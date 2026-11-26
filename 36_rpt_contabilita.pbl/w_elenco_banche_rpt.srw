forward
global type w_elenco_banche_rpt from w_print_main
end type
end forward

global type w_elenco_banche_rpt from w_print_main
int Width=2113
int Height=925
boolean TitleBar=true
string Title="Elenco delle banche"
end type
global w_elenco_banche_rpt w_elenco_banche_rpt

event open;call super::open;
String	ls_da_codice, ls_a_codice
String 	ls_statement, ls_statform
long		ll_da, ll_ad


ls_statement = ""
ls_da_codice = tab_1.tabpage_select.dw_selection.GetItemString(1,"codice1")
ls_a_codice = tab_1.tabpage_select.dw_selection.GetItemString(1,"codice2")

if ls_da_codice > ls_a_codice then
	if MessageBox( "Attenzione","Codice  'da' maggiore di Codice'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	
if not IsNull(ls_da_codice) and ls_da_codice <> "" then
	ls_statement	= ls_statement + "{banca_appoggio.cod_abi} >= '" + ls_da_codice + "'"
	ls_statform		= "'Da Codice ABI  " + ls_da_codice + "  "
else
	ls_statform		= "'Da Codice ABI non definito, "
end if

if not IsNull(ls_a_codice) and ls_a_codice <> "" then
	if not isNull( ls_da_codice ) and ls_da_codice <> "" then
		ls_statement	= ls_statement + " AND {banca_appoggio.cod_abi} <= '" + ls_a_codice + "'"
	ls_statform		= ls_statform + "a Codice ABI " + ls_a_codice + ".'"
	end if	
	if isNull( ls_da_codice ) or ls_da_codice = "" then
		ls_statement	= ls_statement + "{banca_appoggio.cod_abi}<= '" + ls_a_codice + "'"
		ls_statform		= "'Fino a Codice ABI " + ls_a_codice + ".'"
	end if	
else
	ls_statform  	= ls_statform + "a Codice ABI non definito.'"
end if

is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform

return 0



end event

on w_elenco_banche_rpt.create
call w_print_main::create
end on

on w_elenco_banche_rpt.destroy
call w_print_main::destroy
end on

type cb_esci from w_print_main`cb_esci within w_elenco_banche_rpt
int X=1811
end type

type tab_1 from w_print_main`tab_1 within w_elenco_banche_rpt
int Width=2012
int Height=621
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int Width=1975
int Height=493
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=28
int Y=29
int Width=1921
int Height=441
string DataObject="d_appoggio_rpt"
end type

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int Width=1975
int Height=493
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int Width=1975
int Height=493
end type

type cb_stampa from w_print_main`cb_stampa within w_elenco_banche_rpt
int X=1505
end type

