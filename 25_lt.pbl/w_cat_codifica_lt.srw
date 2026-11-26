forward
global type w_cat_codifica_lt from w_list_main
end type
end forward

global type w_cat_codifica_lt from w_list_main
int Width=2323
boolean TitleBar=true
string Title="Categorie di Codifica"
end type
global w_cat_codifica_lt w_cat_codifica_lt

event open;call super::open;il_HelpTopic = 106
ias_key_name[1] = "id_cat_codifica"

end event

on w_cat_codifica_lt.create
call w_list_main::create
end on

on w_cat_codifica_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_cat_codifica_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_cat_codifica_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_cat_codifica_lt
int Width=2172
string DataObject="d_cat_codifica_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Categorie Codifica"
is_resp_window = "w_cat_codifica_cx"

end event

