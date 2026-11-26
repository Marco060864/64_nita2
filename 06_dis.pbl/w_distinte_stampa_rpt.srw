forward
global type w_distinte_stampa_rpt from w_stampa_001
end type
end forward

global type w_distinte_stampa_rpt from w_stampa_001
integer width = 3918
end type
global w_distinte_stampa_rpt w_distinte_stampa_rpt

type variables
long il_id_cat_codifica
str_anag_art istr_param
end variables

on w_distinte_stampa_rpt.create
call super::create
end on

on w_distinte_stampa_rpt.destroy
call super::destroy
end on

event open;call super::open;

istr_param=message.powerobjectparm


dw_1.settransobject(sqlca)
dw_1.retrieve(istr_param.da_art, istr_param.a_art)


end event

type dw_1 from w_stampa_001`dw_1 within w_distinte_stampa_rpt
integer width = 3767
string dataobject = "d_stp_distinta"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i, a
ls_sql=sqlsyntax
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
if istr_param.id_valuta >0 then //è l'id dell'articolo finito
	ls_sql+=" and (articolo_a.id_articolo= "+string(istr_param.id_valuta)+") "
	a++
end if
if a>0 then
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if
	
	


	
end event

event dw_1::doubleclicked;call super::doubleclicked;s_list_main ls_list_distinta
long ll_articolo,ll_id_dis
if row>0 then
	ll_articolo=getitemnumber(row,"articolo_a_id_articolo")
	ll_id_dis=getitemnumber(row, "distinta_id_distinta")
	if ll_id_dis>0 then
		ls_list_distinta.s_modo = modo_modifica
		ls_list_distinta.s_SQL_ident[1] = "distinta.id_distinta"
		ls_list_distinta.s_identifica[1]="id_distinta"
		ls_list_distinta.l_identifica[1]=ll_id_dis
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
	else
			ls_list_distinta.s_identifica[1]="id_articolo"
			ls_list_distinta.l_identifica[1]=ll_articolo
			OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
			setfocus(w_distinta_base_cx)
	end if
end if	

end event

type sle_pg from w_stampa_001`sle_pg within w_distinte_stampa_rpt
end type

type st_1 from w_stampa_001`st_1 within w_distinte_stampa_rpt
end type

type st_2 from w_stampa_001`st_2 within w_distinte_stampa_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_distinte_stampa_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_distinte_stampa_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_distinte_stampa_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_distinte_stampa_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_distinte_stampa_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_distinte_stampa_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_distinte_stampa_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_distinte_stampa_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_distinte_stampa_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_distinte_stampa_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_distinte_stampa_rpt
end type

