forward
global type w_dich_iva_sc from w_search_main
end type
end forward

global type w_dich_iva_sc from w_search_main
end type
global w_dich_iva_sc w_dich_iva_sc

on w_dich_iva_sc.create
call super::create
end on

on w_dich_iva_sc.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_dich_iva_sc
string DataObject="d_dich_per_iva_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_dich_per_iva")
end event

