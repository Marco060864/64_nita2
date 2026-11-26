forward
global type w_nazione_lt from w_list_main
end type
end forward

global type w_nazione_lt from w_list_main
integer width = 5230
end type
global w_nazione_lt w_nazione_lt

on w_nazione_lt.create
call super::create
end on

on w_nazione_lt.destroy
call super::destroy
end on

type p_msg_log from w_list_main`p_msg_log within w_nazione_lt
end type

type p_crescente from w_list_main`p_crescente within w_nazione_lt
end type

type p_decrescente from w_list_main`p_decrescente within w_nazione_lt
end type

type dw_list from w_list_main`dw_list within w_nazione_lt
integer width = 4494
string dataobject = "d_nazione_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Nazioni"
is_resp_window = "w_nazione_ff"
end event

