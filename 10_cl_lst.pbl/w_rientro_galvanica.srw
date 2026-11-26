forward
global type w_rientro_galvanica from w_001
end type
type dw_1 from udw_base within w_rientro_galvanica
end type
type dw_3 from udw_base within w_rientro_galvanica
end type
type cb_1 from commandbutton within w_rientro_galvanica
end type
type rb_2018 from radiobutton within w_rientro_galvanica
end type
type rb_2019 from radiobutton within w_rientro_galvanica
end type
type rb_2020 from radiobutton within w_rientro_galvanica
end type
type rb_2021 from radiobutton within w_rientro_galvanica
end type
type rb_2022 from radiobutton within w_rientro_galvanica
end type
type cb_2 from commandbutton within w_rientro_galvanica
end type
type cb_st_doc from commandbutton within w_rientro_galvanica
end type
type cb_reset from commandbutton within w_rientro_galvanica
end type
type pb_spazzola from picturebutton within w_rientro_galvanica
end type
type cbx_controllo from checkbox within w_rientro_galvanica
end type
type st_2 from statictext within w_rientro_galvanica
end type
type pb_buratto from picturebutton within w_rientro_galvanica
end type
type rr_1 from roundrectangle within w_rientro_galvanica
end type
type pb_1 from picturebutton within w_rientro_galvanica
end type
type dw_5 from udw_base within w_rientro_galvanica
end type
type dw_2 from udw_figlia within w_rientro_galvanica
end type
type cbx_1 from checkbox within w_rientro_galvanica
end type
type cb_salva_cancellazione from commandbutton within w_rientro_galvanica
end type
type dw_8 from udw_base within w_rientro_galvanica
end type
type st_3 from statictext within w_rientro_galvanica
end type
type st_4 from statictext within w_rientro_galvanica
end type
type cb_passa from commandbutton within w_rientro_galvanica
end type
type dw_7 from udw_001 within w_rientro_galvanica
end type
type dw_4 from udw_figlia within w_rientro_galvanica
end type
type dw_9 from udw_base within w_rientro_galvanica
end type
type st_5 from statictext within w_rientro_galvanica
end type
type st_6 from statictext within w_rientro_galvanica
end type
type st_7 from statictext within w_rientro_galvanica
end type
type cb_bur_sped from commandbutton within w_rientro_galvanica
end type
type r_1 from rectangle within w_rientro_galvanica
end type
end forward

global type w_rientro_galvanica from w_001
boolean visible = false
integer width = 6491
integer height = 2748
string title = "INVIO MERCE IN GALVANICA"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_3 dw_3
cb_1 cb_1
rb_2018 rb_2018
rb_2019 rb_2019
rb_2020 rb_2020
rb_2021 rb_2021
rb_2022 rb_2022
cb_2 cb_2
cb_st_doc cb_st_doc
cb_reset cb_reset
pb_spazzola pb_spazzola
cbx_controllo cbx_controllo
st_2 st_2
pb_buratto pb_buratto
rr_1 rr_1
pb_1 pb_1
dw_5 dw_5
dw_2 dw_2
cbx_1 cbx_1
cb_salva_cancellazione cb_salva_cancellazione
dw_8 dw_8
st_3 st_3
st_4 st_4
cb_passa cb_passa
dw_7 dw_7
dw_4 dw_4
dw_9 dw_9
st_5 st_5
st_6 st_6
st_7 st_7
cb_bur_sped cb_bur_sped
r_1 r_1
end type
global w_rientro_galvanica w_rientro_galvanica

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
integer li_anno
string is_ultima_colonna, is_bur_domani
end variables

forward prototypes
public subroutine wf_articolo (long al_id_articolo, long al_riga_doc)
public function long wf_importa (integer ai_riga)
public subroutine wf_agg_fino_calo (decimal adc_legato, long al_riga_inserita)
public subroutine wf_bilancia (long al_riga_inserita, long al_id_bollettina_doc)
public function string wf_corretto_nonpiu_blocco (long al_id_art, string as_tipo, string as_flag)
public subroutine wf_controlla_galv_l (long al_riga)
public subroutine wf_ges_lacci_fili (string as_tipo, decimal ai_num_lacci_fili)
public function decimal wf_storna_legato (decimal adc_peso_da_stornare)
public subroutine wf_controllo_peso_doppio (long al_riga_trovata, decimal adc_peso_netto)
public subroutine wf_giorno_rientro_silver (long al_riga_dw_8, long al_riga_dw_4)
public subroutine wf_colora_riga_lavorata (long al_riga_lavorata)
public function integer wf_salva_giorno_rientro_silver (long al_riga_corrente, string as_grs)
public function long wf_agg_a_doc_esistente (string as_data)
public subroutine wf_agg_data_ora_modfica ()
public subroutine wf_salva_data_ora (long al_id_riga, datetime adt_data_ora)
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
long	 ll_id_articolo,ll_id_prof, ll_id_riga
udw_figlia idw_riga
datetime ldt_data_ora

ll_id_prof=dw_3.getitemnumber(1,"id_prof_destinazione")
if cbx_1.checked  or ll_id_prof=130  or is_bur_domani='S' then  //20251025 buratto domani: si comporta come il sald
	idw_riga=dw_4
else
	idw_riga=dw_2
end if
ldc_coef_calo=idw_riga.getitemdecimal(al_riga_inserita, "coef_calo")
ll_id_articolo=idw_riga.getitemnumber(al_riga_inserita, "id_articolo")
select titolo
into :ldc_titolo
from orafo_titolo t, articolo a
where a.id_titolo=t.id_titolo
and a.id_articolo=:ll_id_articolo
;
ldc_fino=round(adc_legato*ldc_titolo/1000, 2)
ldc_calo=round(adc_legato*ldc_coef_calo/1000,2) - ldc_fino
idw_riga.setitem(al_riga_inserita, "fino", ldc_fino)
idw_riga.setitem(al_riga_inserita, "calo", ldc_calo)

//registro data ora della modifica del peso 20250414
ll_id_riga=idw_riga.getitemnumber(al_riga_inserita, "id_riga_documento")
ldt_data_ora=datetime(today(), now())

wf_salva_data_ora(ll_id_riga, ldt_data_ora)


end subroutine

public subroutine wf_bilancia (long al_riga_inserita, long al_id_bollettina_doc);DWObject my_dwo
decimal ld_peso_netto,ldc_coef_calo, ldc_titolo, ldc_calo, ldc_fino
long	ll_row, ll_id_articolo, ll_riga_trovata,ll_id_prof,ll_id_riga_bol,ll_id_caus_magazzino, LL_nuova_RIGA, ll_riga_trovata4
string ls_metallo,ls_test, ls_num_bol
integer li_ret


w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()
//20250903 se il peso è <=0.2 deve essere =0 (Sara)
if isnull(ld_peso_netto) or ld_peso_netto<=0.2 then ld_peso_netto=0  //20250829 aggiungo controllo nullo anche se non dovrebbe essere necessario, ma stiamo accorti...

//if ld_peso_netto<=0 or isnull(ld_peso_netto) then messagebox("W", "AH!")
//ld_peso_netto=1111 //da togliere subito e rimettere a posto sopra!!!!!!!!!!!!!!
dw_3.setitem(1, "legato", ld_peso_netto)
dw_2.setitem(al_riga_inserita, "peso_netto", ld_peso_netto)
ls_test="id_documento="+string(al_id_bollettina_doc)
ll_riga_trovata=dw_8.find(ls_test, 1, dw_1.rowcount())
if ll_riga_trovata>0 then
	dw_8.setitem(ll_riga_trovata, "peso_netto", ld_peso_netto)
else
	close(w_bil)  // se commentata da rimettere a posto!!!!!!!!!!!!
	messagebox("MOLTA Attenzione!", "STRANO! NON c'è la bollettina???")
	return
end if
ll_id_prof=dw_3.getitemnumber(1,"id_prof_destinazione")
if ll_id_prof=130 or is_bur_domani='S' then  //20251024 BUR DOMANI Il buratto deve fare le stesse cose del sald
	select num_documento into :ls_num_bol from dba.documento where id_documento=:al_id_bollettina_doc;
	//ls_test="provv_imp_subage_2="+string(ll_id_riga_bol) //NO! 20250808 NON c'è id_riga in provv_imp_subage_2....
	ls_test="num_bollettina='"+ls_num_bol+"'"  //20250808 cambiato modo per trovare la riga su dw_4, speriamo per dw_8
	ll_riga_trovata4=dw_4.find(ls_test, 1, dw_4.rowcount())
	if ll_riga_trovata4>0 then  //20240213 la riga  nel doc c'è ...
		dw_4.setitem(ll_riga_trovata4, "peso_netto", ld_peso_netto)
		//20240430
		wf_controllo_peso_doppio(ll_riga_trovata4, ld_peso_netto)
		//fine
		wf_colora_riga_lavorata(ll_riga_trovata4)
		wf_agg_fino_calo(ld_peso_netto, ll_riga_trovata4)
	else //... altrimenti bisogna inserirla!!! Sara
		messagebox("Attenzione!", "La riga NON è nel documento scelto!")
		//20240214 aggiungo controllo se è in altro doc (è stato già fatto nella creazione da fabbisogno per quelle che ci sono
		//20250829 devo valorizzare ll_id_riga_bol sennò funziona poco e nulla....
		select top 1 id_riga_documento  into :ll_id_riga_bol from dba.riga_documento 
		where id_documento = :al_id_bollettina_doc order by num_riga;
		////20250829 fine
		select d.num_documento into :ls_test from riga_documento r, documento d where d.id_documento=r.id_documento 
		and r.provv_imp_subage_2=:ll_id_riga_bol and d.id_prof_documento=130 ; //2024 non escludo il presente doc perché so già che non c'è altrimenti non saremmo qui...
		if ls_test> " " then 
			li_ret=messagebox("Attenzione!", "La riga appartiene già al doc. n. "+ls_test+"! Vuoi INTERROMPERE l'inserimento?", stopsign!,  yesno!)
			if li_ret=1 and not isnull(li_ret) then 	
				close(w_bil)  // se commentata da rimettere a posto!!!!!!!!!!!!
				RETURN
			end if
		END IF
		ls_num_bol=right(dw_8.getitemstring(1, "num_documento"), 7)
		LL_nuova_RIGA=wf_agg_a_doc_esistente(ls_num_bol)
		dw_4.setitem(LL_nuova_RIGA, "peso_netto", ld_peso_netto)
		wf_agg_fino_calo(ld_peso_netto, LL_nuova_RIGA) //20250723 c'erà ll_riga_trovata....
	end if	
else
	//wf_agg_fino_calo(ld_peso_netto, ll_riga_trovata)  //20250429 io lo farei comunque, che male può fare??? meglio di no...
	wf_agg_fino_calo(ld_peso_netto, ll_riga_trovata)  //20250724
end if

if ld_peso_netto=0 or isnull(ld_peso_netto) then 
	dw_3.setfocus()
	dw_3.setcolumn("cod_barre")
end if
if ll_id_prof=130 or is_bur_domani='S' then dw_4.trigger event ue_update()
close(w_bil)  // se commentata da rimettere a posto!!!!!!!!!!!!
end subroutine

public function string wf_corretto_nonpiu_blocco (long al_id_art, string as_tipo, string as_flag);string ls_corretto, ls_non_segnare_piu, ls_blocco_assoluto, ls_ret

//20230628 per gestire i controlli da tabella art_senza_spazzolatura
//20231108 se è "S" prende anche gli "E" e viceversa
if as_tipo="S" or as_tipo="E" then
	select corretto, non_segnare_piu, blocco_assoluto into :ls_corretto, :ls_non_segnare_piu, :ls_blocco_assoluto from dba.art_senza_spazzolatura
	where id_articolo=:al_id_art and (tipo='S' or tipo='E');
else
	select corretto, non_segnare_piu, blocco_assoluto into :ls_corretto, :ls_non_segnare_piu, :ls_blocco_assoluto from dba.art_senza_spazzolatura
	where id_articolo=:al_id_art and tipo=:as_tipo;
end if

if as_flag="B" then
	ls_ret=ls_blocco_assoluto //blocco assoluto
else
	if ls_corretto="S" then ls_ret="S" //già corretto
	if ls_non_segnare_piu="S" then ls_ret+="S" //non segnare più
end if


return ls_ret
end function

public subroutine wf_controlla_galv_l (long al_riga);decimal ldc_peso_medio
integer li_pezzi
long ll_id_galv

ll_id_galv=dw_2.getitemnumber(al_riga, "id_gruppo_agenti_2")
ldc_peso_medio=dw_2.getitemdecimal(al_riga, "peso_netto")
li_pezzi=dw_2.getitemdecimal(al_riga, "quantita")
if ldc_peso_medio>0 and li_pezzi>0 then 
	ldc_peso_medio=ldc_peso_medio / li_pezzi
	if ll_id_galv=42 and ldc_peso_medio<=5.1 then 
		dw_2.setitem(al_riga, "id_gruppo_agenti_2", 52) //L1
	elseif  ll_id_galv=52 and ldc_peso_medio>5.1 then
		dw_2.setitem(al_riga, "id_gruppo_agenti_2", 42) //L
	end if
END IF
end subroutine

public subroutine wf_ges_lacci_fili (string as_tipo, decimal ai_num_lacci_fili);date ldt_data_doc
decimal ldc_peso_lacci, ldc_peso_stornato, ldc_null
long ll_id_prof, ll_id_riga_bol,ll_riga_trovata
string  ls_num_bol, ls_test
setnull(ldc_null)

ldt_data_doc=dw_3.getitemdate(1, "doc_data")

ll_id_prof=dw_3.getitemnumber(1,"id_prof_destinazione")
if ai_num_lacci_fili>0 then
	if (as_tipo="L" or as_tipo="F") then
		ldc_peso_lacci=f_rec_prezzo_laccio_filo_rame( as_tipo, ldt_data_doc)
		ldc_peso_lacci *=ai_num_lacci_fili
	else //as_tipo="T" tara
		ldc_peso_lacci=ai_num_lacci_fili
	end if
end if
	ls_num_bol=dw_8.getitemstring(1, "num_documento")
if ll_id_prof=130 or  ll_id_prof=196 or  ll_id_prof=184   then   
	if ll_id_prof=130 then
		ls_test="num_bollettina='"+ls_num_bol+"'"
		ll_riga_trovata=dw_4.find(ls_test, 1, dw_4.rowcount())
		if as_tipo="L" then
			dw_4.setitem(ll_riga_trovata, "provv_imp_carea_2", ai_num_lacci_fili)
		elseif as_tipo="F" then
			dw_4.setitem(ll_riga_trovata, "provv_imp_agente_2", ai_num_lacci_fili)
		else //è la tara
			dw_4.setitem(ll_riga_trovata, "peso_lordo", ai_num_lacci_fili)
		end if
		ldc_peso_stornato=wf_storna_legato(ldc_peso_lacci)
		if ldc_peso_stornato>0 then dw_4.setitem(ll_riga_trovata, "peso_netto", ldc_peso_stornato)
		wf_agg_fino_calo(ldc_peso_stornato, dw_4.rowcount())
		dw_4.trigger event ue_update()
		wf_colora_riga_lavorata(ll_riga_trovata)
	else //buratto o laser
		ls_test="num_documento='"+ls_num_bol+"'"
		ll_riga_trovata=dw_8.find(ls_test, 1, dw_8.rowcount())
		if as_tipo='L' then
			dw_2.setitem(dw_2.rowcount(), "provv_imp_carea_2", ai_num_lacci_fili)
		elseif  as_tipo='F' then
			dw_2.setitem(dw_2.rowcount(), "provv_imp_agente_2", ai_num_lacci_fili)
		else //è la tara "T"
			dw_2.setitem(ll_riga_trovata, "peso_lordo", ai_num_lacci_fili)
		end if
		wf_storna_legato(ldc_peso_lacci)
		wf_agg_fino_calo(ldc_peso_stornato, dw_2.rowcount())
	end if
else
	if ai_num_lacci_fili>0 and (as_tipo='L' or as_tipo='F') then
		ldc_peso_lacci=f_rec_prezzo_laccio_filo_rame( as_tipo, ldt_data_doc)
		ldc_peso_lacci *=ai_num_lacci_fili
		if as_tipo='L' then
			dw_2.setitem(dw_2.rowcount(), "provv_imp_carea_2", ai_num_lacci_fili)
		else // as_tipo='F' 
			dw_2.setitem(dw_2.rowcount(), "provv_imp_agente_2", ai_num_lacci_fili)
		end if
	end if
	wf_storna_legato(ldc_peso_lacci)
end if
end subroutine

public function decimal wf_storna_legato (decimal adc_peso_da_stornare);decimal ldc_legato

ldc_legato=dw_3.getitemdecimal(1, "legato")
if isnull(ldc_legato) then ldc_legato=0
if ldc_legato - adc_peso_da_stornare<=0 then
	//messagebox("Attenzione!" , "Peso minore di 0!!!") //commento perché blocca il lavoro... metto legato=0 e zitto 20220728
	ldc_legato=0
else
	ldc_legato -=adc_peso_da_stornare
end if
dw_3.setitem(1, "legato", ldc_legato)
dw_2.setitem(dw_2.rowcount(), "peso_netto", ldc_legato)
dw_8.setitem(1, "peso_netto", ldc_legato)
if cbx_1.checked then
	wf_agg_fino_calo(ldc_legato, dw_4.getrow())
else
	wf_agg_fino_calo(ldc_legato, dw_2.rowcount())
end if

return ldc_legato

end function

public subroutine wf_controllo_peso_doppio (long al_riga_trovata, decimal adc_peso_netto);//20240430 controllo Sara: se c'è stesso articolo con più pesi avvertimi
long ll_id_art_corrente, ll_id_art_precedente, ll_riga_doppia
decimal ldc_peso
integer i=1, li_num_questa_riga

if al_riga_trovata>1  then
	if adc_peso_netto>0 then
		ll_id_art_corrente=dw_4.getitemnumber(al_riga_trovata, "id_articolo")
		ll_id_art_precedente=dw_4.getitemnumber(al_riga_trovata - 1, "id_articolo")
		do while ll_id_art_corrente=ll_id_art_precedente
			ldc_peso=dw_4.getitemdecimal(al_riga_trovata - i, "PESO_NETTO")
			if ldc_peso>0 then
				messagebox("Attenzione!", "Esiste già un PESO per lo STESSO ARTICOLO!!!")
				exit
			end if
			ldc_peso=0
			i++
			if i>= al_riga_trovata then exit
			ll_id_art_precedente=dw_4.getitemnumber(al_riga_trovata - i, "id_articolo")		
		loop
		//20250812 ma se lo stesso identico peso è stato messo anche ad un'altra riga, dimmelo lo stesso!!!
//		li_num_questa_riga=dw_4.getitemnumber(al_riga_trovata, "num_riga")
//		ll_riga_doppia=dw_4.find("peso_netto="+string(adc_peso_netto) +" and num_riga<>"+string(li_num_questa_riga), 1, 9999999)
//		if ll_riga_doppia>0 then
//			messagebox("Attenzione!", "La riga n. "+string(ll_riga_doppia)+" ha lo stesso peso di quella attuale!!!")
//		end if
		//fine 20240430
	end if
end if

end subroutine

public subroutine wf_giorno_rientro_silver (long al_riga_dw_8, long al_riga_dw_4);
end subroutine

public subroutine wf_colora_riga_lavorata (long al_riga_lavorata);


dw_4.setitem(al_riga_lavorata, "c_lavorata", "S")
end subroutine

public function integer wf_salva_giorno_rientro_silver (long al_riga_corrente, string as_grs);	string ls_num_bollettina, ls_test,ls_giorno_rientro
	long ll_new_riga_doc, ll_riga_trovata, ll_id_riga_bollettina
	
	
	ls_num_bollettina=dw_8.getitemstring(al_riga_corrente, "num_documento")
	ls_test="num_bollettina='"+ls_num_bollettina+"'"
	ll_riga_trovata=dw_4.find(ls_test, 1, dw_4.rowcount())
	ll_new_riga_doc=dw_4.getitemnumber(ll_riga_trovata, "id_riga_documento") //20240917 da correggere subito testanto la riga trovata (può non esserci20240919, ma anche no....

	select id_riga_documento into :ll_id_riga_bollettina from dba.riga_documento r, documento d 
	where r.id_documento=d.id_documento and  
	d.num_documento=:ls_num_bollettina and r.num_riga=1;
	
	ls_giorno_rientro=dw_8.getitemstring(al_riga_corrente, as_grs)

	if ls_giorno_rientro>" "  then
		//20240917 salvo, se ci sono, il giorno_rientro_SILVER nella riga_documento_2 (campo giorno_rientro_silver)
		if ls_giorno_rientro="0" then ls_giorno_rientro=""
		dw_4.setitem(ll_riga_trovata, "giorno_rientro_silver", ls_giorno_rientro)
		update dba.riga_documento_2 set giorno_rientro_silver= :ls_giorno_rientro where id_riga_documento=:ll_id_riga_bollettina;
		if sqlca.sqlnrows>0 then
			commit;
		else
			rollback;
			insert into  dba.riga_documento_2 (id_riga_documento, giorno_rientro_silver)
			values (:ll_id_riga_bollettina, :ls_giorno_rientro) ;
			if sqlca.sqlnrows>0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Riga "+string(al_riga_corrente)+" NON salvato collegamento giorno_rientro_silver!")
				return 0
			end if
		end if
		
	END IF

return 1

end function

public function long wf_agg_a_doc_esistente (string as_data);string ls_num_doc,ls_num_bollettina,ls_bol_corretta
long ll_id_bollettina,ll_riga_trovata, ll_riga_inserita,ll_doc_scelto,ll_id_doc,ll_riga_bollettina,ll_id_riga_bollettina, ll_null
long ll_id_prof,ll_id_caus_magazzino
integer li_num_riga, li_ret
dwitemstatus l_dw_status
datastore ds_riga_da_copiare

setnull(ll_null)

ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
ls_num_doc=as_data
select id_documento, num_documento
into :ll_id_bollettina, :ls_num_bollettina
from dba.documento d, dba.prof_documento p
where right(num_documento, 7)=:ls_num_doc
and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL' or  p.codice='BOLCLIEN') 
and d.id_prof_documento=p.id_prof_documento
;
SELECT first(ordinato_fo) into :ls_bol_corretta from dba.riga_documento where id_documento=:ll_id_bollettina;
if ls_bol_corretta='S' then
	messagebox("Attenzione!", "Bollettina n. "+ls_num_bollettina+" già corretta: NON è più possibile inviarla ad alcuna lavorazione!!!!")
	return 0
end if
if ll_id_bollettina>0 then
	ll_riga_trovata=dw_4.find("num_bollettina='"+ls_num_bollettina+"'", 1, 9000000)
	if ll_riga_trovata>0 then
		messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento! Riga n. "+string(ll_riga_trovata))
	else
		//inserisco la bollettina nelle righe del doc scelto
		ll_doc_scelto=dw_7.find("c_scegli=1", 1, 9999999)
		if ll_doc_scelto>0 then
			ll_id_doc=dw_7.getitemnumber(ll_doc_scelto, "id_documento")
			//carico datastore con la riga da copiare
			ds_riga_da_copiare=create datastore
			if ll_id_prof=184 or  ll_id_prof=130  then 
				ds_riga_da_copiare.dataobject="d_doc_riga_sald_ra"
			else
				return 0
			end if
			ds_riga_da_copiare.settransobject(sqlca)
			ll_riga_bollettina=ds_riga_da_copiare.retrieve(ll_id_bollettina)
			if ll_riga_bollettina= 1 then
				li_ret=ds_riga_da_copiare.rowscopy(1, 1, primary!, dw_4, dw_4.rowcount()+1, primary!)
				if li_ret=1 then
					ll_riga_inserita=dw_4.find("id_documento="+string(ll_id_bollettina), 1, 9999999)  //20250721 a volte metto il peso nella riga errata, quella successiva...
					if isnull(ll_riga_inserita) or ll_riga_inserita=0 then 	ll_riga_inserita=dw_4.rowcount() //20250721 non si sa mai....no, è da togliere , ma per non saper leggere né scrivere...
					dw_4.scrolltorow(ll_riga_inserita)
					dw_4.setitem(ll_riga_inserita, "c_lavorata", "I")
					//20250827 c'è l'articolo A+ che non prendo e mi frega nel conteggio
					SELECT COALESCE(MAX(num_riga), 0) + 1 into :li_num_riga FROM riga_documento WHERE id_documento = :ll_id_doc;
					//li_num_riga=dw_4.getitemnumber(1, "c_max_num_riga")
					//20250812: è già aumentato di uno nella DW //li_num_riga++
					dw_4.setitem(ll_riga_inserita, "num_riga", li_num_riga)
					dw_4.setitem(ll_riga_inserita, "id_documento", ll_id_doc)
					ll_id_riga_bollettina=ds_riga_da_copiare.getitemnumber(1, "id_riga_documento")
					dw_4.setitem(ll_riga_inserita, "provv_imp_subage_2", ll_id_riga_bollettina)
					dw_4.setitem(ll_riga_inserita, "id_riga_documento", ll_null)
					dw_4.setitem(ll_riga_inserita, "num_bollettina",ls_num_bollettina )
					//20240904 a volte l'utente vuole inserire la riga: inserisco la causale sempre e comunque che NON metteva nel caso di aggiunta di riga... speriamo che basti
					select id_caus_magazzino_prop into :ll_id_caus_magazzino from dba.prof_documento where id_prof_documento=:ll_id_prof;
					dw_4.setitem(ll_riga_inserita, "riga_documento_id_caus_magazzino", ll_id_caus_magazzino)
				
				//	l_dw_status=dw_4.getitemstatus(ll_riga_inserita, 0, primary!)
					dw_4.trigger event ue_update()
					RETURN ll_riga_inserita
				else
					messagebox("Attenzione!","Riga NON copiata!")
				end if
			else
				messagebox("Attenzione!","MAH")
			end if
			destroy  ds_riga_da_copiare
		else
			messagebox("Attenzione!","NON hai SCELTO alcun documento!")
		end if
	end if			
end if
RETURN 0

			
end function

public subroutine wf_agg_data_ora_modfica ();long ll_id_riga
datetime ldt_data_ora
//20250721: salvo la data_ora_modifica in riga_doc_estensione

insert into riga_doc_estensione (id_riga_documento, data_ora_modifica)
values( :ll_id_riga, :ldt_data_ora);
if sqlca.sqlcode=1 then
	commit;
else
	rollback;
	
	messagebox("Attenznioen", "Data modifica riga NON salvata!")
end if
end subroutine

public subroutine wf_salva_data_ora (long al_id_riga, datetime adt_data_ora);
insert into dba.riga_doc_estensione ("id_riga_documento", "data_ora_modifica")
values (:al_id_riga, :adt_data_ora)
;
if sqlca.sqlcode=0 then
	commit;
else
	rollback;
	update dba.riga_doc_estensione
	set data_ora_modifica=:adt_data_ora
	where id_riga_documento=:al_id_riga;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		Messagebox("Attenzione!", "Data_ora di modifica NON salvata!")
	end if
end if
end subroutine

on w_rientro_galvanica.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_1=create cb_1
this.rb_2018=create rb_2018
this.rb_2019=create rb_2019
this.rb_2020=create rb_2020
this.rb_2021=create rb_2021
this.rb_2022=create rb_2022
this.cb_2=create cb_2
this.cb_st_doc=create cb_st_doc
this.cb_reset=create cb_reset
this.pb_spazzola=create pb_spazzola
this.cbx_controllo=create cbx_controllo
this.st_2=create st_2
this.pb_buratto=create pb_buratto
this.rr_1=create rr_1
this.pb_1=create pb_1
this.dw_5=create dw_5
this.dw_2=create dw_2
this.cbx_1=create cbx_1
this.cb_salva_cancellazione=create cb_salva_cancellazione
this.dw_8=create dw_8
this.st_3=create st_3
this.st_4=create st_4
this.cb_passa=create cb_passa
this.dw_7=create dw_7
this.dw_4=create dw_4
this.dw_9=create dw_9
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.cb_bur_sped=create cb_bur_sped
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.rb_2018
this.Control[iCurrent+5]=this.rb_2019
this.Control[iCurrent+6]=this.rb_2020
this.Control[iCurrent+7]=this.rb_2021
this.Control[iCurrent+8]=this.rb_2022
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.cb_st_doc
this.Control[iCurrent+11]=this.cb_reset
this.Control[iCurrent+12]=this.pb_spazzola
this.Control[iCurrent+13]=this.cbx_controllo
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.pb_buratto
this.Control[iCurrent+16]=this.rr_1
this.Control[iCurrent+17]=this.pb_1
this.Control[iCurrent+18]=this.dw_5
this.Control[iCurrent+19]=this.dw_2
this.Control[iCurrent+20]=this.cbx_1
this.Control[iCurrent+21]=this.cb_salva_cancellazione
this.Control[iCurrent+22]=this.dw_8
this.Control[iCurrent+23]=this.st_3
this.Control[iCurrent+24]=this.st_4
this.Control[iCurrent+25]=this.cb_passa
this.Control[iCurrent+26]=this.dw_7
this.Control[iCurrent+27]=this.dw_4
this.Control[iCurrent+28]=this.dw_9
this.Control[iCurrent+29]=this.st_5
this.Control[iCurrent+30]=this.st_6
this.Control[iCurrent+31]=this.st_7
this.Control[iCurrent+32]=this.cb_bur_sped
this.Control[iCurrent+33]=this.r_1
end on

on w_rientro_galvanica.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.rb_2018)
destroy(this.rb_2019)
destroy(this.rb_2020)
destroy(this.rb_2021)
destroy(this.rb_2022)
destroy(this.cb_2)
destroy(this.cb_st_doc)
destroy(this.cb_reset)
destroy(this.pb_spazzola)
destroy(this.cbx_controllo)
destroy(this.st_2)
destroy(this.pb_buratto)
destroy(this.rr_1)
destroy(this.pb_1)
destroy(this.dw_5)
destroy(this.dw_2)
destroy(this.cbx_1)
destroy(this.cb_salva_cancellazione)
destroy(this.dw_8)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_passa)
destroy(this.dw_7)
destroy(this.dw_4)
destroy(this.dw_9)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.cb_bur_sped)
destroy(this.r_1)
end on

event open;call super::open;s_list_main ls_list
long ll_id_prof, ll_null
integer li_ret
string ls_prof_id

setnull(ll_null)

dw_8.settransobject(sqlca)
dw_9.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_7.settransobject(sqlca)
dw_4.settransobject(sqlca)
//dw_5.settransobject(sqlca)
dw_5.insertrow(1)
dw_3.insertrow(1)

//dw_3.setitem(1, "da_data", relativedate(today(), - 30))

datawindowchild dwc_fornitori
 
li_ret= dw_3.GetChild('id_sog_com', dwc_fornitori)
 IF li_ret = -1 THEN MessageBox("Error", "Not a DataWindowChild")
CONNECT USING SQLCA;
dwc_fornitori.SetTransObject(SQLCA)
dwc_fornitori.Retrieve()
dwc_fornitori.setfilter("sog_commerciale_tipo='F'")
dwc_fornitori.filter()

ls_list=message.powerobjectparm
if ls_list.s_win_parametri="184@D" then  //20251024 Per Francesco Buratto di domani: chiamo come per il sald i buratti pronti oggi nei gg successivi (li ha preparati francesco ad hoc)
	is_bur_domani="S"
	ll_id_prof=1840000  //20251024 Per Francesco Buratto di domani
else
	ll_id_prof=long(ls_list.s_win_parametri)
end if

if ll_id_prof=1840000 then  //20251024 Per Francesco Buratto di domani
	ll_id_prof=184 //è sempre un buratto è la data che cambia
	title=upper("Invio Merce BUR. DOMANI")
	//20240913 cambio la dw e metto quella con il giorno della settimana
	dw_8.dataobject="d_ra_doc_sald_fo"
	dw_8.settransobject(sqlca)
	
	dw_3.setitem(1, "id_sog_com", ll_null) //20251024 questo va bene perché NON si fanno doc nuovi, si verificano quelli esistenti
	cb_passa.text="BUR.DOMANI"
	cb_passa.visible=false
	dw_3.modify("t_tara.visible=1")
	dw_3.modify("tara.visible=1")  //richiesta serena sara 15-01-24
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	//dw_3.modify("DataWindow.Detail.color="+string(rgb(200,224,230))) //bohhhh
	dw_7.visible=true
	dw_4.visible=true
	dw_3.modify("id_sog_com.visible=1")
	dw_7.dataobject="d_acc_buratto_da_fabbisogno"  //20251024 Per Francesco Buratto di domani
	dw_7.settransobject(sqlca)
	dw_7.retrieve(ll_id_prof)
	dw_5.visible=true
	cb_salva_cancellazione.visible=true

elseif ll_id_prof=184 then //buratto
	title=upper("Invio Merce al reparto Buratto")
	cb_bur_sped.visible=true //20251031 bur spedizione
	dw_3.setitem(1, "id_sog_com", 2049)  //reparto buratti
	cb_passa.text="A Burattare"
	dw_3.modify("t_tara.visible=1")
	dw_3.modify("tara.visible=1")  //richiesta serena sara 15-01-24
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	dw_7.retrieve(ll_id_prof)
	dw_3.modify("cod_barre_galvanica.visible=0") //20240118 NON serve nel buratto (riportare su tutti glialtri qua sotto?????)
	
	//pb_buratto.visible=true   ////20230828 stampa che mostra anche attesa secondo il paramentro passato
elseif ll_id_prof=196 then  //laser
	title=upper("Invio Merce al reparto LASER")
	dw_3.setitem(1, "id_sog_com", 2110) //RBGOLD
	cb_passa.text="A Laserare"
	dw_3.modify("t_tara.visible=1")
	dw_3.modify("tara.visible=1")
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	pb_spazzola.visible=true
	pb_buratto.visible=false
	dw_3.modify("DataWindow.Detail.color=8388352")  //verde
elseif ll_id_prof=203 or  ll_id_prof=228 then //spazzolare
	title=upper("Invio Merce al reparto Spazzolatura")
	cb_st_doc.visible=false
	if  ll_id_prof=203 then
		dw_3.setitem(1, "id_sog_com", 2146)  //reparto spazzolatura
	else
		dw_3.setitem(1, "id_sog_com", 2148)  // itre fratelli spazzolatura esterni
	end if
	cb_passa.text="A Spazzolare"
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	pb_spazzola.visible=true
	pb_buratto.visible=false
	dw_3.modify("DataWindow.Detail.color=65535") //gialla
elseif ll_id_prof=204 then //ripara
	dw_3.setitem(1, "id_sog_com", 2044)  //reparto riparazione 
	title=upper("Invio Merce al reparto Riparazione")
	cb_passa.text="A Riparare"
	dw_3.modify("t_tara.visible=1") //20251029: Elena chiede di vedere anche la tara...
	dw_3.modify("tara.visible=1")   //20251029: Elena chiede di vedere anche la tara...
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")   //dw colore grigio
	pb_buratto.visible=false
elseif ll_id_prof=224 then  //ceramico
	title=upper("Invio Merce al reparto Ceramico")
		dw_3.setitem(1, "id_sog_com", 2145) //reparto ceramico
	cb_passa.text="Al Ceramico"
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("DataWindow.Detail.color="+string(rgb(176,224,230))) //celeste
elseif ll_id_prof=226 then  //mERCE IN ATTESA
	title=upper("Invio Merce al reparto Attesa")
//	pb_buratto.visible=true  //20230828 stampa che mostra anche attesa secondo il paramentro passato
	cb_passa.text="Manda In Attesa"
	dw_3.setitem(1, "id_sog_com", 2142) //reparto attesa
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	dw_3.modify("DataWindow.Detail.color='#FF7F50'") //ross0
elseif ll_id_prof=130 then  //sald
	title=upper("Invio Merce SALD")
	//20240913 cambio la dw e metto quella con il giorno della settimana
	dw_8.dataobject="d_ra_doc_sald_fo"
	dw_8.settransobject(sqlca)
	
	dw_3.setitem(1, "id_sog_com", ll_null)
	cb_passa.text="SALD"
	cb_passa.visible=false
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	dw_3.modify("t_tara.visible=1")
	dw_3.modify("tara.visible=1")
	dw_3.modify("DataWindow.Detail.color="+string(rgb(200,224,230))) //bohhhh
	dw_7.visible=true
	dw_4.visible=true
	dw_3.modify("id_sog_com.visible=1")
	dw_7.retrieve(ll_id_prof)
	dw_5.visible=true
	cb_salva_cancellazione.visible=true
end if
if ll_id_prof>0 then dw_3.setitem(1, "id_prof_destinazione", ll_id_prof)

end event

event ue_postopen;call super::ue_postopen;dw_3.post setfocus()
dw_3.post setcolumn("cod_barre")
end event

type st_1 from w_001`st_1 within w_rientro_galvanica
end type

type dw_1 from udw_base within w_rientro_galvanica
boolean visible = false
integer x = 73
integer y = 1772
integer width = 3749
boolean bringtotop = true
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
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

type dw_3 from udw_base within w_rientro_galvanica
integer x = 55
integer y = 28
integer width = 4110
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_rientro_galvanica"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;string ls_num_doc, ls_num_bollettina, ls_test,ls_galv,ls_lav, ls_tipo, ls_ret, ls_bol_corretta, ls_g_settimana
long ll_num_prog, ll_id_bollettina, ll_id_test, ll_righe, ll_id_doc,ll_riga,ll_id_galv, ll_null, ll_id_prof, ll_id_riga_bol, ll_id_intestatario, ll_id_art,ll_id_uc
decimal ldc_prezzo, ldc_prezzo_da_Data1, ldc_legato
date ldt_data, ldt_g_settimana,ldt_data_sped
string ls_cliente, LS_DES_2
long ll_id_int_sald, ll_riga_trovata1, ll_riga_dw_2

setnull(ll_null)
if dwo.name="cod_barre"  then
	if len(data)=7   then
		//20250903 se siamo nella galvanica per prima cosa resetto campo cod_galvanica
		ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
		if ll_id_prof=170 then
			setitem(1, "cod_barre_galvanica", "")
		end if
		//20250903 fine
		 //20230920 prima di tutto vediamo se è già presente nella lista attuale (dw_8)
		ll_id_test=dw_8.find("c_solo_bol ='"+data+"'", 1, 1000000)
		if ll_id_test>0 then 
			messagebox("Attenzione!", "Bollettina n. "+data+" già INSERITA!!")
			return
		end if
		  //20230920 fine
		dw_3.setitem(1, "n_lacci", ll_null)
		dw_3.setitem(1, "n_fili", ll_null)
		dw_3.setitem(1, "legato", ll_null)
		//da cambiare subito!!!
		if rb_2021.checked then
			li_anno=2021
		elseif	rb_2022.checked then
			li_anno=2022
		elseif	rb_2020.checked then
			li_anno=2020
		elseif rb_2019.checked then
			li_anno=2019
		elseif rb_2018.checked then
			li_anno=2018
		end if
		
		if li_anno>=2022 then  //in realtà è solo uguale (nel 2022 siamo passati ai 7 caratteri e abbiamo un codice bollettina univoco, quindi gli anni successivi NON esistono a finestra)
			ls_num_doc=data
			ll_num_prog=long(ls_num_doc)
			//ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione") //20250903 spostato prima riga su sopra
			
			ll_id_intestatario=dw_3.getitemnumber(1, "id_sog_com") //20250707 spostato da più sotto, dovrebbe funzionare lo stesso
			if isnull(ll_id_intestatario) and  ll_id_prof<>130 and (isnull(is_bur_domani) or is_bur_domani<>'S') then   //20250707 controllo... ma nel sald prendo l'intestatario dal doc ...
				messagebox("Attenzione!", "L'intestatario del documento DEVE essere inserito!!")  //20251024 sopra:  (isnull(ls_domani) or ls_domani<>'S') NON deve scattare se bur domai
				return
			end if
			//20250707 fine
			select id_documento, num_documento
			into :ll_id_bollettina, :ls_num_bollettina
			from dba.documento d, dba.prof_documento p
			where right(num_documento, 7)=:ls_num_doc
			and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL' or  p.codice='BOLCLIEN' or p.codice='GBOL') 
			and d.id_prof_documento=p.id_prof_documento
			;
			//SELECT first(ordinato_fo) into :ls_bol_corretta from dba.riga_documento where id_documento=:ll_id_bollettina;
			//20250721: le bol hanno sempre una sola riga con il numero =1
			SELECT ordinato_fo into :ls_bol_corretta from dba.riga_documento where id_documento=:ll_id_bollettina  and num_riga=1;
			//20250721 fine
			if ls_bol_corretta='S' then
				messagebox("Attenzione!", "Bollettina n. "+ls_num_bollettina+" già corretta: NON è più possibile inviarla ad alcuna lavorazione!!!!")
				return
			end if
			//20250707 controllo di chi è questa bollettina: Samy dice che c'è un sald con quesdta bollettina e il sald contiene il fornitore corretto... (potrebbero averla già sparata al fonritore sbagliato: è successo...)
			
			if ll_id_prof=130   then
				ll_id_int_sald=0
				select id_riga_documento into :ll_id_riga_bol from dba.riga_documento where id_documento=:ll_id_bollettina;
				select id_sog_commerciale into :ll_id_int_sald from dba.documento d, dba.riga_documento r
				  where r.id_documento=d.id_documento and provv_imp_subage_2=:ll_id_riga_bol and id_prof_documento=130;  //sald=130
				if ll_id_int_sald>0 then // se non lo trovo va bene tutto
					ll_riga_trovata1=dw_7.find("c_scegli=1", 1, 999999)
					ll_id_intestatario=dw_7.getitemnumber(ll_riga_trovata1, "id_sog_commerciale")
					if ll_id_int_sald<>ll_id_intestatario and (isnull(is_bur_domani) or is_bur_domani<>'S') then
						messagebox("Attenzione!", "L'intestatario del SALD NON è lo stesso che hai indicato nel documento attuale!")
						dw_3.setitem(1, "cod_barre", "")
						dw_3.setcolumn("cod_barre")
						return
					end if
				end if
			end if
			 //20230307 Samy: NON POSSONO più essere sparate due volte! Se è già stata sparata CON LO STESSO INTESTATARIO (è in un buratto) avverti e blocca
			
			if cbx_controllo.checked then
				// ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")  //20250707: sposto più sopra
				// ll_id_intestatario=dw_3.getitemnumber(1, "id_sog_com")  //20250707: sposto più sopra, mi serve per far sì che NON si carichino bollettine che non appartengono al fornitore
				//20240909 se è 184 o 204 mi serve l'id_riga
				if ll_id_prof=204 or  (ll_id_prof=184 and (isnull(is_bur_domani) or is_bur_domani<>'S')) then  //20251024 se è BUR DOMANI NON deve farlo
					select id_riga_documento into :ll_id_riga_bol from dba.riga_documento where id_documento=:ll_id_bollettina;
				//20240909: inserisco un controllo che impedisca la creazione di 2 riparazioni allo stesso fornitore nella stessa data
					if ll_id_prof=204 then  //è una riparazione
						select num_documento+'-'+string(data_documento)+'-'+string(num_riga) into :ls_test  from dba.documento d, dba.riga_documento r 
						where provv_imp_subage_2=:ll_id_riga_bol and r.id_documento=d.id_documento and d.id_prof_documento=:ll_id_prof and id_sog_commerciale=:ll_id_intestatario
						and data_documento=today(); 
						if ls_test>" " then
							messagebox("Attenzione!", "Bollettina già riparata: "+ls_test)
							return
						end if
					end if
					//20240909 fine
					 if ll_id_prof=184 then  //è un buratto
						select num_documento+'-'+string(data_documento)+'-'+string(num_riga) into :ls_test  from dba.documento d, dba.riga_documento r 
						where provv_imp_subage_2=:ll_id_riga_bol and r.id_documento=d.id_documento and d.id_prof_documento=184 and id_sog_commerciale=:ll_id_intestatario; //aggiutno intestatario 20230328 su richiesta della Samy
					end if
				end if
				if ls_test>"  " then 
					messagebox("Attenzione!", "Bollettina scaricata in doc: "+ls_test)
					return
				end if
			end if
			 //20230113 agg samy per blollettine cllienti diversi
		else
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
		end if

		if ll_id_bollettina>0 then
			select id_unita_confezione into :ll_id_uc from dba.riga_documento where id_documento=:ll_id_bollettina and num_riga=1;
			select des_2 into :ls_des_2 from dba.prezzo where id_unita_confezione= :ll_id_uc and id_variazione=15;
			//20240417 SE è buratto(184) e C'è NEll'art. il k55 (variaizone karizia =15 campo des ricerca uc e poi su prezzo des_2 fai un pos()>0)
			if ll_id_prof=184 then
			//	select id_unita_confezione into :ll_id_uc from dba.riga_documento where id_documento=:ll_id_bollettina and num_riga=1;  // 20250625 spostata sopra che mi serve anche più giù
				if ll_id_uc>0 then
					//select des_2 into :ls_des_2 from dba.prezzo where id_unita_confezione= :ll_id_uc and id_variazione=15;  // 20250625 spostata sopra che mi serve anche più giù
					if pos(upper(ls_des_2), "K55")>0 then messagebox("ATTENZIONE!!!", "LA BOLLETTINA "+ls_num_bollettina+" CONTIENE K55, DEVE ESSERE LASERATO!!!!")
				end if
				//20251031: Francesco chiede che, in base a ciò che è caricato in bur_spedizione, se la bolelttina è lì mostri in messagebox lòa data spedizione
				select data_spedizione into :ldt_data_sped from dba.bur_spedizione where bollettina=:ls_num_doc;
				if ldt_data_sped> date("2025/01/01") then
					messagebox("Attenzione!", "La bollettina: "+ls_num_doc +" ha data spedizione: "+string(ldt_data_sped, "dd/mm/yy"))
				end if
			end if
			//20230628 controllo se l'articolo è bloccato se lo fosse mmi fermo qui
			select id_articolo into :ll_id_art from documento d , riga_documento r where r.id_documento=d.id_documento and d.num_documento= :ls_num_bollettina
			;
			if ll_id_prof=203 then ls_tipo="S"
			if ll_id_prof=196 then ls_tipo="L"
			if ll_id_prof=228 then ls_tipo="E"  //20231108
			ls_ret=wf_corretto_nonpiu_blocco(ll_id_art, ls_tipo, "B" )
			if ls_ret="S" then //è bloccato assolutamente mi fermo e NON lo inserisco
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" BLOCCATA!!!")
				dw_3.setitem(1, "cod_barre", "")
				return 0
			end if
			//20230628 controllo fine
			
			ls_test="id_documento="+string(ll_id_bollettina)
			ll_id_test=dw_8.find(ls_test, 1, dw_1.rowcount())
			if ll_id_test>0 then
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
			else
				
				dw_8.retrieve(ll_id_bollettina)
				ll_id_test=dw_8.find(ls_test, 1, dw_8.rowcount())
				dw_8.setitem(ll_id_test, "sog_commerciale_gen_codice", "")
				//20250625 se c'è K55 segno da_laserare o k56-59-60 da_spoazzolare
				if  ll_id_prof<>130 and (isnull(is_bur_domani) or is_bur_domani<>'S') then
					if pos(upper(ls_des_2), "K55")>0 then
						dw_8.setitem(ll_id_test, "da_laserare", 1)
					end if 
					if pos(upper(ls_des_2), "K56")>0 or pos(upper(ls_des_2), "K59")>0 or pos(upper(ls_des_2), "K60")>0 then
						dw_8.setitem(ll_id_test, "da_spazzolare", 1)
					end if 
				end if
				//20250625 fine
				
				//20230920 inserisco per poter ordinare in modo da avere in cima sempre l'ultima insierita
				dw_8.setitem(ll_id_test, "c_num_riga", dw_8.rowcount())
				dw_8.sort()
				//20230920 fine
				dw_3.setitem(1, "cod_barre", "")
				dw_3.setfocus()
				dw_3.setcolumn("cod_barre")
				//20230912 Samy dice che ci vuole il giorno della settimana per gestire le spedizioni (a volte la spedizioine NON è precisa e slitta a secondo del giorno di consegna
				ls_g_settimana= f_cliente_giorno(ls_num_bollettina)
				//20250623 modificato ritorno ora il giorno se è anticipato ha una "X" alla fine (ultima lettera)
				if right(ls_g_settimana, 1)="X" then
					//ls_g_settimana=left(ls_g_settimana, len(ls_g_settimana) - 1)
					//ora segno che è anticipato così poi posso colorare un campo per segnalarlo
					dw_8.setitem(ll_id_test, "imp_avanzo_acconto", 1)
				end if
				//ls_g_settimana=f_g_settimana(ldt_g_settimana)
				if isnull(ls_g_settimana) or ls_g_settimana="" then ls_g_settimana="-"
				dw_8.setitem(ll_id_test, "des_contabile", ls_g_settimana)
				//20230912 fine
				ll_righe=dw_2.retrieve(ll_id_bollettina)
				//20250721 è un po' traballante il rowcount() per individuare la riga inserita, meglio ricercarla...
				ll_riga_dw_2=dw_2.find("id_documento="+string(ll_id_bollettina), 1, 9999999)
				//20220928 annullo anche fili, lacci e tara...
				dw_2.setitem(ll_riga_dw_2, "provv_imp_carea_2", ll_null)  //cambio: 20250724: non prendo più l'ultima riga, ma la riga che ha id_documento=a quello del retrieve()
				dw_2.setitem(ll_riga_dw_2, "provv_imp_agente_2", ll_null)
				dw_2.setitem(ll_riga_dw_2, "peso_lordo", ll_null)
				//20220928 fine
				dw_2.setitem(ll_riga_dw_2, "provv_imp_subage_2", dec(ls_num_doc))  //20240205 per collegare la riga dw_8 a dw_2 (metto num_bol in provv_subage_2, magari alla fine lo cancello)
				
				//wf_bilancia(dw_2.rowcount(), ll_id_bollettina) 
				wf_bilancia(ll_riga_dw_2, ll_id_bollettina)
				
				wf_controlla_galv_L(ll_riga_dw_2)  //20231108
				
				if cb_passa.text="Manda in Galv" then
					setcolumn("cod_barre_galvanica")
				elseif  ll_id_prof=130 then //20240911 Francesco chiede che nel sald vada tara-lacci-filo e torni su cod_barre  20240919 Sara vuole cursore nei lacci!!!
					post setcolumn("n_lacci")
				else
					ldc_legato=getitemdecimal(row,"legato")
					////ldc_legato=120 //da togliere immediatamente!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
					if ldc_legato>0 then
//						if dw_3.describe("tara.visible")="1" and ll_id_prof=130 then
//							post setcolumn("n_lacci")  //post setcolumn("tara") //20240202 deve andare su lacci perché di tare ce ne sono poche
//						else
//							post setcolumn("n_lacci")
//						end if
						post setcolumn("n_lacci")  //20240213 a questo punto .... inutile fare l'if la tara è invisibile nel caso...
					else
						post setcolumn("cod_barre")  //torna all'inizio
					end if
				end if
			end if
			//wf_controlla_doppio_peso()
		else
			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
		end if
	end if
end if

if dwo.name="cod_barre_galvanica"  then
	if len(data)=13   then
		//ll_riga=dw_2.rowcount()
		ll_id_doc=dw_8.getitemnumber(1, "id_documento") //bisogna trovare di meglio ...
		ll_riga=dw_2.find("id_documento="+string(ll_id_doc), 1, 999999)
		//
		ls_galv=left(data, 12)
		ls_galv=right(ls_galv, 5)
		//20240417 se galv=tutto quello sotto manda messaggio Serena
//		if ll_id_prof=184 then  //RIMANDATO PERCHè NON ABBIAMO CODICI GALV DELLA KARIZIA
//			
//			if ls_galv="X" or  ls_galv="RTE" or ls_galv="A" or ls_galv="P" or ls_galv="X" or ls_galv="X" or ls_galv="X" or ls_galv="X" then
//				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" NO GALVANICA!!!" )
//			end if
//		end if  //20240417 FINE
		ll_id_galv=long(ls_galv)
		ldt_data=dw_3.getitemdate(1, "doc_data")
		ls_galv=""
		select lavorazione, descrizione
		into :ls_lav, :ls_galv
		from dba.galvanica
		where id_galvanica=:ll_id_galv
		and (provvisorio is null or provvisorio=0) //20251013 per ora i provvisorio sono esclusi dalla procedura
		;
		ldc_prezzo=f_rec_prezzo_galvanica(ldt_data, ll_id_galv)
//		ldt_data=dw_3.getitemdate(1, "doc_data")
//		if ldt_data> date("2000-01-01") then
//			if ldt_data>= date("2019-06-01") then
//				 ldc_prezzo=ldc_prezzo_da_Data1
//			end if
//		else
//			messagebox("Attenzione!", "Inserire Data Doc Destinazione!")
//		end if

		dw_2.setitem(ll_riga, "prezzo_metallo",ldc_prezzo)
		dw_2.setitem(ll_riga, "id_gruppo_agenti_2",ll_id_galv)
		ls_test=dw_2.getitemstring(ll_riga, "descrizione")
		if ls_test> " " then
			ls_galv=ls_test+"  __ "+ls_galv
		end if
		dw_2.setitem(ll_riga, "descrizione", ls_galv)
		dw_3.setitem(1, "cod_barre", "")
		dw_3.setitem(1, "cod_barre_galvanica", "")
		//prima c'erà 1 invece di rowcopuint
		dw_8.setitem(1, "sog_commerciale_gen_codice", ls_lav)  //speriamo vada bene 1 ....
		dw_3.setfocus()
		dw_3.setcolumn("cod_barre")
	end if
	
	
end if
end event

event itemchanged;call super::itemchanged;date ldt_data_doc
//integer  li_num_lacci_fili
decimal ldc_peso_netto, ldc_tara, li_num_lacci_fili, ldc_null,ldc_prezzo
long ll_id_prof, ll_id_doc, ll_riga, ll_id_galv
string ls_lav, ls_des_galv,ls_test
setnull(ldc_null)

ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
choose case dwo.name
		
	case "n_lacci"
		li_num_lacci_fili= integer(data)
		if li_num_lacci_fili>0 and li_num_lacci_fili<200 then  //aggiungo <200 perché, a volte, capita che sparino la bollettina su questo campo... (es: 1845787) che poi rimane lì...
			wf_ges_lacci_fili("L", li_num_lacci_fili)
		end if
		post setcolumn("n_fili")
	case "n_fili"
		li_num_lacci_fili= integer(data)
		if li_num_lacci_fili>0 and li_num_lacci_fili<200 then  //aggiungo <200 perché, a volte, capita che sparino la bollettina su questo campo... (es: 1845787) che poi rimane lì...
			wf_ges_lacci_fili("F", li_num_lacci_fili)
		end if
		post setfocus()
		dw_3.post setitem(1, "tara", ldc_null)
		dw_3.post setitem(1, "n_fili", ldc_null)
		dw_3.post setitem(1, "n_lacci", ldc_null)
		dw_3.post setitem(1, "legato", ldc_null)
		post setcolumn("cod_barre")
		
	case "tara"
		ldc_tara=dec(data)
		wf_ges_lacci_fili("T", ldc_tara)
		
		
			post setfocus()
			post setcolumn("n_lacci")
		
	case "legato"
		ldc_peso_netto=dec(data)
		if ldc_peso_netto> 0 then
			dw_3.setitem(1, "legato", ldc_peso_netto)
			dw_2.setitem( dw_2.rowcount(), "peso_netto", ldc_peso_netto)
			wf_agg_fino_calo(ldc_peso_netto, dw_2.rowcount())
			post setfocus()
			post setcolumn("n_lacci")
			wf_controlla_galv_L(dw_2.rowcount())  //20231108
			
		end if
	case "cod_barre_galvanica"   //20250903 era in editchanged: ma il codice è variabile, quindi devo aspettare la conferma (tab) dell'operatore, almeno finché non trovo qualcosa di meglio: controllo carattere finale??? CR)
		//ll_riga=dw_2.rowcount()
		ll_id_doc=dw_8.getitemnumber(1, "id_documento") //bisogna trovare di meglio ...
		ll_riga=dw_2.find("id_documento="+string(ll_id_doc), 1, 999999)
		ls_lav=""
		ls_lav=data
		select id_galvanica, descrizione into :ll_id_galv, :ls_des_galv from dba.galvanica where lavorazione=:ls_lav;
		
		ldt_data_doc=dw_3.getitemdate(1, "doc_data")
		
//		select lavorazione, descrizione
//		into :ls_lav, :ls_galv
//		from dba.galvanica
//		where id_galvanica=:ll_id_galv
//		;
		ldc_prezzo=f_rec_prezzo_galvanica(ldt_data_doc, ll_id_galv)
		dw_2.setitem(ll_riga, "prezzo_metallo",ldc_prezzo)
		dw_2.setitem(ll_riga, "id_gruppo_agenti_2",ll_id_galv)
		ls_test=dw_2.getitemstring(ll_riga, "descrizione")
		if ls_test> " " then
			ls_des_galv=ls_test+"  __ "+ls_des_galv
		end if
		dw_2.setitem(ll_riga, "descrizione", ls_des_galv)
		dw_3.setitem(1, "cod_barre", "")
		dw_3.setitem(1, "cod_barre_galvanica", "")
		//prima c'erà 1 invece di rowcopuint
		dw_8.setitem(1, "sog_commerciale_gen_codice", ls_lav)  //speriamo vada bene 1 ....
		dw_3.setfocus()
		dw_3.setcolumn("cod_barre")
		
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;//se è sui fili e batte tab che esce deve azzerare tutto e tornare sul cod barre 20240129
//da fare, ultima NON è gestita
long ll_id_prof

ll_id_prof= dw_3.getitemnumber(1, "id_prof_destinazione")

if string(dwo.name)="n_fili" and ll_id_prof=130 then //20240911 SOLO per sald, per ora
	setfocus()
	dw_3.setitem(1, "tara", 0)  //20250220 azzero la tara quando torno su cod_barre (richiesta Sara)
	setcolumn("cod_barre")
end if
if  is_ultima_colonna="cod_barre_galvanica" then
	if ll_id_prof=204 then
		dw_3.post setcolumn("tara")
	else
		dw_3.post setcolumn("cod_barre")
	end if
elseif is_ultima_colonna="tara" then
	dw_3.post setcolumn("n_lacci")
elseif  is_ultima_colonna="n_fili"  and  ll_id_prof=204 then
	setfocus()
	dw_3.setcolumn("cod_barre")
end if

is_ultima_colonna=string(dwo.name)

end event

type cb_1 from commandbutton within w_rientro_galvanica
integer x = 5998
integer y = 604
integer width = 398
integer height = 88
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

event clicked;string ls_nome_file
integer LI_RET


if dw_3.getitemnumber(1, "id_prof_destinazione")=130 then  //20241010 se è SALD deve creare il pdf

	dw_8.Modify("Export.PDF.Method = Distill!")
	dw_8.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	dw_8.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
	ls_nome_file="\\192.168.1.3\laboratorio\Pdfsald\sald_"+string(today(), "yyyy_mm_dd")+string(now(), "hh_mm")+".pdf"
	li_ret=dw_8.SaveAs(ls_nome_file, PDF!, FALSE)
	IF LI_RET<> 1 THEN
		messagebox("Errore!", "File PDF non generato!")	
	end if
end if

dw_9.print(true, true)
end event

type rb_2018 from radiobutton within w_rientro_galvanica
integer x = 6103
integer y = 1288
integer width = 242
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

type rb_2019 from radiobutton within w_rientro_galvanica
integer x = 6103
integer y = 1384
integer width = 242
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

type rb_2020 from radiobutton within w_rientro_galvanica
integer x = 6103
integer y = 1472
integer width = 242
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

type rb_2021 from radiobutton within w_rientro_galvanica
integer x = 6103
integer y = 1556
integer width = 242
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
end type

type rb_2022 from radiobutton within w_rientro_galvanica
integer x = 6103
integer y = 1644
integer width = 242
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
boolean checked = true
end type

type cb_2 from commandbutton within w_rientro_galvanica
integer x = 5998
integer y = 704
integer width = 398
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rivedi "
end type

event clicked;date ldt_data
long ll_id_prof

ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
ldt_data=dw_3.getitemdate(1, "doc_data")

dw_9.retrieve(ll_id_prof, ldt_data)
end event

type cb_st_doc from commandbutton within w_rientro_galvanica
integer x = 5970
integer y = 1760
integer width = 462
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "St. DDT"
end type

event clicked;//stampo il DDT creato (per ora impongo si crei un DDT alla volta, quindi quando stampo ce n'è soltanto uno) 20220901
long ll_id_prof_doc, ll_id_conf_oggetti, ll_job, ll_id_sog, ll_id_reg, ll_id_prof, ll_id_doc
string ls_nome_report,ls_cod_profilo, ls_path_libreria, dwsyntax, ls_ret, ls_printer, ls_ret2, ls_invia, ls_cod_azienda,ls_tipo_reg
integer li_retvalue, li_ret
uo_mail u_mail

ll_id_doc=dw_9.getitemnumber(1, "id_documento")

datastore ds_stampa

select codice into :ls_cod_azienda from azienda;

ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
ll_id_prof_doc=dw_3.getitemnumber(1, "id_prof_destinazione")

//spostato qui perchè Samy dal 20110920 vuole inviare anche prezzi per sald
select invia_mail_e_dati, mostra_prezzi
into :ls_invia, :ls_ret
from dba.sog_profilo_personalizza
where id_sog_commerciale=:ll_id_sog
and id_prof_documento=:ll_id_prof_doc
;
if  pos(upper(ls_cod_azienda), "SILVERDR")>0 then
	ds_stampa=create datastore
	if isnull(ll_id_prof_doc) then return
//	ib_askforsave=false
	//parent.TriggerEvent("ue_update")
	
	select nome_report
	into :ls_nome_report
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof_doc
	;
	
	select id_conf_oggetti, libreria
	into :ll_id_conf_oggetti, :ls_path_libreria
	from conf_oggetti
	where codice=:ls_nome_report;
	
//	ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
//	wf_rec_prezzi_silver(ll_id_prof, ls_cod_azienda, ls_tipo_reg, ll_id_sog)
//	if pos(ls_cod_azienda,"SILVERDR")>0  and ls_tipo_reg="DV" and  (ll_id_sog=43 or ll_id_sog=1862 )  then //deve partire il recupera prezzi per karizia ma anche per panna
//		tab_1.tabpage_2.cb_rec_prezzi.trigger event clicked()
//		idw_riga.Event ue_update(0,0)
//	end if

	
	if ll_id_conf_oggetti>0 then
		ll_job=printopen()
		dwsyntax = LibraryExport(ls_path_libreria, ls_nome_report, ExportDataWindow!)
		IF dwsyntax>"" THEN
			ds_stampa.create(dwsyntax)
			ds_stampa.settransobject(sqlca)
		else
			messagebox("Errore!", "Libreria o report non trovati: "+ls_path_libreria +"-"+ls_nome_report)
			printclose(ll_job)
			return
		end if
	end if
	li_ret=ds_stampa.retrieve(ll_id_doc)
	//non si vuole il prezzo! Samy 04-10-2017 da oggi 20210920 no, si guarda la tabella (vedi sopra all'inizio
	if ls_ret='S' then
		ls_ret2=ds_stampa.Modify("c_prezzo.visible=1")
		ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=1")
	else
		ls_ret2=ds_stampa.Modify("c_prezzo.visible=0")
		ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=0")
	end if
	//ls_ret2=ds_stampa.Modify("riga_documento_tot_riga_val_doc.visible=0")
	
	
	//fine prezzo
	
	ds_stampa.Modify("DataWindow.Print.copies = 2")
	
	
	//ls_cod_profilo=idw_gen.getitemstring(ll_row,"prof_documento_codice")
	//ls_num_doc=ds_documenti.getitemstring(ll_row,"documento_num_documento")
	//ldt_data_doc=ds_documenti.getitemdate(ll_row,"documento_data_documento")
	//ls_nome_file=ls_dir_export+ls_cod_profilo+ls_num_doc+".pdf"
					
	ls_ret2=ds_stampa.Modify("DataWindow.Print.documentName = 'RBOL'")
	
	ls_printer=ds_stampa.describe ('DataWindow.Printer')
		//ds_stampa.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
		
	
	if ls_ret2<>"" then 
		messagebox("Errore!", "Documento non stampato!")
	else
		printdatawindow(ll_job, ds_stampa)
	end if
	printclose(ll_job)				
end if
//questo lo fa anche per Panna... 09062020 spostato in cima 20110920

//select invia_mail_e_dati, mostra_prezzi
//into :ls_invia, :ls_ret
//from dba.sog_profilo_personalizza
//where id_sog_commerciale=:ll_id_sog
//and id_prof_documento=:ll_id_prof_doc
//;
if isnull(ls_ret) then ls_ret='N'
if ls_invia='S' then 
	u_mail.is_mail.s_testo="Inviata in automatico da Nita."
	u_mail.of_prepara_campi_mail(ll_id_doc)
	u_mail.of_allega_files(ll_id_doc, ls_ret )
	u_mail.of_crea_pdf(ll_id_doc, ls_ret, "N")
	u_mail.of_invia_mail("MAIL", ls_ret, true, true) //il primo è il codice della riga con i dati per inviare la mail, il secondo il "vedi prezzi", il terzo e il quarto per creare o no file di log e debug
end if








end event

type cb_reset from commandbutton within w_rientro_galvanica
integer x = 5970
integer y = 1884
integer width = 462
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
	dw_9.reset()
	dw_8.reset()
end if
end event

type pb_spazzola from picturebutton within w_rientro_galvanica
boolean visible = false
integer x = 6062
integer y = 2316
integer width = 279
integer height = 256
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\spazzola.jpeg"
alignment htextalign = left!
end type

event clicked;long ll_id_profilo
string ls_tipo

ll_id_profilo =dw_3.getitemnumber(1,  "id_prof_destinazione")
if ll_id_profilo =203 then ls_tipo="S"  //20230517 spazzolatura
if ll_id_profilo =196 then ls_tipo="L"  //20230517 laseratura
if ll_id_profilo =228 then ls_tipo="E"  //20231108 spazzolatura esterni
openwithparm(w_art_senza_spazzolatura,ls_tipo)

end event

type cbx_controllo from checkbox within w_rientro_galvanica
integer x = 6002
integer y = 376
integer width = 352
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
string text = "Controllo"
boolean checked = true
end type

type st_2 from statictext within w_rientro_galvanica
integer x = 5111
integer width = 613
integer height = 224
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16776960
string text = "In questa finestra la dicitura RSPAZ e RLASER viene inserita solo se l~'articolo non la contiene"
boolean focusrectangle = false
end type

type pb_buratto from picturebutton within w_rientro_galvanica
integer x = 6062
integer y = 2052
integer width = 279
integer height = 256
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\about.png"
alignment htextalign = left!
end type

event clicked;long ll_id_prof
ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")


openwithparm(w_scad_buratto_rpt, ll_id_prof)

end event

type rr_1 from roundrectangle within w_rientro_galvanica
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 6085
integer y = 1280
integer width = 270
integer height = 452
integer cornerheight = 40
integer cornerwidth = 46
end type

type pb_1 from picturebutton within w_rientro_galvanica
integer x = 6272
integer y = 248
integer width = 151
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\info.png"
alignment htextalign = left!
end type

event clicked;messagebox("RICORDA!", "Nel buratto e ovunque vi sia la 'tara' il cursore, dopo il cod. barre,"&
+" andrà sui lacci; tu con il mouse portalo sulla tara e inserisci il valore, poi continua con lacci,"&
+" fili e il sistema, uscendo dai fili, resetterà tutto e porterà il cursore sul cod. barre", STOPSIGN!)
end event

type dw_5 from udw_base within w_rientro_galvanica
boolean visible = false
integer x = 5979
integer y = 944
integer width = 421
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_inserisci_bollettina"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event editchanged;call super::editchanged;if len(data)=7 then
	wf_agg_a_doc_esistente(data)
	setfocus(dw_4)
	dw_4.scrolltorow(dw_4.rowcount())
	dw_4.setcolumn("peso_netto")
end if

















//string ls_num_doc,ls_num_bollettina,ls_bol_corretta
//long ll_id_bollettina,ll_riga_trovata, ll_riga_inserita,ll_doc_scelto,ll_id_doc,ll_riga_bollettina,ll_id_riga_bollettina, ll_null
//integer li_num_riga, li_ret
//dwitemstatus l_dw_status
//datastore ds_riga_da_copiare
//
//setnull(ll_null)
//
//if len(data)=7 then
//	ls_num_doc=data
//	select id_documento, num_documento
//	into :ll_id_bollettina, :ls_num_bollettina
//	from dba.documento d, dba.prof_documento p
//	where right(num_documento, 7)=:ls_num_doc
//	and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL' or  p.codice='BOLCLIEN') 
//	and d.id_prof_documento=p.id_prof_documento
//	;
//	SELECT first(ordinato_fo) into :ls_bol_corretta from dba.riga_documento where id_documento=:ll_id_bollettina;
//	if ls_bol_corretta='S' then
//		messagebox("Attenzione!", "Bollettina n. "+ls_num_bollettina+" già corretta: NON è più possibile inviarla ad alcuna lavorazione!!!!")
//		return
//	end if
//	if ll_id_bollettina>0 then
//		ll_riga_trovata=dw_4.find("right(num_bollettina, 7)='"+ls_num_bollettina+"'", 1, 9000000)
//		if ll_riga_trovata>0 then
//			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento! Riga n. "+string(ll_riga_trovata))
//		else
//			//inserisco la bollettina nelle righe del doc scelto
//			ll_doc_scelto=dw_7.find("c_scegli=1", 1, 9999999)
//			if ll_doc_scelto>0 then
//				ll_id_doc=dw_7.getitemnumber(ll_doc_scelto, "id_documento")
//				//carico datastore con la riga da copiare
//				ds_riga_da_copiare=create datastore
//				ds_riga_da_copiare.dataobject="d_doc_riga_sald_ra"
//				ds_riga_da_copiare.settransobject(sqlca)
//				ll_riga_bollettina=ds_riga_da_copiare.retrieve(ll_id_bollettina)
//				if ll_riga_bollettina= 1 then
//					li_ret=ds_riga_da_copiare.rowscopy(1, 1, primary!, dw_4, dw_4.rowcount()+1, primary!)
//					if li_ret=1 then
//						ll_riga_inserita=dw_4.rowcount()
//						select max(num_riga) into :li_num_riga from dba.riga_documento where id_documento=:ll_id_doc;
//						li_num_riga++
//						dw_4.setitem(ll_riga_inserita, "num_riga", li_num_riga)
//						dw_4.setitem(ll_riga_inserita, "id_documento", ll_id_doc)
//						ll_id_riga_bollettina=ds_riga_da_copiare.getitemnumber(1, "id_riga_documento")
//						dw_4.setitem(ll_riga_inserita, "provv_imp_subage_2", ll_id_riga_bollettina)
//						dw_4.setitem(ll_riga_inserita, "id_riga_documento", ll_null)
//						dw_4.setitem(ll_riga_inserita, "num_bollettina",ls_num_bollettina )
//					//	l_dw_status=dw_4.getitemstatus(ll_riga_inserita, 0, primary!)
//						dw_4.trigger event ue_update()
//					else
//						messagebox("Attenzione!","Riga NON copiata!")
//					end if
//					destroy  ds_riga_da_copiare
//				else
//					messagebox("Attenzione!","MAH")
//				end if
//			else
//				messagebox("Attenzione!","NON hai SCELTO alcun documento!")
//			end if
//		end if			
//	end if
//end if
//			
end event

type dw_2 from udw_figlia within w_rientro_galvanica
integer x = 59
integer y = 2172
integer width = 3735
integer height = 420
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
boolean livescroll = false
end type

event retrievestart;call super::retrievestart;return 2
end event

type cbx_1 from checkbox within w_rientro_galvanica
integer x = 5957
integer y = 804
integer width = 480
integer height = 112
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Completa doc iniziato"
end type

event clicked;long ll_id_prof

if cbx_1.checked then
	ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
	dw_5.visible=true
	dw_7.visible=true
	dw_4.visible=true
	dw_7.retrieve(ll_id_prof)
else
	dw_5.visible=false
	dw_7.visible=false
	dw_4.visible=false
end if
		
end event

type cb_salva_cancellazione from commandbutton within w_rientro_galvanica
boolean visible = false
integer x = 5952
integer y = 2476
integer width = 498
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva Cancellazione"
end type

event clicked;
if messagebox("ATTENZIONE!!!", "Le righe CANCELLATE NON potranno essere recuperate, Vuoi confermare la cancellazione?", stopsign!, yesno!)=1 then
	dw_4.trigger event ue_update()
end if
end event

type dw_8 from udw_base within w_rientro_galvanica
integer x = 55
integer y = 240
integer width = 3858
integer height = 1924
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

event itemchanged;call super::itemchanged;long ll_id_galv, ll_riga, ll_id_doc, LL_ID_PROF,ll_riga_trovata
date ldt_data
string ls_test, ls_galv,ls_num_bol
decimal ldc_prezzo,ldc_peso_netto

LL_ID_PROF=dw_3.getitemnumber(1, "id_prof_destinazione")
if dwo.name="sog_commerciale_gen_codice" then
select id_galvanica
	into :ll_id_galv
	from dba.galvanica
	where lavorazione=:data
	;
	
	if ll_id_galv>0 then
		ll_id_doc=getitemnumber(row, "id_documento")
		ll_riga=dw_2.find("id_documento="+string(ll_id_doc), 1, 999999)
		ldt_data=dw_3.getitemdate(1, "doc_data")  //20240304 questa l'avevo padellata.... non passavo nulla...
		ldc_prezzo=f_rec_prezzo_galvanica(ldt_data, ll_id_galv)
		dw_2.setitem(ll_riga, "prezzo_metallo",ldc_prezzo)
		dw_2.setitem(ll_riga, "id_gruppo_agenti_2",ll_id_galv)
		ls_test=dw_2.getitemstring(ll_riga, "descrizione")
		if ls_test> " " then
			ls_galv=ls_test+"  __ "+data
		end if
		dw_2.setitem(ll_riga, "descrizione", ls_galv)
	else
		messagebox("Attenzione!", "Galvanica NON riconosciuta!!")
	end if
elseif dwo.name="peso_netto" AND (LL_ID_PROF=184 or  LL_ID_PROF=130) then  //serena 20240205 cambio peso diretto in dw_8 solo per buratto e sald!
	ldc_peso_netto=dec(data)
	//dw_3.setitem(1, "legato", ldc_peso_netto)
	ls_num_bol=getitemstring(row, "num_documento")
	ls_num_bol=right(ls_num_bol, 7)
	ll_riga_trovata=dw_2.find( "provv_imp_subage_2="+ls_num_bol, 1, 999999)
	//dw_2.post setitem( dw_2.rowcount(), "peso_netto", ldc_peso_netto)
	dw_2.post setitem(ll_riga_trovata, "peso_netto", ldc_peso_netto)
	post wf_agg_fino_calo(ldc_peso_netto, dw_2.rowcount())
	dw_3.post setfocus()
	dw_3.post setcolumn("cod_barre")
end if
//if LL_ID_PROF=130 then
//	choose  case dwo.name
//		case "lunedi" 
//			
//		case "martedi"
//			
//		case "mercoledi"
//			
//		case "giovedi"
//				
//		case "venerdi"
//					
//		case "sabato"
//			
//	end choose
//end if
	
end event

event clicked;call super::clicked;long ll_id_prof,ll_riga_trovata, ll_new_riga_doc
string ls_test, ls_num_bollettina,ls_giorno_rientro_silver

LL_ID_PROF=dw_3.getitemnumber(1, "id_prof_destinazione")
if LL_ID_PROF=130 then
	choose  case dwo.name	
		case "lunedi" 			
			//messagebox("W", string(dwo.name))
			dw_8.setitem(row, "martedi", "N")
			dw_8.setitem(row, "mercoledi", "N")
			dw_8.setitem(row, "giovedi", "N")
			dw_8.setitem(row, "venerdi", "N")
			dw_8.setitem(row, "sabato", "N")
			post wf_salva_giorno_rientro_silver(row, "lunedi")	
		case "martedi"
			dw_8.setitem(row, "lunedi", "N")
			dw_8.setitem(row, "mercoledi", "N")
			dw_8.setitem(row, "giovedi", "N")
			dw_8.setitem(row, "venerdi", "N")
			dw_8.setitem(row, "sabato", "N")
			post wf_salva_giorno_rientro_silver(row, "martedi")	
			
			//messagebox("W", string(dwo.name))
		case "mercoledi"
			dw_8.setitem(row, "martedi", "N")
			dw_8.setitem(row, "lunedi", "N")
			dw_8.setitem(row, "giovedi", "N")
			dw_8.setitem(row, "venerdi", "N")
			dw_8.setitem(row, "sabato", "N")
			post wf_salva_giorno_rientro_silver(row, "mercoledi")	
		case "giovedi"
			dw_8.setitem(row, "martedi", "N")
			dw_8.setitem(row, "mercoledi", "N")
			dw_8.setitem(row, "lunedi", "N")
			dw_8.setitem(row, "venerdi", "N")
			dw_8.setitem(row, "sabato", "N")
			post wf_salva_giorno_rientro_silver(row, "giovedi")	
		case "venerdi"
			dw_8.setitem(row, "martedi", "N")
			dw_8.setitem(row, "mercoledi", "N")
			dw_8.setitem(row, "giovedi", "N")
			dw_8.setitem(row, "lunedi", "N")
			dw_8.setitem(row, "sabato", "N")
			post wf_salva_giorno_rientro_silver(row, "venerdi")	
		case "sabato"
			dw_8.setitem(row, "martedi", "N")
			dw_8.setitem(row, "mercoledi", "N")
			dw_8.setitem(row, "giovedi", "N")
			dw_8.setitem(row, "venerdi", "N")
			dw_8.setitem(row, "lunedi", "N")
			post wf_salva_giorno_rientro_silver(row, "sabato")	
	end choose
end if
end event

event doubleclicked;call super::doubleclicked;long ll_id_bol_doc
if dwo.name="peso_netto" then
	ll_id_bol_doc=getitemnumber(row, "id_documento")
	wf_bilancia(row, ll_id_bol_doc)
end if
end event

type st_3 from statictext within w_rientro_galvanica
integer x = 4178
integer y = 8
integer width = 914
integer height = 128
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "VGMF= Se = 1 allora la bollettina è nella merce giornaliera per i fornitori "
boolean focusrectangle = false
end type

type st_4 from statictext within w_rientro_galvanica
integer x = 4178
integer y = 152
integer width = 914
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "VSBK=1 bollettina in sped. Karizia"
boolean focusrectangle = false
end type

type cb_passa from commandbutton within w_rientro_galvanica
integer x = 5998
integer y = 480
integer width = 398
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Manda in Galv"
end type

event clicked;integer li_ret, i, li_righe
long     ll_null,ll_riga_doc, ll_id_doc, ll_id_galvanica,ll_id_doc_riga_da_cancellare, ll_riga_erase, ll_parametro[], ll_id_galv
string    ls_num_doc, ls_tipo_registro,ls_nota="", ls_num_bol, ls_des,ls_num_bollettina,ls_des2, ls_des_bollettina, ls_tipo
string ls_corretto, ls_non_segnare_piu, li_len, ls_ret, ls_galv,ls_um, ls_giorno_rientro_silver
date  ldt_data_doc, ldt_data_inserimento
long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_id_riga_provenienza,ll_riga_doc_inserito,ll_new_riga_doc,ll_id_art
long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre,ll_riga_trovata,ll_id_uc
setnull(ll_null)
decimal ldc_prezzo, ldc_legato, ldc_tot_riga,ldc_prezzo_metallo, ls_tot_peso, ldc_coef_calo
long ll_id_locazione, ll_id_magazzino,ll_id_causale, ll_id_titolo, ll_id_riga_bol ,ll_id_var, ll_id_listino, ll_riga_sald, ll_righe_sald, ll_id_riga
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
datetime ldt_data_ora


	dw_8.accepttext()
IF DW_8.ROWCOUNT()>0 THEN
	//20230906 controllo che ogni riga abbia la galvanica, altrimenti lo segnalo e la faccio mettere
	ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
	if ll_id_prof=170 then //galvanica
		for i= 1 to DW_8.ROWCOUNT()
			ls_galv=""
			ls_galv=dw_8.getitemstring(i, "sog_commerciale_gen_codice")
			//if ls_galv> " " and len(ls_galv)<=3  then  //20250612 si porta a 12 (anche se qui il limite è 8 del campo codice sog_commerciale ma dovrebbe andare bene lo stesso (12 è sovrastimato)
			if ls_galv> " "   then
				continue  //rimane la galv che è nel codice cliente (se ci fosse, es:cl010004 che è lungo per forza 8, (la galv è max 3) lo segnalo perché manca galv...)
			else
				messagebox("Attenzione!!", "La riga n. "+string(i)+" NON ha galvanica: puoi inserirla a mano, se vuoi.")
				setfocus(dw_8)
				dw_8.setitem(i, "sog_commerciale_gen_codice", "********")
				dw_8.scrolltorow(i)
				dw_8.setcolumn("sog_commerciale_gen_codice")
				return
			end if
		next
	end if
//20230906 fine

		ll_id_doc=dw_8.getitemnumber(1, "id_documento")
		ll_riga_doc=dw_1.retrieve(ll_id_doc)
		ldt_data_doc=dw_3.getitemdate(1, "doc_data")
		//ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")  //spostato sopra 20230906
		ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
		select id_locazione_1_prop, id_magazzino_1_prop, id_mod_registro_prop, id_caus_magazzino_prop
		into :ll_id_locazione, :ll_id_magazzino, :ll_id_mod_registro, :ll_id_causale
		from dba.prof_documento
		where id_prof_documento=:ll_id_prof
		;
		dw_1.setitem(ll_riga_doc, "id_documento", ll_null)
		dw_1.setitem(ll_riga_doc, "data_documento", ldt_data_doc)
		dw_1.setitem(ll_riga_doc, "id_prof_documento", ll_id_prof)
		//20221027 aggiungo da wf_importa che avevo preparato ma non ho mai usato...
		dw_1.SetItem(1, "id_caus_magazzino", ll_id_causale)
		dw_1.SetItem(1, "id_magazzino", ll_id_magazzino)
		dw_1.SetItem(1, "id_locazione_1", ll_id_locazione)
		dw_1.SetItem(1, "id_registro", ll_id_registro)
		//20221027 fine
		dw_1.setitem(ll_riga_doc, "id_sog_commerciale", ll_id_sog)
		dw_1.setitem(ll_riga_doc, "id_sog_commerciale_fattura", ll_id_sog)
		dw_1.setitem(ll_riga_doc, "data_registrazione", ldt_data_doc)
		//20221014 il tio fattura è importante, se è diverso da 'N' mette il segno "-"
		dw_1.setitem(ll_riga_doc, "tipo_fattura", 'N')
		//trovo il numprog
		
		
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
			dw_1.SetItem(ll_riga_doc, "num_documento", string( ls_trova_prog.sl_num_progressivo))
		end if	
		//ls_num_doc="'"+dw_3.getitemstring(1, "num_documento")+"'"
		//select num_progressivo
		//into :ll_num_prog_test
		//from dba.documento
		//where id_registro=:ll_id_registro and num_documento=:ls_num_doc
		//;
		//if ll_num_prog_test>0 then
		//	messagebox("Attenzione!", "QUesto documento è già stato importato in Galvanica!")
		//	return
		//end if
		ls_nota="Bol. in questo doc: "
		select id_listino into :ll_id_listino from dba.sog_commerciale where id_sog_commerciale=:ll_id_sog;
		select id_variazione into :ll_id_var from dba.variazione  where id_listino=:ll_id_listino and data_inizio<= :ldt_data_doc and data_fine>=:ldt_data_doc ;
		
	//	li_anno=integer 
		for i=1 to dw_8.rowcount()
			
	//		ll_id_doc=dw_8.getitemnumber(i, "id_documento")
	//		//select id_riga_documento into :ll_id_riga_bol from dba.riga_documento where id_documento=:ll_id_doc;
	//		//update dba.riga_documento set descrizione=descrizione+ ' RSPA' where id_riga_documento=:ll_id_riga_bol;
	//		update dba.riga_documento set descrizione=descrizione+ ' RSPA' where id_documento=:ll_id_doc;
	//		if sqlca.sqlnrows>0 then
	//			commit;
	//		else
	//			rollback;
	//		messagebox("Attenzione!", "Descrizione in bollettina non aggiornata con RSPA!")
	//	end if
			
			
			ls_num_bol=dw_8.getitemstring(i, "num_documento")
			select d.num_progressivo
			into :ll_num_prog_test
			from dba.documento d, dba.riga_documento r
			where r.id_documento=d.id_documento and id_prof_documento=:ll_id_prof
			and note_intestazione like ''%'+:ls_num_bol+'%''   //segno note inestazione
			and year(data_documento)=:li_anno
			;
			if ll_num_prog_test>0 then
				messagebox("Attenzione!", "La bollettina "+ls_num_bol+" è già stata importata in Galvanica! Num. Prog.:"+string(ll_num_prog_test))
				ll_id_doc_riga_da_cancellare=dw_8.getitemnumber(i, "id_documento")
				ll_riga_erase=dw_2.find("id_documento="+string(ll_id_doc_riga_da_cancellare), 1, dw_2.rowcount())
				if ll_riga_erase>0 then
					dw_2.RowsMove(ll_riga_erase, ll_riga_erase, Primary!,  dw_2, 1, filter!)
				else
					messagebox("Attenzione!", "Riga da cancellare NON trovata!")
				end if
				dw_8.deleterow(i)
				i --
				continue
		//		dw_8.reset()
		//		dw_1.reset()
		//		dw_2.reset()
		//		setfocus(dw_3)
		//		dw_3.setcolumn(1)
		//		return
			end if
			ls_nota+=ls_num_bol+";"
		next
		
		dw_1.setitem(ll_riga_doc, "note_intestazione", ls_nota)
		//20220322 agg. la dataora creazione aggiornata
		dw_1.setitem(ll_riga_doc, "data_ora_creazione", today())
		dw_1.setitemstatus(ll_riga_doc, 0, primary!, newmodified!)
		li_ret=dw_1.trigger event ue_update()  //salvo la testa
		//fine inserimento testa
		ll_id_doc_inserito=dw_1.getitemnumber(ll_riga_doc, "id_documento")

		//completo e salvo le righe
		for i=1 to dw_2.rowcount()
			dw_2.setitem(i, "id_documento", ll_id_doc_inserito)
			dw_2.setitem(i, "num_riga", i)
			ll_riga_madre=dw_2.getitemnumber(i, "id_riga_documento")
			//20221018 inserisco per le stampe
			dw_2.setitem(i, "provv_imp_subage_2", ll_riga_madre)  //questo è il legame con la bollettina (non posso usare id_riga_doc_provenienza altrimenti lo segna evaso...)
			//fine
			//20221027 aggiungo da wf_importa
			dw_2.SetItem(i, "id_caus_magazzino", ll_id_causale)
			dw_2.SetItem(i, "id_locazione_1", ll_id_locazione)
			//20221027 fine
			dw_2.setitem(i, "id_riga_documento", ll_null)
			ll_id_galvanica=0
			ll_id_galvanica=dw_2.getitemnumber(i, "id_gruppo_agenti_2")
			
	
			//20221212 sAMY DICE CHE il titolo deve essere sempre = 925 se è argento e se il fornitore è ???? me li deve dare
			ll_id_art=dw_2.getitemnumber(i, "id_articolo")
			select id_titolo into :ll_id_titolo from dba.articolo where id_articolo=:ll_id_art;
			if ll_id_titolo=4 then
				//20231205 il coef_calodeve essere sempre = al titolo se ag
				dw_2.SetItem(i, "coef_calo", 925)
			end if
			ldc_prezzo_metallo=dw_2.getitemdecimal(i, "prezzo_metallo")
			//20221212 fine
			//20231031
			if ll_id_prof=228 then //è una spazzolatura esterni i prezzi degli articoli sono in pr_spazzolatura
				ll_id_uc=dw_2.getitemnumber(i, "id_unita_confezione")
			
				select pr_spazzolatura into :ldc_prezzo from dba.prezzo where id_unita_confezione=:ll_id_uc and id_variazione=:ll_id_var;
				if ldc_prezzo>0 then 
					dw_2.setitem(i, "prezzo", ldc_prezzo)
					dw_2.setitem(i, "id_listino", ll_id_var)
					select tipo into :ls_um from unita_misura um, unita_confezione uc where um.id_unita_misura=uc.id_unita_misura and id_unita_confezione=:ll_id_uc;
					if ls_um="P" then
						dw_2.setitem(i, "prezzo_manifattura", ldc_prezzo)
					else
						dw_2.setitem(i, "prezzo_complessivo", ldc_prezzo)
					end if
					
				end if
			else
			//20231031 fine
				if ls_um="P" then
					dw_2.setitem(i, "prezzo_manifattura", ldc_prezzo)
				else
					dw_2.setitem(i, "prezzo_complessivo", ldc_prezzo)
				end if
			end if
			//devo calcolare anche il totale riga ...
			dw_2.setitem(i, "prezzo_metallo", ldc_prezzo_metallo)
			ldc_tot_riga=dw_2.getitemdecimal(i, "tot_riga_val_az")
			ldc_legato=dw_2.getitemdecimal(i, "peso_netto")
			if isnull(ldc_legato) or ldc_legato<0 then ldc_legato=0  //controllo anche che il legato sia >=0 20220728
				ls_tot_peso+=ldc_legato
				ldc_tot_riga+=ldc_prezzo*ldc_legato
			if isnull(ldc_tot_riga) then ldc_tot_riga=0
			dw_2.setitem(i, "peso_netto", ldc_legato)
			//20250401 Pare che non ricalcoli bene il calo e il fino delle righe....
			ldc_coef_calo=dw_2.getitemdecimal(i, "coef_calo")
			select id_titolo into :ll_id_titolo from dba.articolo where id_articolo= :ll_id_art;
			dw_2.setitem(i, "fino", ldc_legato*ll_id_titolo/1000)
			dw_2.setitem(i, "calo", ldc_legato*(ldc_coef_calo - ll_id_titolo) /1000)
			//20250401 fine
			dw_2.setitem(i, "tot_riga_val_az", ldc_tot_riga)  //la valuta è sempre euro
			dw_2.setitem(i, "tot_riga_val_doc", ldc_tot_riga)
			dw_2.setitem(i, "tot_riga_val_riga", ldc_tot_riga)
			//20220922 azzero eventuali derivazioni della bollettina
			dw_2.setitem(i, "peso_netto_evaso", 0)
			dw_2.setitem(i, "qta_evasa", 0)
			//20221107 aggiungo importante: evasa un base
			dw_2.setitem(i, "qta_evasa_un_base", 0)
			//20220922 fine
			//20220929 aggiusto i fattori di conversione altrimenti nulli
			dw_2.setitem(i, "fat_con_globale", 1)
			dw_2.setitem(i, "fat_con_unita_base", 1)
			
			select num_documento, d.id_documento into :ls_num_bollettina, :ll_id_doc from dba.documento d, dba.riga_documento r
			where d.id_documento=r.id_documento and id_riga_documento=:ll_riga_madre;
			//20220921 samy vuole che l'articolo delle riparazioini sia sempre ripgratis  //NOOOO Intendeva nella stampa del ddt... 20220926
	//		if  ll_id_prof=204 then
	//			ll_id_art=281
	//			ll_id_uc=277
	//		else
				ll_id_uc=dw_2.getitemnumber(i, "id_unita_confezione")
				
			//end if
			//20220921 fine
			//20230517
			//20230628 controllo corretto e non più
			if ll_id_prof=203 then ls_tipo="S"
			if ll_id_prof=196 then ls_tipo="L"
			if ll_id_prof=228 then ls_tipo="E"  // 20231108
			ls_ret=wf_corretto_nonpiu_blocco(ll_id_art, ls_tipo, "Z" )
			if  pos(ls_ret, "S")>0 then
				
			else
				select des_2 into :ls_des2 from dba.prezzo where id_variazione=15 and id_unita_confezione=:ll_id_uc;
				ldt_data_inserimento=date(today())
				ls_tipo=''  //20230906 commento perché deve essere un errore o un incompletezza: se ="" NON fa mai l'insert
				if ll_id_prof=203 or ll_id_prof=228 then  //spazzolatura
					if pos(ls_des2, "k56")<=0 and  pos(ls_des2, "k56a")<=0  and  pos(ls_des2, "k57")<=0 and  pos(ls_des2, "k58")<=0 and  pos(ls_des2, "k59")<=0 &
					and  pos(ls_des2, "k60")<=0 and  pos(ls_des2, "k60a")<=0  and  pos(ls_des2, "k61")<=0 and pos(ls_des2, "K61a")<=0   and pos(ls_des2, "K60")<=0 then 
						messagebox("Attenzione!", "L'articolo NON contiene il K spazzolatura!!")
						if ll_id_prof=228 then 
							ls_tipo="E"
						else
							ls_tipo='S'
						end if
					end if
				elseif   ll_id_prof=196 then  //laseratura 20230517
					if pos(ls_des2, "k55")<=0 and pos(ls_des2, "k96")<=0 and pos(ls_des2, "k51l")<=0 then
						//20240520 controllo se c'é @ nella des_2
						if pos(ls_des2, "@")>0 then
							messagebox("Attenzione!", "L'articolo ha la @ nella Des_2!")
						else
							messagebox("Attenzione!", "L'articolo NON contiene il K laseratura!!")
						end if
						ls_tipo='L'
					end if
					
				end if
				if ls_tipo>'' then
					insert into dba.art_senza_spazzolatura (id_articolo,tipo,data_inserimento, num_bollettina)    //20230517 aggiungo un campo per distinguere il tipo di lavorazione
					values(:ll_id_art,:ls_tipo,:ldt_data_inserimento, :ls_num_bollettina);
					if sqlca.sqlNrows>0 then
						commit;
					else
						rollback;
					end if
				end if
			end if
	
	// Kk56a, K57	K58 K59 K60 K60a K61
	//		if //NON serve più???
	//		dw_2.setitem(i, "prezzo_metallo", 0)  //20220830: ANNA chiede che la quotazione della galvanica NON venga riportata sul buratto
			ls_des=dw_2.getitemstring(i, "descrizione")
			ls_des_bollettina=ls_des
			if pos(ls_des, "BOL:")<=0 then ls_des+= " - BOL: "+ls_num_bollettina		
			dw_2.setitem(i, "descrizione", ls_des)
			dw_2.setitemstatus(i, 0, primary!, newmodified!)
			//salvo la riga
			li_ret=dw_2.trigger event ue_update()  //20220725
			//20250721: memorizzo data ora dell'inserimento in riga_doc_estensione (lo rivedo in cerca bol ovunque)
			//20250721 registro data ora della modifica del peso
			ll_id_riga=dw_2.getitemnumber(i, "id_riga_documento")
			ldt_data_ora=datetime(today(), now())
			wf_salva_data_ora(ll_id_riga, ldt_data_ora)
			//20250721 fine
			//aggiungo legame con la produzionevorrei portare tutti i legami in questa tabella mi chiedo perché non l'ho fatto dall'inizio....)
			ll_new_riga_doc=dw_2.getitemnumber(i, "id_riga_documento")
			insert into dba.produzione_2011 (id_bollettina, id_doc_produzione)
			values(:ll_id_doc, :ll_new_riga_doc)
			;
			if sqlca.sqlNrows>0 then
				commit;
			else 
				rollback;
				messagebox("Attenzione!", "Legame bollettina-riga_doc_produzione per bol: "+ls_num_bol+" NON è stato salvato!")
			end if
			// 20220907 fine
			if li_ret=1 then //funzione che vuole Samy: le righe passate correttamente spariscono quelle che rimangono NON sono state passate 20220728
				ll_riga_trovata=dw_8.find("num_documento='"+ ls_num_bollettina+"'", 1, 1000000)
				dw_8.deleterow(ll_riga_trovata)
			end if
			
		//inserisco il doc nella tabella dei doc passati per l'eventuale stampa a memoria
//			if ll_id_old_doc_inserito
//			ll_riga_doc_inserito=dw_9.insertrow(0)
//	//		dw_9.setitem(ll_riga_doc_inserito, "id_riga_bollettina",ll_riga_madre)
//			dw_9.setitem(ll_riga_doc_inserito, "id_documento",ll_id_doc_inserito)
//	//		dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ls_trova_prog.sl_num_progressivo)
//			dw_9.setitem(ll_riga_doc_inserito, "num_documento",	string(ls_trova_prog.sl_num_progressivo))
//			dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_doc)
//			//dw_9.setitem(ll_riga_doc_inserito, "num_riga", i)	 //20240131 Non c'è più, abbiamo cambiato sistema
//			dw_9.setitem(ll_riga_doc_inserito, "num_bollettina",	ls_num_bollettina)
//			dw_9.setitem(ll_riga_doc_inserito, "c_tot_peso",	ls_tot_peso)
	//		li_ret=dw_9.trigger event ue_update() 
	//fine inserimento		
			
			//aggiorna LA BOLLETTINA CON LA GALVANICA E IL PREZZO GALVANICA NEL PREZZO METALLO
			//20220425 Sara dice che si blocca perché manca galvanica....
			
			//20220822 e se per non saper leggere né scrivere io azzerassi tutto comunque 20220822??????
			//if ll_id_galvanica>0 and ldc_prezzo>0  then
	//			update dba.riga_documento
	//			set id_gruppo_agenti_2=:ll_id_galvanica, prezzo_metallo=:ldc_prezzo, tot_riga_val_riga=:ldc_tot_riga, 
	//			tot_riga_val_az=:ldc_tot_riga,  tot_riga_val_doc=:ldc_tot_riga,  descrizione=:ls_des  
	//			where id_riga_documento=:ll_riga_madre
	//			;
				//20220822 Samy dice che si ritrova delle bollettine con numero lacci quando fa rbol (spedizione)
				//non capisco come sia possibile, ma mi adeguo....
				//202305417 se è spaz o laser aggiungere in descrizione riga
				if ll_id_prof=203 then ls_des_bollettina+= " SPAZZ"  //spazzolatura  //cambiate diciture (Ceramica=cera ecc...) 20231205
				if ll_id_prof=196 then ls_des_bollettina+= " LAS"  //laseratura
				if ll_id_prof=224 then ls_des_bollettina+= " CERA" //ceramica
				//20230906 se è galvanica e non c'è galvanica (non l'hanno battuta o per qualsiasi altro motivo) devo mettere "G"
				if ll_id_prof=170 and (isnull(ll_id_galvanica) or ll_id_galvanica<=0) then ll_id_galvanica= 3
				
				update dba.riga_documento
				set id_gruppo_agenti_2=:ll_id_galvanica, prezzo_metallo=:ldc_prezzo_metallo, //20231122 corretto ldc_prezzo con prezzo_metallo (quot galvanica) vedi più in alto molto
				provv_imp_carea_2=0, provv_imp_agente_2=0,   peso_netto=0, descrizione=:ls_des_bollettina   //20250718: io lo tolgo! è successo che ha azzerato delle bollettine già corrette!! " peso_netto=0" prima di descrizione
				where id_riga_documento=:ll_riga_madre
				;
				//tot_riga_val_riga=:ldc_tot_riga, 
				//tot_riga_val_az=:ldc_tot_riga,  tot_riga_val_doc=:ldc_tot_riga,  
				//descrizione=:ls_des 
				 //peso_netto=:ldc_legato 20220426 Samy non vuole che il peso della bollettina sia cambiato!!!
				 
				if sqlca.sqlNrows>0 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "La bollettina "+ls_num_bol+" NON è stata aggiornata con il valore galvanica!")
				end if  
					//inserisco il doc nella tabella dei doc passati per l'eventuale stampa a memoria
	//				ll_riga_doc_inserito=dw_9.insertrow(0)
	//				dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ls_trova_prog.sl_num_progressivo)
	//				dw_9.setitem(ll_riga_doc_inserito, "num_documento",	string(ls_trova_prog.sl_num_progressivo))
	//				dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_doc)
	//				dw_9.setitem(ll_riga_doc_inserito, "num_riga", i)	
	//				dw_9.setitem(ll_riga_doc_inserito, "num_bollettina",	ls_num_bollettina)
				
				//20220822 e se per non saper leggere né scrivere io azzerassi tutto comunque 20220822??????
	//		elseif ldc_legato>0 then
	//			update dba.riga_documento set peso_netto=0 	where id_riga_documento=:ll_riga_madre;
	//			if sqlca.sqlNrows>0 then
	//				commit;
	//			else
	//				rollback;
	//				messagebox("Attenzione!", "NON azzerato peso netto in bollettina "+ls_num_bol+"!")
	//			end if
			//end if  //20220425 Sara dice che si blocca perché manca galvanica... //20220822 e se per non saper leggere né scrivere io azzerassi tutto comunque 20220822??????
		next
		ll_riga_doc_inserito=dw_9.insertrow(0)
		dw_9.setitem(ll_riga_doc_inserito, "id_documento",ll_id_doc_inserito)
		dw_9.setitem(ll_riga_doc_inserito, "num_documento",	string(ls_trova_prog.sl_num_progressivo))
		dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_doc)
		dw_9.setitem(ll_riga_doc_inserito, "num_bollettina",	ls_num_bollettina)
		dw_9.setitem(ll_riga_doc_inserito, "c_tot_peso",	ls_tot_peso)
		dw_9.sort()
		dw_9.groupcalc()
		//li_ret=dw_2.trigger event ue_update()   //spostato sopra per vedere se funziona meglio salvando una riga alla volta... 20220725
		f_pdf_doc_fo(ll_id_doc_inserito, "d_pdf_doc_fo_doc", "")
		f_pdf_doc_fo(ll_id_doc_inserito, "d_pdf_doc_fo_doc", "articolo_id_articolo")
		if dw_8.rowcount()<=0 then dw_8.reset()  //resetto solo se NON ci sono righe non passate 20220728
		
	dw_1.reset()
	dw_2.reset()
	dw_3.setitem(1, "n_lacci", ll_null)
	dw_3.setitem(1, "n_fili", ll_null)
	setfocus(dw_3)
	dw_3.setcolumn(1)
END IF

end event

type dw_7 from udw_001 within w_rientro_galvanica
boolean visible = false
integer x = 3922
integer y = 240
integer width = 2002
integer height = 876
integer taborder = 50
string title = "Ristampa liste già create"
string dataobject = "d_acc_sald_da_fabbisogno"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;long ll_id_doc
//
if dwo.name='c_scegli' then
	ll_id_doc=getitemnumber(row, "id_documento")
	
	dw_4.retrieve(ll_id_doc)
end if
//	
end event

event doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if dwo.name="num_documento" then
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

type dw_4 from udw_figlia within w_rientro_galvanica
boolean visible = false
integer x = 3922
integer y = 1124
integer width = 2011
integer height = 1464
integer taborder = 20
string dataobject = "d_doc_riga_sald_ra"
boolean hscrollbar = true
end type

event itemchanged;call super::itemchanged;decimal ldc_peso, ldc_tara,ldc_storno
integer  li_filo_laccio



if  dwo.name="peso_lordo" or dwo.name="provv_imp_agente_2" or dwo.name="provv_imp_carea_2" then
	//manca storno pesi e aggiorna fino
	ldc_peso=getitemdecimal(row, "peso_netto")
	if dwo.name="peso_lordo" then
		ldc_tara=dec(data)
		if isnull(ldc_tara) then ldc_tara=0
		if ldc_tara>0 then
			if ldc_peso>ldc_tara then  //20250401 AGGIORNO FINO E CALO
				setitem(row, "peso_netto", ldc_peso - ldc_tara)
				wf_agg_fino_calo(ldc_peso - ldc_tara, row)
			END IF
		end if
	end if
	if dwo.name="provv_imp_agente_2" then
		li_filo_laccio= integer(data)
		ldc_storno=f_rec_prezzo_laccio_filo_rame( "F", date(today()))
		if ldc_storno<ldc_peso and ldc_storno>0 then
			dw_4.setitem(row, "peso_netto",ldc_peso - ldc_storno)
			//20250401 AGGIORNO FINO E CALO NELLA DW_2 (CHE è QUELLA CHE SLAVA LA RIGA DOCU
			wf_agg_fino_calo(ldc_peso - ldc_storno, row)
		end if
	end if
	if dwo.name="provv_imp_carea_2" then
		li_filo_laccio= integer(data)
		ldc_storno=f_rec_prezzo_laccio_filo_rame( "L", date(today()))
		dw_4.setitem(row, "peso_netto",ldc_peso - ldc_storno)
		//20250401 AGGIORNO FINO E CALO NELLA DW_2 (CHE è QUELLA CHE SLAVA LA RIGA DOCU
		wf_agg_fino_calo(ldc_peso - ldc_storno, row)
	end if
	trigger event ue_update()
end if
if dwo.name="peso_netto" then
	ldc_peso=dec(data)
	wf_agg_fino_calo(ldc_peso, row)
	trigger event ue_update()
end if
	
	
end event

type dw_9 from udw_base within w_rientro_galvanica
integer x = 3913
integer y = 240
integer width = 2016
integer height = 2328
integer taborder = 20
string dataobject = "d_bol_galv_buratto2"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if dwo.name="num_documento" then
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

type st_5 from statictext within w_rientro_galvanica
integer x = 5888
integer y = 8
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "ANTICIPATO"
boolean focusrectangle = false
end type

type st_6 from statictext within w_rientro_galvanica
integer x = 5737
integer y = 92
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 65280
string text = "SPAZZ!= DA SPAZZOLARE"
boolean focusrectangle = false
end type

type st_7 from statictext within w_rientro_galvanica
integer x = 5737
integer y = 172
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 65280
string text = "LASER!= DA LASERARE"
boolean focusrectangle = false
end type

type cb_bur_sped from commandbutton within w_rientro_galvanica
boolean visible = false
integer x = 5998
integer y = 1144
integer width = 398
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Bur. Sped."
end type

event clicked;open(w_bur_spedizione_gd)
end event

type r_1 from rectangle within w_rientro_galvanica
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 65535
integer x = 5746
integer y = 4
integer width = 123
integer height = 72
end type

