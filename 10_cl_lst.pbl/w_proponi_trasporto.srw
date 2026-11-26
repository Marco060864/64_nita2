forward
global type w_proponi_trasporto from w_np_single_data
end type
end forward

global type w_proponi_trasporto from w_np_single_data
integer width = 4334
integer height = 1432
end type
global w_proponi_trasporto w_proponi_trasporto

on w_proponi_trasporto.create
call super::create
end on

on w_proponi_trasporto.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_proponi_trasporto
end type

type p_crescente from w_np_single_data`p_crescente within w_proponi_trasporto
end type

type p_decrescente from w_np_single_data`p_decrescente within w_proponi_trasporto
end type

type dw_single from w_np_single_data`dw_single within w_proponi_trasporto
integer width = 4187
integer height = 1212
string dataobject = "d_proponi_trasporto"
end type

