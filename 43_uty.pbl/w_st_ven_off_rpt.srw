forward
global type w_st_ven_off_rpt from Window
end type
type cb_6 from commandbutton within w_st_ven_off_rpt
end type
type cb_5 from commandbutton within w_st_ven_off_rpt
end type
type cb_4 from commandbutton within w_st_ven_off_rpt
end type
type cb_3 from commandbutton within w_st_ven_off_rpt
end type
type cb_2 from commandbutton within w_st_ven_off_rpt
end type
type cb_1 from commandbutton within w_st_ven_off_rpt
end type
type dw_1 from datawindow within w_st_ven_off_rpt
end type
end forward

global type w_st_ven_off_rpt from Window
int X=1051
int Y=480
int Width=3305
int Height=1796
boolean TitleBar=true
string Title="Sttampa venduto articoli in Offerta"
long BackColor=80133307
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_st_ven_off_rpt w_st_ven_off_rpt

type variables
long il_zoom
date id_da_data, id_a_data, data_stampa
integer anno, mese
end variables

on w_st_ven_off_rpt.create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_st_ven_off_rpt.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;datawindow dw

st_ven_off str

long ll_row, i
str = message.powerobjectparm

dw = str.dw
id_da_data = str.data1
id_a_data  = str.data2
anno = str.anno 
mese = str.mese 
data_stampa = str.data_stampa 

ll_row = dw.rowcount()

dw.RowsCopy(1, ll_row, Primary!, dw_1, 1, Primary!)
FOR i=1 TO ll_row
	dw_1.setitem(i,"data1",id_da_data)
	dw_1.setitem(i,"data2",id_a_data)
	dw_1.setitem(i,"data_stampa",data_stampa) 
NEXT


dw_1.SetSort("articolo_codice A")
dw_1.Sort()

end event

type cb_6 from commandbutton within w_st_ven_off_rpt
int X=2976
int Y=32
int Width=247
int Height=96
int TabOrder=40
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_5 from commandbutton within w_st_ven_off_rpt
int X=2523
int Y=32
int Width=251
int Height=96
int TabOrder=30
string Text="Zoom out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_4 from commandbutton within w_st_ven_off_rpt
int X=2235
int Y=32
int Width=251
int Height=96
int TabOrder=20
string Text="Zoom in"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_3 from commandbutton within w_st_ven_off_rpt
int X=855
int Y=32
int Width=457
int Height=96
int TabOrder=50
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_2 from commandbutton within w_st_ven_off_rpt
int X=366
int Y=32
int Width=457
int Height=96
int TabOrder=60
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_1 from commandbutton within w_st_ven_off_rpt
int X=32
int Y=32
int Width=247
int Height=96
int TabOrder=10
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_st_ven_off_rpt
int X=27
int Y=168
int Width=3195
int Height=1484
int TabOrder=70
string DataObject="ds_ven_off_doc2"
boolean Border=false
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

