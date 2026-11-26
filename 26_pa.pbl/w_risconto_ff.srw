forward
global type w_risconto_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_risconto_ff
end type
type cb_annulla from commandbutton within w_risconto_ff
end type
type dw_risconto_ff from u_dw_ext_main within w_risconto_ff
end type
type st_1 from statictext within w_risconto_ff
end type
end forward

global type w_risconto_ff from w_wiz_main
int Width=1563
int Height=884
WindowType WindowType=response!
boolean TitleBar=true
string Title="Rilevazione Risconti"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_risconto_ff dw_risconto_ff
st_1 st_1
end type
global w_risconto_ff w_risconto_ff

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE
end variables

forward prototypes
public subroutine uf_feed_struct (boolean ab_feed)
public function boolean uf_controlla_data (date ad_data_registrazione)
public subroutine uf_genera_risconti ()
public subroutine uf_genera_risconti_avere (decimal ld_tot_avere)
public subroutine uf_genera_risconti_dare (decimal ld_tot_dare)
public subroutine uf_genera_storno_dare (decimal ld_tot_dare)
public subroutine uf_genera_storno_avere (decimal ld_tot_avere)
public subroutine uf_genera_rateo_dare (decimal ld_tot_dare)
public subroutine uf_genera_rateo_avere (decimal ld_tot_avere)
public subroutine uf_genera_storno_rateo_dare (decimal ld_tot_dare)
public subroutine uf_genera_storno_rateo_avere (decimal ld_tot_avere)
end prototypes

public subroutine uf_feed_struct (boolean ab_feed);

IF ab_feed = TRUE THEN
	id_data_registrazione = dw_risconto_ff.GetItemDate(dw_risconto_ff.GetRow(), "data_registrazione")
	istr_struct.d_data_registrazione = id_data_registrazione
ELSE
	SetNull(istr_struct.d_data_registrazione)
END IF

Message.PowerObjectParm = istr_struct
end subroutine

public function boolean uf_controlla_data (date ad_data_registrazione);

long ll_id_esercizio
boolean lb_RetVal = FALSE

SELECT esercizio.id_esercizio
	INTO :ll_id_esercizio
	FROM dba.esercizio
	WHERE (esercizio.data_inizio <= :ad_data_registrazione) AND
			(esercizio.data_fine >= :ad_data_registrazione)
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		lb_RetVal = TRUE
END CHOOSE

RETURN lb_RetVal
end function

public subroutine uf_genera_risconti ();



long ll_id_prof_registrazione, ll_id_mod_registro, ll_id_conto, ll_id_esercizio
long ll_id_valuta, ll_id_registro, ll_num_prog, ll_id_reg_pd, ll_num_riga
long ll_rif_conto
integer li_delta
decimal ld_importo_ris, ld_tot_importo_ris, ld_cambio
date ld_data_registrazione

    
	
 DECLARE risconti_cur CURSOR FOR  
  SELECT "ges_ratei_risconti"."flag_rat_ris"  
    FROM "ges_ratei_risconti"  
   WHERE "ges_ratei_risconti"."segno" = 'D' AND 
	      "ges_ratei_risconti"."tipo_record" = 'S' AND
	      "ges_ratei_risconti"."quota_rat_ris" = 'N';

	OPEN risconti_cur;
	
FETCH risconti_cur INTO :ld_importo_ris;

DO WHILE SQLCA.SQLCODE=0 
	
	ld_tot_importo_ris=ld_tot_importo_ris+ld_importo_ris
	
   FETCH risconti_cur INTO :ld_importo_ris;
LOOP

CLOSE risconti_cur;
	
messagebox("Totale Importo",ld_tot_importo_ris)

IF ld_tot_importo_ris>0 THEN
   li_delta=0 
   
   SELECT "prof_registrazione"."id_prof_registrazione", 
	       "prof_registrazione"."id_mod_registro"
     INTO :ll_id_prof_registrazione, :ll_id_mod_registro 
     FROM "par_wizard",   
          "wizard",   
          "prof_registrazione"  
  WHERE ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
        ( "par_wizard"."valore" = "prof_registrazione"."codice" ) AND  
        ( ( "wizard"."codice" = 'RATRISC' ) AND  
        ( "par_wizard"."num_ordine" = 1+:li_delta ) )   ;
		 

	
   SELECT "prof_mov_contabile"."id_conto"  
     INTO :ll_id_conto  
     FROM "prof_mov_contabile"  
  WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione ) AND  
        ( "prof_mov_contabile"."num_riga" = 2 )   ;
 
   
   ll_id_esercizio=dw_risconto_ff.getitemnumber(1,"id_esercizio")
   SELECT "registro"."id_registro"  
     INTO :ll_id_registro  
     FROM "registro"  
  WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
        ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
	SELECT "esercizio"."id_valuta"
	   INTO :ll_id_valuta
		FROM "esercizio"
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio;	

	
  SELECT "valuta"."cambio"  
    INTO :ld_cambio  
    FROM "valuta"  
   WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
 
  
   SELECT max(num_progressivo)
	  INTO :ll_num_prog
	  FROM reg_pd
    WHERE reg_pd.id_registro=:ll_id_registro;
	 
   ll_num_prog++
	
  
  ld_data_registrazione=dw_risconto_ff.getitemdate(1,"data_c")
 
  
  INSERT INTO REG_PD
              (id_registro,
				   num_progressivo, 
					data_competenza,
					data_registrazione,
					id_valuta,
					id_prof_registrazione,
					cambio,
					descrizione)
		 VALUES (:ll_id_registro,
		 		   :ll_num_prog,
					:ld_data_registrazione,
					:ld_data_registrazione,
					:ll_id_valuta,
					:ll_id_prof_registrazione,
					:ld_cambio,
					'Rilevamento Risconti') ;

  
  SELECT id_reg_pd
    INTO :ll_id_reg_pd
	 FROM REG_PD
   WHERE id_registro=:ll_id_registro and 
			num_progressivo=:ll_num_prog and
			data_registrazione=:ld_data_registrazione;
			
	IF SQLCA.SQLCODE<>0 THEN
		messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
	   ELSE
			
			messagebox("OK,Inserisco scrittura Risconto", ll_id_reg_pd)
			
			
         DECLARE risconti1_cur CURSOR FOR  
			  SELECT "ges_ratei_risconti"."flag_rat_ris",
			         "ges_ratei_risconti"."rif_conto"  
				 FROM "ges_ratei_risconti"  
				WHERE "ges_ratei_risconti"."segno" = 'D'  AND 
				      "ges_ratei_risconti"."tipo_record" = 'S' AND
	               "ges_ratei_risconti"."quota_rat_ris" = 'N';
			
				OPEN risconti1_cur;
				
			FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
			
			DO WHILE SQLCA.SQLCODE=0 
				
				ll_num_riga++
				messagebox("Riga Increm.", ll_num_riga)
				INSERT INTO MOV_CONTABILE
              (id_reg_pd,
				   numero,
					id_conto,
					id_valuta,
					avere,
					data_inizio_competenza,
					data_fine_competenza,
					data_val_banca,
					cambio)
		 VALUES (:ll_id_reg_pd,
		 		   :ll_num_riga,
					:ll_rif_conto,
					:ll_id_valuta,
					:ld_importo_ris,
					:ld_data_registrazione,
					:ld_data_registrazione,
					:ld_data_registrazione,
					:ld_cambio) ;

				FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
			LOOP
			
			CLOSE risconti1_cur;
			
			ll_num_riga++
				INSERT INTO MOV_CONTABILE
              (id_reg_pd,
				   numero,
					id_conto,
					id_valuta,
					dare,
					data_inizio_competenza,
					data_fine_competenza,
					data_val_banca,
					cambio)
		 VALUES (:ll_id_reg_pd,
		 		   :ll_num_riga,
					:ll_id_conto,
					:ll_id_valuta,
					:ld_tot_importo_ris,
					:ld_data_registrazione,
					:ld_data_registrazione,
					:ld_data_registrazione,
					:ld_cambio) ;
					
		 
		 
		 UPDATE "ges_ratei_risconti"  
          SET "ges_ratei_risconti"."rif_scr_rat_ris"=:ll_id_reg_pd,
			     "ges_ratei_risconti"."data_rat_ris"=:ld_data_registrazione,
			     "ges_ratei_risconti"."quota_rat_ris"= 'S'
        WHERE "ges_ratei_risconti"."segno" = 'D' AND 
	           "ges_ratei_risconti"."tipo_record" = 'S' AND
	           "ges_ratei_risconti"."quota_rat_ris" = 'N';

	END IF
	ELSE
	   
		messagebox("Controllo", "Attenzione, non ci sono Risconti da generare!",information!)
END IF

end subroutine

public subroutine uf_genera_risconti_avere (decimal ld_tot_avere);

long ll_id_prof_registrazione, ll_id_mod_registro, ll_id_conto, ll_id_esercizio
long ll_id_valuta, ll_id_registro, ll_num_prog, ll_id_reg_pd, ll_num_riga
long ll_rif_conto
integer li_delta
decimal ld_importo_ris, ld_cambio
date ld_data_registrazione

li_delta=2 

SELECT "prof_registrazione"."id_prof_registrazione", 
		 "prof_registrazione"."id_mod_registro",
		 "prof_registrazione"."id_valuta"
  INTO :ll_id_prof_registrazione, :ll_id_mod_registro, :ll_id_valuta  
  FROM "par_wizard",   
		 "wizard",   
		 "prof_registrazione"  
WHERE ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
	  ( "par_wizard"."valore" = "prof_registrazione"."codice" ) AND  
	  ( ( "wizard"."codice" = 'RATRISC' ) AND  
	  ( "par_wizard"."num_ordine" = 1+:li_delta ) )   ;
	 
SELECT "prof_mov_contabile"."id_conto"  
  INTO :ll_id_conto  
  FROM "prof_mov_contabile"  
WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione ) AND  
	  ( "prof_mov_contabile"."num_riga" = 2 )   ;

ll_id_esercizio=dw_risconto_ff.getitemnumber(1,"id_esercizio")
SELECT "registro"."id_registro"  
  INTO :ll_id_registro  
  FROM "registro"  
WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
	  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
	  
	SELECT "esercizio"."id_valuta"
	   INTO :ll_id_valuta
		FROM "esercizio"
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio;	
  SELECT "valuta"."cambio"  
 INTO :ld_cambio  
 FROM "valuta"  
WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
	  
	  
SELECT max(num_progressivo)
  INTO :ll_num_prog
  FROM reg_pd
 WHERE reg_pd.id_registro=:ll_id_registro;
 
ll_num_prog++

ld_data_registrazione=dw_risconto_ff.getitemdate(1,"data_c")

INSERT INTO REG_PD
			  (id_registro,
				num_progressivo, 
				data_competenza,
				data_registrazione,
				id_valuta,
				id_prof_registrazione,
				cambio,
				descrizione)
	 VALUES (:ll_id_registro,
				:ll_num_prog,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ll_id_valuta,
				:ll_id_prof_registrazione,
				:ld_cambio,
				'Rilevamento Risconti Passivi') ;

SELECT id_reg_pd
 INTO :ll_id_reg_pd
 FROM REG_PD
WHERE id_registro=:ll_id_registro and 
		num_progressivo=:ll_num_prog and
		data_registrazione=:ld_data_registrazione;
		
IF SQLCA.SQLCODE<>0 THEN
	messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
	ELSE
		
		
		
		
		DECLARE risconti1_cur CURSOR FOR  
		  SELECT "ges_ratei_risconti"."flag_rat_ris",
					"ges_ratei_risconti"."rif_conto"  
			 FROM "ges_ratei_risconti"  
			WHERE "ges_ratei_risconti"."segno" = 'A'  AND 
					"ges_ratei_risconti"."tipo_record" = 'S' AND
					"ges_ratei_risconti"."quota_rat_ris" = 'N';
		
			OPEN risconti1_cur;
			
		FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
		
		DO WHILE SQLCA.SQLCODE=0 
			
			ll_num_riga++
			
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				dare,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_rif_conto,
				:ll_id_valuta,
				:ld_importo_ris,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;

			FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
		LOOP
		
		CLOSE risconti1_cur;
		
		ll_num_riga++
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				avere,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_id_conto,
				:ll_id_valuta,
				:ld_tot_avere,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;
				
	 
	 
	 UPDATE "ges_ratei_risconti"  
		 SET "ges_ratei_risconti"."rif_scr_rat_ris"=:ll_id_reg_pd,
			  "ges_ratei_risconti"."data_rat_ris"=:ld_data_registrazione,
			  "ges_ratei_risconti"."quota_rat_ris"= 'S'
	  WHERE "ges_ratei_risconti"."segno" = 'A' AND 
			  "ges_ratei_risconti"."tipo_record" = 'S' AND
			  "ges_ratei_risconti"."quota_rat_ris" = 'N';
			  
    
	 messagebox("Information","Generata Scrittura Risconti Passivi n. "+string(ll_num_prog) )
END IF

end subroutine

public subroutine uf_genera_risconti_dare (decimal ld_tot_dare);


long ll_id_prof_registrazione, ll_id_mod_registro, ll_id_conto, ll_id_esercizio
long ll_id_valuta, ll_id_registro, ll_num_prog, ll_id_reg_pd, ll_num_riga
long ll_rif_conto
integer li_delta
decimal ld_importo_ris, ld_cambio
date ld_data_registrazione

li_delta=0 

SELECT "prof_registrazione"."id_prof_registrazione", 
		 "prof_registrazione"."id_mod_registro",
		 "prof_registrazione"."id_valuta"
  INTO :ll_id_prof_registrazione, :ll_id_mod_registro, :ll_id_valuta  
  FROM "par_wizard",   
		 "wizard",   
		 "prof_registrazione"  
WHERE ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
	  ( "par_wizard"."valore" = "prof_registrazione"."codice" ) AND  
	  ( ( "wizard"."codice" = 'RATRISC' ) AND  
	  ( "par_wizard"."num_ordine" = 1+:li_delta ) )   ;

SELECT "prof_mov_contabile"."id_conto"  
  INTO :ll_id_conto  
  FROM "prof_mov_contabile"  
WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione ) AND  
	  ( "prof_mov_contabile"."num_riga" = 2 )   ;

ll_id_esercizio=dw_risconto_ff.getitemnumber(1,"id_esercizio")
SELECT "registro"."id_registro"  
  INTO :ll_id_registro  
  FROM "registro"  
WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
	  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
	SELECT "esercizio"."id_valuta"
	   INTO :ll_id_valuta
		FROM "esercizio"
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio;	
  SELECT "valuta"."cambio"  
 INTO :ld_cambio  
 FROM "valuta"  
WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
	  
SELECT max(num_progressivo)
  INTO :ll_num_prog
  FROM reg_pd
 WHERE reg_pd.id_registro=:ll_id_registro;
 
ll_num_prog++

ld_data_registrazione=dw_risconto_ff.getitemdate(1,"data_c")

INSERT INTO REG_PD
			  (id_registro,
				num_progressivo, 
				data_competenza,
				data_registrazione,
				id_valuta,
				id_prof_registrazione,
				cambio,
				descrizione)
	 VALUES (:ll_id_registro,
				:ll_num_prog,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ll_id_valuta,
				:ll_id_prof_registrazione,
				:ld_cambio,
				'Rilevamento Risconti Attivi') ;

SELECT id_reg_pd
 INTO :ll_id_reg_pd
 FROM REG_PD
WHERE id_registro=:ll_id_registro and 
		num_progressivo=:ll_num_prog and
		data_registrazione=:ld_data_registrazione;
		
IF SQLCA.SQLCODE<>0 THEN
	messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
	ELSE
		
		
		
		
		DECLARE risconti1_cur CURSOR FOR  
		  SELECT "ges_ratei_risconti"."flag_rat_ris",
					"ges_ratei_risconti"."rif_conto"  
			 FROM "ges_ratei_risconti"  
			WHERE "ges_ratei_risconti"."segno" = 'D'  AND 
					"ges_ratei_risconti"."tipo_record" = 'S' AND
					"ges_ratei_risconti"."quota_rat_ris" = 'N';
		
			OPEN risconti1_cur;
			
		FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
		
		DO WHILE SQLCA.SQLCODE=0 
			
			ll_num_riga++
			
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				avere,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_rif_conto,
				:ll_id_valuta,
				:ld_importo_ris,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;

			FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
		LOOP
		
		CLOSE risconti1_cur;
		
		ll_num_riga++
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				dare,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_id_conto,
				:ll_id_valuta,
				:ld_tot_dare,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;
				
	 
	 
	 UPDATE "ges_ratei_risconti"  
		 SET "ges_ratei_risconti"."rif_scr_rat_ris"=:ll_id_reg_pd,
			  "ges_ratei_risconti"."data_rat_ris"=:ld_data_registrazione,
			  "ges_ratei_risconti"."quota_rat_ris"= 'S'
	  WHERE "ges_ratei_risconti"."segno" = 'D' AND 
			  "ges_ratei_risconti"."tipo_record" = 'S' AND
			  "ges_ratei_risconti"."quota_rat_ris" = 'N';
			  
	 
	 messagebox("Information","Generata Scrittura Risconti Attivi n. "+string(ll_num_prog) )
END IF

end subroutine

public subroutine uf_genera_storno_dare (decimal ld_tot_dare);


long ll_id_prof_registrazione, ll_id_mod_registro, ll_id_conto, ll_id_esercizio
long ll_id_valuta, ll_id_registro, ll_num_prog, ll_id_reg_pd, ll_num_riga
long ll_rif_conto
integer li_delta
decimal ld_importo_ris, ld_cambio
date ld_data_registrazione

li_delta=3 

SELECT "prof_registrazione"."id_prof_registrazione", 
		 "prof_registrazione"."id_mod_registro",
		 "prof_registrazione"."id_valuta"
  INTO :ll_id_prof_registrazione, :ll_id_mod_registro, :ll_id_valuta  
  FROM "par_wizard",   
		 "wizard",   
		 "prof_registrazione"  
WHERE ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
	  ( "par_wizard"."valore" = "prof_registrazione"."codice" ) AND  
	  ( ( "wizard"."codice" = 'RATRISC' ) AND  
	  ( "par_wizard"."num_ordine" = 1+:li_delta ) )   ;
	 
SELECT "prof_mov_contabile"."id_conto"  
  INTO :ll_id_conto  
  FROM "prof_mov_contabile"  
WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione ) AND  
	  ( "prof_mov_contabile"."num_riga" = 2 )   ;

ll_id_esercizio=dw_risconto_ff.getitemnumber(1,"id_esercizio")
SELECT "registro"."id_registro"  
  INTO :ll_id_registro  
  FROM "registro"  
WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
	  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;

	SELECT "esercizio"."id_valuta"
	   INTO :ll_id_valuta
		FROM "esercizio"
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio;	

	
  SELECT "valuta"."cambio"  
    INTO :ld_cambio  
    FROM "valuta"  
   WHERE "valuta"."id_valuta" = :ll_id_valuta   ;

	  
SELECT max(num_progressivo)
  INTO :ll_num_prog
  FROM reg_pd
 WHERE reg_pd.id_registro=:ll_id_registro;
 
ll_num_prog++

ld_data_registrazione=dw_risconto_ff.getitemdate(1,"data_c")

INSERT INTO REG_PD
			  (id_registro,
				num_progressivo, 
				data_competenza,
				data_registrazione,
				id_valuta,
				id_prof_registrazione,
				cambio,
				descrizione)
	 VALUES (:ll_id_registro,
				:ll_num_prog,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ll_id_valuta,
				:ll_id_prof_registrazione,
				:ld_cambio,
				'Rilevamento Risconti Passivi Economico') ;

SELECT id_reg_pd
 INTO :ll_id_reg_pd
 FROM REG_PD
WHERE id_registro=:ll_id_registro and 
		num_progressivo=:ll_num_prog and
		data_registrazione=:ld_data_registrazione;
		
IF SQLCA.SQLCODE<>0 THEN
	messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
	ELSE
		
		
		
		DECLARE risconti1_cur CURSOR FOR  
		  SELECT "ges_ratei_risconti"."flag_rat_ris",
					"ges_ratei_risconti"."rif_conto"  
			 FROM "ges_ratei_risconti"  
			WHERE "ges_ratei_risconti"."segno" = 'D'  AND 
					"ges_ratei_risconti"."tipo_record" = 'S' AND
					"ges_ratei_risconti"."quota_rat_ris" = 'S' AND
					"ges_ratei_risconti"."storno" = 'N';
		
			OPEN risconti1_cur;
			
		FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
		
		DO WHILE SQLCA.SQLCODE=0 
			
			ll_num_riga++
			
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				dare,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_rif_conto,
				:ll_id_valuta,
				:ld_importo_ris,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;

			FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
		LOOP
		
		CLOSE risconti1_cur;
		
		ll_num_riga++
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				avere,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_id_conto,
				:ll_id_valuta,
				:ld_tot_dare,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;
				
	 
	 
	 UPDATE "ges_ratei_risconti"  
		 SET "ges_ratei_risconti"."rif_scr_storno"=:ll_id_reg_pd,
			  "ges_ratei_risconti"."data_scr_storno"=:ld_data_registrazione,
			  "ges_ratei_risconti"."storno"= 'S'
	  WHERE "ges_ratei_risconti"."segno" = 'D' AND 
			  "ges_ratei_risconti"."tipo_record" = 'S' AND
			  "ges_ratei_risconti"."quota_rat_ris" = 'S' AND
			  "ges_ratei_risconti"."storno" = 'N';
			  
	 
	 messagebox("Information","Generato Storno Risconti Attivi n. "+string(ll_num_prog) )
END IF

end subroutine

public subroutine uf_genera_storno_avere (decimal ld_tot_avere);

long ll_id_prof_registrazione, ll_id_mod_registro, ll_id_conto, ll_id_esercizio
long ll_id_valuta, ll_id_registro, ll_num_prog, ll_id_reg_pd, ll_num_riga
long ll_rif_conto
integer li_delta
decimal ld_importo_ris, ld_cambio
date ld_data_registrazione

li_delta=1

SELECT "prof_registrazione"."id_prof_registrazione", 
		 "prof_registrazione"."id_mod_registro",
		 "prof_registrazione"."id_valuta"
  INTO :ll_id_prof_registrazione, :ll_id_mod_registro, :ll_id_valuta  
  FROM "par_wizard",   
		 "wizard",   
		 "prof_registrazione"  
WHERE ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
	  ( "par_wizard"."valore" = "prof_registrazione"."codice" ) AND  
	  ( ( "wizard"."codice" = 'RATRISC' ) AND  
	  ( "par_wizard"."num_ordine" = 1+:li_delta ) )   ;
	 

SELECT "prof_mov_contabile"."id_conto"  
  INTO :ll_id_conto  
  FROM "prof_mov_contabile"  
WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione ) AND  
	  ( "prof_mov_contabile"."num_riga" = 2 )   ;

ll_id_esercizio=dw_risconto_ff.getitemnumber(1,"id_esercizio")
SELECT "registro"."id_registro"  
  INTO :ll_id_registro  
  FROM "registro"  
WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
	  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;

	SELECT "esercizio"."id_valuta"
	   INTO :ll_id_valuta
		FROM "esercizio"
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio;	

  SELECT "valuta"."cambio"  
    INTO :ld_cambio  
    FROM "valuta"  
   WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
	  
SELECT max(num_progressivo)
  INTO :ll_num_prog
  FROM reg_pd
 WHERE reg_pd.id_registro=:ll_id_registro;
 
ll_num_prog++

ld_data_registrazione=dw_risconto_ff.getitemdate(1,"data_c")

INSERT INTO REG_PD
			  (id_registro,
				num_progressivo, 
				data_competenza,
				data_registrazione,
				id_valuta,
				id_prof_registrazione,
				cambio,
				descrizione)
	 VALUES (:ll_id_registro,
				:ll_num_prog,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ll_id_valuta,
				:ll_id_prof_registrazione,
				:ld_cambio,
				'Rilevamento Risconti Attivi Economico') ;

SELECT id_reg_pd
 INTO :ll_id_reg_pd
 FROM REG_PD
WHERE id_registro=:ll_id_registro and 
		num_progressivo=:ll_num_prog and
		data_registrazione=:ld_data_registrazione;
		
IF SQLCA.SQLCODE<>0 THEN
	messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
	ELSE
		
			
		
		DECLARE risconti1_cur CURSOR FOR  
		  SELECT "ges_ratei_risconti"."flag_rat_ris",
					"ges_ratei_risconti"."rif_conto"  
			 FROM "ges_ratei_risconti"  
			WHERE "ges_ratei_risconti"."segno" = 'A'  AND 
					"ges_ratei_risconti"."tipo_record" = 'S' AND
					"ges_ratei_risconti"."quota_rat_ris" = 'S' AND
					"ges_ratei_risconti"."storno" = 'N';
		
			OPEN risconti1_cur;
			
		FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
		
		DO WHILE SQLCA.SQLCODE=0 
			
			ll_num_riga++
			
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				avere,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_rif_conto,
				:ll_id_valuta,
				:ld_importo_ris,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;

			FETCH risconti1_cur INTO :ld_importo_ris, :ll_rif_conto;
		LOOP
		
		CLOSE risconti1_cur;
		
		ll_num_riga++
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				dare,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_id_conto,
				:ll_id_valuta,
				:ld_tot_avere,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;
				
	 
	 
	 UPDATE "ges_ratei_risconti"  
		 SET "ges_ratei_risconti"."rif_scr_storno"=:ll_id_reg_pd,
			  "ges_ratei_risconti"."data_scr_storno"=:ld_data_registrazione,
			  "ges_ratei_risconti"."storno"= 'S'
	  WHERE "ges_ratei_risconti"."segno" = 'A' AND 
			  "ges_ratei_risconti"."tipo_record" = 'S' AND
			  "ges_ratei_risconti"."quota_rat_ris" = 'S' AND
			  "ges_ratei_risconti"."storno" = 'N';
			  
    
	 messagebox("Information","Generato Storno Risconti Passivi n. "+string(ll_num_prog) )
END IF

end subroutine

public subroutine uf_genera_rateo_dare (decimal ld_tot_dare);


long ll_id_prof_registrazione, ll_id_mod_registro, ll_id_conto, ll_id_esercizio
long ll_id_valuta, ll_id_registro, ll_num_prog, ll_id_reg_pd, ll_num_riga
long ll_rif_conto
integer li_delta
decimal ld_importo_ris, ld_cambio
date ld_data_registrazione

li_delta=0 

SELECT "prof_registrazione"."id_prof_registrazione", 
		 "prof_registrazione"."id_mod_registro",
		 "prof_registrazione"."id_valuta"
  INTO :ll_id_prof_registrazione, :ll_id_mod_registro, :ll_id_valuta  
  FROM "par_wizard",   
		 "wizard",   
		 "prof_registrazione"  
WHERE ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
	  ( "par_wizard"."valore" = "prof_registrazione"."codice" ) AND  
	  ( ( "wizard"."codice" = 'RATRISC' ) AND  
	  ( "par_wizard"."num_ordine" = 1+:li_delta ) )   ;
	 
SELECT "prof_mov_contabile"."id_conto"  
  INTO :ll_id_conto  
  FROM "prof_mov_contabile"  
WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione ) AND  
	  ( "prof_mov_contabile"."num_riga" = 1 )   ;

ll_id_esercizio=dw_risconto_ff.getitemnumber(1,"id_esercizio")
SELECT "registro"."id_registro"  
  INTO :ll_id_registro  
  FROM "registro"  
WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
	  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;

	SELECT "esercizio"."id_valuta"
	   INTO :ll_id_valuta
		FROM "esercizio"
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio;	

  SELECT "valuta"."cambio"  
    INTO :ld_cambio  
    FROM "valuta"  
   WHERE "valuta"."id_valuta" = :ll_id_valuta   ;

SELECT max(num_progressivo)
  INTO :ll_num_prog
  FROM reg_pd
 WHERE reg_pd.id_registro=:ll_id_registro;
 
ll_num_prog++

ld_data_registrazione=dw_risconto_ff.getitemdate(1,"data_c")

INSERT INTO REG_PD
			  (id_registro,
				num_progressivo, 
				data_competenza,
				data_registrazione,
				id_valuta,
				id_prof_registrazione,
				cambio,
				descrizione)
	 VALUES (:ll_id_registro,
				:ll_num_prog,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ll_id_valuta,
				:ll_id_prof_registrazione,
				:ld_cambio,
				'Rilevamento Ratei Attivi') ;

SELECT id_reg_pd
 INTO :ll_id_reg_pd
 FROM REG_PD
WHERE id_registro=:ll_id_registro and 
		num_progressivo=:ll_num_prog and
		data_registrazione=:ld_data_registrazione;
		
IF SQLCA.SQLCODE<>0 THEN
	messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
	ELSE
		
		
		
		
		DECLARE ratei1_cur CURSOR FOR  
		  SELECT "ges_ratei_risconti"."flag_rat_ris",
					"ges_ratei_risconti"."rif_conto"  
			 FROM "ges_ratei_risconti"  
			WHERE "ges_ratei_risconti"."segno" = 'D'  AND 
					"ges_ratei_risconti"."tipo_record" = 'T' AND
					"ges_ratei_risconti"."quota_rat_ris" = 'N';
		
			OPEN ratei1_cur;
			
		FETCH ratei1_cur INTO :ld_importo_ris, :ll_rif_conto;
		
		DO WHILE SQLCA.SQLCODE=0 
			
			ll_num_riga++
			
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				avere,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_rif_conto,
				:ll_id_valuta,
				:ld_importo_ris,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;

			FETCH ratei1_cur INTO :ld_importo_ris, :ll_rif_conto;
		LOOP
		
		CLOSE ratei1_cur;
		
		ll_num_riga++
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				dare,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_id_conto,
				:ll_id_valuta,
				:ld_tot_dare,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;
				
	 
	 
	 UPDATE "ges_ratei_risconti"  
		 SET "ges_ratei_risconti"."rif_scr_rat_ris"=:ll_id_reg_pd,
			  "ges_ratei_risconti"."data_rat_ris"=:ld_data_registrazione,
			  "ges_ratei_risconti"."quota_rat_ris"= 'S'
	  WHERE "ges_ratei_risconti"."segno" = 'D' AND 
			  "ges_ratei_risconti"."tipo_record" = 'T' AND
			  "ges_ratei_risconti"."quota_rat_ris" = 'N';
			  
	 
	 messagebox("Information","Generata Scrittura Ratei Attivi n. "+string(ll_num_prog) )
END IF

end subroutine

public subroutine uf_genera_rateo_avere (decimal ld_tot_avere);

long ll_id_prof_registrazione, ll_id_mod_registro, ll_id_conto, ll_id_esercizio
long ll_id_valuta, ll_id_registro, ll_num_prog, ll_id_reg_pd, ll_num_riga
long ll_rif_conto
integer li_delta
decimal ld_importo_ris, ld_cambio
date ld_data_registrazione

li_delta=2 

SELECT "prof_registrazione"."id_prof_registrazione", 
		 "prof_registrazione"."id_mod_registro",
		 "prof_registrazione"."id_valuta"
  INTO :ll_id_prof_registrazione, :ll_id_mod_registro, :ll_id_valuta  
  FROM "par_wizard",   
		 "wizard",   
		 "prof_registrazione"  
WHERE ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
	  ( "par_wizard"."valore" = "prof_registrazione"."codice" ) AND  
	  ( ( "wizard"."codice" = 'RATRISC' ) AND  
	  ( "par_wizard"."num_ordine" = 1+:li_delta ) )   ;
	 
SELECT "prof_mov_contabile"."id_conto"  
  INTO :ll_id_conto  
  FROM "prof_mov_contabile"  
WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione ) AND  
	  ( "prof_mov_contabile"."num_riga" = 1 )   ;

ll_id_esercizio=dw_risconto_ff.getitemnumber(1,"id_esercizio")
SELECT "registro"."id_registro"  
  INTO :ll_id_registro  
  FROM "registro"  
WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
	  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
	  
	SELECT "esercizio"."id_valuta"
	   INTO :ll_id_valuta
		FROM "esercizio"
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio;	

	
  SELECT "valuta"."cambio"  
    INTO :ld_cambio  
    FROM "valuta"  
   WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
	  
	  
SELECT max(num_progressivo)
  INTO :ll_num_prog
  FROM reg_pd
 WHERE reg_pd.id_registro=:ll_id_registro;
 
ll_num_prog++

ld_data_registrazione=dw_risconto_ff.getitemdate(1,"data_c")

INSERT INTO REG_PD
			  (id_registro,
				num_progressivo, 
				data_competenza,
				data_registrazione,
				id_valuta,
				id_prof_registrazione,
				cambio,
				descrizione)
	 VALUES (:ll_id_registro,
				:ll_num_prog,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ll_id_valuta,
				:ll_id_prof_registrazione,
				:ld_cambio,
				'Rilevamento Ratei Passivi') ;

SELECT id_reg_pd
 INTO :ll_id_reg_pd
 FROM REG_PD
WHERE id_registro=:ll_id_registro and 
		num_progressivo=:ll_num_prog and
		data_registrazione=:ld_data_registrazione;
		
IF SQLCA.SQLCODE<>0 THEN
	messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
	ELSE
		
		
		
		
		DECLARE rateo1_cur CURSOR FOR  
		  SELECT "ges_ratei_risconti"."flag_rat_ris",
					"ges_ratei_risconti"."rif_conto"  
			 FROM "ges_ratei_risconti"  
			WHERE "ges_ratei_risconti"."segno" = 'A'  AND 
					"ges_ratei_risconti"."tipo_record" = 'T' AND
					"ges_ratei_risconti"."quota_rat_ris" = 'N';
		
			OPEN rateo1_cur;
			
		FETCH rateo1_cur INTO :ld_importo_ris, :ll_rif_conto;
		
		DO WHILE SQLCA.SQLCODE=0 
			
			ll_num_riga++
			
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				dare,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_rif_conto,
				:ll_id_valuta,
				:ld_importo_ris,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;

			FETCH rateo1_cur INTO :ld_importo_ris, :ll_rif_conto;
		LOOP
		
		CLOSE rateo1_cur;
		
		ll_num_riga++
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				avere,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_id_conto,
				:ll_id_valuta,
				:ld_tot_avere,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;
				
	 
	 
	 UPDATE "ges_ratei_risconti"  
		 SET "ges_ratei_risconti"."rif_scr_rat_ris"=:ll_id_reg_pd,
			  "ges_ratei_risconti"."data_rat_ris"=:ld_data_registrazione,
			  "ges_ratei_risconti"."quota_rat_ris"= 'S'
	  WHERE "ges_ratei_risconti"."segno" = 'A' AND 
			  "ges_ratei_risconti"."tipo_record" = 'T' AND
			  "ges_ratei_risconti"."quota_rat_ris" = 'N';
			  
    
	 messagebox("Information","Generata Scrittura Ratei Passivi n. "+string(ll_num_prog) )
END IF

end subroutine

public subroutine uf_genera_storno_rateo_dare (decimal ld_tot_dare);


long ll_id_prof_registrazione, ll_id_mod_registro, ll_id_conto, ll_id_esercizio
long ll_id_valuta, ll_id_registro, ll_num_prog, ll_id_reg_pd, ll_num_riga
long ll_rif_conto
integer li_delta
decimal ld_importo_ris, ld_cambio
date ld_data_registrazione

li_delta=3 

SELECT "prof_registrazione"."id_prof_registrazione", 
		 "prof_registrazione"."id_mod_registro",
		 "prof_registrazione"."id_valuta"
  INTO :ll_id_prof_registrazione, :ll_id_mod_registro, :ll_id_valuta  
  FROM "par_wizard",   
		 "wizard",   
		 "prof_registrazione"  
WHERE ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
	  ( "par_wizard"."valore" = "prof_registrazione"."codice" ) AND  
	  ( ( "wizard"."codice" = 'RATRISC' ) AND  
	  ( "par_wizard"."num_ordine" = 1+:li_delta ) )   ;
	 

SELECT "prof_mov_contabile"."id_conto"  
  INTO :ll_id_conto  
  FROM "prof_mov_contabile"  
WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione ) AND  
	  ( "prof_mov_contabile"."num_riga" = 1 )   ;

ll_id_esercizio=dw_risconto_ff.getitemnumber(1,"id_esercizio")
SELECT "registro"."id_registro"  
  INTO :ll_id_registro  
  FROM "registro"  
WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
	  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;

	SELECT "esercizio"."id_valuta"
	   INTO :ll_id_valuta
		FROM "esercizio"
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio;	

	
  SELECT "valuta"."cambio"  
    INTO :ld_cambio  
    FROM "valuta"  
   WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
	  
SELECT max(num_progressivo)
  INTO :ll_num_prog
  FROM reg_pd
 WHERE reg_pd.id_registro=:ll_id_registro;
 
ll_num_prog++

ld_data_registrazione=dw_risconto_ff.getitemdate(1,"data_c")

INSERT INTO REG_PD
			  (id_registro,
				num_progressivo, 
				data_competenza,
				data_registrazione,
				id_valuta,
				id_prof_registrazione,
				cambio,
				descrizione)
	 VALUES (:ll_id_registro,
				:ll_num_prog,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ll_id_valuta,
				:ll_id_prof_registrazione,
				:ld_cambio,
				'Rilevamento Ratei Passivi Economico') ;

SELECT id_reg_pd
 INTO :ll_id_reg_pd
 FROM REG_PD
WHERE id_registro=:ll_id_registro and 
		num_progressivo=:ll_num_prog and
		data_registrazione=:ld_data_registrazione;
		
IF SQLCA.SQLCODE<>0 THEN
	messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
	ELSE
		
		
		
		DECLARE ratei1_cur CURSOR FOR  
		  SELECT "ges_ratei_risconti"."flag_rat_ris",
					"ges_ratei_risconti"."rif_conto"  
			 FROM "ges_ratei_risconti"  
			WHERE "ges_ratei_risconti"."segno" = 'D'  AND 
					"ges_ratei_risconti"."tipo_record" = 'T' AND
					"ges_ratei_risconti"."quota_rat_ris" = 'S' AND
					"ges_ratei_risconti"."storno" = 'N';
		
			OPEN ratei1_cur;
			
		FETCH ratei1_cur INTO :ld_importo_ris, :ll_rif_conto;
		
		DO WHILE SQLCA.SQLCODE=0 
			
			ll_num_riga++
			
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				dare,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_rif_conto,
				:ll_id_valuta,
				:ld_importo_ris,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;

			FETCH ratei1_cur INTO :ld_importo_ris, :ll_rif_conto;
		LOOP
		
		CLOSE ratei1_cur;
		
		ll_num_riga++
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				avere,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_id_conto,
				:ll_id_valuta,
				:ld_tot_dare,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;
				
	 
	 
	 UPDATE "ges_ratei_risconti"  
		 SET "ges_ratei_risconti"."rif_scr_storno"=:ll_id_reg_pd,
			  "ges_ratei_risconti"."data_scr_storno"=:ld_data_registrazione,
			  "ges_ratei_risconti"."storno"= 'S'
	  WHERE "ges_ratei_risconti"."segno" = 'D' AND 
			  "ges_ratei_risconti"."tipo_record" = 'T' AND
			  "ges_ratei_risconti"."quota_rat_ris" = 'S' AND
			  "ges_ratei_risconti"."storno" = 'N';
			  
	 
	 messagebox("Information","Generato Storno Ratei Attivi n. "+string(ll_num_prog) )
END IF

end subroutine

public subroutine uf_genera_storno_rateo_avere (decimal ld_tot_avere);

long ll_id_prof_registrazione, ll_id_mod_registro, ll_id_conto, ll_id_esercizio
long ll_id_valuta, ll_id_registro, ll_num_prog, ll_id_reg_pd, ll_num_riga
long ll_rif_conto
integer li_delta
decimal ld_importo_ris, ld_cambio
date ld_data_registrazione

li_delta=1

SELECT "prof_registrazione"."id_prof_registrazione", 
		 "prof_registrazione"."id_mod_registro",
		 "prof_registrazione"."id_valuta"
  INTO :ll_id_prof_registrazione, :ll_id_mod_registro, :ll_id_valuta  
  FROM "par_wizard",   
		 "wizard",   
		 "prof_registrazione"  
WHERE ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
	  ( "par_wizard"."valore" = "prof_registrazione"."codice" ) AND  
	  ( ( "wizard"."codice" = 'RATRISC' ) AND  
	  ( "par_wizard"."num_ordine" = 1+:li_delta ) )   ;
	 

SELECT "prof_mov_contabile"."id_conto"  
  INTO :ll_id_conto  
  FROM "prof_mov_contabile"  
WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione ) AND  
	  ( "prof_mov_contabile"."num_riga" = 1 )   ;

ll_id_esercizio=dw_risconto_ff.getitemnumber(1,"id_esercizio")
SELECT "registro"."id_registro"  
  INTO :ll_id_registro  
  FROM "registro"  
WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
	  ( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
	SELECT "esercizio"."id_valuta"
	   INTO :ll_id_valuta
		FROM "esercizio"
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio;	

	
  SELECT "valuta"."cambio"  
    INTO :ld_cambio  
    FROM "valuta"  
   WHERE "valuta"."id_valuta" = :ll_id_valuta   ;

	  
SELECT max(num_progressivo)
  INTO :ll_num_prog
  FROM reg_pd
 WHERE reg_pd.id_registro=:ll_id_registro;
 
ll_num_prog++

ld_data_registrazione=dw_risconto_ff.getitemdate(1,"data_c")

INSERT INTO REG_PD
			  (id_registro,
				num_progressivo, 
				data_competenza,
				data_registrazione,
				id_valuta,
				id_prof_registrazione,
				cambio,
				descrizione)
	 VALUES (:ll_id_registro,
				:ll_num_prog,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ll_id_valuta,
				:ll_id_prof_registrazione,
				:ld_cambio,
				'Rilevamento Ratei Attivi Economico') ;

SELECT id_reg_pd
 INTO :ll_id_reg_pd
 FROM REG_PD
WHERE id_registro=:ll_id_registro and 
		num_progressivo=:ll_num_prog and
		data_registrazione=:ld_data_registrazione;
		
IF SQLCA.SQLCODE<>0 THEN
	messagebox("Errore","Si è verificato un errore nel salvataggio della testa!")
	ELSE
		
			
		
		DECLARE ratei1_cur CURSOR FOR  
		  SELECT "ges_ratei_risconti"."flag_rat_ris",
					"ges_ratei_risconti"."rif_conto"  
			 FROM "ges_ratei_risconti"  
			WHERE "ges_ratei_risconti"."segno" = 'A'  AND 
					"ges_ratei_risconti"."tipo_record" = 'T' AND
					"ges_ratei_risconti"."quota_rat_ris" = 'S' AND
					"ges_ratei_risconti"."storno" = 'N';
		
			OPEN ratei1_cur;
			
		FETCH ratei1_cur INTO :ld_importo_ris, :ll_rif_conto;
		
		DO WHILE SQLCA.SQLCODE=0 
			
			ll_num_riga++
			
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				avere,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_rif_conto,
				:ll_id_valuta,
				:ld_importo_ris,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;

			FETCH ratei1_cur INTO :ld_importo_ris, :ll_rif_conto;
		LOOP
		
		CLOSE ratei1_cur;
		
		ll_num_riga++
			INSERT INTO MOV_CONTABILE
			  (id_reg_pd,
				numero,
				id_conto,
				id_valuta,
				dare,
				data_inizio_competenza,
				data_fine_competenza,
				data_val_banca,
				cambio)
	 VALUES (:ll_id_reg_pd,
				:ll_num_riga,
				:ll_id_conto,
				:ll_id_valuta,
				:ld_tot_avere,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_data_registrazione,
				:ld_cambio) ;
				
	 
	 
	 UPDATE "ges_ratei_risconti"  
		 SET "ges_ratei_risconti"."rif_scr_storno"=:ll_id_reg_pd,
			  "ges_ratei_risconti"."data_scr_storno"=:ld_data_registrazione,
			  "ges_ratei_risconti"."storno"= 'S'
	  WHERE "ges_ratei_risconti"."segno" = 'A' AND 
			  "ges_ratei_risconti"."tipo_record" = 'T' AND
			  "ges_ratei_risconti"."quota_rat_ris" = 'S' AND
			  "ges_ratei_risconti"."storno" = 'N';
			  
    
	 messagebox("Information","Generato Storno Ratei Passivi n. "+string(ll_num_prog) )
END IF

end subroutine

on w_risconto_ff.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_risconto_ff=create dw_risconto_ff
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_risconto_ff
this.Control[iCurrent+4]=this.st_1
end on

on w_risconto_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_risconto_ff)
destroy(this.st_1)
end on

event open;call super::open;


datawindowchild ldw_id_esercizio
dw_risconto_ff.getchild("id_esercizio",ldw_id_esercizio)
ldw_id_esercizio.settransobject(sqlca)
ldw_id_esercizio.retrieve()

IF dw_risconto_ff.GetRow() = 0 THEN
	dw_risconto_ff.InsertRow(0)
END IF

long ll_id_esercizio_proposto
date ld_data_inizio, ld_data_fine

  SELECT "azienda"."id_esercizio_proposto"  
    INTO :ll_id_esercizio_proposto  
    FROM "azienda"  
   WHERE "azienda"."id_azienda" = 1   ;

	  SELECT "esercizio"."data_inizio",   
         "esercizio"."data_fine"  
    INTO :ld_data_inizio,   
         :ld_data_fine  
    FROM "esercizio"  
   WHERE "esercizio"."id_esercizio" = :ll_id_esercizio_proposto   ;

dw_risconto_ff.setitem(1,"id_esercizio",ll_id_esercizio_proposto)
dw_risconto_ff.setitem(1,"d_in",string(ld_data_inizio))
dw_risconto_ff.setitem(1,"d_fin",string(ld_data_fine))
dw_risconto_ff.setitem(1,"data_c",ld_data_fine)	


	


end event

event closequery;call super::closequery;

uf_feed_struct(ib_feed_struct)
end event

type cb_ok from commandbutton within w_risconto_ff
event clicked pbm_bnclicked
int X=50
int Y=40
int Width=274
int Height=84
int TabOrder=10
boolean BringToTop=true
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

string ls_param
ls_param=Message.StringParm
decimal ld_importo_ris, ld_tot_dare, ld_tot_avere
string ls_segno


IF ls_param="Risconto" THEN
	
	
	
	
	 DECLARE risconti_cur CURSOR FOR  
	  SELECT "ges_ratei_risconti"."flag_rat_ris","ges_ratei_risconti"."segno" 
		 FROM "ges_ratei_risconti"  
		WHERE "ges_ratei_risconti"."tipo_record" = 'S' AND
				"ges_ratei_risconti"."quota_rat_ris" = 'N';
	
		OPEN risconti_cur;
		
	FETCH risconti_cur INTO :ld_importo_ris, :ls_segno;
	
	DO WHILE SQLCA.SQLCODE=0 
		
		IF ls_segno='D' THEN
			ld_tot_dare=ld_tot_dare+ld_importo_ris
			  ELSE
				 ld_tot_avere=ld_tot_avere+ld_importo_ris
		END IF 
		FETCH risconti_cur INTO :ld_importo_ris, :ls_segno;
	
	LOOP
	
	CLOSE risconti_cur;
	
	IF ld_tot_dare>0 THEN
		uf_genera_risconti_dare(ld_tot_dare)
	END IF
	
	IF ld_tot_avere>0 THEN
		uf_genera_risconti_avere(ld_tot_avere)
	END IF
	
	IF (ld_tot_dare=0 OR isnull(ld_tot_dare) ) AND &
		(ld_tot_avere=0 OR isnull(ld_tot_avere) ) THEN
		messagebox("Controllo", "Non ci sono Scritture da generare!")
	END IF
	
END IF 



IF ls_param="Storno" THEN
	
	
	 DECLARE storni_cur CURSOR FOR  
	  SELECT "ges_ratei_risconti"."flag_rat_ris","ges_ratei_risconti"."segno" 
		 FROM "ges_ratei_risconti"  
		WHERE "ges_ratei_risconti"."tipo_record" = 'S' AND
				"ges_ratei_risconti"."quota_rat_ris" = 'S' AND
				"ges_ratei_risconti"."storno" = 'N';
	
		OPEN storni_cur;
		
	FETCH storni_cur INTO :ld_importo_ris, :ls_segno;
	
	DO WHILE SQLCA.SQLCODE=0 
		
		IF ls_segno='D' THEN
			ld_tot_dare=ld_tot_dare+ld_importo_ris
			  ELSE
				 ld_tot_avere=ld_tot_avere+ld_importo_ris
		END IF 
		FETCH storni_cur INTO :ld_importo_ris, :ls_segno;
	
	LOOP
	
	CLOSE storni_cur;
	
	IF ld_tot_dare>0 THEN
		uf_genera_storno_dare(ld_tot_dare)
	END IF
	
	IF ld_tot_avere>0 THEN
		uf_genera_storno_avere(ld_tot_avere)
	END IF
	
	IF (ld_tot_dare=0 OR isnull(ld_tot_dare) ) AND &
		(ld_tot_avere=0 OR isnull(ld_tot_avere) ) THEN
		messagebox("Controllo", "Non ci sono Storni da generare!")
	END IF
	
END IF 


IF ls_param="Rateo" THEN
	
	
	
	
	 DECLARE ratei_cur CURSOR FOR  
	  SELECT "ges_ratei_risconti"."flag_rat_ris","ges_ratei_risconti"."segno" 
		 FROM "ges_ratei_risconti"  
		WHERE "ges_ratei_risconti"."tipo_record" = 'T' AND
				"ges_ratei_risconti"."quota_rat_ris" = 'N';
	
		OPEN ratei_cur;
		
	FETCH ratei_cur INTO :ld_importo_ris, :ls_segno;
	
	DO WHILE SQLCA.SQLCODE=0 
		
		IF ls_segno='D' THEN
			ld_tot_dare=ld_tot_dare+ld_importo_ris
			  ELSE
				 ld_tot_avere=ld_tot_avere+ld_importo_ris
		END IF 
		FETCH ratei_cur INTO :ld_importo_ris, :ls_segno;
	
	LOOP
	
	CLOSE ratei_cur;
	
	IF ld_tot_dare>0 THEN
		uf_genera_rateo_dare(ld_tot_dare)
	END IF
	
	IF ld_tot_avere>0 THEN
		uf_genera_rateo_avere(ld_tot_avere)
	END IF
	
	IF (ld_tot_dare=0 OR isnull(ld_tot_dare) ) AND &
		(ld_tot_avere=0 OR isnull(ld_tot_avere) ) THEN
		messagebox("Controllo", "Non ci sono Scritture da generare!")
	END IF
	
END IF 



IF ls_param="Storno Rateo" THEN
	
	 DECLARE storni_rat_cur CURSOR FOR  
	  SELECT "ges_ratei_risconti"."flag_rat_ris","ges_ratei_risconti"."segno" 
		 FROM "ges_ratei_risconti"  
		WHERE "ges_ratei_risconti"."tipo_record" = 'T' AND
				"ges_ratei_risconti"."quota_rat_ris" = 'S' AND
				"ges_ratei_risconti"."storno" = 'N';
	
		OPEN storni_rat_cur;
		
	FETCH storni_rat_cur INTO :ld_importo_ris, :ls_segno;
	
	DO WHILE SQLCA.SQLCODE=0 
		
		IF ls_segno='D' THEN
			ld_tot_dare=ld_tot_dare+ld_importo_ris
			  ELSE
				 ld_tot_avere=ld_tot_avere+ld_importo_ris
		END IF 
		FETCH storni_rat_cur INTO :ld_importo_ris, :ls_segno;
	
	LOOP
	
	CLOSE storni_rat_cur;
	
	IF ld_tot_dare>0 THEN
		uf_genera_storno_rateo_dare(ld_tot_dare)
	END IF
	
	IF ld_tot_avere>0 THEN
		uf_genera_storno_rateo_avere(ld_tot_avere)
	END IF
	
	IF (ld_tot_dare=0 OR isnull(ld_tot_dare) ) AND &
		(ld_tot_avere=0 OR isnull(ld_tot_avere) ) THEN
		messagebox("Controllo", "Non ci sono Storni da generare!")
	END IF
	
END IF 

close(parent)
end event

type cb_annulla from commandbutton within w_risconto_ff
int X=343
int Y=40
int Width=261
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

ib_feed_struct = FALSE
Close(Parent)
end event

type dw_risconto_ff from u_dw_ext_main within w_risconto_ff
int X=46
int Y=340
int Width=1445
int Height=440
int TabOrder=2
string DataObject="d_risconto_ff"
end type

event ue_default;call super::ue_default;



end event

type st_1 from statictext within w_risconto_ff
int X=46
int Y=156
int Width=1445
int Height=136
boolean Enabled=false
boolean BringToTop=true
string Text="Immettere la data delle registrazioni di storno patrimoniale ed economico del risconto."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

