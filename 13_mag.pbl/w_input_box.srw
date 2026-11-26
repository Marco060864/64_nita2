forward
global type w_input_box from Window
end type
type cb_1 from commandbutton within w_input_box
end type
type dw_1 from datawindow within w_input_box
end type
end forward

global type w_input_box from Window
int X=5
int Y=32
int Width=850
int Height=404
boolean TitleBar=true
string Title="Legato da scaricare"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
dw_1 dw_1
end type
global w_input_box w_input_box

on w_input_box.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_input_box.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.insertrow(1)
end event

type cb_1 from commandbutton within w_input_box
int X=279
int Y=200
int Width=247
int Height=108
int TabOrder=20
string Text="OK!"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;decimal ld_legato
dw_1.accepttext()
ld_legato=dw_1.getitemdecimal(1, "legato")
closewithreturn(parent, ld_legato)
end event

type dw_1 from datawindow within w_input_box
int X=37
int Y=20
int Width=763
int Height=188
int TabOrder=10
string DataObject="d_input"
boolean Border=false
boolean LiveScroll=true
end type

