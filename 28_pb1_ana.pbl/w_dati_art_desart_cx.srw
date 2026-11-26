forward
global type w_dati_art_desart_cx from Window
end type
type dw_1 from datawindow within w_dati_art_desart_cx
end type
end forward

global type w_dati_art_desart_cx from Window
int X=1051
int Y=480
int Width=2766
int Height=644
boolean TitleBar=true
string Title="Des. Articolo"
long BackColor=80264376
boolean ControlMenu=true
boolean MinBox=true
WindowType WindowType=popup!
dw_1 dw_1
end type
global w_dati_art_desart_cx w_dati_art_desart_cx

on w_dati_art_desart_cx.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_dati_art_desart_cx.destroy
destroy(this.dw_1)
end on

event open;long ll_id_articolo

ll_id_articolo = message.doubleparm


dw_1.settransobject(sqlca)
dw_1.retrieve(ll_id_Articolo)
end event

type dw_1 from datawindow within w_dati_art_desart_cx
int X=32
int Y=28
int Width=2693
int Height=504
int TabOrder=10
string DataObject="d_des_articolo_lista"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

