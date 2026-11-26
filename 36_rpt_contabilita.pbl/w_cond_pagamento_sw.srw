forward
global type w_cond_pagamento_sw from w_search_main
end type
end forward

global type w_cond_pagamento_sw from w_search_main
int Width=2986
boolean TitleBar=true
string Title="Selezione Ragione Sociale"
end type
global w_cond_pagamento_sw w_cond_pagamento_sw

on w_cond_pagamento_sw.create
call w_search_main::create
end on

on w_cond_pagamento_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_cond_pagamento_sw
int Width=1418
int Height=581
string DataObject="d_pagamento_ff"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_stampa_condizioni_pagamento_rpt"
is_list.s_win_chiave[1] = "id_con_pagamento"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1]= this.uf_get_colval("id_con_pagamento")
end event

