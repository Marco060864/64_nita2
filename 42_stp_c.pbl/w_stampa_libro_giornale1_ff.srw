forward
global type w_stampa_libro_giornale1_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_stampa_libro_giornale1_ff
end type
type cb_annulla from commandbutton within w_stampa_libro_giornale1_ff
end type
type dw_1 from u_dw_ext_main within w_stampa_libro_giornale1_ff
end type
type st_1 from statictext within w_stampa_libro_giornale1_ff
end type
end forward

global type w_stampa_libro_giornale1_ff from w_wiz_main
int Width=1564
int Height=885
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Libro Giornale Contabile"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
st_1 st_1
end type
global w_stampa_libro_giornale1_ff w_stampa_libro_giornale1_ff

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

on w_stampa_libro_giornale1_ff.create
int iCurrent
call w_wiz_main::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_ok
this.Control[iCurrent+2]=cb_annulla
this.Control[iCurrent+3]=dw_1
this.Control[iCurrent+4]=st_1
end on

on w_stampa_libro_giornale1_ff.destroy
call w_wiz_main::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;call super::open;



datawindowchild ldw_id_esercizio, ldw_val

dw_1.getchild("id_esercizio",ldw_id_esercizio)
ldw_id_esercizio.settransobject(sqlca)
ldw_id_esercizio.retrieve()

IF dw_1.GetRow() = 0 THEN
	dw_1.InsertRow(0)
END IF

long ll_id_esercizio_proposto
date ld_data_inizio, ld_data_fine

  SELECT "azienda"."id_esercizio_proposto"  
    INTO :ll_id_esercizio_proposto  
    FROM "azienda"  
   WHERE "azienda"."id_azienda" = 1   ;

	  SELECT "esercizio"."data_inizio",   
         "esercizio"."data_fine"  
    INTO :ld_data_inizio,   
         :ld_data_fine  
    FROM "esercizio"  
   WHERE "esercizio"."id_esercizio" = :ll_id_esercizio_proposto   ;

dw_1.setitem(1,"id_esercizio",ll_id_esercizio_proposto)
dw_1.setitem(1,"d_in",string(ld_data_inizio))
dw_1.setitem(1,"d_fin",string(ld_data_fine))
dw_1.setitem(1,"data_c",ld_data_fine)	


	


end event

event closequery;call super::closequery;

end event

type cb_ok from commandbutton within w_stampa_libro_giornale1_ff
event clicked pbm_bnclicked
int X=51
int Y=41
int Width=275
int Height=85
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
string ls_param
ls_param=string(dw_1.getitemdate(1,"data_c"))
openwithparm(w_stampa_libro_giornale_ff,ls_param)

end event

type cb_annulla from commandbutton within w_stampa_libro_giornale1_ff
int X=343
int Y=41
int Width=261
int Height=85
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

type dw_1 from u_dw_ext_main within w_stampa_libro_giornale1_ff
int X=51
int Y=333
int Width=1445
int Height=441
int TabOrder=10
string DataObject="d_libro_giornale1_ff"
end type

event itemchanged;call super::itemchanged;

long ll_id_esercizio_proposto
date ld_data_inizio, ld_data_fine

IF dwo.Name = "id_esercizio" THEN
	
   ll_id_esercizio_proposto=dec(data)
	
	
		  SELECT "esercizio"."data_inizio",   
				"esercizio"."data_fine"  
		 INTO :ld_data_inizio,   
				:ld_data_fine  
		 FROM "esercizio"  
		WHERE "esercizio"."id_esercizio" = :ll_id_esercizio_proposto   ;
	
	
	dw_1.setitem(1,"id_esercizio",ll_id_esercizio_proposto)
	dw_1.setitem(1,"d_in",string(ld_data_inizio))
	dw_1.setitem(1,"d_fin",string(ld_data_fine))
	dw_1.setitem(1,"data_c",ld_data_fine)	
	
END IF
	


end event

type st_1 from statictext within w_stampa_libro_giornale1_ff
int X=46
int Y=157
int Width=1445
int Height=137
boolean Enabled=false
boolean BringToTop=true
string Text="Immettere la data della registrazione contabile dalla quale si desidera stampare il Libro Giornale."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

