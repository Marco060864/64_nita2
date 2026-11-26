forward
global type w_banca_sog_commerciale_gen_sw from w_search_main
end type
end forward

global type w_banca_sog_commerciale_gen_sw from w_search_main
int Width=2478
boolean TitleBar=true
string Title="Selezione Banca del Soggetto Commerciale"
end type
global w_banca_sog_commerciale_gen_sw w_banca_sog_commerciale_gen_sw

on w_banca_sog_commerciale_gen_sw.create
call w_search_main::create
end on

on w_banca_sog_commerciale_gen_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_banca_sog_commerciale_gen_sw
string DataObject="d_banca_sog_commerciale_gen_lt"
end type

event dw_lista::ue_init;call super::ue_init;
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("cc_den_abi_cab")
								
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_banca_sog_commerciale")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("conto_corrente")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("cin")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("cod_abi")
is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("den_abi")
is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("cod_cab")
is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("den_cab")


end event

