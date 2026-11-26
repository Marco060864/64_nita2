forward
global type w_splash from window
end type
type st_1 from statictext within w_splash
end type
type p_splash from picture within w_splash
end type
end forward

global type w_splash from window
integer x = 962
integer y = 614
integer width = 1668
integer height = 845
boolean enabled = false
boolean border = false
windowtype windowtype = popup!
long backcolor = 79741120
st_1 st_1
p_splash p_splash
end type
global w_splash w_splash

on w_splash.create
this.st_1=create st_1
this.p_splash=create p_splash
this.Control[]={this.st_1,&
this.p_splash}
end on

on w_splash.destroy
destroy(this.st_1)
destroy(this.p_splash)
end on

event open;long ll_screenh, ll_screenw
environment le_env

//p_splash.picturename = Message.StringParm
//p_splash.OriginalSize = true
//p_splash.x = 50
//p_splash.y = 50
//THIS.height = p_splash.height + 100
//THIS.width = p_splash.width + 100
u_freddie.center_window(THIS)

end event

type st_1 from statictext within w_splash
integer x = 208
integer y = 563
integer width = 1200
integer height = 214
integer textsize = -36
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "BankGothic Lt BT"
long textcolor = 1073741824
long backcolor = 553648127
string text = "NITATRON"
boolean focusrectangle = false
end type

type p_splash from picture within w_splash
integer x = 22
integer y = 22
integer width = 1616
integer height = 774
string picturename = "C:\nita\icone\nita.jpg"
boolean focusrectangle = false
end type

