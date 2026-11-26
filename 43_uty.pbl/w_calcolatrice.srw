forward
global type w_calcolatrice from Window
end type
type cb_tasto_canc from commandbutton within w_calcolatrice
end type
type cb_tasto_virgola from commandbutton within w_calcolatrice
end type
type cb_tasto_uguale from commandbutton within w_calcolatrice
end type
type cb_tasto_divisione from commandbutton within w_calcolatrice
end type
type cb_tasto_moltiplicazione from commandbutton within w_calcolatrice
end type
type cb_tasto_sottrazione from commandbutton within w_calcolatrice
end type
type cb_tasto_somma from commandbutton within w_calcolatrice
end type
type cb_tasto_9 from commandbutton within w_calcolatrice
end type
type cb_tasto_8 from commandbutton within w_calcolatrice
end type
type cb_tasto_7 from commandbutton within w_calcolatrice
end type
type cb_tasto_6 from commandbutton within w_calcolatrice
end type
type cb_tasto_5 from commandbutton within w_calcolatrice
end type
type cb_tasto_4 from commandbutton within w_calcolatrice
end type
type cb_tasto_3 from commandbutton within w_calcolatrice
end type
type cb_tasto_2 from commandbutton within w_calcolatrice
end type
type cb_tasto_1 from commandbutton within w_calcolatrice
end type
type cb_tasto_0 from commandbutton within w_calcolatrice
end type
type st_display from statictext within w_calcolatrice
end type
type r_1 from rectangle within w_calcolatrice
end type
type r_2 from rectangle within w_calcolatrice
end type
type r_3 from rectangle within w_calcolatrice
end type
end forward

global type w_calcolatrice from Window
int X=1075
int Y=483
int Width=1211
int Height=1229
boolean TitleBar=true
string Title="Calcolatrice"
boolean ControlMenu=true
WindowType WindowType=response!
cb_tasto_canc cb_tasto_canc
cb_tasto_virgola cb_tasto_virgola
cb_tasto_uguale cb_tasto_uguale
cb_tasto_divisione cb_tasto_divisione
cb_tasto_moltiplicazione cb_tasto_moltiplicazione
cb_tasto_sottrazione cb_tasto_sottrazione
cb_tasto_somma cb_tasto_somma
cb_tasto_9 cb_tasto_9
cb_tasto_8 cb_tasto_8
cb_tasto_7 cb_tasto_7
cb_tasto_6 cb_tasto_6
cb_tasto_5 cb_tasto_5
cb_tasto_4 cb_tasto_4
cb_tasto_3 cb_tasto_3
cb_tasto_2 cb_tasto_2
cb_tasto_1 cb_tasto_1
cb_tasto_0 cb_tasto_0
st_display st_display
r_1 r_1
r_2 r_2
r_3 r_3
end type
global w_calcolatrice w_calcolatrice

type prototypes

end prototypes

type variables
dec d_operando1,d_operando2
string s_operazione1, s_operazione2
boolean b_cancella, numero_dopo_operatore
end variables

forward prototypes
public subroutine numberpressed (string key)
public subroutine operatorpressed (string as_operator)
public function decimal evaluate (decimal par1, decimal par2, string op)
end prototypes

public subroutine numberpressed (string key);numero_dopo_operatore =true
if b_cancella then
	if key<>"x" then
	st_display.TEXT = KEY
	b_cancella = False
	else
	
	b_cancella = False
	end if

else
	if key<>"x" then
	st_display.TEXT = st_display.TEXT + KEY
	else
	st_display.TEXT = left(st_display.TEXT,len(st_display.TEXT)-1)
	end if
end if

end subroutine

public subroutine operatorpressed (string as_operator);b_cancella=TRUE
if numero_dopo_operatore then
d_operando2=dec(st_display.text)
	dec tmp
 	tmp=evaluate(d_operando1, d_operando2, s_operazione1)
	st_display.text=string(tmp)
	d_operando1=tmp
	setNull(d_operando2) 
	s_operazione1 = as_operator
	numero_dopo_operatore =False

	else
	s_operazione1 = as_operator	
end if
	
end subroutine

public function decimal evaluate (decimal par1, decimal par2, string op);decimal res
CHOOSE CASE op
	CASE "+"
		res = par1 + par2
		CASE "-"
		res = par1 - par2
		CASE "*"
		res = par1 * par2
		CASE "/"
		res = par1 / par2
	CASE ELSE
		messagebox("Error","Operazione non prevista: "+op)
		return 666
END CHOOSE
return res
end function

on w_calcolatrice.create
this.cb_tasto_canc=create cb_tasto_canc
this.cb_tasto_virgola=create cb_tasto_virgola
this.cb_tasto_uguale=create cb_tasto_uguale
this.cb_tasto_divisione=create cb_tasto_divisione
this.cb_tasto_moltiplicazione=create cb_tasto_moltiplicazione
this.cb_tasto_sottrazione=create cb_tasto_sottrazione
this.cb_tasto_somma=create cb_tasto_somma
this.cb_tasto_9=create cb_tasto_9
this.cb_tasto_8=create cb_tasto_8
this.cb_tasto_7=create cb_tasto_7
this.cb_tasto_6=create cb_tasto_6
this.cb_tasto_5=create cb_tasto_5
this.cb_tasto_4=create cb_tasto_4
this.cb_tasto_3=create cb_tasto_3
this.cb_tasto_2=create cb_tasto_2
this.cb_tasto_1=create cb_tasto_1
this.cb_tasto_0=create cb_tasto_0
this.st_display=create st_display
this.r_1=create r_1
this.r_2=create r_2
this.r_3=create r_3
this.Control[]={this.cb_tasto_canc,&
this.cb_tasto_virgola,&
this.cb_tasto_uguale,&
this.cb_tasto_divisione,&
this.cb_tasto_moltiplicazione,&
this.cb_tasto_sottrazione,&
this.cb_tasto_somma,&
this.cb_tasto_9,&
this.cb_tasto_8,&
this.cb_tasto_7,&
this.cb_tasto_6,&
this.cb_tasto_5,&
this.cb_tasto_4,&
this.cb_tasto_3,&
this.cb_tasto_2,&
this.cb_tasto_1,&
this.cb_tasto_0,&
this.st_display,&
this.r_1,&
this.r_2,&
this.r_3}
end on

on w_calcolatrice.destroy
destroy(this.cb_tasto_canc)
destroy(this.cb_tasto_virgola)
destroy(this.cb_tasto_uguale)
destroy(this.cb_tasto_divisione)
destroy(this.cb_tasto_moltiplicazione)
destroy(this.cb_tasto_sottrazione)
destroy(this.cb_tasto_somma)
destroy(this.cb_tasto_9)
destroy(this.cb_tasto_8)
destroy(this.cb_tasto_7)
destroy(this.cb_tasto_6)
destroy(this.cb_tasto_5)
destroy(this.cb_tasto_4)
destroy(this.cb_tasto_3)
destroy(this.cb_tasto_2)
destroy(this.cb_tasto_1)
destroy(this.cb_tasto_0)
destroy(this.st_display)
destroy(this.r_1)
destroy(this.r_2)
destroy(this.r_3)
end on

event open;b_cancella = TRUE
st_display.text=""
d_operando1 = 0
setnull(d_operando2)
s_operazione1="+"
numero_dopo_operatore =False
end event

event key;CHOOSE CASE key
	CASE key0!
		numberpressed("0")
	CASE keynumpad0!
		numberpressed("0")
		
	CASE key1!
		numberpressed("1")
	CASE keynumpad1!
		numberpressed("1")
		
	CASE key2!
		numberpressed("2")
	CASE keynumpad2!
		numberpressed("2")
		
		CASE key3!
		numberpressed("3")
	CASE keynumpad3!
		numberpressed("3")
		
		CASE key4!
		numberpressed("4")
	CASE keynumpad4!
		numberpressed("4")
		
		CASE key5!
		numberpressed("5")
	CASE keynumpad5!
		numberpressed("5")
		
		CASE key6!
		numberpressed("6")
	CASE keynumpad6!
		numberpressed("6")
		
		CASE key7!
		numberpressed("7")
	CASE keynumpad7!
		numberpressed("7")
		
		CASE key8!
		numberpressed("8")
	CASE keynumpad8!
		numberpressed("8")
	
	CASE key9!
		numberpressed("9")
	CASE keynumpad9!
		numberpressed("9")
		
	CASE keydecimal!
	numberpressed(",")  
	
	CASE keyback!
	numberpressed("x") 
	
	CASE keyadd!
	operatorpressed("+")
	CASE keysubtract!
	operatorpressed("-")
	CASE keymultiply!
	operatorpressed("*")
	CASE keydivide!
	operatorpressed("/")
		
	CASE keydelete!
	cb_tasto_canc.triggerEvent(clicked!)
	
	CASE keyEnter!
	cb_tasto_uguale.triggerEvent(clicked!)
END CHOOSE


end event

event close;closeWithReturn(this,st_display.text)
end event

type cb_tasto_canc from commandbutton within w_calcolatrice
int X=922
int Y=918
int Width=128
int Height=109
int TabOrder=40
string Tag="C"
string Text="C"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;b_cancella = TRUE
st_display.text=""
d_operando1 = 0
setnull(d_operando2)
s_operazione1="+"
numero_dopo_operatore =False
end event

type cb_tasto_virgola from commandbutton within w_calcolatrice
int X=165
int Y=918
int Width=110
int Height=109
int TabOrder=160
string Tag=","
string Text=","
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_uguale from commandbutton within w_calcolatrice
int X=918
int Y=426
int Width=128
int Height=438
int TabOrder=150
string Tag="="
string Text="="
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;b_cancella=TRUE
if numero_dopo_operatore then
d_operando2=dec(st_display.text)
	dec tmp
 	tmp=evaluate(d_operando1, d_operando2, s_operazione1)
	st_display.text=string(tmp)
	d_operando1=tmp
	setNull(d_operando2) 

	numero_dopo_operatore =False
	
end if
	
end event

type cb_tasto_divisione from commandbutton within w_calcolatrice
int X=731
int Y=918
int Width=110
int Height=109
int TabOrder=30
string Tag="/"
string Text="/"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;operatorPressed(this.tag)
end event

type cb_tasto_moltiplicazione from commandbutton within w_calcolatrice
int X=731
int Y=758
int Width=110
int Height=109
int TabOrder=60
string Tag="*"
string Text="*"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;operatorPressed(this.tag)
end event

type cb_tasto_sottrazione from commandbutton within w_calcolatrice
int X=731
int Y=589
int Width=110
int Height=109
int TabOrder=110
string Tag="-"
string Text="-"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;operatorPressed(this.tag)
end event

type cb_tasto_somma from commandbutton within w_calcolatrice
int X=731
int Y=426
int Width=110
int Height=109
int TabOrder=140
string Tag="+"
string Text="+"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;operatorPressed(this.tag)
end event

type cb_tasto_9 from commandbutton within w_calcolatrice
int X=512
int Y=426
int Width=110
int Height=109
int TabOrder=90
string Tag="9"
string Text="9"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_8 from commandbutton within w_calcolatrice
int X=336
int Y=426
int Width=110
int Height=109
int TabOrder=80
string Tag="8"
string Text="8"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_7 from commandbutton within w_calcolatrice
int X=165
int Y=426
int Width=110
int Height=109
int TabOrder=70
string Tag="7"
string Text="7"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_6 from commandbutton within w_calcolatrice
int X=512
int Y=589
int Width=110
int Height=109
int TabOrder=100
string Tag="6"
string Text="6"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_5 from commandbutton within w_calcolatrice
int X=336
int Y=589
int Width=110
int Height=109
int TabOrder=50
string Tag="5"
string Text="5"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_4 from commandbutton within w_calcolatrice
int X=165
int Y=589
int Width=110
int Height=109
int TabOrder=120
string Tag="4"
string Text="4"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_3 from commandbutton within w_calcolatrice
int X=512
int Y=758
int Width=110
int Height=109
int TabOrder=20
string Tag="3"
string Text="3"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_2 from commandbutton within w_calcolatrice
int X=336
int Y=758
int Width=110
int Height=109
int TabOrder=130
string Tag="2"
string Text="2"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_1 from commandbutton within w_calcolatrice
int X=165
int Y=758
int Width=110
int Height=109
int TabOrder=10
string Tag="1"
string Text="1"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type cb_tasto_0 from commandbutton within w_calcolatrice
int X=329
int Y=918
int Width=110
int Height=109
int TabOrder=170
string Tag="0"
string Text="0"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;NumberPressed(this.tag)
end event

type st_display from statictext within w_calcolatrice
int X=106
int Y=118
int Width=1002
int Height=93
boolean Enabled=false
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type r_1 from rectangle within w_calcolatrice
int X=18
int Y=10
int Width=1159
int Height=1120
boolean Enabled=false
int LineThickness=10
long LineColor=33554432
long FillColor=8421376
end type

type r_2 from rectangle within w_calcolatrice
int X=62
int Y=86
int Width=1090
int Height=157
boolean Enabled=false
int LineThickness=3
long LineColor=1073741824
long FillColor=8421376
end type

type r_3 from rectangle within w_calcolatrice
int X=62
int Y=317
int Width=1075
int Height=752
boolean Enabled=false
int LineThickness=3
long LineColor=1073741824
long FillColor=8421376
end type

