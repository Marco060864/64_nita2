forward
global type w_mod_registro_gd from w_np_single_data
end type
end forward

global type w_mod_registro_gd from w_np_single_data
int Width=2469
boolean TitleBar=true
string Title="Registri"
end type
global w_mod_registro_gd w_mod_registro_gd

on w_mod_registro_gd.create
call w_np_single_data::create
end on

on w_mod_registro_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 73

end event

type p_crescente from w_np_single_data`p_crescente within w_mod_registro_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_mod_registro_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_mod_registro_gd
int Width=2332
string DataObject="d_mod_registro_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Registri"
end event

