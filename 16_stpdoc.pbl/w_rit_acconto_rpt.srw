forward
global type w_rit_acconto_rpt from w_stampa_001
end type
end forward

global type w_rit_acconto_rpt from w_stampa_001
integer x = 23
integer y = 12
end type
global w_rit_acconto_rpt w_rit_acconto_rpt

type variables
string  is_cod_sog
end variables

on w_rit_acconto_rpt.create
call super::create
end on

on w_rit_acconto_rpt.destroy
call super::destroy
end on

event open;call super::open;s_param_articoli str_param


dw_1.settransobject(sqlca)

str_param=message.powerobjectparm

if str_param.da_sog_comm >" " then
	is_cod_sog=str_param.da_sog_comm
	
end if

dw_1.retrieve(integer(str_param.da_categoria), str_param.coef_calo)

end event

type dw_1 from w_stampa_001`dw_1 within w_rit_acconto_rpt
string dataobject = "d_st_cert_rit_acconto"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
ls_sql=sqlsyntax

if is_cod_sog>" " then
	ls_sql+=" and ( sog_commerciale.codice= '"+is_cod_sog+"' )"
	setsqlpreview(ls_sql)
end if

end event

type sle_pg from w_stampa_001`sle_pg within w_rit_acconto_rpt
end type

type st_1 from w_stampa_001`st_1 within w_rit_acconto_rpt
end type

type st_2 from w_stampa_001`st_2 within w_rit_acconto_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_rit_acconto_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_rit_acconto_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_rit_acconto_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_rit_acconto_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_rit_acconto_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_rit_acconto_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_rit_acconto_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_rit_acconto_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_rit_acconto_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_rit_acconto_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_rit_acconto_rpt
end type

