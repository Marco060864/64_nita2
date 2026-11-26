forward
global type w_input_nomefile from w_data_main
end type
type sle_1 from singlelineedit within w_input_nomefile
end type
type st_1 from statictext within w_input_nomefile
end type
type cb_1 from commandbutton within w_input_nomefile
end type
end forward

global type w_input_nomefile from w_data_main
integer width = 2158
integer height = 548
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
sle_1 sle_1
st_1 st_1
cb_1 cb_1
end type
global w_input_nomefile w_input_nomefile

on w_input_nomefile.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
end on

on w_input_nomefile.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_1)
end on

type p_msg_log from w_data_main`p_msg_log within w_input_nomefile
end type

type p_crescente from w_data_main`p_crescente within w_input_nomefile
end type

type p_decrescente from w_data_main`p_decrescente within w_input_nomefile
end type

type sle_1 from singlelineedit within w_input_nomefile
integer x = 78
integer y = 212
integer width = 1957
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_input_nomefile
integer x = 78
integer y = 44
integer width = 1970
integer height = 156
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inserisci la ragione sociale dell~'intestatario senza usare i seguenti caratteri: | \ / ~" ~' * < > : ?"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_input_nomefile
integer x = 768
integer y = 364
integer width = 517
integer height = 132
integer taborder = 20
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
boolean default = true
end type

event clicked;if sle_1.text> " " then
	closewithreturn(parent, sle_1.text)
else
	messagebox("Attenzione!", "Inserire la ragione sociale!") 
end if
end event

