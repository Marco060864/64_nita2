forward
global type w_art_peso_limite from w_semplice_gd
end type
type st_1 from statictext within w_art_peso_limite
end type
end forward

global type w_art_peso_limite from w_semplice_gd
integer width = 2990
integer height = 1548
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
st_1 st_1
end type
global w_art_peso_limite w_art_peso_limite

on w_art_peso_limite.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_art_peso_limite.destroy
call super::destroy
destroy(this.st_1)
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_art_peso_limite
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_art_peso_limite
end type

type cb_primo from w_semplice_gd`cb_primo within w_art_peso_limite
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_peso_limite
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_peso_limite
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_peso_limite
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_peso_limite
string dataobject = "d_art_peso_limite"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_peso_limite
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_peso_limite
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_peso_limite
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_peso_limite
end type

type cb_ok from w_semplice_gd`cb_ok within w_art_peso_limite
end type

type st_1 from statictext within w_art_peso_limite
integer x = 2377
integer y = 32
integer width = 498
integer height = 844
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "ATTENZIONE!!! Quando Karizia spedisce mette il peso TUTTO nella prima bollettina; questo può generare un peso oltre il limite! Quindi creare a<rticoli doppi (con K6 e senza o con >8 e senza)"
boolean focusrectangle = false
end type

