forward
global type w_orafo_bollo_gd from w_np_single_data
end type
type cb_stampa from commandbutton within w_orafo_bollo_gd
end type
type cb_ord_codice from commandbutton within w_orafo_bollo_gd
end type
type cb_1 from commandbutton within w_orafo_bollo_gd
end type
end forward

global type w_orafo_bollo_gd from w_np_single_data
integer height = 1016
cb_stampa cb_stampa
cb_ord_codice cb_ord_codice
cb_1 cb_1
end type
global w_orafo_bollo_gd w_orafo_bollo_gd

on w_orafo_bollo_gd.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
this.cb_ord_codice=create cb_ord_codice
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
this.Control[iCurrent+2]=this.cb_ord_codice
this.Control[iCurrent+3]=this.cb_1
end on

on w_orafo_bollo_gd.destroy
call super::destroy
destroy(this.cb_stampa)
destroy(this.cb_ord_codice)
destroy(this.cb_1)
end on

event resize;dw_single.Width = newwidth - 80
dw_single.Height = newheight - 250
end event

type p_msg_log from w_np_single_data`p_msg_log within w_orafo_bollo_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_orafo_bollo_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_orafo_bollo_gd
end type

type dw_single from w_np_single_data`dw_single within w_orafo_bollo_gd
integer y = 152
string dataobject = "d_orafo_bollo"
end type

type cb_stampa from commandbutton within w_orafo_bollo_gd
integer x = 1577
integer y = 20
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
dw_single.print()
end event

type cb_ord_codice from commandbutton within w_orafo_bollo_gd
integer x = 251
integer y = 24
integer width = 443
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordina per Codice"
end type

event clicked;dw_single.setsort("codice")
dw_single.sort()
end event

type cb_1 from commandbutton within w_orafo_bollo_gd
integer x = 736
integer y = 24
integer width = 553
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordina per Descrizione"
end type

event clicked;dw_single.setsort("Descrizione")
dw_single.sort()
end event

