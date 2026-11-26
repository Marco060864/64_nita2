forward
global type w_art_eccezione from w_semplice_gd
end type
end forward

global type w_art_eccezione from w_semplice_gd
integer width = 2427
integer height = 1548
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_art_eccezione w_art_eccezione

on w_art_eccezione.create
call super::create
end on

on w_art_eccezione.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_art_eccezione
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_art_eccezione
end type

type cb_primo from w_semplice_gd`cb_primo within w_art_eccezione
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_eccezione
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_eccezione
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_eccezione
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_eccezione
string dataobject = "d_ecc_art_no_saldare"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_eccezione
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_eccezione
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_eccezione
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_eccezione
string tag = "Ogni articolo qui dentro viene escluso dalla procedura ~"da saldare~". Se valorizzi il cliente SOLO per quel cliente, se valorizzi l~'accessorio, SOLO per quell~'accessorio."
string text = "HELP"
end type

event cb_annulla::clicked;//

messagebox("Informazioni!", this.tag)
end event

type cb_ok from w_semplice_gd`cb_ok within w_art_eccezione
end type

