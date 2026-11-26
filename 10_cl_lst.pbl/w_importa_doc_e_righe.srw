forward
global type w_importa_doc_e_righe from w_001
end type
type dw_1 from udw_base within w_importa_doc_e_righe
end type
type dw_2 from udw_figlia within w_importa_doc_e_righe
end type
type cb_carica from commandbutton within w_importa_doc_e_righe
end type
type dw_3 from udw_base within w_importa_doc_e_righe
end type
type cb_importa from commandbutton within w_importa_doc_e_righe
end type
type dw_4 from udw_base within w_importa_doc_e_righe
end type
type dw_5 from udw_base within w_importa_doc_e_righe
end type
type cb_reset from commandbutton within w_importa_doc_e_righe
end type
type dw_8 from udw_base within w_importa_doc_e_righe
end type
type dw_9 from udw_base within w_importa_doc_e_righe
end type
type dw_10 from udw_base within w_importa_doc_e_righe
end type
type dw_11 from udw_base within w_importa_doc_e_righe
end type
type dw_6 from udw_base within w_importa_doc_e_righe
end type
type dw_7 from udw_base within w_importa_doc_e_righe
end type
type cb_1 from commandbutton within w_importa_doc_e_righe
end type
type cb_2 from commandbutton within w_importa_doc_e_righe
end type
end forward

global type w_importa_doc_e_righe from w_001
integer x = 1057
integer y = 483
integer width = 4046
integer height = 3068
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_2 dw_2
cb_carica cb_carica
dw_3 dw_3
cb_importa cb_importa
dw_4 dw_4
dw_5 dw_5
cb_reset cb_reset
dw_8 dw_8
dw_9 dw_9
dw_10 dw_10
dw_11 dw_11
dw_6 dw_6
dw_7 dw_7
cb_1 cb_1
cb_2 cb_2
end type
global w_importa_doc_e_righe w_importa_doc_e_righe

type variables
string ls_azienda
end variables

forward prototypes
public subroutine wf_cambia_iva ()
public function long wf_imp_sog_com (long al_id_ana)
public function long wf_imp_anagrafica ()
public function string wf_estrai_cod_barre (string as_numero)
public subroutine wf_salva_in_listino (decimal adc_prezzo, long al_id_uc, long al_id_variazione)
public subroutine wf_agg_articoli (string as_cod_art, long al_riga)
public function long wf_trova_art (string as_cod_articolo, long al_riga_doc)
public function long wf_articolo (long al_id_articolo, long al_riga_doc)
end prototypes

public subroutine wf_cambia_iva ();long ll_id_tab_iva
INTEGER I

select id_TAB_IVA
into :ll_id_tab_iva
from 
dba.tab_iva
where per_aliquota=22 and per_detrazione=100
;
if ll_id_tab_iva> 0 then
	for i= 1 TO DW_2.ROWCOUNT()
		DW_2.SETITEM(I, "ID_TAB_IVA",ll_id_tab_iva)
		//DW_2.SETITEM(I, "provv_imp_carea_2", 0)
	NEXT
else
	messagebox("Attenzione!", "IVA NON TROVATA!")
END IF
	
end subroutine

public function long wf_imp_sog_com (long al_id_ana);long ll_id_sog, ll_null
string ls_cod_cliente

setnull(ll_null)
//ll_id_sog=dw_9.getitemnumber(1, "id_sog_commerciale")
//ls_cod_cliente=dw_9.getitemstring(1, "codice")   //20220913 commento per non capisco
select id_sog_commerciale
into :ll_id_sog
from dba.sog_commerciale
where id_anagrafica=:al_id_ana //and tipo='C'
;

if ll_id_sog<=0 or isnull(ll_id_sog) then
	
	dw_9.rowscopy(1, 1, primary!, dw_11, 1, primary!)
	dw_11.setitem(1,"id_sog_commerciale", ll_null)
	dw_11.setitem(1,"id_anagrafica", al_id_ana)
	dw_11.setitem(1,"id_conto", ll_null)
	dw_11.setitemstatus(1, 0, Primary!, NewModified!)
	dw_11.trigger event ue_update()
	ll_id_sog=dw_11.getitemnumber(1, "id_sog_commerciale")
	IF ll_id_sog<=0 OR ISNULL(ll_id_sog) then messagebox("Attenzione!", "Controllare l'anagrafica: forse esiste, ma non è stato inserito il codice cliente!")
end if
return ll_id_sog
end function

public function long wf_imp_anagrafica ();long ll_id_ana, ll_null, ll_new_codice
string ls_rag_soc, ls_cod_cliente

setnull(ll_null)
//ll_id_ana=dw_8.getitemnumber(1, "id_anagrafica")
ls_rag_soc=dw_8.getitemstring(1, "rag_soc_1")
select id_anagrafica
into :ll_id_ana
from dba.anagrafica
where rag_soc_1=:ls_rag_soc;
if ll_id_ana>0 then
	dw_10.retrieve(ll_id_ana)
	//ll_id_ana=dw_10.getitemnumber(1, "id_anagrafica")
else
	select max(codice)
	into :ll_new_codice
	from dba.anagrafica;
	ll_new_codice++
	//non c'è va inserita: copio la riga nella dw_10
	dw_8.rowscopy(1, 1, primary!, dw_10, 1, primary!)
	dw_10.setitem(1,"id_anagrafica", ll_null)
	dw_10.setitem(1,"codice", ll_new_codice)
	dw_10.setitemstatus(1, 0, Primary!, NewModified!)
	dw_10.trigger event ue_update()
	ll_id_ana=dw_10.getitemnumber(1, "id_anagrafica")
end if
return ll_id_ana
end function

public function string wf_estrai_cod_barre (string as_numero);as_numero=right(as_numero, 5)
return as_numero
end function

public subroutine wf_salva_in_listino (decimal adc_prezzo, long al_id_uc, long al_id_variazione);decimal ldc_prezzo_man, ldc_prezzo_esistente
string ls_tipo, ls_confermato

select tipo into :ls_tipo from dba.unita_misura m, dba.unita_confezione u
where u.id_unita_confezione=:al_id_uc and u.id_unita_misura=m.id_unita_misura
;
if isnull(ls_tipo) or ls_tipo="" then ls_tipo='N'
if ls_tipo<>"N" or ls_tipo<>"P" then ls_tipo='N'
if ls_tipo='P' then //è a "peso" quindi "prezzo manifattura"
	select prezzo_manifattura, confermato
	into :ldc_prezzo_esistente, :ls_confermato
	from dba.prezzo
	where id_unita_confezione=:al_id_uc and id_variazione=:al_id_variazione
	;
elseif ls_tipo='N' then //è al pezzo quindi "prezzo"
	select prezzo, confermato
	into :ldc_prezzo_esistente, :ls_confermato
	from dba.prezzo
	where id_unita_confezione=:al_id_uc and id_variazione=:al_id_variazione
	;
else
	messagebox("Attenzione!", "Tipo dell'unità di misura non trovato (nè P nè N!!!)")
	return
end if
if isnull(ls_confermato) or ls_confermato<>'S' then // inserisco quello nuovo nel listino
	if ls_tipo='P' then
		insert into dba.prezzo(id_variazione, id_unita_confezione, prezzo_manifattura, des_1)
		values(:al_id_variazione, :al_id_uc, :adc_prezzo, 'Da importa documenti')
		;
		if sqlca.sqlnrows>0 then
			commit;
		else
			update dba.prezzo set prezzo_manifattura=:adc_prezzo
			where id_variazione=:al_id_variazione and id_unita_confezione=:al_id_uc
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo non aggiornato/inserito!")
			end if
		end if
	else
		insert into dba.prezzo(id_variazione, id_unita_confezione, prezzo, des_1)
		values(:al_id_variazione, :al_id_uc, :adc_prezzo, 'Da importa documenti')
		;
		if sqlca.sqlnrows>0 then
			commit;
		else
			update dba.prezzo set prezzo=:adc_prezzo
			where id_variazione=:al_id_variazione and id_unita_confezione=:al_id_uc
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo non aggiornato/inserito!")
			end if
		end if
	end if
else
	//messagebox("Attenzione!", "Prezzo già confermato!")
end if
end subroutine

public subroutine wf_agg_articoli (string as_cod_art, long al_riga);string ls_codice, ls_tipo_um, ls_confermato,ls_simbolo_um
long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_art_riga, ll_id_cat_cod
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc, ll_id_variazione, ll_test
decimal ldc_prezzo
datetime ldt_datatime
integer li_ret


setnull(ll_null)

select id_articolo into :ll_test from dba.articolo where codice=:as_cod_art;
if isnull(ll_test) or ll_test<=0 then
 //l'articolo non esiste occorre inserirlo
		dw_6.reset()		
		dw_4.rowscopy(al_riga, al_riga, primary!, dw_6, 1, primary!)
		dw_6.setitem(1, "id_articolo", ll_null)
		select id_cat_codifica into :ll_id_cat_cod from dba.cat_codifica where codice='AUTO';
		dw_6.setitem(1,"id_cat_codifica", ll_id_cat_cod)
		dw_6.setitem(1,"id_sog_comm_variante", ll_null)
		dw_6.setitemstatus(1, 0, Primary!, NewModified!)
		li_ret=dw_6.trigger event ue_update()
		if li_ret<>1 then messagebox("Attenzione!", "Art. "+ string(as_cod_art)+" NON inserito!")
end if
	



end subroutine

public function long wf_trova_art (string as_cod_articolo, long al_riga_doc);string  ls_tipo_um, ls_confermato,ls_simbolo_um
long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_art_riga, ll_id_cat_cod
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc, ll_id_variazione
decimal ldc_prezzo
datetime ldt_datatime

setnull(ll_null)

//ll_riga_trovata=dw_4.find("id_articolo='"+string(as_cod_articolo)+"'", 1, dw_4.rowcount())


	select a.id_articolo, u.id_unita_confezione
	into :ll_id_art_locale, :ll_id_uc
	from dba.articolo a, dba.unita_confezione u
	where a.codice=:as_cod_articolo
	and u.unita_base='S'
	and a.id_articolo=u.id_articolo
	;
	if ll_id_art_locale>0 then //l'articolo esiste già non si deve fare nulla , quasi nulla
		dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
		dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
		
	else //l'articolo non esiste occorre inserirlo
		//se azienda =silverdreams non si caricano articoli nuovi.... 18-05-2021
		if pos(ls_azienda, "SILVER DR")>0 then 
			messagebox("Attenzione!", "Art. "+ string(as_cod_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON PRESENTE NEL NOSTRO ARCHIVIO!")
			return 0
		end if
		dw_6.reset()
		dw_7.reset()
		ll_riga_trovata_uc=dw_5.find("codice='"+string(as_cod_articolo)+"'", 1, dw_5.rowcount())
		if ll_riga_trovata_uc>0 then
			dw_4.rowscopy(ll_riga_trovata, ll_riga_trovata, primary!, dw_6, 1, primary!)
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
			messagebox("Attenzione!", "Art. "+ string(as_cod_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON PRESENTE NEL FILE ART.txt")
		end if
	
		end if

		if pos(ls_azienda, "PANNA")>0 then
			select simbolo into :ls_simbolo_um from dba.unita_misura u, unita_confezione uc
			where uc.id_unita_misura=u.id_unita_misura and uc.id_unita_confezione=:ll_id_uc;
			ll_id_variazione=	dw_1.getItemnumber(1, "id_variazione")
			//ora inserisco l'articolo nel llistino del'intestatario del doc //prima verifico che non ci sia già e se il prezzo è confermato
			select prezzo into :ldc_prezzo 
			from dba.prezzo where id_unita_confezione=:ll_id_uc and id_variazione=:ll_id_variazione;
			
			if sqlca.sqlcode<>0 then //il record non esiste
				ldt_datatime=datetime(today(), now())
				if ls_simbolo_um='PZ' then //muove a pezzo altrimenti è peso (o cm ecc ma il prezzo allora è in manifattura)
					ldc_prezzo=dw_2.getitemdecimal(al_riga_doc, "prezzo")
					
					insert into dba.prezzo (id_unita_confezione, id_variazione, prezzo, confermato, ultima_modifica)
					values (:ll_id_uc, :ll_id_variazione, :ldc_prezzo, 'N', :ldt_datatime);
					if sqlca.sqlcode=0 then
						commit;
					else
						rollback;
						messagebox("Attenzione!", "Art. "+ string(as_cod_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON inserito in listino!")
					end if	
				else
					ldc_prezzo=dw_2.getitemdecimal(al_riga_doc, "prezzo_manifattura")
					insert into dba.prezzo (id_unita_confezione, id_variazione, prezzo_manifattura, confermato, ultima_modifica)
					values (:ll_id_uc, :ll_id_variazione, :ldc_prezzo, 'N',  :ldt_datatime);
					if sqlca.sqlcode=0 then
						commit;
					else
						rollback;
						messagebox("Attenzione!", "Art. "+ string(as_cod_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON inserito in listino!")
					end if
				end if
		end if
	end if //
	return ll_id_art_locale

end function

public function long wf_articolo (long al_id_articolo, long al_riga_doc);string ls_codice, ls_tipo_um, ls_confermato,ls_simbolo_um
long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_art_riga, ll_id_cat_cod
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc, ll_id_variazione
integer li_num_riga
decimal ldc_prezzo
datetime ldt_datatime

setnull(ll_null)

ll_riga_trovata=dw_4.find("id_articolo="+string(al_id_articolo), 1, dw_4.rowcount())
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
		if pos(ls_azienda, "SILVER DR")>0 then 
			li_num_riga=dw_2.getitemnumber(al_riga_doc, "num_riga")
			messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(li_num_riga)+" ERRORE! ARTICOLO NON PRESENTE NEL NOSTRO ARCHIVIO!")
			return -1
		end if
		dw_6.reset()
		dw_7.reset()
		ll_riga_trovata_uc=dw_5.find("id_articolo="+string(al_id_articolo), 1, dw_5.rowcount())
		if ll_riga_trovata_uc>0 then
			dw_4.rowscopy(ll_riga_trovata, ll_riga_trovata, primary!, dw_6, 1, primary!)
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
			messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON PRESENTE NEL FILE ART.txt")
		end if
	
		end if
	end if //
	if pos(ls_azienda, "PANNA")>0 then
		select simbolo into :ls_simbolo_um from dba.unita_misura u, unita_confezione uc
		where uc.id_unita_misura=u.id_unita_misura and uc.id_unita_confezione=:ll_id_uc;
		ll_id_variazione=	dw_1.getItemnumber(1, "id_variazione")
		ldc_prezzo=dw_2.getitemdecimal(al_riga_doc, "prezzo")
		if ldc_prezzo>0 then
			//ora inserisco l'articolo nel llistino del'intestatario del doc //prima verifico che non ci sia già e se il prezzo è confermato
			select prezzo into :ldc_prezzo 
			from dba.prezzo where id_unita_confezione=:ll_id_uc and id_variazione=:ll_id_variazione;
			
			if isnull(ldc_prezzo) or ldc_prezzo=0 then //il record non esiste
				ldt_datatime=datetime(today(), now())
				if ls_simbolo_um='PZ' then //muove a pezzo altrimenti è peso (o cm ecc ma il prezzo allora è in manifattura)
					ldc_prezzo=dw_2.getitemdecimal(al_riga_doc, "prezzo")
					
					insert into dba.prezzo (id_unita_confezione, id_variazione, prezzo, confermato, ultima_modifica)
					values (:ll_id_uc, :ll_id_variazione, :ldc_prezzo, 'N', :ldt_datatime);
					if sqlca.sqlcode=0 then
						commit;
					else
						rollback;
						update dba.prezzo set prezzo=:ldc_prezzo, confermato='N', ultima_modifica=:ldt_datatime where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;
						if sqlca.sqlcode=0 then
							commit;
						else
							messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON inserito in listino!")
							rollback;
						end if
					end if
				else
					ldc_prezzo=dw_2.getitemdecimal(al_riga_doc, "prezzo_manifattura")
					insert into dba.prezzo (id_unita_confezione, id_variazione, prezzo_manifattura, confermato, ultima_modifica)
					values (:ll_id_uc, :ll_id_variazione, :ldc_prezzo, 'N',  :ldt_datatime);
					if sqlca.sqlcode=0 then
						commit;
					else
						rollback;
						messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON inserito in listino!")
					end if
				end if
			END IF
	end if
end if
return ll_id_art_locale

end function

on w_importa_doc_e_righe.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_carica=create cb_carica
this.dw_3=create dw_3
this.cb_importa=create cb_importa
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cb_reset=create cb_reset
this.dw_8=create dw_8
this.dw_9=create dw_9
this.dw_10=create dw_10
this.dw_11=create dw_11
this.dw_6=create dw_6
this.dw_7=create dw_7
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_carica
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_importa
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_5
this.Control[iCurrent+8]=this.cb_reset
this.Control[iCurrent+9]=this.dw_8
this.Control[iCurrent+10]=this.dw_9
this.Control[iCurrent+11]=this.dw_10
this.Control[iCurrent+12]=this.dw_11
this.Control[iCurrent+13]=this.dw_6
this.Control[iCurrent+14]=this.dw_7
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.cb_2
end on

on w_importa_doc_e_righe.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_carica)
destroy(this.dw_3)
destroy(this.cb_importa)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cb_reset)
destroy(this.dw_8)
destroy(this.dw_9)
destroy(this.dw_10)
destroy(this.dw_11)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;s_list_main ls_list

this.title=string(this.classname())

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_7.settransobject(sqlca)
dw_10.settransobject(sqlca)
dw_11.settransobject(sqlca)

dw_3.insertrow(1)

select rag_soc_1
into :ls_azienda
from dba.azienda
;
ls_azienda=upper(ls_azienda)
if pos(ls_azienda, "PANNAART")>0 then
	dw_3.setitem(1, "id_profilo",28)
	dw_3.setitem(1, "id_sog_commerciale",1869)
elseif  pos(ls_azienda, "BELLA")>0 then
	//dw_3.setitem(1, "id_profilo",28) //qui occorre mettere id profilo giusto (fatfiera)
elseif  pos(ls_azienda, "SILVER D")>0 then
	dw_3.setitem(1, "id_profilo",171)
	dw_3.setitem(1, "id_sog_commerciale",2026)
elseif  pos(ls_azienda, "ITALPANN")>0 then
	
	ls_list = Message.PowerObjectParm
	if ls_list.s_win_parametri="CL" then
		dw_3.setitem(1, "id_sog_commerciale",1924)
		dw_3.setitem(1, "id_profilo",28)
	else
		dw_3.setitem(1, "id_sog_commerciale",1928)
		dw_3.setitem(1, "id_profilo",164)
	end if
elseif pos(ls_azienda, "SILVERGOLD")>0   then
	dw_3.setitem(1, "id_sog_commerciale",1924)
	dw_3.setitem(1, "id_profilo",28)
end if


//idw_master.is_list = Message.PowerObjectParm
//Message.Processed=TRUE
//
//is_tipo_documento= idw_master.is_list.s_win_parametri




end event

type st_1 from w_001`st_1 within w_importa_doc_e_righe
end type

type dw_1 from udw_base within w_importa_doc_e_righe
integer x = 69
integer y = 44
integer width = 3867
integer height = 332
boolean bringtotop = true
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;w_orafo_documento_ordine_cx w_orafo
s_list_main s_list
long ll_id_doc
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=dw_1.getitemnumber(1, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type dw_2 from udw_figlia within w_importa_doc_e_righe
integer x = 69
integer y = 400
integer width = 3867
integer height = 1144
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
end type

event itemchanged;call super::itemchanged;//getfileopenname("Cerca DOCasci_", ls_path, ls_file, "txt", "testo, *.txt", "C:\nita\imp_doc")
end event

type cb_carica from commandbutton within w_importa_doc_e_righe
integer x = 3602
integer y = 1600
integer width = 320
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica "
end type

event clicked;integer li_ret, i
string ls_path, ls_file
long ll_null

setnull(ll_null)
	
getfileopenname("Cerca DOCasci_", ls_path, ls_file, "txt", "testo, *.txt", "C:\nita\imp_doc")
//if  not(trim(ls_file)="" or isnull(ls_file)) then
//	 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_path)
//	end if
//end if	 

li_ret=dw_1.importfile(ls_file, 2, 2)  //importo il documento
//20250109 problemi con i listini/variazioni: cancello eventuali dati
dw_1.setitem(1, "id_listino", ll_null)
dw_1.setitem(1, "id_variazione", ll_null)
if li_ret=1 then
	ls_file="Riga"+right(ls_file, len(ls_file) -3)
	
	li_ret=dw_2.importfile(ls_file, 2, 99999)
	ls_file="Art"+right(ls_file, len(ls_file) -4)
	li_ret=dw_4.importfile(ls_file, 2, 99999)
	ls_file="Uc"+right(ls_file, len(ls_file) -3)
	li_ret=dw_5.importfile(ls_file, 2, 99999)
	
	if pos(ls_azienda, "BELLA") >0 then //fiera bella 2020
		ls_file="ana_"+right(ls_file, len(ls_file) -3)
		li_ret=dw_8.importfile(ls_file, 2, 99999)
		ls_file="sog_com_"+right(ls_file, len(ls_file) -4)
		li_ret=dw_9.importfile(ls_file, 2, 99999)
		
	end if
end if
if pos(ls_azienda, "BELLA") <=0 then
	post wf_cambia_iva()
end if

for i= 1 to dw_5.rowcount()
	dw_5.setitem(i, "id_unita_mis_volume", ll_null)
next



//messagebox("A", li_ret)
//getfileopenname("Cerca RIGAasci_", ls_path, ls_file)
//li_ret=dw_2.importfile(ls_file, 2, 9999)
//messagebox("A", li_ret)
//
//getfileopenname("Cerca ARTasci_", ls_path, ls_file)
//li_ret=dw_4.importfile(ls_file, 2, 9999)
//messagebox("A", li_ret)
//
//getfileopenname("Cerca UCasci_", ls_path, ls_file)
//li_ret=dw_5.importfile(ls_file, 2, 9999)
//messagebox("A", li_ret)
//

end event

type dw_3 from udw_base within w_importa_doc_e_righe
integer x = 1536
integer y = 1576
integer width = 1627
integer height = 180
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_scegli_prof_documento"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_importa from commandbutton within w_importa_doc_e_righe
integer x = 3602
integer y = 1716
integer width = 320
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importa"
end type

event clicked;long ll_id_prof, ll_id_mag, ll_id_reg_mod, ll_id_locazione, ll_id_causale, ll_id_esercizio, ll_id_reg, ll_id_ana,ll_id_variazione,ll_num_bol_mun, ll_numero
date ldt_data_odierna, ldt_data_doc
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
string ls_tipo_registro, ls_numero, ls_des, ls_tipo, ls_tipo_listino, ls_cod_art
long ll_null, ll_righe, ll_id_art, ll_id_doc,ll_num_prog_esistente, ll_id_sog_intestatario, ll_id_doc_esistente
long ll_id_listino_associato, ll_id_uc,ll_riga_madre, ll_new_riga_doc, ll_id_art_ret
integer i, li_ret, li_pos
decimal ldc_prezzo,ldc_coef_calo
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

setnull(ll_null)
dw_3.accepttext()
if pos(ls_azienda, "BELLA")>0 then  //bella fiera 2020
	ll_id_ana=wf_imp_anagrafica()
	if ll_id_ana=0 then return
	ll_id_sog_intestatario=wf_imp_sog_com(ll_id_ana)
else
	ll_id_sog_intestatario=dw_3.getitemnumber(1, "id_sog_commerciale")
end if

if ll_id_sog_intestatario>0 then
	ldt_data_doc=dw_1.getitemdate(1, "data_documento")
	//controllo se ha un listino associato e lo riporto nel doc. che creo
	select id_listino, tipo
	into :ll_id_listino_associato, :ls_tipo
	from dba.sog_commerciale
	where id_sog_commerciale=:ll_id_sog_intestatario
	;
	if ll_id_listino_associato>0 then
		select id_variazione
		into :ll_id_variazione
		from dba.variazione
		where id_listino=:ll_id_listino_associato
		and data_inizio<= :ldt_data_doc and data_fine>=:ldt_data_doc
		;
	else
		if ls_tipo='F' then ls_tipo_listino='A' else ls_tipo_listino='V'
		select id_variazione, l.id_listino
		into :ll_id_variazione, :ll_id_listino_associato
		from dba.variazione v, dba.listino l
		where v.id_listino=l.id_listino
		and tipo=:ls_tipo_listino and lis_base='S'  
		and data_inizio<= :ldt_data_doc and data_fine>=:ldt_data_doc
		;
	end if
	ll_id_prof=dw_3.getitemnumber(1, "id_profilo")
	if ll_id_prof>0 then
		
		//con il profilo trovo magazzino, locazione, causale e registro (modello)
		select id_magazzino_1_prop, id_mod_registro_prop, id_locazione_1_prop, id_caus_magazzino_prop
		into :ll_id_mag, :ll_id_reg_mod, :ll_id_locazione, :ll_id_causale
		from dba.prof_documento
		where id_prof_documento=:ll_id_prof
		;
		//ora trovo il registro attuale (modello registro riportato alla data odierna)
		ldt_data_odierna=date(today())
		select id_esercizio
		into :ll_id_esercizio
		from dba.esercizio
		where data_inizio<= :ldt_data_odierna
		and data_fine>=:ldt_data_odierna
		;
		SELECT Max("registro"."id_registro")
		INTO :ll_id_reg  
		FROM "dba"."registro"  
		WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
				( "registro"."id_mod_registro" = :ll_id_reg_mod )   ;
		select tipo_registro
		into :ls_tipo_registro
		from dba.registro
		where id_registro=:ll_id_reg;
		//poi trovo num_progressivo e data registrazione (data odierna)
		uo_proponi_num_progressivo=create u_setta_campi_documento
		ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_reg, 0, ls_tipo_registro)
		destroy uo_proponi_num_progressivo
		//controllo che il documento non esista già
		ls_numero=dw_1.getitemstring(1, "num_documento")
		//ldt_data_doc=dw_1.getitemdate(1, "data_documento")
		ll_num_prog_esistente=0
		select num_progressivo, id_documento
		into :ll_num_prog_esistente, :ll_id_doc_esistente
		from dba.documento
		where id_registro=:ll_id_reg
		and num_documento=:ls_numero
		and data_documento=:ldt_data_doc and id_sog_commerciale=:ll_id_sog_intestatario
		;
		if ll_num_prog_esistente>0 then
			if messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog_esistente)+"! Vuoi aprirlo?", stopsign!, yesno!)=1 then
				s_list.s_identifica[1]="id_documento"
				s_list.s_modo=modo_modifica
				s_list.l_identifica[1]=ll_id_doc_esistente
				openwithparm(w_orafo, s_list)
			end if	
		else
			dw_1.SetItem(1, "id_sog_commerciale", ll_id_sog_intestatario)
			dw_1.SetItem(1, "id_sog_commerciale_fattura", ll_id_sog_intestatario)
			//20220926 prendeva la banca della ditta inviante.... annullo
			dw_1.SetItem(1, "id_banca_sog_commerciale", ll_null)
			dw_1.SetItem(1, "tipo_fattura", "N")
			//agg. 27-05-2020
			dw_1.SetItem(1, "id_listino", ll_id_listino_associato)
			dw_1.SetItem(1, "id_variazione", ll_id_variazione)
			//fine2705
			dw_1.SetItem(1, "id_registro", ll_id_reg)
			dw_1.SetItem(1, "id_prof_documento", ll_id_prof)
			ll_num_prog_esistente=dw_3.getitemnumber(1, "num_progressivo")
			//20231117 aggiungo la possibilità di inserire il doc in progressivo scelto dall'utente (il controllo di coerenza è a carico dell'utente!!!!)
			if ll_num_prog_esistente>0 then
				dw_1.SetItem(1, "num_progressivo",ll_num_prog_esistente)
			else  //fine 20231117
				dw_1.SetItem(1, "num_progressivo", ls_trova_prog.sl_num_progressivo)
			end if
			dw_1.SetItem(1, "data_registrazione", ldt_data_odierna)
			dw_1.SetItem(1, "id_caus_magazzino", ll_id_causale)
			dw_1.SetItem(1, "id_locazione_1", ll_id_locazione)
			dw_1.SetItem(1, "id_magazzino", ll_id_locazione)
			dw_1.SetItem(1, "origine", "PDA doc. importato il "+string(datetime(today(),now()) ,"dd/mm/yy hh:mm:ss"))
			dw_1.SetItem(1, "id_documento", ll_null)
			dw_1.SetItem(1, "id_destinazione", ll_null)
			//08/03/2021 aggiungo annullamento condizine pagamento
			dw_1.SetItem(1, "id_con_pagamento", ll_null)
			dw_1.setitemstatus(1, 0, Primary!, NewModified!)
			li_ret=dw_1.trigger event ue_update()
			ll_id_doc=dw_1.getitemnumber(1, "id_documento")
			if ll_id_doc>0 then
				ll_righe=dw_2.rowcount()
				for i= 1 to ll_righe
					ll_riga_madre=dw_2.getItemnumber(i, "id_riga_documento")
					if  ll_riga_madre> 0 then
						dw_2.SetItem(i, "id_documento", ll_id_doc)
						dw_2.SetItem(i, "id_riga_documento", ll_null)
						//20221018 aggiungo per poter fare le stampe
						dw_2.setitem(i, "provv_imp_subage_2", ll_riga_madre)  //questo è il legame con la bollettina
						//20221018 fine										
						//dw_2.SetItem(i, "id_riga_doc_provenienza", ll_null)  //commento perché la uso 20210219
						dw_2.SetItem(i, "id_caus_magazzino", ll_id_causale)
						dw_2.SetItem(i, "id_locazione_1", ll_id_locazione)
						dw_2.SetItem(i, "id_locazione_2", ll_null)
						dw_2.SetItem(i, "id_des_articolo", ll_null)
						//27-05-2020 inserisco id_variaizone e azzero eventuali qta evase
						dw_2.SetItem(i, "id_listino", ll_id_variazione)
						dw_2.SetItem(i, "qta_evasa", 0)
						dw_2.SetItem(i, "peso_netto_evaso", 0)
						dw_2.SetItem(i, "qta_EVASA_UN_base", 0)
						
						if pos(ls_azienda, "PANNA")>0 or  pos(ls_azienda, "SILVERG")>0 or  pos(ls_azienda, "STELLE")>0 or pos(ls_azienda, "TITANS")>0 then
							ls_numero=wf_estrai_cod_barre(ls_numero)
							dw_2.SetItem(i, "id_des_articolo", ll_null)
							dw_2.SetItem(i, "id_conto", ll_null)
							// dw_2.SetItem(i,"provv_imp_carea_2", ls_numero) // per la SILVER sono lacci  per PANNA è il numero della bollettina ...
							//20220412 cambio perché i lacci servono anche a Italpanna (provv_imp_carea sembra inutillizzata finora)
							 dw_2.SetItem(i,"provv_imp_carea_2", ls_numero)  //20240122 erA provv_imp_carea, ma non salvava, provv_imp_carea è in tutte le righr nullo!!!
							 //ll_numero=integer(ls_numero)
							//dw_2.SetItem(i,"provv_imp_carea", ll_numero) //20251014 metto per le ragioni di cui sopra ho cambiato anche il modo di ricercare in w_lega_doc_a_bollettina_pop
							//il valore della galvanica (prezzo_metallo) NON interessa PANNA
							dw_2.SetItem(i, "prezzo_metallo", ll_null)
							dw_2.SetItem(i, "id_gruppo_agenti_2", ll_null)
							ldc_prezzo=dw_2.getitemdecimal(i, "prezzo_manifattura")
							if isnull(ldc_prezzo) or ldc_prezzo=0 then ldc_prezzo=dw_2.getitemdecimal(i, "prezzo_complessivo")
							ll_id_uc=dw_2.getitemnumber(i, "id_unita_confezione")
							//salvo il prezzo nel listino del cliente/fornitore (silver)
							if ldc_prezzo> 0 then wf_salva_in_listino(ldc_prezzo, ll_id_uc, ll_id_variazione)
						else
							//se l'azienda è silverd  //aggiunto 26-05-2020 perché a Samy appariva num bol nei lacci
//							if pos(ls_azienda, "SILVER")>0 then
//								ll_num_bol_mun=dw_2.getItemdecimal(i,"provv_imp_carea_2")
//								dw_2.SetItem(i,"provv_imp_carea_2", ll_null) 
//								dw_2.SetItem(i, "id_locazione_2", ll_num_bol_mun)
//								ll_num_bol_mun=0
//							end if
						end if
						ls_des=dw_2.getitemstring(i, "descrizione")
						li_pos=pos(ls_des, "::")
						if li_pos>0 then
							ls_des=left(ls_des, li_pos - 1)
							dw_2.SetItem(i, "descrizione", ls_des)
						end if
						
						ll_id_art=dw_2.getitemnumber(i, "id_articolo")
						ll_id_art_ret=wf_articolo(ll_id_art, i)
						if ll_id_art_ret>0 then ll_id_art=ll_id_art_ret
						if pos(ls_azienda, "SILVER DRE")>0 and ll_id_prof=171  then //20220825 ANNA se è XRCLF calo=titolo
							ldc_coef_calo=0
							select titolo into :ldc_coef_calo from orafo_titolo o, articolo a
							where o.id_titolo=a.id_titolo and a.id_articolo=:ll_id_art;
							if ldc_coef_calo>0 then dw_2.SetItem(i, "coef_calo", ldc_coef_calo)
						end if
						
						dw_2.setitemstatus(i, 0, Primary!, NewModified!)
					else
						dw_2.deleterow(i)
						ll_righe --
						i --
					end if
					
				next
				li_ret=dw_2.trigger event ue_update()	
//				if li_ret=1 then
//					ll_new_riga_doc=dw_2.getitemnumber(i, "id_riga_documento")
//					insert into dba.produzione_2011 (id_bollettina, id_doc_produzione)
//					values(:ll_id_doc, :ll_new_riga_doc)
//					;
//					if sqlca.sqlNrows>0 then
//						commit;
//					else
//						rollback;
//						messagebox("Attenzione!", "Legame bollettina-riga_doc_produzione per bol: "+ls_num_bol+" NON è stato salvato!")
//					end if
//				end if
			else
				messagebox("Attenzione!", "Doc NON salvato!!")
			end if
		end if
		dw_1.enabled=true
	else
		messagebox("Attenzione!", "Inserire il profilo documento!!")
	end if
else
	messagebox("Attenzione!", "Inserire l'intestatario del documento!!")
end if
	
	
	

end event

type dw_4 from udw_base within w_importa_doc_e_righe
integer x = 27
integer y = 1564
integer width = 1445
integer height = 532
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type dw_5 from udw_base within w_importa_doc_e_righe
integer x = 1531
integer y = 1776
integer width = 1403
integer height = 316
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_unita_confezione_2016"
boolean hscrollbar = true
end type

type cb_reset from commandbutton within w_importa_doc_e_righe
integer x = 3602
integer y = 2004
integer width = 320
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset"
end type

event clicked;dw_1.reset()
dw_2.reset()
dw_4.reset()
dw_5.reset()
dw_6.reset()
dw_7.reset()
dw_8.reset()
dw_9.reset()
dw_10.reset()
dw_11.reset()
end event

type dw_8 from udw_base within w_importa_doc_e_righe
integer x = 2089
integer y = 2152
integer width = 1445
integer height = 276
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_anagrafica_2016"
boolean hscrollbar = true
end type

type dw_9 from udw_base within w_importa_doc_e_righe
integer x = 2089
integer y = 2444
integer width = 1445
integer height = 460
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_sog_comm_2016"
boolean hscrollbar = true
end type

type dw_10 from udw_base within w_importa_doc_e_righe
integer x = 9
integer y = 2564
integer width = 910
integer height = 352
integer taborder = 40
boolean bringtotop = true
string dataobject = "ds_anagrafica_2016"
boolean hscrollbar = true
end type

type dw_11 from udw_base within w_importa_doc_e_righe
integer x = 974
integer y = 2560
integer width = 910
integer height = 352
integer taborder = 40
boolean bringtotop = true
string dataobject = "ds_sog_comm_2016"
boolean hscrollbar = true
end type

type dw_6 from udw_base within w_importa_doc_e_righe
integer x = 23
integer y = 2240
integer width = 1221
integer height = 280
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type dw_7 from udw_base within w_importa_doc_e_righe
integer x = 1266
integer y = 2236
integer width = 2715
integer height = 640
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_unita_confezione_2016"
boolean hscrollbar = true
end type

type cb_1 from commandbutton within w_importa_doc_e_righe
boolean visible = false
integer x = 3058
integer y = 1964
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;integer i, a
long ll_riga
string ls_dato

for i= 1 to dw_4.rowcount()
	ll_riga=dw_6.insertrow(0)
	for a=1 to 49
		if a>=1 and a<10 then
			ls_dato=dw_4.getitemstring(i, "a_0"+string(a) )
		else
			ls_dato=dw_4.getitemstring(i, "a_"+string(a) )
		end if
		if a=2 then
			dw_6.setitem(i, "codice", ls_dato)
		elseif a=3 then
			dw_6.setitem(i, "id_cat_codifica", long(ls_dato))
		else
			dw_6.object.datawindow.data[ll_riga, a]= ls_dato 
			//dw_6.setitem(i, a, ls_dato)
		end if
		//dw_6.object.datawindow.data[ll_riga, a]= ls_dato 
	next
	
next


//dw_4.rowscopy(1, dw_4.rowcount(), primary!, dw_6,  1, primary!)
end event

type cb_2 from commandbutton within w_importa_doc_e_righe
boolean visible = false
integer x = 3104
integer y = 1836
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;integer li_ret, i
string ls_path, ls_file,ls_cod_art

getfileopenname("Cerca DOCasci_", ls_path, ls_file, "txt", "testo, *.txt", "C:\nita\imp_doc")



	li_ret=dw_4.importfile(ls_file, 2, 99999)
	for i = 1 to dw_4.rowcount()
		ls_cod_art=dw_4.getitemstring(i, "codice")
		wf_agg_articoli(ls_cod_art, i)
	next

end event

