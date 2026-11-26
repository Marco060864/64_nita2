forward
global type w_stampa_tab_raccordo from Window
end type
type cb_7 from commandbutton within w_stampa_tab_raccordo
end type
type cb_6 from commandbutton within w_stampa_tab_raccordo
end type
type cb_5 from commandbutton within w_stampa_tab_raccordo
end type
type cb_4 from commandbutton within w_stampa_tab_raccordo
end type
type cb_2 from commandbutton within w_stampa_tab_raccordo
end type
type dw_1 from datawindow within w_stampa_tab_raccordo
end type
type cb_3 from commandbutton within w_stampa_tab_raccordo
end type
type cb_1 from commandbutton within w_stampa_tab_raccordo
end type
end forward

global type w_stampa_tab_raccordo from Window
int X=10
int Y=237
int Width=2986
int Height=1509
boolean TitleBar=true
string Title="Stampa Tabulato di Raccordo"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_2 cb_2
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stampa_tab_raccordo w_stampa_tab_raccordo

type variables
long il_zoom
end variables

event open;close(w_attesa)
dw_1.settransobject(sqlca)
dw_1.retrieve()
il_zoom=100
end event

on w_stampa_tab_raccordo.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={ this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_2,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stampa_tab_raccordo.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type cb_7 from commandbutton within w_stampa_tab_raccordo
event clicked pbm_bnclicked
int X=1998
int Y=41
int Width=261
int Height=85
int TabOrder=23
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_stampa_tab_raccordo
event clicked pbm_bnclicked
int X=1724
int Y=41
int Width=261
int Height=85
int TabOrder=30
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_tab_raccordo
int X=819
int Y=41
int Width=467
int Height=85
int TabOrder=40
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_tab_raccordo
int X=316
int Y=41
int Width=467
int Height=85
int TabOrder=20
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_2 from commandbutton within w_stampa_tab_raccordo
int X=2410
int Y=41
int Width=247
int Height=85
int TabOrder=50
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if cb_2.text='Preview' then
	dw_1.object.datawindow.print.preview='yes'
	cb_2.text='Ritorna'
else
	dw_1.object.datawindow.print.preview='no'
	cb_2.text='Preview'
end if
end event

type dw_1 from datawindow within w_stampa_tab_raccordo
int X=33
int Y=161
int Width=2908
int Height=1245
int TabOrder=60
string DataObject="d_stampa_tab_raccordo"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_stampa_tab_raccordo
int X=2689
int Y=41
int Width=247
int Height=85
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.print()
end event

type cb_1 from commandbutton within w_stampa_tab_raccordo
int X=23
int Y=41
int Width=247
int Height=85
int TabOrder=70
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

