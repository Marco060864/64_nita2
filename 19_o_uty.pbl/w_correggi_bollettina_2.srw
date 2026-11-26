//objectcomments da mantenere (cancellare il corrreggi bolletina)
forward
global type w_correggi_bollettina_2 from w_001
end type
type dw_1 from udw_base within w_correggi_bollettina_2
end type
type dw_2 from udw_base within w_correggi_bollettina_2
end type
type cb_carica from commandbutton within w_correggi_bollettina_2
end type
type cb_salva from commandbutton within w_correggi_bollettina_2
end type
type cb_esci from commandbutton within w_correggi_bollettina_2
end type
type dw_3 from udw_base within w_correggi_bollettina_2
end type
type cb_stampa from commandbutton within w_correggi_bollettina_2
end type
type cbx_vedi from checkbox within w_correggi_bollettina_2
end type
type cbx_bilancia from checkbox within w_correggi_bollettina_2
end type
type dw_4 from udw_base within w_correggi_bollettina_2
end type
type dw_5 from udw_base within w_correggi_bollettina_2
end type
type cbx_sfrido from checkbox within w_correggi_bollettina_2
end type
type cbx_1 from checkbox within w_correggi_bollettina_2
end type
type rb_data from radiobutton within w_correggi_bollettina_2
end type
type rb_barcode from radiobutton within w_correggi_bollettina_2
end type
type dw_6 from udw_base within w_correggi_bollettina_2
end type
type ole_1 from olecustomcontrol within w_correggi_bollettina_2
end type
type cb_1 from commandbutton within w_correggi_bollettina_2
end type
type dw_8 from u_dw_master_main within w_correggi_bollettina_2
end type
type dw_7 from udw_base within w_correggi_bollettina_2
end type
type dw_9 from u_dw_master_main within w_correggi_bollettina_2
end type
type cbx_vedi_pronto from checkbox within w_correggi_bollettina_2
end type
type dw_10 from udw_base within w_correggi_bollettina_2
end type
type sle_messaggio from singlelineedit within w_correggi_bollettina_2
end type
type rb_13 from radiobutton within w_correggi_bollettina_2
end type
type rb_pacchi from radiobutton within w_correggi_bollettina_2
end type
type sle_1 from singlelineedit within w_correggi_bollettina_2
end type
type st_2 from statictext within w_correggi_bollettina_2
end type
type cbx_no_reset from checkbox within w_correggi_bollettina_2
end type
type rb_bar_2020 from radiobutton within w_correggi_bollettina_2
end type
type cb_rnl from commandbutton within w_correggi_bollettina_2
end type
type dw_11 from udw_001 within w_correggi_bollettina_2
end type
end forward

global type w_correggi_bollettina_2 from w_001
integer x = 1057
integer y = 483
integer width = 4750
integer height = 2800
string title = "Coreggi Bollettine"
boolean minbox = true
windowtype windowtype = popup!
dw_1 dw_1
dw_2 dw_2
cb_carica cb_carica
cb_salva cb_salva
cb_esci cb_esci
dw_3 dw_3
cb_stampa cb_stampa
cbx_vedi cbx_vedi
cbx_bilancia cbx_bilancia
dw_4 dw_4
dw_5 dw_5
cbx_sfrido cbx_sfrido
cbx_1 cbx_1
rb_data rb_data
rb_barcode rb_barcode
dw_6 dw_6
ole_1 ole_1
cb_1 cb_1
dw_8 dw_8
dw_7 dw_7
dw_9 dw_9
cbx_vedi_pronto cbx_vedi_pronto
dw_10 dw_10
sle_messaggio sle_messaggio
rb_13 rb_13
rb_pacchi rb_pacchi
sle_1 sle_1
st_2 st_2
cbx_no_reset cbx_no_reset
rb_bar_2020 rb_bar_2020
cb_rnl cb_rnl
dw_11 dw_11
end type
global w_correggi_bollettina_2 w_correggi_bollettina_2

type prototypes

end prototypes

type variables
string is_ultimo_campo, is_no_reset  //, is_num_pacco
decimal ldc_val_pz_originali[]
integer ii_13
boolean ib_no_lordo=true
//s_pacco is_dati_pacco[]


end variables

forward prototypes
private function string wf_bilancia ()
public subroutine wf_set_col (string as_col)
public function long wf_crea_doc_sfrido (long al_id_registro, long al_id_prof_doc, long al_id_valuta, long al_id_locazione, long al_id_causale)
public subroutine wf_crea_riga_sfrido (long al_id_doc, decimal adc_peso, decimal adc_qta, decimal adc_coef_calo, long al_id_art, long al_id_causale, long al_id_locazione, long al_id_doc_prov, long al_id_valuta, long al_id_doc_provenienza, long al_id_art_padre)
public subroutine wf_crea_pdf ()
public subroutine wf_peso_non_prezioso (long al_riga, decimal adc_qta, long al_id_uc)
public function integer wf_salva_riga (long al_row)
public subroutine wf_crea_doc ()
public function long wf_crea_pronto (long al_id_ordine)
public subroutine wf_aggiungi_riga (long al_id_doc, long al_id_bollettina, long al_id_riga_bollettina)
public function integer wf_controlla_peso ()
public subroutine wf_impacchetta ()
public subroutine wf_controllo_se_esiste_testa (string as_num_doc)
public subroutine wf_incartato_imbustato (long al_row, decimal adc_tara)
public subroutine wf_chiudi_pacco (long al_riga, decimal adc_peso, long al_id_bollettina)
public subroutine wf_ins_bol_in_pacco (long al_riga, long al_id_riga_bollettina)
public function long wf_gia_in_pacco (long al_id_riga_bollettina)
public subroutine wf_agg_peso_pacco (long al_riga, decimal adc_peso)
public subroutine wf_chiudi_pacco_new (long al_id_pacco)
end prototypes

private function string wf_bilancia ();long	ll_row
string Buffer, buffer2, ls_bilancia
integer li_pos
decimal ld_peso_netto
string ls_peso
boolean lb_test
//' Open the serial port

   
   
	
	ls_bilancia = ProfileString ( "cometa.ini", "PC", "Bilancia", "Error!" )
	choose case ls_bilancia
		case "mettler"
			OLE_1.object.CommPort = 1  //' Set the port number
			OLE_1.object.Settings = "9600,E,7,1"
			OLE_1.object.PortOpen = True           //' Required, might lock port
			sleep(1)
			Buffer = OLE_1.object.Input //' Read data
			 
			OLE_1.object.PortOpen = False
			li_pos=pos(buffer, "S")
			ls_peso=mid(buffer, li_pos+2, 10)  
	
			li_pos=pos(ls_peso, ".")
			ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		//ld_peso_netto=dec(ls_peso)
		case "sartorius"
			OLE_1.object.CommPort = 1  //' Set the port number
			OLE_1.object.Settings = "1200,N,7,1"  //' Set UART parameters
	
			OLE_1.object.PortOpen = True           //' Required, might lock port
	 
			sleep(1)
	  //MsComm1.Output = "Text string"    ' Send data
			Buffer = OLE_1.object.Input //' Read data
	 
			OLE_1.object.PortOpen = False
			if len(buffer)>30 then
				li_pos=pos(Buffer, "+", 16)
			else
				li_pos=pos(Buffer, "+", 1)
			end if
		  ls_peso=mid(buffer, li_pos, 11)
		  ls_peso=left(ls_peso, 10)
		  ls_peso=right(ls_peso, 9)
			ls_peso=trim(ls_peso)
			li_pos=pos(ls_peso, ".")
			ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
		case "strumenta"
			OLE_1.object.CommPort = 2  //' Set the port number
			OLE_1.object.Settings = "4800,N,8,1"  //' Set UART parameters
	
			OLE_1.object.PortOpen = True           //' Required, might lock port
	 
			sleep(1)
	  //MsComm1.Output = "Text string"    ' Send data
			Buffer = OLE_1.object.Input //' Read data
			OLE_1.object.PortOpen = False
			messagebox("CORR_BOLL", buffer)
//			if len(buffer)>30 then
//				li_pos=pos(Buffer, "+", 16)
//			else
//				li_pos=pos(Buffer, "+", 1)
//			end if
//		  ls_peso=mid(buffer, li_pos, 11)
//		  ls_peso=left(ls_peso, 10)
//		  ls_peso=right(ls_peso, 9)
//			ls_peso=trim(ls_peso)
//			li_pos=pos(ls_peso, ".")
//			ls_peso=left(ls_peso, li_pos - 1)+","+right(ls_peso, len(ls_peso) - li_pos)
	end choose
dw_1.setitem(dw_1.getrow(), "riga_doc_estensione_data_ora_modifica", today())
return(ls_peso)

					





//boolean lb_controllo
//string ls_prova, ls_peso, ls_path, ls_str, ls_str2, ls_str3
//char lc_rit[255]
//long	ll_row
//integer li_app
//ls_peso=''
//
//
//
//select dir_report into :ls_path from par_sistema;
//
//ls_str2= ls_path + "\pesata.txt"
//ls_str3= ls_path + "\config.txt"
//
//ls_str = ls_path + "\peso.exe "+ ls_str3 +" "+ ls_str2
//FileDelete ( ls_str2 )
//
//li_app=Run(ls_str, Minimized!)
//
//
//
//ls_str=ls_path + "\pesata.txt"
//
//
//time stop
//long conta=0
//open(w_attesa)
//stop=now()
//stop=relativetime(stop, 20 )
//li_app=-1
//DO WHILE  now() < stop and li_app=-1
//	conta=conta + 1
//	li_app=fileopen((ls_str),LineMode!,Read!,LockWrite!,Replace!)	
//LOOP
//close(w_attesa)
//if li_app=-1 then 
//	messagebox('Attenzione', "Il peso non è stato letto correttamente, procedere con l'inserimento manuale!")
//	return
//end if	
//	
//fileRead(li_app,ls_peso)
//fileclose(li_app)
//
//ls_peso=Replace(ls_peso, 1, 6, "")
//
//tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.protect=0")
//tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.background.color=16777215")
//tab_1.tabpage_2.dw_riga_documento_ordine_gd.modify("riga_documento_peso_netto.color=0")
//
//ll_row = tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
//
//DWObject my_dwo
//decimal ld_peso_netto
//ld_peso_netto=dec(string(ls_peso))/1000
//					
//my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
//tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row,"riga_documento_peso_netto",dec(string(ls_peso))/1000)
//tab_1.tabpage_2.dw_riga_documento_ordine_gd.trigger event itemchanged(ll_row, my_dwo, string(ld_peso_netto))

end function

public subroutine wf_set_col (string as_col);dw_1.setcolumn(as_col)
end subroutine

public function long wf_crea_doc_sfrido (long al_id_registro, long al_id_prof_doc, long al_id_valuta, long al_id_locazione, long al_id_causale);//crea un doc per lo sfrido di lavorazione
//prende causale e profilo doc da par_sistema orafo
//intestatario è = a quello delle bollettine
//la causale scarica mag e cliente (-) della percentuale indicata
//in par sist_orafo gli articoli mandati in produzione
//così riequilibra il magazzino che altrimenti rimane sopra alla realtà
//RICHIESTA SIlVERDREAMS 260410
//nella creazione della riga riporto su id_riga-doc_provenienza l'id riga
//della bollettina (dw_1)
long ll_id_doc
long ll_num_prog, ll_id_sog
string ls_num_doc
if dw_4.rowcount()<=0 then
	dw_4.insertrow(0)
else
	return -1
end if

select num_progressivo
into :ll_num_prog
from registro
where id_registro=:al_id_registro
;
ls_num_doc=string(ll_num_prog)
ll_id_sog=dw_2.getitemnumber(1, "id_soggetto")


dw_4.setitem(1, "id_prof_documento", al_id_prof_doc)
dw_4.setitem(1, "num_documento", ls_num_doc)
dw_4.setitem(1, "id_registro", al_id_registro)
dw_4.setitem(1, "data_registrazione", today())
dw_4.setitem(1, "data_documento", today())
dw_4.setitem(1, "num_progressivo", ll_num_prog)
dw_4.setitem(1, "id_sog_commerciale", ll_id_sog)
dw_4.setitem(1, "id_valuta", al_id_valuta)
if dw_4.update()=1 then
	ll_id_doc = dw_4.getitemnumber(1, "id_documento")
else
	ll_id_doc= -1
end if
return ll_id_doc
end function

public subroutine wf_crea_riga_sfrido (long al_id_doc, decimal adc_peso, decimal adc_qta, decimal adc_coef_calo, long al_id_art, long al_id_causale, long al_id_locazione, long al_id_doc_prov, long al_id_valuta, long al_id_doc_provenienza, long al_id_art_padre);long ll_riga, ll_id_uc
string ls_num_doc_prov, ls_cod_art_padre

ll_riga=dw_5.insertrow(0)
select id_unita_confezione
into :ll_id_uc
from unita_confezione
where id_articolo=:al_id_art
and unita_base='S';

select num_documento
into :ls_num_doc_prov
from dba.documento
where id_documento=:al_id_doc_provenienza
;
select codice
into :ls_cod_art_padre
from articolo
where id_articolo=:al_id_art_padre
;

dw_5.setitem(ll_riga, "id_documento", al_id_doc)
dw_5.setitem(ll_riga, "num_riga", ll_riga)
dw_5.setitem(ll_riga, "id_unita_confezione", ll_id_uc)
dw_5.setitem(ll_riga, "id_articolo", al_id_art)
dw_5.setitem(ll_riga, "peso_netto", adc_peso)
dw_5.setitem(ll_riga, "descrizione", "Sfrido da Bollettina n. "+ls_num_doc_prov+&
					" - Articolo padre: "+ls_cod_art_padre)
dw_5.setitem(ll_riga, "quantita", adc_qta)
dw_5.setitem(ll_riga, "qta_un_base", adc_qta)
dw_5.setitem(ll_riga, "id_valuta", al_id_valuta)
dw_5.setitem(ll_riga, "id_locazione_1", al_id_locazione)
dw_5.setitem(ll_riga, "id_caus_magazzino", al_id_causale)
dw_5.setitem(ll_riga, "id_riga_doc_provenienza", al_id_doc_prov)
dw_5.setitem(ll_riga, "id_azienda", 1)
dw_5.setitem(ll_riga, "coef_calo", adc_coef_calo)



if dw_5.update()=1 then
  commit;
else
	rollback;
	Messagebox("Attenzione!", "Riga sfrido non salvata! Articolo: "+string(al_id_art))
end if
end subroutine

public subroutine wf_crea_pdf ();string ls_nome_file, ls_test, ls_email, ls_stampante
integer li_File, li_ret

ls_nome_file=sle_1.text
if ls_nome_file="" or isnull(ls_nome_file) then ls_nome_file="c:\nita\sped\"
if right(ls_nome_file, 1)<>"\" then ls_nome_file+="\"


ls_nome_file+="SPED_"+string(today(), "dd_mm_yy_hh_mm_ss")+".pdf"
//ls_nome_file="C:\start\spediz\PIPPO.pdf"

ls_test=dw_1.Modify("DataWindow.Print.documentname = '"+ls_nome_file+"'")
ls_test=dw_1.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")

	dw_1.Modify ('DataWindow.Printer="Sybase DataWindow PS" ')
	dw_1.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
	
	dw_1.Modify("Export.PDF.Method = Distill!")
	
	
	dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")

	
	//ls_stampante = dw_1.Describe("DataWindow.Printer")
	//messagebox("Stampante!", ls_stampante)
	
	
	li_ret=dw_1.SaveAs(ls_nome_file, PDF!, FALSE)
	
	IF LI_RET<> 1 THEN
		messagebox("Errore!", "File PDF non generato!")	
	end if
	
	
	//if ls_test="" then 
//	ls_stampante="Acrobat PDFWriter"
//	ls_test=dw_1.Modify("DataWindow.Print.printername = '"+ls_stampante+"'")
//	dw_1.print()
//else
//	messagebox("Errore!", "File PDF non generato!")	
//end if


//This example specifies an HP LaserJet PostScript printer as the printer to be used to export PDF with customized settings, and saves the data to a file called custom.pdf:

//int li_ret

 

//dw_1.Object.DataWindow.Export.PDF.Method = Distill!
//
//dw_1.Object.DataWindow.Printer = "Sybase DataWindow PS"
//
//dw_1.Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"
//
// 
//
//li_ret = dw_1.SaveAs("custom.pdf", PDF!, true)
//
//This example uses Modify to set the PDF export properties and specify a network printer:

//dw_1.Modify("Export.PDF.Method = Distill!")
//
//dw_1.Modify("Printer = 'Sybase DataWindow PS' ")
//
//dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
//




//	dw_1.Modify ('DataWindow.Printer="Sybase DataWindow PS" ')
//	dw_1.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
//	
//	dw_1.Modify("Export.PDF.Method = Distill!")
//	
//	
//	dw_1.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
//	
//	ls_test=dw_1.Modify("DataWindow.Print.documentname = '"+ls_nome_file+"'")
//	ls_test=dw_1.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")
end subroutine

public subroutine wf_peso_non_prezioso (long al_riga, decimal adc_qta, long al_id_uc);decimal ldc_peso_non_prez

select peso_non_prezioso
into :ldc_peso_non_prez
from dba.unita_confezione
where id_unita_confezione=:al_id_uc
;
dw_1.setitem(al_riga, "peso_non_prezioso", ldc_peso_non_prez*adc_qta)
end subroutine

public function integer wf_salva_riga (long al_row);
return dw_1.trigger event ue_update()



end function

public subroutine wf_crea_doc ();
end subroutine

public function long wf_crea_pronto (long al_id_ordine);
integer i
long ll_id_prof_doc, ll_id_registro, ll_num_prog, ll_id_sog
long ll_id_valuta, ll_id_prof_reg, ll_id_doc, ll_id_caus, ll_riga_doc_selezionata
string ls_num_doc, ls_des_art,ls_contatore, ls_num_doc_originale
date ldt_data_doc, ldt_oggi
long ll_id_locazione, ll_id_contropartita, ll_id_tab_iva,ll_riga_stampa, ll_id_dest
long ll_test,ll_id_mod_reg,ll_riga, ll_id_articolo, ll_id_uc,ll_id_null, ll_riga_inserita
decimal ldc_qta, ldc_misura, ldc_coef_calo, ldc_prezzo, ldc_qta_divisa
long ll_riga_passata, ll_id_riga, ll_id_riga_ordine,ll_id_bol, ll_righe_prod, ll_riga_esiste
date ldt_data_scadenza
string ls_bollo, ls_nota_produzione, ls_nota_qualita
long lL_id_con_pag, lL_id_banca_sog

dw_7.insertrow(1)
//recupero il bollo e altro
select bollo, id_sog_commerciale, data_prev_consegna, num_documento, id_destinazione
into :ls_bollo, :ll_id_sog, :ldt_data_scadenza, :ls_num_doc, :ll_id_dest
from dba.documento d, dba.riga_documento r
where id_riga_documento=:al_id_ordine
and r.id_documento=d.id_documento
;
//140312 inserisco anche bollo eventuale e data prev_consegna (data scadenza ordine)
dw_7.setitem(1, "data_prev_consegna", ldt_data_scadenza)
dw_7.setitem(1, "bollo", ls_bollo)
dw_7.setitem(1, "num_documento", ls_num_doc)
dw_7.setitem(1, "id_sog_commerciale", 	ll_id_sog)
dw_7.setitem(1, "id_sog_commerciale_fattura", 	ll_id_sog)
dw_7.setitem(1, "id_destinazione", 	ll_id_dest)
//trovo id_pagamento e banca da proporre e le inserisco (per eventuale derivazinoe in bolla)
select id_con_pagamento, id_banca_sog_commerciale
into :lL_id_con_pag, :lL_id_banca_sog
from dba.sog_commerciale
where id_sog_commerciale=:ll_id_sog;
if lL_id_banca_sog>0 then
	dw_7.setitem(1, "id_banca_sog_commerciale", lL_id_banca_sog)
end if
if lL_id_con_pag>0 then
	dw_7.setitem(1, "id_con_pagamento", lL_id_con_pag)
end if

//inserisco valorizzazine di flag che poi bloccano la derivazinne se nulli!!!!
dw_7.setitem(1, "sospeso", "N")
dw_7.setitem(1, "bloccato", "N")
dw_7.setitem(1, "evaso_totalmente", "N")
dw_7.setitem(1, "chius_forzata", "N")

dw_7.setitem(1, "data_documento", today())
dw_7.setitem(1, "data_competenza", today())

select id_prof_registrazione, id_prof_documento, id_caus_magazzino_prop, id_locazione_1_prop, id_mod_registro_prop
into :ll_id_prof_reg, :ll_id_prof_doc, :ll_id_caus, :ll_id_locazione, :ll_id_mod_reg
from dba.prof_documento
where codice='PRONTO';

dw_7.setitem(1, "id_prof_documento", ll_id_prof_doc)
dw_7.setitem(1, "id_magazzino", ll_id_locazione)
dw_7.setitem(1, "documento_id_locazione_1", ll_id_locazione)
dw_7.setitem(1, "id_caus_magazzino", ll_id_caus)

ldt_oggi=today()
//recupero il registro
select id_registro
into :ll_id_registro
from dba.registro r, dba.esercizio e
where id_mod_registro=:ll_id_mod_reg
and e.id_esercizio=r.id_esercizio
and e.data_inizio<=:ldt_oggi
and e.data_fine>=:ldt_oggi
;

dw_7.setitem(1, "id_prof_registrazione", ll_id_prof_reg)
dw_7.setitem(1, "id_registro", ll_id_registro)
select num_progressivo
into :ll_num_prog
from registro
where id_registro=:ll_id_registro
;

dw_7.setitem(1, "num_progressivo", ll_num_prog)

dw_7.setitem(1, "data_registrazione", 	today())

//trova contropartita
select id_conto
into :ll_id_contropartita
from dba.con_movimento
where id_sog_commerciale=:ll_id_sog
and applicazione='V'
;
if isnull(ll_id_contropartita) or ll_id_contropartita=0 then
	select id_conto_predefinito
	into :ll_id_contropartita
	from dba.par_sistema;
end if
select id_tab_iva
into :ll_id_tab_iva
from dba.sog_commerciale
where id_sog_commerciale=:ll_id_sog
;
if isnull(ll_id_tab_iva) then
	select id_conto_iva_ia
	into :ll_id_tab_iva
	from dba.par_sistema;
end if

//valuta
select id_val_euro
into :ll_id_valuta
from dba.par_sistema;
dw_7.setitem(1, "id_valuta", 	ll_id_valuta)

//ora provo a salvare
dw_7.triggerevent("ue_update")

ll_id_doc=dw_7.getitemnumber(1, "id_documento")
//se tutto va bene carico le righe

return ll_id_doc
end function

public subroutine wf_aggiungi_riga (long al_id_doc, long al_id_bollettina, long al_id_riga_bollettina);//aggiunge la riga ad un documento esistente (argomento dà id documento)
//poi lega la riga aggiunta e salvata alla bollettina (secondo argomento)
long ll_null, ll_righe, ll_id_caus, ll_riga_esiste,ll_riga_inserita
long ll_num_riga, ll_righe_prod, ll_id_riga_pronto,LL_ID_LOCAZIONE, LL_ID_PROF_PRONTO
integer li_test
datastore ds_prod_2011

setnull(ll_null)

if al_id_doc>0 then
	dw_9.reset()
	dw_8.reset()
	ll_righe=dw_9.retrieve(al_id_riga_bollettina)
	if ll_righe=1 then
		li_test=dw_9.rowscopy(1,1,Primary!, dw_8,1,Primary!)
		//devo annullare l'id_riga_documento
		dw_8.setitem(ll_righe, "id_riga_documento", ll_null)
		//reimposare l'id_documento
		dw_8.setitem(ll_righe, "id_documento", al_id_doc)
		//la causale
		select id_caus_magazzino
		INTO :ll_id_caus
		from dba.documento
		where id_documento=:al_id_doc
		;
		select id_prof_documento
		into :LL_ID_PROF_PRONTO
		from dba.prof_documento
		where codice='PRONTO'
		;
		select id_locazione_1_prop
		into :LL_ID_LOCAZIONE
		from dba.prof_documento
		where id_prof_documento=:LL_ID_PROF_PRONTO;
		if isnull(LL_ID_LOCAZIONE) then
			messagebox("Attenzione!", "Locazione non recuperata: controllare se esiste un profilo con codice='PRONTO'")
		end if
		
		dw_8.setitem(ll_righe, "riga_documento_id_caus_magazzino", ll_id_caus)
		dw_8.setitem(ll_righe, "id_LOCAZIONE_1", LL_ID_LOCAZIONE)
		//il numero di riga (se c'è già una riga ...
		select max(num_riga)
		into :ll_num_riga
		from dba.riga_documento
		where id_documento=:al_id_doc;
		if isnull(ll_num_riga) then ll_num_riga=0
		ll_num_riga++
		dw_8.setitem(ll_righe, "riga_documento_num_riga", ll_num_riga)
		//cambiare lo stato della riga
		li_test=dw_8.setitemstatus(1, 0, Primary!, NewModified!)
		//salvare
		if dw_8.update()=1 then
			commit;
				ll_id_riga_pronto=dw_8.getitemnumber(1, "id_riga_documento")
				ds_prod_2011=create datastore
				ds_prod_2011.dataobject="d_produzione_2011_ra_gd"
				ds_prod_2011.settransobject(sqlca)
				ll_righe_prod=ds_prod_2011.retrieve(al_id_bollettina)
				if ll_righe_prod>0 then
					ll_riga_esiste=ds_prod_2011.find("id_doc_produzione="+string(ll_id_riga_pronto), 1, ds_prod_2011.rowcount())
				else
					ll_riga_esiste=0
				end if
				//se esiste già non faccio nulla
				if ll_riga_esiste<=0 then
					ll_riga_inserita=ds_prod_2011.insertrow(0)
					ds_prod_2011.setitem(ll_riga_inserita, "id_bollettina", al_id_bollettina)
					ds_prod_2011.setitem(ll_riga_inserita, "id_doc_produzione", ll_id_riga_pronto)
					//salvo
					if ds_prod_2011.update()=1 then
						commit;
					else
						rollback;
						messagebox("Errore!", "Legame con bollettina non salvato!")
					end if
				end if
		else
			rollback;
			messagebox("Attenzione!", "Salvataggio riga non riuscito 28")
		end if
	end if
end if
destroy ds_prod_2011
//		//proviamo a vedere se copiando la riga e cambiando solo qta, 
//		//id_documento e stato può fungere ...
//		
//		if dw_1.rowscopy(i, i, Primary!, dw_4, 1, Primary!)=1 then
//			//qui va inserito recupero note prod e qualità
//			//però ci manca l'id_riga_documento qundi occorre saqlvare riga riga
//			//recuperare l'id_riga e salvare in note prod e qualità con l'id Riga recuperato
//			ll_id_riga_ordine=dw_2.getitemnumber(i, "id_riga_documento")
//			dw_4.setitem(1, "id_riga_documento", ll_id_null)
//			dw_4.setitem(1, "quantita", ldc_qta_divisa)
//			dw_4.setitem(1, "qta_un_base", ldc_qta_divisa)
//			dw_4.setitem(1, "id_documento", ll_id_doc)
//			dw_4.setitem(1, "riga_documento_id_caus_magazzino", ll_id_caus)
//			dw_4.setitem(1, "id_locazione_1", ll_id_locazione)
//			dw_4.setitem(1, "riga_documento_peso_netto", 0)
//			dw_4.setitem(1, "peso_netto_evaso", 0)
//			
//			dw_4.setitem(1, "riga_documento_num_riga", 1)
//			dw_4.setitem(1, "riga_documento_provv_imp_subage_2", ll_id_riga_ordine)
//			//dw_4.setitem(1, "id_riga_doc_provenienza", ll_id_riga_ordine)
//			//dw_4.setitemstatus(1, 0, Primary!, NewModified!)
//			if dw_4.update()=1 then
//				commit;
//			else
//				rollback;
//				messagebox("Attenzione!", "Riga non salvata!")
//			end if
//			select id_riga_documento
//			into :ll_id_riga
//			from dba.riga_documento
//			where id_documento=:ll_id_doc
//			and num_riga=1
//			;
//			if ll_id_riga>0 then
//				select nota_produzione, nota_qualita
//				into :ls_nota_produzione ,:ls_nota_qualita
//				from dba.nota_riga_documento
//				where note_id_riga_doc=:ll_id_riga_ordine
//				;
//				if ls_nota_produzione>" " or ls_nota_qualita>" " then
//					insert into dba.nota_riga_documento
//					values(:ll_id_riga, :ls_nota_produzione, :ls_nota_qualita)
//					;
//					if sqlca.sqlcode=0 then
//						commit;
//					else
//						rollback;
//						messagebox("Attenzione!", "Nota prod. e Qualità non salvata!")
//					end if
//				end if
//			else
//				messagebox("Attenzione!", "Riga non salvata!")
//			end if
//			//esplodo la riga inserita nella bollettina nei suoi componenti
//			wf_prepara_esplodi(i, string(ldc_qta_divisa))
//									
//			//inserisco in dw per stampa bollettine create
//			ll_riga_stampa=dw_6.insertrow(0)
//			dw_6.setitem(ll_riga_stampa, "id_documento", ll_id_doc)
//			dw_6.setitem(ll_riga_stampa, "num_progressivo", ll_num_prog)
//			dw_6.setitem(ll_riga_stampa, "data_registrazione", today())
//			dw_6.setitem(ll_riga_stampa, "pezzi", ldc_qta_divisa)
//			dw_6.setitem(ll_riga_stampa, "num_doc", ls_num_doc)
//			
//		else
//			messagebox("Attenzione!", "Riga non copiata!")	
//		end if
//	else
//		messagebox("Errore!", "Documento non salvato!")
//	end if
////commentato 190312 da rimettere a posto				
////				loop
////fine commentato 190312 da rimettere a posto
//
////provo a salvare le righe una riga alla volta (con le righe esplose se ci sono)
//if dw_4.update()=1 then
//	commit;
////					//devo legare l'ordine alla bollettina (id_bollettina- id_doc_ordine in produzione_2011
//	ll_id_bol=dw_4.getitemnumber(1, "id_documento")
//	ds_prod_2011=create datastore
//	ds_prod_2011.dataobject="d_produzione_2011_ra_gd"
//	ds_prod_2011.settransobject(sqlca)
//	ll_righe_prod=ds_prod_2011.retrieve(ll_id_bol)
//	if ll_righe_prod>0 then
//		ll_riga_esiste=ds_prod_2011.find("id_doc_produzione="+string(ll_id_riga_ordine), 1, ds_prod_2011.rowcount())
//	else
//		ll_riga_esiste=0
//	end if
//	//se esiste già non faccio nulla
//	if ll_riga_esiste<=0 then
//		ll_riga_inserita=ds_prod_2011.insertrow(0)
//		ds_prod_2011.setitem(ll_riga_inserita, "id_bollettina", ll_id_bol)
//		ds_prod_2011.setitem(ll_riga_inserita, "id_doc_produzione", ll_id_riga_ordine)
//		//salvo
//		if ds_prod_2011.update()=1 then
//			commit;
//		else
//			rollback;
//			messagebox("Errore!", "Legame con bollettina non salvato!")
//		end if
//	end if
end subroutine

public function integer wf_controlla_peso ();integer i
decimal ldc_peso
string ls_test

for i= 1 to dw_1.rowcount()
	ls_test=dw_1.getitemstring(i, "ordinato_fo")
	if ls_test = 'S' then
		ldc_peso=dw_1.getitemdecimal(i, "peso_netto")
		if isnull(ldc_peso) or ldc_peso<=0 then
			messagebox("Attenzione!", "Riga "+string(i)+ " NON ha peso!")
			return -1
		end if
	end if
next
return 1
end function

public subroutine wf_impacchetta ();long ll_id_pacco, ll_id_riga_bollettina, ll_riga_inserita, ll_row, ll_num_prog
datastore ds_pacco_bollettina
integer i, li_scelto
string ls_test,  ls_pacco_scelto, ls_des_pacco
date  ldt_data
long ll_righe

/*
if(mid(  pacco_codice , 2, 2 )='01', "NON Urgente", 
if(mid(  pacco_codice , 2, 2 )='02',"Merce Urgente Cliente Lista", 
IF (mid(  pacco_codice , 2, 2 )='03'"Merce Urgente per Scadenza Data Non in Lista")))
*/
//ll_row=dw_11.getrow()


	
	ds_pacco_bollettina=create datastore
	ds_pacco_bollettina.dataobject="d_pacco_bollettina_gd"
	ds_pacco_bollettina.settransobject(sqlca)
	
//	ll_id_pacco=getitemnumber(row, "id_pacco")
	//ls_pacco_des=dw_11.getitemstring(ll_row, "descrizione")
	//if messagebox("Attenzione!", "Vuoi salvare le bollettine selezionate nel pacco "+ls_pacco_des+"?", stopsign!, yesno!)=1 then
		ldt_data=date(string(today(), "yyyy/mm/dd"))
		ll_righe=dw_1.rowcount()
//		messagebox("righe", dw_1.rowcount())
		for i = 1 to ll_righe
			
			li_scelto=dw_1.getitemnumber(i, "c_scelto")
			if li_scelto>0 and li_scelto<100 then //controllo se la bollettina è già in qualche pacco
				ll_id_riga_bollettina=dw_1.getitemnumber(i,"id_riga_documento")
				ll_num_prog=dw_1.getitemnumber(i,"num_progressivo")
				select codice
				into :ls_test
				from dba.pacco_bollettina pb, dba.pacco p
				where id_bollettina=:ll_id_riga_bollettina
				and p.id_pacco=pb.id_pacco
				;
				if ls_test>" " then
					messagebox("Attenzione!", "La bollettina N.Prog. "+string(ll_num_prog)+" è già presente nel pacco "+ls_test)
					continue
				end if
			
				//la bollettina non è presente in alcun pacco finora quindi ...
				// trovo il pacco con primi tre numeri="80"+string(li_scelto)
				ls_pacco_scelto="80"+string(li_scelto)
				select id_pacco, descrizione
				into :ll_id_pacco, :ls_des_pacco
				from dba.pacco
				where left(codice, 3)=:ls_pacco_scelto
				and date(dataora)>= :ldt_data
				and (chiuso='N' or chiuso=null)
				;
				if ll_id_pacco> 0 then
					dw_1.setitem(i, "id_pacco", ll_id_pacco)
					ll_riga_inserita=ds_pacco_bollettina.insertrow(0)
					ds_pacco_bollettina.setitem(ll_riga_inserita, "id_pacco", ll_id_pacco)
					ds_pacco_bollettina.setitem(ll_riga_inserita, "id_bollettina", ll_id_riga_bollettina)
			
					if ds_pacco_bollettina.update()<>1 then
						rollback;
						messagebox("Attenzione!", "Le bollettine non sono state associate al pacco "+ls_test+ "!")
					else
						commit;
						//se ho salvato segno la bollettina come impacchettata
						dw_1.setitem(i, "c_scelto", 9999)
					end if
				else
					Messagebox("Attenzione!", "Pacco "+ls_des_pacco+ " NON trovato!")
				end if
			end if
			
		next
	//end if
	destroy ds_pacco_bollettina
	

end subroutine

public subroutine wf_controllo_se_esiste_testa (string as_num_doc);//string ls_numero
//long ll_num_prog
//date ldt_data_doc
//
//select num_progressivo, data_documento, num_documento
//into :ll_num_prog, :ldt_data_doc, :ls_numero
//from dba.documento
//where num_documento=:as_num_doc
//;
//if ll_num_prog>0 then
//	messagebox("Attenzione!", "Esiste il documento num_prog "+string(ll_num_prog)+&
//					", num_documento: "+ls_numero+", data documento: "+string(ldt_data_doc)+&
//					" che pare non abbia righe!! CONTROLLARE!")
//end if
f_controllo_se_esiste_testa(as_num_doc)
end subroutine

public subroutine wf_incartato_imbustato (long al_row, decimal adc_tara);long ll_id_variazione, ll_id_uc, ll_id_sog
string ls_des_2, ls_des, ls_parte_destra
integer li_pos
date ldt_data_doc

//Samy chiede di aggiungere "Incartato/Imbustato" se la tara>0 e nella des2 NON 'c'è "Ki"
ls_des=dw_1.getitemstring(al_row, "riga_documento_descrizione")
if adc_tara>0 then
	
	if pos(ls_des, "-Incartato/imbustato-")<=0 then //se non c'è lo aggiungo se c'è non faccio nulla
		ll_id_sog=dw_1.getitemnumber(al_row, "id_sog_commerciale")
		ldt_data_doc=dw_1.getitemdate(al_row, "documento_data_documento")
		select id_variazione 
		into :ll_id_variazione
		from dba.variazione v, dba.sog_commerciale s
		where v.id_listino=s.id_listino
		and s.id_sog_commerciale=:ll_id_sog
		and v.data_inizio<= :ldt_data_doc and v.data_fine>= :ldt_data_doc
		;
		ll_id_uc=dw_1.getitemnumber(al_row, "id_unita_confezione")
		select des_2 into :	ls_des_2 from dba.prezzo
		where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc;		
		ls_des_2=upper(ls_des_2)
		if ls_des_2> " " then
			if isnull(ls_des_2) then ls_des_2=" "
			if pos(ls_des_2, "KI")<=0 then
				if isnull(ls_des) then ls_des=" "
				ls_des+= "-Incartato/imbustato-"
				dw_1.setitem(al_row, "riga_documento_descrizione", ls_des)
			end if
		end if
	end if
else //se è =0 o nulla devo controllare se c'è "-Incartato/imbustato-" e toglilerlo
	li_pos= pos(ls_des, "-Incartato/imbustato-")
	if li_pos>0 then
		if len(ls_des)> li_pos+21 then ls_parte_destra=mid(ls_des, li_pos+21, len(ls_des))
		if isnull(ls_parte_destra) then ls_parte_destra=""
		ls_des=left(ls_des, li_pos - 1)+ls_parte_destra
		dw_1.setitem(al_row, "riga_documento_descrizione", ls_des)
	end if
end if
end subroutine

public subroutine wf_chiudi_pacco (long al_riga, decimal adc_peso, long al_id_bollettina);//20220710 sommo il peso del movimento precedente e controllo
//se è >18000 grammi chiudo il pacco
//altrimenti incremento le righe nel pacco e aspetto il prossimo giro
 integer i, li_len, li_ultimo_numero
 long ll_id_pacco
 date ldt_oggi, ldt_data_test
 string ls_numero, ls_num_pacco, ls_test
 datetime ldt_dataora
 decimal ldc_peso_pacco

//se è già spedita NON faccio nulla 20220722 (Samy concorda)
ll_id_pacco=wf_gia_in_pacco(al_id_bollettina)
if ll_id_pacco>0 then 
	//dai il messaggio
	messagebox("Attenzione!", "Bollettina già nel pacco: "+ls_test)
	return
end if
// 20220722 fine
ldt_oggi=dw_2.getitemdate(1,"spedizione")
//trovo il pacco aperto (somma pesi<18000 in futuro flag chiuso)
ll_id_pacco=0
ll_id_pacco=f_trova_pacco_aperto(ldt_oggi)
if ll_id_pacco=0 or isnull(ll_id_pacco) then
	ls_num_pacco=f_trova_max_pacco(ldt_oggi)  //torna o il pacco o ""
	ls_num_pacco=f_incrementa_num_pacco(ls_num_pacco, ldt_oggi)
	ldt_dataora=datetime(ldt_oggi, now())
	ll_id_pacco=f_inserisci_pacco(ls_num_pacco, ldt_dataora)
end if
select max(numero) into :li_ultimo_numero
from dba.pacco_bollettina  where id_pacco=:ll_id_pacco;
if isnull(li_ultimo_numero) then li_ultimo_numero=0
li_ultimo_numero++
ldc_peso_pacco=f_trova_peso_pacco(ll_id_pacco)
//incremento il peso... se è + di 18kg chiudo e creo un altro pacco
ldc_peso_pacco+=adc_peso
if ldc_peso_pacco>= 18000 then
	insert dba.pacco_bollettina (id_pacco, id_bollettina, data_pacco, numero)
	values (:ll_id_pacco, :al_id_bollettina, :ldt_oggi, :li_ultimo_numero)
	;
	if sqlca.sqlNrows>0 then
		commit;
		update dba.pacco set chiuso='S' where id_pacco=:ll_id_pacco;
		if sqlca.sqlNrows>0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Pacco: "+ ls_num_pacco+" NON chiuso!")
		end if
	else
		rollback;
		messagebox("Attenzione!", "id_bollettina: "+string(ll_id_pacco) + " NON salvato!")
	end if
else
	insert dba.pacco_bollettina (id_pacco, id_bollettina, data_pacco, numero)
	values (:ll_id_pacco, :al_id_bollettina, :ldt_oggi, :li_ultimo_numero)
	;
	if sqlca.sqlNrows>0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "id_bollettina: "+string(al_id_bollettina) + " NON salvata!")
	end if
end if
dw_1.setitem(al_riga, "id_pacco", al_id_bollettina)



// integer i, li_len, li_ultimo_numero
// long ll_id_pacco
// date ldt_oggi, ldt_data_test
// string ls_numero
// datetime ldt_dataora
//s_pacco s_pacco_null   //is_dati_pacco
//
//ldt_oggi=today()
//if isnull(ii_riga_pacco) then ii_riga_pacco=0
//ii_riga_pacco++  //potevo prendere l'upperbound di is_dati_pacco ... vediamo in seguito
////trovo il pacco aperto (somma pesi<18000)
//ll_id_pacco=f_trova_pacco_aperto(ldt_oggi)
////idc_peso_pacco=f_trova_peso_pacco(ll_id_pacco)
//
//idc_peso_pacco+=adc_peso
//is_dati_pacco[ii_riga_pacco].s_peso= adc_peso
//is_dati_pacco[ii_riga_pacco].s_id_bollettina=al_id_bollettina
//
//
////incremento il peso... se è + di 18kg chiudo
//if idc_peso_pacco>= 18000 then
	//creo il pacco da chiudere (no l'ho già creato sopra)
	//prendo la data (forse più in là)
	//ldt_data_test=date(MID(is_num_pacco, 2, 8))
	//if ldt_data_test=ldt_oggi then
//	ls_num_pacco=f_incrementa_num_pacco(ls_num_pacco, ldt_oggi)
//	f_inserisci_pacco(ls_num_pacco)
		
	//... lo riempio con le righe bollettina
//	//creo il pacco da chiudere
//	//prendo la data
//	
//	ldt_dataora=datetime(today())
//	//cerco il numero massimo di pacco della giornata /settimana (in realtò cerco il num max assoluto, per ora)
//	select max(codice) into :is_num_pacco
//	from dba.pacco where left(codice,1)='A' ;
//	//ldt_data_test=date(MID(is_num_pacco, 2, 8))
//	//if ldt_data_test=ldt_oggi then
//	if is_num_pacco>"A" then
//		is_num_pacco=f_incrementa_num_pacco(is_num_pacco, ldt_oggi)
//	else
//		is_num_pacco=f_incrementa_num_pacco("", ldt_oggi)
//	end if
//	insert dba.pacco (codice, chiuso)
//	values (:is_num_pacco, 'S');
//	if sqlca.sqlNrows>0 then
//		commit;
//	else
//		rollback;
//		messagebox("Attenzione!", "Testa pacco NON salvata!")
//		return
//	end if
//	select id_pacco into :ll_id_pacco
//	from dba.pacco where codice = :is_num_pacco;
//	
//	//... lo riempio con le righe bollettina
//	select max(numero) into :li_ultimo_numero
//	from dba.pacco_bollettina pb, pacco p where data_pacco=:ldt_oggi;
//	if isnull(li_ultimo_numero) then li_ultimo_numero=0
//	for i= 1 to ii_riga_pacco
//		insert dba.pacco_bollettina (id_pacco, id_bollettina, data_pacco, numero)
//		values (:ll_id_pacco, :is_dati_pacco[i].s_id_bollettina, :ldt_oggi, :li_ultimo_numero+:i)
//		;
//		if sqlca.sqlNrows>0 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "id_bollettina: "+string(ll_id_pacco) + " NON salvato!")
//			
//		end if
//	next
//	//azzero i contatori
//	idc_peso_pacco=0
//	ii_riga_pacco=0
////	
//else
////f_cerca_pacco(
////	ii_righe_pacco++
//end if
////ii_righe_pacco++
////
////
end subroutine

public subroutine wf_ins_bol_in_pacco (long al_riga, long al_id_riga_bollettina);long ll_id_pacco=0, ll_riga_inserita
integer li_ret, li_ultimo_numero
date ldt_oggi
datetime ldt_dataora
decimal ldc_peso_bollettina
string ls_num_pacco, ls_cod_pacco,ls_num_bollettina
////trovo il pacco aperto (somma pesi<18000 in futuro flag chiuso)
ldt_oggi=dw_2.getitemdate(1, "spedizione")
ll_id_pacco=f_trova_pacco_aperto(ldt_oggi)
if ll_id_pacco=0 or isnull(ll_id_pacco) then
	ls_num_pacco=f_trova_max_pacco(ldt_oggi)  //ritorna o il pacco o ""
	ls_num_pacco=f_incrementa_num_pacco(ls_num_pacco, ldt_oggi)
	ldt_dataora=datetime(ldt_oggi, now())
	ll_id_pacco=f_inserisci_pacco(ls_num_pacco, ldt_dataora)
else
	select codice into :ls_num_pacco from dba.pacco where id_pacco=:ll_id_pacco;
end if
li_ret=dw_11.retrieve(ll_id_pacco)
if li_ret>0 then
	li_ultimo_numero=dw_11.getitemnumber(li_ret, "c_max_numero")
else
	li_ultimo_numero=1
END IF
ll_riga_inserita=dw_11.insertrow(0)
dw_11.setitem(ll_riga_inserita, "id_pacco", ll_id_pacco)
dw_11.setitem(ll_riga_inserita, "id_bollettina", al_id_riga_bollettina)
ls_num_bollettina=dw_1.getitemstring(al_riga, "documento_num_documento")
dw_11.setitem(ll_riga_inserita, "numero", li_ultimo_numero)
dw_11.setitem(ll_riga_inserita, "data_pacco", ldt_oggi)
dw_11.setitem(ll_riga_inserita, "pacco_codice", ls_num_pacco)
dw_11.setitem(ll_riga_inserita, "num_bollettina", ls_num_bollettina)
ls_cod_pacco=dw_11.getitemstring(ll_riga_inserita, "c_cod_pacco")
dw_1.setitem(al_riga, "c_cod_pacco", ls_cod_pacco)
dw_11.scrolltorow(ll_riga_inserita)


//select max(numero) into :li_ultimo_numero
//from dba.pacco_bollettina  where id_pacco=:ll_id_pacco;
//if isnull(li_ultimo_numero) then li_ultimo_numero=0
//li_ultimo_numero++
//ldc_peso_pacco=f_trova_peso_pacco(ll_id_pacco)
////incremento il peso... se è + di 18kg chiudo e creo un altro pacco
//ldc_peso_pacco+=adc_peso
//if ldc_peso_pacco>= 18000 then
//	insert dba.pacco_bollettina (id_pacco, id_bollettina, data_pacco, numero)
//	values (:ll_id_pacco, :al_id_bollettina, :ldt_oggi, :li_ultimo_numero)
//	;
//	if sqlca.sqlNrows>0 then
//		commit;
//		update dba.pacco set chiuso='S' where id_pacco=:ll_id_pacco;
//		if sqlca.sqlNrows>0 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "Pacco: "+ ls_num_pacco+" NON chiuso!")
//		end if
//	else
//		rollback;
//		messagebox("Attenzione!", "id_bollettina: "+string(ll_id_pacco) + " NON salvato!")
//	end if
//else
//	insert dba.pacco_bollettina (id_pacco, id_bollettina, data_pacco, numero)
//	values (:ll_id_pacco, :al_id_bollettina, :ldt_oggi, :li_ultimo_numero)
//	;
//	if sqlca.sqlNrows>0 then
//		commit;
//	else
//		rollback;
//		messagebox("Attenzione!", "id_bollettina: "+string(al_id_bollettina) + " NON salvata!")
//	end if
//end if
end subroutine

public function long wf_gia_in_pacco (long al_id_riga_bollettina);long ll_id_pacco

select id_pacco into :ll_id_pacco
from pacco_bollettina  where id_bollettina=:al_id_riga_bollettina;

return ll_id_pacco
end function

public subroutine wf_agg_peso_pacco (long al_riga, decimal adc_peso);long ll_riga_pacco, ll_id_bollettina, ll_riighe_pacco, ll_id_pacco
decimal ldc_peso_totale
ll_id_bollettina=dw_1.getitemnumber(al_riga, "id_riga_documento")

ll_riga_pacco=dw_11.find("id_bollettina="+string(ll_id_bollettina), 1, 1000000)

dw_11.setitem(ll_riga_pacco, "riga_documento_peso_netto", adc_peso)
ll_riighe_pacco=dw_11.rowcount()
ldc_peso_totale=dw_11.getitemdecimal(ll_riighe_pacco, "c_sum_peso")
if ldc_peso_totale>=18000 then
	ll_id_pacco=dw_11.getitemdecimal(ll_riighe_pacco, "id_pacco")
	wf_chiudi_pacco_new(ll_id_pacco)
end if
end subroutine

public subroutine wf_chiudi_pacco_new (long al_id_pacco);update dba.pacco
set chiuso='S' 
where id_pacco=:al_id_pacco;
if sqlca.sqlNrows>0 then
	commit;
else
	rollbacK;
	messagebox("Attenzione!", "Pacco NON chiuso!!! ("+string(al_id_pacco)+")")
end if
end subroutine

event open;call super::open;date ldt_da_data
datawindowchild dwc_profili
s_list_main s_list
long ll_id_prof

dw_2.settransobject(sqlca)
//dw_11.settransobject(sqlca)
integer rtncode , li_Index

rtncode = dw_2.GetChild('id_prof_doc', dwc_profili)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

// Establish the connection

CONNECT USING SQLCA;

// Set the transaction object for the child

dwc_profili.SetTransObject(SQLCA)

// Populate with values for eastern states
//se è aperto da "fare pronto cassaforte" allora il filtro è il num_registro=6 altrimenti num_reg=2
s_list=message.powerobjectparm
if s_list.s_win_parametri ='2' then //bollettine paolo  (correggi bollettine)
	dwc_profili.setfilter("(prof_documento_tipo_registro='GV' and mod_registro_numero=2) or (prof_documento_tipo_registro='GA' and mod_registro_numero=3)")
	ll_id_prof=65  //bol
elseif s_list.s_win_parametri ='6' then //fare pronto cassaforte
	dwc_profili.setfilter("prof_documento_tipo_registro='GV' and   mod_registro_numero =6")
	ll_id_prof=127 //vbol
	rb_13.trigger event clicked()
	rb_13.checked=true
	//titolo finestra lo cambio
	title="Pronto Cassaforte"
	
else
	dwc_profili.setfilter("prof_documento_tipo_registro='GV'" ) //and (mod_registro_numero=2 or mod_registro_numero=6) ")
	ll_id_prof=99  //sbol
end if
rtncode=dwc_profili.filter()

dwc_profili.Retrieve()

dw_2.insertrow(1)

dw_2.setitem(1, "id_prof_doc", ll_id_prof)


dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)
ldt_da_data=dw_2.getitemdate(1, "a_data")
ldt_da_data=relativedate(ldt_da_data, -120)
dw_2.setitem(1, "da_data", ldt_da_data)

dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)

dw_7.settransobject(sqlca)
dw_8.settransobject(sqlca)
dw_9.settransobject(sqlca)
dw_10.settransobject(sqlca)
dw_11.settransobject(sqlca)




end event

on w_correggi_bollettina_2.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_carica=create cb_carica
this.cb_salva=create cb_salva
this.cb_esci=create cb_esci
this.dw_3=create dw_3
this.cb_stampa=create cb_stampa
this.cbx_vedi=create cbx_vedi
this.cbx_bilancia=create cbx_bilancia
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cbx_sfrido=create cbx_sfrido
this.cbx_1=create cbx_1
this.rb_data=create rb_data
this.rb_barcode=create rb_barcode
this.dw_6=create dw_6
this.ole_1=create ole_1
this.cb_1=create cb_1
this.dw_8=create dw_8
this.dw_7=create dw_7
this.dw_9=create dw_9
this.cbx_vedi_pronto=create cbx_vedi_pronto
this.dw_10=create dw_10
this.sle_messaggio=create sle_messaggio
this.rb_13=create rb_13
this.rb_pacchi=create rb_pacchi
this.sle_1=create sle_1
this.st_2=create st_2
this.cbx_no_reset=create cbx_no_reset
this.rb_bar_2020=create rb_bar_2020
this.cb_rnl=create cb_rnl
this.dw_11=create dw_11
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_carica
this.Control[iCurrent+4]=this.cb_salva
this.Control[iCurrent+5]=this.cb_esci
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.cb_stampa
this.Control[iCurrent+8]=this.cbx_vedi
this.Control[iCurrent+9]=this.cbx_bilancia
this.Control[iCurrent+10]=this.dw_4
this.Control[iCurrent+11]=this.dw_5
this.Control[iCurrent+12]=this.cbx_sfrido
this.Control[iCurrent+13]=this.cbx_1
this.Control[iCurrent+14]=this.rb_data
this.Control[iCurrent+15]=this.rb_barcode
this.Control[iCurrent+16]=this.dw_6
this.Control[iCurrent+17]=this.ole_1
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.dw_8
this.Control[iCurrent+20]=this.dw_7
this.Control[iCurrent+21]=this.dw_9
this.Control[iCurrent+22]=this.cbx_vedi_pronto
this.Control[iCurrent+23]=this.dw_10
this.Control[iCurrent+24]=this.sle_messaggio
this.Control[iCurrent+25]=this.rb_13
this.Control[iCurrent+26]=this.rb_pacchi
this.Control[iCurrent+27]=this.sle_1
this.Control[iCurrent+28]=this.st_2
this.Control[iCurrent+29]=this.cbx_no_reset
this.Control[iCurrent+30]=this.rb_bar_2020
this.Control[iCurrent+31]=this.cb_rnl
this.Control[iCurrent+32]=this.dw_11
end on

on w_correggi_bollettina_2.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_carica)
destroy(this.cb_salva)
destroy(this.cb_esci)
destroy(this.dw_3)
destroy(this.cb_stampa)
destroy(this.cbx_vedi)
destroy(this.cbx_bilancia)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cbx_sfrido)
destroy(this.cbx_1)
destroy(this.rb_data)
destroy(this.rb_barcode)
destroy(this.dw_6)
destroy(this.ole_1)
destroy(this.cb_1)
destroy(this.dw_8)
destroy(this.dw_7)
destroy(this.dw_9)
destroy(this.cbx_vedi_pronto)
destroy(this.dw_10)
destroy(this.sle_messaggio)
destroy(this.rb_13)
destroy(this.rb_pacchi)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.cbx_no_reset)
destroy(this.rb_bar_2020)
destroy(this.cb_rnl)
destroy(this.dw_11)
end on

event resize;call super::resize;
	dw_1.height= newheight - 350

dw_1.width= newwidth - 80

end event

type st_1 from w_001`st_1 within w_correggi_bollettina_2
end type

type dw_1 from udw_base within w_correggi_bollettina_2
integer y = 384
integer width = 4672
integer height = 1100
boolean bringtotop = true
string dataobject = "d_correggi_s_bollettina"
end type

event itemchanged;call super::itemchanged;decimal{2} ld_fino, ld_coef_calo, ldc_peso, ld_calo, ldc_tara,ldc_grammi, ldc_test
long ll_id_titolo, ll_id_art,ll_id_uc, ll_id_riga_bollettina
integer li_ret
decimal ldc_ordine,ldc_prezzo_complessivo,ldc_qta, ldc_non_prezioso, ldc_prezzo, ldc_peso_unitario, ldc_tara_precedente
string ls_descrizione, ls_des_originale, ls_bilancia, ls_pacco_scelto
long ll_id, ll_pos, ll_id_pacco,ll_id_prof
date ldt_data
datetime ldt_data_modifica
boolean lb_NO_lacci=false
long    ll_id_variazione //20230719 per controllo scheda tecnica
string ls_test

if row>0 then
	choose case string(dwo.name)
		case "ordinato_fo"
			ldt_data_modifica=datetime(today(), now())
			post setitem(row, "riga_doc_estensione_data_ora_modifica", ldt_data_modifica)	
			cb_salva.post event clicked() 
		case "quantita", "peso_netto"
			
			post setitem(row, "ordinato_fo", "S")
			ldt_data_modifica=datetime(today(), now())
			post setitem(row, "riga_doc_estensione_data_ora_modifica", ldt_data_modifica)
			if isnull(getitemnumber(row, "provv_subage_2")) or getitemnumber(row, "provv_subage_2")<=0  then
				ls_bilancia = ProfileString ( "cometa.ini", "PC", "Bilancia", "Error!" )
				ldc_ordine=getitemdecimal(row, "c_ordine")
				if ls_bilancia="mettler" then
					if ldc_ordine < 9 then
						ldc_ordine+=9
					end if
				else
					ldc_ordine=getitemdecimal(row, "c_ordine")
				end if
				post setitem(row, "provv_subage_2", ldc_ordine)
			end if
			ll_id_art=getitemnumber(row, "id_articolo")
			if string(dwo.name)='peso_netto' then
			
				ldc_peso=dec(data)	
				//gestione tara lacci e filo
				if ib_no_lordo then
					setitem(row, "c_peso_lordo", ldc_peso)
				else
					ib_no_lordo=true
				end if
				//gestione tara fine
	
				//ad_peso=ad_peso - ld_peso_non_prezioso
				select id_titolo
				into :ll_id_titolo
				from articolo
				where id_articolo=:ll_id_art
				;
				ldc_non_prezioso=getitemnumber(row, "peso_non_prezioso")
				if isnull(ldc_non_prezioso) then ldc_non_prezioso=0 
					
				ld_fino=f_converti_in_fino(ldc_peso - ldc_non_prezioso, ll_id_titolo)
				li_ret=dw_1.setitem(row, "fino", ld_fino)
				if li_ret<>1 then messagebox("Errore!", "Fino non settato")
				ld_coef_calo=dw_1.getitemdecimal(row, "coef_calo")
				if ld_coef_calo>0 and not isnull(ld_coef_calo) then
						ld_calo=f_round((ldc_peso - ldc_non_prezioso)*(ld_coef_calo)/1000, -2, 'M')
						ld_calo= f_round(ld_calo - ld_fino, -2, 'M')
						li_ret=dw_1.setitem(row, "calo",ld_calo) 
						if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
				elseif ld_coef_calo=0 then 
					li_ret=dw_1.setitem(row, "calo",0)
					if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
				else
		
				end if
			//20230719 controllo su silver_prezzi_excel (prezzo) che sia spuntato il flag "scheda tecnica", altrimenti segnallo!!! S
		
				ll_id_uc=getitemnumber(row, "id_unita_confezione")
				ll_id_variazione=15
				select scheda_tecnica into :ls_test from dba.prezzo where id_unita_confezione=:ll_id_uc and id_variazione=:ll_id_variazione;
				if ls_test> "" and ls_test= "S" then
					ll_id_art=getitemnumber(li_ret, "id_articolo")
					messagebox("Attenzione!!", "Per l'articolo con ID= "+string(ll_id_art)+" DEVI VERIFICARE LA SCHEDA TECNICA!!!")
				end if
				//20230719 fine
				
			else
				//18-02-11 è stata modificata la qta
				//RICALCOLO IL PESO NON PREZIOSO
				ldc_qta=dec(data)
				ll_id_uc=getitemnumber(row, "id_unita_confezione")
				WF_PESO_NON_PREZIOSO(ROW, ldc_qta, ll_id_uc)
								
				//non so quanto sia giusto, ma sull'onda del momento ....
				//ricalcolo il tot riga: se fosse un articolo mosso a grammi sarebbe erratissimo ....
	//			ldc_prezzo_complessivo=getitemdecimal(row, "prezzo_complessivo")
	//			setitem(row, "tot_riga_val_az", dec(data)*ldc_prezzo_complessivo)
			end if
			
			//qui sotto devo fare sempre la stessa cosa: ricalcolare il peos netoto in base al lordo memorizza in c_pesO_lordo e i valori dei campi indicati (rame lacci tara)
		case "peso_lordo_tara","riga_documento_provv_imp_carea_2", "provv_imp_agente_2" //questo è il campo numero lacci che pesano ognuno 0.47
			//secondo me dovrebbe essere così: prima recupera il vecchio valore della tara o del "laccio" (riga_documento_provv_imp_carea_2*0.47)
			//poi lo somma al peso attuale quindi, solo allora, toglie la tara o il peso del laccio dal peso netto!!!!
			//però ha funzionato così per anni ..... 18-09-2017
			//se modifica tara devo modificare peso netto (grammi)
			ldc_tara=dec(data)
			if dwo.name="peso_lordo_tara" then
				
				ldc_tara_precedente=getitemdecimal(row, "peso_lordo_tara")
				if isnull(ldc_tara_precedente) then ldc_tara_precedente=0
				ldc_tara=ldc_tara - ldc_tara_precedente
				//Samy vuole che se c'è la tara la des riga doc prenda anche "incartato/imbustato"
				post wf_incartato_imbustato(row, ldc_tara)
			end if
			//gestione lacci
			if dwo.name="riga_documento_provv_imp_carea_2" then  //peso_lacci
				//ldc_test=getitemdecimal(row, "riga_documento_provv_imp_carea_2")
				//if ldc_test=0 or isnull(ldc_test) then
				//20231124 se è pronto cassaforte (id_prof_127) NON ci sono lacci
				ll_id_prof=dw_2.getitemnumber(1, "id_prof_doc")
				if parent.title<>"Pronto Cassaforte" and ll_id_prof<>127 then
					ldc_peso_unitario=dw_1.getitemdecimal(row, "c_peso_laccio")
				
//					select peso_laccio
//					into :ldc_peso_unitario
//					from dba.orafo_par_sistema
//					;
					if isnull(ldc_peso_unitario) or ldc_peso_unitario=0 then ldc_peso_unitario=0.47 //0.47 è il peso di un laccio 22092017
					ldc_tara*=ldc_peso_unitario  
					ldc_tara_precedente=getitemdecimal(row, "riga_documento_provv_imp_carea_2")
					if isnull(ldc_tara_precedente) then ldc_tara_precedente=0
					ldc_tara_precedente*=ldc_peso_unitario
					//if ldc_tara_precedente>5 then
						ldc_tara=ldc_tara - ldc_tara_precedente
				end if	
					//end if
					//if ldc_tara< 5 then lb_NO_lacci=true
				//else
				//	messagebox("Attenzione!", "Il numero dei lacci e dei fili di rame funziona SOLO la prima volta: se si ripassa sopra ad un valore già immesso, il peso netto non sarà corretto")
				//end if
			end if
			//gestione filo rame
			if dwo.name="provv_imp_agente_2" then //peso_filo rame
				//ldc_test=getitemdecimal(row, "provv_imp_agente_2")
				//if ldc_test=0 or isnull(ldc_test) then
			
				ldc_peso_unitario=dw_1.getitemdecimal(row, "c_peso_filo_rame")
				
//					select peso_filo_rame
//					into :ldc_peso_unitario
//					from dba.orafo_par_sistema
//					;
					if isnull(ldc_peso_unitario) or ldc_peso_unitario=0 then ldc_peso_unitario=0.14 //0.14 è il peso di un filo rame
					ldc_tara*=ldc_peso_unitario
					ldc_tara_precedente=getitemdecimal(row, "provv_imp_agente_2")
					if isnull(ldc_tara_precedente) then ldc_tara_precedente=0
					ldc_tara_precedente*=ldc_peso_unitario
					if ldc_tara_precedente>0 then
						ldc_tara=ldc_tara - ldc_tara_precedente
					end if
				//else
					//messagebox("Attenzione!", "Il numero dei lacci e dei fili di rame funziona SOLO la prima volta: se si ripassa sopra ad un valore già immesso, il peso netto non sarà corretto!")
				//end if
			end if
			
			ldc_peso= getitemdecimal(row, "peso_netto")
			if lb_NO_lacci then //è < di 5 gr non lo tolgo al peso lo lascio e basta
				if ldc_tara_precedente>=5 then
					setitem(row, "peso_netto", ldc_peso + ldc_tara_precedente) 
					ib_no_lordo=false
					post event itemchanged(row, object.peso_netto, string(ldc_peso + ldc_tara_precedente))	
				end if
			else
				if ldc_peso>ldc_tara  then
					setitem(row, "peso_netto", ldc_peso - ldc_tara) 
					ib_no_lordo=false
					post event itemchanged(row, object.peso_netto, string(ldc_peso - ldc_tara))				
				else
					messagebox("Attenzione!", "Tara maggiore del peso!")
					return 2
				end if
			end if
		
		case "id_gruppo_agenti_2"  //galvanica
			ll_id=long(data)
			//cambiato il 03/10/2019
			select descrizione
			into  :ls_descrizione
			from dba.galvanica
			where id_galvanica=:ll_id;
			//nuovo inserito 03/10/19
			ldt_data=dw_1.getitemdate(row, "documento_data_documento")
			ldc_prezzo=f_rec_prezzo_galvanica(ldt_data, ll_id)
			
			setitem(row, "prezzo_metallo", ldc_prezzo)
			ls_des_originale=getitemstring(row, "riga_documento_descrizione")
			ll_pos=pos(ls_des_originale, "__")
			if ll_pos>0 then
				ls_des_originale=left(ls_des_originale, ll_pos - 1)
			end if
			setitem(row, "riga_documento_descrizione", ls_des_originale +" __ "+ ls_descrizione)
		case "c_scelto"
			setitem(row, "ordinato_fo", "S")
			ldt_data_modifica=datetime(today(), now())
			setitem(row, "riga_doc_estensione_data_ora_modifica", ldt_data_modifica)
			cb_salva.postevent(clicked!)
			if rowcount()>row then
				post scrolltorow(row+1)
				post setcolumn("quantita")
			end if

//			ldt_data=today()
//			ls_pacco_scelto="80"+data
//			select id_pacco
//			into :ll_id_pacco
//			from dba.pacco
//			where left(codice, 3)=:ls_pacco_scelto
//			and date(dataora)>= :ldt_data
//			and (chiuso='N' or chiuso=null)
//			;
//			if ll_id_pacco>0 then
//				
//			
//				ldc_grammi=getitemdecimal(row, "peso_netto")
//				select sum(r.peso_netto)
//				into :ldc_peso
//				from riga_documento r, pacco_bollettina p, pacco pa
//				where r.id_riga_documento=p.id_bollettina
//				and p.id_pacco=:ll_id_pacco
//				and p.id_pacco=pa.id_pacco
//				and (pa.chiuso='N' or pa.chiuso=null)
//				;
//				
//				if isnull(ldc_peso) then ldc_peso=0
//				ldc_grammi+=ldc_peso
//				if ldc_grammi> 15000 then
//					messagebox("Attenzione!", "Peso del pacco scelto compresa questa riga è di gr. "+string(ldc_grammi))
//				end if
//			else
//				messagebox("Attenzione!", "Pacco "+data+" NON trovato")
//			end if
	end choose
end if		
		
end event

event itemfocuschanged;call super::itemfocuschanged;dwobject my_dwo
string data, ls_metallo, ls_data_object
decimal ldc_peso,ldc_null
setnull(ldc_null)
w_bilancia w_bil
long ll_id_articolo

//per sara 30112017
ls_data_object=dw_1.dataobject
if is_ultimo_campo='quantita' and rb_pacchi.checked and ls_data_object<> "d_correggi_cod_barre_s_bol_2020" then
	post setfocus(dw_6)
	dw_6.post setcolumn("cod_barre")
elseif ls_data_object<> "d_correggi_cod_barre_s_bol_2020" then //20200910 Samy chiedeun'altra dw per inserire un modo diverso di dataentry: dopo pezzi non salva e va su cod_barre ma salva con ctrl+"+" vedi ue_key
	
end if

if dwo.name='peso_netto' and is_ultimo_campo='quantita' and cbx_bilancia.checked then
	
	open(w_bil)
	ldc_peso=w_bil.f_rendi_peso()
//	data=wf_bilancia()
	my_dwo = this.object.peso_netto
//	ldc_peso=dec(data)
	//arrotondo 040612 al primo decimale richiesta samy
	
	if ldc_peso>0 then
		ll_id_articolo=dw_1.getitemnumber(row, "id_articolo")
		select m.codice
		into :ls_metallo
		from articolo a, orafo_titolo t, orafo_metallo m
		where a.id_titolo=t.id_titolo and t.id_metallo=m.id_metallo
		and a.id_articolo=:ll_id_articolo
		;
		if ls_metallo<>"AU" then
			if u_freddie.s_utenti.i_idutente =39 OR u_freddie.s_utenti.i_idutente =46  then //secondo Samy deve arrontondare sempre per eccesso a meno che non sia Elisa (39) 18-20 luglio2 2018
				ldc_peso=round(ldc_peso, 1) 
			else
	//				ldc_peso=ceiling(ldc_peso) //20230227 Samy dice basta arrotondamento, ritorno ai 2 decimali
				ldc_peso=round(ldc_peso, 2)
			end if
		end if
		data=string(ldc_peso)
		setitem(row, "peso_netto", ldc_peso)
		this.trigger event itemchanged(row, my_dwo, data)
		setitem(row, "riga_doc_estensione_data_ora_modifica", today())
		post setcolumn("peso_lordo_tara")
		if ldc_peso<1 then
			messagebox("ATTENZIONE!", "Il peso è inferiore ad 1 grammo!")
			setitem(row, "peso_netto", ldc_null)
			
		end if
	end if
	close(w_bil)

end if
choose case string(dwo.name)
	case	"peso_lordo_tara"
		if getitemdecimal(row, "peso_lordo_tara")=0 then
			setitem(row, "peso_lordo_tara", ldc_null)
		end if

end choose
//if is_ultimo_campo="peso_lordo_tara"  then
//	accepttext()
//	cb_salva.postevent(clicked!)
//	if rowcount()>row then
//		post scrolltorow(row+1)
//		post setcolumn("quantita")
//	end if
//end if


is_ultimo_campo=dwo.name


end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow>0 and rb_bar_2020.checked=false then
	
	is_ultimo_campo="peso_netto"
	post wf_set_col("quantita")
	
	post wf_salva_riga(currentrow)
end if
end event

event doubleclicked;call super::doubleclicked;long ll_id_doc,  ll_id_riga
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list


if row>0 and dwo.name <> "c_scelto" and   dwo.name <> "peso_lordo_tara" then
	ll_id_doc=getitemnumber(row, "id_documento")
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
end if


if  dwo.name ="peso_lordo_tara" then
	ll_id_riga=dw_1.getitemnumber(row, "id_riga_documento")
	openwithparm(w_tara_dettaglio, ll_id_riga)
end if


end event

event updatestart;call super::updatestart;integer i
LONG LL_ID_RIGA



for i= 1 to upperbound(ldc_val_pz_originali)
	setnull(ldc_val_pz_originali[i])
next

for i=1 to dw_1.rowcount()
	LL_ID_RIGA=DW_1.GETITEMNUMBER(I, "ID_RIGA_DOCUMENTO")
	SELECT QUANTITA
	INTO :ldc_val_pz_originali[i]
	FROM DBA.RIGA_DOCUMENTO
	WHERE ID_RIGA_DOCUMENTO= :LL_ID_RIGA
	;
	
next


end event

event retrievestart;call super::retrievestart;if is_no_reset='S' then
	return 2
end if
end event

event rbuttondown;call super::rbuttondown;decimal{2} ldc_peso
if dwo.name="peso_netto" then
	open(w_peso_multiplo)
	if isvalid(message) then
		ldc_peso=message.doubleparm
		setitem(row, "peso_netto", ldc_peso)
	end if		
end if
end event

event ue_key;call super::ue_key;string ls_dataobject

if key=KeyAdd!  and keyflags=2  then
	ls_dataobject=dw_1.dataobject
	if ls_dataobject="d_correggi_cod_barre_s_bol_2020" then
//	messagebox ("W", "W")

		cb_salva.triggerevent(clicked!)
		dw_6.setfocus()
	end if
end if
end event

event updateend;call super::updateend;long ll_id_riga_bollettina
decimal ldc_peso

if rowsinserted+rowsupdated+rowsdeleted>0 then
	//gestione pacchi 20220711 passo anche la bollettina
	if getrow()>0 then
		ll_id_riga_bollettina=getitemnumber(getrow(), "id_riga_documento")
		ldc_peso=getitemdecimal(getrow(), "peso_netto")
		//wf_chiudi_pacco(1, ldc_peso, ll_id_riga_bollettina)
		if rb_bar_2020.checked then dw_11.trigger event ue_update()
		wf_agg_peso_pacco(getrow(), ldc_peso )
	end if
end if

end event

type dw_2 from udw_base within w_correggi_bollettina_2
integer x = 969
integer y = 28
integer width = 2025
integer height = 212
boolean bringtotop = true
string dataobject = "d_correggi_bol_selezione"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_carica from commandbutton within w_correggi_bollettina_2
integer x = 955
integer y = 252
integer width = 192
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica"
end type

event clicked;date ldt_da_data, ldt_a_data
long ll_id_prof, ll_id_sog

dw_2.accepttext()
ll_id_prof=dw_2.getitemnumber(1, "id_prof_doc")
ldt_da_data=dw_2.getitemdate(1, "da_data")
ldt_a_data=dw_2.getitemdate(1, "a_data")
ll_id_sog=dw_2.getitemnumber(1, "id_soggetto")

if dw_1.rowcount()>0 then
	if messagebox("Attenzione!", "Vuoi salvare le modifiche prime di caricare i nuovi dati?", stopsign!, yesno!)=1 then
		if dw_1.trigger event ue_update()=1 then
			messagebox("OK!", "Salvataggio eseguito con successo!")
		end if
	end if
end if
dw_1.setfilter("")
dw_1.filter()
dw_1.reset()

dw_1.retrieve(ll_id_prof, ldt_da_data, ldt_a_data, ll_id_sog)
cbx_vedi.checked=false
//cbx_vedi.thirdstate=true
cbx_vedi.triggerevent(clicked!)
dw_1.setsort("num_progressivo, documento_data_documento, documento_num_documento")
dw_1.sort()

end event

type cb_salva from commandbutton within w_correggi_bollettina_2
integer x = 1166
integer y = 252
integer width = 178
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer i, li_righe_comp, a, ldc_qta_distinta,  li_num_riga[]
long LL_ID_RIGA, ll_id_art, ll_id_art_comp, ll_id_doc, ll_id_art_trovati[]
decimal ldc_peso, ldc_peso_distinta, ldc_coef_calo, ldc_perc_sfrido, ldc_qta
integer e
long ll_id_doc_sfrido, ll_id_caus, ll_id_locazione, ll_id_valuta
long ll_id_prof, ll_id_registro, ll_id_mod_registro, ll_num_prog,ll_id_pacco
string ls_sfrido, ls_messaggio, ls_ordinato
datetime ldt_data_modifica
decimal ldc_coef_var, ldc_tara,ldc_tara_np, ldc_peso_test

ls_sfrido=cbx_sfrido.text

for i=1 to dw_1.rowcount()
	ldc_peso_test=dw_1.getitemdecimal(i, "peso_netto")
	ls_ordinato=dw_1.getitemstring(i, "ordinato_fo")
	if ls_ordinato='S' then
		if isnull(ldc_peso_test) or ldc_peso_test=0 then
			if	messagebox("Attenzione!", "Riga n."+string(i)+" con peso uguale a 0! Salvo lo stesso?",&
				 Question!, yesno!)<>1 then
				 ls_messaggio="Salvataggio Annullato dall'Utente!"
				 sle_messaggio.text=ls_messaggio
				return
			end if
		END IF
	else
		if ldc_peso_test>0 then
			messagebox("Attenzione!", "Riga n."+string(i)+" con peso <> 0 e NON segnata come bollettina lavorata!")
		end if
	end if
next
dw_1.setfilter("ordinato_fo ='S'")
dw_1.filter()


select id_profilo_sfrido, perc_sfrido
into :ll_id_prof, :ldc_perc_sfrido
from dba.orafo_par_sistema
;

select id_mod_registro_prop, id_valuta_prop, id_locazione_1_prop, 
	id_caus_magazzino_prop
into :ll_id_mod_registro,:ll_id_valuta, :ll_id_locazione, :ll_id_caus
from dba.prof_documento
where id_prof_documento=:ll_id_prof
;
select id_registro
into :ll_id_registro
from esercizio e, registro r
where r.id_mod_registro=:ll_id_mod_registro
and e.data_inizio<=today()
and e.data_fine>=today()
;
if ls_sfrido='S' then
	ll_id_doc_sfrido=wf_CREA_DOC_SFRIDO(ll_id_registro,ll_id_prof, ll_id_valuta, &
	ll_id_locazione, ll_id_caus )
end if
//if ll_id_doc_sfrido>0 then	
// prima di salvare prendo il valore originale dei pz per trovare il coef di variazione
// utile per calcolare il peso dei componenti più in giù (pz variati/pz originali=coef_variazione)
//lo faccio in un vettore var d'istanza e sull'updatestart

if dw_1.dataobject="d_correggi_s_bollettina"  or dw_1.dataobject="d_correggi_cod_barre_s_bollettina" then 
	wf_impacchetta()
end if

if dw_1.trigger event ue_update()=1 then
	for i=1 TO dw_1.rowcount()
		ll_id_doc=dw_1.getitemnumber(i, "id_documento")
		update dba.documento
		set ordinato_fo='S'
		where id_documento=:ll_id_doc
		;
		if sqlca.sqlnrows>0 then
			commit;
		else
			rollback;
			messagebox("Ahi!", "Salvataggio per segnare doc "+string(ll_id_doc)+" NON riuscito")
		end if
		LL_ID_RIGA=dw_1.getitemnumber(i, "id_riga_documento")
		ldt_data_modifica=dw_1.getitemdatetime(i, "riga_doc_estensione_data_ora_modifica")
		
		
		if isnull(ldt_data_modifica) then ldt_data_modifica=datetime(today(), now())
		ll_id_pacco=dw_1.getitemnumber(i, "id_pacco")
		
		insert into dba.riga_doc_estensione
		(id_riga_documento, data_ora_modifica, qta_originale, id_pacco)
		values (:ll_id_riga, :ldt_data_modifica, :ldc_val_pz_originali[i], :ll_id_pacco)
		;
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			ldt_data_modifica=datetime(today(), now())
			update dba.riga_doc_estensione
			set data_ora_modifica=:ldt_data_modifica, id_pacco=:ll_id_pacco
			where id_riga_documento=:ll_id_riga
			;
		if sqlca.sqlnrows>0 then
			commit;
		else
			rollback;
			messagebox("Ahi!", "Fallito insert e update !!! Data ora modifica non salvata!")
		end if	
		end if
		
		
		
		ll_id_art=dw_1.getitemnumber(i, "id_articolo")
		ldc_qta=dw_1.getitemdecimal(i, "quantita")
		//prendo la tara (campo peso_lordo)151110 no I FIGLI NON DEVONO AVERE LA TARA!!!! 301110
		///ldc_tara=dw_1.getitemnumber(i, "peso_lordo_tara")
		//E PRENDO IL PESO NON PREZIOSO USATO COME SECONDA TARA 181110  no I FIGLI NON DEVONO AVERE LA TARA!!!! 301110
		///ldc_tara_np=dw_1.getitemnumber(i, "peso_non_prezioso")
		//trovo coef_variazione del padre per riportarlo sui figli
		if ldc_val_pz_originali[i]>0 then
			ldc_coef_var=ldc_qta/ldc_val_pz_originali[i]
		else
			ll_num_prog=dw_1.getitemnumber(i, "num_progressivo")
			Messagebox("Attenzione!", "Verificare doc. n.prog.:"+string(ll_num_prog)+" - Potrebbe avere pezzi=0!")
			ldc_coef_var=1
		end if
		ldc_coef_calo=dw_1.getitemdecimal(i, "coef_calo")
		//faccio il retrieve per id_art_padre e trovo le righe dei componenti
		li_righe_comp=DW_3.RETRIEVE(LL_ID_RIGA)
		li_num_riga[1]=0
		for a= 1 to li_righe_comp
			//aggiorno i componenti figli esplosi adeguatemente al ritocco della qta padre
			ll_id_art_comp=dw_3.getitemnumber(a, "id_articolo")
			//se trovo tutto in distinta bene
			ldc_qta_distinta=0
			ldc_peso_distinta=0
			select quantita, r.peso_netto, num_riga
			into :ldc_qta_distinta, :ldc_peso_distinta, :li_num_riga[a+1]
			from dba.riga_distinta r, distinta d
			where r.id_articolo= :ll_id_art_comp
			and d.id_articolo=:ll_id_art
			and d.id_distinta=r.id_distinta
			and r.num_riga > :li_num_riga[a]
			;
			if ldc_qta_distinta <=0 then
			//non c'è il componente nella distinta: Samy cambia a volte nella bollettina
			//il componente (altrimenti dovrebbe fare tanti articoli quanti le varianti
			//in questo caso il numero dei pezzi=pz originale*coef_variazione e il peso lo prendo
			//dall'articolo componente
				select peso_netto
				into :ldc_peso_distinta
				from dba.articolo a, unita_confezione u
				where a.id_articolo= :ll_id_art_comp
				and u.unita_base='S'
				and u.id_articolo=a.id_articolo;
				ldc_qta_distinta=dw_3.getitemdecimal(a, "quantita")
				ldc_qta_distinta=ldc_qta_distinta*ldc_coef_var
				
				dw_3.setitem(a, "quantita", ldc_qta_distinta)	
				dw_3.setitem(a, "qta_un_base", ldc_qta_distinta)
				dw_3.setitem(a, "peso_netto", ldc_qta_distinta*ldc_peso_distinta)
			else
				dw_3.setitem(a, "quantita", ldc_qta*ldc_qta_distinta)	
				dw_3.setitem(a, "qta_un_base", ldc_qta*ldc_qta_distinta)
				//silver 230810
			//	dw_3.setitem(a, "peso_netto", ldc_qta*ldc_qta_distinta*ldc_peso_distinta)
				//errore: se in distinta non c'è la qta allora il peso-distinta=al peso dell'articolo
				//singolo altrimenti (questo è il caso) il peso distinta è il peso totale dei pezzi
				//di ques'articolo contenuti in distinta (es: comp01 pz in distinta 20 peso 20 gr 
				//1 pz = 1 gr)
				dw_3.setitem(a, "peso_netto", ldc_qta*ldc_peso_distinta)
			end if
				//aggiungo il peso_lordo (che poi è la tara: silver 151110) NO!!!! 301110
				//dw_3.setitem(a, "peso_lordo", ldc_tara)
				//aggiungo il peso non prezioso (che poi è una secodna tara (la prima per le buste di plastica
				//questa per oggetti non preziosi che compongono l'articolo (es: monete, cuoio ecc...)
			//	dw_3.setitem(a, "peso_non_prezioso", ldc_tara_np)	301110
				//qui raccolgo i dati per lo sfrido
			if ls_sfrido='S' then
				wf_crea_riga_sfrido(ll_id_doc_sfrido, ldc_qta*ldc_peso_distinta*ldc_perc_sfrido/100, ldc_qta*ldc_perc_sfrido/100, ldc_coef_calo, &
					ll_id_art_comp, ll_id_caus, ll_id_locazione, ll_id_riga, ll_id_valuta, &
					ll_id_doc, ll_id_art)
			end if
		next
		if dw_3.trigger event ue_update()<> 1 then
			messagebox("Ahi!", "Salvataggio dw_3 NON riuscito!")
		end if
	next
	
//		if dw_1.getrow()>0 then
//			ll_num_prog=dw_1.getitemnumber(dw_1.getrow(), "num_progressivo")
//			ls_messaggio="Salvataggio prog. "+string(ll_num_prog)+" eseguito con Successo!"
//		else
		ls_messaggio="Salvataggio Eseguito con Successo!"
//		end if
	sle_messaggio.text=ls_messaggio
	//messagebox("OK!", "Salvataggio Eseguito con Successo!")
else
	messagebox("Ahi!", "Salvataggio NON riuscito!")
end if

//22-03-2016 Paolo chiede che appena salvata la bollettina sparisca e il cursore torni su cod barre
if rb_pacchi.checked or  rb_bar_2020.checked then
	if cbx_no_reset.checked=false then
		dw_1.post reset()
		dw_6.post setfocus()		
	end if
end if
//end 22-03-2016
dw_1.setfilter("")
dw_1.filter()
cbx_vedi.text="Tutti"
cbx_vedi.checked=false
//else
	//messagebox("Ahi!", "Documento di sfrido non creato! Bloccato Tutto!")
//end if
end event

type cb_esci from commandbutton within w_correggi_bollettina_2
integer x = 2299
integer y = 252
integer width = 169
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Esci"
end type

event clicked;if messagebox("Attenzione!", "Vuoi salvare le modifiche?", stopsign!, yesno!)=1 then
	cb_salva.triggerevent(clicked!)
end if

close(parent)
end event

type dw_3 from udw_base within w_correggi_bollettina_2
integer x = 37
integer y = 28
integer width = 914
integer height = 332
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_correggi_componenti_bol_2"
boolean hscrollbar = true
end type

type cb_stampa from commandbutton within w_correggi_bollettina_2
integer x = 2066
integer y = 252
integer width = 206
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;integer li_ret
//controllo se ogni riga ha un peso espresso, altrimenti lo notifico 200313 Paolo Samy
li_ret=wf_controlla_peso()
if li_ret>0 then
	dw_1.setfilter("ordinato_fo ='S'")
	dw_1.filter()
	dw_1.setsort("provv_subage_2")
	dw_1.sort()
	printsetup()
	dw_1.modify("riga_doc_estensione_data_ora_modifica.visible=0")
	dw_1.modify("c_scelto.visible=0")
	dw_1.modify("id_pacco.visible=0")
	dw_1.modify("c_peso_unitario.visible=1")
	dw_1.modify("dim_l.visible=1")
	dw_1.modify("t_peso_unitario.visible=1")
	dw_1.modify("t_dim_l.visible=1")
	dw_1.modify("c_des_con_lavorazioni.width=800")
	dw_1.print()

	wf_crea_pdf()
	dw_1.modify("riga_doc_estensione_data_ora_modifica.visible=1")
	dw_1.modify("c_peso_unitario.visible=0")
	dw_1.modify("dim_l.visible=0")
	dw_1.modify("t_peso_unitario.visible=0")
	dw_1.modify("t_dim_l.visible=0")
	dw_1.modify("c_scelto.visible=1")
	dw_1.modify("id_pacco.visible=1")
	dw_1.modify("c_des_con_lavorazioni.width=1083")
	dw_1.setfilter("")
	dw_1.filter()
end if
end event

type cbx_vedi from checkbox within w_correggi_bollettina_2
integer x = 1376
integer y = 244
integer width = 480
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Modificati"
boolean threestate = true
end type

event clicked;If checked then
	if thirdstate then
		dw_1.setfilter("ordinato_fo<>'S' or isnull(ordinato_fo)")
		cbx_vedi.text="Solo NON Modificati"
	else
		dw_1.setfilter("ordinato_fo='S'")
		cbx_vedi.text="Solo Modificati"
	end if


else
	cbx_vedi.text="Tutti"
		dw_1.setfilter("")
end if
dw_1.filter()
end event

type cbx_bilancia from checkbox within w_correggi_bollettina_2
integer x = 1792
integer y = 240
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Bilancia"
boolean checked = true
end type

type dw_4 from udw_base within w_correggi_bollettina_2
boolean visible = false
integer x = 32
integer y = 1548
integer width = 1495
integer height = 244
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_crea_doc_sfrido"
boolean hscrollbar = true
boolean vscrollbar = false
end type

type dw_5 from udw_base within w_correggi_bollettina_2
boolean visible = false
integer x = 32
integer y = 1788
integer width = 1504
integer height = 612
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_crea_riga_sfrido"
boolean hscrollbar = true
boolean vscrollbar = false
end type

type cbx_sfrido from checkbox within w_correggi_bollettina_2
integer x = 1792
integer y = 304
integer width = 265
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sfrido"
end type

type cbx_1 from checkbox within w_correggi_bollettina_2
integer x = 1376
integer y = 308
integer width = 398
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Tara NP"
end type

event clicked;if checked then
	dw_1.modify("peso_non_prezioso.visible=1")
	dw_1.modify("peso_non_prezioso.x=1913")
else
	dw_1.modify("peso_non_prezioso.visible=0")
end if
end event

type rb_data from radiobutton within w_correggi_bollettina_2
integer x = 3022
integer y = 100
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "PER DATA"
end type

event clicked;dw_1.dataobject="d_correggi_s_bollettina"
dw_1.settransobject(sqlca)
DW_6.VISIBLE=false
cb_carica.visible=true
is_no_reset='N'
cbx_no_reset.checked=false
cbx_no_reset.visible=false
end event

type rb_barcode from radiobutton within w_correggi_bollettina_2
integer x = 3022
integer y = 20
integer width = 361
integer height = 76
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BARCODE 7"
end type

event clicked;dw_1.dataobject="d_correggi_bollettina_cod_barre"
dw_1.settransobject(sqlca)
cb_carica.visible=false
DW_6.VISIBLE=TRUE
dw_6.insertrow(1)
is_no_reset='S'
dw_6.setfocus()
cbx_no_reset.checked=false
cbx_no_reset.visible=false
end event

type dw_6 from udw_base within w_correggi_bollettina_2
boolean visible = false
integer x = 2729
integer y = 204
integer width = 736
integer height = 176
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_ins_barcode_plurimo_ext"
boolean vscrollbar = false
end type

event editchanged;call super::editchanged;long ll_id_bollettina,ll_id_test, ll_riga_trovata,ll_riga_inserita,ll_riga_pacco
long ll_id_prof,ll_riga2_inserita, ll_num_prog, ll_id_pacco
string ls_num_doc, ls_test,ls_anno, ls_gia_spedita,ls_cod_pacco
datastore ds_trova_bol_pacco
integer li_lunghezza, li_lacci
date ldt_da_data


dw_2.accepttext()
ds_trova_bol_pacco=create datastore

//se è silver va bene così, se è vener cambia peer num prog
if dwo.name="cod_barre"  then
//	if len(data)=2 then
//		if data='80' then
//			ii_13=13
//		else
//			ii_13=7
//		end if
//	end if
	//prendo il profilo entro il quale devo ricercare dalla dw in alto (dw_2)
	//ll_id_prof=dw_2.getitemnumber(1, "id_prof_doc")
	if rb_barcode.checked or rb_pacchi.checked or rb_bar_2020.checked then 
		ds_trova_bol_pacco.dataobject="d_trova_bollettina_pacco"
		ds_trova_bol_pacco.settransobject(sqlca)
		li_lunghezza=7
		if len(data)=li_lunghezza then
			
			ls_num_doc=data       //mid(data, 3, 5)
			ldt_da_data=dw_2.getitemdate(1, "da_data")
			if isnull(ldt_da_data) then
				messagebox("Attenzione!", "Valore della data dalla quale partire per ricercare le bollettine NON valorizzato!")
				destroy ds_trova_bol_pacco
				return
			end if
			ll_riga_trovata=ds_trova_bol_pacco.retrieve(ls_num_doc, ldt_da_data)
			if ll_riga_trovata>0 then
				if ll_riga_trovata>1 then
					messagebox("Attenzione!", "trovate 2 bollettine con lo stesso numero")
					destroy ds_trova_bol_pacco
					
				else
					ls_gia_spedita=ds_trova_bol_pacco.getitemstring(1, "ordinato_fo")
					if ls_gia_spedita="S" then
						if messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già spedita!"+&
						" Vuoi visualizzarla lo stesso?", stopsign!,  yesno!)<>1 then
							return
						end if
					end if
					ll_id_bollettina=ds_trova_bol_pacco.getitemnumber(1, "id_riga_documento")
					if ll_id_bollettina>0 then
						dw_1.retrieve(ll_id_bollettina)
						//aggiungo 20220722 cambio tutto e uso una DW
						ll_id_test=wf_gia_in_pacco(ll_id_bollettina)
						if ll_id_test>0 then
							dw_11.retrieve(ll_id_test)
							ll_riga_pacco=dw_11.find("id_bollettina="+string(ll_id_bollettina), 1, 1000000)
							ls_cod_pacco=dw_11.getitemstring(ll_riga_pacco, "c_cod_pacco")
							dw_11.scrolltorow(ll_riga_pacco)
							dw_1.setitem(row, "c_cod_pacco", ls_cod_pacco)
						else
							wf_ins_bol_in_pacco(row, ll_id_bollettina)
						end if
					else
						messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
						
					end if
					dw_6.reset()
					dw_6.insertrow(1)
					//post setfocus(this)
					post scrolltorow(rowcount())
					post setfocus(dw_1)
					//post setcolumn("cod_barre")
					ll_riga_inserita=dw_1.find("id_riga_documento="+string(ll_id_bollettina), 1, dw_1.rowcount())
					dw_1.scrolltorow(ll_riga_inserita)
					dw_1.post setcolumn("quantita")
					li_lacci=dw_1.getitemnumber(ll_riga_inserita, "riga_documento_provv_imp_carea_2")
					if li_lacci=0 then
						setnull(li_lacci)
						dw_1.setitem(ll_riga_inserita, "riga_documento_provv_imp_carea_2", li_lacci)
					end if
		//	//		cb_inserisci.trigger event clicked()
					destroy ds_trova_bol_pacco
				end if
			else
				wf_controllo_se_esiste_testa(ls_num_doc)
				destroy ds_trova_bol_pacco
			end if
		end if
		
			
	
	elseif rb_13.checked then 
		ds_trova_bol_pacco.dataobject="d_trova_bollettina_ean13"
		ds_trova_bol_pacco.settransobject(sqlca)
		li_lunghezza=13
		if len(data)=li_lunghezza then
			ls_num_doc=mid(data, 8, 5)
			ll_num_prog=long(ls_num_doc)
			ll_id_prof=dw_2.getitemnumber(1, "id_prof_doc")
			//ls_anno=left(string(today(), "yyyy/mm/dd"), 4)
			ls_anno=mid(data, 4, 4)
			ll_riga_trovata=ds_trova_bol_pacco.retrieve(ll_num_prog, ll_id_prof, ls_anno)
			if ll_riga_trovata>0 then
			
				if ll_riga_trovata>1 then
						
				else
					ll_id_bollettina=ds_trova_bol_pacco.getitemnumber(1, "id_riga_documento")
					if ll_id_bollettina>0 then
						dw_1.retrieve(ll_id_bollettina)
					else
						messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
						
					end if
					dw_6.reset()
					dw_6.insertrow(1)
				end if
			else
				wf_controllo_se_esiste_testa(ls_num_doc)
			end if
		end if
	end if
end if
		
		
//		select id_documento
//			into :ll_id_bollettina
//			from dba.documento d, registro r, esercizio e
//			
//			where d.num_progressivo=:ll_num_prog
//			and d.id_prof_documento=:ll_id_prof
//			and d.id_registro=r.id_registro
//			and r.id_esercizio=e.id_esercizio
//			and e.codice=:ls_anno
//			;
		
		
		
		
		//commentato 270115
//		ls_anno=left(string(today(), "yyyy/mm/dd"), 4)
//		ls_num_doc=mid(data, 3, 5)
//		ll_num_prog=long(ls_num_doc)
//		select id_documento
//		into :ll_id_bollettina
//		from dba.documento d, registro r, esercizio e//d, dba.prof_documento p
//		//where right(num_documento, 5)=:ls_num_doc
//		where d.num_progressivo=:ll_num_prog
//		//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
//		and d.id_prof_documento=:ll_id_prof
//		and d.id_registro=r.id_registro
//		and r.id_esercizio=e.id_esercizio
//		and e.codice=:ls_anno
//		//and d.id_prof_documento=p.id_prof_documento
//		; //commentato 270115

		//cambiato con sopra il 11-05-12
//		select id_documento
//		into :ll_id_bollettina
//		from dba.documento d, dba.prof_documento p
//		where right(num_documento, 5)=:ls_num_doc
//		and (p.codice='BOL' or p.codice='SBOL')
//		;
		
		//commentato 270115
//	elseif len(data)=13 then
//		//090113: la ricerca trova le bollettine dell'anno scorso ... devo inserire l'esercizio
//		//aggiungo registro ed esercizio
//		ls_anno=mid(data, 4, 4)
//		ls_num_doc=mid(data, 8, 5)
//		ll_num_prog=long(ls_num_doc)
//		
//		select id_documento
//		into :ll_id_bollettina
//		from dba.documento d, registro r, esercizio e
//		//where right(num_documento, 5)=:ls_num_doc
//		where d.num_progressivo=:ll_num_prog
//		//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
//		//agg 10-01-14
//		and d.id_prof_documento=:ll_id_prof
//		//and d.id_prof_documento=p.id_prof_documento
//		and d.id_registro=r.id_registro
//		and r.id_esercizio=e.id_esercizio
//		and e.codice=:ls_anno
//		;
//		//commentato 270115
//select id_documento
//		into :ll_id_bollettina
//		from dba.documento d, dba.prof_documento p
//		//where right(num_documento, 5)=:ls_num_doc
//		where num_progressivo=:ll_num_prog
//		and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
//		and d.id_prof_documento=p.id_prof_documento
//		;
		//cambiato con sopra il 11-05-12
//		select id_documento
//		into :ll_id_bollettina
//		from dba.documento d, dba.prof_documento p
//		where right(num_documento, 5)=:ls_num_doc
//		and (p.codice='BOL' or p.codice='SBOL')
//		;//commentato 270115
//		if ll_id_bollettina>0 then
//			dw_1.retrieve(ll_id_bollettina)
//		else
//			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
//		end if
//		dw_6.reset()
//		dw_6.insertrow(1)
//commentato 270115
	//end if
//end if
end event

type ole_1 from olecustomcontrol within w_correggi_bollettina_2
event oncomm ( )
boolean visible = false
integer x = 4475
integer y = 108
integer width = 174
integer height = 152
integer taborder = 50
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_correggi_bollettina_2.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_1 from commandbutton within w_correggi_bollettina_2
integer x = 3483
integer y = 268
integer width = 343
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Pronto"
end type

event clicked;long ll_id_bollettina, ll_id_pronto,ll_righe, ll_id_ordine, ll_id_riga_bol, ll_id_riga_ordine
integer i, a
long ll_id_bol2, ll_id_riga, ll_id_doc,ll_trovata, ll_id_riga_aggiunta, ll_id_pronto_esistente
datastore ds_cerca_pronto, ds_trova_ord_da_bollettina, ds_trova_bol_da_ordine
long ll_gia_esiste

cb_salva.trigger event clicked()

dw_1.setfilter("ordinato_fo ='S'")
dw_1.filter()
/*devo legare il pronto alla bollettina quindi:
1) devo controllare se l'id_bollettina non è già legato con un pronto nella tabella "produzione_2011", nel qual caso:
	a) correggo anche il pronto?
	b) lascio perdere tutto?
2) devo verificare che un'altra qualunque delle bollettine generate dallo stesso ordine che ha generato questa non sia legata 
	ad un pronto: 
	a) se lo fosse: aggiungo questa bollettina alle righe di quel pronto (quindi recupero l'id_documento e carico le righe dello stesso
		alle quali aggiungo quella della bollettina attuale.
	b) se non lo fosse: creo un nuovo pronto e aggiungo la riga.
Per aggiungere la riga sia nel caso a) che b):
	1) devo prendere id_bollettina
	2) generare la riga del pronto dalla bollettina corretta
	3) devo avere l'id della riga del pronto generata 
	4) lego nella "produzione_2011" la bollettina alla riga del pronto
	
*/
ds_cerca_pronto=create datastore
ds_cerca_pronto.dataobject="d_produzione_2011_cerca_pronto_gd"
ds_cerca_pronto.settransobject(sqlca)

ds_trova_ord_da_bollettina=create datastore
ds_trova_ord_da_bollettina.dataobject="d_produzione_2011_trova_ordine_gd"
ds_trova_ord_da_bollettina.settransobject(sqlca)

ds_trova_bol_da_ordine=create datastore
ds_trova_bol_da_ordine.dataobject="d_produzione_2011_cerca_bol_gd"
ds_trova_bol_da_ordine.settransobject(sqlca)

for i= 1 to dw_1.rowcount()
	ll_id_bollettina=dw_1.getitemnumber(i, "id_documento")
	ll_id_riga_bol=dw_1.getitemnumber(i, "id_riga_documento")
	ll_righe=ds_cerca_pronto.retrieve(ll_id_bollettina)
	if ll_righe>0 then //esiste un pronto già legato a questa bollettina
	//devo inserirlo nella dw_10 trovo l'id_doc del pronto
	ll_id_pronto_esistente=ds_cerca_pronto.getitemnumber(1, "id_documento")
	//controllo se nella dw_10 non sia già stato inserito questo pronto
	ll_gia_esiste=dw_10.find("id_documento="+string(ll_id_pronto_esistente), 1, dw_10.rowcount())
	if ll_gia_esiste>0 then
		ll_gia_esiste=0
	else
		dw_10.retrieve(ll_id_pronto_esistente)	
	end if	
	else //non esiste un pronto legato a questa bollettina
		//occorre cercare le bollettine generate dallo stesso ordine che ha generato questa
		//per poi vedere se hanno generato un qualche pronto, allorché apriamo quello e vi
		//aggiungiamo la riga di questa bollettina
		ll_righe=ds_trova_ord_da_bollettina.retrieve(ll_id_bollettina)
		if ll_righe<=0 or isnull(ll_righe) then messagebox("Incredibile!", "1Non c'è l'ordine ...")
		//l'ordine c'è per forza ....
		ll_id_ordine=ds_trova_ord_da_bollettina.getitemnumber(1, "id_documento")
		//... a meno che qualcuno non lo cancelli .... 210912
		if ll_id_ordine>0 then
			ll_id_riga_ordine=ds_trova_ord_da_bollettina.getitemnumber(1, "id_doc_produzione")
			ll_righe=ds_trova_bol_da_ordine.retrieve(ll_id_ordine)
			for a= 1 to ll_righe
				ll_id_bol2=ds_trova_bol_da_ordine.getitemnumber(a, "id_bollettina")
				ll_trovata=ds_cerca_pronto.retrieve(ll_id_bol2)
				if ll_trovata>0 then	exit//esiste un pronto per questa bollettina
			next
			if ll_trovata>0 then //esiste un pronto per questa bollettina generato da altra bollettina dello stesso ordine
				ll_id_doc=ds_cerca_pronto.getitemnumber(ll_trovata, "id_documento")
				ll_gia_esiste=dw_10.find("id_documento="+string(ll_id_doc), 1, dw_10.rowcount())
				if ll_gia_esiste>0 then
					ll_gia_esiste=0
				else
					dw_10.retrieve(ll_id_doc)
				end if	
			else //è il primo pronto dell'ordine di cui fa parte questa bollettina
					//occorre creare il documento
				ll_id_doc=wf_crea_pronto(ll_id_riga_ordine)			
			end if
			wf_aggiungi_riga(ll_id_doc, ll_id_bollettina,ll_id_riga_bol )
		else
			messagebox("Incredibile!", "Non c'è l'ordine ...")
		end if
	end if
next
dw_7.visible=true
dw_10.visible=true
cbx_vedi_pronto.checked=true
destroy ds_trova_ord_da_bollettina
destroy ds_cerca_pronto
destroy ds_trova_bol_da_ordine
end event

type dw_8 from u_dw_master_main within w_correggi_bollettina_2
event type integer ue_setta_prezzo ( )
event type string ue_get_nrcolval ( integer al_column )
event type long ue_setta_un_conf ( )
event ue_setta_rif_des_agg ( )
event ue_set_arti_riga ( )
event ue_set_ucon_riga ( )
event type integer ue_set_calc_riga ( long al_row )
event ue_set_comp_riga ( )
event type integer ue_wiz_insert ( )
event ue_wiz_getfocus ( )
event type integer ue_set_calc_tot_riga ( long al_row,  decimal adc_quantita,  decimal adc_prezzo_netto,  boolean ab_calc_sconto )
event ue_set_contropartita ( )
event ue_lb_down pbm_lbuttondown
event type integer ue_rec_prezzo ( long row,  decimal qta )
event ue_post_itemchanged ( long al_riga,  string as_colonna,  string as_message )
string tag = "Righe di Documento"
boolean visible = false
integer x = 59
integer y = 1860
integer width = 4082
integer height = 748
integer taborder = 30
string dragicon = "Asterisk!"
boolean bringtotop = true
string dataobject = "d_orafo_riga_documento_ordine_260510_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event type integer ue_setta_prezzo();
long 			ll_id_un_confezione, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value,il_row
decimal 		ldc_ret_value, ldc_fat_conversione, ldc_molteplicita, ldc_quantita, ldc_fattore, ldc_totale
date 			ld_comp
string 		ls_tipo_conversione, ls_sconto

ll_row= GetRow()
il_row=dw_1.getrow()
ll_id_un_confezione= GetItemNumber(ll_row, "riga_documento_id_unita_confezione")
ll_id_listino=GetItemNumber(ll_row, "riga_documento_id_listino")
ld_comp= dw_1.GetItemDate(il_row, "data_registrazione")

ls_sconto = uf_get_colval("sconto")
//ldc_ret_value=uf_calcola_prezzo(ls_sconto, ldc_ret_value, uf_GetItemDecimal(ll_row, "quantita"))
if not IsNull(ldc_ret_value) then 
	
	SetItem(ll_row,"riga_documento_prezzo_netto",Truncate(ldc_ret_value, 0))
	ldc_quantita=uf_GetItemDecimal(ll_row, "quantita")
	if GetItemString(ll_row,"c_unita_conf_tipo_conversione") = 'D' then
		ldc_fattore=1 / uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	else
		ldc_fattore=uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	end if
	ldc_molteplicita=uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
	if IsNull(ldc_molteplicita) then ldc_molteplicita= 0
	ldc_totale= ldc_quantita * Truncate(ldc_ret_value, 0) * ldc_fattore * ldc_molteplicita
	
	SetItem(ll_row,"qta_un_base", ldc_totale)
end if

return ll_ret_value

end event

event ue_setta_rif_des_agg;
end event

event ue_set_arti_riga();//
//
//long				ll_num_colli
//decimal			ld_quantita
//
//long 				ll_id_articolo, ll_id_lingua, ll_id_linguaggio
//long				ll_id_sog_commerciale, ll_id_unita_confezione, ll_id_tab_iva, ll_row
//string			ls_tipo_iva
//
//
//ll_row=GetRow()
//POST WF_METTI_DESCRIZIONE(LL_ROW)
//ll_id_sog_commerciale = idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
//ll_id_articolo = GetItemNumber(ll_row, "riga_documento_id_articolo")
//
//ll_id_unita_confezione = long(uf_get_colval("riga_documento_id_unita_confezione"))	
//
//if (isnull(ll_id_unita_confezione) or ll_id_unita_confezione <= 0) then
//	
//	SELECT id_unita_confezione, num_colli
//	INTO 	 :ll_id_unita_confezione, :ll_num_colli  
//	FROM 	 unita_confezione  
//	WHERE  id_articolo = :ll_id_articolo
//	AND    unita_base = 'S'
//	;
//	
//	if (sqlca.sqlcode = -1) then
//		messagebox("dberror", sqlca.sqlerrtext)
//	end if	
//end if
//
//SELECT num_colli
//INTO 	 :ll_num_colli  
//FROM 	 unita_confezione  
//WHERE  id_unita_confezione = :ll_id_unita_confezione
//;
//
//if (sqlca.sqlcode = -1) then
//	messagebox("dberror", sqlca.sqlerrtext)
//end if
//
//
//if (not IsNull(ll_id_unita_confezione)) and (ll_id_unita_confezione > 0) then
//	
//
//	if (not isnull(ld_quantita) and ld_quantita > 0) then ll_num_colli=ll_num_colli*ld_quantita
//	uf_set_colval("riga_documento_num_colli", string(ll_num_colli))
//
//	
//	triggerevent("ue_set_ucon_riga")
//end if
//
//
//
//
//
//SELECT "tab_iva"."tipo_iva", "tab_iva"."id_tab_iva"
//	INTO :ls_tipo_iva, :ll_id_tab_iva
//	FROM "dba"."sog_commerciale", "dba"."tab_iva"  
//	WHERE ( "tab_iva"."id_tab_iva" = "sog_commerciale"."id_tab_iva" ) and  
//			( ( "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) ) ;
//
//if ls_tipo_iva > '' then
//	
//	uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
//else
//	
//	SELECT "articolo"."id_tab_iva"  
//		INTO :ll_id_tab_iva  
//		FROM "dba"."articolo"
//		WHERE "articolo"."id_articolo" = :ll_id_articolo ;
//
//	if (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
//		
//		SELECT "cat_com_articolo"."id_tab_iva"  
//			INTO :ll_id_tab_iva  
//			FROM "dba"."articolo",   
//			"cat_com_articolo"  
//			WHERE ( "cat_com_articolo"."id_cat_com_articolo" = "articolo"."id_cat_com_articolo" ) and  
//			( ( "articolo"."id_articolo" = :ll_id_articolo ) )   ;
//	end if
//	if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
//		uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
//	end if
//end if
//
//tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.event ue_vis_esi_disponibilita()
//wf_cal_costi()	
end event

event ue_set_ucon_riga();


long			ll_id_unita_conf, ll_num_colli
decimal		ld_molt, ld_fatconv, ld_fatglob, ld_qta_proposta, ld_qta
string		ls_tipoconv

ll_id_unita_conf = long(uf_get_colval("riga_documento_id_unita_confezione"))
ld_qta = dec(uf_get_colval("quantita"))

SELECT fat_conversione, molteplicita, tipo_conversione, num_colli
INTO	 :ld_fatconv, :ld_molt, :ls_tipoconv, :ll_num_colli
FROM	 unita_confezione
WHERE  id_unita_confezione = :ll_id_unita_conf
;

if (SQLCA.SQLCODE = 0) then
	
	

	if ( ld_qta = 0 or isnull(ld_qta) ) then
		

		
		long 		ll_id_prof_documento
		ll_id_prof_documento = dw_1.getitemnumber(dw_1.getrow(), "id_prof_documento")
		
		SELECT quantita_prop_riga
		INTO	 :ld_qta_proposta
		FROM	 prof_documento
		WHERE  id_prof_documento = :ll_id_prof_documento
		;
		
		
		if (SQLCA.SQLCODE = 0) then
			if (not isnull(ld_qta_proposta)) and (ld_qta_proposta > 0) then
				uf_set_colval("quantita",string(ld_qta_proposta))
				
				if (ll_num_colli > 0) and (not isnull(ll_num_colli)) then
					ll_num_colli = ll_num_colli * ld_qta_proposta
					uf_set_colval("riga_documento_num_colli",string(ll_num_colli))
				end if
				
			end if
		end if
	end if

	uf_set_colval("riga_documento_fat_con_unita_base",string(ld_fatconv))
	uf_set_colval("c_unita_conf_tipo_conversione", string(ls_tipoconv))
	uf_set_colval("c_unita_conf_molteplicita", string(ld_molt))
	If ls_tipoconv = "D" then
		uf_set_colval("fat_con_globale", string(ld_fatconv / ld_molt))
	else
		uf_set_colval("fat_con_globale", string(ld_fatconv * ld_molt))		
	end if

	
	long ll_row
	ll_row = getrow()
	
	
	
	if (not isnull(ld_qta_proposta)) and (ld_qta_proposta > 0) then
		
		dwobject	my_dwo
		my_dwo = this.object.quantita
		this.trigger event itemchanged(ll_row, my_dwo, string(ld_qta_proposta))		
		
	end if
	
	
	
end if




end event

event type integer ue_set_calc_riga(long al_row);//
//
//decimal		ld_QTA_UB, ld_QTA, ld_QTA_SM, ld_Prezzo_Netto, ld_Sconti, ld_Totale_Riga
//decimal		ld_Cambio, ld_Sconto_Riga, ld_QTA_Evasa_UB, ld_Qta_Evasa, lcd_null
//decimal		ld_Prezzo, ld_Quantita, ld_Totale_Riga_Lire, ld_Qta_Effettiva, ld_Totale_Riga_val
//string		ls_Sconto, ls_tipoconv, ls_tipo_arrotondamento
//decimal		ld_fatconv, ld_fatglob, ld_molt, ld_cambio_riga, ld_cambio_documento
//long			ll_row, ll_id_valuta_riga, ll_valuta_documento, ll_nr_cifre_arrot
//
//
//if al_row>0 then
//	ll_row= al_row
//	
//	SetNull(lcd_null)
//	ls_tipoconv = GetItemString(ll_row,"c_unita_conf_tipo_conversione")
//	ld_fatconv = uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
//	ld_molt =uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
//	
//	
//	ld_prezzo=getitemdecimal(al_row, "prezzo")
//	
//	
//	
//	if ls_tipoconv = "D" then
//		if ld_fatconv <> 0 then
//			ld_fatglob = 1/ld_fatconv
//		else
//			ld_fatglob = 0
//		end if
//	else
//		ld_fatglob = ld_fatconv
//	end if
//	ld_fatglob = ld_fatglob * ld_molt
//	SetItem(ll_row,"fat_con_globale",string(ld_fatglob))
//	
//	
//	
//	
//	ls_Sconto= GetItemString(ll_row, "sconto")
//	ld_QTA = uf_GetItemDecimal(ll_row, "quantita")
//	if IsNull(ld_QTA) then ld_QTA=0
//	if uf_calcola_prezzo(ls_Sconto, 1000000, 1) = 0 then
//	
//		ld_QTA_SM= 0 
//		SetItem(ll_row, "qta_sconto_merce", 0)
//	else
//		ld_QTA_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
//		if IsNull(ld_QTA_SM) then ld_QTA_SM=0
//	end if
//	
//	ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
//	SetItem(ll_row, "qta_un_base", ld_QTA_UB)
//	
//	ld_Qta_Evasa= uf_GetItemDecimal(ll_row, "qta_evasa")
//	if IsNull(ld_Qta_Evasa) then ld_Qta_Evasa=0
//	
//	ld_QTA_Evasa_UB = ld_Qta_Evasa * ld_FatGlob
//	SetItem(ll_row, "qta_evasa_un_base", ld_QTA_Evasa_UB)
//	ld_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
//	if IsNull(ld_Prezzo) then ld_prezzo = 0
//	
//	ll_valuta_documento= idw_gen.GetItemNumber(il_row, "documento_id_valuta_des")
//	ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")
//	
//	SELECT "valuta"."cifra_arrotondamento",
//		"valuta"."tipo_arrotondamento"
//		INTO :ll_nr_cifre_arrot ,
//				:ls_tipo_arrotondamento
//		FROM "dba"."valuta"  
//		WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
//	
//	if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
//	ld_cambio_riga= GetItemNumber(ll_row, "riga_documento_cambio")
//	if IsNull(ld_cambio_riga) then ld_cambio_riga=1
//	
//	ld_Prezzo_Netto= uf_calcola_prezzo(ls_Sconto, ld_Prezzo, 1)
//	
//	decimal ld_importo_sconto_riga
//	string ls_um, ls_tipo
//	long ll_id_un_conf
//	decimal ld_peso_netto
//	ld_importo_sconto_riga=getitemdecimal(ll_row, "riga_documento_sconto_riga")
//	ll_id_un_conf=getitemnumber(al_row, "riga_documento_id_unita_confezione")
//	select simbolo, tipo
//	into :ls_um, :ls_tipo
//	from unita_confezione, unita_misura
//	where (unita_confezione.id_unita_confezione=:ll_id_un_conf) 
//	and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
//	
//	ld_peso_netto=getitemdecimal(al_row, "riga_documento_peso_netto")
//	
//	
//	
//	if (ld_qta > 0 and ld_importo_sconto_riga > 0) then
//			ld_importo_sconto_riga=ld_importo_sconto_riga/ld_qta
//	end if
//	if (ld_importo_sconto_riga > 0) then
//		ld_Prezzo_Netto=ld_Prezzo_Netto - ld_importo_sconto_riga
//	end if
//			
//	
//	
//	ld_Prezzo_Netto=f_Round(ld_Prezzo_Netto ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
//	
//	if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0
//	
//	SetItem(ll_row, "riga_documento_prezzo_netto",ld_Prezzo_Netto)
//	
//	event ue_set_calc_tot_riga(ll_row, lcd_null, ld_Prezzo_Netto, FALSE)
//	
//end if
return 0
//
//
end event

event ue_set_comp_riga;
	

end event

event type integer ue_wiz_insert();//
//long ll_last_row
//SetFocus()
//SetRedraw(FALSE)
//TriggerEvent("ue_insert")
//ll_last_row= idw_riga.RowCount()
//SetRow(ll_last_row)
//SetColumn("c_articolo_cod")
//SetRedraw(TRUE)
return 0
//
end event

event ue_wiz_getfocus();//
//long ll_current_row
//
//SetFocus()
//ll_current_row= idw_riga.GetRow()
//SetRow(ll_current_row)
//SetColumn("c_articolo_cod")
//
//
//
end event

event type integer ue_set_calc_tot_riga(long al_row, decimal adc_quantita, decimal adc_prezzo_netto, boolean ab_calc_sconto);//
//long			ll_row, ll_nr_cifre_arrot, ll_id_valuta_riga, ll_valuta_documento
//string		ls_tipo_arrotondamento, ls_tipo_Arr
//decimal		ldc_sconto_riga, ldc_totale_riga, ldc_Totale_Riga_val, ldc_Prezzo, ldc_Sconto
//decimal		ldc_cambio, ldc_totale_riga_lire, adc_quantita_SM, adc_quantita_Effettiva
//long			ll_cifra_arr
//ll_row=al_row
//
//if ll_row>0 and  not isnull(ll_row) then
//	if IsNull(adc_quantita) then adc_quantita= uf_GetItemDecimal(ll_row, "quantita")
//	
//	if IsNull(adc_Prezzo_Netto) then	adc_Prezzo_Netto= uf_GetItemDecimal(ll_row, "riga_documento_prezzo_netto")
//	
//	if not IsNull(adc_Prezzo_Netto) then 
//		if IsNull(adc_quantita) then adc_quantita=0
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		ll_valuta_documento= idw_gen.GetItemNumber(1, "documento_id_valuta_des")
//		ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")
//		
//		SELECT "valuta"."cifra_arrotondamento",
//			"valuta"."tipo_arrotondamento"
//			INTO :ll_nr_cifre_arrot ,
//					:ls_tipo_arrotondamento
//			FROM "dba"."valuta"  
//			WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
//		
//		if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
//		
//		ldc_cambio= GetItemNumber(ll_row, "riga_documento_cambio")
//		
//		if IsNull(ldc_cambio) then ldc_cambio=1
//		
//				
//		
//		adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
//			if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
//			adc_quantita_Effettiva= adc_quantita 
//
//		
//		long ll_id_art
//		decimal ld_peso
//		
//		ll_id_art=GetItemNumber(al_row,"riga_documento_id_unita_confezione")
//		ld_peso=GetItemDecimal(al_row,"riga_documento_peso_netto")
//		
//		ldc_Totale_Riga= wf_trova_prezzo(ll_id_art, adc_quantita_Effettiva, ld_peso, adc_Prezzo_Netto)
//		
//		
//		
//		
//		select cifra_arrotondamento, tipo_arrotondamento
//		into   :ll_cifra_arr, :ls_tipo_arr
//		from   valuta
//		where  id_valuta = :al_id_val_az;
//		
//		if (sqlca.sqlcode = -1) then messagebox("dberror", sqlca.sqlerrtext)
//		
//		
//		
//		
//		
//		
//		ldc_Totale_Riga= f_Round(ldc_Totale_Riga, ll_cifra_arr, "M")
//		
//		
//		SetItem(ll_row, "tot_riga_val_riga",ldc_Totale_Riga)
//		
//		
//		
//		
//			adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
//			if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
//			adc_quantita_Effettiva= adc_quantita + adc_quantita_SM
//		
//		if not(IsNull(adc_quantita_Effettiva) OR adc_quantita_Effettiva=0) then SetItem(ll_row, "riga_documento_val_attribuito",ldc_Totale_Riga / adc_quantita_Effettiva)
//		
//		if IsNull(ldc_Cambio) OR ldc_Cambio=0 then ldc_Cambio=1		
//		ldc_Totale_Riga_Lire= ldc_Totale_Riga * ldc_Cambio
//		
//		
//		
//		SetItem(ll_row, "tot_riga_val_az",f_round(ldc_Totale_Riga_Lire,ll_cifra_arr, "M"))
//
//		if ll_id_valuta_riga = ll_valuta_documento then
//			SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga)
//		else
//			
//			//if IsNull(idc_cambio) then idc_cambio=0
//			//ldc_Totale_Riga_val= ldc_Totale_Riga_Lire / idc_cambio
//			ldc_Totale_Riga_val= ldc_Totale_Riga_Lire / ldc_cambio
//			
//			if IsNull(il_arrotondamento) then il_arrotondamento=0
//			
//			
//			ldc_Totale_Riga_val= f_round(ldc_Totale_Riga_val, ll_cifra_arr, "M")
//			
//			
//			
//			SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga_val)
//		end if
//	
//	else
//		adc_Prezzo_Netto=0
//		SetItem(ll_row, "tot_riga_val_riga",0)
//		SetItem(ll_row, "tot_riga_val_doc",0)
//		SetItem(ll_row, "tot_riga_val_az",0)
//	end if
//	If ab_calc_sconto then
//		ldc_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
//		If not IsNull(ldc_Prezzo) OR ldc_Prezzo <> 0 then 
//			ldc_Sconto= (ldc_Prezzo - adc_prezzo_netto) * 100 / ldc_Prezzo
//			ldc_Sconto= Round(ldc_Sconto , 2)
//			SetItem(ll_row, "sconto", String(ldc_Sconto))
//		end if
//		
//	end if
//end if
return 0
//
//
//
end event

event ue_set_contropartita();//
//
//long		ll_row, ll_id_articolo, ll_id_contropartita, ll_id_causale
//long		ll_id_sog_commerciale, ll_id_agente, LL_IDAZ
//u_setta_campi_documento u_cerca_cpt
//u_cerca_cpt=create u_setta_campi_documento
//ll_id_sog_commerciale= idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
//ll_id_agente=  idw_gen.GetItemNumber(il_row, "id_gruppo_agenti")
//ll_row= GetRow()
//ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
//ll_id_causale=GetItemNumber(ll_row, "riga_documento_id_caus_magazzino")
//
//ll_id_contropartita= wf_calcola_cpt(ll_id_sog_commerciale, ll_id_agente, ll_id_articolo, ll_id_causale)
//
//
//
//SetItem(ll_row, "riga_documento_id_conto", ll_id_contropartita)
//
end event

event ue_lb_down;//
//long			ll_row, ll_pos
//string		ls_dati, ls_riga
//
//If ib_rinumera_righe then
//	ll_row = 0
//	ls_dati = this.GetObjectAtPointer()
//	ll_pos = pos(ls_dati,"~t")
//	if ll_pos>0 then
//		ls_riga = mid(ls_dati,ll_pos+1)
//		il_drag_row = Long(ls_riga)
//	end if
//	if (il_drag_row > 0 ) then
//		This.ScrollToRow(il_drag_row)
//		This.Drag(begin!)
//	else
//		this.Drag(end!)
//	end if
//end if
//
end event

event type integer ue_rec_prezzo(long row, decimal qta);//
//
//integer ll_return, ll_riga_corrente
//string ls_tras_mezzo
//long    ll_id_trasporto 
//
//
//ls_tras_mezzo=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemstring(1, "tras_mezzo")
//ll_id_trasporto=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber(1, "id_tipo_trasporto_des") 
//
//ll_return = f_rec_prezzo(row, qta, tab_1.tabpage_1.dw_documento_ordine_ff, this, ls_tras_mezzo, ll_id_trasporto)
//
//if (ll_return = 1) then
//	ll_riga_corrente = getrow()
//	post event ue_set_calc_riga(ll_riga_corrente)
//end if
//
return 1
end event

event ue_post_itemchanged;
if as_message >"" then
	messagebox("Attenzione!", as_message)
end if
setitem(al_riga, as_colonna, 0)
setcolumn(as_colonna)
end event

event clicked;string ls1_nomedwo, ls1_column, ls1_tipodwo, ls_riga_descrittiva, ls_art
long ll_id_art, ll_id_cat_codifica
ls1_nomedwo = dwo.name
ls1_tipodwo = dwo.type
if ((ls1_tipodwo="bitmap") and (right(ls1_nomedwo,3)="_sw")) then
	ls1_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 3)
	if ls1_column="c_articolo_cod" or ls1_column="riga_documento_descrizione" then
		
			ls_riga_descrittiva=getitemstring(getrow(), "riga_documento_descrizione")
			ll_id_art=this.getitemnumber(getrow(),"riga_documento_id_articolo")
			if ls_riga_descrittiva>"" and not (isnull(ls_riga_descrittiva)) and  isnull(ll_id_art) then
				messagebox("Attenzione!", "Impossibile inserire un articolo in una riga descrittiva.~r~n"+&
				"Cancellare la riga e inserirne una nuova")
				return 
			end if	
		
	end if
end if

call super::clicked

if dwo.name="distinta" then
	s_list_main ls_list_distinta
	long ll_id_dis,ll_art
	ll_art=this.getitemnumber(row,"riga_documento_id_articolo")
	select id_distinta
	into :ll_id_dis
	from distinta
	where id_articolo=:ll_art;
	if sqlca.sqlcode=0 then
		ls_list_distinta.s_modo = modo_modifica
		ls_list_distinta.s_SQL_ident[1] = "distinta.id_distinta"
		ls_list_distinta.s_identifica[1]="id_distinta"
		ls_list_distinta.l_identifica[1]=ll_id_dis
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
	else 
		ls_list_distinta.s_identifica[1]="id_articolo"
		ls_list_distinta.l_identifica[1]=ll_art
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
	end if
end if



	
end event

event constructor;call super::constructor;

this.Object.c_riga_valida.width = 0
this.Object.c_evasione.width = 0
If FileExists ("Arr1.cur") then this.Object.DataWindow.Pointer="Arr1.cur"




end event

event dberror;
choose case sqldbcode
	case -196
		messagebox("Salvataggio fallito!", "Si sta tentando di inserire una riga documento~r~n"&
		+"con numero riga già esistente")
		return 1
	case -99999
		messagebox("Salvataggio fallito!", "Per movimentare un articolo occorre~r~n"&
		+"inserire la quantità o il peso (Legato).")
		return 1
	case else
		call super::dberror
end choose

end event

event doubleclicked;

//if string(dwo.name) ="c_articolo_cod" and cbx_cod_barre.checked then
//	return
//	
//
//else
	call Super::doubleClicked
//end if



end event

event dragdrop;call super::dragdrop;
long		ll_drag_num_riga, ll_drop_num_riga

//If ib_rinumera_righe then
//	If not(IsNull(il_drag_row) OR IsNull(row) OR il_drag_row <=0  OR row<=0 OR il_drag_row=row) then
//		this.SetRedraw(FALSE)
//		ll_drag_num_riga=GetItemNumber(il_drag_row,"riga_documento_num_riga")
//		ll_drop_num_riga=GetItemNumber(row,"riga_documento_num_riga")
//		SetItem(il_drag_row,"riga_documento_num_riga", ll_drop_num_riga)
//		SetItem(row,"riga_documento_num_riga", ll_drag_num_riga)
//		SetSort("riga_documento_num_riga A") 
//		Sort()
//	end if
//end if
//this.Drag(end!)
//If not (IsNull(row) Or row=0) then ScrollToRow(row)
//this.SetRedraw(TRUE)
end event

event editchanged;
end event

event getfocus;call super::getfocus;


end event

event itemchanged;//decimal 		ldc_prezzo, ldc_parte,ldc_tot_riga, ldc_ret_value, ldc_quantita, ldc_totale, ldc_fattore
//decimal 		ldc_molteplicita
//string 		ls_sconto, ls_parte, ls_descrizione
//long 			ll_row, ll_pos, ll_ret_value, ll_id, ll_tab_iva, ll_id_magazzino, ll_id_locazione
//boolean 		lb_non_calcolabile
//string 		ls_tot_riga
//string		ls_tb, ls_cp, ls_vr, ls_tr, ls_riga_descrittiva, ls_tipo, ls_art
//string		ls_dbc[], ls_dbv[], ls_dwc[], ls_message
//integer		li_ok
//decimal		ldc_null, ld_sc_unit_riga, ld_sc_riga, ld_qta_min, ld_qta_max 
//dwItemStatus	ldw_status
//long  		ll_id_unita_conf,ll_confezione,ll_id_art,ll_righe_old,ll_righe_new,i, ll_lotto_trovato
//decimal 		ld_qta, ld_qta_lotto, ld_qta_iniz, ld_qta_eff, ldt_qta_scar_attuale
//string ls_gruppo, ls_gruppo_2, ls_cod_lotto
//integer li_ret
//decimal d_azzera[]
//long l_azzera[], LL_NUMERO
//date ldt_scadenza
//
//decimal ld_tara
//decimal ld_peso_netto, ld_peso_lordo
//string  ls_codice_azienda
//
//long 	ll_id_gruppo_agenti, ll_id_gruppo_agenti_2, ll_id_documento
//date	ldt_data_reg
//s_con_provvigione ls_con_provvigione			
//
//
////idt_qta_scar_attuale[]=d_azzera[]
////idt_qta_lotti[]=d_azzera[] 
////il_id_lotti[]=l_azzera[]
////
//
////if is_prof_dispo='C' or is_prof_dispo='B' then
////	decimal ld_tot_precedente
////	if (dwo.name='quantita' and this.getitemstring(row,'tipo_um')<>'P') or (dwo.name='riga_documento_peso_netto' and this.getitemstring(row,'tipo_um')='P') then
////   if dwo.name='quantita' then
////		ld_tot_precedente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,'quantita') 	
////	else
////		ld_tot_precedente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,'riga_documento_peso_netto')
////	end if	
////	if uf_blocca_dispo(ld_tot_precedente,data,row)=2 then 
////		post uf_setta_precedente(row,ld_tot_precedente,dwo.name)
////		return 2
////	end if	
////	end if
////end if	
////
//dwobject ldwo_pippo
//
//ll_row= GetRow()
//If ll_row=0 OR IsNull(ll_row) then ll_row= row
//SetNull(ldc_null)
////if IsValid(ids_lotti) and this.dataobject<>"d_riga_documento_ordine_ritorno_gd" then
////	CHOOSE CASE dwo.name
////	CASE "c_articolo_cod"
////		select id_articolo
////		into :ll_id
////		from articolo
////		where codice=:data;
////		if isnull(ll_id) then return 1
////		
////		wf_carico_lotti(row, ll_id)
////	CASE "riga_documento_descrizione"
////		
////		setnull(ll_id)
////		wf_carico_lotti(row,ll_id )
////	CASE "cod_lotto"
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"cod_esterno", data)
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if
////	CASE "data_scadenza"
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"data_scadenza",date(data))
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if
////	CASE "quantita"
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"qta_iniziale",dec(data))
////			
////			ll_id_unita_conf = this.getitemnumber(row,"riga_documento_id_unita_confezione")
////			SELECT peso_netto
////			INTO	 :ld_peso_netto
////			FROM	 unita_confezione
////			WHERE  id_unita_confezione = :ll_id_unita_conf
////			;
////			
////			if (ld_peso_netto > 0) and (not isnull(ld_peso_netto)) then
////				ld_peso_netto = ld_peso_netto * dec(data)
////				ids_lotti.SetItem(i,"peso_netto_iniziale",ld_peso_netto)				
////			end if
////			
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if
////	CASE "riga_documento_peso_netto"
////		
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"peso_netto_iniziale",dec(data))
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if		
////		
////		
////	END CHOOSE
////end if 
//long ll_id_articolo, ll_id_cat_fiscale2
//
//ll_id_articolo=getitemnumber(row, "riga_documento_id_articolo")
//
//			 
//char lc_tipo_ges_lotti
//string ls_tipo_mov
//
//SELECT a.id_cat_fiscale, m.tipo
//INTO   :ll_id_cat_fiscale2, :ls_tipo_mov
//FROM   articolo a, unita_confezione u, unita_misura m
//WHERE  a.id_articolo=:ll_id_articolo
//AND	 u.id_articolo = a.id_articolo
//AND	 u.unita_base = 'S'
//AND	 m.id_unita_misura =* u.id_unita_misura
//;
//
//SELECT tipo_ges_lotti
//INTO	 :lc_tipo_ges_lotti
//FROM	 pers_par_sistema
//;
//
////if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
////	if dwo.name="riga_documento_peso_netto" and isvalid(ids_scar_lotto) and (not(isnull(ll_id_cat_fiscale2))) then
////		wf_scarico_lotti(ll_id_articolo, dec(data), row)
////	end if		
////else
////	
////	if dwo.name="quantita" and isvalid(ids_scar_lotto) and (not(isnull(ll_id_cat_fiscale2))) then
////		wf_scarico_lotti(ll_id_articolo, dec(data), row)
////	end if	
////end if
//CHOOSE CASE dwo.name
//	CASE "c_articolo_cod", "riga_documento_descrizione"
//			
//	
//		IF DWO.NAME="c_articolo_cod" THEN
////			If (cbx_cod_barre.Checked) = TRUE then
////			
////				String ls_cod_articolo
////			
////				
////				long   ll_id_unita_confezione 
////				SELECT a.codice, c.id_unita_confezione
////				INTO	 :ls_cod_articolo, :ll_id_unita_confezione
////				FROM	 cod_barre c, unita_confezione u, articolo a
////				WHERE	 c.codice = :Data
////				AND	 u.id_unita_confezione = c.id_unita_confezione
////				AND	 a.id_articolo = u.id_articolo;
////				choose case SQLCA.SQLCODE
////					case -1
////						messagebox("", SQLCA.SQLERRTEXT)
////					case 100
////						messagebox("", "Il codice a barre acquisito non è stato codificato ")
////						return 2
////					case 0
////						this.Post setitem(row,"c_articolo_cod", ls_cod_articolo)
////						this.Post setitem(row,"riga_documento_id_unita_confezione", ll_id_unita_confezione)
////						data = ls_cod_articolo
////				end choose
////				
////			end if
//			
//		END IF
//		ls_riga_descrittiva=getitemstring(row, "riga_documento_descrizione")
//		ll_id_art=this.getitemnumber(row,"riga_documento_id_articolo")
//		if ls_riga_descrittiva>"" and not (isnull(ls_riga_descrittiva)) and  isnull(ll_id_art) then
//			messagebox("Attenzione!", "Impossibile inserire un articolo in una riga descrittiva.~r~n"+&
//			"Cancellare la riga e inserirne una nuova")
//			return 1
//		end if		
//	if ii_ricerca_art_fornitore=0 then
//		for i= 1 to 2
//			ls_dbc[1] = "descrizione"
//			ls_dbc[2] = "id_articolo"
//			ls_dbc[3] = "codice"
//			ls_dbc[4] = "descrizione"
//			ls_dwc[1] = "riga_documento_descrizione"
//			ls_dwc[2] = "riga_documento_id_articolo"
//			ls_dwc[3] = "c_articolo_cod"
//			ls_dwc[4] = "c_articolo_des"
//			li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",4,ls_dbc,ls_dbv,ls_dwc)
//			if li_ok>0 and i=1 then
//				ls_art=wf_varianti_set(data, row)
//				if ls_art>"" then
//					data=ls_art
//				else
//					exit
//				end if
//			else
//				exit
//			end if
//		next
//	end if	
//	ii_ricerca_art_fornitore=0	
//	
//		ll_id_art=this.getitemnumber(this.getrow(),"riga_documento_id_articolo")
//		if ll_id_art>0 then
//			li_ret=wf_controlla_utilizzabile(ll_id_art)
//			if li_ret=-1 then 
//				POST uf_set_colval("c_articolo_cod", "")	
//				data=""
//				RETURN
//			end if
//
//
//
//		end if
//		select id_unita_confezione
//		into :ll_confezione
//		from unita_confezione
//		where id_articolo=:ll_id_art
//		and unita_base='S';
//		setitem(ROW,"riga_documento_id_unita_confezione",ll_confezione)
//		wf_inf_aggiuntive(ll_confezione,ROW,ll_id_art)	
//		
//		
//		
//		
//		
//		if li_ok > 0 then
//			
//			
//			
//			
//			ldw_status = GetItemStatus( row,0,Primary! )
//			if ldw_status = New! or ldw_status = NewModified! then
//				post uf_scaglione_provvigione() 
//			end if
//			post wf_inserisci_pesi_riga(0)
//			wf_impongo_magazzino(row,row)
//			trigger event ue_set_arti_riga()	
//			trigger event ue_set_contropartita()
//			
//			if is_prof_dispo='C' or is_prof_dispo='B' then	uf_pre_blocca_dispo(row)
//			return 2 			
//		end if	
//	
//CASE "quantita"
//	ld_qta_max=getitemdecimal(row, "qta_sconto_merce")
//	if (ld_qta_max <> 0 and Not(IsNull(ld_qta_max))) and ld_qta_max>=dec(data) then
//		ls_message="La quantità inserita è inferiore o uguale~r~nalla quantità sconto merce!.~r~nInserire una quantità maggiore!"
//		post event ue_post_itemchanged(row, string(dwo.name), ls_message)
//	end if
//	WF_SE_CAMBIA_QTA(ROW, data)
//	
//	ll_confezione=this.getitemnumber(this.getrow(),"riga_documento_id_unita_confezione")	
//	if (not isnull(data) and dec(data) > 0) and (not isnull(ll_confezione)) and ll_confezione > 0 then
//		decimal {0} ld_num_colli 
//		SELECT num_colli
//		INTO	 :ld_num_colli
//		FROM	 unita_confezione
//		WHERE  id_unita_confezione = :ll_confezione
//		;
//		
//		if (SQLCA.SQLCODE = -1) then messagebox("DBError", SQLCA.SQLERRTEXT)
//		
//		if ld_num_colli > 0 then
//			ld_num_colli = ld_num_colli * dec(data)
//			setitem(row, "riga_documento_num_colli", ld_num_colli)
//		end if
//	end if
//	
//CASE "prezzo", "quantita", "riga_documento_peso_netto" 
//	
//	
//	
//	
//	
//	if (dwo.name = "riga_documento_peso_netto") then
//		SELECT 1
//		INTO   :ls_codice_azienda
//		FROM   azienda
//		WHERE  id_azienda = 1
//		AND	 UCASE(codice) = 'GIESSE'
//		;
//		
//		if (SQLCA.SQLCODE = 0) then
//			ll_row = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getrow()
//			ld_tara = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber(ll_row, "tara")
//
//			ll_row = getrow()
//			ld_peso_lordo = dec(data)
//			ld_peso_netto = (ld_peso_lordo - ld_tara)
//			post setitem(ll_row, "riga_documento_peso_lordo", ld_peso_lordo)	
//			post setitem(ll_row, "riga_documento_peso_netto", ld_peso_netto)
//		end if
//	end if
//	
//	
//	
//	ldw_status = GetItemStatus( row,0,Primary! )
//	
//	
//	string ls_tipo_um
//	decimal ld_prezzo
//	ld_prezzo=getitemdecimal(row, "prezzo")
//	
//	
//	if (dwo.name = "riga_documento_peso_netto") then
//	
//		ls_tipo_um=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(row,"tipo_um")
//		if ls_tipo_um='P' then
//			
//			
//			if pos(upper(u_freddie.istr_database.name), 'ORAFO')>0 then
//			else 
//				post event ue_rec_prezzo(row,1)
//			end if
//		end if
//	end if
//
//	
//	if (dwo.name = "prezzo") then
//		if dec(Data) > 0 and isnull(this.getitemnumber(row, "riga_documento_id_articolo")) then
//			post event ue_set_contropartita()
//		end if
//	end if
//	
//
//CASE "sconto"
//	post event ue_set_calc_riga(row)
//	
//	
//	
//	decimal ld_null
//	setnull(ld_null)
//	this.setitem(row,"riga_documento_sconto_riga",ld_null)
//	
//END CHOOSE
//
//if (dwo.name = "sconto" or dwo.name = "quantita" &
//	 or dwo.name = "riga_documento_peso_netto") then
//	post wf_gruppo_agenti(row)
//end if
//
//
//RETURN ll_ret_value
end event

event itemfocuschanged;call super::itemfocuschanged;//is_last_field=dwo.name


end event

event losefocus;call super::losefocus;
GraphicObject 	lgo_cur_control
string			ls_class

lgo_cur_control = GetFocus( ) 
If IsValid(lgo_cur_control) then
	ls_class=lgo_cur_control.ClassName()
end if
//If ib_rinumera_righe AND not(ls_class="pb_sort") then uf_Rinumera_Righe(0)
end event

event rowfocuschanged;if AcceptText() > 0 then
//	uf_set_mask_riga()
end if 
	
end event

event updateend;//
//IF rowsinserted+rowsupdated+rowsdeleted+modifiedcount()+deletedcount()>0 THEN
//	wf_new_cal_cmc()
//
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//								
//								
//								
//	
//tab_1.tabpage_2.pb_sort.enabled=true
//
//
//END IF
//
//
end event

event updatestart;//boolean lb_calcola_spese = FALSE 
//decimal ld_tot_riga_val_az, ld_tot_riga_val_az_o
//
//If ib_rinumera_righe then uf_Rinumera_Righe(0)
//
//ib_genera_castelletto= TRUE
//	SetPointer(HourGlass!)
//	tab_1.tabpage_4.dw_cast_iva_documento_lt.TriggerEvent("ue_calc_cast_iva")
//	tab_1.tabpage_5.dw_contr_documento_lt.TriggerEvent("ue_calc_contropartita")
//	uf_report_righe()
//	SetPointer(Arrow!)
//
//long  ll_righe, ll_id, ll_riga_doc, ll_id_loc2,i
//long  ll_id_doc, ll_id_caus_magazzino 
//long  ll_id_doc1 
//decimal{2} ld_qta, ld_qta_evasa
//boolean lb_ordinato_fo
//
//
//
//long ll_id_caus_mag_nmn
//
//SELECT id_caus_mag_nmn
//INTO	 :ll_id_caus_mag_nmn
//FROM	 par_sistema
//;
//
//long ll_causale,ll_loc1,ll_loc2, ll_id_articolo
//string ls_loc1,ls_loc2, ls_des
//
//for i=rowcount() to 1 step -1
//	
//	ll_id_articolo=getitemnumber(i,"riga_documento_id_articolo")
//	if isnull(ll_id_articolo) then
//			setitem(i,"riga_documento_id_caus_magazzino", ll_id_articolo)
//			setitem(i,"id_locazione_1", ll_id_articolo)
//			setitem(i,"id_locazione_2", ll_id_articolo)			
//	else
//		
//		long ll_id_cat_fiscale
//		
//		SELECT id_cat_fiscale
//		INTO	 :ll_id_cat_fiscale
//		FROM	 articolo
//		WHERE  id_articolo = :ll_id_articolo
//		;
//		
//		if (isnull(ll_id_cat_fiscale) and not isnull(ll_id_caus_mag_nmn)) then 
//			setitem(i,"riga_documento_id_caus_magazzino", ll_id_caus_mag_nmn)
//			setitem(i,"id_locazione_1", ll_id_cat_fiscale)
//			setitem(i,"id_locazione_2", ll_id_cat_fiscale)
//		end if
//		
//		
//		
//		ll_causale=this.getitemnumber(i,"riga_documento_id_caus_magazzino")
//		select mag_par_richiesto,mag_des_richiesto
//			into :ls_loc1, :ls_loc2
//			from caus_magazzino
//			where id_caus_magazzino=:ll_causale;
//			ll_loc1=this.getitemnumber(i,"id_locazione_1")
//			ll_loc2=this.getitemnumber(i,"id_locazione_2")
//		if not isnull(ll_causale ) then
//			if ls_loc1='S' and isnull(ll_loc1) then
//				messagebox("Errore","La locazione di partenza non è presente sulla riga "+string (i)+" !",stopsign!)
//				return 1
//			end if
//			if ls_loc2='S' and isnull(ll_loc2) then
//				messagebox("Errore","La locazione di destinazione non è presente sulla riga "+string (i)+" !",stopsign!)
//				return 1
//			end if
//			if ls_loc1='N' and not isnull(ll_loc1) then
//				messagebox("Informazione","E' stata impostata una locazione di partenza, su una o più righe, che non sarà utilizzata!")
//			end if	
//			if ls_loc2='N' and not isnull(ll_loc2) then
//				messagebox("Informazione","E' stata impostata una locazione di destinazione, su una o più righe, che non sarà utilizzata!")
//			end if
//		else
//			
//			ll_causale=idw_gen.getitemnumber(1, "documento_id_caus_magazzino")
//			ll_loc1=idw_gen.getitemnumber(1,"documento_id_locazione_1")
//			ll_loc2=idw_gen.getitemnumber(1,"documento_id_locazione_2")
//			setitem(i,"riga_documento_id_caus_magazzino", ll_causale)
//			setitem(i,"id_locazione_1", ll_loc1)
//			setitem(i,"id_locazione_2", ll_loc2)	
//		end if
//	end if
//next
//
//
//
//long ll_id_causale
//string ls_ges_lotti
//integer li_ret
//
//ll_id_causale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_caus_magazzino")
//ls_ges_lotti=wf_gestisci_lotti(ll_id_causale, 0)	
//if ls_ges_lotti='C' or ls_ges_lotti='S' or ls_ges_lotti='A' or ls_ges_lotti='R' then
//	if wf_controlla_lotti(ls_ges_lotti)<0 then
//		messagebox('Errore','Impossibile salvare lotti:  righe errate!')
//		return 1
//	ELSE
//		LI_RET=WF_SALVA_LOTTI(ls_ges_lotti)
//		IF LI_RET<>1 THEN 
//			messagebox('Errore','Impossibile salvare lotti: contattare assistenza!')
//			RETURN 1
//		END IF
//	end if
//end if
//
//
//string ls_des_personale, ls_des_codice, ls_des_estesa
//long ll_id_linguaggio, ll_id_sog_comm, ll_id_lingua, ll_id_linguaggio1, ll_id_lingua1
//long ll_id_riga_padre
//s_des_articolo s_des_art
//string ls_simbolo_um
//decimal{2} ld_lunghezza
//
//ll_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
//if not (tab_1.tabpage_1.dw_documento_ordine_ff.getrow()>0) then return
//ll_id_sog_comm=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_sog_commerciale")
//ll_id_linguaggio=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_linguaggio")
//ll_id_lingua=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_lingua")
//if (isnull(ll_id_linguaggio) or ll_id_linguaggio<1) or (isnull(ll_id_lingua) or ll_id_lingua<1) then
//		select id_linguaggio, id_lingua
//		into :ll_id_linguaggio1, :ll_id_lingua1
//		from par_sistema;
//		if sqlca.sqlcode<>0 then
//			messagebox("Errore!", "Non posso salvare le descrizioni associate al soggetto~r~n"+&
//			"commerciale corrente in quanto non specificato il linguaggio nei parametri di sistema")
//			return
//	end if
//end if
//if isnull(ll_id_lingua) then ll_id_lingua=ll_id_lingua1
//if isnull(ll_id_linguaggio) then ll_id_linguaggio=ll_id_linguaggio1
//for i = 1 to ll_righe
//	ld_lunghezza=getitemdecimal(i,"riga_documento_dim_l")
//	ls_simbolo_um=getitemstring(i, "unita_misura_b_simbolo")
//	if isnull(ls_simbolo_um) then ls_simbolo_um='XX'
//	ls_des_estesa=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i,"des_articolo_des_estesa")
//	ls_des_codice=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i, "des_articolo_codice")
//	ls_des_personale=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i, "des_articolo_descrizione")
//	ll_id_articolo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "riga_documento_id_articolo")
//	//mm 210110 nell'esplosione non deve ricopiare cod cl/fo
//	ll_id_riga_padre=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "id_riga_doc_padre")
//	
//	if (ls_des_personale>'' or ls_des_codice>'' &
//	or ls_des_estesa>'') and isnull(ll_id_riga_padre) &
//	and (not (Isnull(ll_id_articolo))) then
//		
//		update des_articolo
//		set 	descrizione=:ls_des_personale,
//				des_estesa=:ls_des_estesa,
//				codice=:ls_des_codice,
//				id_lingua=:ll_id_lingua,
//				id_linguaggio=:ll_id_linguaggio
//		where id_sog_commerciale=:ll_id_sog_comm
//		and id_articolo=:ll_id_articolo
//		and id_linguaggio=:ll_id_linguaggio
//		and id_lingua=:ll_id_lingua
//		and (simbolo_um=:ls_simbolo_um and lunghezza=:ld_lunghezza)
//		;
//		if sqlca.sqlnrows<1 then
//			
//			insert into des_articolo 
//			(id_linguaggio, descrizione, des_estesa, codice, id_sog_commerciale,
//			id_articolo, id_lingua, lunghezza, simbolo_um)
//			values (:ll_id_linguaggio,:ls_des_personale,:ls_des_estesa,:ls_des_codice, :ll_id_sog_comm, &
//			:ll_id_articolo, :ll_id_lingua, 0,'XX');
//			if sqlca.sqlcode<>0 then
//				rollback;
//			else
//				commit;
//				s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
//				ll_id_lingua,ll_id_linguaggio, i)
//				SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
//			end if
//			if ls_simbolo_um<>'XX' then
//				insert into des_articolo 
//				(id_linguaggio, descrizione, des_estesa, codice, id_sog_commerciale,
//				id_articolo, id_lingua, lunghezza, simbolo_um)
//				values (:ll_id_linguaggio,:ls_des_personale,:ls_des_estesa,:ls_des_codice, :ll_id_sog_comm, &
//				:ll_id_articolo, :ll_id_lingua,  :ld_lunghezza, :ls_simbolo_um);
//				if sqlca.sqlcode<>0 then
//					rollback;
//					messagebox("Errore!", "Descrizione personale "+ls_des_codice+"  non salvata!")
//				else 
//					commit;
//					
//					s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
//					ll_id_lingua,ll_id_linguaggio, i)
//					SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
//				end if
//			end if
//		else 
//			commit;
//			s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
//				ll_id_lingua,ll_id_linguaggio, i)
//			SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
//		end if
//	end if
//	
//next
//
//if (this.DeletedCount() > 0) then lb_calcola_spese = true	
//
//if (lb_calcola_spese) then wf_calcola_spese('N')	
end event

event ue_init;call super::ue_init;
//iudw_children[1] = dw_riga_documento_dett_ord_ff
//				
//is_list.s_identifica[1] = "id_documento"
//is_list.s_win_zoom = "w_riga_documento_wz"
end event

event ue_insert;call super::ue_insert;//ii_ricerca_art_fornitore = 0
//wf_salva_automaticamente()	
end event

event ue_update;
//integer li_RetVal
//
//li_RetVal = super::EVENT ue_update(wparam, lparam)
//
//
//	
//	
//	
//
//RETURN li_RetVal 

end event

event ue_delete;//
//decimal ld_precedente, ld_datastore
//long row, ll_ret, ll_id_art_dispo
//row=this.getrow()
//if is_prof_dispo='C' or is_prof_dispo='B' then
//	if this.getitemstring(row,'tipo_um')<>'P' then
//      ld_precedente=this.getitemdecimal(row,'quantita') 	
//	else
//		ld_precedente=this.getitemdecimal(row,'riga_documento_peso_netto')
//	end if	
//	
//	ll_id_art_dispo=this.getitemnumber(row,'riga_documento_id_articolo')
//   ll_ret=ids_disponibilita.find("id_articolo=" +string(ll_id_art_dispo), 1,ids_disponibilita.RowCount())
//   if ll_ret>0 then ld_datastore=ids_disponibilita.getitemdecimal(ll_ret,'totale')
//	if ld_datastore>ld_precedente then
//		ld_datastore=ld_datastore - ld_precedente
//		ids_disponibilita.setitem(ll_ret,'totale',ld_datastore)
//	else 
//		ids_disponibilita.deleterow(ll_ret)
//	end if
//end if	
//		
//call super ::ue_delete	
end event

event ue_retrieve;call super::ue_retrieve;
long ll_altezza
//ll_altezza= idw_riga.height
long ll_delta_y

//iF POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO')<=0 THEN
//
//	ll_delta_y = 165
//	idw_riga.Modify("c_tot_righe_lire.y = " + String(	 ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe_lire_t.y = " + String( ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe.y = " + String(			 ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe_t.y = " + String(		 ll_altezza 	- ll_delta_y ))
//	
//	
//	idw_riga.Modify("datawindow.summary.height = " + String (ll_altezza - 516))
//end if
//is_title = "Riga " + is_nome_tipo_documento
//SetSort("riga_documento_num_riga A") 
//Sort()
end event

event ue_modify;//
//
//s_any_array			lstr_array
//string				ls_array[], ls_sconto, ls_verifica
//long					ll_nr_column= 48, ll_count, ll_row, ll_id_u_conf
//decimal				ldc_fattore, ldc_molteplicita, ldc_totale, ldc_ret_value, ldc_quantita
//decimal{4}			ld_peso_lordo, ld_peso_netto
//string				ls_nome, ls_ric_riga
//
//long					ll_id_art_o, ll_id_loc_o
//
//
//ll_row = GetRow()
//If AcceptText() = 1 then
//	
//	ls_array[1]= uf_Get_Colval("riga_documento_id_unita_confezione")
//	ls_array[2]= uf_Get_Colval("quantita")
//	
//	ls_verifica=ls_array[2]
//	
//	ls_array[3]= uf_Get_Colval("riga_documento_data_prevista_consegna")
//	ls_array[4]= uf_Get_Colval("prezzo")
//	ls_array[5]= uf_Get_Colval("sconto")
//	ls_array[6]= uf_Get_Colval("riga_documento_prezzo_netto")
//	ls_array[7]= uf_Get_Colval("riga_documento_sconto_riga")
//	ls_array[8]= uf_Get_Colval("riga_documento_id_tab_iva")
//	ls_array[9]= uf_Get_Colval("riga_documento_forza_chius_evasione")
//	ls_array[10]= uf_Get_Colval("riga_documento_sospesa")
//	ls_array[11]= uf_Get_Colval("id_riga_doc_provenienza")
//	ls_array[12]= uf_Get_Colval("riga_documento_id_articolo")
//	ll_id_art_o = long(ls_array[12])	
//	ls_array[13]= uf_Get_Colval("qta_evasa")
//	ls_array[14]= uf_Get_Colval("id_gruppo_agenti")
//	ls_array[15]= uf_Get_Colval("provv_agente")
//	ls_array[16]= uf_Get_Colval("qta_sconto_merce")
//	ls_array[17]= uf_Get_Colval("id_locazione_1")
//	ll_id_loc_o = long(ls_array[17])	
//	ls_array[18]= uf_Get_Colval("id_locazione_2")
//	ls_array[19]= uf_Get_Colval("riga_documento_id_caus_magazzino")
//	ls_ric_riga=is_ric_riga
//	If  uf_Get_Colval("c_evasione") <> "NE" then 
//		ls_ric_riga=Replace(ls_ric_riga,1,1,"L")
//		ls_ric_riga=Replace(ls_ric_riga,13,1,"L")
//		ls_ric_riga=Replace(ls_ric_riga,14,1,"L")
//	end if
//	
//	if is_ges_locazioni = "S" then 
//		ls_ric_riga=Replace(ls_ric_riga,6,1,"M")
//		ls_ric_riga=Replace(ls_ric_riga,7,1,"M")
//	else
//		ls_ric_riga=Replace(ls_ric_riga,6,1,"L")
//		ls_ric_riga=Replace(ls_ric_riga,7,1,"L")
//	end if
//	
//	ls_array[20]= ls_ric_riga
//	ls_array[21]= uf_Get_Colval("riga_documento_id_articolo")
//	ls_array[22]= uf_Get_Colval("riga_documento_id_valuta")
//	ls_array[23]= uf_Get_Colval("riga_documento_cambio")
//	ls_array[24]= uf_Get_Colval("id_riga_documento")
//	ls_array[25]= uf_Get_Colval("provv_subage")
//	ls_array[26]= uf_Get_Colval("provv_carea")
//	ls_array[27]= uf_Get_Colval("riga_documento_id_conto")
//	
//	
//	long ll_riga_corrente
//	ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
//	ls_array[28]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
//	(ll_riga_corrente,"documento_id_magazzino"))
//	ls_array[29]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
//	(ll_riga_corrente,"documento_id_magazzino_2"))
//	
//	
//	ls_array[30]= uf_Get_Colval("riga_documento_num_colli")
//	ls_array[31]= uf_Get_Colval("riga_documento_peso_netto")
//	ls_array[32]= uf_Get_Colval("riga_documento_peso_lordo")
//	
//	ls_array[33]= uf_Get_Colval("usimbolo")
//	ls_array[34]= uf_Get_Colval("udescrizione")
//	ls_array[35]= uf_Get_Colval("riga_documento_dim_l")
//	ls_array[36]= uf_Get_Colval("riga_documento_dim_h")
//	ls_array[37]= uf_Get_Colval("riga_documento_dim_p")
//	
//	ls_array[38]= uf_Get_Colval("unita_misura_b_simbolo")
//	ls_array[39]= uf_Get_Colval("unita_misura_b_descrizione")
//	ls_array[40]=string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_sog_commerciale"))
//	
//	ls_array[41]= uf_Get_Colval("provv_imp_agente")
//	ls_array[42]= uf_Get_Colval("provv_imp_subage")
//	ls_array[43]= uf_Get_Colval("provv_imp_carea")
//	
//	
//	ls_array[44]= uf_Get_Colval("riga_documento_id_gruppo_agenti_2")
//	ls_array[45]= uf_Get_Colval("riga_documento_provv_agente_2")
//	ls_array[46]= uf_Get_Colval("riga_documento_provv_subage_2")
//	ls_array[47]= uf_Get_Colval("riga_documento_provv_carea_2")
//	ls_array[48]= uf_Get_Colval("riga_documento_provv_imp_agente_2")
//	ls_array[49]= uf_Get_Colval("riga_documento_provv_imp_subage_2")
//	ls_array[50]= uf_Get_Colval("riga_documento_provv_imp_carea_2")
//	
//	
//	ls_array[51]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente,"id_documento"))
//	
//	
//	ls_array[52]= string(tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_riga_corrente,"riga_documento_id_con_lis_articolo"))
//	
//	lstr_array.s_array = ls_array
//
//	
//	OpenWithParm(iw_support, lstr_array,"w_riga_documento_wz")
//	lstr_array= Message.PowerObjectParm
//	
//	ls_array= lstr_array.s_array
//	uf_Set_Colval("riga_documento_id_unita_confezione",ls_array[1])
//	long ll_id_unita_confezione
//	ll_id_unita_confezione=long(ls_array[1])
//	if (ll_id_unita_confezione)>0 and not isnull(ll_id_unita_confezione) then
//		string ls_tipo,ls_simbolo
//		SELECT "unita_misura"."tipo","unita_misura"."simbolo"  
//		INTO :ls_tipo,:ls_simbolo 
//		FROM "unita_confezione",   
//		  	  "unita_misura"  
//		WHERE ( "unita_confezione"."id_unita_misura" = "unita_misura"."id_unita_misura" ) and  
//            ( ( "unita_confezione"."id_unita_confezione" = :ll_id_unita_confezione ) )   ;
//		
//		uf_Set_Colval("tipo_um",ls_tipo)
//		uf_Set_Colval("simbolo_mov",ls_simbolo)		
//		
//	end if
//	uf_Set_Colval("quantita",ls_array[2])
//	
//	if ls_verifica<>ls_array[2] then
//		ll_id_u_conf=long(uf_get_colval("riga_documento_id_unita_confezione"))
//		ll_id_u_conf=wf_controlla_qta_mov(ll_id_u_conf, ls_array[2])
//		if ll_id_u_conf=0 then 
//			post event ue_post_itemchanged(getrow(), "quantita", "Non si può movimentare questa quantità!")
//		else
//			post event ue_rec_prezzo(getrow(), dec(ls_array[2]))
//		end if
//	end if
//	
//	if not (IsNull(ls_array[3]) OR  ls_array[3]="") then uf_Set_Colval("riga_documento_data_prevista_consegna",ls_array[3])
//	uf_Set_Colval("prezzo",ls_array[4])
//	uf_Set_Colval("sconto",ls_array[5])
//	
//	uf_Set_Colval("riga_documento_sconto_riga",ls_array[7])
//	uf_Set_Colval("riga_documento_id_tab_iva",ls_array[8])
//	uf_Set_Colval("riga_documento_forza_chius_evasione",ls_array[9])
//	uf_Set_Colval("riga_documento_sospesa",ls_array[10])
//	uf_Set_Colval("id_riga_doc_provenienza",ls_array[11])
//	uf_Set_Colval("qta_evasa",ls_array[13])
//	uf_Set_Colval("id_gruppo_agenti",ls_array[14])
//	uf_Set_Colval("provv_agente",ls_array[15])
//	uf_Set_Colval("qta_sconto_merce", ls_array[16])
//	uf_Set_Colval("id_locazione_1",ls_array[17])
//	uf_Set_Colval("id_locazione_2",ls_array[18])
//	uf_Set_Colval("riga_documento_id_caus_magazzino",ls_array[19])
//	uf_Set_Colval("riga_documento_id_valuta", ls_array[22])
//	uf_Set_Colval("riga_documento_cambio", ls_array[23])
//	uf_Set_Colval("provv_subage",ls_array[25])
//	uf_Set_Colval("provv_carea",ls_array[26])
//	uf_Set_Colval("riga_documento_id_conto",ls_array[27])
//	
//	ll_riga_corrente=getrow()
//	setitem(ll_riga_corrente,"riga_documento_num_colli",dec(ls_array[30]))
//	setitem(ll_riga_corrente,"riga_documento_peso_netto",dec(ls_array[31]))
//	setitem(ll_riga_corrente,"riga_documento_peso_lordo",dec(ls_array[32]))
//
//	
//	setitem(ll_riga_corrente,"riga_documento_dim_l",dec(ls_array[35]))
//	setitem(ll_riga_corrente,"riga_documento_dim_h",dec(ls_array[36]))
//	setitem(ll_riga_corrente,"riga_documento_dim_p",dec(ls_array[37]))	
//	
//	
//	
//	uf_Set_Colval("provv_imp_agente",ls_array[41])
//	uf_Set_Colval("provv_imp_subage",ls_array[42])
//	uf_Set_Colval("provv_imp_carea",ls_array[43])
//	
//	
//	
//	
//	
//	if (long(ls_array[44]) > 0) then
//		
//		uf_Set_Colval("riga_documento_id_gruppo_agenti_2",ls_array[44])
//		uf_Set_Colval("riga_documento_provv_agente_2",ls_array[45])
//		uf_Set_Colval("riga_documento_provv_subage_2",ls_array[46])
//		uf_Set_Colval("riga_documento_provv_carea_2",ls_array[47])
//		uf_Set_Colval("riga_documento_provv_imp_agente_2",ls_array[48])
//		uf_Set_Colval("riga_documento_provv_imp_subage_2",ls_array[49])
//		uf_Set_Colval("riga_documento_provv_imp_carea_2",ls_array[50])	
//		
//	end if
//	
//
//	TriggerEvent("ue_set_ucon_riga")
//	uf_set_mask_riga()
//	
//
//	
//	if (ll_id_art_o <> long(ls_array[12]) or &
//		 ll_id_loc_o <> long(ls_array[17])) then	wf_cal_costi()
//	
//	
//end if
//
end event

event ue_key;//DataWindowChild	ldw_dropdown
//DataWindowChild	ldw_drop
//string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval, ls_cod, ls_des
//integer				li_cdw, li_size, li_i, li_ret
//w_search_main		lw_sm
//w_data_main			lw_win
//w_mod_single_data lw_mw
//w_p_data				lw_pwin
//u_dw_main			lu_dw
//
//long					ll_retv, ll_art, ll_id_sog
//
//integer li_row 
//li_row = getrow()					
//long ll_id_unita_confezione
//if (li_row > 0) then ll_id_unita_confezione = this.getitemnumber(li_row, "riga_documento_id_unita_confezione")
//
//ll_retv = 0
//
//
//choose case key
//	
//	case KeyF1!
//		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
//			
//			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
//		end if
//		
//	case KeyF5!
//		if keyflags = 0 then
//			ls_column = getColumnName()
//			uf_reply_retrieve_dddw(ls_column)
//			
//		end if	
//	
//	
//	
//	
//	case KeyF3!	
//		string ls_parigi, ls_filter2
//		long ll_id_riga_documento
//		integer i
//			
//		select parigi
//		into :ls_parigi
//		from pers_par_sistema;
//			
//		if ls_parigi = 'S' then	
//			
//			open(w_attesa)
//			ls_filter2 = "quantita > 0"
//			setfilter(ls_filter2)
//			filter()
//			update()
//			setfilter("")
//			filter()
//			
//			declare c_canc cursor for
//						
//			select id_riga_documento 
//			from riga_documento
//			where id_documento = :il_id_documento
//			and quantita = 0;
//			
//			open c_canc;
//			fetch c_canc into :ll_id_riga_documento;
//
//			DO WHILE sqlca.sqlcode = 0
//				delete from riga_documento 
//				where id_riga_documento = :ll_id_riga_documento;
//				
//				fetch c_canc into :ll_id_riga_documento;
//			LOOP
//
//	      close c_canc;		
//						
//			commit;
//			
//			idw_master.is_list.s_modo = modo_modifica
//			idw_master.is_list.s_identifica[1] = "id_documento"
//			idw_master.is_list.l_identifica[1] = il_id_documento
//			SetPointer(HourGlass!)
//			
//			this.enabled= FALSE
//			idw_master.Event ue_retrieve(0, 0)
//			uf_set_documento()
//			uf_setup_documento()
//			uf_set_istanze()
//			this.enabled= TRUE
//			uf_default_focus()
//			SetPointer(Arrow!)
//			close(w_attesa)
//		end if
//	
//		
//	case KeyF4!
//		ll_retv = 1
//		ib_during_f4 = true
//		is_ricpar = is_e_ricpar
//		ls_column = getColumnName()
//		ls_style = this.describe(ls_column+".edit.style")
//		is_ricpar.b_imm_retrieve = false
//		is_ricpar.s_caller_column = ls_column
//		is_ricpar.s_sql_cond = ""
//		is_search_window = ""
//		ls_colval = ""
//		trigger event ue_set_search (ls_column,ls_colval)
//		if (is_search_window) <> "" then
//			choose case keyflags
//				case 0	
//					
//					ls_colval = gettext()
//					
//					
//					is_ricpar.b_imm_insert = false
//					is_ricpar.s_caller_column = ls_column
//					is_ricpar.b_imm_retrieve = false
//					is_ricpar.s_sql_cond = ""
//					trigger event ue_set_search (ls_column,ls_colval)
//					if lower (ls_style) <> "dddw" then
//						
//						OpenWithParm (lw_sm,is_ricpar,is_search_window)
//						
//						
//						
//						is_ricpar = Message.PowerObjectParm
//						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
//							trigger event ue_use_search (ls_column)
//						end if
//					end if
//					
//				case 1	
//
//					
//					ls_colval = gettext()
//					
//					
//					is_ricpar.b_imm_insert = true
//					is_ricpar.s_caller_column = ls_column
//					is_ricpar.b_imm_retrieve = false
//					is_ricpar.s_sql_cond = ""
//					trigger event ue_set_search (ls_column, ls_colval)
//					if lower (ls_style) = "dddw" then
//						
//						OpenWithParm (lw_mw,is_ricpar,is_search_window)
//						this.GetChild (ls_column, ldw_dropdown)
//						ldw_dropdown.SetTransObject(SQLCA)
//						ldw_dropdown.Retrieve ()
//						li_size = upperbound(is_ricpar.s_ausil_value)
//						for li_i = 1 to li_size
//							if is_ricpar.s_ausil_value[li_i] > " " then
//								this.GetChild (is_ricpar.s_ausil_value[li_i], ldw_dropdown)
//								ldw_dropdown.SetTransObject(SQLCA)
//								ldw_dropdown.Retrieve ()
//							end if
//						next
//					else
//						
//						
//						OpenWithParm (lw_sm,is_ricpar,is_search_window)
//						is_ricpar = Message.PowerObjectParm
//						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
//							trigger event ue_use_search (ls_column)
//						end if
//					end if
//				case 2	
//				case 3	
//					ls_colval = gettext()
//					is_ricpar.b_imm_maint = true
//					is_ricpar.s_caller_column = ls_column
//					is_ricpar.b_imm_retrieve = false
//					is_ricpar.s_sql_cond = ""
//					trigger event ue_set_search (ls_column,ls_colval)
//					if lower (ls_style) = "dddw" then
//						
//					else
//						
//						
//						OpenWithParm (lw_sm,is_ricpar,is_search_window)
//						if not IsNull(Message.PowerObjectParm) then
//							is_ricpar = Message.PowerObjectParm
//							trigger event ue_use_search (ls_column)
//						end if
//					end if
//					is_ricpar.b_imm_maint = false
//			end choose
//		end if
//		ib_during_f4 = false
//		
//		
//		
//		ii_ricerca_art_fornitore = 0
//
//		
//		
//	case Keyadd!
//		
//		
//		if (keyFlags=2) then
//			ll_retv = 1
//			lw_win = u_freddie.iw_current
//			ls_tipof = lw_win.is_wintype
//			lu_dw = lw_win.idw_master
//			choose case ls_tipof
//				case "W_P_DATA"
//					if this = lu_dw then
//						if is_list.s_modo = modo_inserisci then 			
//							if (event ue_update (0,0) = 0) then
//								triggerevent("ue_insert")
//							end if
//							lu_dw.setFocus()
//						end if
//					else
//						triggerevent("ue_insert")
//					end if
//				case else
//					triggerevent("ue_insert")
//			end choose
//		end if
//	case KeySubtract!
//		if (keyFlags=2) then
//			cb_cancella.event trigger clicked()
//		end if
//
//	case KeyS!
//		if (keyFlags=2) then
//			ll_retv = 1
//			lw_win = u_freddie.iw_current
//			lu_dw = lw_win.idw_master
//			
//			if IsNull(lu_dw) then lu_dw = this
//			lu_dw.triggerevent("ue_update")
//		end if
//	case KeyF12!
//		if (keyFlags=0) then
//			ll_retv = 1
//			lw_win = u_freddie.iw_current
//			lu_dw = lw_win.idw_master
//			
//			if IsNull(lu_dw) then lu_dw = this
//			lu_dw.triggerevent("ue_update")
//		end if
//		
//		
//		if (keyflags=3) then
//			lw_win = u_freddie.iw_current
//			lw_win.trigger event key (keyF12!,3)
//		end if
//	case KeyN!
//		if (keyFlags=2) then
//			ll_retv = 1
//				lw_win = u_freddie.iw_current
//				ls_tipof = lw_win.is_wintype
//				lu_dw = lw_win.idw_master
//				if ls_tipof = "W_P_DATA" then
//					if (lu_dw.is_list.s_modo = modo_inserisci) or (lw_win.ib_nonmodale = true) then 	
//						if (lu_dw.event ue_update (0,0) = 0) then
//							lu_dw.triggerevent("ue_insert")
//						end if
//						lu_dw.setFocus()
//					end if
//				end if
//      end if
//
//	case KeyF6!
//		lw_win = u_freddie.iw_current
//		ls_tipof = lw_win.is_wintype
//		if ls_tipof = "W_P_DATA" then
//			lw_win.ib_F6_in_dw = true
//			if (keyflags=0) then		
//				ll_retv = 0
//				li_ret = -1
//				do while li_ret<0
//					li_cdw = lw_win.ii_dwcurr
//					li_cdw++
//					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
//					lw_win.ii_dwcurr = li_cdw
//					lw_pwin = lw_win
//					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
//				loop
//			end if
//			if (keyFlags=1) then		
//				ll_retv = 0
//				li_ret = -1
//				do while li_ret<0
//					li_cdw = lw_win.ii_dwcurr
//					li_cdw --
//					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
//					lw_win.ii_dwcurr = li_cdw
//					lw_pwin = lw_win
//					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
//				loop
//			end if
//		end if
//	case keydelete!		
//		ls_column = getColumnName()
//		ls_style = this.describe(ls_column+".edit.style")
//		if ls_style = "ddlb" then
//			uf_set_colval(ls_column,u_freddie.gs_null)
//			ll_retv = 1
//		end if
//end choose
//
//
//
//CHOOSE CASE key
//		
//   
//	CASE KeyI!
//		CHOOSE CASE keyflags
//			CASE 2
//				
//				
//				long li_num_prec, li_num_prec2
//				long ll_nr_row, ll_row
//				
//			
//				ll_nr_row = RowCount()
//				FOR ll_row=1 to ll_nr_row
//				   SetItem(ll_row, "riga_documento_num_riga", ll_row * 1000)
//         	NEXT
//
//				li_ret=update()
//				if li_ret<>1 then
//					messagebox("Errore!" , "Salvataggio righe non riuscito!")
//					return 
//				end if
//
//  				if (li_row - 1) >= 1 then
//					li_num_prec=this.getitemnumber((li_row ), "riga_documento_num_riga") - 1
//				else 
//					li_num_prec = 999
//				end if								
//				
//				trigger event ue_insert(0,0)
//				
//				this.setitem(this.rowcount(), "riga_documento_num_riga", li_num_prec)	
//				
//				li_ret=this.SetSort("riga_documento_num_riga A") 		
//				li_ret=this.Sort()												
//				
//				ll_nr_row= RowCount()
//				FOR ll_row= ll_nr_row to 1 step -1
//					SetItem(ll_row, "riga_documento_num_riga", ll_row)
//				NEXT	
//				
//				li_ret=update()
//				if li_ret<>1 then
//					messagebox("Errore!" , "Salvataggio righe non riuscito! #2")
//					return 
//				end if				
//				scrolltorow(li_row)
//		END CHOOSE	
//	
//	
//				
//	CASE KeyF!
//		CHOOSE CASE keyflags
//			CASE 2
//					ii_ricerca_art_fornitore = 1				
//   			   this.accepttext()
//				   ll_row=this.getrow()
//				   ls_cod=trim(this.getitemstring(ll_row,'c_articolo_cod'))
//					ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
//					select id_articolo 
//					into :ll_Art
//					from des_articolo
//					where codice = :ls_cod
//					and id_sog_commerciale=:ll_id_sog
//					and simbolo_um='XX'
//					;
//					if sqlca.sqlcode=0 then
//						string ls_stato
//						select  codice, descrizione, stato
//						into :ls_cod, :ls_des, :ls_stato 
//						from articolo 
//						where id_articolo = :ll_art;
//						
//						this.setitem(ll_row,'c_articolo_cod', ls_cod)
//						this.setitem(ll_row,'riga_documento_id_articolo', ll_art)
//						this.setitem(ll_row,'riga_documento_descrizione', ls_des)
//						
//						
//						long ll_id_uc, ll_id_um
//						select id_unita_confezione, id_unita_misura
//						into :ll_id_uc, :ll_id_um
//						from unita_confezione
//						where id_articolo = :ll_art
//						and	unita_base = 'S';		
//						
//						this.setitem(ll_row,'riga_documento_id_unita_confezione', ll_id_uc)						
//						
//						
//						
//						ii_ricerca_art_fornitore = 1	
//						post wf_inserisci_pesi_riga(0)
//						trigger event ue_set_arti_riga()	
//						
//						s_lung_peso s_lung
//						long ll_id_prof_documento
//						string ls_test
//						ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
//						select prop_lunghezza
//						into :ls_test
//						from prof_documento
//						where id_prof_documento=:ll_id_prof_documento;
//						if ls_test='S' then
//							s_lung.id_sog_commerciale=ll_id_sog	
//							s_lung.cod_articolo=ls_cod
//							openwithparm(w_ric_lung_peso_gd, s_lung)
//							s_lung=message.powerobjectparm
//						end if
//						if isvalid(s_lung)  then
//							if s_lung.cod_articolo>"" then
//								post setitem(ll_row, "riga_documento_dim_l", s_lung.lunghezza)
//							end if
//						end if
//						
//						
//						
//						ii_ricerca_art_fornitore = 0
//						
//						return 
//					else	
//						ii_ricerca_art_fornitore = 1	
//						trigger event ue_key(KeyF4!, 0)
//					end if	
//			END CHOOSE		
//		
//			
//	
//	CASE KeyG!
//		CHOOSE CASE keyflags
//			CASE 2
//				decimal ld_peso_netto 
//				char lc_tipo_ges_lotti
//				
//				SELECT tipo_ges_lotti
//				INTO	 :lc_tipo_ges_lotti
//				FROM	 pers_par_sistema
//				;
//				
//				
//				string		ls_tipo_mov
//				decimal{4}  ld_quantita
//				
//				SELECT m.tipo
//				INTO	 :ls_tipo_mov
//				FROM	 unita_confezione u, unita_misura m
//				WHERE  u.id_unita_confezione = :ll_id_unita_confezione
//				AND	 m.id_unita_misura = u.id_unita_misura
//				;
//				
//				
//				if (lc_tipo_ges_lotti = 'G' and 	(tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject = 'd_riga_documento_ordine_lotti_gd') ) then
//					
//		
//					DWObject my_dwo
//					
//					if (ls_tipo_mov = 'P') then
//						my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
//						ld_peso_netto = getitemnumber(li_row,"riga_documento_peso_netto")
//						trigger event itemchanged(li_row, my_dwo, string(ld_peso_netto))
//					else
//						
//						my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.quantita
//						ld_quantita = getitemnumber(li_row,"quantita")
//						trigger event itemchanged(li_row, my_dwo, string(ld_quantita))						
//						
//					end if
//				end if
//		END CHOOSE
//	
//	
//	
//	CASE KeyW!
//		CHOOSE CASE keyflags
//			CASE 2	
//
//			string ls_cod_barre
//			integer li_len		
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.accepttext()				
//			ls_cod_barre = getitemstring(li_row,"c_articolo_cod")
//			my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.c_articolo_cod
//			trigger event itemchanged(li_row, my_dwo, ls_cod_barre)
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetColumn("quantita")	
//		END CHOOSE
//	
//	
//	
//	CASE KeyP!
//		CHOOSE CASE keyflags
//			CASE 2
//				long ll_id_locazione_1
//				date ldt_data_registrazione
//				ll_id_locazione_1 = this.getitemnumber(li_row, "id_locazione_1")
//				ldt_data_registrazione = tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(1, "data_registrazione")
//				s_list_main my_st
//				my_st.s_modo=modo_modifica
//				my_st.s_identifica[1]="id_unita_confezione"
//				my_st.l_identifica[1]=ll_id_unita_confezione
//				my_st.l_id_varie=ll_id_locazione_1
//				my_st.s_provenienza=string(ldt_data_registrazione)
//				
//				openwithparm(w_mod_prz_cx, my_st)
//				
//		END CHOOSE
//	
//	
//	
//	
//	boolean 	lb_new=FALSE
//	boolean 	lb_last=FALSE
//	long 		ll_last_row
//
//		CASE KeyTab!
//		If keyflags = 0 then
//			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
//			lb_last = (GetRow() = RowCount())
//			if is_last_field = "riga_documento_id_tab_iva" then
//					
//				
//					if lb_last then
//					
//						idw_riga.PostEvent("ue_wiz_insert")
//					else
//	
//						idw_riga.PostEvent("ue_wiz_getfocus")
//					end if
//				RETURN -1
//			end if
//		end if
//	
//	
//END CHOOSE
//	
//return ll_retv
//
//
//
//lb_new=FALSE
//CHOOSE CASE key
//	CASE KeyTab!
//		If keyflags =0 then
//			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
//			if is_last_field = "riga_documento_id_tab_iva" AND lb_new then
//				idw_riga_tot.PostEvent("GetFocus")
//				idw_riga_tot.SetColumn("descrizione")
//				RETURN 1
//			end if
//		end if
//END CHOOSE	
//
end event

event ue_validate_row;call super::ue_validate_row;//
//long 		ll_id_tab_iva, ll_prezzo
integer	li_err_count
//decimal	ld_QTA, ld_QTA_SM, ld_QTA_UB, ld_Fatglob, ld_qta_evasa, ld_qta_evasa_un_base
//
//ld_QTA = uf_GetItemDecimal(al_row, "quantita")
//if IsNull(ld_QTA) then ld_QTA=0
//ld_QTA_SM = uf_GetItemDecimal(al_row, "qta_sconto_merce")
//if IsNull(ld_QTA_SM) then ld_QTA_SM=0
//ld_Fatglob=uf_GetItemDecimal(al_row,"fat_con_globale")
//if IsNull(ld_Fatglob) then ld_Fatglob=0
//ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
//SetItem(al_row, "qta_un_base", ld_QTA_UB)
//
//ld_qta_evasa = uf_GetItemDecimal(al_row, "qta_evasa")
//if isNull(ld_qta_evasa) then ld_qta_evasa = 0
//ld_qta_evasa_un_base = ld_qta_evasa * ld_fatGlob
//SetItem(al_row, "qta_evasa_un_base", ld_qta_evasa_un_base )
//
//
//li_err_count=0
//ll_id_tab_iva= GetItemNumber(al_row, "riga_documento_id_tab_iva")
//ll_prezzo= GetItemNumber(al_row, "prezzo")
//if not(IsNull(ll_prezzo) OR ll_prezzo =0) AND (IsNull(ll_id_tab_iva) OR ll_id_tab_iva =0) then
//	as_error_text= "Esistono righe non descrittive senza IVA. "
//	li_err_count=1
//end if
//If li_err_count > 0 then iuo_msg_log.uf_new_text(as_error_text, 3)
return li_err_count
//
end event

event ue_initial;call super::ue_initial;//date 				ld_data_prev_consegna
//
//long				ll_id_magazzino, ll_row, ll_numero, ll_id_valuta, ll_righe, ll_count, ll_nriga
//long				ll_id_listino, ll_id_caus_magazzino, ll_id_locazione, ll_id_agente, ll_test
//long il_row
//
//ll_row=rowcount()
//
//il_row=dw_1.getrow()
//
//ld_data_prev_consegna = dw_1.GetItemDate(il_row,"data_prev_consegna")
//SetItem(ll_row, "riga_documento_data_prevista_consegna", ld_data_prev_consegna)
//
//ll_nriga = GetItemNumber(1, "c_max_num")
//if isnull(ll_nriga) then ll_nriga = 0
//SetItem(ll_row, "riga_documento_num_riga", ll_nriga+1)
//
//
//ll_id_valuta=dw_1.GetItemNumber(il_row, "documento_id_valuta_des")
//
//
//SetItem(ll_row,"riga_documento_id_valuta",  ll_id_valuta)
//
//SetItem(ll_row,"riga_documento_cambio",  1)
//
//
//ll_id_caus_magazzino = dw_1.GetItemNumber(il_row, "documento_id_caus_magazzino")
//SetItem(ll_row, "riga_documento_id_caus_magazzino",ll_id_caus_magazzino)
//
//
//
//long ll_locazione, ll_locazione2
//ll_locazione=dw_1.GetItemNumber(il_row, "documento_id_locazione_1")
//
//SetItem(ll_row, "id_locazione_1",ll_locazione)
//
//ll_locazione2=dw_1.GetItemNumber(il_row, "documento_id_locazione_2")
//SetItem(ll_row, "id_locazione_2",ll_locazione2)
//
//
//ll_id_agente = dw_1.GetItemNumber(il_row, "id_gruppo_agenti")
//SetItem(ll_row, "id_gruppo_agenti",ll_id_agente)
////mm per silver dreams uso per galvanica
////ll_id_agente = dw_1.GetItemNumber(il_row, "id_gruppo_agenti_2")
////SetItem(ll_row, "riga_documento_id_gruppo_agenti_2",ll_id_agente)
////uf_set_mask_riga()
//
//
//long ll_id_r_lotto, ll_riga, ll_id_doc
//string ls_flag_comm
////if isValid(ids_lotti) or isValid(ids_scar_lotto) then
////	select prog_materie_prime
////	into :ll_id_r_lotto
////	from prog_lotti;
////	if ll_id_r_lotto<1 then 
////		messagebox("Errore", "Riferimento per gestione lotti non creato!")
////		deleterow(ll_row)
////		return
////	else
////		ll_id_r_lotto++
////		update prog_lotti
////		set prog_materie_prime = :ll_id_r_lotto;
////		if sqlca.sqlnrows>0 then
////			ll_riga=tab_1.tabpage_2.dw_riga_documento_ordine_gd.RowCount()
////			tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_riga,"id_riga_lotto",ll_id_r_lotto)
////			commit;	
////		else
////			messagebox("Errore", "Riferimento per gestione lotti non creato!")
////			deleterow(ll_row)
////			return
////		end if
////	end if
////end if
////if isValid(ids_lotti) then	
////	ll_riga=ids_lotti.InsertRow(0)
////	ids_lotti.SetItem(ll_riga,"numero",ll_id_r_lotto)
////	ids_lotti.SetItem(ll_riga,"attivo",'S')
////	select commerciale
////	into :ls_flag_comm
////	from par_sistema;
////	if sqlca.sqlcode=0 then
////		if ls_flag_comm="S" then
////			ids_lotti.SetItem(ll_riga,"tipo_lotto",'Z')
////		else
////			ids_lotti.SetItem(ll_riga,"tipo_lotto",'M')
////		end if
////	else
////		messagebox("Errore", "parametro 'commerciale' non trovato in par_sistema")
////	end if
////end if
//
////wf_tipo_prezzi()
end event

event ue_set_search;call super::ue_set_search;//string ls_riga_descrittiva
//long ll_id_art
//
//
//this.Object.DataWindow.Selected.Mouse = "No"
//
//CHOOSE CASE as_nomecol
//	CASE "riga_documento_descrizione"
//		is_ricpar.s_filter_value = as_valcol 
//		
//		if (ii_ricerca_art_fornitore = 1) then
//			is_search_window = "w_des_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "des_articolo_descrizione"
//		else
//			is_search_window = "w_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "articolo_descrizione" 
//		end if
//		
//		is_ricpar.b_asneeded=TRUE
//	CASE "c_articolo_cod"
//		is_ricpar.s_filter_value = trim(as_valcol) 
//		is_ricpar.l_id_doc=idw_gen.getitemnumber(1, "id_documento")
//		
//		if (ii_ricerca_art_fornitore = 1) then
//			is_search_window = "w_des_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "des_articolo_codice"
//		else
//			is_search_window = "w_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "articolo_codice" 
//		end if
//		
//		is_ricpar.b_asneeded=TRUE
//END CHOOSE
//
//
end event

event ue_use_search;//long ll_id_articolo, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value, ll_id_tab_iva
//decimal ldc_ret_value
//date ld_comp
//string ls_simbolo
//dwItemStatus	ldw_status
//string ls_utilizzabile
//decimal{4} ld_peso_lordo, ld_peso_netto
//long row, ll_id, ll_id_uc
//integer li_riga_fine, li_riga_inizio, i, li_ret
//string ls_um
//long ll_soggetto
//
//
//ll_row= GetRow()
//
//long	ll_id_art_o
//ll_id_art_o = this.getitemnumber(ll_row, "riga_documento_id_articolo")
//if isnull(ll_id_art_o) then ll_id_art_o = 0
//
//this.Object.DataWindow.Selected.Mouse = "Yes"
//
//CHOOSE CASE as_nomecol
//	CASE "c_articolo_cod"
//		
//		
//		
//		
//		
//		
//		
//			ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
//			LI_RET=wf_controlla_utilizzabile(ll_id_articolo)
//			IF LI_RET=-1 THEN
//				RETURN
//			END IF
//		
//		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
//		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
//		uf_set_colval("riga_documento_descrizione", is_ricpar.s_ausil_value[1])
//		uf_set_colval("c_articolo_des", is_ricpar.s_ausil_value[1])
//		
//		uf_set_colval("articolo_stato", is_ricpar.s_ausil_value[2])
//		
//		
//		uf_set_colval("usimbolo", is_ricpar.s_ausil_value[3])
//		uf_set_colval("udescrizione", is_ricpar.s_ausil_value[4])
//		uf_set_colval("unita_misura_b_simbolo", is_ricpar.s_ausil_value[5])
//		uf_set_colval("unita_misura_b_descrizione", is_ricpar.s_ausil_value[6])
//		uf_set_colval("conversione_peso_comune", is_ricpar.s_ausil_value[7])
//		uf_set_colval("conversione_volume_comune", is_ricpar.s_ausil_value[8])
//		uf_set_colval("riga_documento_id_unita_confezione", is_ricpar.s_ausil_value[9])
//		
//		
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then event ue_set_arti_riga()
//		
//		post event ue_set_contropartita()
//		post event ue_set_calc_riga(ll_row)
//		ldw_status = GetItemStatus( ll_row,0,Primary! )
//		if ldw_status = New! or ldw_status = NewModified! then
//			post uf_scaglione_provvigione() 
//		end if	
//		
//		post	wf_inserisci_pesi_riga(0)
//		
//		li_riga_inizio=ll_row
//		li_riga_fine=ll_row
//		wf_impongo_magazzino(li_riga_inizio, li_riga_fine)
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then post wf_cal_costi()
//		
//		
//		
//		ll_id_uc=long(is_ricpar.s_ausil_value[9])
//		select tipo,simbolo
//		into :ls_um,:ls_simbolo
//		from unita_confezione, unita_misura
//		
//		where (unita_confezione.id_unita_confezione=:ll_id_uc) and
//		(unita_misura.id_unita_misura=unita_confezione.id_unita_misura);
//		
//		uf_set_colval("tipo_um", ls_um)	
//		if POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO')>0 THEN 
//			uf_set_colval("simbolo_mov", ls_simbolo)		
//		end if
//		
//		
//		
//		
//		
//		
//		
//		
//
//		
//		if is_prof_dispo='C' or is_prof_dispo='B' then post uf_pre_blocca_dispo(this.getrow())
//		
//
//
//	
//
//	CASE "riga_documento_descrizione"
//		ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
//		LI_RET=wf_controlla_utilizzabile(ll_id_articolo)
//		IF LI_RET=-1 THEN
//				
//				RETURN
//			END IF
//		
//		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
//		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
//		uf_set_colval("c_articolo_cod", is_ricpar.s_ausil_value[1])
//		uf_set_colval("c_articolo_des", is_ricpar.s_main_value)
//		
//		
//		uf_set_colval("articolo_stato", is_ricpar.s_ausil_value[2])
//		
//		
//		
//		uf_set_colval("usimbolo", is_ricpar.s_ausil_value[3])
//		uf_set_colval("udescrizione", is_ricpar.s_ausil_value[4])
//		uf_set_colval("unita_misura_b_simbolo", is_ricpar.s_ausil_value[5])
//		uf_set_colval("unita_misura_b_descrizione", is_ricpar.s_ausil_value[6])
//		uf_set_colval("conversione_peso_comune", is_ricpar.s_ausil_value[7])
//		uf_set_colval("conversione_volume_comune", is_ricpar.s_ausil_value[8])
//		uf_set_colval("riga_documento_id_unita_confezione", is_ricpar.s_ausil_value[9])
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then event ue_set_arti_riga()
//		
//		post event ue_set_contropartita()
//		post event ue_set_calc_riga(ll_row)
//		ldw_status = GetItemStatus( ll_row,0,Primary! )
//		if ldw_status = New! or ldw_status = NewModified! then
//			post uf_scaglione_provvigione() 
//		end if	
//		
//		post wf_inserisci_pesi_riga(0)
//		
//		li_riga_inizio=ll_row
//		li_riga_fine=ll_row
//		wf_impongo_magazzino(li_riga_inizio, li_riga_fine)
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then post wf_cal_costi()
//		
//		
//		select tipo
//		into :ls_um
//		from unita_confezione, unita_misura
//		where (unita_confezione.id_articolo=:is_ricpar.s_id_seg_value[1])and
//		(unita_misura.id_unita_misura=unita_confezione.id_unita_misura);
//		uf_set_colval("simbolo_mov", ls_um)	
//		
//		
//		
//		
//		
//		
//		
//		
//		if is_prof_dispo='C' or is_prof_dispo='B' then post uf_pre_blocca_dispo(this.getrow())
//
//		
//		
//END CHOOSE
//
//if IsValid(ids_lotti) then
//	ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
//	CHOOSE CASE as_nomecol
//	CASE "c_articolo_cod"
//		row=getitemnumber(ll_row,"id_riga_lotto")
//		i= ids_lotti.find("numero = "+string(row),1, ids_lotti.rowcount())
//		if i>0 then	
//			li_ret=ids_lotti.SetItem(i,"id_articolo", ll_id_articolo)
//			if li_ret<>1 then messagebox("Errore", "Non settato id_articolo in lotto")
//		else
//			messagebox("Errore","Lotto non trovato")
//		end if
//		
//		if this.dataobject <> "d_riga_documento_ordine_ritorno_gd" then wf_carico_lotti(ll_row, ll_id_articolo)
//		
//	CASE "riga_documento_descrizione"
//		row=getitemnumber(ll_row,"id_riga_lotto")
//		i= ids_lotti.find("numero = "+string(row),1, ids_lotti.rowcount())
//		if i>0 then	
//			ids_lotti.SetItem(i,"id_articolo",ll_id_articolo)
//		else
//			messagebox("Errore","Lotto non trovato")
//		end if
//		
//		if this.dataobject <> "d_riga_documento_ordine_ritorno_gd" then wf_carico_lotti(ll_row, ll_id_articolo)
//		
//	end choose
//end if
//
end event

event ue_itemerror;call super::ue_itemerror;long ll_ret_value

SetNull(ll_ret_value)
CHOOSE CASE adwo_dwo.name
	CASE "sconto"
		MessageBox(is_title, "Ricontrollare lo sconto immesso.")
		ll_ret_value=2
END CHOOSE
return ll_ret_value
end event

type dw_7 from udw_base within w_correggi_bollettina_2
boolean visible = false
integer x = 1824
integer y = 1516
integer width = 2437
integer height = 828
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Pronto Inseriti"
string dataobject = "d_doc_segna_passati"
boolean hscrollbar = true
boolean livescroll = false
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if


end event

event rowfocuschanged;call super::rowfocuschanged;//long ll_id_sog
//
//
//
//
//
//if currentrow>0 then
//	ll_id_sog=getitemnumber(currentrow, "id_sog_commerciale")
//	dw_5.setitem(1, "id_sog_com", ll_id_sog)
//end if
//
//
end event

event sqlpreview;call super::sqlpreview;//string ls_sql
//
//integer i
//
//ls_sql=sqlsyntax
//
//	
//ls_sql=ls_sql + " and registro.tipo_registro='OV' "
//	
//
//setsqlpreview(ls_sql)
end event

event rbuttondown;call super::rbuttondown;long ll_id_doc,ll_num_prog,ll_riga_stampa
long ll_id_sog, ll_id_bollettina, ll_righe_trovate
string ls_num_bollettina
datastore ds_rec_bol
integer i

if row>0 then
	selectrow(0, false)
	selectrow(row, not(isselected(row)))
	scrolltorow(row)
	
	ll_id_doc=getitemnumber(row, "id_documento")
	
	dw_2.retrieve(ll_id_doc)
	

ds_rec_bol=create datastore
ds_rec_bol.dataobject="ds_recupera_bollettine"
ds_rec_bol.settransobject(sqlca)
if dw_2.rowcount()>0 then
		ls_num_bollettina="%"+getitemstring(row, "num_documento")+"%"
		ll_righe_trovate=ds_rec_bol.retrieve(ls_num_bollettina)
		if ll_righe_trovate>0 then
			messagebox("Attenzione!", "Bollettina già esistente")
		end if
		for i=1 to ll_righe_trovate
			ll_id_doc=ds_rec_bol.getitemnumber(i, "id_documento")
			ll_num_prog=ds_rec_bol.getitemnumber(i, "num_progressivo")
			ls_num_bollettina=ds_rec_bol.getitemstring(i, "num_documento")
			
			//inserisco in dw per stampa bollettine create
			ll_riga_stampa=dw_6.insertrow(0)
			dw_6.setitem(ll_riga_stampa, "id_documento", ll_id_doc)
			dw_6.setitem(ll_riga_stampa, "num_progressivo", ll_num_prog)
			dw_6.setitem(ll_riga_stampa, "data_registrazione", today())
			dw_6.setitem(ll_riga_stampa, "pezzi", 0)
			dw_6.setitem(ll_riga_stampa, "num_doc", ls_num_bollettina)
			
		next
//			ds_rec_bol.rowscopy(1, ll_righe_trovate, primary!, dw_6, 1, primary!)
//		end if
		
	end if
end if
	destroy ds_rec_bol
	
	
	
end event

type dw_9 from u_dw_master_main within w_correggi_bollettina_2
event type integer ue_setta_prezzo ( )
event type string ue_get_nrcolval ( integer al_column )
event type long ue_setta_un_conf ( )
event ue_setta_rif_des_agg ( )
event ue_set_arti_riga ( )
event ue_set_ucon_riga ( )
event type integer ue_set_calc_riga ( long al_row )
event ue_set_comp_riga ( )
event type integer ue_wiz_insert ( )
event ue_wiz_getfocus ( )
event type integer ue_set_calc_tot_riga ( long al_row,  decimal adc_quantita,  decimal adc_prezzo_netto,  boolean ab_calc_sconto )
event ue_set_contropartita ( )
event ue_lb_down pbm_lbuttondown
event type integer ue_rec_prezzo ( long row,  decimal qta )
event ue_post_itemchanged ( long al_riga,  string as_colonna,  string as_message )
string tag = "Righe di Documento"
boolean visible = false
integer x = 535
integer y = 1564
integer width = 951
integer height = 304
integer taborder = 40
string dragicon = "Asterisk!"
boolean bringtotop = true
string dataobject = "d_orafo_riga_doc_ord_ra_id_riga_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event type integer ue_setta_prezzo();
long 			ll_id_un_confezione, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value,il_row
decimal 		ldc_ret_value, ldc_fat_conversione, ldc_molteplicita, ldc_quantita, ldc_fattore, ldc_totale
date 			ld_comp
string 		ls_tipo_conversione, ls_sconto

ll_row= GetRow()
il_row=dw_1.getrow()
ll_id_un_confezione= GetItemNumber(ll_row, "riga_documento_id_unita_confezione")
ll_id_listino=GetItemNumber(ll_row, "riga_documento_id_listino")
ld_comp= dw_1.GetItemDate(il_row, "data_registrazione")

ls_sconto = uf_get_colval("sconto")
//ldc_ret_value=uf_calcola_prezzo(ls_sconto, ldc_ret_value, uf_GetItemDecimal(ll_row, "quantita"))
if not IsNull(ldc_ret_value) then 
	
	SetItem(ll_row,"riga_documento_prezzo_netto",Truncate(ldc_ret_value, 0))
	ldc_quantita=uf_GetItemDecimal(ll_row, "quantita")
	if GetItemString(ll_row,"c_unita_conf_tipo_conversione") = 'D' then
		ldc_fattore=1 / uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	else
		ldc_fattore=uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	end if
	ldc_molteplicita=uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
	if IsNull(ldc_molteplicita) then ldc_molteplicita= 0
	ldc_totale= ldc_quantita * Truncate(ldc_ret_value, 0) * ldc_fattore * ldc_molteplicita
	
	SetItem(ll_row,"qta_un_base", ldc_totale)
end if

return ll_ret_value

end event

event ue_setta_rif_des_agg;
end event

event ue_set_arti_riga();//
//
//long				ll_num_colli
//decimal			ld_quantita
//
//long 				ll_id_articolo, ll_id_lingua, ll_id_linguaggio
//long				ll_id_sog_commerciale, ll_id_unita_confezione, ll_id_tab_iva, ll_row
//string			ls_tipo_iva
//
//
//ll_row=GetRow()
//POST WF_METTI_DESCRIZIONE(LL_ROW)
//ll_id_sog_commerciale = idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
//ll_id_articolo = GetItemNumber(ll_row, "riga_documento_id_articolo")
//
//ll_id_unita_confezione = long(uf_get_colval("riga_documento_id_unita_confezione"))	
//
//if (isnull(ll_id_unita_confezione) or ll_id_unita_confezione <= 0) then
//	
//	SELECT id_unita_confezione, num_colli
//	INTO 	 :ll_id_unita_confezione, :ll_num_colli  
//	FROM 	 unita_confezione  
//	WHERE  id_articolo = :ll_id_articolo
//	AND    unita_base = 'S'
//	;
//	
//	if (sqlca.sqlcode = -1) then
//		messagebox("dberror", sqlca.sqlerrtext)
//	end if	
//end if
//
//SELECT num_colli
//INTO 	 :ll_num_colli  
//FROM 	 unita_confezione  
//WHERE  id_unita_confezione = :ll_id_unita_confezione
//;
//
//if (sqlca.sqlcode = -1) then
//	messagebox("dberror", sqlca.sqlerrtext)
//end if
//
//
//if (not IsNull(ll_id_unita_confezione)) and (ll_id_unita_confezione > 0) then
//	
//
//	if (not isnull(ld_quantita) and ld_quantita > 0) then ll_num_colli=ll_num_colli*ld_quantita
//	uf_set_colval("riga_documento_num_colli", string(ll_num_colli))
//
//	
//	triggerevent("ue_set_ucon_riga")
//end if
//
//
//
//
//
//SELECT "tab_iva"."tipo_iva", "tab_iva"."id_tab_iva"
//	INTO :ls_tipo_iva, :ll_id_tab_iva
//	FROM "dba"."sog_commerciale", "dba"."tab_iva"  
//	WHERE ( "tab_iva"."id_tab_iva" = "sog_commerciale"."id_tab_iva" ) and  
//			( ( "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) ) ;
//
//if ls_tipo_iva > '' then
//	
//	uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
//else
//	
//	SELECT "articolo"."id_tab_iva"  
//		INTO :ll_id_tab_iva  
//		FROM "dba"."articolo"
//		WHERE "articolo"."id_articolo" = :ll_id_articolo ;
//
//	if (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
//		
//		SELECT "cat_com_articolo"."id_tab_iva"  
//			INTO :ll_id_tab_iva  
//			FROM "dba"."articolo",   
//			"cat_com_articolo"  
//			WHERE ( "cat_com_articolo"."id_cat_com_articolo" = "articolo"."id_cat_com_articolo" ) and  
//			( ( "articolo"."id_articolo" = :ll_id_articolo ) )   ;
//	end if
//	if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
//		uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
//	end if
//end if
//
//tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.event ue_vis_esi_disponibilita()
//wf_cal_costi()	
end event

event ue_set_ucon_riga();


long			ll_id_unita_conf, ll_num_colli
decimal		ld_molt, ld_fatconv, ld_fatglob, ld_qta_proposta, ld_qta
string		ls_tipoconv

ll_id_unita_conf = long(uf_get_colval("riga_documento_id_unita_confezione"))
ld_qta = dec(uf_get_colval("quantita"))

SELECT fat_conversione, molteplicita, tipo_conversione, num_colli
INTO	 :ld_fatconv, :ld_molt, :ls_tipoconv, :ll_num_colli
FROM	 unita_confezione
WHERE  id_unita_confezione = :ll_id_unita_conf
;

if (SQLCA.SQLCODE = 0) then
	
	

	if ( ld_qta = 0 or isnull(ld_qta) ) then
		

		
		long 		ll_id_prof_documento
		ll_id_prof_documento = dw_1.getitemnumber(dw_1.getrow(), "id_prof_documento")
		
		SELECT quantita_prop_riga
		INTO	 :ld_qta_proposta
		FROM	 prof_documento
		WHERE  id_prof_documento = :ll_id_prof_documento
		;
		
		
		if (SQLCA.SQLCODE = 0) then
			if (not isnull(ld_qta_proposta)) and (ld_qta_proposta > 0) then
				uf_set_colval("quantita",string(ld_qta_proposta))
				
				if (ll_num_colli > 0) and (not isnull(ll_num_colli)) then
					ll_num_colli = ll_num_colli * ld_qta_proposta
					uf_set_colval("riga_documento_num_colli",string(ll_num_colli))
				end if
				
			end if
		end if
	end if

	uf_set_colval("riga_documento_fat_con_unita_base",string(ld_fatconv))
	uf_set_colval("c_unita_conf_tipo_conversione", string(ls_tipoconv))
	uf_set_colval("c_unita_conf_molteplicita", string(ld_molt))
	If ls_tipoconv = "D" then
		uf_set_colval("fat_con_globale", string(ld_fatconv / ld_molt))
	else
		uf_set_colval("fat_con_globale", string(ld_fatconv * ld_molt))		
	end if

	
	long ll_row
	ll_row = getrow()
	
	
	
	if (not isnull(ld_qta_proposta)) and (ld_qta_proposta > 0) then
		
		dwobject	my_dwo
		my_dwo = this.object.quantita
		this.trigger event itemchanged(ll_row, my_dwo, string(ld_qta_proposta))		
		
	end if
	
	
	
end if




end event

event type integer ue_set_calc_riga(long al_row);//
//
//decimal		ld_QTA_UB, ld_QTA, ld_QTA_SM, ld_Prezzo_Netto, ld_Sconti, ld_Totale_Riga
//decimal		ld_Cambio, ld_Sconto_Riga, ld_QTA_Evasa_UB, ld_Qta_Evasa, lcd_null
//decimal		ld_Prezzo, ld_Quantita, ld_Totale_Riga_Lire, ld_Qta_Effettiva, ld_Totale_Riga_val
//string		ls_Sconto, ls_tipoconv, ls_tipo_arrotondamento
//decimal		ld_fatconv, ld_fatglob, ld_molt, ld_cambio_riga, ld_cambio_documento
//long			ll_row, ll_id_valuta_riga, ll_valuta_documento, ll_nr_cifre_arrot
//
//
//if al_row>0 then
//	ll_row= al_row
//	
//	SetNull(lcd_null)
//	ls_tipoconv = GetItemString(ll_row,"c_unita_conf_tipo_conversione")
//	ld_fatconv = uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
//	ld_molt =uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
//	
//	
//	ld_prezzo=getitemdecimal(al_row, "prezzo")
//	
//	
//	
//	if ls_tipoconv = "D" then
//		if ld_fatconv <> 0 then
//			ld_fatglob = 1/ld_fatconv
//		else
//			ld_fatglob = 0
//		end if
//	else
//		ld_fatglob = ld_fatconv
//	end if
//	ld_fatglob = ld_fatglob * ld_molt
//	SetItem(ll_row,"fat_con_globale",string(ld_fatglob))
//	
//	
//	
//	
//	ls_Sconto= GetItemString(ll_row, "sconto")
//	ld_QTA = uf_GetItemDecimal(ll_row, "quantita")
//	if IsNull(ld_QTA) then ld_QTA=0
//	if uf_calcola_prezzo(ls_Sconto, 1000000, 1) = 0 then
//	
//		ld_QTA_SM= 0 
//		SetItem(ll_row, "qta_sconto_merce", 0)
//	else
//		ld_QTA_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
//		if IsNull(ld_QTA_SM) then ld_QTA_SM=0
//	end if
//	
//	ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
//	SetItem(ll_row, "qta_un_base", ld_QTA_UB)
//	
//	ld_Qta_Evasa= uf_GetItemDecimal(ll_row, "qta_evasa")
//	if IsNull(ld_Qta_Evasa) then ld_Qta_Evasa=0
//	
//	ld_QTA_Evasa_UB = ld_Qta_Evasa * ld_FatGlob
//	SetItem(ll_row, "qta_evasa_un_base", ld_QTA_Evasa_UB)
//	ld_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
//	if IsNull(ld_Prezzo) then ld_prezzo = 0
//	
//	ll_valuta_documento= idw_gen.GetItemNumber(il_row, "documento_id_valuta_des")
//	ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")
//	
//	SELECT "valuta"."cifra_arrotondamento",
//		"valuta"."tipo_arrotondamento"
//		INTO :ll_nr_cifre_arrot ,
//				:ls_tipo_arrotondamento
//		FROM "dba"."valuta"  
//		WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
//	
//	if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
//	ld_cambio_riga= GetItemNumber(ll_row, "riga_documento_cambio")
//	if IsNull(ld_cambio_riga) then ld_cambio_riga=1
//	
//	ld_Prezzo_Netto= uf_calcola_prezzo(ls_Sconto, ld_Prezzo, 1)
//	
//	decimal ld_importo_sconto_riga
//	string ls_um, ls_tipo
//	long ll_id_un_conf
//	decimal ld_peso_netto
//	ld_importo_sconto_riga=getitemdecimal(ll_row, "riga_documento_sconto_riga")
//	ll_id_un_conf=getitemnumber(al_row, "riga_documento_id_unita_confezione")
//	select simbolo, tipo
//	into :ls_um, :ls_tipo
//	from unita_confezione, unita_misura
//	where (unita_confezione.id_unita_confezione=:ll_id_un_conf) 
//	and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
//	
//	ld_peso_netto=getitemdecimal(al_row, "riga_documento_peso_netto")
//	
//	
//	
//	if (ld_qta > 0 and ld_importo_sconto_riga > 0) then
//			ld_importo_sconto_riga=ld_importo_sconto_riga/ld_qta
//	end if
//	if (ld_importo_sconto_riga > 0) then
//		ld_Prezzo_Netto=ld_Prezzo_Netto - ld_importo_sconto_riga
//	end if
//			
//	
//	
//	ld_Prezzo_Netto=f_Round(ld_Prezzo_Netto ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
//	
//	if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0
//	
//	SetItem(ll_row, "riga_documento_prezzo_netto",ld_Prezzo_Netto)
//	
//	event ue_set_calc_tot_riga(ll_row, lcd_null, ld_Prezzo_Netto, FALSE)
//	
//end if
return 0
//
//
end event

event ue_set_comp_riga;
	

end event

event type integer ue_wiz_insert();//
//long ll_last_row
//SetFocus()
//SetRedraw(FALSE)
//TriggerEvent("ue_insert")
//ll_last_row= idw_riga.RowCount()
//SetRow(ll_last_row)
//SetColumn("c_articolo_cod")
//SetRedraw(TRUE)
return 0
//
end event

event ue_wiz_getfocus();//
//long ll_current_row
//
//SetFocus()
//ll_current_row= idw_riga.GetRow()
//SetRow(ll_current_row)
//SetColumn("c_articolo_cod")
//
//
//
end event

event type integer ue_set_calc_tot_riga(long al_row, decimal adc_quantita, decimal adc_prezzo_netto, boolean ab_calc_sconto);//
//long			ll_row, ll_nr_cifre_arrot, ll_id_valuta_riga, ll_valuta_documento
//string		ls_tipo_arrotondamento, ls_tipo_Arr
//decimal		ldc_sconto_riga, ldc_totale_riga, ldc_Totale_Riga_val, ldc_Prezzo, ldc_Sconto
//decimal		ldc_cambio, ldc_totale_riga_lire, adc_quantita_SM, adc_quantita_Effettiva
//long			ll_cifra_arr
//ll_row=al_row
//
//if ll_row>0 and  not isnull(ll_row) then
//	if IsNull(adc_quantita) then adc_quantita= uf_GetItemDecimal(ll_row, "quantita")
//	
//	if IsNull(adc_Prezzo_Netto) then	adc_Prezzo_Netto= uf_GetItemDecimal(ll_row, "riga_documento_prezzo_netto")
//	
//	if not IsNull(adc_Prezzo_Netto) then 
//		if IsNull(adc_quantita) then adc_quantita=0
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		ll_valuta_documento= idw_gen.GetItemNumber(1, "documento_id_valuta_des")
//		ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")
//		
//		SELECT "valuta"."cifra_arrotondamento",
//			"valuta"."tipo_arrotondamento"
//			INTO :ll_nr_cifre_arrot ,
//					:ls_tipo_arrotondamento
//			FROM "dba"."valuta"  
//			WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
//		
//		if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
//		
//		ldc_cambio= GetItemNumber(ll_row, "riga_documento_cambio")
//		
//		if IsNull(ldc_cambio) then ldc_cambio=1
//		
//				
//		
//		adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
//			if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
//			adc_quantita_Effettiva= adc_quantita 
//
//		
//		long ll_id_art
//		decimal ld_peso
//		
//		ll_id_art=GetItemNumber(al_row,"riga_documento_id_unita_confezione")
//		ld_peso=GetItemDecimal(al_row,"riga_documento_peso_netto")
//		
//		ldc_Totale_Riga= wf_trova_prezzo(ll_id_art, adc_quantita_Effettiva, ld_peso, adc_Prezzo_Netto)
//		
//		
//		
//		
//		select cifra_arrotondamento, tipo_arrotondamento
//		into   :ll_cifra_arr, :ls_tipo_arr
//		from   valuta
//		where  id_valuta = :al_id_val_az;
//		
//		if (sqlca.sqlcode = -1) then messagebox("dberror", sqlca.sqlerrtext)
//		
//		
//		
//		
//		
//		
//		ldc_Totale_Riga= f_Round(ldc_Totale_Riga, ll_cifra_arr, "M")
//		
//		
//		SetItem(ll_row, "tot_riga_val_riga",ldc_Totale_Riga)
//		
//		
//		
//		
//			adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
//			if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
//			adc_quantita_Effettiva= adc_quantita + adc_quantita_SM
//		
//		if not(IsNull(adc_quantita_Effettiva) OR adc_quantita_Effettiva=0) then SetItem(ll_row, "riga_documento_val_attribuito",ldc_Totale_Riga / adc_quantita_Effettiva)
//		
//		if IsNull(ldc_Cambio) OR ldc_Cambio=0 then ldc_Cambio=1		
//		ldc_Totale_Riga_Lire= ldc_Totale_Riga * ldc_Cambio
//		
//		
//		
//		SetItem(ll_row, "tot_riga_val_az",f_round(ldc_Totale_Riga_Lire,ll_cifra_arr, "M"))
//
//		if ll_id_valuta_riga = ll_valuta_documento then
//			SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga)
//		else
//			
//			//if IsNull(idc_cambio) then idc_cambio=0
//			//ldc_Totale_Riga_val= ldc_Totale_Riga_Lire / idc_cambio
//			ldc_Totale_Riga_val= ldc_Totale_Riga_Lire / ldc_cambio
//			
//			if IsNull(il_arrotondamento) then il_arrotondamento=0
//			
//			
//			ldc_Totale_Riga_val= f_round(ldc_Totale_Riga_val, ll_cifra_arr, "M")
//			
//			
//			
//			SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga_val)
//		end if
//	
//	else
//		adc_Prezzo_Netto=0
//		SetItem(ll_row, "tot_riga_val_riga",0)
//		SetItem(ll_row, "tot_riga_val_doc",0)
//		SetItem(ll_row, "tot_riga_val_az",0)
//	end if
//	If ab_calc_sconto then
//		ldc_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
//		If not IsNull(ldc_Prezzo) OR ldc_Prezzo <> 0 then 
//			ldc_Sconto= (ldc_Prezzo - adc_prezzo_netto) * 100 / ldc_Prezzo
//			ldc_Sconto= Round(ldc_Sconto , 2)
//			SetItem(ll_row, "sconto", String(ldc_Sconto))
//		end if
//		
//	end if
//end if
return 0
//
//
//
end event

event ue_set_contropartita();//
//
//long		ll_row, ll_id_articolo, ll_id_contropartita, ll_id_causale
//long		ll_id_sog_commerciale, ll_id_agente, LL_IDAZ
//u_setta_campi_documento u_cerca_cpt
//u_cerca_cpt=create u_setta_campi_documento
//ll_id_sog_commerciale= idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
//ll_id_agente=  idw_gen.GetItemNumber(il_row, "id_gruppo_agenti")
//ll_row= GetRow()
//ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
//ll_id_causale=GetItemNumber(ll_row, "riga_documento_id_caus_magazzino")
//
//ll_id_contropartita= wf_calcola_cpt(ll_id_sog_commerciale, ll_id_agente, ll_id_articolo, ll_id_causale)
//
//
//
//SetItem(ll_row, "riga_documento_id_conto", ll_id_contropartita)
//
end event

event ue_lb_down;//
//long			ll_row, ll_pos
//string		ls_dati, ls_riga
//
//If ib_rinumera_righe then
//	ll_row = 0
//	ls_dati = this.GetObjectAtPointer()
//	ll_pos = pos(ls_dati,"~t")
//	if ll_pos>0 then
//		ls_riga = mid(ls_dati,ll_pos+1)
//		il_drag_row = Long(ls_riga)
//	end if
//	if (il_drag_row > 0 ) then
//		This.ScrollToRow(il_drag_row)
//		This.Drag(begin!)
//	else
//		this.Drag(end!)
//	end if
//end if
//
end event

event type integer ue_rec_prezzo(long row, decimal qta);//
//
//integer ll_return, ll_riga_corrente
//string ls_tras_mezzo
//long    ll_id_trasporto 
//
//
//ls_tras_mezzo=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemstring(1, "tras_mezzo")
//ll_id_trasporto=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber(1, "id_tipo_trasporto_des") 
//
//ll_return = f_rec_prezzo(row, qta, tab_1.tabpage_1.dw_documento_ordine_ff, this, ls_tras_mezzo, ll_id_trasporto)
//
//if (ll_return = 1) then
//	ll_riga_corrente = getrow()
//	post event ue_set_calc_riga(ll_riga_corrente)
//end if
//
return 1
end event

event ue_post_itemchanged;
if as_message >"" then
	messagebox("Attenzione!", as_message)
end if
setitem(al_riga, as_colonna, 0)
setcolumn(as_colonna)
end event

event clicked;string ls1_nomedwo, ls1_column, ls1_tipodwo, ls_riga_descrittiva, ls_art
long ll_id_art, ll_id_cat_codifica
ls1_nomedwo = dwo.name
ls1_tipodwo = dwo.type
if ((ls1_tipodwo="bitmap") and (right(ls1_nomedwo,3)="_sw")) then
	ls1_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 3)
	if ls1_column="c_articolo_cod" or ls1_column="riga_documento_descrizione" then
		
			ls_riga_descrittiva=getitemstring(getrow(), "riga_documento_descrizione")
			ll_id_art=this.getitemnumber(getrow(),"riga_documento_id_articolo")
			if ls_riga_descrittiva>"" and not (isnull(ls_riga_descrittiva)) and  isnull(ll_id_art) then
				messagebox("Attenzione!", "Impossibile inserire un articolo in una riga descrittiva.~r~n"+&
				"Cancellare la riga e inserirne una nuova")
				return 
			end if	
		
	end if
end if

call super::clicked

if dwo.name="distinta" then
	s_list_main ls_list_distinta
	long ll_id_dis,ll_art
	ll_art=this.getitemnumber(row,"riga_documento_id_articolo")
	select id_distinta
	into :ll_id_dis
	from distinta
	where id_articolo=:ll_art;
	if sqlca.sqlcode=0 then
		ls_list_distinta.s_modo = modo_modifica
		ls_list_distinta.s_SQL_ident[1] = "distinta.id_distinta"
		ls_list_distinta.s_identifica[1]="id_distinta"
		ls_list_distinta.l_identifica[1]=ll_id_dis
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
	else 
		ls_list_distinta.s_identifica[1]="id_articolo"
		ls_list_distinta.l_identifica[1]=ll_art
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
	end if
end if



	
end event

event constructor;call super::constructor;

this.Object.c_riga_valida.width = 0
this.Object.c_evasione.width = 0
If FileExists ("Arr1.cur") then this.Object.DataWindow.Pointer="Arr1.cur"




end event

event dberror;
choose case sqldbcode
	case -196
		messagebox("Salvataggio fallito!", "Si sta tentando di inserire una riga documento~r~n"&
		+"con numero riga già esistente")
		return 1
	case -99999
		messagebox("Salvataggio fallito!", "Per movimentare un articolo occorre~r~n"&
		+"inserire la quantità o il peso (Legato).")
		return 1
	case else
		call super::dberror
end choose

end event

event doubleclicked;

//if string(dwo.name) ="c_articolo_cod" and cbx_cod_barre.checked then
//	return
//	
//
//else
	call Super::doubleClicked
//end if



end event

event dragdrop;call super::dragdrop;
long		ll_drag_num_riga, ll_drop_num_riga

//If ib_rinumera_righe then
//	If not(IsNull(il_drag_row) OR IsNull(row) OR il_drag_row <=0  OR row<=0 OR il_drag_row=row) then
//		this.SetRedraw(FALSE)
//		ll_drag_num_riga=GetItemNumber(il_drag_row,"riga_documento_num_riga")
//		ll_drop_num_riga=GetItemNumber(row,"riga_documento_num_riga")
//		SetItem(il_drag_row,"riga_documento_num_riga", ll_drop_num_riga)
//		SetItem(row,"riga_documento_num_riga", ll_drag_num_riga)
//		SetSort("riga_documento_num_riga A") 
//		Sort()
//	end if
//end if
//this.Drag(end!)
//If not (IsNull(row) Or row=0) then ScrollToRow(row)
//this.SetRedraw(TRUE)
end event

event editchanged;
end event

event getfocus;call super::getfocus;


end event

event itemchanged;//decimal 		ldc_prezzo, ldc_parte,ldc_tot_riga, ldc_ret_value, ldc_quantita, ldc_totale, ldc_fattore
//decimal 		ldc_molteplicita
//string 		ls_sconto, ls_parte, ls_descrizione
//long 			ll_row, ll_pos, ll_ret_value, ll_id, ll_tab_iva, ll_id_magazzino, ll_id_locazione
//boolean 		lb_non_calcolabile
//string 		ls_tot_riga
//string		ls_tb, ls_cp, ls_vr, ls_tr, ls_riga_descrittiva, ls_tipo, ls_art
//string		ls_dbc[], ls_dbv[], ls_dwc[], ls_message
//integer		li_ok
//decimal		ldc_null, ld_sc_unit_riga, ld_sc_riga, ld_qta_min, ld_qta_max 
//dwItemStatus	ldw_status
//long  		ll_id_unita_conf,ll_confezione,ll_id_art,ll_righe_old,ll_righe_new,i, ll_lotto_trovato
//decimal 		ld_qta, ld_qta_lotto, ld_qta_iniz, ld_qta_eff, ldt_qta_scar_attuale
//string ls_gruppo, ls_gruppo_2, ls_cod_lotto
//integer li_ret
//decimal d_azzera[]
//long l_azzera[], LL_NUMERO
//date ldt_scadenza
//
//decimal ld_tara
//decimal ld_peso_netto, ld_peso_lordo
//string  ls_codice_azienda
//
//long 	ll_id_gruppo_agenti, ll_id_gruppo_agenti_2, ll_id_documento
//date	ldt_data_reg
//s_con_provvigione ls_con_provvigione			
//
//
////idt_qta_scar_attuale[]=d_azzera[]
////idt_qta_lotti[]=d_azzera[] 
////il_id_lotti[]=l_azzera[]
////
//
////if is_prof_dispo='C' or is_prof_dispo='B' then
////	decimal ld_tot_precedente
////	if (dwo.name='quantita' and this.getitemstring(row,'tipo_um')<>'P') or (dwo.name='riga_documento_peso_netto' and this.getitemstring(row,'tipo_um')='P') then
////   if dwo.name='quantita' then
////		ld_tot_precedente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,'quantita') 	
////	else
////		ld_tot_precedente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,'riga_documento_peso_netto')
////	end if	
////	if uf_blocca_dispo(ld_tot_precedente,data,row)=2 then 
////		post uf_setta_precedente(row,ld_tot_precedente,dwo.name)
////		return 2
////	end if	
////	end if
////end if	
////
//dwobject ldwo_pippo
//
//ll_row= GetRow()
//If ll_row=0 OR IsNull(ll_row) then ll_row= row
//SetNull(ldc_null)
////if IsValid(ids_lotti) and this.dataobject<>"d_riga_documento_ordine_ritorno_gd" then
////	CHOOSE CASE dwo.name
////	CASE "c_articolo_cod"
////		select id_articolo
////		into :ll_id
////		from articolo
////		where codice=:data;
////		if isnull(ll_id) then return 1
////		
////		wf_carico_lotti(row, ll_id)
////	CASE "riga_documento_descrizione"
////		
////		setnull(ll_id)
////		wf_carico_lotti(row,ll_id )
////	CASE "cod_lotto"
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"cod_esterno", data)
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if
////	CASE "data_scadenza"
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"data_scadenza",date(data))
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if
////	CASE "quantita"
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"qta_iniziale",dec(data))
////			
////			ll_id_unita_conf = this.getitemnumber(row,"riga_documento_id_unita_confezione")
////			SELECT peso_netto
////			INTO	 :ld_peso_netto
////			FROM	 unita_confezione
////			WHERE  id_unita_confezione = :ll_id_unita_conf
////			;
////			
////			if (ld_peso_netto > 0) and (not isnull(ld_peso_netto)) then
////				ld_peso_netto = ld_peso_netto * dec(data)
////				ids_lotti.SetItem(i,"peso_netto_iniziale",ld_peso_netto)				
////			end if
////			
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if
////	CASE "riga_documento_peso_netto"
////		
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"peso_netto_iniziale",dec(data))
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if		
////		
////		
////	END CHOOSE
////end if 
//long ll_id_articolo, ll_id_cat_fiscale2
//
//ll_id_articolo=getitemnumber(row, "riga_documento_id_articolo")
//
//			 
//char lc_tipo_ges_lotti
//string ls_tipo_mov
//
//SELECT a.id_cat_fiscale, m.tipo
//INTO   :ll_id_cat_fiscale2, :ls_tipo_mov
//FROM   articolo a, unita_confezione u, unita_misura m
//WHERE  a.id_articolo=:ll_id_articolo
//AND	 u.id_articolo = a.id_articolo
//AND	 u.unita_base = 'S'
//AND	 m.id_unita_misura =* u.id_unita_misura
//;
//
//SELECT tipo_ges_lotti
//INTO	 :lc_tipo_ges_lotti
//FROM	 pers_par_sistema
//;
//
////if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
////	if dwo.name="riga_documento_peso_netto" and isvalid(ids_scar_lotto) and (not(isnull(ll_id_cat_fiscale2))) then
////		wf_scarico_lotti(ll_id_articolo, dec(data), row)
////	end if		
////else
////	
////	if dwo.name="quantita" and isvalid(ids_scar_lotto) and (not(isnull(ll_id_cat_fiscale2))) then
////		wf_scarico_lotti(ll_id_articolo, dec(data), row)
////	end if	
////end if
//CHOOSE CASE dwo.name
//	CASE "c_articolo_cod", "riga_documento_descrizione"
//			
//	
//		IF DWO.NAME="c_articolo_cod" THEN
////			If (cbx_cod_barre.Checked) = TRUE then
////			
////				String ls_cod_articolo
////			
////				
////				long   ll_id_unita_confezione 
////				SELECT a.codice, c.id_unita_confezione
////				INTO	 :ls_cod_articolo, :ll_id_unita_confezione
////				FROM	 cod_barre c, unita_confezione u, articolo a
////				WHERE	 c.codice = :Data
////				AND	 u.id_unita_confezione = c.id_unita_confezione
////				AND	 a.id_articolo = u.id_articolo;
////				choose case SQLCA.SQLCODE
////					case -1
////						messagebox("", SQLCA.SQLERRTEXT)
////					case 100
////						messagebox("", "Il codice a barre acquisito non è stato codificato ")
////						return 2
////					case 0
////						this.Post setitem(row,"c_articolo_cod", ls_cod_articolo)
////						this.Post setitem(row,"riga_documento_id_unita_confezione", ll_id_unita_confezione)
////						data = ls_cod_articolo
////				end choose
////				
////			end if
//			
//		END IF
//		ls_riga_descrittiva=getitemstring(row, "riga_documento_descrizione")
//		ll_id_art=this.getitemnumber(row,"riga_documento_id_articolo")
//		if ls_riga_descrittiva>"" and not (isnull(ls_riga_descrittiva)) and  isnull(ll_id_art) then
//			messagebox("Attenzione!", "Impossibile inserire un articolo in una riga descrittiva.~r~n"+&
//			"Cancellare la riga e inserirne una nuova")
//			return 1
//		end if		
//	if ii_ricerca_art_fornitore=0 then
//		for i= 1 to 2
//			ls_dbc[1] = "descrizione"
//			ls_dbc[2] = "id_articolo"
//			ls_dbc[3] = "codice"
//			ls_dbc[4] = "descrizione"
//			ls_dwc[1] = "riga_documento_descrizione"
//			ls_dwc[2] = "riga_documento_id_articolo"
//			ls_dwc[3] = "c_articolo_cod"
//			ls_dwc[4] = "c_articolo_des"
//			li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",4,ls_dbc,ls_dbv,ls_dwc)
//			if li_ok>0 and i=1 then
//				ls_art=wf_varianti_set(data, row)
//				if ls_art>"" then
//					data=ls_art
//				else
//					exit
//				end if
//			else
//				exit
//			end if
//		next
//	end if	
//	ii_ricerca_art_fornitore=0	
//	
//		ll_id_art=this.getitemnumber(this.getrow(),"riga_documento_id_articolo")
//		if ll_id_art>0 then
//			li_ret=wf_controlla_utilizzabile(ll_id_art)
//			if li_ret=-1 then 
//				POST uf_set_colval("c_articolo_cod", "")	
//				data=""
//				RETURN
//			end if
//
//
//
//		end if
//		select id_unita_confezione
//		into :ll_confezione
//		from unita_confezione
//		where id_articolo=:ll_id_art
//		and unita_base='S';
//		setitem(ROW,"riga_documento_id_unita_confezione",ll_confezione)
//		wf_inf_aggiuntive(ll_confezione,ROW,ll_id_art)	
//		
//		
//		
//		
//		
//		if li_ok > 0 then
//			
//			
//			
//			
//			ldw_status = GetItemStatus( row,0,Primary! )
//			if ldw_status = New! or ldw_status = NewModified! then
//				post uf_scaglione_provvigione() 
//			end if
//			post wf_inserisci_pesi_riga(0)
//			wf_impongo_magazzino(row,row)
//			trigger event ue_set_arti_riga()	
//			trigger event ue_set_contropartita()
//			
//			if is_prof_dispo='C' or is_prof_dispo='B' then	uf_pre_blocca_dispo(row)
//			return 2 			
//		end if	
//	
//CASE "quantita"
//	ld_qta_max=getitemdecimal(row, "qta_sconto_merce")
//	if (ld_qta_max <> 0 and Not(IsNull(ld_qta_max))) and ld_qta_max>=dec(data) then
//		ls_message="La quantità inserita è inferiore o uguale~r~nalla quantità sconto merce!.~r~nInserire una quantità maggiore!"
//		post event ue_post_itemchanged(row, string(dwo.name), ls_message)
//	end if
//	WF_SE_CAMBIA_QTA(ROW, data)
//	
//	ll_confezione=this.getitemnumber(this.getrow(),"riga_documento_id_unita_confezione")	
//	if (not isnull(data) and dec(data) > 0) and (not isnull(ll_confezione)) and ll_confezione > 0 then
//		decimal {0} ld_num_colli 
//		SELECT num_colli
//		INTO	 :ld_num_colli
//		FROM	 unita_confezione
//		WHERE  id_unita_confezione = :ll_confezione
//		;
//		
//		if (SQLCA.SQLCODE = -1) then messagebox("DBError", SQLCA.SQLERRTEXT)
//		
//		if ld_num_colli > 0 then
//			ld_num_colli = ld_num_colli * dec(data)
//			setitem(row, "riga_documento_num_colli", ld_num_colli)
//		end if
//	end if
//	
//CASE "prezzo", "quantita", "riga_documento_peso_netto" 
//	
//	
//	
//	
//	
//	if (dwo.name = "riga_documento_peso_netto") then
//		SELECT 1
//		INTO   :ls_codice_azienda
//		FROM   azienda
//		WHERE  id_azienda = 1
//		AND	 UCASE(codice) = 'GIESSE'
//		;
//		
//		if (SQLCA.SQLCODE = 0) then
//			ll_row = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getrow()
//			ld_tara = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber(ll_row, "tara")
//
//			ll_row = getrow()
//			ld_peso_lordo = dec(data)
//			ld_peso_netto = (ld_peso_lordo - ld_tara)
//			post setitem(ll_row, "riga_documento_peso_lordo", ld_peso_lordo)	
//			post setitem(ll_row, "riga_documento_peso_netto", ld_peso_netto)
//		end if
//	end if
//	
//	
//	
//	ldw_status = GetItemStatus( row,0,Primary! )
//	
//	
//	string ls_tipo_um
//	decimal ld_prezzo
//	ld_prezzo=getitemdecimal(row, "prezzo")
//	
//	
//	if (dwo.name = "riga_documento_peso_netto") then
//	
//		ls_tipo_um=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(row,"tipo_um")
//		if ls_tipo_um='P' then
//			
//			
//			if pos(upper(u_freddie.istr_database.name), 'ORAFO')>0 then
//			else 
//				post event ue_rec_prezzo(row,1)
//			end if
//		end if
//	end if
//
//	
//	if (dwo.name = "prezzo") then
//		if dec(Data) > 0 and isnull(this.getitemnumber(row, "riga_documento_id_articolo")) then
//			post event ue_set_contropartita()
//		end if
//	end if
//	
//
//CASE "sconto"
//	post event ue_set_calc_riga(row)
//	
//	
//	
//	decimal ld_null
//	setnull(ld_null)
//	this.setitem(row,"riga_documento_sconto_riga",ld_null)
//	
//END CHOOSE
//
//if (dwo.name = "sconto" or dwo.name = "quantita" &
//	 or dwo.name = "riga_documento_peso_netto") then
//	post wf_gruppo_agenti(row)
//end if
//
//
//RETURN ll_ret_value
end event

event itemfocuschanged;call super::itemfocuschanged;//is_last_field=dwo.name


end event

event losefocus;call super::losefocus;
GraphicObject 	lgo_cur_control
string			ls_class

lgo_cur_control = GetFocus( ) 
If IsValid(lgo_cur_control) then
	ls_class=lgo_cur_control.ClassName()
end if
//If ib_rinumera_righe AND not(ls_class="pb_sort") then uf_Rinumera_Righe(0)
end event

event rowfocuschanged;if AcceptText() > 0 then
//	uf_set_mask_riga()
end if 
	
end event

event updateend;//
//IF rowsinserted+rowsupdated+rowsdeleted+modifiedcount()+deletedcount()>0 THEN
//	wf_new_cal_cmc()
//
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//								
//								
//								
//	
//tab_1.tabpage_2.pb_sort.enabled=true
//
//
//END IF
//
//
end event

event updatestart;//boolean lb_calcola_spese = FALSE 
//decimal ld_tot_riga_val_az, ld_tot_riga_val_az_o
//
//If ib_rinumera_righe then uf_Rinumera_Righe(0)
//
//ib_genera_castelletto= TRUE
//	SetPointer(HourGlass!)
//	tab_1.tabpage_4.dw_cast_iva_documento_lt.TriggerEvent("ue_calc_cast_iva")
//	tab_1.tabpage_5.dw_contr_documento_lt.TriggerEvent("ue_calc_contropartita")
//	uf_report_righe()
//	SetPointer(Arrow!)
//
//long  ll_righe, ll_id, ll_riga_doc, ll_id_loc2,i
//long  ll_id_doc, ll_id_caus_magazzino 
//long  ll_id_doc1 
//decimal{2} ld_qta, ld_qta_evasa
//boolean lb_ordinato_fo
//
//
//
//long ll_id_caus_mag_nmn
//
//SELECT id_caus_mag_nmn
//INTO	 :ll_id_caus_mag_nmn
//FROM	 par_sistema
//;
//
//long ll_causale,ll_loc1,ll_loc2, ll_id_articolo
//string ls_loc1,ls_loc2, ls_des
//
//for i=rowcount() to 1 step -1
//	
//	ll_id_articolo=getitemnumber(i,"riga_documento_id_articolo")
//	if isnull(ll_id_articolo) then
//			setitem(i,"riga_documento_id_caus_magazzino", ll_id_articolo)
//			setitem(i,"id_locazione_1", ll_id_articolo)
//			setitem(i,"id_locazione_2", ll_id_articolo)			
//	else
//		
//		long ll_id_cat_fiscale
//		
//		SELECT id_cat_fiscale
//		INTO	 :ll_id_cat_fiscale
//		FROM	 articolo
//		WHERE  id_articolo = :ll_id_articolo
//		;
//		
//		if (isnull(ll_id_cat_fiscale) and not isnull(ll_id_caus_mag_nmn)) then 
//			setitem(i,"riga_documento_id_caus_magazzino", ll_id_caus_mag_nmn)
//			setitem(i,"id_locazione_1", ll_id_cat_fiscale)
//			setitem(i,"id_locazione_2", ll_id_cat_fiscale)
//		end if
//		
//		
//		
//		ll_causale=this.getitemnumber(i,"riga_documento_id_caus_magazzino")
//		select mag_par_richiesto,mag_des_richiesto
//			into :ls_loc1, :ls_loc2
//			from caus_magazzino
//			where id_caus_magazzino=:ll_causale;
//			ll_loc1=this.getitemnumber(i,"id_locazione_1")
//			ll_loc2=this.getitemnumber(i,"id_locazione_2")
//		if not isnull(ll_causale ) then
//			if ls_loc1='S' and isnull(ll_loc1) then
//				messagebox("Errore","La locazione di partenza non è presente sulla riga "+string (i)+" !",stopsign!)
//				return 1
//			end if
//			if ls_loc2='S' and isnull(ll_loc2) then
//				messagebox("Errore","La locazione di destinazione non è presente sulla riga "+string (i)+" !",stopsign!)
//				return 1
//			end if
//			if ls_loc1='N' and not isnull(ll_loc1) then
//				messagebox("Informazione","E' stata impostata una locazione di partenza, su una o più righe, che non sarà utilizzata!")
//			end if	
//			if ls_loc2='N' and not isnull(ll_loc2) then
//				messagebox("Informazione","E' stata impostata una locazione di destinazione, su una o più righe, che non sarà utilizzata!")
//			end if
//		else
//			
//			ll_causale=idw_gen.getitemnumber(1, "documento_id_caus_magazzino")
//			ll_loc1=idw_gen.getitemnumber(1,"documento_id_locazione_1")
//			ll_loc2=idw_gen.getitemnumber(1,"documento_id_locazione_2")
//			setitem(i,"riga_documento_id_caus_magazzino", ll_causale)
//			setitem(i,"id_locazione_1", ll_loc1)
//			setitem(i,"id_locazione_2", ll_loc2)	
//		end if
//	end if
//next
//
//
//
//long ll_id_causale
//string ls_ges_lotti
//integer li_ret
//
//ll_id_causale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_caus_magazzino")
//ls_ges_lotti=wf_gestisci_lotti(ll_id_causale, 0)	
//if ls_ges_lotti='C' or ls_ges_lotti='S' or ls_ges_lotti='A' or ls_ges_lotti='R' then
//	if wf_controlla_lotti(ls_ges_lotti)<0 then
//		messagebox('Errore','Impossibile salvare lotti:  righe errate!')
//		return 1
//	ELSE
//		LI_RET=WF_SALVA_LOTTI(ls_ges_lotti)
//		IF LI_RET<>1 THEN 
//			messagebox('Errore','Impossibile salvare lotti: contattare assistenza!')
//			RETURN 1
//		END IF
//	end if
//end if
//
//
//string ls_des_personale, ls_des_codice, ls_des_estesa
//long ll_id_linguaggio, ll_id_sog_comm, ll_id_lingua, ll_id_linguaggio1, ll_id_lingua1
//long ll_id_riga_padre
//s_des_articolo s_des_art
//string ls_simbolo_um
//decimal{2} ld_lunghezza
//
//ll_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
//if not (tab_1.tabpage_1.dw_documento_ordine_ff.getrow()>0) then return
//ll_id_sog_comm=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_sog_commerciale")
//ll_id_linguaggio=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_linguaggio")
//ll_id_lingua=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_lingua")
//if (isnull(ll_id_linguaggio) or ll_id_linguaggio<1) or (isnull(ll_id_lingua) or ll_id_lingua<1) then
//		select id_linguaggio, id_lingua
//		into :ll_id_linguaggio1, :ll_id_lingua1
//		from par_sistema;
//		if sqlca.sqlcode<>0 then
//			messagebox("Errore!", "Non posso salvare le descrizioni associate al soggetto~r~n"+&
//			"commerciale corrente in quanto non specificato il linguaggio nei parametri di sistema")
//			return
//	end if
//end if
//if isnull(ll_id_lingua) then ll_id_lingua=ll_id_lingua1
//if isnull(ll_id_linguaggio) then ll_id_linguaggio=ll_id_linguaggio1
//for i = 1 to ll_righe
//	ld_lunghezza=getitemdecimal(i,"riga_documento_dim_l")
//	ls_simbolo_um=getitemstring(i, "unita_misura_b_simbolo")
//	if isnull(ls_simbolo_um) then ls_simbolo_um='XX'
//	ls_des_estesa=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i,"des_articolo_des_estesa")
//	ls_des_codice=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i, "des_articolo_codice")
//	ls_des_personale=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i, "des_articolo_descrizione")
//	ll_id_articolo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "riga_documento_id_articolo")
//	//mm 210110 nell'esplosione non deve ricopiare cod cl/fo
//	ll_id_riga_padre=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "id_riga_doc_padre")
//	
//	if (ls_des_personale>'' or ls_des_codice>'' &
//	or ls_des_estesa>'') and isnull(ll_id_riga_padre) &
//	and (not (Isnull(ll_id_articolo))) then
//		
//		update des_articolo
//		set 	descrizione=:ls_des_personale,
//				des_estesa=:ls_des_estesa,
//				codice=:ls_des_codice,
//				id_lingua=:ll_id_lingua,
//				id_linguaggio=:ll_id_linguaggio
//		where id_sog_commerciale=:ll_id_sog_comm
//		and id_articolo=:ll_id_articolo
//		and id_linguaggio=:ll_id_linguaggio
//		and id_lingua=:ll_id_lingua
//		and (simbolo_um=:ls_simbolo_um and lunghezza=:ld_lunghezza)
//		;
//		if sqlca.sqlnrows<1 then
//			
//			insert into des_articolo 
//			(id_linguaggio, descrizione, des_estesa, codice, id_sog_commerciale,
//			id_articolo, id_lingua, lunghezza, simbolo_um)
//			values (:ll_id_linguaggio,:ls_des_personale,:ls_des_estesa,:ls_des_codice, :ll_id_sog_comm, &
//			:ll_id_articolo, :ll_id_lingua, 0,'XX');
//			if sqlca.sqlcode<>0 then
//				rollback;
//			else
//				commit;
//				s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
//				ll_id_lingua,ll_id_linguaggio, i)
//				SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
//			end if
//			if ls_simbolo_um<>'XX' then
//				insert into des_articolo 
//				(id_linguaggio, descrizione, des_estesa, codice, id_sog_commerciale,
//				id_articolo, id_lingua, lunghezza, simbolo_um)
//				values (:ll_id_linguaggio,:ls_des_personale,:ls_des_estesa,:ls_des_codice, :ll_id_sog_comm, &
//				:ll_id_articolo, :ll_id_lingua,  :ld_lunghezza, :ls_simbolo_um);
//				if sqlca.sqlcode<>0 then
//					rollback;
//					messagebox("Errore!", "Descrizione personale "+ls_des_codice+"  non salvata!")
//				else 
//					commit;
//					
//					s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
//					ll_id_lingua,ll_id_linguaggio, i)
//					SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
//				end if
//			end if
//		else 
//			commit;
//			s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
//				ll_id_lingua,ll_id_linguaggio, i)
//			SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
//		end if
//	end if
//	
//next
//
//if (this.DeletedCount() > 0) then lb_calcola_spese = true	
//
//if (lb_calcola_spese) then wf_calcola_spese('N')	
end event

event ue_init;call super::ue_init;
//iudw_children[1] = dw_riga_documento_dett_ord_ff
//				
//is_list.s_identifica[1] = "id_documento"
//is_list.s_win_zoom = "w_riga_documento_wz"
end event

event ue_insert;call super::ue_insert;//ii_ricerca_art_fornitore = 0
//wf_salva_automaticamente()	
end event

event ue_update;
//integer li_RetVal
//
//li_RetVal = super::EVENT ue_update(wparam, lparam)
//
//
//	
//	
//	
//
//RETURN li_RetVal 

end event

event ue_delete;//
//decimal ld_precedente, ld_datastore
//long row, ll_ret, ll_id_art_dispo
//row=this.getrow()
//if is_prof_dispo='C' or is_prof_dispo='B' then
//	if this.getitemstring(row,'tipo_um')<>'P' then
//      ld_precedente=this.getitemdecimal(row,'quantita') 	
//	else
//		ld_precedente=this.getitemdecimal(row,'riga_documento_peso_netto')
//	end if	
//	
//	ll_id_art_dispo=this.getitemnumber(row,'riga_documento_id_articolo')
//   ll_ret=ids_disponibilita.find("id_articolo=" +string(ll_id_art_dispo), 1,ids_disponibilita.RowCount())
//   if ll_ret>0 then ld_datastore=ids_disponibilita.getitemdecimal(ll_ret,'totale')
//	if ld_datastore>ld_precedente then
//		ld_datastore=ld_datastore - ld_precedente
//		ids_disponibilita.setitem(ll_ret,'totale',ld_datastore)
//	else 
//		ids_disponibilita.deleterow(ll_ret)
//	end if
//end if	
//		
//call super ::ue_delete	
end event

event ue_retrieve;call super::ue_retrieve;
long ll_altezza
//ll_altezza= idw_riga.height
long ll_delta_y

//iF POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO')<=0 THEN
//
//	ll_delta_y = 165
//	idw_riga.Modify("c_tot_righe_lire.y = " + String(	 ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe_lire_t.y = " + String( ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe.y = " + String(			 ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe_t.y = " + String(		 ll_altezza 	- ll_delta_y ))
//	
//	
//	idw_riga.Modify("datawindow.summary.height = " + String (ll_altezza - 516))
//end if
//is_title = "Riga " + is_nome_tipo_documento
//SetSort("riga_documento_num_riga A") 
//Sort()
end event

event ue_modify;//
//
//s_any_array			lstr_array
//string				ls_array[], ls_sconto, ls_verifica
//long					ll_nr_column= 48, ll_count, ll_row, ll_id_u_conf
//decimal				ldc_fattore, ldc_molteplicita, ldc_totale, ldc_ret_value, ldc_quantita
//decimal{4}			ld_peso_lordo, ld_peso_netto
//string				ls_nome, ls_ric_riga
//
//long					ll_id_art_o, ll_id_loc_o
//
//
//ll_row = GetRow()
//If AcceptText() = 1 then
//	
//	ls_array[1]= uf_Get_Colval("riga_documento_id_unita_confezione")
//	ls_array[2]= uf_Get_Colval("quantita")
//	
//	ls_verifica=ls_array[2]
//	
//	ls_array[3]= uf_Get_Colval("riga_documento_data_prevista_consegna")
//	ls_array[4]= uf_Get_Colval("prezzo")
//	ls_array[5]= uf_Get_Colval("sconto")
//	ls_array[6]= uf_Get_Colval("riga_documento_prezzo_netto")
//	ls_array[7]= uf_Get_Colval("riga_documento_sconto_riga")
//	ls_array[8]= uf_Get_Colval("riga_documento_id_tab_iva")
//	ls_array[9]= uf_Get_Colval("riga_documento_forza_chius_evasione")
//	ls_array[10]= uf_Get_Colval("riga_documento_sospesa")
//	ls_array[11]= uf_Get_Colval("id_riga_doc_provenienza")
//	ls_array[12]= uf_Get_Colval("riga_documento_id_articolo")
//	ll_id_art_o = long(ls_array[12])	
//	ls_array[13]= uf_Get_Colval("qta_evasa")
//	ls_array[14]= uf_Get_Colval("id_gruppo_agenti")
//	ls_array[15]= uf_Get_Colval("provv_agente")
//	ls_array[16]= uf_Get_Colval("qta_sconto_merce")
//	ls_array[17]= uf_Get_Colval("id_locazione_1")
//	ll_id_loc_o = long(ls_array[17])	
//	ls_array[18]= uf_Get_Colval("id_locazione_2")
//	ls_array[19]= uf_Get_Colval("riga_documento_id_caus_magazzino")
//	ls_ric_riga=is_ric_riga
//	If  uf_Get_Colval("c_evasione") <> "NE" then 
//		ls_ric_riga=Replace(ls_ric_riga,1,1,"L")
//		ls_ric_riga=Replace(ls_ric_riga,13,1,"L")
//		ls_ric_riga=Replace(ls_ric_riga,14,1,"L")
//	end if
//	
//	if is_ges_locazioni = "S" then 
//		ls_ric_riga=Replace(ls_ric_riga,6,1,"M")
//		ls_ric_riga=Replace(ls_ric_riga,7,1,"M")
//	else
//		ls_ric_riga=Replace(ls_ric_riga,6,1,"L")
//		ls_ric_riga=Replace(ls_ric_riga,7,1,"L")
//	end if
//	
//	ls_array[20]= ls_ric_riga
//	ls_array[21]= uf_Get_Colval("riga_documento_id_articolo")
//	ls_array[22]= uf_Get_Colval("riga_documento_id_valuta")
//	ls_array[23]= uf_Get_Colval("riga_documento_cambio")
//	ls_array[24]= uf_Get_Colval("id_riga_documento")
//	ls_array[25]= uf_Get_Colval("provv_subage")
//	ls_array[26]= uf_Get_Colval("provv_carea")
//	ls_array[27]= uf_Get_Colval("riga_documento_id_conto")
//	
//	
//	long ll_riga_corrente
//	ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
//	ls_array[28]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
//	(ll_riga_corrente,"documento_id_magazzino"))
//	ls_array[29]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
//	(ll_riga_corrente,"documento_id_magazzino_2"))
//	
//	
//	ls_array[30]= uf_Get_Colval("riga_documento_num_colli")
//	ls_array[31]= uf_Get_Colval("riga_documento_peso_netto")
//	ls_array[32]= uf_Get_Colval("riga_documento_peso_lordo")
//	
//	ls_array[33]= uf_Get_Colval("usimbolo")
//	ls_array[34]= uf_Get_Colval("udescrizione")
//	ls_array[35]= uf_Get_Colval("riga_documento_dim_l")
//	ls_array[36]= uf_Get_Colval("riga_documento_dim_h")
//	ls_array[37]= uf_Get_Colval("riga_documento_dim_p")
//	
//	ls_array[38]= uf_Get_Colval("unita_misura_b_simbolo")
//	ls_array[39]= uf_Get_Colval("unita_misura_b_descrizione")
//	ls_array[40]=string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_sog_commerciale"))
//	
//	ls_array[41]= uf_Get_Colval("provv_imp_agente")
//	ls_array[42]= uf_Get_Colval("provv_imp_subage")
//	ls_array[43]= uf_Get_Colval("provv_imp_carea")
//	
//	
//	ls_array[44]= uf_Get_Colval("riga_documento_id_gruppo_agenti_2")
//	ls_array[45]= uf_Get_Colval("riga_documento_provv_agente_2")
//	ls_array[46]= uf_Get_Colval("riga_documento_provv_subage_2")
//	ls_array[47]= uf_Get_Colval("riga_documento_provv_carea_2")
//	ls_array[48]= uf_Get_Colval("riga_documento_provv_imp_agente_2")
//	ls_array[49]= uf_Get_Colval("riga_documento_provv_imp_subage_2")
//	ls_array[50]= uf_Get_Colval("riga_documento_provv_imp_carea_2")
//	
//	
//	ls_array[51]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente,"id_documento"))
//	
//	
//	ls_array[52]= string(tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_riga_corrente,"riga_documento_id_con_lis_articolo"))
//	
//	lstr_array.s_array = ls_array
//
//	
//	OpenWithParm(iw_support, lstr_array,"w_riga_documento_wz")
//	lstr_array= Message.PowerObjectParm
//	
//	ls_array= lstr_array.s_array
//	uf_Set_Colval("riga_documento_id_unita_confezione",ls_array[1])
//	long ll_id_unita_confezione
//	ll_id_unita_confezione=long(ls_array[1])
//	if (ll_id_unita_confezione)>0 and not isnull(ll_id_unita_confezione) then
//		string ls_tipo,ls_simbolo
//		SELECT "unita_misura"."tipo","unita_misura"."simbolo"  
//		INTO :ls_tipo,:ls_simbolo 
//		FROM "unita_confezione",   
//		  	  "unita_misura"  
//		WHERE ( "unita_confezione"."id_unita_misura" = "unita_misura"."id_unita_misura" ) and  
//            ( ( "unita_confezione"."id_unita_confezione" = :ll_id_unita_confezione ) )   ;
//		
//		uf_Set_Colval("tipo_um",ls_tipo)
//		uf_Set_Colval("simbolo_mov",ls_simbolo)		
//		
//	end if
//	uf_Set_Colval("quantita",ls_array[2])
//	
//	if ls_verifica<>ls_array[2] then
//		ll_id_u_conf=long(uf_get_colval("riga_documento_id_unita_confezione"))
//		ll_id_u_conf=wf_controlla_qta_mov(ll_id_u_conf, ls_array[2])
//		if ll_id_u_conf=0 then 
//			post event ue_post_itemchanged(getrow(), "quantita", "Non si può movimentare questa quantità!")
//		else
//			post event ue_rec_prezzo(getrow(), dec(ls_array[2]))
//		end if
//	end if
//	
//	if not (IsNull(ls_array[3]) OR  ls_array[3]="") then uf_Set_Colval("riga_documento_data_prevista_consegna",ls_array[3])
//	uf_Set_Colval("prezzo",ls_array[4])
//	uf_Set_Colval("sconto",ls_array[5])
//	
//	uf_Set_Colval("riga_documento_sconto_riga",ls_array[7])
//	uf_Set_Colval("riga_documento_id_tab_iva",ls_array[8])
//	uf_Set_Colval("riga_documento_forza_chius_evasione",ls_array[9])
//	uf_Set_Colval("riga_documento_sospesa",ls_array[10])
//	uf_Set_Colval("id_riga_doc_provenienza",ls_array[11])
//	uf_Set_Colval("qta_evasa",ls_array[13])
//	uf_Set_Colval("id_gruppo_agenti",ls_array[14])
//	uf_Set_Colval("provv_agente",ls_array[15])
//	uf_Set_Colval("qta_sconto_merce", ls_array[16])
//	uf_Set_Colval("id_locazione_1",ls_array[17])
//	uf_Set_Colval("id_locazione_2",ls_array[18])
//	uf_Set_Colval("riga_documento_id_caus_magazzino",ls_array[19])
//	uf_Set_Colval("riga_documento_id_valuta", ls_array[22])
//	uf_Set_Colval("riga_documento_cambio", ls_array[23])
//	uf_Set_Colval("provv_subage",ls_array[25])
//	uf_Set_Colval("provv_carea",ls_array[26])
//	uf_Set_Colval("riga_documento_id_conto",ls_array[27])
//	
//	ll_riga_corrente=getrow()
//	setitem(ll_riga_corrente,"riga_documento_num_colli",dec(ls_array[30]))
//	setitem(ll_riga_corrente,"riga_documento_peso_netto",dec(ls_array[31]))
//	setitem(ll_riga_corrente,"riga_documento_peso_lordo",dec(ls_array[32]))
//
//	
//	setitem(ll_riga_corrente,"riga_documento_dim_l",dec(ls_array[35]))
//	setitem(ll_riga_corrente,"riga_documento_dim_h",dec(ls_array[36]))
//	setitem(ll_riga_corrente,"riga_documento_dim_p",dec(ls_array[37]))	
//	
//	
//	
//	uf_Set_Colval("provv_imp_agente",ls_array[41])
//	uf_Set_Colval("provv_imp_subage",ls_array[42])
//	uf_Set_Colval("provv_imp_carea",ls_array[43])
//	
//	
//	
//	
//	
//	if (long(ls_array[44]) > 0) then
//		
//		uf_Set_Colval("riga_documento_id_gruppo_agenti_2",ls_array[44])
//		uf_Set_Colval("riga_documento_provv_agente_2",ls_array[45])
//		uf_Set_Colval("riga_documento_provv_subage_2",ls_array[46])
//		uf_Set_Colval("riga_documento_provv_carea_2",ls_array[47])
//		uf_Set_Colval("riga_documento_provv_imp_agente_2",ls_array[48])
//		uf_Set_Colval("riga_documento_provv_imp_subage_2",ls_array[49])
//		uf_Set_Colval("riga_documento_provv_imp_carea_2",ls_array[50])	
//		
//	end if
//	
//
//	TriggerEvent("ue_set_ucon_riga")
//	uf_set_mask_riga()
//	
//
//	
//	if (ll_id_art_o <> long(ls_array[12]) or &
//		 ll_id_loc_o <> long(ls_array[17])) then	wf_cal_costi()
//	
//	
//end if
//
end event

event ue_key;//DataWindowChild	ldw_dropdown
//DataWindowChild	ldw_drop
//string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval, ls_cod, ls_des
//integer				li_cdw, li_size, li_i, li_ret
//w_search_main		lw_sm
//w_data_main			lw_win
//w_mod_single_data lw_mw
//w_p_data				lw_pwin
//u_dw_main			lu_dw
//
//long					ll_retv, ll_art, ll_id_sog
//
//integer li_row 
//li_row = getrow()					
//long ll_id_unita_confezione
//if (li_row > 0) then ll_id_unita_confezione = this.getitemnumber(li_row, "riga_documento_id_unita_confezione")
//
//ll_retv = 0
//
//
//choose case key
//	
//	case KeyF1!
//		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
//			
//			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
//		end if
//		
//	case KeyF5!
//		if keyflags = 0 then
//			ls_column = getColumnName()
//			uf_reply_retrieve_dddw(ls_column)
//			
//		end if	
//	
//	
//	
//	
//	case KeyF3!	
//		string ls_parigi, ls_filter2
//		long ll_id_riga_documento
//		integer i
//			
//		select parigi
//		into :ls_parigi
//		from pers_par_sistema;
//			
//		if ls_parigi = 'S' then	
//			
//			open(w_attesa)
//			ls_filter2 = "quantita > 0"
//			setfilter(ls_filter2)
//			filter()
//			update()
//			setfilter("")
//			filter()
//			
//			declare c_canc cursor for
//						
//			select id_riga_documento 
//			from riga_documento
//			where id_documento = :il_id_documento
//			and quantita = 0;
//			
//			open c_canc;
//			fetch c_canc into :ll_id_riga_documento;
//
//			DO WHILE sqlca.sqlcode = 0
//				delete from riga_documento 
//				where id_riga_documento = :ll_id_riga_documento;
//				
//				fetch c_canc into :ll_id_riga_documento;
//			LOOP
//
//	      close c_canc;		
//						
//			commit;
//			
//			idw_master.is_list.s_modo = modo_modifica
//			idw_master.is_list.s_identifica[1] = "id_documento"
//			idw_master.is_list.l_identifica[1] = il_id_documento
//			SetPointer(HourGlass!)
//			
//			this.enabled= FALSE
//			idw_master.Event ue_retrieve(0, 0)
//			uf_set_documento()
//			uf_setup_documento()
//			uf_set_istanze()
//			this.enabled= TRUE
//			uf_default_focus()
//			SetPointer(Arrow!)
//			close(w_attesa)
//		end if
//	
//		
//	case KeyF4!
//		ll_retv = 1
//		ib_during_f4 = true
//		is_ricpar = is_e_ricpar
//		ls_column = getColumnName()
//		ls_style = this.describe(ls_column+".edit.style")
//		is_ricpar.b_imm_retrieve = false
//		is_ricpar.s_caller_column = ls_column
//		is_ricpar.s_sql_cond = ""
//		is_search_window = ""
//		ls_colval = ""
//		trigger event ue_set_search (ls_column,ls_colval)
//		if (is_search_window) <> "" then
//			choose case keyflags
//				case 0	
//					
//					ls_colval = gettext()
//					
//					
//					is_ricpar.b_imm_insert = false
//					is_ricpar.s_caller_column = ls_column
//					is_ricpar.b_imm_retrieve = false
//					is_ricpar.s_sql_cond = ""
//					trigger event ue_set_search (ls_column,ls_colval)
//					if lower (ls_style) <> "dddw" then
//						
//						OpenWithParm (lw_sm,is_ricpar,is_search_window)
//						
//						
//						
//						is_ricpar = Message.PowerObjectParm
//						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
//							trigger event ue_use_search (ls_column)
//						end if
//					end if
//					
//				case 1	
//
//					
//					ls_colval = gettext()
//					
//					
//					is_ricpar.b_imm_insert = true
//					is_ricpar.s_caller_column = ls_column
//					is_ricpar.b_imm_retrieve = false
//					is_ricpar.s_sql_cond = ""
//					trigger event ue_set_search (ls_column, ls_colval)
//					if lower (ls_style) = "dddw" then
//						
//						OpenWithParm (lw_mw,is_ricpar,is_search_window)
//						this.GetChild (ls_column, ldw_dropdown)
//						ldw_dropdown.SetTransObject(SQLCA)
//						ldw_dropdown.Retrieve ()
//						li_size = upperbound(is_ricpar.s_ausil_value)
//						for li_i = 1 to li_size
//							if is_ricpar.s_ausil_value[li_i] > " " then
//								this.GetChild (is_ricpar.s_ausil_value[li_i], ldw_dropdown)
//								ldw_dropdown.SetTransObject(SQLCA)
//								ldw_dropdown.Retrieve ()
//							end if
//						next
//					else
//						
//						
//						OpenWithParm (lw_sm,is_ricpar,is_search_window)
//						is_ricpar = Message.PowerObjectParm
//						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
//							trigger event ue_use_search (ls_column)
//						end if
//					end if
//				case 2	
//				case 3	
//					ls_colval = gettext()
//					is_ricpar.b_imm_maint = true
//					is_ricpar.s_caller_column = ls_column
//					is_ricpar.b_imm_retrieve = false
//					is_ricpar.s_sql_cond = ""
//					trigger event ue_set_search (ls_column,ls_colval)
//					if lower (ls_style) = "dddw" then
//						
//					else
//						
//						
//						OpenWithParm (lw_sm,is_ricpar,is_search_window)
//						if not IsNull(Message.PowerObjectParm) then
//							is_ricpar = Message.PowerObjectParm
//							trigger event ue_use_search (ls_column)
//						end if
//					end if
//					is_ricpar.b_imm_maint = false
//			end choose
//		end if
//		ib_during_f4 = false
//		
//		
//		
//		ii_ricerca_art_fornitore = 0
//
//		
//		
//	case Keyadd!
//		
//		
//		if (keyFlags=2) then
//			ll_retv = 1
//			lw_win = u_freddie.iw_current
//			ls_tipof = lw_win.is_wintype
//			lu_dw = lw_win.idw_master
//			choose case ls_tipof
//				case "W_P_DATA"
//					if this = lu_dw then
//						if is_list.s_modo = modo_inserisci then 			
//							if (event ue_update (0,0) = 0) then
//								triggerevent("ue_insert")
//							end if
//							lu_dw.setFocus()
//						end if
//					else
//						triggerevent("ue_insert")
//					end if
//				case else
//					triggerevent("ue_insert")
//			end choose
//		end if
//	case KeySubtract!
//		if (keyFlags=2) then
//			cb_cancella.event trigger clicked()
//		end if
//
//	case KeyS!
//		if (keyFlags=2) then
//			ll_retv = 1
//			lw_win = u_freddie.iw_current
//			lu_dw = lw_win.idw_master
//			
//			if IsNull(lu_dw) then lu_dw = this
//			lu_dw.triggerevent("ue_update")
//		end if
//	case KeyF12!
//		if (keyFlags=0) then
//			ll_retv = 1
//			lw_win = u_freddie.iw_current
//			lu_dw = lw_win.idw_master
//			
//			if IsNull(lu_dw) then lu_dw = this
//			lu_dw.triggerevent("ue_update")
//		end if
//		
//		
//		if (keyflags=3) then
//			lw_win = u_freddie.iw_current
//			lw_win.trigger event key (keyF12!,3)
//		end if
//	case KeyN!
//		if (keyFlags=2) then
//			ll_retv = 1
//				lw_win = u_freddie.iw_current
//				ls_tipof = lw_win.is_wintype
//				lu_dw = lw_win.idw_master
//				if ls_tipof = "W_P_DATA" then
//					if (lu_dw.is_list.s_modo = modo_inserisci) or (lw_win.ib_nonmodale = true) then 	
//						if (lu_dw.event ue_update (0,0) = 0) then
//							lu_dw.triggerevent("ue_insert")
//						end if
//						lu_dw.setFocus()
//					end if
//				end if
//      end if
//
//	case KeyF6!
//		lw_win = u_freddie.iw_current
//		ls_tipof = lw_win.is_wintype
//		if ls_tipof = "W_P_DATA" then
//			lw_win.ib_F6_in_dw = true
//			if (keyflags=0) then		
//				ll_retv = 0
//				li_ret = -1
//				do while li_ret<0
//					li_cdw = lw_win.ii_dwcurr
//					li_cdw++
//					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
//					lw_win.ii_dwcurr = li_cdw
//					lw_pwin = lw_win
//					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
//				loop
//			end if
//			if (keyFlags=1) then		
//				ll_retv = 0
//				li_ret = -1
//				do while li_ret<0
//					li_cdw = lw_win.ii_dwcurr
//					li_cdw --
//					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
//					lw_win.ii_dwcurr = li_cdw
//					lw_pwin = lw_win
//					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
//				loop
//			end if
//		end if
//	case keydelete!		
//		ls_column = getColumnName()
//		ls_style = this.describe(ls_column+".edit.style")
//		if ls_style = "ddlb" then
//			uf_set_colval(ls_column,u_freddie.gs_null)
//			ll_retv = 1
//		end if
//end choose
//
//
//
//CHOOSE CASE key
//		
//   
//	CASE KeyI!
//		CHOOSE CASE keyflags
//			CASE 2
//				
//				
//				long li_num_prec, li_num_prec2
//				long ll_nr_row, ll_row
//				
//			
//				ll_nr_row = RowCount()
//				FOR ll_row=1 to ll_nr_row
//				   SetItem(ll_row, "riga_documento_num_riga", ll_row * 1000)
//         	NEXT
//
//				li_ret=update()
//				if li_ret<>1 then
//					messagebox("Errore!" , "Salvataggio righe non riuscito!")
//					return 
//				end if
//
//  				if (li_row - 1) >= 1 then
//					li_num_prec=this.getitemnumber((li_row ), "riga_documento_num_riga") - 1
//				else 
//					li_num_prec = 999
//				end if								
//				
//				trigger event ue_insert(0,0)
//				
//				this.setitem(this.rowcount(), "riga_documento_num_riga", li_num_prec)	
//				
//				li_ret=this.SetSort("riga_documento_num_riga A") 		
//				li_ret=this.Sort()												
//				
//				ll_nr_row= RowCount()
//				FOR ll_row= ll_nr_row to 1 step -1
//					SetItem(ll_row, "riga_documento_num_riga", ll_row)
//				NEXT	
//				
//				li_ret=update()
//				if li_ret<>1 then
//					messagebox("Errore!" , "Salvataggio righe non riuscito! #2")
//					return 
//				end if				
//				scrolltorow(li_row)
//		END CHOOSE	
//	
//	
//				
//	CASE KeyF!
//		CHOOSE CASE keyflags
//			CASE 2
//					ii_ricerca_art_fornitore = 1				
//   			   this.accepttext()
//				   ll_row=this.getrow()
//				   ls_cod=trim(this.getitemstring(ll_row,'c_articolo_cod'))
//					ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
//					select id_articolo 
//					into :ll_Art
//					from des_articolo
//					where codice = :ls_cod
//					and id_sog_commerciale=:ll_id_sog
//					and simbolo_um='XX'
//					;
//					if sqlca.sqlcode=0 then
//						string ls_stato
//						select  codice, descrizione, stato
//						into :ls_cod, :ls_des, :ls_stato 
//						from articolo 
//						where id_articolo = :ll_art;
//						
//						this.setitem(ll_row,'c_articolo_cod', ls_cod)
//						this.setitem(ll_row,'riga_documento_id_articolo', ll_art)
//						this.setitem(ll_row,'riga_documento_descrizione', ls_des)
//						
//						
//						long ll_id_uc, ll_id_um
//						select id_unita_confezione, id_unita_misura
//						into :ll_id_uc, :ll_id_um
//						from unita_confezione
//						where id_articolo = :ll_art
//						and	unita_base = 'S';		
//						
//						this.setitem(ll_row,'riga_documento_id_unita_confezione', ll_id_uc)						
//						
//						
//						
//						ii_ricerca_art_fornitore = 1	
//						post wf_inserisci_pesi_riga(0)
//						trigger event ue_set_arti_riga()	
//						
//						s_lung_peso s_lung
//						long ll_id_prof_documento
//						string ls_test
//						ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
//						select prop_lunghezza
//						into :ls_test
//						from prof_documento
//						where id_prof_documento=:ll_id_prof_documento;
//						if ls_test='S' then
//							s_lung.id_sog_commerciale=ll_id_sog	
//							s_lung.cod_articolo=ls_cod
//							openwithparm(w_ric_lung_peso_gd, s_lung)
//							s_lung=message.powerobjectparm
//						end if
//						if isvalid(s_lung)  then
//							if s_lung.cod_articolo>"" then
//								post setitem(ll_row, "riga_documento_dim_l", s_lung.lunghezza)
//							end if
//						end if
//						
//						
//						
//						ii_ricerca_art_fornitore = 0
//						
//						return 
//					else	
//						ii_ricerca_art_fornitore = 1	
//						trigger event ue_key(KeyF4!, 0)
//					end if	
//			END CHOOSE		
//		
//			
//	
//	CASE KeyG!
//		CHOOSE CASE keyflags
//			CASE 2
//				decimal ld_peso_netto 
//				char lc_tipo_ges_lotti
//				
//				SELECT tipo_ges_lotti
//				INTO	 :lc_tipo_ges_lotti
//				FROM	 pers_par_sistema
//				;
//				
//				
//				string		ls_tipo_mov
//				decimal{4}  ld_quantita
//				
//				SELECT m.tipo
//				INTO	 :ls_tipo_mov
//				FROM	 unita_confezione u, unita_misura m
//				WHERE  u.id_unita_confezione = :ll_id_unita_confezione
//				AND	 m.id_unita_misura = u.id_unita_misura
//				;
//				
//				
//				if (lc_tipo_ges_lotti = 'G' and 	(tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject = 'd_riga_documento_ordine_lotti_gd') ) then
//					
//		
//					DWObject my_dwo
//					
//					if (ls_tipo_mov = 'P') then
//						my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
//						ld_peso_netto = getitemnumber(li_row,"riga_documento_peso_netto")
//						trigger event itemchanged(li_row, my_dwo, string(ld_peso_netto))
//					else
//						
//						my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.quantita
//						ld_quantita = getitemnumber(li_row,"quantita")
//						trigger event itemchanged(li_row, my_dwo, string(ld_quantita))						
//						
//					end if
//				end if
//		END CHOOSE
//	
//	
//	
//	CASE KeyW!
//		CHOOSE CASE keyflags
//			CASE 2	
//
//			string ls_cod_barre
//			integer li_len		
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.accepttext()				
//			ls_cod_barre = getitemstring(li_row,"c_articolo_cod")
//			my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.c_articolo_cod
//			trigger event itemchanged(li_row, my_dwo, ls_cod_barre)
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetColumn("quantita")	
//		END CHOOSE
//	
//	
//	
//	CASE KeyP!
//		CHOOSE CASE keyflags
//			CASE 2
//				long ll_id_locazione_1
//				date ldt_data_registrazione
//				ll_id_locazione_1 = this.getitemnumber(li_row, "id_locazione_1")
//				ldt_data_registrazione = tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(1, "data_registrazione")
//				s_list_main my_st
//				my_st.s_modo=modo_modifica
//				my_st.s_identifica[1]="id_unita_confezione"
//				my_st.l_identifica[1]=ll_id_unita_confezione
//				my_st.l_id_varie=ll_id_locazione_1
//				my_st.s_provenienza=string(ldt_data_registrazione)
//				
//				openwithparm(w_mod_prz_cx, my_st)
//				
//		END CHOOSE
//	
//	
//	
//	
//	boolean 	lb_new=FALSE
//	boolean 	lb_last=FALSE
//	long 		ll_last_row
//
//		CASE KeyTab!
//		If keyflags = 0 then
//			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
//			lb_last = (GetRow() = RowCount())
//			if is_last_field = "riga_documento_id_tab_iva" then
//					
//				
//					if lb_last then
//					
//						idw_riga.PostEvent("ue_wiz_insert")
//					else
//	
//						idw_riga.PostEvent("ue_wiz_getfocus")
//					end if
//				RETURN -1
//			end if
//		end if
//	
//	
//END CHOOSE
//	
//return ll_retv
//
//
//
//lb_new=FALSE
//CHOOSE CASE key
//	CASE KeyTab!
//		If keyflags =0 then
//			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
//			if is_last_field = "riga_documento_id_tab_iva" AND lb_new then
//				idw_riga_tot.PostEvent("GetFocus")
//				idw_riga_tot.SetColumn("descrizione")
//				RETURN 1
//			end if
//		end if
//END CHOOSE	
//
end event

event ue_validate_row;call super::ue_validate_row;//
//long 		ll_id_tab_iva, ll_prezzo
integer	li_err_count
//decimal	ld_QTA, ld_QTA_SM, ld_QTA_UB, ld_Fatglob, ld_qta_evasa, ld_qta_evasa_un_base
//
//ld_QTA = uf_GetItemDecimal(al_row, "quantita")
//if IsNull(ld_QTA) then ld_QTA=0
//ld_QTA_SM = uf_GetItemDecimal(al_row, "qta_sconto_merce")
//if IsNull(ld_QTA_SM) then ld_QTA_SM=0
//ld_Fatglob=uf_GetItemDecimal(al_row,"fat_con_globale")
//if IsNull(ld_Fatglob) then ld_Fatglob=0
//ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
//SetItem(al_row, "qta_un_base", ld_QTA_UB)
//
//ld_qta_evasa = uf_GetItemDecimal(al_row, "qta_evasa")
//if isNull(ld_qta_evasa) then ld_qta_evasa = 0
//ld_qta_evasa_un_base = ld_qta_evasa * ld_fatGlob
//SetItem(al_row, "qta_evasa_un_base", ld_qta_evasa_un_base )
//
//
//li_err_count=0
//ll_id_tab_iva= GetItemNumber(al_row, "riga_documento_id_tab_iva")
//ll_prezzo= GetItemNumber(al_row, "prezzo")
//if not(IsNull(ll_prezzo) OR ll_prezzo =0) AND (IsNull(ll_id_tab_iva) OR ll_id_tab_iva =0) then
//	as_error_text= "Esistono righe non descrittive senza IVA. "
//	li_err_count=1
//end if
//If li_err_count > 0 then iuo_msg_log.uf_new_text(as_error_text, 3)
return li_err_count
//
end event

event ue_initial;call super::ue_initial;//date 				ld_data_prev_consegna
//
//long				ll_id_magazzino, ll_row, ll_numero, ll_id_valuta, ll_righe, ll_count, ll_nriga
//long				ll_id_listino, ll_id_caus_magazzino, ll_id_locazione, ll_id_agente, ll_test
//long il_row
//
//ll_row=rowcount()
//
//il_row=dw_1.getrow()
//
//ld_data_prev_consegna = dw_1.GetItemDate(il_row,"data_prev_consegna")
//SetItem(ll_row, "riga_documento_data_prevista_consegna", ld_data_prev_consegna)
//
//ll_nriga = GetItemNumber(1, "c_max_num")
//if isnull(ll_nriga) then ll_nriga = 0
//SetItem(ll_row, "riga_documento_num_riga", ll_nriga+1)
//
//
//ll_id_valuta=dw_1.GetItemNumber(il_row, "documento_id_valuta_des")
//
//
//SetItem(ll_row,"riga_documento_id_valuta",  ll_id_valuta)
//
//SetItem(ll_row,"riga_documento_cambio",  1)
//
//
//ll_id_caus_magazzino = dw_1.GetItemNumber(il_row, "documento_id_caus_magazzino")
//SetItem(ll_row, "riga_documento_id_caus_magazzino",ll_id_caus_magazzino)
//
//
//
//long ll_locazione, ll_locazione2
//ll_locazione=dw_1.GetItemNumber(il_row, "documento_id_locazione_1")
//
//SetItem(ll_row, "id_locazione_1",ll_locazione)
//
//ll_locazione2=dw_1.GetItemNumber(il_row, "documento_id_locazione_2")
//SetItem(ll_row, "id_locazione_2",ll_locazione2)
//
//
//ll_id_agente = dw_1.GetItemNumber(il_row, "id_gruppo_agenti")
//SetItem(ll_row, "id_gruppo_agenti",ll_id_agente)
////mm per silver dreams uso per galvanica
////ll_id_agente = dw_1.GetItemNumber(il_row, "id_gruppo_agenti_2")
////SetItem(ll_row, "riga_documento_id_gruppo_agenti_2",ll_id_agente)
////uf_set_mask_riga()
//
//
//long ll_id_r_lotto, ll_riga, ll_id_doc
//string ls_flag_comm
////if isValid(ids_lotti) or isValid(ids_scar_lotto) then
////	select prog_materie_prime
////	into :ll_id_r_lotto
////	from prog_lotti;
////	if ll_id_r_lotto<1 then 
////		messagebox("Errore", "Riferimento per gestione lotti non creato!")
////		deleterow(ll_row)
////		return
////	else
////		ll_id_r_lotto++
////		update prog_lotti
////		set prog_materie_prime = :ll_id_r_lotto;
////		if sqlca.sqlnrows>0 then
////			ll_riga=tab_1.tabpage_2.dw_riga_documento_ordine_gd.RowCount()
////			tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_riga,"id_riga_lotto",ll_id_r_lotto)
////			commit;	
////		else
////			messagebox("Errore", "Riferimento per gestione lotti non creato!")
////			deleterow(ll_row)
////			return
////		end if
////	end if
////end if
////if isValid(ids_lotti) then	
////	ll_riga=ids_lotti.InsertRow(0)
////	ids_lotti.SetItem(ll_riga,"numero",ll_id_r_lotto)
////	ids_lotti.SetItem(ll_riga,"attivo",'S')
////	select commerciale
////	into :ls_flag_comm
////	from par_sistema;
////	if sqlca.sqlcode=0 then
////		if ls_flag_comm="S" then
////			ids_lotti.SetItem(ll_riga,"tipo_lotto",'Z')
////		else
////			ids_lotti.SetItem(ll_riga,"tipo_lotto",'M')
////		end if
////	else
////		messagebox("Errore", "parametro 'commerciale' non trovato in par_sistema")
////	end if
////end if
//
////wf_tipo_prezzi()
end event

event ue_set_search;call super::ue_set_search;//string ls_riga_descrittiva
//long ll_id_art
//
//
//this.Object.DataWindow.Selected.Mouse = "No"
//
//CHOOSE CASE as_nomecol
//	CASE "riga_documento_descrizione"
//		is_ricpar.s_filter_value = as_valcol 
//		
//		if (ii_ricerca_art_fornitore = 1) then
//			is_search_window = "w_des_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "des_articolo_descrizione"
//		else
//			is_search_window = "w_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "articolo_descrizione" 
//		end if
//		
//		is_ricpar.b_asneeded=TRUE
//	CASE "c_articolo_cod"
//		is_ricpar.s_filter_value = trim(as_valcol) 
//		is_ricpar.l_id_doc=idw_gen.getitemnumber(1, "id_documento")
//		
//		if (ii_ricerca_art_fornitore = 1) then
//			is_search_window = "w_des_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "des_articolo_codice"
//		else
//			is_search_window = "w_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "articolo_codice" 
//		end if
//		
//		is_ricpar.b_asneeded=TRUE
//END CHOOSE
//
//
end event

event ue_use_search;//long ll_id_articolo, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value, ll_id_tab_iva
//decimal ldc_ret_value
//date ld_comp
//string ls_simbolo
//dwItemStatus	ldw_status
//string ls_utilizzabile
//decimal{4} ld_peso_lordo, ld_peso_netto
//long row, ll_id, ll_id_uc
//integer li_riga_fine, li_riga_inizio, i, li_ret
//string ls_um
//long ll_soggetto
//
//
//ll_row= GetRow()
//
//long	ll_id_art_o
//ll_id_art_o = this.getitemnumber(ll_row, "riga_documento_id_articolo")
//if isnull(ll_id_art_o) then ll_id_art_o = 0
//
//this.Object.DataWindow.Selected.Mouse = "Yes"
//
//CHOOSE CASE as_nomecol
//	CASE "c_articolo_cod"
//		
//		
//		
//		
//		
//		
//		
//			ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
//			LI_RET=wf_controlla_utilizzabile(ll_id_articolo)
//			IF LI_RET=-1 THEN
//				RETURN
//			END IF
//		
//		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
//		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
//		uf_set_colval("riga_documento_descrizione", is_ricpar.s_ausil_value[1])
//		uf_set_colval("c_articolo_des", is_ricpar.s_ausil_value[1])
//		
//		uf_set_colval("articolo_stato", is_ricpar.s_ausil_value[2])
//		
//		
//		uf_set_colval("usimbolo", is_ricpar.s_ausil_value[3])
//		uf_set_colval("udescrizione", is_ricpar.s_ausil_value[4])
//		uf_set_colval("unita_misura_b_simbolo", is_ricpar.s_ausil_value[5])
//		uf_set_colval("unita_misura_b_descrizione", is_ricpar.s_ausil_value[6])
//		uf_set_colval("conversione_peso_comune", is_ricpar.s_ausil_value[7])
//		uf_set_colval("conversione_volume_comune", is_ricpar.s_ausil_value[8])
//		uf_set_colval("riga_documento_id_unita_confezione", is_ricpar.s_ausil_value[9])
//		
//		
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then event ue_set_arti_riga()
//		
//		post event ue_set_contropartita()
//		post event ue_set_calc_riga(ll_row)
//		ldw_status = GetItemStatus( ll_row,0,Primary! )
//		if ldw_status = New! or ldw_status = NewModified! then
//			post uf_scaglione_provvigione() 
//		end if	
//		
//		post	wf_inserisci_pesi_riga(0)
//		
//		li_riga_inizio=ll_row
//		li_riga_fine=ll_row
//		wf_impongo_magazzino(li_riga_inizio, li_riga_fine)
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then post wf_cal_costi()
//		
//		
//		
//		ll_id_uc=long(is_ricpar.s_ausil_value[9])
//		select tipo,simbolo
//		into :ls_um,:ls_simbolo
//		from unita_confezione, unita_misura
//		
//		where (unita_confezione.id_unita_confezione=:ll_id_uc) and
//		(unita_misura.id_unita_misura=unita_confezione.id_unita_misura);
//		
//		uf_set_colval("tipo_um", ls_um)	
//		if POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO')>0 THEN 
//			uf_set_colval("simbolo_mov", ls_simbolo)		
//		end if
//		
//		
//		
//		
//		
//		
//		
//		
//
//		
//		if is_prof_dispo='C' or is_prof_dispo='B' then post uf_pre_blocca_dispo(this.getrow())
//		
//
//
//	
//
//	CASE "riga_documento_descrizione"
//		ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
//		LI_RET=wf_controlla_utilizzabile(ll_id_articolo)
//		IF LI_RET=-1 THEN
//				
//				RETURN
//			END IF
//		
//		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
//		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
//		uf_set_colval("c_articolo_cod", is_ricpar.s_ausil_value[1])
//		uf_set_colval("c_articolo_des", is_ricpar.s_main_value)
//		
//		
//		uf_set_colval("articolo_stato", is_ricpar.s_ausil_value[2])
//		
//		
//		
//		uf_set_colval("usimbolo", is_ricpar.s_ausil_value[3])
//		uf_set_colval("udescrizione", is_ricpar.s_ausil_value[4])
//		uf_set_colval("unita_misura_b_simbolo", is_ricpar.s_ausil_value[5])
//		uf_set_colval("unita_misura_b_descrizione", is_ricpar.s_ausil_value[6])
//		uf_set_colval("conversione_peso_comune", is_ricpar.s_ausil_value[7])
//		uf_set_colval("conversione_volume_comune", is_ricpar.s_ausil_value[8])
//		uf_set_colval("riga_documento_id_unita_confezione", is_ricpar.s_ausil_value[9])
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then event ue_set_arti_riga()
//		
//		post event ue_set_contropartita()
//		post event ue_set_calc_riga(ll_row)
//		ldw_status = GetItemStatus( ll_row,0,Primary! )
//		if ldw_status = New! or ldw_status = NewModified! then
//			post uf_scaglione_provvigione() 
//		end if	
//		
//		post wf_inserisci_pesi_riga(0)
//		
//		li_riga_inizio=ll_row
//		li_riga_fine=ll_row
//		wf_impongo_magazzino(li_riga_inizio, li_riga_fine)
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then post wf_cal_costi()
//		
//		
//		select tipo
//		into :ls_um
//		from unita_confezione, unita_misura
//		where (unita_confezione.id_articolo=:is_ricpar.s_id_seg_value[1])and
//		(unita_misura.id_unita_misura=unita_confezione.id_unita_misura);
//		uf_set_colval("simbolo_mov", ls_um)	
//		
//		
//		
//		
//		
//		
//		
//		
//		if is_prof_dispo='C' or is_prof_dispo='B' then post uf_pre_blocca_dispo(this.getrow())
//
//		
//		
//END CHOOSE
//
//if IsValid(ids_lotti) then
//	ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
//	CHOOSE CASE as_nomecol
//	CASE "c_articolo_cod"
//		row=getitemnumber(ll_row,"id_riga_lotto")
//		i= ids_lotti.find("numero = "+string(row),1, ids_lotti.rowcount())
//		if i>0 then	
//			li_ret=ids_lotti.SetItem(i,"id_articolo", ll_id_articolo)
//			if li_ret<>1 then messagebox("Errore", "Non settato id_articolo in lotto")
//		else
//			messagebox("Errore","Lotto non trovato")
//		end if
//		
//		if this.dataobject <> "d_riga_documento_ordine_ritorno_gd" then wf_carico_lotti(ll_row, ll_id_articolo)
//		
//	CASE "riga_documento_descrizione"
//		row=getitemnumber(ll_row,"id_riga_lotto")
//		i= ids_lotti.find("numero = "+string(row),1, ids_lotti.rowcount())
//		if i>0 then	
//			ids_lotti.SetItem(i,"id_articolo",ll_id_articolo)
//		else
//			messagebox("Errore","Lotto non trovato")
//		end if
//		
//		if this.dataobject <> "d_riga_documento_ordine_ritorno_gd" then wf_carico_lotti(ll_row, ll_id_articolo)
//		
//	end choose
//end if
//
end event

event ue_itemerror;call super::ue_itemerror;long ll_ret_value

SetNull(ll_ret_value)
CHOOSE CASE adwo_dwo.name
	CASE "sconto"
		MessageBox(is_title, "Ricontrollare lo sconto immesso.")
		ll_ret_value=2
END CHOOSE
return ll_ret_value
end event

type cbx_vedi_pronto from checkbox within w_correggi_bollettina_2
integer x = 3643
integer y = 188
integer width = 599
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Pronto Generato"
boolean lefttext = true
end type

event clicked;if checked then
	dw_7.visible=true
	dw_10.visible=true
else
	dw_7.visible=false
	dw_10.visible=false
end if
end event

type dw_10 from udw_base within w_correggi_bollettina_2
boolean visible = false
integer x = 23
integer y = 1516
integer width = 1787
integer height = 828
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Pronto Già Esistenti"
string dataobject = "d_pronto_esistente"
boolean hscrollbar = true
end type

event retrievestart;call super::retrievestart;return 2
end event

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0 then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type sle_messaggio from singlelineedit within w_correggi_bollettina_2
integer x = 4283
integer y = 32
integer width = 466
integer height = 44
integer taborder = 10
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 65535
boolean border = false
end type

type rb_13 from radiobutton within w_correggi_bollettina_2
integer x = 3401
integer y = 96
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BARCODE 13"
end type

event clicked;dw_1.dataobject="d_correggi_bollettina_cod_barre"
dw_1.settransobject(sqlca)
cb_carica.visible=false
DW_6.VISIBLE=TRUE
dw_6.insertrow(1)
is_no_reset='S'
dw_6.setfocus()

cbx_no_reset.checked=false
cbx_no_reset.visible=false
end event

type rb_pacchi from radiobutton within w_correggi_bollettina_2
integer x = 3392
integer y = 20
integer width = 466
integer height = 76
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BARCODE PACCHI"
end type

event clicked;dw_1.dataobject="d_correggi_cod_barre_s_bollettina"
dw_1.settransobject(sqlca)
cb_carica.visible=false
DW_6.VISIBLE=TRUE
dw_6.insertrow(1)
is_no_reset='S'
dw_6.setfocus()

cbx_no_reset.visible=true	
end event

type sle_1 from singlelineedit within w_correggi_bollettina_2
integer x = 3899
integer y = 280
integer width = 681
integer height = 88
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "c:\nita\sped"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_correggi_bollettina_2
integer x = 3049
integer y = 200
integer width = 343
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Salva PDF in"
boolean focusrectangle = false
end type

type cbx_no_reset from checkbox within w_correggi_bollettina_2
boolean visible = false
integer x = 3886
integer y = 20
integer width = 439
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
string text = "Non Resettare"
end type

type rb_bar_2020 from radiobutton within w_correggi_bollettina_2
integer x = 3799
integer y = 92
integer width = 466
integer height = 76
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BARCODE 2020"
end type

event clicked;if checked then
	dw_1.dataobject="d_correggi_cod_barre_s_bol_2020"
	dw_1.settransobject(sqlca)
	cb_carica.visible=false
	DW_6.VISIBLE=TRUE
	dw_6.insertrow(1)
	is_no_reset='S'
	dw_6.setfocus()
	dw_11.visible=true
	cbx_no_reset.visible=true
	dw_1.height=parent.height -1750
else
	dw_11.visible=false
end if

end event

type cb_rnl from commandbutton within w_correggi_bollettina_2
integer x = 2519
integer y = 252
integer width = 165
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "RNL"
end type

event clicked;long ll_riga, ll_id_art, ll_Id_uc
string ls_num_bol
decimal ldc_peso

if rb_barcode.checked then return
ll_riga=dw_1.getrow()

if ll_riga >0 then
	ls_num_bol=dw_1.getitemstring(ll_riga, "documento_num_documento")
	if messagebox("RESO NON LAVORATO", "Sei sicuro di voler Cambiare la bollettina "+ls_num_bol+" a RESO NON LAVORATO?", stopsign!, yesno!)=1 then
		select a.id_articolo, id_unita_confezione into :ll_id_art, :ll_id_uc
		from unita_confezione u, articolo a 
		where a.id_articolo=u.id_articolo and u.unita_base='S' and a.codice='RNL';
		if ll_id_uc>0 then
			//dw_1.SETITEM(ll_riga, "riga_documento_descrizione", "RESO NON LAVORATO") //questo non lo vuole più ... 2021089
			dw_1.SETITEM(ll_riga, "id_articolo", ll_id_art)
			dw_1.SETITEM(ll_riga, "id_unita_confezione", ll_id_uc)
			dw_1.SETITEM(ll_riga, "articolo_codice", "RNL")
		 	//20250327 se il peso sull'RNL =0 devo avvisare e segnare la riga come modificata (modifica solo se si mette il peso)
			ldc_peso=dw_1.getitemdecimal(ll_riga, "peso_netto")
			if ldc_peso= 0 or isnull(ldc_peso) then
				if messagebox("RESO NON LAVORATO"," Manca il peso!!!! Segno lo stesso come corretta la bollettina?", stopsign!, yesno!)=1 then
					dw_1.SETITEM(ll_riga, "ordinato_fo", "S")
				end if
			end if
			messagebox("RESO NON LAVORATO"," Fatto! Le modifiche avranno effetto solo dopo che avrai SALVATO!")
		end if
	end if
	
end if
end event

type dw_11 from udw_001 within w_correggi_bollettina_2
boolean visible = false
integer x = 37
integer y = 1504
integer width = 2697
integer height = 1180
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_new_pacco_bollettina"
boolean maxbox = false
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;//return 2
end event

