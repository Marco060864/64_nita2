forward
global type w_sottomastro_gd from w_np_single_data
end type
end forward

global type w_sottomastro_gd from w_np_single_data
int X=430
int Y=425
int Width=2117
boolean TitleBar=true
string Title="Sottomastri"
end type
global w_sottomastro_gd w_sottomastro_gd

on w_sottomastro_gd.create
call w_np_single_data::create
end on

on w_sottomastro_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_sottomastro_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_sottomastro_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_sottomastro_gd
int Width=1966
string DataObject="d_sottomastro_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Sottomastri"
end event

