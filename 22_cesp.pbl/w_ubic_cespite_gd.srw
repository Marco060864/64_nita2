forward
global type w_ubic_cespite_gd from w_np_single_data
end type
end forward

global type w_ubic_cespite_gd from w_np_single_data
int Width=2798
boolean TitleBar=true
string Title="Ubicazioni Cespiti"
end type
global w_ubic_cespite_gd w_ubic_cespite_gd

on w_ubic_cespite_gd.create
call w_np_single_data::create
end on

on w_ubic_cespite_gd.destroy
call w_np_single_data::destroy
end on

type dw_single from w_np_single_data`dw_single within w_ubic_cespite_gd
int Width=2675
string DataObject="d_ubic_cespite_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Ubicazioni Cespiti"
end event

