forward
global type w_prova_st from Window
end type
type cb_2 from commandbutton within w_prova_st
end type
type cb_1 from commandbutton within w_prova_st
end type
type dw_1 from datawindow within w_prova_st
end type
end forward

global type w_prova_st from Window
int X=823
int Y=360
int Width=3447
int Height=1592
boolean TitleBar=true
string Title="Untitled"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_prova_st w_prova_st

on w_prova_st.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_prova_st.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;datastore ds_prova
ds_prova=create datastore
ds_prova=message.powerobjectparm
ds_prova.settransobject(sqlca)
dw_1.settransobject(sqlca)


dw_1.Object.Data= ds_prova.Object.Data
dw_1.Object.DataWindow.Print.Preview.Buttons = 'Yes'
dw_1.Object.DataWindow.Print.Buttons = 'Yes'

end event

type cb_2 from commandbutton within w_prova_st
int X=562
int Y=1404
int Width=247
int Height=108
int TabOrder=30
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_prova_st
int X=110
int Y=1388
int Width=247
int Height=108
int TabOrder=20
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.object.datawindow.print.preview='yes'
dw_1.object.datawindow.print.preview.rulers='yes'
end event

type dw_1 from datawindow within w_prova_st
int X=9
int Y=28
int Width=3310
int Height=1316
int TabOrder=10
string DataObject="d_stampa_pag_bollato_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

