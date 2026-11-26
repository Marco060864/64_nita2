forward
global type w_azienda_lt from w_list_main
end type
end forward

global type w_azienda_lt from w_list_main
int Width=2524
int Height=1229
boolean TitleBar=true
string Title="Azienda"
end type
global w_azienda_lt w_azienda_lt

type variables

end variables

on w_azienda_lt.create
call w_list_main::create
end on

on w_azienda_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;
il_HelpTopic = 71

ias_key_name[1] = "id_azienda"
end event

type p_crescente from w_list_main`p_crescente within w_azienda_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_azienda_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_azienda_lt
int Width=2401
int TabOrder=10
string DataObject="d_azienda_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Azienda"
is_resp_window = "w_azienda_cx"


end event

