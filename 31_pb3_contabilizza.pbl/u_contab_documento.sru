forward
global type u_contab_documento from nonvisualobject
end type
end forward

global type u_contab_documento from nonvisualobject
end type
global u_contab_documento u_contab_documento

type variables
datastore 		ids_contab_documento
datastore 		ids_cast_cpt_documento
datastore 		ids_cast_iva_documento
datastore		ids_scadenza
uo_wizard	iuo_wizard
string		is_log_file = ".\contab.log"
u_reg_pd		iu_reg_pd
end variables

forward prototypes
public function long uf_esercizio_registro (long al_id_registro, ref string as_des_registro)
public function long uf_conto_sog_commerciale (long al_id_sog_commerciale, ref string as_sog_commerciale_cod)
public function decimal uf_per_aliquota (long al_id_tab_iva)
public function integer uf_aggiorna_contabilizzato (long al_id_documento)
public subroutine uf_aggiorna_scadenze (long al_id_documento, long al_id_reg_pd)
public subroutine uf_create_ds ()
public subroutine uf_destroy_ds ()
public function long uf_crea_reg_pd (long al_id_registro, long al_cprogr_dal, long al_cprogr_al, date ad_data_dal, date ad_data_al, string as_tipo_documento, ref string as_msg)
public function string uf_msg ()
public function long uf_prof_registrazione (long al_i, long al_id_documento)
public function long wf_crea_reg_pd (long al_id_registro, long al_cprogr_dal, long al_cprogr_al, date ad_data_dal, date ad_data_al, string as_tipo_documento, ref string as_msg, datawindow adw_tot_doc)
public subroutine uf_crea_cdc (integer ll_id_reg_pd, integer ll_id_documento)
end prototypes

public function long uf_esercizio_registro (long al_id_registro, ref string as_des_registro);

long ll_RetVal = 0

IF NOT IsNull(al_id_registro) THEN
	SELECT registro.id_esercizio,
	       registro.descrizione
		INTO :ll_RetVal,
		     :as_des_registro
		FROM registro
		WHERE registro.id_registro = :al_id_registro;

	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			MessageBox("Errore sul DataBase", "w_contab_documento_ff / uf_esercizio_registro / 1")
	END CHOOSE
END IF

RETURN ll_RetVal

end function

public function long uf_conto_sog_commerciale (long al_id_sog_commerciale, ref string as_sog_commerciale_cod);

long ll_RetVal = 0

IF (NOT IsNull(al_id_sog_commerciale)) AND (al_id_sog_commerciale > 0) THEN
	SELECT sog_commerciale.id_conto,
	       sog_commerciale.codice
		INTO :ll_RetVal,
		     :as_sog_commerciale_cod
		FROM sog_commerciale
		WHERE sog_commerciale.id_sog_commerciale = :al_id_sog_commerciale;

	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			MessageBox("Errore sul DataBase", "w_contab_documento_ff / uf_conto_sog_commerciale / 1")
	END CHOOSE
END IF

RETURN ll_RetVal
end function

public function decimal uf_per_aliquota (long al_id_tab_iva);

decimal ldc_RetVal

IF (al_id_tab_iva > 0) THEN
	SELECT tab_iva.per_aliquota
		INTO :ldc_RetVal
		FROM tab_iva
		WHERE tab_iva.id_tab_iva = :al_id_tab_iva;

	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			MessageBox("Errore sul DataBase","w_contab_documento_ff / uf_per_aliquota / 1")
	END CHOOSE

END IF

RETURN ldc_RetVal
end function

public function integer uf_aggiorna_contabilizzato (long al_id_documento);

integer li_RetVal = 0

IF al_id_documento > 0 THEN
	UPDATE dba.documento
		SET contabilizzato = 'S'
		WHERE documento.id_documento = :al_id_documento
		USING SQLCA;

	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			IF SQLCA.SQLNRows = 1 THEN
				COMMIT USING SQLCA;
			ELSE
				li_RetVal = -1
			END IF
		CASE -1
			MessageBox("Errore sul DataBase","w_contab_documento_ff / uf_aggiorna_contabilizzato / 1")
			li_RetVal = -1
	END CHOOSE

END IF

RETURN li_RetVal
end function

public subroutine uf_aggiorna_scadenze (long al_id_documento, long al_id_reg_pd);

SQLCA.sp_Aggiorna_Scadenze(al_id_documento, al_id_reg_pd)
end subroutine

public subroutine uf_create_ds ();

ids_contab_documento   = create datastore
ids_cast_cpt_documento = create datastore
ids_cast_iva_documento = create datastore

ids_contab_documento.DataObject   = "d_contab_documento_ds"
ids_cast_cpt_documento.DataObject = "d_cast_cpt_documento_ds"
ids_cast_iva_documento.DataObject ="d_cast_iva_documento_lt"

ids_contab_documento.SetTransObject(SQLCA)
ids_cast_cpt_documento.SetTransObject(SQLCA)
ids_cast_iva_documento.SetTransObject(SQLCA)

iuo_wizard = create uo_wizard
iu_reg_pd = create u_reg_pd
end subroutine

public subroutine uf_destroy_ds ();

IF IsValid(ids_contab_documento) THEN
	destroy ids_contab_documento
END IF

IF IsValid(ids_cast_cpt_documento) THEN
	destroy ids_cast_cpt_documento
END IF

IF IsValid(ids_cast_iva_documento) THEN
	destroy ids_cast_iva_documento
END IF

IF IsValid(iuo_wizard) THEN
	destroy iuo_wizard
END IF

IF IsValid(iu_reg_pd) THEN
	destroy iu_reg_pd
END IF
end subroutine

public function long uf_crea_reg_pd (long al_id_registro, long al_cprogr_dal, long al_cprogr_al, date ad_data_dal, date ad_data_al, string as_tipo_documento, ref string as_msg);

DECIMAL LDC_TOT

STRING LS_TEST
LONG YY,ll_id_avanzo_cambio
DECIMAL LD_SUPER_TOT

long ll_arr_conto
string ls_tipo_arr_conto 

long ll_id_val_euro, ll_id_val_az

DECIMAL LD_CAMBIO_APPOGGIO
LONG IL_ARROTONDAMENTO
STRING IS_TIPO_ARROTONDAMENTO

decimal ldc_acc
long ll_iva_acc

decimal ldc_omaggi
long ll_id_pv, ll_id_mc, ll_nr, ll_sog_v, ll_par_v
long 		ll_id_documento, ll_righe_doc, ll_j, ll_id_prof_registrazione, &
			ll_num_progressivo, ll_id_valuta, ll_id_conto, ll_id_sog_commerciale, ll_id_azienda, &
			ll_righe_cast_cpt, ll_righe_cast_iva, ll_k, ll_l, ll_id_tab_iva[], ll_id_conto_mc[], &
			ll_id_esercizio, ll_NULL[], ll_id_reg_pd, ll_righe_iva, ll_righe_mc, ll_NULL_array[], &
			ll_id_prof_documento, ll_Esito, ll_RetVal = 0
string 	ls_num_documento, ls_des_contabile, ls_ErrText, ls_RifDoc, ls_des_registro, &
			ls_sog_commerciale_cod, ls_sog_commerciale_des, ls_header, ls_footer, ls_fat_anticipo
date 		ld_data_registrazione, ld_data_documento, ld_data_competenza
decimal 	ldc_cambio, ldc_NULL, ldc_tot_documento, ldc_imponibile[], ldc_imposta[], &
			ldc_importo_mc[], ldc_per_aliquota, ldc_val_imp_scontato, ldc_spese, ldc_NULL_array[], LDC_ACCONTO
char 		lc_segno_mc[], lc_tipo_fattura, lc_NULL_array[]
integer 	li_segno_iva, li_Scelta, i
boolean 	lb_Procedi = TRUE, lb_mc_iva[]
long 		ll_id_con_acconto
long	   ll_id_sog_commerciale_vettore	
long		ll_id_conto_v 
string 	ls_prog_scritture
long   	ll_id_registro
long		ll_id_reg_pd_vettore
ll_sog_v=0

CONSTANT STRING LCS_NEWLINE = char(13)+Char(10)

SetNull(ldc_NULL)
as_msg = ""

ids_contab_documento.Retrieve(al_id_registro, al_cprogr_dal, al_cprogr_al, ad_data_dal, ad_data_al)
ll_righe_doc = ids_contab_documento.RowCount()
IF ll_righe_doc > 0 THEN

	u_debug.uf_log_open(is_log_file, 1, TRUE)
	ls_header = "***************** Inizio Contabilizzazione " + String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + " *****************"
	u_debug.uf_log_msg(1, ls_header)
	u_debug.uf_log_msg(1, " ")

	as_msg = as_msg + ls_header + LCS_NEWLINE
	
	FOR ll_j = 1 TO ll_righe_doc
		
		ll_id_conto_mc = ll_NULL_array
		ldc_importo_mc = ldc_NULL_array
		lc_segno_mc    = lc_NULL_array
		ldc_imponibile = ldc_NULL_array
		ldc_imposta    = ldc_NULL_array
		ll_id_tab_iva  = ll_NULL_array

		
		ll_id_documento          = ids_contab_documento.GetItemNumber(ll_j, "id_documento")
		lc_tipo_fattura          = ids_contab_documento.GetItemString(ll_j, "documento_tipo_fattura")
      ll_righe_mc              = ids_cast_cpt_documento.Retrieve(ll_id_documento, as_tipo_documento, lc_tipo_fattura)
		ll_righe_iva             = ids_cast_iva_documento.Retrieve(ll_id_documento)
		ll_id_prof_registrazione = uf_prof_registrazione(ll_j, ll_id_documento)
		ll_id_esercizio          = uf_esercizio_registro(al_id_registro, ls_des_registro)
		ll_num_progressivo       = ids_contab_documento.GetItemNumber(ll_j, "num_progressivo")
		ld_data_registrazione    = ids_contab_documento.GetItemDate(ll_j, "data_registrazione")
		ld_data_competenza       = ids_contab_documento.GetItemDate(ll_j, "documento_data_competenza")
		ls_num_documento         = ids_contab_documento.GetItemString(ll_j, "documento_num_documento")
		ld_data_documento        = ids_contab_documento.GetItemDate(ll_j, "documento_data_documento")
		ls_des_contabile         = ids_contab_documento.GetItemString(ll_j, "documento_des_contabile")
		ll_id_valuta             = ids_contab_documento.GetItemNumber(ll_j, "documento_id_valuta")
		ldc_cambio               = ids_contab_documento.GetItemDecimal(ll_j, "documento_cambio")
		ldc_acconto 				 =0
		
		
		select id_val_euro
		into :ll_id_val_euro
		from par_sistema;
		select id_valuta
		into :ll_id_val_az
		from esercizio
		where id_esercizio=:ll_id_esercizio;
		//20211020 cambio il cambio, prima era parita nel doc e quindi andava reciproco in contabilità, ora è cambio anche in magazzino
//		if ll_id_val_euro=ll_id_val_az then
//			ldc_cambio=1/ldc_cambio
//		end if
		
		ll_id_sog_commerciale_vettore	= ids_contab_documento.GetItemNumber(ll_j, "documento_id_sog_commerciale_vettore")	
		ldc_acc                  = ids_contab_documento.GetItemdecimal(ll_j, "imp_acconto")
		ll_iva_acc					 = ids_contab_documento.GetItemnumber(ll_j, "id_tab_iva_acconto")
		
		IF ids_cast_cpt_documento.RowCount() > 0 THEN
			ldc_tot_documento = ids_cast_cpt_documento.GetItemDecimal(1, "tot_documento")
			
			ldc_omaggi = ids_cast_cpt_documento.GetItemDecimal(1, "tot_omaggi")
			
			
			
			ll_id_prof_documento=ids_contab_documento.GetItemNumber(ll_j, "documento_id_prof_documento")
			select fat_anticipo
			into :ls_fat_anticipo
			from prof_documento
			where id_prof_documento=:ll_id_prof_documento;
			if isnull(ls_fat_anticipo) then ls_fat_anticipo='N'
			if not (ls_fat_anticipo='S' ) then
				select id_cont_gen_acconto
				into :ll_id_con_acconto
				from par_sistema;
				select id_conto_avanzo_cambio
				into :ll_id_avanzo_cambio
				from orafo_par_sistema;
				if ll_id_con_acconto > 0 then
					for i = 1 to ids_cast_cpt_documento.rowcount()
						ll_id_conto=ids_cast_cpt_documento.getitemnumber(i, "id_conto")
						if ll_id_conto=ll_id_con_acconto or ll_id_conto=ll_id_avanzo_cambio then
							ldc_acconto=ids_cast_cpt_documento.getitemdecimal(i, "val_imponibile")
							ldc_tot_documento=ldc_tot_documento - ldc_acconto
						
						end if
					next
				end if
			end if
			
		END IF
		ll_id_sog_commerciale    = ids_contab_documento.GetItemNumber(ll_j, "documento_id_sog_commerciale")
		ll_id_conto              = uf_conto_sog_commerciale(ll_id_sog_commerciale, ls_sog_commerciale_cod)

		IF IsNull(ll_id_conto) OR (ll_id_conto = 0) THEN
         li_Scelta = MessageBox("Contabilizzazione Documenti", "Attenzione: Il Soggetto Commerciale con codice " + ls_sog_commerciale_cod + " non ha un conto collegato.~rCollegarlo Automaticamente? Scegliendo No la contabilizzazione verrà interrota.", Question!, YesNo!)

			CHOOSE CASE li_Scelta
				CASE 1
					SQLCA.sp_Collega_Conto(ll_id_sog_commerciale, ll_Esito)
					IF ll_Esito <> 0 THEN
                  MessageBox("Contabilizzazione Documenti", "Impossibile collegare il conto al Soggetto Commerciale.~rContabilizzazione interrotta.", StopSign!)
						lb_Procedi = FALSE
					END IF

				CASE 2
               MessageBox("Contabilizzazione Documenti", "Contabilizzazione interrotta.", StopSign!)
					lb_Procedi = FALSE
			END CHOOSE
		END IF

		
		
		
		
		SELECT cambio, dec_significativi, tipo_arrotondamento
		INTO :ld_cambio_appoggio, :il_arrotondamento, :is_tipo_arrotondamento 
		FROM valuta	WHERE id_valuta=:ll_id_valuta;
		
		
		SELECT dec_significativi, tipo_arrotondamento
		INTO :ll_arr_conto, :ls_tipo_arr_conto 
		FROM valuta	WHERE id_valuta=:ll_id_val_az;
		ids_cast_iva_documento.Modify("c_cambio_text.text = '" + String(Ldc_cambio) + "'")
		ids_cast_iva_documento.Modify("c_arrotondamento_text.text = '" + String(il_arrotondamento) + "'")
		
		ids_cast_iva_documento.Modify("c_arrotondamento_text_v_conto.text = '" + String(ll_arr_conto) + "'")
		ids_cast_iva_documento.Modify("c_tipo_arrotondamento.text = '" + ls_tipo_arr_conto + "'")
		

		IF lb_Procedi = TRUE THEN
			ll_id_azienda            = ids_contab_documento.GetItemNumber(ll_j, "documento_id_azienda")

			
			ll_righe_cast_iva = ids_cast_iva_documento.RowCount()
			IF ll_righe_cast_iva > 0 THEN
				FOR ll_k = 1 TO ll_righe_cast_iva
					ll_id_tab_iva[ll_k] = ids_cast_iva_documento.GetItemNumber(ll_k, "id_tab_iva")
					
					
					
					if ll_id_tab_iva[ll_k] = ll_iva_acc and ldc_acc>0 then
						ids_cast_iva_documento.setItem(ll_k, "cc_acconto",ldc_acc)
					end if 
					ldc_val_imp_scontato = ids_cast_iva_documento.GetItemDecimal(ll_k, "val_imp_scontato")
					IF IsNull(ldc_val_imp_scontato) THEN ldc_val_imp_scontato = 0

					ldc_spese = ids_cast_iva_documento.GetItemDecimal(ll_k, "val_spese")
					IF IsNull(ldc_spese) THEN ldc_spese = 0

					ldc_imponibile[ll_k] =ids_cast_iva_documento.getitemdecimal(ll_k, "val_tot_imp_l")

					ldc_per_aliquota = uf_per_aliquota(ll_id_tab_iva[ll_k])
												
					ldc_imposta[ll_k] = ids_cast_iva_documento.getitemdecimal(ll_k, "c_iva_lire")
				NEXT

			END IF

			
			ll_righe_cast_cpt = ids_cast_cpt_documento.RowCount()
			IF ll_righe_cast_cpt > 0 THEN
				FOR ll_l = 1 TO ll_righe_cast_cpt
					ll_id_conto_mc[ll_l] = ids_cast_cpt_documento.GetItemNumber(ll_l, "id_conto")
					lc_segno_mc[ll_l] = ids_cast_cpt_documento.GetItemString(ll_l, "segno")
					ldc_importo_mc[ll_l] = ids_cast_cpt_documento.GetItemDecimal(ll_l, "val_imp_scontato") + &
												  ids_cast_cpt_documento.GetItemDecimal(ll_l, "val_spese")
					IF ids_cast_cpt_documento.GetItemString(ll_l, "tipo_riga_cpt") = "I" THEN
						lb_mc_iva[ll_l] = TRUE
					ELSE
						lb_mc_iva[ll_l] = FALSE
					END IF
				NEXT
			END IF

			
			SELECT reg_pd.id_reg_pd
				INTO :ll_id_reg_pd
				FROM dba.reg_pd
				WHERE (reg_pd.num_progressivo = :ll_num_progressivo) AND
						(reg_pd.data_registrazione = :ld_data_registrazione) AND
						(reg_pd.id_registro = :al_id_registro)
				USING SQLCA;

			CHOOSE CASE SQLCA.SQLCode
				CASE 100

					
						
					iu_reg_pd.uf_DisplayMode(0)
					iu_reg_pd.uf_Reset()
					iu_reg_pd.uf_id_prof_registrazione(ll_id_prof_registrazione)
					iu_reg_pd.uf_id_esercizio(ll_id_esercizio)
					iu_reg_pd.uf_id_registro(al_id_registro)
					iu_reg_pd.uf_num_progressivo(ll_num_progressivo)
					iu_reg_pd.uf_data_registrazione(ld_data_registrazione)
					iu_reg_pd.uf_data_competenza(ld_data_competenza)
					iu_reg_pd.uf_descrizione(ls_des_contabile)
					
					
					
					
					
					
					
					
					iu_reg_pd.uf_id_valuta(ll_id_valuta)
					iu_reg_pd.uf_cambio(ldc_cambio)
					
					iu_reg_pd.uf_importo(ldc_tot_documento - ldc_omaggi)
					iu_reg_pd.uf_id_conto(ll_id_conto)
					iu_reg_pd.uf_num_documento(ls_num_documento)
					iu_reg_pd.uf_data_documento(ld_data_documento)
					iu_reg_pd.uf_tipo_fattura(lc_tipo_fattura)
					iu_reg_pd.uf_id_azienda(ll_id_azienda)
					
					
					long ll_id_tab_iva_app
					string ls_ges_intra
					
					select id_tab_iva
					into :ll_id_tab_iva_app
					from sog_commerciale
					where id_sog_commerciale = :ll_id_sog_commerciale;
					
					select ges_oper_intracomunitarie
					into :ls_ges_intra
					from tab_iva
					where id_tab_iva = :ll_id_tab_iva_app;
					if isnull(ls_ges_intra) or ls_ges_intra = '' then ls_ges_intra = 'N'
					
					iu_reg_pd.uf_ges_oper_intracomunitarie(ls_ges_intra)					
					
					
					
					iu_reg_pd.uf_imponibile(ldc_imponibile)
					iu_reg_pd.uf_id_tab_iva(ll_id_tab_iva)
					iu_reg_pd.uf_imposta(ldc_imposta)
					
					
					SELECT GEST_CPT_SCONTI INTO :LS_TEST FROM PAR_SISTEMA;
					IF LS_TEST='S' THEN 

						LD_SUPER_TOT=0
						FOR YY=1 TO UPPERBOUND(ldc_imponibile)
							LD_SUPER_TOT = LD_SUPER_TOT + ldc_imponibile[YY] + ldc_impoSTA[YY]
						NEXT
						iu_reg_pd.uf_importo(LD_SUPER_TOT)
					END IF	
					
					
					
					iu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
					iu_reg_pd.uf_segno_mc(lc_segno_mc)
					iu_reg_pd.uf_importo_mc(ldc_importo_mc)
					iu_reg_pd.uf_mc_iva(lb_mc_iva)
					
					
					ll_id_reg_pd = iu_reg_pd.uf_crea()
					
					
					string ls_app,ls_tipo_registro
					u_liq_provvigioni lo_liq_provv
					if ll_id_reg_pd>0 then
						select tipo_registro
						into   :ls_tipo_registro
						from   registro
						where  id_registro= :al_id_registro;
						ls_app= right(ls_tipo_registro, 1)
						if ls_app='V' then
							lo_liq_provv=create u_liq_provvigioni
							lo_liq_provv.uf_liq_provvigioni(ll_id_documento)
							destroy lo_liq_provv
							
							
							
							
							
							
							SELECT MIN(id_prof_reg_dare)
							INTO	 :ll_id_prof_registrazione
							FROM	 scadenza s, tipo_pagamento t
							WHERE  s.id_documento = :ll_id_documento
							AND    t.id_tipo_pagamento = s.id_tipo_pagamento
							;
							
							if (ll_id_prof_registrazione > 0) then
								
								ll_id_registro = f_proponi_registro(ll_id_prof_registrazione, ll_id_esercizio)
									
								SELECT prog_scritture
								INTO 	 :ls_prog_scritture
								FROM 	 esercizio
								WHERE  id_esercizio = :ll_id_esercizio
								;									
									
								ll_num_progressivo = f_proponi_num_reg_pd(ll_id_registro, ls_prog_scritture)
									
								
								SELECT sc.id_sog_commerciale, sc.id_conto
								INTO	 :ll_id_sog_commerciale, :ll_id_conto_v
								FROM	 sog_commerciale sv, sog_commerciale sc
								WHERE	 sv.id_sog_commerciale = :ll_id_sog_commerciale_vettore
								AND	 sc.id_anagrafica =sv.id_anagrafica
								AND	 sc.tipo = 'C'
								;

								if (ll_id_conto_v > 0 and ll_id_sog_commerciale > 0) then
									
									SELECT reg_pd.id_reg_pd
									INTO 	 :ll_id_reg_pd_vettore
									FROM 	 reg_pd
									WHERE  (reg_pd.num_progressivo = :ll_num_progressivo) AND
											 (reg_pd.data_registrazione = :ld_data_registrazione) AND
											 (reg_pd.id_registro = :ll_id_registro)
									USING  SQLCA
									;
		
									CHOOSE CASE SQLCA.SQLCode
										CASE 100
											
											ll_id_conto_mc = ll_NULL_array
											ldc_importo_mc = ldc_NULL_array
											lc_segno_mc    = lc_NULL_array
												
											
											ldc_tot=0
											ll_id_conto_mc[1] = ll_id_conto_v
											lc_segno_mc[1] 	= 'D'
											
											for YY=1 to upperbound(ldc_imponibile)
												 ldc_tot=ldc_tot + ldc_imponibile[YY]
											next	 
											for YY=1 to upperbound(ldc_imposta)
												 ldc_tot=ldc_tot + ldc_imposta[YY]
											next	 
											ldc_importo_mc[1] = ldc_tot
											ll_id_conto_mc[2] = ll_id_conto
											lc_segno_mc[2] 	= 'A'
											ldc_importo_mc[2] = ldc_tot
										   
										
											
						
											iu_reg_pd.uf_DisplayMode(0)
											iu_reg_pd.uf_Reset()
											iu_reg_pd.uf_id_prof_registrazione(ll_id_prof_registrazione)
											iu_reg_pd.uf_id_esercizio(ll_id_esercizio)
											iu_reg_pd.uf_id_registro(ll_id_registro)
											iu_reg_pd.uf_num_progressivo(ll_num_progressivo)
											iu_reg_pd.uf_data_registrazione(ld_data_registrazione)
											iu_reg_pd.uf_data_competenza(ld_data_competenza)
											iu_reg_pd.uf_descrizione(ls_des_contabile)
											iu_reg_pd.uf_id_valuta(ll_id_valuta)
											iu_reg_pd.uf_cambio(ldc_cambio)

											iu_reg_pd.uf_num_documento(ls_num_documento)
											iu_reg_pd.uf_data_documento(ld_data_documento)
											iu_reg_pd.uf_tipo_fattura(lc_tipo_fattura)
											iu_reg_pd.uf_id_azienda(ll_id_azienda)
												
										
											
											iu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
											iu_reg_pd.uf_segno_mc(lc_segno_mc)
											iu_reg_pd.uf_importo_mc(ldc_importo_mc)
											iu_reg_pd.uf_mc_iva(lb_mc_iva)
												
											
											ll_id_reg_pd_vettore = iu_reg_pd.uf_crea()
											
											
											
											
											long aa
											select max(id_par_aperta) into :aa from par_aperta where id_reg_pd=:ll_id_reg_pd_vettore;
											delete from scadenza where id_par_aperta=:aa;
											delete from par_aperta where id_par_aperta in ( select max(id_par_aperta) from par_aperta where id_reg_pd=:ll_id_reg_pd_vettore);
											
											
											select id_par_aperta into :ll_id_pv
											from par_aperta where id_reg_pd=:ll_id_reg_pd;
											IF sqlca.sqlcode=0 then
													select id_mov_contabile, numero into :ll_id_mc, :ll_nr
													from mov_contabile where id_reg_pd=:ll_id_reg_pd_vettore
													and id_conto=:ll_id_conto_mc[1];
													
													 INSERT INTO mov_partita
																	(id_par_aperta,            id_mov_contabile,    	id_reg_pd,
				  													 num_riga_mov_contabile,   data,                	importo,
				  													 id_azienda )
	  													  VALUES (:ll_id_pv,               :ll_id_mc,           		:ll_id_reg_pd_vettore,
				  													 :ll_nr,                  :ld_data_registrazione,  :ldc_tot,
				  													 :ll_id_azienda)  ;
																		
													 update par_aperta set stato='C' where id_par_aperta=:ll_id_pv;
													 
											END IF
											update par_aperta set id_conto=:ll_id_conto_v where id_reg_pd=:ll_id_reg_pd_vettore;
											select id_par_aperta into :ll_par_v from par_aperta where id_reg_pd=:ll_id_reg_pd_vettore;
											
											select id_sog_commerciale into :ll_sog_v
											from sog_commerciale where id_conto=:ll_id_conto_v;
											
											
									END CHOOSE
								end if
								
							end if
						end if
					end if
					
					IF ll_id_reg_pd > 0 THEN
						iuo_wizard.uf_start(ll_id_reg_pd)
						uf_aggiorna_contabilizzato(ll_id_documento)
						uf_aggiorna_scadenze(ll_id_documento, ll_id_reg_pd)
					END IF
					
					If ll_sog_v>0 then
						
						
						delete from scadenza
						
						where id_par_aperta=:ll_id_pv;
					END IF						
					
						
					ls_RifDoc = "Registro: '" + ls_des_registro + "' Progressivo: " + string(ll_num_progressivo) + " Data: " + string(ld_data_registrazione, "dd/mm/yyyy") + " (" + string(ll_id_documento) + ") ==> "

					CHOOSE CASE ll_id_reg_pd
						CASE IS > 0
							ls_ErrText = "OK"
						CASE -1
							ls_ErrText = "Movimenti contabili non bilanciati o con totali a zero."
						CASE -2
							ls_ErrText = "Il numero degli elementi non è uguale per tutti gli array dei movimenti contabili."
						CASE -3
							ls_ErrText = "L'ID del profilo registrazione non è valido."
						CASE -4
							ls_ErrText = "L'ID dell'esercizio passato è zero o nullo e l'azienda corrente non ha un esercizio impostato."
						CASE -5
							ls_ErrText = "Non esiste un profilo con l'ID passato."
						CASE ELSE
							ls_ErrText = "Errore generico durante la contabilizzazione."
					END CHOOSE

				CASE 0
					ls_RifDoc = "Registro: '" + ls_des_registro + "' Progressivo: " + string(ll_num_progressivo) + " Data: " + string(ld_data_registrazione, "dd/mm/yyyy") + " (" + string(ll_id_documento) + ") ==> "
					ls_ErrText = "Registrazione già esistente."
			END CHOOSE
		
			u_debug.uf_log_msg(1, ls_RifDoc + ls_ErrText)
			as_msg = as_msg + ls_RifDoc + ls_ErrText + LCS_NEWLINE
		ELSE
			ll_j = ll_righe_doc
			ll_RetVal = -1
		END IF
	NEXT
	
	
	
	string ls_cc
	select centri_costo
	into :ls_cc
	from pers_par_sistema;
	if ls_cc='S' then	uf_crea_cdc(ll_id_reg_pd,ll_id_documento)
	
	
	
	u_debug.uf_log_msg(1, " ")
	ls_footer = "****************** Fine Contabilizzazione " + String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + " ******************"
	u_debug.uf_log_msg(1, ls_footer)
	u_debug.uf_log_close(1)

	as_msg = as_msg + ls_footer + LCS_NEWLINE
END IF

RETURN ll_RetVal
end function

public function string uf_msg ();

long ll_FLength
string ls_RetVal
integer li_FHandle

li_FHandle = FileOpen(is_log_file, StreamMode!, Read!, LockReadWrite!)
ll_FLength = FileLength(is_log_file)

IF li_FHandle <> -1 THEN
	IF ll_FLength < 32767 THEN
		FileRead(li_FHandle, ls_RetVal)
		FileClose(li_FHandle)
	ELSE
		ls_RetVal = "Il file " + is_log_file + "contenente l'esito della contabilizzazione è troppo esteso per essere visualizzato."
	END IF
ELSE
	ls_RetVal = "Errore durante la lettura del file " + is_log_file + " contenente l'esito della contabilizzazione."
END IF

RETURN ls_RetVal
end function

public function long uf_prof_registrazione (long al_i, long al_id_documento);

long ll_RetVal = 0

ll_RetVal = ids_contab_documento.GetItemNumber(al_i, "id_prof_registrazione")

IF IsNull(ll_RetVal) THEN
	ll_RetVal = ids_contab_documento.GetItemNumber(al_i, "prof_documento_id_prof_registrazione")
	IF IsNull(ll_RetVal) THEN ll_RetVal = 0

	SELECT prof_documento.id_prof_registrazione
		INTO :ll_RetVal
		FROM dba.prof_documento,
			  dba.documento
		WHERE (prof_documento.id_prof_documento = documento.id_prof_documento) AND
				(documento.id_documento = :al_id_documento);

	CHOOSE CASE SQLCA.SQLCode
		CASE 100
			ll_RetVal = 0
		CASE -1
			MessageBox("Errore sul DataBase","w_contab_documento_ff / uf_prof_registrazione / 1")
	END CHOOSE
END IF

RETURN ll_RetVal
end function

public function long wf_crea_reg_pd (long al_id_registro, long al_cprogr_dal, long al_cprogr_al, date ad_data_dal, date ad_data_al, string as_tipo_documento, ref string as_msg, datawindow adw_tot_doc);

long 		ll_id_documento, ll_righe_doc, ll_j, ll_id_prof_registrazione, &
			ll_num_progressivo, ll_id_valuta, ll_id_conto, ll_id_sog_commerciale, ll_id_azienda, &
			ll_righe_cast_cpt, ll_righe_cast_iva, ll_k, ll_l, ll_id_tab_iva[], ll_id_conto_mc[], &
			ll_id_esercizio, ll_NULL[], ll_id_reg_pd, ll_righe_iva, ll_righe_mc, ll_NULL_array[], &
			ll_id_prof_documento, ll_Esito, ll_RetVal = 0
string 	ls_num_documento, ls_des_contabile, ls_ErrText, ls_RifDoc, ls_des_registro, &
			ls_sog_commerciale_cod, ls_sog_commerciale_des, ls_header, ls_footer
date 		ld_data_registrazione, ld_data_documento, ld_data_competenza
decimal 	ldc_cambio, ldc_NULL, ldc_tot_documento, ldc_imponibile[], ldc_imposta[], &
			ldc_importo_mc[], ldc_per_aliquota, ldc_val_imp_scontato, ldc_spese, ldc_NULL_array[]
char 		lc_segno_mc[], lc_tipo_fattura, lc_NULL_array[]
integer 	li_segno_iva, li_Scelta
boolean 	lb_Procedi = TRUE, lb_mc_iva[]
CONSTANT STRING LCS_NEWLINE = Char(10)

SetNull(ldc_NULL)
as_msg = ""

ids_contab_documento.Retrieve(al_id_registro, al_cprogr_dal, al_cprogr_al, ad_data_dal, ad_data_al)
ll_righe_doc = ids_contab_documento.RowCount()
IF ll_righe_doc > 0 THEN

	u_debug.uf_log_open(is_log_file, 1, TRUE)
	ls_header = "***************** Inizio Contabilizzazione " + String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + " *****************"
	u_debug.uf_log_msg(1, ls_header)
	u_debug.uf_log_msg(1, " ")

	as_msg = as_msg + ls_header + LCS_NEWLINE

	FOR ll_j = 1 TO ll_righe_doc
		
		ll_id_conto_mc = ll_NULL_array
		ldc_importo_mc = ldc_NULL_array
		lc_segno_mc    = lc_NULL_array
		ldc_imponibile = ldc_NULL_array
		ldc_imposta    = ldc_NULL_array
		ll_id_tab_iva  = ll_NULL_array

		
		ll_id_documento          = ids_contab_documento.GetItemNumber(ll_j, "id_documento")
		lc_tipo_fattura          = ids_contab_documento.GetItemString(ll_j, "documento_tipo_fattura")
      ll_righe_mc              = ids_cast_cpt_documento.Retrieve(ll_id_documento, as_tipo_documento, lc_tipo_fattura)
		ll_righe_iva             = ids_cast_iva_documento.Retrieve(ll_id_documento)
		ll_id_prof_registrazione = uf_prof_registrazione(ll_j, ll_id_documento)
		ll_id_esercizio          = uf_esercizio_registro(al_id_registro, ls_des_registro)
		ll_num_progressivo       = ids_contab_documento.GetItemNumber(ll_j, "num_progressivo")
		ld_data_registrazione    = ids_contab_documento.GetItemDate(ll_j, "data_registrazione")
		ld_data_competenza       = ids_contab_documento.GetItemDate(ll_j, "documento_data_competenza")
		ls_num_documento         = ids_contab_documento.GetItemString(ll_j, "documento_num_documento")
		ld_data_documento        = ids_contab_documento.GetItemDate(ll_j, "documento_data_documento")
		ls_des_contabile         = ids_contab_documento.GetItemString(ll_j, "documento_des_contabile")
		ll_id_valuta             = ids_contab_documento.GetItemNumber(ll_j, "documento_id_valuta")
		ldc_cambio               = ids_contab_documento.GetItemDecimal(ll_j, "documento_cambio")
		IF ids_cast_cpt_documento.RowCount() > 0 THEN
			ldc_tot_documento = adw_tot_doc.getitemdecimal(1, "tot_documento_lire")
			
		END IF
		ll_id_sog_commerciale    = ids_contab_documento.GetItemNumber(ll_j, "documento_id_sog_commerciale")
		ll_id_conto              = uf_conto_sog_commerciale(ll_id_sog_commerciale, ls_sog_commerciale_cod)

		IF IsNull(ll_id_conto) OR (ll_id_conto = 0) THEN
         li_Scelta = MessageBox("Contabilizzazione Documenti", "Attenzione: Il Soggetto Commerciale con codice " + ls_sog_commerciale_cod + " non ha un conto collegato.~rCollegarlo Automaticamente? Scegliendo No la contabilizzazione verrà interrota.", Question!, YesNo!)

			CHOOSE CASE li_Scelta
				CASE 1
					SQLCA.sp_Collega_Conto(ll_id_sog_commerciale, ll_Esito)
					IF ll_Esito <> 0 THEN
                  MessageBox("Contabilizzazione Documenti", "Impossibile collegare il conto al Soggetto Commerciale.~rContabilizzazione interrotta.", StopSign!)
						lb_Procedi = FALSE
					END IF

				CASE 2
               MessageBox("Contabilizzazione Documenti", "Contabilizzazione interrotta.", StopSign!)
					lb_Procedi = FALSE
			END CHOOSE
		END IF

		IF lb_Procedi = TRUE THEN
			ll_id_azienda            = ids_contab_documento.GetItemNumber(ll_j, "documento_id_azienda")

			
			ll_righe_cast_iva = ids_cast_iva_documento.RowCount()
			IF ll_righe_cast_iva > 0 THEN
				FOR ll_k = 1 TO ll_righe_cast_iva
					ll_id_tab_iva[ll_k] = ids_cast_iva_documento.GetItemNumber(ll_k, "id_tab_iva")

					

					
					ldc_val_imp_scontato = ids_cast_iva_documento.GetItemDecimal(ll_k, "val_imp_scontato")
					IF IsNull(ldc_val_imp_scontato) THEN ldc_val_imp_scontato = 0

					ldc_spese = ids_cast_iva_documento.GetItemDecimal(ll_k, "val_spese")
					IF IsNull(ldc_spese) THEN ldc_spese = 0

					
					ldc_imponibile[ll_k] =ids_cast_iva_documento.getitemdecimal(ll_k, "val_tot_imp_l")

					
					ldc_per_aliquota = uf_per_aliquota(ll_id_tab_iva[ll_k])
					ldc_imposta[ll_k] = Round(((ldc_imponibile[ll_k] / 100) * ldc_per_aliquota), 0)
				NEXT
			END IF

			
			ll_righe_cast_cpt = ids_cast_cpt_documento.RowCount()
			IF ll_righe_cast_cpt > 0 THEN
				FOR ll_l = 1 TO ll_righe_cast_cpt
					ll_id_conto_mc[ll_l] = ids_cast_cpt_documento.GetItemNumber(ll_l, "id_conto")
					lc_segno_mc[ll_l] = ids_cast_cpt_documento.GetItemString(ll_l, "segno")
					ldc_importo_mc[ll_l] = ids_cast_cpt_documento.GetItemDecimal(ll_l, "val_imp_scontato") + &
												  ids_cast_cpt_documento.GetItemDecimal(ll_l, "val_spese")
					IF ids_cast_cpt_documento.GetItemString(ll_l, "tipo_riga_cpt") = "I" THEN
						lb_mc_iva[ll_l] = TRUE
					ELSE
						lb_mc_iva[ll_l] = FALSE
					END IF
				NEXT
			END IF

			
			SELECT reg_pd.id_reg_pd
				INTO :ll_id_reg_pd
				FROM dba.reg_pd
				WHERE (reg_pd.num_progressivo = :ll_num_progressivo) AND
						(reg_pd.data_registrazione = :ld_data_registrazione) AND
						(reg_pd.id_registro = :al_id_registro)
				USING SQLCA;

			CHOOSE CASE SQLCA.SQLCode
				CASE 100
					
						
					iu_reg_pd.uf_DisplayMode(0)
					iu_reg_pd.uf_Reset()
					iu_reg_pd.uf_id_prof_registrazione(ll_id_prof_registrazione)
					iu_reg_pd.uf_id_esercizio(ll_id_esercizio)
					iu_reg_pd.uf_id_registro(al_id_registro)
					iu_reg_pd.uf_num_progressivo(ll_num_progressivo)
					iu_reg_pd.uf_data_registrazione(ld_data_registrazione)
					iu_reg_pd.uf_data_competenza(ld_data_competenza)
					iu_reg_pd.uf_descrizione(ls_des_contabile)
					iu_reg_pd.uf_id_valuta(ll_id_valuta)
					iu_reg_pd.uf_cambio(ldc_cambio)
					iu_reg_pd.uf_importo(ldc_tot_documento)
					iu_reg_pd.uf_id_conto(ll_id_conto)
					iu_reg_pd.uf_num_documento(ls_num_documento)
					iu_reg_pd.uf_data_documento(ld_data_documento)
					iu_reg_pd.uf_tipo_fattura(lc_tipo_fattura)
					iu_reg_pd.uf_id_azienda(ll_id_azienda)
					
					
					iu_reg_pd.uf_imponibile(ldc_imponibile)
					iu_reg_pd.uf_id_tab_iva(ll_id_tab_iva)
					iu_reg_pd.uf_imposta(ldc_imposta)
					
					
					iu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
					iu_reg_pd.uf_segno_mc(lc_segno_mc)
					iu_reg_pd.uf_importo_mc(ldc_importo_mc)
					iu_reg_pd.uf_mc_iva(lb_mc_iva)
					
					
					ll_id_reg_pd = iu_reg_pd.uf_crea()
					
					
					string ls_app,ls_tipo_registro
					u_liq_provvigioni lo_liq_provv
					if ll_id_reg_pd>0 then
						select tipo_registro
						into :ls_tipo_registro
						from registro
						where id_registro= :al_id_registro;
						ls_app= right(ls_tipo_registro, 1)
						if ls_app='V' then
							lo_liq_provv=create u_liq_provvigioni
							lo_liq_provv.uf_liq_provvigioni(ll_id_documento)
							destroy lo_liq_provv
						end if
					end if
					
					IF ll_id_reg_pd > 0 THEN
						iuo_wizard.uf_start(ll_id_reg_pd)
						uf_aggiorna_contabilizzato(ll_id_documento)
						uf_aggiorna_scadenze(ll_id_documento, ll_id_reg_pd)
					END IF

					ls_RifDoc = "Registro: '" + ls_des_registro + "' Progressivo: " + string(ll_num_progressivo) + " Data: " + string(ld_data_registrazione, "dd/mm/yyyy") + " (" + string(ll_id_documento) + ") ==> "

					CHOOSE CASE ll_id_reg_pd
						CASE IS > 0
							ls_ErrText = "OK"
						CASE -1
							ls_ErrText = "Movimenti contabili non bilanciati o con totali a zero."
						CASE -2
							ls_ErrText = "Il numero degli elementi non è uguale per tutti gli array dei movimenti contabili."
						CASE -3
							ls_ErrText = "L'ID del profilo registrazione non è valido."
						CASE -4
							ls_ErrText = "L'ID dell'esercizio passato è zero o nullo e l'azienda corrente non ha un esercizio impostato."
						CASE -5
							ls_ErrText = "Non esiste un profilo con l'ID passato."
						CASE ELSE
							ls_ErrText = "Errore generico durante la contabilizzazione."
					END CHOOSE

				CASE 0
					ls_RifDoc = "Registro: '" + ls_des_registro + "' Progressivo: " + string(ll_num_progressivo) + " Data: " + string(ld_data_registrazione, "dd/mm/yyyy") + " (" + string(ll_id_documento) + ") ==> "
					ls_ErrText = "Registrazione già esistente."
			END CHOOSE

			u_debug.uf_log_msg(1, ls_RifDoc + ls_ErrText)
			as_msg = as_msg + ls_RifDoc + ls_ErrText + LCS_NEWLINE
		ELSE
			ll_j = ll_righe_doc
			ll_RetVal = -1
		END IF
	NEXT
	
	u_debug.uf_log_msg(1, " ")
	ls_footer = "****************** Fine Contabilizzazione " + String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + " ******************"
	u_debug.uf_log_msg(1, ls_footer)
	u_debug.uf_log_close(1)

	as_msg = as_msg + ls_footer + LCS_NEWLINE
END IF

RETURN ll_RetVal
return 1
end function

public subroutine uf_crea_cdc (integer ll_id_reg_pd, integer ll_id_documento);long ll_row, ll_breakrow, ll_c_testa, ll_c_righe,  ll_conto_pre, ll_pdc, i, j, ll_cen_testa
decimal ld_importo, ld_tot, ld_padre_imp
string ls_num

ls_num=''

datastore ds_calcoli
ds_calcoli=create datastore


ds_calcoli.dataobject='ds_calc_cdc'
ds_calcoli.settransobject(sqlca)


ll_row=ds_calcoli.retrieve(ll_id_documento)
ll_row=ds_calcoli.rowcount()

ll_conto_pre=0
ld_importo=0
ll_pdc=-1


long ll_num, ll_ret, ll_esercizio
date ld_data

ld_data=today()

ll_ret=year(ld_data)

select id_esercizio
into :ll_esercizio
from esercizio
where year(data_fine)=:ll_ret;

select max(num_prog)
into :ll_num
from reg_pdc
where id_esercizio=:ll_esercizio;
if isnull(ll_num) then ll_num=0	
ll_breakrow=1


for i=1 to ll_row
	  ll_breakrow = ds_calcoli.FindGroupChange( i+1, 1)
	  
	  IF ll_breakrow <= 0 THEN 
			j= ds_calcoli.rowcount()
     else 
			if ll_breakrow<> 1 then
			   j=ll_breakrow -1
			else 
				j=1    
				ll_breakrow=2   
		   end if
	  end if
	  
	  ll_c_testa=ds_calcoli.getitemnumber(i,'centro_costo_testa_id_conto')
	  ll_cen_testa=ds_calcoli.getitemnumber(i,'centro_costo_testa_id_cen_cos_t')
	  ld_padre_imp=ds_calcoli.getitemnumber(j,'padre_imp')
	  
	  
	  
	  if ll_conto_pre<>ll_c_testa then
			
			ll_num=ll_num + 1
			
			if ls_num='' then
				ls_num=string ( ll_num)
			else
				ls_num=ls_num+'  ,'+string ( ll_num)
			end if	
	  		insert into reg_pdc (id_reg_pd,valore,data,num_prog,id_esercizio,id_conto,segno,liv_provvisorieta,id_documento,id_cen_cos_t)
     		values       (:ll_id_reg_pd,:ld_padre_imp,:ld_data,:ll_num,:ll_esercizio,:ll_c_testa,-1,'D',:ll_id_documento,:ll_cen_testa);
	  		
	  		commit;		  
			select max(id_reg_pdc)
         into :ll_pdc
	      from reg_pdc; 	  
	
	  end if
	
	  ll_c_righe=ds_calcoli.getitemnumber(j,'centro_costo_righe_id_conto')
	  ld_importo=ds_calcoli.getitemnumber(j,'importo')
	  
	  

	  insert into mov_centri_costo (id_reg_pdc,id_conto,avere)
     values       (:ll_pdc,:ll_c_righe,:ld_importo);
	  
	  
	  
	  ll_conto_pre=ll_c_testa
	  
	  if ll_breakrow=0 then
		 i=ll_row
	  else	 
	    i=ll_breakrow - 1
	  end if	 

next



end subroutine

on u_contab_documento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_contab_documento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;

uf_create_ds()
end event

event destructor;

uf_destroy_ds()
end event

