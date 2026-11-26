forward
global type w_cl_fo_movimentati_st from w_selezione_stampa
end type
end forward

global type w_cl_fo_movimentati_st from w_selezione_stampa
integer width = 1006
integer height = 604
end type
global w_cl_fo_movimentati_st w_cl_fo_movimentati_st

on w_cl_fo_movimentati_st.create
call super::create
end on

on w_cl_fo_movimentati_st.destroy
call super::destroy
end on

type cb_1 from w_selezione_stampa`cb_1 within w_cl_fo_movimentati_st
integer x = 0
integer y = 300
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_cl_fo_movimentati_st
integer x = 421
integer y = 304
end type

event cb_stampa::clicked;call super::clicked;s_param_articoli s_par

dw_1.accepttext()
s_par.a_data=dw_1.getitemdate(1, "a_data")
s_par.da_data=dw_1.getitemdate(1, "da_data")

openwithparm(w_cl_fo_movimentati_rpt, s_par)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_cl_fo_movimentati_st
integer width = 695
integer height = 196
string dataobject = "d_da_data_a_data"
end type

