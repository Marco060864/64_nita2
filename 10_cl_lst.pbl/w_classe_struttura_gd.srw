forward
global type w_classe_struttura_gd from w_np_single_data
end type
end forward

global type w_classe_struttura_gd from w_np_single_data
int Width=1751
end type
global w_classe_struttura_gd w_classe_struttura_gd

on w_classe_struttura_gd.create
call super::create
end on

on w_classe_struttura_gd.destroy
call super::destroy
end on

type dw_single from w_np_single_data`dw_single within w_classe_struttura_gd
int Width=1632
string DataObject="d_classe_struttura_gd"
end type

event dw_single::rowfocuschanged;setrowfocusindicator(hand!)
end event

