forward
global type w_st_lista_articoli_gd from Window
end type
type cb_2 from commandbutton within w_st_lista_articoli_gd
end type
type cb_7 from commandbutton within w_st_lista_articoli_gd
end type
type cb_6 from commandbutton within w_st_lista_articoli_gd
end type
type cb_5 from commandbutton within w_st_lista_articoli_gd
end type
type cb_4 from commandbutton within w_st_lista_articoli_gd
end type
type dw_1 from datawindow within w_st_lista_articoli_gd
end type
type cb_3 from commandbutton within w_st_lista_articoli_gd
end type
type cb_1 from commandbutton within w_st_lista_articoli_gd
end type
end forward

global type w_st_lista_articoli_gd from Window
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
cb_2 cb_2
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_st_lista_articoli_gd w_st_lista_articoli_gd

type variables
long il_zoom
end variables

event ue_post_open;dw_1.Height=(this.Height) - 272
end event

event open;String ls_filtro, ls_parametri, ls_ordinamento, ls_da_articolo, ls_a_articolo, ls_des_estesa
str_anag_art str_param

ls_filtro=message.StringParm
str_param=message.PowerObjectParm

ls_filtro=str_param.filtro
ls_parametri=str_param.parametri
ls_ordinamento=str_param.ordinamento
ls_da_articolo=str_param.da_art
ls_a_articolo=str_param.a_art

ls_des_estesa = str_param.des_estesa

if ls_des_estesa = "S" then 
	dw_1.object.articolo_descrizione.visible = 1
	dw_1.object.articolo_des_breve.visible   = 0
else 
	dw_1.object.articolo_descrizione.visible = 0
	dw_1.object.articolo_des_breve.visible   = 1	
end if

dw_1.SetTransObject(sqlca)
dw_1.Retrieve(ls_da_articolo, ls_a_articolo, ls_parametri, ls_ordinamento)

If ls_ordinamento = 'A' then
	ls_ordinamento = 'codice'	
ElseIf ls_ordinamento = 'C' then
	ls_ordinamento = 'cat_com_articolo_codice'
ElseIf ls_ordinamento = 'M' then
	ls_ordinamento = 'cat_merceologica_codice'	
ElseIf ls_ordinamento = 'F' then
	ls_ordinamento = 'cat_fiscale_codice'
Elseif ls_ordinamento = 'D' then
	if ls_des_estesa = "S" then 
		ls_ordinamento = 'articolo_descrizione'	
	else	
	   ls_ordinamento = 'articolo_des_breve'
	end if
End If

dw_1.SetSort(ls_ordinamento)
dw_1.Sort()

il_zoom=100
this.event post ue_post_open()
dw_1.groupcalc()
end event

on w_st_lista_articoli_gd.create
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

on w_st_lista_articoli_gd.destroy
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

type cb_2 from commandbutton within w_st_lista_articoli_gd
int X=2981
int Y=40
int Width=389
int Height=84
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

type cb_7 from commandbutton within w_st_lista_articoli_gd
event clicked pbm_bnclicked
int X=2505
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
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_st_lista_articoli_gd
event clicked pbm_bnclicked
int X=2231
int Y=40
int Width=261
int Height=84
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

type cb_5 from commandbutton within w_st_lista_articoli_gd
int X=681
int Y=40
int Width=466
int Height=84
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

type cb_4 from commandbutton within w_st_lista_articoli_gd
int X=1161
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

event clicked;dw_1.ScrollNextPage ( ) 
end event

type dw_1 from datawindow within w_st_lista_articoli_gd
int X=18
int Y=148
int Width=3611
int Height=1260
int TabOrder=60
string DataObject="d_st_lista_articoli_gd"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;String ls_filtro
String Ls_SQLSyntax

str_anag_art str_param

str_param=message.PowerObjectParm
ls_filtro=str_param.filtro

If (ls_filtro <> '') Then
	ls_SQLSyntax = SQLSyntax + 'AND (' + ls_filtro + ')'
	This.SetSQLPreview(ls_SQLSyntax)	
End If

end event

type cb_3 from commandbutton within w_st_lista_articoli_gd
int X=3387
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
dw_1.print()
end event

type cb_1 from commandbutton within w_st_lista_articoli_gd
int X=23
int Y=40
int Width=247
int Height=84
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

