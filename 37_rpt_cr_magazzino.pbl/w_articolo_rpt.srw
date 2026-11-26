forward
global type w_articolo_rpt from w_print_main
end type
end forward

global type w_articolo_rpt from w_print_main
int Width=3219
int Height=1245
boolean TitleBar=true
string Title="Stampa Articoli con Prezzo"
end type
global w_articolo_rpt w_articolo_rpt

on w_articolo_rpt.create
call w_print_main::create
end on

on w_articolo_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
String	ls_da_articolo, ls_a_articolo,ls_catcod
String 	ls_statement, ls_selezione
long		ll_var
ls_da_articolo = tab_1.tabpage_select.dw_selection.GetItemString(1, "da_cod")	
ls_a_articolo = tab_1.tabpage_select.dw_selection.GetItemString(1, "a_cod")	
ls_catcod		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"cat_comm_cod")
ll_var		 	  = tab_1.tabpage_select.dw_selection.GetItemnumber(1,"variazione")

if ls_da_articolo > ls_a_articolo then
	if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

ls_statement  = "{unita_confezione.id_articolo}=1 "

if Not IsNull(ll_var) then
	ls_statement 		= ls_statement + " AND {Variazione.ID_Variazione} = " + string(ll_var) + ""
	ls_selezione 	= ls_selezione + " Da Variazione: " + string(ll_var) + "."
else
	ls_selezione 	= ls_selezione + " Tipo variazione non definita."
end if







if Not IsNull(ls_da_articolo) and ls_da_articolo <> "" then
	ls_statement 		= ls_statement + " AND {Articolo.Codice} >= '" + ls_da_articolo + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_articolo + ", "
else
	ls_selezione 	= " Da articolo  - non definito, "
end if

if Not IsNull(ls_a_articolo) and ls_a_articolo <> "" then
	ls_statement 		= ls_statement + " AND {Articolo.Codice} <= '" + ls_a_articolo + "'"
	ls_selezione 	= ls_selezione + "a articolo " + ls_a_articolo + "."
else
	ls_selezione 	= ls_selezione + "a articolo - non definito."
end if



if Not IsNull(ls_catcod) and ls_catcod <> "" then
	ls_statement 		= ls_statement + " AND {cat_com_articolo.codice} >= '" + ls_catcod + "'"
	ls_selezione 	= ls_selezione + " Da Categ. comm. " + ls_catcod+ ". " 
		
else
	ls_selezione 	= " Da Cat. Comm. non definita. "
end if





is_selection 	= ls_statement

istr_formule[1].formula_name 	= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione+ "'"	
return 0
end event

type cb_esci from w_print_main`cb_esci within w_articolo_rpt
int X=2931
int Y=49
end type

type tab_1 from w_print_main`tab_1 within w_articolo_rpt
int Width=3114
int Height=893
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=3077
int Height=765
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=101
int Width=2903
int Height=617
string DataObject="d_articolo_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

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

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "cat_comm_cod"
is_drop_column[2]	= "cat_comm_des"
is_drop_column[3]	= "listino"
is_drop_column[4]	= "listino2"
is_drop_column[5]	=  "variazione"
is_drop_column[6]	=  "variazione2"

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=3077
int Height=765
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=3077
int Height=765
end type

type cb_stampa from w_print_main`cb_stampa within w_articolo_rpt
int X=2611
int Y=49
end type

