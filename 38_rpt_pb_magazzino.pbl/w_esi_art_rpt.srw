forward
global type w_esi_art_rpt from Window
end type
type cb_7 from commandbutton within w_esi_art_rpt
end type
type cb_6 from commandbutton within w_esi_art_rpt
end type
type cb_5 from commandbutton within w_esi_art_rpt
end type
type cb_4 from commandbutton within w_esi_art_rpt
end type
type dw_1 from datawindow within w_esi_art_rpt
end type
type cb_3 from commandbutton within w_esi_art_rpt
end type
type cb_1 from commandbutton within w_esi_art_rpt
end type
end forward

global type w_esi_art_rpt from Window
int X=5
int Y=364
int Width=3657
int Height=1536
boolean TitleBar=true
string Title="Stampa articoli invenduti"
long BackColor=79741120
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
event ue_post_open ( )
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_esi_art_rpt w_esi_art_rpt

type variables
long il_zoom
long il_forn
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
end event

event open;String 	ls_filtro, ls_parametri, ls_da_articolo, ls_a_articolo, ls_util
Long	 	ll_id_esercizio, ll_id_sog_com
Integer	li_anno, li_mese
DateTime		ld_da_data

str_esi_art str_param

ls_filtro=message.StringParm
str_param=message.PowerObjectParm

ls_filtro=str_param.filtro
ls_parametri=str_param.parametri
ls_da_articolo=str_param.da_articolo
ls_a_articolo=str_param.a_articolo
ll_id_esercizio=str_param.id_esercizio
li_anno=str_param.anno
li_mese=str_param.mese
il_forn= str_param.id_soggetto_commerciale
ls_util= str_param.utilizzabile 

SELECT (data_inizio - 1)
INTO	 :ld_da_data
FROM	 esercizio
WHERE	 id_esercizio = :ll_id_esercizio
;

If SQLCA.SQLCODE = 0 Then
	if not isnull(il_forn) then
		dw_1.dataobject='d_esi_art_for_rpt'
		dw_1.SetTransObject(sqlca)	
   	dw_1.Retrieve(ls_da_articolo, ls_a_articolo, ld_da_data, li_anno, li_mese, ls_parametri,il_forn)
	else
		dw_1.SetTransObject(sqlca)
		dw_1.Retrieve(ls_da_articolo, ls_a_articolo, ld_da_data, li_anno, li_mese, ls_parametri)
	end if
	
	if ls_util = 'S' then
		ls_filtro = "articolo_utilizzabile = 'S'"
		dw_1.Setfilter(ls_filtro)
		dw_1.Filter()		
	end if
	
	il_zoom=100
	this.event post ue_post_open()
	dw_1.groupcalc()
Else
	MessageBox("", SQLCA.SQLErrText)
End If	
end event

on w_esi_art_rpt.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_esi_art_rpt.destroy
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

type cb_7 from commandbutton within w_esi_art_rpt
event clicked pbm_bnclicked
int X=2505
int Y=44
int Width=261
int Height=88
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

type cb_6 from commandbutton within w_esi_art_rpt
event clicked pbm_bnclicked
int X=2231
int Y=44
int Width=261
int Height=88
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

type cb_5 from commandbutton within w_esi_art_rpt
int X=681
int Y=44
int Width=466
int Height=88
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

type cb_4 from commandbutton within w_esi_art_rpt
int X=1161
int Y=44
int Width=466
int Height=88
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

type dw_1 from datawindow within w_esi_art_rpt
int X=18
int Y=152
int Width=3611
int Height=1260
int TabOrder=60
string DataObject="d_esi_art_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_3 from commandbutton within w_esi_art_rpt
int X=3387
int Y=44
int Width=247
int Height=88
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

type cb_1 from commandbutton within w_esi_art_rpt
int X=23
int Y=44
int Width=247
int Height=88
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

