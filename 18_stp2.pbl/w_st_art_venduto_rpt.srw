forward
global type w_st_art_venduto_rpt from w_stampa_001
end type
type cbx_1 from checkbox within w_st_art_venduto_rpt
end type
end forward

global type w_st_art_venduto_rpt from w_stampa_001
cbx_1 cbx_1
end type
global w_st_art_venduto_rpt w_st_art_venduto_rpt

type variables
long il_id_lista
str_anag_art istr_param
end variables

on w_st_art_venduto_rpt.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
end on

on w_st_art_venduto_rpt.destroy
call super::destroy
destroy(this.cbx_1)
end on

event open;call super::open;str_anag_art str_param


str_param=message.powerobjectparm

il_id_lista=str_param.id_parte_regola

dw_1.settransobject(sqlca)

dw_1.retrieve(str_param.da_art, str_param.a_art, str_param.da_data, str_param.a_data, il_id_lista)


end event

type dw_1 from w_stampa_001`dw_1 within w_st_art_venduto_rpt
string dataobject = "d_art_venduto"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer li_ret, a

ls_sql=sqlsyntax
if il_id_lista>0 then
	ls_sql+= " and articolo.id_articolo in (select id_articolo from lista_art_key"+&
				" where id_lista_articoli="+string(il_id_lista)+")"
	a++
end if
if istr_param.id_cat_codifica >0 then
	ls_sql+=" and (articolo_a.id_cat_codifica= "+string(istr_param.id_cat_codifica)+") "
	a++
end if
if istr_param.id_cat_comm >0 then
	ls_sql+=" and (articolo_a.id_cat_com_articolo= "+string(istr_param.id_cat_comm)+") "
	a++
end if
if istr_param.id_cat_merc >0 then
	ls_sql+=" and (articolo_a.id_cat_merceologica= "+string(istr_param.id_cat_merc)+") "
	a++
end if
if istr_param.id_cat_fisc >0 then
	ls_sql+=" and (articolo_a.id_cat_fiscale= "+string(istr_param.id_cat_fisc)+") "
	a++
end if
if a>0 then
	li_ret=setsqlpreview(ls_sql)
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_st_art_venduto_rpt
integer x = 1646
integer width = 311
end type

type st_1 from w_stampa_001`st_1 within w_st_art_venduto_rpt
integer x = 1362
end type

type st_2 from w_stampa_001`st_2 within w_st_art_venduto_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_st_art_venduto_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_st_art_venduto_rpt
integer x = 686
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_st_art_venduto_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_st_art_venduto_rpt
integer x = 837
end type

type cb_6 from w_stampa_001`cb_6 within w_st_art_venduto_rpt
integer x = 571
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_st_art_venduto_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_st_art_venduto_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_st_art_venduto_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_st_art_venduto_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_st_art_venduto_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_st_art_venduto_rpt
end type

type cbx_1 from checkbox within w_st_art_venduto_rpt
integer x = 992
integer y = 40
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi righe"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 76")
	dw_1.modify("datawindow.header.1.height = 168")
else
	dw_1.modify("datawindow.detail.height = 0")
	dw_1.modify("datawindow.header.1.height = 84")
end if
end event

