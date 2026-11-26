forward
global type w_crondoc_ff from w_wiz_main
end type
type cb_annulla from commandbutton within w_crondoc_ff
end type
type cb_ok from commandbutton within w_crondoc_ff
end type
type dw_1 from u_dw_ext_main within w_crondoc_ff
end type
end forward

global type w_crondoc_ff from w_wiz_main
int Width=3035
int Height=1128
boolean TitleBar=true
string Title="Stampa Documenti in ordine cronologico"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_crondoc_ff w_crondoc_ff

on w_crondoc_ff.create
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

on w_crondoc_ff.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.insertrow(1)


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

dw_1.Post setitem(1, "id_valuta", ll_id_valuta)
end event

type cb_annulla from commandbutton within w_crondoc_ff
int X=2738
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

type cb_ok from commandbutton within w_crondoc_ff
int X=2395
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

event clicked;String 	ls_filtro, ls_parametri
String	ls_da_profilo, ls_a_profilo, ls_da_num_doc, ls_a_num_doc, ls_tipo_stampa
Date		ld_da_data_doc, ld_a_data_doc
Long		ll_id_valuta	

s_rpt_mag str_param

dw_1.accepttext()

ls_da_profilo = dw_1.getitemstring(1,"da_profilo_cod")
ls_a_profilo  = dw_1.getitemstring(1,"a_profilo_cod")

ld_da_data_doc = dw_1.getitemdate(1, "da_data_doc")
ld_a_data_doc  = dw_1.getitemdate(1, "a_data_doc")

ls_da_num_doc = dw_1.getitemstring(1,"da_num_doc")
ls_a_num_doc  = dw_1.getitemstring(1,"a_num_doc")

ls_tipo_stampa=dw_1.getitemstring(1,"tipo_stampa")

ll_id_valuta = dw_1.getitemnumber(1,"id_valuta")	

if isnull(ll_id_valuta) then
	messagebox("Elenco cronologico documenti","Specificare la valuta",exclamation!)
	Return
End If

if not (isnull(ls_da_profilo)) and not (isnull(ls_a_profilo)) and ls_da_profilo > ls_a_profilo then
	messagebox("Elenco cronologico documenti","Il codice del profilo iniziale è maggiore di quello finale",exclamation!)
	Return
End If

if not (isnull(ls_da_num_doc)) and not (isnull(ls_a_num_doc)) and ls_da_num_doc > ls_a_num_doc then
	messagebox("Elenco cronologico documenti","Il numero di documento iniziale è maggiore di quello finale",exclamation!)
	Return
End If

if not (isnull(ld_da_data_doc)) and not (isnull(ld_a_data_doc)) and ld_da_data_doc > ld_a_data_doc then
	messagebox("Elenco cronologico documenti","La data documento iniziale è maggiore di quella finale",exclamation!)
	Return
End If

	

if ls_da_profilo <> '' and ls_filtro = '' Then
	ls_filtro="prof_documento.codice >= " + "'" + ls_da_profilo + "'"
	ls_parametri='Da profilo:' + ls_da_profilo
end if

if ls_a_profilo <> '' and ls_filtro = '' Then
	ls_filtro="prof_documento.codice <= " + "'" + ls_a_profilo + "'"
	ls_parametri='A profilo:' + ls_a_profilo
elseif ls_a_profilo <> '' and ls_filtro <> '' Then
	ls_filtro=ls_filtro + " AND prof_documento.codice <= " + "'" + ls_a_profilo + "'"
	ls_parametri=ls_parametri + ' A profilo:' + ls_a_profilo	
end if

if not isnull(ld_da_data_doc) and ls_filtro = '' Then
	
	ls_filtro="documento.data_documento >= " + "'" + string(ld_da_data_doc, 'yyyy/mm/dd') + "'" 
	ls_parametri='Da data doc.:' + string(ld_da_data_doc)
elseif not isnull(ld_da_data_doc) and ls_filtro <> '' Then
	ls_filtro=ls_filtro + " AND documento.data_documento >= " + "'" + string(ld_da_data_doc, 'yyyy/mm/dd') + "'"
	ls_parametri=ls_parametri + ' Da data doc.:' + string(ld_da_data_doc)
end if

if not isnull(ld_a_data_doc) and ls_filtro = '' Then
	ls_filtro="documento.data_documento <= " + "'" + string(ld_a_data_doc, 'yyyy/mm/dd') + "'"
	ls_parametri='A data doc.:' + string(ld_a_data_doc)
elseif not isnull(ld_a_data_doc) and ls_filtro <> '' Then
	ls_filtro=ls_filtro + " AND documento.data_documento <= " + "'" + string(ld_a_data_doc, 'yyyy/mm/dd') + "'"
	ls_parametri=ls_parametri + ' A data doc.:' + string(ld_a_data_doc)
end if



if ls_da_num_doc <> '' and ls_filtro = '' Then
	ls_filtro="documento.num_documento >= " + "'" + ls_da_num_doc + "'"
	ls_parametri='Da num. doc.:' + ls_da_num_doc
elseif ls_da_num_doc <> '' and ls_filtro <> '' Then
	ls_filtro=ls_filtro + " AND documento.num_documento >= " + "'" + ls_da_num_doc + "'"
	ls_parametri=ls_parametri + ' Da num. doc.:' + ls_da_num_doc
end if

if ls_a_num_doc <> '' and ls_filtro = '' Then
	ls_filtro="documento.num_documento <= " + "'" + ls_a_num_doc + "'"
	ls_parametri=' A num. doc.:' + ls_a_num_doc
elseif ls_a_num_doc <> '' and ls_filtro <> '' Then
	ls_filtro=ls_filtro + " AND documento.num_documento <= " + "'" + ls_a_num_doc + "'"
	ls_parametri=ls_parametri + ' A num. doc.:' + ls_a_num_doc
end if

str_param.filtro 	  = ls_filtro
str_param.parametri = ls_parametri
str_param.id_valuta = ll_id_valuta

CHOOSE CASE ls_tipo_stampa
	CASE 'S'	
		OpenWithParm(w_crondoc_sin_rpt, str_param)
	CASE 'D' 
		OpenWithParm(w_crondoc_det_rpt, str_param)		
END CHOOSE
end event

type dw_1 from u_dw_ext_main within w_crondoc_ff
int X=32
int Y=128
int Width=2935
int Height=868
int TabOrder=2
string DataObject="d_crondoc_ext"
end type

event ue_set_search;CHOOSE CASE as_nomecol
	CASE	"da_profilo_cod"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_codice"
	CASE	"da_profilo_des"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_descrizione"
	CASE	"a_profilo_cod"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_codice"
	CASE	"a_profilo_des"
		is_search_window="w_cronologia_documenti_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_descrizione"	
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE	"da_profilo_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_profilo_des",is_ricpar.s_ausil_value[1])
			if isnull(this.Getitemstring(1,"a_profilo_cod")) or this.Getitemstring(1,"a_profilo_cod")='' then
			    uf_set_colval("a_profilo_cod",is_ricpar.s_main_value)
		       uf_set_colval("a_profilo_des",is_ricpar.s_ausil_value[1])
			end if	 
	CASE	"da_profilo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_profilo_cod",is_ricpar.s_ausil_value[1])
			if isnull(this.Getitemstring(1,"a_profilo_cod")) or this.Getitemstring(1,"a_profilo_cod")='' then
			  uf_set_colval("a_profilo_des",is_ricpar.s_main_value)
		     uf_set_colval("a_profilo_cod",is_ricpar.s_ausil_value[1])
		   end if  
	CASE	"a_profilo_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_profilo_des",is_ricpar.s_ausil_value[1])	
	CASE	"a_profilo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_profilo_cod",is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "da_profilo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_profilo_cod"
		ls_dwc[2] = "da_profilo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	
		IF (li_ok > 0) THEN
			if isnull(this.Getitemstring(1,"a_profilo_cod")) or this.Getitemstring(1,"a_profilo_cod")='' then
		     this.setitem(1,"a_profilo_cod",data)
           this.setitem(1,"a_profilo_des",This.GetItemString(1, "da_profilo_des"))
		   end if	
			RETURN 2
		END IF
		
	CASE "da_profilo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_profilo_cod"
		ls_dwc[2] = "da_profilo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	
		IF (li_ok > 0) THEN
			if isnull(this.Getitemstring(1,"a_profilo_cod")) or this.Getitemstring(1,"a_profilo_cod")='' then
		    this.setitem(1,"a_profilo_cod",This.GetItemString(1, "da_profilo_des"))
          this.setitem(1,"a_profilo_des",data)
	      end if  
			RETURN 2
		END IF
		
	case "a_profilo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_profilo_cod"
		ls_dwc[2] = "a_profilo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_profilo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_profilo_cod"
		ls_dwc[2] = "a_profilo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE

end event

