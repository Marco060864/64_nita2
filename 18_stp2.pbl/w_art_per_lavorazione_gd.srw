forward
global type w_art_per_lavorazione_gd from w_np_single_data
end type
end forward

global type w_art_per_lavorazione_gd from w_np_single_data
integer width = 2405
integer height = 1288
end type
global w_art_per_lavorazione_gd w_art_per_lavorazione_gd

on w_art_per_lavorazione_gd.create
call super::create
end on

on w_art_per_lavorazione_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_art_per_lavorazione_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_art_per_lavorazione_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_art_per_lavorazione_gd
end type

type dw_single from w_np_single_data`dw_single within w_art_per_lavorazione_gd
integer width = 2254
integer height = 1092
string dataobject = "d_art_per_lavorazione_gd"
end type

