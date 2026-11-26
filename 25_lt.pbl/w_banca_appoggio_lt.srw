forward
global type w_banca_appoggio_lt from w_list_main
end type
end forward

global type w_banca_appoggio_lt from w_list_main
int Width=2922
boolean TitleBar=true
string Title="Banche di Appoggio"
end type
global w_banca_appoggio_lt w_banca_appoggio_lt

event open;call super::open;
il_HelpTopic = 82

ias_key_name[1] = "ID_Banca_Appoggio"
end event

on w_banca_appoggio_lt.create
call w_list_main::create
end on

on w_banca_appoggio_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_banca_appoggio_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_banca_appoggio_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_banca_appoggio_lt
int Width=2812
string DataObject="d_banca_appoggio_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Banche di Appoggio"
is_resp_window = "w_banca_appoggio_ff"
end event

