forward
global type w_attesa from Window
end type
type st_1 from statictext within w_attesa
end type
end forward

global type w_attesa from Window
int X=814
int Y=653
int Width=1998
int Height=501
long BackColor=79741120
WindowType WindowType=child!
st_1 st_1
end type
global w_attesa w_attesa

on w_attesa.create
this.st_1=create st_1
this.Control[]={ this.st_1}
end on

on w_attesa.destroy
destroy(this.st_1)
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

type st_1 from statictext within w_attesa
int X=138
int Y=181
int Width=1646
int Height=141
boolean Enabled=false
string Text="ATTENDERE PREGO......"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-20
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

