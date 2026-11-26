forward
global type w_st_studi_settore from w_stampa
end type
end forward

global type w_st_studi_settore from w_stampa
end type
global w_st_studi_settore w_st_studi_settore

on w_st_studi_settore.create
call super::create
end on

on w_st_studi_settore.destroy
call super::destroy
end on

event open;call super::open;s_date_e_sog st_dati
string ls_dw_object

st_dati=message.powerobjectparm
choose case st_dati.id_sog_com
	case 1
		ls_dw_object="d_studi_settore"
	case 2
		ls_dw_object="d_studi_settore_x_metallo"
	case 3
		ls_dw_object="d_studi_settore_x_proprieta"
	case 4
		ls_dw_object="d_studi_settore_x_lavorazione"
	case 5
		ls_dw_object="d_studi_settore_x_extracee"
	case 6
		ls_dw_object="d_studi_settore_x_pezzo"
	case 7
		ls_dw_object="d_studi_settore_x_grammo"
	case 8
		ls_dw_object="d_studi_settore_x_titolo"
	case 9
		ls_dw_object="d_studi_settore_x_prezzo"
	case 10
		ls_dw_object="d_studi_settore_x_aclc"
	case 11
		ls_dw_object="d_studi_settore_x_aclc_vu"
	case 12
		ls_dw_object="d_studi_settore_x_grammo_titolo"
	case 13
		ls_dw_object="d_studi_settore_x_sem"
end choose
dw_1.dataobject=ls_dw_object

dw_1.settransobject(sqlca)
dw_1.retrieve(st_dati.da_data, st_dati.a_data)
end event

type pb_1 from w_stampa`pb_1 within w_st_studi_settore
end type

type cb_preview from w_stampa`cb_preview within w_st_studi_settore
end type

type dw_1 from w_stampa`dw_1 within w_st_studi_settore
string dataobject = "d_studi_settore"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_studi_settore
end type

type pb_stampa from w_stampa`pb_stampa within w_st_studi_settore
end type

type sle_pg from w_stampa`sle_pg within w_st_studi_settore
end type

type st_1 from w_stampa`st_1 within w_st_studi_settore
end type

type st_2 from w_stampa`st_2 within w_st_studi_settore
end type

type sle_copie from w_stampa`sle_copie within w_st_studi_settore
end type

type sle_zoom from w_stampa`sle_zoom within w_st_studi_settore
end type

type cb_7 from w_stampa`cb_7 within w_st_studi_settore
end type

type cb_6 from w_stampa`cb_6 within w_st_studi_settore
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_studi_settore
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_studi_settore
end type

type cb_esci from w_stampa`cb_esci within w_st_studi_settore
end type

