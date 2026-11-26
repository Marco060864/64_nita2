forward
global type w_or_saldi_rpt from window
end type
type rb_2 from radiobutton within w_or_saldi_rpt
end type
type rb_1 from radiobutton within w_or_saldi_rpt
end type
type cb_1 from commandbutton within w_or_saldi_rpt
end type
type cb_pg_prima from commandbutton within w_or_saldi_rpt
end type
type cb_pg_dopo from commandbutton within w_or_saldi_rpt
end type
type cb_preview from commandbutton within w_or_saldi_rpt
end type
type cb_stampa from commandbutton within w_or_saldi_rpt
end type
type cb_imp_st from commandbutton within w_or_saldi_rpt
end type
type cb_6 from commandbutton within w_or_saldi_rpt
end type
type cb_7 from commandbutton within w_or_saldi_rpt
end type
type cb_salva_su_file from commandbutton within w_or_saldi_rpt
end type
type sle_zoom from singlelineedit within w_or_saldi_rpt
end type
type sle_copie from singlelineedit within w_or_saldi_rpt
end type
type st_2 from statictext within w_or_saldi_rpt
end type
type st_1 from statictext within w_or_saldi_rpt
end type
type sle_pg from singlelineedit within w_or_saldi_rpt
end type
type dw_1 from datawindow within w_or_saldi_rpt
end type
end forward

global type w_or_saldi_rpt from window
integer x = 23
integer y = 12
integer width = 3589
integer height = 1936
boolean titlebar = true
string title = "Stampa Saldi Clienti/Fornitori"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_post_open ( )
rb_2 rb_2
rb_1 rb_1
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
global w_or_saldi_rpt w_or_saldi_rpt

type variables
integer ii_zoom=100
long il_esercizio
string is_cod_art
end variables

forward prototypes
public subroutine wf_zoom ()
end prototypes

public subroutine wf_zoom ();setredraw(false)
dw_1.setredraw(false)
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
setredraw(true)
dw_1.setredraw(true)
end subroutine

on w_or_saldi_rpt.create
this.rb_2=create rb_2
this.rb_1=create rb_1
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
this.Control[]={this.rb_2,&
this.rb_1,&
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

on w_or_saldi_rpt.destroy
destroy(this.rb_2)
destroy(this.rb_1)
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

event open;string ls_test, ls_utente
s_param_articoli s_parametri 
setredraw(false)
dw_1.setredraw(false)
s_parametri=message.powerobjectparm

is_cod_art=s_parametri.da_cod_art

if s_parametri.ll_magazzino>0 then il_esercizio=s_parametri.ll_magazzino

if isnull(s_parametri.da_sog_comm) then s_parametri.da_sog_comm='0000000000000000000000000'
if isnull(s_parametri.a_sog_comm) then s_parametri.a_sog_comm='ZZZZZZZZZZZZZZZZZZZZZZZZZ'

dw_1.dataobject=s_parametri.totali_doc

dw_1.settransobject(sqlca)
dw_1.retrieve(s_parametri.da_data, s_parametri.a_data,s_parametri.da_sog_comm, s_parametri.a_sog_comm)
//sle_zoom.triggerevent(modified!)
dw_1.setredraw(true)
setredraw(true)
if s_parametri.totali_doc="d_or_saldi_tot_fino_e_legato" then
	select ut_utente
	into :ls_utente
	from dba.utenti
	where id_utenti=:u_freddie.s_utenti.i_idutente
	;
	dw_1.modify("t_utente.text='"+ls_utente+" - "+ string(today(), "dd/mm/yy hh:mm:ss")+"'")
end if

end event

event resize;dw_1.height=newheight - 225
dw_1.width=newwidth - 75

end event

type rb_2 from radiobutton within w_or_saldi_rpt
integer x = 946
integer y = 76
integer width = 370
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per codice:"
boolean checked = true
end type

event clicked;if checked then
	dw_1.SetRedraw(false)
	dw_1.setsort("orafo_metallo_codice, sog_commerciale_gen_codice, right(tipo_caus, 3) " + &
						"documento_data_documento,documento_data_ora_creazione, " + &
						"documento_num_documento, documento_id_documento, num_riga")
	dw_1.sort()
	dw_1.GroupCalc()

	dw_1.SetRedraw(true)
end if
end event

type rb_1 from radiobutton within w_or_saldi_rpt
integer x = 946
integer y = 16
integer width = 398
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Per Rag. Soc."
end type

event clicked;
if checked then
	dw_1.SetRedraw(false)
	dw_1.setsort("orafo_metallo_codice, sog_commerciale_gen_rag_soc_1, right(tipo_caus, 3) " + &
						"documento_data_documento,documento_data_ora_creazione, " + &
						"documento_num_documento, documento_id_documento, num_riga")
	dw_1.sort()
	dw_1.GroupCalc()

	dw_1.SetRedraw(true)
end if

end event

type cb_1 from commandbutton within w_or_saldi_rpt
integer x = 37
integer y = 36
integer width = 261
integer height = 92
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

type cb_pg_prima from commandbutton within w_or_saldi_rpt
integer x = 325
integer y = 36
integer width = 91
integer height = 92
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

type cb_pg_dopo from commandbutton within w_or_saldi_rpt
integer x = 434
integer y = 36
integer width = 91
integer height = 92
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

type cb_preview from commandbutton within w_or_saldi_rpt
integer x = 2295
integer y = 36
integer width = 261
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview"
end type

event clicked;dw_1.setredraw(false)
setredraw(false)
if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_1.object.datawindow.print.preview='yes'
	dw_1.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_1.object.datawindow.print.preview='no'
	dw_1.object.datawindow.print.preview.rulers='no'
end if
dw_1.setredraw(true)
setredraw(true)
end event

type cb_stampa from commandbutton within w_or_saldi_rpt
integer x = 3269
integer y = 36
integer width = 261
integer height = 92
integer taborder = 100
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

type cb_imp_st from commandbutton within w_or_saldi_rpt
integer x = 2587
integer y = 36
integer width = 297
integer height = 92
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
	dw_1.object.datawindow.print.preview='yes'
	dw_1.object.datawindow.print.preview.rulers='yes'
end event

type cb_6 from commandbutton within w_or_saldi_rpt
integer x = 544
integer y = 36
integer width = 110
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "In"
end type

event clicked;ii_zoom=ii_zoom+5
wf_zoom()

end event

type cb_7 from commandbutton within w_or_saldi_rpt
integer x = 805
integer y = 36
integer width = 110
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Out"
end type

event clicked;ii_zoom=ii_zoom - 5
wf_zoom()
end event

type cb_salva_su_file from commandbutton within w_or_saldi_rpt
integer x = 2917
integer y = 36
integer width = 320
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva su &File"
end type

event clicked;dw_1.SaveAs()
end event

type sle_zoom from singlelineedit within w_or_saldi_rpt
integer x = 654
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
wf_zoom()

end event

type sle_copie from singlelineedit within w_or_saldi_rpt
integer x = 2117
integer y = 32
integer width = 165
integer height = 92
integer taborder = 120
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

type st_2 from statictext within w_or_saldi_rpt
integer x = 1970
integer y = 44
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

type st_1 from statictext within w_or_saldi_rpt
integer x = 1353
integer y = 44
integer width = 165
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
string text = "St. Pg.:"
boolean focusrectangle = false
end type

type sle_pg from singlelineedit within w_or_saldi_rpt
integer x = 1513
integer y = 32
integer width = 448
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_or_saldi_rpt
integer x = 23
integer y = 156
integer width = 3515
integer height = 1532
integer taborder = 130
string dataobject = "d_or_saldi_mov_tb"
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

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "riga_documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if

		
end event

event sqlpreview;s_param_articoli s_lista_causali
integer i
string ls_sql
date ldt_data_inizio


if dw_1.dataobject="d_or_saldi_sel_cau" then
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
		ls_sql=sqlsyntax + ls_sql
		i=SetSQLPreview(ls_sql)
		if i<>1 then
			messagebox("Errore!", "Filtro causali non applicato!")
		end if
	end if
end if
if is_cod_art>"" then
	ls_sql=" and articolo.codice='"+is_cod_art+"' "
	ls_sql=sqlsyntax + ls_sql
	i=SetSQLPreview(ls_sql)
	if i<>1 then
		messagebox("Errore!", "Filtro causali non applicato!")
	end if
end if

if il_esercizio>0 then
	select data_inizio
	into :ldt_data_inizio
	from esercizio
	where id_esercizio=:il_esercizio;
	if ls_sql="" then ls_sql=sqlsyntax
	ls_sql+=" and (documento.data_documento>='"+string(ldt_data_inizio, "yyyy/mm/dd")+"')"
	i=SetSQLPreview(ls_sql)
end if
	
end event

