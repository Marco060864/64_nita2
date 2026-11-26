forward
global type u_dw_base from datawindow
end type
end forward

global type u_dw_base from datawindow
int Width=494
int Height=360
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event ue_key pbm_dwnkey
end type
global u_dw_base u_dw_base

forward prototypes
public subroutine uf_set_colval (string as_nomecol, string as_valcol, long al_row)
public function string uf_get_colval (string as_nomecol)
end prototypes

public subroutine uf_set_colval (string as_nomecol, string as_valcol, long al_row);
string ls_coltype, ls_value
integer li_nomecol

if as_valcol = "" then SetNull(as_valcol)
if (al_row>0) then
	ls_coltype = Describe(as_nomecol + ".coltype")
	li_nomecol=integer(right(as_nomecol, len(as_nomecol) - 1))
	CHOOSE CASE Mid(ls_coltype,1,5)
		CASE "char("
			SetItem(al_row, li_nomecol, as_valcol)
		CASE "long"
			SetItem(al_row, li_nomecol, Long(as_valcol))
		CASE "date"
			SetItem(al_row, li_nomecol, Date(as_valcol))
		CASE "datet"
			SetItem(al_row, li_nomecol, DateTime(as_valcol))
		CASE "decim"
			SetItem(al_row, li_nomecol, Dec(as_valcol))
		CASE ELSE
	END CHOOSE
end if

end subroutine

public function string uf_get_colval (string as_nomecol);string ls_coltype, ls_value
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
			ls_value = string(GetItemDecimal(ll_row, as_nomecol))	
		CASE ELSE
	END CHOOSE
else
	ls_value = u_freddie.gs_null
end if

return ls_value

end function

event itemerror;string ls_coltype, ls_colname, ls_data, ls_dat2
boolean ll_goon
integer li_ret
long ll_retval
ls_coltype = dwo.coltype
ls_colname = dwo.name
ls_data = data


if ls_coltype = "date" then
	if not IsDate(ls_data) then 
		
		li_ret = f_validate_date(ls_data,ls_dat2)
		if li_ret = 1 then 
			ls_data = ls_dat2
			setitem(row, ls_colname, date(ls_data))
			return 3
		else
			messagebox("Errore!", "Formato data errato!")
			return 0
		end if
	end if
end if
end event

event getfocus;object.datawindow.color=10987431
end event

event losefocus;modify("datawindow.color=12632256")
end event

