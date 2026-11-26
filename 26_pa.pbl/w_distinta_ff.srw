forward
global type w_distinta_ff from w_wiz_main
end type
type cb_chiudi from commandbutton within w_distinta_ff
end type
type cb_crea from commandbutton within w_distinta_ff
end type
type tab_distinta from tab within w_distinta_ff
end type
type tabpage_distinta from userobject within tab_distinta
end type
type dw_distinta_filtro_ext_ff from u_dw_ext_main within tabpage_distinta
end type
type dw_distinta_ff from u_dw_pura within tabpage_distinta
end type
type tabpage_distinta from userobject within tab_distinta
dw_distinta_filtro_ext_ff dw_distinta_filtro_ext_ff
dw_distinta_ff dw_distinta_ff
end type
type tabpage_scadenze from userobject within tab_distinta
end type
type dw_distinta_ext_lt from u_dw_ext_main within tabpage_scadenze
end type
type cb_drop_all from commandbutton within tabpage_scadenze
end type
type cb_drop_many from commandbutton within tabpage_scadenze
end type
type cb_remove_many from commandbutton within tabpage_scadenze
end type
type cb_remove_all from commandbutton within tabpage_scadenze
end type
type dw_distinta_lt from u_dw_pura within tabpage_scadenze
end type
type tabpage_scadenze from userobject within tab_distinta
dw_distinta_ext_lt dw_distinta_ext_lt
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_distinta_lt dw_distinta_lt
end type
type tab_distinta from tab within w_distinta_ff
tabpage_distinta tabpage_distinta
tabpage_scadenze tabpage_scadenze
end type
end forward

global type w_distinta_ff from w_wiz_main
integer x = 432
integer y = 349
integer width = 2754
integer height = 1565
string title = "Creazione Distinta"
windowtype windowtype = response!
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_chiudi cb_chiudi
cb_crea cb_crea
tab_distinta tab_distinta
end type
global w_distinta_ff w_distinta_ff

type variables
DataWindow idw_source, idw_target
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
Decimal idc_imp_max_distinta
s_distinta is_distinta
char ic_tipo_scadenza
long il_id_banca_azienda, il_id_dis_banca

end variables

forward prototypes
public subroutine uf_drop_all ()
public subroutine uf_drop_many ()
public subroutine uf_remove_all ()
public subroutine uf_remove_many ()
public subroutine uf_drop (long al_row_source)
public subroutine uf_remove (long al_row_target)
public function string uf_componi_rif_documento (long al_id_par_aperta, long al_id_documento)
public function long uf_aggiorna_scadenza (long al_id_scadenza, long al_id_riga_dis_banca)
public function decimal uf_getitemdecimal (datawindow adw_dwobj, long al_row, string as_column)
public subroutine uf_genera_righe (long al_id_dis_banca)
public subroutine wf_set_format ()
public subroutine wf_setta_importo (datawindow adw_scad)
public function long uf_crea_riga_dis_banca (long al_id_distinta_banca, long al_num_riga, decimal adc_imp_totale, string as_rif_documento, character ac_esito_pagamento, long al_id_azienda, long al_id_scadenza)
end prototypes

event ue_crea_distinta;

long ll_CurrRow, ll_id_esercizio, ll_num_distinta, ll_new_id_dis_banca, ll_id_scadenza, ll_sql
date ld_data_distinta
decimal ldc_tot_scadenza_importo

long ll_NRows
ll_NRows = idw_target.RowCount()

IF ll_NRows > 0 THEN
	
	ll_CurrRow = tab_distinta.tabpage_distinta.dw_distinta_ff.GetRow()
	ll_id_esercizio = tab_distinta.tabpage_distinta.dw_distinta_ff.GetItemNumber(ll_CurrRow, "id_esercizio")
	ll_num_distinta = f_proponi_num_distinta(ll_id_esercizio)
	ld_data_distinta = tab_distinta.tabpage_distinta.dw_distinta_ff.GetItemDate(ll_CurrRow, "data_distinta")
	ll_CurrRow = idw_target.GetRow()
	
	ldc_tot_scadenza_importo = uf_GetItemDecimal(idw_target, ll_CurrRow, "tot_scadenza_importo")
	
	decimal 	ld_dec_significativi
	string	ls_tipo_arrotondamento
	long		ll_id_valuta
	
	SELECT v.dec_significativi, v.tipo_arrotondamento, v.id_valuta
	INTO	 :ld_dec_significativi, :ls_tipo_arrotondamento, :ll_id_valuta
	FROM	 valuta v, esercizio e
	WHERE  e.id_esercizio = :ll_id_esercizio
	AND	 v.id_valuta = e.id_valuta
	;
	
	ldc_tot_scadenza_importo = f_round(ldc_tot_scadenza_importo, ld_dec_significativi, ls_tipo_arrotondamento)
	
	
	IF il_id_banca_azienda = 0 THEN SetNull(il_id_banca_azienda)
	
	INSERT INTO dba.dis_banca  
				( id_esercizio,   
				  tipo,   
				  num_distinta,   
				  data_distinta,   
				  tot_distinta,   
				  id_banca_azienda,
				  id_azienda,
				  tipo_contabilizzazione,
				  id_valuta)  
	  VALUES ( :ll_id_esercizio,
				  :ic_tipo_scadenza,
				  :ll_num_distinta,
				  :ld_data_distinta,
				  :ldc_tot_scadenza_importo,
				  :il_id_banca_azienda,
				  1,
				  7,
				  :ll_id_valuta)  ;
	
	ll_sql = SQLCA.SQLCode 
	
	commit; 
		
	
	CHOOSE CASE ll_sql 
		CASE 0
			SELECT @@identity 
				INTO :ll_new_id_dis_banca
				FROM dba.dis_banca;
				
			uf_genera_righe(ll_new_id_dis_banca)
			
		CASE -1
			messagebox("ue_crea_distinta", SQLCA.SQLERRTEXT)
			
	END CHOOSE

END IF
end event

event ue_aggiungi_righe;

uf_genera_righe(il_id_dis_banca)
end event

public subroutine uf_drop_all ();

long ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo

ll_Rows = idw_source.RowCount()

ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	uf_drop(ll_i)
NEXT
idw_target.Sort()

ib_removing = FALSE
end subroutine

public subroutine uf_drop_many ();

long ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo

ll_Rows = idw_source.RowCount()

ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_source.IsSelected(ll_i) THEN
		uf_drop(ll_i)
	END IF
NEXT
idw_target.Sort()

ib_removing = FALSE
end subroutine

public subroutine uf_remove_all ();

long ll_Rows, ll_i

ll_Rows = idw_target.RowCount()

ib_removing = TRUE
FOR ll_i = ll_Rows TO 1 STEP -1
	uf_remove(ll_i)
NEXT
idw_source.Sort()
ib_removing = FALSE
end subroutine

public subroutine uf_remove_many ();

long ll_Rows, ll_i

ll_Rows = idw_target.RowCount()

ib_removing = TRUE
FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_target.IsSelected(ll_i) THEN
		uf_remove(ll_i)
	END IF
NEXT


idw_source.Sort()

idw_target.SelectRow(0, FALSE)
idw_target.Sort()
ib_removing = FALSE
end subroutine

public subroutine uf_drop (long al_row_source);

long ll_id_scadenza, ll_NewRow, ll_find, ll_id_tipo_pagamento_cod, ll_id_banca_azienda, ll_CurrRow
long ll_id_documento, ll_id_par_aperta, ll_id_sog_commerciale
date ld_data_scadenza, ld_data_documento
decimal ldc_imp_scadenza, ldc_tot_scadenza_importo
string ls_crag_soc, ls_search
char lc_tipo_scadenza, lc_esito_pagamento, lc_da_raggruppare

ll_CurrRow = idw_target.GetRow()

IF ll_CurrRow > 0 THEN 
	ldc_tot_scadenza_importo = uf_GetItemDecimal(idw_target, ll_CurrRow, "tot_scadenza_importo")
ELSE
	ldc_tot_scadenza_importo = 0
END IF

ll_id_scadenza           = idw_source.GetItemNumber(al_row_source, "scadenza_id_scadenza")
ld_data_scadenza         = idw_source.GetItemDate(al_row_source, "scadenza_data_scadenza")
ldc_imp_scadenza         = uf_GetItemDecimal(idw_source, al_row_source, "scadenza_importo")
ls_crag_soc              = idw_source.GetItemString(al_row_source, "crag_soc")
ld_data_documento        = idw_source.GetItemDate(al_row_source, "documento_data_documento")
lc_tipo_scadenza         = idw_source.GetItemString(al_row_source, "scadenza_tipo_scadenza")
ll_id_tipo_pagamento_cod = idw_source.GetItemNumber(al_row_source, "scadenza_id_tipo_pagamento_cod")
ll_id_banca_azienda      = idw_source.GetItemNumber(al_row_source, "scadenza_id_banca_azienda")
ll_id_documento          = idw_source.GetItemNumber(al_row_source, "scadenza_id_documento")
ll_id_par_aperta         = idw_source.GetItemNumber(al_row_source, "scadenza_id_par_aperta")
lc_esito_pagamento       = idw_source.GetItemString(al_row_source, "scadenza_esito_pagamento")
lc_da_raggruppare        = idw_source.GetItemString(al_row_source, "scadenza_scadenza_da_raggruppare")
ll_id_sog_commerciale    = idw_source.GetItemNumber(al_row_source, "scadenza_id_sog_commerciale")

ls_search = "scadenza_id_scadenza = " + string(ll_id_scadenza)
ll_find = idw_target.find(ls_search, 1, idw_target.RowCount())

IF ll_find = 0  THEN
	IF IsNull(idc_imp_max_distinta) OR idc_imp_max_distinta = 0 THEN
		ll_NewRow = idw_target.InsertRow(0)
		idw_target.SetItem(ll_NewRow, "scadenza_id_scadenza", ll_id_scadenza)
		idw_target.SetItem(ll_NewRow, "scadenza_data_scadenza", ld_data_scadenza)
		idw_target.SetItem(ll_NewRow, "scadenza_importo", ldc_imp_scadenza)
		idw_target.SetItem(ll_NewRow, "crag_soc", ls_crag_soc)
		idw_target.SetItem(ll_NewRow, "documento_data_documento", ld_data_documento)
		idw_target.SetItem(ll_NewRow, "scadenza_tipo_scadenza", lc_tipo_scadenza)
		idw_target.SetItem(ll_NewRow, "scadenza_id_tipo_pagamento_cod", ll_id_tipo_pagamento_cod)
		idw_target.SetItem(ll_NewRow, "scadenza_id_banca_azienda", ll_id_banca_azienda)
		idw_target.SetItem(ll_NewRow, "scadenza_id_documento", ll_id_documento)
		idw_target.SetItem(ll_NewRow, "scadenza_id_par_aperta", ll_id_par_aperta)
		idw_target.SetItem(ll_NewRow, "scadenza_esito_pagamento", lc_esito_pagamento)
		idw_target.SetItem(ll_NewRow, "scadenza_scadenza_da_raggruppare", lc_da_raggruppare)
		idw_target.SetItem(ll_NewRow, "scadenza_id_sog_commerciale", ll_id_sog_commerciale)

		
		idw_source.DeleteRow(al_row_source)


		
	ELSE
		IF (ldc_tot_scadenza_importo + ldc_imp_scadenza) <= idc_imp_max_distinta THEN
			ll_NewRow = idw_target.InsertRow(0)
			idw_target.SetItem(ll_NewRow, "scadenza_id_scadenza", ll_id_scadenza)
			idw_target.SetItem(ll_NewRow, "scadenza_data_scadenza", ld_data_scadenza)
			idw_target.SetItem(ll_NewRow, "scadenza_importo", ldc_imp_scadenza)
			idw_target.SetItem(ll_NewRow, "crag_soc", ls_crag_soc)
			idw_target.SetItem(ll_NewRow, "documento_data_documento", ld_data_documento)
			idw_target.SetItem(ll_NewRow, "scadenza_tipo_scadenza", lc_tipo_scadenza)
			idw_target.SetItem(ll_NewRow, "scadenza_id_tipo_pagamento_cod", ll_id_tipo_pagamento_cod)
			idw_target.SetItem(ll_NewRow, "scadenza_id_banca_azienda", ll_id_banca_azienda)
			idw_target.SetItem(ll_NewRow, "scadenza_id_documento", ll_id_documento)
			idw_target.SetItem(ll_NewRow, "scadenza_id_par_aperta", ll_id_par_aperta)
			idw_target.SetItem(ll_NewRow, "scadenza_esito_pagamento", lc_esito_pagamento)
			idw_target.SetItem(ll_NewRow, "scadenza_scadenza_da_raggruppare", lc_da_raggruppare)
			idw_target.SetItem(ll_NewRow, "scadenza_id_sog_commerciale", ll_id_sog_commerciale)

			idw_source.DeleteRow(al_row_source)

			
		END IF
	END IF

	
	idw_target.SelectRow(ll_NewRow, TRUE)
END IF

end subroutine

public subroutine uf_remove (long al_row_target);

long ll_id_scadenza, ll_find, ll_id_tipo_pagamento_cod, ll_id_banca_azienda, ll_id_par_aperta
long ll_id_documento, ll_NewRow, ll_id_sog_commerciale
date ld_data_scadenza, ld_data_documento
string ls_search, ls_crag_soc
decimal ldc_imp_scadenza
char lc_tipo_scadenza, lc_esito_pagamento, lc_da_raggruppare


ll_id_scadenza           = idw_target.GetItemNumber(al_row_target, "scadenza_id_scadenza")
ld_data_scadenza         = idw_target.GetItemDate(al_row_target, "scadenza_data_scadenza")
ldc_imp_scadenza         = uf_GetItemDecimal(idw_target, al_row_target, "scadenza_importo")
ls_crag_soc              = idw_target.GetItemString(al_row_target, "crag_soc")
ld_data_documento        = idw_target.GetItemDate(al_row_target, "documento_data_documento")
lc_tipo_scadenza         = idw_target.GetItemString(al_row_target, "scadenza_tipo_scadenza")
ll_id_tipo_pagamento_cod = idw_target.GetItemNumber(al_row_target, "scadenza_id_tipo_pagamento_cod")
ll_id_banca_azienda      = idw_target.GetItemNumber(al_row_target, "scadenza_id_banca_azienda")
ll_id_documento          = idw_target.GetItemNumber(al_row_target, "scadenza_id_documento")
ll_id_par_aperta         = idw_target.GetItemNumber(al_row_target, "scadenza_id_par_aperta")
lc_esito_pagamento       = idw_target.GetItemString(al_row_target, "scadenza_esito_pagamento")
lc_da_raggruppare        = idw_target.GetItemString(al_row_target, "scadenza_scadenza_da_raggruppare")
ll_id_sog_commerciale    = idw_target.GetItemNumber(al_row_target, "scadenza_id_sog_commerciale")

ll_NewRow = idw_source.InsertRow(0)
idw_source.SetItem(ll_NewRow, "scadenza_id_scadenza", ll_id_scadenza)
idw_source.SetItem(ll_NewRow, "scadenza_data_scadenza", ld_data_scadenza)
idw_source.SetItem(ll_NewRow, "scadenza_importo", ldc_imp_scadenza)
idw_source.SetItem(ll_NewRow, "crag_soc", ls_crag_soc)
idw_source.SetItem(ll_NewRow, "documento_data_documento", ld_data_documento)
idw_source.SetItem(ll_NewRow, "scadenza_tipo_scadenza", lc_tipo_scadenza)
idw_source.SetItem(ll_NewRow, "scadenza_id_tipo_pagamento_cod", ll_id_tipo_pagamento_cod)
idw_source.SetItem(ll_NewRow, "scadenza_id_banca_azienda", ll_id_banca_azienda)
idw_source.SetItem(ll_NewRow, "scadenza_id_documento", ll_id_documento)
idw_source.SetItem(ll_NewRow, "scadenza_id_par_aperta", ll_id_par_aperta)
idw_source.SetItem(ll_NewRow, "scadenza_esito_pagamento", lc_esito_pagamento)
idw_source.SetItem(ll_NewRow, "scadenza_scadenza_da_raggruppare", lc_da_raggruppare)
idw_source.SetItem(ll_NewRow, "scadenza_id_sog_commerciale", ll_id_sog_commerciale)

idw_source.SelectRow(ll_NewRow, TRUE)

idw_target.SetRow(al_row_target)

idw_target.DeleteRow(0)
end subroutine

public function string uf_componi_rif_documento (long al_id_par_aperta, long al_id_documento);

long ll_num_partita, ll_num_documento
string ls_RetVal
date ld_data_partita, ld_data_documento

IF NOT IsNull(al_id_par_aperta) THEN
	SELECT "par_aperta"."num_partita",
	       "par_aperta"."data_partita"
		INTO :ll_num_partita,
			  :ld_data_partita
		FROM par_aperta
		WHERE par_aperta.id_par_aperta = :al_id_par_aperta;
		
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			ls_RetVal = 'Numero ' + string(ll_num_partita) + ' del ' + string(ld_data_partita, "dd/mm/yyyy")
		CASE 100
			ls_RetVal = ""
	END CHOOSE

ELSE
	SELECT "documento"."num_documento",
	       "documento"."data_documento"
		INTO :ll_num_documento,
			  :ld_data_documento
		FROM documento
		WHERE documento.id_documento = :al_id_documento   ;
		
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			ls_RetVal = 'Numero ' + string(ll_num_documento) + ' del ' + string(ld_data_documento, "dd/mm/yyyy")
		CASE 100
			ls_RetVal = ""
	END CHOOSE

END IF

RETURN ls_RetVal
end function

public function long uf_aggiorna_scadenza (long al_id_scadenza, long al_id_riga_dis_banca);

long ll_sql

UPDATE "dba"."scadenza"  
	SET "id_riga_distinta_banca" = :al_id_riga_dis_banca,
		 "esito_pagamento" = 'D'
	WHERE "dba"."scadenza"."id_scadenza" = :al_id_scadenza ;
	
ll_sql = SQLCA.SQLCode 

commit; 

RETURN ll_sql 
end function

public function decimal uf_getitemdecimal (datawindow adw_dwobj, long al_row, string as_column);

decimal ld_value

ld_value = adw_dwobj.GetItemNumber(al_row,as_column)
if not (isNull(ld_value)) then
	ld_value = adw_dwobj.GetItemDecimal(al_row,as_column)
end if

return ld_value


end function

public subroutine uf_genera_righe (long al_id_dis_banca);

long ll_NRows, ll_i, ll_id_documento, ll_id_par_aperta, ll_numero, ll_new_id_riga_dis_banca
long ll_id_scadenza, ll_row_counter, lal_id_scadenza[], lal_empty[], ll_NULL, ll_j, ll_id_scadenza_old
date ld_data, ld_NULL
decimal ldc_imp_totale
string ls_rif_documento, ls_old_sort, ls_new_sort, ls_rif_ragg
char lc_da_raggruppare

decimal ldc_imp_totale_buf
date ld_data_scadenza_buf
long ll_id_sog_commerciale_buf, ll_id_tipo_pagamento_buf

long ll_id_valuta_i, ll_id_valuta_f, ll_id_esercizio
date ld_data_doc, ld_data_reg, ld_data_scadenza

ldc_imp_totale_buf = 0
ld_data_scadenza_buf = ld_NULL
ll_id_sog_commerciale_buf = 0
ll_id_tipo_pagamento_buf = 0

ll_NRows = idw_target.RowCount()
ls_old_sort = "scadenza_data_scadenza A, scadenza_importo A"
ls_new_sort = "scadenza_scadenza_da_raggruppare A, scadenza_data_scadenza A, scadenza_id_sog_commerciale A, scadenza_id_tipo_pagamento_cod A"
SetNull(ld_NULL)
SetNull(ll_NULL)
ll_row_counter = is_distinta.l_righe

tab_distinta.tabpage_distinta.dw_distinta_ff.Retrieve(al_id_dis_banca)

idw_target.SetSort(ls_new_sort)
idw_target.Sort()

FOR ll_i = 1 TO ll_NRows
	ldc_imp_totale = uf_GetItemDecimal(idw_target, ll_i, "scadenza_importo")		
	
	ll_id_scadenza = idw_target.GetItemNumber(ll_i, "scadenza_id_scadenza")
	
	
	ll_id_par_aperta = idw_target.GetItemNumber(ll_i, "scadenza_id_par_aperta")
	ll_id_documento = idw_target.GetItemNumber(ll_i, "scadenza_id_documento")
	ls_rif_documento = uf_componi_rif_documento(ll_id_par_aperta, ll_id_documento)

	lc_da_raggruppare = idw_target.GetItemString(ll_i, "scadenza_scadenza_da_raggruppare")

	CHOOSE CASE lc_da_raggruppare
		CASE 'S'
			
			IF (ldc_imp_totale_buf = 0) AND (ll_id_sog_commerciale_buf = 0) AND (ll_id_tipo_pagamento_buf = 0) THEN
				
				
				ldc_imp_totale_buf = ldc_imp_totale
				ld_data_scadenza_buf = idw_target.GetItemDate(ll_i, "scadenza_data_scadenza")
				ll_id_sog_commerciale_buf = idw_target.GetItemNumber(ll_i, "scadenza_id_sog_commerciale")
				ll_id_tipo_pagamento_buf = idw_target.GetItemNumber(ll_i, "scadenza_id_tipo_pagamento_cod")

				
				lal_id_scadenza[Upperbound(lal_id_scadenza) + 1] = ll_id_scadenza
				ls_rif_ragg=uf_componi_rif_documento(ll_id_par_aperta, ll_id_documento)
				
			ELSE
				IF ld_data_scadenza_buf = idw_target.GetItemDate(ll_i, "scadenza_data_scadenza") AND &
					ll_id_sog_commerciale_buf = idw_target.GetItemNumber(ll_i, "scadenza_id_sog_commerciale") AND &
					ll_id_tipo_pagamento_buf = idw_target.GetItemNumber(ll_i, "scadenza_id_tipo_pagamento_cod") then 
					
					
					
					
					ll_id_scadenza_old=ll_id_scadenza
					
					ldc_imp_totale_buf = ldc_imp_totale_buf + ldc_imp_totale
					
					lal_id_scadenza[Upperbound(lal_id_scadenza) + 1] = ll_id_scadenza
					
					ls_rif_ragg=ls_rif_ragg + uf_componi_rif_documento(ll_id_par_aperta, ll_id_documento)
					IF ll_i = ll_NRows THEN
						ll_row_counter = ll_row_counter + 1
						
						ll_new_id_riga_dis_banca = uf_crea_riga_dis_banca(al_id_dis_banca, &
																						  ll_row_counter,      &
																						  ldc_imp_totale_buf,  &
																						  ls_rif_documento,    &
																						  'E',                 &
																						  1,                   &
																						  ll_id_scadenza)
						FOR ll_j = 1 TO Upperbound(lal_id_scadenza)
							uf_aggiorna_scadenza(lal_id_scadenza[ll_j], ll_new_id_riga_dis_banca)
						NEXT
					end if
				ELSE 
					ll_row_counter = ll_row_counter + 1
					
					ll_new_id_riga_dis_banca = uf_crea_riga_dis_banca(al_id_dis_banca,     &
																					  ll_row_counter,      &
																					  ldc_imp_totale_buf,  &
																					  ls_rif_documento,    &
																					  'E',                 &
																					  1,                   &
																					  ll_id_scadenza_old)
					
					
					
					FOR ll_j = 1 TO Upperbound(lal_id_scadenza)
						uf_aggiorna_scadenza(lal_id_scadenza[ll_j], ll_new_id_riga_dis_banca)
					NEXT
					
					ls_rif_ragg=''
					lal_id_scadenza=lal_empty
					ldc_imp_totale_buf = ldc_imp_totale
					ld_data_scadenza_buf = idw_target.GetItemDate(ll_i, "scadenza_data_scadenza")
					ll_id_sog_commerciale_buf = idw_target.GetItemNumber(ll_i, "scadenza_id_sog_commerciale")
					ll_id_tipo_pagamento_buf = idw_target.GetItemNumber(ll_i, "scadenza_id_tipo_pagamento_cod")
					lal_id_scadenza[1] = ll_id_scadenza
					IF ll_i = ll_NRows THEN
						
						ll_row_counter = ll_row_counter + 1
						
						ll_new_id_riga_dis_banca = uf_crea_riga_dis_banca(al_id_dis_banca,     &
																					  ll_row_counter,      &
																					  ldc_imp_totale_buf,  &
																					  ls_rif_documento,    &
																					  'E',                 &
																					  1,                   &
																					  ll_id_scadenza)
						uf_aggiorna_scadenza(lal_id_scadenza[1], ll_new_id_riga_dis_banca)
					end if
					
					ll_id_scadenza_old=ll_id_scadenza
					
				END IF 
			END IF

		CASE else
			
			ll_row_counter = ll_row_counter + 1
			uf_crea_riga_dis_banca(al_id_dis_banca,  &
										  ll_row_counter,   &
										  ldc_imp_totale,   &
										  ls_rif_documento, &
										  'E',              &
										  1,                &
										  ll_id_scadenza)
			
			
			
			
			IF ll_i = ll_NRows and Upperbound(lal_id_scadenza)>0 THEN
						ll_new_id_riga_dis_banca = uf_crea_riga_dis_banca(al_id_dis_banca,     &
																					  ll_row_counter,      &
																					  ldc_imp_totale_buf,  &
																					  ls_rif_documento,    &
																					  'E',                 &
																					  1,                   &
																					  ll_id_scadenza_old)
						FOR ll_j = 1 TO Upperbound(lal_id_scadenza)
							uf_aggiorna_scadenza(lal_id_scadenza[ll_j], ll_new_id_riga_dis_banca)
						NEXT
					
			END IF 
										  
										  
		
	END CHOOSE

NEXT
idw_target.SetSort(ls_old_sort)
idw_target.Sort()
end subroutine

public subroutine wf_set_format ();
long		ll_id_valuta, ll_row
string	ls_format

ll_row = tab_distinta.tabpage_distinta.dw_distinta_ff.getrow()
if (ll_row > 0) then 
	ll_id_valuta = tab_distinta.tabpage_distinta.dw_distinta_ff.getitemnumber(ll_row, "id_valuta")
	ls_format = f_valu_mask(ll_id_valuta)
	
	tab_distinta.tabpage_scadenze.dw_distinta_ext_lt.modify("scadenza_importo.format = '" + ls_format + "'")
	tab_distinta.tabpage_scadenze.dw_distinta_ext_lt.modify("tot_scadenza_importo.format = '" + ls_format + "'")
end if

end subroutine

public subroutine wf_setta_importo (datawindow adw_scad);

decimal ld_importo, ld_importo_scad
long ll_id_valuta_i, ll_id_valuta_f, i, ll_rows,ll_id_par_aperta
date ld_data_scadenza, ld_data_reg, ld_data_partita

ll_rows = adw_scad.rowcount()

for i=1 to ll_rows
	ll_id_valuta_i = adw_scad.getitemnumber(i,"id_valuta_i")
	ll_id_valuta_f = adw_scad.getitemnumber(i,"id_valuta_f")
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

public function long uf_crea_riga_dis_banca (long al_id_distinta_banca, long al_num_riga, decimal adc_imp_totale, string as_rif_documento, character ac_esito_pagamento, long al_id_azienda, long al_id_scadenza);

long ll_new_id_riga_dis_banca

decimal 	ld_dec_significativi
string	ls_tipo_arrotondamento
	
SELECT v.dec_significativi, v.tipo_arrotondamento
INTO	 :ld_dec_significativi, :ls_tipo_arrotondamento
FROM	 valuta v, esercizio e, dis_banca d
WHERE  d.id_distinta_banca = :al_id_distinta_banca
AND	 e.id_esercizio = d.id_esercizio
AND	 v.id_valuta = e.id_valuta
;
	
adc_imp_totale = f_round(adc_imp_totale, ld_dec_significativi, ls_tipo_arrotondamento)

INSERT INTO dba.riga_dis_banca
			( id_distinta_banca,
			  num_riga,
			  imp_totale,
			  rif_documento,
			  esito_pagamento,
			  id_azienda )
  VALUES ( :al_id_distinta_banca,
			  :al_num_riga,
			  :adc_imp_totale,
			  :as_rif_documento,
			  :ac_esito_pagamento,
			  :al_id_azienda )  ;
			  
commit; 
			  
SELECT @@identity
	INTO :ll_new_id_riga_dis_banca
	FROM dba.riga_dis_banca;
uf_aggiorna_scadenza(al_id_scadenza, ll_new_id_riga_dis_banca)

RETURN ll_new_id_riga_dis_banca
end function

on w_distinta_ff.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_crea=create cb_crea
this.tab_distinta=create tab_distinta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_crea
this.Control[iCurrent+3]=this.tab_distinta
end on

on w_distinta_ff.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_crea)
destroy(this.tab_distinta)
end on

event open;call super::open;

long ll_CurrRow, ll_id_esercizio, ll_id_dis_banca
DataWindowChild dwc_drop
integer li_ret

string ls_sort

is_distinta      = Message.PowerObjectParm
ll_id_esercizio  = is_distinta.l_id_esercizio
ic_tipo_scadenza = is_distinta.c_tipo_scadenza
il_id_dis_banca  = is_distinta.l_id_dis_banca

CHOOSE CASE ic_tipo_scadenza		
	CASE "A"
		il_HelpTopic = 331
	CASE "P"		
		il_HelpTopic = 336
END CHOOSE


is_filter = "scadenza_tipo_scadenza = '" + ic_tipo_scadenza +"' AND scadenza_esito_pagamento = 'E'"

ib_removing = FALSE

idw_source = tab_distinta.tabpage_scadenze.dw_distinta_lt
idw_target = tab_distinta.tabpage_scadenze.dw_distinta_ext_lt

long		ll_id_valuta
string	ls_des_valuta

tab_distinta.tabpage_distinta.dw_distinta_ff.GetChild("id_valuta", dwc_drop)
dwc_drop.SetTransObject(SQLCA)
dwc_drop.Retrieve()

SELECT id_valuta
INTO	 :ll_id_valuta
FROM	 esercizio
WHERE	 id_esercizio = :ll_id_esercizio
;

Post wf_set_format()

idw_source.SetTransObject(SQLCA)
idw_source.Retrieve(ll_id_valuta)	


idw_source.SetFilter(is_filter)
idw_source.Filter()

ll_CurrRow = tab_distinta.tabpage_distinta.dw_distinta_filtro_ext_ff.GetRow()
IF ll_CurrRow = 0 THEN tab_distinta.tabpage_distinta.dw_distinta_filtro_ext_ff.InsertRow(0)

ll_CurrRow = tab_distinta.tabpage_distinta.dw_distinta_ff.GetRow()
IF ll_CurrRow = 0 THEN ll_CurrRow = tab_distinta.tabpage_distinta.dw_distinta_ff.InsertRow(0)

tab_distinta.tabpage_distinta.dw_distinta_ff.GetChild("id_esercizio", dwc_drop)
dwc_drop.SetTransObject(SQLCA)
dwc_drop.Retrieve()

tab_distinta.tabpage_distinta.dw_distinta_ff.SetTransObject(SQLCA)

tab_distinta.tabpage_distinta.dw_distinta_ff.SetItem(ll_CurrRow, "id_esercizio", ll_id_esercizio)
tab_distinta.tabpage_distinta.dw_distinta_ff.setitem(ll_CurrRow, "id_valuta", ll_id_valuta) 
tab_distinta.tabpage_distinta.dw_distinta_ff.SetItem(ll_CurrRow, "tipo", ic_tipo_scadenza)
tab_distinta.tabpage_distinta.dw_distinta_ff.SetItem(ll_CurrRow, "data_distinta", Today())

tab_distinta.tabpage_distinta.dw_distinta_filtro_ext_ff.postevent("ue_post_open")
idw_target.postevent("ue_post_open")

tab_distinta.tabpage_distinta.dw_distinta_filtro_ext_ff.SetFocus()


end event

type cb_chiudi from commandbutton within w_distinta_ff
integer x = 457
integer y = 42
integer width = 271
integer height = 83
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;Close(Parent)
end event

type cb_crea from commandbutton within w_distinta_ff
integer x = 48
integer y = 42
integer width = 369
integer height = 83
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C&rea Distinta"
end type

event clicked;

CHOOSE CASE il_id_dis_banca
	CASE 0
		Parent.Event ue_crea_distinta()
	CASE ELSE
		Parent.Event ue_aggiungi_righe()
END CHOOSE

Close(Parent)
end event

type tab_distinta from tab within w_distinta_ff
event create ( )
event destroy ( )
integer x = 37
integer y = 160
integer width = 2629
integer height = 1261
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_distinta tabpage_distinta
tabpage_scadenze tabpage_scadenze
end type

on tab_distinta.create
this.tabpage_distinta=create tabpage_distinta
this.tabpage_scadenze=create tabpage_scadenze
this.Control[]={this.tabpage_distinta,&
this.tabpage_scadenze}
end on

on tab_distinta.destroy
destroy(this.tabpage_distinta)
destroy(this.tabpage_scadenze)
end on

event selectionchanged;tab_distinta.tabpage_distinta.dw_distinta_filtro_ext_ff.Event Post ue_Setup_Filter()
end event

type tabpage_distinta from userobject within tab_distinta
event create ( )
event destroy ( )
integer x = 15
integer y = 90
integer width = 2600
integer height = 1158
long backcolor = 79741120
string text = "Distinta"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_distinta_filtro_ext_ff dw_distinta_filtro_ext_ff
dw_distinta_ff dw_distinta_ff
end type

on tabpage_distinta.create
this.dw_distinta_filtro_ext_ff=create dw_distinta_filtro_ext_ff
this.dw_distinta_ff=create dw_distinta_ff
this.Control[]={this.dw_distinta_filtro_ext_ff,&
this.dw_distinta_ff}
end on

on tabpage_distinta.destroy
destroy(this.dw_distinta_filtro_ext_ff)
destroy(this.dw_distinta_ff)
end on

type dw_distinta_filtro_ext_ff from u_dw_ext_main within tabpage_distinta
event itemchanged pbm_dwnitemchange
event ue_init ( )
event ue_setup_filter ( )
integer x = 15
integer y = 35
integer width = 1759
integer height = 931
integer taborder = 2
boolean titlebar = true
string title = "Filtro Scadenze"
string dataobject = "d_distinta_filtro_ext_ff"
end type

event itemchanged;


string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok

CHOOSE CASE dwo.name

	CASE 'cod_abi'
		ls_dbc[1] = "cod_abi"
		ls_dwc[1] = "cod_abi"

		ll_ok = uf_autofind_col(dwo.Name, "banca_sog_commerciale_gen", &  
										"cod_abi", "A", data, & 
										ls_sql_cond, 1, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

END CHOOSE

end event

event ue_init;is_colonne_drop[1]  = "id_tipo_pagamento_cod"
is_colonne_drop[2]  = "id_tipo_pagamento_des"
is_colonne_drop[3]  = "id_banca_azienda"
is_colonne_drop[4]  = "id_banca_azienda_pres"

is_colonne_drop[5]  = "id_valuta"
is_colonne_drop[6]  = "id_valuta_des"
end event

event ue_setup_filter;

long ll_CurrRow, ll_id_banca_azienda, ll_id_tipo_pagamento
date ld_data_scad_dal, ld_data_scad_al, ld_data_doc_dal, ld_data_doc_al
string ls_tipo_scadenza 
decimal ldc_imp_scad_da, ldc_imp_scad_a
string ls_data_scad, ls_data_doc, ls_imp_scad, ls_id_banca_azienda, ls_id_tipo_pagamento, ls_cod_abi, ls_codice_abi
constant string LCS_AND = " AND "

is_filter = ""

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	ld_data_scad_dal = THIS.GetItemDate(ll_CurrRow, "data_scad_dal")
	ld_data_scad_al = THIS.GetItemDate(ll_CurrRow, "data_scad_al")
	ld_data_doc_dal = THIS.GetItemDate(ll_CurrRow, "data_doc_dal")
	ld_data_doc_al = THIS.GetItemDate(ll_CurrRow, "data_doc_al")
	
	ll_id_tipo_pagamento = THIS.GetItemNumber(ll_CurrRow, "id_tipo_pagamento_cod")
	ldc_imp_scad_da = THIS.uf_GetItemDecimal(ll_CurrRow, "imp_scad_da")
	ldc_imp_scad_a = THIS.uf_GetItemDecimal(ll_CurrRow, "imp_scad_a")
	ll_id_banca_azienda = THIS.GetItemNumber(ll_CurrRow, "id_banca_azienda")
	
	
	IF (NOT IsNull(ld_data_scad_dal)) AND (NOT IsNull(ld_data_scad_al)) THEN
		ls_data_scad = "(scadenza_data_scadenza >= date('" + string(ld_data_scad_dal) + "')) AND (scadenza_data_scadenza <= date('" + String(ld_data_scad_al) + "'))"
		IF is_filter = "" THEN
			is_filter = ls_data_scad
		ELSE
			is_filter = is_filter + LCS_AND + ls_data_scad
		END IF
	END IF
	
	
	IF (NOT IsNull(ld_data_doc_dal)) AND (NOT IsNull(ld_data_doc_al)) THEN
		ls_data_doc = "(documento_data_documento >= date('" + string(ld_data_doc_dal) + "')) AND (documento_data_documento <= date('" + String(ld_data_doc_al) + "'))"
		IF is_filter = "" THEN
			is_filter = ls_data_doc
		ELSE
			is_filter = is_filter + LCS_AND + ls_data_doc
		END IF
	END IF
	
	
	IF NOT IsNull(ic_tipo_scadenza) THEN
		ls_tipo_scadenza = ic_tipo_scadenza
		ls_tipo_scadenza = "scadenza_tipo_scadenza = '" + ls_tipo_scadenza +"'"
		IF is_filter = "" THEN
			is_filter = ls_tipo_scadenza
		ELSE
			is_filter = is_filter + LCS_AND + ls_tipo_scadenza
		END IF
	END IF
	
	
	IF NOT IsNull(ll_id_tipo_pagamento) THEN
		ls_id_tipo_pagamento = "scadenza_id_tipo_pagamento_cod = " + string(ll_id_tipo_pagamento)
		IF is_filter = "" THEN
			is_filter = ls_id_tipo_pagamento
		ELSE
			is_filter = is_filter + LCS_AND + ls_id_tipo_pagamento
		END IF
	END IF
	
	
	idc_imp_max_distinta = THIS.uf_GetItemDecimal(ll_CurrRow, "imp_max_distinta")

	
	IF (NOT IsNull(ldc_imp_scad_da)) AND (NOT IsNull(ldc_imp_scad_a)) THEN
		ls_imp_scad = "scadenza_importo >= " + string(ldc_imp_scad_da) + " AND scadenza_importo <= " + String(ldc_imp_scad_a)
		IF is_filter = "" THEN
			is_filter = ls_imp_scad
		ELSE
			is_filter = is_filter + LCS_AND + ls_imp_scad
		END IF
	END IF
	
	
	IF NOT IsNull(ll_id_banca_azienda) THEN
		ls_id_banca_azienda = "scadenza_id_banca_azienda = " + string(ll_id_banca_azienda)
		IF is_filter = "" THEN
			is_filter = ls_id_banca_azienda
		ELSE
			is_filter = is_filter + LCS_AND + ls_id_banca_azienda
		END IF
	END IF
	
	
	ls_cod_abi = this.getitemstring(ll_CurrRow, "cod_abi")
	IF NOT IsNull(ls_cod_abi) THEN
		ls_codice_abi = "cod_abi = '"	+ ls_cod_abi + "'"
		IF is_filter = "" THEN
			is_filter = ls_codice_abi
		ELSE
			is_filter = is_filter + LCS_AND + ls_codice_abi
		END IF	
		
	end if
	
	
	
	il_id_banca_azienda = THIS.GetItemNumber(ll_CurrRow, "id_banca_azienda_pres")
	
	idw_source.SetFilter(is_filter)
	idw_source.Filter()
END IF
end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "cod_abi"
		is_search_window = "w_banca_appoggio_abi_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "cod_abi" 
		is_ricpar.b_AsNeeded = TRUE
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "cod_abi"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
END CHOOSE
end event

type dw_distinta_ff from u_dw_pura within tabpage_distinta
integer x = 1796
integer y = 35
integer width = 775
integer height = 931
integer taborder = 3
boolean titlebar = true
string title = "Estremi Distinta"
string dataobject = "d_distinta_ff"
end type

event itemchanged;
CHOOSE CASE dwo.name
	CASE "id_esercizio"
		long	ll_id_valuta
		
		SELECT id_valuta
		INTO	 :ll_id_valuta
		FROM	 esercizio
		WHERE  id_esercizio = :data
		;
		
		tab_distinta.tabpage_distinta.dw_distinta_ff.setitem(row, "id_valuta", ll_id_valuta)

		
		idw_source.Retrieve(ll_id_valuta)		

		

		idw_source.SetFilter(is_filter)
		idw_source.Filter()		
		
		Post wf_set_format()
END CHOOSE
end event

type tabpage_scadenze from userobject within tab_distinta
event create ( )
event destroy ( )
integer x = 15
integer y = 90
integer width = 2600
integer height = 1158
long backcolor = 79741120
string text = "Scadenze"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_distinta_ext_lt dw_distinta_ext_lt
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_distinta_lt dw_distinta_lt
end type

on tabpage_scadenze.create
this.dw_distinta_ext_lt=create dw_distinta_ext_lt
this.cb_drop_all=create cb_drop_all
this.cb_drop_many=create cb_drop_many
this.cb_remove_many=create cb_remove_many
this.cb_remove_all=create cb_remove_all
this.dw_distinta_lt=create dw_distinta_lt
this.Control[]={this.dw_distinta_ext_lt,&
this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_distinta_lt}
end on

on tabpage_scadenze.destroy
destroy(this.dw_distinta_ext_lt)
destroy(this.cb_drop_all)
destroy(this.cb_drop_many)
destroy(this.cb_remove_many)
destroy(this.cb_remove_all)
destroy(this.dw_distinta_lt)
end on

type dw_distinta_ext_lt from u_dw_ext_main within tabpage_scadenze
event ue_rilascia ( )
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
integer x = 1485
integer y = 35
integer width = 1075
integer height = 1059
integer taborder = 2
boolean titlebar = true
string title = "Selezionate"
string dataobject = "d_distinta_ext_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_rilascia;call super::ue_rilascia;

long ll_Rows, ll_i, ll_id_scadenza, ll_NewRow
date ld_data_scadenza
decimal ldc_imp_scadenza
string ls_crag_soc

ll_Rows = idw_source.RowCount()
ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_source.IsSelected(ll_i) THEN
		uf_drop(ll_i)
	END IF
NEXT

idw_target.Sort()
ib_removing = FALSE
end event

event ue_buttonup;call super::ue_buttonup;ib_down_target = FALSE
end event

event ue_buttondown;call super::ue_buttondown;ib_down_target = TRUE
end event

event ue_mousemove;call super::ue_mousemove;IF tab_distinta.tabpage_scadenze.dw_distinta_ext_lt.GetRow () > 0 AND &
	ib_down_target = TRUE THEN
	tab_distinta.tabpage_scadenze.dw_distinta_ext_lt.Drag (begin!)
	tab_distinta.tabpage_scadenze.dw_distinta_ext_lt.DragIcon = 'Application!'
END IF

end event

event dragenter;call super::dragenter;IF ib_down_source = TRUE THEN
	THIS.dragicon = 'Rectangle!'
END IF
end event

event dragleave;call super::dragleave;IF ib_down_source = TRUE THEN
	tab_distinta.tabpage_scadenze.dw_distinta_lt.DragIcon = 'Application!'
END IF

end event

event dragdrop;call super::dragdrop;DragObject ldo_source
DataWindow ldw_source

ldo_source = DraggedObject()

CHOOSE CASE TypeOf(ldo_source)
	CASE DataWindow!
		ldw_source = ldo_source
		IF ldw_source.DataObject = "d_distinta_lt" AND (ib_down_source = TRUE) THEN
			THIS.EVENT ue_rilascia()
		END IF
END CHOOSE

end event

event clicked;call super::clicked;long ll_RetVal

IF KeyDown(KeyControl!) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

IF KeyDown(KeyShift!) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;

IF ib_removing = FALSE THEN
	IF NOT KeyDown(KeyControl!) AND NOT KeyDown(KeyShift!) THEN
		SelectRow(0,FALSE)
		SelectRow(currentrow, TRUE)
	END IF
	
	IF KeyDown(KeyShift!) THEN
		SelectRow(currentrow, NOT THIS.IsSelected(currentrow))
	END IF
END IF
end event

event ue_init;call super::ue_init;is_colonne_drop[1]  = "scadenza_id_tipo_pagamento_cod"
is_colonne_drop[2]  = "scadenza_id_tipo_pagamento_des"
is_colonne_drop[3]  = "scadenza_id_banca_azienda"
end event

type cb_drop_all from commandbutton within tabpage_scadenze
integer x = 1189
integer y = 301
integer width = 249
integer height = 90
integer taborder = 14
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;

uf_drop_all()
end event

type cb_drop_many from commandbutton within tabpage_scadenze
integer x = 1189
integer y = 419
integer width = 249
integer height = 90
integer taborder = 13
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;

uf_drop_many()
end event

type cb_remove_many from commandbutton within tabpage_scadenze
integer x = 1189
integer y = 640
integer width = 249
integer height = 90
integer taborder = 12
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;

uf_remove_many()
end event

type cb_remove_all from commandbutton within tabpage_scadenze
integer x = 1192
integer y = 755
integer width = 249
integer height = 90
integer taborder = 11
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;

uf_remove_all()
end event

type dw_distinta_lt from u_dw_pura within tabpage_scadenze
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
integer x = 22
integer y = 35
integer width = 1090
integer height = 1059
boolean titlebar = true
string title = "Disponibili"
string dataobject = "d_distinta_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_buttonup;ib_down_source = FALSE
end event

event ue_buttondown;ib_down_source = TRUE
end event

event ue_mousemove;IF tab_distinta.tabpage_scadenze.dw_distinta_lt.GetRow () > 0 AND &
	ib_down_source = TRUE THEN
	tab_distinta.tabpage_scadenze.dw_distinta_lt.Drag (begin!)
	tab_distinta.tabpage_scadenze.dw_distinta_lt.DragIcon = 'Application!'
END IF

end event

event clicked;long ll_RetVal

IF KeyDown(KeyControl!) OR KeyDown(KeyShift!) OR (row = THIS.GetRow()) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF



end event

event rowfocuschanged;

IF ib_removing = FALSE THEN
	IF NOT KeyDown(KeyControl!) AND NOT KeyDown(KeyShift!) THEN
		SelectRow(0,FALSE)
		SelectRow(currentrow, TRUE)
	END IF
	
	IF KeyDown(KeyShift!) THEN
		SelectRow(currentrow, NOT THIS.IsSelected(currentrow))
	END IF
END IF
end event

event dragenter;IF ib_down_source = TRUE THEN
	tab_distinta.tabpage_scadenze.dw_distinta_lt.DragIcon = 'Application!'
END IF

IF ib_down_target = TRUE THEN
	THIS.dragicon = 'Rectangle!'
END IF
end event

event dragleave;IF ib_down_target = TRUE THEN
	tab_distinta.tabpage_scadenze.dw_distinta_lt.DragIcon = 'Application!'
END IF

end event

event dragdrop;IF ib_down_target = TRUE THEN
	uf_remove_many()
END IF

end event

event sqlpreview;
end event

