forward
global type w_st_tracciabilita_wz from w_wiz_main
end type
type cb_annulla from commandbutton within w_st_tracciabilita_wz
end type
type cb_ok from commandbutton within w_st_tracciabilita_wz
end type
type dw_1 from u_dw_ext_main within w_st_tracciabilita_wz
end type
end forward

global type w_st_tracciabilita_wz from w_wiz_main
int Width=2926
int Height=1352
boolean TitleBar=true
string Title="Stampe tracciabilità lotti"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_st_tracciabilita_wz w_st_tracciabilita_wz

on w_st_tracciabilita_wz.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_st_tracciabilita_wz.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;
dw_1.insertrow(1)

datawindowchild ldw_id_variazione_1, ldw_id_variazione_2
datawindowchild ldw_da_id_cat_com_articolo, ldw_a_id_cat_com_articolo

dw_1.GetChild("id_variazione_1", ldw_id_variazione_1)
dw_1.GetChild("id_variazione_2", ldw_id_variazione_2)

dw_1.GetChild("da_cod_cat_com_articolo", ldw_da_id_cat_com_articolo)
dw_1.GetChild("a_cod_cat_com_articolo", ldw_a_id_cat_com_articolo)

dw_1.Accepttext()

ldw_id_variazione_1.SetTransObject(SQLCA)
ldw_id_variazione_1.Retrieve()

ldw_id_variazione_2.SetTransObject(SQLCA)
ldw_id_variazione_2.Retrieve()

ldw_da_id_cat_com_articolo.SetTransObject(SQLCA)
ldw_da_id_cat_com_articolo.Retrieve()

ldw_a_id_cat_com_articolo.SetTransObject(SQLCA)
ldw_a_id_cat_com_articolo.Retrieve()

end event

type cb_annulla from commandbutton within w_st_tracciabilita_wz
int X=2629
int Y=32
int Width=229
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="&Esci"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type cb_ok from commandbutton within w_st_tracciabilita_wz
int X=2359
int Y=32
int Width=242
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stam&pa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
String 	ls_filtro, ls_parametri, ls_tipo_stampa
String	ls_da_articolo, ls_a_articolo
String	ls_da_cod_esterno, ls_a_cod_esterno
Date		ldt_da_data_registrazione, ldt_a_data_registrazione
Date		ldt_da_data_scadenza, ldt_a_data_scadenza

s_st_listino_prezzi str_param

dw_1.Accepttext()

ls_tipo_stampa = dw_1.Object.tipo_stampa[1]

ls_da_articolo = dw_1.Object.da_cod_articolo[1]
ls_a_articolo  = dw_1.Object.a_cod_articolo[1]

If ls_da_articolo > ls_a_articolo then
	MessageBox("Stampa tracciabilità lotti","L'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If

ls_da_cod_esterno = dw_1.Object.da_cod_esterno[1]
ls_a_cod_esterno  = dw_1.Object.a_cod_esterno[1]

If ls_da_cod_esterno > ls_a_cod_esterno then
	MessageBox("Stampa tracciabilità lotti","Il codice esterno iniziale è maggiore di quello finale",exclamation!)
	Return
End If

ldt_da_data_registrazione = dw_1.Object.da_data_registrazione[1]
ldt_a_data_registrazione  = dw_1.Object.a_data_registrazione[1]

If ldt_da_data_registrazione > ldt_a_data_registrazione then
	MessageBox("Stampa tracciabilità lotti","La data di registrazione iniziale è maggiore di quella finale",exclamation!)
	Return
End If

ldt_da_data_scadenza = dw_1.Object.da_data_scadenza[1]
ldt_a_data_scadenza  = dw_1.Object.a_data_scadenza[1]

If ldt_da_data_scadenza > ldt_a_data_scadenza then
	MessageBox("Stampa tracciabilità lotti","La data di registrazione iniziale è maggiore di quella finale",exclamation!)
	Return
End If


	


if (isnull(ls_filtro)) then ls_filtro = ''

If not (IsNull(ls_da_articolo)) then
	ls_filtro="articolo_a.codice >= " + "'" + ls_da_articolo + "'"
	ls_parametri='Da Articolo:' + ls_da_articolo
end if

If not (IsNull(ls_a_articolo)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro=ls_filtro + " articolo_a.codice <= " + "'" + ls_a_articolo + "'"
	ls_parametri=ls_parametri + '  A Articolo:' + ls_a_articolo
end if

If not (IsNull(ls_da_cod_esterno)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro=ls_filtro + "lotto_a.cod_esterno >= " + "'" + ls_da_cod_esterno + "'"
	ls_parametri=ls_parametri + 'Da cod. esterno:' + ls_da_cod_esterno
end if

If not (IsNull(ls_a_cod_esterno)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro=ls_filtro + "lotto_a.cod_esterno <= " + "'" + ls_a_cod_esterno + "'"
	ls_parametri=ls_parametri + 'A cod. esterno:' + ls_a_cod_esterno
end if

CHOOSE CASE ls_tipo_stampa
	CASE '1'
		If not (IsNull(ldt_da_data_registrazione)) then
			if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
			ls_filtro=ls_filtro + "lotto_a.data_doc >= " + "'" + string(ldt_da_data_registrazione, 'yyyy-mm-dd') + "'"
			ls_parametri=ls_parametri + 'Da data reg.:' + string(ldt_da_data_registrazione)
		end if
		
		If not (IsNull(ldt_a_data_registrazione)) then
			if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
			ls_filtro=ls_filtro + "lotto_a.data_doc <= " + "'" + string(ldt_a_data_registrazione, 'yyyy-mm-dd') + "'"
			ls_parametri=ls_parametri + 'A data reg.:' + string(ldt_a_data_registrazione)
		end if
	CASE '2'
		If not (IsNull(ldt_da_data_registrazione)) then
			if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
			ls_filtro=ls_filtro + "documento_a.data_documento >= " + "'" + string(ldt_da_data_registrazione, 'yyyy-mm-dd') + "'"
			ls_parametri=ls_parametri + 'Da data reg.:' + string(ldt_da_data_registrazione)
		end if
		
		If not (IsNull(ldt_a_data_registrazione)) then
			if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
			ls_filtro=ls_filtro + "documento_a.data_documento <= " + "'" + string(ldt_a_data_registrazione, 'yyyy-mm-dd') + "'"
			ls_parametri=ls_parametri + 'A data reg.:' + string(ldt_a_data_registrazione)
		end if
		
END CHOOSE

If not (IsNull(ldt_da_data_scadenza)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro=ls_filtro + "lotto_a.data_scadenza>= " + "'" + string(ldt_da_data_scadenza, 'yyyy-mm-dd') + "'"
	ls_parametri=ls_parametri + 'Da data scad.:' + string(ldt_da_data_scadenza)
end if

If not (IsNull(ldt_a_data_scadenza)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro=ls_filtro + "lotto_a.data_scadenza <= " + "'" + string(ldt_a_data_scadenza, 'yyyy-mm-dd') + "'"
	ls_parametri=ls_parametri + 'A data scad.:' + string(ldt_a_data_scadenza)
end if

str_param.filtro = ls_filtro
str_param.parametri = ls_parametri
str_param.tipo_stampa = ls_tipo_stampa

OpenWithParm(w_st_tracciabilita_rpt, str_param)	


end event

type dw_1 from u_dw_ext_main within w_st_tracciabilita_wz
int X=32
int Y=128
int Width=2825
int Height=1092
int TabOrder=2
string DataObject="d_st_tracciabilita_ext"
end type

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_cod_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "da_des_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	CASE "a_cod_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "a_des_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"	
	CASE "da_cod_fornitore"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	CASE "da_rag_soc_1_fornitore"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
	CASE "a_cod_fornitore"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	CASE "a_rag_soc_1_fornitore"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"

END CHOOSE






end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_cod_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("da_des_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
            uf_set_colval("a_cod_articolo",is_ricpar.s_main_value)
				uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])
	      end if 
			
	CASE "da_des_articolo"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("da_cod_articolo",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
         uf_set_colval("a_des_articolo",is_ricpar.s_main_value)
			uf_set_colval("a_cod_articolo",is_ricpar.s_ausil_value[1])
      end if 
		
	CASE "a_cod_articolo"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])	
		
	CASE "a_des_articolo"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("a_cod_articolo",is_ricpar.s_ausil_value[1])
			
	CASE "da_cod_fornitore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_rag_soc_1_fornitore", is_ricpar.s_ausil_value[1])
		
	CASE "da_rag_soc_1_fornitore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod_fornitore", is_ricpar.s_ausil_value[1])
		
	CASE "a_cod_fornitore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_rag_soc_1_fornitore", is_ricpar.s_ausil_value[1])
		
	CASE "a_rag_soc_1_fornitore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod_fornitore", is_ricpar.s_ausil_value[1])

END CHOOSE
	
	
	
	

end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
CHOOSE CASE dwo.name
	CASE "da_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
           This.SetItem(1, "a_cod_articolo", Data)			
           This.SetItem(1, "a_des_articolo", This.GetItemString(1, "da_des_articolo"))			
	      end if 
			RETURN 2
		END IF
		
		
	CASE "da_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc) 	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
           This.SetItem(1, "a_cod_articolo", Data)			
           This.SetItem(1, "a_des_articolo", This.GetItemString(1, "da_des_articolo"))			
	      end if 
			RETURN 2
		END IF

	CASE "a_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'da_cod_fornitore'
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod_fornitore"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_rag_soc_1_fornitore"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	
	CASE "da_rag_soc_1_fornitore"
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod_fornitore"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_rag_soc_1_fornitore"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE 'a_cod_fornitore'
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_cod_fornitore"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_rag_soc_1_fornitore"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	
	CASE "a_rag_soc_1_fornitore"
		ls_sql_cond = ""
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_cod_fornitore"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_rag_soc_1_fornitore"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (li_ok > 0) THEN
			RETURN 2
		END IF		
END CHOOSE

end event

