forward
global type w_lista_reg_iva_sbilanciate_lt from w_list_main
end type
end forward

global type w_lista_reg_iva_sbilanciate_lt from w_list_main
int Width=2611
boolean TitleBar=true
string Title="Movimenti IVA Incompleti"
end type
global w_lista_reg_iva_sbilanciate_lt w_lista_reg_iva_sbilanciate_lt

on w_lista_reg_iva_sbilanciate_lt.create
call w_list_main::create
end on

on w_lista_reg_iva_sbilanciate_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_lista_reg_iva_sbilanciate_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_lista_reg_iva_sbilanciate_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_lista_reg_iva_sbilanciate_lt
int X=51
int Y=37
int Height=897
string DataObject="d_lista_scr_sbil_iva"
end type

