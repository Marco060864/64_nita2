forward
global type w_conto1_sw from w_search_main
end type
end forward

global type w_conto1_sw from w_search_main
int X=1185
int Y=773
boolean TitleBar=true
string Title="Selezione Conto"
end type
global w_conto1_sw w_conto1_sw

on w_conto1_sw.create
call w_search_main::create
end on

on w_conto1_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_conto1_sw
string DataObject="d_conto1_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_conto_ff"
is_list.s_win_chiave[1] = "conto_id_conto"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = uf_get_colval("conto_id_conto")		

CHOOSE CASE is_ricpar.s_filter_name
	CASE "conto_descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("conto_descrizione")
END CHOOSE
			
end event

