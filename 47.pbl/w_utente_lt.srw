forward
global type w_utente_lt from w_list_main
end type
end forward

global type w_utente_lt from w_list_main
integer width = 2085
string title = "Utenti"
end type
global w_utente_lt w_utente_lt

event open;call super::open;ias_key_name[1] = "id_utenti"
end event

on w_utente_lt.create
call super::create
end on

on w_utente_lt.destroy
call super::destroy
end on

type p_msg_log from w_list_main`p_msg_log within w_utente_lt
end type

type p_crescente from w_list_main`p_crescente within w_utente_lt
end type

type p_decrescente from w_list_main`p_decrescente within w_utente_lt
end type

type dw_list from w_list_main`dw_list within w_utente_lt
integer width = 1915
string dataobject = "d_utente_new_lt"
end type

event dw_list::ue_init;call super::ue_init;is_resp_window = "w_utente_ff"
is_title = "Utenti"
end event

