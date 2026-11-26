forward
global type u_reg_pd from nonvisualobject
end type
end forward

global type u_reg_pd from nonvisualobject
end type
global u_reg_pd u_reg_pd

type variables
long il_id_prof_registrazione = 0
long il_id_esercizio = 0
long il_id_registro = 0
long il_num_progressivo = 0
date id_data_registrazione
date id_data_competenza
string is_descrizione = ""
long il_id_valuta = 0
decimal idc_importo = 0
decimal idc_imp_valuta = 0
decimal idc_cambio = 0
long il_id_conto
string is_num_documento = ""
date id_data_documento
char ic_ges_oper_intracomunitarie = 'N'
long il_id_reg_pd_padre
long il_id_azienda = 1
decimal idc_imponibile[]
long il_id_tab_iva[]
decimal idc_imposta[]
long il_id_conto_mc[]
char ic_segno_mc[]
decimal idc_importo_mc[]
boolean ib_mc_iva[]
long il_id_par_aperta[]
boolean ib_crea_mov_partita = FALSE
boolean ib_AutoCommit = TRUE
boolean ib_invert_mov_partita = FALSE
integer ii_DisplayMode = 2
char ic_rettifica
char ic_tipo_fattura = 'N'
integer ii_segno_reg_iva = 1
string is_des_contabile[]
date id_data_val_banca[]
date id_data_inizio_competenza[]
date id_data_fine_competenza[]
long il_id_valuta_mc[]
decimal idc_cambio_mc[]
long il_prog_stampato[]
boolean ib_crea_mov_scadenza = FALSE
long il_id_scadenza[]
date id_data_scadenza[]
string is_desc_tipo_pagam[]
string is_prof_desc[]
end variables

forward prototypes
public function long uf_crea ()
public subroutine uf_id_prof_registrazione (long al_id_prof_registrazione)
public subroutine uf_id_esercizio (long al_id_esercizio)
public subroutine uf_data_competenza (date ad_data_competenza)
public subroutine uf_descrizione (string as_descrizione)
public subroutine uf_id_valuta (long al_id_valuta)
public subroutine uf_cambio (decimal adc_cambio)
public subroutine uf_id_conto (long al_id_conto)
public subroutine uf_importo (decimal adc_importo)
public subroutine uf_num_documento (string as_num_documento)
public subroutine uf_data_documento (date ad_data_documento)
public subroutine uf_id_azienda (long al_id_azienda)
public subroutine uf_imponibile (decimal adc_imponibile[])
public subroutine uf_id_tab_iva (long al_id_tab_iva[])
public subroutine uf_imposta (decimal adc_imposta[])
public subroutine uf_id_conto_mc (long al_id_conto_mc[])
public subroutine uf_segno_mc (character ac_segno_mc[])
public subroutine uf_importo_mc (decimal adc_importo_mc[])
public subroutine uf_mc_iva (boolean ab_mc_iva[])
public subroutine uf_id_par_aperta (long al_id_par_aperta[])
public subroutine uf_crea_mov_partita (boolean ab_crea_mov_partita)
public subroutine uf_invert_mov_partita (boolean ab_invert_mov_partita)
public subroutine uf_autocommit (boolean ab_AutoCommit)
public subroutine uf_reset ()
public function long uf_proponi_esercizio ()
public subroutine uf_id_registro (long al_id_registro)
public subroutine uf_num_progressivo (long al_num_progressivo)
public subroutine uf_data_registrazione (date ad_data_registrazione)
public subroutine uf_displaymode (integer ai_DisplayMode)
public subroutine uf_rettifica (character ac_rettifica)
public subroutine uf_tipo_fattura (character ac_tipo_fattura)
public function boolean uf_reg_pd_esistente (long al_id_registro, long al_num_progressivo, date ad_data_registrazione)
public subroutine uf_des_contabile (string as_des_contabile[])
public subroutine uf_controlla_array ()
public subroutine uf_data_val_banca (date ad_data_val_banca[])
public subroutine uf_data_inizio_competenza (date ad_data_inizio_competenza[])
public subroutine uf_data_fine_competenza (date ad_data_fine_competenza[])
public subroutine uf_id_valuta_mc (long al_id_valuta_mc[])
public subroutine uf_cambio_mc (decimal adc_cambio_mc[])
public subroutine uf_ges_oper_intracomunitarie (character ac_ges_oper_intracomunitarie)
public subroutine uf_id_reg_pd_padre (long al_id_reg_pd_padre)
public subroutine uf_imp_valuta (decimal adc_imp_valuta)
public subroutine uf_core_controlla_array (ref any aa_array[], any aa_value, long al_upperbound)
public subroutine uf_prog_stampato (long al_prog_stampato[])
public subroutine uf_id_scadenza (long al_id_scadenza[])
public subroutine uf_crea_mov_scadenza (boolean ab_crea_mov_scadenza)
public subroutine uf_copia_uf_crea ()
public subroutine uf_data_scadenza (date ad_data_scadenza[])
public subroutine uf_desc_tipo_pagam (string as_desc_tipo_pagam[])
public subroutine uf_componi_desc (string us_descrizione)
public function string uf_des_mov_contabile (long ul_conto, string us_desc)
end prototypes

public function long uf_crea ();

long ll_id_prof_esiste, ll_NULL, ll_id_reg_pd = 0, ll_i, ll_numero, ll_id_mov_contabile
long ll_num_riga, ll_id_mov_partita
decimal ldc_importo_dare, ldc_importo_avere, ldc_NULL, ldc_tot_dare = 0, ldc_tot_avere = 0
decimal ldc_saldo, ldc_imp_mov_scadenza
integer li_invert, li_RetVal
date ld_NULL
string ls_NULL, ls_descr_registro,ls_prog_scritture
CONSTANT CHAR LCC_DARE = 'D'
CONSTANT CHAR LCC_AVERE = 'A'
CONSTANT CHAR LC_RISCONTO = "S"
CONSTANT CHAR LC_RATEO = "T"

SetNull(ll_NULL)
SetNull(ldc_NULL)
SetNull(ls_NULL)
SetNull(ld_NULL)

CHOOSE CASE ib_invert_mov_partita
   CASE TRUE
      li_invert = -1
   CASE FALSE
      li_invert = 1
END CHOOSE

IF il_id_prof_registrazione > 0 THEN
   SELECT Count(*) 
      INTO :ll_id_prof_esiste
      FROM dba.prof_registrazione
      WHERE id_prof_registrazione = :il_id_prof_registrazione;
ELSE
   
   RETURN -3
END IF

IF (UpperBound(il_id_conto_mc) = UpperBound(ic_segno_mc)) AND &
   (UpperBound(ic_segno_mc) = UpperBound(idc_importo_mc)) THEN
   FOR ll_i = 1 TO UpperBound(il_id_conto_mc)

      CHOOSE CASE ic_segno_mc[ll_i]
         CASE LCC_DARE
            ldc_tot_dare = ldc_tot_dare + idc_importo_mc[ll_i]
         CASE LCC_AVERE
            ldc_tot_avere = ldc_tot_avere + idc_importo_mc[ll_i]
      END CHOOSE

   NEXT
   ldc_saldo = ldc_tot_dare - ldc_tot_avere
	IF ((ldc_tot_dare = 0) AND (ldc_tot_avere = 0)) OR (ldc_saldo <> 0) THEN
      
      RETURN -1
   END IF
ELSE
   
   RETURN -2
END IF
FOR ll_i = 1 TO UpperBound(il_id_conto_mc)
	IF IsNull(ic_rettifica) THEN
		ll_num_riga = ll_i
	ELSE
		CHOOSE CASE ic_rettifica
			CASE LC_RISCONTO
				ll_num_riga = 2
			CASE LC_RATEO
				ll_num_riga = 1
			CASE ELSE
				ll_num_riga = ll_i
		END CHOOSE
	END IF
	
	IF il_id_conto_mc[ll_i] = 0 THEN
		SELECT prof_mov_contabile.id_conto, prof_mov_contabile.des_contabile
			INTO :il_id_conto_mc[ll_i], :is_prof_desc[ll_i]
			FROM prof_mov_contabile
			WHERE (prof_mov_contabile.id_prof_registrazione = :il_id_prof_registrazione) AND
			      (prof_mov_contabile.num_riga = :ll_num_riga)
			USING SQLCA;
		if isnull(is_prof_desc[ll_i])  THEN is_prof_desc[ll_i]='' 	
		IF il_id_conto_mc[ll_i] = 0 or isnull(il_id_conto_mc[ll_i])  THEN 
			messagebox('Information!','Impossibile generare la registrazione di pagamento.~r~nIl profilo selezionato genera una scrittura sbilanciata!')
			RETURN -6
		end if
	ELSE	
		IF upperbound(is_prof_desc[]) < ll_i THEN
			SELECT prof_mov_contabile.des_contabile
			INTO :is_prof_desc[ll_i]
			FROM prof_mov_contabile
			WHERE (prof_mov_contabile.id_prof_registrazione = :il_id_prof_registrazione) AND
			      (prof_mov_contabile.num_riga = :ll_num_riga)
			USING SQLCA;
		END if	
	END IF
	
	IF ic_segno_mc[ll_i] = "" THEN
		SELECT prof_mov_contabile.segno
			INTO :ic_segno_mc[ll_i]
			FROM prof_mov_contabile
			WHERE (prof_mov_contabile.id_prof_registrazione = :il_id_prof_registrazione) AND
			      (prof_mov_contabile.num_riga = :ll_num_riga)
			USING SQLCA;
			
		IF ic_segno_mc[ll_i] = "" THEN RETURN -7
	END IF
NEXT

IF ll_id_prof_esiste = 1 THEN
   
   IF IsNull(il_id_esercizio) OR (Il_id_esercizio = 0) THEN
		il_id_esercizio = uf_proponi_esercizio()
      
      IF IsNull(il_id_esercizio) OR (il_id_esercizio = 0) THEN
         
         RETURN -4
      END IF

   END IF
	
   
   IF IsNull(il_id_registro) OR (il_id_registro = 0) THEN
      il_id_registro = f_proponi_registro(il_id_prof_registrazione, il_id_esercizio)
   END IF
	//mm 07-1-14
	//se il registro non esiste (non è stato aperto l'esercizio relativo)
	//allora fermo tutto
	if isnull(il_id_registro) or il_id_registro=0 then
		messagebox("Attenzione!", "Esercizio non trovato: probabile scadenza all'anno nuovo!")
		return -9
	end if
	
	SELECT registro.descrizione,esercizio.prog_scritture
		INTO :ls_descr_registro,:ls_prog_scritture
		FROM dba.registro,dba.esercizio
		WHERE registro.id_registro = :il_id_registro
		and esercizio.id_esercizio=registro.id_esercizio
		USING SQLCA;

   
   IF IsNull(il_num_progressivo) OR (il_num_progressivo = 0) THEN
      il_num_progressivo = f_proponi_num_reg_pd(il_id_registro,ls_prog_scritture)
   END IF
	
   
   IF IsNull(id_data_registrazione) THEN
      id_data_registrazione = f_proponi_data_reg_pd(il_id_registro,ls_prog_scritture)
   END IF
	
	
	IF uf_reg_pd_esistente(il_id_registro, il_num_progressivo, id_data_registrazione) = TRUE THEN
		RETURN -8
	END IF
	
   
   IF IsNull(is_descrizione) OR is_descrizione = "" THEN
      is_descrizione = f_proponi_descr_reg_pd(il_id_prof_registrazione)
   END IF
	
   
   IF IsNull(il_id_valuta) OR (il_id_valuta = 0) THEN
     
		 il_id_valuta = f_proponi_valuta(ll_NULL, il_id_esercizio)
   END IF
   
   
   IF IsNull(idc_cambio) OR (idc_cambio = 0) THEN
      idc_cambio = f_proponi_cambio(il_id_valuta)
   END IF
	
   
   IF il_id_conto > 0 THEN
		IF IsNull(idc_imp_valuta) THEN
//	      idc_imp_valuta = idc_importo / idc_cambio
			idc_imp_valuta = idc_importo * idc_cambio
		END IF
      
      
      IF IsNull(is_num_documento) OR (is_num_documento = "") THEN
         is_num_documento = f_proponi_num_documento(il_id_registro,ls_prog_scritture)
      END IF
      
      
      IF IsNull(id_data_documento) THEN
         id_data_documento = f_proponi_data_documento(il_id_registro,ls_prog_scritture)
      END IF
   END IF
	
	
	uf_componi_desc(is_descrizione)
	
	uf_controlla_array()

   


 IF IsNull(id_data_competenza) THEN id_data_competenza = id_data_registrazione
 long ll_id_prof_iva_sos
 date ld_data_comp_liq_iva
 select id_prof_reg_iva_sos 
 into :ll_id_prof_iva_sos
 from par_sistema;
 if ll_id_prof_iva_sos<> il_id_prof_registrazione or isnull(ll_id_prof_iva_sos) THEN 
	ld_data_comp_liq_iva = id_data_registrazione
 else
	setnull(ld_data_comp_liq_iva)
 end if

	INSERT INTO reg_pd  
          (id_registro,   
           num_progressivo,   
           data_competenza,   
           id_prof_registrazione,   
           data_registrazione,
			  
			  data_comp_liq_iva,
			  
           id_valuta,   
           cambio,   
           importo,   
           imp_valuta,   
           descrizione,   
           num_documento,   
           data_documento,   
           id_conto,
			  segno_reg_iva,
			  tipo_fattura,
			  ges_oper_intracomunitarie,
			  id_reg_pd_padre,
           id_azienda)
   VALUES (:il_id_registro,
           :il_num_progressivo,   
           :id_data_competenza,   
           :il_id_prof_registrazione,   
           :id_data_registrazione,  
			  
           :ld_data_comp_liq_iva,  
		   :il_id_valuta,
           :idc_cambio,   
           :idc_importo,
           :idc_imp_valuta,   
           :is_descrizione,   
           :is_num_documento,   
           :id_data_documento,   
           :il_id_conto,
			  :ii_segno_reg_iva,
			  :ic_tipo_fattura,
			  :ic_ges_oper_intracomunitarie,
			  :il_id_reg_pd_padre,
           :il_id_azienda) ;
	commit;		  


	SELECT reg_pd.id_reg_pd
		INTO :ll_id_reg_pd
		FROM dba.reg_pd
		WHERE (reg_pd.num_progressivo    = :il_num_progressivo)    AND
		      (reg_pd.data_registrazione = :id_data_registrazione) AND
		      (reg_pd.id_registro        = :il_id_registro) ;
					
	IF ll_id_reg_pd > 0 THEN
		
		IF UpperBound(idc_imponibile) > 0 THEN
			
			FOR ll_i = 1 TO UpperBound(idc_imponibile)
				  INSERT INTO mov_iva  
								( id_reg_pd,   
								  imponibile,   
								  id_tab_iva,   
								  imposta,   
								  id_azienda )  
					  VALUES ( :ll_id_reg_pd,   
								  :idc_imponibile[ll_i],   
								  :il_id_tab_iva[ll_i],   
								  :idc_imposta[ll_i],   
								  :il_id_azienda )  ;
					commit;			  
			NEXT
		END IF
		
      FOR ll_i = 1 TO UpperBound(il_id_conto_mc)

         CHOOSE CASE ic_segno_mc[ll_i]
            CASE "D"
               ldc_importo_dare = idc_importo_mc[ll_i]
               ldc_importo_avere = ldc_NULL
            CASE "A"
               ldc_importo_dare = ldc_NULL
               ldc_importo_avere =idc_importo_mc[ll_i]
         END CHOOSE
			
			IF ib_mc_iva[ll_i] = TRUE THEN
				ll_numero = 9999
			ELSE
				ll_numero = ll_i
			END IF

         INSERT INTO mov_contabile  
                    ( id_reg_pd,   
                      numero,   
                      id_conto,   
                      id_valuta,   
                      cambio,   
                      des_contabile,   
                      dare,   
                      avere,
   						 data_val_banca,
                      data_inizio_competenza,   
                      data_fine_competenza,   
                      id_azienda )  
              VALUES (:ll_id_reg_pd,
                      :ll_numero,   
                      :il_id_conto_mc[ll_i],   
                      :il_id_valuta_mc[ll_i],   
                      :idc_cambio_mc[ll_i],
                      :is_des_contabile[ll_i],   
                      :ldc_importo_dare, 
                      :ldc_importo_avere,
							 :id_data_val_banca[ll_i],
                      :id_data_inizio_competenza[ll_i],
                      :id_data_fine_competenza[ll_i],
                      :il_id_azienda) ;
					commit;		  
         
			SELECT mov_contabile.id_mov_contabile
				INTO :ll_id_mov_contabile
				FROM dba.mov_contabile
				WHERE (mov_contabile.id_reg_pd = :ll_id_reg_pd) AND
				      (mov_contabile.numero = :ll_numero)
				USING SQLCA;

         IF UpperBound(il_id_par_aperta) > 0 THEN

				IF (NOT IsNull(il_id_par_aperta[ll_i])) AND (ib_crea_mov_partita = TRUE) THEN		
					
					ll_id_mov_partita = f_crea_mov_partita(il_id_par_aperta[ll_i],               &
																		ll_id_mov_contabile,                  &
																		ll_id_reg_pd,                         &
																		ll_NULL,                              &
																		id_data_registrazione,                &
																		(idc_importo_mc[ll_i] * li_invert),   &
																		ls_NULL,                              &
																		ll_NULL)
					
					IF ll_id_mov_partita= - 1 then messagebox('Attenzione','Creazione Movimento partita fallito/'+string(il_id_par_aperta[ll_i]))

					
					
					
					IF (ll_id_mov_partita > 0) AND &
						(ib_crea_mov_scadenza = TRUE) AND &
						(il_id_scadenza[ll_i] > 0) THEN
						
						ldc_imp_mov_scadenza = (idc_importo_mc[ll_i] * li_invert)
						
						INSERT INTO mov_scadenza
							(id_mov_partita,
							id_scadenza,
							data,
							importo,
							imp_valuta,
							id_azienda)
						VALUES
							(:ll_id_mov_partita,
							:il_id_scadenza[ll_i],
							:id_data_registrazione,
							:ldc_imp_mov_scadenza,
							:ldc_imp_mov_scadenza,
							:il_id_azienda);
						commit;	
					END IF
				END IF
         END IF
      NEXT
		
		IF ib_AutoCommit = TRUE THEN 
			COMMIT USING SQLCA;
		END IF
		
		
		CHOOSE CASE ii_DisplayMode
			CASE 1
				f_visualizza_reg_pd(ll_id_reg_pd)
			CASE 2
				li_RetVal = MessageBox("Registrazioni Contabili","Generata la registrazione numero " + &
											  string(il_num_progressivo) + " con data " + &
											  string(id_data_registrazione) + "~rnel registro " + &
											  ls_descr_registro + ".~rVisualizzare la registrazione?", Information!, YesNo!, 2)
											  
				IF li_RetVal = 1 THEN
					f_visualizza_reg_pd(ll_id_reg_pd)
				END IF 
		END CHOOSE

	END IF
ELSE
   
   RETURN -5
END IF

RETURN ll_id_reg_pd
end function

public subroutine uf_id_prof_registrazione (long al_id_prof_registrazione);

il_id_prof_registrazione = al_id_prof_registrazione
end subroutine

public subroutine uf_id_esercizio (long al_id_esercizio);

il_id_esercizio = al_id_esercizio

end subroutine

public subroutine uf_data_competenza (date ad_data_competenza);

id_data_competenza = ad_data_competenza
end subroutine

public subroutine uf_descrizione (string as_descrizione);

is_descrizione = as_descrizione
end subroutine

public subroutine uf_id_valuta (long al_id_valuta);

il_id_valuta = al_id_valuta
end subroutine

public subroutine uf_cambio (decimal adc_cambio);

idc_cambio = adc_cambio
end subroutine

public subroutine uf_id_conto (long al_id_conto);

il_id_conto = al_id_conto
end subroutine

public subroutine uf_importo (decimal adc_importo);

idc_importo = adc_importo
end subroutine

public subroutine uf_num_documento (string as_num_documento);

is_num_documento = as_num_documento
end subroutine

public subroutine uf_data_documento (date ad_data_documento);

id_data_documento = ad_data_documento
end subroutine

public subroutine uf_id_azienda (long al_id_azienda);

il_id_azienda = al_id_azienda
end subroutine

public subroutine uf_imponibile (decimal adc_imponibile[]);

idc_imponibile = adc_imponibile
end subroutine

public subroutine uf_id_tab_iva (long al_id_tab_iva[]);

il_id_tab_iva = al_id_tab_iva
end subroutine

public subroutine uf_imposta (decimal adc_imposta[]);

idc_imposta = adc_imposta
end subroutine

public subroutine uf_id_conto_mc (long al_id_conto_mc[]);

il_id_conto_mc = al_id_conto_mc
end subroutine

public subroutine uf_segno_mc (character ac_segno_mc[]);

ic_segno_mc = ac_segno_mc
end subroutine

public subroutine uf_importo_mc (decimal adc_importo_mc[]);

idc_importo_mc = adc_importo_mc
end subroutine

public subroutine uf_mc_iva (boolean ab_mc_iva[]);

ib_mc_iva = ab_mc_iva
end subroutine

public subroutine uf_id_par_aperta (long al_id_par_aperta[]);

il_id_par_aperta = al_id_par_aperta
end subroutine

public subroutine uf_crea_mov_partita (boolean ab_crea_mov_partita);

ib_crea_mov_partita = ab_crea_mov_partita
end subroutine

public subroutine uf_invert_mov_partita (boolean ab_invert_mov_partita);

ib_invert_mov_partita = ab_invert_mov_partita
end subroutine

public subroutine uf_autocommit (boolean ab_AutoCommit);

ib_autocommit = ab_AutoCommit
end subroutine

public subroutine uf_reset ();

long lal_NULL[]

char lac_NULL[]
boolean lab_NULL[]
string las_NULL[]
date lad_NULL[]
decimal ladc_NULL[]

il_id_prof_registrazione = 0
il_id_esercizio = 0
il_id_registro = 0
il_num_progressivo = 0
SetNull(id_data_registrazione)
SetNull(id_data_competenza)
SetNull(is_descrizione)
il_id_valuta = 0
idc_importo = 0
SetNull(idc_imp_valuta)
idc_cambio = 0
SetNull(il_id_conto)
is_num_documento = ""
SetNull(id_data_documento)
ic_ges_oper_intracomunitarie = 'N'
SetNull(il_id_reg_pd_padre)
il_id_azienda = 1
idc_imponibile = ladc_NULL
il_id_tab_iva = lal_NULL
idc_imposta = ladc_NULL
il_id_conto_mc = lal_NULL
ic_segno_mc = lac_NULL
idc_importo_mc = ladc_NULL
ib_mc_iva = lab_NULL
il_id_par_aperta = lal_NULL
ib_crea_mov_partita = FALSE
ib_invert_mov_partita = FALSE
SetNull(ic_rettifica)
ic_tipo_fattura = 'N'
ii_segno_reg_iva = 1
is_des_contabile = las_NULL
id_data_val_banca = lad_NULL
id_data_inizio_competenza = lad_NULL
id_data_fine_competenza = lad_NULL
il_id_valuta_mc = lal_NULL
idc_cambio_mc = ladc_NULL
ib_crea_mov_scadenza = FALSE
il_id_scadenza = lal_NULL
end subroutine

public function long uf_proponi_esercizio ();

long ll_RetVal = 0

SELECT azienda.id_esercizio_proposto
	INTO :ll_RetVal
	FROM azienda
	WHERE azienda.id_azienda = :il_id_azienda
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase", "u_reg_pd / uf_proponi_esercizio / 1")
END CHOOSE

RETURN ll_RetVal
end function

public subroutine uf_id_registro (long al_id_registro);

il_id_registro = al_id_registro



end subroutine

public subroutine uf_num_progressivo (long al_num_progressivo);

il_num_progressivo = al_num_progressivo

end subroutine

public subroutine uf_data_registrazione (date ad_data_registrazione);

id_data_registrazione = ad_data_registrazione

end subroutine

public subroutine uf_displaymode (integer ai_DisplayMode);

ii_DisplayMode = ai_DisplayMode
end subroutine

public subroutine uf_rettifica (character ac_rettifica);

ic_rettifica = ac_rettifica
end subroutine

public subroutine uf_tipo_fattura (character ac_tipo_fattura);

ic_tipo_fattura = ac_tipo_fattura

CHOOSE CASE ac_tipo_fattura
	CASE "C"
		ii_segno_reg_iva = -1
	CASE ELSE
		ii_segno_reg_iva = 1
END CHOOSE

end subroutine

public function boolean uf_reg_pd_esistente (long al_id_registro, long al_num_progressivo, date ad_data_registrazione);

long ll_id_reg_pd
boolean lb_RetVal = FALSE

SELECT reg_pd.id_reg_pd
	INTO :ll_id_reg_pd
	FROM dba.reg_pd
	WHERE (reg_pd.id_registro = :al_id_registro) AND
			(reg_pd.num_progressivo = :al_num_progressivo) AND
			(reg_pd.data_registrazione = :ad_data_registrazione)
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		lb_RetVal = TRUE
END CHOOSE


RETURN lb_RetVal
end function

public subroutine uf_des_contabile (string as_des_contabile[]);

is_des_contabile = as_des_contabile
end subroutine

public subroutine uf_controlla_array ();

long ll_i, ll_UpperBound
string ls_app_des_contabile, ls_des
boolean lb_descriz

ll_UpperBound = UpperBound(il_id_conto_mc)


lb_descriz = FALSE
IF IsNull(is_descrizione) OR is_descrizione = "" THEN lb_descriz = TRUE

FOR ll_i = 1 TO ll_upperbound
		IF lb_descriz = TRUE THEN
        
		  
			if ll_i = 1 and  UpperBound(is_desc_tipo_pagam)>1 then 
				is_des_contabile[ll_i] = "EMESSA " + is_desc_tipo_pagam[2]
			else 
				if UpperBound(is_desc_tipo_pagam)>=ll_i then is_des_contabile[ll_i] = "EMESSA " + is_desc_tipo_pagam[ll_i] + " AL " +  string(id_data_scadenza[ll_i])				
			end if
      else
			
			ls_des=uf_des_mov_contabile(il_id_conto_mc[ll_i],is_prof_desc[ll_i])
			if isnull(ls_des) or ls_des='' then
				is_des_contabile[ll_i] = is_descrizione
			else 
				is_des_contabile[ll_i] = ls_des
			end if	
			
	   END IF				
NEXT	

if lb_descriz = TRUE and UpperBound(is_desc_tipo_pagam)>1 then is_descrizione = "EMESSA " + is_desc_tipo_pagam[2]




IF UpperBound(id_data_val_banca) < ll_UpperBound THEN
	FOR ll_i = UpperBound(id_data_val_banca) + 1 TO ll_UpperBound
		id_data_val_banca[ll_i] = id_data_registrazione
	NEXT
END IF

FOR ll_i = 1 TO UpperBound(id_data_val_banca)
	IF IsNull(id_data_val_banca[ll_i]) THEN
		id_data_val_banca[ll_i] = id_data_registrazione
	END IF
NEXT

IF UpperBound(id_data_inizio_competenza) < ll_UpperBound THEN
	FOR ll_i = UpperBound(id_data_inizio_competenza) + 1 TO ll_UpperBound
		id_data_inizio_competenza[ll_i] = id_data_registrazione
	NEXT
END IF

FOR ll_i = 1 TO UpperBound(id_data_inizio_competenza)
	IF IsNull(id_data_inizio_competenza[ll_i]) THEN
		id_data_inizio_competenza[ll_i] = id_data_registrazione
	END IF
NEXT

IF UpperBound(id_data_fine_competenza) < ll_UpperBound THEN
	FOR ll_i = UpperBound(id_data_fine_competenza) + 1 TO ll_UpperBound
		id_data_fine_competenza[ll_i] = id_data_registrazione
	NEXT
END IF

FOR ll_i = 1 TO UpperBound(id_data_fine_competenza)
	IF IsNull(id_data_fine_competenza[ll_i]) THEN
		id_data_fine_competenza[ll_i] = id_data_registrazione
	END IF
NEXT

IF UpperBound(il_id_valuta_mc) < ll_UpperBound THEN
	FOR ll_i = UpperBound(il_id_valuta_mc) + 1 TO ll_UpperBound
		il_id_valuta_mc[ll_i] = il_id_valuta
	NEXT
END IF

FOR ll_i = 1 TO UpperBound(il_id_valuta_mc)
	IF IsNull(il_id_valuta_mc[ll_i]) THEN
		il_id_valuta_mc[ll_i] = il_id_valuta
	END IF
NEXT

IF UpperBound(idc_cambio_mc) < ll_UpperBound THEN
	FOR ll_i = UpperBound(idc_cambio_mc) + 1 TO ll_UpperBound
		idc_cambio_mc[ll_i] = idc_cambio
	NEXT
END IF

FOR ll_i = 1 TO UpperBound(idc_cambio_mc)
	IF IsNull(idc_cambio_mc[ll_i]) THEN
		idc_cambio_mc[ll_i] = idc_cambio
	END IF
NEXT

IF UpperBound(il_prog_stampato) < ll_UpperBound THEN
	FOR ll_i = UpperBound(il_prog_stampato) + 1 TO ll_UpperBound
		SetNull(il_prog_stampato[ll_i])
	NEXT
END IF

IF UpperBound(ib_mc_iva) < ll_UpperBound THEN
	FOR ll_i = UpperBound(ib_mc_iva) + 1 TO ll_UpperBound
		ib_mc_iva[ll_i] = FALSE
	NEXT
END IF

FOR ll_i = 1 TO UpperBound(ib_mc_iva)
	IF IsNull(ib_mc_iva[ll_i]) THEN
		ib_mc_iva[ll_i] = FALSE
	END IF
NEXT

IF UpperBound(il_id_par_aperta) < ll_UpperBound THEN
	FOR ll_i = UpperBound(il_id_par_aperta) + 1 TO ll_UpperBound
		SetNull(il_id_par_aperta[ll_i])
	NEXT
END IF

FOR ll_i = 1 TO UpperBound(il_id_par_aperta)
	IF IsNull(il_id_par_aperta[ll_i]) THEN
		SetNull(il_id_par_aperta[ll_i])
	END IF
NEXT

IF UpperBound(il_id_scadenza) < ll_UpperBound THEN
	FOR ll_i = UpperBound(il_id_scadenza) + 1 TO ll_UpperBound
		SetNull(il_id_scadenza[ll_i])
	NEXT
END IF

FOR ll_i = 1 TO UpperBound(il_id_scadenza)
	IF IsNull(il_id_scadenza[ll_i]) THEN
		SetNull(il_id_scadenza[ll_i])
	END IF
NEXT

end subroutine

public subroutine uf_data_val_banca (date ad_data_val_banca[]);

id_data_val_banca = ad_data_val_banca
end subroutine

public subroutine uf_data_inizio_competenza (date ad_data_inizio_competenza[]);

id_data_inizio_competenza = ad_data_inizio_competenza
end subroutine

public subroutine uf_data_fine_competenza (date ad_data_fine_competenza[]);

id_data_fine_competenza = ad_data_fine_competenza
end subroutine

public subroutine uf_id_valuta_mc (long al_id_valuta_mc[]);

il_id_valuta_mc = al_id_valuta_mc
end subroutine

public subroutine uf_cambio_mc (decimal adc_cambio_mc[]);

idc_cambio_mc = adc_cambio_mc
end subroutine

public subroutine uf_ges_oper_intracomunitarie (character ac_ges_oper_intracomunitarie);

ic_ges_oper_intracomunitarie = ac_ges_oper_intracomunitarie
end subroutine

public subroutine uf_id_reg_pd_padre (long al_id_reg_pd_padre);

il_id_reg_pd_padre = al_id_reg_pd_padre
end subroutine

public subroutine uf_imp_valuta (decimal adc_imp_valuta);

idc_imp_valuta = adc_imp_valuta
end subroutine

public subroutine uf_core_controlla_array (ref any aa_array[], any aa_value, long al_upperbound);

long ll_i

IF UpperBound(aa_array) < al_UpperBound THEN
	FOR ll_i = UpperBound(aa_array) + 1 TO al_UpperBound
		aa_array[ll_i] = aa_value
	NEXT
END IF

FOR ll_i = 1 TO UpperBound(aa_array)
	IF IsNull(aa_array[ll_i]) THEN
		aa_array[ll_i] = aa_value
	END IF
NEXT

end subroutine

public subroutine uf_prog_stampato (long al_prog_stampato[]);

il_prog_stampato = al_prog_stampato
end subroutine

public subroutine uf_id_scadenza (long al_id_scadenza[]);

il_id_scadenza = al_id_scadenza
end subroutine

public subroutine uf_crea_mov_scadenza (boolean ab_crea_mov_scadenza);

ib_crea_mov_scadenza = ab_crea_mov_scadenza

end subroutine

public subroutine uf_copia_uf_crea ();
end subroutine

public subroutine uf_data_scadenza (date ad_data_scadenza[]);id_data_scadenza = ad_data_scadenza
end subroutine

public subroutine uf_desc_tipo_pagam (string as_desc_tipo_pagam[]);is_desc_tipo_pagam = as_desc_tipo_pagam
end subroutine

public subroutine uf_componi_desc (string us_descrizione);
string ls_des, ls_char, ls_tipo, ls_conto_cod, ls_conto_des
long ll_ret

select des_contabile
into :ls_des
from prof_registrazione
where id_prof_registrazione=:il_id_prof_registrazione;

if isnull(ls_des) or ls_des='' then ls_des=us_descrizione

ll_ret=pos(ls_des,'@',1)
DO WHILE ll_ret<>0 
   ls_char=Left(Right(ls_des,len(ls_des) - ll_ret),1)
	CHOOSE CASE ls_char
		CASE 'N'
			   ls_tipo=ic_tipo_fattura
				if ls_tipo='N' then
					ls_tipo="Fatt. n° "
				elseif ls_tipo='C' then 
					ls_tipo="Nota Cred. n° "
				else
					ls_tipo="Nota Debito n° "
				end if
			if isnull(is_num_documento) then
			   ls_des=Replace(ls_des, ll_ret, 2, ls_tipo + '')
			else
				ls_des=Replace(ls_des, ll_ret, 2, ls_tipo + is_num_documento)
			end if	
		CASE 'P'
			if isnull(il_num_progressivo) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Num.Prog. ' + '')
			else
				ls_des=Replace(ls_des, ll_ret, 2, 'Num.Prog. ' + string(il_num_progressivo))
			end if	
		CASE 'D'
			if isnull(id_data_documento) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Data doc. ' + '')
			else
				ls_des=Replace(ls_des, ll_ret, 2, 'Data doc. ' + string(id_data_documento))
			end if	
	   CASE 'R'
			if isnull(id_data_registrazione) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Data reg. ' +'' )
			else
				ls_des=Replace(ls_des, ll_ret, 2, 'Data reg. ' + string(id_data_registrazione))
			end if
	   CASE 'C'
			if isnull(id_data_competenza) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Data comp. ' +'' )
			else
   			ls_des=Replace(ls_des, ll_ret, 2, 'Data comp. ' + string(id_data_competenza))
			end if	
		CASE 'F'
			select codice, descrizione
			into :ls_conto_cod, :ls_conto_des
			from conto
			where id_conto=:il_id_conto;
			if isnull(ls_conto_des) then
				ls_des=Replace(ls_des, ll_ret,2,'')
			else
   			ls_des=Replace(ls_des, ll_ret,2,ls_conto_des)	
			end if
	END CHOOSE
	ll_ret=pos(ls_des,'@',1)
LOOP
if len(ls_des)>40 then ls_des=left(trim(ls_des),40)
is_descrizione=ls_des
end subroutine

public function string uf_des_mov_contabile (long ul_conto, string us_desc);
string  ls_char, ls_tipo, ls_movcod, ls_movdes, ls_des
long ll_ret

ls_des=us_desc
ll_ret=pos(ls_des,'@',1)
DO WHILE ll_ret<>0 
   ls_char=Left(Right(ls_des,len(ls_des) - ll_ret),1)
	CHOOSE CASE ls_char
		CASE 'N'
			   ls_tipo=ic_tipo_fattura
				if ls_tipo='N' then
					ls_tipo="Fatt. n° "
				elseif ls_tipo='C' then 
					ls_tipo="Nota Cred. n° "
				else
					ls_tipo="Nota Debito n° "
				end if
				if isnull(is_num_documento) then
			  		ls_des=Replace(ls_des, ll_ret, 2, ls_tipo + '' )
				else
					ls_des=Replace(ls_des, ll_ret, 2, ls_tipo + is_num_documento)
				end if	
		CASE 'P'
			if isnull(il_num_progressivo) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Num.Prog. ' + '')
			else
				ls_des=Replace(ls_des, ll_ret, 2, 'Num.Prog. ' + string(il_num_progressivo))
			end if		
		CASE 'D'
			if isnull(id_data_documento) then
			  		ls_des=Replace(ls_des, ll_ret, 2, 'Data doc. ' + '')
				else
					ls_des=Replace(ls_des, ll_ret, 2, 'Data doc. ' + string(id_data_documento))
				end if
	   CASE 'R'
			if isnull(id_data_registrazione) then
			  		ls_des=Replace(ls_des, ll_ret, 2, 'Data reg. ' + '')
				else
					ls_des=Replace(ls_des, ll_ret, 2, 'Data reg. ' + string(id_data_registrazione))
				end if
	   CASE 'C'
				if isnull(id_data_competenza) then
			  		ls_des=Replace(ls_des, ll_ret, 2, 'Data comp. ' + '')
				else
					ls_des=Replace(ls_des, ll_ret, 2, 'Data comp. ' + string(id_data_competenza))
				end if
		CASE 'M'
			select codice, descrizione
			into :ls_movcod, :ls_movdes
			from conto
			where id_conto=:ul_conto;
			if isnull(ls_movdes) then
				ls_des=Replace(ls_des, ll_ret,2,'')	
			else	
			  ls_des=Replace(ls_des, ll_ret,2,ls_movdes)	
		   end if  	
	END CHOOSE
	ll_ret=pos(ls_des,'@',1)
LOOP
if len(ls_des)>40 then ls_des=left(trim(ls_des),40)

return ls_des
end function

on u_reg_pd.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_reg_pd.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;

uf_reset()
end event

