forward
global type w_orafo_lega_gd from w_np_single_data
end type
end forward

global type w_orafo_lega_gd from w_np_single_data
int Width=1851
boolean TitleBar=true
string Title="LEGHE"
end type
global w_orafo_lega_gd w_orafo_lega_gd

on w_orafo_lega_gd.create
call super::create
end on

on w_orafo_lega_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_orafo_lega_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_orafo_lega_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_orafo_lega_gd
int Width=1733
string DataObject="d_orafo_lega"
end type

