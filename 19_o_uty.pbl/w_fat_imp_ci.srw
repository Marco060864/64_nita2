forward
global type w_fat_imp_ci from w_001
end type
type dw_1 from udw_base within w_fat_imp_ci
end type
end forward

global type w_fat_imp_ci from w_001
integer width = 2464
integer height = 2748
dw_1 dw_1
end type
global w_fat_imp_ci w_fat_imp_ci

on w_fat_imp_ci.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_fat_imp_ci.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type st_1 from w_001`st_1 within w_fat_imp_ci
end type

type dw_1 from udw_base within w_fat_imp_ci
integer x = 41
integer y = 36
integer width = 2313
integer height = 2460
boolean bringtotop = true
string dataobject = "d_fat_imp_ci_vedi"
end type

