forward
global type w_orafo_galvanica_gd from w_np_single_data
end type
type cb_salva_righe from commandbutton within w_orafo_galvanica_gd
end type
type dw_1 from udw_base within w_orafo_galvanica_gd
end type
end forward

global type w_orafo_galvanica_gd from w_np_single_data
integer width = 3634
integer height = 2212
boolean resizable = false
cb_salva_righe cb_salva_righe
dw_1 dw_1
end type
global w_orafo_galvanica_gd w_orafo_galvanica_gd

on w_orafo_galvanica_gd.create
int iCurrent
call super::create
this.cb_salva_righe=create cb_salva_righe
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salva_righe
this.Control[iCurrent+2]=this.dw_1
end on

on w_orafo_galvanica_gd.destroy
call super::destroy
destroy(this.cb_salva_righe)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
if dw_1.retrieve()<= 0 then
	dw_1.insertrow(1)
end if
end event

event resize;dw_single.Width = newwidth - 80
dw_single.Height = newheight - 100 - 550
end event

type p_msg_log from w_np_single_data`p_msg_log within w_orafo_galvanica_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_orafo_galvanica_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_orafo_galvanica_gd
end type

type dw_single from w_np_single_data`dw_single within w_orafo_galvanica_gd
integer x = 41
integer y = 700
integer width = 3461
integer height = 1388
string dataobject = "d_orafo_galvanica_gd"
end type

type cb_salva_righe from commandbutton within w_orafo_galvanica_gd
integer x = 2651
integer y = 584
integer width = 361
integer height = 112
integer taborder = 11
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salva Righe"
end type

event clicked;dw_single.triggerevent("ue_update")
end event

type dw_1 from udw_base within w_orafo_galvanica_gd
integer x = 41
integer y = 32
integer width = 3049
integer height = 544
string dataobject = "d_nota_galvanica"
end type

event clicked;call super::clicked;if dwo.name="b_cod_barre" then
	open(w_st_cod_barre_galvanica)
end if
end event

