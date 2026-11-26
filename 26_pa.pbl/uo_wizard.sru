forward
global type uo_wizard from nonvisualobject
end type
end forward

global type uo_wizard from nonvisualobject
end type
global uo_wizard uo_wizard

type variables
DataStore	ids_wiz_profilo
DataStore	ids_wiz_profilo_mov_iva
DataStore	ids_wiz_profilo_mov_contabile
end variables

forward prototypes
public subroutine uf_create_ds ()
public subroutine uf_destroy_ds ()
public subroutine uf_attiva_ivasosp (long al_id_wizard)
public subroutine uf_attiva_ritacc ()
public subroutine uf_attiva_pag_ritenute (long al_id_reg_pd, date ad_data_registrazione, long al_num_progressivo, long al_id_wizard, long al_id_esercizio)
public subroutine uf_attiva_pag_risc ()
public subroutine uf_start (long al_id_reg_pd)
public function long uf_pagamento_ra (long al_id_reg_pd, date ad_data_reg, long al_id_wizard, long al_id_esercizio)
public function long uf_storno_ra (long al_idreg_pd, long al_idwizard, long al_id_esercizio)
public subroutine uf_attiva_ivacee (integer al_id_wizard, string al_cod_wiz)
public subroutine uf_attiva_cespiti (string ls_tipo_reg, long al_id_reg_pd)
public subroutine uf_attiva_rcharge03 (long al_id_wizard)
public subroutine uf_attiva_rcharge02 (long al_id_wizard)
public subroutine uf_attiva_rcharge (long al_id_wizard)
end prototypes

public subroutine uf_create_ds ();


ids_wiz_profilo = create datastore
ids_wiz_profilo.DataObject   = "d_wiz_profilo_ds"
ids_wiz_profilo.SetTransObject(SQLCA)

ids_wiz_profilo_mov_iva = create datastore
ids_wiz_profilo_mov_iva.DataObject = "d_wiz_profilo_mov_iva_ds"
ids_wiz_profilo_mov_iva.SetTransObject(SQLCA)

ids_wiz_profilo_mov_contabile = create datastore
ids_wiz_profilo_mov_contabile.DataObject = "d_wiz_profilo_mov_contabile_ds"
ids_wiz_profilo_mov_contabile.SetTransObject(SQLCA)




end subroutine

public subroutine uf_destroy_ds ();

IF IsValid(ids_wiz_profilo) THEN
	destroy ids_wiz_profilo
END IF

IF IsValid(ids_wiz_profilo_mov_iva) THEN
	destroy ids_wiz_profilo_mov_iva
END IF

IF IsValid(ids_wiz_profilo_mov_contabile) THEN
	destroy ids_wiz_profilo_mov_contabile
END IF
end subroutine

public subroutine uf_attiva_ivasosp (long al_id_wizard);


long ll_CurrRow_Reg_PD, ll_IDReg_PD_Par_Aperta, ll_SQL_Prof_Contabile
long ll_SQL_Mov_IVA, ll_reg_now
long ll_esercizio, ll_mod_reg
long ll_ID_Prof_Registrazione_Reg_PD1
string ls_descrizione_da_prof, ls_num_documento


u_reg_pd lu_reg_pd
long ll_id_registro, ll_num_progressivo, ll_id_prof_registrazione, ll_id_valuta 
long ll_id_conto, ll_id_azienda
date ld_data_competenza, ld_data_registrazione, ld_data_documento
decimal ldc_cambio, ldc_importo
string ls_descrizione
char lc_ges_oper_intracomunitarie

long ll_numero, lal_id_conto_mc[], lal_id_valuta_mc[], lal_prog_stampato[], ll_i
decimal ladc_cambio_mc[], ldc_importo_mc[]
string las_des_contabile[]
date lad_data_val_banca[]
char lc_segno_mc[], lc_segno

long lal_id_tab_iva[]
decimal ladc_imponibile[], ladc_imposta[]
boolean lb_mc_iva[]

long ll_id_conto_mc, ll_id_valuta_mc, ll_prog_stampato, ll_id_tab_iva
decimal ldc_cambio_mc, ldc_dare, ldc_avere, ldc_imponibile, ldc_imposta
string ls_des_contabile
date ld_data_val_banca

lu_reg_pd = create u_reg_pd


ll_CurrRow_Reg_PD = ids_wiz_profilo.GetRow()
ll_IDReg_PD_Par_Aperta       = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_reg_pd")
ll_id_registro               = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_registro")
ll_num_progressivo           = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_num_progressivo")
ld_data_competenza           = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_competenza")
ll_id_prof_registrazione     = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_prof_registrazione")
ld_data_registrazione        = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_registrazione")
ll_id_valuta                 = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_valuta")
ldc_cambio                   = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_cambio")
lc_ges_oper_intracomunitarie = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_ges_oper_intracomunitarie")
ls_num_documento             = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_num_documento")
ld_data_documento            = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_documento")
ll_id_azienda                = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_azienda")

long ll_mov_par, ll_reg_sosp, ll_partita

select id_esercizio into :ll_esercizio
from registro where id_registro=:ll_id_registro;

SELECT max(id_mov_partita) INTO :ll_mov_par  FROM mov_partita WHERE id_reg_pd=:ll_IDReg_PD_Par_Aperta;
SELECT id_par_aperta INTO :ll_partita FROM mov_partita WHERE id_mov_partita=:ll_mov_par;
SELECT id_reg_pd           INTO :ll_reg_sosp FROM par_aperta  WHERE id_par_aperta=:ll_partita;

SELECT id_conto, data_registrazione, descrizione
INTO :ll_id_conto , :ld_data_documento, :ls_descrizione
FROM reg_pd WHERE id_reg_pd=:LL_REG_SOSP;

SELECT sum(dare) INTO :LDC_IMPORTO
FROM mov_contabile 
WHERE id_reg_pd=:ll_IDReg_PD_Par_Aperta;


DECLARE lcur_mov_iva CURSOR FOR
  SELECT "mov_iva"."id_tab_iva"
	 FROM "mov_iva"
	WHERE "mov_iva"."id_reg_pd" = :ll_Reg_sosp ;

OPEN lcur_mov_iva;
ll_i = 0
FETCH lcur_mov_iva INTO :ll_id_tab_iva;		
ll_SQL_Mov_IVA = SQLCA.SQLCode
DO WHILE ll_SQL_Mov_IVA = 0
	ll_i ++
	lal_id_tab_iva[ll_i]  = ll_id_tab_iva
	FETCH lcur_mov_iva INTO :ll_id_tab_iva;
	ll_SQL_Mov_IVA = SQLCA.SQLCode
LOOP
CLOSE lcur_mov_iva;

decimal ld_per_iva, ld_det_iva
select per_aliquota, per_detrazione
into :ld_per_iva, :ld_det_iva
from tab_iva where id_tab_iva=:lal_id_tab_iva[1];

ladc_imponibile[1] = ROUND( (ldc_importo * 100) / (100 + ld_per_iva) , 2 )
ladc_imposta[1] = (ldc_importo - ladc_imponibile[1])

 SELECT "prof_registrazione"."id_prof_registrazione",
			"prof_registrazione"."descrizione",
			"prof_registrazione"."id_mod_registro"
	 INTO :ll_ID_Prof_Registrazione_Reg_PD1,
			:ls_descrizione_da_prof,
			:ll_mod_reg
	 FROM "par_wizard",
			"prof_registrazione"
	WHERE ( "par_wizard"."valore" = "prof_registrazione"."codice" ) and
			( "par_wizard"."id_wizard" = :al_id_wizard ) AND
			( "par_wizard"."num_ordine" = 1 ) ;

select id_registro into :ll_id_registro
from registro where  id_esercizio=:ll_esercizio
and id_mod_registro=:ll_mod_reg;


SELECT MAX("reg_pd"."num_progressivo")
	INTO :ll_num_progressivo
	FROM "reg_pd"
	WHERE "reg_pd"."id_registro" = :ll_ID_Registro;
IF IsNull(ll_num_progressivo) THEN
	ll_num_progressivo = 1
ELSE
	ll_num_progressivo = ll_num_progressivo + 1
END IF


lu_reg_pd.uf_Reset()
lu_reg_pd.uf_id_registro(ll_id_registro)
lu_reg_pd.uf_num_progressivo(ll_num_progressivo)
lu_reg_pd.uf_data_competenza(ld_data_competenza)
lu_reg_pd.uf_id_prof_registrazione(ll_ID_Prof_Registrazione_Reg_PD1)
lu_reg_pd.uf_data_registrazione(ld_data_registrazione)
lu_reg_pd.uf_id_valuta(ll_id_valuta)
lu_reg_pd.uf_cambio(ldc_cambio)
lu_reg_pd.uf_descrizione('Sosp.' + ls_descrizione)
lu_reg_pd.uf_ges_oper_intracomunitarie(lc_ges_oper_intracomunitarie)
lu_reg_pd.uf_num_documento(ls_num_documento)
lu_reg_pd.uf_data_documento(ld_data_documento)
lu_reg_pd.uf_importo(ldc_importo )
lu_reg_pd.uf_id_conto(ll_id_conto)
lu_reg_pd.uf_imponibile(ladc_imponibile)
lu_reg_pd.uf_id_tab_iva(lal_id_tab_iva)
lu_reg_pd.uf_imposta(ladc_imposta)

DECLARE lcur_mov_contabile CURSOR FOR
 SELECT  "prof_mov_contabile"."id_conto",
         "prof_mov_contabile"."des_contabile",
			"prof_mov_contabile"."segno"
	 FROM "prof_mov_contabile"
	WHERE "prof_mov_contabile"."id_prof_registrazione" = :ll_ID_Prof_Registrazione_Reg_PD1
ORDER BY "prof_mov_contabile"."num_riga" ASC  ;

OPEN lcur_mov_contabile;

FETCH lcur_mov_contabile INTO :ll_id_conto_mc,
                              :ls_des_contabile,
										:lc_segno;
											
ll_SQL_prof_Contabile = SQLCA.SQLCode

ll_i = 0
DO WHILE ll_SQL_prof_Contabile = 0
	
	ll_i ++                                           
	if ll_i=1 then
		ll_numero = 9999
	else	
	   ll_numero = ll_i
	end if
	
	lal_id_conto_mc[ll_i]            = ll_id_conto_mc
	lal_id_valuta_mc[ll_i]           = ll_id_valuta
	ladc_cambio_mc[ll_i]             = ldc_cambio
	las_des_contabile[ll_i]          = ls_des_contabile
	lc_segno_mc[ll_i]                = lc_segno
	ldc_importo_mc[ll_i]            = ladc_imposta[1]
	lad_data_val_banca[ll_i]         = ld_data_registrazione
		
	IF ll_numero = 9999 THEN
		lb_mc_iva[ll_i] = TRUE
	ELSE
		lb_mc_iva[ll_i] = FALSE
	END IF
		
	FETCH lcur_mov_contabile INTO :ll_id_conto_mc,
                              :ls_des_contabile,
										:lc_segno;

	ll_SQL_Prof_Contabile = SQLCA.SQLCode
	
LOOP
CLOSE lcur_mov_contabile;

lu_reg_pd.uf_id_conto_mc(lal_id_conto_mc)
lu_reg_pd.uf_id_valuta_mc(lal_id_valuta_mc)
lu_reg_pd.uf_cambio_mc(ladc_cambio_mc)
lu_reg_pd.uf_des_contabile(las_des_contabile)
lu_reg_pd.uf_importo_mc(ldc_importo_mc)
lu_reg_pd.uf_segno_mc(lc_segno_mc)
lu_reg_pd.uf_data_val_banca(lad_data_val_banca)
lu_reg_pd.uf_mc_iva(lb_mc_iva)

ll_reg_now=lu_reg_pd.uf_crea()


end subroutine

public subroutine uf_attiva_ritacc ();

long ll_row, ll_id_reg_pd
s_list_main lstr_for_win

ll_row = ids_wiz_profilo.GetRow()
lstr_for_win.s_modo = modo_modifica

IF ll_row > 0 THEN
	ll_id_reg_pd = ids_wiz_profilo.GetItemNumber(ll_row, "reg_pd_id_reg_pd")
	lstr_for_win.l_identifica[1] = ll_id_reg_pd

	OpenWithParm(w_rit_acconto_wz, lstr_for_win)
END IF
end subroutine

public subroutine uf_attiva_pag_ritenute (long al_id_reg_pd, date ad_data_registrazione, long al_num_progressivo, long al_id_wizard, long al_id_esercizio);

long ll_New_Reg_PD1, ll_New_Reg_PD2, ll_IDTributo, ll_IDConto, ll_SQL_Tributo, ll_id_par_aperta
long ll_IDFornitore
decimal ldc_rit_previdenziale, ldc_dare, ldc_avere, ldc_importo
date ld_data_reg

  SELECT "sog_commerciale"."id_tributo",
         "reg_pd"."id_conto"
    INTO :ll_IDTributo,
	 		:ll_IDConto
    FROM "conto",
         "reg_pd",
         "sog_commerciale"
   WHERE ( "reg_pd"."id_conto" = "conto"."id_conto" ) and
         ( "sog_commerciale"."id_conto" = "conto"."id_conto" ) and
         ( ( "reg_pd"."id_reg_pd" = :al_id_reg_pd) )   ;

ll_SQL_Tributo = SQLCA.SQLCode
IF IsNull(ll_IDConto) OR ll_IDConto = 0 THEN
	 DECLARE lcur_tributo CURSOR FOR
	  SELECT "sog_commerciale"."id_tributo",
	  			"anagrafica"."rit_previdenziale"
		 FROM "mov_contabile",
				"conto",
				"sog_commerciale",
				"anagrafica"
		WHERE ( "conto"."id_conto" = "mov_contabile"."id_conto" ) and
				( "sog_commerciale"."id_conto" = "conto"."id_conto" ) and
				( "anagrafica"."id_anagrafica" = "sog_commerciale"."id_anagrafica" ) and
				( "mov_contabile"."id_reg_pd" = :al_id_reg_pd);
				
	OPEN lcur_tributo;
	FETCH lcur_tributo INTO :ll_IDTributo, :ldc_rit_previdenziale;
	CLOSE lcur_tributo;
END IF

CHOOSE CASE ll_SQL_Tributo
	CASE 0, 100
		IF NOT IsNull(ll_IDTributo) OR ldc_rit_previdenziale > 0 THEN
			ll_New_Reg_PD1 = uf_storno_ra(al_id_reg_pd, al_id_wizard, al_id_esercizio)
		END IF
END CHOOSE

SELECT "par_aperta"."id_par_aperta"
	INTO :ll_id_par_aperta
	FROM "dba"."par_aperta"
	WHERE "par_aperta"."id_reg_pd" = :al_id_reg_pd;

CHOOSE CASE SQLCA.SQLCode
	CASE 100
		
		 DECLARE lcur_fornitore CURSOR FOR
		  SELECT "mov_contabile"."id_conto",
					"mov_contabile"."dare",
					"mov_contabile"."avere"
			 FROM "mov_contabile",
					"anagrafica",
					"conto",
					"sog_commerciale"
			WHERE ( "conto"."id_conto" = "mov_contabile"."id_conto" ) and
					( "sog_commerciale"."id_conto" = "conto"."id_conto" ) and
					( "sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and
					( ( "mov_contabile"."id_reg_pd" = :al_id_reg_pd) AND
					( "anagrafica"."nat_giuridica" = 'F' )); 
					

		OPEN lcur_fornitore;
		FETCH lcur_fornitore INTO :ll_IDFornitore, :ldc_dare, :ldc_avere;
		CLOSE lcur_fornitore;
		IF IsNull(ldc_dare) THEN
			ldc_importo = ldc_avere
		ELSEIF IsNull(ldc_avere) THEN
			ldc_importo = ldc_dare
		END IF

		ll_id_par_aperta = f_crea_par_aperta(ll_IDFornitore,          &
														 al_id_reg_pd,            &
														 al_num_progressivo,      &
														 ad_data_registrazione,   &
														 ad_data_registrazione,   &
														 u_freddie.gd_NULL,       &
														 '',                      &
														 ldc_importo,             &
														 'N',                     &
														 u_freddie.gl_NULL)
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / ue_attiva_pag_ritenute / 1")
		RETURN
END CHOOSE

ll_New_Reg_PD2 = uf_pagamento_ra(al_id_reg_pd, ad_data_registrazione, al_id_wizard, al_id_esercizio)
end subroutine

public subroutine uf_attiva_pag_risc ();

long ll_CurrRow, ll_id_reg_pd, ll_id_par_aperta

decimal ldc_importo, ldc_tot_partita, ldc_tot_movimenti, ldc_tot_imponibile, ldc_tot_iva
string las_array[]
date ld_data_documento
constant char lcc_separatore = "@"

ll_CurrRow = ids_wiz_profilo.GetRow()
ll_id_reg_pd = ids_wiz_profilo.GetItemNumber(ll_CurrRow, "reg_pd_id_reg_pd")

las_array[1] = "pag_risc"

las_array[2] = ids_wiz_profilo.GetItemString(ll_CurrRow, "cinfo_reg_pd")
las_array[3] = ids_wiz_profilo.GetItemString(ll_CurrRow, "cinfo_sc")

  SELECT "par_aperta"."id_par_aperta",
  			"par_aperta"."importo",
         sum("mov_partita"."importo")
    INTO :ll_id_par_aperta,
	 		:ldc_tot_partita,
         :ldc_tot_movimenti
    FROM {oj "par_aperta"  LEFT OUTER JOIN "mov_partita"  ON "par_aperta"."id_par_aperta" = "mov_partita"."id_par_aperta"}
   WHERE "par_aperta"."id_reg_pd" = :ll_id_reg_pd
GROUP BY "par_aperta"."id_par_aperta",
			"par_aperta"."importo" ;

las_array[4] = string(ldc_tot_partita)
las_array[5] = string(ldc_tot_movimenti)
las_array[6] = string(ids_wiz_profilo.GetItemNumber(ll_CurrRow, "registro_id_esercizio"))
las_array[7] = string(ids_wiz_profilo.GetItemNumber(ll_CurrRow, "reg_pd_id_conto"))


ids_wiz_profilo_mov_contabile.Retrieve(ll_id_reg_pd)
IF ids_wiz_profilo_mov_contabile.RowCount() > 0 THEN
	las_array[8] = ids_wiz_profilo_mov_contabile.GetItemString(1, "segno")
END IF

las_array[9] = string(ll_id_par_aperta) + lcc_separatore + string(ll_id_reg_pd)

ids_wiz_profilo_mov_iva.Retrieve(ll_id_reg_pd)
IF ids_wiz_profilo_mov_iva.RowCount() > 0 THEN
	ldc_tot_imponibile = ids_wiz_profilo_mov_iva.GetItemDecimal(1, "tot_imponibile")
	ldc_tot_iva = ids_wiz_profilo_mov_iva.GetItemDecimal(1, "tot_imposta")
END IF


las_array[10] = string(ldc_tot_imponibile) + lcc_separatore + string(ldc_tot_iva)

u_freddie.sp_push(las_array)

s_list_main lstr_for_win
lstr_for_win.s_modo = modo_modifica

OpenWithParm(w_pag_riscossioni_wz, lstr_for_win)
end subroutine

public subroutine uf_start (long al_id_reg_pd);

long ll_Rows, ll_i, ll_id_wizard, ll_num_progressivo, ll_id_esercizio, ll_id_prof_reg
string ls_wizard_codice,ls_tipo_reg, ls_nome_window
date ld_data_registrazione

ids_wiz_profilo.Retrieve(al_id_reg_pd)
ll_Rows = ids_wiz_profilo.RowCount()

IF ll_Rows > 0 THEN
	//11/06/14 metto il contatore per il progressivo nei registri a posto
	//(sembra che il trigger a volte fallisca proprio prima dei wizard!)
	w_registro_in_esercizio_gd w_contatori_prog
	w_contatori_prog=create w_registro_in_esercizio_gd
	open(w_contatori_prog)
	w_contatori_prog.cb_allinea_progressivi.triggerevent("clicked")
	destroy(w_contatori_prog)
	//fine 110614
	FOR ll_i = 1 TO ll_Rows
		ids_wiz_profilo.SetRow(ll_i)
		ls_wizard_codice      = ids_wiz_profilo.GetItemString(ll_i, "wizard_codice")
		ll_id_wizard          = ids_wiz_profilo.GetItemNumber(ll_i, "wizard_id_wizard")
		ld_data_registrazione = ids_wiz_profilo.GetItemDate(ll_i, "reg_pd_data_registrazione")
		ll_num_progressivo    = ids_wiz_profilo.GetItemNumber(ll_i, "reg_pd_num_progressivo")
		ll_id_esercizio       = ids_wiz_profilo.GetItemNumber(ll_i, "registro_id_esercizio")
		ls_nome_window        = ids_wiz_profilo.GetItemString(ll_i, "wizard_nome_window")
		
		
		ll_id_prof_reg= ids_wiz_profilo.GetItemNumber(ll_i, "reg_pd_id_prof_registrazione")
		
		select "tipo_registrazione"
   	into :ls_tipo_reg
		from prof_registrazione
		where "id_prof_registrazione"=:ll_id_prof_reg;
		
		
		
		CHOOSE CASE ls_wizard_codice
			CASE "IVASOSP"
				uf_attiva_ivasosp(ll_id_wizard)
			CASE "CESPITI"
				uf_attiva_cespiti(ls_tipo_reg,al_id_reg_pd)
			CASE "RITACC"
				uf_attiva_ritacc()
			CASE "PAGRIT"    
				uf_attiva_pag_ritenute(al_id_reg_pd, ld_data_registrazione, ll_num_progressivo, ll_id_wizard, ll_id_esercizio)
			CASE "PAGRIT/2"  
				uf_attiva_pag_ritenute(al_id_reg_pd, ld_data_registrazione, ll_num_progressivo, ll_id_wizard, ll_id_esercizio)
			CASE "IVACEE"
				
				uf_attiva_ivacee(ll_id_wizard,ls_wizard_codice)
				
			
			CASE "CEE_NC"
				
				uf_attiva_ivacee(ll_id_wizard, ls_wizard_codice)	
				
			CASE "CENCOSTO"
			CASE "PAGRISC"
				uf_attiva_pag_risc()
				
			CASE "TIBERGRA"
				
				
         
			case "COMMESSA"
         
			
			
			case "INTRA"
				openwithparm(w_intra_fronte_input_ff, al_id_reg_pd)			
			
			
			
			case "RCHARGE"
				uf_attiva_rcharge(ll_id_wizard)
				
			case "RCHARGE2"
				uf_attiva_rcharge02(ll_id_wizard)
			case "RCHARGE3"
				uf_attiva_rcharge03(ll_id_wizard)			
		END CHOOSE
	NEXT
END IF
end subroutine

public function long uf_pagamento_ra (long al_id_reg_pd, date ad_data_reg, long al_id_wizard, long al_id_esercizio);

long ll_IDProf_Registrazione, ll_id_conto, ll_id_par_aperta, ll_RetVal, ll_id_conto_mc[]
long ll_id_par_aperta_mc[]
decimal ldc_SommaNN, ldc_saldo, ldc_Somma, ldc_importo_mc[]
char lc_segno_mc[]
boolean lb_mc_iva[]

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

  SELECT "prof_registrazione"."id_prof_registrazione"  
    INTO :ll_IDProf_Registrazione  
    FROM "par_wizard",   
         "prof_registrazione"  
   WHERE ( "par_wizard"."valore" = "prof_registrazione"."codice" ) and  
         ( ( "par_wizard"."id_wizard" = :al_id_wizard) AND  
         ( "par_wizard"."num_ordine" = 2 ) )   ;

  SELECT "par_aperta"."id_par_aperta",   
         "par_aperta"."id_conto",   
         (ifnull(Somma, 0, Somma)) as SommaNN,   
         ("par_aperta"."importo" - SommaNN) as Saldo,   
         (sum("mov_partita"."importo")) as Somma
    INTO :ll_id_par_aperta,   
         :ll_id_conto,   
			:ldc_SommaNN,
         :ldc_Saldo,
			:ldc_Somma
    FROM {oj "par_aperta"  LEFT OUTER JOIN "mov_partita"  ON "par_aperta"."id_par_aperta" = "mov_partita"."id_par_aperta"}  
   WHERE "par_aperta"."id_reg_pd" = :al_id_reg_pd   
GROUP BY "par_aperta"."id_par_aperta",   
         "par_aperta"."id_conto" ,
         "par_aperta"."importo",
         "mov_partita"."importo",
         "par_aperta"."id_reg_pd";

IF ldc_saldo > 0 THEN
	lu_reg_pd.uf_id_prof_registrazione(ll_IDProf_Registrazione)
	lu_reg_pd.uf_data_registrazione(ad_data_reg)
	
	ldc_importo_mc[1] = ldc_saldo
	ll_id_conto_mc[1] = ll_id_conto
	lc_segno_mc[1] = "D"
	ll_id_par_aperta_mc[1] = ll_id_par_aperta
	lb_mc_iva[1] = FALSE
	
	ldc_importo_mc[2] = ldc_saldo
	ll_id_conto_mc[2] = 0
	lc_segno_mc[2] = "A"
	SetNull(ll_id_par_aperta_mc[2])
	lb_mc_iva[2] = FALSE
	
	lu_reg_pd.uf_importo_mc(ldc_importo_mc)
	lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
	lu_reg_pd.uf_segno_mc(lc_segno_mc)
	lu_reg_pd.uf_id_par_aperta(ll_id_par_aperta_mc)
	lu_reg_pd.uf_crea_mov_partita(TRUE)
	lu_reg_pd.uf_mc_iva(lb_mc_iva)
	
	ll_RetVal = lu_reg_pd.uf_crea()

	IF ll_RetVal > 0 THEN
		f_aggiorna_data_compenso(al_id_reg_pd, ad_data_reg)
	END IF
END IF

RETURN 0
end function

public function long uf_storno_ra (long al_idreg_pd, long al_idwizard, long al_id_esercizio);

long ll_IDProf_Registrazione_w, ll_IDProf_Registrazione, ll_IDAttivita, ll_IDEsercizio
long ll_Min_Num_Registro, ll_IDRegistro, ll_Num_Reg, ll_IDValuta, ll_IDReg_PD, ll_IDCompenso
long ll_New_IDReg_PD, ll_num_riga, ll_id_conto, ll_SQL_mov_contabile1, ll_SQL_mov_contabile2
long ll_SQL_mov_contabile3, ll_SQL_mov_contabile4, ll_IDFornitore, ll_IDPar_Aperta
long ll_SQL_mov_partita, ll_old_num_reg, ll_NULL, ll_i, ld_old_id_esercizio

string ls_cod_prof_registrazione, ls_tipo_registrazione, ls_Par_Menu, ls_descrizione_registro
string ls_Descrizione_Profilo, ls_des_contabile, ls_segno, ls_NULL

decimal ldc_cambio, ldc_rit_acconto, ldc_rit_previdenziale, ldc_imp_ritenuta, ldc_per_rit_previdenziale
decimal ldc_importo, ldc_dare, ldc_avere, ldc_old_importo, ldc_importo_null, ldc_istituti_prev

date ld_Data_Reg, ld_old_data_reg, ld_NULL

integer li_RetVal

long lal_id_conto_mc[], lal_id_par_aperta[]
decimal ladc_importo_mc[]
char lac_segno_mc[]

u_reg_pd lu_reg_pd

lu_reg_pd = create u_reg_pd

SetNull(ldc_importo_null)
SetNull(ls_NULL)
SetNull(ll_NULL)
SetNull(ld_NULL)

ll_IDReg_PD = al_IDReg_PD

  SELECT "compenso"."id_compenso",
         "compenso"."rit_acconto",
         "compenso"."rit_previdenziale",
         "compenso"."imp_ritenuta",
         "compenso"."per_rit_previdenziale",
			"reg_pd"."id_conto",
			"reg_pd"."num_progressivo",
			"reg_pd"."data_registrazione",
			"registro"."id_esercizio"
    INTO :ll_IDCompenso,
         :ldc_rit_acconto,
         :ldc_rit_previdenziale,
         :ldc_imp_ritenuta,
         :ldc_per_rit_previdenziale,
			:ll_IDFornitore,
			:ll_old_num_reg,
			:ld_old_data_reg,
			:ld_old_id_esercizio
    FROM "reg_pd",   
         "compenso",
			"registro"
   WHERE ( "reg_pd"."id_reg_pd" = :ll_IDReg_PD ) and  
         ( "compenso"."id_reg_pd" = "reg_pd"."id_reg_pd" ) and
			( "registro"."id_registro" = "reg_pd"."id_registro");

CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase","f_storno_ra / 1")
		RETURN 0
END CHOOSE

IF IsNull(ldc_rit_previdenziale) THEN 
	ldc_rit_previdenziale = 0
	ldc_istituti_prev = 0
ELSE
	ldc_istituti_prev = Round((ldc_imp_ritenuta / 100 * ldc_per_rit_previdenziale), 0)
END IF

IF IsNull(ll_IDFornitore) OR ll_IDFornitore = 0 THEN
	 DECLARE lcur_fornitore CURSOR FOR  
	  SELECT "mov_contabile"."id_conto",
	         "mov_contabile"."dare",
				"mov_contabile"."avere"
		 FROM "mov_contabile",   
				"anagrafica",   
				"conto",   
				"sog_commerciale"  
		WHERE ( "conto"."id_conto" = "mov_contabile"."id_conto" ) and  
				( "sog_commerciale"."id_conto" = "conto"."id_conto" ) and  
				( "sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and  
				( ( "mov_contabile"."id_reg_pd" = :ll_IDReg_PD ) AND  
				( "anagrafica"."nat_giuridica" = 'F' )); 
				
				
	OPEN lcur_fornitore;
	FETCH lcur_fornitore INTO :ll_IDFornitore, :ldc_dare, :ldc_avere;
	CLOSE lcur_fornitore;
	IF IsNull(ldc_dare) THEN
		ldc_old_importo = ldc_avere
	ELSEIF IsNull(ldc_avere) THEN
		ldc_old_importo = ldc_dare		
	END IF
END IF

  SELECT "prof_registrazione"."id_prof_registrazione"  
    INTO :ll_IDProf_Registrazione
    FROM "par_wizard",   
         "prof_registrazione"  
   WHERE ( "par_wizard"."valore" = "prof_registrazione"."codice" ) and  
         ( ( "par_wizard"."id_wizard" = :al_IDWizard ) AND  
         ( "par_wizard"."num_ordine" = 1 ) )   ;

CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / ue_attiva_storno_ra / 1")
		RETURN 0
END CHOOSE

lu_reg_pd.uf_Reset()
lu_reg_pd.uf_id_prof_registrazione(ll_IDProf_Registrazione)


lu_reg_pd.uf_data_registrazione(ld_old_data_reg)

ll_IDValuta = f_proponi_valuta(ll_IDFornitore, ld_old_id_esercizio)
lu_reg_pd.uf_id_valuta(ll_IDValuta)
lu_reg_pd.uf_cambio(1)

 DECLARE lcur_movimenti CURSOR FOR  
  SELECT "prof_mov_contabile"."num_riga",   
         "prof_mov_contabile"."id_conto",   
         "prof_mov_contabile"."des_contabile",   
         "prof_mov_contabile"."importo",   
         "prof_mov_contabile"."segno"  
    FROM "prof_mov_contabile"  
   WHERE "prof_mov_contabile"."id_prof_registrazione" = :ll_IDProf_Registrazione   
ORDER BY "prof_mov_contabile"."num_riga" ASC  ;

OPEN lcur_movimenti;

FETCH lcur_movimenti INTO :ll_num_riga, :ll_id_conto, :ls_des_contabile, :ldc_importo, :ls_segno;
ll_i = 1

DO WHILE SQLCA.SQLCode = 0
	
	CHOOSE CASE ll_num_riga
		CASE 1
			IF (ldc_rit_acconto > 0) OR (ldc_istituti_prev > 0) THEN
				
				lal_id_conto_mc[ll_i] = ll_IDFornitore
				ladc_importo_mc[ll_i] = (ldc_rit_acconto + ldc_rit_previdenziale)
				lac_segno_mc[ll_i] = "D"
				
				
				SELECT "par_aperta"."id_par_aperta"
					INTO :ll_IDPar_Aperta
					FROM "par_aperta"
					WHERE "par_aperta"."id_reg_pd" = :ll_IDReg_PD;
				
				CHOOSE CASE SQLCA.SQLCode
					CASE 0
						lal_id_par_aperta[ll_i] = ll_IDPar_Aperta
	
					CASE 100
						
						ll_IDPar_Aperta = f_crea_par_aperta(ll_IDFornitore,    &
																		ll_IDReg_PD,       &
																		ll_old_num_reg,    &
																		ld_old_data_reg,   &
																		ld_old_data_reg,   &
																		ld_NULL,           &
																		'',                &
																		ldc_old_importo,   &
																		'N',               &
																		ll_NULL)
						lal_id_par_aperta[ll_i] = ll_IDPar_Aperta
				END CHOOSE
			END IF
		CASE 2
			IF (ldc_istituti_prev - ldc_rit_previdenziale) > 0 THEN
				
				lal_id_conto_mc[ll_i] = ll_id_conto
				ladc_importo_mc[ll_i] = (ldc_istituti_prev - ldc_rit_previdenziale)
				lac_segno_mc[ll_i] = "D"
				SetNull(lal_id_par_aperta[ll_i])
			END IF														
			
		CASE 3
			IF ldc_rit_acconto > 0 THEN
				
				lal_id_conto_mc[ll_i] = ll_id_conto
				ladc_importo_mc[ll_i] = ldc_rit_acconto
				lac_segno_mc[ll_i] = "A"
				SetNull(lal_id_par_aperta[ll_i])
			END IF
		CASE 4			
			IF ldc_istituti_prev > 0 THEN
				
				lal_id_conto_mc[ll_i] = ll_id_conto
				ladc_importo_mc[ll_i] = ldc_istituti_prev
				lac_segno_mc[ll_i] = "A"
				SetNull(lal_id_par_aperta[ll_i])
			END IF
			
	END CHOOSE

	FETCH lcur_movimenti INTO :ll_num_riga, :ll_id_conto, :ls_des_contabile, :ldc_importo, :ls_segno;
	ll_i ++
LOOP

CLOSE lcur_movimenti;

lu_reg_pd.uf_id_par_aperta(lal_id_par_aperta)
lu_reg_pd.uf_crea_mov_partita(TRUE)
lu_reg_pd.uf_id_conto_mc(lal_id_conto_mc)
lu_reg_pd.uf_importo_mc(ladc_importo_mc)
lu_reg_pd.uf_segno_mc(lac_segno_mc)

lu_reg_pd.uf_crea()

IF IsValid(lu_reg_pd) THEN
	Destroy lu_reg_pd
END IF

RETURN ll_New_IDReg_PD
end function

public subroutine uf_attiva_ivacee (integer al_id_wizard, string al_cod_wiz);

long ll_CurrRow_Reg_PD, ll_IDReg_PD, ll_IDProf_Registrazione, ll_IDRegistro, ll_num_progressivo
long ll_IDFornitore, ll_IDValuta, ll_IDAzienda 
long ll_id_esercizio 
long ll_ret, ll_par, ll_mov, ll_scad
decimal ld_imp, ld_importo_scad
date ld_data_scad
string ls_descrizione, ls_descr_registro, ls_num_documento
date ld_data_registrazione, ld_data_competenza, ld_data_documento
decimal ldc_cambio, ldc_importo, ldc_importo_val
char lc_ges_oper_intracomunitarie
string ls_tipo_fatt

decimal ldc_imponibile[], ldc_imposta[]
long ll_id_tab_iva[], ll_i
string ls_descrizione_profilo

decimal ldc_cambio_mc, ldc_dare_1, ldc_avere_1, ldc_dare_9999, ldc_avere_9999, ldc_dare_cp
decimal ldc_avere_cp, ldc_importo_mc[], ladc_cambio_mc[]
long ll_IDValuta_mc, ll_id_conto_iva_profilo, ll_id_conto_mc[], lal_id_valuta_mc[]
char lc_segno_mc[]
boolean lb_mc_iva[]

long ll_SQL_Reg_PD_New, ll_SQL_Mov_IVA_New, ll_SQL_Mov_Contabile_New, ll_id_reg_pd_new
long ll_IDReg_PD_generata_esistente
string ls_cod_profilo, ls_segno_1, ls_segno_9999
decimal ldc_NULL, ldc_temp 
integer li_RetVal

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

SetNull(ldc_NULL)
ll_CurrRow_Reg_PD = ids_wiz_profilo.GetRow()
ll_IDReg_PD = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_reg_pd")


SELECT "reg_pd"."id_reg_pd"
	INTO :ll_IDReg_PD_generata_esistente
	FROM "reg_pd"
	WHERE "reg_pd"."id_reg_pd_padre" = :ll_IDReg_PD;

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		DELETE FROM "mov_contabile"
		   WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
		DELETE FROM "mov_iva"
		   WHERE "mov_iva"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
		DELETE FROM "reg_pd"
		   WHERE "reg_pd"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / ue_attiva_ivacee / 5")
END CHOOSE

ll_IDReg_PD                  = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_reg_pd")
ll_IDRegistro                = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_registro")
ll_num_progressivo           = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_num_progressivo")
ld_data_competenza           = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_competenza")
ll_IDProf_Registrazione      = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_prof_registrazione")
ld_data_registrazione        = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_registrazione")
ll_IDValuta                  = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_valuta")
ldc_cambio                   = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_cambio")
ldc_importo                  = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_importo")
ls_descrizione               = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_descrizione")
lc_ges_oper_intracomunitarie = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_ges_oper_intracomunitarie")
ls_num_documento             = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_num_documento")
ld_data_documento            = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_documento")
ll_IDFornitore               = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_conto")
ll_IDAzienda                 = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_azienda")
ldc_importo_val              = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_imp_valuta")

ll_id_esercizio              = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "registro_id_esercizio") 

                                                                      
		




	 SELECT "registro"."id_registro",
		     "registro"."descrizione"
	 INTO :ll_IDRegistro,
			:ls_descr_registro
    FROM "mod_registro",   
         "par_wizard",   
         "registro",   
         "wizard" ,
			"azienda"
   WHERE ( "registro"."id_mod_registro" = "mod_registro"."id_mod_registro" ) and  
         ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
         ( string ("mod_registro"."id_mod_registro" ) = "par_wizard"."valore" ) and

			
			
			("registro"."id_esercizio" =:ll_id_esercizio ) and
			
			
			("azienda"."id_azienda" = 1) 
			and ("wizard"."codice" = 'IVACEE'); 

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Errore sul DataBase", "w_reg_pd_cx / ue_attiva_ivacee / 2")
END IF

SELECT MAX("reg_pd"."num_progressivo")
	INTO :ll_num_progressivo
	FROM "reg_pd"
	WHERE "reg_pd"."id_registro" = :ll_IDRegistro;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Errore sul DataBase", "w_reg_pd_cx / ue_attiva_ivacee / 3")
END IF

IF IsNull(ll_num_progressivo) THEN ll_num_progressivo = 0
ll_num_progressivo = ll_num_progressivo + 1

  SELECT "prof_registrazione"."id_prof_registrazione",
			"prof_registrazione"."descrizione",
			"prof_registrazione"."id_conto_iva",
			
			"prof_registrazione"."tipo_fattura"
	 INTO :ll_IDProf_Registrazione,
			:ls_descrizione_profilo,
			:ll_id_conto_iva_profilo,
			
			:ls_tipo_fatt
			
	 FROM "par_wizard",
			"prof_registrazione"
	WHERE ( "par_wizard"."valore" = "prof_registrazione"."codice" ) and
			( ( "par_wizard"."id_wizard" = :al_id_wizard) )  and
			( "par_wizard"."num_ordine" = 1 ) ;


 DECLARE lcur_mov_iva CURSOR FOR
  SELECT "mov_iva"."imponibile",
			"mov_iva"."id_tab_iva",
			"mov_iva"."imposta",
			"mov_iva"."id_azienda"
	 FROM "mov_iva"
	WHERE "mov_iva"."id_reg_pd" = :ll_IDReg_PD   ;

OPEN lcur_mov_iva;

ll_i = 1
FETCH lcur_mov_iva INTO :ldc_imponibile[ll_i], :ll_id_tab_iva[ll_i], :ldc_imposta[ll_i], :ll_IDAzienda;

ll_SQL_Mov_IVA_New = 0

DO WHILE SQLCA.SQLCode = 0
	ll_i ++
	FETCH lcur_mov_iva INTO :ldc_imponibile[ll_i], :ll_id_tab_iva[ll_i], :ldc_imposta[ll_i], :ll_IDAzienda;
LOOP
CLOSE lcur_mov_iva;


ll_SQL_Mov_Contabile_New = 0

SELECT "mov_contabile"."dare",
		 "mov_contabile"."avere",
		 "mov_contabile"."id_valuta",
		 "mov_contabile"."cambio"
	INTO :ldc_dare_1,
		  :ldc_avere_1,
		  :ll_IDValuta_mc,
		  :ldc_cambio_mc
	FROM "mov_contabile"
	WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD AND
			"mov_contabile"."numero" = 1;

ldc_temp = ldc_dare_1
ldc_dare_1 = ldc_avere_1
ldc_avere_1 = ldc_temp

long ll_conto_9999
SELECT "mov_contabile"."dare", "mov_contabile"."avere", "mov_contabile"."id_conto"
	INTO :ldc_dare_9999, :ldc_avere_9999, :ll_conto_9999
	FROM "mov_contabile"
	WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD AND
         "mov_contabile"."numero" = 9999;

ldc_temp = ldc_dare_9999
ldc_dare_9999 = ldc_avere_9999
ldc_avere_9999 = ldc_temp

ll_id_conto_mc[1] = ll_IDFornitore
IF IsNull(ldc_dare_1) THEN
	ldc_importo_mc[1] = ldc_avere_1
	lc_segno_mc[1] = "A"
ELSE
	ldc_importo_mc[1] = ldc_dare_1
	lc_segno_mc[1] = "D"
END IF
lb_mc_iva[1] = FALSE
lal_id_valuta_mc[1] = ll_IDValuta_mc
ladc_cambio_mc[1] = ldc_cambio_mc


ll_id_conto_mc[3] = ll_conto_9999
IF IsNull(ldc_dare_9999) THEN
	ldc_importo_mc[3] = ldc_avere_9999
	lc_segno_mc[3] = "A"
ELSE
	ldc_importo_mc[3] = ldc_dare_9999
	lc_segno_mc[3] = "D"
END IF

lb_mc_iva[3] = TRUE
lal_id_valuta_mc[3] = ll_IDValuta_mc
ladc_cambio_mc[3] = ldc_cambio_mc


IF IsNull(ldc_dare_1) THEN
	ldc_dare_cp = ldc_avere_1 - ldc_dare_9999
	ldc_avere_cp = ldc_NULL
ELSEIF IsNull(ldc_avere_1) THEN
	ldc_dare_cp = ldc_NULL
	ldc_avere_cp = ldc_dare_1 - ldc_avere_9999
END IF

ll_id_conto_mc[2] = ll_IDFornitore
IF IsNull(ldc_dare_cp) THEN
	ldc_importo_mc[2] = ldc_avere_cp
	lc_segno_mc[2] = "A"
ELSE
	ldc_importo_mc[2] = ldc_dare_cp
	lc_segno_mc[2] = "D"
END IF
lb_mc_iva[2] = FALSE
lal_id_valuta_mc[2] = ll_IDValuta_mc
ladc_cambio_mc[2] = ldc_cambio_mc


lu_reg_pd.uf_DisplayMode(2)
lu_reg_pd.uf_Reset()
lu_reg_pd.uf_tipo_fattura(ls_tipo_fatt)
lu_reg_pd.uf_id_registro(ll_IDRegistro)
lu_reg_pd.uf_num_progressivo(ll_num_progressivo)
lu_reg_pd.uf_data_competenza(ld_data_competenza)
lu_reg_pd.uf_id_prof_registrazione(ll_IDProf_Registrazione)
lu_reg_pd.uf_data_registrazione(ld_data_registrazione)
lu_reg_pd.uf_id_valuta(ll_IDValuta)
lu_reg_pd.uf_cambio(ldc_cambio)
lu_reg_pd.uf_importo(ldc_importo)
lu_reg_pd.uf_descrizione(ls_descrizione_profilo)
lu_reg_pd.uf_ges_oper_intracomunitarie(lc_ges_oper_intracomunitarie)
lu_reg_pd.uf_num_documento(ls_num_documento)
lu_reg_pd.uf_data_documento(ld_data_documento)
lu_reg_pd.uf_id_conto(ll_IDFornitore)
lu_reg_pd.uf_id_azienda(ll_IDAzienda)
lu_reg_pd.uf_id_reg_pd_padre(ll_IDReg_PD)
lu_reg_pd.uf_imp_valuta(ldc_importo_val)

lu_reg_pd.uf_imponibile(ldc_imponibile)
lu_reg_pd.uf_id_tab_iva(ll_id_tab_iva)
lu_reg_pd.uf_imposta(ldc_imposta)

lu_reg_pd.uf_importo_mc(ldc_importo_mc)
lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
lu_reg_pd.uf_segno_mc(lc_segno_mc)
lu_reg_pd.uf_mc_iva(lb_mc_iva)
lu_reg_pd.uf_id_valuta_mc(lal_id_valuta_mc)
lu_reg_pd.uf_cambio_mc(ladc_cambio_mc)

ll_ret=lu_reg_pd.uf_crea()

IF ll_ret > 0 then 
			
		select id_par_aperta into :ll_par
		from par_aperta where id_reg_pd=:ll_idreg_pd;

      
		IF al_cod_wiz='CEE_NC' THEN
			select id_mov_contabile, dare into :ll_mov, :ld_imp
			from mov_contabile where id_reg_pd=:ll_ret and numero=9999;
		ELSE
			select id_mov_contabile, avere into :ll_mov, :ld_imp
			from mov_contabile where id_reg_pd=:ll_ret and numero=9999;
		END IF
		
		
		INSERT INTO mov_partita (id_par_aperta, id_mov_contabile, id_reg_pd, num_riga_mov_contabile, data, importo, imp_valuta, id_azienda)
	    			  VALUES (:ll_par, :ll_mov, :ll_ret, 9999, :ld_data_registrazione, :ld_imp, :ld_imp, 1);

		commit;
  
		DECLARE lcur_scad CURSOR FOR
		SELECT id_scadenza,importo, data_scadenza
		FROM scadenza
		WHERE id_par_aperta=:ll_par and ( esito_pagamento='E' or esito_pagamento='D' )
		order by data_scadenza;

		OPEN lcur_scad;
		FETCH lcur_scad INTO :ll_scad, :ld_importo_scad, :ld_data_scad;

		DO WHILE ( SQLCA.SQLCode = 0 ) and ld_imp>0
			CHOOSE CASE ld_importo_scad
				
				CASE ld_imp
					INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",     
								"id_azienda" )  
					VALUES ( null,   
								:ll_scad,   
								:ll_mov,   
								:ld_data_scad,   
								:ld_importo_scad,   
								:ld_importo_scad,    
								1 )  ;			  
					if sqlca.sqlcode<>0 then
						messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
					else
						update scadenza
						set esito_pagamento='P'
						where id_scadenza=:ll_scad;
					end if
					ld_imp=0
						
				CASE is>ld_imp
					INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",     
								"id_azienda" )  
					VALUES ( null,   
								:ll_scad,   
								:ll_mov,   
								:ld_data_scad,   
								:ld_imp,   
								:ld_imp,    
								1 )  ;			  
					if sqlca.sqlcode<>0 then
						messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
					end if
					ld_imp=0
					
				CASE is<ld_imp	
					INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",     
								"id_azienda" )  
					VALUES ( null,   
								:ll_scad,   
								:ll_mov,   
								:ld_data_scad,   
								:ld_importo_scad,   
								:ld_importo_scad,    
								1 )  ;			  
					if sqlca.sqlcode<>0 then
						messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
					else
						update scadenza
						set esito_pagamento='P'
						where id_scadenza=:ll_scad;	
					end if
					ld_imp=ld_imp - ld_importo_scad
					
			END CHOOSE
			FETCH lcur_scad INTO :ll_scad, :ld_importo_scad, :ld_data_scad;
		LOOP	

	CLOSE lcur_scad;
   commit;
	
END IF

IF IsValid(lu_reg_pd) THEN
	Destroy lu_reg_pd
END IF
end subroutine

public subroutine uf_attiva_cespiti (string ls_tipo_reg, long al_id_reg_pd);

s_list_main str_cespiti 

str_cespiti.s_aux[1]=string(ids_wiz_profilo.getitemdate(1,'reg_pd_data_documento'))
str_cespiti.s_aux[2]=string(ids_wiz_profilo.getitemnumber(1,'reg_pd_id_valuta'))
str_cespiti.s_aux[3]=string(ids_wiz_profilo.getitemnumber(1,'registro_id_esercizio'))
str_cespiti.s_aux[4]=string(ids_wiz_profilo.getitemnumber(1,'reg_pd_id_conto'))
str_cespiti.s_aux[6]=string(ids_wiz_profilo.getitemnumber(1,'reg_pd_id_prof_registrazione'))
str_cespiti.s_aux[7]=string(ids_wiz_profilo.getitemnumber(1,'reg_pd_id_reg_pd'))
str_cespiti.s_aux[8]=string(ids_wiz_profilo.getitemnumber(1,'reg_pd_num_progressivo'))
str_cespiti.s_aux[9]=string(ids_wiz_profilo.getitemdate(1,'reg_pd_data_registrazione'))

ids_wiz_profilo_mov_iva.Retrieve(al_id_reg_pd)
str_cespiti.s_aux[5]=string(ids_wiz_profilo_mov_iva.getitemdecimal(ids_wiz_profilo_mov_iva.rowcount(),'tot_imponibile'))

OPENWITHPARM(w_cespite_ff,str_cespiti)








end subroutine

public subroutine uf_attiva_rcharge03 (long al_id_wizard);
long ll_CurrRow_Reg_PD, ll_IDReg_PD, ll_IDProf_Registrazione, ll_IDRegistro, ll_num_progressivo
long ll_IDFornitore, ll_IDValuta, ll_IDAzienda 
long ll_id_esercizio 
string ls_descrizione, ls_descr_registro, ls_num_documento
date ld_data_registrazione, ld_data_competenza, ld_data_documento
decimal ldc_cambio, ldc_importo, ldc_importo_val
char lc_ges_oper_intracomunitarie
integer i
decimal ldc_imponibile[], ldc_imposta[]
long ll_id_tab_iva[], ll_i
string ls_descrizione_profilo

decimal ldc_cambio_mc, ldc_dare_1, ldc_avere_1, ldc_dare_9999, ldc_avere_9999, ldc_dare_cp
decimal ldc_avere_cp, ldc_importo_mc[], ladc_cambio_mc[]
long ll_IDValuta_mc, ll_id_conto_iva_profilo, ll_id_conto_mc[], lal_id_valuta_mc[]
char lc_segno_mc[]
boolean lb_mc_iva[]

long ll_SQL_Reg_PD_New, ll_SQL_Mov_IVA_New, ll_SQL_Mov_Contabile_New, ll_id_reg_pd_new
long ll_IDReg_PD_generata_esistente
string ls_cod_profilo, ls_segno_1, ls_segno_9999
decimal ldc_NULL, ldc_temp 
integer li_RetVal

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

SetNull(ldc_NULL)
ll_CurrRow_Reg_PD = ids_wiz_profilo.GetRow()
ll_IDReg_PD = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_reg_pd")


SELECT "reg_pd"."id_reg_pd"
	INTO :ll_IDReg_PD_generata_esistente
	FROM "reg_pd"
	WHERE "reg_pd"."id_reg_pd_padre" = :ll_IDReg_PD;

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		DELETE FROM "mov_contabile"
		   WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
		DELETE FROM "mov_iva"
		   WHERE "mov_iva"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
		DELETE FROM "reg_pd"
		   WHERE "reg_pd"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / 5")
END CHOOSE

ll_IDReg_PD                  = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_reg_pd")
ll_IDRegistro                = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_registro")
ll_num_progressivo           = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_num_progressivo")
ld_data_competenza           = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_competenza")
ll_IDProf_Registrazione      = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_prof_registrazione")
ld_data_registrazione        = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_registrazione")
ll_IDValuta                  = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_valuta")
ldc_cambio                   = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_cambio")
ldc_importo                  = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_importo")
ls_descrizione               = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_descrizione")
lc_ges_oper_intracomunitarie = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_ges_oper_intracomunitarie")
ls_num_documento             = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_num_documento")
ld_data_documento            = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_documento")
ll_IDFornitore               = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_conto")
ll_IDAzienda                 = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_azienda")
ldc_importo_val              = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_imp_valuta")
ll_id_esercizio              = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "registro_id_esercizio") 

	 SELECT "registro"."id_registro",
		     "registro"."descrizione"
	 INTO :ll_IDRegistro,
			:ls_descr_registro
    FROM "mod_registro",   
         "par_wizard",   
         "registro",   
         "wizard" ,
			"azienda"
   WHERE ( "registro"."id_mod_registro" = "mod_registro"."id_mod_registro" ) and  
         ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
         ( string ("mod_registro"."id_mod_registro" ) = "par_wizard"."valore" ) and
			("registro"."id_esercizio" =:ll_id_esercizio ) and
			("azienda"."id_azienda" = 1) 
			and "wizard"."codice"='RCHARGE3';

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Errore sul DataBase", "w_reg_pd_cx / 2")
END IF



SELECT "registro"."num_progressivo"
INTO :ll_num_progressivo
FROM "registro"
WHERE "registro"."id_registro" = :ll_IDRegistro;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Errore sul DataBase: num_prog non recuperato!", "w_reg_pd_cx / 3")
END IF

IF IsNull(ll_num_progressivo) THEN ll_num_progressivo = 1

  SELECT "prof_registrazione"."id_prof_registrazione",
			"prof_registrazione"."descrizione",
			"prof_registrazione"."id_conto_iva"
	 INTO :ll_IDProf_Registrazione,
			:ls_descrizione_profilo,
			:ll_id_conto_iva_profilo
	 FROM "par_wizard",
			"prof_registrazione"
	WHERE ( "par_wizard"."valore" = "prof_registrazione"."codice" ) and
			( ( "par_wizard"."id_wizard" = :al_id_wizard) )  and
			( "par_wizard"."num_ordine" = 1 ) ;


 DECLARE lcur_mov_iva CURSOR FOR
  SELECT "mov_iva"."imponibile",
			"mov_iva"."id_tab_iva",
			"mov_iva"."imposta",
			"mov_iva"."id_azienda"
	 FROM "mov_iva", "tab_iva"
	WHERE "mov_iva"."id_reg_pd" = :ll_IDReg_PD  
	and 	"tab_iva"."id_tab_iva"=	"mov_iva"."id_tab_iva"
	and 	"tab_iva"."rcharge"='S';

OPEN lcur_mov_iva;

ll_i = 1
FETCH lcur_mov_iva INTO :ldc_imponibile[ll_i], :ll_id_tab_iva[ll_i], :ldc_imposta[ll_i], :ll_IDAzienda;

ll_SQL_Mov_IVA_New = 0

DO WHILE SQLCA.SQLCode = 0
	ll_i ++
	FETCH lcur_mov_iva INTO :ldc_imponibile[ll_i], :ll_id_tab_iva[ll_i], :ldc_imposta[ll_i], :ll_IDAzienda;
LOOP
CLOSE lcur_mov_iva;

ldc_importo=0
for i= 1 to upperbound(ldc_imponibile)
	ldc_importo+=ldc_imponibile[i]+ldc_imposta[i]
next
ldc_importo_val=ldc_importo*ldc_cambio

ll_SQL_Mov_Contabile_New = 0

SELECT "mov_contabile"."dare",   
		 "mov_contabile"."avere",
		 "mov_contabile"."id_valuta",
		 "mov_contabile"."cambio"
	INTO :ldc_dare_1,
		  :ldc_avere_1,
		  :ll_IDValuta_mc,
		  :ldc_cambio_mc
	FROM "mov_contabile"
	WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD AND
			"mov_contabile"."numero" = 1;

ldc_avere_1=0
for i= 1 to upperbound(ldc_imponibile)
	ldc_avere_1+=ldc_imponibile[i]+ldc_imposta[i]
next
ldc_temp = ldc_dare_1
ldc_dare_1 = ldc_avere_1
ldc_avere_1 = ldc_temp

SELECT "mov_contabile"."dare", "mov_contabile"."avere"
	INTO :ldc_dare_9999, :ldc_avere_9999
	FROM "mov_contabile"
	WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD AND
		"mov_contabile"."numero" = 9999;

ldc_dare_9999=0
for i= 1 to upperbound(ldc_imponibile)
	ldc_dare_9999+=ldc_imposta[i]
next
ldc_temp = ldc_dare_9999
ldc_dare_9999 = ldc_avere_9999
ldc_avere_9999 = ldc_temp

ll_id_conto_mc[1] = ll_IDFornitore
IF IsNull(ldc_dare_1) THEN
	ldc_importo_mc[1] = ldc_avere_1
	lc_segno_mc[1] = "A"
ELSE
	ldc_importo_mc[1] = ldc_dare_1
	lc_segno_mc[1] = "D"
END IF
lb_mc_iva[1] = FALSE
lal_id_valuta_mc[1] = ll_IDValuta_mc
ladc_cambio_mc[1] = ldc_cambio_mc

ll_id_conto_mc[3] = ll_id_conto_iva_profilo
IF IsNull(ldc_dare_9999) THEN
	ldc_importo_mc[3] = ldc_avere_9999
	lc_segno_mc[3] = "A"
ELSE
	ldc_importo_mc[3] = ldc_dare_9999
	lc_segno_mc[3] = "D"
END IF
lb_mc_iva[3] = TRUE
lal_id_valuta_mc[3] = ll_IDValuta_mc
ladc_cambio_mc[3] = ldc_cambio_mc


IF IsNull(ldc_dare_1) THEN
	ldc_dare_cp = ldc_avere_1 - ldc_dare_9999
	ldc_avere_cp = ldc_NULL
ELSEIF IsNull(ldc_avere_1) THEN
	ldc_dare_cp = ldc_NULL
	ldc_avere_cp = ldc_dare_1 - ldc_avere_9999
END IF

ll_id_conto_mc[2] = ll_IDFornitore
IF IsNull(ldc_dare_cp) THEN
	ldc_importo_mc[2] = ldc_avere_cp
	lc_segno_mc[2] = "A"
ELSE
	ldc_importo_mc[2] = ldc_dare_cp
	lc_segno_mc[2] = "D"
END IF
lb_mc_iva[2] = FALSE
lal_id_valuta_mc[2] = ll_IDValuta_mc
ladc_cambio_mc[2] = ldc_cambio_mc


lu_reg_pd.uf_DisplayMode(2)
lu_reg_pd.uf_Reset()
lu_reg_pd.uf_id_registro(ll_IDRegistro)
lu_reg_pd.uf_num_progressivo(ll_num_progressivo)
lu_reg_pd.uf_data_competenza(ld_data_competenza)
lu_reg_pd.uf_id_prof_registrazione(ll_IDProf_Registrazione)
lu_reg_pd.uf_data_registrazione(ld_data_registrazione)
lu_reg_pd.uf_id_valuta(ll_IDValuta)
lu_reg_pd.uf_cambio(ldc_cambio)
lu_reg_pd.uf_importo(ldc_importo)
lu_reg_pd.uf_descrizione(ls_descrizione_profilo)
lu_reg_pd.uf_ges_oper_intracomunitarie(lc_ges_oper_intracomunitarie)
lu_reg_pd.uf_num_documento(ls_num_documento)
lu_reg_pd.uf_data_documento(ld_data_documento)
lu_reg_pd.uf_id_conto(ll_IDFornitore)
lu_reg_pd.uf_id_azienda(ll_IDAzienda)
lu_reg_pd.uf_id_reg_pd_padre(ll_IDReg_PD)
lu_reg_pd.uf_imp_valuta(ldc_importo_val)

lu_reg_pd.uf_imponibile(ldc_imponibile)
lu_reg_pd.uf_id_tab_iva(ll_id_tab_iva)
lu_reg_pd.uf_imposta(ldc_imposta)

lu_reg_pd.uf_importo_mc(ldc_importo_mc)
lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
lu_reg_pd.uf_segno_mc(lc_segno_mc)
lu_reg_pd.uf_mc_iva(lb_mc_iva)
lu_reg_pd.uf_id_valuta_mc(lal_id_valuta_mc)
lu_reg_pd.uf_cambio_mc(ladc_cambio_mc)

IF lu_reg_pd.uf_crea() > 0 THEN
END IF

IF IsValid(lu_reg_pd) THEN
	Destroy lu_reg_pd
END IF
end subroutine

public subroutine uf_attiva_rcharge02 (long al_id_wizard);
long ll_CurrRow_Reg_PD, ll_IDReg_PD, ll_IDProf_Registrazione, ll_IDRegistro, ll_num_progressivo
long ll_IDFornitore, ll_IDValuta, ll_IDAzienda 
long ll_id_esercizio 
string ls_descrizione, ls_descr_registro, ls_num_documento
date ld_data_registrazione, ld_data_competenza, ld_data_documento
decimal ldc_cambio, ldc_importo, ldc_importo_val
char lc_ges_oper_intracomunitarie
integer i
decimal ldc_imponibile[], ldc_imposta[]
long ll_id_tab_iva[], ll_i
string ls_descrizione_profilo

decimal ldc_cambio_mc, ldc_dare_1, ldc_avere_1, ldc_dare_9999, ldc_avere_9999, ldc_dare_cp
decimal ldc_avere_cp, ldc_importo_mc[], ladc_cambio_mc[]
long ll_IDValuta_mc, ll_id_conto_iva_profilo, ll_id_conto_mc[], lal_id_valuta_mc[]
char lc_segno_mc[]
boolean lb_mc_iva[]

long ll_SQL_Reg_PD_New, ll_SQL_Mov_IVA_New, ll_SQL_Mov_Contabile_New, ll_id_reg_pd_new
long ll_IDReg_PD_generata_esistente
string ls_cod_profilo, ls_segno_1, ls_segno_9999
decimal ldc_NULL, ldc_temp 
integer li_RetVal

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

SetNull(ldc_NULL)
ll_CurrRow_Reg_PD = ids_wiz_profilo.GetRow()
ll_IDReg_PD = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_reg_pd")


SELECT "reg_pd"."id_reg_pd"
	INTO :ll_IDReg_PD_generata_esistente
	FROM "reg_pd"
	WHERE "reg_pd"."id_reg_pd_padre" = :ll_IDReg_PD;

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		DELETE FROM "mov_contabile"
		   WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
		DELETE FROM "mov_iva"
		   WHERE "mov_iva"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
		DELETE FROM "reg_pd"
		   WHERE "reg_pd"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / 5")
END CHOOSE

ll_IDReg_PD                  = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_reg_pd")
ll_IDRegistro                = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_registro")
ll_num_progressivo           = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_num_progressivo")
ld_data_competenza           = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_competenza")
ll_IDProf_Registrazione      = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_prof_registrazione")
ld_data_registrazione        = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_registrazione")
ll_IDValuta                  = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_valuta")
ldc_cambio                   = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_cambio")
ldc_importo                  = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_importo")
ls_descrizione               = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_descrizione")
lc_ges_oper_intracomunitarie = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_ges_oper_intracomunitarie")
ls_num_documento             = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_num_documento")
ld_data_documento            = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_documento")
ll_IDFornitore               = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_conto")
ll_IDAzienda                 = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_azienda")
ldc_importo_val              = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_imp_valuta")
ll_id_esercizio              = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "registro_id_esercizio") 

	 SELECT "registro"."id_registro",
		     "registro"."descrizione"
	 INTO :ll_IDRegistro,
			:ls_descr_registro
    FROM "mod_registro",   
         "par_wizard",   
         "registro",   
         "wizard" ,
			"azienda"
   WHERE ( "registro"."id_mod_registro" = "mod_registro"."id_mod_registro" ) and  
         ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
         ( string ("mod_registro"."id_mod_registro" ) = "par_wizard"."valore" ) and
			("registro"."id_esercizio" =:ll_id_esercizio ) and
			("azienda"."id_azienda" = 1) 
			and "wizard"."codice"='RCHARGE2';

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Errore sul DataBase", "w_reg_pd_cx / 2")
END IF



SELECT "registro"."num_progressivo"
INTO :ll_num_progressivo
FROM "registro"
WHERE "registro"."id_registro" = :ll_IDRegistro;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Errore sul DataBase: num_prog non recuperato!", "w_reg_pd_cx / 3")
END IF

IF IsNull(ll_num_progressivo) THEN ll_num_progressivo = 1

  SELECT "prof_registrazione"."id_prof_registrazione",
			"prof_registrazione"."descrizione",
			"prof_registrazione"."id_conto_iva"
	 INTO :ll_IDProf_Registrazione,
			:ls_descrizione_profilo,
			:ll_id_conto_iva_profilo
	 FROM "par_wizard",
			"prof_registrazione"
	WHERE ( "par_wizard"."valore" = "prof_registrazione"."codice" ) and
			( ( "par_wizard"."id_wizard" = :al_id_wizard) )  and
			( "par_wizard"."num_ordine" = 1 ) ;


 DECLARE lcur_mov_iva CURSOR FOR
  SELECT "mov_iva"."imponibile",
			"mov_iva"."id_tab_iva",
			"mov_iva"."imposta",
			"mov_iva"."id_azienda"
	 FROM "mov_iva", "tab_iva"
	WHERE "mov_iva"."id_reg_pd" = :ll_IDReg_PD  
	and 	"tab_iva"."id_tab_iva"=	"mov_iva"."id_tab_iva"
	and 	"tab_iva"."rcharge"='S';

OPEN lcur_mov_iva;

ll_i = 1
FETCH lcur_mov_iva INTO :ldc_imponibile[ll_i], :ll_id_tab_iva[ll_i], :ldc_imposta[ll_i], :ll_IDAzienda;

ll_SQL_Mov_IVA_New = 0

DO WHILE SQLCA.SQLCode = 0
	ll_i ++
	FETCH lcur_mov_iva INTO :ldc_imponibile[ll_i], :ll_id_tab_iva[ll_i], :ldc_imposta[ll_i], :ll_IDAzienda;
LOOP
CLOSE lcur_mov_iva;

ldc_importo=0
for i= 1 to upperbound(ldc_imponibile)
	ldc_importo+=ldc_imponibile[i]+ldc_imposta[i]
next
ldc_importo_val=ldc_importo*ldc_cambio

ll_SQL_Mov_Contabile_New = 0

SELECT "mov_contabile"."dare",   
		 "mov_contabile"."avere",
		 "mov_contabile"."id_valuta",
		 "mov_contabile"."cambio"
	INTO :ldc_dare_1,
		  :ldc_avere_1,
		  :ll_IDValuta_mc,
		  :ldc_cambio_mc
	FROM "mov_contabile"
	WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD AND
			"mov_contabile"."numero" = 1;

ldc_avere_1=0
for i= 1 to upperbound(ldc_imponibile)
	ldc_avere_1+=ldc_imponibile[i]+ldc_imposta[i]
next
ldc_temp = ldc_dare_1
ldc_dare_1 = ldc_avere_1
ldc_avere_1 = ldc_temp

SELECT "mov_contabile"."dare", "mov_contabile"."avere"
	INTO :ldc_dare_9999, :ldc_avere_9999
	FROM "mov_contabile"
	WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD AND
		"mov_contabile"."numero" = 9999;

ldc_dare_9999=0
for i= 1 to upperbound(ldc_imponibile)
	ldc_dare_9999+=ldc_imposta[i]
next
ldc_temp = ldc_dare_9999
ldc_dare_9999 = ldc_avere_9999
ldc_avere_9999 = ldc_temp

ll_id_conto_mc[1] = ll_IDFornitore
IF IsNull(ldc_dare_1) THEN
	ldc_importo_mc[1] = ldc_avere_1
	lc_segno_mc[1] = "A"
ELSE
	ldc_importo_mc[1] = ldc_dare_1
	lc_segno_mc[1] = "D"
END IF
lb_mc_iva[1] = FALSE
lal_id_valuta_mc[1] = ll_IDValuta_mc
ladc_cambio_mc[1] = ldc_cambio_mc

ll_id_conto_mc[3] = ll_id_conto_iva_profilo
IF IsNull(ldc_dare_9999) THEN
	ldc_importo_mc[3] = ldc_avere_9999
	lc_segno_mc[3] = "A"
ELSE
	ldc_importo_mc[3] = ldc_dare_9999
	lc_segno_mc[3] = "D"
END IF
lb_mc_iva[3] = TRUE
lal_id_valuta_mc[3] = ll_IDValuta_mc
ladc_cambio_mc[3] = ldc_cambio_mc


IF IsNull(ldc_dare_1) THEN
	ldc_dare_cp = ldc_avere_1 - ldc_dare_9999
	ldc_avere_cp = ldc_NULL
ELSEIF IsNull(ldc_avere_1) THEN
	ldc_dare_cp = ldc_NULL
	ldc_avere_cp = ldc_dare_1 - ldc_avere_9999
END IF

ll_id_conto_mc[2] = ll_IDFornitore
IF IsNull(ldc_dare_cp) THEN
	ldc_importo_mc[2] = ldc_avere_cp
	lc_segno_mc[2] = "A"
ELSE
	ldc_importo_mc[2] = ldc_dare_cp
	lc_segno_mc[2] = "D"
END IF
lb_mc_iva[2] = FALSE
lal_id_valuta_mc[2] = ll_IDValuta_mc
ladc_cambio_mc[2] = ldc_cambio_mc


lu_reg_pd.uf_DisplayMode(2)
lu_reg_pd.uf_Reset()
lu_reg_pd.uf_id_registro(ll_IDRegistro)
lu_reg_pd.uf_num_progressivo(ll_num_progressivo)
lu_reg_pd.uf_data_competenza(ld_data_competenza)
lu_reg_pd.uf_id_prof_registrazione(ll_IDProf_Registrazione)
lu_reg_pd.uf_data_registrazione(ld_data_registrazione)
lu_reg_pd.uf_id_valuta(ll_IDValuta)
lu_reg_pd.uf_cambio(ldc_cambio)
lu_reg_pd.uf_importo(ldc_importo)
lu_reg_pd.uf_descrizione(ls_descrizione_profilo)
lu_reg_pd.uf_ges_oper_intracomunitarie(lc_ges_oper_intracomunitarie)
lu_reg_pd.uf_num_documento(ls_num_documento)
lu_reg_pd.uf_data_documento(ld_data_documento)
lu_reg_pd.uf_id_conto(ll_IDFornitore)
lu_reg_pd.uf_id_azienda(ll_IDAzienda)
lu_reg_pd.uf_id_reg_pd_padre(ll_IDReg_PD)
lu_reg_pd.uf_imp_valuta(ldc_importo_val)

lu_reg_pd.uf_imponibile(ldc_imponibile)
lu_reg_pd.uf_id_tab_iva(ll_id_tab_iva)
lu_reg_pd.uf_imposta(ldc_imposta)

lu_reg_pd.uf_importo_mc(ldc_importo_mc)
lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
lu_reg_pd.uf_segno_mc(lc_segno_mc)
lu_reg_pd.uf_mc_iva(lb_mc_iva)
lu_reg_pd.uf_id_valuta_mc(lal_id_valuta_mc)
lu_reg_pd.uf_cambio_mc(ladc_cambio_mc)

IF lu_reg_pd.uf_crea() > 0 THEN
END IF

IF IsValid(lu_reg_pd) THEN
	Destroy lu_reg_pd
END IF
end subroutine

public subroutine uf_attiva_rcharge (long al_id_wizard);
long ll_CurrRow_Reg_PD, ll_IDReg_PD, ll_IDProf_Registrazione, ll_IDRegistro, ll_num_progressivo
long ll_IDFornitore, ll_IDValuta, ll_IDAzienda 
long ll_id_esercizio 
string ls_descrizione, ls_descr_registro, ls_num_documento
date ld_data_registrazione, ld_data_competenza, ld_data_documento
decimal ldc_cambio, ldc_importo, ldc_importo_val
char lc_ges_oper_intracomunitarie
integer i
decimal ldc_imponibile[], ldc_imposta[]
long ll_id_tab_iva[], ll_i
string ls_descrizione_profilo

decimal ldc_cambio_mc, ldc_dare_1, ldc_avere_1, ldc_dare_9999, ldc_avere_9999, ldc_dare_cp
decimal ldc_avere_cp, ldc_importo_mc[], ladc_cambio_mc[]
long ll_IDValuta_mc, ll_id_conto_iva_profilo, ll_id_conto_mc[], lal_id_valuta_mc[]
char lc_segno_mc[]
boolean lb_mc_iva[]

long ll_SQL_Reg_PD_New, ll_SQL_Mov_IVA_New, ll_SQL_Mov_Contabile_New, ll_id_reg_pd_new
long ll_IDReg_PD_generata_esistente
string ls_cod_profilo, ls_segno_1, ls_segno_9999
decimal ldc_NULL, ldc_temp 
integer li_RetVal

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

SetNull(ldc_NULL)
ll_CurrRow_Reg_PD = ids_wiz_profilo.GetRow()
ll_IDReg_PD = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_reg_pd")


SELECT "reg_pd"."id_reg_pd"
	INTO :ll_IDReg_PD_generata_esistente
	FROM "reg_pd"
	WHERE "reg_pd"."id_reg_pd_padre" = :ll_IDReg_PD;

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		DELETE FROM "mov_contabile"
		   WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
		DELETE FROM "mov_iva"
		   WHERE "mov_iva"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
		DELETE FROM "reg_pd"
		   WHERE "reg_pd"."id_reg_pd" = :ll_IDReg_PD_generata_esistente   ;
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / 5")
END CHOOSE

ll_IDReg_PD                  = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_reg_pd")
ll_IDRegistro                = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_registro")
ll_num_progressivo           = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_num_progressivo")
ld_data_competenza           = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_competenza")
ll_IDProf_Registrazione      = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_prof_registrazione")
ld_data_registrazione        = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_registrazione")
ll_IDValuta                  = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_valuta")
ldc_cambio                   = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_cambio")
ldc_importo                  = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_importo")
ls_descrizione               = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_descrizione")
lc_ges_oper_intracomunitarie = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_ges_oper_intracomunitarie")
ls_num_documento             = ids_wiz_profilo.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_num_documento")
ld_data_documento            = ids_wiz_profilo.GetItemDate(ll_CurrRow_Reg_PD, "reg_pd_data_documento")
ll_IDFornitore               = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_conto")
ll_IDAzienda                 = ids_wiz_profilo.GetItemNumber(ll_CurrRow_Reg_PD, "reg_pd_id_azienda")
ldc_importo_val              = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "reg_pd_imp_valuta")
ll_id_esercizio              = ids_wiz_profilo.GetItemDecimal(ll_CurrRow_Reg_PD, "registro_id_esercizio") 

	 SELECT "registro"."id_registro",
		     "registro"."descrizione"
	 INTO :ll_IDRegistro,
			:ls_descr_registro
    FROM "mod_registro",   
         "par_wizard",   
         "registro",   
         "wizard" ,
			"azienda"
   WHERE ( "registro"."id_mod_registro" = "mod_registro"."id_mod_registro" ) and  
         ( "wizard"."id_wizard" = "par_wizard"."id_wizard" ) and  
         ( string ("mod_registro"."id_mod_registro" ) = "par_wizard"."valore" ) and
			("registro"."id_esercizio" =:ll_id_esercizio ) and
			("azienda"."id_azienda" = 1) 
			and "wizard"."codice"='RCHARGE';

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Errore sul DataBase", "w_reg_pd_cx / 2")
END IF



SELECT "registro"."num_progressivo"
INTO :ll_num_progressivo
FROM "registro"
WHERE "registro"."id_registro" = :ll_IDRegistro;

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Errore sul DataBase: num_prog non recuperato!", "w_reg_pd_cx / 3")
END IF

IF IsNull(ll_num_progressivo) THEN ll_num_progressivo = 1

  SELECT "prof_registrazione"."id_prof_registrazione",
			"prof_registrazione"."descrizione",
			"prof_registrazione"."id_conto_iva"
	 INTO :ll_IDProf_Registrazione,
			:ls_descrizione_profilo,
			:ll_id_conto_iva_profilo
	 FROM "par_wizard",
			"prof_registrazione"
	WHERE ( "par_wizard"."valore" = "prof_registrazione"."codice" ) and
			( ( "par_wizard"."id_wizard" = :al_id_wizard) )  and
			( "par_wizard"."num_ordine" = 1 ) ;


 DECLARE lcur_mov_iva CURSOR FOR
  SELECT "mov_iva"."imponibile",
			"mov_iva"."id_tab_iva",
			"mov_iva"."imposta",
			"mov_iva"."id_azienda"
	 FROM "mov_iva", "tab_iva"
	WHERE "mov_iva"."id_reg_pd" = :ll_IDReg_PD  
	and 	"tab_iva"."id_tab_iva"=	"mov_iva"."id_tab_iva"
	and 	"tab_iva"."rcharge"='S';

OPEN lcur_mov_iva;

ll_i = 1
FETCH lcur_mov_iva INTO :ldc_imponibile[ll_i], :ll_id_tab_iva[ll_i], :ldc_imposta[ll_i], :ll_IDAzienda;

ll_SQL_Mov_IVA_New = 0

DO WHILE SQLCA.SQLCode = 0
	ll_i ++
	FETCH lcur_mov_iva INTO :ldc_imponibile[ll_i], :ll_id_tab_iva[ll_i], :ldc_imposta[ll_i], :ll_IDAzienda;
LOOP
CLOSE lcur_mov_iva;

ldc_importo=0
for i= 1 to upperbound(ldc_imponibile)
	ldc_importo+=ldc_imponibile[i]+ldc_imposta[i]
next
ldc_importo_val=ldc_importo*ldc_cambio

ll_SQL_Mov_Contabile_New = 0

SELECT "mov_contabile"."dare",   
		 "mov_contabile"."avere",
		 "mov_contabile"."id_valuta",
		 "mov_contabile"."cambio"
	INTO :ldc_dare_1,
		  :ldc_avere_1,
		  :ll_IDValuta_mc,
		  :ldc_cambio_mc
	FROM "mov_contabile"
	WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD AND
			"mov_contabile"."numero" = 1;

ldc_avere_1=0
for i= 1 to upperbound(ldc_imponibile)
	ldc_avere_1+=ldc_imponibile[i]+ldc_imposta[i]
next
ldc_temp = ldc_dare_1
ldc_dare_1 = ldc_avere_1
ldc_avere_1 = ldc_temp

SELECT "mov_contabile"."dare", "mov_contabile"."avere"
	INTO :ldc_dare_9999, :ldc_avere_9999
	FROM "mov_contabile"
	WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD AND
		"mov_contabile"."numero" = 9999;

ldc_dare_9999=0
for i= 1 to upperbound(ldc_imponibile)
	ldc_dare_9999+=ldc_imposta[i]
next
ldc_temp = ldc_dare_9999
ldc_dare_9999 = ldc_avere_9999
ldc_avere_9999 = ldc_temp

ll_id_conto_mc[1] = ll_IDFornitore
IF IsNull(ldc_dare_1) THEN
	ldc_importo_mc[1] = ldc_avere_1
	lc_segno_mc[1] = "A"
ELSE
	ldc_importo_mc[1] = ldc_dare_1
	lc_segno_mc[1] = "D"
END IF
lb_mc_iva[1] = FALSE
lal_id_valuta_mc[1] = ll_IDValuta_mc
ladc_cambio_mc[1] = ldc_cambio_mc

ll_id_conto_mc[3] = ll_id_conto_iva_profilo
IF IsNull(ldc_dare_9999) THEN
	ldc_importo_mc[3] = ldc_avere_9999
	lc_segno_mc[3] = "A"
ELSE
	ldc_importo_mc[3] = ldc_dare_9999
	lc_segno_mc[3] = "D"
END IF
lb_mc_iva[3] = TRUE
lal_id_valuta_mc[3] = ll_IDValuta_mc
ladc_cambio_mc[3] = ldc_cambio_mc


IF IsNull(ldc_dare_1) THEN
	ldc_dare_cp = ldc_avere_1 - ldc_dare_9999
	ldc_avere_cp = ldc_NULL
ELSEIF IsNull(ldc_avere_1) THEN
	ldc_dare_cp = ldc_NULL
	ldc_avere_cp = ldc_dare_1 - ldc_avere_9999
END IF

ll_id_conto_mc[2] = ll_IDFornitore
IF IsNull(ldc_dare_cp) THEN
	ldc_importo_mc[2] = ldc_avere_cp
	lc_segno_mc[2] = "A"
ELSE
	ldc_importo_mc[2] = ldc_dare_cp
	lc_segno_mc[2] = "D"
END IF
lb_mc_iva[2] = FALSE
lal_id_valuta_mc[2] = ll_IDValuta_mc
ladc_cambio_mc[2] = ldc_cambio_mc


lu_reg_pd.uf_DisplayMode(2)
lu_reg_pd.uf_Reset()
lu_reg_pd.uf_id_registro(ll_IDRegistro)
lu_reg_pd.uf_num_progressivo(ll_num_progressivo)
lu_reg_pd.uf_data_competenza(ld_data_competenza)
lu_reg_pd.uf_id_prof_registrazione(ll_IDProf_Registrazione)
lu_reg_pd.uf_data_registrazione(ld_data_registrazione)
lu_reg_pd.uf_id_valuta(ll_IDValuta)
lu_reg_pd.uf_cambio(ldc_cambio)
lu_reg_pd.uf_importo(ldc_importo)
lu_reg_pd.uf_descrizione(ls_descrizione_profilo)
lu_reg_pd.uf_ges_oper_intracomunitarie(lc_ges_oper_intracomunitarie)
lu_reg_pd.uf_num_documento(ls_num_documento)
lu_reg_pd.uf_data_documento(ld_data_documento)
lu_reg_pd.uf_id_conto(ll_IDFornitore)
lu_reg_pd.uf_id_azienda(ll_IDAzienda)
lu_reg_pd.uf_id_reg_pd_padre(ll_IDReg_PD)
lu_reg_pd.uf_imp_valuta(ldc_importo_val)

lu_reg_pd.uf_imponibile(ldc_imponibile)
lu_reg_pd.uf_id_tab_iva(ll_id_tab_iva)
lu_reg_pd.uf_imposta(ldc_imposta)

lu_reg_pd.uf_importo_mc(ldc_importo_mc)
lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
lu_reg_pd.uf_segno_mc(lc_segno_mc)
lu_reg_pd.uf_mc_iva(lb_mc_iva)
lu_reg_pd.uf_id_valuta_mc(lal_id_valuta_mc)
lu_reg_pd.uf_cambio_mc(ladc_cambio_mc)

IF lu_reg_pd.uf_crea() > 0 THEN
END IF

IF IsValid(lu_reg_pd) THEN
	Destroy lu_reg_pd
END IF
end subroutine

on uo_wizard.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_wizard.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;

uf_create_ds()
end event

event destructor;

uf_destroy_ds()
end event

