forward
global type w_conto_azienda_coddes_sw from w_search_main
end type
end forward

global type w_conto_azienda_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Conto"
end type
global w_conto_azienda_coddes_sw w_conto_azienda_coddes_sw

on w_conto_azienda_coddes_sw.create
call super::create
end on

on w_conto_azienda_coddes_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_conto_azienda_coddes_sw
string DataObject="d_conto_azienda_lt"
end type

event dw_lista::ue_init;call super::ue_init;
end event

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("conto_id_conto")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "conto_codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("conto_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("conto_descrizione")
	CASE "conto_descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("conto_descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("conto_codice")
END CHOOSE

end event

