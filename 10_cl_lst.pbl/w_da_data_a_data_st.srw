forward
global type w_da_data_a_data_st from w_selezione_stampa
end type
type cb_2 from commandbutton within w_da_data_a_data_st
end type
type cb_3 from commandbutton within w_da_data_a_data_st
end type
type cb_4 from commandbutton within w_da_data_a_data_st
end type
type dw_2 from udw_000 within w_da_data_a_data_st
end type
type cb_5 from commandbutton within w_da_data_a_data_st
end type
type cbx_flag from checkbox within w_da_data_a_data_st
end type
type cb_6 from commandbutton within w_da_data_a_data_st
end type
end forward

global type w_da_data_a_data_st from w_selezione_stampa
integer width = 2715
integer height = 948
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
dw_2 dw_2
cb_5 cb_5
cbx_flag cbx_flag
cb_6 cb_6
end type
global w_da_data_a_data_st w_da_data_a_data_st

on w_da_data_a_data_st.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.dw_2=create dw_2
this.cb_5=create cb_5
this.cbx_flag=create cbx_flag
this.cb_6=create cb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_4
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.cbx_flag
this.Control[iCurrent+7]=this.cb_6
end on

on w_da_data_a_data_st.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.dw_2)
destroy(this.cb_5)
destroy(this.cbx_flag)
destroy(this.cb_6)
end on

event open;call super::open;datawindowchild dwc_galv, ldwc_prof, dwc_reg

dw_1.post setitem(1, "da_data", relativedate(today(), -60))
dw_1.post setitem(1, "a_data", today())

dw_1.getchild("filtro", dwc_galv)
dw_1.getchild("registro", dwc_reg)
dwc_galv.SetTransObject(SQLCA)
dwc_reg.SetTransObject(SQLCA)
dwc_galv.Retrieve()
dwc_reg.retrieve()
dw_2.SetTransObject(SQLCA)
dw_2.insertrow(1)
dw_2.getchild("id_prof_documento", ldwc_prof)
ldwc_prof.SetTransObject(SQLCA)
ldwc_prof.retrieve()
dw_2.setitem(1, "id_prof_documento",  170)  //(189 rgalvint - 170=galvint)
end event

type cb_1 from w_selezione_stampa`cb_1 within w_da_data_a_data_st
integer x = 50
integer y = 536
integer width = 306
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_da_data_a_data_st
integer x = 370
integer y = 536
integer width = 256
string text = "St. OLD"
end type

event cb_stampa::clicked;call super::clicked;s_date_e_sog s_date

dw_1.accepttext()
s_date.da_data=dw_1.getitemdate(1, "da_data")
s_date.a_data=dw_1.getitemdate(1, "a_data")
openwithparm(w_galv_entr_uscita_rpt, s_date)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_da_data_a_data_st
integer width = 1486
integer height = 372
string dataobject = "da_data_a_data_st"
end type

type cb_2 from commandbutton within w_da_data_a_data_st
integer x = 960
integer y = 536
integer width = 256
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "St. NEW"
end type

event clicked;s_date_e_sog s_date

dw_1.accepttext()
s_date.da_data=dw_1.getitemdate(1, "da_data")
s_date.a_data=dw_1.getitemdate(1, "a_data")
s_date.id_sog_com=1
openwithparm(w_galv_entr_uscita_rpt, s_date)
end event

type cb_3 from commandbutton within w_da_data_a_data_st
integer x = 1230
integer y = 536
integer width = 306
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "GALV. A1"
end type

event clicked;s_date_e_sog s_date

dw_1.accepttext()
s_date.da_data=dw_1.getitemdate(1, "da_data")
s_date.a_data=dw_1.getitemdate(1, "a_data")
s_date.id_sog_com=1
s_date.filtro=dw_1.getitemstring(1, "filtro")
if cbx_flag.checked then s_date.flag="S"
openwithparm(w_galv_da_data_tot_doc, s_date)
end event

type cb_4 from commandbutton within w_da_data_a_data_st
integer x = 663
integer y = 536
integer width = 256
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Statist."
end type

event clicked;s_date_e_sog s_date

dw_1.accepttext()
s_date.da_data=dw_1.getitemdate(1, "da_data")
s_date.a_data=dw_1.getitemdate(1, "a_data")
s_date.id_sog_com=1
openwithparm(w_galv_statistica_rpt, s_date)
end event

type dw_2 from udw_000 within w_da_data_a_data_st
integer x = 1577
integer y = 28
integer width = 709
integer height = 164
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_scegli_prof_doc"
boolean border = false
end type

type cb_5 from commandbutton within w_da_data_a_data_st
integer x = 1577
integer y = 180
integer width = 640
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "GALVINT_RGALVINT"
end type

event clicked;s_date_e_sog s_date

dw_1.accepttext()
dw_2.accepttext()
s_date.da_data=dw_1.getitemdate(1, "da_data")
s_date.a_data=dw_1.getitemdate(1, "a_data")
s_date.id_sog_com=dw_2.getitemnumber(1, "id_prof_documento")
if s_date.id_sog_com<=0 or isnull(s_date.id_sog_com) then
	messagebox("Attenzione!", "Occorre inserire un profilo!!!")
	return
end if
s_date.filtro=dw_1.getitemstring(1, "filtro")
openwithparm(w_galv_da_data_tot_doc, s_date)
end event

type cbx_flag from checkbox within w_da_data_a_data_st
integer x = 1792
integer y = 328
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Confronto"
end type

type cb_6 from commandbutton within w_da_data_a_data_st
integer x = 1234
integer y = 676
integer width = 306
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Fatturato"
end type

event clicked;s_date_e_sog s_date

dw_1.accepttext()
s_date.da_data=dw_1.getitemdate(1, "da_data")
s_date.a_data=dw_1.getitemdate(1, "a_data")
s_date.id_sog_com=dw_1.getitemnumber(1, "registro")
s_date.filtro=dw_1.getitemstring(1, "filtro")
if cbx_flag.checked then s_date.flag="S"
openwithparm(w_galv_da_data_tot_doc, s_date)
end event

