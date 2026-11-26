forward
global type w_corrispettivi_wz from w_wiz_main
end type
type dw_corrisp_ext_gd from u_dw_ext_main within w_corrispettivi_wz
end type
type dw_corrisp_ext_ff from u_dw_ext_main within w_corrispettivi_wz
end type
type cb_annulla from commandbutton within w_corrispettivi_wz
end type
type cb_ok from commandbutton within w_corrispettivi_wz
end type
end forward

global type w_corrispettivi_wz from w_wiz_main
int X=553
int Y=452
int Width=2601
int Height=1524
WindowType WindowType=response!
boolean TitleBar=true
string Title="Corrispettivi"
dw_corrisp_ext_gd dw_corrisp_ext_gd
dw_corrisp_ext_ff dw_corrisp_ext_ff
cb_annulla cb_annulla
cb_ok cb_ok
end type
global w_corrispettivi_wz w_corrispettivi_wz

type variables
long il_dw_pass[]
decimal idc_importi[6, 33]
decimal ldc_cambio
long  ll_IDValuta
end variables

forward prototypes
public function integer uf_prendi_aliquota (integer ar_id_iva)
public function integer uf_popola_mese (integer ar_mese, integer ar_anno, datawindow ar_dwc, string ar_column)
public subroutine uf_crea_mov_iva (long al_id_reg_pd, decimal adc_imponibile, long al_id_tab_iva, decimal adc_imposta)
public subroutine uf_crea_reg_pd (integer al_day)
public function decimal uf_iva_riga (long al_riga)
public function decimal uf_scorpora (decimal adc_importo, decimal adc_iva)
public subroutine uf_feed_array (integer ai_i, decimal adc_importo, long al_idtab_iva, decimal adc_aliquota, long al_id_reg_pd)
public subroutine uf_blank_array ()
public function decimal uf_iva_colonna (long al_riga, string as_colonna)
public function integer uf_controlla ()
public function integer wf_controlla_conto (long al_id_prof_reg)
public subroutine uf_setta_format (long il_valuta)
public subroutine uf_valuta (long rd_prof, long ll_lire)
end prototypes

public function integer uf_prendi_aliquota (integer ar_id_iva);

integer    	 li_id_tab_iva
integer      li_aliquota
string ls_msg
string ls_err
string ls_sep
string ls_nl


li_id_tab_iva = ar_id_iva
IF (ar_id_iva = 0) OR (IsNull(ar_id_iva)) THEN
	RETURN 0
END IF	
SELECT per_aliquota
	    INTO :li_aliquota
		 FROM tab_iva AS A
		 WHERE A.id_tab_iva = :li_id_tab_iva
		 USING SQLCA;
ls_sep = " "
ls_nl  = "~n"
ls_msg = "Cometa Corrispettivi - Errore in Ricerca Aliquota IVA" 
ls_err = "SQL SELECT Fallito" + ls_nl
ls_err = ls_err + ls_sep + "DBMS(Sybase) Code:"
ls_err = ls_err + String(SQLCA.SQLCode) + ls_nl
ls_err = ls_err + SQLCA.SQLERRText + ls_nl
IF (SQLCA.SQLCode < 0) OR (SQLCA.SQLCode = 100) THEN
	MessageBox(ls_msg, ls_err, StopSign!)
	RETURN 0
END IF			 
	
RETURN li_aliquota  		  
end function

public function integer uf_popola_mese (integer ar_mese, integer ar_anno, datawindow ar_dwc, string ar_column);

string		ls_date_1, ls_date_2, ls_date_3
string		ls_minus, ls_space, ls_column, ls_name_it, ls_name_UK
integer		ar_mese_2, ar_anno_2
date			ld_date_1, ld_date_2, ld_date_3
long			ll_days, ll_index, ll_row, ll_row_delta

IF (ar_mese = 0) OR IsNull(ar_anno) OR IsNull(ar_dwc) OR IsNull(ar_column) THEN
	RETURN 	0
END IF	
ls_minus	 = "-"
ls_space	 = " "
IF ar_mese = 12 THEN
	ar_mese_2 = 1
	ar_anno_2 = ar_anno + 1
ELSE
	ar_mese_2 = ar_mese + 1
	ar_anno_2 = ar_anno 
END IF	
ls_date_1 = String(1) + ls_minus + String(ar_mese) + ls_minus + String(ar_anno)
ls_date_2 = String(1) + ls_minus + String(ar_mese_2) + ls_minus + String(ar_anno_2)
ld_date_1 = Date(ls_date_1)
ld_date_2 = Date(ls_date_2)
ll_days	 = DaysAfter(ld_date_1, ld_date_2)
ll_row_delta = (ar_dwc.RowCount() - ll_days)
IF ll_row_delta < 0 THEN
	ll_row_delta = ll_row_delta * (-1)
	FOR ll_index = 1 TO ll_row_delta
			ll_row = ar_dwc.InsertRow(0)
	NEXT
ELSE
	FOR ll_index = 1 TO ll_row_delta
			ll_row = ar_dwc.DeleteRow(1)
	NEXT
END IF	
FOR ll_index = 1 TO ll_days
		ls_date_3 = String(ll_index) + ls_minus + String(ar_mese) + ls_minus + String(ar_anno)
		ld_date_3 = Date(ls_date_3)
		ls_name_UK = DayName(ld_date_3)
		CHOOSE CASE Left(ls_name_UK, 2)
				CASE	"Mo"
					ls_name_it = "Lunedì"
				CASE	"Tu"
					ls_name_it = "Martedì"
				CASE	"We"
					ls_name_it = "Mercoledì"
				CASE	"Th"
					ls_name_it = "Giovedì"
				CASE	"Fr"
					ls_name_it = "Venerdì"
				CASE	"Sa"
					ls_name_it = "Sabato"
				CASE	"Su"
					ls_name_it = "Domenica"	
		END CHOOSE		
		ls_column = String(ll_index) + ls_space + ls_name_it
		ar_dwc.SetItem(ll_index, ar_column, ls_column)
NEXT		


RETURN 	1

end function

public subroutine uf_crea_mov_iva (long al_id_reg_pd, decimal adc_imponibile, long al_id_tab_iva, decimal adc_imposta);

INSERT INTO "mov_iva"  
		( "id_reg_pd",   
		  "imponibile",   
		  "id_tab_iva",   
		  "imposta",   
		  "id_azienda" )  
VALUES ( :al_id_reg_pd,   
		  :adc_imponibile,   
		  :al_id_tab_iva,   
		  :adc_imposta,   
		  1)  ;

end subroutine

public subroutine uf_crea_reg_pd (integer al_day);

long ll_CurrRow, ll_IDProf_Registrazione, ll_IDRegistro, ll_Num_Reg
long ll_IDReg_PD, ll_SQL_INSERT_Reg_PD, ll_id_conto, ll_val_lire
string ls_des_registro

long ll_CurrRow_gd, ll_IDTab_IVA, ll_SQL_INSERT_Mov_IVA
decimal ldc_imponibile, ldc_imposta, ldc_iva1, ldc_iva2, ldc_iva3, ldc_iva4, ldc_iva5
ll_SQL_INSERT_Mov_IVA = 0

long ll_SQL_INSERT_Mov_Contabile, ll_IDConto
decimal ldc_dare, ldc_avere, ldc_NULL, ldc_IVA_riga 
char lc_segno
SetNull(ldc_NULL)
ll_SQL_INSERT_Mov_Contabile = 0

integer li_mese, li_anno, li_i
date ld_data_registrazione, ld_data
decimal ldc_importo
string ls_data, ls_descrizione
char lc_scorporo

select id_val_lire into :ll_val_lire from par_sistema;


ll_CurrRow = dw_corrisp_ext_ff.GetRow()
ll_CurrRow_gd = al_day

dw_corrisp_ext_gd.AcceptText()

ll_IDProf_Registrazione = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione_cod")


ll_IDRegistro = f_proponi_registro(ll_IDProf_Registrazione, u_freddie.gl_NULL)

  SELECT "registro"."descrizione",
         "registro"."ges_sco_giornaliero"
    INTO :ls_des_registro,
         :lc_scorporo
    FROM "registro"
   WHERE ( "registro"."id_registro" = :ll_IDRegistro ) ;


IF SQLCA.SQLCode = -1 THEN
   MessageBox("Errore sul DataBase", "w_corrispettivi_wz / uf_crea_reg_pd / 1")
   RETURN
END IF

SELECT MAX("reg_pd"."num_progressivo")
   INTO :ll_Num_Reg
   FROM "reg_pd"
   WHERE "reg_pd"."id_registro" = :ll_IDRegistro;

IF SQLCA.SQLCode = -1 THEN
   MessageBox("Errore sul DataBase", "w_corrispettivi_wz / uf_crea_reg_pd / 2")
   RETURN
END IF

IF IsNull(ll_Num_Reg) THEN ll_Num_Reg = 0
ll_Num_Reg = ll_Num_Reg + 1

li_mese = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow, "mese")
li_anno = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow, "anno")
ld_data_registrazione = Date(f_lpad(string(al_day), "0", 2) + "/" + string(li_mese) + "/" + string(lI_anno))

uf_valuta(ll_IDRegistro, ll_val_lire) 
uf_setta_format(ll_idvaluta)

  SELECT "prof_registrazione"."descrizione"
    INTO :ls_descrizione
    FROM "prof_registrazione"
   WHERE "prof_registrazione"."id_prof_registrazione" = :ll_IDProf_Registrazione   ;

IF SQLCA.SQLCode = -1 THEN
   MessageBox("Errore sul DataBase", "w_corrispettivi_wz / uf_crea_reg_pd / 5")
   RETURN
END IF

ldc_importo = dw_corrisp_ext_gd.GetItemDecimal(ll_CurrRow_gd, "totale_riga")


  SELECT "prof_mov_contabile"."id_conto"  
    INTO :ll_id_conto
    FROM "prof_mov_contabile"  
   WHERE ( "prof_mov_contabile"."id_prof_registrazione" = :ll_IDProf_Registrazione ) AND  
         ( "prof_mov_contabile"."num_riga" = 1 )   ;

CHOOSE CASE SQLCA.SQLCode
	CASE 100
		ll_id_conto = 0
	CASE -1
		MessageBox("Errore sul DataBase", "w_corrispettivi_wz / uf_crea_reg_pd / 10")
END CHOOSE
						
  INSERT INTO "reg_pd"
         ( "id_registro",
           "num_progressivo",
           "data_competenza",
           "id_prof_registrazione",
           "data_registrazione",
           "id_valuta",
           "cambio",
           "importo",
           "descrizione",
           "imp_valuta",
			  "num_documento",
			  "data_documento",
			  "id_conto",
			  "data_comp_liq_iva")
  VALUES ( :ll_IDRegistro,
           :ll_Num_Reg,
           :ld_data_registrazione,
           :ll_IDProf_Registrazione,
           :ld_data_registrazione,
           :ll_IDValuta,
           :ldc_cambio,
           :ldc_importo,
           :ls_descrizione,
           :ldc_importo,
			  :ll_Num_Reg,
			  :ld_data_registrazione,
			  :ll_id_conto,
			  :ld_data_registrazione)  ;

ll_SQL_INSERT_Reg_PD = SQLCA.SQLCode

SELECT "reg_pd"."id_reg_pd"

   INTO :ll_IDReg_PD
   FROM "reg_pd"
   WHERE "reg_pd"."id_registro" = :ll_IDRegistro AND
         "num_progressivo" = :ll_Num_Reg AND
         "data_registrazione" = :ld_data_registrazione;

IF SQLCA.SQLCode = -1 THEN
   MessageBox("Errore sul DataBase", "w_corrispettivi_wz / uf_crea_reg_pd / 6")
   RETURN
END IF



ll_IDTab_IVA = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow, "iva_1_cod")
ldc_imponibile = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "importo_1")
IF ((NOT IsNull(ll_IDTab_IVA)) AND (ldc_imponibile > 0)) THEN
	ldc_iva1	= dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "iva_1")
	ldc_imposta = (ldc_imponibile * ldc_iva1 / (ldc_iva1 + 100))
   IF lc_scorporo = "N" THEN
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, 0)
   ELSEIF lc_scorporo = "S" THEN
      ldc_imponibile = ldc_imponibile - ldc_imposta		
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, ldc_imposta)
   END IF
   IF SQLCA.SQLCode <> 0 THEN ll_SQL_INSERT_Mov_IVA = SQLCA.SQLCode
END IF

ll_IDTab_IVA = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow, "iva_2_cod")
ldc_imponibile = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "importo_2")	
IF ((NOT IsNull(ll_IDTab_IVA)) AND (ldc_imponibile > 0)) THEN
	ldc_iva2	= dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "iva_2")
	ldc_imposta = (ldc_imponibile * ldc_iva2 / (ldc_iva2 + 100))
   IF lc_scorporo = "N" THEN
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, 0)
   ELSEIF lc_scorporo = "S" THEN
      ldc_imponibile = ldc_imponibile - ldc_imposta		
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, ldc_imposta)
   END IF
   IF SQLCA.SQLCode <> 0 THEN ll_SQL_INSERT_Mov_IVA = SQLCA.SQLCode
END IF

ll_IDTab_IVA = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow, "iva_3_cod")
ldc_imponibile = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "importo_3")
IF ((NOT IsNull(ll_IDTab_IVA)) AND (ldc_imponibile > 0)) THEN
	ldc_iva3	= dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "iva_3")
	ldc_imposta = (ldc_imponibile * ldc_iva3 / (ldc_iva3 + 100))
   IF lc_scorporo = "N" THEN
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, 0)
   ELSEIF lc_scorporo = "S" THEN
      ldc_imponibile = ldc_imponibile - ldc_imposta		
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, ldc_imposta)
   END IF
   IF SQLCA.SQLCode <> 0 THEN ll_SQL_INSERT_Mov_IVA = SQLCA.SQLCode
END IF

ll_IDTab_IVA = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow, "iva_4_cod")
ldc_imponibile = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "importo_4")
IF ((NOT IsNull(ll_IDTab_IVA)) AND (ldc_imponibile > 0)) THEN
	ldc_iva4	= dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "iva_4")
	ldc_imposta = (ldc_imponibile * ldc_iva4 / (ldc_iva4 + 100))
   IF lc_scorporo = "N" THEN
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, 0)
   ELSEIF lc_scorporo = "S" THEN
      ldc_imponibile = ldc_imponibile - ldc_imposta		
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, ldc_imposta)
   END IF
   IF SQLCA.SQLCode <> 0 THEN ll_SQL_INSERT_Mov_IVA = SQLCA.SQLCode
END IF

ll_IDTab_IVA = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow, "iva_5_cod")
ldc_imponibile = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "importo_5")		
IF ((NOT IsNull(ll_IDTab_IVA)) AND (ldc_imponibile > 0)) THEN
	ldc_iva5	= dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "iva_5")
	ldc_imposta = (ldc_imponibile * ldc_iva5 / (ldc_iva5 + 100))
   IF lc_scorporo = "N" THEN
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, 0)
   ELSEIF lc_scorporo = "S" THEN
      ldc_imponibile = ldc_imponibile - ldc_imposta		
      uf_Crea_Mov_IVA(ll_IDReg_PD, ldc_imponibile, ll_IDTab_IVA, ldc_imposta)
   END IF
   IF SQLCA.SQLCode <> 0 THEN ll_SQL_INSERT_Mov_IVA = SQLCA.SQLCode
END IF




  SELECT "prof_mov_contabile"."id_conto",
         "prof_mov_contabile"."segno"
    INTO :ll_IDConto,
         :lc_segno
    FROM "prof_mov_contabile",
         "prof_registrazione"
   WHERE ( "prof_registrazione"."id_prof_registrazione" = "prof_mov_contabile"."id_prof_registrazione" ) and
         ( ( "prof_mov_contabile"."id_prof_registrazione" = :ll_IDProf_Registrazione ) AND
         ( "prof_mov_contabile"."num_riga" = 1 ) )   ;

IF SQLCA.SQLCode = -1 THEN
   MessageBox("Errore sul DataBase", "w_corrispettivi_wz / uf_crea_reg_pd / 7")
   RETURN
END IF
IF ISNULL(LL_ID_CONTO) then
	messagebox("Errore!", "Dati incompleti: conto non trovato in profilo movimento contabile")
end if

IF lc_segno = "D" THEN
   ldc_dare = ldc_importo
   ldc_avere = ldc_NULL
ELSEIF lc_segno = "A" THEN
   ldc_dare = ldc_NULL
   ldc_avere = ldc_importo
END IF

  INSERT INTO "mov_contabile"
         ( "id_reg_pd",
           "numero",
           "id_conto",
           "id_valuta",
           "cambio",
           "des_contabile",
           "dare",
           "avere",
           "data_val_banca",
           "data_inizio_competenza",
           "data_fine_competenza",
           "id_azienda" )
  VALUES ( :ll_IDReg_PD,
           1,
           :ll_IDConto,
           :ll_IDValuta,
           :ldc_cambio,
           :ls_descrizione,
           :ldc_dare,
           :ldc_avere,
           :ld_data_registrazione,
           :ld_data_registrazione,
           :ld_data_registrazione,
           1)  ;

IF SQLCA.SQLCode <> 0 THEN ll_SQL_INSERT_Mov_Contabile = SQLCA.SQLCode



  SELECT "prof_mov_contabile"."id_conto",
         "prof_mov_contabile"."segno"
    INTO :ll_IDConto,
         :lc_segno
    FROM "prof_mov_contabile",
         "prof_registrazione"
   WHERE ( "prof_registrazione"."id_prof_registrazione" = "prof_mov_contabile"."id_prof_registrazione" ) and
         ( ( "prof_mov_contabile"."id_prof_registrazione" = :ll_IDProf_Registrazione ) AND
         ( "prof_mov_contabile"."num_riga" = 2 ) )   ;

IF SQLCA.SQLCode = -1 THEN
   MessageBox("Errore sul DataBase", "w_corrispettivi_wz / uf_crea_reg_pd / 8")
   RETURN
END IF

IF lc_scorporo = "S" THEN
	ldc_IVA_riga = uf_IVA_riga(al_day)
   ldc_importo = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "totale_riga")
   ldc_importo = ldc_importo - ldc_IVA_riga
ELSEIF lc_scorporo = "N" THEN
	ldc_importo = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "totale_riga")
END IF

IF lc_segno = "D" THEN
   ldc_dare = ldc_importo
   ldc_avere = ldc_NULL
ELSEIF lc_segno = "A" THEN
   ldc_dare = ldc_NULL
   ldc_avere = ldc_importo
END IF

if ll_val_lire=ll_idvaluta then
	ldc_dare = Round(ldc_dare, 0)
	ldc_avere = Round(ldc_avere, 0)
else	
   ldc_dare = Round(ldc_dare, 2)
	ldc_avere = Round(ldc_avere, 2)
end if

  INSERT INTO "mov_contabile"
         ( "id_reg_pd",
           "numero",
           "id_conto",
           "id_valuta",
           "cambio",
           "des_contabile",
           "dare",
           "avere",
           "data_val_banca",
           "data_inizio_competenza",
           "data_fine_competenza",
           "id_azienda" )
  VALUES ( :ll_IDReg_PD,
           2,
           :ll_IDConto,
           :ll_IDValuta,
           :ldc_cambio,
           :ls_descrizione,
           :ldc_dare,

           :ldc_avere,
           :ld_data_registrazione,
           :ld_data_registrazione,
           :ld_data_registrazione,
           1)  ;

IF SQLCA.SQLCode <> 0 THEN ll_SQL_INSERT_Mov_Contabile = SQLCA.SQLCode


IF lc_scorporo = "S" THEN
   
	SELECT "prof_registrazione"."id_conto_iva"
		INTO :ll_IDConto
		FROM "prof_registrazione"
		WHERE "prof_registrazione"."id_prof_registrazione" = :ll_IDProf_Registrazione   ;


   IF SQLCA.SQLCode = -1 THEN
      MessageBox("Errore sul DataBase", "w_corrispettivi_wz / uf_crea_reg_pd / 9")
      RETURN
   END IF

   
	ldc_importo = uf_IVA_riga(al_day)

   IF lc_segno = "D" THEN
      ldc_dare = ldc_importo
      ldc_avere = ldc_NULL
   ELSEIF lc_segno = "A" THEN
      ldc_dare = ldc_NULL
      ldc_avere = ldc_importo
   END IF
   
	
	if ll_val_lire=ll_idvaluta then
		ldc_dare = Round(ldc_dare, 0)
		ldc_avere = Round(ldc_avere, 0)
	else	
	   ldc_dare = Round(ldc_dare, 2)
		ldc_avere = Round(ldc_avere, 2)
	end if
	

     INSERT INTO "mov_contabile"
            ( "id_reg_pd",
              "numero",
              "id_conto",
              "id_valuta",
              "cambio",
              "des_contabile",
              "dare",
              "avere",
              "data_val_banca",
              "data_inizio_competenza",
              "data_fine_competenza",
              "id_azienda" )
     VALUES ( :ll_IDReg_PD,
              9999,
              :ll_IDConto,
              :ll_IDValuta,
              :ldc_cambio,
              :ls_descrizione,
              :ldc_dare,
              :ldc_avere,
              :ld_data_registrazione,
              :ld_data_registrazione,
              :ld_data_registrazione,
              1)  ;
   IF SQLCA.SQLCode <> 0 THEN ll_SQL_INSERT_Mov_Contabile = SQLCA.SQLCode
END IF

IF ll_SQL_INSERT_Reg_PD = 0 AND &
   ll_SQL_INSERT_Mov_IVA = 0 AND &
   ll_SQL_INSERT_Mov_Contabile = 0 THEN
   COMMIT USING SQLCA;
   
ELSE
   ROLLBACK USING SQLCA;
   MessageBox("Corrispettivi", "Impossibile creare la registrazione del giorno " + string(al_day) + ".")
END IF
end subroutine

public function decimal uf_iva_riga (long al_riga);

decimal ldc_imp1, ldc_imp2, ldc_imp3, ldc_imp4, ldc_imp5, ldc_RetVal

ldc_imp1 = dw_corrisp_ext_gd.GetItemNumber(al_riga, "importo_1")
ldc_imp2 = dw_corrisp_ext_gd.GetItemNumber(al_riga, "importo_2")
ldc_imp3 = dw_corrisp_ext_gd.GetItemNumber(al_riga, "importo_3")
ldc_imp4 = dw_corrisp_ext_gd.GetItemNumber(al_riga, "importo_4")
ldc_imp5 = dw_corrisp_ext_gd.GetItemNumber(al_riga, "importo_5")

ldc_imp1 = ldc_imp1 - uf_Scorpora(ldc_imp1, dw_corrisp_ext_gd.uf_GetItemDecimal(al_riga, "iva_1"))
ldc_imp2 = ldc_imp2 - uf_Scorpora(ldc_imp2, dw_corrisp_ext_gd.uf_GetItemDecimal(al_riga, "iva_2"))
ldc_imp3 = ldc_imp3 - uf_Scorpora(ldc_imp3, dw_corrisp_ext_gd.uf_GetItemDecimal(al_riga, "iva_3"))
ldc_imp4 = ldc_imp4 - uf_Scorpora(ldc_imp4, dw_corrisp_ext_gd.uf_GetItemDecimal(al_riga, "iva_4"))
ldc_imp5 = ldc_imp5 - uf_Scorpora(ldc_imp5, dw_corrisp_ext_gd.uf_GetItemDecimal(al_riga, "iva_5"))

ldc_RetVal = ldc_imp1 + ldc_imp2 + ldc_imp3 + ldc_imp4 + ldc_imp5
RETURN ldc_RetVal 
end function

public function decimal uf_scorpora (decimal adc_importo, decimal adc_iva);

decimal ldc_RetVal1, ldc_iva

IF adc_iva > 0 THEN
	ldc_RetVal1 = (adc_importo * 100 / (adc_iva + 100))
ELSE
	ldc_RetVal1 = 0
END IF
	
RETURN ldc_RetVal1
end function

public subroutine uf_feed_array (integer ai_i, decimal adc_importo, long al_idtab_iva, decimal adc_aliquota, long al_id_reg_pd);

integer li_insert_col, li_i 
boolean lb_inserted

lb_inserted = FALSE


FOR li_i = 1 to 5
	IF idc_importi[li_i, 1] = adc_aliquota THEN
		idc_importi[li_i, (ai_i + 2)] = adc_importo
		idc_importi[6, (ai_i + 2)] = al_id_reg_pd		
		lb_inserted = TRUE
	END IF
NEXT

IF lb_inserted = FALSE THEN
	FOR li_i = 1 to 5
		IF IsNull(idc_importi[li_i, 1]) OR (idc_importi[li_i, 1] = 0) THEN
			idc_importi[li_i, 1] = adc_aliquota
			idc_importi[li_i, 2] = al_IDTab_IVA
			idc_importi[li_i, (ai_i + 2)] = adc_importo
			idc_importi[6, (ai_i + 2)] = al_id_reg_pd					
			li_i = 5
		END IF
	NEXT
END IF
end subroutine

public subroutine uf_blank_array ();

integer li_i, li_j
long ll_UpperBound_X, ll_UpperBound_Y

ll_UpperBound_X = UpperBound(idc_importi, 1) 
ll_UpperBound_Y = UpperBound(idc_importi, 2)
FOR li_i = 1 TO ll_UpperBound_X
	FOR li_j = 1 TO ll_UpperBound_Y
		
		SetNull(idc_importi[li_i, li_j])
	NEXT
NEXT
end subroutine

public function decimal uf_iva_colonna (long al_riga, string as_colonna);

decimal ldc_importo

IF al_riga > 0 THEN
	ldc_importo = dw_corrisp_ext_gd.uf_GetItemDecimal(al_riga, as_colonna)
END IF

RETURN 0
end function

public function integer uf_controlla ();

long ll_CurrRow_ff, ll_CurrRow_gd, ll_id_iva1, ll_id_iva2, ll_id_iva3, ll_id_iva4, ll_id_iva5
long ll_RetVal = 1
boolean lb_col1 = TRUE, lb_col2 = TRUE, lb_col3 = TRUE, lb_col4 = TRUE, lb_col5 = TRUE
decimal ldc_tot_imp_1, ldc_tot_imp_2, ldc_tot_imp_3, ldc_tot_imp_4, ldc_tot_imp_5

ll_CurrRow_ff = dw_corrisp_ext_ff.GetRow()
ll_CurrRow_gd = dw_corrisp_ext_gd.GetRow()

ll_id_iva1 = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow_ff, "iva_1_des")
ldc_tot_imp_1 = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "totale_importo_1")
ll_id_iva2 = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow_ff, "iva_2_des")
ldc_tot_imp_2 = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "totale_importo_2")
ll_id_iva3 = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow_ff, "iva_3_des")
ldc_tot_imp_3 = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "totale_importo_3")
ll_id_iva4 = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow_ff, "iva_4_des")
ldc_tot_imp_4 = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "totale_importo_4")
ll_id_iva5 = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow_ff, "iva_5_des")
ldc_tot_imp_5 = dw_corrisp_ext_gd.uf_GetItemDecimal(ll_CurrRow_gd, "totale_importo_5")

IF (IsNull(ll_id_iva1) AND (ldc_tot_imp_1 > 0)) THEN lb_col1 = FALSE
IF (IsNull(ll_id_iva2) AND (ldc_tot_imp_2 > 0)) THEN lb_col2 = FALSE
IF (IsNull(ll_id_iva3) AND (ldc_tot_imp_3 > 0)) THEN lb_col3 = FALSE
IF (IsNull(ll_id_iva4) AND (ldc_tot_imp_4 > 0)) THEN lb_col4 = FALSE
IF (IsNull(ll_id_iva5) AND (ldc_tot_imp_5 > 0)) THEN lb_col5 = FALSE

IF (lb_col1 = TRUE) AND &
	(lb_col2 = TRUE) AND &
	(lb_col3 = TRUE) AND &
	(lb_col4 = TRUE) AND &
	(lb_col5 = TRUE) THEN
	ll_RetVal = 0
ELSE
	ll_RetVal = 1
END IF

RETURN ll_RetVal
end function

public function integer wf_controlla_conto (long al_id_prof_reg);integer li_ret

datastore ds_controlla_conto
ds_controlla_conto=create datastore
ds_controlla_conto.dataobject="ds_controlla_prof_mov_contabile"
ds_controlla_conto.settransobject(sqlca)
li_ret=ds_controlla_conto.retrieve(al_id_prof_reg)
destroy ds_controlla_conto
return li_ret
end function

public subroutine uf_setta_format (long il_valuta);

string ls_format, LS_EDIT


LS_FORMAT = F_VALU_MASK(il_valuta)
LS_EDIT = F_VALU_EDIT(il_valuta)
dw_corrisp_ext_gd.MODIFY("importo_1.EDIT.FORMAT ='"+ ls_edit+"'")
dw_corrisp_ext_gd.MODIFY("importo_1.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("importo_2.EDIT.FORMAT ='"+ ls_edit+"'")
dw_corrisp_ext_gd.MODIFY("importo_2.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("importo_3.EDIT.FORMAT ='"+ ls_edit+"'")
dw_corrisp_ext_gd.MODIFY("importo_3.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("importo_4.EDIT.FORMAT ='"+ ls_edit+"'")
dw_corrisp_ext_gd.MODIFY("importo_4.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("importo_5.EDIT.FORMAT ='"+ ls_edit+"'")
dw_corrisp_ext_gd.MODIFY("importo_5.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_riga.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_importo_tot.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_importo_1.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_importo_2.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_importo_3.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_importo_4.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_importo_5.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imponibile_1.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imponibile_2.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imponibile_3.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imponibile_4.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imponibile_5.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imposta_1.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imposta_2.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imposta_3.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imposta_4.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("imposta_5.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_imposta.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_imponibile.FORMAT ='"+ ls_format+"'")
dw_corrisp_ext_gd.MODIFY("totale_riga.FORMAT ='"+ ls_format+"'")


end subroutine

public subroutine uf_valuta (long rd_prof, long ll_lire);
decimal ld_parita
SELECT esercizio.id_valuta,  valuta.cambio, parita_euro
    INTO :ll_IDValuta,  :ldc_cambio, :ld_parita
    FROM registro, esercizio, valuta
   WHERE registro.id_esercizio=esercizio.id_esercizio 
	  and esercizio.id_valuta=valuta.id_valuta
	  and registro.id_registro=:rd_prof;

if ll_lire<>ll_idvaluta then ldc_cambio=ld_parita

IF SQLCA.SQLCode = -1 THEN
   MessageBox("Errore sul DataBase", "w_corrispettivi_wz / uf_crea_reg_pd / 3")
   RETURN
END IF

end subroutine

on w_corrispettivi_wz.create
int iCurrent
call super::create
this.dw_corrisp_ext_gd=create dw_corrisp_ext_gd
this.dw_corrisp_ext_ff=create dw_corrisp_ext_ff
this.cb_annulla=create cb_annulla
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_corrisp_ext_gd
this.Control[iCurrent+2]=this.dw_corrisp_ext_ff
this.Control[iCurrent+3]=this.cb_annulla
this.Control[iCurrent+4]=this.cb_ok
end on

on w_corrispettivi_wz.destroy
call super::destroy
destroy(this.dw_corrisp_ext_gd)
destroy(this.dw_corrisp_ext_ff)
destroy(this.cb_annulla)
destroy(this.cb_ok)
end on

event open;call super::open;
il_HelpTopic = 32
long		ll_row
long 		ll_index
DataWindowChild ldwc_prof_registrazione

dw_corrisp_ext_ff.GetChild("id_prof_registrazione_cod", ldwc_prof_registrazione)
ldwc_prof_registrazione.SetFilter("tipo_registrazione = 'V'")
ldwc_prof_registrazione.Filter()

il_dw_pass[1] = 0   		
SetNull(il_dw_pass[2])  
il_dw_pass[3] = 0  		
il_dw_pass[4] = 0   		
il_dw_pass[5] = 0   		
il_dw_pass[6] = 0  		
il_dw_pass[7] = 0   		
ll_row = dw_corrisp_ext_ff.InsertRow(0)
FOR ll_index = 1 TO 31
	ll_row = dw_corrisp_ext_gd.InsertRow(0)
NEXT
	
dw_corrisp_ext_ff.postevent("ue_post_open")
end event

type dw_corrisp_ext_gd from u_dw_ext_main within w_corrispettivi_wz
event ue_reset_importo ( )
event ue_blank ( )
int X=46
int Y=616
int Width=2491
int Height=780
int TabOrder=20
string DataObject="d_corrispettivi_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_reset_importo;call super::ue_reset_importo;long 		ll_index, ll_zero

ll_zero	= 0
FOR ll_index = 1 TO RowCount()
					This.SetItem(ll_index, "importo_1", ll_zero)
					This.SetItem(ll_index, "importo_2", ll_zero)
					This.SetItem(ll_index, "importo_3", ll_zero)
					This.SetItem(ll_index, "importo_4", ll_zero)
					This.SetItem(ll_index, "importo_5", ll_zero)
					
NEXT

end event

event ue_blank;call super::ue_blank;

long ll_i, ll_CurrRow, ll_NULL
SetNull(ll_NULL)

ll_CurrRow = dw_corrisp_ext_ff.GetRow()
dw_corrisp_ext_ff.SetItem(ll_CurrRow, "iva_1_cod", ll_NULL)
dw_corrisp_ext_ff.SetItem(ll_CurrRow, "iva_2_cod", ll_NULL)
dw_corrisp_ext_ff.SetItem(ll_CurrRow, "iva_3_cod", ll_NULL)
dw_corrisp_ext_ff.SetItem(ll_CurrRow, "iva_4_cod", ll_NULL)
dw_corrisp_ext_ff.SetItem(ll_CurrRow, "iva_5_cod", ll_NULL)

FOR ll_i = 1 TO RowCount()
	This.SetItem(ll_i, "importo_1", 0)
	This.SetItem(ll_i, "importo_2", 0)
	This.SetItem(ll_i, "importo_3", 0)
	This.SetItem(ll_i, "importo_4", 0)
	This.SetItem(ll_i, "importo_5", 0)
	
	This.SetItem(ll_i, "iva_1", 0)
	This.SetItem(ll_i, "iva_2", 0)
	This.SetItem(ll_i, "iva_3", 0)
	This.SetItem(ll_i, "iva_4", 0)
	This.SetItem(ll_i, "iva_5", 0)	
	
	
	This.SetItem(ll_i, "id_reg_pd", 0)	
NEXT

end event

event itemchanged;
decimal	ll_importo, ll_importo_prec, ll_totale_riga
string	ls_column, ls_text

ls_column = dwo.Name
CHOOSE CASE dwo.Name
	CASE "importo_1", "importo_2", "importo_3", "importo_4", "importo_5" 
			ls_text = This.GetText()
			IF IsNull(ls_text) THEN
				ls_text = "0"
			END IF	
			
			ll_importo = dec(ls_text) 
			ll_importo_prec = This.GetItemdecimal(row, ls_column)
			
			IF ll_importo_prec <> 0 THEN
				ll_importo = ll_importo - ll_importo_prec
			END IF	
			
			ll_totale_riga = This.GetItemdecimal(row, "totale_riga")
			ll_totale_riga = ll_totale_riga + ll_importo
			This.SetItem(row, "totale_riga", ll_totale_riga)
			
END CHOOSE


end event

event getfocus;call super::getfocus;long ll_index 

FOR ll_index = 1 TO RowCount()
					This.SetItem(ll_index, "iva_1", il_dw_pass[3])
					This.SetItem(ll_index, "iva_2", il_dw_pass[4])
					This.SetItem(ll_index, "iva_3", il_dw_pass[5])
					This.SetItem(ll_index, "iva_4", il_dw_pass[6])
					This.SetItem(ll_index, "iva_5", il_dw_pass[7])
NEXT

end event

type dw_corrisp_ext_ff from u_dw_ext_main within w_corrispettivi_wz
event ue_visualizza_reg_pd ( )
int X=46
int Y=160
int Width=2491
int Height=440
int TabOrder=10
string DataObject="d_corrispettivi_ff"
end type

event ue_visualizza_reg_pd;call super::ue_visualizza_reg_pd;

long ll_CurrRow_ff, ll_IDProf_Registrazione, ll_IDReg_PD, ll_SQL_reg_pd, ll_IDTab_IVA
integer li_giorno, li_mese, li_anno, li_i, li_NRows
date ld_data_registrazione
decimal ldc_importo, ldc_aliquota

ll_CurrRow_ff = dw_corrisp_ext_ff.GetRow()
ll_IDProf_Registrazione = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow_ff, "id_prof_registrazione_cod")
li_mese = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow_ff, "mese")
li_anno = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow_ff, "anno")
li_NRows = dw_corrisp_ext_gd.RowCount()

IF NOT IsNull(ll_IDProf_Registrazione) AND NOT IsNull(li_mese) AND NOT IsNull(li_anno) THEN
	
	dw_corrisp_ext_gd.Event ue_blank()
	uf_blank_array()
	FOR li_i = 1 TO li_NRows
		ld_data_registrazione = Date(f_lpad(string(li_i), "0", 2) + "/" + string(li_mese) + "/" + string(lI_anno))
		
		
		DECLARE lcur_reg_pd CURSOR FOR  
		  SELECT "reg_pd"."id_reg_pd"  
			 FROM "reg_pd"  
			WHERE ( "reg_pd"."id_prof_registrazione" = :ll_IDProf_Registrazione ) AND  
					( "reg_pd"."data_registrazione" = :ld_data_registrazione )   ;
		
		
		OPEN lcur_reg_pd ;
		FETCH lcur_reg_pd INTO :ll_IDReg_PD;
		ll_SQL_reg_pd = SQLCA.SQLCode
		CLOSE lcur_reg_pd ;
		
		IF ll_SQL_reg_pd = 0 THEN
			
			 DECLARE lcur_mov_iva CURSOR FOR  
			  SELECT "mov_iva"."imponibile" + "mov_iva"."imposta",   
			  			"mov_iva"."id_tab_iva",
						"tab_iva"."per_aliquota"  
				 FROM "mov_iva",   
						"tab_iva"  
				WHERE ( "tab_iva"."id_tab_iva" = "mov_iva"."id_tab_iva" ) and  
						( ( "mov_iva"."id_reg_pd" = :ll_IDReg_PD ) )   ;

			OPEN lcur_mov_iva ;
			
			FETCH lcur_mov_iva INTO :ldc_importo, :ll_IDTab_IVA, :ldc_aliquota;
			
			DO WHILE SQLCA.SQLCode = 0
				uf_Feed_Array(li_i, ldc_importo, ll_IDTab_IVA, ldc_aliquota, ll_IDReg_PD)
				FETCH lcur_mov_iva INTO :ldc_importo, :ll_IDTab_IVA, :ldc_aliquota;
			LOOP
			
			CLOSE lcur_mov_iva ;			
		END IF
	NEXT
	
	
	IF idc_importi[1, 2] > 0 THEN dw_corrisp_ext_ff.SetItem(ll_CurrRow_ff, "iva_1_cod", idc_importi[1, 2])
	IF idc_importi[2, 2] > 0 THEN dw_corrisp_ext_ff.SetItem(ll_CurrRow_ff, "iva_2_cod", idc_importi[2, 2])
	IF idc_importi[3, 2] > 0 THEN dw_corrisp_ext_ff.SetItem(ll_CurrRow_ff, "iva_3_cod", idc_importi[3, 2])	
	IF idc_importi[4, 2] > 0 THEN dw_corrisp_ext_ff.SetItem(ll_CurrRow_ff, "iva_4_cod", idc_importi[4, 2])	
	IF idc_importi[5, 2] > 0 THEN dw_corrisp_ext_ff.SetItem(ll_CurrRow_ff, "iva_5_cod", idc_importi[5, 2])	
	
	
	FOR li_i = 1 TO li_NRows
		IF idc_importi[1, li_i + 2] > 0 THEN 
			dw_corrisp_ext_gd.SetItem(li_i, "importo_1", idc_importi[1, li_i + 2])
			dw_corrisp_ext_gd.SetItem(li_i, "iva_1", idc_importi[1, 1])
			il_dw_pass[3] = idc_importi[1, 1]
		END IF
		IF idc_importi[2, li_i + 2] > 0 THEN 
			dw_corrisp_ext_gd.SetItem(li_i, "importo_2", idc_importi[2, li_i + 2])
			dw_corrisp_ext_gd.SetItem(li_i, "iva_2", idc_importi[2, 1])
			il_dw_pass[4] = idc_importi[2, 1]			
		END IF
		IF idc_importi[3, li_i + 2] > 0 THEN 
			dw_corrisp_ext_gd.SetItem(li_i, "importo_3", idc_importi[3, li_i + 2])  
			dw_corrisp_ext_gd.SetItem(li_i, "iva_3", idc_importi[3, 1])
			il_dw_pass[5] = idc_importi[3, 1]
		END IF
		IF idc_importi[4, li_i + 2] > 0 THEN 
			dw_corrisp_ext_gd.SetItem(li_i, "importo_4", idc_importi[4, li_i + 2])  
			dw_corrisp_ext_gd.SetItem(li_i, "iva_4", idc_importi[4, 1])			
			il_dw_pass[6] = idc_importi[4, 1]
		END IF
		IF idc_importi[5, li_i + 2] > 0 THEN 
			dw_corrisp_ext_gd.SetItem(li_i, "importo_5", idc_importi[5, li_i + 2])  
			dw_corrisp_ext_gd.SetItem(li_i, "iva_5", idc_importi[5, 1])			
			il_dw_pass[7] = idc_importi[5, 1]
		END IF
		IF idc_importi[6, li_i + 2] > 0 THEN dw_corrisp_ext_gd.SetItem(li_i, "id_reg_pd", idc_importi[6, li_i + 2])  		
	NEXT
END IF
end event

event itemchanged;


long		ll_ws, ll_index, ll_row, ll_ws2, ll_CurrRow_ff, ll_CurrRow_gd, ll_ID
integer	li_ws, li_ret
string	ls_column, ls_date_1, ls_date_2

ll_CurrRow_ff = dw_corrisp_ext_ff.GetRow()
ll_CurrRow_gd = dw_corrisp_ext_gd.GetRow()

ls_column = dwo.Name
li_ws = Long(data)
ll_ws = Long(data)  	
CHOOSE CASE dwo.Name
	CASE "id_prof_registrazione_cod", "id_prof_registrazione_des"
		li_ret=wf_controlla_conto(long(data))
		if li_ret < 2 then
			messagebox("Errore!", "Il profilo reg. scelto non ha conto per i profili di movimento contabile~r~nSpecificare un profilo valido!")
		end if
		THIS.PostEvent("ue_visualizza_reg_pd")
		
		
		long ll_val_lire, ll_registro
		select id_val_lire into :ll_val_lire from par_sistema;
		ll_registro = f_proponi_registro(long(data), u_freddie.gl_NULL)
      uf_valuta(ll_registro, ll_val_lire)
		
		post uf_setta_format(ll_idvaluta)
	CASE "mese"
		il_dw_pass[1] = Long(data)						
		uf_popola_mese(il_dw_pass[1], il_dw_pass[2], dw_corrisp_ext_gd , "ext_data")
		dw_corrisp_ext_gd.TriggerEvent("ue_reset_importo")
		THIS.PostEvent("ue_visualizza_reg_pd")			
	CASE "anno"		
		IF (ll_ws > 50) AND (ll_ws < 100) THEN 								
			ll_ws = ll_ws + 1900 
		END IF
		IF (ll_ws >= 0) AND (ll_ws <= 50) THEN 								
			ll_ws = ll_ws + 2000 
		END IF			
		
		il_dw_pass[2] = ll_ws
		uf_popola_mese(il_dw_pass[1], il_dw_pass[2], dw_corrisp_ext_gd , "ext_data")
		dw_corrisp_ext_gd.TriggerEvent("ue_reset_importo")
		This.SetItem(row, ls_column, ll_ws)				
		THIS.PostEvent("ue_visualizza_reg_pd")			
		RETURN 2
	CASE "iva_1_cod", "iva_1_des"
			
			il_dw_pass[3] = uf_prendi_aliquota(li_ws) 	
			dw_corrisp_ext_gd.TriggerEvent(GetFocus!)
	CASE "iva_2_cod", "iva_2_des"
			
			il_dw_pass[4] = uf_prendi_aliquota(li_ws) 	
			dw_corrisp_ext_gd.TriggerEvent(GetFocus!)
	CASE "iva_3_cod", "iva_3_des"

			il_dw_pass[5] = uf_prendi_aliquota(li_ws) 	
			dw_corrisp_ext_gd.TriggerEvent(GetFocus!)
	CASE "iva_4_cod", "iva_4_des"

			il_dw_pass[6] = uf_prendi_aliquota(li_ws) 	
			dw_corrisp_ext_gd.TriggerEvent(GetFocus!)
	CASE "iva_5_cod", "iva_5_des"

			il_dw_pass[7] = uf_prendi_aliquota(li_ws) 	
			dw_corrisp_ext_gd.TriggerEvent(GetFocus!)
END CHOOSE



end event

event ue_init;call super::ue_init;is_colonne_drop[1]  = "id_prof_registrazione_cod"
is_colonne_drop[2]  = "id_prof_registrazione_des"
is_colonne_drop[3]  = "iva_1_cod"
is_colonne_drop[4]  = "iva_2_cod"
is_colonne_drop[5]  = "iva_3_cod"
is_colonne_drop[6]  = "iva_4_cod"
is_colonne_drop[7]  = "iva_5_cod"
is_colonne_drop[8]  = "iva_1_des"
is_colonne_drop[9]  = "iva_2_des"
is_colonne_drop[10] = "iva_3_des"
is_colonne_drop[11] = "iva_4_des"
is_colonne_drop[12] = "iva_5_des"



end event

event itemfocuschanged;call super::itemfocuschanged;

long ll_CurrRow
integer li_mese, li_anno, li_RetVal

CHOOSE CASE string(dwo.name)
	CASE "anno"
		ll_CurrRow = THIS.GetRow()
		IF li_anno = 0 OR IsNull(li_anno) THEN &
			li_mese = THIS.GetItemNumber(ll_CurrRow, "mese")
			THIS.SetItem(ll_CurrRow, "anno", Year(Today()))
			li_anno = THIS.GetItemNumber(ll_CurrRow, "anno")			
			li_RetVal = uf_popola_mese(li_mese, li_anno, dw_corrisp_ext_gd, "ext_data")
			THIS.PostEvent("ue_visualizza_reg_pd")			
END CHOOSE

end event

type cb_annulla from commandbutton within w_corrispettivi_wz
int X=343
int Y=40
int Width=274
int Height=84
int TabOrder=40
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_corrispettivi_wz
int X=46
int Y=40
int Width=274
int Height=84
int TabOrder=30
string Text="Ok"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_CurrRow, ll_IDProf_Registrazione, ll_NRows, ll_IDReg_PD
decimal ldc_totale_riga
integer li_i

ll_CurrRow = dw_corrisp_ext_ff.GetRow()
ll_NRows = dw_corrisp_ext_gd.RowCount()
ll_IDProf_Registrazione = dw_corrisp_ext_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione_cod")

IF uf_controlla() = 0 THEN
	FOR li_i = 1 to ll_NRows
		ldc_totale_riga = dw_corrisp_ext_gd.uf_GetItemDecimal(li_i, "totale_riga")
		ll_IDReg_PD = dw_corrisp_ext_gd.GetItemNumber(li_i, "id_reg_pd")
		IF ldc_totale_riga > 0 AND NOT (ll_IDReg_PD > 0) THEN 
			uf_crea_reg_pd(li_i)
		END IF
	NEXT
	Close(Parent)
ELSE
	MessageBox("Corrispettivi", "Impossibile generare le registrazioni: Immettere una aliquota IVA~rper ognuna delle colonne sulle quali sono stati immessi degli importi.")
END IF
end event

