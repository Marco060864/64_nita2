forward
global type w_reso_bucci from w_001
end type
type dw_1 from udw_base within w_reso_bucci
end type
type dw_3 from udw_base within w_reso_bucci
end type
type cb_passa from commandbutton within w_reso_bucci
end type
type cb_1 from commandbutton within w_reso_bucci
end type
type dw_2 from udw_figlia within w_reso_bucci
end type
type dw_8 from udw_base within w_reso_bucci
end type
type cbx_4 from checkbox within w_reso_bucci
end type
type dw_4 from udw_001 within w_reso_bucci
end type
type pb_1 from picturebutton within w_reso_bucci
end type
type dw_5 from udw_001 within w_reso_bucci
end type
type cb_agg from commandbutton within w_reso_bucci
end type
type cbx_sel from checkbox within w_reso_bucci
end type
type dw_6 from udw_base within w_reso_bucci
end type
type cb_2 from commandbutton within w_reso_bucci
end type
end forward

global type w_reso_bucci from w_001
boolean visible = false
integer x = 1057
integer y = 483
integer width = 5426
integer height = 2760
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_3 dw_3
cb_passa cb_passa
cb_1 cb_1
dw_2 dw_2
dw_8 dw_8
cbx_4 cbx_4
dw_4 dw_4
pb_1 pb_1
dw_5 dw_5
cb_agg cb_agg
cbx_sel cbx_sel
dw_6 dw_6
cb_2 cb_2
end type
global w_reso_bucci w_reso_bucci

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
end variables

forward prototypes
public subroutine wf_articolo (long al_id_articolo, long al_riga_doc)
public function long wf_importa (integer ai_riga)
public subroutine wf_bilancia (long al_riga_inserita)
public subroutine wf_lista_doc (long ll_id_prof, string ls_num_doc, date ldt_data_doc, long ll_id_doc_inserito, long ll_id_sog, long ll_num_prog)
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

public function long wf_importa (integer ai_riga);//long ll_id_prof,  ll_id_locazione, ll_id_causale,  ll_id_magazzino, ll_id_mod_reg, ll_id_registro, ll_id_doc, ll_null, ll_num_prog
//date ldt_data_odierna, ldt_data_doc
//integer li_ret, i
//string ls_tipo_registro, ls_numero, ls_nota, ls_id_doc
//long ll_righe, ll_return, ll_num_prog_nuovo,ll_id_riga_doc_provenienza, ll_riga_doc_inserito
//
//setnull(ll_null)
//
//ll_id_prof=dw_3.getitemnumber(1,"id_prof_destinazione")
//if isnull(ll_id_prof) then
//	messagebox("Attenzione!", "Il profilo di destinazione DEVE essere valorizzato! Operazione annullata!")
//	return -1
//end if
//select id_locazione_1_prop, id_magazzino_1_prop, id_mod_registro_prop, id_caus_magazzino_prop
//into :ll_id_locazione, :ll_id_magazzino, :ll_id_mod_reg, :ll_id_causale
//from dba.prof_documento
//where id_prof_documento=:ll_id_prof
//;
////con il modello registro recupero il registro nell'esercizio corrente
//ldt_data_odierna=date(today())
//select r.id_registro, r.num_progressivo
//into :ll_id_registro, :ll_num_prog_nuovo
//from dba.registro r, esercizio e
//where r.id_mod_registro=:ll_id_mod_reg
//and e.id_esercizio=r.id_esercizio
//and e.data_inizio<=:ldt_data_odierna
//and e.data_fine>=:ldt_data_odierna
//;
//
////l'ID DOCUMENTO lo salvo poi nell'origine documento
//ll_id_doc=dw_1.getitemnumber(1, "id_documento")
//
////controllo che il documento non esista già ?NON posso più perché faccio un solo doc a fronte
//ls_id_doc=string(ll_id_doc)
//select num_progressivo
//into :ll_num_prog
//from dba.documento
//where origine=:ls_id_doc
//;
//if ll_num_prog>0 then
//	messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog)+"!")
//else
//	
//	//fine controllo
//	ls_numero=dw_1.getitemstring(1, "num_documento")
//	ldt_data_doc=dw_1.getitemdate(1, "data_documento")
//	ll_num_prog=0
//
//	//24052017  segno nel campo "origine" che è inserito in automatico da questo passaggio dati 24052017
//	dw_1.SetItem(1, "origine",  string(ll_id_doc))
//	ls_nota="Rif. Doc. n. "+ls_numero+" del "+string(ldt_data_doc)
//	dw_1.SetItem(1, "note_intestazione",  "Ins. AUTOMATICO  "+ls_nota)
//	//occorrono: il nuovo profilo con causale, magazzino, registro, num_progressivo (il num_doc = a quello derivato e la data è del giorno)
//	dw_1.SetItem(1, "data_documento", ldt_data_odierna)
//	dw_1.SetItem(1, "data_registrazione", ldt_data_odierna)
//	dw_1.SetItem(1, "id_prof_documento", ll_id_prof)
//	dw_1.SetItem(1, "id_caus_magazzino", ll_id_causale)
//	dw_1.SetItem(1, "id_magazzino", ll_id_magazzino)
//	dw_1.SetItem(1, "id_locazione_1", ll_id_locazione)
//	dw_1.SetItem(1, "id_registro", ll_id_registro)
//	dw_1.SetItem(1, "num_progressivo", ll_num_prog_nuovo)
//	//fine 24052017
//	dw_1.SetItem(1, "id_documento", ll_null)
//	dw_1.setitemstatus(1, 0, Primary!, NewModified!)
//	//salvo doc
//	li_ret=dw_1.trigger event ue_update()
//	//ora le righe
//	setnull(ll_id_doc)
//	ll_id_doc=dw_1.getItemnumber(1, "id_documento")
//	if ll_id_doc>0 then
//		ll_righe=dw_2.rowcount()
//		for i= 1 to ll_righe
//			dw_2.SetItem(i, "id_documento", ll_id_doc)
//			dw_2.SetItem(i, "id_caus_magazzino", ll_id_causale)
//			dw_2.SetItem(i, "id_locazione_1", ll_id_locazione)
//			ll_id_riga_doc_provenienza=dw_2.getitemnumber(i, "id_riga_documento")
//			dw_2.SetItem(i, "id_riga_doc_provenienza", ll_id_riga_doc_provenienza)
//			dw_2.SetItem(i, "id_riga_documento", ll_null)
//			dw_2.setitemstatus(i, 0, Primary!, NewModified!)
//		next
//		//salvo righe
//		li_ret=dw_2.trigger event ue_update()
//		if li_ret=1 then
//			ll_return=ll_id_doc
//			//inserisco il doc nella tabella dei doc passati per l'eventuale stampa a memoria
//			ll_riga_doc_inserito=dw_9.insertrow(0)
//			dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ll_num_prog_nuovo)
//			dw_9.setitem(ll_riga_doc_inserito, "num_documento",	ls_numero)
//			dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_odierna)
//		end if
//	else
//		messagebox("Attenzione!", "Doc NON salvato!!")
//	end if
//end if
//
//
return 0
//	
//	
//	
//
end function

public subroutine wf_bilancia (long al_riga_inserita);DWObject my_dwo
decimal ld_peso_netto,ldc_coef_calo, ldc_titolo, ldc_calo, ldc_fino
long	ll_row, ll_id_articolo
string ls_metallo



w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()
dw_3.setitem(1, "legato", ld_peso_netto)
dw_2.setitem(al_riga_inserita, "peso_netto", ld_peso_netto)
ldc_coef_calo=dw_2.getitemdecimal(al_riga_inserita, "coef_calo")
ldc_calo=ld_peso_netto*ldc_coef_calo/1000
ll_id_articolo=dw_2.getitemnumber(al_riga_inserita, "id_articolo")
select titolo
into :ldc_titolo
from orafo_titolo t, articolo a
where a.id_titolo=t.id_titolo
and a.id_articolo=:ll_id_articolo
;

ldc_fino=round(ld_peso_netto*ldc_titolo/1000, 2)
ldc_calo=round(ld_peso_netto*ldc_coef_calo/1000,2) - ldc_fino
dw_2.setitem(al_riga_inserita, "fino", ldc_fino)
dw_2.setitem(al_riga_inserita, "calo", ldc_calo)
close(w_bil)
end subroutine

public subroutine wf_lista_doc (long ll_id_prof, string ls_num_doc, date ldt_data_doc, long ll_id_doc_inserito, long ll_id_sog, long ll_num_prog);dw_6.insertrow(1)
dw_6.setitem(1, "id_profilo", ll_id_prof)
dw_6.setitem(1, "num_documento", ls_num_doc)
dw_6.setitem(1, "data_documento", ldt_data_doc)
dw_6.setitem(1, "id_documento", ll_id_doc_inserito)
dw_6.setitem(1, "id_sog_commerciale", ll_id_sog)
dw_6.setitem(1, "num_progressivo", ll_num_prog)
end subroutine

on w_reso_bucci.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_passa=create cb_passa
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_8=create dw_8
this.cbx_4=create cbx_4
this.dw_4=create dw_4
this.pb_1=create pb_1
this.dw_5=create dw_5
this.cb_agg=create cb_agg
this.cbx_sel=create cbx_sel
this.dw_6=create dw_6
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_passa
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_8
this.Control[iCurrent+7]=this.cbx_4
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.pb_1
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.cb_agg
this.Control[iCurrent+12]=this.cbx_sel
this.Control[iCurrent+13]=this.dw_6
this.Control[iCurrent+14]=this.cb_2
end on

on w_reso_bucci.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_passa)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_8)
destroy(this.cbx_4)
destroy(this.dw_4)
destroy(this.pb_1)
destroy(this.dw_5)
destroy(this.cb_agg)
destroy(this.cbx_sel)
destroy(this.dw_6)
destroy(this.cb_2)
end on

event open;date ldt_da_data, ldt_a_data
integer li_anno
//st_1.visible=false

post event ue_postopen()

dw_8.settransobject(sqlca)
//dw_9.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)

dw_3.insertrow(1)
dw_4.insertrow(1)
dw_5.insertrow(1)
li_anno=year(today())
ldt_da_data=date("01/01/2020")//+string(li_anno - 1) )
dw_5.setitem(1, "da_data", ldt_da_data)
ldt_a_data=date("31/12/"+string(li_anno))
dw_5.setitem(1, "a_data",ldt_a_data )
//dw_3.setitem(1, "da_data", relativedate(today(), - 30))

dw_8.retrieve(date("01/01/20"), ldt_a_data)




end event

event ue_postopen;call super::ue_postopen;//dw_3.post setfocus()
//dw_3.post setcolumn("cod_barre")
end event

type st_1 from w_001`st_1 within w_reso_bucci
end type

type dw_1 from udw_base within w_reso_bucci
integer x = 55
integer y = 1896
integer width = 2981
integer height = 312
boolean bringtotop = true
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
boolean vscrollbar = false
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type dw_3 from udw_base within w_reso_bucci
integer x = 55
integer y = 16
integer width = 2354
integer height = 204
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_rientro_galvanica_bu"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;//integer li_anno
//string ls_num_doc, ls_num_bollettina, ls_test,ls_galv,ls_lav
//long ll_num_prog, ll_id_bollettina, ll_id_test, ll_righe, ll_id_doc,ll_riga,ll_id_galv
//decimal ldc_prezzo, ldc_prezzo_da_Data1
//date ldt_data
//
//if dwo.name="cod_barre"  then
//	if len(data)=7   then
//		
//		//da cambiare subito!!!
//		if rb_2021.checked then
//			li_anno=2021
//		elseif	rb_2020.checked then
//			li_anno=2020
//		elseif rb_2019.checked then
//			li_anno=2019
//		elseif rb_2018.checked then
//			li_anno=2018
//		end if
//		ls_num_doc=mid(data, 3, 5)
//		ll_num_prog=long(ls_num_doc)
//			
//		select id_documento, num_documento
//		into :ll_id_bollettina, :ls_num_bollettina
//		from dba.documento d, dba.prof_documento p
//		where right(num_documento, 5)=:ls_num_doc
//		//where num_progressivo=:ll_num_prog
//		//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
//		and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
//		and d.id_prof_documento=p.id_prof_documento
//		and year(data_documento)=:li_anno
//		;
//
//		if ll_id_bollettina>0 then
//			ls_test="id_documento="+string(ll_id_bollettina)
//			ll_id_test=dw_8.find(ls_test, 1, dw_1.rowcount())
//			if ll_id_test>0 then
//				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
//			else
//				dw_8.retrieve(ll_id_bollettina)
//	
//				dw_3.setitem(1, "cod_barre", "")
//				dw_3.setfocus()
//				dw_3.setcolumn("cod_barre")
//				
//				ll_righe=dw_2.retrieve(ll_id_bollettina)
//				wf_bilancia(dw_2.rowcount())
//				setcolumn("cod_barre_galvanica")
//			end if
//		else
//			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
//		end if
//	end if
//end if
//
//if dwo.name="cod_barre_galvanica"  then
//	if len(data)=13   then
//		ll_riga=dw_2.rowcount()
//		ls_galv=left(data, 12)
//		ls_galv=right(ls_galv, 5)
//		ll_id_galv=long(ls_galv)
//		ldt_data=dw_3.getitemdate(1, "doc_data")
//		ls_galv=""
//		select lavorazione, descrizione
//		into :ls_lav, :ls_galv
//		from dba.galvanica
//		where id_galvanica=:ll_id_galv
//		;
//		ldc_prezzo=f_rec_prezzo_galvanica(ldt_data, ll_id_galv)
////		ldt_data=dw_3.getitemdate(1, "doc_data")
////		if ldt_data> date("2000-01-01") then
////			if ldt_data>= date("2019-06-01") then
////				 ldc_prezzo=ldc_prezzo_da_Data1
////			end if
////		else
////			messagebox("Attenzione!", "Inserire Data Doc Destinazione!")
////		end if
//
//		dw_2.setitem(ll_riga, "prezzo_metallo",ldc_prezzo)
//		dw_2.setitem(ll_riga, "id_gruppo_agenti_2",ll_id_galv)
//		ls_test=dw_2.getitemstring(ll_riga, "descrizione")
//		if ls_test> " " then
//			ls_galv=ls_test+"  __ "+ls_galv
//		end if
//		dw_2.setitem(ll_riga, "descrizione", ls_galv)
//		dw_3.setitem(1, "cod_barre", "")
//		dw_3.setitem(1, "cod_barre_galvanica", "")
//		dw_8.setitem(1, "sog_commerciale_gen_codice", ls_lav)  //speriamo vada bene 1 ....
//		dw_3.setfocus()
//		dw_3.setcolumn("cod_barre")
//	end if
//	
//	
//end if
end event

type cb_passa from commandbutton within w_reso_bucci
integer x = 2505
integer y = 16
integer width = 357
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Doc"
end type

event clicked;integer li_ret, i, li_righe, b,  a=0, c
long     ll_null,ll_riga_doc, ll_id_doc, ll_id_galvanica,ll_riga_inserita, ll_id_art, ll_id_prof
string    ls_num_doc, ls_tipo_registro,ls_nota="", ls_num_bol, ls_des,ls_filtro
date  ldt_data_doc
long  ll_id_doc_inserito,  ll_id_profilo_test[],ll_id_sog, ll_id_riga_provenienza,ll_id_loc1, ll_id_loc2, ll_id_causale
long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre,ll_id_valuta, ll_id_iva, ll_id_uc
setnull(ll_null)
decimal ldc_prezzo, ldc_legato, ldc_tot_riga, ldc_qta,ldc_calo



ll_id_profilo_test[1]=dw_3.getitemnumber(1, "id_prof_destinazione") //profilo Carolina CDCB
ll_id_profilo_test[2]=dw_3.getitemnumber(1, "id_prof_destinazione_2") //profilo bucci uk BUUK

for b=1 to 2
	
	if b=1  and  ll_id_profilo_test[1]>0 then 
		ls_filtro="scegli='S' and c_magazzino='CDCB'"
		ll_id_prof=ll_id_profilo_test[1]
	elseif  b=2 and  ll_id_profilo_test[2]>0 then 
		ls_filtro="scegli='S' and c_magazzino='BUUK'"
		ll_id_prof=ll_id_profilo_test[2]
	else
		continue
	end if
	dw_8.setfilter(ls_filtro)
	dw_8.filter()
	IF DW_8.ROWCOUNT()>0 THEN
		dw_1.reset()
		dw_2.reset()
		dw_3.accepttext()
	//	ll_id_doc=dw_8.getitemnumber(1, "id_documento")
	//	ll_riga_doc=dw_1.retrieve(ll_id_doc)
		ldt_data_doc=dw_3.getitemdate(1, "doc_data")
		
		select id_locazione_1_prop, id_locazione_2_prop, id_caus_magazzino_prop into :ll_id_loc1, :ll_id_loc2, :ll_id_causale from dba.prof_documento where id_prof_documento=:ll_id_prof;
		ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
		select id_valuta, id_tab_iva into :ll_id_valuta, :ll_id_iva from sog_commerciale where id_sog_commerciale=:ll_id_sog;
		ll_id_valuta=3
		ll_riga_doc=dw_1.insertrow(1)
		dw_1.setitem(ll_riga_doc, "id_documento", ll_null)
		dw_1.setitem(ll_riga_doc, "data_documento", ldt_data_doc)
		dw_1.setitem(ll_riga_doc, "id_prof_documento", ll_id_prof)
		dw_1.setitem(ll_riga_doc, "id_sog_commerciale", ll_id_sog)
		dw_1.setitem(ll_riga_doc, "id_sog_commerciale_fattura", ll_id_sog)
		dw_1.setitem(ll_riga_doc, "data_registrazione", ldt_data_doc)
		dw_1.setitem(ll_riga_doc, "id_valuta", ll_id_valuta)
		if ll_id_loc1>0 then dw_1.setitem(ll_riga_doc, "id_locazione_1", ll_id_loc1)
		if ll_id_loc2>0 then dw_1.setitem(ll_riga_doc, "id_locazione_2", ll_id_loc2)
		if ll_id_causale>0 then dw_1.setitem(ll_riga_doc, "id_caus_magazzino", ll_id_causale)
		//trovo il numprog
		u_setta_campi_documento uo_proponi_num_progressivo
		s_trova_progressivo ls_trova_prog
		select id_mod_registro_prop
		into :ll_id_mod_registro
		from dba.prof_documento
		where id_prof_documento=:ll_id_prof
		;
		select id_esercizio
		into :ll_id_esercizio
		from dba.esercizio
		where data_inizio<=:ldt_data_doc
		and data_fine>=:ldt_data_doc
		;
		SELECT Max("registro"."id_registro")
			INTO :ll_id_registro  
			FROM "dba"."registro"  
			WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
				( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
				
		dw_1.setitem(ll_riga_doc, "id_registro", ll_id_registro)
		select tipo_registro
		into :ls_tipo_registro
		from dba.registro
		where id_registro=:ll_id_registro
		;
		
		IF  ll_id_registro > 0 THEN
			uo_proponi_num_progressivo=create u_setta_campi_documento
			ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_registro, 0, ls_tipo_registro)
			destroy uo_proponi_num_progressivo
			dw_1.SetItem(ll_riga_doc, "num_progressivo", ls_trova_prog.sl_num_progressivo)
			//se c'è il numero lo prendo altrimenti è = al progressivo
			ls_num_doc=dw_3.getitemstring(1, "num_doc")
			if ls_num_doc> " " then
				dw_1.SetItem(ll_riga_doc, "num_documento", ls_num_doc)
			else
				dw_1.SetItem(ll_riga_doc, "num_documento", string( ls_trova_prog.sl_num_progressivo))
			end if
		end if	
	
		dw_1.setitem(ll_riga_doc, "note_intestazione", ls_nota)
		
		dw_1.setitemstatus(ll_riga_doc, 0, primary!, newmodified!)
		li_ret=dw_1.trigger event ue_update()
		ll_id_doc_inserito=dw_1.getitemnumber(1, "id_documento")
		wf_lista_doc(ll_id_prof, ls_num_doc, ldt_data_doc, ll_id_doc_inserito, ll_id_sog, ls_trova_prog.sl_num_progressivo)
		
		for i=1 to dw_8.rowcount()
			ll_riga_inserita=dw_2.insertrow(0)
			dw_2.setitem(ll_riga_inserita, "id_documento", ll_id_doc_inserito)
			dw_2.setitem(ll_riga_inserita, "num_riga", i)
			dw_2.setitem(ll_riga_inserita, "id_valuta", ll_id_valuta)
			ll_riga_madre=dw_8.getitemnumber(i, "id_riga_documento")
			dw_2.setitem(ll_riga_inserita, "id_riga_doc_provenienza", ll_riga_madre)
			dw_2.setitem(ll_riga_inserita, "id_riga_documento", ll_null)
			ldc_qta=dw_8.getitemnumber(i, "c_qta_residua")
			dw_2.setitem(ll_riga_inserita, "quantita", ldc_qta)
			dw_2.setitem(ll_riga_inserita, "qta_evasa", 0)
			dw_2.setitem(ll_riga_inserita, "qta_evasa_un_base", 0)
			dw_2.setitem(ll_riga_inserita, "qta_un_base", ldc_qta)
			dw_2.setitem(ll_riga_inserita, "qta_sconto_merce", 0)
			if ll_id_loc1>0 then dw_2.setitem(ll_riga_inserita, "id_locazione_1", ll_id_loc1)
			if ll_id_loc2>0 then dw_2.setitem(ll_riga_inserita, "id_locazione_2", ll_id_loc2)
			if ll_id_causale>0 then dw_2.setitem(ll_riga_inserita, "id_caus_magazzino", ll_id_causale)
			ll_id_uc=dw_8.getitemnumber(i, "id_unita_confezione")
			ll_id_galvanica=dw_8.getitemnumber(i, "id_gruppo_agenti_2") //è l'id_cartellino
			dw_2.setitem(ll_riga_inserita, "id_gruppo_agenti_2", ll_id_galvanica)
			dw_2.setitem(ll_riga_inserita, "id_unita_confezione", ll_id_uc)
			ll_id_art=dw_8.getitemnumber(i, "id_articolo")
			select coef_calo into :ldc_calo from dba.articolo where id_articolo=:ll_id_art;
			dw_2.setitem(ll_riga_inserita, "id_articolo", ll_id_art)
			dw_2.setitem(ll_riga_inserita, "coef_calo", ldc_calo)
			ldc_legato=0
			ldc_legato=dw_8.getitemdecimal(i, "c_peso_residuo")
	//		//ldc_prezzo=dw_2.getitemdecimal(i, "prezzo_metallo")
	//		//devo calcolare anche il totale riga ...
	//		ldc_tot_riga=dw_2.getitemdecimal(i, "tot_riga_val_az")
			dw_2.setitem(ll_riga_inserita, "peso_netto", ldc_legato)
			//if isnull(ldc_legato) then ldc_legato=0
			//if isnull(ldc_tot_riga) then ldc_tot_riga=0
			dw_2.setitem(ll_riga_inserita, "id_tab_iva", ll_id_iva)
	//		ldc_tot_riga+=ldc_prezzo*ldc_legato
	//		dw_2.setitem(i, "tot_riga_val_az", ldc_tot_riga)
	//		dw_2.setitem(i, "tot_riga_val_doc", ldc_tot_riga)
	//		dw_2.setitem(i, "tot_riga_val_riga", ldc_tot_riga)
			ls_des=dw_8.getitemstring(i, "descrizione")
			dw_2.setitem(ll_riga_inserita, "descrizione", ls_des)
			dw_2.setitemstatus(i, 0, primary!, newmodified!)
			//aggiorna LA BOLLETTINA CON peso_evaso e qta evasa
	//		update dba.riga_documento
	//		set qta_evasa=:ldc_qta, peso_netto_evaso=:ldc_legato
	//		where id_riga_documento=:ll_riga_madre
	//		;
	//		if sqlca.sqlNrows>0 then
	//			commit;
	//		else
	//			rollback;
	//			messagebox("Attenzione!", "La riga "+string(i)+" NON è stata aggiornata con il valore galvanica!")
	//		end if
		next
		li_ret=dw_2.trigger event ue_update()
	//	dw_8.reset()
	//	dw_1.reset()
	//	dw_2.reset()
		setfocus(dw_3)
		dw_3.setcolumn(1)
	END IF
next
end event

type cb_1 from commandbutton within w_reso_bucci
integer x = 2889
integer y = 20
integer width = 270
integer height = 192
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
dw_8.print(true, true)
end event

type dw_2 from udw_figlia within w_reso_bucci
integer x = 55
integer y = 2172
integer width = 2981
integer height = 452
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
boolean livescroll = false
end type

event retrievestart;call super::retrievestart;return 2
end event

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type dw_8 from udw_base within w_reso_bucci
integer x = 55
integer y = 240
integer width = 5285
integer height = 1636
string dataobject = "d_ra_doc_rientro_fo_bu"
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

event itemchanged;call super::itemchanged;decimal  ldc_qta, ldc_peso_precedente, ldc_peso_medio, ldc_peso_attuale
integer li_qta
if dwo.name='c_qta_residua' then
	li_qta= integer(data)
	ldc_qta=getitemdecimal(row, "c_qta_residua")
//	if ldc_qta<li_qta then 
//		messagebox("Attenzione!", "NON si può scaricare quantita maggiori di quella disponibile!")
//		return 2
//	end if
	ldc_peso_precedente=getitemdecimal(row, "c_peso_residuo")
	if ldc_qta=0 then ldc_qta=1
	ldc_peso_medio=round(ldc_peso_precedente/ldc_qta, 2)
	ldc_peso_attuale=ldc_peso_medio*li_qta
	setitem(row, "c_peso_residuo", ldc_peso_attuale)
	
	
end if
end event

type cbx_4 from checkbox within w_reso_bucci
integer x = 3186
integer y = 32
integer width = 635
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
string text = "Ordina per codice articolo"
end type

event clicked;
if checked then
	dw_8.setsort("articolo_codice, data_documento, num_documento, num_riga")
else
	dw_8.setsort("data_documento, num_documento, num_riga")
end if
dw_8.sort()
dw_8.groupcalc()
end event

type dw_4 from udw_001 within w_reso_bucci
integer x = 3826
integer y = 28
integer width = 882
integer height = 196
integer taborder = 50
boolean bringtotop = true
string dataobject = "D_FILTRA_ART_BUC"
end type

type pb_1 from picturebutton within w_reso_bucci
integer x = 4709
integer y = 28
integer width = 274
integer height = 196
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Ricerca.png"
alignment htextalign = left!
end type

event clicked;string ls_cod_art, ls_filtro

dw_4.accepttext()

ls_cod_art=dw_4.getitemstring(1, "cod_art")
if ls_cod_art>" " then
	ls_cod_art=upper(ls_cod_art)
	ls_filtro="articolo_codice like '"+ls_cod_art+"%'"
	dw_8.setfilter(ls_filtro)
	dw_8.filter()

end if




end event

type dw_5 from udw_001 within w_reso_bucci
integer x = 3200
integer y = 132
integer width = 608
integer height = 96
integer taborder = 50
boolean bringtotop = true
string dataobject = "D_FILTRA_date_BUCci"
boolean border = false
end type

event itemchanged;call super::itemchanged;date ldt_da_data, ldt_a_data
string ls_filtro

if dwo.name="a_data"   then
	ldt_da_data=getitemdate(row, "da_data")
	ldt_a_data=date(data)
	dw_8.retrieve(ldt_da_data, ldt_a_data)
//	ls_filtro="data_documento>= Date('"+string(ldt_da_data)+ "') and data_documento<= Date('"+string(ldt_a_data)+"')"
//	dw_8.setfilter(ls_filtro)
//	dw_8.filter()
end if
end event

type cb_agg from commandbutton within w_reso_bucci
integer x = 2505
integer y = 124
integer width = 357
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agg. a Doc."
end type

event clicked;integer li_ret, i, li_righe
long     ll_null,ll_riga_doc, ll_id_doc, ll_id_galvanica,ll_riga_inserita, ll_id_art,ll_max_n_riga,  ll_num_prog
string    ls_num_doc, ls_tipo_registro,ls_nota="", ls_num_bol, ls_des
date  ldt_data_doc
long  ll_id_doc_esistente,  ll_id_prof,ll_id_sog, ll_id_riga_provenienza,ll_id_loc1, ll_id_loc2, ll_id_causale
long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre,ll_id_valuta, ll_id_iva,ll_id_uc
setnull(ll_null)
decimal ldc_prezzo, ldc_legato, ldc_tot_riga, ldc_qta,ldc_calo
s_ricerca s_ric
w_new_ricerca_sw w_ric_sw


dw_8.setfilter("scegli='S'")
dw_8.filter()
IF DW_8.ROWCOUNT()>0 THEN
	dw_1.reset()
	dw_2.reset()

	s_ric.dataobject='d_doc_filtrati_sw'
	s_ric.titolo_finestra="Ricerca Documento"

	openwithparm(w_ric_sw, s_ric)
	if message.doubleparm>0 then
		ll_id_doc_esistente=message.doubleparm
		select d.id_valuta, s.id_tab_iva, d.id_locazione_1, d.id_locazione_2,  num_documento, data_documento, id_prof_documento, d.id_sog_commerciale, num_progressivo, id_caus_magazzino
		into :ll_id_valuta, :ll_id_iva, :ll_id_loc1, :ll_id_loc2, :ls_num_doc, :ldt_data_doc, :ll_id_prof, :ll_id_sog, :ll_num_prog, :ll_id_causale
		from dba.documento d , sog_commerciale s where s.id_sog_commerciale=d.id_sog_commerciale and id_documento=:ll_id_doc_esistente;
		if messagebox("Attenzione!", "Hai selezionato il Doc. n. "+ls_num_doc+" del "+string(ldt_data_doc, 'dd/mm/yyyy')+" al quale saranno aggiunte le righe scelte! Confermi?",stopsign!, yesno!)=1 then
			if isnull(ll_id_iva) or ll_id_iva=0 then 
				ll_id_iva=57
			end if
			
//			select id_locazione_1_prop, id_locazione_2_prop, id_caus_magazzino_prop 
//			into :ll_id_loc1, :ll_id_loc2, :ll_id_causale 
//			from dba.prof_documento where id_prof_documento=:ll_id_prof;
			
			for i=1 to dw_8.rowcount()
				ll_riga_inserita=dw_2.insertrow(0)
				dw_2.setitem(ll_riga_inserita, "id_documento", ll_id_doc_esistente)
				select max(num_riga) into :ll_max_n_riga from dba.riga_documento where id_documento= :ll_id_doc_esistente;
				if isnull(ll_max_n_riga) then ll_max_n_riga=0
				dw_2.setitem(ll_riga_inserita, "num_riga", i+ll_max_n_riga)
				dw_2.setitem(ll_riga_inserita, "id_valuta", ll_id_valuta)
				ll_riga_madre=dw_8.getitemnumber(i, "id_riga_documento")
				dw_2.setitem(ll_riga_inserita, "id_riga_doc_provenienza", ll_riga_madre)
				dw_2.setitem(ll_riga_inserita, "id_riga_documento", ll_null)
				ldc_qta=dw_8.getitemnumber(i, "c_qta_residua")
				dw_2.setitem(ll_riga_inserita, "quantita", ldc_qta)
				dw_2.setitem(ll_riga_inserita, "qta_sconto_merce", 0)
				if ll_id_loc1>0 then dw_2.setitem(ll_riga_inserita, "id_locazione_1", ll_id_loc1)
				if ll_id_loc2>0 then dw_2.setitem(ll_riga_inserita, "id_locazione_2", ll_id_loc2)
				if ll_id_causale>0 then dw_2.setitem(ll_riga_inserita, "id_caus_magazzino", ll_id_causale)
				
				ll_id_uc=dw_8.getitemnumber(i, "id_unita_confezione")
				ll_id_galvanica=dw_8.getitemnumber(i, "id_gruppo_agenti_2") //è l'id_cartellino
				dw_2.setitem(ll_riga_inserita, "id_gruppo_agenti_2", ll_id_galvanica)
				dw_2.setitem(ll_riga_inserita, "id_unita_confezione", ll_id_uc)
				ll_id_art=dw_8.getitemnumber(i, "id_articolo")
				select coef_calo into :ldc_calo from dba.articolo where id_articolo=:ll_id_art;
				dw_2.setitem(ll_riga_inserita, "id_articolo", ll_id_art)
				dw_2.setitem(ll_riga_inserita, "coef_calo", ldc_calo)
				ldc_legato=0
				ldc_legato=dw_8.getitemdecimal(i, "c_peso_residuo")
		
				dw_2.setitem(ll_riga_inserita, "peso_netto", ldc_legato)
			
				dw_2.setitem(ll_riga_inserita, "id_tab_iva", ll_id_iva)
		
				ls_des=dw_8.getitemstring(i, "descrizione")
				dw_2.setitem(ll_riga_inserita, "descrizione", ls_des)
				dw_2.setitemstatus(i, 0, primary!, newmodified!)
			
			next
			li_ret=dw_2.trigger event ue_update()
			wf_lista_doc(ll_id_prof,ls_num_doc,ldt_data_doc, ll_id_doc_esistente,ll_id_sog,ll_num_prog)
		
			setfocus(dw_3)
			dw_3.setcolumn(1)
		end if
	END IF
end if

end event

type cbx_sel from checkbox within w_reso_bucci
integer x = 4613
integer y = 260
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Sel. Tutti"
boolean lefttext = true
end type

event clicked;integer i

if checked then
	for I= 1 to dw_8.rowcount()
		dw_8.setitem(i, "scegli", "S")
	next
else
	for I= 1 to dw_8.rowcount()
		dw_8.setitem(i, "scegli", "N")
	next
end if
end event

type dw_6 from udw_base within w_reso_bucci
integer x = 3054
integer y = 1900
integer width = 2267
integer height = 720
boolean bringtotop = true
string dataobject = "d_doc_creati_agg_bu"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;//integer li_anno
//string ls_num_doc, ls_num_bollettina, ls_test,ls_galv,ls_lav
//long ll_num_prog, ll_id_bollettina, ll_id_test, ll_righe, ll_id_doc,ll_riga,ll_id_galv
//decimal ldc_prezzo, ldc_prezzo_da_Data1
//date ldt_data
//
//if dwo.name="cod_barre"  then
//	if len(data)=7   then
//		
//		//da cambiare subito!!!
//		if rb_2021.checked then
//			li_anno=2021
//		elseif	rb_2020.checked then
//			li_anno=2020
//		elseif rb_2019.checked then
//			li_anno=2019
//		elseif rb_2018.checked then
//			li_anno=2018
//		end if
//		ls_num_doc=mid(data, 3, 5)
//		ll_num_prog=long(ls_num_doc)
//			
//		select id_documento, num_documento
//		into :ll_id_bollettina, :ls_num_bollettina
//		from dba.documento d, dba.prof_documento p
//		where right(num_documento, 5)=:ls_num_doc
//		//where num_progressivo=:ll_num_prog
//		//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
//		and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
//		and d.id_prof_documento=p.id_prof_documento
//		and year(data_documento)=:li_anno
//		;
//
//		if ll_id_bollettina>0 then
//			ls_test="id_documento="+string(ll_id_bollettina)
//			ll_id_test=dw_8.find(ls_test, 1, dw_1.rowcount())
//			if ll_id_test>0 then
//				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
//			else
//				dw_8.retrieve(ll_id_bollettina)
//	
//				dw_3.setitem(1, "cod_barre", "")
//				dw_3.setfocus()
//				dw_3.setcolumn("cod_barre")
//				
//				ll_righe=dw_2.retrieve(ll_id_bollettina)
//				wf_bilancia(dw_2.rowcount())
//				setcolumn("cod_barre_galvanica")
//			end if
//		else
//			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
//		end if
//	end if
//end if
//
//if dwo.name="cod_barre_galvanica"  then
//	if len(data)=13   then
//		ll_riga=dw_2.rowcount()
//		ls_galv=left(data, 12)
//		ls_galv=right(ls_galv, 5)
//		ll_id_galv=long(ls_galv)
//		ldt_data=dw_3.getitemdate(1, "doc_data")
//		ls_galv=""
//		select lavorazione, descrizione
//		into :ls_lav, :ls_galv
//		from dba.galvanica
//		where id_galvanica=:ll_id_galv
//		;
//		ldc_prezzo=f_rec_prezzo_galvanica(ldt_data, ll_id_galv)
////		ldt_data=dw_3.getitemdate(1, "doc_data")
////		if ldt_data> date("2000-01-01") then
////			if ldt_data>= date("2019-06-01") then
////				 ldc_prezzo=ldc_prezzo_da_Data1
////			end if
////		else
////			messagebox("Attenzione!", "Inserire Data Doc Destinazione!")
////		end if
//
//		dw_2.setitem(ll_riga, "prezzo_metallo",ldc_prezzo)
//		dw_2.setitem(ll_riga, "id_gruppo_agenti_2",ll_id_galv)
//		ls_test=dw_2.getitemstring(ll_riga, "descrizione")
//		if ls_test> " " then
//			ls_galv=ls_test+"  __ "+ls_galv
//		end if
//		dw_2.setitem(ll_riga, "descrizione", ls_galv)
//		dw_3.setitem(1, "cod_barre", "")
//		dw_3.setitem(1, "cod_barre_galvanica", "")
//		dw_8.setitem(1, "sog_commerciale_gen_codice", ls_lav)  //speriamo vada bene 1 ....
//		dw_3.setfocus()
//		dw_3.setcolumn("cod_barre")
//	end if
//	
//	
//end if
end event

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type cb_2 from commandbutton within w_reso_bucci
integer x = 4997
integer y = 20
integer width = 352
integer height = 192
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "ST.MAG"
end type

event clicked;open(w_mag_arianna_rpt)
end event

