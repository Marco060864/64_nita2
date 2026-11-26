forward
global type w_password_pop from w_pop
end type
type cb_ok from commandbutton within w_password_pop
end type
type cb_annulla from commandbutton within w_password_pop
end type
end forward

global type w_password_pop from w_pop
integer width = 1234
integer height = 708
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_password_pop w_password_pop

on w_password_pop.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
end on

on w_password_pop.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;dw_1.insertrow(1)
end event

type dw_1 from w_pop`dw_1 within w_password_pop
integer height = 304
string dataobject = "d_password_pop"
end type

type cb_ok from commandbutton within w_password_pop
integer x = 663
integer y = 412
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

event clicked;string ls_pass, ls_verifica

dw_1.accepttext()
ls_pass=dw_1.getitemstring(1, "password")
//cambio prima prendevo il codice azienda, troppo lungo, ora solo la lettera iniziale
select left(codice, 1)
into :ls_verifica
from dba.azienda
;
if ls_verifica=ls_pass then
	closewithreturn(parent,  1)
else
	closewithreturn(parent,  0)
end if
end event

type cb_annulla from commandbutton within w_password_pop
integer x = 87
integer y = 412
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

event clicked;closewithreturn(parent, 0)
end event

