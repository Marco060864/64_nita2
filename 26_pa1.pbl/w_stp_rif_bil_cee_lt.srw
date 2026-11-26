forward
global type w_stp_rif_bil_cee_lt from Window
end type
type cb_7 from commandbutton within w_stp_rif_bil_cee_lt
end type
type cb_6 from commandbutton within w_stp_rif_bil_cee_lt
end type
type cb_1 from commandbutton within w_stp_rif_bil_cee_lt
end type
type cb_5 from commandbutton within w_stp_rif_bil_cee_lt
end type
type cb_4 from commandbutton within w_stp_rif_bil_cee_lt
end type
type cb_3 from commandbutton within w_stp_rif_bil_cee_lt
end type
type cb_2 from commandbutton within w_stp_rif_bil_cee_lt
end type
type dw_1 from datawindow within w_stp_rif_bil_cee_lt
end type
end forward

global type w_stp_rif_bil_cee_lt from Window
int X=9
int Y=48
int Width=2670
int Height=2180
boolean TitleBar=true
string Title="Lista riferimenti cee"
long BackColor=78682240
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
global w_stp_rif_bil_cee_lt w_stp_rif_bil_cee_lt

type variables
long il_zoom
end variables

on w_stp_rif_bil_cee_lt.create
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

on w_stp_rif_bil_cee_lt.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_1)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_1)
end on

event open;

dw_1.settransobject(sqlca)
dw_1.retrieve()


end event

type cb_7 from commandbutton within w_stp_rif_bil_cee_lt
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

type cb_6 from commandbutton within w_stp_rif_bil_cee_lt
int X=1659
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

type cb_1 from commandbutton within w_stp_rif_bil_cee_lt
int X=1321
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

type cb_5 from commandbutton within w_stp_rif_bil_cee_lt
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

type cb_4 from commandbutton within w_stp_rif_bil_cee_lt
int X=809
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

type cb_3 from commandbutton within w_stp_rif_bil_cee_lt
int X=320
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

type cb_2 from commandbutton within w_stp_rif_bil_cee_lt
int X=2322
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

type dw_1 from datawindow within w_stp_rif_bil_cee_lt
int X=41
int Y=156
int Width=2551
int Height=1900
int TabOrder=10
string DataObject="d_lista_cee_lt"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

