forward
global type w_tipo_pagamento_lt from w_list_main
end type
end forward

global type w_tipo_pagamento_lt from w_list_main
integer x = 46
integer y = 420
integer width = 3013
integer height = 1188
string title = "Tipi Pagamento"
end type
global w_tipo_pagamento_lt w_tipo_pagamento_lt

on w_tipo_pagamento_lt.create
call super::create
end on

on w_tipo_pagamento_lt.destroy
call super::destroy
end on

event open;call super::open;
il_HelpTopic = 99

ias_key_name[1] = "id_tipo_pagamento"
end event

type p_msg_log from w_list_main`p_msg_log within w_tipo_pagamento_lt
end type

type p_crescente from w_list_main`p_crescente within w_tipo_pagamento_lt
end type

type p_decrescente from w_list_main`p_decrescente within w_tipo_pagamento_lt
end type

type dw_list from w_list_main`dw_list within w_tipo_pagamento_lt
integer width = 2862
integer height = 940
string dataobject = "d_tipo_pagamento_lt"
end type

event dw_list::ue_init;call super::ue_init;is_resp_window = "w_tipo_pagamento_ff"
is_title = "Tipo Pagamento"
end event

