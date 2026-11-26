forward
global type w_or_stampa_parametri_gd from w_np_single_data
end type
end forward

global type w_or_stampa_parametri_gd from w_np_single_data
end type
global w_or_stampa_parametri_gd w_or_stampa_parametri_gd

on w_or_stampa_parametri_gd.create
call super::create
end on

on w_or_stampa_parametri_gd.destroy
call super::destroy
end on

type dw_single from w_np_single_data`dw_single within w_or_stampa_parametri_gd
string DataObject="d_or_stampa_parametri_gd"
end type

