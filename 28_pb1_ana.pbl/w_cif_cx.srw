forward
global type w_cif_cx from w_p_data
end type
type dw_cif_ff from u_dw_master_main within w_cif_cx
end type
type dw_spesa_cif_gd from u_dw_master_main within w_cif_cx
end type
end forward

global type w_cif_cx from w_p_data
int Width=2418
boolean TitleBar=true
string Title="CIF"
dw_cif_ff dw_cif_ff
dw_spesa_cif_gd dw_spesa_cif_gd
end type
global w_cif_cx w_cif_cx

on w_cif_cx.create
int iCurrent
call super::create
this.dw_cif_ff=create dw_cif_ff
this.dw_spesa_cif_gd=create dw_spesa_cif_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cif_ff
this.Control[iCurrent+2]=this.dw_spesa_cif_gd
end on

on w_cif_cx.destroy
call super::destroy
destroy(this.dw_cif_ff)
destroy(this.dw_spesa_cif_gd)
end on

event open;call super::open;
idw_master = dw_cif_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_cif"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "cif.id_cif"
 
 ib_nonmodale=true
end event

event ue_master_delete;call super::ue_master_delete;
long ll_riga_corrente
integer ll_ret

if dw_spesa_cif_gd.rowcount()>0 then
	ll_ret=messagebox("Attenzione!", "Esistono righe legate a questo CIF,~r~n " &
		+"volete cancellarle tutte?~r~n"&
		+"Non sarà possibile poi recuperare questo dato!", stopsign!,yesno! )
		if ll_ret=1 then
			for ll_ret= 1 to dw_spesa_cif_gd.rowcount()
				dw_spesa_cif_gd.deleterow(ll_ret)
			next
			ib_askforsave=false
			dw_spesa_cif_gd.update()
			ll_riga_corrente=dw_cif_ff.getrow()
			dw_cif_ff.deleterow(ll_riga_corrente)
			cb_nuovo.triggerevent(clicked!) 
		end if
else
	dw_cif_ff.deleterow(0)
	cb_nuovo.triggerevent(clicked!)
end if


end event

type p_crescente from w_p_data`p_crescente within w_cif_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_cif_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_cif_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_cif_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_cif_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_cif_cx
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_cif_cx
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_cif_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_cif_cx
int X=960
int Y=760
int Width=1417
int Height=720
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=1381
int Height=600
end type

type cb_ricerca from w_p_data`cb_ricerca within w_cif_cx
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;string ls_filtro,ls_codice
long LL_id_cif
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="codice"
openwithparm(lw_sm,idw_master.is_ricpar,"w_cif_coddes_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	LL_id_cif=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_cif"
	idw_master.is_list.l_identifica[1]=LL_id_cif
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if
end event

type dw_cif_ff from u_dw_master_main within w_cif_cx
int X=46
int Y=160
int Width=2309
int Height=180
int TabOrder=10
string DataObject="d_cif_ff"
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_cif"
iudw_children[1] = dw_spesa_cif_gd
end event

event ue_use_search;call super::ue_use_search;

end event

type dw_spesa_cif_gd from u_dw_master_main within w_cif_cx
int X=46
int Y=360
int Width=2309
int Height=1112
int TabOrder=3
string DataObject="d_spesa_cif_gd"
boolean VScrollBar=true
end type

event ue_init;call super::ue_init;
is_list.s_identifica[1] = "id_cif"

end event

