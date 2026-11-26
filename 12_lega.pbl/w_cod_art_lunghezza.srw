forward
global type w_cod_art_lunghezza from w_semplice_gd
end type
end forward

global type w_cod_art_lunghezza from w_semplice_gd
integer width = 2738
end type
global w_cod_art_lunghezza w_cod_art_lunghezza

on w_cod_art_lunghezza.create
call super::create
end on

on w_cod_art_lunghezza.destroy
call super::destroy
end on

type cb_stampa from w_semplice_gd`cb_stampa within w_cod_art_lunghezza
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_cod_art_lunghezza
end type

type cb_primo from w_semplice_gd`cb_primo within w_cod_art_lunghezza
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_cod_art_lunghezza
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_cod_art_lunghezza
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_cod_art_lunghezza
end type

type dw_1 from w_semplice_gd`dw_1 within w_cod_art_lunghezza
integer width = 2615
string dataobject = "d_cod_articolo_lunghezza"
end type

event dw_1::itemchanged;call super::itemchanged;long ll_id_art
if dwo.name='codice' then
	ll_id_art=long(data)
	if ll_id_art>0 then
		update dba.articolo
		set ges_matricole='S'
		where id_articolo=:ll_id_art
		;
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "ARTICOLO NON SALVATO!")
		end if
		dw_1.retrieve()
	end if
	
end if
end event

event dw_1::updateend;call super::updateend;dw_1.retrieve()
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_cod_art_lunghezza
end type

type cb_salva from w_semplice_gd`cb_salva within w_cod_art_lunghezza
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_cod_art_lunghezza
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_cod_art_lunghezza
end type

type cb_ok from w_semplice_gd`cb_ok within w_cod_art_lunghezza
end type

