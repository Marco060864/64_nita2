forward
global type w_st_cod_barre_galvanica from w_stampa
end type
end forward

global type w_st_cod_barre_galvanica from w_stampa
end type
global w_st_cod_barre_galvanica w_st_cod_barre_galvanica

event open;call super::open;long ll_righe
integer i
string ls_stato, ls_fornitore, ls_num_prog, ls_codice,ls_check, ls_codice_ok
date ldt_data_doc
dw_1.settransobject(sqlca)
ll_righe=dw_1.retrieve()
for i= 1 to ll_righe
	

	//fine inserimento controllo
	ls_stato='80'
	
	ls_fornitore="0"+string(year(ldt_data_doc))
	
	ls_num_prog=string(dw_1.getitemnumber(i, "id_galvanica"), "#")
	do while len(ls_num_prog)<5
		ls_num_prog="0"+ls_num_prog
	loop
	
	ls_codice= ls_stato+ls_fornitore+ls_num_prog
	ls_check=string(f_check_digit(ls_codice, 13))
	
	ls_codice+= ls_check
	ls_codice_ok=f_crea_codice_a_barre(ls_codice)
		dw_1.setitem(i, "cod_barre", ls_codice_ok)

next
end event

on w_st_cod_barre_galvanica.create
call super::create
end on

on w_st_cod_barre_galvanica.destroy
call super::destroy
end on

type pb_1 from w_stampa`pb_1 within w_st_cod_barre_galvanica
end type

type cb_preview from w_stampa`cb_preview within w_st_cod_barre_galvanica
end type

type dw_1 from w_stampa`dw_1 within w_st_cod_barre_galvanica
string dataobject = "d_orafo_galvanica_cod_barre"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_cod_barre_galvanica
end type

type pb_stampa from w_stampa`pb_stampa within w_st_cod_barre_galvanica
end type

type sle_pg from w_stampa`sle_pg within w_st_cod_barre_galvanica
end type

type st_1 from w_stampa`st_1 within w_st_cod_barre_galvanica
end type

type st_2 from w_stampa`st_2 within w_st_cod_barre_galvanica
end type

type sle_copie from w_stampa`sle_copie within w_st_cod_barre_galvanica
end type

type sle_zoom from w_stampa`sle_zoom within w_st_cod_barre_galvanica
end type

type cb_7 from w_stampa`cb_7 within w_st_cod_barre_galvanica
end type

type cb_6 from w_stampa`cb_6 within w_st_cod_barre_galvanica
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_cod_barre_galvanica
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_cod_barre_galvanica
end type

type cb_esci from w_stampa`cb_esci within w_st_cod_barre_galvanica
end type

