forward
global type w_esiart_rpt from Window
end type
type cb_2 from commandbutton within w_esiart_rpt
end type
type cb_7 from commandbutton within w_esiart_rpt
end type
type cb_6 from commandbutton within w_esiart_rpt
end type
type cb_5 from commandbutton within w_esiart_rpt
end type
type cb_4 from commandbutton within w_esiart_rpt
end type
type dw_1 from datawindow within w_esiart_rpt
end type
type cb_3 from commandbutton within w_esiart_rpt
end type
type cb_1 from commandbutton within w_esiart_rpt
end type
end forward

global type w_esiart_rpt from Window
int X=5
int Y=365
int Width=3658
int Height=1521
boolean TitleBar=true
string Title="Stampa esistenza articoli"
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
global w_esiart_rpt w_esiart_rpt

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
end event

event open;
	
Long 		ret
String 	ls_parametri, ls_titolo
long 		ll_anno, ll_mese, ll_id_esercizio

str_esi_art1 str_param

str_param=message.powerobjectparm

ll_anno=str_param.anno
ll_mese=str_param.mese
ll_id_esercizio=str_param.id_esercizio
ls_parametri=str_param.parametri
ls_titolo = "Esistenza articoli al " + String(ll_mese) + "/" + String(ll_anno)

dw_1.SetTransObject(sqlca)

dw_1.Retrieve(ll_id_esercizio, ll_anno, ll_mese, ls_parametri, ls_titolo)

il_zoom=100
this.event post ue_post_open()

end event

on w_esiart_rpt.create
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={ this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_esiart_rpt.destroy
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

type cb_2 from commandbutton within w_esiart_rpt
int X=2986
int Y=41
int Width=389
int Height=85
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

type cb_7 from commandbutton within w_esiart_rpt
event clicked pbm_bnclicked
int X=2506
int Y=41
int Width=261
int Height=85
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

type cb_6 from commandbutton within w_esiart_rpt
event clicked pbm_bnclicked
int X=2231
int Y=41
int Width=261
int Height=85
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

type cb_5 from commandbutton within w_esiart_rpt
int X=682
int Y=41
int Width=467
int Height=85
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

type cb_4 from commandbutton within w_esiart_rpt
int X=1162
int Y=41
int Width=467
int Height=85
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

type dw_1 from datawindow within w_esiart_rpt
int X=19
int Y=161
int Width=3612
int Height=1265
int TabOrder=60
string DataObject="d_esiart_rpt"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;String ls_filtro, Ls_SQLSyntax

str_esi_art1 str_param

str_param=message.PowerObjectParm
ls_filtro		= str_param.filtro

ls_SQLSyntax = SQLSyntax

	
If (ls_filtro <> '') Then
	ls_SQLSyntax = ls_SQLSyntax + ' AND ' + ls_filtro
End If

ls_SQLSyntax = ls_SQLSyntax + ' ORDER BY articolo.codice'

This.SetSQLPreview(ls_SQLSyntax)
end event

type cb_3 from commandbutton within w_esiart_rpt
int X=3388
int Y=41
int Width=247
int Height=85
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

type cb_1 from commandbutton within w_esiart_rpt
int X=23
int Y=41
int Width=247
int Height=85
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

