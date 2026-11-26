forward
global type w_wizard_pwd_contatori_ff from w_wiz_main
end type
type sle_pwd from singlelineedit within w_wizard_pwd_contatori_ff
end type
type cb_1 from commandbutton within w_wizard_pwd_contatori_ff
end type
type st_1 from statictext within w_wizard_pwd_contatori_ff
end type
end forward

type str_pwd from structure
	string		s_pwd
end type

global type w_wizard_pwd_contatori_ff from w_wiz_main
int X=832
int Y=360
int Width=1266
int Height=592
WindowType WindowType=response!
boolean TitleBar=true
string Title="Wizard"
sle_pwd sle_pwd
cb_1 cb_1
st_1 st_1
end type
global w_wizard_pwd_contatori_ff w_wizard_pwd_contatori_ff

type variables

end variables

on w_wizard_pwd_contatori_ff.create
int iCurrent
call super::create
this.sle_pwd=create sle_pwd
this.cb_1=create cb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_pwd
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
end on

on w_wizard_pwd_contatori_ff.destroy
call super::destroy
destroy(this.sle_pwd)
destroy(this.cb_1)
destroy(this.st_1)
end on

type sle_pwd from singlelineedit within w_wizard_pwd_contatori_ff
int X=425
int Y=244
int Width=384
int Height=92
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

type cb_1 from commandbutton within w_wizard_pwd_contatori_ff
int X=498
int Y=360
int Width=247
int Height=88
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

type st_1 from statictext within w_wizard_pwd_contatori_ff
int X=46
int Y=40
int Width=1129
int Height=188
boolean Enabled=false
string Text="ATTENZIONE: Le modifiche apportate possono alterare la coerenza dei dati. Inserire la password per continuare."
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

