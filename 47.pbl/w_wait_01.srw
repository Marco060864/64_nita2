forward
global type w_wait_01 from Window
end type
type st_wait_b from statictext within w_wait_01
end type
type st_wait from statictext within w_wait_01
end type
end forward

global type w_wait_01 from Window
int X=1234
int Y=1040
int Width=1755
int Height=328
boolean TitleBar=true
string Title="Attendere..."
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
string Icon="Information!"
st_wait_b st_wait_b
st_wait st_wait
end type
global w_wait_01 w_wait_01

on w_wait_01.create
this.st_wait_b=create st_wait_b
this.st_wait=create st_wait
this.Control[]={this.st_wait_b,&
this.st_wait}
end on

on w_wait_01.destroy
destroy(this.st_wait_b)
destroy(this.st_wait)
end on

event open;st_wait_b.Text = Message.StringParm
end event

type st_wait_b from statictext within w_wait_01
int X=160
int Y=120
int Width=1490
int Height=76
boolean Enabled=false
string Text="......................"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_wait from statictext within w_wait_01
int X=160
int Y=40
int Width=1490
int Height=60
boolean Enabled=false
string Text="Elaborazione in corso"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

