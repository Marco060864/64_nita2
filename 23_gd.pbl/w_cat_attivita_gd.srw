forward
global type w_cat_attivita_gd from w_np_single_data
end type
end forward

global type w_cat_attivita_gd from w_np_single_data
int Width=1527
int Height=853
boolean TitleBar=true
string Title="Categorie Attività"
end type
global w_cat_attivita_gd w_cat_attivita_gd

on w_cat_attivita_gd.create
call w_np_single_data::create
end on

on w_cat_attivita_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 103

end event

type p_crescente from w_np_single_data`p_crescente within w_cat_attivita_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_cat_attivita_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_cat_attivita_gd
int Width=1418
string DataObject="d_cat_attivita_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Categorie Attività"
end event

