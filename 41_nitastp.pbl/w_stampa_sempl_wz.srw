forward
global type w_stampa_sempl_wz from Window
end type
type rb_video from radiobutton within w_stampa_sempl_wz
end type
type rb_stampa from radiobutton within w_stampa_sempl_wz
end type
type cb_stampa from commandbutton within w_stampa_sempl_wz
end type
type cb_annulla from commandbutton within w_stampa_sempl_wz
end type
type gb_stvi from groupbox within w_stampa_sempl_wz
end type
end forward

global type w_stampa_sempl_wz from Window
int X=833
int Y=361
int Width=1061
int Height=477
boolean TitleBar=true
string Title="Wizard Stampe"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
rb_video rb_video
rb_stampa rb_stampa
cb_stampa cb_stampa
cb_annulla cb_annulla
gb_stvi gb_stvi
end type
global w_stampa_sempl_wz w_stampa_sempl_wz

type variables
long il_stvi

end variables

on w_stampa_sempl_wz.create
this.rb_video=create rb_video
this.rb_stampa=create rb_stampa
this.cb_stampa=create cb_stampa
this.cb_annulla=create cb_annulla
this.gb_stvi=create gb_stvi
this.Control[]={ this.rb_video,&
this.rb_stampa,&
this.cb_stampa,&
this.cb_annulla,&
this.gb_stvi}
end on

on w_stampa_sempl_wz.destroy
destroy(this.rb_video)
destroy(this.rb_stampa)
destroy(this.cb_stampa)
destroy(this.cb_annulla)
destroy(this.gb_stvi)
end on

event systemkey;integer		li_rc
unsignedlong l_keyflags

l_keyflags = keyflags

CHOOSE CASE l_keyflags
	CASE 1 
		IF key = KeyF4! THEN
			li_rc= THIS.cb_annulla.TriggerEvent(Clicked!)
		END IF
	CASE ELSE
		IF key = KeyF4! THEN
			li_rc= THIS.cb_annulla.TriggerEvent(Clicked!)
		END IF
END CHOOSE



end event

event open;rb_video.TriggerEvent(Clicked!)
end event

type rb_video from radiobutton within w_stampa_sempl_wz
int X=709
int Y=221
int Width=247
int Height=77
string Text="&Video"
boolean Checked=true
boolean LeftText=true
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_stvi = 1
end event

type rb_stampa from radiobutton within w_stampa_sempl_wz
int X=69
int Y=221
int Width=266
int Height=77
string Text="&Stampa"
boolean LeftText=true
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_stvi = 2
end event

type cb_stampa from commandbutton within w_stampa_sempl_wz
int X=732
int Y=21
int Width=247
int Height=89
int TabOrder=30
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, il_stvi) 
end event

type cb_annulla from commandbutton within w_stampa_sempl_wz
int X=23
int Y=21
int Width=247
int Height=89
int TabOrder=20
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, -1) 
end event

type gb_stvi from groupbox within w_stampa_sempl_wz
int X=23
int Y=141
int Width=974
int Height=181
int TabOrder=10
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

