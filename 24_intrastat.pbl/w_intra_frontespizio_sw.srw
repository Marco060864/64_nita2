forward
global type w_intra_frontespizio_sw from w_search_main
end type
end forward

global type w_intra_frontespizio_sw from w_search_main
int X=494
int Y=413
int Width=2711
int Height=1269
end type
global w_intra_frontespizio_sw w_intra_frontespizio_sw

on w_intra_frontespizio_sw.create
call w_search_main::create
end on

on w_intra_frontespizio_sw.destroy
call w_search_main::destroy
end on

type cb_cerca from w_search_main`cb_cerca within w_intra_frontespizio_sw
int X=2204
end type

type dw_lista from w_search_main`dw_lista within w_intra_frontespizio_sw
int X=275
int Y=285
int Width=2364
int Height=625
string DataObject="d_intra_frontespizio_input_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_i_fronte")
end event

type sle_showsort from w_search_main`sle_showsort within w_intra_frontespizio_sw
int X=275
int Y=933
end type

type cb_modi from w_search_main`cb_modi within w_intra_frontespizio_sw
int X=572
end type

type cb_nuovo from w_search_main`cb_nuovo within w_intra_frontespizio_sw
int X=275
end type

type cb_annulla from w_search_main`cb_annulla within w_intra_frontespizio_sw
int X=1212
end type

type cb_ok from w_search_main`cb_ok within w_intra_frontespizio_sw
int X=938
end type

type st_3 from w_search_main`st_3 within w_intra_frontespizio_sw
int X=14
int Y=321
end type

type sle_ricerca from w_search_main`sle_ricerca within w_intra_frontespizio_sw
int X=275
int Y=185
int Width=1541
end type

type sle_filtro from w_search_main`sle_filtro within w_intra_frontespizio_sw
int X=828
int Y=65
int Width=1276
end type

type st_2 from w_search_main`st_2 within w_intra_frontespizio_sw
int X=28
end type

type st_1 from w_search_main`st_1 within w_intra_frontespizio_sw
int X=23
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_intra_frontespizio_sw
int X=275
int Y=65
int Width=522
end type

