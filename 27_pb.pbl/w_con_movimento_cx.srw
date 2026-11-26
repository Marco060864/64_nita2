forward
global type w_con_movimento_cx from w_p_data
end type
type st_9 from statictext within tabpage_1
end type
type dw_con_movimento_caus_a_gd from u_dw_master_main within tabpage_1
end type
type st_10 from statictext within tabpage_1
end type
type dw_con_movimento_caus_v_gd from u_dw_master_main within tabpage_1
end type
type tabpage_art from userobject within tab_1
end type
type dw_dummy from u_dw_master_main within tabpage_art
end type
type st_1 from statictext within tabpage_art
end type
type dw_con_movimento_art_gd from u_dw_master_main within tabpage_art
end type
type st_2 from statictext within tabpage_art
end type
type dw_v_con_movimento_art_gd from u_dw_master_main within tabpage_art
end type
type tabpage_art from userobject within tab_1
dw_dummy dw_dummy
st_1 st_1
dw_con_movimento_art_gd dw_con_movimento_art_gd
st_2 st_2
dw_v_con_movimento_art_gd dw_v_con_movimento_art_gd
end type
type tabpage_ccart from userobject within tab_1
end type
type dw_con_movimento_ccart_gd from u_dw_master_main within tabpage_ccart
end type
type dw_v_con_movimento_ccart_gd from u_dw_master_main within tabpage_ccart
end type
type st_3 from statictext within tabpage_ccart
end type
type st_4 from statictext within tabpage_ccart
end type
type tabpage_ccart from userobject within tab_1
dw_con_movimento_ccart_gd dw_con_movimento_ccart_gd
dw_v_con_movimento_ccart_gd dw_v_con_movimento_ccart_gd
st_3 st_3
st_4 st_4
end type
type tabpage_sc from userobject within tab_1
end type
type dw_con_movimento_sc_gd from u_dw_master_main within tabpage_sc
end type
type dw_v_con_movimento_sc_gd from u_dw_master_main within tabpage_sc
end type
type st_5 from statictext within tabpage_sc
end type
type st_6 from statictext within tabpage_sc
end type
type tabpage_sc from userobject within tab_1
dw_con_movimento_sc_gd dw_con_movimento_sc_gd
dw_v_con_movimento_sc_gd dw_v_con_movimento_sc_gd
st_5 st_5
st_6 st_6
end type
type tabpage_ccsc from userobject within tab_1
end type
type dw_con_movimento_ccsc_gd from u_dw_master_main within tabpage_ccsc
end type
type dw_v_con_movimento_ccsc_gd from u_dw_master_main within tabpage_ccsc
end type
type st_7 from statictext within tabpage_ccsc
end type
type st_8 from statictext within tabpage_ccsc
end type
type tabpage_ccsc from userobject within tab_1
dw_con_movimento_ccsc_gd dw_con_movimento_ccsc_gd
dw_v_con_movimento_ccsc_gd dw_v_con_movimento_ccsc_gd
st_7 st_7
st_8 st_8
end type
end forward

global type w_con_movimento_cx from w_p_data
integer x = 406
integer y = 26
integer width = 3046
integer height = 1821
string title = "Contropartite"
end type
global w_con_movimento_cx w_con_movimento_cx

forward prototypes
public subroutine wf_ver_sog_commerciale (string as_codice)
end prototypes

public subroutine wf_ver_sog_commerciale (string as_codice);integer li_app

SELECT 1
INTO	 :li_app
FROM	 con_movimento c, sog_commerciale s
WHERE  c.id_sog_commerciale = s.id_sog_commerciale
AND	 s.codice = :as_codice
;

if (SQLCA.SQLCODE = 0) then
	messagebox("Attenzione", "Il Sogg.Commerciale specificato è già stato inserito");
end if
end subroutine

on w_con_movimento_cx.create
int iCurrent
call super::create
end on

on w_con_movimento_cx.destroy
call super::destroy
end on

event open;call super::open;il_HelpTopic = 379
idw_master = tab_1.tabpage_art.dw_dummy
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE

idw_master.is_list.s_modo = modo_modifica

end event

type p_msg_log from w_p_data`p_msg_log within w_con_movimento_cx
end type

type p_crescente from w_p_data`p_crescente within w_con_movimento_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_con_movimento_cx
end type

type cb_ok from w_p_data`cb_ok within w_con_movimento_cx
end type

type cb_annulla from w_p_data`cb_annulla within w_con_movimento_cx
end type

type cb_nuovo from w_p_data`cb_nuovo within w_con_movimento_cx
end type

type cb_inserisci from w_p_data`cb_inserisci within w_con_movimento_cx
integer x = 2103
end type

type cb_cancella from w_p_data`cb_cancella within w_con_movimento_cx
integer x = 2399
end type

type cb_salva from w_p_data`cb_salva within w_con_movimento_cx
integer x = 2695
end type

type tab_1 from w_p_data`tab_1 within w_con_movimento_cx
integer x = 48
integer y = 154
integer width = 2926
integer height = 1520
long backcolor = 79741120
tabpage_art tabpage_art
tabpage_ccart tabpage_ccart
tabpage_sc tabpage_sc
tabpage_ccsc tabpage_ccsc
end type

on tab_1.create
this.tabpage_art=create tabpage_art
this.tabpage_ccart=create tabpage_ccart
this.tabpage_sc=create tabpage_sc
this.tabpage_ccsc=create tabpage_ccsc
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_art
this.Control[iCurrent+2]=this.tabpage_ccart
this.Control[iCurrent+3]=this.tabpage_sc
this.Control[iCurrent+4]=this.tabpage_ccsc
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_art)
destroy(this.tabpage_ccart)
destroy(this.tabpage_sc)
destroy(this.tabpage_ccsc)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer x = 15
integer y = 90
integer width = 2896
integer height = 1418
long backcolor = 79741120
string text = "Causale di Magazzino"
long tabbackcolor = 79741120
st_9 st_9
dw_con_movimento_caus_a_gd dw_con_movimento_caus_a_gd
st_10 st_10
dw_con_movimento_caus_v_gd dw_con_movimento_caus_v_gd
end type

on tabpage_1.create
this.st_9=create st_9
this.dw_con_movimento_caus_a_gd=create dw_con_movimento_caus_a_gd
this.st_10=create st_10
this.dw_con_movimento_caus_v_gd=create dw_con_movimento_caus_v_gd
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_9
this.Control[iCurrent+2]=this.dw_con_movimento_caus_a_gd
this.Control[iCurrent+3]=this.st_10
this.Control[iCurrent+4]=this.dw_con_movimento_caus_v_gd
end on

on tabpage_1.destroy
call super::destroy
destroy(this.st_9)
destroy(this.dw_con_movimento_caus_a_gd)
destroy(this.st_10)
destroy(this.dw_con_movimento_caus_v_gd)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_con_movimento_cx
end type

type st_9 from statictext within tabpage_1
integer x = 26
integer y = 16
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Acquisti"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_con_movimento_caus_a_gd from u_dw_master_main within tabpage_1
integer x = 26
integer y = 96
integer width = 2834
integer height = 576
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_con_movimento_caus_gd"
end type

event constructor;call super::constructor;string		ls_sql_cond, ls_sql


ls_sql_cond = "con_movimento.applicazione = 'A'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'caus_magazzino_codice'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_caus_magazzino"
		ls_dwc[1] = "id_caus_magazzino"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "caus_magazzino_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "caus_magazzino_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "caus_magazzino", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'caus_magazzino_descrizione'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_caus_magazzino"
		ls_dwc[1] = "id_caus_magazzino"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "caus_magazzino_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "caus_magazzino_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "caus_magazzino_", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'A')
return 0
end event

event ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "caus_magazzino_codice"
		is_search_window = "w_caus_mag_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "caus_magazzino_descrizione"
		is_search_window = "w_caus_mag_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)
	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;

CHOOSE CASE as_nomecol

	CASE "caus_magazzino_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_caus_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("caus_magazzino_descrizione", is_ricpar.s_ausil_value[1])
	CASE "caus_magazzino_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1])
		uf_set_colval("id_caus_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("caus_magazzino_codice",is_ricpar.s_main_value)

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_con_movimento_caus_a_gd.rowcount()
dw_con_movimento_caus_a_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "caus_magazzino_codice_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_caus_a_gd.getitemstring(1,"caus_magazzino_codice")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_con_movimento_caus_a_gd.getitemstring(ll_totrows,"caus_magazzino_codice")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_caus_a_gd.setsort("caus_magazzino_codice D")
			else 
				dw_con_movimento_caus_a_gd.setsort("caus_magazzino_codice A")
			end if
		end if
		
	CASE "caus_magazzino_descrizione_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_caus_a_gd.getitemstring(1,"caus_magazzino_descrizione")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_caus_a_gd.getitemstring(ll_totrows,"caus_magazzino_descrizione")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_caus_a_gd.setsort("caus_magazzino_descrizione D")
			else 
				dw_con_movimento_caus_a_gd.setsort("caus_magazzino_descrizione A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_caus_a_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_con_movimento_caus_a_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_caus_a_gd.setsort("c_conto_cod D")
			else 
				dw_con_movimento_caus_a_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_con_movimento_caus_a_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_caus_a_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_caus_a_gd.setsort("c_conto_des D")
			else 
				dw_con_movimento_caus_a_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_con_movimento_caus_a_gd.sort()
dw_con_movimento_caus_a_gd.setredraw(TRUE)
end event

type st_10 from statictext within tabpage_1
integer x = 26
integer y = 714
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Vendite"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_con_movimento_caus_v_gd from u_dw_master_main within tabpage_1
integer x = 26
integer y = 787
integer width = 2834
integer height = 579
integer taborder = 12
boolean bringtotop = true
string dataobject = "d_con_movimento_caus_gd"
end type

event constructor;call super::constructor;string		ls_sql_cond, ls_sql


ls_sql_cond = "con_movimento.applicazione = 'V'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql

end event

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'caus_magazzino_codice'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_caus_magazzino"
		ls_dwc[1] = "id_caus_magazzino"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "caus_magazzino_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "caus_magazzino_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "caus_magazzino", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'caus_magazzino_descrizione'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_caus_magazzino"
		ls_dwc[1] = "id_caus_magazzino"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "caus_magazzino_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "caus_magazzino_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "caus_magazzino_", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'V')
return 0

end event

event ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "caus_magazzino_codice"
		is_search_window = "w_caus_mag_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "caus_magazzino_descrizione"
		is_search_window = "w_caus_mag_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)
	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;

CHOOSE CASE as_nomecol

	CASE "caus_magazzino_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_caus_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("caus_magazzino_descrizione", is_ricpar.s_ausil_value[1])
	CASE "caus_magazzino_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_ausil_value[1])
		uf_set_colval("id_caus_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("caus_magazzino_codice",is_ricpar.s_main_value)

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_con_movimento_caus_v_gd.rowcount()
dw_con_movimento_caus_v_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "caus_magazzino_codice_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_caus_v_gd.getitemstring(1,"caus_magazzino_codice")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_con_movimento_caus_v_gd.getitemstring(ll_totrows,"caus_magazzino_codice")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_caus_v_gd.setsort("caus_magazzino_codice D")
			else 
				dw_con_movimento_caus_v_gd.setsort("caus_magazzino_codice A")
			end if
		end if
		
	CASE "caus_magazzino_descrizione_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_caus_v_gd.getitemstring(1,"caus_magazzino_descrizione")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_caus_v_gd.getitemstring(ll_totrows,"caus_magazzino_descrizione")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_caus_v_gd.setsort("caus_magazzino_descrizione D")
			else 
				dw_con_movimento_caus_v_gd.setsort("caus_magazzino_descrizione A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_caus_v_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_con_movimento_caus_v_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_caus_v_gd.setsort("c_conto_cod D")
			else 
				dw_con_movimento_caus_v_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_con_movimento_caus_v_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_caus_v_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_caus_v_gd.setsort("c_conto_des D")
			else 
				dw_con_movimento_caus_v_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_con_movimento_caus_v_gd.sort()
dw_con_movimento_caus_v_gd.setredraw(TRUE)
end event

type tabpage_art from userobject within tab_1
integer x = 15
integer y = 90
integer width = 2896
integer height = 1418
long backcolor = 79741120
string text = "Articolo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_dummy dw_dummy
st_1 st_1
dw_con_movimento_art_gd dw_con_movimento_art_gd
st_2 st_2
dw_v_con_movimento_art_gd dw_v_con_movimento_art_gd
end type

on tabpage_art.create
this.dw_dummy=create dw_dummy
this.st_1=create st_1
this.dw_con_movimento_art_gd=create dw_con_movimento_art_gd
this.st_2=create st_2
this.dw_v_con_movimento_art_gd=create dw_v_con_movimento_art_gd
this.Control[]={this.dw_dummy,&
this.st_1,&
this.dw_con_movimento_art_gd,&
this.st_2,&
this.dw_v_con_movimento_art_gd}
end on

on tabpage_art.destroy
destroy(this.dw_dummy)
destroy(this.st_1)
destroy(this.dw_con_movimento_art_gd)
destroy(this.st_2)
destroy(this.dw_v_con_movimento_art_gd)
end on

type dw_dummy from u_dw_master_main within tabpage_art
boolean visible = false
integer x = 1719
integer y = 477
integer width = 870
integer height = 141
integer taborder = 12
boolean enabled = false
string dataobject = "d_azienda_dummy_ff"
end type

event ue_init;call super::ue_init;iudw_children[1] = tab_1.tabpage_1.dw_con_movimento_caus_a_gd
iudw_children[2] = tab_1.tabpage_1.dw_con_movimento_caus_v_gd
iudw_children[3] = tab_1.tabpage_art.dw_con_movimento_art_gd
iudw_children[4] = tab_1.tabpage_art.dw_v_con_movimento_art_gd
iudw_children[5] = tab_1.tabpage_ccart.dw_con_movimento_ccart_gd
iudw_children[6] = tab_1.tabpage_ccart.dw_v_con_movimento_ccart_gd
iudw_children[7] = tab_1.tabpage_sc.dw_con_movimento_sc_gd
iudw_children[8] = tab_1.tabpage_sc.dw_v_con_movimento_sc_gd
iudw_children[9] = tab_1.tabpage_ccsc.dw_con_movimento_ccsc_gd
iudw_children[10] = tab_1.tabpage_ccsc.dw_v_con_movimento_ccsc_gd

end event

type st_1 from statictext within tabpage_art
integer x = 26
integer y = 16
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Acquisti"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_con_movimento_art_gd from u_dw_master_main within tabpage_art
integer x = 26
integer y = 96
integer width = 2834
integer height = 570
integer taborder = 10
string dataobject = "d_con_movimento_art_gd"
boolean vscrollbar = true
end type

event constructor;call super::constructor;string		ls_sql_cond, ls_sql



ls_sql_cond = "con_movimento.applicazione = 'A'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'c_articolo_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_articolo_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'A')
return 0

end event

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "c_articolo_cod"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
	CASE "c_articolo_des"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "c_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_des", is_ricpar.s_ausil_value[1])
	CASE "c_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_con_movimento_art_gd.rowcount()
dw_con_movimento_art_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "c_articolo_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_art_gd.getitemstring(1,"c_articolo_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_con_movimento_art_gd.getitemstring(ll_totrows,"c_articolo_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_art_gd.setsort("c_articolo_cod D")
			else 
				dw_con_movimento_art_gd.setsort("c_articolo_cod A")
			end if
		end if
		
	CASE "c_articolo_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_art_gd.getitemstring(1,"c_articolo_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_art_gd.getitemstring(ll_totrows,"c_articolo_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_art_gd.setsort("c_articolo_des D")
			else 
				dw_con_movimento_art_gd.setsort("c_articolo_des A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_art_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_con_movimento_art_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_art_gd.setsort("c_conto_cod D")
			else 
				dw_con_movimento_art_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_con_movimento_art_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_art_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_art_gd.setsort("c_conto_des D")
			else 
				dw_con_movimento_art_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_con_movimento_art_gd.sort()
dw_con_movimento_art_gd.setredraw(TRUE)
end event

type st_2 from statictext within tabpage_art
integer x = 26
integer y = 714
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Vendite"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_v_con_movimento_art_gd from u_dw_master_main within tabpage_art
integer x = 26
integer y = 797
integer width = 2834
integer height = 579
integer taborder = 12
string dataobject = "d_con_movimento_art_gd"
boolean vscrollbar = true
end type

event constructor;call super::constructor;string		ls_sql_cond, ls_sql

ls_sql_cond = "con_movimento.applicazione = 'V'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'c_articolo_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_articolo_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_articolo"
		ls_dwc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "articolo", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'V')
return 0

end event

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "c_articolo_cod"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
	CASE "c_articolo_des"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "c_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_des", is_ricpar.s_ausil_value[1])
	CASE "c_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_v_con_movimento_art_gd.rowcount()
dw_v_con_movimento_art_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "c_articolo_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_art_gd.getitemstring(1,"c_articolo_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_v_con_movimento_art_gd.getitemstring(ll_totrows,"c_articolo_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_art_gd.setsort("c_articolo_cod D")
			else 
				dw_v_con_movimento_art_gd.setsort("c_articolo_cod A")
			end if
		end if
		
	CASE "c_articolo_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_art_gd.getitemstring(1,"c_articolo_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_v_con_movimento_art_gd.getitemstring(ll_totrows,"c_articolo_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_art_gd.setsort("c_articolo_des D")
			else 
				dw_v_con_movimento_art_gd.setsort("c_articolo_des A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_art_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_v_con_movimento_art_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_art_gd.setsort("c_conto_cod D")
			else 
				dw_v_con_movimento_art_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_v_con_movimento_art_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_v_con_movimento_art_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_art_gd.setsort("c_conto_des D")
			else 
				dw_v_con_movimento_art_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_v_con_movimento_art_gd.sort()
dw_v_con_movimento_art_gd.setredraw(TRUE)
end event

type tabpage_ccart from userobject within tab_1
integer x = 15
integer y = 90
integer width = 2896
integer height = 1418
long backcolor = 79741120
string text = "Categoria Commerciale Articolo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_con_movimento_ccart_gd dw_con_movimento_ccart_gd
dw_v_con_movimento_ccart_gd dw_v_con_movimento_ccart_gd
st_3 st_3
st_4 st_4
end type

on tabpage_ccart.create
this.dw_con_movimento_ccart_gd=create dw_con_movimento_ccart_gd
this.dw_v_con_movimento_ccart_gd=create dw_v_con_movimento_ccart_gd
this.st_3=create st_3
this.st_4=create st_4
this.Control[]={this.dw_con_movimento_ccart_gd,&
this.dw_v_con_movimento_ccart_gd,&
this.st_3,&
this.st_4}
end on

on tabpage_ccart.destroy
destroy(this.dw_con_movimento_ccart_gd)
destroy(this.dw_v_con_movimento_ccart_gd)
destroy(this.st_3)
destroy(this.st_4)
end on

type dw_con_movimento_ccart_gd from u_dw_master_main within tabpage_ccart
integer x = 26
integer y = 96
integer width = 2834
integer height = 579
integer taborder = 1
string dataobject = "d_con_movimento_ccart_gd"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'c_cat_articolo_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_cat_com_articolo"
		ls_dwc[1] = "id_cat_com_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_cat_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_cat_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_com_articolo", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_cat_articolo_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_cat_com_articolo"
		ls_dwc[1] = "id_cat_com_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_cat_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_cat_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_com_articolo", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "c_cat_articolo_cod"
		is_search_window = "w_cat_com_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_cat_articolo_des"
		is_search_window = "w_cat_com_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "c_cat_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cat_com_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_cat_articolo_des", is_ricpar.s_ausil_value[1])
	CASE "c_cat_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cat_com_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_cat_articolo_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'A')
return 0

end event

event constructor;call super::constructor;string		ls_sql_cond, ls_sql


ls_sql_cond = "con_movimento.applicazione = 'A'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_con_movimento_ccart_gd.rowcount()
dw_con_movimento_ccart_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "c_cat_articolo_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_ccart_gd.getitemstring(1,"c_cat_articolo_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_con_movimento_ccart_gd.getitemstring(ll_totrows,"c_cat_articolo_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_ccart_gd.setsort("c_cat_articolo_cod D")
			else 
				dw_con_movimento_ccart_gd.setsort("c_cat_articolo_cod A")
			end if
		end if
		
	CASE "c_cat_articolo_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_ccart_gd.getitemstring(1,"c_cat_articolo_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_ccart_gd.getitemstring(ll_totrows,"c_cat_articolo_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_ccart_gd.setsort("c_cat_articolo_des D")
			else 
				dw_con_movimento_ccart_gd.setsort("c_cat_articolo_des A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_ccart_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_con_movimento_ccart_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_ccart_gd.setsort("c_conto_cod D")
			else 
				dw_con_movimento_ccart_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_con_movimento_ccart_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_ccart_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_ccart_gd.setsort("c_conto_des D")
			else 
				dw_con_movimento_ccart_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_con_movimento_ccart_gd.sort()
dw_con_movimento_ccart_gd.setredraw(true)
end event

type dw_v_con_movimento_ccart_gd from u_dw_master_main within tabpage_ccart
integer x = 26
integer y = 797
integer width = 2834
integer height = 579
integer taborder = 3
string dataobject = "d_con_movimento_ccart_gd"
boolean vscrollbar = true
end type

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'V')
return 0

end event

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'c_cat_articolo_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_cat_com_articolo"
		ls_dwc[1] = "id_cat_com_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_cat_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_cat_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_com_articolo", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_cat_articolo_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_cat_com_articolo"
		ls_dwc[1] = "id_cat_com_articolo"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_cat_articolo_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_cat_articolo_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_com_articolo", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "c_cat_articolo_cod"
		is_search_window = "w_cat_com_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_cat_articolo_des"
		is_search_window = "w_cat_com_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "c_cat_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cat_com_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_cat_articolo_des", is_ricpar.s_ausil_value[1])
	CASE "c_cat_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cat_com_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_cat_articolo_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event constructor;call super::constructor;string		ls_sql_cond, ls_sql


ls_sql_cond = "con_movimento.applicazione = 'V'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_v_con_movimento_ccart_gd.rowcount()
dw_v_con_movimento_ccart_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "c_cat_articolo_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_ccart_gd.getitemstring(1,"c_cat_articolo_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_v_con_movimento_ccart_gd.getitemstring(ll_totrows,"c_cat_articolo_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_ccart_gd.setsort("c_cat_articolo_cod D")
			else 
				dw_v_con_movimento_ccart_gd.setsort("c_cat_articolo_cod A")
			end if
		end if
		
	CASE "c_cat_articolo_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_ccart_gd.getitemstring(1,"c_cat_articolo_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_v_con_movimento_ccart_gd.getitemstring(ll_totrows,"c_cat_articolo_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_ccart_gd.setsort("c_cat_articolo_des D")
			else 
				dw_v_con_movimento_ccart_gd.setsort("c_cat_articolo_des A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_ccart_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_v_con_movimento_ccart_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_ccart_gd.setsort("c_conto_cod D")
			else 
				dw_v_con_movimento_ccart_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_v_con_movimento_ccart_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_v_con_movimento_ccart_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_ccart_gd.setsort("c_conto_des D")
			else 
				dw_v_con_movimento_ccart_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_v_con_movimento_ccart_gd.sort()
dw_v_con_movimento_ccart_gd.setredraw(TRUE)
end event

type st_3 from statictext within tabpage_ccart
integer x = 26
integer y = 16
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Acquisti"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_ccart
integer x = 26
integer y = 717
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Vendite"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type tabpage_sc from userobject within tab_1
integer x = 15
integer y = 90
integer width = 2896
integer height = 1418
long backcolor = 79741120
string text = "Soggetto Commerciale"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_con_movimento_sc_gd dw_con_movimento_sc_gd
dw_v_con_movimento_sc_gd dw_v_con_movimento_sc_gd
st_5 st_5
st_6 st_6
end type

on tabpage_sc.create
this.dw_con_movimento_sc_gd=create dw_con_movimento_sc_gd
this.dw_v_con_movimento_sc_gd=create dw_v_con_movimento_sc_gd
this.st_5=create st_5
this.st_6=create st_6
this.Control[]={this.dw_con_movimento_sc_gd,&
this.dw_v_con_movimento_sc_gd,&
this.st_5,&
this.st_6}
end on

on tabpage_sc.destroy
destroy(this.dw_con_movimento_sc_gd)
destroy(this.dw_v_con_movimento_sc_gd)
destroy(this.st_5)
destroy(this.st_6)
end on

type dw_con_movimento_sc_gd from u_dw_master_main within tabpage_sc
integer x = 26
integer y = 96
integer width = 2834
integer height = 579
string dataobject = "d_con_movimento_sc_gd"
boolean vscrollbar = true
end type

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'c_sc_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sc_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sc_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)

		
		wf_ver_sog_commerciale(data)

		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
			
	CASE 'c_sc_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sc_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sc_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "c_sc_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_sc_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;
string ls_codice
long ll_row

CHOOSE CASE as_nomecol

	CASE "c_sc_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sc_des", is_ricpar.s_ausil_value[1])
		
		
		ll_row = getrow()
		ls_codice = getitemstring(ll_row, "c_sc_cod")
		wf_ver_sog_commerciale(ls_codice)

	CASE "c_sc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sc_cod", is_ricpar.s_ausil_value[1])

		
		ll_row = getrow()
		ls_codice = getitemstring(ll_row, "c_sc_cod")
		wf_ver_sog_commerciale(ls_codice)

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'A')
return 0

end event

event constructor;call super::constructor;string		ls_sql_cond, ls_sql


ls_sql_cond = "con_movimento.applicazione = 'A'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_con_movimento_sc_gd.rowcount()
dw_con_movimento_sc_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "c_sc_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_sc_gd.getitemstring(1,"c_sc_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_con_movimento_sc_gd.getitemstring(ll_totrows,"c_sc_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_sc_gd.setsort("c_sc_cod D")
			else 
				dw_con_movimento_sc_gd.setsort("c_sc_cod A")
			end if
		end if
		
	CASE "c_sc_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_sc_gd.getitemstring(1,"c_sc_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_sc_gd.getitemstring(ll_totrows,"c_sc_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_sc_gd.setsort("c_sc_des D")
			else 
				dw_con_movimento_sc_gd.setsort("c_sc_des A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_sc_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_con_movimento_sc_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_sc_gd.setsort("c_conto_cod D")
			else 
				dw_con_movimento_sc_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_con_movimento_sc_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_sc_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_sc_gd.setsort("c_conto_des D")
			else 
				dw_con_movimento_sc_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_con_movimento_sc_gd.sort()
dw_con_movimento_sc_gd.setredraw(TRUE)
end event

type dw_v_con_movimento_sc_gd from u_dw_master_main within tabpage_sc
integer x = 26
integer y = 797
integer width = 2834
integer height = 579
integer taborder = 3
string dataobject = "d_con_movimento_sc_gd"
boolean vscrollbar = true
end type

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'V')
return 0

end event

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'c_sc_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sc_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sc_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
										
		
		wf_ver_sog_commerciale(data)

		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_sc_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_sc_cod"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "c_sc_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "c_sc_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_sc_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;

string ls_codice
long ll_row

CHOOSE CASE as_nomecol

	CASE "c_sc_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sc_des", is_ricpar.s_ausil_value[1])
		
		
		ll_row = getrow()
		ls_codice = getitemstring(ll_row, "c_sc_cod")
		wf_ver_sog_commerciale(ls_codice)

	CASE "c_sc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sc_cod", is_ricpar.s_ausil_value[1])

		
		ll_row = getrow()
		ls_codice = getitemstring(ll_row, "c_sc_cod")
		wf_ver_sog_commerciale(ls_codice)

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event constructor;call super::constructor;string		ls_sql_cond, ls_sql


ls_sql_cond = "con_movimento.applicazione = 'V'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_v_con_movimento_sc_gd.rowcount()
dw_v_con_movimento_sc_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "c_sc_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_sc_gd.getitemstring(1,"c_sc_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_v_con_movimento_sc_gd.getitemstring(ll_totrows,"c_sc_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_sc_gd.setsort("c_sc_cod D")
			else 
				dw_v_con_movimento_sc_gd.setsort("c_sc_cod A")
			end if
		end if
		
	CASE "c_sc_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_sc_gd.getitemstring(1,"c_sc_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_v_con_movimento_sc_gd.getitemstring(ll_totrows,"c_sc_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_sc_gd.setsort("c_sc_des D")
			else 
				dw_v_con_movimento_sc_gd.setsort("c_sc_des A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_sc_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_v_con_movimento_sc_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_sc_gd.setsort("c_conto_cod D")
			else 
				dw_v_con_movimento_sc_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_v_con_movimento_sc_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_v_con_movimento_sc_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_sc_gd.setsort("c_conto_des D")
			else 
				dw_v_con_movimento_sc_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_v_con_movimento_sc_gd.sort()
dw_v_con_movimento_sc_gd.setredraw(TRUE)
end event

type st_5 from statictext within tabpage_sc
integer x = 26
integer y = 16
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Acquisti"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_sc
integer x = 26
integer y = 714
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Vendite"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type tabpage_ccsc from userobject within tab_1
integer x = 15
integer y = 90
integer width = 2896
integer height = 1418
long backcolor = 79741120
string text = "Categoria Soggetto Commerciale"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_con_movimento_ccsc_gd dw_con_movimento_ccsc_gd
dw_v_con_movimento_ccsc_gd dw_v_con_movimento_ccsc_gd
st_7 st_7
st_8 st_8
end type

on tabpage_ccsc.create
this.dw_con_movimento_ccsc_gd=create dw_con_movimento_ccsc_gd
this.dw_v_con_movimento_ccsc_gd=create dw_v_con_movimento_ccsc_gd
this.st_7=create st_7
this.st_8=create st_8
this.Control[]={this.dw_con_movimento_ccsc_gd,&
this.dw_v_con_movimento_ccsc_gd,&
this.st_7,&
this.st_8}
end on

on tabpage_ccsc.destroy
destroy(this.dw_con_movimento_ccsc_gd)
destroy(this.dw_v_con_movimento_ccsc_gd)
destroy(this.st_7)
destroy(this.st_8)
end on

type dw_con_movimento_ccsc_gd from u_dw_master_main within tabpage_ccsc
integer x = 26
integer y = 96
integer width = 2834
integer height = 579
integer taborder = 1
string dataobject = "d_con_movimento_ccsc_gd"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'c_cat_sc_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_cat_com_sc"
		ls_dwc[1] = "id_cat_com_sc"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_cat_sc_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_cat_sc_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_com_sc", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_cat_sc_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_cat_com_sc"
		ls_dwc[1] = "id_cat_com_sc"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_cat_sc_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_cat_sc_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_com_sc", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "c_cat_sc_cod"
		is_search_window = "w_cat_com_sc_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_cat_sc_des"
		is_search_window = "w_cat_com_sc_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)
	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "c_cat_sc_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cat_com_sc", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_cat_sc_des", is_ricpar.s_ausil_value[1])
	CASE "c_cat_sc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cat_com_sc", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_cat_sc_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'A')
return 0

end event

event constructor;call super::constructor;string		ls_sql_cond, ls_sql


ls_sql_cond = "con_movimento.applicazione = 'A'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_con_movimento_ccsc_gd.rowcount()
dw_con_movimento_ccsc_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "c_cat_sc_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_ccsc_gd.getitemstring(1,"c_cat_sc_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_con_movimento_ccsc_gd.getitemstring(ll_totrows,"c_cat_sc_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_ccsc_gd.setsort("c_cat_sc_cod D")
			else 
				dw_con_movimento_ccsc_gd.setsort("c_cat_sc_cod A")
			end if
		end if
		
	CASE "c_cat_sc_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_ccsc_gd.getitemstring(1,"c_cat_sc_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_ccsc_gd.getitemstring(ll_totrows,"c_cat_sc_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_ccsc_gd.setsort("c_cat_sc_des D")
			else 
				dw_con_movimento_ccsc_gd.setsort("c_cat_sc_des A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_con_movimento_ccsc_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_con_movimento_ccsc_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_ccsc_gd.setsort("c_conto_cod D")
			else 
				dw_con_movimento_ccsc_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_con_movimento_ccsc_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_con_movimento_ccsc_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_con_movimento_ccsc_gd.setsort("c_conto_des D")
			else 
				dw_con_movimento_ccsc_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_con_movimento_ccsc_gd.sort()
dw_con_movimento_ccsc_gd.setredraw(true)
end event

type dw_v_con_movimento_ccsc_gd from u_dw_master_main within tabpage_ccsc
integer x = 26
integer y = 794
integer width = 2834
integer height = 579
integer taborder = 3
string dataobject = "d_con_movimento_ccsc_gd"
boolean vscrollbar = true
end type

event ue_validate_row;call super::ue_validate_row;SetItem(al_row,"applicazione",'V')
return 0

end event

event itemchanged;call super::itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'c_cat_sc_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_cat_com_sc"
		ls_dwc[1] = "id_cat_com_sc"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_cat_sc_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_cat_sc_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_com_sc", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_cat_sc_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_cat_com_sc"
		ls_dwc[1] = "id_cat_com_sc"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_cat_sc_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_cat_sc_des"
		ll_ok = uf_autofind_col(dwo.Name, "cat_com_sc", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_cod'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'c_conto_des'
		ls_sql_cond = ""  
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "c_conto_cod"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_conto_des"
		ll_ok = uf_autofind_col(dwo.Name, "conto_azienda", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
END CHOOSE


end event

event ue_set_search;call super::ue_set_search;long		ll_id_azienda, ll_row

ll_row=GetRow()
ll_id_azienda= GetItemNumber(ll_row,"id_azienda")
If IsNull(ll_id_azienda) then ll_id_azienda = 1
CHOOSE CASE as_nomecol

	CASE "c_cat_sc_cod"
		is_search_window = "w_cat_com_sc_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
	CASE "c_cat_sc_des"
		is_search_window = "w_cat_com_sc_coddes_sw"
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
	
	CASE "c_conto_cod"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)

	CASE "c_conto_des"
		is_search_window = "w_conto_azienda_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
		is_ricpar.s_sql_cond  = "conto_azienda.id_azienda =" + String(ll_id_azienda)
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "c_cat_sc_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cat_com_sc", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_cat_sc_des", is_ricpar.s_ausil_value[1])
	CASE "c_cat_sc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_cat_com_sc", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_cat_sc_cod", is_ricpar.s_ausil_value[1])

	CASE "c_conto_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_des", is_ricpar.s_ausil_value[1])
	CASE "c_conto_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_conto_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event constructor;call super::constructor;string		ls_sql_cond, ls_sql


ls_sql_cond = "con_movimento.applicazione = 'V'"

iu_scan.f_add_where_condition(ls_sql_cond)
ls_sql = iu_scan.f_getcurrent()
this.object.datawindow.table.select = ls_sql


end event

event doubleclicked;call super::doubleclicked;

string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_v_con_movimento_ccsc_gd.rowcount()
dw_v_con_movimento_ccsc_gd.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "c_cat_sc_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_ccsc_gd.getitemstring(1,"c_cat_sc_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_v_con_movimento_ccsc_gd.getitemstring(ll_totrows,"c_cat_sc_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_ccsc_gd.setsort("c_cat_sc_cod D")
			else 
				dw_v_con_movimento_ccsc_gd.setsort("c_cat_sc_cod A")
			end if
		end if
		
	CASE "c_cat_sc_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_ccsc_gd.getitemstring(1,"c_cat_sc_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_v_con_movimento_ccsc_gd.getitemstring(ll_totrows,"c_cat_sc_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_ccsc_gd.setsort("c_cat_sc_des D")
			else 
				dw_v_con_movimento_ccsc_gd.setsort("c_cat_sc_des A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_v_con_movimento_ccsc_gd.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_v_con_movimento_ccsc_gd.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_ccsc_gd.setsort("c_conto_cod D")
			else 
				dw_v_con_movimento_ccsc_gd.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_v_con_movimento_ccsc_gd.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_v_con_movimento_ccsc_gd.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_v_con_movimento_ccsc_gd.setsort("c_conto_des D")
			else 
				dw_v_con_movimento_ccsc_gd.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_v_con_movimento_ccsc_gd.sort()
dw_v_con_movimento_ccsc_gd.setredraw(TRUE)
end event

type st_7 from statictext within tabpage_ccsc
integer x = 26
integer y = 16
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Acquisti"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_8 from statictext within tabpage_ccsc
integer x = 26
integer y = 714
integer width = 2834
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Vendite"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

