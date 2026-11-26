forward
global type w_orafo_quot_met_wz from Window
end type
type em_quotazione from editmask within w_orafo_quot_met_wz
end type
type cb_1 from commandbutton within w_orafo_quot_met_wz
end type
type st_metallo from statictext within w_orafo_quot_met_wz
end type
type st_1 from statictext within w_orafo_quot_met_wz
end type
end forward

global type w_orafo_quot_met_wz from Window
int X=1074
int Y=484
int Width=968
int Height=660
boolean TitleBar=true
string Title="Quotazione Metallo"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
em_quotazione em_quotazione
cb_1 cb_1
st_metallo st_metallo
st_1 st_1
end type
global w_orafo_quot_met_wz w_orafo_quot_met_wz

on w_orafo_quot_met_wz.create
this.em_quotazione=create em_quotazione
this.cb_1=create cb_1
this.st_metallo=create st_metallo
this.st_1=create st_1
this.Control[]={ this.em_quotazione,&
this.cb_1,&
this.st_metallo,&
this.st_1}
end on

on w_orafo_quot_met_wz.destroy
destroy(this.em_quotazione)
destroy(this.cb_1)
destroy(this.st_metallo)
destroy(this.st_1)
end on

event open;decimal ld_quotazione
string ls_metallo

ls_metallo=message.StringParm

select quotazione
into :ld_quotazione
from orafo_metallo
where descrizione=:ls_metallo;

st_metallo.text=ls_metallo
em_quotazione.text=string(ld_quotazione)
end event

type em_quotazione from editmask within w_orafo_quot_met_wz
int X=136
int Y=260
int Width=676
int Height=100
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###.00"
string DisplayData="Ä"
string Text="0"
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_orafo_quot_met_wz
int X=370
int Y=401
int Width=246
int Height=109
int TabOrder=20
string Text="Ok"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
CloseWithReturn(parent,dec(em_quotazione.Text))
end event

type st_metallo from statictext within w_orafo_quot_met_wz
int X=249
int Y=141
int Width=473
int Height=77
boolean Enabled=false
string Text="Oro"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_orafo_quot_met_wz
int X=153
int Y=49
int Width=658
int Height=65
boolean Enabled=false
string Text="Inserire quotazione di: "
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

