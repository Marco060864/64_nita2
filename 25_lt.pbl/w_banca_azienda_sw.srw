forward
global type w_banca_azienda_sw from w_search_main
end type
end forward

global type w_banca_azienda_sw from w_search_main
end type
global w_banca_azienda_sw w_banca_azienda_sw

on w_banca_azienda_sw.create
call super::create
end on

on w_banca_azienda_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_banca_azienda_sw
string DataObject="d_banca_azienda_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_banca_azienda")
is_ricpar.s_main_value = THIS.uf_get_colval("banca_appoggio_den_abi")
								


is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("banca_appoggio_den_cab")

is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("banca_appoggio_cod_abi")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("banca_appoggio_cod_cab")

is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("banca_azienda_id_banca_appoggio") 
end event

