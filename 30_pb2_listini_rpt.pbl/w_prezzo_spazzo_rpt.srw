forward
global type w_prezzo_spazzo_rpt from w_stampa
end type
end forward

global type w_prezzo_spazzo_rpt from w_stampa
integer width = 3685
end type
global w_prezzo_spazzo_rpt w_prezzo_spazzo_rpt

on w_prezzo_spazzo_rpt.create
call super::create
end on

on w_prezzo_spazzo_rpt.destroy
call super::destroy
end on

event open;call super::open;long ll_id_var

dw_1.settransobject(sqlca)

ll_id_var=message.doubleparm
dw_1.retrieve(ll_id_var)
end event

type pb_1 from w_stampa`pb_1 within w_prezzo_spazzo_rpt
end type

type cb_preview from w_stampa`cb_preview within w_prezzo_spazzo_rpt
end type

type dw_1 from w_stampa`dw_1 within w_prezzo_spazzo_rpt
integer width = 3515
string dataobject = "d_st_prezzo_spazzo"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_prezzo_spazzo_rpt
end type

type pb_stampa from w_stampa`pb_stampa within w_prezzo_spazzo_rpt
end type

type sle_pg from w_stampa`sle_pg within w_prezzo_spazzo_rpt
end type

type st_1 from w_stampa`st_1 within w_prezzo_spazzo_rpt
end type

type st_2 from w_stampa`st_2 within w_prezzo_spazzo_rpt
end type

type sle_copie from w_stampa`sle_copie within w_prezzo_spazzo_rpt
end type

type sle_zoom from w_stampa`sle_zoom within w_prezzo_spazzo_rpt
end type

type cb_7 from w_stampa`cb_7 within w_prezzo_spazzo_rpt
end type

type cb_6 from w_stampa`cb_6 within w_prezzo_spazzo_rpt
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_prezzo_spazzo_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_prezzo_spazzo_rpt
end type

type cb_esci from w_stampa`cb_esci within w_prezzo_spazzo_rpt
end type

