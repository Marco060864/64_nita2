forward
global type w_cif_coddes_sw from w_search_main
end type
end forward

global type w_cif_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca CIF"
end type
global w_cif_coddes_sw w_cif_coddes_sw

on w_cif_coddes_sw.create
call w_search_main::create
end on

on w_cif_coddes_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_cif_coddes_sw
string DataObject="d_cif_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;

is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_cif")





end event

event dw_lista::ue_init;call super::ue_init;
end event

