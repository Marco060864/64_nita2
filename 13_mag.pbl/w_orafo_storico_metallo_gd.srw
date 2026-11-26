forward
global type w_orafo_storico_metallo_gd from w_np_single_data
end type
end forward

global type w_orafo_storico_metallo_gd from w_np_single_data
int Width=1906
int Height=836
boolean TitleBar=true
string Title="Storico Quotazioni Metallo"
end type
global w_orafo_storico_metallo_gd w_orafo_storico_metallo_gd

on w_orafo_storico_metallo_gd.create
call super::create
end on

on w_orafo_storico_metallo_gd.destroy
call super::destroy
end on

event open;call super::open;dw_single.retrieve()
end event

event resize;
end event

type p_crescente from w_np_single_data`p_crescente within w_orafo_storico_metallo_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_orafo_storico_metallo_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_orafo_storico_metallo_gd
int X=18
int Y=20
int Width=1829
string DataObject="d_orafo_storico_metallo_gd"
boolean HScrollBar=false
end type

