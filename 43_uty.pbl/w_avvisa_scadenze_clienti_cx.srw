forward
global type w_avvisa_scadenze_clienti_cx from Window
end type
type cb_2 from commandbutton within w_avvisa_scadenze_clienti_cx
end type
type cb_1 from commandbutton within w_avvisa_scadenze_clienti_cx
end type
type dw_1 from datawindow within w_avvisa_scadenze_clienti_cx
end type
end forward

global type w_avvisa_scadenze_clienti_cx from Window
int X=836
int Y=372
int Width=2201
int Height=877
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_avvisa_scadenze_clienti_cx w_avvisa_scadenze_clienti_cx

on w_avvisa_scadenze_clienti_cx.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={ this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_avvisa_scadenze_clienti_cx.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;long ll_anticipo, ll_righe
date ld_data

if Not(IsNull(ll_anticipo)) then
	ld_data=Relativedate(Today(),ll_anticipo)
	dw_1.settransobject(sqlca)
	dw_1.setfilter("data_scadenza <="+string(ld_data))
	dw_1.filter()
	dw_1.retrieve()
	ll_righe=dw_1.rowcount()
	if ll_righe=0 then close(this)
else
	close(this)
end if
end event

type cb_2 from commandbutton within w_avvisa_scadenze_clienti_cx
int X=1121
int Y=637
int Width=321
int Height=87
int TabOrder=3
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_avvisa_scadenze_clienti_cx
int X=726
int Y=637
int Width=246
int Height=87
int TabOrder=20
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_avvisa_scadenze_clienti_cx
int X=43
int Y=17
int Width=2073
int Height=583
int TabOrder=10
string DataObject="d_ordini_clienti_gd"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

