forward
global type w_reg_fiscale_gd from w_np_single_data
end type
end forward

global type w_reg_fiscale_gd from w_np_single_data
int Width=1550
boolean TitleBar=true
string Title="Registri Fiscali"
end type
global w_reg_fiscale_gd w_reg_fiscale_gd

on w_reg_fiscale_gd.create
call w_np_single_data::create
end on

on w_reg_fiscale_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;il_HelpTopic = 92
end event

type p_crescente from w_np_single_data`p_crescente within w_reg_fiscale_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_reg_fiscale_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_reg_fiscale_gd
int Width=1418
string DataObject="d_reg_fiscale_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Registri Fiscali"
end event

