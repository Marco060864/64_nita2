forward
global type w_registro_sw from w_search_main
end type
end forward

global type w_registro_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Registro"
end type
global w_registro_sw w_registro_sw

on w_registro_sw.create
call w_search_main::create
end on

on w_registro_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_registro_sw
string DataObject="d_registro_lt"
end type

event dw_lista::ue_init;call super::ue_init;
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("registro_descrizione")
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("registro_id_registro")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("esercizio_codice")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("tipo_registro")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("registro_numero")
end event

