forward
global type w_par_let_utenti from w_np_single_data
end type
end forward

global type w_par_let_utenti from w_np_single_data
int Width=1888
boolean TitleBar=true
string Title="Associazione Lettori a Barre / Utenti"
long BackColor=80133307
end type
global w_par_let_utenti w_par_let_utenti

on w_par_let_utenti.create
call super::create
end on

on w_par_let_utenti.destroy
call super::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_par_let_utenti
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_par_let_utenti
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_par_let_utenti
int Width=1746
string DataObject="d_par_let_utenti"
end type

