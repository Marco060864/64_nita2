forward
global type w_movartlotto_rpt from Window
end type
type dw_2 from datawindow within w_movartlotto_rpt
end type
type cb_2 from commandbutton within w_movartlotto_rpt
end type
type cb_7 from commandbutton within w_movartlotto_rpt
end type
type cb_6 from commandbutton within w_movartlotto_rpt
end type
type cb_5 from commandbutton within w_movartlotto_rpt
end type
type cb_4 from commandbutton within w_movartlotto_rpt
end type
type dw_1 from datawindow within w_movartlotto_rpt
end type
type cb_3 from commandbutton within w_movartlotto_rpt
end type
type cb_1 from commandbutton within w_movartlotto_rpt
end type
end forward

global type w_movartlotto_rpt from Window
int X=5
int Y=364
int Width=3657
int Height=1516
boolean TitleBar=true
string Title="Stampa articoli invenduti"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
dw_2 dw_2
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_movartlotto_rpt w_movartlotto_rpt

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
end event

event open;String 	ls_filtro, ls_parametri
Decimal	ld_parita_euro, ld_con_promozionale, ld_spese_varie
Long		ll_id_valuta	

str_movartlotto str_param

str_param=message.PowerObjectParm
ls_parametri=str_param.parametri
ld_con_promozionale=str_param.con_promozionale
ld_spese_varie=str_param.spese_varie
ll_id_valuta	= str_param.id_valuta	

SELECT v.parita_euro
INTO	 :ld_parita_euro
FROM	 par_sistema p, valuta v
WHERE	 v.id_valuta = p.id_val_lire
;

CHOOSE CASE SQLCA.SQLCODE
	CASE -1
		MessageBox("", SQLCA.SQLerrtext)
		Return
	CASE 100
		ld_parita_euro = 1936.27
END CHOOSE

dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(ls_parametri, ld_parita_euro, ld_con_promozionale, ld_spese_varie, ll_id_valuta)	


il_zoom=100
this.event post ue_post_open()
dw_1.groupcalc()
end event

on w_movartlotto_rpt.create
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.dw_2,&
this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_movartlotto_rpt.destroy
destroy(this.dw_2)
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

type dw_2 from datawindow within w_movartlotto_rpt
int X=279
int Y=1580
int Width=2811
int Height=360
int TabOrder=71
boolean Visible=false
string DataObject="d_scelta_parte_rpt"
boolean LiveScroll=true
end type

type cb_2 from commandbutton within w_movartlotto_rpt
int X=2981
int Y=32
int Width=389
int Height=84
int TabOrder=40
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.SaveAs()
dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_movartlotto_rpt
event clicked pbm_bnclicked
int X=2523
int Y=32
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

type cb_6 from commandbutton within w_movartlotto_rpt
event clicked pbm_bnclicked
int X=2231
int Y=32
int Width=261
int Height=84
int TabOrder=50
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

type cb_5 from commandbutton within w_movartlotto_rpt
int X=672
int Y=32
int Width=466
int Height=84
int TabOrder=60
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_movartlotto_rpt
int X=1161
int Y=32
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

type dw_1 from datawindow within w_movartlotto_rpt
int X=18
int Y=160
int Width=3611
int Height=1268
int TabOrder=70
string DataObject="d_movartlotto_rpt"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;String ls_filtro
String Ls_SQLSyntax

str_movartlotto str_param

str_param=message.PowerObjectParm
ls_filtro		= str_param.filtro

ls_SQLSyntax = SQLSyntax

If (ls_filtro <> '') Then
	ls_SQLSyntax = ls_SQLSyntax + 'AND (' + ls_filtro + ')'
End If

ls_SQLSyntax = ls_SQLSyntax + ' ORDER BY lotto.cod_esterno, documento.data_documento, articolo.codice'

This.SetSQLPreview(ls_SQLSyntax)
end event

type cb_3 from commandbutton within w_movartlotto_rpt
int X=3387
int Y=32
int Width=247
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
dw_2.print()
dw_1.print()
end event

type cb_1 from commandbutton within w_movartlotto_rpt
int X=23
int Y=32
int Width=247
int Height=84
int TabOrder=80
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

