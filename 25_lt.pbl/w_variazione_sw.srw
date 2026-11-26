forward
global type w_variazione_sw from w_search_main
end type
end forward

global type w_variazione_sw from w_search_main
boolean TitleBar=true
string Title="Selezione Date Variazione"
end type
global w_variazione_sw w_variazione_sw

on w_variazione_sw.create
call w_search_main::create
end on

on w_variazione_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_variazione_sw
string DataObject="d_variazione_lt"
end type

event dw_lista::ue_init;call super::ue_init;
end event

event dw_lista::ue_return_values;call super::ue_return_values;String 		ls_main_value

is_ricpar.s_id_seg_value[1] = uf_get_colval("variazione_id_variazione")		
CHOOSE CASE is_ricpar.s_filter_name
	CASE "variazione_data_inizio"
		IF IsNull(THIS.uf_get_colval("variazione_data_fine")) THEN
			
			
			ls_main_value = THIS.uf_get_colval("variazione_data_inizio")+ " -"
		ELSE
			IF IsNull(THIS.uf_get_colval("variazione_data_inizio")) THEN
				ls_main_value = " - " + THIS.uf_get_colval("variazione_data_fine")
			ELSE
				ls_main_value = THIS.uf_get_colval("variazione_data_inizio") +&
							    " - " + THIS.uf_get_colval("variazione_data_fine")
			END IF
		END IF
		is_ricpar.s_main_value = ls_main_value
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("variazione_data_inizio")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("variazione_data_fine")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("variazione_cambio")
END CHOOSE
			
end event

