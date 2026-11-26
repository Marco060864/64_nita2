forward
global type w_targa_sw from w_search_main
end type
end forward

global type w_targa_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Destinazione"
end type
global w_targa_sw w_targa_sw

on w_targa_sw.create
call super::create
end on

on w_targa_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_targa_sw
string DataObject="d_mezzo_trasporto_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("targa")


CHOOSE CASE is_ricpar.s_filter_name
	CASE "targa"
		is_ricpar.s_main_value = THIS.uf_get_colval("targa")
		is_ricpar.s_ausil_value[1]=this.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[2]=this.uf_get_colval("tara")		
END CHOOSE

end event

event dw_lista::ue_init;is_resp_window = "w_mezzo_trasporto_ff"
is_list.s_win_chiave[1] = "id_mezzo_trasporto"
end event

