forward
global type w_par_oggetto_gd from w_np_single_data
end type
end forward

global type w_par_oggetto_gd from w_np_single_data
int Width=2729
end type
global w_par_oggetto_gd w_par_oggetto_gd

on w_par_oggetto_gd.create
call super::create
end on

on w_par_oggetto_gd.destroy
call super::destroy
end on

type dw_single from w_np_single_data`dw_single within w_par_oggetto_gd
int Width=2619
string DataObject="d_par_oggetto"
end type

