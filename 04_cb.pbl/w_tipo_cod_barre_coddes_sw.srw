forward
global type w_tipo_cod_barre_coddes_sw from w_search_main
end type
end forward

global type w_tipo_cod_barre_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Magazzino"
end type
global w_tipo_cod_barre_coddes_sw w_tipo_cod_barre_coddes_sw

on w_tipo_cod_barre_coddes_sw.create
call super::create
end on

on w_tipo_cod_barre_coddes_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_tipo_cod_barre_coddes_sw
string DataObject="d_tipo_cod_barre_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_tipo_cod_barre")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")
	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
END CHOOSE

end event

