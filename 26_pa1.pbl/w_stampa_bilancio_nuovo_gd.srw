forward
global type w_stampa_bilancio_nuovo_gd from w_stampa_001
end type
end forward

global type w_stampa_bilancio_nuovo_gd from w_stampa_001
end type
global w_stampa_bilancio_nuovo_gd w_stampa_bilancio_nuovo_gd

on w_stampa_bilancio_nuovo_gd.create
call super::create
end on

on w_stampa_bilancio_nuovo_gd.destroy
call super::destroy
end on

event open;call super::open;s_param ls_param
long ll_ap, ll_ch, ll_id_valuta



ls_param=message.powerobjectparm

select id_prof_reg_chiusura, id_prof_reg_apertura, id_valuta
into :ll_ch, :ll_ap, :ll_id_valuta from par_sistema;

if ls_param.tipo_stp="CONFRONTO" then
	dw_1.dataobject="d_bilancio_nuovo_confronto"
end if

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_param.data_in, ls_param.data_fin, ll_ap,ll_ch,ll_id_valuta)



end event

type dw_1 from w_stampa_001`dw_1 within w_stampa_bilancio_nuovo_gd
string dataobject = "d_bilancio_nuovo_economico"
end type

type sle_pg from w_stampa_001`sle_pg within w_stampa_bilancio_nuovo_gd
end type

type st_1 from w_stampa_001`st_1 within w_stampa_bilancio_nuovo_gd
end type

type st_2 from w_stampa_001`st_2 within w_stampa_bilancio_nuovo_gd
end type

type sle_copie from w_stampa_001`sle_copie within w_stampa_bilancio_nuovo_gd
end type

type sle_zoom from w_stampa_001`sle_zoom within w_stampa_bilancio_nuovo_gd
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_stampa_bilancio_nuovo_gd
end type

type cb_7 from w_stampa_001`cb_7 within w_stampa_bilancio_nuovo_gd
end type

type cb_6 from w_stampa_001`cb_6 within w_stampa_bilancio_nuovo_gd
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_stampa_bilancio_nuovo_gd
end type

type cb_stampa from w_stampa_001`cb_stampa within w_stampa_bilancio_nuovo_gd
end type

type cb_preview from w_stampa_001`cb_preview within w_stampa_bilancio_nuovo_gd
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_stampa_bilancio_nuovo_gd
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_stampa_bilancio_nuovo_gd
end type

type cb_1 from w_stampa_001`cb_1 within w_stampa_bilancio_nuovo_gd
end type

