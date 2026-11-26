forward
global type w_wizard_pwd_ff from w_wiz_main
end type
type sle_pwd from singlelineedit within w_wizard_pwd_ff
end type
type cb_1 from commandbutton within w_wizard_pwd_ff
end type
type st_1 from statictext within w_wizard_pwd_ff
end type
end forward

type str_pwd from structure
	string		s_pwd
end type

global type w_wizard_pwd_ff from w_wiz_main
int X=833
int Y=361
int Width=1335
int Height=593
boolean TitleBar=true
string Title="Wizard"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
sle_pwd sle_pwd
cb_1 cb_1
st_1 st_1
end type
global w_wizard_pwd_ff w_wizard_pwd_ff

type variables

end variables

on w_wizard_pwd_ff.create
this.sle_pwd=create sle_pwd
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={ this.sle_pwd,&
this.cb_1,&
this.st_1}
end on

on w_wizard_pwd_ff.destroy
destroy(this.sle_pwd)
destroy(this.cb_1)
destroy(this.st_1)
end on

type sle_pwd from singlelineedit within w_wizard_pwd_ff
int X=503
int Y=221
int Width=385
int Height=93
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean PassWord=true
int Limit=15
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_wizard_pwd_ff
int X=572
int Y=361
int Width=247
int Height=89
int TabOrder=20
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;s_any_array lstr_any_array
lstr_any_array.s_array[1] = sle_pwd.Text
Message.PowerObjectParm = lstr_any_array
CloseWithReturn(Parent, lstr_any_array)
end event

type st_1 from statictext within w_wizard_pwd_ff
int X=46
int Y=41
int Width=1253
int Height=137
boolean Enabled=false
string Text="ATTENZIONE: La finestra dei wizard è ad uso esclusivo del personale dell'assistenza tecnica."
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

