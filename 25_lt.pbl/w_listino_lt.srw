forward
global type w_listino_lt from w_list_main
end type
end forward

global type w_listino_lt from w_list_main
int Width=2679
boolean TitleBar=true
string Title="Listini e Variazioni"
end type
global w_listino_lt w_listino_lt

event open;call super::open;il_HelpTopic = 43

ias_key_name[1] = "id_listino"
end event

on w_listino_lt.create
call w_list_main::create
end on

on w_listino_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_listino_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_listino_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_listino_lt
int Width=2561
string DataObject="d_listino_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Listini e Variazioni"
is_resp_window = "w_listino_cx"
end event

