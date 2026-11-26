forward
global type w_area_gd from w_np_single_data
end type
end forward

global type w_area_gd from w_np_single_data
int Width=2204
boolean TitleBar=true
string Title="Aree di Magazzino"
end type
global w_area_gd w_area_gd

on w_area_gd.create
call w_np_single_data::create
end on

on w_area_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_area_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_area_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_area_gd
int Width=2076
string DataObject="d_area_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Aree Magazzino"
end event

