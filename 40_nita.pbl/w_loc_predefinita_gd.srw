forward
global type w_loc_predefinita_gd from w_np_single_data
end type
end forward

global type w_loc_predefinita_gd from w_np_single_data
int Width=1262
boolean TitleBar=true
string Title="Locazioni Predefinite"
end type
global w_loc_predefinita_gd w_loc_predefinita_gd

on w_loc_predefinita_gd.create
call w_np_single_data::create
end on

on w_loc_predefinita_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_loc_predefinita_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_loc_predefinita_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_loc_predefinita_gd
int Width=1121
string DataObject="d_loc_predefinita_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Locazioni Predefinite"
end event

