forward
global type w_orafo_tipo_partita_gd from w_np_single_data
end type
end forward

global type w_orafo_tipo_partita_gd from w_np_single_data
int Width=1715
end type
global w_orafo_tipo_partita_gd w_orafo_tipo_partita_gd

on w_orafo_tipo_partita_gd.create
call w_np_single_data::create
end on

on w_orafo_tipo_partita_gd.destroy
call w_np_single_data::destroy
end on

event resize;
end event

type p_crescente from w_np_single_data`p_crescente within w_orafo_tipo_partita_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_orafo_tipo_partita_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_orafo_tipo_partita_gd
int Width=1601
string DataObject="d_orafo_tipo_partita_gd"
end type

