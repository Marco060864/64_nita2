forward
global type w_canc_documenti2_cx from w_wiz_main
end type
type cb_chiudi from commandbutton within w_canc_documenti2_cx
end type
type cb_crea from commandbutton within w_canc_documenti2_cx
end type
type tab_distinta from tab within w_canc_documenti2_cx
end type
type tab_filtri from userobject within tab_distinta
end type
type dw_filtro_ff from u_dw_ext_main within tab_filtri
end type
type dw_1 from u_dw_ext_main within tab_filtri
end type
type tab_filtri from userobject within tab_distinta
dw_filtro_ff dw_filtro_ff
dw_1 dw_1
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
type st_1 from statictext within tab_seleziona
end type
type st_2 from statictext within tab_seleziona
end type
type dw_recuperati_lt from u_dw_pura within tab_seleziona
end type
type st_4 from statictext within tab_seleziona
end type
type dw_selezionati_lt from u_dw_pura within tab_seleziona
end type
type st_3 from statictext within tab_seleziona
end type
type tab_seleziona from userobject within tab_distinta
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
st_1 st_1
st_2 st_2
dw_recuperati_lt dw_recuperati_lt
st_4 st_4
dw_selezionati_lt dw_selezionati_lt
st_3 st_3
end type
type tab_distinta from tab within w_canc_documenti2_cx
tab_filtri tab_filtri
tab_seleziona tab_seleziona
end type
type cb_stampa from commandbutton within w_canc_documenti2_cx
end type
end forward

global type w_canc_documenti2_cx from w_wiz_main
integer x = 425
integer y = 348
integer width = 3250
integer height = 2156
string title = "Cancellazione Documenti"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_chiudi cb_chiudi
cb_crea cb_crea
tab_distinta tab_distinta
cb_stampa cb_stampa
end type
global w_canc_documenti2_cx w_canc_documenti2_cx

type variables
DataWindow idw_source, idw_target,idw_modifica
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
Decimal idc_imp_max_distinta
s_distinta is_distinta
char ic_tipo_scadenza
long il_id_banca_azienda, il_id_dis_banca

w_wait_01	iw_wait
string		is_sql, is_filtro 
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
public subroutine wf_ges_errore (string prof_doc, string tabella, long num_prog, date data_reg, string errore)
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

public subroutine wf_ges_errore (string prof_doc, string tabella, long num_prog, date data_reg, string errore);long ll_riga
ll_riga=tab_distinta.tab_filtri.dw_1.insertrow(0)
tab_distinta.tab_filtri.dw_1.setitem(ll_riga, "prof_documento", prof_doc)
tab_distinta.tab_filtri.dw_1.setitem(ll_riga, "tabella", tabella)
tab_distinta.tab_filtri.dw_1.setitem(ll_riga, "num_progressivo", num_prog)
tab_distinta.tab_filtri.dw_1.setitem(ll_riga, "data_registrazione", data_reg)
tab_distinta.tab_filtri.dw_1.setitem(ll_riga, "Errore", errore)

end subroutine

on w_canc_documenti2_cx.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.cb_crea=create cb_crea
this.tab_distinta=create tab_distinta
this.cb_stampa=create cb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.cb_crea
this.Control[iCurrent+3]=this.tab_distinta
this.Control[iCurrent+4]=this.cb_stampa
end on

on w_canc_documenti2_cx.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_crea)
destroy(this.tab_distinta)
destroy(this.cb_stampa)
end on

event open;call super::open;
long ll_CurrRow

ib_removing = FALSE

idw_source = tab_distinta.tab_seleziona.dw_recuperati_lt
idw_target = tab_distinta.tab_seleziona.dw_selezionati_lt

idw_source.SetTransObject(SQLCA)

ll_CurrRow = tab_distinta.tab_filtri.dw_filtro_ff.GetRow()
IF ll_CurrRow = 0 THEN tab_distinta.tab_filtri.dw_filtro_ff.InsertRow(0)

tab_distinta.tab_filtri.dw_filtro_ff.postevent("ue_post_open")
idw_target.postevent("ue_post_open")

tab_distinta.tab_filtri.dw_filtro_ff.SetFocus()



end event

type cb_chiudi from commandbutton within w_canc_documenti2_cx
integer x = 2944
integer y = 24
integer width = 265
integer height = 92
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

type cb_crea from commandbutton within w_canc_documenti2_cx
integer x = 2533
integer y = 24
integer width = 361
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_sel,ll_id_documento,ll_retval,ret,ll_row,i
long ll_riga_da_Cancellare
string ls_flag
s_par_record lstr_par_documento
ll_riga_sel=idw_target.getselectedrow(0)
ret=idw_target.getselectedrow(0)
ll_row=idw_target.rowcount()

integer 	li_lotti
string	ls_p_codice
date		ldt_data_reg
decimal	ld_num_progressivo

li_lotti = 0

SELECT	count(*)
INTO	  	:li_lotti
FROM		riga_doc_lotto
;

ret=messagebox("Ultimo Avviso","Vuoi proseguire con la cancellazione?",question!,yesno!)

if ret=1 then
	
	if (li_lotti = 0) then
		open(iw_wait,"w_wait_01")
		iw_wait.st_wait.text = "Cancellazione del documento ..."
	end if
	
	ll_riga_da_Cancellare=1
	for i=1 to ll_row
		
		
		
		ll_id_documento=idw_target.getitemnumber(ll_riga_da_Cancellare,"documento_id_documento")
		
		if (li_lotti > 0) then  		
			lstr_par_documento.nome_tabella="documento" 
			lstr_par_documento.nome_id_tabella="id_documento"
			lstr_par_documento.id_tabella=ll_id_documento
			lstr_par_documento.visible=false
			openwithparm(w_utl_cancella_documento_wz,lstr_par_documento)
			ll_retval=message.doubleparm
			
			if ll_retval<>1 then
				ls_flag='N'
			else
				ls_flag='S'
			end if
			
			
		else
		
			SELECT	p.codice, d.data_registrazione, d.num_progressivo
			INTO		:ls_p_codice, :ldt_data_reg, :ld_num_progressivo
			FROM		prof_documento p, documento d
			WHERE		d.id_documento = :ll_id_documento
			AND		p.id_prof_documento = d.id_prof_documento;
			
			iw_wait.st_wait_b.text = "Prof.:" + ls_p_codice + &
								" Prot.:" + string(ld_num_progressivo) + &
								" del:" + string(ldt_data_reg, 'dd/mm/yy')
	
			
			DELETE FROM spesa_documento
			WHERE	 id_documento = :ll_id_documento;
			if (sqlca.sqlcode = -1) then
				
				wf_ges_errore(ls_p_codice ,"spesa_documento",ld_num_progressivo, ldt_data_reg, sqlca.sqlerrtext)
								
				ROLLBACK;
				ls_flag='N'
				
				ll_riga_da_Cancellare++
				continue
			end if
	
			
			DELETE FROM scadenza
			WHERE	 id_documento = :ll_id_documento;
			if (sqlca.sqlcode = -1) then
				wf_ges_errore(ls_p_codice ,"scadenza",ld_num_progressivo, ldt_data_reg, sqlca.sqlerrtext)				
				ROLLBACK;
				ls_flag='N'
				
				ll_riga_da_Cancellare++
				continue
			end if
			
			
			DELETE FROM cast_cpt_documento
			WHERE	 id_documento = :ll_id_documento;
			if (sqlca.sqlcode = -1) then
				wf_ges_errore(ls_p_codice ,"cast_cpt_documento",ld_num_progressivo, ldt_data_reg, sqlca.sqlerrtext)					
				ROLLBACK;
				ls_flag='N'
				
				ll_riga_da_Cancellare++
				continue
			end if		
			
			
			DELETE FROM cast_iva_documento
			WHERE	 id_documento = :ll_id_documento;
			if (sqlca.sqlcode = -1) then
				wf_ges_errore(ls_p_codice ,"cast_iva_documento",ld_num_progressivo, ldt_data_reg, sqlca.sqlerrtext)					
				ROLLBACK;
				ls_flag='N'
				
				ll_riga_da_Cancellare++
				continue
			end if				
			
			
			DELETE FROM riga_documento
			WHERE	 id_documento = :ll_id_documento;
			if (sqlca.sqlcode = -1) then
				wf_ges_errore(ls_p_codice ,"riga_documento",ld_num_progressivo, ldt_data_reg, sqlca.sqlerrtext)					
				ROLLBACK;
				ls_flag='N'
				
				ll_riga_da_Cancellare++
				continue
			end if		
			
			
			DELETE FROM documento
			WHERE	 id_documento = :ll_id_documento;
			if (sqlca.sqlcode = -1) then
				wf_ges_errore(ls_p_codice ,"documento",ld_num_progressivo, ldt_data_reg, sqlca.sqlerrtext)
				ROLLBACK;
				ls_flag='N'
				
				ll_riga_da_Cancellare++
				continue
			end if		
			
			COMMIT;
			
			if (sqlca.sqlcode = -1) then
				messagebox("cancellazione documento:" + &
								ls_p_codice + "  " + &
								string(ld_num_progressivo) + &
								" del "+string(ldt_data_reg, 'dd/mm/yy'), sqlca.sqlerrtext)
				
				ll_riga_da_Cancellare++
			else 
				idw_target.deleterow(ll_riga_da_Cancellare)				
			end if
		
		end if
	next
	
	
	if (li_lotti = 0) then
		close(iw_wait)
	end if
	
	
	if ls_flag='N' then
		messagebox("Utility","La cancellazione non è riuscita perfettamente")
	else
		messagebox("Utility","La cancellazione è stata eseguita correttamente")
		
		tab_distinta.trigger event clicked(2)
		tab_distinta.tab_seleziona.st_4.text=string(idw_target.rowcount())
	end if
end if













end event

type tab_distinta from tab within w_canc_documenti2_cx
event create ( )
event destroy ( )
integer x = 23
integer y = 36
integer width = 3200
integer height = 1992
integer taborder = 30
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
tab_seleziona tab_seleziona
end type

on tab_distinta.create
this.tab_filtri=create tab_filtri
this.tab_seleziona=create tab_seleziona
this.Control[]={this.tab_filtri,&
this.tab_seleziona}
end on

on tab_distinta.destroy
destroy(this.tab_filtri)
destroy(this.tab_seleziona)
end on

event selectionchanged;if newindex=2 then
	long ll_Rows, ll_i, ll_CurrRow


ll_Rows = idw_target.RowCount()

ib_removing = TRUE
idw_target.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	idw_target.rowsmove(ll_i,ll_i,primary!,idw_source,1,primary!)
NEXT


ib_removing = FALSE
	tab_distinta.tab_seleziona.st_1.text=string(idw_source.rowcount())
	
	idw_source.Sort()


end if
end event

event clicked;
if (index = 2) then
	tab_distinta.tab_filtri.dw_filtro_ff.Event ue_Setup_Filter()
	
	
	string	ls_sort
	idw_source.retrieve()
	ls_sort = "prof_documento_codice A, registro_tipo_registro A, documento_data_documento A, documento_num_documento A"
	idw_source.setsort(ls_sort)
	idw_source.sort()
end if
end event

type tab_filtri from userobject within tab_distinta
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 3163
integer height = 1872
long backcolor = 79741120
string text = "Filtra"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_filtro_ff dw_filtro_ff
dw_1 dw_1
end type

on tab_filtri.create
this.dw_filtro_ff=create dw_filtro_ff
this.dw_1=create dw_1
this.Control[]={this.dw_filtro_ff,&
this.dw_1}
end on

on tab_filtri.destroy
destroy(this.dw_filtro_ff)
destroy(this.dw_1)
end on

type dw_filtro_ff from u_dw_ext_main within tab_filtri
event ue_setup_filter ( )
integer x = 23
integer y = 8
integer width = 3122
integer height = 484
integer taborder = 2
boolean titlebar = true
string title = "Filtro"
string dataobject = "d_utl_canc_doc2_ff"
end type

event ue_setup_filter;


date ld_da_data_reg,ld_a_data_reg 
string ls_filtro,ls_da_profilo,ls_a_profilo
integer ret
long ll_da_prot,ll_a_prot

this.accepttext()

ld_da_data_reg=this.getitemdate(1,"da_data_reg")
ld_a_data_reg=this.getitemdate(1,"a_data_reg")
ll_da_prot=this.getitemnumber(1,"da_protocollo")
ll_a_prot=this.getitemnumber(1,"a_protocollo")
ls_da_profilo=upper(this.getitemstring(1,"da_profilo"))
ls_a_profilo=upper(this.getitemstring(1,"a_profilo"))

if ld_da_data_reg>ld_a_data_reg then
	messagebox("Utility","La data di registrazione iniziale è più grande di quella finale")
else
	if ll_da_prot>ll_a_prot then
		messagebox("Utility","Il numero di protocollo iniziale è più grande di quello finale")	
	else
		if ls_da_profilo>ls_a_profilo then
			messagebox("Utility","Il profilo iniziale è più grande di quello finale")

		else
			
			
			if ls_da_profilo <> '' and ls_filtro='' then
				ls_filtro = " and prof_documento.codice >= '" + string(ls_da_profilo) + "'"
			end if

			
			if ls_a_profilo<>''and ls_filtro='' then
				ls_filtro='prof_documento.codice<='+'"'+string(ls_a_profilo)+'"'
			elseif ls_a_profilo<>''and ls_filtro<>'' then
				ls_filtro=ls_filtro + " and prof_documento.codice <= '" + string(ls_a_profilo) + "'"
			end if

			
			if not isnull(ld_da_data_reg) and (ls_filtro='') then
				ls_filtro = "and documento.data_registrazione >= '" + string(ld_da_data_reg, 'yyyy/mm/dd') + "'"
			elseif not isnull(ld_da_data_reg)and ls_filtro<>'' then
				
				
				ls_filtro=ls_filtro + " and documento.data_registrazione >= '" + string(ld_da_data_reg, 'yyyy/mm/dd') + "'"
			end if

			
			if not isnull(ld_a_data_reg)and ls_filtro='' then
				ls_filtro = "and documento.data_registrazione <= '" + string(ld_a_data_reg, 'yyyy/mm/dd') + "'"
			elseif not isnull(ld_a_data_reg)and ls_filtro<>'' then
				ls_filtro = ls_filtro + " and documento.data_registrazione <= '" + string(ld_a_data_reg, 'yyyy/mm/dd') + "'"
			end if

			
			if not isnull(ll_da_prot)and ls_filtro='' then
				ls_filtro = "and documento.num_progressivo >= " + string(ll_da_prot)
			elseif not isnull(ll_da_prot)and ls_filtro<>'' then
				ls_filtro=ls_filtro + " and documento.num_progressivo >= " + string(ll_da_prot)
			end if

			
			if not isnull(ll_a_prot)and ls_filtro='' then
				ls_filtro = "and documento.num_progressivo <= " + string(ll_a_prot)
			elseif not isnull(ll_a_prot)and ls_filtro<>'' then
				ls_filtro = ls_filtro + " and documento.num_progressivo <= " + string(ll_a_prot)
			end if
			
			is_filtro = ls_filtro

		end if
	end if
end if
	
end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_profilo"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_codice"
	
	CASE "a_profilo"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_codice"
	
	END CHOOSE		
end event

event ue_use_search;CHOOSE CASE as_nomecol
	case "da_profilo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			if isnull(This.GetItemstring(1, "a_profilo")) or This.GetItemstring(1, "a_profilo")='' then
			     uf_set_colval("a_profilo",is_ricpar.s_main_value)
			end if	  
	case "a_profilo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
END CHOOSE
end event

event ue_itemerror;long ll_null
setnull(ll_null)
return ll_null
end event

type dw_1 from u_dw_ext_main within tab_filtri
integer x = 23
integer y = 500
integer width = 3118
integer height = 796
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Documenti non Cancellati"
string dataobject = "d_canc_doc_errori_rpt"
boolean vscrollbar = true
end type

type tab_seleziona from userobject within tab_distinta
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 3163
integer height = 1872
long backcolor = 79741120
string text = "Documenti da Cancellare"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
st_1 st_1
st_2 st_2
dw_recuperati_lt dw_recuperati_lt
st_4 st_4
dw_selezionati_lt dw_selezionati_lt
st_3 st_3
end type

on tab_seleziona.create
this.cb_drop_all=create cb_drop_all
this.cb_drop_many=create cb_drop_many
this.cb_remove_many=create cb_remove_many
this.cb_remove_all=create cb_remove_all
this.st_1=create st_1
this.st_2=create st_2
this.dw_recuperati_lt=create dw_recuperati_lt
this.st_4=create st_4
this.dw_selezionati_lt=create dw_selezionati_lt
this.st_3=create st_3
this.Control[]={this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.st_1,&
this.st_2,&
this.dw_recuperati_lt,&
this.st_4,&
this.dw_selezionati_lt,&
this.st_3}
end on

on tab_seleziona.destroy
destroy(this.cb_drop_all)
destroy(this.cb_drop_many)
destroy(this.cb_remove_many)
destroy(this.cb_remove_all)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_recuperati_lt)
destroy(this.st_4)
destroy(this.dw_selezionati_lt)
destroy(this.st_3)
end on

type cb_drop_all from commandbutton within tab_seleziona
integer x = 1472
integer y = 300
integer width = 242
integer height = 84
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

ll_Rows = idw_source.RowCount()

ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
			idw_source.rowsmove(ll_i,ll_i,primary!,idw_target,1,primary!)
		contatore=contatore+1
		idw_target.selectrow(contatore,true)
NEXT

idw_target.Sort()

ib_removing = FALSE

dw_selezionati_lt.setfocus()
end event

type cb_drop_many from commandbutton within tab_seleziona
integer x = 1472
integer y = 420
integer width = 242
integer height = 84
integer taborder = 13
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;long ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo
long contatore

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

idw_target.Sort()

ib_removing = FALSE

dw_selezionati_lt.setfocus()
end event

type cb_remove_many from commandbutton within tab_seleziona
integer x = 1472
integer y = 640
integer width = 242
integer height = 84
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
integer x = 1472
integer y = 756
integer width = 242
integer height = 84
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

type st_1 from statictext within tab_seleziona
integer x = 562
integer y = 1196
integer width = 242
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within tab_seleziona
integer x = 242
integer y = 1196
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Recuperati:"
boolean focusrectangle = false
end type

type dw_recuperati_lt from u_dw_pura within tab_seleziona
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
integer x = 46
integer y = 48
integer width = 1321
integer height = 1060
boolean titlebar = true
string title = "Disponibili"
string dataobject = "d_documento_descr_lt"
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
string	ls_sql
integer	li_pos

if (not isnull(is_filtro)) then
	if (isnull(is_sql) or is_sql = "") then 
		is_sql = sqlsyntax 
		li_pos = pos(is_sql, "ORDER")
		is_sql = left(is_sql, li_pos - 1)
	end if
	
	ls_sql = is_sql + is_filtro
	
	setsqlpreview(ls_sql)
end if
end event

type st_4 from statictext within tab_seleziona
integer x = 2240
integer y = 1188
integer width = 242
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
integer x = 1815
integer y = 52
integer width = 1321
integer height = 1060
integer taborder = 2
boolean titlebar = true
string title = "Selezionati"
string dataobject = "d_documento_descr_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;wf_selezione(row,this,"",this,"","")


end event

event getfocus;call super::getfocus;long i,contatore
contatore=dw_selezionati_lt.rowcount()
	

st_4.text=string(contatore)
end event

event losefocus;call super::losefocus;long i,contatore
contatore=dw_selezionati_lt.rowcount()
	

st_4.text=string(contatore)
end event

type st_3 from statictext within tab_seleziona
integer x = 2496
integer y = 1188
integer width = 622
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Documenti da cancellare"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_stampa from commandbutton within w_canc_documenti2_cx
integer x = 969
integer y = 24
integer width = 649
integer height = 92
integer taborder = 12
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa Doc. Non Cancellati"
end type

event clicked;integer li_ret
tab_distinta.tab_filtri.dw_1.object.datawindow.print.Preview='yes'
tab_distinta.tab_filtri.dw_1.object.datawindow.print.Preview.Rulers='yes'
li_ret=printsetup()
if li_ret=1 then
	tab_distinta.tab_filtri.dw_1.print()
end if
end event

