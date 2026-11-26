forward
global type w_centro_costo_sw from w_search_main
end type
end forward

global type w_centro_costo_sw from w_search_main
end type
global w_centro_costo_sw w_centro_costo_sw

on w_centro_costo_sw.create
call w_search_main::create
end on

on w_centro_costo_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_centro_costo_sw
string DataObject="d_centro_costo_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_list.s_win_chiave[1] = "id_centro_costo"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_centro_costo")
is_ricpar.s_main_value      = THIS.uf_get_colval("codice")
is_ricpar.s_ausil_value[1]  = THIS.uf_get_colval("descrizione")
end event

