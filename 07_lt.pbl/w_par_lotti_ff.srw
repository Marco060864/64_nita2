forward
global type w_par_lotti_ff from w_p_data
end type
type dw_lotti_par_sistema_ff from u_dw_master_main within w_par_lotti_ff
end type
end forward

global type w_par_lotti_ff from w_p_data
int X=183
int Y=852
int Width=2240
int Height=1036
boolean TitleBar=true
string Title="Parametri di sistema ~"Gestione Lotti~""
dw_lotti_par_sistema_ff dw_lotti_par_sistema_ff
end type
global w_par_lotti_ff w_par_lotti_ff

on w_par_lotti_ff.create
int iCurrent
call super::create
this.dw_lotti_par_sistema_ff=create dw_lotti_par_sistema_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lotti_par_sistema_ff
end on

on w_par_lotti_ff.destroy
call super::destroy
destroy(this.dw_lotti_par_sistema_ff)
end on

event open;call super::open;

idw_master = dw_lotti_par_sistema_ff
idw_master.is_list = Message.PowerObjectParm

end event

event ue_post_open;call super::ue_post_open;dw_lotti_par_sistema_ff.retrieve()
end event

type p_crescente from w_p_data`p_crescente within w_par_lotti_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_par_lotti_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_par_lotti_ff
int X=37
int Y=32
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_par_lotti_ff
int X=329
int Y=32
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_par_lotti_ff
int X=622
int Y=32
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_par_lotti_ff
int X=1353
int Y=32
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_par_lotti_ff
int X=1646
int Y=32
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_par_lotti_ff
int X=1938
int Y=32
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_par_lotti_ff
int Y=1316
int Height=168
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2322
int Height=48
end type

type cb_ricerca from w_p_data`cb_ricerca within w_par_lotti_ff
int X=1047
int Y=32
boolean BringToTop=true
end type

type dw_lotti_par_sistema_ff from u_dw_master_main within w_par_lotti_ff
int X=32
int Y=164
int Width=2167
int Height=768
int TabOrder=10
boolean BringToTop=true
string DataObject="d_lotti_par_sistema_ff"
end type

