forward
global type w_st_esival_lotti_wz from w_wiz_main
end type
type dw_1 from u_dw_ext_main within w_st_esival_lotti_wz
end type
type cb_ok from commandbutton within w_st_esival_lotti_wz
end type
type cb_annulla from commandbutton within w_st_esival_lotti_wz
end type
end forward

global type w_st_esival_lotti_wz from w_wiz_main
int Width=2853
int Height=1448
boolean TitleBar=true
string Title="Valorizzazione Lotti"
dw_1 dw_1
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_st_esival_lotti_wz w_st_esival_lotti_wz

on w_st_esival_lotti_wz.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_annulla
end on

on w_st_esival_lotti_wz.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;
date ldt_data_inizio

dw_1.insertrow(1)

datawindowchild ldw_da_cod_cat_merc_articolo, ldw_a_cod_cat_merc_articolo
datawindowchild ldw_da_des_cat_merc_articolo, ldw_a_des_cat_merc_articolo
datawindowchild ldw_da_cod_cat_fiscale, ldw_a_cod_cat_fiscale
datawindowchild ldw_da_des_cat_fiscale, ldw_a_des_cat_fiscale

dw_1.GetChild("da_cod_cat_merc_articolo", ldw_da_cod_cat_merc_articolo)
dw_1.GetChild("a_cod_cat_merc_articolo", ldw_a_cod_cat_merc_articolo)

dw_1.GetChild("da_des_cat_merc_articolo", ldw_da_des_cat_merc_articolo)
dw_1.GetChild("a_des_cat_merc_articolo", ldw_a_des_cat_merc_articolo)

dw_1.GetChild("da_cod_cat_fiscale", ldw_da_cod_cat_fiscale)
dw_1.GetChild("a_cod_cat_fiscale", ldw_a_cod_cat_fiscale)
dw_1.GetChild("da_des_cat_fiscale", ldw_da_des_cat_fiscale)
dw_1.GetChild("a_des_cat_fiscale", ldw_a_des_cat_fiscale)

dw_1.Accepttext()

ldw_da_cod_cat_merc_articolo.SetTransObject(SQLCA)
ldw_da_cod_cat_merc_articolo.Retrieve()

ldw_a_cod_cat_merc_articolo.SetTransObject(SQLCA)
ldw_a_cod_cat_merc_articolo.Retrieve()

ldw_da_des_cat_merc_articolo.SetTransObject(SQLCA)
ldw_da_des_cat_merc_articolo.Retrieve()

ldw_a_des_cat_merc_articolo.SetTransObject(SQLCA)
ldw_a_des_cat_merc_articolo.Retrieve()

ldw_da_cod_cat_fiscale.SetTransObject(SQLCA)
ldw_da_cod_cat_fiscale.Retrieve()

ldw_da_des_cat_fiscale.SetTransObject(SQLCA)
ldw_da_des_cat_fiscale.Retrieve()

ldw_a_cod_cat_fiscale.SetTransObject(SQLCA)
ldw_a_cod_cat_fiscale.Retrieve()

ldw_a_des_cat_fiscale.SetTransObject(SQLCA)
ldw_a_des_cat_fiscale.Retrieve()

SELECT e.data_inizio
INTO	 :ldt_data_inizio
FROM	 esercizio e, azienda a
WHERE  e.id_esercizio = a.id_esercizio_proposto
AND    a.id_azienda = 1
;

dw_1.setitem(1, "da_data_esistenza", ldt_data_inizio)
dw_1.setitem(1, "a_data_esistenza", today())
end event

type dw_1 from u_dw_ext_main within w_st_esival_lotti_wz
int X=37
int Y=160
int Width=2747
int Height=1156
int TabOrder=10
boolean BringToTop=true
string DataObject="d_st_esival_lotti_ext"
end type

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
END CHOOSE

end event

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
			
END CHOOSE

end event

type cb_ok from commandbutton within w_st_esival_lotti_wz
int X=2286
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
String 	ls_filtro, ls_parametri
String	ls_da_articolo, ls_a_articolo
String	ls_da_cod_cat_merc_articolo, ls_a_cod_cat_merc_articolo
String	ls_da_cod_cat_fiscale, ls_a_cod_cat_fiscale
String	ls_da_cod_lotto, ls_a_cod_lotto
Date		ldt_da_data_esistenza, ldt_a_data_esistenza

s_rpt_mag str_param

dw_1.Accepttext()

ldt_da_data_esistenza = dw_1.Object.da_data_esistenza[1]
ldt_a_data_esistenza  = dw_1.Object.a_data_esistenza[1]

if (isnull(ldt_da_data_esistenza)) or (isnull(ldt_a_data_esistenza)) then
	messagebox("Stampa valorizzazione lotti", "Le date sono obbligatorie ...")
	return
end if

ls_da_articolo = dw_1.Object.da_cod_articolo[1]
ls_a_articolo  = dw_1.Object.a_cod_articolo[1]

If ls_da_articolo > ls_a_articolo then
	MessageBox("Stampa valorizzazione lotti","L'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If

ls_da_cod_cat_merc_articolo = dw_1.Object.da_cod_cat_merc_articolo[1]
ls_a_cod_cat_merc_articolo  = dw_1.Object.a_cod_cat_merc_articolo[1]

If ls_da_cod_cat_merc_articolo > ls_da_cod_cat_merc_articolo then
	MessageBox("Stampa valorizzazione lotti","La cat. merc. iniziale è maggiore di quella finale",exclamation!)
	Return
End If

ls_da_cod_cat_fiscale = dw_1.Object.da_cod_cat_fiscale[1]
ls_a_cod_cat_fiscale  = dw_1.Object.a_cod_cat_fiscale[1]

If ls_da_cod_cat_fiscale > ls_a_cod_cat_fiscale then
	MessageBox("Stampa valorizzazione lotti","La cat. fiscale iniziale è maggiore di quella finale",exclamation!)
	Return
End If

ls_da_cod_lotto = dw_1.Object.da_cod_lotto[1]
ls_a_cod_lotto  = dw_1.Object.a_cod_lotto[1]

If ls_da_cod_lotto > ls_a_cod_lotto then
	MessageBox("Stampa valorizzazione lotti","Il codice lotto iniziale è maggiore di quello finale",exclamation!)
	Return
End If

	
ls_parametri='Data Inizio:' + string(ldt_da_data_esistenza)

ls_parametri= ls_parametri + ' Data Fine:' + string(ldt_a_data_esistenza)


If not (IsNull(ls_da_articolo)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro="articolo.codice >= " + "'" + ls_da_articolo + "'"
	ls_parametri = ls_parametri + ' Da Articolo:' + ls_da_articolo
end if

If not (IsNull(ls_a_articolo)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro 		= ls_filtro + "articolo.codice <= " + "'" + ls_a_articolo + "'"
	ls_parametri	= ls_parametri + ' A Articolo:' + ls_a_articolo
end if

If not (IsNull(ls_da_cod_cat_merc_articolo)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro		= ls_filtro + "cat_merceologica.codice >= " + "'" + ls_da_cod_cat_merc_articolo + "'"
	ls_parametri	= ls_parametri + ' Da cat.merc.:' + ls_da_cod_cat_merc_articolo
end if

If not (IsNull(ls_a_cod_cat_merc_articolo)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro	= ls_filtro + "cat_merceologica.codice <= " + "'" + ls_a_cod_cat_merc_articolo + "'"
	ls_parametri = ls_parametri + ' A cat.merc.:' + ls_a_cod_cat_merc_articolo
end if

If not (IsNull(ls_da_cod_cat_fiscale)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro		= ls_filtro + "cat_fiscale.codice >= " + "'" + ls_da_cod_cat_fiscale + "'"
	ls_parametri	= ls_parametri + ' Da cat.fiscale:' + ls_da_cod_cat_fiscale
end if

If not (IsNull(ls_a_cod_cat_fiscale)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro	= ls_filtro + "cat_fiscale.codice <= " + "'" + ls_a_cod_cat_fiscale + "'"
	ls_parametri = ls_parametri + ' A cat.fiscale:' + ls_a_cod_cat_fiscale
end if

If not (IsNull(ls_da_cod_lotto)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro		= ls_filtro + "lotto.cod_esterno >= " + "'" + ls_da_cod_lotto + "'"
	ls_parametri	= ls_parametri + ' Da Lotto:' + ls_da_cod_lotto
end if

If not (IsNull(ls_a_cod_lotto)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro		= ls_filtro + "lotto.cod_esterno <= " + "'" + ls_a_cod_lotto + "'"
	ls_parametri	= ls_parametri + ' A Lotto:' + ls_a_cod_lotto
end if

str_param.filtro    = ls_filtro
str_param.parametri = ls_parametri
str_param.da_data   = ldt_da_data_esistenza
str_param.a_data    = ldt_a_data_esistenza

OpenWithParm(w_st_esival_lotti_rpt, str_param)	


end event

type cb_annulla from commandbutton within w_st_esival_lotti_wz
int X=2555
int Y=32
int Width=229
int Height=84
int TabOrder=20
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

