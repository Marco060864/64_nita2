forward
global type w_car_sociale_gd from w_np_single_data
end type
end forward

global type w_car_sociale_gd from w_np_single_data
int Width=1326
boolean TitleBar=true
string Title="Cariche Sociali"
end type
global w_car_sociale_gd w_car_sociale_gd

on w_car_sociale_gd.create
call w_np_single_data::create
end on

on w_car_sociale_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 97

end event

type p_crescente from w_np_single_data`p_crescente within w_car_sociale_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_car_sociale_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_car_sociale_gd
int Width=1212
string DataObject="d_car_sociale_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Cariche Sociali"
end event

