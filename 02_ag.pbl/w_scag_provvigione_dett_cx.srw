forward
global type w_scag_provvigione_dett_cx from w_p_data
end type
type dw_scag_provvigione_dett_ff from u_dw_master_main within w_scag_provvigione_dett_cx
end type
type dw_scag_provvigione_dett_gd from u_dw_master_main within w_scag_provvigione_dett_cx
end type
end forward

global type w_scag_provvigione_dett_cx from w_p_data
int Width=2286
int Height=1297
boolean TitleBar=true
string Title="Scaglioni provvigioni Dettaglio"
dw_scag_provvigione_dett_ff dw_scag_provvigione_dett_ff
dw_scag_provvigione_dett_gd dw_scag_provvigione_dett_gd
end type
global w_scag_provvigione_dett_cx w_scag_provvigione_dett_cx

type variables
string is_dw_ff_text
end variables

on w_scag_provvigione_dett_cx.create
int iCurrent
call w_p_data::create
this.dw_scag_provvigione_dett_ff=create dw_scag_provvigione_dett_ff
this.dw_scag_provvigione_dett_gd=create dw_scag_provvigione_dett_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_scag_provvigione_dett_ff
this.Control[iCurrent+2]=dw_scag_provvigione_dett_gd
end on

on w_scag_provvigione_dett_cx.destroy
call w_p_data::destroy
destroy(this.dw_scag_provvigione_dett_ff)
destroy(this.dw_scag_provvigione_dett_gd)
end on

event open;call super::open;il_helpTopic = 528
idw_master = dw_scag_provvigione_dett_ff
idw_master.is_list = Message.PowerObjectParm
is_dw_ff_text = idw_master.is_list.s_win_parametri



end event

type p_crescente from w_p_data`p_crescente within w_scag_provvigione_dett_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_scag_provvigione_dett_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_scag_provvigione_dett_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_scag_provvigione_dett_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_scag_provvigione_dett_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_scag_provvigione_dett_cx
int X=1372
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_scag_provvigione_dett_cx
int X=1669
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_scag_provvigione_dett_cx
int X=1966
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_scag_provvigione_dett_cx
int Y=1401
int Height=81
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

type cb_ricerca from w_p_data`cb_ricerca within w_scag_provvigione_dett_cx
boolean BringToTop=true
end type

type dw_scag_provvigione_dett_ff from u_dw_master_main within w_scag_provvigione_dett_cx
int X=46
int Y=161
int Width=2181
int Height=233
int TabOrder=10
string DataObject="d_scag_provvigione_dett_ff"
end type

event ue_init;call super::ue_init;
iudw_children[1] = dw_scag_provvigione_dett_gd
is_title = "Scaglione Provvigioni Dettaglio"


end event

event getfocus;call super::getfocus;long			ll_row
integer		li_idx, li_mpx
string		ls_ws[]

ll_row = THIS.GetRow()
IF NOT(ll_row = 1) THEN
	RETURN
END IF	
FOR li_idx = 0 TO 5
	 li_mpx = li_idx * 40
	 ls_ws[li_idx + 1] = Mid(is_dw_ff_text, li_mpx + 1, 40)
NEXT	
FOR li_idx = 1 TO 6
	 RightTrim(ls_ws[li_idx])
NEXT
THIS.Object.gruppo_agenti_codice_t.text = ls_ws[1]
THIS.SetItem(1, "c_gruppo_agenti_cod", ls_ws[2])
THIS.SetItem(1, "c_gruppo_agenti_des", ls_ws[3])
THIS.Object.sog_commerciale_codice_t.text = ls_ws[4]
THIS.SetItem(1, "c_sog_comm_cod", ls_ws[5])
THIS.SetItem(1, "c_sog_comm_des", ls_ws[6])

end event

type dw_scag_provvigione_dett_gd from u_dw_master_main within w_scag_provvigione_dett_cx
int X=46
int Y=421
int Width=2181
int TabOrder=3
string DataObject="d_scag_provvigione_dett_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_con_provvigioni"
is_title = "Scaglioni Provvigioni"
end event

event constructor;call super::constructor;string	ls_mask, ls_w
long		ll_w				

ls_mask= Describe("sconto_t.x")
if IsNull(ls_mask) then ls_mask=""
ls_mask= f_get_dwo_property(ls_mask, "", "Long(Describe('scag_provvigione_da_per_sconto.x'))")
Modify("sconto_t.x=" + ls_mask)
ls_mask= Describe("capoarea_t.x")
if IsNull(ls_mask) then ls_mask=""
ls_mask= f_get_dwo_property(ls_mask, "", "Long(Describe('scag_provvigione_per_prov_capo_area.x'))")
Modify("capoarea_t.x=" + ls_mask)
ls_mask= Describe("agente_t.x")
if IsNull(ls_mask) then ls_mask=""
ls_mask= f_get_dwo_property(ls_mask, "", "Long(Describe('scag_provvigione_per_prov_agente.x'))")
Modify("agente_t.x=" + ls_mask)
ls_mask= Describe("subagente_t.x")
if IsNull(ls_mask) then ls_mask=""
ls_mask= f_get_dwo_property(ls_mask, "", "Long(Describe('scag_provvigione_per_prov_sub_agente.x'))")
Modify("subagente_t.x=" + ls_mask)
ls_mask= Describe("line.X1")
if IsNull(ls_mask) then ls_mask=""
ls_mask = f_get_dwo_property(ls_mask, "", "Long(Describe('scag_provvigione_da_per_sconto.x'))")
Modify("line.X1=" + ls_mask)
ls_mask= Describe("line.X2")
if IsNull(ls_mask) then ls_mask=""
ls_mask = f_get_dwo_property(ls_mask, "", "(Long(Describe('scag_provvigione_imp_prov_sub_agente.x'))+Long(Describe('scag_provvigione_imp_prov_sub_agente.width')))")
Modify("line.X2=" + ls_mask)

end event

