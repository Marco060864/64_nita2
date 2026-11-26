forward
global type uo_pipe1 from pipeline
end type
end forward

global type uo_pipe1 from pipeline
end type
global uo_pipe1 uo_pipe1

type variables
statictext ist_status_read, &
               ist_status_written, &
               ist_status_error
end variables

on uo_pipe1.create
call pipeline::create
TriggerEvent( this, "constructor" )
end on

on uo_pipe1.destroy
call pipeline::destroy
TriggerEvent( this, "destructor" )
end on

event pipemeter;ist_status_read.text = String(rowsread)
ist_status_written.text = String(rowswritten)
ist_status_error.text = string(rowsinerror)
end event

