forward
global type w_banca_appoggioa_rpt from w_print_main
end type
end forward

global type w_banca_appoggioa_rpt from w_print_main
int Width=2478
int Height=1197
boolean TitleBar=true
string Title="Elenco delle Banche Appoggio"
end type
global w_banca_appoggioa_rpt w_banca_appoggioa_rpt

on w_banca_appoggioa_rpt.create
call w_print_main::create
end on

on w_banca_appoggioa_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
String	ls_da_codice, ls_ad_codice
String 	ls_statement, ls_statform
long		ll_da, ll_ad

ls_da_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 1, Primary!, TRUE)	
ls_ad_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 2, Primary!, TRUE)
ls_statement = ""


if ls_da_codice > ls_ad_codice then
	if MessageBox( "Attenzione","Banca 'da' maggiore di Banca 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if not IsNull(ls_da_codice) and ls_da_codice <> "" then
	ls_statement	= ls_statement + "{Banca_appoggio.Cod_ABI} >= '" + ls_da_codice + "'"
	ls_statform		= "'Da codice ABI " + ls_da_codice + ", "
else
	ls_statform		= "'Da codice ABI non definito, "
end if

if not IsNull(ls_ad_codice) and ls_ad_codice <> "" then
	if not isNull( ls_da_codice ) and ls_da_codice <> "" then
		ls_statement	= ls_statement + " AND {Banca_appoggio.Cod_ABI} <= '" + ls_ad_codice + "'"
		ls_statform		= ls_statform + "a Codice ABI " + ls_ad_codice + ".'"
	end if	
	if isNull( ls_da_codice ) or ls_da_codice = "" then
		ls_statement	= ls_statement + "{Banca_appoggio.Cod_ABI} <= '" + ls_ad_codice + "'"
		ls_statform		= "'Fino a Codice ABI " + ls_ad_codice + ".'"
	end if	
else
	ls_statform  	= ls_statform + "a Codice ABI non definito.'"
end if

is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform
							
return 0


end event

type cb_esci from w_print_main`cb_esci within w_banca_appoggioa_rpt
int X=2177
end type

type tab_1 from w_print_main`tab_1 within w_banca_appoggioa_rpt
int Width=2378
int Height=881
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2341
int Height=753
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=28
int Y=29
int Width=2286
int Height=701
string DataObject="d_banca_appoggio_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "da_abi", "ad_abi"
		is_search_window = "w_banca_appoggio_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cod_abi" 

	CASE "da_descr", "a_descr"
		is_search_window = "w_banca_appoggio_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "den_abi" 
		
END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "da_abi", "ad_abi"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_abi" then
			uf_set_colval("da_descr",is_ricpar.s_ausil_value[2])
		else
			uf_set_colval("a_descr",is_ricpar.s_ausil_value[2])
		end if

	CASE "da_descr", "a_descr"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_descr" then
			uf_set_colval("da_abi",is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("ad_abi",is_ricpar.s_ausil_value[1])
		end if
	
END CHOOSE

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2341
int Height=753
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2341
int Height=753
end type

type cb_stampa from w_print_main`cb_stampa within w_banca_appoggioa_rpt
int X=1925
end type

