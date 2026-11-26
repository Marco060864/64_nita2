forward
global type w_esercizio_sw from w_search_main
end type
end forward

global type w_esercizio_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Esercizio"
end type
global w_esercizio_sw w_esercizio_sw

on w_esercizio_sw.create
call w_search_main::create
end on

on w_esercizio_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_esercizio_sw
int Width=1189
int Height=581
string DataObject="d_esercizio_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;


is_ricpar.s_main_value = THIS.uf_get_colval("codice")
								
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_esercizio")
is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("data_inizio")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("data_fine")
end event

type cb_modi from w_search_main`cb_modi within w_esercizio_sw
boolean Visible=false
end type

type cb_nuovo from w_search_main`cb_nuovo within w_esercizio_sw
boolean Visible=false
end type

