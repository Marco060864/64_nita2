forward
global type w_mov_scadenza_cx from w_p_data
end type
type dw_mov_scadenza_gd from u_dw_master_main within w_mov_scadenza_cx
end type
type dw_mov_partita_ff from u_dw_master_main within w_mov_scadenza_cx
end type
end forward

global type w_mov_scadenza_cx from w_p_data
int Height=1149
boolean TitleBar=true
string Title="Movimenti di Scadenza"
dw_mov_scadenza_gd dw_mov_scadenza_gd
dw_mov_partita_ff dw_mov_partita_ff
end type
global w_mov_scadenza_cx w_mov_scadenza_cx

on w_mov_scadenza_cx.create
int iCurrent
call w_p_data::create
this.dw_mov_scadenza_gd=create dw_mov_scadenza_gd
this.dw_mov_partita_ff=create dw_mov_partita_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_mov_scadenza_gd
this.Control[iCurrent+2]=dw_mov_partita_ff
end on

on w_mov_scadenza_cx.destroy
call w_p_data::destroy
destroy(this.dw_mov_scadenza_gd)
destroy(this.dw_mov_partita_ff)
end on

event open;call super::open;idw_master = dw_mov_partita_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ias_key_name[1] = "id_mov_partita"
idw_master.is_list.s_modo = modo_modifica

end event

type p_crescente from w_p_data`p_crescente within w_mov_scadenza_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_mov_scadenza_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_mov_scadenza_cx
int TabOrder=20
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_mov_scadenza_cx
int TabOrder=30
boolean BringToTop=true
boolean Cancel=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_mov_scadenza_cx
int TabOrder=40
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_mov_scadenza_cx
int TabOrder=70
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_mov_scadenza_cx
int TabOrder=80
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_mov_scadenza_cx
int TabOrder=90
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_mov_scadenza_cx
int X=892
int Y=21
int Width=389
int Height=241
int TabOrder=50
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=353
int Height=121
end type

type cb_ricerca from w_p_data`cb_ricerca within w_mov_scadenza_cx
int TabOrder=60
boolean BringToTop=true
end type

type dw_mov_scadenza_gd from u_dw_master_main within w_mov_scadenza_cx
int X=46
int Y=161
int Width=2318
int Height=873
int TabOrder=10
string DataObject="d_mov_scadenza_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_title = "Movimenti di Scadenza"
is_list.s_identifica[1] = "id_mov_partita"
end event

event ue_default;call super::ue_default;

CHOOSE CASE string(adwo_current.name)
	CASE "mov_scadenza_data"
		THIS.SetItem(al_row, "mov_scadenza_data", Today())
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
	CASE "scadenza_data_scadenza"
		is_search_window = "w_scadenza_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "vs_scadenza_saldo_data_scadenza"
		is_ricpar.b_imm_retrieve = TRUE
	CASE "scadenza_importo"
		is_search_window = "w_scadenza_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "vs_scadenza_saldo_importo"
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "scadenza_data_scadenza", "scadenza_importo"
		uf_set_colval("scadenza_data_scadenza", is_ricpar.s_main_value)
		uf_set_colval("mov_scadenza_id_scadenza", is_ricpar.s_id_seg_value[1])
		uf_set_colval("scadenza_importo", is_ricpar.s_ausil_value[1])
		uf_set_colval("scadenza_tipo_scadenza", is_ricpar.s_ausil_value[2])
		uf_set_colval("sog_commerciale_codice", is_ricpar.s_ausil_value[3])
		uf_set_colval("anagrafica_rag_soc_1", is_ricpar.s_ausil_value[4])
		uf_set_colval("csaldo", is_ricpar.s_ausil_value[5])
END CHOOSE
end event

event ue_core_update;call super::ue_core_update;

THIS.Event ue_retrieve(0,0)
end event

type dw_mov_partita_ff from u_dw_master_main within w_mov_scadenza_cx
int X=46
int Y=161
int Width=2318
int Height=253
int TabOrder=100
boolean Enabled=false
string DataObject="d_mov_partita_ff"
end type

event ue_init;call super::ue_init;is_title = "Movimenti di Scadenza"
iudw_children[1] = dw_mov_scadenza_gd
is_list.s_identifica[1] = "id_mov_partita"
end event

