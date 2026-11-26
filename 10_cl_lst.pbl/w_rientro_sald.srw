forward
global type w_rientro_sald from w_001
end type
type dw_1 from udw_base within w_rientro_sald
end type
type dw_3 from udw_base within w_rientro_sald
end type
type cb_passa from commandbutton within w_rientro_sald
end type
type cb_1 from commandbutton within w_rientro_sald
end type
type dw_9 from udw_base within w_rientro_sald
end type
type dw_2 from udw_figlia within w_rientro_sald
end type
type dw_8 from udw_base within w_rientro_sald
end type
type rb_2018 from radiobutton within w_rientro_sald
end type
type rb_2019 from radiobutton within w_rientro_sald
end type
type rb_2020 from radiobutton within w_rientro_sald
end type
type cb_2 from commandbutton within w_rientro_sald
end type
type rb_2021 from radiobutton within w_rientro_sald
end type
type rb_2022 from radiobutton within w_rientro_sald
end type
type rr_1 from roundrectangle within w_rientro_sald
end type
end forward

global type w_rientro_sald from w_001
boolean visible = false
integer x = 1057
integer y = 483
integer width = 3675
integer height = 2680
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_3 dw_3
cb_passa cb_passa
cb_1 cb_1
dw_9 dw_9
dw_2 dw_2
dw_8 dw_8
rb_2018 rb_2018
rb_2019 rb_2019
rb_2020 rb_2020
cb_2 cb_2
rb_2021 rb_2021
rb_2022 rb_2022
rr_1 rr_1
end type
global w_rientro_sald w_rientro_sald

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
end variables

forward prototypes
public subroutine wf_articolo (long al_id_articolo, long al_riga_doc)
public function long wf_importa (integer ai_riga)
end prototypes

public subroutine wf_articolo (long al_id_articolo, long al_riga_doc);//string ls_codice
//long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_tab_iva
//long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc
//
//setnull(ll_null)
//ll_riga_trovata=dw_4.find("id_articolo="+string(al_id_articolo), 1, dw_4.rowcount())
//if ll_riga_trovata>0 then
//	ls_codice=dw_4.getitemstring(ll_riga_trovata, "codice")
//	select id_articolo
//	into :ll_id_art_locale
//	from dba.articolo
//	where codice=:ls_codice
//	USING trans_destinazione
//;
//	if ll_id_art_locale>0 then //l'articolo esiste già non si deve fare nulla a parte recuperare la uc ...
//		dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
//		ll_riga_uc=dw_7.retrieve(ll_id_art_locale)
//		if ll_riga_uc>0 then
//			ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
//			dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
//		else
//			
//		end if
//	else //l'articolo non esiste occorre inserirlo
//		dw_6.reset()
//		dw_7.reset()
//		ll_riga_trovata_uc=dw_5.find("id_articolo="+string(al_id_articolo), 1, dw_5.rowcount())
//		if ll_riga_trovata_uc>0 then
//			dw_4.rowscopy(ll_riga_trovata, ll_riga_trovata, primary!, dw_6, 1, primary!)
//			dw_6.setitem(1, "id_articolo", ll_null)
//			dw_6.setitem(1,"id_sog_comm_variante", ll_null)
//			ll_id_tab_iva=dw_6.getitemnumber(1, "id_tab_iva")
//			if isnull(ll_id_tab_iva) then dw_6.setitem(1, "id_tab_iva",122) //22%
//			dw_6.setitemstatus(1, 0, Primary!, NewModified!)
//			
//			dw_6.trigger event ue_update()
//			ll_id_art_locale=dw_6.getitemnumber(1, "id_articolo")
//			dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
//			ll_id_um=dw_5.getitemnumber(ll_riga_trovata_uc, "id_unita_misura")
//			ll_riga_uc=dw_7.retrieve(ll_id_art_locale)
//			if ll_riga_uc>0 then
//				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
//				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
//				dw_7.setitem(1, "id_unita_misura", ll_id_um)
//				dw_7.trigger event ue_update()
//			else
//				dw_5.rowscopy(ll_riga_trovata_uc, ll_riga_trovata_uc, primary!, dw_7, 1, primary!)
//				dw_7.SetItem(1,"id_unita_confezione", ll_null)
//				dw_7.setitem(1, "id_articolo", ll_id_art_locale)
//				dw_7.setitemstatus(1, 0, Primary!, NewModified!)
//				dw_7.trigger event ue_update()	
//				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
//				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
//			end if
//		end if
//	end if
//end if
end subroutine

public function long wf_importa (integer ai_riga);long ll_id_prof,  ll_id_locazione, ll_id_causale,  ll_id_magazzino, ll_id_mod_reg, ll_id_registro, ll_id_doc, ll_null, ll_num_prog
date ldt_data_odierna, ldt_data_doc
integer li_ret, i
string ls_tipo_registro, ls_numero, ls_nota, ls_id_doc,ls_num
long ll_righe, ll_return, ll_num_prog_nuovo,ll_id_riga_doc_provenienza, ll_riga_doc_inserito, ll_id_sog_comm

setnull(ll_null)

ll_id_prof=dw_3.getitemnumber(1,"id_prof_destinazione")
if isnull(ll_id_prof) then
	messagebox("Attenzione!", "Il profilo di destinazione DEVE essere valorizzato! Operazione annullata!")
	return -1
end if
select id_locazione_1_prop, id_magazzino_1_prop, id_mod_registro_prop, id_caus_magazzino_prop
into :ll_id_locazione, :ll_id_magazzino, :ll_id_mod_reg, :ll_id_causale
from dba.prof_documento
where id_prof_documento=:ll_id_prof
;
//con il modello registro recupero il registro nell'esercizio corrente
ldt_data_odierna=date(today())
select r.id_registro, r.num_progressivo
into :ll_id_registro, :ll_num_prog_nuovo
from dba.registro r, esercizio e
where r.id_mod_registro=:ll_id_mod_reg
and e.id_esercizio=r.id_esercizio
and e.data_inizio<=:ldt_data_odierna
and e.data_fine>=:ldt_data_odierna
;

//l'ID DOCUMENTO lo salvo poi nell'origine documento
ll_id_doc=dw_1.getitemnumber(1, "id_documento")

//controllo che il documento non esista già ?NON posso più perché faccio un solo doc a fronte
ls_id_doc=string(ll_id_doc)
select num_progressivo
into :ll_num_prog
from dba.documento
where origine=:ls_id_doc
;
if ll_num_prog>0 then
	messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog)+"!")
else
	
	//fine controllo
	ls_numero=dw_1.getitemstring(1, "num_documento")
	ldt_data_doc=dw_1.getitemdate(1, "data_documento")
	ll_num_prog=0

	//24052017  segno nel campo "note_intestazione" che è inserito in automatico da questo passaggio dati 24052017
	dw_1.SetItem(1, "origine",  string(ll_id_doc))
	ls_nota="Rif. Doc. n. "+ls_numero+" del "+string(ldt_data_doc)
	dw_1.SetItem(1, "note_intestazione",  "Ins. AUTOMATICO  "+ls_nota)
	//occorrono: il nuovo profilo con causale, magazzino, registro, num_progressivo (il num_doc = a quello derivato e la data è del giorno)
	dw_1.SetItem(1, "data_documento", ldt_data_odierna)
	dw_1.SetItem(1, "data_registrazione", ldt_data_odierna)
	dw_1.SetItem(1, "id_prof_documento", ll_id_prof)
	dw_1.SetItem(1, "id_caus_magazzino", ll_id_causale)
	dw_1.SetItem(1, "id_magazzino", ll_id_magazzino)
	dw_1.SetItem(1, "id_locazione_1", ll_id_locazione)
	dw_1.SetItem(1, "id_registro", ll_id_registro)
	dw_1.SetItem(1, "num_progressivo", ll_num_prog_nuovo)
	//occorre anche un nuovo intestatario: "BURATTO" (Samy) id_sog_commerciale=1996
	dw_1.SetItem(1, "id_sog_commerciale", 1996)
	dw_1.SetItem(1, "id_sog_commerciale_fattura", 1996)
	//fine 24052017
	dw_1.SetItem(1, "id_documento", ll_null)
	dw_1.setitemstatus(1, 0, Primary!, NewModified!)
	//salvo doc
	li_ret=dw_1.trigger event ue_update()
	//ora le righe
	setnull(ll_id_doc)
	ll_id_doc=dw_1.getItemnumber(1, "id_documento")
	if ll_id_doc>0 then
		ll_righe=dw_2.rowcount()
		for i= 1 to ll_righe
			dw_2.SetItem(i, "id_documento", ll_id_doc)
			dw_2.SetItem(i, "id_caus_magazzino", ll_id_causale)
			dw_2.SetItem(i, "id_locazione_1", ll_id_locazione)
			ll_id_riga_doc_provenienza=dw_2.getitemnumber(i, "id_riga_documento")
			
			dw_2.SetItem(i, "provv_carea_2", ll_id_riga_doc_provenienza)
			dw_2.SetItem(i, "id_riga_documento", ll_null)
			dw_2.setitemstatus(i, 0, Primary!, NewModified!)
		next
		//salvo righe
		li_ret=dw_2.trigger event ue_update()
		if li_ret=1 then
			ll_return=ll_id_doc
			//inserisco il doc nella tabella dei doc passati per l'eventuale stampa a memoria
			ll_riga_doc_inserito=dw_9.insertrow(0)
			dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ll_num_prog_nuovo)
			dw_9.setitem(ll_riga_doc_inserito, "num_documento",	ls_numero)
			dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_odierna)
		else
			messagebox("Attenzione!", "RIGA NON salvata!!")
		end if
	else
		messagebox("Attenzione!", "Doc NON salvato!!")
	end if
end if


return ll_return
	
	
	

end function

on w_rientro_sald.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_passa=create cb_passa
this.cb_1=create cb_1
this.dw_9=create dw_9
this.dw_2=create dw_2
this.dw_8=create dw_8
this.rb_2018=create rb_2018
this.rb_2019=create rb_2019
this.rb_2020=create rb_2020
this.cb_2=create cb_2
this.rb_2021=create rb_2021
this.rb_2022=create rb_2022
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_passa
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_9
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_8
this.Control[iCurrent+8]=this.rb_2018
this.Control[iCurrent+9]=this.rb_2019
this.Control[iCurrent+10]=this.rb_2020
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.rb_2021
this.Control[iCurrent+13]=this.rb_2022
this.Control[iCurrent+14]=this.rr_1
end on

on w_rientro_sald.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_passa)
destroy(this.cb_1)
destroy(this.dw_9)
destroy(this.dw_2)
destroy(this.dw_8)
destroy(this.rb_2018)
destroy(this.rb_2019)
destroy(this.rb_2020)
destroy(this.cb_2)
destroy(this.rb_2021)
destroy(this.rb_2022)
destroy(this.rr_1)
end on

event open;call super::open;
dw_8.settransobject(sqlca)
dw_9.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.insertrow(1)

//dw_3.setitem(1, "da_data", relativedate(today(), - 30))






end event

event ue_postopen;call super::ue_postopen;dw_3.post setfocus()
dw_3.post setcolumn("cod_barre")
end event

type st_1 from w_001`st_1 within w_rientro_sald
end type

type dw_1 from udw_base within w_rientro_sald
integer x = 73
integer y = 1772
integer width = 3461
boolean bringtotop = true
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
end type

type dw_3 from udw_base within w_rientro_sald
integer x = 55
integer y = 28
integer width = 2181
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_rientro_sald_barre"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;integer li_anno
string ls_num_doc, ls_num_bollettina, ls_test
long ll_num_prog, ll_id_bollettina, ll_id_test

if dwo.name="cod_barre"  then
	if len(data)=7   then
		
		//da cambiare subito!!! 
	if rb_2022.checked then
			li_anno=2022
		elseif	rb_2021.checked then
			li_anno=2021
		elseif rb_2020.checked then
			li_anno=2020
		elseif rb_2019.checked then
			li_anno=2019
		elseif rb_2018.checked then
			li_anno=2018
		end if
		ls_num_doc=mid(data, 3, 5)
		ll_num_prog=long(ls_num_doc)
			
		select id_documento, num_documento
		into :ll_id_bollettina, :ls_num_bollettina
		from dba.documento d, dba.prof_documento p
		where right(num_documento, 5)=:ls_num_doc
		//where num_progressivo=:ll_num_prog
		//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
		and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
		and d.id_prof_documento=p.id_prof_documento
		and year(data_documento)=:li_anno
		;

		if ll_id_bollettina>0 then
			ls_test="id_documento="+string(ll_id_bollettina)
			ll_id_test=dw_8.find(ls_test, 1, dw_1.rowcount())
			if ll_id_test>0 then
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
			else
				dw_8.retrieve(ll_id_bollettina)
				dw_3.setitem(1, "cod_barre", "")
				dw_3.setfocus()
				dw_3.setcolumn("cod_barre")
			end if
		else
			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
		end if
	end if
end if
end event

type cb_passa from commandbutton within w_rientro_sald
integer x = 2880
integer width = 677
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Crea RIENTRO"
end type

event clicked;integer li_ret, i, li_righe, a
long ll_id_riga_doc_provenienza, ll_id_doc, ll_id_riga
string ls_doc, ls_numero, ls_allegati, ls_num_doc, ls_test, ls_numero_doc_inserito
date ldt_data
integer li_pos
long ll_id_art, ll_id_doc_inserito, ll_riga_doc_inserito,ll_num_prog_doc_passato
decimal ldc_num_bollettina

datastore ds_doc, ds_righe
ds_doc=create datastore
ds_doc.dataobject="ds_documento_2016"
ds_doc.settransobject(sqlca)

ds_righe=create datastore
ds_righe.dataobject="ds_riga_documento_2016"
ds_righe.settransobject(sqlca)



for a= 1 to dw_8.rowcount()


		ds_doc.reset()
		ds_righe.reset()
		dw_1.reset()
		dw_2.reset()

		ll_id_doc=dw_8.getitemnumber(a, "id_documento")
		li_ret=ds_doc.retrieve(ll_id_doc)
		
		if li_ret>0 then
			li_ret=ds_doc.rowscopy(1, 1, primary!, dw_1, 1, primary!)
			if li_ret<>1 then 
				messagebox("Attenzione!", "Errore copiatura doc!")
				return
			else
			//	li_ret=dw_1.trigger event ue_update()
			end if
		end if
	
		li_righe=ds_righe.retrieve(ll_id_doc)
		if li_righe>0 then
			li_ret=ds_righe.rowscopy(1, ds_righe.rowcount(), primary!, dw_2, 1, primary!)
			if li_ret<>1 then 
				messagebox("Attenzione!", "Errore copiatura righe!")	
				return
			else
				wf_importa(a)
			end if
			
		else
			messagebox("Attenzione!", "RIGA non trovata!")
		end if
	//END IF
next

destroy ds_doc
destroy ds_righe
end event

type cb_1 from commandbutton within w_rientro_sald
integer x = 3278
integer y = 120
integer width = 279
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;
dw_9.print(true, true)
end event

type dw_9 from udw_base within w_rientro_sald
integer x = 2240
integer y = 240
integer width = 1321
integer height = 1512
integer taborder = 20
string dataobject = "d_passa_Doc_inseriti"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc,  ll_id_riga
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list
date ldt_data
string ls_num_doc

if row>0 then
	ldt_data=getitemdate(row, "data_documento")
	ls_num_doc=getitemstring(row, "num_documento")
	select id_documento
	into :ll_id_doc
	from dba.documento
	where data_documento=:ldt_data
	and num_documento=:ls_num_doc
	;
	
	//ll_id_doc=getitemnumber(row, "id_documento")
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
end if



end event

type dw_2 from udw_figlia within w_rientro_sald
integer x = 78
integer y = 2172
integer width = 3461
integer height = 404
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
boolean livescroll = false
end type

type dw_8 from udw_base within w_rientro_sald
integer x = 55
integer y = 240
integer width = 2167
integer height = 1512
string dataobject = "d_ra_doc_rientro_fo"
boolean hscrollbar = true
end type

event sqlpreview;call super::sqlpreview;string ls_sql
integer i

ls_sql=sqlsyntax

if il_id_prof_doc>0 then
		ls_sql+= " and documento.id_prof_documento= "+string(il_id_prof_doc)+" "
end if
	
if il_id_sog>0 then
		ls_sql+= " and documento.id_sog_commerciale= "+string(il_id_sog)+" "
end if	

if idt_da_data> date('2010-01-01') then
	ls_sql+= " and documento.data_documento>= '"+string(idt_da_data, "yyyy-mm-dd")+"' "
end if
if ls_sql>sqlsyntax then
	i=SetSQLPreview(ls_sql)
end if
	
end event

event retrievestart;call super::retrievestart;return 2
end event

type rb_2018 from radiobutton within w_rientro_sald
integer x = 2574
integer y = 160
integer width = 247
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "2018"
end type

type rb_2019 from radiobutton within w_rientro_sald
integer x = 2574
integer y = 92
integer width = 247
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "2019"
end type

type rb_2020 from radiobutton within w_rientro_sald
integer x = 2313
integer y = 156
integer width = 233
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "2020"
end type

type cb_2 from commandbutton within w_rientro_sald
integer x = 2546
integer width = 325
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Pulisci"
end type

event clicked;if messagebox("Attenzione!", "Se Non avete creato i rientri pensateci bene a resettare tutto! Vuoi resettare?", stopsign!, yesno!)=1 then
	dw_8.reset()
end if
end event

event rbuttondown;if messagebox("Attenzione!", "Se Non avete creato i rientri pensateci bene a resettare tutto! Vuoi resettare?", stopsign!, yesno!)=1 then
	dw_9.reset()
end if
end event

type rb_2021 from radiobutton within w_rientro_sald
integer x = 2313
integer y = 80
integer width = 233
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "2021"
boolean checked = true
end type

type rb_2022 from radiobutton within w_rientro_sald
integer x = 2313
integer y = 12
integer width = 233
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "2022"
end type

type rr_1 from roundrectangle within w_rientro_sald
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 2880
integer y = 140
integer width = 329
integer height = 92
integer cornerheight = 40
integer cornerwidth = 46
end type

