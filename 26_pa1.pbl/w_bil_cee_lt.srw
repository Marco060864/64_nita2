forward
global type w_bil_cee_lt from w_np_single_data
end type
end forward

global type w_bil_cee_lt from w_np_single_data
int X=133
int Y=49
int Width=3434
int Height=1337
boolean TitleBar=true
string Title="Bilancio Cee"
WindowState WindowState=maximized!
end type
global w_bil_cee_lt w_bil_cee_lt

on w_bil_cee_lt.create
call w_np_single_data::create
end on

on w_bil_cee_lt.destroy
call w_np_single_data::destroy
end on

event ue_post_open;call super::ue_post_open;dw_single.height=(this.height) - 176
end event

type dw_single from w_np_single_data`dw_single within w_bil_cee_lt
int Width=3315
int Height=1161
string DataObject="d_bil_cee_lt"
end type

