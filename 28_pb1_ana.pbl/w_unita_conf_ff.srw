forward
global type w_unita_conf_ff from w_p_data
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
type dw_1 from u_dw_master_main within tabpage_1
end type
end forward

global type w_unita_conf_ff from w_p_data
int X=480
int Y=412
int Width=2715
int Height=1360
boolean TitleBar=true
string Title="Unità confezione di base"
end type
global w_unita_conf_ff w_unita_conf_ff

on w_unita_conf_ff.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_unita_conf_ff.destroy
call super::destroy
end on

event open;call super::open;idw_master = tab_1.tabpage_1.dw_1
idw_master.is_list = Message.PowerObjectParm

If upperbound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.is_list.s_modo = modo_inserisci
END IF

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "unita_conf_base.id_unita_conf_base"
end event

event ue_post_open;call super::ue_post_open;

cb_ricerca.visible = TRUE

end event

event key;call super::key;

Keycode	lk_code
string	ls_nome	
lk_code = key

IF (keyFlags=2) THEN
	CHOOSE CASE lk_code
	CASE Keyadd!
		cb_inserisci.triggerevent(Clicked!)
	
	CASE KeySubtract!
		cb_cancella.triggerevent(Clicked!)
		
	END CHOOSE	
END IF
end event

event ue_master_delete;call super::ue_master_delete;
if (idw_master.Event ue_delete(0, 0) = 0) then
	ib_AskForSave = false
	IF (idw_master.Event ue_update(0, 0) = 0) then
		ib_AskForSave = true
		idw_master.is_list.s_modo = modo_inserisci
		idw_master.Event ue_insert(0, 0)
	else
		idw_master.Event ue_retrieve(0, 0)
	end if
	idw_master.SetItemStatus(idw_master.GetRow(), 0, Primary!, NotModified!)
end if
idw_master.SetFocus()
end event

type p_crescente from w_p_data`p_crescente within w_unita_conf_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_unita_conf_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_unita_conf_ff
int X=37
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_unita_conf_ff
int X=329
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_unita_conf_ff
int X=622
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_unita_conf_ff
int X=1829
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_unita_conf_ff
int X=2121
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_unita_conf_ff
int X=2414
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_unita_conf_ff
int X=32
int Y=160
int Width=2647
int Height=1096
boolean BringToTop=true
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2610
int Height=976
long BackColor=79741120
string Text="Unità confezione di base"
long TabBackColor=79741120
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_1)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_unita_conf_ff
int X=1202
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;
String ls_codice
long ll_seg_value
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="codice"
openwithparm(lw_sm,idw_master.is_ricpar,"w_unita_conf_base_coddes_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_unita_conf_base"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if
end event

type dw_1 from u_dw_master_main within tabpage_1
int X=14
int Y=20
int Width=2574
int Height=940
int TabOrder=21
string DataObject="d_unita_conf_base_ff"
end type

