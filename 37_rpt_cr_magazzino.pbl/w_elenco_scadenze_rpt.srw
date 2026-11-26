forward
global type w_elenco_scadenze_rpt from w_print_main
end type
end forward

global type w_elenco_scadenze_rpt from w_print_main
int Width=2674
int Height=1072
boolean TitleBar=true
string Title="Scadenze per mese"
end type
global w_elenco_scadenze_rpt w_elenco_scadenze_rpt

on w_elenco_scadenze_rpt.create
call super::create
end on

on w_elenco_scadenze_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
string	ls_tipo_scadenza, ls_distinta,ls_da_paga,ls_a_paga
date		ld_da_data, ld_a_data
String 	statement, ls_selezione
long ll_null
setnull(ll_null)

ld_da_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"dalla_data")
ld_a_data				= tab_1.tabpage_select.dw_selection.GetItemDate(1,"alla_data")

if ld_da_data > ld_a_data then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if

ls_da_Paga           = tab_1.tabpage_select.dw_selection.GetitemString(1,"da_pag_cod")
ls_a_Paga            = tab_1.tabpage_select.dw_selection.GetitemString(1,"a_pag_cod")
if ls_da_paga > ls_a_paga then
	if MessageBox( "Attenzione","pagamento 'da' maggiore di pagamento 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

ls_distinta		= tab_1.tabpage_select.dw_selection.GetItemString(1,"esito_pagamento")


statement  = " {Scadenza.ID_azienda} = 1"

if Not IsNull(ld_da_data) then
	statement 		= statement + " AND {Scadenza.Data_Scadenza} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " DAL PERIODO " + string(ld_da_data, "dd/mm/yyyy") + ", "
else
	
	ls_selezione 	= " Dal Periodo - - non definito, "
end if

if Not IsNull(ld_a_data) then
	statement 		= statement + " AND {Scadenza.Data_Scadenza} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "AL PERIODO " + string(ld_a_data, "dd/mm/yyyy") + "."
else
	
	ls_selezione 	= ls_selezione + "Al Periodo  - - non definito."
end if


if Not IsNull(ls_da_paga) and ls_da_paga <> "" then
	statement 		= statement + " AND {tipo_pagamento.Codice} >= '" + ls_da_paga  + "'"
	ls_selezione 	= ls_selezione + " Da Pagamento " + ls_da_paga + ", "
else
	ls_selezione 	= ls_selezione +" Da pagamento non definito, "
end if

if Not IsNull(ls_a_paga) and ls_a_paga <> "" then
	statement 		= statement + " AND {tipo_pagamento.Codice} <= '" + ls_a_paga + "'"
	ls_selezione 	= ls_selezione + "a pagamento " + ls_a_paga  + "."
else
	ls_selezione 	= ls_selezione + "a pagamento non definito."
end if

if ls_distinta='S' then
	statement 		= statement + " AND {Scadenza.id_riga_distinta_banca} >0 "
	ls_selezione 	= ls_selezione + " Distinta: " + ls_distinta + "."
else
	statement 		= statement + " AND isnull({Scadenza.id_riga_distinta_banca})=true "
	ls_selezione 	= ls_selezione + " Distinta: " + ls_distinta + "."
end if


is_selection 	= statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0

end event

type cb_esci from w_print_main`cb_esci within w_elenco_scadenze_rpt
int X=2318
int Y=92
end type

type tab_1 from w_print_main`tab_1 within w_elenco_scadenze_rpt
int X=37
int Y=220
int Width=2601
int Height=752
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2565
int Height=624
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=23
int Y=20
int Width=2519
int Height=588
string DataObject="d_elenco_scadenze_rpt"
end type

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "da_pag_cod"
is_drop_column[2]	= "da_pag_des"
is_drop_column[3]	= "a_pag_cod"
is_drop_column[4]	= "a_pag_des"

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
int Width=2565
int Height=624
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2565
int Height=624
end type

type cb_stampa from w_print_main`cb_stampa within w_elenco_scadenze_rpt
int X=2034
int Y=92
end type

