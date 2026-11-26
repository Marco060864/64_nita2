forward
global type w_agenti_stampa_sw from w_search_main
end type
end forward

global type w_agenti_stampa_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Agenti"
end type
global w_agenti_stampa_sw w_agenti_stampa_sw

on w_agenti_stampa_sw.create
call super::create
end on

on w_agenti_stampa_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_agenti_stampa_sw
string DataObject="d_sog_commerciale_gen_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1]=this.uf_get_colval("id_soggetto_commerciale")
choose case is_ricpar.s_filter_name
	case "rag_soc_1"
		is_ricpar.s_main_value=this.uf_get_colval("rag_soc_1")
		is_ricpar.s_ausil_value[1]=this.uf_get_colval("codice")
	
   case "codice"
		is_ricpar.s_main_value=this.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1]=this.uf_get_colval("rag_soc_1")	
		
end choose 	
end event

event dw_lista::retrieveend;call super::retrieveend;this.setfilter("tipo='A'")
this.filter()
end event

