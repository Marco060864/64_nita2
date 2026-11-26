forward
global type w_anagrafica_lt from w_list_main
end type
end forward

global type w_anagrafica_lt from w_list_main
int X=430
int Y=425
int Width=2798
boolean TitleBar=true
string Title="Anagrafiche Condivise"
end type
global w_anagrafica_lt w_anagrafica_lt

event open;call super::open;il_HelpTopic = 11

ias_key_name[1] = "id_anagrafica"
end event

on w_anagrafica_lt.create
call w_list_main::create
end on

on w_anagrafica_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_anagrafica_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_anagrafica_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_anagrafica_lt
int Width=2675
string DataObject="d_anagrafica_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Anagrafiche"
is_resp_window = "w_anagrafica_cx"
end event

