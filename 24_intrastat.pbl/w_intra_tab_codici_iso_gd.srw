forward
global type w_intra_tab_codici_iso_gd from w_np_single_data
end type
end forward

global type w_intra_tab_codici_iso_gd from w_np_single_data
int X=800
int Width=1737
int Height=812
boolean TitleBar=true
string Title="Tabella Codici Iso"
end type
global w_intra_tab_codici_iso_gd w_intra_tab_codici_iso_gd

event open;call super::open;
il_HelpTopic = 67
end event

on w_intra_tab_codici_iso_gd.create
call super::create
end on

on w_intra_tab_codici_iso_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_intra_tab_codici_iso_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_intra_tab_codici_iso_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_intra_tab_codici_iso_gd
int X=27
int Y=16
int Width=1664
string DataObject="d_intra_tab_codici_iso_gd"
end type

