forward
global type w_magazzino_coddes_sw from w_search_main
end type
end forward

global type w_magazzino_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Magazzino"
end type
global w_magazzino_coddes_sw w_magazzino_coddes_sw

on w_magazzino_coddes_sw.create
call super::create
end on

on w_magazzino_coddes_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_magazzino_coddes_sw
string DataObject="d_magazzino_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_magazzino")


CHOOSE CASE is_ricpar.s_filter_name
	CASE "codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("id_locazione")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("corsia")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("scaffale")
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("ripiano")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("posizione")
		
	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("id_locazione")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("corsia")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("scaffale")
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("ripiano")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("posizione")
END CHOOSE

end event

event dw_lista::ue_init;is_resp_window="w_magazzino_ff"
is_list.s_win_chiave[1]="id_magazzino"
end event

