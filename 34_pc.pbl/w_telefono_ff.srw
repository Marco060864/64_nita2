forward
global type w_telefono_ff from w_p_data
end type
type dw_telefono_ff from u_dw_master_main within w_telefono_ff
end type
end forward

global type w_telefono_ff from w_p_data
int Height=729
boolean TitleBar=true
string Title="Telefoni"
dw_telefono_ff dw_telefono_ff
end type
global w_telefono_ff w_telefono_ff

on w_telefono_ff.create
int iCurrent
call w_p_data::create
this.dw_telefono_ff=create dw_telefono_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_telefono_ff
end on

on w_telefono_ff.destroy
call w_p_data::destroy
destroy(this.dw_telefono_ff)
end on

event open;call super::open;idw_master = dw_telefono_ff
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "telefono.id_telefono"
end event

type p_crescente from w_p_data`p_crescente within w_telefono_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_telefono_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_telefono_ff
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_telefono_ff
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_telefono_ff
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_telefono_ff
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_telefono_ff
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_telefono_ff
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_telefono_ff
int X=1075
int Y=21
int Width=275
int Height=141
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=238
int Height=21
end type

type cb_ricerca from w_p_data`cb_ricerca within w_telefono_ff
boolean BringToTop=true
end type

type dw_telefono_ff from u_dw_master_main within w_telefono_ff
int X=46
int Y=161
int Width=2341
int Height=453
int TabOrder=10
string DataObject="d_telefono_ff"
end type

event ue_init;call super::ue_init;is_title = "Telefoni"
end event

