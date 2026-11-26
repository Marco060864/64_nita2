forward
global type w_st_lista_articoli_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_st_lista_articoli_cx
end type
type cb_ok from commandbutton within w_st_lista_articoli_cx
end type
type dw_1 from u_dw_ext_main within w_st_lista_articoli_cx
end type
end forward

global type w_st_lista_articoli_cx from w_wiz_main
int Width=3035
int Height=1800
boolean TitleBar=true
string Title="Stampa elenco articoli"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_st_lista_articoli_cx w_st_lista_articoli_cx

on w_st_lista_articoli_cx.create
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

on w_st_lista_articoli_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.insertrow(1)

String ls_da_articolo, ls_a_articolo, ls_da_articolo_des, ls_a_articolo_des

datawindowchild ldw_da_cat_comm, ldw_da_cat_comm_des, ldw_a_cat_comm, ldw_a_cat_comm_des, ldw_listino, ldw_listino_des
datawindowchild ldw_da_cat_merc, ldw_da_cat_merc_des, ldw_a_cat_merc, ldw_a_cat_merc_des
datawindowchild ldw_da_cat_fisc, ldw_da_cat_fisc_des, ldw_a_cat_fisc, ldw_a_cat_fisc_des
DataWindowChild ldw_id_cat_codifica, ldw_id_cat_codifica_des

dw_1.GetChild("id_cat_codifica", ldw_id_cat_codifica)
dw_1.GetChild("id_cat_codifica_des", ldw_id_cat_codifica_des)

dw_1.getchild("listino",ldw_listino)
dw_1.getchild("listino_des",ldw_listino_des)

dw_1.GetChild("da_cat_comm", ldw_da_cat_comm)
dw_1.GetChild("da_cat_comm_des", ldw_da_cat_comm_des)
dw_1.GetChild("a_cat_comm", ldw_a_cat_comm)
dw_1.GetChild("a_cat_comm_des", ldw_a_cat_comm_des)

dw_1.GetChild("da_cat_merc", ldw_da_cat_merc)
dw_1.GetChild("da_cat_merc_des", ldw_da_cat_merc_des)
dw_1.GetChild("a_cat_merc", ldw_a_cat_merc)
dw_1.GetChild("a_cat_merc_des", ldw_a_cat_merc_des)

dw_1.GetChild("da_cat_fisc", ldw_da_cat_fisc)
dw_1.GetChild("da_cat_fisc_des", ldw_da_cat_fisc_des)
dw_1.GetChild("a_cat_fisc", ldw_a_cat_fisc)
dw_1.GetChild("a_cat_fisc_des", ldw_a_cat_fisc_des)

dw_1.accepttext()

ldw_id_cat_codifica.SetTransObject(SQLCA)
ldw_id_cat_codifica.Retrieve()

ldw_id_cat_codifica_des.SetTransObject(SQLCA)
ldw_id_cat_codifica_des.Retrieve()

ldw_da_cat_comm.settransobject(sqlca)
ldw_da_cat_comm.retrieve()
	
ldw_da_cat_comm_des.settransobject(sqlca)
ldw_da_cat_comm_des.retrieve()

ldw_a_cat_comm.settransobject(sqlca)
ldw_a_cat_comm.retrieve()
	
ldw_a_cat_comm_des.settransobject(sqlca)
ldw_a_cat_comm_des.retrieve()

ldw_da_cat_merc.settransobject(sqlca)
ldw_da_cat_merc.retrieve()

ldw_da_cat_merc_des.settransobject(sqlca)
ldw_da_cat_merc_des.retrieve()

ldw_a_cat_merc.settransobject(sqlca)
ldw_a_cat_merc.retrieve()

ldw_a_cat_merc_des.settransobject(sqlca)
ldw_a_cat_merc_des.retrieve()

ldw_da_cat_fisc.settransobject(sqlca)
ldw_da_cat_fisc.retrieve()

ldw_da_cat_fisc_des.settransobject(sqlca)
ldw_da_cat_fisc_des.retrieve()

ldw_a_cat_fisc.settransobject(sqlca)
ldw_a_cat_fisc.retrieve()

ldw_a_cat_fisc_des.settransobject(sqlca)
ldw_a_cat_fisc_des.retrieve()
	
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

type cb_annulla from commandbutton within w_st_lista_articoli_cx
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

type cb_ok from commandbutton within w_st_lista_articoli_cx
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

event clicked;String 	ls_filtro, ls_ordinamento, ls_parametri, ls_orientamento
String	ls_da_articolo, ls_a_articolo, ls_da_cat_comm, ls_a_cat_comm, ls_variazione
String	ls_da_cat_merc, ls_a_cat_merc, ls_da_cat_fisc, ls_a_cat_fisc
String	ls_listino, ls_tipo_stampa, ls_raggruppamento, ls_cat_codifica
Long		ll_id_variazione, ll_id_cat_codifica, ll_id_parte_regola
String	ls_da_parte, ls_a_parte, ls_art_listino, ls_des_estesa

str_anag_art str_param

dw_1.accepttext()

ls_orientamento = dw_1.GetItemString(1, "orientamento")
ls_raggruppamento = dw_1.GetItemString(1, "raggruppamento")
ls_art_listino = dw_1.GetItemString(1, "art_listino")

If ls_raggruppamento = 'S' then
	ll_id_cat_codifica = dw_1.GetItemNumber(1, "id_cat_codifica")
	ll_id_parte_regola = dw_1.GetItemNumber(1, "id_parte_regola")
	ls_da_parte = dw_1.GetItemString(1, "da_parte")
	ls_a_parte = dw_1.GetItemString(1, "a_parte")
Else
	ls_da_articolo= dw_1.GetItemString(1, "da_articolo")
	ls_a_articolo = dw_1.GetItemString(1, "a_articolo")
End If

ls_da_cat_comm=dw_1.getitemstring(1,"da_cat_comm")
ls_a_cat_comm=dw_1.getitemstring(1,"a_cat_comm")

ls_da_cat_merc=dw_1.getitemstring(1,"da_cat_merc")
ls_a_cat_merc=dw_1.getitemstring(1,"a_cat_merc")

ls_da_cat_fisc=dw_1.getitemstring(1,"da_cat_fisc")
ls_a_cat_fisc=dw_1.getitemstring(1,"a_cat_fisc")

ls_listino=dw_1.GetItemstring(1,"listino")
ll_id_variazione = dw_1.GetItemNumber(1, "variazione")
ls_tipo_stampa=dw_1.getitemstring(1,"tipo_stampa")

SELECT CAST((DATEFORMAT(Data_inizio, 'dd/mm/yyyy') + ' - ' + DATEFORMAT(Data_fine, 'dd/mm/yyyy')) AS CHAR(40))
INTO	 :ls_variazione
FROM	 variazione
WHERE	 id_variazione = :ll_id_variazione
;


If ls_raggruppamento = 'S' then
	If IsNull(ll_id_cat_codifica) Then
		MessageBox("Lista Articoli per parte di codice", "Indicare la Categoria di Codifica")
		Return
	End If
	
	If IsNull(ll_id_parte_regola) Then
		MessageBox("Lista Articoli per parte di codice", "Indicare la parte di codice per il raggruppamento")
		Return
	End If
	
	
	SELECT codice
	INTO	 :ls_cat_codifica
	FROM	 cat_codifica
	WHERE  id_cat_codifica = :ll_id_cat_codifica
	;
	If SQLCA.SQLCODE = -1 then
		MessageBox("", SQLCA.SQLErrText)
	End If
	
Else
	if isnull(ls_da_articolo) or isnull(ls_a_articolo) then
		messagebox("Stampa elenco articoli","Gli articoli di inizio e fine sono obbligatori")
		return
	End If
		
	if ls_da_articolo > ls_a_articolo then
		messagebox("Stampa elenco articoli","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
		Return
	End If
End If

if ls_da_cat_comm > ls_a_cat_comm then
	messagebox("Stampa elenco articoli","Il codice della categoria commerciale iniziale è maggiore di quello finale",exclamation!)
	Return
End If

if ls_da_cat_merc > ls_a_cat_merc then
	messagebox("Stampa elenco articoli","Il codice della categoria merceologica iniziale è maggiore di quello finale",exclamation!)
	Return
End If

if ls_da_cat_fisc > ls_a_cat_fisc then
	messagebox("Stampa elenco articoli","Il codice della categoria fiscale iniziale è maggiore di quello finale",exclamation!)
	Return
End If

	

If ls_raggruppamento = 'S' then
	
	If not (IsNull(ll_id_cat_codifica)) and ls_parametri = '' then
		ls_parametri='Cat. Codifica:' + ls_cat_codifica
	ElseIf (IsNull(ll_id_cat_codifica)) and ls_parametri <> '' then
		ls_parametri=ls_parametri + ' Cat. Codifica:' + ls_cat_codifica
	end if
	
	
		
	if ls_da_parte <> '' then
		ls_filtro="parte_raggruppamento >= " + "'" + ls_da_parte + "'"
		ls_parametri=ls_parametri+' Da parte:' + ls_da_parte
	end if
	
	if ls_a_parte <> '' and ls_filtro = '' then
		ls_filtro="parte_raggruppamento <= " + "'" + ls_a_parte + "'"
		ls_parametri=ls_parametri+' A parte:' + ls_a_parte
	elseif ls_a_parte <> '' and ls_filtro <> '' then
		ls_filtro=ls_filtro+" AND parte_raggruppamento <= " + "'" + ls_a_parte + "'"
		ls_parametri=ls_parametri+' A Parte:' + ls_a_parte
	end if	
End If

if not(IsNull(ll_id_variazione)) then
	ls_parametri=ls_parametri+' Listino/Variaz.:'+ ls_listino + '     ' + ls_variazione
end if


if ls_da_cat_comm<>'' and ls_filtro = '' Then
	ls_filtro="cat_com_articolo.codice >= "+"'"+string(ls_da_cat_comm)+"'"
	ls_parametri=ls_parametri+' Da Cat.Comm.:'+ls_da_cat_comm
elseif ls_da_cat_comm<>'' and ls_filtro <> '' Then
	ls_filtro=ls_filtro + " AND cat_com_articolo.codice >= "+"'"+string(ls_da_cat_comm)+"'"
	ls_parametri=ls_parametri+' Da Cat.Comm.:'+ls_da_cat_comm
end if

if ls_a_cat_comm<>''and ls_filtro='' then
	ls_filtro="cat_com_articolo.codice <= "+"'"+string(ls_a_cat_comm)+"'"
	ls_parametri=ls_parametri+' A Cat.Comm.:'+ls_a_cat_comm
elseif ls_a_cat_comm<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND cat_com_articolo.codice <= "+"'"+string(ls_a_cat_comm)+"'"
	ls_parametri=ls_parametri+' A Cat.Comm.:'+ls_a_cat_comm
end if


if ls_da_cat_merc<>''and ls_filtro='' then
	ls_filtro="cat_merceologica.codice >= "+"'"+string(ls_da_cat_merc)+"'"
	ls_parametri=ls_parametri+' Da Cat.merc.:'+ls_da_cat_merc
elseif ls_da_cat_merc<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (cat_merceologica.codice >= "+"'"+string(ls_da_cat_merc)+"'"+")"
	ls_parametri=ls_parametri+' Da Cat.merc.:'+ls_da_cat_merc
end if

if ls_a_cat_merc<>''and ls_filtro='' then
	ls_filtro="cat_merceologica.codice <= "+"'"+string(ls_a_cat_merc)+"'"
	ls_parametri=ls_parametri+' A Cat.merc.:'+ls_a_cat_merc
elseif ls_a_cat_merc<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND cat_merceologica.codice <= "+"'"+string(ls_a_cat_merc)+"'"
	ls_parametri=ls_parametri+' A Cat.merc.:'+ls_a_cat_merc
end if


if ls_da_cat_fisc<>''and ls_filtro='' then
	ls_filtro="cat_fiscale.codice >= "+"'"+string(ls_da_cat_fisc)+"'"
	ls_parametri=ls_parametri+' Da Cat.fisc.:'+ls_da_cat_fisc
elseif ls_da_cat_fisc<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND cat_fiscale.codice >= "+"'"+string(ls_da_cat_fisc)+"'"
	ls_parametri=ls_parametri+' Da Cat.fisc.:'+ls_da_cat_fisc
end if

if ls_a_cat_fisc<>''and ls_filtro='' then
	ls_filtro="cat_fiscale.codice <= "+"'"+string(ls_a_cat_fisc)+"'"
	ls_parametri=ls_parametri+' A Cat.fisc.:'+ls_a_cat_fisc
elseif ls_a_cat_fisc<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND cat_fiscale.codice <= "+"'"+string(ls_a_cat_fisc)+"'"
	ls_parametri=ls_parametri+' A Cat.fisc.:'+ls_a_cat_fisc
end if


ls_ordinamento = dw_1.GetItemString(1, "ordinamento")

ls_des_estesa = dw_1.GetItemString(1, "descriz")
str_param.des_estesa = ls_des_estesa

str_param.parametri=ls_parametri
str_param.filtro=ls_filtro
str_param.ordinamento=ls_ordinamento
str_param.id_variazione=ll_id_variazione

If ls_orientamento = 'O' Then
	If ls_raggruppamento = 'S' then
		str_param.id_cat_codifica = ll_id_cat_codifica
		str_param.id_parte_regola = ll_id_parte_regola
		
		CHOOSE CASE ls_tipo_stampa
			CASE 'A'	
				If (IsNull(ll_id_variazione)) Then
					OpenWithParm(w_lista_art_parte_rpt,str_param)
				Else 
					If ls_art_listino = 'S' Then 
						OpenWithParm(w_lista_art3_parte_rpt,str_param)						
					Else
						OpenWithParm(w_lista_art2_parte_rpt,str_param)
					End If																				
				End If
			CASE 'U' 
				If (IsNull(ll_id_variazione)) Then
					OpenWithParm(w_lista_artuc_parte_rpt,str_param)	
				Else 
					If ls_art_listino = 'S' Then 
						OpenWithParm(w_lista_artuc3_parte_rpt,str_param)						
					Else
						OpenWithParm(w_lista_artuc2_parte_rpt,str_param)
					End If																																							
				End If
		END CHOOSE	
		
	Else
		str_param.da_art=ls_da_articolo
		str_param.a_art=ls_a_articolo
		CHOOSE CASE ls_tipo_stampa
			CASE 'A'	
				If (IsNull(ll_id_variazione)) Then
					OpenWithParm(w_st_lista_articoli_gd,str_param)
				Else 
					If ls_art_listino = 'S' Then 
						OpenWithParm(w_st_lista_articoli3_gd,str_param)
					Else
						OpenWithParm(w_st_lista_articoli2_gd,str_param)
					End If																				
				End If
			CASE 'U' 
				If (IsNull(ll_id_variazione)) Then
					OpenWithParm(w_st_lista_art_uc_gd,str_param)	
				Else 
					If ls_art_listino = 'S' Then 
						OpenWithParm(w_st_lista_art_uc3_gd,str_param)				
					Else
						OpenWithParm(w_st_lista_art_uc2_gd,str_param)				
					End If																																								
			End If
		END CHOOSE
	End If

Else		
	If ls_raggruppamento = 'S' then

		str_param.id_cat_codifica = ll_id_cat_codifica
		str_param.id_parte_regola = ll_id_parte_regola
		
		CHOOSE CASE ls_tipo_stampa
			CASE 'A'	
				If (IsNull(ll_id_variazione)) Then
					OpenWithParm(w_lista_art_parte_vrpt,str_param)
				Else 
					If ls_art_listino = 'S' Then 
						OpenWithParm(w_lista_art3_parte_vrpt,str_param)						
					Else
						OpenWithParm(w_lista_art2_parte_vrpt,str_param)
					End If
				End If
			CASE 'U' 
				If (IsNull(ll_id_variazione)) Then
					OpenWithParm(w_lista_artuc_parte_vrpt,str_param)	
				Else 
					If ls_art_listino = 'S' Then 
						OpenWithParm(w_lista_artuc3_parte_vrpt,str_param)				
					Else
						OpenWithParm(w_lista_artuc2_parte_vrpt,str_param)				
					End If	
				End If
		END CHOOSE	
		
	Else
		str_param.da_art=ls_da_articolo
		str_param.a_art=ls_a_articolo
		CHOOSE CASE ls_tipo_stampa
			CASE 'A'	
				If (IsNull(ll_id_variazione)) Then
					OpenWithParm(w_st_lista_articoli_vgd,str_param)
				Else 
					If ls_art_listino = 'S' Then 
						OpenWithParm(w_st_lista_articoli3_vgd,str_param)
					Else
						OpenWithParm(w_st_lista_articoli2_vgd,str_param)
					End If										
				End If
			CASE 'U' 
				If (IsNull(ll_id_variazione)) Then
					OpenWithParm(w_st_lista_art_uc_vgd,str_param)	
				Else 
					If ls_art_listino = 'S' Then 
						OpenWithParm(w_st_lista_art_uc3_vgd,str_param)				
					Else
						OpenWithParm(w_st_lista_art_uc2_vgd,str_param)				
					End If																									
				End If
		END CHOOSE
	End If
	
End If
end event

type dw_1 from u_dw_ext_main within w_st_lista_articoli_cx
int X=32
int Y=128
int Width=2935
int Height=1540
int TabOrder=10
string DataObject="d_st_lista_articoli_ext"
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
	CASE "raggruppamento"
		If Data = 'S' Then			
			
			Integer  li_cnt_cat_codifica
			Long		ll_id_cat_codifica
			
			SELECT COUNT(*)
			INTO	 :li_cnt_cat_codifica
			FROM	 cat_codifica
			WHERE	 id_azienda = 1
			;
			
			IF SQLCA.SQLCODE = -1 Then
				MessageBox("", SQLCA.SQLErrText)
			ElseIf li_cnt_cat_codifica = 1 Then
				SELECT id_cat_codifica
				INTO	 :ll_id_cat_codifica
				FROM	 cat_codifica
				WHERE	 id_azienda = 1
				;
				If SQLCA.SQLCODE = 0 Then
					dw_1.SetItem(1, "id_cat_codifica", ll_id_cat_codifica)
				
					ldw_id_parte_regola.SetTransObject(SQLCA)
					ldw_id_parte_regola.Retrieve(ll_id_cat_codifica)
				
					ldw_id_parte_regola_des.SetTransObject(SQLCA)
					ldw_id_parte_regola_des.Retrieve(ll_id_cat_codifica)					
				End If
			End If
		Else
			dw_1.SetItem(1, "art_listino", '')
		End If
	CASE "id_cat_codifica", "id_cat_codifica_des"
		Dw_1.SetItem(1, "id_parte_regola", "")
		Dw_1.SetItem(1, "id_parte_regola_des", "")
		Dw_1.SetItem(1, "da_parte", "")		
		Dw_1.SetItem(1, "a_parte", "")				
		
		ldw_id_parte_regola.SetTransObject(SQLCA)
		ldw_id_parte_regola.Retrieve(Long(Data))
	
		ldw_id_parte_regola_des.SetTransObject(SQLCA)
		ldw_id_parte_regola_des.Retrieve(Long(Data))
	
	CASE "id_parte_regola", "id_parte_regola_des"
		Integer	li_car_inizio, li_lun_parte, li_num_sezione, ll_id_parte_regola
		String	ls_descrizione
		
		DataWindowChild ldw_da_parte, ldw_a_parte
		
		dw_1.GetChild("da_parte", ldw_da_parte)
		dw_1.GetChild("a_parte",  ldw_a_parte)		
		
		ll_id_parte_regola = Long(Data)
		ll_id_cat_codifica = dw_1.GetItemNumber(1, "id_cat_codifica")
		
		
		SELECT descrizione, lunghezza, num_sezione
		INTO	 :ls_descrizione, :li_lun_parte, :li_num_sezione
		FROM	 parte_regola
		WHERE	 id_parte_regola = :ll_id_parte_regola
		;

		If SQLCA.SQLCODE = -1 then
			MessageBox("", SQLCA.SQLErrText)
		End If

		
		SELECT SUM(p.lunghezza) + 1 
		INTO	 :li_car_inizio
		FROM	 parte_regola p, cat_codifica c
		WHERE	 c.id_cat_codifica = :ll_id_cat_codifica
		AND	 p.id_scomposizione = c.id_scomposizione
		AND	 p.num_sezione < :li_num_sezione
		;
		
		IF SQLCA.SQLCODE = -1 Then
			MessageBox("", SQLCA.SQLErrText)
		End If
		
		If li_car_inizio = 0 Or IsNull(li_car_inizio) Then
			li_car_inizio = 1
		End If		
		
		ldw_da_parte.SetTransObject(SQLCA)
		ldw_da_parte.Retrieve(ll_id_cat_codifica, li_car_inizio, li_lun_parte, ls_descrizione)		
		
		ldw_a_parte.SetTransObject(SQLCA)
		ldw_a_parte.Retrieve(ll_id_cat_codifica, li_car_inizio, li_lun_parte, ls_descrizione)		
		
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

