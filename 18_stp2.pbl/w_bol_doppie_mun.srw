forward
global type w_bol_doppie_mun from w_pop
end type
type cb_stampa from commandbutton within w_bol_doppie_mun
end type
end forward

global type w_bol_doppie_mun from w_pop
integer width = 933
integer height = 612
cb_stampa cb_stampa
end type
global w_bol_doppie_mun w_bol_doppie_mun

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(1)

dw_1.setitem(1, "a_data", today())
dw_1.setitem(1, "da_data", relativedate(today(), -60))
end event

on w_bol_doppie_mun.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
end on

on w_bol_doppie_mun.destroy
call super::destroy
destroy(this.cb_stampa)
end on

type dw_1 from w_pop`dw_1 within w_bol_doppie_mun
integer width = 741
integer height = 216
string dataobject = "d_da_data_a_data"
end type

type cb_stampa from commandbutton within w_bol_doppie_mun
integer x = 411
integer y = 328
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
string text = "Stampa"
end type

event clicked;openwithparm(w_bol_doppie_mun_st, 1)
end event

