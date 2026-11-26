forward
global type w_listino_var_articolo_cx from w_p_data
end type
type dw_listino_var_articolo_lt from u_dw_master_main within w_listino_var_articolo_cx
end type
type dw_listino_articolo_ff from u_dw_master_main within w_listino_var_articolo_cx
end type
end forward

global type w_listino_var_articolo_cx from w_p_data
int Width=2583
int Height=1073
boolean TitleBar=true
string Title="Prezzi Unità Confezione per Listino"
dw_listino_var_articolo_lt dw_listino_var_articolo_lt
dw_listino_articolo_ff dw_listino_articolo_ff
end type
global w_listino_var_articolo_cx w_listino_var_articolo_cx

event open;call super::open;idw_master = dw_listino_articolo_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "articolo.id_articolo"
idw_master.is_list.s_sql_ident[2] = "listino.id_listino"


cb_cancella.Enabled = FALSE
cb_inserisci.Enabled = FALSE
cb_nuovo.Enabled = FALSE
cb_salva.Enabled = FALSE
end event

on w_listino_var_articolo_cx.create
int iCurrent
call w_p_data::create
this.dw_listino_var_articolo_lt=create dw_listino_var_articolo_lt
this.dw_listino_articolo_ff=create dw_listino_articolo_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_listino_var_articolo_lt
this.Control[iCurrent+2]=dw_listino_articolo_ff
end on

on w_listino_var_articolo_cx.destroy
call w_p_data::destroy
destroy(this.dw_listino_var_articolo_lt)
destroy(this.dw_listino_articolo_ff)
end on

event ue_post_open;call super::ue_post_open;
idw_master.iudw_children[1].SetFocus()
end event

type p_crescente from w_p_data`p_crescente within w_listino_var_articolo_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_listino_var_articolo_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_listino_var_articolo_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_listino_var_articolo_cx
boolean BringToTop=true
string Text="Chiudi"
end type

type cb_nuovo from w_p_data`cb_nuovo within w_listino_var_articolo_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_listino_var_articolo_cx
int X=1646
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_listino_var_articolo_cx
int X=1943
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_listino_var_articolo_cx
int X=2241
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_listino_var_articolo_cx
int Y=1001
int Width=2355
int Height=481
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2318
int Height=361
end type

type cb_ricerca from w_p_data`cb_ricerca within w_listino_var_articolo_cx
boolean BringToTop=true
end type

type dw_listino_var_articolo_lt from u_dw_master_main within w_listino_var_articolo_cx
int X=23
int Y=401
int Width=2515
int Height=541
int TabOrder=10
string DataObject="d_listino_var_articolo_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_articolo"
is_list.s_identifica[2] = "id_listino"
is_resp_window = "w_prezzo_unita_conf_cx"
is_list.s_win_chiave[1] = "id_unita_confezione"
is_list.s_win_chiave[2] = "id_listino"
end event

event ue_delete;

RETURN 0
end event

event ue_insert;

RETURN 0
end event

event ue_key;

integer li_ret, li_cdw
string ls_tipof
w_data_main lw_win
w_p_data lw_pwin

choose case key
	case KeyF6!
		lw_win = u_freddie.iw_current
		ls_tipof = lw_win.is_wintype
		if ls_tipof = "W_P_DATA" then
			if (keyflags=0) then		
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw++
					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
			if (keyFlags=1) then		
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw --
					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
		end if
end choose
end event

event ue_update;

RETURN 0
end event

type dw_listino_articolo_ff from u_dw_master_main within w_listino_var_articolo_cx
int X=23
int Y=181
int Width=2515
int Height=201
int TabOrder=3
string DataObject="d_listino_articolo_ff"
end type

event ue_init;call super::ue_init;is_title = "Prezzi per Articolo e Listino"
is_list.s_identifica[1] = "id_articolo"
is_list.s_identifica[2] = "id_listino"

iudw_children[1] = dw_listino_var_articolo_lt
end event

event getfocus;

RETURN 0
end event

event ue_delete;

RETURN 0
end event

event ue_insert;

RETURN 0
end event

event ue_update;

RETURN 0
end event

event ue_modify;
end event

