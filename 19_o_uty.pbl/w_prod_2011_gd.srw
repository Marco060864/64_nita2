forward
global type w_prod_2011_gd from w_np_single_data
end type
end forward

global type w_prod_2011_gd from w_np_single_data
end type
global w_prod_2011_gd w_prod_2011_gd

on w_prod_2011_gd.create
call super::create
end on

on w_prod_2011_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_prod_2011_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_prod_2011_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_prod_2011_gd
end type

type dw_single from w_np_single_data`dw_single within w_prod_2011_gd
string dataobject = "d_produzione_2011_gd"
end type

