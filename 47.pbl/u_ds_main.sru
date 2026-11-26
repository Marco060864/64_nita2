forward
global type u_ds_main from datastore
end type
end forward

global type u_ds_main from datastore
event ue_comment ( )
end type
global u_ds_main u_ds_main

type variables
constant integer ici_confirm_update = 0
constant integer ici_confirm_delete = 1

string		is_title
u_sql_scanner	iu_scan

end variables

forward prototypes
public function string uf_get_colval (string as_nomecol)
public function decimal uf_getitemdecimal (long al_row, string as_column)
public function decimal uf_getitemdecimal (long al_row, string as_column, dwbuffer ad_tipo, boolean ab_original)
public subroutine uf_set_colval (string as_nomecol, string as_valcol)
public function integer uf_setitem (long al_row, string as_column_name, any aa_value, boolean ab_regenerate)
public function long uf_to_update ()
public function boolean uf_changes ()
public function boolean uf_get_confirm (integer ai_operation)
end prototypes

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

public function long uf_to_update ();
long ll_to_update
ll_to_update = this.ModifiedCount() + this.DeletedCount()
return ll_to_update

end function

public function boolean uf_changes ();
this.AcceptText()
if this.ModifiedCount() + this.DeletedCount() > 0 then
	return true
else
	return false
end if
end function

public function boolean uf_get_confirm (integer ai_operation);

string ls_msg
integer li_but

choose case ai_operation
	case ici_confirm_update
		ls_msg = "Confermi il salvataggio dei dati?"
		li_but = 1
	case ici_confirm_delete
		ls_msg = "Confermi l'eliminazione del record?"
		li_but = 2
end choose

if MessageBox(this.is_Title, ls_msg, Question!, YesNo!, li_but) = 1 then
	return True
else
	return False
end if
end function

on u_ds_main.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_main.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event constructor;
string ls_sql
iu_scan = create u_sql_scanner
this.SetTransObject(SQLCA)



end event

event destructor;
if isvalid(iu_scan) then destroy iu_scan
end event

event dberror;s_dberr		lstr_dberr
window		lw_err

lstr_dberr.l_sqlcode = sqldbcode
lstr_dberr.s_sqlerrtext = sqlerrtext

OpenWithParm(lw_err,lstr_dberr,"w_db_err")

return 1
end event

