forward
global type w_mov_art_rpt from Window
end type
type cb_7 from commandbutton within w_mov_art_rpt
end type
type cb_6 from commandbutton within w_mov_art_rpt
end type
type cb_5 from commandbutton within w_mov_art_rpt
end type
type cb_4 from commandbutton within w_mov_art_rpt
end type
type dw_1 from datawindow within w_mov_art_rpt
end type
type cb_3 from commandbutton within w_mov_art_rpt
end type
type cb_1 from commandbutton within w_mov_art_rpt
end type
end forward

global type w_mov_art_rpt from Window
int X=5
int Y=365
int Width=3658
int Height=1537
boolean TitleBar=true
string Title="Stampa articoli invenduti"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_mov_art_rpt w_mov_art_rpt

type variables
long il_zoom
Decimal id_esi_fiscale_prog,  id_esi_fisica_prog

end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
end event

event open;String ls_parametri, ls_da_articolo, ls_a_articolo
Date	 ld_da_data_reg, ld_a_data_reg
Long	 ll_id_variazione
str_anag_art str_param

str_param=message.PowerObjectParm

ls_parametri=str_param.parametri
ls_da_articolo=str_param.da_art
ls_a_articolo=str_param.a_art
ld_da_data_reg=str_param.da_data
ld_a_data_reg=str_param.a_data
ll_id_variazione=str_param.id_variazione


String  ls_tipo_arrotondamento_e
Decimal ld_parita_euro
Integer li_arrotondamento

SELECT v.parita_euro
INTO	 :ld_parita_euro
FROM	 valuta v, par_sistema p
WHERE	 v.id_valuta = p.id_val_lire
;

CHOOSE CASE SQLCA.SQLCODE
	CASE -1
		MessageBox("", SQLCA.SQLERRTEXT)
		Return
	CASE 100
		ld_parita_euro = 1936.27
END CHOOSE

SELECT cifra_arrotondamento, tipo_arrotondamento
INTO	 :li_arrotondamento, :ls_tipo_arrotondamento_e
FROM	 valuta
WHERE  simbolo = 'E'
;

CHOOSE CASE SQLCA.SQLCODE
	CASE -1
		MessageBox("", SQLCA.SQLERRTEXT)
		Return
	CASE 100
		li_arrotondamento = -2
		ls_tipo_arrotondamento_e = 'M'
END CHOOSE


Time lt_inizio_retrieve, lt_fine_retrieve

lt_inizio_retrieve = Now()




dw_1.SetTransObject(sqlca)
dw_1.Retrieve(ls_parametri , ls_da_articolo, ls_a_articolo, ld_da_data_reg, ld_a_data_reg, ld_parita_euro, li_arrotondamento, ls_tipo_arrotondamento_e)

lt_fine_retrieve = Now()

il_zoom=100
this.event post ue_post_open()
dw_1.groupcalc()
end event

on w_mov_art_rpt.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={ this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_mov_art_rpt.destroy
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

type cb_7 from commandbutton within w_mov_art_rpt
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

type cb_6 from commandbutton within w_mov_art_rpt
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

type cb_5 from commandbutton within w_mov_art_rpt
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

type cb_4 from commandbutton within w_mov_art_rpt
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

type dw_1 from datawindow within w_mov_art_rpt
int X=19
int Y=149
int Width=3612
int Height=1261
int TabOrder=60
string DataObject="d_mov_art_rpt"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event retrieverow;

Decimal ld_esi_fiscale_iniziale, ld_qta_un_base, ld_esi_fisica_iniziale

ld_esi_fiscale_iniziale=This.GetItemNumber(Row, "esi_fiscale")
ld_qta_un_base=This.GetItemNumber(Row, "riga_documento_qta_un_base")

If Row = 1 Then
	id_esi_fiscale_prog = This.GetItemNumber(Row, "esi_fiscale")
End If

If (This.GetItemString(Row, "carico")='S') Then
	id_esi_fiscale_prog=id_esi_fiscale_prog+ld_qta_un_base
End If

If (This.GetItemString(Row, "scarico")='S') Then
	id_esi_fiscale_prog = id_esi_fiscale_prog - ld_qta_un_base
End If

This.SetItem(Row, "esi_fiscale_prog", id_esi_fiscale_prog)


ld_esi_fisica_iniziale=This.GetItemNumber(Row, "esi_fisica")

If Row = 1 Then
	id_esi_fisica_prog = This.GetItemNumber(Row, "esi_fisica")
End If

ld_qta_un_base = Dec(This.GetItemString(Row, "qta_esistenza"))
id_esi_fisica_prog=id_esi_fisica_prog+ld_qta_un_base

This.SetItem(Row, "esi_fisica_prog", id_esi_fisica_prog)


end event

event sqlpreview;String ls_filtro
String Ls_SQLSyntax

str_anag_art str_param

str_param=message.PowerObjectParm
ls_filtro=str_param.filtro

SetNull(ls_SQLSyntax)

If (ls_filtro <> '') Then
	ls_SQLSyntax = SQLSyntax + 'AND (' + ls_filtro + ')'
End If

ls_SQLSyntax = ls_SQLSyntax + ' ORDER BY "documento"."data_registrazione" ASC, "documento"."num_progressivo" ASC'

This.SetSQLPreview(ls_SQLSyntax)

end event

type cb_3 from commandbutton within w_mov_art_rpt
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

type cb_1 from commandbutton within w_mov_art_rpt
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

