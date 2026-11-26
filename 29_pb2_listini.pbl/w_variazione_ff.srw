forward
global type w_variazione_ff from w_p_data
end type
type dw_variazione_ff from u_dw_master_main within w_variazione_ff
end type
type dw_prezzo_variaz_gd from u_dw_master_main within w_variazione_ff
end type
type dw_prezzo_variaz_gd_t from statictext within w_variazione_ff
end type
end forward

global type w_variazione_ff from w_p_data
integer width = 2729
integer height = 1460
string title = "Variazioni"
dw_variazione_ff dw_variazione_ff
dw_prezzo_variaz_gd dw_prezzo_variaz_gd
dw_prezzo_variaz_gd_t dw_prezzo_variaz_gd_t
end type
global w_variazione_ff w_variazione_ff

type variables
integer il_key
long il_id_valuta
end variables

event open;call super::open;
il_HelpTopic = 43

idw_master = dw_variazione_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_variazione"
	idw_master.is_list.s_modo=modo_modifica
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_variazione"

il_id_valuta = long(idw_master.is_list.s_par_value[1])
end event

on w_variazione_ff.create
int iCurrent
call super::create
this.dw_variazione_ff=create dw_variazione_ff
this.dw_prezzo_variaz_gd=create dw_prezzo_variaz_gd
this.dw_prezzo_variaz_gd_t=create dw_prezzo_variaz_gd_t
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_variazione_ff
this.Control[iCurrent+2]=this.dw_prezzo_variaz_gd
this.Control[iCurrent+3]=this.dw_prezzo_variaz_gd_t
end on

on w_variazione_ff.destroy
call super::destroy
destroy(this.dw_variazione_ff)
destroy(this.dw_prezzo_variaz_gd)
destroy(this.dw_prezzo_variaz_gd_t)
end on

type p_msg_log from w_p_data`p_msg_log within w_variazione_ff
end type

type p_crescente from w_p_data`p_crescente within w_variazione_ff
end type

type p_decrescente from w_p_data`p_decrescente within w_variazione_ff
end type

type cb_ok from w_p_data`cb_ok within w_variazione_ff
end type

type cb_annulla from w_p_data`cb_annulla within w_variazione_ff
end type

type cb_nuovo from w_p_data`cb_nuovo within w_variazione_ff
end type

type cb_inserisci from w_p_data`cb_inserisci within w_variazione_ff
integer x = 1074
end type

type cb_cancella from w_p_data`cb_cancella within w_variazione_ff
integer x = 1371
end type

type cb_salva from w_p_data`cb_salva within w_variazione_ff
integer x = 1669
end type

type tab_1 from w_p_data`tab_1 within w_variazione_ff
boolean visible = false
integer x = 1737
integer y = 860
integer width = 640
integer height = 620
boolean enabled = false
long backcolor = 79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 603
integer height = 500
end type

type cb_ricerca from w_p_data`cb_ricerca within w_variazione_ff
end type

type dw_variazione_ff from u_dw_master_main within w_variazione_ff
integer x = 46
integer y = 168
integer width = 2624
integer height = 400
integer taborder = 0
string dataobject = "d_variazione_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_variazione" 
iudw_children[1] = dw_prezzo_variaz_gd

end event

type dw_prezzo_variaz_gd from u_dw_master_main within w_variazione_ff
integer x = 18
integer y = 692
integer width = 2670
integer height = 668
integer taborder = 10
string dataobject = "d_prezzo_variaz_gd"
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_title = "Prezzo Variazione"
is_list.s_identifica[1] = "id_variazione"
end event

event ue_set_search;call super::ue_set_search;

long ll_row, ll_id_articolo

CHOOSE CASE as_nomecol
	
	CASE "articolo_codice"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "articolo_codice"
			
	CASE "articolo_descrizione"
		is_search_window = "w_articolo_coddes_sw"
		
		is_ricpar.s_filter_value = as_valcol
		
		
		is_ricpar.s_filter_name = "articolo_descrizione"
		
	CASE "c_unita_confezione_cod"
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		is_search_window = "w_unita_confezione_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "unita_confezione_codice"

	CASE "c_unita_confezione_des"
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		is_ricpar.s_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		is_search_window = "w_unita_confezione_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "unita_confezione_descrizione"

END CHOOSE
end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	
	CASE "articolo_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_descrizione", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("id_unita_confezione", is_ricpar.s_ausil_value[9])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[2])
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[3])

	CASE "articolo_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("articolo_codice", is_ricpar.s_ausil_value[1])
		
		uf_set_colval("id_unita_confezione", is_ricpar.s_ausil_value[9])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[2])
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[3])
		
	CASE "c_unita_confezione_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_unita_confezione_des", is_ricpar.s_ausil_value[1])

	CASE "c_unita_confezione_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_unita_confezione", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_unita_confezione_cod", is_ricpar.s_ausil_value[1])

END CHOOSE
end event

event itemchanged;call super::itemchanged;

integer li_ok
long ll_id_articolo, ll_row
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	
	CASE 'articolo_codice'
		
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'articolo_descrizione'
		
		ls_sql_cond = ""
		ls_dbc[1] = "id_articolo"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_articolo"
		ls_dwc[2] = "articolo_codice"
		ls_dwc[3] = "articolo_descrizione"

		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, &
			3, ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_unita_confezione_cod'
		
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		ls_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		ls_dbc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_unita_confezione"
		ls_dwc[2] = "c_unita_confezione_cod"
		ls_dwc[3] = "c_unita_confezione_des"

		li_ok = uf_autofind_col(dwo.Name, "unita_confezione", "codice", "A", data, &
			ls_sql_cond, 3, ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'c_unita_confezione_des'
		
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "id_articolo")
		ELSE
			SetNull(ll_id_articolo)
		END IF
		ls_sql_cond = "unita_confezione.id_articolo = " + string(ll_id_articolo)
		ls_dbc[1] = "id_unita_confezione"
		ls_dbc[2] = "codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[1] = "id_unita_confezione"
		ls_dwc[2] = "c_unita_confezione_cod"
		ls_dwc[3] = "c_unita_confezione_des"

		li_ok = uf_autofind_col(dwo.Name, "unita_confezione", "descrizione", "A", data, &
			ls_sql_cond, 3, ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF

END CHOOSE
end event

event itemfocuschanged;call super::itemfocuschanged;



long ll_row, ll_id_articolo
string ls_test

CHOOSE CASE dwo.Name
	CASE "c_unita_confezione_cod", "c_unita_confezione_des"
	
	ls_test=this.getitemstring(row,'articolo_descrizione')
	if il_key<>1 or dwo.Name<>"c_unita_confezione_cod" or (ls_test='' or  isnull(ls_test)) then
	
		ll_row = GetRow()
		IF ll_row > 0 THEN
			ll_id_articolo = GetItemNumber(ll_row, "id_articolo")
			IF IsNull(ll_id_articolo) THEN
				MessageBox(is_title, "Si deve prima inserire un articolo.")
				SetFocus()
				ScrollToRow(ll_row)
				SetColumn("articolo_codice")
				RETURN 1		
			END IF
		END IF
	end if
END CHOOSE




Long		ll_col , li_id_unita_conf
String	ls_cod_articolo , ls_cod_unita_conf , ls_des_unita_conf

ll_col = dw_prezzo_variaz_gd.GetColumn()
IF ll_col = 2 THEN
	
	
	
	
	
	ls_cod_articolo = dw_prezzo_variaz_gd.GetItemString(row,"articolo_codice")

	SELECT 	"unita_confezione"."codice" , "unita_confezione"."descrizione" , &
				"unita_confezione"."id_unita_confezione"
 	INTO 		:ls_cod_unita_conf , :ls_des_unita_conf , :li_id_unita_conf
 	FROM 		"articolo" , "unita_confezione"
	WHERE 	("unita_confezione"."unita_base" = 'S') AND &
				("articolo"."codice" = :ls_cod_articolo) AND &
				("articolo"."id_articolo" = "unita_confezione"."id_articolo");

	dw_prezzo_variaz_gd.SetItem(row,"c_unita_confezione_cod",ls_cod_unita_conf)
	dw_prezzo_variaz_gd.SetItem(row,"c_unita_confezione_des",ls_des_unita_conf)
	dw_prezzo_variaz_gd.SetItem(row,"id_unita_confezione",li_id_unita_conf)
	
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;
end event

event ue_key;call super::ue_key;
if key=Keytab! then 
	il_key=1
else
	il_key=0
end if	
end event

event ue_initial;call super::ue_initial;this.setitem(this.getrow(), "listino_id_valuta", il_id_valuta)
end event

type dw_prezzo_variaz_gd_t from statictext within w_variazione_ff
integer x = 18
integer y = 612
integer width = 2670
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Prezzi"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

