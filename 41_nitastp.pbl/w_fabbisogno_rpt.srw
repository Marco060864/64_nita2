forward
global type w_fabbisogno_rpt from w_print_main
end type
end forward

global type w_fabbisogno_rpt from w_print_main
int Width=2506
int Height=1737
boolean TitleBar=true
string Title="Stampa del fabbisogno"
end type
global w_fabbisogno_rpt w_fabbisogno_rpt

on w_fabbisogno_rpt.create
call w_print_main::create
end on

on w_fabbisogno_rpt.destroy
call w_print_main::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_id_cat_cod,ll_id_cat_comm,ll_id_cat_merc,ll_id_cat_fisc,ll_id_gruppo
long		ll_id_produttore,ll_id_fornitore,ll_id_magazzino
string	ls_da_art, ls_a_art, ls_salto_pagina,ls_produttore,ls_fornitore
string 	statement, ls_selezione

ls_da_art				= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_art_cod")
ls_a_art					= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_art_cod")
ll_id_cat_cod			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_cat_codifica")
ll_id_cat_comm			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_cat_comm")
ll_id_cat_merc			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_cat_merc")
ll_id_cat_fisc			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_cat_fisc")
ll_id_gruppo			= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_gruppo")
ll_id_fornitore		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_fornitore" )
ll_id_produttore		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_produttore" )
ls_produttore			= tab_1.tabpage_select.dw_selection.GetItemString(1,"produttore_des" )
ll_id_magazzino		= tab_1.tabpage_select.dw_selection.GetItemNumber(1,"id_magazzino" )
ls_salto_pagina		= tab_1.tabpage_select.dw_selection.GetItemString(1,"salto_pagina" )
ls_fornitore			= tab_1.tabpage_select.dw_selection.GetItemString(1,"for_des" )


if not isNull(ls_da_art) and not isNull(ls_a_art) then
	if ls_da_art > ls_a_art then
		if MessageBox( "Attenzione","Articolo 'da' maggiore Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if


statement  = " {Articolo.ID_Azienda} = 1"

if Not IsNull(ll_id_cat_cod) then
	statement 		= statement + " AND {Articolo.id_cat_codifica} = " + string(ll_id_cat_cod)  
	ls_selezione 	= " Categoria di codifica " + string(ll_id_cat_cod) + ", "
else
	ls_selezione 	= " Categoria di codifica - non definita, "	
end if

if Not IsNull(ls_da_art) and ls_da_art <> "" then
	statement 		= statement + " AND {Articolo.codice} >= '" + ls_da_art + "'"
	ls_selezione 	= ls_selezione + " Da articolo " + ls_da_art + ", "
else
	ls_selezione 	= " Da articolo non definito, "
end if

if Not IsNull(ls_a_art) and ls_a_art <> "" then
	statement 		= statement + " AND {Articolo.codice} <= '" + ls_a_art + "'"
	ls_selezione 	= ls_selezione + "a articolo " + ls_a_art + "."
else
	ls_selezione 	= ls_selezione + "a articolo non definito."
end if

if Not IsNull(ll_id_cat_comm) then
	statement 		= statement + " AND {Articolo.id_cat_com_articolo} = " + string(ll_id_cat_comm)  
	ls_selezione 	= " Categoria commerciale " + string(ll_id_cat_comm) + ", "
else
	ls_selezione 	= " Categoria commerciale - non definita, "	
end if

if Not IsNull(ll_id_cat_merc) then
	statement 		= statement + " AND {Articolo.id_cat_merceologica} = " + string(ll_id_cat_merc)  
	ls_selezione 	= " Categoria merceologica " + string(ll_id_cat_merc) + ", "
else
	ls_selezione 	= " Categoria merceologica - non definita, "	
end if

if Not IsNull(ll_id_cat_fisc) then
	statement 		= statement + " AND {Articolo.id_cat_fiscale} = " + string(ll_id_cat_fisc)  
	ls_selezione 	= " Categoria fiscale " + string(ll_id_cat_fisc) + ", "
else
	ls_selezione 	= " Categoria fiscale - non definita, "	
end if

if Not IsNull(ll_id_gruppo) then
	statement 		= statement + " AND {Articolo.id_gruppo_articoli} = " + string(ll_id_gruppo)  
	ls_selezione 	= " Gruppo articoli " + string(ll_id_gruppo) + ", "
else
	ls_selezione 	= " Gruppo articoli - non definita, "	
end if

if Not IsNull(ll_id_produttore) then
	statement 		= statement + " AND {Articolo.id_anagrafica} = " + string(ll_id_produttore)  
	ls_selezione 	= " Produttore " + ls_produttore + ", "
else
	ls_selezione 	= " Produttore - non definito, "	
end if

if Not IsNull(ll_id_fornitore) then
	statement 		= statement + " AND {Fabbisogno.id_sog_commerciale} = " + string(ll_id_fornitore)  
	ls_selezione 	= " Fornitore " + ls_fornitore + ", "
else
	ls_selezione 	= " Fornitore - non definito, "	
end if

if Not IsNull(ll_id_magazzino) then
	statement 		= statement + " AND {Fabbisogno.id_magazzino} = " + string(ll_id_magazzino)  
	ls_selezione 	= " Magazzino " + string(ll_id_magazzino) + ", "
else
	ls_selezione 	= " Magazzino - non definito, "	
end if

if isNull(ls_salto_pagina) then ls_salto_pagina = "N"

is_selection 	= statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
istr_formule[2].formula_name 		= "salto_pagina"
istr_formule[2].formula_string 	= "'" + ls_salto_pagina + "'"


return 0
end event

type cb_esci from w_print_main`cb_esci within w_fabbisogno_rpt
int X=2172
int Y=81
end type

type tab_1 from w_print_main`tab_1 within w_fabbisogno_rpt
int Width=2423
int Height=1421
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=19
int Y=113
int Width=2387
int Height=1293
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Y=49
int Width=2286
int Height=1201
string DataObject="d_fabbisogno_rpt"
end type

event dw_selection::ue_set_search;call super::ue_set_search;

choose case as_nomecol
		
	case "da_art_cod", "a_art_cod"
		is_search_window 				= "w_articolo_coddes_sw"
		is_ricpar.s_filter_value	= as_valcol
		is_ricpar.s_filter_name 	= "articolo_codice"
	case "da_art_des", "a_art_des"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	case "produttore_des"
		is_search_window = "w_anagrafica_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		
	case "for_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
	case "for_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"

	case "mag_cod"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	case "mag_des"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"

end choose

end event

event dw_selection::ue_use_search;call super::ue_use_search;

choose case as_nomecol
		
	case "da_art_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_art_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("a_art_cod", is_ricpar.s_main_value)
		uf_set_colval("a_art_des", is_ricpar.s_ausil_value[1])
		
	case "da_art_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_art_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("a_art_des", is_ricpar.s_main_value)
		uf_set_colval("a_art_cod", is_ricpar.s_ausil_value[1])
		
	case "a_art_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_art_des", is_ricpar.s_ausil_value[1])
	case "a_art_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_art_cod", is_ricpar.s_ausil_value[1])

	case "produttore_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_produttore", is_ricpar.s_id_seg_value[1])		
		
	case "for_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_fornitore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("for_des", is_ricpar.s_ausil_value[1])
		
	case "for_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_fornitore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("for_cod", is_ricpar.s_ausil_value[1])
		
	case "mag_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("mag_des", is_ricpar.s_ausil_value[1])
	case "mag_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("mag_cod", is_ricpar.s_ausil_value[1])	
		
end choose

end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1] = "id_cat_codifica"
is_drop_column[2] = "id_cat_comm"
is_drop_column[3] = "id_cat_comm_des"
is_drop_column[4] = "id_cat_merc"
is_drop_column[5] = "id_cat_merc_des"
is_drop_column[6] = "id_cat_fisc"
is_drop_column[7] = "id_cat_fisc_des"
is_drop_column[8] = "id_gruppo"
is_drop_column[9] = "id_gruppo_des"

end event

event dw_selection::itemchanged;call super::itemchanged;
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string		ls_a, ls_b, ls_c, ls_pc
date			ld_data_inizio
long			ll_a, ll_ok, ll_row, ll_scode

DataWindowChild	dwc_drop
string				ls_sql, ls_add


ll_row = GetRow()
if ll_row > 0 then

	choose case dwo.name
		
		
		
		
		
		CASE "da_art_cod"
			ls_pc = data
			SELECT	"articolo"."id_articolo",
						"articolo"."codice",
						"articolo"."descrizione"
				INTO	:ll_a, :ls_b, :ls_c  
				FROM	"dba"."articolo"  
				WHERE "articolo"."codice" = :ls_pc;
			
			if sqlca.sqlcode=0 then
				setItem (ll_row,"da_art_cod",ls_b)
				setItem (ll_row,"da_art_des",ls_c)
				setItem (ll_row,"a_art_cod",ls_b)
				setItem (ll_row,"a_art_des",ls_c)
				return 2
			else
				setItem (ll_row,"da_art_des",u_freddie.gs_null)
				return 0
			end if

		CASE 'da_art_des'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "da_art_cod"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "da_art_des"
			ls_dbc[3] = "codice"
			ls_dwc[3] = "a_art_cod"
			ls_dbc[4] = "descrizione"
			ls_dwc[4] = "a_art_des"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		CASE "a_art_cod"
			ls_pc = data
			SELECT	"articolo"."id_articolo",
						"articolo"."codice",
						"articolo"."descrizione"
				INTO	:ll_a, :ls_b, :ls_c  
				FROM	"dba"."articolo"  
				WHERE "articolo"."codice" = :ls_pc;
			
			if sqlca.sqlcode=0 then
				setItem (ll_row,"a_art_cod",ls_b)
				setItem (ll_row,"a_art_des",ls_c)
				return 2
			else
				setItem (ll_row,"a_art_des",u_freddie.gs_null)
				return 0
			end if

		CASE 'a_art_des'
			ls_sql_cond = ""
			ls_dbc[1] = "codice"
			ls_dwc[1] = "a_art_cod"
			ls_dbc[2] = "descrizione"
			ls_dwc[2] = "a_art_des"
			ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		CASE 'produttore_des'
			ls_sql_cond = ""
			ls_dbc[1] = "id_anagrafica"
			ls_dwc[1] = "id_produttore"
			ls_dbc[2] = "rag_soc_1"
			ls_dwc[2] = "produttore_des"
			ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF		
	
		
		
		
		CASE 'for_cod'
			ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"		
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_fornitore"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "for_cod"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "for_des"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF	
	
		CASE 'for_des'
			ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"				
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_fornitore"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "for_cod"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "for_des"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		
		
		
		CASE 'mag_cod'
			ls_sql_cond = ""		
			ls_dbc[1] = "id_magazzino"
			ls_dwc[1] = "id_magazzino"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "mag_cod"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "mag_des"
			ll_ok = uf_autofind_col(dwo.Name, "magazzino", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF	
	
		CASE 'mag_des'
			ls_sql_cond = ""				
			ls_dbc[1] = "id_magazzino"
			ls_dwc[1] = "id_magazzino"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "mag_cod"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "mag_des"
			ll_ok = uf_autofind_col(dwo.Name, "magazzino", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
		
	end choose

end if





end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=19
int Y=113
int Width=2387
int Height=1293
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=19
int Y=113
int Width=2387
int Height=1293
end type

type cb_stampa from w_print_main`cb_stampa within w_fabbisogno_rpt
int X=1898
int Y=81
end type

