forward
global type u_dw_ext_main from datawindow
end type
end forward

global type u_dw_ext_main from datawindow
int Width=1943
int Height=760
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event ue_setcolumn ( string as_colname )
event ue_key pbm_dwnkey
event ue_set_search ( string as_nomecol,  string as_valcol )
event ue_use_search ( string as_nomecol )
event ue_init ( )
event ue_post_open ( )
event type long ue_itemerror ( long al_row,  dwobject adwo_dwo,  string as_data )
event ue_initial ( )
event ue_default ( dwobject adwo_current,  long al_row )
event ue_insert ( )
event ue_comment ( )
end type
global u_dw_ext_main u_dw_ext_main

type variables
string		is_title
boolean		ib_stop_accept = false
boolean		ib_during_f4 = false

string		is_resp_window	
string		is_search_window	
string		is_maint_window	
window		iw_support

s_ric_param	is_ricpar, is_e_ricpar
string		is_colonne_drop[]	

dwobject		il_dwo_current
string		is_focuscol = ""
boolean		ib_query_mode = false

end variables

forward prototypes
public function decimal uf_getitemdecimal (long al_row, string as_column)
public function boolean uf_autofind (string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_dbvalori[])
public function integer uf_autofind_col (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_dbvalori[], string as_dwcol[])
public function integer uf_autofind_val (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_dbvalori[], string as_dwcol[])
public function string uf_get_colval (string as_nomecol)
public subroutine uf_set_colval (string as_nomecol, string as_valcol)
public function powerobject uf_w_set_focus ()
public subroutine uf_sw_setnull (string as_data, string as_nomecol)
public function integer uf_reply_retrieve_dddw (string as_col_name)
end prototypes

event ue_setcolumn;
if not isnull(as_colname) then
	if as_colname <> "" then
		this.setcolumn(as_colname)
	end if
end if


end event

event ue_key;DataWindowChild	ldw_drop
PowerObject			lpo_object
string				ls_column, ls_style, ls_colval
window				lw_win
w_wiz_main			lw_main
w_search_main		lw_sm

choose case key
	case keydelete!		
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		if ls_style = "ddlb" then
			uf_set_colval(ls_column,u_freddie.gs_null)
		end if
		
	case KeyF5!
		if keyflags = 0 then
			ls_column = getColumnName()
			uf_reply_retrieve_dddw(ls_column)
			
		end if	
		
	case KeyF4!
		
		
		ib_during_f4 = true
		if keyflags = 0 then
			
			ls_colval = gettext()
			is_ricpar = is_e_ricpar
			ls_column = getColumnName()
			is_ricpar.b_imm_retrieve = false
			is_ricpar.s_caller_column = ls_column
			is_ricpar.s_sql_cond = ""
			is_search_window = ""
			trigger event ue_set_search (ls_column,ls_colval)
			if (is_search_window) <> "" then			
				
				OpenWithParm (lw_sm,is_ricpar,is_search_window)

				
				
				
				is_ricpar = Message.PowerObjectParm
				IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
					trigger event ue_use_search (ls_column)
				end if
				
			end if
		else
		end if	
		ib_during_f4 = false
		
	case KeyF12!
		if (keyflags=3) then
			lw_win = this.uf_w_set_focus()
			lw_win.trigger event key (keyF12!,3)
		end if
		
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
	      ShowHelp(u_freddie.is_helpfile, Topic!,long(this.object.DataWindow.Help.TypeID.Retrieve.Argument) )
		end if	
	
end choose


end event

event ue_post_open;DataWindowChild	dwc_drop
integer				li_size, li_counter
	
li_size = UpperBound(is_colonne_drop)
for li_counter = 1 to li_size
	this.GetChild (is_colonne_drop[li_counter], dwc_drop)
	dwc_drop.SetTransObject(SQLCA)
	dwc_drop.Retrieve ()
next

end event

event ue_default;

end event

event ue_insert;long ll_newrow

ll_newrow = InsertRow(0) 
if ll_newrow <> -1 then
	ScrollToRow(ll_newrow)
	TriggerEvent("ue_initial")
end if
end event

public function decimal uf_getitemdecimal (long al_row, string as_column);

decimal ld_value

ld_value = this.GetItemNumber(al_row,as_column)
if not (isNull(ld_value)) then
	ld_value = this.GetItemDecimal(al_row,as_column)
end if

return ld_value


end function

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

public function integer uf_autofind_col (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_dbvalori[], string as_dwcol[]);

integer		li_size, li_counter, li_retval
boolean		lb_ok

if ib_during_f4 then
	return 0
else
	li_size = ai_ncol
	if isNull(as_valric) or as_valric = "" then
		
		
		
		
		for li_counter = 1 to li_size
			if as_dwcol[li_counter] <> "" then
				uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
			end if
		next
		li_retval = 0
		
	else
		
		
		
		lb_ok = uf_autofind(as_tabella,as_campo,as_tiporic,as_valric,as_sql_add,ai_ncol,as_dbcampi,as_dbvalori)
		if lb_ok then
			
			for li_counter = 1 to li_size
				if as_dwcol[li_counter] <> "" then
					uf_set_colval(as_dwcol[li_counter],as_dbvalori[li_counter])
				end if
			next
			li_retval = 1
		else
			
			for li_counter = 1 to li_size
				if as_dwcol[li_counter] <> "" then
					uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
				end if
			next
			
			post event ue_setcolumn (as_dwoname)
			
			post event ue_key (KeyF4!,0)
			
			li_retval = 0
		end if
		
	end if
	
	return li_retval
end if

end function

public function integer uf_autofind_val (string as_dwoname, string as_tabella, string as_campo, string as_tiporic, string as_valric, string as_sql_add, integer ai_ncol, string as_dbcampi[], ref string as_dbvalori[], string as_dwcol[]);

integer		li_size, li_counter, li_retval
boolean		lb_ok
string		ls_dwc[], ls_val[]


if ib_during_f4 then
	return 0
else
	li_size = ai_ncol
	if isNull(as_valric) or as_valric = "" then
		
		
		
		
		for li_counter = 1 to li_size
			if as_dwcol[li_counter] <> "" then
				uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
			end if
		next
		li_retval = 0
		
	else
		
		
		
		li_retval = 1
		lb_ok = uf_autofind(as_tabella,as_campo,as_tiporic,as_valric,as_sql_add,ai_ncol,as_dbcampi,ls_val)
		if not lb_ok then
			
			for li_counter = 1 to li_size
				if as_dwcol[li_counter] <> "" then
					uf_set_colval(as_dwcol[li_counter],u_freddie.gs_null)
				end if
			next
			
			post event ue_setcolumn (as_dwoname)
			
			post event ue_key (KeyF4!,0)
			
			li_retval = 0
		else
			as_dbvalori = ls_val
		end if
		
	end if
	
	return li_retval
end if

end function

public function string uf_get_colval (string as_nomecol);
string ls_coltype, ls_value
long ll_row

ll_row = GetRow()
if ll_row>0 then
	ls_coltype = Describe(as_nomecol + ".coltype")
	CHOOSE CASE Mid(ls_coltype,1,5)
		CASE "char("
			ls_value = string(GetItemString(ll_row, as_nomecol))
		CASE "long"
			ls_value = string(GetItemNumber(ll_row, as_nomecol))
		CASE "date"
			ls_value = string(GetItemDate(ll_row, as_nomecol), "dd/mm/yyyy")
		CASE "datet"
			ls_value = string(GetItemDateTime(ll_row, as_nomecol))
		CASE "decim"
			ls_value = string(uf_GetItemDecimal(ll_row, as_nomecol))	
		CASE ELSE
	END CHOOSE
else
	ls_value = u_freddie.gs_null
end if

return ls_value

end function

public subroutine uf_set_colval (string as_nomecol, string as_valcol);
string ls_coltype, ls_value
long ll_row

ll_row = GetRow()
if (ll_row>0) then
	ls_coltype = Describe(as_nomecol + ".coltype")
	CHOOSE CASE Mid(ls_coltype,1,5)
		CASE "char("
			SetItem(ll_row, as_nomecol, as_valcol)
		CASE "long"
			SetItem(ll_row, as_nomecol, Long(as_valcol))
		CASE "numbe"
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

public function powerobject uf_w_set_focus ();PowerObject 	lpo_uno, lpo_due
Userobject  	luo_uno
tab				ltb_uno

lpo_uno 	 = this.GetParent()
if typeof(lpo_uno) = UserObject! then
	lpo_due = lpo_uno.GetParent()
	if typeof(lpo_due) = Tab! then
		ltb_uno = lpo_due
		luo_uno = lpo_uno
		
		
		
		if (ltb_uno.visible) and (ltb_uno.enabled) and (luo_uno.visible) and (luo_uno.enabled) then

			ltb_uno.SelectTab(lpo_uno)
			
			lpo_uno = ltb_uno.GetParent()
			
			if typeof(lpo_uno) = UserObject! then
				lpo_due = lpo_uno.GetParent()
				if typeof(lpo_due) = Tab! then
					ltb_uno = lpo_due
					luo_uno = lpo_uno
					
					
					
					if (ltb_uno.visible) and (ltb_uno.enabled) and (luo_uno.visible) and (luo_uno.enabled) then
						
						ltb_uno.SelectTab(lpo_uno)
					end if
				end if
			end if
		end if
	end if
end if
return lpo_uno

end function

public subroutine uf_sw_setnull (string as_data, string as_nomecol);

if isNull(as_data) or as_data = "" then
	uf_set_colval(as_nomecol,u_freddie.gs_null)
end if


end subroutine

public function integer uf_reply_retrieve_dddw (string as_col_name);
string				ls_style
string				ls_data_column,ls_data_column_conf
integer				li_i,li_size
datawindowchild	ldwc_drop

ls_style = this.describe(as_col_name+".edit.style")

if lower (ls_style) = "dddw" then
	
	
	ls_data_column	= this.Describe( as_col_name + ".dddw.DataColumn" )
	li_size	= UpperBound(is_colonne_drop)
	
	for li_i	= 1 to li_size 
		ls_data_column_conf = this.Describe( is_colonne_drop[li_i] + ".dddw.DataColumn" )
		if ls_data_column_conf = ls_data_column then
			this.GetChild (is_colonne_drop[li_i],ldwc_drop)
			ldwc_drop.Reset()
			ldwc_drop.SetTransObject(SQLCA)
			ldwc_drop.Retrieve()											
		end if
	next
	
end if	

return 0
end function

event constructor;triggerevent("ue_init")
end event

event clicked;string 			ls_column, ls_prot, ls_colval
string 			ls_nomedwo, ls_tipodwo
string			ls_eval_expr
w_search_main	lw_sm

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
		
		if getColumnName() <> ls_column then setcolumn(ls_column)
		
		ls_colval = gettext()
		
		
		
		

		
		is_ricpar.s_caller_column = ls_column
		is_ricpar.s_sql_cond = ""
		is_ricpar.b_imm_insert = false
		is_ricpar.b_imm_retrieve = false
		is_search_window = ""
		trigger event ue_set_search (ls_column, ls_colval)
		OpenWithParm (lw_sm,is_ricpar,is_search_window)

		
		
		
		
		is_ricpar = Message.PowerObjectParm
		IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
			trigger event ue_use_search (ls_column)
		end if
	end if
end if



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
	ls_modi = ls_ilnome + ".Color='16777215'"
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

event getfocus;
string	ls_color
long		ll_Color
w_p_data lw_win
integer	li_size, li_cnt

ls_color = this.object.datawindow.color
ll_color = long(ls_color)
this.object.datawindow.color = "10789024"

ib_stop_accept = false

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
	end if
end if

end event

