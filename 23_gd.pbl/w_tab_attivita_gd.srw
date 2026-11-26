forward
global type w_tab_attivita_gd from w_np_single_data
end type
end forward

global type w_tab_attivita_gd from w_np_single_data
int Width=2972
boolean TitleBar=true
string Title="Tabella Attività"
end type
global w_tab_attivita_gd w_tab_attivita_gd

on w_tab_attivita_gd.create
call w_np_single_data::create
end on

on w_tab_attivita_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 95

end event

type p_crescente from w_np_single_data`p_crescente within w_tab_attivita_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_tab_attivita_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_tab_attivita_gd
int Width=2858
string DataObject="d_tab_attivita_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Tabella Attività"
end event

