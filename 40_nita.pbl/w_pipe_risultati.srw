forward
global type w_pipe_risultati from Window
end type
type st_re from statictext within w_pipe_risultati
end type
type st_rw from statictext within w_pipe_risultati
end type
type st_rr from statictext within w_pipe_risultati
end type
type dw_pipe_errors from datawindow within w_pipe_risultati
end type
end forward

global type w_pipe_risultati from Window
int X=833
int Y=361
int Width=1998
int Height=1209
boolean Visible=false
boolean TitleBar=true
string Title="Monitoraggio risultati della pipeline"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_re st_re
st_rw st_rw
st_rr st_rr
dw_pipe_errors dw_pipe_errors
end type
global w_pipe_risultati w_pipe_risultati

on w_pipe_risultati.create
this.st_re=create st_re
this.st_rw=create st_rw
this.st_rr=create st_rr
this.dw_pipe_errors=create dw_pipe_errors
this.Control[]={ this.st_re,&
this.st_rw,&
this.st_rr,&
this.dw_pipe_errors}
end on

on w_pipe_risultati.destroy
destroy(this.st_re)
destroy(this.st_rw)
destroy(this.st_rr)
destroy(this.dw_pipe_errors)
end on

type st_re from statictext within w_pipe_risultati
int X=1029
int Y=81
int Width=362
int Height=77
boolean Enabled=false
string Text="Righe con Errori"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_rw from statictext within w_pipe_risultati
int X=549
int Y=81
int Width=289
int Height=77
boolean Enabled=false
string Text="Righe Scritte"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_rr from statictext within w_pipe_risultati
int X=115
int Y=81
int Width=247
int Height=77
boolean Enabled=false
string Text="Righe lette"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_pipe_errors from datawindow within w_pipe_risultati
int X=69
int Y=241
int Width=1829
int Height=781
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

