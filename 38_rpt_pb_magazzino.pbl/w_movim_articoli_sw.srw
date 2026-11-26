forward
global type w_movim_articoli_sw from w_search_main
end type
end forward

global type w_movim_articoli_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca "
end type
global w_movim_articoli_sw w_movim_articoli_sw

on w_movim_articoli_sw.create
call w_search_main::create
end on

on w_movim_articoli_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_movim_articoli_sw
int Y=285
string DataObject="d_anag_art_sw"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_stp_movimenti_articolo_cx"
is_list.s_win_chiave[1] = "id_articolo"

end event

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_articolo")


choose case is_ricpar.s_filter_name
		case "codice"
			is_ricpar.s_main_value=this.uf_get_colval("codice")
			is_ricpar.s_ausil_value[1]=this.uf_get_colval("descrizione")
		case "descrizione"
			is_ricpar.s_main_value=this.uf_get_colval("descrizione")
			is_ricpar.s_ausil_value[1]=this.uf_get_colval("codice")
end choose
				
end event

