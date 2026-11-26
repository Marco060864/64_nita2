forward
global type w_del_sog_com_cx from w_wiz_main
end type
type cb_esci from commandbutton within w_del_sog_com_cx
end type
type cb_cancella from commandbutton within w_del_sog_com_cx
end type
type tab_distinta from tab within w_del_sog_com_cx
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
type st_3 from statictext within tab_seleziona
end type
type dw_del_sog_com_cnt_ff from datawindow within tab_seleziona
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
st_3 st_3
dw_del_sog_com_cnt_ff dw_del_sog_com_cnt_ff
end type
type tab_distinta from tab within w_del_sog_com_cx
tab_filtri tab_filtri
tab_seleziona tab_seleziona
end type
end forward

global type w_del_sog_com_cx from w_wiz_main
int X=421
int Y=348
int Width=3301
int Height=1744
WindowType WindowType=response!
boolean TitleBar=true
string Title="Canellazione Documenti"
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_esci cb_esci
cb_cancella cb_cancella
tab_distinta tab_distinta
end type
global w_del_sog_com_cx w_del_sog_com_cx

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

on w_del_sog_com_cx.create
int iCurrent
call super::create
this.cb_esci=create cb_esci
this.cb_cancella=create cb_cancella
this.tab_distinta=create tab_distinta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_esci
this.Control[iCurrent+2]=this.cb_cancella
this.Control[iCurrent+3]=this.tab_distinta
end on

on w_del_sog_com_cx.destroy
call super::destroy
destroy(this.cb_esci)
destroy(this.cb_cancella)
destroy(this.tab_distinta)
end on

event open;call super::open;
long ll_CurrRow

ib_removing = FALSE

idw_source = tab_distinta.tab_seleziona.dw_recuperati_lt
idw_target = tab_distinta.tab_seleziona.dw_selezionati_lt

idw_source.SetTransObject(SQLCA)

idw_target.SetTransObject(SQLCA)

tab_distinta.tab_seleziona.dw_del_sog_com_cnt_ff.SetTransObject(SQLCA)

ll_CurrRow = tab_distinta.tab_filtri.dw_filtro_ff.GetRow()
IF ll_CurrRow = 0 THEN tab_distinta.tab_filtri.dw_filtro_ff.InsertRow(0)

tab_distinta.tab_filtri.dw_filtro_ff.postevent("ue_post_open")
idw_target.postevent("ue_post_open")

tab_distinta.tab_filtri.dw_filtro_ff.SetFocus()

end event

type cb_esci from commandbutton within w_del_sog_com_cx
int X=2491
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

type cb_cancella from commandbutton within w_del_sog_com_cx
int X=2789
int Y=28
int Width=361
int Height=84
int TabOrder=10
string Text="&Cancella"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
Long 		i, ll_row, ll_id_sog_commerciale, ll_id_conto
Integer	ll_ret
String	ls_codice

ll_ret = MessageBox("Cancellazione Sogg. Commerciali", "Confermi la cancellazione dei Sogg. Commerciali selezionati ?", Question!, YesNo!, 2)
If ll_ret = 1 Then
	ll_row=idw_target.rowcount()

	idw_target.ResetUpdate()

	For i=1 to ll_row
		ll_id_sog_commerciale = idw_target.GetItemNumber(1, "sog_commerciale_id_sog_commerciale")
		ls_codice = idw_target.GetItemString(1, "sog_commerciale_codice")
		ll_id_conto = idw_target.GetItemNumber(1, "sog_commerciale_id_conto")
		
		
		DELETE FROM destinazione
		WHERE id_sog_commerciale = :ll_id_sog_commerciale
		;
		
		If SQLCA.SQLCODE = -1 Then
			MessageBox("Cancellazione delle Destinazioni del Sogg. Comm. " + ls_codice, SQLCA.SQLERRTEXT)
			return
		End If
		
		
			
		DELETE FROM spesa_sog_commerciale
		WHERE id_sog_commerciale =  :ll_id_sog_commerciale
		;
		
		If SQLCA.SQLCODE = -1 Then
			MessageBox("Cancellazione delle Spese del Sogg. Comm. " + ls_codice, SQLCA.SQLERRTEXT)
			return
		End If	
		
		
						
		DELETE FROM annotazione
		WHERE id_sog_commerciale =  :ll_id_sog_commerciale
		;
	
		If SQLCA.SQLCODE = -1 Then
			MessageBox("Cancellazione delle Annotazioni del Sogg. Comm. " + ls_codice, SQLCA.SQLERRTEXT)
			return
		End If
			
									
		DELETE FROM saldo_mensile
		WHERE	id_conto = :ll_id_conto 
		;
		If SQLCA.SQLCODE = -1 Then
			MessageBox("Cancellazione del Saldo mensile del Sogg. Comm. " + ls_codice, SQLCA.SQLERRTEXT)
			return
		End If	
					
		
															
		DELETE FROM conto
		WHERE id_conto = :ll_id_conto 
		AND 	id_conto not in ( select id_conto 
										from 	 sog_commerciale)
		;
		
		If SQLCA.SQLCODE = -1 Then
			MessageBox("Cancellazione del Conto del Sogg. Comm. " + ls_codice, SQLCA.SQLERRTEXT)
			return
		end if
		
		idw_target.DeleteRow(1)	
		ll_ret = idw_target.Update()
		If ll_ret = -1 Then
			MessageBox("", "La cancellazione del Sogg.comm. " + ls_codice + " non è andata a buon fine")
		End If
	Next
End If
end event

type tab_distinta from tab within w_del_sog_com_cx
event create ( )
event destroy ( )
int X=23
int Y=120
int Width=3200
int Height=1428
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

event selectionchanged;if newindex=2 then
	long ll_Rows, ll_i, ll_CurrRow


	ll_Rows = idw_target.RowCount()
	
	ib_removing = TRUE
	idw_target.SetRow(1)
	
	FOR ll_i = ll_Rows TO 1 STEP -1
				idw_target.rowsmove(ll_i,ll_i,primary!,idw_source,1,primary!)
				
	NEXT
	
	ib_removing = FALSE
	
	String ls_filtro, ls_da_codice, ls_a_codice
	Integer  ret	
	
	ls_da_codice = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "da_codice")
	ls_a_codice  = tab_distinta.tab_filtri.dw_filtro_ff.GetItemString(1, "a_codice")
	
	
	Time lt_inizio_retrieve, lt_fine_retrieve
	
	lt_inizio_retrieve = Now()
	
	Tab_distinta.tab_filtri.dw_filtro_ff.AcceptText()
	
	ls_da_codice = Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_codice")
	ls_a_codice = Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_codice")	

	If ls_da_codice > ls_a_codice then
		Messagebox("Filtra","Il Sogg. Commerciale iniziale è maggiore di quello finale!",exclamation!)
		Return
	End If
	
	if ls_da_codice <> '' then
		ls_filtro = ls_filtro + " AND sog_commerciale.codice >= " + "'" + string(ls_da_codice) + "'"
	End if
	
	
	If ls_a_codice <> '' then
		ls_filtro = ls_filtro + " AND sog_commerciale.codice <= " + "'" + string(ls_a_codice) + "'"
	End if	

	is_filter = ls_filtro
	
	idw_source.retrieve()
	tab_distinta.tab_seleziona.dw_del_sog_com_cnt_ff.Retrieve()
	tab_distinta.tab_seleziona.st_4.text=string(0)
	idw_source.setfocus()	
end if


end event

type tab_filtri from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3163
int Height=1308
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
int X=9
int Y=36
int Width=3118
int Height=484
int TabOrder=2
string DataObject="d_del_sog_com_ext"
boolean TitleBar=true
string Title="Filtro Sogg. Commerciali"
end type

event itemchanged;

THIS.Event Post ue_Setup_Filter()

string		ls_dbc[], ls_dbv[], ls_dwc[]
integer		li_ok
string		ls_sql_cond

CHOOSE CASE dwo.name
	CASE 'da_codice'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "da_rag_soc_1"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "da_codice"
		li_ok = uf_autofind_col (string(dwo.name), "sog_commerciale_gen", &
										"codice", "A", data, ls_sql_cond,2 , ls_dbc, ls_dbv,ls_dwc)
										
		
	
		IF (li_ok > 0) THEN
		  if isnull(This.GetItemString(1, "a_codice")) or This.GetItemString(1, "a_codice")='' then
          This.SetItem(1, "a_codice", Data)			
          This.SetItem(1, "a_rag_soc_1", This.GetItemString(1, "da_rag_soc_1"))	
	     end if  
		  RETURN 2
	   END IF

	CASE 'da_rag_soc_1'
			ls_dbc[1] = "rag_soc_1"
			ls_dwc[1] = "da_rag_soc_1"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "da_codice"
			li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
											"rag_soc_1", "A", data, ls_sql_cond, 2, ls_dbc, ls_dbv, ls_dwc)

		
		IF (li_ok > 0) THEN
   		if isnull(This.GetItemString(1, "a_codice")) or This.GetItemString(1, "a_codice")='' then
           This.SetItem(1, "a_rag_soc_1", Data)			
           This.SetItem(1, "a_codice", This.GetItemString(1, "da_codice"))
		   end if 
         RETURN 2
	   END IF

	CASE 'a_codice'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "a_rag_soc_1"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "a_codice"
		li_ok = uf_autofind_col (string(dwo.name), "sog_commerciale_gen", &
										"codice", "A", data, ls_sql_cond,2 , ls_dbc, ls_dbv,ls_dwc)
											
	CASE 'a_rag_soc_1'
			ls_dbc[1] = "rag_soc_1"
			ls_dwc[1] = "a_rag_soc_1"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "a_codice"
			li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
											"rag_soc_1", "A", data, ls_sql_cond, 2, ls_dbc, ls_dbv, ls_dwc)
END CHOOSE
end event

event ue_init;call super::ue_init;
end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
CASE "da_codice", "a_codice"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		is_ricpar.b_asneeded=TRUE

CASE "da_rag_soc_1", "a_rag_soc_1"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		is_ricpar.b_asneeded=TRUE
END CHOOSE
end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "da_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_rag_soc_1", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_codice")) or This.GetItemString(1, "a_codice")='' then
		   uf_set_colval("a_codice", is_ricpar.s_main_value)
			uf_set_colval("a_rag_soc_1", is_ricpar.s_ausil_value[1])
		end if	
			
	CASE "a_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_rag_soc_1", is_ricpar.s_ausil_value[1])		
	CASE "da_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_codice", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_codice")) or This.GetItemString(1, "a_codice")='' then
		   uf_set_colval("a_rag_soc_1", is_ricpar.s_main_value)
			uf_set_colval("a_codice", is_ricpar.s_ausil_value[1])
		end if	
		
	CASE "a_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_codice", is_ricpar.s_ausil_value[1])		
END CHOOSE
end event

type tab_seleziona from userobject within tab_distinta
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=3163
int Height=1308
long BackColor=79741120
string Text="Sogg. Commerciali da Cancellare"
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
dw_del_sog_com_cnt_ff dw_del_sog_com_cnt_ff
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
this.dw_del_sog_com_cnt_ff=create dw_del_sog_com_cnt_ff
this.Control[]={this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_recuperati_lt,&
this.st_4,&
this.dw_selezionati_lt,&
this.st_3,&
this.dw_del_sog_com_cnt_ff}
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
destroy(this.dw_del_sog_com_cnt_ff)
end on

type cb_drop_all from commandbutton within tab_seleziona
int X=1472
int Y=300
int Width=238
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
int X=1472
int Y=420
int Width=238
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
int X=1472
int Y=640
int Width=238
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
int X=1472
int Y=756
int Width=238
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
int X=14
int Y=52
int Width=1321
int Height=1060
int TabOrder=10
string DataObject="d_del_sog_com_lt"
boolean TitleBar=true
string Title="Disponibili e non movimentati"
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

idw_source.SetTransObject(SQLCA)

If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + is_filter + ' ORDER BY sog_commerciale.codice'
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
int X=1810
int Y=52
int Width=1321
int Height=1060
int TabOrder=20
string DataObject="d_del_sog_com_lt"
boolean TitleBar=true
string Title="Selezionati"
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

type st_3 from statictext within tab_seleziona
int X=1925
int Y=1152
int Width=827
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Sogg. Commerciali da cancellare"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_del_sog_com_cnt_ff from datawindow within tab_seleziona
int X=87
int Y=1136
int Width=1179
int Height=152
int TabOrder=31
boolean BringToTop=true
string DataObject="d_del_sog_com_cnt_ff"
boolean Border=false
boolean LiveScroll=true
end type

event sqlpreview;

If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + is_filter
	This.SetSQLPreview(ls_SQLSyntax)
End If
end event

