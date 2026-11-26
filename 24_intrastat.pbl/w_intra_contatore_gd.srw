forward
global type w_intra_contatore_gd from w_np_single_data
end type
end forward

global type w_intra_contatore_gd from w_np_single_data
int X=306
int Y=564
int Width=2990
int Height=716
boolean TitleBar=true
string Title="Intra_Contatore"
end type
global w_intra_contatore_gd w_intra_contatore_gd

on w_intra_contatore_gd.create
call super::create
end on

on w_intra_contatore_gd.destroy
call super::destroy
end on

event open;call super::open;
il_HelpTopic = 68
end event

type p_crescente from w_np_single_data`p_crescente within w_intra_contatore_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_intra_contatore_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_intra_contatore_gd
int X=37
int Y=0
int Width=2889
int Height=592
string DataObject="d_intra_contatore_gd"
end type

