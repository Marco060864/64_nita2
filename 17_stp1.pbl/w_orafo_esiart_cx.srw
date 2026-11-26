forward
global type w_orafo_esiart_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_orafo_esiart_cx
end type
type cb_ok from commandbutton within w_orafo_esiart_cx
end type
type dw_1 from u_dw_ext_main within w_orafo_esiart_cx
end type
end forward

global type w_orafo_esiart_cx from w_wiz_main
int Width=2779
int Height=1384
boolean TitleBar=true
string Title="Stampa elenco articoli"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_orafo_esiart_cx w_orafo_esiart_cx

type variables
string flag_date
end variables

on w_orafo_esiart_cx.create
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

on w_orafo_esiart_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;
dw_1.insertrow(1)

String 	ls_da_articolo, ls_a_articolo, ls_da_articolo_des, ls_a_articolo_des
Long	 	ll_id_esercizio
Integer	li_anno, li_mese

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

If SQLCA.SQLCODE = -1 Then
	MessageBox("Stampa Esistenza", SQLCA.SQLERRTEXT)
End If

dw_1.Object.esercizio[1] = ll_id_esercizio

dw_1.Object.mese[1] = Month(today())
dw_1.Object.anno[1] = Year(today())

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
	dw_1.setitem(1,"totali",'N')
End If
end event

type cb_annulla from commandbutton within w_orafo_esiart_cx
int X=2487
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

type cb_ok from commandbutton within w_orafo_esiart_cx
int X=2144
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
String	ls_da_articolo, ls_a_articolo, ls_da_prod, ls_a_prod
String	ls_da_mag, ls_a_mag
String	ls_totali, ls_raggruppa
Long		ll_anno,ll_mese,ll_id_esercizio

str_esi_art1 str_param

dw_1.accepttext()

ls_da_articolo= dw_1.GetItemString(1, "da_articolo")
ls_a_articolo = dw_1.GetItemString(1, "a_articolo")

ls_da_prod=dw_1.getitemstring(1,"da_produttore")
ls_a_prod=dw_1.getitemstring(1,"a_produttore")

ls_da_mag=dw_1.getitemstring(1,"da_magazzino")
ls_a_mag=dw_1.getitemstring(1,"a_magazzino")

ll_anno=dw_1.getitemnumber(1,"anno")
ll_mese=dw_1.getitemnumber(1,"mese")
ll_id_esercizio=dw_1.getitemnumber(1,"esercizio")

ls_totali=dw_1.GetItemstring(1,"totali")
ls_raggruppa = dw_1.GetItemstring(1, "raggruppa")

if flag_date='S' then
	messagebox("Esistenza articoli","Il mese e l'anno specificati non rientrano nell'esercizio selezionato")
	Return
End If

If ls_totali='N'then
	if isnull(ll_id_esercizio)then
		messagebox("Esistenza Articoli","l'Esercizio è obbligatorio")
		return
	end if
		
	If (not(IsNull(ls_da_articolo))) and (not(IsNull(ls_a_articolo))) and (ls_da_articolo > ls_a_articolo) then
		Messagebox("Esistenza articoli","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
		Return
	End If
		
	If (not(IsNull(ls_da_prod))) and (not(IsNull(ls_a_prod))) and (ls_da_prod > ls_a_prod) then
		messagebox("Esistenza articoli","Il produttore iniziale è maggiore di quello finale",exclamation!)
		Return
	End If
		
	if (not(isnull(ls_da_mag))) and (not(isnull(ls_a_mag))) and (ls_da_mag > ls_a_mag) then
		messagebox("Esistenza articoli","Il codice del magazzino iniziale è maggiore di quello finale",exclamation!)
		Return
	End If
end if
	

str_param.anno=ll_anno
str_param.mese=ll_mese
str_param.id_esercizio=ll_id_esercizio

If ls_totali = 'N' Then
	
	if ls_da_articolo <> '' and ls_filtro = '' Then
		ls_filtro="articolo.codice >= "+"'"+string(ls_da_articolo)+"'"
		ls_parametri=ls_parametri+' Da Articolo:'+ls_da_articolo
	elseif ls_da_articolo <> '' and ls_filtro <> '' Then
		ls_filtro=ls_filtro + " AND articolo.codice >= "+"'"+string(ls_da_articolo)+"'"
		ls_parametri=ls_parametri+' Da Articolo:'+ls_da_articolo
	end if
	
	
	if ls_a_articolo <> '' and ls_filtro = '' Then
		ls_filtro="articolo.codice <= "+"'"+string(ls_a_articolo)+"'"
		ls_parametri=ls_parametri+' A Articolo:'+ls_a_articolo
	elseif ls_a_articolo <> '' and ls_filtro <> '' Then
		ls_filtro=ls_filtro + " AND articolo.codice <= "+"'"+string(ls_a_articolo)+"'"
		ls_parametri=ls_parametri+' A Articolo:'+ls_a_articolo
	end if
	
	
	if ls_da_prod <> '' and ls_filtro = '' Then
		ls_filtro="anagrafica.rag_soc_1 >= "+"'"+string(ls_da_prod)+"'"
		ls_parametri=ls_parametri+' Da Produttore:'+ls_da_prod
	elseif ls_da_prod <> '' and ls_filtro <> '' Then
		ls_filtro=ls_filtro + " AND anagrafica.rag_soc_1 >= "+"'"+string(ls_da_prod)+"'"
		ls_parametri=ls_parametri+' Da Produttore:'+ls_da_prod
	end if
	
	
	if ls_a_prod <> '' and ls_filtro = '' Then
		ls_filtro="anagrafica.rag_soc_1 <= "+"'"+string(ls_a_prod)+"'"
		ls_parametri=ls_parametri+' A Produttore:'+ls_a_prod
	elseif ls_a_prod <> '' and ls_filtro <> '' Then
		ls_filtro=ls_filtro + " AND anagrafica.rag_soc_1 <= "+"'"+string(ls_a_prod)+"'"
		ls_parametri=ls_parametri+' A Produttore:'+ls_a_prod
	end if
	
	
	if ls_raggruppa='S' then
		if ls_da_mag <> '' and ls_filtro = '' Then
			ls_filtro="magazzino.codice >= "+"'"+string(ls_da_mag)+"'"
			ls_parametri=ls_parametri+' Da Magazzino:'+ls_da_mag
		elseif ls_da_mag <> '' and ls_filtro <> '' Then
			ls_filtro=ls_filtro + " AND magazzino.codice >= "+"'"+string(ls_da_mag)+"'"
			ls_parametri=ls_parametri+' Da Magazzino:'+ls_da_mag
		end if
	End If
	
	
	if ls_raggruppa='S' then
		if ls_a_mag <> '' and ls_filtro = '' Then
			ls_filtro="magazzino.codice >= "+"'"+string(ls_a_mag)+"'"
			ls_parametri=ls_parametri+' A Magazzino:'+ls_a_mag
		elseif ls_a_mag <> '' and ls_filtro <> '' Then
			ls_filtro=ls_filtro + " AND magazzino.codice <= "+"'"+string(ls_a_mag)+"'"
			ls_parametri=ls_parametri+' A Magazzino:'+ls_a_mag
		end if
	End If
End If	

str_param.filtro=ls_filtro
str_param.parametri=ls_parametri

if ls_totali='S'then
	OpenWithParm(w_esitot_rpt, str_param)
else
	If ls_raggruppa = 'N' Then
		OpenWithParm(w_esiart_rpt, str_param)

	ElseIf ls_raggruppa = 'S' Then
		OpenWithParm(w_esiartmag_rpt, str_param)	
	End If
end if

end event

type dw_1 from u_dw_ext_main within w_orafo_esiart_cx
int X=32
int Y=128
int Width=2683
int Height=1132
int TabOrder=2
string DataObject="d_orafo_esiart_ext"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
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
	CASE "da_produttore"
		is_search_window = "w_anagrafica_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1"
		
	CASE "a_produttore"
		is_search_window = "w_anagrafica_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1"
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo_des",is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
				uf_set_colval("a_articolo",is_ricpar.s_main_value)
				uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])
			end if	
	CASE "da_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
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
	CASE "da_produttore"
		uf_set_colval ( "da_produttore",	 	is_ricpar.s_main_value )
		if isnull(this.getitemstring(1,'a_produttore')) or this.getitemstring(1,'a_produttore')='' then
			uf_set_colval ( "a_produttore",is_ricpar.s_main_value )
		end if	
	CASE "a_produttore"
		uf_set_colval ( "a_produttore",is_ricpar.s_main_value )
end choose
end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
Long		ll_id_listino,ll_mese,ll_anno,ll_id_esercizio
String 	ls_listino,ls_raggruppa,ls_appoggio,ls_data,ls_codice
date   	ld_data,ld_data_i,ld_data_f			



this.accepttext()
ll_anno = this.getitemnumber(row,"anno")
ll_mese = this.getitemnumber(row,"mese")



ls_raggruppa=this.getitemstring(1,"raggruppa")

ll_id_esercizio=this.getitemnumber(row,"esercizio")
		select esercizio.codice,esercizio.data_inizio,esercizio.data_fine
		into :ls_codice,:ld_data_i,:ld_data_f
		from esercizio
		where esercizio.id_esercizio=:ll_id_esercizio;
		
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
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
            This.SetItem(1, "a_articolo", Data)			
            This.SetItem(1, "a_articolo_des", ls_dbv[2])
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
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
            This.SetItem(1, "a_articolo_des", Data)			
            This.SetItem(1, "a_articolo", ls_dbv[1])
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
	CASE "da_produttore"
		ls_sql_cond = ""
		
		ls_dbc[1] = "rag_soc_1"
		
		
		ls_dwc[1] = "da_produttore"
		
		
		li_ok = uf_autofind_col(dwo.Name, "anagrafica", "rag_soc_1", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(this.getitemstring(1,'a_produttore')) or this.getitemstring(1,'a_produttore')='' then
            This.SetItem(1, "a_produttore", Data)
			end if	
			RETURN 2
		END IF	
		
	case "mese"
		if not isnull(ll_anno) then
			ls_appoggio = string(ll_anno)			
			if len ( ls_appoggio ) < 4 then ls_appoggio = left ( string(year(today())), 4 - len(ls_appoggio) ) + ls_appoggio
			ls_data = "01/"+string(data)+"/"+ls_appoggio
			ld_data = date(ls_data)
			end if
		if not isnull(ll_anno)and not isnull(ll_mese)and not(ld_data>=ld_data_i and ld_data<=ld_data_f) then 
	messagebox("Attenzione","Il mese e l'anno specificato non rientrano nel periodo compreso dall'esercizio")
flag_date='S'
else
	flag_date='N'
end if
			
	case "anno"
		if not isnull(ll_mese) then
			ls_appoggio = data			
			if len ( ls_appoggio ) < 4 then ls_appoggio = left ( string(year(today())), 4 - len(ls_appoggio) ) + ls_appoggio
			ls_data = "01/"+string(ll_mese)+"/"+ls_appoggio
			ld_data = date(ls_data)
		end if
if not isnull(ll_anno)and not isnull(ll_mese)and not(ld_data>=ld_data_i and ld_data<=ld_data_f) then 
	messagebox("Attenzione","Il mese e l'anno specificato non rientrano nel periodo compreso dall'esercizio")
flag_date='S'
else
	flag_date='N'
end if
		
	CASE "a_produttore"
		ls_sql_cond = ""
		
		ls_dbc[1] = "rag_soc_1"
		
		
		ls_dwc[1] = "a_produttore"
		
		
		li_ok = uf_autofind_col(dwo.Name, "anagrafica", "rag_soc_1", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF	
	CASE "totali"
		if data='S' then
		this.object.da_articolo_t.visible=0
		this.object.da_articolo.visible=0
		this.object.da_articolo_sw.visible=0
		this.object.da_articolo_des.visible=0
		this.object.da_articolo_des_sw.visible=0
		this.object.a_articolo_t.visible=0
		this.object.a_articolo.visible=0
		this.object.a_articolo_sw.visible=0
		this.object.a_articolo_des.visible=0
		this.object.a_articolo_des_sw.visible=0
		this.object.da_produttore_t.visible=0
		this.object.da_produttore.visible=0
		this.object.da_produttore_sw.visible=0
		this.object.a_produttore_t.visible=0
		this.object.a_produttore.visible=0
		this.object.a_produttore_sw.visible=0
		this.object.raggruppa.visible=0
		this.object.raggruppa_t.visible=0
		this.object.da_magazzino_t.visible=0
		this.object.da_magazzino.visible=0
		this.object.da_magazzino_des.visible=0
		this.object.a_magazzino_t.visible=0
		this.object.a_magazzino.visible=0
		this.object.a_magazzino_des.visible=0
		
		
		
	else
		this.object.da_articolo_t.visible=1
		this.object.da_articolo.visible=1
		this.object.da_articolo_sw.visible=1
		this.object.da_articolo_des.visible=1
		this.object.da_articolo_des_sw.visible=1
		this.object.a_articolo_t.visible=1
		this.object.a_articolo.visible=1
		this.object.a_articolo_sw.visible=1
		this.object.a_articolo_des.visible=1
		this.object.a_articolo_des_sw.visible=1
		this.object.da_produttore_t.visible=1
		this.object.da_produttore.visible=1
		this.object.da_produttore_sw.visible=1
		this.object.a_produttore_t.visible=1
		this.object.a_produttore.visible=1
		this.object.a_produttore_sw.visible=1
		this.object.raggruppa.visible=1
		this.object.raggruppa_t.visible=1
		if ls_raggruppa='S'then
		this.object.da_magazzino_t.visible=1
		this.object.da_magazzino.visible=1
		this.object.da_magazzino_des.visible=1
		this.object.a_magazzino_t.visible=1
		this.object.a_magazzino.visible=1
		this.object.a_magazzino_des.visible=1
	end if
		
	end if
CASE "raggruppa"
	if data='N'then
		this.object.da_magazzino_t.visible=0
		this.object.da_magazzino.visible=0
		this.object.da_magazzino_des.visible=0
		this.object.a_magazzino_t.visible=0
		this.object.a_magazzino.visible=0
		this.object.a_magazzino_des.visible=0
	else
		this.object.da_magazzino_t.visible=1
		this.object.da_magazzino.visible=1
		this.object.da_magazzino_des.visible=1
		this.object.a_magazzino_t.visible=1
		this.object.a_magazzino.visible=1
		this.object.a_magazzino_des.visible=1
	end if	
		
	
		
		
		
		
END CHOOSE

end event

