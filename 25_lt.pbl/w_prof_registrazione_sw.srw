forward
global type w_prof_registrazione_sw from w_search_main
end type
end forward

global type w_prof_registrazione_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Profilo Registrazione"
end type
global w_prof_registrazione_sw w_prof_registrazione_sw

on w_prof_registrazione_sw.create
call w_search_main::create
end on

on w_prof_registrazione_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_prof_registrazione_sw
string DataObject="d_prof_registrazione_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_prof_registrazione_cx"
is_list.s_win_chiave[1] = "id_prof_registrazione"
end event

event dw_lista::ue_return_values;call super::ue_return_values;

is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_prof_registrazione")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")		
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")		
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_prof_registrazione")
	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")			
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")				
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_prof_registrazione")
END CHOOSE




end event

