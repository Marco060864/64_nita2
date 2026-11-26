forward
global type uo_articolo from datastore
end type
end forward

global type uo_articolo from datastore
string DataObject="ds_att_euro_art_gd"
event type integer ue_retrieve ( long al_da_id_valuta,  long al_a_id_valuta )
end type
global uo_articolo uo_articolo

type variables
long  il_da_id_valuta
end variables

event ue_retrieve;il_da_id_valuta = al_da_id_valuta

integer li_rows

li_rows = this.retrieve(al_da_id_valuta, al_a_id_valuta)

return li_rows
end event

on uo_articolo.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on uo_articolo.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

event dberror;messagebox("articoli/DBERROR", sqlerrtext)
end event

event sqlpreview;
if (il_da_id_valuta > 0) then
	string	ls_sql

	ls_sql = sqlsyntax
	if (il_da_id_valuta > 0 and sqltype = PreviewSelect!) then
		ls_sql = ls_sql + " AND articolo.id_valuta = " + string(il_da_id_valuta)
		this.setsqlpreview(ls_sql)
	end if
end if
end event

