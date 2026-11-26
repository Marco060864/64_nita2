forward
global type w_vedi_id_riga_lotto_doppi from Window
end type
type cb_righe_doc_doc from commandbutton within w_vedi_id_riga_lotto_doppi
end type
type dw_4 from datawindow within w_vedi_id_riga_lotto_doppi
end type
type st_4 from statictext within w_vedi_id_riga_lotto_doppi
end type
type st_3 from statictext within w_vedi_id_riga_lotto_doppi
end type
type cb_righe_doc from commandbutton within w_vedi_id_riga_lotto_doppi
end type
type dw_3 from datawindow within w_vedi_id_riga_lotto_doppi
end type
type st_2 from statictext within w_vedi_id_riga_lotto_doppi
end type
type st_1 from statictext within w_vedi_id_riga_lotto_doppi
end type
type cb_prog from commandbutton within w_vedi_id_riga_lotto_doppi
end type
type dw_2 from datawindow within w_vedi_id_riga_lotto_doppi
end type
type cb_salva from commandbutton within w_vedi_id_riga_lotto_doppi
end type
type cb_retrieve from commandbutton within w_vedi_id_riga_lotto_doppi
end type
type dw_1 from datawindow within w_vedi_id_riga_lotto_doppi
end type
end forward

global type w_vedi_id_riga_lotto_doppi from Window
int X=845
int Y=371
int Width=2915
int Height=1523
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_righe_doc_doc cb_righe_doc_doc
dw_4 dw_4
st_4 st_4
st_3 st_3
cb_righe_doc cb_righe_doc
dw_3 dw_3
st_2 st_2
st_1 st_1
cb_prog cb_prog
dw_2 dw_2
cb_salva cb_salva
cb_retrieve cb_retrieve
dw_1 dw_1
end type
global w_vedi_id_riga_lotto_doppi w_vedi_id_riga_lotto_doppi

on w_vedi_id_riga_lotto_doppi.create
this.cb_righe_doc_doc=create cb_righe_doc_doc
this.dw_4=create dw_4
this.st_4=create st_4
this.st_3=create st_3
this.cb_righe_doc=create cb_righe_doc
this.dw_3=create dw_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_prog=create cb_prog
this.dw_2=create dw_2
this.cb_salva=create cb_salva
this.cb_retrieve=create cb_retrieve
this.dw_1=create dw_1
this.Control[]={this.cb_righe_doc_doc,&
this.dw_4,&
this.st_4,&
this.st_3,&
this.cb_righe_doc,&
this.dw_3,&
this.st_2,&
this.st_1,&
this.cb_prog,&
this.dw_2,&
this.cb_salva,&
this.cb_retrieve,&
this.dw_1}
end on

on w_vedi_id_riga_lotto_doppi.destroy
destroy(this.cb_righe_doc_doc)
destroy(this.dw_4)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_righe_doc)
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_prog)
destroy(this.dw_2)
destroy(this.cb_salva)
destroy(this.cb_retrieve)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
end event

type cb_righe_doc_doc from commandbutton within w_vedi_id_riga_lotto_doppi
int X=2341
int Y=1226
int Width=523
int Height=61
int TabOrder=30
string Text="Salva righe doc_doc"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret
li_ret=dw_3.update()
if li_ret<>1 then 
	messagebox("Errore", "Salvataggio non effettuato")
else
	messagebox("Informazione", "Tutto OK!")
end if
end event

type dw_4 from datawindow within w_vedi_id_riga_lotto_doppi
int X=1251
int Y=691
int Width=1605
int Height=515
int TabOrder=30
string DataObject="d_riga_doc_doc"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_4 from statictext within w_vedi_id_riga_lotto_doppi
int X=1499
int Y=19
int Width=1093
int Height=70
boolean Enabled=false
string Text="Righe documento da id_riga_lotto"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_vedi_id_riga_lotto_doppi
int X=1302
int Y=627
int Width=1009
int Height=61
boolean Enabled=false
string Text="Righe documento da id_riga_documento"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_righe_doc from commandbutton within w_vedi_id_riga_lotto_doppi
int X=2326
int Y=624
int Width=523
int Height=61
int TabOrder=40
string Text="Salva righe doc_lotto"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret
li_ret=dw_3.update()
if li_ret<>1 then 
	messagebox("Errore", "Salvataggio non effettuato")
else
	messagebox("Informazione", "Tutto OK!")
end if
end event

type dw_3 from datawindow within w_vedi_id_riga_lotto_doppi
int X=1251
int Y=86
int Width=1605
int Height=515
int TabOrder=20
string DataObject="d_riga_doc"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;long ll_id_riga_doc
if currentrow>0 then
	ll_id_riga_doc=getitemnumber(currentrow, "riga_documento_id_documento")
	messagebox("W", ll_id_riga_doc)
	dw_4.retrieve(ll_id_riga_doc)
end if
end event

event clicked;
end event

type st_2 from statictext within w_vedi_id_riga_lotto_doppi
int X=1269
int Y=1216
int Width=274
int Height=67
boolean Enabled=false
string Text="<<<< Prog"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_vedi_id_riga_lotto_doppi
int X=848
int Width=274
int Height=77
boolean Enabled=false
string Text="<<<< DW_1"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_prog from commandbutton within w_vedi_id_riga_lotto_doppi
int X=1159
int Y=1306
int Width=402
int Height=106
int TabOrder=70
string Text="Salva Progressivi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret
li_ret=dw_2.update()
if li_ret<>1 then 
	messagebox("Errore", "Salvataggio non effettuato")
else
	messagebox("Informazione", "Tutto OK!")
end if
end event

type dw_2 from datawindow within w_vedi_id_riga_lotto_doppi
int X=59
int Y=1114
int Width=1185
int Height=160
int TabOrder=50
string DataObject="d_prog_lotti"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_salva from commandbutton within w_vedi_id_riga_lotto_doppi
int X=549
int Y=1306
int Width=373
int Height=106
int TabOrder=80
string Text="Salva dw_1"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_ret
li_ret=dw_1.update()
if li_ret<>1 then 
	messagebox("Errore", "Salvataggio non effettuato")
else
	messagebox("Informazione", "Tutto OK!")
end if
end event

type cb_retrieve from commandbutton within w_vedi_id_riga_lotto_doppi
int X=117
int Y=1302
int Width=325
int Height=106
int TabOrder=60
string Text="Mostra Doppi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_1.retrieve()

dw_2.retrieve()

end event

type dw_1 from datawindow within w_vedi_id_riga_lotto_doppi
int X=62
int Y=80
int Width=1181
int Height=1008
int TabOrder=10
string DataObject="d_vedi_id_riga_lotto_doppi"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;long ll_id_riga_lotto
if currentrow>0 then
	ll_id_riga_lotto=getitemnumber(currentrow, "id_riga_lotto")

	dw_3.retrieve(ll_id_riga_lotto)
	ll_id_riga_lotto=getitemnumber(currentrow, "id_doc")
	dw_4.retrieve(ll_id_riga_lotto)
end if
end event

