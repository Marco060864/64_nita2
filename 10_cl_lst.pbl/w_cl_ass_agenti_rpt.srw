forward
global type w_cl_ass_agenti_rpt from w_stampa_001
end type
end forward

global type w_cl_ass_agenti_rpt from w_stampa_001
end type
global w_cl_ass_agenti_rpt w_cl_ass_agenti_rpt

type variables
s_param_articoli istr_param
end variables

event open;call super::open;
istr_param=message.powerobjectparm



dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

on w_cl_ass_agenti_rpt.create
call super::create
end on

on w_cl_ass_agenti_rpt.destroy
call super::destroy
end on

type dw_1 from w_stampa_001`dw_1 within w_cl_ass_agenti_rpt
string dataobject = "d_clienti_ass_agenti"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i

ls_sql=sqlsyntax
if istr_param.ll_magazzino>0 then
	//se la stampa è per un singolo agente
	ls_sql=" and gruppo_agenti.id_gruppo_agenti="+string(istr_param.ll_magazzino)+" "
	ls_sql=sqlsyntax + ls_sql
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro agente non applicato!")
	end if
end if

if istr_param.tipo_stampa<>'S' then
	ls_sql+=" and sog_commerciale.id_gruppo_agenti=gruppo_agenti.id_gruppo_agenti "
	
	
	i=SetSQLPreview(ls_sql)
end if
end event

type sle_pg from w_stampa_001`sle_pg within w_cl_ass_agenti_rpt
end type

type st_1 from w_stampa_001`st_1 within w_cl_ass_agenti_rpt
end type

type st_2 from w_stampa_001`st_2 within w_cl_ass_agenti_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_cl_ass_agenti_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_cl_ass_agenti_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_cl_ass_agenti_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_cl_ass_agenti_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_cl_ass_agenti_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_cl_ass_agenti_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_cl_ass_agenti_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_cl_ass_agenti_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_cl_ass_agenti_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_cl_ass_agenti_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_cl_ass_agenti_rpt
end type

