forward
global type w_fv_con_articolo from w_stampa
end type
end forward

global type w_fv_con_articolo from w_stampa
integer width = 3643
integer height = 1740
end type
global w_fv_con_articolo w_fv_con_articolo

on w_fv_con_articolo.create
call super::create
end on

on w_fv_con_articolo.destroy
call super::destroy
end on

event open;call super::open;integer i, li_ret
s_array s_filtro

dw_1.settransobject(sqlca)

s_filtro=message.powerobjectparm

for i=1 to upperbound(s_filtro.ll_id_doc)
	
	li_ret=dw_1.retrieve(s_filtro.ll_id_doc[i])
	
next
end event

type pb_1 from w_stampa`pb_1 within w_fv_con_articolo
string text = ""
end type

type cb_preview from w_stampa`cb_preview within w_fv_con_articolo
end type

type dw_1 from w_stampa`dw_1 within w_fv_con_articolo
integer width = 3497
string dataobject = "d_trova_prezzi_articolo_in_riga_rpt"
end type

event dw_1::retrievestart;call super::retrievestart;return 2
end event

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i

ls_sql=sqlsyntax

ls_sql+=" and right(registro.tipo_registro, 2)= 'IV'"

i=SetSQLPreview(ls_sql)
if i<>1 then
	messagebox("Errore!", "Filtro non applicato!")
end if

end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_fv_con_articolo
end type

type pb_stampa from w_stampa`pb_stampa within w_fv_con_articolo
end type

type sle_pg from w_stampa`sle_pg within w_fv_con_articolo
end type

type st_1 from w_stampa`st_1 within w_fv_con_articolo
end type

type st_2 from w_stampa`st_2 within w_fv_con_articolo
end type

type sle_copie from w_stampa`sle_copie within w_fv_con_articolo
end type

type sle_zoom from w_stampa`sle_zoom within w_fv_con_articolo
end type

type cb_7 from w_stampa`cb_7 within w_fv_con_articolo
end type

type cb_6 from w_stampa`cb_6 within w_fv_con_articolo
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_fv_con_articolo
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_fv_con_articolo
end type

type cb_esci from w_stampa`cb_esci within w_fv_con_articolo
end type

