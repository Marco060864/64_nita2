forward
global type w_st_telefoni_rpt from w_print_main
end type
end forward

global type w_st_telefoni_rpt from w_print_main
int Width=2898
int Height=904
boolean TitleBar=true
string Title="Ultimi Articoli movimentati per Sogg. Commerciale"
end type
global w_st_telefoni_rpt w_st_telefoni_rpt

on w_st_telefoni_rpt.create
call super::create
end on

on w_st_telefoni_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
string	ls_da_articolo,ls_a_articolo
string	ls_da_sogg,ls_a_sogg
string	ls_da_caus,ls_a_caus
string 	statement,ls_selezione
string ls_da_magaz,ls_a_magaz
long		ll_retval

ls_da_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"da_sogg_des")
ls_a_sogg		 	= tab_1.tabpage_select.dw_selection.GetItemString(1,"a_sogg_des")

tab_1.tabpage_select.dw_selection.accepttext()


if not isNull(ls_da_sogg) and not isNull( ls_a_sogg ) then
	if ls_da_sogg > ls_a_sogg then
		if MessageBox( "Attenzione","Soggetto 'da' maggiore di Soggetto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if










if Not IsNull(ls_da_sogg) and ls_da_sogg <> "" then
	statement 		= statement + " {anagrafica.rag_soc_1} >= '" + ls_da_sogg + "'"
	ls_selezione 	= ls_selezione + " Da soggetto " + ls_da_sogg + ", "
else
	ls_selezione 	= " Da soggetto non definito, "
end if

if Not IsNull(ls_a_sogg) and ls_a_sogg <> "" then
	statement 		= statement + " AND {anagrafica.rag_soc_1} <= '" + ls_a_sogg + "'"
	ls_selezione 	= ls_selezione + "a soggetto " + ls_a_sogg + "."
else
	ls_selezione 	= ls_selezione + "a soggetto non definito."
end if


is_selection = statement
istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"
return 0


end event

type cb_esci from w_print_main`cb_esci within w_st_telefoni_rpt
int X=2592
int Y=64
end type

type tab_1 from w_print_main`tab_1 within w_st_telefoni_rpt
int X=14
int Y=188
int Width=2843
int Height=568
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2807
int Height=440
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=87
int Y=56
int Width=2679
int Height=320
string DataObject="d_stampa_telefoni"
end type

event dw_selection::itemchanged;

integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name

		CASE "da_sogg_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_sogg_cod"
		ls_dwc[2] = "da_sogg_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
			
      This.SetItem(1, "a_sogg_cod", Data)			
      This.SetItem(1, "a_sogg_des", This.GetItemString(1, "da_sogg_des"))

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "da_sogg_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_sogg_cod"
		ls_dwc[2] = "da_sogg_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		This.SetItem(1, "a_sogg_des", Data)			
      This.SetItem(1, "a_sogg_cod", This.GetItemString(1, "da_sogg_cod"))

			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF

	case "a_sogg_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_sogg_cod"
		ls_dwc[2] = "a_sogg_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_sogg_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_sogg_cod"
		ls_dwc[2] = "a_sogg_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
end choose


















end event

event dw_selection::ue_set_search;		







CHOOSE CASE as_nomecol
		
	CASE "da_sogg_cod", "da_sogg_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "da_sogg_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "da_sogg_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF


	CASE "a_sogg_cod", "a_sogg_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "a_sogg_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "a_sogg_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF


END CHOOSE	



end event

event dw_selection::ue_use_search;
	
		
		


			
			
choose case as_nomecol
			
	CASE "da_sogg_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_sogg_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("a_sogg_cod", is_ricpar.s_main_value)
		uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])
		
	CASE "da_sogg_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	
		uf_set_colval("da_sogg_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("a_sogg_des", is_ricpar.s_main_value)
		uf_set_colval("a_sogg_cod", is_ricpar.s_ausil_value[1])
		
	CASE "a_sogg_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_sogg_des", is_ricpar.s_ausil_value[1])

	CASE "a_sogg_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_sogg_cod", is_ricpar.s_ausil_value[1])
END CHOOSE


end event

event dw_selection::ue_init;call super::ue_init;
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2807
int Height=440
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2807
int Height=440
end type

type cb_stampa from w_print_main`cb_stampa within w_st_telefoni_rpt
int X=2249
int Y=64
end type

