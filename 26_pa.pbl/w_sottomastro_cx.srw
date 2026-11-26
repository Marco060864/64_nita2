forward
global type w_sottomastro_cx from w_p_data
end type
type dw_sottomastro_ff from u_dw_master_main within w_sottomastro_cx
end type
type dw_conto_gd from u_dw_master_main within w_sottomastro_cx
end type
end forward

global type w_sottomastro_cx from w_p_data
int X=398
int Y=672
int Width=2560
int Height=1360
boolean TitleBar=true
string Title="Inserimento PDC - Conti"
dw_sottomastro_ff dw_sottomastro_ff
dw_conto_gd dw_conto_gd
end type
global w_sottomastro_cx w_sottomastro_cx

type variables
string  is_buffer_codice, is_buffer_item
boolean lb_read_only= FALSE
end variables

forward prototypes
public function integer uf_calcola_codice (long la_id_mastro, long la_id_sottomastro)
end prototypes

public function integer uf_calcola_codice (long la_id_mastro, long la_id_sottomastro);

DataWindowChild ldwc_id_mastro, ldwc_id_sottomastro
long ll_Curr_Row, ll_num_codice, ll_conto_codice, ll_id_mastro, ll_id_sottomastro
string ls_cod_mastro, ls_cod_sottomastro, ls_cod_ms, ls_conto_codice, ls_num_codice, ls_dddw_name1, ls_dddw_name2

ll_Curr_Row = dw_conto_gd.GetRow()
if not (IsNull(la_id_mastro) OR IsNull(la_id_sottomastro)) then
	 SELECT "mastro"."codice",   
				"sottomastro"."codice"  
		 INTO :ls_cod_mastro,   
				:ls_cod_sottomastro  
		 FROM "mastro",   
				"sottomastro"  
		WHERE ( "sottomastro"."id_mastro" = "mastro"."id_mastro" ) and  
				( ( "mastro"."id_mastro" = :la_id_mastro ) AND  
				( "sottomastro"."id_sottomastro" = :la_id_sottomastro ) )   ;
	
	IF (ls_cod_mastro <> "" AND ls_cod_sottomastro <> "") THEN
		ls_cod_ms = (ls_cod_mastro + ls_cod_sottomastro)
		SELECT Max(Convert(Numeric, Right("dba"."conto"."codice", 4)))
			INTO :ll_conto_codice
			FROM "dba"."conto"
			WHERE Left("dba"."conto"."codice", 4) = :ls_cod_ms;
			ll_conto_codice = ll_conto_codice + 1
			ls_num_codice = f_LPad(string(ll_conto_codice), "0", 4)
	else
		ls_num_codice=""
	END IF
else
	ls_num_codice=""
END IF
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			dw_conto_gd.SetItem(ll_Curr_Row, "cc_codice", ls_num_codice)
			dw_conto_gd.SetItem(ll_Curr_Row, "conto_codice",ls_cod_mastro + ls_cod_sottomastro + ls_num_codice)
	END CHOOSE

return 0

end function

on w_sottomastro_cx.create
int iCurrent
call super::create
this.dw_sottomastro_ff=create dw_sottomastro_ff
this.dw_conto_gd=create dw_conto_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sottomastro_ff
this.Control[iCurrent+2]=this.dw_conto_gd
end on

on w_sottomastro_cx.destroy
call super::destroy
destroy(this.dw_sottomastro_ff)
destroy(this.dw_conto_gd)
end on

event open;call super::open;il_HelpTopic = 179
idw_master = This.dw_sottomastro_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "sottomastro.id_sottomastro"

end event

event ue_post_open;call super::ue_post_open;
if dw_sottomastro_ff.uf_get_colval("uso") = 'C' OR dw_sottomastro_ff.uf_get_colval("uso") = 'F' then
	dw_conto_gd.Modify("conto_ges_par_aperte.protect = 1")
	dw_conto_gd.Modify("cc_codice.protect = 1")
	dw_conto_gd.Modify("conto_descrizione.protect = 1")
	cb_inserisci.Visible= false
	cb_cancella.Visible= false
	cb_salva.Visible= false
	lb_read_only = true
end if

end event

type p_crescente from w_p_data`p_crescente within w_sottomastro_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_sottomastro_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_sottomastro_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_sottomastro_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_sottomastro_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_sottomastro_cx
int X=1646
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_sottomastro_cx
int X=1943
boolean Enabled=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_sottomastro_cx
int X=2240
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_sottomastro_cx
int Y=1540
int Height=80
int TabOrder=30
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

type cb_ricerca from w_p_data`cb_ricerca within w_sottomastro_cx
boolean BringToTop=true
end type

type dw_sottomastro_ff from u_dw_master_main within w_sottomastro_cx
int X=46
int Y=160
int Width=2455
int Height=252
int TabOrder=10
string DataObject="d_sottomastro_ff"
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_sottomastro"
is_list.s_identifica[2] = "id_azienda"
iudw_children[1] = dw_conto_gd

end event

event ue_update;If not lb_read_only then
	super::event ue_update(wparam, lparam)
end if
end event

type dw_conto_gd from u_dw_master_main within w_sottomastro_cx
int X=46
int Y=440
int Width=2469
int Height=800
int TabOrder=20
string DataObject="d_conto_gd"
boolean TitleBar=true
string Title="Conti"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_title = "Inserimento PDC - Conti"
is_list.s_identifica[1] = "id_sottomastro"
is_list.s_identifica[2] = "id_azienda"
end event

event ue_initial;call super::ue_initial;long ll_total, ll_count, ll_codice, ll_max_codice = 0, ll_row
string ls_codice, l1,l2

ll_row = GetRow()
ll_total = RowCount()
for ll_count = 1 to ll_total - 1
	ls_codice = Mid(GetItemString(ll_count, "conto_codice"),5,4)
	ll_codice = Long(ls_codice)
	if ll_codice > 0 then
		ll_max_codice = Max(ll_codice, ll_max_codice)
	end if
next 
ls_codice = dw_sottomastro_ff.GetItemString(dw_sottomastro_ff.GetRow(), "mastro_codice") + &
	dw_sottomastro_ff.GetItemString(dw_sottomastro_ff.GetRow(), "codice") + f_lpad(String(ll_max_codice + 1), "0",4)
SetItem(ll_row, "conto_codice", Mid(ls_codice,1,8))
end event

event itemfocuschanged;call super::itemfocuschanged;string ls_codice
long ll_risposta, ll_row

ll_row = GetRow()
CHOOSE CASE dwo.name
	case "conto_codice"
		if is_buffer_item <> "conto_codice" then
			is_buffer_codice = dw_sottomastro_ff.GetItemString(dw_sottomastro_ff.GetRow(), "mastro_codice") + &
				dw_sottomastro_ff.GetItemString(dw_sottomastro_ff.GetRow(), "codice") + Mid(GetItemString(ll_row, "conto_codice"),5,4)
			is_buffer_item = "conto_codice"
		end if
END CHOOSE
end event

event ue_default;call super::ue_default;long ll_total, ll_count, ll_codice, ll_max_codice = 0
string ls_codice

CHOOSE CASE adwo_current.name
	CASE "conto_codice"
		ll_total = RowCount()
		for ll_count = 1 to ll_total - 1
			ls_codice = Mid(GetItemString(ll_count, "conto_codice"),5,4)
			ll_codice = Long(ls_codice)
			if ll_codice > 0 then
				ll_max_codice = Max(ll_codice, ll_max_codice)
			end if
		next 
		ls_codice = dw_sottomastro_ff.GetItemString(dw_sottomastro_ff.GetRow(), "mastro_codice") + &
			dw_sottomastro_ff.GetItemString(dw_sottomastro_ff.GetRow(), "codice") + f_lpad(String(ll_max_codice + 1), "0",4)
		SetItem(al_row, "conto_codice",  Mid(ls_codice,1,8))
END CHOOSE
end event

event itemchanged;string ls_nomecol, ls_codice, ls_original
long ll_risposta, ll_row
long ll_id_bilancio_cee, null_num, ll_riferimento

ls_nomecol = dwo.name

choose case ls_nomecol
	case "cc_codice"	
		ls_codice= uf_get_colval("conto_codice")
		ls_codice= Mid(ls_codice, 1, 4) + f_LPad(string(data), "0", 4)
		uf_set_colval("conto_codice", ls_codice)


   
	
	case "bilancio_cee_riferimento"
		SetNull(null_num)
		ll_row=getrow()
		
		ll_riferimento=dec(data)
	
		if isnull(ll_riferimento) then
			dw_conto_gd.SetItem(ll_row, "conto_id_bilancio_cee", null_num)
		end if		
		
	case else
		return 0
end choose
return 0


end event

event ue_itemerror;call super::ue_itemerror;CHOOSE CASE adwo_dwo.name
			CASE "conto_codice"
				MessageBox(is_title, "Codice errato. ", Exclamation!)
				return 1
END CHOOSE
end event

event ue_insert;If not lb_read_only then
	super::event ue_insert(wparam, lparam)
end if
end event

event ue_delete;If not lb_read_only then
	super::event ue_delete(wparam, lparam)
end if
end event

event ue_use_search;call super::ue_use_search;CHOOSE CASE as_nomecol
	CASE "bilancio_cee_riferimento"
		uf_set_colval("conto_id_bilancio_cee", is_ricpar.s_id_seg_value[1])		
		uf_set_colval("bilancio_cee_descrizione", is_ricpar.s_ausil_value[1])	
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
END CHOOSE
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "bilancio_cee_riferimento"
		is_search_window = "w_bilancio_cee_sw"
		is_ricpar.s_filter_value = as_valcol	
		is_ricpar.s_filter_name = "riferimento"
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE
end event

