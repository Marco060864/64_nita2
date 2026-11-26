forward
global type w_locazione_sw from w_search_main
end type
end forward

global type w_locazione_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Locazione"
end type
global w_locazione_sw w_locazione_sw

on w_locazione_sw.create
call w_search_main::create
end on

on w_locazione_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_locazione_sw
string DataObject="d_locazione_mag_lt"
end type

event dw_lista::ue_init;call super::ue_init;
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("cc_locazione_mag")
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("locazione_id_locazione")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("locazione_id_magazzino")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("area_descrizione")

end event

