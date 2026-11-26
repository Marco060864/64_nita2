forward
global type w_cat_int_cespite_sw from w_search_main
end type
end forward

global type w_cat_int_cespite_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Categoria Interna Cespite"
end type
global w_cat_int_cespite_sw w_cat_int_cespite_sw

on w_cat_int_cespite_sw.create
call w_search_main::create
end on

on w_cat_int_cespite_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_cat_int_cespite_sw
string DataObject="d_cat_int_cespite_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_list.s_win_chiave[1] = "cat_int_cespite_id_cat_int_cespite"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("cat_int_cespite_id_cat_int_cespite")
is_ricpar.s_main_value      = THIS.uf_get_colval("cat_int_cespite_codice")
is_ricpar.s_ausil_value[1]  = THIS.uf_get_colval("cat_int_cespite_descrizione")
is_ricpar.s_ausil_value[2]  = THIS.uf_get_colval("cat_int_cespite_perc_ammortamento")
end event

