forward
global type w_stampa_man_bilancio_sm_gd from Window
end type
type cb_7 from commandbutton within w_stampa_man_bilancio_sm_gd
end type
type cb_6 from commandbutton within w_stampa_man_bilancio_sm_gd
end type
type cb_5 from commandbutton within w_stampa_man_bilancio_sm_gd
end type
type cb_4 from commandbutton within w_stampa_man_bilancio_sm_gd
end type
type dw_1 from datawindow within w_stampa_man_bilancio_sm_gd
end type
type cb_3 from commandbutton within w_stampa_man_bilancio_sm_gd
end type
type cb_1 from commandbutton within w_stampa_man_bilancio_sm_gd
end type
end forward

global type w_stampa_man_bilancio_sm_gd from Window
int X=5
int Y=348
int Width=3657
int Height=1536
boolean TitleBar=true
string Title="Stampa Bilancio"
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
global w_stampa_man_bilancio_sm_gd w_stampa_man_bilancio_sm_gd

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272

integer i
decimal ld_dec_significativi

s_param ls_param
ls_param=Message.PowerObjectParm
ld_dec_significativi=ls_param.dec_significativi

string ls_formato,ls_dec
if ld_dec_significativi=0 then
   ls_formato="#,0"
   else
	ls_formato="#,0."
end if

ls_dec="0"
for i=1 to ld_dec_significativi 
    ls_formato=ls_formato+ls_dec
next
dw_1.object.fronte.object.as.object.campo.format=ls_formato
dw_1.object.fronte.object.as.object.tot_mastro.format=ls_formato
dw_1.object.fronte.object.as.object.dare.format=ls_formato
dw_1.object.fronte.object.ad.object.campo.format=ls_formato
dw_1.object.fronte.object.ad.object.avere.format=ls_formato
dw_1.object.fronte.object.ad.object.tot_mastro.format=ls_formato

dw_1.object.b.object.bs.object.campo.format=ls_formato
dw_1.object.b.object.bs.object.tot_mastro.format=ls_formato
dw_1.object.b.object.bs.object.dare.format=ls_formato
dw_1.object.b.object.bd.object.campo.format=ls_formato
dw_1.object.b.object.bd.object.avere.format=ls_formato
dw_1.object.b.object.bd.object.tot_mastro.format=ls_formato


dw_1.object.c.object.c1.object.compute_0001.format=ls_formato
dw_1.object.c.object.c1.object.compute_0002.format=ls_formato
dw_1.object.c.object.c1.object.campo.format=ls_formato
dw_1.object.c.object.c1.object.perdita.format=ls_formato
dw_1.object.c.object.c1.object.ricavo.format=ls_formato
dw_1.object.c.object.c1.object.PAR1.format=ls_formato
dw_1.object.c.object.c1.object.PAR2.format=ls_formato


dw_1.object.d.object.d1.object.compute_0001.format=ls_formato
dw_1.object.d.object.d1.object.compute_0002.format=ls_formato
dw_1.object.d.object.d1.object.campo.format=ls_formato
dw_1.object.d.object.d1.object.utile.format=ls_formato
dw_1.object.d.object.d1.object.perdita.format=ls_formato
dw_1.object.d.object.d1.object.PAR3.format=ls_formato
dw_1.object.d.object.d1.object.PAR4.format=ls_formato





end event

event open;close(w_attesa)

decimal ld_cambio,ld_dec_significativi
long ll_id_azienda, ll_cod_esercizio
date ld_data_in, ld_data_fin

s_param ls_param
ls_param=Message.PowerObjectParm
ld_cambio=ls_param.cambio
ld_dec_significativi=ls_param.dec_significativi
ll_id_azienda=ls_param.id_azienda
ll_cod_esercizio=ls_param.cod_esercizio
ld_data_in=ls_param.data_in
ld_data_fin=ls_param.data_fin



dw_1.settransobject(sqlca)
dw_1.retrieve(ld_cambio,ll_id_azienda,ll_cod_esercizio,ld_data_in,ld_data_fin)
il_zoom=100
this.event post ue_post_open()
end event

on w_stampa_man_bilancio_sm_gd.create
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

on w_stampa_man_bilancio_sm_gd.destroy
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

type cb_7 from commandbutton within w_stampa_man_bilancio_sm_gd
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

type cb_6 from commandbutton within w_stampa_man_bilancio_sm_gd
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

type cb_5 from commandbutton within w_stampa_man_bilancio_sm_gd
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

type cb_4 from commandbutton within w_stampa_man_bilancio_sm_gd
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

type dw_1 from datawindow within w_stampa_man_bilancio_sm_gd
int X=27
int Y=136
int Width=3611
int Height=1260
int TabOrder=60
string DataObject="d_stampa_bilancio_sm"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_stampa_man_bilancio_sm_gd
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
end event

type cb_1 from commandbutton within w_stampa_man_bilancio_sm_gd
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

