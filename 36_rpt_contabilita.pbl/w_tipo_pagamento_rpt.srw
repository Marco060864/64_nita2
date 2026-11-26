forward
global type w_tipo_pagamento_rpt from w_print_main
end type
end forward

global type w_tipo_pagamento_rpt from w_print_main
int Width=1569
int Height=1049
boolean TitleBar=true
string Title="Stampa tipo di pagamento"
end type
global w_tipo_pagamento_rpt w_tipo_pagamento_rpt

on w_tipo_pagamento_rpt.create
call w_print_main::create
end on

on w_tipo_pagamento_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
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
	ls_statement	= ls_statement + "{tipo_pagamento.codice} >= '" + ls_da_codice + "'"
	ls_statform		= "'Da Codice pagamento  " + ls_da_codice + "  "
else
	ls_statform		= "'Da Codice pagamento non definito, "
end if

if not IsNull(ls_a_codice) and ls_a_codice <> "" then
	if not isNull( ls_da_codice ) and ls_da_codice <> "" then
		ls_statement	= ls_statement + " AND {tipo_pagamento.codice} <= '" + ls_a_codice + "'"
	ls_statform		= ls_statform + "a Codice pagamento " + ls_a_codice + ".'"
	end if	
	if isNull( ls_da_codice ) or ls_da_codice = "" then
		ls_statement	= ls_statement + "{tipo_pagamento.codice}<= '" + ls_a_codice + "'"
		ls_statform		= "'Fino a Codice pagamento " + ls_a_codice + ".'"
	end if	
else
	ls_statform  	= ls_statform + "a Codice pagamento non definito.'"
end if

is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform

return 0



end event

type cb_esci from w_print_main`cb_esci within w_tipo_pagamento_rpt
int X=1303
int Y=61
end type

type tab_1 from w_print_main`tab_1 within w_tipo_pagamento_rpt
int Width=1505
int Height=765
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=1468
int Height=637
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=29
int Width=1390
int Height=561
string DataObject="d_stampa_tipo_pagamento_rpt"
end type

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "codice1"
is_drop_column[2] = "codice2"
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=1468
int Height=637
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=1468
int Height=637
end type

type cb_stampa from w_print_main`cb_stampa within w_tipo_pagamento_rpt
int X=1052
int Y=61
end type

