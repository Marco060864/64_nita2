forward
global type w_reparto_gd from w_np_single_data
end type
end forward

global type w_reparto_gd from w_np_single_data
int Width=1550
boolean TitleBar=true
string Title="Reparti"
end type
global w_reparto_gd w_reparto_gd

on w_reparto_gd.create
call w_np_single_data::create
end on

on w_reparto_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;il_HelpTopic = 594
end event

type p_crescente from w_np_single_data`p_crescente within w_reparto_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_reparto_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_reparto_gd
int Width=1418
string DataObject="d_reparto_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Reparti"
end event

