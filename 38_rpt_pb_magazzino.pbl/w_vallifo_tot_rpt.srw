forward
global type w_vallifo_tot_rpt from Window
end type
type cb_2 from commandbutton within w_vallifo_tot_rpt
end type
type cb_7 from commandbutton within w_vallifo_tot_rpt
end type
type cb_6 from commandbutton within w_vallifo_tot_rpt
end type
type cb_5 from commandbutton within w_vallifo_tot_rpt
end type
type cb_4 from commandbutton within w_vallifo_tot_rpt
end type
type dw_1 from datawindow within w_vallifo_tot_rpt
end type
type cb_3 from commandbutton within w_vallifo_tot_rpt
end type
type cb_1 from commandbutton within w_vallifo_tot_rpt
end type
end forward

global type w_vallifo_tot_rpt from Window
int X=5
int Y=364
int Width=3657
int Height=1488
boolean TitleBar=true
string Title="Valorizzazioni di Magazzino"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_vallifo_tot_rpt w_vallifo_tot_rpt

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
end event

event open;String 	ls_filtro, ls_parametri, ls_tipo_stampa
Date	 	ld_data_val
Long		ll_id_valuta	

s_rpt_mag s_param

ls_filtro=message.StringParm
s_param=message.PowerObjectParm

ls_parametri	= s_param.parametri
ls_filtro		= s_param.filtro
ld_data_val		= s_param.a_data
ls_tipo_stampa = s_param.flag
ll_id_valuta	= s_param.id_valuta	

dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(ls_parametri, ld_data_val, ls_tipo_stampa, ll_id_valuta)	

il_zoom=100
this.event post ue_post_open()
dw_1.groupcalc()
end event

on w_vallifo_tot_rpt.create
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_vallifo_tot_rpt.destroy
destroy(this.cb_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type cb_2 from commandbutton within w_vallifo_tot_rpt
int X=2944
int Y=28
int Width=389
int Height=84
int TabOrder=31
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_vallifo_tot_rpt
event clicked pbm_bnclicked
int X=2523
int Y=28
int Width=261
int Height=84
int TabOrder=30
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_vallifo_tot_rpt
event clicked pbm_bnclicked
int X=2231
int Y=28
int Width=261
int Height=84
int TabOrder=40
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_vallifo_tot_rpt
int X=672
int Y=28
int Width=466
int Height=84
int TabOrder=50
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_vallifo_tot_rpt
int X=1170
int Y=28
int Width=466
int Height=84
int TabOrder=20
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_vallifo_tot_rpt
int X=27
int Y=128
int Width=3611
int Height=1260
int TabOrder=60
string DataObject="d_vallifo_tot_rpt"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;String ls_filtro
String Ls_SQLSyntax

s_rpt_mag s_param

s_param=message.PowerObjectParm
ls_filtro		= s_param.filtro

ls_SQLSyntax = SQLSyntax
	
If (ls_filtro <> '') Then
	ls_SQLSyntax = ls_SQLSyntax + ls_filtro
End If

This.SetSQLPreview(ls_SQLSyntax)
end event

type cb_3 from commandbutton within w_vallifo_tot_rpt
int X=3365
int Y=28
int Width=265
int Height=84
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_vallifo_tot_rpt
int X=23
int Y=28
int Width=247
int Height=84
int TabOrder=70
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

