forward
global type w_lotto_codice_sw from w_search_main
end type
end forward

global type w_lotto_codice_sw from w_search_main
end type
global w_lotto_codice_sw w_lotto_codice_sw

on w_lotto_codice_sw.create
call super::create
end on

on w_lotto_codice_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_lotto_codice_sw
string DataObject="d_lotto_codice_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("lotto_id_lotto")
CHOOSE CASE is_ricpar.s_filter_name
	CASE "lotto_cod_esterno", "articolo_codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("lotto_cod_esterno")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("articolo_descrizione")
END CHOOSE

end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_lotto_codice_sw
boolean BringToTop=true
end type

