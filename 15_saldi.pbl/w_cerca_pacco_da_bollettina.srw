forward
global type w_cerca_pacco_da_bollettina from w_001
end type
type dw_1 from udw_base within w_cerca_pacco_da_bollettina
end type
type dw_2 from udw_figlia within w_cerca_pacco_da_bollettina
end type
end forward

global type w_cerca_pacco_da_bollettina from w_001
integer width = 4005
integer height = 1750
boolean minbox = true
windowtype windowtype = popup!
dw_1 dw_1
dw_2 dw_2
end type
global w_cerca_pacco_da_bollettina w_cerca_pacco_da_bollettina

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.insertrow(1)
end event

on w_cerca_pacco_da_bollettina.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
end on

on w_cerca_pacco_da_bollettina.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

type st_1 from w_001`st_1 within w_cerca_pacco_da_bollettina
end type

type dw_1 from udw_base within w_cerca_pacco_da_bollettina
integer x = 29
integer y = 26
integer width = 1814
integer height = 154
boolean bringtotop = true
string dataobject = "d_cerca_pacco_ext"
end type

event itemchanged;call super::itemchanged;long ll_num_prog
integer li_anno

if dwo.name="num_prog_bollettina" then
	ll_num_prog=long(data)
	li_anno=getitemnumber(1, "anno")
	dw_2.retrieve(ll_num_prog, li_anno)
	
	
	
end if

end event

type dw_2 from udw_figlia within w_cerca_pacco_da_bollettina
integer x = 29
integer y = 205
integer width = 3920
integer height = 1382
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pacco_bollettina_trova"
end type

