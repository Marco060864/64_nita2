forward
global type w_conti_movimentati_rpt from w_stampa_001
end type
end forward

global type w_conti_movimentati_rpt from w_stampa_001
integer x = 23
integer y = 12
end type
global w_conti_movimentati_rpt w_conti_movimentati_rpt

on w_conti_movimentati_rpt.create
call super::create
end on

on w_conti_movimentati_rpt.destroy
call super::destroy
end on

event open;call super::open;s_param_articoli s_par
dw_1.settransobject(sqlca)


s_par=message.powerobjectparm

dw_1.retrieve(s_par.da_data, s_par.a_data, s_par.filtro)

end event

type dw_1 from w_stampa_001`dw_1 within w_conti_movimentati_rpt
integer x = 29
integer y = 128
integer width = 3131
integer height = 1536
string dataobject = "d_conti_movimentati_rpt"
end type

type sle_pg from w_stampa_001`sle_pg within w_conti_movimentati_rpt
end type

type st_1 from w_stampa_001`st_1 within w_conti_movimentati_rpt
end type

type st_2 from w_stampa_001`st_2 within w_conti_movimentati_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_conti_movimentati_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_conti_movimentati_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_conti_movimentati_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_conti_movimentati_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_conti_movimentati_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_conti_movimentati_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_conti_movimentati_rpt
end type

type cb_preview from w_stampa_001`cb_preview within w_conti_movimentati_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_conti_movimentati_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_conti_movimentati_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_conti_movimentati_rpt
end type

