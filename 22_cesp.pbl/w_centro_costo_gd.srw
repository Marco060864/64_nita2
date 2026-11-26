forward
global type w_centro_costo_gd from w_np_single_data
end type
end forward

global type w_centro_costo_gd from w_np_single_data
int Width=1747
boolean TitleBar=true
string Title="Centri di Costo"
end type
global w_centro_costo_gd w_centro_costo_gd

on w_centro_costo_gd.create
call w_np_single_data::create
end on

on w_centro_costo_gd.destroy
call w_np_single_data::destroy
end on

type dw_single from w_np_single_data`dw_single within w_centro_costo_gd
int Width=1623
string DataObject="d_centro_costo_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Centri di Costo"
end event

