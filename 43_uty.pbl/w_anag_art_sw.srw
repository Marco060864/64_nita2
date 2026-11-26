forward
global type w_anag_art_sw from w_search_main
end type
end forward

global type w_anag_art_sw from w_search_main
end type
global w_anag_art_sw w_anag_art_sw

on w_anag_art_sw.create
call w_search_main::create
end on

on w_anag_art_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_anag_art_sw
string DataObject="d_anag_art_sw"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1]=this.uf_get_colval("id_articolo")
choose case is_ricpar.s_filter_name
		case "codice"
			is_ricpar.s_main_value=this.uf_get_colval("codice")
			is_ricpar.s_ausil_value[1]=this.uf_get_colval("descrizione")
		case "descrizione"
			is_ricpar.s_main_value=this.uf_get_colval("descrizione")
			is_ricpar.s_ausil_value[1]=this.uf_get_colval("codice")
end choose
				
end event

event dw_lista::retrieveend;call super::retrieveend;dw_lista.SetSort("codice A")

dw_lista.Sort()
end event

