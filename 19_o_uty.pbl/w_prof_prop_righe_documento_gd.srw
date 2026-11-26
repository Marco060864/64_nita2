forward
global type w_prof_prop_righe_documento_gd from w_np_single_data
end type
end forward

global type w_prof_prop_righe_documento_gd from w_np_single_data
integer width = 2263
integer height = 808
string title = "Proponi Righe in Documento"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
end type
global w_prof_prop_righe_documento_gd w_prof_prop_righe_documento_gd

type variables
long Il_id_doc
end variables

on w_prof_prop_righe_documento_gd.create
call super::create
end on

on w_prof_prop_righe_documento_gd.destroy
call super::destroy
end on

event open;idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"

this.y = 100
Il_id_doc=message.doubleparm
dw_single.Retrieve(Il_id_doc)

end event

type p_msg_log from w_np_single_data`p_msg_log within w_prof_prop_righe_documento_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_prof_prop_righe_documento_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_prof_prop_righe_documento_gd
end type

type dw_single from w_np_single_data`dw_single within w_prof_prop_righe_documento_gd
integer x = 23
integer y = 32
integer width = 2171
integer height = 672
string dataobject = "d_orafo_prof_prop_righe_nra"
borderstyle borderstyle = stylelowered!
end type

event dw_single::ue_initial;call super::ue_initial;
setitem(getrow(), 'id_prof_documento',Il_id_doc)


end event

event dw_single::itemchanged;string ls_sql_cond, ls_dbc[],ls_dbv[], ls_dwc[]
integer li_ok


if dwo.name= 'cod_articolo' then
		
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
	
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "cod_articolo"
	
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
end if

end event

event dw_single::ue_set_search;call super::ue_set_search;if as_nomecol= "cod_articolo" then
	is_search_window = "w_articolo_coddes_sw"
	is_ricpar.s_filter_value = as_valcol
	is_ricpar.s_filter_name = "articolo_codice"
end if
end event

event dw_single::ue_use_search;if as_nomecol="cod_articolo" then
	uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
end if
end event

