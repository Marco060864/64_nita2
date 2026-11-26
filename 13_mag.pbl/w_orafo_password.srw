forward
global type w_orafo_password from Window
end type
type cb_1 from commandbutton within w_orafo_password
end type
type sle_1 from singlelineedit within w_orafo_password
end type
type st_1 from statictext within w_orafo_password
end type
end forward

global type w_orafo_password from Window
int X=1056
int Y=484
int Width=1088
int Height=692
boolean TitleBar=true
string Title="Password"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
sle_1 sle_1
st_1 st_1
end type
global w_orafo_password w_orafo_password

type variables

end variables

on w_orafo_password.create
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_1=create st_1
this.Control[]={this.cb_1,&
this.sle_1,&
this.st_1}
end on

on w_orafo_password.destroy
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_1)
end on

type cb_1 from commandbutton within w_orafo_password
int X=393
int Y=404
int Width=247
int Height=108
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if sle_1.text="Cometa" then
	 CloseWithReturn(w_orafo_password, "OK")
else	
	 CloseWithReturn(w_orafo_password , "NO")
end if

end event

type sle_1 from singlelineedit within w_orafo_password
int X=224
int Y=228
int Width=594
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_orafo_password
int X=274
int Y=72
int Width=576
int Height=76
boolean Enabled=false
string Text="Inserisci la password:"
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

