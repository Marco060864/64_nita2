forward
global type w_unita_conf_base_coddes_sw from w_search_main
end type
end forward

global type w_unita_conf_base_coddes_sw from w_search_main
end type
global w_unita_conf_base_coddes_sw w_unita_conf_base_coddes_sw

on w_unita_conf_base_coddes_sw.create
call w_search_main::create
end on

on w_unita_conf_base_coddes_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_unita_conf_base_coddes_sw
string DataObject="d_unita_conf_base_coddes_sw"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("codice")
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_unita_conf_base")
end event

