forward
global type w_stampa_estratto_ff from window
end type
type cb_7 from commandbutton within w_stampa_estratto_ff
end type
type cb_6 from commandbutton within w_stampa_estratto_ff
end type
type cb_1 from commandbutton within w_stampa_estratto_ff
end type
type cb_5 from commandbutton within w_stampa_estratto_ff
end type
type cb_4 from commandbutton within w_stampa_estratto_ff
end type
type cb_3 from commandbutton within w_stampa_estratto_ff
end type
type cb_2 from commandbutton within w_stampa_estratto_ff
end type
type dw_1 from datawindow within w_stampa_estratto_ff
end type
end forward

global type w_stampa_estratto_ff from window
integer x = 9
integer y = 48
integer width = 3762
integer height = 2400
boolean titlebar = true
string title = "Estratto Conto"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 79741120
cb_7 cb_7
cb_6 cb_6
cb_1 cb_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
end type
global w_stampa_estratto_ff w_stampa_estratto_ff

type variables
long il_zoom
end variables

on w_stampa_estratto_ff.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_1=create cb_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.dw_1}
end on

on w_stampa_estratto_ff.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
long ll_apertura, ll_chiusura, ll_decimali, ll_val
string ls_valuta
decimal ld_cambio


s_passa_date str_parametri  

str_parametri=message.powerobjectparm
data_saldo_iniziale=str_parametri.data_saldo_iniziale
data_saldo_attuale=str_parametri.data_saldo_fine
da_data_estratto=str_parametri.data_inizio_estratto
a_data_estratto=str_parametri.data_fine_estratto
ll_apertura=str_parametri.prof_apertura
ll_chiusura=str_parametri.prof_chiusura
ls_valuta=str_parametri.valuta
ld_cambio=str_parametri.cambio
ll_decimali=str_parametri.decimali
ll_val=str_parametri.id_valuta



dw_1.settransobject(sqlca)
dw_1.retrieve(str_parametri.da_conto, str_parametri.a_conto,data_saldo_iniziale,data_saldo_attuale,da_data_estratto,a_data_estratto, ll_apertura, ll_chiusura, ls_valuta, ll_decimali, str_parametri.id_valuta,str_parametri.data_stampa) 
LONG ll_row, ll_breakrow, ll_saldo_iniziale, ll_saldo_estratto
INTEGER I

il_zoom=100




end event

event resize;dw_1.width=newwidth - 70
dw_1.height=newheight - 200
end event

type cb_7 from commandbutton within w_stampa_estratto_ff
boolean visible = false
integer x = 2921
integer y = 40
integer width = 315
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva su file"
end type

event clicked;dw_1.SaveAs()
end event

type cb_6 from commandbutton within w_stampa_estratto_ff
integer x = 2313
integer y = 40
integer width = 297
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom Out"
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom


end event

type cb_1 from commandbutton within w_stampa_estratto_ff
integer x = 1975
integer y = 40
integer width = 297
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom In"
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_estratto_ff
integer x = 41
integer y = 40
integer width = 247
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type cb_4 from commandbutton within w_stampa_estratto_ff
integer x = 1161
integer y = 40
integer width = 466
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Successiva"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_3 from commandbutton within w_stampa_estratto_ff
integer x = 672
integer y = 40
integer width = 466
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Precedente"
end type

event clicked;dw_1.ScrollPriorPage ( ) 

end event

type cb_2 from commandbutton within w_stampa_estratto_ff
integer x = 3323
integer y = 40
integer width = 247
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

type dw_1 from datawindow within w_stampa_estratto_ff
integer x = 41
integer y = 156
integer width = 3648
integer height = 2104
integer taborder = 10
string dataobject = "d_stampa"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

