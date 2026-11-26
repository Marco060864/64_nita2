forward
global type w_st_vet_doc from w_print_main
end type
end forward

global type w_st_vet_doc from w_print_main
int Width=2386
int Height=1132
end type
global w_st_vet_doc w_st_vet_doc

on w_st_vet_doc.create
call super::create
end on

on w_st_vet_doc.destroy
call super::destroy
end on

event open;call super::open;datawindowchild ldw_tipo_registro

tab_1.tabpage_select.dw_selection.GetChild("tipo_reg",ldw_tipo_registro)

tab_1.tabpage_select.dw_selection.accepttext()


ldw_tipo_registro.SetTransObject(SQLCA)
ldw_tipo_registro.Retrieve()
end event

event ue_pre_print;call super::ue_pre_print;
string ls_da_codvet, ls_a_codvet, ls_tipo_reg
string statement,ls_selezione
date ld_da_data, ld_a_data

ls_da_codvet 	  = tab_1.tabpage_select.dw_selection.GetItemString(1,"da_cod_vet")
ls_a_codvet  	  = tab_1.tabpage_select.dw_selection.GetItemString(1,"a_cod_vet")

ls_tipo_reg  	  = tab_1.tabpage_select.dw_selection.GetItemString(1,"tipo_reg")

ld_da_data 	     = tab_1.tabpage_select.dw_selection.GetItemdate(1,"da_data_doc")
ld_a_data  	     = tab_1.tabpage_select.dw_selection.GetItemdate(1,"a_data_doc")

if not isNull(ls_da_codvet) and not isNull(ls_a_codvet) then
	if ls_da_codvet > ls_a_codvet then
		if MessageBox( "Attenzione","Vettore 'da' maggiore di Vettore 'a',continuare ?",Question!,YesNo!,2 ) = 2 then
			return -1
		end if
	end if	
end if


if Not IsNull(ls_da_codvet) and ls_da_codvet <> "" then
	if statement <> "" then
		statement 		= statement + " AND {Sog_Commerciale_gen.Codice} >= '" + ls_da_codvet + "'"
	else
		statement 		= statement + " {Sog_Commerciale_gen.Codice} >= '" + ls_da_codvet + "'"		
	end if
	ls_selezione 	= ls_selezione + " Da Vettore " + ls_da_codvet + ", "
end if

if Not IsNull(ls_a_codvet) and ls_a_codvet <> "" then
	if statement <> "" then 
		statement 		= statement + " AND {Sog_Commerciale_gen.Codice} <= '" + ls_a_codvet + "'"
	else
	   statement 		= statement + " {Sog_Commerciale_gen.Codice} <= '" + ls_a_codvet + "'"	
	end if
	ls_selezione 	= ls_selezione + "a Vettore " + ls_a_codvet + "."
end if

if statement <> "" then 
	statement 		= statement + " AND {Sog_Commerciale_gen.Tipo} = 'V'"
else
	statement 		= statement + " {Sog_Commerciale_gen.Tipo} = 'V'"
end if

if statement <> "" then 
	statement 		= statement + " AND {Registro.Tipo_Registro} = '" + ls_tipo_reg + "'"
else
	statement 		= statement + " {Registro.Tipo_Registro} = '" + ls_tipo_reg + "'"
end if

if Not IsNull(string(ld_da_data)) and string(ld_da_data) <> "" then
	if statement <> "" then  
		
		
		statement 		= statement + " AND {Documento.Data_Documento} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"
	else
		statement 		= statement + " {Documento.Data_Documento} >= Date (" + string(ld_da_data, "yyyy, mm, dd") + ")"		
	end if
	ls_selezione 	= ls_selezione + " Da Data Doc. " + string(ld_da_data) + ", "
end if

if Not IsNull(string(ld_a_data)) and string(ld_a_data) <> "" then
	if statement <> "" then 
		statement 		= statement + " AND {Documento.Data_Documento} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"
	else
	   statement 		= statement + " {Documento.Data_Documento} <= Date (" + string(ld_a_data, "yyyy, mm, dd") + ")"	
	end if
	ls_selezione 	= ls_selezione + "a Data Doc. " + string(ld_a_data) + "."
end if


is_selection = statement

messagebox ("", statement)

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

return 0
end event

type cb_esci from w_print_main`cb_esci within w_st_vet_doc
int X=2094
end type

type tab_1 from w_print_main`tab_1 within w_st_vet_doc
int Width=2322
int Height=848
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2286
int Height=720
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int Width=2162
int Height=624
string DataObject="d_sel_vet_doc"
end type

event dw_selection::ue_set_search;

CHOOSE CASE as_nomecol
	
	CASE "da_cod_vet"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"

	CASE "da_des_vet"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
		
	CASE "a_cod_vet"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"

	CASE "a_des_vet"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"		
		
END CHOOSE

end event

event dw_selection::ue_use_search;CHOOSE CASE as_nomecol

	CASE "da_cod_vet"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_des_vet", is_ricpar.s_ausil_value[1])
			
	CASE "da_des_vet"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_cod_vet", is_ricpar.s_ausil_value[1])
		
	CASE "a_cod_vet"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_des_vet", is_ricpar.s_ausil_value[1])
			
	CASE "a_des_vet"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("a_cod_vet", is_ricpar.s_ausil_value[1])		
		
end choose
end event

event dw_selection::itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
		CASE "da_cod_vet"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_vet"
		ls_dwc[2] = "da_des_vet"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_vet")) or This.GetItemString(1, "a_cod_vet")='' then
           This.SetItem(1, "a_cod_vet", Data)			
           This.SetItem(1, "a_des_vet", This.GetItemString(1, "da_des_vet"))
	      end if
			RETURN 2
		END IF
		
		
	case "da_des_vet"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_vet"
		ls_dwc[2] = "da_des_vet"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_vet")) or This.GetItemString(1, "a_cod_vet")='' then
		    This.SetItem(1, "a_des_vet", Data)			
          This.SetItem(1, "a_cod_vet", This.GetItemString(1, "da_cod_vet"))
	      end if
			RETURN 2
		END IF

	case "a_cod_vet"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_vet"
		ls_dwc[2] = "a_des_vet"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "a_des_vet"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_vet"
		ls_dwc[2] = "a_des_vet"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
end choose
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
int Width=2286
int Height=720
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2286
int Height=720
end type

type cb_stampa from w_print_main`cb_stampa within w_st_vet_doc
int X=1833
end type

