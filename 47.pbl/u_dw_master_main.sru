forward
global type u_dw_master_main from u_dw_main
end type
end forward

global type u_dw_master_main from u_dw_main
event ue_reset_flags ( )
end type
global u_dw_master_main u_dw_master_main

type variables

end variables

forward prototypes
public function boolean uf_get_insert_permission (u_dw_master_main adw_current)
public function integer uf_disable_buttons ()
end prototypes

event ue_reset_flags;call super::ue_reset_flags;long 					li_size, li_counter
u_dw_master_main 	ldw_item

This.ResetUpdate()

li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ldw_item.trigger event ue_reset_flags()
next

end event

public function boolean uf_get_insert_permission (u_dw_master_main adw_current);boolean lb_insert
long ll_row

lb_insert = true
ll_row = adw_current.iudw_parent.GetRow()
if ll_row > 0 then
	if  (adw_current.iudw_parent.GetItemStatus(ll_row, 0, Primary!) = New!) OR &
		 (adw_current.iudw_parent.GetItemStatus(ll_row, 0, Primary!) = NewModified!) then 
		lb_insert = FALSE
	else
		
	end if
else
	lb_insert = FALSE
end if
return lb_insert
end function

public function integer uf_disable_buttons ();
w_data_main		lw_win
commandbutton	lcb_button
integer			li_i
integer			li_controls
string			ls_tipo,ls_button

lw_win = u_freddie.iw_current
if Not IsNull(lw_win) then
	ls_tipo = lw_win.is_wintype
end if

if ls_tipo = "W_P_DATA" then
	
	li_controls	= UpperBound(lw_win.control)
	for li_i = 1 to li_controls
		if not isNull(lw_win.Control[li_i]) then	

			if lw_win.Control[li_i].TypeOf() = CommandButton! then
				lcb_button	= lw_win.Control[li_i]
				ls_button	= lw_win.Control[li_i].ClassName()
				choose case ls_button
						
					case "cb_inserisci"
						if ib_allow_insert then
							
						else
							
						end if	
						
					case "cb_cancella"
						if ib_allow_delete then
							
						else
							
						end if	
						
					case "cb_salva"	
						if ib_allow_update then
							
						else
							
						end if	
						
				end choose
			end if	
		end if			
	next
	
end if	

return 0

end function

event itemfocuschanged;call super::itemfocuschanged;integer li_size, li_counter
u_dw_main ldw_item
long ll_row

ll_row = GetRow()
if ll_row > 0 then
	li_size = UpperBound(iudw_children)
	for li_counter = 1 to li_size
		ldw_item = iudw_children[li_counter]
		ldw_item.Trigger Event ue_scroll(ll_row)
	next
end if

end event

event constructor;integer		li_size, li_counter,li_id_size, li_id_counter
long			ll_row
u_dw_main	ldw_item
boolean		lb_newrecord
string		ls_sql

iu_scan = CREATE u_sql_scanner
ll_row = Getrow()
TriggerEvent ("ue_init")
	
if not ib_dw_shared then 
	THIS.SetTransObject(SQLCA)
	ls_sql = this.object.datawindow.table.select
	iu_scan.f_setinitial(ls_sql)
	iu_scan.f_setcurrent(ls_sql)
end if
	
li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ldw_item.iudw_parent = this
	if ldw_item.ib_dw_shared then this.ShareData(ldw_item)
next

end event

event ue_insert;long				ll_newrow, ll_row, ll_nonfare, ll_parrow
integer			li_colNumber, li_size, li_counter, li_start_point
string			ls_filter, ls_coltype, ls_column, ls_value, ls_colname, ls_colval
s_list_main 	lstr_for_win
w_p_data			lw_win
dwitemstatus   ldwis_1
s_rit_wp			lstr_rit

if ib_allow_insert or ib_allow_append then
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
						
						lstr_for_win.s_identifica		= is_list.s_identifica
						lstr_for_win.l_identifica		= is_list.l_identifica
						lstr_for_win.s_par_name			= is_list.s_par_name
						lstr_for_win.s_par_value		= is_list.s_par_value
						lstr_for_win.s_win_parametri	= is_list.s_win_parametri
						
						
						li_size = UpperBound(lstr_for_win.s_identifica)
						for li_counter = 1 to li_size
							lstr_for_win.l_identifica[li_counter] = iudw_parent.GetItemNumber(iudw_parent.GetRow(), lstr_for_win.s_identifica[li_counter])
							SetItem(ll_newrow , lstr_for_win.s_identifica[li_counter], lstr_for_win.l_identifica[li_counter])		
						next
						
						
						li_size = UpperBound(lstr_for_win.s_par_value)
						for li_counter = 1 to li_size
							lstr_for_win.s_par_value[li_counter] = iudw_parent.uf_Get_colval(lstr_for_win.s_par_name[li_counter])
							uf_Set_colval(lstr_for_win.s_par_name[li_counter], lstr_for_win.s_par_value[li_counter])
						next
						
						li_size = UpperBound(lstr_for_win.s_par_name)
						li_start_point = UpperBound(lstr_for_win.s_par_value) + 1
						for li_counter = li_start_point to li_size
							 lstr_for_win.s_par_value[li_counter] = iudw_parent.uf_Get_colval(lstr_for_win.s_par_name[li_counter])		
							 uf_Set_colval(lstr_for_win.s_par_name[li_counter], lstr_for_win.s_par_value[li_counter])
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
					
					
					
					
					
				next
			
				lstr_for_win.s_modo				= is_list.s_modo
				lstr_for_win.s_identifica		= is_list.s_win_chiave
				lstr_for_win.l_identifica		= is_list.l_win_chiave
				lstr_for_win.s_par_name			= is_list.s_par_name
				lstr_for_win.s_par_value		= is_list.s_par_value
				lstr_for_win.s_win_parametri	= is_list.s_win_parametri
				
				
				
				li_size = UpperBound(lstr_for_win.s_par_value)
				for li_counter = 1 to li_size
					if isNull (lstr_for_win.s_par_value[li_counter]) then
						lstr_for_win.s_par_value[li_counter] = iudw_parent.uf_Get_colval(lstr_for_win.s_par_name[li_counter])
					end if
				next
				
				
				
				li_size = UpperBound(lstr_for_win.s_par_name)
				li_start_point = UpperBound(lstr_for_win.s_par_value) + 1
				for li_counter = li_start_point to li_size
					ls_value = iudw_parent.uf_Get_colval(lstr_for_win.s_par_name[li_counter])		
					lstr_for_win.s_par_value[li_counter] = ls_value
				next
				
				
				
				OpenWithParm(iw_support, lstr_for_win, is_resp_window)

				This.SetFocus()
				
				ls_filter = ""
				lstr_rit = Message.PowerObjectParm
				li_size = UpperBound(lstr_rit.s_identifica)
				for  li_counter = 1 to li_size
					ls_colname = lstr_rit.s_identifica[li_counter]
					ls_colval = string(lstr_rit.l_identifica[li_counter])
					ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
				next
				ls_filter = Mid(ls_filter,5)
				
				
				
				
					TriggerEvent("ue_retrieve")
					if (RowCount()>0) and (is_resp_window <> "") then
						selectrow(1,true)
					end if
					ll_row = Find( ls_filter, 1, RowCount( ))
					ScrollToRow(ll_row)
				
			end if
	
		end if
	
	else
		ll_nonfare = 0
	end if  
	
	
	
	
	
	
	if ll_nonfare = 0 then
		
		
		ll_row =	rowcount()
		
		triggerevent("ue_initial")
		setitemstatus(ll_row,0,Primary!,DataModified!)
		setitemstatus(ll_row,0,Primary!,NotModified!)
		setitemstatus(ll_row,0,Primary!,New!)
	end if
end if
end event

event doubleclicked;string ls_column

if isValid( dwo ) then
	if row = 0 then 
			if not (dwo.Name = "datawindow") then
				ls_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 2)
				if ls_column = is_last_column then 
					if is_last_sort = "D" then
						this.SetSort(ls_column + " A")
						is_last_sort = "A"
		
		
		
		
					else
						this.SetSort(ls_column + " D")
						is_last_sort = "D"
		
		
		
		
						
					end if
				else 
					this.SetSort(ls_column + " A")
					is_last_column = ls_column
					is_last_sort = "A"
		
		
		
		
				end if
				this.Sort()
			end if
	else
		TriggerEvent("ue_modify")
	end if 
else
	if row > 0 then
		TriggerEvent("ue_modify")
	end if	
end if

end event

event ue_modify;call super::ue_modify;long 				ll_row
integer 			li_size, li_counter
string 			ls_filter, ls_colname, ls_colval
s_list_main 	lstr_for_win
s_rit_wp			lstr_rit

ll_row = GetRow()
if ll_row>0 then
	if not(is_resp_window = "") OR not(is_list.s_win_zoom = "") then
	
		is_list.s_modo 					= modo_modifica
		lstr_for_win.s_modo 				= is_list.s_modo
		lstr_for_win.s_identifica 		= is_list.s_win_chiave
		lstr_for_win.l_identifica 		= is_list.l_win_chiave
		lstr_for_win.s_par_name 		= is_list.s_par_name
		lstr_for_win.s_par_value 		= is_list.s_par_value
		lstr_for_win.s_win_parametri 	= is_list.s_win_parametri
		
		li_size = UpperBound(lstr_for_win.s_identifica)		
		for li_counter = 1 to li_size
			lstr_for_win.l_identifica[li_counter] = GetItemNumber( ll_row, lstr_for_win.s_identifica[li_counter])
		next
		
		li_size = UpperBound(lstr_for_win.s_par_name)
		for li_counter = 1 to li_size
			lstr_for_win.s_par_value[li_counter] = string(GetItemNumber(GetRow(), lstr_for_win.s_par_name[li_counter]))
		next
		
		if is_list.s_win_zoom = "" then
			OpenWithParm(iw_support, lstr_for_win, is_resp_window)
		else
			if not ((GetItemStatus(ll_row, 0, Primary!) = New!) OR (GetItemStatus(ll_row, 0, Primary!) = NewModified!)) then
				OpenWithParm(iw_support, lstr_for_win,is_list.s_win_zoom)
			end if
		end if
	
		
		ls_filter = ""
		lstr_rit = Message.PowerObjectParm
		li_size = UpperBound(lstr_rit.s_identifica)
		for  li_counter = 1 to li_size
			ls_colname = lstr_rit.s_identifica[li_counter]
			ls_colval = string(lstr_rit.l_identifica[li_counter])
			ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
		next
		ls_filter = Mid(ls_filter,5)
		
		
		
		
			TriggerEvent("ue_retrieve")
			if (RowCount()>0) and (is_resp_window <> "") then
				selectrow(1,true)
			end if
			ll_row = Find( ls_filter, 1, RowCount( ))
			ScrollToRow(ll_row)
		
		
	else
		
	end if
end if


end event

event ue_retrieve;integer li_size, li_counter,li_id_size, li_id_counter
long ll_row
u_dw_main ldw_item

ib_first_retrieve = true

CALL super::ue_retrieve


li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ll_row = GetRow()
		
	
	li_id_size = UpperBound(ldw_item.is_list.s_identifica)
	for li_id_counter = 1 to li_id_size
		if ll_row > 0 then
			ldw_item.is_list.l_identifica[li_id_counter] = GetItemNumber(ll_row, ldw_item.is_list.s_identifica[li_id_counter])
		else
			ldw_item.is_list.l_identifica[li_id_counter] = -1
		end if
	next
	ldw_item.TriggerEvent("ue_retrieve")
		
next

ib_first_retrieve = false

end event

event losefocus;

string		ls_color
long			ll_Color
w_p_data		lw_pa
u_dw_main 	ludw_pa


if (not ib_stop_accept) and (not ib_during_f4) then
	if AcceptText()>0 then
		ls_color = this.object.datawindow.color
		ll_color = long(ls_color)
		this.object.datawindow.color = "79741120"
	else
		lw_pa = u_freddie.iw_current
		
		lw_pa.post event ue_dwsetfocus(this)
	end if
end if




end event

event ue_core_update;long li_size, li_counter, ll_errors, ll_partial
u_dw_master_main ldw_item

ll_errors = 0
ll_errors = Super::EVENT ue_core_update (0,0)

li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ll_partial = ldw_item.trigger event ue_core_update (0,0)
	
	ll_errors = ll_errors+ll_partial
next

return ll_errors
end event

event rowfocuschanged;call super::rowfocuschanged;integer li_size, li_counter, li_id_counter, li_id_size
long ll_row
u_dw_master_main ldw_item



if not ib_first_retrieve then
	ll_row = GetRow()
	if ib_dw_shared then
	
		if IsValid(iudw_parent) then
			iudw_parent.ScrollToRow(ll_Row)
		end if
	else
		li_size = UpperBound(iudw_children)
			
		for li_counter = 1 to li_size
			ldw_item = iudw_children[li_counter]
			li_id_size = UpperBound(ldw_item.is_list.s_identifica)
			for li_id_counter = 1 to li_id_size
				if ll_row > 0 then
					ldw_item.is_list.l_identifica[li_id_counter] = GetItemNumber(ll_row, ldw_item.is_list.s_identifica[li_id_counter])
				else
					ldw_item.is_list.l_identifica[li_id_counter] = -1
				end if
			next
			ldw_item.TriggerEvent("ue_retrieve")
		next
		
		
		
		if not isvalid(iudw_parent) then
			li_id_size = upperbound(is_list.s_identifica)
			for li_id_counter = 1 to li_id_size
				is_ritorni.s_identifica[li_id_counter] = is_list.s_identifica[li_id_counter]
				is_ritorni.l_identifica[li_id_counter] = is_list.l_identifica[li_id_counter]
			next
		end if
		
		
	end if 		
end if

if is_resp_window <> "" then
	SelectRow(0,FALSE)
	SelectRow(currentrow, TRUE)
end if

end event

event getfocus;call super::getfocus;
string	ls_color, ls_class
long		ll_Color
w_p_data lw_win

integer	li_size, li_cnt

ls_color = this.object.datawindow.color
ll_color = long(ls_color)
this.object.datawindow.color = "10789024"


IF ISVALID(u_freddie.iw_current) THEN
	
	
	ls_class=u_freddie.iw_current.is_wintype
	if ls_class='W_P_DATA' THEN
			
	
	
	
	
	
	
		lw_win = u_freddie.iw_current
		
		If IsValid(lw_win) then
			li_size = lw_win.ii_dwcount
			for li_cnt = 1 to li_size
				
				if lw_win.idw_tree[li_cnt] = this then
					lw_win.ii_dwcurr = li_cnt
				end if
				
			next
		end if
	end if
END IF
ib_stop_accept = false
uf_disable_buttons()
end event

event ue_update;integer 		li_size, li_counter
long 			ll_NotGood
u_dw_main 	ldw_item

ll_NotGood = 0

if not ib_dw_shared then
	
	li_size = UpperBound(iudw_children)
	for li_counter = 1 to li_size
		ldw_item = iudw_children[li_counter]
		ll_NotGood = ll_NotGood + ldw_item.Event ue_update(0,0)
	next
	
	if ll_NotGood = 0 then 
		ll_NotGood = Super::EVENT ue_update (0,0)
	end if
	
	if ll_NotGood = 0  AND not IsValid(iudw_parent) then 
		
		ll_NotGood = Trigger Event ue_core_update (0,0)
		
		ll_NotGood = Trigger Event ue_commit(ll_NotGood)
		
		if ll_NotGood = 0 then
			
			Trigger Event ue_reset_flags()
		end if
		li_size = upperbound(is_list.l_identifica)
		for li_counter = 1 to li_size
			is_ritorni.s_identifica[li_counter] = is_list.s_identifica[li_counter]
			is_ritorni.l_identifica[li_counter] = is_list.l_identifica[li_counter]
		next
	end if
end if

return ll_NotGood
end event

