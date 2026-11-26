forward
global type w_pdc1cenr_sw from w_search_main
end type
end forward

global type w_pdc1cenr_sw from w_search_main
int Width=2300
boolean TitleBar=true
string Title="Ricerca"
boolean ControlMenu=true
end type
global w_pdc1cenr_sw w_pdc1cenr_sw

on w_pdc1cenr_sw.create
call w_search_main::create
end on

on w_pdc1cenr_sw.destroy
call w_search_main::destroy
end on

type cb_cerca from w_search_main`cb_cerca within w_pdc1cenr_sw
int X=1281
int Width=229
int Height=81
end type

type dw_lista from w_search_main`dw_lista within w_pdc1cenr_sw
int Width=1322
int Height=581
string DataObject="d_pdc1_1cen"
boolean HSplitScroll=true
end type

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = this.uf_get_colval("id_conto")

choose case is_ricpar.s_filter_name
	case "conto_codice"
		Is_ricpar.s_main_value= this.uf_get_colval("conto_codice")
		Is_ricpar.s_ausil_value[1]=this.uf_get_colval("conto_descrizione")
	case "conto_descrizione"
		Is_ricpar.s_main_value= this.uf_get_colval("conto_descrizione")
		Is_ricpar.s_ausil_value[1]=this.uf_get_colval("conto_codice")
end choose
		
end event

type sle_showsort from w_search_main`sle_showsort within w_pdc1cenr_sw
int Width=1340
end type

