forward
global type w_bilancio_cee_cx from w_p_data
end type
type dw_bilancio_cee_ff from u_dw_master_main within w_bilancio_cee_cx
end type
end forward

global type w_bilancio_cee_cx from w_p_data
int Height=977
boolean TitleBar=true
string Title="Gestione PDC CEE"
dw_bilancio_cee_ff dw_bilancio_cee_ff
end type
global w_bilancio_cee_cx w_bilancio_cee_cx

on w_bilancio_cee_cx.create
int iCurrent
call w_p_data::create
this.dw_bilancio_cee_ff=create dw_bilancio_cee_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_bilancio_cee_ff
end on

on w_bilancio_cee_cx.destroy
call w_p_data::destroy
destroy(this.dw_bilancio_cee_ff)
end on

event open;call super::open;
idw_master = dw_bilancio_cee_ff
idw_master.is_list = Message.PowerObjectParm
IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "bilancio_cee.id_bilancio_cee"
	idw_master.is_list.s_modo = modo_inserisci	
	ib_nonmodale=true
END IF
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "bilancio_cee.id_bilancio_cee"
end event

event key;call super::key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			This.Event ue_help(Topic!, il_HelpTopic, "")
		end if
end choose
end event

type p_crescente from w_p_data`p_crescente within w_bilancio_cee_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_bilancio_cee_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_bilancio_cee_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_bilancio_cee_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_bilancio_cee_cx
boolean Enabled=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_bilancio_cee_cx
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_bilancio_cee_cx
boolean Enabled=false
boolean BringToTop=true
end type

event cb_cancella::clicked;call super::clicked;dw_bilancio_cee_ff.deleterow(0)
ib_askforsave=false
cb_salva.triggerevent(clicked!)
dw_bilancio_cee_ff.insertrow(0)
end event

type cb_salva from w_p_data`cb_salva within w_bilancio_cee_cx
boolean Enabled=false
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_bilancio_cee_cx
int X=938
int Y=381
int Width=412
int Height=221
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=17
int Width=375
int Height=189
boolean Visible=false
long BackColor=79741120
long TabBackColor=79741120
end type

type cb_ricerca from w_p_data`cb_ricerca within w_bilancio_cee_cx
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;	s_ric_param controllo
	boolean lb_inizializza
	long ll_prova
	string ls_filtro,ls_codice
	
	w_search_main lw_sm
	ls_codice=""
	idw_master.is_ricpar.s_filter_value=ls_codice
	idw_master.is_ricpar.s_filter_name="riferimento"
	controllo=idw_master.is_ricpar
	openwithparm(lw_sm,idw_master.is_ricpar,"w_bilancio_cee_sw")
	idw_master.is_ricpar=message.powerobjectparm
	if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
		ll_prova=long(idw_master.is_ricpar.s_id_seg_value[1])
		idw_master.is_list.s_modo=modo_modifica
		idw_master.is_list.s_identifica[1]="id_bilancio_cee"
		idw_master.is_list.l_identifica[1]=ll_prova
		idw_master.event ue_retrieve(0,0)
		idw_master.setfocus()
	end if
end event

type dw_bilancio_cee_ff from u_dw_master_main within w_bilancio_cee_cx
int X=23
int Y=201
int Width=2355

int Height=661
int TabOrder=3
string DataObject="d_bilancio_cee_ff"
end type

