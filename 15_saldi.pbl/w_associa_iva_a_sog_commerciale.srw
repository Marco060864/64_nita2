forward
global type w_associa_iva_a_sog_commerciale from w_np_single_data
end type
end forward

global type w_associa_iva_a_sog_commerciale from w_np_single_data
integer width = 2198
integer height = 1626
end type
global w_associa_iva_a_sog_commerciale w_associa_iva_a_sog_commerciale

on w_associa_iva_a_sog_commerciale.create
call super::create
end on

on w_associa_iva_a_sog_commerciale.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_associa_iva_a_sog_commerciale
end type

type p_crescente from w_np_single_data`p_crescente within w_associa_iva_a_sog_commerciale
end type

type p_decrescente from w_np_single_data`p_decrescente within w_associa_iva_a_sog_commerciale
end type

type dw_single from w_np_single_data`dw_single within w_associa_iva_a_sog_commerciale
integer x = 29
integer y = 26
integer width = 2019
integer height = 1434
string dataobject = "d_associa_iva_a_sog_commerciale"
end type

