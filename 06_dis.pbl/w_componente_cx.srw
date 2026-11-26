forward
global type w_componente_cx from w_p_data
end type
type dw_componente_ff from u_dw_master_main within w_componente_cx
end type
type dw_riga_componente_ff from u_dw_master_main within w_componente_cx
end type
end forward

global type w_componente_cx from w_p_data
dw_componente_ff dw_componente_ff
dw_riga_componente_ff dw_riga_componente_ff
end type
global w_componente_cx w_componente_cx

event open;call super::open;string ls_codice
s_list_main ls_list
idw_master =dw_componente_ff
idw_master.is_list = Message.PowerObjectParm
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_componente"
	idw_master.is_list.s_modo = modo_inserisci
END IF
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_SQL_ident[1] = "componente.id_componente"
ib_nonmodale=true

end event

on w_componente_cx.create
int iCurrent
call super::create
this.dw_componente_ff=create dw_componente_ff
this.dw_riga_componente_ff=create dw_riga_componente_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_componente_ff
this.Control[iCurrent+2]=this.dw_riga_componente_ff
end on

on w_componente_cx.destroy
call super::destroy
destroy(this.dw_componente_ff)
destroy(this.dw_riga_componente_ff)
end on

type tab_1 from w_p_data`tab_1 within w_componente_cx
int X=937
int Y=20
int Width=283
int Height=120
boolean Visible=false
long BackColor=78682240
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int Width=247
int Height=0
end type

event cb_ricerca::clicked;w_search_main lw_sm
long ll_id_componente
s_ric_param ls_ricpar
idw_master.is_ricpar.s_filter_value = ""
idw_master.is_ricpar.s_filter_name = "codice"
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_componente_sw")
idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_componente = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_componente"
	idw_master.is_list.l_identifica[1] = ll_id_componente
	idw_master.Event ue_retrieve(0, 0)	
END IF
idw_master.SetFocus()
end event

type dw_componente_ff from u_dw_master_main within w_componente_cx
int X=23
int Y=156
int Width=2363
int Height=292
int TabOrder=10
boolean BringToTop=true
string DataObject="d_componente_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_componente"
iudw_children[1]=dw_riga_componente_ff

end event

type dw_riga_componente_ff from u_dw_master_main within w_componente_cx
int X=23
int Y=540
int Width=2363
int Height=924
int TabOrder=12
boolean BringToTop=true
string DataObject="d_riga_componente_gd"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_componente"
end event

event itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[], ls_codice, ls_cod_art
integer li_ok
CHOOSE CASE dwo.name
	case "articolo_codice"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)		
	case "articolo_descrizione"
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)		
end choose
end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "articolo_codice"
			is_search_window = "w_ric_articolo_cf_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="codice"
	CASE "articolo_descrizione"
			is_search_window = "w_ric_articolo_cf_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name ="descrizione"
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])		
	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

