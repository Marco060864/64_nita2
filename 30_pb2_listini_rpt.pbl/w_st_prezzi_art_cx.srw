forward
global type w_st_prezzi_art_cx from w_wiz_main
end type
type dw_1 from u_dw_ext_main within w_st_prezzi_art_cx
end type
type cb_1 from commandbutton within w_st_prezzi_art_cx
end type
type dw_2 from u_dw_ext_main within w_st_prezzi_art_cx
end type
type dw_3 from u_dw_ext_main within w_st_prezzi_art_cx
end type
end forward

global type w_st_prezzi_art_cx from w_wiz_main
int Width=2482
int Height=1992
boolean TitleBar=true
string Title="Stampa Prezzi Articoli"
long BackColor=80133307
dw_1 dw_1
cb_1 cb_1
dw_2 dw_2
dw_3 dw_3
end type
global w_st_prezzi_art_cx w_st_prezzi_art_cx

forward prototypes
public function decimal wf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita)
end prototypes

public function decimal wf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita);
char		lch_sconto[], lch_item[]
long 		ll_char_size, ll_char_count, ll_item_count
decimal  ldc_parte,ldc_tot_riga
string  ls_parte
long ll_row, ll_pos_plus,ll_pos_minus, ll_pos
boolean lb_non_calcolabile, lb_minus
string ls_tot_riga

lb_minus= FALSE
lch_item = ""
ll_item_count=0
if IsNull(adc_prezzo) then adc_prezzo = 0
if not (IsNull(as_sconto) OR as_sconto= "") then
	lch_sconto= Trim(as_sconto)
	ll_char_size= UpperBound(lch_sconto)
	For ll_char_count= 1 to ll_char_size
		CHOOSE CASE lch_sconto[ll_char_count]
			CASE "-"
				If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if  ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
						else
							adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = TRUE
			CASE "+"
					If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
						else
							adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = FALSE
			CASE ELSE
				ll_item_count ++
				lch_item[ll_item_count]= lch_sconto[ll_char_count]
		END CHOOSE
	next


	If not(lch_item = "") then
		ldc_parte= Dec(lch_item)
		if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
		
			SetNull(ldc_parte)	
			RETURN ldc_parte
		else
			if lb_minus then
				adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
			else
				adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
			end if
		end if
	end if
end if


RETURN adc_prezzo

end function

on w_st_prezzi_art_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_3
end on

on w_st_prezzi_art_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_3)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(0)
end event

event ue_post_open;call super::ue_post_open;
long		ll_id_valuta, ll_id_locazione

SELECT id_valuta, id_locazione
INTO	 :ll_id_valuta, :ll_id_locazione
FROM	 par_sistema
;

dw_1.setitem(1, "id_locazione_1", ll_id_locazione)
dw_1.setitem(1, "id_valuta", ll_id_valuta)
end event

type dw_1 from u_dw_ext_main within w_st_prezzi_art_cx
int X=27
int Y=160
int Width=2391
int Height=1660
int TabOrder=10
boolean BringToTop=true
string DataObject="d_st_prezzi_art"
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
		
	CASE "da_cliente_cod","a_cliente_cod"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="codice"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo='C' "
	CASE "da_cliente_des","a_cliente_des"
		is_search_window="w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="rag_soc_1"
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo='C' "
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
		
	case "da_cliente_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale_gen",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_cliente_des",is_ricpar.s_ausil_value[1])
		   if isnull(This.GetItemString(1, "a_cliente_cod")) or This.GetItemString(1, "a_cliente_cod")='' then
			  uf_set_colval("a_cliente_cod",is_ricpar.s_main_value)
		     uf_set_colval("a_cliente_des",is_ricpar.s_ausil_value[1])
	      end if	
	case "da_cliente_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("da_cliente_cod",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_cliente_cod")) or This.GetItemString(1, "a_cliente_cod")='' then
				uf_set_colval("a_cliente_des",is_ricpar.s_main_value)
				uf_set_colval("a_cliente_cod",is_ricpar.s_ausil_value[1])
			end if	
	case "a_cliente_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("a_cliente_des",is_ricpar.s_ausil_value[1])	
	case "a_cliente_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("a_cliente_cod",is_ricpar.s_ausil_value[1])
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
		
	CASE "da_cliente_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cliente_cod"
		ls_dwc[2] = "da_cliente_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
						
      
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cliente_cod")) or This.GetItemString(1, "a_cliente_cod")='' then
          This.SetItem(1, "a_cliente_cod", Data)			
          This.SetItem(1, "a_cliente_des", This.GetItemString(1, "da_cliente_des"))
	      end if
			RETURN 2
		END IF
		
		
	CASE "da_cliente_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cliente_cod"
		ls_dwc[2] = "da_cliente_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cliente_cod")) or This.GetItemString(1, "a_cliente_cod")='' then
          This.SetItem(1, "a_cliente_des", Data)			
          This.SetItem(1, "a_cliente_cod", This.GetItemString(1, "da_cliente_cod"))
	      end if	
			RETURN 2
		END IF

	CASE "a_cliente_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cliente_cod"
		ls_dwc[2] = "a_cliente_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_cliente_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cliente_cod"
		ls_dwc[2] = "a_cliente_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose
end event

type cb_1 from commandbutton within w_st_prezzi_art_cx
int X=2048
int Y=28
int Width=261
int Height=88
int TabOrder=30
boolean BringToTop=true
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
String 	ls_filtro, ls_parametri, ls_tipo_stampa
String	ls_da_articolo, ls_a_articolo
String	ls_da_cat_comm, ls_a_cat_comm
String	ls_da_cliente_cod, ls_a_cliente_cod
String	ls_da_cat_comm_sc, ls_a_cat_comm_sc
String	ls_tipo_applicazione
Long		ll_id_valuta, ll_id_locazione

s_st_listino_prezzi str_param

dw_1.Accepttext()


ls_tipo_applicazione = dw_1.getitemstring(1, "tipo_applicazione")
ll_id_valuta = dw_1.getitemnumber(1, "id_valuta")
ll_id_locazione = dw_1.getitemnumber(1, "id_locazione_1")

if (isnull(ls_tipo_applicazione) or ls_tipo_applicazione = '') or &
	(isnull(ll_id_valuta) or ll_id_valuta = 0) or &
	(isnull(ll_id_locazione) or ll_id_locazione = 0) then
	messagebox("Stampa Listino Prezzi", "I dati in grassetto sono obbligatori")
	return
end if

ls_da_articolo = dw_1.Object.da_articolo[1]
ls_a_articolo  = dw_1.Object.a_articolo[1]

If ls_da_articolo > ls_a_articolo then
	MessageBox("Stampa Listino Prezzi","L'articolo iniziale è maggiore di quello finale",exclamation!)
	Return
End If

ls_da_cat_comm = dw_1.Object.da_cat_comm[1]
ls_a_cat_comm  = dw_1.Object.a_cat_comm[1]

If ls_da_cat_comm > ls_da_cat_comm then
	MessageBox("Stampa Listino Prezzi","La cat. comm. articolo iniziale è maggiore di quella finale",exclamation!)
	Return
End If

ls_da_cliente_cod = dw_1.Object.da_cliente_cod[1]
ls_a_cliente_cod  = dw_1.Object.a_cliente_cod[1]

If ls_da_cat_comm > ls_da_cat_comm then
	MessageBox("Stampa Listino Prezzi","Il cod. Cliente iniziale è maggiore di quello finale",exclamation!)
	Return
End If

ls_da_cat_comm_sc = dw_1.Object.da_cat_comm_sc[1]
ls_a_cat_comm_sc = dw_1.Object.a_cat_comm_sc[1]

If ls_da_cat_comm > ls_da_cat_comm then
	MessageBox("Stampa Listino Prezzi","La cat. comm. iniziale è maggiore di quella finale",exclamation!)
	Return
End If

	

If not (IsNull(ls_da_articolo)) then
	ls_filtro="articolo.codice >= " + "'" + ls_da_articolo + "'"
	ls_parametri='  Da Articolo:' + ls_da_articolo
end if

If not (IsNull(ls_a_articolo)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro 		= ls_filtro + "articolo.codice <= " + "'" + ls_a_articolo + "'"
	ls_parametri	= ls_parametri + '  A Articolo:' + ls_a_articolo
end if

if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
ls_filtro 		= ls_filtro + "articolo.stampa_in_listini = 'S'"	


If not (IsNull(ls_da_cat_comm)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro		= ls_filtro + "cat_com_articolo.codice >= " + "'" + ls_da_cat_comm + "'"
	ls_parametri	= ls_parametri + '  Da cat.comm.:' + ls_da_cat_comm
end if

If not (IsNull(ls_a_cat_comm)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro	= ls_filtro + "cat_com_articolo.codice <= " + "'" + ls_a_cat_comm + "'"
	ls_parametri = ls_parametri + '  A cat.comm. Articolo:' + ls_a_cat_comm
end if

If not (IsNull(ls_da_cat_comm_sc)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro		= ls_filtro + "cat_com_sc.codice >= " + "'" + ls_da_cat_comm_sc + "'"
	ls_parametri	= ls_parametri + '  Da cat.comm.sc:' + ls_da_cat_comm_sc
end if

If not (IsNull(ls_a_cat_comm_sc)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro	= ls_filtro + "cat_com_sc.codice <= " + "'" + ls_a_cat_comm_sc + "'"
	ls_parametri = ls_parametri + '  A cat.comm.sc:' + ls_a_cat_comm_sc
end if

If not (IsNull(ls_da_cliente_cod)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro=ls_filtro+"sog_commerciale.codice >= " + "'" + ls_da_cliente_cod + "'"
	ls_parametri=ls_parametri+'  Da Sogg. Commerciale:' + ls_da_cliente_cod
end if

If not (IsNull(ls_a_cliente_cod)) then
	if (ls_filtro <> '') then ls_filtro = ls_filtro + " AND "
	ls_filtro=ls_filtro+"sog_commerciale.codice <= " + "'" + ls_a_cliente_cod + "'"
	ls_parametri=ls_parametri+'  A Sogg. Commerciale:' + ls_a_cliente_cod
end if

str_param.filtro = ls_filtro
str_param.parametri = ls_parametri
str_param.tipo_stampa = ls_tipo_stampa
str_param.tipo_applicazione = ls_tipo_applicazione
str_param.id_locazione = ll_id_locazione
str_param.id_valuta = ll_id_valuta

OpenWithParm(w_st_prezzi_art_rpt, str_param)	


end event

type dw_2 from u_dw_ext_main within w_st_prezzi_art_cx
int X=27
int Y=28
int Width=347
int Height=148
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string DataObject="d_st_prezzi_art2"
end type

event retrievestart;return 2
end event

type dw_3 from u_dw_ext_main within w_st_prezzi_art_cx
int X=517
int Y=36
int Width=357
int Height=144
int TabOrder=11
boolean Visible=false
boolean BringToTop=true
string DataObject="d_st_prezzi_art3"
end type

