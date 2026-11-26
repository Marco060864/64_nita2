forward
global type w_controllo_perc from Window
end type
type cb_10 from commandbutton within w_controllo_perc
end type
type cb_9 from commandbutton within w_controllo_perc
end type
type cb_8 from commandbutton within w_controllo_perc
end type
type cb_2 from commandbutton within w_controllo_perc
end type
type cb_7 from commandbutton within w_controllo_perc
end type
type cb_6 from commandbutton within w_controllo_perc
end type
type cb_5 from commandbutton within w_controllo_perc
end type
type cb_4 from commandbutton within w_controllo_perc
end type
type dw_1 from datawindow within w_controllo_perc
end type
type cb_3 from commandbutton within w_controllo_perc
end type
type cb_1 from commandbutton within w_controllo_perc
end type
end forward

global type w_controllo_perc from Window
int X=5
int Y=49
int Width=3658
int Height=2389
boolean TitleBar=true
string Title="Liquidazione IVA"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_controllo_perc w_controllo_perc

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272


end event

event open;

close(w_attesa)
dw_1.settransobject(sqlca)
dw_1.retrieve()
il_zoom=100


end event

on w_controllo_perc.create
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={ this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_controllo_perc.destroy
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
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

type cb_10 from commandbutton within w_controllo_perc
int X=2455
int Y=41
int Width=165
int Height=85
int TabOrder=11
string Text="% Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

string DWfilter2

DWfilter2 = "tot_perc = 100"

dw_1.SetFilter(DWfilter2)
dw_1.Filter( )



end event

type cb_9 from commandbutton within w_controllo_perc
int X=1468
int Y=41
int Width=215
int Height=85
int TabOrder=30
string Text="% Tutte"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string DWfilter2

dw_1.SetFilter(DWfilter2)
dw_1.Filter( )

dw_1.retrieve()
end event

type cb_8 from commandbutton within w_controllo_perc
int X=2049
int Y=41
int Width=343
int Height=85
int TabOrder=10
string Text="% Da inserire"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

string DWfilter2

DWfilter2 = "tot_perc = 0 or isnull(tot_perc)"

dw_1.SetFilter(DWfilter2)
dw_1.Filter( )



end event

type cb_2 from commandbutton within w_controllo_perc
int X=1729
int Y=41
int Width=247
int Height=85
int TabOrder=60
string Text="% Errate"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

string DWfilter2

DWfilter2 = "tot_perc >100 or ( tot_perc < 100 and tot_perc<>0)"

dw_1.SetFilter(DWfilter2)
dw_1.Filter( )



end event

type cb_7 from commandbutton within w_controllo_perc
event clicked pbm_bnclicked
int X=3022
int Y=41
int Width=261
int Height=85
int TabOrder=50
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

type cb_6 from commandbutton within w_controllo_perc
event clicked pbm_bnclicked
int X=2748
int Y=41
int Width=261
int Height=85
int TabOrder=70
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

type cb_5 from commandbutton within w_controllo_perc
int X=371
int Y=41
int Width=467
int Height=85
int TabOrder=80
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_controllo_perc
int X=851
int Y=41
int Width=467
int Height=85
int TabOrder=40
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_controllo_perc
int X=28
int Y=145
int Width=3612
int Height=2145
int TabOrder=90
string DataObject="d_aggrega_conti_ff"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_controllo_perc
int X=3388
int Y=41
int Width=247
int Height=85
int TabOrder=20
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()



end event

type cb_1 from commandbutton within w_controllo_perc
int X=23
int Y=41
int Width=247
int Height=85
int TabOrder=100
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

