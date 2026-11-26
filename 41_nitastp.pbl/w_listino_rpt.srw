forward
global type w_listino_rpt from w_print_main
end type
end forward

global type w_listino_rpt from w_print_main
int Width=2881
int Height=1553
boolean TitleBar=true
string Title="Stampa Listino"
end type
global w_listino_rpt w_listino_rpt

on w_listino_rpt.create
call w_print_main::create
end on

on w_listino_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_id_listino,ll_id_variazione
long		ll_id_cat_comm,ll_id_cat_merc,ll_id_cat_fiscale,ll_id_gruppo
long		ll_id_produttore,ll_id_fornitore
string	ls_da_articolo,ls_a_articolo,ls_cat_codifica
string	ls_raggruppamento,ls_ordinamento



String 	statement, ls_selezione

ll_id_listino			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_listino")
ll_id_variazione		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_variazione")
ls_cat_codifica		= tab_1.tabpage_select.dw_selection.GetItemString(1,"id_categoria_codifica")

ls_da_articolo			= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cod_articolo")
ls_a_articolo			= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cod_articolo")

if ls_da_articolo > ls_a_articolo then
	if MessageBox( "Attenzione","Articolo 'da' maggiore di articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	


ll_id_cat_comm			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"cat_comm")
ll_id_cat_merc			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"cat_merc")
ll_id_cat_fiscale		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"cat_fiscale")
ll_id_gruppo			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"gruppo")
ll_id_produttore		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_produttore")
ll_id_fornitore		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_fornitore")

ls_raggruppamento		= tab_1.tabpage_select.dw_selection.GetItemString(1,"raggruppamento") 
ls_ordinamento			= tab_1.tabpage_select.dw_selection.GetItemString(1,"ordinamento")


statement  = " {vs_stampa_listino.ID_Azienda} = 1"

if Not IsNull(ll_id_listino) then
	statement 		= statement + " AND {vs_stampa_listino.id_listino} = " + string(ll_id_listino) 
	ls_selezione 	= ls_selezione + " Dal listino " + string(ll_id_listino) + ", "
else
	ls_selezione 	= " Dal listino non definito, "
end if

if Not IsNull(ll_id_variazione) then
	statement 		= statement + " AND {vs_stampa_listino.id_variazione} = " + string(ll_id_variazione) 
	ls_selezione 	= ls_selezione + " Dalla variazione " + string(ll_id_variazione) + ", "
else
	ls_selezione 	= " Dalla variazione non definita, "
end if

if Not IsNull(ls_cat_codifica) and ls_cat_codifica <> "" then
	statement 		= statement + " AND {vs_stampa_listino.cat_codifica_codice} = '" + ls_cat_codifica + "'" 
	ls_selezione 	= ls_selezione + " Dalla categoria di codifica " + ls_cat_codifica + ", "
else
	ls_selezione 	= " Dalla categoria di codifica non definita, "
end if

if Not IsNull(ls_da_articolo) and ls_da_articolo <> "" then
	statement 		= statement + " AND {vs_stampa_listino.Articolo_Codice} >= '" + ls_da_articolo + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_articolo + ", "
else
	ls_selezione 	= " Da articolo non definito, "
end if

if Not IsNull(ls_a_articolo) and ls_a_articolo <> "" then
	statement 		= statement + " AND {vs_stampa_listino.Articolo_Codice} <= '" + ls_a_articolo + "'"
	ls_selezione 	= ls_selezione + "ad articolo  " + ls_a_articolo + "."
else
	ls_selezione 	= ls_selezione + "ad artciolo."
end if

if Not IsNull(ll_id_cat_comm) then
	statement 		= statement + " AND {vs_stampa_listino.id_cat_com_articolo} = " + string(ll_id_cat_comm) 
	ls_selezione 	= ls_selezione + " Dalla categoria commerciale " + string(ll_id_cat_comm) + ", "
else
	ls_selezione 	= " Dalla categoria commerciale non definita, "
end if

if Not IsNull(ll_id_cat_merc) then
	statement 		= statement + " AND {vs_stampa_listino.id_cat_merceologica} = " + string(ll_id_cat_merc) 
	ls_selezione 	= ls_selezione + " Dalla categoria merceologica " + string(ll_id_cat_merc) + ", "
else
	ls_selezione 	= " Dalla categoria merceologica non definita, "
end if

if Not IsNull(ll_id_cat_fiscale) then
	statement 		= statement + " AND {vs_stampa_listino.id_cat_fiscale} = " + string(ll_id_cat_fiscale) 
	ls_selezione 	= ls_selezione + " Dalla categoria fiscale " + string(ll_id_cat_fiscale) + ", "
else
	ls_selezione 	= " Dalla categoria fiscale non definita, "
end if

if Not IsNull(ll_id_gruppo) then
	statement 		= statement + " AND {vs_stampa_listino.id_gruppo_articoli} = " + string(ll_id_gruppo) 
	ls_selezione 	= ls_selezione + " Dalla gruppo articoli " + string(ll_id_gruppo) + ", "
else
	ls_selezione 	= " Dal gruppo articoli definita, "
end if

if Not IsNull(ll_id_produttore) then
	statement 		= statement + " AND {vs_stampa_listino.id_anagrafica} = " + string(ll_id_produttore) + ""
	ls_selezione 	= ls_selezione + " Produttore: " + string(ll_id_produttore) + "."
else
	ls_selezione 	= ls_selezione + " Produttore non definito."
end if

if Not IsNull(ll_id_fornitore) then
	statement 		= statement + " AND {vs_stampa_listino.id_sog_commerciale} = " + string(ll_id_fornitore) + ""
	ls_selezione 	= ls_selezione + " Fornitore: " + string(ll_id_fornitore) + "."
else
	ls_selezione 	= ls_selezione + " Fornitore non definito."
end if



is_selection 	= statement

istr_formule[1].formula_name 		= "gruppo_stampa"
istr_formule[1].formula_string 	= "'" + ls_raggruppamento + "'"
istr_formule[2].formula_name 		= "ordine_stampa"
istr_formule[2].formula_string 	= "'" + ls_ordinamento + "'"

return 0

end event

type cb_esci from w_print_main`cb_esci within w_listino_rpt
int X=2561
int Y=81
end type

type tab_1 from w_print_main`tab_1 within w_listino_rpt
int Width=2812
int Height=1281
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2775
int Height=1153
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=49
int Width=2675
int Height=1061
string DataObject="d_listino_rpt"
end type

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "id_listino"
is_drop_column[2]	= "id_variazione"
is_drop_column[3]	= "id_categoria_codifica"
is_drop_column[4]	= "cat_comm"
is_drop_column[5]	= "cat_merc"
is_drop_column[6]	= "cat_fiscale"
is_drop_column[7]	= "gruppo"
end event

event dw_selection::ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
		
	CASE "produttore"
		is_search_window = "w_anagrafica_sw" 	
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "rag_soc" 			
		
	CASE "da_cod_articolo", "a_cod_articolo"
		is_search_window = "w_articolo_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "articolo_codice" 	
		
	CASE "da_cod_articolo_des", "a_cod_articolo_des"
		is_search_window = "w_articolo_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "articolo_descrizione" 	

	CASE "cod_fornitore"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "codice"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
		
	CASE "des_fornitore"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "rag_soc_1" 				
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
		
END CHOOSE

end event

event dw_selection::ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "produttore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_produttore",is_ricpar.s_id_seg_value[1])
		
	CASE "da_cod_articolo", "a_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_cod_articolo" then
			uf_set_colval("da_cod_articolo_des", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_cod_articolo_des", is_ricpar.s_ausil_value[1])
		end if
		
		
	CASE "da_cod_articolo_des", "a_cod_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_cod_articolo_des" then
			uf_set_colval("da_cod_articolo", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_cod_articolo", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "cod_fornitore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_fornitore", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_fornitore",is_ricpar.s_id_seg_value[1])
		
	CASE "des_fornitore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_fornitore", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_fornitore",is_ricpar.s_id_seg_value[1])		
		
		
END CHOOSE

end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2775
int Height=1153
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2775
int Height=1153
end type

type cb_stampa from w_print_main`cb_stampa within w_listino_rpt
int X=2263
int Y=81
end type

