forward
global type w_documento_ordine_cx from w_p_data
end type
type cb_deriva from commandbutton within tabpage_1
end type
type cb_blocco from commandbutton within tabpage_1
end type
type cb_note from commandbutton within tabpage_1
end type
type cb_cerca_anticipi from commandbutton within tabpage_1
end type
type dw_documento_ordine_ff from u_dw_master_main within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type p_arrow from picture within tabpage_2
end type
type pb_sort from picturebutton within tabpage_2
end type
type cb_ricalcola from commandbutton within tabpage_2
end type
type dw_riga_documento_ordine_gd from u_dw_master_main within tabpage_2
end type
type pb_note from picturebutton within tabpage_2
end type
type cb_5bis from commandbutton within tabpage_2
end type
type pb_tree_sort from picturebutton within tabpage_2
end type
type dw_riga_documento_dett_ord_ff from u_dw_master_main within tabpage_2
end type
type tabpage_2 from userobject within tab_1
p_arrow p_arrow
pb_sort pb_sort
cb_ricalcola cb_ricalcola
dw_riga_documento_ordine_gd dw_riga_documento_ordine_gd
pb_note pb_note
cb_5bis cb_5bis
pb_tree_sort pb_tree_sort
dw_riga_documento_dett_ord_ff dw_riga_documento_dett_ord_ff
end type
type tabpage_3 from userobject within tab_1
end type
type dw_documento_bolla_trasp_ff from u_dw_master_main within tabpage_3
end type
type cb_3 from commandbutton within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_documento_bolla_trasp_ff dw_documento_bolla_trasp_ff
cb_3 cb_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_cast_iva_documento_lt from u_dw_master_main within tabpage_4
end type
type dw_spesa_documento_gd from u_dw_master_main within tabpage_4
end type
type st_spese_riepilogo from statictext within tabpage_4
end type
type cb_aggiorna from commandbutton within tabpage_4
end type
type st_spese_riepilogo_cont from statictext within tabpage_4
end type
type st_st_scadenze_sconti_cont from statictext within tabpage_4
end type
type cb_ricalcola_scadenze from commandbutton within tabpage_4
end type
type dw_documento_ord_tot_ff from u_dw_master_main within tabpage_4
end type
type st_st_scadenze_sconti from statictext within tabpage_4
end type
type cb_valuta from commandbutton within tabpage_4
end type
type cb_ricalcola_cast from commandbutton within tabpage_4
end type
type dw_documento_tot_ext_ff from u_dw_master_main within tabpage_4
end type
type cbx_gen_bollo from checkbox within tabpage_4
end type
type cb_applica from commandbutton within tabpage_4
end type
type st_1 from statictext within tabpage_4
end type
type st_val_corrente from statictext within tabpage_4
end type
type st_3 from statictext within tabpage_4
end type
type st_2 from statictext within tabpage_4
end type
type dw_scadenza_documento_lt from u_dw_master_main within tabpage_4
end type
type dw_1 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_cast_iva_documento_lt dw_cast_iva_documento_lt
dw_spesa_documento_gd dw_spesa_documento_gd
st_spese_riepilogo st_spese_riepilogo
cb_aggiorna cb_aggiorna
st_spese_riepilogo_cont st_spese_riepilogo_cont
st_st_scadenze_sconti_cont st_st_scadenze_sconti_cont
cb_ricalcola_scadenze cb_ricalcola_scadenze
dw_documento_ord_tot_ff dw_documento_ord_tot_ff
st_st_scadenze_sconti st_st_scadenze_sconti
cb_valuta cb_valuta
cb_ricalcola_cast cb_ricalcola_cast
dw_documento_tot_ext_ff dw_documento_tot_ext_ff
cbx_gen_bollo cbx_gen_bollo
cb_applica cb_applica
st_1 st_1
st_val_corrente st_val_corrente
st_3 st_3
st_2 st_2
dw_scadenza_documento_lt dw_scadenza_documento_lt
dw_1 dw_1
end type
type tabpage_5 from userobject within tab_1
end type
type dw_contr_documento_lt from u_dw_master_main within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_contr_documento_lt dw_contr_documento_lt
end type
type cbx_simbolo from checkbox within w_documento_ordine_cx
end type
type cb_contabilizza from commandbutton within w_documento_ordine_cx
end type
type cb_calcolatrice from commandbutton within w_documento_ordine_cx
end type
type cbx_cod_barre from checkbox within w_documento_ordine_cx
end type
type cb_lettore from commandbutton within w_documento_ordine_cx
end type
type cb_stampa_etichette from commandbutton within w_documento_ordine_cx
end type
type tv_1 from u_tv_distinta within w_documento_ordine_cx
end type
type cb_duplica from commandbutton within w_documento_ordine_cx
end type
type cb_stampa from picture within w_documento_ordine_cx
end type
type p_video from picture within w_documento_ordine_cx
end type
end forward

global type w_documento_ordine_cx from w_p_data
integer x = 320
integer y = 36
integer width = 3104
integer height = 2048
string title = "Documento Semplificato"
event ue_tipo_documento ( )
event ue_ges_sp_incasso ( )
cbx_simbolo cbx_simbolo
cb_contabilizza cb_contabilizza
cb_calcolatrice cb_calcolatrice
cbx_cod_barre cbx_cod_barre
cb_lettore cb_lettore
cb_stampa_etichette cb_stampa_etichette
tv_1 tv_1
cb_duplica cb_duplica
cb_stampa cb_stampa
p_video p_video
end type
global w_documento_ordine_cx w_documento_ordine_cx

type variables

w_documento_ordine_cx	iw_corrente
u_dw_main	idw_gen
u_dw_main	idw_riga  
u_dw_main	idw_riga_tot
u_dw_main	idw_gen_trasp
u_dw_main	idw_scadenza
u_dw_main	idw_gen_tot
u_dw_main	idw_gen_tot_ext
u_dw_main	idw_spesa
u_dw_main	idw_castelletto
u_dw_main	idw_contropartita
long 		il_row
long 		il_id_documento
long 		il_arrotondamento
decimal		idc_cambio
string		is_tipo_arrotondamento
string 		is_simbolo_valuta
string		is_tipo_documento
string		is_nome_tipo_documento
string		is_last_field
string		is_int_consentiti, is_tipo_registro
string		is_stato_scad_generata
boolean		ib_genera_scadenza = TRUE
boolean		ib_genera_castelletto = FALSE
boolean		ib_crea_spesa=FALSE


boolean		ib_reset=FALSE
long		il_id_mod_registro, il_id_registro, il_id_esercizio
long		il_id_tab_iva
long		il_id_tab_iva_art_15
long		il_id_conto_predefinito
string		is_esenzione

long		il_id_spesa_bollo

long		il_id_spesa_incasso
decimal		idc_spesa_inc_importo

uo_esp_pag	iuo_pag

string		 is_ric_riga, is_ric_documento

string		 is_con_data_progressiva

string		is_blocco

boolean		ib_prot_modificato=FALSE

boolean		ib_cast_modificato=FALSE

boolean		ib_rinumera_righe=FALSE

long		il_drag_row

u_contab_documento iu_contab_documento

string		is_contr_esen_der
string is_ges_locazioni, is_conto_vis_scarico

datastore ids_lotti, ids_doc_lotto, ids_scar_lotto
datastore ids_riga_doc_lotto
long il_id_lotti[]
decimal idt_qta_lotti[], idt_qta_scar_attuale[]
long il_id_doc_anticipo[]
datastore ids_anticipi


datastore ids_righe_ordine
long il_salvato
string is_tipo_doc_documento_per_nuovo

integer ii_ricerca_art_fornitore
integer li_flag, il_doppio_doc

string is_prof_dispo
datastore ids_disponibilita
string is_movimentazione
char ib_cal_giac_costi
long	al_id_val_az
integer	ii_sal_automatico
boolean	ib_cast_in_updatestart_righe  //20261012 true = il discendente ricalcola il castelletto nell'updatestart delle righe
datastore	ids_par_aper_partita, ids_par_scar_partita  //20261028 partite gia' ricalate dal discendente: le salva w_utl_cancella_documento_wz
end variables

forward prototypes
public function decimal uf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita)
public function long uf_iva_item (long al_item)
public function long uf_individua_spese ()
public function integer uf_set_des_articolo (long al_row, long al_id_lingua, long al_id_linguaggio, long al_id_sog_comm)
public function integer uf_set_ric (string as_value, string as_field, datawindow adw_datawindow)
public function long uf_calc_nr_rate (long al_id_sog_comm)
public function long uf_ges_eventi (string as_evento)
public function long uf_ins_riga_cast (long al_id_tab_iva, u_dw_master_main adw_castelletto, decimal adc_imponibile, decimal adc_imposta, decimal adc_omaggi_sc_merce)
public function string uf_check_sospesi ()
public function string uf_calc_eva_doc (u_dw_main adw_righe)
public function string uf_calc_stato_doc ()
public function integer uf_blocco_documento ()
public function long uf_calc_locazione (long al_id_magazzino)
public function long uf_get_ali_max ()
public function long uf_get_imp_max ()
public function decimal uf_round (decimal adc_numero)
public function integer uf_set_mask_riga ()
public function string uf_update_info ()
public function long uf_dw_changed (u_dw_master_main adw_current)
public function decimal uf_calc_importo (decimal al_importo)
public function integer uf_ricerca ()
public function integer uf_set_documento ()
public function integer uf_set_istanze ()
public function integer uf_set_title ()
public function long uf_conto_x_spesa (long al_id_spesa)
public function boolean uf_riga_valida (long al_row)
public function long uf_set_currow ()
public function integer uf_default_focus ()
public function integer uf_wizard_riga ()
public function integer uf_nuovo_documento ()
public function integer uf_load_documento (long al_id_documento)
public function integer uf_report_righe ()
public function integer uf_setup_documento ()
public function boolean uf_is_modified ()
public subroutine uf_contabilizza ()
public function string uf_tipo_registro (long al_id_registro)
public subroutine uf_abilita_contabilizza ()
public function boolean uf_fattura_contabilizzata ()
public function integer uf_set_tipo_doc ()
public function integer uf_scaglione_provvigione ()
public function boolean uf_test_data_registrazione (date ad_data)
public function integer wf_controlla_qta_mov (long al_id_unita_conf, string as_dato)
public subroutine wf_cal_costi ()
public subroutine wf_impongo_magazzino (integer ai_riga_inizio, integer ai_riga_fine)
public subroutine wf_cal_cmc ()
public function integer wf_setta_cambio (integer tipo_settaggio, string valore)
public subroutine wf_chiusura_righe ()
public subroutine wf_inserisci_pesi_riga (decimal quantita)
public subroutine wf_aggiorna_riepiloghi ()
public subroutine wf_new_cal_cmc ()
public subroutine wf_cal_pesi_colli (boolean active_message)
public subroutine wf_inf_aggiuntive (long id_unita_confezione, long riga, integer id_articolo)
public subroutine wf_qta (integer righe_old, integer righe_new)
public function string wf_gestisci_lotti (long al_id_causale, integer ai_flag)
public function integer wf_salva_lotti (string as_car_scar)
public subroutine wf_risetta_qta_originale (long al_row, string as_colonna, decimal ad_qta, datawindow adw)
public subroutine wf_tipo_prezzi ()
public function long wf_trova_causale (datawindow adw_gen, string as_flag)
public function decimal wf_trova_prezzo (long aid_unita_conf, decimal ad_qta, decimal ad_peso, decimal ad_prezzo)
public subroutine wf_setta_evasione_anticipi (ref datastore ads_anticipi)
public subroutine wf_proteggi_acconto ()
public function boolean uf_sog_esente_iva (long id_soggetto)
public function string wf_decode_key (integer posizione, string key)
public subroutine wf_update_riga (readonly long al_id_riga, readonly character ac_set)
public subroutine wf_proponi_profilo (string as_tipo)
public function long wf_cancella_lotti (long ll_row)
public function long wf_controlla_lotti (string as_gest_lotti)
public subroutine wf_azzera_campi_calcolati_sog (long ll_row)
public subroutine wf_scarico_lotti (long ll_id_articolo, decimal ld_qta, long row)
public subroutine wf_carico_lotti (long al_row, long al_id_art)
public function integer wf_controlla_utilizzabile (long al_id_articolo)
public function integer uf_stampa ()
public function long wf_calcola_cpt (long al_id_sog_commerciale, long al_id_gr_agente, long al_id_articolo, long al_id_causale)
public subroutine f_componenti_distinta (long ll_id_distinta)
public subroutine wf_controlla_destinazione (long al_id_sog_commerciale)
public subroutine wf_se_cambia_qta (long row, string data)
public subroutine wf_prepara_esplodi (long row, string data)
public subroutine wf_integra_campi_sog_com (long ll_id_tab_iva)
public function string wf_cod_fornitore (string ls_art)
public function integer uf_rinumera_righe (integer li_cancella)
public function string wf_varianti_set (string as_cod_articolo, long al_riga)
public subroutine wf_proponi_dati_lotto (integer ai_row)
public subroutine uf_pre_blocca_dispo (integer row)
public function integer uf_blocca_dispo (decimal ld_tot_precedente, string data, integer row)
public subroutine uf_setta_precedente (integer row, decimal ld_precedente, string name)
public subroutine wf_gruppo_agenti (integer ai_row)
public function integer wf_ver_spesa (integer ai_row)
public subroutine wf_calcola_spese (character ac_conferma)
public function integer uf_importa_righe (s_par_der_doc astr_par)
public function integer uf_set_dec_mask (integer ai_decimali, string as_valuta, long id_valuta)
public subroutine wf_calc_cpt_sco_tot (character as_cpt_sconti, ref datawindow adw_cpt, string as_sc_finanziario, decimal adc_sc_incondizionato, decimal adc_sc_fin_cassa)
public function integer uf_ins_riga_cp (long al_id_contropartita, string as_tipo, datawindow adw_contropartita, decimal adc_imponibile, decimal adc_imp_scontato, decimal adc_omaggi_sc_merce, decimal adc_spese)
public subroutine uf_crea_spesa (long al_row, string as_codice, long al_id_spesa, long al_percentuale, decimal al_importo, long al_tab_iva, string as_mod_calc_iva)
public function integer wf_set_printer_info (string as_nome_stampante)
public subroutine wf_salva_automaticamente ()
public function s_des_articolo uf_calc_des_art (long al_id_articolo, long al_id_sog_comm, long al_id_lingua, long al_id_linguaggio, long al_row)
public subroutine wf_metti_descrizione (long al_row)
public subroutine wf_clicca_cb_partite ()
public subroutine wf_set_utedocumento (string ac_operazione)
public function string wf_galv_o_metallo (long al_riga)
end prototypes

event ue_tipo_documento;

long ll_id_prof_documento, ll_row 
char lc_trasporto, lc_totali, lc_contropartite

ll_row = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
if ll_row > 0 then ll_id_prof_documento = tab_1.tabpage_1.dw_documento_ordine_ff.object.id_prof_documento[ll_row]

SELECT non_vis_pag_trasporto, non_vis_pag_totali, non_vis_pag_contropartite
INTO	 :lc_trasporto, :lc_totali, :lc_contropartite
FROM	 prof_documento
WHERE  id_prof_documento = :ll_id_prof_documento 
;

if (sqlca.sqlcode = -1) then messagebox("Dberror", sqlca.sqlerrtext)

if (lc_trasporto = 'S') then
	tab_1.tabpage_3.visible= FALSE
	tab_1.tabpage_3.enabled= FALSE
end if

if (lc_totali = 'S') then
	tab_1.tabpage_4.visible= FALSE
	tab_1.tabpage_4.enabled= FALSE
end if

if (lc_contropartite = 'S') then
	tab_1.tabpage_5.visible= FALSE
	tab_1.tabpage_5.enabled= FALSE	
end if


CHOOSE CASE is_tipo_documento
	CASE "O"
		is_nome_tipo_documento= "Ordine"
		this.Title = "Ordine"
	CASE "F"
		is_nome_tipo_documento= "Fattura"
		this.Title = "Fattura"
		
	CASE "D"
		is_nome_tipo_documento= "Bolla-DDT"
		this.Title = "Bolla"

	CASE "P"
		is_nome_tipo_documento= "Preventivo"
		this.Title = "Preventivo"
END CHOOSE
end event

event ue_ges_sp_incasso;call super::ue_ges_sp_incasso;
long ll_id_sog_commerciale

ll_id_sog_commerciale= idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
SELECT "spesa"."id_spesa" ,"spesa_sog_commerciale"."importo"  
	INTO :il_id_spesa_incasso , 
		:idc_spesa_inc_importo  
	FROM "dba"."spesa_sog_commerciale",   
		"dba"."spesa"  
	WHERE ( "spesa"."id_spesa" = "spesa_sog_commerciale"."id_spesa" ) and  
		( ( "spesa"."codice" = 'C' ) AND  
		( "spesa_sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) )   ;

end event

public function decimal uf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita);
char		lch_sconto[], lch_item[]
long 		ll_char_size, ll_char_count, ll_item_count
decimal  ldc_parte,ldc_tot_riga
string  ls_parte
long ll_row, ll_pos_plus,ll_pos_minus, ll_pos
boolean lb_non_calcolabile, lb_minus
string ls_tot_riga

lb_minus= FALSE
lch_item = ""
ll_item_count=0
if IsNull(adc_prezzo) then adc_prezzo = 0
if not (IsNull(as_sconto) OR as_sconto= "") then
	lch_sconto= Trim(as_sconto)
	ll_char_size= UpperBound(lch_sconto)
	For ll_char_count= 1 to ll_char_size
		CHOOSE CASE lch_sconto[ll_char_count]
			CASE "-"
				If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if  ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
						else
							adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = TRUE
			CASE "+"
					If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
						else
							adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = FALSE
			CASE ELSE
				ll_item_count ++
				lch_item[ll_item_count]= lch_sconto[ll_char_count]
		END CHOOSE
	next


	If not(lch_item = "") then
		ldc_parte= Dec(lch_item)
		if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
		
			SetNull(ldc_parte)	
			RETURN ldc_parte
		else
			if lb_minus then
				adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
			else
				adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
			end if
		end if
	end if
end if

RETURN adc_prezzo

end function

public function long uf_iva_item (long al_item);
long ll_item_found

return ll_item_found
end function

public function long uf_individua_spese ();

return 1
end function

public function integer uf_set_des_articolo (long al_row, long al_id_lingua, long al_id_linguaggio, long al_id_sog_comm);
return 0
end function

public function integer uf_set_ric (string as_value, string as_field, datawindow adw_datawindow);

string ls_color
CHOOSE CASE as_value
	CASE "N"
		f_displayonly(adw_datawindow, as_field, TRUE)

		
		ls_color = "276856960"
		adw_datawindow.Modify(as_field + ".color = " + ls_color)
	CASE "L"
		f_displayonly(adw_datawindow, as_field, TRUE)
		ls_color= f_get_dwo_property(adw_datawindow.Describe(as_field + ".color"), "0", "")
		adw_datawindow.Modify(as_field + ".color = " + ls_color)
		
		adw_datawindow.Modify(as_field + ".color = 0")

	CASE "M"
		f_displayonly(adw_datawindow, as_field, FALSE)
		ls_color= f_get_dwo_property(adw_datawindow.Describe(as_field + ".color"), "0", "")
		adw_datawindow.Modify(as_field + ".color = " + ls_color)

		CHOOSE CASE String(adw_datawindow.Describe(as_field + ".edit.style"))
			CASE "edit"
				adw_datawindow.Modify(as_field + ".edit.nilisnull = FALSE")
				adw_datawindow.Modify(as_field + ".edit.required = FALSE")
			CASE "dddw"
				adw_datawindow.Modify(as_field + ".dddw.required = FALSE")

			CASE "ddlb"
				adw_datawindow.Modify(as_field + ".ddlb.required = FALSE")
			CASE "editmask"
				adw_datawindow.Modify(as_field + ".editmask.required = FALSE")
			CASE ELSE
		END CHOOSE
	CASE "O"
		CHOOSE CASE String(adw_datawindow.Describe(as_field + ".edit.style"))
			CASE "edit"
				adw_datawindow.Modify(as_field + ".edit.nilisnull = TRUE")
				adw_datawindow.Modify(as_field + ".edit.required = TRUE")
			CASE "dddw"
				adw_datawindow.Modify(as_field + ".dddw.required = TRUE")

			CASE "ddlb"
				adw_datawindow.Modify(as_field + ".ddlb.required = TRUE")
			CASE "editmask"
				adw_datawindow.Modify(as_field + ".editmask.required = TRUE")
			CASE ELSE
		END CHOOSE
END CHOOSE
return 0
end function

public function long uf_calc_nr_rate (long al_id_sog_comm);
long ll_nr_rate

if isNull(al_id_sog_comm) then
 ll_nr_rate= 1
else
	SELECT sum("app_pagamento"."num_rate")  
		INTO :ll_nr_rate  
		FROM "dba"."con_pagamento",   
			"dba"."sog_commerciale",   
			"dba"."app_pagamento"  
		WHERE ( "sog_commerciale"."id_con_pagamento" = "con_pagamento"."id_con_pagamento" ) and  
			( "app_pagamento"."id_con_pagamento" = "con_pagamento"."id_con_pagamento" ) and  
			( ( "sog_commerciale"."id_sog_commerciale" = :al_id_sog_comm ) )   ;
	If IsNull(ll_nr_rate) then ll_nr_rate= 0
end if

return ll_nr_rate
end function

public function long uf_ges_eventi (string as_evento);

long 			ll_nr_campi, ll_count
string 		ls_name

dwobject ldw[]

CHOOSE CASE as_evento
		CASE "STAMPATO", "BLOCCATO", "CONTABILIZZATO"
			idw_gen.enabled= FALSE
			idw_riga.enabled= FALSE
			idw_spesa.enabled= FALSE
			idw_riga_tot.enabled= FALSE
			idw_gen_tot.enabled= FALSE
			tab_1.tabpage_1.cb_note.enabled= FALSE

		CASE ELSE 
			idw_gen.enabled= TRUE
			idw_riga.enabled= TRUE
			idw_spesa.enabled= TRUE
			idw_riga_tot.enabled= TRUE
			idw_gen_tot.enabled= TRUE

END CHOOSE


return 0
end function

public function long uf_ins_riga_cast (long al_id_tab_iva, u_dw_master_main adw_castelletto, decimal adc_imponibile, decimal adc_imposta, decimal adc_omaggi_sc_merce);

decimal 		ldc_aliquota, ldc_imponibile, ldc_ret_value, ldc_omaggi_sc_merce, ldc_imposta, ldc_per_detrazione
string 		ls_codice, ls_descr_breve
long 			ll_row_found, ll_new_row


if not (IsNull(al_id_tab_iva) OR al_id_tab_iva = 0) then 
	If adw_castelletto.RowCount() > 0 then
		ll_row_found=adw_castelletto.Find("id_tab_iva =" + string(al_id_tab_iva),1,adw_castelletto.RowCount())
	else
		ll_row_found=0
	end if
		if ll_row_found= 0 then
	
		ll_new_row= adw_castelletto.InsertRow(0)
	  SELECT "tab_iva"."per_aliquota","tab_iva"."per_detrazione"
		 INTO :ldc_aliquota, :ldc_per_detrazione
		 FROM "dba"."tab_iva"  
		 WHERE "tab_iva"."id_tab_iva" = :al_id_tab_iva   ;
		ldc_ret_value=ll_new_row
		string ls_cod
		select codice
		into :ls_cod
		from tab_iva
		where id_tab_iva=:al_id_tab_iva;
		adw_castelletto.SetItem(ll_new_row, "tab_iva_codice", ls_cod)
		adw_castelletto.SetItem(ll_new_row, "id_documento", il_id_documento)
		adw_castelletto.SetItem(ll_new_row, "id_tab_iva",al_id_tab_iva)
		adw_castelletto.SetItem(ll_new_row, "val_omaggi", adc_omaggi_sc_merce)
		adw_castelletto.SetItem(ll_new_row, "c_imposta", adc_imposta)
		adw_castelletto.SetItem(ll_new_row, "val_imponibile", adc_imponibile)
		adw_castelletto.SetItem(ll_new_row, "c_aliquota", ldc_aliquota)
		adw_castelletto.SetItem(ll_new_row, "cc_per_detrazione", ldc_per_detrazione)
	else
	
		ldc_ret_value= ll_row_found
		ldc_imponibile= adw_castelletto.uf_GetItemDecimal(ll_row_found,"val_imponibile")
		if IsNull(ldc_imponibile) then ldc_imponibile= 0
		adw_castelletto.SetItem(ll_row_found, "val_imponibile", adc_imponibile + ldc_imponibile)
	 	ldc_imposta= adw_castelletto.uf_GetItemDecimal(ll_row_found,"c_imposta")
		if IsNull(ldc_imposta) then ldc_imposta= 0
		adw_castelletto.SetItem(ll_row_found, "c_imposta", adc_imposta + ldc_imposta)
		ldc_omaggi_sc_merce=adw_castelletto.uf_GetItemDecimal(ll_row_found,"val_omaggi")
		if IsNull(ldc_omaggi_sc_merce) then ldc_omaggi_sc_merce= 0
		adw_castelletto.SetItem(ll_row_found, "val_omaggi", adc_omaggi_sc_merce + ldc_omaggi_sc_merce)
	end if
end if
return ldc_ret_value


end function

public function string uf_check_sospesi ();
long			ll_id_sog_commerciale,ll_row
string		ls_retv,ls_con_fido
s_list_main	lstr_list_main


IF is_tipo_registro='OV' THEN return "OK"

ll_row						= this.tab_1.tabpage_1.dw_documento_ordine_ff.GetRow()
ll_id_sog_commerciale 	= this.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber( ll_row,"id_sog_commerciale" )

select "sog_commerciale"."con_fido"
	into :ls_con_fido
	from "dba"."sog_commerciale"
	where "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale
	using SQLCA;		
	
if isNull(ls_con_fido) then
	ls_con_fido = 'N'
end if	

if ls_con_fido = 'N' then
	return "OK"
end if	

lstr_list_main.s_identifica[1] = "id_sog_commerciale"
lstr_list_main.l_identifica[1] = ll_id_sog_commerciale

long ll_id_esercizio,ll_id_valuta
ll_id_esercizio = idw_gen.getitemnumber(1,"c_esercizio")
select id_valuta
into :ll_id_valuta
from esercizio
where id_esercizio = :ll_id_esercizio;
if isnull(ll_id_valuta) then ll_id_valuta = 0
lstr_list_main.l_id_varie = ll_id_valuta 

choose case ls_con_fido 

	case 'C'
		OpenWithParm( w_esposizione_sog_comm_wz,lstr_list_main )
		return "OK"
			
	case 'B'	
		OpenWithParm( w_esposizione_sog_comm_wz,lstr_list_main )
		ls_retv = Message.StringParm
		choose case ls_retv
			case "OK"
				return "OK"
			case "BLOCCA"	
				return "BLOCCA"
		end choose	
			
	case 'X'
		OpenWithParm( w_esposizione_sog_comm_wz,lstr_list_main )
		return "BLOCCA"
			
end choose	


return "OK"

end function

public function string uf_calc_eva_doc (u_dw_main adw_righe);long		ll_righe, ll_i, ll_et, ll_ep, ll_ne, ll_cf, ll_nc
decimal	ld_qta1, ld_qta2
string	ls_cf, ls_r1, ls_r2, ls_ret

ll_et = 0
ll_ep = 0
ll_ne = 0
ll_righe = adw_righe.RowCount()
if ll_righe > 0 then
	for ll_i = 1 to ll_righe
		ld_qta1 = adw_righe.uf_GetItemDecimal(ll_i,"quantita") + &
						adw_righe.uf_GetItemDecimal(ll_i,"qta_sconto_merce")
		ld_qta2 = adw_righe.uf_GetItemDecimal(ll_i,"qta_evasa")
		ls_cf = adw_righe.GetItemString(ll_i,"riga_documento_forza_chius_evasione")
	
		if (ld_qta1 > 0) and (ld_qta2 = 0) then ll_ne = ll_ne + 1
		if (ld_qta1 > 0) and (ld_qta2 >= ld_qta1) then ll_et = ll_et + 1
		if (ld_qta1 > 0) and (ld_qta2 > 0) and (ld_qta2 <  ld_qta1) then ll_ep = ll_ep + 1
		if (ls_cf = "S") then
			ll_cf = ll_cf + 1
		else
			ll_nc = ll_nc + 1
		end if
	next
	if ((ll_et = 0) and (ll_ep = 0)) then
		ls_r1 = "N"
	else
		if ((ll_et > 0) and (ll_ep = 0) and (ll_ne = 0)) then
			ls_r1 = "T"
		else
			ls_r1 = "P"
		end if
	end if
	if (ll_cf = 0) then
		ls_r2 = "N"
	else
		//260810 blocca i doc alla samy, per ora lo tolgo poi cerco di capire perché
//		if (ll_nc = 0) then
//			ls_r2 = "T" 
//		else
			ls_r2 = "P" 
//		end if
	end if
else
	ls_r1 = "N"
	ls_r2 = "N"
end if

ls_ret = ls_r1 + ls_r2

return ls_ret
end function

public function string uf_calc_stato_doc ();


string 	ls_ret, ls_st

ls_st = tab_1.tabpage_1.dw_documento_ordine_ff.uf_get_colval("bloccato")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = tab_1.tabpage_1.dw_documento_ordine_ff.uf_get_colval("documento_chius_forzata")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = tab_1.tabpage_1.dw_documento_ordine_ff.uf_get_colval("documento_contabilizzato")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = uf_calc_eva_doc(tab_1.tabpage_2.dw_riga_documento_ordine_gd)
ls_ret = ls_ret + ls_st


ls_st = tab_1.tabpage_1.dw_documento_ordine_ff.uf_get_colval("documento_sospeso")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = tab_1.tabpage_1.dw_documento_ordine_ff.uf_get_colval("documento_stampato")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = tab_1.tabpage_1.dw_documento_ordine_ff.uf_get_colval("creato_in_esenzione")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if


return ls_ret
end function

public function integer uf_blocco_documento ();

string	ls_mes1, ls_mes2, ls_mes3, ls_mes4, ls_mes5
string	ls_stato_doc	
											

ls_stato_doc = uf_calc_stato_doc()

if mid(ls_stato_doc,1,1) = "S" then
	ls_mes1 = "Bloccato dall'utente. ~r"
end if

if mid(ls_stato_doc,2,1) = "S" then

	ls_mes2 = "Chiuso dall'utente. ~r"
end if

if mid(ls_stato_doc,3,1) = "S" then
	ls_mes3 = "Contabilizzato. ~r"
end if

if mid(ls_stato_doc,4,1) = "S" then
	ls_mes4 = "Evaso Totalmente. ~r"
end if

if mid(ls_stato_doc,6,1) = "T" then
	ls_mes5 = "Stampato. ~r"
end if

if (mid(ls_stato_doc,1,1) = "S" or mid(ls_stato_doc,2,1) = "S" or 	mid(ls_stato_doc,3,1) = "S" or mid(ls_stato_doc,5,1) = "T") then
	MessageBox("Documento", "Il documento è stato bloccato in quanto: ~r" + ls_mes1 + ls_mes2 + ls_mes3 + ls_mes4 + ls_mes5,Exclamation!)
CHOOSE CASE is_tipo_documento
	CASE "O"
		iuo_msg_log.uf_new_text("Ordine Bloccato",0)
	CASE "F"
		iuo_msg_log.uf_new_text("Fattura Bloccata",0)
	CASE "D"
		iuo_msg_log.uf_new_text("Bolla Bloccata",0)
	CASE "P"
		iuo_msg_log.uf_new_text("Preventivo Bloccato",0)
END CHOOSE
	is_blocco="B"
	tab_1.tabpage_1.dw_documento_ordine_ff.Enabled = FALSE
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.Enabled = FALSE
	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.Enabled = FALSE
	tab_1.tabpage_3.dw_documento_bolla_trasp_ff.Enabled = FALSE
	tab_1.tabpage_4.dw_spesa_documento_gd.Enabled = FALSE
	tab_1.tabpage_4.dw_cast_iva_documento_lt.Enabled = FALSE
	tab_1.tabpage_4.dw_documento_ord_tot_ff.Enabled = FALSE
	tab_1.tabpage_5.dw_contr_documento_lt.Enabled = FALSE
	tab_1.tabpage_1.cb_note.Enabled = FALSE
	cbx_simbolo.Enabled = FALSE
	tab_1.tabpage_4.cb_valuta.Enabled = FALSE
	tab_1.tabpage_4.cb_ricalcola_cast.Enabled = FALSE
	tab_1.tabpage_2.cb_ricalcola.Enabled = FALSE
	tab_1.tabpage_1.cb_deriva.Enabled = FALSE
	cb_nuovo.Enabled = FALSE
	cb_salva.Enabled = FALSE
	cb_inserisci.Enabled = FALSE
	cb_cancella.Enabled = FALSE
	//cb_stampa.Enabled = FALSE
else
	CHOOSE CASE is_tipo_documento
		CASE "O"
			iuo_msg_log.uf_new_text("Documento non bloccato.",1)
		CASE "F"
			iuo_msg_log.uf_new_text("Documento non bloccato.",1)
		CASE "D"
			iuo_msg_log.uf_new_text("Documento non bloccato.",1)
		CASE "P"
			iuo_msg_log.uf_new_text("Documento non bloccato.",1)
	END CHOOSE
	is_blocco=""
	tab_1.tabpage_1.dw_documento_ordine_ff.Enabled = TRUE
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.Enabled = TRUE
	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.Enabled = TRUE
	tab_1.tabpage_3.dw_documento_bolla_trasp_ff.Enabled = TRUE
	tab_1.tabpage_4.dw_spesa_documento_gd.Enabled = TRUE
	tab_1.tabpage_4.dw_cast_iva_documento_lt.Enabled = TRUE
	tab_1.tabpage_4.dw_documento_ord_tot_ff.Enabled = TRUE
	tab_1.tabpage_5.dw_contr_documento_lt.Enabled = TRUE
	tab_1.tabpage_1.cb_note.Enabled = TRUE
	cbx_simbolo.Enabled = TRUE
	tab_1.tabpage_4.cb_valuta.Enabled = TRUE
	tab_1.tabpage_4.cb_ricalcola_cast.Enabled = TRUE
	tab_1.tabpage_2.cb_ricalcola.Enabled = TRUE
	tab_1.tabpage_1.cb_deriva.Enabled = TRUE
	cb_nuovo.Enabled = TRUE
	cb_salva.Enabled = TRUE
	cb_inserisci.Enabled = TRUE
	cb_cancella.Enabled = TRUE
	cb_stampa.Enabled = TRUE

end if
return 0
end function

public function long uf_calc_locazione (long al_id_magazzino);
long ll_id_locazione

SELECT max("locazione"."id_locazione")
	INTO :ll_id_locazione  
	FROM "dba"."locazione",   
		"dba"."magazzino"  
	WHERE ( "magazzino"."id_magazzino" = "locazione"."id_magazzino" ) and  
		( "magazzino"."id_magazzino" = :al_id_magazzino) and  
		( "locazione"."id_area" IS NULL ) AND  
		( "locazione"."corsia" IS NULL ) AND  
		( "locazione"."scaffale" IS NULL ) AND  
		( "locazione"."ripiano" IS NULL ) AND  
		( "locazione"."posizione" IS NULL ) ;

RETURN ll_id_locazione
end function

public function long uf_get_ali_max ();

long 		ll_nr_row, ll_count, ll_id_tab_iva_max
decimal 	ldc_aliquota, ldc_max_aliquota

ldc_max_aliquota=0
SetNull(ll_id_tab_iva_max)
ll_nr_row= idw_castelletto.RowCount()
for ll_count = 1 to ll_nr_row 
	ldc_aliquota= idw_castelletto.uf_GetItemDecimal(ll_count, "c_aliquota")
	if ldc_aliquota > ldc_max_aliquota then
		ldc_max_aliquota=ldc_aliquota
		ll_id_tab_iva_max= idw_castelletto.GetItemNumber(ll_count, "id_tab_iva")
	end if
next
return ll_id_tab_iva_max
end function

public function long uf_get_imp_max ();


long 		ll_nr_row, ll_count, ll_id_tab_iva_max
decimal 	ldc_prezzo, ldc_max_prezzo

ldc_max_prezzo=0
SetNull(ll_id_tab_iva_max)
ll_nr_row= idw_castelletto.RowCount()
for ll_count = 1 to ll_nr_row 
	ldc_prezzo= idw_castelletto.uf_GetItemDecimal(ll_count, "val_imponibile")
	if ldc_prezzo > ldc_max_prezzo then
		ldc_max_prezzo=ldc_prezzo
		ll_id_tab_iva_max= idw_castelletto.GetItemNumber(ll_count, "id_tab_iva")
	end if
next
return ll_id_tab_iva_max
end function

public function decimal uf_round (decimal adc_numero);



decimal 	ldc_ret_number, ldc_precisione
long ll_arrotondamento, ll_id_valuta, ll_dec_significativi

ll_id_valuta= idw_gen.GetItemNumber(il_row, "documento_id_valuta_des")
select dec_significativi
into :ll_dec_significativi
from valuta
where id_valuta = :ll_id_valuta;

ll_arrotondamento= ll_dec_significativi
if isnull(ll_arrotondamento) then ll_arrotondamento=0
If ll_arrotondamento >= 0 then
	ldc_precisione = 10^ll_arrotondamento
else
	ll_arrotondamento= - ll_arrotondamento
	ldc_precisione = 1 / (10^ll_arrotondamento)
end if

ldc_ret_number = adc_numero / ldc_precisione
ldc_ret_number = Round(ldc_ret_number, 0) * ldc_precisione


RETURN ldc_ret_number
end function

public function integer uf_set_mask_riga ();
string 		ls_mask, ls_simbolo
long 			ll_row, ll_id_valuta
decimal 		ldc_cambio
integer		ll_arrotondamento, li_decimali
integer 		li_count
boolean 		lb_simbolo

lb_simbolo= cbx_simbolo.Checked

ls_mask= "#,0"
ll_row= idw_riga.GetRow()
if ll_row > 0 then
	ll_id_valuta= idw_riga.GetItemNumber(ll_row, "riga_documento_id_valuta")	
	if not(IsNull(ll_id_valuta) OR ll_id_valuta=0) then
	
	string	ls_edit_mask
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
		ls_mask = f_valu_mask(ll_id_valuta)
		ls_edit_mask = f_valu_edit(ll_id_valuta)
		
		
		if ls_simbolo <> "" AND lb_simbolo= TRUE then ls_mask = ls_simbolo + " " + ls_mask
	end if
	idw_riga_tot.Modify("prezzo_netto.format = '" + ls_edit_mask + "'")
	idw_riga_tot.Modify("prezzo_netto.edit.mask = '" + ls_edit_mask + "'")
	idw_riga_tot.Modify("prezzo_netto.edit.format = '" + ls_edit_mask + "'")	
	
	
	idw_riga_tot.Modify("tot_riga_val_riga.format = '" + ls_edit_mask + "'")

	
	idw_riga.Modify("prezzo.format = '" + ls_edit_mask + "'")
	idw_riga.Modify("prezzo.edit.format = '" + ls_edit_mask + "'")	
	
	idw_riga_tot.Modify("costo_medio.format = '" + ls_edit_mask + "'")
	idw_riga_tot.Modify("costo_ultimo.format = '" + ls_edit_mask + "'")
	idw_riga_tot.Modify("cmc.format = '" + ls_edit_mask + "'")	
	
end if 

return 0


end function

public function string uf_update_info ();

long 			ll_count, ll_size, ll_row_count
boolean 		lb_dw_changed
string 		ls_Report
u_dw_master_main	ldw_children

lb_dw_changed= FALSE
if not idw_master.ib_dw_shared then
	if uf_dw_changed(idw_master) > 0 then lb_dw_changed= TRUE
end if
If lb_dw_changed then ls_Report= ls_Report + "~n"+ idw_master.is_title

ll_size= UpperBound(idw_master.iudw_children)
FOR ll_count= 1 to ll_size
	ldw_children= idw_master.iudw_children[ll_count]
	lb_dw_changed= FALSE
	if not ldw_children.ib_dw_shared then
	
		if uf_dw_changed(ldw_children) > 0 then lb_dw_changed= TRUE
	end if
	
	If lb_dw_changed then ls_Report= ls_Report + "~n"+ ldw_children.is_title
NEXT

RETURN ls_Report

end function

public function long uf_dw_changed (u_dw_master_main adw_current);
long 			ll_size, ll_row_count, ll_row_changed
boolean 		lb_dw_changed
string 		ls_Report


lb_dw_changed= FALSE
if adw_current.RowCount() > 0 AND (not adw_current.ib_dw_shared) then
	ll_size= adw_current.RowCount()
	FOR ll_row_count= 1 to ll_size
		If (adw_current.GetItemStatus(adw_current.RowCount(), 0, Primary!)<> NotModified!) then
			ll_row_changed= ll_row_changed + 1
		end if
	NEXT
end if

return ll_row_changed
end function

public function decimal uf_calc_importo (decimal al_importo);

return 0
end function

public function integer uf_ricerca ();
w_search_main 	lw_sm
string 			ls_filtro, ls_registro, ls_Parametro, ls_num_progr, ls_data_1, ls_data_2
s_ric_param		ls_ric_param	
date				ld_data
integer			li_risposta, li_retvalue


If idw_gen.AcceptText() > 0 then
	ls_Parametro = Trim(idw_master.is_list.s_win_parametri)
	if isnull(is_tipo_documento) then is_tipo_documento = ""
	ls_filtro = ""
	CHOOSE CASE is_tipo_documento
		CASE "P"
			ls_filtro = "registro.tipo_registro = 'PV' OR registro.tipo_registro = 'PA'"
		CASE "O"
			ls_filtro = "registro.tipo_registro = 'OA' OR registro.tipo_registro = 'OV'"
		CASE "D"
			ls_filtro = "registro.tipo_registro = 'DA' OR registro.tipo_registro = 'DV'"
		CASE "F"
			ls_filtro = "registro.tipo_registro = 'IA' OR registro.tipo_registro = 'IV' OR registro.tipo_registro = 'IC'"
		CASE "L"			
			ls_filtro = "registro.tipo_registro = 'LA' OR registro.tipo_registro = 'LV'"
		CASE "G"
			ls_filtro = "registro.tipo_registro = 'GA' OR registro.tipo_registro = 'GV'"	
		CASE "I"
			ls_filtro = "registro.tipo_registro = 'IA' OR registro.tipo_registro = 'IV' OR registro.tipo_registro = 'IC'"	
		CASE ""
			ls_filtro = ""	
		CASE ELSE
	
	END CHOOSE
	

	
	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			MessageBox("Ricerca del Documento", "I parametri forniti non permettono la ricerca sul Database ~n" &
						+ "oppure si è verificato un errore sul Database.", Information!)
			iuo_msg_log.uf_new_text("I parametri forniti non permettono la ricerca sul Database oppure si è verificato un errore sul Database.",2)
			RETURN 0
	END CHOOSE
	ls_registro=is_tipo_registro
	if IsNull(ls_registro) OR ls_registro="" then ls_registro=idw_gen.GetItemString(il_row,"c_registro_des")
	if IsNull(ls_registro) then ls_registro=""
	ls_num_progr= String(idw_gen.GetItemNumber(il_row,"num_progressivo"))
	if IsNull(ls_num_progr) then ls_num_progr=""
	ld_data= idw_gen.GetItemDate(il_row,"data_registrazione")
	if IsNull(ld_data) then 
		ls_data_1=""
		ls_data_2=""
	else
		ls_data_1=String(ld_data,"dd/mm/yyyy")
		ls_data_2=String(ld_data,"yyyy-mm-dd")
	end if
	If ls_registro= "" then
		if ls_num_progr="" then
			if ls_data_1= "" then
				
				idw_master.is_ricpar.s_filter_value = ""
				idw_master.is_ricpar.s_filter_name = "cc_descrizione"
			else
				
				idw_master.is_ricpar.s_filter_value = ls_data_1
				idw_master.is_ricpar.s_filter_name = "documento_data_registrazione"
			end if
		else
			if ls_data_1= "" then
				
				idw_master.is_ricpar.s_filter_value = ls_num_progr
				idw_master.is_ricpar.s_filter_name = "documento_num_progressivo"
			else
				
				idw_master.is_ricpar.s_filter_value = 'Nr.Progr. ' + ls_num_progr+ ' del ' + ls_data_2
				idw_master.is_ricpar.s_filter_name = "cc_filtro_3"
			end if
		end if
	else
		if ls_num_progr="" then
			if ls_data_1= "" then
				
				idw_master.is_ricpar.s_filter_value = ls_registro
				idw_master.is_ricpar.s_filter_name = "registro_tipo_registro"
			else
				
				idw_master.is_ricpar.s_filter_value = ls_registro + ' del ' + ls_data_2
				idw_master.is_ricpar.s_filter_name = "cc_filtro_2"
			end if
		else
			if ls_data_1= "" then
				
				idw_master.is_ricpar.s_filter_value = ls_registro + ' - Nr.Progr. ' +  ls_num_progr
				idw_master.is_ricpar.s_filter_name = "cc_filtro_1"
			else
				
				idw_master.is_ricpar.s_filter_value = ls_registro + ' - Nr.Progr. ' + ls_num_progr + ' del ' + ls_data_2		
				idw_master.is_ricpar.s_filter_name = "cc_filtro_4"
			end if
		end if
	end if
	If IsNull(idw_master.is_ricpar.s_filter_value) OR idw_master.is_ricpar.s_filter_value = "" then idw_master.is_ricpar.s_filter_value = ""
	If IsNull(idw_master.is_ricpar.s_filter_name) OR idw_master.is_ricpar.s_filter_name = "" then idw_master.is_ricpar.s_filter_name = "cc_descrizione"
	idw_master.is_ricpar.s_SQL_cond = ls_filtro
	OpenWithParm(lw_sm, idw_master.is_ricpar, "w_documento_sw")
	
	ls_ric_param= Message.PowerObjectParm
	if not IsNull(ls_ric_param) then 
		idw_master.is_ricpar=ls_ric_param
		IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
			
			
			if uf_is_modified() = True then
				
				if idw_master.uf_to_update() > 0 then
					li_risposta = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
						"finestra.~n~rVuoi salvarle?", Question!, YesNo!,1)
					CHOOSE CASE li_risposta
						CASE 1
							
							li_retvalue=idw_master.event ue_update (0,0)
						CASE 2
							
							li_retvalue=0
					END CHOOSE
				end if
			end if	

			If li_retvalue=0 then
				il_id_documento = long(idw_master.is_ricpar.s_id_seg_value[1])
				idw_master.is_list.s_modo = modo_modifica
				idw_master.is_list.s_identifica[1] = "id_documento"
				idw_master.is_list.l_identifica[1] = il_id_documento
				SetPointer(HourGlass!)
				
				this.enabled= FALSE
				idw_master.Event ue_retrieve(0, 0)
				uf_set_documento()
				uf_setup_documento()
				uf_set_istanze()
				this.enabled= TRUE
				uf_default_focus()
				SetPointer(Arrow!)
			end if
	
		END IF
	END IF
END IF




RETURN 0

end function

public function integer uf_set_documento ();
long 			ll_row, ll_id_valuta, ll_arrotondamento
decimal 		ldc_cambio, ldc_null
string		ls_null

tab_1.tabpage_1.dw_documento_ordine_ff.event ue_set_esercizio()
tab_1.tabpage_1.dw_documento_ordine_ff.event ue_set_prof_fields()
tab_1.tabpage_1.dw_documento_ordine_ff.event ue_set_valu_fields("")
tab_1.tabpage_1.dw_documento_ordine_ff.event ue_set_sp_incasso()
tab_1.tabpage_1.dw_documento_ordine_ff.event ue_set_not_new()
uf_blocco_documento()
il_id_documento= idw_gen.GetItemNumber(il_row, "id_documento")
is_blocco=""
if is_tipo_documento = "P" AND is_blocco="" then
	SetNull(ldc_null)
	SetNull(ls_null)
	tab_1.tabpage_1.dw_documento_ordine_ff.Event ue_calc_totale(ls_null, ldc_null,ldc_null)
end if

RETURN 0

end function

public function integer uf_set_istanze ();
u_setta_campi_documento uo_setta_campi_doc
uo_setta_campi_doc=create u_setta_campi_documento
	
il_id_spesa_bollo=uo_setta_campi_doc.uf_set_spesa_bollo()
il_id_conto_predefinito=uo_setta_campi_doc.uf_set_conto_predefinito(idw_gen)
uo_setta_campi_doc.uf_set_istanza(idw_gen)
destroy uo_setta_campi_doc

RETURN 0











end function

public function integer uf_set_title ();

string 	ls_num_progressivo, ls_data_registrazione, ls_tipo_registro,ls_title
long 		ll_id_registro


ls_num_progressivo= idw_gen.uf_get_colval("num_documento")
ls_data_registrazione= idw_gen.uf_get_colval("data_documento")

If idw_gen.GetItemStatus(il_row, 0,Primary!)= New! OR idw_gen.GetItemStatus(il_row, 0,Primary!)= NewModified! then
	
	CHOOSE CASE is_tipo_documento
		CASE "O"
			ls_title =	"Nuovo Ordine" 
		CASE "F"
			ls_title =	"Nuova Fattura" 
		CASE "D"
			ls_title =	"Nuova Bolla-DDT"
		CASE "P"	
			ls_title =	"Nuovo Preventivo" 
	END CHOOSE
else
	CHOOSE CASE is_tipo_documento
		CASE "O"
			ls_title =	"Ordine" 
		CASE "F"
			ls_title =	"Fattura" 
		CASE "D"
			ls_title =	"Bolla-DDT"
		CASE "P"	
			ls_title =	"Preventivo" 
	END CHOOSE

end if
If IsNull(ls_num_progressivo) then ls_num_progressivo=""
if not IsNull(ll_id_registro) then 
	SELECT "registro"."tipo_registro"  
		INTO :ls_tipo_registro  
		FROM "registro"  
		WHERE "registro"."id_registro" = :ll_id_registro  ;
	ls_title= ls_title + " " + ls_tipo_registro
end if
If not (IsNull(ls_num_progressivo) OR ls_num_progressivo= "") then ls_title= ls_title + " - Nr. " + ls_num_progressivo
If not (IsNull(ls_data_registrazione) OR ls_data_registrazione= "") then ls_title= ls_title + " del " + ls_data_registrazione
CHOOSE CASE idw_gen.uf_get_colval("tipo_fattura")
	CASE "C"
		ls_title= "Nota di Accredito - " + ls_title
	CASE "D"
		ls_title= "Nota di Addebito - " + ls_title
END CHOOSE

this.title = ls_title

RETURN 0
end function

public function long uf_conto_x_spesa (long al_id_spesa);
boolean 		lb_ret_value
long			ll_id_conto, ll_id_spesa

lb_ret_value=FALSE
CHOOSE CASE is_tipo_registro
	CASE "IA", "PA", "OA", "DA", "LA", "GA"
		
		SELECT "conto_azienda"."id_conto"  
			INTO :ll_id_conto  
			FROM "dba"."conto_azienda",   
				"dba"."spesa"  
			WHERE ( "spesa"."id_conto_acquisti" = "conto_azienda"."id_conto" ) and  
				( ( "spesa"."id_spesa" = :al_id_spesa ) AND  
				( "conto_azienda"."id_azienda" = 1 ) )   ;
	
	CASE "IV", "PV", "OV", "DV", "LV", "GV", "IC"
		
		SELECT "conto_azienda"."id_conto"  
			INTO :ll_id_conto  
			FROM "dba"."conto_azienda",   
				"dba"."spesa"  
			WHERE ( "spesa"."id_conto_vendite" = "conto_azienda"."id_conto" ) and  
				( ( "spesa"."id_spesa" = :al_id_spesa ) AND  
				( "conto_azienda"."id_azienda" = 1 ) )   ;

END CHOOSE
If SQLCA.SQLCode <> 0 then
	SetNull(ll_id_conto)
end if

RETURN ll_id_conto


end function

public function boolean uf_riga_valida (long al_row);RETURN FALSE
end function

public function long uf_set_currow ();
il_row= idw_gen.GetRow()
if IsNull(il_row) OR il_row = 0 then
	il_row= idw_gen.RowCount()
end if
RETURN il_row
end function

public function integer uf_default_focus ();
idw_master.SetFocus()
idw_master.SetColumn("c_prof_doc_cod")

RETURN 0
end function

public function integer uf_wizard_riga ();
integer li_retvalue

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

public function integer uf_nuovo_documento ();
integer li_retvalue

if idw_master.uf_to_update() > 0 and idw_master.rowcount()>0 then	
	
	li_retvalue=idw_master.Event ue_update(0,0)
else
	li_retvalue=0
end if

	
	tab_1.tabpage_1.dw_documento_ordine_ff.reset()
	tab_1.tabpage_1.dw_documento_ordine_ff.event ue_reset()
	idw_master.is_list.s_modo= modo_inserisci
	TriggerEvent("ue_insert_mode")
	
	il_row= idw_gen.GetRow()
	if IsNull(il_row) OR il_row =0 then
		il_row= idw_gen.RowCount()
	end if
	if not(IsNull(il_row) OR il_row =0) then il_id_documento= idw_gen.GetItemNumber(il_row, "id_documento")
	uf_default_focus()
	iuo_msg_log.uf_new_text("Nuovo Documento",1)
	tab_1.tabpage_4.dw_cast_iva_documento_lt.event ue_visibilita_campi("V")
	//20220907 aggiungo per sbloccare eventuale blocco precedente
	uf_blocco_documento()

RETURN 0
end function

public function integer uf_load_documento (long al_id_documento);
idw_master.is_list.s_modo = modo_modifica
idw_master.is_list.s_identifica[1] = "id_documento"
idw_master.is_list.l_identifica[1] = al_id_documento

long ll_id_valuta
integer li_dec_significativi

SetPointer(HourGlass!)
this.enabled= FALSE

il_id_documento = al_id_documento

idw_master.Event ue_retrieve(0, 0)


uf_set_documento()


uf_setup_documento()

uf_set_istanze()


this.enabled= TRUE
uf_default_focus()

SetPointer(Arrow!)

idc_cambio=idw_gen.getitemdecimal(1, "documento_cambio")
idc_cambio=1/idc_cambio  //20220210 temporaneo per alpa poi verifichiamo

ll_id_valuta=idw_gen.getitemnumber(1, "documento_id_valuta_des")
select dec_significativi
into   :li_dec_significativi
from	 valuta
where  id_valuta = :ll_id_valuta
;
idw_castelletto.Modify("c_cambio_text.text = '" + String(idc_cambio) + "'") 
idw_castelletto.Modify("c_arrotondamento_text.text = '" + String(li_dec_significativi) + "'")
idw_castelletto.Modify("c_tipo_arrotondamento.text = '" + is_tipo_arrotondamento + "'")


select dec_significativi
into   :li_dec_significativi
from	 valuta
where  id_valuta = :al_id_val_az
;
if sqlca.sqlcode <> 0 then 	
	messagebox("dberror", sqlca.sqlerrtext)
	iuo_msg_log.uf_new_text("Impossibile settare il cambio.",3)
else
	idw_castelletto.Modify("c_arrotondamento_text_v_conto.text = '" + String(li_dec_significativi) + "'")
	idw_spesa.Modify("c_arrotondamento_text_v_conto.text = '" + String(li_dec_significativi) + "'")
	idw_spesa.Modify("c_cambio_text.text = '" + String(idc_cambio) + "'")
	uf_set_dec_mask(il_arrotondamento, is_simbolo_valuta, ll_id_valuta) 
	iF idc_cambio = 1 then
		cbx_simbolo.checked = FALSE
		uf_set_dec_mask( il_arrotondamento, is_simbolo_valuta, ll_id_valuta) 
	end if
		
	idw_castelletto.Modify("c_arrotondamento_text.text = '" + String(li_dec_significativi) + "'")
	idw_castelletto.Modify("c_tipo_arrotondamento.text = '" + is_tipo_arrotondamento + "'")
	idw_castelletto.Modify("c_arrotondamento_text_v_conto.text = '" + String(li_dec_significativi) + "'")
	idw_spesa.Modify("c_arrotondamento_text_v_conto.text = '" + String(li_dec_significativi) + "'")
	
	
	idw_spesa.Modify("c_cambio_text.text = '" + String(idc_cambio) + "'")
	uf_set_dec_mask(il_arrotondamento, is_simbolo_valuta, ll_id_valuta) 
	
	iF idc_cambio = 1 then
		cbx_simbolo.checked = FALSE
		
		uf_set_dec_mask( il_arrotondamento, is_simbolo_valuta, ll_id_valuta) 
	end if
end if
tab_1.tabpage_4.cb_ricalcola_cast.postevent(clicked!)

RETURN 0
end function

public function integer uf_report_righe ();
long		ll_row, ll_nr_row, ll_nr_descrittive, ll_num_riga
string	ls_Stato, ls_report, ls_text

ls_report=""
ll_nr_descrittive=0
ll_nr_row= idw_riga.RowCount()
For ll_row = 1 to ll_nr_row
	ls_Stato= idw_riga.GetItemString(ll_row,"c_riga_valida")
	CHOOSE CASE ls_Stato
		CASE	"I"
			ll_nr_descrittive++
			ll_num_riga= idw_riga.GetItemNumber(ll_row,"riga_documento_num_riga")
			ls_report=ls_report + " - Nr. " + String(ll_num_riga)
		CASE "D"
			ll_nr_descrittive++
	END CHOOSE
next
If ll_nr_descrittive>0 then
	iuo_msg_log.uf_new_text("Le Righe di Documento comprendono:",3)
	iuo_msg_log.uf_new_text(String(ll_nr_descrittive) + " Righe descrittive.",4)
	If ls_report <> "" then
		iuo_msg_log.uf_new_text("Di cui le seguenti Righe sono probabilmente incomplete di IVA: " + ls_report + ".",4)
	end if
end if
RETURN 0

end function

public function integer uf_setup_documento ();
long 			ll_row, ll_id_valuta, ll_arrotondamento

decimal 		ldc_cambio, ldc_null
string		ls_null

if idw_master.is_list.s_modo <> modo_inserisci then
	idw_gen.Object.c_prof_doc_cod.Protect=1
	idw_gen.Object.c_prof_doc_des.Protect=1
	
	
end if
tab_1.tabpage_4.dw_cast_iva_documento_lt.event ue_visibilita_campi("V")
tab_1.tabpage_4.dw_scadenza_documento_lt.event ue_visibilita_campi() 
tab_1.tabpage_4.cb_applica.Visible=FALSE
f_DisplayOnly(idw_riga, "riga_documento_num_riga", TRUE)

RETURN 0


end function

public function boolean uf_is_modified ();
long ll_row

ll_row	= this.tab_1.tabpage_1.dw_documento_ordine_ff.GetRow()
	
	
if this.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemStatus( ll_row,0,Primary! ) <> NotModified! then
	return True
end if

return False
end function

public subroutine uf_contabilizza ();

long ll_id_registro, ll_CurrRow
decimal ldc_num_progressivo
date ld_data
string ls_msg

ll_CurrRow = tab_1.tabpage_1.dw_documento_ordine_ff.GetRow()

IF ll_CurrRow > 0 THEN
	SetPointer(HourGlass!)

	iuo_msg_log.uf_show_msg_log()
	iuo_msg_log.uf_new_text("Contabilizzazione in corso. Attendere...", 2)
	tab_1.tabpage_1.dw_documento_ordine_ff.AcceptText()
	ldc_num_progressivo = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(ll_CurrRow, "num_progressivo")
		ld_data = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemDate(ll_CurrRow, "data_registrazione")

	ll_id_registro = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(ll_CurrRow, "id_registro")
	IF (NOT IsNull(ldc_num_progressivo)) AND (NOT IsNull(ld_data)) THEN
		
		IF iu_contab_documento.uf_crea_reg_pd(ll_id_registro,                   &
														  ldc_num_progressivo,              &
														  ldc_num_progressivo,              &
														  ld_data,                          &
														  ld_data,                          &
														  uf_tipo_registro(ll_id_registro), &
														  ls_msg)<> 0 THEN
														  
		END IF
	END IF

	iuo_msg_log.uf_new_text(ls_msg, 2)
	
	
	if pos(ls_msg,"OK")>0 then
		messagebox("Registrazione Effettuata", ls_msg)
		
		close(this)
	end if

	SetPointer(Arrow!)
END IF
end subroutine

public function string uf_tipo_registro (long al_id_registro);

string ls_RetVal = ""

IF al_id_registro > 0 THEN
	SELECT dba.registro.tipo_registro
		INTO :ls_RetVal
		FROM dba.registro
		WHERE registro.id_registro = :al_id_registro
		USING SQLCA;
		
		CHOOSE CASE SQLCA.SQLCode
			CASE -1
				MessageBox("Errore sul DataBase", "w_documento_ordine_cx / uf_tipo_registro / 1")
		END CHOOSE

END IF

RETURN ls_RetVal
end function

public function boolean uf_fattura_contabilizzata ();//20261106 TRUE se il documento e' una fattura (registro IV o IA) gia' contabilizzata.
//Le spese e il castelletto IVA di una fattura contabilizzata NON si devono piu' modificare (wf_calcola_spese, ue_calc_cast_iva).
//Si guarda il db e non il buffer: dal pulsante blocco (w_blocco_docum_wz) il flag contabilizzato si puo' togliere a video
//e salvare, ma la registrazione resta in contabilita'. Quindi vale contabilizzato = 'S' nel db OPPURE l'esistenza della reg_pd
//con lo stesso registro, progressivo e data registrazione (e' la chiave con cui la cerca e la crea u_contab_documento).
long		ll_id_documento, ll_id_registro, ll_num_progressivo, ll_id_reg_pd
date		ld_data_registrazione
string	ls_contabilizzato

if left(is_tipo_registro, 1) <> "I" then return false   //solo fatture (IV vendite, IA acquisti)
if isnull(il_row) or il_row < 1 or il_row > idw_gen.RowCount() then return false
ll_id_documento = idw_gen.GetItemNumber(il_row, "id_documento")
if isnull(ll_id_documento) or ll_id_documento <= 0 then return false   //documento nuovo, non ancora salvato

SELECT contabilizzato, id_registro, num_progressivo, data_registrazione
	INTO :ls_contabilizzato, :ll_id_registro, :ll_num_progressivo, :ld_data_registrazione
	FROM dba.documento
	WHERE id_documento = :ll_id_documento;
CHOOSE CASE sqlca.sqlcode
	CASE 100
		return false   //non ancora nel db
	CASE -1
		//nel dubbio NON si tocca niente
		MessageBox("Errore sul DataBase", "uf_fattura_contabilizzata: " + sqlca.sqlerrtext + "~r~nSpese e castelletto NON vengono ricalcolati.", StopSign!)
		return true
END CHOOSE
if ls_contabilizzato = 'S' then return true

//flag tolto ma registrazione presente in contabilita'
if ll_id_registro > 0 and ll_num_progressivo > 0 and not isnull(ld_data_registrazione) then
	setnull(ll_id_reg_pd)
	SELECT FIRST reg_pd.id_reg_pd
		INTO :ll_id_reg_pd
		FROM dba.reg_pd
		WHERE reg_pd.id_registro = :ll_id_registro
		AND reg_pd.num_progressivo = :ll_num_progressivo
		AND reg_pd.data_registrazione = :ld_data_registrazione
		ORDER BY reg_pd.id_reg_pd;
	if sqlca.sqlcode = -1 then
		MessageBox("Errore sul DataBase", "uf_fattura_contabilizzata (reg_pd): " + sqlca.sqlerrtext + "~r~nSpese e castelletto NON vengono ricalcolati.", StopSign!)
		return true
	end if
	if ll_id_reg_pd > 0 then return true
end if

return false
end function

public subroutine uf_abilita_contabilizza ();

long ll_CurrRow, ll_id_prof_documento
char lc_contabilizzabile

ll_CurrRow = tab_1.tabpage_1.dw_documento_ordine_ff.GetRow()

IF ll_CurrRow > 0 THEN
	ll_id_prof_documento = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(ll_CurrRow, "id_prof_documento")
	SELECT prof_documento.contabilizzabile
		INTO :lc_contabilizzabile
		FROM prof_documento
		WHERE prof_documento.id_prof_documento = :ll_id_prof_documento
		USING SQLCA;
	
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			CHOOSE CASE lc_contabilizzabile
				CASE "S"
					cb_contabilizza.Visible = TRUE
				CASE "N"
					cb_contabilizza.Visible = FALSE
			END CHOOSE
			
		CASE 100
			cb_contabilizza.Visible = FALSE
			
		CASE -1
			MessageBox("Errore sul DataBase", "w_documento_ordine_cx / uf_abilita_contabilizza / 1")
	END CHOOSE

END IF
end subroutine

public function integer uf_set_tipo_doc ();
long		ll_id_registro
if il_row<1 then return -1

u_setta_campi_documento uo_setta_campi_doc
uo_setta_campi_doc=create u_setta_campi_documento
is_tipo_documento=uo_setta_campi_doc.uf_set_tipo_doc(is_tipo_documento, is_tipo_registro, idw_gen, il_row)
destroy uo_setta_campi_doc
RETURN 0



end function

public function integer uf_scaglione_provvigione ();
return 0
end function

public function boolean uf_test_data_registrazione (date ad_data);
date		ld_data_inizio, ld_data_fine
boolean	lb_Valida

lb_Valida= TRUE
SELECT "esercizio"."data_inizio",   
			"esercizio"."data_fine"  
	INTO 	:ld_data_inizio,   
			:ld_data_fine
	FROM 	"dba"."esercizio"  
	WHERE "esercizio"."id_esercizio" = :il_id_esercizio ;
If ld_data_inizio > ad_data then  lb_Valida= FALSE
If ld_data_fine < ad_data then  lb_Valida= FALSE

RETURN lb_Valida

end function

public function integer wf_controlla_qta_mov (long al_id_unita_conf, string as_dato);

decimal ld_qta_min, ld_qta_max
select qta_minima, qta_massima
		into :ld_qta_min, :ld_qta_max
		from unita_confezione
		where id_unita_confezione=:al_id_unita_conf;
		if sqlca.sqlcode=0 then
			if not isnull(ld_qta_min) then 
				if not isnull(ld_qta_max) and  ld_qta_max > 0 then 
					if dec(as_dato)<ld_qta_min or dec(as_dato)> ld_qta_max then
						messagebox("Attenzione!", "Si sta movimentando una quantità non consentita.~r~n"&
									+"Modificare la quantità o reimpostare i limiti per ~r~n"&
									+ "l'unità confezione in esame.")
									
						return 0
					end if
				end if
			end if
		end if
	return 1	
		
end function

public subroutine wf_cal_costi ();

decimal 	ld_costo_medio
long 	  	ll_id_articolo, ll_id_magazzino
long 	  	ll_id_locazione, ll_id_valuta
integer	li_row
string	ls_c_ult_costo_data, ls_c_cmc_data
decimal	ld_cmc, ld_costo_ultimo
string	ls_data_costo_ultimo, ls_data_cmc 

if (ib_cal_giac_costi = 'N' or isnull(ib_cal_giac_costi)) then
	return
end if


li_row = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()

if li_row > 0 then
	ll_id_articolo=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemnumber(li_row, "riga_documento_id_articolo")
	ll_id_locazione = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(li_row,"id_locazione_1")
	ll_id_valuta=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"documento_id_valuta_cod") 

	if isnull(ll_id_articolo) or isnull(ll_id_locazione) or isnull(ll_id_valuta) then &
		return
	
	SELECT id_magazzino
	INTO	 :ll_id_magazzino
	FROM	 locazione
	WHERE  id_locazione = :ll_id_locazione
	;
	
	
	SELECT CAST(FN_ULTIMO_COSTO_DATA(1, :ll_id_articolo, :ll_id_magazzino, YEAR(TODAY(*)), MONTH(TODAY(*)) , :ll_id_valuta)  AS CHAR(32) ) AS c_ult_costo_data,
			 CAST(FN_CMC_DATA(1, :ll_id_articolo, :ll_id_magazzino, :ll_id_valuta)  AS CHAR(32) ) AS c_cmc_data,
			 CAST(FN_COSTO_MEDIO(1, :ll_id_articolo, :ll_id_magazzino, YEAR(TODAY(*)), MONTH(TODAY(*)), :ll_id_valuta)  AS DECIMAL(20,6) ) AS costo_medio,
			 CAST(SUBSTR(c_cmc_data, 1, 22) as numeric(20,6)) as cmc,
			 CAST(SUBSTR(c_ult_costo_data, 1, 22) as numeric(20,6)) as costo_ultimo,
			 CAST(SUBSTR(c_ult_costo_data, 23, 10) as CHAR(10)) as data_costo_ultimo,
			 CAST(SUBSTR(c_cmc_data, 23, 10) as CHAR(10)) as data_cmc
	INTO   :ls_c_ult_costo_data, :ls_c_cmc_data, :ld_costo_medio,
			 :ld_cmc, :ld_costo_ultimo, :ls_data_costo_ultimo, :ls_data_cmc
	FROM 	 SYS.DUMMY
	;
	
	if (sqlca.sqlcode = -1) then
		messagebox("DBError", sqlca.sqlerrtext)
	end if
	

	decimal ld_null
	setnull(ld_null)
	
	string ls_null
	setnull(ls_null)
	
	
	if (ld_cmc > 0) then
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "cmc", ld_cmc)
	else
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "cmc", ld_null)
	end if
	
	if (not isnull(ls_data_cmc)) then
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "data_cmc", ls_data_cmc)
	else
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "data_cmc", ls_null)
	end if	

	
	if (ld_costo_ultimo > 0) then
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "ccosto_ultimo", ld_costo_ultimo)
	else
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "ccosto_ultimo", ld_null)
	end if
	
	if (not isnull(ls_data_costo_ultimo)) then
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "data_costo_ultimo", ls_data_costo_ultimo)
	else
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "data_costo_ultimo", ls_null)
	end if	

	
	if (ld_costo_medio > 0) then
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "ccosto_medio", ld_costo_medio)
	else
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(li_row, "ccosto_medio", ld_null)
	end if
end if


end subroutine

public subroutine wf_impongo_magazzino (integer ai_riga_inizio, integer ai_riga_fine);
long ll_verifica,ll_riga_corrente, ll_ges_locazioni, ll_id_loc, ll_id_caus_mag
long ll_id_mag, ll_ret, ll_id_articolo, ll_id_magazzino, ll_id_azienda, ll_id_attivita
long ll_id_loc_pred
integer i, ll_num_righe
string  ls_mag_par, ls_mag_des, ls_mp_val_caricato, ls_md_val_caricato

decimal ld_mese, ld_anno, ld_cmc, ld_esistenza, ld_prezzo, ld_val_tot_riga, ld_qta


ll_num_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()

for i = ai_riga_inizio to ai_riga_fine
	ll_riga_corrente=i
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.scrolltorow(i)
	ll_id_caus_mag=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber&
						(ll_riga_corrente, "riga_documento_id_caus_magazzino")
	ll_id_azienda=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
	(1, "documento_id_azienda")
	select mag_par_richiesto, mag_des_richiesto
	into :ls_mag_par, :ls_mag_des
	from caus_magazzino
	where id_caus_magazzino= :ll_id_caus_mag;
if is_ges_locazioni="N" or isnull(is_ges_locazioni) then
	
	
	
	
	
	
	
else
	
	if sqlca.sqlcode=0 then
		
		if ls_mag_par='S' then
			ll_verifica=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber &
			(ll_riga_corrente, "id_locazione_1")
			
			if ll_verifica<1 or isnull(ll_verifica) then
				ll_id_mag=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
				(1, "documento_id_magazzino")

				ll_id_articolo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber &
										(ll_riga_corrente,"riga_documento_id_articolo" )
				SELECT "loc_predefinita"."id_locazione"
				INTO :ll_id_loc_pred
				FROM "loc_predefinita"
				WHERE "loc_predefinita"."id_articolo" = :ll_id_articolo and
						"loc_predefinita"."id_locazione" 
						IN ( 	SELECT "locazione"."id_locazione"
						 		FROM "locazione"
								WHERE "locazione"."id_magazzino" = :ll_id_mag );
					tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
				(ll_riga_corrente, "id_locazione_1", ll_id_loc_pred)
			end if
		end if
		
		if ls_mag_des='S' then
			ll_verifica=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber &
			(ll_riga_corrente, "id_locazione_2")
			if ll_verifica<1 or isnull(ll_verifica) then
				ll_id_articolo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber &
										(ll_riga_corrente,"riga_documento_id_articolo" )
										
				SELECT "loc_predefinita"."id_locazione"
				INTO :ll_id_loc_pred
				FROM "loc_predefinita"
				WHERE "loc_predefinita"."id_articolo" = :ll_id_articolo and
						"loc_predefinita"."id_locazione" 
						IN ( 	SELECT "locazione"."id_locazione"
						 		FROM "locazione"
								WHERE "locazione"."id_magazzino" = :ll_id_mag );
								
				tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
				(ll_riga_corrente, "id_locazione_2", ll_id_loc_pred)
			end if
		end if
	end if
	
end if

next



end subroutine

public subroutine wf_cal_cmc ();
end subroutine

public function integer wf_setta_cambio (integer tipo_settaggio, string valore);
		
		long ll_my_id
		long row
		decimal 	ld_cambio_acconto
		decimal 	ld_cambio_documento
		decimal 	ld_fattore_cambio
		long		ll_id_valuta
		decimal 	ld_appoggio, LD_AVANZO_acconto
		boolean 	lb_modifica_importo
			
		row = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()	
			
		choose case tipo_settaggio
			case 1
				ll_my_id = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemnumber(row, "id_val_acconto")
				ld_appoggio = dec(valore)
			case 2 
				ld_appoggio = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemdecimal(row, "imp_acconto")
				ll_my_id = long(valore)	
			case 3 
				ll_my_id = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemnumber(row, "id_val_acconto")
				ld_appoggio = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemdecimal(row, "imp_acconto")
			case 4 
				ll_my_id = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemnumber(row, "id_val_acconto")
				ld_appoggio = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemdecimal(row, "imp_acconto")
		end choose
		

	
	ld_appoggio=ld_appoggio*idc_cambio
	//ld_appoggio=ld_appoggio/idc_cambio  20220210 da verificare era commentato quello sopra... per alpa
	LD_AVANZO_acconto=tab_1.tabpage_1.dw_documento_ordine_ff.getitemdecimal(1,"imp_avanzo_acconto")
	if LD_AVANZO_acconto<> 0 then
		ld_appoggio -=LD_AVANZO_acconto
	end if
	tab_1.tabpage_1.dw_documento_ordine_ff.setItem (row,"c_imp_acconto_convertito", ld_appoggio)

return 0
end function

public subroutine wf_chiusura_righe ();
end subroutine

public subroutine wf_inserisci_pesi_riga (decimal quantita);


long 		ll_id_u_conf, ll_row
decimal{4} ld_peso_netto, ld_peso_lordo, ld_quantita, ld_dim_l, ld_dim_h, ld_dim_p
decimal{4} ld_controlla_misura


		ll_row=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
		
		ll_id_u_conf=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_row, "riga_documento_id_unita_confezione")
		
		SELECT 	"unita_confezione"."peso_netto", "unita_confezione"."peso_lordo",	
					"unita_confezione"."dim_l", 
					"unita_confezione"."dim_h", 
					"unita_confezione"."dim_p"
		into :ld_peso_netto, :ld_peso_lordo, :ld_dim_l, :ld_dim_h, :ld_dim_p
		from "unita_confezione"
		where "unita_confezione"."id_unita_confezione" = :ll_id_u_conf;
		
		if isnull(ld_dim_l) then ld_dim_l=0
	
		if quantita = 0 then		
			ld_quantita = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_row, "quantita" )
			if isnull(ld_quantita) then ld_quantita = 0
		else 
			ld_quantita = quantita
		end if
		if not (tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(ll_row, "riga_documento_peso_netto")>0) then
			
			if not(isnull(ld_peso_netto) or ld_peso_netto=0) then
				
				ld_peso_netto = ld_peso_netto * ld_quantita 
				if (ld_peso_netto > 0) and (ll_id_u_conf > 0) then
					ld_peso_netto = uf_converti_peso(ll_id_u_conf, ld_peso_netto)
				end if
				tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row, "riga_documento_peso_netto", ld_peso_netto)
			end if
			
			if not(isnull(ld_peso_lordo) or ld_peso_lordo=0) then
				
				ld_peso_lordo = ld_peso_lordo * ld_quantita 
				if (ld_peso_lordo > 0 and not isnull(ld_peso_lordo)) and (ll_id_u_conf > 0 and not isnull(ll_id_u_conf)) then
					ld_peso_lordo = uf_converti_peso(ll_id_u_conf, ld_peso_lordo)
				end if
				tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row, "riga_documento_peso_netto", ld_peso_lordo)
			end if
		end if
		
		
		ld_controlla_misura=idw_riga.getitemdecimal(ll_row, "riga_documento_dim_l")
		
		if ld_controlla_misura=0 then
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row, "riga_documento_dim_l", ld_dim_l )
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row, "riga_documento_dim_h", ld_dim_h )
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row, "riga_documento_dim_p", ld_dim_p )
		end if
		
end subroutine

public subroutine wf_aggiorna_riepiloghi ();
long 		ll_c_row, ll_row, ll_n_row
long 		ll_id_esercizio, ll_my_id, ll_id_attivita, ll_id_locazione, ll_id_articolo
long		ll_id_unita_confezione, ll_id_caus_magazzino
decimal	ld_ult_costo
integer	li_anno,li_mese
date		ldt_data
string	ls_unita_base, ls_mp_ult_costo, ls_md_ult_costo


ll_n_row = tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
if ll_n_row > 0 then
	for ll_row = 1 to ll_n_row
		
			ll_c_row = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
		
			ll_id_esercizio = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_c_row,"c_esercizio")
		
			ll_my_id = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_c_row,"documento_id_azienda")
			select "azienda"."id_attivita"
			into :ll_id_attivita
			from "azienda"
			where "azienda"."id_azienda" = :ll_my_id;
		
			ll_id_locazione = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_row,"id_locazione_1")
		
			ll_id_articolo  = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_row,"riga_documento_id_articolo")
		
			ldt_data = tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(ll_c_row,"data_registrazione")
			li_mese = month(ldt_data)
			li_anno = year(ldt_data)

		
		ll_id_unita_confezione = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_row,"riga_documento_id_unita_confezione")
		
		ll_id_caus_magazzino   = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_row,"riga_documento_id_caus_magazzino")
		
		SELECT "unita_confezione"."unita_base"
		INTO :ls_unita_base
		FROM "unita_confezione"
		WHERE "unita_confezione"."id_unita_confezione" = :ll_id_unita_confezione;
		
		SELECT "caus_magazzino"."mp_ult_costo", 
		 "caus_magazzino"."md_ult_costo" 
		INTO :ls_mp_ult_costo, :ls_md_ult_costo
		FROM "caus_magazzino"
		WHERE "caus_magazzino"."id_caus_magazzino" = :ll_id_caus_magazzino;

		
		
		
		
		
		
		
		
		
		
		
			
			
		
		
	
	if ls_unita_base = 'S' And &
		(ls_mp_ult_costo = 'S' or ls_md_ult_costo = 'S') then

			
			ldt_data = tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(ll_c_row,"data_registrazione")
			ld_ult_costo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_row,"prezzo")

			UPDATE "riepilogo"
				set "riepilogo"."ult_costo" 		= 	:ld_ult_costo,
				    "riepilogo"."data_ult_costo" =  :ldt_data
			WHERE  	"riepilogo"."id_esercizio" 	= 	:ll_id_esercizio 	and &
						"riepilogo"."id_attivita"  	= 	:ll_id_attivita  	and &
						"riepilogo"."id_articolo"  	= 	:ll_id_articolo  	and &
						"riepilogo"."id_locazione" 	= 	:ll_id_locazione 	and &
						"riepilogo"."anno"				=	:li_anno				and &
						"riepilogo"."mese"				=	:li_mese;
			end if
	next
end if
end subroutine

public subroutine wf_new_cal_cmc ();

end subroutine

public subroutine wf_cal_pesi_colli (boolean active_message);//
//integer li_ret
//long ll_riga_corrente, ll_id_unita_mis_peso, ll_row, ll_id_unita_mis_volume
//decimal	ld_conversione_peso, ld_conversione_volume
//decimal{4} ld_netto_tot, ld_lordo_tot, ld_colli_tot, ld_volume, ld_netto, ld_lordo, ld_colli, ld_volume_tot
//	
//	ll_riga_corrente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
//
//if ll_riga_corrente > 0 then
//	ll_row=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getrow()
//	if ll_row>0 then
//		
//		if isnull(	tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber (ll_row, "id_unita_misura_peso_cod")) Then
//				SELECT 	"par_sistema"."id_unita_mis_peso"
//					INTO 	:ll_id_unita_mis_peso
//				FROM 		"par_sistema";
//				tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem (ll_row,"id_unita_misura_peso_cod", ll_id_unita_mis_peso)
//		end if
//		
//		ll_id_unita_mis_peso = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber (ll_row, "id_unita_misura_peso_cod")
//		SELECT 	"unita_misura"."conversione"
//			INTO	:ld_conversione_peso
//			FROM 	"unita_misura"
//		WHERE 	"unita_misura"."id_unita_misura" = :ll_id_unita_mis_peso;
//		
//		if isnull(	tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber (ll_row, "id_unita_misura_volume_cod")) Then
//				SELECT "par_sistema"."id_unita_mis_volume"
//					INTO :ll_id_unita_mis_volume
//				FROM "par_sistema";
//				tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem (ll_row,"id_unita_misura_volume_cod", ll_id_unita_mis_volume)
//		end if
//		
//		ll_id_unita_mis_volume = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber (ll_row, "id_unita_misura_volume_cod")
//		SELECT 	"unita_misura"."conversione"
//			INTO	:ld_conversione_volume
//			FROM 	"unita_misura"
//		WHERE 	"unita_misura"."id_unita_misura" = :ll_id_unita_mis_volume;
//		
//				
//		if isnull( ld_conversione_peso ) or ld_conversione_peso = 0 then ld_conversione_peso = 1
//		if isnull( ld_conversione_volume ) or ld_conversione_volume = 0 then ld_conversione_volume = 1
//		
//		ld_netto_tot=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
//		(ll_riga_corrente, "somma_peso_netto") / ld_conversione_peso
//	
//		ld_lordo_tot=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
//		(ll_riga_corrente, "somma_peso_lordo") / ld_conversione_peso
//	
//		ld_colli_tot=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
//		(ll_riga_corrente, "somma_num_colli")
//		
//		ld_volume_tot=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
//		(ll_riga_corrente, "c_volume_totale") / ( ld_conversione_volume^3 )
//	
//		ll_riga_corrente=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getrow()
//		
//		
//		ld_netto=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemdecimal&
//					(ll_riga_corrente, "peso_netto")
//		if isnull(ld_netto) or ld_netto=0 then
//			tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem&
//			(ll_riga_corrente, "peso_netto", ld_netto_tot)
//		end if
//		
//		ld_lordo=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemdecimal&
//					(ll_riga_corrente, "peso_lordo")
//		if isnull(ld_lordo) or ld_lordo=0 then
//			tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem&
//			(ll_riga_corrente, "peso_lordo", ld_lordo_tot)
//		end if
//		
//		ld_colli=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemdecimal&
//					(ll_riga_corrente, "num_colli")
//		if isnull(ld_colli) or ld_colli=0 then
//			tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem&
//					(ll_riga_corrente, "num_colli", ld_colli_tot)
//		end if
//		
//		ld_volume=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemdecimal&
//					(ll_riga_corrente, "volume")
//		if isnull(ld_volume) or ld_volume=0 then
//			tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem&
//					(ll_riga_corrente, "volume", ld_volume_tot)
//		end if
//		
//		if ld_netto<>ld_netto_tot or ld_lordo <> ld_lordo_tot or ld_colli <> ld_colli_tot or ld_volume <> ld_volume_tot then
//			if active_message = true then
//				li_ret=Messagebox("Attenzione!", "La somma dei pesi o dei colli delle righe non~r~n"&
//						+"coincide con quella indicata nella pagina Trasporto.~r~n"&
//						+"Vuoi aggiornare i valori allineandoli a quelli delle righe?",&
//						stopsign!, yesno!)
//				else
//					li_ret = 1
//				end if
//			if li_ret = 1 then
//				tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem&
//					(ll_riga_corrente, "peso_netto", ld_netto_tot)
//				tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem&
//					(ll_riga_corrente, "peso_lordo", ld_lordo_tot)
//				tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem&
//					(ll_riga_corrente, "num_colli", ld_colli_tot)
//				tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem&
//					(ll_riga_corrente, "volume", ld_volume_tot)
//			end if
//		end if
//	end if
//END IF
//	
end subroutine

public subroutine wf_inf_aggiuntive (long id_unita_confezione, long riga, integer id_articolo);if riga>0 then
	decimal{4} ld_conversione
	string ls_simbolo,ls_descrizione,ls_stato, ls_tipo
	
	select unita_misura.simbolo,unita_misura.descrizione,unita_misura.conversione
	into :ls_simbolo,:ls_descrizione,:ld_conversione
	from unita_misura,unita_confezione
	where unita_confezione.id_unita_confezione=:id_unita_confezione
	and unita_confezione.id_unita_mis_peso=unita_misura.id_unita_misura;
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(riga,"usimbolo",ls_simbolo)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(riga,"udescrizione",ls_descrizione)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(riga,"conversione_peso_comune",ld_conversione)
	
	select unita_misura.simbolo,unita_misura.descrizione,unita_misura.conversione
	into :ls_simbolo,:ls_descrizione,:ld_conversione
	from unita_misura,unita_confezione
	where unita_confezione.id_unita_confezione=:id_unita_confezione
	and unita_confezione.id_unita_mis_volume=unita_misura.id_unita_misura;
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(riga,"unita_misura_b_simbolo",ls_simbolo)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(riga,"unita_misura_b_descrizione",ls_descrizione)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(riga,"conversione_volume_comune",ld_conversione)
	
	select unita_misura.simbolo,unita_misura.descrizione,unita_misura.conversione, unita_misura.tipo
	into :ls_simbolo,:ls_descrizione,:ld_conversione, :ls_tipo
	from unita_misura,unita_confezione
	where unita_confezione.id_unita_confezione=:id_unita_confezione
	and unita_confezione.id_unita_misura=unita_misura.id_unita_misura;
	if pos(upper(u_freddie.istr_database.name), 'ORAFO')>0 then 
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(riga,"simbolo_mov",ls_simbolo)
	end if
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(riga,"tipo_um",ls_tipo)
	
	
	select stato 
	into :ls_stato
	from articolo
	where id_articolo=:id_articolo;
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(riga,"articolo_stato",ls_stato)
	
end if
end subroutine

public subroutine wf_qta (integer righe_old, integer righe_new);long i,row,ll_row,ll_id_unita_conf,ll_doc,ll_riga_padre
dwobject ldwo_pippo
decimal ld_qta,ld_qta_max,ldc_null
string ls_message
dwitemstatus ldw_status
ll_doc=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_documento")

ll_riga_padre=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(righe_old ,"id_riga_documento")
for i=righe_old+1 to righe_new
	row=i
	ll_row=i
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setrow(i)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.event trigger ue_initial()
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i,"id_documento",ll_doc)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i,"id_riga_doc_padre",ll_riga_padre)
	ld_qta=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(i,"quantita")
	
	ld_qta_max=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row, "qta_sconto_merce")
	
	
	if ld_qta_max>ld_qta then
	
		ls_message="La quantità inserita è inferiore o uguale~r~nalla quantità sconto merce!.~r~nInserire una quantità maggiore!"
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_post_itemchanged(row,"quantita", ls_message)
	end if
	
	ll_id_unita_conf=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(row, "riga_documento_id_unita_confezione")
	ll_id_unita_conf=wf_controlla_qta_mov(ll_id_unita_conf, string(ld_qta))
	if ll_id_unita_conf=0 then
		ls_message=""
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_post_itemchanged(row, "quantita", ls_message)
		return
	end if
	
	
	if isvalid(ids_scar_lotto) then
		long ll_id_art
		ll_id_art=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(row, "riga_documento_id_articolo")
		wf_scarico_lotti(ll_id_art, ld_qta,ll_row)
	end if
	
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_set_calc_tot_riga(ll_row, ld_qta, ldc_null, FALSE)
		ldw_status = tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemStatus( row,0,Primary! )
		if ldw_status = New! or ldw_status = NewModified! then
			post uf_scaglione_provvigione() 
		end if	
		
		long		ll_id_prof_documento
		string	ls_calc_prz

		ll_id_prof_documento = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_prof_documento")

		select calc_prz_esp_dist
		into   :ls_calc_prz
		from   prof_documento
		where  id_prof_documento = :ll_id_prof_documento
		;

		if isnull(ls_calc_prz) or ls_calc_prz = 'N' then 
		

			
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event ue_rec_prezzo(row, ld_qta)
			
			
		end if
		
		wf_inserisci_pesi_riga (ld_qta)
next

end subroutine

public function string wf_gestisci_lotti (long al_id_causale, integer ai_flag);
string ls_ges_lotti
long ll_id_doc
select gestisce_lotti
into :ls_ges_lotti
from caus_magazzino
where id_caus_magazzino=:al_id_causale;
if ai_flag=1 then 
	if sqlca.sqlcode=0 then
		if (ls_ges_lotti='C') or (ls_ges_lotti='S') or (ls_ges_lotti='A') or (ls_ges_lotti='R') then
			ll_id_doc=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_documento")
			if (ls_ges_lotti='R') then
				tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_riga_documento_ordine_ritorno_gd"
				tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.dataobject="d_riga_documento_dett_ord_ritorno_ff"
			else
				tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_riga_documento_ordine_lotti_gd"
				tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.dataobject="d_riga_documento_dett_ord_lotti_ff"
			end if
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.settransobject(sqlca)
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.event trigger ue_retrieve(0,0)
			ids_riga_doc_lotto=create datastore
			if  (ls_ges_lotti='R') then
				ids_riga_doc_lotto.dataobject="ds_riga_doc_ritorno_gd"
				ids_riga_doc_lotto.settransobject(sqlca)
				ids_riga_doc_lotto.retrieve()
			else
				ids_riga_doc_lotto.dataobject="ds_riga_doc_lotto_gd"
				ids_riga_doc_lotto.settransobject(sqlca)
				ids_riga_doc_lotto.retrieve(ll_id_doc)
			end if
		end if
		if (ls_ges_lotti='C')  then
			ids_lotti=create datastore
			ids_lotti.dataobject="d_lotto_ds"
			ids_lotti.settransobject(sqlca)
			ids_lotti.retrieve(ll_id_doc)
		elseif (ls_ges_lotti='S') or (ls_ges_lotti='A') or (ls_ges_lotti='R')then
			ids_scar_lotto=create datastore
			if ls_ges_lotti='S' then
				ids_scar_lotto.dataobject="ds_cerca_lotti"
			else
				ids_scar_lotto.dataobject="d_cerca_lotti_andata_ster_gd"
			end if
			ids_scar_lotto.settransobject(sqlca)
			ids_scar_lotto.Retrieve()	
		end if
	end if
end if
return ls_ges_lotti


end function

public function integer wf_salva_lotti (string as_car_scar);long ll_ret, ll_id_doc, ll_numero, ll_trovato, i, ll_id_lotto, ll_trovato2, ll_id_art
integer li_ret=1
string ls_tipo, ls_ster1, ls_ster2, ls_des


ll_id_doc=idw_gen.getitemnumber(1, "id_documento")
if as_car_scar='C' then
	li_ret=ids_lotti.Update()
	if li_ret <>1 then messagebox("Errore", "Salvataggio lotto non effettuato")
	
	for i=1 to ids_lotti.RowCount()
		ll_numero=ids_lotti.GetItemNumber(i,"numero")
		ll_trovato=ids_riga_doc_lotto.find("id_riga_lotto="+string(ll_numero), 1, ids_riga_doc_lotto.rowcount())
		if not ll_trovato>0 then
			ll_ret=ids_riga_doc_lotto.InsertRow(0)
			ids_riga_doc_lotto.SetItem(ll_ret,"id_riga_lotto",ll_numero)
			ids_riga_doc_lotto.SetItem(ll_ret,"id_lotto",ids_lotti.GetItemNumber(i,"id_lotto"))
			ids_riga_doc_lotto.SetItem(ll_ret,"id_doc",ll_id_doc)
			ids_riga_doc_lotto.SetItem(ll_ret,"valore_scarico",0)
		end if
	next
	li_ret=ids_riga_doc_lotto.Update()
	if li_ret <>1 then messagebox("Errore", "Salvataggio collegamento lotto-riga_documento non effettuato")

elseif (as_car_scar='S') or (as_car_scar='A')then
	li_ret=ids_scar_lotto.Update()
	if li_ret <>1 then messagebox("Errore", "Salvataggio scarico lotto non effettuato")
	
		li_ret=ids_riga_doc_lotto.Update()
		if li_ret <>1 then messagebox("Errore", "Salvataggio collegamento lotto-riga_documento non effettuato")
	
elseif (as_car_scar='R') then
	
	for i= 1 to idw_riga.rowcount()
		ls_ster1=idw_riga.getitemstring(i, "lotto_ster_1")
		ls_ster2=idw_riga.getitemstring(i, "lotto_ster_2")
		ll_numero=idw_riga.getitemnumber(i, "id_riga_lotto")
		ll_trovato=ids_riga_doc_lotto.find("id_riga_lotto="+string(ll_numero), 1, ids_riga_doc_lotto.rowcount())
		if ll_trovato<1 then 
			ll_id_art=idw_riga.getItemNumber(i,"riga_documento_id_articolo")
			if IsNull(ll_id_art) then 
				continue
			else
				messagebox('Errore', 'Collegamento lotto-documento non trovato; riga n° '+string(i))
			end if
		end if
		ids_riga_doc_lotto.setitem(ll_trovato, "valore_scarico", 0)
		ll_id_lotto=ids_riga_doc_lotto.getitemnumber(ll_trovato, "id_lotto")
		ll_trovato2=ids_scar_lotto.find("id_lotto="+string(ll_id_lotto), 1, ids_scar_lotto.rowcount())
		if ll_trovato2>0 then
			ls_tipo=ids_scar_lotto.getitemstring(ll_trovato2, "tipo_lotto")
			if ls_tipo='X' then ls_tipo='Z'
			if ls_tipo='Y' then ls_tipo='K'
			ids_scar_lotto.setitem(ll_trovato2, "tipo_lotto", ls_tipo)
			ids_scar_lotto.setitem(ll_trovato2,"qta_scaricata", 0)
			if not isnull(ls_ster1) and ls_ster1>'' then ids_scar_lotto.setitem(ll_trovato2,"ster_1", ls_ster1)
			if not isnull(ls_ster2) and ls_ster2>'' then ids_scar_lotto.setitem(ll_trovato2,"ster_2", ls_ster2)
		else
			
		end if
	next
	li_ret=ids_scar_lotto.Update()
	if li_ret <>1 then messagebox("Errore", "Salvataggio scarico lotto non effettuato")
	
	li_ret=ids_riga_doc_lotto.Update()
	if li_ret <>1 then messagebox("Errore", "Salvataggio collegamento lotto-riga_documento non effettuato")
end if


return li_ret
end function

public subroutine wf_risetta_qta_originale (long al_row, string as_colonna, decimal ad_qta, datawindow adw);adw.setitem(al_row, as_colonna, ad_qta)
end subroutine

public subroutine wf_tipo_prezzi ();
string lc_cal_p

select calcolo_prezzi
into :lc_cal_p
from par_sistema;
choose case lc_cal_p
	case 'SPN'
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("quantita.protect=1")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("quantita.background.color=12632256")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("quantita.color=12632256")
	case 'SPZ'
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.protect=1")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.background.color=12632256")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.color=12632256")
	case 'EPC'
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("quantita.protect=~'0~tif(tipo_um=~~'P~~',1,0)~'")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("quantita.background.color='16777215~tif(tipo_um=~~'P~~',12632256,16777215)'")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("quantita.color='0~tif(tipo_um=~~'P~~',12632256,0)'")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.protect=~'0~tif((tipo_um<>~~'P~~')or(isnull(tipo_um)),1,0)~'")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.background.color='16777215~tif((tipo_um<>~~'P~~')or(isnull(tipo_um)),12632256,16777215)'")
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.color='0~tif((tipo_um<>~~'P~~')or(isnull(tipo_um)),12632256,0)'")
end choose

end subroutine

public function long wf_trova_causale (datawindow adw_gen, string as_flag);LONG LL_ID_CAUSALE
LL_ID_CAUSALE=Adw_gen.getitemnumber (1, "documento_id_caus_magazzino")
IF AS_FLAG= "LOTTI" then
	post wf_gestisci_lotti(LL_ID_CAUSALE, 1)
end if
RETURN (LL_ID_CAUSALE)
end function

public function decimal wf_trova_prezzo (long aid_unita_conf, decimal ad_qta, decimal ad_peso, decimal ad_prezzo);string ls_um, ls_tipo
decimal ld_prezzo

select simbolo, tipo
into :ls_um, :ls_tipo
from unita_confezione, unita_misura
where (unita_confezione.id_unita_confezione=:aid_unita_conf) and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
choose case ls_tipo
	case "P"
		ld_prezzo=ad_peso*ad_prezzo
	case else 
		ld_prezzo=ad_qta*ad_prezzo
end choose
return ld_prezzo
end function

public subroutine wf_setta_evasione_anticipi (ref datastore ads_anticipi);integer i
long  ll_riga_trovata

ll_riga_trovata=ads_anticipi.find("valore=0", 1, ads_anticipi.rowcount())
do while ll_riga_trovata>0 
	ads_anticipi.deleterow(ll_riga_trovata)
	if ll_riga_trovata=ads_anticipi.rowcount() then
		exit
	else
		ll_riga_trovata=ads_anticipi.find("valore=0",ll_riga_trovata+ 1, ads_anticipi.rowcount())
	end if
loop
i=ids_anticipi.update()
if i<>1 then messagebox("Errore", "Anticipi non salvati")

end subroutine

public subroutine wf_proteggi_acconto ();long ll_id_doc, LL_TEST
ll_id_doc=idw_gen.getitemnumber(1, "id_documento")
if not isnull(ll_id_doc) then
	select id_anticipo
	into :LL_TEST
	from anticipi
	where id_anticipo=:ll_id_doc;
	if LL_TEST>0 then
		idw_gen.modify("imp_acconto.protect=1")
		idw_gen.modify("imp_acconto.background.color=12632256")
	end if
end if

end subroutine

public function boolean uf_sog_esente_iva (long id_soggetto);decimal{2}ld_per_aliquota
boolean lb_esente
select per_aliquota
into :ld_per_aliquota
from sog_commerciale,tab_iva
where sog_commerciale.id_sog_commerciale=:id_soggetto
and sog_commerciale.id_tab_iva=tab_iva.id_tab_iva;
if sqlca.sqlcode=0 then
	if ld_per_aliquota=0 then 
		lb_esente=true
	else
		lb_esente=false
	end if
else
	lb_esente=false
end if
return lb_esente
end function

public function string wf_decode_key (integer posizione, string key);

string 		ls_ritorno
long			ll_count
long			ll_lung
long			ll_pos

ll_pos = 0
ls_ritorno = ""
for ll_count = 1 to len(key)
	if mid(key,ll_count,1) = "(" then
		ll_pos = ll_pos + 1
		if ll_pos = Posizione then
			ll_lung = ll_count + 1
			do while mid(key,ll_lung,1) <> ")" 
				ls_ritorno = ls_ritorno + mid(key,ll_lung,1)
				ll_lung = ll_lung + 1 
			loop
		end if
	end if
next
if len(trim(ls_ritorno)) <= 0 then setnull(ls_ritorno)
return ls_ritorno
end function

public subroutine wf_update_riga (readonly long al_id_riga, readonly character ac_set);

UPDATE "riga_documento"
	SET "riga_documento"."forza_chius_evasione" = :ac_set
WHERE "riga_documento"."id_riga_documento" = :al_id_riga;

end subroutine

public subroutine wf_proponi_profilo (string as_tipo);long ll_proponi

choose case as_tipo
	case "P"
		il_HelpTopic = 52
		select id_prof_pref_preventivi
		into :ll_proponi
		from par_sistema;
		if ll_proponi> 0 and not isnull(ll_proponi) then
			tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1, "id_prof_documento", ll_proponi)
			tab_1.tabpage_1.dw_documento_ordine_ff.trigger event ue_set_prof_fields()
			tab_1.tabpage_1.dw_documento_ordine_ff.setcolumn("c_sog_comm_cod")
		end if
	case "D"
		il_HelpTopic = 48
		select id_prof_pref_ddt
		into :ll_proponi
		from par_sistema;
		if ll_proponi> 0 and not isnull(ll_proponi) then
			tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1, "id_prof_documento", ll_proponi)
			tab_1.tabpage_1.dw_documento_ordine_ff.trigger event ue_set_prof_fields()
			tab_1.tabpage_1.dw_documento_ordine_ff.setcolumn("c_sog_comm_cod")
		end if
	case "F"
		il_HelpTopic = 49
		select id_prof_pref_fatture
		into :ll_proponi
		from par_sistema;
		if ll_proponi> 0 and not isnull(ll_proponi) then
			tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1, "id_prof_documento", ll_proponi)
			tab_1.tabpage_1.dw_documento_ordine_ff.trigger event ue_set_prof_fields()
			tab_1.tabpage_1.dw_documento_ordine_ff.setcolumn("c_sog_comm_cod")
		end if
	case "O"
		il_HelpTopic = 51
		select id_prof_pref_ordini
		into :ll_proponi
		from par_sistema;
		if ll_proponi> 0 and not isnull(ll_proponi) then
			tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1, "id_prof_documento", ll_proponi)
			tab_1.tabpage_1.dw_documento_ordine_ff.trigger event ue_set_prof_fields()
			tab_1.tabpage_1.dw_documento_ordine_ff.setcolumn("c_sog_comm_cod")
		end if
end choose	
end subroutine

public function long wf_cancella_lotti (long ll_row);//long	ll_retval,ll_id_lotto, ll_id_r_lotto, ll_lotto_trovato, ll_lotto_trovato2, err=1
//integer li_ret
//decimal ld_val_scar, ldt_qta_scar_attuale, ld_qta_iniz
//string ls_tipo
//decimal ld_peso_netto_scaricato 
//long    ll_id_unita_confezione
//char    lc_tipo_ges_lotti
//string  ls_tipo_mov
//
//SELECT tipo_ges_lotti
//INTO	 :lc_tipo_ges_lotti
//FROM	 pers_par_sistema
//;
//
//
//	if (isvalid(ids_scar_lotto)) then
//		ll_id_r_lotto=tab_1.tabpage_2.dw_riga_documento_ordine_gd.Getitemnumber(ll_row, "id_riga_lotto")
//		if tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_riga_documento_ordine_ritorno_gd" then
//			ll_lotto_trovato2=ids_riga_doc_lotto.find("id_riga_lotto="+string(ll_id_r_lotto), 1, ids_riga_doc_lotto.rowcount())
//			if ll_lotto_trovato2>0 and not isnull(ll_lotto_trovato2) then
//				ll_id_lotto=ids_riga_doc_lotto.getitemnumber(ll_lotto_trovato2, "id_lotto")
//				ll_lotto_trovato=ids_scar_lotto.find("id_lotto="+string(ll_id_lotto), 1, ids_scar_lotto.rowcount())
//				if ll_lotto_trovato>0 then
//					ls_tipo=ids_scar_lotto.getitemstring(ll_lotto_trovato, "tipo_lotto")
//					if ls_tipo='Z' then ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", 'X')
//					if ls_tipo='K' then ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", 'Y')
//					ld_qta_iniz=ids_scar_lotto.getitemdecimal(ll_lotto_trovato, "qta_iniziale")
//					ids_scar_lotto.setitem(ll_lotto_trovato, "qta_scaricata",ld_qta_iniz)
//					ids_riga_doc_lotto.setitem(ll_lotto_trovato2, "valore_scarico",ld_qta_iniz)
//				else
//				end if
//			else
//				return 1
//			end if
//		else
//			do 
//				ll_lotto_trovato=ids_riga_doc_lotto.find("id_riga_lotto="+string(ll_id_r_lotto), 1, ids_riga_doc_lotto.rowcount())
//				if ll_lotto_trovato>0 and not isnull(ll_lotto_trovato) then
//					
//					ld_val_scar=ids_riga_doc_lotto.GetItemDecimal(ll_lotto_trovato,"valore_scarico")
//					ll_id_lotto=ids_riga_doc_lotto.GetItemNumber(ll_lotto_trovato,"id_lotto")
//					
//					ids_riga_doc_lotto.deleterow(ll_lotto_trovato)
//					
//					ll_lotto_trovato=ids_scar_lotto.find("id_lotto="+string(ll_id_lotto), 1, ids_scar_lotto.rowcount())
//					
//					if ll_lotto_trovato>0 then
//						
//						if (lc_tipo_ges_lotti = 'G') then
//							
//							ll_id_unita_confezione = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_id_unita_confezione[ll_row]
//							SELECT m.tipo
//							INTO	 :ls_tipo_mov
//							FROM	 unita_confezione u, unita_misura m
//							WHERE  u.id_unita_confezione = :ll_id_unita_confezione
//							AND	 m.id_unita_misura = u.id_unita_misura
//							;
//						end if
//							
//						if (lc_tipo_ges_lotti = 'G') and (ls_tipo_mov = 'P') then
//							ld_peso_netto_scaricato=ids_scar_lotto.GetItemDecimal(ll_lotto_trovato,"peso_netto_scaricato")
//							ids_scar_lotto.SetItem(ll_lotto_trovato,"peso_netto_scaricato", ld_peso_netto_scaricato - ld_val_scar)
//						else
//						
//							ldt_qta_scar_attuale=ids_scar_lotto.GetItemDecimal(ll_lotto_trovato,"qta_scaricata")
//							ids_scar_lotto.SetItem(ll_lotto_trovato,"qta_scaricata", ldt_qta_scar_attuale - ld_val_scar)	
//						end if
//						if  ids_scar_lotto.dataobject="d_cerca_lotti_andata_ster_gd" then
//							ls_tipo=ids_scar_lotto.getitemstring(ll_lotto_trovato, "tipo_lotto")
//							choose case ls_tipo	
//								case "X"
//									ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "P")
//								case "Y"
//									ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "S")					
//							end choose
//						end if
//					else
//						messagebox("Errore", "lotto da reintegrare non trovato~r~nid_lotto="+string(ll_id_lotto))
//						err= -1
//					end if
//				end if
//			
//		
//			loop while ll_lotto_trovato>0 and not isnull(ll_lotto_trovato)
//		END IF
//	end if
//	
//	if IsValid(ids_lotti) then
//		ll_id_r_lotto=tab_1.tabpage_2.dw_riga_documento_ordine_gd.Getitemnumber(ll_row, "id_riga_lotto")
//		
//		if ll_id_r_lotto>0 then
//			
//			long li_num_lotto
//			
//			SELECT numero
//			INTO	 :li_num_lotto
//			FROM	 lotto l, riga_doc_lotto r
//			WHERE  r.id_riga_lotto = :ll_id_r_lotto
//			AND	 l.id_lotto = r.id_lotto
//			;
//			
//			if (sqlca.sqlcode = -1) then messagebox("DBError", sqlca.sqlerrtext)
//			
//			if (li_num_lotto > 0) then
//
//				
//				ll_row=ids_lotti.Find("numero = "+string(li_num_lotto),1,ids_lotti.rowcount())
//				
//				if ll_row>0 then
//					li_ret=ids_lotti.DeleteRow(ll_row)
//					if li_ret<>1 then 
//						messagebox("Errore!", "Cancellazione lotto non riuscita!")
//					else
//						ll_row=ids_riga_doc_lotto.Find("id_riga_lotto = "+string(ll_id_r_lotto),1,ids_riga_doc_lotto.rowcount())
//						if ll_row>0 then 
//							li_ret=ids_riga_doc_lotto.DeleteRow(ll_row)
//							if li_ret<>1 then 
//								messagebox("Errore!", "Cancellazione collegamento lotto non riuscita!~r~n numero_lotto="+string(ll_id_r_lotto))
//								err= -1
//							end if
//						else
//							messagebox("Errore!", "Lotto da cancellare non trovato!")
//							err= -1
//						end if
//					end if
//				end if
//			end if
//		end if
//	end if
	return 1// err
end function

public function long wf_controlla_lotti (string as_gest_lotti);
long i, num_righe, ll_id_cat_fiscale
string ls_stringhe, ls_des
date ld_date
decimal{2} ld_decimali

decimal{4} ld_peso_netto
long ll_id_unita_confezione
string ls_tipo

num_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.RowCount()
for i=1 to num_righe
	
	ls_stringhe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemString(i,"c_articolo_cod")
	if IsNull(ls_stringhe) or (ls_stringhe='') then	
		ls_des=tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemString(i,"riga_documento_descrizione")
		if IsNull(ls_des) or (ls_des="") then 
			return -1 
		else
			
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(i,"id_riga_lotto",0)
		end if
	else
		select id_cat_fiscale
		into :ll_id_cat_fiscale
		from articolo
		where codice=:ls_stringhe;
		if isnull(ll_id_cat_fiscale) then return 0
		
		
		ls_stringhe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemString(i,"cod_lotto")
		if IsNull(ls_stringhe) or (ls_stringhe='') then	return -1
		
		ld_date=tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemDate(i,"data_scadenza")
		if IsNull(ld_date) or Not(IsDate(string(ld_date))) then	return -1
		
		ld_decimali=tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemDecimal(i,"quantita")
		if IsNull(ld_decimali) then return -1
		
		
		ll_id_unita_confezione = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i,"riga_documento_id_unita_confezione")
		SELECT m.tipo
		INTO	 :ls_tipo
		FROM	 unita_misura m, unita_confezione u
		WHERE	 u.id_unita_confezione = :ll_id_unita_confezione
		AND	 m.id_unita_misura = u.id_unita_misura
		;
		
		if (ls_tipo = 'P') then
			ld_peso_netto=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i,"riga_documento_peso_netto")
			if (IsNull(ld_peso_netto) or ld_peso_netto = 0) then return -1
		end if
		
	end if
next
return 0
end function

public subroutine wf_azzera_campi_calcolati_sog (long ll_row);
long ll_destinazione
if not isnull(idw_gen.getitemnumber(ll_row, "id_destinazione")) then
	SetNull(ll_destinazione)
	idw_gen.SetItem(ll_row, "id_destinazione", ll_destinazione)
	idw_gen.SetItem(ll_row, "c_destinazione_des", "")
end if


			
end subroutine

public subroutine wf_scarico_lotti (long ll_id_articolo, decimal ld_qta, long row);//decimal {2} ld_val_scar, ld_app, ldt_qta_scar_attuale, ld_qta_lotto
//long ll_id_lotto, ll_id_doc, max_num_riga, ll_id_valuta, ll_id_u_conf, ll_iva, ll_lotto_trovato
//s_ges_lotti s_lotti
//boolean esisteva
//date ld_date_lotto
//string ls_cod_art, ls_des_art, ls_tipo, ls_cod_lotto
//char lc_tipo_lotto
//integer i
//
//
//char lc_tipo_ges_lotti
//string ls_tipo_mov
//decimal  {4} ldt_peso_scar_attuale, ld_peso_lotto
//
//SELECT m.tipo
//INTO   :ls_tipo_mov
//FROM   articolo a, unita_confezione u, unita_misura m
//WHERE  a.id_articolo=:ll_id_articolo
//AND	 u.id_articolo = a.id_articolo
//AND	 u.unita_base = 'S'
//AND	 m.id_unita_misura =* u.id_unita_misura
//;
//
//SELECT tipo_ges_lotti
//INTO	 :lc_tipo_ges_lotti
//FROM	 pers_par_sistema
//;
//
//integer li_ret
//li_ret = ids_scar_lotto.rowcount()
//
//ll_id_doc=idw_gen.getitemnumber(1, "id_documento")
//esisteva=false
//s_lotti.s_id_articolo=ll_id_articolo
//if Not(IsNull(s_lotti.s_id_articolo)) then
//	s_lotti.s_data_scadenza=idw_riga.getitemdate(row, "data_scadenza")
//	if isnull(s_lotti.s_data_scadenza) then s_lotti.s_data_scadenza=date('1998/01/01')
//	s_lotti.s_qta_da_scaricare=ld_qta
//	s_lotti.s_numero=idw_riga.getitemnumber(row, "id_riga_lotto")
//	s_lotti.s_qta_originale=idw_riga.getitemdecimal(row, "quantita")
//	
//	
//	if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//		s_lotti.s_peso_da_scaricare=ld_qta
//		s_lotti.s_peso_originale=idw_riga.getitemdecimal(row, "riga_documento_peso_netto")
//	end if
//	
//	
//	
//	choose case ids_scar_lotto.dataobject
//		case "ds_cerca_lotti", "d_cerca_lotti_andata_ster_gd"
//			ids_scar_lotto.SetFilter("")
//			ids_scar_lotto.Filter()
//			
//			
//				
//				
//			
//			
//				ids_scar_lotto.SetFilter("id_articolo="+string(s_lotti.s_id_articolo))
//				ids_scar_lotto.Filter()
//			
//			
//			do 
//				ll_lotto_trovato=ids_riga_doc_lotto.find("id_riga_lotto="+string(s_lotti.s_numero), 1, ids_riga_doc_lotto.rowcount())
//				if ll_lotto_trovato>0 and not isnull(ll_lotto_trovato) then
//					esisteva= true
//					
//					ld_val_scar=ids_riga_doc_lotto.GetItemDecimal(ll_lotto_trovato,"valore_scarico")
//					ll_id_lotto=ids_riga_doc_lotto.GetItemNumber(ll_lotto_trovato,"id_lotto")
//					
//					il_id_lotti[upperbound(il_id_lotti[])+1]=ll_id_lotto
//					idt_qta_lotti[upperbound(il_id_lotti[])]=ld_val_scar
//					
//					ids_riga_doc_lotto.deleterow(ll_lotto_trovato)
//					
//					ll_lotto_trovato=ids_scar_lotto.find("id_lotto="+string(ll_id_lotto), 1, ids_scar_lotto.rowcount())
//					
//					if ll_lotto_trovato>0 then
//						
//						
//						if  ids_scar_lotto.dataobject="d_cerca_lotti_andata_ster_gd" then
//							ls_tipo=ids_scar_lotto.getitemstring(ll_lotto_trovato, "tipo_lotto")
//							choose case ls_tipo	
//								case "X"
//									ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "P")
//								case "Y"
//									ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "S")					
//							end choose
//						end if
//
//						
//						if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//							ldt_peso_scar_attuale=ids_scar_lotto.GetItemDecimal(ll_lotto_trovato,"peso_netto_scaricato")
//							idt_qta_scar_attuale[upperbound(il_id_lotti[])]=ldt_peso_scar_attuale
//							ids_scar_lotto.SetItem(ll_lotto_trovato,"peso_netto_scaricato", ldt_peso_scar_attuale - ld_val_scar)							
//						else
//						
//							ldt_qta_scar_attuale=ids_scar_lotto.GetItemDecimal(ll_lotto_trovato,"qta_scaricata")
//							
//							idt_qta_scar_attuale[upperbound(il_id_lotti[])]=ldt_qta_scar_attuale
//							ids_scar_lotto.SetItem(ll_lotto_trovato,"qta_scaricata", ldt_qta_scar_attuale - ld_val_scar)
//						end if
//					else
//						messagebox("Errore", "Lotto da reintegrare non trovato~r~nid_lotto="+string(ll_id_lotto))
//					end if
//				end if
//				
//			loop while ll_lotto_trovato>0 and not isnull(ll_lotto_trovato)
//	end choose
//	
//	long ll_rig
//	ll_rig=ids_scar_lotto.RowCount()
//	
//	
//	ls_cod_lotto = idw_riga.getItemString(idw_riga.getRow(),"cod_lotto")
//	if IsNull(ls_cod_lotto) or ls_cod_lotto='' then
//		
//		if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//			ids_scar_lotto.SetFilter("id_articolo="+string(s_lotti.s_id_articolo)+" and peso_netto_iniziale>(if ( isnull( peso_netto_scaricato ), 0, peso_netto_scaricato ) )")
//		
//		else	
//			ids_scar_lotto.SetFilter("id_articolo="+string(s_lotti.s_id_articolo)+" and qta_iniziale>qta_scaricata")
//		end if
//	else
//		string testForQuery
//		
//		
//		if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//			testForQuery="id_articolo="+string(s_lotti.s_id_articolo)+" AND IF ( ISNULL( peso_netto_iniziale) , 0,  peso_netto_iniziale ) > IF ( ISNULL( peso_netto_scaricato ), 0, peso_netto_scaricato) "+ &
//			" and cod_esterno = '" + ls_cod_lotto +"'" 
//			ids_scar_lotto.SetFilter(testForQuery)
//		
//		else		
//			
//			
//			testForQuery="id_articolo="+string(s_lotti.s_id_articolo)+" and IF (ISNULL(qta_iniziale), 0, qta_iniziale ) > IF (ISNULL(qta_scaricata), 0, qta_scaricata)"+ &
//			" and cod_esterno like '" + ls_cod_lotto +"%'" 
//			ids_scar_lotto.SetFilter(testForQuery)
//			
//		end if
//		
//	end if
//	
//	
//	ids_scar_lotto.Filter()
//	s_lotti.s_ds_lotti=ids_scar_lotto
//	
//
//	openwithparm(w_scarica_lotti, s_lotti)
//	
//	
//	s_lotti=Message.PowerObjectparm
//	ids_scar_lotto=s_lotti.s_ds_lotti
//	
//	
//	if s_lotti.s_flag_copia='Ok' or s_lotti.s_flag_copia='SP' then
//	
//		choose case ids_scar_lotto.dataobject
//			case "ds_cerca_lotti"	
//				for i=1 to UpperBound(s_lotti.s_id_lotti)
//					ll_lotto_trovato=ids_scar_lotto.find("id_lotto="+string(s_lotti.s_id_lotti[i]), 1, ids_scar_lotto.rowcount())
//					
//					if ll_lotto_trovato>0 then
//						ls_cod_lotto=ids_scar_lotto.getitemstring(ll_lotto_trovato, "cod_esterno")
//						ld_date_lotto=ids_scar_lotto.getitemdate(ll_lotto_trovato, "data_scadenza")
//						
//						if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//							ld_peso_lotto=ids_scar_lotto.getitemdecimal(ll_lotto_trovato, "peso_netto_scaricato") - s_lotti.s_peso_scar_originale[i]
//						else
//						
//							ld_qta_lotto=ids_scar_lotto.getitemdecimal(ll_lotto_trovato, "qta_scaricata") - s_lotti.s_qta_scar_originale[i]
//						end if
//						if i=1 then
//							idw_riga.setitem(row, "cod_lotto", ls_cod_lotto)
//							idw_riga.setitem(row, "data_scadenza", ld_date_lotto)
//							
//							if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then							
//								post wf_risetta_qta_originale(row, "riga_documento_peso_netto", ld_peso_lotto, idw_riga)
//							
//							else							
//								post wf_risetta_qta_originale(row, "quantita", ld_qta_lotto, idw_riga)
//							end if
//		
//							ll_id_u_conf=idw_riga.getitemnumber(row,"riga_documento_id_unita_confezione")
//							ll_iva=idw_riga.getitemnumber(row,"riga_documento_id_tab_iva")
//							ls_cod_art=idw_riga.getitemstring(row,"c_articolo_cod")
//							ls_des_art=idw_riga.getitemstring(row,"riga_documento_descrizione")
//							max_num_riga=idw_riga.getitemnumber(row,"id_riga_lotto")
//						else
//							cb_inserisci.trigger event clicked()
//							row=idw_riga.Getrow()
//							idw_riga.setitem(row, "riga_documento_id_articolo", s_lotti.s_id_articolo)
//							idw_riga.setitem(row,"c_articolo_cod", ls_cod_art)
//							idw_riga.setitem(row,"riga_documento_descrizione", ls_des_art)
//							idw_riga.setitem(row, "cod_lotto", ls_cod_lotto)
//							idw_riga.setitem(row, "data_scadenza", ld_date_lotto)
//							idw_riga.setitem(row, "quantita", ld_qta_lotto)							
//							
//							if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//								idw_riga.setitem(row, "riga_documento_peso_netto", ld_peso_lotto)
//							end if
//							
//							
//							
//							tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_rec_prezzo(row, ld_qta_lotto)
//							
//							
//							tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_contropartita()
//							
//							
//		
//		
//							idw_riga.setitem(row,"riga_documento_id_unita_confezione",ll_id_u_conf)
//							idw_riga.setitem(row,"riga_documento_id_tab_iva", ll_iva)
//							max_num_riga=idw_riga.getitemnumber(row,"id_riga_lotto")
//						end if
//						
//						ll_lotto_trovato=ids_riga_doc_lotto.InsertRow(0)
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"id_lotto",s_lotti.s_id_lotti[i])
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"id_riga_lotto", max_num_riga)
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"id_doc",ll_id_doc)
//						
//						
//						if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//							ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"valore_scarico",ld_peso_lotto)	
//						
//						else						
//							ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"valore_scarico",ld_qta_lotto)
//						end if
//					else
//						messagebox("errore", "id_lotto="+string(s_lotti.s_id_lotti[i])+" non trovato")
//					end if
//				next
//			case "d_cerca_lotti_andata_ster_gd"
//				for i=1 to UpperBound(s_lotti.s_id_lotti)
//					ll_lotto_trovato=ids_scar_lotto.find("id_lotto="+string(s_lotti.s_id_lotti[i]), 1, ids_scar_lotto.rowcount())
//					
//					if ll_lotto_trovato>0 then
//						ls_cod_lotto=ids_scar_lotto.getitemstring(ll_lotto_trovato, "cod_esterno")
//						ld_date_lotto=ids_scar_lotto.getitemdate(ll_lotto_trovato, "data_scadenza")
//						ld_qta_lotto=ids_scar_lotto.getitemdecimal(ll_lotto_trovato, "qta_scaricata") - s_lotti.s_qta_scar_originale[i]
//						lc_tipo_lotto=ids_scar_lotto.getitemstring(ll_lotto_trovato, "tipo_lotto")
//						choose case lc_tipo_lotto
//							case "P"
//								ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "X")
//							case "S"
//								ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "Y")					
//						end choose
//						if i=1 then
//							idw_riga.setitem(row, "cod_lotto", ls_cod_lotto)
//							idw_riga.setitem(row, "data_scadenza", ld_date_lotto)
//							
//							if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//								post wf_risetta_qta_originale(row, "riga_documento_peso_netto", ld_peso_lotto, idw_riga)
//							
//							else							
//								post wf_risetta_qta_originale(row, "quantita", ld_qta_lotto, idw_riga)
//							end if
//		
//							ll_id_u_conf=idw_riga.getitemnumber(row,"riga_documento_id_unita_confezione")
//							ll_iva=idw_riga.getitemnumber(row,"riga_documento_id_tab_iva")
//							ls_cod_art=idw_riga.getitemstring(row,"c_articolo_cod")
//							ls_des_art=idw_riga.getitemstring(row,"riga_documento_descrizione")								
//							max_num_riga=idw_riga.getitemnumber(row,"id_riga_lotto")
//						else
//							cb_inserisci.trigger event clicked()
//							row=idw_riga.Getrow()
//							idw_riga.setitem(row, "riga_documento_id_articolo", s_lotti.s_id_articolo)
//							idw_riga.setitem(row,"c_articolo_cod", ls_cod_art)
//							idw_riga.setitem(row,"riga_documento_descrizione", ls_des_art)								
//							idw_riga.setitem(row, "cod_lotto", ls_cod_lotto)
//							idw_riga.setitem(row, "data_scadenza", ld_date_lotto)
//							idw_riga.setitem(row, "quantita", ld_qta_lotto)
//							
//							lc_tipo_lotto=ids_scar_lotto.getitemstring(ll_lotto_trovato, "tipo_lotto")
//							choose case lc_tipo_lotto
//								case "P"
//									ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "X")
//								case "S"
//									ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "Y")					
//							end choose
//		
//		
//		
//							idw_riga.setitem(row,"riga_documento_id_unita_confezione",ll_id_u_conf)
//							idw_riga.setitem(row,"riga_documento_id_tab_iva", ll_iva)
//							max_num_riga=idw_riga.getitemnumber(row,"id_riga_lotto")
//						end if
//						ll_lotto_trovato=ids_riga_doc_lotto.InsertRow(0)
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"id_lotto",s_lotti.s_id_lotti[i])
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"id_riga_lotto", max_num_riga)
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"id_doc",ll_id_doc)
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"valore_scarico",ld_qta_lotto)
//					else
//						messagebox("errore", "id_lotto="+string(s_lotti.s_id_lotti[i])+" non trovato")
//					end if
//				next
//		end choose
//	else
//		
//		choose case ids_scar_lotto.dataobject
//			case "ds_cerca_lotti", "d_cerca_lotti_andata_ster_gd"
//				for i=1 to UpperBound(il_id_lotti[])
//					ll_lotto_trovato=ids_scar_lotto.find("id_lotto="+string(il_id_lotti[i]), 1, ids_scar_lotto.rowcount())
//					
//					if ll_lotto_trovato>0 then
//						
//						
//						if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') and (ids_scar_lotto.dataobject = "ds_cerca_lotti") then
//							ids_scar_lotto.setitem(ll_lotto_trovato, "peso_netto_scaricato", idt_qta_scar_attuale[i])
//						
//						else						
//							ids_scar_lotto.setitem(ll_lotto_trovato, "qta_scaricata", idt_qta_scar_attuale[i])
//						end if
//						if ids_scar_lotto.dataobject="d_cerca_lotti_andata_ster_gd" then
//							lc_tipo_lotto=ids_scar_lotto.getitemstring(ll_lotto_trovato, "tipo_lotto")
//							choose case lc_tipo_lotto
//								case "P"
//									ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "X")
//								case "S"
//									ids_scar_lotto.setitem(ll_lotto_trovato, "tipo_lotto", "Y")					
//							end choose
//						end if
//						
//						ll_lotto_trovato=ids_riga_doc_lotto.InsertRow(0)
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"id_lotto", il_id_lotti[i])
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"id_riga_lotto", s_lotti.s_numero)
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"id_doc", ll_id_doc)
//						ids_riga_doc_lotto.SetItem(ll_lotto_trovato,"valore_scarico", idt_qta_lotti[i])
//					else
//						messagebox("Errore", "id_lotto="+string(il_id_lotti[i])+" non trovato")
//					end if
//				next	
//				
//				if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//					post wf_risetta_qta_originale(row, "riga_documento_peso_netto", s_lotti.s_peso_originale, idw_riga)
//				
//				else				
//					post wf_risetta_qta_originale(row, "quantita", s_lotti.s_qta_originale, idw_riga)				
//				end if
//			
//		end choose
//	end if
//	ids_scar_lotto.SetFilter("")
//	ids_scar_lotto.Filter()
//end if
end subroutine

public subroutine wf_carico_lotti (long al_row, long al_id_art);//long ll_row, i, ll_id
//integer li_ret
//char		lc_tipo_ges_lotti		
//date		ldt_data_reg
//
//ll_row=idw_riga.getitemnumber(al_row,"id_riga_lotto")
//i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
//if isnull(al_id_art) then
//	al_id_art=idw_riga.getitemNumber(al_row,"riga_documento_id_articolo")
//end if
//if i>0 then	
//	li_ret=ids_lotti.SetItem(i,"id_articolo",al_id_art)
//	if li_ret<>1 then messagebox("Errore", "Non settato id_articolo in lotto")
//	
//	SELECT tipo_ges_lotti
//	INTO	 :lc_tipo_ges_lotti
//	FROM	 pers_par_sistema
//	;
//	if (SQLCA.SQLCODE = -1) then messagebox("Carico Lotti DBError", SQLCA.SQLERRTEXT)
//	
//	if (lc_tipo_ges_lotti = 'G') then
//		ldt_data_reg = idw_gen.getitemdate(1, "data_registrazione")
//		li_ret=ids_lotti.SetItem(i,"lotto_data_doc", ldt_data_reg)		
//	end if
//	
//else
//	messagebox("Errore","Lotto non trovato")
//end if
//
//post wf_proponi_dati_lotto(al_row)
end subroutine

public function integer wf_controlla_utilizzabile (long al_id_articolo);	
		
		
		
		
		
		
string ls_utilizzabile
LONG LL_ROW

select utilizzabile
into :ls_utilizzabile
from articolo
where id_articolo=:al_id_articolo;
if sqlca.sqlcode=0 then
	if ls_utilizzabile='N' then
		messagebox("Attenzione!", "Articolo marcato 'Non Utilizzabile'.~r~nLa scelta sarà annullata.")
		LL_ROW=IDW_RIGA.GETROW()
		IDW_RIGA.SETITEM(LL_ROW, "C_ARTICOLO_COD", "") 				
		return -1
	end if
else
	Messagebox("Errore!", "Articolo non trovato!")
	return -1
end if

return 1
end function

public function integer uf_stampa ();

string			ls_msg_a, ls_msg_b,ls_title, ls_contabilizza
string			ls_doc_stampato, ls_stampato
boolean			lb_definit, lb_can_go
long				ll_row, ll_id_documento,ll_id_prof_documento
string			ls_tipo_registro, ls_nome_report, ls_dir, ls_selection_formula
window			lw_win
long				ll_retv, ll_sqlcode, ll_sqlrows
integer			li_outdev, li_stampa_ok
integer 			li_retvalue
boolean			lb_iva_ok, lb_cpt_ok
st_stampa_doc lst_stampa
integer li_num_copie
ls_title = ""


//wf_calcola_spese('N')
//ib_askforsave=false
//idw_riga.trigger event ue_key(KeyS!, 2)
//ib_askforsave=true



s_crea_dw s_par 
idw_spesa.TriggerEvent("ue_aggiorna")
If idw_castelletto.RowCount() = 0 or idw_spesa.rowcount()>0 then
	ib_genera_castelletto= TRUE
	SetPointer(HourGlass!)
	
	lb_iva_ok=tab_1.tabpage_4.dw_cast_iva_documento_lt.Event ue_calc_cast_iva()
	lb_cpt_ok=tab_1.tabpage_5.dw_contr_documento_lt.Event ue_calc_contropartita()
	SetPointer(Arrow!)
	If NOT (lb_iva_ok AND lb_cpt_ok) then 
		iuo_msg_log.uf_new_text("Stampa del Documento",3)
		iuo_msg_log.uf_new_text("Impossibile generare correttamente i castelletti IVA e CPT,~n indispensabile per avviare la stampa",4)
		
	end if
end if

//if (idw_master.uf_to_update() > 0) OR (idw_master.GetItemStatus(il_row,0,Primary!)=New!) then	
	
	ib_askforsave=FALSE	
	li_retvalue=idw_master.Event ue_update(0,0)
//else
//	li_retvalue=0
//end if
	iuo_msg_log.uf_new_text("Stampa del Documento",3)
if li_retvalue>0 then
	MessageBox("Stampa del Documento","Impossibile salvare il documento,~n indispensabile per avviare la stampa",Exclamation!)
	iuo_msg_log.uf_new_text("Stampa del Documento",3)
	iuo_msg_log.uf_new_text("Impossibile salvare il documento,~n indispensabile per avviare la stampa",4)
	RETURN 0
end if

ls_msg_a = "Stampa Documento; Warning!"
ls_doc_stampato = "documento_stampato"
ls_stampato = "S"


lb_definit = false
lb_can_go = true

ll_id_documento 	= idw_gen.GetItemNumber(il_row, "id_documento")

//SQLCA.sp_stampa_doc(ll_id_documento)		

if lb_can_go then
	ls_msg_b = "ID.DOCUMENTO NULLO"
	if (IsNull(ll_id_documento)) then
		MessageBox(ls_msg_a, ls_msg_b)
		lb_can_go = false
	else 
		ls_selection_formula="{documento.id_documento}=" + String(ll_id_documento)
		
	end if
end if


//if lb_can_go then
//	ls_tipo_registro = is_tipo_registro
//	if isNull(ls_tipo_registro) then
//		ls_tipo_registro = ""
//	end if
//	ls_msg_b = "Tipo registro "+ls_tipo_registro+" sconosciuto. Si userà il preventivo"
//	CHOOSE CASE ls_tipo_registro
//		CASE "OV", "OA"
//			ls_title = "Stampa Ordine"  
//		CASE "DV", "DA"
//			ls_title = "Stampa Bolla"
//		CASE "IV", "IA", "IC"
//			ls_title = "Stampa Fattura"
//		CASE "PV", "PA"
//			ls_title = "Stampa preventivo"
//		CASE ELSE
//			//MessageBox(ls_msg_a, ls_msg_b)
//			ls_title = "Stampa generica"
//	END CHOOSE
//end if

ll_row					= tab_1.tabpage_1.dw_documento_ordine_ff.getRow()
ll_id_prof_documento = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber( ll_row,"id_prof_documento" )

if lb_can_go then
	
	if not isNull( ll_id_prof_documento ) then
		select "prof_documento"."nome_report"
			into : ls_nome_report
			from "dba"."prof_documento"   
			where ( "prof_documento"."id_prof_documento" = :ll_id_prof_documento );

			
			
		if SQLCA.SQLCode = -1 then
			MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )
			return 0
		end if	
		
		if SQLCA.SQLCode = 100 then
			MessageBox( "Warning","Nel profilo documento non esiste il report",StopSign! )
			return 0		
		end if		
		
		if SQLCA.SQLCode = 0 then
			
		end if	
	end if	
end if	



if lb_can_go then
	
	
	s_par.ls_dw_sintax=ls_nome_report
	s_par.ll_id_doc=il_id_documento
	//220713 per samy segno inviato via mail e altro
	s_par.dw_riga=idw_riga
	s_par.dw_gen=idw_gen
	//fine samy 220713
	OpenWithParm(lw_win,s_par,"w_st_prov_def_wz")
	ll_retv = Message.DoubleParm
	
	lst_stampa=message.powerobjectparm
	li_num_copie= lst_stampa.i_num_copie
	ls_nome_report=lst_stampa.s_nome_report	
	
	select contabilizza_dopo_invio_fe
	into :ls_contabilizza
	from dba.orafo_par_sistema
	;
	if lst_stampa.fat_da_contabilizzare='S'  and ls_contabilizza='S' then
		cb_contabilizza.trigger event clicked()
	end if
	
	
	
	
	
	
	
	
	CHOOSE CASE ll_retv
		CASE 0							
			li_outdev = 1
		CASE 1							
			li_outdev = 1
			lb_definit = true
			
		CASE 2							
			li_outdev = 2
		CASE 3							
			li_outdev = 2
			lb_definit = true
			
		CASE -1							
			lb_can_go = false
		CASE ELSE						
			lb_can_go = false
	END CHOOSE
end if


if lb_can_go then
	
	select "par_sistema"."dir_report" into :ls_dir
		from "dba"."par_sistema"
		where "par_sistema"."id_azienda" = 1
		using SQLCA;
	ll_sqlcode = sqlca.sqlcode
	ll_sqlrows = sqlca.sqlnrows
	if (isNull(ls_dir)) or (ll_sqlcode<>0) or (ll_sqlrows>1) then
		messageBox(ls_msg_a, ls_msg_b)
		lb_can_go = false
	end if
	
	ls_msg_b = "Errore nella scrittura sul database"
	if lb_definit then
		If MessageBox(is_nome_tipo_documento, "E' stata scelta una stampa definitiva,~n confermi questa scelta?", Information!,YesNo!, 1) = 1 then
			
			ib_askforsave=FALSE
			ll_retv = idw_master.event ue_update (0,0)
			if ll_retv <> 0 then
				messageBox(ls_msg_a,ls_msg_b)
				lb_can_go = false
			end if
		end if
	end if
	
else
	return 0
end if
if lst_stampa.ordina_per>"" then
//	u_freddie.iuo_stampa.istr_formula[1].formula_name='ordina'
//	u_freddie.iuo_stampa.istr_formula[1].formula_string=lst_stampa.ordina_per
end if
if lb_can_go then
//	u_freddie.iuo_stampa.of_set_selection_formula(ls_selection_formula) 
//	u_freddie.iuo_stampa.of_set_Title(ls_title) 
//	u_freddie.iuo_stampa.of_set_view(u_freddie.iuo_stampa.MAXIMIZE_VIEW)
	
	if li_num_copie<=0 then li_num_copie=1
//	li_stampa_ok = u_freddie.iuo_stampa.of_stampa(0, li_outdev, 0, 0, li_num_copie,ls_dir, ls_nome_report)
	
end if	


ls_msg_b = "Errore in fase di stampa"
if li_stampa_OK <> 0 then
	MessageBox(ls_msg_a, ls_msg_b)
else
	ls_msg_b = "Errore nella scrittura sul database"
	if lb_definit then
		If MessageBox(is_nome_tipo_documento, "E' stata scelta una stampa definitiva,~n confermi questa scelta?", Information!,YesNo!, 1) = 1 then
			
			ib_askforsave=FALSE
			idw_gen.SetItem(il_row, ls_doc_stampato, ls_stampato)
			ll_retv = idw_master.event ue_update (0,0)
			if ll_retv <> 0 then
				messageBox(ls_msg_a,ls_msg_b)
			end if
		end if
	end if
end if

RETURN 0

end function

public function long wf_calcola_cpt (long al_id_sog_commerciale, long al_id_gr_agente, long al_id_articolo, long al_id_causale);
long		ll_id_contropartita, ll_id_azienda, ll_id_registro, ll_id_prof_doc
string	ls_tipo, ls_tipo_registro, ls_fat_acconto
SetNull(ll_id_contropartita)
ll_id_azienda= idw_gen.GetItemNumber(il_row, "documento_id_azienda")
u_setta_campi_documento u_cerca_cpt
u_cerca_cpt=create u_setta_campi_documento
ll_id_prof_doc= idw_gen.GetItemNumber(il_row, "id_prof_documento")
ls_fat_acconto=u_cerca_cpt.uf_fat_acconto(ll_id_prof_doc)
if ls_fat_acconto='S' then
	ll_id_contropartita=u_cerca_cpt.uf_cerca_contropartita_predefinita(ls_fat_acconto)
	if ll_id_contropartita >0 then
		return ll_id_contropartita
	else
		messagebox("Attenzione","Contropartita predefinita per l'acconto non trovata")
	end if
else
	
		
		ll_id_registro=idw_gen.GetItemNumber(il_row, "id_registro")
		SELECT "registro"."tipo_registro"  
		INTO :ls_tipo_registro  
		FROM "dba"."registro"  
		WHERE ( "registro"."id_registro" = :ll_id_registro ) AND  
			( "registro"."id_azienda" = 1 )   ;
		CHOOSE CASE ls_tipo_registro
		CASE "IA", "PA", "OA", "DA", "LA", "GA"
			
			ls_tipo= "A"
		CASE "IV", "PV", "OV", "DV", "LV", "GV", "IC"
			
			ls_tipo= "V"
		END CHOOSE
		SQLCA.sp_calc_cpt(al_id_sog_commerciale, al_id_articolo, al_id_gr_agente, ls_tipo, ll_id_azienda, ll_id_contropartita, al_id_causale)
end if
if ll_id_contropartita >0 then
	return ll_id_contropartita
else
	
	u_cerca_cpt.uf_cerca_contropartita_predefinita('N')
end if
destroy (u_cerca_cpt)
RETURN ll_id_contropartita
end function

public subroutine f_componenti_distinta (long ll_id_distinta);u_tv_distinta luo_distinta

if upperbound(tv_1.is_comp) >0 then 
	u_tv_distinta app
	app = create u_tv_distinta
	tv_1.is_comp = app.is_comp
	destroy app
end if
	
f_rec_righe_comp(tv_1,0,true,ll_id_distinta,date('01/01/90'),date('31/12/99'),ll_id_distinta,false)
if upperbound(tv_1.is_comp) >0 then 
	luo_distinta=create u_tv_distinta
	luo_distinta.is_comp=tv_1.is_comp
	openwithparm(w_variante_comp_ff,luo_distinta)
	luo_distinta=message.powerobjectparm
	if isvalid(luo_distinta) then 
		tv_1.is_comp=luo_distinta.is_comp
		destroy luo_distinta;
	else
		messagebox("Errore","Si e verificato un errore nel passaggio di parametri")
		destroy luo_distinta;
		return
	end if
	tv_1.deleteitem(0)							
end if
							

end subroutine

public subroutine wf_controlla_destinazione (long al_id_sog_commerciale);integer li_destinazione, li_cod
long ll_id_dest
string ls_indirizzo, ls_rag_soc
select count(id_destinazione) 
into :li_destinazione
from destinazione
where id_sog_commerciale=:al_id_sog_commerciale;
if (li_destinazione>0) and (not isnull(li_destinazione)) then
	tab_1.tabpage_1.dw_documento_ordine_ff.object.c_destinazione_des.background.color=16777088
	select codice, rag_soc_1, indirizzo, id_destinazione
	into :li_cod, :ls_rag_soc, :ls_indirizzo, :ll_id_dest
	from destinazione
	where id_sog_commerciale=:al_id_sog_commerciale
	and codice=0;
	IF sqlca.sqlcode= 0 then 
		if isnull(ls_indirizzo) then ls_indirizzo = ""
		ls_rag_soc+=" "+ls_indirizzo
		tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1, "c_destinazione_des", ls_rag_soc)															
		tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1,"id_destinazione", ll_id_dest)
	end if
else
	tab_1.tabpage_1.dw_documento_ordine_ff.object.c_destinazione_des.background.color=16777215
end if
end subroutine

public subroutine wf_se_cambia_qta (long row, string data);
long ll_id_unita_conf, ll_riga
string ls_gruppo, ls_data
decimal ldc_null
setnull(ldc_null)
ll_id_unita_conf=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(row, "riga_documento_id_unita_confezione")
ll_id_unita_conf=wf_controlla_qta_mov(ll_id_unita_conf, data)

if ll_id_unita_conf=0 then
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_post_itemchanged(row, "quantita", "")
	return
end if

//commentato 09-01-14 sperando sia davvero superfluo ...mm
//if pos(upper(u_freddie.istr_database.name), 'ORAFO')>0 then
//else
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_set_calc_tot_riga(row, Dec(data), ldc_null, FALSE)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.post event ue_rec_prezzo(row, dec(data))	
//end if

wf_inserisci_pesi_riga (dec(data))
ls_data=data
ll_riga=row
wf_prepara_esplodi(ll_riga, ls_data)

end subroutine

public subroutine wf_prepara_esplodi (long row, string data);long ll_articolo,ll_id_cat_fiscale,ll_null,ll_id_distinta,ll_ret,ll_riga, ll_righe_new, ll_totrows
string ls_ges, ls_tipo_reg, ls_la
long ll_prof, ll_righe_old,  ll_id_valuta, ll_id_causale
integer li_ret, i, li_ges_lotti
dec{4} ld_qta 
boolean lb_ok

setnull(ll_null)
ll_riga=row
ll_articolo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(row,"riga_documento_id_articolo")
select id_cat_fiscale
into :ll_id_cat_fiscale
from articolo
where id_articolo=:ll_articolo;

if isnull(ll_id_cat_fiscale) then	
	select id_distinta 
	into :ll_id_distinta
	from distinta
	where id_articolo=:ll_articolo;
	if ll_id_distinta>0 then

		ll_prof=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_prof_documento")
		select ges_db, tipo_registro
		into :ls_ges, :ls_tipo_reg	
		from prof_documento
		where id_prof_documento=:ll_prof;
		if ls_ges='S' then 
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_riga,"id_locazione_1",ll_null)
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_riga,"id_locazione_2",ll_null)			
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_riga,"riga_documento_id_caus_magazzino",ll_null)		
			ll_righe_old=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()						
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.update()
			
			if isvalid(ids_scar_lotto)  then
				li_ges_lotti=1
			else
				li_ges_lotti=0
			end if
			//mm 051212 cambio come dice Renzi: bisogna rottamare ogni tanto (soprattutto se non ha mai funto a dovere ...)
			//f_componenti_distinta(ll_id_distinta)
			//faccio tutto dentro "f_esplodi_documento"
			f_esplodi_documento(tv_1,0,true,ll_id_distinta,date('01/01/90'),date('31/12/99'),ll_id_distinta,tab_1.tabpage_2.dw_riga_documento_ordine_gd,dec(data),li_ges_lotti, row)
			ll_righe_new=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
			//post wf_qta(ll_righe_old,ll_righe_new)
			//PROVO A TOGLIERE IL POST ....
			wf_qta(ll_righe_old,ll_righe_new)
			//end if
		end if
	end if
end if
end subroutine

public subroutine wf_integra_campi_sog_com (long ll_id_tab_iva);string ls_tipo_iva
date ld_data_registrazione, ld_lr_prot_documenti
long ll_size, ll_count, ll_id_articolo, ll_id_lingua, ll_id_linguaggio, ll_id_sog_commerciale
s_des_articolo s_des_art


SELECT "tab_iva"."tipo_iva" 
INTO :ls_tipo_iva  
FROM "dba"."tab_iva"  
WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva;

if SQLCA.SQLCode = 0 then
	if ls_tipo_iva <> "S" then
		SetNull(ll_id_tab_iva)
		tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(il_row, "creato_in_esenzione","N" )
	else
		ld_data_registrazione= tab_1.tabpage_1.dw_documento_ordine_ff.GetItemDate(il_row, "data_registrazione")
		If not IsNull(ld_lr_prot_documenti) then 
			If ld_data_registrazione < ld_lr_prot_documenti then 
				tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(il_row, "creato_in_esenzione","S" )
			else
				tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(il_row, "creato_in_esenzione","N" )
			end if
		else
			tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(il_row, "creato_in_esenzione","S" ) 
		end if
	end if
	ll_size = idw_riga.RowCount()
	
	for ll_count = 1 to ll_size
		
			if IsNull(ll_id_tab_iva) then
			
			  SELECT "articolo"."id_tab_iva"  
					 INTO :ll_id_tab_iva  
					 FROM "dba"."articolo"  
					WHERE "articolo"."id_articolo" = :ll_id_articolo   ;
				if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then 
					idw_riga.SetItem(ll_count, "riga_documento_id_tab_iva",ll_id_tab_iva)
				end if
			else
				if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then 
					idw_riga.SetItem(ll_count, "riga_documento_id_tab_iva",ll_id_tab_iva)
				end if
			end if
			
			
			wf_metti_descrizione(ll_count)
	next
end if
end subroutine

public function string wf_cod_fornitore (string ls_art);
long ll_id_doc, ll_id_sog
string ls_cod_for 
u_setta_campi_documento luo_setta_cod_for
luo_setta_cod_for=create u_setta_campi_documento
ls_cod_for=luo_setta_cod_for.uf_trova_cod_fornitore(ll_id_doc, ll_id_sog, ls_art, tab_1.tabpage_2.dw_riga_documento_ordine_gd)
destroy luo_setta_cod_for
return ls_cod_for

		
end function

public function integer uf_rinumera_righe (integer li_cancella);
long		ll_nr_row, ll_row, ll_id_articolo
integer li_ret
string ls_descrizione

idw_riga.SetSort("riga_documento_num_riga A") 
idw_riga.Sort()
If ib_rinumera_righe then
	ll_nr_row= idw_riga.RowCount()
	
	FOR ll_row= ll_nr_row to 1 step -1
		
		if li_cancella=1 then
			ls_descrizione=idw_riga.getitemstring(ll_row, "riga_Documento_descrizione")
			ll_id_articolo=idw_riga.getitemnumber(ll_row, "riga_documento_id_articolo")
			if isnull(ll_id_articolo) and (isnull(ls_descrizione) or ls_descrizione='') then
				idw_riga.deleterow(ll_row)
			else
				idw_riga.SetItem(ll_row, "riga_documento_num_riga", ll_row)
			end if
		else
			idw_riga.SetItem(ll_row, "riga_documento_num_riga", ll_row)
		end if
	NEXT
	
	f_DisplayOnly(idw_riga,"riga_documento_num_riga" ,TRUE)	
	
	
	tab_1.tabpage_2.pb_sort.enabled=false	
	
else
	ll_nr_row= idw_riga.RowCount()
	FOR ll_row=1 to ll_nr_row
		idw_riga.SetItem(ll_row, "riga_documento_num_riga", ll_row * 1000)
	NEXT
	f_DisplayOnly(idw_riga,"riga_documento_num_riga" ,FALSE)
	li_ret=messagebox("Attenzione!" , "Per rinumerare le righe occorre salvarle: vuoi procedere?", stopsign!,yesno!)
	if li_ret=1 then
		li_ret=idw_riga.update()
		if li_ret<>1 then
			messagebox("Errore!" , "Salvataggio righe non riuscito!")
			ib_rinumera_righe= not ib_rinumera_righe
			uf_rinumera_righe(li_cancella)
			return 0
		end if
	else
		ib_rinumera_righe= not ib_rinumera_righe
		uf_rinumera_righe(li_cancella)
		return 0
	end if

end if
ib_rinumera_righe= not ib_rinumera_righe
RETURN 0

end function

public function string wf_varianti_set (string as_cod_articolo, long al_riga);string ls_art
long ll_id_art_old,ll_row,ll_sog,ll_id_cat_codifica,ll_id_art
long	 ll_orafo

SELECT table_id
INTO	 :ll_orafo
FROM	 sys.systable
WHERE  table_name='orafo_par_sistema'
;

if (sqlca.sqlcode <> 0) then
	ls_art = ""
	return ls_art	
end if

ll_sog=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_sog_commerciale")
select id_cat_codifica,id_articolo
into :ll_id_cat_codifica,:ll_id_art_old
from articolo
where codice=:as_cod_articolo
and id_azienda=1;
if ll_id_art_old>0 then
	ls_art=f_trova_varianti(ll_id_cat_codifica, as_cod_articolo)
	if ls_art>"" then
		ls_art=ls_art+"?"+string(ll_sog)+"?"+string(ll_id_art_old)
		openwithparm(w_variante_gd, ls_art)
		ls_art=message.stringparm
	end if
end if
return ls_art
end function

public subroutine wf_proponi_dati_lotto (integer ai_row);
//char lc_tipo_ges_lotti
//
//SELECT tipo_ges_lotti
//INTO	 :lc_tipo_ges_lotti
//FROM	 pers_par_sistema
//;
//			
//if (lc_tipo_ges_lotti = 'G') then
//	
//	long ll_cod_esterno, ll_giorni_durata, ll_id_articolo, ll_riga, ll_riga_app
//	date ldt_data_scadenza
//	DWObject my_dwo
//	
//	ll_id_articolo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ai_row,"riga_documento_id_articolo")
//	ll_riga = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ai_row,"riga_documento_num_riga")	
//				
//	SELECT MAX(cod_esterno) + 1
//	INTO	 :ll_cod_esterno
//	FROM	 lotto
//	WHERE  tipo_lotto = 'M'
//	AND    id_articolo = :ll_id_articolo
//	;
//		
//	if (ll_cod_esterno = 0 or isnull(ll_cod_esterno)) then
//		ll_cod_esterno = 1
//	end if
//	
//	
//	integer li_rows, li_i
//	long    ll_cod,  ll_max_cod, ll_id_art_app
//	
//	li_rows = tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
//	if (li_rows > 1) then
//		ll_max_cod = 0
//		for li_i = 1 to li_rows
//			ll_id_art_app = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_id_articolo[li_i]
//			ll_riga_app = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_num_riga[li_i]
//			
//			if (ll_id_art_app = ll_id_articolo) and (ll_riga <> ll_riga_app) then
//				ll_cod = long(tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.cod_lotto[li_i])
//				if (isnull(ll_cod)) then ll_cod = 0
//				if (ll_cod > ll_max_cod) then
//					ll_max_cod = ll_cod
//				end if
//			end if
//		next
//		if (ll_max_cod >= ll_cod_esterno) then ll_cod_esterno = ll_max_cod + 1
//	end if	
//	
//	
//	tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ai_row,"cod_lotto", string(ll_cod_esterno))
//				
//	
//
//	SELECT giorni_durata
//	INTO	 :ll_giorni_durata
//	FROM	 articolo
//	WHERE  id_articolo = :ll_id_articolo
//	;
//
//	if (ll_giorni_durata > 0) then
//		ldt_data_scadenza = tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(1,"data_registrazione")
//		if (isnull(ldt_data_scadenza)) then ldt_data_scadenza = Today()
//					
//		ldt_data_scadenza = relativedate(ldt_data_scadenza, ll_giorni_durata)
//		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ai_row,"data_scadenza", ldt_data_scadenza)
//	end if
//
//	my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.cod_lotto
//	tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event itemchanged(ai_row, my_dwo, string(ll_cod_esterno))		
//		
//	my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.data_scadenza
//	tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event itemchanged(ai_row, my_dwo, string(ldt_data_scadenza))			
//end if
//
end subroutine

public subroutine uf_pre_blocca_dispo (integer row);
string ls_tot, ls_name
if tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(row,'tipo_um')='P' then
	ls_tot=string(tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,"riga_documento_peso_netto"))
	ls_name='riga_documento_peso_netto'
else 	
   ls_tot=string(tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,"quantita"))
	ls_name='quantita'
end if
if uf_blocca_dispo(0,ls_tot,row)=2 then 
	if ls_name='quantita' then
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row,"quantita",0)
	else
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row,"riga_documento_peso_netto",0)
	end if
end if	
end subroutine

public function integer uf_blocca_dispo (decimal ld_tot_precedente, string data, integer row);
long ll_id_art_dispo, ll_ret, ll_u_conf, ll_per_scorta
integer li_giorno, li_mese, a
date ld_data
decimal ld_disponibilita, ld_tot_datastore
ll_id_art_dispo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(row,'riga_documento_id_articolo')
if ids_disponibilita.RowCount() > 0 then ll_ret=ids_disponibilita.find("id_articolo=" +string(ll_id_art_dispo), 1,ids_disponibilita.RowCount())
if is_movimentazione='D' then
	ld_disponibilita=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemdecimal(row,'c_disponibilita')
	a=0
else
	ll_u_conf=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(row,'riga_documento_id_unita_confezione')
	ld_data=tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(1,'data_registrazione')
	datastore ds_scorta
	ds_scorta=create datastore
	ds_scorta.dataobject='ds_per_scorta'
	ds_scorta.settransobject(sqlca)
	li_giorno=day(ld_data)
	li_mese=month(ld_data)
	ds_scorta.reset()
	ds_scorta.retrieve(li_giorno,li_mese)
	if ds_scorta.rowcount()>0 then 
		ll_per_scorta=ds_scorta.getitemnumber(1,'id_per_scorta')
		select scorta_minima
		into :ld_disponibilita
		from scorta
		where id_unita_confezione=:ll_u_conf and id_per_scorta=:ll_per_scorta;
		
		
		
		 if sqlca.sqlcode<>0 then ld_disponibilita=999999
	end if
	destroy ds_scorta
	a=1
end if	
if isnull(ld_disponibilita) then ld_disponibilita=0 
if isnull(ld_tot_precedente) then ld_tot_precedente=0
if ll_ret=0 then
 	if (dec(data) - ld_tot_precedente) > ld_disponibilita then
		
		if a=0 then
			messagebox('Attenzione','La quantita inserita supera la disponibilità attuale!')
			
		else
			messagebox('Attenzione',"La quantita inserita manda in sottoscorta l'articolo selezionato!")
		end if
		if is_prof_dispo='B' then return 2
	end if	
	ids_disponibilita.insertrow(1)
	ids_disponibilita.setitem(1,'id_articolo',ll_id_art_dispo)
	ld_disponibilita= ( dec(data) - ld_tot_precedente)
	ids_disponibilita.setitem(1,'totale',ld_disponibilita)
	return 3
else
	ld_tot_datastore=ids_disponibilita.getitemdecimal(ll_ret,'totale')
	
	if ((dec(data) - ld_tot_precedente) + ld_tot_datastore) > ld_disponibilita then
		if a=0 then
			messagebox('Attenzione','La quantita inserita supera la disponibilità attuale!')
		else
			messagebox('Attenzione',"La quantita inserita manda in sottoscorta l'articolo selezionato!")
		end if	
		if is_prof_dispo='B' then return 2
	end if	
	ld_disponibilita=((dec(data) - ld_tot_precedente) + ld_tot_datastore)
	ids_disponibilita.setitem(ll_ret,'totale',ld_disponibilita)
	return 3		
end if 
end function

public subroutine uf_setta_precedente (integer row, decimal ld_precedente, string name);if name='quantita' then
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row,'quantita', ld_precedente) 	
else
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(row,'riga_documento_peso_netto',ld_precedente)
end if	
	
end subroutine

public subroutine wf_gruppo_agenti (integer ai_row);
long 	ll_id_gruppo_agenti, ll_id_gruppo_agenti_2, ll_id_documento
date	ldt_data_reg
s_con_provvigione ls_con_provvigione			
ll_id_gruppo_agenti 	 = idw_riga.getitemnumber(ai_row,"id_gruppo_agenti")
//commento il secondo agente perché Silverdreams lo usa per prezzo galvanica 15-06-11 mm
//ll_id_gruppo_agenti_2 = idw_riga.getitemnumber(ai_row,"riga_documento_id_gruppo_agenti_2")
	
	if ( ll_id_gruppo_agenti > 0 ) then //or ll_id_gruppo_agenti_2 > 0 ) then 15-06-11 mm
		ls_con_provvigione.id_sog_commerciale  = idw_gen.getitemnumber(1, "id_sog_commerciale")
		ls_con_provvigione.id_unita_confezione = idw_riga.getitemnumber(ai_row, "riga_documento_id_unita_confezione")
		ls_con_provvigione.id_articolo = idw_riga.getitemnumber(ai_row, "riga_documento_id_articolo")
		ls_con_provvigione.data = idw_gen.getitemdate(1, "data_registrazione")
		ls_con_provvigione.sconto_perc = idw_riga.getitemstring(ai_row, "sconto")
		ls_con_provvigione.sconto_imp = idw_riga.getitemnumber(ai_row, "riga_documento_sconto_riga")
		ls_con_provvigione.id_valuta = idw_riga.getitemnumber(ai_row, "riga_documento_id_valuta")
		ls_con_provvigione.id_con_lis_articolo = idw_riga.getitemnumber(ai_row, "riga_documento_id_con_lis_articolo")

		if (ll_id_gruppo_agenti > 0) then
			ls_con_provvigione.id_gruppo_agenti = ll_id_gruppo_agenti
			f_provvigioni_agenti(ls_con_provvigione, tab_1.tabpage_2.dw_riga_documento_ordine_gd, ai_row, 1, "D")
		end if
// 15-06-11 mm
//		if (ll_id_gruppo_agenti_2 > 0) then
//			ls_con_provvigione.id_gruppo_agenti = ll_id_gruppo_agenti_2
//			f_provvigioni_agenti(ls_con_provvigione, tab_1.tabpage_2.dw_riga_documento_ordine_gd, ai_row, 2, "D")
//		end if
	end if
end subroutine

public function integer wf_ver_spesa (integer ai_row);string	ls_codice
long		ll_id_prof_documento
integer	li_spesa_gestita
ls_codice = idw_spesa.Describe( "Evaluate ('LookUpDisplay(id_spesa_cod)', " + string(ai_row) + ")")
messagebox("Codice", ls_codice)
ll_id_prof_documento = idw_gen.getitemnumber(1, "id_prof_documento")
		
SELECT LOCATE( spese_gestite, :ls_codice) 
INTO	 :li_spesa_gestita
FROM	 prof_documento
WHERE  id_prof_documento = :ll_id_prof_documento
;
		
if (li_spesa_gestita <= 0) then
	messagebox("Attenzione", "La spesa inserita non è abilitata nel profilo docuemnto")
	return -1
end if

return 0
end function

public subroutine wf_calcola_spese (character ac_conferma);
//20261106 fattura contabilizzata: le spese NON si toccano piu' (vedi uf_fattura_contabilizzata)
if uf_fattura_contabilizzata() then
	iuo_msg_log.uf_new_text("Fattura contabilizzata: le spese non vengono ricalcolate.", 2)
	if ac_conferma = 'S' then MessageBox(is_nome_tipo_documento, "La fattura e' contabilizzata: le spese non si possono piu' ricalcolare.", Exclamation!)
	return
end if

if tab_1.tabpage_4.dw_spesa_documento_gd.RowCount() > 0 and ac_conferma = 'S' then
	If MessageBox(is_nome_tipo_documento, "Vuoi sostituire le attuali Spese ricalcolandole?", Information!,YesNo!, 1) = 2 then &
		return
end if

iuo_msg_log.uf_new_text("Generazione delle spese.",2)
//tolgo l'if: quando ricalcola le spese deve sempre aggiornare
//il castelletto!!! MM 10-10-06

//if il_id_spesa_bollo>0 then
tab_1.tabpage_4.dw_spesa_documento_gd.TriggerEvent("ue_aggiorna")

	

//else
//	iuo_msg_log.uf_new_text("Manca una spesa di tipo bollo.", 4)
//	iuo_msg_log.uf_new_text("Impossibile generare le spese.",4)
//end if
end subroutine

public function integer uf_importa_righe (s_par_der_doc astr_par);//integer i
//decimal ldc_qta
//
//
//w_orafo_documento_ordine_cx lw_doc
//lw_doc=this
//u_righe_doc l_uo_importa_righe
//l_uo_importa_righe=create u_righe_doc
//
//if (astr_par.s_deriva_veloce ="D") then
//	l_uo_importa_righe.uf_importa_righe_veloce(astr_par, lw_doc)
//else
//	l_uo_importa_righe.uf_importa_righe(astr_par, lw_doc)
//end if
//destroy l_uo_importa_righe
//
//		
//wf_calcola_spese("N")
//
//
////char lc_tipo_ges_lotti
////
////SELECT tipo_ges_lotti
////INTO	 :lc_tipo_ges_lotti
////FROM	 pers_par_sistema
////;
////
////if not (lc_tipo_ges_lotti = 'G' and tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject = 'd_riga_documento_ordine_lotti_gd') then
////	cb_salva.post event clicked()
////end if
//
////lancio per ogni riga l'itemchanged sulla quantita
////così se è il caso esplode le righe nei componenti (SILVERDREAMS 11-06-10)
//for i= 1 to idw_riga.rowcount()
//	ldc_qta=idw_riga.getitemdecimal(i, "quantita")
//	wf_prepara_esplodi(i, string(ldc_qta))
//next
//
////lancio il ricalcolo deigli importi di riga
//tab_1.tabpage_2.cb_ricalcola.trigger event clicked()
//
//wf_clicca_cb_partite()
////27042017 AGGIUNGO SALVATAGGIO AUTOMATICO DELLA DERIVAZIONE
////tab_1.tabpage_2.dw_riga_documento_ordine_gd.triggerevent("ue_update")
//ib_askforsave=FALSE	
//TriggerEvent("ue_update")
//
return 0
//
end function

public function integer uf_set_dec_mask (integer ai_decimali, string as_valuta, long id_valuta);
string 		ls_mask, ls_mask_valconto, ls_simbolo_valconto
string		ls_edit
boolean 		lb_simbolo
long 			ll_id_esercizio, ll_id_valconto

lb_simbolo= cbx_simbolo.Checked
ls_mask= "#,0"

ls_mask = f_valu_mask(id_valuta)
if (as_valuta <> "" AND lb_simbolo= TRUE) then ls_mask = as_valuta + " " + ls_mask
ls_edit = f_valu_edit(id_valuta)

long ll_rowdoc
ll_rowdoc = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
ll_id_esercizio = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_rowdoc,"c_esercizio")
SELECT e.id_valuta, v.simbolo
INTO   :ll_id_valconto, :ls_simbolo_valconto
FROM   esercizio e, valuta v
WHERE  e.id_esercizio = :ll_id_esercizio
AND	 v.id_valuta = e.id_valuta
;
if isnull(ll_id_valconto) or ll_id_valconto = 0 then
	ll_id_valconto = id_valuta
	ls_simbolo_valconto = as_valuta
end if

ls_mask_valconto = f_valu_mask(ll_id_valconto)
if ls_simbolo_valconto <> "" AND lb_simbolo= TRUE then ls_mask_valconto = ls_simbolo_valconto + " " + ls_mask_valconto

idw_spesa.Modify("importo.edit.format = '" + ls_mask + "'")
idw_spesa.Modify("importo.format = '" + ls_mask + "'")
idw_spesa.Modify("c_importo_lire.format = '" + ls_mask_valconto + "'")
idw_castelletto.Modify("c_imponibile_spesa.format = '" + ls_mask + "'")
idw_castelletto.Modify("c_imponibile_spesa_lire.format = '" + ls_mask_valconto + "'")
idw_castelletto.Modify("c_imposta.format = '" + ls_mask + "'")
idw_castelletto.Modify("c_iva_lire.format = '" + ls_mask_valconto + "'")
idw_castelletto.Modify("c_iva_val.format = '" + ls_mask + "'")
idw_castelletto.Modify("val_tot_imp_v.format = '" + ls_mask + "'")
idw_castelletto.Modify("val_tot_imp_l.format = '" + ls_mask_valconto + "'")
idw_castelletto.Modify("c_imposta.format = '" + ls_mask + "'")
idw_castelletto.Modify("val_tot_iva_l.format = '" + ls_mask_valconto + "'")
idw_castelletto.Modify("val_tot_iva_v.format = '" + ls_mask + "'")
idw_castelletto.Modify("cc_acconto.format = '" + ls_mask + "'")
idw_castelletto.Modify("c_acconto_lire.format = '" + ls_mask_valconto + "'")

idw_scadenza.Modify("importo.format = '" + ls_mask_valconto + "'")
idw_scadenza.Modify("imp_valuta.format = '" + ls_mask + "'")

idw_contropartita.Modify("c_valore.format = '" + ls_mask_valconto + "'")

idw_gen_tot.Modify("fin_incondizionato.edit.format = '" + ls_edit + "'")
idw_gen_tot.Modify("fin_incondizionato.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_merce.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("netto_merce.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_omaggi_sc_merce.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_imponibile.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_imposta.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_documento.format = '" + ls_mask + "'")

idw_gen_tot_ext.Modify("tot_imponibile_lire.format = '" + ls_mask_valconto + "'")
idw_gen_tot_ext.Modify("tot_imposta_lire.format = '" + ls_mask_valconto + "'")

idw_gen_tot_ext.Modify("tot_documento_lire.format = '" + ls_mask_valconto + "'")
idw_gen_tot_ext.Modify("tot_merce_lire.format = '" + ls_mask_valconto + "'")
idw_gen_tot_ext.Modify("netto_merce_lire.format = '" + ls_mask_valconto + "'")
idw_gen_tot_ext.Modify("tot_omaggi_sc_merce_lire.format = '" + ls_mask_valconto + "'")

if is_tipo_documento = "P" then
	idw_gen.Modify("sconto_fin_incondizionato.format = '" + ls_mask + "'")
	idw_gen.Modify("c_totale_righe.format = '" + ls_mask + "'")
	idw_gen.Modify("c_totale_scontato.format = '" + ls_mask + "'")
end if 

idw_castelletto.Modify("val_tot_imp_v.edit.format = '" + ls_mask + "'")
idw_castelletto.Modify("val_tot_imp_l.edit.format = '" + ls_mask_valconto + "'")
idw_castelletto.Modify("val_tot_iva_v.edit.format = '" + ls_mask + "'")
idw_castelletto.Modify("val_tot_iva_l.edit.format = '" + ls_mask_valconto + "'")
idw_castelletto.Modify("cc_acconto.edit.format = '" + ls_mask + "'")

idw_spesa.Modify("importo.edit.format = '" + ls_mask + "'")

idw_scadenza.Modify("imp_valuta.edit.format = '" + ls_mask + "'")
idw_scadenza.Modify("importo.edit.format = '" + ls_mask_valconto + "'")

tab_1.tabpage_4.dw_documento_ord_tot_ff.Modify("documento_imp_acconto.edit.format = '" + ls_mask + "'")
tab_1.tabpage_4.dw_documento_ord_tot_ff.Modify("documento_imp_acconto.format = '" + ls_mask + "'")
idw_gen.Modify("imp_acconto.format = '" + ls_mask + "'")
idw_gen.Modify("imp_acconto.edit.format = '" + ls_mask + "'")


ls_mask_valconto = f_valu_mask_prezzi(ll_id_valconto)
if ls_simbolo_valconto <> "" AND lb_simbolo= TRUE then ls_mask_valconto = ls_simbolo_valconto + " " + ls_mask_valconto
idw_riga.Modify("c_tot_righe_lire.format = '" + ls_mask_valconto + "'")


ls_mask = f_valu_mask_prezzi(id_valuta)
if (as_valuta <> "" AND lb_simbolo= TRUE) then ls_mask = as_valuta + " " + ls_mask
idw_riga.Modify("c_tot_righe.format = '" + ls_mask + "'")

uf_set_mask_riga()
return 0

end function

public subroutine wf_calc_cpt_sco_tot (character as_cpt_sconti, ref datawindow adw_cpt, string as_sc_finanziario, decimal adc_sc_incondizionato, decimal adc_sc_fin_cassa);long			ll_id_cont_gen_acconto	

SELECT id_cont_gen_acconto
INTO	 :ll_id_cont_gen_acconto	
FROM	 par_sistema
;

if isnull(ll_id_cont_gen_acconto	) then ll_id_cont_gen_acconto	 = 0

long ll_id_cpt_sconti, ll_id_sog_commerciale, ll_cast_count_app, ll_cast_count, ll_cast_row_nr
decimal ldc_sconto_riga, ldc_sconto_unit_riga, ldc_imponibile2, ldc_imponibile1, ldc_imponibile, ldc_imponibile_old
boolean lb_ok
string ls_tipo_cpt

long ll_cifra_arr
string ls_tipo_arr

select cifra_arrotondamento, tipo_arrotondamento
into   :ll_cifra_arr, :ls_tipo_arr
from   valuta
where  id_valuta = :al_id_val_az;

ll_cast_row_nr = adw_cpt.rowcount()

if isnull(as_sc_finanziario) THEN as_sc_finanziario = ""
if isnull(adc_sc_incondizionato) THEN adc_sc_incondizionato = 0
if isnull(adc_sc_fin_cassa) THEN adc_sc_fin_cassa = 0
ll_id_sog_commerciale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,'id_sog_commerciale')

ldc_imponibile = 0
ll_id_sog_commerciale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,'id_sog_commerciale')

uo_cpt_sconti u_cpt_sconti
u_cpt_sconti = create uo_cpt_sconti	
ll_id_cpt_sconti = u_cpt_sconti.uf_cpt_sconti(as_sc_finanziario,0,0,"",0,0,0, ll_id_sog_commerciale, 0)				  
destroy (u_cpt_sconti)

if not isnull(ll_id_cpt_sconti) then
	lb_ok = false
	for ll_cast_count = 1 to ll_cast_row_nr
		ls_tipo_cpt = adw_cpt.getitemstring(ll_cast_count,"tipo_riga_cpt")
		ldc_imponibile1= adw_cpt.GetItemDecimal(ll_cast_count, "val_imponibile")
		adw_cpt.SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile1)			
		
		choose case ls_tipo_cpt
			case "C"
				ldc_imponibile = ldc_imponibile + ldc_imponibile1
			CASE "S"
				ldc_imponibile = ldc_imponibile - ldc_imponibile1
				
				if adw_cpt.getitemnumber(ll_cast_count, "id_conto") = ll_id_cpt_sconti then
					lb_ok = true
					ll_cast_count_app = ll_cast_count
				end if
		end choose
		
	next				
			
	ldc_imponibile2= uf_calcola_prezzo(as_sc_finanziario, ldc_imponibile, 0)
	ldc_imponibile2= f_round(ldc_imponibile2,ll_cifra_arr, ls_tipo_arr) 
	
	ldc_imponibile = ldc_imponibile - ldc_imponibile2
	
	if lb_ok = true then
		ldc_imponibile1 = adw_cpt.GetItemDecimal(ll_cast_count_app, "val_imponibile")
		adw_cpt.SetItem(ll_cast_count_app, "val_imponibile", ldc_imponibile+ldc_imponibile1)
		adw_cpt.SetItem(ll_cast_count_app, "val_imp_scontato", ldc_imponibile+ldc_imponibile1)		
	else
		uf_ins_riga_cp(ll_id_cpt_sconti,"S", adw_cpt, ldc_imponibile ,ldc_imponibile, 0, 0)
	end if
else
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= adw_cpt.GetItemDecimal(ll_cast_count, "val_imponibile")
		if (adw_cpt.getitemnumber(ll_cast_count, "id_conto") <> ll_id_cont_gen_acconto) then
			ldc_imponibile= uf_calcola_prezzo(as_sc_finanziario, ldc_imponibile, 0)
			ldc_imponibile = f_round(ldc_imponibile,ll_cifra_arr, ls_tipo_arr) 
		end if
		adw_cpt.SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
	next							
end if		

end subroutine

public function integer uf_ins_riga_cp (long al_id_contropartita, string as_tipo, datawindow adw_contropartita, decimal adc_imponibile, decimal adc_imp_scontato, decimal adc_omaggi_sc_merce, decimal adc_spese);
decimal 		ldc_aliquota, ldc_imponibile, ldc_ret_value, ldc_omaggi_sc_merce, ldc_imposta
decimal 		ldc_imp_scontato, ldc_per_detrazione, ldc_spese
string 		ls_codice, ls_descrizione
long 			ll_row_found, ll_new_row

if not (IsNull(al_id_contropartita) OR al_id_contropartita = 0) then 
	If adw_contropartita.RowCount() > 0 then
		ll_row_found=adw_contropartita.Find("id_conto =" + string(al_id_contropartita),1,adw_contropartita.RowCount())
	else
		ll_row_found=0
	end if
	if ll_row_found= 0 then
		SELECT "conto_azienda"."codice",   
				"conto_azienda"."descrizione"  
			INTO :ls_codice,   
				:ls_descrizione  
			FROM "dba"."conto_azienda"  
			WHERE "conto_azienda"."id_conto" = :al_id_contropartita   ;
		
		ll_new_row = adw_contropartita.InsertRow(0)
		ldc_ret_value = ll_new_row
		adw_contropartita.SetItem(ll_new_row, "id_documento", il_id_documento)
		adw_contropartita.SetItem(ll_new_row, "id_conto",al_id_contropartita)
		adw_contropartita.SetItem(ll_new_row, "tipo_riga_cpt", as_tipo)
		adw_contropartita.SetItem(ll_new_row, "conto_azienda_codice",ls_codice)
		adw_contropartita.SetItem(ll_new_row, "conto_azienda_descrizione",ls_descrizione)
		adw_contropartita.SetItem(ll_new_row, "val_imponibile", adc_imponibile)
		adw_contropartita.SetItem(ll_new_row, "val_imp_scontato", adc_imp_scontato)
		adw_contropartita.SetItem(ll_new_row, "val_omaggi", adc_omaggi_sc_merce)
		adw_contropartita.SetItem(ll_new_row, "val_spese", adc_spese)
	else
		
		ldc_ret_value= ll_row_found

		ldc_imponibile= adw_contropartita.GetItemDecimal(ll_row_found,"val_imponibile")
		if IsNull(ldc_imponibile) then ldc_imponibile= 0
		adw_contropartita.SetItem(ll_row_found, "val_imponibile", adc_imponibile + ldc_imponibile)

		ldc_omaggi_sc_merce=adw_contropartita.GetItemDecimal(ll_row_found,"val_omaggi")
		if IsNull(ldc_omaggi_sc_merce) then ldc_omaggi_sc_merce= 0
		adw_contropartita.SetItem(ll_row_found, "val_omaggi", adc_omaggi_sc_merce + ldc_omaggi_sc_merce)

		ldc_imp_scontato= adw_contropartita.GetItemDecimal(ll_row_found,"val_imp_scontato")
		if IsNull(ldc_imp_scontato) then ldc_imp_scontato= 0
		adw_contropartita.SetItem(ll_row_found, "val_imp_scontato", adc_imp_scontato + ldc_imp_scontato)

		ldc_spese= adw_contropartita.GetItemDecimal(ll_row_found,"val_spese")
		if IsNull(ldc_spese) then ldc_spese= 0
		adw_contropartita.SetItem(ll_row_found, "val_spese", adc_spese + ldc_spese)
	end if
end if

RETURN ldc_ret_value

end function

public subroutine uf_crea_spesa (long al_row, string as_codice, long al_id_spesa, long al_percentuale, decimal al_importo, long al_tab_iva, string as_mod_calc_iva);string ls_cod_spesa,ls_cod
date ldt_data_doc
long ll_row, ll_id_documento, ll_id_sog, ll_test, ll_id_iva
decimal ldc_tot_iva, ldc_aliq


ll_id_documento=idw_gen.GetItemNumber(il_row, "id_documento")

ll_row=idw_spesa.Find("id_spesa_cod = " + String(al_id_spesa) ,1,idw_spesa.RowCount())
if ll_row = 0  then //and ( al_percentuale > 0 or al_importo > 0 ) then 
	//20240716 tolgo le spese di bollo se NON c'è più la dichiarazione d'Intento (per ora solo per LABELLA)
	select codice into :ls_cod from dba.azienda;
	if pos(upper(ls_cod), "LABELLA") >0 then  //20240731 cambiato serie if per far passare il bollo negli articoli NON 80 (dich intento) ma con bollo		
	 	if idw_riga.rowcount()>0 then
			ll_id_iva=idw_riga.getitemnumber(1, "riga_documento_id_tab_iva")
			if ll_id_iva>0 then
				select codice into :ls_cod_spesa from dba.spesa where id_spesa=:al_id_spesa;
				if ls_cod_spesa='B'  then //occorre verificare meglio se il bollo andase anche in altri casi oltre dich intento (esportatori abituali??? comunque l'art 41 è esente da bollo!)
					//ma l'art 7 no.... infatti Maurizio s'è incazzato nero perché non gli ha messo il bollo in un art 7..... 20240731
					select sum(val_tot_iva_l) into :ldc_tot_iva from dba.cast_iva_documento where id_documento=:ll_id_documento;
					if ldc_tot_iva>0  then return  //se c'è iva NON c'è spesa di bollo!!!! 20240731
					//0select per_aliquota into :ldc_aliq from dba.tab_iva where id_tab_iva=:al_tab_iva;
					//if  ldc_aliq>0 then return //c'è iva niente spesa di bollo!!!
					 if ll_id_iva =80 then //ci deve essere la riga e deve essere iva 8/c1 (dich intento)
						select id_dich_intento into :ll_test from dba.dich_intento d, documento doc, sog_commerciale s where d.id_anagrafica=s.id_anagrafica and doc.id_documento=:ll_id_documento and
						doc.id_sog_commerciale=s.id_sog_commerciale and doc.data_documento>=d.valida_dal and  doc.data_documento<=d.valida_fino;
						select codice into :ls_cod_spesa from dba.spesa where id_spesa=:al_id_spesa;
					
							//20240730 stupido, ma succede : capita che si cghiude con iva anche mentre c'è la dich intento, quindi controllo l'iva doc
							select sum(val_tot_iva_l) into :ldc_tot_iva from dba.cast_iva_documento where id_documento=:ll_id_documento;
							if( isnull(ll_test) or ll_test<=0) then //se c'è iva o non c'è dich intento NON mette bollo
								return
							end if
						end if
				else  //20240729 la spesa NON è di bollo: devo gestire l'iva della spesa (incasso, trasporto ecc..) che dovrebbe seguire l'esenzione eventuale in relazione alla dich intento
					//if ll_test>0 then //dich valida nella data documento /apparte le spese di bollo le altre seguono il documento (almeno finora...)
					//controllo iva: deve essere la stessa delle righe doc ovvero della dich intento (la prendo dalla prima riga doc e incrociamo le dita....
					al_tab_iva=ll_id_iva
					//end if
					 //20240729 fine
				end if
			end if
		end if
	end if
	//20240716 fine
	ll_row=idw_spesa.InsertRow(0)
	idw_spesa.SetItem(ll_row, "id_spesa_cod", al_id_spesa)
	idw_spesa.SetItem(ll_row, "id_documento", ll_id_documento)
	idw_spesa.SetItem(ll_row, "percentuale", al_percentuale)
	idw_spesa.SetItem(ll_row, "importo", al_importo)	
	idw_spesa.SetItem(ll_row, "cc_importo_buffer", al_importo)
	idw_spesa.SetItem(ll_row, "id_tab_iva_cod", al_tab_iva)
	idw_spesa.SetItem(ll_row, "cc_mod_calc_iva", as_mod_calc_iva)
	idw_spesa.SetItem(ll_row, "mantieni", 'N')	
	
	idw_spesa.accepttext()
end if


end subroutine

public function integer wf_set_printer_info (string as_nome_stampante);

long		ll_size,ll_i		 
integer	li_rtn,li_count
string	ls_subkeylist[]
string   ls_regKey,ls_value
string   ls_driver_name,ls_printer_name,ls_port_name

ls_regKey	= "HKEY_LOCAL_MACHINE\System\CurrentControlSet\control\Print\Printers"


if RegistryKeys( ls_regKey,ls_subkeylist ) = -1 then
	MessageBox( "Errore","Errore nel leggere il registry",StopSign! )
	return 0
end if

ll_size = UpperBound( ls_subkeylist )
if ll_size > 0 then
	
	for ll_i = 1 to ll_size 
		
		if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Name",ls_value ) = -1 then
			MessageBox( "Errore","Reading Subkey value",StopSign! )
		end if	
		
		if ls_value = as_nome_stampante then
			
			if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Name",ls_printer_name ) = -1 then
				MessageBox( "Errore","Reading Subkey value",StopSign! )
			end if	

			if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Printer Driver",ls_driver_name ) = -1 then
				MessageBox( "Errore","Reading Subkey value",StopSign! )
			end if	
			
			if RegistryGet( ls_regkey + "\" + ls_subkeylist[ll_i],"Port",ls_port_name ) = -1 then
				MessageBox( "Errore","Reading Subkey value",StopSign! )
			end if	
			
//			u_freddie.iuo_stampa.of_set_printer_info( ls_driver_name,ls_printer_name,ls_port_name )
			
			return 0
			
		end if	
	next	
end if	

return 0

end function

public subroutine wf_salva_automaticamente ();
integer	li_retvalue

//if (idw_riga.deletedcount() + idw_riga.modifiedcount())  >0 and
if ii_sal_automatico>0 then
	ib_askforsave=FALSE	
	li_retvalue=idw_master.Event ue_update(0,0)

	if li_retvalue>0 then &
		MessageBox("Salvataggio automatico del documento", sqlca.sqlerrtext, Exclamation!)
end if
end subroutine

public function s_des_articolo uf_calc_des_art (long al_id_articolo, long al_id_sog_comm, long al_id_lingua, long al_id_linguaggio, long al_row);
s_des_articolo s_des_art
datastore ds_des_articolo
integer li_ret
decimal ld_lunghezza
string ls_simbolo_um
SetNull(s_des_art.sl_id_des_articolo)

ds_des_articolo=create datastore
ds_des_articolo.dataobject="ds_des_articolo"
ds_des_articolo.settransobject(sqlca)

ld_lunghezza=idw_riga.getitemdecimal(al_row, "riga_documento_dim_l")
ls_simbolo_um=idw_riga.getitemstring(al_row, "unita_misura_b_simbolo")

li_ret=ds_des_articolo.retrieve(al_id_articolo, al_id_sog_comm,&
			al_id_linguaggio, al_id_lingua, ls_simbolo_um, ld_lunghezza)
if li_ret> 0 then
	s_des_art.sl_id_des_articolo=ds_des_articolo.getitemnumber(1, "id_des_articolo")
	s_des_art.ss_codice=ds_des_articolo.getitemstring(1, "codice")
	s_des_art.ss_descrizione=ds_des_articolo.getitemstring(1, "descrizione")
	s_des_art.ss_des_estesa=ds_des_articolo.getitemstring(1, "des_estesa")
end if
destroy ds_des_articolo


RETURN s_des_art

end function

public subroutine wf_metti_descrizione (long al_row);LONG ll_id_lingua, ll_id_linguaGGIO, ll_id_sog_commerciale
long ll_id_articolo
s_des_articolo	s_des_art


ll_id_lingua = idw_gen.GetItemNumber(1, "id_lingua")
ll_id_linguaggio = idw_gen.GetItemNumber(1, "documento_id_linguaggio")
ll_id_sog_commerciale = idw_gen.GetItemNumber(1, "id_sog_commerciale")
ll_id_articolo = idw_riga.GetItemNumber(Al_row, "riga_documento_id_articolo")
s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_commerciale,ll_id_lingua,ll_id_linguaggio, al_row)
idw_riga.SetItem(Al_row,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
idw_riga.SetItem(Al_row,"des_articolo_codice",s_des_art.ss_codice)
idw_riga.SetItem(Al_row,"des_articolo_descrizione", s_des_art.ss_descrizione)
idw_riga.SetItem(Al_row,"des_articolo_des_estesa", s_des_art.ss_des_estesa)

end subroutine

public subroutine wf_clicca_cb_partite ();//
end subroutine

public subroutine wf_set_utedocumento (string ac_operazione);string ls_descrizione
if ac_operazione> " " and il_id_documento > 0 and u_freddie.s_utenti.i_IDUtente > 0 then
	
	ls_descrizione=idw_gen.getitemstring(1, "c_prof_doc_cod")
	ls_descrizione+="-"+right(idw_gen.getitemstring(1, "num_documento"), 16)
	ls_descrizione+="-"+string(idw_gen.getitemdate(1, "data_documento"), "dd/mm/yy")
	ls_descrizione+="-"+idw_gen.getitemstring(1, "c_sog_comm_cod")
	
	
	
	
	INSERT INTO ute_documento (id_utente, id_documento, operazione, dataora, descrizione)
	VALUES (:u_freddie.s_utenti.i_idutente, :il_id_documento, :ac_operazione, Now(), :ls_descrizione)
	;
	
	if (sqlca.sqlcode = -1) then
		messagebox("dberror", sqlca.sqlerrtext)
		rollback;
	else
		commit;
	end if
end if

end subroutine

public function string wf_galv_o_metallo (long al_riga);

return "OK"

//datastore ds_galv
//long ll_righe, ll_id_conto,ll_id_conto_metallo
//integer i
//decimal ldc_tot_galvanica, ldc_tot_metallo, ldc_imp_galvanica
//
//ds_galv=create datastore
//ds_galv.dataobject="ds_tot_galv_e_metallo"
//ds_galv.settransobject(sqlca)
//ll_righe=ds_galv.retrieve(il_id_documento)
//ldc_tot_galvanica=ds_galv.getitemdecimal(ds_galv.rowcount(), "c_tot_galvanica")
//if adc_tot_metallo <> ldc_tot_galvanica then
//	ll_id_conto_metallo=1102
//	ldc_tot_metallo=adc_tot_metallo - ldc_tot_galvanica
//	uf_ins_riga_cp(ll_id_conto_metallo,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_tot_metallo ,0, 0, 0)
//end if
//
//	setnull(ll_id_conto)
//	setnull(ldc_imp_galvanica)
//	ldc_imp_galvanica=ds_galv.getitemdecimal(i, "c_tot_lavorazione")
//	ll_id_conto=ds_galv.getitemnumber(i, "id_conto")
//	uf_ins_riga_cp(ll_id_conto,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_imp_galvanica ,0, 0, 0)
//next
end function

on w_documento_ordine_cx.create
int iCurrent
call super::create
this.cbx_simbolo=create cbx_simbolo
this.cb_contabilizza=create cb_contabilizza
this.cb_calcolatrice=create cb_calcolatrice
this.cbx_cod_barre=create cbx_cod_barre
this.cb_lettore=create cb_lettore
this.cb_stampa_etichette=create cb_stampa_etichette
this.tv_1=create tv_1
this.cb_duplica=create cb_duplica
this.cb_stampa=create cb_stampa
this.p_video=create p_video
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_simbolo
this.Control[iCurrent+2]=this.cb_contabilizza
this.Control[iCurrent+3]=this.cb_calcolatrice
this.Control[iCurrent+4]=this.cbx_cod_barre
this.Control[iCurrent+5]=this.cb_lettore
this.Control[iCurrent+6]=this.cb_stampa_etichette
this.Control[iCurrent+7]=this.tv_1
this.Control[iCurrent+8]=this.cb_duplica
this.Control[iCurrent+9]=this.cb_stampa
this.Control[iCurrent+10]=this.p_video
end on

on w_documento_ordine_cx.destroy
call super::destroy
destroy(this.cbx_simbolo)
destroy(this.cb_contabilizza)
destroy(this.cb_calcolatrice)
destroy(this.cbx_cod_barre)
destroy(this.cb_lettore)
destroy(this.cb_stampa_etichette)
destroy(this.tv_1)
destroy(this.cb_duplica)
destroy(this.cb_stampa)
destroy(this.p_video)
end on

event open;call super::open;
iw_corrente=this
SetPointer(HourGlass!)

This.y = 8


tab_1.tabpage_1.dw_documento_ordine_ff.sharedata(tab_1.tabpage_3.dw_documento_bolla_trasp_ff)
tab_1.tabpage_1.dw_documento_ordine_ff.sharedata(tab_1.tabpage_4.dw_documento_ord_tot_ff)


idw_gen = tab_1.tabpage_1.dw_documento_ordine_ff
idw_riga=  tab_1.tabpage_2.dw_riga_documento_ordine_gd  
idw_riga_tot= tab_1.tabpage_2.dw_riga_documento_dett_ord_ff
idw_gen_trasp=tab_1.tabpage_3.dw_documento_bolla_trasp_ff
idw_scadenza= tab_1.tabpage_4.dw_scadenza_documento_lt
idw_gen_tot= tab_1.tabpage_4.dw_documento_ord_tot_ff
idw_gen_tot_ext = tab_1.tabpage_4.dw_documento_tot_ext_ff
idw_spesa= tab_1.tabpage_4.dw_spesa_documento_gd 
idw_castelletto=tab_1.tabpage_4.dw_cast_iva_documento_lt
idw_contropartita=tab_1.tabpage_5.dw_contr_documento_lt

this.enabled = FALSE

iuo_pag = create uo_esp_pag
idw_master=tab_1.tabpage_1.dw_documento_ordine_ff
idw_master.is_list = Message.PowerObjectParm
Message.Processed=TRUE

is_tipo_documento= idw_master.is_list.s_win_parametri



tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetRowFocusIndicator(tab_1.tabpage_2.p_arrow)

TriggerEvent("ue_tipo_documento")
If Upperbound(idw_master.is_list.s_identifica) = 0  then
	idw_master.is_list.s_modo= modo_inserisci
end if

ib_nonmodale = TRUE
iu_contab_documento = create u_contab_documento

il_doppio_doc=0  



end event

event close;call super::close;if isValid(iuo_pag) then
	destroy iuo_pag
end if	
if isValid(iu_contab_documento) then
	destroy iu_contab_documento
end if	
if isValid(ids_lotti) then
	destroy ids_lotti
end if	

if isValid(ids_doc_lotto) then
	destroy ids_doc_lotto
end if	

if isValid(ids_scar_lotto) then
	destroy ids_scar_lotto
end if	
if isValid(IDS_ANTICIPI) then
	destroy IDS_ANTICIPI
end if	

end event

event ue_post_open;call super::ue_post_open;
if il_row<1 then uf_set_currow()
If Upperbound(idw_master.is_list.s_identifica) > 0 then
	uf_set_documento()
end if
uf_setup_documento()
uf_set_istanze()

tab_1.tabpage_4.dw_cast_iva_documento_lt.event ue_visibilita_campi("V")
iuo_msg_log.uf_new_text("Per scegliere documento esistente cliccare su 'Ricerca ...'.", 4)
iuo_msg_log.uf_new_text("E' possibile utilizzare come filtro il Registro, il Protocollo e la Data di Registrazione.", 4)

this.enabled= TRUE
SetPointer(Arrow!)
this.SetFocus()
idw_gen.SetFocus()

if is_tipo_documento <> "P" then
	idw_gen.Object.tipo_fattura.Protect = 1
end if	


select ges_locazioni
into :is_ges_locazioni
from par_sistema;
select conto_vis_scarico
into :is_conto_vis_scarico
from par_sistema;


//wf_setta_cambio (3,"")




post wf_proponi_profilo(is_tipo_documento)
is_tipo_doc_documento_per_nuovo=is_tipo_documento


string ls_prof, ls_reg, ls_fornitore
long ll_ret, ll_riga_corrente
dwobject dw_o

li_flag=0

if IsValid(idw_master.Is_list.ds_righe_ordine) then
ids_righe_ordine = create datastore
ids_righe_ordine.Dataobject=idw_master.Is_list.ds_righe_ordine.DataObject
ids_righe_ordine = idw_master.Is_list.ds_righe_ordine
ids_righe_ordine.setTransObject(sqlca)
	string ls_des,ls_acc
	long ll_id_prof, ll_val_prop
	if upperbound(idw_master.Is_list.s_aux)=6 then
		
		ls_prof="IMP_PROD"
		ls_reg="Registro"

		select descrizione, id_prof_documento, id_valuta_prop, ric_acconti
		into :ls_des, :ll_id_prof, :ll_val_prop, :ls_acc
		from prof_documento
		where codice='IMP_PROD';
	else
	
	
		select min(codice) 
		into :ls_prof
		from prof_documento
		where tipo_registro='oa';
		
		select min(descrizione)
		into :ls_reg
		from mod_registro
		where tipo_registro='oa';
		
		select descrizione, id_prof_documento, id_valuta_prop, ric_acconti
		into :ls_des, :ll_id_prof, :ll_val_prop, :ls_acc
		from prof_documento
		where codice=:ls_prof;
	
	end if
	
	
	
	ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.GetRow()
	
	ll_ret =tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"c_prof_doc_cod",ls_prof)
	ll_ret =tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"c_registro_des",ls_reg)


   
	
	
   tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"id_prof_documento",ll_id_prof)
	tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"c_prof_doc_des",ls_des)
	tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"prof_documento_ric_acconti",ls_acc)
	tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"id_val_acconto",ll_val_prop)
	tab_1.tabpage_1.dw_documento_ordine_ff.triggerevent("ue_set_prof_fields")
	uf_abilita_contabilizza()
	
	
	
	
	
	

	
	ll_ret =tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"c_sog_comm_cod",idw_master.Is_list.s_aux[1])
	ll_ret =tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"c_sog_comm_des",idw_master.Is_list.s_aux[2])
	ll_ret =tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"id_sog_commerciale",long(idw_master.Is_list.s_aux[3]))
	
	long ll_banca, ll_sog
	string ls_banca
	ll_sog=long(idw_master.Is_list.s_aux[3])
	select id_banca_sog_commerciale
	into :ll_banca
	from sog_commerciale
	where id_sog_commerciale=:ll_sog;
	
	select a.den_abi
	into :ls_banca
	from banca_sog_commerciale b, banca_appoggio a
	where b.id_banca_appoggio=a.id_banca_appoggio and b.id_banca_sog_commerciale=:ll_banca;
	
	ll_ret =tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"id_banca_sog_commerciale",ll_banca)
	ll_ret =tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"c_abi_cab_des",ls_banca)		
	
	wf_azzera_campi_calcolati_sog(tab_1.tabpage_1.dw_documento_ordine_ff.getrow())
			
	choose case uf_check_sospesi()
		case "OK"
			tab_1.tabpage_1.dw_documento_ordine_ff.TriggerEvent("ue_set_sog_fields")
			tab_1.tabpage_1.dw_documento_ordine_ff.postevent("ue_set_contropartita")
				
		case "AVVISA"
			MessageBox("Documento","Cliente Fuori Limite di Fido")
			tab_1.tabpage_1.dw_documento_ordine_ff.TriggerEvent("ue_set_sog_fields")
			tab_1.tabpage_1.dw_documento_ordine_ff.postevent("ue_set_contropartita")
				
		case "BLOCCA"
			MessageBox("Documento","Cliente Fuori Limite di Fido")
			tab_1.tabpage_1.dw_documento_ordine_ff.PostEvent("ue_canc_intestatario")
			
	end choose
	wf_controlla_destinazione(ll_sog)

	
	
	ll_ret =tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"documento_note_intestazione",idw_master.Is_list.s_aux[4])
	If Not(IsNull(idw_master.Is_list.s_aux[5]))or(idw_master.Is_list.s_aux[5]="01/01/1900")or(idw_master.Is_list.s_aux[5]="") then
		ll_ret =tab_1.tabpage_1.dw_documento_ordine_ff.SetItem(ll_riga_corrente,"data_prev_consegna",date(idw_master.Is_list.s_aux[5]))
	end if
	
	il_salvato=0
	this.Controlmenu=false
	cb_nuovo.Visible=false
	cb_ricerca.Visible=false
	
	
end if

DataWindowChild ldw_locazione_1, ldw_locazione_2

tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.GetChild("id_locazione_1", ldw_locazione_1)
ldw_locazione_1.SetTransObject(SQLCA)
ldw_locazione_1.Retrieve()

tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.GetChild("id_locazione_2", ldw_locazione_2)
ldw_locazione_2.SetTransObject(SQLCA)
ldw_locazione_2.Retrieve()

string ls_ora
ls_ora= String(Now(), "hh:mm")
ls_ora=ls_ora+':00'
tab_1.Tabpage_3.dw_documento_bolla_trasp_ff.setitem(1,'documento_ora_trasporto',time(ls_ora))



tab_1.tabpage_4.dw_1.settransobject(sqlca)
tab_1.tabpage_4.dw_1.insertrow(0)
end event

event activate;call super::activate;If not IsValid(u_freddie.iudw_current) then
	u_freddie.iudw_current= idw_master
	
end if

end event

event ue_print;

uf_stampa()
end event

event closequery;long ll_intestatario, ll_prof_documento, ll_count, ll_size
string ls_codice_int, ls_codice_prof, ls_codice, ls_info

ls_info= uf_update_info()
if ls_info <> "" then
	If MessageBox(is_nome_tipo_documento, "Le seguenti tabelle sono state cambiate:" + ls_info +&
							 "~n~n Vuoi salvare le modifiche?", Information!,YesNo!, 1) = 1 then
		if tab_1.tabpage_1.dw_documento_ordine_ff.GetItemStatus(il_row, 0, Primary!)= New! or tab_1.tabpage_1.dw_documento_ordine_ff.GetItemStatus(il_row, 0, Primary!)= NewModified! then
			
			ib_crea_spesa= TRUE
		end if
		TriggerEvent("ue_update")
		
		tab_1.tabpage_4.dw_spesa_documento_gd.SetColumn("percentuale")
	end if
end if

end event

event ue_close;if IsValid(ids_righe_ordine) then
	CloseWithReturn(this, il_salvato)
else
	Close(this)
end if

end event

event ue_retrieve;idw_master.ib_use_scanner=true
idw_master.is_list.s_sql_ident[1]="id_documento"
idw_master.TriggerEvent("ue_retrieve")
end event

type p_msg_log from w_p_data`p_msg_log within w_documento_ordine_cx
boolean visible = true
integer x = 2798
integer y = 32
end type

type p_crescente from w_p_data`p_crescente within w_documento_ordine_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_documento_ordine_cx
end type

type cb_ok from w_p_data`cb_ok within w_documento_ordine_cx
integer x = 37
integer y = 32
end type

event cb_ok::clicked;call super::clicked;
end event

type cb_annulla from w_p_data`cb_annulla within w_documento_ordine_cx
integer x = 329
integer y = 32
end type

type cb_nuovo from w_p_data`cb_nuovo within w_documento_ordine_cx
integer x = 622
integer y = 32
end type

event cb_nuovo::clicked;

tab_1.SelectTab ( 1 )

setnull(is_tipo_documento)
setnull(is_tipo_registro)


uf_nuovo_documento()


uf_abilita_contabilizza()


if isValid(ids_lotti) then
	destroy ids_lotti
end if	

if isValid(ids_riga_doc_lotto) then
	destroy ids_riga_doc_lotto
end if	

if isValid(ids_doc_lotto) then
	destroy ids_doc_lotto
end if	

if isValid(ids_scar_lotto) then
	destroy ids_scar_lotto
end if	
if isValid(ids_ANTICIPI) then
	destroy ids_ANTICIPI
end if	



idw_gen.object.tipo_fattura.protect = 0
idw_gen.object.tipo_fattura.background.color = 16777215
tab_1.tabpage_1.visible= true
tab_1.tabpage_1.enabled= true
tab_1.tabpage_2.visible= true
tab_1.tabpage_2.enabled= true
tab_1.tabpage_3.visible= true
tab_1.tabpage_3.enabled= true
tab_1.tabpage_4.visible= true
tab_1.tabpage_4.enabled= true
tab_1.tabpage_5.visible= true
tab_1.tabpage_5.enabled= true
wf_proponi_profilo(is_tipo_doc_documento_per_nuovo)

il_doppio_doc = 0 


string ls_ora
ls_ora= String(Now(), "hh:mm")
ls_ora=ls_ora+':00'
tab_1.Tabpage_3.dw_documento_bolla_trasp_ff.setitem(1,'documento_ora_trasporto',time(ls_ora))




end event

type cb_inserisci from w_p_data`cb_inserisci within w_documento_ordine_cx
integer x = 1531
integer y = 32
integer width = 233
end type

type cb_cancella from w_p_data`cb_cancella within w_documento_ordine_cx
integer x = 1792
integer y = 32
integer width = 233
end type

event cb_cancella::clicked;


long	ll_retval,ll_row,ll_id_lotto, ll_id_r_lotto, ll_lotto_trovato, ll_lotto_trovato2
integer li_ret
decimal ld_val_scar, ldt_qta_scar_attuale, ld_qta_iniz
string ls_tipo

w_p_data  lw_win
u_dw_main lu_dw

s_par_record	lstr_par_documento

if u_freddie.iudw_current=tab_1.tabpage_2.dw_riga_documento_ordine_gd then
	ll_row=tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetRow()
	if wf_cancella_lotti(ll_row)<0 then return
end if




ll_row	= tab_1.tabpage_1.dw_documento_ordine_ff.GetRow()
lstr_par_documento.nome_tabella			= "documento"
lstr_par_documento.nome_id_tabella		= "id_documento"
lstr_par_documento.id_tabella				= il_id_documento
lstr_par_documento.visible					= false

If not(idw_gen.GetItemStatus(il_row,0,Primary!) = NewModified! OR idw_gen.GetItemStatus(il_row,0,Primary!) = New!) then
	lw_win = u_freddie.iw_current
	lu_dw = u_freddie.iudw_current
	if isValid(lu_dw) then
		if isValid(lu_dw.iudw_parent) then
			if not lu_dw.ib_dw_shared then
				if lu_dw.RowCount() >0 then
					parent.triggerevent("ue_delete")
				end if
			end if
		else
			
			if not tab_1.tabpage_1.dw_documento_ordine_ff.getconfirm(1) then
				return
			end if
			
			
			
			if isvalid(ids_scar_lotto) or isvalid(ids_lotti) then
				for li_ret= 1 to idw_riga.rowcount()
					wf_cancella_lotti(li_ret)
				next
			end if
			//20261028 partite (orafo): le salva la finestra di cancellazione, nella stessa transazione
			if isvalid(ids_par_aper_partita) and isvalid(ids_par_scar_partita) then
				lstr_par_documento.s_dw_aper_partita = ids_par_aper_partita
				lstr_par_documento.s_dw_scar_partita = ids_par_scar_partita
			end if
			OpenWithParm(w_utl_cancella_documento_wz,lstr_par_documento )
			ll_retval	= Message.DoubleParm

			
			
			choose case ll_retval
				case 0
					tab_1.tabpage_1.dw_documento_ordine_ff.SetFocus()
				case 1
					tab_1.tabpage_1.dw_documento_ordine_ff.trigger event ue_deletestart()	
					if tab_1.tabpage_1.dw_documento_ordine_ff.rowcount()>0 then 

						tab_1.tabpage_1.dw_documento_ordine_ff.reset()
						if isvalid(ids_riga_doc_lotto) then
							ids_riga_doc_lotto.update()
							destroy ids_riga_doc_lotto
						end if
						if isvalid(ids_scar_lotto) then 
							ids_scar_lotto.update()
							destroy ids_scar_lotto
						end if							
						if isvalid(ids_lotti) then 
							ids_lotti.update()
							destroy ids_lotti
						end if							
					end if
					
					
					cb_nuovo.event clicked()
					
			end choose
			
		end if
	end if
end if

end event

type cb_salva from w_p_data`cb_salva within w_documento_ordine_cx
integer x = 2048
integer y = 32
integer width = 233
end type

event cb_salva::clicked;long ll_intestatario, ll_prof_documento, ll_count, ll_size
string ls_codice_int, ls_codice_prof, ls_codice, ls_info



ls_info= uf_update_info()
if ls_info <> "" then
	If MessageBox(is_nome_tipo_documento, "Le seguenti tabelle sono state cambiate:" + ls_info +&
							 "~n~n Vuoi salvare le modifiche?", Information!,YesNo!, 1) = 1 then
		if tab_1.tabpage_1.dw_documento_ordine_ff.GetItemStatus(il_row, 0, Primary!)= New! or tab_1.tabpage_1.dw_documento_ordine_ff.GetItemStatus(il_row, 0, Primary!)= NewModified! then
			
			ib_crea_spesa= TRUE
		end if
		//290408 aggiunta perché a volte non ricalcola le spese nel castelletto
		//20261012 se le righe vanno salvate e il discendente ricalcola il castelletto nel loro updatestart, qui sarebbe un doppione
		if not ib_cast_in_updatestart_righe then
			tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)
		elseif tab_1.tabpage_2.dw_riga_documento_ordine_gd.ModifiedCount() + tab_1.tabpage_2.dw_riga_documento_ordine_gd.DeletedCount() = 0 then
			tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)
		end if
		//fine 290408
		parent.TriggerEvent("ue_update")
		wf_calcola_spese('N')

		tab_1.tabpage_4.dw_spesa_documento_gd.SetColumn("percentuale")
	end if
else
	parent.TriggerEvent("ue_update")
	wf_calcola_spese('N')
	
end if
end event

type tab_1 from w_p_data`tab_1 within w_documento_ordine_cx
integer x = 32
integer y = 156
integer width = 2944
integer height = 1760
integer taborder = 70
long backcolor = 79741120
boolean multiline = true
alignment alignment = center!
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
this.Control[iCurrent+4]=this.tabpage_5
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event tab_1::selectionchanging;call super::selectionchanging;

UserObject		luo_page
string			ls_pagename, ls_null
long				ll_id_sog_commerciale
long				ll_id_profilo
long 				ll_row
decimal 			ldc_null

luo_page = control[newindex]
ls_pagename = luo_page.classname()

ll_row = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()

choose case ls_pagename
	case "tabpage_1"
		
		if is_tipo_documento = "P" AND is_blocco="" AND (not(IsNull(il_row) OR il_row =0)) then
			SetNull(ldc_null)
			SetNull(ls_null)
			tab_1.tabpage_1.dw_documento_ordine_ff.Post Event ue_calc_totale(ls_null, ldc_null,ldc_null)
		end if
	case "tabpage_2"
			uf_wizard_riga()
	case "tabpage_3"
		string ls_ora_trasporto, ls_data_trasporto
		
		ls_data_trasporto = string(tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemdate(ll_row, "data_trasporto"))
				
		if (ls_data_trasporto = "") or (isnull(ls_data_trasporto)) then
			tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem(ll_row, "data_trasporto", Today())
		end if
		
	case "tabpage_4"
		
		if (idw_riga.deletedcount() + idw_riga.modifiedcount() > 0) then
			wf_calcola_spese('N')
			
			SetPointer(HourGlass!)
			tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)
			uf_report_righe()
			SetPointer(Arrow!)
		end if
		
		
	case "tabpage_5"
		If idw_castelletto.RowCount() =0 AND is_blocco="" then
			SetPointer(HourGlass!)
			tab_1.tabpage_4.dw_cast_iva_documento_lt.TriggerEvent("ue_calc_cast_iva")
			tab_1.tabpage_5.dw_contr_documento_lt.TriggerEvent("ue_calc_contropartita")
			uf_report_righe()

			SetPointer(Arrow!)
		end if
end choose
if newindex = 2 then
	cb_lettore.enabled = TRUE
	cb_stampa_etichette.enabled = True
else
	cb_lettore.enabled = FALSE
	cb_stampa_etichette.enabled = FALSE
end if
end event

event tab_1::selectionchanged;call super::selectionchanged;
UserObject		luo_page
string			ls_pagename, ls_null
decimal 			ldc_null

luo_page = control[newindex]
ls_pagename = luo_page.classname()

choose case ls_pagename
	case "tabpage_3"
		If luo_page.enabled = FALSE then
			SelectTab(tabpage_4)
		end if

	case "tabpage_4"
		If luo_page.enabled = FALSE then
			SelectTab(tabpage_1)
		end if
end choose

long ll_riga_corrente, a, b
decimal ld_netto_tot, ld_lordo_tot,  ld_num_colli, ld_colli, ld_lordo, ld_netto

//If newindex=3 then
//	//wf_cal_pesi_colli(true)
//end if
//	if newindex=2 and oldindex=1 then
//			
//			
//	end if


long ll_id_causale
if newindex=2   and not isvalid(ids_riga_doc_lotto) then
	ll_id_causale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_caus_magazzino")
	
	
	wf_gestisci_lotti(ll_id_causale, 1)
	
end if
post wf_tipo_prezzi()

//char ls_vetro
//select vetrerie
//into :ls_vetro
//from pers_par_sistema;
//
//if newindex=2 and ls_vetro = 'S' and not isvalid(ids_riga_doc_lotto) then
//	tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_riga_doc_vetro_ordine_gd"
//	tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.dataobject="d_riga_doc_vetro_dett_ord_ff"
//	tab_1.tabpage_2.dw_riga_documento_ordine_gd.settransobject(sqlca)
//	tab_1.tabpage_2.dw_riga_documento_ordine_gd.event trigger ue_retrieve(0,0)
//	
//	ids_riga_doc_lotto=create datastore
//	ids_riga_doc_lotto.dataobject="ds_riga_doc_ritorno_gd"
//	ids_riga_doc_lotto.settransobject(sqlca)
//	ids_riga_doc_lotto.retrieve()		
//end if



if newindex = 2 then
	cb_calcolatrice.enabled = true
else
	cb_calcolatrice.enabled = false
end if

end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 2907
integer height = 1640
long backcolor = 79741120
string text = "Generale"
long tabbackcolor = 79741120
cb_deriva cb_deriva
cb_blocco cb_blocco
cb_note cb_note
cb_cerca_anticipi cb_cerca_anticipi
dw_documento_ordine_ff dw_documento_ordine_ff
end type

on tabpage_1.create
this.cb_deriva=create cb_deriva
this.cb_blocco=create cb_blocco
this.cb_note=create cb_note
this.cb_cerca_anticipi=create cb_cerca_anticipi
this.dw_documento_ordine_ff=create dw_documento_ordine_ff
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_deriva
this.Control[iCurrent+2]=this.cb_blocco
this.Control[iCurrent+3]=this.cb_note
this.Control[iCurrent+4]=this.cb_cerca_anticipi
this.Control[iCurrent+5]=this.dw_documento_ordine_ff
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_deriva)
destroy(this.cb_blocco)
destroy(this.cb_note)
destroy(this.cb_cerca_anticipi)
destroy(this.dw_documento_ordine_ff)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_documento_ordine_cx
integer x = 1243
integer y = 32
integer taborder = 10
end type

event cb_ricerca::clicked;tab_1.selecttab(1)
if isValid(ids_lotti) then
	destroy ids_lotti
end if	

if isValid(ids_riga_doc_lotto) then
	destroy ids_riga_doc_lotto
end if	

if isValid(ids_doc_lotto) then
	destroy ids_doc_lotto
end if	

if isValid(ids_scar_lotto) then
	destroy ids_scar_lotto
end if	
if isValid(ids_ANTICIPI) then
	destroy ids_ANTICIPI
end if	

uf_ricerca()

if is_tipo_documento = "P" then
		idw_gen.object.tipo_fattura.protect = 1
		idw_gen.object.tipo_fattura.background.color = 12632256
else
		idw_gen.object.tipo_fattura.protect = 0
		idw_gen.object.tipo_fattura.background.color = 16777215
end if
ib_genera_castelletto= TRUE
post uf_report_righe()
post wf_tipo_prezzi()
post wf_trova_causale(idw_gen, "LOTTI") 

POST WF_PROTEGGI_ACCONTO()

tab_1.tabpage_4.dw_1.setitem(1,'data_dec_pag',tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(1,'documento_data_dec_pagamento'))
parent.triggerevent("ue_tipo_documento")
end event

type cb_deriva from commandbutton within tabpage_1
event clicked pbm_bnclicked
integer x = 2336
integer y = 1292
integer width = 256
integer height = 84
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Deriva ..."
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

OpenWithParm(lw_1, ls_par, "w_check_deriva_wz")
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
		OpenWithParm(lw_1, ls_par2, "w_deriva2_wz")
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
						(ll_row, "sconto_fin_incondizionato",	dec(wf_decode_key(12,ls_appoggio)) )
				
				
				wf_setta_cambio(3,"")
		
				
				tab_1.tabpage_1.dw_documento_ordine_ff.event ue_set_calc_fields()
						
				tab_1.selecttab(2)		
				uf_importa_righe (ls_par3)
				
				
				

		end if
end if



end event

type cb_blocco from commandbutton within tabpage_1
event clicked pbm_bnclicked
integer x = 2336
integer y = 1392
integer width = 256
integer height = 80
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Blocco ..."
end type

event clicked;
long				ll_row, ll_id_documento, ll_id_azienda, ll_id_prof_documento
char				lch_stato[]
dwItemStatus 	l_itemstatus
s_any_array 	lstr_array

ll_row = il_row
l_itemstatus = idw_gen.GetItemStatus(ll_row, 0, Primary!)
IF (l_itemstatus = New! OR l_itemstatus = NewModified!) THEN
	Return
END IF	
lch_stato= uf_calc_stato_doc()

lstr_array.s_array[1] = idw_gen.GetItemNumber(ll_row, "id_documento")
lstr_array.s_array[2] = idw_gen.GetItemNumber(ll_row, "id_prof_documento")
lstr_array.s_array[3] = idw_gen.GetItemNumber(ll_row, "documento_id_azienda")
lstr_array.s_array[4] = lch_stato[1]
lstr_array.s_array[5] = lch_stato[2]
lstr_array.s_array[6] = lch_stato[3]
lstr_array.s_array[7] = lch_stato[4]
lstr_array.s_array[8] = lch_stato[5]
lstr_array.s_array[9] = lch_stato[6]

OpenWithParm(w_blocco_docum_wz, lstr_array)

lstr_array= Message.PowerObjectParm

idw_gen.SetItem(ll_row, "bloccato",lstr_array.s_array[1])
idw_gen.SetItem(ll_row, "documento_chius_forzata",lstr_array.s_array[2])
idw_gen.SetItem(ll_row, "documento_contabilizzato",lstr_array.s_array[3])
idw_gen.SetItem(ll_row, "documento_evaso_totalmente",lstr_array.s_array[4])
idw_gen.SetItem(ll_row, "documento_sospeso",lstr_array.s_array[5])
idw_gen.SetItem(ll_row, "documento_stampato",lstr_array.s_array[6])

uf_blocco_documento()



end event

type cb_note from commandbutton within tabpage_1
integer x = 2336
integer y = 1164
integer width = 256
integer height = 84
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Altro ..."
end type

event clicked;
string 		ls_note
long 			ll_id_prof_doc
string 		ls_array[]
s_any_array lstr_array

ls_array[2] = idw_gen.uf_get_colval("id_documento")  
ls_array[3] = idw_gen.uf_get_colval("id_prof_documento")   
ls_array[4] = idw_gen.uf_get_colval("id_registro")  
ls_array[5] = idw_gen.uf_get_colval("num_progressivo")  
ls_array[6] = idw_gen.uf_get_colval("data_registrazione")  
ls_array[7] = idw_gen.uf_get_colval("num_documento")
ls_array[8] = idw_gen.uf_get_colval("data_documento")  
ls_array[9] = idw_gen.uf_get_colval("documento_data_competenza")  
ls_array[10] = idw_gen.uf_get_colval("id_sog_commerciale")  
ls_array[12] = idw_gen.uf_get_colval("documento_id_caus_magazzino")   
ls_array[13] = idw_gen.uf_get_colval("documento_id_locazione_1")  
ls_array[14] = idw_gen.uf_get_colval("documento_id_locazione_2")  
ls_array[15] = idw_gen.uf_get_colval("documento_id_sog_commerciale_fattura")  
ls_array[16] = idw_gen.uf_get_colval("id_lingua")  
ls_array[17] = idw_gen.uf_get_colval("documento_id_linguaggio")   
ls_array[21] = idw_gen.uf_get_colval("documento_id_listino")
ls_array[22] = idw_gen.uf_get_colval("id_con_pagamento")  
ls_array[23] = idw_gen.uf_get_colval("id_banca_sog_commerciale")  
ls_array[24] = idw_gen.uf_get_colval("id_gruppo_agenti")  

ls_array[26] = idw_gen.uf_get_colval("documento_interlocutore")   

ls_array[28] = idw_gen.uf_get_colval("documento_note_intestazione")  
ls_array[35] = idw_gen.uf_get_colval("id_tipo_trasporto")   
ls_array[36] = idw_gen.uf_get_colval("documento_id_caus_trasporto")  
ls_array[39] = idw_gen.uf_get_colval("documento_id_sog_commerciale_vettore")  
ls_array[40] = idw_gen.uf_get_colval("documento_id_sog_commerciale_vettore_2")  


ls_array[56] = idw_gen.uf_get_colval("data_scadenza")  


ls_array[65] = idw_gen.uf_get_colval("id_documento_padre")
ls_array[66] = idw_gen.uf_get_colval("id_prof_registrazione")
ls_array[67] = idw_gen.uf_get_colval("des_contabile")
if idw_gen.uf_get_colval("tipo_fattura")= "N" then 
	is_ric_documento = is_ric_documento + "N"
else
	is_ric_documento = is_ric_documento + "O"
end if
ls_array[71] = is_ric_documento
if IsValid(u_freddie.iw_current) then 
	ls_array[72] =	u_freddie.iw_current.title
else
	ls_array[72] =	idw_gen.is_title
end if
ls_array[73] = idw_gen.uf_get_colval("c_prof_doc_cod" )
ls_array[74] = idw_gen.uf_get_colval("c_prof_doc_des" )
ls_array[75] = idw_gen.uf_get_colval("c_registro_des" )
ls_array[76] = idw_gen.uf_get_colval("c_registro" )

	ls_array[85] = idw_gen.uf_get_colval("documento_id_listino")
	ls_array[86] = idw_gen.uf_get_colval("documento_id_variazione")
	
ls_array[87] = idw_gen.uf_get_colval("data_ric_consegna") 

lstr_array.s_array= ls_array
OpenWithParm(w_documento_ordine_wz, lstr_array)
lstr_array= Message.PowerObjectParm
ls_array=lstr_array.s_array
tab_1.tabpage_1.dw_documento_ordine_ff.event ue_set_wz_fields(ls_array)


idw_gen.SetFocus()
tab_1.tabpage_1.dw_documento_ordine_ff.TriggerEvent("ue_set_calc_fields")


end event

type cb_cerca_anticipi from commandbutton within tabpage_1
integer x = 2601
integer y = 1532
integer width = 256
integer height = 80
integer taborder = 12
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anticipi"
end type

event clicked;long  ll_id_reg, ll_id_doc_scar_ant
string ls_tipo_reg
s_anticipi s_l_anticipi
integer ret

if idw_gen.getrow()>0 then
	s_l_anticipi.s_ll_id_doc=idw_gen.getitemnumber(1, "id_documento")
	if isnull(s_l_anticipi.s_ll_id_doc) then
		ret=messagebox("Attenzione", "Occorre salvare il documento prima di gestire gli anticipi. Salvarlo?")
		if ret=1 then
			cb_salva.triggerevent(clicked!)
			s_l_anticipi.s_ll_id_doc=idw_gen.getitemnumber(1, "id_documento")
			if isnull(s_l_anticipi.s_ll_id_doc) then return
		else
			return
		end if
	end if
	
	
	s_l_anticipi.s_ll_id_tipo_pagamento=idw_gen.getitemnumber(1, "id_sog_commerciale")
	if s_l_anticipi.s_ll_id_tipo_pagamento>0 then
		ll_id_reg=idw_gen.getitemnumber(1, "id_registro")
		if ll_id_reg>0 then
			select tipo_registro
			into :ls_tipo_reg
			from registro
			where id_registro= :ll_id_reg;
			if sqlca.sqlcode=0 then
				if (ls_tipo_reg='IV' or ls_tipo_reg='IC') and &
					NOT((idw_gen.describe("imp_acconto.protect")='0'  and idw_gen.getitemdecimal(1, "IMP_ACCONTO")>0)) then
					if not isvalid(ids_anticipi) then 
						ids_anticipi=create datastore
						ids_anticipi.dataobject="ds_anticipi"
						ids_anticipi.settransobject(sqlca)
						ids_anticipi.retrieve()
					end if
					s_l_anticipi.sds_anticipi=ids_anticipi
					s_l_anticipi.s_ld_cambio_doc=idw_gen.getitemdecimal(1, "documento_cambio")
					
					s_l_anticipi.s_id_valuta=idw_gen.getitemnumber(1, "documento_id_valuta_des")
		
					openwithparm(w_cerca_anticipo_rp, s_l_anticipi)
					if not isvalid(message.powerobjectparm) then return
					s_l_anticipi=message.powerobjectparm
					if s_l_anticipi.s_ld_imp_acconto>0 then
	   				idw_gen.setitem(1, "imp_acconto", s_l_anticipi.s_ld_imp_val_doc)
						idw_gen.Modify("imp_acconto_text.text = '" + String(s_l_anticipi.s_ld_imp_acconto) + "'") 
						idw_gen.setitem(1, "id_val_acconto", s_l_anticipi.s_ll_id_val_acconto)
						idw_gen.setitem(1, "id_tab_iva_acconto", s_l_anticipi.s_ll_id_iva_acconto)
						idw_gen.setitem(1, "id_tipo_pag_acconto", s_l_anticipi.s_ll_id_tipo_pagamento)
						il_id_doc_anticipo=s_l_anticipi.s_ll_id_doc_anticipi
						ids_anticipi=s_l_anticipi.sds_anticipi
						idw_gen.modify("imp_acconto.protect=1")
						idw_gen.modify("imp_acconto.background.color=12632256")
						
						tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)
						
						
						idw_gen.setitem(1, "imp_avanzo_acconto", s_l_anticipi.s_ld_avanzo_cambio)
						 wf_setta_cambio(3, "")		
					else
						ids_anticipi=s_l_anticipi.sds_anticipi
					end if
				END IF
				
			Else
				messagebox("Errore", "Non trovato il registro attuale")
			end if
		end if
	end if
end if
end event

type dw_documento_ordine_ff from u_dw_master_main within tabpage_1
event type integer ue_set_sog_fields ( )
event type integer ue_set_prof_fields ( )
event ue_set_calc_fields ( )
event ue_set_not_new ( )
event ue_set_regi_fields ( )
event ue_set_valu_fields ( string as_data )
event ue_canc_intestatario ( )
event ue_set_sp_incasso ( )
event ue_set_registro ( )
event ue_set_esercizio ( )
event ue_reset ( )
event type decimal ue_calc_totale ( string as_sc_finanziario,  decimal adc_sc_fin_cassa,  decimal adc_sconto_fin_inc )
event type integer ue_set_wz_fields ( string as_array[] )
event type integer ue_set_contropartita ( )
event ue_set_con_pagamento ( )
event ue_deletestart ( )
integer x = 18
integer y = 4
integer width = 2912
integer height = 1636
integer taborder = 1
string dataobject = "d_documento_ordine_ff"
string icon = "AppIcon!"
borderstyle borderstyle = stylebox!
end type

event type integer ue_set_sog_fields();
long			ll_id_sog_commerciale, ll_id_tab_iva, ll_id_valuta,ll_id_dest,ll_id_listino,ll_id_var
string	 	ls_info, ls_cod
date ldt_data_doc
u_setta_campi_documento uo_set_doc
uo_set_doc=create u_setta_campi_documento

ll_id_sog_commerciale= GetItemNumber(il_row, "id_sog_commerciale")
if not (IsNull(ll_id_sog_commerciale) OR ll_id_sog_commerciale = 0) then
	ll_id_tab_iva=uo_set_doc.uf_setta_campi_sog_com(dw_documento_ordine_ff, il_row, ll_id_sog_commerciale)
	ll_id_valuta=getItemnumber(il_row,"documento_id_valuta_des")
	if not (IsNull(ll_id_valuta) OR ll_id_valuta = 0) then 
		TriggerEvent("ue_set_valu_fields")
	end if
	ls_info= f_info_sc(ll_id_sog_commerciale)
	SetItem(il_row,"cinfo", ls_info)
	wf_integra_campi_sog_com(ll_id_tab_iva)
	select codice
	into :ls_cod
	from dba.azienda
	;
	select id_destinazione
	into :ll_id_dest
	from dba.destinazione
	where id_sog_commerciale=:ll_id_sog_commerciale
	and ins_automatico_in_doc ='S'
	;
	if ll_id_dest>0 then
		setitem(il_row, "id_destinazione",ll_id_dest)
	end if
	//20250217 inserisco anche lìid_variazione legato al soggetto se c'è
	select id_listino into :ll_id_listino from dba.sog_commerciale where id_sog_commerciale=:ll_id_sog_commerciale;
	if ll_id_listino>0 then
		ldt_data_doc=idw_gen.getitemdate(1, "data_documento")
		if isnull(ldt_data_doc) then ldt_data_doc=date(today())
		select id_variazione into :ll_id_var from dba.variazione where id_listino=:ll_id_listino and data_inizio<=:ldt_data_doc and data_fine>=:ldt_data_doc;
		if ll_id_var>0 then idw_gen.setitem(1, "documento_id_variazione", ll_id_var)
	end if
	//fine 20250217
	
//	if ll_id_sog_commerciale=510 and ls_cod="SILVERDR" then
//		select id_destinazione 
//		into :ll_id_dest
//		from dba.destinazione
//		where id_sog_commerciale=:ll_id_sog_commerciale
//		and codice=2
//		;
//		if ll_id_dest>0 then
//			setitem(il_row, "id_destinazione",ll_id_dest)
//		end if
//	end if
	
end if
if this.getitemnumber(1,'id_documento')>0 then 
	wf_calcola_spese('S')
end if

TriggerEvent("ue_set_calc_fields")
event ue_set_sp_incasso()
event ue_set_con_pagamento()
post event ue_set_contropartita()
destroy uo_set_doc
return 0
end event

event type integer ue_set_prof_fields();

long ll_id_prof
string ls_ric_id_registro, ls_ric_num_progressivo, ls_ric_num_documento, ls_ric_id_caus_magazzino
string ls_ric_id_sog_comm, ls_ric_id_con_pagamento, ls_ric_id_sog_comm_agente, ls_ric_id_tipo_trasporto
string ls_ric_id_valuta, ls_ric_id_sog_comm_vettore_1, ls_note_intestazione_prop, ls_fat_anticipo
string ls_aspetto_beni_prop, ls_trasp_mezzo_prop
long ll_id_caus_magazzino_prop, ll_id_sog_comm_prop, ll_id_valuta_prop, ll_id_con_pagamento_prop, ll_id_sog_comm_vettore_1_prop
long ll_id_magazzino_1_prop, ll_id_magazzino_2_prop, ll_id_sog_comm_fattura_prop, ll_id_linguaggio_prop
long ll_id_lingua_prop, ll_id_prof_registrazione, ll_id_caus_trasporto_prop
long ll_id_locazione_1_prop,ll_id_locazione_2_prop
decimal 	ldc_quantita_prop_riga
string ls_ric_id_unita_confezione_riga ,ls_ric_pesi_riga ,ls_ric_data_prev_consegna_riga 
string ls_ric_locazione_2_riga ,ls_ric_locazione_1_riga ,ls_ric_id_caus_magazzino_riga ,ls_ric_unita_prezzo_riga ,ls_ric_unita_base_riga ,ls_ric_quantita_riga 
string ls_ric_id_tab_iva_riga ,ls_ric_sconto_riga_riga ,ls_ric_prezzo_netto_riga ,ls_ric_sconto_riga ,ls_ric_prezzo_riga ,ls_ric_id_listino_riga ,ls_ric_id_valuta_riga ,ls_ric_colli_riga ,ls_ric_dim_riga 
string ls_ric_contropartite_riga ,ls_ric_date_competenza_riga ,ls_ric_val_attribuito_riga ,ls_ric_provvigioni_riga ,ls_ric_id_sog_comm_agente_riga 
string ls_ric_id_caus_trasporto ,ls_ric_volumi 
string ls_ric_pesi ,ls_ric_colli_documento ,ls_ric_data_trasporto ,ls_ric_trasp_mezzo ,ls_ric_asp_beni 
string ls_ric_id_magazzino_1 , ls_ric_id_magazzino_2, ls_ric_id_sog_comm_fattura, ls_ric_id_listino
string ls_tipo_fattura, ls_des_contabile
string ls_esercizio,ls_ric_tipo_fattura,ls_ric_data_documento

string ls_dispo, ls_scorta

string ls_ric_id_sog_comm_vettore_2
long	ll_id_sog_comm_vettore_2_prop

string ls_ric_data_scadenza


long ll_ret, ll_id_iva_proposta
datastore ds_profilo
ds_profilo=create datastore
ds_profilo.dataobject='ds_prof_documento'
ds_profilo.settransobject(sqlca)

ll_id_prof=GetItemNumber(il_row, "id_prof_documento")

ll_ret=ds_profilo.retrieve(ll_id_prof)
if ll_ret<=0 then 
	messagebox('Attenzione', "Ci sono problemi nel profilo selezionato, ripetere l'operazione o contattare il fornitore")
else 
   ls_ric_id_registro=ds_profilo.getitemstring(1,'ric_id_registro')
   ls_ric_num_progressivo=ds_profilo.getitemstring(1,'ric_num_progressivo')
	ls_ric_num_documento=ds_profilo.getitemstring(1,'ric_num_documento')
	ls_ric_id_caus_magazzino=ds_profilo.getitemstring(1,'ric_id_caus_magazzino')
	ls_ric_id_sog_comm=ds_profilo.getitemstring(1,'ric_id_sog_comm')
	ls_ric_id_con_pagamento=ds_profilo.getitemstring(1,'ric_id_con_pagamento') 
	ls_ric_id_sog_comm_agente=ds_profilo.getitemstring(1,'ric_id_sog_comm_agente')
	ls_ric_id_tipo_trasporto=ds_profilo.getitemstring(1,'ric_id_tipo_trasporto')
	ls_ric_id_valuta=ds_profilo.getitemstring(1,'ric_id_valuta')
	ls_ric_id_sog_comm_vettore_1=ds_profilo.getitemstring(1,'ric_id_sog_comm_vettore_1')
	ls_ric_colli_documento=ds_profilo.getitemstring(1,'ric_colli_documento')
	ls_ric_pesi=ds_profilo.getitemstring(1,'ric_pesi')
	ls_ric_volumi=ds_profilo.getitemstring(1,'ric_volumi')
	ls_ric_id_caus_trasporto=ds_profilo.getitemstring(1,'ric_id_caus_trasporto')
	ls_ric_asp_beni=ds_profilo.getitemstring(1,'ric_asp_beni')
	ls_ric_trasp_mezzo=ds_profilo.getitemstring(1,'ric_trasp_mezzo')
	ls_ric_data_trasporto=ds_profilo.getitemstring(1,'ric_data_trasporto')
	is_stato_scad_generata=ds_profilo.getitemstring(1,'stato_scad_generata')
	is_con_data_progressiva=ds_profilo.getitemstring(1,'con_data_progressiva')
	ls_tipo_fattura=ds_profilo.getitemstring(1,'tipo_fattura')
	ls_trasp_mezzo_prop=ds_profilo.getitemstring(1,'trasp_mezzo_prop')
	ls_aspetto_beni_prop=ds_profilo.getitemstring(1,'aspetto_beni_prop')
	il_id_mod_registro=ds_profilo.getitemnumber(1,'id_mod_registro_prop')
	ls_note_intestazione_prop=ds_profilo.getitemstring(1,'note_intestazione_prop')
	ll_id_caus_magazzino_prop=ds_profilo.getitemnumber(1,'id_caus_magazzino_prop')
	ll_id_sog_comm_prop=ds_profilo.getitemnumber(1,'id_sog_comm_prop')
	ll_id_locazione_1_prop=ds_profilo.getitemnumber(1,'id_locazione_1_prop')
	ll_id_locazione_2_prop=ds_profilo.getitemnumber(1,'id_locazione_2_prop')
	ll_id_sog_comm_fattura_prop=ds_profilo.getitemnumber(1,'id_sog_comm_fattura_prop')
	ll_id_linguaggio_prop=ds_profilo.getitemnumber(1,'id_linguaggio_prop')
	ll_id_valuta_prop=ds_profilo.getitemnumber(1,'id_valuta_prop')
	ll_id_con_pagamento_prop=ds_profilo.getitemnumber(1,'id_con_pagamento_prop')
	ll_id_sog_comm_vettore_1_prop=ds_profilo.getitemnumber(1,'id_sog_comm_vettore_1_prop')
	ll_id_lingua_prop=ds_profilo.getitemnumber(1,'id_lingua_prop')
	
	ls_aspetto_beni_prop=ds_profilo.getitemstring(1,'aspetto_beni_prop')
	ls_trasp_mezzo_prop=ds_profilo.getitemstring(1,'trasp_mezzo_prop')
	is_int_consentiti=ds_profilo.getitemstring(1,'int_consentiti')
	ls_des_contabile=ds_profilo.getitemstring(1,'des_contabile')
	ll_id_prof_registrazione=ds_profilo.getitemnumber(1,'id_prof_registrazione')
	ls_ric_id_magazzino_1=ds_profilo.getitemstring(1,'ric_id_magazzino_1')
	ls_ric_id_magazzino_2=ds_profilo.getitemstring(1,'ric_id_magazzino_2')
	ls_ric_id_sog_comm_fattura=ds_profilo.getitemstring(1,'ric_id_sog_comm_fattura')
	ls_ric_id_listino=ds_profilo.getitemstring(1,'ric_id_listino')
	ls_ric_id_unita_confezione_riga=ds_profilo.getitemstring(1,'ric_id_unita_confezione_riga')
	ls_ric_quantita_riga=ds_profilo.getitemstring(1,'ric_quantita_riga')
	ldc_quantita_prop_riga=ds_profilo.getitemdecimal(1,'quantita_prop_riga')
	ls_ric_unita_base_riga=ds_profilo.getitemstring(1,'ric_unita_base_riga')
	ls_ric_unita_prezzo_riga=ds_profilo.getitemstring(1,'ric_unita_prezzo_riga')
	ls_ric_id_caus_magazzino_riga=ds_profilo.getitemstring(1,'ric_id_caus_magazzino_riga')
	ls_ric_locazione_1_riga=ds_profilo.getitemstring(1,'ric_locazione_1_riga')
	ls_ric_locazione_2_riga=ds_profilo.getitemstring(1,'ric_locazione_2_riga')
	ls_ric_data_prev_consegna_riga=ds_profilo.getitemstring(1,'ric_data_prev_consegna_riga')
	ls_ric_pesi_riga=ds_profilo.getitemstring(1,'ric_pesi_riga')
	ls_ric_dim_riga=ds_profilo.getitemstring(1,'ric_dim_riga')
	ls_ric_colli_riga=ds_profilo.getitemstring(1,'ric_colli_riga')
	ls_ric_id_valuta_riga=ds_profilo.getitemstring(1,'ric_id_valuta_riga')
	ls_ric_id_listino_riga=ds_profilo.getitemstring(1,'ric_id_listino_riga')
	ls_ric_prezzo_riga=ds_profilo.getitemstring(1,'ric_prezzo_riga')
	ls_ric_sconto_riga=ds_profilo.getitemstring(1,'ric_sconto_riga')
	ls_ric_prezzo_netto_riga=ds_profilo.getitemstring(1,'ric_prezzo_netto_riga')
	ls_ric_sconto_riga_riga=ds_profilo.getitemstring(1,'ric_sconto_riga_riga')
	ls_ric_id_tab_iva_riga=ds_profilo.getitemstring(1,'ric_id_tab_iva_riga')
	ls_ric_id_sog_comm_agente_riga=ds_profilo.getitemstring(1,'ric_id_sog_comm_agente_riga')
	ls_ric_provvigioni_riga=ds_profilo.getitemstring(1,'ric_provvigioni_riga')
	ls_ric_val_attribuito_riga=ds_profilo.getitemstring(1,'ric_val_attribuito_riga')
	ls_ric_date_competenza_riga=ds_profilo.getitemstring(1,'ric_date_competenza_riga')
	ls_ric_contropartite_riga=ds_profilo.getitemstring(1,'ric_contropartite_riga')
	is_contr_esen_der=ds_profilo.getitemstring(1,'contr_esen_der')
	ls_ric_tipo_fattura=ds_profilo.getitemstring(1,'ric_tipo_fattura')
	ls_ric_data_documento=ds_profilo.getitemstring(1,'ric_data_documento')
	
	ls_fat_anticipo=ds_profilo.getitemstring(1,'fat_anticipo')
	ll_id_caus_trasporto_prop=ds_profilo.getitemnumber(1,'id_caus_trasporto_prop')
	
	ls_ric_id_sog_comm_vettore_2=ds_profilo.getitemstring(1,'ric_id_sog_comm_vettore_2')
	ll_id_sog_comm_vettore_2_prop=ds_profilo.getitemnumber(1,'id_sog_comm_vettore_2_prop')
	
	ls_ric_data_scadenza=ds_profilo.getitemstring(1,'ric_data_scadenza')
	
   ls_dispo=ds_profilo.getitemstring(1,'con_dis_articoli')
   
   ls_scorta=ds_profilo.getitemstring(1,'con_scorta_articoli')
	
	ib_cal_giac_costi = ds_profilo.getitemstring(1,'cal_giac_costi')
	
	ii_sal_automatico = ds_profilo.getitemnumber(1,'sal_automatico')
	
	if not isnull(ls_dispo) then 
		is_prof_dispo=ls_dispo
		is_movimentazione='D'
	else
		if not isnull(ls_scorta) then
			is_prof_dispo=ls_scorta
			is_movimentazione='S'
		end if
	end if
	
	destroy  ds_profilo
end if





setnull(ll_id_magazzino_1_prop)
select id_magazzino
into :ll_id_magazzino_1_prop
from locazione
where id_locazione=:ll_id_locazione_1_prop;
if isnull(ll_id_magazzino_1_prop) then setnull(ll_id_magazzino_1_prop)
setnull(ll_id_magazzino_2_prop)
select id_magazzino
into :ll_id_magazzino_2_prop
from locazione
where id_locazione=:ll_id_locazione_2_prop;
if isnull(ll_id_magazzino_2_prop) then setnull(ll_id_magazzino_2_prop)
uf_set_ric(ls_ric_id_registro, "c_registro_des", this)
uf_set_ric(ls_ric_id_registro, "c_registro", this)
uf_set_ric(ls_ric_num_progressivo,"num_progressivo", this) 
uf_set_ric(ls_ric_num_documento, "num_documento", this)

if (ll_id_sog_comm_prop > 0) then
	uf_set_ric(ls_ric_id_sog_comm, "c_sog_comm_cod", this)
	uf_set_ric(ls_ric_id_sog_comm, "c_sog_comm_des", this)
end if


uf_set_ric(ls_ric_data_scadenza, "data_scadenza", this) 

uf_set_ric(ls_ric_id_caus_magazzino,"documento_id_caus_magazzino", this)
uf_set_ric(ls_ric_id_con_pagamento, "id_con_pagamento", this)
uf_set_ric(ls_ric_id_con_pagamento, "id_con_pagamento_des", this)
uf_set_ric(ls_ric_id_tipo_trasporto,"id_tipo_trasporto", this)
uf_set_ric(ls_ric_id_tipo_trasporto,"id_tipo_trasporto_des", this)
uf_set_ric(ls_ric_id_sog_comm_agente, "c_gruppo_agenti_cod", this)
uf_set_ric(ls_ric_id_sog_comm_agente, "c_gruppo_agenti_des", this)
uf_set_ric(ls_ric_id_valuta, "documento_id_valuta_cod", this)
uf_set_ric(ls_ric_id_valuta, "documento_id_valuta_des", this)
uf_set_ric(ls_ric_tipo_fattura,"tipo_fattura", this)
uf_set_ric(ls_ric_data_documento,"data_documento", this)


uf_set_ric(ls_ric_id_tipo_trasporto,"id_tipo_trasporto", idw_gen_trasp)
uf_set_ric(ls_ric_id_tipo_trasporto,"id_tipo_trasporto_des", idw_gen_trasp)
uf_set_ric(ls_ric_colli_documento,"num_colli", idw_gen_trasp)
uf_set_ric(ls_ric_pesi,"peso_netto", idw_gen_trasp)
uf_set_ric(ls_ric_pesi,"peso_lordo", idw_gen_trasp)
uf_set_ric(ls_ric_id_caus_trasporto,"id_caus_trasporto", idw_gen_trasp)
uf_set_ric(ls_ric_id_caus_trasporto,"id_caus_trasporto_des", idw_gen_trasp)
uf_set_ric(ls_ric_asp_beni,"asp_beni", idw_gen_trasp)

uf_set_ric(ls_ric_trasp_mezzo,"tras_mezzo", idw_gen_trasp)

uf_set_ric(ls_ric_id_sog_comm_vettore_1,"c_vettore_cod", this)
uf_set_ric(ls_ric_id_sog_comm_vettore_1,"c_vettore_des", this)
uf_set_ric(ls_ric_id_sog_comm_vettore_1,"c_vettore_cod", idw_gen_trasp)
uf_set_ric(ls_ric_id_sog_comm_vettore_1,"c_vettore_des", idw_gen_trasp)

if (ls_ric_trasp_mezzo = "V") then
	uf_set_ric(ls_ric_id_sog_comm_vettore_2,"cc_sog_comm_2_cod", this)
	uf_set_ric(ls_ric_id_sog_comm_vettore_2,"cc_sog_comm_2_des", this)
	uf_set_ric(ls_ric_id_sog_comm_vettore_2,"cc_sog_comm_2_cod", idw_gen_trasp)
	uf_set_ric(ls_ric_id_sog_comm_vettore_2,"cc_sog_comm_2_des", idw_gen_trasp)
end if

uf_set_ric(ls_ric_data_trasporto,"data_trasporto", idw_gen_trasp)

uf_set_ric(ls_ric_quantita_riga,"quantita", idw_riga)
uf_set_ric(ls_ric_data_prev_consegna_riga,"riga_documento_data_prev_consegna", idw_riga)
uf_set_ric(ls_ric_sconto_riga,"sconto", idw_riga)
uf_set_ric(ls_ric_prezzo_netto_riga,"prezzo_netto", idw_riga)
uf_set_ric(ls_ric_id_tab_iva_riga,"riga_documento_id_tab_iva", idw_riga)

uf_set_ric(ls_ric_data_prev_consegna_riga,"data_prevista_consegna", idw_riga_tot)
uf_set_ric(ls_ric_prezzo_netto_riga,"prezzo_netto", idw_riga_tot)
is_ric_documento = ""
is_ric_documento= is_ric_documento + ls_ric_id_caus_magazzino + ls_ric_id_magazzino_1 + ls_ric_id_magazzino_2 
is_ric_documento= is_ric_documento + ls_ric_id_sog_comm_fattura + ls_ric_id_listino 
is_ric_documento= is_ric_documento + ls_ric_id_sog_comm_agente + ls_ric_id_tipo_trasporto 
is_ric_documento= is_ric_documento + ls_ric_id_sog_comm_vettore_1 

is_ric_documento= is_ric_documento + ls_ric_id_sog_comm_vettore_2

is_ric_documento= is_ric_documento + ls_ric_data_scadenza 

is_ric_riga = ""


is_ric_riga= is_ric_riga + ls_ric_id_unita_confezione_riga + ls_ric_quantita_riga + ls_ric_unita_base_riga
is_ric_riga= is_ric_riga + ls_ric_unita_prezzo_riga + ls_ric_id_caus_magazzino_riga + ls_ric_locazione_1_riga
is_ric_riga= is_ric_riga + ls_ric_locazione_2_riga + ls_ric_data_prev_consegna_riga + ls_ric_pesi_riga + ls_ric_dim_riga
is_ric_riga= is_ric_riga + ls_ric_colli_riga + ls_ric_id_valuta_riga  + ls_ric_id_listino_riga + ls_ric_prezzo_riga
is_ric_riga= is_ric_riga + ls_ric_sconto_riga + ls_ric_prezzo_netto_riga + ls_ric_sconto_riga_riga + ls_ric_id_tab_iva_riga
is_ric_riga= is_ric_riga + ls_ric_id_sog_comm_agente_riga + ls_ric_provvigioni_riga 
is_ric_riga= is_ric_riga + ls_ric_val_attribuito_riga  + ls_ric_date_competenza_riga + ls_ric_contropartite_riga 

idw_riga.Modify("c_ric.text = '" + is_ric_riga + "'")

if (getItemStatus(il_row,0,Primary!) = New!) or (getItemStatus(il_row,0,Primary!) = NewModified!)  then
	
	
		
	

	
		CHOOSE CASE ls_tipo_fattura
				
			CASE "N"
				uf_set_colval("segno_iva","1")
			CASE "D"
				uf_set_colval("segno_iva","1")
			CASE "C"
				uf_set_colval("segno_iva","-1")
		END CHOOSE
	
		uf_set_colval( "documento_note_intestazione", ls_note_intestazione_prop)
		uf_set_colval( "documento_id_caus_magazzino", string(ll_id_caus_magazzino_prop)) 
		uf_set_colval( "documento_id_caus_trasporto", string(ll_id_caus_trasporto_prop)) 
		uf_set_colval( "id_sog_commerciale", string(ll_id_sog_comm_prop ))
		uf_set_colval( "documento_id_magazzino", string(ll_id_magazzino_1_prop))
		uf_set_colval( "documento_id_magazzino_2", string(ll_id_magazzino_2_prop))
		uf_set_colval( "documento_id_locazione_1", string(ll_id_locazione_1_prop))
		uf_set_colval( "documento_id_locazione_2", string(ll_id_locazione_2_prop))
		uf_set_colval( "documento_id_sog_commerciale_fattura", string(ll_id_sog_comm_fattura_prop))
		uf_set_colval( "documento_id_linguaggio", string(ll_id_linguaggio_prop))
		
		
		if (ll_id_valuta_prop > 0) then
			uf_set_colval( "documento_id_valuta_des", string(ll_id_valuta_prop))
		else
			SELECT id_valuta
			INTO	 :ll_id_valuta_prop
			FROM	 esercizio
			WHERE  id_esercizio = :il_id_esercizio
			;
			
			uf_set_colval( "documento_id_valuta_des", string(ll_id_valuta_prop))
		end if
		
		
		uf_set_colval( "id_val_acconto", string(ll_id_valuta_prop ))
		uf_set_colval( "c_imp_acconto_convertito", "0")
		PostEvent("ue_set_valu_fields")
		uf_set_colval( "id_con_pagamento_des", string(ll_id_con_pagamento_prop ) )
		uf_set_colval( "documento_id_sog_commerciale_vettore", string(ll_id_sog_comm_vettore_1_prop))
	
		
		uf_set_colval( "documento_id_sog_commerciale_vettore_2", string(ll_id_sog_comm_vettore_2_prop))
	
		uf_set_colval( "id_lingua" , string(ll_id_lingua_prop))
		
		uf_set_colval( "documento_asp_beni", ls_aspetto_beni_prop)
	
		uf_set_colval( "tras_mezzo", ls_trasp_mezzo_prop)
	
		uf_set_colval( "tipo_fattura", ls_tipo_fattura)
		uf_set_colval( "des_contabile",ls_des_contabile)
		uf_set_colval( "id_prof_registrazione",string(ll_id_prof_registrazione))
	
		If IsNull(il_id_esercizio) OR il_id_esercizio=0 then event ue_set_esercizio()
	
		
		if (isnull(ll_id_valuta_prop)) then
			SELECT id_valuta
			INTO	 :ll_id_valuta_prop
			FROM	 esercizio
			WHERE  id_esercizio = :il_id_esercizio
			;
	
			uf_set_colval( "documento_id_valuta_des", string(ll_id_valuta_prop))
		end if
		
	
		event ue_set_registro()
		
		
			event ue_set_sog_fields()
			event ue_set_con_pagamento()
		
	
	
end if
	
	if ls_fat_anticipo='S' then
		idw_gen.modify("imp_acconto.protect=1")
		tab_1.tabpage_1.cb_cerca_anticipi.visible=false
		idw_gen.modify("imp_acconto.background.color=12632256")
	else
		idw_gen.modify("imp_acconto.protect=0")
		tab_1.tabpage_1.cb_cerca_anticipi.visible=true
		idw_gen.modify("imp_acconto.background.color=16777215")
	end if

	if is_prof_dispo='C' or is_prof_dispo='B' then
		 if isvalid(ids_disponibilita) then destroy ids_disponibilita
		 ids_disponibilita=create datastore
		 ids_disponibilita.dataobject='ds_ricalc_dispo'
		 ids_disponibilita.settransobject(sqlca)	
	end if 


	event ue_set_calc_fields()


return 0
end event

event ue_set_calc_fields;long 		ll_id_sog_commerciale, ll_id_esercizio
string 	ls_info, ls_esercizio, ls_indirizzo
string 	ls_codice, ls_descrizione, ls_tipo_registro
long 		ll_destinazione, ll_registro, ll_numero, ll_prof_documento, ll_sog_comm
long		ll_sog_comm_vettore, ll_id_gruppo_agenti, ll_id_banca
long 	 	ll_sog_comm_vettore_2

ll_id_sog_commerciale= GetItemNumber(il_row, "id_sog_commerciale")
if not IsNull(ll_id_sog_commerciale) then
	
	ls_info= f_info_sc(ll_id_sog_commerciale)
	uf_SetItem(il_row,"cinfo", ls_info, TRUE)
end if

if RowCount() > 0 then
	
ll_destinazione = long(uf_get_colval("id_destinazione"))
if  not isnull(ll_destinazione) then

	
	SELECT "destinazione"."rag_soc_1", indirizzo 
	  	INTO :ls_descrizione, :ls_indirizzo
     	FROM "dba"."destinazione"
	 	WHERE ( "destinazione"."id_destinazione" = :ll_destinazione );
	
	if isnull(ls_indirizzo) then ls_indirizzo=' '
	uf_SetItem(il_row,"c_destinazione_des",ls_descrizione+ " "+ls_indirizzo, TRUE)
end if
	
	
	
ll_id_banca = long(uf_get_colval("id_banca_sog_commerciale"))

SELECT	den_abi + ' - ' + den_cab
INTO	   :ls_descrizione
FROM	   banca_sog_commerciale_gen
WHERE	   id_banca_sog_commerciale = :ll_id_banca 
;

If SQLCA.SQLCODE = -1 Then
	MessageBox("", SQLCA.SQLERRTEXT)
End If


uf_SetItem(il_row,"c_abi_cab_des",ls_descrizione, TRUE)

	
ls_descrizione = ""
	
ll_registro = long(uf_get_colval("id_registro"))

	
	  SELECT "registro"."tipo_registro",   
				"registro"."numero", 
				"registro"."descrizione", 
				"esercizio"."codice"  
			 INTO :ls_tipo_registro, :ll_numero, :ls_descrizione, :ls_codice  
			 FROM "dba"."esercizio", "registro"  
			 WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
					 ( ( "registro"."id_registro" = :ll_registro ) )   ;
					 
	
	uf_SetItem(il_row,"c_registro_des",ls_descrizione, TRUE)
	uf_SetItem(il_row,"c_registro", "Esercizio: " + ls_codice + " - " + &
							  "Tipo: " + ls_tipo_registro + " - " + &
							  "Numero: " + string(ll_numero), TRUE)
	is_tipo_registro= ls_tipo_registro
ls_codice = ""
ls_descrizione = ""

	
	ll_prof_documento = long(uf_get_colval("id_prof_documento"))

	
	SELECT "prof_documento"."codice" , "prof_documento"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "dba"."prof_documento" 
	 	WHERE ( "prof_documento"."id_prof_documento" = :ll_prof_documento )   ;

	
	uf_SetItem(il_row,"c_prof_doc_cod",ls_codice, TRUE)
	uf_SetItem(il_row,"c_prof_doc_des",ls_descrizione, TRUE)
	
ls_codice = ""
ls_descrizione = ""

ll_sog_comm = long(uf_get_colval("id_sog_commerciale"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "dba"."sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm)   ;
	
	uf_SetItem(il_row,"c_sog_comm_cod",ls_codice, TRUE)
	uf_SetItem(il_row,"c_sog_comm_des",ls_descrizione, TRUE)
	
ls_codice = ""
ls_descrizione = ""

ll_sog_comm_vettore = long(uf_get_colval("documento_id_sog_commerciale_vettore"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "dba"."sog_commerciale_gen" 
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm_vettore )   ;

	
	idw_gen_trasp.uf_SetItem(il_row,"c_vettore_cod",ls_codice, TRUE)
	idw_gen_trasp.uf_SetItem(il_row,"c_vettore_des",ls_descrizione, TRUE)
	
ll_sog_comm_vettore_2 = long(uf_get_colval("documento_id_sog_commerciale_vettore_2"))

ls_codice=''
ls_descrizione=''
SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
INTO 	 :ls_codice, :ls_descrizione
FROM 	 "dba"."sog_commerciale_gen" 
WHERE  ("sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm_vettore_2 )   ;

idw_gen_trasp.uf_SetItem(il_row,"cc_sog_comm_2_cod",ls_codice, TRUE)
idw_gen_trasp.uf_SetItem(il_row,"cc_sog_comm_2_des",ls_descrizione, TRUE)
	

	
ls_codice = ""
ls_descrizione = ""
ll_id_gruppo_agenti = long(uf_get_colval("id_gruppo_agenti"))

	
  SELECT "gruppo_agenti"."codice",   
         "gruppo_agenti"."descrizione"  
    INTO :ls_codice,   
         :ls_descrizione  
    FROM "dba"."gruppo_agenti"  
   WHERE "gruppo_agenti"."id_gruppo_agenti" = :ll_id_gruppo_agenti   ;

	
	uf_SetItem(il_row,"c_gruppo_agenti_cod",ls_codice, TRUE)
	uf_SetItem(il_row,"c_gruppo_agenti_des",ls_descrizione, TRUE)
	
end if

end event

event ue_set_not_new();
if not ((getItemStatus(il_row,0,Primary!) = New!) or (getItemStatus(il_row,0,Primary!) = NewModified!)) then
	il_id_documento= GetItemNumber(il_row, "id_documento")
	f_displayonly(this, "c_prof_doc_cod", TRUE)
	f_displayonly(this, "c_prof_doc_des", TRUE)
	f_displayonly(this, "c_esercizio", TRUE)
	f_displayonly(this, "c_registro", TRUE)
	f_displayonly(this, "c_registro_des", TRUE)
	f_displayonly(this, "num_progressivo", TRUE)
	f_displayonly(this, "documento_id_valuta_cod", TRUE)
	f_displayonly(this, "documento_id_valuta_des", TRUE)
	f_displayonly(this, "documento_cambio", TRUE)
	
	
	
	long 		ll_id_prof_documento
	string 	ls_ric_id_sog_comm
	
	ll_id_prof_documento = tab_1.tabpage_1.dw_documento_ordine_ff.object.id_prof_documento[1]
	
	SELECT ric_id_sog_comm
	INTO	 :ls_ric_id_sog_comm
	FROM   prof_documento
	WHERE  id_prof_documento = :ll_id_prof_documento
	;
	
	uf_set_ric(ls_ric_id_sog_comm, "c_sog_comm_cod", this)
	uf_set_ric(ls_ric_id_sog_comm, "c_sog_comm_des", this)
	
	
	
	
end if
end event

event ue_set_regi_fields();
long 		ll_id_registro, ll_ultimo_num_reg, ll_num_suggerito_min, ll_num_suggerito_Max
long 		ll_id_documento, ll_id_prof_doc
decimal 	ldc_ultimo_num_reg, ldc_doc_globale
date		ld_ultima_data_reg, ld_data_prec, ld_data_succ, ld_Data
string	ls_message, ls_doc_globale, ls_num_documento,ls_tipo_registro
integer li_ret   
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog

ll_id_registro=il_id_registro
	
	IF  ll_id_registro > 0 THEN
		uo_proponi_num_progressivo=create u_setta_campi_documento
		ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_registro, 0, is_tipo_registro)
		destroy uo_proponi_num_progressivo
		SetItem(il_row, "num_progressivo", ls_trova_prog.sl_num_progressivo)
		
		If uf_Test_data_Registrazione(Today()) then ls_trova_prog.sdt_data_registrazione = Today()
		SetItem(il_row, "data_registrazione", ls_trova_prog.sdt_data_registrazione)
		SetItem(il_row, "documento_data_competenza", ls_trova_prog.sdt_data_registrazione)
		ll_id_prof_doc=getitemnumber(1, "id_prof_documento")
		If right(is_tipo_registro, 1)="V" or right(is_tipo_registro, 1)="C" or (ll_id_prof_doc=187) then
			
			SetItem(il_row, "num_documento", string(ls_trova_prog.sl_num_progressivo))
			
			SetItem(il_row, "data_documento", ls_trova_prog.sdt_data_registrazione)
		else
			idw_gen.Object.tipo_fattura.Protect = 0
		end if
	END IF
event ue_set_valu_fields("")

tab_1.tabpage_4.dw_cast_iva_documento_lt.event ue_visibilita_campi("V")

uf_Set_Tipo_Doc()
end event

event ue_set_valu_fields(string as_data);
long		ll_id_valuta, ll_dec_significativi
decimal  ld_cambio_appoggio
long ll_id_val_euro, ll_id_val_conto, ll_id_esercizio
decimal ld_parita_euro
integer	li_dec_significativi
 

if IsNull(as_data) OR as_data="" OR as_data = "NO_CAMBIO" then 
	ll_id_valuta= GetItemNumber(il_row, "documento_id_valuta_des")
else
	ll_id_valuta = long(as_data)
end if

if  ll_id_valuta>0 then
	SELECT "valuta"."cambio",   
		 "valuta"."cifra_arrotondamento" ,
		 "valuta"."tipo_arrotondamento",
		 "valuta"."simbolo",
		 "valuta"."parita_euro",
		 "valuta"."dec_significativi"
		 
	INTO :ld_cambio_appoggio,   
		:il_arrotondamento,
		:is_tipo_arrotondamento ,
		:is_simbolo_valuta,
		:ld_parita_euro,
		:ll_dec_significativi
	FROM "dba"."valuta"  
	WHERE "valuta"."id_valuta" = :ll_id_valuta   ;

	select id_val_euro
	into :ll_id_val_euro
	from par_sistema;
	
	ll_id_esercizio=IDW_GEN.getitemnumber(1, "c_esercizio")
	
	select id_valuta
	into   :al_id_val_az  
	from   esercizio
	where  id_esercizio = :ll_id_esercizio;
	if sqlca.sqlcode = 0 then
		if al_id_val_az = ll_id_val_euro then ld_cambio_appoggio = ld_parita_euro 
	
		if as_data <> "NO_CAMBIO" or isnull(as_data) then
			if GetItemStatus(il_row, 0, Primary!) =New! OR GetItemStatus(il_row, 0, Primary!) =NewModified! then
				idc_cambio = ld_cambio_appoggio
				SetItem (il_row,"documento_cambio",idc_cambio)
			else
				idc_cambio=getitemdecimal(il_row,"documento_cambio")
				idc_cambio=1/idc_cambio //aggiunto 20220210 per alpa da verificare
			end if
		end if
		idw_castelletto.Modify("c_cambio_text.text = '" + String(idc_cambio) + "'") 
		idw_castelletto.Modify("c_arrotondamento_text.text = '" + String(ll_dec_significativi) + "'")
		//idw_castelletto.Modify("c_arrotondamento_text.text = '" + String(6) + "'")
		idw_castelletto.Modify("c_tipo_arrotondamento.text = '" + is_tipo_arrotondamento + "'")
		
		select dec_significativi
		into   :li_dec_significativi
		from	 valuta
		where  id_valuta = :al_id_val_az
		;
		if (sqlca.sqlcode = -1) then messagebox("dberror", sqlca.sqlerrtext)

		idw_castelletto.Modify("c_arrotondamento_text_v_conto.text = '" + String(li_dec_significativi) + "'")
		idw_spesa.Modify("c_arrotondamento_text_v_conto.text = '" + String(li_dec_significativi) + "'")
		
		
		idw_spesa.Modify("c_cambio_text.text = '" + String(idc_cambio) + "'")
		uf_set_dec_mask(il_arrotondamento, is_simbolo_valuta, ll_id_valuta) 
		iF idc_cambio = 1 then
			cbx_simbolo.checked = FALSE
			
			uf_set_dec_mask( il_arrotondamento, is_simbolo_valuta, ll_id_valuta) 
		end if
	else
		iuo_msg_log.uf_new_text("Impossibile settare il cambio.",3)
	end if
end if




end event

event ue_canc_intestatario;call super::ue_canc_intestatario;long ll_null

SetNull(ll_null)
SetItem(il_row, "id_sog_commerciale", ll_null)
SetItem(il_row, "c_sog_comm_cod", "")
SetItem(il_row, "c_sog_comm_des", "")

end event

event ue_set_sp_incasso;call super::ue_set_sp_incasso;
long ll_id_sog_commerciale

ll_id_sog_commerciale= GetItemNumber(il_row, "id_sog_commerciale")
SELECT "spesa"."id_spesa" ,"spesa_sog_commerciale"."importo"  
	INTO :il_id_spesa_incasso , 
		:idc_spesa_inc_importo  
	FROM "dba"."spesa_sog_commerciale",   
		"dba"."spesa"  
	WHERE ( "spesa"."id_spesa" = "spesa_sog_commerciale"."id_spesa" ) and  
		( ( "spesa"."codice" = 'C' ) AND  
		( "spesa_sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) )   ;

end event

event ue_set_registro;call super::ue_set_registro;
long ll_id_esercizio
SELECT Max("registro"."id_registro")
	INTO :il_id_registro  
	FROM "dba"."registro"  
	WHERE ( "registro"."id_esercizio" = :il_id_esercizio ) AND  
		( "registro"."id_mod_registro" = :il_id_mod_registro )   ;

If SQLCA.SQLCode = 0 then
	uf_SetItem(il_row, "id_registro", il_id_registro, TRUE)
	SELECT "registro"."tipo_registro"  
		INTO :is_tipo_registro
		FROM "dba"."registro"  
		WHERE "registro"."id_registro" = :il_id_registro ;
	If (not (IsNull(is_tipo_registro) OR is_tipo_registro ="")) then 
		CHOOSE CASE Left(is_tipo_registro,1)
			CASE "O"
				is_tipo_documento= "O"
			CASE "I"
				is_tipo_documento= "F"
			CASE "C"
				is_tipo_documento= "C"
			CASE "P"
				is_tipo_documento= "P"
			CASE "G"
				is_tipo_documento= "G"
		END CHOOSE
		iw_corrente.TriggerEvent("ue_tipo_documento")
	end if
	TriggerEvent("ue_set_regi_fields")
else
	iuo_msg_log.uf_new_text("Impossibile settare automaticamente il Registro",3)
end if

end event

event ue_set_esercizio;
long 				ll_id_registro
string  			ls_esercizio

string 			ls_coltype, ls_value
long 				ll_ret_value
if il_row>0 then
	u_setta_campi_documento uo_setta_campi_doc
	uo_setta_campi_doc=create u_setta_campi_documento
	il_id_esercizio=uo_setta_campi_doc.uf_set_esercizio(idw_gen, il_row)
	destroy uo_setta_campi_doc
	idw_gen.SetItem(il_row, "c_esercizio",il_id_esercizio)
end if


end event

event ue_reset;
integer 			li_size, li_counter
long 				ll_row
datawindow		ldw_item



ib_reset= TRUE
li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ldw_item.Reset()
next
ib_reset= FALSE
SetNull(il_id_esercizio)
is_int_consentiti=""
is_simbolo_valuta=""
is_stato_scad_generata=""
ib_prot_modificato=FALSE
uf_set_ric("M", "c_esercizio", this)
uf_set_ric("M", "c_registro_des", this)
uf_set_ric("M", "c_registro", this)
uf_set_ric("M","num_progressivo", this) 
uf_set_ric("M", "num_documento", this)
uf_set_ric("M", "c_sog_comm_cod", this)
uf_set_ric("M", "c_sog_comm_des", this)

uf_set_ric("M","documento_id_caus_magazzino", this)
uf_set_ric("M", "id_con_pagamento", this)
uf_set_ric("M", "id_con_pagamento_des", this)
uf_set_ric("M","id_tipo_trasporto", this)
uf_set_ric("M","id_tipo_trasporto_des", this)
uf_set_ric("M", "c_gruppo_agenti_cod", this)
uf_set_ric("M", "c_gruppo_agenti_des", this)
uf_set_ric("M", "documento_id_valuta_cod", this)
uf_set_ric("M", "documento_id_valuta_des", this)
uf_set_ric("M","c_vettore_cod", this)
uf_set_ric("M","c_vettore_des", this)

uf_set_ric("M","id_tipo_trasporto", idw_gen_trasp)
uf_set_ric("M","id_tipo_trasporto_des", idw_gen_trasp)
uf_set_ric("M","num_colli", idw_gen_trasp)
uf_set_ric("M","peso_netto", idw_gen_trasp)
uf_set_ric("M","peso_lordo", idw_gen_trasp)
uf_set_ric("M","id_caus_trasporto", idw_gen_trasp)

uf_set_ric("M","id_caus_trasporto_des", idw_gen_trasp)
uf_set_ric("M","asp_beni", idw_gen_trasp)
uf_set_ric("M","tras_mezzo", idw_gen_trasp)
uf_set_ric("M","c_vettore_cod", idw_gen_trasp)
uf_set_ric("M","c_vettore_des", idw_gen_trasp)
uf_set_ric("M","data_trasporto", idw_gen_trasp)

uf_set_ric("M","quantita", idw_riga)
uf_set_ric("M","riga_documento_data_prev_consegna", idw_riga)
uf_set_ric("M","prezzo", idw_riga)
uf_set_ric("M","sconto", idw_riga)
uf_set_ric("M","prezzo_netto", idw_riga)
uf_set_ric("M","riga_documento_id_tab_iva", idw_riga)

uf_set_ric("M","data_prevista_consegna", idw_riga_tot)
uf_set_ric("M","prezzo_netto", idw_riga_tot)

is_ric_riga= "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM" 

f_displayonly(this, "c_prof_doc_cod", FALSE)
f_displayonly(this, "c_prof_doc_des", FALSE)
f_displayonly(this, "c_registro", FALSE)
f_displayonly(this, "c_registro_des", FALSE)
f_displayonly(this, "num_progressivo", FALSE)
f_displayonly(this, "documento_id_valuta_cod", FALSE)
f_displayonly(this, "documento_id_valuta_des", FALSE)
f_displayonly(this, "documento_cambio", FALSE)
ll_row= idw_gen_tot_ext.GetRow()
idw_gen_tot_ext.SetItem(ll_row, "tot_imponibile_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "tot_imposta_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "tot_documento_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "tot_merce_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "netto_merce_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "tot_omaggi_sc_merce_lire", 0)

end event

event ue_calc_totale;call super::ue_calc_totale;

decimal ldc_tot_righe, ldc_tot_scontato
long ll_nr_row, ll_sc_cassa, ll_sc_inc
string ls_sc_fin
u_dw_main ldw_righe

ldw_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd
ll_nr_row= ldw_righe.RowCount()
if ll_nr_row > 0 then 
	ldc_tot_righe=ldw_righe.uf_GetItemDecimal(ll_nr_row, "c_tot_righe")
else
	ldc_tot_righe=0
end if
uf_SetItem(il_row, "c_totale_righe", ldc_tot_righe, TRUE)
if IsNull(as_sc_finanziario) then
	ls_sc_fin=GetItemString(il_row, "documento_sconto_finanziario")
else
	ls_sc_fin= as_sc_finanziario
end if

if IsNull(adc_sc_fin_cassa) then
	ll_sc_cassa=GetItemNumber(il_row, "documento_sconto_fin_cassa")
else
	ll_sc_cassa= adc_sc_fin_cassa
end if

if IsNull(adc_sconto_fin_inc) then
	ll_sc_inc=GetItemNumber(il_row, "sconto_fin_incondizionato")
else
	ll_sc_inc= adc_sconto_fin_inc
end if

ldc_tot_scontato = ldc_tot_righe
ldc_tot_scontato=uf_Calcola_Prezzo(ls_sc_fin, ldc_tot_scontato, 0)
if not IsNull(ll_sc_inc) then ldc_tot_scontato = ldc_tot_scontato - ll_sc_inc
if not IsNull(ll_sc_cassa) then ldc_tot_scontato = ldc_tot_scontato - (ll_sc_cassa * ldc_tot_scontato / 100)

uf_SetItem(il_row, "c_totale_scontato", ldc_tot_scontato, TRUE)
return 0
end event

event type integer ue_set_wz_fields(string as_array[]);
string ls_id_magazzino_1, ls_id_magazzino_2, ls_id_caus_magazzino
long ll_id_locazione, ll_nr_righe, ll_count_righe

ls_id_caus_magazzino= uf_get_colval("documento_id_caus_magazzino")
if ls_id_caus_magazzino = as_array[12] then
	uf_set_colval("documento_id_caus_magazzino",as_array[12])  
else
	
	uf_set_colval("documento_id_caus_magazzino",as_array[12]) 
	ll_nr_righe= idw_riga.RowCount() 
	FOR ll_count_righe= 1 to ll_nr_righe
		
		if IsNull(idw_riga.GetItemNumber(ll_count_righe, "id_riga_doc_provenienza")) then
			idw_riga.setItem(ll_count_righe, "riga_documento_id_caus_magazzino", Long(as_array[12]))
		end if
	NEXT
end if
long ll_mag1,ll_mag2,ll_loc1,ll_loc2
ll_loc1=long(as_array[13])
ll_loc2=long(as_array[14])
setnull(ll_mag1)
select id_magazzino
into :ll_mag1
from locazione
where id_locazione=:ll_loc1;
if sqlca.sqlcode<>0 then setnull(ll_mag1)
ls_id_magazzino_1= uf_get_colval("documento_id_magazzino")
if ls_id_magazzino_1 = string(ll_mag1) OR IsNull(ll_mag1) OR IsNull(ls_id_magazzino_1) then
	uf_set_colval("documento_id_magazzino",string(ll_mag1)) 
else
	
	uf_set_colval("documento_id_magazzino", string(ll_mag1) )
	uf_set_colval("documento_id_locazione_1", string(ll_loc1) )
	integer li_ret
	li_ret=messagebox("Informazione","La locazione di partenza è stata modificata,~r~nvuoi che la modifica sia riportata sulle righe?",information!,yesno!)
	if li_ret=1 then
		ll_nr_righe= idw_riga.RowCount() 
		FOR ll_count_righe= 1 to ll_nr_righe
			idw_riga.setItem(ll_count_righe, "id_locazione_1", as_array[13])
		NEXT
	end if
end if
setnull(ll_mag2)
select id_magazzino
into :ll_mag2
from locazione
where id_locazione=:ll_loc2;
if sqlca.sqlcode<>0 then setnull(ll_mag2)
ls_id_magazzino_2= uf_get_colval("documento_id_magazzino_2")
SetNull(ll_id_locazione)
if ls_id_magazzino_2 = string(ll_mag2) OR IsNull(ll_mag2) OR IsNull(ls_id_magazzino_2) then
	uf_set_colval("documento_id_magazzino_2", string(ll_mag2)) 
else
	
	uf_set_colval("documento_id_magazzino_2", string(ll_mag2))
	uf_set_colval("documento_id_locazione_2", string(ll_loc2)) 
	li_ret=messagebox("Informazione","La locazione di destinazione è stata modificata,~r~nvuoi che la modifica sia riportata sulle righe?",information!,yesno!)
	if li_ret=1 then
		ll_nr_righe= idw_riga.RowCount() 
		FOR ll_count_righe= 1 to ll_nr_righe
			idw_riga.setItem(ll_count_righe, "id_locazione_2", as_array[14])
		NEXT
	end if
end if

uf_set_colval("documento_id_sog_commerciale_fattura", as_array[15])  

uf_set_colval("id_lingua", as_array[16])
uf_set_colval("documento_id_linguaggio", as_array[17])



//uf_set_colval("documento_id_listino", as_array[21])
uf_set_colval("id_banca_sog_commerciale", as_array[23])  
uf_set_colval("id_gruppo_agenti", as_array[24])  

uf_set_colval("documento_interlocutore",as_array[26])   

uf_set_colval("documento_note_intestazione", as_array[28])  
uf_set_colval("id_tipo_trasporto",as_array[35])   
uf_set_colval("documento_id_caus_trasporto", as_array[36])  
uf_set_colval("documento_id_sog_commerciale_vettore", as_array[39])  

uf_set_colval("documento_id_tipo_pagamento", as_array[50])  

uf_set_colval("data_scadenza", as_array[56])  

 uf_set_colval("id_documento_padre",as_array[65])
 uf_set_colval("id_prof_registrazione",as_array[66])
 uf_set_colval("des_contabile",as_array[67])

 uf_set_colval("documento_id_listino",as_array[85])
 uf_set_colval("documento_id_variazione",as_array[86])
 uf_set_colval("data_ric_consegna",as_array[87])	
return 0

end event

event ue_set_contropartita;
long		ll_count_riga, ll_size_riga, ll_id_articolo, ll_id_contropartita, ll_id_causale
long		ll_id_sog_commerciale, ll_id_agente, LL_IDAZ

ll_id_sog_commerciale= GetItemNumber(il_row, "id_sog_commerciale")
ll_id_agente=  GetItemNumber(il_row, "id_gruppo_agenti")
ll_size_riga= idw_riga.RowCount()
FOR ll_count_riga = 1 to ll_size_riga
	ll_id_articolo= idw_riga.GetItemNumber(ll_count_riga, "riga_documento_id_articolo")
	ll_id_causale=idw_riga.GetItemNumber(ll_count_riga, "riga_documento_id_caus_magazzino")
	ll_id_contropartita= wf_calcola_cpt(ll_id_sog_commerciale, ll_id_agente, ll_id_articolo, ll_id_causale)
	
	IF ll_id_contropartita=0 OR ISNULL(ll_id_contropartita) THEN
		SELECT ID_AZIENDA
		INTO :LL_IDAZ
		FROM AZIENDA;
		IF LL_IDAZ<1 THEN LL_IDAZ=1
		SELECT "par_sistema"."id_conto_predefinito"  
		INTO :ll_id_contropartita  
		FROM "dba"."par_sistema"  
		WHERE "par_sistema"."id_azienda" =  :LL_IDAZ;
	END IF
	
	idw_riga.SetItem(ll_count_riga, "riga_documento_id_conto", ll_id_contropartita)
next

RETURN 0
end event

event ue_set_con_pagamento;call super::ue_set_con_pagamento;
long		ll_id_con_pagamento
decimal	ldc_sconto_cassa

ll_id_con_pagamento= GetItemNumber(il_row,"id_con_pagamento_des")
If not (IsNull(ll_id_con_pagamento) OR ll_id_con_pagamento=0) then 
	SELECT "con_pagamento"."sconto_cassa"  
		INTO :ldc_sconto_cassa  
		FROM "dba"."con_pagamento"  
		WHERE "con_pagamento"."id_con_pagamento" = :ll_id_con_pagamento  ;
	If SQLCA.SQLCode = 0 then SetItem(il_row, "documento_sconto_fin_cassa", ldc_sconto_cassa)
end if

end event

event itemchanged;
integer appoggio
long 			ll_id_sog_commerciale, ll_id_valuta, ll_id_tipo_trasporto, ll_Cur_IDRegistro, ll_ID_Prof_Doc
long			ll_gg_prev_cons,ll_numero, ll_num_succ, ll_num_prec, ll_id_con_pagamento, ll_old_numero
long 			ll_id_magazzino, ll_id_locazione, ll_nr_righe, ll_count_righe, ll_num_suggerito_min, ll_num_suggerito_max
string		ls_sc_fin, ls_tipo_registro, ls_descrizione, ls_codice, ls_info
date			ld_Ultima_Data_Reg, ld_Data, ld_Old_Data,ld_data_succ, ld_data_prec
string		ls_tb, ls_cp, ls_vr, ls_tr, ls_rag_soc, ls_sql, ls_prec,ls_succ
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_null, ls_message, ls_num_doc, ls_old_num_doc
string		ls_tipo_fattura
integer		li_ok
decimal 		ldc_tot_righe, ldc_sc_1, ldc_sc_2, ldc_tot_scontato, ldc_sconto_cassa, ldc_null
decimal{16} 		ldc_Doc_Glob_Min, ldc_Doc_Glob_Max
long			ll_sc_imp, ll_id_documento
boolean		lb_loading
string		ls_intestatari, ls_sql_cond
long			ll_len, ll_count,ll_soggetto, ll_destinazione
long 			ll_gg_scadenza 
char			lc_bloccante	

u_setta_Campi_documento uo_proponi_num_progressivo
s_trova_progressivo  sl_trova_prog

SetNull(ls_null)
SetNull(ldc_null)
CHOOSE CASE dwo.name
	case 'c_abi_cab_des'
		if isnull(data) or data='' then
			setnull(appoggio)
			setitem(row, "id_banca_sog_commerciale", appoggio)
		end if
	case 'tipo_fattura'
		ls_tipo_fattura	= data
		choose case ls_tipo_fattura
			case "N","D"
				this.SetItem( row,"segno_iva",1 )
			case "C"
				this.SetItem( row,"segno_iva",-1 )
		end choose

	
	
	CASE 'c_prof_doc_cod'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		ls_dbc[4] = "ric_acconti"
		
		ls_dwc[1] = "c_prof_doc_cod"
		ls_dwc[2] = "c_prof_doc_des"
		ls_dwc[3] = "id_prof_documento"
		ls_dwc[4] = "prof_documento_ric_acconti"
		CHOOSE CASE is_tipo_documento
			CASE "O"
				ls_sql = "prof_documento.tipo_registro = 'OA' OR prof_documento.tipo_registro = 'OV'"
			CASE "D"
				ls_sql = "prof_documento.tipo_registro = 'DA' OR prof_documento.tipo_registro = 'DV'"
			CASE "F"
				ls_sql = "prof_documento.tipo_registro = 'IA' OR prof_documento.tipo_registro = 'IV'"
			CASE "P"
				ls_sql  = "prof_documento.tipo_registro = 'PA' OR prof_documento.tipo_registro = 'PV'"
			
		END CHOOSE
		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"codice","A",data,ls_sql,4,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			event ue_set_prof_fields()
			uf_abilita_contabilizza()
			
			return 2 
		end if
		
	CASE 'c_prof_doc_des'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		ls_dbc[4] = "ric_acconti"
		
		ls_dwc[1] = "c_prof_doc_cod"
		ls_dwc[2] = "c_prof_doc_des"
		ls_dwc[3] = "id_prof_documento"
		ls_dwc[4] = "prof_documento_ric_acconti"
		CHOOSE CASE is_tipo_documento
			CASE "O"
				ls_sql = "prof_documento.tipo_registro = 'OA' OR prof_documento.tipo_registro = 'OV'"
			CASE "D"
				ls_sql = "prof_documento.tipo_registro = 'DA' OR prof_documento.tipo_registro = 'DV'"
			CASE "F"
				ls_sql = "prof_documento.tipo_registro = 'IA' OR prof_documento.tipo_registro = 'IV'"
		END CHOOSE
		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"descrizione","A",data,ls_sql,4,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
				event ue_set_prof_fields()
				
				uf_abilita_contabilizza()
				return 2 
		end if
	CASE 'c_esercizio'
		If not(IsNull(data) OR data = "") then
			il_id_esercizio=long(data)
			if SQLCA.SQLCode = 0 then
				event ue_set_registro()
				event ue_set_calc_fields()
			end if
			
			
			setnull(ll_id_valuta)
			
			SELECT id_valuta
			INTO	 :ll_id_valuta
			FROM	 esercizio
			WHERE  id_esercizio = :il_id_esercizio
			;
			
			if (ll_id_valuta > 0) then
				this.setitem(row, "documento_id_valuta_des", ll_id_valuta)
				event ue_set_valu_fields(string(ll_id_valuta))
			end if
			
		else
			il_id_esercizio =0
		end if

	CASE 'c_registro_des'
		
		ll_ID_Prof_Doc=GetItemNumber(il_row,"id_prof_documento")
		If not(IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc=0) then
			uf_SW_SetNull(data, 'id_registro')
			ls_dbc[1] = "descrizione"
			ls_dbc[2] = "id_registro"
			ls_dwc[1] = "c_registro_des"
			ls_dwc[2] = "id_registro"
			li_ok = uf_autofind_col (string(dwo.name),"registro","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)
			if li_ok > 0 then
				event ue_set_regi_fields()
				ll_Cur_IDRegistro= GetItemNumber(il_row, "id_registro")
				if not IsNull(ll_Cur_IDRegistro) then
	
					SELECT "registro"."tipo_registro",   
						"registro"."numero", 
						 "registro"."descrizione", 
						"esercizio"."codice"  
					INTO :is_tipo_registro,   
						:ll_numero, 
						:ls_descrizione,  
						:ls_codice  
					FROM "dba"."esercizio",   
						"dba"."registro"  
					WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
						( ( "registro"."id_registro" = :ll_Cur_IDRegistro ) )   ;
					uf_set_colval("c_registro", "Esercizio: " + ls_codice + " - " + &
					  "Tipo: " + ls_tipo_registro + " - " + &
					  "Numero: " + string(ll_numero))
					SetItem(il_row,"c_sog_comm_des", ls_rag_soc)
				end if
				return 2 
			end if
		end if

	CASE 'c_registro'
		uf_SW_SetNull(data, 'id_registro')
		event ue_set_regi_fields()


CASE "num_progressivo"
		
		ll_numero = Long(data)
		
		ll_old_numero=GetItemNumber(il_row, "num_progressivo")
		uo_proponi_num_progressivo=create u_setta_campi_documento
		if il_id_registro>0 then
			sl_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(il_id_registro, ll_numero, is_tipo_registro)
			if sl_trova_prog.sl_id_documento > 0 then
				
				If MessageBox(is_title, "Esiste già un Documento con Progressivo ... '" + String(data) + &
							"'~n vuoi modificarlo?",Information!,  YesNo!, 2) = 1 then
					Post uf_load_documento(sl_trova_prog.sl_id_documento)
				else		
					POST SETITEM(ROW ,"NUM_PROGRESSIVO", ll_old_numero)	
					post setcolumn("num_progressivo")
				end if
			elseif sl_trova_prog.sl_id_documento = -1 then
				messagebox("Attenzione!", "Il numero progressivo è già stato usato in contabilità!")
				POST SETITEM(ROW ,"NUM_PROGRESSIVO", ll_old_numero)	
				post setcolumn("num_progressivo")
			else	
				if is_con_data_progressiva = 'S' then
					ld_Ultima_Data_Reg=GetItemDate(il_row, "data_registrazione")
					
					ld_Ultima_Data_Reg=uo_proponi_num_progressivo.uf_ver_num_data_coerenza(il_id_registro, ll_numero, 	ld_Ultima_Data_Reg)
					Post SetItem(il_row, "data_registrazione", ld_Ultima_Data_Reg) 	
				end if
			end if
			destroy uo_proponi_num_progressivo
		END IF
			
			

	CASE 'data_registrazione'
		ll_Cur_IDRegistro = IL_ID_REGISTRO
		ll_ID_Prof_Doc = GetItemNumber(il_row, "id_prof_documento")
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) AND NOT (IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc = 0) THEN
			ld_Ultima_Data_Reg=Date(data)
			if is_con_data_progressiva = 'S' then
				ll_numero=getitemnumber(il_row, "num_progressivo")
				uo_proponi_num_progressivo=create u_setta_campi_documento
				ld_Ultima_Data_Reg=uo_proponi_num_progressivo.uf_ver_num_data_coerenza(ll_Cur_IDRegistro, 	ll_numero, 	ld_Ultima_Data_Reg)
				destroy uo_proponi_num_progressivo
				Post SetItem(il_row, "data_registrazione", ld_Ultima_Data_Reg) 	
			end if
			
			
			If not(uf_Test_data_Registrazione(ld_Ultima_Data_Reg)) then 
				messagebox ( "ATTENZIONE!", "La data "+data+" Non è compresa nel Periodo  dell' esercizio corrente."+&
								" ~r~n Immettere una data valida " )
				this.setcolumn("data_registrazione")
			end if
			SetItem(il_row, "documento_data_competenza", date(data))
			
			SELECT gg_consegna, gg_scadenza
			INTO 	 :ll_gg_prev_cons, :ll_gg_scadenza
			FROM 	 prof_documento
			WHERE  id_prof_documento = :ll_ID_Prof_Doc   
			;
		
			if not IsNull(ll_gg_prev_cons) then SetItem(il_row, "data_prev_consegna", &
				RelativeDate(ld_Ultima_Data_Reg, ll_gg_prev_cons))
			end if
			
			
			if not isnull(ll_gg_scadenza) then 
				setitem(il_row, "data_scadenza",	relativedate(ld_ultima_data_reg, ll_gg_scadenza))
			end if			
			
			
			ll_numero = GetItemNumber(il_row, "num_progressivo")

			date ldt_data_inizio
			date ldt_data_fine
			long ll_my_id
			ll_my_id = this.getitemnumber(row,"c_esercizio")
			select "esercizio"."data_inizio","esercizio"."data_fine"
				into :ldt_data_inizio,:ldt_data_fine
				from "esercizio"
			where "esercizio"."id_esercizio" = :ll_my_id;
			
			if date(data) < ldt_data_inizio or &
				date(data) > ldt_data_fine then
				messagebox ( "ATTENZIONE!", 	"La data "+data+" Non è compresa nel Periodo ~r~n dal "+&
														string(ldt_data_inizio)+" al "+string(ldt_data_fine)+" dell' esercizio corrente"+&
														" ~r~n immettere una data valida " )
				this.setcolumn("data_registrazione")														
			end if

	CASE 'num_documento'
		ls_num_doc=data
		ls_old_num_doc= GetItemString(il_row, "num_documento")
		ll_Cur_IDRegistro= GetItemNumber(il_row, "id_registro")
		ll_numero=GetItemNumber(il_row, "num_progressivo")
		ld_Data=GetItemDate(il_row, "data_registrazione")
		if not (IsNull(ll_Cur_IDRegistro) OR IsNull(ll_numero) OR IsNull(ld_Data) )then
			SQLCA.sp_ver_numdoc_numprog( ll_Cur_IDRegistro, ll_numero, ls_num_doc, ld_Data,ls_message, ldc_Doc_Glob_Min, ldc_Doc_Glob_Max);	
			If IsNull(ls_num_doc) then
				iuo_msg_log.uf_new_text("Verifica del Numero di Documento '" + data + "'.",3)
				MessageBox(is_title, "Il Numero di Documento è errato.")
				iuo_msg_log.uf_new_text("Il Numero di Documento è errato.",4)
				If not (IsNull(ls_message) OR ls_message ="") then iuo_msg_log.uf_new_text(ls_message,4)
				Post SetItem( il_row, "num_documento", ls_old_num_doc)
			end if
		end if
		
	CASE 'c_sog_comm_cod'
		ls_intestatari =""
		if not (IsNull(is_int_consentiti) OR is_int_consentiti="")  then
			ll_len = Len(is_int_consentiti)
			for ll_count = 1 to ll_len
				ls_intestatari = ls_intestatari + ",'" + Mid(is_int_consentiti, ll_count, 1) + "'"
			next
			if not IsNull(ls_intestatari) then ls_intestatari = Mid(ls_intestatari, 2,Len(ls_intestatari)-1)
			ls_intestatari = "(" + ls_intestatari + ")"
		end if
		if not (IsNull(ls_intestatari) OR ls_intestatari="") then ls_sql_cond = "sog_commerciale_gen.tipo IN " + ls_intestatari
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_sog_comm_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_sog_comm_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"codice","A",data,ls_sql_cond,3,ls_dbc,ls_dbv,ls_dwc)
										
		if li_ok > 0 then
			
			wf_azzera_campi_calcolati_sog(row)
			
			
			
			lc_bloccante = f_ann_sc(this.getitemnumber(row, "id_prof_documento"), GetItemNumber(row, "id_sog_commerciale"))
			if (lc_bloccante = "S") then
				PostEvent("ue_canc_intestatario")
			end if
			
			
			CHOOSE CASE uf_check_sospesi()
				CASE "OK"
					TriggerEvent("ue_set_sog_fields")
					post event ue_set_contropartita()
					return 2 
				CASE "AVVISA"
					MessageBox("Documento","Cliente Fuori Limite di Fido")
					TriggerEvent("ue_set_sog_fields")
					post event ue_set_contropartita()
					return 2
				CASE "BLOCCA"
					MessageBox("Documento","Cliente Fuori Limite di Fido")
					PostEvent("ue_canc_intestatario")
					return 1 
			END CHOOSE
			wf_controlla_destinazione(long(ls_dwc[2]))
			
		end if
			
		
		
	CASE 'c_sog_comm_des'		

		
		if (cbx_cod_barre.checked) = true then
			string ls_cod_sog, ls_rag_sog
			long ll_id_sog_com
			
			select id_sog_commerciale
			into :ll_id_sog_com
			from sog_com_barre
			where sog_com_barre.cod_barre = :data;
			
			choose case sqlca.sqlcode
				case 0
					select codice, rag_soc_1
					into :ls_cod_sog, :ls_rag_sog
					from sog_commerciale_gen
					where id_sog_commerciale = :ll_id_sog_com;
					
					this.post setitem(row,"c_sog_comm_cod",ls_cod_sog)
					this.post setitem(row,"c_sog_comm_des",ls_rag_sog)					
					data = ls_rag_sog
			end choose
		end if
		
		
		ls_intestatari =""
		if not (IsNull(is_int_consentiti) OR is_int_consentiti="")  then
			ll_len = Len(is_int_consentiti)
			for ll_count = 1 to ll_len
				ls_intestatari = ls_intestatari + ",'" + Mid(is_int_consentiti, ll_count, 1) + "'"
			next
			if not IsNull(ls_intestatari) then ls_intestatari = Mid(ls_intestatari, 2,Len(ls_intestatari)-1)
			ls_intestatari = "(" + ls_intestatari + ")"
		end if
		if not (IsNull(ls_intestatari) OR ls_intestatari="") then ls_sql_cond = "sog_commerciale_gen.tipo IN " + ls_intestatari
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_sog_comm_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_sog_comm_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"rag_soc_1","A",data,ls_sql_cond,3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			
			wf_azzera_campi_calcolati_sog(row)
			
			
			
			lc_bloccante = f_ann_sc(this.getitemnumber(row, "id_prof_documento"), GetItemNumber(row, "id_sog_commerciale"))
			if (lc_bloccante = "S") then
				PostEvent("ue_canc_intestatario")
			end if
			
			
			CHOOSE CASE uf_check_sospesi()
				CASE "OK"
					TriggerEvent("ue_set_sog_fields")
					post event ue_set_contropartita()
					return 2 
				CASE "AVVISA"
					MessageBox("Documento","Cliente Fuori Limite di Fido")
					TriggerEvent("ue_set_sog_fields")
					post event ue_set_contropartita()
					return 2
				CASE "BLOCCA"
					MessageBox("Documento","Cliente Fuori Limite di Fido")
					PostEvent("ue_canc_intestatario")
					return 1 
			END CHOOSE
			wf_controlla_destinazione(long(ls_dwc[2])			)
		end if
			
		
	CASE 'c_destinazione_des'
		
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_destinazione_des"
		ls_dbc[2] = "id_destinazione"
		ls_dwc[2] = "id_destinazione"
		li_ok = uf_autofind_col (string(dwo.name),"destinazione",&
										"rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
				return 2 
		end if
		
		
		u_setta_campi_documento uo_campi
		uo_campi = create u_setta_campi_documento
		uo_campi.uf_set_campi_destinazione(dw_documento_ordine_ff)
		destroy uo_campi
		
	CASE "id_con_pagamento", "id_con_pagamento_des"
		Post TriggerEvent("ue_set_con_pagamento")
		if this.getitemnumber(1,'id_documento')>0 then &
			wf_calcola_spese('S') 	

	case "documento_id_valuta_cod","documento_id_valuta_des"
		event ue_set_valu_fields(data)

	CASE "data_documento"
		
		ld_Data= GetItemDate(il_row, "data_registrazione")
		If not IsNull(ld_Data) then
			If DaysAfter(Date(data), ld_Data) < 0 then
				RETURN 1
			end if
		end if
		select tipo_registro
		into :ls_tipo_registro
		from dba.registro where id_registro=:il_id_registro;
		if ls_tipo_registro='IV' then
			ll_numero=GetItemNumber(il_row, "num_progressivo")
			uo_proponi_num_progressivo=create u_setta_campi_documento
			ld_Ultima_Data_Reg=uo_proponi_num_progressivo.uf_ver_num_data_coerenza(il_id_registro, 	ll_numero, 	Date(data))
			destroy uo_proponi_num_progressivo
			Post SetItem(il_row, "data_documento", ld_Ultima_Data_Reg) 	
		end if

	CASE 'c_vettore_cod'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_vettore_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "documento_id_sog_commerciale_vettore"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_vettore_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE 'c_vettore_des'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_vettore_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "documento_id_sog_commerciale_vettore"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_vettore_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"rag_soc_1","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE 'c_gruppo_agenti_cod'
		ls_dbc[1] = "codice"
		ls_dwc[1] = "c_gruppo_agenti_cod"
		ls_dbc[2] = "id_gruppo_agenti"
		ls_dwc[2] = "id_gruppo_agenti"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_gruppo_agenti_des"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			post event ue_set_contropartita()

			return 2 
		end if

	CASE 'c_gruppo_agenti_des'
		ls_dbc[1] = "descrizione"
		ls_dwc[1] = "c_gruppo_agenti_cod"
		ls_dbc[2] = "id_gruppo_agenti"
		ls_dwc[2] = "id_gruppo_agenti"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_gruppo_agenti_des"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			post event ue_set_contropartita()

			return 2 
		end if
	
	

	CASE "documento_id_valuta_cod", "documento_id_valuta_des"
		event ue_set_valu_fields(data)
	
	CASE "documento_cambio"
		
		idc_cambio = dec(data)
		idc_cambio=1/idc_cambio //agiunto 20220210 per alpa da verificare
		event ue_set_valu_fields("NO_CAMBIO")	

	CASE "id_val_acconto"
		appoggio = wf_setta_cambio(2,data)
	CASE "imp_acconto"
		appoggio = wf_setta_cambio(1,data)
	
	CASE "documento_sconto_finanziario"
		Event ue_calc_totale(string(data), ldc_null, ldc_null)

	CASE "documento_sconto_fin_cassa"
		Event ue_calc_totale(ls_null,Dec(data), ldc_null)

	CASE "sconto_fin_incondizionato"
		Event ue_calc_totale(ls_null, ldc_null,Dec(data))
	CASE "id_gruppo_agenti"
		post event ue_set_contropartita()
		
	
	integer li_ris
	long i
	
	CASE "data_prev_consegna"
		if idw_master.is_list.s_modo= modo_modifica then
			li_ris = messagebox("Attenzione","Eseguo la variazione della data consegna su tutte le righe del documento?",question!,yesno!)
			if li_ris = 1 then
				for i= 1 to tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
					tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(i,"riga_documento_data_prevista_consegna",date(data))
				next
			end if
		end if
	
		
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;string ls_intestatari, ls_int_cons,ls_tipo_reg, ls_tipo_registro
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

select id_azienda 
into:ll_id_sog_commerciale_fatt
from azienda;

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

	CASE "c_prof_doc_cod", "c_prof_doc_des"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		if as_nomecol="c_prof_doc_cod" then
			is_ricpar.s_filter_name = "prof_documento_codice" 
		else
			is_ricpar.s_filter_name = "prof_documento_descrizione" 
		end if	
		
		CHOOSE CASE is_tipo_documento
			CASE "O"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'OA' OR prof_documento.tipo_registro = 'OV'"
			CASE "D"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'DA' OR prof_documento.tipo_registro = 'DV'"
			CASE "F"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'IA' OR prof_documento.tipo_registro = 'IV' OR prof_documento.tipo_registro = 'IC'"
			CASE "G"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'GA' OR prof_documento.tipo_registro = 'GV'"
			CASE "P"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'PA' OR prof_documento.tipo_registro = 'PV'"


			
		END CHOOSE


	CASE "c_registro" , "c_registro_des"
		is_search_window = "w_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "registro_descrizione" 
		ll_id_prof_documento=GetItemNumber(il_row,"id_prof_documento")
		select tipo_registro
		into :ls_tipo_registro
		from prof_documento
		where id_prof_documento=:ll_id_prof_documento;
		
		If not(IsNull(ll_id_prof_documento) OR ll_id_prof_documento=0) then
			If not( IsNull(il_id_mod_registro) OR IsNull(il_id_esercizio) ) then
				
				is_ricpar.s_sql_cond  = "registro.id_esercizio = " + String(il_id_esercizio) + " AND  tipo_registro = '" + ls_tipo_registro + "'"				
				
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
		is_search_window = "w_destinazione_nosog_sw" 
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

event ue_use_search;
long ll_id_valuta , ll_id_tipo_trasporto, ll_id_sog_commerciale, ll_id_magazzino, ll_id_causale
long ll_id_loc2, ll_destinazione
char lc_bloccante	

CHOOSE CASE as_nomecol

	CASE "c_abi_cab_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_banca_sog_commerciale", is_ricpar.s_id_seg_value[1])

	CASE "c_prof_doc_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_doc_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("prof_documento_ric_acconti", is_ricpar.s_ausil_value[3])
		uf_set_colval("id_val_acconto", is_ricpar.s_id_seg_value[2])
		event ue_set_prof_fields()
		uf_abilita_contabilizza()
		
	CASE "c_prof_doc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_doc_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("prof_documento_ric_acconti", is_ricpar.s_ausil_value[3])
		uf_set_colval("id_val_acconto", is_ricpar.s_id_seg_value[2])
		event ue_set_prof_fields()
		uf_abilita_contabilizza()
	
	CASE "c_registro"
		uf_set_colval("c_registro_des", is_ricpar.s_main_value)
		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])
		
		uf_set_colval("c_registro", "Esercizio: " + string(is_ricpar.s_ausil_value[1]) + " - " + &
					  "Tipo: " + string(is_ricpar.s_ausil_value[2]) + " - " + &
					  "Numero: " + string(is_ricpar.s_ausil_value[3]))
		is_tipo_registro= string(is_ricpar.s_ausil_value[2])
		event ue_set_regi_fields()

	CASE "c_registro_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])
		

		uf_set_colval("c_registro", "Esercizio: " + string(is_ricpar.s_ausil_value[1]) + " - " + &
					  "Tipo: " + string(is_ricpar.s_ausil_value[2]) + " - " + &
					  "Numero: " + string(is_ricpar.s_ausil_value[3]))
		event ue_set_regi_fields()

	CASE "c_sog_comm_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_des", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_banca_sog_commerciale",is_ricpar.s_ausil_value[5])		
		uf_set_colval("c_abi_cab_des", is_ricpar.s_ausil_value[6])
		
				
		lc_bloccante = f_ann_sc(this.getitemnumber(this.getrow(), "id_prof_documento"), GetItemNumber(this.getrow(), "id_sog_commerciale"))
		if (lc_bloccante = "S") then
			PostEvent("ue_canc_intestatario")
		end if
		
		
		choose case uf_check_sospesi()
			case "OK"
				TriggerEvent("ue_set_sog_fields")
				post event ue_set_contropartita()
				
			case "AVVISA"
				MessageBox("Documento","Cliente Fuori Limite di Fido")
				TriggerEvent("ue_set_sog_fields")
				post event ue_set_contropartita()
				
			case "BLOCCA"
				MessageBox("Documento","Cliente Fuori Limite di Fido")
				PostEvent("ue_canc_intestatario")
				
				
		end choose
					wf_controlla_destinazione(long(is_ricpar.s_id_seg_value[1]))
	CASE "c_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("id_banca_sog_commerciale",is_ricpar.s_ausil_value[5])
		uf_set_colval("c_abi_cab_des", is_ricpar.s_ausil_value[6])
		
		wf_azzera_campi_calcolati_sog(getrow())
			
		
		
		
		
			
		
		
		
		
		lc_bloccante = f_ann_sc(this.getitemnumber(this.getrow(), "id_prof_documento"), GetItemNumber(this.getrow(), "id_sog_commerciale"))
		if (lc_bloccante = "S") then
			PostEvent("ue_canc_intestatario")
		end if
		
		
		choose case uf_check_sospesi()
			case "OK"
				TriggerEvent("ue_set_sog_fields")
				post event ue_set_contropartita()
				
			case "AVVISA"
				MessageBox("Documento","Cliente Fuori Limite di Fido")
				TriggerEvent("ue_set_sog_fields")
				post event ue_set_contropartita()
				
			case "BLOCCA"
				MessageBox("Documento","Cliente Fuori Limite di Fido")
				PostEvent("ue_canc_intestatario")
				
				
		end choose
			
		
			wf_controlla_destinazione(long(is_ricpar.s_id_seg_value[1]))
	CASE "c_destinazione_des"
		if isnull(is_ricpar.s_ausil_value[1]) then is_ricpar.s_ausil_value[1]=" "
		uf_set_colval(as_nomecol, is_ricpar.s_main_value + " "+is_ricpar.s_ausil_value[1])
		uf_set_colval("id_destinazione", is_ricpar.s_id_seg_value[1])
   	

		select id_magazzino
		into :ll_id_loc2
		from destinazione
		where id_destinazione=:is_ricpar.s_id_seg_value[1];
		
		if not isnull(ll_id_loc2) then
			setitem(getrow(),"documento_id_locazione_2", ll_id_loc2)
		end if
		
		
		u_setta_campi_documento uo_campi
		uo_campi = create u_setta_campi_documento
		uo_campi.uf_set_campi_destinazione(dw_documento_ordine_ff)
		destroy uo_campi
		
		
	CASE "c_vettore_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_vettore_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_cod", is_ricpar.s_ausil_value[1])

	CASE "c_gruppo_agenti_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_gruppo_agenti_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_gruppo_agenti_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_gruppo_agenti_cod", is_ricpar.s_ausil_value[1])


END CHOOSE

	choose case uf_controlla_blocco( long(idw_gen.uf_get_colval("documento_id_magazzino")),&
												date(idw_gen.uf_get_colval("data_registrazione"))    )
		case 1
			messagebox("attenzione!","il magazzino di origine è bloccato ~r~n Scegliere ( Altro ) per cambiare Magazzino " )
		end choose


if is_tipo_documento = "P" then
		idw_gen.object.tipo_fattura.protect = 1
		idw_gen.object.tipo_fattura.background.color = 12632256
else
		idw_gen.object.tipo_fattura.protect = 0
		idw_gen.object.tipo_fattura.background.color = 16777215
end if
end event

event ue_init;call super::ue_init;iudw_children[1] = tab_1.tabpage_2.dw_riga_documento_ordine_gd
iudw_children[2] = tab_1.tabpage_3.dw_documento_bolla_trasp_ff
iudw_children[3] = tab_1.tabpage_4.dw_documento_ord_tot_ff
iudw_children[4] = tab_1.tabpage_4.dw_spesa_documento_gd
iudw_children[5] = tab_1.tabpage_4.dw_scadenza_documento_lt
iudw_children[6] = tab_1.tabpage_4.dw_cast_iva_documento_lt
iudw_children[7] = tab_1.tabpage_5.dw_contr_documento_lt
is_title = is_nome_tipo_documento




end event

event ue_default;call super::ue_default;

string 	ls_codice, ls_Par_Menu_Cod, ls_tipo_registro, ls_descrizione
long 		ll_id_registro, ll_numero, ll_Cur_IDRegistro, ll_ID_Prof_Doc, ll_Ultimo_Num_Reg, ll_id_tipo_trasporto
long 		ll_id_intestatario, ll_id_con_pagam, ll_gg_prev_cons, ll_id_attivita, ll_id_esercizio
long 		ll_id_valuta, ll_id_agente, ll_id_dest, ll_id_sog_commerciale
date 		ld_Ultima_Data_Reg
decimal 	ldc_sconto_cassa
string	ls_dbc[], ls_dwc[], ls_dbv[]
integer	li_ok
long 	   ll_gg_scadenza 

ls_Par_Menu_Cod = trim(THIS.is_list.s_win_parametri)


ll_Cur_IDRegistro = GetItemNumber(al_row, "id_registro")
ll_ID_Prof_Doc = GetItemNumber(al_row, "id_prof_documento")
ll_id_intestatario=GetItemNumber(al_row, "id_sog_commerciale")

CHOOSE CASE string(adwo_current.name)
	
		

	CASE "num_progressivo"
		
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) THEN
			SELECT MAX("documento"."num_progressivo")
				INTO :ll_Ultimo_Num_Reg
				FROM "dba"."documento"   
				WHERE "documento"."id_registro" = :ll_Cur_IDRegistro;
	
			
			IF IsNull(ll_Ultimo_Num_Reg) THEN ll_Ultimo_Num_Reg = 0
			SetItem(al_row, "num_progressivo", (ll_Ultimo_Num_Reg+1))
		END IF

	CASE "data_registrazione"
		
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) THEN
			SELECT MAX("documento"."data_documento")
				INTO :ld_Ultima_Data_Reg
				FROM "dba"."documento"   
				WHERE "documento"."id_registro" = :ll_Cur_IDRegistro;
			
			
			IF IsNull(ld_Ultima_Data_Reg) THEN ld_Ultima_Data_Reg = Today()
			SetItem(al_row, "data_registrazione", ld_Ultima_Data_Reg)
			SetItem(al_row, "documento_data_competenza", ld_Ultima_Data_Reg)
		END IF

	CASE "documento_id_valuta_cod"
		
		
		select "par_sistema"."id_valuta"
			into :ll_id_valuta

			from "dba"."par_sistema"
			where "par_sistema"."id_azienda" = 1;

		SetItem(al_row, "documento_id_valuta_cod", ld_Ultima_Data_Reg)


	case "c_agente_cod","c_agente_des"
		
		ll_id_agente = u_freddie.gl_null
		ll_id_dest = this.GetItemNumber(al_row,"id_destinazione")
		if (not IsNull(ll_id_dest)) and (ll_id_dest>0) then
		end if
		if isNull(ll_id_agente) then
			ll_id_sog_commerciale = this.GetItemNumber(al_row,"id_sog_commerciale")

			SELECT "sog_commerciale"."id_gruppo_agenti"  
    			INTO :ll_id_agente  
    			FROM "dba"."sog_commerciale"  
   			WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale;
		end if
		if not isNull(ll_id_agente) then
			ls_dbc[1] = "codice"
			ls_dbc[2] = "descrizione"
			ls_dbc[3] = "id_gruppo_agenti"
			ls_dwc[1] = "c_gruppo_agenti_cod"
			ls_dwc[2] = "c_gruppo_agenti_des"
			ls_dwc[3] = "id_gruppo_agenti"
			li_ok = uf_autofind_col ("id_gruppo_agenti","gruppo_agenti",&
										"id_sog_commerciale","A",string(ll_id_agente),"",3,ls_dbc,ls_dbv,ls_dwc)
		end if
		
	CASE "data_prev_consegna"
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) AND NOT (IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc = 0) THEN

			ld_Ultima_Data_Reg=GetItemDate(al_row, "data_registrazione")
			
			SELECT gg_consegna, gg_scadenza
			INTO 	 :ll_gg_prev_cons, :ll_gg_scadenza
			FROM 	 prof_documento
			WHERE  id_prof_documento = :ll_ID_Prof_Doc 
			;
			
			If NOT IsNull(ll_gg_prev_cons) then SetItem(al_row, "data_prev_consegna", RelativeDate(ld_Ultima_Data_Reg, ll_gg_prev_cons))
			END IF	
		
			
			if not isnull(ll_gg_scadenza) then 
				setitem(al_row, "data_scadenza", relativedate(ld_ultima_data_reg, ll_gg_scadenza))
			end if
			
END CHOOSE

end event

event ue_update;
integer li_RetVal
if not isnull(idw_gen.uf_get_colval("documento_id_magazzino")) then
	choose case uf_controlla_blocco( long(idw_gen.uf_get_colval("documento_id_magazzino")),&
													date(idw_gen.uf_get_colval("data_registrazione"))    )
			case 1
				messagebox("attenzione!","il magazzino di origine è bloccato ~r~n Scegliere ( Altro ) per cambiare Magazzino ~r~n Attenzione Tutte le modifiche non salvate andranno perse" )
				return -1
			case 0
				li_RetVal = super::EVENT ue_update(wparam, lparam)
	
				uf_set_currow()
				event ue_set_not_new()
				RETURN li_RetVal 
				
	end choose
else

	
	li_RetVal = super::EVENT ue_update(wparam, lparam)
	
	uf_set_currow()
	event ue_set_not_new()
	RETURN li_RetVal 
end if


end event

event rowfocuschanged;

tab_1.tabpage_1.dw_documento_ordine_ff.object.c_destinazione_des.background.color=16777215
if currentrow>0 then
	if not ib_reset then
		
		post uf_set_currow()
		If IsNull(il_row) OR il_row = 0 then
			il_row=currentrow
			If IsNull(il_row) OR il_row = 0 then
				MessageBox(is_title,"ERRORE FATALE: Non è possibile considerare una riga di documento valida.", Exclamation!)
				HALt CLOSE 
			end if	
		end if	
		
		if GetItemStatus(il_row, 0,Primary!) = NewModified! OR GetItemStatus(il_row, 0,Primary!) = New! then
			this.Object.c_prof_doc_cod.Protect=0
			this.Object.c_prof_doc_des.Protect=0
		
			this.Object.c_sog_comm_cod.Protect=0
			this.Object.c_sog_comm_des.Protect=0
		else
			this.Object.c_prof_doc_cod.Protect=1
			this.Object.c_prof_doc_des.Protect=1
			this.Object.c_sog_comm_cod.Protect=1
			this.Object.c_sog_comm_des.Protect=1
		end if
	end if
end if
end event

event ue_itemerror;call super::ue_itemerror;long 		ll_id_registro, ll_numero, ll_num_prec, ll_num_succ, ll_ret_value, ll_days
long 		ll_Cur_IDRegistro, ll_num_suggerito_min, ll_num_suggerito_max,ll_id_documento
date 		ld_Data, ld_data_prec, ld_data_succ, ld_Old_Data
string 	ls_colonna, ls_message, ls_value, ls_prec ,ls_succ, ls_nome

SetNull(ll_ret_value)
CHOOSE CASE adwo_dwo.name

	CASE "data_documento"
		
		ld_Data= GetItemDate(al_row, "data_registrazione")
		ll_days= DaysAfter(Date(as_data), ld_Data)
		If not isNull(ll_days) then
			If ll_days < 0 then
				MessageBox("Documento", "Immettere una data di Documento e ~r precedente alla data di Registrazione.", Exclamation!)
				iuo_msg_log.uf_new_text("Immettere una data di Documento precedente alla data di Registrazione.",3)
				ll_ret_value = 1
			end if
		end if

	CASE "data_registrazione"
	
		ll_numero = GetItemNumber(al_row, "num_progressivo")
		ll_Cur_IDRegistro= GetItemNumber(al_row, "id_registro")
			if is_con_data_progressiva = 'S' then
				ld_Data=Date(as_data)
				if not IsNull(ll_Cur_IDRegistro) then
					iuo_msg_log.uf_new_text("Verifica della Data di Registrazione '" + String(ld_Data) + "'.",3)
					ld_Old_Data= GetItemDate(il_row, "data_registrazione")
					If ib_prot_modificato then
						SQLCA.sp_Ges_NumProg_DataReg(2,ll_Cur_IDRegistro, ll_numero, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ,ll_id_documento);	
					else
						SQLCA.sp_Ges_NumProg_DataReg(0,ll_Cur_IDRegistro, ll_numero, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ,ll_id_documento);	
					end if
					If IsNull(ld_Data) then 
					
						If not IsNUll(ld_data_prec) then ls_prec = "e~n successiva al '" + String(ld_data_prec) + "' "
						If not IsNUll(ld_data_succ) then ls_succ = "e~n precedente al '" + String(ld_data_succ) + "'"
						MessageBox(is_title, "La Data corretta deve esser" + ls_prec + ls_succ + ".", Information!)
						iuo_msg_log.uf_new_text("La Data corretta deve esser" + ls_prec + ls_succ + ".",4)
						Post SetItem(il_row, "data_registrazione", ld_Old_Data) 
					end if
			end if
		end if

		
END CHOOSE

IF (this.Describe(adwo_dwo.name + ".edit.required") = "yes") and  IsNull(ll_ret_value) AND IsNull(as_data) then
	ll_ret_value= 2
	ls_nome= Describe(adwo_dwo.name + "_t.text")
	MessageBox(is_title + " " + adwo_dwo.name, "Il campo " + ls_nome + " è obbligatorio :~rinserire quanto prima un valore.", Information!)
	iuo_msg_log.uf_new_text("Il campo è obbligatorio :~rinserire quanto prima un valore.", 3)
	ls_value= uf_get_colval(adwo_dwo.name)
	post uf_set_colval(adwo_dwo.name,ls_value)
end if

RETURN ll_ret_value



end event

event ue_validate_row;call super::ue_validate_row;

long 		ll_id_prof, ll_err_count, ll_id_doc_riferimento, ll_Cur_IDRegistro,ll_numero, ll_protocollo
string 	ls_ric_id_registro, ls_ric_num_progressivo, ls_ric_num_documento, ls_ric_id_caus_magazzino
string 	ls_ric_id_sog_comm, ls_ric_id_con_pagamento, ls_ric_id_sog_comm_agente, ls_ric_id_tipo_trasporto
string 	ls_ric_id_valuta, ls_ric_id_sog_comm_vettore_1, ls_note_intestazione_prop
string 	ls_aspetto_beni_prop, ls_trasp_mezzo_prop
string 	ls_ric_id_caus_trasporto ,ls_ric_volumi 
string 	ls_ric_pesi ,ls_ric_colli_documento ,ls_ric_data_trasporto ,ls_ric_trasp_mezzo ,ls_ric_asp_beni 
date		ld_Data, ld_data_prec, ld_data_succ
long 		ll_id_documento, ll_num_suggerito_max, ll_num_suggerito_min
string	ls_message
string 	ls_ric_data_scadenza 

ll_err_count=0
SetNull(ld_Data)
ll_Cur_IDRegistro= il_id_registro
ll_id_documento= il_id_documento

ll_id_prof=GetItemNumber(al_row, "id_prof_documento")
If not (IsNull(ll_id_prof) OR  ll_id_prof=0) then
	SELECT "prof_documento"."ric_id_registro",   
			"prof_documento"."ric_num_progressivo",   
			"prof_documento"."ric_num_documento",   
			"prof_documento"."ric_id_caus_magazzino",   
			"prof_documento"."ric_id_sog_comm",   
			"prof_documento"."ric_id_con_pagamento",   
			"prof_documento"."ric_id_sog_comm_agente",   
			"prof_documento"."ric_id_tipo_trasporto",   
			"prof_documento"."ric_id_valuta",   
			"prof_documento"."ric_id_sog_comm_vettore_1",
	
			"prof_documento"."ric_colli_documento",
			"prof_documento"."ric_pesi", 
			"prof_documento"."ric_volumi",  
			"prof_documento"."ric_id_caus_trasporto",
			"prof_documento"."ric_asp_beni",
			"prof_documento"."ric_trasp_mezzo", 
			"prof_documento"."ric_data_trasporto",
			"prof_documento"."ric_data_scadenza"
	 INTO :ls_ric_id_registro, 
			:ls_ric_num_progressivo,
			:ls_ric_num_documento, 
			:ls_ric_id_caus_magazzino,
			:ls_ric_id_sog_comm, 
			:ls_ric_id_con_pagamento, 
			:ls_ric_id_sog_comm_agente, 
			:ls_ric_id_tipo_trasporto,
			:ls_ric_id_valuta, 
			:ls_ric_id_sog_comm_vettore_1,
	
			:ls_ric_colli_documento,
			:ls_ric_pesi, 
			:ls_ric_volumi,  
			:ls_ric_id_caus_trasporto,
			:ls_ric_asp_beni,
			:ls_ric_trasp_mezzo, 
			:ls_ric_data_trasporto,
			:ls_ric_data_scadenza
	FROM "dba"."prof_documento"  
	WHERE "prof_documento"."id_prof_documento" = :ll_id_prof   
	;
	
	If SQLCA.SQLCode = 0 then
		
			if IsNull(uf_get_colval("id_registro")) then
				as_error_text= as_error_text + "~n  Il Registro non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		
		
			if IsNull(uf_get_colval("num_progressivo")) then
				as_error_text= as_error_text + "~n Il Numero Progressivo non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		
		If ls_ric_num_documento= "O" then 
			if IsNull(uf_get_colval("num_documento")) then
				as_error_text= as_error_text + "~n Il Numero del Documento non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		
		
			if IsNull(uf_get_colval("id_sog_commerciale")) then
				as_error_text= as_error_text + "~n L'Intestatario non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		
		If ls_ric_id_caus_magazzino= "O" then 
			if IsNull(uf_get_colval("documento_id_caus_magazzino")) then
				as_error_text= as_error_text + "~n La Causale di Magazzino non può essere nulla."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_con_pagamento= "O" then 
			if IsNull(uf_get_colval("id_con_pagamento")) then
				as_error_text= as_error_text + "~n La Condizione di Pagamento non può essere nulla."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_tipo_trasporto= "O" then 
			if IsNull(uf_get_colval("id_tipo_trasporto")) then
				as_error_text= as_error_text + "~n Il Tipo di Trasporto non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_sog_comm_agente= "O" then 
			if IsNull(uf_get_colval("id_gruppo_agenti")) then
				as_error_text= as_error_text + "~n L'Agente non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_valuta= "O" then 
			if IsNull(uf_get_colval("documento_id_valuta_des")) then
				as_error_text= as_error_text + "~n La Valuta non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_sog_comm_vettore_1= "O" then 
			if IsNull(uf_get_colval("documento_id_sog_commerciale_vettore")) then
				as_error_text= as_error_text + "~n Il Vettore non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		
		If ls_ric_data_scadenza="O" then 
			if IsNull(uf_get_colval("data_scadenza")) then
				as_error_text= as_error_text + "~n La data di scadenza del documento non può essere nulla."
				ll_err_count = ll_err_count + 1
			end if
		end if
		
		
		if is_tipo_documento <> "O" AND is_tipo_documento <> "P" then
			
			If ls_ric_colli_documento= "O" then 
				if IsNull(uf_get_colval("documento_num_colli")) then
					as_error_text= as_error_text + "~n Il Numero dei Colli non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_pesi= "O" then 
				if IsNull(uf_get_colval("documento_peso_netto")) then
					as_error_text= as_error_text + "~n Il Peso Netto non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_pesi= "O" then 
				if IsNull(uf_get_colval("documento_peso_lordo")) then
					as_error_text= as_error_text + "~n Il Peso Lordo non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_id_caus_trasporto= "O" then 
				if IsNull(uf_get_colval("documento_id_caus_trasporto")) then
					as_error_text= as_error_text + "~n La Causale di Trasporto non può essere nulla."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_asp_beni= "O" then 
				if IsNull(uf_get_colval("documento_asp_beni")) then
					as_error_text= as_error_text + "~n L' Aspetto dei Beni non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_trasp_mezzo= "O" then 
				if IsNull(uf_get_colval("documento_tras_mezzo")) then
					as_error_text= as_error_text + "~n Il Mezzo di Trasporto non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			
			If ls_ric_data_trasporto= "O" then 
				if IsNull(uf_get_colval("documento_data_trasporto")) then
					as_error_text= as_error_text + "~n La Data di Trasporto non può essere nulla."
					ll_err_count = ll_err_count + 1
				end if
			end if
		end if
	end if
else
	return 2
end if	
If uf_get_colval("tipo_fattura") = "C" OR uf_get_colval("tipo_fattura") = "D" then
	ll_id_doc_riferimento= GetItemNumber(al_row, "id_documento_padre")
	If IsNull(ll_id_doc_riferimento) OR ll_id_doc_riferimento=0 then
			as_error_text= as_error_text + "~n Per questo tipo di documento deve essere definito un Documento di Riferimento,~n è possibile accedervi tramite il bottone ~"Altro...~"."
	end if
end if
If ll_err_count > 0 then iuo_msg_log.uf_new_text(as_error_text, 2)
return ll_err_count

end event

event ue_insert;call super::ue_insert;

is_title = is_nome_tipo_documento
uf_set_currow()
event ue_set_esercizio()

end event

event doubleclicked;call super::doubleclicked;
CHOOSE CASE dwo.name
	CASE "c_esercizio"
		IF GetItemStatus(il_row, 0, Primary!) = New! OR GetItemStatus(il_row, 0, Primary!) = NewModified! THEN
			THIS.Object.c_esercizio.Protect = 0
			THIS.SetColumn("c_esercizio")
		END IF
END CHOOSE
end event

event ue_retrieve;call super::ue_retrieve;

uf_abilita_contabilizza()
uf_Set_Tipo_Doc()




end event

event updatestart;
string ls_time, ls_des_contabile, ls_cod_soggetto
long ll_row, ll_id_sog
integer li_ret

datastore ds_ver_prof
long ll_id_prof
string ls_num_doc
date ls_data




ls_des_contabile=getitemstring(getrow(), "des_contabile")
ll_row=getrow()
if isnull(ls_des_contabile) then ls_des_contabile = ""
char lc_tipo_fattura
lc_tipo_fattura=getitemstring(ll_row, "tipo_fattura")
ls_des_contabile=""	
choose case lc_tipo_fattura
	case 'N'
		ls_des_contabile="Fattura n° "+ getitemstring(ll_row, "num_documento")
	case 'C'
		ls_des_contabile="Nota Credito n° "+ getitemstring(ll_row, "num_documento")
	case 'D'
		ls_des_contabile="Nota Debito n° "+ getitemstring(ll_row, "num_documento")
end choose
ls_des_contabile=ls_des_contabile+" del " + string(getitemdate(ll_row, "data_documento"))
setitem(ll_row, "des_contabile", ls_des_contabile)

long ll_causale,ll_loc1,ll_loc2
string ls_loc1,ls_loc2
ll_loc1=long(idw_gen.uf_get_colval("documento_id_locazione_1"))
ll_loc2=long(idw_gen.uf_get_colval("documento_id_locazione_2"))
ll_causale = long(idw_gen.uf_get_colval("documento_id_caus_magazzino")  )
select mag_par_richiesto, mag_des_richiesto
into :ls_loc1, :ls_loc2
from caus_magazzino
where id_caus_magazzino= :ll_causale;
if sqlca.sqlcode=0 then
	if ls_loc1='S' and isnull(ll_loc1) then
		messagebox("Errore","Non è stata impostata nessuna locazione di partenza!",stopsign!)
		return 1
	end if
	if ls_loc2='S' and isnull(ll_loc2) then
		messagebox("Errore","Non è stata impostata nessuna locazione di destinazione!",stopsign!)
		return 1
	end if
	if ls_loc1='N' and not isnull(ll_loc1) then
		messagebox("Informazione","E' stata impostata una locazione di partenza che non sarà utilizzata!")
	end if	
	if ls_loc2='N' and not isnull(ll_loc2) then
		messagebox("Informazione","E' stata impostata una locazione di destinazione che non sarà utilizzata!")
	end if	
end if

decimal ld_acconto
long ll_iva, ll_pagamento


ld_acconto=getitemdecimal(1, "imp_acconto")
ll_iva=getitemnumber(1, "id_tab_iva_acconto")
ll_pagamento=getitemnumber(1, "id_tipo_pag_acconto")
if ld_acconto>0 and isnull(ll_iva) and isnull(ll_pagamento) then
	messagebox("Errore!", "Deve essere specificato il pagamento!~r~nIl documento non sarà salvato!")
	
	return 1
end if

if il_doppio_doc=0 and idw_master.is_list.s_modo = modo_inserisci then
	il_doppio_doc=1
	long ll_id_registro, ll_num_prog, ll_id_reg2, ll_num_prog2
	date ld_data_reg, ld_data_reg2
	string ls_msg
	integer li_risp
	
	
	ll_id_registro = getitemnumber(ll_row,"id_registro")
	ll_num_prog    = getitemnumber(ll_row,"num_progressivo")
	ld_data_reg    = getitemdate(ll_row,"data_registrazione")

	select id_registro, num_progressivo, data_registrazione
	into :ll_id_reg2, :ll_num_prog2, :ld_data_reg2
	from documento
	where id_registro = :ll_id_registro
	and num_progressivo = :ll_num_prog
	and data_registrazione = :ld_data_reg;


	if sqlca.sqlcode = 0 then 
		ls_msg = "Un altro utente ha già registrato il documento con il numero: " + string(ll_num_prog) + " Assegno un nuovo numero?"
		li_risp = messagebox ("ATTENZIONE!",ls_msg,Question!, YesNo!) 
		if li_risp = 1 then 
			event ue_set_regi_fields()
			
		end if
		
		return 5
	end if
end if	


ds_ver_prof=create datastore
ds_ver_prof.dataobject="d_verifica_val_prof"
ds_ver_prof.settransobject(sqlca)

ll_row=idw_gen.getrow()
ll_id_prof=getitemnumber(ll_row, "id_prof_documento")

li_ret=ds_ver_prof.retrieve(ll_id_prof)
if li_ret>0 then 	
	
	
	ls_des_contabile=ds_ver_prof.getitemstring(1, "obbligatori")
	if pos(ls_des_contabile, "N") > 0 then
		ls_num_doc=idw_gen.getitemstring(ll_row, "num_documento")
		if isnull(ls_num_doc) or ls_num_doc='' then
			messagebox("Attenzione!", "Il numero del documento deve essere inserito! ~r~nSalvataggio non effettuato")
			destroy(ds_ver_prof)
			return 1
		end if
	end if
	if pos(ls_des_contabile, "D") > 0 then
		ls_data=idw_gen.getitemdate(ll_row, "data_documento")
		if isnull(ls_data) or ls_data<=date('1901-01-01') then
			messagebox("Attenzione!", "La data del documento deve essere inserita! ~r~nSalvataggio non effettuato")
			destroy(ds_ver_prof)
			return 1
		end if
	end if
	if pos(ls_des_contabile, "S") > 0 then
		ls_data=idw_gen.getitemdate(ll_row, "data_prev_consegna")
		if isnull(ls_data) or ls_data<=date('1901-01-01') then
			messagebox("Attenzione!", "La data di scadenza deve essere inserita! ~r~nSalvataggio non effettuato")
			destroy(ds_ver_prof)
			return 1
		end if
	end if	
end if
destroy(ds_ver_prof)


end event

event updateend;if isvalid(ids_anticipi) then
	
		post wf_setta_evasione_anticipi(ids_anticipi)
end if

uf_set_title()



if rowsinserted > 0 then 
	wf_set_utedocumento("ID")
	wf_calcola_spese('N')	
end if
//inserito 27052015
if rowsupdated >0 then
	wf_set_utedocumento("UD")
end if
if rowsdeleted >0 then
	wf_set_utedocumento("DD")
end if
//fine
end event

event sqlpreview;String ls_SQLSyntax

If il_id_documento <> 0 then
	
	Ls_SQLSyntax = SQLSyntax + " AND documento.id_documento = " + String(il_id_documento)

	if This.SetSQLPreview(ls_SQLSyntax)<>1 then
		messagebox("Errore!", "sqlpreview, dw_documento_ordine_ff, 14")
	end if
End If

if sqltype = PreviewInsert! then
	Post wf_set_utedocumento('I')
end if
end event

event retrieveend;
decimal ld_tara
string  ls_targa
long ll_row

ll_row = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getrow()
if ll_row>0 then
	ls_targa =getitemstring(ll_row, "documento_targa_mezzo_trasporto")

	
	if not(isnull(ls_targa)) and (ls_targa>'') then
		SELECT tara
		INTO   :ld_tara
		FROM   mezzo_trasporto
		WHERE  targa = :ls_targa
		;

		if (SQLCA.SQLCODE = 0) then
			tab_1.tabpage_3.dw_documento_bolla_trasp_ff.setitem(ll_row, "tara", ld_tara)
		end if
	end if
end if
end event

event clicked;string 			ls_column, ls_prot, ls_colval
string 			ls_nomedwo, ls_tipodwo
string			ls_eval_expr
w_search_main	lw_sm
s_ric_param ls_ricparm

ls_nomedwo = dwo.name
ls_tipodwo = dwo.type
ls_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 3)
if ((ls_tipodwo="bitmap") and (right(ls_nomedwo,3)="_sw")) then
	ls_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 3)
	ls_prot = describe(ls_column+".protect")
	
	IF NOT IsNumber(ls_prot) THEN
		ls_prot = Right(ls_prot, Len(ls_prot) - Pos(ls_prot, "~t"))
		ls_eval_expr = "Evaluate(~"" + ls_prot + ", " + string(row) + ")"
		ls_prot = Describe(ls_eval_expr)
	END IF

	if ls_prot = "0" then
		
		
		if row <> GetRow() then scrolltorow(row)
		
		if getColumnName() <> ls_column then
			ib_during_f4 = true
			setcolumn(ls_column)
			ib_during_f4 = false
		end if
		
		ls_colval = gettext()
		
		
		
		
		is_ricpar.s_caller_column = dwo.name
		is_ricpar.s_sql_cond = ""
		is_ricpar.b_imm_insert = false
		is_ricpar.b_imm_retrieve = false
		is_search_window = ""
		trigger event ue_set_search (ls_column, ls_colval)
		ib_during_f4 = true
		OpenWithParm (lw_sm,is_ricpar,is_search_window)
		ib_during_f4 = false
		
		
		
		
		
		is_ricpar = Message.PowerObjectParm
		IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
			trigger event ue_use_search (ls_column)
		end if
	end if
end if



end event

event dberror;
if sqldbcode=-196 then
	messagebox("Salvataggio fallito!", "Si sta tentando di inserire un documento~r~n"&
	+"con numero protocollo già esistente")

			
	return 1
else
	call super::dberror
end if

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2907
integer height = 1640
long backcolor = 79741120
string text = "Righe"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
p_arrow p_arrow
pb_sort pb_sort
cb_ricalcola cb_ricalcola
dw_riga_documento_ordine_gd dw_riga_documento_ordine_gd
pb_note pb_note
cb_5bis cb_5bis
pb_tree_sort pb_tree_sort
dw_riga_documento_dett_ord_ff dw_riga_documento_dett_ord_ff
end type

on tabpage_2.create
this.p_arrow=create p_arrow
this.pb_sort=create pb_sort
this.cb_ricalcola=create cb_ricalcola
this.dw_riga_documento_ordine_gd=create dw_riga_documento_ordine_gd
this.pb_note=create pb_note
this.cb_5bis=create cb_5bis
this.pb_tree_sort=create pb_tree_sort
this.dw_riga_documento_dett_ord_ff=create dw_riga_documento_dett_ord_ff
this.Control[]={this.p_arrow,&
this.pb_sort,&
this.cb_ricalcola,&
this.dw_riga_documento_ordine_gd,&
this.pb_note,&
this.cb_5bis,&
this.pb_tree_sort,&
this.dw_riga_documento_dett_ord_ff}
end on

on tabpage_2.destroy
destroy(this.p_arrow)
destroy(this.pb_sort)
destroy(this.cb_ricalcola)
destroy(this.dw_riga_documento_ordine_gd)
destroy(this.pb_note)
destroy(this.cb_5bis)
destroy(this.pb_tree_sort)
destroy(this.dw_riga_documento_dett_ord_ff)
end on

type p_arrow from picture within tabpage_2
boolean visible = false
integer y = 176
integer width = 32
integer height = 68
boolean bringtotop = true
boolean originalsize = true
string picturename = "s:\pb\cometa\sel_riga.bmp"
boolean focusrectangle = false
end type

type pb_sort from picturebutton within tabpage_2
integer x = 2245
integer y = 748
integer width = 96
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "s:\pb\commonframework\sort_on.bmp"
alignment htextalign = left!
end type

event clicked;integer li_ret
long i

li_ret=uf_Rinumera_Righe(0)
if li_ret=0 and IsValid(ids_lotti) then
	for i=1 to ids_lotti.RowCount()
		ids_lotti.SetItem(i,"num_riga",ids_lotti.GetItemNumber(i,"num_riga")*1000)
	next
end if
end event

event rbuttondown;integer li_ret
long i

li_ret=uf_Rinumera_Righe(1)
if li_ret=0 and IsValid(ids_lotti) then
	for i=1 to ids_lotti.RowCount()
		ids_lotti.SetItem(i,"num_riga",ids_lotti.GetItemNumber(i,"num_riga")*1000)
	next
end if
end event

type cb_ricalcola from commandbutton within tabpage_2
integer x = 2473
integer y = 748
integer width = 233
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricalcola"
end type

event clicked;long ll_row, ll_nr_row

ll_nr_row= idw_riga.RowCount()
FOR  ll_row =1 to  ll_nr_row
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_riga (ll_row)
next
uf_report_righe()
end event

type dw_riga_documento_ordine_gd from u_dw_master_main within tabpage_2
event type integer ue_setta_prezzo ( )
event type string ue_get_nrcolval ( integer al_column )
event type long ue_setta_un_conf ( )
event ue_setta_rif_des_agg ( )
event ue_set_arti_riga ( )
event ue_set_ucon_riga ( )
event type integer ue_set_calc_riga ( long al_row )
event ue_set_comp_riga ( )
event type integer ue_wiz_insert ( )
event ue_wiz_getfocus ( )
event type integer ue_set_calc_tot_riga ( long al_row,  decimal adc_quantita,  decimal adc_prezzo_netto,  boolean ab_calc_sconto )
event ue_set_contropartita ( )
event ue_lb_down pbm_lbuttondown
event type integer ue_rec_prezzo ( long row,  decimal qta )
event ue_post_itemchanged ( long al_riga,  string as_colonna,  string as_message )
string tag = "Righe di Documento"
integer x = 9
integer y = 12
integer width = 2825
integer height = 884
integer taborder = 10
string dragicon = "Asterisk!"
string dataobject = "d_riga_documento_ordine_gd"
boolean vscrollbar = true
boolean livescroll = false
end type

event ue_setta_prezzo;call super::ue_setta_prezzo;
long 			ll_id_un_confezione, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value
decimal 		ldc_ret_value, ldc_fat_conversione, ldc_molteplicita, ldc_quantita, ldc_fattore, ldc_totale
date 			ld_comp
string 		ls_tipo_conversione, ls_sconto

ll_row= GetRow()

ll_id_un_confezione= GetItemNumber(ll_row, "riga_documento_id_unita_confezione")
ll_id_listino=GetItemNumber(ll_row, "riga_documento_id_listino")
ld_comp= idw_gen.GetItemDate(il_row, "data_registrazione")

ls_sconto = uf_get_colval("sconto")
ldc_ret_value=uf_calcola_prezzo(ls_sconto, ldc_ret_value, uf_GetItemDecimal(ll_row, "quantita"))
if not IsNull(ldc_ret_value) then 
	
	SetItem(ll_row,"riga_documento_prezzo_netto",Truncate(ldc_ret_value, 0))
	ldc_quantita=uf_GetItemDecimal(ll_row, "quantita")
	if GetItemString(ll_row,"c_unita_conf_tipo_conversione") = 'D' then
		ldc_fattore=1 / uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	else
		ldc_fattore=uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	end if
	ldc_molteplicita=uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
	if IsNull(ldc_molteplicita) then ldc_molteplicita= 0
	ldc_totale= ldc_quantita * Truncate(ldc_ret_value, 0) * ldc_fattore * ldc_molteplicita
	
	SetItem(ll_row,"qta_un_base", ldc_totale)
end if

return ll_ret_value

end event

event ue_setta_rif_des_agg;
end event

event ue_set_arti_riga();

long				ll_num_colli
decimal			ld_quantita

long 				ll_id_articolo, ll_id_lingua, ll_id_linguaggio, ll_id_prof_doc
long				ll_id_sog_commerciale, ll_id_unita_confezione, ll_id_tab_iva, ll_row
string			ls_tipo_iva


ll_row=GetRow()
POST WF_METTI_DESCRIZIONE(LL_ROW)
ll_id_sog_commerciale = idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
ll_id_articolo = GetItemNumber(ll_row, "riga_documento_id_articolo")

ll_id_unita_confezione = getitemnumber(ll_row, "riga_documento_id_unita_confezione")	

if (isnull(ll_id_unita_confezione) or ll_id_unita_confezione <= 0) then
	
	SELECT id_unita_confezione, num_colli
	INTO 	 :ll_id_unita_confezione, :ll_num_colli  
	FROM 	 unita_confezione  
	WHERE  id_articolo = :ll_id_articolo
	AND    unita_base = 'S'
	;
	
	if (sqlca.sqlcode = -1) then
		messagebox("dberror", sqlca.sqlerrtext)
	end if	
end if

SELECT num_colli
INTO 	 :ll_num_colli  
FROM 	 unita_confezione  
WHERE  id_unita_confezione = :ll_id_unita_confezione
;

if (sqlca.sqlcode = -1) then
	messagebox("dberror", sqlca.sqlerrtext)
end if


if (not IsNull(ll_id_unita_confezione)) and (ll_id_unita_confezione > 0) then
	if (not isnull(ld_quantita) and ld_quantita > 0) then ll_num_colli=ll_num_colli*ld_quantita
	setitem(ll_row,"riga_documento_num_colli", ll_num_colli)
	triggerevent("ue_set_ucon_riga")
end if

//cerco nella tabella di personalizzazione (sog_profilo_personalizza)
ll_id_prof_doc=idw_gen.getitemnumber(1, "id_prof_documento")
ll_id_tab_iva=f_rec_iva_riga_doc(ll_id_prof_doc, ll_id_sog_commerciale, ll_id_articolo)
if isnull(ll_id_tab_iva) then
	messagebox("Attenzione!", "Iva NON trovata!")
else
		setitem(ll_row, "riga_documento_id_tab_iva", ll_id_tab_iva)
end if
//select id_tab_iva
//into :ll_id_tab_iva
//from dba.sog_profilo_personalizza
//where id_sog_commerciale=:ll_id_sog_commerciale
//and id_prof_documento=:ll_id_prof_doc
//;
//if ll_id_tab_iva>0 then
//	uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
//else //cerco nel soggetto commerciale
//	SELECT "tab_iva"."tipo_iva", "tab_iva"."id_tab_iva"
//	INTO :ls_tipo_iva, :ll_id_tab_iva
//	FROM "dba"."sog_commerciale", "dba"."tab_iva"  
//	WHERE ( "tab_iva"."id_tab_iva" = "sog_commerciale"."id_tab_iva" ) and  
//			( ( "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) ) ;
//
//	if ls_tipo_iva > '' then
//		uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
//	else //cerco nell'articolo
//		
//		SELECT "articolo"."id_tab_iva"  
//			INTO :ll_id_tab_iva  
//			FROM "dba"."articolo"
//			WHERE "articolo"."id_articolo" = :ll_id_articolo ;
//	
//		if (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then //cerco nella cat_comerciale dell'articolo
//			
//			SELECT "cat_com_articolo"."id_tab_iva"  
//				INTO :ll_id_tab_iva  
//				FROM "dba"."articolo",   
//				"cat_com_articolo"  
//				WHERE ( "cat_com_articolo"."id_cat_com_articolo" = "articolo"."id_cat_com_articolo" ) and  
//				( ( "articolo"."id_articolo" = :ll_id_articolo ) )   ;
//		end if
//		if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then //qui dovrebbe esserci...
//			uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
//		end if
//	end if
//end if

tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.event ue_vis_esi_disponibilita()
wf_cal_costi()	
end event

event ue_set_ucon_riga;


long			ll_id_unita_conf, ll_num_colli
decimal		ld_molt, ld_fatconv, ld_fatglob, ld_qta_proposta, ld_qta
string		ls_tipoconv

ll_id_unita_conf = long(uf_get_colval("riga_documento_id_unita_confezione"))
ld_qta = dec(uf_get_colval("quantita"))

SELECT fat_conversione, molteplicita, tipo_conversione, num_colli
INTO	 :ld_fatconv, :ld_molt, :ls_tipoconv, :ll_num_colli
FROM	 unita_confezione
WHERE  id_unita_confezione = :ll_id_unita_conf
;

if (SQLCA.SQLCODE = 0) then
	
	

	if ( ld_qta = 0 or isnull(ld_qta) ) then
		

		
		long 		ll_id_prof_documento
		ll_id_prof_documento = idw_gen.getitemnumber(1, "id_prof_documento")
		
		SELECT quantita_prop_riga
		INTO	 :ld_qta_proposta
		FROM	 prof_documento
		WHERE  id_prof_documento = :ll_id_prof_documento
		;
		
		
		if (SQLCA.SQLCODE = 0) then
			if (not isnull(ld_qta_proposta)) and (ld_qta_proposta > 0) then
				uf_set_colval("quantita",string(ld_qta_proposta))
				
				if (ll_num_colli > 0) and (not isnull(ll_num_colli)) then
					ll_num_colli = ll_num_colli * ld_qta_proposta
					uf_set_colval("riga_documento_num_colli",string(ll_num_colli))
				end if
				
			end if
		end if
	end if

	uf_set_colval("riga_documento_fat_con_unita_base",string(ld_fatconv))
	uf_set_colval("c_unita_conf_tipo_conversione", string(ls_tipoconv))
	uf_set_colval("c_unita_conf_molteplicita", string(ld_molt))
	If ls_tipoconv = "D" then
		uf_set_colval("fat_con_globale", string(ld_fatconv / ld_molt))
	else
		uf_set_colval("fat_con_globale", string(ld_fatconv * ld_molt))		
	end if

	
	long ll_row
	ll_row = getrow()
	
	
	
	if (not isnull(ld_qta_proposta)) and (ld_qta_proposta > 0) then
		
		dwobject	my_dwo
		my_dwo = this.object.quantita
		this.trigger event itemchanged(ll_row, my_dwo, string(ld_qta_proposta))		
		
	end if
	
	
	
end if




end event

event ue_set_calc_riga;

decimal		ld_QTA_UB, ld_QTA, ld_QTA_SM, ld_Prezzo_Netto, ld_Sconti, ld_Totale_Riga
decimal		ld_Cambio, ld_Sconto_Riga, ld_QTA_Evasa_UB, ld_Qta_Evasa, lcd_null
decimal		ld_Prezzo, ld_Quantita, ld_Totale_Riga_Lire, ld_Qta_Effettiva, ld_Totale_Riga_val
string		ls_Sconto, ls_tipoconv, ls_tipo_arrotondamento
decimal		ld_fatconv, ld_fatglob, ld_molt, ld_cambio_riga, ld_cambio_documento
long			ll_row, ll_id_valuta_riga, ll_valuta_documento, ll_nr_cifre_arrot


if al_row>0 then
	ll_row= al_row
	
	SetNull(lcd_null)
	ls_tipoconv = GetItemString(ll_row,"c_unita_conf_tipo_conversione")
	ld_fatconv = uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	ld_molt =uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
	
	
	ld_prezzo=getitemdecimal(al_row, "prezzo")
	
	
	
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
	
	
	
	
	ls_Sconto= GetItemString(ll_row, "sconto")
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
	
	SELECT "valuta"."cifra_arrotondamento",
		"valuta"."tipo_arrotondamento"
		INTO :ll_nr_cifre_arrot ,
				:ls_tipo_arrotondamento
		FROM "dba"."valuta"  
		WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
	
	if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
	ld_cambio_riga= GetItemNumber(ll_row, "riga_documento_cambio")
	if IsNull(ld_cambio_riga) then ld_cambio_riga=1
	
	ld_Prezzo_Netto= uf_calcola_prezzo(ls_Sconto, ld_Prezzo, 1)
	
	decimal ld_importo_sconto_riga
	string ls_um, ls_tipo
	long ll_id_un_conf
	decimal ld_peso_netto
	ld_importo_sconto_riga=getitemdecimal(ll_row, "riga_documento_sconto_riga")
	ll_id_un_conf=getitemnumber(al_row, "riga_documento_id_unita_confezione")
	select simbolo, tipo
	into :ls_um, :ls_tipo
	from unita_confezione, unita_misura
	where (unita_confezione.id_unita_confezione=:ll_id_un_conf) 
	and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
	
	ld_peso_netto=getitemdecimal(al_row, "riga_documento_peso_netto")
	
	
	
	if (ld_qta > 0 and ld_importo_sconto_riga > 0) then
			ld_importo_sconto_riga=ld_importo_sconto_riga/ld_qta
	end if
	if (ld_importo_sconto_riga > 0) then
		ld_Prezzo_Netto=ld_Prezzo_Netto - ld_importo_sconto_riga
	end if
			
	
	
	ld_Prezzo_Netto=f_Round(ld_Prezzo_Netto ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
	
	if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0
	
	SetItem(ll_row, "riga_documento_prezzo_netto",ld_Prezzo_Netto)
	
	event ue_set_calc_tot_riga(ll_row, lcd_null, ld_Prezzo_Netto, FALSE)
	
end if
return 0


end event

event ue_set_comp_riga;
	

end event

event ue_wiz_insert;call super::ue_wiz_insert;
long ll_last_row
SetFocus()
SetRedraw(FALSE)
TriggerEvent("ue_insert")
ll_last_row= idw_riga.RowCount()
SetRow(ll_last_row)
SetColumn("c_articolo_cod")
SetRedraw(TRUE)
return 0

end event

event ue_wiz_getfocus;call super::ue_wiz_getfocus;
long ll_current_row

SetFocus()
ll_current_row= idw_riga.GetRow()
SetRow(ll_current_row)
SetColumn("c_articolo_cod")



end event

event type integer ue_set_calc_tot_riga(long al_row, decimal adc_quantita, decimal adc_prezzo_netto, boolean ab_calc_sconto);
long			ll_row, ll_nr_cifre_arrot, ll_id_valuta_riga, ll_valuta_documento
string		ls_tipo_arrotondamento, ls_tipo_Arr
decimal		ldc_sconto_riga, ldc_totale_riga, ldc_Totale_Riga_val, ldc_Prezzo, ldc_Sconto
decimal		ldc_cambio, ldc_totale_riga_lire, adc_quantita_SM, adc_quantita_Effettiva
long			ll_cifra_arr
ll_row=al_row

if ll_row>0 and  not isnull(ll_row) then
	if IsNull(adc_quantita) then adc_quantita= uf_GetItemDecimal(ll_row, "quantita")
	
	if IsNull(adc_Prezzo_Netto) then	adc_Prezzo_Netto= uf_GetItemDecimal(ll_row, "riga_documento_prezzo_netto")
	
	if not IsNull(adc_Prezzo_Netto) then 
		if IsNull(adc_quantita) then adc_quantita=0
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		ll_valuta_documento= idw_gen.GetItemNumber(1, "documento_id_valuta_des")
		ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")
		
		SELECT "valuta"."cifra_arrotondamento",
			"valuta"."tipo_arrotondamento"
			INTO :ll_nr_cifre_arrot ,
					:ls_tipo_arrotondamento
			FROM "dba"."valuta"  
			WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
		
		if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
		
		ldc_cambio= GetItemNumber(ll_row, "riga_documento_cambio")
		
		if IsNull(ldc_cambio) then ldc_cambio=1
		
				
		
		adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
			if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
			adc_quantita_Effettiva= adc_quantita 

		
		long ll_id_art
		decimal ld_peso
		
		ll_id_art=GetItemNumber(al_row,"riga_documento_id_unita_confezione")
		ld_peso=GetItemDecimal(al_row,"riga_documento_peso_netto")
		
		ldc_Totale_Riga= wf_trova_prezzo(ll_id_art, adc_quantita_Effettiva, ld_peso, adc_Prezzo_Netto)
		
		
		
		
		select cifra_arrotondamento, tipo_arrotondamento
		into   :ll_cifra_arr, :ls_tipo_arr
		from   valuta
		where  id_valuta = :al_id_val_az;
		
		if (sqlca.sqlcode = -1) then messagebox("dberror", sqlca.sqlerrtext)
		
		
		
		
		
		
		ldc_Totale_Riga= f_Round(ldc_Totale_Riga, ll_cifra_arr, "M")
		
		
		SetItem(ll_row, "tot_riga_val_riga",ldc_Totale_Riga)
		
		
		
		
			adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
			if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
			adc_quantita_Effettiva= adc_quantita + adc_quantita_SM
		
		if not(IsNull(adc_quantita_Effettiva) OR adc_quantita_Effettiva=0) then SetItem(ll_row, "riga_documento_val_attribuito",ldc_Totale_Riga / adc_quantita_Effettiva)
		
		if IsNull(ldc_Cambio) OR ldc_Cambio=0 then ldc_Cambio=1		
		ldc_Totale_Riga_Lire= ldc_Totale_Riga * ldc_Cambio
		
		
		
		SetItem(ll_row, "tot_riga_val_az",f_round(ldc_Totale_Riga_Lire,ll_cifra_arr, "M"))

		if ll_id_valuta_riga = ll_valuta_documento then
			SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga)
		else
			
			//if IsNull(idc_cambio) then idc_cambio=0
			//ldc_Totale_Riga_val= ldc_Totale_Riga_Lire / idc_cambio
			ldc_Totale_Riga_val= ldc_Totale_Riga_Lire / ldc_cambio
			
			if IsNull(il_arrotondamento) then il_arrotondamento=0
			
			
			ldc_Totale_Riga_val= f_round(ldc_Totale_Riga_val, ll_cifra_arr, "M")
			
			
			
			SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga_val)
		end if
	
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
end if
return 0



end event

event ue_set_contropartita;

long		ll_row, ll_id_articolo, ll_id_contropartita, ll_id_causale
long		ll_id_sog_commerciale, ll_id_agente, LL_IDAZ
u_setta_campi_documento u_cerca_cpt
u_cerca_cpt=create u_setta_campi_documento
ll_id_sog_commerciale= idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
ll_id_agente=  idw_gen.GetItemNumber(il_row, "id_gruppo_agenti")
ll_row= GetRow()
ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
ll_id_causale=GetItemNumber(ll_row, "riga_documento_id_caus_magazzino")

ll_id_contropartita= wf_calcola_cpt(ll_id_sog_commerciale, ll_id_agente, ll_id_articolo, ll_id_causale)



SetItem(ll_row, "riga_documento_id_conto", ll_id_contropartita)

end event

event ue_lb_down;call super::ue_lb_down;
long			ll_row, ll_pos
string		ls_dati, ls_riga

If ib_rinumera_righe then
	ll_row = 0
	ls_dati = this.GetObjectAtPointer()
	ll_pos = pos(ls_dati,"~t")
	if ll_pos>0 then
		ls_riga = mid(ls_dati,ll_pos+1)
		il_drag_row = Long(ls_riga)
	end if
	if (il_drag_row > 0 ) then
		This.ScrollToRow(il_drag_row)
		This.Drag(begin!)
	else
		this.Drag(end!)
	end if
end if

end event

event ue_rec_prezzo;

integer ll_return, ll_riga_corrente
string ls_tras_mezzo
long    ll_id_trasporto 


ls_tras_mezzo=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemstring(1, "tras_mezzo")
ll_id_trasporto=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber(1, "id_tipo_trasporto_des") 

ll_return = f_rec_prezzo(row, qta, tab_1.tabpage_1.dw_documento_ordine_ff, this, ls_tras_mezzo, ll_id_trasporto)

if (ll_return = 1) then
	ll_riga_corrente = getrow()
	post event ue_set_calc_riga(ll_riga_corrente)
end if

return ll_return
end event

event ue_post_itemchanged;
if as_message >"" then
	messagebox("Attenzione!", as_message)
end if
setitem(al_riga, as_colonna, 0)
setcolumn(as_colonna)
end event

event ue_init;call super::ue_init;
iudw_children[1] = dw_riga_documento_dett_ord_ff
				
is_list.s_identifica[1] = "id_documento"
is_list.s_win_zoom = "w_riga_documento_wz"
end event

event ue_set_search;call super::ue_set_search;string ls_riga_descrittiva
long ll_id_art, ll_id_utente


this.Object.DataWindow.Selected.Mouse = "No"

CHOOSE CASE as_nomecol
	CASE "riga_documento_descrizione"
		is_ricpar.s_filter_value = as_valcol 
		
		if (ii_ricerca_art_fornitore = 1) then
			is_search_window = "w_des_articolo_coddes_documento_sw" 
			is_ricpar.s_filter_name = "des_articolo_descrizione"
		else
			is_search_window = "w_articolo_coddes_documento_sw" 
			is_ricpar.s_filter_name = "articolo_descrizione" 
		end if
		
		is_ricpar.b_asneeded=TRUE
	CASE "c_articolo_cod"
		is_ricpar.s_filter_value = trim(as_valcol) 
		is_ricpar.l_id_doc=idw_gen.getitemnumber(1, "id_documento")
		// 15-03-2014 se è Paolo filtro scremando tutti gli articoli della vecchia silverp )(vener)
		ll_id_utente=idw_gen.getitemnumber(1, "documento_id_utenti")
		if ll_id_utente=41 then //il 41 è PAOLO
			is_ricpar.s_titolo_finestra='PAOLO'
		end if
		//fine 15-03-2014
		if (ii_ricerca_art_fornitore = 1) then
			is_search_window = "w_des_articolo_coddes_documento_sw" 
			is_ricpar.s_filter_name = "des_articolo_codice"
		else
			is_search_window = "w_articolo_coddes_documento_sw" 
			is_ricpar.s_filter_name = "articolo_codice" 
		end if
		
		is_ricpar.b_asneeded=TRUE
END CHOOSE


end event

event ue_use_search;long ll_id_articolo, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value, ll_id_tab_iva
decimal ldc_ret_value
date ld_comp
string ls_simbolo
dwItemStatus	ldw_status
string ls_utilizzabile
decimal{4} ld_peso_lordo, ld_peso_netto
long row, ll_id, ll_id_uc
integer li_riga_fine, li_riga_inizio, i, li_ret
string ls_um
long ll_soggetto


ll_row= GetRow()

long	ll_id_art_o
ll_id_art_o = this.getitemnumber(ll_row, "riga_documento_id_articolo")
if isnull(ll_id_art_o) then ll_id_art_o = 0

this.Object.DataWindow.Selected.Mouse = "Yes"

CHOOSE CASE as_nomecol
	CASE "c_articolo_cod"
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

event ue_initial;call super::ue_initial;date 				ld_data_prev_consegna

long				ll_id_magazzino, ll_row, ll_numero, ll_id_valuta, ll_righe, ll_count, ll_nriga, ll_id_variazione
long				ll_id_listino, ll_id_caus_magazzino, ll_id_locazione, ll_id_agente, ll_test, ll_locazione2


ll_row=rowcount()

ld_data_prev_consegna = idw_gen.GetItemDate(il_row,"data_prev_consegna")
SetItem(ll_row, "riga_documento_data_prevista_consegna", ld_data_prev_consegna)

ll_nriga = GetItemNumber(1, "c_max_num")
if isnull(ll_nriga) then ll_nriga = 0
SetItem(ll_row, "riga_documento_num_riga", ll_nriga+1)


ll_id_valuta=idw_gen.GetItemNumber(il_row, "documento_id_valuta_des")


SetItem(ll_row,"riga_documento_id_valuta",  ll_id_valuta)

SetItem(ll_row,"riga_documento_cambio",  idc_cambio)


ll_id_caus_magazzino = idw_gen.GetItemNumber(il_row, "documento_id_caus_magazzino")
SetItem(ll_row, "riga_documento_id_caus_magazzino",ll_id_caus_magazzino)

ll_id_locazione=idw_gen.GetItemNumber(il_row, "documento_id_locazione_1")

SetItem(ll_row, "id_locazione_1",ll_id_locazione)

ll_locazione2=idw_gen.GetItemNumber(il_row, "documento_id_locazione_2")
SetItem(ll_row, "id_locazione_2",ll_locazione2)

ll_id_variazione=idw_gen.GetItemNumber(il_row, "documento_id_variazione")
SetItem(ll_row, "riga_documento_id_listino",ll_id_variazione)

ll_id_agente = idw_gen.GetItemNumber(il_row, "id_gruppo_agenti")
SetItem(ll_row, "id_gruppo_agenti",ll_id_agente)
//mm per silver dreams uso per galvanica
//ll_id_agente = idw_gen.GetItemNumber(il_row, "id_gruppo_agenti_2")
//SetItem(ll_row, "riga_documento_id_gruppo_agenti_2",ll_id_agente)
uf_set_mask_riga()


long ll_id_r_lotto, ll_riga, ll_id_doc
string ls_flag_comm
if isValid(ids_lotti) or isValid(ids_scar_lotto) then
	select prog_materie_prime
	into :ll_id_r_lotto
	from prog_lotti;
	if ll_id_r_lotto<1 then 
		messagebox("Errore", "Riferimento per gestione lotti non creato!")
		deleterow(ll_row)
		return
	else
		ll_id_r_lotto++
		update prog_lotti
		set prog_materie_prime = :ll_id_r_lotto;
		if sqlca.sqlnrows>0 then
			ll_riga=tab_1.tabpage_2.dw_riga_documento_ordine_gd.RowCount()
			tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_riga,"id_riga_lotto",ll_id_r_lotto)
			commit;	
		else
			messagebox("Errore", "Riferimento per gestione lotti non creato!")
			deleterow(ll_row)
			return
		end if
	end if
end if
if isValid(ids_lotti) then	
	ll_riga=ids_lotti.InsertRow(0)
	ids_lotti.SetItem(ll_riga,"numero",ll_id_r_lotto)
	ids_lotti.SetItem(ll_riga,"attivo",'S')
	select commerciale
	into :ls_flag_comm
	from par_sistema;
	if sqlca.sqlcode=0 then
		if ls_flag_comm="S" then
			ids_lotti.SetItem(ll_riga,"tipo_lotto",'Z')
		else
			ids_lotti.SetItem(ll_riga,"tipo_lotto",'M')
		end if
	else
		messagebox("Errore", "parametro 'commerciale' non trovato in par_sistema")
	end if
end if

wf_tipo_prezzi()

end event

event itemfocuschanged;call super::itemfocuschanged;is_last_field=dwo.name


end event

event ue_itemerror;call super::ue_itemerror;long ll_ret_value

SetNull(ll_ret_value)
CHOOSE CASE adwo_dwo.name
	CASE "sconto"
		MessageBox(is_title, "Ricontrollare lo sconto immesso.")
		ll_ret_value=2
END CHOOSE
return ll_ret_value
end event

event ue_modify;

s_any_array			lstr_array
string				ls_array[], ls_sconto, ls_verifica
long					ll_nr_column= 48, ll_count, ll_row, ll_id_u_conf
decimal				ldc_fattore, ldc_molteplicita, ldc_totale, ldc_ret_value, ldc_quantita
decimal{4}			ld_peso_lordo, ld_peso_netto
string				ls_nome, ls_ric_riga

long					ll_id_art_o, ll_id_loc_o


ll_row = GetRow()
If AcceptText() = 1 then
	
	ls_array[1]= uf_Get_Colval("riga_documento_id_unita_confezione")
	ls_array[2]= uf_Get_Colval("quantita")
	
	ls_verifica=ls_array[2]
	
	ls_array[3]= uf_Get_Colval("riga_documento_data_prevista_consegna")
	ls_array[4]= uf_Get_Colval("prezzo")
	ls_array[5]= uf_Get_Colval("sconto")
	ls_array[6]= uf_Get_Colval("riga_documento_prezzo_netto")
	ls_array[7]= uf_Get_Colval("riga_documento_sconto_riga")
	ls_array[8]= uf_Get_Colval("riga_documento_id_tab_iva")
	ls_array[9]= uf_Get_Colval("riga_documento_forza_chius_evasione")
	ls_array[10]= uf_Get_Colval("riga_documento_sospesa")
	ls_array[11]= uf_Get_Colval("id_riga_doc_provenienza")
	ls_array[12]= uf_Get_Colval("riga_documento_id_articolo")
	ll_id_art_o = long(ls_array[12])	
	ls_array[13]= uf_Get_Colval("qta_evasa")
	ls_array[14]= uf_Get_Colval("id_gruppo_agenti")
	ls_array[15]= uf_Get_Colval("provv_agente")
	ls_array[16]= uf_Get_Colval("qta_sconto_merce")
	ls_array[17]= uf_Get_Colval("id_locazione_1")
	ll_id_loc_o = long(ls_array[17])	
	ls_array[18]= uf_Get_Colval("id_locazione_2")
	ls_array[19]= uf_Get_Colval("riga_documento_id_caus_magazzino")
	ls_ric_riga=is_ric_riga
	If  uf_Get_Colval("c_evasione") <> "NE" then 
		ls_ric_riga=Replace(ls_ric_riga,1,1,"L")
		ls_ric_riga=Replace(ls_ric_riga,13,1,"L")
		ls_ric_riga=Replace(ls_ric_riga,14,1,"L")
	end if
	
	if is_ges_locazioni = "S" then 
		ls_ric_riga=Replace(ls_ric_riga,6,1,"M")
		ls_ric_riga=Replace(ls_ric_riga,7,1,"M")
	else
		ls_ric_riga=Replace(ls_ric_riga,6,1,"L")
		ls_ric_riga=Replace(ls_ric_riga,7,1,"L")
	end if
	
	ls_array[20]= ls_ric_riga
	ls_array[21]= uf_Get_Colval("riga_documento_id_articolo")
	ls_array[22]= uf_Get_Colval("riga_documento_id_valuta")
	ls_array[23]= uf_Get_Colval("riga_documento_cambio")
	ls_array[24]= uf_Get_Colval("id_riga_documento")
	ls_array[25]= uf_Get_Colval("provv_subage")
	ls_array[26]= uf_Get_Colval("provv_carea")
	ls_array[27]= uf_Get_Colval("riga_documento_id_conto")
	
	
	long ll_riga_corrente
	ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
	ls_array[28]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
	(ll_riga_corrente,"documento_id_magazzino"))
	ls_array[29]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
	(ll_riga_corrente,"documento_id_magazzino_2"))
	
	
	ls_array[30]= uf_Get_Colval("riga_documento_num_colli")
	ls_array[31]= uf_Get_Colval("riga_documento_peso_netto")
	ls_array[32]= uf_Get_Colval("riga_documento_peso_lordo")
	
	ls_array[33]= uf_Get_Colval("usimbolo")
	ls_array[34]= uf_Get_Colval("udescrizione")
	ls_array[35]= uf_Get_Colval("riga_documento_dim_l")
	ls_array[36]= uf_Get_Colval("riga_documento_dim_h")
	ls_array[37]= uf_Get_Colval("riga_documento_dim_p")
	
	ls_array[38]= uf_Get_Colval("unita_misura_b_simbolo")
	ls_array[39]= uf_Get_Colval("unita_misura_b_descrizione")
	ls_array[40]=string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_sog_commerciale"))
	
	ls_array[41]= uf_Get_Colval("provv_imp_agente")
	ls_array[42]= uf_Get_Colval("provv_imp_subage")
	ls_array[43]= uf_Get_Colval("provv_imp_carea")
	
	
	ls_array[44]= uf_Get_Colval("riga_documento_id_gruppo_agenti_2")
	ls_array[45]= uf_Get_Colval("riga_documento_provv_agente_2")
	ls_array[46]= uf_Get_Colval("riga_documento_provv_subage_2")
	ls_array[47]= uf_Get_Colval("riga_documento_provv_carea_2")
	ls_array[48]= uf_Get_Colval("riga_documento_provv_imp_agente_2")
	ls_array[49]= uf_Get_Colval("riga_documento_provv_imp_subage_2")
	ls_array[50]= uf_Get_Colval("riga_documento_provv_imp_carea_2")
	
	
	ls_array[51]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente,"id_documento"))
	
	
	ls_array[52]= uf_get_colval("riga_documento_id_con_lis_articolo")
	//250713 aggiungo da-stampare per prezzi confermati e invio mail stato di stampa
	ls_array[53]=uf_get_colval("riga_documento_da_stampare")
	//250713 fine
	lstr_array.s_array = ls_array

	
	OpenWithParm(iw_support, lstr_array,"w_riga_documento_wz")
	lstr_array= Message.PowerObjectParm
	
	ls_array= lstr_array.s_array
	uf_Set_Colval("riga_documento_id_unita_confezione",ls_array[1])
	long ll_id_unita_confezione
	ll_id_unita_confezione=long(ls_array[1])
	if (ll_id_unita_confezione)>0 and not isnull(ll_id_unita_confezione) then
		string ls_tipo,ls_simbolo
		SELECT "unita_misura"."tipo","unita_misura"."simbolo"  
		INTO :ls_tipo,:ls_simbolo 
		FROM "unita_confezione",   
		  	  "unita_misura"  
		WHERE ( "unita_confezione"."id_unita_misura" = "unita_misura"."id_unita_misura" ) and  
            ( ( "unita_confezione"."id_unita_confezione" = :ll_id_unita_confezione ) )   ;
		
		uf_Set_Colval("tipo_um",ls_tipo)
		uf_Set_Colval("simbolo_mov",ls_simbolo)		
		
	end if
	uf_Set_Colval("quantita",ls_array[2])
	
	if ls_verifica<>ls_array[2] then
		ll_id_u_conf=long(uf_get_colval("riga_documento_id_unita_confezione"))
		ll_id_u_conf=wf_controlla_qta_mov(ll_id_u_conf, ls_array[2])
		if ll_id_u_conf=0 then 
			post event ue_post_itemchanged(getrow(), "quantita", "Non si può movimentare questa quantità!")
		else
			post event ue_rec_prezzo(getrow(), dec(ls_array[2]))
		end if
	end if
	
	if not (IsNull(ls_array[3]) OR  ls_array[3]="") then uf_Set_Colval("riga_documento_data_prevista_consegna",ls_array[3])
	uf_Set_Colval("prezzo",ls_array[4])
	uf_Set_Colval("sconto",ls_array[5])
	
	uf_Set_Colval("riga_documento_sconto_riga",ls_array[7])
	uf_Set_Colval("riga_documento_id_tab_iva",ls_array[8])
	uf_Set_Colval("riga_documento_forza_chius_evasione",ls_array[9])
	uf_Set_Colval("riga_documento_sospesa",ls_array[10])
	uf_Set_Colval("id_riga_doc_provenienza",ls_array[11])
	uf_Set_Colval("qta_evasa",ls_array[13])
	uf_Set_Colval("id_gruppo_agenti",ls_array[14])
	uf_Set_Colval("provv_agente",ls_array[15])
	uf_Set_Colval("qta_sconto_merce", ls_array[16])
	uf_Set_Colval("id_locazione_1",ls_array[17])
	uf_Set_Colval("id_locazione_2",ls_array[18])
	uf_Set_Colval("riga_documento_id_caus_magazzino",ls_array[19])
	uf_Set_Colval("riga_documento_id_valuta", ls_array[22])
	uf_Set_Colval("riga_documento_cambio", ls_array[23])
	uf_Set_Colval("provv_subage",ls_array[25])
	uf_Set_Colval("provv_carea",ls_array[26])
	uf_Set_Colval("riga_documento_id_conto",ls_array[27])
	
	ll_riga_corrente=getrow()
	setitem(ll_riga_corrente,"riga_documento_num_colli",dec(ls_array[30]))
	setitem(ll_riga_corrente,"riga_documento_peso_netto",dec(ls_array[31]))
	setitem(ll_riga_corrente,"riga_documento_peso_lordo",dec(ls_array[32]))

	
	setitem(ll_riga_corrente,"riga_documento_dim_l",dec(ls_array[35]))
	setitem(ll_riga_corrente,"riga_documento_dim_h",dec(ls_array[36]))
	setitem(ll_riga_corrente,"riga_documento_dim_p",dec(ls_array[37]))	
	
	
	
	uf_Set_Colval("provv_imp_agente",ls_array[41])
	uf_Set_Colval("provv_imp_subage",ls_array[42])
	uf_Set_Colval("provv_imp_carea",ls_array[43])
	
	
	
	
	
	if (long(ls_array[44]) > 0) then
		
		uf_Set_Colval("riga_documento_id_gruppo_agenti_2",ls_array[44])
		uf_Set_Colval("riga_documento_provv_agente_2",ls_array[45])
		uf_Set_Colval("riga_documento_provv_subage_2",ls_array[46])
		uf_Set_Colval("riga_documento_provv_carea_2",ls_array[47])
		uf_Set_Colval("riga_documento_provv_imp_agente_2",ls_array[48])
		uf_Set_Colval("riga_documento_provv_imp_subage_2",ls_array[49])
		uf_Set_Colval("riga_documento_provv_imp_carea_2",ls_array[50])	
		
	end if
	//250713 aggiungo da-stampare per prezzi confermati e invio mail stato di stampa
	uf_Set_Colval("riga_documento_da_stampare",ls_array[53])
	//fine 250713 
	TriggerEvent("ue_set_ucon_riga")
	uf_set_mask_riga()
	

	
	if (ll_id_art_o <> long(ls_array[12]) or &
		 ll_id_loc_o <> long(ls_array[17])) then	wf_cal_costi()
	
	
end if

end event

event rowfocuschanged;if AcceptText() > 0 then
	uf_set_mask_riga()
end if 
	
end event

event ue_retrieve;call super::ue_retrieve;
long ll_altezza
ll_altezza= idw_riga.height
long ll_delta_y

//iF POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO')<=0 THEN
//
//	ll_delta_y = 165
//	idw_riga.Modify("c_tot_righe_lire.y = " + String(	 ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe_lire_t.y = " + String( ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe.y = " + String(			 ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe_t.y = " + String(		 ll_altezza 	- ll_delta_y ))
//	
//	
//	idw_riga.Modify("datawindow.summary.height = " + String (ll_altezza - 516))
//end if
//is_title = "Riga " + is_nome_tipo_documento
SetSort("riga_documento_num_riga A") 
Sort()
end event

event ue_key;DataWindowChild	ldw_dropdown
DataWindowChild	ldw_drop
string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval, ls_cod, ls_des
integer				li_cdw, li_size, li_i, li_ret
w_search_main		lw_sm
w_data_main			lw_win
w_mod_single_data lw_mw
w_p_data				lw_pwin
u_dw_main			lu_dw

long					ll_retv, ll_art, ll_id_sog

integer li_row 
li_row = getrow()					
long ll_id_unita_confezione
if (li_row > 0) then ll_id_unita_confezione = this.getitemnumber(li_row, "riga_documento_id_unita_confezione")

ll_retv = 0


choose case key
	
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
			
			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
		end if
		
	case KeyF5!
		if keyflags = 0 then
			ls_column = getColumnName()
			uf_reply_retrieve_dddw(ls_column)
			
		end if	
	
	
	
	
	case KeyF3!	
//		string ls_parigi, ls_filter2
//		long ll_id_riga_documento
//		integer i
//			
//		select parigi
//		into :ls_parigi
//		from pers_par_sistema;
//			
//		if ls_parigi = 'S' then	
//			
//			open(w_attesa)
//			ls_filter2 = "quantita > 0"
//			setfilter(ls_filter2)
//			filter()
//			update()
//			setfilter("")
//			filter()
//			
//			declare c_canc cursor for
//						
//			select id_riga_documento 
//			from riga_documento
//			where id_documento = :il_id_documento
//			and quantita = 0;
//			
//			open c_canc;
//			fetch c_canc into :ll_id_riga_documento;
//
//			DO WHILE sqlca.sqlcode = 0
//				delete from riga_documento 
//				where id_riga_documento = :ll_id_riga_documento;
//				
//				fetch c_canc into :ll_id_riga_documento;
//			LOOP
//
//	      close c_canc;		
//						
//			commit;
//			
//			idw_master.is_list.s_modo = modo_modifica
//			idw_master.is_list.s_identifica[1] = "id_documento"
//			idw_master.is_list.l_identifica[1] = il_id_documento
//			SetPointer(HourGlass!)
//			
//			this.enabled= FALSE
//			idw_master.Event ue_retrieve(0, 0)
//			uf_set_documento()
//			uf_setup_documento()
//			uf_set_istanze()
//			this.enabled= TRUE
//			uf_default_focus()
//			SetPointer(Arrow!)
//			close(w_attesa)
//		end if
	
		
	case KeyF4!
		ll_retv = 1
		ib_during_f4 = true
		is_ricpar = is_e_ricpar
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		is_ricpar.b_imm_retrieve = false
		is_ricpar.s_caller_column = ls_column
		is_ricpar.s_sql_cond = ""
		is_search_window = ""
		ls_colval = ""
		trigger event ue_set_search (ls_column,ls_colval)
		if (is_search_window) <> "" then
			choose case keyflags
				case 0	
					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = false
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) <> "dddw" then
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						
						
						
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
					
				case 1	

					
					ls_colval = gettext()
					
					
					is_ricpar.b_imm_insert = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column, ls_colval)
					if lower (ls_style) = "dddw" then
						
						OpenWithParm (lw_mw,is_ricpar,is_search_window)
						this.GetChild (ls_column, ldw_dropdown)
						ldw_dropdown.SetTransObject(SQLCA)
						ldw_dropdown.Retrieve ()
						li_size = upperbound(is_ricpar.s_ausil_value)
						for li_i = 1 to li_size
							if is_ricpar.s_ausil_value[li_i] > " " then
								this.GetChild (is_ricpar.s_ausil_value[li_i], ldw_dropdown)
								ldw_dropdown.SetTransObject(SQLCA)
								ldw_dropdown.Retrieve ()
							end if
						next
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						is_ricpar = Message.PowerObjectParm
						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
							trigger event ue_use_search (ls_column)
						end if
					end if
				case 2	
				case 3	
					ls_colval = gettext()
					is_ricpar.b_imm_maint = true
					is_ricpar.s_caller_column = ls_column
					is_ricpar.b_imm_retrieve = false
					is_ricpar.s_sql_cond = ""
					trigger event ue_set_search (ls_column,ls_colval)
					if lower (ls_style) = "dddw" then
						
					else
						
						
						OpenWithParm (lw_sm,is_ricpar,is_search_window)
						if not IsNull(Message.PowerObjectParm) then
							is_ricpar = Message.PowerObjectParm
							trigger event ue_use_search (ls_column)
						end if
					end if
					is_ricpar.b_imm_maint = false
			end choose
		end if
		ib_during_f4 = false
		
		
		
		ii_ricerca_art_fornitore = 0

		
		
	case Keyadd!
		
		
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			ls_tipof = lw_win.is_wintype
			lu_dw = lw_win.idw_master
			choose case ls_tipof
				case "W_P_DATA"
					if this = lu_dw then
						if is_list.s_modo = modo_inserisci then 			
							if (event ue_update (0,0) = 0) then
								triggerevent("ue_insert")
							end if
							lu_dw.setFocus()
						end if
					else
						triggerevent("ue_insert")
					end if
				case else
					triggerevent("ue_insert")
			end choose
		end if
	case KeySubtract!
		if (keyFlags=2) then
			cb_cancella.event trigger clicked()
		end if

	case KeyS!
		if (keyFlags=2) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			if IsNull(lw_win) then return
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
			
	case KeyF12!
		if (keyFlags=0) then
			ll_retv = 1
			lw_win = u_freddie.iw_current
			lu_dw = lw_win.idw_master
			
			if IsNull(lu_dw) then lu_dw = this
			lu_dw.triggerevent("ue_update")
		end if
		
		
		if (keyflags=3) then
			lw_win = u_freddie.iw_current
			lw_win.trigger event key (keyF12!,3)
		end if
	case KeyN!
		if (keyFlags=2) then
			ll_retv = 1
				lw_win = u_freddie.iw_current
				ls_tipof = lw_win.is_wintype
				lu_dw = lw_win.idw_master
				if ls_tipof = "W_P_DATA" then
					if (lu_dw.is_list.s_modo = modo_inserisci) or (lw_win.ib_nonmodale = true) then 	
						if (lu_dw.event ue_update (0,0) = 0) then
							lu_dw.triggerevent("ue_insert")
						end if
						lu_dw.setFocus()
					end if
				end if
      end if

	case KeyF6!
		lw_win = u_freddie.iw_current
		ls_tipof = lw_win.is_wintype
		if ls_tipof = "W_P_DATA" then
			lw_win.ib_F6_in_dw = true
			if (keyflags=0) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw++
					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
			if (keyFlags=1) then		
				ll_retv = 0
				li_ret = -1
				do while li_ret<0
					li_cdw = lw_win.ii_dwcurr
					li_cdw --
					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
					lw_win.ii_dwcurr = li_cdw
					lw_pwin = lw_win
					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
				loop
			end if
		end if
	case keydelete!		
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		if ls_style = "ddlb" then
			uf_set_colval(ls_column,u_freddie.gs_null)
			ll_retv = 1
		end if
end choose



CHOOSE CASE key
		
   
	CASE KeyI!
		CHOOSE CASE keyflags
			CASE 2
				
				
				long li_num_prec, li_num_prec2
				long ll_nr_row, ll_row
				
			
				ll_nr_row = RowCount()
				FOR ll_row=1 to ll_nr_row
				   SetItem(ll_row, "riga_documento_num_riga", ll_row * 1000)
         	NEXT

				li_ret=update()
				if li_ret<>1 then
					messagebox("Errore!" , "Salvataggio righe non riuscito!")
					return 
				end if

  				if (li_row - 1) >= 1 then
					li_num_prec=this.getitemnumber((li_row ), "riga_documento_num_riga") - 1
				else 
					li_num_prec = 999
				end if								
				
				trigger event ue_insert(0,0)
				
				this.setitem(this.rowcount(), "riga_documento_num_riga", li_num_prec)	
				
				li_ret=this.SetSort("riga_documento_num_riga A") 		
				li_ret=this.Sort()												
				
				ll_nr_row= RowCount()
				FOR ll_row= ll_nr_row to 1 step -1
					SetItem(ll_row, "riga_documento_num_riga", ll_row)
				NEXT	
				
				li_ret=update()
				if li_ret<>1 then
					messagebox("Errore!" , "Salvataggio righe non riuscito! #2")
					return 
				end if				
				scrolltorow(li_row)
		END CHOOSE	
	
	
				
	CASE KeyF!
		CHOOSE CASE keyflags
			CASE 2
					ii_ricerca_art_fornitore = 1				
   			   this.accepttext()
				   ll_row=this.getrow()
				   ls_cod=trim(this.getitemstring(ll_row,'c_articolo_cod'))
					ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
					select id_articolo 
					into :ll_Art
					from des_articolo
					where codice = :ls_cod
					and id_sog_commerciale=:ll_id_sog
					and simbolo_um='XX'
					;
					if sqlca.sqlcode=0 then
						string ls_stato
						select  codice, descrizione, stato
						into :ls_cod, :ls_des, :ls_stato 
						from articolo 
						where id_articolo = :ll_art;
						
						this.setitem(ll_row,'c_articolo_cod', ls_cod)
						this.setitem(ll_row,'riga_documento_id_articolo', ll_art)
						this.setitem(ll_row,'riga_documento_descrizione', ls_des)
						
						
						long ll_id_uc, ll_id_um
						select id_unita_confezione, id_unita_misura
						into :ll_id_uc, :ll_id_um
						from unita_confezione
						where id_articolo = :ll_art
						and	unita_base = 'S';		
						
						this.setitem(ll_row,'riga_documento_id_unita_confezione', ll_id_uc)						
						
						
						
						ii_ricerca_art_fornitore = 1	
						post wf_inserisci_pesi_riga(0)
						trigger event ue_set_arti_riga()	
						
						s_lung_peso s_lung
						long ll_id_prof_documento
						string ls_test
						ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
						select prop_lunghezza
						into :ls_test
						from prof_documento
						where id_prof_documento=:ll_id_prof_documento;
						if ls_test='S' then
							s_lung.id_sog_commerciale=ll_id_sog	
							s_lung.cod_articolo=ls_cod
							openwithparm(w_ric_lung_peso_gd, s_lung)
							s_lung=message.powerobjectparm
						end if
						if isvalid(s_lung)  then
							if s_lung.cod_articolo>"" then
								post setitem(ll_row, "riga_documento_dim_l", s_lung.lunghezza)
							end if
						end if
						
						
						
						ii_ricerca_art_fornitore = 0
						
						return 
					else	
						ii_ricerca_art_fornitore = 1	
						trigger event ue_key(KeyF4!, 0)
					end if	
			END CHOOSE		
		
			
	
	CASE KeyG!
//		CHOOSE CASE keyflags
//			CASE 2
//				decimal ld_peso_netto 
//				char lc_tipo_ges_lotti
//				
//				SELECT tipo_ges_lotti
//				INTO	 :lc_tipo_ges_lotti
//				FROM	 pers_par_sistema
//				;
//				
//				
//				string		ls_tipo_mov
//				decimal{4}  ld_quantita
//				
//				SELECT m.tipo
//				INTO	 :ls_tipo_mov
//				FROM	 unita_confezione u, unita_misura m
//				WHERE  u.id_unita_confezione = :ll_id_unita_confezione
//				AND	 m.id_unita_misura = u.id_unita_misura
//				;
//				
//				
//				if (lc_tipo_ges_lotti = 'G' and 	(tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject = 'd_riga_documento_ordine_lotti_gd') ) then
//					
//		
//					DWObject my_dwo
//					
//					if (ls_tipo_mov = 'P') then
//						my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
//						ld_peso_netto = getitemnumber(li_row,"riga_documento_peso_netto")
//						trigger event itemchanged(li_row, my_dwo, string(ld_peso_netto))
//					else
//						
//						my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.quantita
//						ld_quantita = getitemnumber(li_row,"quantita")
//						trigger event itemchanged(li_row, my_dwo, string(ld_quantita))						
//						
//					end if
//				end if
//		END CHOOSE
	
	
	
	CASE KeyW!
//		CHOOSE CASE keyflags
//			CASE 2	
//
//			string ls_cod_barre
//			integer li_len		
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.accepttext()				
//			ls_cod_barre = getitemstring(li_row,"c_articolo_cod")
//			my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.c_articolo_cod
//			trigger event itemchanged(li_row, my_dwo, ls_cod_barre)
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetColumn("quantita")	
//		END CHOOSE
//	
	
	
	CASE KeyP!
//		CHOOSE CASE keyflags
//			CASE 2
//				long ll_id_locazione_1
//				date ldt_data_registrazione
//				ll_id_locazione_1 = this.getitemnumber(li_row, "id_locazione_1")
//				ldt_data_registrazione = tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(1, "data_registrazione")
//				s_list_main my_st
//				my_st.s_modo=modo_modifica
//				my_st.s_identifica[1]="id_unita_confezione"
//				my_st.l_identifica[1]=ll_id_unita_confezione
//				my_st.l_id_varie=ll_id_locazione_1
//				my_st.s_provenienza=string(ldt_data_registrazione)
//				
//				openwithparm(w_mod_prz_cx, my_st)
				
		//END CHOOSE
	
	
	
	
	boolean 	lb_new=FALSE
	boolean 	lb_last=FALSE
	long 		ll_last_row

		CASE KeyTab!
		If keyflags = 0 then
			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
			lb_last = (GetRow() = RowCount())
			if is_last_field = "riga_documento_id_tab_iva" then
					
				
					if lb_last then
					
						idw_riga.PostEvent("ue_wiz_insert")
					else
	
						idw_riga.PostEvent("ue_wiz_getfocus")
					end if
				RETURN -1
			end if
		end if
	
	
END CHOOSE
	
return ll_retv



lb_new=FALSE
CHOOSE CASE key
	CASE KeyTab!
		If keyflags =0 then
			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
			if is_last_field = "riga_documento_id_tab_iva" AND lb_new then
				idw_riga_tot.PostEvent("GetFocus")
				idw_riga_tot.SetColumn("descrizione")
				RETURN 1
			end if
		end if
END CHOOSE	

end event

event ue_validate_row;call super::ue_validate_row;
long 		ll_id_tab_iva, ll_prezzo
integer	li_err_count
decimal	ld_QTA, ld_QTA_SM, ld_QTA_UB, ld_Fatglob, ld_qta_evasa, ld_qta_evasa_un_base

ld_QTA = uf_GetItemDecimal(al_row, "quantita")
if IsNull(ld_QTA) then ld_QTA=0
ld_QTA_SM = uf_GetItemDecimal(al_row, "qta_sconto_merce")
if IsNull(ld_QTA_SM) then ld_QTA_SM=0
ld_Fatglob=uf_GetItemDecimal(al_row,"fat_con_globale")
if IsNull(ld_Fatglob) then ld_Fatglob=0
ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
SetItem(al_row, "qta_un_base", ld_QTA_UB)

ld_qta_evasa = uf_GetItemDecimal(al_row, "qta_evasa")
if isNull(ld_qta_evasa) then ld_qta_evasa = 0
ld_qta_evasa_un_base = ld_qta_evasa * ld_fatGlob
SetItem(al_row, "qta_evasa_un_base", ld_qta_evasa_un_base )


li_err_count=0
ll_id_tab_iva= GetItemNumber(al_row, "riga_documento_id_tab_iva")
ll_prezzo= GetItemNumber(al_row, "prezzo")
if not(IsNull(ll_prezzo) OR ll_prezzo =0) AND (IsNull(ll_id_tab_iva) OR ll_id_tab_iva =0) then
	as_error_text= "Esistono righe non descrittive senza IVA. "
	li_err_count=1
end if
If li_err_count > 0 then iuo_msg_log.uf_new_text(as_error_text, 3)
return li_err_count

end event

event ue_update;
integer li_RetVal

li_RetVal = super::EVENT ue_update(wparam, lparam)


	
	
	

RETURN li_RetVal 

end event

event constructor;call super::constructor;

this.Object.c_riga_valida.width = 0
this.Object.c_evasione.width = 0
If FileExists ("Arr1.cur") then this.Object.DataWindow.Pointer="Arr1.cur"




end event

event dragdrop;call super::dragdrop;
long		ll_drag_num_riga, ll_drop_num_riga

If ib_rinumera_righe then
	If not(IsNull(il_drag_row) OR IsNull(row) OR il_drag_row <=0  OR row<=0 OR il_drag_row=row) then
		this.SetRedraw(FALSE)
		ll_drag_num_riga=GetItemNumber(il_drag_row,"riga_documento_num_riga")
		ll_drop_num_riga=GetItemNumber(row,"riga_documento_num_riga")
		SetItem(il_drag_row,"riga_documento_num_riga", ll_drop_num_riga)
		SetItem(row,"riga_documento_num_riga", ll_drag_num_riga)
		SetSort("riga_documento_num_riga A") 
		Sort()
	end if
end if
this.Drag(end!)
If not (IsNull(row) Or row=0) then ScrollToRow(row)
this.SetRedraw(TRUE)
end event

event losefocus;call super::losefocus;
GraphicObject 	lgo_cur_control
string			ls_class

lgo_cur_control = GetFocus( ) 
If IsValid(lgo_cur_control) then
	ls_class=lgo_cur_control.ClassName()
end if
If ib_rinumera_righe AND not(ls_class="pb_sort") then uf_Rinumera_Righe(0)
end event

event updatestart;boolean lb_calcola_spese = FALSE 
decimal ld_tot_riga_val_az, ld_tot_riga_val_az_o

If ib_rinumera_righe then uf_Rinumera_Righe(0)

//20261012 se il discendente ricalcola il castelletto nel suo updatestart (dopo questo), qui sarebbe un doppione
if not ib_cast_in_updatestart_righe then
ib_genera_castelletto= TRUE
	SetPointer(HourGlass!)
	tab_1.tabpage_4.dw_cast_iva_documento_lt.TriggerEvent("ue_calc_cast_iva")
	tab_1.tabpage_5.dw_contr_documento_lt.TriggerEvent("ue_calc_contropartita")
	uf_report_righe()
	SetPointer(Arrow!)
end if

long  ll_righe, ll_id, ll_riga_doc, ll_id_loc2,i
long  ll_id_doc, ll_id_caus_magazzino 
long  ll_id_doc1 
decimal{2} ld_qta, ld_qta_evasa
boolean lb_ordinato_fo



long ll_id_caus_mag_nmn

SELECT id_caus_mag_nmn
INTO	 :ll_id_caus_mag_nmn
FROM	 par_sistema
;

long ll_causale,ll_loc1,ll_loc2, ll_id_articolo
string ls_loc1,ls_loc2, ls_des

for i=rowcount() to 1 step -1
	
	ll_id_articolo=getitemnumber(i,"riga_documento_id_articolo")
	if isnull(ll_id_articolo) then
			//setitem(i,"riga_documento_id_caus_magazzino", ll_id_articolo) //annullo causale e locazione
			//setitem(i,"id_locazione_1", ll_id_articolo)
			//setitem(i,"id_locazione_2", ll_id_articolo)			
	else
		
		long ll_id_cat_fiscale
		
		SELECT id_cat_fiscale
		INTO	 :ll_id_cat_fiscale
		FROM	 articolo
		WHERE  id_articolo = :ll_id_articolo
		;
		
		if (isnull(ll_id_cat_fiscale) and not isnull(ll_id_caus_mag_nmn)) then 
			setitem(i,"riga_documento_id_caus_magazzino", ll_id_caus_mag_nmn)
			setitem(i,"id_locazione_1", ll_id_cat_fiscale)
			//setitem(i,"id_locazione_2", ll_id_cat_fiscale)
		end if
		
		
		
//		ll_causale=this.getitemnumber(i,"riga_documento_id_caus_magazzino")
//		select mag_par_richiesto,mag_des_richiesto
//			into :ls_loc1, :ls_loc2
//			from caus_magazzino
//			where id_caus_magazzino=:ll_causale;
//			ll_loc1=this.getitemnumber(i,"id_locazione_1")
//			ll_loc2=this.getitemnumber(i,"id_locazione_2")
//		if not isnull(ll_causale ) then
//			if ls_loc1='S' and isnull(ll_loc1) then
//				messagebox("Errore","La locazione di partenza non è presente sulla riga "+string (i)+" !",stopsign!)
//				return 1
//			end if
////			if ls_loc2='S' and isnull(ll_loc2) then
////				messagebox("Errore","La locazione di destinazione non è presente sulla riga "+string (i)+" !",stopsign!)
////				return 1
////			end if
//			if ls_loc1='N' and not isnull(ll_loc1) then
//				messagebox("Informazione","E' stata impostata una locazione di partenza, su una o più righe, che non sarà utilizzata!")
//			end if	
//			if ls_loc2='N' and not isnull(ll_loc2) then
//				messagebox("Informazione","E' stata impostata una locazione di destinazione, su una o più righe, che non sarà utilizzata!")
//			end if
//		else
//			
//			ll_causale=idw_gen.getitemnumber(1, "documento_id_caus_magazzino")
//			ll_loc1=idw_gen.getitemnumber(1,"documento_id_locazione_1")
//			ll_loc2=idw_gen.getitemnumber(1,"documento_id_locazione_2")
//			setitem(i,"riga_documento_id_caus_magazzino", ll_causale)
//			setitem(i,"id_locazione_1", ll_loc1)
//			setitem(i,"id_locazione_2", ll_loc2)	
//		end if
	end if
next



long ll_id_causale
string ls_ges_lotti
integer li_ret

ll_id_causale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_caus_magazzino")
ls_ges_lotti=wf_gestisci_lotti(ll_id_causale, 0)	
if ls_ges_lotti='C' or ls_ges_lotti='S' or ls_ges_lotti='A' or ls_ges_lotti='R' then
	if wf_controlla_lotti(ls_ges_lotti)<0 then
		messagebox('Errore','Impossibile salvare lotti:  righe errate!')
		return 1
	ELSE
		LI_RET=WF_SALVA_LOTTI(ls_ges_lotti)
		IF LI_RET<>1 THEN 
			messagebox('Errore','Impossibile salvare lotti: contattare assistenza!')
			RETURN 1
		END IF
	end if
end if


string ls_des_personale, ls_des_codice, ls_des_estesa
long ll_id_linguaggio, ll_id_sog_comm, ll_id_lingua, ll_id_linguaggio1, ll_id_lingua1
long ll_id_riga_padre
s_des_articolo s_des_art
string ls_simbolo_um
decimal{2} ld_lunghezza

ll_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
if not (tab_1.tabpage_1.dw_documento_ordine_ff.getrow()>0) then return
ll_id_sog_comm=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_sog_commerciale")
ll_id_linguaggio=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_linguaggio")
ll_id_lingua=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_lingua")
if (isnull(ll_id_linguaggio) or ll_id_linguaggio<1) or (isnull(ll_id_lingua) or ll_id_lingua<1) then
		select id_linguaggio, id_lingua
		into :ll_id_linguaggio1, :ll_id_lingua1
		from par_sistema;
		if sqlca.sqlcode<>0 then
			messagebox("Errore!", "Non posso salvare le descrizioni associate al soggetto~r~n"+&
			"commerciale corrente in quanto non specificato il linguaggio nei parametri di sistema")
			return
	end if
end if
if isnull(ll_id_lingua) then ll_id_lingua=ll_id_lingua1
if isnull(ll_id_linguaggio) then ll_id_linguaggio=ll_id_linguaggio1
for i = 1 to ll_righe
	ld_lunghezza=getitemdecimal(i,"riga_documento_dim_l")
	ls_simbolo_um=getitemstring(i, "unita_misura_b_simbolo")
	if isnull(ls_simbolo_um) then ls_simbolo_um='XX'
	ls_des_estesa=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i,"des_articolo_des_estesa")
	ls_des_codice=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i, "des_articolo_codice")
	ls_des_personale=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i, "des_articolo_descrizione")
	ll_id_articolo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "riga_documento_id_articolo")
	//mm 210110 nell'esplosione non deve ricopiare cod cl/fo
	ll_id_riga_padre=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "id_riga_doc_padre")
	
	if (ls_des_personale>'' or ls_des_codice>'' &
	or ls_des_estesa>'') and isnull(ll_id_riga_padre) &
	and (not (Isnull(ll_id_articolo))) then
		
		update des_articolo
		set 	descrizione=:ls_des_personale,
				des_estesa=:ls_des_estesa,
				codice=:ls_des_codice,
				id_lingua=:ll_id_lingua,
				id_linguaggio=:ll_id_linguaggio
		where id_sog_commerciale=:ll_id_sog_comm
		and id_articolo=:ll_id_articolo
		and id_linguaggio=:ll_id_linguaggio
		and id_lingua=:ll_id_lingua
		and (simbolo_um=:ls_simbolo_um and lunghezza=:ld_lunghezza)
		;
		if sqlca.sqlnrows<1 then
			
			insert into des_articolo 
			(id_linguaggio, descrizione, des_estesa, codice, id_sog_commerciale,
			id_articolo, id_lingua, lunghezza, simbolo_um)
			values (:ll_id_linguaggio,:ls_des_personale,:ls_des_estesa,:ls_des_codice, :ll_id_sog_comm, &
			:ll_id_articolo, :ll_id_lingua, 0,'XX');
			if sqlca.sqlcode<>0 then
				rollback;
			else
				commit;
				s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
				ll_id_lingua,ll_id_linguaggio, i)
				SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
			end if
			if ls_simbolo_um<>'XX' then
				insert into des_articolo 
				(id_linguaggio, descrizione, des_estesa, codice, id_sog_commerciale,
				id_articolo, id_lingua, lunghezza, simbolo_um)
				values (:ll_id_linguaggio,:ls_des_personale,:ls_des_estesa,:ls_des_codice, :ll_id_sog_comm, &
				:ll_id_articolo, :ll_id_lingua,  :ld_lunghezza, :ls_simbolo_um);
				if sqlca.sqlcode<>0 then
					rollback;
					messagebox("Errore!", "Descrizione personale "+ls_des_codice+"  non salvata!")
				else 
					commit;
					
					s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
					ll_id_lingua,ll_id_linguaggio, i)
					SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
				end if
			end if
		else 
			commit;
			s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
				ll_id_lingua,ll_id_linguaggio, i)
			SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
		end if
	end if
	
next

if (this.DeletedCount() > 0) then lb_calcola_spese = true	

if (lb_calcola_spese) then wf_calcola_spese('N')	
end event

event updateend;
//inserito 27052015
if rowsinserted> 0 then
	wf_set_utedocumento("IR")
end if
if rowsupdated >0 then
	wf_set_utedocumento("UR")
end if
if rowsdeleted >0 then
	wf_set_utedocumento("DR")
end if
//fine


IF rowsinserted+rowsupdated+rowsdeleted+modifiedcount()+deletedcount()>0 THEN
	wf_new_cal_cmc()

	if IsValid(idw_master.Is_list.ds_righe_ordine) then
		il_salvato=1
	end if
	
	tab_1.tabpage_2.pb_sort.enabled=true

END IF


end event

event clicked;string ls1_nomedwo, ls1_column, ls1_tipodwo, ls_riga_descrittiva, ls_art
long ll_id_art, ll_id_cat_codifica
ls1_nomedwo = dwo.name
ls1_tipodwo = dwo.type
if ((ls1_tipodwo="bitmap") and (right(ls1_nomedwo,3)="_sw")) then
	ls1_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 3)
	if ls1_column="c_articolo_cod" or ls1_column="riga_documento_descrizione" then
		
			ls_riga_descrittiva=getitemstring(getrow(), "riga_documento_descrizione")
			ll_id_art=this.getitemnumber(getrow(),"riga_documento_id_articolo")
			if ls_riga_descrittiva>"" and not (isnull(ls_riga_descrittiva)) and  isnull(ll_id_art) then
				messagebox("Attenzione!", "Impossibile inserire un articolo in una riga descrittiva.~r~n"+&
				"Cancellare la riga e inserirne una nuova")
				return 
			end if	
		
	end if
end if

call super::clicked

if dwo.name="distinta" then
	s_list_main ls_list_distinta
	long ll_id_dis,ll_art
	ll_art=this.getitemnumber(row,"riga_documento_id_articolo")
	select id_distinta
	into :ll_id_dis
	from distinta
	where id_articolo=:ll_art;
	if sqlca.sqlcode=0 then
		ls_list_distinta.s_modo = modo_modifica
		ls_list_distinta.s_SQL_ident[1] = "distinta.id_distinta"
		ls_list_distinta.s_identifica[1]="id_distinta"
		ls_list_distinta.l_identifica[1]=ll_id_dis
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
	else 
		ls_list_distinta.s_identifica[1]="id_articolo"
		ls_list_distinta.l_identifica[1]=ll_art
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
	end if
end if



	
end event

event getfocus;call super::getfocus;


end event

event editchanged;
end event

event doubleclicked;

if string(dwo.name) ="c_articolo_cod" and cbx_cod_barre.checked then
	return
	

else
	call Super::doubleClicked
end if



end event

event itemchanged;decimal 		ldc_prezzo, ldc_parte,ldc_tot_riga, ldc_ret_value, ldc_quantita, ldc_totale, ldc_fattore
decimal 		ldc_molteplicita
string 		ls_sconto, ls_parte, ls_descrizione
long 			ll_row, ll_pos, ll_ret_value, ll_id, ll_tab_iva, ll_id_magazzino, ll_id_locazione
boolean 		lb_non_calcolabile
string 		ls_tot_riga
string		ls_tb, ls_cp, ls_vr, ls_tr, ls_riga_descrittiva, ls_tipo, ls_art
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_message
integer		li_ok
decimal		ldc_null, ld_sc_unit_riga, ld_sc_riga, ld_qta_min, ld_qta_max 
dwItemStatus	ldw_status
long  		ll_id_unita_conf,ll_confezione,ll_id_art,ll_righe_old,ll_righe_new,i, ll_lotto_trovato
decimal 		ld_qta, ld_qta_lotto, ld_qta_iniz, ld_qta_eff, ldt_qta_scar_attuale
string ls_gruppo, ls_gruppo_2, ls_cod_lotto, ls_cod_art_numerico
integer li_ret
decimal d_azzera[]
long l_azzera[], LL_NUMERO
date ldt_scadenza

decimal ld_tara
decimal ld_peso_netto, ld_peso_lordo
string  ls_codice_azienda

long 	ll_id_gruppo_agenti, ll_id_gruppo_agenti_2, ll_id_documento,	   ll_id_unita_confezione 
date	ldt_data_reg
s_con_provvigione ls_con_provvigione			


idt_qta_scar_attuale[]=d_azzera[]
idt_qta_lotti[]=d_azzera[] 
il_id_lotti[]=l_azzera[]


if is_prof_dispo='C' or is_prof_dispo='B' then
	decimal ld_tot_precedente
	if (dwo.name='quantita' and this.getitemstring(row,'tipo_um')<>'P') or (dwo.name='riga_documento_peso_netto' and this.getitemstring(row,'tipo_um')='P') then
   if dwo.name='quantita' then
		ld_tot_precedente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,'quantita') 	
	else
		ld_tot_precedente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,'riga_documento_peso_netto')
	end if	
	if uf_blocca_dispo(ld_tot_precedente,data,row)=2 then 
		post uf_setta_precedente(row,ld_tot_precedente,dwo.name)
		return 2
	end if	
	end if
end if	

dwobject ldwo_pippo

ll_row= GetRow()
If ll_row=0 OR IsNull(ll_row) then ll_row= row
SetNull(ldc_null)
if IsValid(ids_lotti) and this.dataobject<>"d_riga_documento_ordine_ritorno_gd" then
	CHOOSE CASE dwo.name
	CASE "c_articolo_cod"
		
		select id_articolo
		into :ll_id
		from articolo
		where codice=:data;
		if isnull(ll_id) then return 1
		
		wf_carico_lotti(row, ll_id)
	CASE "riga_documento_descrizione"
		
		setnull(ll_id)
		wf_carico_lotti(row,ll_id )
	CASE "cod_lotto"
		ll_row=getitemnumber(row,"id_riga_lotto")
		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
		if i>0 then	
			ids_lotti.SetItem(i,"cod_esterno", data)
		else
			messagebox("Errore","Lotto non trovato")
		end if
	CASE "data_scadenza"
		ll_row=getitemnumber(row,"id_riga_lotto")
		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
		if i>0 then	
			ids_lotti.SetItem(i,"data_scadenza",date(data))
		else
			messagebox("Errore","Lotto non trovato")
		end if
	CASE "quantita"
		ll_row=getitemnumber(row,"id_riga_lotto")
		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
		if i>0 then	
			ids_lotti.SetItem(i,"qta_iniziale",dec(data))
			
			ll_id_unita_conf = this.getitemnumber(row,"riga_documento_id_unita_confezione")
			SELECT peso_netto
			INTO	 :ld_peso_netto
			FROM	 unita_confezione
			WHERE  id_unita_confezione = :ll_id_unita_conf
			;
			
			if (ld_peso_netto > 0) and (not isnull(ld_peso_netto)) then
				ld_peso_netto = ld_peso_netto * dec(data)
				ids_lotti.SetItem(i,"peso_netto_iniziale",ld_peso_netto)				
			end if
			
		else
			messagebox("Errore","Lotto non trovato")
		end if
	CASE "riga_documento_peso_netto"
		
		ll_row=getitemnumber(row,"id_riga_lotto")
		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
		if i>0 then	
			ids_lotti.SetItem(i,"peso_netto_iniziale",dec(data))
		else
			messagebox("Errore","Lotto non trovato")
		end if		
		
		
	END CHOOSE
end if 
long ll_id_articolo, ll_id_cat_fiscale2

ll_id_articolo=getitemnumber(row, "riga_documento_id_articolo")

			 
char lc_tipo_ges_lotti
string ls_tipo_mov

SELECT a.id_cat_fiscale, m.tipo
INTO   :ll_id_cat_fiscale2, :ls_tipo_mov
FROM   articolo a, unita_confezione u, unita_misura m
WHERE  a.id_articolo=:ll_id_articolo
AND	 u.id_articolo = a.id_articolo
AND	 u.unita_base = 'S'
AND	 m.id_unita_misura =* u.id_unita_misura
;

//SELECT tipo_ges_lotti
//INTO	 :lc_tipo_ges_lotti
//FROM	 pers_par_sistema
//;
//
//if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
//	if dwo.name="riga_documento_peso_netto" and isvalid(ids_scar_lotto) and (not(isnull(ll_id_cat_fiscale2))) then
//		wf_scarico_lotti(ll_id_articolo, dec(data), row)
//	end if		
//else
//	
//	if dwo.name="quantita" and isvalid(ids_scar_lotto) and (not(isnull(ll_id_cat_fiscale2))) then
//		wf_scarico_lotti(ll_id_articolo, dec(data), row)
//	end if	
//end if
CHOOSE CASE dwo.name
	CASE "c_articolo_cod", "riga_documento_descrizione"
		if dwo.name= "c_articolo_cod" and data="" then return 2
		IF DWO.NAME="c_articolo_cod" THEN
			If (cbx_cod_barre.Checked) = TRUE then
				String ls_cod_articolo			
				SELECT a.codice, c.id_unita_confezione
				INTO	 :ls_cod_articolo, :ll_id_unita_confezione
				FROM	 cod_barre c, unita_confezione u, articolo a
				WHERE	 c.codice = :Data
				AND	 u.id_unita_confezione = c.id_unita_confezione
				AND	 a.id_articolo = u.id_articolo;
				choose case SQLCA.SQLCODE
					case -1
						messagebox("", SQLCA.SQLERRTEXT)
					case 100
						messagebox("", "Il codice a barre acquisito non è stato codificato ")
						return 2
					case 0
						this.Post setitem(row,"c_articolo_cod", ls_cod_articolo)
						this.Post setitem(row,"riga_documento_id_unita_confezione", ll_id_unita_confezione)
						data = ls_cod_articolo
				end choose
			end if
		END IF
		ls_riga_descrittiva=getitemstring(row, "riga_documento_descrizione")
		ll_id_art=this.getitemnumber(row,"riga_documento_id_articolo")
		if ls_riga_descrittiva>"" and not (isnull(ls_riga_descrittiva)) and  isnull(ll_id_art) then
			messagebox("Attenzione!", "Impossibile inserire un articolo in una riga descrittiva.~r~n"+&
			"Cancellare la riga e inserirne una nuova")
			return 1
		end if		
	if ii_ricerca_art_fornitore=0 then
		for i= 1 to 2
			ls_dbc[1] = "descrizione"
			ls_dbc[2] = "id_articolo"
			ls_dbc[3] = "codice"
			ls_dbc[4] = "descrizione"
			ls_dwc[1] = "riga_documento_descrizione"
			ls_dwc[2] = "riga_documento_id_articolo"
			ls_dwc[3] = "c_articolo_cod"
			ls_dwc[4] = "c_articolo_des"
			select cod_art_numerico into :ls_cod_art_numerico from dba.orafo_par_sistema;
			if long(data)>0 and ls_cod_art_numerico<>'S' then
				ll_id= long(data)
				select codice into :data from dba.articolo where id_articolo=:ll_id;
			end if
			li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",4,ls_dbc,ls_dbv,ls_dwc)
			if li_ok>0 and i=1 then
				ls_art=wf_varianti_set(data, row)
				if ls_art>"" then
					data=ls_art
				else
					exit
				end if
			else
				exit
			end if
		next
	end if	
	ii_ricerca_art_fornitore=0	
	
		ll_id_art=this.getitemnumber(this.getrow(),"riga_documento_id_articolo")
		if ll_id_art>0 then
			li_ret=wf_controlla_utilizzabile(ll_id_art)
			if li_ret=-1 then 
				POST uf_set_colval("c_articolo_cod", "")	
				data=""
				RETURN
			end if

		end if
		select id_unita_confezione
		into :ll_confezione
		from unita_confezione
		where id_articolo=:ll_id_art
		and unita_base='S';
		setitem(ROW,"riga_documento_id_unita_confezione",ll_confezione)
		wf_inf_aggiuntive(ll_confezione,ROW,ll_id_art)	

		if li_ok > 0 then
			
			ldw_status = GetItemStatus( row,0,Primary! )
			if ldw_status = New! or ldw_status = NewModified! then
				post uf_scaglione_provvigione() 
			end if
			post wf_inserisci_pesi_riga(0)
			wf_impongo_magazzino(row,row)
			trigger event ue_set_arti_riga()	
			trigger event ue_set_contropartita()
			
			if is_prof_dispo='C' or is_prof_dispo='B' then	uf_pre_blocca_dispo(row)
			return 2 			
		end if	
	
CASE "quantita"
	ld_qta_max=getitemdecimal(row, "qta_sconto_merce")
	if (ld_qta_max <> 0 and Not(IsNull(ld_qta_max))) and ld_qta_max>=dec(data) then
		ls_message="La quantità inserita è inferiore o uguale~r~nalla quantità sconto merce!.~r~nInserire una quantità maggiore!"
		post event ue_post_itemchanged(row, string(dwo.name), ls_message)
	end if
	WF_SE_CAMBIA_QTA(ROW, data)
	
	ll_confezione=this.getitemnumber(this.getrow(),"riga_documento_id_unita_confezione")	
	if (not isnull(data) and dec(data) > 0) and (not isnull(ll_confezione)) and ll_confezione > 0 then
		decimal {0} ld_num_colli 
		SELECT num_colli
		INTO	 :ld_num_colli
		FROM	 unita_confezione
		WHERE  id_unita_confezione = :ll_confezione
		;
		
		if (SQLCA.SQLCODE = -1) then messagebox("DBError", SQLCA.SQLERRTEXT)
		
		if ld_num_colli > 0 then
			ld_num_colli = ld_num_colli * dec(data)
			setitem(row, "riga_documento_num_colli", ld_num_colli)
		end if
	end if
	
CASE "prezzo", "quantita", "riga_documento_peso_netto" 
		
	if (dwo.name = "riga_documento_peso_netto") then
		SELECT 1
		INTO   :ls_codice_azienda
		FROM   azienda
		WHERE  id_azienda = 1
		AND	 UCASE(codice) = 'GIESSE'
		;
		
		if (SQLCA.SQLCODE = 0) then
			ll_row = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getrow()
			ld_tara = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber(ll_row, "tara")

			ll_row = getrow()
			ld_peso_lordo = dec(data)
			ld_peso_netto = (ld_peso_lordo - ld_tara)
			post setitem(ll_row, "riga_documento_peso_lordo", ld_peso_lordo)	
			post setitem(ll_row, "riga_documento_peso_netto", ld_peso_netto)
		end if
	end if
	
	
	
	ldw_status = GetItemStatus( row,0,Primary! )
	
	
	string ls_tipo_um
	decimal ld_prezzo
	ld_prezzo=getitemdecimal(row, "prezzo")
	
	
	if (dwo.name = "riga_documento_peso_netto") then
	
		ls_tipo_um=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(row,"tipo_um")
		if ls_tipo_um='P' then
			
			
			if pos(upper(u_freddie.istr_database.name), 'ORAFO')>0 then
			else 
				post event ue_rec_prezzo(row,1)
			end if
		end if
	end if

	
	if (dwo.name = "prezzo") then
		if dec(Data) > 0 and isnull(this.getitemnumber(row, "riga_documento_id_articolo")) then
			post event ue_set_contropartita()
		end if
	end if
	

CASE "sconto"
	post event ue_set_calc_riga(row)
	
	
	
	decimal ld_null
	setnull(ld_null)
	this.setitem(row,"riga_documento_sconto_riga",ld_null)
	
END CHOOSE

if (dwo.name = "sconto" or dwo.name = "quantita" &
	 or dwo.name = "riga_documento_peso_netto") then
	post wf_gruppo_agenti(row)
end if


RETURN ll_ret_value
end event

event dberror;
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

event ue_delete;
decimal ld_precedente, ld_datastore
long row, ll_ret, ll_id_art_dispo
row=this.getrow()
if is_prof_dispo='C' or is_prof_dispo='B' then
	if this.getitemstring(row,'tipo_um')<>'P' then
      ld_precedente=this.getitemdecimal(row,'quantita') 	
	else
		ld_precedente=this.getitemdecimal(row,'riga_documento_peso_netto')
	end if	
	
	ll_id_art_dispo=this.getitemnumber(row,'riga_documento_id_articolo')
   ll_ret=ids_disponibilita.find("id_articolo=" +string(ll_id_art_dispo), 1,ids_disponibilita.RowCount())
   if ll_ret>0 then ld_datastore=ids_disponibilita.getitemdecimal(ll_ret,'totale')
	if ld_datastore>ld_precedente then
		ld_datastore=ld_datastore - ld_precedente
		ids_disponibilita.setitem(ll_ret,'totale',ld_datastore)
	else 
		ids_disponibilita.deleterow(ll_ret)
	end if
end if	
		
call super ::ue_delete	
end event

event ue_insert;call super::ue_insert;ii_ricerca_art_fornitore = 0

end event

type pb_note from picturebutton within tabpage_2
integer x = 23
integer y = 916
integer width = 146
integer height = 148
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Note"
end type

event clicked;string ls_nota
long ll_sogg_com
ll_sogg_com=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,'id_sog_commerciale')

string 		ls_array[]
s_any_array lstr_array

ls_array[2] = string(idw_gen.getitemnumber(il_row, "id_documento"))
ls_array[10] = string(ll_sogg_com)

lstr_array.s_array = ls_array
OpenWithParm(w_annotazione_gd, lstr_array)

ls_nota=message.stringparm
if not isnull(ls_nota) and ls_nota>'' then
	dw_riga_documento_dett_ord_ff.setitem(dw_riga_documento_dett_ord_ff.getrow(),&
	'riga_documento_descrizione', ls_nota)
end if
end event

type cb_5bis from commandbutton within tabpage_2
integer x = 1961
integer y = 748
integer width = 265
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Peso Netto"
end type

event clicked;DWObject my_dwo
decimal ld_peso_netto
long	ll_row, ll_id_articolo
string ls_metallo

w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()
if ld_peso_netto>0 then
	ll_id_articolo=idw_riga.getitemnumber(idw_riga.getrow(), "riga_documento_id_articolo")
		select m.codice
		into :ls_metallo
		from articolo a, orafo_titolo t, orafo_metallo m
		where a.id_titolo=t.id_titolo and t.id_metallo=m.id_metallo
		and a.id_articolo=:ll_id_articolo
		;
		if ls_metallo<>"AU" then
			ld_peso_netto=round(ld_peso_netto, 1)
		end if
	
	ll_row = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
				
	my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_peso_netto",ld_peso_netto)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event itemchanged(ll_row, my_dwo, string(ld_peso_netto))
end if
close(w_bil)
//
////
//long	ll_row
//string Buffer, buffer2, ls_bilancia
//integer li_pos, li_pos_2
//DWObject my_dwo
//decimal ld_peso_netto
//string ls_peso, ls_peso2
////' Open the serial port
//
//  OLE_1.object.CommPort = 1  //' Set the port number 
//   ls_bilancia = ProfileString ( "cometa.ini", "PC", "Bilancia", "Error!" )
//	//messagebox("BILANCIA SCELTA", ls_bilancia)
//	if ls_bilancia="mettler" then
//		 OLE_1.object.CommPort = 1  //' Set the port number
//		OLE_1.object.Settings = "9600,E,7,1"
//		OLE_1.object.PortOpen = True           //' Required, might lock port
//		sleep(1)
//		Buffer = OLE_1.object.Input //' Read data
//// 		do until  len(buffer) > 14  
////		Buffer = OLE_1.object.Input //' Read data
////			 
////		loop
// 		//messagebox("W", buffer)
//		 
//  		OLE_1.object.PortOpen = False
//  		li_pos=pos(buffer, "S")
//		ls_peso=mid(buffer, li_pos+2, 10)  
//		//messagebox("W", ls_peso)
//				
////if len(buffer)>30 then
////			li_pos=pos(Buffer, "+", 16)
////		else
////			li_pos=pos(Buffer, "+", 1)
////		end if
////		ls_peso=mid(buffer, li_pos, 11)
////		ls_peso=left(ls_peso, 10)
////		ls_peso=right(ls_peso, 9)
////		ls_peso=trim(ls_peso)
//		li_pos=pos(ls_peso, ".")
//		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
//		ld_peso_netto=dec(ls_peso)
////
//		ll_row = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
////					
//		my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
//		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_peso_netto",ld_peso_netto)
//		tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event itemchanged(ll_row, my_dwo, string(ld_peso_netto))
//
//	elseif ls_bilancia="sartorius" then
//		 OLE_1.object.CommPort = 1  //' Set the port number
//  		OLE_1.object.Settings = "1200,N,7,1"  //' Set UART parameters
//		OLE_1.object.PortOpen = True           //' Required, might lock port
//		sleep(1)
//		 Buffer = OLE_1.object.Input //' Read data
// 		
//  		OLE_1.object.PortOpen = False
//  
//		if len(buffer)>30 then
//			li_pos=pos(Buffer, "+", 16)
//		else
//			li_pos=pos(Buffer, "+", 1)
//		end if
//		ls_peso=mid(buffer, li_pos, 11)
//		ls_peso=left(ls_peso, 10)
//		ls_peso=right(ls_peso, 9)
//		ls_peso=trim(ls_peso)
//		li_pos=pos(ls_peso, ".")
//		ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
//		ld_peso_netto=dec(ls_peso)
//		//040612 richiesta samy arronto ad un decimale
//		ld_peso_netto=round(ld_peso_netto, 1)
//		ll_row = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
//					
//		my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
//		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_peso_netto",ld_peso_netto)
//		tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event itemchanged(ll_row, my_dwo, string(ld_peso_netto))
//	
//	elseif ls_bilancia="strumenta" then
//		 OLE_1.object.CommPort = 1  //' Set the port number
//  		OLE_1.object.Settings = "4800,N,8,1"  //' Set UART parameters
//		OLE_1.object.PortOpen = True           //' Required, might lock port
//		sleep(2)
//		 Buffer = OLE_1.object.Input //' Read data
// 		//messagebox("Strumenta_doc", buffer)
//  		OLE_1.object.PortOpen = False
//		  
//		 LI_POS=POS(buffer, "GS", 1)
//		 //messagebox("inizio", li_pos)
//		if li_pos>0 then
//			li_pos_2=POS(buffer, "g", li_pos)
//			//messagebox("Fine", li_pos_2)
//			ls_peso=mid(buffer, li_pos+1+2, 9)
//			li_pos=pos(ls_peso, ".")
//			ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
//			ls_peso=trim(ls_peso)
//			ld_peso_netto=dec(ls_peso)
//		end if
//  		ll_row = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
//					
//		my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
//		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_peso_netto",ld_peso_netto)
//		tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event itemchanged(ll_row, my_dwo, string(ld_peso_netto))
//	end if
//  
////  //MsComm1.Output = "Text string"    ' Send data
////
////
////
//////boolean lb_controllo
//////string ls_prova, ls_peso, ls_path, ls_str, ls_str2, ls_str3
//////char lc_rit[255]
//////long	ll_row
//////integer li_app
//////ls_peso=''
//////
//////
//////
//////select dir_report into :ls_path from par_sistema;
//////
//////ls_str2= ls_path + "\pesata.txt"
//////ls_str3= ls_path + "\config.txt"
//////
//////ls_str = ls_path + "\peso.exe "+ ls_str3 +" "+ ls_str2
//////FileDelete ( ls_str2 )
//////
//////li_app=Run(ls_str, Minimized!)
//////
//////
//////
//////ls_str=ls_path + "\pesata.txt"
//////
//////
//////time stop
//////long conta=0
//////open(w_attesa)
//////stop=now()
//////stop=relativetime(stop, 20 )
//////li_app=-1
//////DO WHILE  now() < stop and li_app=-1
//////	conta=conta + 1
//////	li_app=fileopen((ls_str),LineMode!,Read!,LockWrite!,Replace!)	
//////LOOP
//////close(w_attesa)
//////if li_app=-1 then 
//////	messagebox('Attenzione', "Il peso non è stato letto correttamente, procedere con l'inserimento manuale!")
//////	return
//////end if	
//////	
//////fileRead(li_app,ls_peso)
//////fileclose(li_app)
//////
//////ls_peso=Replace(ls_peso, 1, 6, "")
//////
//////tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.protect=0")
//////tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.background.color=16777215")
//////tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.color=0")
//////
//////ll_row = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
//////
//////DWObject my_dwo
//////decimal ld_peso_netto
//////ld_peso_netto=dec(string(ls_peso))/1000
//////					
//////my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
//////tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_peso_netto",dec(string(ls_peso))/1000)
//////tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event itemchanged(ll_row, my_dwo, string(ld_peso_netto))
//////
end event

type pb_tree_sort from picturebutton within tabpage_2
integer x = 2359
integer y = 748
integer width = 96
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "s:\pb\commonframework\sort_on.bmp"
alignment htextalign = left!
end type

event clicked;long		ll_id_documento, ll_app
window   mywin 
string   winname
s_num_righe lstr
				
//ll_id_documento = idw_gen.getitemnumber(il_row, "id_documento")
//winname = "w_alb_riga_documento_cx"
//Openwithparm(mywin, ll_id_documento, winname)
//
//select count(*)
//into	 :ll_app
//from	 alb_riga_documento r1, riga_documento r
//where  r.id_documento = :ll_id_documento
//and	 r1.id_riga_documento = r.id_riga_documento
//and	 r1.num_riga = 999999
//;
//if (ll_app > 0) then 
//	dw_riga_documento_ordine_gd.retrieve(ll_id_documento)
//	update alb_riga_documento r1
//	set	 r1.num_riga = r.num_riga
//	from	 riga_documento r
//	where  r.id_documento = :ll_id_documento
//	and	 r1.id_riga_documento = r.id_riga_documento
//	and	 r1.num_riga = 999999
//	;
//	
//	if (sqlca.sqlcode = -1) then 
//		messagebox("rinumera righe", sqlca.sqlerrtext)
//		rollback;
//	else
//		commit;
//	end if
//end if
end event

type dw_riga_documento_dett_ord_ff from u_dw_master_main within tabpage_2
event ue_vis_esi_disponibilita ( )
event ue_calcola_costi ( )
integer x = 9
integer y = 908
integer width = 2807
integer height = 716
integer taborder = 20
string dataobject = "d_riga_documento_dett_ord_ff"
end type

event ue_vis_esi_disponibilita();//
//
//
//long 			ll_row, ll_id_articolo, ll_id_magazzino, ll_id_locazione, ll_id_azienda
//decimal{0}  ld_anno, ld_mese
//decimal{4}  ld_esi_fisica, ld_disp, ld_esi_fiscale
//long 			ll_riga, ll_id_prof_doc
//string 		ls_esi_disp, ls_esistenza
//integer 		li_pos1, li_pos2
//
//if (ib_cal_giac_costi = 'N' or isnull(ib_cal_giac_costi)) then
//	return
//end if
//
//ll_row= GetRow()
//
//ll_riga=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
//if ll_row>0 and ll_riga=1 then
//	ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
//		ll_id_locazione=GetItemNumber(ll_row, "id_locazione_1")
//	
//		select id_magazzino
//		into 	 :ll_id_magazzino
//		from 	 locazione
//		where  id_locazione= :ll_id_locazione;
//		
//		If SQLCA.SQLCODE = 100 Then
//			Return
//		ElseIf SQLCA.SQLCODE = -1 Then
//			MessageBox("", SQLCA.SQLErrText)
//			Return
//		End if
//		
//		ll_id_azienda=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga, "documento_id_azienda")
//		
//		ld_anno=dec(year(today()))
//		ld_mese=dec(month(today()))
//		
//		ll_id_prof_doc=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga, "id_prof_documento")
//		
//	
//		SELECT fn_esi_disp(1, :ll_id_articolo, :ll_id_magazzino, :ld_anno, :ld_mese, :ll_id_prof_doc) AS esistenza, CAST(SUBSTR(esistenza, 1, 20) AS NUMERIC(18,4)), CAST(SUBSTR(esistenza, 21, 20) AS NUMERIC(18,4)), CAST(SUBSTR(esistenza, 41, 20) AS NUMERIC(18,4))
//		INTO	 :ls_esistenza, :ld_esi_fisica, :ld_esi_fiscale, :ld_disp
//		FROM	 SYS.DUMMY
//		;
//		
//		If SQLCA.SQLCODE = 100 Then
//			Return
//		ElseIf SQLCA.SQLCODE = -1 Then
//			MessageBox("", SQLCA.SQLErrText)
//			Return
//		End if	
//		SetItem(ll_Row, "c_esistenza", ld_esi_fiscale)
//		SetItem(ll_Row, "cesistenza_fisica", ld_esi_fisica)
//		SetItem(ll_row, "c_disponibilita", ld_disp)	
//End If
//
end event

event ue_calcola_costi;




end event

event ue_init;call super::ue_init;ib_dw_shared = TRUE
is_list.s_colonne_drop[1] = "riga_documento_id_listino"
end event

event itemfocuschanged;call super::itemfocuschanged;is_last_field=dwo.name
end event

event itemchanged;call super::itemchanged;long			ll_row
decimal		lcd_null
decimal		ld_prezzo_netto, ld_qta, ld_sconto_riga, ld_totale_riga
decimal		ld_cambio, ld_totale_riga_lire, ld_QTA_SM, ld_Qta_Effettiva

ll_row= GetRow()
If IsNull(ll_row) OR ll_row=0 then ll_row=row
SetNull(lcd_null)
CHOOSE CASE dwo.name
	CASE "prezzo_netto"
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_tot_riga(ll_row ,lcd_null, Dec(data), TRUE)
END CHOOSE

return 0





end event

event ue_retrieve;call super::ue_retrieve;is_title="Riga " + is_nome_tipo_documento
end event

event ue_key;call super::ue_key;boolean 	lb_new=FALSE
boolean 	lb_last=FALSE
long 		ll_last_row

CHOOSE CASE key
	CASE KeyTab!
		If keyflags = 0 then
			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
			lb_last = (GetRow() = RowCount())
			if is_last_field = "data_prevista_consegna" then
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
			
			
			string	ls_height, ls_width
			
			ls_height = this.describe("riga_documento_descrizione.height")
			ls_width  = this.describe("riga_documento_descrizione.width")
				
			this.modify("riga_documento_descrizione.height = 132")
			this.modify("riga_documento_descrizione.width  = 786")
			
		end if
END CHOOSE
end event

event clicked;call super::clicked;





decimal 		ldc_esistenza, ldc_disponibilita
long			ll_id_articolo, ll_id_azienda,ll_id_documento, ll_id_par_disponibilita, ll_row
long			ll_id_profilo, ll_null, ll_orafo
s_any_array	lstr_any_array

long			ll_idmag, ll_idsc, ll_idloc, ll_idart
s_list_main	lstr_list

setnull(ll_null)

CHOOSE CASE string(dwo.name) 
	CASE "img_info"
			event ue_vis_esi_disponibilita()
		
	CASE "c_esistenza","c_disponibilita", "cesistenza_fisica"
		ll_row = getRow()
		ll_idart = GetItemNumber (ll_row, "riga_documento_id_articolo")
		ll_idloc = GetItemNumber (ll_row,"id_locazione_1")
		if not isNull(ll_idloc) then
			select "locazione"."id_magazzino"
				into :ll_idmag
				from "dba"."locazione"
				where "locazione"."id_locazione" = :ll_idloc
				using SQLCA;
			if SQLCA.SQLCode=0 then
			else
				ll_idmag=0
			end if
		else
			ll_idmag=0
		end if
		ll_row 			= idw_gen.GetRow()
		ll_idsc 			= idw_gen.GetItemNumber(ll_row, "id_sog_commerciale")
		ll_id_profilo	= idw_gen.GetItemNumber(ll_row, "id_prof_documento")
		
		if (not isNull(ll_idsc)) and (not isNull(ll_idart)) and (ll_idmag>0) and (ll_idsc>0) and (ll_idart>0) then
			lstr_list.l_identifica[1]	= ll_idart
			lstr_list.l_identifica[2]	= ll_idsc
			lstr_list.l_identifica[3]	= ll_idmag
			if not isNull(ll_id_profilo) then
				lstr_list.s_par_name[1]		= "id_prof_documento"
				lstr_list.s_par_value[1]	= string(ll_id_profilo)
			end if	
			lstr_list.s_win_parametri='D'
			select table_id 
			into :ll_orafo
			from systable
			where table_name='orafo_par_sistema';
			if ll_orafo>0 then
				
			else
				OpenWithParm(w_sit_articolo_wz,lstr_list)
			end if
		end if
	CASE "img_info_art"
		ll_row = getRow()
		ll_idart = GetItemNumber (ll_row, "riga_documento_id_articolo")
		ll_idloc = GetItemNumber (ll_row,"id_locazione_1")
		
		ll_row 			= idw_gen.GetRow()		
		ll_id_profilo	= idw_gen.GetItemNumber(ll_row, "id_prof_documento")
		ll_idsc 			= idw_gen.GetItemNumber(ll_row, "id_sog_commerciale")
		
		if (ll_idart > 0) then
			lstr_list.s_modo = modo_modifica
			lstr_list.s_identifica[1]	= "id_articolo"
			lstr_list.l_identifica[1]	= ll_idart
			lstr_list.l_identifica[2]	= ll_idsc
			lstr_list.l_identifica[3]	= ll_idloc
			
			lstr_list.s_par_value[1]	= string(ll_id_profilo)
			
			lstr_list.s_par_value[2]	= string(idw_gen.getitemnumber(ll_row, "id_registro"))
			lstr_list.s_par_value[3]	= string(idw_riga.getitemnumber(row, "riga_documento_id_unita_confezione"))
			lstr_list.s_par_value[4]	= string(idw_gen.getitemnumber(ll_row, "documento_id_valuta_des"))
			lstr_list.s_par_value[5]	= string(idw_gen.getitemnumber(ll_row, "id_destinazione"))
			lstr_list.s_par_value[6]	= string(idw_gen_trasp.getitemnumber(ll_row, "id_tipo_trasporto"))
			lstr_list.s_par_value[7]	= string(idw_riga.getitemnumber(row, "quantita"))
			lstr_list.s_par_value[8]	= idw_gen_trasp.getitemstring(ll_row, "tras_mezzo")
			if not (isnull(idw_gen.getitemdate(ll_row, "data_documento"))) then
				lstr_list.s_par_value[9]	= string(idw_gen.getitemdate(ll_row, "data_documento"))
			else
				lstr_list.s_par_value[9]	= string(idw_gen.getitemdate(ll_row, "data_registrazione"))
			end if
			lstr_list.s_par_value[10]	= string(idw_gen.getItemNumber(1,"documento_id_listino"))
			lstr_list.s_par_value[11]	= string(idw_gen.getItemNumber(1,"documento_id_variazione"))
			
		
			OpenWithParm(w_dati_articolo_cx, lstr_list)		
		end if
END CHOOSE

//CHOOSE CASE dwo.name
//	CASE "riga_documento_descrizione"
//		string	ls_height, ls_width
//	
//		ls_height = this.describe("riga_documento_descrizione.height")
//		ls_width  = this.describe("riga_documento_descrizione.width")
//		
//		if (ls_height = "132" and ls_width = "786") then
//			this.modify("riga_documento_descrizione.height = 608")
//			this.modify("riga_documento_descrizione.width  = 1582")
//		end if
//	
//		this.setcolumn("riga_documento_descrizione")
//	CASE ELSE
//		this.modify("riga_documento_descrizione.height = 132")
//		this.modify("riga_documento_descrizione.width  = 786")
//END CHOOSE
		

end event

event rowfocuschanged;
end event

event ue_itemerror;call super::ue_itemerror;
CHOOSE CASE adwo_dwo.name
	CASE "prezzo_netto"
		If IsNull(as_data) OR as_data="" then
			RETURN 3
		end if
END CHOOSE
RETURN 2
end event

event doubleclicked;call super::doubleclicked;
if string(dwo.name)="cmc" or string(dwo.name)="costo_medio" or string(dwo.name)="costo_ultimo" then 
	long ll_riga_corrente
	decimal ld_prezzo
	ll_riga_corrente=getrow()
	ld_prezzo=getitemdecimal(ll_riga_corrente, string(dwo.name))
	if not isnull(ld_prezzo) and not ld_prezzo=0 then
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_riga_corrente, "prezzo", ld_prezzo)
	end if
end if

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2907
integer height = 1640
long backcolor = 79741120
string text = "Trasporto"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_documento_bolla_trasp_ff dw_documento_bolla_trasp_ff
cb_3 cb_3
end type

on tabpage_3.create
this.dw_documento_bolla_trasp_ff=create dw_documento_bolla_trasp_ff
this.cb_3=create cb_3
this.Control[]={this.dw_documento_bolla_trasp_ff,&
this.cb_3}
end on

on tabpage_3.destroy
destroy(this.dw_documento_bolla_trasp_ff)
destroy(this.cb_3)
end on

type dw_documento_bolla_trasp_ff from u_dw_master_main within tabpage_3
integer y = 16
integer width = 2843
integer height = 1536
string dataobject = "d_documento_bolla_trasp_ff"
end type

event ue_init;call super::ue_init;long ll_row

is_list.s_colonne_drop[1] = "id_unita_misura_peso_cod"
is_list.s_colonne_drop[2] = "id_tipo_trasporto"
is_list.s_colonne_drop[3] = "id_tipo_trasporto_des"
is_list.s_colonne_drop[4] = "id_caus_trasporto"
is_list.s_colonne_drop[5] = "id_caus_trasporto_des"
is_list.s_colonne_drop[6] = "id_unita_misura_volume_cod"
is_list.s_colonne_drop[7] = "id_unita_misura_volume_cod_2"
is_list.s_colonne_drop[8] = "id_unita_misura_peso_cod_2"
is_list.s_colonne_drop[9] = "id_unita_misura_peso_cod_3"
is_list.s_colonne_drop[10] = "asp_beni"

is_list.s_colonne_drop[11] = "targa"



ib_dw_shared = TRUE

end event

event itemchanged;
long 			ll_null, ll_row

string		ls_dbc[], ls_dbv[], ls_dwc[],ls_trasp
integer		li_ok


ll_row = GetRow()

CHOOSE CASE dwo.name
	CASE 'c_vettore_cod'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_vettore_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "documento_id_sog_commerciale_vettore"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_vettore_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE 'c_vettore_des'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_vettore_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "documento_id_sog_commerciale_vettore"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_vettore_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"rag_soc_1","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	
	CASE 'cc_sog_comm_2_cod'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "cc_sog_comm_2_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale_vettore_2"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "cc_sog_comm_2_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE 'cc_sog_comm_2_des'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "cc_sog_comm_2_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale_vettore_2"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "cc_sog_comm_2_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"rag_soc_1","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	case "id_unita_misura_peso_cod","id_unita_misura_volume_cod"
		post wf_cal_pesi_colli(false)
	
   case 'tras_mezzo'
		if data <>'V' then
			setnull(ll_null)
			this.setitem(row,'documento_id_sog_commerciale_vettore',ll_null)
			this.setitem(row,'id_sog_commerciale_vettore_2',ll_null)
			this.setitem(row,'c_vettore_cod',"")
			this.setitem(row,'c_vettore_des',"")
			this.setitem(row,'cc_sog_comm_2_cod',"")
			this.setitem(row,'cc_sog_comm_2_des',"")
			
			
		elseif data = 'V' then 
			
			
			long 		ll_id_sog_com_vettore, ll_id_sog_com_vettore_2, ll_id_sog_commerciale, ll_id_prof_documento 
			string	ls_sog_com_vettore_cod, ls_sog_com_vettore_des
			
			
			ll_id_sog_commerciale = this.object.id_sog_commerciale[row]
			
			SELECT id_sog_com_vettore, id_sog_com_vettore_2
			INTO	 :ll_id_sog_com_vettore, :ll_id_sog_com_vettore_2
			FROM	 sog_commerciale
			WHERE  id_sog_commerciale = :ll_id_sog_commerciale
			;
			
			if (SQLCA.SQLCODE = 0) then
				if (isnull(ll_id_sog_com_vettore) and isnull(ll_id_sog_com_vettore_2)) then
					ll_id_prof_documento = this.object.id_prof_documento[row]
			
					SELECT id_sog_comm_vettore_1_prop, id_sog_comm_vettore_2_prop
					INTO	 :ll_id_sog_com_vettore, :ll_id_sog_com_vettore_2
					FROM	 prof_documento
					WHERE  id_prof_documento = :ll_id_prof_documento
					;
					
				end if
			end if
				
			if (not isnull(ll_id_sog_com_vettore)) then
				SELECT codice, rag_soc_1
				INTO   :ls_sog_com_vettore_cod, :ls_sog_com_vettore_des
				FROM   sog_commerciale_gen
				WHERE  id_sog_commerciale = :ll_id_sog_com_vettore
				;
				
				if (SQLCA.SQLCODE = 0) then
					this.setitem(row, "c_vettore_cod", ls_sog_com_vettore_cod)
					this.setitem(row, "c_vettore_des", ls_sog_com_vettore_des)
					
					this.setitem(row, "documento_id_sog_commerciale_vettore", ll_id_sog_com_vettore)
				end if
			end if
				
			if (not isnull(ll_id_sog_com_vettore_2)) then
				setnull(ls_sog_com_vettore_cod)
				setnull(ls_sog_com_vettore_des)
				
				SELECT codice, rag_soc_1
				INTO   :ls_sog_com_vettore_cod, :ls_sog_com_vettore_des
				FROM   sog_commerciale_gen
				WHERE  id_sog_commerciale = :ll_id_sog_com_vettore_2
				;
				
				if (SQLCA.SQLCODE = 0) then
					this.setitem(row, "cc_sog_comm_2_cod", ls_sog_com_vettore_cod)
					this.setitem(row, "cc_sog_comm_2_des", ls_sog_com_vettore_des)
					
					this.setitem(row, "id_sog_commerciale_vettore_2", ll_id_sog_com_vettore_2)
				end if
			end if
		end if

CASE "targa"
	
	Decimal {4} 	ld_tara
	String			ls_targa, ls_mezzo_trasporto, ls_null, ls_simbolo
			
	ls_targa = Data
	Setnull(ls_null)
	
	if not isnull(Data) then
		SELECT descrizione, tara
		INTO	 :ls_mezzo_trasporto, :ld_tara
		FROM	 mezzo_trasporto
		WHERE	 targa = :ls_targa
		;
		
		CHOOSE CASE SQLCA.SQLCODE 
			CASE -1 
				messagebox("", SQLCA.SQLERRTEXT)
			CASE 0
				This.setitem(ll_Row, "mezzo_trasporto", ls_mezzo_trasporto)
				This.setitem(ll_Row, "tara", ld_tara)
		END CHOOSE
	end if
	
	CASE "id_tipo_trasporto", "id_tipo_trasporto_des"
			if idw_gen.getitemnumber(1, "id_documento") > 0 then  &
				wf_calcola_spese('S')
	
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;
long  ll_row

ll_row = GetRow()

CHOOSE CASE as_nomecol
	
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
		
	CASE "cc_sog_comm_2_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 

		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
		
	CASE "cc_sog_comm_2_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 

		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"
		
	CASE "targa"
		
		
	
		is_search_window = "w_targa_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "targa" 
		
	CASE "asp_beni"
		
		
		
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		
		is_search_window = "w_mod_single_data"
		is_ricpar.i_width = 1900
		is_ricpar.i_height = 1500
		is_ricpar.s_datawindow = "d_asp_beni_gd"
		is_ricpar.s_titolo_finestra = "Aspetto dei beni"		
END CHOOSE
end event

event ue_use_search;
long  ll_row

ll_row= GetRow()
CHOOSE CASE as_nomecol

	CASE "c_vettore_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_vettore_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_cod", is_ricpar.s_ausil_value[1])
	
	CASE "cc_sog_comm_2_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_vettore_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cc_sog_comm_2_des", is_ricpar.s_ausil_value[1])
		
	CASE "cc__sog_comm_2_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale_vettore_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cc_sog_comm_2_cod", is_ricpar.s_ausil_value[1])

	CASE "targa"

		
		
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("targa", is_ricpar.s_id_seg_value[1])
		uf_set_colval("mezzo_trasporto", is_ricpar.s_ausil_value[1])
		uf_set_colval("tara", is_ricpar.s_ausil_value[2])

	CASE "asp_beni"
		
		
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("asp_beni", is_ricpar.s_id_seg_value[1])
		
END CHOOSE

end event

event ue_retrieve;If not ib_reset then
	CALL super::ue_retrieve
	is_title= is_nome_tipo_documento
end if
end event

event ue_insert;call super::ue_insert;is_title= is_nome_tipo_documento
end event

event rowfocuschanged;
end event

type cb_3 from commandbutton within tabpage_3
integer x = 1079
integer y = 48
integer width = 224
integer height = 84
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Proponi"
end type

event clicked;
wf_cal_pesi_colli(false)


end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2907
integer height = 1640
long backcolor = 79741120
string text = "Totali"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cast_iva_documento_lt dw_cast_iva_documento_lt
dw_spesa_documento_gd dw_spesa_documento_gd
st_spese_riepilogo st_spese_riepilogo
cb_aggiorna cb_aggiorna
st_spese_riepilogo_cont st_spese_riepilogo_cont
st_st_scadenze_sconti_cont st_st_scadenze_sconti_cont
cb_ricalcola_scadenze cb_ricalcola_scadenze
dw_documento_ord_tot_ff dw_documento_ord_tot_ff
st_st_scadenze_sconti st_st_scadenze_sconti
cb_valuta cb_valuta
cb_ricalcola_cast cb_ricalcola_cast
dw_documento_tot_ext_ff dw_documento_tot_ext_ff
cbx_gen_bollo cbx_gen_bollo
cb_applica cb_applica
st_1 st_1
st_val_corrente st_val_corrente
st_3 st_3
st_2 st_2
dw_scadenza_documento_lt dw_scadenza_documento_lt
dw_1 dw_1
end type

on tabpage_4.create
this.dw_cast_iva_documento_lt=create dw_cast_iva_documento_lt
this.dw_spesa_documento_gd=create dw_spesa_documento_gd
this.st_spese_riepilogo=create st_spese_riepilogo
this.cb_aggiorna=create cb_aggiorna
this.st_spese_riepilogo_cont=create st_spese_riepilogo_cont
this.st_st_scadenze_sconti_cont=create st_st_scadenze_sconti_cont
this.cb_ricalcola_scadenze=create cb_ricalcola_scadenze
this.dw_documento_ord_tot_ff=create dw_documento_ord_tot_ff
this.st_st_scadenze_sconti=create st_st_scadenze_sconti
this.cb_valuta=create cb_valuta
this.cb_ricalcola_cast=create cb_ricalcola_cast
this.dw_documento_tot_ext_ff=create dw_documento_tot_ext_ff
this.cbx_gen_bollo=create cbx_gen_bollo
this.cb_applica=create cb_applica
this.st_1=create st_1
this.st_val_corrente=create st_val_corrente
this.st_3=create st_3
this.st_2=create st_2
this.dw_scadenza_documento_lt=create dw_scadenza_documento_lt
this.dw_1=create dw_1
this.Control[]={this.dw_cast_iva_documento_lt,&
this.dw_spesa_documento_gd,&
this.st_spese_riepilogo,&
this.cb_aggiorna,&
this.st_spese_riepilogo_cont,&
this.st_st_scadenze_sconti_cont,&
this.cb_ricalcola_scadenze,&
this.dw_documento_ord_tot_ff,&
this.st_st_scadenze_sconti,&
this.cb_valuta,&
this.cb_ricalcola_cast,&
this.dw_documento_tot_ext_ff,&
this.cbx_gen_bollo,&
this.cb_applica,&
this.st_1,&
this.st_val_corrente,&
this.st_3,&
this.st_2,&
this.dw_scadenza_documento_lt,&
this.dw_1}
end on

on tabpage_4.destroy
destroy(this.dw_cast_iva_documento_lt)
destroy(this.dw_spesa_documento_gd)
destroy(this.st_spese_riepilogo)
destroy(this.cb_aggiorna)
destroy(this.st_spese_riepilogo_cont)
destroy(this.st_st_scadenze_sconti_cont)
destroy(this.cb_ricalcola_scadenze)
destroy(this.dw_documento_ord_tot_ff)
destroy(this.st_st_scadenze_sconti)
destroy(this.cb_valuta)
destroy(this.cb_ricalcola_cast)
destroy(this.dw_documento_tot_ext_ff)
destroy(this.cbx_gen_bollo)
destroy(this.cb_applica)
destroy(this.st_1)
destroy(this.st_val_corrente)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_scadenza_documento_lt)
destroy(this.dw_1)
end on

type dw_cast_iva_documento_lt from u_dw_master_main within tabpage_4
event ue_calc_righe_cast ( )
event ue_calc_sp_iva_cast ( )
event ue_calc_sp_noiva_cast ( )
event type boolean ue_calc_cast_iva ( )
event type decimal ue_calc_bollo_cast ( )
event type decimal ue_calc_bolli_sc_cast ( )
event ue_setta_incasso ( )
event ue_calc_sconti_cast ( )
event ue_calc_sp_bollo_cast ( )
event ue_ripul_spese ( )
event type integer ue_setup_cast_iva ( long al_row )
event type integer ue_visibilita_campi ( string as_valuta )
event ue_applica_cast_iva ( )
event ue_applica_acconto ( )
integer y = 420
integer width = 2848
integer height = 356
integer taborder = 30
string dataobject = "d_cast_iva_documento_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_calc_righe_cast();
long 			ll_nr_row, ll_count, ll_id_tab_iva, ll_new_row,ll_row_found, ll_id_tab_iva_max, ll_tot_row
decimal 		ldc_imponibile, ldc_tot_riga,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_omaggi_sc_merce
decimal 		ldc_val_omaggi, ldc_sconto_merce_art_15, ldc_sconto_merce_iva, ldc_tot_omaggi_sc_merce
string 		ls_codice, ls_descr_breve, ls_sconto, ls_riga_valida
decimal 		ldc_sconto_merce, ldc_peso_netto, ldc_prezzo_metallo
long ll_id_articolo, ll_id_uc
//integer LI_NUM_RIGA

if not (IsNull(il_id_documento) OR il_id_documento=0) then
	
	ldc_val_omaggi=0
	ldc_sconto_merce_art_15= 0
	ldc_sconto_merce_iva=0
	
	ll_nr_row= idw_riga.RowCount()
	for ll_count = 1 to ll_nr_row
	
		ls_riga_valida= idw_riga.GetItemString(ll_count, "c_riga_valida")
		if ls_riga_valida = "V" then
//			LI_NUM_RIGA= idw_riga.GetItemNUMBER(ll_count, "riga_documento_num_riga")
//			if LI_NUM_RIGA=388 then
//				messagebox("D", "")
//			end if
			
			ldc_omaggi_sc_merce=0
			ldc_tot_riga = idw_riga.uf_GetItemDecimal(ll_count, "tot_riga_val_doc")   
			
			if IsNull(ldc_tot_riga)  then ldc_tot_riga = 0
			ldc_prezzo_un = idw_riga.uf_GetItemDecimal(ll_count, "prezzo")
			if IsNull(ldc_prezzo_un)  then ldc_prezzo_un = 0
			ldc_sconto_merce= idw_riga.uf_GetItemDecimal(ll_count, "qta_sconto_merce")
			if IsNull(ldc_sconto_merce)  then ldc_sconto_merce = 0
			ls_sconto = idw_riga.GetItemString(ll_count, "sconto")
			if IsNull(ls_sconto)  then ls_sconto = ""
			ldc_quantita = idw_riga.uf_GetItemDecimal(ll_count, "quantita")
			if IsNull(ldc_quantita)  then ldc_quantita = 0
			ll_id_tab_iva = idw_riga.GetItemNumber(ll_count, "riga_documento_id_tab_iva")
			if IsNull(ll_id_tab_iva)  then 
				ldc_aliquota= 0
			else
				
				SELECT "tab_iva"."per_aliquota"  
					INTO :ldc_aliquota  
					FROM "dba"."tab_iva"  
					WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva  ;
			end if
			
			
			ldc_peso_netto=idw_riga.getitemdecimal(ll_count, "riga_documento_peso_netto")
			ll_id_articolo=idw_riga.getitemnumber(ll_count, "riga_documento_id_articolo")

			
			ll_id_uc= idw_riga.GetItemNumber(ll_count, "riga_documento_id_unita_confezione")
			
			if isnull(ldc_peso_netto) then ldc_peso_netto=0
			string ls_tipo
			select tipo
			into :ls_tipo
			from unita_confezione, unita_misura
			
			where (unita_confezione.id_unita_confezione=:ll_id_uc) and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
			
			
			if uf_calcola_prezzo(ls_sconto, 1000000, 1) = 0 then
				if ls_tipo = 'P' then
					ldc_imposta= Ceiling((ldc_prezzo_un * ldc_peso_netto * ldc_aliquota) / 100)
					
					ldc_omaggi_sc_merce= (ldc_peso_netto * ldc_prezzo_un)
				else
					ldc_imposta= Ceiling((ldc_prezzo_un * ldc_quantita * ldc_aliquota) / 100)
					
					ldc_omaggi_sc_merce= (ldc_quantita * ldc_prezzo_un)					
				end if
				ldc_val_omaggi= ldc_val_omaggi + ldc_omaggi_sc_merce												
				
				uf_ins_riga_cast(ll_id_tab_iva, this, 0, ldc_imposta, uf_round(ldc_omaggi_sc_merce)) 
				
			else				
				ldc_prezzo_metallo=idw_riga.GetItemdecimal(ll_count, "prezzo_metallo")
				if (ls_tipo='P' and ldc_peso_netto>0) or (ldc_quantita <> 0) or (ldc_peso_netto>0 and ldc_prezzo_metallo>0)   then
					
					ldc_imponibile= ldc_tot_riga
					ldc_imposta= Ceiling(ldc_aliquota * ldc_tot_riga / 100)
					uf_ins_riga_cast(ll_id_tab_iva, this, ldc_imponibile, ldc_imposta, 0)
					if ldc_sconto_merce <> 0 then
						ldc_omaggi_sc_merce= (ldc_sconto_merce * (ldc_tot_riga / ldc_quantita) )
						ldc_sconto_merce_art_15= ldc_sconto_merce_art_15 + ldc_omaggi_sc_merce
						
						
						uf_ins_riga_cast(il_id_tab_iva_art_15, this, 0, 0, uf_round(ldc_omaggi_sc_merce)) 
					end if
				else
					
					if ldc_sconto_merce <> 0 then
					
						ldc_imposta= Ceiling(ldc_sconto_merce * ldc_prezzo_un * (ldc_aliquota / 100))
						uf_ins_riga_cast(ll_id_tab_iva, this, 0, ldc_imposta, 0)
						if ll_id_tab_iva = il_id_tab_iva_art_15 then
							ldc_omaggi_sc_merce= (ldc_sconto_merce * ldc_prezzo_un ) 
							ldc_sconto_merce_art_15= ldc_sconto_merce_art_15 + ldc_omaggi_sc_merce
							
							
							uf_ins_riga_cast(il_id_tab_iva_art_15, this, 0, 0, uf_round(ldc_omaggi_sc_merce)) 
							
						else
							ldc_omaggi_sc_merce= (ldc_sconto_merce * ldc_prezzo_un ) 
							ldc_sconto_merce_iva= ldc_sconto_merce_iva +  ldc_omaggi_sc_merce
							
							
							uf_ins_riga_cast(ll_id_tab_iva, this, 0, 0, uf_round(ldc_sconto_merce_iva)) 
						end if
					end if
				end if
			end if
		end if
	next
	If IsNull(ldc_val_omaggi) then ldc_val_omaggi=0
	If IsNull(ldc_sconto_merce_art_15) then ldc_sconto_merce_art_15=0
	If IsNull(ldc_sconto_merce_iva) then ldc_sconto_merce_iva=0
	
	
	ll_tot_row= idw_gen_tot.GetRow()
	idw_gen.SetItem(il_row, "c_val_omaggi", ldc_val_omaggi )
	idw_gen_tot_ext.SetItem(ll_tot_row, "tot_omaggi", ldc_val_omaggi )
	idw_gen.SetItem(il_row, "c_val_sc_merce_art_15", ldc_sconto_merce_art_15 )
	idw_gen_tot_ext.SetItem(ll_tot_row, "tot_sc_merce_art_15", ldc_sconto_merce_art_15 )
	idw_gen.SetItem(il_row, "c_val_sc_merce_iva", ldc_sconto_merce_iva )
	idw_gen_tot_ext.SetItem(ll_tot_row, "tot_sc_merce_iva", ldc_sconto_merce_iva )
	ldc_tot_omaggi_sc_merce=ldc_val_omaggi + ldc_sconto_merce_art_15 + ldc_sconto_merce_iva
	idw_gen_tot_ext.SetItem(ll_tot_row, "tot_omaggi_sc_merce", ldc_tot_omaggi_sc_merce)
	idw_gen_tot_ext.SetItem(ll_tot_row, "tot_omaggi_sc_merce_lire",ldc_tot_omaggi_sc_merce * idc_cambio )
	//20211020 si torna all'antico: si usa il cambio e non più la parità: si moltiplica, che dà meno problemi, non si divide....
//	idw_gen_tot_ext.SetItem(ll_tot_row, "tot_omaggi_sc_merce_lire",ldc_tot_omaggi_sc_merce / idc_cambio )
end if

end event

event ue_calc_sp_iva_cast;

long 			ll_nr_row, ll_count, ll_id_tab_iva, ll_new_row,ll_row_found, ll_id_tab_iva_max, ll_id_spesa
long 			ll_cast_count, ll_cast_row_nr, ll_id_tab_iva_max_imp, ll_id_tab_iva_max_ali, ll_nr_rate
long			ll_id_sog_comm
decimal 		ldc_imponibile, ldc_prezzo,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_tot_imponibile, ldc_proporz, ldc_per_detrazione
string 		ls_codice, ls_descr_breve, ls_sconto, ls_mod_calc_iva

ll_nr_row= idw_spesa.RowCount()
for ll_count = 1 to ll_nr_row
	ll_id_tab_iva= idw_spesa.GetItemNumber(ll_count, "id_tab_iva_cod")
	if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then 
		ll_id_spesa= idw_spesa.uf_GetItemDecimal(ll_count, "id_spesa_cod")
		
		SELECT "spesa"."codice"  
			INTO :ls_codice  
			FROM "dba"."spesa"  
			WHERE "spesa"."id_spesa" = :ll_id_spesa   ;
		CHOOSE CASE ls_codice
			CASE "B"		
				
			CASE "C"
				
				

				ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "importo")
				if (IsNull(ldc_importo) OR ldc_importo = 0) then
					
					idw_spesa.post DeleteRow(ll_count)
				else
					idw_spesa.SetItem(ll_count, "importo", ldc_importo)
					
					ll_row_found=Find("id_tab_iva =" + string(ll_id_tab_iva),1,RowCount())
					if ll_row_found= 0 then
						
						ll_new_row= InsertRow(0)
						SELECT "tab_iva"."per_aliquota", "tab_iva"."per_detrazione"
						 INTO :ldc_aliquota, :ldc_per_detrazione
						 FROM "dba"."tab_iva"  
						 WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva   ;
						SetItem(ll_new_row, "id_documento", il_id_documento)
						SetItem(ll_new_row, "id_tab_iva",ll_id_tab_iva)
						SetItem(ll_new_row, "val_spese", ldc_importo)
						SetItem(ll_new_row, "c_aliquota", ldc_aliquota)
						SetItem(ll_new_row, "cc_per_detrazione", ldc_per_detrazione)
						ldc_imposta= Ceiling(ldc_aliquota * ldc_importo / 100)
						SetItem(ll_new_row, "c_imposta", ldc_imposta)
					else
						
						ldc_imponibile= uf_GetItemDecimal(ll_row_found,"val_spese")
						
						if isnull(ldc_imponibile) then ldc_imponibile=0
						
						if not IsNull(ldc_importo) then SetItem(ll_row_found,"val_spese", ldc_imponibile + ldc_importo)
					end if
				end if
			CASE ELSE
				
				ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "importo")
				
				if (IsNull(ldc_importo) OR ldc_importo = 0) then 
						if idw_riga.RowCount() > 0 then
							ldc_tot_righe= idw_riga.uf_GetItemDecimal(1, "c_tot_righe")
							ldc_importo=ldc_tot_righe * idw_spesa.uf_GetItemDecimal(ll_count, "percentuale") / 100
							
							idw_spesa.SetItem(ll_count, "importo", ldc_importo)
						end if	
				end if
				if not (IsNull(ldc_importo) OR ldc_importo = 0) then 
					
					ll_row_found=Find("id_tab_iva =" + string(ll_id_tab_iva),1,RowCount())
					if ll_row_found= 0 then
						ll_new_row= InsertRow(0)
						SELECT "tab_iva"."per_aliquota", "tab_iva"."per_detrazione"
						 INTO :ldc_aliquota, :ldc_per_detrazione
						 FROM "dba"."tab_iva"  
						 WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva   ;
						SetItem(ll_new_row, "id_documento", il_id_documento)
						SetItem(ll_new_row, "id_tab_iva",ll_id_tab_iva)
						SetItem(ll_new_row, "val_spese", ldc_importo)
						SetItem(ll_new_row, "c_aliquota", ldc_aliquota)
						SetItem(ll_new_row, "cc_per_detrazione", ldc_per_detrazione)
						ldc_imposta= Ceiling(ldc_aliquota * ldc_importo / 100)
						SetItem(ll_new_row, "c_imposta", ldc_imposta)
					else
						ldc_imponibile= uf_GetItemDecimal(ll_row_found,"val_spese")
						if IsNull(ldc_imponibile) then ldc_imponibile=0
						if not IsNull(ldc_importo) then SetItem(ll_row_found,"val_spese", ldc_imponibile + ldc_importo)
					end if
				end if
		END CHOOSE
	end if
next

end event

event ue_calc_sp_noiva_cast;call super::ue_calc_sp_noiva_cast;

long 			ll_nr_row, ll_count, ll_id_tab_iva, ll_new_row,ll_row_found, ll_id_tab_iva_max, ll_id_spesa
long 			ll_cast_count, ll_cast_row_nr, ll_id_tab_iva_max_imp, ll_id_tab_iva_max_ali
decimal 		ldc_imponibile, ldc_prezzo,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_tot_imponibile, ldc_proporz
string 		ls_codice, ls_descr_breve, ls_sconto, ls_mod_calc_iva


ll_cast_row_nr= RowCount()
for ll_cast_count = 1 to ll_cast_row_nr
	SetItem(ll_cast_count, "c_prop_imp", GetItemNumber(ll_cast_count, "c_proporzionale"))
next
ll_id_tab_iva_max_imp = uf_get_imp_max()

ll_id_tab_iva_max_ali = uf_get_ali_max()

ll_nr_row= idw_spesa.RowCount()
for ll_count = 1 to ll_nr_row
	ll_id_tab_iva= idw_spesa.GetItemNumber(ll_count, "id_tab_iva_cod")
	if (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then 
		
		ls_mod_calc_iva= idw_spesa.GetItemString(ll_count, "cc_mod_calc_iva")
		CHOOSE CASE ls_mod_calc_iva
			CASE "I"
				ll_id_tab_iva_max = ll_id_tab_iva_max_imp
			CASE "A"
				ll_id_tab_iva_max = ll_id_tab_iva_max_ali
			CASE "P"
				ll_id_tab_iva_max = 0
			CASE ELSE
				ll_id_tab_iva_max = 0
		END CHOOSE 
		ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "importo")
		
		if (IsNull(ldc_importo) OR ldc_importo = 0) then 
			if idw_riga.RowCount() > 0 then
				ldc_tot_righe= idw_riga.uf_GetItemDecimal(1, "c_tot_righe")
				ldc_importo=ldc_tot_righe * idw_spesa.uf_GetItemDecimal(ll_count, "percentuale") / 100
				
				idw_spesa.SetItem(ll_count, "importo", ldc_importo)
			end if	
		end if
		if not (IsNull(ldc_importo) OR ldc_importo = 0) then 
			if ll_id_tab_iva_max>0 then
	
				ll_id_tab_iva= ll_id_tab_iva_max
				idw_spesa.SetItem(ll_count, "id_tab_iva_cod", ll_id_tab_iva)
	
				
					
					
					ll_row_found=Find("id_tab_iva =" + string(ll_id_tab_iva),1,RowCount())
					if ll_row_found <> 0 then
						ldc_imponibile= uf_GetItemDecimal(ll_row_found,"val_spese")
						if IsNull(ldc_imponibile) then ldc_imponibile = 0
						if not IsNull(ldc_importo) then 
							SetItem(ll_row_found,"val_spese", ldc_imponibile + ldc_importo)
						end if
						ldc_aliquota= uf_GetItemDecimal(ll_row_found,"c_aliquota")
					end if
			else
	
				ll_cast_row_nr = RowCount()
				for ll_cast_count = 1 to ll_cast_row_nr
				
					ldc_proporz= uf_GetItemDecimal(ll_cast_count,"c_proporzionale")
					ldc_imponibile= uf_GetItemDecimal(ll_cast_count,"val_spese") + (ldc_importo * ldc_proporz)
					if IsNull(ldc_proporz) then ldc_proporz = 0
					if IsNull(ldc_imponibile) then ldc_imponibile = 0
					if not IsNull(ldc_importo) then SetItem(ll_cast_count,"val_spese", ldc_imponibile)
				next
			end if
		end if
	end if
next



end event

event ue_calc_cast_iva;
long 		ll_nr_row, ll_count, ll_gen_row, ll_bollo_row, ll_row, ll_row_found
decimal 	ldc_bollo 
long		ll_fatturato
boolean	lb_ok

lb_ok=TRUE
//20261106 fattura contabilizzata: il castelletto resta quello salvato, niente ricalcolo (spese e bolli compresi)
if uf_fattura_contabilizzata() then
	iuo_msg_log.uf_new_text("Fattura contabilizzata: castelletto IVA non ricalcolato.",3)
	RETURN (RowCount() > 0)
end if
iuo_msg_log.uf_new_text("Generazione del Castelletto IVA.",3)
 if Not (IsNull(il_id_spesa_bollo) OR il_id_spesa_bollo = 0) then 
	ll_gen_row=il_row
	idw_gen.uf_SetItem(ll_gen_row, "c_val_sc_merce_art_15", 0, TRUE)
	idw_gen.uf_SetItem(ll_gen_row, "c_val_sc_merce_iva", 0, TRUE)
	idw_gen.uf_SetItem(ll_gen_row, "c_val_omaggi", 0, TRUE)
	
	SELECT "par_sistema"."id_tab_iva_art_15"  
		INTO :il_id_tab_iva_art_15  
		FROM "dba"."par_sistema"  
		WHERE "par_sistema"."id_azienda" = 1   ;
If (RowCount() = 0 OR ib_genera_castelletto) then
		
		ll_nr_row = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
		ll_fatturato = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_nr_row,"id_tab_iva_acconto")
		
		ll_nr_row= RowCount()
		for ll_count =  1 to ll_nr_row 
			DeleteRow(ll_nr_row - ll_count + 1)
		next
						
		TriggerEvent("ue_setta_incasso")
		TriggerEvent("ue_calc_righe_cast")
		TriggerEvent("ue_calc_sconti_cast")
		TriggerEvent("ue_calc_sp_noiva_cast")

		TriggerEvent("ue_calc_sp_iva_cast")
		
		

		TriggerEvent("ue_calc_bollo_cast")
		ldc_bollo = Event ue_calc_bolli_sc_cast()
		if IsNull(ldc_bollo) then ldc_bollo=0
		TriggerEvent("ue_calc_sp_bollo_cast")
		
		event ue_applica_acconto()		
	
				
		
		event ue_setup_cast_iva(0)
			
	end if
	TriggerEvent("ue_applica_cast_iva")
	tab_1.tabpage_4.dw_scadenza_documento_lt.Event ue_simula()
	
	
	SetSort("codice_iva A")
	Sort()

	tab_1.tabpage_4.cb_applica.Visible=FALSE
	
else
	MessageBox("Castelletto IVA", "Impossibile generare il Castelletto IVA ~n in quanto non esiste una spesa di tipo Bollo.", Information!)
	iuo_msg_log.uf_new_text("Impossibile generare il Castelletto IVA in quanto non esiste una spesa di tipo Bollo.",3)
	lb_ok=FALSE
end if

if RowCount() = 0 then lb_ok=FALSE

RETURN lb_ok

end event

event ue_calc_bollo_cast;call super::ue_calc_bollo_cast;
long 			ll_nr_row, ll_count, ll_id_tab_iva, ll_bollo_row, ll_row_found
decimal		ldc_imp_min_fattura, ldc_imp_bollo_fattura, ldc_totale, ldc_bollo, ldc_importo

ldc_bollo=0
ll_nr_row= RowCount()
if ll_nr_row > 0 then
	
	ldc_totale=uf_GetItemDecimal(ll_nr_row, "c_tot_imponibile_spesa")
	
	
	for ll_count =  1 to ll_nr_row 
		
		ll_id_tab_iva= uf_GetItemDecimal(ll_count, "id_tab_iva")
		SELECT "tab_iva"."imp_min_fattura",   
			"tab_iva"."imp_bollo_fattura"  
			INTO :ldc_imp_min_fattura,   
			:ldc_imp_bollo_fattura  
			FROM "dba"."tab_iva"  
			WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva   ;
		if Not(Isnull(ldc_imp_min_fattura) OR ldc_imp_min_fattura <=0 OR &
				Isnull(ldc_imp_bollo_fattura) OR ldc_imp_bollo_fattura <=0 ) then
			if ldc_imp_min_fattura <= ldc_totale then
				ldc_bollo= ldc_bollo + ldc_imp_bollo_fattura
			end if
		end if
	next
	If ldc_bollo > 0 then 

		ll_bollo_row=idw_spesa.Find("id_spesa_cod = " + String(il_id_spesa_bollo),1,idw_spesa.RowCount())
		if not (IsNull(ll_bollo_row) OR ll_bollo_row=0) then 
			ldc_importo= idw_spesa.uf_GetItemDecimal(ll_bollo_row, "importo")
			If isNull(ldc_importo) then ldc_importo=0
			idw_spesa.SetItem(ll_bollo_row, "importo", ldc_bollo + ldc_importo)
		else
			ll_bollo_row=idw_spesa.InsertRow(0)
			idw_spesa.SetItem(ll_bollo_row, "id_spesa_cod", il_id_spesa_bollo)
			idw_spesa.SetItem(ll_bollo_row, "id_documento", idw_gen.GetItemNumber(il_row, "id_documento"))
			idw_spesa.SetItem(ll_bollo_row, "id_tab_iva_cod", il_id_tab_iva_art_15)
			idw_spesa.SetItem(ll_bollo_row, "importo", ldc_bollo)
			idw_spesa.SetItem(ll_bollo_row, "mantieni", 'N')  //20261106 bollo automatico: si rifa' a ogni ricalcolo delle spese (il valore iniziale della dw e' 'S')
		end if
	end if
end if
return ldc_bollo

end event

event ue_calc_bolli_sc_cast;call super::ue_calc_bolli_sc_cast;
s_scadenze		lstr_scadenze
boolean			lb_ok
long				ll_id_cp, ll_id_anag, ll_nr_row, ll_bollo_row, ll_row_found
decimal			ld_impon, ld_impos, ld_bollo, ld_importo
date				ld_iniz
decimal			ld_impr[], ld_ivar[]
date				ld_datr[]
integer			li_size, li_i

ld_bollo=0
ll_nr_row= RowCount()
If ll_nr_row > 0 then
	ld_impon = GetItemDecimal(ll_nr_row,"c_tot_imponibile")
	ld_impos = GetItemDecimal(ll_nr_row,"c_tot_imposta")
	ld_iniz = Date("01/01/1999")
	ll_id_cp = idw_gen.GetItemNumber(il_row, "id_con_pagamento")
	ll_id_anag = idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
	ld_bollo= tab_1.tabpage_4.dw_scadenza_documento_lt.Event ue_simula()
	If ld_bollo > 0 then 
		
		ll_bollo_row=idw_spesa.Find("id_spesa_cod = " + String(il_id_spesa_bollo),1,idw_spesa.RowCount())
		if not (IsNull(ll_bollo_row) OR ll_bollo_row=0) then 
			ld_importo= idw_spesa.uf_GetItemDecimal(ll_bollo_row, "importo")
			If IsNull(ld_importo) then ld_importo =0
			idw_spesa.SetItem(ll_bollo_row, "importo", ld_bollo + ld_importo)

		else
			ll_bollo_row=idw_spesa.InsertRow(0)
			idw_spesa.SetItem(ll_bollo_row, "id_spesa_cod", il_id_spesa_bollo)
			idw_spesa.SetItem(ll_bollo_row, "id_documento", idw_gen.GetItemNumber(il_row, "id_documento"))
			idw_spesa.SetItem(ll_bollo_row, "id_tab_iva_cod", il_id_tab_iva_art_15)
			idw_spesa.SetItem(ll_bollo_row, "importo", ld_bollo)
			idw_spesa.SetItem(ll_bollo_row, "mantieni", 'N')  //20261106 bollo automatico: si rifa' a ogni ricalcolo delle spese (il valore iniziale della dw e' 'S')
		end if
	end if
end if
return ld_bollo
end event

event ue_setta_incasso;
end event

event ue_calc_sconti_cast();

long 			ll_nr_row, ll_count, ll_gen_row, ll_cast_count, ll_cast_row_nr
decimal 		ldc_sc_fin_cassa, ldc_sc_incondizionato, ldc_imponibile, ldc_sconto, ldc_imp_complemento
decimal 		ldc_perc_incondizionato
string 		ls_sc_finanziario

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
	SetItem(ll_cast_count, "c_prop_imp", Round(GetItemNumber(ll_cast_count, "c_proporzionale"), 2))
next

If not (IsNull(ls_sc_finanziario) OR ls_sc_finanziario = "") then
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imponibile")
		ldc_imponibile= uf_calcola_prezzo(ls_sc_finanziario, ldc_imponibile, 0)
		
		
		SetItem(ll_cast_count, "val_imp_scontato", uf_Round(ldc_imponibile)) 
	next
else
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imponibile")
		SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
	next
end if
ldc_imp_complemento=0
If not (IsNull(ldc_sc_incondizionato) OR ldc_sc_incondizionato = 0) then
	if ll_cast_row_nr > 0 then
		for ll_cast_count = 1 to ll_cast_row_nr - 1
			ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imp_scontato")
			ldc_perc_incondizionato= uf_Round(ldc_sc_incondizionato * uf_GetItemDecimal(ll_cast_count, "c_proporzionale"))
			ldc_imponibile= ldc_imponibile - ldc_perc_incondizionato
			ldc_imp_complemento= ldc_imp_complemento + ldc_perc_incondizionato
			
			SetItem(ll_cast_count, "val_imp_scontato", uf_round(ldc_imponibile)) 
		next
		ldc_imponibile= uf_GetItemDecimal(ll_cast_row_nr, "val_imp_scontato")
		ldc_imponibile= ldc_imponibile - ldc_sc_incondizionato + ldc_imp_complemento
		
		SetItem(ll_cast_row_nr, "val_imp_scontato", uf_round(ldc_imponibile)) 
	end if
end if
If not (IsNull(ldc_sc_fin_cassa) OR ldc_sc_fin_cassa = 0) then
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imp_scontato")
		ldc_imponibile= ldc_imponibile - (ldc_imponibile * ldc_sc_fin_cassa / 100)
		
		SetItem(ll_cast_count, "val_imp_scontato", uf_round(ldc_imponibile)) 
	next
end if


end event

event ue_calc_sp_bollo_cast();

long 			ll_nr_row, ll_count, ll_id_tab_iva, ll_new_row,ll_row_found, ll_id_spesa, ll_bollo_nullo
long 			ll_cast_count, ll_cast_row_nr, ll_id_tab_iva_max_imp, ll_id_tab_iva_max_ali, ll_nr_rate

decimal 		ldc_imponibile, ldc_prezzo,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo
decimal 		ldc_quantita, ldc_prezzo_un, ldc_per_detrazione
string 		ls_codice, ls_descr_breve, ls_sconto

ll_nr_row= idw_spesa.RowCount()
for ll_count = 1 to ll_nr_row
	ll_id_spesa= idw_spesa.uf_GetItemDecimal(ll_count, "id_spesa_cod")
	
	SELECT "spesa"."codice"  
		INTO :ls_codice  
		FROM "dba"."spesa"  
		WHERE "spesa"."id_spesa" = :ll_id_spesa   ;
	CHOOSE CASE ls_codice
		CASE "B"
			ll_id_tab_iva= idw_spesa.GetItemNumber(ll_count, "id_tab_iva_cod")
			if IsNull(ll_id_tab_iva) then ll_id_tab_iva= il_id_tab_iva_art_15
			
			ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "importo")
			if not (IsNull(ldc_importo) OR ldc_importo=0) then 
					
				
				ll_row_found=Find("id_tab_iva =" + string(ll_id_tab_iva),1,RowCount())
				if ll_row_found= 0 then
					ll_new_row= InsertRow(0)
					SELECT "tab_iva"."per_aliquota", "tab_iva"."per_detrazione"
						 INTO :ldc_aliquota, :ldc_per_detrazione
						 FROM "dba"."tab_iva"  
						 WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva   ;
					SetItem(ll_new_row, "id_documento", il_id_documento)
					SetItem(ll_new_row, "id_tab_iva",ll_id_tab_iva)
					SetItem(ll_new_row, "val_spese", ldc_importo)
					SetItem(ll_new_row, "c_aliquota", ldc_aliquota)
					SetItem(ll_new_row, "cc_per_detrazione", ldc_per_detrazione)
					ldc_imposta= Ceiling(ldc_aliquota * ldc_importo / 100)
					SetItem(ll_new_row, "c_imposta", ldc_imposta)
				else
					ldc_imponibile= uf_GetItemDecimal(ll_row_found,"val_spese")
					if IsNull(ldc_imponibile) then ldc_imponibile=0
					SetItem(ll_row_found,"val_spese", ldc_imponibile + ldc_importo)
					ldc_imposta= uf_GetItemDecimal(ll_row_found,"c_imposta")
					if IsNull(ldc_imposta) then ldc_imposta=0
					ldc_imposta= ldc_imposta + Ceiling(ldc_aliquota * ldc_importo / 100)
					SetItem(ll_row_found, "c_imposta", ldc_imposta)
				end if
			else
				
				ll_bollo_nullo= ll_count
			end if
	END CHOOSE
next
//provo a cancellare per poter segnare la spesa di bollo senza inserire i 2 euro (es: nota credito)
//if ll_bollo_nullo > 0 then idw_spesa.DeleteRow(ll_bollo_nullo)

end event

event ue_ripul_spese;
end event

event ue_setup_cast_iva;
long		ll_nr_row, ll_count
decimal	ldc_tot_imp_val_calc ,ldc_tot_iva_val_calc 
decimal	ldc_tot_imp_lire_calc ,ldc_tot_iva_lire_calc 

ll_nr_row= RowCount()
If not(IsNull(al_row) OR al_row<=0) then
	If al_row <= ll_nr_row then
		ldc_tot_iva_val_calc=uf_GetItemDecimal(al_row,"c_iva_val")
		ldc_tot_imp_val_calc=uf_GetItemDecimal(al_row,"c_imponibile_spesa")
		ldc_tot_iva_lire_calc=uf_GetItemDecimal(al_row,"c_iva_lire")
		ldc_tot_imp_lire_calc=uf_GetItemDecimal(al_row,"c_imponibile_spesa_lire")
		SetItem(al_row,"val_tot_iva_v", ldc_tot_iva_val_calc)
		SetItem(al_row,"val_tot_imp_v", ldc_tot_imp_val_calc)
		SetItem(al_row,"val_tot_iva_l", ldc_tot_iva_lire_calc)
		SetItem(al_row,"val_tot_imp_l", ldc_tot_imp_lire_calc)
	end if
else
	FOR ll_count=1 to ll_nr_row
		ldc_tot_iva_val_calc=uf_GetItemDecimal(ll_count,"c_iva_val")
		ldc_tot_imp_val_calc=uf_GetItemDecimal(ll_count,"c_imponibile_spesa")
		ldc_tot_iva_lire_calc=uf_GetItemDecimal(ll_count,"c_iva_lire")
		ldc_tot_imp_lire_calc=uf_GetItemDecimal(ll_count,"c_imponibile_spesa_lire")
		SetItem(ll_count,"val_tot_iva_v", ldc_tot_iva_val_calc)
		SetItem(ll_count,"val_tot_imp_v", ldc_tot_imp_val_calc)
		SetItem(ll_count,"val_tot_iva_l", ldc_tot_iva_lire_calc)
		SetItem(ll_count,"val_tot_imp_l", ldc_tot_imp_lire_calc)
	NEXT
end if

RETURN 0
end event

event type integer ue_visibilita_campi(string as_valuta);
If as_valuta = "L" then
	If is_tipo_registro= "IA" then
		idw_castelletto.Object.val_tot_iva_l.width = 500
		idw_castelletto.Object.val_tot_iva_v.width = 0
		idw_castelletto.Object.val_tot_imp_v.width = 0
		idw_castelletto.Object.val_tot_imp_l.width = 500
		idw_castelletto.Object.c_iva_lire.width = 0
		idw_castelletto.Object.c_iva_val.width = 0
		idw_castelletto.Object.c_imponibile_spesa.width = 0
		idw_castelletto.Object.c_imponibile_spesa_lire.width = 0
		idw_castelletto.Object.cc_acconto.width = 0
		idw_castelletto.Object.c_acconto_lire.width = 500
	else
		idw_castelletto.Object.c_iva_lire.width = 500
		idw_castelletto.Object.c_iva_val.width = 0
		idw_castelletto.Object.c_imponibile_spesa.width = 0
		idw_castelletto.Object.c_imponibile_spesa_lire.width = 500
		idw_castelletto.Object.val_tot_iva_l.width = 0
		idw_castelletto.Object.val_tot_iva_v.width = 0
		idw_castelletto.Object.val_tot_imp_v.width = 0
		idw_castelletto.Object.val_tot_imp_l.width = 0
		idw_castelletto.Object.cc_acconto.width = 0
		idw_castelletto.Object.c_acconto_lire.width = 500
	end if
else
	If is_tipo_registro= "IA" then
		idw_castelletto.Object.val_tot_iva_l.width = 0
		idw_castelletto.Object.val_tot_iva_v.width = 500
		idw_castelletto.Object.val_tot_imp_v.width = 500
		idw_castelletto.Object.val_tot_imp_l.width = 0
		idw_castelletto.Object.c_iva_lire.width = 0
		idw_castelletto.Object.c_iva_val.width = 0
		idw_castelletto.Object.c_imponibile_spesa.width = 0
		idw_castelletto.Object.c_imponibile_spesa_lire.width = 0
		idw_castelletto.Object.cc_acconto.width = 500
		idw_castelletto.Object.c_acconto_lire.width = 0
	else
		idw_castelletto.Object.c_iva_lire.width = 0
		idw_castelletto.Object.c_iva_val.width = 500
		idw_castelletto.Object.c_imponibile_spesa.width = 500
		idw_castelletto.Object.c_imponibile_spesa_lire.width = 0
		idw_castelletto.Object.val_tot_iva_l.width = 0
		idw_castelletto.Object.val_tot_iva_v.width = 0
		idw_castelletto.Object.val_tot_imp_v.width = 0
		idw_castelletto.Object.val_tot_imp_l.width =500 //0
		idw_castelletto.Object.cc_acconto.width = 500
		idw_castelletto.Object.c_acconto_lire.width = 0
	end if
end if
RETURN 0
end event

event ue_applica_cast_iva();
long 		ll_row
decimal  ldc_valore	
boolean	lb_ok

lb_ok=TRUE

ll_row= RowCount()
if ll_row > 0 then
	
	
   ldc_valore=GetItemDecimal(ll_row, "c_tot_imponibile")
   ldc_valore=uf_round(ldc_valore)
   idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_merce", ldc_valore )
	//20211020 si torna all'antico: niente parità (:) ma cambio(*)
   idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_merce_lire", ldc_valore * idc_cambio)
//	idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_merce_lire", ldc_valore / idc_cambio)
 
   ldc_valore=GetItemDecimal(ll_row, "c_tot_imp_scontato")
   ldc_valore=uf_round(ldc_valore)
   idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "netto_merce", ldc_valore, TRUE)
 //20211020 si torna all'antico: niente parità (:) ma cambio(*)
  idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "netto_merce_lire", ldc_valore * idc_cambio)
//	idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "netto_merce_lire", ldc_valore / idc_cambio)
	
	
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_imponibile", uf_GetItemDecimal(ll_row, "c_tot_val_tot_imp_v"), TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_imposta", uf_GetItemDecimal(ll_row, "c_tot_val_tot_iva_v") , TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_documento", uf_GetItemDecimal(ll_row, "c_tot_val_tot_imp_v") + uf_GetItemDecimal(RowCount(), "c_tot_val_tot_iva_v") , TRUE)
	
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_imponibile_lire", uf_GetItemDecimal(ll_row, "c_tot_val_tot_imp_l"), TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_imposta_lire", uf_GetItemDecimal(ll_row, "c_tot_val_tot_iva_l") , TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_documento_lire", uf_GetItemDecimal(ll_row, "c_tot_val_tot_imp_l") + uf_GetItemDecimal(ll_row, "c_tot_val_tot_iva_l") , TRUE)
else
	
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_merce", 0, TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "netto_merce", 0, TRUE)

	
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_imponibile", 0, TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_imposta", 0, TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_documento", 0, TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_imponibile_lire", 0, TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_imposta_lire", 0 , TRUE)
	idw_gen_tot_ext.uf_SetItem(idw_gen_tot.GetRow(), "tot_documento_lire", 0, TRUE)
end if

end event

event ue_applica_acconto();
	
	long 		ll_id_iva
	long		ll_id_valuta
	long		ll_id_tipo_pagamento
decimal		ld_importo_acconto, ld_importo_val_conto, LD_AVANZO_acconto, ld_imp
	long		ll_id_iva_acconto
	long		ll_n_righe
	long		ll_riga_giusta
	long		li_c
	long		errore, ll_nr_cifre_arrot, ll_id_valuta_doc
	string  ls_tipo_arrotondamento
	
	li_c = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
	ll_id_iva_acconto = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(li_c,"id_tab_iva_acconto")
	if not isnull (ll_id_iva_acconto) then

		ld_importo_acconto = tab_1.tabpage_1.dw_documento_ordine_ff.getitemdecimal(li_c,"imp_acconto")
		
			
			
							
		
		

		ll_n_righe = tab_1.tabpage_4.dw_cast_iva_documento_lt.RowCount()
	
		if ll_n_righe > 0 then
			li_c = 1
			ll_id_iva = tab_1.tabpage_4.dw_cast_iva_documento_lt.getitemnumber(li_c, "id_tab_iva")
			do while ( ll_id_iva <> ll_id_iva_acconto) And ( li_c <= ll_n_righe )
				li_c ++
				if li_c <= ll_n_righe then
					ll_id_iva = tab_1.tabpage_4.dw_cast_iva_documento_lt.getitemnumber(li_c,"id_tab_iva")
				end if
			loop
			ll_riga_giusta = li_c
			if li_c > ll_n_righe then	
				messagebox ( "ERRORE", 	"Non Esiste Nessuna Aliquota Nel Castelletto ~r~n"+ &
											"Corrispondente a quella dell' aliquota" )
			else
				ll_id_valuta_doc=idw_gen.getitemnumber(1, "documento_id_valuta_cod")
				SELECT "valuta"."cifra_arrotondamento",
				"valuta"."tipo_arrotondamento"
				INTO :ll_nr_cifre_arrot ,
						:ls_tipo_arrotondamento
				FROM "dba"."valuta"  
				WHERE "valuta"."id_valuta" = :ll_id_valuta_doc   ;
				
				
				
				ld_importo_acconto=F_ROUND(ld_importo_acconto, ll_nr_cifre_arrot, "M")
				errore = tab_1.tabpage_4.dw_cast_iva_documento_lt.setItem(ll_riga_giusta,"cc_acconto",ld_importo_acconto)
				wf_setta_cambio(3,"")
				ld_importo_val_conto=tab_1.tabpage_1.dw_documento_ordine_ff.getitemdecimal(li_c,"c_imp_acconto_convertito")
				this.setitem(ll_riga_giusta, "c_acconto_lire", ld_importo_val_conto)
			end if
		end if
	else
		li_c = tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
		
		
		ld_importo_acconto = tab_1.tabpage_1.dw_documento_ordine_ff.&
									getitemdecimal(li_c,"imp_acconto")
		if ld_importo_acconto > 0 then
			ll_riga_giusta = tab_1.tabpage_4.dw_scadenza_documento_lt.insertrow(1)
			if not isnull(ll_riga_giusta) or ll_riga_giusta > 0 then
//				ld_importo_val_conto = ld_importo_acconto * idc_cambio
				ld_importo_val_conto = ld_importo_acconto / idc_cambio
				
				ll_id_valuta = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(li_c,"id_val_acconto")
				ll_id_tipo_pagamento = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(li_c,"id_tipo_pag_acconto")
			
				tab_1.tabpage_4.dw_scadenza_documento_lt.setitem(ll_riga_giusta,"data_scadenza",Today())
				tab_1.tabpage_4.dw_scadenza_documento_lt.setitem(ll_riga_giusta,"tipo_scadenza","A")
				tab_1.tabpage_4.dw_scadenza_documento_lt.setitem(ll_riga_giusta,"id_valuta",ll_id_valuta)
				tab_1.tabpage_4.dw_scadenza_documento_lt.setitem(ll_riga_giusta,"id_tipo_pagamento",ll_id_tipo_pagamento)
				tab_1.tabpage_4.dw_scadenza_documento_lt.setitem(ll_riga_giusta,"importo",ld_importo_val_conto )
				tab_1.tabpage_4.dw_scadenza_documento_lt.setitem(ll_riga_giusta,"imp_valuta",ld_importo_acconto )
			end if
		end if
	end if
end event

event getfocus;call super::getfocus;

w_p_data lw_current

lw_current=u_freddie.iw_current
lw_current.cb_inserisci.Enabled = FALSE
lw_current.cb_cancella.Enabled = FALSE

end event

event losefocus;call super::losefocus;w_p_data 		lw_current
lw_current=u_freddie.iw_current
If IsValid(lw_current) then
	lw_current.cb_inserisci.Enabled = TRUE
	lw_current.cb_cancella.Enabled = TRUE
end if

end event

event constructor;call super::constructor;

this.Object.c_proporzionale.width = 0
this.Object.c_imp_spesa_omaggi.width = 0
this.Object.c_imposta.width = 0
this.Object.c_imposta.visible = 0


end event

event ue_init;call super::ue_init;is_title = "Castelletto IVA"
is_list.s_identifica[1] = "id_documento"
end event

event ue_update;call super::ue_update;if uf_dw_changed(this) =0 then
	
	ib_genera_castelletto = FALSE
end if




end event

event itemchanged;call super::itemchanged;decimal		ldc_valore
long		ll_row

ll_row= GetRow()
If IsNull(ll_row) then ll_row = row
CHOOSE CASE dwo.name
	CASE "val_tot_imp_v"
	beep(9)
		ldc_valore= Dec(data)
		//20211020 si torna all'antico: niente parità (:) ma cambio(*)
		ldc_valore= ldc_valore * idc_cambio
//		ldc_valore= ldc_valore / idc_cambio
		SetItem(ll_row, "val_tot_imp_l", ldc_valore)
		ib_cast_modificato=TRUE
		tab_1.tabpage_4.cb_applica.Visible=TRUE
	CASE "val_tot_imp_l"
		ldc_valore= Dec(data)
		//20211020 si torna all'antico: niente parità (:) ma cambio(*)
//		ldc_valore= ldc_valore / idc_cambio
		ldc_valore= ldc_valore * idc_cambio
		SetItem(ll_row, "val_tot_imp_v", ldc_valore)
		ib_cast_modificato=TRUE
		tab_1.tabpage_4.cb_applica.Visible=TRUE
	CASE "val_tot_iva_v"
		ldc_valore= Dec(data)
	//20211020 si torna all'antico: niente parità (:) ma cambio(*)
		ldc_valore= ldc_valore * idc_cambio
	//	ldc_valore= ldc_valore / idc_cambio
		SetItem(ll_row, "val_tot_iva_l", ldc_valore)
		ib_cast_modificato=TRUE
		tab_1.tabpage_4.cb_applica.Visible=TRUE
	CASE "val_tot_iva_l"
		ldc_valore= Dec(data)
		//20211020 si torna all'antico: niente parità (:) ma cambio(*)
//		ldc_valore= ldc_valore / idc_cambio
		ldc_valore= ldc_valore * idc_cambio
		SetItem(ll_row, "val_tot_iva_v", ldc_valore)
			ib_cast_modificato=TRUE
		tab_1.tabpage_4.cb_applica.Visible=TRUE
END CHOOSE
end event

event ue_retrieve;call super::ue_retrieve;

Post TriggerEvent("ue_applica_cast_iva")

end event

event rowfocuschanged;
end event

type dw_spesa_documento_gd from u_dw_master_main within tabpage_4
event ue_cancella_spese ( )
event ue_aggiorna ( )
integer y = 108
integer width = 1673
integer height = 308
integer taborder = 10
string dataobject = "d_spesa_documento_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_cancella_spese();long ll_count, ll_nr_row
char lc_mantieni

ll_nr_row= tab_1.tabpage_4.dw_spesa_documento_gd.RowCount()

if (ll_nr_row <= 0) then return 

for ll_count= 1 to ll_nr_row
	
	lc_mantieni = tab_1.tabpage_4.dw_spesa_documento_gd.getitemstring(ll_nr_row - ll_count + 1, "mantieni")
	if (lc_mantieni = 'N') or (isnull(lc_mantieni)) then &
		tab_1.tabpage_4.dw_spesa_documento_gd.DeleteRow(ll_nr_row - ll_count + 1)

next
//20261012 il castelletto lo ricalcola ue_aggiorna (l'unico che chiama questo evento), una volta sola dopo aver ricreato le spese
//cb_ricalcola_cast.triggerevent(clicked!)
end event

event ue_aggiorna();
long ll_ret_value
long ll_spese_prima  //20261012

ll_spese_prima = tab_1.tabpage_4.dw_spesa_documento_gd.RowCount()  //20261012 se > 0 ue_cancella_spese ricalcolava il castelletto
TriggerEvent("ue_cancella_spese")
s_spese_calcolate ls_spese_calcolate
integer	 li_rows, li_i
long		 ll_id_prof_documento, ll_id_tipo_trasporto, ll_id_sog_commerciale
long		 ll_id_con_pagamento,ll_id_doc
decimal	 ld_tot_merce

ll_id_prof_documento = idw_gen.getitemnumber(1, "id_prof_documento")
ll_id_tipo_trasporto = idw_gen.getitemnumber(1, "id_tipo_trasporto_des")
ll_id_con_pagamento = idw_gen.getitemnumber(1, "id_con_pagamento_des")
ll_id_sog_commerciale = idw_gen.getitemnumber(1, "id_sog_commerciale")
ll_id_doc= idw_gen.getitemnumber(1, "id_documento")
if (idw_riga.rowcount() > 0) then
	ld_tot_merce = idw_riga.getitemnumber(1, "c_tot_righe_lire")
else
	ld_tot_merce = 0
end if

long	ll_id_val_doc


ll_id_val_doc = idw_gen.getitemnumber(1, "documento_id_valuta_des")

DATASTORE lds_iva
lds_iva = create datastore
lds_iva.dataobject = "ds_iva_spese_gd"
	
if (idw_riga.rowcount() > 0) then lds_iva.object.id_tab_iva.Current = idw_riga.object.riga_documento_id_tab_iva.Current

ls_spese_calcolate = f_calcola_spese_documento(ll_id_prof_documento, ll_id_tipo_trasporto, ll_id_con_pagamento, ll_id_sog_commerciale, ld_tot_merce, ll_id_val_doc, ll_id_val_doc, lds_iva, ll_id_doc)
destroy lds_iva

	
li_rows = upperbound(ls_spese_calcolate.id_spesa)

//20261012 il castelletto che faceva ue_cancella_spese serve solo quando quello finale (sotto) non parte
if ll_spese_prima > 0 and (li_rows <= 0 or idw_riga.rowcount() = 0) then tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)
if (li_rows <= 0) then return


for li_i = 1 to li_rows
	
	uf_crea_spesa(li_i, '0', &
		ls_spese_calcolate.id_spesa[li_i], &
		ls_spese_calcolate.percentuale[li_i], &
		ls_spese_calcolate.importo[li_i], &
		ls_spese_calcolate.id_tab_iva[li_i], &
		ls_spese_calcolate.mod_cal_iva[li_i])
next
if (idw_riga.rowcount() > 0) then tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)  //20240730 era commentato, ma DEVE ricalcolare il castelletto altrimenti lo lascia senza spese...
end event

event itemchanged;

long		ll_id_tab_iva, ll_id_tab_iva_sc, ll_id_sog_commerciale
char		lc_segue_esenzione, lc_tipo_iva, lc_mod_cal_iva
integer	li_ret

CHOOSE CASE dwo.name
	CASE "id_spesa_cod", "id_spesa_des"
		
		
		
		string	ls_codice
		long		ll_id_prof_documento
		integer	li_spesa_gestita
		
		ll_id_prof_documento = idw_gen.getitemnumber(1, "id_prof_documento")
				
		SELECT LOCATE( p.spese_gestite, s.codice) 
		INTO	 :li_spesa_gestita
		FROM	 prof_documento p, spesa s
		WHERE  p.id_prof_documento = :ll_id_prof_documento
		AND	 s.id_spesa = :data
		;
				
		if (li_spesa_gestita <= 0) then
			messagebox("Attenzione", "La spesa inserita non è abilitata nel profilo documento")
			return 1
		end if
		

		
		SELECT id_tab_iva, segue_esenzione, mod_cal_iva
		INTO	 :ll_id_tab_iva, :lc_segue_esenzione, :lc_mod_cal_iva
		FROM	 spesa 
		WHERE  id_spesa = :data
		;
		
		if (SQLCA.SQLCODE = -1) then &
			messagebox("dw_spesa_documento_gd / itemchanged", SQLCA.SQLERRTEXT)
		
		ll_id_sog_commerciale = idw_gen.getitemnumber(1, "id_sog_commerciale")
		
		SELECT sc.id_tab_iva, t.tipo_iva
		INTO	 :ll_id_tab_iva_sc, :lc_tipo_iva
		FROM	 sog_commerciale sc, tab_iva t
		WHERE  sc.id_sog_commerciale = :ll_id_sog_commerciale
		AND	 t.id_tab_iva = sc.id_tab_iva
		;
		if (SQLCA.SQLCODE = -1) then &
			messagebox("dw_spesa_documento_gd / itemchanged", SQLCA.SQLERRTEXT)
		
		
		if (ll_id_tab_iva_sc > 0 and (lc_tipo_iva = 'S' or lc_tipo_iva = 'I') and lc_segue_esenzione = 'S') then &
			ll_id_tab_iva = ll_id_tab_iva_sc
			
		this.setitem(row, "id_tab_iva_cod", ll_id_tab_iva)
		this.setitem(row, "cc_mod_calc_iva", lc_mod_cal_iva)		
		
	CASE "importo", "c_importo_lire"
		SetItem(row, "cc_importo_buffer", Dec(data))
	CASE "percentuale"
		decimal ld_importo
		ld_importo = dw_documento_tot_ext_ff.getitemnumber(1, "tot_merce_lire")
		if (ld_importo > 0) then
			ld_importo = ld_importo * dec(data) / 100
			post setitem(row, "importo", ld_importo)
		end if
END CHOOSE

CHOOSE CASE dwo.name
	CASE "importo", "c_importo_lire", "percentuale"
		cb_ricalcola_cast.post event clicked()
		tab_1.tabpage_4.dw_scadenza_documento_lt.PostEvent("ue_simula")
END CHOOSE

end event

event ue_init;call super::ue_init;is_list.s_identifica[1] 	= "id_documento"

end event

event ue_delete;long  ll_Row
ll_Row=0
if ib_allow_delete and THIS.getconfirm(ici_confirm_delete) then
	If RowCount() < GetRow() then ll_Row=RowCount()
	THIS.DeleteRow(ll_Row)
	This.SetFocus()
	
	
	
		cb_ricalcola_cast.post event clicked()
		tab_1.tabpage_4.dw_scadenza_documento_lt.PostEvent("ue_simula")
	
end if

end event

event retrieverow;call super::retrieverow;

if GetItemNumber(row,"id_spesa_cod") = il_id_spesa_incasso then
	SetItem(row, "cc_importo_buffer", idc_spesa_inc_importo)
end if

end event

event ue_retrieve;call super::ue_retrieve;is_title= "Spese " + is_nome_tipo_documento
end event

event itemfocuschanged;call super::itemfocuschanged;
end event

event constructor;call super::constructor;

this.Object.c_importo_lire.width = 0



end event

event losefocus;call super::losefocus;integer li_ret

li_ret=accepttext()
if li_ret=-1 then messagebox('Attenzione!','Errore nelle spese!')
end event

event rowfocuschanged;
end event

type st_spese_riepilogo from statictext within tabpage_4
integer y = 16
integer width = 1216
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = " Spese / Riepilogo IVA"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_aggiorna from commandbutton within tabpage_4
integer x = 1230
integer y = 16
integer width = 375
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricalcola Spese"
end type

event clicked;wf_calcola_spese('S')	
end event

type st_spese_riepilogo_cont from statictext within tabpage_4
integer x = 1618
integer y = 16
integer width = 50
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_st_scadenze_sconti_cont from statictext within tabpage_4
integer x = 1618
integer y = 16
integer width = 50
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_ricalcola_scadenze from commandbutton within tabpage_4
boolean visible = false
integer x = 2304
integer y = 16
integer width = 320
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Ricalc. Scad."
end type

event clicked;If MessageBox(is_nome_tipo_documento, "Vuoi sostituire le attuali Scadenze ricalcolandole?", Information!,YesNo!, 1) = 1 then
	ib_genera_scadenza= TRUE
	tab_1.tabpage_4.dw_cast_iva_documento_lt.TriggerEvent("ue_calc_cast_iva")
end if




end event

type dw_documento_ord_tot_ff from u_dw_master_main within tabpage_4
integer y = 780
integer width = 2208
integer height = 468
integer taborder = 40
string dataobject = "d_documento_ord_tot_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE

is_list.s_colonne_drop[1]="id_tipo_pag_acconto"
is_list.s_colonne_drop[2]="id_tab_iva_acconto"
is_list.s_colonne_drop[3]="id_val_acconto"
end event

event itemchanged;

CHOOSE CASE dwo.name
	CASE "sconto_finanziario", "sconto_fin_cassa", "fin_incondizionato"
		cb_ricalcola_cast.post event clicked()
		tab_1.tabpage_4.dw_scadenza_documento_lt.PostEvent("ue_simula")
END CHOOSE
end event

event ue_retrieve;call super::ue_retrieve;is_title= is_nome_tipo_documento
end event

event rowfocuschanged;
end event

type st_st_scadenze_sconti from statictext within tabpage_4
integer x = 1673
integer y = 16
integer width = 311
integer height = 84
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 276856960
boolean enabled = false
string text = "Scad/Sconti"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_valuta from commandbutton within tabpage_4
event clicked pbm_bnclicked
boolean visible = false
integer x = 2400
integer y = 1084
integer width = 320
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lire/Euro"
end type

event clicked;
if not(idc_cambio =1) then
	idw_castelletto.SetRedraw(FALSE)
	idw_scadenza.SetRedraw(FALSE)
	idw_spesa.SetRedraw(FALSE)
	
	If this.text = "Lire/Euro" then
		this.text = "Valuta"
		st_val_corrente.text = "Lire/Euro"
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
		this.text = "Lire/Euro"
		st_val_corrente.text = "Valuta"
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
	iuo_msg_log.uf_new_text("Il cambio del documento è già in lire.", 4)
end if
end event

type cb_ricalcola_cast from commandbutton within tabpage_4
integer x = 2304
integer y = 1460
integer width = 448
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = " Cast. IVA - CPT"
end type

event clicked;
	ib_genera_castelletto= TRUE
	SetPointer(HourGlass!)
	
	tab_1.tabpage_4.dw_cast_iva_documento_lt.TriggerEvent("ue_calc_cast_iva")
	tab_1.tabpage_5.dw_contr_documento_lt.TriggerEvent("ue_calc_contropartita")
	uf_report_righe()
	tab_1.tabpage_4.cb_valuta.triggerevent(clicked!)
	tab_1.tabpage_4.cb_valuta.triggerevent(clicked!)
	SetPointer(Arrow!)
	



end event

type dw_documento_tot_ext_ff from u_dw_master_main within tabpage_4
integer y = 1280
integer width = 2208
integer height = 316
integer taborder = 0
string dataobject = "d_documento_tot_ext_ff"
end type

event constructor;call super::constructor;InsertRow(0)
end event

event rowfocuschanged;
end event

type cbx_gen_bollo from checkbox within tabpage_4
integer x = 2578
integer y = 28
integer width = 274
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Gen.Bollo "
boolean checked = true
boolean lefttext = true
end type

type cb_applica from commandbutton within tabpage_4
integer x = 2304
integer y = 1344
integer width = 448
integer height = 80
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Applica Variazioni"
end type

event clicked;If MessageBox(is_nome_tipo_documento, "Vuoi ricalcolare il Castelletto delle Contropartite?", Information!,YesNo!, 1) = 1 then
	ib_genera_castelletto= TRUE
	SetPointer(HourGlass!)
	tab_1.tabpage_4.dw_cast_iva_documento_lt.TriggerEvent("ue_applica_cast_iva")
	tab_1.tabpage_5.dw_contr_documento_lt.TriggerEvent("ue_calc_contropartita")
	uf_report_righe()
	SetPointer(Arrow!)
end if
end event

type st_1 from statictext within tabpage_4
boolean visible = false
integer x = 2277
integer y = 844
integer width = 544
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Visualizzazione Corrente"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_val_corrente from statictext within tabpage_4
boolean visible = false
integer x = 2400
integer y = 908
integer width = 288
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Valuta"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_4
boolean visible = false
integer x = 2400
integer y = 1012
integer width = 224
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Converti In"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_4
integer x = 1998
integer y = 28
integer width = 315
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
string text = "Data dec.pag:"
boolean focusrectangle = false
end type

type dw_scadenza_documento_lt from u_dw_master_main within tabpage_4
event type decimal ue_simula ( )
event type decimal ue_rate_ges_spesa ( string as_spesa )
event ue_visibilita_campi ( )
integer x = 1682
integer y = 108
integer width = 1170
integer height = 308
integer taborder = 20
string dataobject = "d_scadenza_documento_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event type decimal ue_simula();
s_scadenze		lstr_scadenze
boolean	lb_ok
long		ll_id_cp, ll_id_anag, ll_row, ll_nr_row, ll_id_valuta, ll_id_documento,ll_id_tab_iva_acconto
long		ll_nr_scadenze, ll_count, ll_id_intestatario, ll_id_azienda
long		ll_id_banca_azienda, ll_id_banca_sog_com
decimal	ldc_impon, ldc_impos, ldc_bollo, ldc_imp_lire, ldc_bollo_tot, ldc_appoggio
decimal	ldc_imp_parziale, ldc_tot_imp_val,ldc_imp_val, ldc_impon_acc
date		ldc_iniz,ldc_nuova_data
decimal	ldc_impr[], ldc_ivar[]
date		ldc_datr[]
integer	li_size, li_i
boolean 	 lb_gen_bollo
string	ls_appoggio, lb_scadenze_raggruppate
string	ls_tipo_scadenza
integer  li_giorno,li_mese,li_anno,li_giorno_con,li_mese_con
string   ls_giorno,ls_mese,ls_anno
ll_row= il_row
string ls_esito_pagamento
boolean lb_ricalcola

integer  li_dec_significativi
string	ls_tipo_arrotondamento

ll_id_valuta= idw_gen.GetItemNumber(ll_row, "documento_id_valuta_des")

SELECT v.dec_significativi, v.tipo_arrotondamento
INTO	 :li_dec_significativi, :ls_tipo_arrotondamento
FROM	 valuta v
WHERE  v.id_valuta = :ll_id_valuta;

if (sqlca.sqlcode = -1) then &
	messagebox("ue_simula/DbError", sqlca.sqlerrtext)

datastore ds_scade
ds_scade=create datastore
ds_scade.dataobject='ds_spec_scadenza'
ds_scade.reset()
ds_scade.settransobject(sqlca)

long ll_id_prof_doc, ll_id_sog_com
string ls_tipo_fat, ls_tipo, ls_tipo_sog

ll_id_prof_doc = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_prof_documento")
ll_id_sog_com  = tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_sog_commerciale")

select tipo_fattura
into :ls_tipo_fat
from prof_documento
where id_prof_documento = :ll_id_prof_doc;


CHOOSE CASE Right(is_tipo_registro,1)
	CASE "A" 
		ls_tipo_scadenza="P"
		
		
		if ls_tipo_fat = 'C' then
  			ls_tipo_scadenza= "A"				
		end if		
		
		
	CASE "V"
		ls_tipo_scadenza= "A"
		
		
		if ls_tipo_fat = 'C' then
			ls_tipo_scadenza="P"				
		end if
		
		
	CASE ELSE
		ll_id_intestatario= idw_gen.GetItemNumber(ll_row, "id_sog_commerciale")		
		
		select tipo
		into :ls_tipo_sog
		from sog_commerciale
		where id_sog_commerciale = :ll_id_intestatario;
		
		if ls_tipo_sog = 'C' then 
			ls_tipo_scadenza="A"
		else
			ls_tipo_scadenza="P"			
		end if
END CHOOSE
lb_gen_bollo=tab_1.tabpage_4.cbx_gen_bollo.checked
ll_id_valuta= idw_gen.GetItemNumber(ll_row, "documento_id_valuta_des")
ll_id_intestatario= idw_gen.GetItemNumber(ll_row, "id_sog_commerciale")
SELECT "sog_commerciale"."id_banca_sog_commerciale"  
	INTO :ll_id_banca_sog_com  
	FROM "dba"."sog_commerciale"  
	WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_intestatario   ;
SELECT "sog_commerciale"."scad_raggruppate"  
	INTO :lb_scadenze_raggruppate  
	FROM "dba"."sog_commerciale"  
	WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_intestatario    ;

ll_id_documento= idw_gen.GetItemNumber(ll_row, "id_documento")
ll_id_azienda= idw_gen.GetItemNumber(ll_row, "documento_id_azienda")
SELECT "azienda"."id_banca_azienda"  
	INTO :ll_id_banca_azienda  
	FROM "dba"."azienda"  
	WHERE "azienda"."id_azienda" = :ll_id_azienda   ;

ll_nr_row= idw_castelletto.RowCount()
If ll_nr_row > 0 then
	ldc_impon = idw_castelletto.GetItemDecimal(ll_nr_row,"c_tot_imponibile_spesa_lire")
	if idw_gen_tot.rowcount()>0 then
		ldc_impon_acc=idw_gen_tot.getitemdecimal(1,"documento_imp_acconto")
		ll_id_tab_iva_acconto=idw_gen_tot.getitemdecimal(1,"id_tab_iva_acconto")
	end if
	if isnull(ldc_impon_acc) then ldc_impon_acc=0
	if ll_id_tab_iva_acconto>0 then
		ldc_impon=idw_gen_tot_ext.getitemdecimal(1,"tot_imponibile_lire")
	else
		ldc_impon=idw_gen_tot_ext.getitemdecimal(1,"tot_imponibile_lire")-ldc_impon_acc
	end if
	
	
	ldc_impos = idw_castelletto.GetItemDecimal(ll_nr_row,"c_tot_iva_lire")
	
	
	ldc_tot_imp_val= idw_castelletto.GetItemDecimal(ll_nr_row,"c_tot_imponibile_spesa") + idw_castelletto.GetItemDecimal(ll_nr_row,"c_tot_iva_val")
	ldc_iniz = idw_gen.GetItemDate( ll_row,"documento_data_dec_pagamento")
	If IsNull(ldc_iniz) then ldc_iniz = idw_gen.GetItemDate( ll_row,"data_documento") 
	If IsNull(ldc_iniz) then ldc_iniz = idw_gen.GetItemDate( ll_row,"data_registrazione")	
	If IsNull(ldc_iniz) then ldc_iniz = Date("01/01/1900")
	ll_id_cp = idw_gen.GetItemNumber( ll_row,"id_con_pagamento_des")
	ll_id_anag = idw_gen.GetItemNumber( ll_row,"id_sog_commerciale")
	
	
	
	lb_ok = iuo_pag.uf_calcola_pagamenti_e(ll_id_valuta,ldc_impon,ldc_impos,ldc_iniz,ll_id_anag,ll_id_cp,lstr_scadenze)	
	
		
	if is_stato_scad_generata <> "N" then
		
		ll_nr_scadenze= RowCount()
		
		
		lb_ricalcola = true
		for ll_count = 1 to ll_nr_scadenze
			ls_esito_pagamento=this.getitemstring(ll_count, "esito_pagamento")
			if (not isnull(ls_esito_pagamento)) and ls_esito_pagamento <> 'E' then
				lb_ricalcola = false
			end if
		next
		
		if (not lb_ricalcola) then
			ldc_bollo_tot=0
			RETURN ldc_bollo_tot
		end if
			
		
		
		for ll_count= 1 to ll_nr_scadenze
			DeleteRow(ll_nr_scadenze - ll_count + 1)
		next
	
		li_size = UpperBound(lstr_scadenze.dc_imp_out)
		if not (IsNull(li_size) OR li_size=0) then
			for li_i = 1 to li_size -1
				ll_row = InsertRow(0)
				if ll_row>0 then
					SetItem(ll_row, "id_sog_commerciale", ll_id_intestatario)
					
					
					
					li_giorno_con=day(lstr_scadenze.d_date[li_i])
					li_mese_con=month(lstr_scadenze.d_date[li_i])
					ds_scade.reset()
					ds_scade.retrieve(ll_id_intestatario,li_giorno_con,li_mese_con)
					if ds_scade.rowcount()>0 then
						li_giorno=ds_scade.getitemnumber(1,'gg_app')
						li_mese=ds_scade.getitemnumber(1,'ms_app')
						if li_mese_con>li_mese then
							li_anno=year(lstr_scadenze.d_date[li_i]) + 1
					  	else
							if li_mese_con=li_mese and li_giorno_con>li_giorno then
								li_anno=year(lstr_scadenze.d_date[li_i]) + 1
					   	else
								li_anno=year(lstr_scadenze.d_date[li_i])
							end if
						end if
						
						ls_anno=string(li_anno)
						ls_giorno=string(li_giorno)
						if len(ls_giorno)=1 then ls_giorno='0'+ls_giorno
						ls_mese=string(li_mese)
						if len(ls_mese)=1 then ls_mese='0'+ls_mese
						ldc_nuova_data=date(ls_giorno+'/'+ls_mese+'/'+ls_anno)
						lstr_scadenze.d_date[li_i]=ldc_nuova_data
					end if
					
					
					SetItem(ll_row,"data_scadenza",lstr_scadenze.d_date[li_i])
					SetItem(ll_row, "id_valuta", ll_id_valuta)
					SetItem(ll_row, "cambio", idc_cambio)
										
//					ldc_imp_val = (lstr_scadenze.dc_iva_out[li_i] + lstr_scadenze.dc_imp_out[li_i]) / idc_cambio
					ldc_imp_val = (lstr_scadenze.dc_iva_out[li_i] + lstr_scadenze.dc_imp_out[li_i]) * idc_cambio	//ma se è già in valuta	???? 20220303
					
					ldc_imp_val = f_Round(ldc_imp_val, li_dec_significativi, "M")
					
					
					ldc_imp_parziale= ldc_imp_parziale + ldc_imp_val
					
					
					If not lb_gen_bollo then lstr_scadenze.dc_bollo[li_i]=0
															
					ldc_imp_lire= uf_Round(lstr_scadenze.dc_iva_out[li_i] + lstr_scadenze.dc_imp_out[li_i] + lstr_scadenze.dc_bollo[li_i])				
						
					If not IsNull(idc_cambio) then 
						SetItem(ll_row,"importo", ldc_imp_lire)
						//SetItem(ll_row,"imp_valuta", ldc_imp_val + (lstr_scadenze.dc_bollo[li_i] / idc_cambio)) //riattivo questo 03-02-2022
						SetItem(ll_row,"imp_valuta", ldc_imp_val + (lstr_scadenze.dc_bollo[li_i] * idc_cambio))  //da verificare 20220210 no, così NON funge!!! 02-03-2022
					end if
					If not IsNull(idc_cambio) then SetItem(ll_row,"importo", ldc_imp_lire)
					SetItem(ll_row,"id_tipo_pagamento",lstr_scadenze.l_id_tipo_pagamento[li_i])
					SetItem(ll_row,"id_banca_sog_commerciale",ll_id_banca_sog_com)
					SetItem(ll_row,"stato_scadenza",is_stato_scad_generata)
					SetItem(ll_row,"esito_pagamento","E")
					SetItem(ll_row,"scadenza_da_raggruppare",lb_scadenze_raggruppate)
					SetItem(ll_row, "id_documento", ll_id_documento)
					SetItem(ll_row, "tipo_scadenza", ls_tipo_scadenza)
				end if
									
			next
			
			
			ll_row = InsertRow(0)
				
			
			if ll_row>0 then
				SetItem(ll_row, "id_sog_commerciale", ll_id_intestatario)
				
				
				
				li_giorno_con=day(lstr_scadenze.d_date[li_size])
				li_mese_con=month(lstr_scadenze.d_date[li_size])
				ds_scade.reset()
				ds_scade.retrieve(ll_id_intestatario,li_giorno_con,li_mese_con)
				if ds_scade.rowcount()>0 then
					li_giorno=ds_scade.getitemnumber(1,'gg_app')
					li_mese=ds_scade.getitemnumber(1,'ms_app')
					if li_mese_con>li_mese then
						li_anno=year(lstr_scadenze.d_date[li_size]) + 1
					  else
						if li_mese_con=li_mese and li_giorno_con>li_giorno then
							li_anno=year(lstr_scadenze.d_date[li_size]) + 1
					   else
							li_anno=year(lstr_scadenze.d_date[li_size])
						end if
					end if
					ls_anno=string(li_anno)
					ls_giorno=string(li_giorno)
					if len(ls_giorno)=1 then ls_giorno='0'+ls_giorno
					ls_mese=string(li_mese)
					if len(ls_mese)=1 then ls_mese='0'+ls_mese
					ldc_nuova_data=date(ls_giorno+'/'+ls_mese+'/'+ls_anno)
					lstr_scadenze.d_date[li_size]=ldc_nuova_data
				end if
				
				SetItem(ll_row,"data_scadenza",lstr_scadenze.d_date[li_size])
				SetItem(ll_row, "id_valuta", ll_id_valuta)
				SetItem(ll_row, "cambio", idc_cambio)
				
				If not lb_gen_bollo then lstr_scadenze.dc_bollo[li_size]=0
				
				if isnull(ll_id_tab_iva_acconto) or ll_id_tab_iva_acconto<1 then
					ldc_tot_imp_val=ldc_tot_imp_val - ldc_impon_acc
				end if
				
				
				
				
				ldc_tot_imp_val = f_round(ldc_tot_imp_val, li_dec_significativi, "M")
				
				ldc_imp_lire= ((ldc_tot_imp_val  - ldc_imp_parziale) * idc_cambio) + lstr_scadenze.dc_bollo[li_size]
				//ldc_imp_lire= ((ldc_tot_imp_val  - ldc_imp_parziale) / idc_cambio) + lstr_scadenze.dc_bollo[li_size] //20220210 da verificare
//				SetItem(ll_row,"imp_valuta", ldc_imp_lire / idc_cambio)
				//SetItem(ll_row,"imp_valuta", ldc_imp_lire * idc_cambio) //20220303 è già in valuta, perché traformarla in euro e poi riportarla a valuta??????
				SetItem(ll_row,"imp_valuta",ldc_tot_imp_val)
				If not IsNull(idc_cambio) then SetItem(ll_row,"importo", ldc_imp_lire)
				SetItem(ll_row,"id_tipo_pagamento",lstr_scadenze.l_id_tipo_pagamento[li_size])
				SetItem(ll_row,"id_banca_sog_commerciale",ll_id_banca_sog_com)
				SetItem(ll_row,"stato_scadenza",is_stato_scad_generata)
				SetItem(ll_row,"esito_pagamento","E")
				SetItem(ll_row,"scadenza_da_raggruppare",lb_scadenze_raggruppate)
				SetItem(ll_row, "id_documento", ll_id_documento)
				SetItem(ll_row, "tipo_scadenza", ls_tipo_scadenza)
			end if
		
//		ldc_bollo_tot= lstr_scadenze.dc_bollo_tot / idc_cambio
		ldc_bollo_tot= lstr_scadenze.dc_bollo_tot * idc_cambio

		
		end if
	end if
end if

DESTROY ds_scade

If not lb_gen_bollo then ldc_bollo_tot=0
RETURN ldc_bollo_tot

end event

event ue_rate_ges_spesa;call super::ue_rate_ges_spesa;
long ll_count, ll_nr_row, ll_scad_x_spesa, ll_id_con_pagamento
string ls_spese

ll_nr_row= RowCount()
if ll_nr_row > 0  AND not ib_genera_scadenza then
	FOR ll_count = 1 to  ll_nr_row
		
		ll_id_con_pagamento= GetItemNumber(ll_count, "id_tipo_pagamento")
		SELECT "tipo_pagamento"."spese_gestite"  
			INTO :ls_spese  
			FROM "dba"."tipo_pagamento"  
			WHERE "tipo_pagamento"."id_tipo_pagamento" = :ll_id_con_pagamento   ;
		if Pos(ls_spese, as_spesa) > 0 then
			ll_scad_x_spesa ++
		end if
	NEXT
else
	ll_id_con_pagamento= idw_gen.GetItemNumber(il_row, "id_con_pagamento")
	ll_scad_x_spesa= iuo_pag.uf_rate_ges_spesa(ll_id_con_pagamento, "C")
end if
RETURN ll_scad_x_spesa


end event

event ue_visibilita_campi;
long	ll_id_val_conto, ll_id_val_doc, ll_id_esercizio

ll_id_esercizio = idw_gen.getitemnumber(1, "c_esercizio")

SELECT id_valuta
INTO	 :ll_id_val_conto
FROM	 esercizio
WHERE  id_esercizio = :ll_id_esercizio
;

ll_id_val_doc = idw_gen.getitemnumber(1, "documento_id_valuta_des")

if (ll_id_val_doc <> ll_id_val_conto) then
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

end event

event ue_init;call super::ue_init;is_list.s_identifica[1]= "id_documento"


end event

event ue_delete;

long ll_count, ll_nr_row

if MessageBox(is_title, "Vuoi calcellare tutte le Scadenze?", Information!, YesNo!,1) = 1 then

	ll_nr_row= RowCount()
	for ll_count= 1 to ll_nr_row
		DeleteRow(ll_nr_row - ll_count + 1)
	next
	ib_genera_scadenza= TRUE
end if
end event

event ue_retrieve;call super::ue_retrieve;is_title = "Scadenze " + is_nome_tipo_documento
If RowCount() = 0 then
	ib_genera_scadenza= TRUE
end if
end event

event ue_update;call super::ue_update;


end event

event ue_insert;
end event

event constructor;call super::constructor;

this.Object.imp_valuta.width = 0

end event

event rowfocuschanged;
end event

type dw_1 from datawindow within tabpage_4
integer x = 2299
integer y = 12
integer width = 279
integer height = 92
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_data_dec_pag"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1,'documento_data_dec_pagamento',date(data))
end event

event losefocus;accepttext()
tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1,'documento_data_dec_pagamento',this.getitemdate(1,'data_dec_pag'))
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2907
integer height = 1640
long backcolor = 79741120
string text = "Contropartita"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_contr_documento_lt dw_contr_documento_lt
end type

on tabpage_5.create
this.dw_contr_documento_lt=create dw_contr_documento_lt
this.Control[]={this.dw_contr_documento_lt}
end on

on tabpage_5.destroy
destroy(this.dw_contr_documento_lt)
end on

type dw_contr_documento_lt from u_dw_master_main within tabpage_5
event type string ue_calc_righe_cast ( )
event ue_calc_sp_iva_cast ( )
event ue_calc_sconti_cast ( )
event type boolean ue_calc_contropartita ( )
event ue_calc_non_da_conto ( )
event ue_clear_contropartita ( )
event ue_wizard ( )
event ue_no_cpt ( )
event ue_ripul_cpt ( )
event ue_quadra_cpt ( )
integer x = 14
integer y = 12
integer width = 2816
integer height = 1536
integer taborder = 31
string dataobject = "d_contr_documento_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event type string ue_calc_righe_cast();
long 			ll_nr_row, ll_count, ll_id_contropartita, ll_new_row,ll_row_found, ll_id_tab_iva_max, ll_tot_row
long			ll_id_articolo, ll_id_tab_iva, ll_nr_riga, ll_id_iva_acconto, ll_id_uc
decimal 		ldc_imponibile, ldc_tot_riga,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_omaggi_sc_merce
decimal 		ldc_val_omaggi, ldc_sconto_merce_art_15, ldc_sconto_merce_iva, ldc_tot_omaggi_sc_merce, ldc_imponibile_non_sc
string 		ls_codice, ls_descr_breve, ls_sconto, ls_report, ls_riga_valida
decimal 		ldc_sconto_merce, ldc_acconto, ldc_peso_netto
integer		li_ret_value, li_righe_valide 

long ll_id_conto_avanzo_cambio, ll_id_conto_cliente, ll_cifra_arr
decimal ldc_avanzo_cambio,         ldc_finocalo, ldc_tot_metallo ////ultimo 2 inserito 20221123 divisioine degli importi nel documento

string ls_cpt_sconti, ls_tipo_arr
long ll_id_cpt_sconti, ll_id_sog_commerciale, ll_gen_row,    ll_id_galv,   ll_id_conto,ll_id_cpt_metallo    ////ultimo 2 inserito 20221123
decimal ldc_sc_fin_cassa, ldc_sc_incondizionato, ldc_sconto_riga, ldc_sconto_unit_riga
string ls_sc_finanziario,        ls_dividi_importi  //ultimo inserito 20221123 divisioine degli importi nel documento

select gest_cpt_sconti
into :ls_cpt_sconti
from par_sistema;
ll_gen_row= il_row
ll_id_sog_commerciale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,'id_sog_commerciale')
ls_sc_finanziario= idw_gen.GetItemString(ll_gen_row, "documento_sconto_finanziario")
ldc_sc_incondizionato= idw_gen.uf_GetItemDecimal(ll_gen_row, "sconto_fin_incondizionato")
ldc_sc_fin_cassa= idw_gen.uf_GetItemDecimal(ll_gen_row, "documento_sconto_fin_cassa")
select cifra_arrotondamento, tipo_arrotondamento
into   :ll_cifra_arr, :ls_tipo_arr
from   valuta
where  id_valuta = :al_id_val_az;
li_righe_valide= 0
ls_report=""
if not (IsNull(il_id_documento) OR il_id_documento=0) then
	li_ret_value=0
	ldc_val_omaggi=0
	ldc_sconto_merce_art_15= 0
	ldc_sconto_merce_iva=0
	ll_nr_row= idw_riga.RowCount()
	if ll_nr_row =0 then li_ret_value= -1
	for ll_count = 1 to ll_nr_row
		ldc_omaggi_sc_merce=0
		ldc_tot_riga = idw_riga.uf_GetItemDecimal(ll_count, "tot_riga_val_az")
		if IsNull(ldc_tot_riga)  then ldc_tot_riga = 0
		ldc_prezzo_un = idw_riga.uf_GetItemDecimal(ll_count, "prezzo")
		if IsNull(ldc_prezzo_un)  then ldc_prezzo_un = 0
		ldc_sconto_merce= idw_riga.uf_GetItemDecimal(ll_count, "qta_sconto_merce")
		if IsNull(ldc_sconto_merce)  then ldc_sconto_merce = 0
		ls_sconto = idw_riga.GetItemString(ll_count, "sconto")
		if IsNull(ls_sconto)  then ls_sconto = ""
		ldc_quantita = idw_riga.uf_GetItemDecimal(ll_count, "quantita")
		if IsNull(ldc_quantita)  then ldc_quantita = 0
		ll_id_tab_iva= idw_riga.GetItemDecimal(ll_count, "riga_documento_id_tab_iva")
		ll_id_contropartita = idw_riga.GetItemNumber(ll_count, "riga_documento_id_conto")
		If IsNull(ll_id_contropartita) OR ll_id_contropartita=0 then ll_id_contropartita= il_id_conto_predefinito
		ll_id_articolo= idw_riga.GetItemNumber(ll_count, "riga_documento_id_articolo")
		ll_id_uc= idw_riga.GetItemNumber(ll_count, "riga_documento_id_unita_confezione")
		ls_riga_valida= idw_riga.GetItemString(ll_count, "c_riga_valida")
		If ls_riga_valida= "V" then
			ldc_sconto_riga = idw_riga.GetItemnumber(ll_count, "riga_documento_sconto_riga")
			ldc_sconto_unit_riga = 0
			if ls_cpt_sconti = 'S' then
				uo_cpt_sconti u_cpt_sconti
				u_cpt_sconti = create uo_cpt_sconti
				ll_id_cpt_sconti = u_cpt_sconti.uf_cpt_sconti("",0,0,ls_sconto,ldc_sconto_merce,ldc_sconto_riga,ldc_sconto_unit_riga, ll_id_sog_commerciale, ll_id_articolo)				
				destroy (u_cpt_sconti)
			end if
			ldc_peso_netto=idw_riga.getitemdecimal(ll_count, "riga_documento_peso_netto")
			if isnull(ldc_peso_netto) then ldc_peso_netto=0
			string ls_tipo
			select tipo
			into :ls_tipo
			from unita_confezione, unita_misura
			where (unita_confezione.id_unita_confezione=:ll_id_uc) and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
   			ll_nr_riga=idw_riga.GetItemNumber(ll_count, "riga_documento_num_riga")
			if (IsNull(ll_id_contropartita) OR ll_id_contropartita=0) then ls_report= ls_report + "  Nr." + String(ll_nr_riga)
			li_righe_valide++
			//20221123  aggiunto
			select dividi_importi into :ls_dividi_importi from dba.orafo_par_sistema;
			if ls_dividi_importi='S' then
				ldc_finocalo=ldc_peso_netto* idw_riga.GetItemDecimal(ll_count, "coef_calo")/1000
				ldc_tot_metallo= idw_riga.GetItemDecimal(ll_count, "prezzo_metallo")*ldc_finocalo * idc_cambio
			end if
			//20221123 fine
			if uf_calcola_prezzo(ls_sconto, 1000000, 1) = 0 then
				if ls_tipo = 'P' then
					ldc_omaggi_sc_merce= (ldc_peso_netto * ldc_prezzo_un * idc_cambio)  //da verificare 20220210
//					ldc_omaggi_sc_merce= (ldc_peso_netto * ldc_prezzo_un / idc_cambio)
				else
					ldc_omaggi_sc_merce= (ldc_quantita * ldc_prezzo_un * idc_cambio)	 //da verificare 20220210
	//				ldc_omaggi_sc_merce= (ldc_quantita * ldc_prezzo_un / idc_cambio)
				end if
	   			ldc_omaggi_sc_merce = f_round(ldc_omaggi_sc_merce,ll_cifra_arr, ls_tipo_arr) 
				ldc_val_omaggi= ldc_val_omaggi + ldc_omaggi_sc_merce				
				if ls_cpt_sconti = 'S' and (isnull(ll_id_cpt_sconti) = false and ll_id_cpt_sconti <> 0) then 
					uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_omaggi_sc_merce ,0, 0, 0)
					uf_ins_riga_cp(ll_id_cpt_sconti,"S", tab_1.tabpage_5.dw_contr_documento_lt, ldc_omaggi_sc_merce ,0, 0, 0)
				else 
					uf_ins_riga_cp(ll_id_contropartita, "C",tab_1.tabpage_5.dw_contr_documento_lt, 0,0, ldc_omaggi_sc_merce, 0)
				end if
			else
				if (ls_tipo='P' and ldc_peso_netto>0) or (ldc_quantita <> 0) then
					if ls_cpt_sconti = 'S' and (isnull(ll_id_cpt_sconti) = false and ll_id_cpt_sconti <> 0) then	
						if ls_tipo = 'P' then
							ldc_imponibile_non_sc=(ldc_peso_netto * ldc_prezzo_un * idc_cambio)   //da verificare 20220210
//								ldc_imponibile_non_sc=(ldc_peso_netto * ldc_prezzo_un / idc_cambio)
						else
							ldc_imponibile_non_sc=(ldc_quantita * ldc_prezzo_un * idc_cambio)   //da verificare 20220210
//							ldc_imponibile_non_sc=(ldc_quantita * ldc_prezzo_un / idc_cambio)
						end if
						ldc_imponibile_non_sc = f_round(ldc_imponibile_non_sc,ll_cifra_arr, ls_tipo_arr) 
						uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_imponibile_non_sc ,0, 0, 0)							
						ldc_imponibile=ldc_imponibile_non_sc - ldc_tot_riga							
						uf_ins_riga_cp(ll_id_cpt_sconti,"S", tab_1.tabpage_5.dw_contr_documento_lt, ldc_imponibile ,0, 0, 0)									
					else
						//20221123 inserisco divisione importi
						if ldc_tot_metallo>0 and ls_dividi_importi='S'  then
//							if  ls_tipo = 'P' then  //movimento a peso
//								ldc_tot_manifattura= round(idw_riga.GetItemDecimal(ll_count, "prezzo_manifattura")*ldc_peso_netto * idc_cambio, 2)
//							else
//								ldc_tot_manifattura= round(idw_riga.GetItemDecimal(ll_count, "prezzo_complessivo")*ldc_quantita * idc_cambio, 2)
//							end if
							//qui devo mettere la contropartita del metallo o della galvanica...la metto 20221128
							//DEVO ANCORA CONTROLLARE CHE NON LO FACCIA PER TUTTI MA SOLO PER SAMY E VERIFICARE SE FUNZIONA
							ll_id_galv= idw_riga.GetItemNumber(ll_count, "id_gruppo_agenti_2")
							if ll_id_galv>0 then //c'è galvanica
								select id_conto into :ll_id_conto from dba.galvanica where id_galvanica=:ll_id_galv;
								if isnull(ll_id_conto) or ll_id_conto=0 then ll_id_conto=1102
									//messagebox("Attenzione!", "Nella riga "+string(ll_count)+ " manca id_conto!!")
								ll_id_cpt_metallo=ll_id_conto
							else //c'è metallo non galvanica
								ll_id_cpt_metallo=1102
							end if
							uf_ins_riga_cp(ll_id_cpt_metallo,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_tot_metallo ,0, 0, 0)
							ldc_imponibile= ldc_tot_riga - ldc_tot_metallo
							uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_imponibile ,0, 0, 0)
							
						else
							ldc_imponibile= ldc_tot_riga //questa era originale non l'ho toccata (vedi commentato sotto)
							uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_imponibile ,0, 0, 0)//questa era originale non l'ho toccata
						end if
						//20221123 fine
//						ldc_imponibile= ldc_tot_riga
//						uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_imponibile ,0, 0, 0)
					end if
				else
					
					if ldc_sconto_merce <> 0 then
						ldc_omaggi_sc_merce= (ldc_sconto_merce * ldc_prezzo_un * idc_cambio)  //da verificare 20220210
//						ldc_omaggi_sc_merce= (ldc_sconto_merce * ldc_prezzo_un / idc_cambio) 
						ldc_omaggi_sc_merce = f_round(ldc_omaggi_sc_merce,ll_cifra_arr, ls_tipo_arr) 
						ldc_sconto_merce_iva= ldc_sconto_merce_iva +  ldc_omaggi_sc_merce
						uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, 0,0, ldc_sconto_merce_iva, 0) 
					end if
				end if
			end if
		end if
	next
	ldc_acconto = idw_gen.getitemdecimal(1, "imp_acconto")
	ll_id_iva_acconto=idw_gen.getitemnumber(1, "id_tab_iva_acconto")
	if ldc_acconto>0 and ll_id_iva_acconto>0 then
		ldc_acconto=idw_gen.getitemnumber(1, "c_imp_acconto_convertito")
		ldc_avanzo_cambio=idw_gen.getitemdecimal(1, "imp_avanzo_acconto")
		if isnull(ldc_avanzo_cambio) then ldc_avanzo_cambio=0
		if ldc_avanzo_cambio<>0 then
			select id_conto_avanzo_cambio
			into :ll_id_conto_avanzo_cambio
			from orafo_par_sistema
			;
			ll_id_conto_cliente=idw_gen.getitemnumber(1, "id_sog_commerciale")
			select id_conto
			into :ll_id_conto_cliente
			from sog_commerciale
			where id_sog_commerciale=:ll_id_conto_cliente;
			if sqlca.sqlcode=0 and ll_id_conto_avanzo_cambio>0 then
				li_righe_valide++
				if ldc_avanzo_cambio>0 then
					uf_ins_riga_cp(ll_id_conto_avanzo_cambio,"S", tab_1.tabpage_5.dw_contr_documento_lt, abs(ldc_avanzo_cambio) ,0, 0, 0)		
				else
					uf_ins_riga_cp(ll_id_conto_avanzo_cambio,"C", tab_1.tabpage_5.dw_contr_documento_lt, abs(ldc_avanzo_cambio) ,0, 0, 0)
				end if
			else
				messagebox("Attenzione!", "Non trovo la contropartita per avanzo cambio!")
			end if
		end if	
		select id_cont_gen_acconto
		into :ll_id_contropartita
		from par_sistema;
		if sqlca.sqlcode=0 then
			li_righe_valide++
			uf_ins_riga_cp(ll_id_contropartita,"S", tab_1.tabpage_5.dw_contr_documento_lt, ldc_acconto ,0, 0, 0)		
		else
			messagebox("Attenzione!", "Non trovo la contropartita per l'acconto (settala nei parametri di sistema)")
		end if
	end if
end if
If ls_report <> "" then
	If IsNull(il_id_conto_predefinito) OR il_id_conto_predefinito =0 then &
		iuo_msg_log.uf_new_text("Non è stato trovato il Conto Predefinito per le Contropartite: controllare nei Parametri di Sistema in quanto tale informazione è utile alla generazione del Castelletto delle Contropartite.",4)
		messagebox("Attenzione!", "Non è stato trovato il Conto Predefinito per le Contropartite: controllare nei Parametri di Sistema in quanto tale informazione è utile alla generazione del Castelletto delle Contropartite.")
	ls_report="Le seguenti righe non posseggono Contropartita  " + ls_report
end if
If li_righe_valide = 0 then ls_report="Non esistono righe di documento valide."
RETURN ls_report











//
//long 			ll_nr_row, ll_count, ll_id_contropartita, ll_new_row,ll_row_found, ll_id_tab_iva_max, ll_tot_row
//long			ll_id_articolo, ll_id_tab_iva, ll_nr_riga, ll_id_iva_acconto, ll_id_uc,ll_id_galv,ll_id_conto
//decimal 		ldc_imponibile, ldc_tot_riga,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
//decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_omaggi_sc_merce
//decimal 		ldc_val_omaggi, ldc_sconto_merce_art_15, ldc_sconto_merce_iva, ldc_tot_omaggi_sc_merce, ldc_imponibile_non_sc, ldc_tot_manifattura
//string 		ls_codice, ls_descr_breve, ls_sconto, ls_report, ls_riga_valida, ls_dividi_importi
//decimal 		ldc_sconto_merce, ldc_acconto, ldc_peso_netto
//integer		li_ret_value, li_righe_valide 
//
//long ll_id_conto_avanzo_cambio, ll_id_conto_cliente
//decimal ldc_avanzo_cambio,ldc_tot_metallo
//string ls_cpt_sconti
//long ll_id_cpt_sconti, ll_id_sog_commerciale, ll_gen_row,ll_id_cpt_metallo,ll_id_cpt_man
//decimal ldc_sc_fin_cassa, ldc_sc_incondizionato, ldc_sconto_riga, ldc_sconto_unit_riga,ldc_finocalo
//string ls_sc_finanziario, ls_tipo,ls_ret
//
//select gest_cpt_sconti
//into :ls_cpt_sconti
//from par_sistema;
//
//ll_gen_row= il_row
//
//ll_id_sog_commerciale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,'id_sog_commerciale')
//ls_sc_finanziario= idw_gen.GetItemString(ll_gen_row, "documento_sconto_finanziario")
//ldc_sc_incondizionato= idw_gen.uf_GetItemDecimal(ll_gen_row, "sconto_fin_incondizionato")
//ldc_sc_fin_cassa= idw_gen.uf_GetItemDecimal(ll_gen_row, "documento_sconto_fin_cassa")
//
//long ll_cifra_arr
//string ls_tipo_arr
//
//select cifra_arrotondamento, tipo_arrotondamento
//into   :ll_cifra_arr, :ls_tipo_arr
//from   valuta
//where  id_valuta = :al_id_val_az;
//
//li_righe_valide= 0
//ls_report=""
//if not (IsNull(il_id_documento) OR il_id_documento=0) then
//	li_ret_value=0
//	ldc_val_omaggi=0
//	ldc_sconto_merce_art_15= 0
//	ldc_sconto_merce_iva=0
//	ll_nr_row= idw_riga.RowCount()
//	if ll_nr_row =0 then li_ret_value= -1
//	for ll_count = 1 to ll_nr_row
//		ldc_omaggi_sc_merce=0
//		ldc_tot_riga = idw_riga.GetItemDecimal(ll_count, "tot_riga_val_az")
//		if IsNull(ldc_tot_riga)  then ldc_tot_riga = 0
//		ldc_prezzo_un = idw_riga.uf_GetItemDecimal(ll_count, "prezzo")
//		if IsNull(ldc_prezzo_un)  then ldc_prezzo_un = 0
//		ldc_sconto_merce= idw_riga.uf_GetItemDecimal(ll_count, "qta_sconto_merce")
//		if IsNull(ldc_sconto_merce)  then ldc_sconto_merce = 0
//		ls_sconto = idw_riga.GetItemString(ll_count, "sconto")
//		if IsNull(ls_sconto)  then ls_sconto = ""
//		ldc_quantita = idw_riga.uf_GetItemDecimal(ll_count, "quantita")
//		if IsNull(ldc_quantita)  then ldc_quantita = 0
//		ll_id_tab_iva= idw_riga.GetItemDecimal(ll_count, "riga_documento_id_tab_iva")
//		ll_id_contropartita = idw_riga.GetItemNumber(ll_count, "riga_documento_id_conto")
//		If IsNull(ll_id_contropartita) OR ll_id_contropartita=0 then ll_id_contropartita= il_id_conto_predefinito
//		ll_id_articolo= idw_riga.GetItemNumber(ll_count, "riga_documento_id_articolo")
//		ll_id_uc= idw_riga.GetItemNumber(ll_count, "riga_documento_id_unita_confezione")
//		ls_riga_valida= idw_riga.GetItemString(ll_count, "c_riga_valida")
//		If ls_riga_valida= "V" then
//			ldc_sconto_riga = idw_riga.GetItemnumber(ll_count, "riga_documento_sconto_riga")
//			ldc_sconto_unit_riga = 0
//			if ls_cpt_sconti = 'S' then
//				uo_cpt_sconti u_cpt_sconti
//				u_cpt_sconti = create uo_cpt_sconti
//	   			ll_id_cpt_sconti = u_cpt_sconti.uf_cpt_sconti("",0,0,ls_sconto,ldc_sconto_merce,ldc_sconto_riga,ldc_sconto_unit_riga, ll_id_sog_commerciale, ll_id_articolo)				
//	         	destroy (u_cpt_sconti)
//			end if
//			ldc_peso_netto=idw_riga.getitemdecimal(ll_count, "riga_documento_peso_netto")
//			if isnull(ldc_peso_netto) then ldc_peso_netto=0
//		
//			select tipo
//			into :ls_tipo
//			from unita_confezione, unita_misura
//			where (unita_confezione.id_unita_confezione=:ll_id_uc) and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
//		
// 			ll_nr_riga=idw_riga.GetItemNumber(ll_count, "riga_documento_num_riga")
//			if (IsNull(ll_id_contropartita) OR ll_id_contropartita=0) then ls_report= ls_report + "  Nr." + String(ll_nr_riga)
//			li_righe_valide++
//			//20221123  aggiunto
//			select dividi_importi into :ls_dividi_importi from dba.orafo_par_sistema;
//			if ls_dividi_importi='S' then
//				ldc_finocalo=ldc_peso_netto* idw_riga.GetItemDecimal(ll_count, "coef_calo")/1000
//				ldc_tot_metallo= idw_riga.GetItemDecimal(ll_count, "prezzo_metallo")*ldc_finocalo * idc_cambio
//			end if
//			//20221123 fine
//			if uf_calcola_prezzo(ls_sconto, 1000000, 1) = 0 then
//				if ls_tipo = 'P' then
//					ldc_omaggi_sc_merce= (ldc_peso_netto * ldc_prezzo_un * idc_cambio)  //da verificare 20220210
////					ldc_omaggi_sc_merce= (ldc_peso_netto * ldc_prezzo_un / idc_cambio)
//				else
//					ldc_omaggi_sc_merce= (ldc_quantita * ldc_prezzo_un * idc_cambio)	 //da verificare 20220210
//	//				ldc_omaggi_sc_merce= (ldc_quantita * ldc_prezzo_un / idc_cambio)
//				end if
//				ldc_omaggi_sc_merce = f_round(ldc_omaggi_sc_merce,ll_cifra_arr, ls_tipo_arr) 
//				ldc_val_omaggi= ldc_val_omaggi + ldc_omaggi_sc_merce				
//				if ls_cpt_sconti = 'S' and (isnull(ll_id_cpt_sconti) = false and ll_id_cpt_sconti <> 0) then 
//					uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_omaggi_sc_merce ,0, 0, 0)
//					uf_ins_riga_cp(ll_id_cpt_sconti,"S", tab_1.tabpage_5.dw_contr_documento_lt, ldc_omaggi_sc_merce ,0, 0, 0)
//				else 
//					uf_ins_riga_cp(ll_id_contropartita, "C",tab_1.tabpage_5.dw_contr_documento_lt, 0,0, ldc_omaggi_sc_merce, 0)
//				end if
//			else
//				
//				if (ls_tipo='P' and ldc_peso_netto>0) or (ldc_quantita <> 0) then
//					if ls_cpt_sconti = 'S' and (isnull(ll_id_cpt_sconti) = false and ll_id_cpt_sconti <> 0) then	
//							if ls_tipo = 'P' then  //movimento a peso
//								if ldc_tot_metallo>0 then
//									ldc_tot_manifattura= idw_riga.GetItemDecimal(ll_count, "prezzo_manifattura")*ldc_peso_netto * idc_cambio
//									if ls_dividi_importi='S' then
//									//qui devo mettere la contropartita del metallo o della galvanica...
//										ll_id_cpt_metallo=1102
//									END IF
//									uf_ins_riga_cp(ll_id_cpt_metallo,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_tot_metallo ,0, 0, 0)	
//									ldc_imponibile_non_sc=ldc_tot_manifattura
//								else
//									ldc_imponibile_non_sc=(ldc_peso_netto * ldc_prezzo_un * idc_cambio)   //da verificare 20220210
//								 	//ldc_imponibile_non_sc=(ldc_peso_netto * ldc_prezzo_un / idc_cambio)
//								end if
//							else  //movimento a pezzo
//								ldc_tot_manifattura= idw_riga.GetItemDecimal(ll_count, "prezzo_manifattura")*ldc_quantita * idc_cambio
//								if ldc_tot_metallo>0 then
//									ldc_tot_manifattura= idw_riga.GetItemDecimal(ll_count, "prezzo_complessivo")*ldc_quantita * idc_cambio
//									ll_id_cpt_metallo=1102
//									uf_ins_riga_cp(ll_id_cpt_metallo,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_tot_metallo ,0, 0, 0)	
//									ldc_imponibile_non_sc=ldc_tot_manifattura
//								else
//									ldc_imponibile_non_sc=(ldc_quantita * ldc_prezzo_un * idc_cambio)   //da verificare 20220210
//		//							ldc_imponibile_non_sc=(ldc_quantita * ldc_prezzo_un / idc_cambio)
//								end if
//							end if
//							
//							ldc_imponibile_non_sc = f_round(ldc_imponibile_non_sc,ll_cifra_arr, ls_tipo_arr) 
//							uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_imponibile_non_sc ,0, 0, 0)							
//							ldc_imponibile=ldc_imponibile_non_sc - ldc_tot_riga							
//							uf_ins_riga_cp(ll_id_cpt_sconti,"S", tab_1.tabpage_5.dw_contr_documento_lt, ldc_imponibile ,0, 0, 0)									
//					else	
//						if ldc_tot_metallo>0 then
//							if  ls_tipo = 'P' then  //movimento a peso
//								ldc_tot_manifattura= round(idw_riga.GetItemDecimal(ll_count, "prezzo_manifattura")*ldc_peso_netto * idc_cambio, 2)
//							else
//								ldc_tot_manifattura= round(idw_riga.GetItemDecimal(ll_count, "prezzo_complessivo")*ldc_quantita * idc_cambio, 2)
//							end if
//							//qui devo mettere la contropartita del metallo o della galvanica...la metto 20221128
//							//DEVO ANCORA CONTROLLARE CHE NON LO FACCIA PER TUTTI MA SOLO PER SAMY E VERIFICARE SE FUNZIONA
//							ll_id_galv= idw_riga.GetItemNumber(ll_count, "id_gruppo_agenti_2")
//							if ll_id_galv>0 then
//								select id_conto into :ll_id_conto from dba.galvanica where id_galvanica=:ll_id_galv;
//								if isnull(ll_id_conto) or ll_id_conto=0 then 
//									ll_id_conto=1102
//									//messagebox("Attenzione!", "Nella riga "+string(ll_count)+ " manca id_conto!!")
//								else
//									ll_id_cpt_metallo=ll_id_conto
//								end if
//							else //c'è metallo non galvanica
//							 	ll_id_cpt_metallo=1102
//							end if
//							uf_ins_riga_cp(ll_id_cpt_metallo,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_tot_metallo ,0, 0, 0)
//							uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_tot_manifattura ,0, 0, 0)
//							ldc_imponibile= ldc_tot_riga
//						else
//							ldc_imponibile= ldc_tot_riga
//							uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, ldc_imponibile ,0, 0, 0)
//						end if
//					end if
//				else
//						if ldc_sconto_merce <> 0 then
//							ldc_omaggi_sc_merce= (ldc_sconto_merce * ldc_prezzo_un * idc_cambio)  //da verificare 20220210
////							ldc_omaggi_sc_merce= (ldc_sconto_merce * ldc_prezzo_un / idc_cambio) 
//							ldc_omaggi_sc_merce = f_round(ldc_omaggi_sc_merce,ll_cifra_arr, ls_tipo_arr) 
//							ldc_sconto_merce_iva= ldc_sconto_merce_iva +  ldc_omaggi_sc_merce
//							uf_ins_riga_cp(ll_id_contropartita,"C", tab_1.tabpage_5.dw_contr_documento_lt, 0,0, ldc_sconto_merce_iva, 0) 
//						end if
//				end if
//			end if
//		end if
//	next
//	ldc_acconto = idw_gen.getitemdecimal(1, "imp_acconto")
//	ll_id_iva_acconto=idw_gen.getitemnumber(1, "id_tab_iva_acconto")
//	if ldc_acconto>0 and ll_id_iva_acconto>0 then
//		ldc_acconto=idw_gen.getitemnumber(1, "c_imp_acconto_convertito")
//		ldc_avanzo_cambio=idw_gen.getitemdecimal(1, "imp_avanzo_acconto")
//		if isnull(ldc_avanzo_cambio) then ldc_avanzo_cambio=0
//		if ldc_avanzo_cambio<>0 then
//			select id_conto_avanzo_cambio
//			into :ll_id_conto_avanzo_cambio
//			from orafo_par_sistema
//			;
//			ll_id_conto_cliente=idw_gen.getitemnumber(1, "id_sog_commerciale")
//			select id_conto
//			into :ll_id_conto_cliente
//			from sog_commerciale
//			where id_sog_commerciale=:ll_id_conto_cliente;
//			if sqlca.sqlcode=0 and ll_id_conto_avanzo_cambio>0 then
//				li_righe_valide++
//				if ldc_avanzo_cambio>0 then
//					uf_ins_riga_cp(ll_id_conto_avanzo_cambio,"S", tab_1.tabpage_5.dw_contr_documento_lt, abs(ldc_avanzo_cambio) ,0, 0, 0)		
//				else
//					uf_ins_riga_cp(ll_id_conto_avanzo_cambio,"C", tab_1.tabpage_5.dw_contr_documento_lt, abs(ldc_avanzo_cambio) ,0, 0, 0)
//				end if
//			else
//				messagebox("Attenzione!", "Non trovo la contropartita per avanzo cambio!")
//			end if
//		end if	
//		select id_cont_gen_acconto
//		into :ll_id_contropartita
//		from par_sistema;
//		if sqlca.sqlcode=0 then
//			li_righe_valide++
//			uf_ins_riga_cp(ll_id_contropartita,"S", tab_1.tabpage_5.dw_contr_documento_lt, ldc_acconto ,0, 0, 0)		
//		else
//			messagebox("Attenzione!", "Non trovo la contropartita per l'acconto (settala nei parametri di sistema)")
//		end if
//	end if
//end if
//If ls_report <> "" then
//	If IsNull(il_id_conto_predefinito) OR il_id_conto_predefinito =0 then &
//		iuo_msg_log.uf_new_text("Non è stato trovato il Conto Predefinito per le Contropartite: controllare nei Parametri di Sistema in quanto tale informazione è utile alla generazione del Castelletto delle Contropartite.",4)
//		messagebox("Attenzione!", "Non è stato trovato il Conto Predefinito per le Contropartite: controllare nei Parametri di Sistema in quanto tale informazione è utile alla generazione del Castelletto delle Contropartite.")
//	ls_report="Le seguenti righe non posseggono Contropartita  " + ls_report
//end if
//If li_righe_valide = 0 then ls_report="Non esistono righe di documento valide."
//RETURN ls_report
//
end event

event ue_calc_sp_iva_cast;

long 			ll_nr_row, ll_count, ll_id_spesa,ll_id_sog_comm
long 			ll_cast_count,  ll_nr_rate, ll_id_conto
decimal 		ldc_imponibile, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_quantita, ldc_prezzo_un, ldc_tot_imponibile, ldc_proporz
string 		ls_codice, ls_descrizione, ls_sconto, ls_mod_calc_iva

ll_nr_row= idw_spesa.RowCount()
for ll_count = 1 to ll_nr_row
	ll_id_spesa= idw_spesa.GetItemNumber(ll_count, "id_spesa_cod")
	ll_id_conto= uf_conto_x_spesa(ll_id_spesa)
	If not(IsNull(ll_id_conto) OR ll_id_conto =0) then 
		ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "c_importo_lire")
		uf_ins_riga_cp(ll_id_conto,"C", tab_1.tabpage_5.dw_contr_documento_lt, 0 , 0, 0, ldc_importo)
	end if
next

end event

event ue_calc_sconti_cast;

long 			ll_nr_row, ll_count, ll_gen_row, ll_cast_count, ll_cast_row_nr
decimal 		ldc_sc_fin_cassa, ldc_sc_incondizionato, ldc_imponibile, ldc_sconto, ldc_imp_complemento
decimal 		ldc_perc_incondizionato, ldc_imponibile2, ldc_imponibile1
string 		ls_sc_finanziario
boolean lb_ok

long			ll_id_cont_gen_acconto, ll_cast_count_app

SELECT id_cont_gen_acconto
INTO	 :ll_id_cont_gen_acconto	
FROM	 par_sistema
;

if isnull(ll_id_cont_gen_acconto	) then ll_id_cont_gen_acconto	 = 0

string ls_cpt_sconti, ls_tipo_cpt
long ll_id_cpt_sconti, ll_id_sog_commerciale
decimal  ldc_sconto_riga, ldc_sconto_unit_riga

select gest_cpt_sconti
into :ls_cpt_sconti
from par_sistema;

long ll_cifra_arr
string ls_tipo_arr

select cifra_arrotondamento, tipo_arrotondamento
into   :ll_cifra_arr, :ls_tipo_arr
from   valuta
where  id_valuta = :al_id_val_az;

ll_gen_row= il_row
ls_sc_finanziario= idw_gen.GetItemString(ll_gen_row, "documento_sconto_finanziario")
ldc_sc_incondizionato= idw_gen.uf_GetItemDecimal(ll_gen_row, "sconto_fin_incondizionato")
ldc_sc_fin_cassa= idw_gen.uf_GetItemDecimal(ll_gen_row, "documento_sconto_fin_cassa")

ll_cast_row_nr= RowCount()
for ll_cast_count = 1 to ll_cast_row_nr
	SetItem(ll_cast_count, "c_prop_imp", Round(GetItemNumber(ll_cast_count, "c_proporzionale"), 2))
next

If not (IsNull(ls_sc_finanziario) OR ls_sc_finanziario = "" OR ls_sc_finanziario = "0") then
	
	
	if ls_cpt_sconti = 'S' then
		wf_calc_cpt_sco_tot(ls_cpt_sconti, tab_1.tabpage_5.dw_contr_documento_lt, ls_sc_finanziario, ldc_sc_incondizionato, ldc_sc_fin_cassa)		
	else
		for ll_cast_count = 1 to ll_cast_row_nr
			ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imponibile")
			if (this.getitemnumber(ll_cast_count, "id_conto") <> ll_id_cont_gen_acconto) then			
				ldc_imponibile= uf_calcola_prezzo(ls_sc_finanziario, ldc_imponibile, 0)
				ldc_imponibile= f_round(ldc_imponibile,ll_cifra_arr, ls_tipo_arr) 
			end if
			
			SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
		next				
	end if
	

else
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imponibile")
		SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
	next
end if
ldc_imp_complemento=0
If not (IsNull(ldc_sc_incondizionato) OR ldc_sc_incondizionato = 0) then
	if ll_cast_row_nr > 0 then
		for ll_cast_count = 1 to ll_cast_row_nr - 1
			ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imp_scontato")
			
			ldc_perc_incondizionato= f_Round((ldc_sc_incondizionato * uf_GetItemDecimal(ll_cast_count, "c_proporzionale")),ll_cifra_arr,ls_tipo_arr) 
			ldc_imponibile= ldc_imponibile - ldc_perc_incondizionato
			ldc_imp_complemento= ldc_imp_complemento + ldc_perc_incondizionato
			SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
		next
		ldc_imponibile= uf_GetItemDecimal(ll_cast_row_nr, "val_imp_scontato")
		ldc_imponibile= ldc_imponibile - ldc_sc_incondizionato + ldc_imp_complemento
		SetItem(ll_cast_row_nr, "val_imp_scontato", ldc_imponibile)
	end if
end if
If not (IsNull(ldc_sc_fin_cassa) OR ldc_sc_fin_cassa = 0) then
	for ll_cast_count = 1 to ll_cast_row_nr
		if (this.getitemnumber(ll_cast_count, "id_conto") <> ll_id_cont_gen_acconto) then	
			ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "val_imp_scontato")
			ldc_imponibile= ldc_imponibile - (ldc_imponibile * ldc_sc_fin_cassa / 100)				
			ldc_imponibile = f_round(ldc_imponibile,ll_cifra_arr, ls_tipo_arr) 
			SetItem(ll_cast_count, "val_imp_scontato", ldc_imponibile)
		end if
	next
end if



end event

event ue_calc_contropartita;
long 		ll_nr_row, ll_count, ll_gen_row, ll_bollo_row, ll_row, ll_row_found, ll_id_azienda

decimal 	ldc_bollo
string	ls_ret_value
boolean	lb_ok

long ll_conto, ll_sogg
ll_sogg=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,'id_sog_commerciale')
select id_conto
into :ll_conto
from sog_commerciale
where id_sog_commerciale=:ll_sogg;
if isnull(ll_conto) then
	if tab_1.tabpage_1.dw_documento_ordine_ff.getitemstring(1,'documento_contabilizzato')='S' then
		messagebox('Attenzione',"L'intestatario selezionato non può essere utilizzato per la contabilizzazione~r~n"&
		+'di un documento perchè privo di conto, occore cambiare il profilo documento ~r~n'&
		+'o selezionare un intestatario diverso.',Information!)
		lb_ok=FALSE
		return lb_ok
	end if	
end if

lb_ok=TRUE
ll_id_azienda= idw_gen.GetItemNumber(il_row, "id_prof_documento")


iuo_msg_log.uf_new_text("Generazione delle Contropartite.",3)
if Not (IsNull(il_id_spesa_bollo) OR il_id_spesa_bollo = 0) then
	ll_gen_row=il_row
if not (idw_riga.rowcount()>0) then ib_genera_castelletto=false
   
	long ll_id_sc
	string ls_tipo
	
	ll_id_sc = tab_1.tabpage_1.dw_documento_ordine_ff.object.id_sog_commerciale[1]
	
	SELECT tipo
	INTO	 :ls_tipo
	FROM	 sog_commerciale
	WHERE  id_sog_commerciale = :ll_id_sc
	;
	
	If ((RowCount() = 0 OR ib_genera_castelletto) AND ls_tipo <> 'P') then
   
		TriggerEvent("ue_clear_contropartita")
		ls_ret_value=event ue_calc_righe_cast()
		If ls_ret_value = "" then
			
			TriggerEvent("ue_calc_sconti_cast")
			TriggerEvent("ue_calc_sp_iva_cast")
			TriggerEvent("ue_calc_non_da_conto")			
			TriggerEvent("ue_quadra_cpt")			
			TriggerEvent("ue_ripul_cpt")
		else
			
			lb_ok=FALSE
			event ue_no_cpt()
			iuo_msg_log.uf_new_text(ls_ret_value,4)
		end if
	end if
	ll_row= RowCount()
	SetSort("tipo_riga_cpt A")
	Sort()
else
	lb_ok=FALSE
	event ue_no_cpt()
end if
If RowCount()=0 then lb_ok=FALSE
RETURN lb_ok
end event

event ue_calc_non_da_conto;
long 		ll_id_intestatario, ll_id_conto, ll_id_azienda, ll_id_conto_iva_nd, ll_gen_row
long		ll_cast_row, ll_id_registro
decimal	ldc_omaggi, ldc_imp_scontato, ldc_tot_detraibile, ldc_tot_non_detraibile, ldc_acconto
string	ls_tipo_registro
boolean	lb_conto_mancante

lb_conto_mancante= FALSE
ll_id_intestatario= idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
SELECT "sog_commerciale"."id_conto"  
	INTO :ll_id_conto  
	FROM "dba"."sog_commerciale"
	WHERE ( "sog_commerciale"."id_azienda" = 1 ) AND  
			( "sog_commerciale"."id_sog_commerciale" = :ll_id_intestatario )   ;
If SQLCA.SQLCode =0 AND not IsNull(ll_id_conto) then
	ll_gen_row= idw_gen_tot_ext.GetRow()
	If IsNull(ll_gen_row) OR ll_gen_row =0 then ll_gen_row= idw_gen_tot_ext.RowCount()
	If not(IsNull(ll_gen_row) OR ll_gen_row =0) then
		ldc_omaggi= idw_gen_tot_ext.GetItemNumber(ll_gen_row, "tot_omaggi_sc_merce_lire")
		ldc_imp_scontato= idw_gen_tot_ext.GetItemNumber(ll_gen_row, "tot_documento_lire")
		
		uf_ins_riga_cp( ll_id_conto, "S", tab_1.tabpage_5.dw_contr_documento_lt, 0, ldc_imp_scontato, ldc_omaggi, 0)
	end if
else
	If IsNull(ll_id_conto) OR ll_id_conto=0 then 
		iuo_msg_log.uf_new_text("Non è stato trovato il Conto relativo all'Intestatario: controllare in quanto tale informazione è utile alla generazione del Castelletto delle Contropartite.",4)
		lb_conto_mancante=TRUE
		messagebox("Attenzione!", "Non è stato trovato il Conto relativo all'Intestatario: controllare in quanto tale informazione è utile alla generazione del Castelletto delle Contropartite.")
	end if
end if
ll_id_registro=idw_gen.GetItemNumber(il_row, "id_registro")
SELECT "registro"."tipo_registro"  
	INTO :ls_tipo_registro  
	FROM "dba"."registro"  
	WHERE ( "registro"."id_registro" = :ll_id_registro ) AND  
		( "registro"."id_azienda" = 1 )   ;
ll_id_azienda= idw_gen.GetItemNumber(il_row, "documento_id_azienda")
CHOOSE CASE ls_tipo_registro
	CASE "IA", "PA", "OA", "DA", "LA", "GA"
		SELECT "par_sistema"."id_conto_iva_ia",   
			"par_sistema"."id_conto_iva_nd"  
		INTO :ll_id_conto,   
			:ll_id_conto_iva_nd
		FROM "dba"."par_sistema"  
		WHERE "par_sistema"."id_azienda" = :ll_id_azienda ;

	CASE "IV", "PV", "OV", "DV", "LV", "GV", "IC"
		SELECT "par_sistema"."id_conto_iva_iv",   
			"par_sistema"."id_conto_iva_nd"  
		INTO :ll_id_conto,   
			:ll_id_conto_iva_nd
		FROM "dba"."par_sistema"  
		WHERE "par_sistema"."id_azienda" = :ll_id_azienda   ;
END CHOOSE
If SQLCA.SQLCode = 0 then
	ll_cast_row= idw_castelletto.RowCount()
	If ll_cast_row > 0 then
		ldc_tot_detraibile= idw_castelletto.GetItemNumber(ll_cast_row,"c_tot_detraibile")
		uf_ins_riga_cp(ll_id_conto,"I", tab_1.tabpage_5.dw_contr_documento_lt, 0 , ldc_tot_detraibile, 0, 0)
		ldc_tot_non_detraibile= idw_castelletto.GetItemNumber(ll_cast_row,"c_tot_non_detraibile")
		uf_ins_riga_cp(ll_id_conto_iva_nd,"N", tab_1.tabpage_5.dw_contr_documento_lt, 0 , ldc_tot_non_detraibile, 0, 0)
	end if
end if

If IsNull(ll_id_conto) OR ll_id_conto=0 then 
	iuo_msg_log.uf_new_text("Non è stato trovato il Conto Acquisti/Vendite: controllare nei Parametri di Sistema in quanto tale informazione è utile alla generazione del Castelletto delle Contropartite.",4)
	lb_conto_mancante=TRUE
	messagebox("Attenzione!", "Non è stato trovato il Conto Acquisti/Vendite: controllare nei Parametri di Sistema in quanto tale informazione è utile alla generazione del Castelletto delle Contropartite.")
end if


If lb_conto_mancante then 
	event ue_no_cpt()
end if

end event

event ue_clear_contropartita;call super::ue_clear_contropartita;
long 		ll_nr_row, ll_count, ll_row

ll_nr_row= RowCount()
for ll_count =  1 to ll_nr_row 
	DeleteRow(ll_nr_row - ll_count + 1)
next	






end event

event ue_wizard;call super::ue_wizard;
long					ll_cpt_row, ll_id_conto, ll_nr_row, ll_row, ll_found, ll_id_spesa, ll_match_conto
string				ls_codice, ls_descrizione, ls_tipo_cpt, ls_riga_valida
s_contropartita	lstr_contropartita
boolean				lb_found

ll_cpt_row= GetRow()
If not(IsNull(ll_cpt_row) OR ll_cpt_row = 0) then
	ls_tipo_cpt=GetItemString(ll_cpt_row, "tipo_riga_cpt")
	
	If ls_tipo_cpt="C" then
		ll_found=0
		ll_id_conto= GetItemNumber(ll_cpt_row,"id_conto")
		ls_codice= GetItemString(ll_cpt_row,"conto_azienda_codice")
		ls_descrizione= GetItemString(ll_cpt_row,"conto_azienda_descrizione")
		lstr_contropartita.s_codice= ls_codice
		lstr_contropartita.s_descrizione= ls_descrizione
		
		If il_id_conto_predefinito= ll_id_conto then 
			lstr_contropartita.b_predefinito= TRUE
		else
			lstr_contropartita.b_predefinito= FALSE
		end if
		lstr_contropartita.l_id_conto= ll_id_conto
		
		ll_nr_row= idw_riga.RowCount()
		FOR ll_row= 1 to ll_nr_row
	
			ll_match_conto=idw_riga.GetItemNumber(ll_row,"riga_documento_id_conto")
			
			ls_riga_valida= idw_riga.GetItemString(ll_row, "c_riga_valida")
			If ls_riga_valida = "V" then
				If lstr_contropartita.b_predefinito then 
					If IsNull(ll_match_conto) OR ll_match_conto = ll_id_conto then  
						lb_found= TRUE
					else
						lb_found= FALSE
					end if
				else
					If ll_match_conto = ll_id_conto then
						lb_found= TRUE
					else
						lb_found= FALSE
					end if	
				end if
			else
				
				lb_found= FALSE
			end if
			If lb_found then
				ls_codice= idw_riga.GetItemString(ll_row,"c_articolo_cod")
				ls_descrizione= idw_riga.GetItemString(ll_row,"c_articolo_des")
				ll_found++
				lstr_contropartita.str_riga[ll_found].s_rigadoc_spesa= "R"
				lstr_contropartita.str_riga[ll_found].l_nr_riga= ll_row
				lstr_contropartita.str_riga[ll_found].s_codice= ls_codice
				lstr_contropartita.str_riga[ll_found].s_descrizione= ls_descrizione
				
				lstr_contropartita.str_riga[ll_found].l_id_conto= ll_id_conto
			end if
		NEXT
		
		ll_nr_row= idw_spesa.RowCount()
		FOR ll_row= 1 to ll_nr_row
			ll_id_spesa= idw_spesa.GetItemNumber(ll_row,"id_spesa_cod")
	
			ll_match_conto= uf_conto_x_spesa(ll_id_spesa)
			If lstr_contropartita.b_predefinito then 
				If IsNull(ll_match_conto) then  
					lb_found= TRUE
				else
					lb_found= FALSE
				end if
			else
				If ll_match_conto = ll_id_conto then
					lb_found= TRUE
				else
					lb_found= FALSE
				end if	
			end if	
			If lb_found then
			  SELECT "spesa"."codice",   
					"spesa"."descrizione"  
				INTO :ls_codice,   
						:ls_descrizione  
				FROM "dba"."spesa"  
				WHERE "spesa"."id_spesa" = :ll_id_spesa ;
				If SQLCA.SQLCode=0 then
					ll_found++
					lstr_contropartita.str_riga[ll_found].s_rigadoc_spesa= "S"
					lstr_contropartita.str_riga[ll_found].l_nr_riga= ll_row
					lstr_contropartita.str_riga[ll_found].s_codice= ls_codice
					lstr_contropartita.str_riga[ll_found].s_descrizione= ls_descrizione
					
					lstr_contropartita.str_riga[ll_found].l_id_conto= ll_id_conto
				end if
			end if
		NEXT
		If UpperBound(lstr_contropartita.str_riga) > 0 then
			
			OpenWithParm(w_contropartita_wz, lstr_contropartita)
			lstr_contropartita= Message.PowerObjectParm
			
			if not IsNull(lstr_contropartita.l_id_conto) then
				ll_nr_row=UpperBound(lstr_contropartita.str_riga)
				FOR ll_row= 1 to ll_nr_row
					If lstr_contropartita.str_riga[ll_row].s_rigadoc_spesa= "R" then
						
						ll_id_conto	=lstr_contropartita.str_riga[ll_row].l_id_conto
						idw_riga.SetItem(lstr_contropartita.str_riga[ll_row].l_nr_riga, "riga_documento_id_conto",ll_id_conto)
		
		
		
		
					end if
				NEXT
				ib_genera_castelletto= TRUE
				Post TriggerEvent("ue_calc_contropartita")
			end if
		else
			
		end if
	end if
end if
end event

event ue_no_cpt;call super::ue_no_cpt;
post event ue_clear_contropartita()
iuo_msg_log.uf_new_text("Non sono state generate Contropartite.",4)
end event

event ue_ripul_cpt;call super::ue_ripul_cpt;
long 		ll_nr_row, ll_count, ll_row
decimal 	ldc_valore

ll_nr_row= RowCount()
for ll_count =  1 to ll_nr_row 
	ll_row=ll_nr_row - ll_count + 1
	ldc_valore=GetItemNumber(ll_row, "c_valore")
	If (IsNull(ldc_valore) Or ldc_valore=0) then
		DeleteRow(ll_row)
	end if
next


end event

event ue_quadra_cpt;
long 		ll_nr_row, ll_row, ll_row_c
string	ls_tipo
decimal	ldc_valore_c, ldc_valore_imp_sc ,ldc_valore_spese , ldc_valore_s, ldc_differenza, ldc_parziale
decimal	ldc_conguaglio, ldc_valore_in, ldc_acconto
boolean	lb_prima

ldc_valore_c = 0
ll_row_c=0
ll_nr_row= RowCount()
If ll_nr_row> 0 then
	FOR ll_row = 1 to ll_nr_row
		ls_tipo= GetItemString(ll_row,"tipo_riga_cpt")
		CHOOSE CASE ls_tipo 
			CASE "C" 
				ll_row_c++
				ldc_valore_imp_sc=uf_GetItemDecimal(ll_row,"val_imp_scontato")
				If IsNull(ldc_valore_imp_sc) then ldc_valore_imp_sc = 0
				ldc_valore_spese=uf_GetItemDecimal(ll_row,"val_spese")
				If IsNull(ldc_valore_spese) then ldc_valore_spese = 0
				ldc_valore_c= ldc_valore_c + ldc_valore_imp_sc +ldc_valore_spese
			CASE "I" ,"N" 
				ldc_valore_imp_sc=uf_GetItemDecimal(ll_row,"val_imp_scontato")
				If IsNull(ldc_valore_imp_sc) then ldc_valore_imp_sc = 0
				ldc_valore_in= ldc_valore_in + ldc_valore_imp_sc
			CASE "S" 
				if isnull(ldc_valore_s) then ldc_valore_s=0
				ldc_valore_s= ldc_valore_s+uf_GetItemDecimal(ll_row,"val_imp_scontato")
		END CHOOSE
	NEXT
	ldc_differenza= ldc_valore_s - (ldc_valore_c + ldc_valore_in) 
	If ldc_differenza <> 0 and ll_row_c>0  then 
		ldc_parziale= Round(ldc_differenza/ll_row_c, 0)
		ldc_conguaglio= ldc_parziale + (ldc_differenza - (ldc_parziale * ll_row_c))
		lb_prima= TRUE
		FOR ll_row = 1 to ll_nr_row - 1
			ls_tipo= GetItemString(ll_row,"tipo_riga_cpt")
			If ls_tipo = "C" then
				ldc_valore_imp_sc= uf_GetItemDecimal(ll_row,"val_imp_scontato")
				If lb_prima then
					lb_prima= FALSE
					SetItem(ll_row,"val_imp_scontato", ldc_valore_imp_sc + ldc_conguaglio)
				else
					SetItem(ll_row,"val_imp_scontato", ldc_valore_imp_sc + ldc_parziale)
				end if
			end if
				
		NEXT
	end if
end if
	
	
end event

event constructor;call super::constructor;
this.Object.c_proporzionale.width = 0


end event

event getfocus;call super::getfocus;
iw_corrente.cb_inserisci.Enabled = FALSE
iw_corrente.cb_cancella.Enabled = FALSE

end event

event losefocus;call super::losefocus;

iw_corrente.cb_inserisci.Enabled = TRUE
iw_corrente.cb_cancella.Enabled = TRUE

end event

event ue_init;call super::ue_init;is_title = "Castelletto ControPartite"
is_list.s_identifica[1] = "id_documento"
end event

event ue_update;call super::ue_update;if uf_dw_changed(this) =0 then
	
	ib_genera_castelletto = FALSE
end if
end event

event ue_insert;
end event

event ue_delete;
end event

event doubleclicked;call super::doubleclicked;
event ue_wizard()
end event

event rowfocuschanged;
end event

type cbx_simbolo from checkbox within w_documento_ordine_cx
event clicked pbm_bnclicked
integer x = 2487
integer y = 156
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Simbolo Valuta "
boolean checked = true
boolean lefttext = true
end type

event clicked;
long ll_row, ll_id_valuta
ll_row = idw_gen.getrow()
ll_id_valuta= idw_gen.GetItemNumber(ll_row, "documento_id_valuta_des") 
if isnull(ll_id_valuta) then ll_id_valuta = 0
uf_set_dec_mask( il_arrotondamento, is_simbolo_valuta, ll_id_valuta)


idw_riga.SetRedraw(TRUE)
end event

type cb_contabilizza from commandbutton within w_documento_ordine_cx
event clicked pbm_bnclicked
boolean visible = false
integer x = 928
integer y = 36
integer width = 288
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C&ontabilizza"
end type

event clicked;

cb_salva.triggerevent(clicked!)
if idw_riga.modifiedcount()+idw_riga.deletedcount()>0 then return
uf_contabilizza()
end event

type cb_calcolatrice from commandbutton within w_documento_ordine_cx
integer x = 1595
integer y = 140
integer width = 306
integer height = 80
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Calcolatrice"
end type

event clicked;open(w_calcolatrice)
string ls_nota
decimal{2} ld_peso
long ll_riga, ll_col
ls_nota=message.stringparm
ld_peso=dec(ls_nota)
if not isnull(ld_peso) and ld_peso>0 then
	ll_riga=idw_riga.getrow()
	
	
	ll_col = idw_riga.getcolumn() 

	choose case ll_col
		case 14
			idw_riga.setitem(ll_riga, 'quantita', ld_peso)
			idw_riga.event trigger itemchanged(ll_riga,idw_riga.object.quantita, ls_nota)							
		case 33
			idw_riga.setitem(ll_riga, 'riga_documento_peso_netto', ld_peso)
			idw_riga.event trigger itemchanged(ll_riga,idw_riga.object.riga_documento_peso_netto, ls_nota)				
		case 28
			idw_riga.setitem(ll_riga, 'prezzo', ld_peso)
			idw_riga.event trigger itemchanged(ll_riga,idw_riga.object.prezzo, ls_nota)							
	end choose

	
end if
end event

type cbx_cod_barre from checkbox within w_documento_ordine_cx
integer x = 2167
integer y = 148
integer width = 293
integer height = 76
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cod.Barre"
boolean lefttext = true
end type

event clicked;tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetFocus()
end event

type cb_lettore from commandbutton within w_documento_ordine_cx
integer x = 1925
integer y = 140
integer width = 229
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Lettore"
end type

event clicked;string  port, baud, idterm, filename, path, ls_run
integer offset
boolean aperto
string ls_riga, ls_cod_bar, ls_qta, ls_port
integer li_ret, li_esito, li_app, li_eof, li_pos1, li_pos2, li_pos3, li_lung
string sl_codice	, sl_descrizione
dec ld_qta
long ll_row, ll_id_articolo, ll_count, ll_ut

select count(*)
into :ll_count
from par_lettore;
if ll_count <= 1 then

  SELECT "par_lettore"."port",   
         "par_lettore"."baud",   
         "par_lettore"."id_term",   
         "par_lettore"."filename"  
    INTO :port,   
         :baud,   
         :idterm,   
         :filename  
    FROM "par_lettore"  ;
	 
	IF SQLCA.SQLCode <> 0 THEN
	  MessageBox("Error",  &
		"Errore nella lettura dei parametri di comunicazione" + SQLCA.SQLErrText)
	  RETURN
	END IF	 	
else
	ll_ut = u_freddie.s_utenti.i_idutente
	
	select max(id_term)
	into :idterm
	from let_utenti
	where id_utenti = :ll_ut;
	
	SELECT "par_lettore"."port",   
         "par_lettore"."baud",   
         "par_lettore"."id_term",   
         "par_lettore"."filename"  
    INTO :port,   
         :baud,   
         :idterm,   
         :filename  
    FROM "par_lettore"  
	 where id_term = :idterm;
	 
	IF SQLCA.SQLCode <> 0 THEN
	  MessageBox("Error",  &
		"Errore nella lettura dei parametri di comunicazione" + SQLCA.SQLErrText)
	  RETURN
	END IF	 
	
end if

if idterm = "740" or idterm = "734" then
	w_documento_ordine_cx lw_doc									
	lw_doc = iw_corrente
	
	uo_f7400 u_f7400
	u_f7400=create uo_f7400
	u_f7400.uf_importa_barcode(filename, port, lw_doc, idterm)
	destroy u_f7400		
	return
end if




transaction barCode_TransObj
transaction parameter_TransObj

datastore	ds_dati

barCode_TransObj = CREATE transaction

barCode_TransObj.DBMS = "ODBC"
barCode_TransObj.AutoCommit = False
barCode_TransObj.DBParm = "ConnectString='DSN=Bancolini;UID=;PWD='"
CONNECT USING barCode_TransObj;

IF barCode_TransObj.SQLCode <> 0 THEN
  MessageBox("Connect Failed",  &
	"Cannot connect to ODBC source Bancolini." + SQLCA.SQLErrText)
  RETURN
END IF

  SELECT "par_lettore"."port",   
         "par_lettore"."baud",   
         "par_lettore"."id_term",   
         "par_lettore"."filename"  
    INTO :port,   
         :baud,   
         :idterm,   
         :filename  
    FROM "par_lettore"  ;

IF SQLCA.SQLCode <> 0 THEN
  MessageBox("Error",  &
	"Errore nella lettura dei parametri di comunicazione" + SQLCA.SQLErrText)
  RETURN
END IF

path=fill("*",4)
GetModuleFileNameA(0,path,4)

string command
long result, ll_rows

if fileExists(path+filename) then
	fileDelete(path+filename)
end if
if fileExists(path+"mode_3_4.txt") then
	fileDelete(path+"mode_3_4.txt")
end if
command="p="+port+",b="+baud+",i="+idterm+",f="+filename+",path="+path
result = B30XferRx (command)

if result = 0 then
	
	integer li_FileNum
	string linea
	
	li_FileNum = FileOpen(path + fileName, lineMode!, Read!, LockRead!)
	if li_FileNum <> -1 then
		FileRead(li_FileNum, linea)
		FileClose(li_FileNum)
		
		
		integer start = 1
		integer trovato = 0 
		integer count=-1
		
		DO
			count++
			trovato = pos(linea,";",start)
			start=trovato + 1
		LOOP WHILE trovato<>0
		ds_dati = create datastore
		if count=3 then
				string vecchio_nome
				vecchio_nome = path + "mode_1_2.txt"
				
				string nuovo_nome
				nuovo_nome = path + "mode_3_4.txt"
				
				if not(MoveFileA(vecchio_nome,nuovo_nome)) then
					MessageBox("Alert", "Impossibile rinominare il file")
					RETURN
				end if
				ds_dati.dataobject="dw_bancolini_3_4"
		else
			ds_dati.dataobject="dw_bancolini_1_2"
		end if
	else
		MessageBox("Alert", "File dei dati non trovato")
		RETURN
	END IF
	ds_dati.SetTransObject( barCode_TransObj )
	ll_rows = ds_dati.Retrieve( )
ELSE
  MessageBox("Error", "Problemi nella lettura dati")
  RETURN
end if



long ll_riga
string ls_cod, ls_cod_art
datetime	ldt_data
integer il_qta
boolean lb_inserisci
lb_inserisci=false
ll_riga = ds_dati.Rowcount()
long ll_quanteRighe, ll_rigaInserita
ll_quanteRighe = tab_1.tabpage_2.dw_riga_documento_ordine_gd.Rowcount()

if ll_quanteRighe <> 0 then 
	string tmp
	tmp = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemString(ll_quanterighe,"c_articolo_cod" )
	if tmp<>"" and not isNull(tmp) then
		lb_inserisci=true
	else
		ll_quanterighe -- 
	end if
else
	lb_inserisci=true
end if
for count=ll_quanteRighe +1  to ll_quanteRighe + ll_riga
	if lb_inserisci then
		tab_1.tabpage_2.dw_riga_documento_ordine_gd.triggerevent("ue_insert")	
	else
		lb_inserisci=true
	end if
	ls_cod=ds_dati.GetItemString(count - ll_quanteRighe ,"codice")
	
	
string sl_quantita
sl_quantita = ds_dati.GetItemString(count - ll_quanteRighe ,"quantita")
	il_qta=integer(ds_dati.GetItemString(count - ll_quanteRighe,"quantita"))
	if il_qta=0 then il_qta=1	

 
	select articolo.codice, articolo.descrizione
	into :sl_codice, :sl_descrizione
	from articolo, unita_confezione, cod_barre
	where cod_barre.codice=:ls_cod 
	and cod_barre.id_unita_confezione=unita_confezione.id_unita_confezione
	and articolo.id_articolo=unita_confezione.id_articolo;
	
	
	
	
	
	
	
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.event trigger itemchanged(count,&
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.c_articolo_cod,sl_codice)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setItem(count,"quantita",il_qta)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.setItem(count,"riga_documento_descrizione",sl_descrizione)
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.Trigger event ue_rec_prezzo(count,dec(il_qta))
		
next
	tab_1.tabpage_2.dw_riga_documento_ordine_gd.DeleteRow ( count )
	DESTROY barCode_TransObj


end event

type cb_stampa_etichette from commandbutton within w_documento_ordine_cx
integer x = 1275
integer y = 140
integer width = 306
integer height = 80
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa Etich"
end type

event clicked;OpenWithParm ( w_stampa_etichette, idw_riga )
end event

type tv_1 from u_tv_distinta within w_documento_ordine_cx
boolean visible = false
integer x = 2880
integer y = 12
integer width = 197
integer height = 156
integer taborder = 20
boolean bringtotop = true
end type

type cb_duplica from commandbutton within w_documento_ordine_cx
integer x = 2560
integer y = 32
integer width = 224
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Duplica"
end type

event clicked;
long		ll_id_documento, ll_id_documento_new
long		ll_null
long		ll_rows
long		li_i
string	ls_c_prof_doc_cod
datawindow		ldw_item
integer	li_counter, li_size

cb_ricerca.triggerevent(clicked!)

if UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 then
	ll_id_documento = long(idw_master.is_ricpar.s_id_seg_value[1])

	if (isnull(ll_id_documento) or  ll_id_documento <= 0) then return
	
	
	long ll_id_prof_doc, ll_id_registro, ll_id_caus_mag, ll_id_esercizio, ll_id_reg_origine
	string ls_cod_prof, ls_des_prof, ls_reg_des
	str_dup_doc str
	
	ll_id_reg_origine = idw_gen.getitemnumber(il_row, "id_registro")
	select id_esercizio
	into :ll_id_esercizio
	from registro
	where id_registro = :ll_id_reg_origine;
	if isnull(ll_id_esercizio) then ll_id_esercizio = 0
	
	openwithparm(w_sel_prof_dup_doc, ll_id_esercizio)
	str = message.powerobjectparm	
	ll_id_prof_doc = str.id_prof_doc
	ll_id_registro = str.id_registro
	ll_id_caus_mag = str.id_caus_mag
	if ll_id_prof_doc = 0 or ll_id_registro = 0 or ll_id_caus_mag = 0 then
	else
		select codice, descrizione
		into :ls_cod_prof, :ls_des_prof
		from prof_documento
		where id_prof_documento = :ll_id_prof_doc;
		
		select descrizione
		into :ls_reg_des
		from registro
		where id_registro = :ll_id_registro;
		
		idw_gen.setitem(il_row,"id_prof_documento",ll_id_prof_doc)
		idw_gen.setitem(il_row,"c_prof_doc_cod",ls_cod_prof)
		idw_gen.setitem(il_row,"c_prof_doc_des",ls_des_prof)
				
		idw_gen.setitem(il_row,"id_registro",ll_id_registro)
		idw_gen.setitem(il_row,"c_registro_des",ls_reg_des)		
		idw_gen.setitem(il_row,"documento_id_caus_magazzino",ll_id_caus_mag)	
	end if
	
		
	
	tab_1.tabpage_1.dw_documento_ordine_ff.trigger event ue_set_regi_fields()
	
	decimal ld_num_progressivo, ld_prog_globale
	
	ld_num_progressivo = idw_gen.getitemnumber(il_row, "num_progressivo")
	ld_prog_globale = idw_gen.getitemnumber(il_row, "prog_globale")
		
	
	
	
	
	SELECT fn_dup_documento(:ll_id_documento, :ld_num_progressivo, :ld_prog_globale, :ll_id_prof_doc, :ll_id_registro, :ll_id_caus_mag)
	INTO	 :ll_id_documento_new
	FROM	 SYS.DUMMY;
	
	
	If ll_id_documento_new>0 then
		il_id_documento = ll_id_documento_new
		idw_master.is_list.s_modo = modo_modifica
		idw_master.is_list.s_identifica[1] = "id_documento"
		idw_master.is_list.l_identifica[1] = il_id_documento
		SetPointer(HourGlass!)
		
		this.enabled= FALSE
		idw_master.Event ue_retrieve(0, 0)
		uf_set_documento()
		uf_setup_documento()
		uf_set_istanze()
		this.enabled= TRUE
		uf_default_focus()
		SetPointer(Arrow!)
	end if
end if
end event

type cb_stampa from picture within w_documento_ordine_cx
integer x = 2437
integer y = 28
integer width = 114
integer height = 92
boolean bringtotop = true
string picturename = "C:\dati\pbd12-2017\icone\Stampa.png"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;



	



	


uf_stampa()
end event

type p_video from picture within w_documento_ordine_cx
integer x = 2304
integer y = 28
integer width = 114
integer height = 92
boolean bringtotop = true
string picturename = "s:\pb\commonframework\clipbrd.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;this.enabled = false

string			ls_msg_a, ls_msg_b,ls_title
string			ls_doc_stampato, ls_stampato
boolean			lb_definit, lb_can_go
long				ll_row, ll_id_documento,ll_id_prof_documento
string			ls_tipo_registro, ls_nome_report, ls_dir, ls_selection_formula
window			lw_win
long				ll_retv, ll_sqlcode, ll_sqlrows
integer			li_outdev, li_stampa_ok
integer 			li_retvalue
boolean			lb_iva_ok, lb_cpt_ok
st_stampa_doc lst_stampa
integer li_num_copie
ls_title = ""

If idw_castelletto.RowCount() = 0 then
	ib_genera_castelletto= TRUE
	SetPointer(HourGlass!)
	lb_iva_ok=tab_1.tabpage_4.dw_cast_iva_documento_lt.Event ue_calc_cast_iva()
	lb_cpt_ok=tab_1.tabpage_5.dw_contr_documento_lt.Event ue_calc_contropartita()
	SetPointer(Arrow!)
	If NOT (lb_iva_ok AND lb_cpt_ok) then 
		iuo_msg_log.uf_new_text("Stampa del Documento",3)
		iuo_msg_log.uf_new_text("Impossibile generare correttamente i castelletti IVA e CPT,~n indispensabile per avviare la stampa",4)
		
	end if
end if

if (idw_master.uf_to_update() > 0) OR (idw_master.GetItemStatus(il_row,0,Primary!)=New!) then	
	
	ib_askforsave=FALSE	
	li_retvalue=idw_master.Event ue_update(0,0)
else
	li_retvalue=0
end if
	iuo_msg_log.uf_new_text("Stampa del Documento",3)
if li_retvalue>0 then
	MessageBox("Stampa del Documento","Impossibile salvare il documento,~n indispensabile per avviare la stampa",Exclamation!)
	iuo_msg_log.uf_new_text("Stampa del Documento",3)
	iuo_msg_log.uf_new_text("Impossibile salvare il documento,~n indispensabile per avviare la stampa",4)
	this.enabled = true
	RETURN 0
end if

ls_msg_a = "Stampa Documento; Warning!"
ls_doc_stampato = "documento_stampato"
ls_stampato = "S"


lb_definit = false
lb_can_go = true

ll_id_documento 	= idw_gen.GetItemNumber(il_row, "id_documento")

//SQLCA.sp_stampa_doc(ll_id_documento)		

if lb_can_go then
	ls_msg_b = "ID.DOCUMENTO NULLO"
	if (IsNull(ll_id_documento)) then
		MessageBox(ls_msg_a, ls_msg_b)
		lb_can_go = false
	else 
		ls_selection_formula="{documento.id_documento}=" + String(ll_id_documento)
		
	end if
end if


if lb_can_go then
	ls_tipo_registro = is_tipo_registro
	if isNull(ls_tipo_registro) then
		ls_tipo_registro = ""
	end if
	ls_msg_b = "Tipo registro "+ls_tipo_registro+" sconosciuto. Si userà il preventivo"
	CHOOSE CASE ls_tipo_registro
		CASE "OV", "OA"
			ls_title = "Stampa Ordine"  
		CASE "DV", "DA"
			ls_title = "Stampa Bolla"
		CASE "IV", "IA", "IC"
			ls_title = "Stampa Fattura"
		CASE "PV", "PA"
			ls_title = "Stampa preventivo"
		CASE ELSE
			//MessageBox(ls_msg_a, ls_msg_b)
			ls_title = "Stampa generica"
	END CHOOSE
end if

ll_row					= tab_1.tabpage_1.dw_documento_ordine_ff.getRow()
ll_id_prof_documento = tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber( ll_row,"id_prof_documento" )

if lb_can_go then
	
	if not isNull( ll_id_prof_documento ) then
		select "prof_documento"."nome_report"
			into : ls_nome_report
			from "dba"."prof_documento"   
			where ( "prof_documento"."id_prof_documento" = :ll_id_prof_documento );

			
			
		if SQLCA.SQLCode = -1 then
			MessageBox( "Database Error","Errore : " + SQLCA.SQLErrText,StopSign! )
			this.enabled = true
			return 0
		end if	
		
		if SQLCA.SQLCode = 100 then
			MessageBox( "Warning","Nel profilo documento non esiste il report",StopSign! )
			this.enabled = true
			return 0		
		end if		
		
		if SQLCA.SQLCode = 0 then
			
		end if	
	end if	
end if	



if lb_can_go then
	
	
	
	
	
	
	
	
	ll_retv = 0
	li_num_copie = 1
	
	
	
	CHOOSE CASE ll_retv
		CASE 0							
			li_outdev = 1
		CASE 1							
			li_outdev = 1
			lb_definit = true
			
		CASE 2							
			li_outdev = 2
		CASE 3							
			li_outdev = 2
			lb_definit = true
			
		CASE -1							
			lb_can_go = false
		CASE ELSE						
			lb_can_go = false
	END CHOOSE
end if


if lb_can_go then
	
	select "par_sistema"."dir_report" into :ls_dir
		from "dba"."par_sistema"
		where "par_sistema"."id_azienda" = 1
		using SQLCA;
	ll_sqlcode = sqlca.sqlcode
	ll_sqlrows = sqlca.sqlnrows
	if (isNull(ls_dir)) or (ll_sqlcode<>0) or (ll_sqlrows>1) then
		messageBox(ls_msg_a, ls_msg_b)
		lb_can_go = false
	end if
	
	ls_msg_b = "Errore nella scrittura sul database"
	if lb_definit then
		If MessageBox(is_nome_tipo_documento, "E' stata scelta una stampa definitiva,~n confermi questa scelta?", Information!,YesNo!, 1) = 1 then
			
			ib_askforsave=FALSE
			ll_retv = idw_master.event ue_update (0,0)
			if ll_retv <> 0 then
				messageBox(ls_msg_a,ls_msg_b)
				lb_can_go = false
			end if
		end if
	end if
	
end if
if lb_can_go then
//	u_freddie.iuo_stampa.of_set_selection_formula(ls_selection_formula) 
//	u_freddie.iuo_stampa.of_set_Title(ls_title) 
//	u_freddie.iuo_stampa.of_set_view(u_freddie.iuo_stampa.MAXIMIZE_VIEW)
	
	if li_num_copie<=0 then li_num_copie=1
//	li_stampa_ok = u_freddie.iuo_stampa.of_stampa(0, li_outdev, 0, 0, li_num_copie,ls_dir, ls_nome_report)
	
end if	


ls_msg_b = "Errore in fase di stampa"
if li_stampa_OK <> 0 then
	MessageBox(ls_msg_a, ls_msg_b)
else
	ls_msg_b = "Errore nella scrittura sul database"
	if lb_definit then
		If MessageBox(is_nome_tipo_documento, "E' stata scelta una stampa definitiva,~n confermi questa scelta?", Information!,YesNo!, 1) = 1 then
			
			ib_askforsave=FALSE
			idw_gen.SetItem(il_row, ls_doc_stampato, ls_stampato)
			ll_retv = idw_master.event ue_update (0,0)
			if ll_retv <> 0 then
				messageBox(ls_msg_a,ls_msg_b)
			end if
		end if
	end if
end if


this.enabled = true
RETURN 0

end event

