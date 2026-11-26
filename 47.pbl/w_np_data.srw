forward
global type w_np_data from w_data_main
end type
end forward

global type w_np_data from w_data_main
end type
global w_np_data w_np_data

on w_np_data.create
call w_data_main::create
end on

on w_np_data.destroy
call w_data_main::destroy
end on

event open;call super::open;is_wintype = "W_NP_DATA"
end event

type p_crescente from w_data_main`p_crescente within w_np_data
boolean BringToTop=true
end type

type p_decrescente from w_data_main`p_decrescente within w_np_data
boolean BringToTop=true
end type

