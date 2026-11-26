forward
global type w_localita_lt from w_list_main
end type
end forward

global type w_localita_lt from w_list_main
boolean TitleBar=true
string Title="Località"
end type
global w_localita_lt w_localita_lt

on w_localita_lt.create
call w_list_main::create
end on

on w_localita_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_localita_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_localita_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_localita_lt
string DataObject="d_localita_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Località"
is_resp_window = "w_localita_ff"
end event

