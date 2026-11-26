forward
global type w_distinta_base_sw from w_search_main
end type
end forward

global type w_distinta_base_sw from w_search_main
end type
global w_distinta_base_sw w_distinta_base_sw

on w_distinta_base_sw.create
call super::create
end on

on w_distinta_base_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_distinta_base_sw
string DataObject="d_distinta_base_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = uf_get_colval("id_distinta")	

is_ricpar.s_ausil_value[1] = uf_get_colval("codice")
is_ricpar.s_ausil_value[2] = uf_get_colval("descrizione")
end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_distinta_base_sw
boolean BringToTop=true
end type

