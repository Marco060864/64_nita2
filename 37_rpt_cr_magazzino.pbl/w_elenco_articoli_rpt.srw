forward
global type w_elenco_articoli_rpt from w_print_main
end type
end forward

global type w_elenco_articoli_rpt from w_print_main
int Width=2881
int Height=1145
boolean TitleBar=true
string Title="Elenco degli Articoli"
end type
global w_elenco_articoli_rpt w_elenco_articoli_rpt

event ue_pre_print;call super::ue_pre_print;
string	ls_da_articolo,ls_a_articolo
string 	statement,ls_selezione


ls_da_articolo 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_articolo_cod")
ls_a_articolo	 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_articolo_cod")



if not isNull(ls_da_articolo) and not isNull(ls_a_articolo) then
	if ls_da_articolo > ls_a_articolo then
		if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if


statement  = " {Articolo.ID_Azienda} = 1"


if Not IsNull(ls_da_articolo) and ls_da_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} >= '" + ls_da_articolo + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_articolo + ", "
else
	ls_selezione 	= " Da articolo  - non definito, "
end if

if Not IsNull(ls_a_articolo) and ls_a_articolo <> "" then
	statement 		= statement + " AND {Articolo.Codice} <= '" + ls_a_articolo + "'"
	ls_selezione 	= ls_selezione + "a articolo " + ls_a_articolo + "."
else
	ls_selezione 	= ls_selezione + "a articolo - non definito."
end if

is_selection = statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

return 0


end event

on w_elenco_articoli_rpt.create
call w_print_main::create
end on

on w_elenco_articoli_rpt.destroy
call w_print_main::destroy
end on

type cb_esci from w_print_main`cb_esci within w_elenco_articoli_rpt
int X=2551
int Y=65
end type

type tab_1 from w_print_main`tab_1 within w_elenco_articoli_rpt
int X=19
int Width=2780
int Height=813
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int Width=2743
int Height=685
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=49
int Width=2593
int Height=577
string DataObject="d_elenco_articoli_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "da_articolo_cod", "a_articolo_cod"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
	CASE "da_articolo_des", "a_articolo_des"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
		
	CASE "da_articolo_cod", "a_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "da_articolo_cod" then
			uf_set_colval("da_articolo_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_articolo_des", "a_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		if as_nomecol = "da_articolo_des" then
			uf_set_colval("da_articolo_cod", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_articolo_cod", is_ricpar.s_ausil_value[1])
		end if
END CHOOSE

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int Width=2743
int Height=685
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int Width=2743
int Height=685
end type

type cb_stampa from w_print_main`cb_stampa within w_elenco_articoli_rpt
int X=2268
int Y=61
end type

