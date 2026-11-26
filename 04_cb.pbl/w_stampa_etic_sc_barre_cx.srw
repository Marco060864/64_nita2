forward
global type w_stampa_etic_sc_barre_cx from w_wiz_main
end type
type cb_chiudi from commandbutton within w_stampa_etic_sc_barre_cx
end type
type tab_distinta from tab within w_stampa_etic_sc_barre_cx
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
type dw_sel_sc_lt from u_dw_pura within tab_seleziona
end type
type cb_crea from commandbutton within tab_seleziona
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
dw_sel_sc_lt dw_sel_sc_lt
cb_crea cb_crea
end type
type tab_distinta from tab within w_stampa_etic_sc_barre_cx
tab_filtri tab_filtri
tab_modifiche tab_modifiche
tab_seleziona tab_seleziona
end type
end forward

global type w_stampa_etic_sc_barre_cx from w_wiz_main
int X=430
int Y=348
int Width=3474
int Height=1736
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa etichette codice a barre S.C."
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_chiudi cb_chiudi
tab_distinta tab_distinta
end type
global w_stampa_etic_sc_barre_cx w_stampa_etic_sc_barre_cx

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

on w_stampa_etic_sc_barre_cx.create
int iCurrent
call super::create
this.cb_chiudi=create cb_chiudi
this.tab_distinta=create tab_distinta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_chiudi
this.Control[iCurrent+2]=this.tab_distinta
end on

on w_stampa_etic_sc_barre_cx.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.tab_distinta)
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
idw_target = tab_distinta.tab_seleziona.dw_sel_sc_lt

idw_source.SetTransObject(SQLCA)


ll_CurrRow = tab_distinta.tab_filtri.dw_filtro_ff.GetRow()
IF ll_CurrRow = 0 THEN tab_distinta.tab_filtri.dw_filtro_ff.InsertRow(0)

ll_CurrRow = tab_distinta.tab_modifiche.dw_modifiche_ff.GetRow()
IF ll_CurrRow = 0 THEN ll_CurrRow = tab_distinta.tab_modifiche.dw_modifiche_ff.InsertRow(0)

tab_distinta.tab_filtri.dw_filtro_ff.postevent("ue_post_open")
idw_target.postevent("ue_post_open")

tab_distinta.tab_filtri.dw_filtro_ff.SetFocus()
end event

type cb_chiudi from commandbutton within w_stampa_etic_sc_barre_cx
int X=3127
int Y=16
int Width=270
int Height=84
int TabOrder=10
string Text="Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type tab_distinta from tab within w_stampa_etic_sc_barre_cx
event create ( )
event destroy ( )
int X=41
int Y=132
int Width=3374
int Height=1476
int TabOrder=20
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

Time lt_inizio_retrieve, lt_fine_retrieve

lt_inizio_retrieve = Now()


string ls_da_sog, ls_a_sog
ls_da_sog = tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_fornitore_cod")
ls_a_sog  = tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_fornitore_cod")
idw_source.retrieve(ls_da_sog, ls_a_sog)
idw_source.setfocus()

lt_fine_retrieve = Now()
end if


end event

event selectionchanging;
tab_distinta.tab_seleziona.dw_sel_sc_lt.settransobject(sqlca)
tab_distinta.tab_seleziona.dw_recuperati_lt.settransobject(sqlca)

end event

type tab_filtri from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3337
int Height=1356
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
string DataObject="d_sel_st_etic_sc_barre"
boolean TitleBar=true
string Title=""
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
		ls_dwc[1] = "da_produttore_des"
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
		ls_dwc[1] = "a_produttore_des"
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
	CASE "a_fornitore_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 

	CASE "da_fornitore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 

	CASE "a_fornitore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 

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
			if isnull(This.GetItemString(1, "a_articolo_cod")) or This.GetItemString(1, "a_articolo_cod")='' then
           uf_set_colval("a_produttore_des",is_ricpar.s_main_value)	
	      end if
		
	CASE "da_fornitore_cod"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_fornitore_des", is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_fornitore_cod")) or This.GetItemString(1, "a_fornitore_cod")='' then
           uf_set_colval("a_fornitore_cod",is_ricpar.s_main_value)	
           uf_set_colval("a_fornitore_des",is_ricpar.s_ausil_value[1])
	      end if
			
	CASE "da_fornitore_des"
			uf_set_colval(as_nomecol, is_ricpar.s_main_value)
			uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
			uf_set_colval("da_fornitore_cod", is_ricpar.s_ausil_value[1])
			if isnull(This.GetItemString(1, "a_fornitore_cod")) or This.GetItemString(1, "a_fornitore_cod")='' then
           uf_set_colval("a_fornitore_des",is_ricpar.s_main_value)	
           uf_set_colval("a_fornitore_cod",is_ricpar.s_ausil_value[1])
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
int X=18
int Y=104
int Width=3337
int Height=1356
boolean Visible=false
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
int X=9
int Y=16
int Width=3305
int Height=1740
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

event itemchanged;call super::itemchanged;string ls_val
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
end event

type tab_seleziona from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3337
int Height=1356
long BackColor=79741120
string Text="Etichette da stampare"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=553648127
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_recuperati_lt dw_recuperati_lt
dw_sel_sc_lt dw_sel_sc_lt
cb_crea cb_crea
end type

on tab_seleziona.create
this.cb_drop_all=create cb_drop_all
this.cb_drop_many=create cb_drop_many
this.cb_remove_many=create cb_remove_many
this.cb_remove_all=create cb_remove_all
this.dw_recuperati_lt=create dw_recuperati_lt
this.dw_sel_sc_lt=create dw_sel_sc_lt
this.cb_crea=create cb_crea
this.Control[]={this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_recuperati_lt,&
this.dw_sel_sc_lt,&
this.cb_crea}
end on

on tab_seleziona.destroy
destroy(this.cb_drop_all)
destroy(this.cb_drop_many)
destroy(this.cb_remove_many)
destroy(this.cb_remove_all)
destroy(this.dw_recuperati_lt)
destroy(this.dw_sel_sc_lt)
destroy(this.cb_crea)
end on

type cb_drop_all from commandbutton within tab_seleziona
int X=1541
int Y=300
int Width=247
int Height=88
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

ll_Rows = idw_source.rowcount()

ib_removing = TRUE
idw_source.SetRow(1)


FOR ll_i = ll_Rows TO 1 STEP -1
		idw_source.ScrollToRow (ll_i) 		
		idw_source.rowsmove(ll_i,ll_i,primary!,idw_target,1,primary!)
		contatore=contatore+1
		idw_target.selectrow(contatore,true)
NEXT

idw_target.Sort()


ib_removing = FALSE

dw_sel_sc_lt.setfocus()


end event

type cb_drop_many from commandbutton within tab_seleziona
int X=1541
int Y=420
int Width=247
int Height=88
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

contatore = contatore + ll_contatore

idw_target.Sort()

ib_removing = FALSE

dw_sel_sc_lt.setfocus()
end event

type cb_remove_many from commandbutton within tab_seleziona
int X=1541
int Y=640
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
contatore=dw_sel_sc_lt.rowcount()
	

end event

type cb_remove_all from commandbutton within tab_seleziona
int X=1541
int Y=760
int Width=247
int Height=88
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
contatore=dw_sel_sc_lt.rowcount()
	

end event

type dw_recuperati_lt from u_dw_pura within tab_seleziona
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
int X=55
int Y=52
int Width=1449
int Height=1060
string DataObject="d_etic_sog_com_barre"
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

event sqlpreview;call super::sqlpreview;
If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + 'AND ' + is_filter + ' ORDER BY articolo.codice'
	This.SetSQLPreview(ls_SQLSyntax)
End If


end event

type dw_sel_sc_lt from u_dw_pura within tab_seleziona
int X=1842
int Y=52
int Width=1449
int Height=1060
int TabOrder=2
string DataObject="d_etic_sog_com_barre"
boolean TitleBar=true
string Title="Selezionati"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event clicked;call super::clicked;wf_selezione(row,this,"",this,"","")

end event

type cb_crea from commandbutton within tab_seleziona
int X=1531
int Y=1180
int Width=270
int Height=84
int TabOrder=30
string Text="&Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


if dw_sel_sc_lt.rowcount()<=0 then 
	messagebox('Attenzione', 'Non è stato selezionato nessun articolo!')
else
	OpenWithParm ( w_stampa_etichette, dw_sel_sc_lt )
end if	
end event

