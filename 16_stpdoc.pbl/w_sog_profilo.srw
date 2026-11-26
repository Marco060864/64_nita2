forward
global type w_sog_profilo from w_semplice_gd
end type
end forward

global type w_sog_profilo from w_semplice_gd
integer width = 2615
integer height = 2268
end type
global w_sog_profilo w_sog_profilo

on w_sog_profilo.create
call super::create
end on

on w_sog_profilo.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_sog_profilo
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_sog_profilo
end type

type cb_primo from w_semplice_gd`cb_primo within w_sog_profilo
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_sog_profilo
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_sog_profilo
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_sog_profilo
end type

type dw_1 from w_semplice_gd`dw_1 within w_sog_profilo
integer width = 2505
string dataobject = "D_SOG_PROFILO"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_sog_profilo
end type

type cb_salva from w_semplice_gd`cb_salva within w_sog_profilo
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_sog_profilo
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_sog_profilo
integer x = 1979
end type

type cb_ok from w_semplice_gd`cb_ok within w_sog_profilo
integer x = 2272
end type

