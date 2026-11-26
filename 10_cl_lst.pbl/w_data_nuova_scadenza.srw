forward
global type w_data_nuova_scadenza from w_pop
end type
type cb_ok from commandbutton within w_data_nuova_scadenza
end type
end forward

global type w_data_nuova_scadenza from w_pop
integer width = 846
integer height = 652
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
end type
global w_data_nuova_scadenza w_data_nuova_scadenza

on w_data_nuova_scadenza.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
end on

on w_data_nuova_scadenza.destroy
call super::destroy
destroy(this.cb_ok)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(1)
end event

type dw_1 from w_pop`dw_1 within w_data_nuova_scadenza
integer width = 667
integer height = 232
string dataobject = "d_nuova_data_scadenza"
end type

type cb_ok from commandbutton within w_data_nuova_scadenza
integer x = 215
integer y = 356
integer width = 402
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean default = true
end type

event clicked;string ls_data
date ldt_data
ldt_data=dw_1.getitemdate(1, "nuova_data_scadenza")
if ldt_data> date("1900-01-01") then
	ls_data=string(ldt_data)
	closewithreturn(parent, ls_data)
else
	messagebox("Attenzione!", "Inserire una data!")
end if
end event

