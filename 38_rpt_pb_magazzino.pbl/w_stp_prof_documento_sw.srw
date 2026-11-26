forward
global type w_stp_prof_documento_sw from w_search_main
end type
end forward

global type w_stp_prof_documento_sw from w_search_main
end type
global w_stp_prof_documento_sw w_stp_prof_documento_sw

on w_stp_prof_documento_sw.create
call w_search_main::create
end on

on w_stp_prof_documento_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_stp_prof_documento_sw
string DataObject="d_prof_documento_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1]=this.uf_get_colval("id_prof_documento")
choose case is_ricpar.s_filter_name
	case "prof_documento_codice"
		is_ricpar.s_main_value=this.uf_get_colval("prof_documento_codice")
		is_ricpar.s_ausil_value[1]=this.uf_get_colval("prof_documento_descrizione")
	case "prof_documento_descrizione"
		is_ricpar.s_main_value=this.uf_get_colval("prof_documento_descrizione")
		is_ricpar.s_ausil_value[1]=this.uf_get_colval("prof_documento_codice")
end choose
end event

