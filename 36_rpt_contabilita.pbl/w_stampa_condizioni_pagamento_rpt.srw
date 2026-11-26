forward
global type w_stampa_condizioni_pagamento_rpt from w_p_data
end type
type dw_3 from u_dw_master_main within w_stampa_condizioni_pagamento_rpt
end type
type dw_1 from u_dw_master_main within w_stampa_condizioni_pagamento_rpt
end type
end forward

global type w_stampa_condizioni_pagamento_rpt from w_p_data
dw_3 dw_3
dw_1 dw_1
end type
global w_stampa_condizioni_pagamento_rpt w_stampa_condizioni_pagamento_rpt

event open;call super::open;
idw_master=dw_3
idw_master.is_list=Message.PowerObjectParm
IF UpperBound(idw_master.is_list.s_identifica) = 0 then
	     idw_master.ias_key_name[1] ="id_con_pagamento"
		  idw_master.is_list.s_modo = modo_inserisci
	END IF
	idw_master.ib_use_scanner=true
	idw_master.is_list.s_sql_ident[1]="id_con_pagamento"
	ib_nonmodale=true
end event

on w_stampa_condizioni_pagamento_rpt.create
int iCurrent
call w_p_data::create
this.dw_3=create dw_3
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_3
this.Control[iCurrent+2]=dw_1
end on

on w_stampa_condizioni_pagamento_rpt.destroy
call w_p_data::destroy
destroy(this.dw_3)
destroy(this.dw_1)
end on

type tab_1 from w_p_data`tab_1 within w_stampa_condizioni_pagamento_rpt
int Width=229
int Height=241
boolean Visible=false
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int Y=17
int Width=193
int Height=209
boolean Visible=false
long BackColor=79741120
long TabBackColor=79741120
end type

type dw_3 from u_dw_master_main within w_stampa_condizioni_pagamento_rpt
int X=69
int Y=261
int Width=1943
int Height=461
int TabOrder=10
string DataObject="d_app_pagamento_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_con_pagamento"
iudw_children[1]=dw_1
end event

event ue_set_search;call super::ue_set_search;choose case as_nomecol
	case "num_ordine"
		Is_search_window="w_cond_pagamento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name= "num_ordine"
		is_ricpar.b_imm_retrieve = true
end choose
end event

event ue_use_search;call super::ue_use_search;choose case as_nomecol
	case "num ordine"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_con_pagamento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("id_con_pagamento",is_ricpar.s_ausil_value[1])
end choose
end event

type dw_1 from u_dw_master_main within w_stampa_condizioni_pagamento_rpt
int X=69
int Y=821
int Width=1943
int Height=641
int TabOrder=3
string DataObject="d_con_pagamento_lt"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1]="id_con_pagamento"
is_list.s_win_chiave[1]="id_con_pagamento"
end event

