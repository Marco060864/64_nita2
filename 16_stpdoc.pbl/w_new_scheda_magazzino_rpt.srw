forward
global type w_new_scheda_magazzino_rpt from w_stampa
end type
type pb_salva_dw from picturebutton within w_new_scheda_magazzino_rpt
end type
type cbx_vedi_righe from checkbox within w_new_scheda_magazzino_rpt
end type
type cbx_doc from checkbox within w_new_scheda_magazzino_rpt
end type
type cbx_1 from checkbox within w_new_scheda_magazzino_rpt
end type
type cbx_con_calo from checkbox within w_new_scheda_magazzino_rpt
end type
type cbx_fino_calo_invisibili from checkbox within w_new_scheda_magazzino_rpt
end type
type cbx_summary_invisibile from checkbox within w_new_scheda_magazzino_rpt
end type
type ddlb_1 from dropdownlistbox within w_new_scheda_magazzino_rpt
end type
type cbx_2 from checkbox within w_new_scheda_magazzino_rpt
end type
type cbx_3 from checkbox within w_new_scheda_magazzino_rpt
end type
type cb_accorcia from commandbutton within w_new_scheda_magazzino_rpt
end type
type dw_2 from udw_000 within w_new_scheda_magazzino_rpt
end type
type cbx_4 from checkbox within w_new_scheda_magazzino_rpt
end type
type cbx_solo_aperte from checkbox within w_new_scheda_magazzino_rpt
end type
type dw_3 from udw_000 within w_new_scheda_magazzino_rpt
end type
type cb_1 from commandbutton within w_new_scheda_magazzino_rpt
end type
type pb_salva_xls from picturebutton within w_new_scheda_magazzino_rpt
end type
type cbx_5 from checkbox within w_new_scheda_magazzino_rpt
end type
end forward

global type w_new_scheda_magazzino_rpt from w_stampa
integer width = 5481
integer height = 3532
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
pb_salva_dw pb_salva_dw
cbx_vedi_righe cbx_vedi_righe
cbx_doc cbx_doc
cbx_1 cbx_1
cbx_con_calo cbx_con_calo
cbx_fino_calo_invisibili cbx_fino_calo_invisibili
cbx_summary_invisibile cbx_summary_invisibile
ddlb_1 ddlb_1
cbx_2 cbx_2
cbx_3 cbx_3
cb_accorcia cb_accorcia
dw_2 dw_2
cbx_4 cbx_4
cbx_solo_aperte cbx_solo_aperte
dw_3 dw_3
cb_1 cb_1
pb_salva_xls pb_salva_xls
cbx_5 cbx_5
end type
global w_new_scheda_magazzino_rpt w_new_scheda_magazzino_rpt

type variables
s_new_scheda_mag s_new_mag
string ls_sql_1="", ls_sql_tipo="", is_sql_originale
s_param_articoli str_param
decimal ldc_saldo_peso_precedente,ldc_saldo_fc_precedente
end variables

forward prototypes
public function decimal wf_correzioni_doc (long al_id_sog, date adt_da_data, date adt_fino_data_esclusa)
public function s_any_array wf_calc_saldi_prec (string as_tipo_stampa, date adt_da_data, date adt_fino_data_esclusa, string as_sql_aggiunta, string as_tipo_partita, long al_id_sog, long al_id_titolo)
public subroutine wf_crea_riga_saldo (date adt_fine_saldo_precedente, long al_breakrow)
public function long wf_togli_gruppi_zero (boolean ab_colonna_unica)
public subroutine wf_riempi_dw_excel (long al_row)
end prototypes

public function decimal wf_correzioni_doc (long al_id_sog, date adt_da_data, date adt_fino_data_esclusa);long ll_id_titolo
decimal ldc_correzioni_silver,ldc_correzione_k

if al_id_sog=43   then //perché tanto è solo per l'AG e l'AG è solo 925 (4) 03-08-2021
	ll_id_titolo=4
	SELECT sum((select sum((case when provv_imp_carea_2>0 then provv_imp_carea_2 * (select fn_rec_prezzo_filo_rame('L', documento.data_documento)) else 0 end) + (case when provv_imp_agente_2>0 
	then provv_imp_agente_2 * (select fn_rec_prezzo_filo_rame('F', documento.data_documento)) else 0 end )+ (case when peso_lordo>0 then peso_lordo else 0 end)) from riga_documento 
	where id_documento=documento.id_documento and id_articolo in (select articolo.id_articolo from articolo where id_titolo=:ll_id_titolo) and (select count(*) from riga_documento  , articolo
	where articolo.id_articolo=riga_documento.id_articolo and articolo.id_titolo=:ll_id_titolo and id_documento=documento.id_documento and peso_netto> 1 ) >10
	  )) // , (select sum(correzione) from correzioni_k where id_riga_documento in (select id_riga_documento from riga_documento where id_documento=documento.id_documento) )
	  into :ldc_correzioni_silver //, :ldc_correzione_k
	FROM dba.documento
	where (data_documento>=:adt_da_data and data_documento< :adt_fino_data_esclusa )
	//inserita su richiesta il 13/02/2020
	and (data_documento < 20201214  or data_documento >= 20210614) //da attivare quando lo dice Samy =14-06-2021 attivato
	and (documento.id_prof_documento =114 or documento.id_prof_documento =150 or documento.id_prof_documento =66) //  or documento.id_prof_documento =116) VRBOL ma pre ora non serve 20220622
	and id_sog_commerciale=43;

	//aggiungo correzioni rigo rigo
	select sum(correzione) 
	into :ldc_correzione_k
	from correzioni_k , documento
	where id_riga_documento in (select id_riga_documento from riga_documento, articolo, orafo_titolo, orafo_metallo
	where id_documento=documento.id_documento and  data_documento>=:adt_da_data 
	and data_documento< :adt_fino_data_esclusa and 
	orafo_metallo.id_metallo=orafo_titolo.id_metallo and orafo_metallo.codice=:s_new_mag.metallo
	and orafo_titolo.id_titolo=articolo.id_titolo and articolo.id_articolo=riga_documento.id_articolo) ;
	
	if isnull(ldc_correzioni_silver) then ldc_correzioni_silver=0
	if isnull(ldc_correzione_k) then ldc_correzione_k=0
	ldc_correzioni_silver+=ldc_correzione_k
	
end if
return ldc_correzioni_silver	
				
				

end function

public function s_any_array wf_calc_saldi_prec (string as_tipo_stampa, date adt_da_data, date adt_fino_data_esclusa, string as_sql_aggiunta, string as_tipo_partita, long al_id_sog, long al_id_titolo);s_any_array str_any
decimal ldc_saldo[], ldc_correzione
string ls_sql_ok, ls_sql_tipo_partita

//qui c'è da creare una funzione per restituire al tipo partita le causali, per ora le metto a mano 20220629
choose case  as_tipo_stampa
	case "d_new_scheda_mag_all"
		ls_sql_ok= "SELECT  sum( (select ( case caus_magazzino.segno  when 'C' then riga_documento.peso_netto  "+&
					 " when 'S' then riga_documento.peso_netto * -1 end )))  as c_somma_peso, "+&
				  	"sum( (select ( case caus_magazzino.segno  when 'C' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000, 2)  "+&
									  " when 'S' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000 , 2 ) * -1 end )))  as c_somma_finocalo "+&
				 	" FROM riga_documento, documento, articolo, orafo_metallo, orafo_titolo , caus_magazzino "+& 
					" WHERE ( caus_magazzino.id_caus_magazzino = riga_documento.id_caus_magazzino ) and  "+&
						" ( documento.id_documento = riga_documento.id_documento ) and   "+&
						" ( articolo.id_articolo = riga_documento.id_articolo ) and   "+&
						" ( orafo_titolo.id_metallo = orafo_metallo.id_metallo ) and   "+&
						" ( orafo_titolo.id_titolo = articolo.id_titolo ) and   "+&
					"	 ( caus_magazzino.segno is not null ) AND   "+&
					" (documento.data_documento >= '"+string(adt_da_data, "yyyy/mm/dd")+"' AND   "+&
					" documento.data_documento <  '"+string(adt_fino_data_esclusa, "yyyy/mm/dd")+"' )    " +as_sql_aggiunta //il filtro per metallo è qui: 1 metallo solo per stampa
						
	case "d_new_scheda_cl_fo", "d_new_scheda_clfo_cl"
		ls_sql_ok= "SELECT  sum( (select ( case caus_magazzino.saldi_cl_fino  when '+' then riga_documento.peso_netto  "+&
								  " when '-' then riga_documento.peso_netto * -1 end )))  as c_somma_peso, "+&
				"sum( (select ( case caus_magazzino.saldi_cl_fino  when '+' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000, 2)  "+&
								  " when '-' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000 , 2 ) * -1 end )))  as c_somma_finocalo "+&
				" FROM riga_documento, documento, articolo, orafo_metallo, orafo_titolo , caus_magazzino "+& 
					" WHERE ( caus_magazzino.id_caus_magazzino = riga_documento.id_caus_magazzino ) and  "+&
				" ( documento.id_documento = riga_documento.id_documento ) and   "+&
				" ( articolo.id_articolo = riga_documento.id_articolo ) and   "+&
				" ( orafo_titolo.id_metallo = orafo_metallo.id_metallo ) and   "+&
				" ( orafo_titolo.id_titolo = articolo.id_titolo ) and   "+&
				"	 ( caus_magazzino.segno is not null ) AND   "+&
				" (documento.data_documento >= '"+string(adt_da_data, "yyyy/mm/dd")+"' AND   "+&
				" documento.data_documento <  '"+string(adt_fino_data_esclusa, "yyyy/mm/dd")+"' )    " +as_sql_aggiunta //il filtro per metallo è qui: 1 metallo solo per stampa
	case "d_new_scheda_magazzino"
	if as_tipo_partita="CL"  then ls_sql_tipo_partita=" (caus_magazzino.id_tipo_partita=1 or caus_magazzino.id_tipo_partita=8) AND "  // sono SCLC e ACLC
	if as_tipo_partita="CV" then ls_sql_tipo_partita=" (caus_magazzino.id_tipo_partita>=3 and  caus_magazzino.id_tipo_partita<=6) AND "  // sono SCVC e ACVC e ACVF e SCVF
	
	ls_sql_ok= "SELECT  sum( (select ( case caus_magazzino.segno  when 'C' then riga_documento.peso_netto  "+&
						  " when 'S' then riga_documento.peso_netto * -1 end )))  as c_somma_peso, "+&
		"sum( (select ( case caus_magazzino.segno  when 'C' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000, 2)  "+&
						  " when 'S' then round(riga_documento.peso_netto * riga_documento.coef_calo /1000 , 2 ) * -1 end )))  as c_somma_finocalo "+&
		" FROM riga_documento, documento, articolo, orafo_metallo, orafo_titolo , caus_magazzino "+& 
		" WHERE ( caus_magazzino.id_caus_magazzino = riga_documento.id_caus_magazzino ) and  "+&
			" ( documento.id_documento = riga_documento.id_documento ) and   "+&
			" ( articolo.id_articolo = riga_documento.id_articolo ) and   "+&
			" ( orafo_titolo.id_metallo = orafo_metallo.id_metallo ) and   "+&
			" ( orafo_titolo.id_titolo = articolo.id_titolo ) and   "+&
		"	 ( caus_magazzino.segno is not null ) AND   "+ls_sql_tipo_partita+&
			" (documento.data_documento >= '"+string(adt_da_data, "yyyy/mm/dd")+"' AND   "+&
			" documento.data_documento <  '"+string(adt_fino_data_esclusa, "yyyy/mm/dd")+"' )    " +as_sql_aggiunta //il filtro per metallo è qui: 1 metallo solo per stampa
end choose	

PREPARE SQLSA FROM :ls_sql_ok using sqlca ;
DECLARE my_cursor_CL DYNAMIC CURSOR FOR SQLSA ;
OPEN DYNAMIC my_cursor_CL ;
FETCH my_cursor_CL INTO :ldc_saldo[1], :ldc_saldo[2] ;
CLOSE my_cursor_CL ;

if al_id_sog=43 and al_id_titolo=4 then 
	ldc_correzione=wf_correzioni_doc(al_id_sog, adt_da_data, adt_fino_data_esclusa)
	ldc_saldo[1] -=ldc_correzione //queste 2 righe presuppongo che TUTTI i movimenti considerati siano a calo 1000!!!!!!!!!!!! 20220628 (tolgo il peso sia dal peso che dal fino+calo)
	ldc_saldo[2] -=ldc_correzione
end if

str_any.s_array[1]=ldc_saldo[1]
str_any.s_array[2]=ldc_saldo[2]

return str_any
end function

public subroutine wf_crea_riga_saldo (date adt_fine_saldo_precedente, long al_breakrow);long ll_riga_inserita
string ls_tipo_partita, ls_metallo, ls_rag_soc
decimal{2} ldc_peso_precedente,ldc_fino_precedente,ldc_calo_precedente,ldc_coef_calo, ldc_finocalo_precedente


ll_riga_inserita=dw_1.insertrow(0)
dw_1.setitem(ll_riga_inserita, "data_documento", adt_fine_saldo_precedente)
dw_1.setitem(ll_riga_inserita, "caus_magazzino_codice", "SALD_PRE")
ls_tipo_partita=mid(dw_2.getitemstring(al_breakrow, "c_tipo_partita"), 2,2)
//ls_tipo_partita=dw_2.getitemstring(ll_breakrow, "c_solo_tipo_partita")
dw_1.setitem(ll_riga_inserita, "c_tipo_partita", "0"+ls_tipo_partita+"X")
ls_metallo=dw_2.getitemstring(al_breakrow, "orafo_metallo_codice" )
dw_1.setitem(ll_riga_inserita, "orafo_metallo_codice", ls_metallo )
//anche la rag_soc_1 per il gruppo delle "CLFO"
ls_rag_soc=dw_2.getitemstring(al_breakrow, "c_rag_sociale" )
dw_1.setitem(ll_riga_inserita, "c_rag_sociale", ls_rag_soc )
//20261008 anche l'id del cliente: il gruppo 2 e' per rag. sociale + id_sog_commerciale + tipo partita,
//senza id la riga del saldo (X) finiva in un gruppo tutto suo, staccata dalle ??F/??C dello stesso cliente.
//Solo se la colonna c'e' in tutte e due le dw (wf_crea_riga_saldo gira anche con altre stampe)
//e se dw_2 ha la riga: con dw_2 vuota (nessun movimento prima della data iniziale) al_breakrow arriva 0
if al_breakrow > 0 and al_breakrow <= dw_2.rowcount() then
	if dw_1.describe("documento_id_sog_commerciale.id") <> "!" and dw_2.describe("documento_id_sog_commerciale.id") <> "!" then
		dw_1.setitem(ll_riga_inserita, "documento_id_sog_commerciale", dw_2.getitemnumber(al_breakrow, "documento_id_sog_commerciale"))
	end if
	//20261008 e se il cliente stampa il legato o il fino+calo (UNA colonna): in un gruppo fatto solo di saldo
	//senza questo la dw non saprebbe quale colonna mostrare
	if dw_1.describe("fino_o_legato.id") <> "!" and dw_2.describe("fino_o_legato.id") <> "!" then
		dw_1.setitem(ll_riga_inserita, "fino_o_legato", dw_2.getitemstring(al_breakrow, "fino_o_legato"))
	end if
end if
ldc_peso_precedente=dw_2.getitemdecimal(al_breakrow, "c_prog_legato")       //"c_prog_legato_doc")            ////"c_tot_partita_peso")       //
//ldc_fino_precedente=dw_2.getitemdecimal(al_breakrow, "c_tot_partita_fino")
//?????20240904 riattivo il calcolo del calo precedente.... con il coef calo calcolato NON funge
//ldc_calo_precedente=dw_2.getitemdecimal(al_breakrow, "c_tot_partita_calo") 
if  dw_1.dataobject="d_new_scheda_magazzino_test2" then
	ldc_finocalo_precedente=dw_2.getitemdecimal(al_breakrow, "c_tot_partita_fc") //20250409 proviamo così... 
else
	ldc_finocalo_precedente=dw_2.getitemdecimal(al_breakrow, "c_prog_fc_riga") //20240513 proviamo così... era c_prog_fc cambiato in c_prog_finocalo 20240904
	
end if

dw_1.setitem(ll_riga_inserita, "peso_netto", ldc_peso_precedente)
//dw_1.setitem(ll_riga_inserita, "fino", ldc_fino_precedente)
//dw_1.setitem(ll_riga_inserita, "CALO", ldc_calo_precedente) //20240904 ?????riattivo vedi sopra
dw_1.setitem(ll_riga_inserita, "fino", ldc_finocalo_precedente) //20240513 proviamo così...
dw_1.setitem(ll_riga_inserita, "calo", 0) //20240513 proviamo così...
if isnull(ldc_peso_precedente) or ldc_peso_precedente<=0 then
	ldc_coef_calo=1000
else
	//ldc_coef_calo= abs((ldc_fino_precedente+ldc_calo_precedente)*1000/ldc_peso_precedente)
	//20240513 proviamo così... sembra che ORA, con il round, VADA BENE....  NON FUNGEva: con la divisione creaVA decimali arrotondati CHE FALSAVANO IL RISULTATO
	ldc_coef_calo= round(abs((ldc_finocalo_precedente)*1000/ldc_peso_precedente),3) //20250409 arrotondavo a 0 decimali, con 3 decimalli torna molto meglio....
end if
dw_1.setitem(ll_riga_inserita, "coef_calo", ldc_coef_calo)
dw_1.setitem(ll_riga_inserita, "num_documento", "SALDO AL :")
if pos(s_new_mag.tipo_stampa, "clfo")>0 then
	dw_1.setitem(ll_riga_inserita, "caus_magazzino_saldi_cl_fino", "+")
else
	dw_1.setitem(ll_riga_inserita, "caus_magazzino_segno", "C")
end if

dw_1.setredraw(false)
dw_1.sort()
dw_1.groupcalc()
dw_1.setredraw(true)



//if s_new_mag.tipo_stampa="d_new_scheda_mag_all" or s_new_mag.tipo_stampa="d_new_scheda_clfo" then
//	
//	
//	
//end if	
end subroutine

public function long wf_togli_gruppi_zero (boolean ab_colonna_unica);//20261008 stampe "Scheda per Tipo Partita NO ZERO" (d_new_scheda_clfo_cl, ab_colonna_unica = false)
//e "Tipo Partita NO 0 UNA colonna" (d_new_scheda_clfo_cl_no0c1, ab_colonna_unica = true):
//toglie i gruppi di livello 2 (cliente + tipo partita) a zero, cioe' fra -0,01 e +0,01.
//I totali sono i progressivi del gruppo (c_prog_legato, c_prog_fc) letti sull'ultima riga, compresa la riga
//del saldo precedente (0??X) che ormai sta nel gruppo giusto.
//  - NO ZERO: devono essere a zero legato E fino+calo
//  - UNA colonna: conta solo la colonna che il cliente stampa (per_saldo_legato_o_fino.fino_o_legato):
//    "L" solo il legato, "F" solo il fino+calo, non impostato tutti e due (come NO ZERO)
//Restituisce il numero di gruppi tolti
long ll_riga, ll_dopo, ll_fine, ll_righe, ll_n, k, r
long ll_inizi[], ll_fini[]
decimal ldc_legato, ldc_fc
string ls_fl
boolean lb_zero

dw_1.setredraw(false)
dw_1.sort()
dw_1.groupcalc()
ll_righe = dw_1.rowcount()
ll_n = 0
ll_riga = 1
do while ll_riga > 0 and ll_riga <= ll_righe
	//inizio del gruppo dopo: findgroupchange(r, 2) = prima riga di un nuovo gruppo 2 a partire da r
	ll_dopo = dw_1.findgroupchange(ll_riga + 1, 2)
	if ll_dopo <= 0 or ll_dopo > ll_righe then
		ll_fine = ll_righe
	else
		ll_fine = ll_dopo - 1
	end if
	ldc_legato = dw_1.getitemdecimal(ll_fine, "c_prog_legato")
	ldc_fc = dw_1.getitemdecimal(ll_fine, "c_prog_fc")
	if isnull(ldc_legato) then ldc_legato = 0
	if isnull(ldc_fc) then ldc_fc = 0
	//quale colonna conta: con la UNA colonna si guarda fino_o_legato (il primo valorizzato del gruppo:
	//la riga del saldo precedente puo' non averlo)
	ls_fl = ""
	if ab_colonna_unica then
		for r = ll_riga to ll_fine
			ls_fl = dw_1.getitemstring(r, "fino_o_legato")
			if isnull(ls_fl) then ls_fl = ""
			if ls_fl > "" then exit
		next
	end if
	if ls_fl = "L" then
		lb_zero = (abs(ldc_legato) <= 0.01)
	elseif ls_fl = "F" then
		lb_zero = (abs(ldc_fc) <= 0.01)
	else
		lb_zero = (abs(ldc_legato) <= 0.01 and abs(ldc_fc) <= 0.01)
	end if
	if lb_zero then
		ll_n++
		ll_inizi[ll_n] = ll_riga
		ll_fini[ll_n] = ll_fine
	end if
	if ll_dopo <= 0 or ll_dopo > ll_righe then exit
	ll_riga = ll_dopo
loop
//si toglie dal fondo, cosi' i numeri di riga dei gruppi ancora da togliere non si spostano
for k = ll_n to 1 step -1
	dw_1.rowsdiscard(ll_inizi[k], ll_fini[k], Primary!)
next
dw_1.groupcalc()
dw_1.setredraw(true)
return ll_n
end function

public subroutine wf_riempi_dw_excel (long al_row);long ll_riga_inserita,ll_breakrow

string ls_causale, ls_rag_sociale, ls_num_doc, ls_cod_articolo, ls_met_titolo, ls_tipo_partita
date  ldt_data_doc
decimal ldc_c_calo, ldc_qta, ldc_legato, ldc_calo, ldc_fino, ldc_finocalo, ldc_prog_legato, ldc_prog_finocalo

ls_tipo_partita=dw_1.getitemstring(al_row, "c_tipo_partita")
ls_causale       = dw_1.getitemstring(al_row, "caus_magazzino_codice")
ls_rag_sociale   = dw_1.getitemstring(al_row, "c_rag_sociale")
ls_num_doc       = dw_1.getitemstring(al_row, "num_documento")
 ldt_data_doc     = dw_1.getitemdate(al_row, "data_documento")
ls_cod_articolo  = dw_1.getitemstring(al_row, "articolo_codice")
ls_met_titolo    = dw_1.getitemstring(al_row, "compute_1")
ldc_qta          = dw_1.getitemdecimal(al_row, "c_qta_doc")
ldc_legato       = dw_1.getitemdecimal(al_row, "c_legato_doc")
ldc_calo         = dw_1.getitemdecimal(al_row, "c_calo_doc")
ldc_fino         = dw_1.getitemdecimal(al_row, "c_fino_doc")
ldc_finocalo     = dw_1.getitemdecimal(al_row, "c_finocalo_doc")
ldc_prog_legato  = dw_1.getitemdecimal(al_row, "c_prog_legato_doc")
ldc_prog_finocalo= dw_1.getitemdecimal(al_row, "c_prog_fc_doc")

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

on w_new_scheda_magazzino_rpt.create
int iCurrent
call super::create
this.pb_salva_dw=create pb_salva_dw
this.cbx_vedi_righe=create cbx_vedi_righe
this.cbx_doc=create cbx_doc
this.cbx_1=create cbx_1
this.cbx_con_calo=create cbx_con_calo
this.cbx_fino_calo_invisibili=create cbx_fino_calo_invisibili
this.cbx_summary_invisibile=create cbx_summary_invisibile
this.ddlb_1=create ddlb_1
this.cbx_2=create cbx_2
this.cbx_3=create cbx_3
this.cb_accorcia=create cb_accorcia
this.dw_2=create dw_2
this.cbx_4=create cbx_4
this.cbx_solo_aperte=create cbx_solo_aperte
this.dw_3=create dw_3
this.cb_1=create cb_1
this.pb_salva_xls=create pb_salva_xls
this.cbx_5=create cbx_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_salva_dw
this.Control[iCurrent+2]=this.cbx_vedi_righe
this.Control[iCurrent+3]=this.cbx_doc
this.Control[iCurrent+4]=this.cbx_1
this.Control[iCurrent+5]=this.cbx_con_calo
this.Control[iCurrent+6]=this.cbx_fino_calo_invisibili
this.Control[iCurrent+7]=this.cbx_summary_invisibile
this.Control[iCurrent+8]=this.ddlb_1
this.Control[iCurrent+9]=this.cbx_2
this.Control[iCurrent+10]=this.cbx_3
this.Control[iCurrent+11]=this.cb_accorcia
this.Control[iCurrent+12]=this.dw_2
this.Control[iCurrent+13]=this.cbx_4
this.Control[iCurrent+14]=this.cbx_solo_aperte
this.Control[iCurrent+15]=this.dw_3
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.pb_salva_xls
this.Control[iCurrent+18]=this.cbx_5
end on

on w_new_scheda_magazzino_rpt.destroy
call super::destroy
destroy(this.pb_salva_dw)
destroy(this.cbx_vedi_righe)
destroy(this.cbx_doc)
destroy(this.cbx_1)
destroy(this.cbx_con_calo)
destroy(this.cbx_fino_calo_invisibili)
destroy(this.cbx_summary_invisibile)
destroy(this.ddlb_1)
destroy(this.cbx_2)
destroy(this.cbx_3)
destroy(this.cb_accorcia)
destroy(this.dw_2)
destroy(this.cbx_4)
destroy(this.cbx_solo_aperte)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.pb_salva_xls)
destroy(this.cbx_5)
end on

event open;call super::open;date ldt_data, ldt_data_saldo, ldt_fine_saldo_precedente
decimal ldc_correzioni_silver, ldc_correzione_k, ldc_peso_precedente_cl, ldc_peso_precedente_cv,  ldc_fc_precedente_cl, ldc_fc_precedente_cv
decimal ldc_peso_precedente, ldc_fc_precedente, ldc_calo_precedente,ldc_fino_precedente, ldc_coef_calo
integer i, li_pos
string ls_sql_ok, ls_tipo_partita, ls_sql_cl, ls_sql_cv, ls_metallo,ls_rag_soc, ls_cod_articolo
long ll_id_titolo,ll_riga_inserita,  ll_breakrow = 0, ll_breakrow_1
s_any_array str_any
boolean lb_found
string ls_tipo_part_sel  //20261020 tipo partita scelto nella selezione
// dw utilizzaste effettivamente: d_new_scheda_mag_all (quando non si specifica nulla), d_new_scheda_clfo_cl (tipo_partita) e //20260119 d_new_scheda_magazzino_test2 e le altre sulle partite 
s_new_mag=message.powerobjectparm
if isnull(s_new_mag.tipo_stampa) or s_new_mag.tipo_stampa<=" " then s_new_mag.tipo_stampa="d_new_scheda_mag_all"
//20261020 il tipo partita scelto arriva in s_new_mag.filtro (partite orafe e schede per tipo partita): va letto PRIMA
//della riga sotto, che sovrascrive filtro con il testo dell'intestazione (prima il filtro non aveva effetto)
ls_tipo_part_sel = ""
if s_new_mag.tipo_stampa = "d_new_partite_orafe" or (pos(s_new_mag.tipo_stampa, "d_new_scheda_clfo_cl") > 0 and s_new_mag.tipo_stampa <> "d_new_scheda_clfo_cl_tot_metallo") then
	if not isnull(s_new_mag.filtro) then ls_tipo_part_sel = trim(s_new_mag.filtro)
end if
s_new_mag.filtro="Dal "+string(s_new_mag.da_data, "dd/mm/yy")+" al "+string(s_new_mag.a_data, "dd/mm/yy")

if s_new_mag.tipo_stampa="d_new_scheda_clfo_cl_tot_metallo" then
	dw_1.dataobject="d_new_scheda_clfo_cl_tot_metallo"
	dw_1.settransobject(sqlca)
	dw_1.retrieve(s_new_mag.da_data, s_new_mag.a_data,s_new_mag.id_sog_commerciale)
	select rag_soc_1 into :ls_rag_soc from dba.sog_commerciale_gen where id_sog_commerciale=:s_new_mag.id_sog_commerciale;
	s_new_mag.filtro+=" - Sog.Com.: "+ ls_rag_soc
	dw_1.modify("t_filtro.text=s_new_mag.filtro")
	return
end if


if s_new_mag.metallo> "" then
	if s_new_mag.id_titolo>0 then
		if s_new_mag.tipo_stampa="d_new_partite_orafe" then
			ls_sql_1+=" and ( orafo_aper_partita.id_titolo="+string( s_new_mag.id_titolo)+"  or  orafo_aper_partita.id_titolo=1) "			
		end if
	else
		ls_sql_1+=" and (orafo_metallo.codice= '"+string(s_new_mag.metallo)+"') "
		s_new_mag.filtro+=" Met.: "+s_new_mag.metallo+"  "
	end if
end if
if s_new_mag.tipo_stampa="d_new_partite_orafe" then //20240429 se è la nuova stampa delle partite testa righe basta l'id del soggetto com (il metallo serve anche qui)
	cbx_solo_aperte.visible=true
	//dw_2.dataobject=s_new_mag.tipo_stampa
	ls_sql_1+=" and (documento.id_sog_commerciale= "+string( s_new_mag.id_sog_commerciale)+") "
	if ls_tipo_part_sel > " " then ls_sql_1+=" and (orafo_tipo_partita.cod_tipo_partita='"+ ls_tipo_part_sel+"') "  //20261020 prima usava filtro gia' sovrascritto
	dw_1.dataobject="d_new_partite_orafe"
	dw_1.settransobject(sqlca)
	dw_1.retrieve()
else	
	if s_new_mag.fiscale =1 then 
		ls_sql_1+=" and (caus_magazzino.mp_car_fiscali > ' ' or caus_magazzino.mp_scar_fiscali > ' ' "+") "
	end if
	if s_new_mag.id_sog_commerciale> 0  and  s_new_mag.id_sog_commerciale2>0 then
		//lo faccio solo se è saldo di un singolo CL/FO
		ls_sql_1+=" and (documento.id_sog_commerciale= "+string( s_new_mag.id_sog_commerciale)+" or documento.id_sog_commerciale= "&
		+string( s_new_mag.id_sog_commerciale2)+") "
	elseif s_new_mag.id_sog_commerciale>0 then
		if s_new_mag.tipo_stampa="d_new_st_partite_tb" then
			ls_sql_1+=" and (documento_a.id_sog_commerciale= "+string( s_new_mag.id_sog_commerciale)+") "
		else
			ls_sql_1+=" and (documento.id_sog_commerciale= "+string( s_new_mag.id_sog_commerciale)+") "
		end if
	end if
	if s_new_mag.id_destinazione> 0 then //lo faccio solo se è saldo di un singolo CL/FO
		ls_sql_1+=" and (documento.id_destinazione= "+string( s_new_mag.id_destinazione)+") "
		 s_new_mag.filtro+= " - Dest.: "+string( s_new_mag.id_destinazione)
	end if
	
	if s_new_mag.id_titolo>0 then  //20221211 riattivo senza else
		ls_sql_1+=" and (articolo.id_titolo= "+string( s_new_mag.id_titolo)+") "
	//else
		//if  s_new_mag.id_sog_commerciale=43 and  s_new_mag.metallo='AG' then s_new_mag.id_titolo=4
	end if
	//20260423 aggiungo filtro per articolo
	if s_new_mag.id_articolo>0 then  
		ls_sql_1+=" and (articolo.id_articolo= "+string( s_new_mag.id_articolo)+") "
		select codice into :ls_cod_articolo from dba.articolo where id_articolo=:s_new_mag.id_articolo;
		 s_new_mag.filtro+= " - Articolo.: "+ls_cod_articolo
	end if
	//20260423 fine
	//20261020 filtro per tipo partita nelle schede per tipo partita (normale, NO ZERO, 2 soggetti, verticale):
	//si toglie la prima lettera (A apertura / S scarico) e si tengono tutti i tipi con le altre tre uguali,
	//es. ACVF -> CVF = ACVF + SCVF (conto visione fornitori, apertura e chiusura)
	if ls_tipo_part_sel > " " and pos(s_new_mag.tipo_stampa, "d_new_scheda_clfo_cl") > 0 then
		ls_sql_1+=" and (caus_magazzino.id_tipo_partita in (select tp.id_tipo_partita from dba.orafo_tipo_partita tp where substr(tp.cod_tipo_partita, 2) = '"+ mid(ls_tipo_part_sel, 2) +"')) "
		s_new_mag.filtro+= " - Tipo partita: "+mid(ls_tipo_part_sel, 2)
	end if
	if s_new_mag.sel_causali='S' then  
		open(w_sel_causali_st)
		str_param=message.powerobjectparm
		s_new_mag.id_caus_magazzino=str_param.li_titolo
		for i=1 to upperbound(s_new_mag.id_caus_magazzino)
			if i=1 then
				ls_sql_1+=" and (caus_magazzino.id_caus_magazzino= "+string(s_new_mag.id_caus_magazzino[i])
			else
				ls_sql_1+=" or caus_magazzino.id_caus_magazzino= "+string(s_new_mag.id_caus_magazzino[i])
			end if
		next
		ls_sql_1+=" ) "
	end if

	select data_inizio
	into :ldt_data
	from esercizio 
	where data_inizio<=:s_new_mag.da_data
	and data_fine>=:s_new_mag.da_data
	;
	
	if s_new_mag.id_sog_commerciale2>0 and s_new_mag.tipo_stampa="d_new_scheda_clfo_cl" then
		dw_2.dataobject="d_new_scheda_clfo_cl_2sog"
	elseif s_new_mag.tipo_stampa="d_new_scheda_clfo_cl_no0" then
		//20261008 "NO ZERO": stessa dw della scheda per tipo partita (una sola da mantenere), impaginata
		//compatta qui sotto; i gruppi a zero li toglie wf_togli_gruppi_zero() alla fine dell'open
		dw_2.dataobject="d_new_scheda_clfo_cl"
	else
		dw_2.dataobject=s_new_mag.tipo_stampa
	end if
	dw_1.dataobject=dw_2.dataobject
	dw_1.settransobject(sqlca)
	dw_2.settransobject(sqlca)
	if s_new_mag.tipo_stampa="d_new_scheda_clfo_cl_no0" then
		//20261008 impaginazione compatta come la vecchia d_new_scheda_clfo_cl_no0: niente righe per
		//documento (trailer 3), niente header del metallo, totali del gruppo in alto
		dw_1.modify("DataWindow.Header.1.Height=0 DataWindow.Trailer.3.Height=0 " + &
			"c_prog_fc.y=20 c_prog_legato.y=20 c_rag_sociale_1.y=20 c_saldo_prec_fc_1.y=20 " + &
			"c_saldo_prec_peso_1.y=20 compute_29.y=20 l_4.x1=5 l_4.y1=104 l_4.x2=4823 l_4.y2=104")
	end if
	
	ldt_fine_saldo_precedente=relativedate(s_new_mag.da_data, -1)
	//20260423: se è partite orafe (Anna) non deve ricalcore saldi, le partite si fanno dall'inizo anno in caso diverso visualilzzo soltanto
	//quelle del periodo senza riportare altro...
	if s_new_mag.tipo_stampa="d_new_st_partite_tb" then
		//ora cerco i totali legato e fino (se la data inizio è <> dall'inizio dell'esercizio allora c'è un solo sog-comm e, come sempre, un solo metallo)
		dw_1.setredraw(false)
		dw_1.retrieve(s_new_mag.da_data, s_new_mag.a_data, ldc_peso_precedente, ldc_peso_precedente)
		dw_1.sort()
	elseif ldt_data< s_new_mag.da_data  then
		dw_2.reset()
		dw_2.setredraw(false)
		dw_2.retrieve(ldt_data, ldt_fine_saldo_precedente, ldc_peso_precedente,ldc_peso_precedente)
		dw_2.sort()
		
	//	if s_new_mag.id_sog_commerciale2>0 then
	//		dw_2.Modify("cf_group2.expression='c_tipo_partita_gruppo'")
	//		//dw_2.Modify("cf_group3.expression='c_tipo_partita_gruppo,  riga_documento_id_documento'")
	//		dw_2.groupcalc()
	//	end if
		
		dw_2.setredraw(true)
		//ora cerco i totali legato e fino (se la data inizio è <> dall'inizio dell'esercizio allora c'è un solo sog-comm e, come sempre, un solo metallo)
		dw_1.setredraw(false)
		dw_1.retrieve(s_new_mag.da_data, s_new_mag.a_data, ldc_peso_precedente, ldc_peso_precedente)
		dw_1.sort()
	//	if s_new_mag.id_sog_commerciale2>0 then
	//		//dw_1.Modify("cf_group2.expression='c_tipo_partita_gruppo'")
	//		//dw_1.Modify("cf_group3.expression='c_tipo_partita_gruppo,  riga_documento_id_documento'")
	//	end if
		//dw_1.groupcalc()
		dw_1.setredraw(true)
		//se la stampa è senza gruppi (d_new_scheda_magazzino e d_new_scheda_clfo) basta prendere i valori all'ultima riga
		if s_new_mag.tipo_stampa="d_new_scheda_mag_all" or s_new_mag.tipo_stampa="d_new_scheda_clfo" then
			ll_breakrow=dw_2.rowcount()
			ll_riga_inserita=dw_1.insertrow(0)
			dw_1.setitem(ll_riga_inserita, "data_documento", ldt_fine_saldo_precedente)
			dw_1.setitem(ll_riga_inserita, "caus_magazzino_codice", "SALD_PRE")
			ls_tipo_partita=mid(dw_2.getitemstring(ll_breakrow, "c_tipo_partita"), 2,2)
			//ls_tipo_partita=dw_2.getitemstring(ll_breakrow, "c_solo_tipo_partita")
			dw_1.setitem(ll_riga_inserita, "c_tipo_partita", "0"+ls_tipo_partita+"X")
			ls_metallo=dw_2.getitemstring(ll_breakrow, "orafo_metallo_codice" )
			dw_1.setitem(ll_riga_inserita, "orafo_metallo_codice", ls_metallo )
			//anche la rag_soc_1 per il gruppo delle "CLFO"
			ls_rag_soc=dw_2.getitemstring(ll_breakrow, "c_rag_sociale" )
			dw_1.setitem(ll_riga_inserita, "c_rag_sociale", ls_rag_soc )
			ldc_peso_precedente=dw_2.getitemdecimal(ll_breakrow, "c_prog_legato")       //"c_prog_legato_doc")            ////"c_tot_partita_peso")       //
			//ldc_fino_precedente=dw_2.getitemdecimal(ll_breakrow, "c_tot_partita_fino")
			//ldc_calo_precedente=dw_2.getitemdecimal(ll_breakrow, "c_tot_partita_calo")
			dw_1.setitem(ll_riga_inserita, "peso_netto", ldc_peso_precedente)
			//dw_1.setitem(ll_riga_inserita, "fino", ldc_fino_precedente)
			//dw_1.setitem(ll_riga_inserita, "CALO", ldc_calo_precedente)
			//ldc_coef_calo= (ldc_fino_precedente+ldc_calo_precedente)*1000/ldc_peso_precedente
			dw_1.setitem(ll_riga_inserita, "coef_calo", 1000)
			
			dw_1.setitem(ll_riga_inserita, "num_documento", "SALDO AL :")
			if pos(s_new_mag.tipo_stampa, "clfo")>0 then
				dw_1.setitem(ll_riga_inserita, "caus_magazzino_saldi_cl_fino", "+")
				
			else
				dw_1.setitem(ll_riga_inserita, "caus_magazzino_segno", "C")
				dw_1.setitem(ll_riga_inserita, "riga_documento_id_documento", 0)
				ldc_fino_precedente=dw_2.getitemdecimal(ll_breakrow, "c_prog_finocalo")
				//è scritto "ldc_fino_precedente" ma è il fino+calo
				dw_1.setitem(ll_riga_inserita, "fino", ldc_fino_precedente)
				
			end if
			
		else
			ll_breakrow=1
			DO WHILE NOT (lb_found)    
				ll_breakrow = dw_2.FindGroupChange(ll_breakrow, 2)    // If no breaks are found, exit.   
				i++
				if i=1 then 
					ll_breakrow++ 
					continue
				end if
				IF ll_breakrow <= 0 THEN //non ci sono più gruppi prendo l'ultima riga della dw
					ll_breakrow=dw_2.rowcount()
					wf_crea_riga_saldo(ldt_fine_saldo_precedente, ll_breakrow)
					EXIT
				else
					ll_breakrow_1=ll_breakrow - 1
					wf_crea_riga_saldo(ldt_fine_saldo_precedente, ll_breakrow_1)
				end if
				ll_breakrow = ll_breakrow + 1
			LOOP
			
		end if
	
	else
		dw_1.setredraw(false)
		dw_1.retrieve(s_new_mag.da_data, s_new_mag.a_data, ldc_peso_precedente, ldc_peso_precedente)
		dw_1.sort()
		dw_1.groupcalc()
		dw_1.setredraw(true)
	end if
end if //20240429 fine

//20261008 "NO ZERO": via i gruppi (cliente + tipo partita) con legato e fino+calo tutti e due fra -0,01 e +0,01
if s_new_mag.tipo_stampa="d_new_scheda_clfo_cl_no0" then wf_togli_gruppi_zero(false)
//20261008 "NO 0 UNA colonna": via i gruppi a zero nella colonna che il cliente stampa (L legato, F fino+calo)
if s_new_mag.tipo_stampa="d_new_scheda_clfo_cl_no0c1" then wf_togli_gruppi_zero(true)

end event

event ue_postopen;call super::ue_postopen;string ls_ret, ls_mod
decimal ldc_temp
long ll_righe

if s_new_mag.tipo_stampa="d_new_partite_orafe" then
	
else
	if s_new_mag.filtro>" " then
		//dw_1.object.t_filtro.text=s_new_mag.filtro
		ls_mod = "t_filtro.text = '" + s_new_mag.filtro + "'"
		ls_ret=dw_1.modify(ls_mod)
		//messagebox("S", ls_ret)
	end if
	if (s_new_mag.tipo_stampa="d_new_scheda_clfo_cl" or pos(s_new_mag.tipo_stampa,"d_new_scheda_clfo_cl_no0")>0 ) and isnull(s_new_mag.id_sog_commerciale)  then
		cbx_doc.checked=true
		cbx_doc.trigger event clicked()
	end if
end if

if s_new_mag.tipo_stampa="d_new_scheda_clfo_cl" then
	ldc_temp=dw_2.getitemdecimal(dw_2.rowcount(), "c_tot_quantita")
	
	ll_righe = dw_1.rowcount()
	dw_1.setitem(ll_righe, "ep_qta", ldc_temp)
end if
end event

event resize;call super::resize;iudw_corrente.height=newheight - 350
end event

type pb_1 from w_stampa`pb_1 within w_new_scheda_magazzino_rpt
integer x = 4768
integer y = 4
end type

type cb_preview from w_stampa`cb_preview within w_new_scheda_magazzino_rpt
integer x = 4165
integer y = 4
end type

type dw_1 from w_stampa`dw_1 within w_new_scheda_magazzino_rpt
integer y = 280
integer width = 5975
string dataobject = "d_new_scheda_magazzino"
boolean hscrollbar = false
end type

event dw_1::sqlpreview;call super::sqlpreview;string ls_sql, ls_sql_2, ls_sql_unione
integer i, li_pos


if sqltype<>PreviewUpdate!	then
	if is_sql_originale="" or isnull(is_sql_originale) then is_sql_originale=sqlsyntax  //20230803 provo così, è forse più semplice...
	ls_sql=sqlsyntax
	li_pos=pos(is_sql_originale, "order")
	//ls_sql_2=left(ls_sql, li_pos - 1)
	if li_pos>0 then 
		ls_sql_2=left(is_sql_originale, li_pos - 1)
	else
		ls_sql_2=is_sql_originale
	end if
//	if pos(upper(ls_sql_2), "WHERE") <=0 then ls_sql_2+=
	ls_sql_unione=ls_sql_2+ls_sql_1
	if pos(ls_sql_tipo, "sog_commerciale.")> 0 then
		//applico ma prima guardo se non c'è già:
//		if pos(ls_sql_unione,  "and sog_commerciale.")>0 then
//			ls_sql_unione=left(ls_sql_unione, li_pos - 1) + right(ls_sql_unione, len(ls_sql_unione) - li_pos +1)
//		end if
		ls_sql_unione+= " "+ls_sql_tipo
	elseif  pos(ls_sql_tipo, "Togli tipo")> 0 then
//		if pos(ls_sql_unione,  "and sog_commerciale.tipo")>0 then
//			ls_sql_unione=left(ls_sql_unione, li_pos - 1) + right(ls_sql_unione, len(ls_sql_unione) - li_pos +1)
//		end if
	end if
		
	ls_sql_unione+=" "+ right(ls_sql, len(ls_sql) - li_pos +1)
	i=SetSQLPreview(ls_sql_unione)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
	
end if

end event

event dw_1::itemchanged;call super::itemchanged;decimal ldc_titolo, ldc_peso_netto, ldc_calo, ldc_coef_calo, ldc_fino

IF DWO.NAME="coef_calo" then
	ldc_peso_netto=getitemdecimal(row, "peso_netto")
	ldc_fino=getitemdecimal(row, "fino")
	ldc_titolo=getitemdecimal(row, "orafo_titolo_titolo")
	ldc_coef_calo=dec(data)
	if ldc_coef_calo=0 then ldc_coef_calo=ldc_titolo
	ldc_calo=ldc_peso_netto*ldc_coef_calo/1000 - ldc_fino
	post setitem(row, "calo", ldc_calo)
	
	
end if
	
end event

event dw_1::doubleclicked;//


//messagebox("N", "DC")
long ll_id_doc, ll_row
integer li_pos
string band
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

ll_row=row
if ll_row<=0  then
	band = GetBandAtPointer()
	li_pos=pos(band, char(9))
	if li_pos>0 then
		band=right(band, len(band) - li_pos)
		ll_row=long(band)
		if ll_row<=0 then return
	else
		return
	end if
end if
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(ll_row, "riga_documento_id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

event dw_1::retrieveend;call super::retrieveend;//decimal  ldc_legato_uscita
//if dw_2.rowcount()>0 then
//	if rowcount > 0 then
//		ldc_legato_uscita=dw_2.getitemdecimal(dw_2.rowcount(), "c_tot_peso_uscita")
//		dw_1.describe("t_legato_entrata='"+string(ldc_legato_uscita, "#,0.00")+"'")
//	end if
//end if
end event

type pb_salva_su_file from w_stampa`pb_salva_su_file within w_new_scheda_magazzino_rpt
integer x = 4571
integer y = 4
end type

type pb_stampa from w_stampa`pb_stampa within w_new_scheda_magazzino_rpt
integer x = 4361
integer y = 4
end type

type sle_pg from w_stampa`sle_pg within w_new_scheda_magazzino_rpt
integer x = 1678
integer y = 24
integer width = 265
integer height = 68
end type

type st_1 from w_stampa`st_1 within w_new_scheda_magazzino_rpt
integer x = 1399
integer y = 28
integer height = 68
end type

type st_2 from w_stampa`st_2 within w_new_scheda_magazzino_rpt
boolean visible = true
integer y = 24
integer height = 64
end type

type sle_copie from w_stampa`sle_copie within w_new_scheda_magazzino_rpt
boolean visible = true
integer y = 24
integer width = 155
integer height = 68
integer textsize = -7
end type

type sle_zoom from w_stampa`sle_zoom within w_new_scheda_magazzino_rpt
integer y = 20
integer height = 76
end type

type cb_7 from w_stampa`cb_7 within w_new_scheda_magazzino_rpt
integer y = 20
integer height = 76
end type

type cb_6 from w_stampa`cb_6 within w_new_scheda_magazzino_rpt
integer y = 20
integer height = 76
end type

type cb_pg_dopo from w_stampa`cb_pg_dopo within w_new_scheda_magazzino_rpt
end type

type cb_pg_prima from w_stampa`cb_pg_prima within w_new_scheda_magazzino_rpt
end type

type cb_esci from w_stampa`cb_esci within w_new_scheda_magazzino_rpt
integer x = 5170
integer y = 24
end type

type pb_salva_dw from picturebutton within w_new_scheda_magazzino_rpt
integer x = 4978
integer y = 4
integer width = 169
integer height = 124
integer taborder = 18
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\Salva.png"
alignment htextalign = left!
end type

event clicked;integer li_ret

li_ret=dw_1.update()
if li_ret=1 then
	commit;
else
	rollback;
 	messagebox("Attenzione!", "Salvataggio NON riuscito!")
end if
end event

type cbx_vedi_righe from checkbox within w_new_scheda_magazzino_rpt
integer x = 1033
integer y = 20
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Righe"
end type

event clicked;if checked then
	dw_1.modify("datawindow.detail.height = 88")
else
	dw_1.modify("datawindow.detail.height = 0")
end if
end event

type cbx_doc from checkbox within w_new_scheda_magazzino_rpt
integer x = 1033
integer y = 96
integer width = 485
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nascondi Tot. Doc."
end type

event clicked;integer i
if checked then
	if  dw_1.dataobject="d_new_scheda_clfo_cl" or  dw_1.dataobject="d_new_scheda_clfo_cl_no0" or  dw_1.dataobject="d_new_scheda_clfo_cl_no0c1" then
		dw_1.modify("datawindow.trailer.3.height = 0")
		for I=7 to 17
			dw_1.modify("t_"+string(i)+".visible=0")
		next
	
	else
		dw_1.modify("datawindow.trailer.2.height = 0")
	end if
else
	if  dw_1.dataobject="d_new_scheda_clfo_cl" then
		dw_1.modify("datawindow.trailer.3.height = 86")
	else
		dw_1.modify("datawindow.trailer.2.height = 90")
	end if
end if
end event

type cbx_1 from checkbox within w_new_scheda_magazzino_rpt
integer x = 265
integer y = 96
integer width = 626
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Controllo Fino calo errati"
boolean righttoleft = true
end type

event clicked;string ls_filter

if checked then 
	ls_filter="c_controllo_fino_calo>0"
else
	ls_filter=""
end if

dw_1.setfilter(ls_filter)
dw_1.filter()
end event

type cbx_con_calo from checkbox within w_new_scheda_magazzino_rpt
integer x = 1554
integer y = 96
integer width = 407
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo calo > 0"
end type

event clicked;string ls_filter

if checked then 
	ls_filter="calo>0"
else
	ls_filter=""
end if

dw_1.setfilter(ls_filter)
dw_1.filter()
end event

type cbx_fino_calo_invisibili from checkbox within w_new_scheda_magazzino_rpt
integer x = 265
integer y = 176
integer width = 471
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fino Calo Invisibili"
boolean righttoleft = true
end type

event clicked;string ls_filter, ls_h
integer li_h

if checked then 
	dw_1.modify("fino.visible=0")
	dw_1.modify("calo.visible=0")
	dw_1.modify("c_calo_doc.visible=0")
	dw_1.modify("c_fino_doc.visible=0")
	dw_1.modify("riga_documento_calo_t.visible=0")
	dw_1.modify("riga_documento_fino_t.visible=0")
	
	ls_h=dw_1.describe("c_etichetta_saldo_prec.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_etichetta_saldo_prec.x="+ls_h)
	
	ls_h=dw_1.describe("c_saldo_prec_peso.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_saldo_prec_peso.x="+ls_h)
	
	ls_h=dw_1.describe("c_saldo_prec_fc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_saldo_prec_fc.x="+ls_h)
	
	ls_h=dw_1.describe("t_prog_legato.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("t_prog_legato.x="+ls_h)
	
	ls_h=dw_1.describe("t_prog_fc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("t_prog_fc.x="+ls_h)
	
	ls_h=dw_1.describe("t_fc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("t_fc.x="+ls_h)
	
	ls_h=dw_1.describe("c_finocalo.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_finocalo.x="+ls_h)
	
	ls_h=dw_1.describe("c_prog_finocalo_doc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_finocalo_doc.x="+ls_h)
	
	ls_h=dw_1.describe("c_finocalo_doc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_finocalo_doc.x="+ls_h)
		
	ls_h=dw_1.describe("c_prog_legato_doc.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_legato_doc.x="+ls_h)
	
	ls_h=dw_1.describe("c_prog_finocalo.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_finocalo.x="+ls_h)
		
	ls_h=dw_1.describe("c_prog_legato.x")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_legato.x="+ls_h)
	
	ls_h=dw_1.describe("l_3.x2")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("l_3.x2="+ls_h)
		
	ls_h=dw_1.describe("l_1.x2")
	li_h=integer(ls_h) - 613
	ls_h=string(li_h)
	dw_1.modify("l_1.x2="+ls_h)
else
	dw_1.modify("fino.visible=1")
	dw_1.modify("calo.visible=1")
	dw_1.modify("c_calo_doc.visible=1")
	dw_1.modify("c_fino_doc.visible=1")
	dw_1.modify("riga_documento_calo_t.visible=1")
	dw_1.modify("riga_documento_fino_t.visible=1")
	
	ls_h=dw_1.describe("c_etichetta_saldo_prec.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_etichetta_saldo_prec.x="+ls_h)
	
	ls_h=dw_1.describe("c_saldo_prec_peso.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_saldo_prec_peso.x="+ls_h)
	
	ls_h=dw_1.describe("c_saldo_prec_fc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_saldo_prec_fc.x="+ls_h)
	
	ls_h=dw_1.describe("t_prog_legato.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("t_prog_legato.x="+ls_h)
	
	ls_h=dw_1.describe("t_prog_fc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("t_prog_fc.x="+ls_h)
	
	ls_h=dw_1.describe("t_fc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("t_fc.x="+ls_h)
	
	ls_h=dw_1.describe("c_finocalo.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_finocalo.x="+ls_h)
	
	ls_h=dw_1.describe("c_prog_finocalo_doc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_finocalo_doc.x="+ls_h)
	
	ls_h=dw_1.describe("c_finocalo_doc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_finocalo_doc.x="+ls_h)
		
	ls_h=dw_1.describe("c_prog_legato_doc.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_legato_doc.x="+ls_h)
	
	ls_h=dw_1.describe("c_prog_finocalo.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_finocalo.x="+ls_h)
		
	ls_h=dw_1.describe("c_prog_legato.x")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("c_prog_legato.x="+ls_h)
	
	ls_h=dw_1.describe("l_3.x2")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("l_3.x2="+ls_h)
		
	ls_h=dw_1.describe("l_1.x2")
	li_h=integer(ls_h) + 613
	ls_h=string(li_h)
	dw_1.modify("l_1.x2="+ls_h)
end if


end event

type cbx_summary_invisibile from checkbox within w_new_scheda_magazzino_rpt
integer x = 791
integer y = 176
integer width = 571
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Totali in Fondo Invisibili"
boolean righttoleft = true
end type

event clicked;string ls_filter

if checked then 
	dw_1.modify("datawindow.summary.height = 0")
	
else
dw_1.modify("datawindow.summary.height = 80")
	
end if


end event

type ddlb_1 from dropdownlistbox within w_new_scheda_magazzino_rpt
integer x = 1989
integer y = 20
integer width = 411
integer height = 352
integer taborder = 12
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"Solo Clienti","Solo Fornitori","TUTTI","FO01","FO02","FO03"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_filtro
ls_filtro=Text ( index )

if pos(ls_filtro, "FO")>0  then
	ls_sql_tipo=" and left(sog_commerciale.codice, 4) ='"+ls_filtro+"' "
elseif pos(ls_filtro, "TUTTI")>0  then
	ls_sql_tipo= " Togli tipo "
else
	if ls_filtro="Solo Clienti" then 
		ls_filtro='C'
	else
		ls_filtro='F'
	end if
	ls_sql_tipo= " and sog_commerciale.tipo ='"+ls_filtro+"' "
end if


dw_1.retrieve(s_new_mag.da_data, s_new_mag.a_data, ldc_saldo_peso_precedente, ldc_saldo_fc_precedente)
//dw_1.filter()
//dw_1.MODIFY("c_finocalo_1.format='#,0.00'")
//	dw_1.MODIFY("compute_13.format='#,0.00'")
//	dw_1.MODIFY("c_prog_legato.format='#,0.00'")
end event

type cbx_2 from checkbox within w_new_scheda_magazzino_rpt
integer x = 1413
integer y = 176
integer width = 590
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi saldi precedenti"
end type

event clicked;if checked then
	dw_1.modify("c_saldo_prec_fc_1.visible=1")
	dw_1.modify("c_saldo_prec_peso_1.visible=1")
	dw_1.modify("t_18.visible=1")
	dw_1.modify("t_19.visible=1")
else
	dw_1.modify("c_saldo_prec_fc_1.visible=0")
	dw_1.modify("c_saldo_prec_peso_1.visible=0")
	dw_1.modify("t_18.visible=0")
	dw_1.modify("t_19.visible=0")
end if
end event

type cbx_3 from checkbox within w_new_scheda_magazzino_rpt
integer x = 1993
integer y = 176
integer width = 558
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi saldi di Periodo"
end type

event clicked;integer i

if checked then
	dw_1.MODIFY("c_finocalo_1.visible=1")
	dw_1.MODIFY("c_calo_1.visible=1")
	dw_1.MODIFY("c_fino_1.visible=1")
	dw_1.MODIFY("c_qta_1.visible=1")
	dw_1.MODIFY("c_legato_1.visible=1")
	for i= 13 to 17
		dw_1.MODIFY("t_"+string(i)+".visible=1")
	next
else
	dw_1.MODIFY("c_finocalo_1.visible=0")
	dw_1.MODIFY("c_calo_1.visible=0")
	dw_1.MODIFY("c_fino_1.visible=0")
	dw_1.MODIFY("c_qta_1.visible=0")
	dw_1.MODIFY("c_legato_1.visible=0")
	for i= 13 to 17
		dw_1.MODIFY("t_"+string(i)+".visible=0")
	next
end if
end event

type cb_accorcia from commandbutton within w_new_scheda_magazzino_rpt
integer x = 2473
integer y = 20
integer width = 256
integer height = 92
integer taborder = 12
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Accorcia"
end type

event clicked;integer i
if  s_new_mag.tipo_stampa="d_new_scheda_clfo_cl" or s_new_mag.tipo_stampa="d_new_scheda_clfo_cl_no0" or s_new_mag.tipo_stampa="d_new_scheda_clfo_cl_no0c1" then
	if text="Accorcia" then
		dw_1.modify("c_prog_legato.x=2450") //tutto + 200
		if  s_new_mag.tipo_stampa="d_new_scheda_clfo_cl_no0c1" then
			dw_1.modify("c_prog_fc.x=2450")
			dw_1.modify("t_3.x=4")
		else
			dw_1.modify("c_prog_fc.x=2850")
			dw_1.modify("t_3.x=2850")
		end if
		dw_1.modify("t_2.x=2450")
		
		dw_1.modify("l_4.x2=3200")
		dw_1.object.datawindow.print.orientation=2
		text="Allunga"
	else
		dw_1.modify("c_prog_legato.x=4142") //tutto + 200
		if  s_new_mag.tipo_stampa="d_new_scheda_clfo_cl_no0c1" then
			dw_1.modify("c_prog_fc.x=4112")
			dw_1.modify("t_3.x=4112")
		else
			dw_1.modify("c_prog_fc.x=4512")
			dw_1.modify("t_3.x=4512")
		end if
		dw_1.modify("t_2.x=4142")
		
		dw_1.modify("l_4.x2=4855")
		dw_1.object.datawindow.print.orientation=1
		text="Accorcia"
	end if
elseif s_new_mag.tipo_stampa="d_new_scheda_magazzino_test2" then
	dw_1.modify("c_prog_legato.x=2250")
	dw_1.modify("c_prog_fc.x=2650")
	dw_1.modify("t_2.x=2250")
	dw_1.modify("t_3.x=2650")
	dw_1.modify("l_3.x2=2650")
end if

end event

type dw_2 from udw_000 within w_new_scheda_magazzino_rpt
boolean visible = false
integer x = 69
integer y = 1376
integer width = 4910
integer height = 992
integer taborder = 28
boolean bringtotop = true
string dataobject = "d_new_scheda_magazzino_test2"
boolean vscrollbar = true
end type

event sqlpreview;call super::sqlpreview;string ls_sql, ls_sql_2, ls_sql_unione
integer i, li_pos


if sqltype<>PreviewUpdate!	then
	if is_sql_originale="" or isnull(is_sql_originale) then is_sql_originale=sqlsyntax  //20230803 provo così, è forse più semplice...
	ls_sql=sqlsyntax
	li_pos=pos(is_sql_originale, "order")
	//ls_sql_2=left(ls_sql, li_pos - 1)
	if li_pos>0 then 
		ls_sql_2=left(is_sql_originale, li_pos - 1)
	else
		ls_sql_2=is_sql_originale
	end if
//	if pos(upper(ls_sql_2), "WHERE") <=0 then ls_sql_2+=
	ls_sql_unione=ls_sql_2+ls_sql_1
	if pos(ls_sql_tipo, "sog_commerciale.")> 0 then
		//applico ma prima guardo se non c'è già:
//		if pos(ls_sql_unione,  "and sog_commerciale.")>0 then
//			ls_sql_unione=left(ls_sql_unione, li_pos - 1) + right(ls_sql_unione, len(ls_sql_unione) - li_pos +1)
//		end if
		ls_sql_unione+= " "+ls_sql_tipo
	elseif  pos(ls_sql_tipo, "Togli tipo")> 0 then
//		if pos(ls_sql_unione,  "and sog_commerciale.tipo")>0 then
//			ls_sql_unione=left(ls_sql_unione, li_pos - 1) + right(ls_sql_unione, len(ls_sql_unione) - li_pos +1)
//		end if
	end if
		
	ls_sql_unione+=" "+ right(ls_sql, len(ls_sql) - li_pos +1)
	i=SetSQLPreview(ls_sql_unione)
	if i<>1 then
		messagebox("Errore!", "Filtro non applicato!")
	end if
	
end if




//string ls_sql, ls_sql_2, ls_sql_unione
//integer i, li_pos


//if sqltype<>PreviewUpdate!	then
//	ls_sql=sqlsyntax
//	li_pos=pos(ls_sql, "order")
//	ls_sql_2=left(ls_sql, li_pos - 1)
	
//	ls_sql_unione=ls_sql_2+ls_sql_1
//	if pos(ls_sql_tipo, "and sog_commerciale.tipo")> 0 then
//		//applico ma prima guardo se non c'è già:
		
//		if pos(ls_sql_unione,  "and sog_commerciale.tipo")>0 then
//			ls_sql_unione=left(ls_sql_unione, li_pos - 1) + right(ls_sql_unione, len(ls_sql_unione) - li_pos +1)
//		end if
//		ls_sql_unione+= " "+ls_sql_tipo
//	elseif  pos(ls_sql_tipo, "Togli tipo")> 0 then
//		if pos(ls_sql_unione,  "and sog_commerciale.tipo")>0 then
//			ls_sql_unione=left(ls_sql_unione, li_pos - 1) + right(ls_sql_unione, len(ls_sql_unione) - li_pos +1)
//		end if
//	end if
	
		
//	ls_sql_unione+=" "+ right(ls_sql, len(ls_sql) - li_pos +1)
//	i=SetSQLPreview(ls_sql_unione)
//	if i<>1 then
//		messagebox("Errore!", "Filtro non applicato!")
//	end if
	
//end if
end event

type cbx_4 from checkbox within w_new_scheda_magazzino_rpt
integer x = 2775
integer y = 24
integer width = 421
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filtra Calo>0"
end type

event clicked;if checked then
	dw_1.setfilter("Calo>0")
else
	dw_1.setfilter("")
end if
dw_1.filter()
end event

type cbx_solo_aperte from checkbox within w_new_scheda_magazzino_rpt
boolean visible = false
integer x = 2761
integer y = 32
integer width = 421
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Aperte"
end type

event clicked;if checked then
	dw_1.setfilter("orafo_aper_partita_stato='A'")
else
	dw_1.setfilter("")
end if
dw_1.filter()
end event

type dw_3 from udw_000 within w_new_scheda_magazzino_rpt
boolean visible = false
integer x = 123
integer y = 2044
integer width = 4768
integer taborder = 38
boolean bringtotop = true
string dataobject = "d_tipo_part_excel"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_1 from commandbutton within w_new_scheda_magazzino_rpt
integer x = 4357
integer y = 164
integer width = 635
integer height = 92
integer taborder = 12
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Vedi Coef. Calo Errato"
end type

event clicked;
openwithparm(w_trova_coef_calo_strano, s_new_mag.id_sog_commerciale)
end event

type cbx_5 from checkbox within w_new_scheda_magazzino_rpt
integer x = 2729
integer y = 180
integer width = 480
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi partite chiuse"
end type

event clicked;string ls_filtro

if checked then
	ls_filtro=""
else
	ls_filtro=" orafo_aper_partita_stato='A' or orafo_aper_partita_stato='X' "
end if
dw_1.setfilter(ls_filtro)
dw_1.filter()
dw_1.sort()
dw_1.groupcalc()
end event

type pb_salva_xls from picturebutton within w_new_scheda_magazzino_rpt
integer x = 3822
integer y = 20
integer width = 297
integer height = 92
integer taborder = 22
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva XLS"
boolean originalsize = true
end type

event rbuttondown;long i, ll_riga_inserita
string ls_causale, ls_rag_sociale, ls_num_doc, ls_cod_articolo, ls_met_titolo, ls_nome_file, ls_path
date  ldt_data_doc
decimal ldc_c_calo, ldc_qta, ldc_legato, ldc_calo, ldc_fino, ldc_finocalo, ldc_prog_legato, ldc_prog_finocalo

dw_3.reset()
for i=1 to dw_1.rowcount()
	
	ls_causale=dw_1.getitemstring(i, "caus_magazzino_codice")
	ls_rag_sociale=dw_1.getitemstring(i, "c_rag_sociale")
	ls_num_doc=dw_1.getitemstring(i, "num_documento")
	ldt_data_doc=dw_1.getitemdate(i, "data_documento")
	ls_cod_articolo=dw_1.getitemstring(i, "articolo_codice")
	ls_met_titolo=dw_1.getitemstring(i, "compute_1")
	ldc_c_calo=dw_1.getitemdecimal(i, "coef_calo")
	ldc_qta=dw_1.getitemdecimal(i, "quantita")
	ldc_legato=dw_1.getitemdecimal(i, "c_peso_netto")
	ldc_calo=dw_1.getitemdecimal(i, "c_calo")
	ldc_fino=dw_1.getitemdecimal(i, "c_fino")
	ldc_finocalo=dw_1.getitemdecimal(i, "c_finocalo")
	ldc_prog_legato=dw_1.getitemdecimal(i, "c_prog_legato_riga")
	ldc_prog_finocalo=dw_1.getitemdecimal(i, "c_prog_fc_riga")
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
if s_new_mag.tipo_stampa="d_new_scheda_mag_all" then
	ls_nome_file="Prop_"+s_new_mag.metallo+"_"+string(s_new_mag.da_data,"dd_mm_yy")+"-"+ string(s_new_mag.a_data, "dd_mm_yy")
else
	select rag_soc_1 into :ls_rag_sociale from dba.sog_commerciale_gen where id_sog_commerciale=:s_new_mag.id_sog_commerciale;
	do  while left(ls_rag_sociale, 1)="*" 
		ls_rag_sociale=right(ls_rag_sociale, len(ls_rag_sociale) - 1)
	loop
	ls_nome_file="Scheda_"+s_new_mag.metallo+"_"+left(ls_rag_sociale, 8)+string(s_new_mag.da_data,"dd_mm_yy")+"-"+ string(s_new_mag.a_data, "dd_mm_yy")
end if

dw_3.saveas(ls_path+ls_nome_file+".xls", Excel!, true)
end event

event clicked;long ll_riga_inserita,ll_breakrow,  ll_last_row
integer li_gruppo
string ls_causale, ls_rag_sociale, ls_num_doc, ls_cod_articolo, ls_met_titolo, ls_nome_file, ls_path
date  ldt_data_doc
decimal ldc_c_calo, ldc_qta, ldc_legato, ldc_calo, ldc_fino, ldc_finocalo, ldc_prog_legato, ldc_prog_finocalo
//ll_breakrow = 1
dw_3.reset()
if s_new_mag.tipo_stampa = "d_new_scheda_mag_all" then
    li_gruppo = 2
else
    li_gruppo = 3
end if
ll_breakrow = dw_1.FindGroupChange(ll_breakrow, li_gruppo)
DO WHILE ll_breakrow > 0
     // Calcola l’ultima riga del gruppo corrente
	if ll_breakrow>1 then
     	ll_last_row = ll_breakrow - 1
  		wf_riempi_dw_excel(ll_last_row)		
    		// Passa al prossimo gruppo
	end if
	 // Trova la prima riga del prossimo gruppo
	ll_breakrow = dw_1.FindGroupChange(ll_breakrow + 1, li_gruppo)
LOOP
//20251018: ultio giro cooincide con l'ultima riga...
ll_last_row = dw_1.RowCount()
wf_riempi_dw_excel(ll_last_row)

ls_path="c:\nita\excel\"
If not(DirectoryExists ( ls_path)) Then
	createdirectory(ls_path)
end if
if s_new_mag.tipo_stampa="d_new_scheda_mag_all" then
	ls_nome_file="Prop_D_"+s_new_mag.metallo+"_"+string(s_new_mag.da_data,"dd_mm_yy")+"-"+ string(s_new_mag.a_data, "dd_mm_yy")
else
	select rag_soc_1 into :ls_rag_sociale from dba.sog_commerciale_gen where id_sog_commerciale=:s_new_mag.id_sog_commerciale;
	do  while left(ls_rag_sociale, 1)="*" 
		ls_rag_sociale=right(ls_rag_sociale, len(ls_rag_sociale) - 1)
	loop
	ls_nome_file="Scheda_D_"+s_new_mag.metallo+"_"+left(ls_rag_sociale, 8)+string(s_new_mag.da_data,"dd_mm_yy")+"-"+ string(s_new_mag.a_data, "dd_mm_yy")
end if

dw_3.saveas(ls_path+ls_nome_file+".xls", Excel!, true)
end event

