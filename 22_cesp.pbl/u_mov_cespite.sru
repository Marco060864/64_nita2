forward
global type u_mov_cespite from nonvisualobject
end type
end forward

global type u_mov_cespite from nonvisualobject
end type
global u_mov_cespite u_mov_cespite

on u_mov_cespite.create
TriggerEvent( this, "constructor" )
end on

on u_mov_cespite.destroy
TriggerEvent( this, "destructor" )
end on

