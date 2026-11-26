forward
global type w_st_contropartite_sog_com from w_stampa_001
end type
end forward

global type w_st_contropartite_sog_com from w_stampa_001
integer x = 23
integer y = 12
end type
global w_st_contropartite_sog_com w_st_contropartite_sog_com

on w_st_contropartite_sog_com.create
call super::create
end on

on w_st_contropartite_sog_com.destroy
call super::destroy
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type dw_1 from w_stampa_001`dw_1 within w_st_contropartite_sog_com
string dataobject = "d_st_contropartite_sog_com"
end type

type sle_pg from w_stampa_001`sle_pg within w_st_contropartite_sog_com
end type

type st_1 from w_stampa_001`st_1 within w_st_contropartite_sog_com
end type

type st_2 from w_stampa_001`st_2 within w_st_contropartite_sog_com
end type

type sle_copie from w_stampa_001`sle_copie within w_st_contropartite_sog_com
end type

type sle_zoom from w_stampa_001`sle_zoom within w_st_contropartite_sog_com
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_st_contropartite_sog_com
end type

type cb_7 from w_stampa_001`cb_7 within w_st_contropartite_sog_com
end type

type cb_6 from w_stampa_001`cb_6 within w_st_contropartite_sog_com
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_st_contropartite_sog_com
end type

type cb_stampa from w_stampa_001`cb_stampa within w_st_contropartite_sog_com
end type

type cb_preview from w_stampa_001`cb_preview within w_st_contropartite_sog_com
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_st_contropartite_sog_com
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_st_contropartite_sog_com
end type

type cb_1 from w_stampa_001`cb_1 within w_st_contropartite_sog_com
end type

