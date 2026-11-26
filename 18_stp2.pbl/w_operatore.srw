forward
global type w_operatore from w_semplice_gd
end type
end forward

global type w_operatore from w_semplice_gd
end type
global w_operatore w_operatore

on w_operatore.create
call super::create
end on

on w_operatore.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_operatore
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_operatore
end type

type cb_primo from w_semplice_gd`cb_primo within w_operatore
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_operatore
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_operatore
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_operatore
end type

type dw_1 from w_semplice_gd`dw_1 within w_operatore
integer width = 2683
string dataobject = "d_operatore"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_operatore
end type

type cb_salva from w_semplice_gd`cb_salva within w_operatore
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_operatore
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_operatore
end type

type cb_ok from w_semplice_gd`cb_ok within w_operatore
end type

