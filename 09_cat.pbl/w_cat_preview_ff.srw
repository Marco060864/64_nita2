forward
global type w_cat_preview_ff from Window
end type
type st_altre from statictext within w_cat_preview_ff
end type
type st_prima from statictext within w_cat_preview_ff
end type
type cb_1 from commandbutton within w_cat_preview_ff
end type
type r_prima from rectangle within w_cat_preview_ff
end type
type r_altre from rectangle within w_cat_preview_ff
end type
end forward

global type w_cat_preview_ff from Window
int X=836
int Y=372
int Width=2742
int Height=1815
boolean TitleBar=true
string Title="Anteprima Stampa Catalogo"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_post_open ( )
st_altre st_altre
st_prima st_prima
cb_1 cb_1
r_prima r_prima
r_altre r_altre
end type
global w_cat_preview_ff w_cat_preview_ff

type variables

end variables

event ue_post_open;
end event

on w_cat_preview_ff.create
this.st_altre=create st_altre
this.st_prima=create st_prima
this.cb_1=create cb_1
this.r_prima=create r_prima
this.r_altre=create r_altre
this.Control[]={ this.st_altre,&
this.st_prima,&
this.cb_1,&
this.r_prima,&
this.r_altre}
end on

on w_cat_preview_ff.destroy
destroy(this.st_altre)
destroy(this.st_prima)
destroy(this.cb_1)
destroy(this.r_prima)
destroy(this.r_altre)
end on

event open;
end event

type st_altre from statictext within w_cat_preview_ff
int X=1785
int Y=17
int Width=413
int Height=65
boolean Enabled=false
string Text="Altre pagine"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_prima from statictext within w_cat_preview_ff
int X=484
int Y=17
int Width=413
int Height=65
boolean Enabled=false
string Text="Prima pagina"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_cat_preview_ff
int X=1213
int Y=1601
int Width=285
int Height=84
int TabOrder=1
string Text="Ok"
boolean Default=true
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type r_prima from rectangle within w_cat_preview_ff
int X=196
int Y=87
int Width=1049
int Height=1485
boolean Enabled=false
int LineThickness=4
long LineColor=33554432
long FillColor=16777215
end type

type r_altre from rectangle within w_cat_preview_ff
int X=1465
int Y=87
int Width=1049
int Height=1485
boolean Enabled=false
int LineThickness=4
long LineColor=33554432
long FillColor=16777215
end type

