forward
global type w_magazzino_lt from w_list_main
end type
end forward

global type w_magazzino_lt from w_list_main
int Width=2625
boolean TitleBar=true
string Title="Magazzini"
end type
global w_magazzino_lt w_magazzino_lt

event open;call super::open;il_HelpTopic = 109
ias_key_name[1] = "id_magazzino"
end event

on w_magazzino_lt.create
call w_list_main::create
end on

on w_magazzino_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_magazzino_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_magazzino_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_magazzino_lt
int Width=2515
string DataObject="d_magazzino_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Magazzini"
is_resp_window = "w_magazzino_ff"
end event

