forward
global type w_unita_misura_gd from w_np_single_data
end type
end forward

global type w_unita_misura_gd from w_np_single_data
int X=539
int Y=764
int Width=2953
int Height=868
boolean TitleBar=true
string Title="Unità di Misura"
end type
global w_unita_misura_gd w_unita_misura_gd

on w_unita_misura_gd.create
call super::create
end on

on w_unita_misura_gd.destroy
call super::destroy
end on

event open;call super::open;il_HelpTopic = 93
end event

type p_crescente from w_np_single_data`p_crescente within w_unita_misura_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_unita_misura_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_unita_misura_gd
int X=23
int Width=2857
string DataObject="d_unita_misura_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Unità di Misura"
end event

