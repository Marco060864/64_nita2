forward
global type w_fornitore_articolo_gd from w_np_single_data
end type
end forward

global type w_fornitore_articolo_gd from w_np_single_data
integer width = 2523
end type
global w_fornitore_articolo_gd w_fornitore_articolo_gd

on w_fornitore_articolo_gd.create
call super::create
end on

on w_fornitore_articolo_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_fornitore_articolo_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_fornitore_articolo_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_fornitore_articolo_gd
end type

type dw_single from w_np_single_data`dw_single within w_fornitore_articolo_gd
integer width = 2392
string dataobject = "d_fornitore_articolo_gd"
end type

