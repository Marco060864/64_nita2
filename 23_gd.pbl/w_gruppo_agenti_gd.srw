forward
global type w_gruppo_agenti_gd from w_np_single_data
end type
end forward

global type w_gruppo_agenti_gd from w_np_single_data
int Width=1756
boolean TitleBar=true
string Title="Gruppo Agenti"
end type
global w_gruppo_agenti_gd w_gruppo_agenti_gd

on w_gruppo_agenti_gd.create
call w_np_single_data::create
end on

on w_gruppo_agenti_gd.destroy
call w_np_single_data::destroy
end on

type dw_single from w_np_single_data`dw_single within w_gruppo_agenti_gd
int Width=1623
string DataObject="d_gruppo_agenti_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Gruppo Agenti"
end event

