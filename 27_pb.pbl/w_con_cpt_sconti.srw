forward
global type w_con_cpt_sconti from w_p_data
end type
type dw_sconti from u_dw_master_main within tabpage_1
end type
type dw_sconti from u_dw_master_main within tabpage_1
end type
end forward

global type w_con_cpt_sconti from w_p_data
int Width=3845
int Height=1560
boolean TitleBar=true
string Title="Gestione Contropartite per Sconti e Omaggi"
end type
global w_con_cpt_sconti w_con_cpt_sconti

on w_con_cpt_sconti.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_con_cpt_sconti.destroy
call super::destroy
end on

event open;call super::open;
idw_master = tab_1.tabpage_1.dw_sconti
idw_master.is_list = Message.PowerObjectParm


idw_master.retrieve()

end event

type p_crescente from w_p_data`p_crescente within w_con_cpt_sconti
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_con_cpt_sconti
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_con_cpt_sconti
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_con_cpt_sconti
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_con_cpt_sconti
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_con_cpt_sconti
int X=2944
boolean BringToTop=true
end type

event cb_inserisci::clicked;call super::clicked;tab_1.tabpage_1.dw_sconti.insertrow(0)
end event

type cb_cancella from w_p_data`cb_cancella within w_con_cpt_sconti
int X=3241
boolean BringToTop=true
end type

event cb_cancella::clicked;call super::clicked;long ll_row

ll_row = tab_1.tabpage_1.dw_sconti.getrow()
tab_1.tabpage_1.dw_sconti.deleterow(ll_row)
end event

type cb_salva from w_p_data`cb_salva within w_con_cpt_sconti
int X=3538
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_con_cpt_sconti
int X=27
int Y=160
int Width=3781
int Height=1296
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=3744
int Height=1176
long BackColor=79741120
string Text="Tipologia Sconti"
long TabBackColor=79741120
dw_sconti dw_sconti
end type

on tabpage_1.create
this.dw_sconti=create dw_sconti
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sconti
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_sconti)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_con_cpt_sconti
int X=2647
boolean Visible=false
boolean BringToTop=true
end type

type dw_sconti from u_dw_master_main within tabpage_1
int X=9
int Y=36
int Width=3726
int Height=1132
int TabOrder=30
boolean BringToTop=true
string DataObject="d_con_cpt_sconti"
boolean HScrollBar=true
boolean VScrollBar=true
end type

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
		
	CASE "c_art_cod"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
		
	CASE "c_art_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"		

END CHOOSE

end event

event ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "c_sc_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sc_des", is_ricpar.s_ausil_value[1])

	CASE "c_sc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sc_cod", is_ricpar.s_ausil_value[1])

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
		
	case "c_art_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("c_art_des",is_ricpar.s_ausil_value[1])

	case "c_art_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("c_art_cod",is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok
integer   li_ok

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
		
	CASE "c_art_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_articolo"		
		
		ls_dwc[1] = "c_art_cod"
		ls_dwc[2] = "c_art_des"
		ls_dwc[3] = "id_articolo"				
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	CASE "c_art_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_articolo"				
		
		ls_dwc[1] = "c_art_cod"
		ls_dwc[2] = "c_art_des"
		ls_dwc[3] = "id_articolo"				
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)

END CHOOSE


end event

event doubleclicked;call super::doubleclicked;string ls_name, ls_row1, ls_row2
long ll_row, ll_totrows

ls_name = dwo.name  

ll_totrows = dw_sconti.rowcount()
dw_sconti.setredraw(FALSE)

CHOOSE CASE ls_name
	CASE "c_cat_sc_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_sconti.getitemstring(1,"c_cat_sc_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_sconti.getitemstring(ll_totrows,"c_cat_sc_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_sconti.setsort("c_cat_sc_cod D")
			else 
				dw_sconti.setsort("c_cat_sc_cod A")
			end if
		end if
		
	CASE "c_cat_sc_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_sconti.getitemstring(1,"c_cat_sc_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_sconti.getitemstring(ll_totrows,"c_cat_sc_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_sconti.setsort("c_cat_sc_des D")
			else 
				dw_sconti.setsort("c_cat_sc_des A")
			end if
		end if		
		
	CASE "c_sc_cod_t"
		
		if ll_totrows > 0 then
			ls_row1 = dw_sconti.getitemstring(1,"c_sc_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
	      ls_row2 = dw_sconti.getitemstring(ll_totrows,"c_sc_cod")
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
						
			if ls_row1 <= ls_row2 then 
				dw_sconti.setsort("c_sc_cod D")
			else 
				dw_sconti.setsort("c_sc_cod A")
			end if
		end if
		
	CASE "c_sc_des_t"
		if ll_totrows > 0 then
			ls_row1 = dw_sconti.getitemstring(1,"c_sc_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_sconti.getitemstring(ll_totrows,"c_sc_des")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""				
				
			if ls_row1 <= ls_row2 then 
				dw_sconti.setsort("c_sc_des D")
			else 
				dw_sconti.setsort("c_sc_des A")
			end if
		end if
		
	CASE "c_conto_cod_t"
		if ll_totrows > 0 then
			ls_row1 = dw_sconti.getitemstring(1,"c_conto_cod")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_sconti.getitemstring(ll_totrows,"c_conto_cod")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_sconti.setsort("c_conto_cod D")
			else 
				dw_sconti.setsort("c_conto_cod A")
			end if		
		end if

	CASE "c_conto_des_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_sconti.getitemstring(1,"c_conto_des")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_sconti.getitemstring(ll_totrows,"c_conto_des")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_sconti.setsort("c_conto_des D")
			else 
				dw_sconti.setsort("c_conto_des A")
			end if				
		end if
		
END CHOOSE

dw_sconti.sort()
dw_sconti.setredraw(TRUE)
end event

event ue_insert;call super::ue_insert;this.insertrow(0)
end event

event ue_key;call super::ue_key;string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval
integer				li_cdw, li_size, li_i, li_ret
w_search_main		lw_sm
w_data_main			lw_win
w_mod_single_data lw_mw
w_p_data				lw_pwin
u_dw_main			lu_dw

long					ll_retv
integer li_row 
li_row = getrow()					
ll_retv = 0


choose case key
		
	case Keyadd!
		
		
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			ls_tipof = lw_win.is_wintype
			lu_dw = lw_win.idw_master
			choose case ls_tipof
				case "W_P_DATA"
					if this = lu_dw then
						if is_list.s_modo = modo_inserisci then 			
							if (event ue_update (0,0) = 0) then
								triggerevent("ue_insert")
							end if
							lu_dw.setFocus()
						end if
					else
						triggerevent("ue_insert")
					end if
				case else
					triggerevent("ue_insert")
			end choose
		end if
	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella.event trigger clicked()
		end if
end choose

return ll_retv


end event

