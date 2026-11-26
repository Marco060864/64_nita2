forward
global type w_grr_sosp_doc_articolo_rpt from w_print_main
end type
end forward

global type w_grr_sosp_doc_articolo_rpt from w_print_main
int Width=2803
int Height=1313
boolean TitleBar=true
string Title="Stampa inevaso articolo"
end type
global w_grr_sosp_doc_articolo_rpt w_grr_sosp_doc_articolo_rpt

on w_grr_sosp_doc_articolo_rpt.create
call w_print_main::create
end on

on w_grr_sosp_doc_articolo_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;

string	ls_da_art, ls_a_art, ls_da_sogg, ls_a_sogg, ls_tipo_registro
date		ld_da_data, ld_a_data
String 	statement, ls_selezione

ls_da_art				= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_art_cod")
ls_a_art					= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_art_cod")
ls_da_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sog_commerciale_gen_cod")
ls_a_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sog_commerciale_gen_cod")
ld_da_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data")
ld_a_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data")
ls_tipo_registro		= tab_1.tabpage_select.dw_selection.GetItemString(1,"tipo_registro")

if not isNull(ls_da_art) and not isNull(ls_a_art) then
	if ls_da_art > ls_a_art then
		if MessageBox( "Attenzione","Articolo 'da' maggiore Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_sogg) and not isNull(ls_a_sogg) then
	if ls_da_sogg > ls_a_sogg then
		if MessageBox( "Attenzione","Soggetto 'da' maggiore di Soggetto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ld_da_data) and not isNull(ld_a_data) then
	if ld_da_data > ld_a_data then
		if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if


statement  = " {vs_documenti.ID_Azienda} = 1"

if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {vs_documenti.doc_data_registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data scadenza " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	ls_selezione 	= " Dalla data scadenza - non definita, "	
end if

if Not IsNull(ld_a_data) then
	statement 		= statement + " AND {vs_documenti.doc_data_registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data scadenza " + string(ld_a_data, "dd/mm/yyyy") + "."
else
		ls_selezione 	= ls_selezione + "alla data scadenza - non definita."
end if

if Not IsNull(ls_da_art) and ls_da_art <> "" then
	statement 		= statement + " AND {vs_documenti.art_codice} >= '" + ls_da_art + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_art + ", "
else
	ls_selezione 	= " Da articolo non definito, "
end if

if Not IsNull(ls_a_art) and ls_a_art <> "" then
	statement 		= statement + " AND {vs_documenti.art_codice} <= '" + ls_a_art + "'"
	ls_selezione 	= ls_selezione + "a articolo " + ls_a_art + "."
else
	ls_selezione 	= ls_selezione + "a articolo non definito."
end if

if Not IsNull(ls_da_sogg) and ls_da_sogg <> "" then
	statement 		= statement + " AND {vs_documenti.sc_codice} >= '" + ls_da_sogg + "'"
	ls_selezione 	= ls_selezione + " Dal soggetto commerciale " + ls_da_sogg + ", "
else
	ls_selezione 	= " Dal soggetto commerciale non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {vs_documenti.sc_codice} <= '" + ls_a_sogg + "'"
	ls_selezione 	= ls_selezione + "al soggetto commerciale " + ls_a_sogg + "."
else
	ls_selezione 	= ls_selezione + "al soggetto commerciale non definito."
end if

if Not IsNull(ls_tipo_registro) then
	statement 		= statement + " AND {vs_documenti.reg_tipo_registro} = '" + ls_tipo_registro + "'"
	ls_selezione 	= ls_selezione + " Tipo registro: " +ls_tipo_registro + "."
else
	ls_selezione 	= ls_selezione + " Tipo registro non definito."
end if



is_selection 	= statement


return 0
end event

type cb_esci from w_print_main`cb_esci within w_grr_sosp_doc_articolo_rpt
int X=2492
int Y=61
end type

type tab_1 from w_print_main`tab_1 within w_grr_sosp_doc_articolo_rpt
int Width=2721
int Height=1021
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2684
int Height=893
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=29
int Width=2583
int Height=841
string DataObject="d_grr_sosp_doc_articolo_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "da_art_cod", "a_art_cod"
		is_search_window = "w_articolo_coddes_sw"    
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "articolo_codice"  
		
		
	CASE "da_art_des", "a_art_des"
		is_search_window = "w_articolo_coddes_sw"   
		is_ricpar.s_filter_value = as_valcol 				 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
		
	CASE "da_sog_commerciale_gen_cod","a_sog_commerciale_gen_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice" 
		
		
	CASE "da_sog_commerciale_gen_rag_soc_1","a_sog_commerciale_gen_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		
END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "da_art_cod", "a_art_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_art_cod" then
			uf_set_colval("da_art_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_art_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_art_des", "a_art_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_art_des" then
			uf_set_colval("da_art_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_art_cod", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sog_commerciale_gen_cod", "a_sog_commerciale_gen_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_sog_commerciale_gen_cod" then
			uf_set_colval("da_sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sog_commerciale_gen_rag_soc_1", "a_sog_commerciale_gen_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_sog_commerciale_gen_rag_soc_1" then
			uf_set_colval("da_sog_commerciale_gen_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_sog_commerciale_gen_cod", is_ricpar.s_ausil_value[1])
		end if
		
END CHOOSE


end event

event dw_selection::ue_initial;call super::ue_initial;

Post SetItem(1,"a_data",Today())

end event

event dw_selection::itemchanged;call super::itemchanged;
string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long		ll_ok

choose case dwo.name
	
		
	case 'da_art_des'
		
		ls_sql_cond=""  
		
		ls_dbc[1]=	"art_codice"
		ls_dwc[1]=	"da_art_cod"
		
		ls_dbc[2]=	"art_descrizione"
		ls_dwc[2]=	"da_art_des"
		
		ll_ok = uf_autofind_col(dwo.name,"vs_documenti","art_descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
		
		
		case 'a_art_des'
		
		ls_sql_cond=""  
		
		ls_dbc[1]=	"art_codice"
		ls_dwc[1]=	"a_art_cod"
		
		ls_dbc[2]=	"art_descrizione"
		ls_dwc[2]=	"a_art_des"
		
		ll_ok = uf_autofind_col(dwo.name,"vs_documenti","art_descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
		
		
	
  case 'da_sog_commerciale_gen_rag_soc_1'
		
		ls_sql_cond=""
		
		ls_dbc[1]=	"sc_codice"
		ls_dwc[1]=	"da_sog_commerciale_gen_cod"
		
		ls_dbc[2]=	"sc_rag_soc_1"
		ls_dwc[2]=	"da_sog_commerciale_gen_rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.name,"vs_documenti","sc_rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
										 
		
		case 'a_sog_commerciale_gen_rag_soc_1'
		
		ls_sql_cond=""
		
		ls_dbc[1]=	"sc_codice"
		ls_dwc[1]=	"a_sog_commerciale_gen_cod"
		
		ls_dbc[2]=	"sc_rag_soc_1"
		ls_dwc[2]=	"a_sog_commerciale_gen_rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.name,"vs_documenti","sc_rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
		
		
end choose
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2684
int Height=893
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2684
int Height=893
end type

type cb_stampa from w_print_main`cb_stampa within w_grr_sosp_doc_articolo_rpt
int X=2195
int Y=61
end type

