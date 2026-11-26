forward
global type u_tv_menu_button from UserObject
end type
type cb_delete from commandbutton within u_tv_menu_button
end type
type st_1 from statictext within u_tv_menu_button
end type
type cb_5 from commandbutton within u_tv_menu_button
end type
type cb_4 from commandbutton within u_tv_menu_button
end type
type cb_3 from commandbutton within u_tv_menu_button
end type
type cb_2 from commandbutton within u_tv_menu_button
end type
type cb_1 from commandbutton within u_tv_menu_button
end type
end forward

global type u_tv_menu_button from UserObject
int Width=1006
int Height=221
long BackColor=79741120
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=16777215
cb_delete cb_delete
st_1 st_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global u_tv_menu_button u_tv_menu_button

type variables
u_tv_menu		itv_tv

end variables

on u_tv_menu_button.create
this.cb_delete=create cb_delete
this.st_1=create st_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={ this.cb_delete,&
this.st_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on u_tv_menu_button.destroy
destroy(this.cb_delete)
destroy(this.st_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_delete from commandbutton within u_tv_menu_button
int X=366
int Y=121
int Width=389
int Height=69
int TabOrder=31
string Text="&Cancella voci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)
itv_tv.Event ue_delete_item()
SetPointer(Arrow!)
end event

type st_1 from statictext within u_tv_menu_button
int X=23
int Y=21
int Width=179
int Height=57
boolean Enabled=false
string Text="Livello:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_5 from commandbutton within u_tv_menu_button
int X=778
int Y=21
int Width=193
int Height=69
int TabOrder=30
string Text="&Tutti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;itv_tv.Event ue_draw_level(10)
end event

type cb_4 from commandbutton within u_tv_menu_button
int X=641
int Y=21
int Width=110
int Height=69
int TabOrder=40
string Text="&4"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;itv_tv.Event ue_draw_level(4)
end event

type cb_3 from commandbutton within u_tv_menu_button
int X=503
int Y=21
int Width=110
int Height=69
int TabOrder=50
string Text="&3"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;itv_tv.Event ue_draw_level(3)
end event

type cb_2 from commandbutton within u_tv_menu_button
int X=366
int Y=21
int Width=110
int Height=69
int TabOrder=20
string Text="&2"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;itv_tv.Event ue_draw_level(2)
end event

type cb_1 from commandbutton within u_tv_menu_button
int X=229
int Y=21
int Width=110
int Height=69
int TabOrder=10
string Text="&1"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;itv_tv.Event ue_draw_level(1)

end event

