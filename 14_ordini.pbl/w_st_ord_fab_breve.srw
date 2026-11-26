forward
global type w_st_ord_fab_breve from w_stampa
end type
end forward

global type w_st_ord_fab_breve from w_stampa
end type
global w_st_ord_fab_breve w_st_ord_fab_breve

on w_st_ord_fab_breve.create
call super::create
end on

on w_st_ord_fab_breve.destroy
call super::destroy
end on

type pb_1 from w_stampa`pb_1 within w_st_ord_fab_breve
end type

type cb_preview from w_stampa`cb_preview within w_st_ord_fab_breve
end type

type dw_1 from w_stampa`dw_1 within w_st_ord_fab_breve
string dataobject = "d_ordini_fab_breve_tb"
end type

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_st_ord_fab_breve
end type

type pb_stampa from w_stampa`pb_stampa within w_st_ord_fab_breve
end type

type sle_pg from w_stampa`sle_pg within w_st_ord_fab_breve
end type

type st_1 from w_stampa`st_1 within w_st_ord_fab_breve
end type

type st_2 from w_stampa`st_2 within w_st_ord_fab_breve
end type

type sle_copie from w_stampa`sle_copie within w_st_ord_fab_breve
end type

type sle_zoom from w_stampa`sle_zoom within w_st_ord_fab_breve
end type

type cb_7 from w_stampa`cb_7 within w_st_ord_fab_breve
end type

type cb_6 from w_stampa`cb_6 within w_st_ord_fab_breve
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_st_ord_fab_breve
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_st_ord_fab_breve
end type

type cb_esci from w_stampa`cb_esci within w_st_ord_fab_breve
end type

