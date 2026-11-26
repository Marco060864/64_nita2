forward
global type w_agg_prog_lotti_wz from w_wiz_main
end type
type cb_esci from commandbutton within w_agg_prog_lotti_wz
end type
type cb_chiudi from commandbutton within w_agg_prog_lotti_wz
end type
type tab_distinta from tab within w_agg_prog_lotti_wz
end type
type tab_filtri from userobject within tab_distinta
end type
type dw_filtro_ff from u_dw_ext_main within tab_filtri
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
type st_1 from statictext within tab_seleziona
end type
type tab_filtri from userobject within tab_distinta
dw_filtro_ff dw_filtro_ff
end type
type tab_seleziona from userobject within tab_distinta
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_recuperati_lt dw_recuperati_lt
st_4 st_4
dw_selezionati_lt dw_selezionati_lt
st_1 st_1
end type
type tab_distinta from tab within w_agg_prog_lotti_wz
tab_filtri tab_filtri
tab_seleziona tab_seleziona
end type
end forward

global type w_agg_prog_lotti_wz from w_wiz_main
int X=421
int Y=348
int Width=3301
int Height=1616
WindowType WindowType=response!
boolean TitleBar=true
string Title="Aggiorna progressivi lotti dai movimenti di magazzino"
long BackColor=80263581
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_esci cb_esci
cb_chiudi cb_chiudi
tab_distinta tab_distinta
end type
global w_agg_prog_lotti_wz w_agg_prog_lotti_wz

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
public subroutine wf_genera_doc (long al_id_prof_documento)
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

public subroutine wf_genera_doc (long al_id_prof_documento);
long 		ll_id_sog_comm_prop, ll_id_magazzino_1_prop, ll_id_magazzino_2_prop
long		ll_id_valuta_prop, ll_id_locazione_1_prop, ll_id_locazione_2_prop
long		ll_id_caus_magazzino_prop, id_mod_registro_prop
long		ll_id_documento, ll_id_r_lotto
long		ll_id_articolo, ll_id_unita_confezione
string	ls_des_articolo, ls_tipo_lotto
decimal{0}	ll_num_prog
long		ll_id_tab_iva, ll_id_tab_iva_2
decimal	ld_quantita, ld_peso_netto, ld_peso_rimanenza
long		ll_id_riga_documento, ll_id_registro, ll_id_mod_registro_prop, ll_id_lotto
integer	li_i, li_rows

li_rows = idw_target.rowcount()

if (li_rows <= 0) then return

SELECT	id_sog_comm_prop, id_valuta_prop, id_locazione_1_prop, 
			id_caus_magazzino_prop, id_mod_registro_prop
INTO		:ll_id_sog_comm_prop, :ll_id_valuta_prop, :ll_id_locazione_1_prop, 
			:ll_id_caus_magazzino_prop, :ll_id_mod_registro_prop
FROM	 	prof_documento
WHERE  	id_prof_documento = :al_id_prof_documento
;

if (SQLCA.SQLCODE = -1) then 
	messagebox("DBError", SQLCA.SQLERRTEXT)
	return
end if

if (isnull(ll_id_sog_comm_prop) or isnull(ll_id_valuta_prop) or &
	 isnull(ll_id_locazione_1_prop) or isnull(ll_id_caus_magazzino_prop) or &
	 isnull(ll_id_mod_registro_prop)) then

	 messagebox("Attenzione", "Nel Prof.Documento devono essere indicati i seguenti valori: ~n . Intestatario~n . Magazzino/Locazione 1~n . Valuta ~n . Causale di Magazzino ~n . Registro")
	 return
end if

SELECT Max(r.id_registro)
INTO 	 :ll_id_registro  
FROM   registro r, esercizio e
WHERE  e.data_inizio <= TODAY(*)
AND	 (e.data_fine >= TODAY(*) OR data_fine IS NULL)
AND	 r.id_esercizio = e.id_esercizio 
AND  	 r.id_mod_registro = :ll_id_mod_registro_prop
;

if (SQLCA.SQLCODE = -1) then 
	messagebox("DBError", SQLCA.SQLERRTEXT)
	return
end if

if (isnull(ll_id_registro)) then
	messagebox("Attenzione", "Non è stato recuperato il registro del profilo indicato ...")
	return
end if

for li_i = 1 to li_rows
	ld_peso_rimanenza = idw_target.GetItemNumber(li_i, "esi_fiscale")

	SELECT	MAX(num_progressivo)
	INTO	   :ll_num_prog
	FROM		documento
	WHERE		id_prof_documento = :al_id_prof_documento
	AND		id_registro = :ll_id_registro
	;

	if (SQLCA.SQLCODE = -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		return
	end if
	
	if IsNull(ll_num_prog) then 
		ll_num_prog=1
	else
		ll_num_prog++
	end if

	
	INSERT INTO documento (id_prof_documento, id_registro, num_progressivo, data_registrazione,
								  id_sog_commerciale, id_valuta, id_caus_magazzino,
								  id_locazione_1, data_documento, num_documento)
	VALUES	(:al_id_prof_documento, :ll_id_registro, :ll_num_prog, TODAY(*), 
				 :ll_id_sog_comm_prop, :ll_id_valuta_prop, :ll_id_caus_magazzino_prop, 
				 :ll_id_locazione_1_prop, TODAY(*), :ll_num_prog)
	;

	if SQLCA.SQLCODE = -1 then
		messagebox("DBError", SQLCA.SQLERRTEXT)
		ROLLBACK;
	else
		COMMIT;
	end if
	
	SELECT @@identity
	INTO	 :ll_id_documento
	FROM	 SYS.DUMMY
	;
		
	SELECT prog_materie_prime
	INTO	 :ll_id_r_lotto
	FROM	 prog_lotti
	;
	
	if (SQLCA.SQLCODE = -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		return
	end if
	
	ll_id_r_lotto++
	
	UPDATE	prog_lotti
	SET		prog_materie_prime = :ll_id_r_lotto
	;
	
	COMMIT;
	
	if (SQLCA.SQLCODE = -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		return
	end if

	ll_id_lotto = idw_target.GetItemNumber(li_i, "id_lotto")

	INSERT INTO riga_doc_lotto (id_riga_lotto, id_lotto, id_doc, valore_scarico)
	VALUES (:ll_id_r_lotto, :ll_id_lotto, :ll_id_documento, :ld_peso_rimanenza)
	;
	
	if (SQLCA.SQLCODE = -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		return
	end if

	SELECT	l.id_articolo, a.descrizione, u.id_unita_confezione, l.tipo_lotto
	INTO		:ll_id_articolo, :ls_des_articolo, :ll_id_unita_confezione, :ls_tipo_lotto
	FROM		unita_confezione u, lotto l, articolo a
	WHERE		a.id_articolo = l.id_articolo
	AND		u.id_articolo = a.id_articolo
	AND		u.unita_base = 'S'
	AND		l.id_lotto = :ll_id_lotto
	;
			
	if (SQLCA.SQLCODE = -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		return
	end if

	ll_id_tab_iva = 0;
	ll_id_tab_iva_2 = 0;
	
	SELECT a.id_tab_iva, c.id_tab_iva
	INTO	 :ll_id_tab_iva, :ll_id_tab_iva_2
	FROM	 articolo a, cat_com_articolo c
	WHERE  a.id_articolo = :ll_id_articolo
	AND	 c.id_cat_com_articolo = a.id_cat_com_articolo
	;
	
	if (SQLCA.SQLCODE = -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		return
	end if
	
	if (isnull(ll_id_tab_iva) or ll_id_tab_iva >= 0) then
		if (ll_id_tab_iva_2 >= 0) then ll_id_tab_iva = ll_id_tab_iva_2
	end if
				
	INSERT INTO riga_documento (id_documento, num_riga, id_valuta, id_articolo, 
					peso_netto, id_riga_lotto, descrizione, id_unita_confezione, id_locazione_1,
					id_caus_magazzino, fat_con_unita_base, fat_con_globale, id_tab_iva)
	VALUES 		(:ll_id_documento, 1, :ll_id_valuta_prop, :ll_id_articolo, 
					:ld_peso_rimanenza,:ll_id_r_lotto, :ls_des_articolo, :ll_id_unita_confezione, 
					:ll_id_locazione_1_prop, :ll_id_caus_magazzino_prop, 1, 1, 
					:ll_id_tab_iva)
	;
	
	if (SQLCA.SQLCODE = -1) then 
		messagebox("DBError", SQLCA.SQLERRTEXT)
		return
	end if
	
next
end subroutine

on w_agg_prog_lotti_wz.create
int iCurrent
call super::create
this.cb_esci=create cb_esci
this.cb_chiudi=create cb_chiudi
this.tab_distinta=create tab_distinta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_esci
this.Control[iCurrent+2]=this.cb_chiudi
this.Control[iCurrent+3]=this.tab_distinta
end on

on w_agg_prog_lotti_wz.destroy
call super::destroy
destroy(this.cb_esci)
destroy(this.cb_chiudi)
destroy(this.tab_distinta)
end on

event open;call super::open;
long ll_CurrRow

ib_removing = FALSE

idw_source = tab_distinta.tab_seleziona.dw_recuperati_lt
idw_target = tab_distinta.tab_seleziona.dw_selezionati_lt

idw_source.SetTransObject(SQLCA)

idw_target.SetTransObject(SQLCA)

ll_CurrRow = tab_distinta.tab_filtri.dw_filtro_ff.GetRow()
IF ll_CurrRow = 0 THEN tab_distinta.tab_filtri.dw_filtro_ff.InsertRow(0)

tab_distinta.tab_filtri.dw_filtro_ff.postevent("ue_post_open")
idw_target.postevent("ue_post_open")

tab_distinta.tab_filtri.dw_filtro_ff.SetFocus()

end event

type cb_esci from commandbutton within w_agg_prog_lotti_wz
int X=1573
int Y=28
int Width=261
int Height=84
int TabOrder=20
string Text="&Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_chiudi from commandbutton within w_agg_prog_lotti_wz
int X=1865
int Y=28
int Width=384
int Height=84
int TabOrder=10
string Text="&Aggiorna Lotti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
Long 		li_i, li_rows
Integer	ll_ret
decimal	ld_scarichi, ld_carichi
string	ls_tipo

ll_ret = MessageBox("Aggiornamento Progressivi lotti", "Confermi l'aggiornamento dei lotti selezionati ?", Question!, YesNo!, 2)
If ll_ret = 1 Then
	li_rows=idw_target.rowcount()
	
	if (li_rows <= 0) then return

	idw_target.resetupdate()
	
	For li_i=1 to li_rows
		ld_scarichi = idw_target.GetItemNumber(li_i, "scarichi")
		ld_carichi  = idw_target.GetItemNumber(li_i, "carichi")
		ls_tipo = idw_target.GetItemstring(li_i, "unita_misura_tipo")
		
		if (ls_tipo = 'P') then
			idw_target.SetItem(li_i, "peso_netto_scaricato", ld_scarichi)
			idw_target.SetItem(li_i, "peso_netto_iniziale", ld_carichi)			
		else
			idw_target.SetItem(li_i, "lotto_qta_scaricata", ld_scarichi)
			idw_target.SetItem(li_i, "lotto_qta_iniziale", ld_carichi)
		end if
	Next
	
	ll_ret = idw_target.update()
	
	if ll_ret = -1 then
		messagebox("DBerror", "Non è stato possibile aggiornare i lotti.")
		return
	else
		messagebox("Chiusura dei lotti aperti", "I lotti selezionati sono stati aggiornati")
	end if
End If
end event

type tab_distinta from tab within w_agg_prog_lotti_wz
event create ( )
event destroy ( )
int X=37
int Y=128
int Width=3223
int Height=1380
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

event selectionchanged;String 		ls_filtro
Integer  	ret
long 			ll_Rows, ll_i, ll_CurrRow
string	   ls_da_cod_articolo, ls_a_cod_articolo
string		ls_da_codice, ls_a_codice

if newindex=2 then
	ll_Rows = idw_target.RowCount()
	
	ib_removing = TRUE
	idw_target.SetRow(1)
	
	FOR ll_i = ll_Rows TO 1 STEP -1
		idw_target.rowsmove(ll_i,ll_i,primary!,idw_source,1,primary!)
	NEXT
	
	ib_removing = FALSE
	
	Tab_distinta.tab_filtri.dw_filtro_ff.AcceptText()
	
	ls_da_cod_articolo	= tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "da_cod_articolo")
	ls_a_cod_articolo		= tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "a_cod_articolo")
	
	ls_da_codice = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "da_cod_lotto")
	ls_a_codice  = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "a_cod_lotto")
	
	
	If ls_da_cod_articolo > ls_a_cod_articolo then
		Messagebox("Filtra","L'articolo iniziale è maggiore di quello finale!",exclamation!)
		Return
	End If
	
	If not (IsNull(ls_da_cod_articolo)) then
		ls_filtro=ls_filtro+" AND articolo.codice >= " + "'" + ls_da_cod_articolo + "'"
	end if
	
	If not (IsNull(ls_a_cod_articolo)) then
		ls_filtro=ls_filtro+" AND articolo.codice <= " + "'" + ls_a_cod_articolo + "'"
	end if
	
	
	If ls_da_codice > ls_a_codice then
		Messagebox("Filtra","Il lotto iniziale è maggiore di quello finale!",exclamation!)
		Return
	End If
	
	If not (IsNull(ls_da_codice)) then
		ls_filtro=ls_filtro+" AND lotto.cod_esterno >= " + "'" + ls_da_codice + "'"
	end if
	
	If not (IsNull(ls_a_codice)) then
		ls_filtro=ls_filtro+" AND lotto.cod_esterno <= " + "'" + ls_a_codice + "'"
	end if

	is_filter = ls_filtro
	
	ll_rows = idw_source.retrieve()

	tab_distinta.tab_seleziona.st_4.text=string(0)
	tab_distinta.tab_seleziona.st_1.text=string(ll_rows)
	idw_source.setfocus()

end if

end event

type tab_filtri from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3186
int Height=1260
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
int Y=36
int Width=3136
int Height=1196
int TabOrder=2
string DataObject="d_agg_prog_lotti_ext"
end type

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
CHOOSE CASE dwo.name
	CASE "da_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
           This.SetItem(1, "a_cod_articolo", Data)			
           This.SetItem(1, "a_des_articolo", This.GetItemString(1, "da_des_articolo"))			
	      end if 
			RETURN 2
		END IF
		
		
	CASE "da_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod_articolo"
		ls_dwc[2] = "da_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc) 	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
           This.SetItem(1, "a_cod_articolo", Data)			
           This.SetItem(1, "a_des_articolo", This.GetItemString(1, "da_des_articolo"))			
	      end if 
			RETURN 2
		END IF

	CASE "a_cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	CASE "a_des_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod_articolo"
		ls_dwc[2] = "a_des_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
end choose

THIS.Event Post ue_Setup_Filter()


end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_cod_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "da_des_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"
	CASE "a_cod_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_codice"
	CASE "a_des_articolo"
		is_search_window="w_articolo_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="articolo_descrizione"	
END CHOOSE

end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_cod_articolo"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("da_des_articolo",is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
            uf_set_colval("a_cod_articolo",is_ricpar.s_main_value)
				uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])
	      end if 
			
	CASE "da_des_articolo"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("da_cod_articolo",is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_articolo")) or This.GetItemString(1, "a_cod_articolo")='' then
         uf_set_colval("a_des_articolo",is_ricpar.s_main_value)
			uf_set_colval("a_cod_articolo",is_ricpar.s_ausil_value[1])
      end if 
		
	CASE "a_cod_articolo"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("a_des_articolo",is_ricpar.s_ausil_value[1])	
		
	CASE "a_des_articolo"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("a_cod_articolo",is_ricpar.s_ausil_value[1])
			
END CHOOSE

end event

type tab_seleziona from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3186
int Height=1260
long BackColor=80263581
string Text="Lotti "
long TabBackColor=80263581
long TabTextColor=33554432
long PictureMaskColor=553648127
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_recuperati_lt dw_recuperati_lt
st_4 st_4
dw_selezionati_lt dw_selezionati_lt
st_1 st_1
end type

on tab_seleziona.create
this.cb_drop_all=create cb_drop_all
this.cb_drop_many=create cb_drop_many
this.cb_remove_many=create cb_remove_many
this.cb_remove_all=create cb_remove_all
this.dw_recuperati_lt=create dw_recuperati_lt
this.st_4=create st_4
this.dw_selezionati_lt=create dw_selezionati_lt
this.st_1=create st_1
this.Control[]={this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_recuperati_lt,&
this.st_4,&
this.dw_selezionati_lt,&
this.st_1}
end on

on tab_seleziona.destroy
destroy(this.cb_drop_all)
destroy(this.cb_drop_many)
destroy(this.cb_remove_many)
destroy(this.cb_remove_all)
destroy(this.dw_recuperati_lt)
destroy(this.st_4)
destroy(this.dw_selezionati_lt)
destroy(this.st_1)
end on

type cb_drop_all from commandbutton within tab_seleziona
int X=1486
int Y=300
int Width=187
int Height=84
int TabOrder=60
string Text=">>"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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
int X=1486
int Y=420
int Width=187
int Height=84
int TabOrder=50
string Text=">"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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
int X=1486
int Y=640
int Width=187
int Height=84
int TabOrder=40
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
int X=1486
int Y=756
int Width=187
int Height=84
int TabOrder=30
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
int X=5
int Y=48
int Width=1440
int Height=1060
int TabOrder=10
string DataObject="d_agg_prog_lotti_gd"
boolean TitleBar=true
string Title="Lotti"
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

idw_source.SetTransObject(SQLCA)

If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + is_filter + ' ORDER BY articolo.codice, lotto.cod_esterno'
	This.SetSQLPreview(ls_SQLSyntax)
End If
end event

type st_4 from statictext within tab_seleziona
int X=2761
int Y=1148
int Width=238
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
int X=1710
int Y=48
int Width=1440
int Height=1060
int TabOrder=20
string DataObject="d_agg_prog_lotti_gd"
boolean TitleBar=true
string Title="Lotti da aggiornare"
boolean HScrollBar=true
boolean VScrollBar=true
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

type st_1 from statictext within tab_seleziona
int X=1024
int Y=1148
int Width=238
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
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

