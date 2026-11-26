forward
global type w_con_pagamento_cx from w_p_data
end type
type dw_con_pagamento_ff from u_dw_master_main within w_con_pagamento_cx
end type
type dw_app_pagamento_gd from u_dw_master_main within w_con_pagamento_cx
end type
type cb_simula from commandbutton within w_con_pagamento_cx
end type
end forward

global type w_con_pagamento_cx from w_p_data
integer width = 3392
integer height = 1464
string title = "Condizioni Pagamento"
dw_con_pagamento_ff dw_con_pagamento_ff
dw_app_pagamento_gd dw_app_pagamento_gd
cb_simula cb_simula
end type
global w_con_pagamento_cx w_con_pagamento_cx

forward prototypes
public subroutine uf_simula ()
public subroutine uf_ricerca ()
end prototypes

public subroutine uf_simula ();

window		lw_support
long			ll_id_cond, ll_CurrRow


ll_CurrRow = dw_con_pagamento_ff.GetRow()

IF ll_CurrRow > 0 THEN
	ll_id_cond = dw_con_pagamento_ff.GetItemNumber(ll_CurrRow, "id_con_pagamento")
	
	IF IsNull(ll_id_cond) or ll_id_cond = 0 THEN
		MessageBox("Condizioni Pagamento","Impossibile avviare la simulazione.")
	ELSE
		IF (dw_app_pagamento_gd.ModifiedCount()+dw_app_pagamento_gd.deletedcount()) > 0 THEN
			ib_askforsave = FALSE
			 cb_salva.Event trigger clicked()
			ib_askforsave = TRUE
		END IF
		OpenWithParm(lw_support,ll_id_cond,"w_con_pagamento_simula_wz")
	END IF
END IF
end subroutine

public subroutine uf_ricerca ();

w_search_main lw_sm
long ll_id_con_pagamento
string ls_SQL_cond, ls_dwFieldName[], ls_dbfield[]
s_ric_param ls_ricpar

idw_master.is_ricpar.s_filter_name = "codice"

ls_dwFieldName[1] = "codice"
ls_dwFieldName[2] = "descrizione"
ls_dwFieldName[3] = "sconto_cassa"

ls_dbfield[1] = "codice"
ls_dbfield[2] = "descrizione"
ls_dbfield[3] = "sconto_cassa"

ls_SQL_cond = f_get_SQL_cond(dw_con_pagamento_ff, dw_con_pagamento_ff.GetRow(), ls_dwFieldName, ls_dbfield)
idw_master.is_ricpar.s_SQL_cond = ls_SQL_cond

idw_master.is_ricpar.b_imm_retrieve = TRUE

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_con_pagamento_sw")
idw_master.is_ricpar = Message.PowerObjectParm


IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	
	
	
	
	idw_master.is_list.s_identifica[1] = "id_con_pagamento"
	
	idw_master.is_list.l_identifica[1] = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
end if

idw_master.SetFocus()
end subroutine

event open;call super::open;

long ll_screenh
environment le_env

il_HelpTopic = 100

idw_master = dw_con_pagamento_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "con_pagamento.id_con_pagamento"

ib_NonModale = TRUE

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_con_pagamento"
	idw_master.is_list.s_modo = modo_inserisci
	
	
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
END IF

end event

on w_con_pagamento_cx.create
int iCurrent
call super::create
this.dw_con_pagamento_ff=create dw_con_pagamento_ff
this.dw_app_pagamento_gd=create dw_app_pagamento_gd
this.cb_simula=create cb_simula
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_con_pagamento_ff
this.Control[iCurrent+2]=this.dw_app_pagamento_gd
this.Control[iCurrent+3]=this.cb_simula
end on

on w_con_pagamento_cx.destroy
call super::destroy
destroy(this.dw_con_pagamento_ff)
destroy(this.dw_app_pagamento_gd)
destroy(this.cb_simula)
end on

event ue_master_delete;call super::ue_master_delete;

if (idw_master.Event ue_delete(0, 0) = 0) then
	ib_AskForSave = false
	IF (idw_master.Event ue_update(0, 0) = 0) then
		ib_AskForSave = true
		idw_master.is_list.s_modo = modo_inserisci
		idw_master.Event ue_insert(0, 0)
	else
		idw_master.Event ue_retrieve(0, 0)
	end if
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
end if
idw_master.SetFocus()

end event

type p_msg_log from w_p_data`p_msg_log within w_con_pagamento_cx
end type

type p_crescente from w_p_data`p_crescente within w_con_pagamento_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_con_pagamento_cx
end type

type cb_ok from w_p_data`cb_ok within w_con_pagamento_cx
end type

type cb_annulla from w_p_data`cb_annulla within w_con_pagamento_cx
end type

type cb_nuovo from w_p_data`cb_nuovo within w_con_pagamento_cx
integer x = 663
end type

event cb_nuovo::clicked;

IF idw_master.uf_to_update() > 0 THEN idw_master.event ue_update (0,0)

idw_master.Reset()
idw_master.is_list.s_modo = modo_inserisci
idw_master.triggerevent("ue_insert")
idw_master.SetFocus()

end event

type cb_inserisci from w_p_data`cb_inserisci within w_con_pagamento_cx
integer x = 1330
end type

type cb_cancella from w_p_data`cb_cancella within w_con_pagamento_cx
integer x = 1623
end type

type cb_salva from w_p_data`cb_salva within w_con_pagamento_cx
integer x = 1920
end type

type tab_1 from w_p_data`tab_1 within w_con_pagamento_cx
boolean visible = false
integer x = 1874
integer y = 1280
integer width = 503
integer height = 204
integer taborder = 0
boolean enabled = false
long backcolor = 79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 466
integer height = 84
end type

type cb_ricerca from w_p_data`cb_ricerca within w_con_pagamento_cx
integer x = 983
integer width = 306
end type

event cb_ricerca::clicked;call super::clicked;

uf_ricerca()
end event

type dw_con_pagamento_ff from u_dw_master_main within w_con_pagamento_cx
integer x = 50
integer y = 156
integer width = 2103
integer height = 360
integer taborder = 10
string dataobject = "d_con_pagamento_ff"
end type

event ue_init;call super::ue_init;iudw_children[1] = dw_app_pagamento_gd
is_title = "Condizioni Pagamento"
end event

event ue_validate_row;call super::ue_validate_row;
	Return 0
end event

type dw_app_pagamento_gd from u_dw_master_main within w_con_pagamento_cx
integer x = 27
integer y = 540
integer width = 3278
integer height = 744
integer taborder = 20
boolean titlebar = true
string title = "Applicazioni Pagamento"
string dataobject = "d_app_pagamento_gd"
boolean hscrollbar = true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_con_pagamento"
is_title = "Applicazioni Pagamento"
end event

event ue_initial;call super::ue_initial;long ll_rownumber, ll_row_count, ll_max = 0, ll_rowvalue


ll_rownumber = RowCount()
for ll_row_count = 1 to ll_rownumber
	ll_rowvalue = GetItemNumber( ll_row_count, "num_ordine")
	if not IsNull(ll_rowvalue) then ll_max = Max(ll_max, ll_rowvalue)
next
SetItem( GetRow(), "num_ordine", ll_max + 1)
	
end event

event ue_default;call super::ue_default;long ll_value, ll_rownumber, ll_row_count, ll_ivavalue = 0, ll_rowvalue = 0, ll_Impovalue = 0, ll_iva_val=0, ll_iva2_val=0
long ll_num_rate, ll_giorni_rate, ll_giorni_dec

CHOOSE CASE string(adwo_current.name)
	CASE "giorni_rate"
		ll_value = GetItemNumber(al_row, "num_rate")
		if (not IsNull(ll_value)) AND (ll_value > 0) then 
			SetItem(al_row, "giorni_rate", 30)
		else
			SetItem(al_row, "giorni_rate", 0)
		end if
	CASE "per_iva"
		ll_value = 0
		ll_rownumber = 0
		ll_row_count = 0
		ll_rownumber = RowCount()
		for ll_row_count = 1 to ll_rownumber
			ll_iva_val = GetItemnumber( ll_row_count, "per_iva")
			if not IsNull(ll_iva_val) then ll_iva2_val = ll_iva2_val + ll_iva_val
		next
		if (100 - ll_iva2_val) >= 0 then SetItem( GetRow(), "per_iva", (100 - ll_iva2_val))
	CASE "per_imponibile"
		ll_value = 0
		ll_rownumber = 0
		ll_row_count = 0
		ll_rownumber = RowCount()
		for ll_row_count = 1 to ll_rownumber
			ll_rowvalue = GetItemNumber( ll_row_count, "per_imponibile")
			if not IsNull(ll_rowvalue) then ll_Impovalue = ll_Impovalue + ll_rowvalue
		next
		if (100 - ll_Impovalue) >= 0 then SetItem( GetRow(), "per_imponibile", (100 - ll_Impovalue))	

	CASE "giorni_data_decorrenza"
		ll_rownumber = GetRow()
		if ll_rownumber > 1 then
			ll_num_rate = GetItemNumber(ll_rownumber - 1 , "num_rate")
			ll_giorni_rate = GetItemNumber(ll_rownumber - 1 , "giorni_rate")
			ll_giorni_dec = GetItemNumber(ll_rownumber - 1 , "giorni_data_decorrenza")
			if ll_giorni_rate > 0 AND ll_num_rate > 0 then 
				SetItem(ll_rownumber , "giorni_data_decorrenza", ll_giorni_dec + (ll_num_rate * ll_giorni_rate))
			else
				SetItem(ll_rownumber , "giorni_data_decorrenza", ll_giorni_dec + 30)
			end if
		else
			SetItem(ll_rownumber , "giorni_data_decorrenza", 30)
		end if
		
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "id_tipo_pagamento_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_pagamento_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Pagamento"
		is_ricpar.s_ausil_value[1] = "id_tipo_pagamento_des"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 1117
		
END CHOOSE


end event

event updatestart;long ll_rownumber, ll_row_count
decimal ll_ivavalue = 0, ll_rowvalue = 0, ll_impvalue = 0
u_dw_main ldw_current
boolean lb_corretto = TRUE

ldw_current = dw_app_pagamento_gd
ll_rownumber = ldw_current.RowCount()
if ll_rownumber > 0 then
	for ll_row_count = 1 to ll_rownumber
		ll_rowvalue = ldw_current.GetItemdecimal( ll_row_count, "per_iva")
		if not IsNull(ll_rowvalue) then ll_ivavalue = ll_ivavalue + ll_rowvalue
	next
	if (100 - ll_ivavalue) = 0 then 
		lb_corretto = TRUE
	else
		MessageBox(is_title,"Il Totale IVA deve essere 100%.")
		lb_corretto = FALSE
	end if
else
	lb_corretto = TRUE
end if

if ll_rownumber > 0 then
	for ll_row_count = 1 to ll_rownumber
		ll_rowvalue = ldw_current.GetItemdecimal( ll_row_count, "per_imponibile")
		if not IsNull(ll_rowvalue) then ll_impvalue = ll_impvalue + ll_rowvalue
	next
	if (100 - ll_impvalue) = 0 then 
		lb_corretto = lb_corretto AND TRUE
	else
		MessageBox(is_title,"Il Totale Imponibile deve essere 100%.")
		lb_corretto = lb_corretto AND FALSE
	end if
else
	lb_corretto = lb_corretto AND TRUE
end if
If lb_corretto then 
	return 0
else
	return 1
end if
end event

event itemchanged;

long ll_CurrRow

ll_CurrRow = THIS.GetRow()

CHOOSE CASE string(dwo.name)
	CASE "giorno_scadenza"
		THIS.AcceptText()
		IF (ll_CurrRow > 0) AND ((data = 'M') OR (data = 'D')) THEN
			THIS.SetItem(ll_CurrRow, "giorno_fisso", u_freddie.gl_null)
		END IF
	CASE "importo_fisso"
		
	CASE "importo_fisso_iva"		
   
END CHOOSE

end event

type cb_simula from commandbutton within w_con_pagamento_cx
integer x = 2985
integer y = 436
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Simula..."
end type

event clicked;

uf_simula()
end event

