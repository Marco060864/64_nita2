forward
global type w_orafo_help from w_001
end type
type dw_1 from datawindow within w_orafo_help
end type
type cb_1 from commandbutton within w_orafo_help
end type
end forward

global type w_orafo_help from w_001
WindowType WindowType=response!
dw_1 dw_1
cb_1 cb_1
end type
global w_orafo_help w_orafo_help

on w_orafo_help.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_orafo_help.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;string ls_oggetto
integer li_ret
ls_oggetto=message.stringparm
dw_1.settransobject(sqlca)
li_ret=dw_1.retrieve(ls_oggetto)
if li_ret<=0 then
	dw_1.setitem(1, "oggetto", ls_oggetto)
end if
end event

type dw_1 from datawindow within w_orafo_help
int X=32
int Y=120
int Width=2482
int Height=1292
int TabOrder=10
boolean BringToTop=true
string DataObject="d_orafo_help"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_orafo_help
int X=37
int Y=8
int Width=247
int Height=108
int TabOrder=10
boolean BringToTop=true
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
if dw_1.update()<>1 then
	messagebox("W","Salvataggio non riuscito")
end if
end event

