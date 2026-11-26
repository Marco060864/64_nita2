forward
global type w_localita_ff from w_p_data
end type
type dw_localita_ff from u_dw_master_main within w_localita_ff
end type
end forward

global type w_localita_ff from w_p_data
int Width=2099
int Height=849
boolean TitleBar=true
string Title="Località"
dw_localita_ff dw_localita_ff
end type
global w_localita_ff w_localita_ff

on w_localita_ff.create
int iCurrent
call w_p_data::create
this.dw_localita_ff=create dw_localita_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_localita_ff
end on

on w_localita_ff.destroy
call w_p_data::destroy
destroy(this.dw_localita_ff)
end on

event open;call super::open;idw_master = dw_localita_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_localita"
end event

type p_crescente from w_p_data`p_crescente within w_localita_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_localita_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_localita_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_localita_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_localita_ff
int X=641
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_localita_ff
int X=1166
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_localita_ff
int X=1463
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_localita_ff
int X=1761
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_localita_ff
int Y=801
int Width=481
int Height=81
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=444
end type

type dw_localita_ff from u_dw_master_main within w_localita_ff
int X=46
int Y=161
int Width=1989
int Height=561
int TabOrder=1
string DataObject="d_localita_ff"
end type

event ue_init;call super::ue_init;is_title = "Località"
end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol

	CASE "nazione_codice"
		is_search_window = "w_nazione_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
	CASE "nazione_descrizione"
		is_search_window = "w_nazione_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
		
	CASE "nazione_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_nazione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("nazione_descrizione", is_ricpar.s_ausil_value[1])
		
	CASE "nazione_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_nazione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("nazione_codice", is_ricpar.s_ausil_value[1])
		
END CHOOSE

end event

event itemchanged;call super::itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""

CHOOSE CASE dwo.name

	CASE "nazione_codice"
		ls_dbc[1] = "id_nazione"
		ls_dwc[1] = "id_nazione"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "nazione_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "nazione_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "nazione", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'nazione_descrizione'
		ls_dbc[1] = "id_nazione"
		ls_dwc[1] = "id_nazione"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "nazione_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "nazione_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "nazione", &
										"descrizione", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

END CHOOSE

end event

