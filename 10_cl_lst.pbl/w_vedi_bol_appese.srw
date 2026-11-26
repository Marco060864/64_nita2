forward
global type w_vedi_bol_appese from w_pop
end type
type cb_vai from commandbutton within w_vedi_bol_appese
end type
type cb_chiudi from commandbutton within w_vedi_bol_appese
end type
end forward

global type w_vedi_bol_appese from w_pop
integer width = 1504
cb_vai cb_vai
cb_chiudi cb_chiudi
end type
global w_vedi_bol_appese w_vedi_bol_appese

on w_vedi_bol_appese.create
int iCurrent
call super::create
this.cb_vai=create cb_vai
this.cb_chiudi=create cb_chiudi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_vai
this.Control[iCurrent+2]=this.cb_chiudi
end on

on w_vedi_bol_appese.destroy
call super::destroy
destroy(this.cb_vai)
destroy(this.cb_chiudi)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(1)

dw_1.post setitem(1, "da_data", relativedate(today(), -30))
dw_1.post setitem(1, "a_data", today())

end event

type dw_1 from w_pop`dw_1 within w_vedi_bol_appese
integer width = 1253
integer height = 208
string dataobject = "da_data_a_data_ord"
end type

type cb_vai from commandbutton within w_vedi_bol_appese
integer x = 933
integer y = 376
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
string text = "VAI"
end type

event clicked;s_date_estr_cc s_date

s_date.da_data=dw_1.getitemdate(1, "da_data")
s_date.a_data=dw_1.getitemdate(1, "a_data")
//	s_date.da_data=relativedate(s_date.a_data, -30)
openwithparm(w_trova_bol_modificata_non_derivata, s_date)
end event

type cb_chiudi from commandbutton within w_vedi_bol_appese
integer x = 146
integer y = 376
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

