forward
global type w_doc_art_sostituito from w_pop
end type
type cb_ok from commandbutton within w_doc_art_sostituito
end type
type cb_stampa from commandbutton within w_doc_art_sostituito
end type
end forward

global type w_doc_art_sostituito from w_pop
integer width = 2953
integer height = 2324
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
cb_stampa cb_stampa
end type
global w_doc_art_sostituito w_doc_art_sostituito

on w_doc_art_sostituito.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_stampa
end on

on w_doc_art_sostituito.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_stampa)
end on

event resize;call super::resize;dw_1.setredraw(false)
dw_1.height=newheight - 250
dw_1.width=newwidth - 75
dw_1.setredraw(true)
end event

event open;call super::open;long ll_id_articolo


ll_id_articolo=message.doubleparm
if ll_id_articolo>0 then
	dw_1.retrieve(ll_id_articolo)
end if
end event

type dw_1 from w_pop`dw_1 within w_doc_art_sostituito
integer x = 37
integer y = 32
integer width = 2821
integer height = 1968
string dataobject = "d_righe_art_sostituito"
boolean maxbox = false
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::doubleclicked;//
end event

type cb_ok from commandbutton within w_doc_art_sostituito
integer x = 2455
integer y = 2068
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
string text = "OK (chiude)"
end type

event clicked;close(parent)
end event

type cb_stampa from commandbutton within w_doc_art_sostituito
integer x = 41
integer y = 2068
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
string text = "Stampa"
end type

event clicked;dw_1.print(true, true)
end event

