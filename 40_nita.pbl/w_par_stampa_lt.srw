forward
global type w_par_stampa_lt from w_list_main
end type
end forward

global type w_par_stampa_lt from w_list_main
boolean TitleBar=true
string Title="Elenco stampe di sistema"
end type
global w_par_stampa_lt w_par_stampa_lt

on w_par_stampa_lt.create
call w_list_main::create
end on

on w_par_stampa_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;ias_key_name[1]="id_par_stampa"
end event

type p_crescente from w_list_main`p_crescente within w_par_stampa_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_par_stampa_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_par_stampa_lt
string DataObject="d_par_stampa_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Elenco dei parametri di stampa"
is_resp_window = "w_par_stampa_cx"
end event

