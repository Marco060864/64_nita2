forward
global type w_wizard_gd from w_np_single_data
end type
end forward

global type w_wizard_gd from w_np_single_data
int Width=2990
boolean TitleBar=true
string Title="Wizard"
end type
global w_wizard_gd w_wizard_gd

on w_wizard_gd.create
call w_np_single_data::create
end on

on w_wizard_gd.destroy
call w_np_single_data::destroy
end on

type dw_single from w_np_single_data`dw_single within w_wizard_gd
int Width=2858
string DataObject="d_wizard_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Wizard"
end event

