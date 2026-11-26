forward
global type w_elem_pac_list_ff from w_p_data
end type
type dw_elem_pac_list_ff from u_dw_master_main within w_elem_pac_list_ff
end type
end forward

global type w_elem_pac_list_ff from w_p_data
int Width=2743
int Height=1149
boolean TitleBar=true
string Title="Elemento Packing List"
dw_elem_pac_list_ff dw_elem_pac_list_ff
end type
global w_elem_pac_list_ff w_elem_pac_list_ff

event open;call super::open;idw_master = dw_elem_pac_list_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "elem_pac_list.id_elem_pac_list"
end event

on w_elem_pac_list_ff.create
int iCurrent
call w_p_data::create
this.dw_elem_pac_list_ff=create dw_elem_pac_list_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_elem_pac_list_ff
end on

on w_elem_pac_list_ff.destroy
call w_p_data::destroy
destroy(this.dw_elem_pac_list_ff)
end on

type p_crescente from w_p_data`p_crescente within w_elem_pac_list_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_elem_pac_list_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_elem_pac_list_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_elem_pac_list_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_elem_pac_list_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_elem_pac_list_ff
int X=1806
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_elem_pac_list_ff
int X=2103
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_elem_pac_list_ff
int X=2401
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_elem_pac_list_ff
int X=1852
int Y=1121
int Width=526
int Height=361
int TabOrder=20
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=490
int Height=241
end type

type dw_elem_pac_list_ff from u_dw_master_main within w_elem_pac_list_ff
int X=46
int Y=181
int Width=2638
int Height=853
int TabOrder=10
string DataObject="d_elem_pac_list_ff"
end type

event ue_init;call super::ue_init;is_title = "Elemento Packing List"
end event

