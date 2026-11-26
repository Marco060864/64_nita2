forward
global type u_service from nonvisualobject
end type
end forward

global type u_service from nonvisualobject
event type integer ue_profilo ( long al_id_profilo )
end type
global u_service u_service

type variables
s_service iastr_service[]
s_service_blocco iastr_blocco[]
boolean ib_doc_stampato, ib_doc_contabilizzato
boolean ib_doc_ev_totale, ib_doc_ev_parziale
boolean ib_doc_ch_forzata, ib_doc_sospeso
boolean ib_bloccato, ib_doc_cr_esenzione
end variables

forward prototypes
public function long uf_valida_dw (string as_dw, datawindow adw_datawindow, string as_err_text)
public function s_service uf_forn_value (string as_action, string as_dwname, string as_datawindow)
public function integer uf_gestione_testata (any aaa_item[])
public function integer uf_set_field (string as_dbname, string as_value, datawindow adw_current, string as_dwcolumn[])
public function integer uf_forn_servizio (string as_dw, datawindow adw_datawindow)
public function long uf_trigger (s_par_service astr_par_service[])
public function integer uf_richiesta (string s_function, ref s_par_service astr_par_service[])
public function integer uf_blocco_docum (long al_id_documento, long al_id_prof_documento, long al_id_azienda)
end prototypes

event ue_profilo;

string		ls_sql_statement, ls_tabella, ls_where, ls_space
string 		ls_gen, ls_comm, ls_note, ls_totali, ls_trasp
string 		ls_righe_gen, ls_righe_comm, ls_righe_mag, ls_righe_altro

integer		li_size, li_counter, li_rc_err
integer		li_nout, li_sqlerr
boolean		lb_ok
long        ll_id_prof_documento, ll_row, ll_time
ll_id_prof_documento=al_id_profilo
s_service 	lstr_service[]
ls_space = " "
li_rc_err = -1
ls_gen  		 	 = "dw_documento_gen_ff"
ls_comm  		 = "dw_documento_comm_ff"
ls_note 		 	 = "dw_documento_note_ff"
ls_trasp			 = "dw_documento_trasp_ff"
ls_totali 		 = "dw_documento_totali_ff"
ls_righe_gen 	 = "dw_riga_documento_gen_ff"
ls_righe_comm 	 = "dw_riga_documento_comm_ff"
ls_righe_mag 	 = "dw_riga_documento_mag_ff"
ls_righe_altro  = "dw_riga_documento_altro_ff"


lstr_service[01].s_dbname = "id_prof_documento"  
lstr_service[02].s_dbname = "codice" 
lstr_service[03].s_dbname = "descrizione" 
lstr_service[04].s_dbname = "des_stampa" 
lstr_service[05].s_dbname = "tipo_registro" 
lstr_service[06].s_dbname = "ric_id_registro"
lstr_service[06].str_service_dw[1].s_datawindow = ls_gen 
lstr_service[06].str_service_dw[1].s_dwcolumn[1] = "c_registro_cod"
lstr_service[06].str_service_dw[1].s_dwcolumn[2] = "c_registro_des"
lstr_service[07].s_dbname = "id_registro_prop" 
lstr_service[07].str_service_dw[1].s_datawindow = ls_gen
lstr_service[07].str_service_dw[1].s_dwcolumn[1] = "id_registro"
lstr_service[08].s_dbname = "ric_num_progressivo"
lstr_service[08].str_service_dw[1].s_datawindow = ls_gen
lstr_service[08].str_service_dw[1].s_dwcolumn[1] = "num_progressivo"
lstr_service[09].s_dbname = "con_data_progressiva" 
lstr_service[09].str_service_dw[1].s_datawindow = ls_gen
lstr_service[09].str_service_dw[1].s_dwcolumn[1] = "data_registrazione"
lstr_service[10].s_dbname = "ric_num_documento"
lstr_service[10].str_service_dw[1].s_datawindow = ls_gen 
lstr_service[10].str_service_dw[1].s_dwcolumn[1] = "num_documento"
lstr_service[11].s_dbname = "note_intestazione_prop"   
lstr_service[12].s_dbname = "ric_id_caus_magazzino" 
lstr_service[12].str_service_dw[1].s_datawindow = ls_gen
lstr_service[12].str_service_dw[1].s_dwcolumn[1] = "id_caus_magazzino_cod"
lstr_service[12].str_service_dw[1].s_dwcolumn[2] = "id_caus_magazzino_des"
lstr_service[13].s_dbname = "id_caus_magazzino_prop" 
lstr_service[13].str_service_dw[1].s_datawindow = ls_gen 
lstr_service[13].str_service_dw[1].s_dwcolumn[1] = "id_caus_magazzino_cod"
lstr_service[13].str_service_dw[1].s_dwcolumn[2] = "id_caus_magazzino_des"
lstr_service[14].s_dbname = "int_consentiti"  
lstr_service[15].s_dbname = "ric_id_sog_comm"
lstr_service[15].str_service_dw[1].s_datawindow = ls_gen
lstr_service[15].str_service_dw[1].s_dwcolumn[1] = "c_intestatario_cod"
lstr_service[15].str_service_dw[1].s_dwcolumn[2] = "c_intestatario_des"
lstr_service[16].s_dbname = "id_sog_comm_prop"
lstr_service[16].str_service_dw[1].s_datawindow = ls_gen
lstr_service[16].str_service_dw[1].s_dwcolumn[1] = "id_sog_commerciale"
lstr_service[17].s_dbname = "ric_id_magazzino_1"
lstr_service[17].str_service_dw[1].s_datawindow = ls_gen
lstr_service[17].str_service_dw[1].s_dwcolumn[1] = "c_mag_partenza_cod"
lstr_service[17].str_service_dw[1].s_dwcolumn[2] = "c_mag_partenza_des"
lstr_service[18].s_dbname = "id_magazzino_1_prop"
lstr_service[18].str_service_dw[1].s_datawindow = ls_gen
lstr_service[18].str_service_dw[1].s_dwcolumn[1] = "id_magazzino"
lstr_service[19].s_dbname = "ric_id_magazzino_2"
lstr_service[19].str_service_dw[1].s_datawindow = ls_gen 
lstr_service[19].str_service_dw[1].s_dwcolumn[1] = "c_mag_dest_cod"
lstr_service[19].str_service_dw[1].s_dwcolumn[2] = "c_mag_dest_des"
lstr_service[20].s_dbname = "id_magazzino_2_prop"
lstr_service[20].str_service_dw[1].s_datawindow = ls_gen
lstr_service[20].str_service_dw[1].s_dwcolumn[1] = "id_magazzino_2"
lstr_service[21].s_dbname = "ric_id_sog_comm_fattura"
lstr_service[21].str_service_dw[1].s_datawindow = ls_comm
lstr_service[21].str_service_dw[1].s_dwcolumn[1] = "c_fattura_cod"
lstr_service[21].str_service_dw[1].s_dwcolumn[2] = "c_fattura_des"
lstr_service[22].s_dbname = "id_sog_comm_fattura_prop"
lstr_service[22].str_service_dw[1].s_datawindow = ls_comm
lstr_service[22].str_service_dw[1].s_dwcolumn[1] = "id_sog_commerciale_fattura"
lstr_service[23].s_dbname = "ric_lingua_linguaggio"
lstr_service[23].str_service_dw[1].s_datawindow = ls_comm
lstr_service[23].str_service_dw[1].s_dwcolumn[1] = "id_lingua_cod"
lstr_service[23].str_service_dw[1].s_dwcolumn[2] = "id_lingua_des"
lstr_service[23].str_service_dw[1].s_dwcolumn[3] = "id_linguaggio"
lstr_service[23].str_service_dw[1].s_dwcolumn[4] = "id_linguaggio_des"
lstr_service[24].s_dbname = "id_linguaggio_prop"
lstr_service[24].str_service_dw[1].s_datawindow = ls_comm
lstr_service[24].str_service_dw[1].s_dwcolumn[1] = "id_linguaggio"
lstr_service[24].str_service_dw[1].s_dwcolumn[2] = "id_linguaggio_des"
lstr_service[25].s_dbname = "id_lingua_prop"
lstr_service[25].str_service_dw[1].s_datawindow = ls_comm
lstr_service[25].str_service_dw[1].s_dwcolumn[1] = "id_lingua_cod"
lstr_service[25].str_service_dw[1].s_dwcolumn[2] = "id_lingua_des"
lstr_service[26].s_dbname = "ric_id_valuta" 
lstr_service[26].str_service_dw[1].s_datawindow = ls_comm
lstr_service[26].str_service_dw[1].s_dwcolumn[1] = "id_valuta"
lstr_service[26].str_service_dw[1].s_dwcolumn[2] = "id_valuta_des"
lstr_service[27].s_dbname = "id_valuta_prop"
lstr_service[27].str_service_dw[1].s_datawindow = ls_comm
lstr_service[27].str_service_dw[1].s_dwcolumn[1] = "id_valuta"
lstr_service[27].str_service_dw[1].s_dwcolumn[2] = "id_valuta_des"
lstr_service[28].s_dbname = "ric_id_listino"
lstr_service[28].str_service_dw[1].s_datawindow = ls_comm
lstr_service[28].str_service_dw[1].s_dwcolumn[1] = "id_listino"
lstr_service[28].str_service_dw[1].s_dwcolumn[2] = "id_listino_des"
lstr_service[29].s_dbname = "id_listino_prop"
lstr_service[29].str_service_dw[1].s_datawindow = ls_comm
lstr_service[29].str_service_dw[1].s_dwcolumn[1] = "id_listino"
lstr_service[29].str_service_dw[1].s_dwcolumn[2] = "id_listino_des"
lstr_service[30].s_dbname = "ric_id_con_pagamento"
lstr_service[30].str_service_dw[1].s_datawindow = ls_comm
lstr_service[30].str_service_dw[1].s_dwcolumn[1] = "id_con_pagamento"
lstr_service[30].str_service_dw[1].s_dwcolumn[2] = "id_con_pagamento_des"
lstr_service[31].s_dbname = "id_con_pagamento_prop"
lstr_service[31].str_service_dw[1].s_datawindow = ls_comm
lstr_service[31].str_service_dw[1].s_dwcolumn[1] = "id_con_pagamento"
lstr_service[31].str_service_dw[1].s_dwcolumn[2] = "id_con_pagamento_des"
lstr_service[32].s_dbname = "ric_scadenze"   
lstr_service[33].s_dbname = "ric_id_sog_comm_agente"
lstr_service[33].str_service_dw[1].s_datawindow = ls_comm
lstr_service[33].str_service_dw[1].s_dwcolumn[1] = "c_agente_cod"
lstr_service[33].str_service_dw[1].s_dwcolumn[2] = "c_agente_des"
lstr_service[34].s_dbname = "ric_provvigioni"   
lstr_service[35].s_dbname = "ric_data_consegna"   
lstr_service[36].s_dbname = "gg_consegna"   
lstr_service[37].s_dbname = "ric_sconti_finanziari"
lstr_service[38].s_dbname = "spese_gestite"
lstr_service[39].s_dbname = "ric_acconti"   
lstr_service[40].s_dbname = "ric_date_competenza"   
lstr_service[41].s_dbname = "ric_colli_documento"
lstr_service[41].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[41].str_service_dw[1].s_dwcolumn[1] = "num_colli"
lstr_service[42].s_dbname = "ric_pesi"
lstr_service[42].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[42].str_service_dw[1].s_dwcolumn[1] = "id_unita_misura_peso_cod"
lstr_service[42].str_service_dw[1].s_dwcolumn[2] = "peso_netto"
lstr_service[42].str_service_dw[1].s_dwcolumn[3] = "peso_lordo"
lstr_service[43].s_dbname = "ric_volumi"
lstr_service[43].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[44].s_dbname = "ric_id_tipo_trasporto" 
lstr_service[44].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[44].str_service_dw[1].s_dwcolumn[1] = "id_tipo_trasporto"
lstr_service[44].str_service_dw[1].s_dwcolumn[2] = "id_tipo_trasporto_des"
lstr_service[45].s_dbname = "ric_id_caus_trasporto" 
lstr_service[45].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[45].str_service_dw[1].s_dwcolumn[1] = "id_caus_trasporto"
lstr_service[45].str_service_dw[1].s_dwcolumn[2] = "id_caus_trasporto_des"
lstr_service[46].s_dbname = "ric_asp_beni" 
lstr_service[46].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[46].str_service_dw[1].s_dwcolumn[1] = "asp_beni"
lstr_service[47].s_dbname = "aspetto_beni_prop"
lstr_service[47].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[47].str_service_dw[1].s_dwcolumn[1] = "asp_beni"
lstr_service[48].s_dbname = "ric_trasp_mezzo"
lstr_service[48].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[48].str_service_dw[1].s_dwcolumn[1] = "tras_mezzo"
lstr_service[49].s_dbname = "trasp_mezzo_prop" 
lstr_service[49].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[49].str_service_dw[1].s_dwcolumn[1] = "tras_mezzo"
lstr_service[50].s_dbname = "ric_id_sog_comm_vettore_1"
lstr_service[50].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[50].str_service_dw[1].s_dwcolumn[1] = "c_vettore_cod"
lstr_service[50].str_service_dw[1].s_dwcolumn[2] = "c_vettore_des"
lstr_service[51].s_dbname = "ric_id_sog_comm_vettore_2" 
lstr_service[51].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[51].str_service_dw[1].s_dwcolumn[1] = "c_vettore_2_cod"
lstr_service[51].str_service_dw[1].s_dwcolumn[2] = "c_vettore_2_des"
lstr_service[52].s_dbname = "id_sog_comm_vettore_1_prop" 
lstr_service[52].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[52].str_service_dw[1].s_dwcolumn[1] = "id_sog_commerciale_vettore"
lstr_service[53].s_dbname = "ric_mezzo_trasporto"
lstr_service[53].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[53].str_service_dw[1].s_dwcolumn[1] = "mezzo_trasporto"
lstr_service[54].s_dbname = "ric_data_trasporto"
lstr_service[54].str_service_dw[1].s_datawindow = ls_trasp
lstr_service[54].str_service_dw[1].s_dwcolumn[1] = "data_trasporto"
lstr_service[55].s_dbname = "stampabile"
lstr_service[56].s_dbname = "stampa_immediata"
lstr_service[57].s_dbname = "ges_pac_list"   
lstr_service[58].s_dbname = "ges_evas_parziale"   
lstr_service[59].s_dbname = "ges_db"   
lstr_service[60].s_dbname = "ges_matricole"   
lstr_service[61].s_dbname = "con_dis_articoli"   
lstr_service[62].s_dbname = "ges_chius_forzata"   
lstr_service[63].s_dbname = "ges_stato_documento" 
lstr_service[64].s_dbname = "tipo_raggruppamento"
lstr_service[65].s_dbname = "usa_int_fattura"
lstr_service[66].s_dbname = "contabilizzabile"
lstr_service[67].s_dbname = "des_contabile"
lstr_service[68].s_dbname = "ric_id_unita_confezione_riga"
lstr_service[68].str_service_dw[1].s_datawindow = ls_righe_gen
lstr_service[68].str_service_dw[1].s_dwcolumn[1] = "c_unita_confezione_codice"
lstr_service[68].str_service_dw[1].s_dwcolumn[2] = "c_unita_confezione_descrizione"
lstr_service[68].str_service_dw[1].s_dwcolumn[3] = "id_unita_confezione"
lstr_service[69].s_dbname = "ric_quantita_riga"
lstr_service[69].str_service_dw[1].s_datawindow = ls_righe_gen
lstr_service[69].str_service_dw[1].s_dwcolumn[1] = "quantita"
lstr_service[70].s_dbname = "quantita_prop_riga"
lstr_service[71].s_dbname = "ric_unita_base_riga" 
lstr_service[71].str_service_dw[1].s_datawindow = ls_righe_gen
lstr_service[71].str_service_dw[1].s_dwcolumn[1] = "qta_unita_base"
lstr_service[72].s_dbname = "ric_unita_prezzo_riga"
lstr_service[72].str_service_dw[1].s_datawindow = ls_righe_gen
lstr_service[72].str_service_dw[1].s_dwcolumn[1] = "qta_unita_prezzo"
lstr_service[73].s_dbname = "ric_id_caus_magazzino_riga"
lstr_service[73].str_service_dw[1].s_datawindow = ls_righe_mag
lstr_service[73].str_service_dw[1].s_dwcolumn[1] = "id_caus_magazzino"
lstr_service[73].str_service_dw[1].s_dwcolumn[2] = "id_caus_magazzino_des"
lstr_service[74].s_dbname = "ric_locazione_1_riga"
lstr_service[74].str_service_dw[1].s_datawindow = ls_righe_mag
lstr_service[74].str_service_dw[1].s_dwcolumn[1] = "id_locazione_partenza"
lstr_service[75].s_dbname = "ric_locazione_2_riga"
lstr_service[75].str_service_dw[1].s_datawindow = ls_righe_mag
lstr_service[75].str_service_dw[1].s_dwcolumn[1] = "id_locazione_destinazione"
lstr_service[76].s_dbname = "ric_data_prev_consegna_riga"
lstr_service[76].str_service_dw[1].s_datawindow = ls_righe_mag
lstr_service[76].str_service_dw[1].s_dwcolumn[1] = "data_prevista_consegna"
lstr_service[77].s_dbname = "ric_pesi_riga"
lstr_service[77].str_service_dw[1].s_datawindow = ls_righe_mag
lstr_service[77].str_service_dw[1].s_dwcolumn[1] = "peso_netto"
lstr_service[77].str_service_dw[1].s_dwcolumn[2] = "peso_lordo"
lstr_service[78].s_dbname = "ric_dim_riga"
lstr_service[78].str_service_dw[1].s_datawindow = ls_righe_mag
lstr_service[78].str_service_dw[1].s_dwcolumn[1] = "dim_l"
lstr_service[78].str_service_dw[1].s_dwcolumn[2] = "dim_h"
lstr_service[78].str_service_dw[1].s_dwcolumn[3] = "dim_p"
lstr_service[79].s_dbname = "ric_colli_riga"
lstr_service[79].str_service_dw[1].s_datawindow = ls_righe_mag
lstr_service[79].str_service_dw[1].s_dwcolumn[1] = "num_colli"
lstr_service[80].s_dbname = "ric_id_valuta_riga"
lstr_service[80].str_service_dw[1].s_datawindow = ls_righe_comm
lstr_service[80].str_service_dw[1].s_dwcolumn[1] = "id_valuta"
lstr_service[80].str_service_dw[1].s_dwcolumn[2] = "id_valuta_des"
lstr_service[81].s_dbname = "ric_id_listino_riga"
lstr_service[81].str_service_dw[1].s_datawindow = ls_righe_comm
lstr_service[81].str_service_dw[1].s_dwcolumn[1] = "id_listino"
lstr_service[81].str_service_dw[1].s_dwcolumn[2] = "id_listino_des"
lstr_service[82].s_dbname = "ric_prezzo_riga"
lstr_service[82].str_service_dw[1].s_datawindow = ls_righe_comm
lstr_service[82].str_service_dw[1].s_dwcolumn[1] = "prezzo"
lstr_service[83].s_dbname = "ric_sconto_riga"
lstr_service[83].str_service_dw[1].s_datawindow = ls_righe_comm
lstr_service[83].str_service_dw[1].s_dwcolumn[1] = "sconto"
lstr_service[84].s_dbname = "ric_prezzo_netto_riga"
lstr_service[84].str_service_dw[1].s_datawindow = ls_righe_comm
lstr_service[84].str_service_dw[1].s_dwcolumn[1] = "prezzo_netto"
lstr_service[85].s_dbname = "ric_sconto_riga_riga"
lstr_service[85].str_service_dw[1].s_datawindow = ls_righe_comm
lstr_service[85].str_service_dw[1].s_dwcolumn[1] = "sconto_riga"
lstr_service[86].s_dbname = "ric_id_tab_iva_riga"
lstr_service[86].str_service_dw[1].s_datawindow = ls_righe_comm
lstr_service[86].str_service_dw[1].s_dwcolumn[1] = "id_tab_iva"
lstr_service[86].str_service_dw[1].s_dwcolumn[2] = "id_tab_iva_des"
lstr_service[87].s_dbname = "ric_id_sog_comm_agente_riga"
lstr_service[88].s_dbname = "ric_provvigioni_riga"
lstr_service[89].s_dbname = "ric_val_attribuito_riga"
lstr_service[90].s_dbname = "ric_date_competenza_riga"
lstr_service[91].s_dbname = "ric_contropartite_riga"
lstr_service[92].s_dbname = "id_azienda"
ls_tabella = "prof_documento"
ls_tabella = "dba." + ls_tabella
li_size = UpperBound(lstr_service[])
ls_sql_statement = "SELECT" + ls_space
FOR li_counter = 1 TO li_size
	IF Len(lstr_service[li_counter].s_dbname) = 0 THEN
		
		RETURN li_rc_err
	END IF	
	ls_sql_statement = ls_sql_statement + ls_tabella + "." + lstr_service[li_counter].s_dbname
	IF li_counter < li_size THEN
		ls_sql_statement = ls_sql_statement + ", "
	END IF
NEXT
ls_sql_statement = ls_sql_statement + ls_space + "from" + ls_space
ls_sql_statement = ls_sql_statement + ls_tabella + " where " + ls_tabella+ ".id_prof_documento =  ? "  
PREPARE sqlsa FROM :ls_sql_statement;
li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	MessageBox("UF_GET_DATI_PROFILO: ERRORE PREPARE", String(li_sqlerr))
	RETURN li_rc_err
END IF
DESCRIBE sqlsa INTO sqlda;
li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	
	RETURN li_rc_err
END IF
DECLARE lcursor DYNAMIC CURSOR FOR SQLSA;
li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	
	RETURN li_rc_err
END IF

SQLDA.SetDynamicParm( 1, String (ll_id_prof_documento))
OPEN DYNAMIC lcursor USING DESCRIPTOR SQLDA;
li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	
	RETURN li_rc_err
END IF
FETCH lcursor USING DESCRIPTOR SQLDA;
li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	
	RETURN li_rc_err
END IF
IF SQLDA.NumOutputs <> li_size THEN
	li_nout = SQLDA.NUMOutputs
	
	RETURN li_rc_err
END IF
FOR li_counter = 1 TO li_size
	CHOOSE CASE sqlda.OutParmType[li_counter]
		 CASE TypeDate!
			lstr_service[li_counter].s_value = string (GetDynamicDate(sqlda,li_counter))
		 CASE TypeDateTime!
				lstr_service[li_counter].s_value = string (GetDynamicDateTime(sqlda,li_counter))
		 CASE TypeDecimal!, TypeDouble!, TypeInteger!, TypeLong!, TypeReal!, TypeBoolean!
			lstr_service[li_counter].s_value = string (GetDynamicNumber(sqlda,li_counter))
		 CASE TypeUInt!, TypeULong!
			lstr_service[li_counter].s_value = string (GetDynamicNumber(sqlda,li_counter))
		 CASE TypeString!
			lstr_service[li_counter].s_value = string (GetDynamicString(sqlda,li_counter))
		 CASE TypeTime!
			lstr_service[li_counter].s_value = string (GetDynamicTime(sqlda,li_counter))
		 CASE ELSE
			lstr_service[li_counter].s_value = string (GetDynamicString(sqlda,li_counter))
	END CHOOSE
NEXT
CLOSE lcursor;

li_sqlerr = sqlca.sqlcode
IF li_sqlerr <> 0 THEN
	
	RETURN li_rc_err
END IF
iastr_service = lstr_service 
FOR li_counter = 1 TO 3
	
NEXT
RETURN 0
end event

public function long uf_valida_dw (string as_dw, datawindow adw_datawindow, string as_err_text);long ll_count, ll_str_count, ll_size, ll_str_size, ll_col_size, ll_col_count, ll_ret_value
string ls_dwcolumn[], ls_value, ls_error_field
boolean lb_controllato, lb_error
ll_str_size= UpperBound(iastr_service)
s_service_dw lstr_dw_service[]
s_service lstr_service_ret
u_dw_main ldw_datawindow
lb_error=FALSE

ll_ret_value=0
for ll_str_count = 1 to ll_str_size
	if (Left(iastr_service[ll_str_count].s_dbname, 4) = "ric_") AND &
		(iastr_service[ll_str_count].s_value = "O") then
	
		lstr_dw_service = iastr_service[ll_str_count].str_service_dw
		ll_size= UpperBound(lstr_dw_service)
		for ll_count = 1 to ll_size
			lb_controllato= FALSE
			lb_error= FALSE
			if lstr_dw_service[ll_count].s_datawindow = as_dw then
				ldw_datawindow= adw_datawindow
				ls_dwcolumn= lstr_dw_service[ll_count].s_dwcolumn
				ll_col_size= UpperBound(ls_dwcolumn)
				for ll_col_count = 1 to ll_col_size
					if Left(ls_dwcolumn[ll_col_count],3) = "id_" then 
						ls_value=ldw_datawindow.uf_get_colval(ls_dwcolumn[ll_col_count])
							if IsNull(ls_value) OR ls_value = "" then
								lb_error= TRUE
							end if
						lb_controllato= TRUE
					end if
				next
	
				if not lb_controllato then
					for ll_col_count = 1 to ll_col_size
						ls_value=ldw_datawindow.uf_get_colval(ls_dwcolumn[ll_col_count])
						if IsNull(ls_value) OR ls_value = "" then
							lb_error= TRUE
						end if
					next
				end if
	
				if lb_error then
					ll_ret_value= ll_ret_value +1
					ls_error_field= ""
					for ll_col_count = 1 to ll_col_size
						if ls_error_field= "" then	ls_error_field= ldw_datawindow.Describe(ls_dwcolumn[ll_col_count] + "_t.text")
					next
					if ls_error_field= "" then	ls_error_field= iastr_service[ll_str_count].s_dbname
					as_err_text= as_err_text + ls_error_field + " non può essere nullo.~n"
				end if			
					
			end if	
		next
	end if
next
return ll_ret_value

end function

public function s_service uf_forn_value (string as_action, string as_dwname, string as_datawindow);long ll_count, ll_str_count, ll_size, ll_str_size, ll_col_size, ll_col_count
string ls_dwcolumn[]
ll_str_size= UpperBound(iastr_service)
s_service_dw lstr_dw_service[]
s_service lstr_service_ret
for ll_str_count = 1 to ll_str_size
	if (Left(iastr_service[ll_str_count].s_dbname, 4) = as_action + "_") then
		lstr_dw_service= iastr_service[ll_str_count].str_service_dw
		ll_size= UpperBound(lstr_dw_service)
		for ll_count = 1 to ll_size
			if lstr_dw_service[ll_count].s_datawindow = as_datawindow then
				ls_dwcolumn= lstr_dw_service[ll_count].s_dwcolumn
				ll_col_size= UpperBound(ls_dwcolumn)
				for ll_col_count = 1 to ll_col_size
					if ls_dwcolumn[ll_col_count] = as_dwname then lstr_service_ret = iastr_service[ll_str_count]
				next
			end if
		next
	end if
next


return lstr_service_ret

end function

public function integer uf_gestione_testata (any aaa_item[]);
long ll_size, ll_count
long ll_row
datawindow ldw_gen

ldw_gen= aaa_item[1]
ll_row= ldw_gen.GetRow()

if not(ldw_gen.GetItemStatus(ll_row, 0, Primary!)= New! OR ldw_gen.GetItemStatus(ll_row, 0, Primary!)= NewModified!) then
	ll_size= UpperBound(aaa_item)
	for ll_count = 2 to ll_size
		f_displayonly(ldw_gen,aaa_item[ll_count] , TRUE)
	next
end if
return 0

end function

public function integer uf_set_field (string as_dbname, string as_value, datawindow adw_current, string as_dwcolumn[]);string ls_dwcolumn, ls_color, ls_validation
u_dw_main ldw_datawindow
s_service_dw lstr_service_dw[]
long ll_dwcount, ll_dwsize, ll_count, ll_size
ldw_datawindow=adw_current

ll_size= UpperBound(as_dwcolumn)
for ll_count= 1 to ll_size
	ls_dwcolumn= as_dwcolumn[ll_count]
	CHOOSE CASE Left(as_dbname, 4)
		CASE "ges_"
			CHOOSE CASE ""
				CASE ""
			END CHOOSE

		CASE "ric_"
			CHOOSE CASE as_value
				CASE "N"
					f_displayonly(ldw_datawindow, ls_dwcolumn, TRUE)
					
					ls_color = "276856960"
					ldw_datawindow.Modify(ls_dwcolumn + ".color = " + ls_color)
				CASE "L"
					f_displayonly(ldw_datawindow, ls_dwcolumn, TRUE)
					ls_color= f_get_dwo_property(ldw_datawindow.Describe(ls_dwcolumn + ".color"), "0", "")
					ldw_datawindow.Modify(ls_dwcolumn + ".color = " + ls_color)
					
					ldw_datawindow.Modify(ls_dwcolumn + ".color = 0")

				CASE "M"
					f_displayonly(ldw_datawindow, ls_dwcolumn, FALSE)
					ls_color= f_get_dwo_property(ldw_datawindow.Describe(ls_dwcolumn + ".color"), "0", "")
					ldw_datawindow.Modify(ls_dwcolumn + ".color = " + ls_color)

					CHOOSE CASE String(ldw_datawindow.Describe(ls_dwcolumn + ".edit.style"))
						CASE "edit"
							ldw_datawindow.Modify(ls_dwcolumn + ".edit.nilisnull = FALSE")
							ldw_datawindow.Modify(ls_dwcolumn + ".edit.required = FALSE")
						CASE "dddw"
							ldw_datawindow.Modify(ls_dwcolumn + ".dddw.required = FALSE")

						CASE "ddlb"
							ldw_datawindow.Modify(ls_dwcolumn + ".ddlb.required = FALSE")
						CASE "editmask"
							ldw_datawindow.Modify(ls_dwcolumn + ".editmask.required = FALSE")
						CASE ELSE
					END CHOOSE
				CASE "O"
					CHOOSE CASE String(ldw_datawindow.Describe(ls_dwcolumn + ".edit.style"))
						CASE "edit"
							ldw_datawindow.Modify(ls_dwcolumn + ".edit.nilisnull = TRUE")
							ldw_datawindow.Modify(ls_dwcolumn + ".edit.required = TRUE")
						CASE "dddw"
							ldw_datawindow.Modify(ls_dwcolumn + ".dddw.required = TRUE")

						CASE "ddlb"
							ldw_datawindow.Modify(ls_dwcolumn + ".ddlb.required = TRUE")
						CASE "editmask"
							ldw_datawindow.Modify(ls_dwcolumn + ".editmask.required = TRUE")
						CASE ELSE
					END CHOOSE
			END CHOOSE
		
		CASE "con_"
		CASE ELSE
			if (ldw_datawindow.GetItemStatus(ldw_datawindow.GetRow(), 0, Primary!) = New!) OR &
			(ldw_datawindow.GetItemStatus(ldw_datawindow.GetRow(), 0, Primary!) = NewModified!) then
				CHOOSE CASE Right(as_dbname, 5)
					CASE "_prop"
						ldw_datawindow.uf_set_colval(ls_dwcolumn,as_value )
				END CHOOSE
			end if
	END CHOOSE
	
	
next
return 0
end function

public function integer uf_forn_servizio (string as_dw, datawindow adw_datawindow);long ll_size, ll_count
string ls_datawindow
s_service_dw lstr_service_dw[]
long ll_dwcount, ll_dwsize

ll_size= UpperBound(iastr_service)

for ll_count= 1 to ll_size
	lstr_service_dw = iastr_service[ll_count].str_service_dw
	ll_dwsize= UpperBound(lstr_service_dw)
	for ll_dwcount= 1 to ll_dwsize
		ls_datawindow= lstr_service_dw[ll_dwcount].s_datawindow
		if ls_datawindow= as_dw then
			this.uf_set_field(iastr_service[ll_count].s_dbname, iastr_service[ll_count].s_value, &
					adw_datawindow,  lstr_service_dw[ll_dwcount].s_dwcolumn)
		end if
	next
next
return 0
end function

public function long uf_trigger (s_par_service astr_par_service[]);long ll_id_sog_commerciale, ll_row, ll_id_lingua, ll_id_linguaggio, ll_id_valuta, ll_id_listino
long ll_con_pagamento, ll_count, ll_size, ll_id_tab_iva, ll_id_riga, ll_id_articolo, ll_codice
long ll_id_des_articolo, ll_id_tipo_trasporto
string ls_rag_soc, ls_tipo_iva, ls_codice, ls_info
decimal ldc_cambio
datawindow ldw_1, ldw_2, ldw_3, ldw_4, ldw_5

CHOOSE CASE astr_par_service[1].s_column_name
	CASE "intestatario"
		ldw_1= astr_par_service[1].dw_datawindow
		ldw_2= astr_par_service[3].dw_datawindow
		ll_row= ldw_1.GetRow()
		ll_id_sog_commerciale= Long(astr_par_service[1].a_in)
		if not IsNull(ll_id_sog_commerciale) then
			
			ls_info= f_info_sc(ll_id_sog_commerciale)
			
			if ldw_1.Describe("cinfo.name") <> "!" then
				ldw_1.SetItem(ll_row,"cinfo", ls_info)
			end if
		  SELECT "anagrafica"."rag_soc_1",   
					"anagrafica"."id_lingua",   
					"anagrafica"."id_valuta", 
					"anagrafica"."id_tipo_trasporto", 
					"sog_commerciale"."codice",
					"sog_commerciale"."id_con_pagamento",
					"sog_commerciale"."id_linguaggio",   
					"sog_commerciale"."id_listino", 
					"sog_commerciale"."id_tab_iva" ,
					"valuta"."cambio"  
			 INTO :ls_rag_soc,   
					:ll_id_lingua,   
					:ll_id_valuta, 
					:ll_id_tipo_trasporto,
					:ls_codice, 
					:ll_con_pagamento ,
					:ll_id_linguaggio,   
					:ll_id_listino, 
					:ll_id_tab_iva,  
					:ldc_cambio  
			 FROM "anagrafica",   
					"sog_commerciale",   
					"valuta"  
			WHERE ( "sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and  
					( "valuta"."id_valuta" = "anagrafica"."id_valuta" ) and  
					( ( "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) )   ;
		 				
				IF NOT (IsNull(ll_id_sog_commerciale) OR ll_id_sog_commerciale = 0) THEN
							ldw_2.SetItem(ll_row,astr_par_service[3].s_column_name, ll_id_sog_commerciale) 
				END IF
				
				IF NOT (IsNull(ll_id_lingua) OR ll_id_lingua = 0) THEN
						 	ldw_2.SetItem(ll_row,astr_par_service[4].s_column_name, ll_id_lingua)
				END IF
				
				IF NOT (IsNull(ll_id_linguaggio) OR ll_id_linguaggio = 0) THEN 
							ldw_2.SetItem(ll_row,astr_par_service[5].s_column_name, ll_id_linguaggio)
				END IF
				
				
		END IF
END CHOOSE

RETURN 0
end function

public function integer uf_richiesta (string s_function, ref s_par_service astr_par_service[]);CHOOSE CASE s_function
	CASE "trigger"
		uf_trigger(astr_par_service)


END CHOOSE

return 0
end function

public function integer uf_blocco_docum (long al_id_documento, long al_id_prof_documento, long al_id_azienda);integer  			li_retcode
string				ls_msg, ls_sep, ls_si, ls_no
string				ls_stampato, ls_contabilizzato, ls_evaso_totalmente
string				ls_chius_forzata, ls_sospeso, ls_bloccato, ls_pw_bloccato , ls_pw_sospeso
string				ls_pw_sblocco_stampa , ls_pw_chius_forzata
w_blocco_docum_wz wi_blocco_docum_wz
s_service_blocco	lastr_s_ser_blo[]

ls_si = "S"
ls_no = "N"
ls_sep	= "~n"
li_retcode = (-1)
IF (IsNull(al_id_documento)) THEN
	RETURN li_retcode
END IF
SELECT documento.stampato, &
		 documento.contabilizzato, &
		 documento.evaso_totalmente, &
		 documento.chius_forzata, &
		 documento.sospeso, &
		 documento.bloccato
		 INTO	:ls_stampato, &
		 		:ls_contabilizzato, &
				:ls_evaso_totalmente, &
				:ls_chius_forzata, &
				:ls_sospeso, &
				:ls_bloccato
		 FROM documento
		 WHERE documento.id_documento = :al_id_documento
		 USING SQLCA;
SELECT "prof_documento"."pas_di_sblocco",   
		"prof_documento"."pas_chiu_forz"  
	INTO :ls_pw_sblocco_stampa,   
		:ls_pw_chius_forzata  
	FROM "prof_documento"  
	WHERE "prof_documento"."id_prof_documento" = :al_id_prof_documento   ;

SELECT "azienda"."pas_blocco_doc",   
		"azienda"."pas_sosp_doc"  
	INTO :ls_pw_bloccato,   
		:ls_pw_sospeso  
	FROM "azienda"  
	WHERE "azienda"."id_azienda" = :al_id_azienda   ;



lastr_s_ser_blo[1].s_ser_blo_1_desc_stato = "STAMPATO" 
lastr_s_ser_blo[1].s_ser_blo_2_old_stato  = ls_stampato
lastr_s_ser_blo[1].s_ser_blo_3_password   = ls_pw_sblocco_stampa
lastr_s_ser_blo[1].s_ser_blo_4_new_stato  = ls_stampato 
lastr_s_ser_blo[1].s_ser_blo_5_modo       = ls_si
lastr_s_ser_blo[2].s_ser_blo_1_desc_stato = "BLOCCATO" 
lastr_s_ser_blo[2].s_ser_blo_2_old_stato  = ls_bloccato
lastr_s_ser_blo[2].s_ser_blo_3_password   = ls_pw_bloccato
lastr_s_ser_blo[2].s_ser_blo_4_new_stato  = ls_bloccato 
lastr_s_ser_blo[2].s_ser_blo_5_modo       = ls_si
lastr_s_ser_blo[3].s_ser_blo_1_desc_stato = "CONTABILIZZATO" 
lastr_s_ser_blo[3].s_ser_blo_2_old_stato  = ls_contabilizzato 
lastr_s_ser_blo[3].s_ser_blo_3_password   = "PWCONTABILIZZATO"
lastr_s_ser_blo[3].s_ser_blo_4_new_stato  = ls_contabilizzato 
lastr_s_ser_blo[3].s_ser_blo_5_modo       = ls_si
lastr_s_ser_blo[4].s_ser_blo_1_desc_stato = "SOSPESO" 
lastr_s_ser_blo[4].s_ser_blo_2_old_stato  = ls_sospeso
lastr_s_ser_blo[4].s_ser_blo_3_password   = ls_pw_sospeso
lastr_s_ser_blo[4].s_ser_blo_4_new_stato  = ls_sospeso
lastr_s_ser_blo[4].s_ser_blo_5_modo       = ls_si
lastr_s_ser_blo[5].s_ser_blo_1_desc_stato = "EVASO" 
lastr_s_ser_blo[5].s_ser_blo_2_old_stato  = ls_evaso_totalmente 
lastr_s_ser_blo[5].s_ser_blo_3_password   = "PWEVASO"
lastr_s_ser_blo[5].s_ser_blo_4_new_stato  = ls_evaso_totalmente
lastr_s_ser_blo[5].s_ser_blo_5_modo       = ls_si
lastr_s_ser_blo[6].s_ser_blo_1_desc_stato = "CHIUSO" 
lastr_s_ser_blo[6].s_ser_blo_2_old_stato  = ls_chius_forzata
lastr_s_ser_blo[6].s_ser_blo_3_password   = ls_pw_chius_forzata
lastr_s_ser_blo[6].s_ser_blo_4_new_stato  = ls_chius_forzata
lastr_s_ser_blo[6].s_ser_blo_5_modo       = ls_si
lastr_s_ser_blo[7].s_ser_blo_1_desc_stato = "ALTRO" 
lastr_s_ser_blo[7].s_ser_blo_2_old_stato  = "N" 
lastr_s_ser_blo[7].s_ser_blo_3_password   = "PWALTRO"
lastr_s_ser_blo[7].s_ser_blo_4_new_stato  = "S"
lastr_s_ser_blo[7].s_ser_blo_5_modo       = ls_no
iastr_blocco = lastr_s_ser_blo
Open(wi_blocco_docum_wz)
li_retcode = 0
RETURN li_retcode

end function

on u_service.create
TriggerEvent( this, "constructor" )

end on

on u_service.destroy
TriggerEvent( this, "destructor" )
end on

