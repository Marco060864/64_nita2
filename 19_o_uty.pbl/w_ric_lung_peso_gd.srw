forward
global type w_ric_lung_peso_gd from w_001
end type
type dw_1 from udw_base within w_ric_lung_peso_gd
end type
type cb_ok from commandbutton within w_ric_lung_peso_gd
end type
type cb_annulla from commandbutton within w_ric_lung_peso_gd
end type
end forward

global type w_ric_lung_peso_gd from w_001
int Width=1742
int Height=912
WindowType WindowType=response!
dw_1 dw_1
cb_ok cb_ok
cb_annulla cb_annulla
end type
global w_ric_lung_peso_gd w_ric_lung_peso_gd

on w_ric_lung_peso_gd.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_annulla
end on

on w_ric_lung_peso_gd.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_annulla)
end on

event open;call super::open;s_lung_peso s_lung
long ll_righe

dw_1.settransobject(sqlca)

s_lung=message.powerobjectparm

if s_lung.cod_articolo>"" then
	ll_righe=dw_1.retrieve(s_lung.id_sog_commerciale, s_lung.cod_articolo+"%")
	if ll_righe=0 then
		close(this)
	elseif ll_righe=1 then
		cb_ok.triggerevent(clicked!)
	else
		cb_ok.setfocus()
	end if
end if

end event

type dw_1 from udw_base within w_ric_lung_peso_gd
int X=18
int Y=28
int Width=1696
int Height=636
boolean BringToTop=true
string DataObject="d_lung_peso_gd"
end type

event rowfocuschanged;setrowfocusindicator(hand!)
end event

type cb_ok from commandbutton within w_ric_lung_peso_gd
int X=1326
int Y=684
int Width=247
int Height=108
int TabOrder=20
boolean BringToTop=true
string Text="OK!"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_riga
s_lung_peso s_lung

li_riga=dw_1.getrow()

if li_riga>0 then
	s_lung.cod_articolo=dw_1.getitemstring(li_riga, "articolo")
	s_lung.lunghezza=dw_1.getitemdecimal(li_riga, "lunghezza")
	s_lung.peso_unitario=dw_1.getitemdecimal(li_riga, "peso_unitario")
	closewithreturn(parent, s_lung)
	
end if
	
end event

type cb_annulla from commandbutton within w_ric_lung_peso_gd
int X=1029
int Y=684
int Width=247
int Height=108
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

