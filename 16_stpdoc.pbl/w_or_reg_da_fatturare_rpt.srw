forward
global type w_or_reg_da_fatturare_rpt from window
end type
type sle_pg from singlelineedit within w_or_reg_da_fatturare_rpt
end type
type st_1 from statictext within w_or_reg_da_fatturare_rpt
end type
type st_2 from statictext within w_or_reg_da_fatturare_rpt
end type
type sle_copie from singlelineedit within w_or_reg_da_fatturare_rpt
end type
type sle_zoom from singlelineedit within w_or_reg_da_fatturare_rpt
end type
type cb_salva_su_file from commandbutton within w_or_reg_da_fatturare_rpt
end type
type cb_7 from commandbutton within w_or_reg_da_fatturare_rpt
end type
type cb_6 from commandbutton within w_or_reg_da_fatturare_rpt
end type
type cb_imp_st from commandbutton within w_or_reg_da_fatturare_rpt
end type
type cb_stampa from commandbutton within w_or_reg_da_fatturare_rpt
end type
type cb_preview from commandbutton within w_or_reg_da_fatturare_rpt
end type
type cb_pg_dopo from commandbutton within w_or_reg_da_fatturare_rpt
end type
type cb_pg_prima from commandbutton within w_or_reg_da_fatturare_rpt
end type
type cb_1 from commandbutton within w_or_reg_da_fatturare_rpt
end type
type dw_1 from datawindow within w_or_reg_da_fatturare_rpt
end type
end forward

global type w_or_reg_da_fatturare_rpt from window
integer x = 22
integer y = 13
integer width = 3599
integer height = 1808
boolean titlebar = true
string title = "Stampa Totali Fatturato per Soggetto/Codice IVA"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
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
global w_or_reg_da_fatturare_rpt w_or_reg_da_fatturare_rpt

type variables
integer ii_zoom=100
end variables

on w_or_reg_da_fatturare_rpt.create
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

on w_or_reg_da_fatturare_rpt.destroy
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

event open;s_param_articoli s_parametri   
s_parametri=message.powerobjectparm



if isnull(s_parametri.da_sog_comm) then s_parametri.da_sog_comm='0000000000000000000000000'
if isnull(s_parametri.a_sog_comm) then s_parametri.a_sog_comm='ZZZZZZZZZZZZZZZZZZZZZZZZZ'
if isnull(s_parametri.da_cod_art) then s_parametri.da_cod_art='0000000000000000000000000'
if isnull(s_parametri.a_cod_art) then s_parametri.a_cod_art='ZZZZZZZZZZZZZZZZZZZZZZZZZ'
if isnull(s_parametri.da_categoria) then s_parametri.da_categoria='0000000000'
if isnull(s_parametri.a_categoria) then s_parametri.a_categoria='ZZZZZZZZZZ'



if isnull(s_parametri.filtro) then s_parametri.filtro='Nessun filtro'
	
dw_1.dataobject=s_parametri.par_stampa

dw_1.settransobject(sqlca)
	dw_1.retrieve(s_parametri.da_data,s_parametri.a_data, &
 s_parametri.da_sog_comm, s_parametri.a_sog_comm,s_parametri.da_categoria,&
 s_parametri.a_categoria,s_parametri.da_cod_art,s_parametri.a_cod_art, &
 s_parametri.tipo_stampa)
 
 dw_1.object.filtro.text=s_parametri.filtro


end event

event resize;dw_1.height=newheight - 225
dw_1.width=newwidth - 75
end event

type sle_pg from singlelineedit within w_or_reg_da_fatturare_rpt
integer x = 1456
integer y = 32
integer width = 505
integer height = 93
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_or_reg_da_fatturare_rpt
integer x = 1189
integer y = 42
integer width = 271
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Stampa Pg.:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_or_reg_da_fatturare_rpt
integer x = 1971
integer y = 42
integer width = 150
integer height = 77
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Copie:"
boolean focusrectangle = false
end type

type sle_copie from singlelineedit within w_or_reg_da_fatturare_rpt
integer x = 2117
integer y = 32
integer width = 165
integer height = 93
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_zoom from singlelineedit within w_or_reg_da_fatturare_rpt
integer x = 783
integer y = 32
integer width = 146
integer height = 93
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;ii_zoom=integer(this.text)
dw_1.object.datawindow.zoom=ii_zoom

end event

type cb_salva_su_file from commandbutton within w_or_reg_da_fatturare_rpt
integer x = 2918
integer y = 35
integer width = 322
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva su &File"
end type

event clicked;dw_1.SaveAs()
end event

type cb_7 from commandbutton within w_or_reg_da_fatturare_rpt
integer x = 933
integer y = 35
integer width = 241
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom Out"
end type

event clicked;ii_zoom=ii_zoom - 5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_6 from commandbutton within w_or_reg_da_fatturare_rpt
integer x = 563
integer y = 35
integer width = 219
integer height = 90
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom In"
end type

event clicked;ii_zoom=ii_zoom+5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_imp_st from commandbutton within w_or_reg_da_fatturare_rpt
integer x = 2586
integer y = 35
integer width = 296
integer height = 90
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imp. Stamp."
end type

event clicked;printsetup()
dw_1.object.datawindow.print.preview='yes'
dw_1.object.datawindow.print.preview.rulers='yes'
end event

type cb_stampa from commandbutton within w_or_reg_da_fatturare_rpt
integer x = 3269
integer y = 35
integer width = 260
integer height = 90
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
end type

event clicked;printsetup()
dw_1.print()
end event

type cb_preview from commandbutton within w_or_reg_da_fatturare_rpt
integer x = 2297
integer y = 35
integer width = 260
integer height = 90
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview"
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

type cb_pg_dopo from commandbutton within w_or_reg_da_fatturare_rpt
integer x = 435
integer y = 35
integer width = 91
integer height = 90
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_pg_prima from commandbutton within w_or_reg_da_fatturare_rpt
integer x = 325
integer y = 35
integer width = 91
integer height = 90
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_1 from commandbutton within w_or_reg_da_fatturare_rpt
integer x = 37
integer y = 35
integer width = 260
integer height = 90
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_or_reg_da_fatturare_rpt
integer x = 22
integer y = 154
integer width = 3507
integer height = 1530
integer taborder = 120
string dataobject = "d_or_reg_fattura_rpt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

