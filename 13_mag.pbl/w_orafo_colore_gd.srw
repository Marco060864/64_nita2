forward
global type w_orafo_colore_gd from w_np_single_data
end type
end forward

global type w_orafo_colore_gd from w_np_single_data
int Width=1665
int Height=861
boolean TitleBar=true
string Title="Colori Articolo"
end type
global w_orafo_colore_gd w_orafo_colore_gd

on w_orafo_colore_gd.create
call w_np_single_data::create
end on

on w_orafo_colore_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_orafo_colore_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_orafo_colore_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_orafo_colore_gd
int Width=1541
string DataObject="d_orafo_colore_gd"
end type

