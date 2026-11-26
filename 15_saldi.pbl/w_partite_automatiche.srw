forward
global type w_partite_automatiche from w_001
end type
type dw_2 from udw_base within w_partite_automatiche
end type
type dw_3 from udw_base within w_partite_automatiche
end type
type st_2 from statictext within w_partite_automatiche
end type
type st_3 from statictext within w_partite_automatiche
end type
type dw_4 from udw_base within w_partite_automatiche
end type
type cb_vai from commandbutton within w_partite_automatiche
end type
type cb_carica from commandbutton within w_partite_automatiche
end type
type cb_salva from commandbutton within w_partite_automatiche
end type
type cb_3 from commandbutton within w_partite_automatiche
end type
type cb_cancella_tutto from commandbutton within w_partite_automatiche
end type
type st_4 from statictext within w_partite_automatiche
end type
type dw_1 from udw_001 within w_partite_automatiche
end type
type cb_4 from commandbutton within w_partite_automatiche
end type
type cb_1 from commandbutton within w_partite_automatiche
end type
end forward

global type w_partite_automatiche from w_001
integer x = 1057
integer y = 483
integer width = 3986
integer height = 2036
boolean minbox = true
windowtype windowtype = popup!
dw_2 dw_2
dw_3 dw_3
st_2 st_2
st_3 st_3
dw_4 dw_4
cb_vai cb_vai
cb_carica cb_carica
cb_salva cb_salva
cb_3 cb_3
cb_cancella_tutto cb_cancella_tutto
st_4 st_4
dw_1 dw_1
cb_4 cb_4
cb_1 cb_1
end type
global w_partite_automatiche w_partite_automatiche

on w_partite_automatiche.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_2=create st_2
this.st_3=create st_3
this.dw_4=create dw_4
this.cb_vai=create cb_vai
this.cb_carica=create cb_carica
this.cb_salva=create cb_salva
this.cb_3=create cb_3
this.cb_cancella_tutto=create cb_cancella_tutto
this.st_4=create st_4
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.cb_vai
this.Control[iCurrent+7]=this.cb_carica
this.Control[iCurrent+8]=this.cb_salva
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.cb_cancella_tutto
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.cb_4
this.Control[iCurrent+14]=this.cb_1
end on

on w_partite_automatiche.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_4)
destroy(this.cb_vai)
destroy(this.cb_carica)
destroy(this.cb_salva)
destroy(this.cb_3)
destroy(this.cb_cancella_tutto)
destroy(this.st_4)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;date ldt_data_inizio

//ldt_data_inizio=date("01-01-"+string(year(today())))

//dw_4.setitem(1, "da_data", ldt_data_inizio)
end event

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)

dw_4.insertrow(1)
end event

type st_1 from w_001`st_1 within w_partite_automatiche
integer x = 1289
integer y = 588
end type

type dw_2 from udw_base within w_partite_automatiche
integer x = 27
integer y = 284
integer width = 2839
integer height = 744
boolean bringtotop = true
string dataobject = "d_car_per_par_automatiche2"
end type

type dw_3 from udw_base within w_partite_automatiche
integer x = 27
integer y = 1128
integer width = 2839
integer height = 744
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_car_scarico_par_automatiche2"
end type

type st_2 from statictext within w_partite_automatiche
integer x = 59
integer y = 232
integer width = 320
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carichi"
boolean focusrectangle = false
end type

type st_3 from statictext within w_partite_automatiche
integer x = 27
integer y = 1052
integer width = 320
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Scarichi"
boolean focusrectangle = false
end type

type dw_4 from udw_base within w_partite_automatiche
integer x = 59
integer width = 731
integer height = 204
boolean bringtotop = true
string dataobject = "d_date_per_par_automatiche"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type cb_vai from commandbutton within w_partite_automatiche
boolean visible = false
integer x = 1170
integer y = 28
integer width = 320
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Vai"
end type

event clicked;date ldt_da_data,ldt_a_data
long ll_righe_2, ll_righe_3, i, ll_id_riga_scar, ll_id_riga_car, ll_di_sog_comm
long ll_riga_trovata, a
decimal ldc_qta_da_scaricare, ldc_qta_carico, ldc_qta_da_memorizzare
string ls_metallo

//ldt_da_data=dw_4.getitemdate(1, "da_data")
//ldt_a_data=dw_4.getitemdate(1, "a_data")
//ll_righe_2=dw_2.retrieve(ldt_da_data, ldt_a_data)
//ll_righe_3=dw_3.retrieve(ldt_da_data, ldt_a_data)
ll_righe_2=dw_2.rowcount()
ll_righe_3=dw_3.rowcount()

for i= 1 to ll_righe_3
	ldc_qta_da_scaricare=dw_3.getitemdecimal(i, "c_fino_calo")
	ll_id_riga_scar=dw_3.getitemnumber(i, "id_riga_documento")
	ll_di_sog_comm=dw_3.getitemnumber(i, "id_sog_commerciale")
	ls_metallo=dw_3.getitemstring(i, "cod_metallo")
	if ldc_qta_da_scaricare> 1 then
		do while ldc_qta_da_scaricare>0
			ll_riga_trovata=dw_2.find("id_sog_commerciale="+string(ll_di_sog_comm)+" and c_fino_calo > 0 "+&
												" and cod_metallo='"+ls_metallo+"'", &
												1, ll_righe_2)
			if ll_riga_trovata <=0 then
				//messagebox("Attenzione!", "Carichi insufficienti!")
				exit	
			end if
			ll_id_riga_car=dw_2.getitemnumber(ll_riga_trovata, "id_riga_documento")
			if ll_id_riga_car= 0 then continue
			ldc_qta_carico=dw_2.getitemnumber(ll_riga_trovata, "c_fino_calo")
			if ldc_qta_carico >= ldc_qta_da_scaricare then
				ldc_qta_da_memorizzare=ldc_qta_da_scaricare
				ldc_qta_carico -= ldc_qta_da_scaricare
				//dw_2.setitem(ll_riga_trovata, "c_fino_calo", ldc_qta_carico )
				ldc_qta_da_scaricare=0
			else //il carico non basta devo fare un altro giro e trovare un altro carico
				ldc_qta_da_scaricare -= ldc_qta_carico
				ldc_qta_da_memorizzare= ldc_qta_carico
				ldc_qta_carico=0
				
			end if
			dw_2.setitem(ll_riga_trovata, "c_fino_calo", ldc_qta_carico )
			//scrivo nella tabella partite_automatiche
			a=dw_1.insertrow(0)
			dw_1.setitem(a, "id_riga_doc_carico", ll_id_riga_car)
			dw_1.setitem(a, "id_riga_doc_scarico", ll_id_riga_scar)
			dw_1.setitem(a, "qta_scaricata", ldc_qta_da_memorizzare)
		loop
	end if
	
next

end event

type cb_carica from commandbutton within w_partite_automatiche
boolean visible = false
integer x = 818
integer y = 28
integer width = 320
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica"
end type

event clicked;date ldt_da_data, ldt_a_data
long ll_righe_2, ll_righe_3, ll_righe_4

ldt_da_data=dw_4.getitemdate(1, "da_data")
ldt_a_data=dw_4.getitemdate(1, "a_data")
ll_righe_2=dw_2.retrieve(ldt_da_data, ldt_a_data)
ll_righe_3=dw_3.retrieve(ldt_da_data, ldt_a_data)

//ll_righe_4=dw_1.retrieve()
end event

type cb_salva from commandbutton within w_partite_automatiche
integer x = 2395
integer y = 40
integer width = 320
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer li_ret
li_ret=dw_1.trigger event UE_UPDATE()
if li_ret=1 then
	messagebox("OK!", "FATTO!")
else
	messagebox("AHI!", "Salvataggio Fallito!")
end if
end event

type cb_3 from commandbutton within w_partite_automatiche
integer x = 3218
integer y = 28
integer width = 411
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Vedi Registro PA"
end type

event clicked;s_stampa s_st

s_st.data_inizio=dw_4.getitemdate(1, "da_data")
s_st.data_fine=dw_4.getitemdate(1, "a_data")

openwithparm(w_par_automatiche_st, s_st)
end event

type cb_cancella_tutto from commandbutton within w_partite_automatiche
integer x = 3424
integer y = 180
integer width = 347
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella Tutto"
end type

event clicked;long ll_righe
integer li_ret

ll_righe= dw_1.rowcount()

if ll_righe>0 then
	li_ret=dw_1.rowsmove(1, ll_righe, primary!, dw_1, 1, delete!)
	if li_ret=1 then
		dw_1.trigger event ue_update()
	end if
end if
end event

type st_4 from statictext within w_partite_automatiche
boolean visible = false
integer x = 3767
integer y = 56
integer width = 992
integer height = 232
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prima ~"CARICA~", poi ~"CANCELLA TUTTO~", poi ~"VAI~" quindi ~"SALVA~""
boolean focusrectangle = false
end type

type dw_1 from udw_001 within w_partite_automatiche
integer x = 2894
integer y = 280
integer width = 1051
integer height = 1600
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_par_automatiche"
end type

type cb_4 from commandbutton within w_partite_automatiche
boolean visible = false
integer x = 901
integer y = 152
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
string text = "TUTTO"
end type

event clicked;cb_carica.triggerevent(clicked!)
cb_cancella_tutto.triggerevent(clicked!)
cb_carica.triggerevent(clicked!)
cb_vai.triggerevent(clicked!)
cb_salva.triggerevent(clicked!)

end event

type cb_1 from commandbutton within w_partite_automatiche
integer x = 1737
integer y = 40
integer width = 622
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Premi QUi e poi SALVA-->"
end type

event clicked;date ldt_da_data,ldt_a_data
long ll_righe_2, ll_righe_3, i, ll_id_riga_scar, ll_id_riga_car, ll_di_sog_comm
long ll_riga_trovata, a
decimal ldc_qta_da_scaricare, ldc_qta_carico, ldc_qta_old, ldc_qta_scarico, ldc_fino_utile
string ls_metallo

ldt_da_data=dw_4.getitemdate(1, "da_data")
ldt_a_data=dw_4.getitemdate(1, "a_data")
ll_righe_2=dw_2.retrieve(ldt_da_data, ldt_a_data)
ll_righe_3=dw_3.retrieve(ldt_da_data, ldt_a_data)

ldc_qta_scarico=dw_3.getitemdecimal(ll_righe_3, "c_somma_scarico")
ldc_qta_carico=dw_2.getitemdecimal(ll_righe_2, "c_somma_carico")
ldc_fino_utile=ldc_qta_carico - ldc_qta_scarico
//ora scorro le righe a ritroso finchè la somma dei carichi mi dà il fino utile	
for i= 1 to ll_righe_2
	ldc_qta_old=ldc_qta_da_scaricare
	ll_id_riga_car=dw_2.getitemnumber(i, "id_riga_documento")

	ldc_qta_da_scaricare+=dw_2.getitemnumber(i, "c_fino_calo")
	if ldc_qta_da_scaricare>=ldc_fino_utile then
		if ldc_qta_da_scaricare>ldc_fino_utile then
			a=dw_1.insertrow(0)
			dw_1.setitem(a, "id_riga_doc_carico", ll_id_riga_car)
			dw_1.setitem(a, "id_riga_doc_scarico", 0)
			dw_1.setitem(a, "qta_scaricata", ldc_fino_utile - ldc_qta_old )
		end if
		exit
	end if
	a=dw_1.insertrow(0)
	
	dw_1.setitem(a, "id_riga_doc_carico", ll_id_riga_car)
	dw_1.setitem(a, "id_riga_doc_scarico", 0)
	dw_1.setitem(a, "qta_scaricata", 0)
next
	
	
//	
//	ll_id_riga_scar=dw_3.getitemnumber(i, "id_riga_documento")
//	ll_di_sog_comm=dw_3.getitemnumber(i, "id_sog_commerciale")
//	ls_metallo=dw_3.getitemstring(i, "cod_metallo")
//	if ldc_qta_da_scaricare> 1 then
//		do while ldc_qta_da_scaricare>0
//			ll_riga_trovata=dw_2.find("id_sog_commerciale="+string(ll_di_sog_comm)+" and c_fino_calo > 0 "+&
//												" and cod_metallo='"+ls_metallo+"'", &
//												1, ll_righe_2)
//			if ll_riga_trovata <=0 then
//				//messagebox("Attenzione!", "Carichi insufficienti!")
//				exit	
//			end if
//			ll_id_riga_car=dw_2.getitemnumber(ll_riga_trovata, "id_riga_documento")
//			if ll_id_riga_car= 0 then continue
//			ldc_qta_carico=dw_2.getitemnumber(ll_riga_trovata, "c_fino_calo")
//			if ldc_qta_carico >= ldc_qta_da_scaricare then
//				ldc_qta_da_memorizzare=ldc_qta_da_scaricare
//				ldc_qta_carico -= ldc_qta_da_scaricare
//				//dw_2.setitem(ll_riga_trovata, "c_fino_calo", ldc_qta_carico )
//				ldc_qta_da_scaricare=0
//			else //il carico non basta devo fare un altro giro e trovare un altro carico
//				ldc_qta_da_scaricare -= ldc_qta_carico
//				ldc_qta_da_memorizzare= ldc_qta_carico
//				ldc_qta_carico=0
//				
//			end if
//			dw_2.setitem(ll_riga_trovata, "c_fino_calo", ldc_qta_carico )
//			//scrivo nella tabella partite_automatiche
//			a=dw_1.insertrow(0)
//			dw_1.setitem(a, "id_riga_doc_carico", ll_id_riga_car)
//			dw_1.setitem(a, "id_riga_doc_scarico", ll_id_riga_scar)
//			dw_1.setitem(a, "qta_scaricata", ldc_qta_da_memorizzare)
//		loop
//	end if
//	
//next
//
end event

