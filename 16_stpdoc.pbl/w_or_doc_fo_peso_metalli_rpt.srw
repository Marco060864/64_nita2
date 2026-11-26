forward
global type w_or_doc_fo_peso_metalli_rpt from window
end type
type cbx_vedi_righe from checkbox within w_or_doc_fo_peso_metalli_rpt
end type
type sle_pg from singlelineedit within w_or_doc_fo_peso_metalli_rpt
end type
type st_1 from statictext within w_or_doc_fo_peso_metalli_rpt
end type
type st_2 from statictext within w_or_doc_fo_peso_metalli_rpt
end type
type sle_copie from singlelineedit within w_or_doc_fo_peso_metalli_rpt
end type
type sle_zoom from singlelineedit within w_or_doc_fo_peso_metalli_rpt
end type
type cb_salva_su_file from commandbutton within w_or_doc_fo_peso_metalli_rpt
end type
type cb_7 from commandbutton within w_or_doc_fo_peso_metalli_rpt
end type
type cb_6 from commandbutton within w_or_doc_fo_peso_metalli_rpt
end type
type cb_imp_st from commandbutton within w_or_doc_fo_peso_metalli_rpt
end type
type cb_stampa from commandbutton within w_or_doc_fo_peso_metalli_rpt
end type
type cb_preview from commandbutton within w_or_doc_fo_peso_metalli_rpt
end type
type cb_pg_dopo from commandbutton within w_or_doc_fo_peso_metalli_rpt
end type
type cb_pg_prima from commandbutton within w_or_doc_fo_peso_metalli_rpt
end type
type cb_1 from commandbutton within w_or_doc_fo_peso_metalli_rpt
end type
type dw_1 from datawindow within w_or_doc_fo_peso_metalli_rpt
end type
end forward

global type w_or_doc_fo_peso_metalli_rpt from window
integer x = 22
integer y = 13
integer width = 3690
integer height = 1789
boolean titlebar = true
string title = "Stampa Documenti Fornitori Peso Metalli"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = popup!
long backcolor = 79741120
event ue_post_open ( )
cbx_vedi_righe cbx_vedi_righe
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
global w_or_doc_fo_peso_metalli_rpt w_or_doc_fo_peso_metalli_rpt

type variables
string is_solo_preziosi ='S', is_tipo_dw, is_num_doc
integer ii_zoom=100, ii_fiscale
long il_prof_derivato[], il_id_destinazione, il_num_prog
date idt_da_scadenza, idt_a_scadenza
s_param_articoli s_parametri  
end variables

on w_or_doc_fo_peso_metalli_rpt.create
this.cbx_vedi_righe=create cbx_vedi_righe
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
this.Control[]={this.cbx_vedi_righe,&
this.sle_pg,&
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

on w_or_doc_fo_peso_metalli_rpt.destroy
destroy(this.cbx_vedi_righe)
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

event open; 
integer li_upbound, i

s_parametri=message.powerobjectparm

is_num_doc=s_parametri.da_categoria
il_num_prog=s_parametri.id_cat_codifica


dw_1.settransobject(sqlca)
 dw_1.retrieve(s_parametri.li_titolo[3], s_parametri.da_data,s_parametri.a_data)
 
 //dw_1.object.filtro.text=s_parametri.filtro


end event

event resize;dw_1.height=newheight - 225
dw_1.width=newwidth - 75
end event

type cbx_vedi_righe from checkbox within w_or_doc_fo_peso_metalli_rpt
boolean visible = false
integer x = 907
integer y = 26
integer width = 322
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean underline = true
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Righe"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height.autosize = yes")
else
	dw_1.modify("datawindow.detail.height.autosize = no")
	dw_1.modify("datawindow.detail.height = 74")
end if
end event

type sle_pg from singlelineedit within w_or_doc_fo_peso_metalli_rpt
integer x = 1536
integer y = 29
integer width = 241
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

type st_1 from statictext within w_or_doc_fo_peso_metalli_rpt
integer x = 1273
integer y = 45
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

type st_2 from statictext within w_or_doc_fo_peso_metalli_rpt
integer x = 1796
integer y = 45
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

type sle_copie from singlelineedit within w_or_doc_fo_peso_metalli_rpt
integer x = 1942
integer y = 29
integer width = 106
integer height = 93
integer taborder = 70
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

type sle_zoom from singlelineedit within w_or_doc_fo_peso_metalli_rpt
integer x = 622
integer y = 29
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

type cb_salva_su_file from commandbutton within w_or_doc_fo_peso_metalli_rpt
integer x = 3006
integer y = 32
integer width = 322
integer height = 93
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

type cb_7 from commandbutton within w_or_doc_fo_peso_metalli_rpt
integer x = 772
integer y = 32
integer width = 110
integer height = 93
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Out"
end type

event clicked;ii_zoom=ii_zoom - 5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_6 from commandbutton within w_or_doc_fo_peso_metalli_rpt
integer x = 516
integer y = 32
integer width = 110
integer height = 93
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "In"
end type

event clicked;ii_zoom=ii_zoom+5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_imp_st from commandbutton within w_or_doc_fo_peso_metalli_rpt
integer x = 2673
integer y = 32
integer width = 296
integer height = 93
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

type cb_stampa from commandbutton within w_or_doc_fo_peso_metalli_rpt
integer x = 3357
integer y = 32
integer width = 260
integer height = 93
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
end type

event clicked;
printsetup()
dw_1.print()
end event

type cb_preview from commandbutton within w_or_doc_fo_peso_metalli_rpt
integer x = 2384
integer y = 32
integer width = 260
integer height = 93
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

type cb_pg_dopo from commandbutton within w_or_doc_fo_peso_metalli_rpt
integer x = 402
integer y = 32
integer width = 91
integer height = 93
integer taborder = 90
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

type cb_pg_prima from commandbutton within w_or_doc_fo_peso_metalli_rpt
integer x = 293
integer y = 32
integer width = 91
integer height = 93
integer taborder = 110
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

type cb_1 from commandbutton within w_or_doc_fo_peso_metalli_rpt
integer x = 37
integer y = 32
integer width = 238
integer height = 93
integer taborder = 120
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

type dw_1 from datawindow within w_or_doc_fo_peso_metalli_rpt
integer y = 128
integer width = 3632
integer height = 1536
integer taborder = 130
string dataobject = "d_or_doc_fo_peso_metalli_rpt"
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

event sqlpreview;string ls_sql, ls_sql1
integer i, li_pos, li_up, li_pos_appoggio

ls_sql=upper(sqlsyntax)

choose case is_solo_preziosi
	case "B", "F", "Y", "Z" , "A"
		li_pos_appoggio=0
		do
			li_pos=li_pos_appoggio
			li_pos_appoggio= pos(ls_sql, "WHERE", li_pos_appoggio+1)
			
		loop while li_pos_appoggio>0
		if li_pos>0 then
			ls_sql1=left(ls_sql, li_pos - 1)
			ls_sql1 += ", der_profilo "
			ls_sql1 +=right(ls_sql, len(ls_sql) - (li_pos - 1))
			ls_sql1 += " and der_profilo.id_prof_documento_padre=documento.id_prof_documento "	
			if is_solo_preziosi="F" or is_solo_preziosi="Z" then
			
				ls_sql1 += " and (qta<=qta_evasa) and (peso_n<=peso_n_evaso) "
			elseif is_solo_preziosi="A" then
				ls_sql1 += " and documento.id_destinazione="+string(il_id_destinazione)
				
				
			end if
			
			
			li_up=upperbound(il_prof_derivato)
			if li_up>0 then
				for i=1 to li_up
					if i=1 then
						ls_sql1 += " and (der_profilo.id_prof_documento_derivato="+string(il_prof_derivato[i])+ " or"
					else
						ls_sql1 += "  der_profilo.id_prof_documento_derivato="+string(il_prof_derivato[i])+ " or"
					end if
				next
				ls_sql1=left(ls_sql1, len(ls_sql1) -3)+ " ) "
			end if
			
		end if
	case "D" 
		ls_sql1 = ls_sql+" and prof_documento.contabilizzabile='S' "
		ls_sql1 += " and documento.contabilizzato<>'S'"
	case "C" 
		ls_sql1 = ls_sql+" and documento.contabilizzato='S'"
	case "O" 
		
		ls_sql1 = ls_sql+" and documento.data_prev_consegna<= date('"+string(idt_a_scadenza, "yyyy/mm/dd")+"') "&
					+ "and documento.data_prev_consegna>= date('"+string(idt_da_scadenza, "yyyy/mm/dd")+"') "
	
end choose


//if is_solo_preziosi<>'T' then	
if il_num_prog>0 then
if ls_sql1> " " then 
		ls_sql1 = ls_sql1+" and documento.num_progressivo >=" +string(il_num_prog)
	else
		ls_sql1 = ls_sql+" and documento.num_progressivo >=" +string(il_num_prog)
	end if
end if
	
	
	
	if is_num_doc> " " then
		if ls_sql1> " " then 
			ls_sql1 = ls_sql1+" and documento.num_documento like '%"+is_num_doc+"%' "
		else
			ls_sql1 = ls_sql+" and documento.num_documento like '%"+is_num_doc+"%' "
		end if
	end if
	if ls_sql1> " " then  setsqlpreview(ls_sql1)
	
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

