forward
global type w_blocca_saldi_gd from w_np_single_data
end type
end forward

global type w_blocca_saldi_gd from w_np_single_data
integer width = 3008
end type
global w_blocca_saldi_gd w_blocca_saldi_gd

type variables
string is_last_sort='D'
end variables

on w_blocca_saldi_gd.create
call super::create
end on

on w_blocca_saldi_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_blocca_saldi_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_blocca_saldi_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_blocca_saldi_gd
end type

type dw_single from w_np_single_data`dw_single within w_blocca_saldi_gd
integer x = 32
integer width = 2907
string title = "Blocca Saldi"
string dataobject = "d_saldo_verificato_gd"
end type

event dw_single::doubleclicked;call super::doubleclicked;string ls_etic



if left(dwo.name, 1)='t' then
	
	if is_last_sort = "D" then 	
		is_last_sort='A'
	else
		is_last_sort='D'
	end if
	ls_etic=right(string(dwo.name), len(string(dwo.name)) - 2) +" "+ is_last_sort +", fino_a_data" 
	setsort(ls_etic)
	sort()
end if
end event

