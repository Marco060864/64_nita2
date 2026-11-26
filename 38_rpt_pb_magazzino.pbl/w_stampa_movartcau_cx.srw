forward
global type w_stampa_movartcau_cx from Window
end type
type cb_6 from commandbutton within w_stampa_movartcau_cx
end type
type cb_5 from commandbutton within w_stampa_movartcau_cx
end type
type cb_4 from commandbutton within w_stampa_movartcau_cx
end type
type cb_3 from commandbutton within w_stampa_movartcau_cx
end type
type cb_2 from commandbutton within w_stampa_movartcau_cx
end type
type cb_1 from commandbutton within w_stampa_movartcau_cx
end type
type dw_1 from datawindow within w_stampa_movartcau_cx
end type
end forward

global type w_stampa_movartcau_cx from Window
int X=60
int Y=261
int Width=3539
int Height=1517
boolean TitleBar=true
string Title="Anteprima di Stampa Movimenti Articoli per Mag./Caus./Data"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_stampa_movartcau_cx w_stampa_movartcau_cx

event open;
s_stringa_articolo ls_art
ls_art=message.powerobjectparm

Time lt_inizio_retrieve, lt_fine_retrieve

lt_inizio_retrieve = Now()

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_art.ls_cod_art[1],ls_art.ls_cod_art[2])

lt_fine_retrieve = Now()
MessageBox("Retrieve:", String(lt_inizio_retrieve) + '-' + String(lt_fine_retrieve))


end event

on w_stampa_movartcau_cx.create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_stampa_movartcau_cx.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event key;keycode			lk_code
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

type cb_6 from commandbutton within w_stampa_movartcau_cx
int X=723
int Y=41
int Width=321
int Height=81
int TabOrder=11
string Text="<<"
int TextSize=-16
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_5 from commandbutton within w_stampa_movartcau_cx
int X=2908
int Y=33
int Width=385
int Height=97
int TabOrder=30
string Text="Stampa"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_4 from commandbutton within w_stampa_movartcau_cx
int X=2273
int Y=37
int Width=321
int Height=85
int TabOrder=40
string Text="Zomm out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long il_zoom
il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_3 from commandbutton within w_stampa_movartcau_cx
int X=1884
int Y=41
int Width=339
int Height=85
int TabOrder=20
string Text="Zomm in"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long il_zoom
il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_2 from commandbutton within w_stampa_movartcau_cx
int X=1098
int Y=41
int Width=330
int Height=81
int TabOrder=10
string Text=">>"
int TextSize=-16
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_1 from commandbutton within w_stampa_movartcau_cx
int X=74
int Y=25
int Width=289
int Height=93
int TabOrder=50
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_stampa_movartcau_cx
int X=55
int Y=157
int Width=3246
int Height=1205
int TabOrder=60
string DataObject="d_mov_art_cau_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

