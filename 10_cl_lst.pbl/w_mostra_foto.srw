forward
global type w_mostra_foto from w_base
end type
type p_1 from picture within w_mostra_foto
end type
end forward

global type w_mostra_foto from w_base
integer width = 1993
integer height = 2268
p_1 p_1
end type
global w_mostra_foto w_mostra_foto

event resize;call super::resize;p_1.width=width - 100
p_1.height=height - 200
end event

on w_mostra_foto.create
int iCurrent
call super::create
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
end on

on w_mostra_foto.destroy
call super::destroy
destroy(this.p_1)
end on

event open;call super::open;string ls_file

ls_file=message.stringparm
if ls_file> " " then
		p_1.picturename=ls_file
end if
end event

type p_1 from picture within w_mostra_foto
integer x = 59
integer y = 44
integer width = 1806
integer height = 2036
boolean focusrectangle = false
end type

