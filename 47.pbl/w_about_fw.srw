forward
global type w_about_fw from Window
end type
type st_9 from statictext within w_about_fw
end type
type st_7 from statictext within w_about_fw
end type
type st_8 from statictext within w_about_fw
end type
type st_6 from statictext within w_about_fw
end type
type st_5 from statictext within w_about_fw
end type
type st_4 from statictext within w_about_fw
end type
type st_3 from statictext within w_about_fw
end type
type st_2 from statictext within w_about_fw
end type
type st_1 from statictext within w_about_fw
end type
type cb_ok from commandbutton within w_about_fw
end type
type ln_1 from line within w_about_fw
end type
end forward

global type w_about_fw from Window
int X=1074
int Y=484
int Width=1765
int Height=1384
boolean TitleBar=true
string Title="Informazioni"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
st_9 st_9
st_7 st_7
st_8 st_8
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_ok cb_ok
ln_1 ln_1
end type
global w_about_fw w_about_fw

on w_about_fw.create
this.st_9=create st_9
this.st_7=create st_7
this.st_8=create st_8
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_ok=create cb_ok
this.ln_1=create ln_1
this.Control[]={this.st_9,&
this.st_7,&
this.st_8,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_ok,&
this.ln_1}
end on

on w_about_fw.destroy
destroy(this.st_9)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.ln_1)
end on

event open;string		ls_1 = string(today(),"DD/MM/YYYY")
string		ls_2 = string(now())

st_1.Text = u_freddie.istr_application.name
st_2.Text = u_freddie.istr_application.description
st_7.Text = "Versione "+u_freddie.istr_application.version
st_9.text = "Data/ora di compilazione: "+ls_1+" - "+ls_2
u_freddie.center_window(THIS)
end event

type st_9 from statictext within w_about_fw
int X=46
int Y=896
int Width=1691
int Height=60
boolean Enabled=false
string Text="Data/Ora compilazione: xx/xx/xxxx cc:cc:cc"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_about_fw
int X=69
int Y=376
int Width=1646
int Height=80
boolean Enabled=false
string Text="Versione "
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_about_fw
int X=69
int Y=760
int Width=1646
int Height=60
boolean Enabled=false
string Text="www.centrosistemi.it"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_about_fw
int X=69
int Y=700
int Width=1646
int Height=60
boolean Enabled=false
string Text="Tel. 055-91971  Fax 055-9197515"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_about_fw
int X=69
int Y=572
int Width=1646
int Height=60
boolean Enabled=false
string Text="52100 Arezzo - AR"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_about_fw
int X=46
int Y=636
int Width=1691
int Height=60
boolean Enabled=false
string Text="Via dell'Olmo, 99"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_about_fw
int X=69
int Y=500
int Width=1646
int Height=80
boolean Enabled=false
string Text="Centro Sistemi s.p.a."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_about_fw
int X=69
int Y=260
int Width=1646
int Height=120
boolean Enabled=false
string Text="Descrizione"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-18
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_about_fw
int X=46
int Y=40
int Width=1669
int Height=180
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Progetto"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-24
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_about_fw
int X=663
int Y=1120
int Width=457
int Height=120
int TabOrder=1
string Text="OK"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type ln_1 from line within w_about_fw
boolean Enabled=false
int BeginX=46
int BeginY=860
int EndX=1714
int EndY=860
int LineThickness=4
long LineColor=33554432
end type

