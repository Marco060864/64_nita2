forward
global type w_met_quotazione_gd from w_data_main
end type
type dw_1 from u_dw_main within w_met_quotazione_gd
end type
type cb_ok from commandbutton within w_met_quotazione_gd
end type
type cb_annulla from commandbutton within w_met_quotazione_gd
end type
end forward

global type w_met_quotazione_gd from w_data_main
integer width = 1339
integer height = 936
string title = "Quotazione Metalli"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_1 dw_1
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_met_quotazione_gd w_met_quotazione_gd

on w_met_quotazione_gd.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_annulla
end on

on w_met_quotazione_gd.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;integer i
decimal ld_cambio, ld_quotazione
ld_cambio=message.doubleparm

dw_1.retrieve()
for i= 1 to dw_1.rowcount()
	dw_1.setitem(i, "prezioso", 'N')
	ld_quotazione=dw_1.getitemdecimal(i, "quotazione")
//	ld_quotazione=ld_quotazione/ld_cambio
	ld_quotazione=ld_quotazione*ld_cambio
	dw_1.setitem(i, "quotazione", ld_quotazione)
next
end event

type p_msg_log from w_data_main`p_msg_log within w_met_quotazione_gd
end type

type p_crescente from w_data_main`p_crescente within w_met_quotazione_gd
end type

type p_decrescente from w_data_main`p_decrescente within w_met_quotazione_gd
end type

type dw_1 from u_dw_main within w_met_quotazione_gd
integer x = 23
integer y = 140
integer width = 1275
integer height = 692
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_metallo_quotazione"
boolean vscrollbar = true
end type

type cb_ok from commandbutton within w_met_quotazione_gd
integer x = 32
integer y = 16
integer width = 247
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;integer i
s_quotazione s_quot

dw_1.setfilter("prezioso='S'")
dw_1.filter()

for i = 1 to dw_1.rowcount()
	s_quot.metallo[i]=dw_1.getitemnumber(i, "id_metallo")	
	s_quot.quotazione[i]=dw_1.getitemdecimal(i, "quotazione")
next
closewithreturn(parent, s_quot)
end event

type cb_annulla from commandbutton within w_met_quotazione_gd
integer x = 1056
integer y = 16
integer width = 247
integer height = 108
integer taborder = 20
boolean bringtotop = true
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

