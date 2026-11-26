forward
global type w_prezzo_unita_conf_cx from w_p_data
end type
type dw_prezzo_unita_conf_gd from u_dw_master_main within w_prezzo_unita_conf_cx
end type
type dw_listino_unita_confezione_ff from u_dw_master_main within w_prezzo_unita_conf_cx
end type
end forward

global type w_prezzo_unita_conf_cx from w_p_data
int Width=2167
int Height=1213
boolean TitleBar=true
string Title="Prezzi per Unità Confezione"
dw_prezzo_unita_conf_gd dw_prezzo_unita_conf_gd
dw_listino_unita_confezione_ff dw_listino_unita_confezione_ff
end type
global w_prezzo_unita_conf_cx w_prezzo_unita_conf_cx

event open;call super::open;idw_master = dw_listino_unita_confezione_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_unita_confezione"
idw_master.is_list.s_sql_ident[2] = "id_listino"
end event

on w_prezzo_unita_conf_cx.create
int iCurrent
call w_p_data::create
this.dw_prezzo_unita_conf_gd=create dw_prezzo_unita_conf_gd
this.dw_listino_unita_confezione_ff=create dw_listino_unita_confezione_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_prezzo_unita_conf_gd
this.Control[iCurrent+2]=dw_listino_unita_confezione_ff
end on

on w_prezzo_unita_conf_cx.destroy
call w_p_data::destroy
destroy(this.dw_prezzo_unita_conf_gd)
destroy(this.dw_listino_unita_confezione_ff)
end on

event ue_post_open;call super::ue_post_open;
idw_master.iudw_children[1].SetFocus()
end event

type p_crescente from w_p_data`p_crescente within w_prezzo_unita_conf_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_prezzo_unita_conf_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_prezzo_unita_conf_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_prezzo_unita_conf_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_prezzo_unita_conf_cx
int X=641
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_prezzo_unita_conf_cx
int X=1258
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_prezzo_unita_conf_cx
int X=1555
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_prezzo_unita_conf_cx
int X=1852
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_prezzo_unita_conf_cx
int Y=821
int Width=2355
int Height=661
int TabOrder=30
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=2318
int Height=541
end type

type cb_ricerca from w_p_data`cb_ricerca within w_prezzo_unita_conf_cx
boolean BringToTop=true
end type

type dw_prezzo_unita_conf_gd from u_dw_master_main within w_prezzo_unita_conf_cx
int X=298
int Y=441
int Width=1532
int Height=641
int TabOrder=20
string DataObject="d_prezzo_unita_conf_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;

is_list.s_identifica[1] = "id_unita_confezione"
is_list.s_identifica[2] = "id_listino"
end event

event ue_retrieve;

datawindowchild ldwc_data
long ll_id_listino
string ls_par_value

ll_id_listino = is_list.l_identifica[2]

IF This.GetChild("id_variazione_inizio", ldwc_data) = 1 THEN
	ldwc_data.SetTransObject(SQLCA)
	ldwc_data.Retrieve(ll_id_listino)
END IF

IF This.GetChild("id_variazione_fine", ldwc_data) = 1 THEN
	ldwc_data.SetTransObject(SQLCA)
	ldwc_data.Retrieve(ll_id_listino)
END IF

CALL super::ue_retrieve

end event

type dw_listino_unita_confezione_ff from u_dw_master_main within w_prezzo_unita_conf_cx
int X=23
int Y=161
int Width=2081
int Height=241
int TabOrder=10
boolean Enabled=false
string DataObject="d_listino_unita_confezione_ff"
end type

event ue_init;call super::ue_init;

is_title = "Prezzi per Unità Confezione"
is_list.s_identifica[1] = "id_unita_confezione"
is_list.s_identifica[2] = "id_listino"

iudw_children[1] = dw_prezzo_unita_conf_gd
end event

event getfocus;
end event

