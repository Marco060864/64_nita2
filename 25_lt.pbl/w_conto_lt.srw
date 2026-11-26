forward
global type w_conto_lt from w_list_main
end type
end forward

global type w_conto_lt from w_list_main
int Width=2798
int Height=1045
boolean TitleBar=true
string Title="Conti"
end type
global w_conto_lt w_conto_lt

event open;call super::open;ias_key_name[1] = "conto_id_conto"
il_helpTopic = 597
end event

on w_conto_lt.create
call w_list_main::create
end on

on w_conto_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_conto_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_conto_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_conto_lt
int Width=2684
int Height=861
string DataObject="d_conto_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Conti"
is_resp_window = "w_conto_ff"
end event

