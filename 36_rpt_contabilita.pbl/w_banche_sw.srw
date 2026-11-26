forward
global type w_banche_sw from w_search_main
end type
end forward

global type w_banche_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca"
end type
global w_banche_sw w_banche_sw

on w_banche_sw.create
call w_search_main::create
end on

on w_banche_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_banche_sw
string DataObject="d_banc_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1]=this.uf_get_colval("codice")

choose case is_ricpar.s_filter_name
	case "codice"
		Is_ricpar.s_main_value=this.uf_get_colval("codice")
end choose


end event

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_banche_rpt"
is_list.s_win_chiave[1] = "id_sog_commerciale"

end event

