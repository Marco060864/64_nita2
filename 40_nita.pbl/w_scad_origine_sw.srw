forward
global type w_scad_origine_sw from w_search_main
end type
end forward

global type w_scad_origine_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Scadenza"
end type
global w_scad_origine_sw w_scad_origine_sw

on w_scad_origine_sw.create
call w_search_main::create
end on

on w_scad_origine_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_scad_origine_sw
string DataObject="d_scad_origine_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_scadenza")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("data_scadenza")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("stato_scadenza")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("scadenza_da_raggruppare")
is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("id_tipo_pagamento")
is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("id_valuta")
is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("imp_valuta")
is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("cambio")
is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("importo")
end event

