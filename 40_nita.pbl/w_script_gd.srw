forward
global type w_script_gd from w_p_single_data
end type
end forward

global type w_script_gd from w_p_single_data
int Width=3223
int Height=1141
WindowType WindowType=main!
boolean TitleBar=true
string Title="Script"
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_script_gd w_script_gd

on w_script_gd.create
call w_p_single_data::create
end on

on w_script_gd.destroy
call w_p_single_data::destroy
end on

event open;call super::open;
dw_single.insertrow(1)
dw_single.settransobject(sqlca)
dw_single.retrieve()
end event

type p_crescente from w_p_single_data`p_crescente within w_script_gd
boolean BringToTop=true
end type

type p_decrescente from w_p_single_data`p_decrescente within w_script_gd
boolean BringToTop=true
end type

type dw_single from w_p_single_data`dw_single within w_script_gd
int Y=41
int Width=3159
int Height=973
string DataObject="d_script_gd"
boolean Border=true
BorderStyle BorderStyle=StyleBox!
boolean HScrollBar=true
boolean VScrollBar=true
end type

event dw_single::ue_init;call super::ue_init;is_title='script'
end event

type cb_ok from w_p_single_data`cb_ok within w_script_gd
boolean Visible=false
boolean BringToTop=true
end type

type cb_nuovo from w_p_single_data`cb_nuovo within w_script_gd
boolean Visible=false
boolean BringToTop=true
end type

type cb_annulla from w_p_single_data`cb_annulla within w_script_gd
boolean Visible=false
boolean BringToTop=true
end type

