forward
global type w_aspetto_sw from w_search_main
end type
end forward

global type w_aspetto_sw from w_search_main
end type
global w_aspetto_sw w_aspetto_sw

on w_aspetto_sw.create
call super::create
end on

on w_aspetto_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_aspetto_sw
string DataObject="d_asp_beni_gd"
end type

event dw_lista::ue_init;

is_resp_window = "w_asp_beni_cx"
is_list.s_win_chiave[1] = "id_asp_beni"

end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("descrizione")


end event

type cb_nuovo from w_search_main`cb_nuovo within w_aspetto_sw
int X=325
end type

