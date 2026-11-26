forward
global type w_ins_gruppo_articoli_gd from w_np_single_data
end type
end forward

global type w_ins_gruppo_articoli_gd from w_np_single_data
integer width = 2871
integer height = 1988
end type
global w_ins_gruppo_articoli_gd w_ins_gruppo_articoli_gd

on w_ins_gruppo_articoli_gd.create
call super::create
end on

on w_ins_gruppo_articoli_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_ins_gruppo_articoli_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_ins_gruppo_articoli_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_ins_gruppo_articoli_gd
end type

type dw_single from w_np_single_data`dw_single within w_ins_gruppo_articoli_gd
integer x = 41
integer width = 2747
integer height = 1816
string dataobject = "d_ins_gruppo_articoli"
end type

