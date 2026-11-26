forward
global type w_tab_iva_ff from w_p_data
end type
type dw_tab_iva_ff from u_dw_master_main within w_tab_iva_ff
end type
end forward

global type w_tab_iva_ff from w_p_data
int Width=2871
int Height=1349
boolean TitleBar=true
string Title="Tabella IVA"
dw_tab_iva_ff dw_tab_iva_ff
end type
global w_tab_iva_ff w_tab_iva_ff

event open;call super::open;
il_HelpTopic = 89

idw_master = dw_tab_iva_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "tab_iva.id_tab_iva"
end event

on w_tab_iva_ff.create
int iCurrent
call w_p_data::create
this.dw_tab_iva_ff=create dw_tab_iva_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_tab_iva_ff
end on

on w_tab_iva_ff.destroy
call w_p_data::destroy
destroy(this.dw_tab_iva_ff)
end on

type p_crescente from w_p_data`p_crescente within w_tab_iva_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_tab_iva_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_tab_iva_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_tab_iva_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_tab_iva_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_tab_iva_ff
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_tab_iva_ff
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_tab_iva_ff
int X=2538
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_tab_iva_ff
int X=1761
int Y=1081
int Width=618
int Height=401
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=581
int Height=281
end type

type cb_ricerca from w_p_data`cb_ricerca within w_tab_iva_ff
boolean BringToTop=true
end type

type dw_tab_iva_ff from u_dw_master_main within w_tab_iva_ff
int X=46
int Y=181
int Width=2766
int Height=1041
int TabOrder=10
string DataObject="d_tab_iva_ff"
end type

event ue_init;call super::ue_init;is_title = "Tabella IVA"
end event

event itemchanged;call super::itemchanged;

if dwo.name="tipo_iva" then
	if data='N' then 
		this.setitem(1,"per_detrazione",0)
	end if
end if
if dwo.name="tipo_iva" then
	if data='D' then 
		this.setitem(1,"per_detrazione",100)
	end if
end if
end event

