forward
global type w_des_art_b from w_semplice_cx
end type
end forward

global type w_des_art_b from w_semplice_cx
integer width = 3429
integer height = 1308
boolean resizable = true
end type
global w_des_art_b w_des_art_b

on w_des_art_b.create
call super::create
end on

on w_des_art_b.destroy
call super::destroy
end on

event open;call super::open;dw_1.retrieve()
end event

type cb_stampa from w_semplice_cx`cb_stampa within w_des_art_b
end type

type cb_ricerca from w_semplice_cx`cb_ricerca within w_des_art_b
end type

type cb_primo from w_semplice_cx`cb_primo within w_des_art_b
end type

type cb_ultimo from w_semplice_cx`cb_ultimo within w_des_art_b
end type

type cb_indietro from w_semplice_cx`cb_indietro within w_des_art_b
end type

type cb_avanti from w_semplice_cx`cb_avanti within w_des_art_b
end type

type dw_1 from w_semplice_cx`dw_1 within w_des_art_b
integer width = 3291
string dataobject = "d_des_art_b"
end type

type cb_inserisci from w_semplice_cx`cb_inserisci within w_des_art_b
end type

type cb_salva from w_semplice_cx`cb_salva within w_des_art_b
end type

type cb_cancella from w_semplice_cx`cb_cancella within w_des_art_b
end type

type cb_annulla from w_semplice_cx`cb_annulla within w_des_art_b
end type

type cb_ok from w_semplice_cx`cb_ok within w_des_art_b
end type

