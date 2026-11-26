forward
global type w_stessa_riga_provenienza from w_pop
end type
type cb_stampa from commandbutton within w_stessa_riga_provenienza
end type
end forward

global type w_stessa_riga_provenienza from w_pop
integer width = 2373
integer height = 976
boolean resizable = false
windowtype windowtype = response!
cb_stampa cb_stampa
end type
global w_stessa_riga_provenienza w_stessa_riga_provenienza

on w_stessa_riga_provenienza.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
end on

on w_stessa_riga_provenienza.destroy
call super::destroy
destroy(this.cb_stampa)
end on

event open;call super::open;long ll_id_doc
integer li_righe

ll_id_doc=message.doubleparm

if ll_id_doc>0 then
	li_righe=dw_1.retrieve(ll_id_doc)
	if li_righe <=0 then
		closewithreturn(this, 0)
	end if
end if
end event

event close;call super::close;integer li_righe

li_righe=dw_1.rowcount()

closewithreturn(this, li_righe)
end event

type dw_1 from w_pop`dw_1 within w_stessa_riga_provenienza
integer x = 37
integer y = 40
integer width = 2272
integer height = 656
string dataobject = "d_stessa_riga_provenienza"
end type

type cb_stampa from commandbutton within w_stessa_riga_provenienza
integer x = 1797
integer y = 748
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

event clicked;
dw_1.print(true, true)
end event

