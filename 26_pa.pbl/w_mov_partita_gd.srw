forward
global type w_mov_partita_gd from w_np_single_data
end type
end forward

global type w_mov_partita_gd from w_np_single_data
int Width=737
boolean TitleBar=true
string Title="Movimenti Partite"
end type
global w_mov_partita_gd w_mov_partita_gd

on w_mov_partita_gd.create
call w_np_single_data::create
end on

on w_mov_partita_gd.destroy
call w_np_single_data::destroy
end on

type dw_single from w_np_single_data`dw_single within w_mov_partita_gd
int Width=618
string DataObject="d_mov_partita_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Movimenti Partite"
end event

