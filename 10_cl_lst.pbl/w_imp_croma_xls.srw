forward
global type w_imp_croma_xls from w_001
end type
type dw_1 from udw_base within w_imp_croma_xls
end type
type dw_3 from udw_base within w_imp_croma_xls
end type
type cb_passa from commandbutton within w_imp_croma_xls
end type
type cb_1 from commandbutton within w_imp_croma_xls
end type
type dw_9 from udw_base within w_imp_croma_xls
end type
type dw_2 from udw_figlia within w_imp_croma_xls
end type
type cb_reset from commandbutton within w_imp_croma_xls
end type
type dw_4 from udw_base within w_imp_croma_xls
end type
type dw_6 from udw_base within w_imp_croma_xls
end type
type dw_5 from udw_base within w_imp_croma_xls
end type
type dw_7 from udw_base within w_imp_croma_xls
end type
type cb_xls from commandbutton within w_imp_croma_xls
end type
type dw_8 from udw_000 within w_imp_croma_xls
end type
type ole_1 from olecontrol within w_imp_croma_xls
end type
end forward

global type w_imp_croma_xls from w_001
string tag = "w_imp_croma_xls"
boolean visible = false
integer x = 1057
integer y = 483
integer width = 4677
integer height = 1880
string title = "Importa XLS Croma"
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
cb_reset cb_reset
dw_4 dw_4
dw_6 dw_6
dw_5 dw_5
dw_7 dw_7
cb_xls cb_xls
dw_8 dw_8
ole_1 ole_1
end type
global w_imp_croma_xls w_imp_croma_xls

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
integer li_anno
string is_ultima_colonna
end variables

forward prototypes
public function long wf_importa (integer ai_riga)
public subroutine wf_agg_fino_calo (decimal adc_legato, long al_riga_inserita)
public subroutine wf_storna_legato (decimal adc_peso_da_stornare)
public subroutine wf_ges_lacci_fili (string as_tipo, integer ai_num_lacci_fili)
public subroutine wf_bilancia (long al_riga_inserita, long al_id_bollettina_doc)
public subroutine wf_articolo (string as_cod_articolo, long al_riga_doc)
public function string wf_controlla_esistenza (string as_num_doc, long al_id_prof)
public function long wf_prepara_doc (long al_riga_doc, integer al_riga_xls)
public function long wf_agg_articoli (string as_cod_art, long al_id_titolo)
public function string wf_stampa_ean13 (date adt_data_doc, string as_num_bol)
end prototypes

public function long wf_importa (integer ai_riga);long ll_id_prof,  ll_id_locazione, ll_id_causale,  ll_id_magazzino, ll_id_mod_reg, ll_id_registro, ll_id_doc, ll_null, ll_num_prog
date ldt_data_odierna, ldt_data_doc
integer li_ret, i
string ls_tipo_registro, ls_numero, ls_nota, ls_id_doc
long ll_righe, ll_return, ll_num_prog_nuovo,ll_id_riga_doc_provenienza, ll_riga_doc_inserito

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

	//24052017  segno nel campo "origine" che è inserito in automatico da questo passaggio dati 24052017
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
			dw_2.SetItem(i, "id_riga_doc_provenienza", ll_id_riga_doc_provenienza)
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
		end if
	else
		messagebox("Attenzione!", "Doc NON salvato!!")
	end if
end if


return ll_return
	
	
	

end function

public subroutine wf_agg_fino_calo (decimal adc_legato, long al_riga_inserita);decimal ldc_coef_calo, ldc_titolo, ldc_calo, ldc_fino
long	 ll_id_articolo


ldc_coef_calo=dw_2.getitemdecimal(al_riga_inserita, "coef_calo")
ll_id_articolo=dw_2.getitemnumber(al_riga_inserita, "id_articolo")
select titolo
into :ldc_titolo
from orafo_titolo t, articolo a
where a.id_titolo=t.id_titolo
and a.id_articolo=:ll_id_articolo
;
ldc_fino=round(adc_legato*ldc_titolo/1000, 2)
ldc_calo=round(adc_legato*ldc_coef_calo/1000,2) - ldc_fino
dw_2.setitem(al_riga_inserita, "fino", ldc_fino)
dw_2.setitem(al_riga_inserita, "calo", ldc_calo)
end subroutine

public subroutine wf_storna_legato (decimal adc_peso_da_stornare);decimal ldc_legato

ldc_legato=dw_3.getitemdecimal(1, "legato")
if ldc_legato - adc_peso_da_stornare<=0 then
	//messagebox("Attenzione!" , "Peso minore di 0!!!") //commento perché blocca il lavoro... metto legato=0 e zitto 20220728
	ldc_legato=0
else
	ldc_legato -=adc_peso_da_stornare
end if
dw_3.setitem(1, "legato", ldc_legato)
dw_2.setitem(dw_2.rowcount(), "peso_netto", ldc_legato)

wf_agg_fino_calo(ldc_legato, dw_2.rowcount())

end subroutine

public subroutine wf_ges_lacci_fili (string as_tipo, integer ai_num_lacci_fili);date ldt_data_doc
decimal ldc_peso_lacci
	
ldt_data_doc=dw_3.getitemdate(1, "doc_data")

if ai_num_lacci_fili>0 then
	ldc_peso_lacci=f_rec_prezzo_laccio_filo_rame( as_tipo, ldt_data_doc)
	ldc_peso_lacci *=ai_num_lacci_fili
	if as_tipo='L' then
		dw_2.setitem(dw_2.rowcount(), "provv_imp_carea_2", ai_num_lacci_fili)
	else
		dw_2.setitem(dw_2.rowcount(), "provv_imp_agente_2", ai_num_lacci_fili)
	end if
	wf_storna_legato(ldc_peso_lacci)
end if
end subroutine

public subroutine wf_bilancia (long al_riga_inserita, long al_id_bollettina_doc);//DWObject my_dwo
//decimal ld_peso_netto,ldc_coef_calo, ldc_titolo, ldc_calo, ldc_fino
//long	ll_row, ll_id_articolo, ll_riga_trovata
//string ls_metallo,ls_test
//
//
//
//w_bilancia w_bil
//open(w_bil)
//
//ld_peso_netto=w_bil.f_rendi_peso()
//dw_3.setitem(1, "legato", ld_peso_netto)
//dw_2.setitem(al_riga_inserita, "peso_netto", ld_peso_netto)
//ls_test="id_documento="+string(al_id_bollettina_doc)
//ll_riga_trovata=dw_8.find(ls_test, 1, dw_1.rowcount())
//if ll_riga_trovata>0 then
//	dw_8.setitem(ll_riga_trovata, "peso_netto", ld_peso_netto)
//end if
//wf_agg_fino_calo(ld_peso_netto, al_riga_inserita)
//if ld_peso_netto=0 or isnull(ld_peso_netto) then 
//	dw_3.setfocus()
//	dw_3.setcolumn("cod_barre")
//end if
//close(w_bil)
end subroutine

public subroutine wf_articolo (string as_cod_articolo, long al_riga_doc);string ls_codice, ls_tipo_um, ls_confermato,ls_simbolo_um
long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_art_riga, ll_id_cat_cod
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc, ll_id_variazione
decimal ldc_prezzo
datetime ldt_datatime

setnull(ll_null)

ll_riga_trovata=dw_8.find("A03='"+as_cod_articolo+"'", 1, dw_8.rowcount())
if ll_riga_trovata>0 then
	ls_codice=dw_4.getitemstring(ll_riga_trovata, "codice")
	select a.id_articolo, u.id_unita_confezione
	into :ll_id_art_locale, :ll_id_uc
	from dba.articolo a, dba.unita_confezione u
	where a.codice=:ls_codice
	and u.unita_base='S'
	and a.id_articolo=u.id_articolo
	;
	if ll_id_art_locale>0 then //l'articolo esiste già non si deve fare nulla , quasi nulla
		dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
		dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
		
	else //l'articolo non esiste occorre inserirlo
		//se azienda =silverdreams non si caricano articoli nuovi.... 18-05-2021
//		if pos(ls_azienda, "SILVER DR")>0 then 
//			messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON PRESENTE NEL NOSTRO ARCHIVIO!")
//			return
//		end if
		dw_6.reset()
		dw_7.reset()
//		ll_riga_trovata_uc=dw_5.find("id_articolo="+string(al_id_articolo), 1, dw_5.rowcount())
		if ll_riga_trovata_uc>0 then
			
			dw_6.setitem(1, "id_articolo", ll_null)
			select id_cat_codifica into :ll_id_cat_cod from dba.cat_codifica where codice='AUTO';
			dw_6.setitem(1,"id_cat_codifica", ll_id_cat_cod)
			dw_6.setitem(1,"id_sog_comm_variante", ll_null)
			dw_6.setitemstatus(1, 0, Primary!, NewModified!)
			dw_6.trigger event ue_update()
			ll_id_art_locale=dw_6.getitemnumber(1, "id_articolo")
			dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
			ls_simbolo_um=dw_5.getitemstring(ll_riga_trovata_uc, "codice")
			select id_unita_misura into :ll_id_um from dba.unita_misura where simbolo=:ls_simbolo_um;
			if isnull(ll_id_um) or ll_id_um<=0 then messagebox("Attenzione!", "Per importare gli articoli occorre che esista una unità di misura con simbolo='"+ls_simbolo_um +"'!" )
				
			ll_riga_uc=dw_7.retrieve(ll_id_art_locale)
			if ll_riga_uc>0 then
				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
				dw_7.setitem(1, "id_unita_misura", ll_id_um)
				dw_7.trigger event ue_update()
			else
				dw_5.rowscopy(ll_riga_trovata_uc, ll_riga_trovata_uc, primary!, dw_7, 1, primary!)
				dw_7.SetItem(1,"id_unita_confezione", ll_null)
				dw_7.setitem(1, "id_articolo", ll_id_art_locale)
				dw_7.setitemstatus(1, 0, Primary!, NewModified!)
				dw_7.trigger event ue_update()	
				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
			end if
			
		else
//			messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON PRESENTE NEL FILE ART.txt")
		end if
	
	end if //
//	if pos(ls_azienda, "PANNA")>0 then
//		select simbolo into :ls_simbolo_um from dba.unita_misura u, unita_confezione uc
//		where uc.id_unita_misura=u.id_unita_misura and uc.id_unita_confezione=:ll_id_uc;
//		ll_id_variazione=	dw_1.getItemnumber(1, "id_variazione")
//		//ora inserisco l'articolo nel llistino del'intestatario del doc //prima verifico che non ci sia già e se il prezzo è confermato
//		select prezzo into :ldc_prezzo 
//		from dba.prezzo where id_unita_confezione=:ll_id_uc and id_variazione=:ll_id_variazione;
//		
//		if sqlca.sqlcode<>0 then //il record non esiste
//			ldt_datatime=datetime(today(), now())
//			if ls_simbolo_um='PZ' then //muove a pezzo altrimenti è peso (o cm ecc ma il prezzo allora è in manifattura)
//				ldc_prezzo=dw_2.getitemdecimal(al_riga_doc, "prezzo")
//				
//				insert into dba.prezzo (id_unita_confezione, id_variazione, prezzo, confermato, ultima_modifica)
//				values (:ll_id_uc, :ll_id_variazione, :ldc_prezzo, 'N', :ldt_datatime);
//				if sqlca.sqlcode=0 then
//					commit;
//				else
//					rollback;
//					messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON inserito in listino!")
//				end if
//			else
//				ldc_prezzo=dw_2.getitemdecimal(al_riga_doc, "prezzo_manifattura")
//				insert into dba.prezzo (id_unita_confezione, id_variazione, prezzo_manifattura, confermato, ultima_modifica)
//				values (:ll_id_uc, :ll_id_variazione, :ldc_prezzo, 'N',  :ldt_datatime);
//				if sqlca.sqlcode=0 then
//					commit;
//				else
//					rollback;
//					messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON inserito in listino!")
//				end if
//			end if
//	end if
end if

end subroutine

public function string wf_controlla_esistenza (string as_num_doc, long al_id_prof);string ls_return
long ll_num_prog, ll_id_doc_esistente
date ldt_data_doc
s_list_main s_list
w_orafo_documento_ordine_cx w_orafo

select num_progressivo, data_documento, id_documento into :ll_num_prog, :ldt_data_doc, :ll_id_doc_esistente
from dba.documento where id_prof_documento=:al_id_prof and num_documento=:as_num_doc;
if ll_num_prog>0 then
	ls_return="Doc. già inserito al num. prog. "+string(ll_num_prog)+" data doc.: "+string(ldt_data_doc, "dd/mm/yy"+ " Vuoi aprirlo?")
	if messagebox("Attenzione!", ls_return, stopsign!,yesno!)=1 then
		s_list.s_identifica[1]="id_documento"
		s_list.s_modo=modo_modifica
		s_list.l_identifica[1]=ll_id_doc_esistente
		openwithparm(w_orafo, s_list)
	end if
end if
return ls_return
end function

public function long wf_prepara_doc (long al_riga_doc, integer al_riga_xls);integer li_ret, i, li_righe
long     ll_null, ll_id_doc, ll_id_art
string    ls_num_doc, ls_tipo_registro,ls_nota="", ls_num_bol, ls_des,ls_num_bollettina,ls_cod_art,ls_ret, ls_data_scadenza
date  ldt_data_doc
long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_id_riga_provenienza,al_riga_doc_inserito,ll_new_riga_doc
long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre,ll_riga_trovata
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
setnull(ll_null)	
s_list_main s_list

	ldt_data_doc=dw_3.getitemdate(1, "doc_data")
	ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
	ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
	
	ls_num_bollettina=dw_8.getitemstring(al_riga_xls, "A11")
	if ls_num_bollettina> " " then
		//20230112 aggiungo per distinguere da karizia samy dice
		ls_num_bollettina="00"+ls_num_bollettina
		//20230112 fine
		ls_ret=wf_controlla_esistenza(ls_num_bollettina, ll_id_prof )
		if ls_ret> "  " then 
			return 0
		else
			dw_1.SetItem(al_riga_doc, "num_documento", ls_num_bollettina)
		end if
	else
		 messagebox("Attenzione!","Numero Bollettina NON trovato!!!")
		return 0
	end if
	ls_data_scadenza=dw_8.getitemstring(al_riga_xls, "A10") //data_scadenza 20230201
	dw_1.setitem(al_riga_doc, "data_prev_consegna", date(ls_data_scadenza))
	dw_1.setitem(al_riga_doc, "id_documento", ll_null)
	dw_1.setitem(al_riga_doc, "data_documento", ldt_data_doc)
	dw_1.setitem(al_riga_doc, "id_prof_documento", ll_id_prof)
	dw_1.setitem(al_riga_doc, "id_sog_commerciale", ll_id_sog)
	dw_1.setitem(al_riga_doc, "id_sog_commerciale_fattura", ll_id_sog)
	dw_1.setitem(al_riga_doc, "data_registrazione", ldt_data_doc)
	dw_1.setitem(al_riga_doc, "id_valuta", 3)  //euro
	//trovo il numprog

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
			
	dw_1.setitem(al_riga_doc, "id_registro", ll_id_registro)
	select tipo_registro
	into :ls_tipo_registro
	from dba.registro
	where id_registro=:ll_id_registro
	;
	
	IF  ll_id_registro > 0 THEN
		uo_proponi_num_progressivo=create u_setta_campi_documento
		ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_registro, 0, ls_tipo_registro)
		destroy uo_proponi_num_progressivo
		dw_1.SetItem(al_riga_doc, "num_progressivo", ls_trova_prog.sl_num_progressivo)
		
	end if	
	
	if  ls_trova_prog.sl_num_progressivo> 0 then
		return  ls_trova_prog.sl_num_progressivo
	else
		return 0
	end if
end function

public function long wf_agg_articoli (string as_cod_art, long al_id_titolo);string ls_codice, ls_tipo_um, ls_confermato,ls_simbolo_um
long ll_riga_trovata, ll_id_art,  ll_null, ll_id_art_riga, ll_id_cat_cod,ll_riga_inserita
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc, ll_id_variazione, ll_test
decimal ldc_prezzo
datetime ldt_datatime
integer li_ret

setnull(ll_null)

select id_articolo into :ll_id_art from dba.articolo where codice=:as_cod_art;
if isnull(ll_id_art) or ll_id_art<=0 then
 //l'articolo non esiste occorre inserirlo
		dw_6.reset()		
		ll_riga_inserita=dw_6.insertrow(0)
		dw_6.setitem(ll_riga_inserita, "id_articolo", ll_null)
		select id_cat_codifica into :ll_id_cat_cod from dba.cat_codifica where codice='CROM';
		dw_6.setitem(ll_riga_inserita,"id_cat_codifica", ll_id_cat_cod)
		dw_6.setitem(ll_riga_inserita,"codice", as_cod_art)
		dw_6.setitem(ll_riga_inserita,"id_sog_comm_variante", ll_null)
		dw_6.setitem(ll_riga_inserita,"id_titolo", al_id_titolo)
		dw_6.setitem(ll_riga_inserita,"id_cat_com_articolo", 25)
		dw_6.setitemstatus(ll_riga_inserita, 0, Primary!, NewModified!)
		li_ret=dw_6.trigger event ue_update()
		if li_ret<>1 then messagebox("Attenzione!", "Art. "+ string(as_cod_art)+" NON inserito!")
		ll_id_art=dw_6.getitemnumber(ll_riga_inserita, "id_articolo")
end if
return ll_id_art
end function

public function string wf_stampa_ean13 (date adt_data_doc, string as_num_bol);string ls_cod_barre, ls_fornitore, ls_stato
string  ls_codice_ok, ls_codice, ls_check
long ll_num_prog, ll_riga_inserita
//date ldt_data_doc

ls_stato='80'
//	
ls_fornitore="0"+RIGHT(string(year(adt_data_doc)), 2)
//	
	do while len(as_num_bol)<5 
		as_num_bol="0"+as_num_bol
	loop
//	
	ls_codice= ls_stato+ls_fornitore+as_num_bol
	ls_check=string(f_check_digit(ls_codice, 13))
	
	ls_codice+= ls_check
	ls_codice_ok=f_crea_codice_a_barre(ls_codice)
//	tab_1.tabpage_5.dw_6.modify('t_cod_barre.text="'+ls_codice_ok+'"')
//end if
return ls_codice_ok
end function

on w_imp_croma_xls.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_passa=create cb_passa
this.cb_1=create cb_1
this.dw_9=create dw_9
this.dw_2=create dw_2
this.cb_reset=create cb_reset
this.dw_4=create dw_4
this.dw_6=create dw_6
this.dw_5=create dw_5
this.dw_7=create dw_7
this.cb_xls=create cb_xls
this.dw_8=create dw_8
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_passa
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_9
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.cb_reset
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.dw_6
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.dw_7
this.Control[iCurrent+12]=this.cb_xls
this.Control[iCurrent+13]=this.dw_8
this.Control[iCurrent+14]=this.ole_1
end on

on w_imp_croma_xls.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_passa)
destroy(this.cb_1)
destroy(this.dw_9)
destroy(this.dw_2)
destroy(this.cb_reset)
destroy(this.dw_4)
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.dw_7)
destroy(this.cb_xls)
destroy(this.dw_8)
destroy(this.ole_1)
end on

event open;call super::open;s_list_main ls_list
long ll_id_prof

//dw_8.settransobject(sqlca)
dw_9.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.insertrow(1)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_7.settransobject(sqlca)
//dw_3.setitem(1, "da_data", relativedate(today(), - 30))





string ls_prof_id


//ls_list=message.powerobjectparm
//ll_id_prof=long(ls_list.s_win_parametri)
//if ll_id_prof>0 then dw_3.setitem(1, "id_prof_destinazione", ll_id_prof)
//if ll_id_prof=184 then
//	dw_3.setitem(1, "id_prof_destinazione", ll_id_prof)
//	dw_3.setitem(1, "id_sog_com", 2049)
//	cb_passa.text="A Burattare"
//	dw_3.modify("N_lacci.visible=1")
//	dw_3.modify("N_fili.visible=1")
//	dw_3.modify("t_lacci.visible=1")
//	dw_3.modify("t_fili.visible=1")
//elseif ll_id_prof=196 then
//	dw_3.setitem(1, "id_sog_com", 2110)
//	cb_passa.text="A Laserare"
//end if

dw_3.setitem(1, "id_sog_com", 257)  //è la CROMA CATENE CLIENTE
dw_3.setitem(1, "id_prof_destinazione", 202)  //BOLCROMA
setfocus(cb_xls)
end event

type st_1 from w_001`st_1 within w_imp_croma_xls
end type

type dw_1 from udw_base within w_imp_croma_xls
boolean visible = false
integer x = 1179
integer y = 1772
integer width = 2555
integer height = 288
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

type dw_3 from udw_base within w_imp_croma_xls
integer x = 55
integer y = 28
integer width = 1710
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_imp_croma_dati_fissi"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;//
//string ls_num_doc, ls_num_bollettina, ls_test,ls_galv,ls_lav
//long ll_num_prog, ll_id_bollettina, ll_id_test, ll_righe, ll_id_doc,ll_riga,ll_id_galv, ll_null
//decimal ldc_prezzo, ldc_prezzo_da_Data1
//date ldt_data
//
//setnull(ll_null)
//if dwo.name="cod_barre"  then
//	if len(data)=7   then
//		dw_3.setitem(1, "n_lacci", ll_null)
//		dw_3.setitem(1, "n_fili", ll_null)
//		dw_3.setitem(1, "legato", ll_null)
//		//da cambiare subito!!!
//		if rb_2021.checked then
//			li_anno=2021
//		elseif	rb_2022.checked then
//			li_anno=2022
//		elseif	rb_2020.checked then
//			li_anno=2020
//		elseif rb_2019.checked then
//			li_anno=2019
//		elseif rb_2018.checked then
//			li_anno=2018
//		end if
//			
//		if li_anno=2022 then
//			ls_num_doc=data
//			ll_num_prog=long(ls_num_doc)
//			select id_documento, num_documento
//			into :ll_id_bollettina, :ls_num_bollettina
//			from dba.documento d, dba.prof_documento p
//			where right(num_documento, 7)=:ls_num_doc
//			and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
//			and d.id_prof_documento=p.id_prof_documento
//			;
//		else
//			ls_num_doc=mid(data, 3, 5)
//			ll_num_prog=long(ls_num_doc)
//			select id_documento, num_documento
//			into :ll_id_bollettina, :ls_num_bollettina
//			from dba.documento d, dba.prof_documento p
//			where right(num_documento, 5)=:ls_num_doc
//			//where num_progressivo=:ll_num_prog
//			//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
//			and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
//			and d.id_prof_documento=p.id_prof_documento
//			and year(data_documento)=:li_anno
//			;
//		end if
//
//		if ll_id_bollettina>0 then
//			ls_test="id_documento="+string(ll_id_bollettina)
//			ll_id_test=dw_8.find(ls_test, 1, dw_1.rowcount())
//			if ll_id_test>0 then
//				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
//			else
//				dw_8.retrieve(ll_id_bollettina)
//				dw_3.setitem(1, "cod_barre", "")
//				dw_3.setfocus()
//				dw_3.setcolumn("cod_barre")
//				
//				ll_righe=dw_2.retrieve(ll_id_bollettina)
//				wf_bilancia(dw_2.rowcount(), ll_id_bollettina)
//				if cb_passa.text="Manda in Galv" then
//					setcolumn("cod_barre_galvanica")
//				else
//					if getitemdecimal(row,"legato")> 0 then
//						post setcolumn("n_lacci")
//					else
//						post setcolumn("cod_barre")
//					end if
//				end if
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

event itemchanged;call super::itemchanged;date ldt_data_doc
integer  li_num_lacci_fili
decimal ldc_peso_netto

choose case dwo.name
	case "n_lacci"
		li_num_lacci_fili= integer(data)
		if li_num_lacci_fili>0 then
			wf_ges_lacci_fili("L", li_num_lacci_fili)
		end if
		post setcolumn("n_fili")
	case "n_fili"
		li_num_lacci_fili= integer(data)
		if li_num_lacci_fili>0 then
			wf_ges_lacci_fili("F", li_num_lacci_fili)
		end if
		post setfocus()
		post setcolumn("cod_barre")
	case "legato"
		ldc_peso_netto=dec(data)
		if ldc_peso_netto> 0 then
			dw_3.setitem(1, "legato", ldc_peso_netto)
			dw_2.setitem( dw_2.rowcount(), "peso_netto", ldc_peso_netto)
			wf_agg_fino_calo(ldc_peso_netto, dw_2.rowcount())
			post setfocus()
			post setcolumn("n_lacci")
		end if
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;

if string(dwo.name)="ultima" then 
	setfocus()
	setcolumn("cod_barre")
end if
end event

type cb_passa from commandbutton within w_imp_croma_xls
integer x = 3086
integer y = 1564
integer width = 471
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Importa"
end type

event clicked;integer li_ret, i, li_righe
long     ll_null,ll_riga_doc, ll_id_doc, ll_id_art,ll_num_prog, ll_id_tit, ll_id_galv
string    ls_num_doc, ls_nota="",  ls_des,ls_cod_art, lds_legato, ls_pezzi, ls_met, ls_num_bollettina,ls_lunghezza, ls_cod_barre,  ls_data_scadenza
date  ldt_data_doc, ldt_data_scadenza
long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_id_riga_provenienza,ll_riga_doc_inserito,ll_new_riga_doc
long ll_riga_trovata, ll_pezzi
string ls_galvanica
setnull(ll_null)
decimal  ldc_legato, ldc_titolo, ldc_lunghezza

	

for i=2 to dw_8.rowcount()
	dw_1.reset()
	dw_2.reset()
	ll_riga_doc=dw_1.insertrow(0)
  	ll_num_prog=wf_prepara_doc(ll_riga_doc, i)
	if ll_num_prog=0 then
		return
	end if
	ls_num_bollettina=dw_8.getitemstring(i, "A11")
	//20230112 aggiungo per distinguere da karizia samy dice
	ls_num_bollettina="00"+ls_num_bollettina
	//20230112 fine
	ls_nota="Doc. Clienti IMP. in Automatico"
	ldt_data_doc=dw_3.getitemdate(1, "doc_data")
	dw_1.setitem(ll_riga_doc, "note_intestazione", ls_nota)
	ls_data_scadenza=dw_8.getitemstring(i, "A10") //data_scadenza 20230201
	
	//20220322 agg. la dataora creazione aggiornata
	dw_1.setitem(ll_riga_doc, "data_ora_creazione", today())
	dw_1.setitemstatus(ll_riga_doc, 0, primary!, newmodified!)
	li_ret=dw_1.trigger event ue_update()
	ll_id_doc_inserito=dw_1.getitemnumber(ll_riga_doc, "id_documento")
		ll_riga_doc_inserito=dw_2.insertrow(0)
		dw_2.setitem(ll_riga_doc_inserito, "id_valuta", 3)
		dw_2.setitem(ll_riga_doc_inserito, "id_documento", ll_id_doc_inserito)
		//ll_num_riga=dw_8.GETITEmstring(i, "A02")
		dw_2.setitem(ll_riga_doc_inserito, "num_riga", i)
		//ll_riga_madre=dw_2.getitemnumber(i, "id_riga_documento")
		//dw_2.setitem(i, "provv_imp_subage_2", ll_riga_madre)  //questo è il legame con la bollettina (non posso usare id_riga_doc_provenienza altrimenti lo segna evaso...)
		dw_2.setitem(ll_riga_doc_inserito, "id_riga_documento", ll_null)
		//devo calcolare anche il totale riga ...
		
		lds_legato=dw_8.getitemstring(i, "A08")
		lds_legato=f_sostituisci_carattere(lds_legato, ".", ",")
		ldc_legato=dec(lds_legato) //peso netto
		if isnull(ldc_legato) or ldc_legato<0 then ldc_legato=0  //controllo anche che il legato sia >=0 20220728
		dw_2.setitem(ll_riga_doc_inserito, "peso_netto", ldc_legato)
		ls_des=dw_8.getitemstring(i, "A04")
		dw_2.setitem(ll_riga_doc_inserito, "descrizione", ls_des)
		ls_cod_art=dw_8.getitemstring(i, "A03")
		ls_cod_art=trim(ls_cod_art)
		//20220913 inserire anche scelta metallo e titolo...
		ls_met=dw_8.getitemstring(i, "A05")
		ldc_titolo=dec(dw_8.getitemstring(i, "A06"))
		select id_titolo into :ll_id_tit from dba.orafo_titolo t, orafo_metallo m
		where t.id_metallo=m.id_metallo and m.codice=:ls_met and t.titolo=:ldc_titolo;
		if ll_id_tit<= 0 or isnull(ll_id_tit) then
			messagebox("Attenzione!", "Titolo NON trovato per articolo:"+ ls_cod_art+" Metto titolo AG925")
			ll_id_tit=4
		end if
		ll_id_art=wf_agg_articoli(ls_cod_art, ll_id_tit)
		if ll_id_art<=0 or isnull(ll_id_art) then
			messagebox("Attenzione!", "Articolo:"+ ls_cod_art+" NON creato")
			continue
		end if
		dw_2.setitem(ll_riga_doc_inserito, "id_articolo", ll_id_art)
		dw_2.setitem(ll_riga_doc_inserito, "coef_calo", 925)  //per ora, poi si capirà come fare
		ls_pezzi=dw_8.getitemstring(i, "A07")
		ls_pezzi=f_sostituisci_carattere(ls_pezzi, ".", ",")
		ll_pezzi=long(ls_pezzi)
		dw_2.setitem(ll_riga_doc_inserito, "quantita", ll_pezzi)
		//20221219 la croma è sparita, lo applichiamo ad altri clienti, serve anche la lunghezza campo A12
		ls_lunghezza=dw_8.getitemstring(i, "A12")	
		ldc_lunghezza=dec(ls_lunghezza)
		dw_2.setitem(ll_riga_doc_inserito, "dim_l", ldc_lunghezza)
		//fine 2021219
		//20230201 galvanica...
		ls_galvanica=dw_8.getitemstring(i, "A13")
		select id_galvanica into :ll_id_galv from dba.galvanica where lavorazione=:ls_galvanica;
		dw_2.setitem(ll_riga_doc_inserito, "id_gruppo_agenti_2", ll_id_galv)
		//20230201 fine
		dw_2.setitemstatus(ll_riga_doc_inserito, 0, primary!, newmodified!)
		li_ret=dw_2.trigger event ue_update()  //20220725
		if li_ret=1 then 
			dw_8.deleterow(i)
			i --
		end if
		ll_riga_doc_inserito=dw_9.insertrow(0)
//		dw_9.setitem(ll_riga_doc_inserito, "id_riga_bollettina",ll_riga_madre)
		dw_9.setitem(ll_riga_doc_inserito, "id_documento",ll_id_doc_inserito)
		ls_cod_barre=wf_stampa_ean13(ldt_data_doc, ls_num_bollettina)
		dw_9.setitem(ll_riga_doc_inserito, "c_codbarre", ls_cod_barre)
		dw_9.setitem(ll_riga_doc_inserito, "dim_l", ldc_lunghezza)
		dw_9.setitem(ll_riga_doc_inserito, "data_prev_consegna", date(ls_data_scadenza))
		dw_9.setitem(ll_riga_doc_inserito, "quantita", ll_pezzi)
		dw_9.setitem(ll_riga_doc_inserito, "galvanica",ls_galvanica )
		dw_9.setitem(ll_riga_doc_inserito, "riga_documento_descrizione", ls_des)
		dw_9.setitem(ll_riga_doc_inserito, "num_documento",	string(ll_num_prog))
		dw_9.setitem(ll_riga_doc_inserito, "num_bollettina",	ls_num_bollettina)
		dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_doc)
		dw_9.setitem(ll_riga_doc_inserito, "num_riga", ll_riga_doc_inserito)
		
		
	next
	
	dw_9.sort()
	dw_9.groupcalc()
	
	//f_pdf_doc_fo(ll_id_doc_inserito, "d_pdf_doc_fo_doc", "")
	//f_pdf_doc_fo(ll_id_doc_inserito, "d_pdf_doc_fo_doc", "articolo_id_articolo")
	
	
//	dw_1.reset()
//	dw_2.reset()
	
//END IF

end event

type cb_1 from commandbutton within w_imp_croma_xls
integer x = 3598
integer y = 1564
integer width = 471
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

type dw_9 from udw_base within w_imp_croma_xls
integer x = 1783
integer y = 28
integer width = 2793
integer height = 1520
integer taborder = 20
string dataobject = "d_bol_galv_buratto2"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if dwo.name="num_riga" then
	if row<=0  then return
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	ll_id_doc=getitemnumber(row, "id_documento")
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
end if
end event

type dw_2 from udw_figlia within w_imp_croma_xls
boolean visible = false
integer x = 1179
integer y = 2076
integer width = 2555
integer height = 292
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
boolean livescroll = false
end type

event retrievestart;call super::retrievestart;return 2
end event

type cb_reset from commandbutton within w_imp_croma_xls
integer x = 4096
integer y = 1564
integer width = 471
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "RESET"
end type

event clicked;
if messagebox("Attenzione!", "Vuoi davvero pulire le finestre per fare un altro DDT?", stopsign!, yesno!)= 1 then
	dw_1.reset()
	dw_2.reset()
	dw_9.reset()
	dw_8.reset()
end if
end event

type dw_4 from udw_base within w_imp_croma_xls
boolean visible = false
integer x = 50
integer y = 1640
integer width = 1445
integer height = 532
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type dw_6 from udw_base within w_imp_croma_xls
boolean visible = false
integer x = 169
integer y = 2260
integer width = 1221
integer height = 280
integer taborder = 40
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type dw_5 from udw_base within w_imp_croma_xls
boolean visible = false
integer x = 1673
integer y = 1720
integer width = 1042
integer height = 316
integer taborder = 40
boolean bringtotop = true
string dataobject = "ds_unita_confezione_2016"
boolean hscrollbar = true
end type

type dw_7 from udw_base within w_imp_croma_xls
boolean visible = false
integer x = 1678
integer y = 2088
integer width = 992
integer height = 448
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_unita_confezione_2016"
boolean hscrollbar = true
end type

type cb_xls from commandbutton within w_imp_croma_xls
integer x = 2587
integer y = 1564
integer width = 471
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica XLS"
end type

event clicked;integer li_ret
string ls_path, ls_file, ls_name, ls_path_ini
long ll_rigains, ll_max

ls_path_ini="c:\nita\croma"
getfileopenname("Cerca file excel", ls_path, ls_name, "xls", "*.xls", ls_path_ini)
if  not(trim(ls_name)="" or isnull(ls_name)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+".txt"
	if fileexists(ls_file) then filedelete(ls_file)
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_8.reset()
	dw_8.importfile(Text!,ls_file)
	//parent.height=2450
	ole_1.object.close(False)
end if	 
end event

type dw_8 from udw_000 within w_imp_croma_xls
integer y = 252
integer width = 1769
integer height = 1296
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_imp_file_croma"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type ole_1 from olecontrol within w_imp_croma_xls
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
boolean visible = false
integer x = 4215
integer y = 1724
integer width = 288
integer height = 188
integer taborder = 20
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_imp_croma_xls.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

