forward
global type w_arrotondamento_gd from w_np_single_data
end type
end forward

global type w_arrotondamento_gd from w_np_single_data
int Width=2519
boolean TitleBar=true
string Title="Arrotondamenti"
end type
global w_arrotondamento_gd w_arrotondamento_gd

on w_arrotondamento_gd.create
call w_np_single_data::create
end on

on w_arrotondamento_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_arrotondamento_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_arrotondamento_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_arrotondamento_gd
int Width=2401
string DataObject="d_arrotondamento_gd"
end type

