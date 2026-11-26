forward
global type w_var_dati_doc_cx from w_wiz_main
end type
type cb_chiudi from commandbutton within w_var_dati_doc_cx
end type
type cb_crea from commandbutton within w_var_dati_doc_cx
end type
type tab_distinta from tab within w_var_dati_doc_cx
end type
type tab_filtri from userobject within tab_distinta
end type
type dw_filtro_ff from u_dw_ext_main within tab_filtri
end type
type st_5 from statictext within tab_filtri
end type
type tab_modifiche from userobject within tab_distinta
end type
type dw_modifiche_ff from u_dw_ext_main within tab_modifiche
end type
type st_6 from statictext within tab_modifiche
end type
type tab_seleziona from userobject within tab_distinta
end type
type cb_drop_all from commandbutton within tab_seleziona
end type
type cb_drop_many from commandbutton within tab_seleziona
end type
type cb_remove_many from commandbutton within tab_seleziona
end type
type cb_remove_all from commandbutton within tab_seleziona
end type
type dw_recuperati_lt from u_dw_pura within tab_seleziona
end type
type st_4 from statictext within tab_seleziona
end type
type dw_selezionati_lt from u_dw_pura within tab_seleziona
end type
type st_3 from statictext within tab_seleziona
end type
type dw_var_dati_artrec_ff from u_dw_pura within tab_seleziona
end type
type st_1 from statictext within tab_seleziona
end type
type st_2 from statictext within tab_seleziona
end type
type dw_cpt_wrk from datawindow within tab_seleziona
end type
type tab_filtri from userobject within tab_distinta
dw_filtro_ff dw_filtro_ff
st_5 st_5
end type
type tab_modifiche from userobject within tab_distinta
dw_modifiche_ff dw_modifiche_ff
st_6 st_6
end type
type tab_seleziona from userobject within tab_distinta
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_recuperati_lt dw_recuperati_lt
st_4 st_4
dw_selezionati_lt dw_selezionati_lt
st_3 st_3
dw_var_dati_artrec_ff dw_var_dati_artrec_ff
st_1 st_1
st_2 st_2
dw_cpt_wrk dw_cpt_wrk
end type
type tab_distinta from tab within w_var_dati_doc_cx
tab_filtri tab_filtri
tab_modifiche tab_modifiche
tab_seleziona tab_seleziona
end type
end forward

global type w_var_dati_doc_cx from w_wiz_main
int X=434
int Y=348
int Width=3474
int Height=1740
WindowType WindowType=response!
boolean TitleBar=true
string Title="Variazione dati Documento"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_chiudi cb_chiudi
cb_crea cb_crea
tab_distinta tab_distinta
end type
global w_var_dati_doc_cx w_var_dati_doc_cx

type variables
DataWindow idw_source, idw_target,idw_modifica,  ids_cpt
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
Decimal idc_imp_max_distinta
s_distinta is_distinta
char ic_tipo_scadenza
long il_id_banca_azienda, il_id_dis_banca, il_rowtesta
u_ds_main ids_riga, ids_spese, ids_iva
long	il_az_idcontoprd	
long il_az_idivaart15, il_rt_id_tab_iva_acconto, il_sc_idconto
string is_td_tiporeg
decimal id_tot_acconto, idc_td_cambio
long il_id_esercizio, il_id_valuta

end variables

forward prototypes
public subroutine uf_drop_all ()
public subroutine uf_drop_many ()
public subroutine uf_remove_all ()
public subroutine uf_remove_many ()
public subroutine uf_drop (long al_row_source)
public subroutine uf_remove (long al_row_target)
public function decimal uf_getitemdecimal (datawindow adw_dwobj, long al_row, string as_column)
public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg)
public function boolean wf_calc_cpt ()
public function integer wf_calc_cpt_righe ()
public subroutine wf_calc_cpt_sconti ()
public subroutine wf_calc_cpt_spese ()
public function integer wf_calc_cpt_totali ()
public subroutine wf_calc_cpt_quadra ()
public subroutine wf_calc_cpt_ripul ()
public function decimal wf_calc_prezzo_riga (string as_sconto, decimal ad_prezzo, decimal ad_quant)
public function integer wf_insert_riga_cpt (long al_idcpt, string as_tipo, datawindow ads_cpt, decimal ad_imponibile, decimal ad_impscontato, decimal ad_omaggism, decimal ad_spese)
public function integer wf_calc_righe_cast ()
public function integer wf_insert_riga_iva (long al_idtabiva, decimal ad_aliquota, decimal ad_perdetra, decimal ad_imponibile, decimal ad_imposta, decimal ad_omaggism, u_ds_main ads_cast)
public function long wf_setup_cast_iva (long al_riga)
end prototypes

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

public function decimal uf_getitemdecimal (datawindow adw_dwobj, long al_row, string as_column);

decimal ld_value

ld_value = adw_dwobj.GetItemNumber(al_row,as_column)
if not (isNull(ld_value)) then
	ld_value = adw_dwobj.GetItemDecimal(al_row,as_column)
end if

return ld_value


end function

public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg);long i, ll_righe, ll_row
string ls_filter
boolean lb_filter

if as_filtro_agg<>"" then
	ls_filter=as_filtro_agg+" and ("
else
	ls_filter="("
end if
lb_filter=(as_col_origine<>"")and(as_col_dest<>"")
if NOT(KeyDown(KeyShift!))And NOT(KeyDown(KeyControl!)) then
	ll_righe=adw_origine.RowCount()
	ll_row=row
	
	for i = 1 to ll_righe
		if i=ll_row then continue
		if adw_origine.IsSelected(i) then adw_origine.SelectRow(i,false)
	next
	
	adw_origine.SelectRow(ll_row, not (adw_origine.isselected(ll_row)))
	if lb_filter then ls_filter = ls_filter + as_col_dest+' ='+string(adw_origine.GetItemNumber(ll_row,as_col_origine))+' or '
elseif KeyDown(KeyShift!) then
		ll_row=row
		adw_origine.SelectRow(ll_row,true)
		ll_righe=adw_origine.RowCount()
		ll_row=ll_righe
		
		for i= 1 to ll_row
			if adw_origine.IsSelected(i) then ll_row=i
		next
		
		for i=ll_row+1 to ll_righe
			if adw_origine.IsSelected(i) then ll_righe=i
		next
		
		for i = ll_row to ll_righe
			adw_origine.SelectRow(i,true)
			if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '					
		next
	elseif KeyDown(KeyControl!) then
		
		ll_row=row
		adw_origine.SelectRow(ll_row,Not adw_origine.IsSelected(ll_row))
		
		ll_righe=adw_origine.RowCount()
		for i = 1 to ll_righe
			if adw_origine.IsSelected(i) then
				if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '	
			end if
		next
end if
	return ""

	

end function

public function boolean wf_calc_cpt ();boolean		lb_ok
long			ll_nr

lb_ok = true

ids_cpt.reset()
ll_nr = wf_calc_cpt_righe()						
if ll_nr>0 then
	
	wf_calc_cpt_sconti()								
	wf_calc_cpt_spese()								
	
	wf_calc_cpt_totali()								
	
	wf_calc_cpt_quadra() 							
	wf_calc_cpt_ripul() 								
	
end if

ids_cpt.SetSort("tipo_riga_cpt A")
ids_cpt.Sort()

return lb_ok

end function

public function integer wf_calc_cpt_righe ();long		ll_nrows, ll_count, ll_idcpt, ll_idtabiva, ll_create, ll_id_uc
decimal	ld_totriga, ld_qta, ld_qtasm, ld_preuni, ld_prenet, ld_temp, ld_peso
string	ls_rigavalida, ls_sconto
string ls_cpt_sconti
long ll_id_cpt_sconti, ll_id_sog_commerciale, ll_gen_row, ll_id_articolo
decimal ldc_sc_fin_cassa, ldc_sc_incondizionato, ldc_sconto_riga, ldc_sconto_unit_riga, ldc_sconto_merce,ldc_imponibile, ldc_imponibile_non_sc
string ls_sc_finanziario

select gest_cpt_sconti
into :ls_cpt_sconti
from par_sistema;

ll_id_sog_commerciale=idw_target.getitemnumber(il_rowtesta,'id_sog_commerciale')
ls_sc_finanziario= idw_target.GetItemString(il_rowtesta, "documento_sconto_finanziario")
ldc_sc_incondizionato= idw_target.GetItemDecimal(il_rowtesta, "sconto_fin_incondizionato")
ldc_sc_fin_cassa= idw_target.GetItemDecimal(il_rowtesta, "documento_sconto_fin_cassa")

long ll_id_valuta, ll_id_esercizio, ll_id_val_conto, ll_id_val_euro
decimal ld_cambio_appoggio, ld_parita_euro
ll_id_valuta=il_id_valuta
ll_id_esercizio=il_id_esercizio

SELECT "valuta"."cambio",   
		 "valuta"."parita_euro"
	INTO :ld_cambio_appoggio,   
		  :ld_parita_euro
	FROM "dba"."valuta"  
	WHERE "valuta"."id_valuta" = :ll_id_valuta;

select id_val_euro
into :ll_id_val_euro
from par_sistema;

select id_valuta
into :ll_id_val_conto
from esercizio
where id_esercizio = :ll_id_esercizio;

if ll_id_val_conto = ll_id_val_euro then ld_cambio_appoggio = ld_parita_euro

ll_create = 0
ll_nrows = ids_riga.RowCount()
for ll_count = 1 to ll_nrows
	
	ld_totriga = ids_riga.GetItemDecimal(ll_count, "tot_riga_val_az")
	if IsNull(ld_totriga)  then ld_totriga = 0
	ld_qta = ids_riga.GetItemDecimal(ll_count, "quantita")
	if IsNull(ld_qta)  then ld_qta = 0

	
	ll_id_uc = ids_riga.GetItemnumber(ll_count, "id_unita_confezione")
	ld_peso = ids_riga.GetItemDecimal(ll_count, "peso_netto")
	if IsNull(ld_peso)  then ld_peso = 0	
	string ls_tipo
	select tipo
	into :ls_tipo
	from unita_confezione, unita_misura
	where (unita_confezione.id_unita_confezione=:ll_id_uc) and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
	
	
	ld_qtasm = ids_riga.GetItemDecimal(ll_count, "qta_sconto_merce")
	if IsNull(ld_qtasm)  then ld_qtasm = 0
	ld_preuni = ids_riga.GetItemDecimal(ll_count, "prezzo")
	if IsNull(ld_preuni)  then ld_preuni = 0
	ls_sconto = ids_riga.GetItemString(ll_count, "sconto")
	if IsNull(ls_sconto)  then ls_sconto = ""
	
	ll_idtabiva= ids_riga.GetItemNumber(ll_count, "id_tab_iva")
	ll_idcpt = ids_riga.GetItemNumber(ll_count, "id_conto")
	If IsNull(ll_idcpt) OR ll_idcpt = 0 then ll_idcpt = il_az_idcontoprd
	
	ls_rigavalida = ids_riga.GetItemString(ll_count, "c_riga_valida")
	ld_prenet = wf_calc_prezzo_riga (ls_sconto, 1000000, 1)
	
	If (ls_rigavalida="V") then
		
		
		ldc_sconto_riga = ids_riga.GetItemnumber(ll_count, "sconto_riga")
		ldc_sconto_unit_riga = 0
		ldc_sconto_merce= ids_riga.uf_GetItemDecimal(ll_count, "qta_sconto_merce")
		if IsNull(ldc_sconto_merce)  then ldc_sconto_merce = 0		
		ll_id_articolo= ids_riga.GetItemNumber(ll_count, "id_articolo")
		
		if ls_cpt_sconti = 'S' then
			uo_cpt_sconti u_cpt_sconti
			u_cpt_sconti = create uo_cpt_sconti

		 	
			
			ll_id_cpt_sconti = u_cpt_sconti.uf_cpt_sconti("",0,0,ls_sconto,ldc_sconto_merce,ldc_sconto_riga,ldc_sconto_unit_riga, ll_id_sog_commerciale, ll_id_articolo)							  
		 	
			 
			
			destroy (u_cpt_sconti)
		end if
		
		
		if ld_prenet = 0 then
			
			
			
			if ls_tipo = 'P' then
				ld_temp = (ld_peso * ld_preuni * ld_cambio_appoggio) 
			else
				ld_temp = (ld_qta * ld_preuni * ld_cambio_appoggio) 
			end if			
			
			
		
			
			if ls_cpt_sconti = 'S' and (isnull(ll_id_cpt_sconti) = false or ll_id_cpt_sconti <> 0) then 
				
				
				wf_insert_riga_cpt (ll_idcpt, "C", ids_cpt, ld_temp, 0, 0, 0)				
				wf_insert_riga_cpt (ll_id_cpt_sconti, "S", ids_cpt, ld_temp, 0, 0, 0)				
			else 
						
				wf_insert_riga_cpt (ll_idcpt, "C", ids_cpt, 0, 0, ld_temp, 0)				
				
			end if
			
		else
			
			ld_temp = (ld_qtasm * ld_preuni)
			
								
			
			if ls_cpt_sconti = 'S' and (isnull(ll_id_cpt_sconti) = false or ll_id_cpt_sconti <> 0) then	
	
				
				if ls_tipo = 'P' then
					ldc_imponibile_non_sc=(ld_peso * ld_preuni * ld_cambio_appoggio) 
				else
					ldc_imponibile_non_sc=(ld_qta * ld_preuni * ld_cambio_appoggio) 

				end if			
				
				
			
				wf_insert_riga_cpt(ll_idcpt,"C", ids_cpt, ldc_imponibile_non_sc ,0, 0, 0)
				ldc_imponibile=ldc_imponibile_non_sc - ld_totriga
				wf_insert_riga_cpt(ll_id_cpt_sconti,"S", ids_cpt, ldc_imponibile ,0, 0, 0)
			else							
				ldc_imponibile= ld_totriga
				
				wf_insert_riga_cpt(ll_idcpt,"C", ids_cpt, ldc_imponibile ,0, 0, 0)
			end if
			
						
		end if
		ll_create ++
	end if
next

return ll_create

end function

public subroutine wf_calc_cpt_sconti ();
long			ll_nrows, ll_count
decimal		ld_temp, ld_impon, ld_rimanenza
decimal		ld_qprop, ld_percinc
decimal		ld_scfincas, ld_scfininc
string		ls_scfinanz
string ls_cpt_sconti, ls_tipo_cpt
long ll_id_cpt_sconti, ll_id_sog_commerciale
decimal  ldc_sconto_riga, ldc_sconto_unit_riga

select gest_cpt_sconti
into :ls_cpt_sconti
from par_sistema;

ls_scfinanz = idw_target.GetItemString(il_rowtesta,"documento_sconto_finanziario")
ld_scfininc = idw_target.GetItemDecimal(il_rowtesta,"sconto_fin_incondizionato")
ld_scfincas = idw_target.GetItemDecimal(il_rowtesta,"documento_sconto_fin_cassa")


ll_nrows = ids_cpt.rowcount()
for ll_count = 1 to ll_nrows
	ld_temp = Round(ids_cpt.GetItemNumber(ll_count, "c_proporzionale"), 2)
	ids_cpt.SetItem(ll_count, "c_prop_imp", ld_temp)
next

decimal ldc_imponibile, ldc_imponibile1, ldc_imponibile2
boolean lb_ok
long ll_count_app

if ls_cpt_sconti = 'S' then
	ldc_imponibile = 0
	ll_id_sog_commerciale=idw_target.getitemnumber(il_rowtesta,'id_sog_commerciale')
	
	uo_cpt_sconti u_cpt_sconti
	u_cpt_sconti = create uo_cpt_sconti	
	ll_id_cpt_sconti = u_cpt_sconti.uf_cpt_sconti(ls_scfinanz,0,0,"",0,0,0, ll_id_sog_commerciale, 0)				  
	destroy (u_cpt_sconti)
	
	if not isnull(ll_id_cpt_sconti) then
		lb_ok = false
		for ll_count = 1 to ll_nrows
			ls_tipo_cpt = ids_cpt.getitemstring(ll_count,"tipo_riga_cpt")
			ldc_imponibile1= ids_cpt.GetItemDecimal(ll_count, "val_imponibile")
			ids_cpt.SetItem(ll_count, "val_imp_scontato", ldc_imponibile1)			
			
			choose case ls_tipo_cpt
				case "C"
					ldc_imponibile = ldc_imponibile + ldc_imponibile1
				CASE "S"
					ldc_imponibile = ldc_imponibile - ldc_imponibile1
					
					if ids_cpt.getitemnumber(ll_count, "id_conto") = ll_id_cpt_sconti then
						lb_ok = true
						ll_count_app = ll_count
					end if
			end choose
		next				
				
		ldc_imponibile2= wf_calc_prezzo_riga(ls_scfinanz, ldc_imponibile, 0)
		ldc_imponibile = ldc_imponibile - ldc_imponibile2
		
		if lb_ok = true then
			ids_cpt.SetItem(ll_count_app, "val_imponibile", ldc_imponibile+ldc_imponibile1)
			ids_cpt.SetItem(ll_count_app, "val_imp_scontato", ldc_imponibile+ldc_imponibile1)				
		else
			wf_insert_riga_cpt (ll_id_cpt_sconti, "S", ids_cpt, ldc_imponibile, ldc_imponibile, 0, 0)
		end if
	else
		for ll_count = 1 to ll_nrows
			ld_temp = ids_cpt.GetItemDecimal(ll_count, "val_imponibile")
			If not (IsNull(ls_scfinanz) OR ls_scfinanz = "") then
				ld_temp = wf_calc_prezzo_riga(ls_scfinanz, ld_temp, 0)
			end if
			ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_temp)
		next		
	end if			
else
	for ll_count = 1 to ll_nrows
		ld_temp = ids_cpt.GetItemDecimal(ll_count, "val_imponibile")
		If not (IsNull(ls_scfinanz) OR ls_scfinanz = "") then
			ld_temp = wf_calc_prezzo_riga(ls_scfinanz, ld_temp, 0)
		end if
		ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_temp)
	next
end if

ld_rimanenza = 0

If not (IsNull(ld_scfininc) OR ld_scfininc = 0) then
	if ll_nrows > 0 then
		for ll_count = 1 to ll_nrows - 1
			ld_impon = ids_cpt.GetItemDecimal(ll_count, "val_imp_scontato")
			ld_qprop = ids_cpt.GetItemDecimal(ll_count, "c_proporzionale")
			
			
			ld_impon = ld_impon - ld_percinc
			ld_rimanenza = ld_rimanenza + ld_percinc
			ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_impon)
		next
		
		ld_impon = ids_cpt.GetItemDecimal(ll_nrows, "val_imp_scontato")
		ld_impon = ld_impon - ld_scfininc + ld_rimanenza
		ids_cpt.SetItem(ll_nrows, "val_imp_scontato", ld_impon)
	end if
end if


If not (IsNull(ld_scfincas) OR ld_scfincas = 0) then
	for ll_count = 1 to ll_nrows
		ld_impon = ids_cpt.GetItemDecimal(ll_count, "val_imp_scontato")
		ld_impon = ld_impon - (ld_impon * ld_scfincas / 100)
		ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_impon)
	next
end if


end subroutine

public subroutine wf_calc_cpt_spese ();long		ll_count, ll_nrows
long		ll_idspesa, ll_idconto
decimal	ld_importo

ll_nrows = ids_spese.rowcount()
for ll_count = 1 to ll_nrows
	
	ll_idspesa= ids_spese.GetItemNumber(ll_count, "id_spesa")

	choose case is_td_tiporeg
		
		CASE "IA", "PA", "OA", "DA", "LA", "GA"			
			SELECT	"conto_azienda"."id_conto"
				INTO	:ll_idconto
				FROM	"dba"."conto_azienda", "dba"."spesa"  
				WHERE ("spesa"."id_conto_acquisti" = "conto_azienda"."id_conto" ) and  
						("spesa"."id_spesa" = :ll_idspesa) and
						("conto_azienda"."id_azienda" = 1);

		
		CASE "IV", "PV", "OV", "DV", "LV", "GV", "IC"
			SELECT	"conto_azienda"."id_conto"  
				INTO	:ll_idconto
				FROM	"dba"."conto_azienda", "dba"."spesa"  
				WHERE ("spesa"."id_conto_vendite" = "conto_azienda"."id_conto" ) and
						("spesa"."id_spesa" = :ll_idspesa ) and
						("conto_azienda"."id_azienda" = 1);
			
	end choose
	if sqlca.sqlcode<>0 then
		setNull (ll_idconto)
	end if
	
	If not (IsNull(ll_idconto) OR ll_idconto=0) then 
		ld_importo = ids_spese.GetItemDecimal(ll_count, "c_importo_lire")
		wf_insert_riga_cpt (ll_idconto, "C", ids_cpt, 0 , 0, 0, ld_importo)
	end if
next



end subroutine

public function integer wf_calc_cpt_totali ();long		ll_scode, ll_iddetr, ll_idnond, ll_castrow,ll_row_iva
decimal	ld_totdetr, ld_totnond
decimal	ld_valomsc, ld_totdocu

ld_valomsc = idw_target.GetItemDecimal (il_rowtesta, "c_val_omaggi")
ld_valomsc = ld_valomsc + idw_target.GetItemDecimal (il_rowtesta, "c_val_sc_merce_art_15")
ld_valomsc = ld_valomsc + idw_target.GetItemDecimal (il_rowtesta, "c_val_sc_merce_iva")
ld_valomsc = ld_valomsc * idc_td_cambio
ld_valomsc = truncate (ld_valomsc,0)

ll_row_iva = ids_iva.RowCount()
if ll_row_iva > 0  then		
	ld_totdocu = ids_iva.GetItemDecimal(1, "c_tot_val_tot_imp_l")
	ld_totdocu = ld_totdocu + ids_iva.GetItemDecimal(1, "c_tot_val_tot_iva_l")	
	wf_insert_riga_cpt (il_sc_idconto, "S", ids_cpt, 0, ld_totdocu, ld_valomsc, 0)
else	
end if	



choose case is_td_tiporeg
	case "IA", "PA", "OA", "DA", "LA", "GA"
		SELECT "par_sistema"."id_conto_iva_ia", "par_sistema"."id_conto_iva_nd"  
		INTO :ll_iddetr, :ll_idnond
		FROM "dba"."par_sistema"
		WHERE "par_sistema"."id_azienda" = 1 ;
		ll_scode = sqlca.sqlcode

	case "IV", "PV", "OV", "DV", "LV", "GV"
		SELECT "par_sistema"."id_conto_iva_iv", "par_sistema"."id_conto_iva_nd"  
		INTO :ll_iddetr, :ll_idnond
		FROM "dba"."par_sistema"
		WHERE "par_sistema"."id_azienda" = 1 ;
		ll_scode = sqlca.sqlcode

	case else
		ll_scode = -1
end choose


If ll_scode = 0 then
	
	
	ll_castrow= ids_iva.RowCount()
	If ll_castrow > 0 then
		ld_totdetr = ids_iva.GetItemDecimal(ll_castrow,"c_tot_detraibile")
		if ld_totdetr>0 then
			wf_insert_riga_cpt (ll_iddetr, "I", ids_cpt, 0 , ld_totdetr, 0, 0)
		end if
		ld_totnond = ids_iva.GetItemDecimal(ll_castrow,"c_tot_non_detraibile")
		if ld_totnond>0 then
			wf_insert_riga_cpt (ll_idnond, "N", ids_cpt, 0 , ld_totnond, 0, 0)
		end if
	end if
	
end if

return 0

end function

public subroutine wf_calc_cpt_quadra ();long 		ll_nr_row, ll_row, ll_row_c
string	ls_tipo
decimal	ldc_valore_c, ldc_valore_imp_sc ,ldc_valore_spese , ldc_valore_s, ldc_differenza, ldc_parziale
decimal	ldc_conguaglio, ldc_valore_in, ldc_acconto
boolean	lb_prima

ldc_valore_c = 0
ll_row_c=0
ll_nr_row= ids_cpt.RowCount()
If ll_nr_row> 0 then
	FOR ll_row = 1 to ll_nr_row
		ls_tipo= ids_cpt.GetItemString(ll_row,"tipo_riga_cpt")
		CHOOSE CASE ls_tipo 
			CASE "C" 
				ll_row_c++
				ldc_valore_imp_sc=ids_cpt.GetItemDecimal(ll_row,"val_imp_scontato")
				If IsNull(ldc_valore_imp_sc) then ldc_valore_imp_sc = 0
				ldc_valore_spese=ids_cpt.GetItemDecimal(ll_row,"val_spese")
				If IsNull(ldc_valore_spese) then ldc_valore_spese = 0
				ldc_valore_c= ldc_valore_c + ldc_valore_imp_sc +ldc_valore_spese
			CASE "I" ,"N" 
				ldc_valore_imp_sc=ids_cpt.GetItemDecimal(ll_row,"val_imp_scontato")
				If IsNull(ldc_valore_imp_sc) then ldc_valore_imp_sc = 0
				ldc_valore_in= ldc_valore_in + ldc_valore_imp_sc
			CASE "S" 
				if isnull(ldc_valore_s) then ldc_valore_s=0
				ldc_valore_s= ldc_valore_s+ids_cpt.GetItemDecimal(ll_row,"val_imp_scontato")
		END CHOOSE
	NEXT
	ldc_differenza= ldc_valore_s - (ldc_valore_c + ldc_valore_in) 
	If ldc_differenza <> 0 and ll_row_c>0  then 
		ldc_parziale= Round(ldc_differenza/ll_row_c, 0)
		ldc_conguaglio= ldc_parziale + (ldc_differenza - (ldc_parziale * ll_row_c))
		lb_prima= TRUE
		FOR ll_row = 1 to ll_nr_row - 1
			ls_tipo= ids_cpt.GetItemString(ll_row,"tipo_riga_cpt")
			If ls_tipo = "C" then
				ldc_valore_imp_sc= ids_cpt.GetItemDecimal(ll_row,"val_imp_scontato")
				If lb_prima then
					lb_prima= FALSE
					ids_cpt.SetItem(ll_row,"val_imp_scontato", ldc_valore_imp_sc + ldc_conguaglio)
				else
					ids_cpt.SetItem(ll_row,"val_imp_scontato", ldc_valore_imp_sc + ldc_parziale)
				end if
			end if
		NEXT
	end if
end if
	
	
end subroutine

public subroutine wf_calc_cpt_ripul ();
long 		ll_nr_row, ll_count, ll_row
decimal 	ldc_valore

ll_nr_row= ids_cpt.RowCount()
for ll_count =  1 to ll_nr_row 
	ll_row=ll_nr_row - ll_count + 1
	ldc_valore=ids_cpt.GetItemNumber(ll_row, "c_valore")
	If (IsNull(ldc_valore) Or ldc_valore=0) then
		ids_cpt.DeleteRow(ll_row)
	end if
next


end subroutine

public function decimal wf_calc_prezzo_riga (string as_sconto, decimal ad_prezzo, decimal ad_quant);
long		ll_char_size,	ll_char_count,	ll_item_count
long		ll_row,			ll_pos_plus,	ll_pos_minus,	ll_pos
decimal  ldc_parte,		ldc_tot_riga
string	ls_parte,		ls_tot_riga
char		lch_sconto[],	lch_item[]
boolean 	lb_minus,		lb_non_calcolabile



lb_minus= FALSE
lch_item = ""
ll_item_count=0
if IsNull(ad_prezzo) then ad_prezzo = 0
if not (IsNull(as_sconto) OR as_sconto= "") then
	lch_sconto= Trim(as_sconto)
	ll_char_size= UpperBound(lch_sconto)
	For ll_char_count= 1 to ll_char_size
		CHOOSE CASE lch_sconto[ll_char_count]
			CASE "-"
				If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if  ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							ad_prezzo = ad_prezzo + ad_prezzo * (ldc_parte / 100)
						else
							ad_prezzo = ad_prezzo - ad_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = TRUE
			CASE "+"
					If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							ad_prezzo = ad_prezzo + ad_prezzo * (ldc_parte / 100)
						else
							ad_prezzo = ad_prezzo - ad_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = FALSE
			CASE ELSE
				ll_item_count ++
				lch_item[ll_item_count]= lch_sconto[ll_char_count]
		END CHOOSE
	next

	If not(lch_item = "") then
		ldc_parte= Dec(lch_item)
		if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
		
			SetNull(ldc_parte)	
			RETURN ldc_parte
		else
			if lb_minus then
				ad_prezzo = ad_prezzo + ad_prezzo * (ldc_parte / 100)
			else
				ad_prezzo = ad_prezzo - ad_prezzo * (ldc_parte / 100)
			end if
		end if
	end if
end if

RETURN ad_prezzo

end function

public function integer wf_insert_riga_cpt (long al_idcpt, string as_tipo, datawindow ads_cpt, decimal ad_imponibile, decimal ad_impscontato, decimal ad_omaggism, decimal ad_spese);
integer		li_ret
long			ll_rowfound
string		ls_codice, ls_descrizione
decimal		ld_temp


li_ret = 0

if not (IsNull(al_idcpt) OR al_idcpt = 0) then 
	
	If ads_cpt.RowCount() > 0 then
		ll_rowfound = ads_cpt.Find("id_conto =" + string(al_idcpt),1,ads_cpt.RowCount())
	else
		ll_rowfound = 0
	end if
	if ll_rowfound=0 then
		
		SELECT	"conto_azienda"."codice", "conto_azienda"."descrizione"  
			INTO	:ls_codice,	:ls_descrizione  
			FROM	"dba"."conto_azienda"  
			WHERE	"conto_azienda"."id_conto" = :al_idcpt;

		
		ll_rowfound = ads_cpt.InsertRow(0)
		if ll_rowfound > 0 then					
			ads_cpt.SetItem(ll_rowfound, "id_conto",al_idcpt)
			ads_cpt.SetItem(ll_rowfound, "tipo_riga_cpt", as_tipo)
			ads_cpt.SetItem(ll_rowfound, "conto_azienda_codice",ls_codice)
			ads_cpt.SetItem(ll_rowfound, "conto_azienda_descrizione",ls_descrizione)
			ads_cpt.SetItem(ll_rowfound, "val_imponibile", ad_imponibile)
			ads_cpt.SetItem(ll_rowfound, "val_imp_scontato", ad_impscontato)
			ads_cpt.SetItem(ll_rowfound, "val_omaggi", ad_omaggism)
			ads_cpt.SetItem(ll_rowfound, "val_spese", ad_spese)
		else
			li_ret = -1
		end if
	else
		
		

		ld_temp = ads_cpt.GetItemDecimal(ll_rowfound,"val_imponibile")
		if IsNull(ld_temp) then ld_temp = 0
		ads_cpt.SetItem(ll_rowfound, "val_imponibile", ld_temp + ad_imponibile)

		ld_temp = ads_cpt.GetItemDecimal(ll_rowfound,"val_imp_scontato")
		if IsNull(ld_temp) then ld_temp = 0
		ads_cpt.SetItem(ll_rowfound, "val_imp_scontato", ld_temp + ad_impscontato)

		ld_temp = ads_cpt.GetItemDecimal(ll_rowfound,"val_omaggi")
		if IsNull(ld_temp) then ld_temp = 0
		ads_cpt.SetItem(ll_rowfound, "val_omaggi", ld_temp + ad_omaggism)

		ld_temp = ads_cpt.GetItemDecimal(ll_rowfound,"val_spese")
		if IsNull(ld_temp) then ld_temp = 0
		ads_cpt.SetItem(ll_rowfound, "val_spese", ld_temp + ad_spese)
	end if
end if

return li_ret

end function

public function integer wf_calc_righe_cast ();


decimal		ld_totaleriga,			ld_prezzounit,			ld_quantita, 		ld_imponibile
decimal		ld_scontomerc,			ld_aliquota,			ld_imposta,			ld_perdetraz
decimal		ld_tot_val_omaggi,	ld_tot_val_sma15,		ld_tot_val_smiva
decimal		ld_val_omaggi_sm,		ld_val_sma15,			ld_val_smiva
decimal		ld_tot_val_om3, 		ld_peso

long			ll_numrighe,	ll_count
long			ll_idtabiva

string		ls_riga_valida
string		ls_sconto


ld_tot_val_omaggi = 0
ld_tot_val_sma15 = 0
ld_tot_val_smiva = 0

ll_numrighe = ids_riga.rowCount()			


for ll_count = 1 to ll_numrighe
	ls_riga_valida = ids_riga.GetItemString(ll_count,"c_riga_valida")
	if ls_riga_valida = "V" then
		
		ld_val_omaggi_sm = 0
		
		
		
		
		
			ld_peso = ids_riga.GetItemDecimal(ll_count, "peso_netto")
		
		
		if isnull(ld_peso) then ld_peso=0
		
		
		
		ld_totaleriga = ids_riga.GetItemDecimal(ll_count, "tot_riga_val_doc")
		ld_prezzounit = ids_riga.GetItemDecimal(ll_count, "prezzo")
		ld_quantita   = ids_riga.GetItemDecimal(ll_count, "quantita")
		ld_scontomerc = ids_riga.GetItemDecimal(ll_count, "qta_sconto_merce")
		ls_sconto     = ids_riga.GetItemString(ll_count, "sconto")
		
		if isNull (ld_totaleriga) then ld_totaleriga = 0
		if isNull (ld_prezzounit) then ld_prezzounit = 0
		if isNull (ld_quantita) then ld_quantita = 0
		if isNull (ld_scontomerc) then ld_scontomerc = 0
		if isNull (ls_sconto) then ls_sconto = ""
		
		ll_idtabiva = ids_riga.GetItemNumber(ll_count, "id_tab_iva")
		if isNull (ll_idtabiva) then
			ld_aliquota = 0
		else
			SELECT	"tab_iva"."per_aliquota", "tab_iva"."per_detrazione"
				INTO	:ld_aliquota, :ld_perdetraz
				FROM	"dba"."tab_iva"  
				WHERE	"tab_iva"."id_tab_iva" = :ll_idtabiva;
		end if	
		
		
		
		if wf_calc_prezzo_riga (ls_sconto, 1000000, 1) = 0 then
			
			ld_imposta= Ceiling((ld_prezzounit * ld_quantita * ld_aliquota) / 100)
			ld_val_omaggi_sm = (ld_quantita * ld_prezzounit)
			ld_tot_val_omaggi = ld_tot_val_omaggi + ld_val_omaggi_sm
			
			wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, ld_imposta, ld_val_omaggi_sm, ids_iva)
		else
			
			
			if ld_quantita <> 0 or ld_peso>0 then
				
				ld_imponibile = ld_totaleriga
				ld_imposta = Ceiling(ld_aliquota * ld_totaleriga / 100)

				wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, ld_imponibile, ld_imposta, 0, ids_iva)

				if ld_scontomerc <> 0 then
					ld_val_omaggi_sm = (ld_scontomerc * (ld_totaleriga / ld_quantita) )
					ld_tot_val_sma15 = ld_tot_val_sma15 + ld_val_omaggi_sm
					
					wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, 0, ld_val_omaggi_sm, ids_iva)
				end if
			else
				
				if ld_scontomerc <> 0 then
					ld_imposta = Ceiling (ld_scontomerc * ld_prezzounit * (ld_aliquota / 100))

					wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, ld_imposta, 0, ids_iva)
					if ll_idtabiva = il_az_idivaart15 then
						ld_val_omaggi_sm = (ld_scontomerc * ld_prezzounit)
						ld_tot_val_sma15 = ld_tot_val_sma15 + ld_val_omaggi_sm
						wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, 0, ld_val_omaggi_sm, ids_iva)
					else
						ld_val_omaggi_sm = (ld_scontomerc * ld_prezzounit) 
						ld_tot_val_smiva = ld_tot_val_smiva + ld_val_omaggi_sm
						wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, 0, ld_val_omaggi_sm, ids_iva)
					end if
				end if
			end if
		end if
	end if
next


if isNull(ld_tot_val_omaggi) then ld_tot_val_omaggi = 0
if isNull(ld_tot_val_sma15)  then ld_tot_val_sma15 = 0
if isNull(ld_tot_val_smiva)  then ld_tot_val_smiva = 0

ld_tot_val_om3 = ld_tot_val_omaggi + ld_tot_val_sma15 + ld_tot_val_smiva

idw_target.SetItem(il_rowtesta, "c_val_omaggi", ld_tot_val_omaggi)
idw_target.SetItem(il_rowtesta, "c_val_sc_merce_art_15", ld_tot_val_sma15)
idw_target.SetItem(il_rowtesta, "c_val_sc_merce_iva", ld_tot_val_smiva)


return 0

end function

public function integer wf_insert_riga_iva (long al_idtabiva, decimal ad_aliquota, decimal ad_perdetra, decimal ad_imponibile, decimal ad_imposta, decimal ad_omaggism, u_ds_main ads_cast);



long			ll_retval, ll_nrows, ll_rowfound, ll_newrow
decimal		ld_temp


ll_retval = 0
if IsNull(al_idtabiva) or al_idtabiva = 0 then ll_retval = -1

if ll_retval <0 then
	return ll_retval
end if


ll_nrows = ads_cast.rowcount()
if ll_nrows >0 then
	ll_rowfound=ads_cast.Find("id_tab_iva =" + string(al_idtabiva),1,ll_nrows)
else
	ll_rowfound=0
end if


if ll_rowfound= 0 then
	ll_newrow = ads_cast.insertrow(0)
	ll_retval = ll_newrow
	
	
	
	
	
	
	
	If il_rt_id_tab_iva_acconto=al_idtabiva then
		ads_cast.setitem(ll_newrow, "cc_acconto", id_tot_acconto)
	end if
	
	ads_cast.SetItem(ll_newrow, "id_tab_iva",al_idtabiva)
	ads_cast.SetItem(ll_newrow, "val_omaggi", ad_omaggism)
	ads_cast.SetItem(ll_newrow, "c_imposta", ad_imposta)
	ads_cast.SetItem(ll_newrow, "val_imponibile", ad_imponibile)
	ads_cast.SetItem(ll_newrow, "c_aliquota", ad_aliquota)
	ads_cast.SetItem(ll_newrow, "cc_per_detrazione", ad_perdetra)
	
else
	
	ll_retval = ll_rowfound
	
	If il_rt_id_tab_iva_acconto=al_idtabiva then
		ads_cast.setitem(ll_newrow, "cc_acconto", id_tot_acconto)
	end if
	
	ld_temp = ads_cast.GetItemDecimal(ll_rowfound,"val_imponibile")
	if IsNull(ld_temp) then ld_temp = 0
	ads_cast.SetItem(ll_rowfound, "val_imponibile", ad_imponibile + ld_temp)
	ld_temp = ads_cast.GetItemDecimal(ll_rowfound,"c_imposta")
	if IsNull(ld_temp) then ld_temp = 0
	ads_cast.SetItem(ll_rowfound, "c_imposta", ad_imposta + ld_temp)
	ld_temp = ads_cast.GetItemDecimal(ll_rowfound,"val_omaggi")
	if IsNull(ld_temp) then ld_temp = 0
	ads_cast.SetItem(ll_rowfound, "val_omaggi", ad_omaggism + ld_temp)
end if

return ll_retval

end function

public function long wf_setup_cast_iva (long al_riga);
long		ll_nr_row, ll_count
decimal	ldc_tot_imp_val_calc ,ldc_tot_iva_val_calc 
decimal	ldc_tot_imp_lire_calc ,ldc_tot_iva_lire_calc 

ll_nr_row = ids_iva.RowCount()
if ll_nr_row > 0 then
	FOR ll_count=1 to ll_nr_row
		ldc_tot_iva_val_calc=ids_iva.GetItemDecimal(ll_count,"c_iva_val")
		ldc_tot_imp_val_calc=ids_iva.GetItemDecimal(ll_count,"c_imponibile_spesa")
		ldc_tot_iva_lire_calc=ids_iva.GetItemDecimal(ll_count,"c_iva_lire")
		ldc_tot_imp_lire_calc=ids_iva.GetItemDecimal(ll_count,"c_imponibile_spesa_lire")
		ids_iva.SetItem(ll_count,"val_tot_iva_v", ldc_tot_iva_val_calc)
		ids_iva.SetItem(ll_count,"val_tot_imp_v", ldc_tot_imp_val_calc)
		ids_iva.SetItem(ll_count,"val_tot_iva_l", ldc_tot_iva_lire_calc)
		ids_iva.SetItem(ll_count,"val_tot_imp_l", ldc_tot_imp_lire_calc)			
	NEXT
end if

RETURN 0

end function

on w_var_dati_doc_cx.create
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

on w_var_dati_doc_cx.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_crea)
destroy(this.tab_distinta)
end on

event open;call super::open;
long 	 ll_CurrRow, ll_id_esercizio, ll_id_dis_banca
string ls_sort

idw_modifica=tab_distinta.tab_modifiche.dw_modifiche_ff

ids_cpt=tab_distinta.tab_seleziona.dw_cpt_wrk



ib_removing = FALSE

idw_source = tab_distinta.tab_seleziona.dw_recuperati_lt
idw_target = tab_distinta.tab_seleziona.dw_selezionati_lt

idw_source.SetTransObject(SQLCA)

tab_distinta.tab_seleziona.dw_var_dati_artrec_ff.SetTransObject(SQLCA)

ll_CurrRow = tab_distinta.tab_filtri.dw_filtro_ff.GetRow()
IF ll_CurrRow = 0 THEN tab_distinta.tab_filtri.dw_filtro_ff.InsertRow(0)

ll_CurrRow = tab_distinta.tab_modifiche.dw_modifiche_ff.GetRow()
IF ll_CurrRow = 0 THEN ll_CurrRow = tab_distinta.tab_modifiche.dw_modifiche_ff.InsertRow(0)

tab_distinta.tab_filtri.dw_filtro_ff.postevent("ue_post_open")
idw_target.postevent("ue_post_open")

tab_distinta.tab_filtri.dw_filtro_ff.SetFocus()
end event

type cb_chiudi from commandbutton within w_var_dati_doc_cx
int X=2798
int Y=28
int Width=270
int Height=88
int TabOrder=20
string Text="Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_crea from commandbutton within w_var_dati_doc_cx
int X=3122
int Y=28
int Width=270
int Height=88
int TabOrder=10
string Text="&Varia"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long i,ll_row
ll_row=idw_target.rowcount()

string ls_stampato,ls_contab,ls_evaso,appoggio,flag,ls_chius,ls_sospeso,ls_bloccato
Integer	ll_ret

ls_stampato=idw_modifica.getitemstring(1,"stampato")
ls_contab=idw_modifica.getitemstring(1,"contab")
ls_evaso=idw_modifica.getitemstring(1,"evaso_tot")
ls_chius=idw_modifica.getitemstring(1,"chius_forz")
ls_sospeso=idw_modifica.getitemstring(1,"sospeso")
ls_bloccato=idw_modifica.getitemstring(1,"bloccato")

ll_ret = MessageBox("Variazione dati Articolo", "Confermi la variazione degli Articoli selezionati ?", Question!, YesNo!, 2)
If ll_ret = 1 Then

	idw_target.resetupdate()
	
	FOR i=1 TO ll_row
		flag=idw_modifica.getitemstring(1,"f_stamp")
		if flag='S'then
			idw_target.setitem(i,"documento_stampato",ls_stampato)
			idw_target.setitemstatus(i,"documento_stampato",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_cont")
		if flag='S'then
			idw_target.setitem(i,"documento_contabilizzato",ls_contab)
			idw_target.setitemstatus(i,"documento_contabilizzato",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_evaso")
		if flag='S'then
			idw_target.setitem(i,"documento_evaso_totalmente",ls_evaso)
			idw_target.setitemstatus(i,"documento_evaso_totalmente",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_chius")
		if flag='S'then
			idw_target.setitem(i,"documento_chius_forzata",ls_chius)
			idw_target.setitemstatus(i,"documento_chius_forzata",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_sosp")
		if flag='S'then
			idw_target.setitem(i,"documento_sospeso",ls_sospeso)
			idw_target.setitemstatus(i,"documento_sospeso",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_bloc")
		if flag='S'then
			idw_target.setitem(i,"documento_bloccato",ls_bloccato)
			idw_target.setitemstatus(i,"documento_bloccato",primary!,datamodified!)
		end if
		
	NEXT
	idw_target.settransobject(sqlca)
	idw_target.update()
	
	
	long ll_id_documento, ll_id_sog_commerciale, cont
	long ll_nr_row, ll_count, ll_id_registro
	long ll_id_val_euro, ll_id_val_conto, ll_id_esercizio
	decimal ld_parita_euro, ld_cambio_appoggio
	integer ll_arrotondamento, ll_arrotondamento_conto
	string ls_tipo_arrotondamento, ls_simbolo_valuta,ls_tipo_arrotondamento_conto	
	
	flag=idw_modifica.getitemstring(1,"ric_cast")
	if flag='S'then

		SELECT	"par_sistema"."id_conto_predefinito",
				"par_sistema"."id_tab_iva_art_15"
		INTO	:il_az_idcontoprd, :il_az_idivaart15
		FROM	"dba"."par_sistema"  
		WHERE	"par_sistema"."id_azienda" = 1;		
		
		
		ids_riga = create u_ds_main
		ids_riga.dataobject = "d_ricalcola_cpt"
		ids_riga.setTransObject(SQLCA)
		
		ids_spese = create u_ds_main
		ids_spese.dataobject = "d_ricalcola_spese_cpt"
		ids_spese.SetTransObject(SQLCA)
		
		ids_iva = create u_ds_main
		ids_iva.dataobject = "d_cast_iva_documento_lt"
		ids_iva.setTransObject(SQLCA)
		
		ids_cpt.settransobject(sqlca)
		
		FOR i=1 TO ll_row
			il_rowtesta = i
			ll_id_documento          = idw_target.getitemnumber(i,"id_documento")
			ll_id_registro           = idw_target.getitemnumber(i,"id_registro")
			il_rt_id_tab_iva_acconto = idw_target.getitemnumber(i,"id_tab_iva_acconto")
			id_tot_acconto           = idw_target.getitemnumber(i,"imp_acconto")
			idc_td_cambio            = idw_target.getitemdecimal(i,"cambio")
			ll_id_sog_commerciale    = idw_target.getitemnumber(i,"id_sog_commerciale")
			il_id_valuta             = idw_target.getitemnumber(i,"id_valuta")
			
			select id_conto
			into :il_sc_idconto
			from sog_commerciale
			where id_sog_commerciale = :ll_id_sog_commerciale;
			
			select	"registro"."tipo_registro", "registro"."id_esercizio"
			into	:is_td_tiporeg, :il_id_esercizio
			from	"dba"."registro"  
			where	"registro"."id_registro" = :ll_id_registro
			using	SQLCA;
			
			ids_cpt.reset()
			ll_nr_row = ids_cpt.retrieve(ll_id_documento)	
			for ll_count =  1 to ll_nr_row 
				ids_cpt.DeleteRow(ll_nr_row - ll_count + 1)
			next				
			ids_cpt.update()
			ids_iva.reset()
			ids_riga.reset()			
			ids_riga.retrieve(ll_id_documento)
			ids_spese.retrieve(ll_id_documento)			
			ids_iva.retrieve(ll_id_documento)		
			
			SELECT "valuta"."cambio",   
					 "valuta"."cifra_arrotondamento" ,
					 "valuta"."tipo_arrotondamento",
					 "valuta"."simbolo",
					 "valuta"."parita_euro"
				INTO :ld_cambio_appoggio,   
					:ll_arrotondamento,
					:ls_tipo_arrotondamento ,
					:ls_simbolo_valuta,
					:ld_parita_euro
				FROM "dba"."valuta"  
				WHERE "valuta"."id_valuta" = :il_id_valuta   ;
			
			select id_val_euro
			into :ll_id_val_euro
			from par_sistema;
			
			select id_valuta
			into :ll_id_val_conto
			from esercizio
			where id_esercizio = :il_id_esercizio;
			
			if ll_id_val_conto = ll_id_val_euro then ld_cambio_appoggio = ld_parita_euro 			
			
			SELECT "valuta"."cifra_arrotondamento" ,
					 "valuta"."tipo_arrotondamento"
				INTO:ll_arrotondamento_conto,
					:ls_tipo_arrotondamento_conto 
				FROM "dba"."valuta"  
				WHERE "valuta"."id_valuta" = :ll_id_val_conto   ;			
			
			ids_iva.Modify("c_cambio_text.text = '" + String(ld_cambio_appoggio) + "'") 
			ids_iva.Modify("c_arrotondamento_text.text = '" + String(ll_arrotondamento) + "'")
			ids_iva.Modify("c_tipo_arrotondamento.text = '" + ls_tipo_arrotondamento + "'")			
			ids_iva.Modify("c_arrotondamento_text_v_conto.text = '" + String(ll_arrotondamento_conto) + "'")
			
			wf_calc_cpt()
			for cont=1 to ids_cpt.rowcount()
				ids_cpt.setitem(cont,"id_documento",ll_id_documento)
			next
			
			ids_cpt.update()
		next
	end if
	
	
End If


end event

type tab_distinta from tab within w_var_dati_doc_cx
event create ( )
event destroy ( )
int X=32
int Y=124
int Width=3378
int Height=1480
int TabOrder=30
boolean RaggedRight=true
Alignment Alignment=Center!
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tab_filtri tab_filtri
tab_modifiche tab_modifiche
tab_seleziona tab_seleziona
end type

on tab_distinta.create
this.tab_filtri=create tab_filtri
this.tab_modifiche=create tab_modifiche
this.tab_seleziona=create tab_seleziona
this.Control[]={this.tab_filtri,&
this.tab_modifiche,&
this.tab_seleziona}
end on

on tab_distinta.destroy
destroy(this.tab_filtri)
destroy(this.tab_modifiche)
destroy(this.tab_seleziona)
end on

event selectionchanged;
if newindex=3 then
	long ll_Rows, ll_i, ll_CurrRow


ll_Rows = idw_target.RowCount()

ib_removing = TRUE
idw_target.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	idw_target.rowsmove(ll_i,ll_i,primary!,idw_source,1,primary!)
NEXT


ib_removing = FALSE
String ls_da_prof, ls_a_prof, ls_filtro

ls_da_prof = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "prof_doc_cod_ini")
ls_a_prof  = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "prof_doc_cod_fin")

If IsNull(ls_da_prof) OR ls_da_prof = "" then
	SELECT MIN(codice)
	INTO	 :ls_da_prof
	FROM	 prof_documento
	;
End If
If IsNull(ls_a_prof) OR ls_a_prof = "" then
	SELECT MAX(codice)
	INTO	 :ls_a_prof
	FROM	 prof_documento
	;
End If

Time lt_inizio_retrieve, lt_fine_retrieve

lt_inizio_retrieve = Now()

date ld_da_data,ld_a_data 
Integer  ret

Tab_distinta.tab_filtri.dw_filtro_ff.AcceptText()
ld_da_data=Tab_distinta.tab_filtri.dw_filtro_ff.getitemdate(1,"data_doc_ini")
ld_a_data=Tab_distinta.tab_filtri.dw_filtro_ff.getitemdate(1,"data_doc_fin")
	
If ls_da_prof>ls_a_prof then
	Messagebox("Filtra","Il profilo iniziale è maggiore di quello finale!",exclamation!)
	Return
End If

If ld_da_data>ld_a_data then
	messagebox("Filtra","La data documento iniziale è maggiore di quella finale!",exclamation!)
	Return
End if



is_filter = ls_filtro
long ll_totrows
ll_totrows = idw_source.retrieve(ld_da_data, ld_a_data, ls_da_prof, ls_a_prof)
idw_source.setfocus()
tab_distinta.tab_seleziona.dw_var_dati_artrec_ff.Retrieve(ld_da_data, ld_a_data, ls_da_prof, ls_a_prof)
tab_distinta.tab_seleziona.st_4.text=string(0)
lt_fine_retrieve = Now()
end if

end event

type tab_filtri from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3342
int Height=1360
long BackColor=79741120
string Text="Filtra"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
dw_filtro_ff dw_filtro_ff
st_5 st_5
end type

on tab_filtri.create
this.dw_filtro_ff=create dw_filtro_ff
this.st_5=create st_5
this.Control[]={this.dw_filtro_ff,&
this.st_5}
end on

on tab_filtri.destroy
destroy(this.dw_filtro_ff)
destroy(this.st_5)
end on

type dw_filtro_ff from u_dw_ext_main within tab_filtri
event itemchanged pbm_dwnitemchange
event ue_init ( )
event ue_setup_filter ( )
int X=9
int Y=120
int Width=3323
int Height=1228
int TabOrder=2
string DataObject="d_var_dati_documento_ff"
end type

event itemchanged;
integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
long ll_null
SETNULL(LL_NULL)

choose case dwo.name
case "prof_doc_cod_ini"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "prof_doc_cod_ini"
		ls_dwc[2] = "prof_doc_des_ini"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "prof_doc_cod_fin")) or This.GetItemString(1, "prof_doc_cod_fin")='' then 
		     this.setitem(1,"prof_doc_cod_fin",data)
           this.setitem(1,"prof_doc_des_fin",This.GetItemString(1, "prof_doc_des_ini"))
	      end if  	
			RETURN 2
		END IF
		
	case "prof_doc_des_ini"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "prof_doc_cod_ini"
		ls_dwc[2] = "prof_doc_des_ini"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)		

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "prof_doc_cod_fin")) or This.GetItemString(1, "prof_doc_cod_fin")='' then 
		    this.setitem(1,"prof_doc_cod_fin",data)
          this.setitem(1,"prof_doc_des_fin",This.GetItemString(1, "prof_doc_des_ini"))
	      end if  
			RETURN 2
		END IF
		
	case "prof_doc_cod_fin"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "prof_doc_cod_fin"
		ls_dwc[2] = "prof_doc_des_fin"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "prof_doc_des_fin"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "prof_doc_cod_fin"
		ls_dwc[2] = "prof_doc_des_fin"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose


end event

event ue_init;call super::ue_init;is_colonne_drop[1]  = "id_tipo_pagamento_cod"
is_colonne_drop[2]  = "id_tipo_pagamento_des"
is_colonne_drop[3]  = "id_banca_azienda"
is_colonne_drop[4]  = "id_banca_azienda_pres"
end event

event ue_set_search;
choose case as_nomecol
	case "prof_doc_cod_ini"
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"
	case "prof_doc_des_ini" 
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"
	case "prof_doc_cod_fin"
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"	
	case "prof_doc_des_fin" 
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"
end choose
end event

event ue_use_search;
choose case as_nomecol
		case "prof_doc_cod_ini"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_doc_des_ini",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "prof_doc_cod_fin")) or This.GetItemString(1, "prof_doc_cod_fin")='' then 
		  uf_set_colval("prof_doc_cod_fin",is_ricpar.s_main_value)
        uf_set_colval("prof_doc_des_fin",is_ricpar.s_ausil_value[1])
	   end if  	
		
	case "prof_doc_des_ini"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_doc_cod_ini",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "prof_doc_cod_fin")) or This.GetItemString(1, "prof_doc_cod_fin")='' then 
		  uf_set_colval("prof_doc_des_fin",is_ricpar.s_main_value)
        uf_set_colval("prof_doc_cod_fin",is_ricpar.s_ausil_value[1])
	   end if  	 	
		
	case "prof_doc_cod_fin"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_doc_des_fin",is_ricpar.s_ausil_value[1])
		
	case "prof_doc_des_fin"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_doc_cod_fin",is_ricpar.s_ausil_value[1])
end choose
end event

event ue_key;
DataWindowChild	ldw_drop
PowerObject			lpo_object
string				ls_column, ls_style, ls_colval
window				lw_win
w_wiz_main			lw_main
w_search_main		lw_sm

choose case key
	case keydelete!		
		ls_column = getColumnName()
		ls_style = this.describe(ls_column+".edit.style")
		if ls_style = "ddlb" then
			uf_set_colval(ls_column,u_freddie.gs_null)
		end if
		
	case KeyF5!
		if keyflags = 0 then
			ls_column = getColumnName()
			uf_reply_retrieve_dddw(ls_column)
			
		end if	
		
	case KeyF4!
		
		
		ib_during_f4 = true
		if keyflags = 0 then
			
			ls_colval = gettext()
			is_ricpar = is_e_ricpar
			ls_column = getColumnName()
			is_ricpar.b_imm_retrieve = false
			is_ricpar.s_caller_column = ls_column
			is_ricpar.s_sql_cond = ""
			is_search_window = ""
			trigger event ue_set_search (ls_column,ls_colval)
			if (is_search_window) <> "" then			
				
				OpenWithParm (lw_sm,is_ricpar,is_search_window)

				
				
				
				is_ricpar = Message.PowerObjectParm
				IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
					trigger event ue_use_search (ls_column)
				end if
				
			end if
		else
		end if	
		ib_during_f4 = false
		
	case KeyF12!
		if (keyflags=3) then
			lw_win = this.uf_w_set_focus()
			lw_win.trigger event key (keyF12!,3)
		end if
		
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
	      ShowHelp(u_freddie.is_helpfile, Topic!,long(this.object.DataWindow.Help.TypeID.Retrieve.Argument) )
		end if	
	
end choose

end event

type st_5 from statictext within tab_filtri
int X=9
int Y=56
int Width=462
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Filtro Documenti"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tab_modifiche from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3342
int Height=1360
long BackColor=79741120
string Text="Modifica"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_modifiche_ff dw_modifiche_ff
st_6 st_6
end type

on tab_modifiche.create
this.dw_modifiche_ff=create dw_modifiche_ff
this.st_6=create st_6
this.Control[]={this.dw_modifiche_ff,&
this.st_6}
end on

on tab_modifiche.destroy
destroy(this.dw_modifiche_ff)
destroy(this.st_6)
end on

type dw_modifiche_ff from u_dw_ext_main within tab_modifiche
int X=9
int Y=120
int Width=3323
int Height=1228
int TabOrder=2
string DataObject="d_var_dati_documento_ext"
boolean HScrollBar=true
end type

event ue_set_search;
end event

event ue_use_search;string ls_val





	

end event

event itemchanged;
string ls_val
this.accepttext()

if dwo.name="stampato" then
	ls_val=this.getitemstring(1,"stampato")
	if not isnull(ls_val) then
		this.setitem(1,"f_stamp",'S')
	else
		this.setitem(1,"f_stamp",'N')
	end if
end if
if dwo.name="contab" then
	ls_val=this.getitemstring(1,"contab")
	if not isnull(ls_val) then
		this.setitem(1,"f_cont",'S')
	else
		this.setitem(1,"f_cont",'N')
	end if
end if

if dwo.name="evaso_tot" then
	ls_val=this.getitemstring(1,"evaso_tot")
	if not isnull(ls_val) then
		this.setitem(1,"f_evaso",'S')
	else
		this.setitem(1,"f_evaso",'N')
	end if
end if

if dwo.name="chius_forz" then
	ls_val=this.getitemstring(1,"chius_forz")
	if not isnull(ls_val) then
		this.setitem(1,"f_chius",'S')
	else
		this.setitem(1,"f_chius",'N')
	end if
end if

if dwo.name="sospeso" then
	ls_val=this.getitemstring(1,"sospeso")
	if not isnull(ls_val) then
		this.setitem(1,"f_sosp",'S')
	else
		this.setitem(1,"f_sosp",'N')
	end if
end if

if dwo.name="bloccato" then
	ls_val=this.getitemstring(1,"bloccato")
	if not isnull(ls_val) then
		this.setitem(1,"f_bloc",'S')
	else
		this.setitem(1,"f_bloc",'N')
	end if
end if
end event

type st_6 from statictext within tab_modifiche
int X=5
int Y=56
int Width=631
int Height=64
boolean Enabled=false
boolean BringToTop=true
string Text="Modifiche da apportare"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tab_seleziona from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3342
int Height=1360
long BackColor=79741120
string Text="Documenti da variare"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_recuperati_lt dw_recuperati_lt
st_4 st_4
dw_selezionati_lt dw_selezionati_lt
st_3 st_3
dw_var_dati_artrec_ff dw_var_dati_artrec_ff
st_1 st_1
st_2 st_2
dw_cpt_wrk dw_cpt_wrk
end type

on tab_seleziona.create
this.cb_drop_all=create cb_drop_all
this.cb_drop_many=create cb_drop_many
this.cb_remove_many=create cb_remove_many
this.cb_remove_all=create cb_remove_all
this.dw_recuperati_lt=create dw_recuperati_lt
this.st_4=create st_4
this.dw_selezionati_lt=create dw_selezionati_lt
this.st_3=create st_3
this.dw_var_dati_artrec_ff=create dw_var_dati_artrec_ff
this.st_1=create st_1
this.st_2=create st_2
this.dw_cpt_wrk=create dw_cpt_wrk
this.Control[]={this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_recuperati_lt,&
this.st_4,&
this.dw_selezionati_lt,&
this.st_3,&
this.dw_var_dati_artrec_ff,&
this.st_1,&
this.st_2,&
this.dw_cpt_wrk}
end on

on tab_seleziona.destroy
destroy(this.cb_drop_all)
destroy(this.cb_drop_many)
destroy(this.cb_remove_many)
destroy(this.cb_remove_all)
destroy(this.dw_recuperati_lt)
destroy(this.st_4)
destroy(this.dw_selezionati_lt)
destroy(this.st_3)
destroy(this.dw_var_dati_artrec_ff)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_cpt_wrk)
end on

type cb_drop_all from commandbutton within tab_seleziona
int X=1541
int Y=300
int Width=247
int Height=92
int TabOrder=14
string Text=">>"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_Rows, ll_i, ll_CurrRow,contatore
decimal ldc_tot_scadenza_importo

ll_Rows = tab_distinta.tab_seleziona.dw_var_dati_artrec_ff.GetItemNumber(1, "num_record")

ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
		idw_source.ScrollToRow (ll_i) 		
		idw_source.rowsmove(ll_i,ll_i,primary!,idw_target,1,primary!)
		contatore=contatore+1
		idw_target.selectrow(contatore,true)
NEXT

idw_target.Sort()

st_4.text=string(ll_Rows)

ib_removing = FALSE

dw_selezionati_lt.setfocus()

end event

type cb_drop_many from commandbutton within tab_seleziona
int X=1541
int Y=424
int Width=247
int Height=92
int TabOrder=13
string Text=">"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long    ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo
long    contatore, ll_contatore

ll_Rows = idw_source.RowCount()

ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_source.IsSelected(ll_i) THEN
		contatore=contatore+1

		idw_source.rowsmove(ll_i,ll_i,primary!,idw_target,1,primary!)
		idw_target.selectrow(contatore,true)
		
	END IF
NEXT

ll_contatore = Integer(st_4.text)
contatore = contatore + ll_contatore
st_4.text=string(contatore)

idw_target.Sort()

ib_removing = FALSE

dw_selezionati_lt.setfocus()
end event

type cb_remove_many from commandbutton within tab_seleziona
int X=1541
int Y=640
int Width=247
int Height=92
int TabOrder=12
string Text="<"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo

ll_Rows = idw_target.RowCount()

ib_removing = TRUE
idw_target.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_target.IsSelected(ll_i) THEN
		

		idw_target.rowsmove(ll_i,ll_i,primary!,idw_source,1,primary!)
		
		
		
	END IF
NEXT

idw_source.Sort()

ib_removing = FALSE
long contatore
contatore=dw_selezionati_lt.rowcount()
	

st_4.text=string(contatore)
end event

type cb_remove_all from commandbutton within tab_seleziona
int X=1541
int Y=764
int Width=247
int Height=92
int TabOrder=11
string Text="<<"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long ll_Rows, ll_i, ll_CurrRow


ll_Rows = idw_target.RowCount()

ib_removing = TRUE
idw_target.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
			idw_target.rowsmove(ll_i,ll_i,primary!,idw_source,1,primary!)
			
NEXT

idw_source.Sort()

ib_removing = FALSE
long i,contatore
contatore=dw_selezionati_lt.rowcount()
	

st_4.text=string(contatore)
end event

type dw_recuperati_lt from u_dw_pura within tab_seleziona
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
int X=55
int Y=116
int Width=1449
int Height=1000
string DataObject="d_var_documento_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event clicked;wf_selezione(row,this,"",this,"","")
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

event sqlpreview;


end event

type st_4 from statictext within tab_seleziona
int X=2240
int Y=1192
int Width=247
int Height=76
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
string Text="0"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_selezionati_lt from u_dw_pura within tab_seleziona
int X=1842
int Y=116
int Width=1449
int Height=1000
int TabOrder=2
string DataObject="d_var_documento_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event clicked;wf_selezione(row,this,"",this,"","") 

end event

type st_3 from statictext within tab_seleziona
int X=2501
int Y=1192
int Width=539
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Documenti da variare"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_var_dati_artrec_ff from u_dw_pura within tab_seleziona
int X=242
int Y=1192
int Width=1070
int Height=104
int TabOrder=2
boolean BringToTop=true
string DataObject="d_var_dati_docrec_ff"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event sqlpreview;call super::sqlpreview;
If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + 'AND ' + is_filter
	This.SetSQLPreview(ls_SQLSyntax)
End If


end event

type st_1 from statictext within tab_seleziona
int X=59
int Y=48
int Width=256
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Ricercati"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within tab_seleziona
int X=1847
int Y=48
int Width=297
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Selezionati"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-9
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_cpt_wrk from datawindow within tab_seleziona
int X=585
int Y=552
int Width=2734
int Height=748
int TabOrder=21
boolean Visible=false
boolean BringToTop=true
string DataObject="d_contr_documento_lt"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

