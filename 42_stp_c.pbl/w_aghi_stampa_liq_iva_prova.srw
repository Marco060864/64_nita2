forward
global type w_aghi_stampa_liq_iva_prova from w_wiz_main
end type
type cb_ok from commandbutton within w_aghi_stampa_liq_iva_prova
end type
type cb_annulla from commandbutton within w_aghi_stampa_liq_iva_prova
end type
type st_1 from statictext within w_aghi_stampa_liq_iva_prova
end type
type dw_1 from u_dw_ext_main within w_aghi_stampa_liq_iva_prova
end type
end forward

global type w_aghi_stampa_liq_iva_prova from w_wiz_main
int Width=1545
int Height=884
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Liquidazione Iva"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
st_1 st_1
dw_1 dw_1
end type
global w_aghi_stampa_liq_iva_prova w_aghi_stampa_liq_iva_prova

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE
end variables

forward prototypes
public subroutine uf_feed_struct (boolean ab_feed)
public function boolean uf_controlla_data (date ad_data_registrazione)
end prototypes

public subroutine uf_feed_struct (boolean ab_feed);
end subroutine

public function boolean uf_controlla_data (date ad_data_registrazione);

long ll_id_esercizio
boolean lb_RetVal = FALSE

SELECT esercizio.id_esercizio
	INTO :ll_id_esercizio
	FROM dba.esercizio
	WHERE (esercizio.data_inizio <= :ad_data_registrazione) AND
			(esercizio.data_fine >= :ad_data_registrazione)
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		lb_RetVal = TRUE
END CHOOSE

RETURN lb_RetVal
end function

on w_aghi_stampa_liq_iva_prova.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_aghi_stampa_liq_iva_prova.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;call super::open;



datawindowchild ldw_id_esercizio, ldw_val, ldw_id_attivita

dw_1.getchild("id_esercizio",ldw_id_esercizio)
ldw_id_esercizio.settransobject(sqlca)
ldw_id_esercizio.retrieve()



dw_1.getchild("id_attivita",ldw_id_attivita)
ldw_id_attivita.settransobject(sqlca)
ldw_id_attivita.retrieve()

IF dw_1.GetRow() = 0 THEN
	dw_1.InsertRow(0)
END IF

long ll_id_esercizio_proposto, ll_id_attivita
date ld_data_inizio, ld_data_fine

  SELECT "azienda"."id_esercizio_proposto", "azienda"."id_attivita"
    INTO :ll_id_esercizio_proposto , :ll_id_attivita 
    FROM "azienda"  
   WHERE "azienda"."id_azienda" = 1   ;

	  SELECT "esercizio"."data_inizio",   
         "esercizio"."data_fine"  
    INTO :ld_data_inizio,   
         :ld_data_fine  
    FROM "esercizio"  
   WHERE "esercizio"."id_esercizio" = :ll_id_esercizio_proposto   ;

dw_1.setitem(1,"id_esercizio",ll_id_esercizio_proposto)
dw_1.setitem(1,"d_in",ld_data_inizio)
dw_1.setitem(1,"d_fin",ld_data_fine)
dw_1.setitem(1,"data_c",ld_data_fine)	
dw_1.setitem(1, "id_attivita", ll_id_attivita)


	


end event

event closequery;call super::closequery;

end event

type cb_ok from commandbutton within w_aghi_stampa_liq_iva_prova
event clicked pbm_bnclicked
int X=50
int Y=40
int Width=274
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string			ls_data_inizio, ls_data_fine,ls_title
string			ls_doc_stampato, ls_stampato
boolean			lb_definit, lb_can_go
long				ll_row, ll_id_esercizio
string			ls_nome_report, ls_dir, ls_selection_formula
window			lw_win
long				ll_retv, ll_sqlcode, ll_sqlrows, ll_id_attivita
integer			li_outdev, li_stampa_ok
integer 			li_retvalue
boolean			lb_iva_ok, lb_cpt_ok
date           ld_data_inizio, ld_data_fine

lb_can_go=true
	ls_nome_report="liquidazione_iva.rpt"
	OpenWithParm(lw_win,ls_nome_report,"w_st_prov_def_wz")
	ll_retv = Message.DoubleParm
	CHOOSE CASE ll_retv
		CASE 0							
			li_outdev = 1
		CASE 1							
			li_outdev = 1
			lb_definit = true
			
		CASE 2							
			li_outdev = 2
		CASE 3							
			li_outdev = 2
			lb_definit = true
			
		CASE -1							
			lb_can_go = false
		CASE ELSE						
			lb_can_go = false
	END CHOOSE

ld_data_inizio=dw_1.getitemdate(1,"d_in")

ld_data_fine=dw_1.getitemdate(1,"d_fin")

ll_id_esercizio=dw_1.getitemnumber(1, "id_esercizio")
ls_title="Stampa Liquidazione IVA"

ll_id_attivita=dw_1.getitemnumber(1, "id_attivita")

ls_selection_formula="{reg_pd.data_registrazione} >= Date (" +string(ld_data_inizio, "yyyy,mm,dd") + ")"+&
"and {reg_pd.data_registrazione} <= Date (" +string(ld_data_fine, "yyyy,mm,dd") + ")"+ &
" and {azienda.id_esercizio}= "+ string(ll_id_esercizio) + " and {azienda.id_attivita}= "+string(ll_id_attivita)

select "par_sistema"."dir_report" into :ls_dir
		from "dba"."par_sistema"
		where "par_sistema"."id_azienda" = 1
		using SQLCA;


if lb_can_go then
//	u_freddie.iuo_stampa.istr_formula[1].formula_name='da_data'
//	u_freddie.iuo_stampa.istr_formula[1].formula_string="'"+string(ld_data_inizio, "yyyy,mm,dd")+"'"
//	u_freddie.iuo_stampa.istr_formula[2].formula_name='a_data'
//	u_freddie.iuo_stampa.istr_formula[2].formula_string="'"+string(ld_data_fine, "yyyy,mm,dd")+"'"
//	u_freddie.iuo_stampa.of_set_selection_formula(ls_selection_formula) 
//	u_freddie.iuo_stampa.of_set_Title(ls_title) 
//	u_freddie.iuo_stampa.of_set_view(u_freddie.iuo_stampa.MAXIMIZE_VIEW)
	
//	li_stampa_ok = u_freddie.iuo_stampa.of_stampa(0, li_outdev, 0, 0, 1,ls_dir, ls_nome_report)
end if	

end event

type cb_annulla from commandbutton within w_aghi_stampa_liq_iva_prova
int X=343
int Y=40
int Width=261
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type st_1 from statictext within w_aghi_stampa_liq_iva_prova
int X=55
int Y=228
int Width=1449
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Immettere i dati di selezione per il periodo da liquidare"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from u_dw_ext_main within w_aghi_stampa_liq_iva_prova
int X=55
int Y=328
int Width=1445
int Height=440
int TabOrder=10
boolean BringToTop=true
string DataObject="d_liq_iva_marco_ff"
end type

