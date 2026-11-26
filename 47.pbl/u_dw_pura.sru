forward
global type u_dw_pura from datawindow
end type
end forward

global type u_dw_pura from datawindow
int Width=1491
int Height=825
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event ue_key pbm_dwnkey
event ue_set_search ( string as_nomecol,  string as_valcol )
event ue_use_search ( string as_nomecol )
event ue_comment ( )
end type
global u_dw_pura u_dw_pura

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
public function integer uf_set_colval (string as_nomecol, string as_valcol)
public function powerobject uf_w_set_focus ()
end prototypes

event ue_key;PowerObject			lpo_object
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

public function integer uf_set_colval (string as_nomecol, string as_valcol);
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
		CASE "date"
			SetItem(ll_row, as_nomecol, Date(as_valcol))
		CASE "datet"
			SetItem(ll_row, as_nomecol, DateTime(as_valcol))
		CASE "decim"
			SetItem(ll_row, as_nomecol, Dec(as_valcol))
		CASE ELSE
	END CHOOSE
end if
return 0
end function

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

