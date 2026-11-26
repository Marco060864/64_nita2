forward
global type w_stampa_dichiarazione_rpt from Window
end type
type cb_5 from commandbutton within w_stampa_dichiarazione_rpt
end type
type cb_4 from commandbutton within w_stampa_dichiarazione_rpt
end type
type cb_3 from commandbutton within w_stampa_dichiarazione_rpt
end type
type cb_2 from commandbutton within w_stampa_dichiarazione_rpt
end type
type cb_1 from commandbutton within w_stampa_dichiarazione_rpt
end type
type dw_1 from datawindow within w_stampa_dichiarazione_rpt
end type
end forward

global type w_stampa_dichiarazione_rpt from Window
int X=9
int Y=48
int Width=3717
int Height=2280
boolean TitleBar=true
string Title="Stampa Dichiarazione Periodica IVA"
long BackColor=78682240
boolean ControlMenu=true
WindowType WindowType=response!
event ue_post_open ( )
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_stampa_dichiarazione_rpt w_stampa_dichiarazione_rpt

on w_stampa_dichiarazione_rpt.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_stampa_dichiarazione_rpt.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;long ll_id
s_st_param s_parametri   

s_parametri=message.powerobjectparm
ll_id=s_parametri.id_esercizio

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_id)




end event

type cb_5 from commandbutton within w_stampa_dichiarazione_rpt
int X=41
int Y=44
int Width=247
int Height=92
int TabOrder=60
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

type cb_4 from commandbutton within w_stampa_dichiarazione_rpt
int X=1413
int Y=44
int Width=466
int Height=92
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

type cb_3 from commandbutton within w_stampa_dichiarazione_rpt
int X=901
int Y=44
int Width=466
int Height=92
int TabOrder=40
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

type cb_2 from commandbutton within w_stampa_dichiarazione_rpt
int X=3319
int Y=44
int Width=247
int Height=92
int TabOrder=30
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

type cb_1 from commandbutton within w_stampa_dichiarazione_rpt
int X=3022
int Y=44
int Width=247
int Height=92
int TabOrder=20
string Text="Preview"
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

type dw_1 from datawindow within w_stampa_dichiarazione_rpt
int X=59
int Y=176
int Width=3593
int Height=1988
int TabOrder=10
string DataObject="d_dich_per_iva_2"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

