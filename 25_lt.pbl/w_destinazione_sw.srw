forward
global type w_destinazione_sw from w_search_main
end type
end forward

global type w_destinazione_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Destinazione"
end type
global w_destinazione_sw w_destinazione_sw

on w_destinazione_sw.create
call super::create
end on

on w_destinazione_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_destinazione_sw
string DataObject="d_destinazione_nosogcomm_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_destinazione")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "rag_soc_1"
		is_ricpar.s_main_value = THIS.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[1]=this.uf_get_colval("indirizzo")
		is_ricpar.s_ausil_value[2]=this.uf_get_colval("sog_commerciale_gen_rag_soc_1")		
END CHOOSE

end event

event dw_lista::ue_init;is_resp_window = "w_anag_2_cx"
is_list.s_win_chiave[1] = "id_anagrafica"
end event

