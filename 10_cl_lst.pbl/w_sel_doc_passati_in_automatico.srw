forward
global type w_sel_doc_passati_in_automatico from w_seleziona
end type
type cb_2 from commandbutton within w_sel_doc_passati_in_automatico
end type
type cb_1 from commandbutton within w_sel_doc_passati_in_automatico
end type
type dw_1 from udw_000 within w_sel_doc_passati_in_automatico
end type
end forward

global type w_sel_doc_passati_in_automatico from w_seleziona
integer width = 1051
integer height = 620
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_sel_doc_passati_in_automatico w_sel_doc_passati_in_automatico

on w_sel_doc_passati_in_automatico.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_sel_doc_passati_in_automatico.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(1)

dw_1.setitem(1, "data_inizio", today())
dw_1.setitem(1, "data_fine", today())
end event

type cb_2 from commandbutton within w_sel_doc_passati_in_automatico
integer x = 14
integer y = 328
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Annulla"
end type

type cb_1 from commandbutton within w_sel_doc_passati_in_automatico
integer x = 475
integer y = 324
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;s_date_estr_cc s_date

dw_1.accepttext()

s_date.da_data=dw_1.getitemdate(1, "data_inizio")
s_date.a_data=dw_1.getitemdate(1, "data_fine")

openwithparm(w_doc_passati_in_automatico, s_date)
end event

type dw_1 from udw_000 within w_sel_doc_passati_in_automatico
integer x = 160
integer y = 72
integer width = 585
integer height = 192
integer taborder = 10
string dataobject = "d_sel_date_controlla_prezzi"
boolean border = false
borderstyle borderstyle = stylebox!
end type

