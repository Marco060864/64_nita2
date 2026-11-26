forward
global type w_movart_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_movart_cx
end type
type cb_ok from commandbutton within w_movart_cx
end type
type dw_1 from u_dw_ext_main within w_movart_cx
end type
end forward

global type w_movart_cx from w_wiz_main
int Width=2926
int Height=1388
boolean TitleBar=true
string Title="Stampa Movimenti Articolo per Causale"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_movart_cx w_movart_cx

on w_movart_cx.create
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

on w_movart_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;
dw_1.insertrow(1)

String	ls_da_caus_cod, ls_a_caus_cod, ls_da_num_doc, ls_a_num_doc
String	ls_da_mag_cod, ls_a_mag_cod


datawindowchild ldw_da_caus_cod, ldw_da_caus_des, ldw_a_caus_cod, ldw_a_caus_des
datawindowchild ldw_da_mag_cod, ldw_da_mag_des, ldw_a_mag_cod, ldw_a_mag_des

dw_1.GetChild("da_caus_cod", ldw_da_caus_cod)
dw_1.GetChild("da_caus_des", ldw_da_caus_des)

dw_1.GetChild("a_caus_cod", ldw_a_caus_cod)
dw_1.GetChild("a_caus_des", ldw_a_caus_des)

dw_1.GetChild("da_mag_cod", ldw_da_mag_cod)
dw_1.GetChild("da_mag_des", ldw_da_mag_des)

dw_1.GetChild("a_mag_cod", ldw_a_mag_cod)
dw_1.GetChild("a_mag_des", ldw_a_mag_des)

dw_1.Accepttext()

ldw_da_caus_cod.SetTransObject(SQLCA)
ldw_da_caus_cod.Retrieve()

ldw_da_caus_des.SetTransObject(SQLCA)
ldw_da_caus_des.Retrieve()

ldw_a_caus_cod.SetTransObject(SQLCA)
ldw_a_caus_cod.Retrieve()

ldw_a_caus_des.SetTransObject(SQLCA)
ldw_a_caus_des.Retrieve()

ldw_da_mag_cod.SetTransObject(SQLCA)
ldw_da_mag_cod.Retrieve()

ldw_da_mag_des.SetTransObject(SQLCA)
ldw_da_mag_des.Retrieve()

ldw_a_mag_cod.SetTransObject(SQLCA)
ldw_a_mag_cod.Retrieve()

ldw_a_mag_des.SetTransObject(SQLCA)
ldw_a_mag_des.Retrieve()

long	ll_id_valuta
Datawindowchild ldw_id_valuta, ldw_id_valuta_des

dw_1.GetChild("id_valuta", ldw_id_valuta)
dw_1.GetChild("id_valuta_des", ldw_id_valuta_des)

ldw_id_valuta.SetTransObject(SQLCA)
ldw_id_valuta.Retrieve()

ldw_id_valuta_des.SetTransObject(SQLCA)
ldw_id_valuta_des.Retrieve()

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 par_sistema
;

dw_1.setitem(1, "id_valuta", ll_id_valuta)
end event

type cb_annulla from commandbutton within w_movart_cx
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

type cb_ok from commandbutton within w_movart_cx
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
String 	ls_filtro, ls_ordinamento, ls_parametri, ls_tipo_stampa
String	ls_da_articolo, ls_a_articolo, ls_da_caus_cod, ls_a_caus_cod, ls_da_num_doc, ls_a_num_doc
Date		ld_da_data_doc, ld_a_data_doc
String	ls_da_mag_cod, ls_a_mag_cod
Long	   ll_id_valuta	

s_rpt_mag str_param

dw_1.Accepttext()

ls_tipo_stampa = dw_1.Object.tipo_stampa[1]

ls_da_articolo = dw_1.Object.da_articolo[1]
ls_a_articolo  = dw_1.Object.a_articolo[1]

ls_da_caus_cod = dw_1.Object.da_caus_cod[1]
ls_a_caus_cod =  dw_1.Object.a_caus_cod[1]

ls_da_num_doc = dw_1.Object.da_num_doc[1]
ls_a_num_doc = dw_1.Object.a_num_doc[1]

ld_da_data_doc = dw_1.Object.da_data_doc[1]
ld_a_data_doc = dw_1.Object.a_data_doc[1]

ls_da_mag_cod = dw_1.Object.da_mag_cod[1]
ls_a_mag_cod = dw_1.Object.a_mag_cod[1]

ll_id_valuta = dw_1.GetItemNumber(1, "id_valuta")	

If ls_da_articolo>ls_a_articolo then
	MessageBox("Stampa movimenti articoli","L'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If
If ls_da_caus_cod>ls_a_caus_cod then
	MessageBox("Stampa movimenti articoli","La causale iniziale è maggiore di quella finale",exclamation!)
	Return
End If
If ls_da_num_doc>ls_a_num_doc then
	MessageBox("Stampa movimenti articoli","Il num. documento iniziale è maggiore di quello finale",exclamation!)
	Return
End If
If ld_da_data_doc>ld_a_data_doc then
	MessageBox("Stampa movimenti articoli","La data documento iniziale è maggiore di quella finale",exclamation!)
	Return
End If
If ls_da_mag_cod>ls_a_mag_cod then
	MessageBox("Stampa movimenti articoli","Il magazzino iniziale è maggiore di quello finale",exclamation!)
	Return
End If

if isnull(ll_id_valuta) then
	messagebox("Stampa movimenti articoli","Specificare la Valuta",exclamation!)
	Return
End If


	

If not (IsNull(ls_da_articolo)) then
	ls_filtro="articolo.codice >= " + "'" + ls_da_articolo + "'"
	ls_parametri='Da Articolo:' + ls_da_articolo
end if

If not (IsNull(ls_a_articolo)) and ls_filtro = '' then
	ls_filtro="articolo.codice <= " + "'" + ls_a_articolo + "'"
	ls_parametri='A Articolo:' + ls_a_articolo
ElseIf not (IsNull(ls_a_articolo)) and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND articolo.codice <= " + "'" + ls_a_articolo + "'"
	ls_parametri=ls_parametri + '  A Articolo:' + ls_a_articolo
end if
	
if not(IsNull(ls_da_caus_cod)) and ls_filtro = ''  then
	ls_filtro="caus_magazzino.codice >= " + "'" + ls_da_caus_cod + "'"
	ls_parametri='Da Causale:' + ls_da_caus_cod
elseif not(IsNull(ls_da_caus_cod)) and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND caus_magazzino.codice >= " + "'" + ls_da_caus_cod + "'"
	ls_parametri=ls_parametri+' Da Causale:' + ls_da_caus_cod
End If

if not(IsNull(ls_a_caus_cod)) and ls_filtro = '' then
	ls_filtro="caus_magazzino.codice <= " + "'" + ls_a_caus_cod + "'"
	ls_parametri='A Causale:' + ls_a_caus_cod
elseif not(IsNull(ls_a_caus_cod)) and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND caus_magazzino.codice <= " + "'" + ls_a_caus_cod + "'"
	ls_parametri=ls_parametri+' A Causale:' + ls_a_caus_cod
End If

if not(IsNull(ls_da_num_doc)) and ls_filtro = '' then
	ls_filtro="documento.num_documento >= " + "'" + ls_da_num_doc + "'"
	ls_parametri='Da N. documento:' + ls_da_num_doc
elseif not(IsNull(ls_da_num_doc)) and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND documento.num_documento >= " + "'" + ls_da_num_doc + "'"
	ls_parametri=ls_parametri+' Da N. documento:' + ls_da_num_doc
End If

if not(IsNull(ls_a_num_doc)) and ls_filtro = '' then
	ls_filtro="documento.num_documento <= " + "'" + ls_a_num_doc + "'"
	ls_parametri='A N. documento:' + ls_a_num_doc
elseif not(IsNull(ls_a_num_doc)) and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND documento.num_documento <= " + "'" + ls_a_num_doc + "'"
	ls_parametri=ls_parametri+' A N. documento:' + ls_a_num_doc
End If

if not(IsNull(ld_da_data_doc)) and ls_filtro = '' then
	ls_filtro="documento.data_documento >= " + "'" + String(ld_da_data_doc, 'yyyy/mm/dd') + "'"
	ls_parametri='Da data documento:' + String(ld_da_data_doc, 'dd/mm/yyyy')
elseif not(IsNull(ld_da_data_doc)) and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND documento.data_documento >= " + "'" + String(ld_da_data_doc, 'yyyy/mm/dd') + "'"
	ls_parametri= ls_parametri + ' Da data documento:' + String(ld_da_data_doc, 'dd/mm/yyyy')
End If

if not(IsNull(ld_a_data_doc)) and ls_filtro = '' then
	ls_filtro="documento.data_documento <= " + "'" + String(ld_a_data_doc, 'yyyy/mm/dd') + "'"
	ls_parametri='A data documento:' + String(ld_a_data_doc, 'dd/mm/yyyy')
elseif not(IsNull(ld_a_data_doc)) and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND documento.data_documento <= " + "'" + String(ld_a_data_doc, 'yyyy/mm/dd') + "'"
	ls_parametri=ls_parametri+' A data documento:' + String(ld_a_data_doc, 'dd/mm/yyyy')
End If

if not(IsNull(ls_da_mag_cod)) and ls_filtro = '' then
	ls_filtro="magazzino.codice >= " + "'" + ls_da_mag_cod + "'"
	ls_parametri='Da Magazzino:' + ls_da_mag_cod
elseif not(IsNull(ls_da_mag_cod)) and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND magazzino.codice >= " + "'" + ls_da_mag_cod + "'"
	ls_parametri=ls_parametri+' Da Magazzino:' + ls_da_mag_cod
End If

if not(IsNull(ls_a_mag_cod)) and ls_filtro = '' then
	ls_filtro="magazzino.codice <= " + "'" + ls_a_mag_cod + "'"
	ls_parametri='A Magazzino:' + ls_a_mag_cod
elseif not(IsNull(ls_a_mag_cod)) and ls_filtro <> '' then
	ls_filtro=ls_filtro + " AND magazzino.codice <= " + "'" + ls_a_mag_cod + "'"
	ls_parametri=ls_parametri+' A Magazzino:' + ls_a_mag_cod
End If

str_param.filtro = ls_filtro
str_param.parametri = ls_parametri

str_param.da_data = ld_da_data_doc
str_param.a_data = ld_a_data_doc

str_param.id_valuta				= ll_id_valuta		

If ls_tipo_stampa = 'S' Then
	OpenWithParm(w_sch_movart_rpt, str_param)	
Else
	OpenWithParm(w_movart_rpt, str_param)
End If
end event

type dw_1 from u_dw_ext_main within w_movart_cx
int X=32
int Y=128
int Width=2825
int Height=1124
int TabOrder=2
string DataObject="d_movart_ext"
end type

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "da_des_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	CASE "a_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "a_des_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"	
END CHOOSE






end event

event ue_use_search;choose case as_nomecol
	case "da_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_des_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
            uf_set_colval("a_articolo",is_ricpar.s_main_value)
				uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])
	      end if 
	case "da_des_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
            uf_set_colval("a_des_articolo",is_ricpar.s_main_value)
				uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
	      end if 
	case "a_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])	
	case "a_des_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
	end choose
	
	
	
	

end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
CHOOSE CASE dwo.name
	CASE "da_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
           This.SetItem(1, "a_articolo", Data)			
           This.SetItem(1, "a_des_articolo", This.GetItemString(1, "da_des_articolo"))			
	      end if 
			RETURN 2
		END IF
		
		
	CASE "da_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc) 	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
          This.SetItem(1, "a_des_articolo", Data)			
          This.SetItem(1, "a_articolo", This.GetItemString(1, "da_articolo"))			
	      end if
			RETURN 2
		END IF

	CASE "a_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
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
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE








end event

