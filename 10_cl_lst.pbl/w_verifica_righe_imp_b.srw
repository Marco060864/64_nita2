forward
global type w_verifica_righe_imp_b from w_semplice_gd
end type
end forward

global type w_verifica_righe_imp_b from w_semplice_gd
integer width = 5509
integer height = 2044
end type
global w_verifica_righe_imp_b w_verifica_righe_imp_b

on w_verifica_righe_imp_b.create
call super::create
end on

on w_verifica_righe_imp_b.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_verifica_righe_imp_b
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_verifica_righe_imp_b
end type

type cb_primo from w_semplice_gd`cb_primo within w_verifica_righe_imp_b
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_verifica_righe_imp_b
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_verifica_righe_imp_b
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_verifica_righe_imp_b
end type

type dw_1 from w_semplice_gd`dw_1 within w_verifica_righe_imp_b
integer width = 5353
string dataobject = "d_ra_doc_rientro_fo_bucopia"
boolean hscrollbar = true
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_verifica_righe_imp_b
end type

type cb_salva from w_semplice_gd`cb_salva within w_verifica_righe_imp_b
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_verifica_righe_imp_b
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_verifica_righe_imp_b
end type

type cb_ok from w_semplice_gd`cb_ok within w_verifica_righe_imp_b
end type

