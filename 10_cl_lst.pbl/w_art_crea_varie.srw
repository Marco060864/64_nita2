forward
global type w_art_crea_varie from w_wiz_main
end type
type tab_1 from tab within w_art_crea_varie
end type
type tabpage_1 from userobject within tab_1
end type
type dw_filtro_ff from u_dw_ext_main within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_filtro_ff dw_filtro_ff
end type
type tabpage_2 from userobject within tab_1
end type
type dw_recuperati_lt from u_dw_pura within tabpage_2
end type
type dw_selezionati_lt from u_dw_pura within tabpage_2
end type
type cb_drop_all from commandbutton within tabpage_2
end type
type cb_drop_many from commandbutton within tabpage_2
end type
type cb_remove_many from commandbutton within tabpage_2
end type
type cb_remove_all from commandbutton within tabpage_2
end type
type dw_gen_automatica_cntrec_ff from u_dw_pura within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_recuperati_lt dw_recuperati_lt
dw_selezionati_lt dw_selezionati_lt
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_gen_automatica_cntrec_ff dw_gen_automatica_cntrec_ff
end type
type tabpage_3 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_3
end type
type dw_risultato from udw_001 within tabpage_3
end type
type dw_gen_automatica_ext from u_dw_ext_main within tabpage_3
end type
type cb_genera from commandbutton within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_1 cb_1
dw_risultato dw_risultato
dw_gen_automatica_ext dw_gen_automatica_ext
cb_genera cb_genera
end type
type tabpage_4 from userobject within tab_1
end type
type dw_prova from u_dw_ext_main within tabpage_4
end type
type cb_2 from commandbutton within tabpage_4
end type
type r_1 from rectangle within tabpage_4
end type
type st_1 from statictext within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_prova dw_prova
cb_2 cb_2
r_1 r_1
st_1 st_1
end type
type tab_1 from tab within w_art_crea_varie
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type cb_annulla from commandbutton within w_art_crea_varie
end type
end forward

global type w_art_crea_varie from w_wiz_main
integer width = 3483
integer height = 1672
string title = "w_art_crea_varie"
tab_1 tab_1
cb_annulla cb_annulla
end type
global w_art_crea_varie w_art_crea_varie

type variables
DataWindow idw_filtro, idw_recuperati, idw_selezionati
Boolean ib_removing, ib_down_source, ib_down_target
String is_filter
end variables

forward prototypes
public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_col_dest, string as_filtro_agg)
public function string wf_multi_sel (long row, datawindow adw_origine)
end prototypes

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

public function string wf_multi_sel (long row, datawindow adw_origine);long i, ll_righe, ll_row

if NOT(KeyDown(KeyShift!))And NOT(KeyDown(KeyControl!)) then
	ll_righe=adw_origine.RowCount()
	ll_row=row
	
	for i = 1 to ll_righe
		if i=ll_row then continue
		if adw_origine.IsSelected(i) then adw_origine.SelectRow(i,false)
	next
	
	adw_origine.SelectRow(ll_row, not (adw_origine.isselected(ll_row)))
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
		next
	elseif KeyDown(KeyControl!) then
		
		ll_row=row
		adw_origine.SelectRow(ll_row,Not adw_origine.IsSelected(ll_row))
		
		ll_righe=adw_origine.RowCount()
end if

	

return "W"
end function

on w_art_crea_varie.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_annulla
end on

on w_art_crea_varie.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_annulla)
end on

event open;call super::open;long 	 ll_CurrRow, ll_id_esercizio, ll_id_dis_banca
string ls_sort

tab_1.tabpage_4.dw_prova.SetTransObject(SQLCA)

idw_filtro = tab_1.tabpage_1.dw_filtro_ff
idw_recuperati = tab_1.tabpage_2.dw_recuperati_lt
idw_selezionati = tab_1.tabpage_2.dw_selezionati_lt

DataWindowChild ldw_da_cat_merc_cod, ldw_a_cat_merc_cod
Datawindowchild ldw_da_cat_comm_cod, ldw_a_cat_comm_cod
Datawindowchild ldw_da_cat_fisc_cod, ldw_a_cat_fisc_cod
Datawindowchild ldw_da_tab_iva_cod, ldw_a_tab_iva_cod
Datawindowchild ldw_tipo_cod_barre, ldw_cat_codifica

idw_filtro.GetChild("da_cat_merceologica",ldw_da_cat_merc_cod ) 
idw_filtro.GetChild("a_cat_merceologica",ldw_a_cat_merc_cod )
idw_filtro.GetChild("da_cat_commerciale",ldw_da_cat_comm_cod )
idw_filtro.GetChild("a_cat_commerciale",ldw_a_cat_comm_cod )
idw_filtro.GetChild("da_cat_fiscale",ldw_da_cat_fisc_cod )
idw_filtro.GetChild("a_cat_fiscale",ldw_a_cat_fisc_cod )
idw_filtro.GetChild("da_tab_iva",ldw_da_tab_iva_cod )
idw_filtro.GetChild("a_tab_iva",ldw_a_tab_iva_cod )
idw_filtro.GetChild("id_cat_codifica",ldw_cat_codifica )


tab_1.tabpage_3.dw_gen_automatica_ext.GetChild("id_tipo_cod_barre", ldw_tipo_cod_barre)

ldw_cat_codifica.settransobject(sqlca)
ldw_cat_codifica.retrieve()

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

ldw_tipo_cod_barre.settransobject(sqlca)
ldw_tipo_cod_barre.retrieve()

ib_removing = FALSE

idw_recuperati.SetTransObject(SQLCA)

tab_1.tabpage_2.dw_gen_automatica_cntrec_ff.SetTransObject(SQLCA)

idw_filtro.InsertRow(0)

tab_1.tabpage_3.dw_gen_automatica_ext.InsertRow(0)


idw_filtro.postevent("ue_post_open")
idw_selezionati.postevent("ue_post_open")

idw_filtro.SetFocus()

tab_1.tabpage_3.dw_risultato.settransobject(sqlca)
end event

type tab_1 from tab within w_art_crea_varie
integer x = 27
integer y = 120
integer width = 3378
integer height = 1416
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;if newindex=2 then
	long ll_Rows, ll_i, ll_CurrRow, ll_id_cat_codifica
	
	Datetime ld_da_data_ora,ld_a_data_ora 
	String   ls_filtro,ls_da_cat_merc,ls_a_cat_merc,ls_da_cat_comm,ls_a_cat_comm
	String   ls_da_cat_fisc,ls_a_cat_fisc,ls_da_fornitore,ls_a_fornitore,ls_da_produttore,ls_a_produttore
	String   ls_da_tab_iva, ls_a_tab_iva, ls_solo_unita_conf_base
	Integer  ret

	ll_Rows = idw_selezionati.RowCount()
	
	ib_removing = TRUE
	idw_selezionati.SetRow(1)
	
	FOR ll_i = ll_Rows TO 1 STEP -1
		idw_selezionati.rowsmove(ll_i,ll_i,primary!,idw_recuperati,1,primary!)
	NEXT
	
	
	ib_removing = FALSE
	String ls_da_articolo, ls_a_articolo
	
	ls_da_articolo = idw_filtro.GetItemString(1, "da_articolo_cod")
	ls_a_articolo  = idw_filtro.GetItemString(1, "a_articolo_cod")
	
	idw_filtro.AcceptText()
	
	ls_da_cat_merc=idw_filtro.getitemstring(1,"da_cat_merceologica")
	ls_a_cat_merc=idw_filtro.getitemstring(1,"a_cat_merceologica")
	ls_da_cat_comm=idw_filtro.getitemstring(1,"da_cat_commerciale")
	ls_a_cat_comm=idw_filtro.getitemstring(1,"a_cat_commerciale")
	ls_da_cat_fisc=idw_filtro.getitemstring(1,"da_cat_fiscale")
	ls_a_cat_fisc=idw_filtro.getitemstring(1,"a_cat_fiscale")
	ls_da_fornitore=idw_filtro.getitemstring(1,"da_fornitore_cod")	
	ls_a_fornitore=idw_filtro.getitemstring(1,"a_fornitore_cod")	
	ls_da_produttore=idw_filtro.getitemstring(1,"da_produttore_des")
	ls_a_produttore=idw_filtro.getitemstring(1,"a_produttore_des")	
	ls_da_tab_iva=idw_filtro.getitemstring(1,"da_tab_iva")	
	ls_a_tab_iva=idw_filtro.getitemstring(1,"a_tab_iva")
	ld_da_data_ora=idw_filtro.getitemdatetime(1,"da_data_ora")
	ld_a_data_ora=idw_filtro.getitemdatetime(1,"a_data_ora")
	//20221110
	ll_id_cat_codifica=idw_filtro.getitemnumber(1,"id_cat_codifica")
	
	ls_solo_unita_conf_base = idw_filtro.getitemstring(1, "solo_unita_conf_base")
	
		
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
	
	
	
	
	If ls_da_articolo <> ''and ls_filtro = '' then
		ls_filtro="articolo.codice>="+"'"+ls_da_articolo+"'"
	elseif ls_da_articolo <> '' and ls_filtro <> '' then
		ls_filtro=ls_filtro+" AND articolo.codice>="+"'"+ls_da_cat_merc+"'"
	End if
	
	If ls_a_articolo <> '' and ls_filtro = '' then
		ls_filtro="articolo.codice<="+"'"+ls_a_articolo+"'"
	elseif ls_a_articolo <> '' and ls_filtro <> '' then
		ls_filtro=ls_filtro+" and articolo.codice<="+"'"+ls_a_articolo+"'"
	End if
	
	
	If ls_da_cat_comm<>''and ls_filtro='' then
		ls_filtro="cat_com_articolo.codice>="+"'"+ls_da_cat_comm+"'"
	elseif ls_da_cat_comm<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" AND cat_com_articolo.codice>="+"'"+ls_da_cat_comm+"'"
	end if
	//20221110
	If ll_id_cat_codifica>0 and ls_filtro='' then
		ls_filtro="articolo.id_cat_codifica="+string(ll_id_cat_codifica)+" "
	elseif ls_da_cat_comm<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" AND articolo.id_cat_codifica="+string(ll_id_cat_codifica)+" "
	end if
	
	
	
	If ls_da_cat_merc <> ''and ls_filtro = '' then
		ls_filtro="cat_merceologica.codice>="+"'"+ls_da_cat_merc+"'"
	elseif ls_da_cat_merc <> '' and ls_filtro <> '' then
		ls_filtro=ls_filtro+" AND cat_merceologica.codice>="+"'"+ls_da_cat_merc+"'"
	End if
	
	If ls_a_cat_merc <> '' and ls_filtro = '' then
		ls_filtro="cat_merceologica.codice<="+"'"+ls_a_cat_merc+"'"
	elseif ls_a_cat_merc <> '' and ls_filtro <> '' then
		ls_filtro=ls_filtro+" and cat_merceologica.codice<="+"'"+ls_a_cat_merc+"'"
	End if
	
	
	If ls_da_cat_comm<>''and ls_filtro='' then
		ls_filtro="cat_com_articolo.codice>="+"'"+ls_da_cat_comm+"'"
	elseif ls_da_cat_comm<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" AND cat_com_articolo.codice>="+"'"+ls_da_cat_comm+"'"
	end if
	
	if ls_a_cat_comm <> '' and ls_filtro = '' then
		ls_filtro="cat_com_articolo.codice<="+"'"+ls_a_cat_comm+"'"
	elseif ls_a_cat_comm<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" AND cat_com_articolo.codice<="+"'"+ls_a_cat_comm+"'"
	end if
	
	
	if ls_da_cat_fisc <> '' and ls_filtro = '' then
		ls_filtro="cat_fiscale.codice>="+"'"+ls_da_cat_fisc+"'"
	elseif ls_da_cat_fisc <> ''and ls_filtro <> '' then
		ls_filtro=ls_filtro+" AND cat_fiscale.codice>="+"'"+ls_da_cat_fisc+"'"
	end if
	
	if ls_a_cat_fisc <> ''and ls_filtro = '' then
		ls_filtro="cat_fiscale.codice<="+"'"+ls_a_cat_fisc+"'"
	elseif ls_a_cat_fisc<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" AND cat_fiscale.codice<="+"'"+ls_a_cat_fisc+"'"
	end if
	
	
	if ls_da_fornitore <> '' and ls_filtro = '' then
		ls_filtro="sog_commerciale.codice>="+"'"+ls_da_fornitore+"'"
	elseif ls_da_fornitore <> '' and ls_filtro <> '' then
		ls_filtro=ls_filtro+" AND sog_commerciale.codice>="+"'"+ls_da_fornitore+"'"
	end if
	
	if ls_a_fornitore <> '' and ls_filtro = '' then
		ls_filtro="sog_commerciale_codice<="+"'"+ls_a_fornitore+"'"
	elseif ls_a_fornitore<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" AND sog_commerciale.codice<="+"'"+ls_a_fornitore+"'"
	end if
	
	
	if ls_da_produttore <> ''and ls_filtro = '' then
		ls_filtro="anagrafica.rag_soc_1>="+"'"+ls_da_produttore+"'"
	elseif ls_da_produttore<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" AND anagrafica.rag_soc_1>="+"'"+ls_da_produttore+"'"
	end if
	
	if ls_a_produttore<>''and ls_filtro='' then
		ls_filtro="anagrafica.rag_soc_1<="+"'"+ls_a_produttore+"'"
	elseif ls_a_produttore<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" and anagrafica.rag_soc_1<="+"'"+ls_a_produttore+"'"
	end if
	
	
	if ls_da_tab_iva <> '' and ls_filtro = '' then
		ls_filtro="tab_iva.codice>="+"'"+ls_da_tab_iva+"'"
	elseif ls_da_tab_iva<>''and ls_filtro<>'' then
		ls_filtro=ls_filtro+" AND tab_iva.codice>="+"'"+ls_da_tab_iva+"'"
	end if
	
	if ls_a_tab_iva <> '' and ls_filtro = '' then
		ls_filtro="tab_iva.codice<="+"'"+ls_a_tab_iva+"'"
	elseif ls_a_tab_iva <> '' and ls_filtro <> '' then
		ls_filtro=ls_filtro+" AND tab_iva.codice<="+"'"+ls_a_tab_iva+"'"
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
	
	
	if ls_solo_unita_conf_base= 'S' then
		if ls_filtro = '' then
			ls_filtro="unita_confezione.unita_base = 'S'"
		else
			ls_filtro=ls_filtro + " AND unita_confezione.unita_base = 'S'"
		end if
	end if
	
	is_filter = ls_filtro
	
	idw_recuperati.retrieve()
	idw_recuperati.setfocus()
	
	tab_1.tabpage_2.dw_gen_automatica_cntrec_ff.Retrieve()
end if


if newindex=4 then
   tab_1.tabpage_4.dw_prova.reset()
   tab_1.tabpage_4.dw_prova.retrieve()
	
end if



end event

event selectionchanging;choose case newindex
	case 2
		if (oldindex=3  or oldindex=4) then
			return 1
		end if
end choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3342
integer height = 1296
long backcolor = 79741120
string text = "Filtra"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_filtro_ff dw_filtro_ff
end type

on tabpage_1.create
this.dw_filtro_ff=create dw_filtro_ff
this.Control[]={this.dw_filtro_ff}
end on

on tabpage_1.destroy
destroy(this.dw_filtro_ff)
end on

type dw_filtro_ff from u_dw_ext_main within tabpage_1
integer x = 23
integer y = 36
integer width = 3278
integer height = 1236
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Filtro Articoli/Unità Confezioni"
string dataobject = "d_sel_articoli_new"
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

event ue_init;is_colonne_drop[1]  = "id_tipo_pagamento_cod"
is_colonne_drop[2]  = "id_tipo_pagamento_des"
is_colonne_drop[3]  = "id_banca_azienda"
is_colonne_drop[4]  = "id_banca_azienda_pres"
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

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3342
integer height = 1296
long backcolor = 79741120
string text = "Seleziona"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_recuperati_lt dw_recuperati_lt
dw_selezionati_lt dw_selezionati_lt
cb_drop_all cb_drop_all
cb_drop_many cb_drop_many
cb_remove_many cb_remove_many
cb_remove_all cb_remove_all
dw_gen_automatica_cntrec_ff dw_gen_automatica_cntrec_ff
end type

on tabpage_2.create
this.dw_recuperati_lt=create dw_recuperati_lt
this.dw_selezionati_lt=create dw_selezionati_lt
this.cb_drop_all=create cb_drop_all
this.cb_drop_many=create cb_drop_many
this.cb_remove_many=create cb_remove_many
this.cb_remove_all=create cb_remove_all
this.dw_gen_automatica_cntrec_ff=create dw_gen_automatica_cntrec_ff
this.Control[]={this.dw_recuperati_lt,&
this.dw_selezionati_lt,&
this.cb_drop_all,&
this.cb_drop_many,&
this.cb_remove_many,&
this.cb_remove_all,&
this.dw_gen_automatica_cntrec_ff}
end on

on tabpage_2.destroy
destroy(this.dw_recuperati_lt)
destroy(this.dw_selezionati_lt)
destroy(this.cb_drop_all)
destroy(this.cb_drop_many)
destroy(this.cb_remove_many)
destroy(this.cb_remove_all)
destroy(this.dw_gen_automatica_cntrec_ff)
end on

type dw_recuperati_lt from u_dw_pura within tabpage_2
integer x = 23
integer y = 36
integer width = 1490
integer height = 824
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Ricercati"
string dataobject = "d_gen_automatica_lt"
boolean hscrollbar = true
boolean vscrollbar = true
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
If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + 'AND ' + is_filter + ' ORDER BY articolo.codice'
	This.SetSQLPreview(ls_SQLSyntax)
End If
end event

type dw_selezionati_lt from u_dw_pura within tabpage_2
integer x = 1815
integer y = 36
integer width = 1490
integer height = 824
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Selezionati"
string dataobject = "d_gen_automatica_lt"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_drop_all from commandbutton within tabpage_2
integer x = 1541
integer y = 300
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;long 		ll_Rows, ll_i, ll_CurrRow,contatore
decimal  ldc_tot_scadenza_importo 

ll_Rows = tab_1.tabpage_2.dw_gen_automatica_cntrec_ff.GetItemNumber(1, "num_record")

ib_removing = TRUE
idw_recuperati.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
		idw_recuperati.ScrollToRow (ll_i) 		
		idw_recuperati.rowsmove(ll_i,ll_i,primary!,idw_selezionati,1,primary!)
		contatore=contatore+1
		idw_selezionati.selectrow(contatore,true)
NEXT

idw_selezionati.Sort()

tab_1.tabpage_2.dw_gen_automatica_cntrec_ff.Object.art_selezionati[1] = ll_rows

ib_removing = FALSE

dw_selezionati_lt.setfocus()


end event

type cb_drop_many from commandbutton within tabpage_2
integer x = 1541
integer y = 420
integer width = 247
integer height = 88
integer taborder = 30
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

ll_Rows = idw_recuperati.RowCount()

ib_removing = TRUE
idw_recuperati.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF idw_recuperati.IsSelected(ll_i) THEN
		contatore=contatore+1

		idw_recuperati.rowsmove(ll_i,ll_i,primary!,idw_selezionati,1,primary!)
		idw_selezionati.selectrow(contatore,true)
		
	END IF
NEXT

ll_contatore = Tab_1.tabpage_2.dw_gen_automatica_cntrec_ff.Object.art_selezionati[1]
contatore = contatore + ll_contatore

Tab_1.tabpage_2.dw_gen_automatica_cntrec_ff.Object.art_selezionati[1] = contatore

idw_selezionati.Sort()

ib_removing = FALSE

dw_selezionati_lt.setfocus()
end event

type cb_remove_many from commandbutton within tabpage_2
integer x = 1541
integer y = 640
integer width = 247
integer height = 88
integer taborder = 40
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;long 		ll_Rows, ll_i, ll_CurrRow
decimal  ldc_tot_scadenza_importo

ll_Rows = idw_selezionati.RowCount()

ib_removing = TRUE
idw_selezionati.SetRow(1)

for ll_i = ll_Rows to 1 step -1
	if idw_selezionati.IsSelected(ll_i) then
		idw_selezionati.rowsmove(ll_i,ll_i,primary!,idw_recuperati,1,primary!)	
	end if
next

idw_recuperati.Sort()

ib_removing = FALSE
long contatore
contatore=dw_selezionati_lt.rowcount()

Tab_1.tabpage_2.dw_gen_automatica_cntrec_ff.Object.art_selezionati[1] = contatore
end event

type cb_remove_all from commandbutton within tabpage_2
integer x = 1541
integer y = 760
integer width = 247
integer height = 88
integer taborder = 50
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;long ll_Rows, ll_i, ll_CurrRow

ll_Rows = idw_selezionati.RowCount()

ib_removing = TRUE
idw_selezionati.SetRow(1)

for ll_i = ll_Rows to 1 step -1
	idw_selezionati.rowsmove(ll_i,ll_i,primary!,idw_recuperati,1,primary!)
next

idw_recuperati.Sort()

ib_removing = FALSE
long i,contatore
contatore=dw_selezionati_lt.rowcount()
	
Tab_1.tabpage_2.dw_gen_automatica_cntrec_ff.Object.art_selezionati[1] = contatore
end event

type dw_gen_automatica_cntrec_ff from u_dw_pura within tabpage_2
integer x = 27
integer y = 924
integer width = 3273
integer height = 152
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_gen_automatica_cntrec_ff"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event sqlpreview;
If is_filter <> "" Then
	String Ls_SQLSyntax

	ls_SQLSyntax = SQLSyntax + 'AND ' + is_filter
	This.SetSQLPreview(ls_SQLSyntax)
End If
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3342
integer height = 1296
long backcolor = 79741120
string text = "Generazione"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_1 cb_1
dw_risultato dw_risultato
dw_gen_automatica_ext dw_gen_automatica_ext
cb_genera cb_genera
end type

on tabpage_3.create
this.cb_1=create cb_1
this.dw_risultato=create dw_risultato
this.dw_gen_automatica_ext=create dw_gen_automatica_ext
this.cb_genera=create cb_genera
this.Control[]={this.cb_1,&
this.dw_risultato,&
this.dw_gen_automatica_ext,&
this.cb_genera}
end on

on tabpage_3.destroy
destroy(this.cb_1)
destroy(this.dw_risultato)
destroy(this.dw_gen_automatica_ext)
destroy(this.cb_genera)
end on

type cb_1 from commandbutton within tabpage_3
integer x = 1518
integer y = 276
integer width = 270
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;//if dw_selezionati_lt.rowcount()<=0 then 
//	messagebox('Attenzione', 'Non è stato selezionato nessun articolo!')
//else
	OpenWithParm ( w_st_cb_articoli, dw_risultato)
//end if	
end event

type dw_risultato from udw_001 within tabpage_3
integer x = 46
integer y = 376
integer width = 3246
integer height = 844
integer taborder = 40
string dataobject = "d_crea_cb_articolo"
end type

event retrievestart;call super::retrievestart;return 2
end event

type dw_gen_automatica_ext from u_dw_ext_main within tabpage_3
integer x = 46
integer y = 52
integer width = 1394
integer height = 308
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Tipo di codice a barre"
string dataobject = "d_gen_automatica_ext"
end type

type cb_genera from commandbutton within tabpage_3
integer x = 1518
integer y = 60
integer width = 270
integer height = 84
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Genera"
end type

event clicked;long ll_id_articolo,ll_riga
integer i
string ls_articolo, ls_codice, ls_codice_ok,ls_check, ls_stato

for i= 1 to tab_1.tabpage_2.dw_selezionati_lt.rowcount()
	ll_id_articolo=tab_1.tabpage_2.dw_selezionati_lt.getitemnumber(i, "id_articolo")
	ls_articolo=string(ll_id_articolo)
	ls_stato='80'
	do while len(ls_articolo)<10
		ls_articolo="0"+ls_articolo
	loop
	ls_codice= ls_stato+ls_articolo
	ls_check=string(f_check_digit(ls_codice, 13))
	
	ls_codice+= ls_check
	ls_codice_ok=f_crea_codice_a_barre(ls_codice)
	
	ll_riga=tab_1.tabpage_3.dw_risultato.retrieve(ll_id_articolo)
	tab_1.tabpage_3.dw_risultato.setitem(ll_riga, "cod_intrastat", ls_codice_ok)
next
tab_1.tabpage_3.dw_risultato.trigger event ue_update()
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 3342
integer height = 1296
long backcolor = 79741120
string text = "Utility"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_prova dw_prova
cb_2 cb_2
r_1 r_1
st_1 st_1
end type

on tabpage_4.create
this.dw_prova=create dw_prova
this.cb_2=create cb_2
this.r_1=create r_1
this.st_1=create st_1
this.Control[]={this.dw_prova,&
this.cb_2,&
this.r_1,&
this.st_1}
end on

on tabpage_4.destroy
destroy(this.dw_prova)
destroy(this.cb_2)
destroy(this.r_1)
destroy(this.st_1)
end on

type dw_prova from u_dw_ext_main within tabpage_4
integer x = 27
integer y = 44
integer width = 2770
integer height = 1216
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Gestione cancellazione Codici a barre"
string dataobject = "d_canc_cod_barre_gd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;wf_multi_sel(row,this)
end event

type cb_2 from commandbutton within tabpage_4
integer x = 2843
integer y = 144
integer width = 443
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancella"
end type

event clicked;long ll_riga, ll_id_codice, li_ret


ll_riga=dw_prova.GetSelectedRow(0)

li_ret=messagebox('Attenzione','Sei sicuro di voler cancellare i codici selezionati?',Question!, YesNo!)
if li_ret=1 then
  DO WHILE ll_riga>0
	  ll_id_codice=dw_prova.getitemnumber(ll_riga,"cod_barre_id_cod_barre")
	  DELETE FROM cod_barre WHERE id_cod_barre = :ll_id_codice;
	  dw_prova.deleterow(ll_riga)	
	  ll_riga=dw_prova.GetSelectedRow(ll_riga - 1)
  LOOP
end if
commit;
end event

type r_1 from rectangle within tabpage_4
long linecolor = 79741120
integer linethickness = 4
long fillcolor = 255
integer x = 2830
integer y = 292
integer width = 64
integer height = 40
end type

type st_1 from statictext within tabpage_4
integer x = 2907
integer y = 280
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Codici doppioni"
boolean focusrectangle = false
end type

type cb_annulla from commandbutton within w_art_crea_varie
integer x = 3136
integer y = 32
integer width = 270
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Chiudi"
end type

event clicked;
close(parent)
end event

