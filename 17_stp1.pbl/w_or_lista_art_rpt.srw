forward
global type w_or_lista_art_rpt from Window
end type
type sle_pg from singlelineedit within w_or_lista_art_rpt
end type
type st_1 from statictext within w_or_lista_art_rpt
end type
type st_2 from statictext within w_or_lista_art_rpt
end type
type sle_copie from singlelineedit within w_or_lista_art_rpt
end type
type sle_zoom from singlelineedit within w_or_lista_art_rpt
end type
type cb_salva_su_file from commandbutton within w_or_lista_art_rpt
end type
type cb_7 from commandbutton within w_or_lista_art_rpt
end type
type cb_6 from commandbutton within w_or_lista_art_rpt
end type
type cb_imp_st from commandbutton within w_or_lista_art_rpt
end type
type cb_stampa from commandbutton within w_or_lista_art_rpt
end type
type cb_preview from commandbutton within w_or_lista_art_rpt
end type
type cb_pg_dopo from commandbutton within w_or_lista_art_rpt
end type
type cb_pg_prima from commandbutton within w_or_lista_art_rpt
end type
type cb_1 from commandbutton within w_or_lista_art_rpt
end type
type dw_1 from datawindow within w_or_lista_art_rpt
end type
end forward

global type w_or_lista_art_rpt from Window
int X=23
int Y=12
int Width=3598
int Height=1808
boolean TitleBar=true
string Title="Lista Articoli"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_post_open ( )
sle_pg sle_pg
st_1 st_1
st_2 st_2
sle_copie sle_copie
sle_zoom sle_zoom
cb_salva_su_file cb_salva_su_file
cb_7 cb_7
cb_6 cb_6
cb_imp_st cb_imp_st
cb_stampa cb_stampa
cb_preview cb_preview
cb_pg_dopo cb_pg_dopo
cb_pg_prima cb_pg_prima
cb_1 cb_1
dw_1 dw_1
end type
global w_or_lista_art_rpt w_or_lista_art_rpt

type variables
long id_titolo[]
integer ii_zoom=100
end variables

on w_or_lista_art_rpt.create
this.sle_pg=create sle_pg
this.st_1=create st_1
this.st_2=create st_2
this.sle_copie=create sle_copie
this.sle_zoom=create sle_zoom
this.cb_salva_su_file=create cb_salva_su_file
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_imp_st=create cb_imp_st
this.cb_stampa=create cb_stampa
this.cb_preview=create cb_preview
this.cb_pg_dopo=create cb_pg_dopo
this.cb_pg_prima=create cb_pg_prima
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.sle_pg,&
this.st_1,&
this.st_2,&
this.sle_copie,&
this.sle_zoom,&
this.cb_salva_su_file,&
this.cb_7,&
this.cb_6,&
this.cb_imp_st,&
this.cb_stampa,&
this.cb_preview,&
this.cb_pg_dopo,&
this.cb_pg_prima,&
this.cb_1,&
this.dw_1}
end on

on w_or_lista_art_rpt.destroy
destroy(this.sle_pg)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_copie)
destroy(this.sle_zoom)
destroy(this.cb_salva_su_file)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_imp_st)
destroy(this.cb_stampa)
destroy(this.cb_preview)
destroy(this.cb_pg_dopo)
destroy(this.cb_pg_prima)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;string ls_test, ls_tikal
decimal ls_DA_TIT, ls_a_tit
s_param_articoli s_parametri   
s_parametri=message.powerobjectparm



if isnull(s_parametri.da_cod_art) then s_parametri.da_cod_art=' '
if isnull(s_parametri.a_cod_art) then s_parametri.a_cod_art='ZZZZZZZZZZZZZZZZZZZZZZZZZ'
if isnull(s_parametri.da_categoria)  then s_parametri.da_categoria=' '
if isnull(s_parametri.a_categoria) or s_parametri.a_categoria='' then s_parametri.a_categoria='ZZZZZZZZ'
if isnull(s_parametri.filtro) then s_parametri.filtro='Nessun filtro'
	
if upperbound(s_parametri.li_titolo)>0 then
	select titolo
	into :ls_da_tit
	from orafo_titolo
	where id_titolo=:s_parametri.li_titolo[1];
	select titolo
	into :ls_a_tit
	from orafo_titolo
	where id_titolo=:s_parametri.li_titolo[2];
else
	ls_da_tit=0
	ls_a_tit=2000
end if
	
dw_1.settransobject(sqlca)

	dw_1.retrieve(s_parametri.da_cod_art,s_parametri.a_cod_art, s_parametri.filtro,&
		s_parametri.da_categoria, s_parametri.a_categoria,&
		ls_da_tit, ls_a_tit )
		

end event

event resize;dw_1.height=newheight - 225
dw_1.width=newwidth - 75
end event

type sle_pg from singlelineedit within w_or_lista_art_rpt
int X=1454
int Y=32
int Width=503
int Height=92
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_or_lista_art_rpt
int X=1189
int Y=40
int Width=270
int Height=76
boolean Enabled=false
string Text="Stampa Pg.:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_or_lista_art_rpt
int X=1970
int Y=40
int Width=151
int Height=76
boolean Enabled=false
string Text="Copie:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_copie from singlelineedit within w_or_lista_art_rpt
int X=2117
int Y=32
int Width=165
int Height=92
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_zoom from singlelineedit within w_or_lista_art_rpt
int X=782
int Y=32
int Width=146
int Height=92
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="100"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;ii_zoom=integer(this.text)
dw_1.object.datawindow.zoom=ii_zoom

end event

type cb_salva_su_file from commandbutton within w_or_lista_art_rpt
int X=2917
int Y=36
int Width=320
int Height=88
int TabOrder=40
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_or_lista_art_rpt
int X=933
int Y=36
int Width=242
int Height=88
int TabOrder=30
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_zoom=ii_zoom - 5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_6 from commandbutton within w_or_lista_art_rpt
int X=562
int Y=36
int Width=219
int Height=88
int TabOrder=90
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_zoom=ii_zoom+5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_imp_st from commandbutton within w_or_lista_art_rpt
int X=2587
int Y=36
int Width=297
int Height=88
int TabOrder=20
string Text="Imp. Stamp."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.object.datawindow.print.preview='yes'
dw_1.object.datawindow.print.preview.rulers='yes'
end event

type cb_stampa from commandbutton within w_or_lista_art_rpt
int X=3269
int Y=36
int Width=261
int Height=88
int TabOrder=10
string Text="&Stampa"
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

type cb_preview from commandbutton within w_or_lista_art_rpt
int X=2295
int Y=36
int Width=261
int Height=88
int TabOrder=70
string Text="Preview"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_1.object.datawindow.print.preview='yes'
	dw_1.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_1.object.datawindow.print.preview='No'
	dw_1.object.datawindow.print.preview.rulers='no'
end if
end event

type cb_pg_dopo from commandbutton within w_or_lista_art_rpt
int X=434
int Y=36
int Width=91
int Height=88
int TabOrder=80
string Text=">"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_pg_prima from commandbutton within w_or_lista_art_rpt
int X=325
int Y=36
int Width=91
int Height=88
int TabOrder=100
string Text="<"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_1 from commandbutton within w_or_lista_art_rpt
int X=37
int Y=36
int Width=261
int Height=88
int TabOrder=110
string Text="&Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_or_lista_art_rpt
int X=18
int Y=152
int Width=3506
int Height=1528
int TabOrder=120
string DataObject="d_orafo_st_ana_articoli"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event printpage;
end event

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event sqlpreview;
end event

