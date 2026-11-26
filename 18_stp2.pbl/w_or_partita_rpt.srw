forward
global type w_or_partita_rpt from window
end type
type cbx_filtro from checkbox within w_or_partita_rpt
end type
type cbx_no_dettaglio from checkbox within w_or_partita_rpt
end type
type cb_1 from commandbutton within w_or_partita_rpt
end type
type cb_pg_prima from commandbutton within w_or_partita_rpt
end type
type cb_pg_dopo from commandbutton within w_or_partita_rpt
end type
type cb_preview from commandbutton within w_or_partita_rpt
end type
type cb_stampa from commandbutton within w_or_partita_rpt
end type
type cb_imp_st from commandbutton within w_or_partita_rpt
end type
type cb_6 from commandbutton within w_or_partita_rpt
end type
type cb_7 from commandbutton within w_or_partita_rpt
end type
type cb_salva_su_file from commandbutton within w_or_partita_rpt
end type
type sle_zoom from singlelineedit within w_or_partita_rpt
end type
type sle_copie from singlelineedit within w_or_partita_rpt
end type
type st_2 from statictext within w_or_partita_rpt
end type
type st_1 from statictext within w_or_partita_rpt
end type
type sle_pg from singlelineedit within w_or_partita_rpt
end type
type dw_1 from datawindow within w_or_partita_rpt
end type
end forward

global type w_or_partita_rpt from window
integer x = 22
integer y = 13
integer width = 3588
integer height = 1824
boolean titlebar = true
string title = "Stampa Partite Orafe"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 79741120
event ue_post_open ( )
cbx_filtro cbx_filtro
cbx_no_dettaglio cbx_no_dettaglio
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
global w_or_partita_rpt w_or_partita_rpt

type variables
integer ii_zoom=100 
string is_per_causale
end variables

on w_or_partita_rpt.create
this.cbx_filtro=create cbx_filtro
this.cbx_no_dettaglio=create cbx_no_dettaglio
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
this.Control[]={this.cbx_filtro,&
this.cbx_no_dettaglio,&
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
this.sle_pg,&
this.dw_1}
end on

on w_or_partita_rpt.destroy
destroy(this.cbx_filtro)
destroy(this.cbx_no_dettaglio)
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

event open;string ls_test, ls_tipo_partita,ls_num_doc, ls_tipo_par_aperta
s_param_articoli s_parametri   
long ll_id_sog, li_righe, ll_riga, ll_id_partita
date ldt_data_doc
decimal ldc_val_apertura
integer i
DATASTORE DS_APER_INTEGRE

s_parametri=message.powerobjectparm

is_per_causale=s_parametri.ordinamento

if isnull(s_parametri.da_sog_comm) then s_parametri.da_sog_comm='0000000000000000000000000'
if isnull(s_parametri.a_sog_comm) then s_parametri.a_sog_comm='ZZZZZZZZZZZZZZZZZZZZZZZZZ'

if s_parametri.da_categoria>"" then
	dw_1.dataobject =	s_parametri.da_categoria
else
	dw_1.dataobject =	"d_or_par_mov_tb"
end if
select id_sog_commerciale
into :ll_id_sog
from dba.sog_commerciale
where codice=:s_parametri.da_sog_comm
	;
dw_1.settransobject(sqlca)

if s_parametri.li_titolo[2]>0 then
	select cod_tipo_partita
	into :ls_tipo_partita
	from orafo_tipo_partita t, caus_magazzino c
	where t.id_tipo_partita=c.id_tipo_partita
	and c.id_caus_magazzino=:s_parametri.li_titolo[2];
	ls_tipo_par_aperta="A"+right(ls_tipo_partita, 3)
end if
if s_parametri.da_categoria="d_or_partite_a_data" then
	dw_1.retrieve(s_parametri.da_data, s_parametri.a_data,s_parametri.li_titolo[1],ll_id_sog,s_parametri.li_titolo[2] )
	DS_APER_INTEGRE=CREATE DATASTORE
	DS_APER_INTEGRE.dataobject="d_par_aperte_integre"
	DS_APER_INTEGRE.settransobject(sqlca)
	
	li_righe=DS_APER_INTEGRE.retrieve(s_parametri.da_data, s_parametri.a_data,s_parametri.li_titolo[1],ll_id_sog,ls_tipo_par_aperta)
	for i = 1 to li_righe
		ll_riga=dw_1.insertrow(0)
		ldt_data_doc=DS_APER_INTEGRE.getitemdate(i, "data_documento")
		ls_num_doc=DS_APER_INTEGRE.getitemstring(i, "num_documento")
		ldc_val_apertura=DS_APER_INTEGRE.getitemdecimal(i, "val_apertura")
		ll_id_partita=DS_APER_INTEGRE.getitemnumber(i, "id_partita")
		dw_1.setitem(ll_riga,"documento_num_documento_2", ls_num_doc)
		dw_1.setitem(ll_riga,"data_carico_1", ldt_data_doc)
		dw_1.setitem(ll_riga,"orafo_aper_partita_val_apertura_1", ldc_val_apertura)
		dw_1.setitem(ll_riga,"orafo_aper_partita_id_partita", ll_id_partita)
	next
	dw_1.sort()
	dw_1.groupcalc()
elseif  s_parametri.da_categoria="d_ver_scar_partite_con_riga_doc" then
	dw_1.retrieve(s_parametri.da_data, s_parametri.a_data,s_parametri.li_titolo[1],ll_id_sog,ls_tipo_partita )
else
	dw_1.retrieve(s_parametri.da_data, s_parametri.a_data,s_parametri.da_sog_comm, s_parametri.a_sog_comm)
end if
end event

event resize;dw_1.height=newheight - 225
dw_1.width=newwidth - 75

end event

type cbx_filtro from checkbox within w_or_partita_rpt
integer x = 59
integer y = 154
integer width = 322
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Tutti"
end type

event clicked;if checked then
	dw_1.setfilter("")
else
	dw_1.SetFilter(" round(c_scar_partita,2)<> round(c_riga_partita , 2) ")
end if
dw_1.filter()
end event

type cbx_no_dettaglio from checkbox within w_or_partita_rpt
integer x = 1488
integer y = 138
integer width = 344
integer height = 74
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "No dettaglio"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 0")
else
	dw_1.modify("datawindow.detail.height = 90")
end if
end event

type cb_1 from commandbutton within w_or_partita_rpt
integer x = 37
integer y = 35
integer width = 260
integer height = 90
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

type cb_pg_prima from commandbutton within w_or_partita_rpt
integer x = 325
integer y = 35
integer width = 91
integer height = 90
integer taborder = 20
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

type cb_pg_dopo from commandbutton within w_or_partita_rpt
integer x = 435
integer y = 35
integer width = 91
integer height = 90
integer taborder = 30
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

type cb_preview from commandbutton within w_or_partita_rpt
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

type cb_stampa from commandbutton within w_or_partita_rpt
integer x = 3269
integer y = 35
integer width = 260
integer height = 90
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

type cb_imp_st from commandbutton within w_or_partita_rpt
integer x = 2586
integer y = 35
integer width = 296
integer height = 90
integer taborder = 50
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

type cb_6 from commandbutton within w_or_partita_rpt
integer x = 563
integer y = 35
integer width = 219
integer height = 90
integer taborder = 40
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

type cb_7 from commandbutton within w_or_partita_rpt
integer x = 933
integer y = 35
integer width = 241
integer height = 90
integer taborder = 60
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

type cb_salva_su_file from commandbutton within w_or_partita_rpt
integer x = 2918
integer y = 35
integer width = 322
integer height = 90
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

type sle_zoom from singlelineedit within w_or_partita_rpt
integer x = 783
integer y = 32
integer width = 146
integer height = 93
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

type sle_copie from singlelineedit within w_or_partita_rpt
integer x = 2117
integer y = 32
integer width = 165
integer height = 93
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

type st_2 from statictext within w_or_partita_rpt
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

type st_1 from statictext within w_or_partita_rpt
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

type sle_pg from singlelineedit within w_or_partita_rpt
integer x = 1456
integer y = 32
integer width = 505
integer height = 93
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

type dw_1 from datawindow within w_or_partita_rpt
integer x = 22
integer y = 221
integer width = 3515
integer height = 1456
integer taborder = 120
string dataobject = "d_or_par_mov_tb"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

event sqlpreview;s_param_articoli s_lista_causali
integer i
string ls_sql

if is_per_causale='S' then
	open(w_sel_causali_st)
	s_lista_causali=message.powerobjectparm
	if isvalid(s_lista_causali) then
		for i=1 to upperbound(s_lista_causali.li_titolo)
			if i=1 then
				ls_sql+=" and (caus_magazzino.id_caus_magazzino= "+string(s_lista_causali.li_titolo[i])
			else
				ls_sql+=" or caus_magazzino.id_caus_magazzino= "+string(s_lista_causali.li_titolo[i])
			end if
		next
		ls_sql+=")"
	else
		close(parent)
		return
	end if
	i=SetSQLPreview(sqlsyntax+ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if
end event

