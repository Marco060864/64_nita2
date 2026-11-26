forward
global type w_valuta_gd from w_np_single_data
end type
end forward

global type w_valuta_gd from w_np_single_data
integer x = 430
integer y = 424
integer width = 3442
integer height = 860
string title = "Valute"
end type
global w_valuta_gd w_valuta_gd

on w_valuta_gd.create
call super::create
end on

on w_valuta_gd.destroy
call super::destroy
end on

event open;call super::open;
il_HelpTopic = 386

end event

type p_msg_log from w_np_single_data`p_msg_log within w_valuta_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_valuta_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_valuta_gd
end type

type dw_single from w_np_single_data`dw_single within w_valuta_gd
integer width = 3301
string dataobject = "d_valuta_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Valute"
end event

