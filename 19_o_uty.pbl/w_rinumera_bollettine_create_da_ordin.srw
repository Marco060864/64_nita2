forward
global type w_rinumera_bollettine_create_da_ordin from w_001
end type
type dw_1 from udw_base within w_rinumera_bollettine_create_da_ordin
end type
end forward

global type w_rinumera_bollettine_create_da_ordin from w_001
dw_1 dw_1
end type
global w_rinumera_bollettine_create_da_ordin w_rinumera_bollettine_create_da_ordin

on w_rinumera_bollettine_create_da_ordin.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_rinumera_bollettine_create_da_ordin.destroy
call super::destroy
destroy(this.dw_1)
end on

type st_1 from w_001`st_1 within w_rinumera_bollettine_create_da_ordin
end type

type dw_1 from udw_base within w_rinumera_bollettine_create_da_ordin
integer x = 55
integer y = 132
integer width = 2999
integer height = 536
boolean bringtotop = true
string dataobject = "d_doc"
end type

