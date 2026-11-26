forward
global type w_esporta_art_csv from w_semplice_gd
end type
end forward

global type w_esporta_art_csv from w_semplice_gd
integer width = 4133
end type
global w_esporta_art_csv w_esporta_art_csv

on w_esporta_art_csv.create
call super::create
end on

on w_esporta_art_csv.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_esporta_art_csv
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_esporta_art_csv
string text = "EXP CSV"
end type

event cb_ricerca::clicked;//
long i
string ls_titolo, ls_coef
decimal ldc_tit, ldc_coef

for i =1 to dw_1.rowcount()
	ls_titolo=string(dw_1.getitemdecimal(i, "titolo"))
	ls_coef=string(dw_1.getitemdecimal(i, "coef_calo"))
	ls_titolo=f_cambia_virgola_in_punto(ls_titolo)
	ls_coef=f_cambia_virgola_in_punto(ls_coef)
	dw_1.setitem(i, "titolo", ls_titolo)
	dw_1.setitem(i, "titolo", ls_coef)
next

dw_1.saveas()
end event

type cb_primo from w_semplice_gd`cb_primo within w_esporta_art_csv
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_esporta_art_csv
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_esporta_art_csv
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_esporta_art_csv
end type

type dw_1 from w_semplice_gd`dw_1 within w_esporta_art_csv
integer width = 3918
string dataobject = "d_esporta_art_csv"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_esporta_art_csv
end type

type cb_salva from w_semplice_gd`cb_salva within w_esporta_art_csv
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_esporta_art_csv
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_esporta_art_csv
end type

type cb_ok from w_semplice_gd`cb_ok within w_esporta_art_csv
end type

