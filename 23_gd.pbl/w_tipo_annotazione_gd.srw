forward
global type w_tipo_annotazione_gd from w_np_single_data
end type
end forward

global type w_tipo_annotazione_gd from w_np_single_data
int Width=2963
boolean TitleBar=true
string Title="Tipi di Annotazione"
end type
global w_tipo_annotazione_gd w_tipo_annotazione_gd

on w_tipo_annotazione_gd.create
call w_np_single_data::create
end on

on w_tipo_annotazione_gd.destroy
call w_np_single_data::destroy
end on

event open;call super::open;
il_HelpTopic = 81
end event

type p_crescente from w_np_single_data`p_crescente within w_tipo_annotazione_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_tipo_annotazione_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_tipo_annotazione_gd
int Width=2835
string DataObject="d_tipo_annotazione_gd"
end type

event dw_single::itemchanged;call super::itemchanged;is_title = "Tipi di Annotazione"
end event

