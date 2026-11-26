forward
global type w_st_raffronti_cdc_ff from Window
end type
type cb_7 from commandbutton within w_st_raffronti_cdc_ff
end type
type cb_6 from commandbutton within w_st_raffronti_cdc_ff
end type
type cb_1 from commandbutton within w_st_raffronti_cdc_ff
end type
type cb_5 from commandbutton within w_st_raffronti_cdc_ff
end type
type cb_2 from commandbutton within w_st_raffronti_cdc_ff
end type
type dw_1 from datawindow within w_st_raffronti_cdc_ff
end type
type cb_3 from commandbutton within w_st_raffronti_cdc_ff
end type
type cb_4 from commandbutton within w_st_raffronti_cdc_ff
end type
end forward

global type w_st_raffronti_cdc_ff from Window
int X=5
int Y=4
int Width=2834
int Height=2132
boolean TitleBar=true
string Title="Estratto Conto"
long BackColor=80263581
boolean ControlMenu=true
WindowType WindowType=response!
cb_7 cb_7
cb_6 cb_6
cb_1 cb_1
cb_5 cb_5
cb_2 cb_2
dw_1 dw_1
cb_3 cb_3
cb_4 cb_4
end type
global w_st_raffronti_cdc_ff w_st_raffronti_cdc_ff

type variables
long il_zoom
string is_conto[]
long il_conto[]
integer k
string selezione
end variables

on w_st_raffronti_cdc_ff.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_1=create cb_1
this.cb_5=create cb_5
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_4=create cb_4
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_1,&
this.cb_5,&
this.cb_2,&
this.dw_1,&
this.cb_3,&
this.cb_4}
end on

on w_st_raffronti_cdc_ff.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_1)
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event open;long ll_ret

s_passa_date str_parametri  

str_parametri=message.powerobjectparm




dw_1.settransobject(sqlca)

ll_ret=dw_1.retrieve(str_parametri.da_conto,str_parametri.a_conto)

end event

type cb_7 from commandbutton within w_st_raffronti_cdc_ff
int X=2921
int Y=40
int Width=315
int Height=92
int TabOrder=60
boolean Visible=false
string Text="Salva su file"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type cb_6 from commandbutton within w_st_raffronti_cdc_ff
int X=1819
int Y=40
int Width=238
int Height=92
int TabOrder=50
string Text="Zoom Out"
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

type cb_1 from commandbutton within w_st_raffronti_cdc_ff
int X=1559
int Y=40
int Width=238
int Height=92
int TabOrder=70
string Text="Zoom In"
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

type cb_5 from commandbutton within w_st_raffronti_cdc_ff
int X=18
int Y=36
int Width=247
int Height=92
int TabOrder=80
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

type cb_2 from commandbutton within w_st_raffronti_cdc_ff
int X=2354
int Y=32
int Width=434
int Height=96
int TabOrder=20
string Text="Stampa "
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

type dw_1 from datawindow within w_st_raffronti_cdc_ff
int Y=156
int Width=2793
int Height=1856
int TabOrder=10
string DataObject="d_raffronti_cdc"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event retrievestart;
end event

type cb_3 from commandbutton within w_st_raffronti_cdc_ff
int X=503
int Y=40
int Width=393
int Height=92
int TabOrder=30
boolean BringToTop=true
string Text="Pag Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_st_raffronti_cdc_ff
int X=914
int Y=40
int Width=393
int Height=92
int TabOrder=40
boolean BringToTop=true
string Text="Pag Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 

end event

