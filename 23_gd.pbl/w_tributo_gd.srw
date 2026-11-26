forward
global type w_tributo_gd from w_np_single_data
end type
end forward

global type w_tributo_gd from w_np_single_data
int Width=2917
int Height=869
boolean TitleBar=true
string Title="Tributi"
end type
global w_tributo_gd w_tributo_gd

on w_tributo_gd.create
call w_np_single_data::create
end on

on w_tributo_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_tributo_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_tributo_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_tributo_gd
int Width=2789
string DataObject="d_tributo_gd"
end type

event dw_single::ue_validate_row;call super::ue_validate_row;if DaysAfter(GetItemDate(al_row, "inizio_per_validita"), GetItemDate(al_row, "fine_per_validita")) < 0 then
	as_error_text = "La data di inizio deve essere precedente alla data di fine."
	return 1
else
	return 0
end if
end event

event dw_single::ue_init;call super::ue_init;is_title = "Tributi"
end event

