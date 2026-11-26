forward
global type w_prof_prezzo_documento_gd from w_np_single_data
end type
end forward

global type w_prof_prezzo_documento_gd from w_np_single_data
int Width=2167
boolean TitleBar=true
string Title="Valori da proporre in Variazione Prezzo"
end type
global w_prof_prezzo_documento_gd w_prof_prezzo_documento_gd

on w_prof_prezzo_documento_gd.create
call super::create
end on

on w_prof_prezzo_documento_gd.destroy
call super::destroy
end on

type dw_single from w_np_single_data`dw_single within w_prof_prezzo_documento_gd
int X=27
int Width=2071
string DataObject="d_prof_prezzo_documento"
end type

