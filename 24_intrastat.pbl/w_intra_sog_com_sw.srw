forward
global type w_intra_sog_com_sw from w_search_main
end type
end forward

global type w_intra_sog_com_sw from w_search_main
end type
global w_intra_sog_com_sw w_intra_sog_com_sw

on w_intra_sog_com_sw.create
call w_search_main::create
end on

on w_intra_sog_com_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_intra_sog_com_sw
string DataObject="d_sog_comm_cl_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")


CHOOSE CASE is_ricpar.s_filter_name
	CASE "rag_soc_1"
		is_ricpar.s_main_value = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("par_iva")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("codice")
END CHOOSE

end event

event dw_lista::ue_init;call super::ue_init;is_resp_window="w_sog_commerciale_cx"
end event

