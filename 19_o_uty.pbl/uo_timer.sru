forward
global type uo_timer from timing
end type
end forward

global type uo_timer from timing
end type
global uo_timer uo_timer

on uo_timer.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_timer.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

