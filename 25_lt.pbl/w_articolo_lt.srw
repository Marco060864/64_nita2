forward
global type w_articolo_lt from w_list_main
end type
end forward

global type w_articolo_lt from w_list_main
int X=69
int Y=433
int Width=2798
boolean TitleBar=true
string Title="Articoli"
end type
global w_articolo_lt w_articolo_lt

event open;call super::open;il_HelpTopic = 45
ias_key_name[1] = "id_articolo"
end event

on w_articolo_lt.create
call w_list_main::create
end on

on w_articolo_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_articolo_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_articolo_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_articolo_lt
int Width=2675
string DataObject="d_articolo_lt"
end type

event dw_list::ue_init;call super::ue_init;is_resp_window = "w_articolo_cx"
end event

