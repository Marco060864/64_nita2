forward
global type w_dis_banca_sw from w_search_main
end type
end forward

global type w_dis_banca_sw from w_search_main
end type
global w_dis_banca_sw w_dis_banca_sw

on w_dis_banca_sw.create
call super::create
end on

on w_dis_banca_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_dis_banca_sw
string DataObject="d_dis_banca"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_distinta_banca")
is_ricpar.s_main_value = THIS.uf_get_colval("num_distinta")
is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("data_distinta")

end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_dis_banca_sw
boolean BringToTop=true
end type

