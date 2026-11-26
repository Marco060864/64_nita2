forward
global type w_pwd_voci_menu_ff from Window
end type
type cb_annulla from commandbutton within w_pwd_voci_menu_ff
end type
type cb_ok from commandbutton within w_pwd_voci_menu_ff
end type
type st_sle_pwd_t from statictext within w_pwd_voci_menu_ff
end type
type sle_pwd from singlelineedit within w_pwd_voci_menu_ff
end type
end forward

global type w_pwd_voci_menu_ff from Window
int X=833
int Y=361
int Width=1148
int Height=377
boolean TitleBar=true
string Title="Prego inserire la Password"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_annulla cb_annulla
cb_ok cb_ok
st_sle_pwd_t st_sle_pwd_t
sle_pwd sle_pwd
end type
global w_pwd_voci_menu_ff w_pwd_voci_menu_ff

on w_pwd_voci_menu_ff.create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.st_sle_pwd_t=create st_sle_pwd_t
this.sle_pwd=create sle_pwd
this.Control[]={ this.cb_annulla,&
this.cb_ok,&
this.st_sle_pwd_t,&
this.sle_pwd}
end on

on w_pwd_voci_menu_ff.destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.st_sle_pwd_t)
destroy(this.sle_pwd)
end on

type cb_annulla from commandbutton within w_pwd_voci_menu_ff
int X=837
int Y=45
int Width=247
int Height=81
int TabOrder=30
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, "0")
end event

type cb_ok from commandbutton within w_pwd_voci_menu_ff
int X=46
int Y=41
int Width=247
int Height=81
int TabOrder=20
string Text="&OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, sle_pwd.Text)
end event

type st_sle_pwd_t from statictext within w_pwd_voci_menu_ff
int X=69
int Y=161
int Width=252
int Height=77
boolean Enabled=false
string Text="Password:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_pwd from singlelineedit within w_pwd_voci_menu_ff
int X=343
int Y=161
int Width=732
int Height=81
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

