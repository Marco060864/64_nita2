forward
global type w_cancella_art_samy from w_semplice_gd
end type
end forward

global type w_cancella_art_samy from w_semplice_gd
integer width = 4379
integer height = 2112
end type
global w_cancella_art_samy w_cancella_art_samy

on w_cancella_art_samy.create
call super::create
end on

on w_cancella_art_samy.destroy
call super::destroy
end on

event open;call super::open;dw_1.retrieve()
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_cancella_art_samy
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_cancella_art_samy
end type

type cb_primo from w_semplice_gd`cb_primo within w_cancella_art_samy
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_cancella_art_samy
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_cancella_art_samy
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_cancella_art_samy
end type

type dw_1 from w_semplice_gd`dw_1 within w_cancella_art_samy
integer width = 4215
integer height = 1712
string dataobject = "d_cancella_articoli_samy"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_cancella_art_samy
end type

type cb_salva from w_semplice_gd`cb_salva within w_cancella_art_samy
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_cancella_art_samy
end type

event cb_cancella::rbuttondown;call super::rbuttondown;long ll_riga_da_cancellare, ll_righe
integer i
ll_riga_da_cancellare=dw_1.getrow()

if messagebox("Attenzione!", "Saranno cancellati tutti gli articoli qui presenti: continuare?",  Stopsign!, yesno!)=1 then
	ll_righe=dw_1.rowcount()
	for i = ll_righe to 1 step -1
		dw_1.trigger event ue_delete(i)	
		dw_1.trigger event ue_update()	
	next
end if
end event

type cb_annulla from w_semplice_gd`cb_annulla within w_cancella_art_samy
end type

type cb_ok from w_semplice_gd`cb_ok within w_cancella_art_samy
end type

