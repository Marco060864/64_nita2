forward
global type w_wizard_lt from w_list_main
end type
end forward

global type w_wizard_lt from w_list_main
int Width=2657
boolean TitleBar=true
string Title="Wizard"
end type
global w_wizard_lt w_wizard_lt

on w_wizard_lt.create
call w_list_main::create
end on

on w_wizard_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;ias_key_name[1] = "id_wizard"
end event

type dw_list from w_list_main`dw_list within w_wizard_lt
int Width=2538
string DataObject="d_wizard_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Wizard"
is_resp_window = "w_wizard_cx"
end event

