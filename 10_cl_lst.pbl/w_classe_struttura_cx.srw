forward
global type w_classe_struttura_cx from w_001
end type
type cb_ok from commandbutton within w_classe_struttura_cx
end type
type cb_annulla from commandbutton within w_classe_struttura_cx
end type
type dw_1 from udw_base within w_classe_struttura_cx
end type
end forward

global type w_classe_struttura_cx from w_001
int Width=1413
int Height=516
WindowType WindowType=response!
boolean TitleBar=true
string Title="Scegli Classe da Applicare"
long BackColor=80269524
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_classe_struttura_cx w_classe_struttura_cx

type variables
long	il_item_corrente
string is_sql

string is_chiamante


end variables

on w_classe_struttura_cx.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
end on

on w_classe_struttura_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.insertrow(1)

is_chiamante=message.stringparm
end event

event timer;
end event

type cb_ok from commandbutton within w_classe_struttura_cx
int X=1120
int Y=284
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

event clicked;s_recupera_classe s_rec

if dw_1.rowcount()>0 then
	s_rec.cod_classe[1]=dw_1.getitemstring(1, "c_1")
	s_rec.id_classe[1]=dw_1.getitemnumber(1, "id_classe_1")
	s_rec.cod_classe[2]=dw_1.getitemstring(1, "c_2")
	s_rec.id_classe[2]=dw_1.getitemnumber(1, "id_classe_2")
	s_rec.cod_classe[3]=dw_1.getitemstring(1, "c_3")
	s_rec.id_classe[3]=dw_1.getitemnumber(1, "id_classe_3")
	
	if (s_rec.id_classe[1]>0 and s_rec.id_classe[2]>0 and s_rec.id_classe[3]>0) &
		or (is_chiamante<>"Articolo")	then
		closewithreturn(parent, s_rec)
	else
		messagebox("Attenzione!", "Devono essere specificati tutti i 3 livelli!")
	end if
	
end if
end event

type cb_annulla from commandbutton within w_classe_struttura_cx
int X=809
int Y=284
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

type dw_1 from udw_base within w_classe_struttura_cx
int X=18
int Y=28
int Width=1358
int Height=232
boolean BringToTop=true
string DataObject="d_ins_classe_or_tb"
boolean VScrollBar=false
end type

