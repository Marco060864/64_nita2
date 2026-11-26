forward
global type w_stampa_documenti_art_rpt from w_print_main
end type
end forward

global type w_stampa_documenti_art_rpt from w_print_main
int Width=2789
int Height=1936
boolean TitleBar=true
string Title="Stampa Documenti per Articolo"
long BackColor=80264376
end type
global w_stampa_documenti_art_rpt w_stampa_documenti_art_rpt

event ue_pre_print;call super::ue_pre_print;long		ll_retval
string	ls_da_profilo, ls_a_profilo, ls_da_articolo, ls_a_articolo,ls_stato_righe
date		ld_da_data, ld_a_data
decimal{0} ld_da_num_progressivo, ld_a_num_progressivo
String 	statement, ls_selezione
date		ld_da_data_pc, ld_a_data_pc
string	ls_da_sogg_cod, ls_a_sogg_cod
long		ll_da_mod_registro, ll_a_mod_registro
string	ls_da_tipo_registro, ls_a_tipo_registro
decimal	ld_da_numero, ld_a_numero

ls_da_articolo 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_codice_art")
ls_a_articolo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_codice_art")

ls_da_profilo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_prof_cod")
ls_a_profilo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_prof_cod")

ld_da_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data")
ld_a_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data")

ld_da_num_progressivo = tab_1.tabpage_select.dw_selection.GetItemNumber(1,"da_num_progressivo")
ld_a_num_progressivo  = tab_1.tabpage_select.dw_selection.GetItemNumber(1,"a_num_progressivo")

ls_stato_righe    = tab_1.tabpage_select.dw_selection.GetItemString(1,"stato_righe")

ld_da_data_pc		= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data_pc")
ld_a_data_pc		= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data_pc")

ls_da_sogg_cod	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sogg_cod")
ls_a_sogg_cod	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sogg_cod")

ll_da_mod_registro= long(tab_1.tabpage_select.dw_selection.GetItemstring(1,"da_mod_registro"))
ll_a_mod_registro	= long(tab_1.tabpage_select.dw_selection.GetItemstring(1,"a_mod_registro"))

if (ll_da_mod_registro > 0) then
	SELECT tipo_registro, numero
	INTO	 :ls_da_tipo_registro, :ld_da_numero
	FROM	 mod_registro
	WHERE  id_mod_registro = :ll_da_mod_registro
	;
end if

if (ll_a_mod_registro > 0) then
	SELECT tipo_registro, numero
	INTO	 :ls_a_tipo_registro, :ld_a_numero
	FROM	 mod_registro
	WHERE  id_mod_registro = :ll_a_mod_registro
	;
end if

if ll_da_mod_registro > ll_a_mod_registro then
	if MessageBox( "Attenzione","Mod. registro 'da' maggiore di Mod. registro cons. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ld_da_data_pc > ld_a_data_pc then
	if MessageBox( "Attenzione","Data prev. cons. 'da' maggiore di Data prev. cons. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ls_da_sogg_cod > ls_a_sogg_cod then
	if MessageBox( "Attenzione","Sogg. Comm. 'da' maggiore di Sogg. Comm. 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ls_da_profilo > ls_a_profilo then
	if MessageBox( "Attenzione","Profilo 'da' maggiore di Profilo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ld_da_data > ld_a_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ls_da_articolo > ls_a_articolo then
	if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if IsNull(ls_stato_righe) or ls_stato_righe = "" then
	ls_stato_righe = "N"
end if	

if ls_stato_righe = "I" then
	ls_selezione = ls_selezione + "Righe Inevase"
end if

if ls_stato_righe ="E" then
	ls_selezione = ls_selezione + "Righe Evase"
end if

if Ls_stato_righe ="C" then

	ls_selezione = ls_selezione + "Righe Consegnate"
end if	

statement  = "{Articolo.ID_Azienda} = 1"

if (ll_da_mod_registro > 0) then
	statement 		= statement + " AND {mod_registro.tipo_registro} >= '" + ls_da_tipo_registro + "' AND {mod_registro.numero} >= " + string(ld_da_numero)
	ls_selezione 	= ls_selezione + " Da Mod. registro " + ls_da_tipo_registro + "/" + string(ld_da_numero) + ", "
end if

if (ll_a_mod_registro > 0) then
	statement 		= statement + " AND {mod_registro.tipo_registro} <= '" + ls_a_tipo_registro + "' AND {mod_registro.numero} <= " + string(ld_a_numero)
	ls_selezione 	= ls_selezione + " A Mod. registro " + ls_a_tipo_registro + "/" + string(ld_a_numero) + ", "
end if

if Not IsNull(ls_da_sogg_cod) and ls_da_sogg_cod <> "" then
	statement 		= statement + " AND {sog_commerciale_gen.Codice} >= '" + ls_da_sogg_cod + "'"
	ls_selezione 	= ls_selezione + " Da Intestatario " + ls_da_sogg_cod + ", "
end if

if Not IsNull(ls_a_sogg_cod) and ls_a_sogg_cod <> "" then
	statement 		= statement + " AND {sog_commerciale_gen.Codice} <= '" + ls_a_sogg_cod + "'"
	ls_selezione 	= ls_selezione + "a Intestatario " + ls_a_sogg_cod + "."
end if

if Not IsNull(ls_da_articolo) and ls_da_articolo <> "" then
	statement 		= statement + " AND {articolo.Codice} >= '" + ls_da_articolo + "'"
	ls_selezione 	= ls_selezione + " Da Articolo " + ls_da_articolo + ", "
end if

if Not IsNull(ls_a_articolo) and ls_a_articolo <> "" then
	statement 		= statement + " AND {articolo.Codice} <= '" + ls_a_articolo + "'"
	ls_selezione 	= ls_selezione + "a Articolo " + ls_a_articolo + "."
end if

if Not IsNull(ld_da_data_pc) then
	statement 		= statement + " AND {Documento.data_prev_consegna} >= Date (" + string(ld_da_data_pc, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data prev. cons. " + string(ld_da_data, "dd/mm/yyyy") + ", "
end if

if Not IsNull(ld_a_data_pc) then
	statement 		= statement + " AND {Documento.data_prev_consegna} <= Date (" + string(ld_a_data_pc, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data prev. consegna " + string(ld_a_data_pc, "dd/mm/yyyy") + "."
end if

if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
end if

if Not IsNull(ld_a_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_a_data, "dd/mm/yyyy") + "."
end if

if Not IsNull(ld_da_num_progressivo) then
	statement 		= statement + " AND {Documento.num_progressivo} >= " + string(ld_da_num_progressivo)
	ls_selezione 	= " Da Prot.:" + string(ld_da_num_progressivo) + ", "
end if

if Not IsNull(ld_a_num_progressivo) then
	statement 		= statement + " AND {Documento.num_progressivo} <= " + string(ld_a_num_progressivo)
	ls_selezione 	= " A Prot.:" + string(ld_a_num_progressivo) + ", "
end if

if Not IsNull(ls_da_profilo) and ls_da_profilo <> "" then
	statement 		= statement + " AND {Prof_documento.Codice} >= '" + ls_da_profilo + "'"
	ls_selezione 	= ls_selezione + " Da codice profilo " + ls_da_profilo + ", "
end if

if Not IsNull(ls_a_profilo) and ls_a_profilo <> "" then
	statement 		= statement + " AND {Prof_documento.Codice} <= '" + ls_a_profilo + "'"
	ls_selezione 	= ls_selezione + "a profilo " + ls_a_profilo + "."
end if

is_selection 	= statement


CHOOSE CASE ls_stato_righe
	CASE 'E'
		istr_formule[1].formula_name 		= "selezione"
		istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
		istr_formule[2].formula_name 		= ""
		istr_formule[2].formula_string 	= "'" + ls_stato_righe+ "'"
		istr_formule[3].formula_name 		= "Evaso"
		istr_formule[3].formula_string 	= "'" + ls_stato_righe + "'"
		istr_formule[4].formula_name 		= ""
		istr_formule[4].formula_string 	= "'" + ls_stato_righe + "'"
	CASE 'I'
		istr_formule[1].formula_name 		= "selezione"
		istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
		istr_formule[2].formula_name 		= "Inevaso"
		istr_formule[2].formula_string 	= "'" + ls_stato_righe+ "'"
		istr_formule[3].formula_name 		= ""
		istr_formule[3].formula_string 	= "'" + ls_stato_righe + "'"
		istr_formule[4].formula_name 		= ""
		istr_formule[4].formula_string 	= "'" + ls_stato_righe + "'"
	CASE 'C'
		istr_formule[1].formula_name 		= "selezione"
		istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
		istr_formule[2].formula_name 		= ""
		istr_formule[2].formula_string 	= "'" + ls_stato_righe+ "'"
		istr_formule[3].formula_name 		= ""
		istr_formule[3].formula_string 	= "'" + ls_stato_righe + "'"
		istr_formule[4].formula_name 		= "Contabilizzato"
		istr_formule[4].formula_string 	= "'" + ls_stato_righe + "'"
	CASE 'N'
		istr_formule[1].formula_name 		= "selezione"
		istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
		istr_formule[2].formula_name 		= "Inevaso"
		istr_formule[2].formula_string 	= "'" + ls_stato_righe+ "'"
		istr_formule[3].formula_name 		= "Evaso"
		istr_formule[3].formula_string 	= "'" + ls_stato_righe + "'"
		istr_formule[4].formula_name 		= "Contabilizzato"
		istr_formule[4].formula_string 	= "'" + ls_stato_righe + "'"
	END CHOOSE
	
	
	istr_formule[5].formula_name 		= "id_valuta"
	istr_formule[5].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))
	

return 0

end event

on w_stampa_documenti_art_rpt.create
call super::create
end on

on w_stampa_documenti_art_rpt.destroy
call super::destroy
end on

type cb_esci from w_print_main`cb_esci within w_stampa_documenti_art_rpt
int X=2523
int Y=60
end type

event cb_esci::clicked;call super::clicked;
end event

type tab_1 from w_print_main`tab_1 within w_stampa_documenti_art_rpt
int X=32
int Y=192
int Width=2715
int Height=1636
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2679
int Height=1508
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=18
int Y=24
int Width=2642
int Height=1464
string DataObject="d_iserimento_interf_rpt"
end type

event dw_selection::ue_set_search;CHOOSE CASE as_nomecol
	
	CASE "da_codice_art","a_codice_art"
		is_search_window = "w_articolo_coddes_sw"   
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "articolo_codice"  
				
	CASE "da_des_art","a_des_art"
		is_search_window = "w_articolo_coddes_sw"   
		is_ricpar.s_filter_value = as_valcol 				 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
	CASE "da_prof_cod","a_prof_cod"
		is_search_window ="w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_codice" 
		
	CASE "da_prof_des","a_prof_des"
		is_search_window = "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_descrizione" 

	CASE "da_sogg_cod","a_sogg_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"   
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "codice"  
		
	CASE "da_sogg_des","a_sogg_des"
		is_search_window = "w_sog_commerciale_gen_Coddes_sw"   
		is_ricpar.s_filter_value = as_valcol 				 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
END CHOOSE

end event

event dw_selection::ue_use_search;CHOOSE CASE as_nomecol
		
	CASE "da_codice_art", "a_codice_art"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_codice_art" then
			uf_set_colval("da_des_art", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_des_art", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_des_art", "a_des_art"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_des_art" then
			uf_set_colval("da_codice_art", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_codice_art", is_ricpar.s_ausil_value[1])
		end if
	
	CASE "da_prof_cod", "a_prof_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_prof_cod" then
			uf_set_colval("da_prof_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_prof_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_prof_des", "a_prof_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_prof_des" then
			uf_set_colval("da_prof_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_prof_cod", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sogg_cod", "a_sogg_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_sogg_cod" then
			uf_set_colval("da_sogg_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sogg_des", "a_sogg_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_sogg_des" then
			uf_set_colval("da_sogg_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_sogg_cod", is_ricpar.s_ausil_value[1])
		end if
END CHOOSE

if (as_nomecol = "da_prof_cod" or	as_nomecol = "da_prof_des") then
	if isnull(This.GetItemString(1, "a_prof_cod")) or This.GetItemString(1, "a_prof_cod")='' then
      This.SetItem(1, "a_prof_cod", This.GetItemString(1, "da_prof_cod"))			
      This.SetItem(1, "a_prof_des", This.GetItemString(1, "da_prof_des"))			
    end if 
end if
		

if (as_nomecol = "da_sogg_cod" or	as_nomecol = "da_sogg_des") then
	if isnull(This.GetItemString(1, "a_sogg_cod")) or This.GetItemString(1, "a_sogg_cod")='' then
      This.SetItem(1, "a_sogg_cod", This.GetItemString(1, "da_sogg_cod"))			
      This.SetItem(1, "a_sogg_des", This.GetItemString(1, "da_sogg_des"))			
	end if
end if

if (as_nomecol = "da_codice_art" or	as_nomecol = "da_des_art") then
	if isnull(This.GetItemString(1, "a_codice_art")) or This.GetItemString(1, "a_codice_art")='' then
      This.SetItem(1, "a_codice_art", This.GetItemString(1, "da_cod_art"))			
      This.SetItem(1, "a_des_art", This.GetItemString(1, "da_des_art"))			
    end if 
end if

end event

event dw_selection::itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
CHOOSE CASE dwo.name
	CASE "da_prof_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_prof_cod"
		ls_dwc[2] = "da_prof_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_prof_cod")) or This.GetItemString(1, "a_prof_cod")='' then
           This.SetItem(1, "a_prof_cod", Data)			
           This.SetItem(1, "a_prof_des", This.GetItemString(1, "da_prof_des"))			
	      end if 
			RETURN 2
		END IF
		
		
	CASE "da_prof_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_prof_cod"
		ls_dwc[2] = "da_prof_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "da_prof_cod")) or This.GetItemString(1, "a_prof_cod")='' then
           This.SetItem(1, "a_prof_cod", This.GetItemString(1, "da_prof_des"))			
           This.SetItem(1, "a_prof_des", Data)			
	      end if 
			RETURN 2
		END IF

	CASE "a_prof_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_prof_cod"
		ls_dwc[2] = "a_prof_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	CASE "a_prof_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_prof_cod"
		ls_dwc[2] = "a_prof_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "da_codice_art"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_codice_art"
		ls_dwc[2] = "da_des_art"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_codice_art")) or This.GetItemString(1, "a_codice_art")='' then
           This.SetItem(1, "a_codice_art", Data)			
           This.SetItem(1, "a_des_art", This.GetItemString(1, "da_des_art"))			
	      end if 
			RETURN 2
		END IF
		
		
	CASE "da_des_art"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_codice_art"
		ls_dwc[2] = "da_des_art"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc) 	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_codice_art")) or This.GetItemString(1, "a_codice_art")='' then
           This.SetItem(1, "a_codice_art", This.GetItemString(1, "da_codice_art"))			
           This.SetItem(1, "a_des_art", Data)			
	      end if 
			RETURN 2
		END IF

	CASE "a_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	
	CASE 'da_sogg_cod'
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_sogg_cod"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_sogg_des"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_sogg_cod")) or This.GetItemString(1, "a_sogg_cod")='' then
           This.SetItem(1, "a_sogg_cod", Data)			
           This.SetItem(1, "a_sogg_des", This.GetItemString(1, "da_sogg_des"))			
	      end if 
			RETURN 2
		END IF
	
	
	CASE "da_sogg_des"
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_sogg_cod"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_sogg_des"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_sogg_cod")) or This.GetItemString(1, "a_sogg_cod")='' then
           This.SetItem(1, "a_sogg_cod", This.GetItemString(1, "da_sogg_des"))			
           This.SetItem(1, "a_sogg_des", Data)			
	      end if 
			RETURN 2
		END IF

	
	CASE 'a_sogg_cod'
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_sogg_cod"
		ls_dbc[2] = "rag_1_soc_1"
		ls_dwc[2] = "a_sogg_des"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	
	
	CASE "a_sogg_des"
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_sogg_cod"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_sogg_des"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF

END CHOOSE

end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1] = "da_mod_registro"
is_drop_column[2] = "da_mod_registro_des"
is_drop_column[3] = "a_mod_registro"
is_drop_column[4] = "a_mod_registro_des"

is_drop_column[5]	= "id_valuta"
is_drop_column[6]	= "id_valuta_des"

end event

event dw_selection::ue_initial;
long	ll_id_valuta 

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2679
int Height=1508
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2679
int Height=1508
end type

type cb_stampa from w_print_main`cb_stampa within w_stampa_documenti_art_rpt
int X=2245
int Y=60
end type

