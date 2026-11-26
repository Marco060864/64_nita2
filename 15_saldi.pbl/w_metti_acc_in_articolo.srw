forward
global type w_metti_acc_in_articolo from w_semplice_gd
end type
end forward

global type w_metti_acc_in_articolo from w_semplice_gd
string title = "w_metti_acc_in_articolo"
end type
global w_metti_acc_in_articolo w_metti_acc_in_articolo

on w_metti_acc_in_articolo.create
call super::create
end on

on w_metti_acc_in_articolo.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_metti_acc_in_articolo
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_metti_acc_in_articolo
integer x = 1435
integer y = 992
end type

event cb_ricerca::clicked;string ls_cod_art, ls_acc
integer i, li_pos, li_pos_2
for i= 1 to dw_1.rowcount()
	ls_cod_art=dw_1.GETITEMSTRING(i, "codice")
	li_pos=pos(ls_cod_art, "_")
	li_pos_2=pos(ls_cod_art, "-", li_pos)
	if li_pos>0 and li_pos_2>0 then
		ls_acc=mid(ls_cod_art, li_pos+1, li_pos_2 - li_pos - 1)
		if pos(ls_acc, "_")>0 then ls_acc=left(ls_acc, pos(ls_acc, "_") - 1)
		dw_1.setitem(i, "accessorio", ls_acc)
	end if
next
end event

type cb_primo from w_semplice_gd`cb_primo within w_metti_acc_in_articolo
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_metti_acc_in_articolo
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_metti_acc_in_articolo
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_metti_acc_in_articolo
end type

type dw_1 from w_semplice_gd`dw_1 within w_metti_acc_in_articolo
integer width = 2674
string dataobject = "d_metti_acc_in_articolo"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_metti_acc_in_articolo
end type

type cb_salva from w_semplice_gd`cb_salva within w_metti_acc_in_articolo
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_metti_acc_in_articolo
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_metti_acc_in_articolo
end type

type cb_ok from w_semplice_gd`cb_ok within w_metti_acc_in_articolo
end type

