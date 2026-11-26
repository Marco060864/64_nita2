forward
global type udw_base from datawindow
end type
end forward

global type udw_base from datawindow
int Width=494
int Height=360
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
event type integer ue_update ( )
event type long ue_insert ( integer al_riga_precedente )
event ue_delete ( integer al_riga_da_cancellare )
event ue_key pbm_dwnkey
event ue_keystop pbm_dwnprocessenter
event ue_rbutton_dbclick pbm_rbuttondblclk
end type
global udw_base udw_base

forward prototypes
public function integer uf_validate_data (string as_colname, dwobject adwo_dwo, long al_row, string as_data)
end prototypes

event ue_update;integer li_ret

li_ret=update()
if li_ret=1 then
	commit;
else
	rollback;
	messagebox(  this.classname() +" - Salvataggio non riuscito!",sqlca.sqlerrtext)
end if
	
	
	
return li_ret
end event

event ue_insert;
long ll_riga
ll_riga=this.insertrow(al_riga_precedente)
scrolltorow(ll_riga)

return ll_riga

end event

event ue_delete;
if al_riga_da_cancellare=0 then
	this.rowsmove(1, this.rowcount(), primary!, this, 1, delete!)
else
	this.deleterow(al_riga_da_cancellare)
end if
end event

public function integer uf_validate_data (string as_colname, dwobject adwo_dwo, long al_row, string as_data);

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

event getfocus;this.modify("datawindow.color = 10789024")

end event

event losefocus;this.modify("datawindow.color = 79741120")
end event

