forward
global type w_ricarico_gd from w_np_single_data
end type
end forward

global type w_ricarico_gd from w_np_single_data
integer width = 2034
integer height = 904
string title = "Fasce di Ricarico"
long backcolor = 80269524
end type
global w_ricarico_gd w_ricarico_gd

on w_ricarico_gd.create
call super::create
end on

on w_ricarico_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_ricarico_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_ricarico_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_ricarico_gd
end type

type dw_single from w_np_single_data`dw_single within w_ricarico_gd
integer width = 1888
string dataobject = "d_ricarico_gd"
end type

