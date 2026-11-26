forward
global type w_prof_cespite_cx from w_p_data
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
end forward

global type w_prof_cespite_cx from w_p_data
int Width=2405
int Height=1276
boolean TitleBar=true
string Title="Causale Cespite"
long BackColor=78748035
end type
global w_prof_cespite_cx w_prof_cespite_cx

on w_prof_cespite_cx.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_prof_cespite_cx.destroy
call super::destroy
end on

event open;call super::open;idw_master = tab_1.tabpage_1.dw_1

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "prof_cespite.id_prof_cespite"

ib_NonModale = TRUE

idw_master.ias_key_name[1] = "id_prof_cespite"
idw_master.is_list.s_modo = modo_inserisci

datawindowchild ldc_mm
tab_1.tabpage_1.dw_1.getchild('id_mastro',ldc_mm)
ldc_mm.settransobject(sqlca)
ldc_mm.retrieve()

end event

type p_crescente from w_p_data`p_crescente within w_prof_cespite_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_prof_cespite_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_prof_cespite_cx
int X=32
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_prof_cespite_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_prof_cespite_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_prof_cespite_cx
int X=1385
int Width=46
int Height=40
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_prof_cespite_cx
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_prof_cespite_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_prof_cespite_cx
int X=27
int Y=168
int Width=2341
int Height=1000
boolean BringToTop=true
Alignment Alignment=Center!
long BackColor=78748035
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2304
int Height=880
long BackColor=78748035
string Text="Profilo       "
long TabBackColor=78748035
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_1)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_prof_cespite_cx
boolean BringToTop=true
end type

event cb_ricerca::clicked;w_search_main lw_sm
long ll_id_gruppo_cespite
s_ric_param ls_ricpar


idw_master.is_ricpar.s_filter_name = "codice"
idw_master.is_ricpar.b_imm_retrieve = TRUE

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_prof_cespite_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_gruppo_cespite = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_prof_cespite"
	idw_master.is_list.l_identifica[1] = ll_id_gruppo_cespite
	
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
END IF

idw_master.SetFocus()
end event

type dw_1 from u_dw_master_main within tabpage_1
int X=23
int Y=32
int Width=2254
int Height=824
int TabOrder=12
string DataObject="d_prof_cesptite_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_prof_cespite"
is_title = "Profili"
end event

event itemchanged;STRING ls_dbc[], ls_dwc[], ls_dbv[]
INTEGER li_ok

CHOOSE CASE dwo.name
	CASE "cod_prof"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"
		ls_dwc[1] = "cod_prof"
		ls_dwc[2] = "des_prof"
		ls_dwc[3] = "id_prof_registrazione"

		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "des_prof"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"
		ls_dwc[1] = "cod_prof"
		ls_dwc[2] = "des_prof"
		ls_dwc[3] = "id_prof_registrazione"
		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
END CHOOSE		
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
	CASE "cod_prof", "des_prof"
		
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		IF as_nomecol = "cod_prof" THEN
			is_ricpar.s_filter_name = "codice"
		ELSE
			is_ricpar.s_filter_name = "descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE
		
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
		
	CASE "cod_prof"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])
      uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("des_prof", is_ricpar.s_ausil_value[1])
	
	CASE "des_prof"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("cod_prof", is_ricpar.s_ausil_value[1])

END CHOOSE		
end event

event rowfocuschanged;
end event

