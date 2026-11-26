forward
global type w_riepilogo_cx from w_p_data
end type
type dw_generale from u_dw_master_main within tabpage_1
end type
type dw_generale from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_altro from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_altro dw_altro
end type
end forward

global type w_riepilogo_cx from w_p_data
int Width=2967
int Height=1740
boolean TitleBar=true
string Title="Riepiloghi di Magazzino"
end type
global w_riepilogo_cx w_riepilogo_cx

on w_riepilogo_cx.create
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
end on

on w_riepilogo_cx.destroy
call super::destroy
end on

event open;call super::open;il_HelpTopic = 381
idw_master = tab_1.tabpage_1.dw_generale
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = true

this.cb_annulla.visible = false
this.cb_salva.visible	= false

idw_master.is_list.s_sql_ident[1] = "riepilogo.id_esercizio"
idw_master.is_list.s_sql_ident[2] = "riepilogo.id_attivita"
idw_master.is_list.s_sql_ident[3] = "riepilogo.id_articolo"
idw_master.is_list.s_sql_ident[4] = "riepilogo.id_locazione"
idw_master.is_list.s_sql_ident[5] = "riepilogo.anno"
idw_master.is_list.s_sql_ident[6] = "riepilogo.mese"

end event

type p_crescente from w_p_data`p_crescente within w_riepilogo_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_riepilogo_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_riepilogo_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_riepilogo_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_riepilogo_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_riepilogo_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_riepilogo_cx
boolean Visible=false
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_riepilogo_cx
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_riepilogo_cx
int X=27
int Width=2903
int Height=1472
boolean BringToTop=true
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_2=create tabpage_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
end on

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2866
int Height=1352
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
dw_generale dw_generale
end type

on tabpage_1.create
this.dw_generale=create dw_generale
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_generale
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_generale)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_riepilogo_cx
boolean BringToTop=true
end type

type dw_generale from u_dw_master_main within tabpage_1
int X=18
int Y=24
int Width=2830
int Height=1300
int TabOrder=1
string DataObject="d_riepilogo_gen_ff"
end type

event ue_init;call super::ue_init;iudw_children[1] = tab_1.tabpage_2.dw_altro

is_list.s_identifica[1]="riepilogo_id_esercizio"
is_list.s_identifica[2]="riepilogo_id_attivita"
is_list.s_identifica[3]="riepilogo_id_articolo"
is_list.s_identifica[4]="riepilogo_id_locazione"
is_list.s_identifica[5]="riepilogo_anno"
is_list.s_identifica[6]="riepilogo_mese"
end event

event retrieveend;call super::retrieveend;String	ls_des_riep_gr1, ls_des_riep_gr2, ls_des_riep_gr3, ls_des_riep_gr4

SELECT des_riep_gr1, des_riep_gr2, des_riep_gr3, des_riep_gr4
INTO	 :ls_des_riep_gr1, :ls_des_riep_gr2, :ls_des_riep_gr3, :ls_des_riep_gr4
FROM	 par_sistema
;

If SQLCA.SQLCODE = 0 Then
	If not IsNull(ls_des_riep_gr1) Then
		tab_1.tabpage_2.dw_altro.Object.qta_gruppo_lib_1_t.Text = ls_des_riep_gr1 + ':'
	End If

	If not IsNull(ls_des_riep_gr2) Then
		tab_1.tabpage_2.dw_altro.Object.qta_gruppo_lib_2_t.Text = ls_des_riep_gr2 + ':'
	End If
	If not IsNull(ls_des_riep_gr3) Then
		tab_1.tabpage_2.dw_altro.Object.qta_gruppo_lib_3_t.Text = ls_des_riep_gr3 + ':'
	End If	
	If not IsNull(ls_des_riep_gr4) Then
		tab_1.tabpage_2.dw_altro.Object.qta_gruppo_lib_4_t.Text = ls_des_riep_gr4 + ':'
	End If	
End If
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2866
int Height=1352
long BackColor=79741120
string Text="Altro"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_altro dw_altro
end type

on tabpage_2.create
this.dw_altro=create dw_altro
this.Control[]={this.dw_altro}
end on

on tabpage_2.destroy
destroy(this.dw_altro)
end on

type dw_altro from u_dw_master_main within tabpage_2
int X=23
int Y=32
int Width=2811
int Height=1048
int TabOrder=3
string DataObject="d_riepilogo_altro_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = true
end event

