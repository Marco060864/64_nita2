forward
global type w_parte_regola_gd from w_np_single_data
end type
end forward

global type w_parte_regola_gd from w_np_single_data
int Width=2382
boolean TitleBar=true
string Title="Regole di Codifica"
end type
global w_parte_regola_gd w_parte_regola_gd

on w_parte_regola_gd.create
call w_np_single_data::create
end on

on w_parte_regola_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_parte_regola_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_parte_regola_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_parte_regola_gd
int Width=2263
string DataObject="d_parte_regola_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Regole di Codifica"
end event

