forward
global type w_np_single_data from w_data_main
end type
type dw_single from u_dw_main within w_np_single_data
end type
end forward

global type w_np_single_data from w_data_main
int Width=2057
int Height=872
dw_single dw_single
end type
global w_np_single_data w_np_single_data

event closequery;call super::closequery;return dw_single.Ask_for_Save()
end event

event open;call super::open;idw_master = dw_single
is_wintype = "W_NP_SINGLE_DATA"
dw_single.Retrieve()
this.y = 100
end event

on w_np_single_data.create
int iCurrent
call super::create
this.dw_single=create dw_single
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_single
end on

on w_np_single_data.destroy
call super::destroy
destroy(this.dw_single)
end on

event resize;call super::resize;dw_single.Width = newwidth - 80
dw_single.Height = newheight - 100


end event

event ue_update;call super::ue_update;
THIS.uf_route_event("ue_update")
end event

type p_crescente from w_data_main`p_crescente within w_np_single_data
boolean BringToTop=true
end type

type p_decrescente from w_data_main`p_decrescente within w_np_single_data
boolean BringToTop=true
end type

type dw_single from u_dw_main within w_np_single_data
int X=46
int Y=40
int Width=1920
int Height=680
int TabOrder=1
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_append;

integer li_colNumber

if ib_allow_append then 
	THIS.ScrollToRow(THIS.InsertRow(0))
end if

li_colNumber = 1
do while SetColumn(li_colNumber) <> 1 AND li_colNumber < 10
	li_colNumber = li_colNumber + 1
loop
end event

event ue_clearquery;call super::ue_clearquery;

end event

event ue_insert;call super::ue_insert;

long ll_currow
integer li_colNumber

if ib_allow_insert then 
	ll_currow = THIS.GetRow()
	THIS.InsertRow(ll_currow)
	THIS.ScrollToRow(ll_currow)
end if

li_colNumber = 1
do while SetColumn(li_colNumber) = -1 AND li_colNumber < 10
	li_colNumber = li_colNumber + 1
loop
end event

event ue_retrieve;if THIS.ask_for_save() = 0 then
	THIS.retrieve()
end if
end event

event ue_togglequery;call super::ue_togglequery;

integer li_colonne, li_i, li_retval
string  ls_nome, ls_colonne

ib_query_mode = not ib_query_mode
IF ib_query_mode THEN
	
	for li_i = 1 to li_colonne
		this.setcolumn(li_i)
		ls_nome = this.getcolumnname()
		this.modify(ls_nome+".Criteria.override_edit=yes")
	next
	THIS.Object.DataWindow.querymode = "Yes"
	m_app_frame.uf_enable_modifica(false)
	
ELSE
	THIS.Object.DataWindow.querymode = "No"
	this.reset()
	for li_i = 1 to li_colonne
		this.setcolumn(li_i)
		ls_nome = this.getcolumnname()
		this.modify(ls_nome+".Criteria.override_edit=no")
	next
	m_app_frame.uf_enable_modifica(true)
	THIS.triggerevent("ue_retrieve")
END IF


end event

event ue_delete;call super::ue_delete;

long	ll_sbagli

ll_sbagli = Event ue_core_update (0,0)
ll_sbagli = Event ue_commit(ll_sbagli)

end event

event ue_update;
long	ll_sbagli

ll_sbagli = Super::Event ue_update(0,0)
if ll_sbagli = 0 then
	ll_sbagli = Event ue_core_update (0,0)
	ll_sbagli = Event ue_commit(ll_sbagli)
end if

end event

