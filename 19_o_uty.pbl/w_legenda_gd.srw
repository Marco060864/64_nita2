forward
global type w_legenda_gd from w_np_single_data
end type
end forward

global type w_legenda_gd from w_np_single_data
int Width=2103
WindowType WindowType=popup!
boolean TitleBar=true
string Title="Legenda Finestra Documento"
boolean MaxBox=false
end type
global w_legenda_gd w_legenda_gd

on w_legenda_gd.create
call super::create
end on

on w_legenda_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_legenda_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_legenda_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_legenda_gd
int Width=1998
string DataObject="d_legenda_gd"
end type

