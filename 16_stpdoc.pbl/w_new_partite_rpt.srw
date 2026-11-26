forward
global type w_new_partite_rpt from w_stampa
end type
type pb_salva_dw from picturebutton within w_new_partite_rpt
end type
type cbx_vedi_righe from checkbox within w_new_partite_rpt
end type
type cbx_doc from checkbox within w_new_partite_rpt
end type
type cbx_1 from checkbox within w_new_partite_rpt
end type
type cbx_con_calo from checkbox within w_new_partite_rpt
end type
type cbx_fino_calo_invisibili from checkbox within w_new_partite_rpt
end type
type cbx_summary_invisibile from checkbox within w_new_partite_rpt
end type
type ddlb_1 from dropdownlistbox within w_new_partite_rpt
end type
type cbx_2 from checkbox within w_new_partite_rpt
end type
type cbx_3 from checkbox within w_new_partite_rpt
end type
end forward

global type w_new_partite_rpt from w_stampa
integer width = 5065
integer height = 1944
pb_salva_dw pb_salva_dw
cbx_vedi_righe cbx_vedi_righe
cbx_doc cbx_doc
cbx_1 cbx_1
cbx_con_calo cbx_con_calo
cbx_fino_calo_invisibili cbx_fino_calo_invisibili
cbx_summary_invisibile cbx_summary_invisibile
ddlb_1 ddlb_1
cbx_2 cbx_2
cbx_3 cbx_3
end type
global w_new_partite_rpt w_new_partite_rpt

type variables
s_new_scheda_mag s_new_mag
string ls_sql_1="", ls_sql_tipo=""
s_param_articoli str_param
decimal ldc_saldo_peso_precedente,ldc_saldo_fc_precedente
end variables

forward prototypes
public function decimal wf_correzioni_doc ()
end prototypes

public function decimal wf_correzioni_doc ();//

return 1
end function

on w_new_partite_rpt.create
int iCurrent
call super::create
this.pb_salva_dw=create pb_salva_dw
this.cbx_vedi_righe=create cbx_vedi_righe
this.cbx_doc=create cbx_doc
this.cbx_1=create cbx_1
this.cbx_con_calo=create cbx_con_calo
this.cbx_fino_calo_invisibili=create cbx_fino_calo_invisibili
this.cbx_summary_invisibile=create cbx_summary_invisibile
this.ddlb_1=create ddlb_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_salva_dw
this.Control[iCurrent+2]=this.cbx_vedi_righe
this.Control[iCurrent+3]=this.cbx_doc
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.cbx_con_calo
this.Control[iCurrent+6]=this.cbx_fino_calo_invisibili
this.Control[iCurrent+7]=this.cbx_summary_invisibile
this.Control[iCurrent+8]=this.ddlb_1
this.Control[iCurrent+9]=this.cbx_2
this.Control[iCurrent+10]=this.cbx_3
end on

on w_new_partite_rpt.destroy
call super::destroy
destroy(this.pb_salva_dw)
destroy(this.cbx_vedi_righe)
destroy(this.cbx_doc)
destroy(this.cbx_1)
destroy(this.cbx_con_calo)
destroy(this.cbx_fino_calo_invisibili)
destroy(this.cbx_summary_invisibile)
destroy(this.ddlb_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
end on

event open;call super::open;date ldt_data
decimal ldc_correzioni_silver, ldc_correzione_k
integer i, li_pos
string ls_sql_ok
long ll_id_titolo

s_new_mag=message.powerobjectparm
if isnull(s_new_mag.tipo_stampa) or s_new_mag.tipo_stampa<=" " then s_new_mag.tipo_stampa="d_new_partite"
dw_1.dataobject=s_new_mag.tipo_stampa
dw_1.settransobject(sqlca)

if s_new_mag.metallo> "" then
	ls_sql_1+=" and (orafo_metallo.codice= '"+string(s_new_mag.metallo)+"') "
end if
if s_new_mag.id_sog_commerciale> 0 then //lo faccio solo se è saldo di un singolo CL/FO
	ls_sql_1+=" and (documento.id_sog_commerciale= "+string( s_new_mag.id_sog_commerciale)+") "
end if

dw_1.retrieve(s_new_mag.da_data, s_new_mag.a_data)
//if s_new_mag.sel_causali='S' then  
//	open(w_sel_causali_st)
//	str_param=message.powerobjectparm
//	s_new_mag.id_caus_magazzino=str_param.li_titolo
//	for i=1 to upperbound(s_new_mag.id_caus_magazzino)
//		if i=1 then
//			ls_sql_1+=" and (caus_magazzino.id_caus_magazzino= "+string(s_new_mag.id_caus_magazzino[i])
//		else
//			ls_sql_1+=" or caus_magazzino.id_caus_magazzino= "+string(s_new_mag.id_caus_magazzino[i])
//		end if
//	next
//	ls_sql_1+=" ) "
//end if
//
//select data_inizio
//into :ldt_data
//from esercizio 
//where data_inizio<=:s_new_mag.da_data
//and data_fine>=:s_new_mag.da_data
//;
//if sqlca.sqlcode=0 then
//	if ldt_data=s_new_mag.da_data then
//		ldc_saldo_fc_precedente=0
//		ldc_saldo_peso_precedente=0		
//	else	
//		if s_new_mag.id_sog_commerciale> 0 then //lo faccio solo se è saldo di un singolo CL/FO
//			
//			if s_new_mag.tipo_stampa="d_new_scheda_magazzino" or isnull(s_new_mag.tipo_stampa) or s_new_mag.tipo_stampa<=" " then
//		//		//"sum( (select ( case caus_magazzino.segno  when 'C' then riga_documento.fino + riga_documento.calo  "+&
//		//        //               " when 'S' then (riga_documento.fino + riga_documento.calo ) * -1 end )))  as c_somma_finocalo		"+&
//				  
//				ls_sql_ok= "SELECT  sum( (select ( case caus_magazzino.segno  when 'C' then riga_documento.peso_netto  "+&
//									  " when 'S' then riga_documento.peso_netto * -1 end )))  as c_somma_peso, "+&
//				  	"sum( (select ( case caus_magazzino.segno  when 'C' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000, 2)  "+&
//									  " when 'S' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000 , 2 ) * -1 end )))  as c_somma_finocalo "+&
//				 	" FROM riga_documento, documento, articolo, orafo_metallo, orafo_titolo , caus_magazzino "+& 
//					" WHERE ( caus_magazzino.id_caus_magazzino = riga_documento.id_caus_magazzino ) and  "+&
//						" ( documento.id_documento = riga_documento.id_documento ) and   "+&
//						" ( articolo.id_articolo = riga_documento.id_articolo ) and   "+&
//						" ( orafo_titolo.id_metallo = orafo_metallo.id_metallo ) and   "+&
//						" ( orafo_titolo.id_titolo = articolo.id_titolo ) and   "+&
//					"	 ( caus_magazzino.segno is not null ) AND   "+&
//						" (documento.data_documento >= '"+string(ldt_data, "yyyy/mm/dd")+"' AND   "+&
//						" documento.data_documento <  '"+string(s_new_mag.da_data, "yyyy/mm/dd")+"' )    " +ls_sql_1 //il filtro per metallo è qui: 1 metallo solo per stampa
//			else
//				ls_sql_ok= "SELECT  sum( (select ( case caus_magazzino.saldi_cl_fino  when '+' then riga_documento.peso_netto  "+&
//									  " when '-' then riga_documento.peso_netto * -1 end )))  as c_somma_peso, "+&
//					"sum( (select ( case caus_magazzino.saldi_cl_fino  when '+' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000, 2)  "+&
//									  " when '-' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000 , 2 ) * -1 end )))  as c_somma_finocalo "+&
//					" FROM riga_documento, documento, articolo, orafo_metallo, orafo_titolo , caus_magazzino "+& 
//						" WHERE ( caus_magazzino.id_caus_magazzino = riga_documento.id_caus_magazzino ) and  "+&
//					" ( documento.id_documento = riga_documento.id_documento ) and   "+&
//					" ( articolo.id_articolo = riga_documento.id_articolo ) and   "+&
//					" ( orafo_titolo.id_metallo = orafo_metallo.id_metallo ) and   "+&
//					" ( orafo_titolo.id_titolo = articolo.id_titolo ) and   "+&
//					"	 ( caus_magazzino.segno is not null ) AND   "+&
//					" (documento.data_documento >= '"+string(ldt_data, "yyyy/mm/dd")+"' AND   "+&
//					" documento.data_documento <  '"+string(s_new_mag.da_data, "yyyy/mm/dd")+"' )    " +ls_sql_1 //il filtro per metallo è qui: 1 metallo solo per stampa
//			end if
//			PREPARE SQLSA FROM :ls_sql_ok using sqlca ;
//			DECLARE my_cursor DYNAMIC CURSOR FOR SQLSA ;
//			OPEN DYNAMIC my_cursor ;
//			FETCH my_cursor INTO :ldc_saldo_peso_precedente, :ldc_saldo_fc_precedente ;
//			CLOSE my_cursor ;
//			
//			if s_new_mag.metallo='AG' then
//				ll_id_titolo=4
//			else
//				select max(id_titolo)
//				into :ll_id_titolo
//				from orafo_titolo, orafo_metallo
//				where orafo_metallo.codice=:s_new_mag.metallo
//				and orafo_titolo.id_metallo=orafo_metallo.id_metallo
//				;
//				if ll_id_titolo<=0 or isnull(ll_id_titolo) then
//					messagebox("Attenzione!", "Titolo non trovato!")
//					return
//				end if
//			end if
//			if s_new_mag.id_sog_commerciale=43  then
//				SELECT sum((select sum((case when provv_imp_carea_2>0 then provv_imp_carea_2 * (select fn_rec_prezzo_filo_rame('L', documento.data_documento)) else 0 end) + (case when provv_imp_agente_2>0 
//				then provv_imp_agente_2 * (select fn_rec_prezzo_filo_rame('F', documento.data_documento)) else 0 end )+ (case when peso_lordo>0 then peso_lordo else 0 end)) from riga_documento 
//				where id_documento=documento.id_documento and id_articolo in (select articolo.id_articolo from articolo where id_titolo=:ll_id_titolo) and (select count(*) from riga_documento  , articolo
//				where articolo.id_articolo=riga_documento.id_articolo and articolo.id_titolo=:ll_id_titolo and id_documento=documento.id_documento and peso_netto> 1 ) >10
//				  )) // , (select sum(correzione) from correzioni_k where id_riga_documento in (select id_riga_documento from riga_documento where id_documento=documento.id_documento) )
//				  into :ldc_correzioni_silver //, :ldc_correzione_k
//				FROM dba.documento
//				where data_documento>=:ldt_data and data_documento< :s_new_mag.da_data 
//				and ( documento.id_prof_documento =114 or documento.id_prof_documento =150 or documento.id_prof_documento =66 )
//				and id_sog_commerciale=43;
//				//da togliere
//				dw_1.object.t_2.text=string(ldc_correzioni_silver, "#,0.00")
//				if ldc_correzioni_silver>0 then 
//					ldc_saldo_peso_precedente=ldc_saldo_peso_precedente - ldc_correzioni_silver
//					ldc_saldo_fc_precedente=ldc_saldo_fc_precedente - ldc_correzioni_silver
//				end if
//				//aggiungo correzioni rigo rigo
//				select sum(correzione) 
//				into :ldc_correzione_k
//				from correzioni_k , documento
//				where id_riga_documento in (select id_riga_documento from riga_documento, articolo, orafo_titolo, orafo_metallo
//				where id_documento=documento.id_documento and  data_documento>=:ldt_data 
//				and data_documento< :s_new_mag.da_data and 
//				orafo_metallo.id_metallo=orafo_titolo.id_metallo and orafo_metallo.codice=:s_new_mag.metallo
//				and orafo_titolo.id_titolo=articolo.id_titolo and articolo.id_articolo=riga_documento.id_articolo) ;
//				//da togliere
//				dw_1.object.t_3.text=string(ldc_correzione_k, "#,0.00")
//				if ldc_correzione_k<>0 then// ldc_correzioni_silver+=ldc_correzione_k
//				//if ldc_correzioni_silver>0 then 
//					ldc_saldo_peso_precedente -= ldc_correzione_k //IL SEGNO - è PERCHé SONO MOVIMENTI DI SCARICO QUINDI NEGATIVI!!!! 20200715
//					ldc_saldo_fc_precedente -= ldc_correzione_k
//				//end if
//				end if
//			end if
//		else //è una stampa per tutti i soggetti commerciali
//			
//		end if
//	end if
//end if
//if isnull(ldc_saldo_peso_precedente) then ldc_saldo_peso_precedente=0
//if isnull(ldc_saldo_fc_precedente) then ldc_saldo_fc_precedente=0
//
//dw_1.retrieve(s_new_mag.da_data, s_new_mag.a_data)
//if s_new_mag.tipo_stampa="d_new_scheda_clfo" or   s_new_mag.tipo_stampa="d_new_scheda_clfo_cl" then
//	if isnull(s_new_mag.id_sog_commerciale) or s_new_mag.id_sog_commerciale<=0 then
//		dw_1.MODIFY("c_saldo_prec_fc.visible=0")
//		dw_1.MODIFY("c_saldo_prec_peso.visible=0")
//		dw_1.MODIFY("compute_4.visible=0")	
//		dw_1.MODIFY("c_finocalo_1.visible=0")
//		dw_1.MODIFY("c_calo_1.visible=0")
//		dw_1.MODIFY("c_fino_1.visible=0")
//		dw_1.MODIFY("c_qta_1.visible=0")
//		dw_1.MODIFY("c_legato_1.visible=0")
//		for i= 5 to 17
//			dw_1.MODIFY("t_"+string(i)+".visible=0")
//		next
//	end if
//	dw_1.MODIFY("c_finocalo_1.format='#,0.00'")
//	dw_1.MODIFY("compute_13.format='#,0.00'")
//	dw_1.MODIFY("c_prog_legato.format='#,0.00'")
//end if
//
end event

type pb_1 from w_stampa`pb_1 within w_new_partite_rpt
integer x = 4261
integer y = 16
string text = ""
end type

type cb_preview from w_stampa`cb_preview within w_new_partite_rpt
integer x = 3657
integer y = 16
end type

type dw_1 from w_stampa`dw_1 within w_new_partite_rpt
integer y = 280
integer width = 4910
string dataobject = "d_new_partite"
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql, ls_sql_2, ls_sql_unione
integer i, li_pos


if sqltype<>PreviewUpdate!	then
	ls_sql=sqlsyntax
	
	ls_sql_unione=ls_sql+ls_sql_1

	i=SetSQLPreview(ls_sql_unione)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
	
end if

end event

event dw_1::itemchanged;call super::itemchanged;decimal ldc_titolo, ldc_peso_netto, ldc_calo, ldc_coef_calo, ldc_fino

IF DWO.NAME="coef_calo" then
	ldc_peso_netto=getitemdecimal(row, "peso_netto")
	ldc_fino=getitemdecimal(row, "fino")
	ldc_titolo=getitemdecimal(row, "orafo_titolo_titolo")
	ldc_coef_calo=dec(data)
	if ldc_coef_calo=0 then ldc_coef_calo=ldc_titolo
	ldc_calo=ldc_peso_netto*ldc_coef_calo/1000 - ldc_fino
	post setitem(row, "calo", ldc_calo)
	
	
end if
	
end event

event dw_1::doubleclicked;//


//messagebox("N", "DC")
long ll_id_doc, ll_row
integer li_pos
string band
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

ll_row=row
if ll_row<=0  then
	band = GetBandAtPointer()
	li_pos=pos(band, char(9))
	if li_pos>0 then
		band=right(band, len(band) - li_pos)
		ll_row=long(band)
		if ll_row<=0 then return
	else
		return
	end if
end if
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(ll_row, "riga_documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_new_partite_rpt
integer x = 4064
integer y = 16
end type

type pb_stampa from w_stampa`pb_stampa within w_new_partite_rpt
integer x = 3854
integer y = 16
end type

type sle_pg from w_stampa`sle_pg within w_new_partite_rpt
integer x = 1678
integer y = 24
integer width = 265
integer height = 68
end type

type st_1 from w_stampa`st_1 within w_new_partite_rpt
integer x = 1399
integer y = 28
integer height = 68
end type

type st_2 from w_stampa`st_2 within w_new_partite_rpt
boolean visible = true
integer y = 24
integer height = 64
end type

type sle_copie from w_stampa`sle_copie within w_new_partite_rpt
boolean visible = true
integer y = 24
integer width = 155
integer height = 68
integer textsize = -7
end type

type sle_zoom from w_stampa`sle_zoom within w_new_partite_rpt
integer y = 20
integer height = 76
end type

type cb_7 from w_stampa`cb_7 within w_new_partite_rpt
integer y = 20
integer height = 76
end type

type cb_6 from w_stampa`cb_6 within w_new_partite_rpt
integer y = 20
integer height = 76
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_new_partite_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_new_partite_rpt
end type

type cb_esci from w_stampa`cb_esci within w_new_partite_rpt
integer x = 4663
integer y = 36
end type

type pb_salva_dw from picturebutton within w_new_partite_rpt
integer x = 4471
integer y = 16
integer width = 169
integer height = 124
integer taborder = 18
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\Salva.png"
alignment htextalign = left!
end type

event clicked;integer li_ret

li_ret=dw_1.update()
if li_ret=1 then
	commit;
else
	rollback;
 	messagebox("Attenzione!", "Salvataggio NON riuscito!")
end if
end event

type cbx_vedi_righe from checkbox within w_new_partite_rpt
integer x = 1033
integer y = 20
integer width = 343
integer height = 72
boolean bringtotop = true
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
	dw_1.modify("datawindow.detail.height = 88")
else
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

type cbx_doc from checkbox within w_new_partite_rpt
integer x = 1033
integer y = 96
integer width = 485
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nascondi Tot. Doc."
end type

event clicked;if checked then
	dw_1.modify("datawindow.trailer.2.height = 0")
else
	dw_1.modify("datawindow.trailer.2.height = 90")
end if
end event

type cbx_1 from checkbox within w_new_partite_rpt
integer x = 265
integer y = 96
integer width = 626
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Controllo Fino calo errati"
boolean righttoleft = true
end type

event clicked;string ls_filter

if checked then 
	ls_filter="c_controllo_fino_calo>0"
else
	ls_filter=""
end if

dw_1.setfilter(ls_filter)
dw_1.filter()
end event

type cbx_con_calo from checkbox within w_new_partite_rpt
integer x = 1554
integer y = 96
integer width = 407
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo calo > 0"
end type

event clicked;string ls_filter

if checked then 
	ls_filter="calo>0"
else
	ls_filter=""
end if

dw_1.setfilter(ls_filter)
dw_1.filter()
end event

type cbx_fino_calo_invisibili from checkbox within w_new_partite_rpt
integer x = 265
integer y = 176
integer width = 471
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fino Calo Invisibili"
boolean righttoleft = true
end type

event clicked;string ls_filter, ls_h
integer li_h

if checked then 
	dw_1.modify("fino.visible=0")
	dw_1.modify("calo.visible=0")
	dw_1.modify("c_calo_doc.visible=0")
	dw_1.modify("c_fino_doc.visible=0")
	dw_1.modify("riga_documento_calo_t.visible=0")
	dw_1.modify("riga_documento_fino_t.visible=0")
	
	ls_h=dw_1.describe("c_etichetta_saldo_prec.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_etichetta_saldo_prec.x="+ls_h)
	
	ls_h=dw_1.describe("c_saldo_prec_peso.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_saldo_prec_peso.x="+ls_h)
	
	ls_h=dw_1.describe("c_saldo_prec_fc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_saldo_prec_fc.x="+ls_h)
	
	ls_h=dw_1.describe("t_prog_legato.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("t_prog_legato.x="+ls_h)
	
	ls_h=dw_1.describe("t_prog_fc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("t_prog_fc.x="+ls_h)
	
	ls_h=dw_1.describe("t_fc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("t_fc.x="+ls_h)
	
	ls_h=dw_1.describe("c_finocalo.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_finocalo.x="+ls_h)
	
	ls_h=dw_1.describe("c_prog_finocalo_doc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_finocalo_doc.x="+ls_h)
	
	ls_h=dw_1.describe("c_finocalo_doc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_finocalo_doc.x="+ls_h)
		
	ls_h=dw_1.describe("c_prog_legato_doc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_legato_doc.x="+ls_h)
	
	ls_h=dw_1.describe("c_prog_finocalo.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_finocalo.x="+ls_h)
		
	ls_h=dw_1.describe("c_prog_legato.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_legato.x="+ls_h)
	
	ls_h=dw_1.describe("l_3.x2")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("l_3.x2="+ls_h)
		
	ls_h=dw_1.describe("l_1.x2")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("l_1.x2="+ls_h)
else
	dw_1.modify("fino.visible=1")
	dw_1.modify("calo.visible=1")
	dw_1.modify("c_calo_doc.visible=1")
	dw_1.modify("c_fino_doc.visible=1")
	dw_1.modify("riga_documento_calo_t.visible=1")
	dw_1.modify("riga_documento_fino_t.visible=1")
	
	ls_h=dw_1.describe("c_etichetta_saldo_prec.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_etichetta_saldo_prec.x="+ls_h)
	
	ls_h=dw_1.describe("c_saldo_prec_peso.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_saldo_prec_peso.x="+ls_h)
	
	ls_h=dw_1.describe("c_saldo_prec_fc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_saldo_prec_fc.x="+ls_h)
	
	ls_h=dw_1.describe("t_prog_legato.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("t_prog_legato.x="+ls_h)
	
	ls_h=dw_1.describe("t_prog_fc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("t_prog_fc.x="+ls_h)
	
	ls_h=dw_1.describe("t_fc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("t_fc.x="+ls_h)
	
	ls_h=dw_1.describe("c_finocalo.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_finocalo.x="+ls_h)
	
	ls_h=dw_1.describe("c_prog_finocalo_doc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_finocalo_doc.x="+ls_h)
	
	ls_h=dw_1.describe("c_finocalo_doc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_finocalo_doc.x="+ls_h)
		
	ls_h=dw_1.describe("c_prog_legato_doc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_legato_doc.x="+ls_h)
	
	ls_h=dw_1.describe("c_prog_finocalo.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_finocalo.x="+ls_h)
		
	ls_h=dw_1.describe("c_prog_legato.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_legato.x="+ls_h)
	
	ls_h=dw_1.describe("l_3.x2")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("l_3.x2="+ls_h)
		
	ls_h=dw_1.describe("l_1.x2")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("l_1.x2="+ls_h)
end if


end event

type cbx_summary_invisibile from checkbox within w_new_partite_rpt
integer x = 791
integer y = 176
integer width = 571
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Totali in Fondo Invisibili"
boolean righttoleft = true
end type

event clicked;string ls_filter

if checked then 
	dw_1.modify("datawindow.summary.height = 0")
	
else
dw_1.modify("datawindow.summary.height = 80")
	
end if


end event

type ddlb_1 from dropdownlistbox within w_new_partite_rpt
integer x = 1989
integer y = 20
integer width = 411
integer height = 352
integer taborder = 12
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"Solo Clienti","Solo Fornitori","TUTTI"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
if index=1 then
	ls_sql_tipo= " and sog_commerciale.tipo ='C' "
	
	
	//dw_1.setfilter("sog_commerciale_tipo='C'")
elseif index=2 then
	ls_sql_tipo=" and sog_commerciale.tipo ='F' "
	//dw_1.setfilter("sog_commerciale_tipo='F'")
else
	ls_sql_tipo="Togli tipo"
	//dw_1.setfilter("")
end if
dw_1.retrieve(s_new_mag.da_data, s_new_mag.a_data, ldc_saldo_peso_precedente, ldc_saldo_fc_precedente)
//dw_1.filter()
//dw_1.MODIFY("c_finocalo_1.format='#,0.00'")
//	dw_1.MODIFY("compute_13.format='#,0.00'")
//	dw_1.MODIFY("c_prog_legato.format='#,0.00'")
end event

type cbx_2 from checkbox within w_new_partite_rpt
integer x = 1413
integer y = 176
integer width = 590
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi saldi precedenti"
end type

event clicked;if checked then
	dw_1.modify("c_saldo_prec_fc_1.visible=1")
	dw_1.modify("c_saldo_prec_peso_1.visible=1")
	dw_1.modify("t_18.visible=1")
	dw_1.modify("t_19.visible=1")
else
	dw_1.modify("c_saldo_prec_fc_1.visible=0")
	dw_1.modify("c_saldo_prec_peso_1.visible=0")
	dw_1.modify("t_18.visible=0")
	dw_1.modify("t_19.visible=0")
end if
end event

type cbx_3 from checkbox within w_new_partite_rpt
integer x = 1993
integer y = 176
integer width = 558
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi saldi di Periodo"
end type

event clicked;integer i

if checked then
	dw_1.MODIFY("c_finocalo_1.visible=1")
	dw_1.MODIFY("c_calo_1.visible=1")
	dw_1.MODIFY("c_fino_1.visible=1")
	dw_1.MODIFY("c_qta_1.visible=1")
	dw_1.MODIFY("c_legato_1.visible=1")
	for i= 13 to 17
		dw_1.MODIFY("t_"+string(i)+".visible=1")
	next
else
	dw_1.MODIFY("c_finocalo_1.visible=0")
	dw_1.MODIFY("c_calo_1.visible=0")
	dw_1.MODIFY("c_fino_1.visible=0")
	dw_1.MODIFY("c_qta_1.visible=0")
	dw_1.MODIFY("c_legato_1.visible=0")
	for i= 13 to 17
		dw_1.MODIFY("t_"+string(i)+".visible=0")
	next
end if
end event

