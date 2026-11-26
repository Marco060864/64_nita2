forward
global type w_mostra_imm_ocx from w_data_main
end type
type ole_imm from olecustomcontrol within w_mostra_imm_ocx
end type
type cb_1 from commandbutton within w_mostra_imm_ocx
end type
type cb_ingrandisci_immagine from commandbutton within w_mostra_imm_ocx
end type
type cb_2 from commandbutton within w_mostra_imm_ocx
end type
type cb_3 from commandbutton within w_mostra_imm_ocx
end type
end forward

global type w_mostra_imm_ocx from w_data_main
integer width = 1545
integer height = 1552
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
ole_imm ole_imm
cb_1 cb_1
cb_ingrandisci_immagine cb_ingrandisci_immagine
cb_2 cb_2
cb_3 cb_3
end type
global w_mostra_imm_ocx w_mostra_imm_ocx

forward prototypes
public subroutine wf_mostra (string as_imm)
end prototypes

public subroutine wf_mostra (string as_imm);string ls_path, ls_imm
select dir_immagini
into :ls_path
from par_sistema;

if as_imm>"" then
	if pos(as_imm, "\") <=0 then ls_imm=ls_path+"\"+as_imm
	if FileExists(ls_imm) then
		ole_imm.object.aspectratio=1
		ole_imm.object.loadimage=ls_imm
	else
		ole_imm.object.delimage=true
	end if
end if
end subroutine

event open;call super::open;string ls_imm

ls_imm=message.stringparm

wf_mostra(ls_imm)	


end event

on w_mostra_imm_ocx.create
int iCurrent
call super::create
this.ole_imm=create ole_imm
this.cb_1=create cb_1
this.cb_ingrandisci_immagine=create cb_ingrandisci_immagine
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_imm
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_ingrandisci_immagine
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
end on

on w_mostra_imm_ocx.destroy
call super::destroy
destroy(this.ole_imm)
destroy(this.cb_1)
destroy(this.cb_ingrandisci_immagine)
destroy(this.cb_2)
destroy(this.cb_3)
end on

type p_msg_log from w_data_main`p_msg_log within w_mostra_imm_ocx
end type

type p_crescente from w_data_main`p_crescente within w_mostra_imm_ocx
end type

type p_decrescente from w_data_main`p_decrescente within w_mostra_imm_ocx
end type

type ole_imm from olecustomcontrol within w_mostra_imm_ocx
event paintevent ( )
event selectevent ( long lplleft,  long lpltop,  long lplright,  long lplbottom )
event statusevent ( long lppercent )
event click ( )
event dblclick ( )
event keydown ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event keyup ( integer keycode,  integer shift )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event scroll ( long scrolltype )
event errorevent ( integer nerrcount )
event thumbnail ( string filename,  long page )
event tag ( integer tagid,  integer tagtype,  long tagsize,  integer wordval,  long longval,  string strval )
event thumbtitle ( string title,  integer page )
integer x = 23
integer y = 16
integer width = 1472
integer height = 1260
integer taborder = 10
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_mostra_imm_ocx.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_1 from commandbutton within w_mostra_imm_ocx
integer x = 1257
integer y = 1344
integer width = 224
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

type cb_ingrandisci_immagine from commandbutton within w_mostra_imm_ocx
integer x = 416
integer y = 1344
integer width = 544
integer height = 100
integer taborder = 43
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ingrandisci Immagine"
end type

event clicked;ole_imm.object.GUIXpos = 200
ole_imm.object.GUIYpos = 200
ole_imm.object.GUIWidth = 5000
ole_imm.object.GUIHeight = 5000
ole_imm.object.MagnifyWindow = 2
end event

type cb_2 from commandbutton within w_mostra_imm_ocx
integer x = 997
integer y = 1344
integer width = 224
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lente"
end type

event clicked;ole_imm.object.MagnifyWindow = 1
end event

type cb_3 from commandbutton within w_mostra_imm_ocx
integer x = 32
integer y = 1344
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
string text = "Help"
end type

event clicked;openwithparm(w_help_orafo, parent.classname())
end event

