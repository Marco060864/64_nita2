forward
global type w_cartellino_b_gd from w_semplice_gd
end type
end forward

global type w_cartellino_b_gd from w_semplice_gd
integer width = 3717
integer height = 1860
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_cartellino_b_gd w_cartellino_b_gd

on w_cartellino_b_gd.create
call super::create
end on

on w_cartellino_b_gd.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_cartellino_b_gd
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_cartellino_b_gd
end type

type cb_primo from w_semplice_gd`cb_primo within w_cartellino_b_gd
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_cartellino_b_gd
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_cartellino_b_gd
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_cartellino_b_gd
end type

type dw_1 from w_semplice_gd`dw_1 within w_cartellino_b_gd
integer width = 3634
string dataobject = "d_cartellino_b2_gd"
end type

event dw_1::ue_post_insert;call super::ue_post_insert;string ls_max_codice
long ll_max

select max(codice) into :ls_max_codice from dba.cat_merceologica;
	
ll_max=long(right(ls_max_codice, 6))
ls_max_codice=""
ls_max_codice="X_"+fill("0", 6 - len(string(ll_max+1)))+string(ll_max+1)
dw_1.setitem(al_riga, "cat_merceologica_codice", ls_max_codice)


end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_cartellino_b_gd
end type

type cb_salva from w_semplice_gd`cb_salva within w_cartellino_b_gd
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_cartellino_b_gd
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_cartellino_b_gd
end type

event cb_annulla::clicked;long  ll_riga_corrente
long ll_cartellino
ll_riga_corrente=dw_1.getrow()
if ll_riga_corrente>0 then
	ll_cartellino=dw_1.getitemnumber(ll_riga_corrente, "id_cat_merceologica")
	closewithreturn(parent, ll_cartellino)
end if
	
end event

type cb_ok from w_semplice_gd`cb_ok within w_cartellino_b_gd
end type

