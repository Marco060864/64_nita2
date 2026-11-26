forward
global type w_orafo_par_sistema_cx from w_001
end type
type dw_1 from udw_base within w_orafo_par_sistema_cx
end type
type cb_salva from commandbutton within w_orafo_par_sistema_cx
end type
type cb_ok from commandbutton within w_orafo_par_sistema_cx
end type
type cb_annulla from commandbutton within w_orafo_par_sistema_cx
end type
end forward

global type w_orafo_par_sistema_cx from w_001
integer width = 2834
integer height = 1796
string title = "Parametri di Sistema "
dw_1 dw_1
cb_salva cb_salva
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_orafo_par_sistema_cx w_orafo_par_sistema_cx

on w_orafo_par_sistema_cx.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_salva=create cb_salva
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_salva
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_annulla
end on

on w_orafo_par_sistema_cx.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_salva)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;

dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type st_1 from w_001`st_1 within w_orafo_par_sistema_cx
end type

type dw_1 from udw_base within w_orafo_par_sistema_cx
integer x = 41
integer y = 160
integer width = 2725
integer height = 1452
boolean bringtotop = true
string dataobject = "d_orafo_par_sistema_cx"
boolean vscrollbar = false
end type

type cb_salva from commandbutton within w_orafo_par_sistema_cx
integer x = 2213
integer y = 16
integer width = 247
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer li_ret
li_ret=dw_1.update()
if li_ret<>1 then
	messagebox("Errore!", "Salvataggio non corretto!")
end if
end event

type cb_ok from commandbutton within w_orafo_par_sistema_cx
integer x = 2491
integer y = 16
integer width = 247
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;cb_salva.triggerevent(clicked!)
close(parent)
end event

type cb_annulla from commandbutton within w_orafo_par_sistema_cx
integer x = 1934
integer y = 16
integer width = 247
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

