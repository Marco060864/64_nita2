forward
global type w_prof_documento_coddes_sw from w_search_main
end type
end forward

global type w_prof_documento_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Profilo Documento"
end type
global w_prof_documento_coddes_sw w_prof_documento_coddes_sw

on w_prof_documento_coddes_sw.create
call w_search_main::create
end on

on w_prof_documento_coddes_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_prof_documento_coddes_sw
string DataObject="d_prof_documento_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_prof_documento_cx"
is_list.s_win_chiave[1] = "id_prof_documento"
end event

event dw_lista::ue_return_values;call super::ue_return_values;
CHOOSE CASE is_ricpar.s_filter_name

	CASE "prof_documento_codice"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_prof_documento")
		is_ricpar.s_main_value = THIS.uf_get_colval("prof_documento_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("prof_documento_descrizione")
		

	CASE "prof_documento_descrizione"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_prof_documento")
		is_ricpar.s_main_value = THIS.uf_get_colval("prof_documento_descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("prof_documento_codice")
		

END CHOOSE

is_ricpar.s_id_seg_value[2] = THIS.uf_get_colval("prof_documento_id_valuta_prop")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("prof_documento_tipo_registro")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("prof_documento_ric_acconti")

end event

