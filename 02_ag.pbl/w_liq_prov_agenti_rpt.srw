forward
global type w_liq_prov_agenti_rpt from Window
end type
type cb_2 from commandbutton within w_liq_prov_agenti_rpt
end type
type cb_7 from commandbutton within w_liq_prov_agenti_rpt
end type
type cb_6 from commandbutton within w_liq_prov_agenti_rpt
end type
type cb_5 from commandbutton within w_liq_prov_agenti_rpt
end type
type cb_4 from commandbutton within w_liq_prov_agenti_rpt
end type
type dw_1 from datawindow within w_liq_prov_agenti_rpt
end type
type cb_3 from commandbutton within w_liq_prov_agenti_rpt
end type
type cb_1 from commandbutton within w_liq_prov_agenti_rpt
end type
end forward

global type w_liq_prov_agenti_rpt from Window
int X=5
int Y=364
int Width=3657
int Height=1488
boolean TitleBar=true
string Title="Liquidazione provvigioni Agenti"
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
global w_liq_prov_agenti_rpt w_liq_prov_agenti_rpt

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272

long	ll_id_valuta

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if ll_id_valuta > 0 then
	string 		ls_mask
	
	ls_mask = f_valu_mask(ll_id_valuta)
	
	dw_1.Modify("cprov_fatturato.format = '" + ls_mask + "'")
	dw_1.Modify("imp_prov_incassato_val.format = '" + ls_mask + "'")
	dw_1.Modify("tot_fattura.format = '" + ls_mask + "'")
	dw_1.Modify("imp_provvigioni.format = '" + ls_mask + "'")
	dw_1.Modify("incassato_netto_val.format = '" + ls_mask + "'")
	dw_1.Modify("provv_importo.format = '" + ls_mask + "'")
	dw_1.Modify("ctotale.format = '" + ls_mask + "'")
	dw_1.Modify("liq_pagato_val.format = '" + ls_mask + "'")
	dw_1.Modify("tot_provvigioni.format = '" + ls_mask + "'")
	dw_1.Modify("imp_fisso_val.format = '" + ls_mask + "'")
	dw_1.Modify("imp_premio_budget_val.format = '" + ls_mask + "'")	
	dw_1.Modify("importo_da_liquidare.format = '" + ls_mask + "'")
	dw_1.Modify("importo_iva.format = '" + ls_mask + "'")
	dw_1.Modify("totale_fattura.format = '" + ls_mask + "'")
	dw_1.Modify("enasarco_da_versare.format = '" + ls_mask + "'")
	dw_1.Modify("progressivo_enasarco_val.format = '" + ls_mask + "'")
	dw_1.Modify("massimale_val.format = '" + ls_mask + "'")
	dw_1.Modify("crit_acconto.format = '" + ls_mask + "'")
	dw_1.Modify("crit_acconto_imp.format = '" + ls_mask + "'")
	dw_1.Modify("imp_rit_acconto.format = '" + ls_mask + "'")
	dw_1.Modify("netto.format = '" + ls_mask + "'")
end if

end event

event open;String 	ls_filtro, ls_parametri, ls_tipo_stampa

str_liq_prov str_param

ls_filtro=message.StringParm
str_param=message.PowerObjectParm

ls_parametri=str_param.parametri
ls_filtro=str_param.filtro
ls_tipo_stampa=str_param.flag

CHOOSE CASE ls_tipo_stampa
	CASE 'P'
		ls_tipo_stampa = 'provvisoria'
	CASE 'D'
		ls_tipo_stampa = 'definitiva'		
END CHOOSE


dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(ls_parametri, ls_tipo_stampa)

il_zoom=100
this.event post ue_post_open()
end event

on w_liq_prov_agenti_rpt.create
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

on w_liq_prov_agenti_rpt.destroy
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

type cb_2 from commandbutton within w_liq_prov_agenti_rpt
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

type cb_7 from commandbutton within w_liq_prov_agenti_rpt
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

type cb_6 from commandbutton within w_liq_prov_agenti_rpt
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

type cb_5 from commandbutton within w_liq_prov_agenti_rpt
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

type cb_4 from commandbutton within w_liq_prov_agenti_rpt
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

type dw_1 from datawindow within w_liq_prov_agenti_rpt
int X=27
int Y=128
int Width=3611
int Height=1260
int TabOrder=60
string DataObject="d_liq_prov_agenti_rpt"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;String ls_filtro
String Ls_SQLSyntax

str_liq_prov str_param

str_param=message.PowerObjectParm
ls_filtro		= str_param.filtro

ls_SQLSyntax = SQLSyntax
	
If (ls_filtro <> '') Then
	ls_SQLSyntax = ls_SQLSyntax + 'AND (' + ls_filtro + ')'
End If

ls_SQLSyntax = ls_SQLSyntax + ' ORDER BY sog_commerciale.codice, sog_commerciale_gen.codice, documento.data_documento, documento.num_documento'

This.SetSQLPreview(ls_SQLSyntax)
end event

event retrieverow;


Decimal	ld_totale, ld_prov_fatturato, ld_prov_incassato, ld_premi_penalita
Decimal	ld_imp_provvigioni, ld_provvigioni, ld_rip_per_fatturato
Long		ll_id_val_doc, ll_id_val_prov_agente	


ld_imp_provvigioni = dw_1.Object.riep_prov_righe_imp_provv_documento[Row]
ld_provvigioni = dw_1.Object.riep_prov_righe_provvigioni[Row]

If IsNull(ld_imp_provvigioni) Then
	ld_imp_provvigioni = 0
End If

If IsNull(ld_provvigioni) Then
	ld_provvigioni = 0
End If

If dw_1.Object.documento_tipo_fattura[Row] = 'C' Then		
	If dw_1.Object.riep_prov_righe_tipo_prov[Row] = 'P' Then
		ld_prov_fatturato = (ld_imp_provvigioni * ld_provvigioni  / 100)
	Else
		ld_prov_fatturato = ld_provvigioni
	End If
Else	
	
	ld_rip_per_fatturato = dw_1.Object.gruppo_agenti_rip_per_fatturato[Row]
		
	If IsNull(ld_rip_per_fatturato) Then
			ld_rip_per_fatturato = 0
	End If
	
	If dw_1.Object.riep_prov_righe_tipo_prov[Row] = 'P' Then
		ld_prov_fatturato = ((ld_imp_provvigioni * ld_rip_per_fatturato  / 100) * ld_provvigioni / 100)
	Else	
		ld_prov_fatturato = (ld_provvigioni * ld_rip_per_fatturato / 100)
	End If
End If

ll_id_val_doc 		 = dw_1.getitemnumber(Row, "documento_id_valuta")
ll_id_val_prov_agente = dw_1.getitemnumber(Row, "id_val_prov_agente")

if (ll_id_val_doc <> ll_id_val_prov_agente and ld_prov_fatturato > 0) then
	SELECT FN_CONV_VALUTA(:ll_id_val_doc, :ld_prov_fatturato, :ll_id_val_prov_agente)
	INTO	 :ld_prov_fatturato
	FROM	 SYS.DUMMY
	;
	
	if (sqlca.sqlcode = -1) then &
		messagebox("Dberror", sqlca.sqlerrtext)
end if

dw_1.Object.cprov_fatturato[Row] = ld_prov_fatturato

If (not(IsNull(dw_1.Object.riep_prov_righe_data_elab_fatturato[Row]))) and (not(IsNull(dw_1.Object.sog_commerciale_ult_elab_definitivo[Row]))) Then
	If dw_1.Object.riep_prov_righe_data_elab_fatturato[Row] <> dw_1.Object.sog_commerciale_ult_elab_definitivo[Row] Then
		ld_prov_fatturato = 0 
		dw_1.Object.cgia_fatturato[Row] = '*'
	Else
		ld_prov_fatturato = dw_1.Object.cprov_fatturato[Row]
	End If
End If	

ld_prov_incassato = dw_1.Object.riep_prov_righe_imp_prov_incassato[Row]
ld_premi_penalita	= dw_1.Object.riep_provvigioni_imp_premi_penalita[Row]
ld_premi_penalita = 0	

If IsNull(ld_prov_fatturato) Then
	ld_prov_fatturato = 0
End If

If IsNull(ld_prov_incassato) Then
	ld_prov_incassato = 0
End If

If IsNull(ld_premi_penalita) Then
	ld_premi_penalita = 0
End If

if (ll_id_val_doc <> ll_id_val_prov_agente and ld_prov_incassato > 0) then
	SELECT FN_CONV_VALUTA(:ll_id_val_doc, :ld_prov_incassato, :ll_id_val_prov_agente)
	INTO	 :ld_prov_incassato
	FROM	 SYS.DUMMY
	;
	
	if (sqlca.sqlcode = -1) then &
		messagebox("Dberror", sqlca.sqlerrtext)
end if

if (ll_id_val_doc <> ll_id_val_prov_agente and ld_premi_penalita > 0) then
	SELECT FN_CONV_VALUTA(:ll_id_val_doc, :ld_premi_penalita, :ll_id_val_prov_agente)
	INTO	 :ld_premi_penalita
	FROM	 SYS.DUMMY
	;
	
	if (sqlca.sqlcode = -1) then &
		messagebox("Dberror", sqlca.sqlerrtext)
end if

ld_totale = ld_prov_fatturato + ld_prov_incassato + ld_premi_penalita

dw_1.Object.ctotale[Row] = ld_totale

end event

type cb_3 from commandbutton within w_liq_prov_agenti_rpt
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

type cb_1 from commandbutton within w_liq_prov_agenti_rpt
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

