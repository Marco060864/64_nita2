forward
global type w_banca_azienda_lt from w_list_main
end type
end forward

global type w_banca_azienda_lt from w_list_main
boolean TitleBar=true
string Title="Banche dell'Azienda"
end type
global w_banca_azienda_lt w_banca_azienda_lt

on w_banca_azienda_lt.create
call w_list_main::create
end on

on w_banca_azienda_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;
il_HelpTopic = 72

ias_key_name[1] = "id_banca_azienda"
end event

type p_crescente from w_list_main`p_crescente within w_banca_azienda_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_banca_azienda_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_banca_azienda_lt
string DataObject="d_banca_azienda_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Banca Azienda"
is_resp_window = "w_banca_azienda_cx"


end event

