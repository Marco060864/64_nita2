forward
global type w_st_distinte from w_wiz_main
end type
type cb_annulla from commandbutton within w_st_distinte
end type
type cb_ok from commandbutton within w_st_distinte
end type
type dw_1 from u_dw_ext_main within w_st_distinte
end type
type cb_distinta from commandbutton within w_st_distinte
end type
end forward

global type w_st_distinte from w_wiz_main
integer width = 3035
integer height = 1216
string title = "Stampa Distinta Base"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
cb_distinta cb_distinta
end type
global w_st_distinte w_st_distinte

on w_st_distinte.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.cb_distinta=create cb_distinta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_distinta
end on

on w_st_distinte.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.cb_distinta)
end on

event open;call super::open;dw_1.insertrow(1)

String ls_da_articolo, ls_a_articolo, ls_da_articolo_des, ls_a_articolo_des, ls_tipo_stampa
long  ll_id_valuta

datawindowchild ldw_da_cat_comm, ldw_da_cat_comm_des, ldw_a_cat_comm, ldw_a_cat_comm_des, ldw_listino, ldw_listino_des
datawindowchild ldw_da_cat_merc, ldw_da_cat_merc_des, ldw_a_cat_merc, ldw_a_cat_merc_des
datawindowchild ldw_da_cat_fisc, ldw_da_cat_fisc_des, ldw_a_cat_fisc, ldw_a_cat_fisc_des
DataWindowChild ldw_id_cat_codifica, ldw_id_cat_codifica_des, ldw_valuta

dw_1.GetChild("id_valuta", ldw_valuta)

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

ldw_valuta.SetTransObject(SQLCA)
ldw_valuta.Retrieve()

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
select id_valuta
into :ll_id_valuta
from par_sistema;

dw_1.SetItem(1, "id_valuta", ll_id_valuta)

dwobject l_dwo
l_dwo=dw_1.object.id_valuta
dw_1.trigger event itemchanged(1, l_dwo, string(ll_id_valuta)) 

ls_tipo_stampa = 'Listino prezzi'
dw_1.SetItem(1, "tipo_stampa", ls_tipo_stampa)
end event

type cb_annulla from commandbutton within w_st_distinte
integer x = 2738
integer y = 32
integer width = 229
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Esci"
boolean cancel = true
end type

event clicked;

Close(Parent)
end event

type cb_ok from commandbutton within w_st_distinte
integer x = 2395
integer y = 32
integer width = 242
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stam&pa"
boolean cancel = true
end type

event clicked;

String 	ls_filtro, ls_ordinamento, ls_parametri 
String	ls_da_articolo, ls_a_articolo, ls_da_cat_comm, ls_a_cat_comm, ls_variazione, ls_tipo_stampa
String	ls_da_cat_merc, ls_a_cat_merc, ls_da_cat_fisc, ls_a_cat_fisc
String	ls_listino, ls_cat_codifica     
Long		ll_id_variazione, ll_id_cat_codifica, ll_id_parte_regola
String	ls_da_parte, ls_a_parte, ls_art_listino

str_anag_art str_param

dw_1.accepttext()


ls_da_articolo= dw_1.GetItemString(1, "da_articolo")
ls_a_articolo = dw_1.GetItemString(1, "a_articolo")

str_param.id_cat_comm=dw_1.getitemnumber(1,"da_cat_comm")
//ls_a_cat_comm=dw_1.getitemstring(1,"a_cat_comm")

str_param.id_cat_merc=dw_1.getitemnumber(1,"da_cat_merc")
//ls_a_cat_merc=dw_1.getitemstring(1,"a_cat_merc")

str_param.id_cat_fisc=dw_1.getitemnumber(1,"da_cat_fisc")
//ls_a_cat_fisc=dw_1.getitemstring(1,"a_cat_fisc")

if isnull(ls_da_articolo) or isnull(ls_a_articolo) then
	messagebox("Stampa elenco articoli","Gli articoli di inizio e fine sono obbligatori")
	return
End If
		
if ls_da_articolo > ls_a_articolo then
	messagebox("Stampa elenco articoli","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If

//if ls_da_cat_comm > ls_a_cat_comm then
//	messagebox("Stampa elenco articoli","Il codice della categoria commerciale iniziale è maggiore di quello finale",exclamation!)
//	Return
//End If
//
//if ls_da_cat_merc > ls_a_cat_merc then
//	messagebox("Stampa elenco articoli","Il codice della categoria merceologica iniziale è maggiore di quello finale",exclamation!)
//	Return
//End If
//
//if ls_da_cat_fisc > ls_a_cat_fisc then
//	messagebox("Stampa elenco articoli","Il codice della categoria fiscale iniziale è maggiore di quello finale",exclamation!)
//	Return
//End If
//
//	

if not(IsNull(ll_id_variazione)) then
	ls_parametri=ls_parametri+' Listino/Variaz.:'+ ls_listino + '     ' + ls_variazione
end if

LS_FILTRO=''
if ls_da_cat_comm>'' and ls_filtro = '' Then
	ls_filtro="cat_com_articolo.codice >= "+"'"+string(ls_da_cat_comm)+"'"
	ls_parametri=ls_parametri+' Da Cat.Comm.:'+ls_da_cat_comm
elseif ls_da_cat_comm>'' and ls_filtro <> '' Then
	ls_filtro=ls_filtro + " AND cat_com_articolo.codice >= "+"'"+string(ls_da_cat_comm)+"'"
	ls_parametri=ls_parametri+' Da Cat.Comm.:'+ls_da_cat_comm
end if

if ls_a_cat_comm>''and ls_filtro='' then
	ls_filtro="cat_com_articolo.codice <= "+"'"+string(ls_a_cat_comm)+"'"
	ls_parametri=ls_parametri+' A Cat.Comm.:'+ls_a_cat_comm
elseif ls_a_cat_comm>''and ls_filtro<>'' then
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

str_param.id_cat_codifica=dw_1.getitemnumber(1, "id_cat_codifica")


str_param.id_valuta=dw_1.getitemnumber(1, "id_articolo")


str_param.parametri=ls_parametri
str_param.filtro=ls_filtro
str_param.da_art=ls_da_articolo
str_param.a_art=ls_a_articolo
str_param.tipo_arr=dw_1.getitemstring(1, "tipo_arr")
str_param.num_dec=dw_1.getitemnumber(1, "num_dec")

OpenWithParm(w_distinte_stampa_rpt,str_param)
				
			
			
			
			
			
			
		



end event

type dw_1 from u_dw_ext_main within w_st_distinte
integer x = 32
integer y = 128
integer width = 2935
integer height = 852
integer taborder = 10
string dataobject = "d_st_distinte_ext"
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
			if isnull(this.getitemstring(1,"a_articolo")) or this.getitemstring(1,"a_articolo")='' then
           SetItem(1, "a_des_articolo", is_ricpar.s_ausil_value[1])	
 		     SetItem(1, "a_articolo", is_ricpar.s_main_value)
			end if	

	
	
		
	case "da_des_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo",is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,"a_articolo")) or this.getitemstring(1,"a_articolo")='' then
			  SetItem(1, "a_articolo", is_ricpar.s_ausil_value[1])	
 		     SetItem(1, "a_des_articolo", is_ricpar.s_main_value)
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

event itemchanged;

integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
Long		ll_id_listino
String 	ls_listino, ls_raggruppamento
decimal ld_cambio

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
			if isnull(this.getitemstring(1,"a_articolo")) or this.getitemstring(1,"a_articolo")='' then
			  This.SetItem(1, "a_articolo",data)	
           This.SetItem(1, "a_des_articolo",ls_dbv[2])
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
			if isnull(this.getitemstring(1,"a_articolo")) or this.getitemstring(1,"a_articolo")='' then
			  This.SetItem(1, "a_des_articolo",data)	
           This.SetItem(1, "a_articolo",ls_dbv[1])
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
			
		End If
		
	case "id_valuta"
		ll_id_variazione=long (data)
		select parita_euro
		into :ld_cambio
		from valuta
		where id_valuta=:ll_id_variazione;
		dw_1.setitem(1, "cambio", ld_cambio)
		
END CHOOSE

end event

type cb_distinta from commandbutton within w_st_distinte
boolean visible = false
integer x = 1682
integer y = 32
integer width = 585
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa controllo/distinta"
end type

event clicked;



String 	ls_filtro, ls_ordinamento, ls_parametri 
String	ls_da_articolo, ls_a_articolo, ls_da_cat_comm, ls_a_cat_comm, ls_variazione, ls_tipo_stampa
String	ls_da_cat_merc, ls_a_cat_merc, ls_da_cat_fisc, ls_a_cat_fisc
String	ls_listino, ls_cat_codifica     
Long		ll_id_variazione, ll_id_cat_codifica, ll_id_parte_regola
String	ls_da_parte, ls_a_parte, ls_art_listino

str_anag_art str_param

dw_1.accepttext()


	ls_da_articolo= dw_1.GetItemString(1, "da_articolo")
	ls_a_articolo = dw_1.GetItemString(1, "a_articolo")


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


	if isnull(ls_da_articolo) or isnull(ls_a_articolo) then
		messagebox("Stampa elenco articoli","Gli articoli di inizio e fine sono obbligatori")
		return
	End If
		
	if ls_da_articolo > ls_a_articolo then
		messagebox("Stampa elenco articoli","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
		Return
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
str_param.parametri=ls_parametri
str_param.filtro=ls_filtro
str_param.ordinamento=ls_ordinamento
str_param.id_variazione=ll_id_variazione


		str_param.da_art=ls_da_articolo
		str_param.a_art=ls_a_articolo
		
		
OpenWithParm(w_orafo_st_lista_art_distinta_gd,str_param)		
		

	
end event

