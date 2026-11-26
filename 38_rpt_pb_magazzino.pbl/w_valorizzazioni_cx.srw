forward
global type w_valorizzazioni_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_valorizzazioni_cx
end type
type cb_ok from commandbutton within w_valorizzazioni_cx
end type
type dw_1 from u_dw_ext_main within w_valorizzazioni_cx
end type
end forward

global type w_valorizzazioni_cx from w_wiz_main
int Width=3035
int Height=1220
boolean TitleBar=true
string Title="Valorizzazioni di magazzino"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_valorizzazioni_cx w_valorizzazioni_cx

on w_valorizzazioni_cx.create
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

on w_valorizzazioni_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.insertrow(1)

Long ll_id_esercizio
Long	ll_id_valuta	

Datawindowchild ldw_id_esercizio, ldw_periodo_esercizio
Datawindowchild ldw_da_mag, ldw_da_mag_des, ldw_a_mag, ldw_a_mag_des
Datawindowchild ldw_id_valuta, ldw_id_valuta_des	

dw_1.GetChild("id_esercizio", ldw_id_esercizio)
dw_1.GetChild("periodo_esercizio", ldw_periodo_esercizio)
dw_1.GetChild("da_magazzino", ldw_da_mag)
dw_1.GetChild("a_magazzino", ldw_a_mag)
dw_1.GetChild("da_mag_des", ldw_da_mag_des)
dw_1.GetChild("a_mag_des", ldw_a_mag_des)
dw_1.GetChild("id_valuta", ldw_id_valuta)
dw_1.GetChild("id_valuta_des", ldw_id_valuta_des)

ldw_id_valuta.SetTransObject(SQLCA)
ldw_id_valuta.Retrieve()

ldw_id_valuta_des.SetTransObject(SQLCA)
ldw_id_valuta_des.Retrieve()

ldw_id_esercizio.SetTransObject(SQLCA)
ldw_id_esercizio.Retrieve()

ldw_periodo_esercizio.SetTransObject(SQLCA)
ldw_periodo_esercizio.Retrieve()

ldw_da_mag.SetTransObject(SQLCA)
ldw_da_mag.Retrieve()

ldw_a_mag.SetTransObject(SQLCA)
ldw_a_mag.Retrieve()

ldw_da_mag_des.SetTransObject(SQLCA)
ldw_da_mag_des.Retrieve()

ldw_a_mag_des.SetTransObject(SQLCA)
ldw_a_mag_des.Retrieve()


SELECT id_esercizio_proposto, esercizio.id_valuta
INTO	 :ll_id_esercizio, :ll_id_valuta
FROM	 azienda, esercizio
WHERE	 azienda.id_azienda = 1
AND	 esercizio.id_esercizio = azienda.id_esercizio
;

If SQLCA.SQLCODE = -1 Then
	Messagebox("Stampa valorizzazioni di magazzino", SQLCA.SQLERRTEXT)
End If

dw_1.Object.id_esercizio[1] = ll_id_esercizio
dw_1.Object.id_valuta[1] = ll_id_valuta	
dw_1.Object.data_val[1] = today()

end event

type cb_annulla from commandbutton within w_valorizzazioni_cx
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

type cb_ok from commandbutton within w_valorizzazioni_cx
int X=2405
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

event clicked;String 	ls_filtro, ls_parametri, ls_tipo_val, ls_solo_totale
String	ls_da_articolo, ls_a_articolo, ls_raggruppa, ls_da_magazzino, ls_a_magazzino
Date	   ld_data_val, ld_data_inizio
Long		ll_id_esercizio, ll_row, ll_i, ll_id_attivita
Long		ll_id_valuta		

s_rpt_mag s_param

dw_1.accepttext()

ll_id_esercizio = dw_1.Object.id_esercizio[1]
ld_data_val = dw_1.Object.data_val[1]

ls_da_articolo= dw_1.Object.da_articolo[1]
ls_a_articolo = dw_1.Object.a_articolo[1]

ls_raggruppa=dw_1.Object.raggruppa[1]
ls_tipo_val = dw_1.Object.tipo_val[1]
ls_solo_totale = dw_1.Object.solo_totale[1]

ll_id_valuta = dw_1.Object.id_valuta[1]	

If ls_raggruppa = 'S' Then
	ls_da_magazzino=dw_1.Object.da_magazzino[1]
	ls_a_magazzino=dw_1.Object.a_magazzino[1]
End If

if isnull(ll_id_esercizio) Then
	messagebox("Stampa Valorizzazioni di Magazzino","Specificare l'Esercizio")
	return
End If

if isnull(ll_id_valuta) Then
	messagebox("Stampa Valorizzazioni di Magazzino","Specificare la Valuta")
	return
End If

if isnull(ld_data_val) Then
	messagebox("Stampa Valorizzazioni di Magazzino","Specificare la data della valorizzazione")
	return
End If

if ls_da_articolo > ls_a_articolo then
	messagebox("Stampa Valorizzazioni di Magazzino","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If

If ls_raggruppa = 'S' and ls_da_magazzino > ls_a_magazzino then
	messagebox("Stampa Valorizzazioni di Magazzino","Il codice del magazzino iniziale è maggiore di quello finale",exclamation!)
	Return
End If

	
string	ls_des_valuta	

SELECT descrizione
INTO	 :ls_des_valuta
FROM	 valuta
WHERE  id_valuta = :ll_id_valuta
;

ls_parametri = ' Valorizzazione in ' + ls_des_valuta + ' al ' + String(ld_data_val)

If ls_raggruppa = 'S' then
	
	if ls_da_magazzino <> '' and ls_filtro = '' Then
		IF ls_tipo_val = 'L' then   
			ls_filtro=" AND magazzino.codice >= "+"'"+string(ls_da_magazzino)+"'"   
		else	
			ls_filtro=" magazzino.codice >= "+"'"+string(ls_da_magazzino)+"'"
		end if
		ls_parametri=ls_parametri+' Da Magazzino:'+ls_da_magazzino
	elseif ls_da_magazzino <> '' and ls_filtro <> '' Then
		ls_filtro=ls_filtro + " AND magazzino.codice >= "+"'"+string(ls_da_magazzino)+"'"
		ls_parametri=ls_parametri+' Da Magazzino:'+ls_da_magazzino
	end if
	
	
	if ls_a_magazzino<>''and ls_filtro='' then
		IF ls_tipo_val = 'L' then  
			ls_filtro=" AND magazzino.codice <= "+"'"+string(ls_a_magazzino)+"'"   
		else
			ls_filtro=" magazzino.codice <= "+"'"+string(ls_a_magazzino)+"'"
		end if
		ls_parametri=ls_parametri+' A Magazzino:'+ls_a_magazzino
	elseif ls_a_magazzino<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" AND magazzino.codice <= "+"'"+string(ls_a_magazzino)+"'"
		ls_parametri=ls_parametri+' A Magazzino:'+ls_a_magazzino
	end if	
End If

	
if ls_da_articolo <> '' and ls_filtro = '' Then
	IF ls_tipo_val = 'L' then  
		ls_filtro=" AND articolo.codice >= "+"'"+string(ls_da_articolo)+"'"   
	ELSE
		ls_filtro=" articolo.codice >= "+"'"+string(ls_da_articolo)+"'"
	END IF
	ls_parametri=ls_parametri+' Da Articolo:'+ls_da_articolo
elseif ls_da_articolo <> '' and ls_filtro <> '' Then
	ls_filtro=ls_filtro + " AND articolo.codice >= "+"'"+string(ls_da_articolo)+"'"
	ls_parametri=ls_parametri+' Da Articolo:'+ls_da_articolo
end if
	
if ls_a_articolo<>''and ls_filtro='' then
	IF ls_tipo_val = 'L' then  
		ls_filtro=" AND articolo.codice <= "+"'"+string(ls_a_articolo)+"'" 
	ELSE
		ls_filtro=" articolo.codice <= "+"'"+string(ls_a_articolo)+"'"
	END IF
	ls_parametri=ls_parametri+' A Articolo:'+ls_a_articolo
elseif ls_a_articolo<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND articolo.codice <= "+"'"+string(ls_a_articolo)+"'"
	ls_parametri=ls_parametri+' A Articolo:'+ls_a_articolo
end if

SELECT Date(data_inizio - 1)
INTO	 :ld_data_inizio
FROM	 esercizio
WHERE	 id_esercizio = :ll_id_esercizio
;

If SQLCA.SQLCODE = -1 Then
	Messagebox("Stampa Valorizzazioni di magazzino", SQLCA.SQLERRTEXT)
	Return 
End If
s_param.filtro 	= ls_filtro
s_param.parametri = ls_parametri
s_param.da_data 	= ld_data_inizio
s_param.a_data 	= ld_data_val
s_param.id_valuta = ll_id_valuta 

If ls_raggruppa = 'S' then
	s_param.flag = 'M'
Else
	s_param.flag = 'A'	
End If


If ls_tipo_val = 'L' then
	
	SELECT id_attivita
	INTO	 :ll_id_attivita
	FROM	 azienda
	WHERE	 id_azienda = 1
	;
	
	If SQLCA.SQLCODE = -1 then
		messagebox("", SQLCA.SQLERRTEXT)
	end if
	
end if


If ls_solo_totale = 'S' and ls_tipo_val = 'L' then
	SQLCA.sp_valorizzazioni(ll_id_attivita , ls_da_articolo , ls_a_articolo , 0, YEAR(ld_data_val), MONTH(ld_data_val))	
	OpenWithParm(w_vallifo_tot_rpt, s_param)
	Return
End if

If ls_solo_totale = 'S' and ls_tipo_val = 'M' then
	OpenWithParm(w_valcm_tot_rpt, s_param)
	Return
End if

If ls_solo_totale = 'S' and ls_tipo_val = 'U' then
	OpenWithParm(w_valuc_tot_rpt, s_param)
	Return
End if

If ls_raggruppa = 'N' Then
	CHOOSE CASE ls_tipo_val
		CASE 'M'
			OpenWithParm(w_valcm_rpt, s_param)
		CASE 'U'
			OpenWithParm(w_valuc_rpt, s_param)
		CASE 'L'
			SQLCA.sp_valorizzazioni(ll_id_attivita , ls_da_articolo , ls_a_articolo , 0, YEAR(ld_data_val), MONTH(ld_data_val))
	END CHOOSE
Else
	CHOOSE CASE ls_tipo_val
		CASE 'M'
			OpenWithParm(w_valcm_mag_rpt, s_param)
		CASE 'U'
			OpenWithParm(w_valuc_mag_rpt, s_param)
		CASE 'L'
			SQLCA.sp_valorizzazioni(ll_id_attivita , ls_da_articolo , ls_a_articolo , 1, YEAR(ld_data_val), MONTH(ld_data_val))			
	END CHOOSE	
End If 

If ls_tipo_val = 'L' then
	OpenWithParm(w_vallifo_rpt, s_param)
End if



end event

type dw_1 from u_dw_ext_main within w_valorizzazioni_cx
int X=32
int Y=128
int Width=2935
int Height=964
int TabOrder=2
string DataObject="d_valorizzazioni_ext"
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
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
	CASE "a_articolo_des"
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

