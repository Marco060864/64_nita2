forward
global type w_caus_trasporto_gd from w_np_single_data
end type
end forward

global type w_caus_trasporto_gd from w_np_single_data
int Width=1569
boolean TitleBar=true
string Title="Causali Trasporto"
end type
global w_caus_trasporto_gd w_caus_trasporto_gd

on w_caus_trasporto_gd.create
call w_np_single_data::create
end on

on w_caus_trasporto_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;il_HelpTopic = 90
end event

type p_crescente from w_np_single_data`p_crescente within w_caus_trasporto_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_caus_trasporto_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_caus_trasporto_gd
int Width=1441
string DataObject="d_caus_trasporto_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Causali Trasporto"
end event

