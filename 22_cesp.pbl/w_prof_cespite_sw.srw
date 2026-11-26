forward
global type w_prof_cespite_sw from w_search_main
end type
end forward

global type w_prof_cespite_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Cespiti"
end type
global w_prof_cespite_sw w_prof_cespite_sw

on w_prof_cespite_sw.create
call super::create
end on

on w_prof_cespite_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_prof_cespite_sw
string DataObject="d_prof_cespite_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_prof_cespite")
is_ricpar.s_main_value      = THIS.uf_get_colval("codice")
is_ricpar.s_ausil_value[1]  = THIS.uf_get_colval("descrizione")
end event

event dw_lista::ue_init;is_list.s_win_chiave[1] = "id_prof_cespite"
end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_prof_cespite_sw
boolean BringToTop=true
end type

