forward
global type w_mod_cometa_gd from w_mod_single_data
end type
end forward

global type w_mod_cometa_gd from w_mod_single_data
end type
global w_mod_cometa_gd w_mod_cometa_gd

on w_mod_cometa_gd.create
call w_mod_single_data::create
end on

on w_mod_cometa_gd.destroy
call w_mod_single_data::destroy
end on

type p_crescente from w_mod_single_data`p_crescente within w_mod_cometa_gd
boolean BringToTop=true
end type

type p_decrescente from w_mod_single_data`p_decrescente within w_mod_cometa_gd
boolean BringToTop=true
end type

type dw_single from w_mod_single_data`dw_single within w_mod_cometa_gd
int TabOrder=50
end type

type cb_ok from w_mod_single_data`cb_ok within w_mod_cometa_gd
int TabOrder=0
boolean BringToTop=true
end type

type cb_annulla from w_mod_single_data`cb_annulla within w_mod_cometa_gd
int TabOrder=0
boolean BringToTop=true
end type

type cb_inserisci from w_mod_single_data`cb_inserisci within w_mod_cometa_gd
int TabOrder=0
boolean BringToTop=true
end type

type cb_cancella from w_mod_single_data`cb_cancella within w_mod_cometa_gd
int TabOrder=0
boolean BringToTop=true
end type

type cb_salva from w_mod_single_data`cb_salva within w_mod_cometa_gd
int TabOrder=0
boolean BringToTop=true
end type

