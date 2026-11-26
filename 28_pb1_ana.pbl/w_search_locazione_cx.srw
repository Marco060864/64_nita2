forward
global type w_search_locazione_cx from Window
end type
type cb_1 from commandbutton within w_search_locazione_cx
end type
type dw_1 from datawindow within w_search_locazione_cx
end type
end forward

global type w_search_locazione_cx from Window
int X=1051
int Y=480
int Width=2011
int Height=968
boolean TitleBar=true
string Title="Selezione Locazione"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
dw_1 dw_1
end type
global w_search_locazione_cx w_search_locazione_cx

type variables
long ll_id_locazione, ll_row
end variables

on w_search_locazione_cx.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_search_locazione_cx.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.SetTransObject(SQLCA)
dw_1.retrieve()
end event

event close;if ll_row > 0 then
	closewithreturn(this, ll_id_locazione)
else 
	close (this)
end if
end event

type cb_1 from commandbutton within w_search_locazione_cx
int X=41
int Y=36
int Width=247
int Height=100
int TabOrder=10
string Text="&OK"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

ll_row = dw_1.getselectedrow(0)

if ll_row > 0 then
	ll_id_locazione = dw_1.getitemnumber(ll_row, "locazione_id_locazione")
end if
close (parent)
end event

type dw_1 from datawindow within w_search_locazione_cx
int X=37
int Y=192
int Width=1883
int Height=616
int TabOrder=10
string DataObject="d_locazione_lt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;if row>0 then
  dw_1.selectrow(0,false)
  dw_1.selectrow(row,true)
else
	dw_1.selectrow(0,false)
end if
end event

