forward
global type w_esi_art_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_esi_art_cx
end type
type cb_ok from commandbutton within w_esi_art_cx
end type
type dw_1 from u_dw_ext_main within w_esi_art_cx
end type
end forward

global type w_esi_art_cx from w_wiz_main
int X=46
int Y=468
int Width=2848
int Height=1196
boolean TitleBar=true
string Title="Stampa esistenza articoli"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_esi_art_cx w_esi_art_cx

type variables
integer ii_par
end variables

on w_esi_art_cx.create
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

on w_esi_art_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;	ii_par=message.doubleparm
	if ii_par = 1 then
		
		
	else
		
		
	end if
dw_1.insertrow(1)

String ls_da_articolo, ls_a_articolo, ls_da_articolo_des, ls_a_articolo_des
Long	 ll_id_esercizio

datawindowchild ldw_esercizio
datawindowchild ldw_da_mag, ldw_da_mag_des, ldw_a_mag, ldw_a_mag_des

dw_1.GetChild("esercizio", ldw_esercizio)
dw_1.GetChild("da_magazzino", ldw_da_mag)
dw_1.GetChild("da_magazzino_des", ldw_da_mag_des)

dw_1.GetChild("a_magazzino", ldw_a_mag)
dw_1.GetChild("a_magazzino_des", ldw_a_mag_des)

dw_1.accepttext()

ldw_esercizio.SetTransObject(sqlca)
ldw_esercizio.Retrieve()

ldw_da_mag.settransobject(sqlca)
ldw_da_mag.retrieve()

ldw_da_mag_des.settransobject(sqlca)
ldw_da_mag_des.retrieve()
	
ldw_a_mag.settransobject(sqlca)
ldw_a_mag.retrieve()

ldw_a_mag_des.settransobject(sqlca)
ldw_a_mag_des.retrieve()


SELECT id_esercizio_proposto
INTO	 :ll_id_esercizio
FROM	 azienda
WHERE	 id_azienda = 1
;

If SQLCA.SQLCODE = 0 Then
	dw_1.SetItem(1, "esercizio", ll_id_esercizio)
End If

dw_1.SetItem(1, "mese", Month(today()))
dw_1.SetItem(1, "anno", Year(today()))

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
	dw_1.SetItem(1, "da_articolo_des", ls_da_articolo_des)	
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
	dw_1.SetItem(1, "a_articolo_des", ls_a_articolo_des)		
End If
end event

type cb_annulla from commandbutton within w_esi_art_cx
int X=2551
int Y=24
int Width=229
int Height=88
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

type cb_ok from commandbutton within w_esi_art_cx
int X=2208
int Y=24
int Width=242
int Height=88
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
String	ls_da_articolo, ls_a_articolo, ls_raggruppa, ls_da_mag, ls_a_mag
Long	   ll_id_esercizio, ll_id_sog_com
Integer	li_anno, li_mese
char ls_esineg, ls_util

str_esi_art str_param

dw_1.accepttext()

ll_id_esercizio=dw_1.GetItemNumber(1,"esercizio")
li_anno=dw_1.GetItemNumber(1, "anno")
li_mese=dw_1.GetItemNumber(1, "mese")

ls_da_articolo= dw_1.GetItemString(1, "da_articolo")
ls_a_articolo = dw_1.GetItemString(1, "a_articolo")

ls_raggruppa=dw_1.GetItemString(1,"raggruppa")

ls_da_mag=dw_1.GetItemString(1,"da_magazzino")
ls_a_mag=dw_1.GetItemString(1,"a_magazzino")

ls_esineg=dw_1.GetItemString(1,"esineg") 
ls_util=dw_1.GetItemString(1,"utilizzabile") 

ll_id_sog_com=dw_1.GetItemnumber(1,"id_sog_commerciale")

if (isnull(ls_da_articolo) or isnull(ls_a_articolo)) then
	messagebox("Stampa esistenza articoli","Gli articoli di inizio e fine sono obbligatori")
	return
End If
	
if ls_da_articolo > ls_a_articolo then
	messagebox("Stampa esistenza articoli","Il codice dell'articolo iniziale è maggiore di quello finale")
	Return
End If

If ls_raggruppa = 'S' Then
	if IsNull(ls_da_mag) or IsNull(ls_a_mag) then
		Messagebox("Stampa esistenza articoli","I Magazzini di inizio e fine sono obbligatori")
		Return
	End If
	if ls_da_mag > ls_a_mag then
		messagebox("Stampa esistenza articoli","Il codice del magazzino iniziale è maggiore di quello finale")
		Return
	End If
End If

	

ls_parametri=ls_parametri+'Da Articolo:' + ls_da_Articolo + ' A Articolo:' + ls_a_articolo

str_param.da_articolo=ls_da_articolo
str_param.a_articolo=ls_a_articolo
str_param.id_esercizio=ll_id_esercizio
str_param.anno=li_anno
str_param.mese=li_mese
str_param.parametri=ls_parametri
str_param.filtro=ls_filtro
str_param.id_soggetto_commerciale=ll_id_sog_com
str_param.utilizzabile=ls_util 

If ls_raggruppa = 'S' Then
	str_param.da_magazzino=ls_da_mag
	str_param.a_magazzino=ls_a_mag
	
	
	if ls_esineg = 'N' then
		OpenWithParm(w_esi_art_mag_rpt, str_param)
	else
		OpenWithParm(w_esineg_art_mag_rpt, str_param)
	end if
	
Else	
	
	
	if ls_esineg = 'N' then	
		OpenWithParm(w_esi_art_rpt, str_param)
	else
		OpenWithParm(w_esineg_art_rpt, str_param)		
	end if
	
End If

end event

type dw_1 from u_dw_ext_main within w_esi_art_cx
int X=23
int Y=128
int Width=2752
int Height=924
int TabOrder=2
string DataObject="d_esi_art_ext"
end type

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "da_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	CASE "a_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "a_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"	
	CASE "sog_com_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
	CASE "sog_com_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"			
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
END CHOOSE

end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo_des",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
           uf_set_colval("a_articolo",is_ricpar.s_main_value)			
           uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])			
	      end if
	CASE "da_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
           uf_set_colval("a_articolo_des",is_ricpar.s_main_value)			
           uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])			
	      end if
	CASE "a_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])	
	CASE "a_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo",is_ricpar.s_ausil_value[1])
			
	CASE "sog_com_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_com_cod", is_ricpar.s_ausil_value[1])
				
	case "sog_com_rag"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale",is_ricpar.s_id_seg_value[1])
			uf_set_colval("sog_com_rag", is_ricpar.s_ausil_value[1])			
END CHOOSE 
end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
Long		ll_id_listino
String 	ls_listino
Date 	 ld_data_fine
			

CHOOSE CASE dwo.name
	CASE "da_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
          This.SetItem(1, "a_articolo", Data)			
          This.SetItem(1, "a_articolo_des", This.GetItemString(1, "da_articolo_des"))			
	      end if
			RETURN 2
		END IF
		
		
	CASE "da_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_articolo")) or This.GetItemString(1, "a_articolo")='' then
          This.SetItem(1, "a_articolo_des", Data)			
          This.SetItem(1, "a_articolo", This.GetItemString(1, "da_articolo"))			
	      end if
			RETURN 2
		END IF

	CASE "a_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		

	CASE "esercizio"
		SELECT Date(data_fine)
		INTO	 :ld_data_fine
		FROM	 esercizio
		WHERE  id_esercizio = :Data
		;
		If SQLCA.SQLCODE = 0 Then
			This.SetItem(1, "mese", month (ld_data_fine))
			This.SetItem(1, "anno", year (ld_data_fine))
		End If
	
	
		CASE "sog_com_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"		
		
		ls_dwc[1] = "sog_com_cod"
		ls_dwc[2] = "sog_com_rag"
		ls_dwc[3] = "id_sog_commerciale"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
	
	case "sog_com_rag"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"				
		
		ls_dwc[1] = "sog_com_cod"
		ls_dwc[2] = "sog_com_rag"
		ls_dwc[3] = "id_sog_commerciale"		
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
END CHOOSE

end event

