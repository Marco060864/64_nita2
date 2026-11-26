forward
global type w_traduzioni_cx from w_np_single_data
end type
type cb_carica from commandbutton within w_traduzioni_cx
end type
type cb_1 from commandbutton within w_traduzioni_cx
end type
type cb_2 from commandbutton within w_traduzioni_cx
end type
end forward

global type w_traduzioni_cx from w_np_single_data
integer x = 631
integer y = 508
integer width = 3803
integer height = 1340
string title = "Traduzioni"
cb_carica cb_carica
cb_1 cb_1
cb_2 cb_2
end type
global w_traduzioni_cx w_traduzioni_cx

on w_traduzioni_cx.create
int iCurrent
call super::create
this.cb_carica=create cb_carica
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_carica
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_traduzioni_cx.destroy
call super::destroy
destroy(this.cb_carica)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event resize;dw_single.Width = newwidth - 80
dw_single.Height = newheight - 300
end event

type p_msg_log from w_np_single_data`p_msg_log within w_traduzioni_cx
end type

type p_crescente from w_np_single_data`p_crescente within w_traduzioni_cx
end type

type p_decrescente from w_np_single_data`p_decrescente within w_traduzioni_cx
end type

type dw_single from w_np_single_data`dw_single within w_traduzioni_cx
integer y = 168
integer width = 3616
integer height = 996
string dataobject = "d_traduci_gd"
borderstyle borderstyle = stylelowered!
end type

type cb_carica from commandbutton within w_traduzioni_cx
integer x = 146
integer y = 40
integer width = 462
integer height = 100
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica descrizioni"
end type

event clicked;long ll_righe, i, ll_righe_esistenti, ll_riga_inserita, ll_test
string ls_des
datastore ds_des
ds_des=create datastore
ds_des.dataobject="ds_carica_descrizioni"
ds_des.settransobject(sqlca)
ll_righe=ds_des.retrieve()
ll_righe_esistenti=dw_single.rowcount()
for i=1 to ll_righe
	ls_des=ds_des.getitemstring(i, "descrizione")
	if ls_des>" " then
		if pos(ls_des, "'")>0 then continue
		if pos(ls_des, '"')>0 then continue
		ll_test=dw_single.find("italiano='"+ls_des+"'", 1, ll_righe_esistenti)
		if ll_test<=0 then
			ll_righe_esistenti++
			ll_riga_inserita=dw_single.insertrow(0)
			dw_single.setitem(ll_riga_inserita, "italiano", ls_des)
		end if
	end if
next
end event

type cb_1 from commandbutton within w_traduzioni_cx
integer x = 2665
integer y = 40
integer width = 462
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_single.triggerevent("ue_update")
end event

type cb_2 from commandbutton within w_traduzioni_cx
integer x = 3195
integer y = 40
integer width = 462
integer height = 100
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esci"
end type

event clicked;close(parent)
end event

