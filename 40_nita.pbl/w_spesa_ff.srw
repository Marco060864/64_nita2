forward
global type w_spesa_ff from w_p_data
end type
type dw_spesa_ff from u_dw_master_main within w_spesa_ff
end type
type dw_riga_spesa_gd from u_dw_master_main within w_spesa_ff
end type
end forward

global type w_spesa_ff from w_p_data
int Width=2459
int Height=1392
boolean TitleBar=true
string Title="Spese"
dw_spesa_ff dw_spesa_ff
dw_riga_spesa_gd dw_riga_spesa_gd
end type
global w_spesa_ff w_spesa_ff

on w_spesa_ff.create
int iCurrent
call super::create
this.dw_spesa_ff=create dw_spesa_ff
this.dw_riga_spesa_gd=create dw_riga_spesa_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_spesa_ff
this.Control[iCurrent+2]=this.dw_riga_spesa_gd
end on

on w_spesa_ff.destroy
call super::destroy
destroy(this.dw_spesa_ff)
destroy(this.dw_riga_spesa_gd)
end on

event open;call super::open;
il_HelpTopic = 388

idw_master = dw_spesa_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "spesa.id_spesa"

if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_spesa"
	idw_master.is_list.s_modo=modo_inserisci
end if

end event

event ue_post_open;call super::ue_post_open;
long			ll_id_valuta
dwobject		my_dwo

ll_id_valuta = dw_spesa_ff.getitemnumber(1, "spesa_id_valuta")

if (isnull(ll_id_valuta)) then
	SELECT id_valuta
	INTO	 :ll_id_valuta
	FROM	 par_sistema
	;
	
	if (sqlca.sqlcode = -1) then
		messagebox("DbError", sqlca.sqlerrtext)
	end if
	
	if (ll_id_valuta > 0) then
		dw_spesa_ff.setitem(1, "spesa_id_valuta", ll_id_valuta)
		my_dwo = dw_spesa_ff.object.spesa_id_valuta
		dw_spesa_ff.event itemchanged(1, my_dwo, string(ll_id_valuta))	
	end if
end if
end event

type p_crescente from w_p_data`p_crescente within w_spesa_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_spesa_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_spesa_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_spesa_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_spesa_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_spesa_ff
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_spesa_ff
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_spesa_ff
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_spesa_ff
int X=46
int Y=1040
int Width=229
int Height=60
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=192
end type

type cb_ricerca from w_p_data`cb_ricerca within w_spesa_ff
boolean BringToTop=true
end type

type dw_spesa_ff from u_dw_master_main within w_spesa_ff
int X=37
int Y=160
int Width=2382
int Height=648
int TabOrder=10
string DataObject="d_spesa_ff"
end type

event ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "conto_a_codice"
		is_search_window = "w_conto_sw" 
		
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "conto_a_descrizione"
		is_search_window = "w_conto_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
			
	CASE "conto_b_codice"
		is_search_window = "w_conto_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_codice" 
	CASE "conto_b_descrizione"
		is_search_window = "w_conto_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "conto_descrizione" 
			
END CHOOSE

CHOOSE CASE as_nomecol
		
	CASE "id_tab_iva"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tab_iva_gd"
		is_ricpar.s_titolo_finestra = "Tabella IVA"
		is_ricpar.i_width = 2913
		is_ricpar.i_height = 873

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	
	CASE "conto_a_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_acquisti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_a_descrizione", is_ricpar.s_ausil_value[1])
	CASE "conto_a_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_acquisti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_a_codice", is_ricpar.s_ausil_value[1])

	CASE "conto_b_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_vendite", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_b_descrizione", is_ricpar.s_ausil_value[1])
	CASE "conto_b_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto_vendite", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_b_codice", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_id_anagrafica,ll_value
integer   li_rows, li_i		
string	 ls_valu_edit  

ls_sql_cond = ""  
CHOOSE CASE dwo.name

	CASE 'tipo_importo'
		
		integer  li_found
		long		ll_id_spesa
		string	ls_codice
		ll_id_spesa = this.getitemnumber(1, "id_spesa")		
		
		if (data = 'F') then
			
			li_found = 0
			SELECT s.codice, 1
			INTO	 :ls_codice, :li_found
			FROM	 spesa_sog_commerciale ss, sog_commerciale s
			WHERE  ss.id_spesa = :ll_id_spesa
			AND	 ss.percentuale > 0
			AND	 s.id_sog_commerciale = ss.id_sog_commerciale;
			if (li_found > 0) then
				messagebox("Attenzione", "Con tipo importo 'Fisso' i valori in percentuale non sono validi.~nVerificare le spese del Sogg. Commerciale "+ls_codice)
			end if
			
			li_rows = dw_riga_spesa_gd.rowcount()
			if (li_rows > 0) then
				for li_i = 1 to li_rows
					dw_riga_spesa_gd.setitem(li_i, "c_tipo_importo", data)
				next
			end if
		else
		
		
			
			li_found = 0
			SELECT s.codice, 1
			INTO	 :ls_codice, :li_found
			FROM	 spesa_sog_commerciale ss, sog_commerciale s
			WHERE  ss.id_spesa = :ll_id_spesa
			AND	 ss.importo > 0
			AND	 s.id_sog_commerciale = ss.id_sog_commerciale;
			if (li_found > 0) then
				messagebox("Attenzione", "Con tipo importo 'Percentuale' i valori ad importo non sono validi.~nVerificare le spese del Sogg. Commerciale "+ls_codice)
			end if
			
			li_rows = dw_riga_spesa_gd.rowcount()
			if (li_rows > 0) then
				for li_i = 1 to li_rows
					dw_riga_spesa_gd.setitem(li_i, "c_tipo_importo", data)
				next
			end if
		end if
	
	
CASE 'conto_a_codice'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_acquisti"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "conto_a_codice"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "conto_a_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'conto_a_descrizione'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_acquisti"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "conto_a_codice"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "conto_a_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	
	CASE 'conto_b_codice'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_vendite"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "conto_b_codice"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "conto_b_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'conto_b_descrizione'
		ls_sql_cond = ""  
		ls_dbc[1]  = "id_conto"
		ls_dwc[1]  = "id_conto_vendite"
		ls_dbc[2]  = "codice"
		ls_dwc[2]  = "conto_b_codice"
		ls_dbc[3]  = "descrizione"
		ls_dwc[3]  = "conto_b_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE 'spesa_id_valuta'
		li_rows = dw_riga_spesa_gd.rowcount()
		if (li_rows > 0) then
			for li_i = 1 to li_rows
				dw_riga_spesa_gd.setitem(li_i, "spesa_id_valuta", long(data))
			next
		end if	
		ls_valu_edit = f_valu_edit(long(data))
		dw_riga_spesa_gd.modify("importo.edit.format ='" + ls_valu_edit + "'")
		dw_riga_spesa_gd.modify("da_imponibile.edit.format ='" + ls_valu_edit + "'")
		dw_riga_spesa_gd.modify("a_imponibile.edit.format ='" + ls_valu_edit + "'")
	
END CHOOSE


end event

event ue_init;call super::ue_init;is_title = "Spese"
is_list.s_identifica[1] = "id_spesa"
iudw_children[1] = dw_riga_spesa_gd
end event

event ue_update;call super::ue_update;


end event

event ue_initial;call super::ue_initial;
end event

type dw_riga_spesa_gd from u_dw_master_main within w_spesa_ff
int X=32
int Y=832
int Width=2386
int Height=452
int TabOrder=12
boolean BringToTop=true
string DataObject="d_riga_spesa_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_spesa"


end event

event ue_initial;call super::ue_initial;
this.setitem(this.getrow(), "c_tipo_importo", dw_spesa_ff.getitemstring(1, "tipo_importo"))
this.setitem(this.getrow(), "spesa_id_valuta", dw_spesa_ff.getitemnumber(1, "spesa_id_valuta"))
end event

event dberror;call super::dberror;
end event

