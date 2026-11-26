forward
global type w_mov_art_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_mov_art_cx
end type
type cb_annulla from commandbutton within w_mov_art_cx
end type
type dw_1 from u_dw_ext_main within w_mov_art_cx
end type
end forward

global type w_mov_art_cx from w_wiz_main
int Width=2935
int Height=1264
WindowType WindowType=response!
boolean TitleBar=true
string Title="Scheda movimenti articolo"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_mov_art_cx w_mov_art_cx

type variables

end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
end prototypes

public function string uf_controlla_dati ();


string ls_tipo_registro,ls_flag_registri,ls_filtro,ls_flag_definitiva,ls_ret,ls_st_reg_iva,ls_st_reg2_iva
long ll_row,ll_n_registro
date ld_dalla_data,ld_alla_data

ll_row=dw_1.getrow()
ls_tipo_registro=dw_1.getitemstring(ll_row,"tipo_registro")
ld_dalla_data=dw_1.getitemdate(ll_row,"dalla_data")
ld_alla_data=dw_1.getitemdate(ll_row,"alla_data")
ls_flag_registri=dw_1.getitemstring(ll_row,"tutti_reg")
ll_n_registro=dw_1.getitemnumber(ll_row,"numero_registro")
ls_flag_definitiva=dw_1.getitemstring(ll_row,"elab_prova")




ls_ret='OK'
if ls_flag_registri='N' then
	
DECLARE ws_registri_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and  
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri_iva_cur;

FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri_iva_cur;


DECLARE ws_registri2_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and 
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri2_iva_cur ;

FETCH ws_registri2_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri2_iva_cur;
return ls_ret
else
	
	
	
	
	
DECLARE ws_registri3_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri3_iva_cur;

FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri3_iva_cur;


DECLARE ws_registri4_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri4_iva_cur ;

FETCH ws_registri4_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri4_iva_cur;
return ls_ret
end if

end function

public function date uf_prossimo_mese (readonly date data_attuale);integer mese,anno,day,giorni_mese
date nuova_data
anno=year(data_attuale)
mese=month(data_attuale)
if mese=12 then
	mese=1
	anno=anno+1
else
mese=mese+1
end if
day=day(data_attuale)


giorni_mese=f_gmese(mese,anno)
if day>giorni_mese then
	day=giorni_mese
end if

nuova_data=date(string(day)+"/"+string(mese)+"/"+string(anno))
return nuova_data
end function

on w_mov_art_cx.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
end on

on w_mov_art_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event closequery;

end event

event open;call super::open;datawindowchild ldw_da_cat_fiscale, ldw_a_cat_fiscale, ldw_da_cat_fiscale_des, ldw_a_cat_fiscale_des
datawindowchild ldw_da_magazzino, ldw_a_magazzino, ldw_da_magazzino_des, ldw_a_magazzino_des

String ls_par 


dw_1.insertrow(1)
String ls_da_articolo, ls_da_articolo_des, ls_a_articolo, ls_a_articolo_des, ls_da_prof_doc, ls_da_prof_doc_des, ls_a_prof_doc, ls_a_prof_doc_des
Date	 ld_da_data_doc, ld_a_data_doc

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
	dw_1.SetItem(1, "da_articoli_des", ls_da_articolo_des)	
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
	dw_1.SetItem(1, "a_articoli_des", ls_a_articolo_des)		
End If





SELECT data_inizio, data_fine
INTO	 :ld_da_data_doc, :ld_a_data_doc
FROM	 esercizio
WHERE	 id_esercizio = (SELECT id_esercizio FROM AZIENDA WHERE id_azienda = 1)
;

If SQLCA.SQLCODE = 0 Then
	dw_1.SetItem(1, "da_data_doc", ld_da_data_doc)
	dw_1.SetItem(1, "a_data_doc", ld_a_data_doc)
End If
end event

type cb_ok from commandbutton within w_mov_art_cx
event clicked pbm_bnclicked
int X=2267
int Y=36
int Width=261
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

event clicked;

string ls_da_articolo, ls_a_articolo
string ls_filtro, ls_parametri,ls_da_prof_doc, ls_a_prof_doc
date ld_da_data,ld_a_data

w_stampa_mov_art s_param_articoli

dw_1.accepttext()
ls_da_articolo=dw_1.getitemstring(1,"da_articolo")
ls_a_articolo=dw_1.getitemstring(1,"a_articolo")
ld_da_data=dw_1.getitemdate(1,"da_data_doc")
ld_a_data=dw_1.getitemdate(1,"a_data_doc")
ls_da_prof_doc=dw_1.getitemstring(1,"da_cod_prof_doc")
ls_a_prof_doc=dw_1.getitemstring(1,"a_cod_prof_doc")

If (IsNull(ls_da_articolo) or IsNull(ls_a_articolo)) Then
	MessageBox("Stampa movimenti articoli ","Gli Articoli di inizio e fine sono obbligatori",exclamation!)
	Return
End If	

if ls_da_articolo > ls_a_articolo then
	MessageBox("Stampa movimenti articoli ","L'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If	

If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Stampa movimenti articoli","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If

If ld_da_data > ld_a_data then
	MessageBox("Stampa movimenti articoli","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If
If ls_da_prof_doc > ls_a_prof_doc then
	MessageBox("Stampa movimenti articoli","Il profilo documento iniziale è maggiore di quello finale",exclamation!)
	Return
End If

ls_parametri='Da Articolo:' + ls_da_articolo + ' A Articolo:' + ls_a_articolo


if ls_da_prof_doc <> '' and ls_filtro='' then
	ls_filtro="prof_documento.codice>="+"'"+string(ls_da_prof_doc)+"'"
	ls_parametri = ' Da Prof Doc.:' + ls_da_prof_doc
elseif ls_da_prof_doc <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (prof_documento.codice>="+"'"+string(ls_da_prof_doc)+"'"+")"
	ls_parametri = ' Da Prof Doc.:' + ls_da_prof_doc
end if
if ls_a_prof_doc <> ''and ls_filtro='' then
	ls_filtro="prof_documento.codice<="+"'"+string(ls_a_prof_doc)+"'"
	ls_parametri = ' A Prof Doc.:' + ls_a_prof_doc
elseif ls_a_prof_doc <> ''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (prof_documento.codice<="+"'"+string(ls_a_prof_doc)+"'"+")"
	ls_parametri = ' A Prof Doc.:' + ls_a_prof_doc
end if

OpenWithParm(w_stampa_mov_art, s_param_articoli)


end event

type cb_annulla from commandbutton within w_mov_art_cx
int X=2597
int Y=32
int Width=261
int Height=88
int TabOrder=30
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

type dw_1 from u_dw_ext_main within w_mov_art_cx
event type integer ue_tipo_reg ( )
int X=32
int Y=144
int Width=2862
int Height=1012
int TabOrder=10
string DataObject="d_mov_art_ext"
end type

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_articoli_des", is_ricpar.s_ausil_value[1])

	CASE "da_articoli_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_articolo", is_ricpar.s_ausil_value[1])
		
	CASE "a_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_articoli_des", is_ricpar.s_ausil_value[1])

	CASE "a_articoli_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_articolo", is_ricpar.s_ausil_value[1])

	
	CASE "da_cod_prof_doc"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_prof_doc_des", is_ricpar.s_ausil_value[1])

	CASE "da_prof_doc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod_prof_doc", is_ricpar.s_ausil_value[1])
		
	CASE "a_cod_prof_doc"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod_prof_doc_des", is_ricpar.s_ausil_value[1])

	CASE "a_prof_doc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod_prof_doc", is_ricpar.s_ausil_value[1])
		
			
	CASE "da_cod_sog_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_sog_comm_des", is_ricpar.s_ausil_value[1])

	CASE "da_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod_sog_comm", is_ricpar.s_ausil_value[1])
		
	CASE "a_cod_sog_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod_sog_comm_des", is_ricpar.s_ausil_value[1])

	CASE "da_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod_sog_comm", is_ricpar.s_ausil_value[1])


END CHOOSE

end event

event ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "da_articolo", "da_articoli_des"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "da_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "da_articoli_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF

	
	CASE "a_articolo", "a_articoli_des"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "a_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "a_articoli_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF
		
		
	CASE "da_cod_prof_doc", "da_prof_doc_des"
		is_search_window = "w_prof_documento_coddes_sw"

		IF as_nomecol = "da_cod_prof_doc" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "prof_documento_codice"
		ELSEIF as_nomecol = "da_prof_doc_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "prof_documento_descrizione"
		END IF

	CASE "a_cod_prof_doc", "a_prof_doc_des"
		is_search_window = "w_prof_documento_coddes_sw"

		IF as_nomecol = "a_cod_prof_doc" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "prof_documento_codice"
		ELSEIF as_nomecol = "a_prof_doc_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "prof_documento_descrizione"
		END IF
			
	CASE "da_cod_sog_comm", "da_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "da_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "sog_commerciale_gen_codice"
		ELSEIF as_nomecol = "da_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "sog_commerciale_gen_descrizione"
		END IF

	CASE "a_cod_sog_comm", "a_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "a_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "sog_commerciale_gen_codice"
		ELSEIF as_nomecol = "a_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "sog_commerciale_gen_descrizione"
		END IF
	

	



END CHOOSE	
end event

event itemchanged;
integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	CASE "da_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articoli_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
			
      This.SetItem(1, "a_articolo", Data)			
      This.SetItem(1, "a_articoli_des", This.GetItemString(1, "da_articoli_des"))

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "da_articoli_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articoli_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF

	case "a_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articoli_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_articoli_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articoli_des"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		CASE "da_cod_prof_doc"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_prof_doc"
		ls_dwc[2] = "da_cod_prof_doc_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
			
      This.SetItem(1, "a_cod_prof_doc", Data)			
      This.SetItem(1, "a_prof_doc_des", This.GetItemString(1, "da_prof_doc_des"))

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "da_prof_doc_des"
		ls_sql_cond = ""

		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_prof_doc"
		ls_dwc[2] = "a_prof_doc_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF

	case "a_cod_prof_doc"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_prof_doc"
		ls_dwc[2] = "a_prof_doc_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_prof_doc_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_prof_doc"
		ls_dwc[2] = "a_prof_doc_des"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		CASE "da_cod_sog_comm"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "da_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
			
      This.SetItem(1, "a_cod_sog_comm", Data)			
      This.SetItem(1, "a_sog_comm_des", This.GetItemString(1, "da_sog_comm_des"))

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "da_sog_comm_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "a_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF

	case "a_cod_sog_comm"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_sog_comm"
		ls_dwc[2] = "a_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_sog_comm_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_sog_comm"
		ls_dwc[2] = "a_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
end choose

end event

