forward
global type w_lega_lis_cl_fo from w_np_single_data
end type
end forward

global type w_lega_lis_cl_fo from w_np_single_data
integer width = 3218
integer height = 1251
end type
global w_lega_lis_cl_fo w_lega_lis_cl_fo

on w_lega_lis_cl_fo.create
call super::create
end on

on w_lega_lis_cl_fo.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_lega_lis_cl_fo
end type

type p_crescente from w_np_single_data`p_crescente within w_lega_lis_cl_fo
end type

type p_decrescente from w_np_single_data`p_decrescente within w_lega_lis_cl_fo
end type

type dw_single from w_np_single_data`dw_single within w_lega_lis_cl_fo
integer x = 29
integer y = 26
integer width = 3043
integer height = 1050
string dataobject = "d_lega_lis_cl_fo_righe"
end type

