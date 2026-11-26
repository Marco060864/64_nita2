forward
global type w_tab_ali_dich_per from w_np_single_data
end type
end forward

global type w_tab_ali_dich_per from w_np_single_data
int Width=1920
boolean TitleBar=true
string Title="Tabella raffronto Aliquote"
end type
global w_tab_ali_dich_per w_tab_ali_dich_per

on w_tab_ali_dich_per.create
call super::create
end on

on w_tab_ali_dich_per.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_tab_ali_dich_per
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_tab_ali_dich_per
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_tab_ali_dich_per
int Width=1806
string DataObject="d_tab_ali_dich_per"
end type

