forward
global type w_orafo_var_tipo_articolo_cx from w_wiz_main
end type
type cb_chiudi from commandbutton within w_orafo_var_tipo_articolo_cx
end type
type cb_crea from commandbutton within w_orafo_var_tipo_articolo_cx
end type
type tab_distinta from tab within w_orafo_var_tipo_articolo_cx
end type
type tab_filtri from userobject within tab_distinta
end type
type dw_filtro_ff from u_dw_ext_main within tab_filtri
end type
type tab_filtri from userobject within tab_distinta
dw_filtro_ff dw_filtro_ff
end type
type tab_modifiche from userobject within tab_distinta
end type
type dw_modifiche_ff from u_dw_ext_main within tab_modifiche
end type
type cb_cnv from commandbutton within tab_modifiche
end type
type tab_modifiche from userobject within tab_distinta
dw_modifiche_ff dw_modifiche_ff
cb_cnv cb_cnv
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
end type
type tab_distinta from tab within w_orafo_var_tipo_articolo_cx
tab_filtri tab_filtri
tab_modifiche tab_modifiche
tab_seleziona tab_seleziona
end type
type cb_1 from commandbutton within w_orafo_var_tipo_articolo_cx
end type
type cb_salva from commandbutton within w_orafo_var_tipo_articolo_cx
end type
end forward

global type w_orafo_var_tipo_articolo_cx from w_wiz_main
integer x = 434
integer y = 348
integer width = 2930
integer height = 1624
string title = "Variazione dati Articolo"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_chiudi cb_chiudi
cb_crea cb_crea
tab_distinta tab_distinta
cb_1 cb_1
cb_salva cb_salva
end type
global w_orafo_var_tipo_articolo_cx w_orafo_var_tipo_articolo_cx

type variables
DataWindow idw_source, idw_target,idw_modifica
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
Decimal idc_imp_max_distinta
s_distinta is_distinta
char ic_tipo_scadenza
long il_id_banca_azienda, il_id_dis_banca
decimal idec_peso[], idec_misura[], idec_calo, idec_cnv_coef
long id_u_c[], il_id_titolo
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
public subroutine wf_solo_coilore (long ll_variante, long ll_row)
public subroutine wf_solo_titolo (long ll_variante, long ll_row)
public subroutine wf_tit_col (long ll_variante, long ll_variante2, long ll_row)
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

public subroutine wf_solo_coilore (long ll_variante, long ll_row);
end subroutine

public subroutine wf_solo_titolo (long ll_variante, long ll_row);
end subroutine

public subroutine wf_tit_col (long ll_variante, long ll_variante2, long ll_row);long ll_riga, ll_conto, ll_val, ll_val_orig, ll_null, ll_val2, ll_val_orig2, ll_ret
string ls_codice,ls_codice2, ls_codice_orig, ls_precedente, ls_controllo, ls_fisso
integer li_pos

datastore ext_tutto

ext_tutto=create datastore
ext_tutto.DataObject = 'd_cerca_art_tit_cod'
ext_tutto.settransobject(sqlca)

ll_riga=ll_row
ll_val=ll_variante
ll_val2=ll_variante2

ls_precedente=''
for ll_conto=1 to ll_riga 
	   ll_val_orig=tab_distinta.tab_seleziona.dw_selezionati_lt.getitemnumber(ll_conto,"id_titolo")
		ll_val_orig2=tab_distinta.tab_seleziona.dw_selezionati_lt.getitemnumber(ll_conto,"id_colore")
      if isnull(ll_val_orig) then ll_val_orig=0
		if isnull(ll_val_orig2) then ll_val_orig2=0
		//se cambia il titolo o i lcolore allora creo la variante
		//if (ll_val<>ll_val_orig) or (ll_val2<>ll_val_orig2) then
		//invece faccio creare la variante in ogni caso 19-02-12 mm

		ls_codice_orig=tab_distinta.tab_seleziona.dw_selezionati_lt.getitemstring(ll_conto,"articolo_codice")
		li_pos=pos(ls_codice_orig, '-')
		if li_pos>0 then
			ls_codice_orig=left(ls_codice_orig, li_pos -1)
		end if
		
		
		
		//invece faccio creare la variante in ogni caso 19-02-12 mm //funzionerà???
//		if ls_codice_orig=ls_precedente then 
//			tab_distinta.tab_seleziona.dw_selezionati_lt.rowsmove(ll_conto,ll_conto,primary!,tab_distinta.tab_seleziona.dw_recuperati_lt,1,primary!)
//			ll_riga=ll_riga -1
//			ll_conto=ll_conto -1
//			continue
//		end if
		
		
		ls_precedente = ls_codice_orig
	
	
		ls_fisso=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemstring(1,"piu_cod")  
		ls_codice= ls_codice_orig + '-' + ls_fisso
		
		

		ls_controllo=ls_codice_orig + '-'

		//ll_ret=ext_tutto.retrieve(ll_val2,ls_codice_orig, ls_controllo+"%", ll_val)
		ll_ret=ext_tutto.retrieve(ll_val2,ls_codice, ls_codice, ll_val)
		if ll_ret>0 then    
			 tab_distinta.tab_seleziona.dw_selezionati_lt.rowsmove(ll_conto,ll_conto,primary!,tab_distinta.tab_seleziona.dw_recuperati_lt,1,primary!)
			 ll_riga=ll_riga -1
			 ll_conto=ll_conto -1
			 continue
		end if
//		
		
		select codice
		into :ls_controllo
			 from articolo
			 where codice=:ls_codice
		  ; 
	  
			if sqlca.sqlcode=0 then	  
			  DO   	 
				open(w_orafo_var_nuovo_cod)
				ls_fisso=message.stringparm
				ls_codice= ls_codice_orig + '-' + ls_fisso
				select codice
					into :ls_controllo
					from articolo
					where codice=:ls_codice
					; 
		  
				LOOP UNTIL ls_codice<>ls_controllo
			end if
		if ll_val2>0 then
			tab_distinta.tab_seleziona.dw_selezionati_lt.setitem(ll_conto,"id_titolo",ll_val2)
		end if
		if ll_val>0 then
			tab_distinta.tab_seleziona.dw_selezionati_lt.setitem(ll_conto,"id_colore",ll_val)
		end if	
		ll_null= tab_distinta.tab_seleziona.dw_selezionati_lt.getitemnumber(ll_conto,"id_articolo")
		select peso_netto, conv_misura_peso, id_unita_confezione
		into :idec_peso[ll_conto], :idec_misura[ll_conto],:id_u_c[ll_conto]
		from unita_confezione
		where id_articolo=:ll_null
		and unita_base='S'
		;
		
		if isnull(idec_misura[ll_conto]) then idec_misura[ll_conto]=0
		if isnull(idec_peso[ll_conto]) then idec_peso[ll_conto]=0
		
		setnull(ll_null)
		tab_distinta.tab_seleziona.dw_selezionati_lt.setitem(ll_conto,"articolo_codice",ls_codice)
		tab_distinta.tab_seleziona.dw_selezionati_lt.setitem(ll_conto,"id_articolo", ll_null)
		
		tab_distinta.tab_seleziona.dw_selezionati_lt.setitem(ll_conto,"articolo_coef_calo",idec_calo)
//	else  //commentato 19-02-12 per fare comunque variante funzionerà? aveva lo scopo anche di non creare 2 varianti uguali !?
//				tab_distinta.tab_seleziona.dw_selezionati_lt.rowsmove(ll_conto,ll_conto,primary!,tab_distinta.tab_seleziona.dw_recuperati_lt,1,primary!)
//				ll_riga=ll_riga -1
//				ll_conto=ll_conto -1
//		  end if	
//		  
	     
		  ls_codice=''
        ls_codice2=''

next 



messagebox('Information!','Prima di eseguire ulteriori operazioni è consigliabile, se vi sono modifiche, salvare gli articoli con la nuova variante') 


end subroutine

on w_orafo_var_tipo_articolo_cx.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_crea=create cb_crea
this.tab_distinta=create tab_distinta
this.cb_1=create cb_1
this.cb_salva=create cb_salva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_crea
this.Control[iCurrent+3]=this.tab_distinta
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_salva
end on

on w_orafo_var_tipo_articolo_cx.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_crea)
destroy(this.tab_distinta)
destroy(this.cb_1)
destroy(this.cb_salva)
end on

event open;call super::open;

long 	 ll_CurrRow, ll_id_esercizio, ll_id_dis_banca
string ls_sort

DataWindowChild dwc_drop,ldw_da_cat_merc_cod, ldw_a_cat_merc_cod
Datawindowchild ldw_da_cat_comm_cod, ldw_a_cat_comm_cod
Datawindowchild ldw_da_cat_fisc_cod, ldw_a_cat_fisc_cod, ldw_titolo2, ldw_colore2
Datawindowchild ldw_da_tab_iva_cod, ldw_a_tab_iva_cod, ldw_titolo, ldw_colore


tab_distinta.tab_seleziona.dw_recuperati_lt.getchild("id_titolo",ldw_titolo)
ldw_titolo.settransobject(sqlca)
ldw_titolo.retrieve()

tab_distinta.tab_seleziona.dw_recuperati_lt.getchild("id_titolo",ldw_colore)
ldw_colore.settransobject(sqlca)
ldw_colore.retrieve()

tab_distinta.tab_seleziona.dw_selezionati_lt.getchild("id_titolo",ldw_titolo2)
ldw_titolo2.settransobject(sqlca)
ldw_titolo2.retrieve()

tab_distinta.tab_seleziona.dw_selezionati_lt.getchild("id_titolo",ldw_colore2)
ldw_colore2.settransobject(sqlca)
ldw_colore2.retrieve()




datawindowchild ldw_gruppo_art_cod, ldw_cat_comm_cod
datawindowchild ldw_cat_merc_cod, ldw_cat_fisc_cod
datawindowchild ldw_reparto, ldw_tab_iva_cod
datawindowchild ldw_unita_conf_cod
datawindowchild ldw_colore_cod
datawindowchild ldw_titolo_cod, ldw_titolo_part

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
idw_modifica.getchild("colore",ldw_colore_cod)
idw_modifica.getchild("titolo",ldw_titolo_cod)

idw_modifica.getchild("titolo_partenza",ldw_titolo_part)

ldw_titolo_part.settransobject(sqlca)
ldw_titolo_part.retrieve()

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

ldw_colore_cod.settransobject(sqlca)
ldw_colore_cod.retrieve()

ldw_titolo_cod.settransobject(sqlca)
ldw_titolo_cod.retrieve()

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
tab_distinta.tab_seleziona.dw_selezionati_lt.settransobject(sqlca)

ll_CurrRow = tab_distinta.tab_filtri.dw_filtro_ff.GetRow()
IF ll_CurrRow = 0 THEN tab_distinta.tab_filtri.dw_filtro_ff.InsertRow(0)

ll_CurrRow = tab_distinta.tab_modifiche.dw_modifiche_ff.GetRow()
IF ll_CurrRow = 0 THEN ll_CurrRow = tab_distinta.tab_modifiche.dw_modifiche_ff.InsertRow(1)

tab_distinta.tab_filtri.dw_filtro_ff.postevent("ue_post_open")
idw_target.postevent("ue_post_open")

tab_distinta.tab_filtri.dw_filtro_ff.SetFocus()

tab_distinta.tab_seleziona.dw_1.settransobject(sqlca)


end event

type cb_chiudi from commandbutton within w_orafo_var_tipo_articolo_cx
integer x = 1915
integer y = 28
integer width = 270
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;Close(Parent)
end event

type cb_crea from commandbutton within w_orafo_var_tipo_articolo_cx
integer x = 2240
integer y = 28
integer width = 270
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Crea"
end type

event clicked;long ll_val,ll_val2, ll_val_orig, ll_val_orig2, ll_riga, ll_conto, ll_null
string ls_codice,ls_precedente, ls_codice_orig, ls_codice2, ls_codice_orig2, ls_controllo, ls_fisso
integer li_pos

idec_calo=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemdecimal(1,"coef_calo")

ls_fisso=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemstring(1,"piu_cod")
if isnull(ls_fisso) then
	 messagebox('Attenzione!', 'Inserire prima la desinenza da associare al codice nella pagina MODIFICHE')
	 return 1
end if	 
tab_distinta.tab_modifiche.dw_modifiche_ff.accepttext()
ll_val2=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemnumber(1,"titolo")


ll_val=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemnumber(1,"colore")
ll_riga=tab_distinta.tab_seleziona.dw_selezionati_lt.rowcount()

ls_fisso=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemstring(1,"fisso")


       wf_tit_col(ll_val,ll_val2,ll_riga)
		 cb_salva.enabled=true




































end event

type tab_distinta from tab within w_orafo_var_tipo_articolo_cx
event create ( )
event destroy ( )
integer x = 27
integer y = 124
integer width = 2825
integer height = 1396
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
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
string ls_cod
long ll_titolo

if newindex=3 then
		long ll_Rows, ll_i, ll_CurrRow
		cb_crea.enabled=true
	
	
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
	String   ls_da_tab_iva,ls_a_tab_iva
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
	
	
	
	il_id_titolo=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemnumber(1, "titolo_partenza")
	
	if  isnull(il_id_titolo) then 
		Messagebox("Attenzione!", "Non è stato specificato alcun titolo di partenza")
		return
	else
		
	end if
	idec_cnv_coef=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemnumber(1, "cnv_coef")
	if  isnull(idec_cnv_coef) then 
		Messagebox("Attenzione!", "Non è stato specificato alcun coefficiente di conversione peso di partenza")
		return
	end if
	
	idw_source.retrieve(ls_da_articolo, ls_a_articolo)
	idw_source.setfocus()
	
	tab_distinta.tab_seleziona.dw_var_dati_artrec_ff.Retrieve(ls_da_articolo, ls_a_articolo)
	tab_distinta.tab_seleziona.st_4.text=string(0)
	lt_fine_retrieve = Now()
else
	cb_crea.enabled=false
	
end if
if newindex=2 then
	ll_titolo=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemnumber(1, "titolo_partenza")
	if isnull(ll_titolo) then
		ls_cod=tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_articolo_cod")
		select id_titolo
		into :ll_titolo
		from articolo
		where codice=:ls_cod;
		tab_distinta.tab_modifiche.dw_modifiche_ff.setitem(1, "titolo_partenza", ll_titolo)
		
	end if
end if

end event

type tab_filtri from userobject within tab_distinta
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2789
integer height = 1276
long backcolor = 79741120
string text = "Filtra"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
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
integer x = 14
integer y = 20
integer width = 2743
integer height = 1124
integer taborder = 2
boolean titlebar = true
string title = "Filtro Articoli/Unità Confezione"
string dataobject = "d_orafo_var_tipo_articolo_ff"
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
		ls_dwc[1] = "da_fornitore_cod"
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
		ls_dwc[1] = "da_fornitore_cod"
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
		ls_dwc[1] = "a_fornitore_cod"
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
		ls_dwc[1] = "a_fornitore_cod"
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
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "da_produttore"
		ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 1, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_produttore_des")) or This.GetItemString(1, "a_produttore_des")='' then
            This.SetItem(1, "a_produttore_des", Data)			
	      end if
			RETURN 2
		END IF				
	CASE 'a_produttore_des'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "a_produttore"
		ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 1, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
END CHOOSE

end event

event ue_init;call super::ue_init;is_colonne_drop[1]  = "id_tipo_pagamento_cod"
is_colonne_drop[2]  = "id_tipo_pagamento_des"
is_colonne_drop[3]  = "id_banca_azienda"
is_colonne_drop[4]  = "id_banca_azienda_pres"
end event

event ue_setup_filter;call super::ue_setup_filter;
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
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

type tab_modifiche from userobject within tab_distinta
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2789
integer height = 1276
long backcolor = 79741120
string text = "Modifica"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_modifiche_ff dw_modifiche_ff
cb_cnv cb_cnv
end type

on tab_modifiche.create
this.dw_modifiche_ff=create dw_modifiche_ff
this.cb_cnv=create cb_cnv
this.Control[]={this.dw_modifiche_ff,&
this.cb_cnv}
end on

on tab_modifiche.destroy
destroy(this.dw_modifiche_ff)
destroy(this.cb_cnv)
end on

type dw_modifiche_ff from u_dw_ext_main within tab_modifiche
integer x = 18
integer y = 56
integer width = 2743
integer height = 1208
integer taborder = 2
boolean titlebar = true
string title = "Modifiche da apportare"
string dataobject = "d_orafo_var_tipo_articoli_ext"
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

event itemchanged;long ll_colore, ll_titolo, ll_titolo_part
string ls_titolo
DECIMAL LD_coef_cnv, ld_coef_calo
DECIMAL{2} ll_coef_max, ll_coef_min, ll_coef_calo
integer li_ret



if dwo.name="colore" then
	  ll_titolo=this.getitemnumber(1,"titolo")
	  if not isnull(data) then
	     if isnull(ll_titolo) or (ll_titolo=0) then
		        this.setitem(1,"fisso",'_')
	     else	  
	           this.setitem(1,"fisso",'_')
	     end if
      			
    else	  
    if isnull(ll_titolo) or (ll_titolo=0) then
		        this.setitem(1,"fisso",'')
	     else	  
	           this.setitem(1,"fisso",'_')
				  
    end if
  end if
end if

if dwo.name="titolo" then
	  ll_colore=this.getitemnumber(1,"colore")
	  if not isnull(data) then
	     if not isnull(ll_colore) or (ll_colore<>0) then
		        this.setitem(1,"fisso",'_')
	     else	  
	           this.setitem(1,"fisso",'_')
	     end if
		else	  
         if not isnull(ll_colore)  or (ll_colore<>0)  then
		        this.setitem(1,"fisso",'_')
	     else	  
	           this.setitem(1,"fisso",'')

	end if
 end if
end if     

if dwo.name="titolo" then
	
	ll_titolo_part=getitemnumber(1,"titolo_partenza")
	if ll_titolo_part>0 then
		ll_titolo=long(data)
		select coef_cnv, coef_calo
		into :LD_coef_cnv, :ld_coef_calo
		from duplica_articoli
		where da_titolo=:ll_titolo_part
		and a_titolo=:ll_titolo;
		if isnull(LD_coef_cnv) then LD_coef_cnv=1
		setitem(row, "cnv_coef", LD_coef_cnv) 
		setitem(row, "coef_calo", ld_coef_calo) 
		
end if
	
end if

if dwo.name='coef_calo' then
	
	
	ll_titolo=getitemnumber(1, "titolo")
	LD_coef_cnv=getitemdecimal(1, "coef_calo") 
	SELECT orafo_titolo.coef_calo_massimo, orafo_titolo.coef_calo_minimo
		INTO :ll_coef_max, :ll_coef_min
		FROM orafo_titolo
		WHERE orafo_titolo.id_titolo = :ll_titolo;
		IF ll_coef_max>0 and not isnull(ll_coef_max) THEN
			
			ll_coef_calo=dec(data)
			IF not((ll_coef_calo>=ll_coef_min)and(ll_coef_calo<=ll_coef_max)) THEN
				li_ret=messagebox("Coefficiente di calo non valido","Il coefficiente deve esser compreso tra "+&
				+string(ll_coef_min)+" e "+string(ll_coef_max)+"~r~nVuoi assegnarlo lo stesso?",  stopsign!, yesno!)
				if li_ret=1 then 
					
				else
				
					post setitem(1, "coef_calo", LD_coef_cnv)
				end if
			END IF
		END IF
end if
																	
end event

type cb_cnv from commandbutton within tab_modifiche
integer x = 1888
integer y = 184
integer width = 841
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Modifica Coefficienti di Conversione"
end type

event clicked;open(w_duplica_articoli_gd)
end event

type tab_seleziona from userobject within tab_distinta
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2789
integer height = 1276
long backcolor = 79741120
string text = " Articoli da variare"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
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
this.Control[]={this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_recuperati_lt,&
this.st_4,&
this.dw_selezionati_lt,&
this.st_3,&
this.dw_var_dati_artrec_ff,&
this.dw_1}
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
end on

type cb_drop_all from commandbutton within tab_seleziona
integer x = 1271
integer y = 280
integer width = 229
integer height = 92
integer taborder = 14
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
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

dw_selezionati_lt.setsort("articolo_codice A")
dw_selezionati_lt.sort()


end event

type cb_drop_many from commandbutton within tab_seleziona
integer x = 1271
integer y = 400
integer width = 229
integer height = 92
integer taborder = 13
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
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


dw_selezionati_lt.setsort("articolo_codice A")
dw_selezionati_lt.sort()
end event

type cb_remove_many from commandbutton within tab_seleziona
integer x = 1271
integer y = 584
integer width = 229
integer height = 92
integer taborder = 12
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
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
integer x = 1271
integer y = 716
integer width = 229
integer height = 92
integer taborder = 11
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
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
integer x = 18
integer y = 48
integer width = 1225
integer height = 1072
boolean titlebar = true
string title = "Ricercati"
string dataobject = "d_orafo_var_articoli_lt"
boolean hscrollbar = true
boolean vscrollbar = true
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
String Ls_SQLSyntax

ls_SQLSyntax=SQLSyntax + 'AND articolo.id_titolo='+string(il_id_titolo)

If is_filter <> "" Then
	ls_SQLSyntax = SQLSyntax + 'AND ' + is_filter + ' ORDER BY articolo.codice'
	
End If

This.SetSQLPreview(ls_SQLSyntax)
end event

type st_4 from statictext within tab_seleziona
integer x = 2514
integer y = 1148
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "0"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_selezionati_lt from u_dw_pura within tab_seleziona
integer x = 1531
integer y = 48
integer width = 1225
integer height = 1080
integer taborder = 2
boolean titlebar = true
string title = "Selezionati"
string dataobject = "d_orafo_var_articoli_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;wf_selezione(row,this,"",this,"","")

end event

type st_3 from statictext within tab_seleziona
integer x = 2011
integer y = 1152
integer width = 485
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Articoli da variare"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_var_dati_artrec_ff from u_dw_pura within tab_seleziona
integer x = 59
integer y = 1148
integer width = 1125
integer height = 96
integer taborder = 2
boolean bringtotop = true
string dataobject = "d_orafo_var_tipo_artrec_ff"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event sqlpreview;call super::sqlpreview;
If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + 'AND ' + is_filter
	This.SetSQLPreview(ls_SQLSyntax)
End If


end event

type dw_1 from datawindow within tab_seleziona
boolean visible = false
integer x = 1289
integer y = 872
integer width = 174
integer height = 152
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_orafo_duplica_unita_confezione"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrievestart;return 2
end event

type cb_1 from commandbutton within w_orafo_var_tipo_articolo_cx
integer x = 2587
integer y = 28
integer width = 270
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Cancella"
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
End If
end event

type cb_salva from commandbutton within w_orafo_var_tipo_articolo_cx
integer x = 1618
integer y = 28
integer width = 251
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Salva"
end type

event clicked;integer i, a
long ll_id_articolo, ll_null, ll_riga_Corrente,ll_id_art_padre,ll_id_dis
setnull(ll_null)
string ls_suffisso, ls_cod_articolo, ls_cod_art_padre
integer li_lung_suffisso, li_ret
datetime ldt_datatime
sqlca.triggers_on_off('OFF')


i=tab_distinta.tab_seleziona.dw_selezionati_lt.update()

if i<>1 then 
	messagebox("Errore!", "Articolo non salvato")
	rollback;
	sqlca.triggers_on_off('ONN')
	return
else
	commit;
end if

sqlca.triggers_on_off('ONN')

tab_distinta.tab_seleziona.dw_1.reset()

ls_suffisso=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemstring(1, "fisso")
ls_suffisso+=tab_distinta.tab_modifiche.dw_modifiche_ff.getitemstring(1, "piu_cod")
li_lung_suffisso=len(ls_suffisso)

for i=1 to tab_distinta.tab_seleziona.dw_selezionati_lt.rowcount()
	ll_id_articolo= tab_distinta.tab_seleziona.dw_selezionati_lt.getitemnumber(i, "id_articolo")
	tab_distinta.tab_seleziona.dw_1.retrieve(id_u_c[i])
	ll_riga_corrente=tab_distinta.tab_seleziona.dw_1.rowcount()
	tab_distinta.tab_seleziona.dw_1.setitem(ll_riga_corrente, "id_unita_confezione", ll_null)
	tab_distinta.tab_seleziona.dw_1.setitem(ll_riga_corrente, "id_articolo", ll_id_articolo)
	
	tab_distinta.tab_seleziona.dw_1.setitem(ll_riga_corrente, "peso_netto", idec_peso[i]*idec_cnv_coef)
	tab_distinta.tab_seleziona.dw_1.setitem(ll_riga_corrente, "conv_misura_peso", idec_misura[i]*idec_cnv_coef)
	tab_distinta.tab_seleziona.dw_1.setitemstatus(i, 0, primary!,newmodified!)
	
	
	ls_cod_articolo =	tab_distinta.tab_seleziona.dw_selezionati_lt.getitemstring(i,"articolo_codice")
	ls_cod_art_padre = left(ls_cod_articolo, len(ls_cod_articolo) - li_lung_suffisso)
	select id_articolo
	into :ll_id_art_padre
	from articolo
	where codice=:ls_cod_art_padre;
	if sqlca.sqlcode=0 then
		datastore ds_duplica_classe
		ds_duplica_classe=create datastore
		ds_duplica_classe.dataobject="d_cl_art_duplica"
		ds_duplica_classe.settransobject(sqlca)
		li_ret=ds_duplica_classe.retrieve(ll_id_art_padre)
		for a=1 to li_ret
			ds_duplica_classe.setitem(a, "id_articolo",ll_id_articolo) 
			ds_duplica_classe.setitemstatus(a, 0, primary!,newmodified!)
		next
		
		if li_ret>0 then
			if ds_duplica_classe.update()= 1 then
				commit;
			else
				rollback;
				messagebox("Errore!", "Classi articolo "+ls_cod_articolo+" Non salvate!")
			end if
		end if
		select id_distinta 
		into :ll_id_dis
		from distinta
		where id_articolo=:ll_id_articolo;
				
		ds_duplica_classe.dataobject="ds_riga_dis_duplica"
		ds_duplica_classe.settransobject(sqlca)
		li_ret=ds_duplica_classe.retrieve(ll_id_art_padre)
		if li_ret>0 then
			if isnull(ll_id_dis) or ll_id_dis=0 then
				ldt_datatime=datetime(today(), now())
				insert into distinta (codice, id_articolo, data_ora_creazione, 
				data_ora_ult_cambiamento, tipo_applicazione)
				values(:ls_cod_articolo,:ll_id_articolo, :ldt_datatime, 
				:ldt_datatime, 'V')
				;
				if sqlca.sqlcode=0 then 
					commit;
					select id_distinta 
					into :ll_id_dis
					from distinta
					where id_articolo=:ll_id_articolo;
				else
					rollback;
					messagebox("Errore!", "Distinta articolo "+ls_cod_articolo+" non inserita!")
				end if
			end if
			
			for a=1 to li_ret
				ds_duplica_classe.setitem(a, "id_distinta", ll_id_dis)
				ds_duplica_classe.setitemstatus(a, 0, primary!,newmodified!)
			next
			if ds_duplica_classe.update()= 1 then
				commit;
			else
				rollback;
				messagebox("Errore!", "Distinta articolo "+ls_cod_articolo+" Non salvata!")
			end if
		end if
	else
		
	end if
	
	
	
		
	
next

tab_distinta.tab_seleziona.dw_1.post update()

if isvalid(ds_duplica_classe) then destroy(ds_duplica_classe)

cb_salva.enabled=false

end event

