forward
global type w_ordina_scorta_cx from Window
end type
type cb_piu from commandbutton within w_ordina_scorta_cx
end type
type cb_3 from commandbutton within w_ordina_scorta_cx
end type
type st_1 from statictext within w_ordina_scorta_cx
end type
type cb_des from commandbutton within w_ordina_scorta_cx
end type
type cb_1 from commandbutton within w_ordina_scorta_cx
end type
type dw_1 from datawindow within w_ordina_scorta_cx
end type
end forward

global type w_ordina_scorta_cx from Window
int X=1056
int Y=484
int Width=3273
int Height=1516
boolean TitleBar=true
string Title="Ordine del sottoscorta"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_piu cb_piu
cb_3 cb_3
st_1 st_1
cb_des cb_des
cb_1 cb_1
dw_1 dw_1
end type
global w_ordina_scorta_cx w_ordina_scorta_cx

on w_ordina_scorta_cx.create
this.cb_piu=create cb_piu
this.cb_3=create cb_3
this.st_1=create st_1
this.cb_des=create cb_des
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_piu,&
this.cb_3,&
this.st_1,&
this.cb_des,&
this.cb_1,&
this.dw_1}
end on

on w_ordina_scorta_cx.destroy
destroy(this.cb_piu)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.cb_des)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;datawindow ldw_balcone
long ll_row
integer li_ret

dw_1.settransobject(sqlca)

ldw_balcone=Message.PowerObjectParm
ll_row=ldw_balcone.rowcount()
if ll_row>0 then
  li_ret=ldw_balcone.RowsCopy(1,ll_row,Primary!,dw_1,1,Primary!)
end if
end event

type cb_piu from commandbutton within w_ordina_scorta_cx
int X=3077
int Y=296
int Width=91
int Height=64
int TabOrder=30
string Text="+"
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_ordina_scorta_cx
int X=3077
int Y=232
int Width=91
int Height=64
int TabOrder=30
string Text="-"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_ordina_scorta_cx
int X=2789
int Y=252
int Width=293
int Height=104
boolean Enabled=false
string Text="varia qta selezionati"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_des from commandbutton within w_ordina_scorta_cx
int X=2313
int Y=44
int Width=407
int Height=108
int TabOrder=20
string Text="Deseleziona tutti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SelectRow ( 0, false )


end event

type cb_1 from commandbutton within w_ordina_scorta_cx
int X=2775
int Y=44
int Width=352
int Height=108
int TabOrder=10
string Text="Seleziona tutti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SelectRow ( 0, true )
end event

type dw_1 from datawindow within w_ordina_scorta_cx
int X=50
int Y=364
int Width=3122
int Height=872
int TabOrder=40
string DataObject="d_ordina_scorta_tab"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event rowfocuschanging;dw_1.SelectRow ( currentrow, false )
dw_1.SelectRow ( newrow, true )

end event

event clicked;messagebox('',row)
end event

