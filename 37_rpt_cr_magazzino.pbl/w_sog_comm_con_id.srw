forward
global type w_sog_comm_con_id from w_stampa
end type
end forward

global type w_sog_comm_con_id from w_stampa
end type
global w_sog_comm_con_id w_sog_comm_con_id

type variables
s_param_articoli istr_param
end variables

on w_sog_comm_con_id.create
call super::create
end on

on w_sog_comm_con_id.destroy
call super::destroy
end on

event open;call super::open;istr_param=message.powerobjectparm

dw_1.settransobject(sqlca)

dw_1.retrieve()
end event

type pb_1 from w_stampa`pb_1 within w_sog_comm_con_id
end type

type cb_preview from w_stampa`cb_preview within w_sog_comm_con_id
end type

type dw_1 from w_stampa`dw_1 within w_sog_comm_con_id
string dataobject = "d_sog_comm_con_id"
end type

event dw_1::sqlpreview;call super::sqlpreview;
string ls_sql, ls_sql1
//istr_param.da_cod_art=dw_1.getitemstring(1, "da_sogg_cod")
//istr_param.da_sog_comm=dw_1.getitemstring(1,"da_sogg_des")
//istr_param.a_cod_art=dw_1.getitemstring(1,"a_sogg_cod")
//istr_param.a_sog_comm=dw_1.getitemstring(1,"a_sogg_des")


ls_sql=upper(sqlsyntax)
ls_sql1=ls_sql
//if istr_param.da_cod_art > " " then
	
if istr_param.legato_fino> " " then
	ls_sql1 += " where sog_commerciale_gen.tipo='"+ istr_param.legato_fino+"' "
end if

setsqlpreview(ls_sql1)
//
//
//		if li_pos>0 then
//			ls_sql1=left(ls_sql, li_pos - 1)
//			ls_sql1 += ", der_profilo "
//			ls_sql1 +=right(ls_sql, len(ls_sql) - (li_pos - 1))
//			ls_sql1 += " and der_profilo.id_prof_documento_padre=documento.id_prof_documento "	
//			if is_solo_preziosi="F" or is_solo_preziosi="Z" then
//			
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_sog_comm_con_id
end type

type pb_stampa from w_stampa`pb_stampa within w_sog_comm_con_id
end type

type sle_pg from w_stampa`sle_pg within w_sog_comm_con_id
end type

type st_1 from w_stampa`st_1 within w_sog_comm_con_id
end type

type st_2 from w_stampa`st_2 within w_sog_comm_con_id
end type

type sle_copie from w_stampa`sle_copie within w_sog_comm_con_id
end type

type sle_zoom from w_stampa`sle_zoom within w_sog_comm_con_id
end type

type cb_7 from w_stampa`cb_7 within w_sog_comm_con_id
end type

type cb_6 from w_stampa`cb_6 within w_sog_comm_con_id
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_sog_comm_con_id
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_sog_comm_con_id
end type

type cb_esci from w_stampa`cb_esci within w_sog_comm_con_id
end type

