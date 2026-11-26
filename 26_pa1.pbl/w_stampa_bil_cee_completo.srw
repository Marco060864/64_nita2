forward
global type w_stampa_bil_cee_completo from Window
end type
type cb_7 from commandbutton within w_stampa_bil_cee_completo
end type
type cb_6 from commandbutton within w_stampa_bil_cee_completo
end type
type cb_5 from commandbutton within w_stampa_bil_cee_completo
end type
type cb_4 from commandbutton within w_stampa_bil_cee_completo
end type
type dw_1 from datawindow within w_stampa_bil_cee_completo
end type
type cb_3 from commandbutton within w_stampa_bil_cee_completo
end type
type cb_1 from commandbutton within w_stampa_bil_cee_completo
end type
end forward

global type w_stampa_bil_cee_completo from Window
int X=5
int Y=4
int Width=3657
int Height=1508
boolean TitleBar=true
string Title="Stampa Bilancio Cee Completo"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stampa_bil_cee_completo w_stampa_bil_cee_completo

type variables
long il_zoom
long aa
end variables

forward prototypes
public subroutine f_setta_totali ()
end prototypes

event ue_post_open;close(w_attesa)
dw_1.Height=(this.Height) - 272



end event

public subroutine f_setta_totali ();datawindowchild ldw_att , ldw_pas
long ll_test

ll_test=dw_1.getchild("attivi",ldw_att)
ll_test=dw_1.getchild("passivi",ldw_pas)

decimal ll_tot_x, ll_tot_y, ll_ax, ll_ay, ll_px, ll_py
long ll_rowa, ll_rowp

long conta=0
DO WHILE not(ldw_pas.rowcount()>0)
	ll_rowp=ldw_pas.rowcount()
	conta=conta+1
LOOP

DO WHILE not(ldw_att.rowcount()>0)
	ll_rowa=ldw_att.rowcount()
	conta=conta+1
LOOP





ll_rowa=ldw_att.rowcount()
ll_rowp=ldw_pas.rowcount()

ll_ax=ldw_att.getitemnumber(ll_rowa,"tot_attivo")
ll_ay=ldw_att.getitemnumber(ll_rowa,"tot_attivo_y")

ll_px=ldw_pas.getitemnumber(ll_rowp,"tot_10_x_gen")
ll_py=ldw_pas.getitemnumber(ll_rowp,"tot_10_y_gen")

ll_tot_x=ll_ax - ll_px
ll_tot_y=ll_ay - ll_py

ldw_pas.setitem(ll_rowp,"tot_x",ll_tot_x)
ldw_pas.setitem(ll_rowp,"tot_y",ll_tot_y)
end subroutine

event open;
dw_1.settransobject(sqlca)
dw_1.retrieve()
il_zoom=100
this.event post ue_post_open()




end event

on w_stampa_bil_cee_completo.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stampa_bil_cee_completo.destroy
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

type cb_7 from commandbutton within w_stampa_bil_cee_completo
event clicked pbm_bnclicked
int X=2505
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

type cb_6 from commandbutton within w_stampa_bil_cee_completo
event clicked pbm_bnclicked
int X=2231
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

type cb_5 from commandbutton within w_stampa_bil_cee_completo
int X=681
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

type cb_4 from commandbutton within w_stampa_bil_cee_completo
int X=1161
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

type dw_1 from datawindow within w_stampa_bil_cee_completo
int X=23
int Y=160
int Width=3589
int Height=1220
int TabOrder=60
string DataObject="d_stampa_bil_cee_completa"
boolean VScrollBar=true
boolean LiveScroll=true
end type

event retrieveend;post f_setta_totali()
end event

type cb_3 from commandbutton within w_stampa_bil_cee_completo
int X=3365
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

event clicked;dw_1.print()
end event

type cb_1 from commandbutton within w_stampa_bil_cee_completo
int X=23
int Y=40
int Width=247
int Height=84
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

