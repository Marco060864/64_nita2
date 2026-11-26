forward
global type w_sede_ff from w_p_data
end type
type dw_1 from u_dw_master_main within w_sede_ff
end type
end forward

global type w_sede_ff from w_p_data
int Width=1637
int Height=977
boolean TitleBar=true
string Title="Gestione Dettaglio Sede"
dw_1 dw_1
end type
global w_sede_ff w_sede_ff

event open;call super::open;il_HelpTopic = 187
idw_master = dw_1
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "sede.id_sede"

end event

on w_sede_ff.create
int iCurrent
call w_p_data::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_1
end on

on w_sede_ff.destroy
call w_p_data::destroy
destroy(this.dw_1)
end on

type p_crescente from w_p_data`p_crescente within w_sede_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_sede_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_sede_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_sede_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_sede_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_sede_ff
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_sede_ff
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_sede_ff
int X=1258
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_sede_ff
int X=892
int Y=401
int Width=1189
int Height=481
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=1153
int Height=361
end type

type cb_ricerca from w_p_data`cb_ricerca within w_sede_ff
boolean BringToTop=true
end type

type dw_1 from u_dw_master_main within w_sede_ff
int X=46
int Y=181
int Width=1509
int Height=681
int TabOrder=10
string DataObject="d_sede_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_sede"
end event

