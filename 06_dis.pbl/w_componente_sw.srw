forward
global type w_componente_sw from w_search_main
end type
end forward

global type w_componente_sw from w_search_main
end type
global w_componente_sw w_componente_sw

on w_componente_sw.create
call super::create
end on

on w_componente_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_componente_sw
string DataObject="d_componente_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = uf_get_colval("id_componente")		
end event

