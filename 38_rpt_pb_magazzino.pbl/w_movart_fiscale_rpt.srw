forward
global type w_movart_fiscale_rpt from Window
end type
type cb_preview from commandbutton within w_movart_fiscale_rpt
end type
type cb_2 from commandbutton within w_movart_fiscale_rpt
end type
type cb_7 from commandbutton within w_movart_fiscale_rpt
end type
type cb_6 from commandbutton within w_movart_fiscale_rpt
end type
type cb_5 from commandbutton within w_movart_fiscale_rpt
end type
type cb_4 from commandbutton within w_movart_fiscale_rpt
end type
type dw_rpt1 from datawindow within w_movart_fiscale_rpt
end type
type cb_3 from commandbutton within w_movart_fiscale_rpt
end type
type cb_1 from commandbutton within w_movart_fiscale_rpt
end type
end forward

global type w_movart_fiscale_rpt from Window
int X=5
int Y=364
int Width=3474
int Height=816
boolean TitleBar=true
string Title="Stampa articoli invenduti"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_preview cb_preview
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_rpt1 dw_rpt1
cb_3 cb_3
cb_1 cb_1
end type
global w_movart_fiscale_rpt w_movart_fiscale_rpt

type variables
long il_zoom
end variables

event ue_post_open;dw_rpt1.Height=(this.Height) - 272
end event

event open;datawindow dw_2
string ls_a_articolo, ls_da_articolo,ls_da_mag_cod, ls_a_mag_cod,ls_tipo_stampa
date ld_da_data_doc, ld_a_data_doc
dw_2=message.PowerObjectParm
integer li_da_anno, li_a_anno,li_da_mese, li_a_mese


ls_tipo_stampa = dw_2.Object.tipo_stampa[1]

ls_da_articolo = dw_2.Object.da_articolo[1]
ls_a_articolo  = dw_2.Object.a_articolo[1]
if isnull(ls_da_articolo) then ls_da_articolo=''
if isnull(ls_a_articolo) then ls_a_articolo='ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ'


ld_da_data_doc = dw_2.Object.da_data_doc[1]
ld_a_data_doc = dw_2.Object.a_data_doc[1]
if isnull(ld_da_data_doc) then ld_da_data_doc=date('01/01/1970')
if isnull(ld_a_data_doc) then ld_a_data_doc=date('01/12/2020')
li_da_anno=year(ld_da_data_doc)
li_a_anno=year(ld_a_data_doc)
	li_da_mese=month(ld_da_data_doc)
	li_a_mese=month(ld_a_data_doc)
	li_da_mese=1
	li_a_mese=12





ls_da_mag_cod = dw_2.Object.da_mag_cod[1]
ls_a_mag_cod = dw_2.Object.a_mag_cod[1]
if isnull(ls_da_mag_cod) then ls_da_mag_cod=''
if isnull(ls_a_mag_cod) then ls_a_mag_cod='ZZZZZZZZ'


dw_rpt1.settransobject(sqlca)
dw_rpt1.retrieve(ls_da_articolo, ls_a_articolo, ls_da_mag_cod,ls_a_mag_cod,li_da_anno, li_a_anno, li_da_mese,li_a_mese)

dw_rpt1.object.datawindow.print.preview='yes'
dw_rpt1.object.datawindow.print.preview.rulers='yes'
end event

on w_movart_fiscale_rpt.create
this.cb_preview=create cb_preview
this.cb_2=create cb_2
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_rpt1=create dw_rpt1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_preview,&
this.cb_2,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_rpt1,&
this.cb_3,&
this.cb_1}
end on

on w_movart_fiscale_rpt.destroy
destroy(this.cb_preview)
destroy(this.cb_2)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_rpt1)
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

type cb_preview from commandbutton within w_movart_fiscale_rpt
int X=1710
int Y=40
int Width=466
int Height=84
int TabOrder=41
boolean Visible=false
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_rpt1.object.datawindow.print.preview='yes'
dw_rpt1.object.datawindow.print.preview.rulers='yes'
end event

type cb_2 from commandbutton within w_movart_fiscale_rpt
int X=2770
int Y=40
int Width=389
int Height=84
int TabOrder=40
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_rpt1.SaveAs()
end event

type cb_7 from commandbutton within w_movart_fiscale_rpt
event clicked pbm_bnclicked
int X=2199
int Y=40
int Width=261
int Height=84
int TabOrder=30
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_rpt1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_movart_fiscale_rpt
event clicked pbm_bnclicked
int X=1915
int Y=40
int Width=261
int Height=84
int TabOrder=50
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_rpt1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_movart_fiscale_rpt
int X=622
int Y=40
int Width=457
int Height=84
int TabOrder=60
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_rpt1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_movart_fiscale_rpt
int X=1102
int Y=40
int Width=466
int Height=84
int TabOrder=20
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_rpt1.ScrollNextPage ( ) 
end event

type dw_rpt1 from datawindow within w_movart_fiscale_rpt
int X=32
int Y=144
int Width=3397
int Height=324
int TabOrder=70
string DataObject="d_movart_fiscale_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;
end event

event retrieverow;
	
end event

type cb_3 from commandbutton within w_movart_fiscale_rpt
int X=3177
int Y=40
int Width=247
int Height=84
int TabOrder=10
string Text="Stam&pa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_rpt1.print()
end event

type cb_1 from commandbutton within w_movart_fiscale_rpt
int X=37
int Y=40
int Width=247
int Height=84
int TabOrder=80
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

