forward
global type w_help_orafo from w_data_main
end type
type rte_1 from richtextedit within w_help_orafo
end type
type cb_salvadoc from commandbutton within w_help_orafo
end type
end forward

global type w_help_orafo from w_data_main
integer width = 3378
integer height = 1736
rte_1 rte_1
cb_salvadoc cb_salvadoc
end type
global w_help_orafo w_help_orafo

on w_help_orafo.create
int iCurrent
call super::create
this.rte_1=create rte_1
this.cb_salvadoc=create cb_salvadoc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rte_1
this.Control[iCurrent+2]=this.cb_salvadoc
end on

on w_help_orafo.destroy
call super::destroy
destroy(this.rte_1)
destroy(this.cb_salvadoc)
end on

event open;call super::open;
string ls_doc
ls_doc=message.stringparm
title=ls_doc

rte_1.InsertDocument(ls_doc+".rtf", TRUE)
rte_1.WordWrap = TRUE
end event

type p_msg_log from w_data_main`p_msg_log within w_help_orafo
end type

type p_crescente from w_data_main`p_crescente within w_help_orafo
end type

type p_decrescente from w_data_main`p_decrescente within w_help_orafo
end type

type rte_1 from richtextedit within w_help_orafo
integer x = 37
integer y = 64
integer width = 3237
integer height = 1352
integer taborder = 10
boolean bringtotop = true
boolean init_wordwrap = true
boolean init_rulerbar = true
boolean init_tabbar = true
boolean init_toolbar = true
boolean init_popmenu = true
borderstyle borderstyle = stylelowered!
end type

type cb_salvadoc from commandbutton within w_help_orafo
integer x = 2912
integer y = 1428
integer width = 343
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Doc."
end type

event clicked;rte_1.savedocument(parent.title+".rtf")
end event

