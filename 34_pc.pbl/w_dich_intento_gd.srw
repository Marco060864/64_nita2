forward
global type w_dich_intento_gd from w_semplice_gd
end type
end forward

global type w_dich_intento_gd from w_semplice_gd
integer width = 4773
integer height = 2076
end type
global w_dich_intento_gd w_dich_intento_gd

on w_dich_intento_gd.create
call super::create
end on

on w_dich_intento_gd.destroy
call super::destroy
end on

event open;call super::open;datawindowchild dwc_ana

dw_1.getchild("id_anagrafica", dwc_ana)
dwc_ana.settransobject(sqlca)
//dwc_ana.setfilter(
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_dich_intento_gd
integer x = 923
integer y = 1844
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_dich_intento_gd
integer x = 1458
integer y = 1844
end type

type cb_primo from w_semplice_gd`cb_primo within w_dich_intento_gd
integer x = 997
integer y = 1712
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_dich_intento_gd
integer x = 1413
integer y = 1712
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_dich_intento_gd
integer x = 1157
integer y = 1712
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_dich_intento_gd
integer x = 1285
integer y = 1712
end type

type dw_1 from w_semplice_gd`dw_1 within w_dich_intento_gd
integer width = 4507
integer height = 1616
string dataobject = "d_dich_intento_gd"
end type

event dw_1::ue_key;call super::ue_key;//
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_dich_intento_gd
integer x = 78
integer y = 1696
end type

type cb_salva from w_semplice_gd`cb_salva within w_dich_intento_gd
integer x = 357
integer y = 1696
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_dich_intento_gd
integer x = 649
integer y = 1696
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_dich_intento_gd
integer x = 1746
integer y = 1700
end type

type cb_ok from w_semplice_gd`cb_ok within w_dich_intento_gd
integer x = 2039
integer y = 1700
end type

