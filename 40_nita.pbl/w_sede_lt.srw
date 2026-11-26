forward
global type w_sede_lt from w_list_main
end type
end forward

global type w_sede_lt from w_list_main
int Width=2917
boolean TitleBar=true
string Title="Sedi delle Aziende"
end type
global w_sede_lt w_sede_lt

event open;call super::open;ias_key_name[1] = "ID_Sede"
end event

on w_sede_lt.create
call w_list_main::create
end on

on w_sede_lt.destroy
call w_list_main::destroy
end on

type dw_list from w_list_main`dw_list within w_sede_lt
int Width=2812
string DataObject="d_sede_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event dw_list::ue_init;call super::ue_init;is_title = "Sedi delle Aziende"
is_resp_window = "w_sede_ff"
end event

