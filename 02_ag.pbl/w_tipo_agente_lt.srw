forward
global type w_tipo_agente_lt from w_list_main
end type
end forward

global type w_tipo_agente_lt from w_list_main
int Width=2350
boolean TitleBar=true
string Title="Tipo Agente"
end type
global w_tipo_agente_lt w_tipo_agente_lt

on w_tipo_agente_lt.create
call w_list_main::create
end on

on w_tipo_agente_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;il_HelpTopic = 68
ias_key_name[1] = "id_tipo_agente"
end event

type p_crescente from w_list_main`p_crescente within w_tipo_agente_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_tipo_agente_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_tipo_agente_lt
int Width=2218
string DataObject="d_tipo_agente_lt"
BorderStyle BorderStyle=StyleLowered!
end type

event dw_list::ue_init;call super::ue_init;is_title =  "Tipo Agente"
is_resp_window = "w_tipo_agente_cx"
end event

