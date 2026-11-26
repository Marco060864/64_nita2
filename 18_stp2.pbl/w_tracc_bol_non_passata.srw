forward
global type w_tracc_bol_non_passata from w_semplice_gd
end type
end forward

global type w_tracc_bol_non_passata from w_semplice_gd
integer width = 3520
end type
global w_tracc_bol_non_passata w_tracc_bol_non_passata

on w_tracc_bol_non_passata.create
call super::create
end on

on w_tracc_bol_non_passata.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_tracc_bol_non_passata
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_tracc_bol_non_passata
end type

type cb_primo from w_semplice_gd`cb_primo within w_tracc_bol_non_passata
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_tracc_bol_non_passata
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_tracc_bol_non_passata
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_tracc_bol_non_passata
end type

type dw_1 from w_semplice_gd`dw_1 within w_tracc_bol_non_passata
integer width = 3397
string dataobject = "d_tracc_bol_non_passate"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_tracc_bol_non_passata
end type

type cb_salva from w_semplice_gd`cb_salva within w_tracc_bol_non_passata
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_tracc_bol_non_passata
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_tracc_bol_non_passata
end type

type cb_ok from w_semplice_gd`cb_ok within w_tracc_bol_non_passata
end type

