forward
global type w_articolo_prezzo_cx from w_p_data
end type
type dw_prezzo_articolo_prezzo_gd from u_dw_master_main within w_articolo_prezzo_cx
end type
type dw_articolo_prezzo_ff from u_dw_master_main within w_articolo_prezzo_cx
end type
end forward

global type w_articolo_prezzo_cx from w_p_data
int Width=2986
int Height=1297
boolean TitleBar=true
string Title="Prezzi degli Articoli"
dw_prezzo_articolo_prezzo_gd dw_prezzo_articolo_prezzo_gd
dw_articolo_prezzo_ff dw_articolo_prezzo_ff
end type
global w_articolo_prezzo_cx w_articolo_prezzo_cx

on w_articolo_prezzo_cx.create
int iCurrent
call w_p_data::create
this.dw_prezzo_articolo_prezzo_gd=create dw_prezzo_articolo_prezzo_gd
this.dw_articolo_prezzo_ff=create dw_articolo_prezzo_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_prezzo_articolo_prezzo_gd
this.Control[iCurrent+2]=dw_articolo_prezzo_ff
end on

on w_articolo_prezzo_cx.destroy
call w_p_data::destroy
destroy(this.dw_prezzo_articolo_prezzo_gd)
destroy(this.dw_articolo_prezzo_ff)
end on

event open;call super::open;idw_master = dw_articolo_prezzo_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "articolo.id_articolo"

end event

type p_crescente from w_p_data`p_crescente within w_articolo_prezzo_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_articolo_prezzo_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_articolo_prezzo_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_articolo_prezzo_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_articolo_prezzo_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_articolo_prezzo_cx
int X=2058
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_articolo_prezzo_cx
int X=2355
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_articolo_prezzo_cx
int X=2652
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_articolo_prezzo_cx
int X=46
int Y=841
int Width=188
int Height=101
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=151
end type

type cb_ricerca from w_p_data`cb_ricerca within w_articolo_prezzo_cx
boolean BringToTop=true
end type

type dw_prezzo_articolo_prezzo_gd from u_dw_master_main within w_articolo_prezzo_cx
int X=46
int Y=421
int Width=2881
int Height=741
int TabOrder=10
string DataObject="d_prezzo_articolo_prezzo_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_set_search;call super::ue_set_search;long 	ll_CurrRow, ll_id_listino, ll_id_articolo

ll_CurrRow = GetRow()
ll_id_listino = GetItemNumber(ll_CurrRow, "variazione_id_listino")
ll_id_articolo = GetItemNumber(ll_CurrRow, "id_articolo")

CHOOSE CASE as_nomecol

	CASE "cc_variazione"
		is_search_window = "w_variazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "variazione_data_inizio" 
		is_ricpar.s_sql_cond = "variazione.id_listino = " + string(ll_id_listino)

	CASE "cc_unita_confezione_des"
		is_search_window = "w_unita_confezione_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "unita_confezione_descrizione" 
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		
END CHOOSE


end event

event ue_use_search;call super::ue_use_search;
CHOOSE CASE as_nomecol

	CASE "cc_variazione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prezzo_id_variazione", is_ricpar.s_id_seg_value[1])

	CASE "cc_unita_confezione_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prezzo_id_unita_confezione", is_ricpar.s_id_seg_value[1])

END CHOOSE
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_articolo"

is_title = "Prezzi degli Articoli"

end event

event itemchanged;call super::itemchanged;

string   	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond, &
				ls_title, ls_codice, ls_descrizione
long 		 	ll_ok, ll_CurrRow, ll_id_articolo

ls_sql_cond = ""
ll_CurrRow = GetRow()

ll_id_articolo = This.GetItemNumber(ll_CurrRow, "id_articolo")

CHOOSE CASE string(dwo.name)

	CASE 'cc_unita_confezione_des'

		ls_sql_cond = "unita_confezione.id_articolo" + string(ll_id_articolo)		
		ls_dbc[1] = "id_unita_confezione"
		ls_dwc[1] = "unita_confezione_id_unita_confezione"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "cc_unita_confezione_des"
		ll_ok = uf_autofind_col(dwo.Name, "unita_confezione", &  
										"descrizione", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
	
END CHOOSE

end event

event ue_insert;call super::ue_insert;long			ll_id_unita_base
long			ll_row
string		ls_codice

ll_id_unita_base 	= dw_articolo_prezzo_ff.getitemnumber (1,"unita_confezione_id_unita_confezione")
ls_codice 			= dw_articolo_prezzo_ff.getitemstring (1,"unita_confezione_descrizione")

ll_row = this.getrow()
this.setitem(ll_row,"prezzo_id_unita_confezione",ll_id_unita_base )
this.setitem(ll_row,"cc_unita_confezione_des",ls_codice)
end event

type dw_articolo_prezzo_ff from u_dw_master_main within w_articolo_prezzo_cx
int X=46
int Y=161
int Width=2881
int Height=221
int TabOrder=1
string DataObject="d_articolo_prezzo_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_articolo"
is_title = "Prezzi degli Articoli"
iudw_children[1] = dw_prezzo_articolo_prezzo_gd
end event

