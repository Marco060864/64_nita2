forward
global type w_trova_art_per_prezzo_man_rpt from w_stampa_001
end type
type cbx_1 from checkbox within w_trova_art_per_prezzo_man_rpt
end type
type cbx_2 from checkbox within w_trova_art_per_prezzo_man_rpt
end type
end forward

global type w_trova_art_per_prezzo_man_rpt from w_stampa_001
cbx_1 cbx_1
cbx_2 cbx_2
end type
global w_trova_art_per_prezzo_man_rpt w_trova_art_per_prezzo_man_rpt

type variables
long il_id_prof_doc
string is_cod_fornitore
string is_num_documento
end variables

on w_trova_art_per_prezzo_man_rpt.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cbx_2
end on

on w_trova_art_per_prezzo_man_rpt.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cbx_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
s_param_articoli str_param
str_param=message.powerobjectparm

is_num_documento=str_param.da_categoria
il_id_prof_doc=str_param.li_titolo[1]
is_cod_fornitore=str_param.da_sog_comm
//if istr_param.da_data>date("1900/01/02") then
//
//end if
//if istr_param.da_data>date("1900/01/02") then
//
//end if
if isnull(str_param.da_cod_art) then
	str_param.da_cod_art=" "
end if
if isnull(str_param.a_cod_art) then
	str_param.a_cod_art="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ"
end if

if str_param.solo_preziosi="G" then
	dw_1.dataobject="d_trova_art_per_prezzo_man_giorno_rpt"
	dw_1.settransobject(sqlca)
elseif str_param.solo_preziosi="P" then
	dw_1.dataobject="d_trova_parita_prezzo_rpt"
	dw_1.settransobject(sqlca)
end if

dw_1.retrieve(str_param.da_data, str_param.a_data,str_param.da_cod_art,str_param.a_cod_art)

dw_1.object.t_parametri.text=str_param.filtro
//str_param.da_data
//str_param.a_data
//ls_da_prof=str_param.da_cod_art
//ls_a_prof=str_param.a_cod_art
end event

type dw_1 from w_stampa_001`dw_1 within w_trova_art_per_prezzo_man_rpt
string dataobject = "d_trova_art_per_prezzo_man_rpt"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql

ls_sql=sqlsyntax
if il_id_prof_doc>0 then
	ls_sql=ls_sql + " and (documento.id_prof_documento = "+string(il_id_prof_doc)+") "
end if

if is_cod_fornitore>" " then
	ls_sql=ls_sql + " and (sog_commerciale_gen.codice = '"+is_cod_fornitore+"') "
end if
if is_num_documento> " " then
	ls_sql=ls_sql + " and (documento.num_documento = '"+is_num_documento+"') "
end if
//	
setsqlpreview(ls_sql)
	
end event

event dw_1::doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_trova_art_per_prezzo_man_rpt
integer width = 370
end type

type st_1 from w_stampa_001`st_1 within w_trova_art_per_prezzo_man_rpt
end type

type st_2 from w_stampa_001`st_2 within w_trova_art_per_prezzo_man_rpt
integer x = 1819
end type

type sle_copie from w_stampa_001`sle_copie within w_trova_art_per_prezzo_man_rpt
integer x = 1970
end type

type sle_zoom from w_stampa_001`sle_zoom within w_trova_art_per_prezzo_man_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_trova_art_per_prezzo_man_rpt
boolean visible = false
integer x = 1632
integer y = 16
end type

type cb_7 from w_stampa_001`cb_7 within w_trova_art_per_prezzo_man_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_trova_art_per_prezzo_man_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_trova_art_per_prezzo_man_rpt
integer x = 2939
end type

type cb_stampa from w_stampa_001`cb_stampa within w_trova_art_per_prezzo_man_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_trova_art_per_prezzo_man_rpt
integer x = 2647
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_trova_art_per_prezzo_man_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_trova_art_per_prezzo_man_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_trova_art_per_prezzo_man_rpt
end type

type cbx_1 from checkbox within w_trova_art_per_prezzo_man_rpt
integer x = 2203
integer y = 4
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Righe"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 76")
else
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

type cbx_2 from checkbox within w_trova_art_per_prezzo_man_rpt
integer x = 2203
integer y = 76
integer width = 421
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Tot. Art."
end type

event clicked;if checked then
	dw_1.modify("datawindow.trailer.1.height = 76")
else
	dw_1.modify("datawindow.trailer.1.height = 0")
end if
end event

