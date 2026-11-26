forward
global type w_gruppo_agenti_coddes_sw from w_search_main
end type
end forward

global type w_gruppo_agenti_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Agente"
end type
global w_gruppo_agenti_coddes_sw w_gruppo_agenti_coddes_sw

on w_gruppo_agenti_coddes_sw.create
call super::create
end on

on w_gruppo_agenti_coddes_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_gruppo_agenti_coddes_sw
string DataObject="d_gruppo_agenti_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;
	
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_gruppo_agenti")
is_ricpar.s_id_seg_value[2] = THIS.uf_get_colval("id_sog_com_capo_area")
is_ricpar.s_id_seg_value[3] = THIS.uf_get_colval("id_sog_com_agente")
is_ricpar.s_id_seg_value[4] = THIS.uf_get_colval("id_sog_com_sub_agente")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")
	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
END CHOOSE

end event

event dw_lista::ue_init;is_resp_window = "w_gruppo_agenti_cx"
is_list.s_win_chiave[1] = "id_gruppo_agenti"
end event

