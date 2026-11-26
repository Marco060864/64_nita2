forward
global type w_duplica_articoli_gd from w_np_single_data
end type
end forward

global type w_duplica_articoli_gd from w_np_single_data
int Width=1888
int Height=856
boolean TitleBar=true
string Title="Tabella dei Coefficienti di Conversione da Titolo a Titolo"
end type
global w_duplica_articoli_gd w_duplica_articoli_gd

on w_duplica_articoli_gd.create
call super::create
end on

on w_duplica_articoli_gd.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_duplica_articoli_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_duplica_articoli_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_duplica_articoli_gd
int X=55
int Width=1733
string DataObject="d_duplica_articoli"
end type

