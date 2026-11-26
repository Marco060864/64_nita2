forward
global type w_prof_doc_ins_automatico_gd from w_semplice_gd
end type
type cb_1 from commandbutton within w_prof_doc_ins_automatico_gd
end type
type sle_1 from singlelineedit within w_prof_doc_ins_automatico_gd
end type
type cb_2 from commandbutton within w_prof_doc_ins_automatico_gd
end type
type cb_3 from commandbutton within w_prof_doc_ins_automatico_gd
end type
type cb_4 from commandbutton within w_prof_doc_ins_automatico_gd
end type
type cb_5 from commandbutton within w_prof_doc_ins_automatico_gd
end type
end forward

global type w_prof_doc_ins_automatico_gd from w_semplice_gd
cb_1 cb_1
sle_1 sle_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
end type
global w_prof_doc_ins_automatico_gd w_prof_doc_ins_automatico_gd

on w_prof_doc_ins_automatico_gd.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.cb_5
end on

on w_prof_doc_ins_automatico_gd.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_prof_doc_ins_automatico_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_prof_doc_ins_automatico_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_prof_doc_ins_automatico_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_prof_doc_ins_automatico_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_prof_doc_ins_automatico_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_prof_doc_ins_automatico_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_prof_doc_ins_automatico_gd
string dataobject = "d_prof_doc_ins_automatico_gd"
boolean hscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_prof_doc_ins_automatico_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_prof_doc_ins_automatico_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_prof_doc_ins_automatico_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_prof_doc_ins_automatico_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_prof_doc_ins_automatico_gd
end type

type cb_1 from commandbutton within w_prof_doc_ins_automatico_gd
integer x = 1673
integer y = 1284
integer width = 311
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "BURATTO"
end type

event clicked;long ll_riga
integer li_ret, i

ll_riga=dw_1.rowcount()
for i=1 to 100
	li_ret=dw_1.rowscopy(ll_riga, ll_riga, primary!, dw_1, ll_riga+i, primary!)
	dw_1.setitem(ll_riga+i, "codice", "B_"+string(i))
	dw_1.setitem(ll_riga+i, "des_stampa", "BURATTO")
	dw_1.setitem(ll_riga+i, "Descrizione", "POSTO "+string(i)+" per BURATTO")
next
end event

type sle_1 from singlelineedit within w_prof_doc_ins_automatico_gd
integer x = 1234
integer y = 1280
integer width = 402
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_prof_doc_ins_automatico_gd
integer x = 2021
integer y = 1284
integer width = 311
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ceramico"
end type

event clicked;long ll_riga
integer li_ret, i

ll_riga=dw_1.rowcount()
for i=1 to 100
	li_ret=dw_1.rowscopy(ll_riga, ll_riga, primary!, dw_1, ll_riga+i, primary!)
	dw_1.setitem(ll_riga+i, "codice", "C_"+string(i))
	dw_1.setitem(ll_riga+i, "des_stampa", "CERAMICO")
	dw_1.setitem(ll_riga+i, "Descrizione", "POSTO "+string(i)+" per CERAMICO")
next
end event

type cb_3 from commandbutton within w_prof_doc_ins_automatico_gd
integer x = 2405
integer y = 1292
integer width = 357
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "GALVANICA"
end type

event clicked;long ll_riga
integer li_ret, i

ll_riga=dw_1.rowcount()
for i=1 to 100
	li_ret=dw_1.rowscopy(ll_riga, ll_riga, primary!, dw_1, ll_riga+i, primary!)
	dw_1.setitem(ll_riga+i, "codice", "G_"+string(i))
	dw_1.setitem(ll_riga+i, "des_stampa", "GALVANICA")
	dw_1.setitem(ll_riga+i, "Descrizione", "POSTO "+string(i)+" per GALVANICA")
next
end event

type cb_4 from commandbutton within w_prof_doc_ins_automatico_gd
integer x = 805
integer y = 1292
integer width = 379
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "CONTROLLO"
end type

event clicked;long ll_riga
integer li_ret, i

ll_riga=dw_1.rowcount()
for i=1 to 100
	li_ret=dw_1.rowscopy(ll_riga, ll_riga, primary!, dw_1, ll_riga+i, primary!)
	dw_1.setitem(ll_riga+i, "codice", "V_"+string(i))   //V=VERIFICA
	dw_1.setitem(ll_riga+i, "des_stampa", "CONTROLLO")
	dw_1.setitem(ll_riga+i, "Descrizione", "POSTO "+string(i)+" per CONTROLLO")
next
end event

type cb_5 from commandbutton within w_prof_doc_ins_automatico_gd
integer x = 384
integer y = 1292
integer width = 379
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "SPAZZOLA"
end type

event clicked;long ll_riga
integer li_ret, i

ll_riga=dw_1.rowcount()
for i=1 to 100
	li_ret=dw_1.rowscopy(ll_riga, ll_riga, primary!, dw_1, ll_riga+i, primary!)
	dw_1.setitem(ll_riga+i, "codice", "S_"+string(i))   //S=spazzolatura
	dw_1.setitem(ll_riga+i, "des_stampa", "SPAZZOLA")
	dw_1.setitem(ll_riga+i, "Descrizione", "POSTO "+string(i)+" per SPAZZOLATURA")
next
end event

