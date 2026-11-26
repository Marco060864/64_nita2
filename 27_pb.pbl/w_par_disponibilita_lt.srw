forward
global type w_par_disponibilita_lt from w_list_main
end type
end forward

global type w_par_disponibilita_lt from w_list_main
boolean TitleBar=true
string Title="Parametri di Disponibilità"
end type
global w_par_disponibilita_lt w_par_disponibilita_lt

on w_par_disponibilita_lt.create
call w_list_main::create
end on

on w_par_disponibilita_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;il_HelpTopic = 380
ias_key_name[1]= "id_par_disponibilita"
end event

type p_crescente from w_list_main`p_crescente within w_par_disponibilita_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_par_disponibilita_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_par_disponibilita_lt
string DataObject="d_par_disponibilita_lt"
end type

event dw_list::ue_init;call super::ue_init;is_resp_window="w_par_disponibilita_ff"
is_title="Parametri di Disponibilità"
end event

