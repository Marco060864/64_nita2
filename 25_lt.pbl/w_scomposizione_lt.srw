forward
global type w_scomposizione_lt from w_list_main
end type
end forward

global type w_scomposizione_lt from w_list_main
int Width=1532
boolean TitleBar=true
string Title="Tipi di codice"
end type
global w_scomposizione_lt w_scomposizione_lt

event open;call super::open;il_HelpTopic = 166
ias_key_name[1] = "id_scomposizione"
end event

on w_scomposizione_lt.create
call w_list_main::create
end on

on w_scomposizione_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_scomposizione_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_scomposizione_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_scomposizione_lt
int Width=1418
string DataObject="d_scomposizione_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Tipi di Codice"
is_resp_window = "w_scomposizione_cx"
end event

