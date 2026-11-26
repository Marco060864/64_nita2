forward
global type w_tab_iva_lt from w_list_main
end type
end forward

global type w_tab_iva_lt from w_list_main
int X=343
int Y=425
int Width=2798
boolean TitleBar=true
string Title="Aliquote IVA"
end type
global w_tab_iva_lt w_tab_iva_lt

on w_tab_iva_lt.create
call w_list_main::create
end on

on w_tab_iva_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;
il_HelpTopic = 89

ias_key_name[1] = "id_tab_iva"
end event

type p_crescente from w_list_main`p_crescente within w_tab_iva_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_tab_iva_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_tab_iva_lt
int Width=2675
string DataObject="d_tab_iva_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Aliquote IVA"
is_resp_window = "w_tab_iva_ff"
end event

