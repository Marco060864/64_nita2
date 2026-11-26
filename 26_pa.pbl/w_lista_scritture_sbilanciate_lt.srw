forward
global type w_lista_scritture_sbilanciate_lt from w_list_main
end type
end forward

global type w_lista_scritture_sbilanciate_lt from w_list_main
boolean TitleBar=true
string Title="Scritture Contabili Incomplete"
end type
global w_lista_scritture_sbilanciate_lt w_lista_scritture_sbilanciate_lt

on w_lista_scritture_sbilanciate_lt.create
call w_list_main::create
end on

on w_lista_scritture_sbilanciate_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_lista_scritture_sbilanciate_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_lista_scritture_sbilanciate_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_lista_scritture_sbilanciate_lt
string DataObject="d_lista_scr_sbil"
end type

