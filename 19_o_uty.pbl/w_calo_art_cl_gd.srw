forward
global type w_calo_art_cl_gd from w_np_single_data
end type
end forward

global type w_calo_art_cl_gd from w_np_single_data
integer width = 2359
integer height = 1088
end type
global w_calo_art_cl_gd w_calo_art_cl_gd

on w_calo_art_cl_gd.create
call super::create
end on

on w_calo_art_cl_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_calo_art_cl_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_calo_art_cl_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_calo_art_cl_gd
end type

type dw_single from w_np_single_data`dw_single within w_calo_art_cl_gd
integer width = 2235
integer height = 892
string dataobject = "d_calo_art_cl_gd"
end type

