forward
global type w_causali_sw from w_search_main
end type
end forward

global type w_causali_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca"
end type
global w_causali_sw w_causali_sw

on w_causali_sw.create
call w_search_main::create
end on

on w_causali_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_causali_sw
string DataObject="d_causali_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1]=this.uf_get_colval("codice")

choose case is_ricpar.s_filter_name
	case "codice"
		Is_ricpar.s_main_value=this.uf_get_colval("codice")
end choose


end event

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_elenco_causali_rpt"
is_list.s_win_chiave[1] = "id_prof_registrazione"

end event

