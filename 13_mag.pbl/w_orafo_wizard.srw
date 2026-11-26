forward
global type w_orafo_wizard from w_np_single_data
end type
end forward

global type w_orafo_wizard from w_np_single_data
int Width=1943
int Height=852
end type
global w_orafo_wizard w_orafo_wizard

on w_orafo_wizard.create
call super::create
end on

on w_orafo_wizard.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_orafo_wizard
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_orafo_wizard
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_orafo_wizard
int Width=1829
string DataObject="d_orafo_wizard"
end type

