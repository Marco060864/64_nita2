forward
global type w_sel_studi_settore from w_selezione_stampa
end type
type cb_stampa_2 from commandbutton within w_sel_studi_settore
end type
type cb_3 from commandbutton within w_sel_studi_settore
end type
type cb_2 from commandbutton within w_sel_studi_settore
end type
type cb_4 from commandbutton within w_sel_studi_settore
end type
type cb_5 from commandbutton within w_sel_studi_settore
end type
type cb_6 from commandbutton within w_sel_studi_settore
end type
type cb_7 from commandbutton within w_sel_studi_settore
end type
type cb_8 from commandbutton within w_sel_studi_settore
end type
type cb_9 from commandbutton within w_sel_studi_settore
end type
type cb_10 from commandbutton within w_sel_studi_settore
end type
type cb_11 from commandbutton within w_sel_studi_settore
end type
type cb_12 from commandbutton within w_sel_studi_settore
end type
end forward

global type w_sel_studi_settore from w_selezione_stampa
integer width = 1079
integer height = 1552
cb_stampa_2 cb_stampa_2
cb_3 cb_3
cb_2 cb_2
cb_4 cb_4
cb_5 cb_5
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
cb_9 cb_9
cb_10 cb_10
cb_11 cb_11
cb_12 cb_12
end type
global w_sel_studi_settore w_sel_studi_settore

event open;call super::open;date ldt_da_data, ldt_a_data
integer li_anno

li_anno=year(today())
li_anno --
ldt_da_data=date(li_anno, 1, 1)
ldt_a_data=date(li_anno, 12, 31)

dw_1.setitem(1, "da_data", ldt_da_data)
dw_1.setitem(1, "a_data", ldt_a_data)

end event

on w_sel_studi_settore.create
int iCurrent
call super::create
this.cb_stampa_2=create cb_stampa_2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_11=create cb_11
this.cb_12=create cb_12
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa_2
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.cb_6
this.Control[iCurrent+7]=this.cb_7
this.Control[iCurrent+8]=this.cb_8
this.Control[iCurrent+9]=this.cb_9
this.Control[iCurrent+10]=this.cb_10
this.Control[iCurrent+11]=this.cb_11
this.Control[iCurrent+12]=this.cb_12
end on

on w_sel_studi_settore.destroy
call super::destroy
destroy(this.cb_stampa_2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_11)
destroy(this.cb_12)
end on

type cb_1 from w_selezione_stampa`cb_1 within w_sel_studi_settore
integer x = 55
integer y = 292
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_sel_studi_settore
integer x = 549
integer y = 292
string text = "X CLIENTE"
end type

event cb_stampa::clicked;call super::clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore
st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=1


openwithparm(w_st_settore, st_dati)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_sel_studi_settore
integer width = 873
integer height = 216
string dataobject = "d_da_data_a_data_bol2"
end type

type cb_stampa_2 from commandbutton within w_sel_studi_settore
integer x = 549
integer y = 440
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "X Metallo"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=2


openwithparm(w_st_settore, st_dati)
end event

type cb_3 from commandbutton within w_sel_studi_settore
integer x = 55
integer y = 440
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C06"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=3



openwithparm(w_st_settore, st_dati)
end event

type cb_2 from commandbutton within w_sel_studi_settore
integer x = 549
integer y = 588
integer width = 402
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C08"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=4


openwithparm(w_st_settore, st_dati)
end event

type cb_4 from commandbutton within w_sel_studi_settore
integer x = 55
integer y = 588
integer width = 402
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C24"
end type

event clicked;s_date_e_sog st_dati

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=5

w_st_studi_settore w_st_settore

openwithparm(w_st_settore, st_dati)
end event

type cb_5 from commandbutton within w_sel_studi_settore
integer x = 549
integer y = 736
integer width = 402
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D36"
end type

event clicked;s_date_e_sog st_dati

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=6

w_st_studi_settore w_st_settore

openwithparm(w_st_settore, st_dati)
end event

type cb_6 from commandbutton within w_sel_studi_settore
integer x = 549
integer y = 884
integer width = 402
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D37"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=7


openwithparm(w_st_settore, st_dati)
end event

type cb_7 from commandbutton within w_sel_studi_settore
integer x = 55
integer y = 736
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D19_22"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=8


openwithparm(w_st_settore, st_dati)
end event

type cb_8 from commandbutton within w_sel_studi_settore
integer x = 549
integer y = 1032
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "D38_43"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=9


openwithparm(w_st_settore, st_dati)
end event

type cb_9 from commandbutton within w_sel_studi_settore
integer x = 55
integer y = 884
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACLC"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=10


openwithparm(w_st_settore, st_dati)
end event

type cb_10 from commandbutton within w_sel_studi_settore
integer x = 55
integer y = 1032
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "VUOTO"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=11


openwithparm(w_st_settore, st_dati)
end event

type cb_11 from commandbutton within w_sel_studi_settore
integer x = 55
integer y = 1180
integer width = 402
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "GR/TITOLO"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=12


openwithparm(w_st_settore, st_dati)
end event

type cb_12 from commandbutton within w_sel_studi_settore
integer x = 549
integer y = 1180
integer width = 402
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SEM"
end type

event clicked;s_date_e_sog st_dati
w_st_studi_settore w_st_settore

st_dati.da_data=dw_1.getitemdate(1, "da_data")
st_dati.a_data=dw_1.getitemdate(1, "a_data")
st_dati.id_sog_com=13


openwithparm(w_st_settore, st_dati)
end event

