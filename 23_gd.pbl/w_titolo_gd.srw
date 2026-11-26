forward
global type w_titolo_gd from w_np_single_data
end type
end forward

global type w_titolo_gd from w_np_single_data
int Width=1308
boolean TitleBar=true
string Title="Titoli"
end type
global w_titolo_gd w_titolo_gd

on w_titolo_gd.create
call w_np_single_data::create
end on

on w_titolo_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 87

end event

type p_crescente from w_np_single_data`p_crescente within w_titolo_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_titolo_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_titolo_gd
int Width=1189
string DataObject="d_titolo_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Titoli"
end event

