forward
global type w_tipo_magazzino_gd from w_np_single_data
end type
end forward

global type w_tipo_magazzino_gd from w_np_single_data
boolean TitleBar=true
string Title="Tipi di magazzini"
end type
global w_tipo_magazzino_gd w_tipo_magazzino_gd

event open;call super::open;
il_HelpTopic = 42
end event

on w_tipo_magazzino_gd.create
call w_np_single_data::create
end on

on w_tipo_magazzino_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_tipo_magazzino_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_tipo_magazzino_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_tipo_magazzino_gd
string DataObject="d_tipo_magazzino_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Tipi di magazzini"
end event

