forward
global type w_stampa_lotti_cx from w_print_main
end type
end forward

global type w_stampa_lotti_cx from w_print_main
int Width=2674
int Height=1356
end type
global w_stampa_lotti_cx w_stampa_lotti_cx

on w_stampa_lotti_cx.create
call super::create
end on

on w_stampa_lotti_cx.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;long		ll_retval
string	ls_da_cod_articolo, ls_a_cod_articolo, ls_da_cod_lotto, ls_a_cod_lotto
date		ld_da_data_doc, ld_a_data_doc
String 	statement, ls_selezione

ls_da_cod_articolo = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cod_articolo")
ls_a_cod_articolo  = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cod_articolo")

ls_da_cod_lotto = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cod_lotto")
ls_a_cod_lotto  = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cod_lotto")

ld_da_data_doc	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data_doc")
ld_a_data_doc	= tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data_doc")

if ls_da_cod_articolo > ls_a_cod_articolo then
	if MessageBox( "Attenzione","Articolo 'da' maggiore di Articolo 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ls_da_cod_lotto > ls_a_cod_lotto then
	if MessageBox( "Attenzione","Lotto 'da' maggiore di Lotto 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

if ld_da_data_doc > ld_a_data_doc then
	if MessageBox( "Attenzione","Data 'da' maggiore di Data 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
		return -1
	end if
end if	

statement = ""
if Not IsNull(ls_da_cod_articolo) then
	statement 		= statement + " {articolo.codice} >= '" + ls_da_cod_articolo + "'"
	ls_selezione 	= " Da articolo " + ls_da_cod_articolo + ", "
end if

if Not IsNull(ls_a_cod_articolo) then
	if statement <> '' then statement = statement + " AND "
	statement 		= statement + " {articolo.codice} <= '" + ls_a_cod_articolo + "'"
	ls_selezione 	= " A articolo " + ls_a_cod_articolo + ", "
end if

if Not IsNull(ls_da_cod_lotto) then
	if statement <> '' then statement = statement + " AND "
	statement 		= statement + " {lotto.cod_esterno} >= '" + ls_da_cod_lotto + "'"
	ls_selezione 	= " Da lotto " + ls_da_cod_lotto + ", "
end if

if Not IsNull(ls_a_cod_lotto) then
	if statement <> '' then statement = statement + " AND "
	statement 		= statement + " {lotto.cod_esterno} <= '" + ls_a_cod_lotto + "'"
	ls_selezione 	= " A lotto " + ls_a_cod_lotto + ", "
end if

if Not IsNull(ld_da_data_doc) then
	if statement <> '' then statement = statement + " AND "
	statement 		= statement + " {Documento.data_documento} >= Date (" + string(ld_da_data_doc, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Da data doc. " + string(ld_da_data_doc, "dd/mm/yyyy") + ", "
end if

if Not IsNull(ld_a_data_doc) then
	if statement <> '' then statement = statement + " AND "
	statement 		= statement + " {Documento.Data_documento} <= Date (" + string(ld_a_data_doc, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "a data doc. " + string(ld_a_data_doc, "dd/mm/yyyy") + "."
end if


is_selection 	= statement

istr_formule[1].formula_name 	= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0

end event

type cb_esci from w_print_main`cb_esci within w_stampa_lotti_cx
int X=2382
int Y=64
end type

type tab_1 from w_print_main`tab_1 within w_stampa_lotti_cx
int Width=2619
int Height=1072
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2583
int Height=944
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=18
int Y=28
int Width=2551
int Height=900
string DataObject="d_stampa_lotti_ff"
end type

event dw_selection::ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_cod_articolo", "a_cod_articolo"
		is_search_window = "w_articolo_coddes_sw"   
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "articolo_codice"  
		
	CASE "da_des_articolo", "a_des_articolo"
		is_search_window = "w_articolo_coddes_sw"   
		is_ricpar.s_filter_value = as_valcol 				 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
	CASE "da_cod_lotto", "a_cod_lotto"
		is_search_window = "w_lotto_codice_sw"   
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "lotto_cod_esterno"  
		
		string ls_tipo_lotto
		
		ls_tipo_lotto = this.object.tipo_lotto[1]
		
		choose case ls_tipo_lotto
			case 'M'
				is_ricpar.s_sql_cond = "lotto.tipo_lotto = 'M'"
			case 'Z', 'K'
				is_ricpar.s_sql_cond = "lotto.tipo_lotto IN ('Z', 'K')"
		end choose
		
		
END CHOOSE
end event

event dw_selection::ue_use_search;CHOOSE CASE as_nomecol

	CASE "da_cod_articolo", "a_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_cod_articolo" then
			uf_set_colval("da_des_articolo", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_des_articolo", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_des_articolo", "a_des_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_des_articolo" then
			uf_set_colval("da_cod_articolo", is_ricpar.s_ausil_value[1])
		else
			uf_set_colval("a_cod_articolo", is_ricpar.s_ausil_value[1])
		end if
	
	CASE "da_cod_lotto", "a_cod_lotto"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_cod_lotto" then
			uf_set_colval("da_art_lotto", is_ricpar.s_ausil_value[1] + ' ' + is_ricpar.s_ausil_value[2])
		else
			uf_set_colval("a_art_lotto", is_ricpar.s_ausil_value[1] + ' ' + is_ricpar.s_ausil_value[2])
		end if

END CHOOSE

end event

event dw_selection::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok
string ls_null
ls_sql_cond = ""

CHOOSE CASE dwo.name
	CASE "da_cod_articolo"
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod_articolo"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "da_des_articolo"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
										
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "da_des_articolo"
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod_articolo"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "da_des_articolo"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"descrizione", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)								
										
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "a_cod_articolo"
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_cod_articolo"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "a_des_articolo"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
										
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "a_des_articolo"
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_cod_articolo"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "a_des_articolo"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &
										"descrizione", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)								
										
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
END CHOOSE
end event

event dw_selection::ue_init;call super::ue_init;
is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"

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
int Width=2583
int Height=944
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2583
int Height=944
end type

type cb_stampa from w_print_main`cb_stampa within w_stampa_lotti_cx
int X=2121
int Y=64
end type

