forward
global type w_orafo_st_lista_art_prezzo_veloce_gd from Window
end type
type cb_1 from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type cb_pg_prima from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type cb_pg_dopo from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type cb_preview from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type cb_stampa from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type cb_imp_st from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type cb_6 from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type cb_7 from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type cb_salva_su_file from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type sle_zoom from singlelineedit within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type sle_copie from singlelineedit within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type st_2 from statictext within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type st_1 from statictext within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type sle_pg from singlelineedit within w_orafo_st_lista_art_prezzo_veloce_gd
end type
type dw_1 from datawindow within w_orafo_st_lista_art_prezzo_veloce_gd
end type
end forward

global type w_orafo_st_lista_art_prezzo_veloce_gd from Window
int X=23
int Y=12
int Width=3589
int Height=1824
boolean TitleBar=true
string Title="STAMPA LISTINI"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_post_open ( )
cb_1 cb_1
cb_pg_prima cb_pg_prima
cb_pg_dopo cb_pg_dopo
cb_preview cb_preview
cb_stampa cb_stampa
cb_imp_st cb_imp_st
cb_6 cb_6
cb_7 cb_7
cb_salva_su_file cb_salva_su_file
sle_zoom sle_zoom
sle_copie sle_copie
st_2 st_2
st_1 st_1
sle_pg sle_pg
dw_1 dw_1
end type
global w_orafo_st_lista_art_prezzo_veloce_gd w_orafo_st_lista_art_prezzo_veloce_gd

type variables
integer ii_zoom=100
string is_filtro

end variables

on w_orafo_st_lista_art_prezzo_veloce_gd.create
this.cb_1=create cb_1
this.cb_pg_prima=create cb_pg_prima
this.cb_pg_dopo=create cb_pg_dopo
this.cb_preview=create cb_preview
this.cb_stampa=create cb_stampa
this.cb_imp_st=create cb_imp_st
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_salva_su_file=create cb_salva_su_file
this.sle_zoom=create sle_zoom
this.sle_copie=create sle_copie
this.st_2=create st_2
this.st_1=create st_1
this.sle_pg=create sle_pg
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_pg_prima,&
this.cb_pg_dopo,&
this.cb_preview,&
this.cb_stampa,&
this.cb_imp_st,&
this.cb_6,&
this.cb_7,&
this.cb_salva_su_file,&
this.sle_zoom,&
this.sle_copie,&
this.st_2,&
this.st_1,&
this.sle_pg,&
this.dw_1}
end on

on w_orafo_st_lista_art_prezzo_veloce_gd.destroy
destroy(this.cb_1)
destroy(this.cb_pg_prima)
destroy(this.cb_pg_dopo)
destroy(this.cb_preview)
destroy(this.cb_stampa)
destroy(this.cb_imp_st)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_salva_su_file)
destroy(this.sle_zoom)
destroy(this.sle_copie)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_pg)
destroy(this.dw_1)
end on

event open;String ls_nome_azienda, ls_filtro, ls_parametri, ls_ordinamento, ls_da_articolo, ls_a_articolo, ls_tipo_arrotondamento
Long	 ll_id_variazione
Integer li_cifra_arrotondamento, li_ret
string ls_sql
str_anag_art str_param

ls_filtro=message.StringParm
str_param=message.PowerObjectParm

is_filtro=str_param.filtro
ls_parametri=str_param.parametri
ls_ordinamento=str_param.ordinamento
ls_da_articolo=str_param.da_art
ls_a_articolo=str_param.a_art
ll_id_variazione=str_param.id_variazione






dw_1.SetTransObject(sqlca)



dw_1.Retrieve(ll_id_variazione, ls_da_articolo, ls_a_articolo, &
					str_param.id_valuta, str_param.cambio, str_param.num_dec , &
					str_param.tipo_arr)

If ls_ordinamento = 'A' then
	ls_ordinamento = 'codice'	
ElseIf ls_ordinamento = 'C' then
	ls_ordinamento = 'cat_com_articolo_codice'
ElseIf ls_ordinamento = 'M' then
	ls_ordinamento = 'cat_merceologica_codice'	
ElseIf ls_ordinamento = 'F' then
	ls_ordinamento = 'cat_fiscale_codice'
End If

dw_1.SetSort(ls_ordinamento)
dw_1.Sort()

this.event post ue_post_open()
dw_1.groupcalc()






end event

event resize;dw_1.height=newheight - 225
dw_1.width=newwidth - 75

end event

type cb_1 from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
int X=37
int Y=36
int Width=261
int Height=88
int TabOrder=20
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

type cb_pg_prima from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
int X=325
int Y=36
int Width=91
int Height=88
int TabOrder=20
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

type cb_pg_dopo from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
int X=434
int Y=36
int Width=91
int Height=88
int TabOrder=30
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

type cb_preview from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
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
	dw_1.object.datawindow.print.preview='no'
	dw_1.object.datawindow.print.preview.rulers='no'
end if
end event

type cb_stampa from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
int X=3269
int Y=36
int Width=261
int Height=88
int TabOrder=90
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

type cb_imp_st from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
int X=2587
int Y=36
int Width=297
int Height=88
int TabOrder=50
string Text="Imp. Stamp."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
end event

type cb_6 from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
int X=562
int Y=36
int Width=219
int Height=88
int TabOrder=40
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

type cb_7 from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
int X=933
int Y=36
int Width=242
int Height=88
int TabOrder=60
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

type cb_salva_su_file from commandbutton within w_orafo_st_lista_art_prezzo_veloce_gd
int X=2917
int Y=36
int Width=320
int Height=88
int TabOrder=100
string Text="Salva su &File"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.SaveAs()
end event

type sle_zoom from singlelineedit within w_orafo_st_lista_art_prezzo_veloce_gd
int X=782
int Y=32
int Width=146
int Height=92
int TabOrder=10
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

type sle_copie from singlelineedit within w_orafo_st_lista_art_prezzo_veloce_gd
int X=2117
int Y=32
int Width=165
int Height=92
int TabOrder=110
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

type st_2 from statictext within w_orafo_st_lista_art_prezzo_veloce_gd
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

type st_1 from statictext within w_orafo_st_lista_art_prezzo_veloce_gd
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

type sle_pg from singlelineedit within w_orafo_st_lista_art_prezzo_veloce_gd
int X=1454
int Y=32
int Width=503
int Height=92
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_orafo_st_lista_art_prezzo_veloce_gd
int X=23
int Y=144
int Width=3515
int Height=1536
int TabOrder=120
string DataObject="d_orafo_st_lista_art_prezzo_veloce_gdx"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event sqlpreview;
String ls_filtro
String Ls_SQLSyntax

str_anag_art str_param

str_param=message.PowerObjectParm

if str_param.flag='S' then
  ls_filtro=" prezzo >0  "
	ls_SQLSyntax = SQLSyntax + 'AND (' + ls_filtro + ')'
	if is_filtro>'' then
		ls_SQLSyntax+=" and ("+is_filtro+")"
	end if
	This.SetSQLPreview(ls_SQLSyntax)	
else
	if is_filtro>'' then
		ls_SQLSyntax = SQLSyntax +" and ("+is_filtro+")"
		This.SetSQLPreview(ls_SQLSyntax)	
	end if
	
end if



end event

