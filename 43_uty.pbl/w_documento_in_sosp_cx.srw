forward
global type w_documento_in_sosp_cx from w_wiz_main
end type
type cb_chiudi from commandbutton within w_documento_in_sosp_cx
end type
type cb_crea from commandbutton within w_documento_in_sosp_cx
end type
type tab_distinta from tab within w_documento_in_sosp_cx
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
type dw_selezionati_lt from u_dw_pura within tab_seleziona
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
dw_selezionati_lt dw_selezionati_lt
end type
type tab_distinta from tab within w_documento_in_sosp_cx
tab_filtri tab_filtri
tab_seleziona tab_seleziona
end type
end forward

global type w_documento_in_sosp_cx from w_wiz_main
int X=434
int Y=348
int Width=2958
int Height=1680
WindowType WindowType=response!
boolean TitleBar=true
string Title="Variazione dati Articolo"
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_chiudi cb_chiudi
cb_crea cb_crea
tab_distinta tab_distinta
end type
global w_documento_in_sosp_cx w_documento_in_sosp_cx

type variables
DataWindow idw_source, idw_target,idw_modifica
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
Decimal idc_imp_max_distinta
s_distinta is_distinta
char ic_tipo_scadenza
long il_id_banca_azienda, il_id_dis_banca
decimal idec_peso[], idec_misura[]
long ll_sost1, ll_sost2
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

on w_documento_in_sosp_cx.create
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

on w_documento_in_sosp_cx.destroy
call super::destroy
destroy(this.cb_chiudi)
destroy(this.cb_crea)
destroy(this.tab_distinta)
end on

event open;




tab_distinta.tab_filtri.dw_filtro_ff.settransobject(sqlca)
tab_distinta.tab_filtri.dw_filtro_ff.insertrow(1)
tab_distinta.tab_seleziona.dw_recuperati_lt.settransobject(sqlca)
tab_distinta.tab_seleziona.dw_selezionati_lt.settransobject(sqlca)

tab_distinta.tab_filtri.dw_filtro_ff.setitem(1,"a_data", today())
tab_distinta.tab_filtri.dw_filtro_ff.setitem(1,"da_data", RelativeDate(today(), -30))



end event

type cb_chiudi from commandbutton within w_documento_in_sosp_cx
int X=1897
int Y=28
int Width=270
int Height=84
int TabOrder=30
string Text="Chiudi"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)
end event

type cb_crea from commandbutton within w_documento_in_sosp_cx
int X=2226
int Y=28
int Width=539
int Height=88
int TabOrder=10
string Text="Manda in sospensione"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long  ll_riga, ll_id_doc
string ls_da, ls_a
date ld_da, ld_a 
integer li_pos






ll_riga=tab_distinta.tab_seleziona.dw_selezionati_lt.rowcount()


for li_pos=1 to ll_riga 
	  
	  
	  
	  
	  ll_id_doc=tab_distinta.tab_seleziona.dw_selezionati_lt.getitemnumber(li_pos,"d_id_documento")
	  
	  
	  
	  update documento
	  set id_prof_documento=:ll_sost2, id_registro=:ll_sost1
	  where id_documento=:ll_id_doc;

next

tab_distinta.tab_seleziona.dw_selezionati_lt.reset()





end event

type tab_distinta from tab within w_documento_in_sosp_cx
event create ( )
event destroy ( )
int X=32
int Y=152
int Width=2779
int Height=1400
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

event selectionchanged;string ls_da_prof, ls_a_prof, ls_tipo_registro, ls_a_data, ls_da_data 
long ll_sost
date ld_da_data, ld_a_data
string DWfilter2

 
 
if oldindex=1 then
	
tab_distinta.tab_filtri.dw_filtro_ff.accepttext()	

	
select id_prof_reg_iva_sos, id_mod_reg_iva_sos
into :ll_sost, :ll_sost1
from par_sistema
;

select id_prof_documento
into :ll_sost2
from prof_documento
where id_prof_registrazione=:ll_sost;	
	
	
	
	
	
if tab_distinta.tab_filtri.dw_filtro_ff.getrow()>0 then
ls_da_prof = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "da_prof")
ls_a_prof  = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "a_prof")


If IsNull(ls_da_prof) OR ls_da_prof = "" then
	SELECT MIN(codice)
	INTO	 :ls_da_prof
	FROM	 prof_documento
	where tipo_registro='IV' or tipo_registro='IC';
End If
If IsNull(ls_a_prof) OR ls_a_prof = "" then
	SELECT MAX(codice)
	INTO	 :ls_a_prof
	FROM	 prof_documento
	where tipo_registro='IV' or tipo_registro='IC';
End If


If ls_da_prof>ls_a_prof then
	Messagebox("Filtra","Il profilo iniziale è maggiore di quello finale!",exclamation!)
	Return
End If




ld_da_data = tab_distinta.tab_filtri.dw_filtro_ff.GetItemdate(1, "da_data")
ld_a_data  = tab_distinta.tab_filtri.dw_filtro_ff.GetItemdate(1, "a_data")


If IsNull(ld_da_data)  then ld_da_data=RelativeDate(today(), -30)
If IsNull(ld_a_data)  then ld_a_data=today()
	

If ld_da_data>ld_a_data then
	Messagebox("Filtra","La data iniziale è maggiore di quella finale!",exclamation!)
	Return
End If


tab_distinta.tab_seleziona.dw_recuperati_lt.Retrieve(ll_sost2, ll_sost1)
tab_distinta.tab_seleziona.dw_recuperati_lt.sort()

ls_da_data=string(ld_da_data,"yyyy-mm-dd")
ls_a_data=string(ld_a_data,"yyyy-mm-dd")

DWfilter2 = "p_codice>= '"+ls_da_prof+"' and  p_codice<='"+ls_a_prof+"' and d_data_documento>=date('"+ls_da_data+"') and d_data_documento<=date('"+ls_a_data+"')"
tab_distinta.tab_seleziona.dw_recuperati_lt.SetFilter(DWfilter2)
tab_distinta.tab_seleziona.dw_recuperati_lt.Filter( )
end if

end if
end event

type tab_filtri from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2743
int Height=1280
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
event ue_setup_filter ( )
int X=23
int Y=72
int Width=2688
int Height=1124
int TabOrder=10
string DataObject="d_seleziona_doc_sosp_ff"
boolean TitleBar=true
string Title="Filtro Articoli/Unità Confezione"
end type

event itemchanged;String 	ls_sql_cond
String 	ls_dbc[], ls_dwc[], ls_dbv[]
Long	   ll_ok


CHOOSE CASE dwo.name
	CASE "da_prof"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_prof"
		
		ll_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)

		
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
		
	CASE "a_prof"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "a_prof"

		
		ll_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
	
END CHOOSE

end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "da_prof"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_codice"
		
	
	CASE "a_prof"
		is_search_window="w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value=uf_get_colval(as_nomecol)
		is_ricpar.s_filter_name="prof_documento_codice"
		
	
end choose
end event

event ue_use_search;CHOOSE CASE as_nomecol
	case "da_prof"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
			
	case "a_prof"
			uf_set_colval(as_nomecol,is_ricpar.s_main_value)
			uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])			
	
END CHOOSE
end event

type tab_seleziona from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2743
int Height=1280
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
dw_selezionati_lt dw_selezionati_lt
end type

on tab_seleziona.create
this.cb_drop_all=create cb_drop_all
this.cb_drop_many=create cb_drop_many
this.cb_remove_many=create cb_remove_many
this.cb_remove_all=create cb_remove_all
this.dw_recuperati_lt=create dw_recuperati_lt
this.dw_selezionati_lt=create dw_selezionati_lt
this.Control[]={this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_recuperati_lt,&
this.dw_selezionati_lt}
end on

on tab_seleziona.destroy
destroy(this.cb_drop_all)
destroy(this.cb_drop_many)
destroy(this.cb_remove_many)
destroy(this.cb_remove_all)
destroy(this.dw_recuperati_lt)
destroy(this.dw_selezionati_lt)
end on

type cb_drop_all from commandbutton within tab_seleziona
int X=1230
int Y=92
int Width=247
int Height=92
int TabOrder=30
string Text=">>"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_Rows, ll_i, ll_CurrRow,contatore
decimal ldc_tot_scadenza_importo


ll_Rows = tab_distinta.tab_seleziona.dw_recuperati_lt.rowcount()


ib_removing = TRUE
tab_distinta.tab_seleziona.dw_recuperati_lt.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
		tab_distinta.tab_seleziona.dw_recuperati_lt.ScrollToRow (ll_i) 		
		tab_distinta.tab_seleziona.dw_recuperati_lt.rowsmove(ll_i,ll_i,primary!,tab_distinta.tab_seleziona.dw_selezionati_lt,1,primary!)
		contatore=contatore+1
		tab_distinta.tab_seleziona.dw_selezionati_lt.selectrow(contatore,true)
NEXT

tab_distinta.tab_seleziona.dw_selezionati_lt.Sort()


ib_removing = FALSE

dw_selezionati_lt.setfocus()

dw_selezionati_lt.setsort("articolo_codice A")
dw_selezionati_lt.sort()
end event

type cb_drop_many from commandbutton within tab_seleziona
int X=1230
int Y=212
int Width=247
int Height=92
int TabOrder=50
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

ll_Rows = tab_distinta.tab_seleziona.dw_recuperati_lt.RowCount()

ib_removing = TRUE
tab_distinta.tab_seleziona.dw_recuperati_lt.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF tab_distinta.tab_seleziona.dw_recuperati_lt.IsSelected(ll_i) THEN
		contatore=contatore+1

		tab_distinta.tab_seleziona.dw_recuperati_lt.rowsmove(ll_i,ll_i,primary!,tab_distinta.tab_seleziona.dw_selezionati_lt,1,primary!)
		tab_distinta.tab_seleziona.dw_selezionati_lt.selectrow(contatore,true)
		
	END IF
NEXT


tab_distinta.tab_seleziona.dw_selezionati_lt.Sort()

ib_removing = FALSE

dw_selezionati_lt.setfocus()


dw_selezionati_lt.setsort("articolo_codice A")
dw_selezionati_lt.sort()
end event

type cb_remove_many from commandbutton within tab_seleziona
int X=1230
int Y=396
int Width=247
int Height=92
int TabOrder=60
string Text="<"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo

ll_Rows = tab_distinta.tab_seleziona.dw_selezionati_lt.RowCount()

ib_removing = TRUE
tab_distinta.tab_seleziona.dw_selezionati_lt.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF tab_distinta.tab_seleziona.dw_selezionati_lt.IsSelected(ll_i) THEN
		

		tab_distinta.tab_seleziona.dw_selezionati_lt.rowsmove(ll_i,ll_i,primary!,tab_distinta.tab_seleziona.dw_recuperati_lt,1,primary!)
		
		
		
	END IF
NEXT

tab_distinta.tab_seleziona.dw_recuperati_lt.Sort()

ib_removing = FALSE
	

end event

type cb_remove_all from commandbutton within tab_seleziona
int X=1230
int Y=528
int Width=247
int Height=92
int TabOrder=70
string Text="<<"
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_Rows, ll_i, ll_CurrRow


ll_Rows = tab_distinta.tab_seleziona.dw_selezionati_lt.RowCount()

ib_removing = TRUE
tab_distinta.tab_seleziona.dw_selezionati_lt.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
			tab_distinta.tab_seleziona.dw_selezionati_lt.rowsmove(ll_i,ll_i,primary!,tab_distinta.tab_seleziona.dw_recuperati_lt,1,primary!)
			
NEXT

tab_distinta.tab_seleziona.dw_recuperati_lt.Sort()

ib_removing = FALSE
end event

type dw_recuperati_lt from u_dw_pura within tab_seleziona
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
int X=23
int Y=48
int Width=1161
int Height=1072
int TabOrder=11
string DataObject="d_doc_sosp_lt"
boolean TitleBar=true
string Title="Ricercati"
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

event sqlpreview;call super::sqlpreview;
If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + 'AND ' + is_filter + ' ORDER BY articolo.codice'
	This.SetSQLPreview(ls_SQLSyntax)
End If


end event

type dw_selezionati_lt from u_dw_pura within tab_seleziona
int X=1545
int Y=48
int Width=1161
int Height=1072
int TabOrder=21
string DataObject="d_doc_sosp_lt"
boolean TitleBar=true
string Title="Selezionati"
boolean VScrollBar=true
end type

event clicked;wf_selezione(row,this,"",this,"","")

end event

