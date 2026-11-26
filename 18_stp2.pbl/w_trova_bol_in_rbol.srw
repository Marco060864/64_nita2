forward
global type w_trova_bol_in_rbol from w_semplice_gd
end type
end forward

global type w_trova_bol_in_rbol from w_semplice_gd
integer width = 3131
end type
global w_trova_bol_in_rbol w_trova_bol_in_rbol

on w_trova_bol_in_rbol.create
call super::create
end on

on w_trova_bol_in_rbol.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_trova_bol_in_rbol
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_trova_bol_in_rbol
end type

type cb_primo from w_semplice_gd`cb_primo within w_trova_bol_in_rbol
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_trova_bol_in_rbol
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_trova_bol_in_rbol
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_trova_bol_in_rbol
end type

type dw_1 from w_semplice_gd`dw_1 within w_trova_bol_in_rbol
integer width = 2985
string dataobject = "d_trova_bol_in_rbol"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_trova_bol_in_rbol
end type

type cb_salva from w_semplice_gd`cb_salva within w_trova_bol_in_rbol
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_trova_bol_in_rbol
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_trova_bol_in_rbol
end type

type cb_ok from w_semplice_gd`cb_ok within w_trova_bol_in_rbol
end type

