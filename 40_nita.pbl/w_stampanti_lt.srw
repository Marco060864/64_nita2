forward
global type w_stampanti_lt from Window
end type
type cb_annulla from commandbutton within w_stampanti_lt
end type
type cb_ok from commandbutton within w_stampanti_lt
end type
type dw_1 from datawindow within w_stampanti_lt
end type
end forward

global type w_stampanti_lt from Window
int X=1056
int Y=484
int Width=1765
int Height=864
boolean TitleBar=true
string Title="Stampanti"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_stampanti_lt w_stampanti_lt

on w_stampanti_lt.create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={this.cb_annulla,&
this.cb_ok,&
this.dw_1}
end on

on w_stampanti_lt.destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;string ls_stampanti[], ls_defoult
integer i,row

stampanti str_parametri  


str_parametri=message.powerobjectparm
ls_stampanti[]=str_parametri.stampanti
ls_defoult=str_parametri.defoult


dw_1.settransobject(sqlca)
row=upperbound(ls_stampanti)
if row>1 then
   for i=1 to row
	   dw_1.insertrow(i)
		dw_1.setitem(i,"stampante",ls_stampanti[i])
		if ls_defoult=ls_stampanti[i] then 
			dw_1.setitem(i,"predefinita",'S')
			dw_1.scrolltorow(i)
		end if	
   next	
end if  


if ls_defoult='false' then dw_1.scrolltorow(1)

end event

type cb_annulla from commandbutton within w_stampanti_lt
int X=1486
int Y=128
int Width=206
int Height=84
int TabOrder=20
string Text="Anulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_stampanti_lt
int X=1486
int Y=32
int Width=206
int Height=84
int TabOrder=20
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_selezionata
integer row
row=dw_1.getrow()
ls_selezionata=dw_1.getitemstring(row,"stampante")

CloseWithReturn ( parent, ls_selezionata )
end event

type dw_1 from datawindow within w_stampanti_lt
int Width=1417
int Height=764
int TabOrder=10
string DataObject="d_stampante_lt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
string Icon="Information!"
end type

event rowfocuschanged;dw_1.selectrow(0, false)
dw_1.selectrow(currentrow, true)
end event

event doubleclicked;cb_ok.triggerevent (clicked!)
end event

