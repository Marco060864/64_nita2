forward
global type w_stampa_dichiarazione_rpt_p3 from Window
end type
type cbx_1 from checkbox within w_stampa_dichiarazione_rpt_p3
end type
type cb_5 from commandbutton within w_stampa_dichiarazione_rpt_p3
end type
type cb_4 from commandbutton within w_stampa_dichiarazione_rpt_p3
end type
type cb_3 from commandbutton within w_stampa_dichiarazione_rpt_p3
end type
type cb_2 from commandbutton within w_stampa_dichiarazione_rpt_p3
end type
type cb_1 from commandbutton within w_stampa_dichiarazione_rpt_p3
end type
type dw_1 from datawindow within w_stampa_dichiarazione_rpt_p3
end type
end forward

global type w_stampa_dichiarazione_rpt_p3 from Window
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
cbx_1 cbx_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_stampa_dichiarazione_rpt_p3 w_stampa_dichiarazione_rpt_p3

on w_stampa_dichiarazione_rpt_p3.create
this.cbx_1=create cbx_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cbx_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_stampa_dichiarazione_rpt_p3.destroy
destroy(this.cbx_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;long ll_id
s_st_param s_parametri   

cbx_1.Checked = TRUE
dw_1.Object.ivaper2.Visible = 1

s_parametri=message.powerobjectparm
ll_id=s_parametri.id_esercizio

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_id)






end event

type cbx_1 from checkbox within w_stampa_dichiarazione_rpt_p3
int X=1737
int Y=60
int Width=485
int Height=76
string Text="Stampa su modulo "
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_5 from commandbutton within w_stampa_dichiarazione_rpt_p3
int X=69
int Y=40
int Width=229
int Height=100
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

type cb_4 from commandbutton within w_stampa_dichiarazione_rpt_p3
int X=891
int Y=40
int Width=457
int Height=100
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

type cb_3 from commandbutton within w_stampa_dichiarazione_rpt_p3
int X=389
int Y=40
int Width=457
int Height=100
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

type cb_2 from commandbutton within w_stampa_dichiarazione_rpt_p3
int X=3337
int Y=40
int Width=251
int Height=100
int TabOrder=30
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

printsetup()

IF cbx_1.checked=FALSE THEN  
    									
	dw_1.Object.ivaper2.Visible = 0
ELSE
	dw_1.Object.ivaper2.Visible = 1
END IF

dw_1.print()

dw_1.Object.ivaper2.Visible = 1
end event

type cb_1 from commandbutton within w_stampa_dichiarazione_rpt_p3
int X=3040
int Y=40
int Width=251
int Height=100
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

type dw_1 from datawindow within w_stampa_dichiarazione_rpt_p3
int X=59
int Y=176
int Width=3593
int Height=1988
int TabOrder=10
string DataObject="d_dich_per_iva_rpt_p3"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

