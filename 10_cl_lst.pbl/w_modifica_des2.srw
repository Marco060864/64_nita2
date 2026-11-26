forward
global type w_modifica_des2 from w_semplice_gd
end type
end forward

global type w_modifica_des2 from w_semplice_gd
integer width = 2386
integer height = 1208
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_modifica_des2 w_modifica_des2

event open;long ll_id_uc, ll_id_variazione=15  //è di Karizia

ll_id_uc=message.doubleparm
dw_1.settransobject(sqlca)
dw_1.retrieve(ll_id_variazione, ll_id_uc)

end event

on w_modifica_des2.create
call super::create
end on

on w_modifica_des2.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_modifica_des2
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_modifica_des2
end type

type cb_primo from w_semplice_gd`cb_primo within w_modifica_des2
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_modifica_des2
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_modifica_des2
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_modifica_des2
end type

type dw_1 from w_semplice_gd`dw_1 within w_modifica_des2
integer width = 2295
string dataobject = "d_modifica_des2"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_modifica_des2
end type

type cb_salva from w_semplice_gd`cb_salva within w_modifica_des2
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_modifica_des2
boolean visible = false
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_modifica_des2
end type

event cb_annulla::clicked;call super::clicked;closewithreturn(parent, 0)
end event

type cb_ok from w_semplice_gd`cb_ok within w_modifica_des2
end type

event cb_ok::clicked;closewithreturn(parent, 1)
end event

