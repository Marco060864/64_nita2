forward
global type w_socio_lt from w_list_main
end type
end forward

global type w_socio_lt from w_list_main
int Width=2798
boolean TitleBar=true
string Title="Soci"
end type
global w_socio_lt w_socio_lt

on w_socio_lt.create
call w_list_main::create
end on

on w_socio_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;ias_key_name[1] = "id_socio"
end event

type dw_list from w_list_main`dw_list within w_socio_lt
int Width=2675
int Height=901
string DataObject="d_socio_lt"
boolean HScrollBar=true
end type

event dw_list::ue_init;call super::ue_init;is_title = "Soci"
is_resp_window = "w_socio_ff"
end event

