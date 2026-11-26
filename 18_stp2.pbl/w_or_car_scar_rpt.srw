forward
global type w_or_car_scar_rpt from window
end type
type sle_pg from singlelineedit within w_or_car_scar_rpt
end type
type cb_1 from commandbutton within w_or_car_scar_rpt
end type
type cb_pg_prima from commandbutton within w_or_car_scar_rpt
end type
type cb_pg_dopo from commandbutton within w_or_car_scar_rpt
end type
type cb_preview from commandbutton within w_or_car_scar_rpt
end type
type cb_stampa from commandbutton within w_or_car_scar_rpt
end type
type cb_imp_st from commandbutton within w_or_car_scar_rpt
end type
type cb_6 from commandbutton within w_or_car_scar_rpt
end type
type cb_7 from commandbutton within w_or_car_scar_rpt
end type
type cb_salva_su_file from commandbutton within w_or_car_scar_rpt
end type
type sle_zoom from singlelineedit within w_or_car_scar_rpt
end type
type sle_copie from singlelineedit within w_or_car_scar_rpt
end type
type st_2 from statictext within w_or_car_scar_rpt
end type
type st_1 from statictext within w_or_car_scar_rpt
end type
type dw_1 from datawindow within w_or_car_scar_rpt
end type
end forward

global type w_or_car_scar_rpt from window
integer x = 23
integer y = 12
integer width = 3589
integer height = 1824
boolean titlebar = true
string title = "Stampa Carico Scarico Partite"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_post_open ( )
sle_pg sle_pg
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
dw_1 dw_1
end type
global w_or_car_scar_rpt w_or_car_scar_rpt

type variables
string is_solo_preziosi ='S'
integer ii_zoom=100

s_param_articoli s_parametri  
end variables

on w_or_car_scar_rpt.create
this.sle_pg=create sle_pg
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
this.dw_1=create dw_1
this.Control[]={this.sle_pg,&
this.cb_1,&
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
this.dw_1}
end on

on w_or_car_scar_rpt.destroy
destroy(this.sle_pg)
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
destroy(this.dw_1)
end on

event open;string ls_stato_1, ls_stato_2
 long ll_id_sog
s_parametri=message.powerobjectparm

if isnull(s_parametri.da_sog_comm) then s_parametri.da_sog_comm='0000000000000000000000000'
if isnull(s_parametri.a_sog_comm) then s_parametri.a_sog_comm='ZZZZZZZZZZZZZZZZZZZZZZZZZ'
if isnull(s_parametri.da_categoria) then s_parametri.da_categoria='00000000'
if isnull(s_parametri.a_categoria) then s_parametri.a_categoria='ZZZZZZZZ'
if isnull(s_parametri.filtro) then s_parametri.filtro=''

ls_stato_1=s_parametri.solo_preziosi
if ls_stato_1='T' then
	ls_stato_1='A'
	ls_stato_2='C'
else
	ls_stato_2=ls_stato_1
end if
select id_sog_commerciale
into :ll_id_sog
from dba.sog_commerciale
where codice=: s_parametri.da_sog_comm ;
	
dw_1.settransobject(sqlca)
dw_1.retrieve( s_parametri.da_data,s_parametri.a_data, ll_id_sog)  //s_parametri.da_sog_comm)   // ll_id_sog, s_parametri.da_categoria, s_parametri.a_categoria, ls_stato_1,ls_stato_2)

end event

event resize;dw_1.height=newheight - 225
dw_1.width=newwidth - 75
end event

type sle_pg from singlelineedit within w_or_car_scar_rpt
integer x = 1454
integer y = 32
integer width = 503
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_or_car_scar_rpt
integer x = 37
integer y = 36
integer width = 261
integer height = 88
integer taborder = 20
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

type cb_pg_prima from commandbutton within w_or_car_scar_rpt
integer x = 325
integer y = 36
integer width = 91
integer height = 88
integer taborder = 30
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

type cb_pg_dopo from commandbutton within w_or_car_scar_rpt
integer x = 434
integer y = 36
integer width = 91
integer height = 88
integer taborder = 40
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

type cb_preview from commandbutton within w_or_car_scar_rpt
integer x = 2295
integer y = 36
integer width = 261
integer height = 88
integer taborder = 80
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

type cb_stampa from commandbutton within w_or_car_scar_rpt
integer x = 3269
integer y = 36
integer width = 261
integer height = 88
integer taborder = 90
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

type cb_imp_st from commandbutton within w_or_car_scar_rpt
integer x = 2587
integer y = 36
integer width = 297
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imp. Stamp."
end type

event clicked;printsetup()
end event

type cb_6 from commandbutton within w_or_car_scar_rpt
integer x = 562
integer y = 36
integer width = 219
integer height = 88
integer taborder = 50
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

type cb_7 from commandbutton within w_or_car_scar_rpt
integer x = 933
integer y = 36
integer width = 242
integer height = 88
integer taborder = 70
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

type cb_salva_su_file from commandbutton within w_or_car_scar_rpt
integer x = 2917
integer y = 36
integer width = 320
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva su &File"
end type

event clicked;dw_1.SaveAs()
end event

type sle_zoom from singlelineedit within w_or_car_scar_rpt
integer x = 782
integer y = 32
integer width = 146
integer height = 92
integer taborder = 10
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

type sle_copie from singlelineedit within w_or_car_scar_rpt
integer x = 2117
integer y = 32
integer width = 165
integer height = 92
integer taborder = 110
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

type st_2 from statictext within w_or_car_scar_rpt
integer x = 1970
integer y = 40
integer width = 151
integer height = 76
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

type st_1 from statictext within w_or_car_scar_rpt
integer x = 1189
integer y = 40
integer width = 270
integer height = 76
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

type dw_1 from datawindow within w_or_car_scar_rpt
integer x = 23
integer y = 148
integer width = 3506
integer height = 1532
integer taborder = 120
string dataobject = "d_or_car_scar_rpt"
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

event sqlpreview;string ls_sql, ls_sql_2, ls_sql_unione
integer i, li_pos


if sqltype<>PreviewUpdate!	then
	ls_sql=sqlsyntax
	if s_parametri.filtro> " " then
		ls_sql_unione=ls_sql+" and orafo_metallo.codice= '"+s_parametri.filtro+"' "
	
		i=SetSQLPreview(ls_sql_unione)
		if i<>1 then
			messagebox("Errore!", "Filtro non applicato!")
		end if
	end if
	
end if

end event

