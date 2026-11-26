forward
global type w_fab_acc_k from w_semplice_gd
end type
end forward

global type w_fab_acc_k from w_semplice_gd
integer width = 4366
end type
global w_fab_acc_k w_fab_acc_k

on w_fab_acc_k.create
call super::create
end on

on w_fab_acc_k.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_fab_acc_k
integer width = 535
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_fab_acc_k
end type

type cb_primo from w_semplice_gd`cb_primo within w_fab_acc_k
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_fab_acc_k
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_fab_acc_k
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_fab_acc_k
end type

type dw_1 from w_semplice_gd`dw_1 within w_fab_acc_k
integer width = 4192
string dataobject = "d_fab_acc_k"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_fab_acc_k
end type

type cb_salva from w_semplice_gd`cb_salva within w_fab_acc_k
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_fab_acc_k
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_fab_acc_k
end type

type cb_ok from w_semplice_gd`cb_ok within w_fab_acc_k
end type

