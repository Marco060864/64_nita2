forward
global type w_doc_agente_rpt from w_print_main
end type
end forward

global type w_doc_agente_rpt from w_print_main
int Width=2386
int Height=1232
boolean TitleBar=true
string Title="Documenti per Agente"
end type
global w_doc_agente_rpt w_doc_agente_rpt

type variables
integer ii_tab_seq_pro
integer ii_tab_seq_dat
long il_id_esercizio
long il_num_pro
date id_ult_dat
end variables

on w_doc_agente_rpt.create
call super::create
end on

on w_doc_agente_rpt.destroy
call super::destroy
end on

event ue_pre_print;call super::ue_pre_print;
long		ll_retval
date		ldt_da_data, ldt_a_data
decimal {0} ld_da_num_progressivo, ld_a_num_progressivo

String 	statement, ls_selezione
String	ls_da_agente, ls_a_agente
String	ls_da_tipo_registro, ls_a_tipo_registro

ldt_da_data	     		 = tab_1.tabpage_select.dw_selection.GetItemDate(1,"da_data")
ldt_a_data	     		 = tab_1.tabpage_select.dw_selection.GetItemDate(1,"a_data")
ld_da_num_progressivo = tab_1.tabpage_select.dw_selection.GetItemNumber(1,"da_num_progressivo")
ld_a_num_progressivo  = tab_1.tabpage_select.dw_selection.GetItemNumber(1,"a_num_progressivo")
ls_da_agente     		 = tab_1.tabpage_select.dw_selection.GetItemstring(1,"da_cod_agente")
ls_a_agente      		 = tab_1.tabpage_select.dw_selection.GetItemstring(1,"a_cod_agente")
ls_da_tipo_registro	 = tab_1.tabpage_select.dw_selection.GetItemstring(1,"da_tipo_registro")
ls_a_tipo_registro	 = tab_1.tabpage_select.dw_selection.GetItemstring(1,"a_tipo_registro")

statement  = " {Documento.ID_Azienda} = 1"

if Not IsNull(ldt_da_data) and Not IsNull(ldt_a_data) then
	if ldt_da_data > ldt_a_data then
		MessageBox( "Attenzione","Da Data reg. è maggiore di A Data reg. ")
		return -1
	end if	
end if

if Not IsNull(ldt_da_data) then
	statement 		= statement + " AND {Documento.Data_registrazione} >= Date (" + string(ldt_da_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= " Da data reg. " + string(ldt_da_data, "dd/mm/yyyy") + ", "
end if

if Not IsNull(ldt_a_data) then
	statement 		= statement + " AND {Documento.Data_registrazione} <= Date (" + string(ldt_a_data, "yyyy, mm, dd") + ")"
	ls_selezione 	= ls_selezione + "a data reg. " + string(ldt_a_data, "dd/mm/yyyy") + "."
end if

if (not isnull(ld_da_num_progressivo)) and (not isnull(ld_a_num_progressivo)) then
	if ld_da_num_progressivo > ld_a_num_progressivo then
		MessageBox( "Attenzione","Da Prot. è maggiore di A Prot.")
		return -1
	end if
end if

if (not isnull(ld_da_num_progressivo)) then
	statement 		= statement + " AND documento.num_progressivo} >= " + string(ld_da_num_progressivo)
   ls_selezione 	= ls_selezione + " Da Prot. " + string(ld_da_num_progressivo)
end if

if (not isnull(ld_a_num_progressivo)) then
   statement 		= statement + " AND {documento.num_progressivo} <= " + string(ld_a_num_progressivo)
   ls_selezione 	= ls_selezione + " A Prot.: " + string(ld_a_num_progressivo) + ";"
end if


if (not isnull(ls_da_agente)) and (not isnull(ls_a_agente)) then
	if ls_da_agente > ls_a_agente then
		MessageBox( "Attenzione","Da Agente è maggiore di A Agente")
		return -1
	end if
end if
if (not isnull(ls_da_agente)) then
	statement 		= statement + " AND {sog_commerciale.Codice} >= '" + ls_da_agente + "'"
   ls_selezione 	= ls_selezione + " Da Agente " + ls_da_agente 
end if

if (not isnull(ls_a_agente)) then
   statement 		= statement + " AND {sog_commerciale.Codice} <= '" + ls_a_agente + "'"
   ls_selezione 	= ls_selezione + " A Agente " + ls_a_agente + "."
end if

if (not isnull(ls_da_tipo_registro)) and (not isnull(ls_a_tipo_registro)) then
	if ls_da_tipo_registro > ls_a_tipo_registro then
		MessageBox( "Attenzione","Da Tipo registro è maggiore di A Tipo Registro")
		return -1
	end if
end if
if (not isnull(ls_da_tipo_registro)) then
	statement 		= statement + " AND {registro.tipo_registro} >= '" + ls_da_tipo_registro + "'"
   ls_selezione 	= ls_selezione + " Da Tipo reg. " + ls_da_tipo_registro
end if

if (not isnull(ls_a_tipo_registro)) then
   statement 		= statement + " AND {registro.tipo_registro} <= '" + ls_a_tipo_registro + "'"
   ls_selezione 	= ls_selezione + " A Tipo reg. " + ls_a_tipo_registro
end if


is_selection = statement

istr_formule[1].formula_name 		= "selezione"
istr_formule[1].formula_string 	= "'" + ls_selezione + "'"

istr_formule[2].formula_name 		= "id_valuta"
istr_formule[2].formula_string 	= string(tab_1.tabpage_select.dw_selection.getitemnumber(1, "id_valuta"))

istr_formule[3].formula_name 		= "da_agente"
istr_formule[3].formula_string 	= "'" + tab_1.tabpage_select.dw_selection.getitemstring(1, "da_cod_agente") + "'"

istr_formule[4].formula_name 		= "a_agente"
istr_formule[4].formula_string 	= "'" + tab_1.tabpage_select.dw_selection.getitemstring(1, "a_cod_agente") + "'"

return 0

end event

event ue_pre_open;this.Title = istr_coddes_rpt.titolo_finestra
end event

type cb_esci from w_print_main`cb_esci within w_doc_agente_rpt
int X=1970
int Y=28
end type

type tab_1 from w_print_main`tab_1 within w_doc_agente_rpt
int X=14
int Y=192
int Width=2331
int Height=936
end type

type tabpage_select from w_print_main`tabpage_select within tab_1
int X=18
int Y=112
int Width=2295
int Height=808
end type

type dw_selection from w_print_main`dw_selection within tabpage_select
int X=32
int Y=32
int Width=2235
int Height=752
string DataObject="d_doc_agente_ff"
end type

event dw_selection::itemchanged;date		ldt_da_data
string 	ls_sql_cond,ls_dbc[],ls_dbv[],ls_dwc[]
integer 	li_ok


CHOOSE CASE dwo.name
	CASE 'a_data'
		ldt_da_data = This.GetItemDate(1, "da_data")
		if Date(data) < ldt_da_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("fino_data")
		end if

	case "da_cod_agente"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_cod_agente"
		ls_dwc[2] = "da_des_agente"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod_agente')) or this.getitemstring(1,'a_cod_agente')='' then
				 this.setitem(1,'a_cod_agente',data)
				 this.setitem(1,'a_des_agente',this.getitemstring(1,'da_des_agente'))
			end if
			return 2
		end if	
		
	case "da_des_agente"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_cod_agente"
		ls_dwc[2] = "da_des_agente"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_cod_agente')) or this.getitemstring(1,'a_cod_agente')='' then
				 this.setitem(1,'a_des_agente',data)
				 this.setitem(1,'a_cod_agente',this.getitemstring(1,'da_cod_agente'))
			end if
			return 2
		end if	
	
	case "a_cod_agente"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_cod_agente"
		ls_dwc[2] = "a_des_agente"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_des_agente"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_cod_agente"
		ls_dwc[2] = "a_des_agente"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if			
END CHOOSE		
end event

event dw_selection::ue_initial;string	ls_data_oggi
date 		ldt_inizio_esercizio
long		ll_id_valuta 

SELECT esercizio.data_inizio 
INTO   :ldt_inizio_esercizio
FROM   esercizio 
WHERE  esercizio.id_azienda = 1 ;
	
this.SetItem(1, "da_data", ldt_inizio_esercizio )
this.SetItem( 1,"a_data",Today() )

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

if (ll_id_valuta > 0) then 
	this.setitem(1, "id_valuta", ll_id_valuta)
end if


end event

event dw_selection::ue_init;call super::ue_init;is_drop_column[1]	= "id_valuta"
is_drop_column[2]	= "id_valuta_des"
is_drop_column[3]	= "da_tipo_registro"
is_drop_column[4]	= "a_tipo_registro"

end event

event dw_selection::ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_cod_agente"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="codice"
	CASE "a_cod_agente"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="codice"
		
	CASE "da_des_agente"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="rag_soc_1"
		
	CASE "a_des_agente"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="rag_soc_1"

END CHOOSE
end event

event dw_selection::ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_cod_agente", "a_cod_agente"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_cod_agente" then
			uf_set_colval("da_des_agente", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod_agente')) or this.getitemstring(1,'a_cod_agente')='' then
				 uf_set_colval('a_cod_agente', is_ricpar.s_main_value)
			    uf_set_colval("a_des_agente", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_des_agente", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_des_agente", "a_des_agente"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_des_agente" then
			uf_set_colval("da_cod_agente", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_cod_agente')) or this.getitemstring(1,'a_cod_agente')='' then
				 uf_set_colval('a_des_agente', is_ricpar.s_main_value)
			    uf_set_colval("a_cod_agente", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_des_agente", is_ricpar.s_ausil_value[1])
		end if

END CHOOSE
end event

type tabpage_stampante from w_print_main`tabpage_stampante within tab_1
int X=18
int Y=112
int Width=2295
int Height=808
end type

type tabpage_export from w_print_main`tabpage_export within tab_1
int X=18
int Y=112
int Width=2295
int Height=808
end type

type cb_stampa from w_print_main`cb_stampa within w_doc_agente_rpt
int X=1714
int Y=28
end type

event cb_stampa::pre_print;
end event

