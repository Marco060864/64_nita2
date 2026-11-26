forward
global type w_conto_ges_partite_lt from w_list_main
end type
end forward

global type w_conto_ges_partite_lt from w_list_main
int Width=2967
int Height=1049
boolean TitleBar=true
string Title="Conti che gestiscono partite"
end type
global w_conto_ges_partite_lt w_conto_ges_partite_lt

on w_conto_ges_partite_lt.create
call w_list_main::create
end on

on w_conto_ges_partite_lt.destroy
call w_list_main::destroy
end on

type dw_list from w_list_main`dw_list within w_conto_ges_partite_lt
int Width=2812
string DataObject="d_conto_ges_partite_lt"
boolean HScrollBar=true
end type

event dw_list::ue_init;call super::ue_init;is_title = "Conti che gestiscono partite"
end event

