forward
global type w_menu_admin_ric_cx from w_p_data
end type
type dw_voce_menu_ric_ff from u_dw_master_main within w_menu_admin_ric_cx
end type
type dw_voce_menu_ric_lt from u_dw_master_main within w_menu_admin_ric_cx
end type
type tv_menu from treeview within w_menu_admin_ric_cx
end type
end forward

global type w_menu_admin_ric_cx from w_p_data
int Width=2963
boolean TitleBar=true
string Title="Voci Menu"
dw_voce_menu_ric_ff dw_voce_menu_ric_ff
dw_voce_menu_ric_lt dw_voce_menu_ric_lt
tv_menu tv_menu
end type
global w_menu_admin_ric_cx w_menu_admin_ric_cx

type variables
long		il_id_menu, il_rootitem
string		is_menu_name, is_sel

end variables

forward prototypes
public function string uf_title (string as_title)
public function integer wf_populate ()
public function integer wf_set_curr_tv ()
public function integer wf_set_data (long al_row, ref treeviewitem atvi_new, long al_handle)
public function integer wf_populate_ric ()
public function integer wf_ins_items (long al_parenthandle, long al_handle)
public function integer wf_get_curr_tv (long al_cnt, long al_handle)
public subroutine wf_lucchetto (string as_pwd)
end prototypes

public function string uf_title (string as_title);

string	ls_title

ls_title = idw_master.is_list.s_win_parametri

if idw_master.is_list.s_modo = "I" then
	ls_title = ls_title + " / <...>"
else 
	ls_title = ls_title + " / " + as_title
end if

This.Title = ls_title

Return ls_title
end function

public function integer wf_populate ();

long 				ll_row, ll_handle, ll_ret
TreeViewItem	ltvi_New

ll_row = dw_voce_menu_ric_ff.GetRow()

if u_freddie.istr_menu.sl_start = -100 then
	ltvi_New.Data = dw_voce_menu_ric_ff.GetItemNumber(ll_row,"id_voci_menu")
	ltvi_New.Label = dw_voce_menu_ric_ff.GetItemString(ll_row,"vmenu_voce")
	
	if dw_voce_menu_ric_lt.RowCount() > 0 then
		ltvi_New.PictureIndex = 1
	else
		ltvi_New.PictureIndex = 2
	end if
	ltvi_New.SelectedPictureIndex = 3
	ll_handle = tv_menu.InsertItemLast ( 0, ltvi_New )
end if

ll_ret = wf_ins_items(0, ll_handle)

ll_ret = ll_ret + wf_get_curr_tv(1, 0)

Return ll_ret
end function

public function integer wf_set_curr_tv ();

if u_freddie.istr_menu.sl_start = -100 then
	wf_populate()
else
	wf_populate_ric()
end if

is_sel = "dw"

Return 0
end function

public function integer wf_set_data (long al_row, ref treeviewitem atvi_new, long al_handle);


long 			ll_id_oggetti

atvi_New.Data = dw_voce_menu_ric_lt.GetItemNumber(al_row,"id_voci_menu_figlio")
atvi_New.Label = dw_voce_menu_ric_lt.GetItemString(al_row,"vmenu_voce")
ll_id_oggetti = dw_voce_menu_ric_lt.GetItemNumber(al_row,"id_oggetti")
if IsNull(ll_id_oggetti) Or ll_id_oggetti = 0 then
	atvi_New.PictureIndex = 1
	atvi_New.SelectedPictureIndex = 4
else
	atvi_New.SelectedPictureIndex = 2
	atvi_New.PictureIndex = 2
end if

Return 0
end function

public function integer wf_populate_ric ();

long				ll_cnt, ll_handle, ll_ret, ll_padre, ll_size
s_menu_ric		lstr_menu
TreeViewItem 	ltvi_New

ll_ret = 0

lstr_menu = u_freddie.istr_menu

ll_size = UpperBound(lstr_menu.ss_label)

if ll_size > 0 then
	
	For ll_Cnt = 1 To ll_size
		
		ltvi_New.Label = lstr_menu.ss_label[ll_cnt]
		ltvi_New.Data = lstr_menu.sl_data[ll_cnt]
		ll_handle = lstr_menu.sl_padre[ll_cnt]
		ltvi_New.PictureIndex = lstr_menu.sl_pictureindex[ll_cnt]
		
		ltvi_New.SelectedPictureIndex = 3
		
		If tv_menu.InsertItemLast(ll_handle, ltvi_New) < 1 Then
			
			MessageBox("Error", "Errore nell'Inserimento Voci Menu precedenti", Exclamation!)
			Return -1
		End If
	Next
end if 

tv_menu.ExpandItem(ll_handle)

ll_handle = u_freddie.istr_menu.sl_start
tv_menu.GetItem(ll_handle, ltvi_New)
tv_menu.ExpandItem(ll_handle)
ll_padre = tv_menu.FindItem(ParentTreeItem!, ll_handle)
ll_ret = wf_ins_items(ll_handle, ll_handle)

ltvi_new.PictureIndex = 1
ltvi_New.SelectedPictureIndex = ltvi_new.PictureIndex

ll_ret = ll_ret + wf_get_curr_tv(1, 0)

Return ll_ret
end function

public function integer wf_ins_items (long al_parenthandle, long al_handle);

long 				ll_handle, ll_size, ll_cnt, ll_ret
TreeViewItem	ltvi_New

ll_handle = al_handle

ll_size = dw_voce_menu_ric_lt.RowCount()
if ll_size > 0 then
	
	For ll_Cnt = 1 To ll_size
		
		ll_ret = wf_set_data(ll_Cnt, ltvi_New,ll_handle)
		
		if al_parenthandle = 0 then
			If tv_menu.InsertItemLast(ll_handle, ltvi_New) < 1 Then
				
				MessageBox("Error", "Errore nell'Inserimento Voci Menu", Exclamation!)
				Return -1
			End If
		else
			If tv_menu.InsertItemLast(al_parenthandle,  ltvi_New) < 1 Then
				
				MessageBox("Error", "Errore nell'Inserimento Voci Menu Precedenti", Exclamation!)
				Return -1
			End If
		end if
	Next
end if 

tv_menu.ExpandAll(1)

Return ll_ret
end function

public function integer wf_get_curr_tv (long al_cnt, long al_handle);

long				ll_cnt, ll_handle, ll_parenthandle, ll_ret, ll_hand
TreeViewItem 	l_tvi

tv_menu.SetFocus()
ll_ret = 0
ll_handle = al_handle

if ll_handle = 0 then
	ll_handle = tv_menu.FindItem(RootTreeItem! , 0)
end if

If tv_menu.GetItem(ll_handle, l_tvi) = -1 Then 		
	ll_ret = -1
	Return ll_ret
end if

ll_cnt = al_cnt
DO WHILE ll_handle <> -1
		tv_menu.GetItem(ll_handle, l_tvi)
		
		u_freddie.istr_menu.ss_label[ll_handle] = l_tvi.Label
		
		u_freddie.istr_menu.sl_data[ll_handle] = l_tvi.Data
		
		u_freddie.istr_menu.sl_pictureindex[ll_handle] = l_tvi.PictureIndex
		
		if tv_menu.FindItem(ParentTreeItem!, ll_handle) = -1 then
			
			u_freddie.istr_menu.sl_padre[ll_handle] = 0
		else
			u_freddie.istr_menu.sl_padre[ll_handle] = tv_menu.FindItem(ParentTreeItem!, ll_handle)
		end if
		
		ll_hand = tv_menu.FindItem(ChildTreeItem!, ll_handle)
		if ll_hand <> -1 then
			This.wf_get_curr_tv(ll_cnt + 1, ll_hand)
		end if
		ll_handle = tv_menu.FindItem(NextTreeItem!, ll_handle)
		ll_cnt++
LOOP

dw_voce_menu_ric_lt.SetFocus()

Return ll_ret
end function

public subroutine wf_lucchetto (string as_pwd);if Not IsNull(as_pwd) AND as_pwd <> "" then
	dw_voce_menu_ric_ff.Object.p_lucchetto_col.Visible = 1
else
	dw_voce_menu_ric_ff.Object.p_lucchetto_col.Visible = 0
end if
end subroutine

on w_menu_admin_ric_cx.create
int iCurrent
call w_p_data::create
this.dw_voce_menu_ric_ff=create dw_voce_menu_ric_ff
this.dw_voce_menu_ric_lt=create dw_voce_menu_ric_lt
this.tv_menu=create tv_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_voce_menu_ric_ff
this.Control[iCurrent+2]=dw_voce_menu_ric_lt
this.Control[iCurrent+3]=tv_menu
end on

on w_menu_admin_ric_cx.destroy
call w_p_data::destroy
destroy(this.dw_voce_menu_ric_ff)
destroy(this.dw_voce_menu_ric_lt)
destroy(this.tv_menu)
end on

event open;

integer			li_size, li_i
s_list_main		istr_list
long				ll_row

ib_close_query = TRUE
ib_askforsave = TRUE
is_wintype = "_"					
u_freddie.iw_current = THIS
u_freddie.center_window(this)

is_wintype = "W_P_DATA"
istr_list = Message.PowerObjectParm

li_size = upperBound(istr_list.l_identifica)
if li_size < 1 then
	li_size = upperbound(istr_list.s_identifica)
	for li_i = 1 to li_size
		istr_list.l_identifica[li_i] = -1
	next
	Message.PowerObjectParm = istr_list
end if

idw_master = dw_voce_menu_ric_ff
idw_master.is_list = Message.PowerObjectParm
idw_master.is_list.s_identifica[1] = "id_voci_menu"
idw_master.is_list.s_par_name[1] = "id_voci_menu_padre"

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "voci_menu.id_voci_menu"

PostEvent("ue_post_open")

end event

event ue_post_open;call super::ue_post_open;long 		ll_row
string	ls_ret

ll_row = dw_voce_menu_ric_ff.GetRow()
ls_ret = uf_title(dw_voce_menu_ric_ff.GetItemString(ll_row,"vmenu_voce"))

end event

event ue_close;call super::ue_close;
s_menu_ric 		lstr_menu

u_freddie.istr_menu = lstr_menu


u_freddie.istr_menu.sl_start = -101


end event

type p_crescente from w_p_data`p_crescente within w_menu_admin_ric_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_menu_admin_ric_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_menu_admin_ric_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_menu_admin_ric_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_menu_admin_ric_cx
boolean BringToTop=true
end type

type cb_inserisci from w_p_data`cb_inserisci within w_menu_admin_ric_cx
int X=2012
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_menu_admin_ric_cx
int X=2309
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_menu_admin_ric_cx
int X=2606
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_menu_admin_ric_cx
int X=2103
int Y=241
int Width=183
int Height=101
int TabOrder=40
boolean Visible=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=19
int Y=105
int Width=147
end type

type dw_voce_menu_ric_ff from u_dw_master_main within w_menu_admin_ric_cx
event type long ue_select_id ( )
int X=46
int Y=161
int Width=1852
int Height=641
int TabOrder=20
string DataObject="d_voce_menu_ric_ff"
end type

event ue_select_id;call super::ue_select_id;

string			ls_label
long				ll_row, ll_handle, ll_data
TreeViewItem	l_tvi

ll_row = GetRow()
if ll_row > 0 then
	ls_label = GetItemString(ll_row, "vmenu_voce")
	
	if ls_label = "" Or IsNull(ls_label) then
		ll_handle = u_freddie.istr_menu.sl_start
	else
		ll_data = GetItemNumber(ll_row, "id_voci_menu")
		
		ll_handle = tv_menu.Event ue_select_tvi(ls_label, ll_data)
		choose case ll_handle
			case -1
				
				
				MessageBox("Attenzione", "Non ci sono le voci nella TreeView")
				Return -1
			case -2
				
				MessageBox("Attenzione "+string(ll_data), "Non riesco a trova la voce corrispondente.")
				Return -1
		end choose
	end if
end if

Return ll_handle
end event

event ue_init;call super::ue_init;
iudw_children[1] = dw_voce_menu_ric_lt
is_title = "Detaglio Voce Menu"

end event

event ue_update;call super::ue_update;string	ls_modo
long		ll_row


ll_row = this.GetRow()

ls_modo = this.is_list.s_modo
this.is_list.s_modo = "M"
uf_title(getItemString(ll_row,"vmenu_voce"))

end event

event itemchanged;call super::itemchanged;string			ls_label
long				ll_handle, ll_data
TreeViewItem	l_tvi

CHOOSE CASE dwo.name
	CASE "vmenu_voce"
		
		ll_handle = Event ue_select_id()
		tv_menu.GetItem(ll_handle, l_tvi)
		
		l_tvi.Label = data
		tv_menu.SetItem(ll_handle, l_tvi)
		
		wf_get_curr_tv(1,0)
		tv_menu.ExpandAll(1)
		This.SetFocus()
		This.SetColumn("vmenu_order")
	CASE "vmenu_pwd"
		
		wf_lucchetto(data)
END CHOOSE

end event

event retrieveend;call super::retrieveend;long		ll_row
string	ls_pwd

ll_row = This.GetRow()
if ll_row > 0 then
	ls_pwd = This.GetItemString(ll_row, "vmenu_pwd")
	wf_lucchetto(ls_pwd)
end if
end event

type dw_voce_menu_ric_lt from u_dw_master_main within w_menu_admin_ric_cx
event type long ue_select_id ( )
int X=46
int Y=841
int Width=1852
int Height=601
int TabOrder=10
string DataObject="d_voce_menu_ric_lt"
boolean VScrollBar=true
end type

event ue_select_id;call super::ue_select_id;

Long				ll_ret, ll_row, ll_data, ll_handle
string			ls_label

ll_ret = -1
ll_row = GetRow()
if ll_row > 0 then
	ls_label = GetItemString(ll_row, "vmenu_voce")
	ll_data = GetItemNumber(ll_row, "id_voci_menu_figlio")
	
	ll_handle = tv_menu.Event ue_select_tvi(ls_label, ll_data)
	choose case ll_handle
		case -1
			
			
			Parent.wf_set_curr_tv()
			dw_voce_menu_ric_lt.Event Rowfocuschanged(1)
		case -2
			
			
			ll_ret = -1
		case else
			ll_ret = ll_handle
	end choose

else
	
	
	ll_handle = tv_menu.FindItem(RootTreeItem!,0)
	
	if ll_handle = -1 then
		wf_set_curr_tv()
	end if
	
	ll_row = dw_voce_menu_ric_ff.GetRow()
	ls_label = dw_voce_menu_ric_ff.GetItemString(ll_row,"vmenu_voce")
	if IsNull(ls_label) Or ls_label = "" then
		ls_label = "<...>"
		ll_data = 0
	else
		ll_data = dw_voce_menu_ric_ff.GetItemNumber(ll_row,"id_voci_menu")
	end if
	ll_ret = tv_menu.Event ue_select_tvi(ls_label, ll_data)
	is_sel = "tv"
end if

Return ll_ret
end event

event ue_init;call super::ue_init;is_title = "Voci Menu"

is_list.s_identifica[1] = "id_voci_menu"
is_list.s_win_chiave[1] = "id_voci_menu_figlio"
is_list.s_par_name[1] = "id_voci_menu"
is_resp_window = "w_menu_admin_ric_cx"

end event

event ue_insert;

long 				ll_id_oggetto, ll_row, ll_ret, ll_handle, ll_handle_new, ll_id_voci_menu
TreeViewItem	l_tvi, l_tvi_New
string			ls_label

long				ll_newrow, ll_nonfare, ll_parrow
integer			li_colNumber, li_size, li_counter, li_start_point
string			ls_filter, ls_coltype, ls_column, ls_value, ls_colname, ls_colval
s_list_main 	lstr_for_win
w_p_data			lw_win
dwitemstatus   ldwis_1
s_rit_wp			lstr_rit

ll_row = dw_voce_menu_ric_ff.GetRow()
ll_id_oggetto = dw_voce_menu_ric_ff.GetItemNumber(ll_row,"id_oggetti")
ls_label = dw_voce_menu_ric_ff.GetItemString(ll_row, "vmenu_voce")
ll_id_voci_menu = dw_voce_menu_ric_ff.GetItemNumber(ll_row, "id_voci_menu")
ll_handle = tv_menu.Event ue_select_tvi(ls_label, ll_id_voci_menu)
if ll_handle < 0 then Return -1
if isNull(ll_id_oggetto) or ll_id_oggetto = 0 then
	
	
	
	
	
	if not ib_dw_shared then
	
		if IsValid(iudw_parent) then
			
			
			ll_parRow = iudw_Parent.GetRow()
			if (ll_parRow>0) then
				if iudw_parent.AcceptText() >0 then
					ldwis_1 = iudw_Parent.GetItemStatus(ll_ParRow,0,Primary!)
					CHOOSE CASE ldwis_1
						CASE New!
							MessageBox(iudw_parent.is_title,"Non ci sono dati!")
							ll_nonfare = 99
							iudw_parent.SetFocus()
						CASE NewModified!
							lw_win = u_freddie.iw_current
							ll_nonfare = lw_win.idw_master.event ue_update (0,0)
						CASE DataModified!
							ll_nonfare = 0
						CASE NotModified!
							ll_nonfare = 0
						CASE ELSE
							ll_nonfare = 0
					END CHOOSE
				else
					ll_nonfare = 99
					iudw_parent.SetFocus()
				end if
			else
				ll_nonfare = 99
			end if
		else
			
			
			
			
			if acceptText() >0 then
				if is_list.s_modo = modo_inserisci then
					ll_nonfare = 0  
				else
					ll_nonfare = 99
				end if
			else
				ll_nonfare = 99
				SetFocus()
			end if
		end if
		
		if ll_nonfare = 0 then
			
			if is_resp_window = "" then
				ll_newrow = InsertRow(0) 
				if ll_newrow <> -1 then
					ScrollToRow(ll_newrow)
					li_colNumber = 1
					do while SetColumn(li_colNumber) = -1 AND li_colNumber < 10
						li_colNumber = li_colNumber + 1
					loop
					
					if IsValid(iudw_parent) then
						
						li_size = UpperBound(is_list.s_identifica)
						for li_counter = 1 to li_size
							is_list.l_identifica[li_counter] = iudw_parent.GetItemNumber(iudw_parent.GetRow(), is_list.s_identifica[li_counter])
							SetItem(ll_newrow , is_list.s_identifica[li_counter], is_list.l_identifica[li_counter])		
						next
						
						
						li_size = UpperBound(is_list.s_par_name)
						for li_counter = 1 to li_size
							if isNull(is_list.s_par_value[li_counter]) then
								is_list.s_par_value[li_counter] = iudw_parent.uf_Get_colval(is_list.s_par_name[li_counter])
							end if
							uf_Set_colval(is_list.s_par_name[li_counter], is_list.s_par_value[li_counter])
						next
						AcceptText()
					else
					
						li_size = UpperBound(is_list.s_par_name)
						li_start_point = UpperBound(is_list.s_par_value) + 1
						ll_row = GetRow()
						for li_counter = 1 to li_size
							uf_Set_colval(is_list.s_par_name[li_counter], is_list.s_par_value[li_counter])
			
						next
						AcceptText()
						ScrollToRow(ll_newrow)
					end if
				end if
			else
			
				
				is_list.s_modo = modo_inserisci
				li_size = UpperBound(is_list.s_identifica)
				for li_counter = 1 to li_size
					is_list.l_identifica[li_counter] = iudw_parent.GetItemNumber(iudw_parent.GetRow(), is_list.s_identifica[li_counter])
					SetItem(ll_newrow , is_list.s_identifica[li_counter], is_list.l_identifica[li_counter])		
				next
				
				li_size = UpperBound(is_list.s_par_name)
				li_start_point = UpperBound(is_list.s_par_value) + 1
				for li_counter = li_start_point to li_size
					ls_value = iudw_parent.uf_Get_colval(is_list.s_par_name[li_counter])		
					is_list.s_par_value[li_counter] = ls_value
				next
				lstr_for_win.s_modo = is_list.s_modo
				lstr_for_win.s_identifica = is_list.s_win_chiave
				lstr_for_win.l_identifica = is_list.l_win_chiave
				lstr_for_win.s_par_name = is_list.s_par_name
				lstr_for_win.s_par_value = is_list.s_par_value
				
				lstr_for_win.s_win_parametri = u_freddie.iw_current.title
				
				
				
				
				
				
				
				l_tvi_New.Label = "<...>"
				l_tvi_New.Data = 0
				l_tvi_New.PictureIndex = 1
				ll_handle_new = tv_menu.InsertItemLast(ll_handle, l_tvi_New)
				u_freddie.istr_menu.sl_start = ll_handle_new
				wf_get_curr_tv(1,0)
				
				OpenWithParm(iw_support, lstr_for_win, is_resp_window)
				
				
				ls_filter = ""
				lstr_rit = Message.PowerObjectParm
				li_size = UpperBound(lstr_rit.s_identifica)
				for  li_counter = 1 to li_size
					
					ls_colname = "id_voci_menu_figlio"
					ls_colval = string(lstr_rit.l_identifica[li_counter])
					ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
				next
				ls_filter = Mid(ls_filter,5)
				
				
				
				
					TriggerEvent("ue_retrieve")
					if (RowCount()>0) and (is_resp_window <> "") then
						selectrow(1,true)
					end if
					ll_row = Find( ls_filter, 1, RowCount( ))
					
					if Not IsNull(ll_row) then
						ll_ret = wf_set_data(ll_row, l_tvi_New, ll_handle_new)
						tv_menu.SetItem(ll_handle_new, l_tvi_New)
						wf_get_curr_tv(1, 0)
					else
						
						tv_menu.DeleteItem(ll_handle_new)
					end if
					tv_menu.ExpandAll(ll_handle)
					ScrollToRow(ll_row)
					
				
			end if
	
		end if
	
	else
		ll_nonfare = 0
	end if  
	
	
	
	
	
	
	if ll_nonfare = 0 then triggerevent("ue_initial")
else
	messageBox ("Errore!","La voce di menu è associata ad una~rfinestra. Impossibile continuare")
	ll_ret = -1
end if

return ll_ret

end event

event ue_modify;
long 				ll_row, ll_handle, ll_id_oggetti
integer 			li_size, li_counter
string 			ls_filter, ls_colname, ls_colval
s_list_main 	lstr_for_win
s_rit_wp			lstr_rit
TreeViewItem	l_tvi

ll_row = GetRow()
ll_handle = This.Event ue_select_id()
tv_menu.GetItem(ll_handle, l_tvi)
if ll_row>0 then
	if not(is_resp_window = "") OR not(is_list.s_win_zoom = "") then
	
		li_size = UpperBound(is_list.s_win_chiave)
		is_list.s_modo = modo_modifica
		for li_counter = 1 to li_size
			is_list.l_win_chiave[li_counter] = GetItemNumber( ll_row, is_list.s_win_chiave[li_counter])
		next
		li_size = UpperBound(is_list.s_par_name)
		for li_counter = 1 to li_size
			
			
			
			
		next
		lstr_for_win.s_modo = is_list.s_modo
		lstr_for_win.s_identifica = is_list.s_win_chiave
		lstr_for_win.l_identifica = is_list.l_win_chiave
		lstr_for_win.s_par_name = is_list.s_par_name
		lstr_for_win.s_par_value = is_list.s_par_value
		
		lstr_for_win.s_win_parametri = u_freddie.iw_current.title
		if is_list.s_win_zoom = "" then
			OpenWithParm(iw_support, lstr_for_win,is_resp_window)
		else
			if not ((GetItemStatus(ll_row, 0, Primary!) = New!) OR (GetItemStatus(ll_row, 0, Primary!) = NewModified!)) then
				OpenWithParm(iw_support, lstr_for_win,is_list.s_win_zoom)
			end if
		end if
	
		
		ls_filter = ""
		lstr_rit = Message.PowerObjectParm
		li_size = UpperBound(lstr_rit.s_identifica)
		for  li_counter = 1 to li_size
			
			ls_colname = "id_voci_menu_figlio"
			ls_colval = string(lstr_rit.l_identifica[li_counter])
			ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
		next
		ls_filter = Mid(ls_filter,5)
		
		
		
		
			TriggerEvent("ue_retrieve")
			if (RowCount()>0) and (is_resp_window <> "") then
				selectrow(1,true)
			end if
			ll_row = Find( ls_filter, 1, RowCount( ))
			
			l_tvi.Label = GetItemString(ll_row,"vmenu_voce")
			ll_id_oggetti = GetItemNumber(ll_row, "id_oggetti")
			if IsNull(ll_id_oggetti) or ll_id_oggetti = 0 then
				l_tvi.PictureIndex = 1
				l_tvi.SelectedPictureIndex = 4
			else
				l_tvi.PictureIndex = 2
				l_tvi.SelectedPictureIndex = 2
			end if
			tv_menu.SetItem(ll_handle, l_tvi)
			
			wf_get_curr_tv(1,0)
			tv_menu.ExpandAll(1)
			ScrollToRow(ll_row)
			
		
		
	else
		
	end if
end if


end event

event rowfocuschanged;call super::rowfocuschanged;

Long			ll_ret = 0, ll_row, ll_rows, ll_handle, ll_cnt = 1

if u_freddie.istr_menu.sl_start < -100 AND UpperBound(u_freddie.istr_menu.ss_label) = 0 then
	
	if UpperBound(u_freddie.istr_menu.ss_label) = 0 then
		wf_get_curr_tv(1,0)
	end if
	
	is_sel = "dw"
	
	u_freddie.istr_menu.sl_start = 1
end if

if is_sel <> "tv" then
	
	ll_handle = This.Event ue_select_id()
end if

Return ll_ret
end event

event getfocus;call super::getfocus;
is_sel = "dw"

end event

event losefocus;call super::losefocus;
is_sel = ""

end event

event doubleclicked;call super::doubleclicked;

long 		ll_row

ll_row = GetRow()
if ll_row > 0 then
	This.Event ue_select_id()
end if

end event

event ue_delete;

treeViewItem	l_tvi
long				ll_handle, ll_row, ll_id_voci_menu, ll_figlio, ll_i
string			ls_text
s_list_main		lstr_for_win

ll_row = dw_voce_menu_ric_lt.GetRow()
ll_handle = tv_menu.FindItem(CurrentTreeItem!,0)
tv_menu.GetItem(ll_handle, l_tvi)

ll_id_voci_menu = GetItemNumber(ll_row, "id_voci_menu_figlio")
SELECT Max("voci_menu"."id_voci_menu") INTO :ll_figlio
  FROM "dba"."voci_menu"  
  WHERE ( "voci_menu"."id_voci_menu_padre" = :ll_id_voci_menu ) ;
if Not IsNull(ll_figlio) And ll_figlio <> 0 then
	lstr_for_win.l_identifica[1] = 0
	lstr_for_win.l_identifica[2] = ll_id_voci_menu
	OpenWithParm(w_voci_menu_ext_lt, lstr_for_win)
	lstr_for_win = Message.PowerObjectParm
	
	if lstr_for_win.l_identifica[1] < 0 then
		dw_voce_menu_ric_lt.SetFocus()
		Return -1
	end if
end if

if ib_allow_delete and THIS.getconfirm(ici_confirm_delete) then
	
	if ll_handle <> -1 then
		tv_menu.DeleteItem(ll_handle)
	else
		MessageBox("Cancellazione voce menu","Cancellazione non riuscita per la voce " + &
					l_tvi.Label)
	end if
	
	THIS.DeleteRow(ll_row)
	if Not IsNull(ll_figlio) And ll_figlio <> 0 then
		
		FOR ll_i = 2 TO UpperBound(lstr_for_win.l_identifica)
			DELETE FROM "dba"."voci_menu" 
				WHERE ( "dba"."voci_menu"."id_voci_menu" = :lstr_for_win.l_identifica[ll_i] ) ;
		NEXT
		COMMIT USING SQLCA ;
	end if
end if

cb_salva.TriggerEvent("Clicked")

wf_get_curr_tv(1,0)

end event

event retrieveend;call super::retrieveend;
if This.RowCount() <> 0 then
	f_displayonly(Parent.dw_voce_menu_ric_ff, "id_oggetti", True)
end if
end event

type tv_menu from treeview within w_menu_admin_ric_cx
event type integer ue_select_tvi ( string as_label,  long al_data )
event type long ue_select_label ( string as_label,  long al_cnt )
int X=1943
int Y=161
int Width=938
int Height=1281
int TabOrder=30
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean LinesAtRoot=true
boolean HideSelection=false
string PictureName[]={"S:\PB\CommonFrameWork\cfolder.bmp",&
"S:\PB\CommonFrameWork\genappl.bmp",&
"NotFound!",&
"S:\PB\CommonFrameWork\ofolder.bmp"}
long PictureMaskColor=553648127
long StatePictureMaskColor=553648127
long TextColor=33554432
int TextSize=-8

int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_select_tvi;
Long					ll_handle, ll_ret = 0, ll_cnt = 1
TreeViewItem		l_tvi

if UpperBound(u_freddie.istr_menu.ss_label) = 0 and u_freddie.istr_menu.sl_start < -100 then
	wf_get_curr_tv(1,0)
end if

ll_handle = tv_menu.FindItem(CurrentTreeItem!, 0)
	
If GetItem(ll_handle, l_tvi) = -1 Then Return -1

If IsNull(l_tvi.data) then l_tvi.data = 0

ll_handle = Event ue_select_label(as_label, 1)

GetItem(ll_handle, l_tvi)

if l_tvi.data <> al_data then
	ll_handle = Event ue_select_label(as_label, ll_handle + 1)
else
	ll_ret = ll_handle
end if

if SelectItem(ll_handle) < 0 then
	MessageBox("Avviso","Non riesco selezionare nulla nella TreeView")
	Return -2
end if

u_freddie.istr_menu.sl_start = ll_handle

Return ll_ret
end event

event ue_select_label;

if al_cnt <= UpperBound(u_freddie.istr_menu.ss_label) then
	DO WHILE as_label <> u_freddie.istr_menu.ss_label[al_cnt]
		al_cnt++
		
		if al_cnt > UpperBound(u_freddie.istr_menu.ss_label) then
			MessageBox("Avviso", "Non trovo voce corrispondente a <"+ as_label + &
												">~rin visualizzazione ad albero.")
			Return -1
		end if
	LOOP
	Return al_cnt
else
	
	
	MessageBox("Avviso", "Per inserimento sottovoci tornare indietro.")
	Return -1
end if
end event

event doubleclicked;long 				ll_row, ll_id_oggetti
string			ls_id_voci_menu
TreeViewItem 	l_tvi

if handle <> 0 then
	GetItem(handle, l_tvi)
	
	
	u_freddie.istr_menu.sl_start = handle
	ls_id_voci_menu = string(l_tvi.data)
	
	if Not IsNull(ls_id_voci_menu) And ls_id_voci_menu <> "" then
		ll_row = dw_voce_menu_ric_lt.Find("id_voci_menu_figlio = "+ls_id_voci_menu,1,dw_voce_menu_ric_lt.RowCount())
		if ll_row > 0 then
		
			ll_id_oggetti =  dw_voce_menu_ric_lt.GetItemNumber(ll_row,"id_oggetti")
		else
			MessageBox("Attenzione","Impossibile aprire ulteriormente.")
			Return 0
		end if
		
		if UpperBound(u_freddie.istr_menu.ss_label) = 0 then
			wf_get_curr_tv(1,0)
		end if
		dw_voce_menu_ric_lt.TriggerEvent("DoubleClicked")
	end if
end if

end event

event selectionchanged;
long 				ll_row
string			ls_id_voci_menu
TreeViewItem 	l_tvi

if newhandle <> 0 And is_sel <> "dw" then
	GetItem(newhandle, l_tvi)
	ls_id_voci_menu = string(l_tvi.data)
	
	if Not IsNull(ls_id_voci_menu) And ls_id_voci_menu <> "" then
		ll_row = dw_voce_menu_ric_lt.Find("id_voci_menu_figlio = " + ls_id_voci_menu,1,dw_voce_menu_ric_lt.RowCount())
		dw_voce_menu_ric_lt.ScrollToRow(ll_row)
	else
		
		dw_voce_menu_ric_ff.SetFocus()
		dw_voce_menu_ric_ff.SetColumn("vmenu_voce")
	end if
end if

end event

event key;treeViewItem	l_tvi
long				ll_tvi

ll_tvi = FindItem(CurrentTreeItem!,0)
if key = KeyEnter! then
	GetItem(ll_tvi, l_tvi)
	Event DoubleClicked(ll_tvi)
end if

return 0
end event

event getfocus;
is_sel = "tv"

end event

event losefocus;
is_sel = ""

end event

