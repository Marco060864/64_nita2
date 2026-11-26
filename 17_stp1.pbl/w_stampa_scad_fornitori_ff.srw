forward
global type w_stampa_scad_fornitori_ff from Window
end type
type cb_7 from commandbutton within w_stampa_scad_fornitori_ff
end type
type cb_6 from commandbutton within w_stampa_scad_fornitori_ff
end type
type cb_1 from commandbutton within w_stampa_scad_fornitori_ff
end type
type cb_5 from commandbutton within w_stampa_scad_fornitori_ff
end type
type cb_4 from commandbutton within w_stampa_scad_fornitori_ff
end type
type cb_3 from commandbutton within w_stampa_scad_fornitori_ff
end type
type cb_2 from commandbutton within w_stampa_scad_fornitori_ff
end type
type dw_1 from datawindow within w_stampa_scad_fornitori_ff
end type
end forward

global type w_stampa_scad_fornitori_ff from Window
int X=9
int Y=48
int Width=3735
int Height=2376
boolean TitleBar=true
string Title="Estratto Conto"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_7 cb_7
cb_6 cb_6
cb_1 cb_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
dw_1 dw_1
end type
global w_stampa_scad_fornitori_ff w_stampa_scad_fornitori_ff

type variables
long il_zoom
end variables

on w_stampa_scad_fornitori_ff.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_1=create cb_1
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_1=create dw_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_1,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.dw_1}
end on

on w_stampa_scad_fornitori_ff.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
long ll_apertura, ll_chiusura, ll_decimali
string ls_valuta
decimal ld_cambio


s_passa_date str_parametri  

str_parametri=message.powerobjectparm

dw_1.settransobject(sqlca)
dw_1.retrieve(str_parametri.da_id_conto,str_parametri.data_inizio_estratto)

il_zoom=100




end event

type cb_7 from commandbutton within w_stampa_scad_fornitori_ff
int X=2921
int Y=40
int Width=315
int Height=92
int TabOrder=60
boolean Visible=false
string Text="Salva su file"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type cb_6 from commandbutton within w_stampa_scad_fornitori_ff
int X=2313
int Y=40
int Width=297
int Height=92
int TabOrder=50
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom


end event

type cb_1 from commandbutton within w_stampa_scad_fornitori_ff
int X=1975
int Y=40
int Width=297
int Height=92
int TabOrder=60
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_scad_fornitori_ff
int X=41
int Y=40
int Width=247
int Height=92
int TabOrder=70
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type cb_4 from commandbutton within w_stampa_scad_fornitori_ff
int X=1161
int Y=40
int Width=466
int Height=92
int TabOrder=40
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_3 from commandbutton within w_stampa_scad_fornitori_ff
int X=672
int Y=40
int Width=466
int Height=92
int TabOrder=30
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 

end event

type cb_2 from commandbutton within w_stampa_scad_fornitori_ff
int X=3323
int Y=40
int Width=247
int Height=92
int TabOrder=20
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()
end event

type dw_1 from datawindow within w_stampa_scad_fornitori_ff
int X=32
int Y=160
int Width=3648
int Height=2104
int TabOrder=10
string DataObject="d_scad_ordine_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

