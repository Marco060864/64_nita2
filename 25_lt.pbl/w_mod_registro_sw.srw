forward
global type w_mod_registro_sw from w_search_main
end type
end forward

global type w_mod_registro_sw from w_search_main
boolean TitleBar=true
string Title="Selezione Modello Registro"
end type
global w_mod_registro_sw w_mod_registro_sw

on w_mod_registro_sw.create
call w_search_main::create
end on

on w_mod_registro_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_mod_registro_sw
string DataObject="d_mod_registro_lt"
end type

event dw_lista::ue_init;call super::ue_init;
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("mod_registro_descrizione")
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("mod_registro_id_mod_registro")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("mod_registro_tipo_registro")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("mod_registro_numero")
end event

type cb_modi from w_search_main`cb_modi within w_mod_registro_sw
boolean Enabled=false
end type

type cb_nuovo from w_search_main`cb_nuovo within w_mod_registro_sw
boolean Enabled=false
end type

