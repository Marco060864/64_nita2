forward
global type w_ini_creation from Window
end type
type cb_ok from commandbutton within w_ini_creation
end type
type st_1 from statictext within w_ini_creation
end type
type sle_name from singlelineedit within w_ini_creation
end type
end forward

global type w_ini_creation from Window
int X=1056
int Y=484
int Width=1467
int Height=668
boolean TitleBar=true
string Title="Configurazione Database "
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_ok cb_ok
st_1 st_1
sle_name sle_name
end type
global w_ini_creation w_ini_creation

type variables
string returnValue
end variables

event open;returnValue =""
end event

event close;CloseWithReturn ( this, returnvalue )
end event

on w_ini_creation.create
this.cb_ok=create cb_ok
this.st_1=create st_1
this.sle_name=create sle_name
this.Control[]={this.cb_ok,&
this.st_1,&
this.sle_name}
end on

on w_ini_creation.destroy
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.sle_name)
end on

type cb_ok from commandbutton within w_ini_creation
int X=558
int Y=404
int Width=293
int Height=108
int TabOrder=20
string Text="Connetti"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if fileExists(message.stringParm) then
	if not(fileDelete(message.stringParm)) then
		MessageBox("Alert","Impossibile cancellare " + message.stringParm + "~rControllare che il file non sia in uso o protetto")
		returnValue = ""
	end if
end if

// se il file non esiste viene creato

integer li_FileNum

li_FileNum = FileOpen(message.stringParm, StreamMode!, Write!)
integer il_res
string sl_INI_text
sl_INI_text = "[Database]~r~nNome = "+sle_name.text+"~r~n"
il_res = FileWrite(li_FileNum, sl_INI_text)
if il_res=-1 then
	MessageBox("Alert","Errore nella scrittura")
	returnValue = ""
end if

il_res = FileClose(li_FileNum)
if il_res=-1 then
	MessageBox("Alert","Errore nella chiusura del file")
	returnValue = ""
end if

returnValue = sle_name.text
w_ini_creation.triggerevent(Close!)
end event

type st_1 from statictext within w_ini_creation
int X=82
int Y=92
int Width=1294
int Height=76
boolean Enabled=false
string Text="Inserire il nome del database al quale ci si vuole collegare:"
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

type sle_name from singlelineedit within w_ini_creation
int X=306
int Y=232
int Width=832
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

