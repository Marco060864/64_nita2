forward
global type w_bol_doppie_mun_st from w_stampa
end type
end forward

global type w_bol_doppie_mun_st from w_stampa
integer width = 4736
end type
global w_bol_doppie_mun_st w_bol_doppie_mun_st

on w_bol_doppie_mun_st.create
call super::create
end on

on w_bol_doppie_mun_st.destroy
call super::destroy
end on

event open;call super::open;dw_1.settransobject(sqlca)

dw_1.retrieve()
end event

type pb_1 from w_stampa`pb_1 within w_bol_doppie_mun_st
end type

type cb_preview from w_stampa`cb_preview within w_bol_doppie_mun_st
end type

type dw_1 from w_stampa`dw_1 within w_bol_doppie_mun_st
integer width = 4283
string dataobject = "d_bol_doppie_mun"
end type

event dw_1::retrieveend;call super::retrieveend;long i	, ll_id_art, ll_id_riga, ll_riga_trovata
decimal ldc_qta
string ls_des

for i = rowcount() to 1 step -1
	ll_id_art=dw_1.getitemnumber(i, "id_articolo")
	ldc_qta=dw_1.getitemdecimal(i, "quantita")
	ls_des=dw_1.getitemstring(i, "descrizione")
	ll_id_riga=dw_1.getitemnumber(i, "id_riga_documento")
	
	select id_riga_documento into :ll_riga_trovata
	from dba.riga_documento
	where id_articolo=:ll_id_art and quantita=:ldc_qta and descrizione=:ls_des and id_riga_documento<>:ll_id_riga;
	if ll_riga_trovata>0 then
		messagebox("Attenzione!", "Riga "+string(i)+" doppia! "+ls_des)
	end if
	
	
next
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_bol_doppie_mun_st
end type

type pb_stampa from w_stampa`pb_stampa within w_bol_doppie_mun_st
end type

type sle_pg from w_stampa`sle_pg within w_bol_doppie_mun_st
end type

type st_1 from w_stampa`st_1 within w_bol_doppie_mun_st
end type

type st_2 from w_stampa`st_2 within w_bol_doppie_mun_st
end type

type sle_copie from w_stampa`sle_copie within w_bol_doppie_mun_st
end type

type sle_zoom from w_stampa`sle_zoom within w_bol_doppie_mun_st
end type

type cb_7 from w_stampa`cb_7 within w_bol_doppie_mun_st
end type

type cb_6 from w_stampa`cb_6 within w_bol_doppie_mun_st
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_bol_doppie_mun_st
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_bol_doppie_mun_st
end type

type cb_esci from w_stampa`cb_esci within w_bol_doppie_mun_st
end type

