forward
global type w_orafo_titolo_gd from w_np_single_data
end type
end forward

global type w_orafo_titolo_gd from w_np_single_data
end type
global w_orafo_titolo_gd w_orafo_titolo_gd

on w_orafo_titolo_gd.create
call w_np_single_data::create
end on

on w_orafo_titolo_gd.destroy
call w_np_single_data::destroy
end on

type dw_single from w_np_single_data`dw_single within w_orafo_titolo_gd
string DataObject="d_orafo_titolo_gd"
end type

