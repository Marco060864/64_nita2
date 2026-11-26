forward
global type w_scadenza_sw from w_search_main
end type
end forward

global type w_scadenza_sw from w_search_main
end type
global w_scadenza_sw w_scadenza_sw

on w_scadenza_sw.create
call w_search_main::create
end on

on w_scadenza_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_scadenza_sw
string DataObject="d_scadenza_sw_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("vs_scadenza_saldo_data_scadenza")
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("vs_scadenza_saldo_id_scadenza")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("vs_scadenza_saldo_importo")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("vs_scadenza_saldo_tipo_scadenza")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("sog_commerciale_gen_codice")
is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("sog_commerciale_gen_rag_soc_1")
is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("vs_scadenza_saldo_saldo")

end event

