forward
global type w_ricalcolo_riepilogo_wz from w_wiz_main
end type
type cb_ricalcola from commandbutton within w_ricalcolo_riepilogo_wz
end type
type st_1 from statictext within w_ricalcolo_riepilogo_wz
end type
type st_2 from statictext within w_ricalcolo_riepilogo_wz
end type
type st_3 from statictext within w_ricalcolo_riepilogo_wz
end type
type st_4 from statictext within w_ricalcolo_riepilogo_wz
end type
end forward

global type w_ricalcolo_riepilogo_wz from w_wiz_main
int Width=1609
int Height=424
WindowType WindowType=popup!
boolean TitleBar=true
string Title="Ricalcolo riepiloghi dei movimenti di magazzino"
boolean MaxBox=false
boolean Resizable=false
cb_ricalcola cb_ricalcola
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type
global w_ricalcolo_riepilogo_wz w_ricalcolo_riepilogo_wz

type prototypes

end prototypes

type variables
w_wait_01	iw_wait
end variables

on w_ricalcolo_riepilogo_wz.create
int iCurrent
call super::create
this.cb_ricalcola=create cb_ricalcola
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ricalcola
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_4
end on

on w_ricalcolo_riepilogo_wz.destroy
call super::destroy
destroy(this.cb_ricalcola)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

type cb_ricalcola from commandbutton within w_ricalcolo_riepilogo_wz
int X=640
int Y=28
int Width=279
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="&Ricalcola"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
time lt_i, lt_f

open(iw_wait,"w_wait_01")

iw_wait.st_wait.text = "Ricalcolo riepiloghi dei movimenti"
iw_wait.st_wait_b.text = ""

lt_i = Now()
st_3.text = string(lt_i)
SQLCA.sp_ricalcolo_riepilogo()
lt_f = Now()
st_4.text = string(lt_f)

close(iw_wait)
end event

type st_1 from statictext within w_ricalcolo_riepilogo_wz
int X=169
int Y=160
int Width=165
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Inizio:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_ricalcolo_riepilogo_wz
int X=942
int Y=160
int Width=133
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Fine:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_ricalcolo_riepilogo_wz
int X=343
int Y=160
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_ricalcolo_riepilogo_wz
int X=1083
int Y=160
int Width=334
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

