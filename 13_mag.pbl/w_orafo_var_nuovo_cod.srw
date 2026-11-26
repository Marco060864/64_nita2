forward
global type w_orafo_var_nuovo_cod from Window
end type
type cb_ok from commandbutton within w_orafo_var_nuovo_cod
end type
type st_1 from statictext within w_orafo_var_nuovo_cod
end type
type piu_cod from singlelineedit within w_orafo_var_nuovo_cod
end type
end forward

global type w_orafo_var_nuovo_cod from Window
int X=1056
int Y=484
int Width=1536
int Height=432
boolean TitleBar=true
string Title="Nuovo Codice"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
string Icon="Question!"
cb_ok cb_ok
st_1 st_1
piu_cod piu_cod
end type
global w_orafo_var_nuovo_cod w_orafo_var_nuovo_cod

on w_orafo_var_nuovo_cod.create
this.cb_ok=create cb_ok
this.st_1=create st_1
this.piu_cod=create piu_cod
this.Control[]={this.cb_ok,&
this.st_1,&
this.piu_cod}
end on

on w_orafo_var_nuovo_cod.destroy
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.piu_cod)
end on

type cb_ok from commandbutton within w_orafo_var_nuovo_cod
int X=1216
int Y=216
int Width=233
int Height=76
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_codice
  ls_codice=piu_cod.text
  
  
  
closewithreturn(parent, ls_codice)  
end event

type st_1 from statictext within w_orafo_var_nuovo_cod
int X=82
int Y=116
int Width=1083
int Height=176
boolean Enabled=false
boolean Border=true
string Text="I due caratteri inseriti precedentemente sono già utilizzati per questo articolo, inserisci un nuovo suffisso:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
long BorderColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type piu_cod from singlelineedit within w_orafo_var_nuovo_cod
int X=1216
int Y=120
int Width=229
int Height=84
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=2
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

