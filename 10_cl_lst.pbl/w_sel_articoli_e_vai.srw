forward
global type w_sel_articoli_e_vai from w_001
end type
type dw_1 from udw_001 within w_sel_articoli_e_vai
end type
end forward

global type w_sel_articoli_e_vai from w_001
integer width = 3214
dw_1 dw_1
end type
global w_sel_articoli_e_vai w_sel_articoli_e_vai

on w_sel_articoli_e_vai.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_sel_articoli_e_vai.destroy
call super::destroy
destroy(this.dw_1)
end on

type st_1 from w_001`st_1 within w_sel_articoli_e_vai
end type

type dw_1 from udw_001 within w_sel_articoli_e_vai
integer x = 41
integer y = 132
integer width = 3099
integer height = 1228
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_sel_articoli_new"
end type

