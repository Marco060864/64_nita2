forward
global type w_001 from window
end type
type st_1 from statictext within w_001
end type
end forward

global type w_001 from window
integer x = 1057
integer y = 483
integer width = 3105
integer height = 1581
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = child!
long backcolor = 79741120
event ue_postopen ( )
st_1 st_1
end type
global w_001 w_001

event ue_postopen();//
end event

on w_001.create
this.st_1=create st_1
this.Control[]={this.st_1}
end on

on w_001.destroy
destroy(this.st_1)
end on

event rbuttondown;messagebox("Informazioni!", ClassName())
end event

event timer;st_1.visible=false
end event

event open;st_1.visible=false

post event ue_postopen()
end event

type st_1 from statictext within w_001
boolean visible = false
integer x = 18
integer y = 26
integer width = 581
integer height = 67
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

