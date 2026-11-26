forward
global type w_centro_costo_rpt from w_print_main
end type
end forward

global type w_centro_costo_rpt from w_print_main
int Width=2236
int Height=1029
boolean TitleBar=true
string Title="Centri di costo"
end type
global w_centro_costo_rpt w_centro_costo_rpt

on w_centro_costo_rpt.create
call w_print_main::create
end on

on w_centro_costo_rpt.destroy
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
	if MessageBox( "Attenzione","Codice conto 'da' maggiore di Codice conto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if not IsNull(ls_da_codice) and ls_da_codice <> "" then
	ls_statement	= ls_statement + "{conto.codice} >= '" + ls_da_codice + "'"
	ls_statform		= "'Da Codice conto " + ls_da_codice + ", "
else
	ls_statform		= "'Da Codice conto non definito, "
end if

if not IsNull(ls_ad_codice) and ls_ad_codice <> "" then
	if not isNull( ls_da_codice ) and ls_da_codice <> "" then
		ls_statement	= ls_statement + " AND {conto.codice} <= '" + ls_ad_codice + "'"
		ls_statform		= ls_statform + "Codice conto " + ls_ad_codice + ".'"
	end if	
	if isNull( ls_da_codice ) or ls_da_codice = "" then
		ls_statement	= ls_statement + "{conto.codice} <= '" + ls_ad_codice + "'"
		ls_statform		= "'Fino a Codice conto " + ls_ad_codice + ".'"
	end if	
else
	ls_statform  	= ls_statform + "a Codice conto non definito.'"
end if

is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform
return 0


end event

type cb_esci from w_print_main`cb_esci within w_centro_costo_rpt
int X=1966
int Y=49
end type

type tab_1 from w_print_main`tab_1 within w_centro_costo_rpt
int Y=201
int Width=2172
int Height=721
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2135
int Height=593
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Width=2030
int Height=521
string DataObject="d_centro_cos_des_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "codice1"
		is_search_window = "w_centro_c_ra_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "codice2"
		is_search_window = "w_centro_c_ra_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
				
	CASE "codice3"
		is_search_window = "w_centro_c_ra_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		
	CASE "codice4"
		is_search_window = "w_centro_c_ra_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 

END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "codice1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto",is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice3",is_ricpar.s_ausil_value[1])
		
	CASE "codice2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto",is_ricpar.s_id_seg_value[1])
		uf_set_colval("codice4",is_ricpar.s_ausil_value[1])
END CHOOSE

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2135
int Height=593
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2135
int Height=593
end type

type cb_stampa from w_print_main`cb_stampa within w_centro_costo_rpt
int X=1687
int Y=49
end type

