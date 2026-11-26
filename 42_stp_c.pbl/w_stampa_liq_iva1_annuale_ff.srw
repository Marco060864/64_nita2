forward
global type w_stampa_liq_iva1_annuale_ff from Window
end type
type cb_7 from commandbutton within w_stampa_liq_iva1_annuale_ff
end type
type cb_6 from commandbutton within w_stampa_liq_iva1_annuale_ff
end type
type cb_5 from commandbutton within w_stampa_liq_iva1_annuale_ff
end type
type cb_4 from commandbutton within w_stampa_liq_iva1_annuale_ff
end type
type dw_1 from datawindow within w_stampa_liq_iva1_annuale_ff
end type
type cb_3 from commandbutton within w_stampa_liq_iva1_annuale_ff
end type
type cb_1 from commandbutton within w_stampa_liq_iva1_annuale_ff
end type
end forward

global type w_stampa_liq_iva1_annuale_ff from Window
int X=5
int Y=48
int Width=3657
int Height=2388
boolean TitleBar=true
string Title="Liquidazione IVA"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stampa_liq_iva1_annuale_ff w_stampa_liq_iva1_annuale_ff

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272


end event

event open;


s_param1 ls_param
ls_param=Message.PowerObjectParm	

date ld_data_in,ld_data_fin
long ll_id_esercizio,ll_id_attivita
decimal ld_acconto
string ls_flag 

ll_id_esercizio=ls_param.id_esercizio
ll_id_attivita=ls_param.id_attivita
ld_data_in=ls_param.data_in
ld_data_fin=ls_param.data_fin
ld_acconto=ls_param.acconto
ls_flag=ls_param.flag

close(w_attesa)

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_flag,ll_id_esercizio,ll_id_attivita,ld_data_in,ld_data_fin)
il_zoom=100

decimal ld_perc_prorata
select perc_prorata
  into :ld_perc_prorata
  from registro
 where id_attivita=:ll_id_attivita and 
       id_esercizio=:ll_id_esercizio and
		 tipo_registro='IA';

date ld_ultima_liq
decimal ld_credito_inizio_anno
SELECT CREDITO_INIZIO_ANNO 
  INTO :ld_credito_inizio_anno
  FROM RIEP_IVA;
 
if isnull(ld_credito_inizio_anno) then
	ld_credito_inizio_anno=0
end if



long ll_righe, i

ll_righe=dw_1.rowcount()
FOR i=1 TO ll_righe
    dw_1.setitem(i,"cacconto",ld_acconto)
	 dw_1.setitem(i,"cper_prorata",ld_perc_prorata)
	 dw_1.setitem(i,"cult_iva_credito",ld_credito_inizio_anno)
	 dw_1.setitem(i,"cdata_inizio",ld_data_in)
	 dw_1.setitem(i,"cdata_fine",ld_data_fin)
NEXT


end event

on w_stampa_liq_iva1_annuale_ff.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stampa_liq_iva1_annuale_ff.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type cb_7 from commandbutton within w_stampa_liq_iva1_annuale_ff
event clicked pbm_bnclicked
int X=2505
int Y=40
int Width=261
int Height=84
int TabOrder=30
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_stampa_liq_iva1_annuale_ff
event clicked pbm_bnclicked
int X=2231
int Y=40
int Width=261
int Height=84
int TabOrder=40
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_liq_iva1_annuale_ff
int X=681
int Y=40
int Width=466
int Height=84
int TabOrder=50
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_liq_iva1_annuale_ff
int X=1161
int Y=40
int Width=466
int Height=84
int TabOrder=20
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_stampa_liq_iva1_annuale_ff
int X=27
int Y=144
int Width=3611
int Height=2144
int TabOrder=60
string DataObject="d_liq_iva_annuale"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_stampa_liq_iva1_annuale_ff
int X=3387
int Y=40
int Width=247
int Height=84
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()



s_liq_iva ls_liq_iva
decimal ld_interessi, ld_differenza,ld_totale_d,ld_totale_c, ld_plafond_diff, ld_per_prorata

ld_plafond_diff=dw_1.getitemnumber(1,"plafond_diff")
ls_liq_iva.plafond_diff=ld_plafond_diff

ld_interessi=dw_1.getitemnumber(1,"interessi")
ls_liq_iva.interessi=ld_interessi

ld_differenza=dw_1.getitemnumber(1,"differenza")

ld_totale_d=dw_1.getitemnumber(1,"totale_d")
ld_totale_c=dw_1.getitemnumber(1,"totale_c")

if ld_totale_d>ld_totale_c then
   	ls_liq_iva.iva_debito=ld_differenza
        else
			ls_liq_iva.iva_credito=ld_differenza
end if

ld_per_prorata=dw_1.getitemnumber(1,"cper_prorata")
ls_liq_iva.per_prorata=ld_per_prorata

closewithreturn(parent,ls_liq_iva)
end event

type cb_1 from commandbutton within w_stampa_liq_iva1_annuale_ff
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=70
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

