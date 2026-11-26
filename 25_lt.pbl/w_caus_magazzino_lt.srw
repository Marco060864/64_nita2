forward
global type w_caus_magazzino_lt from w_list_main
end type
end forward

global type w_caus_magazzino_lt from w_list_main
int Width=1729
boolean TitleBar=true
string Title="Causali Magazzino"
end type
global w_caus_magazzino_lt w_caus_magazzino_lt

event open;call super::open;il_HelpTopic = 75
ias_key_name[1] = "id_caus_magazzino"
end event

on w_caus_magazzino_lt.create
call w_list_main::create
end on

on w_caus_magazzino_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_caus_magazzino_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_caus_magazzino_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_caus_magazzino_lt
int Width=1623
string DataObject="d_caus_magazzino_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Causali Magazzino"
is_resp_window = "w_caus_magazzino_ff"
end event

