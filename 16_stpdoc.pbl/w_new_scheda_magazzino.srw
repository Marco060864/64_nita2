forward
global type w_new_scheda_magazzino from w_selezione_stampa
end type
type st_1 from statictext within w_new_scheda_magazzino
end type
type cb_stampa_tutto from commandbutton within w_new_scheda_magazzino
end type
type dw_3 from udw_000 within w_new_scheda_magazzino
end type
type dw_2 from udw_000 within w_new_scheda_magazzino
end type
type cb_2 from commandbutton within w_new_scheda_magazzino
end type
type cb_3 from commandbutton within w_new_scheda_magazzino
end type
end forward

global type w_new_scheda_magazzino from w_selezione_stampa
integer x = 2999
integer y = 1000
integer width = 2496
integer height = 1328
boolean maxbox = false
boolean resizable = false
st_1 st_1
cb_stampa_tutto cb_stampa_tutto
dw_3 dw_3
dw_2 dw_2
cb_2 cb_2
cb_3 cb_3
end type
global w_new_scheda_magazzino w_new_scheda_magazzino

type variables
string is_metallo, is_sql_originale
long il_id_sog

end variables

forward prototypes
public subroutine wf_excel_doc ()
public subroutine wf_riempi_dw_excel (long al_row)
public subroutine wf_excel_righe ()
public subroutine wf_excele_righe_modello ()
end prototypes

public subroutine wf_excel_doc ();long ll_riga_inserita,ll_breakrow,  ll_last_row
integer li_gruppo
string ls_causale, ls_rag_sociale, ls_num_doc, ls_cod_articolo, ls_met_titolo, ls_nome_file, ls_path, ls_tipo_stampa
date  ldt_data_doc, ldt_a_data, ldt_da_data
decimal ldc_c_calo, ldc_qta, ldc_legato, ldc_calo, ldc_fino, ldc_finocalo, ldc_prog_legato, ldc_prog_finocalo
//ll_breakrow = 1
dw_3.reset()
ldt_da_data=dw_1.getitemdate(1,"da_data")
ldt_a_data=dw_1.getitemdate(1,"a_data")
ls_tipo_stampa=dw_1.getitemstring(1, "tipo_stampa")
if ls_tipo_stampa="d_new_scheda_mag_all" then
    li_gruppo = 2
else
    li_gruppo = 3
end if
ll_breakrow = dw_2.FindGroupChange(1, li_gruppo)
DO WHILE ll_breakrow > 0
     // Calcola l’ultima riga del gruppo corrente
	if ll_breakrow>1 then
     	ll_last_row = ll_breakrow - 1
  		wf_riempi_dw_excel(ll_last_row)		
    		// Passa al prossimo gruppo
	end if
	 // Trova la prima riga del prossimo gruppo
	ll_breakrow = dw_2.FindGroupChange(ll_breakrow + 1, li_gruppo)
LOOP
//20251018: ultio giro cooincide con l'ultima riga...
ll_last_row = dw_2.RowCount()
wf_riempi_dw_excel(ll_last_row)

ls_path="c:\nita\excel\"
//ls_tipo_stampa=
If not(DirectoryExists ( ls_path)) Then
	createdirectory(ls_path)
end if
if ls_tipo_stampa="d_new_scheda_mag_all" then
	ls_nome_file="Prop_D_"+is_metallo+"_"+string(ldt_da_data,"dd_mm_yy")+"-"+ string(ldt_a_data, "dd_mm_yy")
else
	select rag_soc_1 into :ls_rag_sociale from dba.sog_commerciale_gen where id_sog_commerciale=:il_id_sog;
	do  while left(ls_rag_sociale, 1)="*" 
		ls_rag_sociale=right(ls_rag_sociale, len(ls_rag_sociale) - 1)
	loop
	ls_nome_file="Scheda_D_"+is_metallo+"_"+left(ls_rag_sociale, 8)+string(ldt_da_data,"dd_mm_yy")+"-"+ string(ldt_a_data, "dd_mm_yy")
end if

dw_3.saveas(ls_path+ls_nome_file+".xls", Excel!, true)


end subroutine

public subroutine wf_riempi_dw_excel (long al_row);long ll_riga_inserita,ll_breakrow

string ls_causale, ls_rag_sociale, ls_num_doc, ls_cod_articolo, ls_met_titolo, ls_tipo_partita,ls_path,  ls_nome_file
date  ldt_data_doc
decimal ldc_c_calo, ldc_qta, ldc_legato, ldc_calo, ldc_fino, ldc_finocalo, ldc_prog_legato, ldc_prog_finocalo


ls_tipo_partita=dw_2.getitemstring(al_row, "c_tipo_partita")
ls_causale       = dw_2.getitemstring(al_row, "caus_magazzino_codice")
ls_rag_sociale   = dw_2.getitemstring(al_row, "c_rag_sociale")
ls_num_doc       = dw_2.getitemstring(al_row, "num_documento")
 ldt_data_doc     = dw_2.getitemdate(al_row, "data_documento")
ls_cod_articolo  = dw_2.getitemstring(al_row, "articolo_codice")
ls_met_titolo    = dw_2.getitemstring(al_row, "compute_1")
ldc_qta          = dw_2.getitemdecimal(al_row, "c_qta_doc")
ldc_legato       = dw_2.getitemdecimal(al_row, "c_legato_doc")
ldc_calo         = dw_2.getitemdecimal(al_row, "c_calo_doc")
ldc_fino         = dw_2.getitemdecimal(al_row, "c_fino_doc")
ldc_finocalo     = dw_2.getitemdecimal(al_row, "c_finocalo_doc")
ldc_prog_legato  = dw_2.getitemdecimal(al_row, "c_prog_legato_doc")
ldc_prog_finocalo= dw_2.getitemdecimal(al_row, "c_prog_fc_doc")

ll_riga_inserita = dw_3.insertrow(0)

dw_3.setitem(ll_riga_inserita, "tipo_partita", ls_tipo_partita)
dw_3.setitem(ll_riga_inserita, "causale", ls_causale)
dw_3.setitem(ll_riga_inserita, "rag_soc_1", ls_rag_sociale)
dw_3.setitem(ll_riga_inserita, "num_doc", ls_num_doc)
dw_3.setitem(ll_riga_inserita, "data_doc", ldt_data_doc)
dw_3.setitem(ll_riga_inserita, "articolo", ls_cod_articolo)
dw_3.setitem(ll_riga_inserita, "titolo", ls_met_titolo)
dw_3.setitem(ll_riga_inserita, "qta", ldc_qta)
dw_3.setitem(ll_riga_inserita, "legato", ldc_legato)
dw_3.setitem(ll_riga_inserita, "calo", ldc_calo)
dw_3.setitem(ll_riga_inserita, "fino", ldc_fino)
dw_3.setitem(ll_riga_inserita, "fino_calo", ldc_finocalo)
dw_3.setitem(ll_riga_inserita, "prog_legato", ldc_prog_legato)
dw_3.setitem(ll_riga_inserita, "prog_fino_calo", ldc_prog_finocalo)


end subroutine

public subroutine wf_excel_righe ();long i, ll_riga_inserita
string ls_causale, ls_rag_sociale, ls_num_doc, ls_cod_articolo, ls_met_titolo, ls_nome_file, ls_path,ls_tipo_stampa
date  ldt_data_doc, ldt_da_data, ldt_a_data
decimal ldc_c_calo, ldc_qta, ldc_legato, ldc_calo, ldc_fino, ldc_finocalo, ldc_prog_legato, ldc_prog_finocalo


ldt_da_data=dw_1.getitemdate(1,"da_data")
ldt_a_data=dw_1.getitemdate(1,"a_data")
dw_3.reset()
for i=1 to dw_2.rowcount()
	
	ls_causale=dw_2.getitemstring(i, "caus_magazzino_codice")
	ls_rag_sociale=dw_2.getitemstring(i, "c_rag_sociale")
	ls_num_doc=dw_2.getitemstring(i, "num_documento")
	ldt_data_doc=dw_2.getitemdate(i, "data_documento")
	ls_cod_articolo=dw_2.getitemstring(i, "articolo_codice")
	ls_met_titolo=dw_2.getitemstring(i, "compute_1")
	ldc_c_calo=dw_2.getitemdecimal(i, "coef_calo")
	ldc_qta=dw_2.getitemdecimal(i, "quantita")
	ldc_legato=dw_2.getitemdecimal(i, "c_peso_netto")
	ldc_calo=dw_2.getitemdecimal(i, "c_calo")
	ldc_fino=dw_2.getitemdecimal(i, "c_fino")
	ldc_finocalo=dw_2.getitemdecimal(i, "c_finocalo")
	ldc_prog_legato=dw_2.getitemdecimal(i, "c_prog_legato_riga")
	ldc_prog_finocalo=dw_2.getitemdecimal(i, "c_prog_fc_riga")
	ll_riga_inserita=dw_3.insertrow(0)
	dw_3.setitem(ll_riga_inserita, "causale", ls_causale)
	dw_3.setitem(ll_riga_inserita, "rag_soc_1", ls_rag_sociale)
	dw_3.setitem(ll_riga_inserita, "num_doc", ls_num_doc)
	dw_3.setitem(ll_riga_inserita, "data_doc", ldt_data_doc)
	dw_3.setitem(ll_riga_inserita, "articolo", ls_cod_articolo)
	dw_3.setitem(ll_riga_inserita, "titolo", ls_met_titolo)
	dw_3.setitem(ll_riga_inserita, "coef_calo", ldc_c_calo )
	dw_3.setitem(ll_riga_inserita, "qta", ldc_qta)
	dw_3.setitem(ll_riga_inserita, "legato", ldc_legato)
	dw_3.setitem(ll_riga_inserita, "calo", ldc_calo)
	dw_3.setitem(ll_riga_inserita, "fino", ldc_fino)
	dw_3.setitem(ll_riga_inserita, "fino_calo", ldc_finocalo)
	dw_3.setitem(ll_riga_inserita, "prog_legato", ldc_prog_legato)
	dw_3.setitem(ll_riga_inserita, "prog_fino_calo", ldc_prog_finocalo)
next
ls_path="c:\nita\excel\"
If not(DirectoryExists ( ls_path)) Then
	createdirectory(ls_path)
end if
if ls_tipo_stampa="d_new_scheda_mag_all" then
	ls_nome_file="Prop_"+is_metallo+"_"+string(ldt_da_data,"dd_mm_yy")+"-"+ string(ldt_a_data, "dd_mm_yy")
else
	select rag_soc_1 into :ls_rag_sociale from dba.sog_commerciale_gen where id_sog_commerciale=:il_id_sog;
	do  while left(ls_rag_sociale, 1)="*" 
		ls_rag_sociale=right(ls_rag_sociale, len(ls_rag_sociale) - 1)
	loop
	ls_nome_file="Scheda_"+is_metallo+"_"+left(ls_rag_sociale, 8)+string(ldt_da_data,"dd_mm_yy")+"-"+ string(ldt_a_data, "dd_mm_yy")
end if

dw_3.saveas(ls_path+ls_nome_file+".xls", Excel!, true)
end subroutine

public subroutine wf_excele_righe_modello ();long i, ll_riga_inserita, ll_id_doc
string ls_causale, ls_rag_sociale, ls_num_doc, ls_cod_articolo, ls_met_titolo, ls_nome_file, ls_path,ls_tipo_stampa
date  ldt_data_doc, ldt_da_data, ldt_a_data
decimal ldc_c_calo, ldc_qta, ldc_legato, ldc_calo, ldc_fino, ldc_finocalo, ldc_prog_legato, ldc_prog_finocalo


ldt_da_data=dw_1.getitemdate(1,"da_data")
ldt_a_data=dw_1.getitemdate(1,"a_data")
dw_3.reset()
for i=1 to dw_2.rowcount()
	
	ls_causale=dw_2.getitemstring(i, "caus_magazzino_codice")
	ls_rag_sociale=dw_2.getitemstring(i, "c_rag_sociale")
	ls_num_doc=dw_2.getitemstring(i, "num_documento")
	ldt_data_doc=dw_2.getitemdate(i, "data_documento")
	ls_cod_articolo=dw_2.getitemstring(i, "articolo_codice")
	ls_met_titolo=dw_2.getitemstring(i, "compute_1")
	ldc_c_calo=dw_2.getitemdecimal(i, "coef_calo")
	ldc_qta=dw_2.getitemdecimal(i, "quantita")
	ldc_legato=dw_2.getitemdecimal(i, "c_peso_netto")
	ldc_calo=dw_2.getitemdecimal(i, "c_calo")
	ldc_fino=dw_2.getitemdecimal(i, "c_fino")
	ldc_finocalo=dw_2.getitemdecimal(i, "c_finocalo")
	ldc_prog_legato=dw_2.getitemdecimal(i, "c_prog_legato_riga")
	ldc_prog_finocalo=dw_2.getitemdecimal(i, "c_prog_fc_riga")
	


	ll_riga_inserita=dw_3.insertrow(0)
	dw_3.setitem(ll_riga_inserita, "causale", ls_causale)
	dw_3.setitem(ll_riga_inserita, "rag_soc_1", ls_rag_sociale)
	dw_3.setitem(ll_riga_inserita, "num_doc", ls_num_doc)
	dw_3.setitem(ll_riga_inserita, "data_doc", ldt_data_doc)
	dw_3.setitem(ll_riga_inserita, "articolo", ls_cod_articolo)
	dw_3.setitem(ll_riga_inserita, "titolo", ls_met_titolo)
	dw_3.setitem(ll_riga_inserita, "coef_calo", ldc_c_calo )
	dw_3.setitem(ll_riga_inserita, "qta", ldc_qta)
	dw_3.setitem(ll_riga_inserita, "legato", ldc_legato)
	dw_3.setitem(ll_riga_inserita, "calo", ldc_calo)
	dw_3.setitem(ll_riga_inserita, "fino", ldc_fino)
	dw_3.setitem(ll_riga_inserita, "fino_calo", ldc_finocalo)
	dw_3.setitem(ll_riga_inserita, "prog_legato", ldc_prog_legato)
	dw_3.setitem(ll_riga_inserita, "prog_fino_calo", ldc_prog_finocalo)
next
ls_path="c:\nita\excel\"
If not(DirectoryExists ( ls_path)) Then
	createdirectory(ls_path)
end if
if ls_tipo_stampa="d_new_scheda_mag_all" then
	ls_nome_file="Prop_"+is_metallo+"_"+string(ldt_da_data,"dd_mm_yy")+"-"+ string(ldt_a_data, "dd_mm_yy")
else
	select rag_soc_1 into :ls_rag_sociale from dba.sog_commerciale_gen where id_sog_commerciale=:il_id_sog;
	do  while left(ls_rag_sociale, 1)="*" 
		ls_rag_sociale=right(ls_rag_sociale, len(ls_rag_sociale) - 1)
	loop
	ls_nome_file="Scheda_"+is_metallo+"_"+left(ls_rag_sociale, 8)+string(ldt_da_data,"dd_mm_yy")+"-"+ string(ldt_a_data, "dd_mm_yy")
end if

dw_3.saveas(ls_path+ls_nome_file+".xls", Excel!, true)


//		// Creazione dell'oggetto Excel
//		
//		OLEObject excel
//		excel = CREATE OLEObject
//		IF excel.ConnectToNewObject("Excel.Application") <> 0 THEN
//			 MessageBox("Errore", "Impossibile connettersi a Excel")
//			 RETURN
//		END IF
//		
//		// Rendere visibile Excel (utile per debugging)
//		excel.Visible = TRUE  
//		
//		// Apri il file dei dati esportati
//		OLEObject workbook
//		OLEObject sheetData
//		workbook = excel.Workbooks.Open(LS_NOME_FILE+".XLS")
//		sheetData = workbook.Sheets(1)
//		
//		// Apri il file template **prima** di copiare i dati
//		OLEObject templateWorkbook
//		ls_versione_office=string(excel.Version)
//		if pos(ls_versione_office, "8.0")>0 then
//			templateWorkbook = excel.Workbooks.Open("c:\nita\excel\modelli\modello.xlt")
//		else
//			templateWorkbook = excel.Workbooks.Open("c:\nita\excel\modelli\modello.xls")
//		end if
//		// Attivare il template come file attivo
//		//templateWorkbook.Activate()
//		// Selezionare il foglio corretto nel template
//		OLEObject sheetTemplate
//		sheetTemplate = templateWorkbook.Sheets(1)
//		
//		// Copiare i dati dal file dati e incollarli nel template
//		sheetData.UsedRange.Copy()
//		//MessageBox("Debug", "Dati copiati correttamente?")
//		sheetTemplate.Range("A2").Select()
//		sheetTemplate.Paste()
//		//sheetTemplate.Range("A2").PasteSpecial(-4122)  // Incolla solo valori
//		//20250623 metto anche l'id utente
//		ll_id_utente=u_freddie.s_utenti.i_idutente
//		// Salva il file risultante con un nuovo nome
//		templateWorkbook.SaveAs(LS_NOME_FILE+"_"+string(ll_id_utente)+"_OK.xls")
//		
//		// Chiudi i file e Excel correttamente
//		workbook.Close(FALSE)  // Chiude il file dei dati senza salvare modifiche
//		templateWorkbook.Close(TRUE)  // Salva e chiude il template
//		excel.Quit()
//		DESTROY excel


end subroutine

event open;call super::open;datawindowchild ldw_sog_comm, ldw_metallo, ldw_sog_comm2,ldw_tipo_partita,ldw_articolo

string ls_cod
date ld_data
long ll_righe

dw_1.getchild("id_sog_comm", ldw_sog_comm)
ldw_sog_comm.settransobject(sqlca)
ll_righe=ldw_sog_comm.retrieve()

dw_1.getchild("id_sog_comm2", ldw_sog_comm2)
ldw_sog_comm2.settransobject(sqlca)
ll_righe=ldw_sog_comm2.retrieve()

dw_1.getchild("metallo", ldw_metallo)
ldw_metallo.settransobject(sqlca)
ll_righe=ldw_metallo.retrieve()

dw_1.getchild("tipo_partita", ldw_tipo_partita)
ldw_tipo_partita.settransobject(sqlca)
ll_righe=ldw_tipo_partita.retrieve()

dw_1.getchild("id_articolo", ldw_articolo)
ldw_articolo.settransobject(sqlca)
ll_righe=ldw_articolo.retrieve()

dw_1.insertrow(1)


ld_data=today()
dw_1.setitem(1, "a_data", ld_data)
select data_inizio
into :ld_data
from esercizio 
where data_inizio<=:ld_data
and data_fine>=:ld_data
;
if sqlca.sqlcode=0 then
	dw_1.setitem(1, "solo_preziosi",ls_cod)
	dw_1.setitem(1, "da_data", ld_data)
else
	messagebox("Errore!", "Esercizio non recuperato: confronta esercizio corrente in dati azienda")
end if

//dw_1.setitem(1, "tipo_stampa","d_new_scheda_magazzino_test2")
dw_1.setitem(1, "tipo_stampa","d_new_scheda_clfo_cl")

dw_2.settransobject(sqlca)
end event

on w_new_scheda_magazzino.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_stampa_tutto=create cb_stampa_tutto
this.dw_3=create dw_3
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_stampa_tutto
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
end on

on w_new_scheda_magazzino.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_stampa_tutto)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event ue_postopen;call super::ue_postopen;datawindowchild ldw_dest
long ll_righe, ll_id_sog

dw_1.getchild("destinazione", ldw_dest)
ldw_dest.settransobject(sqlca)
ll_id_sog=dw_1.getitemnumber(1, "id_sog_comm")
if ll_id_sog>0 then
	ll_righe=ldw_dest.retrieve(ll_id_sog)
end if
end event

type cb_1 from w_selezione_stampa`cb_1 within w_new_scheda_magazzino
integer x = 1431
integer y = 404
end type

type cb_stampa from w_selezione_stampa`cb_stampa within w_new_scheda_magazzino
integer x = 1435
integer y = 580
end type

event cb_stampa::clicked;call super::clicked;date ld_da_data,ld_a_data
s_new_scheda_mag s_new_mag
long ll_id_sog
string ls_parametri, ls_rag_destinazione, ls_rag_soc,ls_cod_dest
decimal ldc_titolo

dw_1.accepttext()
ld_da_data=dw_1.getitemdate(1,"da_data")
ld_a_data=dw_1.getitemdate(1,"a_data")
if string(ld_da_data)>'' then ls_parametri=ls_parametri+'Da Data: ' + string(ld_da_data) + " "
if string(ld_a_data)>'' then ls_parametri=ls_parametri+'A Data: ' + string(ld_a_data) + " "
If ld_da_data > ld_a_data then
	MessageBox("Stampa Fatturato","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If
s_new_mag.da_data=ld_da_data
s_new_mag.a_data=ld_a_data
s_new_mag.id_sog_commerciale=dw_1.getitemnumber(1, "id_sog_comm")
Select rag_soc_1 into :ls_rag_soc from dba.sog_commerciale_gen where id_sog_commerciale=:s_new_mag.id_sog_commerciale;
if ls_rag_soc> " " then ls_parametri+=" - Per: "+left(ls_rag_soc, 10)
s_new_mag.tipo_stampa=dw_1.getitemstring(1, "tipo_stampa")
s_new_mag.id_destinazione=dw_1.getitemnumber(1, "destinazione")
//str_param.coef_calo=dw_1.getitemdecimal(1, "aliquota_ritenuta")
s_new_mag.sel_causali=dw_1.getitemstring(1, "sel_causali")
s_new_mag.metallo=dw_1.getitemstring(1, "metallo")
if isnull(s_new_mag.metallo) or s_new_mag.metallo<=" " then
	MessageBox("Stampa Magazzino","Devi obbligatoriamente scegliere un metallo!",exclamation!)
	return
else
	ls_parametri+=" - Metallo: "+s_new_mag.metallo
end if
//20221010 aggiungo la possibilità di scegliere un secondo soggetto per fare stampa cumulativa (RB GIOIELLI e -RBGIOIELLI ad es. sono lo stesso fornitore!!!)
s_new_mag.id_sog_commerciale2=dw_1.getitemnumber(1, "id_sog_comm2")
//20221010 fine
s_new_mag.id_titolo=dw_1.getitemnumber(1, "id_titolo")
if s_new_mag.id_titolo>0 then
	select titolo into :ldc_titolo from dba.orafo_titolo where id_titolo=:s_new_mag.id_titolo;
	ls_parametri+=" - Titolo: "+ string(ldc_titolo, "#,0.00")
end if
if s_new_mag.id_destinazione>0 then
	select rag_soc_1, codice into :ls_rag_destinazione, :ls_cod_dest from dba.destinazione where id_destinazione=:s_new_mag.id_destinazione;
	if isnull(ls_rag_destinazione) then ls_rag_destinazione=""
	ls_parametri+=" - Dest.: "+ls_rag_destinazione+" "+ls_cod_dest
end if
s_new_mag.filtro=ls_parametri
//20261020 il tipo partita va passato anche alle varianti della scheda per tipo partita (NO ZERO, verticale, 2 soggetti)
if s_new_mag.tipo_stampa="d_new_partite_orafe" or (pos(s_new_mag.tipo_stampa, "d_new_scheda_clfo_cl") > 0 and s_new_mag.tipo_stampa <> "d_new_scheda_clfo_cl_tot_metallo") then 
	s_new_mag.filtro=dw_1.getitemstring(1, "tipo_partita") //20240429 
end if
s_new_mag.id_articolo=dw_1.getitemnumber(1, "id_articolo")
if isnull(s_new_mag.id_articolo) then s_new_mag.id_articolo=0
s_new_mag.fiscale=dw_1.getitemnumber(1, "fiscale")
//20261020 se il report e' gia' aperto OpenWithParm lo riporta in primo piano senza ricaricarlo
//(restavano metallo e parametri della prima stampa): lo chiudo e lo riapro con i parametri nuovi
if isvalid(w_new_scheda_magazzino_rpt) then close(w_new_scheda_magazzino_rpt)
OpenWithParm(w_new_scheda_magazzino_rpt, s_new_mag)
end event

type dw_1 from w_selezione_stampa`dw_1 within w_new_scheda_magazzino
integer width = 1330
integer height = 1080
string dataobject = "d_new_scheda_mag_st"
end type

event dw_1::doubleclicked;//
end event

event dw_1::itemfocuschanged;//
end event

event dw_1::losefocus;//
end event

event dw_1::rowfocuschanged;//
end event

event dw_1::itemchanged;call super::itemchanged;datawindowchild ldw_dest, ldw_titolo
long ll_righe, ll_id_metallo

if dwo.name="id_sog_comm" then
	dw_1.getchild("destinazione", ldw_dest)
	ldw_dest.settransobject(sqlca)
	ll_righe=ldw_dest.retrieve(long(data))

end if
if dwo.name="metallo" then
	select id_metallo into :ll_id_metallo from dba.orafo_metallo where codice=:data;
	if ll_id_metallo>0 then
		dw_1.getchild("id_titolo", ldw_titolo)
		ldw_titolo.settransobject(sqlca)
		ll_righe=ldw_titolo.retrieve(ll_id_metallo)
	end if
end if

end event

type st_1 from statictext within w_new_scheda_magazzino
integer x = 1426
integer y = 40
integer width = 750
integer height = 344
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 65535
string text = "Attenzione! Se si vogliono i saldi di TUTTI i sog. commerciali allora la data iniziale deve essere il primo giorno dell~'anno!!!"
boolean focusrectangle = false
end type

type cb_stampa_tutto from commandbutton within w_new_scheda_magazzino
integer x = 1883
integer y = 872
integer width = 590
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "St. FINE ANNO CLFO"
end type

event clicked;date ldt_da_data, ldt_a_data
long  ll_righe_sog, ll_righe_met, ll_righe_tot, ll_test
string  ls_tipo_stampa
integer i, a
datastore ds_met_preziosi, ds_cl_fo

if messagebox("Attenzione!", "Vuoi davvero stampare tutta la situazione dei CLIENTI E FORNITORI?", stopsign!, yesno!)=1 then
	ds_cl_fo=create datastore
	ds_cl_fo.dataobject="d_lista_clfo"
	ds_cl_fo.settransobject(sqlca)
	ll_righe_sog=ds_cl_fo.retrieve()
	
	ds_met_preziosi=create datastore
	ds_met_preziosi.dataobject="d_lista_metalli_preziosi"
	ds_met_preziosi.settransobject(sqlca)
	ll_righe_met=ds_met_preziosi.retrieve()
	ldt_da_data=dw_1.getitemdate(1,"da_data")
	ldt_a_data=dw_1.getitemdate(1,"a_data")
	//ls_tipo_stampa=dw_1.getitemstring(1, "tipo_stampa")
	//dw_2.dataobject=ls_tipo_stampa
	//dw_2.settransobject(sqlca)
	is_sql_originale=dw_2.GetSQLSelect()
	for a = 1 to ll_righe_met
		is_metallo=ds_met_preziosi.getitemstring(a, "codice")
		for i=1 to ll_righe_sog
			il_id_sog=ds_cl_fo.getitemnumber(i,  "id_sog_commerciale")
			ll_test=0
			select id_riga_documento into :ll_test from "dba"."riga_documento",  "dba"."documento",    "dba"."articolo",  
				"dba"."orafo_metallo",     "dba"."orafo_titolo" ,  "dba"."caus_magazzino"
			 WHERE ( "caus_magazzino"."id_caus_magazzino" = "riga_documento"."id_caus_magazzino" ) and  
				( "documento"."id_documento" = "riga_documento"."id_documento" ) and  
				( "articolo"."id_articolo" = "riga_documento"."id_articolo" ) and  
				( "orafo_titolo"."id_metallo" = "orafo_metallo"."id_metallo" ) and  
				( "orafo_titolo"."id_titolo" = "articolo"."id_titolo" ) and  
				 ( "caus_magazzino"."saldi_cl_fino" >' ' ) AND  (caus_magazzino.id_tipo_partita>0) and
				 ("documento"."id_sog_commerciale"=:il_id_sog) and ("orafo_metallo"."codice"=:is_metallo) and
			  ("documento"."data_documento" >= :ldt_da_data  and       "documento"."data_documento" <= :ldt_a_data);
			  if ll_test>0 then
				ll_righe_tot=dw_2.retrieve(ldt_da_data, ldt_a_data, 0.0, 0.0)
				if ll_righe_tot>0 then
					wf_excel_doc()
					wf_excel_righe()
				end if
			end if
		next
	next
	destroy ds_met_preziosi
end if

end event

type dw_3 from udw_000 within w_new_scheda_magazzino
boolean visible = false
integer x = 32
integer y = 1560
integer width = 3899
integer taborder = 48
boolean bringtotop = true
string dataobject = "d_tipo_part_excel"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_2 from udw_000 within w_new_scheda_magazzino
boolean visible = false
integer x = 32
integer y = 1192
integer width = 3881
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_new_scheda_clfo_cl"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event sqlpreview;call super::sqlpreview;string ls_sql, ls_sql_2, ls_sql_unione
integer i, li_pos


if sqltype<>PreviewUpdate! and( il_id_sog> 0 	or is_metallo>"  ") then
	
	  //20230803 provo così, è forse più semplice...
	li_pos=pos(is_sql_originale, "order")
	if li_pos>0 then 
		ls_sql_2=left(is_sql_originale, li_pos - 1)
	else
		ls_sql_2=is_sql_originale
	end if
//	if pos(upper(ls_sql_2), "WHERE") <=0 then ls_sql_2+=
	IF is_metallo> " " THEN 	ls_sql_unione=ls_sql_2+ " and (orafo_metallo.codice= '"+string(is_metallo)+"') "
	if il_id_sog> 0 THEN ls_sql_unione+=" and (documento.id_sog_commerciale= "+string(il_id_sog)+")"
	
		
	ls_sql_unione+=" "+ right(ls_sql, len(ls_sql) - li_pos +1)
	i=SetSQLPreview(ls_sql_unione)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
end if

end event

type cb_2 from commandbutton within w_new_scheda_magazzino
boolean visible = false
integer x = 2418
integer y = 588
integer width = 622
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa tutti clfoProp."
end type

event clicked;date ldt_da_data, ldt_a_data
long  ll_righe_sog, ll_righe_met, ll_righe_tot, ll_test
string  ls_tipo_stampa
integer i, a
datastore ds_met_preziosi, ds_cl_fo

ds_cl_fo=create datastore
ds_cl_fo.dataobject="d_lista_clfo"
ds_cl_fo.settransobject(sqlca)
ll_righe_sog=ds_cl_fo.retrieve()

ds_met_preziosi=create datastore
ds_met_preziosi.dataobject="d_lista_metalli_preziosi"
ds_met_preziosi.settransobject(sqlca)
ll_righe_met=ds_met_preziosi.retrieve()
ldt_da_data=dw_1.getitemdate(1,"da_data")
ldt_a_data=dw_1.getitemdate(1,"a_data")
ls_tipo_stampa="d_new_scheda_mag_all"
dw_2.dataobject=ls_tipo_stampa
dw_2.settransobject(sqlca)
is_sql_originale=dw_2.GetSQLSelect()
for a = 1 to ll_righe_met
	is_metallo=ds_met_preziosi.getitemstring(a, "codice")
	for i=1 to ll_righe_sog
		il_id_sog=ds_cl_fo.getitemnumber(i,  "id_sog_commerciale")
		ll_test=0
		select id_riga_documento into :ll_test from "dba"."riga_documento",  "dba"."documento",    "dba"."articolo",  
         "dba"."orafo_metallo",     "dba"."orafo_titolo" ,  "dba"."caus_magazzino"
		 WHERE ( "caus_magazzino"."id_caus_magazzino" = "riga_documento"."id_caus_magazzino" ) and  
         ( "documento"."id_documento" = "riga_documento"."id_documento" ) and  
         ( "articolo"."id_articolo" = "riga_documento"."id_articolo" ) and  
         ( "orafo_titolo"."id_metallo" = "orafo_metallo"."id_metallo" ) and  
         ( "orafo_titolo"."id_titolo" = "articolo"."id_titolo" ) and  
          ( "caus_magazzino"."saldi_cl_fino" >' ' ) AND  (caus_magazzino.id_tipo_partita>0) and
			 ("documento"."id_sog_commerciale"=:il_id_sog) and ("orafo_metallo"."codice"=:is_metallo) and
		  ("documento"."data_documento" >= :ldt_da_data  and       "documento"."data_documento" <= :ldt_a_data);
		  if ll_test>0 then
			ll_righe_tot=dw_2.retrieve(ldt_da_data, ldt_a_data, 0.0, 0.0)
			if ll_righe_tot>0 then
				wf_excel_doc()
				wf_excel_righe()
			end if
		end if
	next
next
destroy ds_met_preziosi

end event

type cb_3 from commandbutton within w_new_scheda_magazzino
integer x = 1883
integer y = 1004
integer width = 590
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "St. FINE ANNO Prop"
end type

event clicked;string ls_tipo_stampa
date ldt_da_data, ldt_a_data
long ll_righe_tot, ll_righe_met
datastore ds_met_preziosi
integer a

if messagebox("Attenzione!", "Vuoi davvero stampare tutta la proprietà?", stopsign!, yesno!)=1 then
	ds_met_preziosi=create datastore
	ds_met_preziosi.dataobject="d_lista_metalli_preziosi"
	ds_met_preziosi.settransobject(sqlca)
	
	ls_tipo_stampa="d_new_scheda_mag_prop"
	is_metallo=""
	il_id_sog=0
	dw_2.dataobject=ls_tipo_stampa
	dw_2.settransobject(sqlca)
	ldt_da_data=dw_1.getitemdate(1,"da_data")
	ldt_a_data=dw_1.getitemdate(1,"a_data")
	dw_2.dataobject=ls_tipo_stampa
	dw_2.settransobject(sqlca)
	
	ll_righe_met=ds_met_preziosi.retrieve()
	
	is_sql_originale=dw_2.GetSQLSelect()
	for a = 1 to ll_righe_met
		is_metallo=ds_met_preziosi.getitemstring(a, "codice")
		ll_righe_tot=dw_2.retrieve(ldt_da_data, ldt_a_data, 0.0, 0.0)
		if ll_righe_tot>0 then
			wf_excel_doc()
			wf_excel_righe()
		end if
	next
end if

end event

