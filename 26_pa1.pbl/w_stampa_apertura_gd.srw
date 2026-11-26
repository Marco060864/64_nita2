forward
global type w_stampa_apertura_gd from Window
end type
type cbx_1 from checkbox within w_stampa_apertura_gd
end type
type cb_7 from commandbutton within w_stampa_apertura_gd
end type
type cb_6 from commandbutton within w_stampa_apertura_gd
end type
type cb_5 from commandbutton within w_stampa_apertura_gd
end type
type cb_4 from commandbutton within w_stampa_apertura_gd
end type
type cb_2 from commandbutton within w_stampa_apertura_gd
end type
type dw_1 from datawindow within w_stampa_apertura_gd
end type
type cb_3 from commandbutton within w_stampa_apertura_gd
end type
type cb_1 from commandbutton within w_stampa_apertura_gd
end type
end forward

global type w_stampa_apertura_gd from Window
int X=9
int Y=376
int Width=3593
int Height=1536
boolean TitleBar=true
string Title="Stampa Apertura dei Conti"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cbx_1 cbx_1
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_2 cb_2
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stampa_apertura_gd w_stampa_apertura_gd

type variables
long il_zoom
end variables

event open;close(w_attesa)
dw_1.settransobject(sqlca)
dw_1.retrieve()
il_zoom=100
end event

on w_stampa_apertura_gd.create
this.cbx_1=create cbx_1
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cbx_1,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_2,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stampa_apertura_gd.destroy
destroy(this.cbx_1)
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

type cbx_1 from checkbox within w_stampa_apertura_gd
int X=3287
int Y=44
int Width=224
int Height=76
string Text="Aghi"
BorderStyle BorderStyle=StyleLowered!
boolean LeftText=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_7 from commandbutton within w_stampa_apertura_gd
event clicked pbm_bnclicked
int X=2107
int Y=40
int Width=261
int Height=84
int TabOrder=30
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

type cb_6 from commandbutton within w_stampa_apertura_gd
event clicked pbm_bnclicked
int X=1833
int Y=40
int Width=261
int Height=84
int TabOrder=40
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

type cb_5 from commandbutton within w_stampa_apertura_gd
int X=1120
int Y=40
int Width=466
int Height=84
int TabOrder=50
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_apertura_gd
int X=617
int Y=40
int Width=466
int Height=84
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

type cb_2 from commandbutton within w_stampa_apertura_gd
int X=2706
int Y=40
int Width=247
int Height=84
int TabOrder=60
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

type dw_1 from datawindow within w_stampa_apertura_gd
int X=23
int Y=140
int Width=3497
int Height=1260
int TabOrder=70
string DataObject="d_stampa_apertura_gd"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_stampa_apertura_gd
int X=2999
int Y=40
int Width=247
int Height=84
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()

IF cbx_1.Checked = TRUE THEN 
	datastore ds_st
	ds_st=create datastore
	ds_st.dataobject="d_stampa_apertura_aghi_gd"
	ds_st.settransobject(sqlca)
	ds_st.retrieve()
	ds_st.print()
ELSE
	dw_1.print()
END IF
end event

type cb_1 from commandbutton within w_stampa_apertura_gd
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=80
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

