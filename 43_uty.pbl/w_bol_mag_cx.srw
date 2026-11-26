forward
global type w_bol_mag_cx from w_np_single_data
end type
end forward

global type w_bol_mag_cx from w_np_single_data
boolean TitleBar=true
string Title="Parametri Bollato Magazzino"
long BackColor=80133307
end type
global w_bol_mag_cx w_bol_mag_cx

on w_bol_mag_cx.create
call super::create
end on

on w_bol_mag_cx.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_bol_mag_cx
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_bol_mag_cx
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_bol_mag_cx
string DataObject="d_par_bol_mag"
end type

event dw_single::itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "prof_documento_codice"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"		
		
		ls_dwc[1] = "prof_documento_codice"
		ls_dwc[2] = "prof_documento_descrizione"
		ls_dwc[3] = "id_prof_documento"				
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
	
	CASE "prof_documento_descrizione"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"				
		
		ls_dwc[1] = "prof_documento_codice"
		ls_dwc[2] = "prof_documento_descrizione"
		ls_dwc[3] = "id_prof_documento"						
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
		
END CHOOSE

end event

event dw_single::ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE	"prof_documento_codice"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_codice"
		
	CASE	"prof_documento_descrizione"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_descrizione"

END CHOOSE
end event

event dw_single::ue_use_search;CHOOSE CASE as_nomecol
	CASE	"prof_documento_codice"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("prof_documento_descrizione",is_ricpar.s_ausil_value[1])

	CASE	"prof_documento_descrizione"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("prof_documento_codice",is_ricpar.s_ausil_value[1])

END CHOOSE
end event

