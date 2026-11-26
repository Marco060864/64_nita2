forward
global type w_riga_dis_banca_cx from w_p_data
end type
type dw_riga_dis_banca_gd from u_dw_master_main within w_riga_dis_banca_cx
end type
type st_riga_dis_banca_gd_t from statictext within w_riga_dis_banca_cx
end type
type cb_ricalcola_importo_distinta from commandbutton within w_riga_dis_banca_cx
end type
type st_ricalcola_importo_distinta from statictext within w_riga_dis_banca_cx
end type
type cb_contabilizzazione from commandbutton within w_riga_dis_banca_cx
end type
type p_stampa from picture within w_riga_dis_banca_cx
end type
type dw_dis_banca_ff from u_dw_master_main within w_riga_dis_banca_cx
end type
type p_1 from picture within w_riga_dis_banca_cx
end type
type cb_contabilizza_uno_per_uno from commandbutton within w_riga_dis_banca_cx
end type
type dw_riga_unica_gd from datawindow within w_riga_dis_banca_cx
end type
end forward

global type w_riga_dis_banca_cx from w_p_data
integer width = 2935
integer height = 1552
string title = "Distinte"
long backcolor = 78682240
dw_riga_dis_banca_gd dw_riga_dis_banca_gd
st_riga_dis_banca_gd_t st_riga_dis_banca_gd_t
cb_ricalcola_importo_distinta cb_ricalcola_importo_distinta
st_ricalcola_importo_distinta st_ricalcola_importo_distinta
cb_contabilizzazione cb_contabilizzazione
p_stampa p_stampa
dw_dis_banca_ff dw_dis_banca_ff
p_1 p_1
cb_contabilizza_uno_per_uno cb_contabilizza_uno_per_uno
dw_riga_unica_gd dw_riga_unica_gd
end type
global w_riga_dis_banca_cx w_riga_dis_banca_cx

type prototypes

end prototypes

type variables
s_con_effetti istr_con_effetti
s_distinta is_distinta
end variables

forward prototypes
public subroutine uf_contabilizza ()
public function long uf_trova_conto (long al_id_sog_commerciale)
public subroutine uf_aggiorna_scadenza (long al_id_scadenza[])
public subroutine uf_accedi_protetti (string as_campo)
public subroutine wf_set_edit_format ()
public subroutine wf_setta_importo (datawindow adw_scad)
public subroutine uf_contabilizza_uno_per_volta ()
end prototypes

public subroutine uf_contabilizza ();

long ll_CurrRow_ff, ll_CurrRow_gd, ll_id_conto_mc[], ll_i, ll_id_sog_commerciale, ll_id_reg_pd, ll_id_scad
long ll_id_esercizio, ll_id_valuta_i, ll_id_valuta_f, ll_null
long ll_id_registro, ll_num_progressivo, ll_id_par_aperta[], ll_NULL_array[], ll_id_scadenza[], ll_importo
integer li_RetVal, li_tipo_registrazione
decimal ldc_tot_distinta, ldc_importo_mc[], ldc_NULL, ldc_NULL_array[], ldc_tmp_importo
char lc_segno_mc[]
date ld_data_registrazione, ld_data_scadenza[]
boolean lb_mc_iva[], ok_cont 
string ls_descr_registro, ls_desc_tipo_pagam[]
long  ll_tipo_cont
CONSTANT CHAR LCC_DARE = "D"
CONSTANT CHAR LCC_AVERE = "A"

ok_cont = true

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

SetNull(ldc_NULL)
SetNull(ll_id_registro)
SetNull(ll_num_progressivo)

ll_CurrRow_ff = dw_dis_banca_ff.GetRow()
ll_CurrRow_gd = dw_riga_dis_banca_gd.GetRow()

ldc_tot_distinta = 0 

SetNull(ll_NULL)
ll_id_esercizio = dw_dis_banca_ff.getitemnumber(1,"id_esercizio")
ll_id_valuta_f  = f_proponi_valuta(ll_NULL, ll_id_esercizio)

FOR ll_i = 1 to dw_riga_dis_banca_gd.RowCount()
	
	
	ldc_tmp_importo = 0
	ll_id_scad = dw_riga_dis_banca_gd.uf_GetItemDecimal(ll_i, "id_scadenza") 
	select importo
	into :ldc_tmp_importo
	from scadenza 
	where id_scadenza = :ll_id_scad;
	if isnull(ldc_tmp_importo) then ldc_tmp_importo = 0
	ll_id_valuta_i = dw_riga_dis_banca_gd.GetItemnumber(ll_i, "id_valuta_i") 
	
	select fn_conv_valuta(:ll_id_valuta_i, :ldc_tmp_importo, :ll_id_valuta_f)
	into :ldc_tmp_importo
	from sys.dummy;				
	
	ldc_tot_distinta = ldc_tot_distinta + ldc_tmp_importo
	
	
	ll_importo = 	 dw_riga_dis_banca_gd.uf_GetItemDecimal(ll_i, "scadenza_importo")  	
	if isnull(ll_importo) then
		ok_cont = false
		exit
	end if
next

IF ok_cont = true then
	
IF NOT IsNull(istr_con_effetti.l_id_prof_registrazione) AND &
	NOT IsNull(istr_con_effetti.i_tipo_registrazione) AND &
	(ll_CurrRow_ff > 0) THEN
				
	
	CHOOSE CASE istr_con_effetti.c_tipo_distinta
		CASE "A"

			CHOOSE CASE istr_con_effetti.i_tipo_registrazione
				CASE 1, 3, 6
					
					ll_id_conto_mc[1] = istr_con_effetti.l_id_conto_1
					lc_segno_mc[1]    = LCC_DARE
					ldc_importo_mc[1] = ldc_tot_distinta
					SetNull(ll_id_par_aperta[1])
					SetNull(ll_id_scadenza[1])
					lb_mc_iva[1] = FALSE
					
					FOR ll_i = 1 TO dw_riga_dis_banca_gd.RowCount()
						ll_id_sog_commerciale = dw_riga_dis_banca_gd.GetItemNumber(ll_i, "id_sog_commerciale")
						ll_id_conto_mc[ll_i + 1] = uf_trova_conto(ll_id_sog_commerciale)
						lc_segno_mc[ll_i + 1]    = LCC_AVERE
						
						
						ldc_tmp_importo = 0
						ll_id_scad = dw_riga_dis_banca_gd.uf_GetItemDecimal(ll_i, "id_scadenza") 
						select importo
						into :ldc_tmp_importo
						from scadenza 
						where id_scadenza = :ll_id_scad;
						if isnull(ldc_tmp_importo) then ldc_tmp_importo = 0
						ll_id_valuta_i = dw_riga_dis_banca_gd.GetItemnumber(ll_i, "id_valuta_i") 
						
						select fn_conv_valuta(:ll_id_valuta_i, :ldc_tmp_importo, :ll_id_valuta_f)
						into :ldc_tmp_importo
						from sys.dummy;				
						
						
						ldc_importo_mc[ll_i + 1] = ldc_tmp_importo
						
						
						ll_id_par_aperta[ll_i + 1] = dw_riga_dis_banca_gd.GetItemNumber(ll_i, "scadenza_id_par_aperta")
						ll_id_scadenza[ll_i + 1] = dw_riga_dis_banca_gd.GetItemNumber(ll_i, "id_scadenza")
						lb_mc_iva[ll_i + 1] = FALSE
					NEXT
				CASE 2, 4, 5
					
					ll_id_conto_mc[1] = istr_con_effetti.l_id_conto_1
					lc_segno_mc[1]    = LCC_DARE
					ldc_importo_mc[1] = ldc_tot_distinta
					SetNull(ll_id_par_aperta[1])
					SetNull(ll_id_scadenza[1])
					lb_mc_iva[1] = FALSE
		
					ll_id_conto_mc[2] = istr_con_effetti.l_id_conto_2
					lc_segno_mc[2]    = LCC_AVERE
					ldc_importo_mc[2] = ldc_tot_distinta
					SetNull(ll_id_par_aperta[2])
					SetNull(ll_id_scadenza[2])
					lb_mc_iva[2] = FALSE
			END CHOOSE
			
		CASE "P"				
			CHOOSE CASE istr_con_effetti.i_tipo_registrazione
				CASE 1
					
					ll_id_conto_mc[1] = istr_con_effetti.l_id_conto_1
					lc_segno_mc[1]    = LCC_AVERE
					ldc_importo_mc[1] = ldc_tot_distinta
					SetNull(ll_id_par_aperta[1])
					SetNull(ll_id_scadenza[1])
					lb_mc_iva[1] = FALSE
					
					FOR ll_i = 1 TO dw_riga_dis_banca_gd.RowCount()
						ll_id_sog_commerciale = dw_riga_dis_banca_gd.GetItemNumber(ll_i, "id_sog_commerciale")
						ll_id_conto_mc[ll_i + 1] = uf_trova_conto(ll_id_sog_commerciale)
						lc_segno_mc[ll_i + 1]    = LCC_DARE
						
						
						ldc_tmp_importo = 0
						ll_id_scad = dw_riga_dis_banca_gd.uf_GetItemDecimal(ll_i, "id_scadenza") 
						select importo
						into :ldc_tmp_importo
						from scadenza 
						where id_scadenza = :ll_id_scad;
						if isnull(ldc_tmp_importo) then ldc_tmp_importo = 0
						ll_id_valuta_i = dw_riga_dis_banca_gd.GetItemnumber(ll_i, "id_valuta_i") 
						
						select fn_conv_valuta(:ll_id_valuta_i, :ldc_tmp_importo, :ll_id_valuta_f)
						into :ldc_tmp_importo
						from sys.dummy;				
						
						
						ldc_importo_mc[ll_i + 1] = ldc_tmp_importo
						
						
						ll_id_par_aperta[ll_i + 1] = dw_riga_dis_banca_gd.GetItemNumber(ll_i, "scadenza_id_par_aperta")
						ll_id_scadenza[ll_i + 1] = dw_riga_dis_banca_gd.GetItemNumber(ll_i, "id_scadenza")
						lb_mc_iva[ll_i + 1] = FALSE
					NEXT

		END CHOOSE
	END CHOOSE
	
	ld_data_registrazione = istr_con_effetti.d_data_registrazione
	
	
   FOR ll_i = 1 TO dw_riga_dis_banca_gd.RowCount()
		ld_data_scadenza[ll_i+1]   = dw_riga_dis_banca_gd.GetItemDate(ll_i, "scadenza_data_scadenza")
		ls_desc_tipo_pagam[ll_i+1] = trim(dw_riga_dis_banca_gd.GetItemString(ll_i, "descrizione"))
   NEXT
	
	lu_reg_pd.uf_data_scadenza(ld_data_scadenza)
   lu_reg_pd.uf_desc_tipo_pagam(ls_desc_tipo_pagam)
	
	
	lu_reg_pd.uf_id_prof_registrazione(istr_con_effetti.l_id_prof_registrazione)
	lu_reg_pd.uf_id_registro(ll_id_registro)
	lu_reg_pd.uf_num_progressivo(ll_num_progressivo)
	
	lu_reg_pd.uf_data_registrazione(ld_data_registrazione)
	
	lu_reg_pd.uf_descrizione(istr_con_effetti.s_des_contabile)
	lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
	lu_reg_pd.uf_segno_mc(lc_segno_mc)
	lu_reg_pd.uf_importo_mc(ldc_importo_mc)
	lu_reg_pd.uf_id_par_aperta(ll_id_par_aperta)
	lu_reg_pd.uf_invert_mov_partita(FALSE)
	lu_reg_pd.uf_crea_mov_partita(TRUE)
	lu_reg_pd.uf_crea_mov_scadenza(TRUE)
	lu_reg_pd.uf_id_scadenza(ll_id_scadenza)
	lu_reg_pd.uf_mc_iva(lb_mc_iva)
	lu_reg_pd.uf_id_esercizio(ll_id_esercizio) 
	lu_reg_pd.uf_id_valuta(ll_id_valuta_f) 
	
	ll_id_reg_pd = lu_reg_pd.uf_crea()
	
	IF ll_id_reg_pd > 0 THEN
		uf_aggiorna_scadenza(ll_id_scadenza)
		
		
		ll_tipo_cont = istr_con_effetti.i_tipo_registrazione
		dw_dis_banca_ff.setitem(ll_CurrRow_ff, "dis_banca_tipo_contabilizzazione", ll_tipo_cont)
		dw_dis_banca_ff.triggerEvent ("update") 		
		
	else 
		messagebox ('ATTENZIONE', 'impossibile creare la registrazione',stopsign!) 
	END IF
END IF
else
	messagebox ('ATTENZIONE', 'Non sono stati impostati correttamente ~r~ntutti i valori della RIBA n. ' + string(ll_i) + ', verificare')
end if	
end subroutine

public function long uf_trova_conto (long al_id_sog_commerciale);

long ll_RetVal, ll_id_conto
string ls_codice

IF NOT IsNull(al_id_sog_commerciale) THEN
	SELECT dba.sog_commerciale.id_conto,
			 dba.sog_commerciale.codice
		INTO :ll_id_conto,
			  :ls_codice
		FROM sog_commerciale
		WHERE sog_commerciale.id_sog_commerciale = :al_id_sog_commerciale ;
		
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			CHOOSE CASE ll_id_conto
				CASE IS > 0
					ll_RetVal = ll_id_conto
				CASE ELSE
					MessageBox("Contabilizzazione Distinte", "Attenzione: Il Soggetto Commerciale con codice " + ls_codice + "~rnon ha un conto collegato.")
					ll_RetVal = 0
			END CHOOSE

		CASE -1
			MessageBox("Errore sul DataBase", "w_riga_dis_banca_cx / uf_trova_conto / 1")
			ll_RetVal = 0
	END CHOOSE
	
END IF

RETURN ll_RetVal
end function

public subroutine uf_aggiorna_scadenza (long al_id_scadenza[]);

long ll_i, ll_id_banca_azienda, ll_gg_min_cal_esposizione
char lc_esito_pagamento
date ld_data_scadenza, ld_data_cond, ld_data_pagamento

IF UpperBound(al_id_scadenza) > 0 THEN
	FOR ll_i = 1 TO UpperBound(al_id_scadenza)
		IF al_id_scadenza[ll_i] > 0 THEN
			SELECT
				scadenza.esito_pagamento,
				scadenza.data_scadenza,
				scadenza.id_banca_azienda
			INTO
				:lc_esito_pagamento,
				:ld_data_scadenza,
				:ll_id_banca_azienda
			FROM
				dba.scadenza
			WHERE
				scadenza.id_scadenza = :al_id_scadenza[ll_i]
			USING
				SQLCA;
		
			CHOOSE CASE SQLCA.SQLCode
				CASE 0
					IF (lc_esito_pagamento = 'P') AND (NOT IsNull(ll_id_banca_azienda)) THEN
						SetNull(ll_gg_min_cal_esposizione)
						SELECT
							gg_min_cal_esposizione
						INTO
							:ll_gg_min_cal_esposizione
						FROM
							con_banca_azienda
						WHERE
							id_banca_azienda = :ll_id_banca_azienda AND
							data_condizione = (
							SELECT
								max(data_condizione)
							FROM
								con_banca_azienda
							WHERE
								id_banca_azienda = :ll_id_banca_azienda)
						USING
							SQLCA;
						IF NOT IsNull(ll_gg_min_cal_esposizione) THEN
							ld_data_pagamento = RelativeDate(ld_data_scadenza, ll_gg_min_cal_esposizione)
							UPDATE
								scadenza
							SET
								data_pagamento = :ld_data_pagamento
							WHERE
								scadenza.id_scadenza = :al_id_scadenza[ll_i]
							USING
								SQLCA;
							
							IF (SQLCA.SQLCode = 0) AND (SQLCA.SQLNRows = 1) THEN
								COMMIT USING SQLCA;
							END IF
						END IF
					END IF
			END CHOOSE
		END IF

	NEXT
END IF
end subroutine

public subroutine uf_accedi_protetti (string as_campo);
long ll_CurrRow, ll_id_registro
string ls_tipo_registro
dwItemStatus ldwis_status

ll_CurrRow = dw_dis_banca_ff.GetRow()
ldwis_status = dw_dis_banca_ff.GetItemStatus(ll_CurrRow, 0,Primary!)

CHOOSE CASE as_campo
	CASE "dis_banca_tipo_contabilizzazione"
		dw_dis_banca_ff.Object.dis_banca_tipo_contabilizzazione.Protect = 0
		dw_dis_banca_ff.SetColumn("dis_banca_tipo_contabilizzazione")
	
END CHOOSE

end subroutine

public subroutine wf_set_edit_format ();
long		ll_id_valuta, ll_row
string	ls_format, ls_edit

ll_row = dw_dis_banca_ff.getrow()
if (ll_row > 0) then 
	ll_id_valuta = dw_dis_banca_ff.getitemnumber(1, "id_valuta")
	ls_edit = f_valu_edit(ll_id_valuta)
	ls_format = f_valu_mask(ll_id_valuta)
	
	dw_riga_dis_banca_gd.modify("cc_importo_riga.edit.format = '" + ls_edit + "'")
	dw_riga_dis_banca_gd.modify("scadenza_importo.edit.format = '" + ls_edit + "'")	
	dw_dis_banca_ff.modify("tot_distinta.edit.format = '" + ls_edit + "'") 
	
	dw_dis_banca_ff.modify("tot_distinta.format = '" + ls_format + "'") 
	dw_riga_dis_banca_gd.modify("tot_distinta.format = '" + ls_format + "'") 
	dw_riga_dis_banca_gd.modify("cc_importo_riga.format = '" + ls_format + "'")
	dw_riga_dis_banca_gd.modify("scadenza_importo.format = '" + ls_format + "'")		
end if

end subroutine

public subroutine wf_setta_importo (datawindow adw_scad);

decimal ld_importo, ld_importo_scad
long ll_id_valuta_i, ll_id_valuta_f, i, ll_rows,ll_id_par_aperta
date ld_data_scadenza, ld_data_reg, ld_data_partita

ll_rows = adw_scad.rowcount()

for i=1 to ll_rows
	ll_id_valuta_i = adw_scad.getitemnumber(i,"id_valuta_i")
	ll_id_valuta_f = adw_scad.getitemnumber(i,"id_valuta")
	ld_data_scadenza = adw_scad.getitemdate(i,"scadenza_data_scadenza")
	
	ld_importo     = adw_scad.getitemdecimal(i,"importo")
	
	if isnull(ll_id_valuta_i) or ll_id_valuta_i = 0 then		
		ld_data_reg = adw_scad.getitemdate(i,"data_registrazione")
		SELECT id_valuta 
		into :ll_id_valuta_i
		FROM esercizio 
		WHERE data_inizio <= :ld_data_reg AND data_fine >= :ld_data_reg;
		
		if sqlca.sqlcode <> 0 then	
			
			ll_id_par_aperta = adw_scad.getitemnumber(i,"scadenza_id_par_aperta")
			select data_partita
			into :ld_data_partita
			from par_aperta 
			where id_par_aperta = :ll_id_par_aperta;
			
			if sqlca.sqlcode <> 0 then				
				
				ld_data_scadenza = adw_scad.getitemdate(i,"scadenza_data_scadenza")
		
				SELECT id_valuta 
				into :ll_id_valuta_i
				FROM esercizio 
				WHERE data_inizio <= :ld_data_scadenza AND data_fine >= :ld_data_scadenza;
				if sqlca.sqlcode = 0 then 
					select fn_conv_valuta(:ll_id_valuta_i, :ld_importo, :ll_id_valuta_f)
					into :ld_importo_scad
					from sys.dummy;		
					
					adw_scad.setitem(i,"id_valuta_i",ll_id_valuta_i)		
					adw_scad.setitem(i,"scadenza_importo",ld_importo_scad)		
				end if
			else
				SELECT id_valuta 
				into :ll_id_valuta_i
				FROM esercizio 
				WHERE data_inizio <= :ld_data_partita AND data_fine >= :ld_data_partita;
				if sqlca.sqlcode = 0 then 
					select fn_conv_valuta(:ll_id_valuta_i, :ld_importo, :ll_id_valuta_f)
					into :ld_importo_scad
					from sys.dummy;		
					
					adw_scad.setitem(i,"id_valuta_i",ll_id_valuta_i)		
					adw_scad.setitem(i,"scadenza_importo",ld_importo_scad)		
				end if				
			end if
		else						
			select fn_conv_valuta(:ll_id_valuta_i, :ld_importo, :ll_id_valuta_f)
			into :ld_importo_scad
			from sys.dummy;		
			
			adw_scad.setitem(i,"id_valuta_i",ll_id_valuta_i)		
			adw_scad.setitem(i,"scadenza_importo",ld_importo_scad)
		end if		
	end if
next
end subroutine

public subroutine uf_contabilizza_uno_per_volta ();

long ll_CurrRow_ff, ll_CurrRow_gd, ll_id_conto_mc[], ll_i, ll_id_sog_commerciale, ll_id_reg_pd, ll_id_scad
long ll_id_esercizio, ll_id_valuta_i, ll_id_valuta_f, ll_null
long ll_id_registro, ll_num_progressivo, ll_id_par_aperta[], ll_NULL_array[], ll_id_scadenza[], ll_importo
integer li_RetVal, li_tipo_registrazione
decimal ldc_tot_distinta, ldc_importo_mc[], ldc_NULL, ldc_NULL_array[], ldc_tmp_importo
char lc_segno_mc[]
date ld_data_registrazione, ld_data_scadenza[]
boolean lb_mc_iva[], ok_cont 
string ls_descr_registro, ls_desc_tipo_pagam[], ls_data
long  ll_tipo_cont
CONSTANT CHAR LCC_DARE = "D"
CONSTANT CHAR LCC_AVERE = "A"

ok_cont = true

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

SetNull(ldc_NULL)
SetNull(ll_id_registro)
SetNull(ll_num_progressivo)

ll_CurrRow_ff = dw_dis_banca_ff.GetRow()
ll_CurrRow_gd = dw_riga_unica_gd.GetRow()

ldc_tot_distinta = 0 

SetNull(ll_NULL)
ll_id_esercizio = dw_dis_banca_ff.getitemnumber(1,"id_esercizio")
ll_id_valuta_f  = f_proponi_valuta(ll_NULL, ll_id_esercizio)

FOR ll_i = 1 to dw_riga_unica_gd.RowCount()
	
	
	ldc_tmp_importo = 0
	ll_id_scad = dw_riga_unica_gd.GetItemnumber(ll_i, "id_scadenza") 
	select importo
	into :ldc_tmp_importo
	from scadenza 
	where id_scadenza = :ll_id_scad;
	if isnull(ldc_tmp_importo) then ldc_tmp_importo = 0
	ll_id_valuta_i = dw_riga_unica_gd.GetItemnumber(ll_i, "id_valuta_i") 
	
	select fn_conv_valuta(:ll_id_valuta_i, :ldc_tmp_importo, :ll_id_valuta_f)
	into :ldc_tmp_importo
	from sys.dummy;				
	
	ldc_tot_distinta = ldc_tot_distinta + ldc_tmp_importo
	
	
	ll_importo = 	 dw_riga_unica_gd.GetItemDecimal(ll_i, "scadenza_importo")  	
	if isnull(ll_importo) then
		ok_cont = false
		exit
	end if
next

IF ok_cont = true then
	
IF NOT IsNull(istr_con_effetti.l_id_prof_registrazione) AND &
	NOT IsNull(istr_con_effetti.i_tipo_registrazione) AND &
	(ll_CurrRow_ff > 0) THEN
				
	
	CHOOSE CASE istr_con_effetti.c_tipo_distinta
		CASE "A"

			CHOOSE CASE istr_con_effetti.i_tipo_registrazione
				CASE 1, 3, 6
					
					ll_id_conto_mc[1] = istr_con_effetti.l_id_conto_1
					lc_segno_mc[1]    = LCC_DARE
					ldc_importo_mc[1] = ldc_tot_distinta
					SetNull(ll_id_par_aperta[1])
					SetNull(ll_id_scadenza[1])
					lb_mc_iva[1] = FALSE
					
					FOR ll_i = 1 TO dw_riga_unica_gd.RowCount()
						ll_id_sog_commerciale = dw_riga_unica_gd.GetItemNumber(ll_i, "id_sog_commerciale")
						ll_id_conto_mc[ll_i + 1] = uf_trova_conto(ll_id_sog_commerciale)
						lc_segno_mc[ll_i + 1]    = LCC_AVERE
						
						
						ldc_tmp_importo = 0
						ll_id_scad = dw_riga_unica_gd.GetItemnumber(ll_i, "id_scadenza") 
						select importo
						into :ldc_tmp_importo
						from scadenza 
						where id_scadenza = :ll_id_scad;
						if isnull(ldc_tmp_importo) then ldc_tmp_importo = 0
						ll_id_valuta_i = dw_riga_unica_gd.GetItemnumber(ll_i, "id_valuta_i") 
						
						select fn_conv_valuta(:ll_id_valuta_i, :ldc_tmp_importo, :ll_id_valuta_f)
						into :ldc_tmp_importo
						from sys.dummy;				
						
						
						ldc_importo_mc[ll_i + 1] = ldc_tmp_importo
						
						
						ll_id_par_aperta[ll_i + 1] = dw_riga_unica_gd.GetItemNumber(ll_i, "scadenza_id_par_aperta")
						ll_id_scadenza[ll_i + 1] = dw_riga_unica_gd.GetItemNumber(ll_i, "id_scadenza")
						lb_mc_iva[ll_i + 1] = FALSE
					NEXT
		END CHOOSE
	END CHOOSE
	
	ld_data_registrazione = dw_riga_unica_gd.GetItemDate(1, "scadenza_data_scadenza")
	
	
   FOR ll_i = 1 TO dw_riga_unica_gd.RowCount()
		ld_data_scadenza[ll_i+1]   = dw_riga_unica_gd.GetItemDate(ll_i, "scadenza_data_scadenza")
		ls_desc_tipo_pagam[ll_i+1] = trim(dw_riga_unica_gd.GetItemString(ll_i, "descrizione"))
   NEXT
	
	lu_reg_pd.uf_data_scadenza(ld_data_scadenza)
	//mm 07-11-14 se la data scadenza è oltre l'esercizio corrente
	//devo scegliere l'esercizio corretto o avvertire che NON esiste
	
	setnull(ll_id_esercizio)
	select id_esercizio
	into :ll_id_esercizio
	from dba.esercizio
	where data_inizio <= :ld_data_registrazione
	and data_fine>= :ld_data_registrazione;
	if isnull(ll_id_esercizio) or ll_id_esercizio=0 then
		messagebox("Attenzione!", "La data scadenza: "+string(ld_data_registrazione)+&
		" va oltre l'esercizio corrente e NON è stato trovato	l'esercizio corretto!")
		return
	end if
	
	
   lu_reg_pd.uf_desc_tipo_pagam(ls_desc_tipo_pagam)
	
	
	lu_reg_pd.uf_id_prof_registrazione(istr_con_effetti.l_id_prof_registrazione)
	lu_reg_pd.uf_id_registro(ll_id_registro)
	lu_reg_pd.uf_num_progressivo(ll_num_progressivo)
	
	lu_reg_pd.uf_data_registrazione(ld_data_registrazione)
	
	lu_reg_pd.uf_descrizione(istr_con_effetti.s_des_contabile)
	lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
	lu_reg_pd.uf_segno_mc(lc_segno_mc)
	lu_reg_pd.uf_importo_mc(ldc_importo_mc)
	lu_reg_pd.uf_id_par_aperta(ll_id_par_aperta)
	lu_reg_pd.uf_invert_mov_partita(FALSE)
	lu_reg_pd.uf_crea_mov_partita(TRUE)
	lu_reg_pd.uf_crea_mov_scadenza(TRUE)
	lu_reg_pd.uf_id_scadenza(ll_id_scadenza)
	lu_reg_pd.uf_mc_iva(lb_mc_iva)
	lu_reg_pd.uf_id_esercizio(ll_id_esercizio) 
	lu_reg_pd.uf_id_valuta(ll_id_valuta_f) 
	
	//per non visualizzare le registrazioni 011111
	lu_reg_pd.ii_DisplayMode=0
	
	ll_id_reg_pd = lu_reg_pd.uf_crea()
	
	IF ll_id_reg_pd > 0 THEN
		uf_aggiorna_scadenza(ll_id_scadenza)
		
		
		ll_tipo_cont = istr_con_effetti.i_tipo_registrazione
		dw_dis_banca_ff.setitem(ll_CurrRow_ff, "dis_banca_tipo_contabilizzazione", ll_tipo_cont)
		dw_dis_banca_ff.triggerEvent ("update") 		
		
	else 
		messagebox ('ATTENZIONE', 'Impossibile creare la registrazione',stopsign!) 
	END IF
END IF
else
	messagebox ('ATTENZIONE', 'Non sono stati impostati correttamente ~r~ntutti i valori della RIBA n. ' + string(ll_i) + ', verificare')
end if	
end subroutine

on w_riga_dis_banca_cx.create
int iCurrent
call super::create
this.dw_riga_dis_banca_gd=create dw_riga_dis_banca_gd
this.st_riga_dis_banca_gd_t=create st_riga_dis_banca_gd_t
this.cb_ricalcola_importo_distinta=create cb_ricalcola_importo_distinta
this.st_ricalcola_importo_distinta=create st_ricalcola_importo_distinta
this.cb_contabilizzazione=create cb_contabilizzazione
this.p_stampa=create p_stampa
this.dw_dis_banca_ff=create dw_dis_banca_ff
this.p_1=create p_1
this.cb_contabilizza_uno_per_uno=create cb_contabilizza_uno_per_uno
this.dw_riga_unica_gd=create dw_riga_unica_gd
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_riga_dis_banca_gd
this.Control[iCurrent+2]=this.st_riga_dis_banca_gd_t
this.Control[iCurrent+3]=this.cb_ricalcola_importo_distinta
this.Control[iCurrent+4]=this.st_ricalcola_importo_distinta
this.Control[iCurrent+5]=this.cb_contabilizzazione
this.Control[iCurrent+6]=this.p_stampa
this.Control[iCurrent+7]=this.dw_dis_banca_ff
this.Control[iCurrent+8]=this.p_1
this.Control[iCurrent+9]=this.cb_contabilizza_uno_per_uno
this.Control[iCurrent+10]=this.dw_riga_unica_gd
end on

on w_riga_dis_banca_cx.destroy
call super::destroy
destroy(this.dw_riga_dis_banca_gd)
destroy(this.st_riga_dis_banca_gd_t)
destroy(this.cb_ricalcola_importo_distinta)
destroy(this.st_ricalcola_importo_distinta)
destroy(this.cb_contabilizzazione)
destroy(this.p_stampa)
destroy(this.dw_dis_banca_ff)
destroy(this.p_1)
destroy(this.cb_contabilizza_uno_per_uno)
destroy(this.dw_riga_unica_gd)
end on

event open;call super::open;string ls_param

idw_master = This.dw_dis_banca_ff
idw_master.is_list = Message.PowerObjectParm
ls_param	= idw_master.is_list.s_win_parametri

choose case ls_param
	case "A"
		il_HelpTopic = 331
	case "P"
		il_HelpTopic = 336
end choose


idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "dis_banca.id_distinta_banca"


end event

event ue_master_delete;call super::ue_master_delete;

IF (idw_master.Event ue_delete(0, 0) = 0) THEN
	
	ib_AskForSave = FALSE
	IF (idw_master.uf_To_Update() > 0) THEN
		IF (idw_master.Event ue_update(0, 0) = 0) THEN
			ib_AskForSave = TRUE
			idw_master.is_list.s_modo = modo_inserisci
			idw_master.Event ue_insert(0, 0)
		END IF
	END IF
END IF
idw_master.SetFocus()
end event

event ue_post_open;call super::ue_post_open;long ll_tipo_cont

ll_tipo_cont = dw_dis_banca_ff.getitemnumber(1,"dis_banca_tipo_contabilizzazione")

if ll_tipo_cont = 2 or 	ll_tipo_cont = 5 or 	ll_tipo_cont = 6 or 	ll_tipo_cont = 10 then
	cb_contabilizzazione.enabled=false
end if



long	ll_id_valuta

ll_id_valuta = dw_dis_banca_ff.getitemnumber(1, "id_valuta") 
if isnull(ll_id_valuta) or ll_id_valuta = 0 then ll_id_valuta = long(idw_master.is_list.s_par_value[1]) 

if ll_id_valuta > 0 then
	dw_riga_dis_banca_gd.is_list.l_identifica[2] = ll_id_valuta
	dw_riga_dis_banca_gd.PostEvent("ue_retrieve")
else
	SELECT id_valuta
	INTO	 :ll_id_valuta
	FROM	 par_sistema
	;	
end if

dw_dis_banca_ff.setitem(1, "id_valuta", ll_id_valuta)

wf_set_edit_format()
end event

type p_msg_log from w_p_data`p_msg_log within w_riga_dis_banca_cx
end type

type p_crescente from w_p_data`p_crescente within w_riga_dis_banca_cx
end type

type p_decrescente from w_p_data`p_decrescente within w_riga_dis_banca_cx
end type

type cb_ok from w_p_data`cb_ok within w_riga_dis_banca_cx
integer x = 37
integer width = 233
end type

type cb_annulla from w_p_data`cb_annulla within w_riga_dis_banca_cx
integer x = 288
integer width = 247
end type

type cb_nuovo from w_p_data`cb_nuovo within w_riga_dis_banca_cx
integer x = 553
integer width = 238
end type

type cb_inserisci from w_p_data`cb_inserisci within w_riga_dis_banca_cx
integer x = 2112
integer width = 238
end type

type cb_cancella from w_p_data`cb_cancella within w_riga_dis_banca_cx
integer x = 2373
integer width = 238
end type

type cb_salva from w_p_data`cb_salva within w_riga_dis_banca_cx
integer x = 2633
end type

type tab_1 from w_p_data`tab_1 within w_riga_dis_banca_cx
boolean visible = false
integer x = 2171
integer y = 284
integer width = 187
integer height = 100
integer taborder = 50
long backcolor = 79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 151
integer height = -20
end type

type cb_ricerca from w_p_data`cb_ricerca within w_riga_dis_banca_cx
integer x = 1344
integer y = 0
end type

type dw_riga_dis_banca_gd from u_dw_master_main within w_riga_dis_banca_cx
event ue_somma ( )
integer x = 41
integer y = 912
integer width = 2866
integer height = 532
integer taborder = 20
string dataobject = "d_riga_dis_banca_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_somma;

long ll_i, ll_id_riga_distinta_banca
decimal ld_importo, ld_importo_scad
long ll_id_valuta_i, ll_id_valuta_f
date ld_data_reg, ld_data_scadenza
FOR ll_i=1 TO This.RowCount()

   
	ll_id_valuta_i = this.getitemnumber(ll_i,"id_valuta_i")
	ll_id_valuta_f = this.getitemnumber(ll_i,"id_valuta")
	
	if isnull(ll_id_valuta_i) or ll_id_valuta_i = 0 then		
		ld_data_reg = this.getitemdate(ll_i,"data_registrazione")
		SELECT id_valuta 
		into :ll_id_valuta_i
		FROM esercizio 
		WHERE data_inizio <= :ld_data_reg AND data_fine >= :ld_data_reg;
		
		if sqlca.sqlcode <> 0 then	
			ld_data_scadenza = this.getitemdate(ll_i,"scadenza_data_scadenza")
	
			SELECT id_valuta 
			into :ll_id_valuta_i
			FROM esercizio 
			WHERE data_inizio <= :ld_data_scadenza AND data_fine >= :ld_data_scadenza;

		end if		
	end if

	ll_id_riga_distinta_banca = This.GetItemNumber(ll_i,"id_riga_distinta_banca")	
	
	
   select sum(scadenza.importo) 
	into :ld_importo
   from scadenza
   where scadenza.id_riga_distinta_banca=:ll_id_riga_distinta_banca;	
	if isnull(ld_importo) then ld_importo = 0

	select fn_conv_valuta(:ll_id_valuta_i, :ld_importo, :ll_id_valuta_f)
	into :ld_importo_scad
	from sys.dummy;	
	
   update riga_dis_banca 
	set riga_dis_banca.imp_totale=:ld_importo_scad
   where riga_dis_banca.id_riga_distinta_banca=:ll_id_riga_distinta_banca;
	commit;
	
	
		
NEXT

IF SQLCA.sqlcode <> 0 THEN
	messagebox("Errore", SQLCA.sqlerrtext)
END IF

TriggerEvent("ue_retrieve")
end event

event ue_init;call super::ue_init;is_title = "Righe Distinta Banca"
is_list.s_identifica[1] = "id_distinta_banca"
is_list.s_identifica[2] = "id_valuta"		
end event

event doubleclicked;long 		ll_row
string	ls_colname

ll_row = GetRow()

if ll_row > 0 then

	ls_colname = this.getColumnName()
	CHOOSE CASE ls_colname
	
		CASE "riga_dis_banca_num_riga", "cc_importo_riga", "riga_dis_banca_rif_documento"
			is_list.s_win_chiave[1] = "id_riga_distinta_banca"
			is_list.s_win_zoom 		= "w_riga_dis_banca_ff"
			is_list.s_win_parametri = idw_master.is_list.s_win_parametri
			
			is_list.s_par_name[1]  = "id_valuta"
			
			Call Super::DoubleClicked 
	
		CASE "scadenza_data_scadenza", "scadenza_importo", "valuta_descrizione", "scadenza_imp_valuta"
			if IsNull(GetItemNumber(ll_row,"id_scadenza")) then
				MessageBox("Avviso","Non esiste scadenza per questa riga.")
			else
				if IsNull(GetItemNumber(ll_row,"id_sog_commerciale")) then
					MessageBox("Avviso","Non esiste Soggetto Commerciale per questa riga." + &
								"~rNon si può vedere il detaglio delle scadenze.")
				else
					is_list.s_win_chiave[1] = "id_scadenza"
					is_list.s_win_zoom = "w_scadenza_cx"
					Call Super::DoubleClicked 
				end if
			end if
	
	END CHOOSE

else 
	Call Super::DoubleClicked
end if

string ls_name, ls_row1, ls_row2
long ll_totrows, ll_row1, ll_row2
date ld_row1, ld_row2

ls_name = dwo.name  

ll_totrows = dw_riga_dis_banca_gd.rowcount()

CHOOSE CASE ls_name
	CASE "riga_dis_banca_num_riga_t"
		
		if ll_totrows > 0 then
			ll_row1 = dw_riga_dis_banca_gd.getitemnumber(1,"riga_dis_banca_num_riga")
			if isnull(ll_row1) = TRUE then ll_row1 = 0
	      ll_row2 = dw_riga_dis_banca_gd.getitemnumber(ll_totrows,"riga_dis_banca_num_riga")
			if isnull(ll_row2) = TRUE then ll_row2 = 0		
						
			if ll_row1 <= ll_row2 then 
				dw_riga_dis_banca_gd.setsort("riga_dis_banca_num_riga D")
			else 
				dw_riga_dis_banca_gd.setsort("riga_dis_banca_num_riga A")
			end if
		end if
		
	CASE "cc_importo_riga_t"
		if ll_totrows > 0 then
			ll_row1 = dw_riga_dis_banca_gd.getitemnumber(1,"cc_importo_riga")
			if isnull(ll_row1) = TRUE then ll_row1 = 0		
			ll_row2 = dw_riga_dis_banca_gd.getitemnumber(ll_totrows,"cc_importo_riga")	
			if isnull(ll_row2) = TRUE then ll_row2 = 0				
				
			if ll_row1 <= ll_row2 then 
				dw_riga_dis_banca_gd.setsort("cc_importo_riga D")
			else 
				dw_riga_dis_banca_gd.setsort("cc_importo_riga A")
			end if
		end if
		
	CASE "riga_dis_banca_rif_documento_t"
		if ll_totrows > 0 then
			ls_row1 = dw_riga_dis_banca_gd.getitemstring(1,"riga_dis_banca_rif_documento")
			if isnull(ls_row1) = TRUE then ls_row1 = ""
			ls_row2 = dw_riga_dis_banca_gd.getitemstring(ll_totrows,"riga_dis_banca_rif_documento")	
			if isnull(ls_row2) = TRUE then ls_row2 = ""		
		
			if ls_row1 <= ls_row2 then 
				dw_riga_dis_banca_gd.setsort("riga_dis_banca_rif_documento D")
			else 
				dw_riga_dis_banca_gd.setsort("riga_dis_banca_rif_documento A")
			end if		
		end if

	CASE "scadenza_data_scadenza_t"
		if ll_totrows > 0 then		
			ld_row1 = dw_riga_dis_banca_gd.getitemdate(1,"scadenza_data_scadenza")
			if isnull(ld_row1) = TRUE then ld_row1 = date('01/01/00')
			ld_row2 = dw_riga_dis_banca_gd.getitemdate(ll_totrows,"scadenza_data_scadenza")		
			if isnull(ld_row2) = TRUE then ld_row2 = date('01/01/00')
				
			if ld_row1 <= ld_row2 then 
				dw_riga_dis_banca_gd.setsort("scadenza_data_scadenza D")
			else 
				dw_riga_dis_banca_gd.setsort("scadenza_data_scadenza A")
			end if				
		end if
		
	CASE "scadenza_importo_t"
		if ll_totrows > 0 then		
			ll_row1 = dw_riga_dis_banca_gd.getitemnumber(1,"scadenza_importo")
			if isnull(ll_row1) = TRUE then ll_row1 = 0		
			ll_row2 = dw_riga_dis_banca_gd.getitemnumber(ll_totrows,"scadenza_importo")		
			if isnull(ll_row2) = TRUE then ll_row2 = 0
				
			if ll_row1 <= ll_row2 then 
				dw_riga_dis_banca_gd.setsort("scadenza_importo D")
			else 
				dw_riga_dis_banca_gd.setsort("scadenza_importo A")
			end if				
		end if
		
	CASE "valuta_descrizione_t"
		if ll_totrows > 0 then		
			ls_row1 = dw_riga_dis_banca_gd.getitemstring(1,"valuta_descrizione")
			if isnull(ls_row1) = TRUE then ls_row1 = ""		
			ls_row2 = dw_riga_dis_banca_gd.getitemstring(ll_totrows,"valuta_descrizione")		
			if isnull(ls_row2) = TRUE then ls_row2 = ""
				
			if ls_row1 <= ls_row2 then 
				dw_riga_dis_banca_gd.setsort("valuta_descrizione D")
			else 
				dw_riga_dis_banca_gd.setsort("valuta_descrizione A")
			end if				
		end if
		
	CASE "scadenza_imp_valuta_t"
		if ll_totrows > 0 then		
			ll_row1 = dw_riga_dis_banca_gd.getitemnumber(1,"scadenza_imp_valuta")
			if isnull(ll_row1) = TRUE then ll_row1 = 0		
			ll_row2 = dw_riga_dis_banca_gd.getitemnumber(ll_totrows,"scadenza_imp_valuta")		
			if isnull(ll_row2) = TRUE then ll_row2 = 0
				
			if ll_row1 <= ll_row2 then 
				dw_riga_dis_banca_gd.setsort("scadenza_imp_valuta D")
			else 
				dw_riga_dis_banca_gd.setsort("scadenza_imp_valuta A")
			end if				
		end if		
						
END CHOOSE

dw_riga_dis_banca_gd.sort()


end event

event ue_insert;

long ll_CurrRow, ll_id_esercizio, ll_id_distinta_banca, ll_tipo_cont
char lc_tipo_scadenza

ll_CurrRow = dw_dis_banca_ff.GetRow()
ll_id_esercizio      = dw_dis_banca_ff.GetItemNumber(ll_CurrRow, "id_esercizio")
lc_tipo_scadenza     = dw_dis_banca_ff.GetItemString(ll_CurrRow, "tipo")
ll_id_distinta_banca = dw_dis_banca_ff.GetItemNumber(ll_CurrRow, "id_distinta_banca")

is_distinta.l_id_esercizio  = ll_id_esercizio
is_distinta.c_tipo_scadenza = lc_tipo_scadenza
is_distinta.l_id_dis_banca  = ll_id_distinta_banca

is_distinta.l_righe         = dw_riga_dis_banca_gd.GetItemNumber(ll_CurrRow, "max_riga")

ll_tipo_cont = dw_dis_banca_ff.GetItemNumber(ll_CurrRow, "dis_banca_tipo_contabilizzazione")

if ll_tipo_cont = 7 then
	OpenWithParm(w_distinta_ff, is_distinta)
else
	messagebox ('Attenzione', "E' impossibile inserire una nuova riga su di una distinta contabilizzata")
end if
	
	THIS.Event ue_retrieve(0, 0)
	
end event

event ue_update;call super::ue_update;integer li_i

li_i = 0
end event

event retrieveend;

end event

type st_riga_dis_banca_gd_t from statictext within w_riga_dis_banca_cx
integer x = 37
integer y = 832
integer width = 2066
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
string text = " Righe della Distinta Banca"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_ricalcola_importo_distinta from commandbutton within w_riga_dis_banca_cx
integer x = 2117
integer y = 832
integer width = 699
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricalcola Importo Distinta"
end type

event clicked;

dw_dis_banca_ff.update() 

long ll_CurRow_ff, ll_CurRow_gd
decimal ldc_tot_distinta

ll_CurRow_ff = dw_dis_banca_ff.GetRow()
ll_CurRow_gd = dw_riga_dis_banca_gd.GetRow()

if dw_riga_dis_banca_gd.RowCount() > 0 then
	
		dw_riga_dis_banca_gd.TriggerEvent("ue_somma")
	
end if

IF (ll_CurRow_ff > 0) AND (ll_CurRow_gd > 0) THEN
	ldc_tot_distinta = dw_riga_dis_banca_gd.uf_GetItemDecimal(ll_CurRow_gd, "tot_distinta")
	dw_dis_banca_ff.SetItem(ll_CurRow_ff, "tot_distinta", ldc_tot_distinta)

	ib_AskForSave = FALSE
	dw_dis_banca_ff.Event ue_update(0, 0)
	
END IF
end event

type st_ricalcola_importo_distinta from statictext within w_riga_dis_banca_cx
integer x = 2825
integer y = 832
integer width = 87
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 276856960
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_contabilizzazione from commandbutton within w_riga_dis_banca_cx
integer x = 1472
integer y = 44
integer width = 475
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Contabilizzazione"
end type

event clicked;

long ll_CurrRow_ff, ll_tipo_cont, ll_riga, ll_contabilizza

ll_riga=dw_dis_banca_ff.getrow()
ll_contabilizza=dw_dis_banca_ff.getitemnumber(ll_riga,"dis_banca_tipo_contabilizzazione")

if ll_contabilizza=7 then

Message.Processed = TRUE
ll_CurrRow_ff = dw_dis_banca_ff.GetRow()

	istr_con_effetti.c_tipo_distinta = dw_dis_banca_ff.GetItemString(ll_CurrRow_ff, "tipo")
	OpenWithParm(w_con_effetti_ff, istr_con_effetti)
	
	istr_con_effetti = Message.PowerObjectParm
	IF NOT IsNull(istr_con_effetti.l_id_prof_registrazione) AND &
		NOT IsNull(istr_con_effetti.i_tipo_registrazione) THEN 
		
		
		
		uf_contabilizza()
	
	
	END IF
else
	messagebox("Attenzione!!!","La distinta è già stata contabilizzata")
end if

end event

type p_stampa from picture within w_riga_dis_banca_cx
integer x = 1970
integer y = 40
integer width = 123
integer height = 100
boolean bringtotop = true
string picturename = "C:\nita\icone\Stampa.png"
boolean focusrectangle = false
end type

event clicked;

string			ls_msg_a, ls_msg_b
string			ls_doc_stampato, ls_stampato
boolean			lb_definit, lb_can_go
long				ll_row, ll_id_distinta_banca
string			ls_nome_report, ls_dir, ls_selection_formula
window			lw_win
long				ll_retv, ll_sqlcode, ll_sqlrows
integer			li_outdev, li_stampa_ok
integer 			li_retvalue

ll_row = idw_master.GetRow()
if ll_row > 0 then
	
	if (idw_master.uf_to_update() > 0) OR (idw_master.GetItemStatus(ll_row,0,Primary!)=New!) then	
		
		ib_askforsave=FALSE
		li_retvalue=idw_master.Event ue_update(0,0)
	else
		li_retvalue=0
	end if
	
	iuo_msg_log.uf_new_text("Stampa Distinta Banca",3)
	if li_retvalue>0 then
	
		MessageBox("Stampa Distinta Banca","Impossibile salvare il documento,~n indispensabile per avviare la stampa",Exclamation!)
		iuo_msg_log.uf_new_text("Stampa di Riga Distinta Banca",3)
		iuo_msg_log.uf_new_text("Impossibile salvare il documento,~n indispensabile per avviare la stampa",4)
		RETURN 0
	end if
	
	
	
	ls_msg_a = "Stampa Distinta Banca; Avviso!"
	ls_doc_stampato = "documento stampato"
	ls_stampato = "S"
	
	
	ll_id_distinta_banca = idw_master.GetItemNumber(ll_row, "id_distinta_banca")
	
	openwithparm(w_stampa_dis_banca_rpt, ll_id_distinta_banca)
end if
	
end event

type dw_dis_banca_ff from u_dw_master_main within w_riga_dis_banca_cx
integer x = 37
integer y = 160
integer width = 2857
integer height = 644
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dis_banca_ff"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_distinta_banca"
is_list.s_identifica[2] = "id_valuta"	

iudw_children[1] = dw_riga_dis_banca_gd

is_list.s_win_chiave[1] = "id_riga_distinta_banca"
is_title = "Distinte"


end event

event doubleclicked;call super::doubleclicked;

uf_accedi_protetti(dwo.name)
end event

event itemchanged;
CHOOSE CASE dwo.name 
	CASE "id_valuta", "id_distinta_des"
		dw_riga_dis_banca_gd.is_list.l_identifica[2] = Long(data)		
		dw_riga_dis_banca_gd.PostEvent("ue_retrieve")			
		Post wf_set_edit_format()
		cb_ricalcola_importo_distinta.PostEvent("clicked") 
END CHOOSE
end event

type p_1 from picture within w_riga_dis_banca_cx
integer x = 1312
integer y = 40
integer width = 137
integer height = 104
boolean bringtotop = true
string picturename = "C:\nita\icone\articoli.png"
boolean focusrectangle = false
end type

event clicked;

long ll_row, ll_id, ll_prog_dis, ll_retv
s_distinta par_dis


ll_row= dw_dis_banca_ff.getrow()
if ll_row > 0 then   
	ll_id =dw_dis_banca_ff.getitemnumber(ll_row, "id_distinta_banca")
par_dis.l_id_dis_banca=ll_id

OpenWithParm (w_sel_data_ff, par_dis)
end if            


end event

type cb_contabilizza_uno_per_uno from commandbutton within w_riga_dis_banca_cx
integer x = 823
integer y = 44
integer width = 475
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cont. Uno per Volta"
end type

event clicked;integer i

long ll_CurrRow_ff, ll_tipo_cont, ll_riga, ll_contabilizza

ll_riga=dw_dis_banca_ff.getrow()
ll_contabilizza=dw_dis_banca_ff.getitemnumber(ll_riga,"dis_banca_tipo_contabilizzazione")

if ll_contabilizza=7 then

	Message.Processed = TRUE
	ll_CurrRow_ff = dw_dis_banca_ff.GetRow()

	istr_con_effetti.c_tipo_distinta = dw_dis_banca_ff.GetItemString(ll_CurrRow_ff, "tipo")
	OpenWithParm(w_con_effetti_ff, istr_con_effetti)
	
	istr_con_effetti = Message.PowerObjectParm
	IF NOT IsNull(istr_con_effetti.l_id_prof_registrazione) AND &
		NOT IsNull(istr_con_effetti.i_tipo_registrazione) THEN 
		dw_riga_dis_banca_gd.setsort("scadenza_data_scadenza")
		dw_riga_dis_banca_gd.sort()
		for i=1 to dw_riga_dis_banca_gd.rowcount()
			dw_riga_unica_gd.reset()
			dw_riga_dis_banca_gd.rowscopy(i,i,primary!, dw_riga_unica_gd, 1, primary!)
			uf_contabilizza_uno_per_volta()
		next
		messagebox("OK!","La distinta è stata correttamente contabilizzata")	
	END IF
	
else
	messagebox("Attenzione!!!","La distinta è già stata contabilizzata")
end if

end event

type dw_riga_unica_gd from datawindow within w_riga_dis_banca_cx
boolean visible = false
integer x = 1413
integer y = 1008
integer width = 1486
integer height = 400
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_riga_dis_banca_gd"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

