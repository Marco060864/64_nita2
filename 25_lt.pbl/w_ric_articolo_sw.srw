forward
global type w_ric_articolo_sw from w_search_main
end type
end forward

global type w_ric_articolo_sw from w_search_main
end type
global w_ric_articolo_sw w_ric_articolo_sw

on w_ric_articolo_sw.create
call w_search_main::create
end on

on w_ric_articolo_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_ric_articolo_sw
int Width=1185
string DataObject="d_ricerca_art_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_articolo")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")
	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
END CHOOSE

end event

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_articolo_cx"
is_list.s_win_chiave[1] = "id_articolo"
end event

