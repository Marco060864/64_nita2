forward
global type w_sog_commerciale_ritenute_lt from w_list_main
end type
end forward

global type w_sog_commerciale_ritenute_lt from w_list_main
int Height=993
boolean TitleBar=true
string Title="Ritenute dei Soggetti Commerciali"
end type
global w_sog_commerciale_ritenute_lt w_sog_commerciale_ritenute_lt

event open;call super::open;il_HelpTopic = 33

ias_key_name[1] = "id_sog_commerciale"
idw_master = dw_list
idw_master.is_list = Message.PowerObjectParm

end event

on w_sog_commerciale_ritenute_lt.create
call w_list_main::create
end on

on w_sog_commerciale_ritenute_lt.destroy
call w_list_main::destroy
end on

type p_crescente from w_list_main`p_crescente within w_sog_commerciale_ritenute_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_sog_commerciale_ritenute_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_sog_commerciale_ritenute_lt
int Width=2492
int Height=801
string DataObject="d_sog_commerciale_ritenute_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Ritenute dei Soggetti Commerciali"
is_resp_window = "w_sog_commerciale_ritenute_cx"

end event

