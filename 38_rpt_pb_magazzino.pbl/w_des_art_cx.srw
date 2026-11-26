forward
global type w_des_art_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_des_art_cx
end type
type cb_ok from commandbutton within w_des_art_cx
end type
type dw_1 from u_dw_ext_main within w_des_art_cx
end type
end forward

global type w_des_art_cx from w_wiz_main
int X=46
int Y=468
int Width=2848
int Height=648
boolean TitleBar=true
string Title="Stampa esistenza articoli"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_des_art_cx w_des_art_cx

type variables
integer ii_par
end variables

on w_des_art_cx.create
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

on w_des_art_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;string ls_da_articolo, ls_da_articolo_des, ls_a_articolo, ls_a_articolo_des

dw_1.insertrow(1)

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

type cb_annulla from commandbutton within w_des_art_cx
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

type cb_ok from commandbutton within w_des_art_cx
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
String	ls_da_articolo, ls_a_articolo

str_anag_art str_param

dw_1.accepttext()

ls_da_articolo= dw_1.GetItemString(1, "da_articolo")
ls_a_articolo = dw_1.GetItemString(1, "a_articolo")

if (isnull(ls_da_articolo) or isnull(ls_a_articolo)) then
	messagebox("Attenzione","Gli articoli di inizio e fine sono obbligatori")
	return
End If
	
if ls_da_articolo > ls_a_articolo then
	messagebox("Attenzione","Il codice dell'articolo iniziale è maggiore di quello finale")
	Return
End If

ls_parametri=ls_parametri+'Da Articolo:' + ls_da_Articolo + ' A Articolo:' + ls_a_articolo

str_param.da_art=ls_da_articolo
str_param.a_art=ls_a_articolo
str_param.parametri=ls_parametri

OpenWithParm(w_st_des_articoli_gd, str_param)

end event

type dw_1 from u_dw_ext_main within w_des_art_cx
int X=41
int Y=148
int Width=2720
int Height=340
int TabOrder=2
string DataObject="d_des_art_ext"
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
		

END CHOOSE

end event

