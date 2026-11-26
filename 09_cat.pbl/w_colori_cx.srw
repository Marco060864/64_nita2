forward
global type w_colori_cx from Window
end type
type cb_blugiu from commandbutton within w_colori_cx
end type
type cb_blusu from commandbutton within w_colori_cx
end type
type cb_greengiu from commandbutton within w_colori_cx
end type
type cb_greensu from commandbutton within w_colori_cx
end type
type cb_redgiu from commandbutton within w_colori_cx
end type
type cb_redsu from commandbutton within w_colori_cx
end type
type cb_2 from commandbutton within w_colori_cx
end type
type cb_1 from commandbutton within w_colori_cx
end type
type dw_colore from datawindow within w_colori_cx
end type
end forward

global type w_colori_cx from Window
int X=836
int Y=372
int Width=1330
int Height=737
boolean TitleBar=true
string Title="Colore"
long BackColor=79741120
WindowType WindowType=response!
cb_blugiu cb_blugiu
cb_blusu cb_blusu
cb_greengiu cb_greengiu
cb_greensu cb_greensu
cb_redgiu cb_redgiu
cb_redsu cb_redsu
cb_2 cb_2
cb_1 cb_1
dw_colore dw_colore
end type
global w_colori_cx w_colori_cx

type variables
s_testo is_testo_parm
string is_button

end variables

on w_colori_cx.create
this.cb_blugiu=create cb_blugiu
this.cb_blusu=create cb_blusu
this.cb_greengiu=create cb_greengiu
this.cb_greensu=create cb_greensu
this.cb_redgiu=create cb_redgiu
this.cb_redsu=create cb_redsu
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_colore=create dw_colore
this.Control[]={ this.cb_blugiu,&
this.cb_blusu,&
this.cb_greengiu,&
this.cb_greensu,&
this.cb_redgiu,&
this.cb_redsu,&
this.cb_2,&
this.cb_1,&
this.dw_colore}
end on

on w_colori_cx.destroy
destroy(this.cb_blugiu)
destroy(this.cb_blusu)
destroy(this.cb_greengiu)
destroy(this.cb_greensu)
destroy(this.cb_redgiu)
destroy(this.cb_redsu)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_colore)
end on

event open;integer li_red, li_green, li_blue

is_testo_parm=Message.PowerObjectParm

dw_colore.InsertRow(0)
if IsNull(is_testo_parm.red) then
	li_red=0
else
	li_red=is_testo_parm.red
end if
if IsNull(is_testo_parm.green) then
	li_green=0
else
	li_green=is_testo_parm.green
end if
if IsNull(is_testo_parm.blue) then
	li_blue=0
else
	li_blue=is_testo_parm.blue
end if
dw_colore.SetItem(1,"red",li_red)
dw_colore.SetItem(1,"green",li_green)
dw_colore.SetItem(1,"blue",li_blue)
dw_colore.object.r_old.brush.color=rgb(li_red,li_green,li_blue)
end event

event timer;integer li_valore

choose case is_button
	case "redsu"
		li_valore=dw_colore.GetItemNumber(1,"red")
		if li_valore<255 then
			dw_colore.setItem(1,"red",li_valore+1)
		end if
	case "redgiu"
		li_valore=dw_colore.GetItemNumber(1,"red")
		if li_valore>0 then
			dw_colore.setItem(1,"red",li_valore - 1)
		end if
	case "greensu"
		li_valore=dw_colore.GetItemNumber(1,"green")
		if li_valore<255 then
			dw_colore.setItem(1,"green",li_valore+1)
		end if
	case "greengiu"
		li_valore=dw_colore.GetItemNumber(1,"green")
		if li_valore>0 then
			dw_colore.setItem(1,"green",li_valore - 1)
		end if
	case "blusu"
		li_valore=dw_colore.GetItemNumber(1,"blue")
		if li_valore<255 then
			dw_colore.setItem(1,"blue",li_valore+1)
		end if
	case "blugiu"
		li_valore=dw_colore.GetItemNumber(1,"blue")
		if li_valore>0 then
			dw_colore.setItem(1,"blue",li_valore - 1)
		end if
end choose
end event

type cb_blugiu from commandbutton within w_colori_cx
event ue_startclick pbm_lbuttondown
event ue_endclick pbm_lbuttonup
int X=1163
int Y=349
int Width=79
int Height=39
int TabOrder=70
string Text="ê"
int TextSize=-6
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

event ue_startclick;is_button="blugiu"
Timer(0.1,parent)

end event

event ue_endclick;Timer(0,parent)
end event

type cb_blusu from commandbutton within w_colori_cx
event ue_startclick pbm_lbuttondown
event ue_endclick pbm_lbuttonup
int X=1163
int Y=308
int Width=79
int Height=39
int TabOrder=60
string Text="é"
int TextSize=-6
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

event ue_startclick;is_button="blusu"
Timer(0.1,parent)

end event

event ue_endclick;Timer(0,parent)
end event

type cb_greengiu from commandbutton within w_colori_cx
event ue_startclick pbm_lbuttondown
event ue_endclick pbm_lbuttonup
int X=1163
int Y=237
int Width=79
int Height=39
int TabOrder=50
string Text="ê"
int TextSize=-6
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

event ue_startclick;is_button="greengiu"
Timer(0.1,parent)

end event

event ue_endclick;Timer(0,parent)
end event

type cb_greensu from commandbutton within w_colori_cx
event ue_startclick pbm_lbuttondown
event ue_endclick pbm_lbuttonup
int X=1163
int Y=196
int Width=79
int Height=39
int TabOrder=40
string Text="é"
int TextSize=-6
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

event ue_startclick;is_button="greensu"
Timer(0.1,parent)

end event

event ue_endclick;Timer(0,parent)
end event

type cb_redgiu from commandbutton within w_colori_cx
event ue_startclick pbm_lbuttondown
event ue_endclick pbm_lbuttonup
int X=1163
int Y=129
int Width=79
int Height=39
int TabOrder=30
string Text="ê"
int TextSize=-6
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

event ue_startclick;is_button="redgiu"
Timer(0.1,parent)

end event

event ue_endclick;Timer(0,parent)
end event

type cb_redsu from commandbutton within w_colori_cx
event ue_startclick pbm_lbuttondown
event ue_endclick pbm_lbuttonup
int X=1163
int Y=87
int Width=79
int Height=39
int TabOrder=20
string Text="é"
int TextSize=-6
int Weight=400
string FaceName="Wingdings"
FontCharSet FontCharSet=Symbol!
FontPitch FontPitch=Variable!
end type

event ue_startclick;is_button="redsu"
Timer(0.1,parent)

end event

event ue_endclick;Timer(0,parent)
end event

type cb_2 from commandbutton within w_colori_cx
int X=651
int Y=503
int Width=367
int Height=84
int TabOrder=90
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(parent,is_testo_parm)
end event

type cb_1 from commandbutton within w_colori_cx
int X=239
int Y=503
int Width=246
int Height=84
int TabOrder=80
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_testo_parm.red=dw_colore.GetItemNumber(1,"red")
is_testo_parm.green=dw_colore.GetItemNumber(1,"green")
is_testo_parm.blue=dw_colore.GetItemNumber(1,"blue")

CloseWithReturn(parent,is_testo_parm)
end event

type dw_colore from datawindow within w_colori_cx
event ue_post_itemchanged ( long al_riga,  string as_colonna,  long as_valore )
int X=68
int Y=39
int Width=1170
int Height=401
int TabOrder=10
string DataObject="d_colori_ff"
boolean Border=false
boolean LiveScroll=true
end type

event ue_post_itemchanged;setitem(al_riga, as_colonna, as_valore)
end event

event itemchanged;long ll_old
string ls_colonna

choose case dwo.name
	case "red", "green", "blue"
		if long(data)>255 then
			messagebox('Errore!','Immettere un valore minore uguale a 255!')
			ls_colonna=dwo.name
			ll_old=getitemnumber(row,ls_colonna)
			post event ue_post_itemchanged(row, dwo.name,ll_old)
		end if
		if long(data)<0 then
			messagebox('Errore!','Immettere un valore maggiore uguale a 0!')
			ls_colonna=dwo.name
			ll_old=getitemnumber(row,ls_colonna)
			post event ue_post_itemchanged(row, dwo.name,ll_old)
		end if
end choose

end event

