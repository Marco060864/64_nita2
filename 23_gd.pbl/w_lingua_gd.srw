forward
global type w_lingua_gd from w_np_single_data
end type
end forward

global type w_lingua_gd from w_np_single_data
int Width=1623
boolean TitleBar=true
string Title="Lingue"
end type
global w_lingua_gd w_lingua_gd

on w_lingua_gd.create
call w_np_single_data::create
end on

on w_lingua_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 385
end event

type p_crescente from w_np_single_data`p_crescente within w_lingua_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_lingua_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_lingua_gd
int Width=1486
string DataObject="d_lingua_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Lingue"
end event

