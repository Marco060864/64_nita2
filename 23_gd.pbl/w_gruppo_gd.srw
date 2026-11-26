forward
global type w_gruppo_gd from w_np_single_data
end type
end forward

global type w_gruppo_gd from w_np_single_data
int Width=2981
int Height=849
boolean TitleBar=true
string Title="Gruppi d'Acquisto"
end type
global w_gruppo_gd w_gruppo_gd

on w_gruppo_gd.create
call w_np_single_data::create
end on

on w_gruppo_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 38

end event

type p_crescente from w_np_single_data`p_crescente within w_gruppo_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_gruppo_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_gruppo_gd
int Width=2858
string DataObject="d_gruppo_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Gruppi d'Acquisto"
end event

event dw_single::ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "c_anagrafica_rag_soc_1"
		is_search_window = "w_anagrafica_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc"
		
END CHOOSE

end event

event dw_single::ue_use_search;call super::ue_use_search;
CHOOSE CASE as_nomecol
		
	CASE "c_anagrafica_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("gruppo_id_anagrafica", is_ricpar.s_id_seg_value[1])

END CHOOSE
end event

event dw_single::itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name

	CASE "c_anagrafica_rag_soc_1"
		ls_dbc[1] = "id_anagrafica"
		ls_dwc[1] = "gruppo_id_anagrafica"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "c_anagrafica_rag_soc_1"
		ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF			
		
END CHOOSE

end event

