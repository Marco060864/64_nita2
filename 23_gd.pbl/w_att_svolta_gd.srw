forward
global type w_att_svolta_gd from w_np_single_data
end type
end forward

global type w_att_svolta_gd from w_np_single_data
int Width=1564
int Height=985
boolean TitleBar=true
string Title="Attività Svolte"
end type
global w_att_svolta_gd w_att_svolta_gd

on w_att_svolta_gd.create
call w_np_single_data::create
end on

on w_att_svolta_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 84

end event

type p_crescente from w_np_single_data`p_crescente within w_att_svolta_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_att_svolta_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_att_svolta_gd
int Width=1441
int Height=801
string DataObject="d_att_svolta_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Attività Svolta"
end event

