forward
global type w_art_famiglia from w_semplice_gd
end type
end forward

global type w_art_famiglia from w_semplice_gd
integer width = 3566
integer height = 1548
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
end type
global w_art_famiglia w_art_famiglia

on w_art_famiglia.create
call super::create
end on

on w_art_famiglia.destroy
call super::destroy
end on

event open;s_array s_dati 

s_dati=message.powerobjectparm
dw_1.settransobject(sqlca)
dw_1.retrieve(s_dati.as_string[1], long (s_dati.as_string[2]))
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_art_famiglia
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_art_famiglia
end type

type cb_primo from w_semplice_gd`cb_primo within w_art_famiglia
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_art_famiglia
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_art_famiglia
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_art_famiglia
end type

type dw_1 from w_semplice_gd`dw_1 within w_art_famiglia
integer width = 3479
string dataobject = "d_art_cliente_diverso"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_art_famiglia
end type

type cb_salva from w_semplice_gd`cb_salva within w_art_famiglia
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_art_famiglia
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_art_famiglia
end type

type cb_ok from w_semplice_gd`cb_ok within w_art_famiglia
end type

