forward
global type w_conta_click_menu from w_semplice_gd
end type
end forward

global type w_conta_click_menu from w_semplice_gd
integer width = 3570
end type
global w_conta_click_menu w_conta_click_menu

on w_conta_click_menu.create
call super::create
end on

on w_conta_click_menu.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_conta_click_menu
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_conta_click_menu
end type

type cb_primo from w_semplice_gd`cb_primo within w_conta_click_menu
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_conta_click_menu
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_conta_click_menu
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_conta_click_menu
end type

type dw_1 from w_semplice_gd`dw_1 within w_conta_click_menu
integer width = 3410
string dataobject = "d_conta_click_menu"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_conta_click_menu
end type

type cb_salva from w_semplice_gd`cb_salva within w_conta_click_menu
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_conta_click_menu
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_conta_click_menu
end type

type cb_ok from w_semplice_gd`cb_ok within w_conta_click_menu
end type

