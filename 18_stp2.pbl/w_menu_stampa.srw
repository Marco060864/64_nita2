forward
global type w_menu_stampa from w_stampa_001
end type
end forward

global type w_menu_stampa from w_stampa_001
end type
global w_menu_stampa w_menu_stampa

on w_menu_stampa.create
call super::create
end on

on w_menu_stampa.destroy
call super::destroy
end on

event open;call super::open;long ll_id_utente

dw_1.settransobject(sqlca)

ll_id_utente=message.doubleparm
dw_1.retrieve(ll_id_utente)
end event

type dw_1 from w_stampa_001`dw_1 within w_menu_stampa
string dataobject = "d_menu_st"
end type

type sle_pg from w_stampa_001`sle_pg within w_menu_stampa
end type

type st_1 from w_stampa_001`st_1 within w_menu_stampa
end type

type st_2 from w_stampa_001`st_2 within w_menu_stampa
end type

type sle_copie from w_stampa_001`sle_copie within w_menu_stampa
end type

type sle_zoom from w_stampa_001`sle_zoom within w_menu_stampa
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_menu_stampa
end type

type cb_7 from w_stampa_001`cb_7 within w_menu_stampa
end type

type cb_6 from w_stampa_001`cb_6 within w_menu_stampa
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_menu_stampa
end type

type cb_stampa from w_stampa_001`cb_stampa within w_menu_stampa
end type

type cb_preview from w_stampa_001`cb_preview within w_menu_stampa
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_menu_stampa
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_menu_stampa
end type

type cb_1 from w_stampa_001`cb_1 within w_menu_stampa
end type

