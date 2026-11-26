forward
global type w_stampa_doc_fattura from Window
end type
type cb_2 from commandbutton within w_stampa_doc_fattura
end type
type cb_7 from commandbutton within w_stampa_doc_fattura
end type
type cb_6 from commandbutton within w_stampa_doc_fattura
end type
type cb_5 from commandbutton within w_stampa_doc_fattura
end type
type cb_4 from commandbutton within w_stampa_doc_fattura
end type
type dw_1 from datawindow within w_stampa_doc_fattura
end type
type cb_3 from commandbutton within w_stampa_doc_fattura
end type
type cb_1 from commandbutton within w_stampa_doc_fattura
end type
end forward

global type w_stampa_doc_fattura from Window
int X=55
int Y=362
int Width=3657
int Height=1536
boolean TitleBar=true
string Title="Stampa articoli invenduti"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_stampa_doc_fattura w_stampa_doc_fattura

type variables
long il_zoom, il_id_doc

end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
dw_1.Object.DataWindow.Print.preview='yes'
end event

event open;
il_id_doc=message.doubleparm

dw_1.SetTransObject(sqlca)
dw_1.Retrieve(il_id_doc)



il_zoom=100
this.event post ue_post_open()
end event

on w_stampa_doc_fattura.create
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_stampa_doc_fattura.destroy
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

type cb_2 from commandbutton within w_stampa_doc_fattura
int X=2981
int Y=42
int Width=388
int Height=86
int TabOrder=31
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_stampa_doc_fattura
event clicked pbm_bnclicked
int X=2505
int Y=42
int Width=260
int Height=86
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

type cb_6 from commandbutton within w_stampa_doc_fattura
event clicked pbm_bnclicked
int X=2231
int Y=42
int Width=260
int Height=86
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

type cb_5 from commandbutton within w_stampa_doc_fattura
int X=680
int Y=42
int Width=468
int Height=86
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

type cb_4 from commandbutton within w_stampa_doc_fattura
int X=1163
int Y=42
int Width=468
int Height=86
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

type dw_1 from datawindow within w_stampa_doc_fattura
int X=18
int Y=150
int Width=3613
int Height=1261
int TabOrder=60
string DataObject="dw_rep_fat_base_prima2"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;

end event

type cb_3 from commandbutton within w_stampa_doc_fattura
int X=3387
int Y=42
int Width=249
int Height=86
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_1 from commandbutton within w_stampa_doc_fattura
int X=22
int Y=42
int Width=249
int Height=86
int TabOrder=70
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

