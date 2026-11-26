forward
global type w_agg_attesa from w_001
end type
type st_2 from statictext within w_agg_attesa
end type
end forward

global type w_agg_attesa from w_001
int Width=1883
int Height=560
boolean TitleBar=false
boolean ControlMenu=false
st_2 st_2
end type
global w_agg_attesa w_agg_attesa

on w_agg_attesa.create
int iCurrent
call super::create
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
end on

on w_agg_attesa.destroy
call super::destroy
destroy(this.st_2)
end on

type st_2 from statictext within w_agg_attesa
int X=27
int Y=20
int Width=1806
int Height=500
boolean Enabled=false
boolean BringToTop=true
string Text="Attendere: aggiornamento del peso del componente in tutte le distinte in cui è presente!"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-22
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

