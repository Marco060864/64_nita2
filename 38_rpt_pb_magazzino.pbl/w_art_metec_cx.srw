forward
global type w_art_metec_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_art_metec_cx
end type
type cb_ok from commandbutton within w_art_metec_cx
end type
type dw_1 from u_dw_ext_main within w_art_metec_cx
end type
end forward

global type w_art_metec_cx from w_wiz_main
int Width=3035
int Height=884
boolean TitleBar=true
string Title="Stampa elenco articoli"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_art_metec_cx w_art_metec_cx

on w_art_metec_cx.create
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

on w_art_metec_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.insertrow(1)

String ls_da_articolo, ls_a_articolo, ls_da_articolo_des, ls_a_articolo_des

datawindowchild ldw_listino, ldw_listino_des


dw_1.getchild("listino",ldw_listino)
dw_1.getchild("listino_des",ldw_listino_des)


dw_1.accepttext()

	
ldw_listino.settransobject(sqlca)
ldw_listino.retrieve()
	
ldw_listino_des.settransobject(sqlca)
ldw_listino_des.retrieve()
	
SELECT MIN(codice)
INTO	 :ls_da_articolo
FROM	 articolo
;

If SQLCA.SQLCODE = 0 Then
	dw_1.SetItem(1, "da_articolo", ls_da_articolo)
	
	SELECT descrizione 
	INTO	 :ls_da_articolo_des
	FROM	 articolo
	WHERE	 codice = :ls_da_articolo
	;
	dw_1.SetItem(1, "da_des_articolo", ls_da_articolo_des)	
End If

SELECT MAX(codice)
INTO	 :ls_a_articolo
FROM	 articolo;

If SQLCA.SQLCODE = 0 Then
	dw_1.SetItem(1, "a_articolo", ls_a_articolo)
	
	SELECT descrizione 
	INTO	 :ls_a_articolo_des
	FROM	 articolo
	WHERE	 codice = :ls_a_articolo
	;
	dw_1.SetItem(1, "a_des_articolo", ls_a_articolo_des)		
End If
end event

type cb_annulla from commandbutton within w_art_metec_cx
int X=2738
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

type cb_ok from commandbutton within w_art_metec_cx
int X=2395
int Y=32
int Width=242
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Stam&pa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_da_articolo, ls_a_articolo, ls_variazione
String	ls_listino
Long		ll_id_variazione
String	ls_art_listino, ls_des_estesa

str_anag_art str_param

dw_1.accepttext()

ls_da_articolo= dw_1.GetItemString(1, "da_articolo")
ls_a_articolo = dw_1.GetItemString(1, "a_articolo")

ls_listino=dw_1.GetItemstring(1,"listino")
ll_id_variazione = dw_1.GetItemNumber(1, "variazione")

SELECT CAST((DATEFORMAT(Data_inizio, 'dd/mm/yyyy') + ' - ' + DATEFORMAT(Data_fine, 'dd/mm/yyyy')) AS CHAR(40))
INTO	 :ls_variazione
FROM	 variazione
WHERE	 id_variazione = :ll_id_variazione
;

if isnull(ll_id_variazione) then
	messagebox("Stampa elenco articoli","La selezione del listino è obbligatoria")
	return
End If

if isnull(ls_da_articolo) or isnull(ls_a_articolo) then
	messagebox("Stampa elenco articoli","Gli articoli di inizio e fine sono obbligatori")
	return
End If
		
if ls_da_articolo > ls_a_articolo then
	messagebox("Stampa elenco articoli","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If

str_param.id_variazione=ll_id_variazione

str_param.da_art=ls_da_articolo
str_param.a_art=ls_a_articolo

OpenWithParm(w_lista_art_metec_rpt,str_param)				
end event

type dw_1 from u_dw_ext_main within w_art_metec_cx
int X=32
int Y=128
int Width=2935
int Height=596
int TabOrder=10
string DataObject="d_art_metec"
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
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
            uf_set_colval("a_articolo",is_ricpar.s_main_value)	
            uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])
	      end if  
	case "da_des_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
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
Long		ll_id_listino
String 	ls_listino, ls_raggruppamento

DataWindowChild ldw_id_parte_regola, ldw_id_parte_regola_des
dw_1.GetChild("id_parte_regola", ldw_id_parte_regola)
dw_1.GetChild("id_parte_regola_des", ldw_id_parte_regola_des)
			
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
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
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
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo") ='' then
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
	CASE "listino", "listino_des"
		If Not IsNull(Data) Then
			ls_listino = data
			
			SELECT id_listino
			INTO	 :ll_id_listino
			FROM	 listino
			WHERE	 codice = :ls_listino;

			If SQLCA.SQLCODE = 0 Then			
				
				datawindowchild ldw_variazione
				dw_1.getchild("variazione", ldw_variazione)
				ldw_variazione.settransobject(sqlca)				
				ldw_variazione.retrieve(ll_id_listino)
				
				
				Long ll_id_variazione
				
				DECLARE c_variazione CURSOR FOR 
					SELECT id_variazione
					FROM	 variazione
					WHERE	 id_listino = :ll_id_listino
					AND	 data_inizio <= today(*)
					AND	 (data_fine >= today(*) OR data_fine IS NULL)
					;
					
			   OPEN c_variazione;
					FETCH NEXT c_variazione INTO :ll_id_variazione;
				CLOSE c_variazione;
				
				dw_1.SetItem(1, "variazione", ll_id_variazione)
			End If			
		Else
			String ls_null
			
			SetNull(ls_null)
			dw_1.SetItem(1, "id_variazione", '')
			dw_1.SetItem(1, "variazione", '')
			dw_1.SetItem(1, "art_listino", '')
			dw_1.SetItem(1, "art_prezzo", '')			
		End If
END CHOOSE

end event

