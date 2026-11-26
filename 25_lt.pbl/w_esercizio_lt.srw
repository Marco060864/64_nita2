forward
global type w_esercizio_lt from w_list_main
end type
end forward

global type w_esercizio_lt from w_list_main
int Width=2172
boolean TitleBar=true
string Title="Esercizi Contabili dell'Azienda"
end type
global w_esercizio_lt w_esercizio_lt

event open;call super::open;ias_key_name[1] = "ID_Esercizio"
il_HelpTopic = 74
end event

on w_esercizio_lt.create
call w_list_main::create
end on

on w_esercizio_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_esercizio_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_esercizio_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_esercizio_lt
int X=42
int Width=2026
string DataObject="d_esercizio_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Esercizi Contabili"
is_resp_window = "w_esercizio_cx"
end event

