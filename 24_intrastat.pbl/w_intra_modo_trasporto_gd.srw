forward
global type w_intra_modo_trasporto_gd from w_np_single_data
end type
end forward

global type w_intra_modo_trasporto_gd from w_np_single_data
int X=1047
int Y=652
int Width=1403
int Height=748
boolean TitleBar=true
string Title="Modo Trasporto"
end type
global w_intra_modo_trasporto_gd w_intra_modo_trasporto_gd

event open;call super::open;
il_HelpTopic = 64
end event

on w_intra_modo_trasporto_gd.create
call super::create
end on

on w_intra_modo_trasporto_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_intra_modo_trasporto_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_intra_modo_trasporto_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_intra_modo_trasporto_gd
int X=18
int Y=20
int Width=1339
int Height=612
string DataObject="d_intra_modo_trasporto_gd"
end type

