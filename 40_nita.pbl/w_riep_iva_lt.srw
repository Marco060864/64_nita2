forward
global type w_riep_iva_lt from w_list_main
end type
end forward

global type w_riep_iva_lt from w_list_main
boolean TitleBar=true
string Title="Riepilogo IVA"
end type
global w_riep_iva_lt w_riep_iva_lt

on w_riep_iva_lt.create
call w_list_main::create
end on

on w_riep_iva_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_riep_iva_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_riep_iva_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_riep_iva_lt
string DataObject="d_riep_iva_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Riepilogo IVA"
is_resp_window = "w_riep_iva_ff"
end event

