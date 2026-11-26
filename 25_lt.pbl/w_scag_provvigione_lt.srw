forward
global type w_scag_provvigione_lt from w_list_main
end type
end forward

global type w_scag_provvigione_lt from w_list_main
int Width=2437
boolean TitleBar=true
string Title="Scaglioni di Provvigione"
end type
global w_scag_provvigione_lt w_scag_provvigione_lt

on w_scag_provvigione_lt.create
call w_list_main::create
end on

on w_scag_provvigione_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;il_helpTopic = 528
ias_key_name[1] = "id_gruppo_agenti"
end event

type p_crescente from w_list_main`p_crescente within w_scag_provvigione_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_scag_provvigione_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_scag_provvigione_lt
int Width=2309
string DataObject="d_gruppo_agenti_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Gruppo Agenti"
is_resp_window = "w_scag_provvigione_cx"
end event

