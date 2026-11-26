forward
global type w_segui_produzione_rpt from window
end type
type cbx_solo_venduto from checkbox within w_segui_produzione_rpt
end type
type cbx_solo_aperti from checkbox within w_segui_produzione_rpt
end type
type cbx_vedi_doc from checkbox within w_segui_produzione_rpt
end type
type cbx_vedi_totali from checkbox within w_segui_produzione_rpt
end type
type cbx_vedi_righe from checkbox within w_segui_produzione_rpt
end type
type sle_pg from singlelineedit within w_segui_produzione_rpt
end type
type st_1 from statictext within w_segui_produzione_rpt
end type
type st_2 from statictext within w_segui_produzione_rpt
end type
type sle_copie from singlelineedit within w_segui_produzione_rpt
end type
type sle_zoom from singlelineedit within w_segui_produzione_rpt
end type
type cb_salva_su_file from commandbutton within w_segui_produzione_rpt
end type
type cb_7 from commandbutton within w_segui_produzione_rpt
end type
type cb_6 from commandbutton within w_segui_produzione_rpt
end type
type cb_imp_st from commandbutton within w_segui_produzione_rpt
end type
type cb_stampa from commandbutton within w_segui_produzione_rpt
end type
type cb_pg_dopo from commandbutton within w_segui_produzione_rpt
end type
type cb_pg_prima from commandbutton within w_segui_produzione_rpt
end type
type cb_1 from commandbutton within w_segui_produzione_rpt
end type
type dw_1 from datawindow within w_segui_produzione_rpt
end type
type cb_preview from commandbutton within w_segui_produzione_rpt
end type
end forward

global type w_segui_produzione_rpt from window
integer x = 22
integer y = 13
integer width = 4220
integer height = 1834
boolean titlebar = true
string title = "Step Produzione"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_post_open ( )
cbx_solo_venduto cbx_solo_venduto
cbx_solo_aperti cbx_solo_aperti
cbx_vedi_doc cbx_vedi_doc
cbx_vedi_totali cbx_vedi_totali
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
cb_pg_dopo cb_pg_dopo
cb_pg_prima cb_pg_prima
cb_1 cb_1
dw_1 dw_1
cb_preview cb_preview
end type
global w_segui_produzione_rpt w_segui_produzione_rpt

type variables

integer ii_zoom=100
string is_da_art, is_ad_art, is_num_ordine, is_cod_cliente
long il_id_cat_codifica, il_id_ordine[]

end variables

on w_segui_produzione_rpt.create
this.cbx_solo_venduto=create cbx_solo_venduto
this.cbx_solo_aperti=create cbx_solo_aperti
this.cbx_vedi_doc=create cbx_vedi_doc
this.cbx_vedi_totali=create cbx_vedi_totali
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
this.cb_pg_dopo=create cb_pg_dopo
this.cb_pg_prima=create cb_pg_prima
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_preview=create cb_preview
this.Control[]={this.cbx_solo_venduto,&
this.cbx_solo_aperti,&
this.cbx_vedi_doc,&
this.cbx_vedi_totali,&
this.cbx_vedi_righe,&
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
this.cb_pg_dopo,&
this.cb_pg_prima,&
this.cb_1,&
this.dw_1,&
this.cb_preview}
end on

on w_segui_produzione_rpt.destroy
destroy(this.cbx_solo_venduto)
destroy(this.cbx_solo_aperti)
destroy(this.cbx_vedi_doc)
destroy(this.cbx_vedi_totali)
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
destroy(this.cb_pg_dopo)
destroy(this.cb_pg_prima)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_preview)
end on

event open;string ls_test, ls_tikal, ls_tipo_arr
integer li_num_dec
s_param_articoli s_parametri   // dichiaro la struttura per ricevere i dati

s_parametri=message.powerobjectparm
is_da_art=s_parametri.da_cod_art
is_ad_art=s_parametri.a_cod_art
il_id_cat_codifica=s_parametri.ll_magazzino
il_id_ordine=s_parametri.li_titolo
is_cod_cliente=s_parametri.da_sog_comm

dw_1.dataobject=s_parametri.tipo_stampa
dw_1.settransobject(sqlca)
dw_1.retrieve(s_parametri.da_data,s_parametri.a_data)

if s_parametri.tipo_stampa="d_prod_2011_tb" then  //per retrocompatibilità magari è anche inutile più in là si toglie
	cbx_solo_aperti.enabled=true
	cbx_vedi_doc.enabled=true
elseif s_parametri.tipo_stampa="d_sem_prod_2012_tb" OR s_parametri.tipo_stampa="d_sem_prod_2012E_tb" then
	cbx_vedi_totali.visible=false
	cbx_vedi_righe.visible=false
else
	cbx_vedi_totali.checked=true
	cbx_vedi_righe.checked=true
end if
	
	
	
end event

event resize;dw_1.height=newheight - 225
dw_1.width=newwidth - 75
end event

type cbx_solo_venduto from checkbox within w_segui_produzione_rpt
integer x = 2809
integer y = 77
integer width = 464
integer height = 74
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo venduto<=0"
end type

event clicked;if checked then
	cbx_solo_aperti.checked=false
	dw_1.setfilter("c_tot_ven_qta <= 0")
	dw_1.filter()
	dw_1.groupcalc()
else
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.groupcalc()
end if
end event

type cbx_solo_aperti from checkbox within w_segui_produzione_rpt
integer x = 2205
integer y = 77
integer width = 611
integer height = 74
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo aperti (diff <= 10%)"
end type

event clicked;if checked then
	cbx_solo_venduto.checked=false
	dw_1.setfilter("c_solo_aperti > 0")
	dw_1.filter()
	dw_1.groupcalc()
else
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.groupcalc()
end if
end event

type cbx_vedi_doc from checkbox within w_segui_produzione_rpt
integer x = 2216
integer y = 13
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
boolean enabled = false
string text = "Vedi Doc."
end type

event clicked;if checked then
	dw_1.modify("datawindow.trailer.2.height = 80")
else
	dw_1.modify("datawindow.trailer.2.height = 0")
end if
end event

type cbx_vedi_totali from checkbox within w_segui_produzione_rpt
integer x = 1880
integer y = 77
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
string text = "Vedi Totali"
end type

event clicked;if checked then
	if dw_1.dataobject="d_prod_2011_tb" then
		dw_1.modify("datawindow.summary.height = 76")
	else
		dw_1.modify("datawindow.trailer.2.height = 248")
	end if
else
	if dw_1.dataobject="d_prod_2011_tb" then
		dw_1.modify("datawindow.summary.height = 148")
	else
		dw_1.modify("datawindow.trailer.2.height = 0")
	end if
end if
end event

type cbx_vedi_righe from checkbox within w_segui_produzione_rpt
integer x = 1880
integer y = 10
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
string text = "Vedi Righe"
end type

event clicked;if checked then
	if dw_1.dataobject="d_prod_2011_tb" then
		dw_1.modify("datawindow.detail.height = 76")
		dw_1.modify("data_documento_t.visible=1")
		dw_1.modify("num_documento_t.visible=1")
		dw_1.modify("causale_t.visible=1")
	else
		dw_1.modify("datawindow.detail.height.Autosize = Yes")
		dw_1.modify("datawindow.header.2.height = 172")
	end if		
else
	if dw_1.dataobject="d_prod_2011_tb" then
		dw_1.modify("datawindow.detail.height = 0")
		dw_1.modify("data_documento_t.visible=0")
		dw_1.modify("causale_t.visible=0")
	else
		dw_1.modify("datawindow.detail.height.autosize = No")
		dw_1.modify("datawindow.header.2.height = 92")
	end if
	
end if
end event

type sle_pg from singlelineedit within w_segui_produzione_rpt
integer x = 1207
integer y = 32
integer width = 380
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

type st_1 from statictext within w_segui_produzione_rpt
integer x = 936
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

type st_2 from statictext within w_segui_produzione_rpt
integer x = 1591
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

type sle_copie from singlelineedit within w_segui_produzione_rpt
integer x = 1737
integer y = 32
integer width = 132
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

type sle_zoom from singlelineedit within w_segui_produzione_rpt
integer x = 662
integer y = 32
integer width = 132
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

type cb_salva_su_file from commandbutton within w_segui_produzione_rpt
boolean visible = false
integer x = 3632
integer y = 1587
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

type cb_7 from commandbutton within w_segui_produzione_rpt
integer x = 805
integer y = 35
integer width = 124
integer height = 90
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OUT"
end type

event clicked;ii_zoom=ii_zoom - 5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_6 from commandbutton within w_segui_produzione_rpt
integer x = 563
integer y = 35
integer width = 110
integer height = 90
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "IN"
end type

event clicked;ii_zoom=ii_zoom+5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_imp_st from commandbutton within w_segui_produzione_rpt
integer x = 3544
integer y = 42
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

type cb_stampa from commandbutton within w_segui_produzione_rpt
integer x = 3862
integer y = 42
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

type cb_pg_dopo from commandbutton within w_segui_produzione_rpt
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

type cb_pg_prima from commandbutton within w_segui_produzione_rpt
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

type cb_1 from commandbutton within w_segui_produzione_rpt
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

type dw_1 from datawindow within w_segui_produzione_rpt
integer x = 26
integer y = 154
integer width = 4092
integer height = 1530
integer taborder = 120
string dataobject = "d_segui_produzione_rpt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event printpage;//integer li_copie, li_ap, i , li_pos=0, li_inizio, li_fine
//string ls_nr_pg
//boolean lb_stampa=false
//
//
//
//ls_nr_pg=sle_pg.text
//if isnull(ls_nr_pg) then ls_nr_pg='T'
//
//choose case ls_nr_pg
//	case 'T'
//		
//	case 'P'
//		if mod(pagenumber, 2)<>0 then
//			return 1
//		end if
//	case 'D'
//		if mod(pagenumber, 2)=0 then
//			return 1
//		end if	
//	case else
//		li_copie=len(ls_nr_pg)
//      li_pos=pos(ls_nr_pg, "-", li_pos+1)
//		if li_pos>0 then	
//			li_inizio=integer(left(ls_nr_pg, li_pos - 1))
//			li_fine=integer(right(ls_nr_pg, li_copie - li_pos))
//			if li_fine=0 or isnull(li_fine) then li_fine=pagenumber
//			if li_inizio=0 or li_fine=0 or isnull(li_inizio) then
//				messagebox("Attenzione!", "Pagine da stampare non impostate correttamente")
//			end if
//			if pagenumber>=li_inizio and pagenumber<=li_fine then lb_stampa=true
//		else	
//			for i = 1 to li_copie
//				if li_pos>=i then continue
//				//if li_pos>=li_copie then exit
//				li_pos=pos(ls_nr_pg, ",", li_pos+1)
//				if li_pos=0 then li_pos=li_copie + 1
//				li_ap=integer(mid(ls_nr_pg, i, li_pos - 1))
//				if li_ap=0 or isnull(li_ap) then
//					messagebox("Attenzione!", "Pagine da stampare non impostate correttamente")
//				else
//					if li_ap=pagenumber then 
//						lb_stampa=true
//						exit
//					end if
//				end if
//			next
//		end if
//		if lb_stampa=false then return 1
//end choose
//
//
////messagebox("pagina", pagenumber)
//
////messagebox("copie", copy)
end event

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event sqlpreview;string ls_sql, ls_ordine, ls_sql_temp
long ll_id_ordine[]

integer i, li_pos
ls_sql=sqlsyntax
	
if dw_1.dataobject="d_segui_produzione_rpt" then
	ls_sql=sqlsyntax
	if is_da_art>"" then
		ls_sql=ls_sql + " and (articolo.codice >= '"+is_da_art+"') " 
//		//messagebox("W", right(sqlsyntax, 400))
//		
	end if
	if is_ad_art>"" then
		ls_sql=ls_sql + " and (articolo.codice <= '"+is_ad_art+"') " 
//		//messagebox("W", right(sqlsyntax, 400))
//		
	end if
	
	if upperbound(il_id_ordine)> 0 then
		if dw_1.dataobject="d_segui_produzione_rpt" then
			for i= 1 to upperbound(il_id_ordine)
				if i=1 then
					ls_sql=ls_sql + " and ((riga_documento.id_riga_sorgente = "+string(il_id_ordine[i])+") " 
				elseif i=upperbound(il_id_ordine) then
					ls_sql=ls_sql + " or (riga_documento.id_riga_sorgente = "+string(il_id_ordine[i])+")) " 
				else
					ls_sql=ls_sql + " or (riga_documento.id_riga_sorgente = "+string(il_id_ordine[i])+") " 
				end if
				//messagebox("W", right(sqlsyntax, 400))
			next	
			if upperbound(il_id_ordine)=1 then
				ls_sql=ls_sql + ")"
			end if
		else	
		for i= 1 to upperbound(il_id_ordine)
			if i=1 then
				ls_sql=ls_sql + " and ((produzione_2011.id_bollettina = "+string(il_id_ordine[i])+") " 
			elseif i=upperbound(il_id_ordine) then
				ls_sql=ls_sql + " or (produzione_2011.id_bollettina = "+string(il_id_ordine[i])+")) " 
			else
				ls_sql=ls_sql + " or (produzione_2011.id_bollettina = "+string(il_id_ordine[i])+") " 
				end if
				//messagebox("W", right(sqlsyntax, 400))
		next	
		if upperbound(il_id_ordine)=1 then
			ls_sql=ls_sql + ")"
		end if
	end if
end if	
	
	if il_id_cat_codifica>0 then
		ls_sql=ls_sql + " and (articolo.id_cat_codifica = "+string(il_id_cat_codifica)+") "
	end if
	
	setsqlpreview(ls_sql)
else
	li_pos=pos(ls_sql, "ORDER")
	
	if il_id_cat_codifica>0 then
		ls_sql=left(ls_sql, li_pos -1) &
		+ " and (articolo_b.id_cat_codifica = "+string(il_id_cat_codifica)+") "+&
		right(ls_sql, len(ls_sql) - li_pos + 1)
	end if
	
	if is_da_art>"" then
		ls_sql=left(ls_sql, li_pos -1) &
		+ " and (articolo_b.codice >= '"+is_da_art+"') " +&
		right(ls_sql, len(ls_sql) - li_pos + 1)
//		//messagebox("W", right(sqlsyntax, 400))
//		
	end if
	if is_ad_art>"" then
		ls_sql=left(ls_sql, li_pos -1) &
		+ " and (articolo_b.codice <= '"+is_ad_art+"') " +&
		right(ls_sql, len(ls_sql) - li_pos + 1)
		
		//messagebox("W", right(sqlsyntax, 400))
//		
	end if
	
	if is_cod_cliente>" " then
		if left(is_cod_cliente, 2)='CL' then
			if dw_1.dataobject="d_sem_prod_2012_tb" or upper(dw_1.dataobject)="D_SEM_PROD_2012E_TB" then
					ls_sql=left(ls_sql, li_pos -1) &
			+ " and (sog_commerciale.codice = '"+is_cod_cliente+"') "+&
			right(ls_sql, len(ls_sql) - li_pos + 1)
			else
					ls_sql=left(ls_sql, li_pos -1) &
			+ " and (sog_commerciale_gen_a.codice = '"+is_cod_cliente+"') "+&
			right(ls_sql, len(ls_sql) - li_pos + 1)
			end if
		else
			if dw_1.dataobject="d_sem_prod_2012_tb" or upper(dw_1.dataobject)="D_SEM_PROD_2012E_TB" then
					ls_sql=left(ls_sql, li_pos -1) &
			+ " and (sog_commerciale.codice = '"+is_cod_cliente+"') "+&
			right(ls_sql, len(ls_sql) - li_pos + 1)
			else
					ls_sql=left(ls_sql, li_pos -1) &
			+ " and (sog_commerciale_gen_c.codice = '"+is_cod_cliente+"') "+&
			right(ls_sql, len(ls_sql) - li_pos + 1)
			end if
		end if
	
	end if
	for i= 1 to upperbound(il_id_ordine)
			if i=1 and upperbound(il_id_ordine)=1 then
				ls_sql_temp=" and (produzione_2011.id_bollettina = "+string(il_id_ordine[i])+") " 
			elseif i=1 and upperbound(il_id_ordine)>1 then
				ls_sql_temp= " and ((produzione_2011.id_bollettina = "+string(il_id_ordine[i])+") " 
			elseif i=upperbound(il_id_ordine) then
				ls_sql_temp=ls_sql_temp+ " or (produzione_2011.id_bollettina = "+string(il_id_ordine[i])+"))"
			else
				ls_sql_temp=ls_sql_temp+ " or (produzione_2011.id_bollettina = "+string(il_id_ordine[i])+")"
			end if
				//messagebox("W", right(sqlsyntax, 400))
		next	
		ls_sql=left(ls_sql, li_pos -1) & 
		+ls_sql_temp +&
		right(ls_sql, len(ls_sql) - li_pos + 1)
	
	
	if setsqlpreview(ls_sql)<>1 then
		messagebox("2", ls_sql)
	end if
end if


end event

event doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
if dw_1.dataobject="d_segui_produzione_rpt" then
	ll_id_doc=getitemnumber(row, "id_documento")
else
	ll_id_doc=getitemnumber(row, "documento_id_documento")
end if
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type cb_preview from commandbutton within w_segui_produzione_rpt
integer x = 3259
integer y = 42
integer width = 260
integer height = 90
integer taborder = 70
boolean bringtotop = true
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
	dw_1.object.datawindow.print.preview='No'
	dw_1.object.datawindow.print.preview.rulers='no'
end if
end event

