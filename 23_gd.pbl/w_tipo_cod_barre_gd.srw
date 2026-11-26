forward
global type w_tipo_cod_barre_gd from w_np_single_data
end type
end forward

global type w_tipo_cod_barre_gd from w_np_single_data
int Width=2295
boolean TitleBar=true
string Title="Tipi Codici a Barre"
end type
global w_tipo_cod_barre_gd w_tipo_cod_barre_gd

on w_tipo_cod_barre_gd.create
call w_np_single_data::create
end on

on w_tipo_cod_barre_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;il_HelpTopic = 96
end event

type p_crescente from w_np_single_data`p_crescente within w_tipo_cod_barre_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_tipo_cod_barre_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_tipo_cod_barre_gd
int Width=2172
string DataObject="d_tipo_cod_barre_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Tipi Codici a Barre"
end event

