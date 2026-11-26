forward
global type w_wait from Window
end type
type st_wait_b from statictext within w_wait
end type
type st_wait from statictext within w_wait
end type
end forward

global type w_wait from Window
int X=1235
int Y=1041
int Width=1157
int Height=329
boolean TitleBar=true
string Title="Wait"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
string Icon="StopSign!"
st_wait_b st_wait_b
st_wait st_wait
end type
global w_wait w_wait

on w_wait.create
this.st_wait_b=create st_wait_b
this.st_wait=create st_wait
this.Control[]={ this.st_wait_b,&
this.st_wait}
end on

on w_wait.destroy
destroy(this.st_wait_b)
destroy(this.st_wait)
end on

event open;st_wait_b.Text = Message.StringParm
end event

type st_wait_b from statictext within w_wait
int X=161
int Y=121
int Width=887
int Height=77
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

type st_wait from statictext within w_wait
int X=161
int Y=41
int Width=883
int Height=61
boolean Enabled=false
string Text="Wait...Trasferimento Dati In corso..."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

