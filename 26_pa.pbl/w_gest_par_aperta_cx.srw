forward
global type w_gest_par_aperta_cx from w_p_data
end type
type dw_par_aperta_ff from u_dw_master_main within w_gest_par_aperta_cx
end type
type dw_mov_partita_gd from u_dw_master_main within w_gest_par_aperta_cx
end type
end forward

global type w_gest_par_aperta_cx from w_p_data
int Width=2839
int Height=1708
boolean TitleBar=true
string Title="Gestione Partite Aperte"
dw_par_aperta_ff dw_par_aperta_ff
dw_mov_partita_gd dw_mov_partita_gd
end type
global w_gest_par_aperta_cx w_gest_par_aperta_cx

type variables
long il_par
long il_lire

end variables

forward prototypes
public subroutine uf_ricerca ()
public subroutine uf_setta_conto ()
end prototypes

public subroutine uf_ricerca ();

w_search_main lw_sm
long ll_id_par_aperta
s_ric_param ls_ricpar
string ls_SQL_cond, ls_dwcolname[], ls_dbfield[]

idw_master.is_ricpar.s_filter_name = "conto_codice"

ls_dwcolname[1] = "conto_codice"
ls_dwcolname[2] = "conto_descrizione"
ls_dwcolname[3] = "par_aperta_num_partita"
ls_dwcolname[4] = "par_aperta_data_partita"
ls_dwcolname[5] = "importo"

ls_dbfield[1] = "conto.codice"
ls_dbfield[2] = "conto.descrizione"
ls_dbfield[3] = "numero"
ls_dbfield[4] = "data"
ls_dbfield[5] = "par_aperta.importo"

ls_SQL_cond = f_get_SQL_cond(dw_par_aperta_ff, dw_par_aperta_ff.GetRow(), ls_dwcolname, ls_dbfield)
idw_master.is_ricpar.s_SQL_cond = ls_SQL_cond

idw_master.is_ricpar.b_imm_retrieve = TRUE

OpenWithParm(lw_sm, idw_master.is_ricpar, "w_par_aperta_sw")
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_id_par_aperta = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_par_aperta"
	idw_master.is_list.l_identifica[1] = ll_id_par_aperta
	
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
END IF

idw_master.SetFocus()
end subroutine

public subroutine uf_setta_conto ();string ls_des, ls_cod

SELECT codice, descrizione into :ls_cod, :ls_des 
from   conto where id_conto=:il_par;
dw_par_aperta_ff.setitem(1,'id_conto',il_par)
dw_par_aperta_ff.setitem(1,'conto_codice',ls_cod)
dw_par_aperta_ff.setitem(1,'conto_descrizione',ls_des)	
end subroutine

event open;call super::open;long ll_screenh
string ls_par
environment le_env

il_HelpTopic = 30
idw_master = dw_par_aperta_ff
ls_par=Message.StringParm
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "par_aperta.id_par_aperta"

ib_NonModale = TRUE

if Pos(ls_par, '@')>0 then
	il_par=long(Right(ls_par,len(ls_par) - 1) )
	idw_master.ias_key_name[1] = "id_par_aperta"
	idw_master.is_list.s_modo = modo_inserisci
	
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
else
	il_par=long(ls_par)
	idw_master.is_ricpar.b_imm_retrieve = TRUE
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_par_aperta"
	idw_master.is_list.l_identifica[1] = il_par	
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
END IF



select id_val_lire into :il_lire
from par_sistema;

end event

on w_gest_par_aperta_cx.create
int iCurrent
call super::create
this.dw_par_aperta_ff=create dw_par_aperta_ff
this.dw_mov_partita_gd=create dw_mov_partita_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_par_aperta_ff
this.Control[iCurrent+2]=this.dw_mov_partita_gd
end on

on w_gest_par_aperta_cx.destroy
call super::destroy
destroy(this.dw_par_aperta_ff)
destroy(this.dw_mov_partita_gd)
end on

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

event ue_post_open;call super::ue_post_open;if idw_master.is_list.s_modo = modo_inserisci then post uf_setta_conto()
cb_ricerca.visible=false
end event

type p_crescente from w_p_data`p_crescente within w_gest_par_aperta_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_gest_par_aperta_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_gest_par_aperta_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_gest_par_aperta_cx
int TabOrder=60
boolean BringToTop=true
boolean Cancel=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_gest_par_aperta_cx
int X=640
boolean BringToTop=true
end type

event cb_nuovo::clicked;

IF idw_master.uf_to_update() > 0 THEN idw_master.event ue_update (0,0)

idw_master.Reset()
idw_master.is_list.s_modo = modo_inserisci
idw_master.triggerevent("ue_insert")
idw_master.SetFocus()

end event

type cb_inserisci from w_p_data`cb_inserisci within w_gest_par_aperta_cx
int X=1824
int TabOrder=50
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_gest_par_aperta_cx
int X=2121
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_gest_par_aperta_cx
int X=2418
int TabOrder=40
boolean BringToTop=true
end type

event cb_salva::clicked;call super::clicked;


end event

type tab_1 from w_p_data`tab_1 within w_gest_par_aperta_cx
int X=1097
int Y=260
int Width=663
int Height=760
int TabOrder=30
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=16
int Width=626
int Height=728
boolean Visible=false
boolean Enabled=false
long BackColor=79741120
long TabBackColor=79741120
end type

type cb_ricerca from w_p_data`cb_ricerca within w_gest_par_aperta_cx
int X=1225
int Y=36
int Width=270
boolean Visible=false
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;

uf_ricerca()
end event

type dw_par_aperta_ff from u_dw_master_main within w_gest_par_aperta_cx
int X=23
int Y=144
int Width=2761
int Height=948
int TabOrder=20
string DataObject="d_par_aperta_ff"
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_par_aperta"
is_title = "Partite Aperte"
iudw_children[1] = dw_mov_partita_gd



end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
	
	CASE "conto_codice"
			is_search_window = "w_conto_coddes_sw"		
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
			
	CASE "conto_descrizione"
			is_search_window = "w_conto_coddes_sw"		
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		
END CHOOSE
end event

event ue_use_search;call super::ue_use_search;
CHOOSE CASE as_nomecol
	
	CASE "conto_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_descrizione", is_ricpar.s_ausil_value[1])

	CASE "conto_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_codice", is_ricpar.s_ausil_value[1])
		
END CHOOSE

end event

event itemchanged;

string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

ls_sql_cond = ""  

CHOOSE CASE dwo.name
		
	CASE 'chiusa_forzatamente'	
		
		if data='S' then 
			this.setitem(row,"stato",'C')
		else
			this.setitem(row,"stato",'A')
		end if	
	
	CASE 'conto_codice'
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "conto_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"codice", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'conto_descrizione'
		ls_dbc[1] = "id_conto"
		ls_dwc[1] = "id_conto"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "conto_codice"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "conto_descrizione"
		ll_ok = uf_autofind_col(dwo.Name, "conto", &
										"descrizione", "A", data, &
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	CASE 'tipo_fattura'	
		if data='C' then 
			dw_par_aperta_ff.setitem(1,'segno_iva',-1)
		else	
			dw_par_aperta_ff.setitem(1,'segno_iva',1)
		end if 
		
END CHOOSE

end event

event rowfocuschanged;
end event

event editchanged;
long ll_pos, ll_pos1, ll_imp

if dwo.name = "importo" then
   if il_lire=dw_par_aperta_ff.getitemnumber(1,'id_valuta') then
		ll_pos=pos(data,',')
		ll_pos1=pos(data,',00')
		if ll_pos>0 and ll_pos1=0 then
			if ll_pos>1 then
				ll_imp=long(left(data,ll_pos - 1))
			else 
				ll_imp=0
			end if	
			messagebox('Attenzione','In valuta lire non è possibile inserire cifre decimali')
			this.post setitem(1,'importo',ll_imp)
			return 2
		end if
	end if
end if		
	
end event

type dw_mov_partita_gd from u_dw_master_main within w_gest_par_aperta_cx
int X=14
int Y=1112
int Width=2770
int Height=500
int TabOrder=10
string DataObject="d_mov_partita_gd"
boolean TitleBar=true
string Title="Elenco Movimenti"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_par_aperta"
is_title = "Movimenti di Partite Aperte"

is_list.s_win_chiave[1] = "id_mov_partita"
is_list.s_win_zoom = "w_mov_scadenza_cx"

end event

event editchanged;
long ll_pos, ll_pos1, ll_imp

if dwo.name = "importo" then
   if il_lire=dw_par_aperta_ff.getitemnumber(1,'id_valuta') then
		ll_pos=pos(data,',')
		ll_pos1=pos(data,',00')
		if ll_pos>0 and ll_pos1=0 then
			if ll_pos>1 then
				ll_imp=long(left(data,ll_pos - 1))
			else 
				ll_imp=0
			end if	
			messagebox('Attenzione','In valuta lire non è possibile inserire cifre decimali')
			this.post setitem(1,'importo',ll_imp)
			return 2
		end if
	end if
end if		
	
end event

