forward
global type u_dw_main from datawindow
end type
end forward

global type u_dw_main from datawindow
integer y = 1220
integer width = 2066
integer height = 752
integer taborder = 2
string icon = "Database!"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_init pbm_custom01
event ue_append pbm_custom03
event ue_togglequery pbm_custom06
event ue_insert pbm_custom02
event ue_update pbm_custom04
event ue_delete pbm_custom05
event ue_retrieve pbm_custom07
event ue_firstrecord pbm_custom08
event ue_prevrecord pbm_custom09
event ue_nextrecord pbm_custom10
event ue_lastrecord pbm_custom11
event ue_clearquery pbm_custom12
event ue_core_update pbm_custom13
event ue_show ( )
event ue_modify ( )
event ue_print ( )
event ue_pre_retrieve ( )
event ue_key pbm_dwnkey
event type integer ue_validate_row ( long al_row,  ref string as_error_text )
event type integer ue_validate_rows ( )
event ue_default ( dwobject adwo_current,  long al_row )
event ue_initial ( )
event type integer ue_scroll ( integer al_row )
event ue_keystop pbm_dwnprocessenter
event ue_set_search ( string as_nomecol,  string as_valcol )
event ue_use_search ( string as_nomecol )
event type long ue_itemerror ( long al_row,  dwobject adwo_dwo,  string as_data )
event ue_setcolumn ( string as_colname )
event ue_save_html ( )
event ue_saveas ( )
event type long ue_commit ( long lparam )
event ue_comment ( )
event ue_set_dddw ( )
event ue_retrieve_dddw ( )
end type
global u_dw_main u_dw_main

type variables
constant integer ici_confirm_update = 0
constant integer ici_confirm_delete = 1

integer		ii_num_children
u_dw_main	iudw_parent, iudw_children[]

boolean		ib_first_retrieve
boolean		ib_retrieved
boolean		ib_use_scanner
boolean		ib_is_shared
boolean		ib_dw_shared
boolean		ib_allow_insert
boolean		ib_allow_append
boolean		ib_allow_delete
boolean		ib_allow_update
string		is_title
boolean		ib_query_mode = false
string		is_focuscol = ""
boolean		ib_stop_accept = false
boolean		ib_during_f4 = false

string		ias_key_name[] 

string		is_resp_window	
string		is_search_window	
string		is_maint_window	
window		iw_support
boolean		ib_auto_commit = TRUE 
boolean		ib_sortorder

s_list_main	is_list
s_ric_param	is_ricpar, is_e_ricpar
s_rit_wp		is_ritorni

string		is_last_Column
string		is_last_sort

transaction	it_transaction
u_bob_main	iu_bob
u_sql_scanner	iu_scan

Dwobject		il_dwo_current

end variables

forward prototypes
public subroutine uf_init (s_dw astr_dw)
public subroutine uf_init ()
public function boolean uf_changes ()
public function integer ask_for_save ()
public function boolean getconfirm (integer ai_operation)
public function integer uf_validate_date (string as_colname, ref dwobject adwo_dwo, long al_row, string as_data)
public function long uf_to_update ()
public function string uf_get_colval (string as_nomecol)
public function decimal uf_getitemdecimal (long al_row, string as_column)
public function decimal uf_getitemdecimal (long al_row, string as_column, dwbuffer ad_tipo, boolean ab_original)
public subroutine uf_set_colval (string as_nomecol, string as_valcol)
public subroutine uf_sw_setnull (string as_data, string as_nomecol)
public function boolean uf_autofind (string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_dbvalori[])
public function integer uf_autofind_col (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_valori[], string as_dwcol[])
public function integer uf_autofind_val (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_valori[], string as_dwcol[])
public function integer uf_setitem (long al_row, string as_column_name, any aa_value, boolean ab_regenerate)
public function integer uf_reply_retrieve_dddw (string as_col_name)
end prototypes

event ue_init;


is_focuscol = ""

THIS.uf_init()

end event

event ue_insert;PostEvent("ue_initial")
end event

event ue_update;boolean		lb_lets_go = FALSE
long			ll_nrows, ll_row
integer		li_val_result, li_sbagli

li_sbagli = 0
if not IsValid(iudw_parent) then
	if ib_allow_update then
		if u_freddie.iw_current.ib_askforsave then
			if (THIS.getconfirm(ici_confirm_update)) then
				lb_lets_go = TRUE
			end if
		else
			lb_lets_go = TRUE
		end if
		u_freddie.iw_current.ib_askforsave = true
	
	
	end if
else
	if ib_allow_update then
		lb_lets_go = TRUE
	
	
	end if
end if 
if lb_lets_go then
	
	if THIS.accepttext()>0 then
		li_sbagli = Event ue_validate_rows()
		
	end if
else
	li_sbagli = -1
end if

return li_sbagli

end event

event ue_delete;
long		ll_row,ll_ret
ll_ret = 0
if this.RowCount() > 0 then
	if ib_allow_delete then
		if THIS.getconfirm(ici_confirm_delete) then
			ll_row = this.getrow()
			this.DeleteRow(0)
			this.SetFocus()
			ll_row  = ll_row  -1
			if ll_row > 0 then this.setrow(ll_row)
			ll_ret = 0
		else
			ll_ret = 1
		end if	
	else
		ll_ret = 1
	end if	
else
	ll_ret = 1
end if

return ll_ret
end event

event ue_retrieve;long					ll_row,ll_i,ll_row_child
integer				li_size, li_counter
DataWindowChild	dwc_drop
string				s_col_name, ls_filter, ls_sql

if UpperBound(is_list.l_identifica) > 0 then
		
	if IsValid(iudw_parent) then
		
		 CHOOSE CASE UpperBound(is_list.l_identifica)
			CASE 0
				Retrieve()
			CASE 1
				Retrieve( is_list.l_identifica[1])
			CASE 2
				Retrieve( is_list.l_identifica[1], is_list.l_identifica[2])
			CASE 3
				Retrieve( is_list.l_identifica[1], is_list.l_identifica[2], is_list.l_identifica[3])
			CASE 4
				Retrieve( is_list.l_identifica[1], is_list.l_identifica[2], is_list.l_identifica[3], is_list.l_identifica[4])
			CASE 5
				Retrieve( is_list.l_identifica[1], is_list.l_identifica[2], is_list.l_identifica[3], is_list.l_identifica[4], is_list.l_identifica[5])
			CASE 6
				Retrieve( is_list.l_identifica[1], is_list.l_identifica[2], is_list.l_identifica[3], is_list.l_identifica[4], is_list.l_identifica[5], is_list.l_identifica[6])
			CASE ELSE
				MessageBox("Attenzione", "E' stato superato il numero massimo di parametri " + &
				"utilizzabili nella retrieve.~r~nControllare l'evento ue_retrieve di u_dw_main.", StopSign!)
				HALT CLOSE
		END CHOOSE
	else
		
		if ib_use_scanner then
			
			li_size = upperbound(is_list.s_sql_ident)
			if li_size > 0 then
				for  li_counter = 1 to li_size
					ls_filter = ls_filter + " AND " + f_tilde_quote(is_list.s_sql_ident[li_counter])
					ls_filter = ls_filter + " = " + string(is_list.l_identifica[li_counter])
					is_ritorni.s_identifica[li_counter] = is_list.s_identifica[li_counter]
					is_ritorni.l_identifica[li_counter] = is_list.l_identifica[li_counter]
				next
				ls_filter = Mid(ls_filter,5)
				iu_scan.f_reset_cur_as_ini()
				iu_scan.f_add_where_condition(ls_filter)
				ls_sql = iu_scan.f_getcurrent()
				this.object.datawindow.table.select = ls_sql
			end if
			
			retrieve()
		else
			
			ls_filter = ""
			li_size = UpperBound(is_list.s_identifica)
			if (li_size>0) then
				if (is_list.l_identifica[1]) >0 then
					for  li_counter = 1 to li_size
						ls_filter = ls_filter + " AND " + is_list.s_identifica[li_counter] + " = " + string(is_list.l_identifica[li_counter])
						is_ritorni.s_identifica[li_counter] = is_list.s_identifica[li_counter]
						is_ritorni.l_identifica[li_counter] = is_list.l_identifica[li_counter]
					next
					ls_filter = Mid(ls_filter,5)
					SetFilter(ls_filter)
					Filter( )
				end if
			end if
			
			Retrieve()
		end if
		
	end if
else
	if ib_dw_shared then
		
		
		
		
		iudw_parent.ShareData(this)
		ll_row = iudw_parent.GetRow()
		ScrollToRow(ll_row)
	else
		
		Retrieve()
	end if
end if

end event

event ue_firstrecord;

THIS.ScrollToRow(1)
end event

event ue_prevrecord;

THIS.ScrollPriorRow()
end event

event ue_nextrecord;

THIS.ScrollNextRow()
end event

event ue_lastrecord;

THIS.ScrollToRow(THIS.RowCount())
end event

event ue_core_update;
long ll_retval,ll_del

ll_retval = 0

if not ib_dw_shared then
	ll_del = THIS.DeletedCount()
	if (THIS.ModifiedCount()>0) OR ll_del > 0 then
		if THIS.accepttext()>0 then
			if ib_auto_commit = TRUE then
				
				IF THIS.update(false,false) < 0 then 
					ll_retval = 5
				END IF
			else
				IF THIS.update(false,true) < 0 then 
					ll_retval = 5
				END IF
			end if
		else
			ll_retval = 5
		end if
	end if
end if

return ll_retval

end event

event ue_show;integer li_size, li_counter
u_dw_main ldwo_item

Enabled = FALSE
li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	 ldwo_item = iudw_children[li_counter]
	 ldwo_item.TriggerEvent("ue_show")
next
	
end event

event ue_print;Print()
end event

event ue_key;DataWindowChild	ldw_dropdown
DataWindowChild	ldw_drop
string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval
integer				li_cdw, li_size, li_i, li_ret
w_search_main		lw_sm
w_data_main			lw_win
w_mod_single_data lw_mw
w_p_data				lw_pwin
u_dw_main			lu_dw

long					ll_retv


ll_retv = 0


choose case key
	
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			
			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
		end if
		
	case KeyF5!
		if keyflags = 0 then
			ls_column = getColumnName()
			uf_reply_retrieve_dddw(ls_column)
			
		end if	
	
		
	case KeyF4!
		ll_retv = 1
		ib_during_f4 = true
		is_ricpar = is_e_ricpar
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		is_ricpar.b_imm_retrieve = false
		is_ricpar.s_caller_column = ls_column
		is_ricpar.s_sql_cond = ""
		is_search_window = ""
		ls_colval = ""
		trigger event ue_set_search (ls_column,ls_colval)
		if (is_search_window) <> "" then
			choose case keyflags
				case 0	
					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = false
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) <> "dddw" then
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						
						
						
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
					
				case 1	

					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column, ls_colval)
					if lower (ls_style) = "dddw" then
						
						OpenWithParm (lw_mw,is_ricpar,is_search_window)
						this.GetChild (ls_column, ldw_dropdown)
						ldw_dropdown.SetTransObject(SQLCA)
						ldw_dropdown.Retrieve ()
						li_size = upperbound(is_ricpar.s_ausil_value)
						for li_i = 1 to li_size
							if is_ricpar.s_ausil_value[li_i] > " " then
								this.GetChild (is_ricpar.s_ausil_value[li_i], ldw_dropdown)
								ldw_dropdown.SetTransObject(SQLCA)
								ldw_dropdown.Retrieve ()
							end if
						next
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
				case 2	
				case 3	
					ls_colval = gettext()
					is_ricpar.b_imm_maint = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) = "dddw" then
						
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						if not IsNull(Message.PowerObjectParm) then
							is_ricpar = Message.PowerObjectParm
							trigger event ue_use_search (ls_column)
						end if
					end if
					is_ricpar.b_imm_maint = false
			end choose
		end if
		ib_during_f4 = false

		
		
	case Keyadd!
		
		
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			ls_tipof = lw_win.is_wintype
			lu_dw = lw_win.idw_master
			choose case ls_tipof
				case "W_P_DATA"
					if this = lu_dw then
						if is_list.s_modo = modo_inserisci then 			
							if (event ue_update (0,0) = 0) then
								triggerevent("ue_insert")
							end if
							lu_dw.setFocus()
						end if
					else
						triggerevent("ue_insert")
					end if
				case else
					triggerevent("ue_insert")
			end choose
		end if
	case KeySubtract!
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			ls_tipof = lw_win.is_wintype
			lu_dw = lw_win.idw_master
			choose case ls_tipof
				case "W_P_DATA"
					if this <> lu_dw then
						triggerevent("ue_delete")
					else
						
						
						
						lw_win.triggerevent("ue_master_delete")
					end if
				case else
					triggerevent("ue_delete")
			end choose
		end if

	case KeyS!
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
	case KeyF12!
		if (keyFlags=0) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
		
		
		if (keyflags=3) then
			lw_win = u_freddie.iw_current
			lw_win.trigger event key (keyF12!,3)
		end if
	case KeyN!
		if (keyFlags=2) then
			ll_retv = 1
				lw_win = u_freddie.iw_current
				ls_tipof = lw_win.is_wintype
				lu_dw = lw_win.idw_master
				if ls_tipof = "W_P_DATA" then
					if (lu_dw.is_list.s_modo = modo_inserisci) or (lw_win.ib_nonmodale = true) then 	
						if (lu_dw.event ue_update (0,0) = 0) then
							lu_dw.triggerevent("ue_insert")
						end if
						lu_dw.setFocus()
					end if
				end if
      end if

	case KeyF6!
		lw_win = u_freddie.iw_current
		ls_tipof = lw_win.is_wintype
		if ls_tipof = "W_P_DATA" then
			lw_win.ib_F6_in_dw = true
			if (keyflags=0) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw++
					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
			if (keyFlags=1) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw --
					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
		end if
	case keydelete!		
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		if ls_style = "ddlb" then
			uf_set_colval(ls_column,u_freddie.gs_null)
			ll_retv = 1
		end if
end choose


return ll_retv



end event

event ue_validate_row;
return 0

end event

event ue_validate_rows;long ll_nrows, ll_row = 0, ll_count = 0, ll_sbagli=0
string ls_error_text
dwItemStatus status

if not ib_dw_shared then
	
	ll_nrows = this.RowCount()
	
	DO WHILE ll_row <= ll_nrows
		ll_row = this.GetNextModified(ll_row, Primary!)
		IF ll_row > 0 THEN 
			ls_error_text = "Errore di Validazione"
			if (this.trigger event ue_validate_row(ll_row,ls_error_text )) >0 then 
				
				ll_sbagli ++
				if (ls_error_text>" ") then
					MessageBox("Validazione di " + is_title, ls_error_text)
				end if
			end if
		ELSE
			ll_row = ll_nrows + 1
		END IF
	LOOP
	
else
	ll_sbagli = 0
end if

return ll_sbagli
end event

event ue_default;

end event

event ue_initial;


end event

event ue_scroll;if ib_dw_shared then
	return ScrollToRow(al_row)
else
	return 0
end if

end event

event ue_keystop;long		ll_row

ll_row = this.GetRow()

if KeyDown(KeyEnter!) then
	Post Event doubleclicked (0,0,ll_row,il_dwo_current)
	return 1
end if

end event

event ue_set_search;
end event

event ue_setcolumn;
if not isnull(as_colname) then
	if as_colname <> "" then
		this.setcolumn(as_colname)
	end if
end if


end event

event ue_save_html;
string		ls_htdir, ls_html
w_data_main	lw_1

lw_1 = u_freddie.iw_current
ls_html = lw_1.title
if isNull(ls_html) or ls_html = "" then
	ls_html = this.dataobject
end if

SELECT "par_sistema"."dir_html"  
	INTO :ls_htdir
   FROM "dba"."par_sistema"  
   WHERE "par_sistema"."id_azienda" = 1;

if isNull (ls_htdir) then ls_htdir = "."
if ls_htdir = "" then ls_htdir = "."
ls_html = ls_htdir+"\"+ls_html+".htm"

this.object.datawindow.retrieve.asneeded = "No"
this.retrieve()
this.object.datawindow.retrieve.asneeded = "Yes"
this.SaveAs(ls_html,HTMLTable!,True)

end event

event ue_saveas;this.SaveAs()

end event

event ue_commit;
long ll_retval

ll_retval = 5

if ib_auto_commit = true then
	if lparam = 0 then
		COMMIT USING SQLCA;
		if it_transaction.SQLCode>=0 then 
			THIS.ResetUpdate()
			ll_retval = 0
			
		else
			ROLLBACK USING SQLCA;
		end if
	else
		ROLLBACK USING SQLCA;
	end if
end if

return ll_retval

end event

event ue_set_dddw;
long					ll_current_row
integer				li_i,li_size,li_size_children,li_k
datawindowchild	ldwc_drop
u_dw_main			ldw_children

li_size				= UpperBound( is_list.s_colonne_drop )
li_size_children	= UpperBound( this.iudw_children )


for li_i	= 1 to li_size
	
	if this.ib_dw_shared = false then
		
		this.GetChild(is_list.s_colonne_drop[li_i],ldwc_drop )
	
	
	
		ll_current_row	= ldwc_drop.InsertRow(0)
		ldwc_drop.ScrollToRow(ll_current_row)	
	
		for li_k = 1 to li_size_children
			ldw_children	= this.iudw_children[li_k]
			ldw_children.event ue_set_dddw()
		next			
	end if	
	
next	

return
end event

event ue_retrieve_dddw;
string				ls_col_focus
integer				li_i,li_ret
datawindowchild	ldwc_drop

if this.ib_dw_shared = true then
	if this.ib_retrieved	= false then
		
		ls_col_focus	= this.GetColumnName()
		
		for li_i = 1 to UpperBound( is_list.s_colonne_drop )
			if this.GetChild( is_list.s_colonne_drop[li_i],ldwc_drop ) = 1 then
				li_ret	= ldwc_drop.SetTransObject(SQLCA)
				li_ret	= ldwc_drop.Retrieve()				
			end if
		next
		
		for li_i = 1 to UpperBound( is_list.s_colonne_drop )
			if is_list.s_colonne_drop[li_i] = ls_col_focus then
				this.SetColumn(ls_col_focus)
			end if
		next	
		
		this.ib_retrieved	= true
		
	end if		
end if
end event

public subroutine uf_init (s_dw astr_dw);
it_transaction = astr_dw.transaction
if not isnull(astr_dw.parent_dw) then
	iudw_parent = astr_dw.parent_dw
	iudw_parent.ii_num_children ++ 
	iudw_parent.iudw_children[iudw_parent.ii_num_children] = THIS
end if
iu_bob.iudw_main = THIS
ib_use_scanner = false

end subroutine

public subroutine uf_init ();
u_dw_main   ludw_1

it_transaction = SQLCA

ib_is_shared = false
ib_use_scanner = false
ib_dw_shared = false
ib_allow_insert = true
ib_allow_append = true
ib_allow_update = true
ib_allow_delete = true
ludw_1 = this

u_freddie.iudw_current = ludw_1

end subroutine

public function boolean uf_changes ();THIS.AcceptText()
if THIS.ModifiedCount()+THIS.DeletedCount()>0 then
	RETURN true
else
	RETURN false
end if
end function

public function integer ask_for_save ();

integer	li_ync, li_retval
long		ll_mods

if THIS.uf_changes() then
	li_ync = MessageBox(THIS.is_title, "Ci sono modifiche non salvate in " + THIS.is_title + ".~n~r" + &
		"Vuoi salvarle?", Question!, YesNoCancel!)
	CHOOSE CASE li_ync
		CASE 1
			
			
			THIS.triggerevent("ue_update")
			
			ll_mods = uf_to_update()
			if ll_mods = 0 then 
				li_retval = 0
			else
				li_retval = 1
			end if
		CASE 2
			
			li_retval = 0
		CASE 3
			
			li_retval = 1
	END CHOOSE
else
	
	li_retval = 0
end if

return li_retval
end function

public function boolean getconfirm (integer ai_operation);

string ls_msg
integer li_but

CHOOSE CASE ai_operation
	CASE ici_confirm_update
		ls_msg = "Confermi il salvataggio dei dati?"
		li_but = 1
	CASE ici_confirm_delete
		ls_msg = "Confermi l'eliminazione del record?"
		li_but = 2
END CHOOSE

if MessageBox(THIS.is_Title, ls_msg, Question!, YesNo!, li_but) = 1 then
	return True
else
	return False
end if
end function

public function integer uf_validate_date (string as_colname, ref dwobject adwo_dwo, long al_row, string as_data);

string ls_data

if as_colname=adwo_dwo.name then

	ls_data = left(as_data,2)+"/"+mid(as_data,3,2)+"/"+mid(as_data,5)
	if IsDate(ls_data) then
		setItem(al_row,as_colname,date(ls_data))
		return 3
	else
		return 0
	end if
	
end if

end function

public function long uf_to_update ();integer li_size, li_counter
long ll_to_update
u_dw_main ldw_item

if not ib_dw_shared then
	ll_to_update = ModifiedCount() + DeletedCount()
	li_size = UpperBound(iudw_children)
	for li_counter = 1 to li_size
		ldw_item = iudw_children[li_counter]
		ll_to_update = ll_to_update + ldw_item.uf_To_Update()
	next
end if
return ll_to_update

end function

public function string uf_get_colval (string as_nomecol);
string ls_coltype, ls_value
long ll_row

ll_row = GetRow()
if ll_row>0 then
	ls_coltype = Describe(as_nomecol + ".coltype")
	CHOOSE CASE Mid(ls_coltype,1,5)
		CASE "char(", "char"
			ls_value = string(GetItemString(ll_row, as_nomecol))
		CASE "long"
			ls_value = string(GetItemNumber(ll_row, as_nomecol))
		CASE "numbe"
			ls_value = string(GetItemNumber(ll_row, as_nomecol))
		CASE "date"
			ls_value = string(GetItemDate(ll_row, as_nomecol), "dd/mm/yyyy")
		CASE "datet"
			ls_value = string(GetItemDateTime(ll_row, as_nomecol))
		CASE "decim"
			ls_value = string(uf_GetItemDecimal(ll_row, as_nomecol))	
		CASE ELSE
			MessageBox("uf_get_colval","Tipo non riconosciuto: '" + ls_coltype + "'")
	END CHOOSE
else
	ls_value = u_freddie.gs_null
end if

return ls_value

end function

public function decimal uf_getitemdecimal (long al_row, string as_column);

decimal ld_value

ld_value = this.GetItemNumber(al_row,as_column)
if not (isNull(ld_value)) then
	ld_value = this.GetItemDecimal(al_row,as_column)
end if

return ld_value


end function

public function decimal uf_getitemdecimal (long al_row, string as_column, dwbuffer ad_tipo, boolean ab_original);

decimal ld_value

ld_value = GetItemNumber(al_row,as_column,ad_tipo,ab_original)
if not (isNull(ld_value)) then
	ld_value = GetItemDecimal(al_row,as_column,ad_tipo,ab_original)
end if

return ld_value

end function

public subroutine uf_set_colval (string as_nomecol, string as_valcol);
string ls_coltype, ls_value
long ll_row

if as_valcol = "" then SetNull(as_valcol)
ll_row = GetRow()
if (ll_row>0) then
	ls_coltype = Describe(as_nomecol + ".coltype")
	CHOOSE CASE Mid(ls_coltype,1,5)
		CASE "char("
			SetItem(ll_row, as_nomecol, as_valcol)
		CASE "long"
			SetItem(ll_row, as_nomecol, Long(as_valcol))
		CASE "date"
			SetItem(ll_row, as_nomecol, Date(as_valcol))
		CASE "datet"
			SetItem(ll_row, as_nomecol, DateTime(as_valcol))
		CASE "decim"
			SetItem(ll_row, as_nomecol, Dec(as_valcol))
		CASE ELSE
	END CHOOSE
end if

end subroutine

public subroutine uf_sw_setnull (string as_data, string as_nomecol);

if isNull(as_data) or as_data = "" then
	uf_set_colval(as_nomecol,u_freddie.gs_null)
end if


end subroutine

public function boolean uf_autofind (string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_dbvalori[]);


string		ls_sql_statement, ls_tabella, ls_where
integer		li_size, li_counter
integer		li_nout, li_sqlerr
boolean		lb_ok


if isNull(as_valric) or as_valric = "" then
	
	
	
else
	
	
	
	lb_ok = false
	
	
	
	ls_tabella = "dba."+as_tabella
	
	
	
	
	ls_where = trim(as_sql_add)
	li_size = ai_ncol
	ls_sql_statement = "select "
	for li_counter =1 to li_size - 1
		ls_sql_statement = ls_sql_statement + ls_tabella + "." + as_dbcampi[li_counter] + ", "
	next
	ls_sql_statement = ls_sql_statement + ls_tabella + "." + as_dbcampi[li_size]
	ls_sql_statement = ls_sql_statement + " from "
	ls_sql_statement = ls_sql_statement + ls_tabella + " where (" + ls_tabella+"."+as_campo
	ls_sql_statement = ls_sql_statement + " = "
	
	choose case as_tiporic
		case "A"	
			ls_sql_statement = ls_sql_statement + "'" + as_valric + "'"
		case "N" 
			ls_sql_statement = ls_sql_statement + as_valric 
		case else 
	end choose
	
	
	
	ls_sql_statement = ls_sql_statement + ") "
	if ls_where > "" then
		ls_sql_statement = ls_sql_statement + "and (" + ls_where + ")"
	end if
	
	
	
	prepare sqlsa from :ls_sql_statement;
	li_sqlerr = sqlca.sqlcode
	if li_sqlerr = 0 then
		describe sqlsa into sqlda;
	end if
	li_sqlerr = sqlca.sqlcode
	if li_sqlerr = 0 then
		declare mycursor dynamic cursor for sqlsa;
	end if
	li_sqlerr = sqlca.sqlcode
	if li_sqlerr = 0 then
	
		open dynamic mycursor using descriptor sqlda;
		fetch mycursor using descriptor sqlda;
		li_sqlerr = sqlca.sqlcode
		
		if li_sqlerr = 0 then
			
			lb_ok = true
			
			
			li_nout = sqlda.NumOutputs
			if li_nout <> li_size then
				lb_ok = false
			else
				for li_counter = 1 to li_size
					choose case sqlda.OutParmType[li_counter]
						case TypeDate!
							as_dbvalori[li_counter] = string (GetDynamicDate(sqlda,li_counter))
						case TypeDateTime!
							as_dbvalori[li_counter] = string (GetDynamicDateTime(sqlda,li_counter))
						case TypeDecimal!, TypeDouble!, TypeInteger!, TypeLong!, TypeReal!, TypeBoolean!
							as_dbvalori[li_counter] = string (GetDynamicNumber(sqlda,li_counter))
						case TypeUInt!, TypeULong!
							as_dbvalori[li_counter] = string (GetDynamicNumber(sqlda,li_counter))
						case TypeString!
							as_dbvalori[li_counter] = string (GetDynamicString(sqlda,li_counter))
						case TypeTime!
							as_dbvalori[li_counter] = string (GetDynamicTime(sqlda,li_counter))
						case else
							as_dbvalori[li_counter] = string (GetDynamicString(sqlda,li_counter))
					end choose
				next
			end if
			
			
			fetch mycursor using descriptor sqlda;
			li_sqlerr = sqlca.sqlcode
			if li_sqlerr<> 100 then
				lb_ok = false
			end if
		end if
		
		close mycursor;
	
	end if
	
end if

return lb_ok

end function

public function integer uf_autofind_col (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_valori[], string as_dwcol[]);

integer		li_size, li_counter, li_retval
boolean		lb_ok

if ib_during_f4 then
	return 0
else
	li_size = ai_ncol
	if isNull(as_valric) or as_valric = "" then
		for li_counter = 1 to li_size
			uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
		next
		li_retval = 0
	else
		lb_ok = uf_autofind(as_tabella,as_campo,as_tiporic,as_valric,as_sql_add,ai_ncol,as_dbcampi,as_valori)
		if lb_ok then
			for li_counter = 1 to li_size
				uf_set_colval(as_dwcol[li_counter],as_valori[li_counter])
			next
			li_retval = 1
		else
			for li_counter = 1 to li_size
				uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
			next
			
			post event ue_setcolumn (as_dwoname)
			
			post event ue_key (KeyF4!,0)
			
			li_retval = 0
		end if
		
	end if
	
	return li_retval
end if

end function

public function integer uf_autofind_val (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_valori[], string as_dwcol[]);

integer		li_size, li_counter, li_retval
boolean		lb_ok
string		ls_dwc[], ls_val[]


if ib_during_f4 then
	return 0
else
	li_size = ai_ncol
	if isNull(as_valric) or as_valric = "" then
		
		
		
		
		for li_counter = 1 to li_size
			uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
		next
		li_retval = 0
		
	else
		
		
		
		li_retval = 1
		lb_ok = uf_autofind(as_tabella,as_campo,as_tiporic,as_valric,as_sql_add,ai_ncol,as_dbcampi,ls_val)
		if not lb_ok then
			
			for li_counter = 1 to li_size
				uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
			next
			
			post event ue_setcolumn (as_dwoname)
			
			post event ue_key (KeyF4!,0)
			
			li_retval = 0
		else
			as_valori = ls_val
		end if
		
	end if
	
	return li_retval
end if

end function

public function integer uf_setitem (long al_row, string as_column_name, any aa_value, boolean ab_regenerate);

string 			ls_coltype, ls_value
long 				ll_ret_value
dwitemstatus 	ldwis_current

ll_ret_value= 0
ldwis_current= GetItemStatus ( al_row, as_column_name, Primary!)
if (al_row>0) then
	ls_coltype = Describe(as_column_name + ".coltype")
	CHOOSE CASE Mid(ls_coltype,1,5)
		CASE "char("
			SetItem(al_row, as_column_name, String(aa_value))
		CASE "long"
			SetItem(al_row, as_column_name, Long(aa_value))
		CASE "date"
			SetItem(al_row, as_column_name, Date(aa_value))
		CASE "datet"
			SetItem(al_row, as_column_name, DateTime(aa_value))
		CASE "decim"
			SetItem(al_row, as_column_name, Dec(aa_value))
		CASE ELSE
			
			ll_ret_value= -1
	END CHOOSE
end if
If ll_ret_value = 0 AND ab_regenerate then
	SetItemStatus(al_row, as_column_name, Primary!, ldwis_current)
end if

return ll_ret_value

end function

public function integer uf_reply_retrieve_dddw (string as_col_name);
string				ls_style
string				ls_data_column,ls_data_column_conf
integer				li_i,li_size
datawindowchild	ldwc_drop

ls_style = this.describe(as_col_name+".edit.style")

if lower (ls_style) = "dddw" then
	
	ls_data_column	= this.Describe( as_col_name + ".dddw.DataColumn" )
	li_size	= UpperBound(is_list.s_colonne_drop)
	
	for li_i	= 1 to li_size 
		ls_data_column_conf = this.Describe( is_list.s_colonne_drop[li_i] + ".dddw.DataColumn" )
		if ls_data_column_conf = ls_data_column then
			this.GetChild (is_list.s_colonne_drop[li_i],ldwc_drop)
			ldwc_drop.Reset()
			ldwc_drop.SetTransObject(SQLCA)
			ldwc_drop.Retrieve()											
		end if
	next

end if	

return 0
end function

event constructor;
string ls_sql

iu_scan = create u_sql_scanner
THIS.triggerevent("ue_init")
THIS.SetTransObject(SQLCA)

if THIS.dataobject > " " then
	ls_sql = THIS.object.datawindow.table.select
	iu_scan.f_setinitial(ls_sql)
	iu_scan.f_setcurrent(ls_sql)
end if	



end event

event destructor;
if isvalid(iu_scan) then destroy iu_scan

end event

event getfocus;
long					ll_row
string				ls_tipof,ls_describe,ls_tab
string				ls_col_focus
w_data_main			lw_win


ls_tab	= ""

u_freddie.iudw_current = THIS

ll_row	= this.GetRow()

lw_win = u_freddie.iw_current
if Not IsNull(lw_win) then
	ls_tipof = lw_win.is_wintype
	if ls_tipof = "W_P_DATA" then
		lw_win.ib_F6_in_dw = false
	end if
end if

triggerevent("ue_retrieve_dddw")

end event

event losefocus;

SetNull(u_freddie.iudw_current)
end event

event itemerror;
long		ll_retval
string	ls_coltype, ls_data, ls_dat2, ls_colname
boolean	ll_goon
integer  li_ret

ls_coltype = dwo.coltype
ls_colname = dwo.name
ls_data = data

ib_stop_accept = true

if ls_coltype = "date" then
	
	ll_goon = true
	li_ret = 0
	if not IsDate(ls_data) then 
		
		li_ret = f_validate_date(ls_data,ls_dat2)
		if li_ret = 1 then ls_data = ls_dat2 else ll_goon = false
	end if
	
	
	
	
	if ll_goon then
		if li_ret=0 then
			
			
			ll_retval = event ue_itemerror(row,dwo,ls_data)
			if isNull(ll_retval) then ll_retval = 0
		else
			
			
			
			
			ll_retval = event ue_itemerror(row,dwo,ls_data)
			if isNull(ll_retval) then ll_retval = 2
			if ll_retval = 2 then
				setItem(row,ls_colname,date(ls_data))
				ll_retval = 3
				
				
				Post Event ItemChanged (row, dwo, ls_data)
				
				
			end if
		end if
	else
		
		ll_retval = 0
	end if
	
else
	
	
	ll_retval = event ue_itemerror(row,dwo,ls_data)
	if isNull(ll_retval) then ll_retval = 0
end if

return ll_retval

end event

event itemfocuschanged;string	ls_ilnome, ls_modi, ls_tipo, ls_column, ls_coltype, ls_value, ls_objtype
long		ll_row, ll_lung
boolean	lb_is_new

il_dwo_current= dwo


	if is_focuscol <> "" then
		
		ls_ilnome = is_focuscol+"_t"
		ls_modi = ls_ilnome + ".Color='0'"
		modify(ls_modi)
		ls_ilnome = is_focuscol+"_tt"
		ls_modi = ls_ilnome + ".Color='0'"
		modify(ls_modi)
	end if
	
	is_focuscol = dwo.name
	
	ls_ilnome = is_focuscol+"_t"
	ls_modi = ls_ilnome + ".Color='15466496'"	
	modify(ls_modi)
	ls_ilnome = is_focuscol+"_tt"
	ls_modi = ls_ilnome + ".Color='16777215'" 
	modify(ls_modi)
	

if not ib_query_mode then
	ll_row = GetRow()
	if (ll_row>0) and (ll_row<= rowcount()) then
		ls_column = string(dwo.name)
		ls_coltype = string(dwo.coltype)
		CHOOSE CASE Mid(ls_coltype,1,5)
			CASE "char("
				ls_value = string(GetItemString(ll_row, ls_column))
			CASE "long"
				ls_value = string(GetItemNumber(ll_row, ls_column))
			CASE "date"
				ls_value = string(GetItemDate(ll_row, ls_column))
			CASE "datet"
				ls_value = string(GetItemDateTime(ll_row, ls_column))
			CASE "decim"
				
				ls_value = string(GetItemNumber(ll_row, ls_column))	
			CASE ELSE
		END CHOOSE
		
		lb_is_new = (GetItemStatus(ll_row, 0, Primary!) = New!) OR (GetItemStatus(ll_row, 0, Primary!) = NewModified!)
		if (ls_value = "" OR IsNull(ls_value)) AND lb_is_new then 
			trigger event ue_default(dwo, ll_row)
			ll_lung = len(this.getText())
			if ll_lung<100 then ll_lung = 100
			this.selectText(1,ll_lung)
			
		end if
	else
		MessageBox ("Riga zero!!","u_dw_main, ItemFocusChanged")
	end if
end if
end event

event clicked;string 			ls_column, ls_prot, ls_colval
string 			ls_nomedwo, ls_tipodwo
string			ls_eval_expr
w_search_main	lw_sm
s_ric_param ls_ricparm

ls_nomedwo = dwo.name
ls_tipodwo = dwo.type
if ((ls_tipodwo="bitmap") and (right(ls_nomedwo,3)="_sw")) then
	ls_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 3)
	ls_prot = describe(ls_column+".protect")
	
	IF NOT IsNumber(ls_prot) THEN
		ls_prot = Right(ls_prot, Len(ls_prot) - Pos(ls_prot, "~t"))
		ls_eval_expr = "Evaluate(~"" + ls_prot + ", " + string(row) + ")"
		ls_prot = Describe(ls_eval_expr)
	END IF

	if ls_prot = "0" then
		
		
		if row <> GetRow() then scrolltorow(row)
		
		if getColumnName() <> ls_column then
			ib_during_f4 = true
			setcolumn(ls_column)
			ib_during_f4 = false
		end if
		
		ls_colval = gettext()
		
		
		
		
		is_ricpar.s_caller_column = dwo.name
		is_ricpar.s_sql_cond = ""
		is_ricpar.b_imm_insert = false
		is_ricpar.b_imm_retrieve = false
		is_search_window = ""
		trigger event ue_set_search (ls_column, ls_colval)
		ib_during_f4 = true
		OpenWithParm (lw_sm,is_ricpar,is_search_window)
		ib_during_f4 = false
		
		
		
		
		
		is_ricpar = Message.PowerObjectParm
		IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
			trigger event ue_use_search (ls_column)
		end if
	end if
end if



end event

event dberror;s_dberr		lstr_dberr
window		lw_err

lstr_dberr.l_sqlcode = sqldbcode
lstr_dberr.s_sqlerrtext = sqlerrtext

OpenWithParm(lw_err,lstr_dberr,"w_db_err")

return 1
end event

on u_dw_main.create
end on

on u_dw_main.destroy
end on

