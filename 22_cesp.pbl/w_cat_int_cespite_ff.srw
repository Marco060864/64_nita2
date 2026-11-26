forward
global type w_cat_int_cespite_ff from w_p_data
end type
type dw_cat_int_cespite_ff from u_dw_master_main within w_cat_int_cespite_ff
end type
end forward

global type w_cat_int_cespite_ff from w_p_data
integer y = 4
integer width = 2776
integer height = 1763
string title = "Definizione Categorie"
long backcolor = 78748035
dw_cat_int_cespite_ff dw_cat_int_cespite_ff
end type
global w_cat_int_cespite_ff w_cat_int_cespite_ff

forward prototypes
public subroutine uf_ricerca ()
end prototypes

public subroutine uf_ricerca ();

w_search_main lw_sm
long ll_id_cat_int_cespite
s_ric_param ls_ricpar

idw_master.is_ricpar.s_filter_name = "cat_int_cespite_codice"
idw_master.is_ricpar.s_filter_value=""
idw_master.is_ricpar.b_imm_retrieve = TRUE

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_cat_int_cespite_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_cat_int_cespite = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_cat_int_cespite"
	idw_master.is_list.l_identifica[1] = ll_id_cat_int_cespite
	
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
	dw_cat_int_cespite_ff.event post ue_setta_valori()
END IF

idw_master.SetFocus()
end subroutine

on w_cat_int_cespite_ff.create
int iCurrent
call super::create
this.dw_cat_int_cespite_ff=create dw_cat_int_cespite_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cat_int_cespite_ff
end on

on w_cat_int_cespite_ff.destroy
call super::destroy
destroy(this.dw_cat_int_cespite_ff)
end on

event open;call super::open;

long ll_screenh
environment le_env

idw_master = dw_cat_int_cespite_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "cat_int_cespite.id_cat_int_cespite"

ib_NonModale = TRUE

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_cat_int_cespite"
	idw_master.is_list.s_modo = modo_inserisci
	
	
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
END IF

end event

event ue_master_delete;call super::ue_master_delete;

IF (idw_master.Event ue_delete(0, 0) = 0) THEN
	
	ib_AskForSave = FALSE
	IF (idw_master.uf_To_Update() > 0) THEN
		IF (idw_master.Event ue_update(0, 0) = 0) THEN
			ib_AskForSave = TRUE
			idw_master.is_list.s_modo = modo_inserisci
			idw_master.Event ue_insert(0, 0)
		END IF
	END IF
END IF
idw_master.SetFocus()
end event

type p_msg_log from w_p_data`p_msg_log within w_cat_int_cespite_ff
end type

type p_crescente from w_p_data`p_crescente within w_cat_int_cespite_ff
end type

type p_decrescente from w_p_data`p_decrescente within w_cat_int_cespite_ff
end type

type cb_ok from w_p_data`cb_ok within w_cat_int_cespite_ff
end type

type cb_annulla from w_p_data`cb_annulla within w_cat_int_cespite_ff
end type

type cb_nuovo from w_p_data`cb_nuovo within w_cat_int_cespite_ff
end type

event cb_nuovo::clicked;

IF idw_master.uf_to_update() > 0 THEN idw_master.event ue_update (0,0)

idw_master.Reset()
idw_master.is_list.s_modo = modo_inserisci
idw_master.triggerevent("ue_insert")
idw_master.SetFocus()

end event

type cb_inserisci from w_p_data`cb_inserisci within w_cat_int_cespite_ff
integer x = 1872
end type

type cb_cancella from w_p_data`cb_cancella within w_cat_int_cespite_ff
integer x = 2172
end type

type cb_salva from w_p_data`cb_salva within w_cat_int_cespite_ff
integer x = 2469
end type

type tab_1 from w_p_data`tab_1 within w_cat_int_cespite_ff
boolean visible = false
integer x = 59
integer y = 1562
long backcolor = 79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
boolean visible = false
integer x = 15
integer y = 90
integer width = 2330
integer height = 1219
end type

type cb_ricerca from w_p_data`cb_ricerca within w_cat_int_cespite_ff
integer x = 1532
integer width = 307
end type

event cb_ricerca::clicked;call super::clicked;

uf_ricerca()
end event

type dw_cat_int_cespite_ff from u_dw_master_main within w_cat_int_cespite_ff
event ue_setta_valori ( )
integer x = 48
integer y = 154
integer width = 2673
integer height = 1491
integer taborder = 10
string dataobject = "d_cat_int_cespite_ff"
end type

event ue_setta_valori;long ll_id_c_pat, ll_id_c_min, ll_id_c_plus, ll_id_c_fant, ll_id_c_ford
long ll_id_c_qant, ll_id_c_qord, ll_id_c_vend, ll_id_c_fsval, ll_id_c_friv
long currentrow
string ls_conto, ls_des
currentrow=getrow()
ll_id_c_pat=getitemnumber(currentrow,"id_conto_patrimoniale")	  
ll_id_c_min=getitemnumber(currentrow,"id_conto_minusvalenza")
ll_id_c_plus=getitemnumber(currentrow,"id_conto_plusvalenza")
ll_id_c_fant=getitemnumber(currentrow,"id_conto_fondo_ant")
ll_id_c_ford=getitemnumber(currentrow,"id_conto_fondo_ord")
ll_id_c_qant=getitemnumber(currentrow,"id_conto_quota_ant")
ll_id_c_qord=getitemnumber(currentrow,"id_conto_quota_ord")
ll_id_c_vend=getitemnumber(currentrow,"id_conto_vendita")
ll_id_c_fsval=getitemnumber(currentrow,"id_conto_fondo_sval")
ll_id_c_friv=getitemnumber(currentrow,"id_conto_fondo_riv")

select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_pat;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_patrimoniale_cod",ls_conto)
		uf_set_colval("cconto_patrimoniale_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_patrimoniale_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_patrimoniale_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
	end if

select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_min;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_minusvalenza_cod",ls_conto)
		uf_set_colval("cconto_minusvalenza_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_minusvalenza_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_minusvalenza_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
	end if

select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_plus;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_plusvalenza_cod",ls_conto)
		uf_set_colval("cconto_plusvalenza_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_plusvalenza_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_plusvalenza_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
	end if

select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_fant;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_fondo_ant_cod",ls_conto)
		uf_set_colval("cconto_fondo_ant_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_fondo_ant_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_fondo_ant_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
	end if

select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_ford;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_fondo_ord_cod",ls_conto)
		uf_set_colval("cconto_fondo_ord_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_fondo_ord_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_fondo_ord_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
	end if

select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_qant;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_quota_ant_cod",ls_conto)
		uf_set_colval("cconto_quota_ant_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_quota_ant_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_quota_ant_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
	end if
select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_qord;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_quota_ord_cod",ls_conto)
		uf_set_colval("cconto_quota_ord_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_quota_ord_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_quota_ord_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
	end if

select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_vend;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_vendita_cod",ls_conto)
		uf_set_colval("cconto_vendita_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_vendita_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_vendita_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
	end if

select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_fsval;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_fondo_sval_cod",ls_conto)
		uf_set_colval("cconto_fondo_sval_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_fondo_sval_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_fondo_sval_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
	end if

select codice,descrizione
into :ls_conto, :ls_des
from conto
where id_conto=:ll_id_c_friv;
if sqlca.sqlcode=0 then
		
		uf_set_colval("cconto_fondo_riv_cod",ls_conto)
		uf_set_colval("cconto_fondo_riv_des",ls_des)
		
		
		setitemstatus(currentrow, "cconto_fondo_riv_cod", PRIMARY!, NotModified!)
		setitemstatus(currentrow, "cconto_fondo_riv_des", PRIMARY!, NotModified!)
		
		ls_conto = ""
		ls_des = ""
end if


end event

event ue_set_search;

CHOOSE CASE as_nomecol
	CASE "cat_fisc_cespite_codice", "cat_fisc_cespite_descrizione"
		is_search_window = "w_cat_fisc_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = as_nomecol
		is_ricpar.b_imm_retrieve  = TRUE
	CASE "gruppo_cespite_codice","gruppo_cespite_descrizione"
		is_search_window = "w_cat_fisc_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = as_nomecol
		is_ricpar.b_imm_retrieve  = TRUE
	CASE "specie_cespite_codice","specie_cespite_descrizione"
		is_search_window = "w_cat_fisc_cespite_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = as_nomecol
		is_ricpar.b_imm_retrieve  = TRUE
	CASE "cconto_patrimoniale_cod", &
		  "cconto_minusvalenza_cod", &
		  "cconto_plusvalenza_cod", &
		  "cconto_fondo_ant_cod", &
		  "cconto_fondo_ord_cod", &
		  "cconto_quota_ant_cod", &
		  "cconto_quota_ord_cod", &
		  "cconto_vendita_cod", &
		  "cconto_fondo_sval_cod", &
		  "cconto_fondo_riv_cod"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_codice"
		is_ricpar.b_imm_retrieve  = TRUE
		
	CASE "cconto_patrimoniale_des", &
		  "cconto_minusvalenza_des", &
		  "cconto_plusvalenza_des", &
		  "cconto_fondo_ant_des", &
		  "cconto_fondo_ord_des", &
		  "cconto_quota_ant_des", &
		  "cconto_quota_ord_des", &
		  "cconto_vendita_des", &
		  "cconto_fondo_sval_des", &
		  "cconto_fondo_riv_des"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_descrizione"
		is_ricpar.b_imm_retrieve  = TRUE
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "cat_fisc_cespite_codice", "cat_fisc_cespite_descrizione",&
		"gruppo_cespite_codice","gruppo_cespite_descrizione",&
		"specie_cespite_codice","specie_cespite_descrizione"
		uf_set_colval("cat_int_cespite_id_coef_ammortamento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("perc_ammortamento", is_ricpar.s_main_value)
		uf_set_colval("gruppo_cespite_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("gruppo_cespite_descrizione", is_ricpar.s_ausil_value[2])
		uf_set_colval("cat_fisc_cespite_codice", is_ricpar.s_ausil_value[3])
		uf_set_colval("cat_fisc_cespite_descrizione", is_ricpar.s_ausil_value[4])
		uf_set_colval("specie_cespite_codice", is_ricpar.s_ausil_value[5])
		uf_set_colval("specie_cespite_descrizione", is_ricpar.s_ausil_value[6])
		
   CASE "cconto_patrimoniale_cod"
      uf_set_colval("id_conto_patrimoniale", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_patrimoniale_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_patrimoniale_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_patrimoniale_des"
      uf_set_colval("id_conto_patrimoniale", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_patrimoniale_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_patrimoniale_cod", is_ricpar.s_ausil_value[1])

   CASE "cconto_minusvalenza_cod"
      uf_set_colval("id_conto_minusvalenza", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_minusvalenza_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_minusvalenza_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_minusvalenza_des"
      uf_set_colval("id_conto_minusvalenza", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_minusvalenza_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_minusvalenza_cod", is_ricpar.s_ausil_value[1])

   CASE "cconto_plusvalenza_cod"
      uf_set_colval("id_conto_plusvalenza", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_plusvalenza_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_plusvalenza_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_plusvalenza_des"
      uf_set_colval("id_conto_plusvalenza", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_plusvalenza_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_plusvalenza_cod", is_ricpar.s_ausil_value[1])

   CASE "cconto_fondo_ant_cod"
      uf_set_colval("id_conto_fondo_ant", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_fondo_ant_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_fondo_ant_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_fondo_ant_des"
      uf_set_colval("id_conto_fondo_ant", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_fondo_ant_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_fondo_ant_cod", is_ricpar.s_ausil_value[1])

   CASE "cconto_fondo_ord_cod"
      uf_set_colval("id_conto_fondo_ord", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_fondo_ord_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_fondo_ord_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_fondo_ord_des"
      uf_set_colval("id_conto_fondo_ord", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_fondo_ord_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_fondo_ord_cod", is_ricpar.s_ausil_value[1])

   CASE "cconto_quota_ant_cod"
      uf_set_colval("id_conto_quota_ant", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_quota_ant_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_quota_ant_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_quota_ant_des"
      uf_set_colval("id_conto_quota_ant", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_quota_ant_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_quota_ant_cod", is_ricpar.s_ausil_value[1])

   CASE "cconto_quota_ord_cod"
      uf_set_colval("id_conto_quota_ord", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_quota_ord_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_quota_ord_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_quota_ord_des"
      uf_set_colval("id_conto_quota_ord", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_quota_ord_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_quota_ord_cod", is_ricpar.s_ausil_value[1])

	CASE "cconto_vendita_cod"
      uf_set_colval("id_conto_vendita", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_vendita_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_vendita_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_vendita_des"
      uf_set_colval("id_conto_vendita", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_vendita_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_vendita_cod", is_ricpar.s_ausil_value[1])
		
	CASE "cconto_fondo_sval_cod"
      uf_set_colval("id_conto_fondo_sval", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_fondo_sval_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_fondo_sval_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_fondo_sval_des"
      uf_set_colval("id_conto_fondo_sval", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_fondo_sval_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_fondo_sval_cod", is_ricpar.s_ausil_value[1])
		
	CASE "cconto_fondo_riv_cod"
      uf_set_colval("id_conto_fondo_riv", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_fondo_riv_cod", is_ricpar.s_main_value)
      uf_set_colval("cconto_fondo_riv_des", is_ricpar.s_ausil_value[1])

   CASE "cconto_fondo_riv_des"
      uf_set_colval("id_conto_fondo_riv", is_ricpar.s_id_seg_value[1])
      uf_set_colval("cconto_fondo_riv_des", is_ricpar.s_main_value)
      uf_set_colval("cconto_fondo_riv_cod", is_ricpar.s_ausil_value[1])
END CHOOSE

end event

event ue_init;call super::ue_init;is_title = parent.Title
end event

event itemchanged;integer li_ok
string ls_dbc[], ls_dbv[], ls_dwc[], ls_codice, ls_descrizione
long ll_specie_cespite, ll_gruppo_cespite, ll_cat_fisc_cespite
decimal ld_base_fiscale

DECIMAL LD_PERC

CHOOSE CASE dwo.name

   CASE "perc_ammortamento"
		  ld_perc=long(data)
		  if not isnull(ld_perc) then
			  this.setitem(row,'perc_amm_anticipato',100)
			  this.setitem(row,'perc_primo_amm',50)
		  end if	  

   CASE "cat_fisc_cespite_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_cat_fisc_cespite"
		ls_dwc[1] = "cat_fisc_cespite_codice"
		ls_dwc[2] = "cat_fisc_cespite_descrizione"
		ls_dwc[3] = "id_cat_fisc_cespite"
		
		li_ok = uf_autofind_col(string(dwo.name), "cat_fisc_cespite", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		
		
		select id_specie_cespite, base_fiscale
		into :ll_specie_cespite, :ld_base_fiscale
		from coef_ammortamento
		where id_cat_fisc_cespite=:ls_dbv[3];
		
		this.setitem(1,'perc_ammortamento',ld_base_fiscale)
		
		select id_gruppo_cespite, codice, descrizione
		into :ll_gruppo_cespite, :ls_codice, :ls_descrizione
		from specie_cespite
		where id_specie_cespite= :ll_specie_cespite;
		
		this.setitem(1,'specie_cespite_codice',ls_codice)
		this.setitem(1,'specie_cespite_descrizione',ls_descrizione)
		
		select codice, descrizione
	   into :ls_codice, :ls_descrizione
	   from gruppo_cespite
		where id_gruppo_cespite=:ll_gruppo_cespite;
		
		this.setitem(1,'gruppo_cespite_codice',ls_codice)
		this.setitem(1,'gruppo_cespite_descrizione',ls_descrizione)
		
		
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
		
	CASE "cat_fisc_cespite_descrizione"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_cat_fisc_cespite"
		ls_dwc[1] = "cat_fisc_cespite_codice"
		ls_dwc[2] = "cat_fisc_cespite_descrizione"
		ls_dwc[3] = "id_cat_fisc_cespite"
		
		li_ok = uf_autofind_col(string(dwo.name), "cat_fisc_cespite", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		
		select id_specie_cespite, base_fiscale
		into :ll_specie_cespite, :ld_base_fiscale
		from coef_ammortamento
		where id_cat_fisc_cespite=:ls_dbv[3];
		
		this.setitem(1,'perc_ammortamento',ld_base_fiscale)
		
		select id_gruppo_cespite, codice, descrizione
		into :ll_gruppo_cespite, :ls_codice, :ls_descrizione
		from specie_cespite
		where id_specie_cespite= :ll_specie_cespite;
		
		this.setitem(1,'specie_cespite_codice',ls_codice)
		this.setitem(1,'specie_cespite_descrizione',ls_descrizione)
		
		select codice, descrizione
	   into :ls_codice, :ls_descrizione
	   from gruppo_cespite
		where id_gruppo_cespite=:ll_gruppo_cespite;
		
		this.setitem(1,'gruppo_cespite_codice',ls_codice)
		this.setitem(1,'gruppo_cespite_descrizione',ls_descrizione)
		
		
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
		


   CASE "specie_cespite_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_specie_cespite"
		ls_dbc[4] = "id_gruppo_cespite"
		ls_dwc[1] = "specie_cespite_codice"
		ls_dwc[2] = "specie_cespite_descrizione"
		ls_dwc[3] = "id_specie_cespite"
		ls_dwc[4] = "id_gruppo_cespite"
		
		li_ok = uf_autofind_col(string(dwo.name), "specie_cespite", "codice", "A", data, "", 4, ls_dbc, ls_dbv, ls_dwc)
		
		
		select id_cat_fisc_cespite, base_fiscale
		into :ll_cat_fisc_cespite, :ld_base_fiscale
		from coef_ammortamento
		where id_specie_cespite=:ls_dbv[3];
		
		this.setitem(1,'perc_ammortamento',ld_base_fiscale)
		
		select codice, descrizione
		into  :ls_codice, :ls_descrizione
		from cat_fisc_cespite
		where id_cat_fisc_cespite= :ll_cat_fisc_cespite;
		
		this.setitem(1,'cat_fisc_cespite_codice',ls_codice)
		this.setitem(1,'cat_fisc_cespite_descrizione',ls_descrizione)
		
		select codice, descrizione
	   into :ls_codice, :ls_descrizione
	   from gruppo_cespite
		where id_gruppo_cespite=:ls_dbv[4];
		
		this.setitem(1,'gruppo_cespite_codice',ls_codice)
		this.setitem(1,'gruppo_cespite_descrizione',ls_descrizione)
		
		
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
		
	CASE "specie_cespite_descrizione"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_specie_cespite"
		ls_dwc[1] = "specie_cespite_codice"
		ls_dwc[2] = "specie_cespite_descrizione"
		ls_dwc[3] = "id_specie_cespite"
		
		li_ok = uf_autofind_col(string(dwo.name), "specie_cespite", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		
		
		select id_cat_fisc_cespite, base_fiscale
		into :ll_cat_fisc_cespite, :ld_base_fiscale
		from coef_ammortamento
		where id_specie_cespite=:ls_dbv[3];
		
		this.setitem(1,'perc_ammortamento',ld_base_fiscale)
		
		select codice, descrizione
		into  :ls_codice, :ls_descrizione
		from cat_fisc_cespite
		where id_cat_fisc_cespite= :ll_cat_fisc_cespite;
		
		this.setitem(1,'cat_fisc_cespite_codice',ls_codice)
		this.setitem(1,'cat_fisc_cespite_descrizione',ls_descrizione)
		
		select codice, descrizione
	   into :ls_codice, :ls_descrizione
	   from gruppo_cespite
		where id_gruppo_cespite=:ls_dbv[4];
		
		this.setitem(1,'gruppo_cespite_codice',ls_codice)
		this.setitem(1,'gruppo_cespite_descrizione',ls_descrizione)
		
		
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	
		
   CASE "gruppo_cespite_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_gruppo_cespite"
		ls_dwc[1] = "specie_cespite_codice"
		ls_dwc[2] = "specie_cespite_descrizione"
		ls_dwc[3] = "id_gruppo_cespite"
		
		li_ok = uf_autofind_col(string(dwo.name), "specie_cespite", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		
		
		select id_specie_cespite, codice, descrizione
	   into :ll_specie_cespite, :ls_codice, :ls_descrizione
	   from specie_cespite
		where id_gruppo_cespite=:ls_dbv[3];
		
		this.setitem(1,'specie_cespite_codice',ls_codice)
		this.setitem(1,'specie_cespite_descrizione',ls_descrizione)
		
		select id_cat_fisc_cespite, base_fiscale
		into :ll_cat_fisc_cespite, :ld_base_fiscale
		from coef_ammortamento
		where id_specie_cespite=:ll_specie_cespite;
		
		this.setitem(1,'perc_ammortamento',ld_base_fiscale)
		
		select codice, descrizione
		into  :ls_codice, :ls_descrizione
		from cat_fisc_cespite
		where id_cat_fisc_cespite= :ll_cat_fisc_cespite;
		
		this.setitem(1,'cat_fisc_cespite_codice',ls_codice)
		this.setitem(1,'cat_fisc_cespite_descrizione',ls_descrizione)
		
		
		
		
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
		
	CASE "gruppo_cespite_descrizione"
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_gruppo_cespite"
		ls_dwc[1] = "specie_cespite_codice"
		ls_dwc[2] = "specie_cespite_descrizione"
		ls_dwc[3] = "id_gruppo_cespite"
		
		li_ok = uf_autofind_col(string(dwo.name), "specie_cespite", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		
		select id_specie_cespite, codice, descrizione
	   into :ll_specie_cespite, :ls_codice, :ls_descrizione
	   from specie_cespite
		where id_gruppo_cespite=:ls_dbv[3];
		
		this.setitem(1,'specie_cespite_codice',ls_codice)
		this.setitem(1,'specie_cespite_descrizione',ls_descrizione)
		
		select id_cat_fisc_cespite, base_fiscale
		into :ll_cat_fisc_cespite, :ld_base_fiscale
		from coef_ammortamento
		where id_specie_cespite=:ll_specie_cespite;
		
		this.setitem(1,'perc_ammortamento',ld_base_fiscale)
		
		select codice, descrizione
		into  :ls_codice, :ls_descrizione
		from cat_fisc_cespite
		where id_cat_fisc_cespite= :ll_cat_fisc_cespite;
		
		this.setitem(1,'cat_fisc_cespite_codice',ls_codice)
		this.setitem(1,'cat_fisc_cespite_descrizione',ls_descrizione)
		
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
		
			
	
	
	
	
   CASE "cconto_patrimoniale_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_patrimoniale_cod"
      ls_dwc[2] = "cconto_patrimoniale_des"
      ls_dwc[3] = "id_conto_patrimoniale"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_patrimoniale_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_patrimoniale_cod"
      ls_dwc[2] = "cconto_patrimoniale_des"
      ls_dwc[3] = "id_conto_patrimoniale"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF

   CASE "cconto_minusvalenza_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_minusvalenza_cod"
      ls_dwc[2] = "cconto_minusvalenza_des"
      ls_dwc[3] = "id_conto_minusvalenza"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_minusvalenza_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_minusvalenza_cod"
      ls_dwc[2] = "cconto_minusvalenza_des"
      ls_dwc[3] = "id_conto_minusvalenza"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_plusvalenza_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_plusvalenza_cod"
      ls_dwc[2] = "cconto_plusvalenza_des"
      ls_dwc[3] = "id_conto_plusvalenza"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_plusvalenza_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_plusvalenza_cod"
      ls_dwc[2] = "cconto_plusvalenza_des"
      ls_dwc[3] = "id_conto_plusvalenze"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_fondo_ant_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_fondo_ant_cod"
      ls_dwc[2] = "cconto_fondo_ant_des"

      ls_dwc[3] = "id_conto_fondo_ant"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_fondo_ant_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_fondo_ant_cod"
      ls_dwc[2] = "cconto_fondo_ant_des"
      ls_dwc[3] = "id_conto_fondo_ant"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_fondo_ord_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_fondo_ord_cod"
      ls_dwc[2] = "cconto_fondo_ord_des"
      ls_dwc[3] = "id_conto_fondo_ord"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_fondo_ord_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_fondo_ord_cod"
      ls_dwc[2] = "cconto_fondo_ord_des"
      ls_dwc[3] = "id_conto_fondo_ord"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_quota_ant_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_quota_ant_cod"
      ls_dwc[2] = "cconto_quota_ant_des"
      ls_dwc[3] = "id_conto_quota_ant"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_quota_ant_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_quota_ant_cod"
      ls_dwc[2] = "cconto_quota_ant_des"
      ls_dwc[3] = "id_conto_quota_ant"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_quota_ord_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
	   ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_quota_ord_cod"
      ls_dwc[2] = "cconto_quota_ord_des"
      ls_dwc[3] = "id_conto_quota_ord"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_quota_ord_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
      
		ls_dbc[3] = "id_conto"	
      ls_dwc[1] = "cconto_quota_ord_cod"
      ls_dwc[2] = "cconto_quota_ord_des"
      ls_dwc[3] = "id_conto_quota_ord"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF




   CASE "cconto_vendita_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
	   ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_vendita_cod"
      ls_dwc[2] = "cconto_vendita_des"
      ls_dwc[3] = "id_conto_vendita"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_vendita_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"	
      ls_dwc[1] = "cconto_vendita_cod"
      ls_dwc[2] = "cconto_vendita_des"
      ls_dwc[3] = "id_conto_vendita"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
	
	 CASE "cconto_fondo_sval_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
	   ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_fondo_sval_cod"
      ls_dwc[2] = "cconto_fondo_sval_des"
      ls_dwc[3] = "id_conto_fondo_sval"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_fondo_sval_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"	
      ls_dwc[1] = "cconto_fondo_sval_cod"
      ls_dwc[2] = "cconto_fondo_sval_des"
      ls_dwc[3] = "id_conto_fondo_sval"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF

    CASE "cconto_fondo_riv_cod"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
	   ls_dbc[3] = "id_conto"
      ls_dwc[1] = "cconto_fondo_riv_cod"
      ls_dwc[2] = "cconto_fondo_riv_des"
      ls_dwc[3] = "id_conto_fondo_riv"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
   CASE "cconto_fondo_riv_des"
      ls_dbc[1] = "codice"
      ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"	
      ls_dwc[1] = "cconto_fondo_riv_cod"
      ls_dwc[2] = "cconto_fondo_riv_des"
      ls_dwc[3] = "id_conto_fondo_riv"

      li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
      IF li_ok > 0 THEN
         RETURN 2
      END IF
		
	
	

END CHOOSE
end event

