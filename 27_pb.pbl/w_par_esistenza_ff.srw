forward
global type w_par_esistenza_ff from w_p_data
end type
type dw_par_esistenza_ff from u_dw_master_main within w_par_esistenza_ff
end type
end forward

global type w_par_esistenza_ff from w_p_data
int Width=2131
int Height=1645
boolean TitleBar=true
string Title="Parametri di Esistenza"
dw_par_esistenza_ff dw_par_esistenza_ff
end type
global w_par_esistenza_ff w_par_esistenza_ff

on w_par_esistenza_ff.create
int iCurrent
call w_p_data::create
this.dw_par_esistenza_ff=create dw_par_esistenza_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_par_esistenza_ff
end on

on w_par_esistenza_ff.destroy
call w_p_data::destroy
destroy(this.dw_par_esistenza_ff)
end on

event open;call super::open;il_HelpTopic = 380
idw_master= dw_par_esistenza_ff
idw_master.is_list= Message.PowerObjectParm

if Upperbound(idw_master.is_list.s_identifica)=0 then
	idw_master.ias_key_name[1] = "id_par_esistenza"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "id_par_esistenza"

ib_nonmodale=true


end event

event ue_master_delete;call super::ue_master_delete;if (idw_master.Event ue_delete(0, 0) = 0) then
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

event ue_post_open;call super::ue_post_open;dw_par_esistenza_ff.Retrieve()
end event

type p_crescente from w_p_data`p_crescente within w_par_esistenza_ff
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_par_esistenza_ff
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_par_esistenza_ff
int X=37
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_par_esistenza_ff
int X=330
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_par_esistenza_ff
int X=2460
int Y=773
boolean Visible=false
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_par_esistenza_ff
int X=1372
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_par_esistenza_ff
int X=1829
int Width=266
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_par_esistenza_ff
int X=1537
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_par_esistenza_ff
int X=2172
int Y=1113
int Width=778
int Height=341
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=741
int Height=221
end type

type cb_ricerca from w_p_data`cb_ricerca within w_par_esistenza_ff
int X=2177
int Y=773
boolean Visible=false
boolean BringToTop=true
end type

event cb_ricerca::clicked;call super::clicked;string ls_filtro,ls_codice
long ll_seg_value
w_search_main lw_sm
ls_codice=""
idw_master.is_ricpar.s_filter_value=ls_codice
idw_master.is_ricpar.s_filter_name="id_par_esistenza"
openwithparm(lw_sm,idw_master.is_ricpar,"w_par_esistenza_sw")
idw_master.is_ricpar=message.powerobjectparm
if upperbound(idw_master.is_ricpar.s_id_seg_value)>0 then
	ll_seg_value=long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo=modo_modifica
	idw_master.is_list.s_identifica[1]="id_par_esistenza"
	idw_master.is_list.l_identifica[1]=ll_seg_value
	idw_master.event ue_retrieve(0,0)
	idw_master.setfocus()
end if
end event

type dw_par_esistenza_ff from u_dw_master_main within w_par_esistenza_ff
int X=37
int Y=157
int Width=2058
int Height=1385
int TabOrder=1
string DataObject="d_par_esistenza_ff"
end type

event ue_init;call super::ue_init;is_title = "Parametri di Esistenza"
end event

event retrieveend;call super::retrieveend;If rowcount = 0 Then
	This.triggerevent('ue_insert')
End If

String	ls_des_riep_gr1, ls_des_riep_gr2, ls_des_riep_gr3, ls_des_riep_gr4

SELECT des_riep_gr1, des_riep_gr2, des_riep_gr3, des_riep_gr4
INTO	 :ls_des_riep_gr1, :ls_des_riep_gr2, :ls_des_riep_gr3, :ls_des_riep_gr4
FROM	 par_sistema
;

If SQLCA.SQLCODE = 0 Then
	If not IsNull(ls_des_riep_gr1) Then
		This.Object.gr_lib_1_t.Text = ls_des_riep_gr1 + ':'
	End If

	If not IsNull(ls_des_riep_gr2) Then
		This.Object.gr_lib_2_t.Text = ls_des_riep_gr2 + ':'
	End If
	If not IsNull(ls_des_riep_gr3) Then
		This.Object.gr_lib_3_t.Text = ls_des_riep_gr3 + ':'
	End If	
	If not IsNull(ls_des_riep_gr4) Then
		This.Object.gr_lib_4_t.Text = ls_des_riep_gr4 + ':'
	End If	
End If
end event

