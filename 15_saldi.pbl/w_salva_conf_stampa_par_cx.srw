forward
global type w_salva_conf_stampa_par_cx from Window
end type
type st_1 from statictext within w_salva_conf_stampa_par_cx
end type
type sle_1 from singlelineedit within w_salva_conf_stampa_par_cx
end type
end forward

global type w_salva_conf_stampa_par_cx from Window
int X=1075
int Y=485
int Width=1838
int Height=461
boolean TitleBar=true
string Title="Salva Configurazione Stampe Parametriche"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
st_1 st_1
sle_1 sle_1
end type
global w_salva_conf_stampa_par_cx w_salva_conf_stampa_par_cx

on w_salva_conf_stampa_par_cx.create
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={ this.st_1,&
this.sle_1}
end on

on w_salva_conf_stampa_par_cx.destroy
destroy(this.st_1)
destroy(this.sle_1)
end on

event open;s_stampa s_dw
s_dw=message.powerobjectparm
end event

type st_1 from statictext within w_salva_conf_stampa_par_cx
int X=83
int Y=37
int Width=1633
int Height=77
boolean Enabled=false
string Text="Inserisci Il nome con cui vuoi salvare la configurazione:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_salva_conf_stampa_par_cx
int X=65
int Y=121
int Width=1687
int Height=93
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

