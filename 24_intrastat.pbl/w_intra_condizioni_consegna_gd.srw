forward
global type w_intra_condizioni_consegna_gd from w_np_single_data
end type
end forward

global type w_intra_condizioni_consegna_gd from w_np_single_data
int X=960
int Y=452
int Width=1792
int Height=712
boolean TitleBar=true
string Title="Condizioni di consegna"
end type
global w_intra_condizioni_consegna_gd w_intra_condizioni_consegna_gd

event open;call super::open;
il_HelpTopic = 63
end event

on w_intra_condizioni_consegna_gd.create
call super::create
end on

on w_intra_condizioni_consegna_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_intra_condizioni_consegna_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_intra_condizioni_consegna_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_intra_condizioni_consegna_gd
int X=37
int Y=28
int Width=1701
int Height=564
string DataObject="d_intra_condizioni_consegna_gd"
boolean HScrollBar=false
end type

