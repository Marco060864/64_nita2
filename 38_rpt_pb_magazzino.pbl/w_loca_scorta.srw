forward
global type w_loca_scorta from Window
end type
type cb_1 from commandbutton within w_loca_scorta
end type
type st_1 from statictext within w_loca_scorta
end type
type em_loco from editmask within w_loca_scorta
end type
end forward

global type w_loca_scorta from Window
int X=1056
int Y=484
int Width=1207
int Height=560
boolean TitleBar=true
string Title="Sottoscorta"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_1 cb_1
st_1 st_1
em_loco em_loco
end type
global w_loca_scorta w_loca_scorta

type variables

end variables

on w_loca_scorta.create
this.cb_1=create cb_1
this.st_1=create st_1
this.em_loco=create em_loco
this.Control[]={this.cb_1,&
this.st_1,&
this.em_loco}
end on

on w_loca_scorta.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_loco)
end on

type cb_1 from commandbutton within w_loca_scorta
int X=439
int Y=300
int Width=247
int Height=108
int TabOrder=20
string Text="OK"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_date


ls_date= em_loco.text
if isnull(ls_date) then 
	messagebox('Attenzione','La data inserita non è valida')
   return 
end if	

CloseWithReturn ( parent, ls_date )


end event

type st_1 from statictext within w_loca_scorta
int X=91
int Y=124
int Width=635
int Height=116
boolean Enabled=false
string Text="Inserire la data scadenza per l'ordine al fornitore"
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

type em_loco from editmask within w_loca_scorta
int X=750
int Y=136
int Width=265
int Height=96
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
long TextColor=33554432
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

