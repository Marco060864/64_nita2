forward
global type w_des_contabile_gd from w_np_single_data
end type
end forward

global type w_des_contabile_gd from w_np_single_data
int Width=1308
boolean TitleBar=true
string Title="Descrizioni Contabili"
end type
global w_des_contabile_gd w_des_contabile_gd

on w_des_contabile_gd.create
call w_np_single_data::create
end on

on w_des_contabile_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 98

end event

type p_crescente from w_np_single_data`p_crescente within w_des_contabile_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_des_contabile_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_des_contabile_gd
int Width=1189
string DataObject="d_des_contabile_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Descrizioni Contabili"
end event

