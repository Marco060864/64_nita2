forward
global type w_mastro_gd from w_np_single_data
end type
end forward

global type w_mastro_gd from w_np_single_data
int Width=1943
boolean TitleBar=true
string Title="Mastri"
end type
global w_mastro_gd w_mastro_gd

on w_mastro_gd.create
call w_np_single_data::create
end on

on w_mastro_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_mastro_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_mastro_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_mastro_gd
int Width=1806
string DataObject="d_mastro_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Mastro"
end event

