forward
global type uo_sp_trans from transaction
end type
end forward

global type uo_sp_trans from transaction
end type
global uo_sp_trans uo_sp_trans

type prototypes
subroutine sp_stampa_doc(long id_documento) RPCFUNC ALIAS FOR "~"dba~".~"sp_stampa_doc~""
subroutine sp_rinumera_righe_doc(long id_documento) RPCFUNC ALIAS FOR "~"dba~".~"sp_rinumera_righe_doc~""
subroutine triggers_on_off(string valore) RPCFUNC ALIAS FOR "~"dba~".~"triggers_on_off~""
subroutine sp_ges_numprog_datareg(long al_modo,long al_id_registro,ref long al_Num_Progr,ref date ad_Data_Registrazione,ref string as_Message,ref long al_Num_Progr_Min,ref long al_Num_Progr_Max,ref date ad_Data_Prec,ref date ad_Data_Succ,ref long al_id_Documento) RPCFUNC ALIAS FOR "~"dba~".~"sp_ges_numprog_datareg~""
subroutine sp_ver_numdoc_numprog(long al_id_registro,ref long al_Num_Progr,ref string as_Num_Doc,date ad_Data_Registrazione,ref string as_Message,ref decimal adc_Doc_Glob_Min,ref decimal adc_Doc_Glob_Max) RPCFUNC ALIAS FOR "~"dba~".~"sp_ver_numdoc_numprog~""
subroutine sp_setta_provvigioni(long al_id_sog_commerciale,long al_id_gruppo_agenti,long al_id_con_pagamento,long al_id_articolo) RPCFUNC ALIAS FOR "~"dba~".~"sp_setta_provvigioni~""
function long sf_pr1(long num_in) RPCFUNC ALIAS FOR "~"dba~".~"sf_pr1~""
subroutine sp_get_descr_locazione(long Locazione,ref string Descrizione) RPCFUNC ALIAS FOR "~"dba~".~"sp_get_descr_locazione~""
subroutine sp_prop_progr_registro(long Id_Registro,ref decimal Num_Progressivo,ref date Data_Registrazione) RPCFUNC ALIAS FOR "~"dba~".~"sp_prop_progr_registro~""
subroutine sp_prezzo_riferimento(long ID_Unita_Confezione,long id_listino,date dataref,ref decimal prezzo) RPCFUNC ALIAS FOR "~"dba~".~"sp_prezzo_riferimento~""
subroutine sp_prova(long pippo,ref decimal ll_ok) RPCFUNC ALIAS FOR "~"dba~".~"sp_prova~""
subroutine sp_proponi_num_reg_pd(long id_registro,ref long num_progressivo) RPCFUNC ALIAS FOR "~"dba~".~"sp_proponi_num_reg_pd~""
subroutine sp_caus_der(long ID_prof_der,long ID_riga_prov,ref long retv) RPCFUNC ALIAS FOR "~"dba~".~"sp_caus_der~""
subroutine sp_somma_scad_riga_dist(long ID_riga_distinta_banca) RPCFUNC ALIAS FOR "~"dba~".~"sp_somma_scad_riga_dist~""
subroutine sp_elimina_reg_pd(long id_reg_pd,ref long RetVal) RPCFUNC ALIAS FOR "~"dba~".~"sp_elimina_reg_pd~""
subroutine identity(ref long i_rtv) RPCFUNC ALIAS FOR "~"dba~".~"identity~""
subroutine sp_esi_disp_totali(long al_id_articolo,long al_id_esercizio,long al_id_azienda,long al_id_par_disponibilita,ref decimal ldc_esistenza,ref decimal ldc_disponibilita) RPCFUNC ALIAS FOR "~"dba~".~"sp_esi_disp_totali~""
subroutine sp_esi_disp_magazzino(long al_id_articolo,long al_id_magazzino,long al_id_esercizio,long al_id_azienda,long al_id_par_disponibilita,ref decimal ldc_esistenza,ref decimal ldc_disponibilita) RPCFUNC ALIAS FOR "~"dba~".~"sp_esi_disp_magazzino~""
subroutine sp_stato_doc(long ai_iddoc,string as_stato) RPCFUNC ALIAS FOR "~"dba~".~"sp_stato_doc~""
subroutine sp_calc_cpt(long al_idsc,long al_idar,long al_idag,string as_tipo,long al_idaz,ref long al_idconto,long al_id_causale) RPCFUNC ALIAS FOR "~"dba~".~"sp_calc_cpt~""
subroutine sp_aggiorna_scadenze(long ai_id_documento,long ai_id_reg_pd) RPCFUNC ALIAS FOR "~"dba~".~"sp_aggiorna_scadenze~""
subroutine sp_collega_conto(long ai_id_sog_commerciale,ref long ai_RetVal) RPCFUNC ALIAS FOR "~"dba~".~"sp_collega_conto~""
subroutine sp_mov_contabile_op(decimal Mov_Dare,decimal Mov_Avere,date Data_Inizio_Competenza,date Data_Fine_Competenza,date Data_Competenza,long Conto,long Esercizio,long ID_Mov_Contab) RPCFUNC ALIAS FOR "~"dba~".~"sp_mov_contabile_op~""
subroutine sp_aggiorna_reg_pd( char val,int azienda,date Data_Inizio,date Data_Fine,long prog) RPCFUNC ALIAS FOR "~"dba~".~"sp_aggiorna_reg_pd~""
subroutine sp_gest_causale(string Evento,date LaData,long ID_Esercizio,long ID_Attivita,long ID_Articolo,long ID_Locazione,decimal Anno,decimal Mese,decimal Qta,decimal Valore,decimal Prezzo,long ID_Caus_Magazzino,long id_unita_confezione,long ll_id_riga_doc_provenienza,decimal peso_netto) RPCFUNC ALIAS FOR "~"dba~".~"sp_gest_causale~""

subroutine sp_calc_iva_sc_art(long al_id_art,long al_id_sog,date ad_data,ref long al_id_tab_iva) RPCFUNC ALIAS FOR "~"dba~".~"sp_calc_iva_sc_art~""
subroutine sp_valorizzazioni(long id_attivita,string da_articolo,string a_articolo,long id_magazzino,long anno,long mese) RPCFUNC ALIAS FOR "~"dba~".~"sp_valorizzazioni~""
subroutine sp_trasf_dati(integer ai_tipo_trasferimento, integer ai_num_parte) RPCFUNC ALIAS FOR "~"dba~".~"sp_trasf_dati~""
subroutine sp_trasf_drop_tmp(integer ai_tipo_trasferimento) RPCFUNC ALIAS FOR "~"dba~".~"sp_trasf_drop_tmp~""
subroutine sp_ricalcolo_riepilogo() RPCFUNC ALIAS FOR "~"dba~".~"sp_ricalcolo_riepilogo~""
subroutine sp_trasf_aprii() RPCFUNC ALIAS FOR "~"dba~".~"sp_trasf_aprii~""
subroutine sp_drop() RPCFUNC ALIAS FOR "~"dba~".~"sp_drop~"" 
subroutine sp_create_index() RPCFUNC ALIAS FOR "~"dba~".~"sp_create_index~"" 
subroutine sp_tmp_iva(string as_test) RPCFUNC ALIAS FOR "~"dba~".~"sp_tmp_iva~""
subroutine sp_com_mov_automatico(long ai_id_bilancio, long ai_id_documento , string as_tipo_movimento , decimal ad_importo , long ai_id_articolo , long ai_id_riga_documento ) RPCFUNC ALIAS FOR "~"dba~".~"sp_com_mov_automatico~""
subroutine triggers_on_off(char valore) RPCFUNC ALIAS FOR "~"dba~".~"trigger_on_off~""

end prototypes

on uo_sp_trans.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on uo_sp_trans.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

