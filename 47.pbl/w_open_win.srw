forward
global type w_open_win from window
end type
type cb_annulla from commandbutton within w_open_win
end type
type cb_ok from commandbutton within w_open_win
end type
type st_sle_pwd_t from statictext within w_open_win
end type
type sle_pwd from singlelineedit within w_open_win
end type
end forward

global type w_open_win from window
integer x = 832
integer y = 360
integer width = 1248
integer height = 424
boolean titlebar = true
string title = "Prego inserire la Password"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
cb_annulla cb_annulla
cb_ok cb_ok
st_sle_pwd_t st_sle_pwd_t
sle_pwd sle_pwd
end type
global w_open_win w_open_win

on w_open_win.create
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
this.st_sle_pwd_t=create st_sle_pwd_t
this.sle_pwd=create sle_pwd
this.Control[]={this.cb_annulla,&
this.cb_ok,&
this.st_sle_pwd_t,&
this.sle_pwd}
end on

on w_open_win.destroy
destroy(this.cb_annulla)
destroy(this.cb_ok)
destroy(this.st_sle_pwd_t)
destroy(this.sle_pwd)
end on

type cb_annulla from commandbutton within w_open_win
integer x = 457
integer y = 180
integer width = 247
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
end type

event clicked;CloseWithReturn(Parent, "0")
end event

type cb_ok from commandbutton within w_open_win
integer x = 960
integer y = 184
integer width = 247
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&OK"
boolean default = true
end type

event clicked;CloseWithReturn(Parent, sle_pwd.Text)
end event

type st_sle_pwd_t from statictext within w_open_win
integer x = 50
integer y = 60
integer width = 384
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Nome Menu - "
boolean focusrectangle = false
end type

type sle_pwd from singlelineedit within w_open_win
integer x = 457
integer y = 48
integer width = 750
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

