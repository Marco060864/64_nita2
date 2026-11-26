forward
global type w_stampa2_tab_raccordo_cx from Window
end type
type cb_7 from commandbutton within w_stampa2_tab_raccordo_cx
end type
type cb_6 from commandbutton within w_stampa2_tab_raccordo_cx
end type
type cb_5 from commandbutton within w_stampa2_tab_raccordo_cx
end type
type cb_4 from commandbutton within w_stampa2_tab_raccordo_cx
end type
type cb_1 from commandbutton within w_stampa2_tab_raccordo_cx
end type
type cb_2 from commandbutton within w_stampa2_tab_raccordo_cx
end type
type dw_1 from u_dw_ext_main within w_stampa2_tab_raccordo_cx
end type
end forward

global type w_stampa2_tab_raccordo_cx from Window
int X=5
int Y=4
int Width=3657
int Height=1452
boolean TitleBar=true
string Title="Stampa 2 Tabulato di Raccordo "
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
end type
global w_stampa2_tab_raccordo_cx w_stampa2_tab_raccordo_cx

type variables
long ll_id1,ll_id2,ll_id3,ll_id4,il_zoom
end variables

event ue_post_open;close(w_attesa)
dw_1.Height=(this.Height) - 272
end event

event open;long ll_anno

il_zoom=100

ll_anno=message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_anno)

this.event post ue_post_open()
end event

on w_stampa2_tab_raccordo_cx.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_1,&
this.cb_2,&
this.dw_1}
end on

on w_stampa2_tab_raccordo_cx.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
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

type cb_7 from commandbutton within w_stampa2_tab_raccordo_cx
event clicked pbm_bnclicked
int X=2505
int Y=40
int Width=261
int Height=84
int TabOrder=20
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

type cb_6 from commandbutton within w_stampa2_tab_raccordo_cx
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

type cb_5 from commandbutton within w_stampa2_tab_raccordo_cx
event clicked pbm_bnclicked
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

type cb_4 from commandbutton within w_stampa2_tab_raccordo_cx
event clicked pbm_bnclicked
int X=1161
int Y=40
int Width=466
int Height=84
int TabOrder=60
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_1 from commandbutton within w_stampa2_tab_raccordo_cx
int X=3387
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
dw_1.print()
end event

type cb_2 from commandbutton within w_stampa2_tab_raccordo_cx
event clicked pbm_bnclicked
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=30
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from u_dw_ext_main within w_stampa2_tab_raccordo_cx
int X=23
int Y=140
int Width=3611
int Height=1180
int TabOrder=70
string DataObject="d_bilancio3_cee_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

