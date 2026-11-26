forward
global type w_con_pagamento_gd from w_np_single_data
end type
end forward

global type w_con_pagamento_gd from w_np_single_data
int Width=2126
boolean TitleBar=true
string Title="Condizioni di Pagamento"
end type
global w_con_pagamento_gd w_con_pagamento_gd

on w_con_pagamento_gd.create
call w_np_single_data::create
end on

on w_con_pagamento_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_con_pagamento_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_con_pagamento_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_con_pagamento_gd
int Width=2012
string DataObject="d_con_pagamento_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Condizioni Pagamento"
end event

