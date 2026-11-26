forward
global type w_tributo_lt from w_list_main
end type
end forward

global type w_tributo_lt from w_list_main
int Width=2963
boolean TitleBar=true
string Title="Tributi"
end type
global w_tributo_lt w_tributo_lt

event open;call super::open;
il_HelpTopic = 83

ias_key_name[1] = "id_tributo"
end event

on w_tributo_lt.create
call w_list_main::create
end on

on w_tributo_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_tributo_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_tributo_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_tributo_lt
int Width=2835
string DataObject="d_tributo_lt"
end type

event dw_list::ue_init;call super::ue_init;is_resp_window = "w_tributo_ff"
is_title = "Tributi"
end event

