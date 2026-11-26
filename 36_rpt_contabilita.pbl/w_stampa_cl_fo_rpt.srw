forward
global type w_stampa_cl_fo_rpt from w_print_main
end type
end forward

global type w_stampa_cl_fo_rpt from w_print_main
int Width=2295
int Height=933
boolean TitleBar=true
string Title="Stampa Elenco Anagrafiche"
end type
global w_stampa_cl_fo_rpt w_stampa_cl_fo_rpt

on w_stampa_cl_fo_rpt.create
call w_print_main::create
end on

on w_stampa_cl_fo_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
String	ls_da_rag_soc, ls_ad_rag_soc
String 	ls_statement, ls_statform
long		ll_da, ll_ad

ls_da_rag_soc = tab_1.tabpage_select.dw_selection.GetItemString(1, 1, Primary!, TRUE)	
ls_ad_rag_soc = tab_1.tabpage_select.dw_selection.GetItemString(1, 2, Primary!, TRUE)
ls_statement = ""


if ls_da_rag_soc > ls_ad_rag_soc then
	if MessageBox( "Attenzione","Rag_soc1 'da' maggiore di Rag_soc2 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if not IsNull(ls_da_rag_soc) and ls_da_rag_soc <> "" then
	ls_statement	= ls_statement + "{anagrafica.rag_soc_1} >= '" + ls_da_rag_soc + "'"
	ls_statform		= "'Ragione Sociale " + ls_da_rag_soc + ", "
else
	ls_statform		= "'Da Rag_Soc non definita, "
end if

if not IsNull(ls_ad_rag_soc) and ls_ad_rag_soc <> "" then
	if not isNull( ls_da_rag_soc ) and ls_da_rag_soc <> "" then
		ls_statement	= ls_statement + " AND {anagrafica.rag_soc_1} <= '" + ls_ad_rag_soc + "'"
		ls_statform		= ls_statform + "a Rag_Sociale " + ls_ad_rag_soc + ".'"
	end if	
	if isNull( ls_da_rag_soc ) or ls_da_rag_soc = "" then
		ls_statement	= ls_statement + "{anagrafica.rag_soc_1}<= '" + ls_ad_rag_soc + "'"
		ls_statform		= "'Fino a Ragione_Sociale " + ls_ad_rag_soc + ".'"
	end if	
else
	ls_statform  	= ls_statform + "a Ragione Sociale non definito.'"
end if


is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform
							

return 0



end event

type cb_esci from w_print_main`cb_esci within w_stampa_cl_fo_rpt
int X=2012
end type

type tab_1 from w_print_main`tab_1 within w_stampa_cl_fo_rpt
int Width=2222
int Height=641
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2186
int Height=513
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=14
int Y=21
int Width=2158
int Height=457
string DataObject="d_anag_clfo_ff"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
	CASE "rag_1"
		is_search_window = "w_anagrafica_sw" 	
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "rag_soc" 			
	CASE "rag_2"
		is_search_window = "w_anagrafica_sw" 	
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "rag_soc" 			

END CHOOSE



end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "rag_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
	CASE "rag_2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
END CHOOSE

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2186
int Height=513
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2186
int Height=513
end type

type cb_stampa from w_print_main`cb_stampa within w_stampa_cl_fo_rpt
int X=1751
end type

