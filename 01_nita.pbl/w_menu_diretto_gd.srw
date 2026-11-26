forward
global type w_menu_diretto_gd from w_np_single_data
end type
end forward

global type w_menu_diretto_gd from w_np_single_data
integer width = 3488
integer height = 1452
end type
global w_menu_diretto_gd w_menu_diretto_gd

on w_menu_diretto_gd.create
call super::create
end on

on w_menu_diretto_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_menu_diretto_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_menu_diretto_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_menu_diretto_gd
end type

type dw_single from w_np_single_data`dw_single within w_menu_diretto_gd
integer width = 3365
integer height = 1280
string dataobject = "d_menu_diretto_gd"
end type

