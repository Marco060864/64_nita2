forward
global type u_ds_lotti_da_imp_gd from datastore
end type
end forward

global type u_ds_lotti_da_imp_gd from datastore
string DataObject="ds_lotti_da_imp_gd"
end type
global u_ds_lotti_da_imp_gd u_ds_lotti_da_imp_gd

on u_ds_lotti_da_imp_gd.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on u_ds_lotti_da_imp_gd.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

