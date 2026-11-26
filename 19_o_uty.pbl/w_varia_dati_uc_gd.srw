forward
global type w_varia_dati_uc_gd from w_np_single_data
end type
end forward

global type w_varia_dati_uc_gd from w_np_single_data
integer width = 3397
integer height = 1832
end type
global w_varia_dati_uc_gd w_varia_dati_uc_gd

on w_varia_dati_uc_gd.create
call super::create
end on

on w_varia_dati_uc_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_varia_dati_uc_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_varia_dati_uc_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_varia_dati_uc_gd
end type

type dw_single from w_np_single_data`dw_single within w_varia_dati_uc_gd
integer width = 3246
integer height = 1564
string dataobject = "d_varia_uc_gd"
end type

