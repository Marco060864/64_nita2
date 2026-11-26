forward
global type w_riep_mag_cx from w_print_main
end type
end forward

global type w_riep_mag_cx from w_print_main
int Width=2703
int Height=1190
boolean TitleBar=true
string Title="Stampa Riepiloghi di Magazzino per Articolo"
end type
global w_riep_mag_cx w_riep_mag_cx

on w_riep_mag_cx.create
call super::create
end on

on w_riep_mag_cx.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
String	ls_da_codice, ls_ad_codice
String 	ls_statement, ls_statform
String   ls_da_cod_mag, ls_a_cod_mag, ls_a_desc_mag, ls_da_desc_mag
ls_da_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 1, Primary!, TRUE)	
ls_ad_codice = tab_1.tabpage_select.dw_selection.GetItemString(1, 1, Primary!, TRUE)	

ls_da_cod_mag=tab_1.tabpage_select.dw_selection.getitemstring(1,"da_cod_mag")
ls_a_cod_mag=tab_1.tabpage_select.dw_selection.getitemstring(1,"a_cod_mag")

if ls_da_codice > ls_ad_codice then
	if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ls_da_cod_mag > ls_a_cod_mag then
	if MessageBox( "Attenzione","Magazzino 'da' maggiore di Magazzino 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	


ls_statement  = "{Articolo.ID_Azienda} = 1"


if not IsNull(ls_da_codice) and ls_da_codice <> "" then
	ls_statement	= ls_statement + " AND {Articolo.Codice} >= '" + ls_da_codice + "'"
	ls_statform		= "'Da codice " + ls_da_codice + ", "
else
	ls_statform		= "'Da codice non definito, "
end if

if not IsNull(ls_ad_codice) and ls_ad_codice <> "" then
	ls_statement	= ls_statement + " AND {Articolo.Codice} <= '" + ls_ad_codice + "'"
	ls_statform		= ls_statform + "a codice " + ls_ad_codice + ".'"
else
	ls_statform		= ls_statform + "a codice non definito.'"
end if

if not isnull(ls_da_cod_mag) and ls_da_cod_mag <> "" then
	ls_statement   = ls_statement + " AND {Magazzino.Codice} >= '" + ls_a_cod_mag + "'"
	ls_statform    = "'Da magazzino " + ls_da_cod_mag + ", "
else
	ls_statform    = "' Da magazzino non definito, "
end if

if not IsNull(ls_a_cod_mag) and ls_a_cod_mag <> "" then
	ls_statement	= ls_statement + " AND {Magazzino.Codice} <= '" + ls_a_cod_mag + "'"
	ls_statform		= ls_statform + "a codice " + ls_a_cod_mag + ".'"
else
	ls_statform		= ls_statform + "a magazzino non definito.'"
end if


is_selection = ls_statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= ls_statform

istr_formule[2].formula_name   ="selezione"
istr_formule[2].formula_string = ls_statform
							
return 0
end event

event open;call super::open;date dat2, dat1

dat1 = date('1999/01/01')

IF tab_1.tabpage_select.dw_selection.GetRow() = 0 THEN
	tab_1.tabpage_select.dw_selection.InsertRow(0)

	
	select max(data_fine)
		into :dat2
		from esercizio;
		
	tab_1.tabpage_select.dw_selection.setitem(1, 'd_in', dat1 )
	tab_1.tabpage_select.dw_selection.setitem(1, 'd_fin', dat2)	
	
END IF
end event

type cb_esci from w_print_main`cb_esci within w_riep_mag_cx
int X=2333
end type

type tab_1 from w_print_main`tab_1 within w_riep_mag_cx
int X=29
int Width=2600
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=15
int Y=90
int Width=2571
int Height=784
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=29
int Y=29
int Width=2516
int Height=701
string DataObject="d_riep_mag_cx"
end type

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "da_cod", "a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "da_cod" then
			uf_set_colval("da_descr", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_descr", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_descr", "a_descr"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "da_descr" then
			uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
		end if
END CHOOSE

end event

event dw_selection::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "da_cod", "a_cod"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
	CASE "da_descr", "a_descr"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
END CHOOSE

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=15
int Y=90
int Width=2571
int Height=784
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=15
int Y=90
int Width=2571
int Height=784
end type

type cb_stampa from w_print_main`cb_stampa within w_riep_mag_cx
int X=2066
end type

