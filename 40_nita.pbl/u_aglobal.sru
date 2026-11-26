forward
global type u_aglobal from nonvisualobject
end type
end forward

global type u_aglobal from nonvisualobject
end type
global u_aglobal u_aglobal

on u_aglobal.create
TriggerEvent( this, "constructor" )
end on

on u_aglobal.destroy
TriggerEvent( this, "destructor" )
end on

