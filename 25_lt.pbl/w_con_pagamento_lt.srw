forward
global type w_con_pagamento_lt from w_list_main
end type
end forward

global type w_con_pagamento_lt from w_list_main
int Width=2122
boolean TitleBar=true
string Title="Condizioni Pagamento"
end type
global w_con_pagamento_lt w_con_pagamento_lt

on w_con_pagamento_lt.create
call w_list_main::create
end on

on w_con_pagamento_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;
il_HelpTopic = 100

ias_key_name[1] = "id_con_pagamento"
end event

type p_crescente from w_list_main`p_crescente within w_con_pagamento_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_con_pagamento_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_con_pagamento_lt
int Width=1989
string DataObject="d_con_pagamento_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "con_pagamento"
is_resp_window = "w_con_pagamento_cx"
end event

