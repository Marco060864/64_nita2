forward
global type w_pdc_gd from w_np_single_data
end type
end forward

global type w_pdc_gd from w_np_single_data
int X=549
int Y=449
int Width=1550
boolean TitleBar=true
string Title="Piano dei Conti"
end type
global w_pdc_gd w_pdc_gd

on w_pdc_gd.create
call w_np_single_data::create
end on

on w_pdc_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_pdc_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_pdc_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_pdc_gd
int Width=1418
string DataObject="d_pdc_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Piano dei Conti"
end event

