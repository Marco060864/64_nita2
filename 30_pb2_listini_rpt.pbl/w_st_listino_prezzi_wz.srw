forward
global type w_st_listino_prezzi_wz from w_wiz_main
end type
type cb_annulla from commandbutton within w_st_listino_prezzi_wz
end type
type cb_ok from commandbutton within w_st_listino_prezzi_wz
end type
type dw_1 from u_dw_ext_main within w_st_listino_prezzi_wz
end type
end forward

global type w_st_listino_prezzi_wz from w_wiz_main
int Width=2926
int Height=1352
boolean TitleBar=true
string Title="Stampe listini prezzi"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_st_listino_prezzi_wz w_st_listino_prezzi_wz

on w_st_listino_prezzi_wz.create
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

on w_st_listino_prezzi_wz.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;
dw_1.insertrow(1)

datawindowchild ldw_id_variazione_1, ldw_id_variazione_2
datawindowchild ldw_da_cod_cat_merc_articolo, ldw_a_cod_cat_merc_articolo
datawindowchild ldw_da_cod_cat_merc_articolo_des, ldw_a_cod_cat_merc_articolo_des

dw_1.GetChild("id_variazione_1", ldw_id_variazione_1)
dw_1.GetChild("id_variazione_2", ldw_id_variazione_2)

dw_1.GetChild("da_cod_cat_merc_articolo", ldw_da_cod_cat_merc_articolo)
dw_1.GetChild("a_cod_cat_merc_articolo", ldw_a_cod_cat_merc_articolo)
dw_1.GetChild("da_cod_cat_merc_articolo_des", ldw_da_cod_cat_merc_articolo_des)
dw_1.GetChild("a_cod_cat_merc_articolo_des", ldw_a_cod_cat_merc_articolo_des)

dw_1.Accepttext()

ldw_id_variazione_1.SetTransObject(SQLCA)
ldw_id_variazione_1.Retrieve()

ldw_id_variazione_2.SetTransObject(SQLCA)
ldw_id_variazione_2.Retrieve()

ldw_da_cod_cat_merc_articolo.SetTransObject(SQLCA)
ldw_da_cod_cat_merc_articolo.Retrieve()

ldw_a_cod_cat_merc_articolo.SetTransObject(SQLCA)
ldw_a_cod_cat_merc_articolo.Retrieve()

ldw_da_cod_cat_merc_articolo_des.SetTransObject(SQLCA)
ldw_da_cod_cat_merc_articolo_des.Retrieve()

ldw_a_cod_cat_merc_articolo_des.SetTransObject(SQLCA)
ldw_a_cod_cat_merc_articolo_des.Retrieve()

end event

type cb_annulla from commandbutton within w_st_listino_prezzi_wz
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

type cb_ok from commandbutton within w_st_listino_prezzi_wz
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
String	ls_da_cod_cat_merc_articolo, ls_a_cod_cat_merc_articolo
String	ls_da_fornitore, ls_a_fornitore
Long		ll_id_variazione_1, ll_id_variazione_2

s_st_listino_prezzi str_param

dw_1.Accepttext()

ls_tipo_stampa = dw_1.Object.tipo_stampa[1]

ll_id_variazione_1 = dw_1.Object.id_variazione_1[1]

if not (ll_id_variazione_1 > 0) then
	MessageBox("Stampa Listino Prezzi","Specificare il listino",exclamation!)
	Return
End If

if (ls_tipo_stampa = '2') then
	ll_id_variazione_2 = dw_1.Object.id_variazione_2[1]
	
	if not (ll_id_variazione_2 > 0) then
		MessageBox("Stampa Listino Prezzi","Specificare il listino di riferimento",exclamation!)
		Return
	End If
end if

ls_da_articolo = dw_1.Object.da_cod_articolo[1]
ls_a_articolo  = dw_1.Object.a_cod_articolo[1]

If ls_da_articolo > ls_a_articolo then
	MessageBox("Stampa Listino Prezzi","L'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If

ls_da_cod_cat_merc_articolo = dw_1.Object.da_cod_cat_merc_articolo[1]
ls_a_cod_cat_merc_articolo  = dw_1.Object.a_cod_cat_merc_articolo[1]

If ls_da_cod_cat_merc_articolo > ls_da_cod_cat_merc_articolo then
	MessageBox("Stampa Listino Prezzi","La cat. merc. iniziale è maggiore di quella finale",exclamation!)
	Return
End If

ls_da_fornitore = dw_1.Object.da_cod_fornitore[1]
ls_a_fornitore  = dw_1.Object.a_cod_fornitore[1]

If ls_da_cod_cat_merc_articolo > ls_da_cod_cat_merc_articolo then
	MessageBox("Stampa Listino Prezzi","La cat. comm. iniziale è maggiore di quella finale",exclamation!)
	Return
End If

	

str_param.id_variazione_1 = ll_id_variazione_1
str_param.id_variazione_2 = ll_id_variazione_2

If not (IsNull(ls_da_articolo)) then
	ls_filtro="articolo.codice >= " + "'" + ls_da_articolo + "'"
	ls_parametri='Da Articolo:' + ls_da_articolo
end if

If not (IsNull(ls_a_articolo)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro 		= ls_filtro + "articolo.codice <= " + "'" + ls_a_articolo + "'"
	ls_parametri	= ls_parametri + 'A Articolo:' + ls_a_articolo
end if

if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
ls_filtro 		= ls_filtro + "articolo.stampa_in_listini = 'S'"	


If not (IsNull(ls_da_cod_cat_merc_articolo)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro		= ls_filtro + "cat_merceologica.codice >= " + "'" + ls_da_cod_cat_merc_articolo + "'"
	ls_parametri	= ls_parametri + 'Da cat.merc.:' + ls_da_cod_cat_merc_articolo
end if

If not (IsNull(ls_a_cod_cat_merc_articolo)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro	= ls_filtro + "cat_merceologica.codice <= " + "'" + ls_a_cod_cat_merc_articolo + "'"
	ls_parametri = ls_parametri + 'A cat.merc. Articolo:' + ls_a_cod_cat_merc_articolo
end if

If not (IsNull(ls_da_fornitore)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro=ls_filtro+"sog_commerciale.codice >= " + "'" + ls_da_fornitore + "'"
	ls_parametri=ls_parametri+'Da Fornitore:' + ls_da_fornitore
end if

If not (IsNull(ls_a_fornitore)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro=ls_filtro+"sog_commerciale.codice <= " + "'" + ls_a_fornitore + "'"
	ls_parametri=ls_parametri+'A Fornitore:' + ls_a_fornitore
end if

str_param.filtro = ls_filtro
str_param.parametri = ls_parametri
str_param.tipo_stampa = ls_tipo_stampa

OpenWithParm(w_st_listino_prezzi_rpt, str_param)	


end event

type dw_1 from u_dw_ext_main within w_st_listino_prezzi_wz
int X=32
int Y=128
int Width=2825
int Height=1092
int TabOrder=2
string DataObject="d_listino_prezzi_ext"
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

