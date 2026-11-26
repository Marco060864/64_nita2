forward
global type w_intra_frontespizio_input_sw from w_search_main
end type
end forward

global type w_intra_frontespizio_input_sw from w_search_main
int X=494
int Y=412
int Width=1934
int Height=1268
boolean TitleBar=true
string Title="Frontespizio per la duplicazione"
end type
global w_intra_frontespizio_input_sw w_intra_frontespizio_input_sw

on w_intra_frontespizio_input_sw.create
call super::create
end on

on w_intra_frontespizio_input_sw.destroy
call super::destroy
end on

type cb_cerca from w_search_main`cb_cerca within w_intra_frontespizio_input_sw
int X=1563
int Y=184
end type

type dw_lista from w_search_main`dw_lista within w_intra_frontespizio_input_sw
int X=274
int Y=284
int Width=1541
int Height=624
string DataObject="d_intra_frontespizio_input_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_i_fronte")

end event

type sle_showsort from w_search_main`sle_showsort within w_intra_frontespizio_input_sw
int X=274
int Y=932
int Width=1541
end type

type cb_modi from w_search_main`cb_modi within w_intra_frontespizio_input_sw
int X=571
end type

type cb_nuovo from w_search_main`cb_nuovo within w_intra_frontespizio_input_sw
int X=274
end type

type cb_annulla from w_search_main`cb_annulla within w_intra_frontespizio_input_sw
int X=1568
end type

type cb_ok from w_search_main`cb_ok within w_intra_frontespizio_input_sw
int X=1271
end type

type st_3 from w_search_main`st_3 within w_intra_frontespizio_input_sw
int X=14
int Y=320
end type

type sle_ricerca from w_search_main`sle_ricerca within w_intra_frontespizio_input_sw
int X=274
int Y=184
int Width=1248
end type

type sle_filtro from w_search_main`sle_filtro within w_intra_frontespizio_input_sw
int X=827
int Y=64
int Width=992
end type

type st_2 from w_search_main`st_2 within w_intra_frontespizio_input_sw
int X=27
end type

type st_1 from w_search_main`st_1 within w_intra_frontespizio_input_sw
int X=23
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_intra_frontespizio_input_sw
int X=274
int Y=64
int Width=521
boolean BringToTop=true
string Item[]={"Inizia per",&
"Contiene",&
"Termina per"}
end type

