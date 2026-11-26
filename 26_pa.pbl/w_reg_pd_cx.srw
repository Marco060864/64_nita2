forward
global type w_reg_pd_cx from w_p_data
end type
type dw_reg_pd_pn_ff from u_dw_master_main within w_reg_pd_cx
end type
type p_arrowl from picture within w_reg_pd_cx
end type
type tab_mov_contabile from tab within w_reg_pd_cx
end type
type tabpage_mov_iva from userobject within tab_mov_contabile
end type
type dw_mov_iva_gd from u_dw_master_main within tabpage_mov_iva
end type
type dw_mov_iva_ff from u_dw_ext_main within tabpage_mov_iva
end type
type cb_ricalcolo from commandbutton within tabpage_mov_iva
end type
type cb_scorporo from commandbutton within tabpage_mov_iva
end type
type tabpage_mov_iva from userobject within tab_mov_contabile
dw_mov_iva_gd dw_mov_iva_gd
dw_mov_iva_ff dw_mov_iva_ff
cb_ricalcolo cb_ricalcolo
cb_scorporo cb_scorporo
end type
type tabpage_mov_contabile from userobject within tab_mov_contabile
end type
type cb_saldo_conto from commandbutton within tabpage_mov_contabile
end type
type cb_estratto_conto from commandbutton within tabpage_mov_contabile
end type
type cb_partite from commandbutton within tabpage_mov_contabile
end type
type p_arrowd from picture within tabpage_mov_contabile
end type
type dw_mov_contabile_gd from u_dw_master_main within tabpage_mov_contabile
end type
type tabpage_mov_contabile from userobject within tab_mov_contabile
cb_saldo_conto cb_saldo_conto
cb_estratto_conto cb_estratto_conto
cb_partite cb_partite
p_arrowd p_arrowd
dw_mov_contabile_gd dw_mov_contabile_gd
end type
type tabpage_partite_aperte from userobject within tab_mov_contabile
end type
type dw_mov_partita_conto_gd from u_dw_master_main within tabpage_partite_aperte
end type
type tabpage_partite_aperte from userobject within tab_mov_contabile
dw_mov_partita_conto_gd dw_mov_partita_conto_gd
end type
type tab_mov_contabile from tab within w_reg_pd_cx
tabpage_mov_iva tabpage_mov_iva
tabpage_mov_contabile tabpage_mov_contabile
tabpage_partite_aperte tabpage_partite_aperte
end type
type cbx_retain from checkbox within w_reg_pd_cx
end type
type pb_1 from picturebutton within w_reg_pd_cx
end type
type pb_cespiti from picturebutton within w_reg_pd_cx
end type
end forward

global type w_reg_pd_cx from w_p_data
integer x = 64
integer width = 2807
integer height = 1884
dw_reg_pd_pn_ff dw_reg_pd_pn_ff
p_arrowl p_arrowl
tab_mov_contabile tab_mov_contabile
cbx_retain cbx_retain
pb_1 pb_1
pb_cespiti pb_cespiti
end type
global w_reg_pd_cx w_reg_pd_cx

type variables
boolean ib_Crea_Mov_Contabili
boolean ib_crea_mov_contabili_IVA1
boolean ib_crea_mov_contabili_IVA2
string is_tipo_registro 
string is_item_precedente
string is_item_precedente_mov_con
boolean ib_crea_movimenti
boolean ib_nuovo_movimento
boolean ib_attiva_wizard
boolean ib_inserimento = FALSE

boolean ib_riga_protetta 
boolean ib_retrieve_partite = FALSE 
long il_id_ultimo_profilo = 0
string is_cod_ultimo_profilo = ""
string is_des_ultimo_profilo = ""
string is_par_menu
uo_wizard iuo_wizard
string is_title
s_list_main is_insoluti 
boolean ib_bloccata = FALSE
u_debug iu_debug
string is_filtro_conto 
long il_par_sistema_id_valuta
boolean ib_proteggi_cambio = TRUE

integer ii_test
string is_fil
long il_conto_old,il_conto_v
boolean ib_euro
string is_des_tipo_fatt
long il_pro_partita
decimal id_segno_iva
string is_chiocciola
long il_esercizio
string is_par_desc, is_prop_data
long is_test_par
long il_lire, ll_Valuta_Reg_PD
end variables

forward prototypes
public function boolean uf_controlla_saldo (datawindow ldw_oggetto_gd)
public function boolean uf_convalida_salvataggio ()
public subroutine uf_aggiorna_tot_iva ()
public function string uf_seleziona_tipo_registro (long l_id_registro)
public function decimal uf_calcola_saldo_conto (long l_idconto)
public function boolean uf_controlla_movimenti ()
public subroutine uf_par_aperte ()
public subroutine uf_genera_movimenti ()
public subroutine uf_displayonly (datawindow dw_dwobj, string s_field, boolean b_status)
public function string uf_visualizza_info_sc ()
public function string uf_visualizza_info_reg_pd ()
public function decimal uf_proponi_scorporo ()
public function long uf_proponi_iva_da_prof (long al_idprof_registrazione)
public function string uf_notifica_reg_esistente (long l_idconto, string s_num_documento, date d_data_documento, long l_num_reg_esistente, date d_data_reg_esistente, long l_id_registro)
public subroutine uf_elimina_incompleta ()
public function integer uf_controlla_data_doc ()
public subroutine uf_aggiorna_date_esercizio (long al_id_esercizio)
public subroutine uf_riproponi_num_reg_pd ()
public subroutine uf_riproponi_num_documento ()
public subroutine uf_setup_window ()
public subroutine uf_assegna_tipo_fattura (long al_id_prof_registrazione)
public subroutine uf_sposta_focus (datawindow adw_grid, string ai_colonna)
public subroutine uf_ricerca ()
public function string uf_tipo_registrazione (string as_tipo_registro)
public subroutine uf_proponi_default ()
public function integer uf_nuovo ()
public subroutine uf_controlla_esistente ()
public subroutine uf_setup_id ()
public function boolean uf_attiva_insoluti (long al_id_prof_registrazione)
public subroutine uf_crea_mov_contabili ()
public subroutine uf_crea_mov_contabili_iva1 ()
public subroutine uf_crea_mov_contabili_iva1a ()
public subroutine uf_crea_mov_contabili_iva2 ()
public subroutine uf_attiva_wizard ()
public function decimal uf_imposta (decimal adc_imponibile, long al_id_tab_iva)
public subroutine uf_ricalcolo ()
public subroutine uf_scorporo ()
public subroutine uf_abilita_controlli_iva (boolean ab_parametro)
public subroutine uf_accedi_protetti (string as_campo)
public subroutine uf_attiva_partite ()
public function boolean uf_controlla_esistente_iva ()
public function character uf_calcola_segno (string as_tipo_registro, character ac_tipo_fattura, long al_id_prof_registrazione, character ac_tipo_riga)
public subroutine uf_aggiorna_saldo_partita ()
public subroutine uf_chiudi_scadenze (integer li_id_par_aperte, long ll_id_mov_partita)
public subroutine uf_calcola_data_fine_amm (long ll_id_cespite)
public subroutine uf_cancella_risconti_storni (long ll_id_reg_pd)
public subroutine uf_aggiorna_totale_righe (long ll_id_reg_pd, string ls_segno, string ls_ris_sto)
public subroutine uf_ricerca_1 ()
public subroutine uf_crea_righe_iva_det ()
public subroutine uf_crea_righe_iva_det1 ()
public subroutine uf_crea_righe_nd1 ()
public function long uf_insoluti (integer par_aperta, integer reg_pd)
public function long uf_controlla_sbilanciate ()
public subroutine uf_cancella_cdc (integer ll_idreg_pd)
public subroutine uf_calc_cdc_ia ()
public subroutine uf_ripristina_data (integer row)
public subroutine uf_componi_descrizione ()
public function string uf_des_mov_contabile (string ls_des, integer ll_row)
public subroutine uf_test_des_mov (string ls_test)
public subroutine wf_ute_reg_pd (string ac_operazione)
end prototypes

public function boolean uf_controlla_saldo (datawindow ldw_oggetto_gd);

long ll_CurrRow, ll_Righe_Movimenti
decimal{2} ll_Tot_Dare, ll_Tot_Avere, ll_Saldo
integer li_Action

ll_CurrRow = ldw_oggetto_gd.GetRow()


IF ll_CurrRow <> 0 THEN
	ll_Tot_Dare = ldw_oggetto_gd.GetItemNumber(ll_CurrRow, "totale_dare")
	ll_Tot_Avere = ldw_oggetto_gd.GetItemNumber(ll_CurrRow, "totale_avere")
	ll_Saldo = ll_Tot_Dare - ll_Tot_Avere
ELSE
	ll_Saldo = 0
	ll_Tot_Dare = 0
	ll_Tot_Avere = 0
END IF

IF ll_Saldo = 0 AND ll_Tot_Dare > 0 AND ll_Tot_Avere > 0 THEN
	li_Action = MessageBox("","La registrazione è già bilanciata.~rSi desidera confermarla?", Information!, YesNo!)
	IF li_Action = 1 THEN
		TriggerEvent("ue_update")
		RETURN FALSE
	END IF
END IF

RETURN TRUE
end function

public function boolean uf_convalida_salvataggio ();

long ll_CurrRow_Reg_PD, ll_CurrRow,  ll_IDRegistro
DECIMAL ll_Tot_Dare, ll_Tot_Avere, ll_Saldo
long ll_CurrRow_Mov_IVA_ff
integer li_Action
string ls_tipo_registro
decimal ldec_differenza
boolean lb_attiva_insoluti
dwItemStatus lis_Stato_Reg_PD

ll_CurrRow = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetRow()
ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
ll_CurrRow_Mov_IVA_ff = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.GetRow()

IF ll_CurrRow <> 0 THEN
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.AcceptText()
	ll_Tot_Dare = ROUND(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "totale_dare"),2)
	ll_Tot_Avere = ROUND(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "totale_avere"),2)
	ll_Saldo = ll_Tot_Dare - ll_Tot_Avere

	IF ll_Saldo <> 0 THEN
		messagebox("Uf_convalida - saldo (dare-avere) ",ll_saldo)
		messagebox("Uf_convalida - saldo (dare-avere) ",STRING(ll_TOT_DARE) + '  ' +STRING(LL_TOT_AVERE))	
		li_Action = MessageBox("Registrazioni Contabili", "Impossibile salvare: la registrazione non è bilanciata.", Information!, Ok!)
		RETURN FALSE
	END IF
ELSE
	lis_Stato_Reg_PD = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow_Reg_PD, 0, Primary!)
	IF lis_Stato_Reg_PD <> New! AND lis_Stato_Reg_PD <> NewModified! THEN

		ll_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD,"id_registro")
		SELECT "registro"."tipo_registro"
			INTO :ls_tipo_registro
			FROM "registro"
			WHERE "registro"."id_registro" = :ll_IDRegistro;

		ldec_differenza = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.GetItemNumber(ll_CurrRow_Mov_IVA_ff, "differenza")

		IF NOT ((ls_tipo_registro <> "IA" OR ls_tipo_registro <> "IV") AND (ldec_differenza <> 0 OR NOT IsNull(ldec_differenza))) THEN

			li_Action = MessageBox("Registrazioni Contabili", "Impossibile salvare: La registrazione non ha movimenti contabili.~rSi desidera salvarla ugualmente?", Exclamation!, YesNo!)
			IF li_Action = 2 THEN
				RETURN FALSE
			END IF
		END IF
	END IF
	
END IF

RETURN TRUE

end function

public subroutine uf_aggiorna_tot_iva ();


Decimal ld_totale_imponibile, ld_totale_imposta
Long ll_CurrRow_Mov_IVA, ll_CurrRow_Reg_PD, ll_RetVal

ll_CurrRow_Mov_IVA = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetRow()
ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

IF ll_CurrRow_Mov_IVA <> 0 THEN
	ld_totale_imponibile = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.uf_GetItemDecimal(ll_CurrRow_Mov_IVA, "totale_imponibile")
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow_Reg_PD, "imponibile", ld_totale_imponibile)

	
	

	ld_totale_imposta = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.uf_GetItemDecimal(ll_CurrRow_Mov_IVA, "totale_imposta")
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow_Reg_PD, "imposta", ld_totale_imposta)

	
	
ELSE
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow_Reg_PD, "imponibile", 0)

	
	

	dw_reg_pd_pn_ff.SetItem(ll_CurrRow_Reg_PD, "imposta", 0)

	
	
END IF

end subroutine

public function string uf_seleziona_tipo_registro (long l_id_registro);

string ls_tipo_registro

SELECT "registro"."tipo_registro"
	INTO :ls_tipo_registro
	FROM "registro"
	WHERE "registro"."id_registro" = :l_id_registro;

CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul Database", "uf_seleziona_tipo_registro")
		RETURN ""
	CASE 100
		RETURN ""
END CHOOSE

RETURN ls_tipo_registro
end function

public function decimal uf_calcola_saldo_conto (long l_idconto);

decimal ldc_saldo

SELECT sum("saldo_mensile"."saldo")
 INTO :ldc_saldo
 FROM "azienda",
		"esercizio",
		"saldo_mensile",
		"conto"
WHERE ( "esercizio"."id_esercizio" = "azienda"."id_esercizio" ) and
		( "saldo_mensile"."id_esercizio" = "esercizio"."id_esercizio" ) and
		( "conto"."id_conto" = "saldo_mensile"."id_conto" ) and
		( ( "azienda"."id_azienda" = 1 ) AND
		( "conto"."id_conto" = :l_IDConto ) )   ;

CHOOSE CASE SQLCA.SQLCode
	CASE -1, 100
		ldc_saldo = 0
END CHOOSE


RETURN ldc_saldo
end function

public function boolean uf_controlla_movimenti ();

long ll_CurrRow_Reg_PD
long ll_Righe_Mov_Contabili, ll_Righe_Mov_IVA, ll_IDRegistro
string ls_tipo_registro

ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

IF ll_CurrRow_Reg_PD > 0 THEN
	ll_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_registro")

	SELECT "dba"."registro"."tipo_registro"
		INTO :ls_tipo_registro
		FROM "dba"."registro"
		WHERE "dba"."registro"."id_registro" = :ll_IDRegistro;

	IF SQLCA.SQLCode = -1 THEN
		MessageBox("Errore sul Database", "w_reg_pd_cx / uf_controlla_movimenti")
		RETURN FALSE
	END IF

	ll_Righe_Mov_Contabili = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.RowCount()
	ll_Righe_Mov_IVA = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.RowCount()

	IF ll_Righe_Mov_Contabili = 0 OR &
			(ll_Righe_Mov_IVA = 0 AND &
			(ls_tipo_registro = "IA" OR ls_tipo_registro = "IV")) THEN
		
		RETURN FALSE
	END IF

	RETURN TRUE

END IF

RETURN TRUE
end function

public subroutine uf_par_aperte ();

long ll_Conto_Movimento, ll_CurrRow
char lc_ges_par_aperte

CONSTANT char lc_BOOLEAN_YES = "S"
CONSTANT char lc_BOOLEAN_NO = "N"

ll_CurrRow = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetRow()

IF ll_CurrRow <> 0 THEN
	
	ll_Conto_Movimento = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "id_conto")
	

	
	SELECT "conto"."ges_par_aperte"
		INTO :lc_ges_par_aperte
		FROM "conto"
		WHERE "conto"."id_conto" = :ll_Conto_Movimento;

	
	IF lc_ges_par_aperte = lc_BOOLEAN_NO THEN
		tab_mov_contabile.tabpage_partite_aperte.enabled = FALSE
	ELSE
		tab_mov_contabile.tabpage_partite_aperte.enabled = TRUE
	END IF
END IF

end subroutine

public subroutine uf_genera_movimenti ();

long ll_CurrRow_Reg_PD, ll_IDRegistro, ll_CurrRow_Mov_IVA_ff
decimal ld_differenza
string ls_Parametro, ls_tipo_registro, ls_differenza
datawindow ldw_mov_contabile

ldw_mov_contabile = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd

ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
ls_Parametro = dw_reg_pd_pn_ff.is_list.s_win_parametri
if ls_parametro<>'PN' then
	ll_CurrRow_Mov_IVA_ff = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.GetRow()
	ld_differenza = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.uf_GetItemDecimal(ll_CurrRow_Mov_IVA_ff, "differenza")
end if
ll_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_registro")

SELECT "dba"."registro"."tipo_registro"
	INTO :ls_tipo_registro
	FROM "registro"
	WHERE "dba"."registro"."id_registro" = :ll_IDRegistro;

CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul Database", "uf_genera_movimenti")
		RETURN
	CASE 100
		ls_tipo_registro = ""
END CHOOSE
IF (ls_Parametro = "IA" OR &
	ls_Parametro = "IV" OR &
	ls_Parametro = "AV" OR &
	ls_tipo_registro = "IA" OR &
	ls_tipo_registro = "IC" OR &	
	ls_tipo_registro = "IV") THEN
	IF (ld_differenza <> 0) OR IsNull(ld_differenza) THEN
		ib_crea_mov_contabili_IVA1 = FALSE
		ib_Crea_Mov_Contabili = FALSE
		ib_crea_mov_contabili_IVA2 = FALSE
	ELSE
		ib_crea_mov_contabili_IVA1 = TRUE
		ib_Crea_Mov_Contabili = TRUE
		ib_crea_mov_contabili_IVA2 = TRUE
	END IF
END IF

IF ib_crea_mov_contabili_IVA1 = TRUE THEN
	
	
	
	Post Function uf_crea_mov_contabili_IVA1()
	ib_crea_mov_contabili_IVA1 = FALSE
END IF

IF ib_crea_mov_contabili_IVA2 = TRUE THEN
	
	
	Post Function uf_crea_mov_contabili_IVA2()
	ib_crea_mov_contabili_IVA2 = FALSE
END IF

IF ib_Crea_Mov_Contabili = TRUE THEN
	
	
	Post Function uf_crea_mov_contabili()

	ib_Crea_Mov_Contabili = FALSE
	ib_nuovo_movimento = TRUE
END IF


end subroutine

public subroutine uf_displayonly (datawindow dw_dwobj, string s_field, boolean b_status);

dw_dwobj.Modify(s_field + ".Protect = " + string(b_status))
dw_dwobj.Modify(s_field + ".Background.Mode=" + string(b_status))
end subroutine

public function string uf_visualizza_info_sc ();


long ll_CurrRow_Reg_PD, ll_IDConto, ll_id_anagrafica
string ls_info, ls_Rag_Soc_1, ls_Rag_Soc_2, ls_Ind, ls_CAP, ls_Loc, ls_Prov, ls_Naz, ls_CF, ls_PI
ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
	ll_IDConto = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_conto")
  SELECT "anagrafica"."id_anagrafica",
  			"anagrafica"."rag_soc_1",
         "anagrafica"."rag_soc_2",
         "anagrafica"."indirizzo",
         "anagrafica"."cap",
         "anagrafica"."localita",
         "anagrafica"."provincia",
         "anagrafica"."nazione",
         "anagrafica"."cod_fiscale",
         "anagrafica"."par_iva"
    INTO :ll_id_anagrafica,
	 		:ls_Rag_Soc_1,
         :ls_Rag_Soc_2,
         :ls_Ind,
         :ls_CAP,
         :ls_Loc,
         :ls_Prov,
         :ls_Naz,
         :ls_CF,
         :ls_PI
    FROM "anagrafica",
         "conto",
         "sog_commerciale"
   WHERE ( "sog_commerciale"."id_conto" = "conto"."id_conto" ) and
         ( "sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and
         ( ( "conto"."id_conto" = :ll_IDConto ) )   ;

	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			MessageBox("Errore sul DataBase", "uf_visualizza_info_sc")
	END CHOOSE


IF IsNull(ll_id_anagrafica) OR ll_id_anagrafica = 0 THEN
	ls_info = ""
ELSE
	IF IsNull(ls_Rag_Soc_1) THEN ls_Rag_Soc_1 = ""
	IF IsNull(ls_Rag_Soc_2) THEN ls_Rag_Soc_2 = ""
	IF IsNull(ls_Ind)       THEN ls_Ind       = ""
	IF IsNull(ls_CAP)       THEN ls_CAP       = ""
	IF IsNull(ls_Loc)       THEN ls_Loc       = ""
	IF IsNull(ls_Prov)      THEN ls_Prov      = ""
	IF IsNull(ls_Naz)       THEN ls_Naz       = ""
	IF IsNull(ls_CF)        THEN ls_CF        = ""
	IF IsNull(ls_PI)        THEN ls_PI        = ""

	ls_info = ls_Rag_Soc_1 + " - " + ls_Rag_Soc_2 + "~r" + ls_Ind + "~r" + ls_CAP + " " + ls_Loc + " " + ls_Prov + " " + ls_Naz + "~rP.I.:" + ls_PI + " - C.F.:" + ls_CF
END IF

RETURN ls_info
end function

public function string uf_visualizza_info_reg_pd ();

long ll_CurrRow
string ls_RetVal, ls_esercizio, ls_tipo_registro, ls_num_registro, ls_n_progr, ls_data_reg, ls_data_comp, ls_n_doc, ls_data_doc, ls_des_contab, ls_imp_doc

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()

IF ll_CurrRow > 0 THEN
	ls_esercizio = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "esercizio_codice")
	ls_tipo_registro = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "tipo_registro")
	ls_num_registro = string(dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "registro_numero"))
	ls_n_progr = string(dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "num_progressivo"))
	ls_data_reg = string(dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow, "data_competenza"), "dd/mm/yyyy")
	ls_data_comp = string(dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow, "data_registrazione"), "dd/mm/yyyy")
	ls_n_doc = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "num_documento")
	ls_data_doc = string(dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow, "data_documento"), "dd/mm/yyyy")
	ls_des_contab = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "descrizione")
	ls_imp_doc = string(dw_reg_pd_pn_ff.uf_GetItemDecimal(ll_CurrRow, "importo"))

	ls_RetVal = "Esercizio: " + ls_esercizio + " - Tipo Registro: " + ls_tipo_registro + &
					" - N. Registro: " + ls_num_registro + "~rNum. Progr.: " + ls_n_progr + &
					" - Data Registraz.: " + ls_data_reg + " - Data Comp.: " + ls_data_comp + &
					"~rNum. Doc.: " + ls_n_doc + " - Data Doc.: " + ls_data_doc + &
					"~rDes. Contabile: " + ls_des_contab + "~rImporto: " + ls_imp_doc

	RETURN ls_RetVal
ELSE
	RETURN ""
END IF
end function

public function decimal uf_proponi_scorporo ();

decimal ldc_tot_documento, ldc_per_aliquota, ldc_per_detrazione, ldc_imponibile
long ll_CurrRow_reg_PD, ll_IDConto, ll_IDTab_IVA, ll_IDProf_Registrazione

ll_CurrRow_reg_PD = dw_reg_pd_pn_ff.GetRow()

ldc_tot_documento = dw_reg_pd_pn_ff.uf_GetItemDecimal(ll_CurrRow_reg_PD, "importo")

ll_IDConto = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_reg_PD, "id_conto")

IF NOT IsNull(ll_IDConto) THEN

  SELECT "dba"."tab_iva"."per_aliquota",
         "dba"."tab_iva"."per_detrazione"
    INTO :ldc_per_aliquota,
         :ldc_per_detrazione
    FROM "dba"."sog_commerciale",
         "dba"."tab_iva"
   WHERE ( "dba"."tab_iva"."id_tab_iva" = "dba"."sog_commerciale"."id_tab_iva" ) and
         ( ( "dba"."sog_commerciale"."id_conto" = :ll_IDConto ) )   ;

	CHOOSE CASE SQLCA.SQLCode
		CASE 100
			ll_IDProf_Registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_reg_PD, "id_prof_registrazione")

			  SELECT "dba"."tab_iva"."per_aliquota",
						"dba"."tab_iva"."per_detrazione"
				 INTO :ldc_per_aliquota,
						:ldc_per_detrazione
				 FROM "dba"."prof_registrazione",
						"dba"."tab_iva"
				WHERE ( "dba"."tab_iva"."id_tab_iva" = "dba"."prof_registrazione"."id_tab_iva" ) and
						( ( "dba"."prof_registrazione"."id_prof_registrazione" = :ll_IDProf_Registrazione ) )   ;

			CHOOSE CASE SQLCA.SQLCode
				CASE -1
					MessageBox("Errore sul Database","dw_mov_iva_gd / ue_proponi_scorporo / 2")
					RETURN 0
				CASE 100
					ldc_tot_documento = 0
			END CHOOSE

		CASE -1
			MessageBox("Errore sul Database","dw_mov_iva_gd / ue_proponi_scorporo / 1")
			RETURN 0
	END CHOOSE
	
   if il_lire=ll_valuta_reg_pd then  
		ldc_imponibile = ceiling ((100 * ldc_tot_documento) / (100 + ldc_per_aliquota))
	else	
	
		ldc_imponibile = (100 * ldc_tot_documento) / (100 + ldc_per_aliquota)
	end if	
	RETURN ldc_imponibile
END IF
end function

public function long uf_proponi_iva_da_prof (long al_idprof_registrazione);

long ll_IDTab_IVA

  SELECT "dba"."prof_registrazione"."id_tab_iva"
	 INTO :ll_IDTab_IVA
	 FROM "dba"."prof_registrazione"
	WHERE "dba"."prof_registrazione"."id_prof_registrazione" = :al_idprof_registrazione;

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		RETURN ll_IDTab_IVA
	CASE -1
		MessageBox("Errore sul DataBase", "uf_proponi_iva_da_prof / 1")
		RETURN 0
END CHOOSE


RETURN 0
end function

public function string uf_notifica_reg_esistente (long l_idconto, string s_num_documento, date d_data_documento, long l_num_reg_esistente, date d_data_reg_esistente, long l_id_registro);

long ll_SQL1, ll_SQL2
string ls_error_text, ls_conto_codice, ls_des_registro

SELECT "registro"."descrizione"
	INTO :ls_des_registro
   FROM "registro"
   WHERE "registro"."id_registro" = :l_id_registro   ;

ll_SQL1 = SQLCA.SQLCode

SELECT "conto"."codice"
	INTO :ls_conto_codice
	FROM "conto"
	WHERE "conto"."id_conto" = :l_IDConto;

ll_SQL2 = SQLCA.SQLCode

IF ll_SQL1 = 0  AND ll_SQL2 = 0 THEN
	ls_error_text = "Attenzione: Il registro " + ls_des_registro + " contiene la~rregistrazione " + string(l_num_reg_esistente) + " del " + string(d_data_reg_esistente) + " con conto " &
		+ trim(ls_conto_codice) + ", numero~rdocumento " + s_num_documento &
		+ " e data documento " + string(d_data_documento) + "."
ELSE
	ls_error_text = ""
END IF

RETURN ls_error_text
end function

public subroutine uf_elimina_incompleta ();

long ll_CurrRow, ll_IDReg_PD, ll_IDPar_Aperta

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()

IF ll_CurrRow > 0 AND ib_inserimento = TRUE THEN
	ll_IDReg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_reg_pd")
	IF ll_IDReg_PD > 0 THEN
		SELECT "par_aperta"."id_par_aperta"
    		INTO :ll_IDPar_Aperta
    		FROM "par_aperta"
   		WHERE "par_aperta"."id_reg_pd" = :ll_IDReg_PD   ;

		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				
				DELETE FROM "mov_partita"
					WHERE ( "mov_partita"."id_reg_pd" = :ll_IDReg_PD ) AND
							( "mov_partita"."id_par_aperta" = :ll_IDPar_Aperta )   ;
            commit;
				
				DELETE FROM "par_aperta"
					WHERE "par_aperta"."id_par_aperta" = :ll_IDPar_Aperta   ;
            commit;
			CASE -1
				MessageBox("Errore sul DataBase", "w_reg_pd_cx / uf_elimina_incompleta / 1")
				RETURN
		END CHOOSE

		
		DELETE FROM "mov_iva"
			WHERE "mov_iva"."id_reg_pd" = :ll_IDReg_PD   ;
		commit;
		
		DELETE FROM "mov_contabile"
			WHERE "mov_contabile"."id_reg_pd" = :ll_IDReg_PD   ;
      commit;
		
		DELETE FROM "compenso"
			WHERE "compenso"."id_reg_pd" = :ll_IDReg_PD   ;
      commit;
		
		DELETE FROM "reg_pd"
			WHERE "reg_pd"."id_reg_pd" = :ll_IDReg_PD   ;
		commit;	
		
		
		

		COMMIT USING SQLCA;
	END IF
END IF
end subroutine

public function integer uf_controlla_data_doc ();

date ld_data_registrazione, ld_data_documento

ld_data_registrazione = dw_reg_pd_pn_ff.GetItemDate(dw_reg_pd_pn_ff.GetRow(), "data_registrazione")
IF NOT IsNull(ld_data_registrazione) THEN
	dw_reg_pd_pn_ff.AcceptText()
	ld_data_documento = dw_reg_pd_pn_ff.GetItemDate(dw_reg_pd_pn_ff.GetRow(), "data_documento")
	IF ld_data_documento > ld_data_registrazione THEN
		RETURN 1
	ELSE
		RETURN 0
	END IF
END IF

RETURN 1
end function

public subroutine uf_aggiorna_date_esercizio (long al_id_esercizio);

long ll_CurrRow
date ld_data_inizio, ld_data_fine
dwItemStatus ldwis_status1, ldwis_status2

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()

SELECT "dba"."esercizio"."data_inizio",
	    "dba"."esercizio"."data_fine"
	INTO :ld_data_inizio,
		  :ld_data_fine
	FROM "dba"."esercizio"
	WHERE "dba"."esercizio"."id_esercizio" = :al_id_esercizio   ;

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		ldwis_status1 = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow, "esercizio_data_inizio", Primary!)
		ldwis_status2 = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow, "esercizio_data_fine", Primary!)

		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "esercizio_data_inizio", ld_data_inizio)
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "esercizio_data_fine", ld_data_fine)

		dw_reg_pd_pn_ff.SetItemStatus(ll_CurrRow, "esercizio_data_inizio", Primary!, ldwis_status1)
		dw_reg_pd_pn_ff.SetItemStatus(ll_CurrRow, "esercizio_data_fine", Primary!, ldwis_status2)

	CASE -1
		MessageBox("Errore sul DataBase", "uf_aggiorna_date_esercizio / 1")
END CHOOSE

end subroutine

public subroutine uf_riproponi_num_reg_pd ();

long ll_CurrRow, ll_id_registro, ll_num_registrazione, ll_num_registrazione_new
date ld_data_registrazione
string ls_tipo_registro

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
ll_id_registro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")
ld_data_registrazione = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow, "data_registrazione")
ll_num_registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "num_progressivo")
ls_tipo_registro = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "tipo_registro")

ll_num_registrazione_new = f_proponi_num_reg_pd_anno(ll_id_registro, year(ld_data_registrazione))
IF ll_num_registrazione_new <> ll_num_registrazione THEN
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "num_progressivo", ll_num_registrazione_new)
	MessageBox("Registrazioni Contabili", "Attenzione: non esistono registrazioni di tipo " + &
		ls_tipo_registro + " per l'anno " + string(year(ld_data_registrazione)) + &
		".~rIl numero progressivo è stato aggiornato a " + string(ll_num_registrazione_new) + ".")
END IF
end subroutine

public subroutine uf_riproponi_num_documento ();

long ll_CurrRow, ll_id_registro
date ld_data_documento
string ls_tipo_registro, ls_num_documento, ls_num_documento_new

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
ll_id_registro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")
ld_data_documento = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow, "data_documento")
ls_num_documento = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "num_documento")
ls_tipo_registro = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "tipo_registro")

ls_num_documento_new = f_proponi_num_documento_anno(ll_id_registro, year(ld_data_documento))
IF ls_num_documento_new <> ls_num_documento THEN
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "num_documento", ls_num_documento_new)
	MessageBox("Registrazioni Contabili", "Attenzione: non esistono registrazioni di tipo " + &
		ls_tipo_registro + " per l'anno " + string(year(ld_data_documento)) + &
		".~rIl numero documento è stato aggiornato a " + string(ls_num_documento_new) + ".")
END IF
end subroutine

public subroutine uf_setup_window ();

string ls_Parametro

ls_Parametro = dw_reg_pd_pn_ff.is_list.s_win_parametri

CHOOSE CASE ls_Parametro
	CASE "PN"
		is_title = "Registrazioni Prima Nota (PN)"
		Post Function uf_abilita_controlli_iva(FALSE)
	CASE "MN"
		is_title = "Registrazioni Manageriali (MN)"
		Post Function uf_abilita_controlli_iva(FALSE)
	CASE "PM"
		is_title = "Registrazioni Prima Nota/Manageriali (PN/MN)"
		Post Function uf_abilita_controlli_iva(FALSE)
	CASE "IA"
		is_title = "Registrazioni IVA Acquisti (IA)"
		Post Function uf_abilita_controlli_iva(TRUE)
	CASE "IV"
		is_title = "Registrazioni IVA Vendite (IV)"
		Post Function uf_abilita_controlli_iva(TRUE)
	CASE "AV"
		is_title = "Registrazioni IVA Acquisti/IVA Vendite (IA/IV)"
		Post Function uf_abilita_controlli_iva(TRUE)
	CASE "IC"
		is_title = "Registrazioni IVA Corrispettivi (IC)"
		Post Function uf_abilita_controlli_iva(TRUE)
	CASE "PI"
		is_title = "Tutte le Registrazioni (PN/MN/IA/IV)"
		Post Function uf_abilita_controlli_iva(TRUE)
	CASE ELSE
		is_title = "Registrazioni Contabili"
		Post Function uf_abilita_controlli_iva(TRUE)
END CHOOSE

THIS.Title = is_title

ib_Attiva_Wizard = FALSE

ib_Inserimento = FALSE

ib_riga_protetta = FALSE

tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.object.nmax.width = 0

SetNull(is_filtro_conto)

dw_reg_pd_pn_ff.object.esercizio_id_esercizio.Accelerator = 'E'

IF IsValid(w_msg_log) THEN
	w_msg_log.x = 900
	w_msg_log.width = 2700
	w_msg_log.height = 400
END IF

end subroutine

public subroutine uf_assegna_tipo_fattura (long al_id_prof_registrazione);

long ll_CurrRow
char lc_tipo_fattura
integer li_segno_reg_iva

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()

IF (al_id_prof_registrazione > 0) AND (ll_CurrRow > 0) THEN
	SELECT "dba"."prof_registrazione"."tipo_fattura"
		INTO :lc_tipo_fattura
		FROM "dba"."prof_registrazione"
		WHERE "dba"."prof_registrazione"."id_prof_registrazione" = :al_id_prof_registrazione   ;

	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			CHOOSE CASE lc_tipo_fattura
				CASE "N", "D"
					li_segno_reg_iva = 1
				CASE "C"
					li_segno_reg_iva = -1
			END CHOOSE
			dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "reg_pd_tipo_fattura", lc_tipo_fattura)
			dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "reg_pd_segno_reg_iva", li_segno_reg_iva)
		CASE -1
			MessageBox("Errore sul DataBase", "w_reg_pd_cx / uf_assegna_tipo_fattura / 1")
	END CHOOSE
END IF
end subroutine

public subroutine uf_sposta_focus (datawindow adw_grid, string ai_colonna);

long ll_righe

ll_Righe = adw_grid.RowCount()

adw_grid.SetRow(ll_Righe)
adw_grid.SetColumn(ai_colonna)
adw_grid.SetFocus()
end subroutine

public subroutine uf_ricerca ();
w_search_main lw_sm

long ll_CurrRow, ll_id_reg_pd, ll_id_esercizio
string ls_cod_esercizio, ls_filtro, ls_Parametro, ls_SQL_cond, ls_dwcol[], ls_dbfield[]
string ls_st_stampa_bollato
ls_Parametro = trim(idw_master.is_list.s_win_parametri)

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
ll_id_esercizio = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "esercizio_id_esercizio")


SELECT esercizio.codice
	INTO :ls_cod_esercizio
	FROM esercizio
	WHERE esercizio.id_esercizio = :ll_id_esercizio;

CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / uf_ricerca / 1")
		RETURN
END CHOOSE

IF IsNull(ls_cod_esercizio) THEN
	MessageBox("Registrazioni Contabili", "Attenzione: non è stato selezionato l'esercizio contabile~rper l'azienda corrente.")
	ls_cod_esercizio = ""
END IF

idw_master.is_ricpar.s_filter_value = ls_cod_esercizio
idw_master.is_ricpar.s_filter_name = "esercizio_codice"

ls_dwcol[1] = "prof_registrazione_codice"
ls_dwcol[2] = "prof_registrazione_descrizione"
ls_dwcol[3] = "esercizio_id_esercizio"
ls_dwcol[4] = "registro_descrizione"
ls_dwcol[5] = "data_competenza"
ls_dwcol[6] = "num_progressivo"
ls_dwcol[7] = "data_registrazione"
ls_dwcol[8] = "num_documento"
ls_dwcol[9] = "data_documento"
ls_dwcol[10] = "descrizione"
ls_dwcol[11] = "conto_codice"
ls_dwcol[12] = "conto_descrizione"
ls_dwcol[13] = "reg_pd_imp_valuta"

ls_dbfield[1] = "prof_registrazione.codice"
ls_dbfield[2] = "prof_registrazione.descrizione"
ls_dbfield[3] = "esercizio.codice"
ls_dbfield[4] = "registro.descrizione"
ls_dbfield[5] = "reg_pd.data_competenza"
ls_dbfield[6] = "reg_pd.num_progressivo"
ls_dbfield[7] = "reg_pd.data_registrazione"
ls_dbfield[8] = "reg_pd.num_documento"
ls_dbfield[9] = "reg_pd.data_documento"
ls_dbfield[10] = "reg_pd.descrizione"
ls_dbfield[11] = "conto.codice"
ls_dbfield[12] = "conto.descrizione"
ls_dbfield[13] = "reg_pd.imp_valuta"

ls_SQL_cond = f_get_SQL_cond(dw_reg_pd_pn_ff, dw_reg_pd_pn_ff.GetRow(), ls_dwcol, ls_dbfield)
IF ls_SQL_cond <> "" THEN
	idw_master.is_ricpar.s_SQL_cond = uf_tipo_registrazione(ls_parametro) + " AND " + ls_SQL_cond
	
ELSE
	idw_master.is_ricpar.s_SQL_cond = uf_tipo_registrazione(ls_parametro)
	
END IF
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_reg_pd_sw") 
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ib_inserimento = FALSE
	ll_id_reg_pd = long(idw_master.is_ricpar.s_id_seg_value[1])
	ls_st_stampa_bollato = idw_master.is_ricpar.s_ausil_value[1] 
	IF ls_st_stampa_bollato = "S" OR ls_st_stampa_bollato = "I" THEN
		MessageBox("Registrazioni Contabili", "Registrazione bloccata perchè stampata o in corso di stampa.", Exclamation!)
		dw_reg_pd_pn_ff.enabled                                                  = FALSE
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.enabled                  = FALSE
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.enabled      = FALSE
		tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.enabled = FALSE
		ib_bloccata = TRUE
	ELSE
		dw_reg_pd_pn_ff.enabled                                                  = TRUE
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.enabled                  = TRUE
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.enabled      = TRUE
		tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.enabled = TRUE
		ib_bloccata = FALSE
	END IF
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_reg_pd"
	idw_master.is_list.l_identifica[1] = ll_id_reg_pd
	ib_attiva_wizard = FALSE
	idw_master.Event ue_retrieve(0, 0)
	SetNull(is_filtro_conto)
END IF
idw_master.SetFocus()
end subroutine

public function string uf_tipo_registrazione (string as_tipo_registro);

string ls_RetVal


CHOOSE CASE as_tipo_registro
	CASE "PN"
		ls_RetVal = "tipo_registro = 'PN'"
	CASE "MN"
		ls_RetVal = "tipo_registro = 'MN'"
	CASE "PM"
		ls_RetVal = "tipo_registro = 'PN' OR tipo_registro = 'MN'"
	CASE "IA"
		ls_RetVal = "tipo_registro = 'IA'"
	CASE "IV"
		ls_RetVal = "tipo_registro = 'IV'"
	CASE "IC"
      ls_RetVal = "tipo_registro = 'IC'"
	CASE "AV"
		ls_RetVal = "tipo_registro = 'IA' OR tipo_registro = 'IV'"
	
	
	CASE ELSE
		ls_RetVal = ""
END CHOOSE


RETURN ls_RetVal
end function

public subroutine uf_proponi_default ();

long ll_CurrRow, ll_Cur_IDRegistro, ll_ID_Prof_Reg
long ll_id_esercizio, ll_IDRegistro, ll_Min_Num_Registro, ll_IDCliFor
string ls_tipo_registro, ls_descrizione_registro, ls_cod_esercizio
string ls_conto_codice, ls_conto_descrizione, ls_Ultimo_Num_Doc,ls_prog_scritture
date ld_Ultima_Data_Doc, ld_Data_Reg_PD, ld_data_in, ld_data_fn
decimal ldc_cambio
Integer LI_AZIENDA_FITTIZIA
LI_AZIENDA_FITTIZIA = 1

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()

ll_ID_Prof_Reg = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
ll_id_esercizio = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "esercizio_id_esercizio")
long ll_val_esercizio
select id_valuta into :ll_val_esercizio from esercizio where id_esercizio=:ll_id_esercizio;

ll_IDRegistro = f_proponi_registro(ll_ID_Prof_Reg, ll_id_esercizio)
IF ll_IDRegistro > 0 THEN

	  SELECT "registro"."descrizione",
				"registro"."tipo_registro",
				"registro"."numero",
				"esercizio"."codice",
				"esercizio"."prog_scritture",
			   "esercizio"."data_inizio",
				"esercizio"."data_fine"
		 INTO :ls_descrizione_registro,
				:ls_tipo_registro,
				:ll_min_num_registro,
				:ls_cod_esercizio,
				:ls_prog_scritture,
				:ld_data_in, 
				:ld_data_fn
		 FROM "esercizio",
				"registro"
		WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and
				( ( "registro"."id_registro" = :ll_IDRegistro ) )   ;


	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "id_registro", ll_IDRegistro)
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "registro_descrizione", ls_descrizione_registro)

	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "esercizio_codice", ls_cod_esercizio)
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "registro_numero", ll_min_num_registro)

	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "cinfo_registro", "Tipo: " + ls_tipo_registro + " - Numero: " + string(ll_Min_Num_Registro))
	ll_Cur_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")

	IF (ls_tipo_registro = "IA") OR (ls_tipo_registro = "IV") OR (ls_tipo_registro = "IC") THEN
		uf_abilita_controlli_iva(TRUE)
	ELSE
		uf_abilita_controlli_iva(FALSE)
	END IF
	
	is_tipo_registro = ls_tipo_registro
ELSE
	
	IF NOT isnull(ll_ID_Prof_Reg) THEN		
		MessageBox("Registrazioni Contabili", "Attenzione: il registro impostato nel profilo~rnon esiste per l'esercizio selezionato.")
	END IF
	RETURN
	
END IF


if ls_prog_scritture='N' then
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "num_progressivo", f_proponi_num_reg_pd(ll_Cur_IDRegistro,ls_prog_scritture))
else
end if

if ls_prog_scritture='N' then
	
	ld_Data_Reg_PD = today()
	if is_prop_data<>'S' or (ld_data_reg_pd>ld_data_fn or ld_data_reg_pd<ld_data_in) then
	
		ld_Data_Reg_PD = f_proponi_data_reg_pd(ll_Cur_IDRegistro,ls_prog_scritture)
	end if	
end if
dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "data_registrazione", ld_Data_Reg_PD)
dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "data_competenza", ld_Data_Reg_PD)

ll_IDCliFor = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_conto")
ll_ID_Prof_Reg = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
ll_Valuta_Reg_PD = f_proponi_valuta(ll_IDCliFor, ll_id_esercizio)

dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "id_valuta_cod", ll_Valuta_Reg_PD)
IF ll_Valuta_Reg_PD <> il_lire THEN 
	ib_proteggi_cambio = FALSE
	dw_reg_pd_pn_ff.object.cambio.Protect = 0
	
	dw_reg_pd_pn_ff.SetFormat('importo', '#,0.00')
	dw_reg_pd_pn_ff.SetFormat('reg_pd_imp_valuta', '#,0.00')
	
ELSE
	ib_proteggi_cambio = TRUE
	dw_reg_pd_pn_ff.object.cambio.Protect = 1
	
	dw_reg_pd_pn_ff.SetFormat('importo', '#,0')
	dw_reg_pd_pn_ff.SetFormat('reg_pd_imp_valuta', '#,0')
END IF

ll_Valuta_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_valuta_cod")
if ll_val_esercizio=il_lire then
	ldc_cambio = f_proponi_cambio(ll_Valuta_Reg_PD)
else 
	ldc_cambio = f_prop_cambio_euro(ll_Valuta_Reg_PD)
end if
dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "cambio", ldc_cambio)

is_chiocciola=f_proponi_descr_reg_pd(ll_ID_Prof_Reg)
dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "descrizione", is_chiocciola)

IF (is_tipo_registro = "IA") OR (is_tipo_registro = "IV") OR (is_tipo_registro = "IC") THEN
	
	IF ls_tipo_registro = "IV" THEN
		if ls_prog_scritture='N' then
			ls_Ultimo_Num_Doc = f_proponi_num_documento(ll_Cur_IDRegistro,ls_prog_scritture)
		else
		end if
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "num_documento", ls_Ultimo_Num_Doc)
	END IF
	
	
	IF ls_tipo_registro = "IV" THEN
		if ls_prog_scritture='N' then
			ld_Ultima_Data_Doc = f_proponi_data_documento(ll_Cur_IDRegistro,ls_prog_scritture)
		else
		end if
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "data_documento", ld_Ultima_Data_Doc)
	END IF
	
	
	ll_ID_Prof_Reg = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
	ll_IDCliFor = f_proponi_conto(ll_ID_Prof_Reg, ls_conto_codice, ls_conto_descrizione)
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "id_conto", ll_IDCliFor)
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "conto_codice", ls_conto_codice)
	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "conto_descrizione", ls_conto_descrizione)
END IF

dw_reg_pd_pn_ff.SetColumn("data_registrazione")
end subroutine

public function integer uf_nuovo ();

long ll_CurrRow
integer li_MsgRetVal, li_RetVal = 1
ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
SetNull(is_filtro_conto)

IF ib_Inserimento = TRUE THEN
	long dif,ll_ret
	II_TEST=0
   if tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()>0 then 
	dif=uf_controlla_sbilanciate()
   if dif <> 0 then
    ll_ret=messagebox ("Information!","ATTENZIONE, ~nLA SCRITTURA E' SBILANCIATA!~nCREARE UNA NUOVA REGISTRAZIONE SENZA SALVARE?",Information!,YESNO!) 
    if ll_ret=1 then
		ii_test=1
    else 
      return li_RetVal
    end if	
  end if
end if	
	
	if not isnull(dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")) then
	IF II_TEST=0 THEN 
		li_MsgRetVal = MessageBox("Registrazioni Contabili", "Ci sono modifiche non salvate nella finestra.~rVuoi salvarle?", Question!, YesNoCancel!, 1)
   ELSE
		li_MsgRetVal=2
	END IF	
	CHOOSE CASE li_MsgRetVal
		CASE 1
			IF NOT uf_controlla_movimenti() THEN
				MessageBox("Impossibile Proseguire", "La registrazione non è completa.",Information!, Ok!)
				dw_reg_pd_pn_ff.SetFocus()
			ELSE
				
				
				
				
				
				ib_Inserimento = FALSE
				
				IF ll_CurrRow > 0 THEN
					il_id_ultimo_profilo = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
					is_cod_ultimo_profilo = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "prof_registrazione_codice")
					is_des_ultimo_profilo = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "prof_registrazione_descrizione")
					
					is_des_tipo_fatt = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow,"reg_pd_tipo_fattura")
					id_segno_iva=dw_reg_pd_pn_ff.GetItemdecimal(ll_CurrRow,"reg_pd_segno_reg_iva")
				END IF
				
				
				
				li_RetVal = 0
			END IF
		CASE 2
			idw_master.is_list.s_modo = modo_inserisci
			uf_DisplayOnly(dw_reg_pd_pn_ff, "prof_registrazione_codice", FALSE)
			uf_DisplayOnly(dw_reg_pd_pn_ff, "prof_registrazione_descrizione", FALSE)
			dw_reg_pd_pn_ff.Modify("esercizio_id_esercizio.Background.Mode=0")
			uf_DisplayOnly(dw_reg_pd_pn_ff, "registro_descrizione", FALSE)
			uf_DisplayOnly(dw_reg_pd_pn_ff, "num_progressivo", FALSE)
			dw_reg_pd_pn_ff.SetColumn("prof_registrazione_codice")

			uf_Elimina_Incompleta()
			dw_reg_pd_pn_ff.Reset()
			TriggerEvent("ue_insert_mode")

			uf_setup_window()
			dw_reg_pd_pn_ff.SetFocus()
			ib_Inserimento = TRUE
			ib_attiva_wizard = TRUE 
	END CHOOSE
end if

ELSE
	IF dw_reg_pd_pn_ff.ModifiedCount() > 0 OR &
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.ModifiedCount() > 0 OR &
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.ModifiedCount() > 0 THEN

		li_MsgRetVal = MessageBox("Registrazioni Contabili", "Ci sono modifiche non salvate nella finestra.~rVuoi salvarle?", Question!, YesNoCancel!, 1)
		
		CHOOSE CASE li_MsgRetVal
			CASE 1
				IF idw_master.Event ue_update(0,0) = 0 THEN
				
					idw_master.is_list.s_modo = modo_inserisci
					uf_DisplayOnly(dw_reg_pd_pn_ff, "prof_registrazione_codice", FALSE)
					uf_DisplayOnly(dw_reg_pd_pn_ff, "prof_registrazione_descrizione", FALSE)
					dw_reg_pd_pn_ff.Modify("esercizio_id_esercizio.Background.Mode=0")
					uf_DisplayOnly(dw_reg_pd_pn_ff, "registro_descrizione", FALSE)
					uf_DisplayOnly(dw_reg_pd_pn_ff, "num_progressivo", FALSE)
					dw_reg_pd_pn_ff.SetColumn("prof_registrazione_codice")
				
					IF ll_CurrRow > 0 THEN
						il_id_ultimo_profilo = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
						is_cod_ultimo_profilo = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "prof_registrazione_codice")
						is_des_ultimo_profilo = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "prof_registrazione_descrizione")
						
						is_des_tipo_fatt = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow,"reg_pd_tipo_fattura")
						id_segno_iva=dw_reg_pd_pn_ff.GetItemdecimal(ll_CurrRow,"reg_pd_segno_reg_iva")
					END IF
					
					dw_reg_pd_pn_ff.Reset()
					TriggerEvent("ue_insert_mode")
				
					uf_setup_window()
					dw_reg_pd_pn_ff.SetFocus()
					ib_Inserimento = TRUE
					ib_attiva_wizard = FALSE
				END IF
			CASE 2
				idw_master.is_list.s_modo = modo_inserisci
				uf_DisplayOnly(dw_reg_pd_pn_ff, "prof_registrazione_codice", FALSE)
				uf_DisplayOnly(dw_reg_pd_pn_ff, "prof_registrazione_descrizione", FALSE)
				dw_reg_pd_pn_ff.Modify("esercizio_id_esercizio.Background.Mode=0")
				uf_DisplayOnly(dw_reg_pd_pn_ff, "registro_descrizione", FALSE)
				uf_DisplayOnly(dw_reg_pd_pn_ff, "num_progressivo", FALSE)
				dw_reg_pd_pn_ff.SetColumn("prof_registrazione_codice")
			
				IF ll_CurrRow > 0 THEN
					il_id_ultimo_profilo = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
					is_cod_ultimo_profilo = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "prof_registrazione_codice")
					is_des_ultimo_profilo = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "prof_registrazione_descrizione")
						
					is_des_tipo_fatt = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow,"reg_pd_tipo_fattura")
					id_segno_iva=dw_reg_pd_pn_ff.GetItemdecimal(ll_CurrRow,"reg_pd_segno_reg_iva")
				END IF
				
				dw_reg_pd_pn_ff.Reset()
				TriggerEvent("ue_insert_mode")
			
				uf_setup_window()
				dw_reg_pd_pn_ff.SetFocus()
				ib_Inserimento = TRUE
				ib_attiva_wizard = FALSE
			CASE 3
		END CHOOSE
	ELSE
		idw_master.is_list.s_modo = modo_inserisci
		uf_DisplayOnly(dw_reg_pd_pn_ff, "prof_registrazione_codice", FALSE)
		uf_DisplayOnly(dw_reg_pd_pn_ff, "prof_registrazione_descrizione", FALSE)
		dw_reg_pd_pn_ff.Modify("esercizio_id_esercizio.Background.Mode=0")
		uf_DisplayOnly(dw_reg_pd_pn_ff, "registro_descrizione", FALSE)
		uf_DisplayOnly(dw_reg_pd_pn_ff, "num_progressivo", FALSE)
		dw_reg_pd_pn_ff.SetColumn("prof_registrazione_codice")
	
		IF ll_CurrRow > 0 THEN
			il_id_ultimo_profilo = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
			is_cod_ultimo_profilo = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "prof_registrazione_codice")
			is_des_ultimo_profilo = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "prof_registrazione_descrizione")
				
			is_des_tipo_fatt = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow,"reg_pd_tipo_fattura")
			id_segno_iva=dw_reg_pd_pn_ff.GetItemdecimal(ll_CurrRow,"reg_pd_segno_reg_iva")
		END IF
		
		dw_reg_pd_pn_ff.Reset()
		TriggerEvent("ue_insert_mode")
	
		uf_setup_window()
		dw_reg_pd_pn_ff.SetFocus()
		ib_Inserimento = TRUE
		ib_attiva_wizard = FALSE
	END IF

END IF

RETURN li_RetVal
end function

public subroutine uf_controlla_esistente ();

long ll_id_reg_pd, ll_CurrRow, ll_num_progressivo, ll_id_registro
integer li_RetVal
string ls_prog_scritture

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()

IF ll_CurrRow > 0 THEN
	dw_reg_pd_pn_ff.AcceptText()
	ll_num_progressivo = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "num_progressivo")
	ll_id_registro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")

	SELECT reg_pd.id_reg_pd  
		INTO :ll_id_reg_pd  
		FROM dba.reg_pd
		WHERE ( reg_pd.id_registro        = :ll_id_registro )     AND  
				( reg_pd.num_progressivo    = :ll_num_progressivo ) ;

	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			li_RetVal = MessageBox("Registrazioni Contabili", "Registrazione numero " + string(ll_num_progressivo) + " esistente.~rVisualizzare la registrazione?", Question!, YesNo!)
			CHOOSE CASE li_RetVal
				CASE 1
					ib_inserimento = FALSE
					idw_master.is_list.s_modo = modo_modifica
					idw_master.is_list.s_identifica[1] = "id_reg_pd"
					idw_master.is_list.l_identifica[1] = ll_id_reg_pd
					idw_master.Event ue_retrieve(0, 0)
					idw_master.SetFocus()
				CASE 2
					
					SELECT "esercizio"."prog_scritture"
					 INTO :ls_prog_scritture
					 FROM "esercizio",
							"registro"
					WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and
							( ( "registro"."id_registro" = :ll_ID_Registro ) )   ;
								
					ll_num_progressivo = f_proponi_num_reg_pd(ll_id_registro,ls_prog_scritture)
					dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "num_progressivo", ll_num_progressivo)
			END CHOOSE 
		CASE -1
			MessageBox("Errore sul DataBase", "w_reg_pd_cx / uf_controlla_esistente / 1")
	END CHOOSE 

END IF
end subroutine

public subroutine uf_setup_id ();

long ll_CurrRow, ll_IDReg_PD, ll_num_progressivo, ll_IDRegistro
date ld_data_registrazione
char lc_tipo_fattura
dwItemStatus ldwis_status

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()

ll_IDRegistro         = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")
ll_num_progressivo    = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "num_progressivo")
ld_data_registrazione = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow, "data_registrazione")
ldwis_status          = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow, "id_reg_pd", Primary!)

SELECT "dba"."reg_pd"."id_reg_pd"
	INTO :ll_IDReg_PD
	FROM "dba"."reg_pd"
	WHERE ( "dba"."reg_pd"."id_registro" = :ll_IDRegistro ) AND
			( "dba"."reg_pd"."num_progressivo" = :ll_num_progressivo ) AND
			( "dba"."reg_pd"."data_registrazione" = :ld_data_registrazione ) AND
			( "dba"."reg_pd"."id_azienda" in (0, 1) )   ;

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "id_reg_pd", ll_IDReg_PD)
		dw_reg_pd_pn_ff.SetItemStatus(ll_CurrRow, "id_reg_pd", Primary!, ldwis_status)
	CASE -1
		MessageBox("Errore sul DataBase", "dw_reg_pd_pn_ff / updateend / 1")
END CHOOSE
end subroutine

public function boolean uf_attiva_insoluti (long al_id_prof_registrazione);

long ll_CurrRow, ll_i, lal_id_conto[], ll_id_conto
date ld_data_registrazione
string ls_filtro_conto
boolean lb_RetVal = FALSE
char lc_insoluti

SELECT prof_registrazione.usa_insoluti
	INTO :lc_insoluti
	FROM dba.prof_registrazione
	WHERE prof_registrazione.id_prof_registrazione = :al_id_prof_registrazione
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		IF lc_insoluti = "S" THEN
			lb_RetVal = TRUE
			ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
			ld_data_registrazione = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow, "data_registrazione")


			is_insoluti.l_identifica[1] = al_id_prof_registrazione
			is_insoluti.s_identifica[1] = string(ld_data_registrazione, "dd/mm/yyyy")
			
			FOR ll_i = 1 TO 3
				SELECT prof_mov_contabile.id_conto,
				       prof_mov_contabile.filtro_conto
					INTO :ll_id_conto,
					     :ls_filtro_conto
					FROM dba.prof_mov_contabile
					WHERE (prof_mov_contabile.id_prof_registrazione = :al_id_prof_registrazione) AND
					      (prof_mov_contabile.num_riga = :ll_i)
					USING SQLCA;
					
				IF SQLCA.SQLCode = 0 THEN 
					is_insoluti.l_identifica[ll_i + 1] = ll_id_conto
					is_insoluti.s_identifica[ll_i + 1] = ls_filtro_conto
				ELSE
					SetNull(is_insoluti.l_identifica[ll_i + 1])
					SetNull(is_insoluti.s_identifica[ll_i + 1])
				END IF
				
			NEXT
			OpenWithParm(w_insoluti_cx, is_insoluti)
			FOR ll_i = 0 TO long(dw_reg_pd_pn_ff.Describe("DataWindow.Column.Count"))
				dw_reg_pd_pn_ff.SetItemStatus(ll_CurrRow, ll_i, Primary!, NotModified!)
			NEXT
			ib_inserimento = FALSE
			uf_nuovo()
		END IF
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / uf_attiva_insoluti / 1")
END CHOOSE

RETURN lb_RetVal
end function

public subroutine uf_crea_mov_contabili ();

long ll_id_reg_pd, ll_CurrRow_Reg_PD, ll_ID_Prof_Registrazione, ll_id_prof_registrazione4f, ll_num_riga4f, ll_id_conto4f, ll_importo4f, ll_Nuovo_Movimento, ll_Valuta_Reg_PD, ll_Cambio_Reg_PD , ll_IDRegistro, ll_SQLCA_SQLCode, ll_num_recs
string ls_filtro_conto4f, ls_des_contabile4f, ls_segno4f, ls_tipo_registro, ls_conto_codice, ls_conto_descrizione, ls_des_contab_testa
date ld_Data_Reg_PD
integer li_RetVal
long ll_id_con,ll_id_sog,ll_id_conto
string ls_cod,ls_des

CONSTANT Integer li_ID_Azienda = 1

ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
ll_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_registro")
SELECT "registro"."tipo_registro"
	INTO :ls_tipo_registro
	FROM "registro"
	WHERE "registro"."id_registro" = :ll_IDRegistro;


IF ib_crea_movimenti = TRUE OR (ls_tipo_registro <> "IA" AND ls_tipo_registro <> "IV") THEN

	

	ll_ID_Prof_Registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_prof_registrazione")

	
	
	ll_id_reg_pd = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_reg_pd")
	

	
	SELECT count( * )
		INTO :ll_num_recs
		FROM "dba"."prof_mov_contabile"
	  WHERE "dba"."prof_mov_contabile"."id_prof_registrazione" = :ll_ID_Prof_Registrazione;

	IF SQLCA.SQLCode < 0 THEN
		MessageBox("Errore sul Database", "dw_reg_pd_pn_ff / ue_crea_mov_contabili / 1")
		RETURN
	END IF

	
	
	DECLARE lc_prof_mov_contabile CURSOR FOR
	  SELECT "prof_mov_contabile"."id_prof_registrazione",
				"prof_mov_contabile"."num_riga",
				"prof_mov_contabile"."id_conto",
				"prof_mov_contabile"."filtro_conto",
				"prof_mov_contabile"."des_contabile",
				"prof_mov_contabile"."importo",
				"prof_mov_contabile"."segno"
		 FROM "prof_mov_contabile"
		WHERE "prof_mov_contabile"."id_prof_registrazione" = :ll_ID_Prof_Registrazione;

	
	OPEN lc_prof_mov_contabile;

	
	FETCH lc_prof_mov_contabile INTO :ll_id_prof_registrazione4f, :ll_num_riga4f, :ll_id_conto4f, :ls_filtro_conto4f, :ls_des_contabile4f, :ll_importo4f, :ls_segno4f; 


	ll_SQLCA_SQLCode = SQLCA.SQLCode

	
	DO WHILE ll_SQLCA_SQLCode = 0 AND ll_num_recs > 0
		
		
		
		
		
		
		IF NOT ((ls_tipo_registro = "IA" OR ls_tipo_registro = "IV" OR  ls_tipo_registro = "IC") AND ll_num_riga4f = 1) THEN
			
			IF NOT IsNull(ls_filtro_conto4f) THEN is_filtro_conto = ls_filtro_conto4f
			ll_Nuovo_Movimento = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.InsertRow(0)
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.is_list.l_identifica[1] = ll_ID_Reg_PD
			ib_nuovo_movimento = TRUE

			
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "numero", ll_num_riga4f)

			
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_conto", ll_id_conto4f)

			SELECT "dba"."conto"."codice", "dba"."conto"."descrizione"
				INTO :ls_conto_codice, :ls_conto_descrizione
				FROM "dba"."conto"
				WHERE "dba"."conto"."id_conto" = :ll_id_conto4f;

			CHOOSE CASE SQLCA.SQLCode
				CASE -1
					MessageBox("Errore sul Database", "dw_reg_pd_pn_ff / ue_crea_mov_contabili / 2")
					RETURN
				CASE 0
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_codice", ls_conto_codice)
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_descrizione", ls_conto_descrizione)
				CASE 100
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_codice", ls_filtro_conto4f)
					
					if (is_par_menu='IA') or (is_par_menu='IV') then
						tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_descrizione", ls_des)
						tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_conto", ll_id_con)
					end if
					
			END CHOOSE


			
			ll_Valuta_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_valuta_cod")
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_valuta", ll_Valuta_Reg_PD)

			
			ll_Cambio_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "cambio")
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "cambio", ll_cambio_Reg_PD)

			
			
			if isnull(ls_des_contabile4f) then
				ls_des_contab_testa = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "descrizione")
			else	
				ls_des_contab_testa=uf_des_mov_contabile(ls_des_contabile4f, ll_Nuovo_Movimento)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "chiocciola", ls_des_contabile4f)
			end if	
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_des_contabile", ls_des_contab_testa)
			


			
			
			ld_Data_Reg_PD = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow_Reg_PD, "data_competenza")
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_val_banca", ld_Data_Reg_PD)
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_inizio_competenza", ld_Data_Reg_PD)
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_fine_competenza", ld_Data_Reg_PD)

			
			IF ls_segno4f = "D" THEN
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "dare", ll_importo4f)
			ELSEIF ls_segno4f = "A" THEN
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "avere", ll_importo4f)
			END IF

			
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_reg_pd", ll_id_reg_pd)

			
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_rateo_risconto", "N")

			
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_azienda", li_ID_Azienda)
		ELSE
			
			ll_Nuovo_Movimento=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getrow()
			if isnull(ls_des_contabile4f) then
				ls_des_contab_testa = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "descrizione")
			else	
				ls_des_contab_testa=uf_des_mov_contabile(ls_des_contabile4f, ll_Nuovo_Movimento)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "chiocciola", ls_des_contabile4f)
			end if	
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_des_contabile", ls_des_contab_testa)
			
		END IF

		FETCH lc_prof_mov_contabile INTO :ll_id_prof_registrazione4f, :ll_num_riga4f, :ll_id_conto4f, :ls_filtro_conto4f, :ls_des_contabile4f, :ll_importo4f, :ls_segno4f; 
		ll_SQLCA_SQLCode = SQLCA.SQLCode
		
	
		if (is_par_menu='IA') or (is_par_menu='IV') then
			ls_cod=dw_reg_pd_pn_ff.getitemstring(1,"conto_codice")
			select id_sog_commerciale
			into :ll_id_sog
			from sog_commerciale
			where codice=:ls_cod;
			
			select id_conto
			into :ll_id_conto
			from con_movimento
			where id_sog_commerciale=:ll_id_sog;
		
			select codice,descrizione,id_conto
			into :ls_cod,:ls_des,:ll_id_con
			from conto
			where id_conto=:ll_id_conto;
			if sqlca.sqlcode=0 then 
				ls_filtro_conto4f=ls_cod
			else
				is_fil=ls_filtro_conto4f
			end if
		end if	
	

	LOOP

	CLOSE lc_prof_mov_contabile;

	
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetColumn("conto_codice")
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetFocus()

	
END IF

ib_crea_movimenti = FALSE

ib_Attiva_Wizard = TRUE
end subroutine

public subroutine uf_crea_mov_contabili_iva1 ();


long ll_CurrRow_Reg_PD, ll_Nuovo_Movimento, ll_IDConto, ll_id_reg_pd, ll_IDRegistro
long ll_Cambio_Reg_PD, ll_ID_Prof_Registrazione, ll_num_righe
decimal {2} ld_importo
string ls_tipo_registro, ls_conto_codice, ls_conto_descrizione, ls_des_contabile
date ld_Data_Reg_PD
char lc_segno, lc_tipo_fattura
datawindow ldw_mov_contabile_gd
dwItemStatus l_status

ldw_mov_contabile_gd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd
ll_num_righe = ldw_mov_contabile_gd.RowCount()

IF ll_num_righe = 0 THEN
	ib_crea_movimenti = TRUE
ELSE
	ib_crea_movimenti = FALSE
END IF
IF ib_crea_movimenti = TRUE THEN
	ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

	
	ll_id_reg_pd = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_reg_pd")

	
	ll_ID_Prof_Registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_prof_registrazione")

	
	lc_tipo_fattura = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_tipo_fattura")

	
	ld_importo = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "importo")

	
	ll_IDConto = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_conto")

	
	ll_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_registro")

	
	SELECT "registro"."tipo_registro"
		INTO :ls_tipo_registro
		FROM "registro"
		WHERE "registro"."id_registro" = :ll_IDRegistro;

	ll_Nuovo_Movimento = ldw_mov_contabile_gd.InsertRow(0)
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.is_list.l_identifica[1] = ll_ID_Reg_PD

	
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_reg_pd", ll_id_reg_pd)

	
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "numero", 1)

	
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_conto", ll_IDConto)

	SELECT "dba"."conto"."codice", "dba"."conto"."descrizione"
		INTO :ls_conto_codice, :ls_conto_descrizione
		FROM "dba"."conto"
		WHERE "dba"."conto"."id_conto" = :ll_IDConto;

	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			MessageBox("Errore sul Database", "ue_crea_mov_contabili_iva1")
			RETURN
		CASE 0
			ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_codice", ls_conto_codice)
			ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_descrizione", ls_conto_descrizione)
	END CHOOSE

	
	
	
	lc_segno = uf_calcola_segno(ls_tipo_registro, lc_tipo_fattura, ll_id_prof_registrazione, "S")

	CHOOSE CASE lc_segno
		CASE "D"
			ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "dare", ld_importo)
		CASE "A"
			ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "avere", ld_importo)
	END CHOOSE


	
	
	ll_Valuta_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_valuta_cod")
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_valuta", ll_Valuta_Reg_PD)

	
	
	ll_Cambio_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "cambio")
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "cambio", ll_cambio_Reg_PD)

	
	
	
	ld_Data_Reg_PD = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow_Reg_PD, "data_competenza")
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_val_banca", ld_Data_Reg_PD)
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_inizio_competenza", ld_Data_Reg_PD)
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_fine_competenza", ld_Data_Reg_PD)
	
	
	ls_des_contabile = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "descrizione")
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_des_contabile", ls_des_contabile)

	
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_rateo_risconto", "N")


	
	
	uf_crea_mov_contabili_IVA1a()

END IF
end subroutine

public subroutine uf_crea_mov_contabili_iva1a ();


long ll_ID_Prof_Registrazione, ll_CurrRow_Reg_PD, ll_num_recs, ll_nuovo_movimento, ll_id_reg_pd, ll_valuta_reg_pd, ll_cambio_reg_pd
string ls_des_contabile
datawindow ldw_mov_contabile_gd
date ld_data_reg_pd

ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

ll_id_reg_pd = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_reg_pd")

ldw_mov_contabile_gd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd

ll_ID_Prof_Registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_prof_registrazione")

SELECT count( * )
	INTO :ll_num_recs
	FROM "dba"."prof_mov_contabile"
  WHERE "dba"."prof_mov_contabile"."id_prof_registrazione" = :ll_ID_Prof_Registrazione;

IF SQLCA.SQLCode < 0 THEN
	MessageBox("Errore sul Database", "ue_crea_mov_contabili_iva1a")
	RETURN
END IF

IF ll_num_recs = 0 THEN

	ll_Nuovo_Movimento = ldw_mov_contabile_gd.InsertRow(0)
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.is_list.l_identifica[1] = ll_ID_Reg_PD
	

	
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_reg_pd", ll_id_reg_pd)

	
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "numero", 2)

	
	ll_Valuta_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_valuta_cod")
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_valuta", ll_Valuta_Reg_PD)

	
	ll_Cambio_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "cambio")
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "cambio", ll_cambio_Reg_PD)

	
	
	ld_Data_Reg_PD = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow_Reg_PD, "data_competenza")
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_val_banca", ld_Data_Reg_PD)
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_inizio_competenza", ld_Data_Reg_PD)
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_fine_competenza", ld_Data_Reg_PD)

	
	ls_des_contabile = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "descrizione")
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_des_contabile", ls_des_contabile)

	
	ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_rateo_risconto", "N")

	
	
END IF

end subroutine

public subroutine uf_crea_mov_contabili_iva2 ();

long ll_CurrRow_Reg_PD, ll_id_reg_pd, ll_conta, ll_conta_det
long ll_num_righe, ll_conto_iva_nd
long iva_det
char lc_tipo_fattura
decimal{2}ld_per_detrazione
datawindow ldw_mov_contabile_gd, ldw_mov_iva_gd
dwItemStatus l_status


ll_conta = 0
ll_conta_det = 0

ldw_mov_contabile_gd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd
ldw_mov_iva_gd = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd

ll_num_righe = ldw_mov_contabile_gd.RowCount()

IF ib_crea_movimenti = TRUE THEN

	ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

	
	ll_id_reg_pd = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_reg_pd")

	
	lc_tipo_fattura = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_tipo_fattura")



	
	
	
	
	SELECT "par_sistema"."id_conto_iva_nd"
				INTO :ll_conto_iva_nd
				FROM "par_sistema"
				WHERE "par_sistema"."id_azienda" = 1;
				
		
		IF isnull(ll_conto_iva_nd)  then
			
			 UF_CREA_RIGHE_IVA_DET()  
		ELSE
	
	
	
		
	DECLARE IVA_ND CURSOR FOR
	
			SELECT  "tab_iva"."per_detrazione"
			FROM "mov_iva", "tab_iva"
			WHERE ( "tab_iva"."id_tab_iva" = "mov_iva"."id_tab_iva" ) AND "mov_iva"."id_reg_pd" = :ll_id_reg_pd;
	
	OPEN  IVA_ND;
	FETCH IVA_ND INTO :iva_det;
	DO WHILE SQLCA.SQLCODE = 0;

	if iva_det <> 100 then   
		ll_conta ++
		if iva_det <> 0 then  
			ll_conta_det ++
		end if
	else
		ll_conta_det ++
	end if
	
   FETCH IVA_ND INTO :iva_det;
	LOOP
	close IVA_ND;

	if ll_conta > 0  then	
		if ll_conta_det > 0 then
			
			UF_CREA_RIGHE_IVA_DET1()
		end if	
			long ll_nrighe,i,ll_id_tab_iva
			string ls_tipo_iva
			boolean lb_non_det
			
			lb_non_det=false
						
			ll_nrighe=tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.rowcount()
			for i=1 to ll_nrighe
				ll_id_tab_iva=tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.getitemnumber(i,"id_tab_iva_cod")
				setnull(ld_per_detrazione)
				select per_detrazione 
				into :ld_per_detrazione
				from tab_iva
				where id_tab_iva=:ll_id_tab_iva;
				if ld_per_detrazione>100 or ld_per_detrazione<100 then 
					lb_non_det=true
				end if
			next
			if lb_non_det=true then
				UF_CREA_RIGHE_nd1()
			end if
				
		else
			UF_CREA_RIGHE_IVA_DET1()
		 
		end if
	END IF
END IF
end subroutine

public subroutine uf_attiva_wizard ();
long ll_IDReg_PD, ll_CurrRow

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
IF ll_CurrRow > 0 THEN
	ll_IDReg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_reg_pd")
	iuo_wizard.uf_start(ll_IDReg_PD)
	ib_Attiva_Wizard = FALSE
END IF




long ll_id_prof_reg, ll_id_wizard
string ls_wiz_codice
ll_id_prof_reg= dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
  
  SELECT "wiz_profilo"."id_wizard"  
    INTO :ll_id_wizard  
    FROM "wiz_profilo"  
   WHERE "wiz_profilo"."id_prof_registrazione" = :ll_id_prof_reg   ;
  
  SELECT "wizard"."codice"  
    INTO :ls_wiz_codice  
    FROM "wizard"  
   WHERE "wizard"."id_wizard" = :ll_id_wizard   ;


IF ls_wiz_codice="CESPITI" THEN
	
	long ll_id_cespite, i, ll_riga
	string ls_tipo_registro
	date ld_data_reg
	decimal ld_importo
	long ll_newrow
				
	
	ls_tipo_registro= trim(idw_master.is_list.s_win_parametri)
	ld_data_reg=dw_reg_pd_pn_ff.GetItemdate(ll_CurrRow, "data_registrazione")
	ll_riga=tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.rowcount()
	
	CHOOSE CASE ls_tipo_registro
		CASE 'IA'  
			ll_id_cespite=Message.DoubleParm 
			ls_tipo_registro='A'
			ld_data_reg=dw_reg_pd_pn_ff.GetItemdate(ll_CurrRow, "data_registrazione")
	      ll_riga=tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.rowcount()
			for i=1 to ll_riga
				 ld_importo=ld_importo+tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.getitemdecimal(i,"mov_iva_imponibile")
			next
			 
			 INSERT INTO "storico_cespite"  
						( "id_st_cesp",   
						  "id_cespite",   
						  "id_reg_pd",   
						  "ult_amm",   
						  "ult_tipo",   
						  "perc_amm_fisc",   
						  "perc_amm_civ",   
						  "imp_amm_fisc",   
						  "imp_amm_civ",   
						  "importo",   
						  "data_mov",   
						  "tipo_mov",   
						  "descrizione" )  
			  VALUES ( null,   
						  :ll_id_cespite,   
						  :ll_idreg_pd,   
						  null,   
						  null,   
						  null,   
						  null,   
						  null,   
						  null,   
						  :ld_importo,   
						  :ld_data_reg,   
						  :ls_tipo_registro,   
						  null )  ;
		      commit;
		
		
		UPDATE "cespite"  
         SET "valore_acq" = :ld_importo,   
             "data_inizio_utilizzo" = :ld_data_reg, 
				 "data_inizio_amm" = :ld_data_reg,
				 "residuo_da_amm"=:ld_importo
       WHERE "cespite"."id_cespite" = :ll_id_cespite;
		 commit;
       
		 
		   uf_calcola_data_fine_amm(ll_id_cespite)
		 
		 
		CASE 'IV' 
			ls_tipo_registro='V'
			string ls_param, ls_cespite, ls_importo
			string ls_codice, ls_descrizione
			integer li_pos
			decimal ld_imp_residuo
			long ll_id_cat_int_cespite, ll_id_conto_minus, ll_id_conto_plus, ll_differenza
			
			decimal ll_importo
			long  ll_id_conto
			
			ls_param=Message.StringParm 
			
			
			li_pos=pos(ls_param,' ')
			ls_cespite=trim( left(ls_param,li_pos) )
			i=len(ls_param)
			ls_importo=trim( Mid ( ls_param, li_pos, i) )
			ll_id_cespite=integer(ls_cespite)
			ld_imp_residuo=dec(ls_importo)
			
			
			
			ll_riga=tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.rowcount()
			for i=1 to ll_riga
				 ld_importo=ld_importo+tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.getitemdecimal(i,"mov_iva_imponibile")
			next
			
				INSERT INTO "storico_cespite"  
						( "id_st_cesp",   
						  "id_cespite",   
						  "id_reg_pd",   
						  "ult_amm",   
						  "ult_tipo",   
						  "perc_amm_fisc",   
						  "perc_amm_civ",   
						  "imp_amm_fisc",   
						  "imp_amm_civ",   
						  "importo",   
						  "data_mov",   
						  "tipo_mov",   
						  "descrizione" )  
			  VALUES ( null,   
						  :ll_id_cespite,   
						  :ll_idreg_pd,   
						  null,   
						  null,   
						  null,   
						  null,   
						  null,   
						  null,   
						  :ld_importo,   
						  :ld_data_reg,   
						  :ls_tipo_registro,   
						  null )  ;
				commit;		  
			
			
		   
		   UPDATE "cespite"  
            SET "alien_valore" = :ld_importo,   
                "alien_data" = :ld_data_reg  
          WHERE "cespite"."id_cespite" = :ll_id_cespite;
			 commit;
				
		      STRING Flag
		      DATE DATA_INI, DATA_FIN
				LONG LL_ID_VALUTA, LL_CAMBIO, LL_ID_AZIENDA,ll1_idreg_pd
				LL_ID_VALUTA=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(1,"id_valuta")
				LL_CAMBIO=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(1,"cambio")
				LL_ID_AZIENDA=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(1,"ID_AZIENDA")
				DATA_INI=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemdate(1,"data_inizio_competenza")
				DATA_FIN=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemdate(1,"data_fine_competenza")

			
			if ld_imp_residuo>ld_importo then
				Flag="L"
				ll_differenza=ld_imp_residuo - ld_importo
				
				
				SELECT "cespite"."id_cat_int_cespite"  
				INTO :ll_id_cat_int_cespite  
				FROM "cespite"  
				WHERE "cespite"."id_cespite" = :ll_id_cespite;
				
				if sqlca.sqlcode=0 then
					
					
					  SELECT "cat_int_cespite"."id_conto_minusvalenza"  
					  INTO :ll_id_conto_minus  
					  FROM "cat_int_cespite"  
					  WHERE "cat_int_cespite"."id_cat_int_cespite" = :ll_id_cat_int_cespite;
				end if
				
				
				SELECT "conto"."codice","conto"."descrizione" 
				INTO :ls_codice, :ls_descrizione 
				FROM "conto"  
				WHERE "conto"."id_conto" = :ll_id_conto_minus;
				
				
				ll_newrow = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.InsertRow(0) 
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.ScrollToRow(ll_newrow)
				ll_newrow=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getrow()
	
				
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"id_reg_pd",ll_idreg_pd)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"id_conto",ll_id_conto_minus)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"conto_codice",ls_codice)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"conto_descrizione",ls_descrizione)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"dare",ll_differenza)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"NUMERO",3)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"ID_VALUTA", LL_ID_VALUTA)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"cambio",LL_CAMBIO)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"ID_AZIENDA",LL_ID_AZIENDA)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"data_inizio_competenza",DATA_INI)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"data_fine_competenza",DATA_FIN)
				
				
				ll_newrow = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.InsertRow(0) 
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.ScrollToRow(ll_newrow)
				ll_newrow=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getrow()
	
				
				
				
				
				ll_riga=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()
	
				for i=1 to ll_riga
					 ll_importo=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(i,"avere")
					 if ll_importo=ld_importo then
						 ll_id_conto=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(i,"id_conto")
					 end if
				next
				
				
				SELECT "conto"."codice","conto"."descrizione" 
				INTO :ls_codice, :ls_descrizione 
				FROM "conto"  
				WHERE "conto"."id_conto" = :ll_id_conto;
				
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"id_reg_pd",ll_idreg_pd)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"id_conto",ll_id_conto)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"conto_codice",ls_codice)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"conto_descrizione",ls_descrizione)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"avere",ll_differenza)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"NUMERO",4)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"ID_VALUTA", LL_ID_VALUTA)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"cambio",LL_CAMBIO)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"ID_AZIENDA",LL_ID_AZIENDA)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"data_inizio_competenza",DATA_INI)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"data_fine_competenza",DATA_FIN)
		
			end if 
			
						
			
         if ld_imp_residuo<ld_importo then
				Flag="P"
				ll_differenza=ld_importo - ld_imp_residuo
				
				
				SELECT "cespite"."id_cat_int_cespite"  
				INTO :ll_id_cat_int_cespite  
				FROM "cespite"  
				WHERE "cespite"."id_cespite" = :ll_id_cespite;
				
				if sqlca.sqlcode=0 then
					
					
					 SELECT "cat_int_cespite"."id_conto_plusvalenza"  
					 INTO :ll_id_conto_plus 
					 FROM "cat_int_cespite"  
					 WHERE "cat_int_cespite"."id_cat_int_cespite" = :ll_id_cat_int_cespite;
				end if
				
				
				
				SELECT "conto"."codice","conto"."descrizione" 
				INTO :ls_codice, :ls_descrizione 
				FROM "conto"  
				WHERE "conto"."id_conto" = :ll_id_conto_plus;
				
				
				
				ll_newrow = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.InsertRow(0) 
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.ScrollToRow(ll_newrow)
				ll_newrow=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getrow()
	
				
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"id_reg_pd",ll_idreg_pd)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"id_conto",ll_id_conto_plus)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"conto_codice",ls_codice)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"conto_descrizione",ls_descrizione)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"avere",ll_differenza)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"NUMERO",3)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"ID_VALUTA", LL_ID_VALUTA)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"cambio",LL_CAMBIO)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"ID_AZIENDA",LL_ID_AZIENDA)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"data_inizio_competenza",DATA_INI)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"data_fine_competenza",DATA_FIN)

				
				ll_newrow = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.InsertRow(0) 
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.ScrollToRow(ll_newrow)
				ll_newrow=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getrow()
	
				
				
				
				
				ll_riga=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()
				
				for i=1 to ll_riga
					 ll_importo=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(i,"avere")
					 if ll_importo=ld_importo then
						 ll_id_conto=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(i,"id_conto")
					 end if
				next
				
				
				SELECT "conto"."codice","conto"."descrizione" 
				INTO :ls_codice, :ls_descrizione 
				FROM "conto"  
				WHERE "conto"."id_conto" = :ll_id_conto;
				
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"id_reg_pd",ll_idreg_pd)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"id_conto",ll_id_conto)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"conto_codice",ls_codice)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"conto_descrizione",ls_descrizione)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"dare",ll_differenza)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"NUMERO",4)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"ID_VALUTA", LL_ID_VALUTA)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"cambio",LL_CAMBIO)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"ID_AZIENDA",LL_ID_AZIENDA)
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"data_inizio_competenza",DATA_INI)
	         tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem (ll_newrow,"data_fine_competenza",DATA_FIN)

         end if 
			
	END CHOOSE

	
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItemStatus(1, 0,Primary!, NotModified!)
   tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItemStatus(2, 0,Primary!, NotModified!)
   tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItemStatus(3, 0,Primary!, NotModified!)

tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.update()	
	
   
	if ld_importo<>ld_imp_residuo and (flag='P' or flag='L') then
			INSERT INTO "storico_cespite"  
							( "id_st_cesp",   
							  "id_cespite",   
							  "id_reg_pd",   
							  "ult_amm",   
							  "ult_tipo",   
							  "perc_amm_fisc",   
							  "perc_amm_civ",   
							  "imp_amm_fisc",   
							  "imp_amm_civ",   
							  "importo",   
							  "data_mov",   
							  "tipo_mov",   
							  "descrizione" )  
				  VALUES ( null,   
							  :ll_id_cespite,   
							  :ll_idreg_pd,   
							  null,   
							  null,   
							  null,   
							  null,   
							  null,   
							  null,   
							  :ll_differenza,   
							  :ld_data_reg,   
							  :flag,   
							  null )  ;
					commit;		  
      end if  
		if flag='P' then
		   
		   
		   UPDATE "cespite"  
            SET "plus" = :ll_differenza  
          WHERE "cespite"."id_cespite" = :ll_id_cespite;
			 commit;
		    elseif flag='L' then
                 UPDATE "cespite"  
                    SET "minus" = :ll_differenza  
                  WHERE "cespite"."id_cespite" = :ll_id_cespite;
					   commit;	
		end if
END IF
end subroutine

public function decimal uf_imposta (decimal adc_imponibile, long al_id_tab_iva);decimal {2} ldc_RetVal, ldc_per_aliquota
SetNull(ldc_RetVal)

SELECT "tab_iva"."per_aliquota"
	INTO :ldc_per_aliquota
	FROM "tab_iva"
	WHERE "tab_iva"."id_tab_iva" = :al_id_tab_iva
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		
		if il_lire=ll_valuta_reg_pd then   
			ldc_RetVal = Ceiling((adc_imponibile/100)*ldc_per_aliquota)
		else	
			ldc_RetVal = (adc_imponibile/100)*ldc_per_aliquota
		end if
		
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / uf_imposta / 1")
END CHOOSE

RETURN ldc_RetVal
end function

public subroutine uf_ricalcolo ();

long ll_CurrRow, ll_id_tab_iva
decimal ldc_imponibile

ll_CurrRow = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetRow()

IF ll_CurrRow > 0 THEN
	tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.AcceptText()
	ldc_imponibile = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.uf_GetItemDecimal(ll_CurrRow, "mov_iva_imponibile")
	ll_id_tab_iva = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetItemNumber(ll_CurrRow, "id_tab_iva_cod")
	IF ldc_imponibile > 0 THEN
		IF ll_id_tab_iva > 0 THEN
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetItem(ll_CurrRow, "mov_iva_imposta", uf_imposta(ldc_imponibile, ll_id_tab_iva))
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetColumn("mov_iva_imposta")
		ELSE
			MessageBox("Registrazioni Contabili", "Per ricalcolare l'imposta selezionare prima l'aliquota IVA.")
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetColumn("id_tab_iva_cod")
		END IF
	ELSE
		MessageBox("Registrazioni Contabili", "Per ricalcolare l'imposta immettere prima l'imponibile.")
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetColumn("mov_iva_imponibile")
	END IF
	tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetFocus()
END IF
end subroutine

public subroutine uf_scorporo ();

long ll_CurrRow, ll_id_tab_iva, ll_riga
decimal ldc_totale,  ldc_per_aliquota
decimal {2} ldc_imponibile , ldc_imposta

ll_CurrRow = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetRow()
ll_riga= dw_reg_pd_pn_ff.GetRow()

IF ll_CurrRow > 0 THEN
	tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.AcceptText()
	ldc_totale = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.uf_GetItemDecimal(ll_CurrRow, "mov_iva_imponibile")
	ll_id_tab_iva = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetItemNumber(ll_CurrRow, "id_tab_iva_cod")
	IF ldc_totale > 0 THEN
		IF ll_id_tab_iva > 0 THEN
			
			SELECT "tab_iva"."per_aliquota"
				INTO :ldc_per_aliquota
				FROM "tab_iva"
				WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva
				USING SQLCA;
				
			CHOOSE CASE SQLCA.SQLCode
				CASE 0
					ldc_imponibile = (ldc_totale * 100) / (100 + ldc_per_aliquota)
					
					if il_lire=ll_valuta_reg_pd then   
						ldc_imposta = ceiling(ldc_totale - ldc_imponibile)
					else	
						ldc_imposta = (ldc_totale - ldc_imponibile)
					end if	
					
					tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetItem(ll_CurrRow, "mov_iva_imponibile", ldc_imponibile)
					tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetItem(ll_CurrRow, "mov_iva_imposta", ldc_imposta)
					tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetColumn("mov_iva_imposta")
			END CHOOSE
		ELSE
			MessageBox("Registrazioni Contabili", "Selezionare l'aliquota IVA in base alla quale eseguire lo scorporo.")
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetColumn("id_tab_iva_cod")
		END IF
	ELSE
		MessageBox("Registrazioni Contabili", "Immettere l'importo da scorporare.")
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetColumn("mov_iva_imponibile")
	END IF
	tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetFocus()
END IF
end subroutine

public subroutine uf_abilita_controlli_iva (boolean ab_parametro);

long ll_CurrRow, ll_IDReg_PD_Padre
boolean lb_flag
ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
ll_IDReg_PD_Padre = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "reg_pd_id_reg_pd_padre")
IF IsNull(ll_IDReg_PD_Padre) THEN ll_IDReg_PD_Padre = 0

uf_DisplayOnly(dw_reg_pd_pn_ff, "conto_codice", NOT (ab_Parametro))
uf_DisplayOnly(dw_reg_pd_pn_ff, "conto_descrizione", NOT (ab_Parametro))

uf_DisplayOnly(dw_reg_pd_pn_ff, "num_documento", NOT (ab_Parametro))
uf_DisplayOnly(dw_reg_pd_pn_ff, "data_documento", NOT (ab_Parametro))

IF ab_Parametro = TRUE THEN
	dw_reg_pd_pn_ff.Modify("reg_pd_tipo_fattura.Background.Mode = 0")
	dw_reg_pd_pn_ff.Modify("Importo.Background.Mode = 0")
ELSE
	dw_reg_pd_pn_ff.Modify("reg_pd_tipo_fattura.Background.Mode = 1")
	dw_reg_pd_pn_ff.Modify("Importo.Background.Mode = 1")
END IF

uf_DisplayOnly(dw_reg_pd_pn_ff, "reg_pd_imp_valuta", NOT (ab_Parametro))
IF NOT (ab_Parametro) = FALSE THEN
	dw_reg_pd_pn_ff.Modify("reg_pd_imp_valuta.TabSequence = 180")
END IF

tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.enabled = ab_Parametro
tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.visible= ab_Parametro

tab_mov_contabile.tabpage_mov_iva.enabled = ab_Parametro
tab_mov_contabile.tabpage_mov_iva.visible = ab_Parametro

IF NOT (ll_IDReg_PD_Padre > 0) THEN
	lb_flag = ab_Parametro AND NOT (ll_IDReg_PD_Padre > 0)
	IF ib_bloccata = FALSE THEN
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.enabled = lb_flag
	ELSE
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.enabled = FALSE
	END IF
	tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.visible=  lb_flag
ELSE
	lb_flag = ab_Parametro AND NOT (ll_IDReg_PD_Padre > 0)
	IF ib_bloccata = FALSE THEN
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.enabled = lb_flag
	ELSE
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.enabled = FALSE
	END IF
	
END IF

IF ab_Parametro = FALSE THEN
	tab_mov_contabile.SelectedTab = 2
ELSE
	tab_mov_contabile.SelectedTab = 1
END IF

tab_mov_contabile.tabpage_mov_contabile.cb_partite.enabled = FALSE
end subroutine

public subroutine uf_accedi_protetti (string as_campo);

long ll_CurrRow, ll_id_registro
string ls_tipo_registro
dwItemStatus ldwis_status

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
ldwis_status = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow, 0,Primary!)
ll_id_registro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")

CHOOSE CASE as_campo
	CASE "data_comp_liq_iva"
		dw_reg_pd_pn_ff.Object.data_comp_liq_iva.Protect = 0
		dw_reg_pd_pn_ff.SetColumn("data_comp_liq_iva")
	CASE "data_competenza"
		dw_reg_pd_pn_ff.Object.data_competenza.Protect = 0
		dw_reg_pd_pn_ff.SetColumn("data_competenza")
	CASE "importo"
		dw_reg_pd_pn_ff.Object.importo.Protect = 0
		dw_reg_pd_pn_ff.SetColumn("importo")
	CASE "esercizio_id_esercizio"
		IF ldwis_status = New! OR ldwis_status = NewModified! THEN
			dw_reg_pd_pn_ff.Object.esercizio_id_esercizio.Protect = 0
			dw_reg_pd_pn_ff.SetColumn("esercizio_id_esercizio")
		END IF
	CASE "reg_pd_tipo_fattura"
		ls_tipo_registro = uf_seleziona_tipo_registro(ll_id_registro)
		IF ls_tipo_registro = "IA" OR ls_tipo_registro = "IV"  then 
			dw_reg_pd_pn_ff.Object.reg_pd_tipo_fattura.Protect = 0
			dw_reg_pd_pn_ff.SetColumn("reg_pd_tipo_fattura")
		END IF
	CASE "id_valuta_cod"
		dw_reg_pd_pn_ff.object.id_valuta_cod.Protect = 0
		dw_reg_pd_pn_ff.SetColumn("id_valuta_cod")
	CASE "id_valuta_des"
		dw_reg_pd_pn_ff.object.id_valuta_des.Protect = 0
		dw_reg_pd_pn_ff.SetColumn("id_valuta_des")
	CASE "cambio"
		dw_reg_pd_pn_ff.object.cambio.Protect = 0
		dw_reg_pd_pn_ff.SetColumn("cambio")
END CHOOSE

end subroutine

public subroutine uf_attiva_partite ();long ll_CurrRow, ll_IDConto, ll_CurrCol, ll_id_mov_contabile
string las_array[], ls_CurrCol, ls_segno
char lc_ges_par_aperte
decimal {2} ldc_importo
boolean lb_RetVal
integer li_RetVal_Msg
dwItemStatus l_status

ll_CurrRow = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetRow()

IF ll_CurrRow > 0 THEN
	l_status = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemStatus(ll_CurrRow, 0, Primary!)
	ll_IDConto = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "id_conto")

	SELECT "conto"."ges_par_aperte"
		INTO :lc_ges_par_aperte
		FROM "conto"
	  	WHERE "conto"."id_conto" = :ll_IDConto;

	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			IF lc_ges_par_aperte = "N" THEN
				MessageBox("Libro Giornale", "Il conto non gestisce partite aperte.")
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetFocus()
				RETURN
			END IF
	END CHOOSE

	IF ll_IDConto > 0 THEN
		las_array[1] = "dw_mov_contabile_gd"
		las_array[2] = string(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "id_reg_pd"))
		las_array[3] = string(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "numero"))
		las_array[4] = string(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "id_mov_contabile"))
		las_array[5] = string(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_CurrRow, "dare"))
		las_array[6] = string(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_CurrRow, "avere"))
		las_array[7] = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetColumnName()
		las_array[8] = string(dw_reg_pd_pn_ff.GetItemDate(dw_reg_pd_pn_ff.GetRow(), "data_registrazione"), "dd/mm/yyyy")
		las_array[9] = string(ll_IDConto)
		las_array[10] = string(il_esercizio)   
		lb_RetVal = u_freddie.sp_push(las_array)

      
		long ll_reg_now
		ll_reg_now=dw_reg_pd_pn_ff.getitemnumber(1,'id_reg_pd')
		Openwithparm(w_par_aperta_partite_gd, ll_reg_now) 
		lb_RetVal = u_freddie.sp_pop(las_array)
		
		
		IF (dec(las_array[2]) > 0) THEN
			
		   tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(ll_CurrRow,'associa_partita','S')
			il_pro_partita=1
			ls_CurrCol = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetColumnName()
			CHOOSE CASE ls_CurrCol
				CASE "dare"
					ls_segno = "dare"
				CASE "avere"
					ls_segno = "avere"
			END CHOOSE

			ldc_importo = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_CurrRow, ls_CurrCol)
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_CurrRow, "cid_reg_app", dec(las_array[3]))
			IF IsNull(ldc_importo) THEN
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_CurrRow, ls_CurrCol, dec(las_array[2]))
			ELSE
				li_RetVal_Msg = MessageBox("Movimentazione Partite", "Sostituire l'importo in " + ls_segno + " di " + string(ldc_importo, "#,0") + "~rcon il Totale Movimenti di " + string(dec(las_array[2]),"#,0") + "?", Question!, YesNo!)
				CHOOSE CASE li_RetVal_Msg
					CASE 1
						is_test_par=2
						tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_CurrRow, ls_CurrCol, dec(las_array[2]))
					CASE 2
						is_test_par=1
				END CHOOSE

			END IF
		ELSE
		   is_test_par=1
		END IF	

	END IF
END IF

tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetFocus()
end subroutine

public function boolean uf_controlla_esistente_iva ();

long ll_id_reg_pd, ll_id_registro, ll_id_conto, ll_id_reg_pd_esistente, ll_id_registro_Esistente
long ll_num_prog_reg_esistente, ll_CurrRow, ll_SQL_Reg_Esistente
boolean lb_RetVal = FALSE
integer li_UChoice
string ls_num_documento
date ld_data_documento, ld_data_reg_esistente
dwItemStatus ldwis_status

dw_reg_pd_pn_ff.AcceptText()
ll_CurrRow         = dw_reg_pd_pn_ff.GetRow()
ll_id_registro     = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")
ll_id_conto        = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_conto")
ls_num_documento   = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "num_documento")
ld_data_documento  = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow, "data_documento")

IF (ll_id_registro > 0) AND (ll_id_conto > 0) AND (ls_num_documento > "") AND (ld_data_documento > date("01/01/1900")) THEN
	DECLARE lcur_reg_pd_esistenti CURSOR FOR
		SELECT "reg_pd"."id_reg_pd",
				 "reg_pd"."id_registro",
				 "reg_pd"."num_progressivo",
				 "reg_pd"."data_registrazione"
			FROM "reg_pd"
			WHERE "reg_pd"."id_registro"    = :ll_id_registro AND
					"reg_pd"."id_conto"       = :ll_id_conto AND
					"reg_pd"."num_documento"  = :ls_num_documento AND
					"reg_pd"."data_documento" = :ld_data_documento;
	
	OPEN lcur_reg_pd_esistenti ;
	
	FETCH lcur_reg_pd_esistenti INTO :ll_id_reg_pd_esistente,
												:ll_id_registro_Esistente,
												:ll_num_prog_reg_esistente,
												:ld_data_reg_esistente;
	ll_SQL_Reg_Esistente = SQLCA.SQLCode
	
	CLOSE lcur_reg_pd_esistenti ;
	
	CHOOSE CASE ll_SQL_Reg_Esistente
		CASE 0
			ldwis_status = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow, 0, Primary!)
			
			CHOOSE CASE ldwis_status 
				CASE NewModified!
					
					
					
					li_UChoice = MessageBox("Validazione di Registrazioni Contabili", uf_notifica_reg_esistente(ll_id_conto, ls_num_documento, ld_data_documento, ll_num_prog_reg_esistente, ld_data_reg_esistente, ll_id_registro_Esistente), Exclamation!)
	
					
				CASE DataModified!
					IF ll_id_reg_pd_esistente <> ll_id_reg_pd THEN
						
						
						
						
						li_UChoice = MessageBox("Validazione di Registrazioni Contabili", uf_notifica_reg_esistente(ll_id_conto, ls_num_documento, ld_data_documento, ll_num_prog_reg_esistente, ld_data_reg_esistente, ll_id_registro_Esistente), Exclamation!)
	
						
	
				END IF
	
			END CHOOSE
		CASE -1
			
			
	END CHOOSE

END IF

RETURN lb_RetVal
end function

public function character uf_calcola_segno (string as_tipo_registro, character ac_tipo_fattura, long al_id_prof_registrazione, character ac_tipo_riga);

char lc_RetVal, lc_segno

SELECT prof_mov_contabile.segno
	INTO :lc_segno
	FROM dba.prof_mov_contabile
	WHERE (prof_mov_contabile.id_prof_registrazione = :al_id_prof_registrazione) AND
			(prof_mov_contabile.num_riga = 1)
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE 0
		CHOOSE CASE ac_tipo_riga
			CASE "S"
				lc_RetVal = lc_segno
			CASE "I"
				
				CHOOSE CASE lc_segno
					CASE "D"
						lc_RetVal = "A"
					CASE "A"
						lc_RetVal = "D"
				END CHOOSE

		END CHOOSE
		
	CASE 100
		
		CHOOSE CASE as_tipo_registro
			CASE "IA"
				
				CHOOSE CASE ac_tipo_fattura
					CASE "N", "D"
						
						CHOOSE CASE ac_tipo_riga
							CASE "S"
								lc_RetVal = "A"
							CASE "I"
								lc_RetVal = "D"
						END CHOOSE

					CASE "C"
						CHOOSE CASE ac_tipo_riga
							CASE "S"
								lc_RetVal = "D"
							CASE "I"
								lc_RetVal = "A"
						END CHOOSE
						
				END CHOOSE

				
			CASE "IV"
				CHOOSE CASE ac_tipo_fattura
					CASE "N", "D"
						
						CHOOSE CASE ac_tipo_riga
							CASE "S"
								lc_RetVal = "D"
							CASE "I"
								lc_RetVal = "A"
						END CHOOSE

					CASE "C"
						CHOOSE CASE ac_tipo_riga
							CASE "S"
								lc_RetVal = "A"
							CASE "I"
								lc_RetVal = "D"
						END CHOOSE
						
				END CHOOSE
		END CHOOSE
		
END CHOOSE

RETURN lc_RetVal
end function

public subroutine uf_aggiorna_saldo_partita ();
long ll_id_par_aperta
decimal ld_importo, ld_totale_importo, ld_par_aperta_importo

ll_id_par_aperta=tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.getitemnumber(1,"cid_par_aperta")
	
   DECLARE mov_partita_cur CURSOR FOR  
    SELECT "mov_partita"."importo"  
      FROM "mov_partita"  
     WHERE "mov_partita"."id_par_aperta" = :ll_id_par_aperta;  
	  
	open mov_partita_cur;
	
	fetch mov_partita_cur into :ld_importo;
	
	
	do while sqlca.sqlcode=0
  		
		ld_totale_importo=ld_totale_importo+ld_importo
		fetch mov_partita_cur into :ld_importo;	
	loop
		
	close mov_partita_cur;
	
	
	ld_par_aperta_importo=tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.getitemnumber(1,"par_aperta_importo")

   
	
   ld_importo=ld_par_aperta_importo - ld_totale_importo

   
	tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.setitem(1,"csaldo_partita",ld_importo)
   
end subroutine

public subroutine uf_chiudi_scadenze (integer li_id_par_aperte, long ll_id_mov_partita);
long li_id_par_aperte_scad, li_id_scadenza
decimal ld_imp_scadenza
date    ld_data_scadenza
string  ls_note;

long ll_reg_now
ll_reg_now=dw_reg_pd_pn_ff.getitemnumber(1,'id_reg_pd')

DECLARE scadenze_cur CURSOR FOR  
 SELECT "gest_chiudi_scadenze"."id_par_aperte",   
 		  "gest_chiudi_scadenze"."imp_scadenza",   
        "gest_chiudi_scadenze"."id_scadenza",   
        "gest_chiudi_scadenze"."data_scadenza", 
		  "gest_chiudi_scadenze"."note"
   FROM "gest_chiudi_scadenze"
  WHERE "gest_chiudi_scadenze"."id_reg_now"=:ll_reg_now; 

OPEN scadenze_cur;

FETCH scadenze_cur INTO :li_id_par_aperte_scad,:ld_imp_scadenza, :li_id_scadenza, &
		   						   :ld_data_scadenza, :ls_note;
										
DO WHILE SQLCA.SQLCODE=0
      IF SQLCA.SQLCODE=0 THEN 
			   
				
				
				IF li_id_par_aperte_scad=li_id_par_aperte AND (NOT ISNULL(ld_imp_scadenza) &
				   											           OR ld_imp_scadenza<>0) THEN
			      
					
					
					
					long ll_val_scad
               select id_valuta into :ll_val_scad
					from scadenza where id_scadenza=:li_id_scadenza;
					select fn_conv_valuta(:ll_valuta_reg_pd,:ld_imp_scadenza,:ll_val_scad) into :ld_imp_scadenza from sys.dummy;
					ld_imp_scadenza=f_round_2(ll_val_scad,ld_imp_scadenza)
					
					
					INSERT INTO "mov_scadenza"  
								 ( "id_mov_scadenza",   
									"id_scadenza",   
									"id_mov_partita",   
									"data",   
									"importo",   
									"imp_valuta",   
									"note",   
									"id_azienda" )  
						VALUES ( null,   
									:li_id_scadenza,   
									:ll_id_mov_partita,   
									:ld_data_scadenza,   
									:ld_imp_scadenza,   
									:ld_imp_scadenza,   
									:ls_note,   
									1 )  ;
				END IF

		END IF
			
		FETCH scadenze_cur INTO :li_id_par_aperte_scad,:ld_imp_scadenza, :li_id_scadenza, &
		   						   :ld_data_scadenza, :ls_note;
LOOP
CLOSE scadenze_cur;
COMMIT;
end subroutine

public subroutine uf_calcola_data_fine_amm (long ll_id_cespite);

decimal ld_valore_acq, ld_amm_normale, ld_anni, ld_mesi
date ld_data_inizio_amm, ld_data_fine_amm
string ls_data_fine_amm, ls_mesi
integer li_pos

	SELECT "cespite"."valore_acq",   
			 "cespite"."amm_normale",   
			 "cespite"."data_inizio_amm"  
	  INTO :ld_valore_acq,   
			 :ld_amm_normale,   
			 :ld_data_inizio_amm  
	  FROM "cespite"  
	 WHERE "cespite"."id_cespite" = :ll_id_cespite   ;

  ld_anni=ld_valore_acq*ld_amm_normale/100
  if ld_anni<>0 then ld_anni=ld_valore_acq/ld_anni

  ls_data_fine_amm=string(integer(day(ld_data_inizio_amm)))+"/"+ &
	  				    string(integer(month(ld_data_inizio_amm)))+"/"+ &
						 string(integer(year(ld_data_inizio_amm)) + ld_anni)
					  
	li_pos=pos(ls_data_fine_amm,',') 
	ls_data_fine_amm=left(ls_data_fine_amm,li_pos - 1)
					  

	ld_data_fine_amm=date(ls_data_fine_amm)
	

	ls_mesi=string(ld_anni) 
	li_pos=pos(ls_mesi,',') 
	ls_mesi=mid(ls_mesi,li_pos+1,1) 
	
	ld_mesi=dec(ls_mesi) 
	
	
  IF ld_mesi>=5 THEN
	  ls_data_fine_amm=string(integer(day(ld_data_fine_amm)))+"/"+ &
		     			    string(integer(month(ld_data_fine_amm)))+"/"+ &
					       string(integer(year(ld_data_fine_amm)) + 1)
  END IF
	
  ld_data_fine_amm=date(ls_data_fine_amm)
  

	UPDATE "cespite"  
		SET "data_fine_amm" = :ld_data_fine_amm  
	 WHERE "cespite"."id_cespite" = :ll_id_cespite   ;
	 commit;



end subroutine

public subroutine uf_cancella_risconti_storni (long ll_id_reg_pd);

string ls_quota_rat_ris, ls_storno, ls_segno, ls_ris_sto
long ll_rif_conto, ll_rif_scr_storno, ll_rif_scr_rat_ris, ll_id_mov_contabile
long ll_mov_reg_pd,var_comodo, ll_num
integer li_numero
decimal ld_dare, ld_avere, ld_tot_dare, ld_tot_avere, LD_IMP_RISC;

SELECT quota_rat_ris, storno, segno, rif_conto, rif_scr_storno, rif_scr_rat_ris, FLAG_RAT_RIS
INTO :ls_quota_rat_ris, :ls_storno, :ls_segno, :ll_rif_conto, 
                        :ll_rif_scr_storno, :ll_rif_scr_rat_ris, :LD_IMP_RISC
  FROM ges_ratei_risconti
 WHERE rif_scrittura=:ll_id_reg_pd;
 
IF sqlca.sqlcode=0 THEN 
	
	IF ls_quota_rat_ris='S' THEN 
		
		SELECT id_mov_contabile
		  INTO :ll_id_mov_contabile
		FROM mov_contabile
	  WHERE id_reg_pd=:ll_rif_scr_rat_ris AND 
				id_conto=:ll_rif_conto AND 
				(dare=:LD_IMP_RISC OR avere=:LD_IMP_RISC);
	  
	  DELETE FROM mov_contabile
	  WHERE id_mov_contabile=:ll_id_mov_contabile;
	  commit;
	END IF
	
	IF ls_storno='S' THEN 
		
		SELECT id_mov_contabile
		  INTO :ll_id_mov_contabile
		FROM mov_contabile
	  WHERE id_reg_pd=:ll_rif_scr_storno AND 
				id_conto=:ll_rif_conto AND 
				(dare=:LD_IMP_RISC OR avere=:LD_IMP_RISC);
	  
	  DELETE FROM mov_contabile
	  WHERE id_mov_contabile=:ll_id_mov_contabile;
	  commit;
	END IF

END IF

IF ls_quota_rat_ris='S' THEN  
   ls_ris_sto="RISCONTO"
   uf_aggiorna_totale_righe(ll_rif_scr_rat_ris, ls_segno, ls_ris_sto)
END IF
IF ls_storno='S' THEN  
   ls_ris_sto="STORNO"
   uf_aggiorna_totale_righe(ll_rif_scr_storno, ls_segno, ls_ris_sto)
END IF


end subroutine

public subroutine uf_aggiorna_totale_righe (long ll_id_reg_pd, string ls_segno, string ls_ris_sto);

string ls_quota_rat_ris, ls_storno
long ll_rif_conto, ll_rif_scr_storno, ll_rif_scr_rat_ris, ll_id_mov_contabile
long var_comodo, ll_num, ll_mov_reg_pd
decimal ld_dare, ld_avere, ld_tot_dare, ld_tot_avere, LD_IMP_RISC;

CHOOSE CASE LS_RIS_STO
CASE "RISCONTO"
	   choose case ls_segno
			case "D"
				
				
				DECLARE mov_contabile_d_cur CURSOR FOR
				SELECT  id_mov_contabile, dare, avere
				  FROM mov_contabile
				 WHERE id_reg_pd=:ll_id_reg_pd;
				 										 
				 
				OPEN mov_contabile_d_cur;
				
				FETCH mov_contabile_d_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere; 
				
				DO WHILE SQLCA.SQLCODE=0
			     	IF SQLCA.SQLCODE=0 THEN 
						if ld_avere>0 then 
							
							ld_tot_avere=ld_tot_avere+ld_avere
							ll_num=ll_num+1
							UPDATE mov_contabile
								SET numero=:ll_num
							 WHERE id_mov_contabile=:ll_id_mov_contabile;
						end if
						if ld_dare>0 then 
							var_comodo=ll_id_mov_contabile 
						end if
					END IF
					FETCH mov_contabile_d_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere;
							
					LOOP
					CLOSE mov_contabile_d_cur; 
					commit;
							
					
					if ld_tot_avere>0 and ll_num>0 then
						
						ll_num=ll_num+1
						UPDATE mov_contabile
						SET numero=:ll_num, dare=:ld_tot_avere
						WHERE id_mov_contabile=:var_comodo;
						commit;
						  else
							
							select id_reg_pd
							into :ll_mov_reg_pd
							from mov_contabile
							where id_mov_contabile=:var_comodo;  
							
							delete from mov_contabile
							where id_mov_contabile=:var_comodo;
							commit;
							
							delete from reg_pd
							where id_reg_pd=:ll_mov_reg_pd;
							commit;
					end if
	      case "A"
				
				
				DECLARE mov_contabile_a_cur CURSOR FOR
				SELECT  id_mov_contabile, dare, avere
				  FROM mov_contabile
				 WHERE id_reg_pd=:ll_id_reg_pd;
				 										 
				 
				OPEN mov_contabile_a_cur;
				
				FETCH mov_contabile_a_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere; 
				
				DO WHILE SQLCA.SQLCODE=0
					IF SQLCA.SQLCODE=0 THEN 
						if ld_dare>0 then 
							
							ld_tot_dare=ld_tot_dare+ld_dare
							ll_num=ll_num+1
							UPDATE mov_contabile
								SET numero=:ll_num
							 WHERE id_mov_contabile=:ll_id_mov_contabile;
						end if
						if ld_avere>0 then 
							var_comodo=ll_id_mov_contabile 
						end if
					END IF
					FETCH mov_contabile_a_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere;
							
					LOOP
					CLOSE mov_contabile_a_cur; 
					commit;		
					
					if ld_tot_dare>0 and ll_num>0  then
						
						ll_num=ll_num+1
						UPDATE mov_contabile
						SET numero=:ll_num, avere=:ld_tot_dare
						WHERE id_mov_contabile=:var_comodo;
						commit;
						  else
							
							select id_reg_pd
							into :ll_mov_reg_pd
							from mov_contabile
							where id_mov_contabile=:var_comodo;  
							
							delete from mov_contabile
							where id_mov_contabile=:var_comodo;
							commit;
							
							delete from reg_pd
							where id_reg_pd=:ll_mov_reg_pd;
							commit;
					end if
			end choose
CASE "STORNO"	
		choose case ls_segno
			case "A"
				
				
				DECLARE mov_contabile_sd_cur CURSOR FOR
				SELECT  id_mov_contabile, dare, avere
				  FROM mov_contabile
				 WHERE id_reg_pd=:ll_id_reg_pd;
				 										 
				 
				OPEN mov_contabile_sd_cur;
				
				FETCH mov_contabile_sd_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere; 
				
				DO WHILE SQLCA.SQLCODE=0
			     	IF SQLCA.SQLCODE=0 THEN 
						if ld_avere>0 then 
							
							ld_tot_avere=ld_tot_avere+ld_avere
							ll_num=ll_num+1
							UPDATE mov_contabile
								SET numero=:ll_num
							 WHERE id_mov_contabile=:ll_id_mov_contabile;
						end if
						if ld_dare>0 then
							var_comodo=ll_id_mov_contabile 
						end if
					END IF
					FETCH mov_contabile_sd_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere;
							
					LOOP
					CLOSE mov_contabile_sd_cur; 
					commit;		
					
					if ld_tot_avere>0 and ll_num>0 then
						
						ll_num=ll_num+1
						UPDATE mov_contabile
						SET numero=:ll_num, dare=:ld_tot_avere
						WHERE id_mov_contabile=:var_comodo;
						commit;
						  else
							
							select id_reg_pd
							into :ll_mov_reg_pd
							from mov_contabile
							where id_mov_contabile=:var_comodo;  
							
							delete from mov_contabile
							where id_mov_contabile=:var_comodo;
							commit;
							
							delete from reg_pd
							where id_reg_pd=:ll_mov_reg_pd;
							commit;
					end if
	      case "D"
				
				
				DECLARE mov_contabile_sa_cur CURSOR FOR
				SELECT  id_mov_contabile, dare, avere
				  FROM mov_contabile
				 WHERE id_reg_pd=:ll_id_reg_pd;
				 										 
				 
				OPEN mov_contabile_sa_cur;
				
				FETCH mov_contabile_sa_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere; 
				
				DO WHILE SQLCA.SQLCODE=0
					IF SQLCA.SQLCODE=0 THEN 
					   if ld_dare>0 then 
							
							
							ld_tot_dare=ld_tot_dare+ld_dare
							ll_num=ll_num+1
							UPDATE mov_contabile
								SET numero=:ll_num
							 WHERE id_mov_contabile=:ll_id_mov_contabile;
						end if
						if ld_avere>0 then 
							var_comodo=ll_id_mov_contabile 
						end if
					END IF
					FETCH mov_contabile_sa_cur INTO :ll_id_mov_contabile,:ld_dare,:ld_avere;
							
					LOOP
					CLOSE mov_contabile_sa_cur; 
					commit;		
					
					if ld_tot_dare>0 and ll_num>0  then
						
						ll_num=ll_num+1
						UPDATE mov_contabile
						SET numero=:ll_num, avere=:ld_tot_dare
						WHERE id_mov_contabile=:var_comodo;
						commit;
						  else
							
							select id_reg_pd
							into :ll_mov_reg_pd
							from mov_contabile
							where id_mov_contabile=:var_comodo;  
							
						   delete from mov_contabile
							where id_mov_contabile=:var_comodo;
							commit;
							
							delete from reg_pd
							where id_reg_pd=:ll_mov_reg_pd;
							commit;
					end if
			end choose
END CHOOSE
	
end subroutine

public subroutine uf_ricerca_1 ();
w_search_main lw_sm

long ll_CurrRow, ll_id_reg_pd, ll_id_esercizio
string ls_cod_esercizio, ls_filtro, ls_Parametro, ls_SQL_cond, ls_dwcol[], ls_dbfield[]
string ls_st_stampa_bollato
string ls_SQL_cond2, ls_pippo
ls_Parametro = trim(idw_master.is_list.s_win_parametri)

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
ll_id_esercizio = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "esercizio_id_esercizio")


SELECT esercizio.codice
	INTO :ls_cod_esercizio
	FROM esercizio
	WHERE esercizio.id_esercizio = :ll_id_esercizio;

CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / uf_ricerca / 1")
		RETURN
END CHOOSE

IF IsNull(ls_cod_esercizio) THEN
	MessageBox("Registrazioni Contabili", "Attenzione: non è stato selezionato l'esercizio contabile~rper l'azienda corrente.")
	ls_cod_esercizio = ""
END IF

idw_master.is_ricpar.s_filter_value = ls_cod_esercizio
idw_master.is_ricpar.s_filter_name = "esercizio_codice"

ls_dwcol[1] = "prof_registrazione_codice"
ls_dwcol[2] = "prof_registrazione_descrizione"
ls_dwcol[3] = "esercizio_id_esercizio"
ls_dwcol[4] = "registro_descrizione"
ls_dwcol[5] = "data_competenza"
ls_dwcol[6] = "num_progressivo"
ls_dwcol[7] = "data_registrazione"
ls_dwcol[8] = "num_documento"
ls_dwcol[9] = "data_documento"
ls_dwcol[10] = "descrizione"
ls_dwcol[11] = "conto_codice"
ls_dwcol[12] = "conto_descrizione"
ls_dwcol[13] = "reg_pd_imp_valuta"

ls_dbfield[1] = "prof_registrazione.codice"
ls_dbfield[2] = "prof_registrazione.descrizione"
ls_dbfield[3] = "esercizio.codice"
ls_dbfield[4] = "registro.descrizione"
ls_dbfield[5] = "reg_pd.data_competenza"
ls_dbfield[6] = "reg_pd.num_progressivo"
ls_dbfield[7] = "reg_pd.data_registrazione"
ls_dbfield[8] = "reg_pd.num_documento"
ls_dbfield[9] = "reg_pd.data_documento"
ls_dbfield[10] = "reg_pd.descrizione"
ls_dbfield[11] = "conto.codice"
ls_dbfield[12] = "conto.descrizione"
ls_dbfield[13] = "reg_pd.imp_valuta"

ls_dwcol[7] = string(dw_reg_pd_pn_ff.GetItemdate(ll_CurrRow, "data_registrazione"))


ls_SQL_cond = f_get_SQL_cond(dw_reg_pd_pn_ff, dw_reg_pd_pn_ff.GetRow(), ls_dwcol, ls_dbfield)

IF ls_SQL_cond <> "" THEN
	idw_master.is_ricpar.s_SQL_cond = uf_tipo_registrazione(ls_parametro) + " AND " + ls_SQL_cond  
ELSE
   idw_master.is_ricpar.s_SQL_cond = uf_tipo_registrazione(ls_parametro) 
END IF
OpenWithParm(lw_sm, idw_master.is_ricpar, "w_reg_pd_sw") 
idw_master.is_ricpar = Message.PowerObjectParm

IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ib_inserimento = FALSE
	ll_id_reg_pd = long(idw_master.is_ricpar.s_id_seg_value[1])
	ls_st_stampa_bollato = idw_master.is_ricpar.s_ausil_value[1] 
	IF ls_st_stampa_bollato = "S" OR ls_st_stampa_bollato = "I" THEN
		MessageBox("Registrazioni Contabili", "Registrazione bloccata perchè stampata o in corso di stampa.", Exclamation!)
		dw_reg_pd_pn_ff.enabled                                                  = FALSE
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.enabled                  = FALSE
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.enabled      = FALSE
		tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.enabled = FALSE
		ib_bloccata = TRUE
	ELSE
		dw_reg_pd_pn_ff.enabled                                                  = TRUE
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.enabled                  = TRUE
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.enabled      = TRUE
		tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.enabled = TRUE
		ib_bloccata = FALSE
	END IF
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_reg_pd"
	idw_master.is_list.l_identifica[1] = ll_id_reg_pd
	ib_attiva_wizard = FALSE
	idw_master.Event ue_retrieve(0, 0)
	SetNull(is_filtro_conto)
END IF
idw_master.SetFocus()
end subroutine

public subroutine uf_crea_righe_iva_det ();long ll_CurrRow_Reg_PD,  ll_Cambio_Reg_PD, ll_Nuovo_Movimento, ll_id_reg_pd
long ll_id_prof_registrazione, ll_conto_iva, ll_IDRegistro, ll_num_righe, ll_conto_iva_nd
date ld_Data_Reg_PD
string ls_tipo_registro, ls_conto_codice, ls_conto_descrizione, ls_des_contabile
decimal {2} ldec_imposta, ldec_per_detrazione
char lc_tipo_fattura, lc_segno
datawindow ldw_mov_contabile_gd, ldw_mov_iva_gd
dwItemStatus l_status

ldw_mov_contabile_gd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd
ldw_mov_iva_gd = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd

ll_num_righe = ldw_mov_contabile_gd.RowCount()

IF ib_crea_movimenti = TRUE THEN

	ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

	
	ll_id_reg_pd = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_reg_pd")

	
	lc_tipo_fattura = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_tipo_fattura")

		ll_Nuovo_Movimento = ldw_mov_contabile_gd.InsertRow(0)
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.is_list.l_identifica[1] = ll_ID_Reg_PD
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_reg_pd", ll_id_reg_pd)
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "numero", 9999)
	
		
		ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
		ll_id_prof_registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_prof_registrazione")
	
		SELECT "prof_registrazione"."id_conto_iva"
			INTO :ll_conto_iva
			FROM "prof_registrazione"
			WHERE "prof_registrazione"."id_prof_registrazione" = :ll_id_prof_registrazione;
	
		
		ll_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_registro")
		SELECT "registro"."tipo_registro"
			INTO :ls_tipo_registro
			FROM "registro"
			WHERE "registro"."id_registro" = :ll_IDRegistro;
	
		
		IF IsNull(ll_conto_iva) THEN
			IF ls_tipo_registro = "IA" THEN
				SELECT "par_sistema"."id_conto_iva_ia"
					INTO :ll_conto_iva
					FROM "par_sistema"
					WHERE "par_sistema"."id_azienda" = 1;
			ELSEIF ls_tipo_registro = "IV" THEN
				SELECT "par_sistema"."id_conto_iva_iv"
					INTO :ll_conto_iva
					FROM "par_sistema"
					WHERE "par_sistema"."id_azienda" = 1;
			END IF
		END IF
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_conto", ll_conto_iva)
	
		SELECT "dba"."conto"."codice", "dba"."conto"."descrizione"
			INTO :ls_conto_codice, :ls_conto_descrizione
			FROM "dba"."conto"
			WHERE "dba"."conto"."id_conto" = :ll_conto_iva;
	
		CHOOSE CASE SQLCA.SQLCode
			CASE -1
				MessageBox("Errore sul Database", "ue_crea_mov_contabili_iva2")
				RETURN
			CASE 0
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_codice", ls_conto_codice)
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_descrizione", ls_conto_descrizione)
		END CHOOSE
	
		l_status = ldw_mov_iva_gd.GetItemStatus(ldw_mov_iva_gd.GetRow(), 0, Primary!)
	
		
		
		
		
		SELECT sum ("mov_iva"."imposta" / 100 * "tab_iva"."per_detrazione")
		INTO :ldec_imposta  FROM "mov_iva", "tab_iva"
		WHERE ( "tab_iva"."id_tab_iva" = "mov_iva"."id_tab_iva" ) AND "mov_iva"."id_reg_pd" = :ll_id_reg_pd;
      if il_lire=ll_valuta_reg_pd then	ldec_imposta=ceiling(ldec_imposta)    
	   
		
		lc_segno = uf_calcola_segno(ls_tipo_registro, lc_tipo_fattura, ll_id_prof_registrazione, "I")
		CHOOSE CASE lc_segno
			CASE "D"
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "dare", ldec_imposta)
			CASE "A"
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "avere", ldec_imposta)
		END CHOOSE
	
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_valuta", ll_Valuta_Reg_PD)
	
		
		ll_Cambio_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "cambio")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "cambio", ll_cambio_Reg_PD)
	
		
		
		ld_Data_Reg_PD = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow_Reg_PD, "data_competenza")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_val_banca", ld_Data_Reg_PD)
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_inizio_competenza", ld_Data_Reg_PD)
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_fine_competenza", ld_Data_Reg_PD)
	
		
		ls_des_contabile = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "descrizione")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_des_contabile", ls_des_contabile)
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_rateo_risconto", "N")
	
		
		Post Function uf_sposta_focus(ldw_mov_contabile_gd, "conto_codice")
	
	
		
		tab_mov_contabile.SelectedTab = 2
	end if
end subroutine

public subroutine uf_crea_righe_iva_det1 ();long ll_CurrRow_Reg_PD, ll_Cambio_Reg_PD, ll_Nuovo_Movimento, ll_id_reg_pd
long ll_id_prof_registrazione, ll_conto_iva, ll_IDRegistro, ll_num_righe, ll_conto_iva_nd
date ld_Data_Reg_PD
string ls_tipo_registro, ls_conto_codice, ls_conto_descrizione, ls_des_contabile
decimal {2} ldec_imposta, ldec_per_detrazione
char lc_tipo_fattura, lc_segno
datawindow ldw_mov_contabile_gd, ldw_mov_iva_gd
dwItemStatus l_status

ldw_mov_contabile_gd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd
ldw_mov_iva_gd = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd

ll_num_righe = ldw_mov_contabile_gd.RowCount()

IF ib_crea_movimenti = TRUE THEN

	ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

	
	ll_id_reg_pd = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_reg_pd")

	
	lc_tipo_fattura = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_tipo_fattura")

		ll_Nuovo_Movimento = ldw_mov_contabile_gd.InsertRow(0)
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.is_list.l_identifica[1] = ll_ID_Reg_PD
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_reg_pd", ll_id_reg_pd)
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "numero", 9999)
	
		
		ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
		ll_id_prof_registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_prof_registrazione")
	
		SELECT "prof_registrazione"."id_conto_iva"
			INTO :ll_conto_iva
			FROM "prof_registrazione"
			WHERE "prof_registrazione"."id_prof_registrazione" = :ll_id_prof_registrazione;
	
		
		ll_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_registro")
		SELECT "registro"."tipo_registro"
			INTO :ls_tipo_registro
			FROM "registro"
			WHERE "registro"."id_registro" = :ll_IDRegistro;
	
		
		IF IsNull(ll_conto_iva) THEN
			IF ls_tipo_registro = "IA" THEN
				SELECT "par_sistema"."id_conto_iva_ia"
					INTO :ll_conto_iva
					FROM "par_sistema"
					WHERE "par_sistema"."id_azienda" = 1;
			ELSEIF ls_tipo_registro = "IV" THEN
				SELECT "par_sistema"."id_conto_iva_iv"
					INTO :ll_conto_iva
					FROM "par_sistema"
					WHERE "par_sistema"."id_azienda" = 1;
			END IF
		END IF
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_conto", ll_conto_iva)
	
		SELECT "dba"."conto"."codice", "dba"."conto"."descrizione"
			INTO :ls_conto_codice, :ls_conto_descrizione
			FROM "dba"."conto"
			WHERE "dba"."conto"."id_conto" = :ll_conto_iva;
	
		CHOOSE CASE SQLCA.SQLCode
			CASE -1
				MessageBox("Errore sul Database", "ue_crea_mov_contabili_iva2")
				RETURN
			CASE 0
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_codice", ls_conto_codice)
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_descrizione", ls_conto_descrizione)
		END CHOOSE
	
		l_status = ldw_mov_iva_gd.GetItemStatus(ldw_mov_iva_gd.GetRow(), 0, Primary!)
	
		
		
		
		
		
		SELECT sum ("mov_iva"."imposta" / 100 * "tab_iva"."per_detrazione")
		INTO :ldec_imposta   FROM "mov_iva", "tab_iva"
		WHERE ( "tab_iva"."id_tab_iva" = "mov_iva"."id_tab_iva" ) AND "mov_iva"."id_reg_pd" = :ll_id_reg_pd;
      if il_lire=ll_valuta_reg_pd then	ldec_imposta=ceiling(ldec_imposta)  
		
		
		lc_segno = uf_calcola_segno(ls_tipo_registro, lc_tipo_fattura, ll_id_prof_registrazione, "I")
		CHOOSE CASE lc_segno
			CASE "D"
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "dare", ldec_imposta)
			CASE "A"
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "avere", ldec_imposta)
		END CHOOSE
	
	
		
		ll_Valuta_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_valuta_cod")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_valuta", ll_Valuta_Reg_PD)
	
		
		ll_Cambio_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "cambio")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "cambio", ll_cambio_Reg_PD)
	
		
		
		ld_Data_Reg_PD = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow_Reg_PD, "data_competenza")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_val_banca", ld_Data_Reg_PD)
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_inizio_competenza", ld_Data_Reg_PD)
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_fine_competenza", ld_Data_Reg_PD)
	
		
		ls_des_contabile = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "descrizione")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_des_contabile", ls_des_contabile)
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_rateo_risconto", "N")
	
		
		Post Function uf_sposta_focus(ldw_mov_contabile_gd, "conto_codice")
	
	
		
		tab_mov_contabile.SelectedTab = 2
	end if
	
end subroutine

public subroutine uf_crea_righe_nd1 ();long ll_CurrRow_Reg_PD,  ll_Cambio_Reg_PD, ll_Nuovo_Movimento, ll_id_reg_pd
long ll_id_prof_registrazione, ll_conto_iva, ll_IDRegistro, ll_num_righe, ll_conto_iva_nd
date ld_Data_Reg_PD
string ls_tipo_registro, ls_conto_codice, ls_conto_descrizione, ls_des_contabile
decimal {2} ldec_imposta, ldec_per_detrazione
char lc_tipo_fattura, lc_segno
datawindow ldw_mov_contabile_gd, ldw_mov_iva_gd
dwItemStatus l_status

ldw_mov_contabile_gd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd
ldw_mov_iva_gd = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd

ll_num_righe = ldw_mov_contabile_gd.RowCount()

IF ib_crea_movimenti = TRUE THEN

	ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

	
	ll_id_reg_pd = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_reg_pd")

	
	lc_tipo_fattura = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "reg_pd_tipo_fattura")

		ll_Nuovo_Movimento = ldw_mov_contabile_gd.InsertRow(0)
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.is_list.l_identifica[1] = ll_ID_Reg_PD
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_reg_pd", ll_id_reg_pd)
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "numero", 8888)
	
		
		ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
		ll_id_prof_registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_prof_registrazione")
	
		SELECT "prof_registrazione"."id_conto_iva"
			INTO :ll_conto_iva
			FROM "prof_registrazione"
			WHERE "prof_registrazione"."id_prof_registrazione" = :ll_id_prof_registrazione;
	
		
		ll_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_registro")
		SELECT "registro"."tipo_registro"
			INTO :ls_tipo_registro
			FROM "registro"
			WHERE "registro"."id_registro" = :ll_IDRegistro;
	
		
		
				SELECT "par_sistema"."id_conto_iva_nd"
					INTO :ll_conto_iva
					FROM "par_sistema"
					WHERE "par_sistema"."id_azienda" = 1;
				
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_conto", ll_conto_iva)
	
		SELECT "dba"."conto"."codice", "dba"."conto"."descrizione"
			INTO :ls_conto_codice, :ls_conto_descrizione
			FROM "dba"."conto"
			WHERE "dba"."conto"."id_conto" = :ll_conto_iva;
	
		CHOOSE CASE SQLCA.SQLCode
			CASE -1
				MessageBox("Errore sul Database", "ue_crea_mov_contabili_iva2")
				RETURN
			CASE 0
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_codice", ls_conto_codice)
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "conto_descrizione", ls_conto_descrizione)
		END CHOOSE
	
		l_status = ldw_mov_iva_gd.GetItemStatus(ldw_mov_iva_gd.GetRow(), 0, Primary!)
	
		
		

		SELECT sum ("mov_iva"."imposta" / 100 * (100 - "tab_iva"."per_detrazione"))
			INTO :ldec_imposta
			FROM "mov_iva", "tab_iva"
			WHERE ( "tab_iva"."id_tab_iva" = "mov_iva"."id_tab_iva" ) AND "mov_iva"."id_reg_pd" = :ll_id_reg_pd;
	   
		if il_lire=ll_valuta_reg_pd then
			ldec_imposta= Truncate(ldec_imposta,0)
		else	
			ldec_imposta= Truncate(ldec_imposta,2)
		end if	
		
		lc_segno = uf_calcola_segno(ls_tipo_registro, lc_tipo_fattura, ll_id_prof_registrazione, "I")
		CHOOSE CASE lc_segno
			CASE "D"
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "dare", ldec_imposta)
			CASE "A"
				ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "avere", ldec_imposta)
		END CHOOSE
	
	
		
		ll_Valuta_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_valuta_cod")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "id_valuta", ll_Valuta_Reg_PD)
	
		
		ll_Cambio_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "cambio")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "cambio", ll_cambio_Reg_PD)
	
		
		
		ld_Data_Reg_PD = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow_Reg_PD, "data_competenza")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_val_banca", ld_Data_Reg_PD)
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_inizio_competenza", ld_Data_Reg_PD)
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "data_fine_competenza", ld_Data_Reg_PD)
	
		
		ls_des_contabile = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "descrizione")
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_des_contabile", ls_des_contabile)
	
		
		ldw_mov_contabile_gd.SetItem(ll_Nuovo_Movimento, "mov_contabile_rateo_risconto", "N")
	
		
	
	
	
		Post Function uf_sposta_focus(ldw_mov_contabile_gd, "conto_codice")
	
	
		
		tab_mov_contabile.SelectedTab = 2


end if
end subroutine

public function long uf_insoluti (integer par_aperta, integer reg_pd);long ll_scad, ll_mov_par


select id_mov_partita
into :ll_mov_par
from mov_partita
where id_par_aperta=:par_aperta and id_reg_pd<>:reg_pd;

select id_scadenza
into :ll_scad
from mov_scadenza
where id_mov_partita=:ll_mov_par;


return ll_scad
end function

public function long uf_controlla_sbilanciate ();long ll_mov, ll_id_regpd
decimal dar, ave, dif


ll_id_regpd=dw_reg_pd_pn_ff.getitemnumber(1,"id_reg_pd")

select sum(dare), sum(avere)
into :dar, :ave
from mov_contabile
where id_reg_pd = :ll_id_regpd;

dif = (dar - ave)

return dif


end function

public subroutine uf_cancella_cdc (integer ll_idreg_pd);long ll_testa

DECLARE lcur_cdc CURSOR FOR  
   SELECT id_reg_pdc
	from reg_pdc
	where id_reg_pd=:ll_idreg_pd;
	
	OPEN lcur_cdc;
	
	FETCH lcur_cdc into 	:ll_testa; 

   do while (sqlca.sqlcode = 0)
		delete mov_centri_costo where id_reg_pdc=:ll_testa;
		FETCH lcur_cdc into 	:ll_testa;
	loop 
	CLOSE lcur_cdc;


delete reg_pdc where id_reg_pd=:ll_idreg_pd;
commit;
end subroutine

public subroutine uf_calc_cdc_ia ();long i, ll_reg_pd, ll_conto, ll_testa, ll_pre_reg, ll_pre_conto,ll_pre_valore, a,ll_segno, ll_mov_contabile
decimal ld_importo
long ll_num, ll_ret, ll_esercizio
date ld_data
s_list_main		lstr_list

ll_reg_pd=dw_reg_pd_pn_ff.getitemnumber(1,'id_reg_pd')


FOR i=1 to tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()
	ll_conto=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(i,'id_conto')
	ll_mov_contabile=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(i,'id_mov_contabile')
	setnull(ld_importo)
	ld_importo=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemdecimal(i,'dare')
	if isnull(ld_importo) or ld_importo=0 then
		ld_importo=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemdecimal(i,'avere')
		ll_segno=-1
	else
		ll_segno=1
	end if	

a=0

select id_cen_cos_t
into :ll_testa
from centro_costo_testa
where id_conto=:ll_conto;

if sqlca.sqlcode=0 then
	
	select id_reg_pdc, id_conto, valore
	into :ll_pre_reg, :ll_pre_conto, :ll_pre_valore
	from reg_pdc
	where id_reg_pd=:ll_reg_pd and id_mov_contabile=:ll_mov_contabile;
	
	if sqlca.sqlcode=0 then
	
		
		UPDATE reg_pdc 
		SET id_conto=:ll_conto , valore=:ld_importo
		WHERE id_reg_pdc=:ll_pre_reg; 
		commit;
		
		a=1
			
	else

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
		ll_num=ll_num + 1


		insert into reg_pdc (id_reg_pd,data,num_prog,valore,id_esercizio,id_conto,segno,liv_provvisorieta,id_cen_cos_t,id_mov_contabile)
       values       (:ll_reg_pd,:ld_data,:ll_num,:ld_importo,:ll_esercizio,:ll_conto,:ll_segno,'D',:ll_testa,:ll_mov_contabile);
		
		commit;
	
	end if
	
	long ll_conto2, ll_perc,  ll_pdc
	
	decimal ll_importo, ll_tot, ll_imp2, ll_imp3
	string cod,des
	
	ll_importo=truncate(ld_importo,0)
	
		if a=1 and (ll_conto<>ll_pre_conto or ll_pre_valore<>ll_importo) then  
			delete from mov_centri_costo where id_reg_pdc=:ll_pre_reg;
			commit;
			ll_pdc=ll_pre_reg
		else	
			select max(id_reg_pdc)
   		into :ll_pdc
			from reg_pdc;
		end if 	

   	ll_perc=0
		ll_tot=0
		ll_imp3=0
		ll_imp2=0
		DECLARE lcur_cdc CURSOR FOR  
   	SELECT "centro_costo_righe"."id_conto",   
         "centro_costo_righe"."base_perc"    
    	FROM "dba"."centro_costo_righe"  
   	WHERE  "centro_costo_righe"."id_cen_cos_t" = :ll_testa; 
   	OPEN lcur_cdc;
	
		FETCH lcur_cdc into 	:ll_conto2,&
									:ll_perc; 
     
		
   	do while (sqlca.sqlcode = 0)
			ll_tot=ll_tot + ll_perc
			if ll_tot=100 then
				ll_imp2=ll_importo - ll_imp3
			else
				ll_imp2=Truncate(ll_importo*ll_perc/100, 0)
				ll_imp3=ll_imp3 + ll_imp2
			end if	
			
			if ll_segno= -1 then
				insert into mov_centri_costo (id_reg_pdc,id_conto,avere)
       		values       (:ll_pdc,:ll_conto2,:ll_imp2);
			else
				insert into mov_centri_costo (id_reg_pdc,id_conto,dare)
       		values       (:ll_pdc,:ll_conto2,:ll_imp2);
			end if	
			
			
	   	FETCH lcur_cdc into 	:ll_conto2,&
									:ll_perc;     
		   
			
		loop 
		CLOSE lcur_cdc;
		
	
	lstr_list.l_id_provenienza=ll_reg_pd
	

end if

next
if lstr_list.l_id_provenienza<>0 and not isnull(lstr_list.l_id_provenienza) then 
	if messagebox('Informazione','Vuoi visualizzare il movimento centro di costo associato alla registrazione?',information!,yesNo!)=1 then openwithparm(w_reg_cdc_cx,lstr_list)
end if

end subroutine

public subroutine uf_ripristina_data (integer row);
date ld_date
long ll_reg
ll_reg=dw_reg_pd_pn_ff.getitemnumber(row,'id_reg_pd')
select data_registrazione
into :ld_date
from reg_pd 
where id_reg_pd=:ll_Reg;

dw_reg_pd_pn_ff.setitem(row,'data_registrazione',ld_date)
end subroutine

public subroutine uf_componi_descrizione ();string ls_des, ls_char, ls_tipo, ls_controllo
long ll_ret

ls_des=dw_reg_pd_pn_ff.getitemstring(1,"descrizione")
ll_ret=pos(ls_des,'@',1)
DO WHILE ll_ret<>0 
   ls_char=Left(Right(ls_des,len(ls_des) - ll_ret),1)
	CHOOSE CASE ls_char
		CASE 'N'
			   ls_tipo=dw_reg_pd_pn_ff.getitemstring(1, "reg_pd_tipo_fattura")
				if ls_tipo='N' then
					ls_tipo="Fatt. n° "
				elseif ls_tipo='C' then 
					ls_tipo="Nota Cred. n° "
				else
					ls_tipo="Nota Debito n° "
				end if
			ls_controllo=dw_reg_pd_pn_ff.getitemstring(1,'num_documento')
			if isnull(ls_controllo) then
			   ls_des=Replace(ls_des, ll_ret, 2, ls_tipo + '')
			else
				ls_des=Replace(ls_des, ll_ret, 2, ls_tipo + ls_controllo)
			end if
		CASE 'P'
			ls_controllo=string(dw_reg_pd_pn_ff.getitemnumber(1,'num_progressivo'))
			if isnull(ls_controllo) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Num.Prog. ' + '')
			else
				ls_des=Replace(ls_des, ll_ret, 2, 'Num.Prog. ' + ls_controllo)
			end if	
		CASE 'D'
			ls_controllo=string(dw_reg_pd_pn_ff.getitemdate(1,'data_documento'))
			if isnull(ls_controllo) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Data doc. ' + '')
			else
				ls_des=Replace(ls_des, ll_ret, 2, 'Data doc. ' + ls_controllo)
			end if	
	   CASE 'R'
			ls_controllo=string(dw_reg_pd_pn_ff.getitemdate(1,'data_registrazione'))
			if isnull(ls_controllo) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Data reg. ' +'' )
			else
				ls_des=Replace(ls_des, ll_ret, 2, 'Data reg. ' + ls_controllo)
			end if	
	   CASE 'C'
			ls_controllo=string(dw_reg_pd_pn_ff.getitemdate(1,'data_competenza'))
			if isnull(ls_controllo) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Data comp. ' +'' )
			else
   			ls_des=Replace(ls_des, ll_ret, 2, 'Data comp. ' + ls_controllo)
			end if	
		CASE 'F'
			ls_controllo=dw_reg_pd_pn_ff.getitemstring(1,'conto_descrizione')
			if isnull(ls_controllo) then
				ls_des=Replace(ls_des, ll_ret,2,'')
			else
   			ls_des=Replace(ls_des, ll_ret,2,ls_controllo)
			end if
				
	END CHOOSE
	ll_ret=pos(ls_des,'@',1)
LOOP
if len(ls_des)>40 then ls_des=left(trim(ls_des),40)
dw_reg_pd_pn_ff.setitem(1,"descrizione", ls_des)

string ls_test
ls_test='1'
if tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()>0 and not isnull(ls_test) then
	post uf_test_des_mov(ls_test)
end if	
end subroutine

public function string uf_des_mov_contabile (string ls_des, integer ll_row);string  ls_char, ls_tipo, ls_controllo, ls_movdes
long ll_ret

ll_ret=pos(ls_des,'@',1)
DO WHILE ll_ret<>0 
   ls_char=Left(Right(ls_des,len(ls_des) - ll_ret),1)
	CHOOSE CASE ls_char
		CASE 'N'
			   ls_tipo=dw_reg_pd_pn_ff.getitemstring(1, "reg_pd_tipo_fattura")
				if ls_tipo='N' then
					ls_tipo="Fatt. n° "
				elseif ls_tipo='C' then 
					ls_tipo="Nota Cred. n° "
				else
					ls_tipo="Nota Debito n° "
				end if
				ls_controllo=dw_reg_pd_pn_ff.getitemstring(1,'num_documento')
				if isnull(ls_controllo) then
			  		ls_des=Replace(ls_des, ll_ret, 2, ls_tipo + '' )
				else
					ls_des=Replace(ls_des, ll_ret, 2, ls_tipo + ls_controllo )
				end if	
		CASE 'P'
			ls_controllo=string(dw_reg_pd_pn_ff.getitemnumber(1,'num_progressivo'))
			if isnull(ls_controllo) then
				ls_des=Replace(ls_des, ll_ret, 2, 'Num.Prog. ' + '')
			else
				ls_des=Replace(ls_des, ll_ret, 2, 'Num.Prog. ' + ls_controllo)
			end if		
		CASE 'D'
			ls_controllo=string(dw_reg_pd_pn_ff.getitemdate(1,'data_documento'))
				if isnull(ls_controllo) then
			  		ls_des=Replace(ls_des, ll_ret, 2, 'Data doc. ' + '')
				else
					ls_des=Replace(ls_des, ll_ret, 2, 'Data doc. ' +  ls_controllo )
				end if
	   CASE 'R'
				ls_controllo=string(dw_reg_pd_pn_ff.getitemdate(1,'data_registrazione'))
				if isnull(ls_controllo) then
			  		ls_des=Replace(ls_des, ll_ret, 2, 'Data reg. ' + '')
				else
					ls_des=Replace(ls_des, ll_ret, 2, 'Data reg. ' + ls_controllo)
				end if
	   CASE 'C'
				ls_controllo=string(dw_reg_pd_pn_ff.getitemdate(1,'data_competenza'))
				if isnull(ls_controllo) then
			  		ls_des=Replace(ls_des, ll_ret, 2, 'Data comp. ' + '')
				else
					ls_des=Replace(ls_des, ll_ret, 2, 'Data comp. ' + ls_controllo)
				end if
		CASE 'M'
			ls_movdes=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getItemstring(ll_row, "conto_descrizione")
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

public subroutine uf_test_des_mov (string ls_test);integer i
string ls_des, ls_des2, ls_des_mov
for i=1 to tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount() 
	ls_des=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemstring(i,'chiocciola')
	if Pos ( ls_des,ls_test,1)>0 then
		ls_des2=uf_des_mov_contabile(ls_des,i)
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(i,'mov_contabile_des_contabile',ls_des2)
	else
		
		ls_des_mov=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemstring(i,'mov_contabile_des_contabile')
		if isnull(ls_des) and isnull(ls_des_mov) then
		
			ls_des2=dw_reg_pd_pn_ff.getitemstring(1,"descrizione")
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(i,'mov_contabile_des_contabile',ls_des2)
		end if	
	end if
next	
	
end subroutine

public subroutine wf_ute_reg_pd (string ac_operazione);long ll_id_reg_pd

ll_id_reg_pd= dw_reg_pd_pn_ff.getitemnumber(1, "id_reg_pd")
if ac_operazione> " " and ll_id_reg_pd > 0 and u_freddie.s_utenti.i_IDUtente > 0 then
	
	INSERT INTO ute_reg_pd (id_utente, id_reg_pd, operazione, data_ora)
	VALUES (:u_freddie.s_utenti.i_IDUtente, :ll_id_reg_pd, :ac_operazione, Now())
	;
	
	if sqlca.sqlcode = 0 then
		
		commit;
		
	else
		messagebox("dberror", sqlca.sqlerrtext)
		rollback;
	end if
end if
end subroutine

on w_reg_pd_cx.create
int iCurrent
call super::create
this.dw_reg_pd_pn_ff=create dw_reg_pd_pn_ff
this.p_arrowl=create p_arrowl
this.tab_mov_contabile=create tab_mov_contabile
this.cbx_retain=create cbx_retain
this.pb_1=create pb_1
this.pb_cespiti=create pb_cespiti
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_reg_pd_pn_ff
this.Control[iCurrent+2]=this.p_arrowl
this.Control[iCurrent+3]=this.tab_mov_contabile
this.Control[iCurrent+4]=this.cbx_retain
this.Control[iCurrent+5]=this.pb_1
this.Control[iCurrent+6]=this.pb_cespiti
end on

on w_reg_pd_cx.destroy
call super::destroy
destroy(this.dw_reg_pd_pn_ff)
destroy(this.p_arrowl)
destroy(this.tab_mov_contabile)
destroy(this.cbx_retain)
destroy(this.pb_1)
destroy(this.pb_cespiti)
end on

event open;call super::open;long ll_screenh
environment le_env

idw_master = dw_reg_pd_pn_ff
idw_master.is_list = Message.PowerObjectParm

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_reg_pd"
	idw_master.is_list.s_modo = modo_inserisci
	
	
	GetEnvironment(le_env)
	ll_screenh = PixelsToUnits(le_env.screenheight,YPixelsToUnits!)
	THIS.y = 0
END IF

tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetRowFocusIndicator(p_arrowl)

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_SQL_ident[1] = "reg_pd.id_reg_pd"

 
is_par_menu = idw_master.is_list.s_win_parametri

CHOOSE CASE is_par_menu
	CASE "PN"
		il_HelpTopic = 21
		dw_reg_pd_pn_ff.Object.data_competenza.Protect = 0
   CASE "MN"
		il_HelpTopic = 22
	CASE "PM"
		il_HelpTopic = 23
   CASE "IA"
		il_HelpTopic = 24
	CASE "IV"
		il_HelpTopic = 25
	CASE "IC"
		il_HelpTopic = 457
	CASE "AV"
		il_HelpTopic = 26
	CASE "PI"
		il_HelpTopic = 27
END CHOOSE

uf_setup_window()

iuo_wizard = create uo_wizard 
ib_NonModale = TRUE

iu_debug = create u_debug
iu_debug.uf_log_open("w_reg_pd_cx.log", 1, TRUE)
iu_debug.uf_log_msg(1, "***** w_reg_pd_cx - Inizio Sessione del " + string(today(), "dd/mm/yyyy") + &
	" " + string(now(), "hh:mm:ss") + " *****")

ib_euro=true
il_pro_partita=0

is_par_desc=''


select id_val_lire, data_prop_reg 
into :il_lire, :is_prop_data
from par_sistema;

end event

event closequery;long dif,ll_ret
ii_test=0

if tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()>0 then 
	dif=uf_controlla_sbilanciate()
  if dif <> 0 then
    ll_ret=messagebox ("Information!","ATTENZIONE, ~nLA SCRITTURA E' SBILANCIATA!~nUSCIRE SENZA SALVARE?",Information!,YESNO!) 
    if ll_ret=1 then
		ii_test=1
	 else
      return 1
    end if	
  end if
end if	

long ll_RetVal
IF ii_test=0 THEN
	ll_RetVal = super::EVENT CloseQuery()
	RETURN ll_RetVal
ELSE
	RETURN 0
END IF



end event

event close;call super::close;

IF IsValid(iuo_wizard) THEN
	destroy iuo_wizard 
END IF

uf_Elimina_Incompleta()

iu_debug.uf_log_msg(1, "***** w_reg_pd_cx - Fine Sessione del " + string(today(), "dd/mm/yyyy") + " " + string(now(), "hh:mm:ss") + " *****")
iu_debug.uf_log_close(1)
destroy iu_debug

long ll_reg_now
ll_reg_now=dw_reg_pd_pn_ff.getitemnumber(1,'id_reg_pd')
delete from gest_chiudi_partite where id_reg_now=:ll_reg_now;
delete from gest_chiudi_scadenze where id_reg_now=:ll_reg_now;
commit;
end event

event ue_post_open;call super::ue_post_open;

SELECT par_sistema.id_valuta
	INTO :il_par_sistema_id_valuta
	FROM dba.par_sistema
	WHERE par_sistema.id_azienda = 1
	USING SQLCA;
	
CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase", "w_reg_pd_cx / ue_post_open / 1")
END CHOOSE
end event

type p_msg_log from w_p_data`p_msg_log within w_reg_pd_cx
boolean visible = true
integer x = 2647
integer width = 110
integer height = 88
string picturename = "C:\nita\icone\info.png"
end type

type p_crescente from w_p_data`p_crescente within w_reg_pd_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_reg_pd_cx
end type

type cb_ok from w_p_data`cb_ok within w_reg_pd_cx
integer y = 20
integer width = 270
integer taborder = 40
end type

event cb_ok::clicked;
long ll_mov,  ll_id_regpd
decimal dar, ave, dif

ll_id_regpd=dw_reg_pd_pn_ff.getitemnumber(1,"id_reg_pd")

select sum(dare), sum(avere)
into :dar, :ave
from mov_contabile
where id_reg_pd = :ll_id_regpd;

dif = (dar - ave)

if dif <> 0 then
	messagebox ("Information!","ATTENZIONE, ~nLA SCRITTURA E' SBILANCIATA!~nCORREGGERE PRIMA DI USCIRE!",Information!)
   return
end if

integer li_RetVal

IF NOT uf_controlla_movimenti() THEN
	MessageBox("Impossibile Proseguire", "La registrazione non è completa.",Information!, Ok!)
ELSE
	li_RetVal = Super::Event Clicked()
	RETURN li_RetVal
END IF




end event

type cb_annulla from w_p_data`cb_annulla within w_reg_pd_cx
integer y = 20
integer taborder = 50
end type

type cb_nuovo from w_p_data`cb_nuovo within w_reg_pd_cx
integer x = 640
integer y = 20
integer taborder = 70
string text = "N&uovo"
end type

event cb_nuovo::clicked;

Integer li_RetVal


is_par_desc=''

il_esercizio=dw_reg_pd_pn_ff.getitemnumber(1,'esercizio_id_esercizio')
IF uf_nuovo() = 0 THEN
	li_RetVal = Super::Event Clicked()
	RETURN li_RetVal
END IF

dw_reg_pd_pn_ff.Object.DataWindow.ReadOnly="No"		

cb_cancella.Enabled = true


long ll_reg_now
ll_reg_now=dw_reg_pd_pn_ff.getitemnumber(1,'id_reg_pd')
delete from gest_chiudi_partite where id_reg_now=:ll_reg_now;
delete from gest_chiudi_scadenze where id_reg_now=:ll_reg_now;
commit;


end event

type cb_inserisci from w_p_data`cb_inserisci within w_reg_pd_cx
integer x = 1760
integer y = 20
integer taborder = 100
end type

type cb_cancella from w_p_data`cb_cancella within w_reg_pd_cx
integer x = 2057
integer y = 20
integer taborder = 110
end type

event cb_cancella::clicked;

w_p_data  lw_win
u_dw_main lu_dw

lw_win = u_freddie.iw_current
lu_dw = u_freddie.iudw_current
IF IsValid(lu_dw) THEN
	IF isValid(lu_dw.iudw_parent) THEN
		IF NOT lu_dw.ib_dw_shared THEN
			IF lu_dw.RowCount() > 0 THEN
				dw_reg_pd_pn_ff.SetRedraw(FALSE)
				parent.triggerevent("ue_delete")
				if lu_dw.dataobject<>'d_mov_contabile_gd' then 	uf_nuovo()
				dw_reg_pd_pn_ff.SetRedraw(TRUE)
			END IF
		END IF
	ELSE
		dw_reg_pd_pn_ff.SetRedraw(FALSE)
		idw_master.Event ue_delete(0, 0)
		
		
		
		
		dw_reg_pd_pn_ff.reset()
		triggerevent("ue_pre_nuovo")
		dw_reg_pd_pn_ff.is_list.s_modo	= modo_inserisci
		dw_reg_pd_pn_ff.triggerevent("ue_insert")
		triggerevent("ue_post_nuovo")
		dw_reg_pd_pn_ff.Object.DataWindow.ReadOnly="No"		
		
	
		
		dw_reg_pd_pn_ff.SetRedraw(TRUE)
	END IF
END IF
end event

type cb_salva from w_p_data`cb_salva within w_reg_pd_cx
integer x = 2354
integer y = 20
integer taborder = 120
end type

event cb_salva::clicked;

	parent.TriggerEvent("ue_update")

end event

type tab_1 from w_p_data`tab_1 within w_reg_pd_cx
boolean visible = false
integer x = 1024
integer y = 36
integer width = 361
integer height = 140
integer taborder = 60
long backcolor = 79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 325
integer height = 20
end type

type cb_ricerca from w_p_data`cb_ricerca within w_reg_pd_cx
integer x = 1390
integer y = 20
integer width = 320
integer taborder = 90
end type

event cb_ricerca::clicked;

uf_ricerca_1()  
il_conto_old=dw_reg_pd_pn_ff.getitemnumber(1,"id_conto")
il_conto_v=il_conto_old


date ld_control1, ld_control2, ld_data
long ll_registro
string ls_tipo

ll_registro=dw_reg_pd_pn_ff.getItemnumber(1, "id_registro")
ld_data=dw_reg_pd_pn_ff.getItemdate(1, "data_registrazione")

select ultima_data, tipologia
into :ld_control1, :ls_tipo
from contatori_registri
where id_registro=:ll_registro;

		
select ultima_data
into :ld_control2
from contatori_registri
where tipologia='PN';
		
if ld_data<=ld_control1 or ld_data<=ld_control2 then
	messagebox('Impossibile proseguire', 'La data già stampata su bollato')
	dw_reg_pd_pn_ff.Object.DataWindow.ReadOnly="Yes"
end if		


end event

type dw_reg_pd_pn_ff from u_dw_master_main within w_reg_pd_cx
event ue_assegna_imp_doc ( )
event ue_calcola_imp_lire ( )
event ue_attiva_imp_fat_cee ( )
event ue_assegna_cambio ( )
event ue_nota_accredito ( long al_id_reg_pd )
event ue_assegna_righe_1_9999 ( string as_data )
integer x = 41
integer y = 124
integer width = 2738
integer height = 784
integer taborder = 10
string dataobject = "d_reg_pd_ff"
end type

event ue_assegna_imp_doc;

long ll_CurrRow_Reg_PD, ll_CurrRow_Mov_IVA , ll_Riga_1, ll_i
decimal {2} ldc_Importo, ldc_dare, ldc_avere

ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

IF ll_CurrRow_Reg_PD > 0 THEN
	dw_reg_pd_pn_ff.AcceptText()
	ldc_Importo = dw_reg_pd_pn_ff.uf_GetItemDecimal(ll_CurrRow_Reg_PD, "importo")
	ll_CurrRow_Mov_IVA = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.GetRow()

	IF ll_CurrRow_Mov_IVA = 0 THEN
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.InsertRow(0)
	END IF

	tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.SetItem(ll_CurrRow_Mov_IVA, "documento", ldc_Importo)
END IF


end event

event ue_calcola_imp_lire;long ll_CurrRow, ll_CurrRow_Mov_IVA
decimal ldc_imp_valuta, ldc_cambio, ldc_imp

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	THIS.AcceptText()
	ldc_imp_valuta = THIS.uf_GetItemDecimal(ll_CurrRow, "reg_pd_imp_valuta")
	ldc_cambio = THIS.uf_GetItemDecimal(ll_CurrRow, "cambio")
	
	if il_lire=ll_valuta_reg_pd then 
		ldc_imp=f_round_2(il_lire, ldc_imp_valuta * ldc_cambio)
	else
		ldc_imp=ldc_imp_valuta * ldc_cambio
	end if	
	THIS.SetItem(ll_CurrRow, "importo", ldc_imp)
END IF
end event

event ue_attiva_imp_fat_cee;call super::ue_attiva_imp_fat_cee;

string las_array[]
long ll_CurrRow, ll_CurrRow_Mov_IVA_gd, ll_CurrRow_Mov_IVA_ff
decimal ldc_cambio, ldc_impvaluta, ldc_tot_fattura
integer li_RetVal

ll_CurrRow = THIS.GetRow()

s_list_main lstr_for_win

lstr_for_win.s_modo = modo_modifica
lstr_for_win.s_identifica[1] = ""

ldc_cambio = THIS.uf_GetItemDecimal(ll_CurrRow, "cambio")
ldc_impvaluta = THIS.uf_GetItemDecimal(ll_CurrRow, "reg_pd_imp_valuta")
las_array[1] = "ivacee"
las_array[2] = string(ldc_impvaluta * ldc_cambio)
las_array[3] = string(THIS.GetItemNumber(ll_CurrRow, "id_prof_registrazione"))
u_freddie.sp_push(las_array)

OpenWithParm(w_imp_fat_cee_ff, lstr_for_win)

u_freddie.sp_pop(las_array)
ldc_tot_fattura = dec(las_array[2])
THIS.SetItem(ll_CurrRow, "importo", ldc_tot_fattura)



ll_CurrRow_Mov_IVA_ff = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.GetRow()
ll_CurrRow_Mov_IVA_gd = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetRow()
tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.SetItem(ll_CurrRow_Mov_IVA_ff, "documento", ldc_tot_fattura)
tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetItem(ll_CurrRow_Mov_IVA_gd, "mov_iva_imponibile", uf_proponi_scorporo())
end event

event ue_assegna_cambio;

long ll_id_valuta, ll_id_esercizio, ll_currow
decimal ldc_cambio

ll_currow = dw_reg_pd_pn_ff.rowcount()
ll_id_esercizio = dw_reg_pd_pn_ff.GetItemNumber(ll_CurRow, "esercizio_id_esercizio")
long ll_val_esercizio
select id_valuta into :ll_val_esercizio from esercizio where id_esercizio=:ll_id_esercizio;

ll_id_valuta = dw_reg_pd_pn_ff.GetItemNumber(dw_reg_pd_pn_ff.GetRow(), "id_valuta_cod")
IF ll_id_valuta > 0 THEN

	if ll_val_esercizio=il_lire then
		ldc_cambio = f_proponi_cambio(ll_id_valuta)
	else 
		ldc_cambio = f_prop_cambio_euro(ll_id_valuta)
	end if
	dw_reg_pd_pn_ff.SetItem(dw_reg_pd_pn_ff.GetRow(), "cambio", ldc_cambio)

END IF

end event

event ue_nota_accredito;long ll_CurrRow, ll_id_conto, ll_id_par_aperta, ll_id_par_aperta_curr
string ls_codice_conto
w_search_main lw_sm
char lc_tipo_fattura
s_ric_param ls_ric_param

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
lc_tipo_fattura = THIS.GetItemString(ll_CurrRow, "reg_pd_tipo_fattura")

IF (ib_Inserimento = TRUE) AND ((lc_tipo_fattura = 'C') OR (lc_tipo_fattura = 'D')) AND (ll_CurrRow > 0) THEN
	ls_codice_conto = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow, "conto_codice")
	ll_id_conto = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_conto")
	is_ricpar = ls_ric_param
	is_ricpar.s_filter_value = ls_codice_conto
	is_ricpar.s_filter_name = "conto_codice"
	
	
	SELECT par_aperta.id_par_aperta 
		INTO :ll_id_par_aperta_curr
		FROM dba.par_aperta
		WHERE par_aperta.id_reg_pd = :al_id_reg_pd
		USING SQLCA;
		
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			is_ricpar.s_SQL_cond = "par_aperta.id_par_aperta <> " + string(ll_id_par_aperta_curr)
			OpenWithParm(lw_sm, is_ricpar, "w_nota_accredito_sw")
			is_ricpar = Message.PowerObjectParm
		
			IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
				ll_id_par_aperta = long(is_ricpar.s_id_seg_value[1])
				UPDATE "dba"."par_aperta"
					SET "id_par_aperta_padre" = :ll_id_par_aperta
					WHERE "dba"."par_aperta"."id_reg_pd" = :al_id_reg_pd   ;
				commit;	
		
				CHOOSE CASE SQLCA.SQLCode
					CASE 0
						IF SQLCA.SQLNRows > 0 THEN
							COMMIT;
						ELSE
							MessageBox("Registrazioni Contabili", "Attenzione: La Registrazione Contabile appena memorizzata~rnon ha generato la Partita Aperta. Controllare che il Profilo~rRegistrazione e il Conto selezionato abbiano abilitata la~rgenerazione delle partite.")
						END IF
					CASE -1
						MessageBox("Errore sul DataBase","dw_reg_pd_pn_ff / ue_nota_accredito / 1")
						RETURN
				END CHOOSE
			END IF
		CASE 100
	END CHOOSE

END IF

long ll_imp

select importo
into :ll_imp
from par_aperta where id_par_aperta_padre = :ll_id_par_aperta;

insert into mov_partita (importo, id_par_aperta)
values(:ll_imp, :ll_id_par_aperta);
commit;

insert into mov_partita (importo, id_par_aperta)
values(:ll_imp, :ll_id_par_aperta_curr);
commit;

end event

event ue_assegna_righe_1_9999;call super::ue_assegna_righe_1_9999;

long ll_riga_1, ll_i
decimal ldc_dare, ldc_avere
dwItemStatus l_status
DataWindow ldw_mov_contab, ldw_mov_iva

ldw_mov_contab = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd
ldw_mov_iva = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd
l_status = THIS.GetItemStatus(THIS.GetRow(), 0, Primary!)

IF (l_status <> New!) AND (l_status <> NewModified!) AND (ldw_mov_contab.RowCount() > 0) THEN
	ll_riga_1 = ldw_mov_contab.find('numero = 1', 1, ldw_mov_contab.RowCount())
	IF ll_riga_1 > 0 THEN
		ldc_dare = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_riga_1, "dare")
		ldc_avere = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_riga_1, "avere")

		
		IF NOT IsNull(ldc_dare) THEN
			ldw_mov_contab.SetItem(ll_riga_1, "dare", dec(as_data))
		ELSEIF NOT IsNull(ldc_avere) THEN
			ldw_mov_contab.SetItem(ll_riga_1, "avere", dec(as_data))
		END IF

		
		
		
		FOR ll_i = 1 TO ldw_mov_iva.RowCount()
			ldw_mov_iva.SetItemStatus(ll_i, 0, Primary!, DataModified!)
		NEXT
	END IF
END IF
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_reg_pd"
iudw_children[1] = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd
iudw_children[2] = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd
is_title = "Registrazioni Contabili"

end event

event ue_default;call super::ue_default;long ll_CurrRow, ll_Cur_IDRegistro, ll_ID_Prof_Reg
long ll_id_esercizio, ll_IDRegistro, ll_Min_Num_Registro, ll_IDCliFor
string ls_Par_Menu, ls_tipo_registro, ls_descrizione_registro, ls_cod_esercizio
string ls_conto_codice, ls_conto_descrizione, ls_Ultimo_Num_Doc, ls_prog_scritture
date ld_Ultima_Data_Doc, ld_Data_Reg_PD, ld_data_in, ld_data_fn
decimal ldc_cambio
Integer LI_AZIENDA_FITTIZIA
LI_AZIENDA_FITTIZIA = 1

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
ll_Cur_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_registro")
ll_ID_Prof_Reg = dw_reg_pd_pn_ff.GetItemNumber(al_row, "id_prof_registrazione")
ll_id_esercizio = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "esercizio_id_esercizio")


SELECT "esercizio"."prog_scritture"
 INTO :ls_prog_scritture
 FROM "esercizio",
		"registro"
WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and
		( ( "registro"."id_registro" = :ll_IDRegistro ) )   ;
CHOOSE CASE string(adwo_current.name)
	CASE "registro_descrizione"
		IF ll_ID_Prof_Reg > 0 THEN
			ll_IDRegistro = f_proponi_registro(ll_ID_Prof_Reg, ll_id_esercizio)
			IF ll_IDRegistro > 0 THEN
	
				  SELECT "registro"."descrizione",
							"registro"."tipo_registro",
							"registro"."numero",
							"esercizio"."codice",
							"esercizio"."data_inizio",
							"esercizio"."data_fine"
					 INTO :ls_descrizione_registro,
							:ls_par_menu,
							:ll_min_num_registro,
							:ls_cod_esercizio,
							:ld_data_in,
							:ld_data_fn
					 FROM "esercizio",
							"registro"
					WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and
							( ( "registro"."id_registro" = :ll_IDRegistro ) )   ;

	
	
				dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "id_registro", ll_IDRegistro)
				dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "registro_descrizione", ls_descrizione_registro)
	
				dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "esercizio_codice", ls_cod_esercizio)
				dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "registro_numero", ll_min_num_registro)
	
	
	
	
	
				uf_set_colval("cinfo_registro", "Tipo: " + ls_Par_Menu + " - " + &
														  "Numero: " + string(ll_Min_Num_Registro))
	
			ELSE
				MessageBox("Registrazioni Contabili", "Attenzione: il registro impostato nel profilo~rnon esiste per l'esercizio selezionato.")
			END IF
		END IF
	CASE "num_progressivo"
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "num_progressivo", f_proponi_num_reg_pd(ll_Cur_IDRegistro,ls_prog_scritture))

		
		
	CASE "data_registrazione"
		
		IF ll_Cur_IDRegistro > 0 THEN 
			
			ld_Data_Reg_PD = today()
			if is_prop_data<>'S' or (ld_data_reg_pd>ld_data_fn or ld_data_reg_pd<ld_data_in) then
			
				ld_Data_Reg_PD = f_proponi_data_reg_pd(ll_Cur_IDRegistro,ls_prog_scritture)
			end if	
			dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "data_registrazione", ld_Data_Reg_PD)
			dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "data_competenza", ld_Data_Reg_PD)
		END IF
	CASE "id_valuta_cod"
		ll_IDCliFor = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_conto")
		ll_ID_Prof_Reg = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
		
		ll_Valuta_Reg_PD = f_proponi_valuta(ll_IDCliFor, ll_id_esercizio)
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "id_valuta_cod", ll_Valuta_Reg_PD)

	CASE "cambio"
		ll_Valuta_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_valuta_cod")
		
		long ll_val_esercizio
		select id_valuta into :ll_val_esercizio from esercizio where id_esercizio=:ll_id_esercizio;
		if ll_val_esercizio=il_lire then
			ldc_cambio = f_proponi_cambio(ll_Valuta_Reg_PD)
		else 
			ldc_cambio = f_prop_cambio_euro(ll_Valuta_Reg_PD)
		end if
		
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "cambio", ldc_cambio)
	CASE "descrizione"
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "descrizione", f_proponi_descr_reg_pd(ll_ID_Prof_Reg))
	CASE "num_documento"
		ls_tipo_registro = uf_seleziona_tipo_registro(ll_Cur_IDRegistro)
		IF ls_tipo_registro = "IV" then 
			ls_Ultimo_Num_Doc = f_proponi_num_documento(ll_Cur_IDRegistro,ls_prog_scritture)
			dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "num_documento", ls_Ultimo_Num_Doc)
		END IF

	CASE "data_documento"
		ls_tipo_registro = uf_seleziona_tipo_registro(ll_Cur_IDRegistro)

		IF ls_tipo_registro = "IV" then 
			ld_Ultima_Data_Doc = f_proponi_data_documento(ll_Cur_IDRegistro,ls_prog_scritture)
			dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "data_documento", ld_Ultima_Data_Doc)
		END IF

	CASE "conto_codice"
		ll_ID_Prof_Reg = THIS.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
		ll_IDCliFor = f_proponi_conto(ll_ID_Prof_Reg, ls_conto_codice, ls_conto_descrizione)
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "id_conto", ll_IDCliFor)
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "conto_codice", ls_conto_codice)
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "conto_descrizione", ls_conto_descrizione)
END CHOOSE
end event

event updatestart;


long ll_CurrRow
dwItemStatus l_status

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
l_status = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow, 0, Primary!)
IF l_status = NewModified! THEN ib_Crea_Mov_Contabili = TRUE


date ld_data_reg
long ll_sos_sistema,ll_sos
select id_prof_reg_iva_sos
into :ll_sos_sistema
from par_sistema;
ll_sos=this.getitemnumber(1,"id_prof_registrazione")
if ll_sos_sistema<>ll_sos or isnull(ll_sos_sistema) then
	ld_data_reg=this.getitemdate(1,"data_comp_liq_iva")
	if isnull(ld_data_reg) then
		ld_data_reg=this.getitemdate(1,"data_registrazione")
		this.setitem(1,"data_comp_liq_iva",ld_data_reg)
	end if
end if


string ls_descrizione,ls_num_doc
date ld_data_doc
ls_descrizione=this.getitemstring(1,"descrizione")
uf_componi_descrizione()
if isnull(ls_descrizione) then
	ls_num_doc=this.getitemstring(1,"num_documento")
	ld_data_doc=this.getitemdate(1,"data_documento")
	if not isnull(ls_num_doc) and not isnull(ld_data_doc) then
		ls_descrizione="Fatt. n° "+ls_num_doc+" del "+string(ld_data_doc,'dd/mm/yyyy')
		this.setitem(1,"descrizione",ls_descrizione)
	end if
end if


long ll_id_prof_registrazione
string ges_intra
boolean lb_ges_intra
lb_ges_intra=false
ll_id_prof_registrazione=dw_reg_pd_pn_ff.getitemnumber(1,"id_prof_registrazione")
select ges_oper_intracomunitarie
into :ges_intra
from prof_registrazione
where id_prof_registrazione=:ll_id_prof_registrazione;
if ges_intra='S' then 
	lb_ges_intra=true
else
	lb_ges_intra=false
	DECLARE CEE CURSOR FOR
	SELECT "wizard"."codice" 
    FROM "prof_registrazione",   
         "wiz_profilo",   
         "wizard"  
   WHERE ( "wiz_profilo"."id_prof_registrazione" = "prof_registrazione"."id_prof_registrazione" ) and  
         ( "wizard"."id_wizard" = "wiz_profilo"."id_wizard" ) and  
         ( ( "prof_registrazione"."id_prof_registrazione" = :ll_id_prof_registrazione ) ) ;
	
	OPEN CEE;
	fetch cee into :ges_intra;
	do while sqlca.sqlcode=0 
		if ges_intra='S' then lb_ges_intra=true
		fetch cee into :ges_intra;
	loop
	CLOSE CEE;
end if
if lb_ges_intra=true then 
	dw_reg_pd_pn_ff.setitem(1,"reg_pd_ges_oper_intracomunitarie",'S')
else
	dw_reg_pd_pn_ff.setitem(1,"reg_pd_ges_oper_intracomunitarie",'N')
end if
end event

event constructor;call super::constructor;

ib_Crea_Mov_Contabili = FALSE
ib_crea_mov_contabili_IVA1 = FALSE
ib_crea_mov_contabili_IVA2 = FALSE
end event

event updateend;


long ll_CurrRow, ll_id_reg_pd

uf_setup_id()

ll_CurrRow = THIS.GetRow()
IF ll_CurrRow > 0 THEN
	ll_id_reg_pd = THIS.GetItemNumber(ll_CurrRow, "id_reg_pd")
END IF

THIS.Event Post ue_nota_accredito(ll_id_reg_pd)

uf_genera_movimenti()

if il_conto_old<>il_conto_v then
	long ll_reg
	ll_reg=dw_reg_pd_pn_ff.getitemnumber(1,"id_reg_pd")
	update par_aperta set id_conto=:il_conto_old where id_reg_pd=:ll_reg;
	commit;
end if
//27052105
if rowsinserted >0 then
	wf_ute_reg_pd("IR")
end if
if rowsupdated>0 then
	wf_ute_reg_pd("UR")
end if
if rowsdeleted>0 then
	wf_ute_reg_pd("DR")
end if



end event

event itemfocuschanged;

Long ll_CurrRow, ll_IDRegistro, ll_RetVal
string ls_tipo_registro
boolean lb_Continue
date ld_data_registrazione, ld_data_inizio, ld_data_fine

lb_Continue = TRUE
ll_CurrRow = THIS.GetRow()

CHOOSE CASE is_item_precedente
	
	CASE "registro_descrizione"
		ll_IDRegistro = THIS.GetItemNumber(Row, "id_registro")
		SELECT "registro"."tipo_registro"
			INTO :ls_tipo_registro
			FROM "registro"
			WHERE "registro"."id_registro" = :ll_IDRegistro;
		
		THIS.SetItem(Row, "tipo_registro", ls_tipo_registro)
		
		IF (ls_tipo_registro = "IA") OR (ls_tipo_registro = "IV") OR (ls_tipo_registro = "IC") THEN
			Post Function uf_abilita_controlli_iva(TRUE)
		ELSE
			Post Function uf_abilita_controlli_iva(FALSE)
		END IF
	CASE "data_competenza"
		
		
		if is_par_menu<>'PN' then
			THIS.Object.data_competenza.Protect = 1
		end if
	CASE "importo"
		
		
		THIS.Object.importo.Protect = 1
	CASE "esercizio_id_esercizio"
		
		
		THIS.Object.esercizio_id_esercizio.Protect = 1
	CASE "reg_pd_tipo_fattura"
		
		
		THIS.Object.reg_pd_tipo_fattura.Protect = 1
	CASE "id_valuta_cod"
		
		
		THIS.Object.id_valuta_cod.Protect = 1
	CASE "id_valuta_des"
		
		
		THIS.Object.id_valuta_des.Protect = 1
	CASE "cambio"
		
		
		IF ib_proteggi_cambio = TRUE THEN 
			THIS.Object.cambio.Protect = 1
		END IF
	CASE "data_comp_liq_iva"
		
		
		THIS.Object.data_comp_liq_iva.Protect = 1
END CHOOSE


choose case dwo.name
	CASE "conto_codice","conto_descrizione"
		string ls_descrizione,ls_num_doc
		date ld_data_doc
		ls_descrizione=this.getitemstring(1,"descrizione")
		if isnull(ls_descrizione) then
			ls_num_doc=this.getitemstring(1,"num_documento")
			ld_data_doc=this.getitemdate(1,"data_documento")
			if not isnull(ls_num_doc) and not isnull(ld_data_doc) then
				ls_descrizione=getitemstring(1, "reg_pd_tipo_fattura")
				if ls_descrizione='N' then
					ls_descrizione="Fatt. n° "+ls_num_doc+" del "+string(ld_data_doc,'dd/mm/yyyy')
				elseif ls_descrizione='C' then
				
					ls_descrizione="Nota Cred. n° "+ls_num_doc+" del "+string(ld_data_doc,'dd/mm/yyyy')
				else
					ls_descrizione="Nota Debito n° "+ls_num_doc+" del "+string(ld_data_doc,'dd/mm/yyyy')
				end if
				
				this.setitem(1,"descrizione",ls_descrizione)
			end if
		end if
end choose



is_item_precedente = THIS.GetColumnName()

IF lb_continue = TRUE THEN
	ll_RetVal = Super::Event ItemFocusChanged(row, dwo)
	RETURN ll_RetVal
END IF
end event

event ue_initial;call super::ue_initial;

long LL_ID_AZIENDA,  ll_CurrRow
dwItemStatus l_status
LL_ID_AZIENDA = 1

if isnull(il_esercizio) or il_esercizio=0 then	
	SELECT "dba"."azienda"."id_esercizio_proposto"
	INTO :il_esercizio
	FROM "dba"."azienda"
	WHERE "dba"."azienda"."id_azienda" = :LL_ID_AZIENDA   ;
end if

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		IF IsNull(il_esercizio) OR il_esercizio = 0 THEN
			MessageBox("Registrazioni Contabili", "Attenzione: Non è stato impostato l'esercizio contabile~rper l'azienda corrente.")
			RETURN
		ELSE
			ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
			l_status = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow, "esercizio_id_esercizio", Primary!)
			dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "esercizio_id_esercizio", il_esercizio)
			
			uf_aggiorna_date_esercizio(il_esercizio)
		END IF
	CASE -1
		MessageBox("Errore sul DataBase","dw_reg_pd_pn_ff / ue_initial / 1")
END CHOOSE


end event

event ue_validate_row;

long ll_CurrRow, ll_IDReg_PD, ll_num_progressivo, ll_num_prog_reg_esistente, ll_IDRegistro
long ll_IDConto, ll_registrazione, ll_IDRegistro_Esistente, ll_SQL_Reg_Esistente, ll_id_esercizio
long ll_riga, ll_id_prof_registrazione, ll_riga_nd
date ld_data_registrazione, ld_data_competenza, ld_ultima_data, ld_ultima_data_1
date ld_data_documento, ld_data_reg_esistente, ld_inizio_esercizio, ld_fine_esercizio, ld_data_bollato
string ls_tipo_registro, ls_conto_codice, ls_num_documento, ls_bloccato
decimal{4} ldc_importo, ldc_documento, ldc_imposta, ldc_importo_mc
boolean lb_data1, lb_data2, lb_Continue
integer li_RetVal, li_UChoice
dwItemStatus l_status
DataWindow ldw_mov_iva_ff, ldw_mov_iva_gd, ldw_mov_contabile_gd
dwItemStatus ldwis_status

ldw_mov_iva_ff = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff
ldw_mov_iva_gd = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd
ldw_mov_contabile_gd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd

lb_Continue = TRUE
ll_CurrRow               = THIS.GetRow()
ld_data_registrazione    = THIS.GetItemDate(ll_CurrRow, "data_registrazione")
ld_data_competenza       = THIS.GetItemDate(ll_CurrRow, "data_competenza")
ll_num_progressivo       = THIS.GetItemNumber(ll_CurrRow, "num_progressivo")
ll_IDRegistro            = THIS.GetItemNumber(ll_CurrRow, "id_registro")
ll_id_esercizio          = THIS.GetItemNumber(ll_CurrRow, "esercizio_id_esercizio")
ll_IDReg_PD              = THIS.GetItemNumber(ll_CurrRow, "id_reg_pd")
ll_id_prof_registrazione = THIS.GetItemNumber(ll_CurrRow, "id_prof_registrazione")

ll_IDConto = THIS.GetItemNumber(ll_CurrRow, "id_conto")
ls_num_documento = THIS.GetItemString(ll_CurrRow, "num_documento")

ld_data_documento =  THIS.GetItemDate(ll_CurrRow, "data_documento")
ldc_importo = THIS.uf_GetItemDecimal(ll_CurrRow, "importo")

IF IsNull(ll_id_prof_registrazione) THEN
	as_error_text = "Impossibile salvare: immettere il Profilo."
	THIS.SetColumn("prof_registrazione_codice")
	lb_Continue = FALSE
END IF

IF IsNull(ll_num_progressivo) THEN
	as_error_text = "Impossibile salvare: immettere il numero progressivo."
	THIS.SetColumn("num_progressivo")
	lb_Continue = FALSE
END IF

SELECT "registro"."tipo_registro"
	INTO :ls_tipo_registro
	FROM "registro"
	WHERE "registro"."id_registro" = :ll_IDRegistro;

IF ls_tipo_registro = "IA" OR ls_tipo_registro = "IV" then 
	
	
	SELECT "reg_pd"."data_registrazione"
		INTO :ld_ultima_data
		FROM "reg_pd"
		WHERE "reg_pd"."id_registro" = :ll_IDRegistro AND "reg_pd"."num_progressivo" =
			(SELECT Max("reg_pd"."num_progressivo")
				FROM "reg_pd"
				WHERE "reg_pd"."id_registro" = :ll_IDRegistro
				AND "reg_pd"."num_progressivo" < :ll_num_progressivo);

	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			lb_data1 = TRUE
		CASE 100
			lb_data1 = FALSE
	END CHOOSE

	
	
	SELECT "reg_pd"."data_registrazione"
		INTO :ld_ultima_data_1
		FROM "reg_pd"
		WHERE "reg_pd"."id_registro" = :ll_IDRegistro AND "reg_pd"."num_progressivo" =
			(SELECT Min("reg_pd"."num_progressivo")
				FROM "reg_pd"
				WHERE "reg_pd"."id_registro" = :ll_IDRegistro
				AND "reg_pd"."num_progressivo" > :ll_num_progressivo);

	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			lb_data2 = TRUE
		CASE 100
			lb_data2 = FALSE
	END CHOOSE

	IF lb_data1 = TRUE AND lb_data2 = TRUE THEN
		IF ld_data_registrazione < ld_ultima_data OR ld_data_registrazione > ld_ultima_data_1 THEN
			as_error_text = "Impossibile salvare: errore nella consecutività delle date."
			THIS.SetColumn("data_registrazione")
			lb_Continue = FALSE
		END IF
	ELSEIF lb_data1 = TRUE AND lb_data2 = FALSE THEN
		IF ld_data_registrazione < ld_ultima_data THEN
			as_error_text = "Impossibile salvare: errore nella consecutività delle date."
			THIS.SetColumn("data_registrazione")
			lb_Continue = FALSE
		END IF
	END IF
	

select max("ultima_data")
	into :ld_data_bollato
	from "dba"."contatori_registri"
	where "id_registro" = :ll_IDRegistro;
if sqlca.sqlcode = 0 then
	if ld_data_registrazione < ld_data_bollato then
		as_error_text = "Impossibile salvare: data già stampata su bollato."
		THIS.SetColumn("data_registrazione")
		lb_Continue = FALSE
		
	end if
end if


	
	IF IsNull(ll_IDConto) OR ll_IDConto = 0 OR IsNull(ldc_importo) THEN
		as_error_text = "Immettere l'importo del documento e il conto."
		lb_Continue = FALSE
	END IF

	
	
	IF IsNull(ls_num_documento) or IsNull(ld_data_documento) THEN
		as_error_text = "Immettere il numero e la data del documento."
		lb_Continue = FALSE
	END IF
END IF

SELECT data_inizio, data_fine,bloccato
	INTO :ld_inizio_esercizio, :ld_fine_esercizio, :ls_bloccato
	FROM esercizio
	WHERE (id_esercizio = :ll_id_esercizio );

IF ld_data_competenza < ld_inizio_esercizio OR ld_data_competenza > ld_fine_esercizio THEN
	date ld_inizio	
	select data_inizio
	into :ld_inizio
	from esercizio
	where data_inizio<=:ld_data_competenza and data_fine>=:ld_data_competenza
	and bloccato='N';
	if sqlca.sqlcode<>0 then 
		as_error_text = "La data competenza deve essere compresa tra~rla data di inizio (" + string(ld_inizio_esercizio) + ") e la data di fine (" + string(ld_fine_esercizio) + ")~rdell'esercizio corrente;"+" l'esercizio precedente è stato chiuso"
		lb_Continue = FALSE
	end if
ELSE
	if LS_bloccato='S' then
	   as_error_text = "L'esercizio è Bloccato!"
		lb_Continue = FALSE
	end if
END IF	

IF uf_Controlla_Data_Doc() = 1 THEN
	as_error_text = "La data del documento deve essere precedente~ro uguale alla data registrazione."
	THIS.SetColumn("data_documento")
	lb_Continue = FALSE
END IF

IF ib_inserimento = FALSE AND (ls_tipo_registro = "IA" OR ls_tipo_registro = "IV") then 
	ldc_documento = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.uf_GetItemDecimal(ldw_mov_iva_ff.GetRow(), "documento")
	ldc_imposta = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.uf_GetItemDecimal(ldw_mov_iva_gd.GetRow(), "totale_imposta")
	
	ll_riga = ldw_mov_contabile_gd.Find("numero = 1", 1, ldw_mov_contabile_gd.RowCount())
	IF ll_riga > 0 THEN
		ldc_importo_mc = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_riga, "dare")
			
		IF IsNull(ldc_importo_mc) THEN ldc_importo_mc = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_riga, "avere")
		
	
		IF (ldc_importo_mc > 0) AND (ldc_documento <> ldc_importo_mc) THEN
			MessageBox("Registrazioni Contabili","Impossibile proseguire: l'importo del documento della sezione IVA~rdeve essere uguale all'importo del movimento contabile con il conto~rdel Cliente/Fornitore.")
			lb_Continue = FALSE
		END IF
	END IF
	
	
	ll_riga_nd = ldw_mov_contabile_gd.Find("numero = 8888", 1, ldw_mov_contabile_gd.RowCount())
	
	IF ll_riga_nd = 0 then
	
		
		
		ll_riga = ldw_mov_contabile_gd.Find("numero = 9999", 1, ldw_mov_contabile_gd.RowCount())
		IF ll_riga > 0 THEN
			ldc_importo_mc = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_riga, "dare")
			IF IsNull(ldc_importo_mc) THEN ldc_importo_mc = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_riga, "avere")
			IF (ldc_importo_mc > 0) AND (ldc_imposta <> ldc_importo_mc) THEN
				if MessageBox("Registrazioni Contabili","Impossibile proseguire: l'importo dell'imposta della sezione IVA"+&
				"~rdeve essere uguale all'importo del movimento contabile con il conto IVA."+&
				"Se la registrazione prevede iva indetraibile è possibile che questo controllo sia errato!"+&
				"Controlla i dati e, se sono esatti, premi 'SI' per continuare!",  Stopsign!,yesno!)=1 then
					lb_Continue = true
				else
					lb_Continue = FALSE
				end if		
			END IF
		END IF
	END IF
END IF

iu_debug.uf_log_msg(1, "dw_reg_pd_pn_ff / ue_validate_row - lb_continue = " + string(lb_continue))

IF lb_Continue = TRUE THEN
	li_RetVal = Super::Event ue_validate_row(al_row, as_error_text)
	RETURN li_RetVal
	
	
ELSE
	RETURN 1
END IF
end event

event itemchanged;string ls_tipo_registro, ls_filtro_conto, ls_NULL, ls_data, ls_colval
string ls_dbc[], ls_dbv[], ls_dwc[], ls_test
long ll_CurrRow, ll_i, ll_data, ll_riga_1, ll_riga_9999, ll_id_valuta, ll_RetVal, ll_id_esercizio
long ll_id_prof_registrazione, ll_id_registro
integer li_ok, li_segno_reg_iva
decimal{4} ldc_dare, ldc_avere, ldc_cambio
boolean lb_continue
lb_continue = TRUE
date ld_data_registrazione, ld_data_documento, ld_data_inizio, ld_data_fine, ld_control1, ld_control2
DataWindow ldw_mov_contab, ldw_mov_iva

SetNull(ls_NULL)
SetNull(ls_test)
ldw_mov_contab = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd
ldw_mov_iva = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd
dwItemStatus l_status

l_status = THIS.GetItemStatus(row, 0, Primary!)
ll_CurrRow = THIS.GetRow()
ll_id_prof_registrazione = THIS.GetItemNumber(ll_CurrRow, "id_prof_registrazione")

CHOOSE CASE dwo.name
	CASE "prof_registrazione_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"
		ls_dwc[1] = "prof_registrazione_codice"
		ls_dwc[2] = "prof_registrazione_descrizione"
		ls_dwc[3] = "id_prof_registrazione"

		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			
			
			IF l_status = New! OR l_status = NewModified! THEN
				uf_Set_ColVal("registro_descrizione", u_freddie.gs_Null)
				uf_Set_ColVal("id_registro", u_freddie.gs_Null)
				uf_Set_ColVal("cinfo_registro", u_freddie.gs_Null)
				uf_Set_ColVal("num_progressivo", u_freddie.gs_Null)
				uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
				uf_Set_ColVal("data_competenza", u_freddie.gs_Null)
				uf_Set_ColVal("num_documento", u_freddie.gs_Null)
				uf_Set_ColVal("data_documento", u_freddie.gs_Null)
				uf_Set_ColVal("descrizione", u_freddie.gs_Null)
				is_tipo_registro = ""
			END IF
			uf_Assegna_Tipo_Fattura(long(ls_dbv[3]))
			
			Post Function uf_proponi_default()
			
			
			Post Function uf_attiva_insoluti(long(ls_dbv[3]))
			
			
			RETURN 2
		END IF
	CASE "prof_registrazione_descrizione"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"
		ls_dwc[1] = "prof_registrazione_codice"
		ls_dwc[2] = "prof_registrazione_descrizione"
		ls_dwc[3] = "id_prof_registrazione"
		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			
			
			IF l_status = New! OR l_status = NewModified! THEN
				uf_Set_ColVal("registro_descrizione", u_freddie.gs_Null)
				uf_Set_ColVal("id_registro", u_freddie.gs_Null)
				uf_Set_ColVal("cinfo_registro", u_freddie.gs_Null)
				uf_Set_ColVal("num_progressivo", u_freddie.gs_Null)
				uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
				uf_Set_ColVal("data_competenza", u_freddie.gs_Null)
				uf_Set_ColVal("num_documento", u_freddie.gs_Null)
				uf_Set_ColVal("data_documento", u_freddie.gs_Null)
				uf_Set_ColVal("descrizione", u_freddie.gs_Null)
			END IF
			uf_Assegna_Tipo_Fattura(long(ls_dbv[3]))
			
			Post Function uf_proponi_default()
			
			
			Post Function uf_attiva_insoluti(long(ls_dbv[3]))
			
			RETURN 2
		END IF
	CASE "esercizio_id_esercizio"
		THIS.AcceptText()
		il_esercizio = THIS.GetItemNumber(ll_CurrRow, "esercizio_id_esercizio")
		IF l_status = New! OR l_status = NewModified! THEN
			uf_Set_ColVal("registro_descrizione", u_freddie.gs_Null)
			uf_Set_ColVal("id_registro", u_freddie.gs_Null)
			uf_Set_ColVal("cinfo_registro", u_freddie.gs_Null)
			uf_Set_ColVal("num_progressivo", u_freddie.gs_Null)
			uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
			uf_Set_ColVal("data_competenza", u_freddie.gs_Null)
			uf_Set_ColVal("num_documento", u_freddie.gs_Null)
			uf_Set_ColVal("data_documento", u_freddie.gs_Null)
			uf_Set_ColVal("descrizione", u_freddie.gs_Null)
		END IF
      uf_aggiorna_date_esercizio(il_esercizio)
		
		Post Function uf_proponi_default()

	CASE "registro_descrizione"
		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "id_registro"
		ls_dwc[1] = "registro_descrizione"
		ls_dwc[2] = "id_registro"
		li_ok = uf_autofind_col(string(dwo.name), "registro", "descrizione", "A", data, "", 2, ls_dbc, ls_dbv, ls_dwc)

		ll_data = long(data)
		ls_tipo_registro = ""
		SELECT "dba"."registro"."tipo_registro"
			INTO :ls_tipo_registro
			FROM "dba"."registro"
			WHERE "dba"."registro"."id_registro" = :ll_data;

		IF SQLCA.SQLCode < 0 THEN
			MessageBox("Errore sul Database", "dw_reg_pd_pn_ff / itemchanged / 1")
			RETURN
		END IF

		THIS.SetItem(row, "tipo_registro", ls_tipo_registro)
		
		
		is_tipo_registro = ls_tipo_registro
		
		

		IF li_ok > 0 THEN
			
			
			IF l_status = New! OR l_status = NewModified! THEN
				uf_Set_ColVal("num_progressivo", u_freddie.gs_Null)
				uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
				uf_Set_ColVal("data_competenza", u_freddie.gs_Null)
				uf_Set_ColVal("num_documento", u_freddie.gs_Null)
				uf_Set_ColVal("data_documento", u_freddie.gs_Null)
			END IF
			uf_controlla_esistente_iva()
			RETURN 2
		END IF
	CASE "num_progressivo"
		Post Function uf_controlla_esistente()
	CASE "reg_pd_tipo_fattura"
		CHOOSE CASE data
			CASE "N", "D"
				li_segno_reg_iva = 1
			CASE "C"
				li_segno_reg_iva = -1
		END CHOOSE
		THIS.SetItem(ll_CurrRow, "reg_pd_segno_reg_iva", li_segno_reg_iva)
	CASE "data_registrazione"
		THIS.AcceptText()
		ll_id_registro=this.GetItemNumber(ll_CurrRow, "id_registro")
		ls_tipo_registro = THIS.GetItemString(ll_CurrRow, "tipo_registro")
		ld_data_registrazione = THIS.GetItemDate(ll_CurrRow, "data_registrazione")
		ld_data_inizio = THIS.GetItemDate(ll_CurrRow, "esercizio_data_inizio")
		ld_data_fine = THIS.GetItemDate(ll_CurrRow, "esercizio_data_fine")
		IF NOT ((ld_data_registrazione >= ld_data_inizio) AND (ld_data_registrazione <= ld_data_fine)) THEN
			MessageBox("Registrazioni Contabili", "La data registrazione deve essere compresa tra~rla data di inizio (" + string(ld_data_inizio) + ") e la data di fine (" + string(ld_data_fine) + ")~rdell'esercizio corrente.")
			THIS.SetColumn("data_registrazione")
			lb_continue = FALSE
		ELSE
			IF ls_tipo_registro = "IA" OR ls_tipo_registro = "IV" then 
				
				long ll_num_prog, ll_test, ll_reg_id
				date ld_iniz, ld_fine
				setnull(ld_iniz)
				setnull(ld_fine)
				ll_test=this.GetItemNumber(ll_CurrRow, "num_progressivo")
				select max(num_progressivo)
				into :ll_num_prog
				from reg_pd r, registro g
				where r.id_registro=g.id_registro and g.tipo_registro=:ls_tipo_registro and r.num_progressivo<:ll_test and r.data_registrazione>:ld_data_inizio and r.data_registrazione<:ld_data_fine;
				select data_registrazione
				into  :ld_iniz
				from reg_pd r, registro g
				where r.id_registro=g.id_registro and g.tipo_registro=:ls_tipo_registro  and r.data_registrazione>:ld_data_inizio and r.data_registrazione<:ld_data_fine and r.num_progressivo=:ll_num_prog;
				select min(num_progressivo)
				into :ll_num_prog
				from reg_pd r, registro g
				where r.id_registro=g.id_registro and g.tipo_registro=:ls_tipo_registro and r.num_progressivo>:ll_test and r.data_registrazione>:ld_data_inizio and r.data_registrazione<:ld_data_fine;
				select data_registrazione
				into  :ld_fine
				from reg_pd r, registro g
				where r.id_registro=g.id_registro and g.tipo_registro=:ls_tipo_registro  and r.data_registrazione>:ld_data_inizio and r.data_registrazione<:ld_data_fine and num_progressivo=:ll_num_prog;

				if ld_iniz<ld_data_inizio then ld_iniz=ld_data_inizio
				if isnull(ld_fine) or ld_fine>ld_data_fine then	ld_fine=ld_data_fine
				if date(data)>ld_fine then 
					ll_test=messagebox('Attenzione',"La data è modificabile all'interno del periodo compreso tra il "+string(ld_iniz) +" e il " +string(ld_fine) +"~r~nPremere OK per mantenere la data inserita generando un nuovo numero di registrazione,"+&
					"~r~naltrimenti annulla per reinserire la data!",Information!, OKCancel!)
					if  ll_test=2 then
						Post Function uf_ripristina_data(ll_CurrRow)
						return 2
					else	
			  
						uf_riproponi_num_reg_pd()
					end if
				
				else
					if date(data)<ld_iniz then 
						messagebox('Attenzione',"La data è modificabile all'interno del periodo compreso tra il "+string(ld_iniz) +" e il " +string(ld_fine))
						Post Function uf_ripristina_data(ll_CurrRow)
						return 2
					end if
				end if	
				
			END IF
			THIS.SetItem(row, "data_competenza", date(data))
		END IF
		select ultima_data
		into :ld_control1
		from contatori_registri
		where id_registro=:ll_id_registro;
		
		select ultima_data
		into :ld_control2
		from contatori_registri
		where tipologia='PN';
		
		if date(data)<=ld_control1 or date(data)<=ld_control2 then
			messagebox('Impossibile proseguire', 'La data già stampata su bollato')
         setnull(ld_control2)
			post setitem(row,'data_registrazione',ld_control2)
			post SetColumn('data_registrazione')
		end if		

	CASE "num_documento"
		uf_controlla_esistente_iva()
	CASE "data_documento"
		ls_tipo_registro = THIS.GetItemString(ll_CurrRow, "tipo_registro")
		IF ls_tipo_registro = "IV" then 
			uf_riproponi_num_documento()
		END IF
		uf_controlla_esistente_iva()
	CASE "conto_codice"
		ls_test='@S'
		ll_id_prof_registrazione = THIS.GetItemNumber(THIS.GetRow(), "id_prof_registrazione")
		ls_data = data
		SELECT "dba"."prof_mov_contabile"."filtro_conto"
			INTO :ls_filtro_conto
			FROM "dba"."prof_mov_contabile"
			WHERE "dba"."prof_mov_contabile"."id_prof_registrazione" = :ll_id_prof_registrazione AND
				   "dba"."prof_mov_contabile"."num_riga" = 1;

		CHOOSE CASE SQLCA.SQLCode
			CASE -1
				MessageBox("Errore sul Database", "dw_reg_pd_pn_ff / itemchanged / 1")
				RETURN 1
			CASE 0
				IF NOT IsNull(ls_filtro_conto) THEN
					IF (Pos(data, ls_filtro_conto) = 0) OR (Pos(ls_filtro_conto, data) = 0) THEN
						
						THIS.SetItem(THIS.GetRow(), "conto_codice", ls_filtro_conto)
						
						THIS.AcceptText()
						ls_data = ls_filtro_conto
						data = ls_filtro_conto
						
						
						
					END IF
				END IF
		END CHOOSE

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_codice"
		ls_dwc[2] = "conto_descrizione"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", ls_data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			uf_controlla_esistente_iva()
			
			
		END IF
	CASE "conto_descrizione"
		ls_test='@S'
		

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_codice"
		ls_dwc[2] = "conto_descrizione"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			uf_controlla_esistente_iva()
			
			
		END IF
	CASE "id_valuta_cod", "id_valuta_des"
		Post Event ue_assegna_cambio()
		
		if long(data)=il_lire then
			dw_reg_pd_pn_ff.SetFormat('importo', '#,0')
			dw_reg_pd_pn_ff.SetFormat('reg_pd_imp_valuta', '#,0')
		else	
			dw_reg_pd_pn_ff.SetFormat('importo', '#,0.00')
			dw_reg_pd_pn_ff.SetFormat('reg_pd_imp_valuta', '#,0.00')
		end if
		
	CASE "importo", "reg_pd_imp_valuta"
		THIS.Event Post ue_assegna_imp_doc()

END CHOOSE

string ls_descrizione,ls_num_doc
date ld_data_doc
choose case dwo.name
	CASE "data_documento"
		ls_test='@D'
		if Pos ( is_chiocciola,'@D',1)>0 and Pos(this.getitemstring(1,"descrizione"),'@',1)=0 then
			this.setitem(1,"descrizione",is_chiocciola)
			post uf_componi_descrizione()
		else	
			if is_chiocciola='' or  isnull(is_chiocciola) then
			ls_descrizione=this.getitemstring(1,"descrizione")
			if isnull(ls_descrizione) or left(ls_descrizione,5)="Fatt." or left(ls_descrizione,6)="Nota C" then
				ls_num_doc=this.getitemstring(1,"num_documento")
				
				if not isnull(ls_num_doc) and not isnull(data) then
					ls_descrizione=getitemstring(1, "reg_pd_tipo_fattura")
					if ls_descrizione='N' then
						ls_descrizione="Fatt. n° "+ls_num_doc+" del "+data
					elseif ls_descrizione='C' then
					
						ls_descrizione="Nota Cred. n° "+ls_num_doc+" del "+data
					else
						ls_descrizione="Nota Debito n° "+ls_num_doc+" del "+data
					end if
					
					this.setitem(1,"descrizione",ls_descrizione)
				end if
			end if	
			end if
		end if
		
	CASE "num_documento" 
		ls_test='@N'
		if Pos ( is_chiocciola,'@N',1)>0 and Pos(this.getitemstring(1,"descrizione"),'@',1)=0 then
			this.setitem(1,"descrizione",is_chiocciola)
			post uf_componi_descrizione()
		else	
			if is_chiocciola='' or  isnull(is_chiocciola) then
			ls_descrizione=this.getitemstring(1,"descrizione")
			if isnull(ls_descrizione) or left(ls_descrizione,5)="Fatt." or left(ls_descrizione,6)="Nota C" then
				
				ld_data_doc=this.getitemdate(1,"data_documento")
				if not isnull(data) and not isnull(ld_data_doc) then
					ls_descrizione=getitemstring(1, "reg_pd_tipo_fattura")
					if ls_descrizione='N' then
						ls_descrizione="Fatt. n° "+data+" del "+string(ld_data_doc,'dd/mm/yyyy')
					elseif ls_descrizione='C' then
					
						ls_descrizione="Nota Cred. n° "+data+" del "+string(ld_data_doc,'dd/mm/yyyy')
					else
						ls_descrizione="Nota Debito n° "+data+" del "+string(ld_data_doc,'dd/mm/yyyy')
					end if
					
					this.setitem(1,"descrizione",ls_descrizione)
				end if
			end if
			end if
		end if	
	
	CASE "data_registrazione"
		ls_test='@R'
		if Pos ( is_chiocciola,'@R',1)>0 and Pos(this.getitemstring(1,"descrizione"),'@',1)=0 then
			this.setitem(1,"descrizione",is_chiocciola)
			post uf_componi_descrizione()
		end if	
		
	CASE "data_competenza" 
		ls_test='@C'
		if Pos ( is_chiocciola,'@C',1)>0 and Pos(this.getitemstring(1,"descrizione"),'@',1)=0 then
			this.setitem(1,"descrizione",is_chiocciola)
			post uf_componi_descrizione()
		end if	
	
	CASE "conto_descrizione", "conto_codice"
		if Pos ( is_chiocciola,'@F',1)>0 and Pos(this.getitemstring(1,"descrizione"),'@',1)=0 then
			this.setitem(1,"descrizione",is_chiocciola)
			post uf_componi_descrizione()
		end if	
		
end choose	

if tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()>0 and not isnull(ls_test) then
	post uf_test_des_mov(ls_test)
end if	





end event

event ue_retrieve;call super::ue_retrieve;

long ll_CurrRow, ll_IDRegistro
string ls_tipo_registro 
decimal ldc_importo

dwItemStatus l_status

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	ll_IDRegistro = THIS.GetItemNumber(ll_CurrRow, "id_registro")
		
		
		
		ls_tipo_registro = THIS.GetItemString(ll_CurrRow, "tipo_registro")
		
		
		is_tipo_registro = ls_tipo_registro
		
		THIS.SetItem(ll_CurrRow, "tipo_registro", ls_tipo_registro)
		IF ls_tipo_registro = "IA" OR ls_tipo_registro = "IV" OR ls_tipo_registro = "IC" THEN
			Post Function uf_abilita_controlli_iva(TRUE)
		ELSE
			Post Function uf_abilita_controlli_iva(FALSE)
		END IF

	
	
	THIS.EVENT Post ue_assegna_imp_doc()

	l_status = THIS.GetItemStatus(ll_CurrRow, 0, Primary!)

	IF l_status = NotModified! OR l_status = DataModified! THEN
		uf_DisplayOnly(THIS, "esercizio_id_esercizio", TRUE)
		uf_DisplayOnly(THIS, "registro_descrizione", TRUE)
		uf_DisplayOnly(THIS, "num_progressivo", TRUE)
	END IF

	dw_reg_pd_pn_ff.SetItem(ll_CurrRow, "cinfo_sc", uf_visualizza_info_sc())
END IF
end event

event ue_set_search;

long ll_IDProf_Registrazione, ll_IDConto_Prof_Mov_Contab, ll_Cod_Mastro_Cli, ll_Cod_Mastro_For
long ll_IDRegistro, ll_id_esercizio
string ls_tipo_registrazione, ls_filtro, ls_filtro_conto, ls_conto_codice, ls_conto_descrizione, ls_tipo_registro, ls_Parametro
string ls_ges_intra
dwItemStatus l_status

CONSTANT STRING LCS_USO_FORNITORI = "F"
CONSTANT STRING LCS_USO_CLIENTI = "C"

ls_Parametro = trim(THIS.is_list.s_win_parametri)

CHOOSE CASE as_nomecol
	CASE "prof_registrazione_codice", "prof_registrazione_descrizione"
		is_search_window = "w_prof_registrazione_sw"

		IF as_nomecol = "prof_registrazione_codice" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "prof_registrazione_descrizione" THEN
			is_ricpar.s_filter_value = uf_get_colval("prof_registrazione_descrizione")
			is_ricpar.s_filter_name = "descrizione"
		END IF

		is_ricpar.b_imm_retrieve = TRUE

		CHOOSE CASE ls_parametro
			CASE "PN"
				ls_filtro = "tipo_registrazione ='P'"
			CASE "MN"
				ls_filtro = "tipo_registrazione ='M'"
			CASE "PM"
				ls_filtro = "tipo_registrazione ='P' OR tipo_registrazione ='M'"
			CASE "IA"
				ls_filtro = "tipo_registrazione ='A'"
			CASE "IV"
				ls_filtro = "tipo_registrazione ='V'"
			CASE "AV"
				ls_filtro = "tipo_registrazione ='A' OR tipo_registrazione ='V'"
			CASE ELSE
				ls_filtro = ""
		END CHOOSE

		is_ricpar.s_SQL_cond = ls_filtro

	CASE "registro_descrizione"
		is_search_window = "w_registro_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "registro_descrizione"
		is_ricpar.b_imm_retrieve  = TRUE
  		ll_IDProf_Registrazione = THIS.GetItemNumber(THIS.GetRow(), "id_prof_registrazione")
		ll_id_esercizio = THIS.GetItemNumber(THIS.GetRow(), "esercizio_id_esercizio")

		SELECT "dba"."prof_registrazione"."tipo_registrazione"
			INTO :ls_tipo_registrazione
			FROM "dba"."prof_registrazione"
			WHERE "dba"."prof_registrazione"."id_prof_registrazione" = :ll_IDProf_Registrazione;

		IF SQLCA.SQLCode < 0 THEN
			MessageBox("Errore sul Database", "dw_reg_pd_pn_ff / ue_set_search / 1")
			RETURN
		END IF

		CHOOSE CASE ls_tipo_registrazione
			CASE "P"
				ls_filtro = "tipo_registro = 'PN' AND id_esercizio = " + string(ll_id_esercizio)
			CASE "M"
				ls_filtro = "tipo_registro = 'MN' AND id_esercizio = " + string(ll_id_esercizio)
			CASE "A"
				ls_filtro = "tipo_registro = 'IA' AND id_esercizio = " + string(ll_id_esercizio)
			CASE "V"
				ls_filtro = "tipo_registro = 'IV' AND id_esercizio = " + string(ll_id_esercizio)
			CASE ELSE
				ls_filtro = "id_esercizio = " + string(ll_id_esercizio)
		END CHOOSE

		is_ricpar.s_SQL_cond = ls_filtro

	CASE "conto_codice", "conto_descrizione"
		
		
		
      is_search_window = "w_conti_pd_sw"
		

		IF as_nomecol = "conto_codice" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "conto_descrizione" THEN
			is_ricpar.s_filter_value = as_valcol
			if dw_reg_pd_pn_ff.object.t_descrizione.text="Descrizione" then
				is_ricpar.s_filter_name = "conto_descrizione"
			else
				is_ricpar.s_filter_name = "anagrafica_par_iva"
			end if
		END IF
		is_ricpar.b_imm_retrieve = TRUE

		
		ll_IDProf_Registrazione = THIS.GetItemNumber(THIS.GetRow(), "id_prof_registrazione")
		SELECT "dba"."prof_mov_contabile"."id_conto", "dba"."prof_mov_contabile"."filtro_conto", 
		"dba"."prof_registrazione"."ges_oper_intracomunitarie"
			INTO :ll_IDConto_Prof_Mov_Contab, :ls_filtro_conto, :ls_ges_intra
			FROM "dba"."prof_mov_contabile", "dba"."prof_registrazione"
			WHERE "dba"."prof_mov_contabile"."id_prof_registrazione" ="dba"."prof_registrazione"."id_prof_registrazione" and
			"dba"."prof_mov_contabile"."id_prof_registrazione" = :ll_IDProf_Registrazione AND
				"dba"."prof_mov_contabile"."num_riga" = 1;

		CHOOSE CASE SQLCA.SQLCode
			CASE -1
				MessageBox("Errore sul Database", "dw_reg_pd_pn_ff / ue_set_search / 2")
				RETURN
			CASE 0
				
				
				IF NOT IsNull(ls_filtro_conto) THEN
					
					
					
					ls_filtro = "left(conto_azienda.codice," + string(len(ls_filtro_conto)) + ") = '" + ls_filtro_conto + "'"
					
					is_ricpar.s_SQL_cond = ls_filtro
				ELSE
					ll_IDRegistro = THIS.GetItemNumber(THIS.GetRow(), "id_registro")

					
					SELECT "registro"."tipo_registro"
						INTO :ls_tipo_registro
						FROM "registro"
						WHERE "registro"."id_registro" = :ll_IDRegistro;

					
					IF ls_tipo_registro = "IA" THEN
						
						ls_filtro = "sottomastro.uso = '" + LCS_USO_FORNITORI + "'"
						is_ricpar.s_SQL_cond = ls_filtro
					ELSEIF ls_tipo_registro = "IV" or ls_tipo_registro='IC' THEN
						if ls_ges_intra<>'S' then
							ls_filtro = "sottomastro.uso = '" + LCS_USO_CLIENTI + "'"
							
						else
							ls_filtro = "sottomastro.uso = 'C' or sottomastro.uso = 'F'"
						end if
						is_ricpar.s_SQL_cond = ls_filtro
					END IF

				END IF

			CASE ELSE

		END CHOOSE

END CHOOSE

CHOOSE CASE as_nomecol

	CASE "id_valuta_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_des"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
	CASE "id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_cod"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861

	CASE "descrizione"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_des_contabile_gd"
		is_ricpar.s_titolo_finestra = "Descrizioni Contabili"

END CHOOSE
end event

event ue_use_search;
long ll_riga
string ls_conto
long ll_CurrRow_Reg_PD
string ls_tipo_registro
dwItemStatus l_status

integer i
string ls_des, ls_des2

ll_CurrRow_Reg_PD = THIS.GetRow()
l_status = THIS.GetItemStatus(ll_CurrRow_Reg_PD, 0, Primary!)

CHOOSE CASE as_nomecol
	CASE "prof_registrazione_codice"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])

		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_descrizione", is_ricpar.s_ausil_value[1])

		
		
		IF l_status = New! OR l_status = NewModified! THEN
			uf_Set_ColVal("registro_descrizione", u_freddie.gs_Null)
			uf_Set_ColVal("id_registro", u_freddie.gs_Null)
			uf_Set_ColVal("cinfo_registro", u_freddie.gs_Null)
			uf_Set_ColVal("num_progressivo", u_freddie.gs_Null)
			uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
			uf_Set_ColVal("data_competenza", u_freddie.gs_Null)
			uf_Set_ColVal("num_documento", u_freddie.gs_Null)
			uf_Set_ColVal("data_documento", u_freddie.gs_Null)
			uf_Set_ColVal("descrizione", u_freddie.gs_Null)


			
		END IF
			uf_Assegna_Tipo_Fattura(long(is_ricpar.s_id_seg_value[1]))
		
		uf_proponi_default()

		
		uf_attiva_insoluti(long(is_ricpar.s_id_seg_value[1]))
		

	
	CASE "prof_registrazione_descrizione"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])

		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_codice", is_ricpar.s_ausil_value[1])

		
		
		IF l_status = New! OR l_status = NewModified! THEN
			uf_Set_ColVal("registro_descrizione", u_freddie.gs_Null)
			uf_Set_ColVal("id_registro", u_freddie.gs_Null)
			uf_Set_ColVal("cinfo_registro", u_freddie.gs_Null)
			uf_Set_ColVal("num_progressivo", u_freddie.gs_Null)
			uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
			uf_Set_ColVal("data_competenza", u_freddie.gs_Null)
			uf_Set_ColVal("num_documento", u_freddie.gs_Null)
			uf_Set_ColVal("data_documento", u_freddie.gs_Null)
			uf_Set_ColVal("descrizione", u_freddie.gs_Null)
		END IF

		uf_Assegna_Tipo_Fattura(long(is_ricpar.s_id_seg_value[1]))

		
		uf_proponi_default()

		
		uf_attiva_insoluti(long(is_ricpar.s_id_seg_value[1]))
		
	CASE "registro_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("registro_id_registro", is_ricpar.s_id_seg_value[1])
		
		is_tipo_registro = is_ricpar.s_ausil_value[2]

		uf_set_colval("cinfo_registro", "Tipo: " + string(is_ricpar.s_ausil_value[2]) + " - " + &
												  "Numero: " + string(is_ricpar.s_ausil_value[3]))

		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])

		
		
		IF l_status = New! OR l_status = NewModified! THEN
			uf_Set_ColVal("num_progressivo", u_freddie.gs_Null)
			uf_Set_ColVal("data_registrazione", u_freddie.gs_Null)
			uf_Set_ColVal("data_competenza", u_freddie.gs_Null)
			uf_Set_ColVal("num_documento", u_freddie.gs_Null)
			uf_Set_ColVal("data_documento", u_freddie.gs_Null)
		END IF
		
		uf_controlla_esistente_iva()
	CASE "conto_codice"
		ls_des2=is_ricpar.s_main_value+' '+is_ricpar.s_ausil_value[1]
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("conto_id_conto", is_ricpar.s_id_seg_value[1])
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow_Reg_PD, "cinfo_sc", uf_visualizza_info_sc())
		uf_controlla_esistente_iva()
		
		
		
		if (not isnull(il_conto_old)) and (long(is_ricpar.s_id_seg_value[1])<>il_conto_old) then
			ls_conto=string(il_conto_old)
			ll_riga=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.find &
			("id_conto="+ls_conto,1, &
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount())
			if ll_riga>0 then
				il_conto_old=long(is_ricpar.s_id_seg_value[1])
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(ll_riga,"conto_codice",is_ricpar.s_main_value)				
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(ll_riga,"conto_descrizione",is_ricpar.s_ausil_value[1])				
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(ll_riga,"id_conto",il_conto_old)				
			end if
		end if
		
	CASE "conto_descrizione"
		ls_des2=is_ricpar.s_ausil_value[1]+' '+is_ricpar.s_main_value
		
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_codice", is_ricpar.s_ausil_value[1])
		uf_set_colval("conto_id_conto", is_ricpar.s_id_seg_value[1])
		dw_reg_pd_pn_ff.SetItem(ll_CurrRow_Reg_PD, "cinfo_sc", uf_visualizza_info_sc())
		uf_controlla_esistente_iva()
		
		
		
		if (not isnull(il_conto_old)) and (long(is_ricpar.s_id_seg_value[1])<>il_conto_old) then
			ls_conto=string(il_conto_old)
			ll_riga=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.find &
			("id_conto="+ls_conto,1, &
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount())
			if ll_riga>0 then
				il_conto_old=long(is_ricpar.s_id_seg_value[1])
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(ll_riga,"conto_descrizione",is_ricpar.s_main_value)				
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(ll_riga,"conto_codice",is_ricpar.s_ausil_value[1])				
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(ll_riga,"id_conto",il_conto_old)				
			end if
		end if
		
		
		CASE "conto_descrizione", "conto_codice"
		if Pos ( is_chiocciola,'@F',1)>0 and Pos(this.getitemstring(1,"descrizione"),'@',1)=0 then
			this.setitem(1,"descrizione",is_chiocciola)
			post uf_componi_descrizione()
			
			if tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()>0 then
			ls_des=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemstring(i,'chiocciola')
			for i=1 to tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount() 
					if isnull(ls_des) then	
						tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(i,'mov_contabile_des_contabile',ls_des2)
					end if	
			next
			end if
		end if	
		
END CHOOSE



if (as_nomecol="conto_codice") or (as_nomecol="conto_descrizione") then
	long ll_id_par,ll_id_reg
	ll_id_reg=this.getitemnumber(1,"id_reg_pd")
	update par_aperta
	set id_conto=:is_ricpar.s_id_seg_value[1]
	where id_reg_pd=:ll_id_reg;
	commit;
end if


end event

event rowfocuschanged;call super::rowfocuschanged;

long ll_CurrRow
decimal ldc_importo

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	ldc_importo = THIS.uf_GetItemDecimal(ll_CurrRow, "reg_pd_imp_valuta")
	THIS.EVENT Post ue_assegna_imp_doc()
END IF

end event

event editchanged;

integer li_RetVal , ll_pos, ll_pos1
long ll_imp
string ls_null
setnull(ls_null)

CHOOSE CASE dwo.name
	CASE "importo"
		
		THIS.Event Post ue_assegna_imp_doc()

	CASE "reg_pd_imp_valuta"
		
      if il_lire=dw_reg_pd_pn_ff.getitemnumber(1,'id_valuta_cod') then
			ll_pos=pos(data,',')
			ll_pos1=pos(data,',00')
			if ll_pos>0 and ll_pos1=0 then
				if ll_pos>1 then
					ll_imp=long(left(data,ll_pos - 1))
				else 
					ll_imp=0
				end if	
				messagebox('Attenzione','In valuta lire non è possibile inserire cifre decimali')
				this.post setitem(1,'reg_pd_imp_valuta',ll_imp)
				return 2
			end if
		end if
		
		Event ue_Calcola_Imp_Lire()
		THIS.Event Post ue_assegna_imp_doc()
		THIS.Event Post ue_assegna_righe_1_9999(data)
	
	CASE "num_documento"
		if len(data)>12 then 
			messagebox('Attenzione','Il numero documento non può essere formato da un numero di caratteri~r~nsuperiore a 12!')
			dw_reg_pd_pn_ff.setitem(row,"num_documento",ls_null)
		end if
	


END CHOOSE
end event

event doubleclicked;call super::doubleclicked;

uf_accedi_protetti(dwo.name)

if dwo.name="t_descrizione" then
	if dw_reg_pd_pn_ff.object.t_descrizione.text="Descrizione" then 
		dw_reg_pd_pn_ff.object.t_descrizione.text="Par. IVA"
	else
		dw_reg_pd_pn_ff.object.t_descrizione.text="Descrizione"
	end if
end if
end event

event ue_update;


long ll_IDProf_Registrazione, ll_CurrRow, ll_IDWizard, ll_num_ordine, ll_id_registro
long ll_num_progressivo, ll_new_num_progressivo, ll_id_reg_pd
integer li_retVal
string ls_nome_window, ls_cod_wizard, ls_descr_registro,ls_prog_scritture
date ld_data_registrazione
char lc_insoluti
dwItemStatus ldwis_status

ll_CurrRow = THIS.GetRow()


IF (ll_CurrRow > 0) AND (uf_convalida_salvataggio() = TRUE) THEN
   ll_IDProf_Registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
	IF ll_IDProf_Registrazione > 0 THEN
		 DECLARE lcur_wizard CURSOR FOR
		  SELECT "wizard"."id_wizard",
		  			"wizard"."nome_window",
		  			"wizard"."codice",
					"wiz_profilo"."num_ordine"
			 FROM "wiz_profilo",
					"wizard"
			WHERE ( "wizard"."id_wizard" = "wiz_profilo"."id_wizard" ) and
					( ( "wiz_profilo"."id_prof_registrazione" = :ll_IDProf_Registrazione ) )
		ORDER BY "wiz_profilo"."num_ordine" ASC  ;

		OPEN lcur_wizard;

		
		FETCH lcur_wizard INTO :ll_IDWizard, :ls_nome_window, :ls_cod_wizard, :ll_num_ordine;

		
		DO WHILE SQLCA.SQLCode = 0
			
			

			FETCH lcur_wizard INTO :ll_IDWizard, :ls_nome_window, :ls_cod_wizard, :ll_num_ordine;
		LOOP

		CLOSE lcur_wizard;

	END IF

	
	ldwis_status = THIS.GetItemStatus(ll_CurrRow, 0, Primary!)
	IF ldwis_status = New! OR ldwis_status = NewModified! THEN
		ll_id_registro = THIS.GetItemNumber(ll_CurrRow, "id_registro")
		ll_num_progressivo = THIS.GetItemNumber(ll_CurrRow, "num_progressivo")
		ld_data_registrazione = THIS.GetItemDate(ll_CurrRow, "data_registrazione")
		  SELECT "reg_pd"."id_reg_pd"
			 INTO :ll_id_reg_pd
			 FROM "reg_pd"
			WHERE ( "reg_pd"."id_registro" = :ll_id_registro ) AND
					( "reg_pd"."num_progressivo" = :ll_num_progressivo ) AND
					( "reg_pd"."data_registrazione" = :ld_data_registrazione )   ;
		CHOOSE CASE SQLCA.SQLCode
			CASE 0
			   SELECT "registro"."descrizione"
				  INTO :ls_descr_registro
				  FROM "registro"
				 WHERE "registro"."id_registro" = :ll_id_registro   ;
				
				select esercizio.prog_scritture
				into :ls_prog_scritture
				from registro,esercizio
				where registro.id_esercizio=esercizio.id_esercizio
				and registro.id_registro = :ll_id_registro;
				
				ll_new_num_progressivo = f_proponi_num_reg_pd(ll_id_registro,ls_prog_scritture)
				THIS.SetItem(ll_CurrRow, "num_progressivo", ll_new_num_progressivo)
				MessageBox("Registrazioni Contabili","Esiste già una registrazione numero " + &
					string(ll_num_progressivo) + " con data " + string(ld_data_registrazione) + &
					"~rnel registro " + string(ls_descr_registro) + &
					". Il nuovo numero progressivo attribuito è " + string(ll_new_num_progressivo) + ".")
			CASE -1
				MessageBox("Errore sul DataBase","w_reg_pd_cx / dw_reg_pd_pn_ff / ue_update / 1")
				RETURN
		END CHOOSE
	END IF

	li_RetVal = super::EVENT ue_update(wparam, lparam)
	RETURN li_RetVal
END IF
end event

event ue_keystop;

end event

event losefocus;call super::losefocus;

long ll_CurrRow, ll_IDProf_Registrazione, ll_IDWizard, ll_num_ordine
string ls_cod_wizard
integer li_RetVal
dwItemStatus lis_status

ll_CurrRow = dw_reg_pd_pn_ff.GetRow()
lis_status = THIS.GetItemStatus(ll_CurrRow, 0, Primary!)

CHOOSE CASE is_item_precedente
	CASE "reg_pd_imp_valuta", "descrizione"
		ll_IDProf_Registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
		IF ll_IDProf_Registrazione > 0 THEN
			 DECLARE lcur_wizard CURSOR FOR
			  SELECT "wizard"."id_wizard",
						"wizard"."codice",
						"wiz_profilo"."num_ordine"
				 FROM "wiz_profilo",
						"wizard"
				WHERE ( "wizard"."id_wizard" = "wiz_profilo"."id_wizard" ) and
						( ( "wiz_profilo"."id_prof_registrazione" = :ll_IDProf_Registrazione ) )
			ORDER BY "wiz_profilo"."num_ordine" ASC  ;
	
	
			OPEN lcur_wizard;
	
			
			FETCH lcur_wizard INTO :ll_IDWizard, :ls_cod_wizard, :ll_num_ordine;
	
			
			DO WHILE SQLCA.SQLCode = 0
				CHOOSE CASE ls_cod_wizard
					CASE "IVACEE"
						
						IF lis_status = New! OR lis_status = NewModified! THEN
							Post Event ue_attiva_imp_fat_cee()
							
						END IF
				END CHOOSE
	
				FETCH lcur_wizard INTO :ll_IDWizard, :ls_cod_wizard, :ll_num_ordine;
	
			LOOP
	
			CLOSE lcur_wizard;
	
		END IF
		

		
END CHOOSE
end event

event retrieveend;

long ll_CurrRow, ll_IDReg_PD_Padre, ll_id_esercizio, ll_id_reg
date ldt_data_competenza, ldt_ult_data, ldt_ult_data_reg
string ls_tipo_reg

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	
	select id_val_lire
	into :il_lire
	from par_sistema
	;
	ll_valuta_reg_pd=THIS.GetItemNumber(ll_CurrRow, "id_valuta_cod")

	
	ll_IDReg_PD_Padre = THIS.GetItemNumber(ll_CurrRow, "reg_pd_id_reg_pd_padre")

	IF NOT IsNull(ll_IDReg_PD_Padre) THEN
		THIS.Enabled = FALSE
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.Enabled = FALSE
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.Enabled = FALSE
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.Enabled = FALSE
	END IF
END IF

IF ll_CurrRow > 0 THEN
	ll_IDReg_PD_Padre = THIS.GetItemNumber(ll_CurrRow, "id_reg_pd")
	IF NOT IsNull(ll_IDReg_PD_Padre) THEN
		ll_id_esercizio=getitemnumber(1, "esercizio_id_esercizio")
		ldt_data_competenza=getitemdate(1, "data_competenza")
		ll_id_reg=getitemnumber(1, "id_registro")
		ls_tipo_reg=getitemstring(1, "tipo_registro")
		
		
		select ult_data_stampa_bollato
		into :ldt_ult_data
		from esercizio
		where id_esercizio=:ll_id_esercizio;
		
			select max(ultima_data)
			into :ldt_ult_data_reg
			from contatori_registri , azienda
			where id_esercizio=:ll_id_esercizio
			and id_registro=0
			and tipologia=:ls_tipo_reg
			and azienda.id_azienda=1;
		if sqlca.sqlcode<>0 then
			select  ultima_data
			into :ldt_ult_data_reg
			from contatori_registri , azienda
			where id_esercizio=:ll_id_esercizio
			and id_registro=:ll_id_reg
			and azienda.id_azienda=1;
		end if
		if ldt_ult_data<ldt_ult_data_reg then ldt_ult_data=ldt_ult_data_reg
			
		
		if ldt_ult_data>=ldt_data_competenza then
				messagebox("Attenzione!", "Scrittura già stampata in bollato!")
		
		
		
		else
			
			
		end if
	end if
end if


end event

event ue_insert;call super::ue_insert;

long ll_CurrRow
ll_CurrRow = THIS.GetRow()

ib_Inserimento = TRUE
THIS.SetItem(ll_CurrRow, "esercizio_id_esercizio", il_esercizio)

IF (il_id_ultimo_profilo > 0) AND (cbx_retain.Checked = TRUE) THEN
	THIS.SetItem(ll_CurrRow, "id_prof_registrazione", il_id_ultimo_profilo)
	THIS.SetItem(ll_CurrRow, "prof_registrazione_codice", is_cod_ultimo_profilo)
	THIS.SetItem(ll_CurrRow, "prof_registrazione_descrizione", is_des_ultimo_profilo)
	uf_proponi_default()
	THIS.SetItem(ll_CurrRow, "reg_pd_tipo_fattura",is_des_tipo_fatt)
	THIS.SetItem(ll_CurrRow, "reg_pd_segno_reg_iva",id_segno_iva)
	il_id_ultimo_profilo = 0
END IF
end event

event ue_delete;long ll_CurrRow, ll_IDReg_PD, ll_RetVal, ll_id_registro, ll_num_prog, ll_par_aperta, ll_emp_aperte[], ll_mov_partita, ll_emp_reg[], ll_scad[], ll_test,ll_apri_par[], ll_scad2, ll_profilo
integer li_RetVal, i, j, k, h, f, z, li_test
long li_insoluti
string LS_QUOTA_RAT_RIS, LS_STORNO, STATO, ll_num, ls_data_reg, stato_reg_iva, liquidazione, ls_control, ls_test
date ld_data, ldt_data_reg
decimal ld_importo

ll_CurrRow = THIS.GetRow()
if ll_CurrRow>0 then
	ll_id_registro=getitemnumber(ll_CurrRow, "id_registro")
	ldt_data_reg=getitemdate(ll_CurrRow, "data_registrazione")
	ll_num_prog=getitemnumber(ll_CurrRow, "num_progressivo")
	ll_profilo=getitemnumber(ll_CurrRow, "id_prof_registrazione")
end if

li_insoluti=0
select usa_insoluti
into :ls_test
from prof_registrazione
where id_prof_registrazione=:ll_profilo;
if ls_test='S' then li_insoluti=1

li_RetVal = MessageBox("Registrazioni Prima Nota","Confermi l'eliminazione della registrazione?", Question!, YesNo!, 2)

IF ll_CurrRow > 0 AND li_RetVal = 1 THEN
	ll_IDReg_PD = THIS.GetItemNumber(ll_CurrRow, "id_reg_pd")
	
		
	SELECT st_stampa_bollato, num_progressivo
	INTO :stato, :ll_num
	FROM reg_pd
	WHERE id_reg_pd = :ll_idreg_pd;
	
	
	SELECT st_reg_iva, num_progressivo, st_liquidazione
	INTO :stato_reg_iva, :ll_num, :liquidazione
	FROM reg_pd
	WHERE id_reg_pd = :ll_idreg_pd;

	IF	stato <> "N" THEN
			MESSAGEBOX ('Attenzione','La scrittura N. ' + ll_num  + '  è stampata su Bollato')
	ELSE	
		IF stato_reg_iva <> "N" or liquidazione <> "N" then
			messagebox ('Attenzione','La scrittura N. ' + ll_num  + '  è stampata sui Registri o in Liquidazione')
		ELSE
			select id_par_aperta_padre
				into :ll_par_aperta
				from par_aperta
				where id_reg_pd = :ll_IDReg_PD;
	
			if sqlca.sqlcode = 0 then
				delete from mov_partita where id_par_aperta = :ll_par_aperta;
				commit;
			end if
			
			
			
			
			
			
			
			
			
			if ll_IDReg_PD>0 then
				
				   k=1
					DECLARE cur_reg CURSOR FOR
					SELECT id_mov_partita
					FROM mov_partita
					WHERE id_reg_pd=:ll_IDReg_PD;
					
					OPEN cur_reg;
					FETCH cur_reg INTO :ll_emp_reg[k];	
				
					DO WHILE SQLCA.SQLCode = 0
						k=K+1
						FETCH cur_reg INTO :ll_emp_reg[k];
	   			LOOP
				
					Z=1
					
					for h=1 to (k -1)
					   i=1	
						DECLARE cur_apri_par CURSOR FOR
			   		SELECT id_par_aperta
						FROM mov_partita
						WHERE id_mov_partita=:ll_emp_reg[h];
				
						OPEN cur_apri_par;
						FETCH cur_apri_par INTO :ll_emp_aperte[i];
                  ll_apri_par[z]=ll_emp_aperte[i]
						DO WHILE SQLCA.SQLCode = 0
							i=i+1
							z=z+1
							FETCH cur_apri_par INTO :ll_emp_aperte[i];
							ll_apri_par[z]=ll_emp_aperte[i]
	   				LOOP
		            
						close cur_apri_par;
					next	

					
					
					
					long ll_id_prof,ll_id_prof_sistema
					long ll_reg_sosp

					select id_prof_risc_fat_sos
					into :ll_id_prof_sistema
					from par_sistema;
					
					ll_id_prof=dw_reg_pd_pn_ff.getitemnumber(1,"id_prof_registrazione")
					if ll_id_prof_sistema=ll_id_prof then  
						FOR i=1 TO z - 1
								select id_reg_pd into :ll_reg_sosp from par_aperta where id_par_aperta=:ll_apri_par[i];
								if ll_reg_sosp>0 then
									update reg_pd set data_comp_liq_iva=null
									where id_reg_pd=:ll_reg_sosp;
									commit;
								end if
						NEXT
					end if
					

					if li_insoluti=1 then
						ll_scad2=uf_insoluti(ll_apri_par[1], ll_idreg_pd)
					else	
					  f=1
					  for h=1 to (k -1)
					     i=1	
						  DECLARE cur_partita CURSOR FOR
			   		  SELECT id_scadenza
						  FROM mov_scadenza
						  WHERE id_mov_partita=:ll_emp_reg[h];
				
						  OPEN cur_partita;
						  FETCH cur_partita INTO :ll_emp_aperte[i];
                    ll_scad[f]=ll_emp_aperte[i]
						  DO WHILE SQLCA.SQLCode = 0
							  i=i+1
							  f=f+1
							  FETCH cur_partita INTO :ll_emp_aperte[i];
							  ll_scad[f]=ll_emp_aperte[i]
	   				  LOOP
		            
						  close cur_partita;
					  next	
				   end if
					
			SQLCA.sp_Elimina_Reg_PD(ll_IDReg_PD, ll_RetVal)
			
			IF ll_RetVal <> 0 THEN
				MessageBox("Registrazioni Contabili", "Impossibile eliminare la registrazione.")
			ELSE 
			  
			  delete mov_partita where id_reg_pd=:ll_IDReg_PD;
			  commit;
			  
			  if li_insoluti=1 then
				     select id_riga_distinta_banca
						into :ll_test
						from scadenza
						where id_scadenza=:ll_scad2;
					  
						
						select importo
						into :ld_importo
						from scadenza 
						where id_scadenza=:ll_scad2;
						update mov_scadenza
				      set importo=:ld_importo
				      where id_scadenza=:ll_scad2;
						commit;
						
						
						select id_scadenza
						into :li_test
						from scadenza
						where id_par_aperta=:ll_apri_par[1] and id_scadenza<>:ll_scad2 and ( esito_pagamento='E' or esito_pagamento='I');  
						if sqlca.sqlcode=100 then
						  update par_aperta
						  set stato='C'
						  where id_par_aperta=:ll_apri_par[1];
					   end if  
				      commit;
						
						 if isnull(ll_test) then
							update scadenza
							set esito_pagamento='E'
							where id_scadenza=:ll_scad2;
							commit;
						else
							update scadenza
							set esito_pagamento='D'
							where id_scadenza=:ll_scad2;
							commit;
						end if
				
			  else
			      for j=1 to ( f	-1 )	
						
						select id_riga_distinta_banca
						into :ll_test
						from scadenza
						where id_scadenza=:ll_scad[j];
					   if isnull(ll_test) then
							update scadenza
							set esito_pagamento='E'
							where id_scadenza=:ll_scad[j];
						else
							update scadenza
							set esito_pagamento='D'
							where id_scadenza=:ll_scad[j];
						end if	
						commit;
				    next
				
				    for j=1 to ( z -1 )
                     
							update par_aperta
							set stato='A'
							where id_par_aperta=:ll_apri_par[j];
				         commit;
				    next			
				end if
			end if	
				
				
				LONG LL_RIF_SCRITTURA
				SELECT QUOTA_RAT_RIS, STORNO
				  INTO :LS_QUOTA_RAT_RIS, :LS_STORNO
				  FROM GES_RATEI_RISCONTI
				  WHERE RIF_SCRITTURA=:ll_IDReg_PD AND
						  (STORNO='S' OR QUOTA_RAT_RIS='S');
				 IF SQLCA.SQLCODE=0 THEN
					 IF LS_QUOTA_RAT_RIS='S' OR LS_STORNO='S' THEN
						 UF_CANCELLA_RISCONTI_STORNI(ll_IDReg_PD)
					 END IF
				 END IF
				
				
				DELETE FROM "ges_ratei_risconti"  
				WHERE "ges_ratei_risconti"."rif_scrittura" = :ll_IDReg_PD   ;
				commit;
				
				
				ls_data_reg=string(ldt_data_reg, "yy/mm/dd")
				update documento
				set contabilizzato='N'
				where documento.id_registro=:ll_ID_Registro
				and   documento.num_progressivo= :ll_num_prog  
				and documento.data_registrazione=date(:ls_data_reg);
				commit;
			END IF
		END IF

	END IF

END IF




end event

event ue_core_update;call super::ue_core_update;


IF ib_attiva_wizard = TRUE THEN 
	uf_attiva_wizard()
END IF



end event

event clicked;

long ll_RetVal
dwItemStatus l_status
	l_status = THIS.GetItemStatus(THIS.GetRow(), 0, Primary!)
	
	IF (l_status <> NotModified!) AND (l_status <> DataModified!) THEN
		ll_RetVal = Super::Event Clicked(xpos, ypos, row, dwo)
		RETURN ll_RetVal
	else
		
		
		
		if (string(dwo.name)='conto_codice_sw') or (string(dwo.name)='conto_descrizione_sw') then
			ll_RetVal = Super::Event Clicked(xpos, ypos, row, dwo)
			RETURN ll_RetVal
		end if
		
	END IF


end event

type p_arrowl from picture within w_reg_pd_cx
boolean visible = false
integer x = 96
integer y = 1088
integer width = 50
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "s:\pb\cometa\arrowl.bmp"
boolean focusrectangle = false
end type

type tab_mov_contabile from tab within w_reg_pd_cx
event selectionchanged pbm_tcnselchanged
event create ( )
event destroy ( )
integer y = 924
integer width = 2752
integer height = 872
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_mov_iva tabpage_mov_iva
tabpage_mov_contabile tabpage_mov_contabile
tabpage_partite_aperte tabpage_partite_aperte
end type

event selectionchanged;integer li_val, li_valuta
select id_valuta into :li_val
from esercizio where id_esercizio=:il_esercizio;


CHOOSE CASE oldindex
	CASE 3
		ib_retrieve_partite = FALSE
	CASE 1
		long ll_righe,i
		decimal {2} ld_imponibile,ld_imposta,ld_tot,ld_app
		ld_tot=dw_reg_pd_pn_ff.getitemnumber(1,"reg_pd_imp_valuta")
		
		ll_righe=tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.rowcount()
		ld_app=0
		FOR i=1 TO ll_righe
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.accepttext()
			ld_imposta=tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.getitemnumber(i,"mov_iva_imposta")
			ld_imponibile=tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.getitemnumber(i,"mov_iva_imponibile")
			ld_app=ld_app+ld_imposta+ld_imponibile
		NEXT

		li_valuta = dw_reg_pd_pn_ff.getitemnumber(1,"id_valuta_cod")
		if li_valuta = li_val then
	 		 if ld_tot<>ld_app then
				messagebox ('Attenzione', 'Importo Valuta diverso da Importo')			
				dw_reg_pd_pn_ff.setitem(1,"reg_pd_imp_valuta",ld_app)
				dw_reg_pd_pn_ff.setitem(1,"importo",ld_app)
				tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.setitem(1,"documento",ld_app)
				ib_askforsave=true
				dw_reg_pd_pn_ff.event trigger ue_update(0,0)
			end if
		end if
END CHOOSE

CHOOSE CASE newindex
	CASE 3
		ib_retrieve_partite = TRUE
		tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.TriggerEvent("ue_retrieve")
END CHOOSE


end event

on tab_mov_contabile.create
this.tabpage_mov_iva=create tabpage_mov_iva
this.tabpage_mov_contabile=create tabpage_mov_contabile
this.tabpage_partite_aperte=create tabpage_partite_aperte
this.Control[]={this.tabpage_mov_iva,&
this.tabpage_mov_contabile,&
this.tabpage_partite_aperte}
end on

on tab_mov_contabile.destroy
destroy(this.tabpage_mov_iva)
destroy(this.tabpage_mov_contabile)
destroy(this.tabpage_partite_aperte)
end on

event selectionchanging;choose case oldindex
	case 1
	   
		if ((newindex=2) or (newindex=3))  and tabpage_mov_iva.dw_mov_iva_ff.rowcount()>0 then
			if tabpage_mov_iva.dw_mov_iva_ff.getitemdecimal(1,'differenza')<>0 then
			  tabpage_mov_iva.dw_mov_iva_gd.setcolumn('mov_iva_imposta')
			  return 1
		   end if  
		end if
end choose
end event

type tabpage_mov_iva from userobject within tab_mov_contabile
event rbuttondown pbm_rbuttondown
integer x = 18
integer y = 104
integer width = 2715
integer height = 752
long backcolor = 79741120
string text = "Sezione IVA"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_mov_iva_gd dw_mov_iva_gd
dw_mov_iva_ff dw_mov_iva_ff
cb_ricalcolo cb_ricalcolo
cb_scorporo cb_scorporo
end type

on tabpage_mov_iva.create
this.dw_mov_iva_gd=create dw_mov_iva_gd
this.dw_mov_iva_ff=create dw_mov_iva_ff
this.cb_ricalcolo=create cb_ricalcolo
this.cb_scorporo=create cb_scorporo
this.Control[]={this.dw_mov_iva_gd,&
this.dw_mov_iva_ff,&
this.cb_ricalcolo,&
this.cb_scorporo}
end on

on tabpage_mov_iva.destroy
destroy(this.dw_mov_iva_gd)
destroy(this.dw_mov_iva_ff)
destroy(this.cb_ricalcolo)
destroy(this.cb_scorporo)
end on

type dw_mov_iva_gd from u_dw_master_main within tabpage_mov_iva
event ue_assegna_totale ( )
event ue_elimina_mov_iva ( )
event ue_proponi_scorporo ( )
event ue_crea_mov_iva_vuote ( )
integer x = 23
integer y = 72
integer width = 2610
integer height = 468
integer taborder = 10
string dataobject = "d_mov_iva_gd"
boolean vscrollbar = true
end type

event ue_assegna_totale;

long ll_CurrRow_Mov_IVA, ll_CurrRow_Mov_IVA_gd
decimal {2} ldc_tot_imponibile, ldc_tot_imposta, ldc_totale, ldc_differenza

ll_CurrRow_Mov_IVA_gd = THIS.GetRow()
ll_CurrRow_Mov_IVA = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.GetRow()

IF (ll_CurrRow_Mov_IVA_gd > 0) THEN 
	ldc_tot_imponibile = THIS.uf_GetItemDecimal(ll_CurrRow_Mov_IVA_gd, "totale_imponibile")
	ldc_tot_imposta = THIS.uf_GetItemDecimal(ll_CurrRow_Mov_IVA_gd, "totale_imposta")

	ldc_totale = ldc_tot_imponibile + ldc_tot_imposta

	IF ll_CurrRow_Mov_IVA = 0 THEN
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.InsertRow(0)
	END IF

	tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.SetItem(ll_CurrRow_Mov_IVA, "totale", ldc_totale)
ELSE
	IF ll_CurrRow_Mov_IVA = 0 THEN
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.InsertRow(0)
	END IF

	tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.SetItem(ll_CurrRow_Mov_IVA, "totale", 0)

END IF
end event

event ue_elimina_mov_iva;call super::ue_elimina_mov_iva;

long ll_righe, ll_i 
decimal ldc_imponibile, ldc_imposta

ll_righe = THIS.RowCount()

FOR ll_i = ll_righe TO 1 STEP -1

	ldc_imponibile = THIS.uf_GetItemDecimal(ll_i, "mov_iva_imponibile")
	ldc_imposta = THIS.uf_GetItemDecimal(ll_i, "mov_iva_imposta")
	
	IF (IsNull(ldc_imponibile) OR ldc_imponibile = 0) AND &
		(IsNull(ldc_imposta) OR ldc_imposta = 0) THEN
		THIS.SetRow(ll_i)
		THIS.DeleteRow(0)
	END IF

NEXT


end event

event ue_crea_mov_iva_vuote;call super::ue_crea_mov_iva_vuote;

CONSTANT Integer LI_RIGHE = 10
Integer li_i

FOR li_i=1 TO LI_RIGHE
	tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.TriggerEvent("ue_insert")
NEXT

tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.ScrollToRow(1)
tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.SetRow(1)


end event

event itemfocuschanged;call super::itemfocuschanged;

long ll_CurrRow_Mov_IVA
decimal ldc_tot_imponibile, ldc_tot_imposta, ldc_totale

CHOOSE CASE dwo.name
	CASE "mov_iva_imponibile", "mov_iva_imposta"

		PostEvent("ue_assegna_totale")

END CHOOSE
end event

event updateend;call super::updateend;
uf_genera_movimenti()
//27052015
if rowsinserted >0 then
	wf_ute_reg_pd("II")
end if
if rowsupdated>0 then
	wf_ute_reg_pd("UI")
end if
if rowsdeleted>0 then
	wf_ute_reg_pd("DI")
end if
end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_reg_pd"
is_title = "Movimenti IVA"

end event

event ue_insert;call super::ue_insert;

uf_sposta_focus(THIS,"mov_iva_imponibile")
end event

event ue_delete;call super::ue_delete;


PostEvent("ue_assegna_totale")
end event

event ue_retrieve;call super::ue_retrieve;

string ls_par_menu

ls_par_menu = is_par_menu

IF ((ls_par_menu = "IA") OR (ls_par_menu = "IV")  OR (ls_par_menu = "AV") OR (ls_par_menu = "PI")) THEN 
	PostEvent("ue_assegna_totale")
END IF
end event

event ue_validate_row;call super::ue_validate_row;

long ll_CurrRow_Reg_PD, ll_righe, ll_CurrRow_Mov_IVA_ff
decimal ldc_differenza

ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
ll_CurrRow_Mov_IVA_ff = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.GetRow()
ldc_differenza = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.uf_GetItemDecimal(ll_CurrRow_Mov_IVA_ff, "differenza")

ll_righe = THIS.RowCount()

IF ldc_differenza <> 0 AND ll_righe <> 0 THEN
	as_error_text = "La differenza fra i movimenti IVA e l'importo~rdel documento deve essere zero."
	RETURN 1
END IF

RETURN 0
end event

event ue_default;call super::ue_default;

long ll_CurrRow, ll_CurrRow_Reg_PD, ll_IDTab_IVA, ll_IDConto, ll_IDProf_Registrazione
decimal {2} ldc_imponibile, ldc_per_aliquota, ldc_scorporato
long ll_id_reg,ll_riga
string ls_tipo_reg,ls_ges_sco
boolean lb_registro
ll_riga=dw_reg_pd_pn_ff.getrow()
ll_id_reg=dw_reg_pd_pn_ff.getitemnumber(ll_riga,"id_registro")
lb_registro=true
select tipo_registro,ges_sco_giornaliero
into :ls_tipo_reg,:ls_ges_sco
from registro
where id_registro=:ll_id_reg;
if (ls_tipo_reg='IC') and (ls_ges_sco='N') then lb_registro=false

ll_CurrRow = THIS.GetRow()

CHOOSE CASE string(adwo_current.name)
	CASE "mov_iva_imponibile"
		
		
		
		if lb_registro=true then
			IF (ll_CurrRow = 1) THEN
				ldc_scorporato = uf_proponi_scorporo()
				IF ldc_scorporato > 0 THEN
					THIS.SetItem(ll_CurrRow, "mov_iva_imponibile", ldc_scorporato)
				END IF
			END IF
		else
			ldc_scorporato=dw_reg_pd_pn_ff.getitemnumber(ll_riga,"reg_pd_imp_valuta")
			THIS.SetItem(ll_riga, "mov_iva_imponibile", ldc_scorporato)
		end if
	CASE "mov_iva_imposta"
			
		
		
		if lb_registro=true then
			ldc_imponibile = THIS.uf_GetItemDecimal(ll_CurrRow, "mov_iva_imponibile")
			ll_IDTab_IVA = THIS.GetItemNumber(ll_CurrRow, "id_tab_iva_cod")
	
			THIS.SetItem(ll_CurrRow, "mov_iva_imposta", uf_imposta(ldc_imponibile, ll_IDTab_IVA) )
		else
			THIS.SetItem(ll_riga, "mov_iva_imposta",0)
		end if
		
	
	CASE "id_tab_iva_cod"
		ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
		ll_IDConto = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_conto")
		ll_IDProf_Registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_prof_registrazione")
		SELECT "dba"."sog_commerciale"."id_tab_iva"
			INTO :ll_IDTab_IVA
			FROM "dba"."sog_commerciale"
			WHERE "dba"."sog_commerciale"."id_conto" = :ll_IDConto;

		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				IF ll_IDTab_IVA <> 0 THEN
					THIS.SetItem(ll_CurrRow, "id_tab_iva_cod", ll_IDTab_IVA)
				ELSE
					ll_IDTab_IVA = uf_proponi_IVA_da_prof(ll_IDProf_Registrazione)
					IF ll_IDTab_IVA <> 0 THEN THIS.SetItem(ll_CurrRow, "id_tab_iva_cod", ll_IDTab_IVA)

				END IF
			CASE 100
				ll_IDTab_IVA = uf_proponi_IVA_da_prof(ll_IDProf_Registrazione)
				IF ll_IDTab_IVA <> 0 THEN THIS.SetItem(ll_CurrRow, "id_tab_iva_cod", ll_IDTab_IVA)
			CASE -1
				MessageBox("Errore sul DataBase", "ue_default / dw_mov_iva_gd / 1")
		END CHOOSE
END CHOOSE
end event

event getfocus;

long ll_RetVal, ll_CurrRow_Reg_PD, ll_CurrRow_Mov_IVA_ff, ll_rows
integer li_RetVal
string ls_tipo_registro
decimal ldc_differenza
dwItemStatus ldwis_Reg_PD

iu_debug.uf_log_msg(1, "dw_mov_iva_gd / GetFocus")

ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()

ldwis_Reg_PD = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow_Reg_PD, 0, Primary!)

CHOOSE CASE ldwis_Reg_PD
	CASE New!, NewModified!
		ib_askforsave = FALSE
		li_RetVal = dw_reg_pd_pn_ff.EVENT ue_update(0, 0)
		long ll_controllo_testa
		ll_controllo_testa=dw_reg_pd_pn_ff.getitemnumber(1,"id_reg_pd")
		if ll_controllo_testa>0 then 
		
			
			
			
			THIS.Event ue_insert(0,0)
		ELSE
			dw_reg_pd_pn_ff.SetFocus()
			RETURN 1
		END IF
		
		
		
		
		
		
		
		
END CHOOSE


ll_RetVal = super::EVENT getfocus()
RETURN ll_RetVal


end event

event ue_update;

long ll_RetVal, ll_Rows_Mov_IVA
decimal ldc_differenza

TriggerEvent("ue_elimina_mov_iva")

ib_askforsave = FALSE

ll_RetVal = super::EVENT ue_update (0, 0)
RETURN ll_RetVal


end event

event ue_key;call super::ue_key;

CHOOSE CASE key
	CASE KeyTab!
		IF (THIS.GetColumnName() = "mov_iva_imposta") AND (THIS.GetRow() = THIS.RowCount()) AND (keyflags <> 1) THEN
			
			if dw_mov_iva_ff.getitemdecimal(1,'differenza')=0 then
			    tab_mov_contabile.Event post selectionchanged(1, 2)
			else
				messagebox ('Attenzione', 'Importo Valuta diverso da Importo')	
				THIS.Event Post ue_insert(0, 0)
			end if	 
		END IF
	CASE KeyDownArrow!
		
		IF (THIS.GetRow() = THIS.RowCount()) THEN
			THIS.Event Post ue_insert(0, 0)
		END IF
END CHOOSE

end event

event losefocus;

end event

event itemchanged;call super::itemchanged;

long ll_CurrRow_Mov_IVA
decimal ldc_tot_imponibile, ldc_tot_imposta, ldc_totale

CHOOSE CASE dwo.name
	CASE "mov_iva_imponibile", "mov_iva_imposta"

		PostEvent("ue_assegna_totale")

END CHOOSE
end event

type dw_mov_iva_ff from u_dw_ext_main within tabpage_mov_iva
integer x = 23
integer y = 540
integer width = 2030
integer height = 140
integer taborder = 20
string dataobject = "d_mov_iva_ff"
end type

type cb_ricalcolo from commandbutton within tabpage_mov_iva
integer x = 2080
integer y = 540
integer width = 270
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ri&calcola"
end type

event clicked;

uf_ricalcolo()
end event

type cb_scorporo from commandbutton within tabpage_mov_iva
event clicked pbm_bnclicked
integer x = 2368
integer y = 540
integer width = 265
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Scorporo"
end type

event clicked;

uf_scorporo()
end event

type tabpage_mov_contabile from userobject within tab_mov_contabile
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2715
integer height = 752
long backcolor = 79741120
string text = "Libro Giornale"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_saldo_conto cb_saldo_conto
cb_estratto_conto cb_estratto_conto
cb_partite cb_partite
p_arrowd p_arrowd
dw_mov_contabile_gd dw_mov_contabile_gd
end type

on tabpage_mov_contabile.create
this.cb_saldo_conto=create cb_saldo_conto
this.cb_estratto_conto=create cb_estratto_conto
this.cb_partite=create cb_partite
this.p_arrowd=create p_arrowd
this.dw_mov_contabile_gd=create dw_mov_contabile_gd
this.Control[]={this.cb_saldo_conto,&
this.cb_estratto_conto,&
this.cb_partite,&
this.p_arrowd,&
this.dw_mov_contabile_gd}
end on

on tabpage_mov_contabile.destroy
destroy(this.cb_saldo_conto)
destroy(this.cb_estratto_conto)
destroy(this.cb_partite)
destroy(this.p_arrowd)
destroy(this.dw_mov_contabile_gd)
end on

type cb_saldo_conto from commandbutton within tabpage_mov_contabile
integer x = 457
integer y = 564
integer width = 329
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Saldi Mensili"
end type

event clicked;

long 				ll_CurrRow, ll_IDConto
s_list_main		lstr_for_win
ll_CurrRow = dw_mov_contabile_gd.GetRow()

IF ll_CurrRow > 0 THEN
	
	ll_IDConto = dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "id_conto")

	IF ll_IDConto > 0 THEN

		lstr_for_win.l_identifica[1] = ll_IDConto

		OpenWithParm(w_conto_saldi_cx, lstr_for_win)
	END IF
END IF

tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetFocus()
end event

type cb_estratto_conto from commandbutton within tabpage_mov_contabile
event clicked pbm_bnclicked
integer x = 837
integer y = 564
integer width = 375
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Estratto Conto"
end type

event clicked;

long ll_CurrRow, ll_IDConto
ll_CurrRow = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetRow()

IF ll_CurrRow > 0 THEN
	ll_IDConto = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "id_conto")

	IF ll_IDConto > 0 THEN
		
		OpenWithParm(w_estratto_conto_2_ff, ll_IDConto)
	END IF
END IF

tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetFocus()
end event

type cb_partite from commandbutton within tabpage_mov_contabile
integer x = 1248
integer y = 564
integer width = 224
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Partite"
end type

event clicked;

uf_attiva_partite()

long ll_reg_now
ll_reg_now=dw_reg_pd_pn_ff.getitemnumber(1,'id_reg_pd')

DECLARE partite_cur CURSOR FOR  
SELECT "gest_chiudi_partite"."id_par_aperte",   
       "gest_chiudi_partite"."id_reg_pd"  
  FROM "gest_chiudi_partite"
 WHERE "gest_chiudi_partite"."id_reg_now"=:ll_reg_now;   
 
string ls_descrizione1
long ll_row, li_id_par_aperte, li_id_reg_pd, ll_num_par, ll_num_reg, ll_len
date ld_data_par

if is_test_par=0 or is_test_par=2 then 

	OPEN partite_cur;

	FETCH partite_cur INTO :li_id_par_aperte, :li_id_reg_pd;

	if SQLCA.SQLCODE = 0 then

		ls_descrizione1=''
		DO WHILE SQLCA.SQLCODE = 0
			select num_partita, data_partita
			into :ll_num_par, :ld_data_par
			from par_aperta
			where id_par_aperta=:li_id_par_aperte;
			select num_progressivo
			into :ll_num_reg
			from reg_pd
			where id_reg_pd=:li_id_reg_pd;
			if ls_descrizione1='' then 
				ls_descrizione1='Saldo N°F.'+string(ll_num_par)+'- '+string(ld_data_par)
			else	
				ls_descrizione1=ls_descrizione1+', N°F.'+string(ll_num_par)+'- '+string(ld_data_par)	
			end if	
			
			FETCH partite_cur INTO :li_id_par_aperte, :li_id_reg_pd;	
			
		LOOP
	   
  	   ll_row=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getrow()
		ll_len=len(is_par_desc)
		if ll_len<>0 then ll_len=ll_len + 1
		if ll_row=0 then ll_row=1
		if ls_descrizione1<>'' then 
			is_par_desc= LS_DESCRIZIONE1
			LS_DESCRIZIONE1= Right ( LS_DESCRIZIONE1 , len(ls_descrizione1) - (ll_len) )
			LS_DESCRIZIONE1=Left(ls_descrizione1, 40)
         if is_test_par=2 then ls_descrizione1='Saldo fattura' 
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(ll_row,'mov_contabile_des_contabile',ls_descrizione1)
		end if
		
	end if	
	CLOSE partite_cur;
	
end if 
	
is_test_par=0

	
	
	
	
	
	
	
	
end event

type p_arrowd from picture within tabpage_mov_contabile
boolean visible = false
integer x = 96
integer y = 1088
integer width = 50
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "s:\pb\cometa\arrowd.bmp"
boolean focusrectangle = false
end type

type dw_mov_contabile_gd from u_dw_master_main within tabpage_mov_contabile
event ue_posiziona_cursore ( )
event ue_elimina_mov_contab ( )
event ue_genera_risconti ( )
event ue_attiva_dettagli ( )
event ue_crea_mov_contab_vuote ( )
event ue_init_row ( )
event ue_crea_mov_contabili ( )
event ue_crea_mov_contabili_iva1 ( )
event ue_crea_mov_contabili_iva2 ( )
event ue_crea_mov_contabili_iva1a ( )
event ue_post_getfocus ( )
integer x = 9
integer y = 28
integer width = 2702
integer height = 644
integer taborder = 10
string dataobject = "d_mov_contabile_gd"
boolean vscrollbar = true
end type

event ue_posiziona_cursore;call super::ue_posiziona_cursore;

long ll_CurrRow, ll_CurrRow_Reg_PD, ll_IDProf_Registrazione, ll_numero
decimal ldec_dare, ldec_avere
string ls_segno

ll_CurrRow = THIS.GetRow()
ldec_dare = uf_GetItemDecimal(ll_CurrRow, "dare")
ldec_avere = uf_GetItemDecimal(ll_CurrRow, "avere")

IF IsNull(ldec_dare) AND IsNull(ldec_avere) THEN
	ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
	ll_IDProf_Registrazione = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_prof_registrazione")
	ll_numero = THIS.GetItemNumber(ll_CurrRow, "numero")

	SELECT "prof_mov_contabile"."segno"
		INTO :ls_segno
		FROM "prof_mov_contabile"
		WHERE "prof_mov_contabile"."ID_Prof_Registrazione" = :ll_IDProf_Registrazione AND
			"prof_mov_contabile"."num_riga" = :ll_numero;

	CHOOSE CASE ls_segno
		CASE "D"
			THIS.SetColumn("dare")
		CASE "A"
			THIS.SetColumn("avere")
	END CHOOSE

END IF
end event

event ue_elimina_mov_contab;



long ll_righe, ll_i, ll_IDConto
decimal ldc_dare, ldc_avere
ll_righe = THIS.RowCount()

FOR ll_i = ll_righe TO 1 STEP -1
	ldc_dare = THIS.uf_GetItemDecimal(ll_i, "dare")
	ldc_avere = THIS.uf_GetItemDecimal(ll_i, "avere")
	ll_IDConto = THIS.GetItemNumber(ll_i, "id_conto")
	IF (IsNull(ldc_dare) OR ldc_dare = 0) AND &
		(IsNull(ldc_avere) OR ldc_avere = 0) THEN
		THIS.SetRow(ll_i)
		THIS.DeleteRow(0)
	END IF
NEXT



end event

event ue_genera_risconti;call super::ue_genera_risconti;
end event

event ue_attiva_dettagli;



s_any_array lstr_array
string ls_array[]

ls_array[1] = "0"
ls_array[2] = uf_Get_Colval("id_mov_contabile")
ls_array[3] = uf_Get_Colval("id_conto")
ls_array[4] = uf_Get_Colval("conto_codice")
ls_array[5] = uf_Get_Colval("conto_descrizione")
ls_array[6] = uf_Get_Colval("valuta_codice")
ls_array[7] = uf_Get_Colval("valuta_descrizione")
ls_array[8] = uf_Get_Colval("cambio")
ls_array[9] = uf_Get_Colval("mov_contabile_des_contabile")
ls_array[10] = uf_Get_Colval("dare")
ls_array[11] = uf_Get_Colval("avere")
ls_array[12] = uf_Get_Colval("data_val_banca")
ls_array[13] = uf_Get_Colval("data_inizio_competenza")
ls_array[14] = uf_Get_Colval("data_fine_competenza")
ls_array[15] = uf_Get_Colval("mov_contabile_rateo_risconto")


IF ib_riga_protetta = TRUE THEN
	ls_array[16] = "1"
ELSE
	ls_array[16] = "0"
END IF

  ls_array[17] = string(il_HelpTopic)

lstr_array.s_array = ls_array
OpenWithParm(w_mov_contabile_ext_ff, lstr_array)
lstr_array= Message.PowerObjectParm
ls_array = lstr_array.s_array


IF ls_array[1] = "1" THEN
	uf_Set_Colval("id_mov_contabile", ls_array[2])
	uf_Set_Colval("id_conto", ls_array[3])
	uf_Set_Colval("conto_codice", ls_array[4])
	uf_Set_Colval("conto_descrizione", ls_array[5])
	uf_Set_Colval("valuta_codice", ls_array[6])
	uf_Set_Colval("valuta_descrizione", ls_array[7])
	uf_Set_Colval("cambio", ls_array[8])
	uf_Set_Colval("mov_contabile_des_contabile", ls_array[9])
	uf_Set_Colval("dare", ls_array[10])
	uf_Set_Colval("avere", ls_array[11])
	uf_Set_Colval("data_val_banca", ls_array[12])
	uf_Set_Colval("data_inizio_competenza", ls_array[13])
	uf_Set_Colval("data_fine_competenza", ls_array[14])
	uf_Set_Colval("mov_contabile_rateo_risconto", ls_array[15])
 END IF


long ll_id_reg_pd, ll_id_conto, ll_reg, ll_rif_scrittura, ll_rif_intestatario
decimal ld_importo
date ld_data_in_comp, ld_data_fin_comp
string ls_tipo_record, ls_segno

ls_tipo_record=ls_array[15]

IF ls_tipo_record="S" OR ls_tipo_record="T" THEN
	
	ll_rif_intestatario=dw_reg_pd_pn_ff.getitemnumber(1,"id_conto")
	ll_id_reg_pd=this.getitemnumber(getrow(),"id_reg_pd")
	ll_id_conto=dec(ls_array[3])
	ld_importo=dec(ls_array[10]) 
	ls_segno="D"
	if ld_importo=0 or isnull(ld_importo) then
	   ld_importo=dec(ls_array[11]) 
		ls_segno="A"
   end if
	ld_data_in_comp=date(ls_array[13])
	ld_data_fin_comp=date(ls_array[14])
  
  
  SELECT "ges_ratei_risconti"."rif_scrittura"  
    INTO :ll_rif_scrittura  
    FROM "ges_ratei_risconti"  
   WHERE "ges_ratei_risconti"."rif_scrittura" = :ll_id_reg_pd   ;

   IF sqlca.sqlcode=0 then 
		UPDATE "ges_ratei_risconti"  
         SET "rif_conto" = :ll_id_conto,   
             "importo_doc" = :ld_importo,   
				 "data_in_comp" = :ld_data_in_comp,   
				 "data_fin_comp" = :ld_data_fin_comp,   
				 "tipo_record" = :ls_tipo_record,
				 "segno"= :ls_segno
		 WHERE "ges_ratei_risconti"."rif_scrittura" = :ll_id_reg_pd   ;
		 commit;

	    ELSE
				
				INSERT INTO "ges_ratei_risconti"  
							 ( "rif_scrittura",   
								"rif_conto",   
								"importo_doc",   
								"data_in_comp",   
								"data_fin_comp",   
								"tipo_record",
								"segno",
								"rif_intestatario")
					VALUES ( :ll_id_reg_pd,   
								:ll_id_conto,   
								:ld_importo,   
								:ld_data_in_comp,   
								:ld_data_fin_comp,   
								:ls_tipo_record,
								:ls_segno,
								:ll_rif_intestatario)  ;
					commit;			
					IF SQLCA.SQLCODE <> 0 THEN
						Messagebox ('Attenzione', 'Si è verificato un errore durante la creazione del Rateo/Risconto')
					END IF
	END IF 
END IF 


end event

event ue_crea_mov_contab_vuote;call super::ue_crea_mov_contab_vuote;

long ll_IDReg_PD, ll_max_numero, ll_CurrRow, ll_Valuta_Reg_PD, ll_CurrRow_Reg_PD, ll_Cambio_Reg_PD
Integer li_i
Date ld_Data_Reg_PD
string ls_tipo_registro
DataWindow ldw_mov_contab_gd
CONSTANT Integer LI_RIGHE = 10

ldw_mov_contab_gd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd
ll_CurrRow_Reg_PD  = dw_reg_pd_pn_ff.GetRow()
ll_IDReg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_reg_pd")
ls_tipo_registro = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "tipo_registro")

FOR li_i=1 TO LI_RIGHE
	ll_CurrRow = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.InsertRow(0)

	
	ldw_mov_contab_gd.SetItem(ll_CurrRow, "id_reg_pd", ll_IDReg_PD)
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.is_list.l_identifica[1] = ll_IDReg_PD

	
	ll_max_numero = ldw_mov_contab_gd.Find("numero < 7999", ldw_mov_contab_gd.RowCount(), 1)
	IF IsNull(ll_max_numero) THEN ll_max_numero = 0
	ldw_mov_contab_gd.SetItem(ll_CurrRow, "numero", (ll_max_numero+1))

	
	
	ll_Valuta_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_valuta_des")
	ldw_mov_contab_gd.SetItem(ll_CurrRow, "id_valuta", ll_Valuta_Reg_PD)

	
	ll_Cambio_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "cambio")
	ldw_mov_contab_gd.SetItem(ll_CurrRow, "cambio", ll_cambio_Reg_PD)

	
	
	ld_Data_Reg_PD = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow_Reg_PD, "data_competenza")
	ldw_mov_contab_gd.SetItem(ll_CurrRow, "data_val_banca", ld_Data_Reg_PD)
	ldw_mov_contab_gd.SetItem(ll_CurrRow, "data_inizio_competenza", ld_Data_Reg_PD)
	ldw_mov_contab_gd.SetItem(ll_CurrRow, "data_fine_competenza", ld_Data_Reg_PD)

	
	ldw_mov_contab_gd.SetItem(ll_CurrRow, "mov_contabile_rateo_risconto", "N")
NEXT

IF ls_tipo_registro = "IA" OR ls_tipo_registro = "IV" THEN
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetRow(3)
ELSE
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetRow(1)
END IF

ib_Attiva_Wizard = TRUE
end event

event ue_init_row;call super::ue_init_row;

long ll_CurrRow, ll_max_numero, ll_Valuta_Reg_PD, ll_CurrRow_Reg_PD, ll_Cambio_Reg_PD, ll_CurrNumero
date ld_Data_Reg_PD
string ls_des_contabile

ll_CurrRow = dw_mov_contabile_gd.GetRow()
ll_CurrRow_Reg_PD  = dw_reg_pd_pn_ff.GetRow()

ll_max_numero = dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "max_numero")
IF IsNull(ll_max_numero) THEN ll_max_numero = 0

ll_CurrNumero = dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "numero")
IF IsNull(ll_CurrNumero) THEN
	dw_mov_contabile_gd.SetItem(ll_CurrRow, "numero", (ll_max_numero+1))
END IF

ls_des_contabile = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "descrizione")
dw_mov_contabile_gd.SetItem(ll_CurrRow, "mov_contabile_des_contabile", ls_des_contabile)

ll_Valuta_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_valuta_des")
dw_mov_contabile_gd.SetItem(ll_CurrRow, "id_valuta", ll_Valuta_Reg_PD)

ll_Cambio_Reg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "cambio")
dw_mov_contabile_gd.SetItem(ll_CurrRow, "cambio", ll_cambio_Reg_PD)

ld_Data_Reg_PD = dw_reg_pd_pn_ff.GetItemDate(ll_CurrRow_Reg_PD, "data_competenza")
dw_mov_contabile_gd.SetItem(ll_CurrRow, "data_val_banca", ld_Data_Reg_PD)
dw_mov_contabile_gd.SetItem(ll_CurrRow, "data_inizio_competenza", ld_Data_Reg_PD)
dw_mov_contabile_gd.SetItem(ll_CurrRow, "data_fine_competenza", ld_Data_Reg_PD)

dw_mov_contabile_gd.SetItem(ll_CurrRow, "mov_contabile_rateo_risconto", "N")
end event

event ue_post_getfocus;call super::ue_post_getfocus;
if is_par_menu="IC" then
	long ll_id_prof,ll_id_conto,ll_riga,ll_id_reg
	string ls_sco
	ll_id_reg = dw_reg_pd_pn_ff.getitemnumber(1,"id_registro")
	select ges_sco_giornaliero
	into :ls_sco
	from registro
	where id_registro=:ll_id_reg;
	if ls_sco='N' then
		ll_id_prof = dw_reg_pd_pn_ff.getitemnumber(1,"id_prof_registrazione")
		select id_conto_iva
		into :ll_id_conto
		from prof_registrazione
		where id_prof_registrazione=:ll_id_prof;
		if sqlca.sqlcode=0 then
			ll_riga=this.Find ( "id_conto="+string(ll_id_conto), 1, this.rowcount())
			if ll_riga>0 then this.deleterow(ll_riga)
		end if
	end if
end if
end event

event getfocus;
long ll_altro, ll_val_lire


long ll_RetVal, ll_CurrRow_Reg_PD, ll_CurrRow_Mov_IVA, ll_Righe_Mov_Contabile, ll_Righe_Mov_IVA
long ll_Riga_9999, ll_IDTab_IVA, ll_CurrRow_Mov_Contabile, ll_numero, ll_riga_8888
string ls_tipo_registro, ls_segno
decimal {2} ldc_differenza, ldc_imposta_dare, ldc_imposta_avere,  ldc_imposta_netta, ldc_tot_imposta_netta, ldc_per_detr, ldc_imposta_iva
decimal {2} ldc_imposta, ldc_imposta_nd, ldc_imposta_dare_nd, ldc_imposta_avere_nd
integer li_RetVal, li_i
dwItemStatus ldwis_Reg_PD, ldwis_Mov_IVA

ll_Righe_Mov_Contabile = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.RowCount()
ll_Righe_Mov_IVA = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.RowCount()
ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
ldc_tot_imposta_netta = 0

THIS.SetRowFocusIndicator(p_arrowd)

ldwis_Reg_PD = dw_reg_pd_pn_ff.GetItemStatus(ll_CurrRow_Reg_PD, 0, Primary!)

CHOOSE CASE ldwis_Reg_PD
	CASE New!, NewModified!
		li_RetVal = dw_reg_pd_pn_ff.EVENT ue_update(0, 0)
		
		IF li_RetVal <> 0 THEN
			dw_reg_pd_pn_ff.SetFocus()
			RETURN 1
		END IF
END CHOOSE

ls_tipo_registro = is_tipo_registro

IF ls_tipo_registro = "IA" OR ls_tipo_registro = "IV" OR ls_tipo_registro = "IC" THEN
	ldc_differenza = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.uf_GetItemDecimal(1, "differenza")
	IF ldc_differenza = 0 AND &
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.RowCount() > 0  AND &
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.RowCount() = 0 THEN
		ldwis_Mov_IVA = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetItemStatus(1, 0, Primary!)
		IF ldwis_Mov_IVA = New! OR ldwis_Mov_IVA = NewModified! THEN
			dw_reg_pd_pn_ff.EVENT ue_update(0, 0)
		END IF
	END IF

	IF ll_Righe_Mov_Contabile > 0 THEN
		
		
		
		ll_Riga_9999 = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.Find('numero = 9999', 1, ll_Righe_Mov_Contabile)
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.AcceptText()
		
		ll_riga_8888 = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.Find('numero = 8888', 1, ll_Righe_Mov_Contabile)
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.AcceptText()
		

IF ll_Riga_9999 > 0 THEN
	
	
	if il_lire=ll_valuta_reg_pd then   
		ldc_imposta_dare = ceiling(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_9999, "dare"))
		ldc_imposta_avere = ceiling(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_9999, "avere"))
	else
		ldc_imposta_dare = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_9999, "dare")
		ldc_imposta_avere = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_9999, "avere")
	end if
	
	IF IsNull(ldc_imposta_dare) THEN
		ldc_imposta = ldc_imposta_avere
		ls_segno = "A"
	ELSEIF IsNull(ldc_imposta_avere) THEN
		ldc_imposta = ldc_imposta_dare
		ls_segno = "D"
	END IF

	IF ll_riga_8888 > 0 then
		
		if il_lire=ll_valuta_reg_pd then    
			ldc_imposta_dare_nd = truncate(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_8888, "dare"), 0)
			ldc_imposta_avere_nd = truncate(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_8888, "avere"),0)
		else
			ldc_imposta_dare_nd = truncate(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_8888, "dare"), 2)
			ldc_imposta_avere_nd = truncate(tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_8888, "avere"),2)
		end if
		
		IF IsNull(ldc_imposta_dare_nd) THEN
			ldc_imposta_nd = ldc_imposta_avere_nd
			ls_segno = "A"
		ELSEIF IsNull(ldc_imposta_avere_nd) THEN
			ldc_imposta_nd = ldc_imposta_dare_nd
			ls_segno = "D"
		END IF
	END IF	

		
	
		
		
			
			
	IF ll_Righe_Mov_IVA > 0 THEN
		
		FOR li_i = 1 TO ll_Righe_Mov_IVA
			ll_IDTab_IVA = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetItemNumber(li_i, "id_tab_iva_cod")

			  SELECT "tab_iva"."per_detrazione"
				 INTO :ldc_per_detr
				 FROM "tab_iva"
				WHERE "tab_iva"."id_tab_iva" = :ll_IDTab_IVA;

				CHOOSE CASE SQLCA.SQLCode
					CASE 0
						ldc_imposta_iva = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.uf_GetItemDecimal(li_i, "mov_iva_imposta")
						   
							
							
							
							
							
							
							if ll_riga_8888=0 then 
								ldc_imposta_netta = ldc_imposta_iva  / 100 * ldc_per_detr
							else
								ldc_imposta_netta = ldc_imposta_iva
							end if	
							
							
							ldc_tot_imposta_netta = ldc_tot_imposta_netta + ldc_imposta_netta
							
				END CHOOSE
		NEXT
      
      
		
		
		
		
		ldc_imposta = ldc_imposta + ldc_imposta_nd
		
			
	   
		
		
		
		IF ldc_tot_imposta_netta <> ldc_imposta THEN
		
			IF ls_segno = "D" THEN
				
				if il_lire=ll_valuta_reg_pd then    
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_9999, "dare", CEILING(ldc_tot_imposta_netta))
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_8888, "dare", TRUNCATE(ldc_tot_imposta_netta, 0))
				else
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_9999, "dare", ldc_tot_imposta_netta)
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_8888, "dare", TRUNCATE(ldc_tot_imposta_netta, 2))
				end if
				
			ELSEIF ls_segno = "A" THEN
				
				if il_lire=ll_valuta_reg_pd then    
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_9999, "avere", CEILING(ldc_tot_imposta_netta))
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_8888, "avere", TRUNCATE(ldc_tot_imposta_netta, 0))
				else
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_9999, "avere", ldc_tot_imposta_netta)
					tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_8888, "avere", TRUNCATE(ldc_tot_imposta_netta, 2))
				end if
				
			END IF
		END IF

	END IF
				
		ll_CurrRow_Mov_Contabile = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetRow()
		ll_numero = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow_Mov_Contabile, "numero")
		IF (ll_numero = 1) OR (ll_numero = 9999) OR (ll_numero = 8888) THEN
			
			if ldc_per_detr = 100 then
				ib_riga_protetta = TRUE
			else
				ib_riga_protetta = FALSE
			end if	
		END IF
	
else
	IF ll_riga_8888 > 0 then
		ldc_imposta_dare_nd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_8888, "dare")
		ldc_imposta_avere_nd = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.uf_GetItemDecimal(ll_Riga_8888, "avere")
		IF IsNull(ldc_imposta_dare_nd) THEN
			ldc_imposta_nd = ldc_imposta_avere_nd
			ls_segno = "A"
		ELSEIF IsNull(ldc_imposta_avere_nd) THEN
			ldc_imposta_nd = ldc_imposta_dare_nd
			ls_segno = "D"
		END IF

		
		
			
		IF ll_Righe_Mov_IVA > 0 THEN
			FOR li_i = 1 TO ll_Righe_Mov_IVA
				ll_IDTab_IVA = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetItemNumber(li_i, "id_tab_iva_cod")

					  SELECT "tab_iva"."per_detrazione"
						 INTO :ldc_per_detr
						 FROM "tab_iva"
						WHERE "tab_iva"."id_tab_iva" = :ll_IDTab_IVA;
					
					CHOOSE CASE SQLCA.SQLCode
						CASE 0
							ldc_imposta_iva = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.uf_GetItemDecimal(li_i, "mov_iva_imposta")
							   IF LDC_PER_DETR > 0 THEN
									ldc_imposta_netta = ldc_imposta_iva / 100 * ldc_per_detr
									ldc_tot_imposta_netta = ldc_tot_imposta_netta + ldc_imposta_netta
									
								ELSE
									ldc_imposta_netta = ldc_imposta_iva  
									ldc_tot_imposta_netta = ldc_tot_imposta_netta + ldc_imposta_netta
									
								END IF						
							END CHOOSE
				NEXT

				
				ldc_imposta = ldc_imposta + ldc_imposta_nd
				
				IF ldc_tot_imposta_netta <> ldc_imposta THEN
					IF ls_segno = "D" THEN
						tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_8888, "dare", ldc_tot_imposta_netta)
					ELSEIF ls_segno = "A" THEN
						tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.SetItem(ll_Riga_8888, "avere", ldc_tot_imposta_netta)
					END IF
				END IF

			END IF
		END IF
		
		ll_CurrRow_Mov_Contabile = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetRow()
		
		if ll_currrow_mov_contabile>0 then ll_numero = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(ll_CurrRow_Mov_Contabile, "numero")
		IF (ll_numero = 1) OR (ll_numero = 9999) OR (ll_numero = 8888) THEN
			
			if ldc_per_detr = 100 then
				ib_riga_protetta = TRUE
			else
				ib_riga_protetta = FALSE
			end if	
		END IF
	
	END IF	
END IF
	
END IF


ll_RetVal = super::EVENT getfocus()
this.event post ue_post_getfocus()
RETURN ll_RetVal

end event

event itemchanged;

string ls_dbc[], ls_dbv[], ls_dwc[], ls_des, ls_des2, ls_movcod, ls_movdes
long li_ok, ll_ret

CHOOSE CASE dwo.name
	CASE "conto_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_codice"
		ls_dwc[2] = "conto_descrizione"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)

		uf_SW_SetNull(data, "id_conto")
		
		IF li_ok > 0 THEN
			
		END IF
	CASE "conto_descrizione"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_codice"
		ls_dwc[2] = "conto_descrizione"
		ls_dwc[3] = "id_conto"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)

		uf_SW_SetNull(data, "id_conto")

		IF li_ok > 0 THEN
			
		END IF
	
	CASE "conto_descrizione", "conto_codice"
		ls_des=this.getitemstring(row,'chiocciola')
		if Pos ( ls_des,'@M',1)>0  then
			ls_movdes=ls_dbv[2]
			ll_ret=pos(ls_des,'@',1)
			ls_des2=Replace(ls_des, ll_ret,2,ls_movdes)	
		   this.setitem(row,'mov_contabile_des_contabile',ls_des2)
		end if	
		
END CHOOSE

end event

event itemfocuschanged;

integer li_RetVal

li_RetVal = Super::EVENT ItemFocusChanged(row, dwo)

CHOOSE CASE dwo.name
	CASE "dare"
		IF (is_tipo_registro = "PN") OR (is_tipo_registro = "MN") THEN
			cb_partite.enabled = TRUE
		ELSE
			cb_partite.enabled = FALSE
		END IF
		Trigger Event ue_posiziona_cursore()
	CASE "avere"
		IF (is_tipo_registro = "PN") OR (is_tipo_registro = "MN") THEN
			cb_partite.enabled = TRUE
		ELSE
			cb_partite.enabled = FALSE
		END IF
		Trigger Event ue_posiziona_cursore()
	CASE ELSE
		cb_partite.enabled = FALSE
END CHOOSE

is_item_precedente_mov_con = THIS.GetColumnName()

RETURN li_RetVal
end event

event rowfocuschanged;call super::rowfocuschanged;

long ll_Curr_Row_Reg_PD, ll_Conto_Movimento, ll_numero, ll_CurrRow
string ls_tipo_registro

CONSTANT long ll_N_RIGA_IMPORTO = 1
CONSTANT long ll_N_RIGA_IVA = 9999
CONSTANT long ll_N_RIGA_IVA_N = 8888


ll_Curr_Row_Reg_PD = dw_reg_pd_pn_ff.GetRow()

ll_CurrRow = THIS.GetRow()

IF (ll_CurrRow > 0) AND (ll_Curr_Row_Reg_PD > 0) THEN
	
	ls_tipo_registro = is_tipo_registro
	ll_numero = THIS.GetItemNumber(ll_CurrRow, "numero")

	IF (ls_tipo_registro = "IA") OR (ls_tipo_registro = "IV") OR (ls_tipo_registro = "IC") THEN

		IF ll_numero = ll_N_RIGA_IMPORTO OR ll_numero = ll_N_RIGA_IVA OR ll_numero = ll_N_RIGA_IVA_N THEN
			THIS.Object.conto_codice.Edit.DisplayOnly = TRUE
			THIS.Object.conto_descrizione.Edit.DisplayOnly = TRUE
			THIS.Object.dare.Edit.DisplayOnly = TRUE
			THIS.Object.avere.Edit.DisplayOnly = TRUE
			ib_riga_protetta = TRUE
		ELSE
			THIS.Object.conto_codice.Edit.DisplayOnly = FALSE
			THIS.Object.conto_descrizione.Edit.DisplayOnly = FALSE
			THIS.Object.dare.Edit.DisplayOnly = FALSE
			THIS.Object.avere.Edit.DisplayOnly = FALSE
			ib_riga_protetta = FALSE
		END IF
	END IF
END IF
end event

event ue_init;call super::ue_init;is_title = "Libro Giornale"
is_list.s_identifica[1] = "id_reg_pd"
iudw_children[1] = tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd

is_list.s_win_chiave[1] = "id_mov_contabile"


end event

event ue_insert;

long ll_RetVal, ll_CurrRow_Reg_PD, ll_NewRow, ll_IDReg_PD, ll_l_numero, ll_Rows_Mov_IVA
string ls_tipo_registro
decimal ldc_differenza

ll_CurrRow_Reg_PD = dw_reg_pd_pn_ff.GetRow()
ls_tipo_registro = dw_reg_pd_pn_ff.GetItemString(ll_CurrRow_Reg_PD, "tipo_registro")

ib_nuovo_movimento = TRUE
IF ls_tipo_registro = "IA" OR ls_tipo_registro = "IV" OR ls_tipo_registro = "IC" THEN
	ll_Rows_Mov_IVA = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.GetRow()
	ldc_differenza = tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.uf_GetItemDecimal(1, "differenza")

	IF (ll_Rows_Mov_IVA > 0) AND (ldc_differenza = 0) THEN
		ll_NewRow = THIS.InsertRow(0)

		PostEvent("ue_initial")

		ll_IDReg_PD = dw_reg_pd_pn_ff.GetItemNumber(ll_CurrRow_Reg_PD, "id_reg_pd")
		THIS.SetItem(ll_NewRow, "id_reg_pd", ll_IDReg_PD)

		THIS.SetRow(ll_NewRow)
		THIS.SetColumn("conto_codice")
		THIS.ScrollToRow(ll_NewRow)
		THIS.SetFocus()
	ELSE
		MessageBox("Libro Giornale","Impossibile inserire movimenti: non ci sono movimenti IVA o~rla somma degli imponibili e delle imposte non è uguale~rall'importo del documento.")
		RETURN 0
	END IF
ELSE
	
	ll_RetVal = Super::Event ue_insert(wparam, lparam)
	uf_sposta_focus(THIS,"conto_codice")
	IF IsNull(THIS.GetItemString(THIS.GetRow(), "conto_codice")) THEN
		THIS.SetItem(THIS.GetRow(), "conto_codice", is_filtro_conto)
	END IF
	RETURN ll_RetVal 
END IF
end event

event ue_delete;

long ll_IDReg_PD, ll_IDRegistro, ll_CurrRow, ll_num_riga
string ls_tipo_registro

ll_IDReg_PD = dw_reg_pd_pn_ff.GetRow()
ll_IDRegistro = dw_reg_pd_pn_ff.GetItemNumber(ll_IDReg_PD, "id_registro")


ls_tipo_registro = is_tipo_registro

IF ls_tipo_registro = "IA" OR ls_tipo_registro = "IV" then 
	ll_CurrRow = THIS.GetRow()
	ll_num_riga = THIS.GetItemNumber(ll_CurrRow, "numero")
	IF ll_num_riga = 1 OR ll_num_riga = 9999 THEN
		MessageBox("Impossibile Proseguire","Impossibile cancellare le righe di movimento 1 o 9999", Information!, Ok!)
		RETURN
	END IF
END IF

long num, ll_mov, dar, ave, dif, ll_id_regpd

num = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getrow()
ll_mov = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(num, 'id_mov_contabile')



if isnull(ll_mov) then
   UPDATE(dw_mov_contabile_gd)
   
	num = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getrow()
	ll_mov = tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(num, 'id_mov_contabile')
end if




ll_id_regpd=dw_reg_pd_pn_ff.getitemnumber(1,"id_reg_pd")

select sum(dare), sum(avere)
into :dar, :ave
from mov_contabile
where id_reg_pd = :ll_id_regpd;

dif = (dar - ave)

integer flag
if dif <> 0 then
	messagebox ("Information!","ATTENZIONE, ~nse confermi il salvataggio, verrà~nsalvata una SCRITTURA SBILANCIATA!",Information!)
	
	tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.DeleteRow(0) 
				else
			
			Call Super::ue_delete 
end if



end event

event ue_default;call super::ue_default;

long ll_CurrRow
double ll_totale_dare, ll_totale_avere, ll_saldo

ll_CurrRow = dw_mov_contabile_gd.GetRow()
ll_totale_dare = dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "totale_dare")
ll_totale_avere = dw_mov_contabile_gd.GetItemNumber(ll_CurrRow, "totale_avere")

ll_saldo = ll_totale_dare - ll_totale_avere

CHOOSE CASE string(adwo_current.name)

	CASE "dare"
		
		IF ll_saldo < 0 THEN dw_mov_contabile_gd.SetItem(ll_CurrRow, "dare", Abs(ll_saldo))
	CASE "avere"
		
		IF ll_saldo > 0 THEN dw_mov_contabile_gd.SetItem(ll_CurrRow, "avere", Abs(ll_saldo))
END CHOOSE

end event

event ue_initial;call super::ue_initial;

THIS.EVENT ue_init_row()
end event

event ue_set_search;

IF ib_riga_protetta = FALSE THEN
	
	CHOOSE CASE as_nomecol
		CASE "conto_codice"
			
			is_search_window = "w_conti_pdc_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
			is_ricpar.b_imm_retrieve = TRUE
		CASE "conto_descrizione"
				is_search_window = "w_conti_pdc_sw"
				is_ricpar.s_filter_value = as_valcol
			if object.conto_descrizione_t.text="Descrizione Conto" then
				is_ricpar.s_filter_name = "conto_descrizione"
			else
				is_ricpar.s_filter_name = "anagrafica_par_iva"
			end if
			
			is_ricpar.b_imm_retrieve = TRUE
	END CHOOSE
	
	
	
END IF
end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "conto_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_descrizione", is_ricpar.s_ausil_value[1])

	CASE "conto_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
		uf_set_colval("conto_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event ue_update;call super::ue_update;
long ll_RetVal
string ls_tipo_rettifica



TriggerEvent("ue_elimina_mov_contab")



IF THIS.RowCount() > 0 THEN
	
	ib_Inserimento = FALSE
END IF




ll_RetVal = SUPER::EVENT ue_update(wparam, lparam)

RETURN ll_RetVal


end event

event updateend;

long ll_Rows, ll_i, ll_IDReg_PD, ll_num_riga, ll_IDPar_Aperta, ll_IDMov_Contabile, ll_IDMov_Contabile1
long ll_test, LL_TEST2, LL_PROF, li_id_scadenza, li_num_riga
long ll_reg_2, ll_id_con,ll_riga_giusta, ll_id_sog,ll_id_conto,ll_num_righe,i
long li_id_par_aperte, li_id_par_aperte_scad, li_id_reg_pd, li_id_mov_contabile,li_id_mov_partita 
boolean lb_nuovo_movimento
string ls_tescon, ls_des_c
lb_nuovo_movimento = ib_nuovo_movimento	
decimal ld_importo_par, ld_imp_scadenza, ld_scad_originale
date ld_data_mov, ld_data_scadenza
string ls_note, ls_cod, ls_des, ls_fil, ls_app
long ll_val_par, ll_pos, ll_id_mov_partita, ll_val_scad

//27052015
if rowsinserted >0 then
	wf_ute_reg_pd("IC")
end if
if rowsupdated>0 then
	wf_ute_reg_pd("UC")
end if
if rowsdeleted>0 then
	wf_ute_reg_pd("DC")
end if
//fine
ll_riga_giusta=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()
if ll_riga_giusta>0 then
	ll_id_con=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(ll_riga_giusta,"id_conto")
end if	

long ll_id_prof,ll_id_prof_sistema,ll_nrighe, ll_id_reg_pd
date ld_data
select id_prof_risc_fat_sos
into :ll_id_prof_sistema
from par_sistema;

ld_data=dw_reg_pd_pn_ff.getitemdate(1,"data_registrazione")	
ll_id_prof=dw_reg_pd_pn_ff.getitemnumber(1,"id_prof_registrazione")
if ll_id_prof_sistema=ll_id_prof then  
	ll_nrighe=this.rowcount()
	if ll_nrighe>0 then
		FOR i=1 TO ll_nrighe
			ll_id_reg_pd=this.getitemnumber(i,"cid_reg_app")
			if ll_id_reg_pd>0 then
				update reg_pd set data_comp_liq_iva=:ld_data
				where id_reg_pd=:ll_id_reg_pd;
				commit;
			end if
		NEXT
	end if
end if

ll_reg_2 = dw_reg_pd_pn_ff.GetItemNumber(dw_reg_pd_pn_ff.GetRow(), "id_reg_pd")
tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.retrieve(ll_reg_2)


IF ib_nuovo_movimento = TRUE THEN
	ll_IDReg_PD = dw_reg_pd_pn_ff.GetItemNumber(dw_reg_pd_pn_ff.GetRow(), "id_reg_pd")
	ll_Rows = THIS.RowCount()
	FOR ll_i = 1 TO ll_Rows
		ll_num_riga = THIS.GetItemNumber(ll_i, "numero")
		ll_IDMov_Contabile = THIS.GetItemNumber(ll_i, "id_mov_contabile")
		DECLARE lcur_mov_partita CURSOR FOR
			SELECT id_mov_contabile
				FROM mov_partita
				WHERE id_reg_pd = :ll_IDReg_PD AND
						num_riga_mov_contabile = :ll_num_riga
				USING SQLCA;

		OPEN lcur_mov_partita;
		FETCH lcur_mov_partita INTO :ll_IDMov_Contabile1;

		DO WHILE SQLCA.SQLCode = 0
			UPDATE mov_partita
				SET id_mov_contabile = :ll_IDMov_Contabile
				WHERE id_reg_pd = :ll_IDReg_PD AND
						num_riga_mov_contabile = :ll_num_riga;

			IF SQLCA.SQLNRows > 0 THEN
				COMMIT USING SQLCA ;
			END IF

			FETCH lcur_mov_partita INTO :ll_IDMov_Contabile1;
		LOOP

		CLOSE lcur_mov_partita;
		
		commit;

		
		tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.Retrieve(ll_IDMov_Contabile)
	NEXT
END IF

ib_nuovo_movimento = FALSE


if (is_par_menu='IA') or (is_par_menu='IV') then 
		ls_cod=dw_reg_pd_pn_ff.getitemstring(1,"conto_codice")
		select id_sog_commerciale
		into :ll_id_sog
		from sog_commerciale
		where codice=:ls_cod;

		select id_con_movimento
		into :ll_test
		from con_movimento
		where id_sog_commerciale=:ll_id_sog;
		if sqlca.sqlcode<>0 then

			if is_par_menu='IA' then
				ls_app='A'
			else
				ls_app='V'
			end if
			insert into con_movimento (applicazione,id_sog_commerciale,id_conto)
			values (:ls_app,:ll_id_sog,:ll_id_con);
			if sqlca.sqlcode<>0 then 
				rollback;
			else 
			   commit;	
		   end if

		end if
end if

long ll_reg_now
ll_reg_now=dw_reg_pd_pn_ff.getitemnumber(1,'id_reg_pd')

li_id_mov_contabile=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(1,"id_mov_contabile")

DECLARE partite_cur CURSOR FOR  
SELECT "gest_chiudi_partite"."id_par_aperte",   
       "gest_chiudi_partite"."importo_par",   
       "gest_chiudi_partite"."id_reg_pd",   
       "gest_chiudi_partite"."num_riga",   
       "gest_chiudi_partite"."data_mov",
		 "gest_chiudi_partite"."importo_originale"
  FROM "gest_chiudi_partite"
 WHERE "gest_chiudi_partite"."id_reg_now"=:ll_reg_now; 
 
OPEN partite_cur;

FETCH partite_cur INTO :li_id_par_aperte, :ld_importo_par, :li_id_reg_pd, :li_num_riga, & 
                        :ld_data_mov, :ld_scad_originale;

DO WHILE SQLCA.SQLCODE = 0
	li_id_mov_contabile=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.GetItemNumber(1,"id_mov_contabile")

	
	
	
	
	
	
	IF NOT ISNULL(ld_importo_par) OR ld_importo_par<>0 THEN 
		
		
      select id_valuta into :ll_val_par
		from par_aperta where id_par_aperta=:li_id_par_aperte;				
		select fn_conv_valuta(:ll_valuta_reg_pd,:ld_importo_par,:ll_val_par) into :ld_importo_par from sys.dummy;
		ld_importo_par=f_round_2(ll_val_par,ld_importo_par)
		select fn_conv_valuta(:ll_valuta_reg_pd,:ld_scad_originale,:ll_val_par) into :ld_scad_originale from sys.dummy;
		ld_scad_originale=f_round_2(ll_val_par,ld_scad_originale)
		
		
		
		
		INSERT INTO "mov_partita"  
					 ( "id_mov_partita",   
						"id_par_aperta",   
						"id_mov_contabile",   
						"id_reg_pd",   
						"num_riga_mov_contabile",   
						"data",   
						"importo",   
						"imp_valuta",   
						"note",   
						"id_azienda" )  
			VALUES ( null,   
						:li_id_par_aperte,   
						:li_id_mov_contabile,   
						:li_id_reg_pd,   
						:li_num_riga,   
						:ld_data_mov,   
						:ld_importo_par,   
						:ld_importo_par,   
						null,   
						1 )  ;

			if sqlca.sqlcode<>0 then
				messagebox("Attenzione!",sqlca.sqlerrtext)
				messagebox("Attenzione!", "Gestione chiusura partite fallita! 241 updateend dw_mov_contabile")
			else
				
				if ld_scad_originale=ld_importo_par then
				  update par_aperta
				  set stato='C'
				  where id_par_aperta=:li_id_par_aperte;
				else
					
					select des_contabile into :ls_des_c from mov_contabile
					where id_mov_contabile=:li_id_mov_contabile;
					ll_pos=pos(ls_des,'Saldo')
					ls_des_c=Replace(ls_des_c, ll_pos, 5, "Conto")
					update mov_contabile set des_contabile=:ls_des_c 
					where id_mov_contabile=:li_id_mov_contabile;  
				end if              
		   end if

	END IF
   
	
	
	
	
	
	

	SELECT "mov_partita"."id_mov_partita"  
     INTO :ll_id_mov_partita  
     FROM "mov_partita"  
    WHERE ( "mov_partita"."id_par_aperta" = :li_id_par_aperte ) AND  
            ( "mov_partita"."id_mov_contabile" = :li_id_mov_contabile );
     
	
	
	
	DECLARE scadenze_cur CURSOR FOR  
      SELECT "gest_chiudi_scadenze"."id_par_aperte",   
				 "gest_chiudi_scadenze"."imp_scadenza",   
             "gest_chiudi_scadenze"."id_scadenza",   
             "gest_chiudi_scadenze"."data_scadenza", 
		 	    "gest_chiudi_scadenze"."note",
   			 "gest_chiudi_scadenze"."importo_originale"
        FROM "gest_chiudi_scadenze"
       WHERE "gest_chiudi_scadenze"."id_reg_now"=:ll_reg_now; 
	 
	OPEN scadenze_cur;

   FETCH scadenze_cur INTO :li_id_par_aperte_scad,:ld_imp_scadenza, :li_id_scadenza, &
		   						   :ld_data_scadenza, :ls_note, :ld_scad_originale;
										
		
   DO WHILE SQLCA.SQLCODE=0
	   IF SQLCA.SQLCODE=0 THEN 
			   
			
			
			IF li_id_par_aperte_scad=li_id_par_aperte AND (NOT ISNULL(ld_imp_scadenza) &
				   											           OR ld_imp_scadenza<>0) THEN
		      
				
				
				
            select id_valuta into :ll_val_scad
				from scadenza where id_scadenza=:li_id_scadenza;				
				select fn_conv_valuta(:ll_valuta_reg_pd,:ld_imp_scadenza,:ll_val_scad) into :ld_imp_scadenza from sys.dummy;
				ld_imp_scadenza=f_round_2(ll_val_par,ld_imp_scadenza)
				select fn_conv_valuta(:ll_valuta_reg_pd,:ld_scad_originale,:ll_val_par) into :ld_scad_originale from sys.dummy;
				ld_scad_originale=f_round_2(ll_val_par,ld_scad_originale)
				
				
				INSERT INTO "mov_scadenza"  
							 ( "id_mov_scadenza",   
								"id_scadenza",   
								"id_mov_partita",   
								"data",   
								"importo",   
								"imp_valuta",   
								"note",   
								"id_azienda" )  
					VALUES ( null,   
								:li_id_scadenza,   
								:ll_id_mov_partita,   
								:ld_data_scadenza,   
								:ld_imp_scadenza,   
								:ld_imp_scadenza,   
								:ls_note,   
								1 )  ;
				
				if sqlca.sqlcode<>0 then
					messagebox("Attenzione!", "Gestione chiusura scadenze fallita! 304 updateend dw_mov_contabile_gd")
				else
					
					if ld_imp_scadenza=ld_scad_originale then
						update scadenza
						set esito_pagamento='P'
						where id_scadenza=:li_id_scadenza;
					end if	
				end if
				
			END IF

		END IF
			
		FETCH scadenze_cur INTO :li_id_par_aperte_scad,:ld_imp_scadenza, :li_id_scadenza, &
		   						   :ld_data_scadenza, :ls_note, :ld_scad_originale;
	LOOP
   CLOSE scadenze_cur;
	
	FETCH partite_cur INTO :li_id_par_aperte, :ld_importo_par, :li_id_reg_pd, :li_num_riga, & 
                          :ld_data_mov, :ld_scad_originale;
LOOP

CLOSE partite_cur;

commit;

string ls_cc
select centri_costo into :ls_cc
from pers_par_sistema;
if ls_cc='S' then	uf_calc_cdc_ia()	

DELETE FROM "gest_chiudi_partite" WHERE "gest_chiudi_partite"."id_reg_now"=:ll_reg_now; 
DELETE FROM "gest_chiudi_scadenze"  WHERE "gest_chiudi_scadenze"."id_reg_now"=:ll_reg_now; 
commit;

cb_OK.enabled=true
cb_Nuovo.enabled=true
cb_Cancella.enabled=true

end event

event ue_modify;

Event ue_attiva_dettagli()
end event

event losefocus;call super::losefocus;THIS.SetRowFocusIndicator(p_arrowl)
end event

event ue_key;call super::ue_key;

long ll_CurrRow
decimal ldc_dare, ldc_avere

CHOOSE CASE key
	CASE KeyTab!
		ll_CurrRow = THIS.GetRow()
		ldc_dare = THIS.uf_GetItemDecimal(ll_CurrRow, "dare")
		ldc_avere = THIS.uf_GetItemDecimal(ll_CurrRow, "avere")
		
		IF (THIS.GetRow()=THIS.RowCount()) AND (keyflags<>1) AND (THIS.GetColumnName()="avere" OR THIS.GetColumnName()="dare") THEN
			IF NOT (IsNull(ldc_dare) AND IsNull(ldc_avere)) THEN
				THIS.Event Post ue_insert(0, 0)
			END IF	
		END IF
		
	CASE KeyDownArrow!
		IF (THIS.GetRow() = THIS.RowCount()) THEN
			THIS.Event Post ue_insert(0, 0)
		END IF
END CHOOSE

end event

event clicked;

THIS.SetRow(row)

if dwo.name="conto_descrizione_sw" or dwo.name="conto_codice_sw" then
	trigger event ue_key(keyF4!, 0)  
end if

long ll_RetVal


end event

event retrieveend;long i, ll_mov, ll_test

for i=1 to this.rowcount()
	 ll_mov=this.getitemnumber(i,'id_mov_contabile')
	 select count(*) into :ll_test from mov_partita 
	 where id_mov_contabile=:ll_mov;
	 if ll_test=1 then this.setitem(i,'test_protect','S')
next		 

end event

event doubleclicked;call super::doubleclicked;if dwo.name="conto_descrizione_t" then
	if object.conto_descrizione_t.text="Descrizione Conto" then
		object.conto_descrizione_t.text="Par. IVA Conto"
	else
		object.conto_descrizione_t.text="Descrizione Conto"
	end if
end if
end event

type tabpage_partite_aperte from userobject within tab_mov_contabile
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2715
integer height = 752
long backcolor = 79741120
string text = "Partite Aperte"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_mov_partita_conto_gd dw_mov_partita_conto_gd
end type

on tabpage_partite_aperte.create
this.dw_mov_partita_conto_gd=create dw_mov_partita_conto_gd
this.Control[]={this.dw_mov_partita_conto_gd}
end on

on tabpage_partite_aperte.destroy
destroy(this.dw_mov_partita_conto_gd)
end on

type dw_mov_partita_conto_gd from u_dw_master_main within tabpage_partite_aperte
event ue_post_retrieve ( )
integer x = 23
integer y = 16
integer width = 2674
integer height = 628
integer taborder = 1
string dataobject = "d_mov_partita_conto_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_mov_contabile"

end event

event rowfocuschanged;call super::rowfocuschanged;

dw_mov_partita_conto_gd.SelectRow(0,FALSE)
dw_mov_partita_conto_gd.SelectRow(currentrow, TRUE)
end event

event ue_retrieve;


long ll_CurrRow, ll_RetVal

IF ib_retrieve_partite = TRUE THEN
	ll_RetVal = Super::Event ue_retrieve(wparam, lparam)
END IF

ll_CurrRow = dw_mov_partita_conto_gd.GetRow()

IF ll_CurrRow > 0 THEN
	dw_mov_partita_conto_gd.SelectRow(ll_CurrRow, TRUE)
end if

RETURN ll_RetVal



end event

event ue_keystop;

end event

event ue_update;
end event

event ue_insert;
end event

type cbx_retain from checkbox within w_reg_pd_cx
integer x = 933
integer y = 20
integer width = 416
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "M&antieni Profilo:"
boolean lefttext = true
end type

type pb_1 from picturebutton within w_reg_pd_cx
integer x = 2601
integer y = 916
integer width = 119
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\about.png"
string disabledname = "s:\pb\commonframework\simbolo euro.bmp"
alignment htextalign = left!
end type

event clicked;
long ll_m,ll_mes
ll_m=dw_reg_pd_pn_ff.ModifiedCount( ) +dw_reg_pd_pn_ff.deletedcount()+ &
 tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.ModifiedCount()+ tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.deletedcount()+&
 tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.ModifiedCount()+ tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.deletedcount()+&
 tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.ModifiedCount()+ tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.deletedcount()+&
 tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.ModifiedCount()+ tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.deletedcount()
if ll_m>0 then
	ll_mes=messagebox("Information","Alcuni dati non sono stati salvati è possibile che vadano persi.~r~nVuoi continuare?",information!,okcancel!)
end if
if ll_mes=1 then
	long ll_id_valuta
	long ll_id_reg,ll_nrighe,i
	decimal{4} ld_parita
	if ib_euro=true then
		ll_id_valuta=dw_reg_pd_pn_ff.getitemnumber(1,"id_valuta_cod")
		select parita_euro
		into :ld_parita
		from valuta
		where id_valuta=:ll_id_valuta;
		if sqlca.sqlcode=0 then
			
			dw_reg_pd_pn_ff.setitem(1,"ceuro",ld_parita)
			dw_reg_pd_pn_ff.object.importo.visible=0
			dw_reg_pd_pn_ff.object.reg_pd_imp_valuta.visible=0
			dw_reg_pd_pn_ff.object.importo.x=2817
			dw_reg_pd_pn_ff.object.reg_pd_imp_valuta.x=2817
			dw_reg_pd_pn_ff.object.importo_euro.visible=1
			dw_reg_pd_pn_ff.object.valuta_euro.visible=1
			dw_reg_pd_pn_ff.object.importo_euro.x=2268
			dw_reg_pd_pn_ff.object.valuta_euro.x=2268
			
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.setitem(1,"euro",ld_parita)
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.documento.visible=0
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.totale.visible=0
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.differenza.visible=0
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.documento.x=2122
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.totale.x=2561
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.differenza.x=3018
			
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.documento_euro.visible=1
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.totale_euro.visible=1
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.differenza_euro.visible=1
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.documento_euro.x=321
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.totale_euro.x=915
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.differenza_euro.x=1601
			
			
			ll_id_reg=dw_reg_pd_pn_ff.getitemnumber(1,"id_reg_pd")
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.dataobject="d_mov_iva_euro_gd"
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.settransobject(sqlca)
			tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.retrieve(ll_id_reg)
			ll_nrighe=tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.rowcount()
			FOR i=1 TO ll_nrighe
				tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.setitem(i,"euro",ld_parita)
			NEXT
	
			
			
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.dataobject="d_mov_contabile_euro_gd"
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.settransobject(sqlca)
			tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.retrieve(ll_id_reg)
			ll_nrighe=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.rowcount()
			for i=1 to ll_nrighe
				tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.setitem(i,"ceuro",ld_parita)
			next
			
			
			ll_id_reg=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(1,"id_mov_contabile")
			tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.dataobject="d_mov_partita_conto_euro_gd"
			tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.settransobject(sqlca)
			tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.retrieve(ll_id_reg)
			ll_nrighe=tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.rowcount()
			for i=1 to ll_nrighe
				tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.setitem(i,"ceuro",ld_parita)
			next
		else
			messagebox("Informazione","Controllare di avere inserito la parità euro nella valuta")
		end if
		ib_euro=false
	else
		
		dw_reg_pd_pn_ff.object.importo.visible=1
		dw_reg_pd_pn_ff.object.reg_pd_imp_valuta.visible=1
		dw_reg_pd_pn_ff.object.importo.x=2268
		dw_reg_pd_pn_ff.object.reg_pd_imp_valuta.x=2268
		dw_reg_pd_pn_ff.object.importo_euro.visible=0
		dw_reg_pd_pn_ff.object.valuta_euro.visible=0
		dw_reg_pd_pn_ff.object.importo_euro.x=2817
		dw_reg_pd_pn_ff.object.valuta_euro.x=2817
		
		
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.documento_euro.visible=0
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.totale_euro.visible=0
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.differenza_euro.visible=0
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.documento_euro.x=2122
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.totale_euro.x=2561
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.differenza_euro.x=3018
		
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.documento.visible=1
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.totale.visible=1
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.differenza.visible=1
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.documento.x=321
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.totale.x=915
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_ff.object.differenza.x=1601
			
		
		ll_id_reg=dw_reg_pd_pn_ff.getitemnumber(1,"id_reg_pd")
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.dataobject="d_mov_iva_gd"
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.settransobject(sqlca)
		tab_mov_contabile.tabpage_mov_iva.dw_mov_iva_gd.retrieve(ll_id_reg)
		
		
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.dataobject="d_mov_contabile_gd"
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.settransobject(sqlca)
		tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.retrieve(ll_id_reg)
		
		ll_id_reg=tab_mov_contabile.tabpage_mov_contabile.dw_mov_contabile_gd.getitemnumber(1,"id_mov_contabile")
		tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.dataobject="d_mov_partita_conto_gd"
		tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.settransobject(sqlca)
		tab_mov_contabile.tabpage_partite_aperte.dw_mov_partita_conto_gd.retrieve(ll_id_reg)
		ib_euro=true
	end if
end if
end event

type pb_cespiti from picturebutton within w_reg_pd_cx
integer x = 2437
integer y = 916
integer width = 119
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Azienda2.png"
alignment htextalign = left!
end type

event clicked;long ll_id_reg
if dw_reg_pd_pn_ff.rowcount()>0 then
	ll_id_reg=dw_reg_pd_pn_ff.getitemnumber(1, "id_reg_pd")
	openwithparm(w_reg_cespiti_sintetica_rpt, ll_id_reg)
end if
end event

