forward
global type w_tipo_agente_sw from w_search_main
end type
end forward

global type w_tipo_agente_sw from w_search_main
end type
global w_tipo_agente_sw w_tipo_agente_sw

on w_tipo_agente_sw.create
call w_search_main::create
end on

on w_tipo_agente_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_tipo_agente_sw
string DataObject="d_tipo_agente_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = uf_get_colval("id_tipo_agente")	
end event

