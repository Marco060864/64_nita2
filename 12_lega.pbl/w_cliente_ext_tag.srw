forward
global type w_cliente_ext_tag from w_semplice_gd
end type
end forward

global type w_cliente_ext_tag from w_semplice_gd
integer width = 3547
end type
global w_cliente_ext_tag w_cliente_ext_tag

on w_cliente_ext_tag.create
call super::create
end on

on w_cliente_ext_tag.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_cliente_ext_tag
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_cliente_ext_tag
end type

type cb_primo from w_semplice_gd`cb_primo within w_cliente_ext_tag
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_cliente_ext_tag
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_cliente_ext_tag
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_cliente_ext_tag
end type

type dw_1 from w_semplice_gd`dw_1 within w_cliente_ext_tag
integer width = 3419
string dataobject = "d_cliente_ext_tag"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_cliente_ext_tag
end type

type cb_salva from w_semplice_gd`cb_salva within w_cliente_ext_tag
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_cliente_ext_tag
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_cliente_ext_tag
end type

type cb_ok from w_semplice_gd`cb_ok within w_cliente_ext_tag
end type

