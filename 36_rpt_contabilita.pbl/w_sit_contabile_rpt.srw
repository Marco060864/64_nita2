forward
global type w_sit_contabile_rpt from w_print_main
end type
end forward

global type w_sit_contabile_rpt from w_print_main
int Width=2423
int Height=1196
boolean TitleBar=true
string Title="Sit. Contabile Mensile dei Soggetti"
end type
global w_sit_contabile_rpt w_sit_contabile_rpt

type variables
string ls_sel
end variables

on w_sit_contabile_rpt.create
call super::create
end on

on w_sit_contabile_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
String	ls_da_rag_soc, ls_ad_rag_soc, ls_es, ls_da_codice, ls_ad_codice
String 	ls_statement, ls_statform
long		ll_da, ll_ad

ls_es = tab_1.tabpage_select.dw_selection.GetItemString(1, 3, Primary!, TRUE)	

ls_da_rag_soc = tab_1.tabpage_select.dw_selection.GetItemString(1, "rag_1")	
ls_ad_rag_soc = tab_1.tabpage_select.dw_selection.GetItemString(1, "rag_2")

ls_da_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 5, Primary!, TRUE)	
ls_ad_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 6, Primary!, TRUE)


ls_statement = ""

ls_statement = "{esercizio.codice} = '" + ls_es + "' and "


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


if not IsNull(ls_da_codice) and ls_da_codice <> "" then
	ls_statement	= ls_statement + "{sog_commerciale.codice} >= '" + ls_da_codice + "'"
	ls_statform		= "'Codice " + ls_da_codice + ", "
else
	ls_statform		= "'Da codice non definita, "
end if

if not IsNull(ls_ad_codice) and ls_ad_codice <> "" then
	if not isNull( ls_da_codice ) and ls_da_codice <> "" then
		ls_statement	= ls_statement + " AND {sog_commerciale.codice} <= '" + ls_ad_codice+ "'"
		ls_statform		= ls_statform + "a codice " + ls_ad_codice + ".'"
	end if	
	if isNull( ls_da_codice ) or ls_da_codice = "" then
		ls_statement	= ls_statement + "{sog_commerciale.codice} <= '" + ls_ad_codice + "'"
		ls_statform		= "'Fino a codice " + ls_ad_codice + ".'"
	end if	
else
	ls_statform  	= ls_statform + "a codice non definito.'"
end if


is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0



end event

type cb_esci from w_print_main`cb_esci within w_sit_contabile_rpt
int X=2135
int Y=76
end type

type tab_1 from w_print_main`tab_1 within w_sit_contabile_rpt
int X=27
int Width=2354
int Height=912
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2318
int Height=784
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=52
int Width=2194
int Height=676
string DataObject="d_anag_ff"
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
		
	CASE "cod_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "codice" 
	CASE "cod_2"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "codice" 	

		

END CHOOSE



end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "rag_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
	CASE "rag_2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	CASE "cod_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	CASE "cod_2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			
		
END CHOOSE

end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "es"

ls_sel = 'N'

is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"

end event

event dw_selection::itemchanged;call super::itemchanged;CHOOSE CASE dwo.Name
	CASE "selezione"
		ls_sel = dw_selection.getitemstring(1, "selezione")
	if ls_sel = 'N' then
			dw_selection.object.rag_1.protect = 1	
			dw_selection.object.rag_2.protect = 1
			dw_selection.object.cod_1.protect = 0	
			dw_selection.object.cod_2.protect = 0
		else
			dw_selection.object.rag_1.protect = 0
			dw_selection.object.rag_2.protect = 0
			dw_selection.object.cod_1.protect = 1	
			dw_selection.object.cod_2.protect = 1
	end if
 END CHOOSE		

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
int Width=2318
int Height=784
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2318
int Height=784
end type

type cb_stampa from w_print_main`cb_stampa within w_sit_contabile_rpt
int X=1874
int Y=76
end type

