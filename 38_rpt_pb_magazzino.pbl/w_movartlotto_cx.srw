forward
global type w_movartlotto_cx from w_wiz_main
end type
type cb_annulla from commandbutton within w_movartlotto_cx
end type
type cb_ok from commandbutton within w_movartlotto_cx
end type
type dw_1 from u_dw_ext_main within w_movartlotto_cx
end type
end forward

global type w_movartlotto_cx from w_wiz_main
int Width=3035
int Height=996
boolean TitleBar=true
string Title="Stampa elenco articoli"
cb_annulla cb_annulla
cb_ok cb_ok
dw_1 dw_1
end type
global w_movartlotto_cx w_movartlotto_cx

on w_movartlotto_cx.create
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

on w_movartlotto_cx.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.insertrow(1)
end event

event ue_post_open;call super::ue_post_open;
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

type cb_annulla from commandbutton within w_movartlotto_cx
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

type cb_ok from commandbutton within w_movartlotto_cx
int X=2469
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
String	ls_da_articolo, ls_a_articolo, ls_da_cod_esterno, ls_a_cod_esterno
Decimal	ld_con_promozionale, ld_spese_varie
Long	   ll_id_valuta	
str_movartlotto str_param

dw_1.accepttext()

ls_da_articolo= dw_1.GetItemString(1, "da_articolo")
ls_a_articolo = dw_1.GetItemString(1, "a_articolo")

ls_da_cod_esterno = dw_1.GetItemString(1, "da_cod_esterno")
ls_a_cod_esterno = dw_1.GetItemString(1, "a_cod_esterno")

ld_con_promozionale = dw_1.GetItemNumber(1, "con_promozionale")
ld_spese_varie = dw_1.GetItemNumber(1, "spese_varie")
ll_id_valuta = dw_1.GetItemNumber(1, "id_valuta")	


if ls_da_articolo > ls_a_articolo then
	MessageBox("Stampa movimenti articoli per lotto","Il codice dell'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If

if ls_da_cod_esterno > ls_a_cod_esterno then
	messagebox("Stampa movimenti articoli per lotto","Il codice Lotto iniziale è maggiore di quello finale",exclamation!)
	Return
End If

if isnull(ll_id_valuta) then
	messagebox("Stampa movimenti articoli per lotto","Specificare la Valuta",exclamation!)
	Return
End If


ls_filtro = ''
ls_parametri = ''

if ls_filtro = '' and not (IsNull(ls_da_articolo)) Then
	ls_filtro="articolo.codice >= "+"'"+string(ls_da_articolo)+"'"
	ls_parametri=ls_parametri+' Da Articolo:'+ls_da_articolo
elseif ls_filtro <> '' and not (IsNull(ls_da_articolo)) Then
	ls_filtro=ls_filtro + " AND articolo.codice >= "+"'"+string(ls_da_articolo)+"'"
	ls_parametri=ls_parametri+' Da Articolo:'+ls_da_articolo
end if

if ls_filtro = '' and not (IsNull(ls_a_articolo)) Then
	ls_filtro="articolo.codice <= "+"'"+string(ls_a_articolo)+"'"
	ls_parametri=ls_parametri+' A Articolo:'+ls_a_articolo
elseif ls_filtro <> '' and not (IsNull(ls_a_articolo)) Then
	ls_filtro=ls_filtro + " AND articolo.codice <= "+"'"+string(ls_a_articolo)+"'"
	ls_parametri=ls_parametri+' A Articolo:'+ls_a_articolo
end if

if ls_filtro = '' and not (IsNull(ls_da_cod_esterno)) Then
	ls_filtro="lotto.cod_esterno >= "+"'"+string(ls_da_cod_esterno)+"'"
	ls_parametri=ls_parametri+' Da Cod. Lotto:'+ls_da_cod_esterno
elseif ls_filtro <> '' and not (IsNull(ls_da_cod_esterno)) Then
	ls_filtro=ls_filtro + " AND lotto.cod_esterno >= "+"'"+string(ls_da_cod_esterno)+"'"
	ls_parametri=ls_parametri+' Da Cod. Lotto:'+ls_da_cod_esterno
end if

if ls_filtro = '' and not (IsNull(ls_a_cod_esterno)) Then
	ls_filtro="lotto.cod_esterno <= "+"'"+string(ls_a_cod_esterno)+"'"
	ls_parametri=ls_parametri+' A Cod. Lotto:'+ls_a_cod_esterno
elseif ls_filtro <> '' and not (IsNull(ls_a_cod_esterno)) Then
	ls_filtro=ls_filtro + " AND lotto.cod_esterno <= "+"'"+string(ls_a_cod_esterno)+"'"
	ls_parametri=ls_parametri+' A Cod. Lotto:'+ls_a_cod_esterno
end if

str_param.filtro 					= ls_filtro
str_param.parametri 				= ls_parametri
str_param.con_promozionale 	= ld_con_promozionale
str_param.spese_varie 			= ld_spese_varie
str_param.id_valuta				= ll_id_valuta		

OpenWithParm(w_movartlotto_rpt, str_param)
end event

type dw_1 from u_dw_ext_main within w_movartlotto_cx
int X=32
int Y=128
int Width=2935
int Height=740
int TabOrder=2
string DataObject="d_movartlotto_ext"
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
	CASE "da_cod_esterno"
		is_search_window="w_lotto_cod_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="cod_esterno"		
	CASE "a_cod_esterno"
		is_search_window="w_lotto_cod_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="cod_esterno"
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
	case "da_cod_esterno"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_lotto",is_ricpar.s_id_seg_value[1])
			if isnull(This.GetItemString(1, "a_cod_esterno")) or This.GetItemString(1, "a_cod_esterno")='' then
				uf_set_colval("a_cod_esterno",is_ricpar.s_main_value)
			end if	
	case "a_cod_esterno"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_lotto",is_ricpar.s_id_seg_value[1])
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
		
	CASE "da_cod_esterno"
		ls_sql_cond = ""
		
		ls_dbc[1] = "cod_esterno"
		ls_dwc[1] = "da_cod_esterno"
		li_ok = uf_autofind_col(dwo.Name, "lotto", "cod_esterno", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_esterno")) or This.GetItemString(1, "a_cod_esterno")='' then
           This.SetItem(1, "a_cod_esterno", Data)			
	      end if  
			RETURN 2
		END IF	
		
	CASE "a_cod_esterno"
		ls_sql_cond = ""
		
		ls_dbc[1] = "cod_esterno"
		ls_dwc[1] = "a_cod_esterno"
		li_ok = uf_autofind_col(dwo.Name, "lotto", "cod_esterno", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	

		IF (li_ok > 0) THEN
			RETURN 2
		END IF		
		
END CHOOSE
end event

