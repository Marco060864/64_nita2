forward
global type w_verifica_ordini from w_semplice_gd
end type
type dw_2 from udw_000 within w_verifica_ordini
end type
end forward

global type w_verifica_ordini from w_semplice_gd
integer width = 3639
dw_2 dw_2
end type
global w_verifica_ordini w_verifica_ordini

on w_verifica_ordini.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_verifica_ordini.destroy
call super::destroy
destroy(this.dw_2)
end on

event open;dw_1.settransobject(sqlca)
dw_2.insertrow(1)
end event

event resize;call super::resize;cb_cancella.y=newheight - 224
dw_2.y=cb_cancella.y
dw_2.x=cb_cancella.x +cb_cancella.width+20+ cb_stampa.width + 80
cb_cancella.x=cb_salva.x + 285
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_verifica_ordini
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_verifica_ordini
end type

type cb_primo from w_semplice_gd`cb_primo within w_verifica_ordini
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_verifica_ordini
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_verifica_ordini
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_verifica_ordini
end type

type dw_1 from w_semplice_gd`dw_1 within w_verifica_ordini
integer width = 3534
string dataobject = "d_verifica_ordini"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_verifica_ordini
end type

type cb_salva from w_semplice_gd`cb_salva within w_verifica_ordini
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_verifica_ordini
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_verifica_ordini
end type

type cb_ok from w_semplice_gd`cb_ok within w_verifica_ordini
end type

type dw_2 from udw_000 within w_verifica_ordini
integer x = 1381
integer y = 960
integer width = 402
integer height = 132
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_verifica_num_ordine"
end type

event itemchanged;call super::itemchanged;if len(data)=5 then 
	dw_1.retrieve(long(data))	
end if
end event

