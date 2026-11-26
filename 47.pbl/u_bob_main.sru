forward
global type u_bob_main from nonvisualobject
end type
end forward

global type u_bob_main from nonvisualobject
event ue_default pbm_custom01
event ue_validate_column pbm_custom02
event ue_validate_row pbm_custom03
event ue_pre_update pbm_custom04
event ue_post_update pbm_custom05
event ue_pre_delete pbm_custom06
event ue_post_delete pbm_custom07
end type
global u_bob_main u_bob_main

type variables
long il_row
u_dw_main iudw_main
end variables

forward prototypes
public subroutine uf_init ()
end prototypes

public subroutine uf_init ();
end subroutine

on u_bob_main.create
TriggerEvent( this, "constructor" )
end on

on u_bob_main.destroy
TriggerEvent( this, "destructor" )
end on

