forward
global type w_tipo_cod_barre_cx from w_p_data
end type
type dw_tipo_cod_barre_ff from u_dw_master_main within w_tipo_cod_barre_cx
end type
type dw_parti_tipo_cod_barre_gd from u_dw_master_main within w_tipo_cod_barre_cx
end type
end forward

global type w_tipo_cod_barre_cx from w_p_data
int Width=2606
int Height=1296
boolean TitleBar=true
string Title="Tipologie di codice a barre"
dw_tipo_cod_barre_ff dw_tipo_cod_barre_ff
dw_parti_tipo_cod_barre_gd dw_parti_tipo_cod_barre_gd
end type
global w_tipo_cod_barre_cx w_tipo_cod_barre_cx

on w_tipo_cod_barre_cx.create
int iCurrent
call super::create
this.dw_tipo_cod_barre_ff=create dw_tipo_cod_barre_ff
this.dw_parti_tipo_cod_barre_gd=create dw_parti_tipo_cod_barre_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tipo_cod_barre_ff
this.Control[iCurrent+2]=this.dw_parti_tipo_cod_barre_gd
end on

on w_tipo_cod_barre_cx.destroy
call super::destroy
destroy(this.dw_tipo_cod_barre_ff)
destroy(this.dw_parti_tipo_cod_barre_gd)
end on

event open;call super::open;il_HelpTopic = 43

idw_master = dw_tipo_cod_barre_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_tipo_cod_barre"
	idw_master.is_list.s_modo=modo_inserisci
end if
ib_nonmodale = TRUE
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "tipo_cod_barre.id_tipo_cod_barre"
end event

event ue_master_delete;
end event

type p_crescente from w_p_data`p_crescente within w_tipo_cod_barre_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_tipo_cod_barre_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_tipo_cod_barre_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_tipo_cod_barre_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_tipo_cod_barre_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_tipo_cod_barre_cx
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_tipo_cod_barre_cx
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_tipo_cod_barre_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_tipo_cod_barre_cx
int Y=1364
int Height=116
int TabOrder=30
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2322
end type

type cb_ricerca from w_p_data`cb_ricerca within w_tipo_cod_barre_cx
boolean BringToTop=true
end type

event cb_ricerca::clicked;string ls_filtro,ls_codice
long ll_seg_value
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="id_tipo_cod_barre"
openwithparm(lw_sm,idw_master.is_ricpar,"w_tipo_cod_barre_coddes_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_tipo_cod_barre"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if
end event

type dw_tipo_cod_barre_ff from u_dw_master_main within w_tipo_cod_barre_cx
int X=32
int Y=160
int Width=2533
int Height=484
int TabOrder=10
boolean BringToTop=true
string DataObject="d_tipo_cod_barre_ff"
boolean TitleBar=true
string Title="Tipologia di codice a barre"
end type

event ue_init;call super::ue_init;is_title = "Tipologie di codice a barre"
is_list.s_identifica[1] = "id_tipo_cod_barre"
iudw_children[1] = dw_parti_tipo_cod_barre_gd
end event

type dw_parti_tipo_cod_barre_gd from u_dw_master_main within w_tipo_cod_barre_cx
int X=32
int Y=672
int Width=2533
int Height=516
int TabOrder=20
boolean BringToTop=true
string DataObject="d_parti_tipo_cod_barre_gd"
boolean TitleBar=true
string Title="Composizione"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_tipo_cod_barre"
end event

event itemchanged;String	ls_alfanumerico, ls_valore, ls_codice 
choose case dwo.name
	case "valore"
		
		ls_alfanumerico = dw_tipo_cod_barre_ff.Object.alfanumerico[1]
		ls_codice = dw_tipo_cod_barre_ff.Object.codice[1]
		
		if ls_alfanumerico <> 'S' and not isnull(data) and data <> ' ' and not isnumber(data) then
			messagebox("Tipologie dei codici a barre", "La tipologia " + ls_codice + &
				  "  ~r~nsupporta solamente codici numerici !!!")			
			return 2
		end if
end choose
end event

