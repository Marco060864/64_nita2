forward
global type w_intra_nat_transazione_gd from w_np_single_data
end type
end forward

global type w_intra_nat_transazione_gd from w_np_single_data
int X=951
int Y=676
int Width=1655
int Height=772
boolean TitleBar=true
string Title="Natura Transazione"
end type
global w_intra_nat_transazione_gd w_intra_nat_transazione_gd

event open;call super::open;
il_HelpTopic = 65
end event

on w_intra_nat_transazione_gd.create
call super::create
end on

on w_intra_nat_transazione_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_intra_nat_transazione_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_intra_nat_transazione_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_intra_nat_transazione_gd
int X=27
int Y=4
int Width=1586
int Height=648
string DataObject="d_intra_nat_transazione_gd"
end type

