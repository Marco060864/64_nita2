forward
global type w_par_disponibilita_sw from w_search_main
end type
end forward

global type w_par_disponibilita_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca parametri di disponibilità"
end type
global w_par_disponibilita_sw w_par_disponibilita_sw

on w_par_disponibilita_sw.create
call w_search_main::create
end on

on w_par_disponibilita_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_par_disponibilita_sw
string DataObject="d_par_disponibilita_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_par_disponibilita")


end event

