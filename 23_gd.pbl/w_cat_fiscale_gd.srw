forward
global type w_cat_fiscale_gd from w_np_single_data
end type
end forward

global type w_cat_fiscale_gd from w_np_single_data
int Width=1353
int Height=860
boolean TitleBar=true
string Title="Categorie Fiscali"
end type
global w_cat_fiscale_gd w_cat_fiscale_gd

on w_cat_fiscale_gd.create
call super::create
end on

on w_cat_fiscale_gd.destroy
call super::destroy
end on

event open;call super::open;il_HelpTopic = 86
end event

type p_crescente from w_np_single_data`p_crescente within w_cat_fiscale_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_cat_fiscale_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_cat_fiscale_gd
int Width=1225
string DataObject="d_cat_fiscale_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Categorie Fiscali"
end event

