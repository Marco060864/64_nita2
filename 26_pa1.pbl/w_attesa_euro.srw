forward
global type w_attesa_euro from Window
end type
type p_1 from picture within w_attesa_euro
end type
end forward

global type w_attesa_euro from Window
int X=833
int Y=361
int Width=590
int Height=581
boolean TitleBar=true
string Title="Untitled"
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
p_1 p_1
end type
global w_attesa_euro w_attesa_euro

on w_attesa_euro.create
this.p_1=create p_1
this.Control[]={ this.p_1}
end on

on w_attesa_euro.destroy
destroy(this.p_1)
end on

type p_1 from picture within w_attesa_euro
int Width=549
int Height=481
string PictureName="c:\windows\desktop\euro\meuro.bmp"
boolean FocusRectangle=false
end type

