forward
global type w_prof_registrazione_lt from w_list_main
end type
end forward

global type w_prof_registrazione_lt from w_list_main
int Width=2858
boolean TitleBar=true
string Title="Profili Registrazioni Contabili"
end type
global w_prof_registrazione_lt w_prof_registrazione_lt

event open;call super::open;il_HelpTopic = 76

ias_key_name[1] = "ID_Prof_Registrazione"
end event

on w_prof_registrazione_lt.create
call w_list_main::create
end on

on w_prof_registrazione_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_prof_registrazione_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_prof_registrazione_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_prof_registrazione_lt
int Width=2743
string DataObject="d_prof_registrazione_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Profili per Registrazioni Contabili"
is_resp_window = "w_prof_registrazione_cx"
end event

