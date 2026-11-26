forward
global type w_conti_in_pdc_sw from w_search_main
end type
end forward

global type w_conti_in_pdc_sw from w_search_main
end type
global w_conti_in_pdc_sw w_conti_in_pdc_sw

on w_conti_in_pdc_sw.create
call super::create
end on

on w_conti_in_pdc_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_conti_in_pdc_sw
string DataObject="d_conti_in_pdc_gd"
end type

event dw_lista::ue_init;is_list.s_win_chiave[1] = "id_conto"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_cen_cos_t")

		is_ricpar.s_main_value = THIS.uf_get_colval("id_conto")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("conto_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("conto_descrizione")
end event

