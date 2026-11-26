forward
global type w_up_conf_oggetti from w_np_single_data
end type
end forward

global type w_up_conf_oggetti from w_np_single_data
int Width=3218
end type
global w_up_conf_oggetti w_up_conf_oggetti

on w_up_conf_oggetti.create
call super::create
end on

on w_up_conf_oggetti.destroy
call super::destroy
end on

type dw_single from w_np_single_data`dw_single within w_up_conf_oggetti
int Width=3072
string DataObject="d_up_conf_oggetti_gd"
end type

