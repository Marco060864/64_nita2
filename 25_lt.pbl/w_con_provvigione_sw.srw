forward
global type w_con_provvigione_sw from w_search_main
end type
end forward

global type w_con_provvigione_sw from w_search_main
int Width=2770
end type
global w_con_provvigione_sw w_con_provvigione_sw

on w_con_provvigione_sw.create
call super::create
end on

on w_con_provvigione_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_con_provvigione_sw
string DataObject="d_con_provvivione_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_con_provvigione")
end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_con_provvigione_sw
boolean BringToTop=true
end type

