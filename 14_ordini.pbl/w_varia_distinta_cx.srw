forward
global type w_varia_distinta_cx from w_001
end type
type cb_applica from commandbutton within w_varia_distinta_cx
end type
type dw_1 from u_dw_ext_main within w_varia_distinta_cx
end type
type cb_annulla from commandbutton within w_varia_distinta_cx
end type
end forward

global type w_varia_distinta_cx from w_001
int Width=2601
int Height=572
WindowType WindowType=main!
boolean TitleBar=true
string Title="Variazioni Distinta Articolo"
long BackColor=80269524
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_applica cb_applica
dw_1 dw_1
cb_annulla cb_annulla
end type
global w_varia_distinta_cx w_varia_distinta_cx

on w_varia_distinta_cx.create
int iCurrent
call super::create
this.cb_applica=create cb_applica
this.dw_1=create dw_1
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_applica
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_annulla
end on

on w_varia_distinta_cx.destroy
call super::destroy
destroy(this.cb_applica)
destroy(this.dw_1)
destroy(this.cb_annulla)
end on

event open;call super::open;dw_1.insertrow(1)
end event

type cb_applica from commandbutton within w_varia_distinta_cx
int X=1979
int Y=328
int Width=247
int Height=108
int TabOrder=10
boolean BringToTop=true
string Text="Applica"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;w_orafo_lista_dis_cliente_gd w_lista
s_new_ordini s_ordini
integer ll_ret



s_ordini.s_ll_id_art_originale=dw_1.getitemnumber(1, "id_articolo")
s_ordini.s_ll_id_cliente=dw_1.getitemnumber(1, "id_sog_commerciale")

if s_ordini.s_ll_id_art_originale>0 and s_ordini.s_ll_id_cliente>0 then
	OpenWithParm(w_lista, s_ordini)
	ll_ret=message.doubleparm
	
	
	if ll_ret= -1 then 
		
	elseif ll_ret>0 then
		
		
		
	end if
else
	messagebox("Dati Incompleti!", "Articolo e soggetto commerciale sono obbligatori!")
end if
end event

type dw_1 from u_dw_ext_main within w_varia_distinta_cx
event type integer ue_tipo_reg ( )
int X=18
int Y=24
int Width=2519
int Height=272
int TabOrder=20
string DataObject="d_varia_distinta_st"
end type

event itemchanged;integer li_ok, li_null
long ll_id_titolo
string ls_sql_cond, ls_null
string ls_dbc[], ls_dwc[], ls_dbv[]
decimal ldc_cambio

CHOOSE CASE dwo.name
	CASE "da_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		LS_DBC[3] =	"id_articolo"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		ls_dwc[3] = "id_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	
	  
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "da_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dBc[3] = "ID_articolo"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		ls_dwc[3] = "ID_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc) 
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF

	
		CASE "da_cod_sog_comm"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"
		
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "da_sog_comm_des"
		ls_dwc[3] = "id_sog_commerciale"
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "da_sog_comm_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dbc[3] = "id_sog_commerciale"
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "da_sog_comm_des"
		ls_dwc[3] = "id_sog_commerciale"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF

end choose

end event

event itemfocuschanged;call super::itemfocuschanged;



end event

event ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "da_cod_articolo", "da_des_articolo"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "da_cod_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "da_des_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE
	CASE "a_cod_articolo", "a_des_articolo"
		is_search_window = "w_articolo_coddes_sw"

		IF as_nomecol = "a_cod_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "a_des_articolo" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF
		
			
	CASE "da_cod_sog_comm", "da_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "da_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "da_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF

	CASE "a_cod_sog_comm", "a_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "a_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "a_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF






END CHOOSE	
end event

event ue_use_search;CHOOSE CASE as_nomecol



			
	CASE "da_cod_sog_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_sog_comm_des", is_ricpar.s_ausil_value[1])
		
	CASE "da_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_cod_sog_comm", is_ricpar.s_ausil_value[1])
		
	CASE "da_cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_des_articolo", is_ricpar.s_ausil_value[1])
		
	CASE "da_des_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("da_cod_articolo", is_ricpar.s_ausil_value[1])
		
END CHOOSE

end event

type cb_annulla from commandbutton within w_varia_distinta_cx
int X=2286
int Y=328
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

