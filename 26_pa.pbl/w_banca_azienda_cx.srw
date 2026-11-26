forward
global type w_banca_azienda_cx from w_p_data
end type
type dw_banca_azienda_ff from u_dw_master_main within w_banca_azienda_cx
end type
type dw_con_banca_azienda_gd from u_dw_master_main within w_banca_azienda_cx
end type
end forward

global type w_banca_azienda_cx from w_p_data
int X=416
int Width=2720
int Height=1456
boolean TitleBar=true
string Title="Banche dell' Azienda"
dw_banca_azienda_ff dw_banca_azienda_ff
dw_con_banca_azienda_gd dw_con_banca_azienda_gd
end type
global w_banca_azienda_cx w_banca_azienda_cx

on w_banca_azienda_cx.create
int iCurrent
call super::create
this.dw_banca_azienda_ff=create dw_banca_azienda_ff
this.dw_con_banca_azienda_gd=create dw_con_banca_azienda_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_banca_azienda_ff
this.Control[iCurrent+2]=this.dw_con_banca_azienda_gd
end on

on w_banca_azienda_cx.destroy
call super::destroy
destroy(this.dw_banca_azienda_ff)
destroy(this.dw_con_banca_azienda_gd)
end on

event open;call super::open;
il_HelpTopic = 72

idw_master = dw_banca_azienda_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "banca_azienda.id_banca_azienda"
ib_nonmodale=true

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_banca_azienda"
	idw_master.is_list.s_modo = modo_inserisci
	

END IF

end event

type p_crescente from w_p_data`p_crescente within w_banca_azienda_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_banca_azienda_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_banca_azienda_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_banca_azienda_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_banca_azienda_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_banca_azienda_cx
int X=1691
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_banca_azienda_cx
int X=1989
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_banca_azienda_cx
int X=2286
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_banca_azienda_cx
int Y=1500
int Height=44
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2322
end type

type cb_ricerca from w_p_data`cb_ricerca within w_banca_azienda_cx
boolean BringToTop=true
end type

event cb_ricerca::clicked;


w_search_main lw_sm
long ll_id_ban_azienda
s_ric_param ls_ricpar
string ls_dwcolname[], ls_dbfield[], ls_SQL_cond

idw_master.is_ricpar.s_filter_name = "banca_appoggio_cod_abi"



OpenWithParm(lw_sm, idw_master.is_ricpar, "w_banca_azienda_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_ban_azienda = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_banca_azienda"
	idw_master.is_list.l_identifica[1] = ll_id_ban_azienda
	
	idw_master.Event ue_retrieve(0, 0)
	
END IF

idw_master.SetFocus()

end event

type dw_banca_azienda_ff from u_dw_master_main within w_banca_azienda_cx
int X=50
int Y=160
int Width=2629
int Height=540
int TabOrder=10
string DataObject="d_banca_azienda_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_banca_azienda"
iudw_children[1] = dw_con_banca_azienda_gd
is_title = "Banche dell'Azienda"




		



end event

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
	CASE "banca_appoggio_cod_abi"
		is_search_window = "w_banca_appoggio_sw" 
		is_ricpar.s_filter_value = uf_get_colval("banca_appoggio_cod_abi") 
		is_ricpar.s_filter_name = "cod_abi" 
		
		is_ricpar.b_AsNeeded = TRUE
	CASE "banca_appoggio_cod_cab"
		is_search_window = "w_banca_appoggio_sw" 
		is_ricpar.s_filter_value = uf_get_colval("banca_appoggio_cod_cab") 
		is_ricpar.s_filter_name = "cod_cab" 
		
		is_ricpar.b_AsNeeded = TRUE
	CASE "cc_abi_cab_des"
		is_search_window = "w_banca_appoggio_sw" 
		is_ricpar.s_filter_value = uf_get_colval("banca_appoggio_den_abi") 
		is_ricpar.s_filter_name = "den_abi" 
		
		is_ricpar.b_AsNeeded = TRUE
	CASE "conto_codice"
		is_search_window = "w_conto_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond="sottomastro.uso='B'"
	CASE "conto_descrizione"
		is_search_window = "w_conto_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond="sottomastro.uso='B'"
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;
string 		ls_codice, ls_sep, ls_space

ls_sep = "-"
ls_space = "   "
CHOOSE CASE as_nomecol
	CASE "banca_appoggio_cod_abi"
		uf_set_colval("banca_azienda_id_banca_appoggio", is_ricpar.s_id_seg_value[1])
		uf_set_colval("banca_appoggio_cod_abi", is_ricpar.s_ausil_value[1])
		uf_set_colval("banca_appoggio_den_abi", is_ricpar.s_ausil_value[2])
		uf_set_colval("banca_appoggio_cod_cab", is_ricpar.s_ausil_value[3])
		uf_set_colval("banca_appoggio_den_cab", is_ricpar.s_ausil_value[4])

		uf_set_colval("cc_abi_cab_des",uf_get_colval("banca_appoggio_den_abi") + " - " + &
						  uf_get_colval("banca_appoggio_den_cab"))

	CASE "banca_appoggio_cod_cab"
		uf_set_colval("banca_azienda_id_banca_appoggio", is_ricpar.s_id_seg_value[1])
		uf_set_colval("banca_appoggio_cod_abi", is_ricpar.s_ausil_value[1])
		uf_set_colval("banca_appoggio_den_abi", is_ricpar.s_ausil_value[2])
		uf_set_colval("banca_appoggio_cod_cab", is_ricpar.s_ausil_value[3])
		uf_set_colval("banca_appoggio_den_cab", is_ricpar.s_ausil_value[4])

		uf_set_colval("cc_abi_cab_des",uf_get_colval("banca_appoggio_den_abi") + " - " + &
						  uf_get_colval("banca_appoggio_den_cab"))

	CASE "cc_abi_cab_des"
		uf_set_colval("banca_azienda_id_banca_appoggio", is_ricpar.s_id_seg_value[1])
		uf_set_colval("banca_appoggio_cod_abi", is_ricpar.s_ausil_value[1])
		uf_set_colval("banca_appoggio_den_abi", is_ricpar.s_ausil_value[2])
		uf_set_colval("banca_appoggio_cod_cab", is_ricpar.s_ausil_value[3])
		uf_set_colval("banca_appoggio_den_cab", is_ricpar.s_ausil_value[4])

		uf_set_colval("cc_abi_cab_des",uf_get_colval("banca_appoggio_den_abi") + " - " + &
						  uf_get_colval("banca_appoggio_den_cab"))
		
		
	CASE "conto_codice"
		uf_set_colval("conto_codice", is_ricpar.s_main_value)
		uf_set_colval("conto_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("banca_azienda_id_conto", is_ricpar.s_id_seg_value[1])
	CASE "conto_descrizione"
		uf_set_colval("conto_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("conto_descrizione", is_ricpar.s_main_value)
		uf_set_colval("banca_azienda_id_conto", is_ricpar.s_id_seg_value[1])
END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;
string 		ls_codice, ls_sep, ls_space

ls_sep = "-"
ls_space = "   "
ls_codice = uf_get_colval("banca_appoggio_cod_abi")
ls_codice = ls_codice + ls_sep + uf_get_colval("banca_appoggio_cod_cab")
ls_codice = ls_codice + ls_space + uf_get_colval("banca_appoggio_den_abi")
ls_codice = ls_codice + ls_sep + uf_get_colval("banca_appoggio_den_cab")
uf_set_colval("cc_abi_cab_des",ls_codice)
end event

event itemchanged;string ls_dbc[], ls_dwc[], ls_dbv[]
integer li_ok

CHOOSE CASE dwo.name

	CASE "banca_appoggio_cod_cab"
		ls_dbc[1] = "cod_abi"
		ls_dbc[2] = "cod_cab"
		ls_dbc[3] = "des_abi"
    	ls_dbc[4] = "id_banca_appoggio"

		ls_dwc[1] = "banca_appoggio_cod_abi"
		ls_dwc[2] = "banca_appoggio_cod_cab"

		ls_dwc[3] = "cc_abi_cab_des"		
		ls_dwc[4] = "banca_azienda_id_banca_appoggio"		
		
		li_ok = uf_autofind_col(string(dwo.name), "banca_appoggio", "cod_abi", "A", data, "", 4, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "conto_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"

		ls_dwc[1] = "conto_codice"
		ls_dwc[2] = "conto_descrizione"
		ls_dwc[3] = "banca_azienda_id_conto"		
		
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "conto_descrizione"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"

		ls_dwc[1] = "conto_codice"
		ls_dwc[2] = "conto_descrizione"
		ls_dwc[3] = "banca_azienda_id_conto"		
		
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
END CHOOSE
end event

type dw_con_banca_azienda_gd from u_dw_master_main within w_banca_azienda_cx
int X=50
int Y=720
int Width=2629
int Height=620
int TabOrder=3
string DataObject="d_con_banca_azienda_gd"
boolean TitleBar=true
string Title="Condizioni Banca"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_title = "Condizioni Banca Azienda"
is_list.s_identifica[1] = "id_banca_azienda"

end event

