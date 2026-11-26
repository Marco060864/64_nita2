forward
global type w_intra_localita_gd from w_np_single_data
end type
end forward

global type w_intra_localita_gd from w_np_single_data
boolean TitleBar=true
string Title="Località"
end type
global w_intra_localita_gd w_intra_localita_gd

on w_intra_localita_gd.create
call super::create
end on

on w_intra_localita_gd.destroy
call super::destroy
end on

event open;call super::open;
end event

type p_crescente from w_np_single_data`p_crescente within w_intra_localita_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_intra_localita_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_intra_localita_gd
string DataObject="d_intra_localita_gd"
end type

