forward
global type w_elenco_doc_sc_rpt from w_print_main
end type
end forward

global type w_elenco_doc_sc_rpt from w_print_main
int Width=2894
int Height=1232
boolean TitleBar=true
string Title="Stampa elenco documenti per Sogg. Commerciale"
end type
global w_elenco_doc_sc_rpt w_elenco_doc_sc_rpt

on w_elenco_doc_sc_rpt.create
call super::create
end on

on w_elenco_doc_sc_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval
string	ls_da_sogg,ls_a_sogg
string	ls_da_profilo,ls_a_profilo

string 	statement,ls_selezione
date		ld_da_data, ld_ad_data
ls_da_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sogg_cod")
ls_a_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sogg_cod")
ls_da_profilo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_prof_cod")
ls_a_profilo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_prof_cod")
ld_da_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_ad_data 			= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")
ls_da_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sogg_cod")
ls_a_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sogg_cod")
if not isNull(ls_da_profilo) and not isNull( ls_a_profilo ) then
	if ls_da_profilo > ls_a_profilo then
		if MessageBox( "Attenzione","Profilo 'da' maggiore di Profilo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	

end if

statement  = " {Sog_commerciale.id_azienda} = 1"

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


if Not IsNull(ls_da_sogg) and ls_da_sogg <> "" then
	statement 		= statement + "AND  {Sog_commerciale.Codice} >= '" + ls_da_sogg + "'"
	ls_selezione 	= ls_selezione + " Da soggetto " + ls_da_sogg + ", "
else
	ls_selezione 	= ls_selezione + " Da soggetto - non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + "AND {Sog_commerciale.Codice} <= '" + ls_a_sogg + "'"
	ls_selezione 	= ls_selezione + "a soggetto " + ls_a_sogg + "."
else
	ls_selezione 	= ls_selezione + "a soggetto - non definito."
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

is_selection 	= statement

istr_formule[1].formula_name 	= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))


return 0


end event

type cb_esci from w_print_main`cb_esci within w_elenco_doc_sc_rpt
int X=2519
int Y=80
end type

type tab_1 from w_print_main`tab_1 within w_elenco_doc_sc_rpt
int X=27
int Y=192
int Width=2830
int Height=940
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2793
int Height=812
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=23
int Y=32
int Width=2752
int Height=756
string DataObject="d_doc_sogg_comm_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;		
CHOOSE CASE as_nomecol
		CASE "da_sogg_cod"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="codice"
		CASE "a_sogg_cod"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="codice"
	case "da_sogg_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="rag_soc_1"
		case "a_sogg_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="rag_soc_1"
		
	
	CASE "da_prof_cod"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"
		CASE "a_prof_cod"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"
	case "da_prof_des"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"
		case "a_prof_des"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"
		
		
END CHOOSE


end event

event dw_selection::ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
		

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
		
END CHOOSE




end event

event dw_selection::itemchanged;call super::itemchanged;string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string	ls_cod,ls_des
long		ll_ok

choose case dwo.name
		case 'da_sogg_cod'

		select	"sog_commerciale"."codice",
					"anagrafica"."rag_soc_1"
			into	:ls_cod, :ls_des
			from	"dba"."sog_commerciale","dba"."anagrafica"  
			where "sog_commerciale"."codice" = :data;
			
		if sqlca.sqlcode=0 then
			setItem (row,"da_sogg_cod",ls_cod)
			setItem (row,"da_sogg_des",ls_des)
			setItem (row,"a_sogg_cod",ls_cod)
			setItem (row,"a_sogg_des",ls_des)
			return 2
		else
			setItem (row,"da_sogg_des",u_freddie.gs_null)
			return 0
		end if		
		
	
	case 'da_sogg_des'
		
		ls_sql_cond=""
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_sogg_cod"
		ls_dbc[2]=	"anagrafica_rag_soc_1"
		ls_dwc[2]=	"da_sogg_des"
		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale","anagrafica_rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
		
		if ll_ok	= 0 then
			return 2
		end if	
	case 'a_sogg_des'
		
		ls_sql_cond=""
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_sogg_cod"
		ls_dbc[2]=	"anagrafica_rag_soc_1"
		ls_dwc[2]=	"a_sogg_des"
		ll_ok = uf_autofind_col(dwo.name,"sog_commerciale","anagrafica_rag_soc_1",& 
		                         "A", data, ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
	
		if ll_ok	= 0 then
			return 2
		end if	
		
		
	
	case 'da_prof_des'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"da_prof_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"da_prof_des"
		ll_ok = uf_autofind_col(dwo.name,"prof_documento","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
												 
		if ll_ok	= 0 then
			return 2
		end if	
		
	case 'a_prof_des'
		
		ls_sql_cond=""  
		ls_dbc[1]=	"codice"
		ls_dwc[1]=	"a_prof_cod"
		ls_dbc[2]=	"descrizione"
		ls_dwc[2]=	"a_prof_des"
		ll_ok = uf_autofind_col(dwo.name,"prof_documento","descrizione","A",data,&
		                                ls_sql_cond,2,ls_dbc, ls_dbv, ls_dwc)
												  
		if ll_ok	= 0 then
			return 2
		end if	
	
end choose
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
int Width=2793
int Height=812
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2793
int Height=812
end type

type cb_stampa from w_print_main`cb_stampa within w_elenco_doc_sc_rpt
int X=2217
int Y=80
end type

