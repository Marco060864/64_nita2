forward
global type w_con_pagamento_sw from w_search_main
end type
end forward

global type w_con_pagamento_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Condizioni Pagamento"
end type
global w_con_pagamento_sw w_con_pagamento_sw

on w_con_pagamento_sw.create
call super::create
end on

on w_con_pagamento_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_con_pagamento_sw
string DataObject="d_con_pagamento_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_con_pagamento_cx"
is_list.s_win_chiave[1] = "id_con_pagamento"
end event

event dw_lista::ue_return_values;call super::ue_return_values;
CHOOSE CASE is_ricpar.s_filter_name
	CASE "codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")		
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")		
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_con_pagamento")
		
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("sconto_cassa")		
	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")			
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")				
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_con_pagamento")
END CHOOSE




end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_con_pagamento_sw
int X=325
end type

