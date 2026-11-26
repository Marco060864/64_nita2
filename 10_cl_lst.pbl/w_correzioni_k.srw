forward
global type w_correzioni_k from w_semplice_gd
end type
type cb_1 from commandbutton within w_correzioni_k
end type
end forward

global type w_correzioni_k from w_semplice_gd
integer width = 2473
cb_1 cb_1
end type
global w_correzioni_k w_correzioni_k

on w_correzioni_k.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_correzioni_k.destroy
call super::destroy
destroy(this.cb_1)
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_correzioni_k
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_correzioni_k
end type

type cb_primo from w_semplice_gd`cb_primo within w_correzioni_k
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_correzioni_k
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_correzioni_k
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_correzioni_k
end type

type dw_1 from w_semplice_gd`dw_1 within w_correzioni_k
string dataobject = "d_correzioni_k"
end type

event dw_1::ue_post_insert;call super::ue_post_insert; setcolumn("id_riga_documento")
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_correzioni_k
end type

type cb_salva from w_semplice_gd`cb_salva within w_correzioni_k
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_correzioni_k
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_correzioni_k
end type

type cb_ok from w_semplice_gd`cb_ok within w_correzioni_k
end type

type cb_1 from commandbutton within w_correzioni_k
integer x = 1609
integer y = 256
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "open("
end type

event clicked;open(w_rimedia_err_rientro)
end event

