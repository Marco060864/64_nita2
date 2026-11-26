forward
global type uo_att_euro_spese from datastore
end type
end forward

global type uo_att_euro_spese from datastore
string DataObject="d_att_euro_spese"
event type integer ue_retrieve ( long al_da_id_valuta,  long al_a_id_valuta )
end type
global uo_att_euro_spese uo_att_euro_spese

type variables
long	il_da_id_valuta
end variables

event ue_retrieve;il_da_id_valuta = al_da_id_valuta

integer li_rows

li_rows = this.retrieve(al_a_id_valuta)

return li_rows
end event

on uo_att_euro_spese.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on uo_att_euro_spese.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event dberror;messagebox("Spese/DBERROR", sqlerrtext)
end event

event sqlpreview;
if (il_da_id_valuta > 0) then
	string	ls_sql

	ls_sql = sqlsyntax
	if (il_da_id_valuta > 0 and sqltype = PreviewSelect!) then
		ls_sql = ls_sql + " AND spesa.id_valuta = " + string(il_da_id_valuta)
		this.setsqlpreview(ls_sql)
	end if
end if
end event

