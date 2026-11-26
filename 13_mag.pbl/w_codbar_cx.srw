forward
global type w_codbar_cx from Window
end type
type cb_2 from commandbutton within w_codbar_cx
end type
type rte_1 from richtextedit within w_codbar_cx
end type
type cb_1 from commandbutton within w_codbar_cx
end type
type dw_1 from datawindow within w_codbar_cx
end type
end forward

global type w_codbar_cx from Window
int X=836
int Y=372
int Width=2561
int Height=1226
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_2 cb_2
rte_1 rte_1
cb_1 cb_1
dw_1 dw_1
end type
global w_codbar_cx w_codbar_cx

on w_codbar_cx.create
this.cb_2=create cb_2
this.rte_1=create rte_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_2,&
this.rte_1,&
this.cb_1,&
this.dw_1}
end on

on w_codbar_cx.destroy
destroy(this.cb_2)
destroy(this.rte_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_codbar_cx
int X=1416
int Y=554
int Width=246
int Height=106
int TabOrder=4
string Text="<-"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rte_1 from richtextedit within w_codbar_cx
int X=1753
int Y=359
int Width=690
int Height=641
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
end type

on rte_1.create
HScrollBar=true
VScrollBar=true
end on

type cb_1 from commandbutton within w_codbar_cx
int X=1899
int Y=218
int Width=246
int Height=106
int TabOrder=30
string Text="Vai"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
end event

type dw_1 from datawindow within w_codbar_cx
int X=89
int Y=45
int Width=1170
int Height=1021
int TabOrder=20
string DataObject="d_orafo_etich_cartellini_lb"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

