forward
global type w_trova_prezzo_des_2_art from w_stampa
end type
end forward

global type w_trova_prezzo_des_2_art from w_stampa
end type
global w_trova_prezzo_des_2_art w_trova_prezzo_des_2_art

type variables
long il_id_art
end variables

on w_trova_prezzo_des_2_art.create
call super::create
end on

on w_trova_prezzo_des_2_art.destroy
call super::destroy
end on

event open;call super::open;dw_1.settransobject(sqlca)

il_id_art=message.doubleparm

dw_1.retrieve()


end event

type pb_1 from w_stampa`pb_1 within w_trova_prezzo_des_2_art
end type

type cb_preview from w_stampa`cb_preview within w_trova_prezzo_des_2_art
end type

type dw_1 from w_stampa`dw_1 within w_trova_prezzo_des_2_art
integer width = 3355
string dataobject = "d_trova_prezzo_des2_art"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql
integer i  //, li_pos


if sqltype<>PreviewUpdate!	then
	ls_sql=sqlsyntax
	ls_sql+= " and articolo.id_articolo="+string(il_id_art)+" "
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
	
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_trova_prezzo_des_2_art
end type

type pb_stampa from w_stampa`pb_stampa within w_trova_prezzo_des_2_art
end type

type sle_pg from w_stampa`sle_pg within w_trova_prezzo_des_2_art
end type

type st_1 from w_stampa`st_1 within w_trova_prezzo_des_2_art
end type

type st_2 from w_stampa`st_2 within w_trova_prezzo_des_2_art
end type

type sle_copie from w_stampa`sle_copie within w_trova_prezzo_des_2_art
end type

type sle_zoom from w_stampa`sle_zoom within w_trova_prezzo_des_2_art
end type

type cb_7 from w_stampa`cb_7 within w_trova_prezzo_des_2_art
end type

type cb_6 from w_stampa`cb_6 within w_trova_prezzo_des_2_art
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_trova_prezzo_des_2_art
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_trova_prezzo_des_2_art
end type

type cb_esci from w_stampa`cb_esci within w_trova_prezzo_des_2_art
end type

