forward
global type w_banche_rpt from w_print_main
end type
end forward

global type w_banche_rpt from w_print_main
int Height=1081
boolean TitleBar=true
string Title="Elenco banche"
end type
global w_banche_rpt w_banche_rpt

on w_banche_rpt.create
call w_print_main::create
end on

on w_banche_rpt.destroy
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
	ls_statement	= ls_statement + "{sog_commerciale.codice} >= '" + ls_da_codice + "'"
	ls_statform		= "'Da sogg. commerciale " + ls_da_codice + ", "
else
	ls_statform		= "'Da sogg. commerciale non definito, "
end if

if not IsNull(ls_ad_codice) and ls_ad_codice <> "" then
	if not isNull( ls_da_codice ) and ls_da_codice <> "" then
		ls_statement	= ls_statement + " AND {sog_commerciale.codice} <= '" + ls_ad_codice + "'"
		ls_statform		= ls_statform + "a sogg. commerciale " + ls_ad_codice + ".'"
	end if	
	if isNull( ls_da_codice ) or ls_da_codice = "" then
		ls_statement	= ls_statement + "{sog_commerciale.codice} <= '" + ls_ad_codice + "'"
		ls_statform		= "'Fino a sogg. commerciale " + ls_ad_codice + ".'"
	end if	
else
	ls_statform  	= ls_statform + "a sogg. commerciale non definito.'"
end if

is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform
return 0


end event

type cb_esci from w_print_main`cb_esci within w_banche_rpt
int X=1601
int Y=49
end type

type tab_1 from w_print_main`tab_1 within w_banche_rpt
int Height=785
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=1765
int Height=657
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Height=541
string DataObject="d_elencobanca_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "codice1"
		is_search_window = "w_banche_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "codice2"
		is_search_window = "w_banche_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 

END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "codice1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
	CASE "codice2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
END CHOOSE

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=1765
int Height=657
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=1765
int Height=657
end type

type cb_stampa from w_print_main`cb_stampa within w_banche_rpt
int X=1299
int Y=49
end type

