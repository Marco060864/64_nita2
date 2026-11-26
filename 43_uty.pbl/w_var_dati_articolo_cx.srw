forward
global type w_var_dati_articolo_cx from w_wiz_main
end type
type cb_chiudi from commandbutton within w_var_dati_articolo_cx
end type
type cb_crea from commandbutton within w_var_dati_articolo_cx
end type
type tab_distinta from tab within w_var_dati_articolo_cx
end type
type tab_filtri from userobject within tab_distinta
end type
type dw_filtro_ff from u_dw_ext_main within tab_filtri
end type
type tab_modifiche from userobject within tab_distinta
end type
type dw_modifiche_ff from u_dw_ext_main within tab_modifiche
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
type dw_1 from datawindow within tab_seleziona
end type
type dw_2 from datawindow within tab_seleziona
end type
type cb_1 from commandbutton within w_var_dati_articolo_cx
end type
type tv_1 from u_tv_distinta within w_var_dati_articolo_cx
end type
type cb_2 from commandbutton within w_var_dati_articolo_cx
end type
type tab_filtri from userobject within tab_distinta
dw_filtro_ff dw_filtro_ff
end type
type tab_modifiche from userobject within tab_distinta
dw_modifiche_ff dw_modifiche_ff
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
dw_1 dw_1
dw_2 dw_2
end type
type tab_distinta from tab within w_var_dati_articolo_cx
tab_filtri tab_filtri
tab_modifiche tab_modifiche
tab_seleziona tab_seleziona
end type
end forward

global type w_var_dati_articolo_cx from w_wiz_main
int X=434
int Y=348
int Width=3474
int Height=1740
WindowType WindowType=response!
boolean TitleBar=true
string Title="Variazione dati Articolo"
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_chiudi cb_chiudi
cb_crea cb_crea
tab_distinta tab_distinta
cb_1 cb_1
tv_1 tv_1
cb_2 cb_2
end type
global w_var_dati_articolo_cx w_var_dati_articolo_cx

type variables
DataWindow idw_source, idw_target,idw_modifica
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
public function decimal uf_getitemdecimal (datawindow adw_dwobj, long al_row, string as_column)
public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg)
public subroutine wf_fabbisogno (long disponibilita)
public subroutine wf_euro_fab (long disponibilita)
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

public subroutine wf_fabbisogno (long disponibilita);
string ls_conto_visione
decimal ld_esistenza,ld_carico,ld_scarico,ld_ordinato_fo,ld_impegnato_cl,ld_disponibilita
long ll_righe,i,ll_art
string ls_car_fiscali,ls_sca_fiscali,ls_ord_clienti,ls_ord_fornitori,ls_vis_clienti
string ls_vis_fornitori,ls_cl_clienti,ls_cl_fornitori,ls_imp_produzione,ls_ord_produzione
string ls_gr_lib_1,ls_gr_lib_2,ls_gr_lib_3,ls_gr_lib_4
decimal ls_car_fiscali_a,ls_sca_fiscali_a,ls_ord_clienti_a,ls_ord_fornitori_a,ls_vis_clienti_a
decimal ls_vis_fornitori_a,ls_cl_clienti_a,ls_cl_fornitori_a,ls_imp_produzione_a
decimal ls_ord_produzione_a,ls_gr_lib_1_a,ls_gr_lib_2_a,ls_gr_lib_3_a,ls_gr_lib_4_a
ll_righe=tab_distinta.tab_seleziona.dw_1.rowcount()
select conto_vis_scarico
into :ls_conto_visione
from par_sistema;
for i=1 to ll_righe
	ll_art=tab_distinta.tab_seleziona.dw_1.getitemnumber(i,"id_articolo")
	
	if ls_conto_visione='S' then
		select sum(qta_caricata)-sum(qta_scaricata),sum(qta_caricata),sum(qta_scaricata),&
				 
				 sum(qta_ord_fornitori),sum(qta_imp_produzione)
		into :ld_esistenza,:ld_carico,:ld_carico,:ld_ordinato_fo,:ld_impegnato_cl
		from riepilogo
		where id_articolo=:ll_art;
	else
		select sum(qta_caricata)-sum(qta_scaricata)+sum(qta_vis_fornitori)-sum(qta_vis_clienti),&
				 
				 sum(qta_caricata),sum(qta_scaricata),sum(qta_ord_fornitori),sum(qta_imp_produzione)
		into :ld_esistenza,:ld_carico,:ld_scarico,:ld_ordinato_fo,:ld_impegnato_cl
		from riepilogo
		where id_articolo=:ll_art;
	end if
	if isnull(ld_esistenza) then ld_esistenza=0
	tab_distinta.tab_seleziona.dw_1.setitem(i,"esistenza",ld_esistenza)

	if isnull(ld_carico) then ld_carico=0
	tab_distinta.tab_seleziona.dw_1.setitem(i,"carico",ld_carico)
	if isnull(ld_scarico) then ld_scarico=0
	tab_distinta.tab_seleziona.dw_1.setitem(i,"scarico",ld_scarico)
	if isnull(ld_ordinato_fo) then ld_ordinato_fo=0
	tab_distinta.tab_seleziona.dw_1.setitem(i,"ordinato_fo",ld_ordinato_fo)
	if isnull(ld_impegnato_cl) then ld_impegnato_cl=0
	tab_distinta.tab_seleziona.dw_1.setitem(i,"impegnato_cl",ld_impegnato_cl)	

	select car_fiscali,sca_fiscali,ord_clienti,ord_fornitori,vis_clienti,vis_fornitori,&
			 cl_clienti,cl_fornitori,imp_produzione,ord_produzione,gr_lib_1,gr_lib_2,gr_lib_3,&
			 gr_lib_4 
	into :ls_car_fiscali,:ls_sca_fiscali,:ls_ord_clienti,:ls_ord_fornitori,:ls_vis_clienti&
	 ,:ls_vis_fornitori,:ls_cl_clienti,:ls_cl_fornitori,:ls_imp_produzione,:ls_ord_produzione
	 ,:ls_gr_lib_1,:ls_gr_lib_2,:ls_gr_lib_3,:ls_gr_lib_4
	from par_disponibilita
	where id_par_disponibilita=:disponibilita;
	if sqlca.sqlcode=0 then
		if isnull(ls_car_fiscali) then ls_car_fiscali=""
		if isnull(ls_sca_fiscali) then ls_sca_fiscali=""
		if isnull(ls_vis_fornitori) then ls_vis_fornitori=""
		if isnull(ls_vis_clienti) then ls_vis_clienti=""
		if isnull(ls_ord_clienti) then ls_ord_clienti=""
		if isnull(ls_ord_fornitori) then ls_ord_fornitori=""
		if isnull(ls_cl_clienti) then ls_cl_clienti=""
		if isnull(ls_cl_fornitori) then ls_cl_fornitori=""
		if isnull(ls_imp_produzione) then ls_imp_produzione=""
		if isnull(ls_ord_produzione) then ls_ord_produzione=""
		if isnull(ls_gr_lib_1) then ls_gr_lib_1=""
		if isnull(ls_gr_lib_2) then ls_gr_lib_2=""
		if isnull(ls_gr_lib_3) then ls_gr_lib_3=""
		if isnull(ls_gr_lib_4) then ls_gr_lib_4=""
		select sum(qta_caricata),sum(qta_scaricata),sum(qta_ord_clienti),sum(qta_ord_fornitori),&
		sum(qta_vis_clienti),sum(qta_vis_fornitori),sum(qta_imp_produzione),&
		sum(qta_cl_clienti),sum(qta_cl_fornitori),sum(qta_ord_produzione),&
		sum(qta_gruppo_lib_1),sum(qta_gruppo_lib_2),sum(qta_gruppo_lib_3),sum(qta_gruppo_lib_4)
		into :ls_car_fiscali_a,:ls_sca_fiscali_a,:ls_ord_clienti_a,:ls_ord_fornitori_a,&
		:ls_vis_clienti_a,:ls_vis_fornitori_a,:ls_cl_clienti_a,:ls_cl_fornitori_a,&
		:ls_imp_produzione_a,:ls_ord_produzione_a,:ls_gr_lib_1_a,:ls_gr_lib_2_a,&
		:ls_gr_lib_3_a,:ls_gr_lib_4_a
		from riepilogo
		where id_articolo=:ll_art;
		if isnull(ls_car_fiscali_a) then ls_car_fiscali_a=0
		if isnull(ls_sca_fiscali_a) then ls_sca_fiscali_a=0
		if isnull(ls_vis_fornitori_a) then ls_vis_fornitori_a=0
		if isnull(ls_vis_clienti_a) then ls_vis_clienti_a=0
		if isnull(ls_ord_clienti_a) then ls_ord_clienti_a=0
		if isnull(ls_ord_fornitori_a) then ls_ord_fornitori_a=0
		if isnull(ls_cl_clienti_a) then ls_cl_clienti_a=0
		if isnull(ls_cl_fornitori_a) then ls_cl_fornitori_a=0
		if isnull(ls_imp_produzione_a) then ls_imp_produzione_a=0
		if isnull(ls_ord_produzione_a) then ls_ord_produzione_a=0
		if isnull(ls_gr_lib_1_a) then ls_gr_lib_1_a=0
		if isnull(ls_gr_lib_2_a) then ls_gr_lib_2_a=0
		if isnull(ls_gr_lib_3_a) then ls_gr_lib_3_a=0
		if isnull(ls_gr_lib_4_a) then ls_gr_lib_4_a=0

	  if ls_car_fiscali    <> '' then ls_car_fiscali    += string(ls_car_fiscali_a)	  
	  if ls_sca_fiscali    <> '' then ls_sca_fiscali    += string(ls_sca_fiscali_a) 	
	  if ls_vis_fornitori  <> '' then ls_vis_fornitori  += string(ls_vis_fornitori_a)
	  if ls_vis_clienti    <> '' then ls_vis_clienti    += string(ls_vis_clienti_a) 
	  if ls_ord_clienti    <> '' then ls_ord_clienti    += string(ls_ord_clienti_a)  
	  if ls_ord_fornitori  <> '' then ls_ord_fornitori  += string(ls_ord_fornitori_a)
	  if ls_cl_clienti     <> '' then ls_cl_clienti     += string(ls_cl_clienti_a)
	  if ls_cl_fornitori   <> '' then ls_cl_fornitori   += string(ls_cl_fornitori_a)
	  if ls_imp_produzione <> '' then ls_imp_produzione += string(ls_imp_produzione_a)
	  if ls_ord_produzione <> '' then ls_ord_produzione += string(ls_ord_produzione_a)
	  if ls_gr_lib_1       <> '' then ls_gr_lib_1 		 += string(ls_gr_lib_1_a)
	  if ls_gr_lib_2       <> '' then ls_gr_lib_2 		 += string(ls_gr_lib_2_a) 	
	  if ls_gr_lib_3       <> '' then ls_gr_lib_3 		 += string(ls_gr_lib_3_a)
	  if ls_gr_lib_4       <> '' then ls_gr_lib_4 		 += string(ls_gr_lib_4_a)
	
		  ld_disponibilita= dec(ls_car_fiscali)+dec(ls_sca_fiscali)+dec(ls_vis_fornitori)+&
				dec(ls_vis_clienti)+dec(ls_ord_clienti)+dec(ls_ord_fornitori)+&
				dec(ls_cl_clienti)+dec(ls_cl_fornitori)+dec(ls_imp_produzione)+&
				dec(ls_ord_produzione)+dec(ls_gr_lib_1)+dec(ls_gr_lib_2)+&
				dec(ls_gr_lib_3)+dec(ls_gr_lib_4)
		if isnull(ld_disponibilita) then ld_disponibilita=0
		tab_distinta.tab_seleziona.dw_1.setitem(i,"disponibilita",ld_disponibilita)	
	end if
	
next


end subroutine

public subroutine wf_euro_fab (long disponibilita);
string ls_conto_visione
decimal ld_esistenza,ld_carico,ld_scarico,ld_ordinato_fo,ld_impegnato_cl,ld_disponibilita
long ll_righe,i,ll_art
string ls_car_fiscali,ls_sca_fiscali,ls_ord_clienti,ls_ord_fornitori,ls_vis_clienti
string ls_vis_fornitori,ls_cl_clienti,ls_cl_fornitori,ls_imp_produzione,ls_ord_produzione
string ls_gr_lib_1,ls_gr_lib_2,ls_gr_lib_3,ls_gr_lib_4
decimal ls_car_fiscali_a,ls_sca_fiscali_a,ls_ord_clienti_a,ls_ord_fornitori_a,ls_vis_clienti_a
decimal ls_vis_fornitori_a,ls_cl_clienti_a,ls_cl_fornitori_a,ls_imp_produzione_a
decimal ls_ord_produzione_a,ls_gr_lib_1_a,ls_gr_lib_2_a,ls_gr_lib_3_a,ls_gr_lib_4_a
ll_righe=tab_distinta.tab_seleziona.dw_2.rowcount()
select conto_vis_scarico
into :ls_conto_visione
from par_sistema;
for i=1 to ll_righe
	ll_art=tab_distinta.tab_seleziona.dw_2.getitemnumber(i,"id_articolo")
	
	if ls_conto_visione='S' then
		select sum(qta_caricata)-sum(qta_scaricata),sum(qta_caricata),sum(qta_scaricata),&
				 
				 sum(qta_ord_fornitori),sum(qta_imp_produzione)
		into :ld_esistenza,:ld_carico,:ld_carico,:ld_ordinato_fo,:ld_impegnato_cl
		from riepilogo
		where id_articolo=:ll_art;
	else
		select sum(qta_caricata)-sum(qta_scaricata)+sum(qta_vis_fornitori)-sum(qta_vis_clienti),&
				 
				 sum(qta_caricata),sum(qta_scaricata),sum(qta_ord_fornitori),sum(qta_imp_produzione)
		into :ld_esistenza,:ld_carico,:ld_scarico,:ld_ordinato_fo,:ld_impegnato_cl
		from riepilogo
		where id_articolo=:ll_art;
	end if
	if isnull(ld_esistenza) then ld_esistenza=0
	tab_distinta.tab_seleziona.dw_2.setitem(i,"esistenza",ld_esistenza)

	if isnull(ld_carico) then ld_carico=0
	tab_distinta.tab_seleziona.dw_2.setitem(i,"carico",ld_carico)
	if isnull(ld_scarico) then ld_scarico=0
	tab_distinta.tab_seleziona.dw_2.setitem(i,"scarico",ld_scarico)
	if isnull(ld_ordinato_fo) then ld_ordinato_fo=0
	tab_distinta.tab_seleziona.dw_2.setitem(i,"ordinato_fo",ld_ordinato_fo)
	if isnull(ld_impegnato_cl) then ld_impegnato_cl=0
	tab_distinta.tab_seleziona.dw_2.setitem(i,"impegnato_cl",ld_impegnato_cl)	

	select car_fiscali,sca_fiscali,ord_clienti,ord_fornitori,vis_clienti,vis_fornitori,&
			 cl_clienti,cl_fornitori,imp_produzione,ord_produzione,gr_lib_1,gr_lib_2,gr_lib_3,&
			 gr_lib_4 
	into :ls_car_fiscali,:ls_sca_fiscali,:ls_ord_clienti,:ls_ord_fornitori,:ls_vis_clienti&
	 ,:ls_vis_fornitori,:ls_cl_clienti,:ls_cl_fornitori,:ls_imp_produzione,:ls_ord_produzione
	 ,:ls_gr_lib_1,:ls_gr_lib_2,:ls_gr_lib_3,:ls_gr_lib_4
	from par_disponibilita
	where id_par_disponibilita=:disponibilita;
	if sqlca.sqlcode=0 then
		if isnull(ls_car_fiscali) then ls_car_fiscali=""
		if isnull(ls_sca_fiscali) then ls_sca_fiscali=""
		if isnull(ls_vis_fornitori) then ls_vis_fornitori=""
		if isnull(ls_vis_clienti) then ls_vis_clienti=""
		if isnull(ls_ord_clienti) then ls_ord_clienti=""
		if isnull(ls_ord_fornitori) then ls_ord_fornitori=""
		if isnull(ls_cl_clienti) then ls_cl_clienti=""
		if isnull(ls_cl_fornitori) then ls_cl_fornitori=""
		if isnull(ls_imp_produzione) then ls_imp_produzione=""
		if isnull(ls_ord_produzione) then ls_ord_produzione=""
		if isnull(ls_gr_lib_1) then ls_gr_lib_1=""
		if isnull(ls_gr_lib_2) then ls_gr_lib_2=""
		if isnull(ls_gr_lib_3) then ls_gr_lib_3=""
		if isnull(ls_gr_lib_4) then ls_gr_lib_4=""
		select sum(qta_caricata),sum(qta_scaricata),sum(qta_ord_clienti),sum(qta_ord_fornitori),&
		sum(qta_vis_clienti),sum(qta_vis_fornitori),sum(qta_imp_produzione),&
		sum(qta_cl_clienti),sum(qta_cl_fornitori),sum(qta_ord_produzione),&
		sum(qta_gruppo_lib_1),sum(qta_gruppo_lib_2),sum(qta_gruppo_lib_3),sum(qta_gruppo_lib_4)
		into :ls_car_fiscali_a,:ls_sca_fiscali_a,:ls_ord_clienti_a,:ls_ord_fornitori_a,&
		:ls_vis_clienti_a,:ls_vis_fornitori_a,:ls_cl_clienti_a,:ls_cl_fornitori_a,&
		:ls_imp_produzione_a,:ls_ord_produzione_a,:ls_gr_lib_1_a,:ls_gr_lib_2_a,&
		:ls_gr_lib_3_a,:ls_gr_lib_4_a
		from riepilogo
		where id_articolo=:ll_art;
		if isnull(ls_car_fiscali_a) then ls_car_fiscali_a=0
		if isnull(ls_sca_fiscali_a) then ls_sca_fiscali_a=0
		if isnull(ls_vis_fornitori_a) then ls_vis_fornitori_a=0
		if isnull(ls_vis_clienti_a) then ls_vis_clienti_a=0
		if isnull(ls_ord_clienti_a) then ls_ord_clienti_a=0
		if isnull(ls_ord_fornitori_a) then ls_ord_fornitori_a=0
		if isnull(ls_cl_clienti_a) then ls_cl_clienti_a=0
		if isnull(ls_cl_fornitori_a) then ls_cl_fornitori_a=0
		if isnull(ls_imp_produzione_a) then ls_imp_produzione_a=0
		if isnull(ls_ord_produzione_a) then ls_ord_produzione_a=0
		if isnull(ls_gr_lib_1_a) then ls_gr_lib_1_a=0
		if isnull(ls_gr_lib_2_a) then ls_gr_lib_2_a=0
		if isnull(ls_gr_lib_3_a) then ls_gr_lib_3_a=0
		if isnull(ls_gr_lib_4_a) then ls_gr_lib_4_a=0

	  if ls_car_fiscali    <> '' then ls_car_fiscali    += string(ls_car_fiscali_a)	  
	  if ls_sca_fiscali    <> '' then ls_sca_fiscali    += string(ls_sca_fiscali_a) 	
	  if ls_vis_fornitori  <> '' then ls_vis_fornitori  += string(ls_vis_fornitori_a)
	  if ls_vis_clienti    <> '' then ls_vis_clienti    += string(ls_vis_clienti_a) 
	  if ls_ord_clienti    <> '' then ls_ord_clienti    += string(ls_ord_clienti_a)  
	  if ls_ord_fornitori  <> '' then ls_ord_fornitori  += string(ls_ord_fornitori_a)
	  if ls_cl_clienti     <> '' then ls_cl_clienti     += string(ls_cl_clienti_a)
	  if ls_cl_fornitori   <> '' then ls_cl_fornitori   += string(ls_cl_fornitori_a)
	  if ls_imp_produzione <> '' then ls_imp_produzione += string(ls_imp_produzione_a)
	  if ls_ord_produzione <> '' then ls_ord_produzione += string(ls_ord_produzione_a)
	  if ls_gr_lib_1       <> '' then ls_gr_lib_1 		 += string(ls_gr_lib_1_a)
	  if ls_gr_lib_2       <> '' then ls_gr_lib_2 		 += string(ls_gr_lib_2_a) 	
	  if ls_gr_lib_3       <> '' then ls_gr_lib_3 		 += string(ls_gr_lib_3_a)
	  if ls_gr_lib_4       <> '' then ls_gr_lib_4 		 += string(ls_gr_lib_4_a)
	
		  ld_disponibilita= dec(ls_car_fiscali)+dec(ls_sca_fiscali)+dec(ls_vis_fornitori)+&
				dec(ls_vis_clienti)+dec(ls_ord_clienti)+dec(ls_ord_fornitori)+&
				dec(ls_cl_clienti)+dec(ls_cl_fornitori)+dec(ls_imp_produzione)+&
				dec(ls_ord_produzione)+dec(ls_gr_lib_1)+dec(ls_gr_lib_2)+&
				dec(ls_gr_lib_3)+dec(ls_gr_lib_4)
		if isnull(ld_disponibilita) then ld_disponibilita=0
		tab_distinta.tab_seleziona.dw_2.setitem(i,"disponibilita",ld_disponibilita)	
	end if
	
next


end subroutine

on w_var_dati_articolo_cx.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_crea=create cb_crea
this.tab_distinta=create tab_distinta
this.cb_1=create cb_1
this.tv_1=create tv_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_crea
this.Control[iCurrent+3]=this.tab_distinta
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.tv_1
this.Control[iCurrent+6]=this.cb_2
end on

on w_var_dati_articolo_cx.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_crea)
destroy(this.tab_distinta)
destroy(this.cb_1)
destroy(this.tv_1)
destroy(this.cb_2)
end on

event open;call super::open;

long 	 ll_CurrRow, ll_id_esercizio, ll_id_dis_banca
string ls_sort

DataWindowChild dwc_drop,ldw_da_cat_merc_cod, ldw_a_cat_merc_cod
Datawindowchild ldw_da_cat_comm_cod, ldw_a_cat_comm_cod
Datawindowchild ldw_da_cat_fisc_cod, ldw_a_cat_fisc_cod
Datawindowchild ldw_da_tab_iva_cod, ldw_a_tab_iva_cod

datawindowchild ldw_gruppo_art_cod, ldw_cat_comm_cod
datawindowchild ldw_cat_merc_cod, ldw_cat_fisc_cod
datawindowchild ldw_reparto, ldw_tab_iva_cod
datawindowchild ldw_unita_conf_cod

datawindowchild ldw_da_unita_conf_cod, ldw_da_unita_conf_des, ldw_a_unita_conf_cod, ldw_a_unita_conf_des

idw_modifica=tab_distinta.tab_modifiche.dw_modifiche_ff

idw_modifica.getchild("gruppo_art_cod",ldw_gruppo_art_cod)
idw_modifica.getchild("cat_comm_articolo",ldw_cat_comm_cod)
idw_modifica.getchild("cat_merceologica",ldw_cat_merc_cod)
idw_modifica.getchild("cat_fiscale",ldw_cat_fisc_cod)
idw_modifica.getchild("reparto",ldw_reparto)
idw_modifica.getchild("tab_iva",ldw_tab_iva_cod)
idw_modifica.getchild("unita_conf",ldw_unita_conf_cod)
idw_modifica.getchild("unita_confezione",ldw_a_unita_conf_cod)

ldw_gruppo_art_cod.settransobject(sqlca)
ldw_gruppo_art_cod.retrieve()

ldw_cat_comm_cod.settransobject(sqlca)
ldw_cat_comm_cod.retrieve()

ldw_cat_merc_cod.settransobject(sqlca)
ldw_cat_merc_cod.retrieve()

ldw_cat_fisc_cod.settransobject(sqlca)
ldw_cat_fisc_cod.retrieve()

ldw_reparto.settransobject(sqlca)
ldw_reparto.retrieve()

ldw_tab_iva_cod.settransobject(sqlca)
ldw_tab_iva_cod.retrieve()

ldw_unita_conf_cod.settransobject(sqlca)
ldw_unita_conf_cod.retrieve()

ldw_a_unita_conf_cod.settransobject(sqlca)
ldw_a_unita_conf_cod.retrieve()

ldw_a_unita_conf_des.settransobject(sqlca)
ldw_a_unita_conf_des.retrieve()

tab_distinta.tab_filtri.dw_filtro_ff.GetChild("da_cat_merceologica",ldw_da_cat_merc_cod )
tab_distinta.tab_filtri.dw_filtro_ff.GetChild("a_cat_merceologica",ldw_a_cat_merc_cod )
tab_distinta.tab_filtri.dw_filtro_ff.GetChild("da_cat_commerciale",ldw_da_cat_comm_cod )
tab_distinta.tab_filtri.dw_filtro_ff.GetChild("a_cat_commerciale",ldw_a_cat_comm_cod )
tab_distinta.tab_filtri.dw_filtro_ff.GetChild("da_cat_fiscale",ldw_da_cat_fisc_cod )
tab_distinta.tab_filtri.dw_filtro_ff.GetChild("a_cat_fiscale",ldw_a_cat_fisc_cod )
tab_distinta.tab_filtri.dw_filtro_ff.GetChild("da_tab_iva",ldw_da_tab_iva_cod )
tab_distinta.tab_filtri.dw_filtro_ff.GetChild("a_tab_iva",ldw_a_tab_iva_cod )
tab_distinta.tab_filtri.dw_filtro_ff.getchild("unita_confezione",ldw_da_unita_conf_cod)
tab_distinta.tab_filtri.dw_filtro_ff.getchild("unita_confezione_des",ldw_da_unita_conf_des)

ldw_da_cat_merc_cod.settransobject(sqlca)
ldw_da_cat_merc_cod.retrieve()

ldw_da_cat_comm_cod.settransobject(sqlca)
ldw_da_cat_comm_cod.retrieve()

ldw_da_cat_fisc_cod.settransobject(sqlca)
ldw_da_cat_fisc_cod.retrieve()

ldw_da_tab_iva_cod.settransobject(sqlca)
ldw_da_tab_iva_cod.retrieve()

ldw_a_cat_merc_cod.settransobject(sqlca)
ldw_a_cat_merc_cod.retrieve()

ldw_a_cat_comm_cod.settransobject(sqlca)
ldw_a_cat_comm_cod.retrieve()

ldw_a_cat_fisc_cod.settransobject(sqlca)
ldw_a_cat_fisc_cod.retrieve()

ldw_a_tab_iva_cod.settransobject(sqlca)
ldw_a_tab_iva_cod.retrieve()

ldw_da_unita_conf_cod.settransobject(sqlca)
ldw_da_unita_conf_cod.retrieve()

ldw_da_unita_conf_des.settransobject(sqlca)
ldw_da_unita_conf_des.retrieve()

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

event ue_post_open;
end event

type cb_chiudi from commandbutton within w_var_dati_articolo_cx
int X=2482
int Y=28
int Width=270
int Height=88
int TabOrder=50
string Text="Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_crea from commandbutton within w_var_dati_articolo_cx
int X=2807
int Y=28
int Width=270
int Height=88
int TabOrder=40
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

string ls_art_des,ls_des_b,ls_cod_int,appoggio,flag,ls_rif_cat
long   ll_gruppo_art,ll_cat_comm,ll_cat_merc,ll_cat_fisc,ll_reparto,ll_produttore
long   ll_fornitore,ll_tab_iva,ll_unita_conf, ll_articolo
String ls_da_unita_confezione, ls_a_unita_confezione, ls_util, ls_st_list
Integer	ll_ret

ls_art_des=idw_modifica.getitemstring(1,"articolo_descrizione")
ls_rif_cat=idw_modifica.getitemstring(1,"rif_catalogo")
appoggio=idw_modifica.getitemstring(1,"gruppo_art_cod")

ll_ret = MessageBox("Variazione dati Articolo", "Confermi la variazione degli Articoli selezionati ?", Question!, YesNo!, 2)
If ll_ret = 1 Then
	
	select "gruppo_articoli"."id_gruppo_articoli"
	into 	 :ll_gruppo_art
	from   gruppo_articoli
	where  "gruppo_articoli"."codice"=:appoggio;
	
	appoggio=idw_modifica.getitemstring(1,"cat_comm_articolo")
	select "cat_com_articolo"."id_cat_com_articolo"
	into :ll_cat_comm
	from cat_com_articolo
	where "cat_com_articolo"."codice"=:appoggio;
	
	appoggio=idw_modifica.getitemstring(1,"cat_merceologica")
	select "cat_merceologica"."id_cat_merceologica"
	into :ll_cat_merc
	from cat_merceologica
	where "cat_merceologica"."codice"=:appoggio;
	
	appoggio=idw_modifica.getitemstring(1,"cat_fiscale")
	select "cat_fiscale"."id_cat_fiscale"
	into :ll_cat_fisc
	from cat_fiscale
	where "cat_fiscale"."codice"=:appoggio;
	
	ls_des_b=idw_modifica.getitemstring(1,"des_breve")
	
	
	appoggio=idw_modifica.getitemstring(1,"reparto")
	select "reparto"."id_reparto"
	into :ll_reparto
	from reparto
	where "reparto"."codice"=:appoggio;
	
	appoggio=idw_modifica.getitemstring(1,"produttore")
	select "anagrafica"."id_anagrafica"
	into :ll_produttore
	from anagrafica
	where "anagrafica"."rag_soc_1"=:appoggio;
	
	appoggio=idw_modifica.getitemstring(1,"fornitore_cod")
	select "sog_commerciale"."id_sog_commerciale"
	into :ll_fornitore
	from sog_commerciale
	where "sog_commerciale"."codice"=:appoggio;
	
	appoggio=idw_modifica.getitemstring(1,"tab_iva")
	select "tab_iva"."id_tab_iva"
	into :ll_tab_iva
	from tab_iva
	where "tab_iva"."codice"=:appoggio;
	
	ls_cod_int=idw_modifica.getitemstring(1,"cod_intrastat")
	
	appoggio=idw_modifica.getitemstring(1,"unita_conf")
	select "unita_conf_base"."id_unita_conf_base"
	into :ll_unita_conf
	from unita_conf_base
	where "unita_conf_base"."codice"=:appoggio;
	
	ls_a_unita_confezione=idw_modifica.GetItemString(1, "unita_confezione")
	ls_da_unita_confezione=tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "unita_confezione_des")
	
	ls_util = idw_modifica.GetItemString(1, "utilizzabile") 
	ls_st_list = idw_modifica.GetItemString(1, "st_in_list") 
	
	idw_target.resetupdate()
	
	FOR i=1 TO ll_row
		
		flag=idw_modifica.getitemstring(1,"f_art_des")
		if flag='S'then
			idw_target.setitem(i,"articolo_descrizione",ls_art_des)
			idw_target.setitemstatus(i,"articolo_descrizione",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_rif_cat")
		if flag='S'then
			idw_target.setitem(i,"articolo_rif_catalogo",ls_rif_cat)
			idw_target.setitemstatus(i,"articolo_rif_catalogo",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_g_art")
		if flag='S'then
			idw_target.setitem(i,"articolo_id_gruppo_articoli",ll_gruppo_art)
			idw_target.setitemstatus(i,"articolo_id_gruppo_articoli",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_cat_comm")
		if flag='S'then
			idw_target.setitem(i,"articolo_id_cat_com_articolo",ll_cat_comm)
			idw_target.setitemstatus(i,"articolo_id_cat_com_articolo",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_cat_merc")
		if flag='S'then
			idw_target.setitem(i,"articolo_id_cat_merceologica",ll_cat_merc)
			idw_target.setitemstatus(i,"articolo_id_cat_merceologica",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_cat_fisc")
		if flag='S'then
			idw_target.setitem(i,"articolo_id_cat_fiscale",ll_cat_fisc)
			idw_target.setitemstatus(i,"articolo_id_cat_fiscale",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_des_b")
		if flag='S'then
			idw_target.setitem(i,"articolo_des_breve",ls_des_b)
			idw_target.setitemstatus(i,"articolo_des_breve",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_reparto")
		if flag='S'then
			idw_target.setitem(i,"articolo_id_reparto",ll_reparto)
			idw_target.setitemstatus(i,"articolo_id_reparto",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_produttore")
		if flag='S'then
			idw_target.setitem(i,"articolo_id_anagrafica",ll_produttore)
			idw_target.setitemstatus(i,"articolo_id_anagrafica",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_fornitore")
		if flag='S'then
			idw_target.setitem(i,"articolo_id_sog_commerciale",ll_fornitore)
			idw_target.setitemstatus(i,"articolo_id_sog_commerciale",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_tab_iva")
		if flag='S'then
			idw_target.setitem(i,"articolo_id_tab_iva",ll_tab_iva)
			idw_target.setitemstatus(i,"articolo_id_tab_iva",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_cod_int")
		if flag='S'then
			idw_target.setitem(i,"articolo_cod_intrastat",ls_cod_int)
			idw_target.setitemstatus(i,"articolo_cod_intrastat",primary!,datamodified!)
		end if
		
		flag=idw_modifica.getitemstring(1,"f_uconf")
		if flag='S'then
			idw_target.setitem(i,"articolo_id_unita_conf_base",ll_unita_conf)
			idw_target.setitemstatus(i,"articolo_id_unita_conf_base",primary!,datamodified!)
		end if
		
		flag=idw_modifica.GetItemString(1,"f_unita_confezione")
		if flag='S'then
			ll_articolo=idw_target.GetItemNumber(i, "id_articolo")
			
			UPDATE unita_confezione u
			SET 	 u.codice = b.codice, u.id_unita_misura = b.id_unita_misura, 
					 u.descrizione = b.descrizione, u.app_conversione = b.app_conversione, 
					 u.fat_conversione = b.fat_conversione, u.tipo_conversione = b.tipo_conversione,
					 u.molteplicita = b.molteplicita, u.qta_minima = b.qta_minima, 
					 u.qta_massima = b.qta_massima, u.id_unita_mis_peso = b.id_unita_mis_peso, 
					 u.peso_netto = b.peso_netto, u.peso_lordo = b.peso_lordo, 
					 u.id_unita_mis_volume = b.id_unita_mis_volume, u.dim_l = b.dim_l, u.dim_h = b.dim_h, 
					 u.dim_p = b.dim_p, u.tipo_stampa_etichette = b.tipo_stampa_etichette, 
					 u.num_colli = b.num_colli
			FROM	 unita_conf_base b
			WHERE  u.codice = :ls_da_unita_confezione
			AND    u.id_articolo = :ll_articolo
			AND 	 b.codice = :ls_a_unita_confezione;
			
			
			if (sqlca.sqlcode = -1) then
				messagebox("DBerror", sqlca.sqlerrtext)
				rollback;
			else
				commit;
			end if
			
		End If   
		
		
		flag=idw_modifica.getitemstring(1,"f_utilizzabile")
		if flag='S'then
			idw_target.setitem(i,"articolo_utilizzabile",ls_util)
			idw_target.setitemstatus(i,"articolo_utilizzabile",primary!,datamodified!)
		end if		
		
		flag=idw_modifica.getitemstring(1,"f_st_in_list")
		if flag='S'then
			idw_target.setitem(i,"articolo_stampa_in_listini",ls_st_list)
			idw_target.setitemstatus(i,"articolo_stampa_in_listini",primary!,datamodified!)
		end if				
		
				
	NEXT
	idw_target.settransobject(sqlca)
	idw_target.update()
	
	
	if (sqlca.sqlcode = -1) then
		messagebox("DBerror", sqlca.sqlerrtext)
		rollback;
	else
		commit;
	end if
	
End If
end event

type tab_distinta from tab within w_var_dati_articolo_cx
event create ( )
event destroy ( )
int X=37
int Y=132
int Width=3378
int Height=1480
int TabOrder=60
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

event selectionchanged;if newindex=3 then
	long ll_Rows, ll_i, ll_CurrRow


ll_Rows = idw_target.RowCount()

ib_removing = TRUE
idw_target.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	idw_target.rowsmove(ll_i,ll_i,primary!,idw_source,1,primary!)
NEXT


ib_removing = FALSE
String ls_da_articolo, ls_a_articolo

ls_da_articolo = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "da_articolo_cod")
ls_a_articolo  = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "a_articolo_cod")

If IsNull(ls_da_articolo) OR ls_da_articolo = "" then
	SELECT MIN(codice)
	INTO	 :ls_da_articolo
	FROM	 articolo
	;
End If
If IsNull(ls_a_articolo) OR ls_a_articolo = "" then
	SELECT MAX(codice)
	INTO	 :ls_a_articolo
	FROM	 articolo
	;
End If

Time lt_inizio_retrieve, lt_fine_retrieve

lt_inizio_retrieve = Now()

Datetime ld_da_data_ora,ld_a_data_ora 
String   ls_filtro,ls_da_cat_merc,ls_a_cat_merc,ls_da_cat_comm,ls_a_cat_comm
String   ls_da_cat_fisc,ls_a_cat_fisc,ls_da_fornitore,ls_a_fornitore,ls_da_produttore,ls_a_produttore
String   ls_da_tab_iva,ls_a_tab_iva, ls_dist
Integer  ret

Tab_distinta.tab_filtri.dw_filtro_ff.AcceptText()
ls_da_cat_merc=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_cat_merceologica")
ls_a_cat_merc=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_cat_merceologica")
ls_da_cat_comm=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_cat_commerciale")
ls_a_cat_comm=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_cat_commerciale")
ls_da_cat_fisc=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_cat_fiscale")
ls_a_cat_fisc=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_cat_fiscale")
ls_da_fornitore=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_fornitore_cod")	
ls_a_fornitore=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_fornitore_cod")	
ls_da_produttore=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_produttore_des")
ls_a_produttore=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_produttore_des")	
ls_da_tab_iva=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_tab_iva")	
ls_a_tab_iva=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_tab_iva")
ld_da_data_ora=Tab_distinta.tab_filtri.dw_filtro_ff.getitemdatetime(1,"da_data_ora")
ld_a_data_ora=Tab_distinta.tab_filtri.dw_filtro_ff.getitemdatetime(1,"a_data_ora")
ls_dist = Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"filtro_dist")

	
If ls_da_articolo>ls_a_articolo then
	Messagebox("Filtra","L'articolo iniziale è maggiore di quello finale!",exclamation!)
	Return
End If

If ls_da_cat_merc>ls_a_cat_merc then
	messagebox("Filtra","La categoria merceologica iniziale è maggiore di quella finale!",exclamation!)
	Return
End if


if ls_da_cat_comm > ls_a_cat_comm then
	messagebox("Filtra","La categoria commerciale iniziale è maggiore di quella finale!",exclamation!)
	Return
End If

If ls_da_cat_fisc>ls_a_cat_fisc then
	messagebox("Filtra","La categoria fiscale iniziale è maggiore di quella finale!",exclamation!)
	Return
End If

If ls_da_fornitore>ls_a_fornitore then
	messagebox("Filtra","Il codice del fornitore iniziale è maggiore di quello finale!",exclamation!)
	Return
End If

If ls_da_produttore>ls_a_produttore then
	messagebox("Filtra","Il produttore iniziale è maggiore di quello finale!",exclamation!)
	Return
End If

if ls_da_tab_iva>ls_a_tab_iva then
	messagebox("Filtra","La tabella iva iniziale è maggiore di quella finale!",exclamation!)
	Return
End If

If ls_da_cat_merc <> ''and ls_filtro = '' then
	ls_filtro="cat_merceologica.codice>="+"'"+string(ls_da_cat_merc)+"'"
elseif ls_da_cat_merc <> '' and ls_filtro <> '' then
	ls_filtro=ls_filtro+" AND (cat_merceologica.codice>="+"'"+string(ls_da_cat_merc)+"'"+")"
End if

If ls_a_cat_merc <> '' and ls_filtro = '' then
	ls_filtro="cat_merceologica.codice<="+"'"+string(ls_a_cat_merc)+"'"
elseif ls_a_cat_merc <> '' and ls_filtro <> '' then
	ls_filtro=ls_filtro+" and (cat_merceologica.codice<="+"'"+string(ls_a_cat_merc)+"'"+")"
End if

If ls_da_cat_comm<>''and ls_filtro='' then
	ls_filtro="cat_com_articolo.codice>="+"'"+string(ls_da_cat_comm)+"'"
elseif ls_da_cat_comm<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (cat_com_articolo.codice>="+"'"+string(ls_da_cat_comm)+"'"+")"
end if

if ls_a_cat_comm <> '' and ls_filtro = '' then
	ls_filtro="cat_com_articolo.codice<="+"'"+string(ls_a_cat_comm)+"'"
elseif ls_a_cat_comm<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (cat_com_articolo.codice<="+"'"+string(ls_a_cat_comm)+"'"+")"
end if

if ls_da_cat_fisc <> '' and ls_filtro = '' then
	ls_filtro="cat_fiscale.codice>="+"'"+string(ls_da_cat_fisc)+"'"
elseif ls_da_cat_fisc <> ''and ls_filtro <> '' then
	ls_filtro=ls_filtro+" AND (cat_fiscale.codice>="+"'"+string(ls_da_cat_fisc)+"'"+")"
end if

if ls_a_cat_fisc <> ''and ls_filtro = '' then
	ls_filtro="cat_fiscale.codice<="+"'"+string(ls_a_cat_fisc)+"'"
elseif ls_a_cat_fisc<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (cat_fiscale.codice<="+"'"+string(ls_a_cat_fisc)+"'"+")"
end if

if ls_da_fornitore <> '' and ls_filtro = '' then
	ls_filtro="sog_commerciale.codice>="+"'"+string(ls_da_fornitore)+"'"
elseif ls_da_fornitore <> '' and ls_filtro <> '' then
	ls_filtro=ls_filtro+" AND (sog_commerciale.codice>="+"'"+string(ls_da_fornitore)+"'"+")"
end if

if ls_a_fornitore <> '' and ls_filtro = '' then
	ls_filtro="sog_commerciale_codice<="+"'"+string(ls_a_fornitore)+"'"
elseif ls_a_fornitore<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (sog_commerciale.codice<="+"'"+string(ls_a_fornitore)+"'"+")"
end if

if ls_da_produttore <> ''and ls_filtro = '' then
	ls_filtro="anagrafica.rag_soc_1>="+"'"+string(ls_da_produttore)+"'"
elseif ls_da_produttore<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (anagrafica.rag_soc_1>="+"'"+string(ls_da_produttore)+"'"+")"
end if

if ls_a_produttore<>''and ls_filtro='' then
	ls_filtro="anagrafica.rag_soc_1<="+"'"+string(ls_a_produttore)+"'"
elseif ls_a_produttore<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" and (anagrafica.rag_soc_1<="+"'"+string(ls_a_produttore)+"'"+")"
end if

if ls_da_tab_iva <> '' and ls_filtro = '' then
	ls_filtro="tab_iva.codice>="+"'"+string(ls_da_tab_iva)+"'"
elseif ls_da_tab_iva<>''and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (tab_iva.codice>="+"'"+string(ls_da_tab_iva)+"'"+")"
end if

if ls_a_tab_iva <> '' and ls_filtro = '' then
	ls_filtro="tab_iva.codice<="+"'"+string(ls_a_tab_iva)+"'"
elseif ls_a_tab_iva <> '' and ls_filtro <> '' then
	ls_filtro=ls_filtro+" AND (tab_iva.codice<="+"'"+string(ls_a_tab_iva)+"'"+")"
end if

if not isnull(ld_da_data_ora) and ls_filtro = '' then
	ls_filtro="articolo.data_ora_creazione>=datetime('"+string(ld_da_data_ora)+"')"
elseif not isnull(ld_da_data_ora) and ls_filtro <> '' then
	ls_filtro=ls_filtro+" AND (articolo.data_ora_creazione>=datetime('"+string(ld_da_data_ora)+"'))"
end if

If not isnull(ld_a_data_ora) and ls_filtro = '' then
	ls_filtro="articolo.data_ora_creazione<=datetime('"+string(ld_a_data_ora)+"')"
elseif not isnull(ld_a_data_ora) and ls_filtro<>'' then
	ls_filtro=ls_filtro+" AND (articolo.data_ora_creazione<=datetime('"+string(ld_a_data_ora)+"'))"
End If


is_filter = ls_filtro

idw_source.retrieve(ls_da_articolo, ls_a_articolo)
idw_source.setfocus()

tab_distinta.tab_seleziona.dw_var_dati_artrec_ff.Retrieve(ls_da_articolo, ls_a_articolo)
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
end type

on tab_filtri.create
this.dw_filtro_ff=create dw_filtro_ff
this.Control[]={this.dw_filtro_ff}
end on

on tab_filtri.destroy
destroy(this.dw_filtro_ff)
end on

type dw_filtro_ff from u_dw_ext_main within tab_filtri
event itemchanged pbm_dwnitemchange
event ue_init ( )
event ue_setup_filter ( )
int X=23
int Y=0
int Width=3314
int Height=1344
int TabOrder=2
string DataObject="d_var_dati_articolo_ff"
boolean TitleBar=true
string Title="Filtro Articoli/Unità Confezione"
end type

event itemchanged;String 	ls_sql_cond
String 	ls_dbc[], ls_dwc[], ls_dbv[]
Long		ll_id_listino, ll_ok
String 	ls_listino

CHOOSE CASE dwo.name
	CASE "da_articolo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo_cod"
		ls_dwc[2] = "da_articolo_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	
	   
		
		IF (ll_ok > 0) THEN
		   if isnull(This.GetItemString(1, "a_articolo_cod")) or This.GetItemString(1, "a_articolo_cod")='' then
            This.SetItem(1, "a_articolo_cod", Data)			
            This.SetItem(1, "a_articolo_des", This.GetItemString(1, "da_articolo_des"))	
         end if  	
			RETURN 2
		END IF
		
		
	CASE "da_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_articolo_cod"
		ls_dwc[2] = "da_articolo_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
			
			

		IF (ll_ok > 0) THEN
		   if isnull(This.GetItemString(1, "a_articolo_cod")) or This.GetItemString(1, "a_articolo_cod")='' then
          This.SetItem(1, "a_articolo_des", Data)			
          This.SetItem(1, "a_articolo_cod", This.GetItemString(1, "da_articolo_cod"))	
	      end if  
			RETURN 2
		END IF

	CASE "a_articolo_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo_cod"
		ls_dwc[2] = "a_articolo_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_articolo_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_articolo_cod"
		ls_dwc[2] = "a_articolo_des"
		
		ll_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE 'da_fornitore_cod'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"				
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_fornitore"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_fornitore_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
										
											
										
		IF (ll_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_fornitore_cod")) or This.GetItemString(1, "a_fornitore_cod")='' then
           This.SetItem(1, "a_fornitore_cod", Data)			
           This.SetItem(1, "a_fornitore_des", This.GetItemString(1, "da_fornitore_des"))	
	      end if  
			RETURN 2
		END IF	
		
		
		
	CASE 'da_fornitore_des'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"				
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_fornitore"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_fornitore_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)		
					
		IF (ll_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_fornitore_cod")) or This.GetItemString(1, "a_fornitore_cod")='' then
           This.SetItem(1, "a_fornitore_des", Data)			
           This.SetItem(1, "a_fornitore_cod", This.GetItemString(1, "da_fornitore_cod"))	
	      end if  		
			RETURN 2
		END IF
		
	CASE 'a_fornitore_cod'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_fornitore"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_fornitore_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"codice", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
		
	CASE 'a_fornitore_des'
		ls_sql_cond = "sog_commerciale_gen.tipo = 'F'"				
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_fornitore"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_fornitore_des"
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
	CASE 'da_produttore_des'
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "da_produttore"
		ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
												
		
		IF (ll_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_produttore_des")) or This.GetItemString(1, "a_produttore_des")='' then
           This.SetItem(1, "a_produttore_des", Data)			
	      end if  
			RETURN 2
		END IF				
	CASE 'a_produttore_des'
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[2] = "a_produttore"
		ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 2, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
		
	case "filtro_dist"
		if data = 'S' then
			idw_source.dataobject="d_var_articoli_dist_lt"
			idw_target.dataobject="d_var_articoli_dist_lt"		
			idw_source.settransobject(sqlca)			
			idw_target.settransobject(sqlca)						
		else
			idw_source.dataobject="d_var_articoli_lt"
			idw_target.dataobject="d_var_articoli_lt"			
			idw_source.settransobject(sqlca)			
			idw_target.settransobject(sqlca)									
		end if
END CHOOSE

end event

event ue_init;call super::ue_init;is_colonne_drop[1]  = "id_tipo_pagamento_cod"
is_colonne_drop[2]  = "id_tipo_pagamento_des"
is_colonne_drop[3]  = "id_banca_azienda"
is_colonne_drop[4]  = "id_banca_azienda_pres"
end event

event ue_setup_filter;call super::ue_setup_filter;
end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_articolo_cod"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "da_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	CASE "a_articolo_cod"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "a_articolo_des"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"	
	CASE "da_produttore_des"
		is_search_window = "w_anagrafica_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
	CASE "a_produttore_des"
		is_search_window = "w_anagrafica_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
	CASE "da_fornitore_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
	CASE "a_fornitore_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
	CASE "da_fornitore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
	CASE "a_fornitore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
end choose
end event

event ue_use_search;CHOOSE CASE as_nomecol
	case "da_articolo_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo_des",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo_cod")) or This.GetItemString(1, "a_articolo_cod")='' then
			  uf_set_colval("a_articolo_cod",is_ricpar.s_main_value)		
           uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])
	      end if  
		
	case "da_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_articolo_cod",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_articolo_cod")) or This.GetItemString(1, "a_articolo_cod")='' then
			  uf_set_colval("a_articolo_des",is_ricpar.s_main_value)		
           uf_set_colval("a_articolo_cod",is_ricpar.s_ausil_value[1])
	      end if  
			
	case "a_articolo_cod"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo_des",is_ricpar.s_ausil_value[1])	
	case "a_articolo_des"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_articolo",is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_articolo_cod",is_ricpar.s_ausil_value[1])
			
	CASE "da_produttore_des"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			uf_set_colval("id_anagrafica", is_ricpar.s_id_seg_value[1])
			if isnull(This.GetItemString(1, "a_produttore_des")) or This.GetItemString(1, "a_produttore_des")='' then
            	uf_set_colval("a_produttore_des", is_ricpar.s_main_value)			
	      end if  
		
	CASE "da_fornitore_cod"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_fornitore_des", is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_fornitore_cod")) or This.GetItemString(1, "a_fornitore_cod")='' then
           uf_set_colval("a_fornitore_cod", is_ricpar.s_main_value)
			  uf_set_colval("a_fornitore_des", is_ricpar.s_ausil_value[1])	
	      end if 
			
	CASE "da_fornitore_des"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_fornitore_cod", is_ricpar.s_ausil_value[1])	
			if isnull(This.GetItemString(1, "a_fornitore_cod")) or This.GetItemString(1, "a_fornitore_cod")='' then
           uf_set_colval("a_fornitore_des", is_ricpar.s_main_value)
			  uf_set_colval("a_fornitore_cod", is_ricpar.s_ausil_value[1])	
	      end if 
			
	CASE "a_produttore_des"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			uf_set_colval("id_anagrafica", is_ricpar.s_id_seg_value[1])
	CASE "a_fornitore_cod"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_fornitore_des", is_ricpar.s_ausil_value[1])
	CASE "a_fornitore_des"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
			uf_set_colval("a_fornitore_cod", is_ricpar.s_ausil_value[1])	
END CHOOSE
end event

event ue_key;DataWindowChild	ldw_drop
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
end type

on tab_modifiche.create
this.dw_modifiche_ff=create dw_modifiche_ff
this.Control[]={this.dw_modifiche_ff}
end on

on tab_modifiche.destroy
destroy(this.dw_modifiche_ff)
end on

type dw_modifiche_ff from u_dw_ext_main within tab_modifiche
int X=5
int Y=8
int Width=3305
int Height=1348
int TabOrder=2
string DataObject="d_var_dati_articoli_ext"
boolean TitleBar=true
string Title="Modifiche da apportare"
boolean HScrollBar=true
end type

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "produttore"
		is_search_window = "w_anagrafica_sw" 

		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
	CASE "fornitore_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
	CASE "fornitore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'F'"
				
end choose

end event

event ue_use_search;call super::ue_use_search;string ls_val
CHOOSE CASE as_nomecol
	CASE "produttore"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		this.accepttext()

		ls_val=this.getitemstring(1,"produttore")
		if not isnull(ls_val) then
			this.setitem(1,"f_produttore",'S')
		else
			this.setitem(1,"f_produttore",'N')
		end if

	CASE "fornitore_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("fornitore_des", is_ricpar.s_ausil_value[1])
		
		ls_val=this.Getitemstring(1,"fornitore_cod")
		if not isnull(ls_val) then
			this.setitem(1,"f_fornitore",'S')
		else
			this.setitem(1,"f_fornitore",'N')
		end if

	CASE "fornitore_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("fornitore_cod", is_ricpar.s_ausil_value[1])
		
		ls_val=this.getitemstring(1,"fornitore_des")
		if not isnull(ls_val) then
			this.setitem(1,"f_fornitore",'S')
		else
			this.setitem(1,"f_fornitore",'N')
		end if	
END CHOOSE





	

end event

event itemchanged;string ls_val
this.accepttext()

if dwo.name="articolo_descrizione" then
	ls_val=this.getitemstring(1,"articolo_descrizione")
	if not isnull(ls_val) then
		this.setitem(1,"f_art_des",'S')
	else
		this.setitem(1,"f_art_des",'N')
	end if
end if
if dwo.name="rif_catalogo" then
	ls_val=this.getitemstring(1,"rif_catalogo")
	if not isnull(ls_val) then
		this.setitem(1,"f_rif_cat",'S')
	else
		this.setitem(1,"f_rif_cat",'N')
	end if
end if

if dwo.name="gruppo_art_cod" then
	ls_val=this.getitemstring(1,"gruppo_art_cod")
	if not isnull(ls_val) then
		this.setitem(1,"f_g_art",'S')
	else
		this.setitem(1,"f_g_art",'N')
	end if
end if

if dwo.name="gruppo_art_des" then
	ls_val=this.getitemstring(1,"gruppo_art_des")
	if not isnull(ls_val) then
		this.setitem(1,"f_g_art",'S')
	else
		this.setitem(1,"f_g_art",'N')
	end if
end if

if dwo.name="cat_comm_articolo" then
	ls_val=this.getitemstring(1,"cat_comm_articolo")
	if not isnull(ls_val) then
		this.setitem(1,"f_cat_comm",'S')
	else
		this.setitem(1,"f_cat_comm",'N')
	end if
end if

if dwo.name="cat_comm_articolo_des" then
	ls_val=this.getitemstring(1,"cat_comm_articolo_des")
	if not isnull(ls_val) then
		this.setitem(1,"f_cat_comm",'S')
	else
		this.setitem(1,"f_cat_comm",'N')
	end if
end if

if dwo.name="cat_merceologica" then
	ls_val=this.getitemstring(1,"cat_merceologica")
	if not isnull(ls_val) then
		this.setitem(1,"f_cat_merc",'S')
	else
		this.setitem(1,"f_cat_merc",'N')
	end if
end if

if dwo.name="cat_merceologica_des" then
	ls_val=this.getitemstring(1,"cat_merceologica_des")
	if not isnull(ls_val) then
		this.setitem(1,"f_cat_merc",'S')
	else
		this.setitem(1,"f_cat_merc",'N')
	end if
end if

if dwo.name="cat_fiscale" then
	ls_val=this.getitemstring(1,"cat_fiscale")
	if not isnull(ls_val) then
		this.setitem(1,"f_cat_fisc",'S')
	else
		this.setitem(1,"f_cat_fisc",'N')
	end if
end if

if dwo.name="cat_fiscale_des" then
	ls_val=this.getitemstring(1,"cat_fiscale_des")
	if not isnull(ls_val) then
		this.setitem(1,"f_cat_fisc",'S')
	else
		this.setitem(1,"f_cat_fisc",'N')
	end if
end if

if dwo.name="des_breve" then
	ls_val=this.getitemstring(1,"des_breve")
	if not isnull(ls_val) then
		this.setitem(1,"f_des_b",'S')
	else
		this.setitem(1,"f_des_b",'N')
	end if
end if

if dwo.name="reparto" then
	ls_val=this.getitemstring(1,"reparto")
	if not isnull(ls_val) then
		this.setitem(1,"f_reparto",'S')
	else
		this.setitem(1,"f_reparto",'N')
	end if
end if

if dwo.name="reparto_des" then
	ls_val=this.getitemstring(1,"reparto_des")
	if not isnull(ls_val) then
		this.setitem(1,"f_reparto",'S')
	else
		this.setitem(1,"f_reparto",'N')
	end if
end if

if dwo.name="produttore" then
	ls_val=this.getitemstring(1,"produttore")
	if not isnull(ls_val) then
		this.setitem(1,"f_produttore",'S')
	else
		this.setitem(1,"f_produttore",'N')
	end if
end if

if dwo.name="fornitore_cod" then
	ls_val=this.getitemstring(1,"fornitore_cod")
	if not isnull(ls_val) then
		this.setitem(1,"f_fornitore",'S')
	else
		this.setitem(1,"f_fornitore",'N')
	end if
end if

if dwo.name="fornitore_des" then
	ls_val=this.getitemstring(1,"fornitore_des")
	if not isnull(ls_val) then
		this.setitem(1,"f_fornitore",'S')
	else
		this.setitem(1,"f_fornitore",'N')
	end if
end if

if dwo.name="tab_iva" then
	ls_val=this.getitemstring(1,"tab_iva")
	if not isnull(ls_val) then
		this.setitem(1,"f_tab_iva",'S')
	else
		this.setitem(1,"f_tab_iva",'N')
	end if
end if

if dwo.name="tab_iva_des" then
	ls_val=this.getitemstring(1,"tab_iva_des")
	if not isnull(ls_val) then
		this.setitem(1,"f_tab_iva",'S')
	else
		this.setitem(1,"f_tab_iva",'N')
	end if
end if

if dwo.name="cod_intrastat" then
	ls_val=this.getitemstring(1,"cod_intrastat")
	if not isnull(ls_val) then
		this.setitem(1,"f_cod_int",'S')
	else
		this.setitem(1,"f_cod_int",'N')
	end if
end if

if dwo.name="unita_conf" then
	ls_val=this.getitemstring(1,"unita_conf")
	if not isnull(ls_val) then
		this.setitem(1,"f_uconf",'S')
	else
		this.setitem(1,"f_uconf",'N')
	end if
end if

if dwo.name="unita_conf_des" then
	ls_val=this.getitemstring(1,"unita_conf_des")
	if not isnull(ls_val) then
		this.setitem(1,"f_uconf",'S')
	else
		this.setitem(1,"f_uconf",'N')
	end if
end if

if dwo.name="unita_confezione" then
	ls_val=this.getitemstring(1,"unita_confezione")
	if not isnull(ls_val) then
		this.setitem(1,"f_unita_confezione",'S')
	else
		this.setitem(1,"f_unita_confezione",'N')
	end if
end if

if dwo.name="unita_confezione_des" then
	ls_val=this.getitemstring(1,"unita_confezione_des")
	if not isnull(ls_val) then
		this.setitem(1,"f_unita_confezione",'S')
	else
		this.setitem(1,"f_unita_confezione",'N')
	end if
end if

if dwo.name="calc_fab" then
	if data = 'S' then
		cb_2.visible = true
	else
		cb_2.visible = false
	end if
end if
end event

type tab_seleziona from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3342
int Height=1360
long BackColor=79741120
string Text=" Articoli da variare"
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
dw_1 dw_1
dw_2 dw_2
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
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_recuperati_lt,&
this.st_4,&
this.dw_selezionati_lt,&
this.st_3,&
this.dw_var_dati_artrec_ff,&
this.dw_1,&
this.dw_2}
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
destroy(this.dw_1)
destroy(this.dw_2)
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

event clicked;long ll_Rows, ll_i, ll_CurrRow,contatore
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

event clicked;long    ll_Rows, ll_i, ll_CurrRow
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

event clicked;long ll_Rows, ll_i, ll_CurrRow
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

event clicked;long ll_Rows, ll_i, ll_CurrRow


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
int Y=56
int Width=1449
int Height=1064
string DataObject="d_var_articoli_lt"
boolean TitleBar=true
string Title="Ricercati"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_buttonup;
end event

event ue_buttondown;
end event

event ue_mousemove;
end event

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

event dragenter;
end event

event dragleave;
end event

event sqlpreview;
If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + ' AND ' + is_filter + ' ORDER BY articolo.codice'
	This.SetSQLPreview(ls_SQLSyntax)
	
End If


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
int Y=56
int Width=1449
int Height=1064
int TabOrder=2
string DataObject="d_var_articoli_lt"
boolean TitleBar=true
string Title="Selezionati"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event clicked;call super::clicked;wf_selezione(row,this,"",this,"","")

end event

type st_3 from statictext within tab_seleziona
int X=2501
int Y=1192
int Width=485
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="articoli da variare"
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
int Width=1125
int Height=96
int TabOrder=2
boolean BringToTop=true
string DataObject="d_var_dati_artrec_ff"
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

type dw_1 from datawindow within tab_seleziona
int X=1312
int Y=1152
int Width=283
int Height=156
int TabOrder=21
boolean Visible=false
boolean BringToTop=true
string DataObject="d_fabbisogno_gd"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type dw_2 from datawindow within tab_seleziona
int X=1714
int Y=1152
int Width=283
int Height=156
int TabOrder=31
boolean Visible=false
boolean BringToTop=true
string DataObject="d_euro_fabbisogno_gd"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_1 from commandbutton within w_var_dati_articolo_cx
int X=3131
int Y=28
int Width=270
int Height=88
int TabOrder=10
boolean BringToTop=true
string Text="&Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
Long 		i, ll_row
Integer	ll_ret

String	ls_articolo

ll_ret = MessageBox("Variazione dati Articolo", "Confermi la cancellazione degli Articoli selezionati ?", Question!, YesNo!, 2)
If ll_ret = 1 Then
	ll_row=idw_target.rowcount()

	idw_target.ResetUpdate()

	For i=1 to ll_row
		ls_articolo = idw_target.GetItemString(1, "articolo_codice")
		idw_target.DeleteRow(1)	
	Next
	idw_target.SetTransObject(SQLCA)
	idw_target.Update()	
	
	if (sqlca.sqlcode = -1) then
		messagebox("DBerror", sqlca.sqlerrtext)
		rollback;
	else
		commit;
	end if
	
End If
end event

type tv_1 from u_tv_distinta within w_var_dati_articolo_cx
int X=1531
int Y=24
int Width=512
int Height=140
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
end type

type cb_2 from commandbutton within w_var_dati_articolo_cx
int X=2085
int Y=28
int Width=343
int Height=88
int TabOrder=20
boolean Visible=false
boolean BringToTop=true
string Text="Calcola Fabb."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long i,ll_row
ll_row=idw_target.rowcount()

string ls_art_des,ls_des_b,ls_cod_int,appoggio,flag,ls_rif_cat, ls_codart, ls_desart
long   ll_gruppo_art,ll_cat_comm,ll_cat_merc,ll_cat_fisc,ll_reparto,ll_produttore
long   ll_fornitore,ll_tab_iva,ll_unita_conf, ll_articolo, ll_id_art, ll_id_rep, cont, ll_new
String ls_da_unita_confezione, ls_a_unita_confezione, ls_util, ls_st_list, ls_repdes
Integer	ll_ret
decimal ld_qta, ld_esis, ld_disp

ls_art_des=idw_modifica.getitemstring(1,"articolo_descrizione")
ls_rif_cat=idw_modifica.getitemstring(1,"rif_catalogo")
appoggio=idw_modifica.getitemstring(1,"gruppo_art_cod")

ll_ret = MessageBox("Calcolo Fabbisogno", "Confermi il calcolo degli Articoli selezionati ?", Question!, YesNo!, 2)
If ll_ret = 1 Then

	long ll_id_articolo, ll_distinta, ll_handle,ll_disponibilita
	string tipo_calcolo, tipo_applicazione, ls_euroservice
	integer li_anno
	decimal ld_quantita
	s_fabbisogno s_app
	u_tv_distinta luo_distinta	
	flag=idw_modifica.GetItemString(1,"calc_fab")
	if flag='S'then
		idw_target.accepttext()
		tab_distinta.tab_seleziona.dw_1.settransobject(sqlca)
		tab_distinta.tab_seleziona.dw_1.reset()
		
		tab_distinta.tab_seleziona.dw_2.settransobject(sqlca)
		tab_distinta.tab_seleziona.dw_2.reset()		
		
		select produzione
		into :ls_euroservice
		from pers_par_sistema;
		if isnull(ls_euroservice) then ls_euroservice = 'N'
		
		li_anno=year(today())
		open(w_data_val_ff)
		dati dat
		dat=message.powerobjectparm
		date ld_1,ld_2
		ld_1=dat.data_inizio
		ld_2=dat.data_fine
		if isnull(ld_1) then ld_1=date('01/01/'+string(li_anno))
		if isnull(ld_2) then ld_2=date('31/12/'+string(li_anno))		
		
		
		
		
		open(w_par_disponibilita_fabbisogno_lt)
		ll_disponibilita=message.doubleparm		
		
		FOR i=1 TO ll_row
			ll_distinta = 0
			tipo_applicazione = ''
			tipo_calcolo  = ''
			ll_id_articolo = idw_target.getitemnumber(i,"id_articolo")
			select id_distinta, tipo_applicazione, tipo_cal_valore
			into :ll_distinta, :tipo_applicazione, :tipo_calcolo
			from distinta
			where id_articolo = :ll_id_articolo;
			if isnull(ll_distinta) then ll_distinta = 0
			
			ld_quantita = dec(idw_target.GetItemnumber(i,"qta"))
			if isnull(ld_quantita) or ld_quantita = 0 then ld_quantita = 1			
			
			if ll_distinta > 0 and (tipo_calcolo<>"" or not isnull(tipo_calcolo )) then						
				tv_1.deleteitem(0)
				ll_handle=tv_1.FindItem(RootTreeItem! , 0)				
				f_rec_righe_comp(tv_1,0,true,ll_distinta,ld_1,ld_2,ll_distinta,false)
				if upperbound(tv_1.is_comp) >0 then 
					luo_distinta=create u_tv_distinta
					luo_distinta.is_comp=tv_1.is_comp
					openwithparm(w_variante_comp_ff,luo_distinta)
					luo_distinta=message.powerobjectparm
					if isvalid(luo_distinta) then 
						tv_1.is_comp=luo_distinta.is_comp
					end if
					destroy luo_distinta
					tv_1.deleteitem(0)	
				end if
								
				if ls_euroservice = 'S' then
					f_fabbisogno(tv_1,ll_handle,true,ll_distinta,ld_1,ld_2,ll_distinta,tipo_calcolo,tipo_applicazione,false,tab_distinta.tab_seleziona.dw_2,ld_quantita)
				else
					f_fabbisogno(tv_1,ll_handle,true,ll_distinta,ld_1,ld_2,ll_distinta,tipo_calcolo,tipo_applicazione,false,tab_distinta.tab_seleziona.dw_1,ld_quantita)					
				end if
															
			end if			
		next

		if ls_euroservice = 'S' then
			wf_euro_fab(ll_disponibilita)
			FOR i=1 TO ll_row
				ll_new = tab_distinta.tab_seleziona.dw_2.insertrow(0)
				
				ll_id_articolo = idw_target.getitemnumber(i,"id_articolo")
				if isnull(ll_id_articolo) then ll_id_articolo = 0
				
				ls_codart = idw_target.getitemstring(i,"articolo_codice")
				if isnull(ls_codart) then ls_codart = ''				
				
				ls_desart = idw_target.getitemstring(i,"articolo_descrizione")
				if isnull(ls_desart) then ls_desart = ''								
				
				ld_qta = idw_target.getitemdecimal(i,"qta")
				if isnull(ld_qta) then ld_qta = 0
				
				ld_esis = idw_target.getitemdecimal(i,"esi_fisica_attuale")
				if isnull(ld_esis) then ld_esis = 0	
				
				ld_disp = idw_target.getitemdecimal(i,"disponibile")
				if isnull(ld_disp) then ld_disp = 0				
				
				tab_distinta.tab_seleziona.dw_2.setitem(ll_new,"codice",ls_codart)
				tab_distinta.tab_seleziona.dw_2.setitem(ll_new,"descrizione",ls_desart)
				tab_distinta.tab_seleziona.dw_2.setitem(ll_new,"id_articolo",ll_id_articolo)
				tab_distinta.tab_seleziona.dw_2.setitem(ll_new,"consumo",ld_qta)
				tab_distinta.tab_seleziona.dw_2.setitem(ll_new,"esistenza",ld_esis)
				tab_distinta.tab_seleziona.dw_2.setitem(ll_new,"disponibilita",ld_disp)	
				
			next
			
			for cont=1 to tab_distinta.tab_seleziona.dw_2.rowcount()
				ll_id_art = tab_distinta.tab_seleziona.dw_2.getitemnumber(cont,"id_articolo")
				select id_reparto
				into :ll_id_rep
				from articolo
				where id_articolo = :ll_id_art;
				if isnull(ll_id_rep) then ll_id_rep = 0
				
				select descrizione
				into :ls_repdes
				from reparto
				where id_reparto = :ll_id_rep;
				if isnull(ls_repdes) then ls_repdes = ''				
				
				tab_distinta.tab_seleziona.dw_2.setitem(cont,"id_reparto",ll_id_rep)
				tab_distinta.tab_seleziona.dw_2.setitem(cont,"repdes",ls_repdes)				
			next
			
			
		else		
			wf_fabbisogno(ll_disponibilita)
			openwithparm(w_fabbisogno_distinta2_ff,tab_distinta.tab_seleziona.dw_1)
		end if
	end if
end if
end event

