forward
global type w_stampa_sintetica_ff from window
end type
type cb_7 from commandbutton within w_stampa_sintetica_ff
end type
type cb_6 from commandbutton within w_stampa_sintetica_ff
end type
type cb_5 from commandbutton within w_stampa_sintetica_ff
end type
type cb_4 from commandbutton within w_stampa_sintetica_ff
end type
type dw_1 from datawindow within w_stampa_sintetica_ff
end type
type cb_3 from commandbutton within w_stampa_sintetica_ff
end type
type cb_1 from commandbutton within w_stampa_sintetica_ff
end type
end forward

global type w_stampa_sintetica_ff from window
integer x = 5
integer y = 364
integer width = 3657
integer height = 1684
boolean titlebar = true
string title = "Stampa Bilancio"
boolean controlmenu = true
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 79741120
event ue_post_open ( )
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stampa_sintetica_ff w_stampa_sintetica_ff

type variables
long il_zoom
string is_stato
end variables

event ue_post_open;close(w_attesa)
this.windowstate=Maximized! 
dw_1.Object.DataWindow.Print.Preview='yes'
dw_1.Height=(this.Height) - 272


end event

event open;string ls_codici,ls_da,ls_a
date ld_data_fine
s_sintetica passaggio
passaggio=message.powerobjectparm
ls_da=passaggio.da_cod
if isnull(ls_da) then ls_da=""
ls_a=passaggio.a_cod
if ls_a="" or isnull(ls_a) then ls_a='ZZZZZZZZZZ'
if passaggio.stato='U' then is_stato='U'
	
dw_1.settransobject(sqlca)
dw_1.retrieve(ls_da,ls_a)
il_zoom=100
this.event post ue_post_open()
end event

on w_stampa_sintetica_ff.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stampa_sintetica_ff.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type cb_7 from commandbutton within w_stampa_sintetica_ff
event clicked pbm_bnclicked
integer x = 2505
integer y = 40
integer width = 261
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom Out"
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_stampa_sintetica_ff
event clicked pbm_bnclicked
integer x = 2231
integer y = 40
integer width = 261
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom In"
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_sintetica_ff
integer x = 681
integer y = 40
integer width = 466
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Precedente"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_sintetica_ff
integer x = 1161
integer y = 40
integer width = 466
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Successiva"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_stampa_sintetica_ff
integer x = 27
integer y = 176
integer width = 3589
integer height = 1348
integer taborder = 60
string dataobject = "d_stampa_sintetica_ff"
boolean vscrollbar = true
boolean livescroll = true
end type

event sqlpreview;if is_stato='U' then
	sqlsyntax+= " and cespite.stato='U' "
	setsqlpreview(sqlsyntax)
end if
end event

type cb_3 from commandbutton within w_stampa_sintetica_ff
integer x = 3387
integer y = 40
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_stampa_sintetica_ff
integer x = 23
integer y = 40
integer width = 247
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

