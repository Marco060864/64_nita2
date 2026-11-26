forward
global type w_cedolino_agente_rpt from w_print_main
end type
end forward

global type w_cedolino_agente_rpt from w_print_main
int Width=2803
int Height=1241
boolean TitleBar=true
string Title="Cedolino agente"
end type
global w_cedolino_agente_rpt w_cedolino_agente_rpt

on w_cedolino_agente_rpt.create
call w_print_main::create
end on

on w_cedolino_agente_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;

string	ls_da_sogg, ls_a_sogg, ls_tipo_documento
string	ls_da_agente,ls_a_agente,ls_salto_pagina,ls_provv_manuali
date		ld_da_data, ld_a_data
String 	statement, ls_selezione

ls_da_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sog_commerciale_gen_cod")
ls_a_sogg				= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sog_commerciale_gen_cod")
ls_da_agente			= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_agente_cod")
ls_a_agente				= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_agente_cod")
ld_da_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data")
ld_a_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data")
ls_salto_pagina		= tab_1.tabpage_select.dw_selection.GetItemString(1,"salto_pagina")
ls_provv_manuali		= tab_1.tabpage_select.dw_selection.GetItemString(1,"provv_manuali")

if isNull(ls_provv_manuali) then ls_provv_manuali = "N"

if not isNull(ls_da_agente) and not isNull(ls_a_agente) then
	if ls_da_agente > ls_a_agente then
		if MessageBox( "Attenzione","Agente 'da' maggiore di Agente 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
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


statement  = " {riep_provvigione.ID_Azienda} = 1"

if Not IsNull(ld_da_data) then
	
	if ls_provv_manuali = "S" then
		statement 		= statement + " AND ( {documento.data_registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ") OR " + &
														"{riep_provvigione.data_registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ") ) "	
	else	
		statement 		= statement + " AND {documento.data_registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	end if
	
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	ls_selezione 	= " Dalla data registrazione - non definita, "	
end if

if Not IsNull(ld_a_data) then
	if ls_provv_manuali = "S" then
		statement 		= statement + " AND ( {documento.data_registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ") OR " + &
													   "{riep_provvigione.data_registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ") ) " 
	else
		statement 		= statement + " AND {documento.data_registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	end if	
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_a_data, "dd/mm/yyyy") + "."
else
		ls_selezione 	= ls_selezione + "alla data registrazione - non definita."
end if

if Not IsNull(ls_da_agente) and ls_da_agente <> "" then
	statement 		= statement + " AND {Sog_Commerciale_gen.codice} >= '" + ls_da_agente + "'"
	ls_selezione 	= ls_selezione + " Da agente " + ls_da_agente + ", "
else
	ls_selezione 	= " Da agente non definito, "
end if

if Not IsNull(ls_a_agente) and ls_a_agente <> "" then
	statement 		= statement + " AND {Sog_Commerciale_gen.codice} <= '" + ls_a_agente + "'"
	ls_selezione 	= ls_selezione + "a agente " + ls_a_agente + "."
else
	ls_selezione 	= ls_selezione + "a agente non definito."
end if

if Not IsNull(ls_da_sogg) and ls_da_sogg <> "" then
	statement 		= statement + " AND {Sog_Commerciale_gen_cliente.codice} >= '" + ls_da_sogg + "'"
	ls_selezione 	= ls_selezione + " Da cliente " + ls_da_sogg + ", "
else
	ls_selezione 	= " Da cliente non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {Sog_Commerciale_gen_cliente.codice} <= '" + ls_a_sogg + "'"
	ls_selezione 	= ls_selezione + "al cliente " + ls_a_sogg + "."
else
	ls_selezione 	= ls_selezione + "al cliente non definito."
end if

if isNull(ls_salto_pagina) then ls_salto_pagina = "N"


is_selection 	= statement

istr_formule[1].formula_name 		= "salto_pagina"
istr_formule[1].formula_string 	= "'" + ls_salto_pagina + "'"
istr_formule[2].formula_name 		= "selezione"
istr_formule[2].formula_string 	= "'" + ls_selezione + "'"

return 0
end event

type cb_esci from w_print_main`cb_esci within w_cedolino_agente_rpt
int X=2492
int Y=61
end type

type tab_1 from w_print_main`tab_1 within w_cedolino_agente_rpt
int Width=2721
int Height=961
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2684
int Height=833
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=28
int Y=29
int Width=2629
int Height=781
string DataObject="d_cedolino_agente_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "da_sog_commerciale_gen_cod","a_sog_commerciale_gen_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'" 		
		
	CASE "da_sog_commerciale_gen_rag_soc_1","a_sog_commerciale_gen_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'C'" 


	CASE "da_agente_cod","a_agente_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'" 		
		
	CASE "da_agente_des","a_agente_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'A'" 
		
		
END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
		
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

	CASE "da_agente_cod", "a_agente_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_agente_cod" then
			uf_set_colval("da_agente_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_agente_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_agente_des", "a_agente_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_agente_des" then
			uf_set_colval("da_agente_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_agente_cod", is_ricpar.s_ausil_value[1])
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
	
	
  case 'da_sog_commerciale_gen_rag_soc_1'
		
		ls_sql_cond = "sog_commerciale_gen.tipo = 'C'"
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_sog_commerciale_gen_cod"
		
		ls_dbc[2]=	"rag_soc_1"
		ls_dwc[2]=	"da_sog_commerciale_gen_rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
										 
		if ll_ok>0 then
			return 2
		end if
				
	case 'a_sog_commerciale_gen_rag_soc_1'
		
		ls_sql_cond = "sog_commerciale_gen.tipo = 'C'"
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_sog_commerciale_gen_cod"
		
		ls_dbc[2]=	"rag_soc_1"
		ls_dwc[2]=	"a_sog_commerciale_gen_rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
	
		if ll_ok>0 then
			return 2
		end if

  case 'da_agente_des'
		
		ls_sql_cond = "sog_commerciale_gen.tipo = 'A'"
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_agente_cod"
		
		ls_dbc[2]=	"rag_soc_1"
		ls_dwc[2]=	"da_agente_des"
		
		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
										 
		if ll_ok>0 then
			return 2
		end if
		
	case 'a_agente_des'
		
		ls_sql_cond= "sog_commerciale_gen.tipo = 'A'"
		
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_agente_cod"
		
		ls_dbc[2]=	"rag_soc_1"
		ls_dwc[2]=	"a_agente_des"
		
		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale_gen","rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
										 
		if ll_ok>0 then
			return 2
		end if
		
end choose
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2684
int Height=833
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2684
int Height=833
end type

type cb_stampa from w_print_main`cb_stampa within w_cedolino_agente_rpt
int X=2195
int Y=61
end type

