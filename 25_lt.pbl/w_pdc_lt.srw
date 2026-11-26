forward
global type w_pdc_lt from w_list_main
end type
end forward

global type w_pdc_lt from w_list_main
int X=97
int Y=449
int Width=1523
int Height=985
boolean TitleBar=true
string Title="Inserimento Piano dei Conti"
end type
global w_pdc_lt w_pdc_lt

on w_pdc_lt.create
call w_list_main::create
end on

on w_pdc_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;il_HelpTopic = 191
ias_key_name[1] = "id_pdc"
end event

type p_crescente from w_list_main`p_crescente within w_pdc_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_pdc_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_pdc_lt
int Width=1395
int Height=801
string DataObject="d_pdc_gd"
end type

event dw_list::ue_init;call super::ue_init;
is_title = "Inserimento Piano dei Conti"
is_resp_window = "w_pdc_cx"
end event

