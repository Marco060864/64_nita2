forward
global type w_cat_com_sc_gd from w_np_single_data
end type
end forward

global type w_cat_com_sc_gd from w_np_single_data
int Width=1527
boolean TitleBar=true
string Title="Categorie Commerciali"
end type
global w_cat_com_sc_gd w_cat_com_sc_gd

on w_cat_com_sc_gd.create
call w_np_single_data::create
end on

on w_cat_com_sc_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 110

end event

type p_crescente from w_np_single_data`p_crescente within w_cat_com_sc_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_cat_com_sc_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_cat_com_sc_gd
int Width=1395
string DataObject="d_cat_com_sc_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Categorie Commerciali"
end event

