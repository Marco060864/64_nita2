forward
global type uo_ds_ult_costo from datastore
end type
end forward

global type uo_ds_ult_costo from datastore
string DataObject="ds_ultimo_costo"
end type
global uo_ds_ult_costo uo_ds_ult_costo

on uo_ds_ult_costo.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on uo_ds_ult_costo.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

