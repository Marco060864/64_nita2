forward
global type w_con_effetti_ff from w_wiz_main
end type
type cb_annulla from commandbutton within w_con_effetti_ff
end type
type cb_ok from commandbutton within w_con_effetti_ff
end type
type dw_con_effetti_ext_ff from u_dw_ext_main within w_con_effetti_ff
end type
end forward

global type w_con_effetti_ff from w_wiz_main
integer x = 832
integer y = 360
integer width = 2350
integer height = 932
string title = "Parametri Contabilizzazione Distinta"
windowtype windowtype = response!
cb_annulla cb_annulla
cb_ok cb_ok
dw_con_effetti_ext_ff dw_con_effetti_ext_ff
end type
global w_con_effetti_ff w_con_effetti_ff

type variables
s_con_effetti istr_con_effetti
boolean ib_feed, lb_controllo
end variables

forward prototypes
public subroutine uf_feed_struct (boolean ab_feed)
end prototypes

public subroutine uf_feed_struct (boolean ab_feed);

long ll_CurrRow
ll_CurrRow = dw_con_effetti_ext_ff.GetRow()

CHOOSE CASE ab_feed
	CASE TRUE
		IF ll_CurrRow > 0 THEN
			istr_con_effetti.l_id_prof_registrazione = dw_con_effetti_ext_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
			istr_con_effetti.d_data_registrazione    = dw_con_effetti_ext_ff.GetItemDate(ll_CurrRow, "data_registrazione")
			istr_con_effetti.s_des_contabile         = dw_con_effetti_ext_ff.GetItemString(ll_CurrRow, "des_contabile")

			CHOOSE CASE istr_con_effetti.c_tipo_distinta
				CASE "A"
					istr_con_effetti.i_tipo_registrazione = integer(dw_con_effetti_ext_ff.GetItemString(ll_CurrRow, "tipo_registrazione_a"))
				CASE "P"
					istr_con_effetti.i_tipo_registrazione = integer(dw_con_effetti_ext_ff.GetItemString(ll_CurrRow, "tipo_registrazione_p"))
			END CHOOSE
			
			istr_con_effetti.l_id_conto_1            = dw_con_effetti_ext_ff.GetItemNumber(ll_CurrRow, "id_conto_1")
			istr_con_effetti.l_id_conto_2            = dw_con_effetti_ext_ff.GetItemNumber(ll_CurrRow, "id_conto_2")
			
		END IF
	CASE FALSE
		istr_con_effetti.l_id_prof_registrazione = u_freddie.gl_NULL
		istr_con_effetti.d_data_registrazione    = u_freddie.gd_NULL
		istr_con_effetti.s_des_contabile         = u_freddie.gs_NULL
		istr_con_effetti.i_tipo_registrazione    = u_freddie.gi_NULL
		istr_con_effetti.l_id_conto_1            = u_freddie.gl_NULL
		istr_con_effetti.l_id_conto_2            = u_freddie.gl_NULL
		
END CHOOSE

Message.PowerObjectParm = istr_con_effetti
end subroutine

on w_con_effetti_ff.create
int iCurrent
call super::create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.dw_con_effetti_ext_ff=create dw_con_effetti_ext_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_annulla
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_con_effetti_ext_ff
end on

on w_con_effetti_ff.destroy
call super::destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.dw_con_effetti_ext_ff)
end on

event open;call super::open;

char lc_tipo_distinta

IF NOT dw_con_effetti_ext_ff.GetRow() > 0 THEN dw_con_effetti_ext_ff.InsertRow(0)

f_DisplayOnly(dw_con_effetti_ext_ff, "conto_cod_2", TRUE)
f_DisplayOnly(dw_con_effetti_ext_ff, "conto_des_2", TRUE)

istr_con_effetti = Message.PowerObjectParm
lc_tipo_distinta = istr_con_effetti.c_tipo_distinta
CHOOSE CASE lc_tipo_distinta
	CASE "A"
		il_helpTopic = 331
		dw_con_effetti_ext_ff.Object.Tipo_Registrazione_a.Visible = TRUE
		dw_con_effetti_ext_ff.Object.Tipo_Registrazione_p.Visible = FALSE
	CASE "P"
		il_helpTopic = 336
		dw_con_effetti_ext_ff.Object.Tipo_Registrazione_a.Visible = FALSE
		dw_con_effetti_ext_ff.Object.Tipo_Registrazione_p.Visible = TRUE
END CHOOSE

Message.Processed = TRUE

ib_feed = FALSE

dw_con_effetti_ext_ff.Event Post ue_post_open()
end event

event closequery;

uf_feed_struct(ib_feed)
end event

type cb_annulla from commandbutton within w_con_effetti_ff
integer x = 343
integer y = 40
integer width = 261
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;ib_feed = FALSE
Close(Parent)
end event

type cb_ok from commandbutton within w_con_effetti_ff
integer x = 46
integer y = 40
integer width = 261
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;boolean lb_continua
string ls_cod1,ls_cod2
lb_continua=false
if lb_controllo=true then
	ls_cod2=dw_con_effetti_ext_ff.getitemstring(1,"conto_cod_2")
	if not isnull(ls_cod2) then
		ls_cod1=dw_con_effetti_ext_ff.getitemstring(1,"conto_cod_1")
		if not isnull(ls_cod1) then lb_continua=true
	end if
else
	ls_cod1=dw_con_effetti_ext_ff.getitemstring(1,"conto_cod_1")
	if not isnull(ls_cod1) then lb_continua=true
end if
if lb_continua=true then
	ib_feed = TRUE
	Close(Parent)
else
	messagebox("Informazione!","Non sono state inserite tutte le informazioni necessarie!")
end if
end event

type dw_con_effetti_ext_ff from u_dw_ext_main within w_con_effetti_ff
integer x = 46
integer y = 160
integer width = 2240
integer height = 640
integer taborder = 10
string dataobject = "d_con_effetti_ext_ff"
end type

event ue_init;call super::ue_init;is_title = "Contabilizzazione Distinte"
is_colonne_drop[1] = "des_contabile"
end event

event ue_set_search;

CHOOSE CASE as_nomecol
	
	CASE "prof_registrazione_cod"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "prof_registrazione.usa_con_effetti = 'S'"
	CASE "prof_registrazione_des"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "prof_registrazione.usa_con_effetti = 'S'"		

	
	CASE "conto_cod_1"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_codice"
		is_ricpar.b_imm_retrieve = TRUE
	CASE "conto_des_1"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_descrizione"
		is_ricpar.b_imm_retrieve = TRUE
	
	
	CASE "conto_cod_2"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_codice"
		is_ricpar.b_imm_retrieve = TRUE
	CASE "conto_des_2"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_descrizione"
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;


CHOOSE CASE as_nomecol
	
	CASE "prof_registrazione_cod"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_des", is_ricpar.s_ausil_value[1])		
		
		THIS.SetItem(THIS.GetRow(), "des_contabile", u_freddie.gs_NULL)
	CASE "prof_registrazione_des"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_cod", is_ricpar.s_ausil_value[1])
		
		THIS.SetItem(THIS.GetRow(), "des_contabile", u_freddie.gs_NULL)

	
	CASE "conto_cod_1"
		uf_set_colval("id_conto_1", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_des_1", is_ricpar.s_ausil_value[1])		
	CASE "conto_des_1"
		uf_set_colval("id_conto_1", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_cod_1", is_ricpar.s_ausil_value[1])

	
	CASE "conto_cod_2"
		uf_set_colval("id_conto_2", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_des_2", is_ricpar.s_ausil_value[1])		
	CASE "conto_des_2"
		uf_set_colval("id_conto_2", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_cod_2", is_ricpar.s_ausil_value[1])

END CHOOSE
end event

event itemchanged;

string ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok
date ldt_null

setnull(ldt_null)

CHOOSE CASE dwo.name
	
	CASE "prof_registrazione_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"
		ls_dwc[1] = "prof_registrazione_cod"
		ls_dwc[2] = "prof_registrazione_des"
		ls_dwc[3] = "id_prof_registrazione"		
		
		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			THIS.SetItem(row, "des_contabile", u_freddie.gs_NULL)
			RETURN 2
		END IF
		
		
	CASE "prof_registrazione_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"		
		ls_dwc[1] = "prof_registrazione_cod"
		ls_dwc[2] = "prof_registrazione_des"
		ls_dwc[3] = "id_prof_registrazione"				
		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			THIS.SetItem(row, "des_contabile", u_freddie.gs_NULL)
			RETURN 2
		END IF
		
	CASE "tipo_registrazione_a"
		CHOOSE CASE data
			CASE '1'
				THIS.object.id_conto_1_t.text = "Portafoglio:"
				THIS.object.id_conto_2_t.text = ""
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_cod_2", TRUE)
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_des_2", TRUE)
				lb_controllo=false
			CASE '2'
				THIS.object.id_conto_1_t.text = "Banca:"
				THIS.object.id_conto_2_t.text = "Portafoglio:"
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_cod_2", FALSE)
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_des_2", FALSE)
				lb_controllo=true
			CASE '3'
				THIS.object.id_conto_1_t.text = "Banca c/Effetti:"
				THIS.object.id_conto_2_t.text = ""
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_cod_2", TRUE)
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_des_2", TRUE)
				lb_controllo=false
			CASE '4'
				THIS.object.id_conto_1_t.text = "Banca c/Effetti:"
				THIS.object.id_conto_2_t.text = "Portafoglio:"
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_cod_2", FALSE)
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_des_2", FALSE)
				lb_controllo=true
			CASE '5'
				THIS.object.id_conto_1_t.text = "Banca c/c"
				THIS.object.id_conto_2_t.text = "Banca c/Effetti:"
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_cod_2", FALSE)
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_des_2", FALSE)
				lb_controllo=true
			CASE '6'
				THIS.object.id_conto_1_t.text = "Banca:"
				THIS.object.id_conto_2_t.text = ""
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_cod_2", TRUE)
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_des_2", TRUE)
				lb_controllo=false

		END CHOOSE
		
	CASE "tipo_registrazione_p"
		CHOOSE CASE integer(data)
			CASE 1
				THIS.object.id_conto_1_t.text = "Banca:"
				THIS.object.id_conto_2_t.text = ""
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_cod_2", TRUE)
				f_DisplayOnly(dw_con_effetti_ext_ff, "conto_des_2", TRUE)
				lb_controllo=false
		END CHOOSE
	
	CASE "conto_cod_1"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_cod_1"
		ls_dwc[2] = "conto_des_1"
		ls_dwc[3] = "id_conto_1"
		
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "conto_des_1"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"		
		ls_dwc[1] = "conto_cod_1"
		ls_dwc[2] = "conto_des_1"
		ls_dwc[3] = "id_conto_1"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "conto_cod_2"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_cod_2"
		ls_dwc[2] = "conto_des_2"
		ls_dwc[3] = "id_conto_2"
		
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "conto_des_2"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"		
		ls_dwc[1] = "conto_cod_2"
		ls_dwc[2] = "conto_des_2"
		ls_dwc[3] = "id_conto_2"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	
		
END CHOOSE
end event

event itemfocuschanged;call super::itemfocuschanged;

long ll_CurrRow, ll_id_prof_registrazione
date ld_data
string ls_data

CHOOSE CASE dwo.name
	CASE "data_registrazione"
		THIS.AcceptText()
		ll_CurrRow = THIS.GetRow()
		ld_data = THIS.GetItemDate(ll_CurrRow, "data_registrazione")
		IF IsNull(ld_data) THEN THIS.SetItem(ll_CurrRow, "data_registrazione", Today())
	CASE "des_contabile"
		THIS.AcceptText()
		ll_CurrRow = THIS.GetRow()
		ls_data = THIS.GetItemString(ll_CurrRow, "des_contabile")
		ll_id_prof_registrazione = THIS.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
		IF IsNull(ls_data) AND &
			NOT IsNull(ll_id_prof_registrazione) THEN THIS.SetItem(ll_CurrRow, "des_contabile", f_proponi_descr_reg_pd(ll_id_prof_registrazione))
END CHOOSE

end event

