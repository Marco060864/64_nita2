forward
global type w_scheda_fornitori_prova_rpt from w_print_main
end type
end forward

global type w_scheda_fornitori_prova_rpt from w_print_main
int Width=2757
int Height=1584
boolean TitleBar=true
string Title="Scheda Articolo"
end type
global w_scheda_fornitori_prova_rpt w_scheda_fornitori_prova_rpt

on w_scheda_fornitori_prova_rpt.create
call super::create
end on

on w_scheda_fornitori_prova_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
string	ls_da_articolo,ls_a_articolo
string	ls_da_sogg,ls_a_sogg
string	ls_da_profilo,ls_a_profilo,ls_sort
string	ls_da_caus,ls_a_caus
string 	statement,ls_selezione,ls_tipo_met
date		ld_da_data, ld_ad_data
integer	li_tipo_doc

ls_da_articolo 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_articolo_cod")
ls_a_articolo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_articolo_cod")
ls_da_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sogg_cod")
ls_a_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sogg_cod")
ls_da_caus		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_caus_cod")
ls_a_caus		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_caus_cod")
ld_da_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_ad_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")
ls_tipo_met 		= tab_1.tabpage_select.dw_selection.GetItemstring(1,"metallo")

if  isNull(ls_tipo_met) and (ls_tipo_met=" ") then
	if MessageBox( "Attenzione","Non è stato inserito il tipo di metallo " ) =2 then
			return -1
	end if	
end if

if not isNull(ls_da_articolo) and not isNull(ls_a_articolo) then
	if ls_da_articolo > ls_a_articolo then
		if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ls_da_sogg) and not isNull( ls_a_sogg ) then
	if ls_da_sogg > ls_a_sogg then
		if MessageBox( "Attenzione","Soggetto 'da' maggiore di Soggetto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if


if not isNull(ls_da_caus) and not isNull( ls_a_caus ) then
	if ls_da_caus > ls_a_caus then
		if MessageBox( "Attenzione","Causale 'da' maggiore di Causale 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if

if not isNull(ld_da_data) and not isNull( ld_ad_data ) then
	if ld_da_data > ld_ad_data then
		if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if	

statement  = " ({caus_magazzino.saldi_cl_fino} = '+' or {caus_magazzino.saldi_cl_fino}= '-' )"
if Not IsNull(ls_tipo_met) and ls_tipo_met <> "" then
	statement 		= statement + " AND {orafo_metallo.cod_int_met} >= '" + ls_tipo_met + "'"
	ls_selezione 	= ls_selezione + " Tipo metallo" + ls_tipo_met + ", "
else
	ls_selezione 	= " Tipo metallo  - non definito, "
end if


if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	ls_selezione 	= " Dalla data registrazione - non definita, "	
end if

if Not IsNull(ld_ad_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} <= Date (" + string(ld_ad_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_ad_data, "dd/mm/yyyy") + "."
else
	ls_selezione = ls_selezione + "alla data registrazione - non definita."
end if

if Not IsNull(ls_da_articolo) and ls_da_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} >= '" + ls_da_articolo + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_articolo + ", "
else
	ls_selezione 	= " Da articolo  - non definito, "
end if

if Not IsNull(ls_a_articolo) and ls_a_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} <= '" + ls_a_articolo + "'"
	ls_selezione 	= ls_selezione + "a articolo " + ls_a_articolo + "."
else
	ls_selezione 	= ls_selezione + "a articolo - non definito."
end if

if Not IsNull(ls_da_sogg) and ls_da_sogg <> "" then
	statement 		= statement + " AND {Sog_commerciale_gen.rag_soc_1} >= '" + ls_da_sogg + "'"
	ls_selezione 	= ls_selezione + " Da soggetto " + ls_da_sogg + ", "
else
	ls_selezione 	= " Da soggetto non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {sog_commerciale_gen.rag_soc_1} <= '" + ls_a_sogg + "'"
	ls_selezione 	= ls_selezione + "a soggetto " + ls_a_sogg + "."
else
	ls_selezione 	= ls_selezione + "a soggetto non definito."
end if

if Not IsNull(ls_da_caus) and ls_da_caus <> "" then
	statement 		= statement + " AND {Caus_magazzino.Codice} >= '" + ls_da_caus + "'"
	
	ls_selezione 	= ls_selezione + " Da causale " + ls_da_caus + ", "
else
	ls_selezione 	= " Da causale non definito, "
end if

if Not IsNull(ls_a_caus) and ls_a_caus <> "" then
	statement 		= statement + " AND {Caus_magazzino.Codice} <= '" + ls_a_caus + "'"
	ls_selezione 	= ls_selezione + "a causale " + ls_a_caus + "."
else
	ls_selezione 	= ls_selezione + "a causale non definito."
end if

is_selection = statement
istr_formule[1].formula_name 		= 'selezione'
istr_formule[1].formula_string 	= "'"+ ls_selezione + "'"

return 0


end event

type cb_esci from w_print_main`cb_esci within w_scheda_fornitori_prova_rpt
int X=2469
int Y=76
end type

type tab_1 from w_print_main`tab_1 within w_scheda_fornitori_prova_rpt
int X=27
int Width=2697
int Height=1300
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2661
int Height=1172
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=55
int Y=56
int Width=2560
int Height=1080
string DataObject="d_scheda_fornitore_provarpt"
end type

event dw_selection::ue_set_search;



CHOOSE CASE as_nomecol
		
	CASE "da_articolo_cod", "da_articolo_des"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "da_articolo_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "da_articolo_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE
	CASE "a_articolo_cod", "a_articolo_des"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "a_articolo_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "a_articolo_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF

			
	CASE "da_sogg_cod", "da_sogg_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "da_sogg_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "da_sogg_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF


	CASE "a_sogg_cod", "a_sogg_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "a_sogg_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "a_sogg_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF


END CHOOSE	



end event

event dw_selection::ue_use_search;			
choose case as_nomecol
			
	CASE "da_sogg_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_sogg_des", is_ricpar.s_ausil_value[1])
		if isnull(this.getitemstring(1,'a_sogg_cod')) or this.getitemstring(1,'a_sogg_cod')='' then
		   uf_set_colval("a_sogg_cod", is_ricpar.s_main_value)
		   uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_sogg_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	
		uf_set_colval("da_sogg_cod", is_ricpar.s_ausil_value[1])
		if isnull(this.getitemstring(1,'a_sogg_cod')) or this.getitemstring(1,'a_sogg_cod')='' then
		   uf_set_colval("a_sogg_des", is_ricpar.s_main_value)
		   uf_set_colval("a_sogg_cod", is_ricpar.s_ausil_value[1])
	   end if
		
	CASE "a_sogg_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])

	CASE "a_sogg_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_sogg_cod", is_ricpar.s_ausil_value[1])
	CASE "da_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_articolo_des", is_ricpar.s_ausil_value[1])
		if isnull(this.getitemstring(1,'a_articolo_cod')) or this.getitemstring(1,'a_articolo_cod')='' then
		   uf_set_colval("a_articolo_cod", is_ricpar.s_main_value)
		   uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])
		end if	
		
	CASE "da_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	
		uf_set_colval("da_articolo_cod", is_ricpar.s_ausil_value[1])
		if isnull(this.getitemstring(1,'a_articolo_cod')) or this.getitemstring(1,'a_articolo_cod')='' then
		  uf_set_colval("a_articolo_des", is_ricpar.s_main_value)
		  uf_set_colval("a_articolo_cod", is_ricpar.s_ausil_value[1])
	   end if 
		
	CASE "a_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])

	CASE "a_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_articolo_cod", is_ricpar.s_ausil_value[1])
END CHOOSE


end event

event dw_selection::itemchanged;


integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "da_articolo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo_cod"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
			

		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,'a_articolo_cod')) or this.getitemstring(1,'a_articolo_cod')='' then
				  This.SetItem(1, "a_articolo_cod", Data)			
              This.SetItem(1, "a_articolo_des", This.GetItemString(1, "da_articolo_des"))
			end if
			RETURN 2
		END IF
		
		
	case "da_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo_cod"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,'a_articolo_cod')) or this.getitemstring(1,'a_articolo_cod')='' then
				 This.SetItem(1, "a_articolo_des", Data)			
             This.SetItem(1, "a_articolo_cod", This.GetItemString(1, "da_articolo_cod"))
			end if
			RETURN 2
		END IF

	case "a_articolo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo_cod"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

	
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo_cod"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF



		CASE "da_sogg_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_sogg_cod"
		ls_dwc[2] = "da_sogg_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
			
     

		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,'a_sogg_cod')) or this.getitemstring(1,'a_sogg_cod')='' then
				  This.SetItem(1, "a_sogg_cod", Data)			
              This.SetItem(1, "a_sogg_des", This.GetItemString(1, "da_sogg_des"))
			end if
			RETURN 2
		END IF
		
		
	case "da_sogg_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_sogg_cod"
		ls_dwc[2] = "da_sogg_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
				
		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,'a_sogg_cod')) or this.getitemstring(1,'a_sogg_cod')='' then
				 This.SetItem(1, "a_sogg_des", Data)			
             This.SetItem(1, "a_sogg_cod", This.GetItemString(1, "da_sogg_cod"))
			end if
			RETURN 2
		END IF

	case "a_sogg_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_sogg_cod"
		ls_dwc[2] = "a_sogg_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_sogg_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_sogg_cod"
		ls_dwc[2] = "a_sogg_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
end choose







		
	
		
	
	
end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "da_caus_cod"
is_drop_column[2]	= "da_caus_des"
is_drop_column[3]	= "a_caus_cod"
is_drop_column[4]	= "a_caus_des"

end event

event dw_selection::ue_initial;call super::ue_initial;
string	ls_data_oggi
date 		ld_inizio_esercizio

SELECT esercizio.data_inizio INTO :ld_inizio_esercizio
	FROM dba.esercizio WHERE esercizio.id_azienda = 1 ;			
	
this.SetItem(1, "dalla_data",ld_inizio_esercizio )
this.SetItem( 1,"alla_data",Today() )

end event

event dw_selection::itemfocuschanged;call super::itemfocuschanged;
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2661
int Height=1172
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2661
int Height=1172
end type

type cb_stampa from w_print_main`cb_stampa within w_scheda_fornitori_prova_rpt
int X=2199
int Y=76
end type

