forward
global type w_ric_articolo_cf_sw from w_search_main
end type
end forward

global type w_ric_articolo_cf_sw from w_search_main
end type
global w_ric_articolo_cf_sw w_ric_articolo_cf_sw

on w_ric_articolo_cf_sw.create
call super::create
end on

on w_ric_articolo_cf_sw.destroy
call super::destroy
end on

type cb_cerca from w_search_main`cb_cerca within w_ric_articolo_cf_sw
end type

type dw_lista from w_search_main`dw_lista within w_ric_articolo_cf_sw
integer width = 1184
string dataobject = "d_ricerca_art_cf_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_articolo")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("des_articolo_codice")
	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("des_articolo_codice")
	CASE "des_articolo_codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("des_articolo_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("descrizione")
END CHOOSE

end event

event dw_lista::ue_init;is_resp_window = "w_orafo_articolo_cx"
				
is_list.s_win_chiave[1] = "id_articolo"
end event

type sle_showsort from w_search_main`sle_showsort within w_ric_articolo_cf_sw
end type

type cb_modi from w_search_main`cb_modi within w_ric_articolo_cf_sw
end type

type cb_nuovo from w_search_main`cb_nuovo within w_ric_articolo_cf_sw
end type

type cb_annulla from w_search_main`cb_annulla within w_ric_articolo_cf_sw
end type

type cb_ok from w_search_main`cb_ok within w_ric_articolo_cf_sw
end type

type st_3 from w_search_main`st_3 within w_ric_articolo_cf_sw
end type

type sle_ricerca from w_search_main`sle_ricerca within w_ric_articolo_cf_sw
end type

type sle_filtro from w_search_main`sle_filtro within w_ric_articolo_cf_sw
end type

type st_2 from w_search_main`st_2 within w_ric_articolo_cf_sw
end type

type st_1 from w_search_main`st_1 within w_ric_articolo_cf_sw
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_ric_articolo_cf_sw
end type

