forward
global type w_insoluti_cx from w_wiz_main
end type
type cb_oneri from commandbutton within w_insoluti_cx
end type
type cb_chiudi from commandbutton within w_insoluti_cx
end type
type cb_registra from commandbutton within w_insoluti_cx
end type
type tab_1 from tab within w_insoluti_cx
end type
type tabpage_parametri from userobject within tab_1
end type
type dw_insoluti_param_ff from u_dw_ext_main within tabpage_parametri
end type
type dw_insoluti_filtro_ff from u_dw_ext_main within tabpage_parametri
end type
type tabpage_scadenze from userobject within tab_1
end type
type cb_remove_all from commandbutton within tabpage_scadenze
end type
type cb_remove_many from commandbutton within tabpage_scadenze
end type
type cb_drop_many from commandbutton within tabpage_scadenze
end type
type cb_drop_all from commandbutton within tabpage_scadenze
end type
type dw_insoluti_scadenze_ext_gd from u_dw_ext_main within tabpage_scadenze
end type
type dw_insoluti_scadenze_gd from datawindow within tabpage_scadenze
end type
type tabpage_parametri from userobject within tab_1
dw_insoluti_param_ff dw_insoluti_param_ff
dw_insoluti_filtro_ff dw_insoluti_filtro_ff
end type
type tabpage_scadenze from userobject within tab_1
cb_remove_all cb_remove_all
cb_remove_many cb_remove_many
cb_drop_many cb_drop_many
cb_drop_all cb_drop_all
dw_insoluti_scadenze_ext_gd dw_insoluti_scadenze_ext_gd
dw_insoluti_scadenze_gd dw_insoluti_scadenze_gd
end type
type tab_1 from tab within w_insoluti_cx
tabpage_parametri tabpage_parametri
tabpage_scadenze tabpage_scadenze
end type
end forward

global type w_insoluti_cx from w_wiz_main
int X=430
int Y=224
int Width=2798
int Height=1588
WindowType WindowType=response!
boolean TitleBar=true
string Title="Registrazione Insoluti"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_oneri cb_oneri
cb_chiudi cb_chiudi
cb_registra cb_registra
tab_1 tab_1
end type
global w_insoluti_cx w_insoluti_cx

type variables
datawindow idw_filtro, idw_param, idw_source, idw_target
long il_id_sog_commerciale
Boolean ib_removing, ib_down_source, ib_down_target

long il_array[] 

s_list_main is_insoluti 
date ld_data_reg
end variables

forward prototypes
public subroutine uf_drop (long al_row_source)
public subroutine uf_drop_all ()
public subroutine uf_drop_many ()
public subroutine uf_remove (long al_row_target)
public subroutine uf_remove_all ()
public subroutine uf_remove_many ()
public function decimal uf_getitemdecimal (datawindow adw_dwobj, long al_row, string as_column)
public subroutine uf_pre_drop ()
public subroutine uf_select_grouped (long al_row)
public subroutine uf_assegna_oneri ()
public subroutine uf_registra ()
public function long uf_trova_conto (long al_id_sog_commerciale, ref string as_sog_com_codice)
public function long uf_aggiorna_scadenza (long al_id_scadenza, string as_esito)
public function boolean uf_controlla_oneri ()
public subroutine uf_assegna_parametri ()
public subroutine uf_desc_profilo (integer fl_prof)
public subroutine uf_set_mask (integer ll_valuta)
end prototypes

public subroutine uf_drop (long al_row_source);

long ll_NewRow, ll_CurrRow, ll_find, ll_id_scadenza, ll_id_sog_commerciale, ll_id_riga_dis_banca
long ll_id_par_aperta
decimal ldc_imp_scadenza
date ld_data_partita, ld_data_scadenza
string ls_search, ls_num_partita, ls_sog_com_codice, ls_sog_com_descrizione
char lc_tipo_scadenza, lc_esito_pagamento, lc_raggruppate

ls_num_partita         = idw_source.GetItemString(al_row_source, "par_aperta_num_partita")
ld_data_partita        = idw_source.GetItemDate(al_row_source, "par_aperta_data_partita")
ls_sog_com_codice      = idw_source.GetItemString(al_row_source, "sog_commerciale_codice")
ls_sog_com_descrizione = idw_source.GetItemString(al_row_source, "anagrafica_rag_soc_1")
ld_data_scadenza       = idw_source.GetItemDate(al_row_source, "scadenza_data_scadenza")
ldc_imp_scadenza       = uf_GetItemDecimal(idw_source, al_row_source, "scadenza_importo")
lc_tipo_scadenza       = idw_source.GetItemString(al_row_source, "scadenza_tipo_scadenza")
ll_id_sog_commerciale  = idw_source.GetItemNumber(al_row_source, "scadenza_id_sog_commerciale")
ll_id_scadenza         = idw_source.GetItemNumber(al_row_source, "scadenza_id_scadenza")
lc_esito_pagamento     = idw_source.GetItemString(al_row_source, "scadenza_esito_pagamento")
lc_raggruppate         = idw_source.GetItemString(al_row_source, "scadenza_scadenza_da_raggruppare")
ll_id_riga_dis_banca   = idw_source.GetItemNumber(al_row_source, "scadenza_id_riga_distinta_banca")
ll_id_par_aperta       = idw_source.GetItemNumber(al_row_source, "scadenza_id_par_aperta")

ls_search = "scadenza_id_scadenza = " + string(ll_id_scadenza)
ll_find = idw_target.find(ls_search, 1, idw_target.RowCount())

IF ll_find = 0  THEN
	ll_NewRow = idw_target.InsertRow(0)

	idw_target.SetItem(ll_NewRow, "par_aperta_num_partita", ls_num_partita)
	idw_target.SetItem(ll_NewRow, "par_aperta_data_partita", ld_data_partita)
	idw_target.SetItem(ll_NewRow, "sog_commerciale_codice", ls_sog_com_codice)
	idw_target.SetItem(ll_NewRow, "anagrafica_rag_soc_1", ls_sog_com_descrizione)
	idw_target.SetItem(ll_NewRow, "scadenza_data_scadenza", ld_data_scadenza)
	idw_target.SetItem(ll_NewRow, "scadenza_importo", ldc_imp_scadenza)
	idw_target.SetItem(ll_NewRow, "scadenza_tipo_scadenza", lc_tipo_scadenza)
	idw_target.SetItem(ll_NewRow, "scadenza_id_sog_commerciale", ll_id_sog_commerciale)
	idw_target.SetItem(ll_NewRow, "scadenza_id_scadenza", ll_id_scadenza)
	idw_target.SetItem(ll_NewRow, "scadenza_esito_pagamento", lc_esito_pagamento)
	idw_target.SetItem(ll_NewRow, "scadenza_scadenza_da_raggruppare", lc_raggruppate)
	idw_target.SetItem(ll_NewRow, "scadenza_id_riga_distinta_banca", ll_id_riga_dis_banca)
	idw_target.SetItem(ll_NewRow, "scadenza_id_par_aperta", ll_id_par_aperta)
	
	
	idw_source.DeleteRow(al_row_source)

	
	idw_target.SelectRow(ll_NewRow, TRUE)
END IF

end subroutine

public subroutine uf_drop_all ();

long ll_Rows, ll_i, ll_CurrRow

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

long ll_Rows, ll_i

ll_Rows = idw_source.RowCount()
ib_removing = TRUE
idw_source.SetRow(1)

uf_pre_drop()

FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_source.IsSelected(ll_i) THEN
		uf_drop(ll_i)
	END IF
NEXT

idw_target.Sort()

ib_removing = FALSE
end subroutine

public subroutine uf_remove (long al_row_target);

long ll_NewRow, ll_CurrRow, ll_find, ll_id_scadenza, ll_id_sog_commerciale, ll_id_riga_dis_banca
long ll_id_par_aperta
decimal ldc_imp_scadenza
date ld_data_partita, ld_data_scadenza
string ls_search, ls_num_partita, ls_sog_com_codice, ls_sog_com_descrizione
char lc_tipo_scadenza, lc_esito_pagamento, lc_raggruppate

ls_num_partita         = idw_target.GetItemString(al_row_target, "par_aperta_num_partita")
ld_data_partita        = idw_target.GetItemDate(al_row_target, "par_aperta_data_partita")
ls_sog_com_codice      = idw_target.GetItemString(al_row_target, "sog_commerciale_codice")
ls_sog_com_descrizione = idw_target.GetItemString(al_row_target, "anagrafica_rag_soc_1")
ld_data_scadenza       = idw_target.GetItemDate(al_row_target, "scadenza_data_scadenza")
ldc_imp_scadenza       = uf_GetItemDecimal(idw_target, al_row_target, "scadenza_importo")
lc_tipo_scadenza       = idw_target.GetItemString(al_row_target, "scadenza_tipo_scadenza")
ll_id_sog_commerciale  = idw_target.GetItemNumber(al_row_target, "scadenza_id_sog_commerciale")
ll_id_scadenza         = idw_target.GetItemNumber(al_row_target, "scadenza_id_scadenza")
lc_esito_pagamento     = idw_target.GetItemString(al_row_target, "scadenza_esito_pagamento")
lc_raggruppate         = idw_target.GetItemString(al_row_target, "scadenza_scadenza_da_raggruppare")
ll_id_riga_dis_banca   = idw_target.GetItemNumber(al_row_target, "scadenza_id_riga_distinta_banca")
ll_id_par_aperta       = idw_target.GetItemNumber(al_row_target, "scadenza_id_par_aperta")

ll_NewRow = idw_source.InsertRow(0)

idw_source.SetItem(ll_NewRow, "par_aperta_num_partita", ls_num_partita)
idw_source.SetItem(ll_NewRow, "par_aperta_data_partita", ld_data_partita)
idw_source.SetItem(ll_NewRow, "sog_commerciale_codice", ls_sog_com_codice)
idw_source.SetItem(ll_NewRow, "anagrafica_rag_soc_1", ls_sog_com_descrizione)
idw_source.SetItem(ll_NewRow, "scadenza_data_scadenza", ld_data_scadenza)
idw_source.SetItem(ll_NewRow, "scadenza_importo", ldc_imp_scadenza)
idw_source.SetItem(ll_NewRow, "scadenza_tipo_scadenza", lc_tipo_scadenza)
idw_source.SetItem(ll_NewRow, "scadenza_id_sog_commerciale", ll_id_sog_commerciale)
idw_source.SetItem(ll_NewRow, "scadenza_id_scadenza", ll_id_scadenza)
idw_source.SetItem(al_row_target, "scadenza_esito_pagamento", lc_esito_pagamento)
idw_source.SetItem(al_row_target, "scadenza_scadenza_da_raggruppare", lc_raggruppate)
idw_source.SetItem(al_row_target, "scadenza_id_riga_distinta_banca", ll_id_riga_dis_banca)
idw_source.SetItem(al_row_target, "scadenza_id_par_aperta", ll_id_par_aperta)

idw_source.SelectRow(ll_NewRow, TRUE)

idw_target.SetRow(al_row_target)
idw_target.DeleteRow(0)
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

public function decimal uf_getitemdecimal (datawindow adw_dwobj, long al_row, string as_column);

decimal ld_value

ld_value = adw_dwobj.GetItemNumber(al_row,as_column)
if not (isNull(ld_value)) then
	ld_value = adw_dwobj.GetItemDecimal(al_row,as_column)
end if

return ld_value


end function

public subroutine uf_pre_drop ();

long ll_Rows, ll_i
ll_Rows = idw_source.RowCount()

FOR ll_i = 1 TO ll_Rows 
	IF idw_source.IsSelected(ll_i) THEN
		uf_select_grouped(ll_i)
	END IF
NEXT

end subroutine

public subroutine uf_select_grouped (long al_row);

long ll_i, ll_rows, ll_id_riga_dis_banca
char lc_raggruppata

ll_rows = idw_source.RowCount()

lc_raggruppata = idw_source.GetItemString(al_row, "scadenza_scadenza_da_raggruppare")
ll_id_riga_dis_banca = idw_source.GetItemNumber(al_row, "scadenza_id_riga_distinta_banca")

FOR ll_i = 1 TO ll_rows
	IF idw_source.GetItemString(ll_i, "scadenza_scadenza_da_raggruppare") = lc_raggruppata AND &
		idw_source.GetItemNumber(ll_i, "scadenza_id_riga_distinta_banca") = ll_id_riga_dis_banca THEN
		
		idw_source.SelectRow(ll_i, TRUE)
	END IF
NEXT
end subroutine

public subroutine uf_assegna_oneri ();

long ll_CurrRow, ll_i
decimal ldc_onere

ll_CurrRow = idw_target.GetRow()

IF ll_CurrRow > 0 THEN
	ldc_onere = uf_GetItemDecimal(idw_target, ll_CurrRow, "oneri")
	FOR ll_i = 1 TO idw_target.RowCount()
		IF IsNull(uf_GetItemDecimal(idw_target, ll_i, "oneri")) THEN
			idw_target.SetItem(ll_i, "oneri", ldc_onere)
		END IF
	NEXT
END IF
end subroutine

public subroutine uf_registra ();

long ll_rows, ll_i, ll_id_prof_registrazione, ll_id_onere, ll_id_banca, ll_id_par_aperta[]
long ll_id_conto_mc[], ll_id_sog_commerciale, ll_id_conto_sc, ll_NULL, ll_id_tab_iva[]
long ll_id_scadenza, li_ret
decimal ldc_imp_scadenza, ldc_onere, ldc_importo_mc[], ldc_NULL, ldc_imponibile[], ldc_imposta[]
date ld_data_registrazione, ld_data_scadenza, ld_NULL
string ls_sog_comm_codice, ls_NULL, ls_desc
char lc_segno_mc[]
boolean lb_generate = FALSE, lb_mc_iva[]

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

SetNull(ldc_NULL)
SetNull(ll_NULL)
SetNull(ls_NULL)
SetNull(ld_NULL)
ll_rows = idw_target.RowCount()

IF (ll_rows > 0) THEN
	IF uf_controlla_oneri() THEN
		SetPointer(HourGlass!)
		ll_id_prof_registrazione = idw_param.GetItemNumber(idw_param.GetRow(), "id_prof_registrazione")
		ld_data_registrazione = idw_param.GetItemDate(idw_param.GetRow(), "data_registrazione")
		ll_id_onere = idw_param.GetItemNumber(idw_param.GetRow(), "id_conto_1")
		ll_id_banca = idw_param.GetItemNumber(idw_param.GetRow(), "id_conto_2")
		ls_desc = idw_param.GetItemString(idw_param.GetRow(), "descrizione")   
		
		
		FOR ll_i = 1 TO ll_rows
			
			ll_id_scadenza = idw_target.GetItemNumber(ll_i, "scadenza_id_scadenza")
			ll_id_sog_commerciale = idw_target.GetItemNumber(ll_i, "scadenza_id_sog_commerciale")
	
			ldc_imp_scadenza = uf_GetItemDecimal(idw_target, ll_i, "scadenza_importo")
			ldc_onere = uf_GetItemDecimal(idw_target, ll_i, "oneri")
			ll_id_conto_sc = uf_trova_conto(ll_id_sog_commerciale, ls_sog_comm_codice)
			ld_data_scadenza = idw_target.GetItemDate(ll_i, "scadenza_data_scadenza")
	
			IF IsNull(ll_id_conto_sc) OR (ll_id_conto_sc = 0) THEN
				MessageBox("Registrazione Insoluti", "Attenzione: Al soggetto commerciale con codice " + ls_sog_comm_codice + "~rnon è associato il conto. Impossibile registrare~rla scadenza del " + string(ld_data_scadenza) + " di importo " + string(ldc_imp_scadenza) + ".")
			ELSE
			
				ll_id_conto_mc[1]   = ll_id_conto_sc
				lc_segno_mc[1]      = "D"
				ldc_importo_mc[1]   = ldc_imp_scadenza
				ll_id_par_aperta[1] = idw_target.GetItemNumber(ll_i, "scadenza_id_par_aperta")
				lb_mc_iva[1] = FALSE
				
				ll_id_conto_mc[2]   = ll_id_onere
				lc_segno_mc[2]      = "D"
				ldc_importo_mc[2]   = ldc_onere
				ll_id_par_aperta[2] = 0
				lb_mc_iva[2] = FALSE
				
				ll_id_conto_mc[3]   = ll_id_banca
				lc_segno_mc[3]      = "A"
				ldc_importo_mc[3]   = (ldc_imp_scadenza + ldc_onere)
				ll_id_par_aperta[3] = 0
				lb_mc_iva[3] = FALSE

				
				lu_reg_pd.uf_DisplayMode(2)
				lu_reg_pd.uf_Reset()
				lu_reg_pd.uf_id_prof_registrazione(ll_id_prof_registrazione)
				lu_reg_pd.uf_data_registrazione(ld_data_registrazione)
				
				long ll_id_es
				select id_esercizio into :ll_id_es from esercizio 
				where data_inizio<=:ld_data_registrazione and data_fine>=:ld_data_registrazione;
				lu_reg_pd.uf_id_esercizio(ll_id_es)
				
				
				
				if ls_desc<>'' and not isnull(ls_desc) then 
					lu_reg_pd.uf_descrizione(ls_desc)  
				end if	
				
				
				lu_reg_pd.uf_imponibile(ldc_imponibile)
				lu_reg_pd.uf_id_tab_iva(ll_id_tab_iva)
				lu_reg_pd.uf_imposta(ldc_imposta)
				
				
				lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
				lu_reg_pd.uf_segno_mc(lc_segno_mc)
				lu_reg_pd.uf_importo_mc(ldc_importo_mc)
				lu_reg_pd.uf_id_par_aperta(ll_id_par_aperta)
				lu_reg_pd.uf_crea_mov_partita(TRUE)
				lu_reg_pd.uf_invert_mov_partita(TRUE)
				lu_reg_pd.uf_mc_iva(lb_mc_iva)
				
				
				IF lu_reg_pd.uf_crea() > 0 THEN lb_generate = TRUE
				
				update mov_scadenza
				set importo=0
				where id_scadenza=:ll_id_scadenza;
				uf_aggiorna_scadenza(ll_id_scadenza, "I")
			END IF
			
		NEXT
		SetPointer(Arrow!)
		IF lb_generate = TRUE THEN MessageBox("Registrazione Insoluti", "Generate le registrazioni per le scadenze selezionate.")
	ELSE
		MessageBox("Registrazione Insoluti", "Impossibile generare le registrazioni: Immettere~rl'importo dell'onere per tutte le scadenze selezionate.")
	END IF
END IF
end subroutine

public function long uf_trova_conto (long al_id_sog_commerciale, ref string as_sog_com_codice);

long ll_RetVal, ll_id_conto

SELECT dba.sog_commerciale.id_conto,   
		 dba.sog_commerciale.codice
	INTO :ll_id_conto,   
		  :as_sog_com_codice  
	FROM dba.sog_commerciale
	WHERE dba.sog_commerciale.id_sog_commerciale = :al_id_sog_commerciale   ;

CHOOSE CASE SQLCA.SQLCode
	CASE 0
		ll_RetVal = ll_id_conto
	CASE -1
		MessageBox("Errore sul DataBase", "w_insoluti_cx / uf_trova_conto / 1")
		SetNull(ll_RetVal)
END CHOOSE

RETURN ll_RetVal
end function

public function long uf_aggiorna_scadenza (long al_id_scadenza, string as_esito);

long ll_RetVal = 0

IF al_id_scadenza > 0 THEN
	UPDATE scadenza
		SET esito_pagamento = :as_esito
		WHERE scadenza.id_scadenza = :al_id_scadenza
		USING SQLCA;
	
	IF (SQLCA.SQLCode = 0) AND (SQLCA.SQLNRows = 1) THEN
		ll_RetVal = 0
	ELSE
		ll_RetVal = -1
	END IF
	
END IF

RETURN ll_RetVal 
end function

public function boolean uf_controlla_oneri ();

long ll_i
boolean lb_RetVal = TRUE
decimal ldc_onere

FOR ll_i = 1 TO idw_target.RowCount()
	ldc_onere = idw_target.GetItemDecimal(ll_i, "oneri")
	IF IsNull(ldc_onere) OR ldc_onere = 0 THEN lb_RetVal = FALSE
NEXT

RETURN lb_RetVal
end function

public subroutine uf_assegna_parametri ();

long ll_id_prof_registrazione, ll_id_conto_oneri, ll_id_conto_banca, ll_CurrRow_Filtro
long ll_CurrRow_Param
date ld_data_registrazione
string ls_filtro_conto, ls_prof_registrazione_cod, ls_prof_registrazione_des
string ls_conto_oneri_cod, ls_conto_oneri_des, ls_conto_banca_cod, ls_conto_banca_des

is_insoluti = Message.PowerObjectParm

IF UpperBound(is_insoluti.l_identifica) > 0 THEN

	ll_id_prof_registrazione = is_insoluti.l_identifica[1]
	ld_data_registrazione    = date(is_insoluti.s_identifica[1])
	ls_filtro_conto          = is_insoluti.s_identifica[2]
	ll_id_conto_oneri        = is_insoluti.l_identifica[3]
	ll_id_conto_banca        = is_insoluti.l_identifica[4]
	
	ll_CurrRow_Filtro = tab_1.tabpage_parametri.dw_insoluti_filtro_ff.GetRow()
	ll_CurrRow_Param = tab_1.tabpage_parametri.dw_insoluti_param_ff.GetRow()
	
	IF ll_CurrRow_Filtro > 0 THEN
		tab_1.tabpage_parametri.dw_insoluti_filtro_ff.SetItem(ll_CurrRow_Filtro, "sog_com_codice", ls_filtro_conto)
	END IF
	
	IF ll_CurrRow_Param > 0 THEN
		SELECT prof_registrazione.codice,
				 prof_registrazione.descrizione
			INTO :ls_prof_registrazione_cod, 
				  :ls_prof_registrazione_des
			FROM dba.prof_registrazione
			WHERE prof_registrazione.id_prof_registrazione = :ll_id_prof_registrazione
			USING SQLCA;
			
		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "id_prof_registrazione", ll_id_prof_registrazione)
				tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "prof_registrazione_cod", ls_prof_registrazione_cod)
				tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "prof_registrazione_des", ls_prof_registrazione_des)
		END CHOOSE
	
	
		tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "data_registrazione", ld_data_registrazione)
	
		SELECT conto.codice,
				 conto.descrizione
			INTO :ls_conto_oneri_cod, 
				  :ls_conto_oneri_des
			FROM dba.conto
			WHERE conto.id_conto = :ll_id_conto_oneri
			USING SQLCA;
			
		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "id_conto_1", ll_id_conto_oneri)
				tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "conto_1_cod", ls_conto_oneri_cod)
				tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "conto_1_des", ls_conto_oneri_des)
		END CHOOSE
	
		SELECT conto.codice,
				 conto.descrizione
			INTO :ls_conto_banca_cod, 
				  :ls_conto_banca_des
			FROM dba.conto
			WHERE conto.id_conto = :ll_id_conto_banca
			USING SQLCA;
			
		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "id_conto_2", ll_id_conto_banca)
				tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "conto_2_cod", ls_conto_banca_cod)
				tab_1.tabpage_parametri.dw_insoluti_param_ff.SetItem(ll_CurrRow_Param, "conto_2_des", ls_conto_banca_des)
		END CHOOSE
		
		
		
		
		tab_1.tabpage_parametri.dw_insoluti_param_ff.Trigger Event ue_enable_button()
		
	END IF
END IF
end subroutine

public subroutine uf_desc_profilo (integer fl_prof);
string ls_desc

select des_contabile into :ls_desc
from prof_registrazione where id_prof_registrazione=:fl_prof;

if isnull(ls_desc) or trim(ls_desc)='' then ls_desc='Fattura insoluti'

tab_1.tabpage_parametri.dw_insoluti_param_ff.setitem(1,'descrizione',ls_desc)
end subroutine

public subroutine uf_set_mask (integer ll_valuta);
idw_source.Modify("scadenza_importo.format = '" + f_valu_masK(ll_valuta) + "'")
idw_source.Modify("scadenza_importo.edit.mask = '" + f_valu_masK(ll_valuta) + "'")
tab_1.tabpage_scadenze.dw_insoluti_scadenze_ext_gd.Modify("scadenza_importo.format = '" + f_valu_masK(ll_valuta) + "'")
tab_1.tabpage_scadenze.dw_insoluti_scadenze_ext_gd.Modify("scadenza_importo.edit.mask = '" + f_valu_masK(ll_valuta) + "'")
tab_1.tabpage_scadenze.dw_insoluti_scadenze_ext_gd.Modify("oneri.format = '" + f_valu_masK(ll_valuta) + "'")
tab_1.tabpage_scadenze.dw_insoluti_scadenze_ext_gd.Modify("oneri.edit.mask = '" + f_valu_masK(ll_valuta) + "'")
end subroutine

on w_insoluti_cx.create
int iCurrent
call super::create
this.cb_oneri=create cb_oneri
this.cb_chiudi=create cb_chiudi
this.cb_registra=create cb_registra
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_oneri
this.Control[iCurrent+2]=this.cb_chiudi
this.Control[iCurrent+3]=this.cb_registra
this.Control[iCurrent+4]=this.tab_1
end on

on w_insoluti_cx.destroy
call super::destroy
destroy(this.cb_oneri)
destroy(this.cb_chiudi)
destroy(this.cb_registra)
destroy(this.tab_1)
end on

event open;call super::open;
integer li_ret
long ll_valuta
il_HelpTopic = 276

idw_filtro = tab_1.tabpage_parametri.dw_insoluti_filtro_ff
idw_param  = tab_1.tabpage_parametri.dw_insoluti_param_ff
idw_source = tab_1.tabpage_scadenze.dw_insoluti_scadenze_gd
idw_target = tab_1.tabpage_scadenze.dw_insoluti_scadenze_ext_gd

IF idw_filtro.GetRow() = 0 THEN idw_filtro.InsertRow(0)
IF idw_param.GetRow() = 0 THEN idw_param.InsertRow(0)

idw_source.SetTransObject(SQLCA)
select id_valuta into :ll_valuta from esercizio 
where data_inizio<=today() and data_fine>=today();
idw_source.Retrieve(ll_valuta)
uf_set_mask(ll_valuta)

idw_source.SetSort("long(par_aperta_num_partita) A, scadenza_importo A")
idw_source.Sort()

idw_target.SetSort("long(par_aperta_num_partita) A, scadenza_importo A")
idw_target.Sort()

idw_source.SetFilter("scadenza_tipo_scadenza = 'A' AND (scadenza_esito_pagamento = 'D')")
li_ret=idw_source.Filter()
if li_ret<1 then messagebox("errore", "Filtro non valido")

uf_assegna_parametri()
end event

type cb_oneri from commandbutton within w_insoluti_cx
int X=2309
int Y=36
int Width=411
int Height=88
int TabOrder=11
boolean Enabled=false
string Text="&Assegna Oneri"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_assegna_oneri()
end event

type cb_chiudi from commandbutton within w_insoluti_cx
int X=389
int Y=40
int Width=247
int Height=84
int TabOrder=30
string Text="&Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_registra from commandbutton within w_insoluti_cx
int X=46
int Y=40
int Width=297
int Height=84
int TabOrder=20
boolean Enabled=false
string Text="&Registra"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_registra()
end event

type tab_1 from tab within w_insoluti_cx
int X=59
int Y=164
int Width=2674
int Height=1312
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_parametri tabpage_parametri
tabpage_scadenze tabpage_scadenze
end type

on tab_1.create
this.tabpage_parametri=create tabpage_parametri
this.tabpage_scadenze=create tabpage_scadenze
this.Control[]={this.tabpage_parametri,&
this.tabpage_scadenze}
end on

on tab_1.destroy
destroy(this.tabpage_parametri)
destroy(this.tabpage_scadenze)
end on

event selectionchanged;IF newindex = 2 THEN
	cb_oneri.enabled  = TRUE
ELSE
	cb_oneri.enabled  = FALSE
END IF
end event

event selectionchanging;
long ll_valuta, ll_val_reg
IF newindex = 2 THEN
	ld_data_reg = idw_param.GetItemDate(idw_param.GetRow(), "data_registrazione")
	if isnull(ld_data_reg) then
		messagebox('Attenzione',"Prima di selezionare le scadenze~r~ninserire la data di registrazione dell'insoluto")
		return 1
	else
		select id_valuta into :ll_valuta from esercizio 
		where data_inizio<=:ld_data_reg and data_fine>=:ld_data_reg;
		if idw_source.rowcount()>0 then 
			ll_val_reg=idw_source.getitemnumber(1,'val_reg')
		else
			ll_val_reg=0
		end if	
		if ll_val_reg<>ll_valuta then		
			idw_source.Retrieve(ll_valuta)
			uf_set_mask(ll_valuta)
		end if		
		tab_1.tabpage_parametri.dw_insoluti_filtro_ff.Event ue_setup_filter()	
	end if	
END IF	


end event

type tabpage_parametri from userobject within tab_1
int X=18
int Y=104
int Width=2638
int Height=1192
long BackColor=79741120
string Text="Parametri"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_insoluti_param_ff dw_insoluti_param_ff
dw_insoluti_filtro_ff dw_insoluti_filtro_ff
end type

on tabpage_parametri.create
this.dw_insoluti_param_ff=create dw_insoluti_param_ff
this.dw_insoluti_filtro_ff=create dw_insoluti_filtro_ff
this.Control[]={this.dw_insoluti_param_ff,&
this.dw_insoluti_filtro_ff}
end on

on tabpage_parametri.destroy
destroy(this.dw_insoluti_param_ff)
destroy(this.dw_insoluti_filtro_ff)
end on

type dw_insoluti_param_ff from u_dw_ext_main within tabpage_parametri
event ue_enable_button ( )
int X=27
int Y=512
int Width=2309
int Height=664
int TabOrder=10
string DataObject="d_insoluti_param_ff"
boolean TitleBar=true
string Title="Parametri Registrazioni Contabili"
end type

event ue_enable_button;

long ll_CurrRow, ll_id_prof_registrazione, ll_id_conto_1, ll_id_conto_2
date ld_data_registrazione

ll_CurrRow = THIS.GetRow()

IF ll_CurrRow > 0 THEN
	ll_id_prof_registrazione = THIS.GetItemNumber(ll_CurrRow, "id_prof_registrazione")
	ld_data_registrazione = THIS.GetItemDate(ll_CurrRow, "data_registrazione")
	ll_id_conto_1 = THIS.GetItemNumber(ll_CurrRow, "id_conto_1")
	ll_id_conto_2 = THIS.GetItemNumber(ll_CurrRow, "id_conto_2")
	
	IF (ll_id_prof_registrazione > 0) AND &
		(ll_id_conto_1 > 0) AND & 
		(ll_id_conto_2 > 0) AND &
		(NOT IsNull(ld_data_registrazione)) THEN
		cb_registra.enabled = TRUE
	ELSE
		cb_registra.enabled = FALSE
	END IF
END IF
end event

event ue_set_search;

CHOOSE CASE as_nomecol
	
	CASE "prof_registrazione_cod"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "usa_insoluti='S'"
	CASE "prof_registrazione_des"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "usa_insoluti='S'"		

	
	CASE "conto_1_cod"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_codice"
		is_ricpar.b_imm_retrieve = TRUE
	CASE "conto_1_des"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol

		is_ricpar.s_filter_name = "conto_descrizione"
		is_ricpar.b_imm_retrieve = TRUE
	
	
	CASE "conto_2_cod"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_codice"
		is_ricpar.b_imm_retrieve = TRUE
	CASE "conto_2_des"
		is_search_window = "w_conti_pdc_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "conto_descrizione"
		is_ricpar.b_imm_retrieve = TRUE
END CHOOSE
end event

event ue_use_search;


CHOOSE CASE as_nomecol
	
	CASE "prof_registrazione_cod"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_des", is_ricpar.s_ausil_value[1])
      post uf_desc_profilo(long(is_ricpar.s_id_seg_value[1]))
		
		THIS.Event ue_enable_button()
	CASE "prof_registrazione_des"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_cod", is_ricpar.s_ausil_value[1])
		post uf_desc_profilo(long(is_ricpar.s_id_seg_value[1]))    
		
		THIS.Event ue_enable_button()
	
	CASE "conto_1_cod"
		uf_set_colval("id_conto_1", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_1_des", is_ricpar.s_ausil_value[1])
		
		THIS.Event ue_enable_button()
	CASE "conto_1_des"
		uf_set_colval("id_conto_1", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_1_cod", is_ricpar.s_ausil_value[1])    
		
		THIS.Event ue_enable_button()

	
	CASE "conto_2_cod"
		uf_set_colval("id_conto_2", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_2_des", is_ricpar.s_ausil_value[1])
		
		THIS.Event ue_enable_button()
	CASE "conto_2_des"
		uf_set_colval("id_conto_2", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_2_cod", is_ricpar.s_ausil_value[1])
		
		THIS.Event ue_enable_button()
END CHOOSE
end event

event itemchanged;

string ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok

CHOOSE CASE dwo.name
	
	CASE "prof_registrazione_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"
		ls_dwc[1] = "prof_registrazione_cod"
		ls_dwc[2] = "prof_registrazione_des"
		ls_dwc[3] = "id_prof_registrazione"		
		
		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			post uf_desc_profilo(long(ls_dbc[3]))  
			RETURN 2
		END IF
		
		
	CASE "prof_registrazione_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_registrazione"		
		ls_dwc[1] = "prof_registrazione_cod"
		ls_dwc[2] = "prof_registrazione_des"
		ls_dwc[3] = "id_prof_registrazione"				
		li_ok = uf_autofind_col(string(dwo.name), "prof_registrazione", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			post uf_desc_profilo(long(ls_dbc[3]))    
			RETURN 2
		END IF
		
		
	CASE "data_registrazione"
		THIS.Event ue_enable_button()

	
	CASE "conto_1_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_1_cod"
		ls_dwc[2] = "conto_1_des"
		ls_dwc[3] = "id_conto_1"
		
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "conto_1_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"		
		ls_dwc[1] = "conto_1_cod"
		ls_dwc[2] = "conto_1_des"
		ls_dwc[3] = "id_conto_1"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
		
	
	CASE "conto_2_cod"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"
		ls_dwc[1] = "conto_2_cod"
		ls_dwc[2] = "conto_2_des"
		ls_dwc[3] = "id_conto_2"
		
		li_ok = uf_autofind_col(string(dwo.name), "conto", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF
	CASE "conto_2_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_conto"		
		ls_dwc[1] = "conto_2_cod"
		ls_dwc[2] = "conto_2_des"
		ls_dwc[3] = "id_conto_2"
		li_ok = uf_autofind_col(string(dwo.name), "conto", "descrizione", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			RETURN 2
		END IF

END CHOOSE
end event

event ue_default;call super::ue_default;

long ll_id_prof_registrazione, ll_id_registro, ll_id_esercizio
date ld_data_registrazione
string ls_prog_scritture
CHOOSE CASE string(adwo_current.name)
	CASE "data_registrazione"
		ll_id_prof_registrazione = THIS.GetItemNumber(al_row, "id_prof_registrazione")
		IF ll_id_prof_registrazione > 0 THEN
			
			SELECT dba.azienda.id_esercizio
				INTO :ll_id_esercizio  
				FROM dba.azienda
				WHERE dba.azienda.id_azienda = 1   ;
				
			CHOOSE CASE SQLCA.SQLCode
				CASE 0
					IF ll_id_esercizio > 0 THEN
						ll_id_registro = f_proponi_registro(ll_id_prof_registrazione, ll_id_esercizio)
						  SELECT "esercizio"."prog_scritture"  
						  INTO :ls_prog_scritture  
						  FROM "esercizio",   
							    "registro"  
						  WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
									( ( "registro"."id_registro" = :ll_id_registro ) )   ;

						ld_data_registrazione = f_proponi_data_reg_pd(ll_id_registro,ls_prog_scritture)
						THIS.SetItem(al_row, "data_registrazione", ld_data_registrazione)
					END IF
			END CHOOSE

		END IF
END CHOOSE

end event

event editchanged;call super::editchanged;CHOOSE CASE string(dwo.name)
	CASE "data_registrazione"
		THIS.Event ue_enable_button()
END CHOOSE

end event

event itemfocuschanged;call super::itemfocuschanged;

THIS.Event ue_enable_button()
end event

type dw_insoluti_filtro_ff from u_dw_ext_main within tabpage_parametri
event ue_setup_filter ( )
int X=27
int Y=36
int Width=2309
int Height=460
string DataObject="d_insoluti_filtro_ff"
boolean TitleBar=true
string Title="Filtro Scadenze"
end type

event ue_setup_filter;

long ll_CurrRow, ll_id_sog_commerciale
char lc_tipo_scadenza
date ld_data_scadenza, ld_data_documento
string ls_filter, ls_num_documento
integer li_RetVal
constant string LCS_AND = " AND "

ll_CurrRow = THIS.GetRow()
THIS.AcceptText()
ls_filter = ""

IF ll_CurrRow > 0 THEN
	
	lc_tipo_scadenza = THIS.GetItemString(ll_CurrRow, "tipo_scadenza")
	IF ls_filter = "" THEN
		ls_filter = "(scadenza_tipo_scadenza = '" + lc_tipo_scadenza + "')"
	ELSE
		ls_filter = ls_filter + LCS_AND + "(scadenza_tipo_scadenza = '" + lc_tipo_scadenza + "')"
	END IF
	
	
	ll_id_sog_commerciale = THIS.GetItemNumber(ll_CurrRow, "id_sog_commerciale")
	IF NOT IsNull(ll_id_sog_commerciale) THEN
		IF ls_filter = "" THEN
			ls_filter = "(scadenza_id_sog_commerciale = " + string(ll_id_sog_commerciale) + ")"
		ELSE
			ls_filter = ls_filter + LCS_AND + "(scadenza_id_sog_commerciale = " + string(ll_id_sog_commerciale) + ")"
		END IF
	END IF
	
	
	ld_data_scadenza = THIS.GetItemDate(ll_CurrRow, "data_scadenza")
	IF NOT IsNull(ld_data_scadenza) THEN
		IF ls_filter = "" THEN
			ls_filter = "(scadenza_data_scadenza = date('" + string(ld_data_scadenza) + "'))"
		ELSE
			ls_filter = ls_filter + LCS_AND + "(scadenza_data_scadenza = date('" + string(ld_data_scadenza) + "'))"
		END IF
	END IF
	
	
	ls_num_documento = THIS.GetItemString(ll_CurrRow, "num_documento")
	IF NOT IsNull(ls_num_documento) THEN
		IF ls_filter = "" THEN
			ls_filter = "(par_aperta_num_partita = '" + string(ls_num_documento) + "')"
		ELSE
			ls_filter = ls_filter + LCS_AND + "(par_aperta_num_partita = '" + ls_num_documento + "')"
		END IF
	END IF
	
	
	ld_data_documento = THIS.GetItemDate(ll_CurrRow, "data_documento")
	IF NOT IsNull(ld_data_documento) THEN
		IF ls_filter = "" THEN
			ls_filter = "(par_aperta_data_partita = date('" + string(ld_data_documento) + "'))"
		ELSE
			ls_filter = ls_filter + LCS_AND + "(par_aperta_data_partita = date('" + string(ld_data_documento) + "'))"
		END IF
	END IF
	
	ls_filter=ls_filter+ "and scadenza_tipo_scadenza = 'A' AND scadenza_esito_pagamento = 'D'"
	li_RetVal = idw_source.SetFilter(ls_filter)
	li_RetVal = idw_source.Filter()
	
	li_RetVal = li_RetVal
END IF
end event

event itemchanged;

string ls_dbc[], ls_dbv[], ls_dwc[]
integer li_ok

CHOOSE CASE string(dwo.name)
	CASE "tipo_scadenza"
		
		CHOOSE CASE data
			CASE "A"
				THIS.object.sog_com_codice_t.Text = "Cliente:"
				idw_source.object.sog_commerciale_codice_t.Text = "Codice~rCliente"
				idw_source.object.anagrafica_rag_soc_1_t.Text = "Ragione Sociale~rCliente"
				
				idw_target.object.codice_t.Text = "Codice~rCliente"
				idw_target.object.descrizione_t.Text = "Ragione Sociale~rCliente"
			CASE "P"
				THIS.object.sog_com_codice_t.Text = "Fornitore:"
				idw_source.object.sog_commerciale_codice_t.Text = "Codice~rFornitore"
				idw_source.object.anagrafica_rag_soc_1_t.Text = "Ragione Sociale~rFornitore"
				
				idw_target.object.codice_t.Text = "Codice~rFornitore"
				idw_target.object.descrizione_t.Text = "Ragione Sociale~rFornitore"
		END CHOOSE
		
	CASE "sog_com_codice"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dbc[3] = "id_sog_commerciale"
		
		ls_dwc[1] = "sog_com_codice"
		ls_dwc[2] = "sog_com_descrizione"
		ls_dwc[3] = "id_sog_commerciale"		
		
		li_ok = uf_autofind_col(string(dwo.name), "sog_commerciale_gen", "codice", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			THIS.Event ue_setup_filter()
			RETURN 2
		END IF
		
	CASE "sog_com_descrizione"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dbc[3] = "id_sog_commerciale"
		
		ls_dwc[1] = "sog_com_codice"
		ls_dwc[2] = "sog_com_descrizione"
		ls_dwc[3] = "id_sog_commerciale"		
		
		li_ok = uf_autofind_col(string(dwo.name), "sog_commerciale_gen", "rag_soc_1", "A", data, "", 3, ls_dbc, ls_dbv, ls_dwc)
		IF li_ok > 0 THEN
			THIS.Event ue_setup_filter()
			RETURN 2
		END IF
		
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;

string ls_pref_cod_cliente
long ll_pref_cod_cliente

CHOOSE CASE as_nomecol
	CASE "sog_com_codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_imm_retrieve = TRUE
		SELECT par_sistema.pref_cod_cliente
			INTO :ls_pref_cod_cliente
			FROM par_sistema
			WHERE par_sistema.id_azienda in (0, 1)
			USING SQLCA;
			
		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				ll_pref_cod_cliente = len(ls_pref_cod_cliente)
				is_ricpar.s_SQL_cond = "left(sog_commerciale_gen.codice, " + string(ll_pref_cod_cliente) + ") = '" + ls_pref_cod_cliente + "'"
		END CHOOSE

	CASE "sog_com_descrizione"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"
		is_ricpar.b_imm_retrieve = TRUE
		SELECT par_sistema.pref_cod_cliente
			INTO :ls_pref_cod_cliente
			FROM par_sistema
			WHERE par_sistema.id_azienda in (0, 1)
			USING SQLCA;
			
		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				ll_pref_cod_cliente = len(ls_pref_cod_cliente)
				is_ricpar.s_SQL_cond = "left(sog_commerciale_gen.codice, " + string(ll_pref_cod_cliente) + ") = '" + ls_pref_cod_cliente + "'"
		END CHOOSE

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol
	CASE "sog_com_codice"
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_com_descrizione", is_ricpar.s_ausil_value[1])		
		
		THIS.Event ue_setup_filter()
	CASE "sog_com_descrizione"
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("sog_com_codice", is_ricpar.s_ausil_value[1])		
		
		THIS.Event ue_setup_filter()
END CHOOSE

end event

event ue_default;call super::ue_default;

CHOOSE CASE string(adwo_current.name)
	CASE "data_scadenza"
		THIS.SetItem(THIS.GetRow(), "data_scadenza", Today())
		THIS.Event ue_setup_filter()
END CHOOSE

end event

type tabpage_scadenze from userobject within tab_1
int X=18
int Y=104
int Width=2638
int Height=1192
long BackColor=79741120
string Text="Scadenze"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
cb_remove_all cb_remove_all
cb_remove_many cb_remove_many
cb_drop_many cb_drop_many
cb_drop_all cb_drop_all
dw_insoluti_scadenze_ext_gd dw_insoluti_scadenze_ext_gd
dw_insoluti_scadenze_gd dw_insoluti_scadenze_gd
end type

on tabpage_scadenze.create
this.cb_remove_all=create cb_remove_all
this.cb_remove_many=create cb_remove_many
this.cb_drop_many=create cb_drop_many
this.cb_drop_all=create cb_drop_all
this.dw_insoluti_scadenze_ext_gd=create dw_insoluti_scadenze_ext_gd
this.dw_insoluti_scadenze_gd=create dw_insoluti_scadenze_gd
this.Control[]={this.cb_remove_all,&
this.cb_remove_many,&
this.cb_drop_many,&
this.cb_drop_all,&
this.dw_insoluti_scadenze_ext_gd,&
this.dw_insoluti_scadenze_gd}
end on

on tabpage_scadenze.destroy
destroy(this.cb_remove_all)
destroy(this.cb_remove_many)
destroy(this.cb_drop_many)
destroy(this.cb_drop_all)
destroy(this.dw_insoluti_scadenze_ext_gd)
destroy(this.dw_insoluti_scadenze_gd)
end on

type cb_remove_all from commandbutton within tabpage_scadenze
event clicked pbm_bnclicked
int X=1175
int Y=756
int Width=247
int Height=88
int TabOrder=13
string Text="<<"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_remove_all()
end event

type cb_remove_many from commandbutton within tabpage_scadenze
event clicked pbm_bnclicked
int X=1175
int Y=616
int Width=247
int Height=88
int TabOrder=12
string Text="<"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_remove_many()
end event

type cb_drop_many from commandbutton within tabpage_scadenze
event clicked pbm_bnclicked
int X=1175
int Y=436
int Width=247
int Height=88
int TabOrder=11
string Text=">"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_drop_many()
end event

type cb_drop_all from commandbutton within tabpage_scadenze
event clicked pbm_bnclicked
int X=1175
int Y=296
int Width=247
int Height=88
int TabOrder=31
string Text=">>"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_drop_all()
end event

type dw_insoluti_scadenze_ext_gd from u_dw_ext_main within tabpage_scadenze
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
int X=1463
int Y=40
int Width=1120
int Height=1100
int TabOrder=10
string DataObject="d_insoluti_scadenze_ext_gd"
boolean TitleBar=true
string Title="Selezionate"
boolean HScrollBar=true
boolean VScrollBar=true
string Icon="None!"
end type

event ue_buttonup;call super::ue_buttonup;ib_down_target = FALSE
end event

event ue_buttondown;call super::ue_buttondown;ib_down_target = TRUE
end event

event ue_mousemove;call super::ue_mousemove;IF idw_target.GetRow () > 0 AND &
	ib_down_target = TRUE THEN
	idw_target.Drag (begin!)
	idw_target.DragIcon = 'Application!'
END IF

end event

event clicked;call super::clicked;long ll_RetVal

IF KeyDown(KeyControl!) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

IF KeyDown(KeyShift!) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

end event

event dragdrop;call super::dragdrop;DragObject ldo_source
DataWindow ldw_source

ldo_source = DraggedObject()

CHOOSE CASE TypeOf(ldo_source)
	CASE DataWindow!
		ldw_source = ldo_source
		IF ldw_source.DataObject = "d_insoluti_scadenze_gd" AND (ib_down_source = TRUE) THEN
			
			uf_drop_many()
		END IF
END CHOOSE

end event

event dragenter;call super::dragenter;IF ib_down_source = TRUE THEN
	THIS.dragicon = 'Rectangle!'
END IF
end event

event dragleave;call super::dragleave;IF ib_down_source = TRUE THEN
	idw_source.DragIcon = 'Application!'
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

type dw_insoluti_scadenze_gd from datawindow within tabpage_scadenze
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
int X=14
int Y=40
int Width=1111
int Height=1100
int TabOrder=1
string DataObject="d_insoluti_scadenze_gd"
boolean TitleBar=true
string Title="Disponibili"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
string Icon="None!"
end type

event ue_buttonup;ib_down_source = FALSE
end event

event ue_buttondown;ib_down_source = TRUE
end event

event ue_mousemove;IF idw_source.GetRow () > 0 AND &
	ib_down_source = TRUE THEN
	idw_source.Drag (begin!)
	idw_source.DragIcon = 'Application!'
END IF

end event

event clicked;long ll_RetVal

IF KeyDown(KeyControl!) OR KeyDown(KeyShift!) OR (row = THIS.GetRow()) THEN
	THIS.SelectRow(row, NOT THIS.IsSelected(row))
END IF

end event

event dragdrop;IF ib_down_target = TRUE THEN
	uf_remove_many()
END IF

end event

event dragenter;IF ib_down_source = TRUE THEN
	idw_source.DragIcon = 'Application!'
END IF

IF ib_down_target = TRUE THEN
	THIS.dragicon = 'Rectangle!'
END IF
end event

event dragleave;IF ib_down_target = TRUE THEN
	idw_source.DragIcon = 'Application!'
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

