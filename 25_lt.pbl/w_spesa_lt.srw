forward
global type w_spesa_lt from w_list_main
end type
end forward

global type w_spesa_lt from w_list_main
int Width=2963
boolean TitleBar=true
string Title="Spesa"
end type
global w_spesa_lt w_spesa_lt

on w_spesa_lt.create
call w_list_main::create
end on

on w_spesa_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;
il_HelpTopic = 388

ias_key_name[1]="id_spesa"
end event

type p_crescente from w_list_main`p_crescente within w_spesa_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_spesa_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_spesa_lt
int Width=2835
string DataObject="d_spesa_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Spese"
is_resp_window = "w_spesa_ff"
end event

