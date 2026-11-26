forward
global type w_con_lis_articolo_sw from Window
end type
type cb_esci from commandbutton within w_con_lis_articolo_sw
end type
type cb_ok from commandbutton within w_con_lis_articolo_sw
end type
type dw_con_lis_articolo_gd from u_dw_master_main within w_con_lis_articolo_sw
end type
end forward

global type w_con_lis_articolo_sw from Window
int X=233
int Y=200
int Width=3003
int Height=1328
boolean TitleBar=true
string Title="Ricerca Condizioni Di Listino"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
event ue_post_open ( )
cb_esci cb_esci
cb_ok cb_ok
dw_con_lis_articolo_gd dw_con_lis_articolo_gd
end type
global w_con_lis_articolo_sw w_con_lis_articolo_sw

event ue_post_open;string ls_filtro
ls_filtro=message.stringparm

dw_con_lis_articolo_gd.setfilter(ls_filtro)
dw_con_lis_articolo_gd.filter()
dw_con_lis_articolo_gd.retrieve()
end event

event open;
this.event post ue_post_open()
end event

on w_con_lis_articolo_sw.create
this.cb_esci=create cb_esci
this.cb_ok=create cb_ok
this.dw_con_lis_articolo_gd=create dw_con_lis_articolo_gd
this.Control[]={this.cb_esci,&
this.cb_ok,&
this.dw_con_lis_articolo_gd}
end on

on w_con_lis_articolo_sw.destroy
destroy(this.cb_esci)
destroy(this.cb_ok)
destroy(this.dw_con_lis_articolo_gd)
end on

type cb_esci from commandbutton within w_con_lis_articolo_sw
int X=329
int Y=32
int Width=274
int Height=84
int TabOrder=11
string Text="Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(w_con_lis_articolo_sw)
end event

type cb_ok from commandbutton within w_con_lis_articolo_sw
int X=23
int Y=32
int Width=274
int Height=84
int TabOrder=10
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_riga_corrente, ll_id_con_lis_articolo

ll_riga_corrente=dw_con_lis_articolo_gd.getrow()
if ll_riga_corrente >0 then
	ll_id_con_lis_articolo=dw_con_lis_articolo_gd.getitemnumber(ll_riga_corrente, "id_con_lis_articolo")
	closewithreturn(w_con_lis_articolo_sw, ll_id_con_lis_articolo)
else
	messagebox("ERRORE!", "Nessuna riga selezionata")
end if
end event

type dw_con_lis_articolo_gd from u_dw_master_main within w_con_lis_articolo_sw
int X=23
int Y=128
int Width=2953
int Height=1092
int TabOrder=20
string DataObject="d_con_lis_articolo_gd"
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
end type

event constructor;call super::constructor;SetRowFocusIndicator(Hand!)
end event

event doubleclicked;call super::doubleclicked; cb_ok.triggerevent(clicked!)
end event

event sqlpreview;
end event

