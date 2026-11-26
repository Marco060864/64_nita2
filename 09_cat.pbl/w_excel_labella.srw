forward
global type w_excel_labella from w_001
end type
type dw_1 from udw_base within w_excel_labella
end type
type dw_3 from udw_base within w_excel_labella
end type
type cb_passa from commandbutton within w_excel_labella
end type
type cb_stampa from commandbutton within w_excel_labella
end type
type dw_2 from udw_figlia within w_excel_labella
end type
type cb_reset from commandbutton within w_excel_labella
end type
type dw_4 from udw_base within w_excel_labella
end type
type dw_6 from udw_base within w_excel_labella
end type
type dw_5 from udw_base within w_excel_labella
end type
type dw_7 from udw_base within w_excel_labella
end type
type cb_xls from commandbutton within w_excel_labella
end type
type dw_8 from udw_000 within w_excel_labella
end type
type ole_1 from olecontrol within w_excel_labella
end type
end forward

global type w_excel_labella from w_001
boolean visible = false
integer width = 4677
integer height = 2576
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_3 dw_3
cb_passa cb_passa
cb_stampa cb_stampa
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
global w_excel_labella w_excel_labella

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
integer li_anno
string is_ultima_colonna
//20260922 metallo: lo decide la cella B3 di OGNI file caricato ("BRASS" = ottone OT, altrimenti argento AG).
//20260928 si possono caricare piu' file insieme, anche di metalli diversi: il metallo non e' piu'
//         della finestra ma della singola riga.
string is_met_file[]    //metallo di ogni file caricato, nell'ordine di caricamento
long   il_righe_file[]  //quante righe buone (con il numero in A01) ha portato ogni file
string is_met_riga[]    //metallo riga per riga di dw_8, ricostruito dopo la pulizia delle intestazioni
string is_cod_metallo="AG"  //solo per l'etichetta della finestra: "AG", "OT" o "MISTO"
s_orafo_partite us_dati_partita

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
public function string wf_stampa_ean13 (date adt_data_doc, string as_num_bol)
public function long wf_agg_articoli (string as_cod_art, long al_id_titolo, string as_pz_gr)
public function integer wf_apri_partita (long al_riga_che_scarica, long al_id_sog, long al_id_titolo, decimal adc_fino_da_scaricare, long al_id_doc_inserito)
public function integer wf_scarica_partite (long al_id_riga_doc, long al_id_sog, long al_id_tit, decimal adc_fino, string as_doc_da_scaricare, long al_id_doc_inserito)
public function integer wf_carica_datastore (long al_id_sog)
public function integer wf_salva_ds_partite ()
public function integer wf_controlla_gia_importate (long al_id_sog, long al_id_prof, long al_id_tit_ag, long al_id_tit_ot)
public function boolean wf_riga_vuota (long al_riga)
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
string     ls_tipo_registro,ls_nota="", ls_num_bol, ls_des,ls_num_documento,ls_cod_art,ls_ret, ls_data_scadenza
date  ldt_data_doc
long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_id_riga_provenienza,al_riga_doc_inserito,ll_new_riga_doc
long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre,ll_riga_trovata
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
setnull(ll_null)	
s_list_main s_list
	dw_3.accepttext()
	ldt_data_doc=dw_3.getitemdate(1, "doc_data")
	ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
	//

	ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
	
//	ls_num_documento=dw_3.getitemstring(1, "num_documento")
//	if ls_num_documento> " " then
//		ls_ret=wf_controlla_esistenza(ls_num_documento, ll_id_prof )
//		if ls_ret> "  " then 
//			return 0
//		else
//			dw_1.SetItem(al_riga_doc, "num_documento", ls_num_documento)
//		end if
//	else
//		 messagebox("Attenzione!","Numero doc NON trovato!!!")
//		return 0
//	end if

	dw_1.setitem(al_riga_doc, "id_documento", ll_null)
	dw_1.setitem(al_riga_doc, "data_documento", ldt_data_doc)
	dw_1.setitem(al_riga_doc, "id_prof_documento", ll_id_prof)
	dw_1.setitem(al_riga_doc, "id_sog_commerciale", ll_id_sog)
	dw_1.setitem(al_riga_doc, "id_sog_commerciale_fattura", ll_id_sog)
	dw_1.setitem(al_riga_doc, "data_registrazione", ldt_data_doc)
	dw_1.setitem(al_riga_doc, "id_valuta", 3)  //euro
	ls_nota="Doc. IMP. in Automatico "+string(today(), "dd/mm/yy hh:mm")
	dw_1.setitem(al_riga_doc, "note_intestazione", ls_nota)
	//20220322 agg. la dataora creazione aggiornata
	dw_1.setitem(al_riga_doc, "data_ora_creazione", today())
	
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
		dw_1.SetItem(al_riga_doc, "num_documento", string(ls_trova_prog.sl_num_progressivo))
		
	end if	
	
	if  ls_trova_prog.sl_num_progressivo> 0 then
		return  ls_trova_prog.sl_num_progressivo
	else
		return 0
	end if
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

public function long wf_agg_articoli (string as_cod_art, long al_id_titolo, string as_pz_gr);string ls_codice, ls_tipo_um, ls_confermato,ls_simbolo_um
long ll_riga_trovata, ll_id_art,  ll_null, ll_id_art_riga, ll_id_cat_cod,ll_riga_inserita
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc, ll_id_variazione, ll_test
string ls_cod_nuovo, ls_met_art
decimal ldc_prezzo
datetime ldt_datatime
integer li_ret

setnull(ll_null)

//20260928 il codice del metallo lo ricavo dal titolo che mi passa la riga: con piu' file caricati
//         insieme il metallo cambia da riga a riga, non e' piu' uno solo per tutta la finestra.
ls_met_art=""
select m.codice into :ls_met_art from dba.orafo_titolo t, dba.orafo_metallo m
where t.id_metallo=m.id_metallo and t.id_titolo=:al_id_titolo;
if isnull(ls_met_art) then ls_met_art=""
ls_met_art=trim(ls_met_art)
if ls_met_art="" then ls_met_art="AG"

//20260922 il titolo e' una proprieta' fondamentale dell'articolo: se cambia il titolo cambia
//         l'articolo. Un articolo in AG NON si puo' usare su un documento in OT e viceversa,
//         percio' cerco per codice E titolo, non piu' per solo codice.
ls_cod_nuovo=as_cod_art
ll_id_art=0
select id_articolo into :ll_id_art from dba.articolo where codice=:ls_cod_nuovo and id_titolo=:al_id_titolo;
if isnull(ll_id_art) or ll_id_art<=0 then
	//20260922 lo stesso codice esiste gia' ma con un ALTRO titolo? Il codice articolo e' univoco:
	//         non posso usarlo (sarebbe il metallo sbagliato) ne' crearne un secondo uguale,
	//         quindi l'articolo dell'altro metallo lo creo con codice + "_" + metallo (es. 7970_OT).
	ll_test=0
	select id_articolo into :ll_test from dba.articolo where codice=:ls_cod_nuovo;
	if ll_test>0 then
		ls_cod_nuovo=as_cod_art+"_"+ls_met_art
		ll_id_art=0
		select id_articolo into :ll_id_art from dba.articolo where codice=:ls_cod_nuovo and id_titolo=:al_id_titolo;
		if ll_id_art>0 then return ll_id_art   //l'aveva gia' creato un import precedente
		ll_test=0
		select id_articolo into :ll_test from dba.articolo where codice=:ls_cod_nuovo;
		if ll_test>0 then
			messagebox("Attenzione!", "Il codice "+ls_cod_nuovo+" esiste gia' in archivio con un titolo diverso da quello di questo documento!~r~nArticolo NON creato.")
			return 0
		end if
	end if
 //l'articolo non esiste occorre inserirlo
		dw_6.reset()		
		ll_riga_inserita=dw_6.insertrow(0)
		dw_6.setitem(ll_riga_inserita, "id_articolo", ll_null)
		//select id_cat_codifica into :ll_id_cat_cod from dba.cat_codifica where codice='CROM';
		ll_id_cat_cod=5
		dw_6.setitem(ll_riga_inserita,"id_cat_codifica", ll_id_cat_cod)
		dw_6.setitem(ll_riga_inserita,"codice", ls_cod_nuovo)
		//20260922 il metallo non e' piu' fisso: AG oppure OT
		dw_6.setitem(ll_riga_inserita,"descrizione", "Semilavorati in "+ls_met_art+" ")
		dw_6.setitem(ll_riga_inserita,"id_sog_comm_variante", ll_null)
		dw_6.setitem(ll_riga_inserita,"id_titolo", al_id_titolo)
		dw_6.setitem(ll_riga_inserita,"id_cat_com_articolo", 8)
		if as_pz_gr="PZ" then
			dw_6.setitem(ll_riga_inserita,"id_unita_conf_base", 3)
		else
			dw_6.setitem(ll_riga_inserita,"id_unita_conf_base", 2)			
		end if
		dw_6.setitemstatus(ll_riga_inserita, 0, Primary!, NewModified!)
		li_ret=dw_6.trigger event ue_update()
		if li_ret<>1 then messagebox("Attenzione!", "Art. "+ string(ls_cod_nuovo)+" NON inserito!")
		ll_id_art=dw_6.getitemnumber(ll_riga_inserita, "id_articolo")
		
		
end if
return ll_id_art
end function

public function integer wf_apri_partita (long al_riga_che_scarica, long al_id_sog, long al_id_titolo, decimal adc_fino_da_scaricare, long al_id_doc_inserito);string ls_cod_partita
integer li_num_righe, li_ret, i
long ll_id_partita, ll_riga_trovata, ll_id_caus_mag
decimal{2} ld_val_scarico, ld_fino, pippo, ad_peso, ld_peso
decimal ldc_titolo_part

ll_id_partita=al_riga_che_scarica
if ll_id_partita>0 then 
	ll_id_partita=0
else
	return 10
end if
//trovo tipo partita
ls_cod_partita="SCLC"
if ls_cod_partita="" or isnull(ls_cod_partita) then return 10
//devo cercare i carichi (iniziano con "A") per questo tipo partita
us_dati_partita.s_tipo_partita="A"+mid(ls_cod_partita, 2,3)
ls_cod_partita=mid(ls_cod_partita, 1, 1)
//se si tratta di uno scarico ...
if ls_cod_partita='S' then
	//Prendo il titolo (salvo diversa indicazione si scarica titolo con titolo
	us_dati_partita.s_ll_id_titolo=al_id_titolo
	//se non c'è titolo chiudo qui	
	if isnull(us_dati_partita.s_ll_id_titolo) then return 0
	//se nonesiste ancora carico la dw delle aperture	
	if not isvalid(us_dati_partita.s_dw_aper_partita) then
		li_ret=wf_carica_datastore(al_id_sog)
		if li_ret=0 then return 10
	end if
	//carico dati utili per finestra partita	
	us_dati_partita.s_id_documento=al_id_doc_inserito
	us_dati_partita.s_ll_id_sog_com=al_id_sog
	us_dati_partita.s_ll_id_riga_partita=al_riga_che_scarica
	
	//20260922 il fattore fino->legato dipende dal titolo (AG 925, OT 1000): non e' piu' fisso
	ldc_titolo_part=0
	select titolo into :ldc_titolo_part from dba.orafo_titolo where id_titolo=:al_id_titolo;
	if isnull(ldc_titolo_part) or ldc_titolo_part<=0 then ldc_titolo_part=925
	us_dati_partita.s_ld_quantita_legato=adc_fino_da_scaricare*1000/ldc_titolo_part
	us_dati_partita.s_ld_quantita_da_scaricare=adc_fino_da_scaricare
	
		
	
	us_dati_partita.s_scarica_ogni_titolo='N'
	
	OpenWithParm(w_orafo_partite_aperte_gd, us_dati_partita)
	us_dati_partita = Message.PowerObjectParm
	ad_peso=adc_fino_da_scaricare*1000/ldc_titolo_part
	
		//riporto nella riga doc il peso corretto gestito in partita
		if ad_peso=0 then 
			ld_peso=us_dati_partita.s_ld_quantita_legato
		else
			ld_peso=ad_peso
		end if
		//wf_setta_fino_calo(row, ld_peso, us_dati_partita.s_ld_coef_calo)
		if ad_peso <> us_dati_partita.s_ld_quantita_legato then  //devo riportarlo sulla riga creata, ma non dovrebbe essere possibile... 20231016
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_post_itemch_cond(row, "riga_documento_peso_netto", us_dati_partita.s_ld_quantita_legato )
//			ad_peso=	us_dati_partita.s_ld_quantita_legato 
		end if
		
	
else
	return 10
end if
return ld_peso








end function

public function integer wf_scarica_partite (long al_id_riga_doc, long al_id_sog, long al_id_tit, decimal adc_fino, string as_doc_da_scaricare, long al_id_doc_inserito);long ll_id_doc_da_scaricare, ll_id_partita_da_scaricare, ll_tipo_partita
string ls_stato
decimal ldc_fino_partita, ldc_new_val_scarico, ldc_val_scarico
integer li_ret
long ll_n_doc, ll_n_cand, ll_n_altri  //20261017
string ls_num_b                       //20261017 pomeriggio: numero con /b
string ls_num_b_sql                   //20261017 pomeriggio: idem, mai vuoto nelle select

//20261017 prima cercava la proforma SOLO per num_documento: con due documenti con lo stesso numero
//         (anni diversi, altri clienti, altri profili) la select restituiva piu' righe, andava in
//         errore e la riga restava NON scaricata. Ora la proforma da scaricare deve essere:
//           - dello stesso cliente del documento importato (id_sog_commerciale o _fattura)
//           - con una partita APERTA (stato 'A') del tipo 8 e del titolo della riga
//             (e' questo che la distingue da documenti di altri profili e da quelle gia' chiuse)
//         Niente filtro rigido sull'anno: una proforma dell'anno prima puo' essere ancora aperta.
//         Se ce n'e' piu' di una aperta con lo stesso numero prendo la piu' recente e avviso.
ll_tipo_partita=8
as_doc_da_scaricare=trim(as_doc_da_scaricare)

//20261017 pomeriggio - PROFORMA CON /b (fase di passaggio)
//         Le proforma vecchie hanno l'ottone su un documento a parte con il numero + "/b"
//         (es. 901264/b), ma nel file Binder c'e' il numero senza /b (901264).
//         Cerco PRIMA il numero esatto; se li' non c'e' una partita aperta del titolo della riga,
//         cerco anche il numero + "/b" (maiuscolo o minuscolo). Se il file ha gia' il /b non
//         aggiungo niente. Le proforma nuove (AG e OT sulla stessa, senza /b) non cambiano.
if lower(right(as_doc_da_scaricare, 2))="/b" then
	ls_num_b=""
else
	ls_num_b=lower(as_doc_da_scaricare+"/b")
end if
//nelle select non passo mai una stringa vuota: troverebbe i documenti senza numero
ls_num_b_sql=ls_num_b
if ls_num_b_sql="" then ls_num_b_sql="#nessun numero /b#"

//quanti documenti con questo numero ha il cliente (aperti o no)
ll_n_doc=0
select count(*) into :ll_n_doc from dba.documento d
where (trim(d.num_documento)=:as_doc_da_scaricare or lower(trim(d.num_documento))=:ls_num_b_sql)
and (d.id_sog_commerciale=:al_id_sog or d.id_sog_commerciale_fattura=:al_id_sog);
if isnull(ll_n_doc) then ll_n_doc=0

if ll_n_doc=0 then
	//c'e' con questo numero ma di un altro cliente?
	ll_n_altri=0
	select count(*) into :ll_n_altri from dba.documento d where trim(d.num_documento)=:as_doc_da_scaricare;
	if isnull(ll_n_altri) then ll_n_altri=0
	if ll_n_altri>0 then
		messagebox("Attenzione!", "Partita da scaricare n. "+as_doc_da_scaricare+" NON trovata per questo cliente!~r~n"+&
		           "(ci sono "+string(ll_n_altri)+" documenti con questo numero, ma di altri clienti)~r~nRiga NON scaricata.")
	else
		messagebox("Attenzione!", "Partita da scaricare n. "+as_doc_da_scaricare+" NON trovata!")
	end if
	return 0
end if

//proforma del cliente con una partita aperta del titolo richiesto: la piu' recente
ll_n_cand=0
ll_id_doc_da_scaricare=0
select count(*), max(d.id_documento) into :ll_n_cand, :ll_id_doc_da_scaricare
from dba.documento d
where trim(d.num_documento)=:as_doc_da_scaricare
and (d.id_sog_commerciale=:al_id_sog or d.id_sog_commerciale_fattura=:al_id_sog)
and exists(select 1 from dba.orafo_aper_partita a where a.id_documento=d.id_documento
           and a.id_titolo=:al_id_tit and a.id_tipo_partita=:ll_tipo_partita and a.stato='A');
if sqlca.sqlcode<0 then
	messagebox("Attenzione!", "Errore nella ricerca della proforma n. "+as_doc_da_scaricare+":~r~n"+sqlca.sqlerrtext+"~r~nRiga NON scaricata.")
	return 0
end if
if isnull(ll_n_cand) then ll_n_cand=0

//20261017 pomeriggio nessuna partita aperta sul numero esatto: provo il numero + "/b"
if (ll_n_cand=0 or isnull(ll_id_doc_da_scaricare) or ll_id_doc_da_scaricare<=0) and ls_num_b<>"" then
	ll_n_cand=0
	ll_id_doc_da_scaricare=0
	select count(*), max(d.id_documento) into :ll_n_cand, :ll_id_doc_da_scaricare
	from dba.documento d
	where lower(trim(d.num_documento))=:ls_num_b
	and (d.id_sog_commerciale=:al_id_sog or d.id_sog_commerciale_fattura=:al_id_sog)
	and exists(select 1 from dba.orafo_aper_partita a where a.id_documento=d.id_documento
	           and a.id_titolo=:al_id_tit and a.id_tipo_partita=:ll_tipo_partita and a.stato='A');
	if sqlca.sqlcode<0 then
		messagebox("Attenzione!", "Errore nella ricerca della proforma n. "+as_doc_da_scaricare+"/b:~r~n"+sqlca.sqlerrtext+"~r~nRiga NON scaricata.")
		return 0
	end if
	if isnull(ll_n_cand) then ll_n_cand=0
	//trovata: da qui in avanti i messaggi parlano della /b
	if ll_n_cand>0 and ll_id_doc_da_scaricare>0 then as_doc_da_scaricare=as_doc_da_scaricare+"/b"
end if

//20260922 se sul carico non c'e' una partita aperta di QUESTO titolo non scarico niente:
//         e' il filtro sul titolo che tiene separato lo scarico dell'ottone da quello dell'argento
if ll_n_cand=0 or isnull(ll_id_doc_da_scaricare) or ll_id_doc_da_scaricare<=0 then
	if ls_num_b<>"" then
		messagebox("Attenzione!", "Sul doc. di carico n. "+as_doc_da_scaricare+" (e nemmeno sul "+as_doc_da_scaricare+"/b) NON c'e' una partita aperta con il titolo richiesto (id_titolo="+string(al_id_tit)+", tipo partita "+string(ll_tipo_partita)+")!~r~nRiga NON scaricata.")
	else
		messagebox("Attenzione!", "Sul doc. di carico n. "+as_doc_da_scaricare+" NON c'e' una partita aperta con il titolo richiesto (id_titolo="+string(al_id_tit)+", tipo partita "+string(ll_tipo_partita)+")!~r~nRiga NON scaricata.")
	end if
	return 0
end if
if ll_n_cand>1 then
	messagebox("Attenzione!", "Ci sono "+string(ll_n_cand)+" proforma n. "+as_doc_da_scaricare+" di questo cliente con la partita ancora aperta!~r~n"+&
	           "Scarico la piu' recente (id_documento "+string(ll_id_doc_da_scaricare)+"): controllare.")
end if

//trovo la partita e il valore residuo (se ce ne fosse piu' di una aperta dello stesso titolo, la prima)
ll_id_partita_da_scaricare=0
select min(id_partita) into :ll_id_partita_da_scaricare from dba.orafo_aper_partita
where id_documento=:ll_id_doc_da_scaricare and id_titolo=:al_id_tit and id_tipo_partita=:ll_tipo_partita and stato='A';
if isnull(ll_id_partita_da_scaricare) or ll_id_partita_da_scaricare<=0 then
	messagebox("Attenzione!", "Sul doc. di carico n. "+as_doc_da_scaricare+" NON c'e' una partita aperta con il titolo richiesto (id_titolo="+string(al_id_tit)+", tipo partita "+string(ll_tipo_partita)+")!~r~nRiga NON scaricata.")
	return 0
end if
select val_apertura - ifnull(val_scarico, 0, val_scarico), val_scarico into :ldc_fino_partita, :ldc_val_scarico
from dba.orafo_aper_partita where id_partita=:ll_id_partita_da_scaricare;

if isnull(ldc_val_scarico) then ldc_val_scarico=0
if isnull(ldc_fino_partita) then ldc_fino_partita=0
if ldc_fino_partita - adc_fino<= - 0.1 then
	messagebox("Attenzione!", "La partita del doc n. "+as_doc_da_scaricare+" NON è sufficiente!!")
	li_ret=wf_apri_partita(al_id_riga_doc, al_id_sog, al_id_tit, adc_fino,al_id_doc_inserito)
	wf_salva_ds_partite()
	destroy us_dati_partita.s_dw_aper_partita
	destroy us_dati_partita.s_dw_scar_partita
	return 0
else
	if ldc_fino_partita - adc_fino=0 then ls_stato="C" else ls_stato="A"
	ldc_new_val_scarico=ldc_val_scarico+adc_fino
	update dba.orafo_aper_partita set val_scarico= :ldc_new_val_scarico, stato=:ls_stato where id_partita=:ll_id_partita_da_scaricare;
	if sqlca.sqlNrows>0 then
		commit;
		insert into dba.orafo_scar_partita (id_partita, id_riga_documento, val_scarico)
		values (:ll_id_partita_da_scaricare, :al_id_riga_doc, :adc_fino);
		if sqlca.sqlNrows>0 then
			commit;
			return 1
		else
			rollback;
			messagebox("Attenzione!", "Scarico Partita NON creato!!!")
		end if
	else
		rollback;
		messagebox("Attenzione!", "Partita NON scaricata!!!")
	end if		
end if
return 0








//long ll_id_doc_da_scaricare, ll_id_partita_da_scaricare, ll_tipo_partita
//string ls_stato
//decimal ldc_fino_partita, ldc_new_val_scarico, ldc_val_scarico
//integer li_ret
//
//select id_documento into :ll_id_doc_da_scaricare from dba.documento where num_documento=:as_doc_da_scaricare;
//if ll_id_doc_da_scaricare>0 then
//	//trovo il tipo partita
////	select id_tipo_partita into :ll_tipo_partita from dba.caus_magazzino c, riga_documento r 
////	where c.id_caus_magazzino=r.id_caus_magazzino and r.id_riga_documento=:al_id_riga_doc;
//	ll_tipo_partita=8
//	//trovo la partita e il valore residuo
//	ll_id_partita_da_scaricare=0
//	select id_partita, val_apertura - ifnull(val_scarico, 0, val_scarico), val_scarico into :ll_id_partita_da_scaricare, :ldc_fino_partita, :ldc_val_scarico from dba.orafo_aper_partita 
//	where id_documento=:ll_id_doc_da_scaricare and id_titolo=:al_id_tit and id_tipo_partita=:ll_tipo_partita and stato='A';
//	//20260922 se sul carico non c'e' una partita aperta di QUESTO titolo non scarico niente:
//	//         e' il filtro sul titolo che tiene separato lo scarico dell'ottone da quello dell'argento
//	if isnull(ll_id_partita_da_scaricare) or ll_id_partita_da_scaricare<=0 then
//		messagebox("Attenzione!", "Sul doc. di carico n. "+as_doc_da_scaricare+" NON c'e' una partita aperta con il titolo richiesto (id_titolo="+string(al_id_tit)+", tipo partita "+string(ll_tipo_partita)+")!~r~nRiga NON scaricata.")
//		return 0
//	end if
//	if isnull(ldc_val_scarico) then ldc_val_scarico=0
//	if ldc_fino_partita - adc_fino<= - 0.1 then
//		messagebox("Attenzione!", "La partita del doc n. "+as_doc_da_scaricare+" NON è sufficiente!!")
//		li_ret=wf_apri_partita(al_id_riga_doc, al_id_sog, al_id_tit, adc_fino,al_id_doc_inserito)
//		wf_salva_ds_partite()
//		destroy us_dati_partita.s_dw_aper_partita
//		destroy us_dati_partita.s_dw_scar_partita
//		return 0
//	else
//		if ldc_fino_partita - adc_fino=0 then ls_stato="C" else ls_stato="A"
//		ldc_new_val_scarico=ldc_val_scarico+adc_fino
//		update dba.orafo_aper_partita set val_scarico= :ldc_new_val_scarico, stato=:ls_stato where id_partita=:ll_id_partita_da_scaricare;
//		if sqlca.sqlNrows>0 then
//			commit;
//			insert into dba.orafo_scar_partita (id_partita, id_riga_documento, val_scarico)
//			values (:ll_id_partita_da_scaricare, :al_id_riga_doc, :adc_fino);
//			if sqlca.sqlNrows>0 then
//				commit;
//				return 1
//			else
//				rollback;
//				messagebox("Attenzione!", "Scarico Partita NON creato!!!")
//			end if
//		else
//			rollback;
//			messagebox("Attenzione!", "Partita NON scaricata!!!")
//		end if		
//	end if
//else
//	messagebox("Attenzione!", "Partita da scaricare n. "+as_doc_da_scaricare+" NON trovata!")
//end if
//return 0
//
end function

public function integer wf_carica_datastore (long al_id_sog);
long ll_id_sog, ll_id_doc, ll_riga_corrente, ll_id_prof
datetime ldt_data_ora
string ls_disattiva_partite, ls_ges_partite

//if (ls_disattiva_partite='N' or isnull(ls_disattiva_partite)) and ls_ges_partite='S' then
//fine modifica 10-02-14
//modifica del 06072015 prima dava errore se sicambiava ora doc prima di salvare il documento
 
	
		
//			ll_id_doc=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente, "ID_DOCUMENTO")
ldt_data_ora=datetime(today())

	ll_id_sog=al_id_sog
	if not isvalid(us_dati_partita.s_dw_aper_partita)  then
		us_dati_partita.s_dw_aper_partita = create datastore 
		us_dati_partita.s_dw_aper_partita.dataobject = "ds_orafo_part_aperte" 
		us_dati_partita.s_dw_aper_partita.settransobject(sqlca)
		us_dati_partita.s_dw_aper_partita.retrieve(ll_id_sog, ldt_data_ora)
		
		us_dati_partita.s_dw_scar_partita = create datastore
		us_dati_partita.s_dw_scar_partita.dataobject = "ds_orafo_partite_scarico_doc"
		us_dati_partita.s_dw_scar_partita.settransobject(sqlca)
		us_dati_partita.s_dw_scar_partita.RETRIEVE(ll_id_doc)	
		return 1
	
	end if
return 0	


end function

public function integer wf_salva_ds_partite ();long ll_riga_corrente,  ll_riga_trovata
integer li_ret, righe, i

	if isvalid(us_dati_partita.s_dw_aper_partita) then
		
		li_ret=us_dati_partita.s_dw_aper_partita.update()
		if li_ret<> 1 then 
			messagebox("Errore!", "Non salva orafo_aper_partita")
			rollback;
		else	
			li_ret=us_dati_partita.s_dw_scar_partita.update()
			if li_ret<> 1 then 
				messagebox("Errore!", "non salva orafo_scar_partita")
				rollback;
			else
				commit;
			end if
		end if
	end if
	
	
return 0
end function

public function integer wf_controlla_gia_importate (long al_id_sog, long al_id_prof, long al_id_tit_ag, long al_id_tit_ot);//==========================================================================================
// FUNZIONE NUOVA DI w_excel_labella  -  20261017
// Nel painter: menu Declare > Window Functions > nuova funzione, con questa dichiarazione:
//
//   Access     : public
//   Return type: integer
//   Name       : wf_controlla_gia_importate
//   Arguments  : long al_id_sog, long al_id_prof, long al_id_tit_ag, long al_id_tit_ot
//
// wf_controlla_gia_importate  -  20261017
//
// Protezione contro la doppia importazione dello stesso xls Binder.
// Il 17/10/2026, sulla copia di prova, reimportare il file del 13/10 (gia' importato nel DDT 2276
// e fatturato con la 521) ha creato un nuovo DDT e ha SCARICATO UNA SECONDA VOLTA tutte le righe
// delle proforma ancora aperte, senza nessun avviso.
//
// Prima di creare il documento controllo, riga per riga di dw_8, se la stessa riga e' gia' in un
// documento dello stesso cliente e dello stesso profilo di destinazione. Una riga e' "la stessa" se:
//   - descrizione uguale  "Semilavorati in <AG|OT> - N. rif. Proforma: <A04>"  (proforma + metallo)
//   - articolo con codice = A03 (oppure A03_<metallo>, come lo crea wf_agg_articoli) e lo stesso titolo
//   - peso_netto uguale a A05 (tolleranza 0,05 g)
// Controllo anche che la stessa riga non compaia due volte in dw_8 (stesso file caricato due volte).
//
// Le fatture che evadono il DDT copiano descrizione, articolo e peso: per questo filtro sul profilo
// di destinazione dell'import (il DDT), cosi' la fattura non viene presa per un doppione.
//
// Ritorna: 0 = nessun doppione, oppure l'utente ha confermato di importare lo stesso
//          1 = importazione da ANNULLARE
//==========================================================================================
long    ll_i, ll_j, ll_righe, ll_id_tit, ll_trovate, ll_n_doppie, ll_n_interne
integer li_num_riga
string  ls_met, ls_cod_art, ls_cod_art_met, ls_num_ordine, ls_des, ls_legato, ls_elenco, ls_num_ddt
string  ls_chiave[], ls_chiave_j
decimal ldc_legato
date    ldt_data_ddt
integer li_mostrate
string  ls_interne

ll_righe=dw_8.rowcount()
if ll_righe<=0 then return 0
ll_n_doppie=0
ll_n_interne=0
li_mostrate=0
ls_elenco=""

for ll_i=1 to ll_righe
	ls_chiave[ll_i]=""
	//stesse regole di cb_passa::clicked: si importano solo le righe con il numero in A01
	li_num_riga=integer(dw_8.getitemstring(ll_i, "A01"))
	if isnull(li_num_riga) or li_num_riga<=0 then continue

	//metallo e titolo della riga
	ls_met="AG"
	if ll_i<=upperbound(is_met_riga) then
		if is_met_riga[ll_i]="OT" then ls_met="OT"
	end if
	if ls_met="OT" then ll_id_tit=al_id_tit_ot else ll_id_tit=al_id_tit_ag

	//stessi valori che scrive cb_passa::clicked nella riga del DDT
	ls_num_ordine=dw_8.getitemstring(ll_i, "A04")
	ls_des="Semilavorati in "+ls_met+" - N. rif. Proforma: "+ls_num_ordine
	ls_cod_art=trim(dw_8.getitemstring(ll_i, "A03"))
	ls_cod_art_met=ls_cod_art+"_"+ls_met
	ls_legato=f_sostituisci_carattere(dw_8.getitemstring(ll_i, "A05"), ".", ",")
	ldc_legato=dec(ls_legato)
	if isnull(ldc_legato) or ldc_legato<0 then ldc_legato=0
	if isnull(ls_cod_art) or isnull(ls_num_ordine) then continue

	//1) la stessa riga compare due volte nelle righe caricate?
	ls_chiave[ll_i]=ls_met+"|"+ls_cod_art+"|"+trim(ls_num_ordine)+"|"+string(ldc_legato, "0.00")
	for ll_j=1 to ll_i - 1
		ls_chiave_j=ls_chiave[ll_j]
		if ls_chiave_j=ls_chiave[ll_i] then
			ll_n_interne++
			if li_mostrate<20 then
				ls_elenco+="riga "+string(li_num_riga)+": cod. "+ls_cod_art+" proforma "+trim(ls_num_ordine)+" "+ls_met+" g "+string(ldc_legato, "0.00")+" -> DUE VOLTE nelle righe caricate~r~n"
				li_mostrate++
			end if
			exit
		end if
	next

	//2) la stessa riga e' gia' in un documento importato prima?
	ll_trovate=0
	setnull(ls_num_ddt)
	setnull(ldt_data_ddt)
	select count(*), max(d.num_documento), max(d.data_documento)
	into :ll_trovate, :ls_num_ddt, :ldt_data_ddt
	from dba.riga_documento r, dba.documento d, dba.articolo a
	where r.id_documento=d.id_documento
	and a.id_articolo=r.id_articolo
	and d.id_sog_commerciale=:al_id_sog
	and d.id_prof_documento=:al_id_prof
	and r.descrizione=:ls_des
	and (a.codice=:ls_cod_art or a.codice=:ls_cod_art_met)
	and a.id_titolo=:ll_id_tit
	and abs(isnull(r.peso_netto, 0) - :ldc_legato)<0.05;
	if sqlca.sqlcode<0 then
		messagebox("Attenzione!", "Controllo righe gia' importate NON riuscito:~r~n"+sqlca.sqlerrtext+"~r~nImportazione ANNULLATA.")
		return 1
	end if
	if isnull(ll_trovate) then ll_trovate=0
	if ll_trovate>0 then
		ll_n_doppie++
		if li_mostrate<20 then
			ls_elenco+="riga "+string(li_num_riga)+": cod. "+ls_cod_art+" proforma "+trim(ls_num_ordine)+" "+ls_met+" g "+string(ldc_legato, "0.00")+ &
			           " -> gia' nel DDT n. "+ls_num_ddt+" del "+string(ldt_data_ddt, "dd/mm/yy")+"~r~n"
			li_mostrate++
		end if
	end if
next

if ll_n_doppie=0 and ll_n_interne=0 then return 0

if ll_n_doppie+ll_n_interne>li_mostrate then ls_elenco+="... e altre "+string(ll_n_doppie+ll_n_interne - li_mostrate)+"~r~n"

ls_interne=""
if ll_n_interne>0 then ls_interne=" e "+string(ll_n_interne)+" sono caricate due volte"

//pulsante predefinito = NO (annulla): per importare lo stesso bisogna sceglierlo apposta
if messagebox("ATTENZIONE: righe GIA' IMPORTATE!", &
	string(ll_n_doppie)+" righe sono gia' in un DDT importato prima"+ &
	ls_interne+":~r~n~r~n"+ls_elenco+ &
	"~r~nImportandole di nuovo si crea un altro DDT e si SCARICANO DI NUOVO le proforma.~r~n~r~n"+ &
	"Importare lo stesso?", Exclamation!, YesNo!, 2)=1 then
	return 0
end if

return 1

end function

public function boolean wf_riga_vuota (long al_riga);//20261017 riga del packing list senza dati: niente codice (A03), proforma (A04), peso (A05) e pezzi (A06).
//         Il modulo di Binder ha la colonna A gia' numerata anche sulle righe vuote.
//         Basta UNO di questi campi per considerare la riga buona: se e' incompleta, se ne accorge
//         l'import con un messaggio (meglio un avviso in piu' che una riga sparita in silenzio).
string ls_cod, ls_prof, ls_peso, ls_pz

ls_cod =trim(dw_8.getitemstring(al_riga, "A03"))
ls_prof=trim(dw_8.getitemstring(al_riga, "A04"))
ls_peso=trim(dw_8.getitemstring(al_riga, "A05"))
ls_pz  =trim(dw_8.getitemstring(al_riga, "A06"))
if isnull(ls_cod) then ls_cod=""
if isnull(ls_prof) then ls_prof=""
if isnull(ls_peso) then ls_peso=""
if isnull(ls_pz) then ls_pz=""
return (ls_cod="" and ls_prof="" and ls_peso="" and ls_pz="")

end function

on w_excel_labella.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_passa=create cb_passa
this.cb_stampa=create cb_stampa
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
this.Control[iCurrent+4]=this.cb_stampa
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.cb_reset
this.Control[iCurrent+7]=this.dw_4
this.Control[iCurrent+8]=this.dw_6
this.Control[iCurrent+9]=this.dw_5
this.Control[iCurrent+10]=this.dw_7
this.Control[iCurrent+11]=this.cb_xls
this.Control[iCurrent+12]=this.dw_8
this.Control[iCurrent+13]=this.ole_1
end on

on w_excel_labella.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_passa)
destroy(this.cb_stampa)
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


setfocus(cb_xls)

title=ClassName()
end event

type st_1 from w_001`st_1 within w_excel_labella
end type

type dw_1 from udw_base within w_excel_labella
integer x = 27
integer y = 264
integer width = 2286
integer height = 244
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

type dw_3 from udw_base within w_excel_labella
integer x = 55
integer y = 28
integer width = 2245
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_xls_labella_dati_fissi"
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

type cb_passa from commandbutton within w_excel_labella
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
long     ll_null,ll_riga_doc, ll_id_doc, ll_id_art,ll_num_prog, ll_id_tit,  ll_id_locazione, ll_id_causale
string     ls_nota="",  ls_des,ls_cod_art, lds_legato, ls_pezzi, ls_met, ls_num_documento, ls_ucm, ls_num_ordine
date  ldt_data_doc
long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_riga_doc_inserito, ll_new_riga_doc
long ll_riga_trovata, ll_pezzi, ll_id_listino, ll_id_tab_iva, ll_id_variazione, ll_uc
long ll_id_tit_ag, ll_id_tit_ot, ll_righe_ag, ll_righe_ot
setnull(ll_null)
decimal  ldc_legato, ldc_titolo, ldc_coef_calo, ldc_fino, ldc_calo
integer li_num_riga

//20260928 METALLO: cambia da riga a riga, perche' si possono caricare piu' file insieme anche di
//          metalli diversi. Il metallo della riga sta in is_met_riga[], scritto al caricamento
//          dell'xls leggendo la cella B3 di ogni file (BRASS = ottone OT 1000, altrimenti AG 925).
//          Qui cerco UNA volta sola il titolo dei due metalli e conto le righe di ciascuno.
ll_id_tit_ag=0
select id_titolo into :ll_id_tit_ag from dba.orafo_titolo t, orafo_metallo m
where t.id_metallo=m.id_metallo and m.codice='AG' and t.titolo=925;
if isnull(ll_id_tit_ag) or ll_id_tit_ag<=0 then
	messagebox("Attenzione!", "Titolo AG 925 NON trovato! Metto titolo 4")
	ll_id_tit_ag=4
end if
ll_id_tit_ot=0
select id_titolo into :ll_id_tit_ot from dba.orafo_titolo t, orafo_metallo m
where t.id_metallo=m.id_metallo and m.codice='OT' and t.titolo=1000;
ll_righe_ag=0
ll_righe_ot=0
for i=1 to dw_8.rowcount()
	ls_met="AG"
	if i<=upperbound(is_met_riga) then
		if is_met_riga[i]="OT" then ls_met="OT"
	end if
	if ls_met="OT" then
		ll_righe_ot++
	else
		ll_righe_ag++
	end if
next
if ll_righe_ot>0 then
	if isnull(ll_id_tit_ot) or ll_id_tit_ot<=0 then
		messagebox("Attenzione!", "Titolo OT 1000 NON trovato in archivio!~r~nImportazione ANNULLATA: senza titolo lo scarico dell'ottone finirebbe sulla partita sbagliata.")
		return
	end if
end if
if messagebox("Attenzione!", "Importo "+string(ll_righe_ag)+" righe in ARGENTO (AG) e "+string(ll_righe_ot)+" in OTTONE (OT).~r~nVado avanti?", question!, yesno!)<>1 then return

//20261017 protezione doppia importazione: se le righe sono gia' in un DDT importato prima
//         (o il file e' caricato due volte) avviso e, salvo conferma esplicita, non importo niente
if wf_controlla_gia_importate(dw_3.getitemnumber(1, "id_sog_com"), dw_3.getitemnumber(1, "id_prof_destinazione"), ll_id_tit_ag, ll_id_tit_ot)=1 then
	messagebox("Attenzione!", "Importazione ANNULLATA: nessun documento creato, nessuna partita scaricata.")
	return
end if
//20261017 fine

for i=1 to dw_8.rowcount()
	if i= 1 then  //questa è la testa del doc, le cose che faccio una volta sola 
	//da spostare fuori dal for!!!!! che cosa ci fa qui?????
		dw_1.reset()
		dw_2.reset()
		ll_riga_doc=dw_1.insertrow(0)
		ll_num_prog=wf_prepara_doc(ll_riga_doc, i)
		if ll_num_prog=0 then
			messagebox("Attenzione!", "Documento NON creato!!! AHI!!!")
			return
		end if
		//trovo dati che servono
		ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
		select id_locazione_1_prop, id_caus_magazzino_prop
		into  :ll_id_locazione, :ll_id_causale
		from dba.prof_documento
		where id_prof_documento=:ll_id_prof;
		//ora li inserisco nel doc
		dw_1.setitem(ll_riga_doc, "id_caus_magazzino", ll_id_causale)
		dw_1.setitem(ll_riga_doc, "id_magazzino", ll_id_locazione)
		dw_1.setitem(ll_riga_doc, "id_locazione_1", ll_id_locazione)
		ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
		select id_listino, id_tab_iva into :ll_id_listino, :ll_id_tab_iva
		from dba.sog_commerciale
		where id_sog_commerciale=:ll_id_sog;
		if ll_id_tab_iva<=0 or isnull(ll_id_tab_iva) then ll_id_tab_iva=124
		if ll_id_listino>0 then
			dw_1.setitem(ll_riga_doc, "id_listino", ll_id_listino)
			ldt_data_doc=dw_3.getitemdate(1, "doc_data")
			select id_variazione
			into :ll_id_variazione
			from dba.variazione
			where id_listino=:ll_id_listino
			and data_inizio<=:ldt_data_doc and (data_fine>=:ldt_data_doc or data_fine is null)
			;
			dw_1.setitem(ll_riga_doc, "id_variazione", ll_id_variazione)
		end if
		
		//mi preparo a salvare la testa e salvo
		dw_1.setitemstatus(ll_riga_doc, 0, primary!, newmodified!)
		li_ret=dw_1.trigger event ue_update()
		IF li_ret<=0 THEN 
			messagebox("Attenzione!", "Documento NON creato!!! RIGA 25")
			RETURN
		END IF
		ll_id_doc_inserito=dw_1.getitemnumber(ll_riga_doc, "id_documento")
	
	end if
	//ORA creo le righe
		//prima guardo se c'è un num riga, altrimenti salto e vado al prossimo giro
		li_num_riga=integer(dw_8.GETITEmstring(i, "A01"))
		if li_num_riga>0  then 
			//20261017 senza codice l'articolo non si puo' creare (codice NOT NULL in articolo):
			//         salto la riga PRIMA di inserirla, con un solo avviso
			ls_cod_art=trim(dw_8.getitemstring(i, "A03"))
			if isnull(ls_cod_art) or ls_cod_art="" then
				messagebox("Attenzione!", "Riga "+string(li_num_riga)+" senza codice (colonna C): NON importata.")
				continue
			end if
			//20260928 metallo di QUESTA riga: lo ha scritto il caricamento dell'xls, file per file
			ls_met="AG"
			if i<=upperbound(is_met_riga) then
				if is_met_riga[i]="OT" then ls_met="OT"
			end if
			if ls_met="OT" then
				ldc_titolo=1000
				ll_id_tit=ll_id_tit_ot
			else
				ldc_titolo=925
				ll_id_tit=ll_id_tit_ag
			end if
			ldc_coef_calo=ldc_titolo
			ll_riga_doc_inserito=dw_2.insertrow(0)
			dw_2.setitem(ll_riga_doc_inserito, "id_valuta", 3)
			dw_2.setitem(ll_riga_doc_inserito, "id_documento", ll_id_doc_inserito)
			dw_2.setitem(ll_riga_doc_inserito, "num_riga", li_num_riga)
			dw_2.setitem(ll_riga_doc_inserito, "id_riga_documento", ll_null)
			lds_legato=dw_8.getitemstring(i, "A05")
			lds_legato=f_sostituisci_carattere(lds_legato, ".", ",")
			ldc_legato=dec(lds_legato) //peso netto
			if isnull(ldc_legato) or ldc_legato<0 then ldc_legato=0  //controllo anche che il legato sia >=0 20220728
			dw_2.setitem(ll_riga_doc_inserito, "peso_netto", ldc_legato)
			// recupero il legame con il documento di carico 
			ls_num_ordine=dw_8.getitemstring(i, "A04")
			//lo aggiungo alla descrizione e a provv_imp_carea_2
			ls_des="Semilavorati in "+ls_met+" - N. rif. Proforma: "+ls_num_ordine//dw_8.getitemstring(i, "A04")  //20230926 eventualmente aggiungiamo il numero rifFAT proforma /delivery
			dw_2.setitem(ll_riga_doc_inserito, "descrizione", ls_des)
			ls_cod_art=dw_8.getitemstring(i, "A03")
			ls_cod_art=trim(ls_cod_art)
			//calcola fino e calo
			ldc_fino=ldc_legato*ldc_titolo/1000
			ldc_calo=ldc_legato*ldc_coef_calo/1000 - ldc_fino
			dw_2.setitem(ll_riga_doc_inserito, "fino", ldc_fino)
			dw_2.setitem(ll_riga_doc_inserito, "calo", ldc_calo)
			ls_pezzi=dw_8.getitemstring(i, "A06")
			ls_pezzi=f_sostituisci_carattere(ls_pezzi, ".", ",")
			ll_pezzi=long(ls_pezzi)
			dw_2.setitem(ll_riga_doc_inserito, "quantita", ll_pezzi)
			//20261123 evasione a zero, non NULL: sp_deriva_riga fa qta_evasa + quantita derivata e con NULL
			//         la qta evasa restava NULL per sempre -> la bolla si poteva ricavare due volte
			//         (2688 -> fatture 599 e 600 del 23/11/2026, la seconda con peso 0)
			dw_2.setitem(ll_riga_doc_inserito, "qta_sconto_merce", 0)
			dw_2.setitem(ll_riga_doc_inserito, "qta_evasa", 0)
			dw_2.setitem(ll_riga_doc_inserito, "qta_evasa_un_base", 0)
			dw_2.setitem(ll_riga_doc_inserito, "fat_con_unita_base", 1)
			dw_2.setitem(ll_riga_doc_inserito, "fat_con_globale", 1)
			//se ci sono i pezzi muove a pz, altrimenti a grammo
			if ll_pezzi>0 then
				ls_ucm="PZ" 
			else 
				ls_ucm="GR" 
			end if
			ll_id_art=wf_agg_articoli(ls_cod_art, ll_id_tit, ls_ucm)
			if ll_id_art<=0 or isnull(ll_id_art) then
				messagebox("Attenzione!", "Articolo:"+ ls_cod_art+" NON creato")
				//20260922 la riga era gia' stata inserita nel buffer: se la lascio li' la salva
				//         il ue_update del giro dopo, incompleta. La butto via.
				dw_2.deleterow(ll_riga_doc_inserito)
				continue
			end if
			dw_2.setitem(ll_riga_doc_inserito, "id_articolo", ll_id_art)
			select id_unita_confezione into :ll_uc  from dba.unita_confezione where id_articolo= :ll_id_art and unita_base='S';
			dw_2.setitem(ll_riga_doc_inserito, "id_unita_confezione", ll_uc)
			dw_2.setitem(ll_riga_doc_inserito, "coef_calo", ldc_coef_calo)  
		
			//locazione e causale e iva riga e id_variazione
			dw_2.setitem(ll_riga_doc_inserito, "id_locazione_1", ll_id_locazione)
			dw_2.setitem(ll_riga_doc_inserito, "id_caus_magazzino", ll_id_causale)
			dw_2.setitem(ll_riga_doc_inserito, "id_tab_iva", ll_id_tab_iva)
			dw_2.setitem(ll_riga_doc_inserito, "id_listino", ll_id_variazione)
			//20231020 metto prezzo metallo=0 altrimenti il nullo mi crea 2 righe nei riep metallo....
			dw_2.setitem(ll_riga_doc_inserito, "prezzo_metallo", 0)
			dw_2.setitemstatus(ll_riga_doc_inserito, 0, primary!, newmodified!)
			li_ret=dw_2.trigger event ue_update()  //20220725
			//scarico delle partite:id riga doc che scarica, intestatario da scaricare, titolo, peso_scaricato
			ll_new_riga_doc=dw_2.getitemnumber(ll_riga_doc_inserito, "id_riga_documento")
			dw_2.setitem(ll_riga_doc_inserito, "id_riga_partita", ll_new_riga_doc)
			li_ret=dw_2.trigger event ue_update()  
			//20260922 il fino da scaricare e' quello calcolato col titolo del metallo (era fisso a 925)
			//wf_scarica_partite(ll_new_riga_doc, ll_id_sog, ll_id_tit, ldc_fino, ls_num_ordine,ll_id_doc_inserito )
			//20261017 senza peso non c'e' metallo da scaricare: niente scarico da 0 grammi
			if ldc_fino>0 then
				wf_scarica_partite(ll_new_riga_doc, ll_id_sog, ll_id_tit, ldc_fino, ls_num_ordine,ll_id_doc_inserito )
			else
				messagebox("Attenzione!", "Riga "+string(li_num_riga)+" (cod. "+ls_cod_art+", proforma "+trim(ls_num_ordine)+") SENZA PESO (colonna E):~r~n"+&
				           "importata con peso 0, metallo NON scaricato. Controllare il file.")
			end if
			//20261017 fine
		end if
		
	next

end event

type cb_stampa from commandbutton within w_excel_labella
boolean visible = false
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

type dw_2 from udw_figlia within w_excel_labella
integer x = 23
integer y = 516
integer width = 2272
integer height = 1040
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
boolean livescroll = false
end type

event retrievestart;call super::retrievestart;return 2
end event

type cb_reset from commandbutton within w_excel_labella
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

event clicked;string ls_met_vuoto[]
long ll_righe_vuoto[]

if messagebox("Attenzione!", "Vuoi davvero pulire le finestre per fare un altro DDT?", stopsign!, yesno!)= 1 then
	dw_1.reset()
	dw_2.reset()

	dw_8.reset()
	//20260922 torno al metallo di default: lo ridiranno i prossimi file caricati
	//20260928 svuoto anche le liste dei metalli, altrimenti il prossimo carico le trova sporche
	is_cod_metallo="AG"
	is_met_file=ls_met_vuoto
	is_met_riga=ls_met_vuoto
	il_righe_file=ll_righe_vuoto
	parent.title="Import Excel"
end if
end event

type dw_4 from udw_base within w_excel_labella
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

type dw_6 from udw_base within w_excel_labella
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

type dw_5 from udw_base within w_excel_labella
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

type dw_7 from udw_base within w_excel_labella
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

type cb_xls from commandbutton within w_excel_labella
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

event clicked;integer li_ret, i, a
string ls_path, ls_file, ls_name[], ls_path_ini, ls_nome_file, ls_test, ls_met_file, ls_met_vuoto[]
long ll_rigains, ll_max, ll_righe_prima, ll_righe_dopo
long ll_valide, ll_file, ll_riga, ll_j, ll_tot_ag, ll_tot_ot

ls_path_ini="c:\nita\xls"
getfileopenname("Cerca file excel", ls_path, ls_name, "xls", "*.xls", ls_path_ini)
if  not(trim(ls_name[1])="" or isnull(ls_name[1])) then
	for i= 1 to upperbound(ls_name)
		if  upperbound(ls_name)=1 then
			ls_nome_file=ls_path
		else
			ls_nome_file=ls_path+"\"+ls_name[i]
		end if
		//ole_1.open(ls_nome_file)  //20261030 sostituito da f_xls_in_txt (l'oggetto OLE ricreato funziona, ma si preferisce il codice diretto)
		
		ls_file=left(ls_nome_file, len(ls_nome_file) - 3)+"txt"
		if fileexists(ls_file) then filedelete(ls_file)
		//ole_1.object.activesheet.saveas(ls_file, 21)
		if f_xls_in_txt(ls_nome_file, ls_file) <> 1 then exit  //20261030 messaggio gia' dato; i file precedenti restano caricati
		//dw_8.reset()
		ll_righe_prima=dw_8.rowcount()
		dw_8.importfile(Text!,ls_file)
		//20260922 METALLO DEL FILE: sta nella cella B3 del foglio, cioe' colonna A02 della TERZA riga.
		//          Va letto ADESSO: quella riga qui sotto viene buttata via dal filtro su A01.
		ls_met_file="AG"
		ll_righe_dopo=dw_8.rowcount()
		if ll_righe_dopo>=ll_righe_prima+3 then
			ls_test=upper(trim(dw_8.getitemstring(ll_righe_prima+3, "A02")))
			if ls_test="BRASS" then ls_met_file="OT"
		end if
		//20260928 mi segno metallo e numero di righe BUONE di questo file (stesso criterio della pulizia
		//          qui sotto: conta solo chi ha un numero in A01). Serve per ricostruire dopo il metallo
		//          riga per riga, cosi' file di metalli diversi possono stare insieme nello stesso import.
		ll_valide=0
		for ll_riga=ll_righe_prima+1 to ll_righe_dopo
			ls_test=dw_8.getitemstring(ll_riga, "A01")
			//if isnumber(ls_test) then ll_valide++
			//20261017 le righe vuote del modulo non contano (stesso criterio della pulizia qui sotto)
			if isnumber(ls_test) and not wf_riga_vuota(ll_riga) then ll_valide++
		next
		ll_file=upperbound(is_met_file)+1
		is_met_file[ll_file]=ls_met_file
		il_righe_file[ll_file]=ll_valide


		//parent.height=2450
		//ole_1.object.close(False)
	next
	FOR I=  dw_8.rowcount() to 1 step -1
		
		ls_test=dw_8.getitemstring(i, "A01")
		//if isnumber(ls_test) then
		//20261017 butto via anche le righe vuote del modulo (numero in A ma niente dati)
		if isnumber(ls_test) and not wf_riga_vuota(i) then

//			a++
//			dw_8.setitem(i, "A01", string(a))
		else
			dw_8.deleterow(i)
		end if
	next
	for i=1 to  dw_8.rowcount()
		dw_8.setitem(i, "A01", string(i))
	next
	//20260928 ora che le intestazioni sono state buttate via, ricostruisco il metallo riga per riga:
	//         le righe dei file stanno in dw_8 nell'ordine in cui sono stati caricati.
	is_met_riga=ls_met_vuoto
	ll_riga=0
	ll_tot_ag=0
	ll_tot_ot=0
	for ll_file=1 to upperbound(is_met_file)
		for ll_j=1 to il_righe_file[ll_file]
			ll_riga++
			is_met_riga[ll_riga]=is_met_file[ll_file]
		next
		if is_met_file[ll_file]="OT" then
			ll_tot_ot+=il_righe_file[ll_file]
		else
			ll_tot_ag+=il_righe_file[ll_file]
		end if
	next
	//rete di sicurezza: se i conti non tornano il metallo delle righe non e' attendibile
	if ll_riga<>dw_8.rowcount() then
		messagebox("Attenzione!", "Conteggio righe NON tornato ("+string(ll_riga)+" contro "+string(dw_8.rowcount())+")!~r~nNON importare: avvisa l'assistenza.")
	end if
	//20260922 dico sempre che metallo ho riconosciuto: se sbaglia si vede subito, prima di importare
	if ll_tot_ot>0 and ll_tot_ag>0 then
		is_cod_metallo="MISTO"
	elseif ll_tot_ot>0 then
		is_cod_metallo="OT"
	else
		is_cod_metallo="AG"
	end if
	parent.title="Import Excel - AG: "+string(ll_tot_ag)+" righe - OT: "+string(ll_tot_ot)+" righe"
	messagebox("Metallo", "Righe caricate:~r~nARGENTO (AG, titolo 925): "+string(ll_tot_ag)+"~r~nOTTONE (OT, titolo 1000): "+string(ll_tot_ot)+"~r~n~r~nIl metallo lo decide la cella B3 di ogni file.")
	
end if	 
end event

type dw_8 from udw_000 within w_excel_labella
integer x = 2318
integer y = 28
integer width = 2272
integer height = 1520
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_imp_file_croma"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type ole_1 from olecontrol within w_excel_labella
event queryinterface ( OleObject riid,  ref Pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( OleObject target )
event beforedoubleclick ( OleObject target,  boolean cancel )
event beforerightclick ( OleObject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( OleObject target )
boolean visible = false
integer x = 2898
integer y = 1784
integer width = 2053
integer height = 684
integer taborder = 30
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_excel_labella.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

