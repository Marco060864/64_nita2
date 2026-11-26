forward
global type w_mail_configurazione_gd from w_np_single_data
end type
end forward

global type w_mail_configurazione_gd from w_np_single_data
integer width = 3977
end type
global w_mail_configurazione_gd w_mail_configurazione_gd

on w_mail_configurazione_gd.create
call super::create
end on

on w_mail_configurazione_gd.destroy
call super::destroy
end on

type p_msg_log from w_np_single_data`p_msg_log within w_mail_configurazione_gd
end type

type p_crescente from w_np_single_data`p_crescente within w_mail_configurazione_gd
end type

type p_decrescente from w_np_single_data`p_decrescente within w_mail_configurazione_gd
end type

type dw_single from w_np_single_data`dw_single within w_mail_configurazione_gd
integer width = 3858
string dataobject = "d_mail_configurazione"
end type

event dw_single::itemchanged;call super::itemchanged;integer i
if dwo.name='base' then
	if data='S' then
		for i= 1 to rowcount()
			if i<> row then
				if getitemstring(i, "base")='S' then
					setitem(i, "base", "N")
				end if
			end if
		next
	end if
end if
end event

