forward
global type w_m_az_lt from w_list_main
end type
end forward

global type w_m_az_lt from w_list_main
int Width=2035
boolean TitleBar=true
string Title="Elenco Aziende disponibili"
end type
global w_m_az_lt w_m_az_lt

on w_m_az_lt.create
call w_list_main::create
end on

on w_m_az_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;ias_key_name[1] = "id_m_az"
end event

type p_crescente from w_list_main`p_crescente within w_m_az_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_m_az_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_m_az_lt
int Width=1875
string DataObject="d_m_az_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Aziende"
is_resp_window = "w_m_az_cx"
end event

