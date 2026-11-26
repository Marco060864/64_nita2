forward
global type w_tab_iva_gd from w_np_single_data
end type
end forward

global type w_tab_iva_gd from w_np_single_data
int Width=2913
boolean TitleBar=true
string Title="Tabella IVA"
end type
global w_tab_iva_gd w_tab_iva_gd

on w_tab_iva_gd.create
call w_np_single_data::create
end on

on w_tab_iva_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_tab_iva_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_tab_iva_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_tab_iva_gd
int X=23
int Y=21
int Width=2812
string DataObject="d_tab_iva_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Tebella IVA"
end event

