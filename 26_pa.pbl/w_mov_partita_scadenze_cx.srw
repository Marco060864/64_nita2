forward
global type w_mov_partita_scadenze_cx from w_p_data
end type
type dw_mov_partita_partite_ff from u_dw_master_main within w_mov_partita_scadenze_cx
end type
type dw_mov_partita_scadenze_gd from u_dw_master_main within w_mov_partita_scadenze_cx
end type
end forward

global type w_mov_partita_scadenze_cx from w_p_data
int Width=2378
int Height=1429
boolean TitleBar=true
string Title="Scadenze"
dw_mov_partita_partite_ff dw_mov_partita_partite_ff
dw_mov_partita_scadenze_gd dw_mov_partita_scadenze_gd
end type
global w_mov_partita_scadenze_cx w_mov_partita_scadenze_cx

on w_mov_partita_scadenze_cx.create
int iCurrent
call w_p_data::create
this.dw_mov_partita_partite_ff=create dw_mov_partita_partite_ff
this.dw_mov_partita_scadenze_gd=create dw_mov_partita_scadenze_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_mov_partita_partite_ff
this.Control[iCurrent+2]=dw_mov_partita_scadenze_gd
end on

on w_mov_partita_scadenze_cx.destroy
call w_p_data::destroy
destroy(this.dw_mov_partita_partite_ff)
destroy(this.dw_mov_partita_scadenze_gd)
end on

event open;call super::open;idw_master = dw_mov_partita_partite_ff
idw_master.is_list = Message.PowerObjectParm

end event

type p_crescente from w_p_data`p_crescente within w_mov_partita_scadenze_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_mov_partita_scadenze_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_mov_partita_scadenze_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_mov_partita_scadenze_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_mov_partita_scadenze_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_mov_partita_scadenze_cx
int X=1463
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_mov_partita_scadenze_cx
int X=1761
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_mov_partita_scadenze_cx
int X=2058
boolean Visible=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_mov_partita_scadenze_cx
int X=51
int Y=1401
int Height=77
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2323
end type

type cb_ricerca from w_p_data`cb_ricerca within w_mov_partita_scadenze_cx
boolean BringToTop=true
end type

type dw_mov_partita_partite_ff from u_dw_master_main within w_mov_partita_scadenze_cx
int X=51
int Y=157
int Width=2268
int Height=241
int TabOrder=10
string DataObject="d_mov_partita_partite_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_par_aperta"
iudw_children[1] = dw_mov_partita_scadenze_gd

end event

type dw_mov_partita_scadenze_gd from u_dw_master_main within w_mov_partita_scadenze_cx
int X=55
int Y=433
int Width=2259
int Height=873
int TabOrder=3
string DataObject="d_mov_partita_scadenze_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_par_aperta"

end event

