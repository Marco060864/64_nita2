forward
global type w_vedi_art_per_misura from w_stampa
end type
end forward

global type w_vedi_art_per_misura from w_stampa
integer x = 1000
integer y = 500
end type
global w_vedi_art_per_misura w_vedi_art_per_misura

event open;call super::open;long ll_id_art


ll_id_art=message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_id_art)
end event

on w_vedi_art_per_misura.create
call super::create
end on

on w_vedi_art_per_misura.destroy
call super::destroy
end on

type pb_1 from w_stampa`pb_1 within w_vedi_art_per_misura
end type

type cb_preview from w_stampa`cb_preview within w_vedi_art_per_misura
end type

type dw_1 from w_stampa`dw_1 within w_vedi_art_per_misura
string dataobject = "d_art_misura_qta"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql,ls_sql1
date ldt_data_fine, ldt_data_inizio
integer li_ret, li_pos

ls_sql=upper(sqlsyntax)

select data_inizio, data_fine into :ldt_data_inizio, :ldt_data_fine from dba.esercizio where data_inizio<= today() and data_fine >= today();
if ldt_data_inizio> date("1900-01-01") then
	li_pos=pos(ls_sql, "GROUP")
	ls_sql1= left(ls_sql, li_pos - 1) + " and documento.data_documento>=date('"+string(ldt_data_inizio, "yyyy/mm/dd")+"') and documento.data_documento<=date('"+string(ldt_data_fine,"yyyy/mm/dd")+"') " +&
				right(ls_sql, len(ls_sql) - li_pos +1)	
end if
li_ret=setsqlpreview(ls_sql1)
	
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_vedi_art_per_misura
end type

type pb_stampa from w_stampa`pb_stampa within w_vedi_art_per_misura
end type

type sle_pg from w_stampa`sle_pg within w_vedi_art_per_misura
end type

type st_1 from w_stampa`st_1 within w_vedi_art_per_misura
end type

type st_2 from w_stampa`st_2 within w_vedi_art_per_misura
end type

type sle_copie from w_stampa`sle_copie within w_vedi_art_per_misura
end type

type sle_zoom from w_stampa`sle_zoom within w_vedi_art_per_misura
end type

type cb_7 from w_stampa`cb_7 within w_vedi_art_per_misura
end type

type cb_6 from w_stampa`cb_6 within w_vedi_art_per_misura
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_vedi_art_per_misura
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_vedi_art_per_misura
end type

type cb_esci from w_stampa`cb_esci within w_vedi_art_per_misura
end type

