forward
global type w_ten_scr_contabili_lt from w_list_main
end type
end forward

global type w_ten_scr_contabili_lt from w_list_main
int Width=2698
boolean TitleBar=true
string Title="Tenutari Scritture Contabili"
end type
global w_ten_scr_contabili_lt w_ten_scr_contabili_lt

on w_ten_scr_contabili_lt.create
call w_list_main::create
end on

on w_ten_scr_contabili_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;
il_HelpTopic = 94

ias_key_name[1] = "id_ten_scr_contabili"
end event

type p_crescente from w_list_main`p_crescente within w_ten_scr_contabili_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_ten_scr_contabili_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_ten_scr_contabili_lt
int Width=2583
string DataObject="d_ten_scr_contabili_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Tenutari Scritture Contabili"
is_resp_window = "w_ten_scr_contabili_ff"
end event

