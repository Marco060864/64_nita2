forward
global type w_prof_documento_lt from w_list_main
end type
end forward

global type w_prof_documento_lt from w_list_main
boolean TitleBar=true
string Title="Profili Documenti"
end type
global w_prof_documento_lt w_prof_documento_lt

event open;call super::open;il_HelpTopic = 125
ias_key_name[1] = "id_prof_documento"
end event

on w_prof_documento_lt.create
call w_list_main::create
end on

on w_prof_documento_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_prof_documento_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_prof_documento_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_prof_documento_lt
string DataObject="d_prof_documento_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Profili Documenti"
is_resp_window = "w_prof_documento_cx"
end event

