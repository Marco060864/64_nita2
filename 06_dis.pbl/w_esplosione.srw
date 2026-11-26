forward
global type w_esplosione from Window
end type
type cb_2 from commandbutton within w_esplosione
end type
type cb_espandi from commandbutton within w_esplosione
end type
type cb_5 from commandbutton within w_esplosione
end type
type cb_6 from commandbutton within w_esplosione
end type
type sle_livello from singlelineedit within w_esplosione
end type
type tv_1 from u_tv_distinta within w_esplosione
end type
end forward

global type w_esplosione from Window
int X=833
int Y=361
int Width=1157
int Height=1605
boolean TitleBar=true
string Title="Esplosione Distinta"
long BackColor=79741120
boolean ControlMenu=true
cb_2 cb_2
cb_espandi cb_espandi
cb_5 cb_5
cb_6 cb_6
sle_livello sle_livello
tv_1 tv_1
end type
global w_esplosione w_esplosione

type variables
integer ii_livello
end variables

on w_esplosione.create
this.cb_2=create cb_2
this.cb_espandi=create cb_espandi
this.cb_5=create cb_5
this.cb_6=create cb_6
this.sle_livello=create sle_livello
this.tv_1=create tv_1
this.Control[]={ this.cb_2,&
this.cb_espandi,&
this.cb_5,&
this.cb_6,&
this.sle_livello,&
this.tv_1}
end on

on w_esplosione.destroy
destroy(this.cb_2)
destroy(this.cb_espandi)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.sle_livello)
destroy(this.tv_1)
end on

event open;dati dat
date ld_1,ld_2
long ll_handle
treeviewitem tvi_esplodi
dat=message.powerobjectparm
ll_handle=tv_1.FindItem(childTreeItem! , 0)
tvi_esplodi.label=dat.codice
ld_1=dat.data_inizio
ld_2=dat.data_fine
f_rec_righe(tv_1,ll_handle,true,dat.id_dis_figlio,ld_1,ld_2,dat.id_dis_figlio,true)
end event

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

type cb_2 from commandbutton within w_esplosione
int X=142
int Y=17
int Width=247
int Height=69
int TabOrder=10
boolean BringToTop=true
string Text="Chiudi "
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;treeview tv_d
tv_d=tv_1
f_collapse(tv_d,0,0,1)

end event

type cb_espandi from commandbutton within w_esplosione
int X=394
int Y=17
int Width=247
int Height=69
int TabOrder=20
boolean BringToTop=true
string Text="Espandi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tv_1.ib_completa=true
long ll_root
ll_root =tv_1.FindItem (RootTreeItem!, 0)
tv_1.expandall(ll_root)
end event

type cb_5 from commandbutton within w_esplosione
int X=668
int Y=17
int Width=87
int Height=69
int TabOrder=30
boolean BringToTop=true
string Text="<"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_root
if ii_livello>1 then
	ll_root =tv_1.FindItem (RootTreeItem!, 0)
	tv_1.expandall(ll_root)
	treeview tv_d
	tv_d=tv_1
	ii_livello=ii_livello -1
	f_collapse(tv_d,0,0,ii_livello)
	sle_livello.text=string(ii_livello)
end if
end event

type cb_6 from commandbutton within w_esplosione
int X=759
int Y=17
int Width=87
int Height=69
int TabOrder=40
boolean BringToTop=true
string Text=">"
int TextSize=-12
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_root
tv_1.ib_completa=true
ll_root =tv_1.FindItem (RootTreeItem!, 0)
tv_1.expandall(ll_root)
treeview tv_d
tv_d=tv_1
ii_livello=ii_livello +1
f_collapse(tv_d,0,0,ii_livello)
sle_livello.text=string(ii_livello)
end event

type sle_livello from singlelineedit within w_esplosione
int X=851
int Y=17

int Width=133
int Height=73
int TabOrder=50
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tv_1 from u_tv_distinta within w_esplosione
int X=1
int Y=101
int TabOrder=60
end type

