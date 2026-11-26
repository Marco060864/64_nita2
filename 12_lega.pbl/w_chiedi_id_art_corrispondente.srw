forward
global type w_chiedi_id_art_corrispondente from w_pop
end type
type cb_ok from commandbutton within w_chiedi_id_art_corrispondente
end type
type dw_2 from udw_000 within w_chiedi_id_art_corrispondente
end type
end forward

global type w_chiedi_id_art_corrispondente from w_pop
integer width = 3273
integer height = 1260
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
dw_2 dw_2
end type
global w_chiedi_id_art_corrispondente w_chiedi_id_art_corrispondente

on w_chiedi_id_art_corrispondente.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.dw_2
end on

on w_chiedi_id_art_corrispondente.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.dw_2)
end on

event open;call super::open;string ls_cod_articolo


dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_1.insertrow(1)

ls_cod_articolo=message.stringparm
dw_1.setitem(1, "cod_articolo", ls_cod_articolo)

dw_2.retrieve(ls_cod_articolo+"%")
end event

type dw_1 from w_pop`dw_1 within w_chiedi_id_art_corrispondente
integer width = 933
integer height = 480
string dataobject = "d_chiedi_id_articolo"
end type

event dw_1::itemchanged;call super::itemchanged;if dwo.name="cod_articolo" then
	dw_2.retrieve(data+"%")
	
end if
end event

type cb_ok from commandbutton within w_chiedi_id_art_corrispondente
integer x = 617
integer y = 572
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
end type

event clicked;long ll_id_art

dw_1.accepttext()
ll_id_art=dw_1.getitemnumber(1, "id_articolo_corrispondente")

closewithreturn(parent, ll_id_art)
end event

type dw_2 from udw_000 within w_chiedi_id_art_corrispondente
integer x = 1047
integer y = 60
integer width = 2149
integer height = 1072
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_lista_art_per_inizio"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_riga, ll_id_art

ll_riga=currentrow
if ll_riga>0 then
	ll_id_art=dw_2.getitemnumber(ll_riga, "id_articolo")
	dw_1.setitem(1, "id_articolo_corrispondente", ll_id_art)
end if
end event

