forward
global type w_scad_silver_rpt from w_stampa_001
end type
end forward

global type w_scad_silver_rpt from w_stampa_001
end type
global w_scad_silver_rpt w_scad_silver_rpt

type variables
long il_id_tipo_pagamento
string is_tipo_scadenza
end variables

on w_scad_silver_rpt.create
call super::create
end on

on w_scad_silver_rpt.destroy
call super::destroy
end on

event open;call super::open;str_fil_flag str_param



str_param=message.powerobjectparm

il_id_tipo_pagamento=str_param.id_banca

is_tipo_scadenza=str_param.flag

dw_1.object.t_selezione.text = str_param.parametri


dw_1.settransobject(sqlca)

dw_1.retrieve(str_param.da_data,str_param.a_data )
end event

type dw_1 from w_stampa_001`dw_1 within w_scad_silver_rpt
string dataobject = "d_scadenzario_silver"
end type

event dw_1::sqlpreview;string ls_sql, ls_sql_post
integer i
long ll_pos
ls_sql=sqlsyntax
if il_id_tipo_pagamento> 0 then
	
	ll_pos=pos(ls_sql, "ORDER")
	if ll_pos>0 then
		ls_sql_post=right(ls_sql, len(ls_sql) - ll_pos + 1)
		ls_sql=left(ls_SQL, LL_POS - 1)
		ls_sql+=" and scadenza.id_tipo_pagamento="+string(il_id_tipo_pagamento) 
		ls_sql+=" "+ls_sql_post
	end if
end if
if is_tipo_scadenza> " " then
	ll_pos=pos(ls_sql, "ORDER")
	if ll_pos>0 then
		ls_sql_post=right(ls_sql, len(ls_sql) - ll_pos + 1)
		ls_sql=left(ls_SQL, LL_POS - 1)
		ls_sql+=" and scadenza.tipo_scadenza='"+is_tipo_scadenza+"' "
		ls_sql+=" "+ls_sql_post
	end if
end if
if il_id_tipo_pagamento> 0 or is_tipo_scadenza> " " then
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if


end event

type sle_pg from w_stampa_001`sle_pg within w_scad_silver_rpt
end type

type st_1 from w_stampa_001`st_1 within w_scad_silver_rpt
end type

type st_2 from w_stampa_001`st_2 within w_scad_silver_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_scad_silver_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_scad_silver_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_scad_silver_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_scad_silver_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_scad_silver_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_scad_silver_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_scad_silver_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_scad_silver_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_scad_silver_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_scad_silver_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_scad_silver_rpt
end type

