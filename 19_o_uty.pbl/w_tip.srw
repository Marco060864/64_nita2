forward
global type w_tip from w_001
end type
type rte_tip from richtextedit within w_tip
end type
type cb_chiudi from commandbutton within w_tip
end type
end forward

global type w_tip from w_001
integer width = 1317
integer height = 1444
rte_tip rte_tip
cb_chiudi cb_chiudi
end type
global w_tip w_tip

event open;call super::open;string ls_tip, ls_nome_oggetto
integer li_pos

ls_tip=message.stringparm

if ls_tip> " " then
	li_pos=pos(ls_tip, "|")
	if li_pos> 0 then
		ls_nome_oggetto=left(ls_tip, li_pos -1)
		ls_tip=right(ls_tip, len(ls_tip) - li_pos)
		this.title="Tip riferito a: "+ls_nome_oggetto
		rte_tip.ReplaceText(ls_tip)
	end if
else
	close(this)
end if
end event

on w_tip.create
int iCurrent
call super::create
this.rte_tip=create rte_tip
this.cb_chiudi=create cb_chiudi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rte_tip
this.Control[iCurrent+2]=this.cb_chiudi
end on

on w_tip.destroy
call super::destroy
destroy(this.rte_tip)
destroy(this.cb_chiudi)
end on

type st_1 from w_001`st_1 within w_tip
end type

type rte_tip from richtextedit within w_tip
integer x = 50
integer y = 128
integer width = 1189
integer height = 908
integer taborder = 10
boolean bringtotop = true
boolean init_wordwrap = true
boolean init_rulerbar = true
boolean init_toolbar = true
boolean init_popmenu = true
borderstyle borderstyle = stylelowered!
end type

type cb_chiudi from commandbutton within w_tip
integer x = 827
integer y = 1128
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

