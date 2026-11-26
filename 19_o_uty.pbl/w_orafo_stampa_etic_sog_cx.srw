forward
global type w_orafo_stampa_etic_sog_cx from w_wiz_main
end type
type cb_mail from commandbutton within w_orafo_stampa_etic_sog_cx
end type
type cb_chiudi from commandbutton within w_orafo_stampa_etic_sog_cx
end type
type tab_distinta from tab within w_orafo_stampa_etic_sog_cx
end type
type tab_filtri from userobject within tab_distinta
end type
type dw_filtro_ff from u_dw_ext_main within tab_filtri
end type
type tab_filtri from userobject within tab_distinta
dw_filtro_ff dw_filtro_ff
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
type cb_crea from commandbutton within tab_seleziona
end type
type tab_seleziona from userobject within tab_distinta
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_recuperati_lt dw_recuperati_lt
dw_selezionati_lt dw_selezionati_lt
cb_crea cb_crea
end type
type tab_distinta from tab within w_orafo_stampa_etic_sog_cx
tab_filtri tab_filtri
tab_seleziona tab_seleziona
end type
end forward

global type w_orafo_stampa_etic_sog_cx from w_wiz_main
integer x = 430
integer y = 348
integer width = 3474
integer height = 1504
string title = "Stampa etichette Soggetti Commerciali"
event ue_crea_distinta ( )
event ue_aggiungi_righe ( )
cb_mail cb_mail
cb_chiudi cb_chiudi
tab_distinta tab_distinta
end type
global w_orafo_stampa_etic_sog_cx w_orafo_stampa_etic_sog_cx

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
public function string wf_trova_indirizzo_da_anagrafica (long al_id_anagrafica)
public subroutine wf_invia_mail (string as_allegato, string as_indirizzo, string as_oggetto, string as_testo)
public function string wf_estrai_nome_file (string as_path)
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

public function string wf_trova_indirizzo_da_anagrafica (long al_id_anagrafica);////trova l'indirizzo mail nell'anagrafica  passata come argomento

string ls_indirizzo

select t.num_riferimento
into :ls_indirizzo
from dba.anagrafica a,  telefono t
where a.id_anagrafica=t.id_anagrafica
and t.tipo='E'
and a.id_anagrafica=:al_id_anagrafica
;

return ls_indirizzo
end function

public subroutine wf_invia_mail (string as_allegato, string as_indirizzo, string as_oggetto, string as_testo);string ls_nome_file

mailsession lms_sess
mailmessage lm_mess
mailrecipient lm_recipient
mailFileDescription lmf_file
mailreturncode lmc_rc


lmf_file.FileType = mailAttach!
ls_nome_file=wf_estrai_nome_file(as_allegato)
lmf_file.FileName = ls_nome_file
lmf_file.PathName = as_allegato

lm_mess.NoteText = as_testo
lm_mess.Subject = as_oggetto

lm_mess.Attachmentfile[1] = lmf_file

lm_recipient.Address = as_indirizzo
lm_recipient.Name = as_indirizzo
lm_recipient.RecipientType = mailTo!
lm_mess.Recipient[1] = lm_recipient

lms_sess = create mailsession
lmc_rc = lms_Sess.mailLogon()


lmc_rc = lms_Sess.mailSend(lm_mess)
IF lmc_rc <> mailReturnSuccess! THEN
   MessageBox("Error", "Error on Send")
END IF

lmc_rc = lms_sess.mailLogoff()
IF lmc_rc <> mailReturnSuccess! THEN
   MessageBox("Error", "Error on Close")
END IF
DESTROY lms_sess
 
end subroutine

public function string wf_estrai_nome_file (string as_path);string ls_nome_file
integer li_pos

li_pos=lastpos(as_path, "\")
if li_pos>0 then
	ls_nome_file=right(as_path, len(as_path) - li_pos)
else
	ls_nome_file=as_path
end if
return ls_nome_file
end function

on w_orafo_stampa_etic_sog_cx.create
int iCurrent
call super::create
this.cb_mail=create cb_mail
this.cb_chiudi=create cb_chiudi
this.tab_distinta=create tab_distinta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_mail
this.Control[iCurrent+2]=this.cb_chiudi
this.Control[iCurrent+3]=this.tab_distinta
end on

on w_orafo_stampa_etic_sog_cx.destroy
call super::destroy
destroy(this.cb_mail)
destroy(this.cb_chiudi)
destroy(this.tab_distinta)
end on

event open;call super::open;datawindowchild ldw_da_zona, ldw_a_zona
integer i

long 	 ll_CurrRow, ll_id_esercizio, ll_id_dis_banca
string ls_sort

ib_removing = FALSE

idw_source = tab_distinta.tab_seleziona.dw_recuperati_lt
idw_target = tab_distinta.tab_seleziona.dw_selezionati_lt

idw_source.SetTransObject(SQLCA)





i=tab_distinta.tab_filtri.dw_filtro_ff.getchild("da_cat_zona",ldw_da_zona)
i=tab_distinta.tab_filtri.dw_filtro_ff.getchild("a_cat_zona",ldw_a_zona)
ldw_da_zona.settransobject(sqlca)
ldw_da_zona.retrieve()
ldw_a_zona.settransobject(sqlca)
ldw_a_zona.retrieve()

ll_CurrRow = tab_distinta.tab_filtri.dw_filtro_ff.GetRow()
IF ll_CurrRow = 0 THEN tab_distinta.tab_filtri.dw_filtro_ff.InsertRow(0)

tab_distinta.tab_filtri.dw_filtro_ff.SetFocus()
end event

type cb_mail from commandbutton within w_orafo_stampa_etic_sog_cx
boolean visible = false
integer x = 2555
integer y = 20
integer width = 270
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Invia Mail"
end type

event clicked;string ls_indirizzo,ls_nome_file, ls_oggetto, ls_testo
long ll_id_anagrafica, ll_righe
integer i


ll_righe=idw_target.rowcount()
ls_testo=tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1, "testo_mail")
ls_oggetto=tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1, "oggetto_mail")
for i=1 to ll_righe
	ll_id_anagrafica=idw_target.getitemnumber(i, "id_anagrafica")
	
	ls_indirizzo=wf_trova_indirizzo_da_anagrafica(ll_id_anagrafica)
	if ls_indirizzo>" " then
		ls_nome_file=tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1, "allegato")
		wf_invia_mail(ls_nome_file, ls_indirizzo, ls_oggetto, ls_testo)
	end if
next
messagebox("OK!", "Posta Inviata!")
end event

type cb_chiudi from commandbutton within w_orafo_stampa_etic_sog_cx
integer x = 3127
integer y = 16
integer width = 270
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;Close(Parent)
end event

type tab_distinta from tab within w_orafo_stampa_etic_sog_cx
event create ( )
event destroy ( )
integer x = 27
integer y = 32
integer width = 3374
integer height = 1332
integer taborder = 20
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

event selectionchanging;char lc_filtro_ub

tab_distinta.tab_seleziona.dw_recuperati_lt.settransobject(sqlca)
tab_distinta.tab_seleziona.dw_selezionati_lt.settransobject(sqlca)

end event

event selectionchanged;long ll_Rows, ll_i, ll_CurrRow
String   ls_filtro, ls_inizio
String  ls_da_anag,ls_a_anag, ls_da_zona, ls_a_zona
 
if newindex=2 then
	ll_Rows = idw_target.RowCount()
	
	ib_removing = TRUE
	idw_target.SetRow(1)
	
	FOR ll_i = ll_Rows TO 1 STEP -1
		idw_target.rowsmove(ll_i,ll_i,primary!,idw_source,1,primary!)
	NEXT
		
		
	ib_removing = FALSE
	ls_da_anag=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_rag_1")	
	ls_a_anag=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_rag_1")
	ls_da_zona=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"da_cat_zona")	
	ls_a_zona=Tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1,"a_cat_zona")
	
	If IsNull(ls_da_anag) OR ls_da_anag = "" then
		SELECT MIN(rag_soc_1)
		INTO	 :ls_da_anag
		FROM	 anagrafica
		;
	End If
	If IsNull(ls_a_anag) OR ls_a_anag = "" then
		SELECT Max(rag_soc_1)
		INTO	 :ls_a_anag
		FROM	 anagrafica
		;
	End If
	
	
	
	
	
	Tab_distinta.tab_filtri.dw_filtro_ff.AcceptText()
	
	
	
	
		
	If ls_da_anag>ls_a_anag then
		Messagebox("Filtra","Il soggetto iniziale è maggiore di quello finale!",exclamation!)
		Return
	End If
	
	if ls_da_anag > '' then
		if pos(ls_filtro, "where") >0 then
			ls_inizio=" and "
		else
			ls_inizio=" where "
		end if
		ls_filtro+=ls_inizio+" rag_soc_1>="+"'"+string(ls_da_anag)+"'"
	end if
	
	if ls_a_anag > '' then
		if pos(ls_filtro, "where") >0 then
			ls_inizio=" and "
		else
			ls_inizio=" where "
		end if
		ls_filtro+=ls_inizio+" rag_soc_1<="+"'"+string(ls_a_anag)+"'"
		
	end if
	
	if ls_da_zona > ' ' then
		if pos(ls_filtro, "where") >0 then
			ls_inizio=" and "
		else
			ls_inizio=" where "
		end if
		ls_filtro+=ls_inizio+" cat_zona.codice>="+"'"+string(ls_da_zona)+"'"
	end if
	if ls_a_zona > ' ' then
		if pos(ls_filtro, "where") >0 then
			ls_inizio=" and "
		else
			ls_inizio=" where "
		end if
		ls_filtro+= ls_inizio+" cat_zona.codice<="+"'"+string(ls_a_zona)+"'"
	end if
	
	
	is_filter = ls_filtro
	
	idw_source.retrieve()
	idw_source.setfocus()
	
	
	
end if


end event

type tab_filtri from userobject within tab_distinta
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 3337
integer height = 1212
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
event ue_setup_filter ( )
integer x = 23
integer y = 24
integer width = 3287
integer height = 1136
integer taborder = 10
boolean titlebar = true
string title = "Filtro Soggetti Commerciali"
string dataobject = "d_orafo_anag_clfo_ff"
end type

event itemchanged;string ls_dbc[], ls_dwc[], ls_sql_cond, ls_dbv[]
integer ll_ok

choose case dwo.name

	CASE 'da_rag_1'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "da_rag_1"
		ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 1, &
										ls_dbc, ls_dbv, ls_dwc)							
										
		IF (ll_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_rag_1")) or This.GetItemString(1, "a_rag_1")='' then
           This.SetItem(1, "a_rag_1", Data)			
	      end if	
			RETURN 2
		END IF				
	CASE 'a_rag_1'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "a_rag_1"
		ll_ok = uf_autofind_col(dwo.Name, "anagrafica", &  
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 1, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF		
	case "mail"
		if data="S" then
			cb_mail.visible=true
		else
			cb_mail.visible=false
		end if
end choose
end event

event ue_set_search;

CHOOSE CASE as_nomecol
	CASE "da_rag_1"
		is_search_window = "w_anagrafica_sw" 	
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "rag_soc" 			
	CASE "a_rag_1"
		is_search_window = "w_anagrafica_sw" 	
		is_ricpar.s_filter_value = as_valcol 			
		is_ricpar.s_filter_name = "rag_soc" 			

END CHOOSE
end event

event ue_use_search;

CHOOSE CASE as_nomecol

	CASE "da_rag_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_rag_1",is_ricpar.s_main_value)
	CASE "a_rag_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
END CHOOSE

end event

event ue_init;call super::ue_init;is_colonne_drop[1]  = "id_tipo_pagamento_cod"
is_colonne_drop[2]  = "id_tipo_pagamento_des"
is_colonne_drop[3]  = "id_banca_azienda"
is_colonne_drop[4]  = "id_banca_azienda_pres"
end event

event clicked;call super::clicked;integer li_ret
string ls_path, ls_file

	
if dwo.name="p_allegato" then
	getfileopenname("Cerca report", ls_path, ls_file)
	if  trim(ls_file)>" " then
//		li_ret=messagebox("Richiesta conferma!","Vuoi riportare il solo nome del file?", Information!,yesno! )
//		if  li_ret=1 then
//			setitem(row, "allegato", ls_file)
//		else
			 setitem(row, "allegato", ls_path)
//		end if
	end if	
end if
end event

type tab_seleziona from userobject within tab_distinta
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 3337
integer height = 1212
long backcolor = 79741120
string text = "Soggetti da stampare"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_recuperati_lt dw_recuperati_lt
dw_selezionati_lt dw_selezionati_lt
cb_crea cb_crea
end type

on tab_seleziona.create
this.cb_drop_all=create cb_drop_all
this.cb_drop_many=create cb_drop_many
this.cb_remove_many=create cb_remove_many
this.cb_remove_all=create cb_remove_all
this.dw_recuperati_lt=create dw_recuperati_lt
this.dw_selezionati_lt=create dw_selezionati_lt
this.cb_crea=create cb_crea
this.Control[]={this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_recuperati_lt,&
this.dw_selezionati_lt,&
this.cb_crea}
end on

on tab_seleziona.destroy
destroy(this.cb_drop_all)
destroy(this.cb_drop_many)
destroy(this.cb_remove_many)
destroy(this.cb_remove_all)
destroy(this.dw_recuperati_lt)
destroy(this.dw_selezionati_lt)
destroy(this.cb_crea)
end on

type cb_drop_all from commandbutton within tab_seleziona
integer x = 1541
integer y = 300
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;long ll_Rows, ll_i, ll_CurrRow,contatore
decimal ldc_tot_scadenza_importo

ll_Rows = tab_distinta.tab_seleziona.dw_recuperati_lt.GetItemNumber(1, "righe")

ib_removing = TRUE
idw_source.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
		idw_source.ScrollToRow (ll_i) 		
		idw_source.rowsmove(ll_i,ll_i,primary!,idw_target,1,primary!)
		
NEXT

idw_target.Sort()


ib_removing = FALSE

dw_selezionati_lt.setfocus()


end event

type cb_drop_many from commandbutton within tab_seleziona
integer x = 1541
integer y = 420
integer width = 247
integer height = 88
integer taborder = 40
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


idw_target.Sort()

ib_removing = FALSE

dw_selezionati_lt.setfocus()
end event

type cb_remove_many from commandbutton within tab_seleziona
integer x = 1541
integer y = 640
integer width = 247
integer height = 88
integer taborder = 50
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
end event

type cb_remove_all from commandbutton within tab_seleziona
integer x = 1541
integer y = 760
integer width = 247
integer height = 88
integer taborder = 60
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
end event

type dw_recuperati_lt from u_dw_pura within tab_seleziona
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
integer x = 55
integer y = 52
integer width = 1449
integer height = 1060
integer taborder = 11
boolean titlebar = true
string title = "Ricercati"
string dataobject = "d_orafo_sog_etichette_gd"
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

event dragenter;
end event

event dragleave;
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

event sqlpreview;string ls_tipo, Ls_SQLSyntax
ls_tipo=tab_distinta.tab_filtri.dw_filtro_ff.getitemstring(1, "tipo")
if ls_tipo>'' then
	if is_filter>'' then
		is_filter+=" and tipo= '"+ls_tipo+"'"
	else
		is_filter+=" where tipo= '"+ls_tipo+"'"
	end if
end if

If is_filter <> "" Then
	

	ls_SQLSyntax = SQLSyntax + is_filter + ' ORDER BY rag_soc_1'
	This.SetSQLPreview(ls_SQLSyntax)
End If


end event

type dw_selezionati_lt from u_dw_pura within tab_seleziona
integer x = 1842
integer y = 52
integer width = 1449
integer height = 1060
integer taborder = 21
boolean titlebar = true
string title = "Selezionati"
string dataobject = "d_orafo_sog_etichette_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;wf_selezione(row,this,"",this,"","")

end event

type cb_crea from commandbutton within tab_seleziona
integer x = 1531
integer y = 1016
integer width = 270
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
end type

event clicked;


if dw_selezionati_lt.rowcount()<=0 then 
	messagebox('Attenzione', 'Non è stato selezionato nessun soggetto!')
else
	OpenWithParm ( w_orafo_stampa_etichette_rpt, dw_selezionati_lt )
end if	
end event

