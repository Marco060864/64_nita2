forward
global type w_sog_commerciale_ritenute_sw from w_search_main
end type
end forward

global type w_sog_commerciale_ritenute_sw from w_search_main
end type
global w_sog_commerciale_ritenute_sw w_sog_commerciale_ritenute_sw

on w_sog_commerciale_ritenute_sw.create
call w_search_main::create
end on

on w_sog_commerciale_ritenute_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_sog_commerciale_ritenute_sw
string DataObject="d_sog_commerciale_ritenute_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("sog_commerciale_codice")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("anagrafica_rag_soc_1")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("anagrafica_rag_soc_2")
is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("anagrafica_par_iva")
is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("anagrafica_cod_fiscale")

end event

event dw_lista::ue_init;call super::ue_init;is_list.s_win_chiave[1] = "id_sog_commerciale"

end event

