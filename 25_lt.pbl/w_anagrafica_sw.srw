forward
global type w_anagrafica_sw from w_search_main
end type
end forward

global type w_anagrafica_sw from w_search_main
int Width=2986
boolean TitleBar=true
string Title="Selezione Ragione Sociale"
end type
global w_anagrafica_sw w_anagrafica_sw

on w_anagrafica_sw.create
call w_search_main::create
end on

on w_anagrafica_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_anagrafica_sw
int Width=1418
int Height=581
string DataObject="d_anagrafica_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_anag_2_cx"
is_list.s_win_chiave[1] = "id_anagrafica"
end event

event dw_lista::ue_return_values;call super::ue_return_values;

is_ricpar.s_main_value = THIS.uf_get_colval("rag_soc_1")

is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_anagrafica")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("rag_soc_2")

is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("indirizzo")

is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("cap")

is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("localita")

is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("provincia")

is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("nazione")

is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("cod_fiscale")

is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("par_iva")

end event

