forward
global type w_linguaggio_gd from w_np_single_data
end type
end forward

global type w_linguaggio_gd from w_np_single_data
int Width=1532
boolean TitleBar=true
string Title="Linguaggi"
end type
global w_linguaggio_gd w_linguaggio_gd

on w_linguaggio_gd.create
call w_np_single_data::create
end on

on w_linguaggio_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 387

end event

type p_crescente from w_np_single_data`p_crescente within w_linguaggio_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_linguaggio_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_linguaggio_gd
int Width=1418
string DataObject="d_linguaggio_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Linguaggi"
end event

