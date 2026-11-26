forward
global type w_gruppo_esp_sospeso_lt from w_np_single_data
end type
end forward

global type w_gruppo_esp_sospeso_lt from w_np_single_data
int Width=1335
boolean TitleBar=true
string Title="Gruppi Esposizione Sospesi"
end type
global w_gruppo_esp_sospeso_lt w_gruppo_esp_sospeso_lt

on w_gruppo_esp_sospeso_lt.create
call w_np_single_data::create
end on

on w_gruppo_esp_sospeso_lt.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_gruppo_esp_sospeso_lt
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_gruppo_esp_sospeso_lt
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_gruppo_esp_sospeso_lt
int Width=1212
string DataObject="d_gruppo_esp_sospeso_lt"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Gruppo Esposizione Sospeso"
end event

