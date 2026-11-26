forward
global type w_orafo_documento_ordine_cx from w_documento_ordine_cx
end type
type cb_var_prezzo from commandbutton within tabpage_1
end type
type dw_orafo_wizard from datawindow within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type cb_prezzi_confermati from commandbutton within tabpage_1
end type
type cb_controlla_bollettine from commandbutton within tabpage_1
end type
type cb_cambia_iva from commandbutton within tabpage_1
end type
type cb_5 from commandbutton within tabpage_1
end type
type cb_6 from commandbutton within tabpage_1
end type
type cb_rbol_non_derivati from commandbutton within tabpage_1
end type
type cb_12 from commandbutton within tabpage_1
end type
type cb_cambia_prof from commandbutton within tabpage_1
end type
type dw_5 from udw_001 within tabpage_1
end type
type pb_excel from picturebutton within tabpage_1
end type
type rb_per_articolo from radiobutton within tabpage_1
end type
type rb_per_riga from radiobutton within tabpage_1
end type
type cb_13 from commandbutton within tabpage_1
end type
type r_1 from rectangle within tabpage_1
end type
type r_2 from rectangle within tabpage_1
end type
type pb_riep_pesi from picturebutton within tabpage_2
end type
type cb_quotazione from commandbutton within tabpage_2
end type
type pb_stampa_righe from picturebutton within tabpage_2
end type
type pb_legenda from picturebutton within tabpage_2
end type
type cb_agg_listino from commandbutton within tabpage_2
end type
type dw_nota_riga from udw_base within tabpage_2
end type
type cb_rec_prezzi from commandbutton within tabpage_2
end type
type hpb_avanzamento from hprogressbar within tabpage_2
end type
type cb_libre_calc from commandbutton within tabpage_2
end type
type cb_f_c from commandbutton within tabpage_2
end type
type cb_partite from commandbutton within tabpage_2
end type
type dw_des_aggiuntiva from udw_base within tabpage_2
end type
type cb_pacco from commandbutton within tabpage_2
end type
type pb_1 from picturebutton within tabpage_2
end type
type cbx_decimali from checkbox within tabpage_2
end type
type pb_cod_barre_bollettine from picturebutton within tabpage_2
end type
type cb_copia_riga from commandbutton within tabpage_2
end type
type cbx_des_3 from checkbox within tabpage_2
end type
type cb_4 from commandbutton within tabpage_2
end type
type cbx_incartato from checkbox within tabpage_2
end type
type cb_reso_non_lavorato from commandbutton within tabpage_2
end type
type dw_3 from udw_000 within tabpage_2
end type
type dw_4 from udw_000 within tabpage_2
end type
type cbx_agg_coef_calo from checkbox within tabpage_2
end type
type cb_8 from commandbutton within tabpage_2
end type
type cb_9 from commandbutton within tabpage_2
end type
type cb_coef_calo_925 from commandbutton within tabpage_2
end type
type cb_10 from commandbutton within tabpage_2
end type
type cb_11 from commandbutton within tabpage_2
end type
type st_des_3_prezzo from statictext within tabpage_2
end type
type pb_2 from picturebutton within tabpage_2
end type
type pb_3 from picturebutton within tabpage_2
end type
type dw_6 from udw_001 within tabpage_2
end type
type cb_csv from commandbutton within tabpage_2
end type
type dw_9 from udw_000 within tabpage_2
end type
type dw_2 from udw_001 within tabpage_4
end type
type cb_2 from commandbutton within tabpage_4
end type
type tabpage_7 from userobject within tab_1
end type
type dw_esplodi from datawindow within tabpage_7
end type
type dw_salva_prezzo_in_listino from datawindow within tabpage_7
end type
type tabpage_7 from userobject within tab_1
dw_esplodi dw_esplodi
dw_salva_prezzo_in_listino dw_salva_prezzo_in_listino
end type
type p_sigle_prezzi from picture within w_orafo_documento_ordine_cx
end type
type pb_st_art_foto from picturebutton within w_orafo_documento_ordine_cx
end type
type rb_2 from radiobutton within w_orafo_documento_ordine_cx
end type
type rb_1 from radiobutton within w_orafo_documento_ordine_cx
end type
type cb_chiudi_ordine from commandbutton within w_orafo_documento_ordine_cx
end type
type cbx_tara from checkbox within w_orafo_documento_ordine_cx
end type
type cbx_1 from checkbox within w_orafo_documento_ordine_cx
end type
type cb_verifica_prezzi from commandbutton within w_orafo_documento_ordine_cx
end type
type rb_meno_10 from radiobutton within w_orafo_documento_ordine_cx
end type
type rb_10 from radiobutton within w_orafo_documento_ordine_cx
end type
type rb_meno_15 from radiobutton within w_orafo_documento_ordine_cx
end type
type rb_15 from radiobutton within w_orafo_documento_ordine_cx
end type
type cb_sconta from commandbutton within w_orafo_documento_ordine_cx
end type
type cb_7 from commandbutton within w_orafo_documento_ordine_cx
end type
type dw_7 from udw_000 within w_orafo_documento_ordine_cx
end type
type dw_8 from udw_000 within w_orafo_documento_ordine_cx
end type
end forward

global type w_orafo_documento_ordine_cx from w_documento_ordine_cx
integer x = 347
integer y = 160
integer width = 4233
integer height = 2336
string title = "Documento"
long backcolor = 134217728
string icon = "AppIcon!"
windowanimationstyle closeanimation = rightslide!
boolean ib_close_query = true
p_sigle_prezzi p_sigle_prezzi
pb_st_art_foto pb_st_art_foto
rb_2 rb_2
rb_1 rb_1
cb_chiudi_ordine cb_chiudi_ordine
cbx_tara cbx_tara
cbx_1 cbx_1
cb_verifica_prezzi cb_verifica_prezzi
rb_meno_10 rb_meno_10
rb_10 rb_10
rb_meno_15 rb_meno_15
rb_15 rb_15
cb_sconta cb_sconta
cb_7 cb_7
dw_7 dw_7
dw_8 dw_8
end type
global w_orafo_documento_ordine_cx w_orafo_documento_ordine_cx

type variables
s_orafo_partite us_dati_partita
integer ii_flag2, il_test_protezione, ii_gia_fatto, ii_righe_fatte[]
long il_id_riga_documento[]
decimal{4} id_quantita[]
u_ges_ordini u_ordini
datastore ids_salva_prezzo_in_listino, ids_ev_forzata
long il_id_riga_cancellata[]
datastore ids_ord_cli_fo, ds_excel
string is_pz_giacenza
//20261126 REC come nella 64_2025: barra di avanzamento e specchietto delle righe cambiate
long il_avanz_totale     //barra di avanzamento (hpb_avanzamento): passi totali della procedura in corso
integer ii_avanz_perc    //ultima percentuale mostrata: la barra si ridisegna solo quando cambia
boolean ib_rl_attivo     //true durante il REC: ue_rec_prezzo annota in is_rl_mot cosa ha fatto sul prezzo
decimal idc_rl_pc[], idc_rl_pm[], idc_rl_tot[]
string is_rl_mot[]



end variables

forward prototypes
public function long wf_crea_id_riga_partita (long al_row)
public function string wf_trova_cod_tipo_partita (long id_caus_magazzino)
public function integer wf_cancella_partite (long al_id_riga_partita, ref datastore adw_aper, ref datastore adw_scar)
public function decimal wf_converti_in_fino (decimal ad_qta_legato, long al_id_titolo)
public subroutine wf_setcolumn_prezzo ()
public subroutine wf_controlla_par_zoppe ()
public function integer wf_recupera_partite_zoppe (long al_id_doc, long al_id_titolo, long al_id_sog_comm)
public subroutine wf_salva_des_personale ()
public subroutine wf_aggiorna_scarico_borsa (integer ai_flag2)
public function string wf_cod_barre (long valore)
public subroutine wf_setta_riga_copiata (integer i)
public subroutine wf_ripristina_evasa (long ll_id_doc, integer li_righe_cancellate)
public subroutine wf_setto_id_riga_sorgente ()
public function decimal wf_propone_prezzo_metallo (long al_id_articolo, date data_registrazione, decimal quotazione)
public function boolean wf_controllo_saldi ()
public function integer wf_setta_mask_riga ()
public function integer wf_cancella_riga1 (long al_row)
public function integer wf_integra_autofind (integer al_row)
public function integer uf_importa_righe_orafo (s_par_der_doc astr_par)
public function decimal wf_gestione_coef_calo (long al_row, decimal al_id_art)
public function integer wf_controlla_range_coef_calo (long al_id_titolo, datawindow adw, long row, string column, integer ad_coef_calo)
public function integer wf_salva_ds_partite ()
public subroutine wf_ricarica_partite ()
public subroutine wf_controlla_partita (long al_row, decimal ad_valore_vecchio, long al_id_titolo, decimal ad_fino_da_controllare, string as_campo_da_settare)
public subroutine wf_crea_oggetto_per_ordini ()
public subroutine wf_cancella_aper_partita (long al_id_doc, long al_id_titolo, decimal ad_val_scarico, long al_riga)
public function integer wf_gestione_partite (long row, ref decimal ad_peso, decimal ad_peso_originale, decimal ad_coef_calo)
public subroutine wf_cerca_dis_cliente (long al_row)
public subroutine wf_crea_datastore ()
public function integer wf_apri_partita (long al_id_documento)
public subroutine wf_calcola_prezzo (long row)
public function integer wf_acq_cliente (long al_id_articolo, long al_id_soggetto)
public subroutine wf_forza_chius_evasione (long al_riga, string as_ev_forzata)
public subroutine wf_controllo_id_riga_doc_prov (long al_id_riga_doc_prov, long al_num_riga, string as_ev_forzata)
public subroutine wf_salva_lung_peso ()
public function s_lung_peso wf_ric_lung_variante (long al_riga, string as_data)
public subroutine wf_lung_canc_id_riga (long al_riga)
public subroutine wf_storno_lung_peso ()
public function integer wf_tolleranza (long al_riga, decimal ad_peso_totale, decimal ad_qta)
public subroutine wf_blocca_ddt_fatturato ()
public subroutine wf_spese_confezionamento ()
public subroutine wf_controlla_doppioni ()
public subroutine wf_setitem (long al_riga, string as_colonna, datawindow adw, decimal adc_valore)
public subroutine wf_euro_valuta (string ls_trasforma)
public subroutine wf_salva_cod_art_cliente ()
public subroutine wf_trova_cod_art_cliente (string as_articolo, long al_id_articolo)
public subroutine w_recupera_non_prezioso (long al_row, decimal al_qta)
public subroutine wf_gestione_utenti ()
public subroutine wf_salva_note_riga ()
public subroutine wf_ricalcola_figli (decimal adc_qta_originale, decimal adc_qta_new, long al_riga)
public subroutine wf_inserisci_id_ordine (long al_row)
public subroutine wf_prezzo_galvanica (long al_row, string as_cod_art)
public subroutine wf_togli_tara (long al_row, decimal adc_peso, dwobject a_dwo)
public subroutine wf_prod_2011 ()
public subroutine wf_rec_galvanica (string as_id, long al_riga)
public subroutine wf_ric_giac_partita_pezzo ()
public subroutine wf_car_nota_art_in_produzione (long al_row)
public subroutine wf_copia_riga (long al_riga)
public function decimal wf_calcola_qta_residua_bollettina (long al_id_bollettina, long al_id_riga_madre)
public subroutine wf_ges_partite_da_deriva ()
public function integer wf_controlla_legato ()
public subroutine wf_clicca_cb_partite ()
public subroutine wf_attenzione ()
public subroutine wf_proteggi_prezzi_confermati (long al_row, decimal adc_old_value, string as_campo)
public subroutine wf_art_aut_del_fornitore ()
public function integer wf_carica_datastore ()
public subroutine wf_prezzo_modificato (long al_riga, string as_data, string as_colonna)
public subroutine wf_des_aggiuntiva (long al_riga)
public subroutine wf_retrieve_riga_doc_2 ()
public subroutine wf_ins_riga_2 ()
public subroutine wf_delete_riga_2 (long al_riga)
public subroutine wf_salva_riga_doc_2 ()
public subroutine wf_cancella_riga_2 (long al_riga)
public subroutine wf_ins_righe_per_scar_metallo (long al_righe)
public subroutine wf_rec_des_aggiuntiva (long al_riga, long al_id_articolo, string as_cod_articolo)
public subroutine wf_salva_prezzo_in_listino (long al_riga, decimal ad_prezzo, integer ai_flag, long ll_id_uc)
public subroutine wf_controlla_profilo ()
public subroutine wf_cod_barre_bollettine ()
public subroutine wf_ka_kr_rec_galvanica (long al_riga, string as_cod_articolo, long al_prof_doc)
public subroutine wf_controlla_righe_stessa_riga_madre ()
public function integer uf_importa_righe (s_par_der_doc astr_par)
public subroutine wf_ricopia_iva_su_tutte_righe (long al_id_tab_iva, long al_prima_riga)
public subroutine wf_ricopia_listino_tutte_righe (long al_id_variazione, integer al_prima_riga)
public subroutine wf_crea_sald_da_bol_accessori ()
public subroutine wf_incartato_imbustato (long al_row)
public subroutine wf_salva_riga_e_partita ()
public subroutine wf_salva_riga_partita ()
public subroutine wf_sinc_des_agg (long al_riga)
public subroutine wf_aumenta_prezzo (decimal adc_percentuale_aumento)
public function integer uf_wizard_riga ()
public subroutine wf_cartellino (long al_riga)
public subroutine wf_stampa_brogliaccio (integer ai_ordinamento)
public subroutine wf_rec_prezzi_silver (long al_id_prof, string as_cod_azienda, string as_tipo_reg, long al_id_sog)
public function long wf_copia_riga_bollettina (long al_id_bollettina)
public function decimal wf_rec_prezzo_distinta (long al_id_art, long al_id_art_padre)
public function long wf_contr_peso_uni_galvanica (long al_id, long al_riga)
public function integer wf_scarica_partite_automatico ()
public function integer wf_apri_part_automatico (integer al_riga_che_scarica, integer al_id_sog, integer al_id_titolo, integer adc_fino_da_scaricare, integer al_id_doc_inserito)
public function integer wf_car_ds_automatico (long al_id_sog)
public subroutine wf_setta_fino_calo (long row)
public subroutine wf_calcola_fino_calo (long row)
public subroutine wf_magg_per_quantita (long al_riga)
public subroutine wf_salva_riga_doc_estensione (long al_row)
public subroutine wf_avanz_inizio (long al_totale)
public subroutine wf_avanz_passo (long al_fatti)
public subroutine wf_avanz_fine ()
public subroutine wf_rec_log_prima ()
public function boolean wf_doc_senza_rec ()
public subroutine wf_rec_log_dopo ()
public function string wf_rl_col (string as_testo, integer ai_larghezza, boolean ab_destra)
end prototypes

public function long wf_crea_id_riga_partita (long al_row);

long ll_id_riga_partita
integer li_ret
if tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()>0 then
	ll_id_riga_partita=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(al_row, "id_riga_partita")
	if isnull(ll_id_riga_partita) then
		select id_riga_partita
		into :ll_id_riga_partita
		from orafo_riga_partita;
		if sqlca.sqlcode<>0 then
			if sqlca.sqlcode=100 then
				insert into orafo_riga_partita
				(id_riga_partita)
				values(1);
				if sqlca.sqlcode=0 then
					ll_id_riga_partita=1
					commit;
				else
					messagebox("Insert!", "Recupero errato dell'id_riga_partita")
					rollback;
					return 0
				end if
			else 
				messagebox("Errore!", "2Recupero errato dell'id_riga_partita")
				return 0
			end if
		end if
			
			if isnull(ll_id_riga_partita) then ll_id_riga_partita=0
			
			li_ret=tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
			(al_row, "id_riga_partita", ll_id_riga_partita)
			if li_ret<>1 then messagebox("Id_riga_partita", "Valore non settato!")
		
		
		ll_id_riga_partita +=1
		update orafo_riga_partita
		set id_riga_partita= :ll_id_riga_partita;
		if sqlca.sqlnrows > 0 then
			commit;
		else
			messagebox("Errore!", "Non aggiornato valore id_riga_partita")
		end if
		return (ll_id_riga_partita - 1)
	else
		return ll_id_riga_partita
	end if
end if
end function

public function string wf_trova_cod_tipo_partita (long id_caus_magazzino);
string ls_cod_tipo_partita, ls_partite_attive
select cod_tipo_partita
into :ls_cod_tipo_partita
from  orafo_tipo_partita,  caus_magazzino
where id_caus_magazzino=:id_caus_magazzino
and orafo_tipo_partita.id_tipo_partita=caus_magazzino.id_tipo_partita;
if ls_cod_tipo_partita>"" and not isnull(ls_cod_tipo_partita) then
	select disattiva_partite
	into :ls_partite_attive
	from orafo_par_sistema;
	if ls_partite_attive='S' then ls_cod_tipo_partita=""
	return ls_cod_tipo_partita
else
	
	return "NO COD_PARTITA"
end if
end function

public function integer wf_cancella_partite (long al_id_riga_partita, ref datastore adw_aper, ref datastore adw_scar);//20261028 riscritta: prima CONTROLLA tutto, poi applica.
//Prima toglieva lo scarico e solo dopo cercava la partita: se non la trovava (o lo scarico era piu' grande
//dello scaricato) usciva a meta' lasciando lo scarico tolto e la partita non ricalata.
//Ritorna 1 = fatto (anche se la riga non ha scarichi), 0 = errore, NIENTE e' stato toccato: la riga non va cancellata.
//(Il trigger t_scar_partita_riga_ad, tenuto per il futuro, fara' questo lavoro nel db: allora questa funzione si togliera')
long ll_riga, ll_riga_aper, ll_id_partita, ll_n, k
long ll_righe_scar[], ll_righe_aper[]
decimal ld_val_scarico, ld_val_scar_attuale, ld_nuovo
string ls_stato

if not isvalid(adw_scar) or not isvalid(adw_aper) then
	messagebox("Errore!", "Partite non caricate: la riga non viene cancellata.")
	return 0
end if

//1) raccolgo gli scarichi della riga e per ognuno la sua partita: se ne manca una non tocco niente
ll_riga = adw_scar.find("id_riga_documento=" + string(al_id_riga_partita), 1, adw_scar.rowcount())
do while ll_riga > 0
	ll_id_partita = adw_scar.getitemnumber(ll_riga, "id_partita")
	ll_riga_aper = adw_aper.find("id_partita=" + string(ll_id_partita), 1, adw_aper.rowcount())
	if ll_riga_aper < 1 then
		messagebox("Errore!", "Non trovata la partita " + string(ll_id_partita) + " da ricalare." + &
					"~r~nLa riga NON viene cancellata: chiudere e riaprire il documento e riprovare.")
		return 0
	end if
	ll_n = ll_n + 1
	ll_righe_scar[ll_n] = ll_riga
	ll_righe_aper[ll_n] = ll_riga_aper
	if ll_riga >= adw_scar.rowcount() then exit
	ll_riga = adw_scar.find("id_riga_documento=" + string(al_id_riga_partita), ll_riga + 1, adw_scar.rowcount())
loop

//2) ricalo le partite
for k = 1 to ll_n
	ld_val_scarico = adw_scar.getitemdecimal(ll_righe_scar[k], "val_scarico")
	if isnull(ld_val_scarico) then ld_val_scarico = 0
	ld_val_scar_attuale = adw_aper.getitemdecimal(ll_righe_aper[k], "val_scarico")
	if isnull(ld_val_scar_attuale) then ld_val_scar_attuale = 0
	ls_stato = adw_aper.getitemstring(ll_righe_aper[k], "stato")

	//mai sotto zero: prima qui si fermava a meta' ("Lo scarico è negativo")
	ld_nuovo = ld_val_scar_attuale - ld_val_scarico
	if ld_nuovo < 0 then ld_nuovo = 0

	if ld_nuovo = 0 and (ls_stato = 'Z' or isnull(ls_stato)) then
		//partita aperta solo per questo scarico: si azzera (prima azzerava l'apertura ma lasciava lo scaricato)
		adw_aper.setitem(ll_righe_aper[k], "val_apertura", 0)
		adw_aper.setitem(ll_righe_aper[k], "val_scarico", 0)
	else
		adw_aper.setitem(ll_righe_aper[k], "val_scarico", ld_nuovo)
		if ld_val_scarico > 0 then adw_aper.setitem(ll_righe_aper[k], "stato", 'A')
	end if
next

//3) tolgo gli scarichi, dall'ultimo al primo (gli indici sono in ordine crescente: cosi' non si spostano)
for k = ll_n to 1 step -1
	adw_scar.deleterow(ll_righe_scar[k])
next

return 1
end function

public function decimal wf_converti_in_fino (decimal ad_qta_legato, long al_id_titolo);
decimal{4} ld_fino, ld_titolo
if al_id_titolo=0 then return 0
select titolo
into :ld_titolo
from orafo_titolo
where id_titolo=:al_id_titolo;
if ld_titolo>0 then
	ld_fino=round(ad_qta_legato*ld_titolo/1000, 2)
else
	ld_fino=0
	if isnull(al_id_titolo) then 
		al_id_titolo=0
		
	end if
end if
return ld_fino
end function

public subroutine wf_setcolumn_prezzo ();tab_1.tabpage_2.dw_riga_documento_ordine_gd.setcolumn("prezzo")
end subroutine

public subroutine wf_controlla_par_zoppe ();
long ll_riga_trovata, ll_num_righe, ll_id_partita, ll_id_titolo
integer li_ret, i

ll_num_righe=us_dati_partita.s_dw_scar_partita.rowcount()
for i= 1 to ll_num_righe
ll_id_titolo=us_dati_partita.s_dw_scar_partita.getitemnumber(i, "id_titolo")



ll_riga_trovata=us_dati_partita.s_dw_aper_partita.find("id_titolo="+&
string(ll_id_titolo)+" and stato='Z'", 1, us_dati_partita.s_dw_aper_partita.rowcount())
if ll_riga_trovata>0 then
	ll_id_partita=us_dati_partita.s_dw_aper_partita.getitemnumber(ll_riga_trovata, "id_partita")
	ll_riga_trovata=us_dati_partita.s_dw_scar_partita.find&
	("id_titolo="+string(ll_id_titolo)+" and isNull(id_partita)", 1,ll_num_righe)
	if ll_riga_trovata>0 then
		li_ret=us_dati_partita.s_dw_scar_partita.setitem(ll_riga_trovata, "id_partita", ll_id_partita)
		if li_ret<>1 then messagebox("errore!", "Setitem fallito!")
	else
		if ll_id_partita>0 then 
			
		else
			messagebox("scarico non trovato", "Strano")
		end if
	end if
else
	
end if
next
end subroutine

public function integer wf_recupera_partite_zoppe (long al_id_doc, long al_id_titolo, long al_id_sog_comm);
long ll_riga, ll_id_caus_magazzino, ll_id_documento, ll_num_partite_zoppe, ll_id_sog_comm
integer li_ret
string ls_tipo_partita


ll_riga=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
if ll_riga>0 then
	ll_id_documento=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga, &
								"id_documento")
	ll_id_caus_magazzino=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga, &
								"documento_id_caus_magazzino")
	
	select cod_tipo_partita
	into :ls_tipo_partita
	from orafo_tipo_partita t, caus_magazzino c
	where t.id_tipo_partita=c.id_tipo_partita
	and c.id_caus_magazzino= :ll_id_caus_magazzino;
	if sqlca.sqlcode=0 then
		if left(ls_tipo_partita, 1) = 'A' then
			
			long ll_riga_corrente 
			decimal{2} ld_titolo
			s_partite_zoppe us_par_zoppe
			
			ll_riga_corrente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
			us_par_zoppe.s_ll_id_doc=al_id_doc
			us_par_zoppe.s_ll_id_sog_comm=al_id_sog_comm
			us_par_zoppe.s_ld_legato=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
						(ll_riga_corrente, "riga_documento_peso_netto")
			us_par_zoppe.s_ll_id_titolo=al_id_titolo
			us_par_zoppe.s_ld_coef_calo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
						(ll_riga_corrente, "coef_calo")
			
			if isnull(us_par_zoppe.s_ld_coef_calo) then
				us_par_zoppe.s_qta_da_scaricare=wf_converti_in_fino&
				(us_par_zoppe.s_ld_legato, us_par_zoppe.s_ll_id_titolo)
			else
				us_par_zoppe.s_qta_da_scaricare=us_par_zoppe.s_ld_legato/1000*us_par_zoppe.s_ld_coef_calo
			end if
			openwithparm(w_orafo_partite_zoppe_gd, us_par_zoppe)

			s_partite_zoppe u_par_zoppe
			u_par_zoppe=message.powerobjectparm
			if isvalid(u_par_zoppe) then
				if u_par_zoppe.s_flag=1 then
					tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_riga_corrente, "riga_documento_peso_netto", u_par_zoppe.s_qta_da_scaricare)
					wf_calcola_fino_calo(ll_riga_corrente)  //20261106 fino e calo subito sul peso scaricato dalle partite zoppe
					tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_set_calc_riga(ll_riga_corrente)
				end if
			end if
		else
			
			return 10 
		end if
	end if
end if
return 1

end function

public subroutine wf_salva_des_personale ();
end subroutine

public subroutine wf_aggiorna_scarico_borsa (integer ai_flag2);
end subroutine

public function string wf_cod_barre (long valore);string ls_ritorno
char ls_valore[11], ls_check[10]
integer i, cifra, tot

ls_check[1]="`"
ls_check[2]="a"
ls_check[3]="b"
ls_check[4]="c"
ls_check[5]="d"
ls_check[6]="e"
ls_check[7]="f"
ls_check[8]="g"
ls_check[9]="h"
ls_check[10]="i"

ls_valore=string(valore)
if Len(ls_valore)<11 then
	ls_valore=Fill('0',11 - Len(ls_valore))+ls_valore
elseif Len(ls_valore)>11 then 
	return ''
end if
tot=0
for i=1 to Len(ls_valore) step 2
	cifra=long(ls_valore[i])
	tot=tot+cifra
next
tot=tot*3
for i=2 to Len(ls_valore) step 2
	cifra=long(ls_valore[i])
	tot=tot+cifra
next
ls_ritorno=string(tot)
ls_ritorno=right(ls_ritorno,1)
tot=long(ls_ritorno)
if tot<>0 then tot=10 - tot

ls_ritorno='P'
cifra=asc('0')
for i=2 to 6 
	ls_ritorno=ls_ritorno+char(long(ls_valore[i])+cifra)
next
ls_ritorno=ls_ritorno+'p'
cifra=asc('@')
for i=7 to 11
	ls_ritorno=ls_ritorno+char(long(ls_valore[i])+cifra)
next
cifra=asc("'")
ls_ritorno=ls_ritorno+ls_check[tot+1]

return ls_ritorno
	

end function

public subroutine wf_setta_riga_copiata (integer i);long ll_id_caus_magazzino,  ll_id_riga_doc_prov, ll_riga_doc
long ll_id_loc2,ll_id_loc1, ll_id_articolo, ll_mag_1, ll_mag_2
string ls_id_loc2, ls_loc_uno
integer li_pos, li_ret
ll_riga_doc=tab_1.tabpage_1.dw_documento_ordine_ff.rowcount()

ll_id_caus_magazzino=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_doc,"documento_id_caus_magazzino")
ll_mag_1=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_doc,"documento_id_magazzino")
ll_mag_2=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_doc,"documento_id_magazzino_2")


ll_id_riga_doc_prov=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "id_riga_doc_provenienza")
if isnull(ll_id_riga_doc_prov) then
	ll_id_riga_doc_prov=tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemNumber(i, "id_riga_documento") 
	li_ret=tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i, "id_riga_doc_provenienza", ll_id_riga_doc_prov)
	if li_ret<>1 then messagebox("Errore!", "No setto riga provenienza")
end if
li_ret=tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i,"riga_documento_id_caus_magazzino",ll_id_caus_magazzino)
if li_ret<>1 then messagebox("Errore!", "No setto causale")
ll_id_articolo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "riga_documento_id_articolo")

ls_id_loc2=f_trova_locazioni(i, ll_id_caus_magazzino, ll_id_articolo, ll_mag_1, ll_mag_2)
li_pos=pos(ls_id_loc2, '-', 1)
ls_loc_uno=left(ls_id_loc2, li_pos - 1)
tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i,"id_locazione_1", long(ls_loc_uno))
ls_loc_uno=right(ls_id_loc2, len(ls_id_loc2) - li_pos)
tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i,"id_locazione_2", long(ls_loc_uno))

		
end subroutine

public subroutine wf_ripristina_evasa (long ll_id_doc, integer li_righe_cancellate);
end subroutine

public subroutine wf_setto_id_riga_sorgente ();//SERVE PER LE VARIANTI DELL'ARTICOLO
//FATTO PER FANTASY NEL 2002 O GIU DI LI
//CHISSA SE FUNGE ANCORA ....

//long i, ll_id_caus_magazzino, a
//string ls_cod_partita
//for i = 1 to tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
//	ll_id_caus_magazzino= tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "id_riga_sorgente")
//	if not isnull(ll_id_caus_magazzino) and ll_id_caus_magazzino>0 then continue
//	ll_id_caus_magazzino=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "riga_documento_id_caus_magazzino")
//	ls_cod_partita=wf_trova_cod_tipo_partita(ll_id_caus_magazzino)
//	if ls_cod_partita='CAR' then
//		update orafo_riga_partita
//		set id_riga_sorgente = id_riga_sorgente + 1;
//		if sqlca.sqlnrows>0 then
//			commit;
//			select id_riga_sorgente
//			into :ll_id_caus_magazzino
//			from orafo_riga_partita;
//			if sqlca.sqlcode<>0 then 
//				messagebox("Errore!", "Progressivo riga_sorgente non trovato!")
//				return
//			end if
//		else
//			rollback;
//		end if
//		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i, "id_riga_sorgente", ll_id_caus_magazzino)
//	end if
//next
//
end subroutine

public function decimal wf_propone_prezzo_metallo (long al_id_articolo, date data_registrazione, decimal quotazione);
decimal ld_quot, ld_cambio, ld_cambio_metallo
long ll_riga, ll_id_valuta, li_righe, ll_id_metallo, LL_id_valuta_metallo, ll_id_val_euro
INTEGER LI_RET
datetime ldt_data_reg
datastore ds_quotazione
ds_quotazione = create datastore
ds_quotazione.dataobject="ds_propone_salva_quotazione"
ds_quotazione.settransobject(sqlca)
li_righe=ds_quotazione.retrieve(al_id_articolo)
if li_righe>0 then
	
	
	
	
	
	select id_val_euro
	into :ll_id_val_euro
	from par_sistema;
	if al_id_val_az = ll_id_val_euro then 
		ld_cambio_metallo = ds_quotazione.getitemdecimal(1, "parita_euro")
	else
		ld_cambio_metallo=ds_quotazione.getitemdecimal(1, "cambio")
	end if
	
	
	
	ll_riga=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
	if isnull(quotazione) then
		
		ld_quot=ds_quotazione.getitemdecimal(1, "quotazione")
		if isnull(ld_quot) then ld_quot=0
		
//		ld_quot=ld_quot/idc_cambio*ld_cambio_metallo
		ld_quot=ld_quot*idc_cambio*ld_cambio_metallo  //alpa vuole la divisione 20220210
		
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_riga, "prezzo_metallo", ld_quot)
	else
		ds_quotazione.setitem(1, "data_quotazione", datetime(data_registrazione, now()))
		
		
//		ld_quot=quotazione/ld_cambio_metallo*iDc_CAMBIO
		ld_quot=quotazione/ld_cambio_metallo/iDc_CAMBIO
		ds_quotazione.setitem(1, "quotazione", ld_quot)
		li_ret=ds_quotazione.update()
			
	   
		 if li_ret<>1 then
			messagebox("Errore!", "Quotazione non aggiornata!")
		 else
			ldt_data_reg=datetime(data_registrazione, now())
			ll_id_metallo=ds_quotazione.getitemnumber(1,"id_metallo")
		 	INSERT INTO "orafo_storico_metallo"  
         ( "id_metallo","quotazione","data_quotazione","id_azienda", id_valuta )  
            VALUES ( :ll_id_metallo,:ld_quot, :ldt_data_reg,1 ,:ll_id_valuta )
				USING sqlca;
				if sqlca.sqlnrows >= 1 then 
					commit;
				else
					rollback;
					messagebox("qwery",sqlca.sqlerrtext)
				end if
		 end if
		
			
	END IF
	
end if

destroy ds_quotazione
return ld_quot
end function

public function boolean wf_controllo_saldi ();long ll_id_sog_com, ll_id_caus_mag, ll_num_righe, i
date ld_data_reg
time lt_ora_reg
datetime ldt_data_chius
string ls_data_chius
boolean lb_chius_successiva=false
char lc_car_fis, lc_scar_fis, lc_qta_cl_fo, lc_qta_cl_cli

ll_id_sog_com=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1,"id_sog_commerciale")
ld_data_reg=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemDate(1,"data_registrazione")
lt_ora_reg=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemTime(1,"ora_registrazione")
ll_num_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
SetNull(ls_data_chius)
ldt_data_chius=datetime(ld_data_reg,lt_ora_reg)
select Min(s_data_chius)
into :ls_data_chius
from orafo_saldi_chiusi
where(orafo_saldi_chiusi.id_sog_commerciale=:ll_id_sog_com)
and(orafo_saldi_chiusi.data_chiusura>=:ldt_data_chius);
if Not(IsNull(ls_data_chius)) then
	for i=1 to ll_num_righe
		ll_id_caus_mag=tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemNumber(i,"riga_documento_id_caus_magazzino")
		select mp_car_fiscali, mp_scar_fiscali, mp_qta_cl_fornitori, mp_qta_cl_clienti
		into :lc_car_fis, :lc_scar_fis, :lc_qta_cl_fo, :lc_qta_cl_cli
		from caus_magazzino
		where caus_magazzino.id_caus_magazzino=:ll_id_caus_mag;
		if (IsNull(lc_car_fis))and(IsNull(lc_scar_fis))and(IsNull(lc_qta_cl_fo))and(IsNull(lc_qta_cl_cli)) then
		else
			messagebox('Attenzione!','Questo documento fa parte di una scheda soggetto già chiusa in data '+string(ls_data_chius)+'...'+char(13)+&
			+'Impossibile modificare il documento!')
			lb_chius_successiva=true
			exit
		end if
	next
else
	return lb_chius_successiva
end if
return lb_chius_successiva
end function

public function integer wf_setta_mask_riga ();
string 		ls_mask, ls_simbolo, ls_mask_importi, ls_simbolo_val_conto, ls_mask_importi_conto
long 			ll_row, ll_id_valuta
decimal 		ldc_cambio
integer		ll_arrotondamento, li_decimali, li_dec_per_importi
integer 		li_count
boolean 		lb_simbolo

lb_simbolo= cbx_simbolo.Checked
ls_mask= "#,0"
ls_mask_importi= "#,0"
ll_row= idw_riga.GetRow()
if ll_row > 0 then
	ls_mask= "#,0"
	ll_id_valuta= idw_riga.GetItemNumber(ll_row, "riga_documento_id_valuta")
	if not(IsNull(ll_id_valuta) OR ll_id_valuta=0) then
		ldc_cambio= idw_riga.uf_GetItemDecimal(ll_row, "riga_documento_cambio")
		SELECT "valuta"."simbolo",   
				"valuta"."cifra_arrotondamento" ,  "valuta"."dec_significativi" 
			INTO :ls_simbolo,   
				:ll_arrotondamento , :li_dec_per_importi 
			FROM "dba"."valuta"  
			WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
	
		li_decimali = - ll_arrotondamento
		if li_decimali > 0 then
			ls_mask = ls_mask + "."
			FOR li_count = 1 to li_decimali
				ls_mask = ls_mask + "0"
			NEXT
		end if
		
		li_decimali = - li_dec_per_importi
		if li_decimali > 0 then
			ls_mask_importi = ls_mask_importi + "."
			FOR li_count = 1 to li_decimali
				ls_mask_importi = ls_mask_importi + "0"
			NEXT
		end if
		
		
		
		if ls_simbolo <> "" AND lb_simbolo= TRUE then 
			select simbolo
			into :ls_simbolo_val_conto
			from valuta
			where id_valuta=:al_id_val_az;
			If isnull(ls_simbolo_val_conto) then ls_simbolo_val_conto=''
			ls_mask = ls_simbolo + " " + ls_mask
			ls_mask_importi_conto= ls_simbolo_val_conto+" "  +ls_mask_importi
			ls_mask_importi= ls_simbolo + " " +ls_mask_importi
		end if
	end if
	idw_riga.Modify("prezzo_complessivo.format = '" + ls_mask + "'")
	idw_riga.Modify("prezzo_manifattura.format = '" + ls_mask + "'")
	

	idw_riga_tot.Modify("importo_manifattura_val.format = '" + ls_mask_importi + "'")
	idw_riga_tot.Modify("imp_metallo_val.format = '" + ls_mask_importi + "'")	
	idw_riga_tot.Modify("c_imp_man_val.format = '" + ls_mask_importi + "'")
	
	
	
	
	
	
	
	
	
	idw_riga_tot.Modify("importo_manifattura_val.format = '" + ls_mask_importi + "'")
	idw_riga_tot.Modify("imp_metallo_val.format = '" + ls_mask_importi + "'")
	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.Modify("sconto_riga.format = '" + ls_mask_importi + "'")
	
	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.Modify("tot_riga_val_riga.format = '" + ls_mask_importi + "'")
	
	
	tab_1.tabpage_4.dw_documento_tot_ext_ff.modify("tot_metallo.format='"+ls_mask_importi+"'")
	
	tab_1.tabpage_4.dw_documento_tot_ext_ff.modify("tot_manifattura_netto.format='"+ls_mask_importi+"'")
	tab_1.tabpage_4.dw_documento_tot_ext_ff.modify("tot_sconti.format='"+ls_mask_importi+"'")
end if 

return 0

end function

public function integer wf_cancella_riga1 (long al_row);
string ls_cod_partita
long ll_id_caus_magazzino, ll_riga_corrente, ll_id_titolo, ll_id_documento, ll_id_partita
decimal{2} ld_val_scarico, ld_coef_calo, ld_fino_calo
	ll_riga_corrente=al_row
u_dw_main lu_dw
lu_dw = u_freddie.iudw_current
	
	if ll_riga_corrente>0 then
		ll_id_caus_magazzino=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_riga_corrente, "riga_documento_id_caus_magazzino")
		ls_cod_partita=wf_trova_cod_tipo_partita(ll_id_caus_magazzino)
		if mid(ls_cod_partita, 1,1) ='S' then 
			if not isvalid(us_dati_partita.s_dw_scar_partita) then wf_carica_datastore()
			long  ll_id_riga_partita
			
			
			
			
				
				ll_id_riga_partita=	tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber&
											(ll_riga_corrente, "id_riga_partita")
				if ll_id_riga_partita>0 then
					//20261028 se non riesce non ha toccato niente: la riga non si cancella (cb_cancella rilegge le partite)
					if wf_cancella_partite(ll_id_riga_partita, us_dati_partita.s_dw_aper_partita, us_dati_partita.s_dw_scar_partita) = 0 then return 0
				else
					messagebox("Attenzione!", "Non trovata riga di collegamento partite") 
				end if
			
		elseif mid(ls_cod_partita, 1,1) ='A' then
			
			ll_id_titolo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber&
								(ll_riga_corrente, "id_titolo")
			ll_id_documento = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_documento")
			select id_partita
			into :ll_id_partita
			from orafo_scar_partita
			where id_partita in (select id_partita from orafo_aper_partita
			where id_documento=:ll_id_documento and id_titolo=:ll_id_titolo);
			if ll_id_partita>0 and not isnull(ll_id_partita) then
				messagebox("Attenzione!", "Esistono scarichi collegati a questa riga.~r~n"+&
							"Impossibile cancellare la riga!")
				return 0
			end if
			if ll_id_titolo < 1 then 
				messagebox("Errore!", "Titolo non trovato")
			end if
			ld_fino_calo=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemdecimal&
								(ll_riga_corrente, "fino_calo")
			if  not(ld_fino_calo>0 or not isnull(ld_fino_calo)) then
				ld_val_scarico=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
									(ll_riga_corrente, "riga_documento_peso_netto")
	
				ld_coef_calo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
									(ll_riga_corrente, "coef_calo")
				if isnull(ld_coef_calo) or ld_coef_calo<=0 then
					select titolo
					into	:ld_coef_calo
					from orafo_titolo
					where id_titolo= :ll_id_titolo;
					if sqlca.sqlcode<>0 then 
						messagebox("Errore!", "Titolo non trovato")
					end if
				end if
				if ld_coef_calo>0 then
					ld_val_scarico= f_round(ld_val_scarico*ld_coef_calo/1000, -2, 'M')
					ld_fino_calo=ld_val_scarico
				end if
			end if
			if not isvalid(us_dati_partita.s_dw_aper_partita) then wf_carica_datastore()
			wf_cancella_aper_partita(ll_id_documento, ll_id_titolo, ld_fino_calo, ll_riga_corrente) 
		end if
	end if
	return 1
end function

public function integer wf_integra_autofind (integer al_row);long ll_id_articolo, ll_id_UC, ll_id_titolo, ll_id_sog
decimal{4} ld_calo, ld_calo_buono,ld_fino_calo, ld_legato
integer li_ret
string ls_simbolo, ls_tipo, ls_cod_articolo

ll_id_articolo=idw_riga.getitemnumber(al_row,"riga_documento_id_articolo")

ll_id_sog=idw_gen.getitemnumber(idw_gen.getrow(), "id_sog_commerciale")
LI_RET=wf_acq_cliente(ll_id_articolo, ll_id_sog)
IF LI_RET>0 THEN
	ls_cod_articolo=idw_riga.getitemstring(al_row, "c_articolo_cod")
	idw_riga.setitem(al_row, "c_articolo_cod",+ls_cod_articolo+" ")
END IF


 select id_titolo
into :ll_id_titolo
from articolo
where id_articolo=:ll_id_articolo;
if ll_id_titolo>0 and not isnull(ll_id_titolo) then
	li_ret=idw_riga.setitem(al_row,"id_titolo", ll_id_titolo)
	if li_ret<>1 then messagebox("Errore", "Non settato id_titolo")
end if

ll_id_UC=idw_riga.getitemnumber(al_row, "riga_documento_id_unita_confezione")

select simbolo, tipo 
into :ls_simbolo, :ls_tipo
from unita_confezione u, unita_misura m
where u.id_unita_confezione=:ll_id_UC
and u.id_unita_misura=m.id_unita_misura;
if ls_simbolo>"" and not isnull(ls_simbolo) then
	idw_riga.setitem(al_row, "simbolo_mov", ls_simbolo)
	idw_riga.setitem(al_row, "tipo_um", ls_tipo)
end if

w_recupera_non_prezioso(al_row, -1)

ld_calo_buono=wf_gestione_coef_calo(al_row, ll_id_articolo)
//
ld_legato=idw_riga.getitemdecimal(aL_ROW, "riga_documento_peso_netto")
if  ld_legato> 0 and not isnull(ld_legato) then
	wf_setta_fino_calo(aL_ROW)
	
	wf_gestione_partite(al_row, ld_legato, ld_legato, ld_calo_buono)
	
end if



return 0
end function

public function integer uf_importa_righe_orafo (s_par_der_doc astr_par);//
//
//
//
//long		ll_size, ll_count, ll_row, ll_id_prof_documento, ll_id_riga_documento, ll_id_val_arr,ll_id_titolo
//boolean	lb_ricc, lb_Ok, lb_descr, lb_tengo
//
//long		ll_idriga, ll_idart, ll_iddes, ll_idunc,ll_idcaus, ll_id_sog_commerciale, ll_id_causale
//long		ll_idl1, ll_idl2, ll_idval, ll_idlis, ll_idcla, ll_idiva, ll_id_agente, ll_id_r_lotto
//long		ll_idage, ll_idctr, ll_idcpt, ll_idazi, ll_Id_tab_Iva, ll_Id_Sog_Comm
//string	ls_descr, ls_scon, ls_Contabilizzabile, ls_cod_lotto
//decimal	ld_fcub, ld_fcgl, ld_camb, ld_prez, ld_scri, ld_psnt, ld_pslo, ld_cambio
//decimal	ld_diml, ld_dimh, ld_dimp, ld_numc, ld_prv1, ld_prv2, ld_prv3, ld_vatt, ld_peso, ld_cambio_doc
//date		ldt_cns, ldt_dic, ldt_dfc, ld_data_lotto
//string	ls_Prec_Esenzione, ls_Att_Esenzione
//long		ll_rows[], ll_id_loc_1, ll_id_loc_2
//long 		ll_sizeini
//integer li_ret
//
//decimal ld_coef_calo, ld_calo, ld_fino, ld_prezzo_metallo, ld_prezzo_manif, ld_prezzo_comp, ld_val_peso_non_p
//decimal ld_provv_imp_agente, ld_provv_imp_subage, ld_provv_imp_carea, ld_imp_manif, ld_peso_non_prezioso
//DECIMAL ld_imp_manif_VAL, ld_prezzo_netto
//string ls_sigla_prezzo, ls_tipo_um, ls_simbolo_mov, ls_des_cod, ls_des_descrizione, ls_des_estesa
//				
//lb_ricc = false
//lb_descr = false
//
//ll_sizeini = tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
//
//
//ll_size = upperbound(astr_par.s_dbn)
//
//
//ll_id_loc_1=idw_gen.getitemnumber(1, "documento_id_locazione_1")
//ll_id_loc_2=idw_gen.getitemnumber(1, "documento_id_locazione_2")
//ld_cambio_doc=idw_gen.getitemdecimal(1, "documento_cambio")
//
//for ll_count = 1 to ll_size
//	
//
//	ll_idriga = long(astr_par.s_dbn[ll_count])
//	ll_idcaus = long(astr_par.s_dbt[ll_count])
//	if ll_idcaus <= 0 or isNull(ll_idcaus) then 
//		ll_idcaus = long(idw_gen.uf_get_colval("documento_id_caus_magazzino"))
//	end if
//	if ll_idcaus <= 0 then SetNull(ll_idcaus)
//
//	SELECT "riga_documento"."id_articolo",				"riga_documento"."descrizione",
//			 "riga_documento"."id_des_articolo",	 			"riga_documento"."id_unita_confezione",
//			 "riga_documento"."fat_con_unita_base",		"riga_documento"."fat_con_globale",
//			 "riga_documento"."id_locazione_1",       		"riga_documento"."id_locazione_2",
//			 "riga_documento"."id_valuta",					"riga_documento"."cambio",
//			 "riga_documento"."id_listino",					"riga_documento"."id_con_lis_articolo",
//			 "riga_documento"."prezzo",						"riga_documento"."prezzo_netto",
//			 "riga_documento"."sconto",
//			 "riga_documento"."sconto_riga",			 		"riga_documento"."data_prevista_consegna",
//			 "riga_documento"."peso_netto",					"riga_documento"."peso_lordo",
//			 "riga_documento"."dim_l",						"riga_documento"."dim_h",
//			 "riga_documento"."dim_p",						"riga_documento"."num_colli",
//			 "riga_documento"."id_tab_iva",					"riga_documento"."id_gruppo_agenti",
//			 "riga_documento"."provv_agente",				"riga_documento"."provv_subage",
//			 "riga_documento"."provv_carea",				"riga_documento"."val_attribuito",
//			 "riga_documento"."id_caus_trasporto",			"riga_documento"."data_inizio_competenza",
//			 "riga_documento"."data_fine_competenza",	"riga_documento"."id_conto",					
//			 "riga_documento"."id_azienda",			 		"riga_documento"."id_riga_lotto",
//			 "riga_documento"."coef_calo",			 		"riga_documento"."calo",
//			 "riga_documento"."fino",			 				"riga_documento"."prezzo_metallo",
//			 "riga_documento"."prezzo_manifattura",			"riga_documento"."sigla_prezzo",
// 			 "riga_documento"."prezzo_complessivo",		"riga_documento"."provv_imp_agente",
//			 "riga_documento"."provv_imp_subage",		"riga_documento"."provv_imp_carea",
//			
//			"riga_documento"."peso_non_prezioso",
//			 "riga_documento"."valoriz_peso_non_prezioso"
//			 
//	INTO	:ll_idart, :ls_descr, :ll_iddes, :ll_idunc, :ld_fcub, :ld_fcgl,
//			:ll_idl1,  :ll_idl2,  :ll_idval, :ld_camb,  :ll_idlis, :ll_idcla,
//			:ld_prez,  :ld_prezzo_netto, :ls_scon,  :ld_scri,  :ldt_cns, :ld_psnt,  :ld_pslo,
//			:ld_diml,  :ld_dimh,  :ld_dimp,  :ld_numc, :ll_idiva, :ll_idage,
//			:ld_prv1,  :ld_prv2,  :ld_prv3,  :ld_vatt,  :ll_idctr,
//			:ldt_dic,  :ldt_dfc,  :ll_idcpt, :ll_idazi, :ll_id_r_lotto,
//			:ld_coef_calo, :ld_calo, :ld_fino, :ld_prezzo_metallo,
//			:ld_prezzo_manif, :ls_sigla_prezzo, :ld_prezzo_comp,
//			:ld_provv_imp_agente, :ld_provv_imp_subage, :ld_provv_imp_carea,
//			
//			:ld_peso_non_prezioso, :ld_val_peso_non_p
//			 
//	FROM "dba"."riga_documento"  
//	WHERE "riga_documento"."id_riga_documento" = :ll_idriga   ;
//	
//		
//	if SQLCA.SQLCode = 0 then
//		
//		ll_id_riga_documento = ll_idriga	
//		
//		Long		ll_id_articolo, riga_in
//		String	ls_des_articolo
//		
//		riga_in=idw_riga.rowcount()
//		if riga_in>0 then
//			ll_id_articolo = idw_riga.GetItemNumber(1, "riga_documento_id_articolo")
//			ls_des_articolo = idw_riga.getItemString(1, "riga_documento_descrizione")
//		end if
//		
//			
//			
//		If not (IsNull(ll_id_articolo)) and not (IsNull(ls_des_articolo)) Then
//			idw_riga.event ue_insert(0,0)
//		Else
//			ll_sizeini = 0
//		End If
//		
//		ll_row = idw_riga.getrow()
//		if ll_row > 0 then
//			
//			
//			
//			
//			
//			
//			
//			lb_descr = true
//			
//			if (not isNull(astr_par.s_op[ll_count])) and (dec(astr_par.s_op[ll_count])<>0) then
//				lb_descr = false
//			end if
//			
//			if (not isNull(astr_par.s_dbv[ll_count])) and (dec(astr_par.s_dbv[ll_count])<>0) then
//				lb_descr = false
//			end if
//			
//			if (not isNull(ld_prez)) and (ld_prez<>0) then
//				lb_descr = false
//			end if
//			
//			if (not isNull(ld_scri)) and (ld_scri<>0) then
//				lb_descr = false
//			end if
//			
//			
//			
//			idw_riga.SetItem(ll_row,"riga_documento_id_articolo",ll_idart)
//			idw_riga.SetItem(ll_row,"riga_documento_descrizione",ls_descr)
//			idw_riga.SetItem(ll_row,"riga_documento_id_des_articolo",ll_iddes)
//			
//			if ll_iddes>0 then
//				select codice, descrizione,des_estesa
//				into :ls_des_cod, :ls_des_descrizione, :ls_des_estesa
//				from des_articolo
//				where id_des_articolo=:ll_iddes;
//				if sqlca.sqlcode=0 then
//					idw_riga.SetItem(ll_row,"des_articolo_codice",ls_des_cod)
//					idw_riga.SetItem(ll_row,"des_articolo_descrizione",ls_des_descrizione)
//					idw_riga.SetItem(ll_row,"des_articolo_des_estesa", ls_des_estesa)
//				end if
//			end if
//			
//			idw_riga.SetItem(ll_row,"riga_documento_id_unita_confezione",ll_idunc)
//			
//			idw_riga.SetItem(ll_row,"quantita",dec(astr_par.s_op[ll_count]))
//			idw_riga.SetItem(ll_row,"qta_sconto_merce",dec(astr_par.s_dbv[ll_count]))
//			idw_riga.SetItem(ll_row,"qta_evasa",0)
//	
//			idw_riga.SetItem(ll_row,"riga_documento_fat_con_unita_base",ld_fcub)
//			idw_riga.SetItem(ll_row,"fat_con_globale",ld_fcgl)
//			idw_riga.SetItem(ll_row,"riga_documento_id_caus_magazzino",ll_idcaus)
//			
//			idw_riga.SetItem(ll_row,"id_locazione_1",ll_id_loc_1)
//			idw_riga.SetItem(ll_row,"id_locazione_2",ll_id_loc_2)
//			
//			idw_riga.SetItem(ll_row,"riga_documento_id_valuta",ll_idval)
//			
//			if ld_cAMB<>ld_cambio_doc then
//				if ll_count=1 then
//					li_ret=messagebox("Attenzione!", "Il cambio impostato in fattura è diverso "&
//					+"da quello della bolla che si sta derivando.~r~n Scegliere 'Sì' per"&
//					+" usare il cambio della Fattura, 'No' per quello della bolla",stopsign!, yesno!)
//					if li_ret=2 then
//						ld_cambio_doc=ld_camb
//						idw_gen.setitem(1, "documento_cambio", ld_cambio_doc)
//					end if
//				else
//					
//				end if
//			end if
//			
//			idw_riga.SetItem(ll_row,"riga_documento_cambio",ld_cambio_doc)
//			
//			idw_riga.SetItem(ll_row,"riga_documento_id_listino",ll_idlis)
//			idw_riga.SetItem(ll_row,"riga_documento_id_con_lis_articolo",ll_idcla)
//			idw_riga.SetItem(ll_row,"prezzo",ld_prez)
//			
//			idw_riga.SetItem(ll_row,"riga_documento_prezzo_netto",ld_prezzo_netto)
//			
//			idw_riga.SetItem(ll_row,"sconto",ls_scon)
//			idw_riga.SetItem(ll_row,"riga_documento_sconto_riga",ld_scri)
//			idw_riga.SetItem(ll_row,"riga_documento_data_prevista_consegna",ldt_cns)
//			idw_riga.SetItem(ll_row,"riga_documento_peso_netto",ld_psnt)
//			idw_riga.SetItem(ll_row,"riga_documento_peso_lordo",ld_pslo)
//			idw_riga.SetItem(ll_row,"riga_documento_dim_l",ld_diml)
//			idw_riga.SetItem(ll_row,"riga_documento_dim_h",ld_dimh)
//			idw_riga.SetItem(ll_row,"riga_documento_dim_p",ld_dimp)
//			idw_riga.SetItem(ll_row,"riga_documento_num_colli",ld_numc)
//			
//			
//			select id_titolo 
//			into :ll_id_titolo
//			from articolo
//			where id_articolo=:ll_idart;
//			idw_riga.SetItem(ll_row,"id_titolo",ll_id_titolo)
//			
//			idw_riga.SetItem(ll_row,"coef_calo",ld_coef_calo)
//			idw_riga.SetItem(ll_row,"calo",ld_calo)
//			idw_riga.SetItem(ll_row,"fino",ld_fino)
//			idw_riga.SetItem(ll_row,"prezzo_metallo",ld_prezzo_metallo)
//			idw_riga.SetItem(ll_row,"prezzo_manifattura",ld_prezzo_manif)
//			idw_riga.SetItem(ll_row,"sigla_prezzo",ls_sigla_prezzo)
//			idw_riga.SetItem(ll_row,"prezzo_complessivo",ld_prezzo_comp)
//			idw_riga.SetItem(ll_row,"provv_imp_agente",ld_provv_imp_agente)
//			idw_riga.SetItem(ll_row,"provv_imp_subage",ld_provv_imp_subage)
//			idw_riga.SetItem(ll_row,"provv_imp_carea",ld_provv_imp_carea)
//			
//			
//			idw_riga.SetItem(ll_row,"peso_non_prezioso",ld_peso_non_prezioso)
//			idw_riga.SetItem(ll_row,"valoriz_peso_non_prezioso",ld_val_peso_non_p)
//			ld_peso=f_round(Dec(astr_par.orafo_peso_ev[ll_count]), -2, 'M')
//			idw_riga.SetItem(ll_row,"riga_documento_peso_netto",ld_peso)
//			select simbolo, tipo
//			into :ls_simbolo_mov, :ls_tipo_um
//			from unita_confezione u, unita_misura m
//			where u.id_unita_confezione=:ll_idunc
//			and u.id_unita_misura=m.id_unita_misura;
//			if ls_simbolo_mov>"" and not isnull(ls_simbolo_mov) then
//				idw_riga.SetItem(ll_row,"tipo_um",ls_tipo_um)
//				idw_riga.SetItem(ll_row,"simbolo_mov",ls_simbolo_mov)			
//			end if
//			
//			
//			
//			if tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_riga_documento_ordine_lotti_gd" then
//				if Not(IsNull(ll_id_r_lotto)) then
//					select lotto.cod_esterno, lotto.data_scadenza
//					into :ls_cod_lotto, :ld_data_lotto
//					from riga_doc_lotto, lotto
//					where(riga_doc_lotto.id_riga_lotto=:ll_id_r_lotto)
//					and(riga_doc_lotto.id_lotto=lotto.id_lotto);
//					idw_riga.SetItem(ll_row,"cod_lotto",ls_cod_lotto)
//					idw_riga.SetItem(ll_row,"data_scadenza",ld_data_lotto)
//				end if
//			end if
//			
//
//			
//			
//			
//			
//			idw_riga.SetItem(ll_row,"riga_documento_id_tab_iva",ll_idiva)
//			if not lb_descr then
//				
//				If is_contr_esen_der ="S" then
//					
//					If not IsNull(ll_idiva) then
//						
//						ls_Prec_Esenzione=idw_gen.GetItemString(idw_gen.GetRow(),"creato_in_esenzione")
//						If IsNull(ls_Prec_Esenzione) then ls_Prec_Esenzione=""
//						
//						SELECT "documento"."creato_in_esenzione"  
//							INTO :ls_Att_Esenzione  
//							FROM 	"dba"."documento",   
//									"dba"."riga_documento" 
//							WHERE ( "riga_documento"."id_documento" = "documento"."id_documento" ) and  
//									( ( "riga_documento"."id_riga_documento" = :ll_idriga ) )   ;
//						If IsNull(ls_Att_Esenzione) then ls_Att_Esenzione = ""
//						
//						If ls_Prec_Esenzione = "S" then
//							If ls_Att_Esenzione = "S" then
//								
//								SELECT "articolo"."id_tab_iva"  
//									INTO :ll_Id_tab_Iva 
//									FROM "dba"."articolo"  
//									WHERE "articolo"."id_articolo" = :ll_idart ;
//								idw_riga.SetItem(ll_row,"riga_documento_id_tab_iva",ll_Id_tab_Iva)
//							else
//								
//								idw_riga.SetItem(ll_row,"riga_documento_id_tab_iva",ll_idiva)
//							end if
//						else
//							If ls_Att_Esenzione = "S" then
//								
//								SELECT "sog_commerciale"."id_tab_iva"  
//									INTO :ll_Id_tab_Iva
//									FROM 	"dba"."documento",   
//											"dba"."riga_documento",   
//											"dba"."sog_commerciale"  
//									WHERE ( "riga_documento"."id_documento" = "documento"."id_documento" ) and  
//											( "sog_commerciale"."id_sog_commerciale" = "documento"."id_sog_commerciale" ) and  
//											( ( "riga_documento"."id_riga_documento" = :ll_idriga ) ) ;
//									messagebox("SQL STATE",sqlca.sqlerrtext)
//								idw_riga.SetItem(ll_row,"riga_documento_id_tab_iva",ll_Id_tab_Iva)
//							else
//								
//								idw_riga.SetItem(ll_row,"riga_documento_id_tab_iva",ll_idiva)
//							end if
//						end if
//					end if
//				end if
//			end if
//			
//	
//			idw_riga.SetItem(ll_row,"id_gruppo_agenti",ll_idage)
//			idw_riga.SetItem(ll_row,"provv_agente",ld_prv1)
//			idw_riga.SetItem(ll_row,"provv_subage",ld_prv2)
//			idw_riga.SetItem(ll_row,"provv_carea",ld_prv3)
//			idw_riga.SetItem(ll_row,"riga_documento_val_attribuito",ld_vatt)
//			idw_riga.SetItem(ll_row,"riga_documento_id_caus_trasporto",ll_idctr)
//			idw_riga.SetItem(ll_row,"riga_documento_forza_chius_evasione","N")
//			idw_riga.SetItem(ll_row,"riga_documento_sospesa","N")
//			idw_riga.SetItem(ll_row,"riga_documento_da_stampare","S")
//			idw_riga.SetItem(ll_row,"riga_documento_data_inizio_competenza",ldt_dic)
//			idw_riga.SetItem(ll_row,"riga_documento_data_fine_competenza",ldt_dfc)
//			
//			idw_riga.SetItem(ll_row,"id_riga_doc_provenienza",ll_idriga)
//			
//			
//			
//			
//			
//			
//			idw_riga.SetItem(ll_row,"riga_documento_id_azienda",ll_idazi)
//			idw_riga.SetItem(ll_row,"riga_documento_id_conto",ll_idcpt)
//			lb_tengo = true
//			if not lb_descr then
//				
//				If IsNull(ll_idcpt) OR ll_idcpt=0 then 
//					ll_id_sog_commerciale = idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
//					ll_id_agente = idw_gen.GetItemNumber(il_row, "id_gruppo_agenti")
//					ll_id_causale=idw_riga.getItemnumber(ll_row,"riga_documento_id_caus_magazzino")
//					ll_idcpt = wf_calcola_cpt(ll_id_sog_commerciale, ll_id_agente, ll_idart, ll_id_causale)
//					if isnull(ll_idcpt) or ll_idcpt=0 then
//						SELECT "par_sistema"."id_conto_predefinito"  
//						INTO :ll_idcpt  
//						FROM "dba"."par_sistema"  
//						WHERE "par_sistema"."id_azienda" = :ll_idazi ;
//					end if
//				end if
//				
//				If IsNull(ll_idcpt) OR ll_idcpt=0 then 
//					
//					ll_id_prof_documento= idw_gen.GetItemNumber(il_row, "id_prof_documento")
//					SELECT	"prof_documento"."contabilizzabile"  
//						INTO	:ls_Contabilizzabile 
//						FROM	"dba"."prof_documento"  
//						WHERE	"prof_documento"."id_prof_documento" = :ll_id_prof_documento ;	
//						
//					If SQLCA.SQLCode <>0 then
//						MessageBox("SQL ERROR","Errore in w_documento_ordine_cx / uf_importa_righe ")
//						lb_tengo = false
//					end if
//					If ls_Contabilizzabile="S" then lb_tengo = false
//				end if
//			end if
//			
//			
//			 
//			
//			
//			
//			if lb_tengo then
//				
//				idw_riga.SetItem(ll_row,"riga_documento_id_conto",ll_idcpt)
//				idw_riga.SetItem(ll_row,"riga_documento_id_azienda",ll_idazi)
//				tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_comp_riga()
//				
//				
//				
//				
//				
//				
//				
//				
//				wf_calcola_prezzo(ll_row)
//				
//				ll_rows[ll_row] = ll_count
//			else
//				
//				If IsNull(ll_idcpt) OR ll_idcpt=0 then 
//					Messagebox("ATTENZIONE", "La riga Nr. ("+string(ll_count)+") Non Può essere Derivata ~r~n Non Esiste Nessuna Contropartita Per Questa Riga")
//				end if
//				idw_riga.DeleteRow(ll_row)
//			end if
//			
//			
//			
//			
//		end if
//	end if
//next
//
//tab_1.tabpage_2.dw_riga_documento_ordine_gd.TriggerEvent("ue_update")
//tab_1.tabpage_1.dw_documento_ordine_ff.TriggerEvent("ue_update")
//
//
//ll_size = tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
//for ll_count = ll_sizeini + 1 To ll_size
//	if astr_par.s_mio[ll_rows[ll_count]] = "S" then
//		ll_id_riga_documento = long( astr_par.s_dbn[ll_rows[ll_count]] )
//		post wf_update_riga ( ll_id_riga_documento, "S" )
//	end if
//next
//
return 0
//
//
end function

public function decimal wf_gestione_coef_calo (long al_row, decimal al_id_art);LONG ll_id_UC, ll_id_sog, ll_id_listino, ll_id_articolo,ll_id_caus_mag,ll_id_tit, ll_id_metallo,ll_id_prof
DECIMAL{2} ld_calo, LD_CALO_BUONO, ld_calo_art, ld_calo_lis_base
string ls_tipo, ls_cod_azienda, ls_prof_doc, ls_metallo

ll_id_tit=idw_riga.getitemnumber(al_row, "id_titolo")
ll_id_sog=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_sog_commerciale")
//Se è silverdr e titolo 925 e cliente 13 (K) allora sempre calo 1000 11-02-2019
select codice into :ls_cod_azienda from dba.azienda;
if ls_cod_azienda="SILVERDR" then
	if ll_id_tit=4 and ll_id_sog=43 then
		if ls_cod_azienda="SILVERDR" then
			idw_riga.setitem(al_row,"coef_calo", 1000)
			RETURN 1000
		end if
	end if
	//se è ORDCLI, PRONTO o VRBOL il calo è sempre 1000 (in AG) richiesta Elisa 28-02-2020
	ls_prof_doc=idw_gen.getitemstring(1, "c_prof_doc_cod")
	if ll_id_tit=4 and (ls_prof_doc= "ORDCLI" or ls_prof_doc= "PRONTO" or ls_prof_doc= "VRBOL") then
		idw_riga.setitem(al_row,"coef_calo", 1000)
		RETURN 1000
	end if
	//20221027 Anna vuole che nel SALD il coef calo sia sempre uguale al titolo 
	if ls_prof_doc="XSALD" or ls_prof_doc="SALD" or ls_prof_doc="VSALD" or ls_prof_doc="VSMER" or ls_prof_doc="SALDA_US" or ls_prof_doc="RIPARA" &
	 or ls_prof_doc="RCLF" or ls_prof_doc="RSPAZEST" or ls_prof_doc="BURATTO"  then //20220825 (ANNA) in XSALD il coef calo DEVE essere sempre = al titolo
		select titolo into :LD_CALO_BUONO from orafo_titolo where id_titolo=:ll_id_tit; //20231205 asggiunto altri profili
		idw_riga.setitem(al_row,"coef_calo", LD_CALO_BUONO)
		if LD_CALO_BUONO>0 then return LD_CALO_BUONO
	end if
end if
//FINE se è ORDCLI, PRONTO o VRBOL

ll_id_UC=idw_riga.getitemnumber(AL_row, "riga_documento_id_unita_confezione")
//	ll_id_sog=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_sog_commerciale")  //spostato sopra riga 8
ll_id_caus_mag=idw_riga.getitemnumber(al_row, "riga_documento_id_caus_magazzino")
if ll_id_caus_mag>0 then
	select tipo_valorizzazione
	into :ls_tipo
	from caus_magazzino
	where id_caus_magazzino=:ll_id_caus_mag;
else
	ls_tipo='V'
end if
	
////se è espresso nella tabella calo_art_cliente
//ha la precedenza!
select id_metallo
into :ll_id_metallo
from dba.orafo_titolo
where id_titolo=:ll_id_tit
;

if ls_tipo='V' then
	select first(calo_uscita)
	into :ld_calo_art
	from dba.calo_art_cliente
	where id_sog_commerciale=:ll_id_sog
	and (id_articolo=:al_id_art or id_articolo= 16639)  //articolo per prenderli tutti
	and id_metallo=:ll_id_metallo
	;
else
	select first(calo_entrata)
	into :ld_calo_art
	from dba.calo_art_cliente
	where id_sog_commerciale=:ll_id_sog
	and (id_articolo=:al_id_art or id_articolo= 16639)  //articolo per prenderli tutti
	and id_metallo=:ll_id_metallo
	;
end if
if ld_calo_art>0 then
	idw_riga.setitem(al_row,"coef_calo", ld_calo_art)
	RETURN ld_calo_art
end if



//se è nella tabella prezzo_documento lo prendo prima
//	ll_id_tit=idw_riga.getitemnumber(al_row, "id_titolo")  //spostato sopra riga 7
select coef_calo 
into 	:ld_calo_art
from prezzo_documento
where id_documento=:il_id_documento
and id_titolo=:ll_id_tit;
if ld_calo_art>0 and not isnull(ld_calo_art)then
	idw_riga.setitem(al_row,"coef_calo", ld_calo_art)
	RETURN ld_calo_art
end if




select p.coef_calo
into :ld_calo_art
from prezzo p, variazione v, listino l
where v.id_variazione=p.id_variazione
and p.id_unita_confezione=:ll_id_UC
and v.id_listino=l.id_listino
and l.lis_base='S'
and l.tipo=:ls_tipo
and data_inizio<=date(today())
and (data_fine>=date(today()) or data_fine is null)
;

if isnull(ld_calo_art) or ld_calo_art<=0 then
	select coef_calo
	into :ld_calo_art
	from articolo
	where id_articolo=:al_id_art;
end if	

		
select id_listino
into :ll_id_listino
from sog_commerciale
where id_sog_commerciale=:ll_id_sog;
if ll_id_listino>0 and not isnull(ll_id_listino) then
	select p.coef_calo
	into :ld_calo
	from prezzo p, variazione v
	where v.id_variazione=p.id_variazione
	and p.id_unita_confezione=:ll_id_UC
	and v.id_listino=:ll_id_listino
	and data_inizio<=date(today())
	and (data_fine>=date(today()) or data_fine is null);
	if ld_calo>0 and not isnull(ld_calo) then
		
		
		if ld_calo>0 and not isnull(ld_calo) then
			idw_riga.setitem(al_row,"coef_calo", ld_calo)
			ld_calo_buono=ld_calo
		else
			idw_riga.setitem(al_row,"coef_calo", ld_calo_art)
			ld_calo_buono=dec(ld_calo_art)
		end if
	else
		idw_riga.setitem(al_row,"coef_calo", ld_calo_art)
			ld_calo_buono=dec(ld_calo_art)
	end if
else
	idw_riga.setitem(al_row,"coef_calo", ld_calo_art)
	ld_calo_buono=dec(ld_calo_art)
end if

	
	
RETURN LD_CALO_BUONO
end function

public function integer wf_controlla_range_coef_calo (long al_id_titolo, datawindow adw, long row, string column, integer ad_coef_calo);	DECIMAL{2} ll_coef_max, ll_coef_min, ll_coef_calo, ld_calo_originale
	integer li_ret
	
	
	SELECT orafo_titolo.coef_calo_massimo, orafo_titolo.coef_calo_minimo
		INTO :ll_coef_max, :ll_coef_min
		FROM orafo_titolo
		WHERE orafo_titolo.id_titolo = :al_id_titolo;
		IF ll_coef_max>0 and not isnull(ll_coef_max) THEN
			
			ll_coef_calo=ad_coef_calo
			IF not((ll_coef_calo>=ll_coef_min)and(ll_coef_calo<=ll_coef_max)) THEN
				li_ret=messagebox("Coefficiente di calo non valido","Il coefficiente deve esser compreso tra "+&
				+string(ll_coef_min)+" e "+string(ll_coef_max)+"~r~nVuoi assegnarlo lo stesso?",  stopsign!, yesno!)
				if li_ret=1 then 
					return 1
				else
					
					ld_calo_originale=adw.getitemdecimal(row, "coef_calo")
					adw.post setitem(row, "coef_calo", ld_calo_originale)
					
					adw.post Scrolltorow(row)
					adw.post SetColumn(column)
					return 0
				end if
			END IF
		END IF
		return 1
end function

public function integer wf_salva_ds_partite ();long ll_riga_corrente,  ll_riga_trovata
integer li_ret, righe, i

ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
if ll_riga_corrente > 0 then
	
	
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
	
	li_ret=wf_apri_partita(il_id_documento)
	if li_ret=-1 then return -1
	//20261028 prima: retrieve(ll_sog) con 1 argomento su un ds che ne vuole 2, e gli scarichi non riletti.
	//Ora si rileggono tutti e due: il trigger t_scar_partita_riga_ad puo' aver cambiato partite e scarichi
	wf_ricarica_partite()
end if
return 0
end function

public subroutine wf_ricarica_partite ();//20261028 rilegge dal db i datastore delle partite (aperte e scarichi del documento)
if isvalid(us_dati_partita.s_dw_aper_partita) then destroy us_dati_partita.s_dw_aper_partita
if isvalid(us_dati_partita.s_dw_scar_partita) then destroy us_dati_partita.s_dw_scar_partita
wf_carica_datastore()
end subroutine

public subroutine wf_controlla_partita (long al_row, decimal ad_valore_vecchio, long al_id_titolo, decimal ad_fino_da_controllare, string as_campo_da_settare);decimal{4} ld_val_scarico, ld_val_arrotondamento, ldc_fino_calo
integer i=1
long ll_riga_trovata

select val_scarico
into :ld_val_scarico
from orafo_aper_partita
where id_documento= :il_id_documento and id_titolo=:al_id_titolo;

select val_arrotondamento
into :ld_val_arrotondamento
from orafo_metallo m, orafo_titolo t
where t.id_titolo=:al_id_titolo
and m.id_metallo=t.id_metallo;
if isnull(ld_val_arrotondamento) or ld_val_arrotondamento<0 then ld_val_arrotondamento=0.1

ad_fino_da_controllare=0
do 
	ll_riga_trovata=idw_riga.find("id_titolo="+string(al_id_titolo), i, idw_riga.rowcount())
	ldc_fino_calo=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemdecimal(ll_riga_trovata, "fino_calo")
	ad_fino_da_controllare+=ldc_fino_calo
	i++
	ll_riga_trovata=idw_riga.find("id_titolo="+string(al_id_titolo), i, idw_riga.rowcount())
loop while ll_riga_trovata>0 and i <= idw_riga.rowcount()

if  ld_val_scarico - ad_fino_da_controllare > ld_val_arrotondamento then
	messagebox("Attenzione!", "La partita è negativa, saranno ripristinati i valori precedenti")
	idw_riga.setitem(al_row, as_campo_da_settare, ad_valore_vecchio)
end if


end subroutine

public subroutine wf_crea_oggetto_per_ordini ();string ls_tipo_registro

select tipo_registro
into :ls_tipo_registro
from mod_registro
where id_mod_registro=:il_id_mod_registro;

if sqlca.sqlcode=0 then
	if ls_tipo_registro='OV' then
		u_ordini=create u_ges_ordini
	end if
end if
end subroutine

public subroutine wf_cancella_aper_partita (long al_id_doc, long al_id_titolo, decimal ad_val_scarico, long al_riga);
long ll_riga_trovata, ll_id_caus_mag, ll_id_metallo
decimal{2} ld_aper, ld_scar
string ls_cod_tipo_partita

ll_id_caus_mag=idw_riga.getitemnumber(al_riga, "riga_documento_id_caus_magazzino")
ls_cod_tipo_partita=wf_trova_cod_tipo_partita(ll_id_caus_mag)
if mid(ls_cod_tipo_partita, 2,2)='VU' then
	select id_metallo into :ll_id_metallo
	from orafo_titolo
	where id_titolo=:al_id_titolo;
	select id_titolo into :al_id_titolo
	from orafo_titolo
	where id_metallo=:ll_id_metallo and titolo=1000;
end if


ll_riga_trovata=us_dati_partita.s_dw_aper_partita.find("id_documento="+string(al_id_doc)&
					+ " and id_titolo="+string(al_id_titolo), 1, us_dati_partita.s_dw_aper_partita.rowcount())

if  ll_riga_trovata>0 then
	ld_aper=us_dati_partita.s_dw_aper_partita.getitemdecimal(ll_riga_trovata, "val_apertura")
	if ld_aper > ad_val_scarico then
		ld_aper= ld_aper - ad_val_scarico
		us_dati_partita.s_dw_aper_partita.setitem(ll_riga_trovata, "val_apertura", ld_aper)
	else
		us_dati_partita.s_dw_aper_partita.deleterow(ll_riga_trovata)
	end if
end if
	
	
end subroutine

public function integer wf_gestione_partite (long row, ref decimal ad_peso, decimal ad_peso_originale, decimal ad_coef_calo);string ls_cod_partita
integer li_num_righe, li_ret, i
long ll_id_partita, ll_riga_trovata, ll_id_caus_mag
decimal{2} ld_val_scarico, ld_fino, pippo, ld_peso_non_prezioso, ld_peso

ll_id_partita=idw_riga.getitemnumber(row, "id_riga_partita")
if ll_id_partita>0 then 
	ll_id_partita=0
else
	return 10
end if

//tolgo il non prezioso dal peso_netto da gestire in partita
ld_peso_non_prezioso=idw_riga.getitemdecimal(row, "peso_non_prezioso")
if isnull(ld_peso_non_prezioso) then ld_peso_non_prezioso=0
ad_peso= ad_peso - ld_peso_non_prezioso
//trovo tipo partita
ll_id_caus_mag=idw_riga.getitemnumber(row, "riga_documento_id_caus_magazzino")
ls_cod_partita=wf_trova_cod_tipo_partita(ll_id_caus_mag)
if ls_cod_partita="" or isnull(ls_cod_partita) then return 10
//devo cercare i carichi (iniziano con "A") per questo tipo partita
us_dati_partita.s_tipo_partita="A"+mid(ls_cod_partita, 2,3)
ls_cod_partita=mid(ls_cod_partita, 1, 1)
//se si tratta di uno scarico ...
if ls_cod_partita='S' then
	//Prendo il titolo (salvo diversa indicazione si scarica titolo con titolo
	us_dati_partita.s_ll_id_titolo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(row, "id_titolo")
	//se non c'è titolo chiudo qui	
	if isnull(us_dati_partita.s_ll_id_titolo) then return 0
	//se nonesiste ancora carico la dw delle aperture	
	if not isvalid(us_dati_partita.s_dw_aper_partita) then
		li_ret=wf_carica_datastore()
		if li_ret=0 then return 10
	end if
	//carico dati utili per finestra partita	
	us_dati_partita.s_id_documento=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_documento")
	us_dati_partita.s_ll_id_sog_com=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_sog_commerciale")
	us_dati_partita.s_ll_id_riga_partita=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(row, "id_riga_partita")
	//se l'id riga partita non c'è lo creo
	if isnull(us_dati_partita.s_ll_id_riga_partita) then
		us_dati_partita.s_ll_id_riga_partita=wf_crea_id_riga_partita(row)
	end if
	us_dati_partita.s_ld_quantita_legato=ad_peso
	if us_dati_partita.s_ll_id_titolo>0 then
		if isnull(ad_coef_calo) then //se il coef calo c'è lo recupero
			us_dati_partita.s_ld_coef_calo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row, "coef_calo")
		else
			us_dati_partita.s_ld_coef_calo = ad_coef_calo
		end if
		//se il calo non c'è recupero il fino (calo = titolo)
		if us_dati_partita.s_ld_coef_calo=0 or isnull(us_dati_partita.s_ld_coef_calo) then
			ld_fino=wf_converti_in_fino(ad_peso, us_dati_partita.s_ll_id_titolo)
			us_dati_partita.s_ld_quantita_da_scaricare=ld_fino
			select titolo
			into :us_dati_partita.s_ld_coef_calo
			from orafo_titolo
			where id_titolo=:us_dati_partita.s_ll_id_titolo;
		else
			//altrimenti calcolo in base al calo il peso da scaricare
			us_dati_partita.s_ld_quantita_da_scaricare=round(ad_peso*us_dati_partita.s_ld_coef_calo/1000, 2)
		end if
	elseif  us_dati_partita.s_ll_id_titolo=0 then //se il titolo è=0 lavoro a legato
		ld_fino=ad_peso
	end if
	us_dati_partita.s_scarica_ogni_titolo=idw_gen.getitemstring(1, "scarica_ogni_titolo")
	if isnull(us_dati_partita.s_scarica_ogni_titolo) then us_dati_partita.s_scarica_ogni_titolo='N'
	OpenWithParm(w_orafo_partite_aperte_gd, us_dati_partita)
	us_dati_partita = Message.PowerObjectParm
	
	if isnull(us_dati_partita.s_ld_quantita_selezionata) or us_dati_partita.s_ld_quantita_selezionata=0 then 
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_post_itemch_cond(row, "riga_documento_peso_netto", ad_peso_originale)
		ad_peso=ad_peso_originale
	else
		//riporto nella riga doc il peso corretto gestito in partita
		if ad_peso=0 then 
			ld_peso=us_dati_partita.s_ld_quantita_legato
		else
			ld_peso=ad_peso
		end if
		wf_setta_fino_calo(row)
		if ad_peso <> us_dati_partita.s_ld_quantita_legato then
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_post_itemch_cond(row, "riga_documento_peso_netto", us_dati_partita.s_ld_quantita_legato )
			ad_peso=	us_dati_partita.s_ld_quantita_legato 
		end if
		
	end if
else
	return 10
end if
return 1
end function

public subroutine wf_cerca_dis_cliente (long al_row);
long ll_id_sog, ll_id_art, ll_id_riga_doc,ll_righe
datastore ds_dis_cliente

if is_tipo_documento='O' then
	ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
	ll_id_art=idw_riga.getitemnumber(al_row, "riga_documento_id_articolo")
	
	ds_dis_cliente=create datastore
	ds_dis_cliente.dataobject="d_ok_cerca_dis_cliente"
	ds_dis_cliente.settransobject(sqlca)
	ll_righe=ds_dis_cliente.retrieve(ll_id_art, ll_id_sog)
	if ll_righe> 0 then
		
		ll_id_riga_doc=ds_dis_cliente.getitemnumber(1, "id_riga_doc")
		idw_riga.setitem(al_row,"id_riga_sorgente",ll_id_riga_doc)
	end if
	destroy ds_dis_cliente
END IF
end subroutine

public subroutine wf_crea_datastore ();if isvalid(us_dati_partita.s_dw_aper_partita) then
	destroy us_dati_partita.s_dw_aper_partita
	destroy us_dati_partita.s_dw_scar_partita
end if


string ls_cod_partita, ls_disattiva_partite
long ll_id_caus_magazzino, ll_riga_corrente

ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
if ll_riga_corrente>0 then
	ll_id_caus_magazzino=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente, "documento_id_caus_magazzino")
	ls_cod_partita=wf_trova_cod_tipo_partita(ll_id_caus_magazzino)
	if left(ls_cod_partita, 1) ='S'  then 
		select disattiva_partite
		into :ls_disattiva_partite
		from orafo_par_sistema
		;
		if ls_disattiva_partite='S' then
			return
		else
			wf_carica_datastore()
		end if
	end if
end if
end subroutine

public function integer wf_apri_partita (long al_id_documento);
integer i, li_num_righe, li_ret, a
string ls_tipo_partita, ls_stato, ls_tipo_partita_2, ls_sql, ls_disattiva_partite
long ll_riga_corrente, ll_id_tipo_partita, ll_id_titolo, ll_id_sog_comm, ll_id_metallo,ll_id_tit_old
decimal{4} ld_quantita, ld_val_scar, ld_arr
datastore ds_partita
boolean lb_found
lb_found=true
long ll_id_tit[]


select disattiva_partite
into :ls_disattiva_partite
from orafo_par_sistema
;
if ls_disattiva_partite='S' then return -1

	
	li_num_righe=idw_riga.rowcount()
	if 	li_num_righe<1 then return 0

		ds_partita=create datastore
		ds_partita.dataobject="ds_orafo_partite"
		ds_partita.settrans(sqlca)
		li_ret=ds_partita.retrieve(al_id_documento)
		if li_ret>0 then
			
			
			for i=1 to li_ret
				ls_tipo_partita_2=ds_partita.getitemstring(i, "tipo_partita_2")
				if ls_tipo_partita_2='VU' then
					ll_id_metallo=ds_partita.getitemnumber(i, "id_metallo")
					ll_id_titolo=ds_partita.getitemnumber(i, "id_titolo")
					select id_titolo
					into :ll_id_titolo
					from orafo_titolo
					where id_Metallo=:ll_id_metallo and titolo=1000;
					ds_partita.setitem(i, "gruppo", ll_id_titolo)
				end if
			next
	ds_partita.sort()
	ds_partita.groupcalc()
			
			
		
		
				
					
		
			
			i = 1 
			DO WHILE i<>0
				
						ll_id_tipo_partita=ds_partita.getitemnumber(i, "id_tipo_partita")
						ld_quantita=ds_partita.getitemdecimal(i, "somma_quantita")
						ll_id_sog_comm=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_sog_commerciale")
						ll_id_titolo=ds_partita.getitemnumber(i, "gruppo")
					
			
			
			
						if isnull(ll_id_titolo) then 
							messagebox("Attenzione!", "L'articolo della riga "+string(i)+" non ha titolo!")
							ll_id_titolo=0
							return 0
						else
							a++
							ll_id_tit[a]=ll_id_titolo
						end if
						
						
						select val_scarico
						into :ld_val_scar
						from orafo_aper_partita
						where id_documento= :al_id_documento and id_titolo=:ll_id_titolo;
						if isnull(ld_val_scar) then ld_val_scar=0
						
						SELECT m.VAL_ARRotondamento
						into :ld_arr
						from orafo_metallo m, orafo_titolo t
						where m.id_metallo=t.id_metallo
						and t.id_titolo=:ll_id_titolo;
												
						if ld_val_scar <= ld_quantita + ld_arr then
							if ld_quantita - ld_val_scar  <= ld_arr then
								ls_stato='C' 
								
							else 
								ls_stato='A'
							end if
							IF sqlca.SQLNRows > 0 THEN
								COMMIT USING sqlca;
							else
								rollback;
							end if
						
							update orafo_aper_partita
							set val_apertura=:ld_quantita, stato= :ls_stato
							where id_documento= :al_id_documento and id_titolo=:ll_id_titolo;
							
							IF sqlca.SQLNRows > 0 THEN
								COMMIT USING sqlca;
							else
								rollback;
								
							insert into orafo_aper_partita
							(stato, id_documento, id_tipo_partita, val_apertura, id_titolo)
							values ('A', :al_id_documento, :ll_id_tipo_partita, :ld_quantita, :ll_id_titolo);
							if sqlca.sqlcode<>0 then 
								messagebox("Errore!", "Impossibile aprire la partita!")
								rollback;
							else
								commit;
							end if
								
							END IF
							
							string ls_pippo
							
							select a.stato
							into :ls_pippo
							from orafo_aper_partita a, documento d
							where d.id_documento=a.id_documento
							and a.stato='Z' 
							and a.id_titolo=:ll_id_titolo
							and d.id_sog_commerciale=:ll_id_sog_comm;
							if ls_pippo='Z' then
								wf_recupera_partite_zoppe(al_id_documento,ll_id_titolo, ll_id_sog_comm)
							end if
						else
							messagebox("Errore!", "La partita è negativa! Le modifiche alle righe non verranno salvate!")
							return -1
						end if
						
				
				i = i + 1
				i = ds_partita.FindGroupChange(i, 1)
			LOOP
		end if
	
	destroy ds_partita
	
	ls_sql="delete from orafo_aper_partita where id_documento="+string(al_id_documento)
	for i =1 to upperbound(ll_id_tit)
		ls_sql+=" and id_titolo<>"+string(ll_id_tit[i])
	next
	
	execute IMMEDIATE :ls_sql;
	if sqlca.sqlcode=0 or  sqlca.sqlcode=100 then
		commit;
	else
		messagebox("Errore!", "Partite Non cancellate!")
		rollback;
	end if
	
	return 0
end function

public subroutine wf_avanz_inizio (long al_totale);//20261026 barra di avanzamento sotto le righe (hpb_avanzamento, a destra di "Calc").
//Da usare in qualunque procedura lunga: wf_avanz_inizio(passi totali) prima del ciclo, wf_avanz_passo(passi fatti)
//dentro, wf_avanz_fine() alla fine (anche sulle uscite anticipate). La barra lavora in percentuale (0-100): la
//maxposition di un hprogressbar e' un integer e non basterebbe per i documenti piu' grandi.
if isnull(al_totale) or al_totale < 1 then al_totale = 1
il_avanz_totale = al_totale
ii_avanz_perc = 0
tab_1.tabpage_2.hpb_avanzamento.position = 0
tab_1.tabpage_2.hpb_avanzamento.visible = true
tab_1.tabpage_2.hpb_avanzamento.bringtotop = true
end subroutine

public subroutine wf_avanz_passo (long al_fatti);//20261026 avanzamento: al_fatti passi su il_avanz_totale (vedi wf_avanz_inizio).
//La barra si aggiorna solo quando cambia la percentuale: su 2000 righe sono 100 ridisegni, non 2000.
integer li_perc

if il_avanz_totale < 1 then return
if isnull(al_fatti) or al_fatti < 0 then al_fatti = 0
li_perc = integer(al_fatti * 100 / il_avanz_totale)
if li_perc > 100 then li_perc = 100
if li_perc = ii_avanz_perc then return
ii_avanz_perc = li_perc
tab_1.tabpage_2.hpb_avanzamento.position = li_perc
end subroutine

public subroutine wf_avanz_fine ();//20261026 fine della procedura: la barra sparisce
tab_1.tabpage_2.hpb_avanzamento.visible = false
tab_1.tabpage_2.hpb_avanzamento.position = 0
il_avanz_totale = 0
ii_avanz_perc = 0
end subroutine

public subroutine wf_rec_log_prima ();//20261027 richiesta utente: specchietto delle righe cambiate dal REC (cb_rec_prezzi).
//Fotografa prezzo complessivo, prezzo galvanica e totale di ogni riga PRIMA del recupero (per numero di riga della
//DataWindow: il REC non aggiunge e non toglie righe) e accende ib_rl_attivo, con cui ue_rec_prezzo annota in is_rl_mot
//il prezzo di listino che e' stato ripreso. Il confronto lo fa wf_rec_log_dopo a fine REC.
long ll_riga, ll_n
decimal ldc_vuoto[], ldc_v
string ls_vuoto[]

idc_rl_pc = ldc_vuoto
idc_rl_pm = ldc_vuoto
idc_rl_tot = ldc_vuoto
is_rl_mot = ls_vuoto
ll_n = idw_riga.rowcount()
for ll_riga = 1 to ll_n
	ldc_v = idw_riga.getitemdecimal(ll_riga, "prezzo_complessivo")
	if isnull(ldc_v) then ldc_v = 0
	idc_rl_pc[ll_riga] = ldc_v
	ldc_v = idw_riga.getitemdecimal(ll_riga, "prezzo_metallo")
	if isnull(ldc_v) then ldc_v = 0
	idc_rl_pm[ll_riga] = ldc_v
	ldc_v = idw_riga.getitemdecimal(ll_riga, "tot_riga_val_doc")
	if isnull(ldc_v) then ldc_v = 0
	idc_rl_tot[ll_riga] = ldc_v
	is_rl_mot[ll_riga] = ""
next
ib_rl_attivo = true
end subroutine

public function boolean wf_doc_senza_rec ();//20261126 come nella 64_2025: niente REC sulle note di credito e di debito.
//Nella 64_2025 il controllo e' sugli id dei profili Silver Dreams (PRONC 182, PROND 183, NC 54, NOTADEB 158), che su
//Labella sono altri documenti: qui si guarda il tipo documento AE del profilo, TD04 nota di credito e TD05 nota di debito.
long ll_prof
string ls_tipo_ae
if idw_gen.rowcount() < 1 then return false
ll_prof = idw_gen.getitemnumber(1, "id_prof_documento")
if isnull(ll_prof) then return false
setnull(ls_tipo_ae)
select tipo_documento_ae into :ls_tipo_ae from dba.prof_documento where id_prof_documento = :ll_prof;
if isnull(ls_tipo_ae) then return false
ls_tipo_ae = upper(trim(ls_tipo_ae))
return (ls_tipo_ae = "TD04" or ls_tipo_ae = "TD05")
end function

public subroutine wf_rec_log_dopo ();//20261027 richiesta utente: a fine REC confronta le righe con la fotografia di wf_rec_log_prima e
//1) scrive lo specchietto delle righe cambiate (riga, BOL, documento di provenienza, articolo, pezzi, prezzo complessivo,
//   prezzo galvanica e totale prima/dopo, differenza, motivo) nel file
//   c:\nita\log\REC <registro> n<numero> del <data documento> (<data e ora del REC>).txt
//   del PC che sta usando il programma: un file per ogni REC, anche quando non cambia niente;
//   20261112 (utente) in Excel: lo stesso nome in .xlsx, scritto con LibreOffice da f_rec_log_calc (0,1-0,7 s misurati
//   sulla fattura 167 di prova64); il .txt si scrive solo se l Excel non riesce
//2) mostra un avviso con il riepilogo e le prime 20 righe cambiate (tutte le altre sono nel file).
//Il motivo viene da ue_rec_prezzo (prezzo di listino, in is_rl_mot) piu' quello che si vede qui:
//prezzo metallo cambiato, data di modifica del listino. 20261126 64_nita2: tolte le regole Karizia (Ki4, no_spazz).
//Come wf_log_prezzo_ddt non deve MAI fermare il lavoro: se il file non si apre resta solo l'avviso.
long ll_riga, ll_n, ll_cambiate, ll_uc, ll_lis, ll_prov, ll_num_riga, ll_id_sog, ll_k
decimal ldc_pc, ldc_pm, ldc_tot, ldc_qta, ldc_tara, ldc_tot_prima, ldc_tot_dopo
datetime ldt_mod_lis
date ldt_doc
string ls_file, ls_num, ls_reg, ls_des, ls_bol, ls_prov, ls_art, ls_mot, ls_riga, ls_avviso, ls_utente, ls_quando, ls_testa
string ls_righe[]
integer li_file, li_p
any la_xls[]   //20261112 valori per l Excel: 13 per riga cambiata (f_rec_log_calc)
long ll_x     //20261112
long ll_id_art_x   //20261117 id_articolo al posto della bollettina (Excel, .txt, avviso)
string ls_id_art_x

ib_rl_attivo = false
ll_n = idw_riga.rowcount()
if ll_n > upperbound(idc_rl_tot) then ll_n = upperbound(idc_rl_tot)
ll_id_sog = idw_gen.getitemnumber(1, "id_sog_commerciale")
if isnull(ll_id_sog) then ll_id_sog = 0
ldc_tot_prima = 0
ldc_tot_dopo = 0
ll_cambiate = 0

for ll_riga = 1 to ll_n
	ldc_pc = idw_riga.getitemdecimal(ll_riga, "prezzo_complessivo")
	if isnull(ldc_pc) then ldc_pc = 0
	ldc_pm = idw_riga.getitemdecimal(ll_riga, "prezzo_metallo")
	if isnull(ldc_pm) then ldc_pm = 0
	ldc_tot = idw_riga.getitemdecimal(ll_riga, "tot_riga_val_doc")
	if isnull(ldc_tot) then ldc_tot = 0
	ldc_tot_prima += idc_rl_tot[ll_riga]
	ldc_tot_dopo += ldc_tot
	if abs(ldc_tot - idc_rl_tot[ll_riga]) < 0.005 and abs(ldc_pc - idc_rl_pc[ll_riga]) < 0.00005 &
		and abs(ldc_pm - idc_rl_pm[ll_riga]) < 0.00005 then continue

	ll_cambiate++
	ls_des = idw_riga.getitemstring(ll_riga, "riga_documento_descrizione")
	if isnull(ls_des) then ls_des = ""
	//bollettina: il numero dopo "BOL:" nella descrizione
	ls_bol = ""
	li_p = pos(upper(ls_des), "BOL:")
	if li_p > 0 then
		ls_bol = trim(mid(ls_des, li_p + 4))
		li_p = pos(ls_bol, " ")
		if li_p > 0 then ls_bol = left(ls_bol, li_p - 1)
	end if
	//documento di provenienza (il DDT, per una fattura)
	ls_prov = ""
	ll_prov = idw_riga.getitemnumber(ll_riga, "id_riga_doc_provenienza")
	if not isnull(ll_prov) and ll_prov > 0 then
		setnull(ls_prov)
		select d.num_documento into :ls_prov
		from dba.riga_documento r, dba.documento d
		where r.id_riga_documento = :ll_prov and d.id_documento = r.id_documento;
		if isnull(ls_prov) then ls_prov = ""
		ls_prov = trim(ls_prov)
	end if
	//20261117 (utente) su una fattura il documento di provenienza e' il DDT: si scrive "DDT-bollettina" (es. 1010-1925398)
	//come nel brogliaccio; su un DDT resta com'era
	if is_tipo_registro <> "DV" and ls_prov <> "" and ls_bol <> "" then ls_prov += "-" + ls_bol
	ls_art = idw_riga.getitemstring(ll_riga, "c_articolo_cod")
	if isnull(ls_art) then ls_art = ""
	ldc_qta = idw_riga.getitemdecimal(ll_riga, "quantita")
	if isnull(ldc_qta) then ldc_qta = 0
	ll_num_riga = idw_riga.getitemnumber(ll_riga, "riga_documento_num_riga")
	if isnull(ll_num_riga) then ll_num_riga = ll_riga

	//motivo
	ls_mot = ""
	if ll_riga <= upperbound(is_rl_mot) then ls_mot = is_rl_mot[ll_riga]
	if isnull(ls_mot) then ls_mot = ""
	if idw_riga.getitemnumber(ll_riga, "provv_agente_2") = 2 then ls_mot = "riga M (prezzo a mano, non ripreso dal listino)" + ls_mot
	if abs(ldc_pc - idc_rl_pc[ll_riga]) >= 0.00005 then
		ll_uc = idw_riga.getitemnumber(ll_riga, "riga_documento_id_unita_confezione")
		ll_lis = idw_riga.getitemnumber(ll_riga, "riga_documento_id_listino")
		setnull(ldt_mod_lis)
		select ult_modifica_2 into :ldt_mod_lis from dba.prezzo
		where id_unita_confezione = :ll_uc and id_variazione = :ll_lis;
		if not isnull(ldt_mod_lis) then ls_mot += "; listino modificato il " + string(ldt_mod_lis, "dd/mm/yyyy hh:mm")
	end if
	if abs(ldc_pm - idc_rl_pm[ll_riga]) >= 0.00005 then
		ls_mot += "; prezzo metallo " + string(idc_rl_pm[ll_riga], "0.0000") + " -> " + string(ldc_pm, "0.0000")
	end if
	if left(ls_mot, 2) = "; " then ls_mot = mid(ls_mot, 3)
	if ls_mot = "" then ls_mot = "importo ricalcolato"

	//20261117 (utente) id_articolo al posto della bollettina: Excel, .txt e avviso
	ll_id_art_x = idw_riga.getitemnumber(ll_riga, "riga_documento_id_articolo")
	ls_id_art_x = ""
	if not isnull(ll_id_art_x) then ls_id_art_x = string(ll_id_art_x)
	ls_riga = wf_rl_col(string(ll_num_riga), 6, true) + "  " + wf_rl_col(ls_id_art_x, 9, false) + " " + &
		wf_rl_col(ls_prov, 15, false) + " " + wf_rl_col(ls_art, 30, false) + " " + &
		wf_rl_col(string(ldc_qta, "#,##0.##"), 10, true) + " " + &
		wf_rl_col(string(idc_rl_pc[ll_riga], "0.0000"), 9, true) + " " + wf_rl_col(string(ldc_pc, "0.0000"), 9, true) + " " + &
		wf_rl_col(string(idc_rl_pm[ll_riga], "0.0000"), 9, true) + " " + wf_rl_col(string(ldc_pm, "0.0000"), 9, true) + " " + &
		wf_rl_col(string(idc_rl_tot[ll_riga], "#,##0.00"), 12, true) + " " + wf_rl_col(string(ldc_tot, "#,##0.00"), 12, true) + " " + &
		wf_rl_col(string(ldc_tot - idc_rl_tot[ll_riga], "+#,##0.00;-#,##0.00"), 11, true) + "  " + ls_mot
	if isnull(ls_riga) then ls_riga = "riga " + string(ll_riga) + ": dati non leggibili"   //un nullo annulla la concatenazione
	ls_righe[upperbound(ls_righe) + 1] = ls_riga
	//20261112 gli stessi valori per l Excel (numeri come double, BOL e documento come testo)
	ll_x = upperbound(la_xls)
	la_xls[ll_x + 1] = double(ll_num_riga)
	//20261117 (utente) colonna B "ID ART": id_articolo della riga al posto della bollettina
	if isnull(ll_id_art_x) then
		la_xls[ll_x + 2] = ""
	else
		la_xls[ll_x + 2] = double(ll_id_art_x)
	end if
	la_xls[ll_x + 3] = ls_prov
	la_xls[ll_x + 4] = ls_art
	la_xls[ll_x + 5] = double(ldc_qta)
	la_xls[ll_x + 6] = double(idc_rl_pc[ll_riga])
	la_xls[ll_x + 7] = double(ldc_pc)
	la_xls[ll_x + 8] = double(idc_rl_pm[ll_riga])
	la_xls[ll_x + 9] = double(ldc_pm)
	la_xls[ll_x + 10] = double(idc_rl_tot[ll_riga])
	la_xls[ll_x + 11] = double(ldc_tot)
	la_xls[ll_x + 12] = double(ldc_tot - idc_rl_tot[ll_riga])
	la_xls[ll_x + 13] = ls_mot
	if ll_cambiate <= 20 then
		ls_riga = "Riga " + string(ll_num_riga)
		if ls_id_art_x <> "" then ls_riga += " ID ART " + ls_id_art_x   //20261117 prima la bollettina
		ls_riga += ": " + string(idc_rl_tot[ll_riga], "#,##0.00") + " -> " + string(ldc_tot, "#,##0.00") + &
			" (" + string(ldc_tot - idc_rl_tot[ll_riga], "+#,##0.00;-#,##0.00") + ")  " + ls_mot
		if not isnull(ls_riga) then ls_avviso += "~r~n" + ls_riga
	end if
next
//righe oltre la fotografia (non dovrebbero esserci): contano solo nel totale dopo
for ll_riga = ll_n + 1 to idw_riga.rowcount()
	ldc_tot = idw_riga.getitemdecimal(ll_riga, "tot_riga_val_doc")
	if not isnull(ldc_tot) then ldc_tot_dopo += ldc_tot
next

//testata del documento
ls_num = idw_gen.getitemstring(1, "num_documento")
if isnull(ls_num) then ls_num = ""
ls_num = trim(ls_num)
ldt_doc = idw_gen.getitemdate(1, "data_documento")
ls_reg = is_tipo_registro
if isnull(ls_reg) then ls_reg = ""
ls_utente = u_freddie.s_utenti.s_utente
if isnull(ls_utente) then ls_utente = ""
ls_quando = string(today(), "dd/mm/yyyy") + " " + string(now(), "hh:mm:ss")
ls_testa = "REC " + ls_reg + " n. " + ls_num
if not isnull(ldt_doc) then ls_testa += " del " + string(ldt_doc, "dd/mm/yyyy")
ls_testa += " - fatto il " + ls_quando
if ls_utente <> "" then ls_testa += " da " + ls_utente
ls_riga = "Righe: " + string(ll_n) + "   cambiate: " + string(ll_cambiate) + &
	"   totale prima " + string(ldc_tot_prima, "#,##0.00") + "   dopo " + string(ldc_tot_dopo, "#,##0.00") + &
	"   differenza " + string(ldc_tot_dopo - ldc_tot_prima, "+#,##0.00;-#,##0.00")

//file
ls_num = f_sostituisci_carattere(f_sostituisci_carattere(ls_num, "/", "-"), "\", "-")
if not DirectoryExists("c:\nita\log") then CreateDirectory("c:\nita\log")
ls_file = "c:\nita\log\REC " + ls_reg + " n" + ls_num
if not isnull(ldt_doc) then ls_file += " del " + string(ldt_doc, "yyyy-mm-dd")
ls_file += " (" + string(today(), "yyyy-mm-dd") + " " + string(now(), "hh.mm.ss") + ")"
li_file = -1
//20261112 prima l Excel; se LibreOffice non c e o non riesce, il .txt di sempre
if not isnull(ls_file) then
	if f_rec_log_calc(ls_file + ".xlsx", ls_testa, ls_riga, la_xls) = 1 then
		ls_file += ".xlsx"
		li_file = 0   //0 = Excel scritto: niente .txt
	else
		ls_file += ".txt"
		li_file = FileOpen(ls_file, LineMode!, Write!, LockWrite!, Replace!, EncodingANSI!)
	end if
end if
if li_file > 0 then
	FileWrite(li_file, ls_testa)
	FileWrite(li_file, ls_riga)
	FileWrite(li_file, "")
	if ll_cambiate > 0 then
		//20261117 intestazioni come nell Excel: ID ART al posto di BOL, BOL. al posto di Prov.
		FileWrite(li_file, wf_rl_col("Riga", 6, true) + "  " + wf_rl_col("ID ART", 9, false) + " " + wf_rl_col("Doc. prov.", 15, false) + " " + &
			wf_rl_col("Articolo", 30, false) + " " + wf_rl_col("Pz", 10, true) + " " + &
			wf_rl_col("Prezzo pr", 9, true) + " " + wf_rl_col("Prezzo dp", 9, true) + " " + &
			wf_rl_col("Met. pr.", 9, true) + " " + wf_rl_col("Met. dp.", 9, true) + " " + &
			wf_rl_col("Tot.prima", 12, true) + " " + wf_rl_col("Tot.dopo", 12, true) + " " + wf_rl_col("Diff.", 11, true) + "  Motivo")
		FileWrite(li_file, fill("-", 160))
		for ll_k = 1 to upperbound(ls_righe)
			FileWrite(li_file, ls_righe[ll_k])
		next
		FileWrite(li_file, fill("-", 160))
	else
		FileWrite(li_file, "Nessuna riga cambiata.")
	end if
	FileClose(li_file)
end if

//avviso a video
if ll_cambiate = 0 then
	ls_avviso = ls_testa + "~r~n~r~nNessuna riga cambiata (" + string(ll_n) + " righe controllate)."
else
	ls_avviso = ls_testa + "~r~n" + ls_riga + "~r~n" + ls_avviso
	if ll_cambiate > 20 then ls_avviso += "~r~n... e altre " + string(ll_cambiate - 20) + " righe"
end if
if li_file >= 0 then   //20261112 0 = Excel, maggiore di 0 = .txt
	ls_avviso += "~r~n~r~nSpecchietto completo nel file:~r~n" + ls_file
else
	ls_avviso += "~r~n~r~n(il file in c:\nita\log non si e' potuto scrivere)"
end if
//20261029 (utente) l'avviso a video solo sulle fatture (registro IV); il file in c:\nita\log si scrive sempre
if is_tipo_registro = "IV" then MessageBox("REC finito", ls_avviso, Information!)
end subroutine

public function string wf_rl_col (string as_testo, integer ai_larghezza, boolean ab_destra);//20261027 colonna a larghezza fissa per lo
//specchietto del REC: testo tagliato alla larghezza o completato con spazi (a destra per i numeri)
if isnull(as_testo) then as_testo = ""
if len(as_testo) >= ai_larghezza then return left(as_testo, ai_larghezza)
if ab_destra then return space(ai_larghezza - len(as_testo)) + as_testo
return as_testo + space(ai_larghezza - len(as_testo))
end function

public subroutine wf_calcola_prezzo (long row);decimal ld_importo, ld_imp_manifattura_val, ldc_cambio, ld_imp_manifattura
long ll_id_valuta_riga, ll_nr_cifre_arrot, ll_galvanica
string ls_tipo_arrotondamento, ls_sconto, ls_um, ls_codice_profilo
decimal ld_pr_metallo, ld_pr_manifattura, ld_pr_complessivo
decimal ld_fino_calo, ld_peso

ls_um=tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemstring(row, "tipo_um")
ld_pr_complessivo=idw_riga.GetItemdecimal(row, "prezzo_complessivo")
if ls_um='P' then
	ld_pr_metallo=idw_riga.GetItemdecimal(row, "prezzo_metallo")
	ld_pr_manifattura=idw_riga.GetItemdecimal(row, "prezzo_manifattura")
	ld_fino_calo=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.GetItemdecimal(row, "fino_calo")
	ld_peso=idw_riga.getitemdecimal(row, "riga_documento_peso_netto")
	
	if isnull(ld_peso) then ld_peso=0
	if isnull(ld_pr_metallo) then ld_pr_metallo=0
	if isnull(ld_fino_calo) then ld_fino_calo=0
	if isnull(ld_pr_manifattura) or ld_pr_manifattura=0 then 		
		ld_pr_manifattura=ld_pr_complessivo
	end if
	if isnull(ld_pr_manifattura) then	ld_pr_manifattura=0
	
	ld_imp_manifattura_val=ld_pr_manifattura*ld_peso
	ls_sconto=idw_riga.getitemstring(row, "sconto")
	if not((isnull(ls_sconto)) or (ls_sconto='') or ls_sconto='0') then
		ld_imp_manifattura_val= uf_calcola_prezzo(ls_Sconto, ld_imp_manifattura_val, 1)
	end if
	ld_imp_manifattura_val= uf_Round(ld_imp_manifattura_val)
	//14-02-14 se ilprofilo ="MRBOL" è galvanica
	//non è davvero quotazione e va moltiplicata per il peso, non per il puro (il coef_calo è sempre =1000 quindi non cambia nulla: così ha affermato Samy)
	//20221115 Samy dice che il coefcalo può non essere 1000 quindi guardiamo se c'è la galvanica e agiamo di conseguenza
	if tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_orafo_riga_documento_ordine_silver_gd" then //20230927
		ll_galvanica=idw_riga.getitemnumber(row, "id_gruppo_agenti_2")
		ls_codice_profilo=idw_gen.getitemstring(1, "c_prof_doc_cod")
		if ll_galvanica>0 or ls_codice_profilo='MRBOL' or ls_codice_profilo='MFATLAV' then
			ld_importo=(ld_pr_metallo*ld_peso)+(ld_imp_manifattura_val)
		else
			ld_importo=(ld_pr_metallo*ld_fino_calo)+(ld_imp_manifattura_val)
		end if
	else
		ld_importo=(ld_pr_metallo*ld_fino_calo)+(ld_imp_manifattura_val)
	end if
	//fine 14-02-14
	ld_importo=uf_Round(ld_importo)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row,"importo_manifattura_val", ld_imp_manifattura_val)
		
	//ld_imp_manifattura= ld_imp_manifattura_val * idc_cambio
	ld_imp_manifattura= ld_imp_manifattura_val / idc_cambio
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row,"importo_manifattura", ld_imp_manifattura)
	if ld_importo>=0 then
		ld_importo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row, "prezzo", ld_importo)
		if ld_importo<>1 then 
			messagebox("Errore!", "Setitem fallito, prezzo non settato")
		end if
	else
		
	end if
else
	idw_riga.setitem(row, "prezzo", ld_pr_complessivo)
end if

tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_riga(row)
WF_SETTA_MASK_RIGA()


end subroutine

public function integer wf_acq_cliente (long al_id_articolo, long al_id_soggetto);integer li_ret
string ls_imm
datastore ds_righe


ds_righe=create datastore
ds_righe.dataobject="d_acq_cliente_gd"
ds_righe.settransobject(sqlca)

li_ret=ds_righe.retrieve(al_id_soggetto,al_id_articolo)
destroy ds_righe
return li_ret

end function

public subroutine wf_forza_chius_evasione (long al_riga, string as_ev_forzata);

long ll_id_riga_doc_prov  //, ll_riga_trovata, ll_num_riga, i
//20241209 per spostare il lancio della funzione da updateend a itemchanged

//if not(isvalid(ids_ev_forzata)) then
//	ids_ev_forzata=create datastore
//	ids_ev_forzata.dataobject="ds_ev_forzata"
//	ids_ev_forzata.settransobject(sqlca)
//end if
//ll_id_riga_doc_prov=idw_riga.getitemnumber(al_riga, "id_riga_doc_provenienza")
//ll_num_riga=idw_riga.getitemnumber(al_riga, "riga_documento_num_riga")
//
//wf_controllo_id_riga_doc_prov(ll_id_riga_doc_prov, ll_num_riga, as_ev_forzata)
//
//ll_riga_trovata=ids_ev_forzata.find("id_riga_documento="+string(ll_id_riga_doc_prov), 1, ids_ev_forzata.rowcount())
//if ll_riga_trovata<=0 then 
//	ll_riga_trovata=ids_ev_forzata.insertrow(0)
//	ids_ev_forzata.setitem(ll_riga_trovata, "id_riga_documento", ll_id_riga_doc_prov)
//end if
//ids_ev_forzata.setitem(ll_riga_trovata, "forza_chius_evasione", as_ev_forzata)



ll_id_riga_doc_prov=idw_riga.getitemnumber(al_riga, "id_riga_doc_provenienza")
if ll_id_riga_doc_prov>0 then
	update riga_documento
	set forza_chius_evasione=:as_ev_forzata
	where id_riga_documento=:ll_id_riga_doc_prov;
	if sqlca.sqlcode<>0 then
		rollback;
		messagebox("Salvataggio non Riuscito!", "Chiusura forzata righe non riuscita!")
	else
		commit;
	end if
end if

end subroutine

public subroutine wf_controllo_id_riga_doc_prov (long al_id_riga_doc_prov, long al_num_riga, string as_ev_forzata);
long  ll_riga_trovata, ll_righe

ll_righe=idw_riga.rowcount()
do
	ll_riga_trovata=idw_riga.find("id_riga_doc_provenienza="+string(al_id_riga_doc_prov)+ " and "+&
					" riga_documento_num_riga<>"+string(al_num_riga), ll_riga_trovata+1, ll_righe)
	if ll_riga_trovata>0 then
		idw_riga.setitem(ll_riga_trovata, "forza_chius_evasione", as_ev_forzata)
	end if
loop while ll_riga_trovata>0 and ll_riga_trovata<ll_righe
end subroutine

public subroutine wf_salva_lung_peso ();
long ll_id_art, ll_id_sog,  ll_id_riga, ll_righe, ll_id_prof_documento
long ll_id_lung_peso,ll_test
string ls_simbolo_um, ls_test
decimal ld_lung, ld_peso_unitario
integer i, li_righe_esistenti, li_ret
datetime ldt_daytime
datastore lds_salva_lung_peso, lds_righe_lung_peso, lds_canc_righe

ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
select agg_lunghezza
into :ls_test
from prof_documento
where id_prof_documento=:ll_id_prof_documento;
	
if ls_test='S' or ls_test='P' then 

	ll_righe=idw_riga.rowcount()
	
	lds_salva_lung_peso=create datastore
	lds_salva_lung_peso.dataobject="ds_lung_peso"
	lds_salva_lung_peso.settransobject(sqlca)
	
	lds_righe_lung_peso=create datastore
	lds_righe_lung_peso.dataobject="ds_righe_lung_peso"
	lds_righe_lung_peso.settransobject(sqlca)
	
	lds_canc_righe=create datastore
	lds_canc_righe.dataobject="ds_canc_righe_id_riga"
	lds_canc_righe.settransobject(sqlca)
	
	ll_id_sog	= idw_gen.getitemnumber(1, "id_sog_commerciale")
	ldt_daytime=idw_gen.getitemdatetime(1, "documento_data_ora_creazione")
	
	for i=1 to 	ll_righe
		ld_lung			=	idw_riga.getitemdecimal(i, "riga_documento_dim_l")
		
		
		
		
		IF isnull(ld_lung) THEN LD_LUNG=0
		ll_id_art = idw_riga.getitemnumber(i, "riga_documento_id_articolo")
		if  isnull(ll_id_art) then continue
		
		
		
		if ls_test='P' then
			ll_test=0
			select first num_riga into :ll_test
			from riga_documento r, documento d, prof_documento p
			where d.id_documento<>:il_id_documento
			and id_articolo=:ll_id_art
			and r.id_documento=d.id_documento
			and d.id_sog_commerciale=:ll_id_sog
			and p.id_prof_documento=d.id_prof_documento
			and (p.agg_lunghezza='P' or p.agg_lunghezza='S')
			and r.dim_l=:ld_lung
			;
			if ll_test>0 then
				continue
			end if
		end if
		ls_simbolo_um 	= 	idw_riga.getitemstring(i, "unita_misura_b_simbolo")
		
		
		
		if isnull(ls_simbolo_um) or ls_simbolo_um="" then
			ls_simbolo_um='CM'
		end if
		ll_id_riga			= 	idw_riga.getitemnumber(i, "id_riga_documento")	
		li_righe_esistenti = lds_salva_lung_peso.retrieve(ll_id_sog, ll_id_art, ls_simbolo_um, ld_lung)
		
		if li_righe_esistenti=1 then
			
			
			
			li_righe_esistenti=lds_canc_righe.retrieve(ll_id_riga)
			if li_righe_esistenti<=0 then 
				ll_id_lung_peso=lds_salva_lung_peso.getitemnumber(1, "id_lung_peso")
				lds_righe_lung_peso.insertrow(1)
				lds_righe_lung_peso.setitem(1, "id_lung_peso", ll_id_lung_peso)
				lds_righe_lung_peso.setitem(1, "id_riga_documento", ll_id_riga)
					lds_righe_lung_peso.setitem(1, "data_movimento", ldt_daytime) 
				li_ret=lds_righe_lung_peso.update()
				if li_ret=1 then
					commit;
				else
					rollback;
					messagebox("Errore!", "Lunghezze personalizzate non storicizzate!")
				end if
			end if
			
			
			ll_test=lds_salva_lung_peso.getitemnumber(1, "id_riga_documento")
			if ll_test>0 then
				lds_salva_lung_peso.SETITEM(1, "id_riga_documento", ll_id_riga) 
				lds_salva_lung_peso.setitem(1, "ultimo_aggiornamento", ldt_daytime)
				ld_peso_unitario=round(idw_riga.getitemdecimal(i, "peso_unita"),2)
				lds_salva_lung_peso.setitem(1, "peso_unitario", ld_peso_unitario)
				li_ret=lds_salva_lung_peso.update()
				if li_ret=1 then
					commit;
				else
					rollback;
				messagebox("Errore!", "Lunghezze personalizzate non salvate!")
				end if
			end if
		else 
			
			ld_peso_unitario=round(idw_riga.getitemdecimal(i, "peso_unita"),2)
			lds_salva_lung_peso.insertrow(1)
			lds_salva_lung_peso.setitem(1, "peso_unitario", ld_peso_unitario)
			
			
			
			if isnull(ls_simbolo_um) or ls_simbolo_um="" then
				ls_simbolo_um='CM'
			end if
			lds_salva_lung_peso.setitem(1, "simbolo_um", ls_simbolo_um)
			lds_salva_lung_peso.setitem(1, "lunghezza", ld_lung)
			lds_salva_lung_peso.setitem(1, "id_sog_commerciale", ll_id_sog)
			lds_salva_lung_peso.setitem(1, "id_articolo", ll_id_art)
			lds_salva_lung_peso.setitem(1, "id_riga_documento", ll_id_riga)
			lds_salva_lung_peso.setitem(1, "ultimo_aggiornamento", ldt_daytime)
			li_ret=lds_salva_lung_peso.update()
			if li_ret=1 then
				commit;
			else
				rollback;
				messagebox("Errore!", "Lunghezze personalizzate non salvate!")
			end if
			
			li_righe_esistenti=lds_canc_righe.retrieve(ll_id_riga)
			if li_righe_esistenti<=0 then 
				ll_id_lung_peso=lds_salva_lung_peso.getitemnumber(1, "id_lung_peso")
				lds_righe_lung_peso.setitem(1, "id_lung_peso", ll_id_lung_peso)
				lds_righe_lung_peso.setitem(1, "id_riga_documento", ll_id_riga)
				lds_righe_lung_peso.setitem(1, "data_movimento", ldt_daytime) 
				li_ret=lds_righe_lung_peso.update()
				if li_ret=1 then
					commit;
				else
					rollback;
					messagebox("Errore!", "Lunghezze personalizzate non storicizzate!")
				end if
			end if
		end if
				
		
	next
	destroy(lds_salva_lung_peso)
	destroy(lds_righe_lung_peso)
	destroy(lds_canc_righe)
	
end if
end subroutine

public function s_lung_peso wf_ric_lung_variante (long al_riga, string as_data);
s_lung_peso s_lung
integer li_ret
long ll_id_prof_documento
string ls_test

ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
select prop_lunghezza
into :ls_test
from prof_documento
where id_prof_documento=:ll_id_prof_documento;
if ls_test='S' then
	s_lung.id_sog_commerciale=idw_gen.getitemnumber(1, "id_sog_commerciale")	
	s_lung.cod_articolo=as_data
	openwithparm(w_ric_lung_peso_gd, s_lung)
	s_lung=message.powerobjectparm
end if
return s_lung
end function

public subroutine wf_lung_canc_id_riga (long al_riga);integer li_numero_righe_cancellate

li_numero_righe_cancellate=upperbound(il_id_riga_cancellata)

li_numero_righe_cancellate++

il_id_riga_cancellata[li_numero_righe_cancellate]=idw_riga.getitemnumber(al_riga, "id_riga_documento")

end subroutine

public subroutine wf_storno_lung_peso ();

long ll_id_riga, ll_id_riga_da_riportare, ll_id_lung, ll_azzera[]
integer li_riga_da_cancellare, li_riga_da_riportare, li_upper, i
datastore lds_salva_lung_peso, lds_righe_lung_peso, lds_canc_righe
decimal ld_peso_netto, ld_quantita,ld_peso_manuale
datetime ld_daytime
long ll_null
setnull(ll_null)

li_upper=upperbound(il_id_riga_cancellata)
if li_upper>0 then
	lds_salva_lung_peso=create datastore
	lds_salva_lung_peso.dataobject="ds_storna_lung_peso"
	lds_salva_lung_peso.settransobject(sqlca)
	
	lds_righe_lung_peso=create datastore
	lds_righe_lung_peso.dataobject="ds_storna_righe_lung_peso"
	lds_righe_lung_peso.settransobject(sqlca)
	
	lds_canc_righe=create datastore
	lds_canc_righe.dataobject="ds_canc_righe_id_riga"
	lds_canc_righe.settransobject(sqlca)
				
	for i=1 to li_upper
		if isnull(il_id_riga_cancellata[i]) then continue
		
		li_riga_da_cancellare=lds_canc_righe.retrieve(il_id_riga_cancellata[i])
		if li_riga_da_cancellare=1 then
			lds_canc_righe.deleterow(1)
			if lds_canc_righe.update()=1 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Riga storico non cancellata!")
			end if
		end if
		li_riga_da_cancellare=lds_salva_lung_peso.retrieve(il_id_riga_cancellata[i])
		if li_riga_da_cancellare=1 then
			
			
			
			
			ll_id_lung=lds_salva_lung_peso.getitemnumber(1, "id_lung_peso")
			li_riga_da_riportare=lds_righe_lung_peso.retrieve(ll_id_lung)
			if li_riga_da_riportare>0 then
				
				ll_id_riga_da_riportare=lds_righe_lung_peso.getitemnumber(1, "id_riga_documento")
				ld_daytime=lds_righe_lung_peso.getitemdatetime(1, "data_movimento")
				
				select  peso_netto, quantita
				into :ld_peso_netto, :ld_quantita
				from riga_documento
				where id_riga_documento=:ll_id_riga_da_riportare
				;
				if ld_peso_netto>0 and ld_quantita>0 then
					lds_salva_lung_peso.setitem(1, "peso_unitario", ld_peso_netto/ld_quantita)
				else
					lds_salva_lung_peso.setitem(1, "peso_unitario", 0)
				end if
				lds_salva_lung_peso.setitem(1, "ultimo_aggiornamento", ld_daytime )
				lds_salva_lung_peso.setitem(1, "id_riga_documento", ll_id_riga_da_riportare)
				if lds_salva_lung_peso.update()=1 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Lunghezza personalizzata non aggiornata!")
				end if
			else
				
				
				
				ld_peso_manuale=lds_salva_lung_peso.getitemdecimal(1, "peso_manuale")
				if ld_peso_manuale>0  then
					lds_salva_lung_peso.setitem(1, "id_riga_documento", ll_null)
				else
					lds_salva_lung_peso.deleterow(1)
				end if	
				if lds_salva_lung_peso.update()=1 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Lunghezza personalizzata non stornata!")
				end if
			end if
		end if

	next
	il_id_riga_cancellata=ll_azzera
	destroy(lds_salva_lung_peso)
	destroy(lds_righe_lung_peso)
	destroy(lds_canc_righe)
end if	
	
end subroutine

public function integer wf_tolleranza (long al_riga, decimal ad_peso_totale, decimal ad_qta);integer li_ret
decimal ld_qta, ld_perc_tolleranza, ld_peso_unitario, ld_peso_un_calcolato
decimal ld_perc_tol_calc, ld_dim, ld_peso_manuale
long ll_id_uc, ll_id_sog, ll_di_art
string ls_simbolo

li_ret=1

if is_tipo_registro='DV' then

	ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
	select tolleranza
	into :ld_perc_tolleranza
	from sog_commerciale
	where id_sog_commerciale=:ll_id_sog;
	
	ll_id_uc=idw_riga.getitemnumber(al_riga, "riga_documento_id_unita_confezione")
	
	
	
	if ll_id_uc>0 and ld_perc_tolleranza>0 then
		if ad_qta= -1 then
			ld_qta=idw_riga.getitemdecimal(al_riga, "quantita")
		else
			ld_qta=ad_qta
		end if
		if  ld_qta>0 then
			ld_peso_un_calcolato=ad_peso_totale/ld_qta
			ll_di_art=idw_riga.getitemnumber(al_riga, "riga_documento_id_articolo")
			ld_dim=idw_riga.getitemdecimal(al_riga, "riga_documento_dim_l")
			ls_simbolo=idw_riga.getitemstring(al_riga, "unita_misura_b_simbolo")
			
			
			
			
			select peso_manuale, peso_unitario
			into :ld_peso_manuale, :ld_peso_unitario
			from orafo_lung_peso
			where id_articolo=:ll_di_art
			and id_sog_commerciale=:ll_id_sog
			and lunghezza=:ld_dim
			and simbolo_um=:ls_simbolo;
			if ld_peso_manuale>0 then
				ld_peso_unitario=ld_peso_manuale
			end if
			if isnull(ld_peso_unitario) or ld_peso_unitario=0 then
				select peso_netto
				into :ld_peso_unitario
				from unita_confezione
				where id_unita_confezione=:ll_id_uc;
			end if
			ld_perc_tol_calc=abs(ld_peso_unitario - ld_peso_un_calcolato)*100/ld_peso_unitario
			if ld_perc_tol_calc>ld_perc_tolleranza then
				messagebox("Attenzione!", "Il peso inserito supera la tolleranza ammessa!")
				li_ret=0
			end if		
		end if
	end if
end if
return li_ret
end function

public subroutine wf_blocca_ddt_fatturato ();long ll_righe,  ll_id_riga, ll_filtrate
decimal ld_qta_evasa

datastore ds_righe
string ls_tipo_reg

if is_tipo_registro='DV' then
	ll_righe=idw_riga.rowcount()
	if ll_righe>0 then
		ds_righe=create datastore
		ds_righe.dataobject=idw_riga.dataobject
		if idw_riga.rowscopy(1,ll_righe, primary!, ds_righe, 1, primary!) <>1 then
			messagebox("Errore!", "Righe non copiate!")
		else
			ds_righe.setfilter("qta_evasa>=quantita")
			ll_filtrate=ds_righe.filter()
			if ll_filtrate=ll_righe then
				
				ll_id_riga=idw_riga.getitemnumber(1, "id_riga_documento")
				select r.tipo_registro
				into :ls_tipo_reg
				from registro r, documento d, riga_documento rd
				where rd.id_riga_doc_provenienza=:ll_id_riga
				and d.id_documento=rd.id_documento
				and d.id_registro=r.id_registro;
				if ls_tipo_reg='IV' then
					
					uf_ges_eventi("BLOCCATO")
				end if
			end if
		end if
		destroy(ds_righe)
	end if
end if
end subroutine

public subroutine wf_spese_confezionamento ();
long ll_id_sog, ll_id_var, ll_righe, i
long ll_id_uc
decimal ld_costo_imballo, ld_qta, ld_spesa_imballo, ldc_variazione,ldc_prezzo
long ll_row, ll_id_documento,ll_id_spesa
string ls_campo

ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")

select spesa.id_spesa
into :ll_id_spesa
from spesa_sog_commerciale, spesa
where id_sog_commerciale=:ll_id_sog
and spesa.id_spesa=spesa_sog_commerciale.id_spesa
and spesa.codice='I';
if ll_id_spesa>0 then
	
	ll_id_var=idw_gen.getItemNumber(1,"documento_id_variazione")
	ll_righe=idw_riga.rowcount()
	for i=1 to ll_righe
		ll_id_uc=idw_riga.getitemnumber(i, "riga_documento_id_unita_confezione")
		if isnull(ll_id_uc) then continue
		ld_qta=idw_riga.getitemdecimal(i, "quantita")
		
		
		if isnull(ld_qta) then continue
		ld_costo_imballo=0
		select costo_imballo
		into :ld_costo_imballo
		from prezzo
		where id_unita_confezione=:ll_id_uc
		and id_variazione=:ll_id_var
		;
		ld_costo_imballo*=ld_qta
		if ld_costo_imballo>0 then
			ld_spesa_imballo+=ld_costo_imballo
		end if
	next
	
	if ld_spesa_imballo>0 then
		ll_row=idw_spesa.Find("id_spesa_cod = "+string(ll_id_spesa)  ,1,idw_spesa.RowCount())
		if ll_row > 0  then 
			idw_spesa.SetItem(ll_row, "importo", ld_spesa_imballo)
			idw_spesa.SetItem(ll_row, "mantieni", "S")
			tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)
		else
			messagebox("Attenzione!", "Spesa di imballo non trovata!"+ &
			"~r~nOccorre che la spesa esista nella tabella delle spese!")
			
		end if
	end if
end if
end subroutine

public subroutine wf_controlla_doppioni ();string ls_numero_ultime_5, ls_num_doppio, ls_tipo_reg
long ll_num_prog=0, ll_id_registro
date ldt_data_doc
integer li_numero_reg

ldt_data_doc=idw_gen.getitemdate(1, "data_documento")
ll_id_registro=idw_gen.getitemnumber(1, "id_registro")
select tipo_registro, numero into :ls_tipo_reg, :li_numero_reg
from dba.registro where id_registro=:ll_id_registro;

if (ls_tipo_reg="GV" and (li_numero_reg=2 or li_numero_reg=6)) or (ls_tipo_reg="GA" and li_numero_reg=3 ) then  //sono i registri delle bollettine (2=BOLLETTINE, 6=Bollettine AU, 3 Silver p bollettine)
	ls_numero_ultime_5=idw_gen.getitemstring(1, "num_documento")
	
	if ls_numero_ultime_5> " " then
	//20220106 si cambia: 7 cifre non più 5
	if ldt_data_doc<date("2022/01/10") then
		ls_numero_ultime_5=right(ls_numero_ultime_5, 5)
		select num_documento, num_progressivo
		into :ls_num_doppio, :ll_num_prog
		from dba.documento
		where id_registro=:ll_id_registro
		and right(num_documento, 5)=:ls_numero_ultime_5
		;
	else //20220106 si cambia: 7 cifre non più 5
		ls_numero_ultime_5=right(ls_numero_ultime_5, 7)
 		if il_id_documento>0 then
			select num_documento, num_progressivo
			into :ls_num_doppio, :ll_num_prog
			from dba.documento
			where id_registro=:ll_id_registro
			and right(num_documento, 7)=:ls_numero_ultime_5 and id_documento<> :il_id_documento
			;
		else
			select num_documento, num_progressivo
			into :ls_num_doppio, :ll_num_prog
			from dba.documento
			where id_registro=:ll_id_registro
			and right(num_documento, 7)=:ls_numero_ultime_5 
			;
		end if
	end if
	if ll_num_prog> 0 then messagebox("Attenzione!", "Bollettina già esistente nell'anno " +string(year(today())) + " al numero progressivo  "+ string(ll_num_prog)+"!")
	end if
end if
end subroutine

public subroutine wf_setitem (long al_riga, string as_colonna, datawindow adw, decimal adc_valore);adw.setitem(al_riga,as_colonna,adc_valore)
end subroutine

public subroutine wf_euro_valuta (string ls_trasforma);
integer i, ll_righe
decimal ld_prezzo_manifattura, ld_prezzo_complessivo, ld_parita 
Messagebox("Attenzione!", "Questa funzione trasforma i prezzi "+&
"da Euro a Valuta e viceversa! Consente quindi di inserire i prezzi "+&
"in euro anche in documenti con valuta diversa ($) e poi trasformarli in valuta "+&
"scegliendo 'valuta'. Se si sceglie 'Euro' i prezzi saranno ritrasformati in Euro." +&
"~r~nAttenzione: prima di salvare il documento i prezzi devono essere in valuta!")
ll_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
ld_parita=idw_gen.getitemdecimal(1, "documento_cambio")
for i= 1 to ll_righe
	
	ld_prezzo_manifattura=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(i, "prezzo_manifattura")
	ld_prezzo_complessivo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(i, "prezzo_complessivo")
	If isnull(ld_prezzo_manifattura) then ld_prezzo_manifattura=0
	If isnull(ld_prezzo_complessivo) then ld_prezzo_complessivo=0
	if ls_trasforma='E' then
		ld_prezzo_manifattura/=ld_parita
		ld_prezzo_complessivo/=ld_parita
	else
		ld_prezzo_manifattura*=ld_parita
		ld_prezzo_complessivo*=ld_parita
	end if
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i, "prezzo_manifattura", ld_prezzo_manifattura)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i, "prezzo_complessivo", ld_prezzo_complessivo)
	wf_calcola_prezzo(i)
	
next
end subroutine

public subroutine wf_salva_cod_art_cliente ();
end subroutine

public subroutine wf_trova_cod_art_cliente (string as_articolo, long al_id_articolo);
end subroutine

public subroutine w_recupera_non_prezioso (long al_row, decimal al_qta);decimal ld_peso_non_prezioso, ld_qta
long ll_id_UC
ll_id_uc=idw_riga.getitemnumber(al_row, "riga_documento_id_unita_confezione")
select peso_non_prezioso
into :ld_peso_non_prezioso
from unita_confezione
where id_unita_confezione=:ll_id_UC;

if isnull(ld_peso_non_prezioso) then ld_peso_non_prezioso=0
if al_qta>0 then 
	ld_qta=al_qta
else
	ld_qta=idw_riga.getitemdecimal(al_row, "quantita")
end if
if isnull(ld_qta) then ld_qta=0
idw_riga.setitem(al_row, "peso_non_prezioso", ld_peso_non_prezioso*ld_qta)
	

end subroutine

public subroutine wf_gestione_utenti ();//150107 inserisco gestione utente MM
datawindowchild dwc_utenti
long ll_id_utenti, rtncode
//w_app_frame.s_utenti.i_id_utenti
ll_id_utenti=u_freddie.s_utenti.i_idutente
rtncode = tab_1.tabpage_1.dw_documento_ordine_ff.GetChild('documento_id_utenti', dwc_utenti)
IF rtncode = -1 THEN MessageBox("Error", "Not a dwc_utenti")
dwc_utenti.SetTransObject(SQLCA)
dwc_utenti.Retrieve()
tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1,"documento_id_utenti", ll_id_utenti)

//fine gestione utente
end subroutine

public subroutine wf_salva_note_riga ();long  ll_id_riga
integer li_riga, i, ll_riga_trovata


if tab_1.tabpage_2.dw_nota_riga.visible then
	for i= 1 to idw_riga.rowcount()
		
		li_riga=idw_riga.getitemnumber(i, "riga_documento_num_riga")
		ll_riga_trovata=tab_1.tabpage_2.dw_nota_riga.find&
							("num_riga="+string(li_riga), 1, &
							tab_1.tabpage_2.dw_nota_riga.rowcount())
	
		IF ll_riga_trovata>0 THEN
			ll_id_riga=idw_riga.getitemnumber(i, "id_riga_documento")
			tab_1.tabpage_2.dw_nota_riga.SETITEM(ll_riga_trovata, "note_id_riga_doc", ll_id_riga)
		END IF
		
	next
	
	for i= 1 to tab_1.tabpage_2.dw_nota_riga.rowcount()
		ll_id_riga=tab_1.tabpage_2.dw_nota_riga.getitemnumber(i, "note_id_riga_doc")
		ll_riga_trovata=idw_riga.find("id_riga_documento="+string(ll_id_riga), 1, idw_riga.rowcount())
		IF ll_riga_trovata>0 THEN 
			continue
		else
			tab_1.tabpage_2.dw_nota_riga.deleterow(i)	
		end if
	next
	
	tab_1.tabpage_2.dw_nota_riga.accepttext()
	
	if tab_1.tabpage_2.dw_nota_riga.update()=1 then
	commit;
	
	else
		rollback;
		messagebox("Attenzione!", "Note non salvate! Motivo: "+SQLCA.SQLErrText)
	end if
end if
end subroutine

public subroutine wf_ricalcola_figli (decimal adc_qta_originale, decimal adc_qta_new, long al_riga);long ll_id_riga_provenienza, ll_id_riga_padre, ll_test
integer i
decimal ldc_qta

ll_test=idw_riga.getitemnumber(al_riga, "id_riga_doc_padre")
if isnull(ll_test) then
	
	ll_id_riga_provenienza = idw_riga.getitemnumber(al_riga, "riga_documento_provv_imp_subage_2")
//	ll_id_riga_provenienza = idw_riga.getitemnumber(al_riga, "id_riga_doc_provenienza")
	if ll_id_riga_provenienza>0 then
		for i= 1 to idw_riga.rowcount()
			ll_id_riga_padre=idw_riga.getitemnumber(i, "id_riga_doc_padre")
			if ll_id_riga_padre=ll_id_riga_provenienza then
				//occorre aggiornare la qta in base alla midifica della qta del padre
				//qta figlio/qta old padre*qtanewpadre
				ldc_qta=idw_riga.getitemdecimal(i, "quantita")
				ldc_qta=ldc_qta/adc_qta_originale*adc_qta_new
				idw_riga.setitem(i, "quantita", ldc_qta)
				//stessa cosa per il peso
				ldc_qta=idw_riga.getitemdecimal(i, "riga_documento_peso_netto")
				ldc_qta=ldc_qta/adc_qta_originale*adc_qta_new
				idw_riga.setitem(i, "riga_documento_peso_netto", ldc_qta)
				wf_calcola_fino_calo(i)  //20261106 fino e calo del figlio sul peso ricalcolato
			end if
		next 
	end if
end if
end subroutine

public subroutine wf_inserisci_id_ordine (long al_row);//INSERISCO ID ORDINE SE è UN ORDINE (REGISTRO ov)
//IN ID_RIGA_SORGENTE PER LEGARE LA PRODUZIONE NELLA STAMPA STEP-PRODUZIONE SILVER (160610)
LONG ll_id_registro, ll_id_doc
string ls_tipo_registro


ll_id_registro=IDW_GEN.getitemnumber(1, "id_registro")
select tipo_registro
into :ls_tipo_registro
from dba.registro
where id_registro=:ll_id_registro;
if ls_tipo_registro='OV' then
	ll_id_doc=idw_gen.getitemnumber(1, "id_documento")
	idw_riga.setitem(al_row, "id_riga_sorgente", ll_id_doc)
	
end if
end subroutine

public subroutine wf_prezzo_galvanica (long al_row, string as_cod_art);//samy 280910 recuepro prezzo galvanica da listino (lo metto per adesso
//in prezzo metallo poi si vedrà ...
long ll_id_uc, ll_id_sog, ll_id_lis_cliente, ll_id_var, ll_id_galvanica
date ldt_data_doc
decimal ldc_costo_galvanica
string ls_controllato


ll_id_uc=idw_riga.getitemnumber(al_row, "riga_documento_id_unita_confezione")
ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
ldt_data_doc=idw_gen.getitemdate(1, "data_documento")

select id_listino
into :ll_id_lis_cliente
from dba.sog_commerciale
where id_sog_commerciale=:ll_id_sog;
if ll_id_lis_cliente>0 then
	//trovo la variaizone e quindi il prezzo galvanica
	select id_variazione
	into :ll_id_var
	from dba.variazione
	where id_listino=:ll_id_lis_cliente
	and data_inizio<= :ldt_data_doc
	and (data_fine>=:ldt_data_doc or data_fine is null)
	;
else //cerco nel listino di base di vendita
	select id_variazione
	into :ll_id_var
	from dba.variazione v, dba.listino l
	where l.id_listino=v.id_listino
	and l.lis_base='S'
	and l.tipo='V'
	and data_inizio<= :ldt_data_doc
	and (data_fine>=:ldt_data_doc or data_fine is null)
	;
end if
select galvanica, confermato, id_galvanica //agg 2019-05-02
into :ldc_costo_galvanica, :ls_controllato, :ll_id_galvanica
from dba.prezzo
where id_unita_confezione=:ll_id_uc
and id_variazione=:ll_id_var
;
if ldc_costo_galvanica>0 then
	idw_riga.setitem(al_row, "prezzo_metallo", ldc_costo_galvanica)
end if
if ls_controllato='C' then
	idw_riga.setitem(al_row, "provv_agente_2", 1)
end if
if ll_id_galvanica>0 then 	idw_riga.setitem(al_row, "id_gruppo_agenti_2", ll_id_galvanica)



end subroutine

public subroutine wf_togli_tara (long al_row, decimal adc_peso, dwobject a_dwo);decimal ldc_tara
string ls_des_2, ls_des, ls_parte_destra
long ll_id_variazione, ll_id_uc
integer li_pos

idw_riga.setitem(al_row, "riga_documento_peso_netto", adc_peso)
//20261106 fino e calo SUBITO sul peso netto senza lacci, fili e tara (come wf_fino_calo nella 64 del 20261026):
//prima li rifaceva solo l'itemchanged qui sotto, lanciato con post dopo il post di wf_togli_tara, e se il
//salvataggio arrivava prima restavano quelli del peso lordo
wf_calcola_fino_calo(al_row)
idw_riga.post event itemchanged(al_row, idw_riga.object.riga_documento_peso_netto, string(adc_peso))

wf_incartato_imbustato(al_row)

//ldc_tara=idw_riga.getitemdecimal(al_row, "riga_documento_peso_lordo")
//ls_des=idw_riga.getitemstring(al_row, "riga_documento_descrizione")
////Samy chiede di aggiungere "Incartato/Imbustato" se la tara>0 e nella des2 NON 'c'è "Ki"
//if ldc_tara>0 then
//	if pos(ls_des, "-Incartato/imbustato-")<=0 then //se non c'è lo aggiungo se c'è non faccio nulla
//		ll_id_variazione=idw_riga.getitemnumber(al_row, "riga_documento_id_listino")
//		ll_id_uc=idw_riga.getitemnumber(al_row, "riga_documento_id_unita_confezione")
//		select des_2 into :	ls_des_2 from dba.prezzo
//		where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;		
//		ls_des_2=upper(ls_des_2)
//		if ls_des_2> " " then
//			if isnull(ls_des_2) then ls_des_2=" "
//			if pos(ls_des_2, "KI")<=0 then
//				if isnull(ls_des) then ls_des=" "
//				ls_des+= "-Incartato/imbustato-"
//				idw_riga.setitem(al_row, "riga_documento_descrizione", ls_des)
//			end if
//		end if
//	end if
//else //se è =0 o nulla devo controllare se c'è "-Incartato/imbustato-" e toglilerlo
//	li_pos= pos(ls_des, "-Incartato/imbustato-")
//	if li_pos>0 then
//		if len(ls_des)> li_pos+21 then ls_parte_destra=mid(ls_des, li_pos+21, len(ls_des))
//		if isnull(ls_parte_destra) then ls_parte_destra=""
//		ls_des=left(ls_des, li_pos - 1)+ls_parte_destra
//		idw_riga.setitem(al_row, "riga_documento_descrizione", ls_des)
//	end if
//end if
end subroutine

public subroutine wf_prod_2011 ();
end subroutine

public subroutine wf_rec_galvanica (string as_id, long al_riga);decimal ldc_prezzo
string ls_descrizione, ls_des_originale
long ll_id, ll_pos, ll_id_prof,ll_test
date ldt_data_doc

ll_id=long(as_id)
wf_contr_peso_uni_galvanica(ll_id, al_riga)

ldt_data_doc=idw_gen.getitemdate(1, "data_documento")
//if ldt_data_doc>= date("2019-06-01") then  //modifica del 28-08-2019
	select descrizione
	into  :ls_descrizione
	from dba.galvanica
	where id_galvanica=:ll_id;
	if ls_descrizione="L" or ls_descrizione="L1" then  //20231108
		ll_test=wf_contr_peso_uni_galvanica(ll_id, al_riga)
		if ll_test>0 then ll_id=ll_test
	end if
	ldc_prezzo=f_rec_prezzo_galvanica(ldt_data_doc, ll_id)
//else
//	select descrizione, prezzo_gr
//	into  :ls_descrizione, :ldc_prezzo 
//	from dba.galvanica
//	where id_galvanica=:ll_id;
//end if


//04-03-2019 se il profilo è ddtven e la galvanica è "RP"  allora devo mettere il prezzo galvanica insieme al prezzo manifattura (Elisa SAMY)
ll_id_prof=idw_GEN.getitemnumber(1, "id_prof_documento")
if ll_id=23 and (ll_id_prof=25 or ll_id_prof=142) then
	if idw_riga.getitemdecimal(al_riga, "prezzo_manifattura")>0 then
		ldc_prezzo+=idw_riga.getitemdecimal(al_riga, "prezzo_manifattura")
	end if
	idw_riga.setitem(al_riga, "prezzo_manifattura", ldc_prezzo)
	idw_riga.setitem(al_riga, "prezzo_metallo", 0)
else //altrimenti tutto regolare, lo metta sulla quotazione metallo (prezzo_metallo)
	idw_riga.setitem(al_riga, "prezzo_metallo", ldc_prezzo)
end if

ls_des_originale=idw_riga.getitemstring(al_riga, "riga_documento_descrizione")
ll_pos=pos(ls_des_originale, "__")
if ll_pos>0 then
	ls_des_originale=left(ls_des_originale, ll_pos - 1)
end if
idw_riga.setitem(al_riga, "riga_documento_descrizione", ls_des_originale +" __ "+ ls_descrizione)
end subroutine

public subroutine wf_ric_giac_partita_pezzo ();long ll_id_art
if idw_riga.getrow()>0 then
	ll_id_art=idw_riga.getitemnumber(idw_riga.getrow(), "riga_documento_id_articolo")
else
	ll_id_art=0
end if
if is_pz_giacenza="S" then
	if  isvalid(w_giacenza_pz) then
		w_giacenza_pz.w_leggi_saldo(ll_id_art)
	else
		openwithparm(w_giacenza_pz, ll_id_art, iw_corrente )
	end if
elseif is_pz_giacenza="P" then
	if  isvalid(w_partita_a_pz) then
		w_partita_a_pz.w_leggi_saldo(ll_id_art)
	else
		openwithparm(w_partita_a_pz, ll_id_art, iw_corrente )
	end if
elseif is_pz_giacenza="E" then
	if  isvalid(w_giacenza_pz) then
		w_giacenza_pz.w_leggi_saldo(ll_id_art)
	else
		openwithparm(w_giacenza_pz, ll_id_art, iw_corrente )
	end if
	if  isvalid(w_partita_a_pz) then
		w_partita_a_pz.w_leggi_saldo(ll_id_art)
	else
		openwithparm(w_partita_a_pz, ll_id_art, iw_corrente )
	end if
end if

end subroutine

public subroutine wf_car_nota_art_in_produzione (long al_row);long ll_id_art, ll_riga, ll_riga_trovata, LL_TEST
string ls_vedi_note, ls_nota
integer li_num_riga

if tab_1.tabpage_2.dw_nota_riga.visible then
	ll_id_art=idw_riga.getitemnumber(al_row, "riga_documento_id_articolo")
	select nota
	into :ls_nota
	from dba.articolo
	where id_articolo=:ll_id_art;
	//devo caricare solo fino al carattere "$"
	if pos( ls_nota , "$")>0 then
		ls_nota=left(ls_nota, pos( ls_nota , "$") - 1)
	end if
	
	ll_riga=idw_riga.getitemnumber(al_row, "id_riga_documento")
	if isnull(ll_riga) then
		ll_riga=idw_riga.getitemnumber(al_row, "riga_documento_num_riga")
		ll_riga_trovata=tab_1.tabpage_2.dw_nota_riga.find("num_riga="+string(ll_riga), 1, tab_1.tabpage_2.dw_nota_riga.rowcount())
	else
		ll_riga_trovata=tab_1.tabpage_2.dw_nota_riga.find("note_id_riga_doc="+string(ll_riga), 1, tab_1.tabpage_2.dw_nota_riga.rowcount())
		if ll_riga_trovata <= 0 then
			LL_TEST=tab_1.tabpage_2.dw_nota_riga.ROWCOUNT()
			tab_1.tabpage_2.dw_nota_riga.retrieve(ll_riga)
			if ll_test = tab_1.tabpage_2.dw_nota_riga.ROWCOUNT() then 
				ll_riga_trovata=tab_1.tabpage_2.dw_nota_riga.insertrow(0)
				//250208
				li_num_riga=idw_riga.getitemnumber(al_row, "riga_documento_num_riga")
				tab_1.tabpage_2.dw_nota_riga.setitem(ll_riga_trovata, "num_riga", li_num_riga)
			else
				ll_riga_trovata=tab_1.tabpage_2.dw_nota_riga.find("note_id_riga_doc="+string(ll_riga), 1, tab_1.tabpage_2.dw_nota_riga.rowcount())
			end if
		 end if
	end if
	tab_1.tabpage_2.dw_nota_riga.scrolltorow(ll_riga_trovata)
	tab_1.tabpage_2.dw_nota_riga.setitem(ll_riga_trovata, "nota_produzione", ls_nota)
	
end if
end subroutine

public subroutine wf_copia_riga (long al_riga);
end subroutine

public function decimal wf_calcola_qta_residua_bollettina (long al_id_bollettina, long al_id_riga_madre);decimal ldc_qta_in_pronto, ldt_qta_bollettina, ldc_qta_giusta

//occorre calcolare i pezzi da proporre
//prendo tutte le righe di pronto salvate ad ora riferite a questa bollettina
//e sommo le qta
SELECT sum("riga_documento"."quantita") 
into :ldc_qta_in_pronto
FROM "produzione_2011",   
"riga_documento",   
"caus_magazzino"  
WHERE "riga_documento"."id_riga_documento" = "produzione_2011"."id_doc_produzione"  and  
 "caus_magazzino"."id_caus_magazzino" = "riga_documento"."id_caus_magazzino"  and  
 "produzione_2011"."id_bollettina" = :al_id_bollettina  AND 
"riga_documento"."id_riga_documento" <> :al_id_riga_madre and
 "caus_magazzino"."step_produzione" = 'X'   
	;
if isnull(ldc_qta_in_pronto) then ldc_qta_in_pronto=0
select sum("riga_documento"."quantita")
into :ldt_qta_bollettina
from dba.riga_documento
where id_documento=:al_id_bollettina
and (id_riga_doc_padre is null or id_riga_doc_padre=0)
;
if isnull(ldt_qta_bollettina) then ldt_qta_bollettina=0
ldc_qta_giusta=ldt_qta_bollettina - ldc_qta_in_pronto //- ldc_qta_madre
if ldc_qta_giusta<0 then ldc_qta_giusta=0
//ora propongo la qta giusta
return ldc_qta_giusta
end function

public subroutine wf_ges_partite_da_deriva ();//
decimal ld_peso,  ld_peso_originale, ld_null
integer li_ret
long i, ll_righe

setnull(ld_null)

ll_righe=idw_riga.rowcount()
us_dati_partita.s_i_partite_da_derivazione=1
for i= 1 to ll_righe
	
//dopo la derivazione, se è il caso, lancio la gestione partite
	ld_peso=idw_riga.getitemdecimal(i, "riga_documento_peso_netto")
	wf_crea_id_riga_partita(i)
	li_ret=wf_gestione_partite(i, ld_peso, ld_peso_originale, ld_null)
next

end subroutine

public function integer wf_controlla_legato ();long ll_righe
integer i, li_ret
decimal ldc_legato
string ls_test


SELECT NUM_DOCUMENTO, NUM_PROGRESSIVO, d.id_prof_documento, r.quantita FROM documento d, riga_documento r
where d.id_documento=r.id_documento 
and r.peso_netto=0.01
AND D.DATA_DOCUMENTO> DATE('2019-01-01')





select controlla_peso_e_stampa
into :ls_test
from dba.orafo_par_sistema
;
if ls_test="B" or ls_test="C" then

	ll_righe=idw_riga.rowcount()
	
	for i = 1 to ll_righe
		ldc_legato= idw_riga.getitemdecimal(i, "riga_documento_peso_netto")
		if ldc_legato>0 then 
			continue
		else
			if ls_test="B" then
				messagebox("Attenzione!", "La riga n° "+ string(i)+" ha legato <=0! Impossibile stampare!")
				return -1
			else
				li_ret=messagebox("Attenzione!", "La riga n° "+ string(i)+" ha legato <=0! Vuoi stampare lo stesso?", stopsign!, yesno! )
				if li_ret=1 then 
					return 1
				else
					return -1
				end if
			end if
		end if
		
	next
end if
return 1
end function

public subroutine wf_clicca_cb_partite ();string ls_profilo
ls_profilo=idw_gen.getitemstring(1, "c_prof_doc_cod")
if ls_profilo="VRBOL" then
	
	if messagebox("Attenzione!", "Vuoi scaricare le partite legate a questo VRBOL?", &
		stopsign!, yesno!)=1 then
		tab_1.tabpage_2.cb_partite.triggerevent(CLICKED!)
	end if
	
end if


end subroutine

public subroutine wf_attenzione ();messagebox("Attenzione!", "Ti sei ricordata di stornare gli ordini?")
end subroutine

public subroutine wf_proteggi_prezzi_confermati (long al_row, decimal adc_old_value, string as_campo);string ls_prezzo_confermato, ls_riga_confermata
integer li_ret
//240713 proteggo i prezzi se sono confermati (stampato=C o X)
//ls_prezzo_confermato=idw_gen.getitemstring(1, "documento_stampato") abbandonato vedi sotto
//ls_riga_confermata=idw_riga.getitemstring(al_row, "riga_documento_da_stampare") abbandonata vedi sotto
ls_riga_confermata=idw_riga.getitemstring(al_row, "provv_agente_2")  //correzione(forse) 20220304

//if ls_prezzo_confermato='C' or ls_prezzo_confermato='X' or ls_riga_confermata='C' or ls_riga_confermata='X' then  20220304
if ls_riga_confermata='C' or ls_riga_confermata='X' then 
	li_ret= messagebox("Attenzione!", "Prezzo Confermato: lo vuoi cambiare lo stesso?", stopsign!, yesno!, 2)
	if li_ret <>1 then
		idw_riga.setitem(al_row, as_campo, adc_old_value)

	end if
end if
//240713 fine
end subroutine

public subroutine wf_art_aut_del_fornitore ();//per recuperare eventuale articolo da porporre nella riga doc se il fornitore è adeguato
//mm 23-12-13 12.00 13.00
//parte da selectionchanged del tab, ma se lo vuole per tutte le righe va messo nell'ue_insert o ue_INIT
long ll_id_sog_commerciale, ll_id_articolo, ll_riga, ll_id_prof_doc, ll_righe
string ls_cod_articolo, ls_tipo_registro
datastore ds_fornitore_articolo
integer i

ll_riga=idw_riga.getrow()
if ll_riga>0 then
	ls_tipo_registro=uf_tipo_registro(il_id_registro)
	
	if ls_tipo_registro='DV' then
		ds_fornitore_articolo=create datastore
		ds_fornitore_articolo.dataobject="d_fornitore_articolo_ra"
		ds_fornitore_articolo.settransobject(sqlca)
		ll_id_sog_commerciale=idw_gen.getitemnumber(1, "id_sog_commerciale")
		ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
		ll_righe=ds_fornitore_articolo.retrieve(ll_id_sog_commerciale, ll_id_prof_doc)
//		select f.id_articolo, codice
//		into :ll_id_articolo, :ls_cod_articolo
//		from dba.fornitore_articolo f, dba.articolo a
//		where f.id_sog_commerciale=:ll_id_sog_commerciale
//		and a.id_articolo=f.id_articolo
//		;
		
		for i= 1 to ll_righe
			ls_cod_articolo=ds_fornitore_articolo.getitemstring(i, "articolo_codice")
			//ERA LANCIATO DAL SELCTIONCHAGED DEL TAB , ORA DAL UE:_INITIAL DELLA RIGA ... 010114
			ll_riga=idw_riga.getrow()
		//	if ll_riga=0 or isnull(ll_riga) then
		//		idw_riga.triggerevent("ue_insert")
		//		ll_riga=1
		//	elseif ll_riga>1 then
		//		return
		//	end if
			//if ll_id_articolo>0 then
			if ls_cod_articolo>" " then
				idw_riga.trigger event itemchanged(ll_riga, idw_riga.object.c_articolo_cod, ls_cod_articolo)
				idw_riga.post setcolumn("riga_documento_peso_netto")
			end if
		next
		destroy ds_fornitore_articolo
	end if
end if
end subroutine

public function integer wf_carica_datastore ();
long ll_id_sog, ll_id_doc, ll_riga_corrente, ll_id_prof
datetime ldt_data_ora
string ls_disattiva_partite, ls_ges_partite

select disattiva_partite
into :ls_disattiva_partite
from orafo_par_sistema
;
//inserito 10-02-14: se NON voglio disattivare le partite, ma mi servono solo su determinati profili
//di documento allora ho inserito questo flag
ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
ll_id_prof=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente, "ID_prof_DOCUMENTO")

select ges_partite_orafe
into :ls_ges_partite
from dba.prof_documento
where id_prof_documento=:ll_id_prof
;


//if (ls_disattiva_partite='N' or isnull(ls_disattiva_partite)) and ls_ges_partite='S' then
//fine modifica 10-02-14
//modifica del 06072015 prima dava errore se sicambiava ora doc prima di salvare il documento
if ls_disattiva_partite='S' then
	return 0
else 
	if ls_ges_partite='S' then
		if ll_riga_corrente> 0 then
			ll_id_doc=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente, "ID_DOCUMENTO")
			ldt_data_ora=tab_1.tabpage_1.dw_documento_ordine_ff.getitemdatetime(ll_riga_corrente, "doCUMENTO_data_ora_creazione")
			IF ll_id_doc>0 THEN
				ll_id_sog=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente, "id_sog_commerciale")
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
			ELSE
				return 0
			END IF
		end if
	else
		return 00
	end if
//else
//	return 0
end if
end function

public subroutine wf_prezzo_modificato (long al_riga, string as_data, string as_colonna);//colora di blu il prezzo modificato o inserito a mano
//ma sarebbe meglio che memorizzasse da qualche aprte dataora modifica (con id_riga, colonna)
//e magari utente

end subroutine

public subroutine wf_des_aggiuntiva (long al_riga);long ll_riga_trovata, ll_righe_esistenti, ll_di_riga
integer li_num_riga


if tab_1.tabpage_2.dw_des_aggiuntiva.visible=true then

	if idw_riga.rowcount()>0 then
		if al_riga>0 then
			//cambio: 23022021 uso la id_riga_Documento
			ll_di_riga= idw_riga.getitemnumber(al_riga, "id_riga_documento")
			//li_num_riga = idw_riga.getitemnumber(al_riga, "riga_documento_num_riga")
			//if li_num_riga>0 then
			if ll_di_riga>0 then
				ll_righe_esistenti = tab_1.tabpage_2.dw_des_aggiuntiva.rowcount()
				if ll_righe_esistenti>0 then
					ll_riga_trovata= tab_1.tabpage_2.dw_des_aggiuntiva.find&
					("id_riga_documento= "+string(il_id_documento)+" and num_riga= "+string(li_num_riga), 1, ll_righe_esistenti)
					//("id_documento= "+string(il_id_documento)+" and num_riga= "+string(li_num_riga), 1, ll_righe_esistenti)
					if ll_riga_trovata>0 then
						tab_1.tabpage_2.dw_des_aggiuntiva.scrolltorow(ll_riga_trovata)
					else
						wf_ins_riga_2()
					end if
				else
					wf_ins_riga_2()
				end if
			end if
		end if
	end if
end if

end subroutine

public subroutine wf_retrieve_riga_doc_2 ();string ls_cod_azienda
integer li_num_riga
long ll_riga_corrente, ll_righe

select codice 
into :ls_cod_azienda
from azienda
;
//290814 solo per silverdreams
//if ls_cod_azienda='SILVERDR' or ls_cod_azienda='VENER' then //commentato il 04-11-15
//messagebox("A", "wf_retreive_riga_doc_2")
if tab_1.tabpage_2.dw_des_aggiuntiva.visible=true then
	ll_righe=tab_1.tabpage_2.dw_des_aggiuntiva.rowcount()
	if isnull(ll_righe) then ll_righe=0
	if ll_righe <=0 then
		tab_1.tabpage_2.dw_des_aggiuntiva.retrieve(il_id_documento)
	end if
	ll_riga_corrente=idw_riga.getrow()
	if ll_riga_corrente>0 then
		wf_des_aggiuntiva(ll_riga_corrente)
	end if
	
end if
end subroutine

public subroutine wf_ins_riga_2 ();long ll_riga_inserita, ll_riga, ll_id_riga_doc
integer li_num_riga

if tab_1.tabpage_2.dw_des_aggiuntiva.visible=true then
	
	ll_riga_inserita = tab_1.tabpage_2.dw_des_aggiuntiva.insertrow(0)
	//e metto il numero di riga al posto dell'id per collegarla
	ll_riga=idw_riga.getrow()
	//if ll_riga>0 then
		ll_id_riga_doc=idw_riga.getitemnumber(ll_riga, "id_riga_documento")
		li_num_riga=idw_riga.getitemnumber(ll_riga, "riga_documento_num_riga")
		tab_1.tabpage_2.dw_des_aggiuntiva.setitem(ll_riga_inserita, "id_documento",il_id_documento)
		tab_1.tabpage_2.dw_des_aggiuntiva.setitem(ll_riga_inserita, "num_riga",li_num_riga) 
		tab_1.tabpage_2.dw_des_aggiuntiva.setitem(ll_riga_inserita, "id_riga_documento",ll_id_riga_doc) 
		
		tab_1.tabpage_2.dw_des_aggiuntiva.scrolltorow(ll_riga_inserita)
	//end if
end if
end subroutine

public subroutine wf_delete_riga_2 (long al_riga);integer li_num_riga
long ll_righe_esistenti, ll_riga_trovata


if tab_1.tabpage_2.dw_des_aggiuntiva.visible=true then
	if al_riga>0 then
		li_num_riga=idw_riga.getitemnumber(al_riga, "riga_documento_num_riga")
		ll_righe_esistenti = tab_1.tabpage_2.dw_des_aggiuntiva.rowcount()
			if ll_righe_esistenti>0 then
				ll_riga_trovata= tab_1.tabpage_2.dw_des_aggiuntiva.find&
				("id_documento= "+string(il_id_documento)+" and num_riga= "+string(li_num_riga), 1, &
				ll_righe_esistenti)
				if ll_riga_trovata>0 then
					tab_1.tabpage_2.dw_des_aggiuntiva.deleterow(ll_riga_trovata)
				end if
			end if
		
	end if
end if

end subroutine

public subroutine wf_salva_riga_doc_2 ();//290814 salvo la riga_doc_2 (estensione della riga documento)
if tab_1.tabpage_2.dw_des_aggiuntiva.visible=true and tab_1.tabpage_2.dw_des_aggiuntiva.rowcount()>0 then
	tab_1.tabpage_2.dw_des_aggiuntiva.accepttext()
	if tab_1.tabpage_2.dw_des_aggiuntiva.update()=1 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Descrizione aggiuntiva NON salvata!")
	end if
	//fine 290814
end if
end subroutine

public subroutine wf_cancella_riga_2 (long al_riga);long ll_num_riga, ll_riga_trovata


if tab_1.tabpage_2.dw_des_aggiuntiva.visible=true then

	ll_num_riga=idw_riga.getitemnumber(al_riga, "riga_documento_num_riga")
	if ll_num_riga>0 then
		ll_riga_trovata=tab_1.tabpage_2.dw_des_aggiuntiva.find("num_riga="+string(ll_num_riga), 1 , &
		tab_1.tabpage_2.dw_des_aggiuntiva.rowcount())
		if ll_riga_trovata>0 then
			tab_1.tabpage_2.dw_des_aggiuntiva.deleterow(ll_riga_trovata)
		end if
	end if
end if
end subroutine

public subroutine wf_ins_righe_per_scar_metallo (long al_righe);integer i
string ls_metallo, ls_bz, ls_ot, ls_SI
long ll_id_articolo, ll_ins_riga, ll_test


for i = 1 to al_righe
	ll_id_articolo=idw_riga.getitemnumber(i, "riga_documento_id_articolo")
	if ll_id_articolo>0 then
		select m.codice
		into :ls_metallo
		from dba.orafo_metallo m, dba.orafo_titolo t, dba.articolo a
		where t.id_titolo=a.id_titolo
		and a.id_articolo=:ll_id_articolo
		and m.id_metallo=t.id_metallo
		;
		if ls_metallo='BZ' and ls_bz="" then
			ls_bz=ls_metallo
			ll_test=idw_riga.find("c_articolo_cod='BZ'", 1, idw_riga.rowcount())
			if ll_test<=0 then
				ll_ins_riga=idw_riga.trigger event ue_insert(0,0)
				ll_ins_riga=idw_riga.getrow()
				idw_riga.trigger event itemchanged(ll_ins_riga, idw_riga.object.c_articolo_cod, ls_metallo)
			end if
		elseif ls_metallo='OT' and ls_ot="" then
			ls_OT=ls_metallo
			ll_test=idw_riga.find("c_articolo_cod='OT'", 1, idw_riga.rowcount())
			if ll_test<=0 then
				ll_ins_riga=idw_riga.trigger event ue_insert(0,0)
				ll_ins_riga=idw_riga.getrow()
				idw_riga.trigger event itemchanged(ll_ins_riga, idw_riga.object.c_articolo_cod, ls_metallo)
			end if
		elseif ls_metallo='SI' and ls_SI="" then
			ls_SI=ls_metallo
			ll_test=idw_riga.find("c_articolo_cod='BD'", 1, idw_riga.rowcount())
			if ll_test<=0 then
				ll_ins_riga=idw_riga.trigger event ue_insert(0,0)
				ll_ins_riga=idw_riga.getrow()
				idw_riga.trigger event itemchanged(ll_ins_riga, idw_riga.object.c_articolo_cod, "BD")
			end if
		elseif ls_metallo='AG' and ls_SI="" then
			ls_SI=ls_metallo
			ll_test=idw_riga.find("c_articolo_cod='AG'", 1, idw_riga.rowcount())
			if ll_test<=0 then
				ll_ins_riga=idw_riga.trigger event ue_insert(0,0)
				ll_ins_riga=idw_riga.getrow()
				idw_riga.trigger event itemchanged(ll_ins_riga, idw_riga.object.c_articolo_cod, "A+")
			end if
		end if
	end if
next
end subroutine

public subroutine wf_rec_des_aggiuntiva (long al_riga, long al_id_articolo, string as_cod_articolo);string ls_tipo_registro, ls_nota_lavorazione, ls_des_3
integer li_num_registro, li_num_riga
long ll_id_variazione, ll_id_uc, ll_id_sog_com
date ldt_data_doc



if tab_1.tabpage_2.dw_des_aggiuntiva.visible=true then
	select tipo_registro, numero
	into :ls_tipo_registro, :li_num_registro
	from dba.registro
	where id_registro=:il_id_registro
	;
	if ls_tipo_registro='GV' and li_num_registro=2 then
		if al_id_articolo=0 then
			select id_articolo
			into :al_id_articolo
			from dba.articolo
			where codice=:as_cod_articolo
			;
		end if
		
		select note
		into :ls_nota_lavorazione
		from dba.articolo
		where id_articolo=:al_id_articolo
		;
		if isnull(ls_nota_lavorazione) then ls_nota_lavorazione=""
		ll_id_uc=idw_riga.getitemnumber(al_riga, "riga_documento_id_unita_confezione") 
		ll_id_sog_com=idw_gen.getitemnumber(1, "id_sog_commerciale") 
		ldt_data_doc=idw_gen.getitemdate(1, "data_documento") 
		
		select v.id_variazione
		into :ll_id_variazione
		from dba.sog_commerciale s, variazione v
		where id_sog_commerciale=:ll_id_sog_com
		and s.id_listino=v.id_listino
		and v.data_fine>= :ldt_data_doc
		and v.data_inizio<=:ldt_data_doc
		;
			
		Select des_3
		into :ls_des_3
		from dba.prezzo
		where id_unita_confezione=:ll_id_uc and id_variazione=:ll_id_variazione
		;
		
		li_num_riga=idw_riga.getitemnumber(al_riga, "riga_documento_num_riga")
		
		
		if ls_des_3> "  " then
			
			tab_1.tabpage_2.dw_des_aggiuntiva.setitem(li_num_riga, "des_aggiuntiva",ls_nota_lavorazione+" ~r~n"+ls_des_3) 
		else
			tab_1.tabpage_2.dw_des_aggiuntiva.setitem(li_num_riga, "des_aggiuntiva",ls_nota_lavorazione) 
		end if
	end if
end if
end subroutine

public subroutine wf_salva_prezzo_in_listino (long al_riga, decimal ad_prezzo, integer ai_flag, long ll_id_uc);string ls_um, ls_lis_base, ls_colonna_da_aggiornare, ls_tipo_arr, ls_test, ls_rag_soc_azienda //, ls_des
integer  li_riga_trovata, li_ret, LI_RIGHE_ATTUALI, li_cifre_arr, li_confermato
long  ll_id_var, ll_id_valuta_listino
decimal ld_parita_euro, ldc_coef_calo


if ai_flag=0 then
	//invece di mesagebox ingombrante, metto campo listino in rosso
	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.modify("riga_documento_id_listino.background.color=255")
//	if messagebox("Attenzione!", "Aggiornare prezzo in listino personale?", stopsign!, yesno!)<>1 then
//		return
//	end if
end if
	
//ll_id_var=idw_riga.getitemnumber(al_riga, "riga_documento_id_listino")
ll_id_var=idw_gen.getitemnumber(1, "documento_id_variazione")
if ll_id_var>0 then
	select id_valuta 
	into :ll_id_valuta_listino
	from listino l, variazione v
	where l.id_listino=v.id_listino
	and v.id_variazione=:ll_id_var;
	
	idw_riga.setitem(al_riga, "riga_documento_id_listino", ll_id_var)
	
end if

select parita_euro, cifra_arrotondamento, tipo_arrotondamento
into :ld_parita_euro, :li_cifre_arr, :ls_tipo_arr
from valuta
where id_valuta=:ll_id_valuta_listino;
if ld_parita_euro>0 then
//	ad_prezzo=f_round(ad_prezzo*idc_cambio/ld_parita_euro, li_cifre_arr, ls_tipo_arr)
	ad_prezzo=f_round(ad_prezzo/idc_cambio/ld_parita_euro, -6, ls_tipo_arr)
	
end if

ls_um=idw_riga.GetItemstring(al_riga, "tipo_um")
if ls_um='P' then 
	ls_colonna_da_aggiornare="prezzo_manifattura"
else
	ls_colonna_da_aggiornare="prezzo"
end if
//ll_id_uc=idw_riga.getitemnumber(al_riga, "riga_documento_id_unita_confezione")
LI_RIGHE_ATTUALI=tab_1.tabpage_7.dw_salva_prezzo_in_listino.rowcount()
li_riga_trovata=tab_1.tabpage_7.dw_salva_prezzo_in_listino.find("id_unita_confezione="+string(ll_id_uc)&
					+" and id_variazione="+string(ll_id_var), 1, LI_RIGHE_ATTUALI)
if isnull(li_riga_trovata) or li_riga_trovata <= 0 then
	li_ret=tab_1.tabpage_7.dw_salva_prezzo_in_listino.retrieve(ll_id_var, ll_id_uc)
	if li_ret>LI_RIGHE_ATTUALI then
		li_riga_trovata=li_ret		
	else
		li_riga_trovata=tab_1.tabpage_7.dw_salva_prezzo_in_listino.insertrow(0)
		tab_1.tabpage_7.dw_salva_prezzo_in_listino.setitem(li_riga_trovata, "id_variazione", ll_id_var)
		tab_1.tabpage_7.dw_salva_prezzo_in_listino.setitem(li_riga_trovata, "id_unita_confezione", ll_id_uc)
	end if
	//tab_1.tabpage_7.dw_salva_prezzo_in_listino.setitem(li_riga_trovata, ls_colonna_da_aggiornare, ad_prezzo)	

//else
	//tab_1.tabpage_7.dw_salva_prezzo_in_listino.setitem(li_riga_trovata, ls_colonna_da_aggiornare, ad_prezzo)
end if
select rag_soc_1 into :ls_rag_soc_azienda from dba.azienda;
//if pos(upper(ls_rag_soc_azienda), "PANNA")>0 then
//	ls_test=tab_1.tabpage_7.dw_salva_prezzo_in_listino.getitemstring(li_riga_trovata, "confermato")
//	if ls_test='C' then return
//end if
//aggiorno il prezzo
tab_1.tabpage_7.dw_salva_prezzo_in_listino.setitem(li_riga_trovata, ls_colonna_da_aggiornare, ad_prezzo)
//26-05-2022 Samy chiede per Ellisa che venga aggiornato anche il coef_calo... SOLO SE IL FLAG APPOSITO è ="S"
if tab_1.tabpage_2.cbx_agg_coef_calo.checked then
	ldc_coef_calo=idw_riga.getitemdecimal(al_riga, "coef_calo")
	tab_1.tabpage_7.dw_salva_prezzo_in_listino.setitem(li_riga_trovata, "coef_calo", ldc_coef_calo)
end if
//controllo se devo confermarlo nel listino in base alla riga doc
li_confermato=idw_riga.getitemnumber(al_riga, "provv_agente_2")
if int(li_confermato)=1 AND li_riga_trovata>0  then
	ls_test=tab_1.tabpage_7.dw_salva_prezzo_in_listino.getitemstring(li_riga_trovata, "confermato")
	if isnull(ls_test) or ls_test<>"C" then
		tab_1.tabpage_7.dw_salva_prezzo_in_listino.setitem(li_riga_trovata, "ultima_modifica", today())
	end if
	tab_1.tabpage_7.dw_salva_prezzo_in_listino.setitem(li_riga_trovata, "confermato", "C")
end if
//ls_des=
//tab_1.tabpage_7.dw_salva_prezzo_in_listino.setitem(li_riga_trovata, "des_1", ls_des)
//




end subroutine

public subroutine wf_controlla_profilo ();//funzione che controlla il profilo alla stampa del documento
//se l'intestatario è Karizia (id_sog_comm=43) e la destinazione è galvanica formelli (id_destinazione=306)
//allora va a vedere la prima riga e guarda se è argento o altro metallo
//1) se è <argento il profilo deve essere GRBOL
//2) se NON è argento il profilo deve essere GORBOL

long ll_id_prof, ll_id_GORBOL, ll_id_GRBOL, ll_id_met, ll_id_articolo,ll_id_galvanica, ll_id_riga_doc, ll_id_riga_bol
integer i
string ls_des
long ll_id_intestatario, ll_id_destinazione

ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
if ll_id_prof=159 or  ll_id_prof=160 then //  (kagalv e krgalv)
	if  ll_id_prof=159 then //in questo caso, ovvero se è kagalv, metto galvanica AF (28) e cambio la descrizione
		ll_id_galvanica=28
		ls_des="AF-Argentato Formelli"
	else
		ll_id_galvanica=27 //lo stesso di sopra ma con il rodio
		ls_des="RF-Rodiato Formelli"
	end if
	for i= 1 to idw_riga.rowcount()  //vado a ricercare la bollettina e cambio anche lì la descrizione
		ll_id_articolo=idw_riga.getitemnumber(i, "riga_documento_id_articolo")
		if ll_id_articolo<> 7128 and ll_id_articolo<>8942 then
			ls_des=""
			ls_des+="-"+idw_riga.getitemstring(i, "riga_documento_descrizione")
			ll_id_riga_doc=idw_riga.getitemnumber(i, "id_riga_documento")
			ll_id_riga_bol=0
			select id_bollettina
			into :ll_id_riga_bol
			from dba.produzione_2011
			where id_doc_produzione=:ll_id_riga_doc;
			if ll_id_riga_bol>0 then
//				update dba.riga_documento
//				set  descrizione=''
//				where id_documento=:ll_id_riga_bol
//				;
//				if sqlca.sqlnrows>0 then
//					commit;
//				else
//					rollback;
//					messagebox("Attenzione!", "Riga "+string(i)+": annullamento descrizione non riuscito!")
//				end if
				update dba.riga_documento
				set id_gruppo_agenti_2=:ll_id_galvanica, descrizione=:ls_des
				where id_documento=:ll_id_riga_bol
				and num_riga=1
				//and descrizione<>:ls_des
				//and charindex("Formelli", "descrizione")>0 
				;
				if sqlca.sqlnrows>0 then
					commit;
					//messagebox("Des salvata!", ls_des)
				else
					rollback;
					messagebox("Attenzione!", "Riga "+string(i)+": Valore Galvanica NON memorizzato nella bollettina d'origine!")
				end if
			else
				messagebox("Attenzione!", "Riga "+string(i)+":  bollettina NON trovata!")
			end if
		end if
	next
end if


ll_id_intestatario=idw_gen.getitemnumber(1, "id_sog_commerciale")
if ll_id_intestatario=43 then
	
	ll_id_destinazione=idw_gen.getitemnumber(1, "id_destinazione")
	if ll_id_destinazione=306 then
		select id_prof_documento
		into :ll_id_GRBOL
		from dba.prof_documento
		where codice='GRBOL'
		;
		if ll_id_GRBOL>0 then
			select id_prof_documento
			into :ll_id_GORBOL
			from dba.prof_documento
			where codice='GORBOL'
			;
			if ll_id_prof<> ll_id_GORBOL and ll_id_prof<> ll_id_GRBOL and is_tipo_documento='D' then
				messagebox("Attenzione!", "Il profilo è errato e sarà cambiato: controllare!")
				ll_id_articolo=idw_riga.getitemnumber(1, "riga_documento_id_articolo")
				select m.id_metallo
				into :ll_id_met
				from dba.orafo_metallo m, dba.orafo_titolo t, dba.articolo a
				where a.id_articolo=:ll_id_articolo
				and a.id_titolo=t.id_titolo
				and t.id_metallo=m.id_metallo
				;
				if ll_id_met=3 then //è argento
					idw_gen.setitem(1, "id_prof_documento",ll_id_GRBOL)
					idw_gen.setitem(1, "c_prof_doc_cod","GRBOL")
				else
					idw_gen.setitem(1, "id_prof_documento",ll_id_GORBOL)		
					idw_gen.setitem(1, "c_prof_doc_cod","GORBOL")
				end if
				idw_gen.trigger event ue_update(0,0)
				
			end if
		end if
	end if
end if

end subroutine

public subroutine wf_cod_barre_bollettine ();long ll_id_prof_doc, ll_id_valuta, ll_id_caus, ll_id_loc_1, ll_id_loc_2, ll_prima_riga_copiata 
long ll_id_art, ll_id_UC, ll_id_documento, LL_ID_RIGA, ll_null, ll_righe_retrieve, ll_id_doc_prod
long ll_righe_doc, ll_righe_prod, ll_riga_esiste, ll_riga_inserita, ll_righe, ll_id_titolo, ll_id_variazione, ll_id_art_padre
string ls_barcode, ls_tipo_lavorazione, ls_des_riga, ls_azienda, ls_simb_um, ls_cod_art
string ls_pi_azienda, ls_ins_righe_per_scar_metallo='SI', ls_des, ls_cod_metallo
integer a, i, li_ret, b, li_num_riga, li_ordine
decimal ldc_coef_calo, ldc_peso, ldc_qta, ldc_prezzo_galvanica, ldc_ordine, ldc_prezzo_componente
s_array s_bol
datastore ds_righe_bollettina, ds_prod_2011


//18-01-11 gestione ordini con codice a barre
	//rivisto completamente dal 15-30 marzo 2012

select rag_soc_1
into :ls_azienda
from dba.azienda
;
ls_azienda=upper(ls_azienda)

ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
select ins_barcode
into :ls_barcode
from dba.prof_documento
where id_prof_documento =:ll_id_prof_doc
;
IF ls_barcode='S' then
	ll_id_valuta=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1,"documento_id_valuta_des")
	ll_id_caus=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1,"documento_id_caus_magazzino")
	ll_id_loc_1=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "documento_id_locazione_1")
	ll_id_loc_2=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "documento_id_locazione_2")
	ds_righe_bollettina=create datastore
	ds_righe_bollettina.dataobject="d_orafo_riga_documento_ordine_filtro_gd"
	ds_righe_bollettina.settransobject(sqlca)
	//per caricare eventualmente la riga con la lavorazione interessata
	select step_produzione
	into :ls_tipo_lavorazione
	from dba.caus_magazzino
	where id_caus_magazzino=:ll_id_caus
	;
	choose case ls_tipo_lavorazione
		case "S"
			ls_tipo_lavorazione="SA" //Saldatura
		case "M"
			ls_tipo_lavorazione="SP" //spazzolatura
		case "A"
			ls_tipo_lavorazione="AR" //argentatura
		case "E"
			ls_tipo_lavorazione="EC" //ecoat
			//se è altro resta com'è
	end choose
	
	openwithparm(w_lega_doc_a_bollettina_pop, il_id_documento, this )  
	
	s_bol=message.powerobjectparm
	if isvalid(s_bol) then	
	//controllo se cè la riga iniziale vuota proposta in automatico 
		li_ordine=idw_riga.rowcount()
		if li_ordine=1 then
			li_ordine=0
			//se è una riga vuota di articolo e descrizione la cancello
			ll_id_art=idw_riga.getitemnumber(1, "riga_documento_id_articolo")
			ls_des_riga=idw_riga.getitemstring(1, "riga_documento_descrizione")
			ldc_peso=idw_riga.getitemdecimal(1, "riga_documento_peso_netto")
			// 30-07-2017inserisco anche la condizione ll_id_art=8942 ("A+") se è quello è la riga inserita in automatico per i fornitori: tolgo ...
			if isnull(ll_id_art) and (isnull(ls_des_riga) or ls_des_riga< " ") or ll_id_art=8942  then
				idw_riga.deleterow(1)
			end if
		elseif  li_ordine>1 then
			ll_id_art=idw_riga.getitemnumber(li_ordine, "riga_documento_id_articolo")
			ldc_peso=idw_riga.getitemdecimal(li_ordine, "riga_documento_peso_netto")
			if (isnull(ldc_peso) or ldc_peso=0) and ll_id_art=8942  then //20210109
				idw_riga.deleterow(li_ordine)
				li_ordine --
			end if
		end if
		
		if upperbound(s_bol.ll_id_doc)>0 then
			ds_prod_2011=create datastore
			ds_prod_2011.dataobject="d_produzione_2011_ra_gd"
			ds_prod_2011.settransobject(sqlca)
		end if
		setnull(ll_null)
		
		for a=1 to upperbound(s_bol.ll_id_doc) //giro per ogni bollettina trovata
			if s_bol.ll_id_doc[a]>0 then
				if pos(ls_azienda, "PANNA")>0 or pos(ls_azienda, "SILVERG")>0 or pos(ls_azienda, "STELLE")>0 or pos(ls_azienda, "TITANS")>0 then //se è panna art e c.
					ls_ins_righe_per_scar_metallo='NO'
					ds_righe_bollettina.dataobject="d_orafo_riga_documento_ordine_munna_gd"
					ds_righe_bollettina.settransobject(sqlca)
					ll_righe_retrieve=ds_righe_bollettina.retrieve(s_bol.ll_id_doc[a])
				 //29-06-2017
					//non faccio nulla perché le vuole uguali al doc di provenienza
					//20200806 il coef calo DEVE essere sempre 925 se c'è bol
					ll_id_art=ds_righe_bollettina.getitemdecimal(1, "riga_documento_id_articolo")
					select t.id_titolo, m.codice
					into :ll_id_titolo, :ls_cod_metallo
					from dba.orafo_titolo t, articolo a, orafo_metallo m
					where t.id_titolo=a.id_titolo and m.id_metallo=t.id_metallo and a.id_articolo=:ll_id_art;
					if ll_id_titolo=4 then 
						ds_righe_bollettina.setitem(1, "riga_documento_coef_calo", 925)
					end if
					//20230117 Elena vuole il peso a 0
					if  pos(ls_azienda, "SILVERG")>0 or pos(ls_azienda, "STELLE")>0 then
						ds_righe_bollettina.setitem(1, "riga_documento_peso_lordo", 0) //peso_lordo=tara
						ds_righe_bollettina.setitem(1, "riga_documento_peso_netto", 0)
					end if
				else // per tutti gli ALTRI prendo le righe (dovrebbe essere sempre 1 riga sola, quindi ll_righe_retrieve=1, se è >1 è perché ci sono righe figlie esplose dalla distinta articolo
						//tuttavia questo nelle bol non è possible, quindi è senz'altro eredità di quando si passava anche altro... controllare e correggere se il caso
					ll_righe_retrieve=ds_righe_bollettina.retrieve(s_bol.ll_id_doc[a], ls_tipo_lavorazione)
				end if
				if ll_righe_retrieve<=0 then 
					messagebox("Attenzione!", "Riga: "+string(a)+" nessuna bollettina trovata!")
					ls_ins_righe_per_scar_metallo="NO"
					continue
				end if
				LL_ID_RIGA=ds_righe_bollettina.getitemnumber(1, "id_riga_documento")
				//ldc_qta=ds_righe_bollettina.getitemdecimal(1, "quantita")
				//150612: samy vuole che sul pronto la bollettina proponga la qta residua tolto il pronto già fatto
				ldc_qta=wf_calcola_qta_residua_bollettina(s_bol.ll_id_doc[a], 0)
				if isnull(ldc_qta) then ldc_qta=0
				
				//questo non lo capisco... era stabilito così? 
				//if isnull(ldc_qta) or ldc_qta=0 then ldc_qta=1
				//fine 150612
				if ls_tipo_lavorazione='X' then //è un "pronto" (tipo_lavorazione "X" = doc PRONTO)
					ds_righe_bollettina.setitem(1, "id_riga_doc_provenienza", ll_null)
					//150612 aggiungo su richiesta samy: 
					//1) il peso = 0,01 (perché tanto lo mette da bilancia e non metto "0" perché sennò gli ricalcola i pezzi;
					//2) tara= 0 tanto la mette lei nel pronto
					ds_righe_bollettina.setitem(1, "riga_documento_peso_lordo", 0) //peso_lordo=tara
					ds_righe_bollettina.setitem(1, "riga_documento_peso_netto", 0.01)
					//20221018 azzero anche il fno non si sa mai ...
					ds_righe_bollettina.setitem(1, "fino", 0)
					ds_righe_bollettina.setitem(1, "calo", 0)
					//metto la qta residua invece che quella totale della bollettina
					ds_righe_bollettina.setitem(1, "quantita", ldc_qta)
					//fine 150612	
				else
					ds_righe_bollettina.setitem(1, "riga_documento_provv_imp_subage_2", LL_ID_RIGA)
					//20231204 riportato da sotto: lo deve fare per tutti...
					//101012 azzero qualsiasi valore del peso perché non deve influire sul magazzino
					ds_righe_bollettina.setitem(1, "riga_documento_peso_lordo", 0) //peso_lordo=tara
					ds_righe_bollettina.setitem(1, "riga_documento_peso_netto", 0)
					//aggiunto 270313 perché riportava in spazzolatura valori del fino e del calo
					ds_righe_bollettina.setitem(1, "fino", 0)
					ds_righe_bollettina.setitem(1, "calo", 0)
					if pos(ls_azienda, "PANNA")>0 or  pos(ls_azienda, "SILVERG")>0 or pos(ls_azienda, "STELLE")>0 or pos(ls_azienda, "TITANS")>0 then //29-06-2017
						//non faccio nulla perché le vuole uguali al doc di provenienza
						//20200806 il coef calo DEVE essere sempre 925 se c'è bol
						ll_id_art=ds_righe_bollettina.getitemdecimal(1, "riga_documento_id_articolo")
						select t.id_titolo, m.codice
						into :ll_id_titolo, :ls_cod_metallo
						from dba.orafo_titolo t, articolo a, orafo_metallo m
						where t.id_titolo=a.id_titolo and m.id_metallo=t.id_metallo and a.id_articolo=:ll_id_art;
						if ll_id_titolo=4 then 
							ds_righe_bollettina.setitem(1, "riga_documento_coef_calo", 925)
						end if
					//else   //20231204 : elena dice che NON vuole il peso e la tara dalla bollettina su rbol
//						//101012 azzero qualsiasi valore del peso perché non deve influire sul magazzino
//						ds_righe_bollettina.setitem(1, "riga_documento_peso_lordo", 0) //peso_lordo=tara
//						ds_righe_bollettina.setitem(1, "riga_documento_peso_netto", 0)
//						//aggiunto 270313 perché riportava in spazzolatura valori del fino e del calo
//						ds_righe_bollettina.setitem(1, "fino", 0)
//						ds_righe_bollettina.setitem(1, "calo", 0)
					end if
				end if
				
				//fine 101012
				//20220623 recupero id_variazione attuale e lo sostituisco a quello della bollettina
				ll_id_variazione=idw_gen.getitemnumber(1, "documento_id_variazione")
				ds_righe_bollettina.setitem(1, "riga_documento_id_listino", ll_id_variazione )
				//fine 20220623
				//azzero evenbtuali qta evase nella riga di origine
				ds_righe_bollettina.setitem(1, "qta_evasa", 0)
				ds_righe_bollettina.setitem(1, "qta_evasa_un_base", 0)
				//se il prof è rientro sul peso metto quello recuperato dalla bilancia al momento dello sparo della bollettina
				if  pos(ls_azienda, "SILVER DRE")>0 then
					if (ll_id_prof_doc=159 or  ll_id_prof_doc=160) then
						ds_righe_bollettina.setitem(1, "riga_documento_peso_netto", s_bol.ldc_legato[a])
					end if
					if s_bol.as_string[a]="ADD" then ds_righe_bollettina.setitem(1, "riga_documento_dim_h", 99.99)
					//wf_gestione_coef_calo( //lo commento 20231205
//					if ll_id_prof_doc=132 or  ll_id_prof_doc=133  or  ll_id_prof_doc=130 and ll_id_titolo=4 then //VSALD o VSMER o SALD deve mettere coef calo=1000
//						//ds_righe_bollettina.setitem(1, "coef_calo", 1000) //20231205 coef calo=925 
//						ds_righe_bollettina.setitem(1, "coef_calo", 925)
// 					end if
				end if
				//questo non lo capisco più ... 20210109 è certamente NON bolettina ... mha...
				ll_id_art_padre=ds_righe_bollettina.getitemnumber(1, "riga_documento_id_articolo")
				for b=2 to ll_righe_retrieve //questa è la riga della lavorazione
					ds_righe_bollettina.setitem(b, "id_riga_doc_padre", LL_ID_RIGA)
					if ll_id_prof_doc=132 or  ll_id_prof_doc=133 then //VSALD o VSMER
							//in questo caso Elisa chiede che sia riportato il prezzo da distinta.... 20220605
							//20220623 il prezzo adesso NON deve essere recuperato dalla distinta, ma dal listino personale dell'intestatario
							ll_id_art=ds_righe_bollettina.getitemnumber(b, "riga_documento_id_articolo")
							//26-02-2022 devo recuperare anche il coef_calo...
							//ll_id_variazione=idw_gen.getitemnumber(1, "documento_id_variazione")  //recuperato più sopra
							ds_righe_bollettina.setitem(b, "riga_documento_id_listino", ll_id_variazione )
							select p.coef_calo, p.prezzo, a.id_titolo into :ldc_coef_calo, :ldc_prezzo_componente, :ll_id_titolo from dba.prezzo p, dba.unita_confezione u, articolo a where u.id_articolo=:ll_id_art
							and p.id_unita_confezione=u.id_unita_confezione and p.id_variazione=:ll_id_variazione and a.id_articolo=u.id_articolo and u.unita_base='S';
							if ll_id_titolo=4 then  //20231205 aggiunto per uniformare il coef calo dell'AG
								ldc_coef_calo=925
							end if
							if ldc_coef_calo> 0 then ds_righe_bollettina.setitem(b, "coef_calo", ldc_coef_calo )		
							if ldc_prezzo_componente> 0 then 
								ds_righe_bollettina.setitem(b, "prezzo_complessivo", ldc_prezzo_componente )
							else
								ldc_prezzo_componente=wf_rec_prezzo_distinta(ll_id_art, ll_id_art_padre)
								if ldc_prezzo_componente> 0 then ds_righe_bollettina.setitem(b, "prezzo_complessivo", ldc_prezzo_componente )
							end if												
					end if
				next
				//20210109 ho cambiato il modo di recuperare il numero di riga, dovrebbe funzionare meglio, spero... (vedi più sopra)
				//li_ordine=idw_riga.rowcount()
				ll_prima_riga_copiata=li_ordine+1
				//qui segna l'ordine di stampa: controllare se è ancora necessario e, nel caso , commentare 20210109
				for i=1 to ll_righe_retrieve
					ldc_ordine+=ds_righe_bollettina.getitemdecimal(i, "riga_documento_provv_subage_2")*100 + li_ordine/100
					ds_righe_bollettina.setitem(i, "riga_documento_provv_subage_2", ldc_ordine)
				next
				//copio la riga sulle righe doc
				li_ret=ds_righe_bollettina.rowscopy(1,ll_righe_retrieve , Primary!, idw_riga, ll_prima_riga_copiata, Primary!)
				//recupero id documento attuale per sostiruirlo nella riga copiata
				ll_id_doc_prod=idw_gen.getitemnumber(1, "id_documento")
				setnull(ll_null)
				ll_righe_doc=idw_riga.rowcount()
				if ll_righe_doc>0 then
					li_num_riga=idw_riga.getitemnumber(1, "c_max_num")
					if isnull(li_num_riga)  then li_num_riga=0
				else
					li_num_riga=0
				end if
				b=0
				//ora giro per per le righe doc e metto a posto ciò che è necessario 
				//NO! così inserisco la prima riga tante volte quante le righe - 1!!!! Devo mettere a posto una riga per volta (spero...) 202101090
				for i= ll_prima_riga_copiata to ll_prima_riga_copiata +ll_righe_retrieve - 1 // idw_riga.rowcount()
					b++
					idw_riga.SetItem(i, "id_locazione_1", ll_id_loc_1)
					idw_riga.SetItem(i, "id_locazione_2", ll_id_loc_2)
					idw_riga.SetItem(i,"riga_documento_num_riga",li_num_riga+b)
					idw_riga.SetItem(i,"riga_documento_id_valuta",ll_id_valuta)
					idw_riga.SetItem(i,"riga_documento_id_caus_magazzino",ll_id_caus)
					//idw_riga.SetItem(i,"id_tab_iva",122)		//sembra che a volte perda l'aliquota iva??? 27062017 lo metto???				
					idw_riga.setitem(i, "id_documento", ll_id_doc_prod)
					idw_riga.setitem(i, "id_riga_documento", ll_null)
					
					//se profilo=159 allora deve mettere "AF"28 sul campo galvanica ("id_gruppo_agenti_2"), se 160 invece mette  "RF"27
					//solo per Samy gestione rodiato e argentato
					if pos(upper(ls_azienda), "DREAMS")>0 then
						ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
						if ll_id_prof_doc=159 then  //kagalv argentato
							idw_riga.setitem(i, "id_gruppo_agenti_2", 28)
							ls_des=idw_riga.getitemstring(i, "riga_documento_descrizione")
							IF POS(ls_des, "AF-ARGENTATO")<= 0 THEN
								ls_des="AF-ARGENTATO - "+ls_des
								idw_riga.setitem(i, "riga_documento_descrizione", ls_des)
								select prezzo_gr
								into :ldc_prezzo_galvanica
								from dba.galvanica
								where lavorazione='AF'
								;
								if isnull(ldc_prezzo_galvanica) then ldc_prezzo_galvanica=0
								UPDATE dba.riga_documento
								set id_gruppo_agenti_2= 28, prezzo_metallo= :ldc_prezzo_galvanica
								where id_documento=:s_bol.ll_id_doc[a]
								;
								if sqlca.sqlnrows>0 then
									commit;
								else
									rollback;
									messagebox("Errore!", "Galvanica in bollettina derivata non salvata!")
								end if
							END IF
						elseif ll_id_prof_doc=160 then //krgalv rodiato
							idw_riga.setitem(i, "id_gruppo_agenti_2", 27)
							ls_des=idw_riga.getitemstring(i, "riga_documento_descrizione")
							IF POS(ls_des, "RF-RODIATO")<= 0 THEN
								ls_des="RF-RODIATO - "+ls_des
								idw_riga.setitem(i, "riga_documento_descrizione", ls_des)
								select prezzo_gr
								into :ldc_prezzo_galvanica
								from dba.galvanica
								where lavorazione='RF'
								;
								if isnull(ldc_prezzo_galvanica) then ldc_prezzo_galvanica=0
								UPDATE dba.riga_documento
								set id_gruppo_agenti_2= 27, prezzo_metallo= :ldc_prezzo_galvanica
								where id_documento=:s_bol.ll_id_doc[a]
								;
								if sqlca.sqlnrows>0 then
									commit;
								else
									rollback;
									messagebox("Errore!", "Galvanica in bollettina derivata non salvata!")
								end if
							END IF				
						end if
					end if
					//faccio scattare il ricalcolo dei prezzi
					tab_1.Tabpage_2.dw_riga_documento_ordine_gd.trigger event ue_rec_prezzo(i, ldc_qta)
					idw_riga.setitemstatus(i, 0, primary!, newmodified!)
					wf_calcola_prezzo(i) //per Munna 2019-05-06
					//20250327 aggiungo ricalco fino calo perché sono ritornati alcuni doc con fino calo errati...
					wf_setta_FINO_CALO( i )
				next
				
				if idw_riga.update()=1 then //salvo
					commit;
					if pos(ls_azienda, "SILVER DRE")>0  then //per panna-art e c NON salvo in "produzione_2011"
						//adesso lego la riga appena salvata alla bollettina (la prima riga è quella giusta)
						ls_cod_art=idw_riga.getitemstring(ll_prima_riga_copiata, "c_articolo_cod")
						if (ls_cod_art= "A" or  ls_cod_art= "A+")  then continue  //non c'è mai bollettina legata a questi articoli 20210219
						ll_righe_prod=ds_prod_2011.retrieve(s_bol.ll_id_doc[a])
						if ll_righe_prod>0 then
							ll_riga_esiste=ds_prod_2011.find("id_doc_produzione="+string(ll_id_riga), 1, ds_prod_2011.rowcount())
							//se esiste già non faccio nulla
							if ll_riga_esiste>0 then
								continue
							end if
						end if
					
						//la riga copiata in ogni giro si posiziona in prima posizione, è sempre  la riga numero 1 (+ le righe eventuialmente esistenti) 20210109
						ll_id_riga=idw_riga.getitemnumber(ll_prima_riga_copiata, "id_riga_documento")
						ll_riga_inserita=ds_prod_2011.insertrow(0)
						
						ds_prod_2011.setitem(ll_riga_inserita, "id_bollettina", s_bol.ll_id_doc[a])
						ds_prod_2011.setitem(ll_riga_inserita, "id_doc_produzione", ll_id_riga)
						//salvo
						if ds_prod_2011.update()=1 then
							commit;
							//quindi posso chiudere la bollettina e farla diventare uno scarico
							//"Quando si manda in galvanica o in qualsiasi altra lavorazione (smerigliatura, saldatura)
							//devi cambiare lettera a ordinato_fo e mettere “S” (suggerito da Samy)
							//per indicare che tale bollettina deve essere vista come scarico
							//e riporta il valore scaricato nella colonna scarichi della stampa “d_data_tot_doc_tb”."
							//150513
							//commento tutto perché dà problemi nel correggi bollettina (rimostra le bollettine sppuntate come se fosse ordinato_fo='S')
//							update dba.riga_documento
//							set ordinato_fo='G'  //vuol dire che è andato in galvanica o in smerigliatura o ...
//							where id_documento=:s_bol.ll_id_doc[a]
//							;
//							if sqlca.sqlNrows>0 then
//								commit;
//							else
//								rollback;
//								messagebox("Errore!", "Bollettina id="+string (s_bol.ll_id_doc[a])&
//											+"NON trasformata in scarico (ordinato_fo='G')")
//							end if
						else
							rollback;
							messagebox("Errore!", "Legame con bollettina non salvato!")
						end if
					end if
				else
					rollback;
					messagebox("Errore!", "Riga non salvata!")
				end if
			end if
		next	
		
		//salvo le righe documento
		idw_riga.trigger event ue_update(0,0)
		if ls_ins_righe_per_scar_metallo='SI' then
			ll_righe=idw_riga.rowcount()
			wf_ins_righe_per_scar_metallo(ll_righe)
		end if
	end if
end if
end subroutine

public subroutine wf_ka_kr_rec_galvanica (long al_riga, string as_cod_articolo, long al_prof_doc);//se il profilo è KAGALV o KRGALV
//e l'articolo inizia per "KA "  , "KC "  ecc...  allora devo prendere
//se KAGALV=idGALV=6 se KRGALV id galv=10
if left(as_cod_articolo, 1)="K" and not isnumber(mid(as_cod_articolo, 2, 1)) and mid(as_cod_articolo, 3, 1)= " " then
	if al_prof_doc=159 then
		idw_riga.setitem(al_riga, "id_gruppo_agenti_2", 6)
		wf_rec_galvanica("6", al_riga)
	elseif al_prof_doc=160 then
		idw_riga.setitem(al_riga, "id_gruppo_agenti_2", 10)
		wf_rec_galvanica("10", al_riga)		
	end if
end if

end subroutine

public subroutine wf_controlla_righe_stessa_riga_madre ();






end subroutine

public function integer uf_importa_righe (s_par_der_doc astr_par);integer i
decimal ldc_qta
long ll_id_prof, ll_id_iva_prop

w_orafo_documento_ordine_cx lw_doc
lw_doc=this
u_righe_doc l_uo_importa_righe
l_uo_importa_righe=create u_righe_doc

if (astr_par.s_deriva_veloce ="D") then
	l_uo_importa_righe.uf_importa_righe_veloce(astr_par, lw_doc)
else
	l_uo_importa_righe.uf_importa_righe(astr_par, lw_doc)
end if
destroy l_uo_importa_righe

		
wf_calcola_spese("N")


//char lc_tipo_ges_lotti
//
//SELECT tipo_ges_lotti
//INTO	 :lc_tipo_ges_lotti
//FROM	 pers_par_sistema
//;
//
//if not (lc_tipo_ges_lotti = 'G' and tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject = 'd_riga_documento_ordine_lotti_gd') then
//	cb_salva.post event clicked()
//end if

//lancio per ogni riga l'itemchanged sulla quantita
//così se è il caso esplode le righe nei componenti (SILVERDREAMS 11-06-10)
//20260220 per labella recupero l'Iva del profilo e la metto nelle righe
ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento") 
select id_tab_iva_prop into :ll_id_iva_prop from dba.prof_documento where id_prof_documento=:ll_id_prof;

for i= 1 to idw_riga.rowcount()
	ldc_qta=idw_riga.getitemdecimal(i, "quantita")
	wf_prepara_esplodi(i, string(ldc_qta))
	if ll_id_iva_prop>0 then  //20260220 aggiunto per labella in base al valore messo in id_tab_iva_prop campo di prof_documento
		idw_riga.setitem(i, "riga_documento_id_tab_iva", ll_id_iva_prop)
	end if
//	ls_id_galv=string(idw_riga.getitemnumber(i, "id_gruppo_agenti_2"))
//	wf_rec_galvanica(ls_id_galv, i)
next

//lancio il ricalcolo deigli importi di riga
tab_1.tabpage_2.cb_ricalcola.trigger event clicked()

wf_clicca_cb_partite()
//27042017 AGGIUNGO SALVATAGGIO AUTOMATICO DELLA DERIVAZIONE
//tab_1.tabpage_2.dw_riga_documento_ordine_gd.triggerevent("ue_update")
ib_askforsave=FALSE	
TriggerEvent("ue_update")
idw_riga.trigger event ue_update(0,0)

return 0
end function

public subroutine wf_ricopia_iva_su_tutte_righe (long al_id_tab_iva, long al_prima_riga);long i

if al_id_tab_iva>0 then
	for i=al_prima_riga to idw_riga.rowcount()
			idw_riga.setitem(i, "riga_documento_id_tab_iva", al_id_tab_iva)		
	next
end if
	
end subroutine

public subroutine wf_ricopia_listino_tutte_righe (long al_id_variazione, integer al_prima_riga);long i

if al_id_variazione>0 then
	for i=al_prima_riga to idw_riga.rowcount()
			idw_riga.setitem(i, "riga_documento_id_listino", al_id_variazione)		
	next
end if
	
end subroutine

public subroutine wf_crea_sald_da_bol_accessori ();integer i, li_ret
long ll_id_doc, ll_riga, ll_id_bol[], ll_id_new_riga, ll_id_riga_bol, ll_null, ll_ins_riga, ll_id_variazione
dwitemstatus ldw_status
setnull(ll_null)
datastore ds_copia
ds_copia=create datastore
ds_copia.dataobject="d_orafo_riga_documento_ordine_silver_gd"
ds_copia.settransobject(sqlca)
//

idw_gen.setitem(1, "id_prof_documento", 130) // è il SALD
idw_gen.triggerevent ("ue_set_prof_fields")
idw_gen.setitem(1, "id_sog_commerciale", idw_master.is_list.l_id_riga[2])
idw_gen.triggerevent ("ue_set_sog_fields")
ib_askforsave=FALSE	
li_ret=idw_gen.trigger event ue_update(0,0)
//idw_riga.reset()
for i= 3 to upperbound( idw_master.is_list.l_id_riga)  //nelle dispari c'è l'id_doc
	//ll_riga=idw_riga.retrieve( idw_master.is_list.l_id_riga[i])
	//nelle bollettine silver c'è una (1) sola riga, quindi con il retrieve per id_doc tiro su quella e basta 2020-10-25
	ll_riga=ds_copia.retrieve( idw_master.is_list.l_id_riga[i])
	//quindi la copio sulla riga attuale
	li_ret=ds_copia.rowscopy(1, 1, primary!, idw_riga, 1, primary!)
	//ds_copia.reset()
next

ll_id_doc=idw_gen.getitemnumber(1, "id_documento")
if ll_id_doc>0 then
	ll_id_variazione=idw_gen.getitemnumber(1, "documento_id_variazione")
	 
	for i=1 to idw_riga.rowcount()
		
		ll_id_bol[i]=idw_riga.getitemnumber(i, "id_documento")
		ll_id_riga_bol=0
		//recupero id_riga della bollettina padre di questa riga
		ll_id_riga_bol=idw_riga.getitemnumber(i, "id_riga_documento")
		//poi annullo il campo per predisporre salvataggio della nuova riga "sald"
		li_ret=idw_riga.setitem(i, "id_riga_documento", ll_null)
		idw_riga.setitem(i, "id_documento", ll_id_doc) //canbio id doc, causale e magazzino
		idw_riga.setitem(i, "id_locazione_1", 1)
		idw_riga.setitem(i, "riga_documento_id_caus_magazzino", 55)
		//20220614 aggiusto la variazione prezzo sennò prende quella della karizia
		idw_riga.setitem(i, "riga_documento_id_listino", ll_id_variazione)  ////finire!!!!!!!!!!!!!!!!!!!!!!!!!!!
		//20220614 fine
		idw_riga.setitem(i, "riga_documento_num_riga", i)
		//inserisco il legame con la bollettina 
		idw_riga.setitem(i, "riga_documento_provv_imp_subage_2", ll_id_riga_bol)
		idw_riga.setitem(i, "riga_documento_provv_imp_carea_2", ll_id_riga_bol)
		//azzero eventuali qta_evase
		idw_riga.setitem(i, "qta_evasa", 0)
		idw_riga.setitem(i, "qta_evasa_un_base", 0)
		idw_riga.setitem(i, "peso_netto_evaso", 0)
		
//		ldw_status=idw_riga.getitemstatus(i, 0, primary!)
//		idw_riga.setitemstatus(i, 0, primary!, newmodified!)
	next
	//lego il tutto al doc bollettina padre
	//prima salvo per avere il nuovo id_riga_doc del sald
	idw_master.triggerevent("ue_update")
	for i=1 to  idw_riga.rowcount()
		ll_id_new_riga=idw_riga.getitemnumber(i, "id_riga_documento")
		insert into dba.produzione_2011 (id_bollettina, id_doc_produzione)
		values (:ll_id_bol[i], :ll_id_new_riga);
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Bol non legata a riga")
		end if
	next
	//aggiiungo una riga er il peso (a+)
	ll_ins_riga=idw_riga.trigger event ue_insert(0,0)
	ll_ins_riga=idw_riga.getrow()
	idw_riga.trigger event itemchanged(ll_ins_riga, idw_riga.object.c_articolo_cod, "A+")
END IF
destroy ds_copia
//		

end subroutine

public subroutine wf_incartato_imbustato (long al_row);decimal ldc_tara
string ls_des,ls_des_2, ls_parte_destra
long ll_id_variazione, ll_id_uc
integer li_pos

if tab_1.tabpage_2.cbx_INCARTATO.checked then

	ldc_tara=idw_riga.getitemdecimal(al_row, "riga_documento_peso_lordo")
	ls_des=idw_riga.getitemstring(al_row, "riga_documento_descrizione")
	ll_id_variazione=idw_riga.getitemnumber(al_row, "riga_documento_id_listino")
	ll_id_uc=idw_riga.getitemnumber(al_row, "riga_documento_id_unita_confezione")
	
	//Samy chiede di aggiungere "Incartato/Imbustato" se la tara>0 e nella des2 NON 'c'è "Ki"  20200826
	if ldc_tara>0 then
		//if pos(ls_des, "-Incartato/imbustato-")<=0 then //se non c'è lo aggiungo se c'è non faccio nulla
			select des_2 into :	ls_des_2 from dba.prezzo
			where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;	
			ls_des_2=upper(ls_des_2)
			if isnull(ls_des_2) then ls_des_2=" "
			if ls_des_2> " " then
				if pos(ls_des_2, "KI")<=0 then
					if isnull(ls_des) then ls_des=" "
					if pos(ls_des, "-Incartato/imbustato-")<=0 then //se non c'è lo aggiungo se c'è non faccio nulla
						ls_des+= "-Incartato/imbustato-"
						idw_riga.setitem(al_row, "riga_documento_descrizione", ls_des)
					end if
				else  //unificare con quello più sotto
					li_pos= pos(ls_des, "-Incartato/imbustato-")
					if li_pos>0 then
						if len(ls_des)> li_pos+21 then ls_parte_destra=mid(ls_des, li_pos+21, len(ls_des))
						if isnull(ls_parte_destra) then ls_parte_destra=""
						ls_des=left(ls_des, li_pos - 1)+ls_parte_destra
						idw_riga.setitem(al_row, "riga_documento_descrizione", ls_des)
					end if
				end if
			end if
	//	else  //
	//		
	//	end if
	else //se è =0 o nulla devo controllare se c'è "-Incartato/imbustato-" e toglilerlo
		li_pos= pos(ls_des, "-Incartato/imbustato-")
		if li_pos>0 then
			if len(ls_des)> li_pos+21 then ls_parte_destra=mid(ls_des, li_pos+21, len(ls_des))
			if isnull(ls_parte_destra) then ls_parte_destra=""
			ls_des=left(ls_des, li_pos - 1)+ls_parte_destra
			idw_riga.setitem(al_row, "riga_documento_descrizione", ls_des)
		end if
	end if
end if
end subroutine

public subroutine wf_salva_riga_e_partita ();
end subroutine

public subroutine wf_salva_riga_partita ();//05-01-2021 proviamo per vedere se smette di perdere a non cancellare scarichi
//u_dw_main ldw

//ldw=idw_riga
ib_askforsave=false
idw_riga.trigger event ue_key( KeyS!, 2)
		
//cb_salva.triggerEvent(clicked!)
ib_askforsave=true
end subroutine

public subroutine wf_sinc_des_agg (long al_riga);//
long ll_id_riga, ll_righe
if tab_1.tabpage_2.dw_des_aggiuntiva.visible then
	idw_riga.accepttext()
	ll_id_riga=idw_riga.getitemnumber(al_riga, "id_riga_documento")
	if ll_id_riga>0 then
		ll_righe=tab_1.tabpage_2.dw_des_aggiuntiva.retrieve(ll_id_riga)
		if ll_righe<=0 then
			tab_1.tabpage_2.dw_des_aggiuntiva.insertrow(1)
			tab_1.tabpage_2.dw_des_aggiuntiva.setitem(1, "id_riga_documento", ll_id_riga)
		end if
	end if
end if
end subroutine

public subroutine wf_aumenta_prezzo (decimal adc_percentuale_aumento);integer i
decimal ldc_prezzo, ldc_test

ldc_test=idw_gen.getitemdecimal(1, "imp_avanzo_acconto")
if ldc_test<85 or isnull(ldc_test) then
	for i=1 to idw_riga.rowcount()
		ldc_prezzo=idw_riga.getitemdecimal(i, "prezzo_complessivo")
		if ldc_prezzo>0 then 
			ldc_prezzo+=ldc_prezzo*adc_percentuale_aumento/100
			idw_riga.setitem(i, "prezzo_complessivo", ldc_prezzo)
		else
			ldc_prezzo=idw_riga.getitemdecimal(i, "prezzo_manifattura")
			ldc_prezzo+=ldc_prezzo*adc_percentuale_aumento/100
			idw_riga.setitem(i, "prezzo_manifattura", ldc_prezzo)
		end if
	next
	idw_gen.setitem(1, "imp_avanzo_acconto", 100+adc_percentuale_aumento)
else
	choose case adc_percentuale_aumento
		case 10 
			rb_10.checked=false
		case -10
			rb_meno_10.checked=false
		case  15
			rb_15.checked=false
		case -15
			rb_meno_15.checked=false
	end choose 
	ldc_test=idw_gen.getitemdecimal(1, "imp_avanzo_acconto")
	if ldc_test=110 then rb_10.checked=true
	if ldc_test=115 then rb_15.checked=true
	if ldc_test=90 then rb_meno_10.checked=true
	if ldc_test=85 then rb_meno_15.checked=true
end if
end subroutine

public function integer uf_wizard_riga ();long ll_id_registro, ll_id_prof_doc
integer li_num_registro, li_retvalue
string ls_tipo_registro, ls_cod_azienda

ll_id_registro=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_registro")
select tipo_registro, numero, a.codice
into :ls_tipo_registro, :li_num_registro, :ls_cod_azienda
from dba.registro, dba.azienda a
where id_registro=:ll_id_registro
;
ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
if (ls_tipo_registro='GV' and li_num_registro=2) or ((ll_id_prof_doc=107 or ll_id_prof_doc=108  &
		or ll_id_prof_doc=110 or ll_id_prof_doc=116 or ll_id_prof_doc=117  or ll_id_prof_doc=125 &
		or ll_id_prof_doc=133 ) and ls_cod_azienda = "LABELLA") then
		tab_1.tabpage_2.dw_des_aggiuntiva.visible=true
	else
		tab_1.tabpage_2.dw_des_aggiuntiva.visible=false
	end if
 

if (idw_master.uf_to_update() > 0) AND (idw_master.GetItemStatus(il_row,0,Primary!) = NewModified!)then	
	
	ib_askforsave=FALSE
	li_retvalue=idw_master.Event ue_update(0,0)
	if li_retvalue>0 and li_retvalue<> 5 then 
	
		MessageBox("Wizard del Documento","Impossibile salvare il documento,~n tale azione è indispensabile per creare una nuova riga.",Exclamation!)
		iuo_msg_log.uf_new_text("Wizard del Documento",3)
		iuo_msg_log.uf_new_text("Impossibile salvare il documento,~n tale azione è indispensabile per creare una nuova riga.",4)
		RETURN 0
	else
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_wiz_insert()
	end if
end if

RETURN 0
end function

public subroutine wf_cartellino (long al_riga);datawindowchild dwc_cartellino
integer li_ret
string ls_cod_art, ls_azienda
long ll_riga_trovata,ll_id_cat_merc

select rag_soc_1 into :ls_azienda from dba.azienda;
if pos(upper(ls_azienda), "BUCCI" )>0 then


	li_ret=idw_riga.getchild("cartellino", dwc_cartellino)
	CONNECT USING SQLCA;
	// Set the transaction object for the 
	dwc_cartellino.SetTransObject(SQLCA)  
	// Populate with values for eastern 
	ls_cod_art=idw_riga.getitemstring(al_riga, "c_articolo_cod")
	dwc_cartellino.Retrieve()
	ll_riga_trovata=dwc_cartellino.find("articolo_codice= '"+ls_cod_art+"'", 1, 1000000)
	if ll_riga_trovata>0 then
		ll_id_cat_merc=dwc_cartellino.getitemnumber(ll_riga_trovata, "id_cat_merceologica")
		idw_riga.setitem(al_riga, "cartellino",ll_id_cat_merc)
	end if
end if
//dwc_cartellino.setfilter("articolo_codice= '"+ls_cod_art+"'")
//li_ret=dwc_cartellino.filter()
end subroutine

public subroutine wf_stampa_brogliaccio (integer ai_ordinamento);integer li_y, i, li_num_riga
string ls_codice_azienda, ls_num_doc, ls_des2, ls_doc_controllato
datastore ds_silver
//datawindowchild dwc_galvanica
decimal ldc_imponibile, ldc_imposta, ldc_totale , ldc_tara,ldc_prezzo_attuale, ldc_test
long ll_id_uc,ll_num_prog, ll_id_art,ll_test, ll_id_sog
date ldt_data_doc, ldt_2_mesi_prima, ldt_modifica_listino, ldt_data_fine,ldt_primo_gmese


if printsetup()= 1  then
	select rag_soc_1
	into :ls_codice_azienda
	from azienda
	;
	if pos(upper(ls_codice_azienda),'SILVER')>0 or pos( upper(ls_codice_azienda),'PANNA')>0   then
			tab_1.tabpage_2.dw_6.setredraw(false)
		//ds_silver=create datastore
		if ai_ordinamento=4 or ai_ordinamento=8  or ai_ordinamento=5 then //20241106 inserisco  nuova stampa con peso medio e des_2 (4 e 8)
			tab_1.tabpage_2.dw_6.dataobject="d_orafo_riga_documento_silver_stampa"
		else
			tab_1.tabpage_2.dw_6.dataobject="d_orafo_riga_documento_silver_stampa20241106"
		end if
		tab_1.tabpage_2.dw_6.settransobject(sqlca)
		idw_riga.rowscopy(1,idw_riga.RowCount(), Primary!, tab_1.tabpage_2.dw_6, 1, Primary!)
		if ai_ordinamento=1 or ai_ordinamento=4 or  ai_ordinamento=5 then
			tab_1.tabpage_2.dw_6.setsort("riga_documento_id_articolo")
			tab_1.tabpage_2.dw_6.sort()
		elseif ai_ordinamento=0 or ai_ordinamento=8 then //20241106 inserisco  nuova stampa con peso medio e des_2 (4 e 8)
			tab_1.tabpage_2.dw_6.sort()
		end if
		
		ldt_data_doc=idw_gen.getitemdate(1, "data_documento")
		ldt_2_mesi_prima=date(string(year(ldt_data_doc))+"/"+string(month(ldt_data_doc))+"/01" )
		//ldt_2_mesi_prima=relativedate(ldt_2_mesi_prima, -60) //NO! Deve essere al primo del mese, come prima 20230406 
		for i=1 to tab_1.tabpage_2.dw_6.rowcount()
			
			ldc_tara=tab_1.tabpage_2.dw_6.getitemdecimal(i, "riga_documento_peso_lordo")
			if isnull(ldc_tara) or ldc_tara=0 then
				ll_id_uc=tab_1.tabpage_2.dw_6.getitemdecimal(i, "riga_documento_ID_unita_CONFEZIONE")
				select des_2 into :ls_des2 from dba.prezzo
				where id_unita_confezione=:ll_id_uc and id_variazione=15
				;
				if pos(upper(ls_des2), "KI4")>0 then //se KI4 in des_2 allora è rosso il background campo articolo è rosso
					tab_1.tabpage_2.dw_6.setitem(i, "id_locazione_2", 100)
				end if
			end if
			// (richiesta samy 05/12/2021)  rifatto il 20220707 controllo nelle fatture dei 4 mesi precedenti (122gg) se il prezzo è rimasto sempre uguale a quello del listino
			// o se è stato variato se è fisso da 4 mesi lo segno nel brogliaccio (dim_p=1) barrato, altrimenti lo sottolineo (dim_p=2)
			//se però il prezzo è stato modificato in una fattura che ha "prezzi_controllati" flaggato (=S) allora quella variazione lì
			//NON la devo considerare
			ll_id_uc=0
			ldc_prezzo_attuale=0
			ll_id_uc=tab_1.tabpage_2.dw_6.getitemnumber(i, "riga_documento_id_unita_confezione")
			//20250409 se l'articolo è presente in una fattura precedente con data stesso mese allora segno la riga in qualche modo
			if ll_id_uc>0 then
				ll_test=0
				ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
				ldt_primo_gmese=date("01/"+string(month(ldt_data_doc))+"/"+string(year(ldt_data_doc)))
				select first(id_riga_documento) into :ll_test from dba.riga_documento r, dba.documento d , dba.registro reg
				where d.id_documento=r.id_documento and r.id_unita_confezione=:ll_id_uc and reg.id_registro=d.id_registro
				and d.id_sog_commerciale=:ll_id_sog 
				and reg.tipo_registro='IV' and d.data_documento < :ldt_data_doc and d.data_documento>= :ldt_primo_gmese;
				if ll_test> 0 then
					tab_1.tabpage_2.dw_6.setitem(i, "cmc", 1)  //se cmc=1 il colore del campo id_articolo sara giallo (background)
				end if
				
			end if
			//fine 20250409
			ldc_prezzo_attuale=tab_1.tabpage_2.dw_6.getitemdecimal(i, "prezzo_complessivo")
			if ldc_prezzo_attuale>0 and ll_id_uc>0  then
				ll_num_prog=0
				//20230315 commento e poi si guarda se va bene: Samy chiede (ANNA) che il grassetto si riferisca alla data_ultima del llistino non ai documenti
//				select d.num_progressivo, r.num_riga, prezzo_complessivo, d.creato_in_esenzione 
//				into   :ll_num_prog, :li_num_riga, :ldc_test, :ls_doc_controllato //creato in esenzione=prezzi controllati
//				from riga_documento r, documento d , registro reg, prezzo p
//				where d.id_documento=r.id_documento and d.id_registro=reg.id_registro and reg.tipo_registro='IV' and 
//				r.id_unita_confezione=p.id_unita_confezione and p.id_variazione=15
//					and d.data_documento<=:ldt_data_doc and d.data_documento>= :ldt_2_mesi_prima and r.id_unita_confezione=:ll_id_uc
//					and d.creato_in_esenzione<>'S' and (r.prezzo_complessivo<>p.prezzo or  p.ultima_modifica>=:ldt_2_mesi_prima ) 
//					;
				//20230315 fine
				//20230315 sostituisco con richiesta
				ldc_test=0
				ldt_data_fine=relativedate(ldt_data_doc, 15)
				select prezzo  into :ldc_test from dba.prezzo p where p.id_unita_confezione= :ll_id_uc and p.id_variazione=15 and p.ultima_modifica>=:ldt_2_mesi_prima and p.ultima_modifica<=:ldt_data_fine ;
				ll_id_art=tab_1.tabpage_2.dw_6.getitemnumber(i, "riga_documento_id_articolo")
				if ldc_test>0 then
					ll_num_prog=2
					ls_doc_controllato='N'
				end if
				//20230315 sostituisco con richiesta fine
				
				
					 //20220801 se l'ultima modifica del prezzo è all'interno degli utlimi 4 mesi NON si barra!!! (anna lo deve controllare) (SAMY E ANNA)
//				where d.id_documento=r.id_documento and d.id_registro=reg.id_registro and reg.tipo_registro='IV' and 
//				r.id_unita_confezione=p.id_unita_confezione and p.id_variazione=15
//					and d.data_documento<=:ldt_data_doc and d.data_documento>= :ldt_2_mesi_prima and r.id_unita_confezione=:ll_id_uc
//					and r.prezzo_complessivo<>p.prezzo and d.creato_in_esenzione<>'S'
//					;
					
				if ll_num_prog>0 and (isnull(ls_doc_controllato) or ls_doc_controllato="N") then
					tab_1.tabpage_2.dw_6.setitem(i, "riga_documento_dim_p", 2)  // 2= sottolineato  se trovo il doc e NON è una fat. controllata metto grassetto: prezzo da controllare!!!
				else
					tab_1.tabpage_2.dw_6.setitem(i, "riga_documento_dim_p", 1)
				end if
				
			end if
			//fine 05/12/2021)
		next
				
		ls_num_doc="N. "+ idw_gen.getitemstring(1, "num_documento")
		ls_num_doc+= " del "+string(ldt_data_doc)
		//ls_num_doc= "t_num_doc.text= "+ls_num_doc
		tab_1.tabpage_2.dw_6.modify("t_num_doc.text='"+ls_num_doc+"'")
		//23-04-2016 aggiungo intestazione e totali documento
		tab_1.tabpage_2.dw_6.object.t_intestazione.text="Brogliaccio "+ls_num_doc
		ldc_imponibile=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imponibile_lire")
		ldc_imposta=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imposta_lire")
		ldc_totale=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_documento_lire")
		tab_1.tabpage_2.dw_6.object.t_imponibile.text=string(ldc_imponibile, "#,0.00")
		tab_1.tabpage_2.dw_6.object.t_imposta.text=string(ldc_imposta, "#,0.00")
		tab_1.tabpage_2.dw_6.object.t_totale.text=string(ldc_totale, "#,0.00")
		//fine 23-04-2016
		//ds_silver.print()
		tab_1.tabpage_2.dw_6.setredraw(true)
		if  ai_ordinamento=5 then
			f_doc_excel(tab_1.tabpage_2.dw_6)
		else
			tab_1.tabpage_2.dw_6.print()
		end if	
	else
		idw_riga.object.c_tot_righe.visible="0"
		idw_riga.object.linea.visible="0"
		idw_riga.object.c_tot_righe_t.visible="0"
		idw_riga.object.c_tot_righe_lire_t.visible="0"
		idw_riga.object.c_tot_righe_lire.visible="0"
			
		idw_riga.print()	
		idw_riga.object.c_tot_righe.visible="1"
		idw_riga.object.linea.visible="1"
		idw_riga.object.c_tot_righe_t.visible="1"
		idw_riga.object.c_tot_righe_lire_t.visible="1"
		idw_riga.object.c_tot_righe_lire.visible="1"
	
	end if
end if
end subroutine

public subroutine wf_rec_prezzi_silver (long al_id_prof, string as_cod_azienda, string as_tipo_reg, long al_id_sog);//deve partire il recupera prezzi per karizia ma anche per panna e anche sui SALD=130


if (pos(as_cod_azienda,"SILVERDR")>0  and as_tipo_reg="DV" and  (al_id_sog=43 or al_id_sog=1862) ) or (pos(as_cod_azienda,"SILVERDR")>0  and al_id_prof=130)  then 
	tab_1.tabpage_2.cb_rec_prezzi.trigger event clicked()
	idw_riga.Event ue_update(0,0)
end if
end subroutine

public function long wf_copia_riga_bollettina (long al_id_bollettina);long ll_riga_inserita, ll_max_num_riga, ll_null, ll_id_riga, ll_id_caus_magazzino, ll_id_prof_doc, ll_id_variazione, ll_id_riga_bol
datastore ds_riga_bollettina
string ls_num_bol, ls_azienda

select rag_soc_1 into :ls_azienda from dba.azienda;
ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
ll_id_variazione=idw_gen.getitemnumber(1, "documento_id_variazione")
setnull(ll_null)
ds_riga_bollettina=create datastore
ds_riga_bollettina.dataobject="d_orafo_riga_documento_ordine_silver_gd"
ds_riga_bollettina.settransobject(sqlca)
ds_riga_bollettina.retrieve(al_id_bollettina)
ds_riga_bollettina.rowscopy(1,1, primary!, idw_riga,100000, primary!)
ll_riga_inserita=idw_riga.rowcount()
ll_max_num_riga=idw_riga.getitemnumber(1, "c_max_num")
idw_riga.setitem(ll_riga_inserita, "riga_documento_num_riga", ll_max_num_riga+1)
//20230524 salvo il riferimento alla bollettina per riverderlo in bol_ovunque ecc...
ll_id_riga_bol=idw_riga.getitemnumber(ll_riga_inserita, "id_riga_documento")
//idw_riga.setitem(ll_riga_inserita, "riga_documento_provv_imp_carea_2", ll_id_riga_bol)
idw_riga.setitem(ll_riga_inserita, "riga_documento_provv_imp_subage_2", ll_id_riga_bol)
//20230524 fine 
idw_riga.setitem(ll_riga_inserita, "id_riga_documento", ll_null)
idw_riga.setitem(ll_riga_inserita, "id_documento",il_id_documento)
ll_id_caus_magazzino=idw_gen.getitemnumber(1, "documento_id_caus_magazzino")
idw_riga.setitem(ll_riga_inserita, "riga_documento_id_caus_magazzino", ll_id_caus_magazzino)  //20240904 sembra che metta la causale del documento d'origine (BOL) la prendo dal prof_doc
idw_riga.setitem(ll_riga_inserita, "riga_documento_id_listino",ll_id_variazione)
//20221107 per problemi su derivazione rbol e fatture conseguenti
idw_riga.setitem(ll_riga_inserita, "qta_evasa",0)
idw_riga.setitem(ll_riga_inserita, "qta_evasa_un_base",0)
idw_riga.setitem(ll_riga_inserita, "fat_con_globale",1)
idw_riga.setitem(ll_riga_inserita, "riga_documento_fat_con_unita_base",1)
//20221107 fine

if  pos(ls_azienda, "SILVER DR")>0 then
	if ll_id_prof_doc=132 or  ll_id_prof_doc=133  or  ll_id_prof_doc=130 or  ll_id_prof_doc=184 then //VSALD o VSMER o SALD deve mettere coef calo=1000
		idw_riga.setitem(ll_riga_inserita, "coef_calo", 1000)
	end if
end if
destroy(ds_riga_bollettina)
if idw_riga.update()=1 then //salvo
	commit;
	ll_id_riga=idw_riga.getitemnumber(ll_riga_inserita, "id_riga_documento")
	//Lego la bollettina alla nuova riga produzione
	insert into dba.produzione_2011 (id_bollettina, id_doc_produzione)
	values (:al_id_bollettina, :ll_id_riga);
	if sqlca.sqlNrows>0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Riga NON legata alla sua bollettina!!!!")
	end if
end if




return ll_riga_inserita
end function

public function decimal wf_rec_prezzo_distinta (long al_id_art, long al_id_art_padre);decimal ldc_prezzo
select costo into :ldc_prezzo from dba.riga_distinta r, dba.distinta d where r.id_articolo=:al_id_art 
and d.id_distinta=r.id_distinta and d.id_articolo=:al_id_art_padre ;
if isnull(ldc_prezzo) then ldc_prezzo=0

return ldc_prezzo
end function

public function long wf_contr_peso_uni_galvanica (long al_id, long al_riga);string ls_galvanica, ls_rag_soc
decimal ldc_peso_unitario, ldc_peso_netto, ldc_pezzi
long ll_id_sog

ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
select rag_soc_1 into :ls_rag_soc from dba.azienda;
ls_rag_soc=upper(ls_rag_soc)
if pos(ls_rag_soc, "SILVER DR")>0 and ll_id_sog=43 then
	select lavorazione into :ls_galvanica from dba.galvanica where id_galvanica=:al_id;
	ldc_peso_unitario=idw_riga.getitemdecimal(al_riga, "peso_unita")
	if ls_galvanica='L' then
		if ldc_peso_unitario>5 and  ldc_peso_unitario<=5.1 then
			ldc_pezzi=idw_riga.getitemdecimal(al_riga, "quantita")
			ldc_peso_netto=ldc_pezzi*5
			idw_riga.setitem(al_riga, "riga_documento_peso_netto", ldc_peso_netto)  //20231108 mai attivato dovrebbe scattare sul peso
			return 52
		end if	
	end if
	if ls_galvanica='L1' and  ldc_peso_unitario>5.1 then
		return 42
	end if
end if
return 0
end function

public function integer wf_scarica_partite_automatico ();long ll_id_doc_da_scaricare, ll_id_partita_da_scaricare, ll_tipo_partita,ll_id_tit,ll_id_riga_doc, ll_id_sog, ll_id_doc_inserito
string ls_stato
decimal ldc_fino_partita, ldc_new_val_scarico, ldc_val_scarico,ldc_fino
integer li_ret, i

for i= 1 to idw_riga.rowcount()
	ll_tipo_partita=8
	//trovo la partita e il valore residuo
	select id_partita, val_apertura - ifnull(val_scarico, 0, val_scarico), val_scarico into :ll_id_partita_da_scaricare, :ldc_fino_partita, :ldc_val_scarico from dba.orafo_aper_partita 
	where id_documento=:ll_id_doc_da_scaricare and id_titolo=:ll_id_tit and id_tipo_partita=:ll_tipo_partita and stato='A';
	if isnull(ldc_val_scarico) then ldc_val_scarico=0
	if ldc_fino_partita - ldc_fino<= - 0.1 then
		
	//	li_ret=wf_apri_part_automatico(ll_id_riga_doc, ll_id_sog, ll_id_tit, ldc_fino,ll_id_doc_inserito)
		wf_salva_ds_partite()
		destroy us_dati_partita.s_dw_aper_partita
		destroy us_dati_partita.s_dw_scar_partita
		return 0
	else
		if ldc_fino_partita - ldc_fino=0 then ls_stato="C" else ls_stato="A"
		ldc_new_val_scarico=ldc_val_scarico+ldc_fino
		update dba.orafo_aper_partita set val_scarico= :ldc_new_val_scarico, stato=:ls_stato where id_partita=:ll_id_partita_da_scaricare;
		if sqlca.sqlNrows>0 then
			commit;
			insert into dba.orafo_scar_partita (id_partita, id_riga_documento, val_scarico)
			values (:ll_id_partita_da_scaricare, :ll_id_riga_doc, :ldc_fino);
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
next

return 0

end function

public function integer wf_apri_part_automatico (integer al_riga_che_scarica, integer al_id_sog, integer al_id_titolo, integer adc_fino_da_scaricare, integer al_id_doc_inserito);string ls_cod_partita
integer li_num_righe, li_ret, i
long ll_id_partita, ll_riga_trovata, ll_id_caus_mag
decimal{2} ld_val_scarico, ld_fino, pippo, ad_peso, ld_peso

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
		li_ret=wf_car_ds_automatico(al_id_sog)
		if li_ret=0 then return 10
	end if
	//carico dati utili per finestra partita	
	us_dati_partita.s_id_documento=al_id_doc_inserito
	us_dati_partita.s_ll_id_sog_com=al_id_sog
	us_dati_partita.s_ll_id_riga_partita=al_riga_che_scarica
	
	us_dati_partita.s_ld_quantita_legato=adc_fino_da_scaricare*1000/925
	us_dati_partita.s_ld_quantita_da_scaricare=adc_fino_da_scaricare
	
		
	
	us_dati_partita.s_scarica_ogni_titolo='N'
	
	OpenWithParm(w_orafo_partite_aperte_gd, us_dati_partita)
	us_dati_partita = Message.PowerObjectParm
	ad_peso=adc_fino_da_scaricare*1000/925
	
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

public function integer wf_car_ds_automatico (long al_id_sog);
long ll_id_sog, ll_id_doc, ll_riga_corrente, ll_id_prof
datetime ldt_data_ora
string ls_disattiva_partite, ls_ges_partite

//if (ls_disattiva_partite='N' or isnull(ls_disattiva_partite)) and ls_ges_partite='S' then
//fine modifica 10-02-14
//modifica del 06072015 prima dava errore se sicambiava ora doc prima di salvare il documento
 
	
		
//	ll_id_doc=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente, "ID_DOCUMENTO")
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

public subroutine wf_setta_fino_calo (long row);long ll_id_riga
datetime ldt_data_ora

//20261028 il calcolo e' in wf_calcola_fino_calo: la usa anche l'updatestart, dove non si deve fare commit
wf_calcola_fino_calo(row)

//20250422 dentro la funzione setta fino calo aggiungere quanto qui sotto
//		//20250422 occorre salvare sempre le modifche su riga_doc_estensione (data_ora)
ll_id_riga=idw_riga.getitemnumber(row, "id_riga_documento")
ldt_data_ora=datetime(today(), now())
insert into dba.riga_doc_estensione ("id_riga_documento", "data_ora_modifica")
values (:ll_id_riga, :ldt_data_ora)
;
if sqlca.sqlcode=0 then
	commit;
else
	update dba.riga_doc_estensione
	set data_ora_modifica=:ldt_data_ora
	where id_riga_documento=:ll_id_riga;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		Messagebox("Attenzione!", "Data di modifica NON salvata!")
	end if
end if
//20250422 fine


end subroutine

public subroutine wf_calcola_fino_calo (long row);decimal{2} ld_fino, ld_coef_calo, ld_peso_non_prezioso, ld_calo, ld_peso
long ll_id_titolo
integer li_ret

ld_peso=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row, "riga_documento_peso_netto")
ld_coef_calo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row, "coef_calo")
if ld_peso<=0 or isnull(ld_peso) then
	li_ret=tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row, "fino", 0)
	if li_ret<>1 then messagebox("Errore!", "Fino non settato")
	li_ret=tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row, "calo",0) 
	if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
else
	ll_id_titolo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(row, "id_titolo")
	ld_peso_non_prezioso=idw_riga.getitemdecimal(row, "peso_non_prezioso")
	if isnull(ld_peso_non_prezioso) then ld_peso_non_prezioso=0
	ld_peso=ld_peso - ld_peso_non_prezioso
	
	ld_fino=wf_converti_in_fino(ld_peso, ll_id_titolo)
	li_ret=tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row, "fino", ld_fino)
	if li_ret<>1 then messagebox("Errore!", "Fino non settato")
	
	if  isnull(ld_coef_calo) then ld_coef_calo=0 

	if ld_coef_calo>0 and not isnull(ld_coef_calo) then
			ld_calo=f_round(ld_peso*(ld_coef_calo)/1000, -2, 'M')
			ld_calo= f_round(ld_calo - ld_fino, -2, 'M')  
			li_ret=tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row, "calo",ld_calo) 
			if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
	elseif ld_coef_calo=0 then 
		li_ret=tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row, "calo",0)
		if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
	end if
end if

end subroutine

public subroutine wf_magg_per_quantita (long al_riga);long ll_id_prof_doc, ll_test, ll_id_sog, ll_id_art
string ls_eccezione_inizio_anno, ls_campo
decimal ldc_peso,ldc_variazione, ldc_prezzo

Select vrbol_no_maggiorazione into :ls_eccezione_inizio_anno from dba.orafo_par_sistema;
ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
ll_test=idw_riga.getitemnumber(al_riga, "valoriz_peso_non_prezioso")
if ll_test<>1 then
	if ( ll_id_prof_doc=116 and ls_eccezione_inizio_anno='S' or ll_id_prof_doc=158 or ll_id_prof_doc=54)  &
		or (ll_id_prof_doc=12 or  ll_id_prof_doc=64 or ll_id_prof_doc=47)  then			
			//ls_test=idw_riga.getitemstring(li_ret, "riga_documento_da_stampare")
			//20230127 se il profilo è VRBOL(116) elisa, all inizio dell anno, deriva roba già prezzata e non deve riprezzare nulla... corretto il 20210206 con parametro in parametri di sistema orafo
			//20231211 aggiunto fatlav (47) ai profili esclusi dalla maggiorazione NC o ND uguale non fa nulla (54 e 158)
			if ( ll_id_prof_doc=116 and ls_eccezione_inizio_anno='S' or ll_id_prof_doc=158 or ll_id_prof_doc=54) or ldc_peso=0 or isnull(ldc_peso) or (ll_id_prof_doc=12 or  ll_id_prof_doc=64 or ll_id_prof_doc=47)  then	
				//brutto ma ho fretta e non mi viene nulla di estetico...					//20231120 se è NC o ND NON deve fare nulla
			else 
				ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
				ll_id_art=idw_riga.getitemdecimal(al_riga, "riga_documento_id_articolo")
				ldc_peso=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemdecimal(al_riga,"riga_documento_peso_netto")
				ldc_variazione= f_applica_maggiorazione(ll_id_art, ll_id_sog, ldc_peso)
				if ldc_variazione>0 then
					ldc_prezzo=idw_riga.getitemdecimal(al_riga, "prezzo_manifattura")
					ls_campo="prezzo_manifattura"
					if isnull(ldc_prezzo) or ldc_prezzo=0 then
						ldc_prezzo=idw_riga.getitemdecimal(al_riga, "prezzo_complessivo")
						ls_campo="prezzo_complessivo"
					end if
					if ldc_prezzo>0 then
						//idw_riga.modify(ls_campo+".color=255") no colora tutti i campi di rosso ....invece solo quello toccato ...
						//250713 modifico: cambio il campo da_stampare con valoriz_peso_non_prezioso (vuol dire che c'è maggiorazione)
						idw_riga.setitem(al_riga, "valoriz_peso_non_prezioso", 1)
						//idw_riga.setitem(li_ret, "riga_documento_da_stampare", "S")
						idw_riga.setitem(al_riga, ls_campo, ldc_prezzo+(ldc_prezzo*ldc_variazione/100))
					end if	
					//bisogna ricalcolare il prezzo .... 070313 NO l'importo riga non il prezzo, altrimenti un sè fatto nulla....
					wf_calcola_prezzo(al_riga)
				end if
			end if
		end if
	end if
		//fine aggiunta 180213
end subroutine

public subroutine wf_salva_riga_doc_estensione (long al_row);long ll_id_riga, ll_riga_TROVATA
datetime ldt_data_ora
integer li_ret
string ls_data_ora,ls_data
datastore ds_estensione

	
ds_estensione=create datastore
ds_estensione.dataobject="d_riga_doc_estensione_ds"
ds_estensione.settransobject(sqlca)
ll_id_riga=idw_riga.getitemnumber(al_row, "id_riga_documento")
if ll_id_riga>0 then
	
	ll_riga_TROVATA=ds_estensione.retrieve(ll_id_riga)
	if ll_riga_TROVATA<=0  or isnull(ll_riga_TROVATA) then
		ll_riga_TROVATA=ds_estensione.insertrow(0)
		ds_estensione.setitem(ll_riga_TROVATA, "id_riga_documento",ll_id_riga)
	end if
	ldt_data_ora=datetime(date(today()), now())
	ds_estensione.setitem(ll_riga_TROVATA, "data_ora_modifica",ldt_data_ora)
	li_ret=ds_estensione.update()
	if li_ret=1 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Data_ora_modifica NON salvata!")
	end if
	
end if
destroy ds_estensione
//select id_riga_documento into :ll_id_riga
//from dba.riga_doc_estensione
//where id_riga_documento=:al_id_riga;
//ldt_data_ora=datetime(date(today()), now())
//ls_data=string(ldt_data_ora, "yyyy/mm/yy")
//ldt_data_ora=datetime(date(ls_data), now())
//if ll_id_riga>0 then
//	update  dba.riga_doc_estensione
//	set data_ora_modifica=:ldt_data_ora
//	where id_riga_documento=:al_id_riga;
//	if sqlca.sqlcode=0 then
//		commit;
//	else
//		rollback;
//		messagebox("Attenzione!", "Data_ora_mofica NON salvata!")
//	end if
//else
//	insert into dba.riga_doc_estensione (id_riga_documento, data_ora_modifica)
//	values( :al_id_riga, :ldt_data_ora);
//	if sqlca.sqlcode>0 then
//		commit;
//	else
//		rollback;
//		messagebox("Attenzione!", "Data_ora_mofica NON salvata!")
//	end if
//end if
end subroutine

on w_orafo_documento_ordine_cx.create
int iCurrent
call super::create
this.p_sigle_prezzi=create p_sigle_prezzi
this.pb_st_art_foto=create pb_st_art_foto
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_chiudi_ordine=create cb_chiudi_ordine
this.cbx_tara=create cbx_tara
this.cbx_1=create cbx_1
this.cb_verifica_prezzi=create cb_verifica_prezzi
this.rb_meno_10=create rb_meno_10
this.rb_10=create rb_10
this.rb_meno_15=create rb_meno_15
this.rb_15=create rb_15
this.cb_sconta=create cb_sconta
this.cb_7=create cb_7
this.dw_7=create dw_7
this.dw_8=create dw_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_sigle_prezzi
this.Control[iCurrent+2]=this.pb_st_art_foto
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.cb_chiudi_ordine
this.Control[iCurrent+6]=this.cbx_tara
this.Control[iCurrent+7]=this.cbx_1
this.Control[iCurrent+8]=this.cb_verifica_prezzi
this.Control[iCurrent+9]=this.rb_meno_10
this.Control[iCurrent+10]=this.rb_10
this.Control[iCurrent+11]=this.rb_meno_15
this.Control[iCurrent+12]=this.rb_15
this.Control[iCurrent+13]=this.cb_sconta
this.Control[iCurrent+14]=this.cb_7
this.Control[iCurrent+15]=this.dw_7
this.Control[iCurrent+16]=this.dw_8
end on

on w_orafo_documento_ordine_cx.destroy
call super::destroy
destroy(this.p_sigle_prezzi)
destroy(this.pb_st_art_foto)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_chiudi_ordine)
destroy(this.cbx_tara)
destroy(this.cbx_1)
destroy(this.cb_verifica_prezzi)
destroy(this.rb_meno_10)
destroy(this.rb_10)
destroy(this.rb_meno_15)
destroy(this.rb_15)
destroy(this.cb_sconta)
destroy(this.cb_7)
destroy(this.dw_7)
destroy(this.dw_8)
end on

event close;call super::close;
if isvalid(us_dati_partita.s_dw_aper_partita) then
	
	destroy us_dati_partita.s_dw_aper_partita
	destroy us_dati_partita.s_dw_scar_partita
end if
if isvalid(u_ordini) then destroy u_ordini
tab_1.tabpage_7.dw_salva_prezzo_in_listino.reset()

if isvalid(ids_ev_forzata) then
	destroy ids_ev_forzata
end if

//20231024 distruggo eventuale ds_excel
if isvalid(ds_excel) then 	destroy ds_excel
end event

event ue_post_open;call super::ue_post_open;
long ll_id_caus_magazzino, ll_riga_corrente, ll_riga, ll_id_utenti,ll_id_prof_doc,ll_id_registro
string ls_cod_tipo_partita,ls_tipo_registro,ls_cod_azienda

DataWindowChild dwc_wizard 
integer rtncode, li_num_registro


ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
if ll_riga_corrente>0 then	
	ll_id_caus_magazzino=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_caus_magazzino")
	if ll_id_caus_magazzino>0 then
		ls_cod_tipo_partita=wf_trova_cod_tipo_partita(ll_id_caus_magazzino)
		if mid(ls_cod_tipo_partita, 1, 1)='S' then
			wf_carica_datastore()
		end if
	end if
end if

select mod_caus_magazzino 
into :ls_cod_tipo_partita
from par_sistema;
if ls_cod_tipo_partita='S' then
	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.modify("id_caus_magazzino.protect=0")
end if
tab_1.tabpage_1.dw_orafo_wizard.insertrow(1)
rtncode = tab_1.tabpage_1.dw_orafo_wizard.GetChild('wizard', dwc_wizard)
IF rtncode = -1 THEN MessageBox("Error", "Not a DataWindowChild")
dwc_wizard.SetTransObject(SQLCA)
dwc_wizard.Retrieve()


datastore ds_par_sistema
string ls_nota
integer li_riga

ds_par_sistema=create datastore
ds_par_sistema.dataobject="d_orafo_par_sistema_cx"
ds_par_sistema.settransobject(sqlca)
li_riga=ds_par_sistema.retrieve()
if li_riga>0 then
	ls_nota=ds_par_sistema.getitemstring(1, "nota_in_primo_piano")
	if upper(ls_nota)='S' then
		idw_gen.modify("documento_note_intestazione.visible=1")
		idw_gen.modify("c_registro.visible=0")
	end if
	ls_nota=ds_par_sistema.getitemstring(1, "varia_uc")
	if ls_nota='S' then
		tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.modify("id_unita_confezione.visible=1")
		tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.modify("txt_uc.visible=1")
	end if
else
	messagebox("Attenzione!", "Tabella Orafo_par_sistema non corretta!")
end if

destroy ds_par_sistema
//richiesta samy 250613 spariscono c_tot_righe e c_tot_righe_lire
//se pc="bilancia" in cometa.ini
string path
string sl_file_ini, sl_result

path=fill("*",256)
GetModuleFileNameA(0,path,256)
sl_file_ini = left(path, len(path) - 3)+"ini"
sl_result = ProfileString ( sl_file_ini, "PC", "Nome", "Error!" )

if sl_result = "bilancia" then
	idw_riga.modify("c_tot_righe.visible=0")
	idw_riga.modify("c_tot_righe_lire.visible=0")
end if
//20210419 dw_des_aggiuntiva gestione
ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
ll_id_registro=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_registro")
select tipo_registro, numero, a.codice
into :ls_tipo_registro, :li_num_registro, :ls_cod_azienda
from dba.registro, dba.azienda a
where id_registro=:ll_id_registro
;
if (ls_tipo_registro='GV' and li_num_registro=2) or &
	((ll_id_prof_doc=107 or ll_id_prof_doc=108  or ll_id_prof_doc=110 or ll_id_prof_doc=116 or ll_id_prof_doc=117  or ll_id_prof_doc=125 &
	or ll_id_prof_doc=142 or ll_id_prof_doc=133 ) and ls_cod_azienda = "LABELLA") then
	tab_1.tabpage_2.dw_des_aggiuntiva.visible=true
else
	tab_1.tabpage_2.dw_des_aggiuntiva.visible=false
end if





end event

event ue_close;call super::ue_close;


end event

event ue_tipo_documento;call super::ue_tipo_documento;CHOOSE CASE is_tipo_documento
	CASE "O"
		u_ordini=create u_ges_ordini
end choose

//if left(is_tipo_documento,1)= "F" then
//	cbx_prezzi_controllati.visible=true	
//else
//	cbx_prezzi_controllati.visible=false
//end if
end event

event activate;
u_freddie.iw_current = this



If not IsValid(u_freddie.iudw_current) then
	u_freddie.iudw_current= idw_master
end if

end event

event open;call super::open;string ls_cod_azienda, ls_tipo_registro
integer li_num_registro

ib_cast_in_updatestart_righe = true  //20261012 il castelletto si ricalcola nell'updatestart di dw_riga_documento_ordine_gd: il cb_salva dell'antenato non lo rifà


//Inserito per samy il 02-12-09 (con bollo gestisce stampa disponibilità-esistenza per clienti)
select codice 
into :ls_cod_azienda
from azienda
;

tab_1.tabpage_2.dw_riga_documento_ordine_gd.sharedata(tab_1.tabpage_2.dw_riga_documento_dett_ord_ff)

if ls_cod_azienda="BUCCI" then
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_orafo_riga_documento_ordine_bucci"
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.settransobject(sqlca)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.sharedata(tab_1.tabpage_2.dw_riga_documento_dett_ord_ff)
	idw_gen.modify("t_bollo.text= 'Order:'")
end if

if ls_cod_azienda='LABELLA' then ii_sal_automatico=1
if ls_cod_azienda='SILVERDR' or ls_cod_azienda='VENER' or ls_cod_azienda="PANNA" then
	//inserito 20210123
	 tab_1.tabpage_1.cb_rbol_non_derivati.visible=true
	//fine 23
	
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_orafo_riga_documento_ordine_silver_gd"
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.settransobject(sqlca)
	
	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.dataobject="d_orafo_riga_doc_dettaglio_silver"
	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.settransobject(sqlca)	
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.sharedata(tab_1.tabpage_2.dw_riga_documento_dett_ord_ff)
	//agg. 250814
	tab_1.tabpage_2.cb_partite.visible=true
	tab_1.tabpage_2.cb_pacco.visible=true
	cb_chiudi_ordine.visible=true
	if  ls_cod_azienda="PANNA" then  //2019-05-06 è il campo dove salvo il num bollettina silver
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_provv_imp_carea_2_t.text='N.BOL'")
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_provv_imp_carea_2.format='#,0'")
	end if
end if

//fine variazione samy 02-12-09
tab_1.tabpage_7.dw_salva_prezzo_in_listino.settransobject(sqlca)

//agg. 250814
tab_1.tabpage_2.dw_des_aggiuntiva.settransobject(sqlca)
string ls_flag
select ins_prezzi_in_euro
into :ls_flag
from orafo_par_sistema
;
if ls_flag='S' then
	rb_1.visible=true
	rb_2.visible=true
end if

tab_1.tabpage_2.dw_nota_riga.settransobject(sqlca)

//galvanica totali 22/02/19
if ls_cod_azienda='SILVERDR' or ls_cod_azienda='VENER' or ls_cod_azienda="PANNA" then //20240730 SOLO loro vedono galvanica
	tab_1.tabpage_4.dw_2.settransobject(sqlca)
else
	tab_1.tabpage_4.dw_2.visible=false
	tab_1.tabpage_4.cb_2.visible=false
end if


if upperbound(idw_master.is_list.l_id_riga)>0 then //è l'automatismo per creare un SALD in automatico da w_bol_accessori 20200915
	post wf_crea_sald_da_bol_accessori()
end if
//end if
//20220428 inserisco riga in dw_4 tabpage_2
tab_1.tabpage_2.dw_4.settransobject(sqlca)
tab_1.tabpage_2.dw_4.insertrow(1)
tab_1.tabpage_1.dw_5.settransobject(sqlca)
tab_1.tabpage_1.dw_5.insertrow(1)
end event

type p_msg_log from w_documento_ordine_cx`p_msg_log within w_orafo_documento_ordine_cx
integer x = 2747
integer y = 12
integer width = 160
integer height = 120
string picturename = "C:\nita\icone\old\info_in.bmp"
end type

type p_crescente from w_documento_ordine_cx`p_crescente within w_orafo_documento_ordine_cx
end type

type p_decrescente from w_documento_ordine_cx`p_decrescente within w_orafo_documento_ordine_cx
end type

type cb_ok from w_documento_ordine_cx`cb_ok within w_orafo_documento_ordine_cx
integer x = 59
integer y = 16
integer width = 178
integer height = 76
end type

type cb_annulla from w_documento_ordine_cx`cb_annulla within w_orafo_documento_ordine_cx
integer x = 251
integer y = 16
integer width = 242
integer height = 76
end type

type cb_nuovo from w_documento_ordine_cx`cb_nuovo within w_orafo_documento_ordine_cx
integer x = 526
integer y = 16
integer width = 242
integer height = 76
end type

event cb_nuovo::clicked;call super::clicked;
if isvalid(us_dati_partita.s_dw_aper_partita) then
	destroy us_dati_partita.s_dw_aper_partita
	destroy us_dati_partita.s_dw_scar_partita
end if
parent.title=""
if isvalid(u_ordini) then destroy u_ordini

if isvalid(w_saldo_doc_pop) then
	close(w_saldo_doc_pop)
end if

tab_1.tabpage_7.dw_salva_prezzo_in_listino.reset()
if isvalid(ids_ev_forzata) then
	destroy ids_ev_forzata
end if
long ll_azzera[]
il_id_riga_cancellata=ll_azzera

tab_1.tabpage_2.dw_nota_riga.reset()









end event

type cb_inserisci from w_documento_ordine_cx`cb_inserisci within w_orafo_documento_ordine_cx
integer x = 1385
integer y = 16
integer height = 76
end type

type cb_cancella from w_documento_ordine_cx`cb_cancella within w_orafo_documento_ordine_cx
integer x = 1637
integer y = 16
integer height = 76
end type

event cb_cancella::clicked;
long ll_riga_corrente, ll_id_prof_documento, ll_righe, i
integer  li_ret
string ls_test
u_dw_main 	lu_dw
lu_dw = u_freddie.iudw_current

//20261028 per capire dopo il call super se la cancellazione e' avvenuta davvero
long ll_righe_prima, ll_id_doc_prima
boolean lb_partite
ll_righe_prima = idw_riga.rowcount()
if idw_gen.rowcount() > 0 then ll_id_doc_prima = idw_gen.getitemnumber(1, "id_documento")
lb_partite = isvalid(us_dati_partita.s_dw_aper_partita)

ll_riga_corrente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
if ll_riga_corrente>0 then
	//3009014
	wf_cancella_riga_2(ll_riga_corrente)
	//fine 300914
	if isvalid(us_dati_partita.s_dw_aper_partita) then 
		if isValid(lu_dw.iudw_parent) then	
			
			
			li_ret=wf_cancella_riga1(ll_riga_corrente)
			if li_ret=0 then
				messagebox("Errore", "Errore nella cancellazione delle partite di scarico")
				wf_ricarica_partite()  //20261028 riparto dal db, qualunque cosa sia stata toccata
				return
			end if
		else

			ll_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
			for i= 1 to ll_righe
				li_ret=wf_cancella_riga1(i)
				if li_ret=0 then
					wf_ricarica_partite()  //20261028 le righe prima di questa avevano gia' toccato le partite
					return
				end if
			next
			//20261028 cancellazione del documento intero: le partite gia' ricalate vanno alla finestra di
			//cancellazione, che le salva (prima non le riceveva: scarichi orfani e partite non ricalate)
			ids_par_aper_partita = us_dati_partita.s_dw_aper_partita
			ids_par_scar_partita = us_dati_partita.s_dw_scar_partita
		end if		
	end if
	
	ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
	select agg_lunghezza
	into :ls_test
	from prof_documento
	where id_prof_documento=:ll_id_prof_documento;
	if ls_test='S' or ls_test='P' then
		if isValid(lu_dw.iudw_parent) then
			wf_lung_canc_id_riga(ll_riga_corrente)
			
		else
			for li_ret=1 to idw_riga.rowcount()
				wf_lung_canc_id_riga(li_ret)
			next
			wf_storno_lung_peso()
		end if
	end if
end if
call super::clicked
datastore lds_nessuno
ids_par_aper_partita = lds_nessuno
ids_par_scar_partita = lds_nessuno

//20261028 la conferma la chiede l'antenato (call super), DOPO wf_cancella_riga1 che ha gia' ricalato le partite:
//se la riga o il documento NON sono stati cancellati (risposto No) le partite in memoria si rileggono dal db
if lb_partite then
	if isValid(lu_dw) then
		if isValid(lu_dw.iudw_parent) then
			if idw_riga.rowcount() >= ll_righe_prima then wf_ricarica_partite()
		else
			if idw_gen.rowcount() > 0 then
				if idw_gen.getitemnumber(1, "id_documento") = ll_id_doc_prima then wf_ricarica_partite()
			end if
		end if
	end if
end if

end event

type cb_salva from w_documento_ordine_cx`cb_salva within w_orafo_documento_ordine_cx
integer x = 1888
integer y = 16
integer width = 215
integer height = 76
end type

event cb_salva::clicked;call super::clicked;string ls_vedi_note
long ll_id_prof

//salvo le descrizioni multiple per cliente/fo
post wf_salva_cod_art_cliente()



////salvo le note se è il caso 280710
//spostato in updateend della riga documento 23-02-12
//ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
//select vedi_note_prod_qualita
//	into :ls_vedi_note
//	from dba.prof_documento
//	where id_prof_documento=:ll_id_prof;
//	if ls_vedi_note='S' then
//		post wf_salva_note_riga()
//	end if
end event

type tab_1 from w_documento_ordine_cx`tab_1 within w_orafo_documento_ordine_cx
event create ( )
event destroy ( )
integer x = 41
integer y = 140
integer width = 4096
integer height = 2064
integer taborder = 60
fontcharset fontcharset = ansi!
tabpage_7 tabpage_7
end type

on tab_1.create
this.tabpage_7=create tabpage_7
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_7
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_7)
end on

event tab_1::selectionchanged;call super::selectionchanged;
long ll_id_prof, ll_id_prof_doc, ll_id_doc_prod, ll_righe, ll_null, ll_id_dest
long ll_righe_doc
string ls_cod_sog, ls_saldi, ls_vedi_note,ls_barcode, ls_prof,ls_ins_righe_per_scar_metallo, ls_azienda
decimal ldc_qta_in_pronto
integer li_num_riga, b
datastore ds_par_sistema

ls_ins_righe_per_scar_metallo="SI"

select rag_soc_1
into :ls_azienda
from dba.azienda
;
ls_azienda=upper(ls_azienda)
if newindex<>2 and isvalid(w_saldo_doc_pop) then
	w_saldo_doc_pop.visible=false
elseif newindex=2 and isvalid(w_saldo_doc_pop) then
	w_saldo_doc_pop.visible=true
end if
if newindex=2 AND OLDINDEX=1 then
	//se è giacomo o sara (43 e 18) il tot_righe_lire NON si devono vedere 28-10-20
	if u_freddie.s_utenti.i_idutente=18 or u_freddie.s_utenti.i_idutente=43 then
		idw_riga.modify("c_tot_righe_lire.visible=0")
		idw_riga.modify("c_tot_righe.visible=0")
	end if
	//290814 per gestire estensione riga documento
	//post wf_retrieve_riga_doc_2()
	//inserito per samy 23-12 e 28-12-13
	
	//questa cosa è pericolosissima ... discutere e NON fare
//	tab_1.tabpage_2.cb_rec_prezzi.postevent(clicked!)
//	messagebox("Attenzione!", "Prezzi Aggiornati: confermare con salvataggio o annullare uscendo senza salvare!")
	//fine 23-12 e 28-12-13
	
	//tab_1.tabpage_1.dw_documento_ordine_ff.accepttext()
	//inserisco controllo destinazione: se c'è e non è stata messa avviso: 280512 richiesta samy vener
	if tab_1.tabpage_1.dw_documento_ordine_ff.object.c_destinazione_des.background.color="16777088" then
		
		if pos(ls_azienda, 'SILVER')>0 or pos(ls_azienda, "PANNA")>0 then 
			ll_id_dest=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_destinazione")
			if isnull(ll_id_dest) then
				//se è un "BOL" non deve chiedere 03-01-14
				ls_prof=tab_1.tabpage_1.dw_documento_ordine_ff.getitemstring(1, "c_prof_doc_cod")
				if ls_prof<>'BOL'  and pos(ls_prof, "SALD")<=0  then
					//fne 03-01-14
						if messagebox("Attenzione!", "Non hai scelto la destinazione: la vuoi scegliere ora?", stopsign!,yesno!)=1 then
							tab_1.selecttab(1)
							tab_1.tabpage_1.dw_documento_ordine_ff.setcolumn("c_destinazione_des")
						else
							tab_1.tabpage_1.dw_documento_ordine_ff.object.c_destinazione_des.background.color="16777215"
						end if
					end if
				end if
			end if
	end if

	ds_par_sistema=create datastore
	ds_par_sistema.dataobject="d_orafo_par_sistema_cx"
	ds_par_sistema.settransobject(sqlca)
	ll_id_prof=ds_par_sistema.retrieve()
	if ll_id_prof= 1 then
		ls_cod_sog=ds_par_sistema.getitemstring(1, "saldi_riga_documento")
		if ls_cod_sog='S' then
			ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
			select cal_giac_costi
			into :ls_saldi
			from dba.prof_documento
			where id_prof_documento=:ll_id_prof
			;
			if ls_saldi<>'S' then
				open(w_saldo_doc_pop, parent)
			end if
	
		end if
	end if
	destroy ds_par_sistema
	
	uo_or_documento uo_doc
	uo_doc=create uo_or_documento
	ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
	dw_riga_documento_ordine_gd idw_righe
	idw_righe=idw_riga
	uo_doc.of_proponi_righe(idw_righe, ll_id_prof )
	
	destroy uo_doc
	//260208
	
	select vedi_note_prod_qualita
	into :ls_vedi_note
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof;
	if ls_vedi_note='S' then
		tab_1.tabpage_2.dw_nota_riga.visible=true
	else
		tab_1.tabpage_2.dw_nota_riga.visible=false
	end if
end if



decimal ldc_coef_calo, ldc_peso, ldc_qta
long i, ll_id_valuta, ll_id_caus, ll_id_UC, ll_id_loc_1,ll_id_loc_2,ll_id_documento, LL_ID_RIGA
integer li_ret
string ls_simb_um, ls_tipo_lavorazione, ls_des_riga
long a, ll_righe_retrieve, ll_prima_riga_copiata,ll_righe_prod, ll_riga_esiste, ll_riga_inserita
long ll_id_art
s_array s_bol
datastore ds_righe_bollettina, ds_prod_2011

if (newindex=2)and(oldindex=1) then
	
	if IsValid(ids_righe_ordine) and li_flag=0 then
		//la finestra è stata aperta da componi ordine in sviluppo ordine (w_orafo_ordini_cx)
		li_flag=1
		if tab_1.Tabpage_2.dw_riga_documento_ordine_gd.RowCount()>0 then tab_1.Tabpage_2.dw_riga_documento_ordine_gd.DeleteRow(1)
		if tab_1.Tabpage_2.dw_riga_documento_ordine_gd.RowCount()<>ids_righe_ordine.RowCount() then
			li_ret=ids_righe_ordine.RowsCopy(1,ids_righe_ordine.RowCount(),Primary!,tab_1.Tabpage_2.dw_riga_documento_ordine_gd,1,Primary!)
			if li_ret<>1 then messagebox("Errore!", "Righe non copiate!")
			ll_id_valuta=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1,"documento_id_valuta_des")
			ll_id_caus=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1,"documento_id_caus_magazzino")
			ll_id_loc_1=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "documento_id_locazione_1")
			ll_id_loc_2=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "documento_id_locazione_2")
			ll_id_documento=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "id_documento")
			for i = tab_1.Tabpage_2.dw_riga_documento_ordine_gd.RowCount() to 1 step -1
				ll_id_UC=tab_1.Tabpage_2.dw_riga_documento_ordine_gd.getItemnumber(i,"riga_documento_id_unita_confezione")
				tab_1.Tabpage_2.dw_riga_documento_ordine_gd.SetItem(i,"id_documento",ll_id_documento)
	
				tab_1.Tabpage_2.dw_riga_documento_ordine_gd.SetItem(i, "id_locazione_1", ll_id_loc_1)
				tab_1.Tabpage_2.dw_riga_documento_ordine_gd.SetItem(i, "id_locazione_2", ll_id_loc_2)
				tab_1.Tabpage_2.dw_riga_documento_ordine_gd.SetItem(i,"riga_documento_num_riga",i)
				tab_1.Tabpage_2.dw_riga_documento_ordine_gd.SetItem(i,"riga_documento_id_valuta",ll_id_valuta)
				tab_1.Tabpage_2.dw_riga_documento_ordine_gd.SetItem(i,"riga_documento_id_caus_magazzino",ll_id_caus)
				//inserito successivamente 011010
				ll_id_UC=tab_1.Tabpage_2.dw_riga_documento_ordine_gd.getItemnumber(i,"riga_documento_id_unita_confezione")
				select simbolo
				into :ls_simb_um
				from unita_confezione u, unita_misura m 
				where u.id_unita_confezione=:ll_id_UC
				and u.id_unita_misura=m.id_unita_misura;	
				tab_1.Tabpage_2.dw_riga_documento_ordine_gd.SetItem(i,"simbolo_mov",ls_simb_um)
				ldc_coef_calo=tab_1.Tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(i, "coef_calo")
				ldc_peso=tab_1.Tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(i, "riga_documento_peso_netto")
				wf_setta_fino_calo(i)
				//fine inserimento
				
				tab_1.Tabpage_2.dw_riga_documento_ordine_gd.trigger event ue_rec_prezzo(i,1)
				tab_1.Tabpage_2.dw_riga_documento_ordine_gd. event trigger ue_set_calc_riga(i)
			next
		end if
	end if
//	//18-01-11 gestione ordini con codice a barre
//	//rivisto completamente dal 15-30 marzo 2012
	wf_cod_barre_bollettine()
	
end if
//20212021 Samy vuole richiamare bollettina scrivendo il codice della stessa
if (newindex=2)and(oldindex=1) then
	ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
	if  pos(ls_azienda, 'SILVER DR')>0 and ll_id_prof=187 then //"xsald"
		tab_1.tabpage_2.dw_3.visible=true
		tab_1.tabpage_2.dw_3.settransobject(sqlca)
		tab_1.tabpage_2.dw_3.insertrow(1)
		
	else
		tab_1.tabpage_2.dw_3.visible=false
	end if
	if ll_id_prof_doc=66 then  //20231108
		tab_1.tabpage_2.dw_4.visible=false
	else
		tab_1.tabpage_2.dw_4.visible=true
	end if
end if


//	ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
//	select ins_barcode
//	into :ls_barcode
//	from dba.prof_documento
//	where id_prof_documento =:ll_id_prof_doc
//	;
//	IF ls_barcode='S' then
//		ll_id_valuta=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1,"documento_id_valuta_des")
//		ll_id_caus=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1,"documento_id_caus_magazzino")
//		ll_id_loc_1=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "documento_id_locazione_1")
//		ll_id_loc_2=tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "documento_id_locazione_2")
//		
//		ds_righe_bollettina=create datastore
//		ds_righe_bollettina.dataobject="d_orafo_riga_documento_ordine_filtro_gd"
//		ds_righe_bollettina.settransobject(sqlca)
//		//per caricare eventualmente la riga con la lavorazione interessata
//		select step_produzione
//		into :ls_tipo_lavorazione
//		from dba.caus_magazzino
//		where id_caus_magazzino=:ll_id_caus
//		;
//		choose case ls_tipo_lavorazione
//			case "S"
//				ls_tipo_lavorazione="SA" //Saldatura
//			case "M"
//				ls_tipo_lavorazione="SP" //spazzolatura
//			case "A"
//				ls_tipo_lavorazione="AR" //argentatura
//			case "E"
//				ls_tipo_lavorazione="EC" //ecoat
//				//se è altro resta com'è
//		end choose
//		
//		//controllo se cè la riga iniziale vuota proposta in automatico 
//		if idw_riga.rowcount()=1 then
//			//se è una riga vuota di articolo e descrizione la cancello
//			ll_id_art=idw_riga.getitemnumber(1, "riga_documento_id_articolo")
//			ls_des_riga=idw_riga.getitemstring(1, "riga_documento_descrizione")
//			if isnull(ll_id_art) and (isnull(ls_des_riga) or ls_des_riga< " ") then
//				idw_riga.deleterow(1)
//			end if
//		end if
//		openwithparm(w_lega_doc_a_bollettina_pop, il_id_documento)
//		
//		s_bol=message.powerobjectparm
//		if isvalid(s_bol) then	
//
//			if upperbound(s_bol.ll_id_doc)>0 then
//				ds_prod_2011=create datastore
//				ds_prod_2011.dataobject="d_produzione_2011_ra_gd"
//				ds_prod_2011.settransobject(sqlca)
//			end if
//			setnull(ll_null)
//			for a=1 to upperbound(s_bol.ll_id_doc)
//				if s_bol.ll_id_doc[a]>0 then
//					select rag_soc_1
//					into :ls_azienda
//					from dba.azienda
//					;
//					if pos(ls_azienda, "Panna Art")>0 then
//						ds_righe_bollettina.dataobject="d_orafo_riga_documento_ordine_munna_gd"
//						ds_righe_bollettina.settransobject(sqlca)
//						ll_righe_retrieve=ds_righe_bollettina.retrieve(s_bol.ll_id_doc[a])
//					else
//						ll_righe_retrieve=ds_righe_bollettina.retrieve(s_bol.ll_id_doc[a], ls_tipo_lavorazione)
//					end if
//					if ll_righe_retrieve<=0 then 
//						messagebox("Attenzione!", "Nessuna bollettina trovata!")
//						ls_ins_righe_per_scar_metallo="NO"
//						exit
//					end if
//						LL_ID_RIGA=ds_righe_bollettina.getitemnumber(1, "id_riga_documento")
//						//ldc_qta=ds_righe_bollettina.getitemdecimal(1, "quantita")
//						//150612: samy vuole che sul pronto la bollettina proponga la qta residua tolto il pronto già fatto
//						ldc_qta=wf_calcola_qta_residua_bollettina(s_bol.ll_id_doc[a], 0)
//						if isnull(ldc_qta) then ldc_qta=0
//						
//						//questo non lo capisco... era stabilito così? 
//						//if isnull(ldc_qta) or ldc_qta=0 then ldc_qta=1
//						//fine 150612
//						if ls_tipo_lavorazione='X' then //è un "pronto" (tipo_lavorazione "X" = doc PRONTO)
//							ds_righe_bollettina.setitem(1, "id_riga_doc_provenienza", ll_null)
//							//150612 aggiungo su richiesta samy: 
//							//1) il peso = 0,01 (perché tanto lo mette da bilancia e non metto "0" perché sennò gli ricalcola i pezzi;
//							//2) tara= 0 tanto la mette lei nel pronto
//							ds_righe_bollettina.setitem(1, "riga_documento_peso_lordo", 0) //peso_lordo=tara
//							ds_righe_bollettina.setitem(1, "riga_documento_peso_netto", 0.01)
//							//metto la qta residua invece che quella totale della bollettina
//							ds_righe_bollettina.setitem(1, "quantita", ldc_qta)
//							//fine 150612
////						
//						else
//							ds_righe_bollettina.setitem(1, "riga_documento_provv_imp_subage_2", LL_ID_RIGA)
//						//if not(pos(ls_azienda, "Panna Art")>0) then
//							//101012 azzero qualsiasi valore del peso perché non deve influire sul magazzino
//							ds_righe_bollettina.setitem(1, "riga_documento_peso_lordo", 0) //peso_lordo=tara
//							ds_righe_bollettina.setitem(1, "riga_documento_peso_netto", 0)
//							//aggiunto 270313 perché riportava in spazzolatura valori del fino e del calo
//							ds_righe_bollettina.setitem(1, "fino", 0)
//							ds_righe_bollettina.setitem(1, "calo", 0)
//							//end if
//						end if
//					
//					//fine 101012
//					ds_righe_bollettina.setitem(1, "qta_evasa", 0)
//					ds_righe_bollettina.setitem(1, "qta_evasa_un_base", 0)
//					ds_righe_bollettina.setitem(1, "peso_netto_evaso", 0)
//					for b=2 to ll_righe_retrieve
//						ds_righe_bollettina.setitem(b, "id_riga_doc_padre", LL_ID_RIGA)
//					next
//
//					ll_prima_riga_copiata=idw_riga.rowcount()+1
//					li_ret=ds_righe_bollettina.rowscopy(1,ll_righe_retrieve , Primary!, idw_riga, ll_prima_riga_copiata, Primary!)
//					ll_id_doc_prod=idw_gen.getitemnumber(1, "id_documento")
//					setnull(ll_null)
//					ll_righe_doc=idw_riga.rowcount()
//					if ll_righe_doc>0 then
//						li_num_riga=idw_riga.getitemnumber(1, "c_max_num")
//						if isnull(li_num_riga)  then li_num_riga=0
//					else
//						li_num_riga=0
//					end if
//					b=0
//					for i= ll_prima_riga_copiata to idw_riga.rowcount()
//						b++
//						
//						idw_riga.SetItem(i, "id_locazione_1", ll_id_loc_1)
//						idw_riga.SetItem(i, "id_locazione_2", ll_id_loc_2)
//						idw_riga.SetItem(i,"riga_documento_num_riga",li_num_riga+b)
//						idw_riga.SetItem(i,"riga_documento_id_valuta",ll_id_valuta)
//						idw_riga.SetItem(i,"riga_documento_id_caus_magazzino",ll_id_caus)
//												
//						idw_riga.setitem(i, "id_documento", ll_id_doc_prod)
//						idw_riga.setitem(i, "id_riga_documento", ll_null)
//						//faccio scattare il ricalcolo dei prezzi
//						tab_1.Tabpage_2.dw_riga_documento_ordine_gd.trigger event ue_rec_prezzo(i, ldc_qta)
//						idw_riga.setitemstatus(i, 0, primary!, newmodified!)
//					 
//					next
//					
//					if idw_riga.update()=1 then
//						commit;
//						//adesso lego la riga appena salvata alla bollettina (la prima riga è quella giusta)
//						if pos(ls_azienda, "Panna Art")<>1 then
//							ll_id_riga=idw_riga.getitemnumber(ll_prima_riga_copiata, "id_riga_documento")
//							ll_righe_prod=ds_prod_2011.retrieve(s_bol.ll_id_doc[a])
//							if ll_righe_prod>0 then
//								ll_riga_esiste=ds_prod_2011.find("id_doc_produzione="+string(ll_id_riga), 1, ds_prod_2011.rowcount())
//								//se esiste già non faccio nulla
//								if ll_riga_esiste>0 then
//									continue
//								end if
//							end if
//							ll_riga_inserita=ds_prod_2011.insertrow(0)
//							ds_prod_2011.setitem(ll_riga_inserita, "id_bollettina", s_bol.ll_id_doc[a])
//							ds_prod_2011.setitem(ll_riga_inserita, "id_doc_produzione", ll_id_riga)
//							//salvo
//							if ds_prod_2011.update()=1 then
//								commit;
//								//quindi posso chiudere la bollettina e farla diventare uno scarico
//								//"Quando si manda in galvanica o in qualsiasi altra lavorazione (smerigliatura, saldatura)
//								//devi cambiare lettera a ordinato_fo e mettere “S” (suggerito da Samy)
//								//per indicare che tale bollettina deve essere vista come scarico
//								//e riporta il valore scaricato nella colonna scarichi della stampa “d_data_tot_doc_tb”."
//								//150513
//								//commento tutto perché dà problemi nel correggi bollettina (rimostra le bollettine sppuntate come se fosse ordinato_fo='S')
//	//							update dba.riga_documento
//	//							set ordinato_fo='G'  //vuol dire che è andato in galvanica o in smerigliatura o ...
//	//							where id_documento=:s_bol.ll_id_doc[a]
//	//							;
//	//							if sqlca.sqlNrows>0 then
//	//								commit;
//	//							else
//	//								rollback;
//	//								messagebox("Errore!", "Bollettina id="+string (s_bol.ll_id_doc[a])&
//	//											+"NON trasformata in scarico (ordinato_fo='G')")
//	//							end if
//							else
//								rollback;
//								messagebox("Errore!", "Legame con bollettina non salvato!")
//							end if
//						end if
//					else
//						rollback;
//						messagebox("Errore!", "Riga non salvata!")
//					end if
//				end if
//			next				
//			if ls_ins_righe_per_scar_metallo='SI' then
//				ll_righe=idw_riga.rowcount()
//				wf_ins_righe_per_scar_metallo(ll_righe)
//			end if
//		end if
//	end if


end event

event tab_1::selectionchanging;call super::selectionchanging;string ls_tipo_registro, ls_cod_azienda
integer li_num_registro
long ll_id_prof_doc, ll_id_registro

if newindex=2 then
	if isvalid(w_giacenza_pz) then
		w_giacenza_pz.visible=true
	end if
	if isvalid(w_partita_a_pz) then	
		w_partita_a_pz.visible=true
	end if
else
	if isvalid(w_giacenza_pz) then
		w_giacenza_pz.visible=false
	end if
	if isvalid(w_partita_a_pz) then	
		w_partita_a_pz.visible=false
	end if
end if

if newindex=2 and oldindex=1  then
	ll_id_registro=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_registro")
	select tipo_registro, numero, a.codice
	into :ls_tipo_registro, :li_num_registro, :ls_cod_azienda
	from dba.registro, dba.azienda a
	where id_registro=:ll_id_registro
	;
	ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
	if (ls_tipo_registro='GV' and li_num_registro=2) or &
		((ll_id_prof_doc=107 or ll_id_prof_doc=108  or ll_id_prof_doc=110 or ll_id_prof_doc=116 or ll_id_prof_doc=117  or ll_id_prof_doc=125 &
		or ll_id_prof_doc=142 or ll_id_prof_doc=133 ) and ls_cod_azienda = "LABELLA" ) then
		tab_1.tabpage_2.dw_des_aggiuntiva.visible=true
	else
		tab_1.tabpage_2.dw_des_aggiuntiva.visible=false
	end if

end if

end event

type tabpage_1 from w_documento_ordine_cx`tabpage_1 within tab_1
integer width = 4059
integer height = 1944
cb_var_prezzo cb_var_prezzo
dw_orafo_wizard dw_orafo_wizard
cb_1 cb_1
cb_prezzi_confermati cb_prezzi_confermati
cb_controlla_bollettine cb_controlla_bollettine
cb_cambia_iva cb_cambia_iva
cb_5 cb_5
cb_6 cb_6
cb_rbol_non_derivati cb_rbol_non_derivati
cb_12 cb_12
cb_cambia_prof cb_cambia_prof
dw_5 dw_5
pb_excel pb_excel
rb_per_articolo rb_per_articolo
rb_per_riga rb_per_riga
cb_13 cb_13
r_1 r_1
r_2 r_2
end type

on tabpage_1.create
this.cb_var_prezzo=create cb_var_prezzo
this.dw_orafo_wizard=create dw_orafo_wizard
this.cb_1=create cb_1
this.cb_prezzi_confermati=create cb_prezzi_confermati
this.cb_controlla_bollettine=create cb_controlla_bollettine
this.cb_cambia_iva=create cb_cambia_iva
this.cb_5=create cb_5
this.cb_6=create cb_6
this.cb_rbol_non_derivati=create cb_rbol_non_derivati
this.cb_12=create cb_12
this.cb_cambia_prof=create cb_cambia_prof
this.dw_5=create dw_5
this.pb_excel=create pb_excel
this.rb_per_articolo=create rb_per_articolo
this.rb_per_riga=create rb_per_riga
this.cb_13=create cb_13
this.r_1=create r_1
this.r_2=create r_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_var_prezzo
this.Control[iCurrent+2]=this.dw_orafo_wizard
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_prezzi_confermati
this.Control[iCurrent+5]=this.cb_controlla_bollettine
this.Control[iCurrent+6]=this.cb_cambia_iva
this.Control[iCurrent+7]=this.cb_5
this.Control[iCurrent+8]=this.cb_6
this.Control[iCurrent+9]=this.cb_rbol_non_derivati
this.Control[iCurrent+10]=this.cb_12
this.Control[iCurrent+11]=this.cb_cambia_prof
this.Control[iCurrent+12]=this.dw_5
this.Control[iCurrent+13]=this.pb_excel
this.Control[iCurrent+14]=this.rb_per_articolo
this.Control[iCurrent+15]=this.rb_per_riga
this.Control[iCurrent+16]=this.cb_13
this.Control[iCurrent+17]=this.r_1
this.Control[iCurrent+18]=this.r_2
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_var_prezzo)
destroy(this.dw_orafo_wizard)
destroy(this.cb_1)
destroy(this.cb_prezzi_confermati)
destroy(this.cb_controlla_bollettine)
destroy(this.cb_cambia_iva)
destroy(this.cb_5)
destroy(this.cb_6)
destroy(this.cb_rbol_non_derivati)
destroy(this.cb_12)
destroy(this.cb_cambia_prof)
destroy(this.dw_5)
destroy(this.pb_excel)
destroy(this.rb_per_articolo)
destroy(this.rb_per_riga)
destroy(this.cb_13)
destroy(this.r_1)
destroy(this.r_2)
end on

type cb_deriva from w_documento_ordine_cx`cb_deriva within tabpage_1
integer x = 2057
integer y = 1284
integer width = 320
integer height = 80
end type

type cb_blocco from w_documento_ordine_cx`cb_blocco within tabpage_1
integer x = 2053
integer y = 1376
integer width = 320
end type

type cb_note from w_documento_ordine_cx`cb_note within tabpage_1
integer x = 2437
integer y = 1376
integer width = 320
integer height = 80
end type

type cb_cerca_anticipi from w_documento_ordine_cx`cb_cerca_anticipi within tabpage_1
integer x = 2437
integer y = 1284
integer width = 320
end type

type dw_documento_ordine_ff from w_documento_ordine_cx`dw_documento_ordine_ff within tabpage_1
integer x = 5
integer y = 0
integer width = 4046
integer height = 1828
borderstyle borderstyle = stylelowered!
end type

event dw_documento_ordine_ff::updateend;call super::updateend;	string ls_cod_partita, ls_controllato
	long ll_id_caus_magazzino, ll_id_doc
if rowsinserted+rowsupdated>0 then

	ll_id_caus_magazzino=getitemnumber(getrow(), "documento_id_caus_magazzino")
	ls_cod_partita=wf_trova_cod_tipo_partita(ll_id_caus_magazzino)
	if mid(ls_cod_partita, 2,1) ='S' then wf_carica_datastore()
	wf_controlla_doppioni()
//	//04-04-2018 se creato_in_esenzione="C" allora devo checcare cbx_prezzi_controllati
//	ls_controllato=getitemstring(1, "creato_in_esenzione")
//	if ls_controllato='C' then //è gia stato controllato occorre mostrarlo
//		cbx_prezzi_controllati.checked=true
//	else
//		cbx_prezzi_controllati.checked=false
//	end if
	
//	tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)
//20241129 con il bottone lo sblocco e ora lo riblocco con la fine del salvataggio
//
end if


end event

event dw_documento_ordine_ff::ue_set_search;
string ls_intestatari, ls_int_cons,ls_tipo_reg
long ll_count, ll_len, ll_id_prof_documento, ll_id_sog_comm, ll_id_mod_registro
long ll_id_sog_commerciale_fatt,ll_id_anagrafica,ll_id_sog_commerciale

ls_intestatari =""
if not (IsNull(is_int_consentiti) OR is_int_consentiti="")  then
	ll_len = Len(is_int_consentiti)
	for ll_count = 1 to ll_len
		ls_intestatari = ls_intestatari + ",'" + Mid(is_int_consentiti, ll_count, 1) + "'"
	next
	if not IsNull(ls_intestatari) then ls_intestatari = Mid(ls_intestatari, 2,Len(ls_intestatari)-1)
	ls_intestatari = "(" + ls_intestatari + ")"
end if


ls_tipo_reg = is_list.s_win_parametri

CHOOSE CASE as_nomecol
		
	case "c_abi_cab_des"	
		
		is_search_window 				= "w_banca_sog_commerciale_gen_sw" 
		is_ricpar.s_filter_value 	= as_valcol 
		is_ricpar.s_filter_name 	= "cc_den_abi_cab" 
		
		ll_id_sog_commerciale_fatt	= GetItemNumber(GetRow(),"documento_id_sog_commerciale_fattura")

		If not(IsNull(ll_id_sog_commerciale_fatt) OR ll_id_sog_commerciale_fatt=0) then
			SELECT "sog_commerciale"."id_anagrafica"  
				INTO :ll_id_anagrafica  
				FROM "dba"."sog_commerciale"  
				WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale_fatt ;
				
			IF not(IsNull(ll_id_anagrafica) OR ll_id_anagrafica=0) THEN
				is_ricpar.s_sql_cond = "banca_sog_commerciale_gen.id_anagrafica = "+ String(ll_id_anagrafica)
			end if
			
		else
			ll_id_sog_commerciale	= GetItemNumber(GetRow(),"id_sog_commerciale")
			If not(IsNull(ll_id_sog_commerciale) OR ll_id_sog_commerciale=0) then
				SELECT "sog_commerciale"."id_anagrafica"  
					INTO :ll_id_anagrafica  
					FROM "dba"."sog_commerciale"  
					WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ;
				IF not(IsNull(ll_id_anagrafica) OR ll_id_anagrafica=0) THEN 
					is_ricpar.s_sql_cond = "banca_sog_commerciale_gen.id_anagrafica = "+ String(ll_id_anagrafica)
				end if	
			end if
		END IF		

	CASE "c_prof_doc_cod"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_codice" 
		
		CHOOSE CASE is_tipo_documento
			CASE "O"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'OA' OR prof_documento.tipo_registro = 'OV'"
			CASE "D"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'DA' OR prof_documento.tipo_registro = 'DV'"
			CASE "F"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'IA' OR prof_documento.tipo_registro = 'IV'"
			CASE "G"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'GA' OR prof_documento.tipo_registro = 'GV'"
			CASE "P"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'PA' OR prof_documento.tipo_registro = 'PV'"
			
		END CHOOSE
	CASE "c_prof_doc_des"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_descrizione" 
		
		CHOOSE CASE is_tipo_documento
			CASE "O"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'OA' OR prof_documento.tipo_registro = 'OV'"
			CASE "D"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'DA' OR prof_documento.tipo_registro = 'DV'"
			CASE "F"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'IA' OR prof_documento.tipo_registro = 'IV'"
			CASE "G"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'GA' OR prof_documento.tipo_registro = 'GV'"
			CASE "P"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'PA' OR prof_documento.tipo_registro = 'PV'"
			
		END CHOOSE

	CASE "c_registro"
		is_search_window = "w_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "registro_descrizione" 
		ll_id_prof_documento=GetItemNumber(il_row,"id_prof_documento")
		
		If not(IsNull(ll_id_prof_documento) OR ll_id_prof_documento=0) then
			If not( IsNull(il_id_mod_registro) OR IsNull(il_id_esercizio) ) then
				is_ricpar.s_sql_cond  = "registro.id_esercizio = " + String(il_id_esercizio) + " AND  registro.id_mod_registro = " + String(il_id_mod_registro)
			end if
		else
			is_ricpar.s_sql_cond  = "registro.id_esercizio = -1"
		end if
	CASE "c_registro_des"
		is_search_window = "w_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "registro_descrizione" 
		ll_id_prof_documento=GetItemNumber(il_row,"id_prof_documento")
		
		If not(IsNull(ll_id_prof_documento) OR ll_id_prof_documento=0) then
				If not( IsNull(il_id_mod_registro) OR IsNull(il_id_esercizio) ) then
				is_ricpar.s_sql_cond  = "registro.id_esercizio = " + String(il_id_esercizio) + " AND  registro.id_mod_registro = " + String(il_id_mod_registro)
			end if
		else
			is_ricpar.s_sql_cond  = "registro.id_esercizio = -1"
		end if
	CASE "c_sog_comm_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
		is_ricpar.b_asneeded=TRUE
		if not (IsNull(ls_intestatari) OR ls_intestatari="") then is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo IN " + ls_intestatari

	CASE "c_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		is_ricpar.b_asneeded=TRUE
		if not (IsNull(ls_intestatari) OR ls_intestatari="") then is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo IN " + ls_intestatari

	CASE "c_destinazione_des"
		ll_id_sog_comm = GetItemNumber(il_row,"id_sog_commerciale")
		is_search_window = "w_destinazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		if not (IsNull(ll_id_sog_comm) OR ll_id_sog_comm= 0) then is_ricpar.s_sql_cond = "destinazione.id_sog_commerciale = " + string(ll_id_sog_comm)
	
	CASE "c_vettore_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"

	CASE "c_vettore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
	
	CASE "c_gruppo_agenti_cod"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		

	CASE "c_gruppo_agenti_des"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		
END CHOOSE
CHOOSE CASE as_nomecol
		
	CASE "id_tipo_trasporto"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Trasporto"
		is_ricpar.s_ausil_value[1] = "id_tipo_trasporto_des"

		is_ricpar.i_width = 2606
		is_ricpar.i_height = 873
	CASE "id_tipo_trasporto_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Trasporto"
		is_ricpar.s_ausil_value[1] = "id_tipo_trasporto"
		is_ricpar.i_width = 2606
		is_ricpar.i_height = 873
		
	CASE "documento_id_valuta_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "documento_id_valuta_des"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
	CASE "documento_id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "documento_id_valuta_cod"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
		
END CHOOSE


end event

event dw_documento_ordine_ff::itemchanged;call super::itemchanged;
long ll_id_doc, ll_id_val_euro,ll_id_sog
datetime ldt_data_ora
date ld_data
integer li_ret
decimal{6} ldc_acconto, ldc_cambio_old
long ll_id_prof_doc
string ls_cod_profilo

choose case string(dwo.name)
	case	"data_documento" 
	ld_data=date(data)
	ldt_data_ora=datetime(ld_data,now())
	setitem(1, "documento_data_ora_creazione", ldt_data_ora)
	
	ll_id_doc=getitemnumber(1, "id_documento")
	if not isnull(ll_id_doc) then
		li_ret=idw_riga.update()
		if li_ret=1 then
			commit;
			post wf_crea_datastore()
		else
			rollback;
			messagebox("Errore!", "Impossibile salvare righe del documento: ~r~nChiudere e riaprire questa finestra!")
		end if
	end if

case "documento_data_ora_creazione" 
	ll_id_doc=getitemnumber(1, "id_documento")
	if not isnull(ll_id_doc) then
		li_ret=idw_riga.update()
		if li_ret=1 then
			commit;
			post wf_crea_datastore()
		else
			rollback;
			messagebox("Errore!", "Impossibile salvare righe del documento: ~r~nChiudere e riaprire questa finestra!")
		end if
	end if

case "documento_cambio" 
	w_documento_ordine_cx lw_doc
	tab u_tab
	u_tab=parent.getparent()
	lw_doc=u_tab.getparent()
	u_righe_doc l_uo_importa_righe
	l_uo_importa_righe=create u_righe_doc
	select id_val_euro
	into :ll_id_val_euro
	from par_sistema;
	
//	if al_id_val_az=ll_id_val_euro then
//		idc_cambio=1/dec(data)
//	else
		//idc_cambio=dec(data)
		idc_cambio=1/dec(data)  //temporaneo vediamo cosa succede ... 20220210
//	end if
	l_uo_importa_righe.uf_calcola_cambio(idc_cambio, lw_doc)
	destroy l_uo_importa_righe
case "num_documento"
	post wf_controlla_doppioni()
case "c_prof_doc_cod", "c_prof_doc_des"
	//guardo se il profilo apre la finestra della giacenza
	//se sì aggiorno la variabile di istanza
	
	ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
	select giac_pezzi 
	into :is_pz_giacenza
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof_doc;
	case "creato_in_esenzione" 
		ls_cod_profilo=getitemstring(1, "c_prof_doc_cod")
		if upper(ls_cod_profilo) = "ORDCLI" then
			idw_riga.modify("quantita.protect= 1")
		end if
		
end choose	

end event

event dw_documento_ordine_ff::getfocus;call super::getfocus;dw_orafo_wizard.object.datawindow.color = "10789024"
end event

event dw_documento_ordine_ff::losefocus;call super::losefocus;dw_orafo_wizard.object.datawindow.color = "79741120"
end event

event dw_documento_ordine_ff::clicked;call super::clicked;f_displayonly(this, "documento_cambio", false)
datetime ldt_data_ora
time lt_time
date ld_data
integer li_ora=3600
decimal ldc_acconto

choose case dwo.name
	case "cb_agg_ora" 
		ldt_data_ora=getitemdatetime(1, "documento_data_ora_creazione")
		ld_data=date(ldt_data_ora)
		lt_time=time(ldt_data_ora)
		if xpos<532 then li_ora*= -1
		lt_time=relativetime(lt_time, li_ora)
		ldt_data_ora=datetime(ld_data, lt_time)
		setitem(1, "documento_data_ora_creazione", ldt_data_ora)
		post wf_crea_datastore()
end choose

end event

event dw_documento_ordine_ff::ue_initial;call super::ue_initial;//datastore ds_par_sistema
//string ls_nota
//integer li_riga
//
//ds_par_sistema=create datastore
//ds_par_sistema.dataobject="d_orafo_par_sistema_cx"
//ds_par_sistema.settransobject(sqlca)
//li_riga=ds_par_sistema.retrieve()
//if li_riga>0 then
//	ls_nota=ds_par_sistema.getitemstring(1, "nota_in_primo_piano")
//	if upper(ls_nota)='S' then
//		idw_gen.modify("documento_note_intestazione.visible=1")
//		idw_gen.modify("c_registro.visible=0")
//	end if
//	ls_nota=ds_par_sistema.getitemstring(1, "varia_uc")
//	if ls_nota='S' then
//		tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.modify("id_unita_confezione.visible=1")
//		tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.modify("txt_uc.visible=1")
//	end if
//else
//	messagebox("Attenzione!", "Tabella Orafo_par_sistema non corretta!")
//end if
//
//destroy ds_par_sistema
end event

event dw_documento_ordine_ff::ue_retrieve;call super::ue_retrieve;
//20261028 prima wf_carica_datastore, che li crea solo se non ci sono: restavano le partite del documento precedente
post wf_ricarica_partite()
post wf_blocca_ddt_fatturato()


end event

event dw_documento_ordine_ff::ue_deletestart;integer i, li_ret
long ll_righe

if isvalid(us_dati_partita.s_dw_aper_partita) then
	li_ret=us_dati_partita.s_dw_scar_partita.update()
	if li_ret<>1 then
		messagebox("Errore!", "Scarico Partita non salvata!")
		rollback;
		return
	else
		commit;
	end if
	li_ret=us_dati_partita.s_dw_aper_partita.update()
	if li_ret<>1 then
		messagebox("Errore!", "Apertura Partita non salvata!")
		rollback;
	else
		commit;
	end if
end if

wf_set_utedocumento("DD")


end event

event dw_documento_ordine_ff::ue_set_valu_fields;call super::ue_set_valu_fields;idw_castelletto.postevent("ue_calc_sconti_cast")
//wf_setta_mask_riga()
end event

event dw_documento_ordine_ff::updatestart;call super::updatestart;date ld_data, ldt_data_reg
string ls_num_doc, ls_cod_soggetto, ls_num_doc_ver
long ll_id_sog, ll_id_registro, ll_num_prog
dwitemstatus dwis_doc
decimal ldc_fino
date ldt_a_data


ld_data=idw_gen.getitemdate(1, "data_documento")
if isnull(ld_data) then
	ld_data=idw_gen.getitemdate(1, "data_registrazione")
	idw_gen.setitem(1, "data_documento", ld_data)
end if
ls_num_doc=idw_gen.getitemstring(1, "num_documento")
if isnull(ls_num_doc) or ls_num_doc='' then
	idw_gen.setitem(1, "num_documento", string(idw_gen.getitemnumber(1, "num_progressivo"))+"X")
end if

//controllo doppia numerazione su reg. DA (stesso numero, (stessa data), stesso cliente)
//samy 280910
dwis_doc=getitemstatus(1, 0, primary!)
if dwis_doc=NEW! or dwis_doc=NEWMODIFIED! then
	ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
	ll_id_registro = getitemnumber(1,"id_registro")
	ls_cod_soggetto=idw_gen.getitemstring(1,"c_sog_comm_cod")
	select num_documento, num_progressivo, data_registrazione
	into :ls_num_doc_ver, :ll_num_prog, :ldt_data_reg
	from dba.documento
	where num_documento=:ls_num_doc
	and id_sog_commerciale=:ll_id_sog
	and id_registro=:ll_id_registro;
	if ls_num_doc_ver>" " then
		messagebox("Attenzione!", "Esiste già un documento con n. "+ls_num_doc+" intestato a "+ls_cod_soggetto &
						+" - Num. Prog.: "+string(ll_num_prog)+ " Data Reg.:"+string(ldt_data_reg))
	end if
	//controllo se il doc va ad incidere su un saldo verificato 290910
	//in tal caso avverto, ma non blocco
	select fino_calo, fino_a_data
	into :ldc_fino, :ldt_a_data
	from dba.saldo_verificato
	where fino_a_data>= :ld_data
	and id_sog_commerciale=:ll_id_sog
	;
	if ldc_fino>0 then
		messagebox("Attenzione!", "Saldo Verificato con "+ls_cod_soggetto+&
		" il "+string(ldt_a_data)+" Valore: "+string(ldc_fino))
	end if
end if




wf_gestione_utenti()
end event

event dw_documento_ordine_ff::itemfocuschanged;call super::itemfocuschanged;decimal ldc_acconto
long ll_id_prof_doc
string ls_barcode, ls_numero, ls_data_scadenza,ls_data_doc
integer li_pos
s_stringa_data_prog s_struct


choose case dwo.name
case "documento_cambio"
	ldc_acconto=getitemdecimal(1, "imp_acconto")
	if ldc_acconto>0 then
		messagebox("Attenzione!", "Per Variare il valore del cambio occorre che l'acconto sia 0!")
		modify("imp_acconto.protect=0")
		post setcolumn("imp_acconto")
	end if
case "num_documento"
	ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
	if ll_id_prof_doc>0 then
		select ins_barcode
		into :ls_barcode
		from dba.prof_documento
		where id_prof_documento =:ll_id_prof_doc
		;
		IF ls_barcode='B' then
			ls_data_doc=string(idw_gen.getitemdate(1, "data_DOCUMENTO"), "yyyy/mm/dd")
			openwithparm(w_ins_barcode_pop, ls_data_doc )
			ls_numero=message.stringparm
			if ls_numero>"" then
				s_struct=f_scomp_stringa_num_data_prog(ls_numero)
//				li_pos=pos(ls_numero, "#")
//				if li_pos>0 then
//					
//					ls_data_scadenza=right(ls_numero, len(ls_numero) - li_pos)
//					ls_numero=left(ls_numero, li_pos -1)
//				end if
				if s_struct.as_numero> " " then
					post setitem(1, "num_documento", s_struct.as_numero )  //ls_numero)
				end if
				if  s_struct.adt_data> date("01-01-1901") then
					post setitem(1, "data_prev_consegna",  s_struct.adt_data)  //date(ls_data_scadenza))
				end if
//				li_pos=0
//				li_pos=pos(ls_numero, "___")
			if s_struct.al_prog>0 then
//					ls_prog=right(ls_numero, len(ls_numero) - (li_pos +2))
//					ls_numero=left(ls_numero, li_pos -1)
					post setitem(1, "num_progressivo", s_struct.al_prog)
				end if
//			if ls_numero>"" then
//				li_pos=pos(ls_numero, "#")
//				if li_pos>0 then
//					li_pos=len(ls_numero) - li_pos
//					ls_data_scadenza=right(ls_numero, li_pos)
//					ls_numero=left(ls_numero, li_pos)
//				end if
//				post setitem(1, "num_documento", ls_numero)
//				if ls_data_scadenza> " " then
//					post setitem(1, "data_prev_consegna", date(ls_data_scadenza))
//				end if
				post wf_controlla_doppioni()
			end if
			
		end if
	END IF
end choose
end event

event dw_documento_ordine_ff::retrieveend;call super::retrieveend;string ls_livello
long ll_id_prof_doc
integer li_null[]

ls_livello=f_livello_utente('N')

if ls_livello <> 'A' then
	if left(is_tipo_registro, 1)='I' then
		messagebox("Attenzione!", "Utente non abilitato alla contabilità")
		cb_nuovo.postevent(clicked!)
	end if
end if
//guardo se il profilo apre la finestra della giacenza
//se sì aggiorno la variabile di istanza
	ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
	select giac_pezzi 
	into :is_pz_giacenza
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof_doc;
	
//290814 resetto la riga_doc_2
//modificata 20210411
tab_1.tabpage_2.dw_des_aggiuntiva.reset()
//tab_1.tabpage_2.dw_des_aggiuntiva.post retrieve(il_id_documento)

//20221016 annullo il vettore che cambia il colore alle righe controllate (clicked "cod_bbarre"
 ii_righe_fatte[]=li_null[]
 //fine
end event

event dw_documento_ordine_ff::doubleclicked;call super::doubleclicked;if dwo.name="documento_id_valuta_cod" then
	if messagebox("Attenzione!", "Sei davvero sicuro di voler cambiare valuta?"+&
	"La cosa dovrà essere seguita dal ricalcolo del cambio!", stopsign!, yesno!)=1 then
		f_displayonly(this, "documento_id_valuta_cod", FALSE)
	end if
	
end if
end event

event dw_documento_ordine_ff::ue_set_prof_fields;call super::ue_set_prof_fields;string ls_cod_prof, ls_test

select proteggi_profilo
into :ls_test
from orafo_par_sistema;
ls_cod_prof=getitemstring(1, "c_prof_doc_cod")
if ls_cod_prof=ls_test then
	idw_riga.modify("riga_documento_peso_netto.protect='0 ~t if(id_riga_doc_padre > 0, 1,0)' ")
	idw_riga.modify("quantita.protect='0 ~t if(id_riga_doc_padre > 0, 1,0)' ")
	idw_riga.modify("prezzo_complessivo.protect='0 ~t if(id_riga_doc_padre > 0, 1,0)' ")
	idw_riga.modify("sigla_prezzo.protect='0 ~t if(id_riga_doc_padre > 0, 1,0)' ")
else
//	if upper(ls_cod_prof)="GBOL" then
//		idw_riga.modify("prezzo_complessivo.protect='1'") //20240319: provo a commentare, se i lamenti arrivano fino a me trovo un altro sistema
//	else
//		idw_riga.modify("prezzo_complessivo.protect='0'")
//	end if
		idw_riga.modify("riga_documento_peso_netto.protect='0'")
	idw_riga.modify("quantita.protect='0'")
	
	idw_riga.modify("sigla_prezzo.protect='0'")
end if
//20231017 cambio etichetta al prezzi_controllati, in ordcli e "ordine a peso"
if upper(ls_cod_prof)="ORDCLI" then
	idw_gen.modify("creato_in_esenzione.checkbox.text='Ordine a PESO'")
	
else
	idw_gen.modify("creato_in_esenzione.checkbox.text='Prezzi CONTROLLATI''")
end if


return 0

end event

event dw_documento_ordine_ff::ue_set_sog_fields;call super::ue_set_sog_fields;long ll_id_sog, ll_id_tipo_trasp, ll_id_caus_trasp
string ls_asp_beni, ls_trasp_mezzo,ls_delivery


ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
if ll_id_sog=43 then
	cb_controlla_bollettine.visible=true
else
	cb_controlla_bollettine.visible=false
end if
if ll_id_sog>0 then
	select id_tipo_trasporto, id_caus_trasporto, trasp_a_mezzo, asp_beni_descrizione
	into :ll_id_tipo_trasp, :ll_id_caus_trasp,  :ls_trasp_mezzo, :ls_asp_beni
	from dba.proponi_trasporto
	where id_sog_commerciale= :ll_id_sog
	;
	if sqlca.sqlcode=0 then
		tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem(1, "id_tipo_trasporto", ll_id_tipo_trasp)
		tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem(1, "id_caus_trasporto", ll_id_caus_trasp)
		tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem(1, "tras_mezzo", ls_trasp_mezzo)
		tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem(1, "asp_beni", ls_asp_beni)
	end if
	select uff_iva into :ls_delivery from dba.sog_commerciale
	where id_sog_commerciale= :ll_id_sog
	;
	if ls_delivery> " " then
		idw_gen.setitem(1, "documento_mezzo_trasporto",ls_delivery )
	end if
end if
return 0
end event

type tabpage_2 from w_documento_ordine_cx`tabpage_2 within tab_1
integer width = 4059
integer height = 1944
pb_riep_pesi pb_riep_pesi
cb_quotazione cb_quotazione
pb_stampa_righe pb_stampa_righe
pb_legenda pb_legenda
cb_agg_listino cb_agg_listino
dw_nota_riga dw_nota_riga
cb_rec_prezzi cb_rec_prezzi
hpb_avanzamento hpb_avanzamento
cb_libre_calc cb_libre_calc
cb_f_c cb_f_c
cb_partite cb_partite
dw_des_aggiuntiva dw_des_aggiuntiva
cb_pacco cb_pacco
pb_1 pb_1
cbx_decimali cbx_decimali
pb_cod_barre_bollettine pb_cod_barre_bollettine
cb_copia_riga cb_copia_riga
cbx_des_3 cbx_des_3
cb_4 cb_4
cbx_incartato cbx_incartato
cb_reso_non_lavorato cb_reso_non_lavorato
dw_3 dw_3
dw_4 dw_4
cbx_agg_coef_calo cbx_agg_coef_calo
cb_8 cb_8
cb_9 cb_9
cb_coef_calo_925 cb_coef_calo_925
cb_10 cb_10
cb_11 cb_11
st_des_3_prezzo st_des_3_prezzo
pb_2 pb_2
pb_3 pb_3
dw_6 dw_6
cb_csv cb_csv
dw_9 dw_9
end type

on tabpage_2.create
this.pb_riep_pesi=create pb_riep_pesi
this.cb_quotazione=create cb_quotazione
this.pb_stampa_righe=create pb_stampa_righe
this.pb_legenda=create pb_legenda
this.cb_agg_listino=create cb_agg_listino
this.dw_nota_riga=create dw_nota_riga
this.cb_rec_prezzi=create cb_rec_prezzi
this.hpb_avanzamento=create hpb_avanzamento
this.cb_libre_calc=create cb_libre_calc
this.cb_f_c=create cb_f_c
this.cb_partite=create cb_partite
this.dw_des_aggiuntiva=create dw_des_aggiuntiva
this.cb_pacco=create cb_pacco
this.pb_1=create pb_1
this.cbx_decimali=create cbx_decimali
this.pb_cod_barre_bollettine=create pb_cod_barre_bollettine
this.cb_copia_riga=create cb_copia_riga
this.cbx_des_3=create cbx_des_3
this.cb_4=create cb_4
this.cbx_incartato=create cbx_incartato
this.cb_reso_non_lavorato=create cb_reso_non_lavorato
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cbx_agg_coef_calo=create cbx_agg_coef_calo
this.cb_8=create cb_8
this.cb_9=create cb_9
this.cb_coef_calo_925=create cb_coef_calo_925
this.cb_10=create cb_10
this.cb_11=create cb_11
this.st_des_3_prezzo=create st_des_3_prezzo
this.pb_2=create pb_2
this.pb_3=create pb_3
this.dw_6=create dw_6
this.cb_csv=create cb_csv
this.dw_9=create dw_9
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_riep_pesi
this.Control[iCurrent+2]=this.cb_quotazione
this.Control[iCurrent+3]=this.pb_stampa_righe
this.Control[iCurrent+4]=this.pb_legenda
this.Control[iCurrent+5]=this.cb_agg_listino
this.Control[iCurrent+6]=this.dw_nota_riga
this.Control[iCurrent+7]=this.cb_rec_prezzi
this.Control[iCurrent+8]=this.cb_f_c
this.Control[iCurrent+9]=this.cb_partite
this.Control[iCurrent+10]=this.dw_des_aggiuntiva
this.Control[iCurrent+11]=this.cb_pacco
this.Control[iCurrent+12]=this.pb_1
this.Control[iCurrent+13]=this.cbx_decimali
this.Control[iCurrent+14]=this.pb_cod_barre_bollettine
this.Control[iCurrent+15]=this.cb_copia_riga
this.Control[iCurrent+16]=this.cbx_des_3
this.Control[iCurrent+17]=this.cb_4
this.Control[iCurrent+18]=this.cbx_incartato
this.Control[iCurrent+19]=this.cb_reso_non_lavorato
this.Control[iCurrent+20]=this.dw_3
this.Control[iCurrent+21]=this.dw_4
this.Control[iCurrent+22]=this.cbx_agg_coef_calo
this.Control[iCurrent+23]=this.cb_8
this.Control[iCurrent+24]=this.cb_9
this.Control[iCurrent+25]=this.cb_coef_calo_925
this.Control[iCurrent+26]=this.cb_10
this.Control[iCurrent+27]=this.cb_11
this.Control[iCurrent+28]=this.st_des_3_prezzo
this.Control[iCurrent+29]=this.pb_2
this.Control[iCurrent+30]=this.pb_3
this.Control[iCurrent+31]=this.dw_6
this.Control[iCurrent+32]=this.cb_csv
this.Control[iCurrent+33]=this.dw_9
this.Control[iCurrent+34]=this.hpb_avanzamento
this.Control[iCurrent+35]=this.cb_libre_calc
end on

on tabpage_2.destroy
call super::destroy
destroy(this.pb_riep_pesi)
destroy(this.cb_quotazione)
destroy(this.pb_stampa_righe)
destroy(this.pb_legenda)
destroy(this.cb_agg_listino)
destroy(this.dw_nota_riga)
destroy(this.cb_rec_prezzi)
destroy(this.hpb_avanzamento)
destroy(this.cb_libre_calc)
destroy(this.cb_f_c)
destroy(this.cb_partite)
destroy(this.dw_des_aggiuntiva)
destroy(this.cb_pacco)
destroy(this.pb_1)
destroy(this.cbx_decimali)
destroy(this.pb_cod_barre_bollettine)
destroy(this.cb_copia_riga)
destroy(this.cbx_des_3)
destroy(this.cb_4)
destroy(this.cbx_incartato)
destroy(this.cb_reso_non_lavorato)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cbx_agg_coef_calo)
destroy(this.cb_8)
destroy(this.cb_9)
destroy(this.cb_coef_calo_925)
destroy(this.cb_10)
destroy(this.cb_11)
destroy(this.st_des_3_prezzo)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.dw_6)
destroy(this.cb_csv)
destroy(this.dw_9)
end on

type p_arrow from w_documento_ordine_cx`p_arrow within tabpage_2
end type

type pb_sort from w_documento_ordine_cx`pb_sort within tabpage_2
integer x = 1934
integer y = 800
integer width = 105
integer height = 92
boolean bringtotop = true
string picturename = "C:\nita\icone\ordina.png"
end type

type cb_ricalcola from w_documento_ordine_cx`cb_ricalcola within tabpage_2
integer x = 2039
integer y = 804
integer width = 146
integer textsize = -7
fontcharset fontcharset = ansi!
string text = "Rical."
end type

event cb_ricalcola::clicked;long ll_row, ll_nr_row
decimal ld_pr_metallo, ld_pr_manifattura, ld_peso, ld_fino_calo

ll_nr_row= idw_riga.RowCount()
FOR  ll_row =1 to  ll_nr_row
	wf_calcola_prezzo(ll_row)
next
messagebox("OK!", "Ricalcolo prezzi completato.")
end event

type dw_riga_documento_ordine_gd from w_documento_ordine_cx`dw_riga_documento_ordine_gd within tabpage_2
event ue_post_itemch_cond ( long row,  string campo,  decimal valore )
string tag = "Righe Documento"
integer x = 5
integer y = 0
integer width = 3977
integer height = 920
string dataobject = "d_orafo_riga_documento_ordine_gd"
string icon = "AppIcon!"
boolean livescroll = true
boolean ib_retrieved = true
end type

event dw_riga_documento_ordine_gd::ue_post_itemch_cond(long row, string campo, decimal valore);setitem(row, campo, valore)
end event

event dw_riga_documento_ordine_gd::rowfocuschanged;call super::rowfocuschanged;long ll_riga, ll_riga_trovata, ll_test, li_num_riga, ll_id_art

if currentrow>0 then

	//300914 per des aggiuntiva
	
	//post wf_des_aggiuntiva(currentrow)
	//fine 300914
	ll_riga=getitemnumber(currentrow, "id_riga_documento")
	if isnull(ll_riga) then
		ll_riga=getitemnumber(currentrow, "riga_documento_num_riga")
		ll_riga_trovata=dw_nota_riga.find("num_riga="+string(ll_riga), 1, dw_nota_riga.rowcount())
		
	else
		//sincornizzo des_aggiuntiva 20210411
		wf_sinc_des_agg(currentrow)
		ll_riga_trovata=dw_nota_riga.find("note_id_riga_doc="+string(ll_riga), 1, dw_nota_riga.rowcount())
		if ll_riga_trovata <= 0 then
			LL_TEST=dw_nota_riga.ROWCOUNT()
			dw_nota_riga.retrieve(ll_riga)
			if ll_test = dw_nota_riga.ROWCOUNT() then 
				ll_riga_trovata=dw_nota_riga.insertrow(0)
				//250208
				li_num_riga=getitemnumber(currentrow, "riga_documento_num_riga")
			
				dw_nota_riga.setitem(ll_riga_trovata, "num_riga", li_num_riga)

				
			else
				ll_riga_trovata=dw_nota_riga.find("note_id_riga_doc="+string(ll_riga), 1, dw_nota_riga.rowcount())
			end if
		end if
	end if
	dw_nota_riga.scrolltorow(ll_riga_trovata)
	//apro, se è il caso w_giacenza_pz
	wf_ric_giac_partita_pezzo()
//	if is_pz_giacenza='S' then
//		ll_id_art=getitemnumber(currentrow, "riga_documento_id_articolo")
//		if isnull(ll_id_art) then ll_id_art=0
//		if  isvalid(w_giacenza_pz) then
//			w_giacenza_pz.post w_leggi_saldo(ll_id_art)
//		else
//			openwithparm(w_giacenza_pz, ll_id_art, iw_corrente )
//			
//
//		end if
//		if  isvalid(w_partita_a_pz) then
//			w_partita_a_pz.post w_leggi_saldo(ll_id_art)
//		else
//			openwithparm(w_partita_a_pz, ll_id_art, iw_corrente )
//			
//
//		end if
			
			
		
		//w_giacenza_pz.post w_leggi_saldo()
//
//if not isvalid(w_giacenza_pz) then
//	open(w_giacenza_pz, iw_corrente )
//end if
	//end if
	
	
	
end if

end event

event dw_riga_documento_ordine_gd::updateend;call super::updateend;///20250103 sposto tutto a livello di operazione sulla singola riga (itemchanged, clicked ecc...


integer li_ret, i, li_num_riga, li_num_registro
boolean lb_errore
long ll_id_riga, ll_riga_ord_fo
string ls_ev,ls_vedi_note, ls_profilo, ls_registro,ls_azienda
decimal{2} ld_fc_riga, ld_fc_part
decimal ld_prezzo_manifattura, ld_prezzo_metallo
long ll_id_prof

//if tab_1.tabpage_2.dw_des_aggiuntiva.visible=true then wf_salva_riga_doc_2()

//se il registro è delle bollettine (tipo GV numero 2 e azienda ="SILVERDR" controllo che il numero della riga (unica) sia = 1
ls_registro=idw_gen.getitemstring(1, "c_registro")
li_num_registro=integer(right(ls_registro, 2))
select codice 
into :ls_azienda
from azienda;
if is_tipo_registro='GV' and li_num_registro=2 and ls_azienda="SILVERDR" then
	if idw_riga.rowcount()<> 1 then
		messagebox("Attenzione!", "Le bollettine DEVONO avere SOLO UNA RIGA!!")
	else
		li_num_riga=idw_riga.getitemnumber(1, "riga_documento_num_riga")
		if  li_num_riga<>1 then
			messagebox("Attenzione!", "La riga della Bollettina DEVE avere NUMERO RIGA = 1!! RISALVARE IL DOCUMENTO!!!")
			setitem(1, "num_riga", 1)
		end if
	end if
END IF
//20241209 spostato in dw_nota_riga si salva appena cambiano
//salv le note riga produzione se è il caso ... //20250401 lo rimetto perché NON funge...
ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
select vedi_note_prod_qualita
into :ls_vedi_note
from dba.prof_documento
where id_prof_documento=:ll_id_prof;
if ls_vedi_note='S' then
	wf_salva_note_riga()
end if
//if isvalid(ids_ev_forzata) then
//20241209 spostato in itemchanged e fuznione wf_chius_forzata
//		for li_ret=1 to rowcount()
//			ll_id_riga=getitemnumber(li_ret, "id_riga_doc_provenienza")
//			if ll_id_riga>0 then
//				ls_ev=getitemstring(li_ret, "forza_chius_evasione")
//				update riga_documento
//				set forza_chius_evasione=:ls_ev
//				where id_riga_documento=:ll_id_riga;
//				if sqlca.sqlcode<>0 then
//					rollback;
//					messagebox("Salvataggio non Riuscito!", "Chiusura forzata righe non riuscita!")
//					li_ret = -1
//					exit
//				else
//					commit;
//				end if
//			end if
//		next
			
//	end if
//chissà perché c'è anche +DeletedCount()+ModifiedCount() ????
if rowsinserted+rowsupdated+rowsdeleted+DeletedCount()+ModifiedCount()>0 then
	//per elisa chiedo se si è ricordata di stornare gli ordini nel VRCLF
	ls_profilo=idw_gen.getitemstring(1, "c_prof_doc_cod")
	if ls_profilo='VRCLF' then
		post wf_attenzione()
	end if
	
	post wf_ric_giac_partita_pezzo()
	
	li_ret= wf_salva_ds_partite()
	
	wf_storno_lung_peso()
	wf_salva_lung_peso()
		
	if isvalid(w_saldo_doc_pop) then
		w_saldo_doc_pop.post w_leggi_saldo()
	end if
	//01-04-2019 pesce d'aprile ... questa wf-controlla_profilo del 2016 veniva lanciata nl cb_stampa, ora non si stampano più i doc interessati quindi la richiamo da qui
	wf_controlla_profilo()
		
	if	tab_1.tabpage_7.dw_salva_prezzo_in_listino.rowcount()>0 then
		li_ret=tab_1.tabpage_7.dw_salva_prezzo_in_listino.update()
		if li_ret=1 then
			commit;
		else
			messagebox("Attenzione!", SQLCA.SQLErrText)
			rollback;
		end if
end if
	
//	if isvalid(ids_ev_forzata) then
//		for li_ret=1 to ids_ev_forzata.rowcount()
//			ll_id_riga=ids_ev_forzata.getitemnumber(li_ret, "id_riga_documento")
//			ls_ev=ids_ev_forzata.getitemstring(li_ret, "forza_chius_evasione")
//			update riga_documento
//			set forza_chius_evasione=:ls_ev
//			where id_riga_documento=:ll_id_riga;
//			if sqlca.sqlcode<>0 then
//				rollback;
//				messagebox("Salvataggio non Riuscito!", "Chiusura forzata righe non riuscita!")
//				li_ret = -1
//				exit
//			end if
//		next
//		if li_ret>0 then
//			commit;
//		end if
//			
//	end if

end if


//Lego ordine clienti a ordine fornitori
if rowsinserted>0 and isvalid(ids_ord_cli_fo) then
	if ids_ord_cli_fo.rowcount()=rowcount() then
		for i=1 to rowcount()
			ll_riga_ord_fo=getitemnumber(i, "id_riga_documento")
			ids_ord_cli_fo.setitem(i, "id_riga_ord_fornitore", ll_riga_ord_fo)
		next
		if ids_ord_cli_fo.update()=1 then
			commit;
			ids_ord_cli_fo.reset()
		else
			rollback;
			messagebox("Errore!", "Legame ordini clienti ordini fornitori non salvato!")
		end if
	end if
end if

end event

event dw_riga_documento_ordine_gd::itemchanged;decimal ld_qta, ld_qta_1, ldc_data, ldc_peso_laccio, ldc_peso_filo_rame
decimal{4}  ld_peso_originale, ld_peso_gr, ld_fino, ld_null, ld_valore_vecchio, ld_altro, ld_fino_da_controllare
decimal{4} ld_qta_originale, ld_peso_uc, ld_tolleranza
integer li_ret, li_confermato
long ll_id_titolo, ll_id_uc, ll_id_articolo, ll_id_caus_mag, ll_id_sog
string  ls_cod, ls_campo, ls_sospesa
setnull(ld_null)
date ldt_data_reg, ldt_data_doc
decimal  ld_conv_misura, ld_conv_mis_peso, ld_dim, ld_dim_uc
decimal{4} ad_peso, ld_peso_manuale, ld_peso_unitario,ldc_old_value, ldc_peso_medio
long ll_id_caus_magazzino
string ls_cod_tipo_partita
long ll_id_prof_doc, ll_id_art, ll_id_dest, ll_id_utente, ll_id_cat_merc, ll_id_riga
string ls_agg_pr_listino, ls_simbolo_um, ls_prof_doc, ls_prezzo_confermato
s_lung_peso s_lung
datastore lds_lung
string ls_riga_confermata, ls_cod_azienda,ls_metallo


ls_sospesa=idw_riga.getitemstring(row, "riga_documento_sospesa")
if ls_sospesa='S' then
	ls_cod=uf_get_colval(dwo.name)
	messagebox("Attenzione!", "La riga è Sospesa: ogni cambiamento è inibito!"&
	+"~r~nPer modificare la riga cambiare il valore del flag sospeso."&
	+"~r~n(Doppio click sulla riga, pagina 'INFO')", Stopsign!)
	post uf_set_colval(dwo.name, ls_cod)
	return 
end if

choose case string(dwo.name)	
	CASE 'coef_calo', 'riga_documento_peso_netto' 
	
		if dwo.name='coef_calo' then
			ld_altro=getitemdecimal(row, 'riga_documento_peso_netto')
		else 
			ld_tolleranza=getitemdecimal(row, "riga_documento_peso_netto")
			li_ret=wf_tolleranza(row, dec(data), -1)
				
			ld_altro=getitemdecimal(row, "coef_calo")
						
			ld_qta=getitemdecimal(row, "quantita")
			if ld_qta=0 or isnull(ld_qta) then
				
				ll_id_articolo=idw_riga.getitemnumber(row, "riga_documento_id_articolo")
				ld_dim=idw_riga.getitemdecimal(row, "riga_documento_dim_l")
				ls_simbolo_um=idw_riga.getitemstring(row, "unita_misura_b_simbolo")
				ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
				select peso_manuale, peso_unitario
				into :ld_peso_manuale, :ld_peso_unitario
				from orafo_lung_peso
				where id_articolo=:ll_id_articolo
				and id_sog_commerciale=:ll_id_sog
				and lunghezza=:ld_dim
				and simbolo_um=:ls_simbolo_um;
				if ld_peso_manuale>0 then
					ld_peso_unitario=ld_peso_manuale
				end if				
				if ld_peso_unitario>0 then
					setitem(row, "quantita", round(dec(data)/ld_peso_unitario,0))
				else 
					ll_id_uc=getitemnumber(row, "riga_documento_id_unita_confezione")
					select peso_netto, dim_l
					into :ld_qta_originale, :ld_dim_UC 
					from unita_confezione
					where id_unita_confezione= :ll_id_uc;
					if ld_qta_originale>0 then 
					
					
						ld_dim=getitemdecimal(row, "riga_documento_dim_l")
						if ld_dim>0 and ld_dim_UC>0 then 
							if ld_dim>0 then ld_qta_originale=(ld_qta_originale/ld_dim_UC)*ld_dim
						end if	
						ld_qta=dec(data)/ld_qta_originale
						setitem(row, "quantita", ROUND(ld_qta,0))
					end if
				end if
			end if
		end if
		
		
		if ld_altro>0 then  
			ll_id_titolo=getitemnumber(row, "id_titolo")
			ls_campo=string(dwo.name)
			ld_valore_vecchio=getitemdecimal(row, ls_campo)
			ld_fino_da_controllare=dec(data)*ld_altro/1000
			post wf_controlla_partita(row,ld_valore_vecchio, ll_id_titolo,ld_fino_da_controllare, string(dwo.name) )
		end if
		
		if dwo.name='riga_documento_peso_netto' then
			ld_peso_originale=getitemdecimal(row, "riga_documento_peso_netto")
			ldc_data=dec(data)
			//solo per samy 19-10-2015 arrotondo il peso all'intero (senza decimali sempre per eccesso)
			select rag_soc_1
			into :ls_cod_azienda
			from dba.azienda
			;
			ll_id_utente=idw_gen.getitemnumber(1, "documento_id_utenti")
//			if tab_1.tabpage_2.cbx_decimali.checked = false then    ////commentato su richiesta Samy: non si usa più 20220414
//				//utente deve essere diverso da Elisa (39) 
//				//e NON deve essere un doc in entrata (tipo <> "DA")
//				//e il metallo NON deve essere AU
//				ll_id_titolo=getitemnumber(row, "id_titolo")
//				select codice
//				into :ls_metallo
//				from dba.orafo_metallo m, dba.orafo_titolo t
//				where t.id_metallo=m.id_metallo
//				and t.id_titolo=:ll_id_titolo
//				;
//				//IL PROFILO DEVE ESSERE DIVERSO DA KAGALV E KRGALV (159 E 160)
//				ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
//				if ls_metallo<>'AU' then
//					if (pos(ls_cod_azienda, "Silver Dreams")>0 or pos(ls_cod_azienda, "talpanna")>0) and ll_id_utente<>39 and is_tipo_registro<>"DA" AND ll_id_prof_doc<>159 and ll_id_prof_doc<>160  then
//						ldc_data=ceiling(ldc_data) //arrotondo al superiore
//						data=string(ldc_data)
//						if ldc_data>0 then post setitem(row, "riga_documento_peso_netto", ldc_data)
//					end if
//				end if
//			end if
			
			//fine modifica per samy
			call super::itemchanged
			ad_peso=dec(data)
			li_ret=wf_gestione_partite(row, ad_peso, ld_peso_originale, ld_null)
//			if li_ret=10 then   //20241209 cambiato l'ho messo in fondo (165) una volta per tutte
//				wf_setta_fino_calo(row, ad_peso, -1)
//			end if
			post wf_calcola_prezzo(row)
			post wf_salva_riga_partita()
			wf_magg_per_quantita(row) //20241209 spsotato da updatestart e messo anche in ue-rec-prezzo
			//20250321 gesstisco ultima modifica riga per controllo peso nelle foto/video richiesta Serena
			
			if row >0 then
				wf_salva_riga_doc_estensione(row)
			end if
			//20250321 fine
		else
			
			ll_id_titolo=this.getitemnumber(row,"id_titolo")
			ld_qta_originale=getitemdecimal(row, "coef_calo")
			
			li_ret=wf_controlla_range_coef_calo(ll_id_titolo, this, row, string(dwo.name), dec(data))
			if li_ret=0 then 
				post setitem(row,"coef_calo",ld_qta_originale)
				return
			end if
			ld_peso_originale=getitemdecimal(row, "riga_documento_peso_netto")
			if ld_peso_originale=0 or isnull(ld_peso_originale) then return
			
			li_ret=wf_gestione_partite(row, ld_peso_originale, ld_peso_originale, dec(data))
//			if li_ret=10 then //20241209 cambiato l'ho messo in fondo (165) una volta per tutte
//				wf_setta_fino_calo(row, ld_peso_originale, dec(data))
//			end if
			ll_id_caus_mag=getitemnumber(row, "riga_documento_id_caus_magazzino")
			ls_cod=wf_trova_cod_tipo_partita(ll_id_caus_mag)
			ls_cod=left(ls_cod, 1)
			if (isvalid(us_dati_partita.s_dw_aper_partita) and  ls_cod='S')&
				and (isnull(us_dati_partita.s_ld_quantita_selezionata) or (us_dati_partita.s_ld_quantita_selezionata=0)) then
				post event ue_post_itemch_cond(row, "coef_calo", ld_qta_originale)
				//post wf_setta_fino_calo(row, ld_peso_originale, ld_qta_originale)  //20241209 cambiato l'ho messo in fondo (165) una volta per tutte
				
			else
				post wf_setcolumn_prezzo()
			end if
			post wf_calcola_prezzo(row)
			post wf_salva_riga_partita()
		end if
		
		ld_qta=0
		ld_qta_originale=0
		post wf_setta_fino_calo(row)  //20241209 INSERITO QUI perché era disperso ovunque cambiate anche numero paramentri
		
	
	case 'c_articolo_cod' 
		ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
		ll_id_dest=idw_gen.getitemnumber(1, "id_destinazione")
		
		post f_controlla_art_destinazione(data, ll_id_prof_doc,ll_id_dest)
		
		if idw_gen.getitemstring(1, "c_registro_des") ="BOLLETTINE" then
			post f_avverti_variante(data)
		end if
		w_recupera_non_prezioso(row, -1)
		
		s_lung = wf_ric_lung_variante(row, data)
		if isvalid(s_lung)  then
			if  s_lung.cod_articolo>""  then 
				data=s_lung.cod_articolo
			end if
		end if
		//se kagalv o krgalv allora controllo se hanno galvanica "speciale"
		wf_KA_KR_rec_galvanica(row, data, ll_id_prof_doc)
		
		call super::itemchanged
		post wf_cartellino(row)
		
		
		if ancestorreturnvalue<>2 then return ancestorreturnvalue
		
		
		ll_id_caus_magazzino=getitemnumber(row, "riga_documento_id_caus_magazzino")
		ls_cod_tipo_partita=wf_trova_cod_tipo_partita(ll_id_caus_magazzino)
		li_ret=setitem(row, "cod_tipo_partita", ls_cod_tipo_partita)
		if li_ret<>1 then
			messagebox("Errore!", "Setitem fallito tipo partita in riga_documento")
		end if
		
		
		if isvalid(s_lung)  then
			if s_lung.cod_articolo>"" then
				post setitem(row, "riga_documento_dim_l", s_lung.lunghezza)
			end if
		end if
		
		//280910 per recupero samy costo galvanica (prezzo metallo per ora)
		post wf_prezzo_galvanica(row, data)  //commento perché è cambiato il modo di recuperare la galvanica
		//per gestione finestra saldi a pz (se cambia art cambia saldo)
		post wf_ric_giac_partita_pezzo()
//		if  isvalid(w_giacenza_pz) then
//			select id_articolo
//			into :ll_id_art
//			from articolo
//			where codice=:data;
//			w_giacenza_pz.w_leggi_saldo(ll_id_art)
//		end if
//		if  isvalid(w_partita_a_pz) then
//			w_partita_a_pz.w_leggi_saldo(ll_id_art)
//		end if
		wf_rec_des_aggiuntiva(row, 0, data)
		post wf_car_nota_art_in_produzione(row)
	
		//aggungo su richiesta luca goldchains
		//dopo l'articolo il cursore va in coef_calo 02-07-15
		post setcolumn("coef_calo")


		
		return ancestorreturnvalue
	
	case "prezzo_metallo" 
		//20210208 non l'ha mai usato nessuno....
//		if not(data='' or isnull(data)) then
//			li_ret=messagebox("Attenzione!", "Vuoi aggiornare al quotazione del metallo?",Question!, yesno! )
//			if li_ret=1 then
//				ll_id_articolo=getitemnumber(row, "riga_documento_id_articolo")
//				ldt_data_reg=tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(1, "data_registrazione")
//				wf_propone_prezzo_metallo(ll_id_articolo, ldt_data_reg, dec(data))
//			end if
//		end if
		
		post wf_calcola_prezzo(row)
	
	
	case "prezzo_manifattura" ,  "prezzo_complessivo"
		//240713 proteggo i prezzi se sono confermati (stampato=C o X)
		
		//ls_prezzo_confermato=idw_gen.getitemstring(1, "documento_stampato") //abbandono 20220304
		//ls_riga_confermata=getitemstring(row, "riga_documento_da_stampare") //abbandono 20220304
		li_confermato=getitemdecimal(row, "provv_agente_2")
		//if ls_prezzo_confermato='C' or ls_prezzo_confermato='X' or ls_riga_confermata='C' or ls_riga_confermata='X' or li_confermato=1 then
		if li_confermato=1 then
			ldc_old_value=getitemdecimal(row, string(dwo.name))
			li_ret= messagebox("Attenzione!", "Prezzo Confermato: lo vuoi cambiare lo stesso?", stopsign!, yesno!, 2)
			if li_ret <>1 then
				return 2
			else
				open(w_password_pop)
				li_ret=Message.DoubleParm
				if li_ret<>1 then 
					post setitem(row, string(dwo.name), ldc_old_value)
					//aggiungo 02-05-2018: metto "M" come modificato che NON va nel listino
					post  setitem(row,"provv_agente_2" , 2)
					li_confermato=2
				end if
			end if
		end if
		
//		ldc_old_value=getitemdecimal(row, "prezzo_manifattura")
//		wf_proteggi_prezzi_confermati(row, ldc_old_value, dwo.name)
		//240713 fine
		//20261126 prezzo scritto a mano su una riga non confermata: la M (provv_agente_2 = 2) e il REC non lo tocca piu'
		//(i prezzi messi a mano hanno la priorita' sul listino). Sulle confermate resta la regola di prima, con la password.
		if isnull(li_confermato) then li_confermato = 0
		if li_confermato <> 1 then
			post setitem(row, "provv_agente_2", 2)
			li_confermato = 2
		end if
		wf_magg_per_quantita(row)
		post wf_calcola_prezzo(row)
	
		if li_confermato=1 then
			ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
			select agg_pr_listino
			into :ls_agg_pr_listino
			from prof_documento
			where id_prof_documento=:ll_id_prof_doc;
			if ls_agg_pr_listino='S'   then 
				ll_id_uc=getitemnumber(row, "riga_documento_id_unita_confezione")
				wf_salva_prezzo_in_listino(row, dec(data), 0, ll_id_uc)	
			end if 
		end if
		//samy 120213 se prezzo modificato a mano segnala con colore blu
		//wf_prezzo_modificato(row, data, string(dwo.name))
		
	case "quantita" 
		w_recupera_non_prezioso(row, dec(data))
		ld_qta_originale=getitemdecimal(row, "quantita")
		ld_peso_originale=getitemdecimal(row, "riga_documento_peso_netto")
		
		IF ld_peso_originale>0 THEN
			li_ret=wf_tolleranza(row, ld_peso_originale, dec(data))			
		END IF
		//04-01-10 silverdreams gestione esplosione articoli
//		ls_prof_doc=idw_gen.getitemstring(1, "c_prof_doc_cod") //commentato 21-03-12
//		if ls_prof_doc='RBOL' then
			wf_ricalcola_figli(ld_qta_originale, dec(data), row)
		//end if
		
		call super::itemchanged
		
		IF ld_peso_originale=0 or isnull(ld_peso_originale) then
			ld_dim=getitemdecimal(row, "riga_documento_dim_l")
			ld_conv_misura=getitemdecimal(row, "conversione_volume_comune")
			if ld_conv_misura=0 or isnull(ld_conv_misura) then ld_conv_misura=1
			ll_id_uc=getitemnumber(row, "riga_documento_id_unita_confezione")
			
			
			ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
			ll_id_articolo=getitemnumber(row, "riga_documento_id_articolo")
			ls_simbolo_um=getitemstring(row, "unita_misura_b_simbolo")
			
			lds_lung=create datastore
			lds_lung.dataobject="ds_lung_peso"
			lds_lung.settransobject(sqlca)
			li_ret=lds_lung.retrieve(ll_id_sog, ll_id_articolo, ls_simbolo_um, ld_dim)
			if li_ret=1 then
				
				ld_peso_gr=lds_lung.getitemdecimal(1, "peso_manuale")
				if ld_peso_gr=0 or isnull(ld_peso_gr) then
					ld_peso_gr=lds_lung.getitemdecimal(1, "peso_unitario")
				end if
				ld_peso_gr*=dec(data)
			else
				select peso_netto, dim_l
				into  :ld_peso_uc, :ld_dim_uc
				from unita_confezione
				where id_unita_confezione= :ll_id_uc;
				
				if isnull(ld_peso_uc) then ld_peso_uc=0
				
				if ld_dim_uc>0 then
					ld_conv_mis_peso=ld_peso_uc/ld_dim_uc
				else
					ld_dim=ld_peso_uc
					ld_conv_mis_peso=1
				end if
	
				ld_peso_gr=ld_dim*ld_conv_misura*ld_conv_mis_peso*dec(data)
			end if
			destroy(lds_lung)
			
			
			if ld_peso_gr<=0 or isnull(ld_peso_gr) then
				ld_peso_gr=getitemdecimal(row, "riga_documento_peso_netto")
			end if
			
			if  ld_peso_gr > 0  then 
				setitem(row, "riga_documento_peso_netto", ld_peso_gr)
				
				
				li_ret=wf_gestione_partite(row, ld_peso_gr, ld_peso_originale, ld_null)
//				if li_ret=10 then  //20220424 proviamo l'ho messo in nfodno che lo fa sempre
//					wf_setta_fino_calo(row)
//				end if
				
				
				if isvalid(us_dati_partita.s_dw_aper_partita) and ((isnull(us_dati_partita.s_ld_quantita_selezionata) or (us_dati_partita.s_ld_quantita_selezionata=0))) then
				
				
					ll_id_titolo=getitemdecimal(getrow(), "id_titolo")
					if ll_id_titolo>0 and not isnull(ll_id_titolo) then
					
						post event ue_post_itemch_cond(row, "quantita", dec(data))
					end if
				
				end if
				
			end if
			
				
		end if	
		post wf_calcola_prezzo(row)
		post wf_setta_fino_calo(row)
	
	case  "riga_documento_dim_l" 
		
		if isnull(data) then 
			return 1
		end if
		
		POST WF_METTI_DESCRIZIONE(ROW)
		
		ld_peso_originale=getitemdecimal(row, "riga_documento_peso_netto")
		
		if ld_peso_originale>0  then return
	
	
	
	
	ld_qta_1=getitemdecimal(row, "quantita")
	if ld_qta_1 > 0 then
  		ld_conv_misura=getitemdecimal(row, "conversione_volume_comune")
		if ld_conv_misura=0 or isnull(ld_conv_misura) then ld_conv_misura=1
		ll_id_uc=getitemnumber(row, "riga_documento_id_unita_confezione")
		select peso_netto, dim_l
		into  :ld_peso_uc, :ld_dim_uc
		from unita_confezione
		where id_unita_confezione= :ll_id_uc;
		if ld_dim_uc>0 then
			ld_conv_mis_peso=ld_peso_uc/ld_dim_uc
		else
			ld_conv_mis_peso=1
		end if
		ld_peso_gr=ld_qta_1*ld_conv_misura*ld_conv_mis_peso*dec(data)
	
		if  ld_peso_gr > 0  then 
			setitem(row, "riga_documento_peso_netto", ld_peso_gr)
			li_ret=wf_gestione_partite(row, ld_peso_gr, ld_peso_originale, ld_null)
			if li_ret=10 then	wf_setta_fino_calo(row)
			if isvalid(us_dati_partita.s_dw_aper_partita) and (isnull(us_dati_partita.s_ld_quantita_selezionata) or (us_dati_partita.s_ld_quantita_selezionata=0)) then
			
				
				
			else
				post wf_setcolumn_prezzo()
			end if
		end if
		post wf_calcola_prezzo(row)
		
	end if	
	
	
case "forza_chius_evasione"
	wf_forza_chius_evasione(row, data)
case "riga_documento_peso_lordo", "riga_documento_provv_imp_carea_2", "riga_documento_provv_imp_agente_2"
	
	//questo lo commento perché NON è pèiù valido e spero non dia problemi....2020 08 26
//	ld_peso_gr=dec(data)
//	select peso_laccio, peso_filo_rame
//	into :ldc_peso_laccio, :ldc_peso_filo_rame
//	from dba.orafo_par_sistema
//	;
//	if isnull(ldc_peso_laccio) then ldc_peso_laccio=0.47
//	if isnull(ldc_peso_filo_rame) then ldc_peso_filo_rame=1
//nuovo sistema 2020 08 26
	ldt_data_doc=idw_gen.getitemdate(1, "data_documento")
	select prezzo into :ldc_peso_laccio from dba.laccio_filo_rame where codice='L' and da_data<=:ldt_data_doc and a_data>=:ldt_data_doc;
	if isnull(ldc_peso_laccio) then messagebox("Attenzione!", "Peso Laccio NON trovato: controlla storico prezzi lacci e filo!")
	select prezzo into :ldc_peso_filo_rame from dba.laccio_filo_rame where codice='F' and da_data<=:ldt_data_doc and a_data>=:ldt_data_doc;
	if isnull(ldc_peso_filo_rame) then messagebox("Attenzione!", "Peso FILO RAME NON trovato: controlla storico prezzi lacci e filo!")
	ld_peso_gr=dec(data)
	
	if dwo.name="riga_documento_provv_imp_carea_2" then
		ld_peso_gr*=ldc_peso_laccio //peso di un laccio
	end if
	if dwo.name="riga_documento_provv_imp_agente_2" then 
		ld_peso_gr*=ldc_peso_filo_rame //peso filo rame
	end if


	//solo per samy 19-10-2015 arrotondo il peso all'intero (senza decimali sempre per eccesso)
	//commento tutto perché senza senso arrotondare al superiore la tara.... 2020-12-02
//	ll_id_titolo=getitemnumber(row, "id_titolo")
//	select codice
//	into :ls_metallo
//	from dba.orafo_metallo m, dba.orafo_titolo t
//	where t.id_metallo=m.id_metallo
//	and t.id_titolo=:ll_id_titolo
//	;
//	if ls_metallo<>'AU' then
//		select codice
//		into :ls_cod_azienda
//		from dba.azienda
//		;
//		ll_id_utente=idw_gen.getitemnumber(1, "documento_id_utenti")
//		
//		//utente deve essere diverso da Elisa (39)
//		//e NON deve essere un doc di entrata (tipo <> "DA")
//		if left(ls_cod_azienda, 6)="SILVER" and ll_id_utente<>39 and is_tipo_registro<>"DA"  then
//			ld_peso_gr=ceiling(ld_peso_gr)
//			data=string(ld_peso_gr)
//			post setitem(row, "riga_documento_peso_netto", ld_peso_gr)
//		end if
//	end if	
	//fine modifica per samy
		
	ld_peso_originale=getitemdecimal(row, "riga_documento_peso_netto")
	//controllo se la tara è maggiore del peso, se è così non accetto il cambiamento
	if ld_peso_originale - ld_peso_gr >0 then
		POST WF_TOGLI_TARA(ROW, ld_peso_originale - ld_peso_gr, dwo)
	else
		return 1
	end if
case "id_gruppo_agenti_2"
	post wf_rec_galvanica(data, row)
	post wf_calcola_prezzo(row)
case "cartellino"
	ls_cod=getitemstring(row, "c_articolo_cod")
	if ls_cod<" " or isnull(ls_cod) then
		ll_id_cat_merc=long(data)
		select a.codice into :ls_cod from dba.cat_merceologica c, dba.articolo a  where c.id_anag_modello=a.id_articolo
		and c.id_cat_merceologica=:ll_id_cat_merc;
		trigger event itemchanged(row, this.object.c_articolo_cod, ls_cod)
	end if

end choose
end event

event dw_riga_documento_ordine_gd::ue_insert;call super::ue_insert;
long ll_id_caus_magazzino
string ls_cod_tipo_partita,ls_ret
integer li_num_riga
long ll_riga

ll_id_caus_magazzino=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_caus_magazzino")
ls_cod_tipo_partita=wf_trova_cod_tipo_partita(ll_id_caus_magazzino)
if left(ls_cod_tipo_partita, 1)='S' then
	post wf_crea_id_riga_partita(getrow())
end if
	
	select proponi_prezzo_manifattura
	into :ls_ret
	from caus_magazzino
	where id_caus_magazzino=:ll_id_caus_magazzino;
	setitem(getrow(), "proponi_prezzo_manifattura", ls_ret)

post setfocus()

//250208
if getrow()>0 then
	li_num_riga=getitemnumber(getrow(), "riga_documento_num_riga")
	ll_riga=dw_nota_riga.insertrow(0)
	dw_nota_riga.setitem(ll_riga, "num_riga", li_num_riga)
	dw_nota_riga.scrolltorow(ll_riga)
end if
return getrow()


end event

event dw_riga_documento_ordine_gd::ue_use_search;long ll_id_articolo, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value, ll_id_tab_iva
decimal ldc_ret_value
date ld_comp
string ls_simbolo
dwItemStatus	ldw_status
string ls_utilizzabile
decimal{4} ld_peso_lordo, ld_peso_netto
long row, ll_id, ll_id_uc, ll_id_dest
integer li_riga_fine, li_riga_inizio, i, li_ret
string ls_um, ls_art_variante
decimal ldc_conv_peso, ldc_conv_volume
long ll_soggetto, ll_id_unita_conf, ll_id_prof_documento


ll_row= GetRow()

long	ll_id_art_o, ll_id_prof_doc
ll_id_art_o = this.getitemnumber(ll_row, "riga_documento_id_articolo")
if isnull(ll_id_art_o) then ll_id_art_o = 0

this.Object.DataWindow.Selected.Mouse = "Yes"

CHOOSE CASE as_nomecol
	CASE "c_articolo_cod"
			ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
			ll_id_dest=idw_gen.getitemnumber(1, "id_destinazione")
			f_controlla_art_destinazione(is_ricpar.s_main_value, ll_id_prof_doc,ll_id_dest)
			ls_art_variante=wf_varianti_set(is_ricpar.s_main_value, getrow())
			if ls_art_variante>" " then
				is_ricpar.s_main_value=ls_art_variante
				//select per recuperare tutti i valori di sotto 
				
				select a.id_articolo, a.descrizione, a.stato, 
				m1.simbolo, m1.descrizione,
				m2.simbolo, m2.descrizione,
				m1.conversione, m2.conversione,
				u.id_unita_confezione
							
				into :ll_id_articolo, :is_ricpar.s_ausil_value[1],:is_ricpar.s_ausil_value[2],
						:is_ricpar.s_ausil_value[3],:is_ricpar.s_ausil_value[4],
						:is_ricpar.s_ausil_value[5], :is_ricpar.s_ausil_value[6],
						:ldc_conv_peso, :ldc_conv_volume,
						:ll_id_unita_conf
				
				
				from dba.articolo a, dba.unita_confezione u, unita_misura m1, unita_misura m2
				where a.codice=:ls_art_variante
				and a.id_articolo=u.id_articolo
				and u.unita_base='S'
				and u.id_unita_misura=m1.id_unita_misura
				and u.id_unita_mis_volume=m2.id_unita_misura;
				is_ricpar.s_id_seg_value[1]=string(ll_id_articolo)
				is_ricpar.s_ausil_value[7]=string(ldc_conv_peso)
				is_ricpar.s_ausil_value[8]=string(ldc_conv_volume)
				is_ricpar.s_ausil_value[9]=string(ll_id_unita_conf)
			end if
			ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
			LI_RET=wf_controlla_utilizzabile(ll_id_articolo)
			IF LI_RET=-1 THEN
				RETURN
			END IF
		
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("riga_documento_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("c_articolo_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("articolo_stato", is_ricpar.s_ausil_value[2])
		uf_set_colval("usimbolo", is_ricpar.s_ausil_value[3])
		uf_set_colval("udescrizione", is_ricpar.s_ausil_value[4])
		uf_set_colval("unita_misura_b_simbolo", is_ricpar.s_ausil_value[5])
		uf_set_colval("unita_misura_b_descrizione", is_ricpar.s_ausil_value[6])
		uf_set_colval("conversione_peso_comune", is_ricpar.s_ausil_value[7])
		uf_set_colval("conversione_volume_comune", is_ricpar.s_ausil_value[8])
		uf_set_colval("riga_documento_id_unita_confezione", is_ricpar.s_ausil_value[9])
		
		
		
		
		if (ll_id_art_o <> ll_id_articolo) then event ue_set_arti_riga()
		
		post event ue_set_contropartita()
		post event ue_set_calc_riga(ll_row)
		ldw_status = GetItemStatus( ll_row,0,Primary! )
		if ldw_status = New! or ldw_status = NewModified! then
			post uf_scaglione_provvigione() 
		end if	
		
		post	wf_inserisci_pesi_riga(0)
		
		li_riga_inizio=ll_row
		li_riga_fine=ll_row
		wf_impongo_magazzino(li_riga_inizio, li_riga_fine)
		
		
		if (ll_id_art_o <> ll_id_articolo) then post wf_cal_costi()
		
		
		
		ll_id_uc=long(is_ricpar.s_ausil_value[9])
		select tipo,simbolo
		into :ls_um,:ls_simbolo
		from unita_confezione, unita_misura
		
		where (unita_confezione.id_unita_confezione=:ll_id_uc) and
		(unita_misura.id_unita_misura=unita_confezione.id_unita_misura);
		
		uf_set_colval("tipo_um", ls_um)	
		uf_set_colval("simbolo_mov", ls_simbolo)		
	
			

		
		if is_prof_dispo='C' or is_prof_dispo='B' then post uf_pre_blocca_dispo(this.getrow())
		

	//280910 per recupero samy costo galvanica (prezzo metallo per ora)
		post wf_prezzo_galvanica(ll_row, is_ricpar.s_main_value)
	//per gestione finestra saldi a pz (se cambia art cambia saldo)
			post wf_ric_giac_partita_pezzo()
//		if  isvalid(w_giacenza_pz) then
//			w_giacenza_pz.w_leggi_saldo(ll_id_articolo)
//		end if
		post wf_car_nota_art_in_produzione(getrow())
		//02072015
		post setcolumn("coef_calo")
		//21102015 per samy
		post wf_rec_des_aggiuntiva(ll_row, ll_id_articolo, "")
		//211015 fine
		//se kagalv o krgalv allora controllo se hanno galvanica "speciale"
		ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
		post wf_KA_KR_rec_galvanica(ll_row, is_ricpar.s_main_value, ll_id_prof_documento)
		
		post wf_cartellino(ll_row)
		
	CASE "riga_documento_descrizione"
		ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
		LI_RET=wf_controlla_utilizzabile(ll_id_articolo)
		IF LI_RET=-1 THEN
				
				RETURN
			END IF
		
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("c_articolo_des", is_ricpar.s_main_value)
		
		
		uf_set_colval("articolo_stato", is_ricpar.s_ausil_value[2])
		
		
		
		uf_set_colval("usimbolo", is_ricpar.s_ausil_value[3])
		uf_set_colval("udescrizione", is_ricpar.s_ausil_value[4])
		uf_set_colval("unita_misura_b_simbolo", is_ricpar.s_ausil_value[5])
		uf_set_colval("unita_misura_b_descrizione", is_ricpar.s_ausil_value[6])
		uf_set_colval("conversione_peso_comune", is_ricpar.s_ausil_value[7])
		uf_set_colval("conversione_volume_comune", is_ricpar.s_ausil_value[8])
		uf_set_colval("riga_documento_id_unita_confezione", is_ricpar.s_ausil_value[9])
		
		
		if (ll_id_art_o <> ll_id_articolo) then event ue_set_arti_riga()
		
		post event ue_set_contropartita()
		post event ue_set_calc_riga(ll_row)
		ldw_status = GetItemStatus( ll_row,0,Primary! )
		if ldw_status = New! or ldw_status = NewModified! then
			post uf_scaglione_provvigione() 
		end if	
		
		post wf_inserisci_pesi_riga(0)
		
		li_riga_inizio=ll_row
		li_riga_fine=ll_row
		wf_impongo_magazzino(li_riga_inizio, li_riga_fine)
		
		
		if (ll_id_art_o <> ll_id_articolo) then post wf_cal_costi()
		
		
		select tipo
		into :ls_um
		from unita_confezione, unita_misura
		where (unita_confezione.id_articolo=:is_ricpar.s_id_seg_value[1])and
		(unita_misura.id_unita_misura=unita_confezione.id_unita_misura);
		uf_set_colval("simbolo_mov", ls_um)	
				
		if is_prof_dispo='C' or is_prof_dispo='B' then post uf_pre_blocca_dispo(this.getrow())

		//21102015 per samy
		post wf_rec_des_aggiuntiva(ll_row, ll_id_articolo, "")
		//211015 fine
		
END CHOOSE

if IsValid(ids_lotti) then
	ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
	CHOOSE CASE as_nomecol
	CASE "c_articolo_cod"
		row=getitemnumber(ll_row,"id_riga_lotto")
		i= ids_lotti.find("numero = "+string(row),1, ids_lotti.rowcount())
		if i>0 then	
			li_ret=ids_lotti.SetItem(i,"id_articolo", ll_id_articolo)
			if li_ret<>1 then messagebox("Errore", "Non settato id_articolo in lotto")
		else
			messagebox("Errore","Lotto non trovato")
		end if
		
		if this.dataobject <> "d_riga_documento_ordine_ritorno_gd" then wf_carico_lotti(ll_row, ll_id_articolo)
		
	CASE "riga_documento_descrizione"
		row=getitemnumber(ll_row,"id_riga_lotto")
		i= ids_lotti.find("numero = "+string(row),1, ids_lotti.rowcount())
		if i>0 then	
			ids_lotti.SetItem(i,"id_articolo",ll_id_articolo)
		else
			messagebox("Errore","Lotto non trovato")
		end if
		
		if this.dataobject <> "d_riga_documento_ordine_ritorno_gd" then wf_carico_lotti(ll_row, ll_id_articolo)
		
	end choose
end if

end event

event dw_riga_documento_ordine_gd::itemfocuschanged;call super::itemfocuschanged;
long ll_id_articolo, ll_id_caus
decimal ld_test
date data_reg
string ls_proponi_prezzo_metallo, ls_cod_prof
long ll_id_riga, ll_id_prof

setnull(data_reg)

choose case string(dwo.name)

	
case "riga_documento_peso_lordo" 
	if cbx_tara.checked then
		ll_id_riga=idw_riga.getitemnumber(row, "id_riga_documento")
		openwithparm(w_tara_dettaglio, ll_id_riga)
	end if
		ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
		ls_cod_prof=idw_gen.getitemstring(1, "c_prof_doc_cod")
		if ll_id_prof=188 and upper(ls_cod_prof)="VERIFICA" then
			post setcolumn("riga_documento_provv_imp_carea_2")
		end if
case  "prezzo_metallo" 
		ld_test=getitemdecimal(row, "prezzo_metallo")
		if ld_test=0 or isnull(ld_test) then
		
		ll_id_caus=getitemnumber(row, "riga_documento_id_caus_magazzino")
		select proponi_prezzo_metallo
		into :ls_proponi_prezzo_metallo
		from caus_magazzino
		where id_caus_magazzino=:ll_id_caus;
		if ls_proponi_prezzo_metallo='S' then 
			ll_id_articolo=getitemnumber(row, "riga_documento_id_articolo")
			setnull(ld_test)
			wf_propone_prezzo_metallo(ll_id_articolo, data_reg,ld_test)
			wf_calcola_prezzo(row)
		 end if
	end if
	case "riga_documento_peso_netto"   
		ld_test=getitemdecimal(row, "riga_documento_peso_netto")
		ll_id_articolo=GETITEMNUMBER(row, "riga_documento_id_articolo")
		if ld_test=0  and ll_id_articolo>0 then 
			post event itemchanged(row,dwo, '0')
		end if
 

	case "coef_calo" 
		string ls_cod_prof_doc
		ls_cod_prof_doc=idw_gen.getitemstring(1, "c_prof_doc_cod")
		//se è ordcli il profilo sposto il cursore sulla lunghezza (misura)
		if ls_cod_prof_doc='ORDCLI' then
			post setcolumn("riga_documento_dim_l")
		else
				
		end if
		
end choose
end event

event dw_riga_documento_ordine_gd::updatestart;call super::updatestart;//20250103 TOLGO TUTTO E SEMMAI LO RISPOSTO A LIVELLO DI MODIFICA DELLA RIGA, MAI PIù NEL SALVATAGGIO DI TUTTE LE RIGHE (2000 E PIù)

long  ll_righe, i, ll_id, ll_riga_doc, ll_id_loc2
long  ll_id_doc, ll_id_caus_magazzino 
long  ll_id_doc1 
decimal{2} ld_qta, ld_qta_evasa, ld_prezzo_complessivo, ldc_saldo, ldc_peso,ldc_coef_calo
boolean lb_ordinato_fo
string ls_um, ls_test, ls_campo, ls_test_fino_calo, ls_eccezione_inizio_anno
integer li_ret
long ll_id_riga_cliente, ll_id_riga_nulla
datastore ds_controlla_doppi
decimal ldc_variazione, ldc_prezzo
long ll_id_sog, ll_id_art, ll_test, ll_id_prof_doc

//wf_spese_confezionamento()



//100313 RICALCOLO CASTELLETTO IVA E SCADENZE
//20261028 come nella 64: TRIGGER e non POST, il castelletto deve essere pronto PRIMA che si salvi (cb_salva e antenato non lo rifanno piu')
TAB_1.TABPAGE_4.CB_RICALCOLA_CAST.TRIGGEREVENT(CLICKED!)

//20261028 fino e calo: l'itemchanged li ricalcola con un POST, che arriva DOPO il salvataggio
//se si preme Salva subito dopo aver scritto peso o coef calo (si salvava il coef nuovo col fino/calo vecchio).
//Solo le righe con peso o coef cambiati, non tutte (vedi nota 20250103 qui sopra)
for i=1 to rowcount()
	if getitemstatus(i, "coef_calo", Primary!)=DataModified! or getitemstatus(i, "riga_documento_peso_netto", Primary!)=DataModified! then
		wf_calcola_fino_calo(i)
	end if
next

//select controlla_fino_calo
//into :ls_test_fino_calo
//from dba.orafo_par_sistema
//;
//ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
//ll_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.RowCount()
//for li_ret=1 to ll_righe
//	ls_um=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemString(li_ret,"riga_documento_descrizione")
//	ls_um=trim(ls_um)
//	tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(li_ret,"riga_documento_descrizione",ls_um)
//	
//	if tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.&
//									getItemdecimal(li_ret,"imp_metallo_val") < -0.1 then
//		messagebox("Attenzione!", "Importo metallo < 0! Riga n° "+string(Li_ret)+&
//						"~r~nContattare Assistenza!")
//	end if	
//	
//	//23-06-2019 se è bol coef-calo=1000
//	if ll_id_prof_doc=65 then //profilo doc="BOL"
//		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setItem(li_ret,"coef_calo", 1000)
//	end if
//	//inserito per silverdreams 200911
//	ldc_peso=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemdecimal(li_ret,"riga_documento_peso_netto")
//	if ls_test_fino_calo='S' then
//		//ldc_peso=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemdecimal(li_ret,"riga_documento_peso_netto") 20230324 spostato sopra mi serve anche più in giù
//		ldc_coef_calo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemdecimal(li_ret,"coef_calo")
//		wf_setta_fino_calo(li_ret, ldc_peso, ldc_coef_calo)
//	end if
	//fine 200911
	//18-02-13 per samy maggiorazione se qta min <500 ... è sulla "pb_listini"
	//250713 modifico: cambio il campo da_stampare con valoriz_peso_non_prezioso
//	ll_test=idw_riga.getitemnumber(li_ret, "valoriz_peso_non_prezioso")
//	select vrbol_no_maggiorazione into :ls_eccezione_inizio_anno from dba.orafo_par_sistema;
//	//ls_test=idw_riga.getitemstring(li_ret, "riga_documento_da_stampare")
//	//20230127 se il profilo è VRBOL(116) elisa, all inizio dell anno, deriva roba già prezzata e non deve riprezzare nulla... corretto il 20210206 con parametro in parametri di sistema orafo
//	//20231211 aggiunto fatlav (47) ai profili esclusi dalla maggiorazione NC o ND uguale non fa nulla (54 e 158)
//	if ll_test=1 or( ll_id_prof_doc=116 and ls_eccezione_inizio_anno='S' or ll_id_prof_doc=158 or ll_id_prof_doc=54) or ldc_peso=0 or isnull(ldc_peso) or (ll_id_prof_doc=12 or  ll_id_prof_doc=64 or ll_id_prof_doc=47)  then	
//		//brutto ma ho fretta e non mi viene nulla di estetico...					//20231120 se è NC o ND NON deve fare nulla
//	elseif ll_test<> 1 then
//	//if ls_test<> "S" then
//		ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
//		ll_id_art=idw_riga.getitemdecimal(li_ret, "riga_documento_id_articolo")
//		ldc_peso=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemdecimal(li_ret,"riga_documento_peso_netto")
//		ldc_variazione= f_applica_maggiorazione(ll_id_art, ll_id_sog, ldc_peso)
//		
//		if ldc_variazione>0 then
//			ldc_prezzo=idw_riga.getitemdecimal(li_ret, "prezzo_manifattura")
//			ls_campo="prezzo_manifattura"
//			if isnull(ldc_prezzo) or ldc_prezzo=0 then
//				ldc_prezzo=idw_riga.getitemdecimal(li_ret, "prezzo_complessivo")
//				ls_campo="prezzo_complessivo"
//			end if
//			if ldc_prezzo>0 then
//				//idw_riga.modify(ls_campo+".color=255") no colora tutti i campi di rosso ....invece solo quello toccato ...
//				//250713 modifico: cambio il campo da_stampare con valoriz_peso_non_prezioso
//				idw_riga.setitem(li_ret, "valoriz_peso_non_prezioso", 1)
//				//idw_riga.setitem(li_ret, "riga_documento_da_stampare", "S")
//				idw_riga.setitem(li_ret, ls_campo, ldc_prezzo+(ldc_prezzo*ldc_variazione/100))
//			end if	
//			//bisogna ricalcolare il prezzo .... 070313 NO l'importo riga non il prezzo, altrimenti un sè fatto nulla....
//		//	tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_riga(li_ret)
//			wf_calcola_prezzo(li_ret)
//		end if
//	end if
	//fine aggiunta 180213

//next

if is_tipo_registro='OV' AND LL_RIGHE>0 then

	ds_controlla_doppi=create datastore
	ds_controlla_doppi.dataobject="d_orafo_righe_doppie"
	ds_controlla_doppi.settransobject(sqlca)
	LI_RET=this.rowscopy(1, ll_righe, primary!, ds_controlla_doppi, 1, primary!)
	IF LI_RET=1 THEN
		ds_controlla_doppi.sort()
		LI_RET=ds_controlla_doppi.GETITEMNUMBER(ds_controlla_doppi.rowcount(), "SOM_CONTROLLO")
		if li_ret>0 then
			messagebox("Attenzione!","Esistono righe che possono essere raggruppate!")
		end if
	else	
		MESSAGEBOX("Errore", "Righe non copiate! (Up. Start, 41)")
	END IF
	DESTROY ds_controlla_doppi
END IF
long ll_id_riga
if isvalid(ids_righe_ordine) and not isvalid(ids_ord_cli_fo) then
	ids_ord_cli_fo=create datastore
	ids_ord_cli_fo.dataobject="ds_ord_cli_fo"
	ids_ord_cli_fo.settransobject(sqlca)
	setnull(ll_id_riga_nulla)
	for i= 1 to rowcount()
		ids_ord_cli_fo.insertrow(i)
		ll_id_riga_cliente=getitemnumber(i, "id_riga_documento")
		ids_ord_cli_fo.setitem(i, "id_riga_ord_cliente", ll_id_riga_cliente)
		setitem(i, "id_riga_documento", ll_id_riga_nulla)
	next
		
end if
//inserire controllo se saldo<0  10-03-09
if isvalid(w_saldo_doc_pop) then
	ls_test=""
	select segnala_saldo_negativo
	into :ls_test
	from dba.orafo_par_sistema;
	if ls_test='S' then
		for i=1 to w_saldo_doc_pop.dw_1.rowcount()
			ldc_saldo=w_saldo_doc_pop.dw_1.getitemdecimal(i, "somma_prog_grammi")
			if ldc_saldo<0 then
				if messagebox("Attenzione!", "Il saldo è minore di zero: salvare comunque?", StopSign!, YesNo!) <>1 then
					return 1
				else
					exit
				end if
			end if
		next
	end if
end if
	

end event

event dw_riga_documento_ordine_gd::ue_post_itemchanged;call super::ue_post_itemchanged;

tab_1.tabpage_2.dw_riga_documento_ordine_gd.setrow(al_riga)
setcolumn(as_colonna)


end event

event dw_riga_documento_ordine_gd::ue_initial;call super::ue_initial;date 				ld_data_prev_consegna
decimal 			ldc_cambio

long				ll_id_magazzino, ll_row, ll_numero, ll_id_valuta, ll_righe, ll_count, ll_nriga
long				ll_id_listino, ll_id_caus_magazzino, ll_id_locazione, ll_id_agente, ll_id_prof_doc
string ls_pi_azienda,ls_azienda

ll_row = GetRow()

ld_data_prev_consegna = idw_gen.GetItemDate(il_row,"data_prev_consegna")
SetItem(ll_row, "riga_documento_data_prevista_consegna", ld_data_prev_consegna)
//SE SIAMO IN UN ORDINE SILVER METTO L'ID-DOCUMENTO DELL'ORDINE IN ID_RIGA-SORGENTE
//COS' CON LA DERIVAZIONE ME LO PORTA IN GIRO E POSSO RIUNIRE TUTTO SOTTO LìORDINE
//NELLA STAMPA 160610  22-01-13: per me non funge più ...
WF_INSERISCI_ID_ORDINE(LL_ROW)


post wf_setto_id_riga_sorgente()



uf_set_mask_riga()
wf_setta_mask_riga()





select rag_soc_1
into :ls_azienda
from dba.azienda
;


//inserito per samy 23-12 e 28-12-13
if pos(upper(ls_azienda), "SILVER D")>0  then
	post wf_art_aut_del_fornitore()
	ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
	if ll_id_prof_doc=188 then
		idw_riga.trigger event itemchanged(idw_riga.getrow(), idw_riga.object.c_articolo_cod, "A+")
		idw_riga.post setcolumn("riga_documento_peso_netto")
	end if
end if
//20210409 provo a salvare la riga appena inserita (non dovrebbe compremettere nulla)
//		ib_askforsave=false
//		idw_riga.accepttext()
//		idw_riga.post event ue_key(KEYS!,2)
if  tab_1.tabpage_2.dw_des_aggiuntiva.visible=true and cb_reso_non_lavorato.text='RESO' then //post wf_sinc_des_agg(getrow())
		post wf_salva_automaticamente()
		post wf_sinc_des_agg(ll_row)
end if
	
	// 23022021
	



//per Munna 220617   13-03-19 ora un lo vol più ....mah ....
//select par_iva
//into :ls_pi_azienda
//from dba.azienda
//;
//if ls_pi_azienda="02252270513"  then post wf_cod_barre_bollettine()
//fine munna
//se profilo=159 allora deve mettere "A" sul campo galvanica ("id_gruppo_agenti_2"), se 160 invece mette  "R"
////solo per Samy
//select codice
//into :ls_pi_azienda
//from dba.azienda
//;
//if ls_pi_azienda='SILVERDR' then
//	ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
//	if ll_id_prof_doc=159 then
//		setitem(ll_row, "id_gruppo_agenti_2", 5)
//	elseif ll_id_prof_doc=160 then
//		setitem(ll_row, "id_gruppo_agenti_2", 10)
//	end if
//end if
//

end event

event dw_riga_documento_ordine_gd::ue_modify;	decimal ld_qta1, ld_qta2, ld_peso1, ld_peso2
	long ll_id_unita_confezione1, ll_id_unita_confezione2
	long ll_riga
	
	ll_riga=getrow()
	
	
	ll_id_unita_confezione1= Getitemnumber(ll_riga, "riga_documento_id_unita_confezione")
	ld_qta1= Getitemdecimal(ll_riga, "quantita")
	ld_peso1= Getitemdecimal(ll_riga, "riga_documento_peso_netto")
	
CALL SUPER::ue_modify

	ll_id_unita_confezione2= Getitemnumber(ll_riga, "riga_documento_id_unita_confezione")
	ld_qta2= Getitemdecimal(ll_riga, "quantita")
	ld_peso2= Getitemdecimal(ll_riga, "riga_documento_peso_netto")

	if  (ll_id_unita_confezione1<>ll_id_unita_confezione2 or &
		ld_peso1<>ld_peso2 or ld_qta1<>ld_qta2) then
		post wf_integra_autofind(ll_riga)
		post event ue_rec_prezzo(ll_riga, dec(ld_qta2))
		post wf_calcola_prezzo(ll_riga)
		
	end if
	

wf_setta_mask_riga()
end event

event dw_riga_documento_ordine_gd::ue_set_calc_riga;
decimal  ld_importo_sconto_riga, ld_pr_complessivo, ld_importo_man
decimal		ld_QTA_UB, ld_QTA, ld_QTA_SM, ld_Prezzo_Netto, ld_Sconti, ld_Totale_Riga
decimal		ld_Cambio, ld_Sconto_Riga, ld_QTA_Evasa_UB, ld_Qta_Evasa, lcd_null
decimal		ld_Prezzo, ld_Quantita, ld_Totale_Riga_Lire, ld_Qta_Effettiva, ld_Totale_Riga_val
string		ls_Sconto, ls_tipoconv, ls_tipo_arrotondamento,ls_rag_soc
decimal		ld_fatconv, ld_fatglob, ld_molt, ld_cambio_riga, ld_cambio_documento
long			ll_row, ll_id_valuta_riga, ll_valuta_documento, ll_nr_cifre_arrot, ll_id_prof_doc, ll_id_sog
string 		ls_um
decimal		ldc_Totale_Riga_Lire, ldc_Totale_Riga_val, ld_importo_manifattura, ld_importo_metallo
decimal		ld_legato, ld_fino_calo

if isnull(al_row) or al_row=0 then return 0
ll_row= al_row
SetNull(lcd_null)
ls_tipoconv = GetItemString(ll_row,"c_unita_conf_tipo_conversione")
ld_fatconv = uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
ld_molt =uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
if ls_tipoconv = "D" then
	if ld_fatconv <> 0 then
		ld_fatglob = 1/ld_fatconv
	else
		ld_fatglob = 0
	end if
else
	ld_fatglob = ld_fatconv
end if
ld_fatglob = ld_fatglob * ld_molt
SetItem(ll_row,"fat_con_globale",string(ld_fatglob))

ls_Sconto= dw_riga_documento_dett_ord_ff.getitemstring(ll_row, "sconto")
ld_QTA = uf_GetItemDecimal(ll_row, "quantita")
if IsNull(ld_QTA) then ld_QTA=0
if uf_calcola_prezzo(ls_Sconto, 1000000, 1) = 0 then
	ld_QTA_SM= 0 
	SetItem(ll_row, "qta_sconto_merce", 0)
else
	ld_QTA_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
	if IsNull(ld_QTA_SM) then ld_QTA_SM=0
end if
ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
SetItem(ll_row, "qta_un_base", ld_QTA_UB)

ld_Qta_Evasa= uf_GetItemDecimal(ll_row, "qta_evasa")
if IsNull(ld_Qta_Evasa) then ld_Qta_Evasa=0
ld_QTA_Evasa_UB = ld_Qta_Evasa * ld_FatGlob
SetItem(ll_row, "qta_evasa_un_base", ld_QTA_Evasa_UB)
ld_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
if IsNull(ld_Prezzo) then ld_prezzo = 0

ll_valuta_documento= idw_gen.GetItemNumber(il_row, "documento_id_valuta_des")
ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")

ld_cambio_riga= GetItemdecimal(ll_row, "riga_documento_cambio")
if IsNull(ld_cambio_riga) then ld_cambio_riga=1
ls_um=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(al_row,"tipo_um")
ld_importo_sconto_riga=getitemdecimal(ll_row, "riga_documento_sconto_riga")
if ls_um='P' then
	ld_Prezzo_Netto= ld_prezzo
	
	if not isnull(ld_importo_sconto_riga) then
		ld_prezzo_netto=ld_prezzo_netto - ld_importo_sconto_riga
	end if
		
	
	ld_Prezzo_Netto=uf_Round(ld_Prezzo_Netto)
	if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0
	
	SetItem(ll_row, "riga_documento_prezzo_netto",ld_Prezzo_Netto)
	
	SetItem(ll_row, "tot_riga_val_riga",ld_Prezzo_Netto)
	
	
	if IsNull(ld_cambio_riga) OR ld_cambio_riga=0 then ld_cambio_riga=1
	
	SELECT "valuta"."dec_significativi",
	"valuta"."tipo_arrotondamento"
	INTO :ll_nr_cifre_arrot ,
			:ls_tipo_arrotondamento
	FROM "dba"."valuta"  
	WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
	
 ldc_Totale_Riga_Lire= f_round(ld_Prezzo_Netto * ld_cambio_riga, ll_nr_cifre_arrot, ls_tipo_arrotondamento) 
//	ldc_Totale_Riga_Lire= f_round(ld_Prezzo_Netto / ld_cambio_riga, ll_nr_cifre_arrot, ls_tipo_arrotondamento) 

	SetItem(ll_row, "tot_riga_val_az",ldc_Totale_Riga_Lire)
	
	
	if ll_id_valuta_riga = ll_valuta_documento then
		SetItem(ll_row, "tot_riga_val_doc",ld_Prezzo_Netto)
	else
		
		if IsNull(idc_cambio) then idc_cambio=1
		//ldc_Totale_Riga_val= ld_Prezzo_Netto / idc_cambio
		ldc_Totale_Riga_val= ld_Prezzo_Netto * idc_cambio
		
		if IsNull(il_arrotondamento) then il_arrotondamento=0
		ldc_Totale_Riga_val= uf_round(ldc_Totale_Riga_val)
		
		SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga_val)
	end if
		
 		
		ld_QTA_effettiva= ld_QTA + ld_QTA_SM
		if ld_Qta_Effettiva>0 then SetItem(ll_row, "riga_documento_val_attribuito",ld_Prezzo_Netto / ld_Qta_Effettiva)
else
	ld_Prezzo_Netto=uf_calcola_prezzo(ls_Sconto, ld_prezzo, 1)
	SetItem(ll_row, "riga_documento_prezzo_netto",ld_Prezzo_Netto)
	
	event ue_set_calc_tot_riga(ll_row, lcd_null, ld_Prezzo_Netto, FALSE)
end if

return 0




end event

event dw_riga_documento_ordine_gd::ue_set_calc_tot_riga;
long			ll_row, ll_nr_cifre_arrot, ll_id_valuta_riga, ll_valuta_documento,ll_galvanica
string		ls_tipo_arrotondamento, ls_um, ls_codice_profilo
decimal		ldc_sconto_riga, ldc_totale_riga, ldc_Totale_Riga_val, ldc_Prezzo, ldc_Sconto
decimal		ldc_cambio, ldc_totale_riga_lire, adc_quantita_SM, adc_quantita_Effettiva
decimal		ld_quotazione, ld_fino_calo, ldc_solo_man, ld_peso

ll_row=al_row

if IsNull(adc_quantita) then adc_quantita= uf_GetItemDecimal(ll_row, "quantita")

if IsNull(adc_Prezzo_Netto) then	adc_Prezzo_Netto= uf_GetItemDecimal(ll_row, "riga_documento_prezzo_netto")

if not IsNull(adc_Prezzo_Netto) then 
	if IsNull(adc_quantita) then adc_quantita=0
		
	ldc_cambio= idc_cambio //GetItemNumber(ll_row, "riga_documento_cambio")  //modifica 20211024
	if IsNull(ldc_cambio) then ldc_cambio=1
		
	adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
		if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
		adc_quantita_Effettiva= adc_quantita - adc_quantita_SM
	
		ls_um=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(al_row,"tipo_um")
		if ls_um='P' then
			adc_quantita_Effettiva=1
		end if	
	
	ld_fino_calo=dw_riga_documento_dett_ord_ff.getitemdecimal(al_row, "fino_calo")
	ld_quotazione=getitemdecimal(al_row, "prezzo_metallo")
	
	if isnull(ld_quotazione) then ld_quotazione=0
	//14-02-14 se ilprofilo ="MRBOL" è galvanica
	//non è davvero quotazione e va moltiplicata per il peso, non per il puro
	//20221115 Samy dice che il coefcalo può non essere 1000 quindi guardiamo se c'è la galvanica e agiamo di conseguenza
	if tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_orafo_riga_documento_ordine_silver_gd" then
		ll_galvanica=idw_riga.getitemnumber(al_row, "id_gruppo_agenti_2")  //20221115
		ls_codice_profilo=idw_gen.getitemstring(1, "c_prof_doc_cod")
	
		if ll_galvanica>0 or ls_codice_profilo='MRBOL' or ls_codice_profilo='MFATLAV' then
			ld_peso=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(al_row,"riga_documento_peso_netto")
			ld_quotazione*=ld_peso
		else
			ld_quotazione*=ld_fino_calo
		end if
	else
		ld_quotazione*=ld_fino_calo
	end if
	//fine 14-02-14
		
	ldc_Totale_Riga= (adc_Prezzo_Netto * adc_quantita_Effettiva) 
	
	ldc_Sconto_Riga= dw_riga_documento_dett_ord_ff.getitemdecimal(ll_row, "sconto_riga")
	if IsNull(ldc_Sconto_Riga) then ldc_Sconto_Riga=0
	ldc_Totale_Riga=ldc_Totale_Riga - ldc_Sconto_Riga
	
	ldc_Totale_Riga= uf_Round(ldc_Totale_Riga)
	ldc_solo_man=ldc_Totale_Riga
	SetItem(ll_row,"importo_manifattura_val",ldc_solo_man)
	ld_quotazione=uf_round(ld_quotazione)
	ldc_Totale_Riga=uf_round(ld_quotazione+ldc_Totale_Riga)
	SetItem(ll_row, "tot_riga_val_riga",ldc_Totale_Riga)
	adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
	if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
	adc_quantita_Effettiva= adc_quantita + adc_quantita_SM
	if not(IsNull(adc_quantita_Effettiva) OR adc_quantita_Effettiva<=0) then SetItem(ll_row, "riga_documento_val_attribuito",ldc_Totale_Riga / adc_quantita_Effettiva)
	
	//if IsNull(ldc_Cambio) OR ldc_Cambio=0 then ldc_Cambio=1  //l'abbiamo già fatto sopra...
	SELECT "valuta"."dec_significativi",
		"valuta"."tipo_arrotondamento"
		INTO :ll_nr_cifre_arrot ,
				:ls_tipo_arrotondamento
		FROM "dba"."valuta"  
		WHERE "valuta"."id_valuta" = :al_id_val_az   ;
		//20211024 ripristino il cambio e elimino la parità per coerenza con quanto viene fatto in contabilità (w_reg_pd_cx)
	ldc_Totale_Riga_Lire=f_round(ldc_Totale_Riga * ldc_Cambio, ll_nr_cifre_arrot, ls_tipo_arrotondamento) 
	ldc_solo_man=f_round(ldc_solo_man*ldc_Cambio, ll_nr_cifre_arrot, ls_tipo_arrotondamento)
	//ldc_Totale_Riga_Lire=f_round(ldc_Totale_Riga / ldc_Cambio, ll_nr_cifre_arrot, ls_tipo_arrotondamento) 
	//ldc_solo_man=f_round(ldc_solo_man / ldc_Cambio, ll_nr_cifre_arrot, ls_tipo_arrotondamento)
	SetItem(ll_row, "tot_riga_val_az",ldc_Totale_Riga_Lire)
	SetItem(ll_row,"importo_manifattura",ldc_solo_man)
	
	SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga)

else
	adc_Prezzo_Netto=0
	SetItem(ll_row, "tot_riga_val_riga",0)
	SetItem(ll_row, "tot_riga_val_doc",0)
	SetItem(ll_row, "tot_riga_val_az",0)
end if
If ab_calc_sconto then
	ldc_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
	If not IsNull(ldc_Prezzo) OR ldc_Prezzo <> 0 then 
		ldc_Sconto= (ldc_Prezzo - adc_prezzo_netto) * 100 / ldc_Prezzo
		ldc_Sconto= Round(ldc_Sconto , 2)
		SetItem(ll_row, "sconto", String(ldc_Sconto))
	end if
	
end if


return 0



end event

event dw_riga_documento_ordine_gd::getfocus;call super::getfocus;
end event

event dw_riga_documento_ordine_gd::ue_rec_prezzo;//20261126 come nella 64_2025 (riorganizzazione del 02/07/2026), senza la parte Silver Dreams e Karizia:
//f_rec_prezzo_riga legge e calcola, qui si fanno i setitem. La variazione scritta sulla riga comanda: il prezzo si prende da lei.
//PRIMA questo evento azzerava SEMPRE prezzo e prezzo_manifattura all inizio e poi metteva il prezzo del listino anche quando
//era 0: le righe di articoli senza prezzo di listino restavano a zero (fattura 599 Labella). Le righe con la M (prezzo a mano)
//il REC non le passa nemmeno qui (cb_rec_prezzi). Il corpo di prima e' in fondo, commentato.
s_rec_prezzo	lstr
long				ll_row, ll_riga_testata
decimal			ldc_null
string			ls_sconto
boolean			lb_pc_nuovo     //prezzo_complessivo appena riscritto dal listino
decimal			ldc_rl_a, ldc_rl_b   //specchietto del REC: prezzo prima e dopo la maggiorazione per quantita
string			ls_rl_mot            //cosa e' successo al prezzo della riga (va in is_rl_mot)

setnull(ldc_null)

ll_row = row
if ll_row < 1 then ll_row = this.getrow()
if ll_row < 1 then return 0
lstr = f_rec_prezzo_riga(idw_riga, idw_gen, ll_row, qta, il_id_documento, &
	idc_cambio, al_id_val_az, "", is_tipo_arrotondamento, il_arrotondamento)

if lstr.l_esito <> 1 then return 0

if lstr.l_id_variazione > 0 then setitem(ll_row, "riga_documento_id_listino", lstr.l_id_variazione)

choose case lstr.s_tipo_prezzo
	case"PZ"	//prezzo pieno (UM diversa da 'P')
		setitem(ll_row, "prezzo", lstr.dc_prezzo)
		setitem(ll_row, "prezzo_complessivo", lstr.dc_prezzo)
		lb_pc_nuovo = true
	case "CO"	//solo prezzo complessivo
		setitem(ll_row, "prezzo_complessivo", lstr.dc_prezzo)
		setitem(ll_row, "prezzo_manifattura", ldc_null)
		lb_pc_nuovo = true
	case "MA"	//solo manifattura
		setitem(ll_row, "prezzo_manifattura", lstr.dc_prezzo)
		setitem(ll_row, "prezzo_complessivo", ldc_null)
	case "AZ"	//prezzo non valido: azzera entrambi
		setitem(ll_row, "prezzo_complessivo", ldc_null)
		setitem(ll_row, "prezzo_manifattura", ldc_null)
end choose

if lstr.b_set_sconto_riga then setitem(ll_row, "riga_documento_sconto_riga", lstr.dc_sconto_riga)

if lstr.b_set_sconto_perc then
	ls_sconto = getitemstring(ll_row, "sconto")
	if ls_sconto <= '0' or isnull(ls_sconto) then	//NON sovrascrive uno sconto gia' presente
		setitem(ll_row, "sconto", lstr.s_sconto_perc)
	end if
end if

if lstr.b_set_sconto_fin then
	ll_riga_testata = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
	tab_1.tabpage_1.dw_documento_ordine_ff.setitem(ll_riga_testata, "documento_sconto_finanziario", lstr.s_sconto_finanziario)
end if

//specchietto del REC: prezzo di listino appena ripreso
if ib_rl_attivo then
	ls_rl_mot = ""
	ldc_rl_a = getitemdecimal(ll_row, "prezzo_complessivo")
	if lb_pc_nuovo then
		if isnull(ldc_rl_a) then ls_rl_mot = "listino vuoto" else ls_rl_mot = "listino " + string(ldc_rl_a, "0.0000")
	elseif lstr.s_tipo_prezzo = "MA" then
		ls_rl_mot = "solo manifattura"
	elseif lstr.s_tipo_prezzo = "AZ" then
		ls_rl_mot = "prezzo non valido: azzerato"
	end if
end if
//180313/250713 flag per segnalare il prezzo aumentato da magg_qta_merce
setitem(ll_row, "valoriz_peso_non_prezioso", 0)
wf_magg_per_quantita(ll_row) //20241209 - window function, resta nel chiamante
if ib_rl_attivo then
	ldc_rl_b = getitemdecimal(ll_row, "prezzo_complessivo")
	if not isnull(ldc_rl_a) and not isnull(ldc_rl_b) then
		if ldc_rl_b <> ldc_rl_a then ls_rl_mot += "; magg. quantita' " + string(ldc_rl_b - ldc_rl_a, "+0.0000;-0.0000")
	end if
	if ll_row <= upperbound(is_rl_mot) then
		if not isnull(ls_rl_mot) then is_rl_mot[ll_row] = ls_rl_mot
	end if
end if
return 1

//20261126 CORPO DI PRIMA:


//string 			ls_tipo_applicazione	, ls_sconto	
//STRING			LS_SQL_SCRIPT				
//STRING			ls_app	, ls_app1					
//long 				ll_riga_corrente
//date 				ldt_data_attuale			
//long				ll_id_U_C_in_esame		
//long 				ll_sog_com					
//decimal		ld_prezzo	, ld_cambio				
//decimal{2}		ld_coef_calo
//long 				ll_listino					
//string			ls_percentuali				
//integer			li_ret
//long				ll_id_cat_com_sc			
//long				ll_id_art_in_esame		
//long 				ll_id_cat_com_articolo	
//decimal{4}		ld_qta						
//long           ll_sog_com_fornitore		
//long 				ll_id_produttore			
//long				ll_id_listino				
//string			ls_qta, ls_um
//long				ll_pos
//long 				ll_id_registro
//string   		ls_tipo_registro
//string 			ls_cod_art_in_esame		
//long 				ll_id_magazzino,ll_caus_magazzino
//long 				ll_id_titolo, ll_tipo_prezzo , ll_id_riga_padre , ll_id_prof
//decimal        ld_var_prezzo
//decimal		ld_var_calo ,ldc_prezzo_spazzo

//decimal{4} ld_legato, ld_fino, ld_calo 
//long ll_id_valuta_riga,ll_nr_cifre_arrot
//string ls_tipo_arrotondamento,ls_test, ls_rag_soc
//long ll_riga,ll_id_prof_doc, ll_id_sog

//setnull(ld_calo)
//setitem(row, "prezzo", ld_calo)
//setitem(row, "prezzo_manifattura", ld_calo)
////se è silverdreams ed è una riga esplosa (con id_riga-doc_padre>0 
////allora non si recupera il prezzo
//select rag_soc_1
//into :ls_test
//from azienda
//where id_azienda=1
//;
//if pos(ls_test, "Silver Dreams")>0 then
//	//aggiunto 02-05-2018 recupero flag prezzo confermato
//	ll_id_riga_padre=getitemnumber(row, "id_riga_doc_padre")
//	if ll_id_riga_padre>0 then
//		return 0
//	end if
//end if
//ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()

//if row>0 then
//	ll_riga=row
//else
//	ll_riga=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
//end if
//ll_caus_magazzino=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_riga,"riga_documento_id_caus_magazzino") 
//select tipo_valorizzazione
//into :ls_app
//from caus_magazzino
//where id_caus_magazzino=:ll_caus_magazzino;
//if ls_app='' or isnull(ls_app) then ls_app='V'

//ldt_data_attuale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(ll_riga_corrente, "data_registrazione")
//if isnull(ldt_data_attuale) then 
//	messagebox("Attenzione!", "Specificare la data del documento") 
//	return 0
//end if
//	ll_id_listino=getitemnumber(row, "riga_documento_id_listino")   //202231031 è la variazione
//	ll_sog_com=idw_gen.getitemnumber(1, "id_sog_commerciale")
//	if isnull(ll_id_listino) then
//		//ll_sog_com=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente, "id_sog_commerciale")
//		select id_cat_com_sc, id_listino
//		into :ll_id_cat_com_sc, :ll_id_listino
//		from sog_commerciale
//		where id_sog_commerciale = :ll_sog_com;
//	end if
//if isnull(ll_id_cat_com_sc) then ll_id_cat_com_sc=0
//if isnull(ll_id_listino) then ll_id_listino=0

//ll_id_art_in_esame=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_riga,"riga_documento_id_articolo")
//if isnull(ll_id_art_in_esame) then ll_id_art_in_esame=0
//ls_cod_art_in_esame=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(ll_riga, "c_articolo_cod")
//	select id_cat_com_articolo
//	into :ll_id_cat_com_articolo
//	from articolo
//	where id_articolo= :ll_id_art_in_esame;
//if isnull(ll_id_cat_com_articolo) then ll_id_cat_com_articolo=0	
	
//	select id_sog_commerciale, id_anagrafica
//	into :ll_sog_com_fornitore, :ll_id_produttore
//	from articolo
//	where id_articolo= :ll_id_art_in_esame;
//if isnull(ll_sog_com_fornitore) then ll_sog_com_fornitore=0	
//if isnull(ll_id_produttore) then ll_id_produttore=0	

	
//ll_id_U_C_in_esame=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_riga, "riga_documento_id_unita_confezione")
//if isnull(ll_id_U_C_in_esame) then ll_id_U_C_in_esame=0
//ld_qta=qta
//if isnull(ld_qta) then ld_qta=0
//ls_qta=string(ld_qta)
//ll_pos = Pos(ls_qta, ",", 1)
//ls_qta=replace(ls_qta, ll_pos, 1, ".")

//ll_id_magazzino=getitemnumber(ll_riga, "id_locazione_1")

//if ll_id_magazzino<1 then 
//	Messagebox("Attenzione!", "Non è stato specificato alcun magazzino~r~n"&
//									+"per questa riga!")
//end if

//integer i, li_pos

//ll_id_valuta_riga=idw_gen.GetItemNumber(1, "documento_id_valuta_des")
//	SELECT "valuta"."cifra_arrotondamento",
//		"valuta"."tipo_arrotondamento"
//			INTO :ll_nr_cifre_arrot ,
//			:ls_tipo_arrotondamento
//	FROM "dba"."valuta"  
//	WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;			

//for i = 1 to 4
//	if i=1 then ls_tipo_applicazione="P"
//	if i=2 then ls_tipo_applicazione="R" 
//	if i=3 then ls_tipo_applicazione="S" 
//	if i=4 then ls_tipo_applicazione="D" 
	
//	string ls_prezzo
//	long ll_valuta, ll_id_var
//	string ls_lis_variazione
//	ll_valuta=this.getitemnumber(1,"riga_documento_id_valuta")
//	ll_id_var=ll_id_listino
	
//	ls_um=getitemstring(row, "tipo_um")
//	if isnull(ls_um) then ls_um=""
//	ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
//	if ll_id_prof=228 or ll_id_prof=229 then // 20231031 è una spazzolatura
//		select pr_spazzolatura into :ldc_prezzo_spazzo from dba.prezzo where id_variazione=:ll_id_listino and id_unita_confezione=:ll_id_U_C_in_esame;
//		if ldc_prezzo_spazzo>0 then 
//			ls_prezzo=string(ldc_prezzo_spazzo	)+"!0!"
//		else  //20240506 metteva l' id_variazione nel prezzo, speriamo non lo faccia più....
//			ls_prezzo="0!0!"
//		end if
//		ls_lis_variazione=string(ll_id_listino)
//		ls_prezzo+=ls_lis_variazione
//	else
////	20231031 fine
//		if not(ls_um='P') then 
//			ls_prezzo=f_recupera_prezzo_manifattura(ls_app, ll_id_U_C_in_esame, ll_sog_com,ll_id_cat_com_sc, ls_cod_art_in_esame, & 
//			ll_id_cat_com_articolo,	ll_sog_com_fornitore, ll_id_produttore,& 
//			ld_qta, ls_tipo_applicazione, ll_id_art_in_esame, ll_id_magazzino, &
//			ll_valuta,'PZ',idc_cambio, al_id_val_az)
//		else
//			ls_prezzo=f_recupera_prezzo_manifattura(ls_app, ll_id_U_C_in_esame, ll_sog_com,ll_id_cat_com_sc, ls_cod_art_in_esame, & 
//			ll_id_cat_com_articolo,	ll_sog_com_fornitore, ll_id_produttore,& 
//			ld_qta, ls_tipo_applicazione, ll_id_art_in_esame, ll_id_magazzino, &
//			ll_valuta,'PS', idc_cambio, al_id_val_az)
//		end if
//	end if
//		li_pos=pos(ls_prezzo, "!")
//			string ls_coef_calo
//			ls_app1=ls_prezzo
//	if li_pos>0 then
//		ls_prezzo=left(ls_app1, li_pos - 1) //prezzo vero e proprio
//		ls_app1=right(ls_app1, len(LS_APP1) - li_pos) //coef calo da applicare alla riga
//	end if
//	li_pos=pos(ls_app1, "!")
//	if li_pos>0 then
//		ls_lis_variazione=right(ls_app1, len(ls_app1) - li_pos) //id_variazione da riportare in riga documento
//		ls_coef_calo=left(ls_app1, li_pos - 1)		
//		if ls_lis_variazione> "0" then 
//		//if ll_id_var=0 then
//			ll_id_var=long(ls_lis_variazione)
//			if ll_id_var>0 then
//				setitem(row, "riga_documento_id_listino", ll_id_var)
//			else
//				setnull(ll_id_var)
//				//setitem(row, "riga_documento_id_listino", ll_id_var)
//			end if
//		end if
//	else
//		ls_coef_calo=ls_app1
//		if ll_id_var=0 then
//			setnull(ll_id_var)
//			//setitem(row, "riga_documento_id_listino", ll_id_var)
//		end if
//	end if
							
//	if i=1  then 
//		ld_prezzo=dec(ls_prezzo)
				
//		if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
//			ld_Prezzo=f_Round(ld_Prezzo ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)		
			
//		if not(ls_um='P') then 
			
					
//			select p.coef_calo
//			into :ld_var_calo 
//			from prezzo_documento p, unita_confezione u, articolo a
//			where id_documento=:il_id_documento
//			and u.id_unita_confezione= :ll_id_U_C_in_esame
//			and p.id_titolo=a.id_titolo
//			and u.id_articolo=a.id_articolo;
			
//			if ld_prezzo >=0 then 
				
//				tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
//						(ll_riga, "prezzo", ld_prezzo)
//				tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
//						(ll_riga, "prezzo_complessivo", ld_prezzo)
//			end if
//		else 
//			long ll_id_caus_magazzino, ll_null
//			string ls_manifattura
//			setnull(ll_null)
			
//			ll_id_caus_magazzino=this.getitemnumber(ll_riga,"riga_documento_id_caus_magazzino")
//			select proponi_prezzo_manifattura
//			into :ls_manifattura
//			from caus_magazzino
//			where id_caus_magazzino=:ll_id_caus_magazzino;
//			if ls_manifattura='S' then
									
//					select u.unita_produzione, a.id_titolo
//					into :ls_manifattura, :ll_id_titolo
//					from unita_confezione u, articolo a
//					where u.id_unita_confezione= :ll_id_U_C_in_esame
//					and u.id_articolo=a.id_articolo;
//					//potrei aggiungere controllo sulla data di aggiornamento del prezzo:
//				//se è stato aggiornato dopo la data del documento attuale
//				//NON si dovrebbe recuperare il prezzo ....						
//					select coef_calo, prezzo, id_unita_conf_base
//					into :ld_var_calo, :ld_var_prezzo, :ll_tipo_prezzo
//					from prezzo_documento
//					where id_documento=:il_id_documento
//					and id_titolo=:ll_id_titolo;
//					if ld_var_prezzo>0 then ld_prezzo+=ld_var_prezzo
					
//					if ld_prezzo >=0 then
//						if ll_tipo_prezzo=2 then 
//							ls_manifattura='C' 
//						elseif ll_tipo_prezzo=1 then 
//							ls_manifattura='S'
//						end if
						
//						if ls_manifattura='S' then
//							this.setitem(ll_riga,"prezzo_complessivo",ld_prezzo)
//							this.setitem(ll_riga,"prezzo_manifattura",ll_null)
//						else
//							tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_riga, "prezzo_manifattura", ld_prezzo)
//							this.setitem(ll_riga,"prezzo_complessivo",ll_null)
//						end if
//					else
//						this.setitem(ll_riga,"prezzo_complessivo",ll_null)
//						this.setitem(ll_riga,"prezzo_manifattura",ll_null)
//					end if
//			end if	
//		end if
//		ld_legato=getitemdecimal(row, "riga_documento_peso_netto")
//		if ld_legato>0 then
//			ld_fino=getitemdecimal(row, "fino")
//			ld_calo=getitemdecimal(row, "calo")
//			if isnull(ld_calo) then ld_calo=0
//			if isnull(ld_fino) then ld_fino=0
//			ld_fino=ld_fino+ld_calo
//		else
//			ld_fino=0
//		end if
		
//	elseif i=2 then //sconto riga ad importo
//		ld_prezzo=dec(ls_prezzo)
		
//		if ld_prezzo >=0 then tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
//										(ll_riga, "riga_documento_sconto_riga", (ld_prezzo )*ld_qta)										
//	elseif i=3 then //sconto in percentuale
//		ls_sconto=idw_riga.getitemstring(ll_riga, "sconto")
//		if ls_sconto<='0' or isnull(ls_sconto) then
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_riga, "sconto", ls_prezzo)
//		else
//			//li_ret=messagebox("Attenzione!", "Esiste già uno sconto applicato. Si vuole sovrascriverlo?",  stopsign!, yesno!)
//			if li_ret=1 then tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_riga, "sconto", ls_prezzo)
//		end if
	
//	elseif i=4 then
//		ld_prezzo=dec(ls_prezzo)
//		ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
//		tab_1.tabpage_1.dw_documento_ordine_ff.setitem(ll_riga_corrente, "documento_sconto_finanziario", ls_prezzo)
//	end if
//	ld_coef_calo=dec(ls_coef_calo)
	
//	if ld_var_calo>0 then ld_coef_calo=ld_var_calo
//	if ll_id_prof=228 or ll_id_prof=229 then exit
//next

////180313 metto il flag da stampare che serve per segnalare che il prezzo è stato aumentato in base alla tabella magg_qta_merce
////250713 cambio campo di controllo per la maggiorazione, ora uso valoriz_peso_non_prezioso
////idw_riga.setitem(row, "riga_documento_da_stampare", "N")
//idw_riga.setitem(row, "valoriz_peso_non_prezioso", 0)
//wf_magg_per_quantita(row) //20241209 spostato da updatestart e messo anche in itamchamged del peso
//return 1
	
end event

event dw_riga_documento_ordine_gd::clicked;call super::clicked;
s_new_ordini s_ordini
long ll_id_art_originale, ll_id_cliente, ll_row, ll_id_documento, ll_id_sorgente, ll_ret, ll_riga, ll_tot 
long ll_cartellino
w_orafo_lista_dis_cliente_gd  w_lista
datawindowchild dwc_cartellino

if dwo.name='varianti' then
	ll_row=getrow() 
	if ll_row>0 then
		s_ordini.s_ll_id_sorgente=getitemnumber(ll_row, "id_riga_sorgente")
		
		s_ordini.s_ll_id_documento=getitemnumber(ll_row, "id_documento")
		s_ordini.s_ll_id_art_originale=getitemnumber(ll_row, "riga_documento_id_articolo")
		s_ordini.s_ll_id_cliente=idw_gen.getitemnumber(1, "id_sog_commerciale")
		OpenWithParm(w_lista, s_ordini)
		ll_ret=message.doubleparm
		if ll_ret= -1 then 
			messagebox("Attenzione!", "Non esiste distinta per questo articolo!")
		elseif ll_ret>0 then
					
			if  ll_row>1 then ll_riga=find( "id_riga_sorgente="+string(ll_ret), 1, ll_row -1)
			ll_tot=dw_riga_documento_ordine_gd.rowcount()
			if ll_row<ll_tot and isnull(ll_riga) then 
				ll_riga=find( "id_riga_sorgente=" +string(ll_ret), ll_row, ll_tot)
			end if	
			if not isnull(ll_riga) and ll_riga>0 then 
				  messagebox('Attenzione','La variante selezionata è già stata utilizzata nella riga '&
				  +string(ll_riga) + ' di questo documento, ~r~nè consigliabile cambiare la variante'+ &
				  ' o provvedere a sommare le due righe in una riga sola')	  
		   end if
			dw_riga_documento_ordine_gd.setitem(ll_row,"id_riga_sorgente",ll_ret)
	     end if
	end if
elseif dwo.name='p_cartellino' then  //per Bucci da cancellare
	open(w_cartellino_b_gd)
	ll_cartellino=message.doubleparm
	idw_riga.getchild("cartellino", dwc_cartellino)
	CONNECT USING SQLCA;
	// Set the transaction object for the 
	dwc_cartellino.SetTransObject(SQLCA)
	// Populate with values for eastern 
	dwc_cartellino.Retrieve()
	idw_riga.setitem(row, "cartellino", ll_cartellino)
end if



end event

event dw_riga_documento_ordine_gd::ue_comment;cb_cancella.triggerevent(clicked!)
end event

event dw_riga_documento_ordine_gd::ue_set_arti_riga;call super::ue_set_arti_riga;long ll_row
ll_row=getrow()
if ll_row>0 THEN 
	post wf_integra_autofind(ll_row)
	
	post event ue_rec_prezzo(ll_row, 1)
	post wf_calcola_prezzo(ll_row)
	
	post wf_cerca_dis_cliente(ll_row)
	
	POST WF_METTI_DESCRIZIONE(LL_ROW)
	post setcolumn(getcolumn())
end if

end event

event dw_riga_documento_ordine_gd::ue_key;call super::ue_key;boolean lb_new, lb_last
string ls_cod_azienda, ls_ultimo_campo, ls_um
decimal ldc_prezzo_complessivo
long ll_row, ll_id_prof

choose case key
CASE KeyTab!
		If keyflags = 0 then
			
			lb_last = (GetRow() = RowCount())
			//silverdreams per gestione impegnato (041209)
			select rag_soc_1 
			into :ls_cod_azienda
			from azienda
			;
			ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
			if (pos(upper(ls_cod_azienda), 'SILVER D')>0 or  pos(upper(ls_cod_azienda), 'PANNA')>0) and  ll_id_prof<>188 then
				ll_row=getrow()
				ls_um=getitemstring(ll_row, "simbolo_mov")
				if ls_um='PZ' then
					ls_ultimo_campo="prezzo_complessivo"
				else
					ls_ultimo_campo="prezzo_manifattura"
				end if
			elseif ll_id_prof=188 and pos(upper(ls_cod_azienda), 'SILVER D')>0 then
				ls_ultimo_campo="riga_documento_provv_imp_carea_2"
	
			else
				ls_ultimo_campo="prezzo_metallo"
			end if
			//fine modifica silver 041209
			if is_last_field = ls_ultimo_campo then
				if lb_last then
					idw_riga.PostEvent("ue_wiz_insert")
				else
					idw_riga.PostEvent("ue_wiz_getfocus")
				end if
					RETURN -1
			end if
		end if
END CHOOSE
	
end event

event dw_riga_documento_ordine_gd::doubleclicked;call super::doubleclicked;string ls_sort


ls_sort=string(dwo.name)
if right(ls_sort, 2)="_t" then
	ls_sort=left(ls_sort, len(ls_sort) - 2)
	idw_riga.setsort(ls_sort)
	idw_riga.sort()
end if

end event

event dw_riga_documento_ordine_gd::dberror;
choose case sqldbcode
	case -196
		messagebox("Salvataggio fallito!", "Si sta tentando di inserire una riga documento~r~n"&
		+"con numero riga già esistente")
		return 1
	case -99999
		messagebox("Salvataggio fallito!", "Per movimentare un articolo occorre~r~n"&
		+"inserire la quantità o il peso (Legato).")
		return 1
	case else
		call super::dberror
end choose

end event

event dw_riga_documento_ordine_gd::ue_set_search;call super::ue_set_search;
end event

event dw_riga_documento_ordine_gd::rbuttondown;call super::rbuttondown;string ls_colonna, ls_test, ls_ret, ls_cod_art_new, ls_id_art
integer i
string ls_stampato
long ll_id_art
s_correggi_provenienza s_c_prov
s_array s_utente

if string(dwo.name)="c_articolo_cod" then
	accepttext()
	ls_id_art=getitemstring(row, "c_articolo_cod")
	if isnumber(ls_id_art) then
		ll_id_art=long(ls_id_art)
		select codice
		into :ls_cod_art_new
		from dba.articolo
		where id_articolo= :ll_id_art;
		if ls_cod_art_new> " " then
			trigger event itemchanged(row, dwo, ls_cod_art_new)
		end if	
	end if
end if
select proteggi_profilo
into :ls_test
from orafo_par_sistema;
if ls_test> " " then
	if string(dwo.name)="riga_documento_peso_netto_t" or string(dwo.name)="quantita_t" or &
	 string(dwo.name)="sigla_prezzo_t" or string(dwo.name)="prezzo_complessivo_t" then
		ls_colonna=left(string(dwo.name), len(string(dwo.name)) - 2)
		if il_test_protezione=0 then
			ls_ret=modify(ls_colonna+".protect='0 ~t if(id_riga_doc_padre > 0, 1,0)' ")
			il_test_protezione=1
		else
			ls_ret=modify(ls_colonna+".protect='0'")
			il_test_protezione=0
		end if
	end if
end if
//aggiunto per Samy 010310
//serve per chiudere forzatamente tutte le righe derivate (invece di spuntare riga per riga)
if string(dwo.name)="forza_chius_evasione_t" then
		for i= 1 to rowcount()
			if getitemnumber(i, "id_riga_doc_provenienza")>0 then
				setitem(i, "forza_chius_evasione", "S")
			end if
		next	
end if
// fine aggiunta 010310
//se Samy corregge un rbol derivato da un bol nel peso o nei pezzi e mette i pezzi o il peso
//minori di quanto è sul bol, in automatico al salvataggio la procedura riapre la bol per la differenza
//questo è corretto ma non ci va bene: Samy dovrebbe in realtà cancellare la riga derivata nell'rbol
//poi andare sul bol padre e modificare correttamente la riga bol poi ritornare sull'rbol
//e riderivare la riga del bol allora i dati sarebbero coincidenti e tutto sarebbe a posto.
//così però è laborioso, quindi questa funzione semplificherà un po' la cosa:
//quando Samy corregge rbol curerà di premere il tasto dx del mouse sul campo QTA o peso_netto
//questo farà aprire un finestra che permetterà la contemporanea correzione del bol corrispondente
if string(dwo.name)="quantita" or string(dwo.name)="riga_documento_peso_netto" then
	s_c_prov.l_id_riga_provenienza=getitemnumber(row, "id_riga_doc_provenienza")
	if isnull(s_c_prov.l_id_riga_provenienza) then
		messagebox("Attenzione!", "La riga non è stata derivata e quindi non ha riga di provenienza!")
		return
	end if
	s_c_prov.s_campo=string(dwo.name)
	s_c_prov.dc_qta_peso=getitemdecimal(row, string(dwo.name))
	openwithparm(w_correggi_riga_prov_cx, s_c_prov)
	ls_cod_art_new=message.stringparm
	if ls_cod_art_new> " " and ls_cod_art_new<>getitemstring(row, "c_articolo_cod") then
		setitem(row, "c_articolo_cod",ls_cod_art_new )
		trigger event itemchanged(row, object.c_articolo_cod , ls_cod_art_new)
	end if
end if
//250713 per samy prezzi confermati (da_stampare=c o X) il campo viene barrato
if dwo.name="prezzo_manifattura" or dwo.name="prezzo_complessivo"   then
	if messagebox("Conferma Prezzo", "Vuoi confermare questo prezzo?", stopsign!, yesno!)=1 then
		ls_stampato=getitemstring(row, "riga_documento_da_stampare")
		if ls_stampato='E' then 
			ls_stampato='X'
		else
			ls_stampato='C'
		end if
		setitem(row, "riga_documento_da_stampare", ls_stampato)
	end if
end if
//20200703
if dwo.name="riga_documento_num_riga" then //Samy vuol vedere la data ultima modifica
	s_utente.ll_id_doc[2]=getitemnumber(row, "riga_documento_num_riga")
	s_utente.ll_id_doc[1]=il_id_documento
	openwithparm(	w_vedi_data_creaz_aggiornamento, s_utente)
end if

end event

event dw_riga_documento_ordine_gd::retrieveend;call super::retrieveend;DECIMAL LDC_TEST

if rowcount>0 then
	ldc_test=idw_gen.getitemdecimal(1, "imp_avanzo_acconto")
	
		if ldc_test=110 then rb_10.checked=true
		if ldc_test=115 then rb_15.checked=true
		if ldc_test=90 then rb_meno_10.checked=true
		if ldc_test=85 then rb_meno_15.checked=true
	
	
end if
end event

event dw_riga_documento_ordine_gd::ue_update;call super::ue_update;//300914 des aggiuntiva
//wf_salva_riga_doc_2()
//300914 fine

//20250319: non salvava più (dal 20-02) le note produzione e qualità: quando abbiamo spostato i vari controlli a livello di riga
//probabilmente questo è saltato... ora lo rimetto...
wf_salva_note_riga()
end event

event dw_riga_documento_ordine_gd::retrievestart;call super::retrievestart;//if  upperbound( idw_master.is_list.l_id_riga)>=3 then
//	return 2
//end if
//	
end event

type pb_note from w_documento_ordine_cx`pb_note within tabpage_2
integer x = 3122
integer y = 924
integer width = 165
integer height = 92
end type

event pb_note::clicked;string ls_nota, ls_nota_attuale
long ll_sogg_com
ll_sogg_com=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,'id_sog_commerciale')
openwithparm(w_annotazione_gd, string(ll_sogg_com))
ls_nota=message.stringparm
if not isnull(ls_nota) and ls_nota>'' then
	ls_nota_attuale=dw_riga_documento_dett_ord_ff.getitemstring(dw_riga_documento_dett_ord_ff.getrow(),&
	'riga_documento_descrizione')
	if messagebox("Question", "Vuoi sostituire questa nota all'attuale?", information!, yesno!) = 2 then
		ls_nota=ls_nota_attuale + " " +ls_nota
	end if
	dw_riga_documento_dett_ord_ff.setitem(dw_riga_documento_dett_ord_ff.getrow(),&
	'riga_documento_descrizione', ls_nota)
end if





end event

type cb_5bis from w_documento_ordine_cx`cb_5bis within tabpage_2
integer x = 2446
integer y = 804
integer width = 146
integer height = 84
integer textsize = -7
string text = "Legato"
end type

event cb_5bis::clicked;call super::clicked;
if idw_riga.dataobject="d_orafo_riga_documento_ordine_silver_gd" then 	
	idw_riga.post setcolumn("riga_documento_peso_lordo")
	post setfocus(idw_riga)
end if
end event

type pb_tree_sort from w_documento_ordine_cx`pb_tree_sort within tabpage_2
boolean visible = false
integer x = 2679
integer y = 800
end type

type dw_riga_documento_dett_ord_ff from w_documento_ordine_cx`dw_riga_documento_dett_ord_ff within tabpage_2
integer x = 5
integer y = 924
integer width = 3109
integer height = 880
string dataobject = "d_orafo_riga_doc_dettaglio"
end type

event dw_riga_documento_dett_ord_ff::ue_init;call super::ue_init;is_list.s_colonne_drop[1] = "articolo_id_titolo"
is_list.s_colonne_drop[2] = "articolo_metallo"
is_list.s_colonne_drop[3] = "id_caus_magazzino"
is_list.s_colonne_drop[4] = "id_caus_des"
is_list.s_colonne_drop[5] = "riga_documento_id_listino"
is_list.s_colonne_drop[6] = "riga_documento_id_TAB_IVA"
is_list.s_colonne_drop[7] = "id_conto"
end event

event dw_riga_documento_dett_ord_ff::ue_key;boolean 	lb_new=FALSE
boolean 	lb_last=FALSE
long 		ll_last_row

CHOOSE CASE key
	CASE KeyTab!
		If keyflags = 0 then
			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
			lb_last = (GetRow() = RowCount())
			if is_last_field = "id_caus_magazzino" then
				if lb_new then
				
					if lb_last then
					
						idw_riga.PostEvent("ue_wiz_insert")
					else
	
						idw_riga.PostEvent("ue_wiz_getfocus")
					end if
				else
				
					idw_riga.PostEvent("ue_wiz_getfocus")
				end if
				RETURN -1
			end if
		end if
END CHOOSE
end event

event dw_riga_documento_dett_ord_ff::itemchanged;call super::itemchanged;long ll_id_caus, ll_id_uc
string ls_met, ls_man, ls_um
decimal{4} ld_prezzo_metallo, ld_prezzo_manifattura ,ld_qta2
decimal{2} ld_peso_gr, ld_fino_calo, ld_peso
integer i

choose case string(dwo.name)
	case "id_caus_magazzino" 
		ll_id_caus=long(data)
		select proponi_prezzo_metallo, proponi_prezzo_manifattura
		into :ls_met, :ls_man
		from caus_magazzino
		where id_caus_magazzino=:ll_id_caus;
		
		setitem(row, "proponi_prezzo_metallo", ls_met)
		setitem(row, "proponi_prezzo_manifattura", ls_man)
//20241129 se si cambia la caus della prima riga si cambiano tutte forse...
		if row=1 then
			if messagebox("Attenzione!", "Vuoi riportare la causale su tutte le righe?", stopsign!, yesno!)=1 then
				for i=1 to rowcount()
					setitem(i, "id_caus_magazzino", long(data))
				next
			end if
		end if

	case "sconto" 
		ls_um=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(row,"tipo_um")
		if ls_um='P' then
			ld_prezzo_manifattura=idw_riga.getitemdecimal(row, "prezzo_manifattura")
			if ld_prezzo_manifattura>0 then
	
	
	
				
				post wf_calcola_prezzo(row)
			else
				if pos(data, "+")=0 and len(data)>3 then //è il caso della Bella che usa lo sconto come descrizione
				
				else
					messagebox("Attenzione!", "Impossibile applicare sconto:~r~nnon esiste un valore per la manifattura!")
					post uf_set_colval("sconto",  "0")
				end if
			end if
		else
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_set_calc_riga(row)
		end if
	case "sconto_riga" 
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.event post ue_set_calc_riga(row)
	case "peso_non_prezioso" 
		ld_peso=idw_riga.getitemdecimal(row, "riga_documento_peso_netto")
		if dec(data)<=ld_peso then
			if not isnull(ld_peso) then
				post wf_setta_fino_calo(row)
				post wf_calcola_prezzo(row)
			end if
		else
			messagebox("Errore!", "Il peso non prezioso non può essere maggiore del legato!")
			return 2
		end if
	case "id_unita_confezione"
		ll_id_uc=long(data)
		select m.tipo
		into 	:ls_um
		from unita_misura m, unita_confezione c
		where c.id_unita_misura=m.id_unita_misura
		and c.id_unita_confezione=:ll_id_uc
		;
		idw_riga.setitem(row, "tipo_um", ls_um)
		ld_qta2=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row, "quantita")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_rec_prezzo(row, ld_qta2)
		post wf_calcola_prezzo(row)
		
	case "riga_documento_id_tab_iva"
		if row=1 then 
			if messagebox("Attenzione!", "Vuoi cambiare l'iva su tutte le righe?",  stopsign!, yesno!)=1 then 
				wf_ricopia_iva_su_tutte_righe(long(data), row)
			end if
		end if
	case	"riga_documento_id_listino"
		if messagebox("Attenzione!", "Vuoi cambiare il listino su tutte le righe?",  stopsign!, yesno!)=1 then 
				wf_ricopia_listino_tutte_righe(long(data), row)
			end if
		
		
end choose
end event

event dw_riga_documento_dett_ord_ff::clicked;call super::clicked;long ll_id_articolo, ll_id_riga, ll_riga_corrente,ll_id_prof
integer i, li_len
string ls_tipo_doc_ae, ls_sort


ll_riga_corrente=row
if ll_riga_corrente> 0 then
	ll_id_riga=getitemnumber(ll_riga_corrente, "id_riga_documento")
	
	if dwo.name='id_unita_confezione' then
		ll_id_articolo=getitemnumber(row, "riga_documento_id_articolo")
		datawindowchild dw_uc
		this.getchild("id_unita_confezione", dw_uc)
		dw_uc.settransobject(sqlca)
		dw_uc.retrieve(ll_id_articolo)
	end if
	
	if dwo.name='b_riga_derivata' then
		if ll_id_riga>0 then
			openwithparm(w_vedi_riga_derivata_cx, ll_id_riga)
		end if	
	end if
	
	if dwo.name='p_nc' then
		ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
		select tipo_documento_ae into :ls_tipo_doc_ae from dba.prof_documento where id_prof_documento=:ll_id_prof;
		if ls_tipo_doc_ae="TD04" or ls_tipo_doc_ae="TD05" or ls_tipo_doc_ae="TD16" or  ls_tipo_doc_ae="TD17" or  ls_tipo_doc_ae="TD18" or  ls_tipo_doc_ae="TD19"then
			ll_id_riga=getitemnumber(ll_riga_corrente, "id_riga_documento")
			if ll_id_riga<=0 or isnull(ll_id_riga) then
				cb_salva.triggerevent("clicked!")
				ll_id_riga=getitemnumber(ll_riga_corrente, "id_riga_documento")
			end if
			openwithparm(w_integr_nc_2_pop, ll_id_riga)
		end if
	end if
	
	if dwo.name='riga_documento_id_articolo' then
		ls_sort="riga_documento_id_articolo"
		idw_riga.setsort(ls_sort)
		idw_riga.sort()
		
	end if
	
	//if dwo.name='riga_documento_descrizione' then
	//	li_len= len(getitemstring(row, "riga_documento_descrizione"))
	//	for i= 1 to li_len
	//		
	//		keybd_event(25,0,2,0)
	//		keybd_event(25,0,0,0) // END Depressed
	//	next
	//end if
end if
end event

event dw_riga_documento_dett_ord_ff::editchanged;call super::editchanged;string ls_dato, ls_azienda

select codice
into :ls_azienda
from dba.azienda
where id_azienda=1
;
if dwo.name="riga_documento_descrizione"  then
	if ls_azienda="SILVERDR" then
		if pos(data, "-|-")<=0 then
			ls_dato=left(data, len(data) - 1)
			ls_dato+="  -|- "
			setitem(row, "riga_documento_descrizione", ls_dato)
			//post setfocus(this)
			//post scrolltorow(row)
			//post setcolumn("riga_documento_descrizione")
			//Send(Handle(this),256,9,Long(0,0))
			//keybd_event(40,0,0,0)//tasto freccia in giù (lo faccio più volte perché non so quante righe ci sono
			//keybd_event(40,0,2,0)
	//		keybd_event(40,0,0,0)
	//		keybd_event(40,0,2,0)
	//		keybd_event(40,0,0,0)
	//		keybd_event(40,0,2,0)
	//		ls_data=data
	//		li_len=len(ls_data)
			keybd_event(35,0,0,0) // END Depressed
			
			keybd_event(35,0,2,0) // END Released (Can be omitted) 
			
			
		end if
	end if
	
		
end if
end event

event dw_riga_documento_dett_ord_ff::doubleclicked;call super::doubleclicked;long ll_articolo, ll_temp
nvo_file_list sl_lista_file
integer li_ret
string ls_file_trovato, ls_path

if dwo.name="riga_documento_id_articolo" then
	ll_articolo=getitemnumber(row, "riga_documento_id_articolo")
	if ll_articolo>0 then
		select dir_immagini 
		into :ls_path
		from dba.par_sistema
		;

		sl_lista_file=f_leggi_files(ls_path, false)
	end if
	FOR ll_temp = 1 TO UpperBound( sl_lista_file.as_file )
		 li_ret=pos(sl_lista_file.as_file[ll_temp], string(ll_articolo))
		 if li_ret>0 then
			ls_file_trovato=sl_lista_file.as_file[ll_temp]
			//l'ho trovato ora lo mostro
			//ma prima chiudo la finestra se fosse stata aperta già precedentemente
			close(w_mostra_foto)
			openwithparm(w_mostra_foto, ls_file_trovato)
			exit
			
			
		end if
	 NEXT
end if
end event

event dw_riga_documento_dett_ord_ff::rowfocuschanged;call super::rowfocuschanged;if currentrow>0 then
	cbx_des_3.triggerevent(clicked!)
end if
end event

type tabpage_3 from w_documento_ordine_cx`tabpage_3 within tab_1
integer width = 4059
integer height = 1944
end type

type dw_documento_bolla_trasp_ff from w_documento_ordine_cx`dw_documento_bolla_trasp_ff within tabpage_3
integer x = 41
integer y = 20
integer width = 3342
integer height = 1768
end type

type cb_3 from w_documento_ordine_cx`cb_3 within tabpage_3
end type

type tabpage_4 from w_documento_ordine_cx`tabpage_4 within tab_1
integer width = 4059
integer height = 1944
dw_2 dw_2
cb_2 cb_2
end type

on tabpage_4.create
this.dw_2=create dw_2
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_2
end on

on tabpage_4.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_2)
end on

type dw_cast_iva_documento_lt from w_documento_ordine_cx`dw_cast_iva_documento_lt within tabpage_4
integer width = 3840
integer height = 556
end type

event dw_cast_iva_documento_lt::ue_calc_sconti_cast;

long 			ll_nr_row, ll_count, ll_gen_row, ll_cast_count, ll_cast_row_nr
decimal 		ldc_sc_fin_cassa, ldc_sc_incondizionato, ldc_imponibile, ldc_sconto, ldc_imp_complemento
decimal 		ldc_perc_incondizionato, ld_imp_man_doc1, ld_imp_man_doc, ld_sconto, ld_tot_sconto
decimal		ld_prop_sconto, ld_quadra_sconto, ld_sconto1, ld_sconto2, ld_sconto3
string 			ls_sc_finanziario
long 			ll_id_valuta_doc
integer 		li_dec_significativi

IF ROWCOUNT()<=0 THEN
	RETURN
END IF


ll_id_valuta_doc=idw_gen.getitemnumber(1, "documento_id_valuta_cod")
select dec_significativi
into :li_dec_significativi
from valuta
where id_valuta=:ll_id_valuta_doc;
if isnull(li_dec_significativi) then
	li_dec_significativi=-2
	messagebox("Attenzione!", "I decimali di arrotondamento degli importi non sono valorizzati!")
end if


ld_sconto=0
ll_gen_row= il_row
ls_sc_finanziario= idw_gen.GetItemString(ll_gen_row, "documento_sconto_finanziario")
if left(ls_sc_finanziario, 1)='+' or left(ls_sc_finanziario, 1)='-' then
	ls_sc_finanziario = right(ls_sc_finanziario, len(ls_sc_finanziario) - 1)
	idw_gen.setItem(ll_gen_row, "documento_sconto_finanziario",ls_sc_finanziario)
end if

ldc_sc_incondizionato= idw_gen.uf_GetItemDecimal(ll_gen_row, "sconto_fin_incondizionato")
ldc_sc_fin_cassa= idw_gen.uf_GetItemDecimal(ll_gen_row, "documento_sconto_fin_cassa")

ll_cast_row_nr= RowCount()
for ll_cast_count = 1 to ll_cast_row_nr
	SetItem(ll_cast_count, "c_prop_imp", Round(GetItemNumber(ll_cast_count, "c_proporzionale"), 4))
next

if  ls_sc_finanziario > "0"  THEN
	
	
	
	
	
	ld_imp_man_doc=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemdecimal(1, "tot_manifattura")
	
	ld_imp_man_doc1= uf_calcola_prezzo(ls_sc_finanziario, ld_imp_man_doc, 0)
	ld_tot_sconto=round(ld_imp_man_doc - ld_imp_man_doc1, li_dec_significativi* -1)
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imponibile")
		ld_prop_sconto=getitemdecimal(ll_cast_count, "c_prop_imp")
		ld_sconto=ld_tot_sconto*ld_prop_sconto
		ld_quadra_sconto+=ld_sconto
		
		if ll_cast_count=ll_cast_row_nr then
			if ld_quadra_sconto<>ld_tot_sconto then
				ld_sconto+=(ld_tot_sconto - ld_quadra_sconto)
			end if
		end if
		ldc_imponibile=ldc_imponibile - ld_sconto
		SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
	next
	
	
	
	dw_documento_tot_ext_ff.setitem(1, "sconto_fin", ld_tot_sconto)
	
	
	
else
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imponibile")
		SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
	next
	
	dw_documento_tot_ext_ff.setitem(1, "sconto_fin", 0)
	ls_sc_finanziario='0'
end if
ldc_imp_complemento=0
If not (IsNull(ldc_sc_incondizionato) OR ldc_sc_incondizionato = 0) then
	if ll_cast_row_nr > 0 then
		for ll_cast_count = 1 to ll_cast_row_nr - 1
			ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imp_scontato")
			ldc_perc_incondizionato= uf_Round(ldc_sc_incondizionato * uf_GetItemDecimal(ll_cast_count, "c_proporzionale"))
			ldc_imponibile= ldc_imponibile - ldc_perc_incondizionato
			ldc_imp_complemento= ldc_imp_complemento + ldc_perc_incondizionato
			SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
		next
		ldc_imponibile= uf_GetItemDecimal(ll_cast_row_nr, "val_imp_scontato")
		ldc_imponibile= ldc_imponibile - ldc_sc_incondizionato + ldc_imp_complemento
		SetItem(ll_cast_row_nr, "val_imp_scontato", ldc_imponibile)
	end if
	
	dw_documento_tot_ext_ff.setitem(1, "sconto_inc", ldc_sc_incondizionato)	
else
	dw_documento_tot_ext_ff.setitem(1, "sconto_inc", 0)
	ldc_sc_incondizionato=0
end if

If not (IsNull(ldc_sc_fin_cassa) OR ldc_sc_fin_cassa = 0) then
	
	
	ld_imp_man_doc=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemdecimal(1, "tot_manifattura")
	
	ld_imp_man_doc1= uf_calcola_prezzo(ls_sc_finanziario, ld_imp_man_doc, 0)
	ld_imp_man_doc1 -=ldc_sc_incondizionato
	ld_imp_man_doc=uf_calcola_prezzo(string(ldc_sc_fin_cassa), ld_imp_man_doc1, 0)
	ld_tot_sconto=round(ld_imp_man_doc1 - ld_imp_man_doc, li_dec_significativi * - 1)
	
	ld_quadra_sconto=0
	for ll_cast_count = 1 to ll_cast_row_nr
		ld_prop_sconto=getitemdecimal(ll_cast_count, "c_prop_imp")
		ld_sconto=ld_tot_sconto*ld_prop_sconto
		ld_quadra_sconto+=ld_sconto
		
		if ll_cast_count=ll_cast_row_nr then
			if ld_quadra_sconto<>ld_tot_sconto then
				ld_sconto+=(ld_tot_sconto - ld_quadra_sconto)
			end if
		end if
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imp_scontato")
		ldc_imponibile=ldc_imponibile - ld_sconto
		SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
	next
	
	dw_documento_tot_ext_ff.setitem(1, "sconto_cassa", ld_tot_sconto) 
else
	
	dw_documento_tot_ext_ff.setitem(1, "sconto_cassa", 0)
end if
If cb_valuta.text = "Valuta Documento" then
	ld_sconto1=dw_documento_tot_ext_ff.getitemdecimal(1, "sconto_inc")
	ld_sconto2=dw_documento_tot_ext_ff.getitemdecimal(1, "sconto_fin")
	ld_sconto3=dw_documento_tot_ext_ff.getitemdecimal(1, "sconto_cassa")
//	ld_sconto1*=idc_cambio
//	ld_sconto2*=idc_cambio
//	ld_sconto3*=idc_cambio
	ld_sconto1/=idc_cambio
	ld_sconto2/=idc_cambio
	ld_sconto3/=idc_cambio
	dw_documento_tot_ext_ff.setitem(1, "sconto_inc", ld_sconto1)
	dw_documento_tot_ext_ff.setitem(1, "sconto_fin", ld_sconto2)
	dw_documento_tot_ext_ff.setitem(1, "sconto_cassa", ld_sconto3)
end if
	
end event

event dw_cast_iva_documento_lt::ue_applica_cast_iva;call super::ue_applica_cast_iva;decimal ld_imp_man_doc
if idw_riga.rowcount()>0 then
	ld_imp_man_doc=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemdecimal(1, "tot_manifattura")
	
	If cb_valuta.text = "Valuta Documento" then
	//ld_imp_man_doc*=idc_cambio
		ld_imp_man_doc/=idc_cambio
	end if
	
	
	dw_documento_tot_ext_ff.setitem(1, "tot_manifattura", ld_imp_man_doc)
end if
end event

type dw_spesa_documento_gd from w_documento_ordine_cx`dw_spesa_documento_gd within tabpage_4
integer width = 2098
end type

type st_spese_riepilogo from w_documento_ordine_cx`st_spese_riepilogo within tabpage_4
end type

type cb_aggiorna from w_documento_ordine_cx`cb_aggiorna within tabpage_4
end type

type st_spese_riepilogo_cont from w_documento_ordine_cx`st_spese_riepilogo_cont within tabpage_4
end type

type st_st_scadenze_sconti_cont from w_documento_ordine_cx`st_st_scadenze_sconti_cont within tabpage_4
integer x = 2592
end type

type cb_ricalcola_scadenze from w_documento_ordine_cx`cb_ricalcola_scadenze within tabpage_4
integer x = 2555
end type

type dw_documento_ord_tot_ff from w_documento_ordine_cx`dw_documento_ord_tot_ff within tabpage_4
integer y = 1004
integer width = 2103
end type

type st_st_scadenze_sconti from w_documento_ordine_cx`st_st_scadenze_sconti within tabpage_4
integer x = 1925
end type

type cb_valuta from w_documento_ordine_cx`cb_valuta within tabpage_4
boolean visible = true
integer x = 2112
integer y = 1012
integer width = 549
string text = "Valuta di Conto"
end type

event cb_valuta::clicked;
if idw_castelletto.rowcount() >0 then
	if not(idc_cambio =1) then
		idw_castelletto.SetRedraw(FALSE)
		idw_scadenza.SetRedraw(FALSE)
		idw_spesa.SetRedraw(FALSE)
		
		If this.text = "Valuta di Conto" then
			this.text = "Valuta Documento"
			
			tab_1.tabpage_4.dw_cast_iva_documento_lt.event ue_visibilita_campi("L")
			idw_scadenza.Object.importo.width = 450
			idw_scadenza.Object.imp_valuta.width = 0
			idw_spesa.Object.c_importo_lire.width = 485
			idw_spesa.Object.importo.width = 0
			idw_gen_tot_ext.Modify("tot_documento_lire.visible = 1")
			idw_gen_tot_ext.Modify("tot_imposta_lire.visible = 1")
			idw_gen_tot_ext.Modify("tot_imponibile_lire.visible = 1")
			idw_gen_tot_ext.Modify("tot_merce_lire.visible = 1")
			idw_gen_tot_ext.Modify("netto_merce_lire.visible = 1")
			idw_gen_tot_ext.Modify("tot_omaggi_sc_merce_lire.visible = 1")
		else
			this.text = "Valuta di Conto"
			
			tab_1.tabpage_4.dw_cast_iva_documento_lt.event ue_visibilita_campi("V")
			idw_scadenza.Object.importo.width = 0
			idw_scadenza.Object.imp_valuta.width = 450
			idw_spesa.Object.c_importo_lire.width = 0
			idw_spesa.Object.importo.width = 485
			idw_gen_tot_ext.Modify("tot_documento_lire.visible = 0")
			idw_gen_tot_ext.Modify("tot_imposta_lire.visible = 0")
			idw_gen_tot_ext.Modify("tot_imponibile_lire.visible = 0")
			idw_gen_tot_ext.Modify("tot_merce_lire.visible = 0")
			idw_gen_tot_ext.Modify("netto_merce_lire.visible = 0")
			idw_gen_tot_ext.Modify("tot_omaggi_sc_merce_lire.visible = 0")
		
		end if
		idw_castelletto.SetRedraw(TRUE)
		idw_scadenza.SetRedraw(TRUE)
		idw_spesa.SetRedraw(TRUE)
	else
		
	end if
end if

decimal ld_man, ld_sconto1, ld_sconto2, ld_sconto3
string ls_mask_importi
long ll_id_valuta


if idw_castelletto.rowcount()>0 then
	If this.text = "Valuta di Conto" and idw_castelletto.rowcount()>0 then	
		ld_man=dw_documento_tot_ext_ff.getitemdecimal(1, "tot_manifattura")
		if isnull(ld_man) then ld_man=0
		ld_sconto1=dw_documento_tot_ext_ff.getitemdecimal(1, "sconto_inc")
		ld_sconto2=dw_documento_tot_ext_ff.getitemdecimal(1, "sconto_fin")
		ld_sconto3=dw_documento_tot_ext_ff.getitemdecimal(1, "sconto_cassa")
//		if ld_sconto1>0 then ld_sconto1/=idc_cambio
//		if ld_sconto2>0 then ld_sconto2/=idc_cambio
//		if ld_sconto3>0 then ld_sconto3/=idc_cambio
		if ld_sconto1>0 then ld_sconto1*=idc_cambio
		if ld_sconto2>0 then ld_sconto2*=idc_cambio
		if ld_sconto3>0 then ld_sconto3*=idc_cambio
		
		dw_documento_tot_ext_ff.setitem(1, "sconto_inc", ld_sconto1)
		dw_documento_tot_ext_ff.setitem(1, "sconto_fin", ld_sconto2)
		dw_documento_tot_ext_ff.setitem(1, "sconto_cassa", ld_sconto3)
//		if ld_man>0 then ld_man/=idc_cambio
		if ld_man>0 then ld_man*=idc_cambio
		
		dw_documento_tot_ext_ff.setitem(1, "tot_manifattura", ld_man)
		dw_documento_tot_ext_ff.modify("tot_metallo_lire.visible=0")
		dw_documento_tot_ext_ff.modify("tot_metallo.visible=1")
		
		ls_mask_importi=tab_1.tabpage_4.dw_documento_tot_ext_ff.describe("tot_merce.format")
		//ls_mask_importi=right(ls_mask_importi, len(ls_mask_importi)  - (pos("#", ls_mask_importi) ))
		//ll_id_valuta=idw_gen.getitemnumber(il_row, "documento_id_valuta_cod")
		tab_1.tabpage_4.dw_documento_tot_ext_ff.modify("tot_manifattura_netto.format='"+ls_mask_importi+"'")
		tab_1.tabpage_4.dw_documento_tot_ext_ff.modify("tot_sconti.format='"+ls_mask_importi+"'")
		tab_1.tabpage_4.dw_documento_tot_ext_ff.modify("tot_metallo_lire.format='"+ls_mask_importi+"'")
	elseif this.text <> "Valuta di Conto" and idw_castelletto.rowcount()>0 then	
		ld_man=dw_documento_tot_ext_ff.getitemdecimal(1, "tot_manifattura")
		ld_sconto1=dw_documento_tot_ext_ff.getitemdecimal(1, "sconto_inc")
		ld_sconto2=dw_documento_tot_ext_ff.getitemdecimal(1, "sconto_fin")
		ld_sconto3=dw_documento_tot_ext_ff.getitemdecimal(1, "sconto_cassa")
//		ld_sconto1*=idc_cambio
//		ld_sconto2*=idc_cambio
//		ld_sconto3*=idc_cambio
		ld_sconto1/=idc_cambio
		ld_sconto2/=idc_cambio
		ld_sconto3/=idc_cambio
		dw_documento_tot_ext_ff.setitem(1, "sconto_inc", ld_sconto1)
		dw_documento_tot_ext_ff.setitem(1, "sconto_fin", ld_sconto2)
		dw_documento_tot_ext_ff.setitem(1, "sconto_cassa", ld_sconto3)
//		ld_man*=idc_cambio
		ld_man/=idc_cambio
		
		dw_documento_tot_ext_ff.setitem(1, "tot_manifattura", ld_man)
		dw_documento_tot_ext_ff.modify("tot_metallo.visible=0")
		dw_documento_tot_ext_ff.modify("tot_metallo_lire.visible=1")
		ls_mask_importi=tab_1.tabpage_4.dw_documento_tot_ext_ff.describe("tot_merce_lire.format")
		//ls_mask_importi=right(ls_mask_importi, len(ls_mask_importi)  - (pos("#", ls_mask_importi) ))
		//ll_id_valuta=idw_gen.getitemnumber(il_row, "documento_id_valuta_cod")
		
		tab_1.tabpage_4.dw_documento_tot_ext_ff.modify("tot_manifattura_netto.format='"+ls_mask_importi+"'")
		tab_1.tabpage_4.dw_documento_tot_ext_ff.modify("tot_sconti.format='"+ls_mask_importi+"'")
		tab_1.tabpage_4.dw_documento_tot_ext_ff.modify("tot_metallo_lire.format='"+ls_mask_importi+"'")
	end if	
	
end if
end event

type cb_ricalcola_cast from w_documento_ordine_cx`cb_ricalcola_cast within tabpage_4
integer x = 2112
integer y = 1368
integer width = 453
integer height = 92
integer weight = 700
fontcharset fontcharset = ansi!
end type

event cb_ricalcola_cast::clicked;call super::clicked;
setpointer(hourglass!)
end event

type dw_documento_tot_ext_ff from w_documento_ordine_cx`dw_documento_tot_ext_ff within tabpage_4
integer y = 1484
integer width = 2455
end type

type cbx_gen_bollo from w_documento_ordine_cx`cbx_gen_bollo within tabpage_4
integer x = 2272
end type

type cb_applica from w_documento_ordine_cx`cb_applica within tabpage_4
boolean visible = false
integer x = 2107
integer y = 1200
integer width = 443
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
end type

type st_1 from w_documento_ordine_cx`st_1 within tabpage_4
integer x = 2062
integer y = 1056
end type

type st_val_corrente from w_documento_ordine_cx`st_val_corrente within tabpage_4
integer x = 2185
integer y = 1120
end type

type st_3 from w_documento_ordine_cx`st_3 within tabpage_4
integer x = 2185
integer y = 1224
end type

type st_2 from w_documento_ordine_cx`st_2 within tabpage_4
integer x = 2249
end type

type dw_scadenza_documento_lt from w_documento_ordine_cx`dw_scadenza_documento_lt within tabpage_4
integer x = 2121
integer width = 1467
end type

type dw_1 from w_documento_ordine_cx`dw_1 within tabpage_4
integer x = 2551
end type

type tabpage_5 from w_documento_ordine_cx`tabpage_5 within tab_1
integer width = 4059
integer height = 1944
end type

type dw_contr_documento_lt from w_documento_ordine_cx`dw_contr_documento_lt within tabpage_5
integer width = 3369
integer height = 1780
end type

type cb_ricerca from w_documento_ordine_cx`cb_ricerca within w_orafo_documento_ordine_cx
integer x = 1106
integer y = 16
integer height = 76
end type

event cb_ricerca::clicked;call super::clicked;if isvalid(u_ordini) then destroy u_ordini
//05-11-15
if isvalid(us_dati_partita.s_dw_aper_partita) then destroy(us_dati_partita.s_dw_aper_partita)
if isvalid(us_dati_partita.s_dw_scar_partita) then destroy(us_dati_partita.s_dw_scar_partita)
post wf_crea_oggetto_per_ordini()
//05-11-15 fine
post wf_controllo_saldi()
post wf_crea_datastore()
post wf_setta_mask_riga()
if isvalid(w_saldo_doc_pop) then
	close(w_saldo_doc_pop)
end if
tab_1.tabpage_7.dw_salva_prezzo_in_listino.reset()

if isvalid(ids_ev_forzata) then
	destroy ids_ev_forzata
end if
long ll_azzera[]
il_id_riga_cancellata=ll_azzera


end event

type cbx_simbolo from w_documento_ordine_cx`cbx_simbolo within w_orafo_documento_ordine_cx
boolean visible = false
integer x = 3758
integer y = 1872
integer width = 315
string text = "Simb. Val. "
end type

event cbx_simbolo::clicked;call super::clicked;wf_setta_mask_riga()
end event

type cb_contabilizza from w_documento_ordine_cx`cb_contabilizza within w_orafo_documento_ordine_cx
integer x = 795
integer y = 16
integer height = 76
integer taborder = 40
end type

type cb_calcolatrice from w_documento_ordine_cx`cb_calcolatrice within w_orafo_documento_ordine_cx
integer x = 3209
integer y = 152
integer width = 169
integer taborder = 70
string text = "Calc"
end type

type cbx_cod_barre from w_documento_ordine_cx`cbx_cod_barre within w_orafo_documento_ordine_cx
integer x = 1774
integer y = 164
integer width = 302
integer height = 64
integer taborder = 80
end type

type cb_lettore from w_documento_ordine_cx`cb_lettore within w_orafo_documento_ordine_cx
boolean visible = false
integer x = 2926
integer y = 16
integer width = 219
integer height = 76
end type

type cb_stampa_etichette from w_documento_ordine_cx`cb_stampa_etichette within w_orafo_documento_ordine_cx
integer x = 3410
integer y = 152
integer width = 219
integer taborder = 90
string text = "St. Etich"
end type

event cb_stampa_etichette::clicked;OpenWithParm ( w_orafo_stampa_etichette_rpt, idw_riga )
end event

type tv_1 from w_documento_ordine_cx`tv_1 within w_orafo_documento_ordine_cx
integer x = 2949
integer y = 1872
integer width = 178
integer height = 96
end type

type cb_duplica from w_documento_ordine_cx`cb_duplica within w_orafo_documento_ordine_cx
integer x = 2139
integer y = 16
integer height = 76
end type

event cb_duplica::clicked;//questa procedura crea un duplicato del doc corrente e ne cambia (chiedendo
//all'utente) il profilo (e quindi la causale e il magazzino) e l'intestatario

long ll_null_id
integer li_righe, i
long ll_null, ll_caus_mag, ll_id_locazione_1, ll_id_locazione_2, ll_id_variazione
long ll_id_prof, ll_id_art
decimal ldc_coef_calo
string ls_null, ls_cod_azienda
setnull(ls_null)

select rag_soc_1 into :ls_cod_azienda from azienda;  //20251025 per iniszare a implementare TITANS duplica senza derivazione cambiato cod_azienda in rag_soc_1
if text='&Duplica' then
	text='Completa'
	tab_1.tabpage_2.visible=false
	tab_1.tabpage_3.visible=false
	tab_1.tabpage_4.visible=false
	tab_1.tabpage_5.visible=false
	setnull(ll_null_id)
	//prima di tutto salvo il doc corrente
	//cb_salva.triggerevent(clicked!)
	//poi azzero tutti gli id riferiti a questo doc 
	//(doc e righe, scadenze, castelletti, spese ecc..)
	idw_gen.setitem(1, "id_documento", ll_null_id)
	setnull(il_id_documento)

	//Azzero altre
	idw_scadenza.reset()
	idw_spesa.reset()
	idw_castelletto.reset()
	idw_contropartita.reset()
	
	idw_gen.setitem(il_row,"id_prof_documento",ll_null_id)
	idw_gen.setitem(il_row,"c_prof_doc_cod",ls_null)
	idw_gen.setitem(il_row,"c_prof_doc_des",ls_null)
			
	idw_gen.setitem(il_row,"id_registro",ll_null_id)
	idw_gen.setitem(il_row,"c_registro_des",ls_null)		
	idw_gen.setitem(il_row,"documento_id_caus_magazzino",ll_null_id)
	idw_gen.setitem(il_row,"documento_data_ora_creazione", today())
	//cambio lo stato del record doc
	if idw_gen.setitemstatus(1, 0, primary!, Newmodified!)<>1 then
		messagebox("W", "ERRORE")
		return
	end if
	
	//poi chiedo all'utente profilo e nuovo intestatario
	f_displayonly(idw_gen, "c_prof_doc_cod", false)
	f_displayonly(idw_gen, "c_prof_doc_des", false)
	f_displayonly(idw_gen, "c_sog_comm_cod", false)
	f_displayonly(idw_gen, "c_sog_comm_des", false)
	idw_gen.enabled=true  
	
	is_tipo_documento=""
	messagebox("Vai", "Adesso cambia il profilo e l'intestatario, poi premi il bottone 'Completa'")
else
	text='&Duplica'
	
	if idw_gen.update()<>1 then
		messagebox("Ahi!", "Contattare supporto: AIUTOOOO!!!")
		return
	end if
	il_id_documento=idw_gen.getitemnumber(1, "id_documento")
	
	setnull(ll_null)
	//prendo id_caus e locazioni
	ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
	select id_caus_magazzino_prop, id_locazione_1_prop, id_locazione_2_prop
	into :ll_caus_mag, :ll_id_locazione_1, :ll_id_locazione_2
	from prof_documento
	where id_prof_documento=:ll_id_prof;
	ll_id_variazione=idw_gen.getitemnumber(1, "documento_id_variazione")
	li_righe=idw_riga.rowcount()
	for i= 1 to li_righe
		idw_riga.setitem(i, "id_riga_documento", ll_null)
		idw_riga.setitem(i, "id_documento", il_id_documento)
		idw_riga.setitem(i, "riga_documento_id_caus_magazzino", ll_caus_mag)
		if ll_id_locazione_1>0 then
			idw_riga.setitem(i, "id_locazione_1", ll_id_locazione_1)
		end if
		if ll_id_locazione_2>0 then
			idw_riga.setitem(i, "id_locazione_2", ll_id_locazione_2)
		end if
		if ll_id_variazione>0 then
			idw_riga.setitem(i, "riga_documento_id_listino", ll_id_variazione)
		end if
		//20220825 ANNA il calo = titolo sempre se id_prof=187 (XSALD)
		if pos(upper(ls_cod_azienda),"SILVER DR")>0  and ll_id_prof=187 then  //20251025 per iniszare a implementare TITANS duplica senza derivazione
			ll_id_art=idw_riga.getitemnumber(i, "riga_documento_id_articolo")
			select o.titolo into :ldc_coef_calo from orafo_titolo o, articolo a 
			where o.id_titolo=a.id_titolo and a.id_articolo=:ll_id_art;
			idw_riga.setitem(i, "coef_calo", ldc_coef_calo)
		elseif  pos(upper(ls_cod_azienda),"TITANS")>0 then  //20251025 per iniziare a implementare TITANS duplica senza derivazione potrei aver fatto...
			idw_riga.setitem(i, "id_riga_doc_provenienza", ll_null)  // //20251025 controlla con librerie di casa
			idw_riga.setitem(i, "qta_evasa", 0)
			idw_riga.setitem(i, "qta_evasa_un_base", 0)
			idw_riga.setitem(i, "peso_netto_evaso", 0)
		end if	
		//20220825 ANNA fine
		//cambio lo stato dei records
		idw_riga.setitemstatus(i, 0, primary!, Newmodified!)
	next
	cb_salva.triggerevent(clicked!)
	tab_1.tabpage_2.visible=true
	tab_1.tabpage_3.visible=true
	tab_1.tabpage_4.visible=true
	tab_1.tabpage_5.visible=true
end if

end event

type cb_stampa from w_documento_ordine_cx`cb_stampa within w_orafo_documento_ordine_cx
integer x = 2382
integer y = 8
integer width = 160
integer height = 120
integer taborder = 100
string picturename = "C:\nita\icone\Stampa.png"
end type

event cb_stampa::clicked;long ll_id_sog_com, ll_num_prog, ll_id_reg, ll_id_prof
string ls_tipo_reg, ls_test, ls_stampato, ls_par_automatica, ls_cod_azienda
datetime ld_a_data
uo_stampa_doc luo_stampa
long ll_id_prof_doc, ll_id_doc,ll_id_sog, ll_id_metallo
integer li_ret, li_retvalue
string ls_avvisa_se_stampato
date ldt_data_inizio, ldt_data_fine
decimal ldc_saldo
string ls_note_riep

//ib_genera_castelletto= TRUE
//SetPointer(HourGlass!)
//if idw_spesa.rowcount()<=0 then idw_spesa.TriggerEvent("ue_aggiorna")
//tab_1.tabpage_4.dw_cast_iva_documento_lt.TriggerEvent("ue_calc_cast_iva")
//ib_askforsave=FALSE	
//tab_1.tabpage_4.dw_cast_iva_documento_lt.Trigger Event ue_update(0,0)
//li_retvalue=idw_master.trigger Event ue_update(0,0)
//messagebox("Attenzione!", string(li_retvalue))


select codice into :ls_cod_azienda from azienda;
//controlla se stampato, s sì avverti
if ls_cod_azienda='SILVERDR' then
	//20230503 se è orbol (id=114) e il saldo au è negativo blocca la stampa
	ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
	if ll_id_prof=114 then
		ldt_data_inizio=date("01/01/"+string(year(today())))
		ldt_data_fine=idw_gen.getitemdate(1, "data_documento")
		ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
		ll_id_metallo=4  //oro AU
		SELECT sum(if "caus_magazzino"."segno"='S' then "riga_documento"."peso_netto" * "riga_documento"."coef_calo" /1000 * -1 
		else "riga_documento"."peso_netto" * "riga_documento"."coef_calo" /1000 end if) into :ldc_saldo
  	 	FROM "riga_documento", "documento",   "articolo", "orafo_metallo","orafo_titolo" , "caus_magazzino" , orafo_tipo_partita
  		WHERE ( "caus_magazzino"."id_caus_magazzino" = "riga_documento"."id_caus_magazzino" ) and  
         ( "documento"."id_documento" = "riga_documento"."id_documento" ) and  ( "articolo"."id_articolo" = "riga_documento"."id_articolo" ) and  
         ( "orafo_titolo"."id_metallo" = "orafo_metallo"."id_metallo" ) and  ( "orafo_titolo"."id_titolo" = "articolo"."id_titolo" ) and  (documento.id_sog_commerciale=:ll_id_sog) 
		and  (orafo_metallo.id_metallo=:ll_id_metallo) and (  "caus_magazzino"."segno" is not null ) AND  (orafo_tipo_partita.id_tipo_partita = caus_magazzino.id_tipo_partita) and 
         ( orafo_tipo_partita.cod_tipo_partita ='ACLC' or  orafo_tipo_partita.cod_tipo_partita ='SCLC')   and
         ("documento"."data_documento" >= :ldt_data_inizio AND  "documento"."data_documento" <= :ldt_data_fine)  ;
		if ldc_saldo<0 then
			messagebox("Attenzione!", "Controlla saldo AU!!! Sembra sia negativo!!!!")
			return
		end if
	end if
	//20230503 fine
		
	openwithparm(w_stessa_riga_provenienza, il_id_documento)
	if message.doubleparm>0 then
		messagebox("Attenzione!", "Documento con righe con la stessa provenienza!")
	end if
	ls_stampato=idw_gen.getitemstring(1, "documento_stampato")
	if ls_stampato='N' then
		//segniamo stampato il doc 
		idw_gen.setitem(1, "documento_stampato", "S")
	else
		select avvisa_se_stampato
		into :ls_avvisa_se_stampato
		from dba.orafo_par_sistema
		;
		if ls_avvisa_se_stampato='S' then messagebox("Attenzione!", "Documento già stampato!")
	end if
	//controlla profilo (silver 01-12-2016)
	wf_controlla_profilo()
end if


// questo va tolto nella nuova versione!!! 20260228
if (idw_master.uf_to_update() > 0) OR (idw_master.GetItemStatus(il_row,0,Primary!)=New!) then	
	ii_sal_automatico=1
	wf_salva_automaticamente()
	ii_sal_automatico=0
end if
// questo va tolto nella nuova versione!!! 20260228 fine

ll_id_reg=idw_gen.getitemnumber(1, 'id_registro')
select tipo_registro
into :ls_tipo_reg
from registro
where id_registro=:ll_id_reg;

if left(ls_tipo_reg, 1)='D' or left(ls_tipo_reg, 1)='I' then
	ll_id_doc=idw_gen.getitemnumber(1, 'id_documento')
	if ls_tipo_reg="DV" then
		select par_automatica
		into :ls_par_automatica
		from dba.orafo_par_sistema
		;
		if ls_par_automatica='S' then 
			if ll_id_prof=66 then 
				f_partite_automatiche(ll_id_doc, "S")
			else
				f_partite_automatiche(ll_id_doc, "N")
			end if
		end if
	end if
	luo_stampa=create uo_stampa_doc
	ll_num_prog=idw_gen.getitemnumber(1, 'num_progressivo')
	
	ll_id_sog_com=idw_gen.getitemnumber(1, 'id_sog_commerciale')
	ld_a_data=idw_gen.getitemdatetime(1, 'documento_data_ora_creazione')
	ll_id_reg=idw_gen.getitemnumber(1, 'id_registro')
	luo_stampa.uf_trova_saldi_metallo(ll_id_sog_com, ld_a_data, ll_id_reg, ll_num_prog, ll_id_doc )
	destroy luo_stampa
end if
ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
wf_rec_prezzi_silver(ll_id_prof, ls_cod_azienda, ls_tipo_reg, ll_id_sog_com)
//if ls_cod_azienda="PANNA" and ls_tipo_reg="DV" and  ll_id_sog_com=1869  then
//	tab_1.tabpage_2.cb_rec_prezzi.trigger event clicked()
//	idw_riga.Event ue_update(0,0)
//end if

//20261015 LaBella - FATTURA C/LAVORAZIONE (prof. FATLAV): prima di stampare riscrivo in fondo
//         alle note il riepilogo degli scarichi per proforma e metallo (prima lo scriveva a mano
//         il cliente). Il documento e' gia' stato salvato qui sopra (wf_salva_automaticamente).
//         La funzione aggiorna direttamente dba.documento: qui riallineo solo la dw a video.
if ls_cod_azienda='LABELLA' then
	ll_id_doc=idw_gen.getitemnumber(1, 'id_documento')
	if f_agg_note_riep_proforma_labella(ll_id_doc, ls_note_riep)=1 then
		idw_gen.setitem(1, "documento_note_intestazione", ls_note_riep)
		idw_gen.setitemstatus(1, "documento_note_intestazione", Primary!, NotModified!)
	end if
end if


//140213 samy: se un legato NON è valorizzato blocco la stampa
li_ret=wf_controlla_legato()
if li_ret= -1 then return
//fine 140213



uf_stampa()


		
		
		
end event

event cb_stampa::rbuttondown;call super::rbuttondown;long ll_id_prof_doc, ll_id_conf_oggetti, ll_job, ll_id_sog, ll_id_reg, ll_id_prof, ll_utente
string ls_nome_report,ls_cod_profilo, ls_path_libreria, dwsyntax, ls_ret, ls_printer, ls_ret2, ls_invia, ls_cod_azienda,ls_tipo_reg, ls_rag_soc
string ls_ret3
integer li_retvalue, li_ret
uo_mail u_mail

datastore ds_stampa

select codice, rag_soc_1 into :ls_cod_azienda, :ls_rag_soc from azienda;

ll_id_reg=idw_gen.getitemnumber(1, 'id_registro')
select tipo_registro
into :ls_tipo_reg
from registro
where id_registro=:ll_id_reg;
ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento") 
//20230727 Luisa NON vuole che parta anche per lei (Italpanna e c. hanno codice SILVERDR)
//20230920 così parte SOLO per Silverdreams!
if pos(upper(ls_rag_soc), "SILVER DREAMS")>0 then //aggiustato anche per samy 20210219  (pos(upper(ls_azienda),"PANNA")>0 and ls_tipo_reg="DV" and  ll_id_sog=1869) or
	tab_1.tabpage_2.cb_rec_prezzi.trigger event clicked()
	idw_riga.Event ue_update(0,0)
end if
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
	ib_askforsave=false
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
	
	ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
	wf_rec_prezzi_silver(ll_id_prof, ls_cod_azienda, ls_tipo_reg, ll_id_sog)
//	if pos(ls_cod_azienda,"SILVERDR")>0  and ls_tipo_reg="DV" and  (ll_id_sog=43 or ll_id_sog=1862 )  then //deve partire il recupera prezzi per karizia ma anche per panna
//		tab_1.tabpage_2.cb_rec_prezzi.trigger event clicked()
//		idw_riga.Event ue_update(0,0)
//	end if

	
	if ll_id_conf_oggetti>0 then
		dwsyntax = LibraryExport(ls_path_libreria, ls_nome_report, ExportDataWindow!)
		IF dwsyntax>"" THEN
			ds_stampa.create(dwsyntax)
			ds_stampa.settransobject(sqlca)
		else
			messagebox("Errore!", "Libreria o report non trovati: "+ls_path_libreria +"-"+ls_nome_report)
			//printclose(ll_job)
			return
		end if
	end if
	li_ret=ds_stampa.retrieve(il_id_documento)
	//non si vuole il prezzo! Samy 04-10-2017 da oggi 20210920 no, si guarda la tabella (vedi sopra all'inizio
	if ls_ret='S' then
		ls_ret2=ds_stampa.Modify("c_prezzo.visible=1")
		ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=1")
	else
		ls_ret2=ds_stampa.Modify("c_prezzo.visible=0")
		ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=0")
	end if
	//ls_ret2=ds_stampa.Modify("riga_documento_tot_riga_val_doc.visible=0")
	ls_printer=ds_stampa.describe ('DataWindow.Printer')
		//ds_stampa.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
		//20241007 inizio
	ll_utente=u_freddie.s_utenti.i_idutente
	if  pos(upper(ls_rag_soc), "SILVER DR")>0 and ll_utente<> 34 and ll_utente<> 40 and ll_utente<> 42 then  //20241007 proviamo così: se è+ silverdreams e non SONO ANNA 40, DANIELA 42 E SAMY 34 ALLORA STAMPO NELLA 
		ls_ret3=ds_stampa.Modify("DataWindow.Print.printername = 'KONICA MINOLTA C250i'")  
		ls_ret3=ds_stampa.Modify("DataWindow.Print.paper.size= 11")  //11= A5
		ls_ret3=ds_stampa.Modify("DataWindow.Print.paper.source= 2")   //vassoio sotto (2)
	end if
	
	ls_printer=ds_stampa.describe("DataWindow.Print.paper.size")
	ls_printer=ds_stampa.describe("DataWindow.Print.paper.source")
	ls_printer=ds_stampa.describe ('DataWindow.Printer')
		//20241007 fine
	//fine prezzo
	//20240503 lo richiese luly per italpanna solo una stampa
	if pos(ls_rag_soc, "Italpanna")>0 then
		if ll_id_sog=1924 and ll_id_prof_doc=66 then
			ds_stampa.Modify("DataWindow.Print.copies = 1")
		end if
	else
		ds_stampa.Modify("DataWindow.Print.copies = 2")
	end if
	
	//ls_cod_profilo=idw_gen.getitemstring(ll_row,"prof_documento_codice")
	//ls_num_doc=ds_documenti.getitemstring(ll_row,"documento_num_documento")
	//ldt_data_doc=ds_documenti.getitemdate(ll_row,"documento_data_documento")
	//ls_nome_file=ls_dir_export+ls_cod_profilo+ls_num_doc+".pdf"
					
	ls_ret2=ds_stampa.Modify("DataWindow.Print.documentName = 'RBOL'")
	
	if ls_ret2<>"" then 
		messagebox("Errore!", "Documento non stampato!")
	else
		ll_job=printopen()
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
	u_mail.of_prepara_campi_mail(il_id_documento)
	u_mail.of_allega_files(il_id_documento, ls_ret )
	u_mail.of_crea_pdf(il_id_documento, ls_ret, "N")
	//u_mail.of_invia_mail("MAIL", ls_ret, true, true)  //20261126 si passa a of_new_mailsender come nella 64_2025
	u_mail.of_new_mailsender("MAIL", ls_ret, true, true) //il primo è il codice della riga con i dati per inviare la mail, il secondo il "vedi prezzi", il terzo e il quarto per creare o no file di log e debug
end if






end event

type p_video from w_documento_ordine_cx`p_video within w_orafo_documento_ordine_cx
boolean visible = false
integer x = 617
integer y = 40
string picturename = "C:\nita\icone\old\CLIPBRD.bmp"
end type

type cb_var_prezzo from commandbutton within tabpage_1
integer x = 2053
integer y = 1468
integer width = 704
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Variazione Prezzo"
end type

event clicked;long ll_row, ll_id_documento

ll_row=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
if ll_row>0 then
	ll_id_documento=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_row, "id_documento")
	if ll_id_documento>0 then
		openwithparm(w_prezzo_documento_gd, ll_id_documento)
	else
		messagebox("Attenzione!", "Salvare il documento prima di inserire variazioni di prezzo!")
	end if
end if
end event

type dw_orafo_wizard from datawindow within tabpage_1
integer x = 2821
integer y = 1120
integer width = 699
integer height = 164
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_orafo_wizard_ext"
boolean border = false
boolean livescroll = true
end type

event clicked;uo_or_documento uo_doc
string ls_cod_sog, ls_oggetto
u_dw_master_main udw_doc


if dwo.name='p_lancia' then
	ls_cod_sog=idw_gen.getitemstring(1, "c_sog_comm_cod")
	
	if ls_cod_sog>'' then
		ls_oggetto=getitemstring(1, "wizard")
		udw_doc=dw_documento_ordine_ff
		uo_doc=create uo_or_documento
		uo_doc.of_orafo_wizard(ls_oggetto, udw_doc,ls_cod_sog )
		destroy uo_doc
	end if
end if
end event

type cb_1 from commandbutton within tabpage_1
integer x = 50
integer y = 1132
integer width = 343
integer height = 100
integer taborder = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deriva Silver"
end type

event clicked;

long				ll_row, ll_Id_Sog_Comm, ll_my_id[]
string			ls_nome[], ls_Codice, ls_Descrizione, ls_appoggio
integer			li_size, li_i
s_par_der_doc	ls_par, ls_par2, ls_par3
window			lw_1





ll_row = idw_gen.getRow()

li_size = 1
ls_par.s_dbn[li_size] = "der_profilo.id_prof_documento_derivato"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_prof_documento")
li_size++
ls_par.s_dbn[li_size] = "documento.id_sog_commerciale"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_sog_commerciale")
li_size++
ls_par.s_dbn[li_size] = "documento.id_destinazione"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_destinazione")
li_size++
ls_par.s_dbn[li_size] = "documento.id_magazzino"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("documento_id_magazzino")


li_size++
ls_par.s_dbn[li_size] = "documento.id_gruppo_agenti"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_gruppo_agenti")
li_size++
ls_par.s_dbn[li_size] = "documento.id_valuta"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("documento_id_valuta_cod")
li_size++
ls_par.s_dbn[li_size] = "documento.id_con_pagamento"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_con_pagamento")
li_size++
ls_par.s_dbn[li_size] = "documento.id_gruppo_agenti_2"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_gruppo_agenti_2")
//agg. 02-02-10 mm per Filtro per Samy
if idw_gen.uf_get_colval("documento_ordinato_fo")='S' then
	li_size++
	ls_par.s_dbn[li_size] = "documento.ordinato_fo"
	ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("documento_ordinato_fo")
end if
//fine
ls_par.a_optional[1] = idw_gen.uf_get_colval("data_registrazione")
for li_i = 1 to li_size
	ls_par.s_op[li_i] = "="
	ls_par.s_dbt[li_i] = "N"
next

OpenWithParm(lw_1, ls_par, "w_check_deriva_silver_wz")
ls_par2 = Message.PowerObjectParm

If IsValid(ls_par2) then
	If ((IsNull(ls_par.s_dbv[2]) OR ls_par.s_dbv[2]="")) AND &
	   not((IsNull(ls_par2.s_dbv[2]) OR ls_par2.s_dbv[2]="")) then
		
		
		idw_gen.uf_Set_colval("id_sog_commerciale", ls_par2.s_dbv[2])
		ll_Id_Sog_Comm=Long(ls_par2.s_dbv[2])
		SELECT "sog_commerciale_gen"."codice",   
					"sog_commerciale_gen"."rag_soc_1"  
			INTO  :ls_Codice, :ls_Descrizione  
			FROM "dba"."sog_commerciale_gen"  
			WHERE "sog_commerciale_gen"."id_sog_commerciale" = :ll_Id_Sog_Comm ;
		If SQLCA.SQLCode =0 then
			idw_gen.uf_Set_colval("c_sog_comm_cod", ls_Codice)
			idw_gen.uf_Set_colval("c_sog_comm_des", ls_Descrizione)
			idw_gen.TriggerEvent("ue_set_sog_fields")
		end if

	end if

end if
if isValid(ls_par2) and not(IsNull(ls_par2.s_dbv[2]) OR ls_par2.s_dbv[2]="") then	
		OpenWithParm(lw_1, ls_par2, "w_deriva_silver_wz")
		ls_par3 = Message.PowerObjectParm
		if isValid(ls_par3) then
				
				ls_appoggio = ls_par3.a_optional[2]
				
				ll_row = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"imp_acconto",ls_par3.a_optional[1] )
				
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"id_tipo_pag_Acconto",				long(wf_decode_key(1,ls_appoggio)) )
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"Id_tab_iva_Acconto",				long(wf_decode_key(2,ls_appoggio)) )
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"Id_Val_Acconto",						long(wf_decode_key(3,ls_appoggio)) )
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"id_banca_sog_commerciale",		long(wf_decode_key(4,ls_appoggio)) )
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"id_destinazione",					long(wf_decode_key(5,ls_appoggio)) )
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"id_con_pagamento_des",				long(wf_decode_key(6,ls_appoggio)) )	
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"documento_id_valuta_des",			long(wf_decode_key(7,ls_appoggio)) )
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"documento_sconto_fin_cassa",		dec(wf_decode_key(9,ls_appoggio)) )
						
				string	ls_sconto_fin
				ls_sconto_fin = wf_decode_key(8,ls_appoggio)
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"documento_sconto_finanziario",		ls_sconto_fin )
				
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"id_gruppo_agenti",			long(wf_decode_key(10,ls_appoggio)) )
				
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"id_gruppo_agenti_2",			long(wf_decode_key(11,ls_appoggio)) )

				
				tab_1.tabpage_1.dw_documento_ordine_ff.setitem &
						( ll_row,"sconto_fin_incondizionato",		dec(wf_decode_key(12,ls_appoggio)) )
				
				
				wf_setta_cambio(3,"")
		
				
				tab_1.tabpage_1.dw_documento_ordine_ff.event ue_set_calc_fields()
						
				tab_1.selecttab(2)		
				uf_importa_righe (ls_par3)

		end if
end if



end event

type cb_prezzi_confermati from commandbutton within tabpage_1
boolean visible = false
integer x = 2743
integer y = 32
integer width = 654
integer height = 112
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Conferma Prezzi"
end type

event clicked;string ls_stampato
long ll_righe
integer i

ll_righe=idw_riga.rowcount()

ls_stampato=idw_gen.getitemstring(1, "documento_stampato")

if ls_stampato='E' then
	ls_stampato="X"
else
	ls_stampato="C"
end if
idw_gen.setitem(1, "documento_stampato", ls_stampato)

for i= 1 to ll_righe
	idw_riga.setitem(i, "riga_documento_da_stampare", ls_stampato)
next 

messagebox("Attenzione!", "Salvare il documento per rendere effettiva la conferma dei prezzi!")
end event

type cb_controlla_bollettine from commandbutton within tabpage_1
boolean visible = false
integer x = 2743
integer y = 180
integer width = 654
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Controlla BOL"
end type

event clicked;s_date_estr_cc s_date

if idw_gen.rowcount()=1 then
	s_date.a_data=idw_gen.getitemdate(1, "data_documento")
	s_date.da_data=relativedate(s_date.a_data, -30)
	openwithparm(w_trova_bol_modificata_non_derivata, s_date)
end if
end event

type cb_cambia_iva from commandbutton within tabpage_1
boolean visible = false
integer x = 2743
integer y = 328
integer width = 654
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cambia IVA"
end type

event clicked;integer i


open(w_cambia_iva_gd)
if isvalid(message) then
	il_id_tab_iva=message.doubleparm
	for i= 1 to idw_riga.rowcount()
		idw_riga.setitem(i, "riga_documento_id_tab_iva", il_id_tab_iva)
	next
	idw_riga.triggerevent("ue_update")
end if
for i=1 to tab_1.tabpage_4.dw_spesa_documento_gd.rowcount()
	tab_1.tabpage_4.dw_spesa_documento_gd.post setitem(i, "id_tab_iva_cod", il_id_tab_iva)
next
end event

type cb_5 from commandbutton within tabpage_1
integer x = 2743
integer y = 476
integer width = 654
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Controlla Tot. Doc. Derivati"
end type

event clicked;if il_id_documento> 0 then openwithparm(w_controlla_tot_doc_derivati, il_id_documento)
end event

type cb_6 from commandbutton within tabpage_1
integer x = 2743
integer y = 624
integer width = 654
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Art. Già Ordinati"
end type

event clicked;s_array ll_id
integer i
long ll_riga_inserita

ll_id.ll_id_doc[1]=idw_gen.getitemnumber(1, "id_prof_documento")
ll_id.ll_id_doc[2]=idw_gen.getitemnumber(1, "id_sog_commerciale")

openwithparm(w_trova_art_gia_ordinati, ll_id)

ll_id=message.powerobjectparm
if isvalid(ll_id) then
	idw_gen.trigger event ue_update(0,0)
	for i = 1 to upperbound(ll_id.as_string)
		ll_riga_inserita=idw_riga.trigger event ue_insert(0, 0)
		idw_riga.setitem(ll_riga_inserita, "c_articolo_cod", ll_id.as_string[i] )
		idw_riga.trigger event itemchanged(ll_riga_inserita, idw_riga.object.c_articolo_cod, ll_id.as_string[i])
	next
	tab_1.SelectedTab = 2
end if
end event

type cb_rbol_non_derivati from commandbutton within tabpage_1
boolean visible = false
integer x = 2743
integer y = 772
integer width = 654
integer height = 112
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "RBOL NON DERIVATI"
end type

event clicked;open(w_rbol_non_derivati)
end event

type cb_12 from commandbutton within tabpage_1
boolean visible = false
integer x = 393
integer y = 1764
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;string ls_cod_prof


ls_cod_prof=idw_gen.getitemstring(1, "c_prof_doc_cod")
if upper(ls_cod_prof)="SALD" then
	f_crea_ds_bol_urgenti()
	ds_excel=create datastore
	ds_excel.dataobject="d_EXT_PER_IMPORT"
	//ds_excel.settransobject(sqlca)
	ds_excel.importfile("C:\nita\xlsurgenti\bol_urgenti.txt")
	
end if
end event

type cb_cambia_prof from commandbutton within tabpage_1
integer x = 3415
integer y = 260
integer width = 617
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cambia Prof."
end type

event clicked;long LL_ID_PROF
integer li_ret

open(w_password_pop)
li_ret=Message.DoubleParm
if li_ret=1 then 

	if il_id_documento>0 then
		LL_ID_PROF=dw_5.getitemnumber(1, "id_prof")
		if LL_ID_PROF> 0 then
			messagebox("Attenzione!", "Sei sicuro di voler cambiare il profilo documento?")
			update documento
			set id_prof_documento=:LL_ID_PROF
			where id_documento=:il_id_documento;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Salvataggio NON riiuscito!")
			end if
		else
			messagebox("Attenzione!", "Scegli il profilo prima di tutto!!!!")
		end if
	else
		messagebox("Attenzione!", "Scegli un documento e caricalo prima di cambiare il profilo!")
	end if
else
	messagebox("Attenzione!", "Password errata!!")
end if
end event

type dw_5 from udw_001 within tabpage_1
integer x = 3415
integer y = 48
integer width = 617
integer height = 200
integer taborder = 42
boolean bringtotop = true
string dataobject = "d_prof_per_cambio"
end type

type pb_excel from picturebutton within tabpage_1
integer x = 3547
integer y = 408
integer width = 398
integer height = 344
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\xls_down.jpg"
alignment htextalign = left!
end type

event clicked;integer li_y, i, li_num_riga
string ls_codice_azienda, ls_num_doc, ls_des2, ls_doc_controllato
datastore ds_silver
//datawindowchild dwc_galvanica
decimal ldc_imponibile, ldc_imposta, ldc_totale , ldc_tara,ldc_prezzo_attuale, ldc_test
long ll_id_uc,ll_num_prog, ll_id_art,ll_test, ll_id_sog
date ldt_data_doc, ldt_2_mesi_prima, ldt_modifica_listino, ldt_data_fine,ldt_primo_gmese


	
	select rag_soc_1
	into :ls_codice_azienda
	from azienda
	;
//	if pos(upper(ls_codice_azienda),'SILVER')>0 or pos( upper(ls_codice_azienda),'PANNA')>0   then
		tab_1.tabpage_2.dw_6.setredraw(false)
		//ds_silver=create datastore
		tab_1.tabpage_2.dw_6.dataobject="d_orafo_riga_documento_silver_stampa"
		tab_1.tabpage_2.dw_6.settransobject(sqlca)
		idw_riga.rowscopy(1,idw_riga.RowCount(), Primary!, tab_1.tabpage_2.dw_6, 1, Primary!)
		if rb_per_articolo.checked then
			tab_1.tabpage_2.dw_6.setsort("riga_documento_id_articolo")
			tab_1.tabpage_2.dw_6.sort()
		else
			tab_1.tabpage_2.dw_6.setsort("c_ordina_num_doc_provenienza, riga_documento_num_riga")
			tab_1.tabpage_2.dw_6.sort()
		end if
		
		ldt_data_doc=idw_gen.getitemdate(1, "data_documento")
		ldt_2_mesi_prima=date(string(year(ldt_data_doc))+"/"+string(month(ldt_data_doc))+"/01" )
		//ldt_2_mesi_prima=relativedate(ldt_2_mesi_prima, -60) //NO! Deve essere al primo del mese, come prima 20230406 
		for i=1 to tab_1.tabpage_2.dw_6.rowcount()
			
			ldc_tara=tab_1.tabpage_2.dw_6.getitemdecimal(i, "riga_documento_peso_lordo")
			if isnull(ldc_tara) or ldc_tara=0 then
				ll_id_uc=tab_1.tabpage_2.dw_6.getitemdecimal(i, "riga_documento_ID_unita_CONFEZIONE")
				select des_2 into :ls_des2 from dba.prezzo
				where id_unita_confezione=:ll_id_uc and id_variazione=15
				;
				if pos(upper(ls_des2), "KI4")>0 then //se KI4 in des_2 allora è rosso il background campo articolo è rosso
					tab_1.tabpage_2.dw_6.setitem(i, "id_locazione_2", 100)
				end if
			end if
			ll_id_uc=0
			ldc_prezzo_attuale=0
			ll_id_uc=tab_1.tabpage_2.dw_6.getitemnumber(i, "riga_documento_id_unita_confezione")
			//20250409 se l'articolo è presente in una fattura precedente con data stesso mese allora segno la riga in qualche modo
			if ll_id_uc>0 then
				ll_test=0
				ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
				ldt_primo_gmese=date("01/"+string(month(ldt_data_doc))+"/"+string(year(ldt_data_doc)))
				select first(id_riga_documento) into :ll_test from dba.riga_documento r, dba.documento d , dba.registro reg
				where d.id_documento=r.id_documento and r.id_unita_confezione=:ll_id_uc and reg.id_registro=d.id_registro
				and d.id_sog_commerciale=:ll_id_sog 
				and reg.tipo_registro='IV' and d.data_documento < :ldt_data_doc and d.data_documento>= :ldt_primo_gmese;
				if ll_test> 0 then
					tab_1.tabpage_2.dw_6.setitem(i, "cmc", 1)  //se cmc=1 il colore del campo id_articolo sara giallo (background)
				end if
				
			end if
			//fine 20250409
			ldc_prezzo_attuale=tab_1.tabpage_2.dw_6.getitemdecimal(i, "prezzo_complessivo")
			if ldc_prezzo_attuale>0 and ll_id_uc>0  then
				ll_num_prog=0
				ldc_test=0
				ldt_data_fine=relativedate(ldt_data_doc, 15)
				select prezzo  into :ldc_test from dba.prezzo p where p.id_unita_confezione= :ll_id_uc and p.id_variazione=15 and p.ultima_modifica>=:ldt_2_mesi_prima and p.ultima_modifica<=:ldt_data_fine ;
				ll_id_art=tab_1.tabpage_2.dw_6.getitemnumber(i, "riga_documento_id_articolo")
				if ldc_test>0 then
					ll_num_prog=2
					ls_doc_controllato='N'
				end if					
				if ll_num_prog>0 and (isnull(ls_doc_controllato) or ls_doc_controllato="N") then
					tab_1.tabpage_2.dw_6.setitem(i, "riga_documento_dim_p", 2)  // 2= sottolineato  se trovo il doc e NON è una fat. controllata metto grassetto: prezzo da controllare!!!
				else
					tab_1.tabpage_2.dw_6.setitem(i, "riga_documento_dim_p", 1)
				end if
				
			end if
			//fine 05/12/2021)
		next
				
		ls_num_doc="N. "+ idw_gen.getitemstring(1, "num_documento")
		ls_num_doc+= " del "+string(ldt_data_doc)
		//ls_num_doc= "t_num_doc.text= "+ls_num_doc
		tab_1.tabpage_2.dw_6.modify("t_num_doc.text='"+ls_num_doc+"'")
		//23-04-2016 aggiungo intestazione e totali documento
		tab_1.tabpage_2.dw_6.object.t_intestazione.text="Brogliaccio "+ls_num_doc
		ldc_imponibile=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imponibile_lire")
		ldc_imposta=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imposta_lire")
		ldc_totale=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_documento_lire")
		tab_1.tabpage_2.dw_6.object.t_imponibile.text=string(ldc_imponibile, "#,0.00")
		tab_1.tabpage_2.dw_6.object.t_imposta.text=string(ldc_imposta, "#,0.00")
		tab_1.tabpage_2.dw_6.object.t_totale.text=string(ldc_totale, "#,0.00")
		//fine 23-04-2016
		//ds_silver.print()
		tab_1.tabpage_2.dw_6.setredraw(true)
		f_doc_excel(tab_1.tabpage_2.dw_6)
//	else
//		idw_riga.object.c_tot_righe.visible="0"
//		idw_riga.object.linea.visible="0"
//		idw_riga.object.c_tot_righe_t.visible="0"
//		idw_riga.object.c_tot_righe_lire_t.visible="0"
//		idw_riga.object.c_tot_righe_lire.visible="0"
//			
//		idw_riga.print()	
//		idw_riga.object.c_tot_righe.visible="1"
//		idw_riga.object.linea.visible="1"
//		idw_riga.object.c_tot_righe_t.visible="1"
//		idw_riga.object.c_tot_righe_lire_t.visible="1"
//		idw_riga.object.c_tot_righe_lire.visible="1"
//	
//	end if

end event

type rb_per_articolo from radiobutton within tabpage_1
integer x = 3520
integer y = 760
integer width = 485
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordina per Articolo"
end type

type rb_per_riga from radiobutton within tabpage_1
integer x = 3520
integer y = 844
integer width = 398
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordina per riga"
boolean checked = true
end type

type cb_13 from commandbutton within tabpage_1
integer x = 3415
integer y = 1024
integer width = 617
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Estrai Bollettine"
end type

event clicked;long ll_id_prof, ll_riga_inserita, ll_riga_doc_provenienza
integer i
string ls_num_bollettina, ls_file
datastore ds_estrai_bol

ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
ds_estrai_bol= create datastore
ds_estrai_bol.dataobject="d_estrai_bol"
if  ll_id_prof=130 or  ll_id_prof=184  then //20251020 è il sald  //20251025 184 è il buratto deve farlo anche lì (Francesco)
	for i = 1 to idw_riga.rowcount()
		ls_num_bollettina=""
		ll_riga_doc_provenienza=0
		ll_riga_doc_provenienza=idw_riga.getitemnumber(i, "riga_documento_provv_imp_subage_2")
		select right(num_documento, 7) into :ls_num_bollettina from dba.documento d, dba.riga_Documento r
		where d.id_documento=r.id_documento and r.id_riga_documento=:ll_riga_doc_provenienza;
		if len(ls_num_bollettina) =7 then
			ll_riga_inserita=ds_estrai_bol.insertrow(0)
			ds_estrai_bol.setitem(ll_riga_inserita, "num_bollettina",ls_num_bollettina )
		end if	
	next
elseif  ll_id_prof=66 then
	for i = 1 to idw_riga.rowcount()
		ls_num_bollettina=""
		ll_riga_doc_provenienza=0
		ll_riga_doc_provenienza=idw_riga.getitemnumber(i, "id_riga_doc_provenienza")
		select right(num_documento, 7) into :ls_num_bollettina from dba.documento d, dba.riga_Documento r
		where d.id_documento=r.id_documento and r.id_riga_documento=:ll_riga_doc_provenienza;
		if len(ls_num_bollettina) =7 then
			ll_riga_inserita=ds_estrai_bol.insertrow(0)
			ds_estrai_bol.setitem(ll_riga_inserita, "num_bollettina",ls_num_bollettina )
		end if	
	next
end if
ls_file=idw_gen.getitemstring(1, "c_prof_doc_cod")
ls_file+="_"+idw_gen.getitemstring(1, "num_documento")

ds_estrai_bol.saveas("c:\nita\excel\"+ls_file+".xls", Excel!, true)
destroy ds_estrai_bol
end event

type r_1 from rectangle within tabpage_1
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 3474
integer y = 396
integer width = 329
integer height = 176
end type

type r_2 from rectangle within tabpage_1
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 3141
integer y = 844
integer width = 329
integer height = 176
end type

type pb_riep_pesi from picturebutton within tabpage_2
integer x = 1815
integer y = 796
integer width = 119
integer height = 96
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Bilancia.png"
string disabledname = "s:\pb\detail.bmp"
alignment htextalign = left!
end type

event clicked;
openwithparm(w_orafo_riepilogo_pesi, tab_1.tabpage_2.dw_riga_documento_ordine_gd)
end event

type cb_quotazione from commandbutton within tabpage_2
integer x = 2318
integer y = 804
integer width = 123
integer height = 84
integer taborder = 41
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quot."
end type

event clicked;integer i , a, up
long ll_id_met
decimal ld_prezzo_manifattura, ld_peso_gr, ld_fino_calo, ld_pr_complessivo, ld_cambio
string ls_tipo_um
s_quotazione s_quot
openwithparm(w_met_quotazione_gd, idc_cambio)

s_quot=message.powerobjectparm
if isvalid(s_quot) then
	up=upperbound(s_quot.metallo[])
	if up>0 then
		for a= 1 to idw_riga.rowcount()
			ls_tipo_um=idw_riga.getitemstring(a, "tipo_um")
			if ls_tipo_um<>'P' then continue
			ld_pr_complessivo=idw_riga.getitemdecimal(a, "prezzo_complessivo")
			if ld_pr_complessivo>0 then continue
			ll_id_met=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemnumber(a, "articolo_metallo")
			select id_metallo
			into :ll_id_met
			from orafo_titolo
			where id_titolo=:ll_id_met;
			
			for i = 1 to up
				if ll_id_met=s_quot.metallo[i] then
					idw_riga.setitem(a, "prezzo_metallo", s_quot.quotazione[i])
					wf_calcola_prezzo(a)
					exit
				end if
			next
		next
	end if
end if
end event

type pb_stampa_righe from picturebutton within tabpage_2
integer x = 1568
integer y = 796
integer width = 119
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Stampa.png"
alignment htextalign = left!
end type

event clicked;
	tab_1.tabpage_4.cb_ricalcola_cast.triggerevent (clicked!)
	wf_stampa_brogliaccio(0)


end event

event rbuttondown;if flags=10 then  //con ctrl è 10
	wf_stampa_brogliaccio(1)
elseif  flags=6 then //con peso medio e des_2 (sono i "K") 20241106 shift+tastodx mouse=6
	wf_stampa_brogliaccio(4)
elseif flags=14 then  //ctrl+shift+tastodx mouse=14
	wf_stampa_brogliaccio(8)
else
	wf_stampa_brogliaccio(-1)
end if





////idw_riga.saveas()
//integer li_y
//string ls_codice_azienda, ls_num_doc
//datastore ds_silver
////datawindowchild dwc_galvanica
//decimal ldc_imponibile, ldc_imposta, ldc_totale 
//
//if printsetup()= 1 then
//	select rag_soc_1
//	into :ls_codice_azienda
//	from azienda
//	;
//	if pos(upper(ls_codice_azienda),'SILVER')>0  or pos(upper(ls_codice_azienda),'PANNA')>0 then
//		ds_silver=create datastore
//		ds_silver.dataobject="d_orafo_riga_documento_silver_stampa"
////		ds_silver.getchild("riga_documento_id_gruppo_agenti_2", dwc_galvanica)
////		dwc_galvanica.settransobject(sqlca)
////		dwc_galvanica.retrieve()
//		ds_silver.settransobject(sqlca)
//		idw_riga.rowscopy(1,idw_riga.RowCount(), Primary!, ds_silver, 1, Primary!)
//		
//		//ds_silver.filter()
//		//ds_silver.sort()
//		ls_num_doc="DOC. "+ idw_gen.getitemstring(1, "num_documento")
//		ls_num_doc+= " del "+string(idw_gen.getitemdate(1, "data_documento"))
//		//ls_num_doc= "t_num_doc.text= "+ls_num_doc
//		ds_silver.modify("t_num_doc.text='"+ls_num_doc+"'")
//		//23-04-2016 aggiungo intestazione e totali documento
//		ds_silver.object.t_intestazione.text="Stampa Brogliaccio "+ls_num_doc
//		ldc_imponibile=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imponibile_lire")
//		ldc_imposta=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_imposta_lire")
//		ldc_totale=tab_1.tabpage_4.dw_documento_tot_ext_ff.getitemdecimal(1, "tot_documento_lire")
//		ds_silver.object.t_imponibile.text=string(ldc_imponibile, "#,0.00")
//		ds_silver.object.t_imposta.text=string(ldc_imposta, "#,0.00")
//		ds_silver.object.t_totale.text=string(ldc_totale, "#,0.00")
//		//fine 23-04-2016
//		ds_silver.print()
//	else
//		idw_riga.object.c_tot_righe.visible="0"
//		idw_riga.object.linea.visible="0"
//		idw_riga.object.c_tot_righe_t.visible="0"
//		idw_riga.object.c_tot_righe_lire_t.visible="0"
//		idw_riga.object.c_tot_righe_lire.visible="0"
//			
//		idw_riga.print()	
//		idw_riga.object.c_tot_righe.visible="1"
//		idw_riga.object.linea.visible="1"
//		idw_riga.object.c_tot_righe_t.visible="1"
//		idw_riga.object.c_tot_righe_lire_t.visible="1"
//		idw_riga.object.c_tot_righe_lire.visible="1"
//	
//	end if
//		
//	
//	
//		
//end if
end event

type pb_legenda from picturebutton within tabpage_2
event ue_mousemove pbm_dwnmousemove
string tag = "Legenda"
integer x = 1445
integer y = 796
integer width = 119
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\legenda.png"
string disabledname = "s:\pb\commonframework\apri_dettaglio.bmp"
alignment htextalign = left!
end type

event ue_mousemove;messagebox("E", this.tag)
end event

event clicked;open (w_legenda_gd)
end event

type cb_agg_listino from commandbutton within tabpage_2
integer x = 2597
integer y = 804
integer width = 187
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agg. Lis."
end type

event clicked;Integer ll_row, ll_nr_row,li_ret,ll_prima_riga
decimal ld_prezzo
string ls_agg_una_riga_o_tutto
long ll_id_uc

if messagebox("Attenzione!", "Sei sicura di voler riportare i prezzi attuali ~r~n"+&
					"nel listino personale dell'intestatario di questo documento?", stopsign!, yesno!)=1 then
	ll_nr_row= idw_riga.RowCount()
	ll_prima_riga=1
	select agg_lis_da_doc
	into :ls_agg_una_riga_o_tutto
	from dba.orafo_par_sistema
	;
	if ls_agg_una_riga_o_tutto="U" then //aggiorno solo la riga corrente
		ll_nr_row=idw_riga.getrow()
		ll_prima_riga=ll_nr_row
	end if
	FOR  ll_row =ll_prima_riga to  ll_nr_row
		ld_prezzo=idw_riga.getitemdecimal(ll_row, "prezzo_manifattura") 
		if isnull(ld_prezzo) or ld_prezzo=0 then
			ld_prezzo=idw_riga.getitemdecimal(ll_row, "prezzo_complessivo")
		end if
		ll_id_uc=idw_riga.getitemnumber(ll_row, "riga_documento_id_unita_confezione")
		wf_salva_prezzo_in_listino(ll_row, ld_prezzo, 100, ll_id_uc)
	next

	if	tab_1.tabpage_7.dw_salva_prezzo_in_listino.rowcount()>0 then
		li_ret=tab_1.tabpage_7.dw_salva_prezzo_in_listino.update()
		if li_ret=1 then
			commit;
		else
			messagebox("Attenzione!", SQLCA.SQLErrText)
			rollback;
		end if
	end if
end if
end event

event rbuttondown;Integer ll_row, ll_nr_row,li_ret,ll_prima_riga
decimal ld_prezzo
string ls_agg_una_riga_o_tutto
long ll_id_uc, ll_id_cliente
date ldt_data_doc
uo_lis_fornitori uo_lis_fo

if messagebox("Attenzione!", "Sei sicura di voler riportare TUTTI i prezzi attuali ~r~n"+&
					"nel listino personale dell'intestatario di questo documento?", stopsign!, yesno!)=1 then
	ll_nr_row= idw_riga.RowCount()
	ll_prima_riga=1
//	select agg_lis_da_doc
//	into :ls_agg_una_riga_o_tutto
//	from dba.orafo_par_sistema
//	;
//	if ls_agg_una_riga_o_tutto="U" then //aggiorno solo la riga corrente
//		ll_nr_row=idw_riga.getrow()
//		ll_prima_riga=ll_nr_row
//	end if
	ll_id_cliente=idw_gen.getitemnumber(1, "id_sog_commerciale")
	ldt_data_doc=idw_gen.getitemdate(1, "data_documento")
	uo_lis_fo=create uo_lis_fornitori
	FOR  ll_row =ll_prima_riga to  ll_nr_row
		ld_prezzo=idw_riga.getitemdecimal(ll_row, "prezzo_manifattura") 
		if isnull(ld_prezzo) or ld_prezzo=0 then
			ld_prezzo=idw_riga.getitemdecimal(ll_row, "prezzo_complessivo")
		end if
		ll_id_uc=idw_riga.getitemnumber(ll_row, "riga_documento_id_unita_confezione")
		wf_salva_prezzo_in_listino(ll_row, ld_prezzo, 100, ll_id_uc )
//		//aggiungo 29082016 per aggiornare i listini fornitori collegati (tabella lega_lis_cl_fo)
		uo_lis_fo.f_agg_lis_fornitore(ll_id_cliente, ld_prezzo, ll_id_uc, ldt_data_doc)
		
	next

	if	tab_1.tabpage_7.dw_salva_prezzo_in_listino.rowcount()>0 then
		li_ret=tab_1.tabpage_7.dw_salva_prezzo_in_listino.update()
		if li_ret=1 then
			commit;
		else
			messagebox("Attenzione!", SQLCA.SQLErrText)
			rollback;
		end if
	end if
end if


end event

type dw_nota_riga from udw_base within tabpage_2
boolean visible = false
integer x = 855
integer y = 1024
integer width = 1202
integer height = 524
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Note Produzione e Qualità"
string dataobject = "d_nota_riga_documento"
boolean vscrollbar = false
boolean livescroll = false
end type

event retrievestart;call super::retrievestart;return 2
end event

event clicked;call super::clicked;if dwo.name="t_p" then
	wf_salva_note_riga()
end if
end event

event itemchanged;call super::itemchanged;
//20241209 spostato da updateend
if dwo.name="nota_produzione" or dwo.name="nota_qualita" then
	wf_salva_note_riga()
end if
end event

type hpb_avanzamento from hprogressbar within tabpage_2
boolean visible = false
integer x = 3109
integer y = 820
integer width = 841
integer height = 56
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 1
boolean smoothscroll = true
end type

type cb_libre_calc from commandbutton within tabpage_2
integer x = 2921
integer y = 804
integer width = 160
integer height = 84
integer taborder = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calc"
end type

event clicked;//20261126 come il pulsante Calc della 64_2025, ma per Labella: le righe del documento come si vedono nella griglia
//(colonne visibili, nell ordine a video, righe dopo filtro e ordinamento), scritte con LibreOffice da f_dw_calc;
//colonne e decimali sistemati per il file (vedi sotto, 26/11 sera).
//Niente brogliaccio Silver Dreams (modello brog_2026.xls, K, SB, TC, galvanica, doratura).
//Il file va in c:\nita\excel come BROG_<profilo>_<numero>_<data>.xlsx, poi si chiede se aprirlo.
string ls_prof, ls_num, ls_file
date ld_data
long ll_righe

idw_riga.accepttext()
if idw_riga.rowcount() < 1 then
	messagebox("Calc", "Il documento non ha righe.")
	return
end if
ls_prof = idw_gen.getitemstring(1, "c_prof_doc_cod")
if isnull(ls_prof) or trim(ls_prof) = "" then ls_prof = "DOC"
ls_num = idw_gen.getitemstring(1, "num_documento")
if isnull(ls_num) or trim(ls_num) = "" then ls_num = "nuovo"
ld_data = idw_gen.getitemdate(1, "data_documento")
if isnull(ld_data) then ld_data = today()
ls_num = f_sostituisci_carattere(f_sostituisci_carattere(trim(ls_num), "/", "-"), "\", "-")
if not DirectoryExists("c:\nita") then CreateDirectory("c:\nita")
if not DirectoryExists("c:\nita\excel") then CreateDirectory("c:\nita\excel")
ls_file = "c:\nita\excel\BROG_" + trim(ls_prof) + "_" + ls_num + "_" + string(ld_data, "dd-mm-yy") + ".xlsx"

//20261126 sera (utente): il file non e' la griglia tale e quale. Si lavora su una copia in dw_6 (la dw nascosta delle
//stampe, che si reimposta a ogni stampa), cosi' a video non cambia niente:
//- via obj_3551705, al suo posto la descrizione della riga; via c_spazio ed EF (forza_chius_evasione); via anche
//  c_riga_valida e c_evasione, che hanno la visibilita' a espressione (a video non si vedono mai)
//- peso, coef. calo, misura e peso unitario a 2 decimali, prezzi a 4 (f_dw_calc porta in Calc il formato della colonna)
string ls_ret, ls_id_des, ls_x_des
setpointer(hourglass!)
tab_1.tabpage_2.dw_6.setredraw(false)
tab_1.tabpage_2.dw_6.dataobject = idw_riga.dataobject
idw_riga.rowscopy(1, idw_riga.rowcount(), Primary!, tab_1.tabpage_2.dw_6, 1, Primary!)
ls_x_des = tab_1.tabpage_2.dw_6.describe("obj_3551705.x")
if not isnumber(ls_x_des) then ls_x_des = "503"
ls_ret = tab_1.tabpage_2.dw_6.modify("obj_3551705.visible=0 c_spazio.visible=0 forza_chius_evasione.visible=0 " + &
	"c_riga_valida.visible=0 c_evasione.visible=0")
//la descrizione: la colonna c'e' nella dw ma non ha un oggetto a video, lo si crea nella copia
ls_id_des = tab_1.tabpage_2.dw_6.describe("riga_documento_descrizione.id")
if isnumber(ls_id_des) and tab_1.tabpage_2.dw_6.describe("riga_documento_descrizione.visible") = "!" then
	ls_ret = tab_1.tabpage_2.dw_6.modify("create column(band=detail id=" + ls_id_des + " alignment=~"0~" tabsequence=0 border=~"0~" " + &
		"color=~"0~" x=~"" + ls_x_des + "~" y=~"0~" height=~"80~" width=~"110~" format=~"[general]~" " + &
		"name=riga_documento_descrizione visible=~"1~" edit.limit=0 edit.case=any font.face=~"Arial~" font.height=~"-8~" " + &
		"font.weight=~"400~" font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"1~" background.color=~"536870912~" )")
	ls_ret = tab_1.tabpage_2.dw_6.modify("create text(band=header alignment=~"2~" text=~"Descrizione~" border=~"0~" color=~"0~" " + &
		"x=~"" + ls_x_des + "~" y=~"4~" height=~"56~" width=~"110~" name=riga_documento_descrizione_t visible=~"1~" " + &
		"font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~" font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" " + &
		"background.mode=~"1~" background.color=~"536870912~" )")
elseif isnumber(ls_id_des) then
	//l oggetto c'e' ma nascosto: lo si mette a video al posto di obj_3551705
	ls_ret = tab_1.tabpage_2.dw_6.modify("riga_documento_descrizione.visible=1 riga_documento_descrizione.x=" + ls_x_des + &
		" riga_documento_descrizione.width=110")
end if
//20261126 sera (utente) totale della riga a 2 decimali, dopo il metallo (a video nella griglia non c'e')
ls_x_des = tab_1.tabpage_2.dw_6.describe("prezzo_metallo.x")
if isnumber(ls_x_des) then
	ls_x_des = string(long(ls_x_des) + 260)
else
	ls_x_des = "2651"
end if
ls_id_des = tab_1.tabpage_2.dw_6.describe("tot_riga_val_doc.id")
if isnumber(ls_id_des) and tab_1.tabpage_2.dw_6.describe("tot_riga_val_doc.visible") = "!" then
	ls_ret = tab_1.tabpage_2.dw_6.modify("create column(band=detail id=" + ls_id_des + " alignment=~"1~" tabsequence=0 border=~"0~" " + &
		"color=~"0~" x=~"" + ls_x_des + "~" y=~"0~" height=~"80~" width=~"80~" format=~"#,##0.00~" " + &
		"name=tot_riga_val_doc visible=~"1~" edit.limit=0 edit.case=any font.face=~"Arial~" font.height=~"-8~" " + &
		"font.weight=~"400~" font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" background.mode=~"1~" background.color=~"536870912~" )")
	ls_ret = tab_1.tabpage_2.dw_6.modify("create text(band=header alignment=~"2~" text=~"Totale riga~" border=~"0~" color=~"0~" " + &
		"x=~"" + ls_x_des + "~" y=~"4~" height=~"56~" width=~"80~" name=tot_riga_val_doc_t visible=~"1~" " + &
		"font.face=~"Arial~" font.height=~"-8~" font.weight=~"400~" font.family=~"2~" font.pitch=~"2~" font.charset=~"0~" " + &
		"background.mode=~"1~" background.color=~"536870912~" )")
elseif isnumber(ls_id_des) then
	ls_ret = tab_1.tabpage_2.dw_6.modify("tot_riga_val_doc.visible=1 tot_riga_val_doc.x=" + ls_x_des + " tot_riga_val_doc.width=80 " + &
		"tot_riga_val_doc.format='#,##0.00'")
end if
ls_ret = tab_1.tabpage_2.dw_6.modify("riga_documento_peso_netto.format='#,##0.00' coef_calo.format='#,##0.00' " + &
	"riga_documento_dim_l.format='#,##0.00' peso_unita.format='#,##0.00' prezzo_complessivo.format='#,##0.0000' " + &
	"prezzo_manifattura.format='#,##0.0000' prezzo_metallo.format='#,##0.0000'")
ll_righe = f_dw_calc(tab_1.tabpage_2.dw_6, ls_file)
tab_1.tabpage_2.dw_6.reset()
tab_1.tabpage_2.dw_6.setredraw(true)
setpointer(arrow!)
if ll_righe < 0 then return   //errore gia' detto da f_dw_calc

if messagebox("Calc", "Scritte " + string(ll_righe) + " righe in~r~n" + ls_file + "~r~n~r~nAprire il file?", question!, yesno!) = 1 then
	run("explorer.exe ~"" + ls_file + "~"")
end if
end event

type cb_rec_prezzi from commandbutton within tabpage_2
integer x = 2190
integer y = 804
integer width = 123
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "REC"
end type

event clicked;long ll_row, ll_nr_row, ll_saltate_m
string ls_stato_doc
integer li_m_rec
//recupera il prezzo dell'articolo
//20261126 come nella 64_2025, senza la parte Silver Dreams e Karizia (galvanica dal gruppo, RIPGRA, SOLO GALV, estensioni):
//niente REC su note di credito e di debito e sulle fatture contabilizzate, le righe con la M non si toccano,
//barra di avanzamento e specchietto delle righe cambiate (c:\nita\log, in Excel).
if wf_doc_senza_rec() then
	messagebox("Attenzione!", "Nelle note di credito e di debito il REC non si usa: i prezzi restano quelli del documento.")
	return 0
end if
//20260430 (64_2025) controllo se il doc e' contabilizzato, al che NON faccio nulla
ls_stato_doc = uf_calc_stato_doc()
if mid(ls_stato_doc,3,1) = "S" then  //e' contabilizzato!!!!
	messagebox("Attenzione!", "La fattura e' contabilizzata: non si possono cambiare i prezzi!!!!")
	return 0
end if
wf_rec_log_prima()  //specchietto: come sono le righe prima del recupero
ll_nr_row= idw_riga.RowCount()
idw_riga.SetRedraw(false)
wf_avanz_inizio(ll_nr_row)  //barra di avanzamento
FOR  ll_row =1 to  ll_nr_row
	wf_avanz_passo(ll_row)
	//20261126 riga con la M (provv_agente_2 = 2, prezzo messo a mano): i prezzi a mano hanno la priorita' sul listino,
	//il REC la salta del tutto
	li_m_rec = idw_riga.getitemnumber(ll_row, "provv_agente_2")
	if isnull(li_m_rec) then li_m_rec = 0
	if li_m_rec = 2 then
		ll_saltate_m++
		continue
	end if
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event ue_rec_prezzo(ll_row, 1)
	wf_calcola_prezzo(ll_row)
	wf_prezzo_galvanica(ll_row, idw_riga.getitemstring(ll_row, "c_articolo_cod"))
	wf_incartato_imbustato(ll_row)
next
idw_riga.SetRedraw(true)
wf_avanz_fine()
rb_10.checked=false
rb_meno_10.checked=false
rb_15.checked=false
rb_meno_15.checked=false
wf_rec_log_dopo()  //specchietto delle righe cambiate (file in c:\nita\log, avviso a video sulle fatture)
end event

type cb_f_c from commandbutton within tabpage_2
integer x = 2789
integer y = 804
integer width = 105
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "F+C"
end type

event clicked;long ll_riga
decimal ldc_peso, ldc_c_calo

for ll_riga=1 to idw_riga.rowcount()
	ldc_peso=idw_riga.getitemdecimal(ll_riga, "riga_documento_peso_netto")
	ldc_c_calo=idw_riga.getitemdecimal(ll_riga, "coef_calo")
	wf_setta_fino_calo(ll_riga)

next
messagebox("OK!", "Ricalcolo fino e calo completato!")
cb_ricalcola.triggerevent(clicked!)

end event

type cb_partite from commandbutton within tabpage_2
boolean visible = false
integer x = 3607
integer y = 1032
integer width = 187
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Partite"
end type

event clicked;
wf_ges_partite_da_deriva()
end event

type dw_des_aggiuntiva from udw_base within tabpage_2
boolean visible = false
integer x = 23
integer y = 1572
integer width = 1065
integer height = 224
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_riga_doc_23"
boolean vscrollbar = false
end type

event clicked;call super::clicked;long ll_id_riga,ll_riga


if rowcount() >0 then
	//if dwo.name="b_salva" then
		//ll_id_riga=tab_1.tabpage_2.dw_des_aggiuntiva.getitemnumber(row, "id_riga_documento")
//		if isnull(ll_id_riga) then
			//ll_riga=idw_riga.getrow()
//			ib_askforsave=false
//			idw_riga.accepttext()
//			idw_riga.trigger event ue_key(KEYS!,2)
//			ll_id_riga=idw_riga.getitemnumber(ll_riga, "id_riga_documento")
//			tab_1.tabpage_2.dw_des_aggiuntiva.setitem(row, "id_riga_documento", ll_id_riga)
//			post wf_salva_riga_doc_2()		
//		end if
		wf_salva_riga_doc_2()
	//end if
else
	ll_riga=idw_riga.getrow()
	if ll_riga>0 then wf_sinc_des_agg(ll_riga)
end if


	

end event

event getfocus;call super::getfocus;long ll_riga,ll_riga_des, ll_id_riga_doc

//ll_riga=idw_riga.getrow()
//ll_riga_des=getrow()
//if ll_riga>0 then
//	if ll_riga_des>0 then
//		ll_id_riga_doc=getitemnumber(ll_riga_des, "id_RIGA_DOCUMENTO")
//		if isnull(ll_id_riga_doc) or ll_id_riga_doc<=0 and ll_riga>0 then wf_sinc_des_agg(ll_riga)
//	else
//		wf_sinc_des_agg(ll_riga)
//	end if
//end if
end event

event losefocus;call super::losefocus;accepttext()
end event

type cb_pacco from commandbutton within tabpage_2
boolean visible = false
integer x = 3803
integer y = 1032
integer width = 174
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pacco"
end type

event clicked;long ll_id_riga, ll_riga

w_data_main			lw_win
u_dw_main			lu_dw



ll_riga=idw_riga.getrow()
if ll_riga>0 then
	lw_win = u_freddie.iw_current
	lu_dw = lw_win.idw_master
			
	if IsNull(lu_dw) then lu_dw = idw_riga
	lu_dw.triggerevent("ue_update")
	ll_id_riga=idw_riga.getitemnumber(ll_riga, "id_riga_documento")
	if ll_id_riga>0 then
		openwithparm(w_ins_in_pacco_pop, ll_id_riga)
	else
		messagebox("Attenzione!", "Occorre salvare le righe prima di impacchettarle!")
	end if
end if



end event

type pb_1 from picturebutton within tabpage_2
integer x = 3291
integer y = 924
integer width = 119
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\ordina.png"
alignment htextalign = left!
end type

event clicked;long ll_nr_row, ll_row

idw_riga.SetSort("riga_documento_num_riga A") 
idw_riga.Sort()

ll_nr_row= idw_riga.RowCount()
FOR ll_row= ll_nr_row to 1 step -1
	idw_riga.SetItem(ll_row, "riga_documento_num_riga", ll_row)
next
end event

type cbx_decimali from checkbox within tabpage_2
boolean visible = false
integer x = 3191
integer y = 1596
integer width = 283
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "DECIMALI"
boolean lefttext = true
end type

type pb_cod_barre_bollettine from picturebutton within tabpage_2
integer x = 3122
integer y = 1032
integer width = 197
integer height = 92
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Codice a barre.png"
alignment htextalign = left!
end type

event clicked;wf_cod_barre_bollettine()
end event

type cb_copia_riga from commandbutton within tabpage_2
integer x = 3529
integer y = 924
integer width = 270
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copia Riga"
end type

event clicked;//090612 o per samy vener: copia la riga nel pronto (o a richiesta) e la collego alla produzione come la riga precedente (copiata)
long ll_null, ll_id_riga_madre, ll_id_riga_copiata, ll_id_bollettina,ll_riga
decimal ldc_qta_in_pronto, ldt_qta_bollettina, ldc_qta_giusta,ldc_qta_madre

setnull(ll_null)

ll_riga=idw_riga.getrow()

if ll_riga>0 then
	idw_riga.rowscopy(ll_riga, ll_riga, primary!, idw_riga, ll_riga +1, primary!)
	idw_riga.setitem(ll_riga+1, "riga_documento_num_riga", idw_riga.rowcount() +1)
	idw_riga.setitem(ll_riga+1, "id_riga_documento", ll_null)
	//150612 aggiungo su richiesta samy: 
	//1) il peso = 0,01 (perché tanto lo mette da bilancia e non metto "0" perché sennò gli ricalcola i pezzi;
	//2) tara= 0 tanto la mette lei nel pronto
	idw_riga.setitem(ll_riga+1, "riga_documento_peso_lordo", 0) //peso_lordo=tara
	idw_riga.setitem(ll_riga+1, "riga_documento_peso_netto", 0.01)
	
	idw_riga.setitemstatus(ll_riga+1, 0, primary!, newmodified!)
	
	ll_id_riga_madre=idw_riga.getitemnumber(ll_riga, "id_riga_documento")
	ldc_qta_madre=idw_riga.getitemnumber(ll_riga, "quantita")
	if isnull(ldc_qta_madre) then ldc_qta_madre=0
	select id_bollettina
	into :ll_id_bollettina
	from dba.produzione_2011
	where id_doc_produzione=:ll_id_riga_madre;
	if ll_id_bollettina>0 then
		ldc_qta_giusta=wf_calcola_qta_residua_bollettina(ll_id_bollettina, ll_id_riga_madre)
//	//e il legame con la produzione
//	
//	
//		//occorre calcolare i pezzi da proporre
//		//prendo tutte le righe di pronto salvate ad ora riferite a questa bollettina
//		//e sommo le qta
//		 SELECT sum("riga_documento"."quantita") 
//		 into :ldc_qta_in_pronto
//    	FROM "produzione_2011",   
//         "riga_documento",   
//         "caus_magazzino"  
//   	WHERE "riga_documento"."id_riga_documento" = "produzione_2011"."id_doc_produzione"  and  
//          "caus_magazzino"."id_caus_magazzino" = "riga_documento"."id_caus_magazzino"  and  
//          "produzione_2011"."id_bollettina" = :ll_id_bollettina  AND 
//			"riga_documento"."id_riga_documento" <> :ll_id_riga_madre and
//          "caus_magazzino"."step_produzione" = 'X'   
//			;
//			
//			if isnull(ldc_qta_in_pronto) then ldc_qta_in_pronto=0
//			
//			select sum("riga_documento"."quantita")
//			into :ldt_qta_bollettina
//			from dba.riga_documento
//			where id_documento=:ll_id_bollettina
//			and (id_riga_doc_padre is null or id_riga_doc_padre=0)
//			;
//			
//			if isnull(ldt_qta_bollettina) then ldt_qta_bollettina=0
			
//			ldc_qta_giusta =ldt_qta_bollettina - ldc_qta_in_pronto - ldc_qta_madre
			ldc_qta_giusta -= ldc_qta_madre
			if ldc_qta_giusta<0 then ldc_qta_giusta=0
			//ora propongo la qta giusta
			idw_riga.setitem(ll_riga+1, "quantita", ldc_qta_giusta)
		//occorre salvare la riga 
		if idw_riga.update()=1 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Riga non salvata!")
		end if
		ll_id_riga_copiata=idw_riga.getitemnumber(ll_riga +1, "id_riga_documento")
		if ll_id_riga_copiata>0 then
			
			//inserisco in produzione (lego riga del pronto alla bollettina)
			insert into dba.produzione_2011 
			(id_bollettina, id_doc_produzione)
			values (:ll_id_bollettina, :ll_id_riga_copiata)
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Legame Riga-Bollettina non salvato!")
			end if
		end if
	
	end if
	
	
	
end if
end event

type cbx_des_3 from checkbox within tabpage_2
integer x = 3182
integer y = 1664
integer width = 297
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
string text = "Vedi Des3"
boolean lefttext = true
end type

event clicked;long ll_id_uc, ll_id_var, ll_id_listino, al_riga
string ls_des_1, ls_des_2, ls_des_3
date ldt_data_attuale


if checked then
	al_riga=idw_riga.getrow()
	if al_riga>0 then
	
		//20-04-2016 aggiungo recupero delle descrizioni del listino (per ora solo la des_2)
		ldt_data_attuale=idw_gen.getitemdate(1, "data_documento")
		ll_id_uc=idw_riga.getitemnumber(al_riga, "riga_documento_id_unita_confezione")
		if isnull(ll_id_var) or ll_id_var<=0 then
			ll_id_listino=idw_gen.getitemnumber(1, "documento_id_listino")
			if ll_id_listino>0 then
				select id_variazione
				into :ll_id_var
				from dba.variazione
				where id_listino=:ll_id_listino
				and data_inizio<=:ldt_data_attuale
				and data_fine >=:ldt_data_attuale
				;
			end if
		end if
		if ll_id_var>0 then
			select des_1, des_2, des_3 
			into  :ls_des_1, :ls_des_2, :ls_des_3
			from dba.prezzo 
			where id_variazione=:ll_id_var
			and id_unita_confezione=:ll_id_uc
			;
		else
			//provo dal listino base
			select des_2, des_3, des_1
			into :ls_des_2, :ls_des_3, :ls_des_1
			from dba.prezzo p, dba.listino l, dba.variazione v
			where l.id_listino=v.id_listino
			and v.id_variazione=p.id_variazione
			and p.id_unita_confezione=:ll_id_uc
			and l.lis_base='S'
			and l.tipo='V'
			and v.data_inizio<=:ldt_data_attuale
			and v.data_fine>=:ldt_data_attuale
			;
		end if
		if ls_des_2>" " then
//			st_des_2_prezzo.text=ls_des_2
		end if
		if ls_des_3>" " then
			st_des_3_prezzo.text=ls_des_3
		else
				st_des_3_prezzo.text=""
		end if
	end if
end if
end event

type cb_4 from commandbutton within tabpage_2
integer x = 3351
integer y = 1032
integer width = 210
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Per Elisa"
end type

event clicked;INTEGER I
STRING ls_id_galv
if ii_gia_fatto> 0 then
	if	messagebox("Attenzione!", "Hai già premuto questo bottone, sei certa che vuoi continuare?", stopsign!, yesno!)<>1 then return
end if
FOR I= 1 TO IDW_RIGA.ROWCOUNT()
	ls_id_galv=string(idw_riga.getitemnumber(i, "id_gruppo_agenti_2"))
	wf_rec_galvanica(ls_id_galv, i)
NEXT
ii_gia_fatto=100
end event

type cbx_incartato from checkbox within tabpage_2
integer x = 3168
integer y = 1736
integer width = 315
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
string text = "Incartato"
boolean checked = true
boolean lefttext = true
end type

type cb_reso_non_lavorato from commandbutton within tabpage_2
integer x = 3803
integer y = 924
integer width = 174
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RESO"
end type

event clicked;s_dw_ritorna ldw_ritorna
integer i
long ll_riga_inserita,ll_id_articolo
string ls_cod_art
decimal ldc_qta,ldc_coef_calo

open(w_imp_reso_non_lavorato)
ldw_ritorna=message.powerobjectparm

this.text="WORK"
for i=1 to  ldw_ritorna.ds.rowcount()
	ls_cod_art=ldw_ritorna.ds.getitemstring(i, "cod_articolo")
	ldc_qta=ldw_ritorna.ds.getitemdecimal(i, "qta")
	ll_id_articolo=ldw_ritorna.ds.getitemnumber(i, "id_articolo")
	select coef_calo into :ldc_coef_calo from dba.articolo where id_articolo=:ll_id_articolo;
	if ldc_coef_calo<=0 or isnull(ldc_coef_calo) then ldc_coef_calo=1000	
	ll_riga_inserita=idw_riga.trigger event ue_insert(0,0)
	idw_riga.setitem(ll_riga_inserita, "c_articolo_cod", ls_cod_art)
	idw_riga.setitem(ll_riga_inserita, "coef_calo", ldc_coef_calo)
	idw_riga.setitem(ll_riga_inserita, "riga_documento_id_articolo", ll_id_articolo)
	idw_riga.setitem(ll_riga_inserita, "quantita", ldc_qta)
	//idw_riga.trigger event itemchanged(ll_riga_inserita, idw_riga.object.quantita, string(ldc_qta))
	idw_riga.setitem(ll_riga_inserita, "riga_documento_descrizione", ls_cod_art+" - Reso non lavorato")
next
this.text="RESO"


//for i=1 to  ldw_ritorna.ds.rowcount()
//	ls_cod_art=ldw_ritorna.ds.getitemstring(i, "cod_articolo")
//	ldc_qta=ldw_ritorna.ds.getitemdecimal(i, "qta")
//	ll_riga_inserita=idw_riga.trigger event ue_insert(0,0)
//	idw_riga.trigger event itemchanged(ll_riga_inserita, idw_riga.object.c_articolo_cod, ls_cod_art)
//	idw_riga.setitem(ll_riga_inserita, "quantita", ldc_qta)
//	idw_riga.trigger event itemchanged(ll_riga_inserita, idw_riga.object.quantita, string(ldc_qta))
//	idw_riga.setitem(ll_riga_inserita, "riga_documento_descrizione", ls_cod_art+" - Reso non lavorato")
//next
end event

type dw_3 from udw_000 within tabpage_2
boolean visible = false
integer x = 3122
integer y = 1128
integer width = 448
integer height = 180
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_rec_bol_da_riga_documento"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long ll_id_bollettina, ll_id_riga_provenienza, ll_null,ll_id_sald,ll_id_sog, ll_riga_di_partenza
datastore ds_riga_bollettina
integer li_num_riga, li_righe
string ls_des

setnull(ll_null)


if dwo.name="num_bollettina" then
		ds_riga_bollettina=create datastore
		ds_riga_bollettina.dataobject="d_orafo_riga_documento_ordine_silver_gd"
		ds_riga_bollettina.settransobject(sqlca)
		
		select id_documento into :ll_id_bollettina from documento d, registro r
		where d.id_registro=r.id_registro and tipo_registro='GV' and numero=2
		and num_documento like '%-'+:data 
		;
		ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
		select d.id_documento, r.num_riga into :ll_id_sald, :li_num_riga from riga_documento r, produzione_2011 p, registro g, documento d
		where id_doc_produzione =id_riga_documento and id_bollettina=:ll_id_bollettina
		and d.id_documento=r.id_documento and d.id_registro=g.id_registro
		and d.id_sog_commerciale=:ll_id_sog
		and g.tipo_registro='DV' and (g.numero=3 or g.numero=4)
		;
		
		if ll_id_sald> 0 then
			
		li_righe=ds_riga_bollettina.retrieve(ll_id_sald)
		ds_riga_bollettina.setfilter("riga_documento_num_riga="+string(li_num_riga))
		ds_riga_bollettina.filter()
		ll_id_riga_provenienza=ds_riga_bollettina.getitemnumber(1, "id_riga_documento")
		ds_riga_bollettina.SetItem(1, "id_documento", il_id_documento)
		ds_riga_bollettina.SetItem(1, "riga_documento_provv_imp_carea_2", ll_null)	
		ds_riga_bollettina.SetItem(1, "id_riga_documento", ll_null)
		ds_riga_bollettina.SetItem(1, "id_riga_doc_provenienza", ll_id_riga_provenienza)  //commento perché la uso 20210219 no!!! 24/05/2022
		
		ds_riga_bollettina.SetItem(1, "qta_evasa", 0)
		ds_riga_bollettina.SetItem(1, "peso_netto_evaso", 0)
		ds_riga_bollettina.SetItem(1, "riga_documento_peso_netto", 0)  //per Anna 05/05/2022 NON deve riportare peso da bollettina (restaurato 240522)
		ds_riga_bollettina.SetItem(1, "qta_EVASA_UN_base", 0) 
		ll_riga_di_partenza=idw_riga.rowcount()
		
		ds_riga_bollettina.ROWSCOPY(1,1,primary!, idw_riga,  999999, primary!)
		idw_riga.scrolltorow(idw_riga.rowcount())
		idw_riga.trigger event ue_initial()
		ls_des=idw_riga.getitemstring(idw_riga.rowcount(), "riga_documento_descrizione")
		idw_riga.setitem(idw_riga.rowcount(), "riga_documento_descrizione", ls_des+" ("+data+")")
	else
		messagebox("Attenzione!", "Bollettina: "+data+" NON trovata!")
	end if			
	destroy ds_riga_bollettina
end if




end event

type dw_4 from udw_000 within tabpage_2
integer x = 3589
integer y = 1128
integer width = 462
integer height = 204
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_cod_barre_ext"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event editchanged;call super::editchanged;string  ls_num_bollettina,modstring, ls_ret, modstring2, ls_messaggio
long ll_id_bollettina,  ll_id_prof_sald,ll_id_riga_sald,ll_riga_trovata, ll_riga_inserita, ll_num_prog_sald
decimal ld_peso_netto
integer li_num_riga,  a
w_bilancia w_bil


if dwo.name="cod_barre"  then
	if len(data)=7   then
		ls_num_bollettina=data
		select id_documento, num_documento
		into :ll_id_bollettina, :ls_num_bollettina
		from dba.documento d, dba.prof_documento p
		where right(num_documento, 7)=:ls_num_bollettina
		and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
		and d.id_prof_documento=p.id_prof_documento
		;
		if ll_id_bollettina>0 then  //trovato l'id_bol vado su produzione_2011 e cerco l'id_riga sald collegata
			ll_id_prof_sald=idw_gen.getitemnumber(1, "id_prof_documento")
			//20231024 avverto se nel xls urgenti c'è la bollettina
//			ll_riga_trovata=ds_excel.find("A05='"+ls_num_bollettina, 1, 100000)
//			if ll_riga_trovata>0 then
//				ls_messaggio=ds_excel.getitemstring(ll_riga_trovata, "A08")
//				messagebox("Attenzione!", ls_messaggio)
//			else
//				ll_riga_trovata=0
//			end if
			//end 20231024
			select p.id_doc_produzione, r.num_riga, d.num_progressivo into :ll_id_riga_sald, :li_num_riga, :ll_num_prog_sald
			from dba.produzione_2011 p, dba.riga_documento r, dba.documento d where p.id_bollettina=:ll_id_bollettina
			and p.id_doc_produzione=r.id_riga_documento and d.id_documento=r.id_documento and d.id_prof_documento=:ll_id_prof_sald 
			;
		
			if ll_id_riga_sald>0 then  
				ll_riga_trovata=idw_riga.find("id_riga_documento="+string(ll_id_riga_sald), 1, idw_riga.rowcount())
				open(w_bil)
				ld_peso_netto=w_bil.f_rendi_peso()   ////////OCCHIO DEVI RIATTIVARE!!!!!!!!!///////////////
				close(w_bil)
				if ll_riga_trovata>0 then
					
//					modstring = "riga_documento_peso_netto.Background.Color= '16777215~tIf(riga_documento_num_riga="+string(li_num_riga)+", 65280, 16777215 )'"
//					ls_ret=idw_riga.modify(modstring)
					if ld_peso_netto>0 then
						idw_riga.setitem(ll_riga_trovata, "riga_documento_peso_netto", ld_peso_netto)
						wf_calcola_fino_calo(ll_riga_trovata)  //20261106 fino e calo subito sul peso della bilancia (qui non scatta l'itemchanged)
						idw_riga.setfocus()
						idw_riga.scrolltorow(ll_riga_trovata)
						idw_riga.setcolumn("riga_documento_provv_imp_carea_2")
					else
						messagebox("Attenzione!", "Peso NON recuperato!")
					end if
					
				else
					//messagebox("Attenzione!", "La bollettina NON è in questo Documento, vuoi inserirla adesso?", stopsign!,yesno!)
					ll_riga_inserita=wf_copia_riga_bollettina(ll_id_bollettina)
				end if
				dw_4.setitem(1, "cod_barre", "")
	//			dw_4.setfocus()
	//			dw_4.setcolumn("cod_barre")
			else
				ll_riga_inserita=wf_copia_riga_bollettina(ll_id_bollettina)
			end if
			a=upperbound(ii_righe_fatte) +1
			if ll_riga_inserita>0 then li_num_riga=ll_riga_inserita
			ii_righe_fatte[a]=li_num_riga
			modstring = "riga_documento_peso_netto.Background.Color= '16777215~tIf(riga_documento_num_riga="+string(li_num_riga) 
			modstring2="c_articolo_cod.Background.Color= '16777215~tIf(riga_documento_num_riga="+string(li_num_riga)
			for a =1 to upperbound(ii_righe_fatte)
				modstring +=" or riga_documento_num_riga="+string(ii_righe_fatte[a])
				modstring2 +=" or riga_documento_num_riga="+string(ii_righe_fatte[a])
			next
			modstring += ", 65280,  16777215 )'"
			modstring2 += ", 16777215,  255 )'"
			ls_ret=idw_riga.modify(modstring)	
			ls_ret=idw_riga.modify(modstring2)	
		//	idw_riga.scrolltorow(idw_riga.rowcount())   //20231211 l'avevo dimenticato... così mettevano il legato da bilancia nella riga errata.....
			////Datawindowcontrol.Object.column.Background.Color="553648127~tif( cod_state = 'TX', rgb(255,255,255), rgb(128,128,128))"
		else
			messagebox("Attenzione!", "Bollettina: "+ls_num_bollettina+" non trovata!")
			
		end if
	end if
end if
end event

event rowfocuschanged;//
end event

type cbx_agg_coef_calo from checkbox within tabpage_2
integer x = 3662
integer y = 1692
integer width = 357
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "AGG. C.Calo"
boolean lefttext = true
end type

type cb_8 from commandbutton within tabpage_2
integer x = 3611
integer y = 1388
integer width = 384
integer height = 80
integer taborder = 22
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Listino da Doc."
end type

event clicked;long ll_id_variazione
integer i

ll_id_variazione=idw_gen.getitemnumber(1, "documento_id_variazione")
if ll_id_variazione>0 then
	for i = 1 to idw_riga.rowcount()
		idw_riga.setitem(i, "riga_documento_id_listino", ll_id_variazione)
	next
end if
end event

type cb_9 from commandbutton within tabpage_2
integer x = 3607
integer y = 1300
integer width = 384
integer height = 80
integer taborder = 22
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Togli protezione"
end type

event clicked;tab_1.tabpage_2.dw_riga_documento_ordine_gd.Enabled = TRUE
	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.Enabled = TRUE
end event

type cb_coef_calo_925 from commandbutton within tabpage_2
integer x = 3150
integer y = 1300
integer width = 411
integer height = 80
integer taborder = 42
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Coef. Calo = 925"
end type

event clicked;integer i

for i=1 to idw_riga.rowcount()
	idw_riga.setitem(i, "coef_calo", 925)
	wf_setta_fino_calo(i)  //ricalcolo fino e calo... 20261028 come nella 64 (20260528)
next

end event

type cb_10 from commandbutton within tabpage_2
integer x = 3150
integer y = 1388
integer width = 411
integer height = 80
integer taborder = 32
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Riga Derivata"
end type

event clicked;long ll_riga, ll_id_riga

ll_riga=idw_riga.getrow()
ll_id_riga=idw_riga.getitemnumber(ll_riga, "id_riga_documento")
if ll_id_riga>0 then
	openwithparm(w_vedi_riga_derivata_cx, ll_id_riga)
end if	

end event

type cb_11 from commandbutton within tabpage_2
integer x = 3154
integer y = 1484
integer width = 411
integer height = 80
integer taborder = 42
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "NO BOL in DES"
end type

event clicked;string ls_des
integer li_pos, li_pos2
long ll_row

//20220928 se nella descrizione c'è "- BOL: xxxx-XXXXXXX" lo tolgo.. ma solo se il prof dest. è=RBOL
if idw_gen.getitemnumber(1, "id_prof_documento")=66   then //66=RBOL
	for ll_row=1 to idw_riga.rowcount()
	
		ls_des=idw_riga.getitemstring(ll_row, "riga_documento_descrizione")
		li_pos=pos(ls_des, "- BOL")
		if li_pos>0 then					//- BOL: xxx-
			li_pos2=pos(ls_des, "-", li_pos+1) 
			li_pos2+=7 //il numero dopo il "-" è della bollettina ed è lungo 7
			ls_des=left(ls_des, li_pos - 1)+ " "+right(ls_des, len(ls_des) - li_pos2 - 1)
			idw_riga.setitem(ll_row, "riga_documento_descrizione", ls_des)
		end if
	next
end if
end event

type st_des_3_prezzo from statictext within tabpage_2
integer x = 3515
integer y = 1776
integer width = 503
integer height = 148
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean focusrectangle = false
end type

type pb_2 from picturebutton within tabpage_2
boolean visible = false
integer x = 3410
integer y = 924
integer width = 119
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
alignment htextalign = left!
long backcolor = 134217857
end type

event clicked;string ls_modifica

ls_modifica= "c_articolo_cod.Background.Color= '255'"

idw_riga.modify(ls_modifica)
	

end event

type pb_3 from picturebutton within tabpage_2
integer x = 1687
integer y = 796
integer width = 119
integer height = 96
integer taborder = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Dipartimento Filled-50.png"
alignment htextalign = left!
end type

event clicked;long ll_id_prof_documento
datastore ds_silver
string ls_nome_stampa, ls_ret
INTEGER LI_RET


ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
if ll_id_prof_documento=236 then  //236 merce mag libero per Martina Kar 20241024
	ds_silver=create datastore
	ds_silver.dataobject="d_riga_doc_mag_libero"
	ds_silver.settransobject(sqlca)
	ds_silver.retrieve(il_id_documento)
	//ds_silver.print(true,true)
	ls_nome_stampa="c:\nita\maglib\"
	ls_nome_stampa+="ML_"+idw_gen.getitemstring(1, "num_documento")+"_.pdf"
	ls_ret=ds_silver.Modify("DataWindow.Print.documentName = 'ls_nome_stampa'")
	ds_silver.Modify("Export.PDF.Method = Distill!")
	ls_ret=ds_silver.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	ds_silver.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
	ds_silver.setsort("c_ordina_per_cliente")
	ds_silver.sort()
	li_ret=ds_silver.SaveAs(ls_nome_stampa, PDF!, FALSE)
	
	destroy ds_silver
	

end if


end event

event rbuttondown;long ll_id_prof_documento
datastore ds_silver
string ls_nome_stampa, ls_ret
INTEGER LI_RET


ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
if ll_id_prof_documento=236 then  //236 merce mag libero per Martina Kar 20241024
	ds_silver=create datastore
	ds_silver.dataobject="d_riga_doc_mag_libero"
	ds_silver.settransobject(sqlca)
	ds_silver.retrieve(il_id_documento)
	//ds_silver.print(true,true)
	ls_nome_stampa="c:\nita\maglib\"
	ls_nome_stampa+="ML_"+idw_gen.getitemstring(1, "num_documento")+"_.xls"
	
	ds_silver.setsort("id_articolo")
	ds_silver.sort()
	li_ret=ds_silver.SaveAs(ls_nome_stampa, Excel!, FALSE)
	
	destroy ds_silver
	

end if


end event

type dw_6 from udw_001 within tabpage_2
boolean visible = false
integer x = 3374
integer y = 60
integer width = 535
integer height = 724
integer taborder = 40
boolean bringtotop = true
end type

type cb_csv from commandbutton within tabpage_2
integer x = 2871
integer y = 1272
integer width = 247
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CSV"
end type

event clicked;string ls_path, ls_file, ls_bol
integer i
long ll_row
//20251025: buratto domani: Francesco vuole che inserisca le righe da file csv con una sola colonna "Bollettina" a partire da riga 2
getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.csv", "csv" , "C:\nita\exp_doc") //20230519 xls diventa xlsx .... proviamo
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_9.reset()
	dw_9.importfile(Text!,ls_file)
	for i= 2 to dw_9.rowcount()
		ls_bol=dw_9.getitemstring(i, "bollettina")
		ll_row=idw_riga.rowcount()
		if ll_row<=0 then ll_row=0
		dw_4.trigger event editchanged(ll_row + i - 1, dw_4.object.cod_barre, 	ls_bol)
	next
end if	 
end event

type dw_9 from udw_000 within tabpage_2
boolean visible = false
integer x = 1495
integer y = 1140
integer width = 581
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_carica_bol_urgenti"
end type

type dw_2 from udw_001 within tabpage_4
integer x = 2638
integer y = 988
integer width = 1010
integer height = 732
integer taborder = 50
boolean bringtotop = true
string title = ""
string dataobject = "d_galv_tot_doc"
end type

type cb_2 from commandbutton within tabpage_4
integer x = 2757
integer y = 1732
integer width = 795
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Vedi Tot. galvanica"
end type

event clicked;dw_2.retrieve(il_id_documento)
end event

type tabpage_7 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 104
integer width = 4059
integer height = 1944
long backcolor = 79741120
string text = "Esplosione articoli"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_esplodi dw_esplodi
dw_salva_prezzo_in_listino dw_salva_prezzo_in_listino
end type

on tabpage_7.create
this.dw_esplodi=create dw_esplodi
this.dw_salva_prezzo_in_listino=create dw_salva_prezzo_in_listino
this.Control[]={this.dw_esplodi,&
this.dw_salva_prezzo_in_listino}
end on

on tabpage_7.destroy
destroy(this.dw_esplodi)
destroy(this.dw_salva_prezzo_in_listino)
end on

type dw_esplodi from datawindow within tabpage_7
boolean visible = false
integer x = 585
integer y = 64
integer width = 3365
integer height = 1260
integer taborder = 32
boolean bringtotop = true
string dataobject = "d_orafo_espl_cartellini_gd"
boolean livescroll = true
end type

type dw_salva_prezzo_in_listino from datawindow within tabpage_7
integer x = 27
integer y = 44
integer width = 4000
integer height = 1344
integer taborder = 41
boolean bringtotop = true
string dataobject = "ds_salva_nuovo_prezzo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrievestart;return 2
end event

type p_sigle_prezzi from picture within w_orafo_documento_ordine_cx
boolean visible = false
integer x = 3150
integer y = 20
integer width = 96
integer height = 84
string picturename = "C:\nita\icone\old\lira.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;string ls_sigla

ls_sigla=''
OpenWithParm(w_sigla_prezzo_np, ls_sigla)
ls_sigla=Message.StringParm
if ls_sigla<>'' then
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetRow(),"sigla_prezzo",ls_sigla)
end if
end event

type pb_st_art_foto from picturebutton within w_orafo_documento_ordine_cx
integer x = 2569
integer y = 12
integer width = 160
integer height = 120
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\old\scadenza.bmp"
alignment htextalign = left!
end type

event clicked;datastore ds_recupera
integer li_righe, i, li_riga_inserita, li_st_ogni_riga
decimal ld_peso, ld_lunghezza, ld_qta, ld_prezzo, ld_peso_unitario, ldc_sconto_riga
string ls_articolo, ls_des, ls_imm, ls_rif, ls_cod_cliente, ls_tipo_um
long ll_id_art, ll_id_sog, ll_trovata, ll_id_var,ll_id_riga
li_righe=idw_riga.rowcount()
ds_recupera=create datastore
ds_recupera.dataobject="d_foto_art_da_documento"

if is_tipo_registro='OA' then
	ls_cod_cliente=idw_gen.getitemstring(1, "documento_note_intestazione")
	ls_cod_cliente=left(ls_cod_cliente, 8)
	select id_sog_commerciale
	into :ll_id_sog
	from sog_commerciale
	where codice=:ls_cod_cliente;
	if isnull(ll_id_sog) or ll_id_sog<=0 then
		messagebox("Attenzione!", "Cliente non trovato: si useranno le immagini del fornitore!")
		ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
	end if
else
	ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
end if


ls_rif="Rif. Doc.: "+idw_gen.getitemstring(1, "num_documento")
ls_rif+=" - "+ string(idw_gen.getitemdate(1, "data_documento"))
li_st_ogni_riga=messagebox("Attenzione!", "Vuoi raggruppare codici uguali?", stopsign!, yesno!)
for i= 1 to li_righe
	ls_articolo=idw_riga.getitemstring(i, "c_articolo_cod")
	if ls_articolo>"" then
		ld_peso=idw_riga.getitemdecimal(i, "riga_documento_peso_netto")
		ld_qta=idw_riga.getitemdecimal(i, "quantita")
		if ld_qta>0 then
			ld_peso_unitario=ld_peso/ld_qta
		else
			ld_peso_unitario=0
		end if
		ld_lunghezza=idw_riga.getitemdecimal(i, "riga_documento_dim_l")
		ld_prezzo=idw_riga.getitemdecimal(i, "prezzo_manifattura")
		//aggiungo 110207: se non c'è manifattura prendo il complessivo
		if isnull(ld_prezzo) or ld_prezzo=0 then ld_prezzo=idw_riga.getitemdecimal(i, "prezzo_complessivo")
		//fine aggiunta 110206
		//aggiungo: 040309: prendo l'unita di misura del movimento (pz o grammi: P=grammi)
		ls_tipo_um=idw_riga.getitemstring(i, "tipo_um")
		ls_des=idw_riga.getitemstring(i, "riga_documento_descrizione")
		ll_id_art=idw_riga.getitemnumber(i, "riga_documento_id_articolo")
		ls_imm=f_trova_immagine(ll_id_sog, ll_id_art)
		if ls_imm="" then
			select immagine
			into :ls_imm 
			from articolo
			where id_articolo=:ll_id_art;
		end if
		ll_id_var=idw_riga.getitemnumber(i, "riga_documento_id_listino")
		ll_id_riga=idw_riga.getitemnumber(i, "id_riga_documento")
		ldc_sconto_riga=dec(idw_riga.getitemstring(i, "sconto"))
		
		li_riga_inserita=ds_recupera.insertrow(0)
		ds_recupera.setitem(li_riga_inserita, "cod_articolo", ls_articolo)
		ds_recupera.setitem(li_riga_inserita, "Lunghezza", ld_lunghezza)
		ds_recupera.setitem(li_riga_inserita, "peso_totale", ld_peso)
		ds_recupera.setitem(li_riga_inserita, "peso_unitario", ld_peso_unitario)
		ds_recupera.setitem(li_riga_inserita, "prezzo", ld_prezzo)
		//inserisco um delmovimento (p= prezzo al grammo)
		ds_recupera.setitem(li_riga_inserita, "tipo_um", ls_tipo_um)
		ds_recupera.setitem(li_riga_inserita, "des_articolo", ls_des)
		ds_recupera.setitem(li_riga_inserita, "nome_immagine", ls_imm)
		ds_recupera.setitem(li_riga_inserita, "rif_doc", ls_rif)
		ds_recupera.setitem(li_riga_inserita, "id_sog_commerciale",ll_id_sog)
		ds_recupera.setitem(li_riga_inserita, "id_articolo",ll_id_art)
		ds_recupera.setitem(li_riga_inserita, "qta",ld_qta)
		ds_recupera.setitem(li_riga_inserita, "listino",ll_id_var)
		
		
		ds_recupera.setitem(li_riga_inserita, "id_riga_documento",ll_id_riga)
		ds_recupera.setitem(li_riga_inserita,"sconto",ldc_sconto_riga)
		
		if li_st_ogni_riga=1 then
			ll_trovata=ds_recupera.find("cod_articolo='"+ls_articolo+"'", 1, i -1)
			if ll_trovata>0 then
				ds_recupera.setitem(li_riga_inserita, "num_riga", ll_trovata)
			else
				ds_recupera.setitem(li_riga_inserita, "num_riga", i)
			end if
		else
			ds_recupera.setitem(li_riga_inserita, "num_riga", i)
		end if
	end if
next
if li_righe>0 then
	openwithparm(w_st_foto_articolo_cx, ds_recupera)
end if
destroy(ds_recupera)
end event

type rb_2 from radiobutton within w_orafo_documento_ordine_cx
boolean visible = false
integer x = 3854
integer y = 1728
integer width = 219
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "Valuta"
boolean lefttext = true
end type

event clicked;
wf_euro_valuta("V")
end event

type rb_1 from radiobutton within w_orafo_documento_ordine_cx
boolean visible = false
integer x = 3890
integer y = 1800
integer width = 183
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "Euro"
boolean checked = true
boolean lefttext = true
end type

event clicked;
wf_euro_valuta("E")
end event

type cb_chiudi_ordine from commandbutton within w_orafo_documento_ordine_cx
boolean visible = false
integer x = 3246
integer y = 16
integer width = 178
integer height = 76
integer taborder = 12
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ord"
end type

event clicked;//long ll_id_art, ll_riga_corrente, ll_righe
//integer i
//s_vedi_residuo
//ll_righe=idw_riga.rowcount()


//ll_riga_corrente=idw_riga.getrow()
//if ll_riga_corrente>0 then
//	ll_id_art=idw_riga.getitemnumber(ll_riga_corrente, "riga_documento_id_articolo")
//	if ll_id_art>0 then
		openwithparm(w_chiudi_ordinato_gd, idw_riga)
//	end if
//end if


end event

type cbx_tara from checkbox within w_orafo_documento_ordine_cx
integer x = 2103
integer y = 164
integer width = 283
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Tara Dett."
boolean lefttext = true
end type

type cbx_1 from checkbox within w_orafo_documento_ordine_cx
integer x = 1385
integer y = 164
integer width = 366
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Come stampa"
boolean lefttext = true
end type

event clicked;if checked then
	idw_riga.setsort("riga_documento_provv_subage_2, riga_documento_num_riga" )
else
	idw_riga.setsort("riga_documento_num_riga" )
end if
idw_riga.sort()
end event

type cb_verifica_prezzi from commandbutton within w_orafo_documento_ordine_cx
integer x = 3429
integer y = 16
integer width = 283
integer height = 76
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ver.Prezzi"
end type

event clicked;//i integer 
//decimal ldc_pr_pz, ldc_pr_man

openwithparm(w_silver_prezzi_excel_da_doc, idw_riga)
//tab_1.tabpage_2.cb_rec_prezzi.triggerevent(clicked!)   //20231102 samy dice che andava bene come prima, se voglio rec prezzi lo premo in doc

//for i= 1 to idw_riga.rowcount()
//	ldc_pr_pz=0
//	ldc_pr_man=0
//	ldc_pr_pz=idw_riga.get
//	
//	
//next
end event

type rb_meno_10 from radiobutton within w_orafo_documento_ordine_cx
integer x = 2601
integer y = 156
integer width = 165
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "-10"
end type

event clicked;if checked then
	wf_aumenta_prezzo(-10)
end if
end event

type rb_10 from radiobutton within w_orafo_documento_ordine_cx
integer x = 2427
integer y = 156
integer width = 165
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "+10"
end type

event clicked;if checked then
	wf_aumenta_prezzo(10)
end if
end event

type rb_meno_15 from radiobutton within w_orafo_documento_ordine_cx
integer x = 2949
integer y = 156
integer width = 165
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "-15"
end type

event clicked;if checked then
	wf_aumenta_prezzo(-15)
end if
end event

type rb_15 from radiobutton within w_orafo_documento_ordine_cx
integer x = 2775
integer y = 156
integer width = 165
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "+15"
end type

event clicked;if checked then
	wf_aumenta_prezzo(15)
end if
end event

type cb_sconta from commandbutton within w_orafo_documento_ordine_cx
integer x = 3671
integer y = 152
integer width = 338
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "App. Sconto"
end type

event clicked;long ll_id_prof_doc, ll_id_sog, ll_riga, ll_id_art_da_cercare
string ls_rag_soc, ls_sconto
decimal ld_QTA
integer li_righe, i, a
datastore ds_magg_250
	
//per Elisa: 26-07-2021: se clilente=43 (karizia), qta>250 e profilo "VRBOL" applico sconto 5%
select rag_soc_1 into :ls_rag_soc from azienda;
if pos(upper(ls_rag_soc), "SILVER D")>0 then
	ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
	ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
	if (ll_id_prof_doc=116 OR ll_id_prof_doc=104 or ll_id_prof_doc=60) and ll_id_sog=43 then //116 vrbol, 104 pronto 60 ordclli
		//cerco righe la cui qta sommata a parità di articolo nel documento sia >250
		ds_magg_250=create datastore
		ds_magg_250.dataobject="d_sum_qta_parita_articolo"
		ds_magg_250.settransobject(sqlca)
		li_righe=ds_magg_250.retrieve(il_id_documento)
		//fine ricerca, se ci sono ho trovato le righe da scontare
		//ora le sconto
		for i=1 to li_righe
			ll_id_art_da_cercare=ds_magg_250.getitemnumber(i, "id_articolo")
			for a= 1 to idw_riga.rowcount()
				if idw_riga.getitemnumber(a, "riga_documento_id_articolo")=ll_id_art_da_cercare then
					ld_QTA=ds_magg_250.getitemdecimal(i, "c_qta_tot_articolo")
					If ld_QTA>250 and ld_QTA<1000 then
						ls_sconto='5'
					elseif  ld_QTA>=1000 then
						ls_sconto='15'
					end if
					idw_riga.setitem(a, "sconto", ls_sconto)
				end if	
			next
		next
		destroy ds_magg_250
	end if
end if
//fine elisa 26-07-2021
end event

type cb_7 from commandbutton within w_orafo_documento_ordine_cx
integer x = 3730
integer y = 16
integer width = 279
integer height = 76
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "St. Buratto"
end type

event clicked;f_pdf_doc_fo(il_id_documento, "d_pdf_doc_fo_doc", "articolo_id_articolo")
end event

event rbuttondown;f_pdf_doc_fo(il_id_documento, "d_pdf_doc_fo_doc", "")
end event

type dw_7 from udw_000 within w_orafo_documento_ordine_cx
boolean visible = false
integer x = 4914
integer y = 2076
integer width = 581
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_carica_bol_urgenti"
end type

type dw_8 from udw_000 within w_orafo_documento_ordine_cx
boolean visible = false
integer x = 4914
integer y = 2076
integer width = 581
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_carica_bol_urgenti"
end type

