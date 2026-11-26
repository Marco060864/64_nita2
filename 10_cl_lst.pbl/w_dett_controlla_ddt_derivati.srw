forward
global type w_dett_controlla_ddt_derivati from w_pop
end type
type cbx_solo_errati from checkbox within w_dett_controlla_ddt_derivati
end type
end forward

global type w_dett_controlla_ddt_derivati from w_pop
integer width = 4512
integer height = 2224
cbx_solo_errati cbx_solo_errati
end type
global w_dett_controlla_ddt_derivati w_dett_controlla_ddt_derivati

on w_dett_controlla_ddt_derivati.create
int iCurrent
call super::create
this.cbx_solo_errati=create cbx_solo_errati
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_solo_errati
end on

on w_dett_controlla_ddt_derivati.destroy
call super::destroy
destroy(this.cbx_solo_errati)
end on

event open;call super::open;LONG LL_ID_DOC


dw_1.settransobject(sqlca)
LL_ID_DOC=message.DOUBLEPARM

if LL_ID_DOC>0 then
	dw_1.retrieve(LL_ID_DOC)
end if
end event

type dw_1 from w_pop`dw_1 within w_dett_controlla_ddt_derivati
integer y = 164
integer width = 4283
integer height = 1896
string dataobject = "d_det_controlla_ddt_derivato"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cbx_solo_errati from checkbox within w_dett_controlla_ddt_derivati
integer x = 142
integer y = 48
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Errati"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro="tot_riga_fattura <> tot_riga_ddt"
else
	ls_filtro=""
end if

dw_1.setfilter(ls_filtro)
dw_1.filter()
end event

