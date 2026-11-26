forward
global type w_an_galv_controllo from w_stampa
end type
end forward

global type w_an_galv_controllo from w_stampa
end type
global w_an_galv_controllo w_an_galv_controllo

on w_an_galv_controllo.create
call super::create
end on

on w_an_galv_controllo.destroy
call super::destroy
end on

event open;call super::open;long ll_id_doc

dw_1.settransobject(sqlca)
ll_id_doc=message.doubleparm
dw_1.retrieve(ll_id_doc)
end event

type pb_1 from w_stampa`pb_1 within w_an_galv_controllo
end type

type cb_preview from w_stampa`cb_preview within w_an_galv_controllo
end type

type dw_1 from w_stampa`dw_1 within w_an_galv_controllo
integer width = 1829
string dataobject = "d_an_galv_tot_doc_rpt"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_an_galv_controllo
end type

type pb_stampa from w_stampa`pb_stampa within w_an_galv_controllo
end type

type sle_pg from w_stampa`sle_pg within w_an_galv_controllo
end type

type st_1 from w_stampa`st_1 within w_an_galv_controllo
end type

type st_2 from w_stampa`st_2 within w_an_galv_controllo
end type

type sle_copie from w_stampa`sle_copie within w_an_galv_controllo
end type

type sle_zoom from w_stampa`sle_zoom within w_an_galv_controllo
end type

type cb_7 from w_stampa`cb_7 within w_an_galv_controllo
end type

type cb_6 from w_stampa`cb_6 within w_an_galv_controllo
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_an_galv_controllo
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_an_galv_controllo
end type

type cb_esci from w_stampa`cb_esci within w_an_galv_controllo
end type

