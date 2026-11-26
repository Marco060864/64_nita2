forward
global type w_vedi_residuo from Window
end type
type st_1 from statictext within w_vedi_residuo
end type
type cb_aggiorna from commandbutton within w_vedi_residuo
end type
type dw_1 from datawindow within w_vedi_residuo
end type
end forward

global type w_vedi_residuo from Window
int X=1056
int Y=484
int Width=1701
int Height=1212
boolean TitleBar=true
string Title="RESIDUO PARTITE"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
WindowType WindowType=popup!
st_1 st_1
cb_aggiorna cb_aggiorna
dw_1 dw_1
end type
global w_vedi_residuo w_vedi_residuo

type variables
long il_id_sog
end variables

on w_vedi_residuo.create
this.st_1=create st_1
this.cb_aggiorna=create cb_aggiorna
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_aggiorna,&
this.dw_1}
end on

on w_vedi_residuo.destroy
destroy(this.st_1)
destroy(this.cb_aggiorna)
destroy(this.dw_1)
end on

event open;integer li_ret
dw_1.settransobject(sqlca)
s_vedi_residuo lst_vedi_residuo

lst_vedi_residuo=message.powerobjectparm
il_id_sog=lst_vedi_residuo.ll_id_sog
li_ret=dw_1.retrieve(il_id_sog,il_id_sog)
if li_ret<1 or isnull(li_ret) then close(this)
ST_1.TEXT="Partite Disponibili: " +string(li_ret)
end event

event key;IF keyflags=3 AND KEY=KEYF12! THEN
	MESSAGEBOX("CLASSNAME", "W_VEDI_RESIDUO")
END IF
end event

type st_1 from statictext within w_vedi_residuo
int X=434
int Y=1216
int Width=1198
int Height=76
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_aggiorna from commandbutton within w_vedi_residuo
int X=46
int Y=992
int Width=279
int Height=108
int TabOrder=20
string Text="Aggiorna"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret
li_ret=dw_1.retrieve(il_id_sog,il_id_sog)

ST_1.TEXT="Partite Disponibili: " +string(li_ret)

end event

type dw_1 from datawindow within w_vedi_residuo
int X=32
int Y=28
int Width=1627
int Height=932
int TabOrder=10
string DataObject="d_vedi_residuo"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

