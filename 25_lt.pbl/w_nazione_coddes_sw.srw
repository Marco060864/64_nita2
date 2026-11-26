forward
global type w_nazione_coddes_sw from w_search_main
end type
end forward

global type w_nazione_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Selezione Nazione"
end type
global w_nazione_coddes_sw w_nazione_coddes_sw

on w_nazione_coddes_sw.create
call w_search_main::create
end on

on w_nazione_coddes_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_nazione_coddes_sw
string DataObject="d_nazione_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_nazione_ff"
is_list.s_win_chiave[1] = "id_nazione"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_nazione")

CHOOSE CASE is_ricpar.s_filter_name
		
	CASE "codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")

	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
		
END CHOOSE

end event

