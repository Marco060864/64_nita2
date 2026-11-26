forward
global type w_slide_accessori_gd from w_semplice_gd
end type
type cb_acc_peso from commandbutton within w_slide_accessori_gd
end type
end forward

global type w_slide_accessori_gd from w_semplice_gd
integer width = 5161
cb_acc_peso cb_acc_peso
end type
global w_slide_accessori_gd w_slide_accessori_gd

on w_slide_accessori_gd.create
int iCurrent
call super::create
this.cb_acc_peso=create cb_acc_peso
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_acc_peso
end on

on w_slide_accessori_gd.destroy
call super::destroy
destroy(this.cb_acc_peso)
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_slide_accessori_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_slide_accessori_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_slide_accessori_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_slide_accessori_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_slide_accessori_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_slide_accessori_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_slide_accessori_gd
integer width = 5015
string dataobject = "d_slide_accessori_gd"
end type

event dw_1::rowfocuschanged;//modify("#1.background.color='0~tIf(getrow()=currentrow(),255,rgb(255,255,255))'")

df_segna_obbligatori()
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_slide_accessori_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_slide_accessori_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_slide_accessori_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_slide_accessori_gd
end type

type cb_ok from w_semplice_gd`cb_ok within w_slide_accessori_gd
end type

type cb_acc_peso from commandbutton within w_slide_accessori_gd
integer x = 2889
integer y = 1140
integer width = 402
integer height = 112
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Acc_PESO"
end type

event clicked;open(w_acc_peso_gd)
end event

