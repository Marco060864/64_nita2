forward
global type w_locazione_lt from w_list_main
end type
end forward

global type w_locazione_lt from w_list_main
int Width=2986
boolean TitleBar=true
string Title="Locazioni"
end type
global w_locazione_lt w_locazione_lt

on w_locazione_lt.create
call w_list_main::create
end on

on w_locazione_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;ias_key_name[1] = "id_locazione"
end event

type p_crescente from w_list_main`p_crescente within w_locazione_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_locazione_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_locazione_lt
int Width=2812
string DataObject="d_locazione_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Locazioni"
end event

