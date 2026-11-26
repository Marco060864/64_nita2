forward
global type w_ordini_conf_cli_cx from Window
end type
type cb_7 from commandbutton within w_ordini_conf_cli_cx
end type
type cb_6 from commandbutton within w_ordini_conf_cli_cx
end type
type cb_5 from commandbutton within w_ordini_conf_cli_cx
end type
type cb_4 from commandbutton within w_ordini_conf_cli_cx
end type
type cb_2 from commandbutton within w_ordini_conf_cli_cx
end type
type dw_1 from datawindow within w_ordini_conf_cli_cx
end type
type cb_3 from commandbutton within w_ordini_conf_cli_cx
end type
type cb_1 from commandbutton within w_ordini_conf_cli_cx
end type
end forward

global type w_ordini_conf_cli_cx from Window
int X=9
int Y=236
int Width=3291
int Height=1644
boolean TitleBar=true
string Title="Stampa Conferma d'ordine"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_2 cb_2
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_ordini_conf_cli_cx w_ordini_conf_cli_cx

type variables
long il_zoom
end variables

event open;datastore ds_temp

ds_temp=message.powerobjectparm
if IsValid(ds_temp) then
	dw_1.object.data = ds_temp.object.data
end if

il_zoom=100
end event

on w_ordini_conf_cli_cx.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_2,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_ordini_conf_cli_cx.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_2)
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

type cb_7 from commandbutton within w_ordini_conf_cli_cx
event clicked pbm_bnclicked
int X=1998
int Y=44
int Width=261
int Height=88
int TabOrder=23
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

type cb_6 from commandbutton within w_ordini_conf_cli_cx
event clicked pbm_bnclicked
int X=1723
int Y=44
int Width=261
int Height=88
int TabOrder=30
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

type cb_5 from commandbutton within w_ordini_conf_cli_cx
int X=818
int Y=44
int Width=466
int Height=88
int TabOrder=40
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_ordini_conf_cli_cx
int X=315
int Y=44
int Width=466
int Height=88
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

type cb_2 from commandbutton within w_ordini_conf_cli_cx
int X=2409
int Y=44
int Width=247
int Height=88
int TabOrder=50
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if cb_2.text='Preview' then
	dw_1.object.datawindow.print.preview='yes'
	cb_2.text='Ritorna'
else
	dw_1.object.datawindow.print.preview='no'
	cb_2.text='Preview'
end if
end event

type dw_1 from datawindow within w_ordini_conf_cli_cx
int X=32
int Y=160
int Width=3227
int Height=1356
int TabOrder=60
string DataObject="d_conferma_cliente_ff"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_ordini_conf_cli_cx
int X=2688
int Y=44
int Width=247
int Height=88
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if dw_1.accepttext()<>1 then 
	messagebox('Errore!','Impossibile stampare!')
	return
end if

printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_ordini_conf_cli_cx
int X=23
int Y=44
int Width=247
int Height=88
int TabOrder=70
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

