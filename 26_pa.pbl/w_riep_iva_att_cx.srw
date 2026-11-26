forward
global type w_riep_iva_att_cx from w_p_data
end type
type dw_attivita_azienda_ff from u_dw_master_main within w_riep_iva_att_cx
end type
type dw_riep_iva_att_gd from u_dw_master_main within w_riep_iva_att_cx
end type
end forward

global type w_riep_iva_att_cx from w_p_data
int Width=2693
int Height=1509
boolean TitleBar=true
string Title="Progressivi I.V.A. per Attività"
dw_attivita_azienda_ff dw_attivita_azienda_ff
dw_riep_iva_att_gd dw_riep_iva_att_gd
end type
global w_riep_iva_att_cx w_riep_iva_att_cx

on w_riep_iva_att_cx.create
int iCurrent
call w_p_data::create
this.dw_attivita_azienda_ff=create dw_attivita_azienda_ff
this.dw_riep_iva_att_gd=create dw_riep_iva_att_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_attivita_azienda_ff
this.Control[iCurrent+2]=dw_riep_iva_att_gd
end on

on w_riep_iva_att_cx.destroy
call w_p_data::destroy
destroy(this.dw_attivita_azienda_ff)
destroy(this.dw_riep_iva_att_gd)
end on

event open;call super::open;il_HelpTopic = 183
idw_master = dw_attivita_azienda_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "attivita.id_attivita"
end event

type p_crescente from w_p_data`p_crescente within w_riep_iva_att_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_riep_iva_att_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_riep_iva_att_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_riep_iva_att_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_riep_iva_att_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_riep_iva_att_cx
int X=1751
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_riep_iva_att_cx
int X=2049
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_riep_iva_att_cx
int X=2346
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_riep_iva_att_cx
int X=92
int Y=181
int Width=206
int Height=101
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=170
end type

type cb_ricerca from w_p_data`cb_ricerca within w_riep_iva_att_cx
int X=1454
boolean BringToTop=true
end type

type dw_attivita_azienda_ff from u_dw_master_main within w_riep_iva_att_cx
int X=46
int Y=161
int Width=2583
int Height=141
int TabOrder=10
string DataObject="d_attivita_azienda_ff"
end type

event ue_init;call super::ue_init;
iudw_children[1] = dw_riep_iva_att_gd

end event

type dw_riep_iva_att_gd from u_dw_master_main within w_riep_iva_att_cx
int X=46
int Y=321
int Width=2583
int Height=1041
int TabOrder=3
string DataObject="d_riep_iva_att_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_attivita"

end event

