forward
global type w_lega_gd from w_np_single_data
end type
end forward

global type w_lega_gd from w_np_single_data
int Width=2117
boolean TitleBar=true
string Title="Lega"
end type
global w_lega_gd w_lega_gd

on w_lega_gd.create
call super::create
end on

on w_lega_gd.destroy
call super::destroy
end on

type dw_single from w_np_single_data`dw_single within w_lega_gd
int X=37
int Width=2007
string DataObject="d_lega_gd"
end type

