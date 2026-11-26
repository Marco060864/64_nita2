forward
global type w_gruppo_articoli_gd from w_np_single_data
end type
end forward

global type w_gruppo_articoli_gd from w_np_single_data
int Width=2409
boolean TitleBar=true
string Title="Gruppi Articoli"
end type
global w_gruppo_articoli_gd w_gruppo_articoli_gd

on w_gruppo_articoli_gd.create
call super::create
end on

on w_gruppo_articoli_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_gruppo_articoli_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_gruppo_articoli_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_gruppo_articoli_gd
int Width=2286
string DataObject="d_gruppo_articoli_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Gruppi Articoli"
end event

