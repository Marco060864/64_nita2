forward
global type w_stampa_doc_sogg_com_rpt from w_print_main
end type
end forward

global type w_stampa_doc_sogg_com_rpt from w_print_main
int Width=2679
int Height=1484
boolean TitleBar=true
string Title="Stampa Documenti per Soggetto Commerciale"
end type
global w_stampa_doc_sogg_com_rpt w_stampa_doc_sogg_com_rpt

on w_stampa_doc_sogg_com_rpt.create
call super::create
end on

on w_stampa_doc_sogg_com_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval
string	ls_da_profilo, ls_a_profilo, ls_da_soggetto, ls_a_soggetto,ls_stato_righe  
String  li_da_prot,li_a_prot
date		ld_da_data, ld_a_data
String 	statement, ls_selezione
date     ld_da_data_scad, ld_a_data_scad 
ls_da_soggetto   = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sogg_cod")
ls_a_soggetto   = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sogg_cod")
li_da_prot       = (tab_1.tabpage_select.dw_selection.GetItemString(1,"da_protocollo"))
li_a_prot          =( tab_1.tabpage_select.dw_selection.GetItemString(1,"a_protocollo"))
ls_da_profilo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_prof_cod")
ls_a_profilo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_prof_cod")
ld_da_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_a_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")
ls_stato_righe    = tab_1.tabpage_select.dw_selection.GetItemString(1,"stato_righe")
ld_da_data_scad	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data_scad")
ld_a_data_scad		= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data_scad")

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

if ld_da_data_scad > ld_a_data_scad then
	if MessageBox( "Attenzione","Data Scadenza 'da' maggiore di Data Scadenza 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ls_da_soggetto > ls_a_soggetto then
	if MessageBox( "Attenzione","soggetto 'da' maggiore di Soggetto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	
statement  = " {Documento.ID_Azienda} = 1"


if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data registrazione " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dalla data registrazione - non definita, "
end if

if Not IsNull(ld_a_data) then
	statement 		= statement + " AND {Documento.Data_Registrazione} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data registrazione " + string(ld_a_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "alla data registrazione - non definita."
end if


if Not IsNull(ld_da_data_scad) then
	statement 		= statement + " AND {Documento.Data_scadenza} >= Date (" + string(ld_da_data_scad, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Dalla data scadenza " + string(ld_da_data_scad, "dd/mm/yyyy") + ", "
else
	ls_selezione 	= " Dalla data scadenza - non definita, "
end if

if Not IsNull(ld_a_data_scad) then
	statement 		= statement + " AND {Documento.Data_scadenza} <= Date (" + string(ld_a_data_scad, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "alla data scadenza " + string(ld_a_data_scad, "dd/mm/yyyy") + "."
else
	ls_selezione 	= ls_selezione + "alla data scadenza - non definita."
end if
if Not IsNull(ls_da_soggetto) and ls_da_soggetto <> "" then
	statement 		= statement + " AND {Sog_commerciale_gen.Codice} >= '" + ls_da_soggetto + "'"
	ls_selezione 	= ls_selezione + " Da soggetto " + ls_da_soggetto + ", "
else
	ls_selezione 	= ls_selezione + " Da soggetto - non definito, "
end if

if Not IsNull(ls_a_soggetto) and ls_a_soggetto <> "" then
	statement 		= statement + " AND {Sog_commerciale_gen.Codice} <= '" + ls_a_soggetto + "'"
	ls_selezione 	= ls_selezione + "a soggetto " + ls_a_soggetto + "."
else
	ls_selezione 	= ls_selezione + "a soggetto - non definito."
end if

if Not IsNull (li_da_prot) then
	statement 		= statement + " AND {Documento.num_progressivo} >= " + (li_da_prot) + " "
ls_selezione 	= ls_selezione + " Da Protocollo " + (li_da_prot) + ", "
else
	ls_selezione 	= ls_selezione + " Da Protocollo - non definito, "
end if

if Not IsNull(li_a_prot) and (li_a_prot) <> "" then
	statement 		= statement + " AND {Documento.num_progressivo} <= " + (li_a_prot) + " "
	ls_selezione 	= ls_selezione + "a protocollo " + (li_a_prot) + "."
else
	ls_selezione 	= ls_selezione + "a protocollo - non definito."
end if	



if Not IsNull(ls_da_profilo) and ls_da_profilo <> "" then
	statement 		= statement + " AND {Prof_documento.Codice} >= '" + ls_da_profilo + "'"
	ls_selezione 	= ls_selezione + " Da profilo " + ls_da_profilo + ", "
else
	ls_selezione 	= ls_selezione + " Da profilo non definito, "
end if

if Not IsNull(ls_a_profilo) and ls_a_profilo <> "" then
	statement 		= statement + " AND {Prof_documento.Codice} <= '" + ls_a_profilo + "'"
	ls_selezione 	= ls_selezione + " a profilo " + ls_a_profilo + ", "
else
	ls_selezione 	= ls_selezione+" a profilo non definito, "
end if






if IsNull(ls_stato_righe) or ls_stato_righe = "" then
	ls_stato_righe = "Nullo"
end if	

if ls_stato_righe = "I" then
	ls_selezione = ls_selezione + "Inevasa."
end if

if ls_stato_righe ="E" then
	ls_selezione = ls_selezione + "Evasa."
end if

if Ls_stato_righe ="C" then

	ls_selezione = ls_selezione + "Consegnata."
end if	


is_selection 	= statement


istr_formule[1].formula_name 	= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
istr_formule[2].formula_name 		= "Inevaso"
istr_formule[2].formula_string 	= "'" + ls_stato_righe + "'"
istr_formule[3].formula_name 		= "Evaso"
istr_formule[3].formula_string 	= "'" + ls_stato_righe + "'"
istr_formule[4].formula_name 		= "Contabilizzato"
istr_formule[4].formula_string 	= "'" + ls_stato_righe + "'"
istr_formule[5].formula_name 	= "sel"
istr_formule[5].formula_string 	= " " + li_da_prot + " "
istr_formule[6].formula_name 	= "sel"
istr_formule[6].formula_string 	= " " + li_a_prot + " "

istr_formule[7].formula_name 		= "id_valuta"
istr_formule[7].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0

end event

type cb_esci from w_print_main`cb_esci within w_stampa_doc_sogg_com_rpt
int X=2414
end type

type tab_1 from w_print_main`tab_1 within w_stampa_doc_sogg_com_rpt
int Y=216
int Width=2615
int Height=1164
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2578
int Height=1036
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=18
int Y=20
int Width=2546
int Height=968
string DataObject="d_scheda_doc_sog_rpt"
boolean LiveScroll=false
end type

event dw_selection::ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	
	
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

event dw_selection::ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
		
	
	
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
			uf_set_colval("a_prof_des", is_ricpar.s_ausil_value[1])
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
end event

event dw_selection::ue_init;call super::ue_init;
is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"

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
int Width=2578
int Height=1036
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2578
int Height=1036
end type

type cb_stampa from w_print_main`cb_stampa within w_stampa_doc_sogg_com_rpt
int X=2121
end type

