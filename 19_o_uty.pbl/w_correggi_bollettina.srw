//objectcomments da cancellare a favore del corerggi bollettina 2
forward
global type w_correggi_bollettina from w_001
end type
type dw_1 from udw_base within w_correggi_bollettina
end type
type dw_2 from udw_base within w_correggi_bollettina
end type
type cb_carica from commandbutton within w_correggi_bollettina
end type
type cb_salva from commandbutton within w_correggi_bollettina
end type
type cb_esci from commandbutton within w_correggi_bollettina
end type
type dw_3 from udw_base within w_correggi_bollettina
end type
type cb_stampa from commandbutton within w_correggi_bollettina
end type
type cbx_vedi from checkbox within w_correggi_bollettina
end type
type cbx_bilancia from checkbox within w_correggi_bollettina
end type
type dw_4 from udw_base within w_correggi_bollettina
end type
type dw_5 from udw_base within w_correggi_bollettina
end type
type cbx_sfrido from checkbox within w_correggi_bollettina
end type
type dw_6 from udw_base within w_correggi_bollettina
end type
type rb_barcode from radiobutton within w_correggi_bollettina
end type
type rb_data from radiobutton within w_correggi_bollettina
end type
type ole_1 from olecustomcontrol within w_correggi_bollettina
end type
type st_2 from statictext within w_correggi_bollettina
end type
end forward

global type w_correggi_bollettina from w_001
integer width = 3502
integer height = 1736
string title = "Correggi Bollettine"
boolean minbox = true
boolean maxbox = true
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
dw_6 dw_6
rb_barcode rb_barcode
rb_data rb_data
ole_1 ole_1
st_2 st_2
end type
global w_correggi_bollettina w_correggi_bollettina

type variables
string is_ultimo_campo, is_no_reset
decimal ldc_val_pz_originali[]
integer ii_13
end variables

forward prototypes
private function string wf_bilancia ()
public subroutine wf_set_col (string as_col)
public function long wf_crea_doc_sfrido (long al_id_registro, long al_id_prof_doc, long al_id_valuta, long al_id_locazione, long al_id_causale)
public subroutine wf_crea_riga_sfrido (long al_id_doc, decimal adc_peso, decimal adc_qta, decimal adc_coef_calo, long al_id_art, long al_id_causale, long al_id_locazione, long al_id_doc_prov, long al_id_valuta, long al_id_doc_provenienza, long al_id_art_padre)
public subroutine wf_crea_pdf ()
end prototypes

private function string wf_bilancia ();long	ll_row
string Buffer, buffer2
integer li_pos
decimal ld_peso_netto
string ls_peso
boolean lb_test
//' Open the serial port

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
integer li_File
ls_nome_file="c:\start\spediz\"

ls_nome_file+="SPED_"+string(today(), "dd-mm-yy")+".pdf"

ls_test=dw_1.Modify("DataWindow.Print.documentname = '"+ls_nome_file+"'")
ls_test=dw_1.Modify("DataWindow.Print.filename = '"+ls_nome_file+"'")

if ls_test="" then 
	ls_stampante="Acrobat PDFWriter"
	ls_test=dw_1.Modify("DataWindow.Print.printername = '"+ls_stampante+"'")
	dw_1.print()
else
	messagebox("Errore!", "File PDF non generato!")	
end if

end subroutine

event open;call super::open;date ldt_da_data

dw_2.settransobject(sqlca)
dw_2.insertrow(1)
dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)
ldt_da_data=dw_2.getitemdate(1, "a_data")
ldt_da_data=relativedate(ldt_da_data, -30)
dw_2.setitem(1, "da_data", ldt_da_data)

dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)


end event

on w_correggi_bollettina.create
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
this.dw_6=create dw_6
this.rb_barcode=create rb_barcode
this.rb_data=create rb_data
this.ole_1=create ole_1
this.st_2=create st_2
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
this.Control[iCurrent+13]=this.dw_6
this.Control[iCurrent+14]=this.rb_barcode
this.Control[iCurrent+15]=this.rb_data
this.Control[iCurrent+16]=this.ole_1
this.Control[iCurrent+17]=this.st_2
end on

on w_correggi_bollettina.destroy
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
destroy(this.dw_6)
destroy(this.rb_barcode)
destroy(this.rb_data)
destroy(this.ole_1)
destroy(this.st_2)
end on

event resize;call super::resize;dw_1.height= newheight - 350
dw_1.width= newwidth - 80

end event

type st_1 from w_001`st_1 within w_correggi_bollettina
end type

type dw_1 from udw_base within w_correggi_bollettina
integer x = 32
integer y = 376
integer width = 3223
integer height = 1124
boolean bringtotop = true
string dataobject = "d_correggi_bollettina"
end type

event itemchanged;call super::itemchanged;decimal{2} ld_fino, ld_coef_calo, ldc_peso, ld_calo
long ll_id_titolo, ll_id_art
integer li_ret
decimal ldc_ordine, ldc_tara


choose case string(dwo.name)
	case "ordinato_fo"
		post setitem(row, "riga_doc_estensione_data_ora_modifica", today())	
	case "quantita", "peso_netto"
		post setitem(row, "ordinato_fo", "S")
		post setitem(row, "riga_doc_estensione_data_ora_modifica", today())
		if isnull(getitemnumber(row, "provv_subage_2")) or getitemnumber(row, "provv_subage_2")<=0  then
			ldc_ordine=getitemdecimal(row, "c_ordine")
			post setitem(row, "provv_subage_2", ldc_ordine)
		end if
		if string(dwo.name)='peso_netto' then
		
			ldc_peso=dec(data)	
			ll_id_art=getitemnumber(row, "id_articolo")
			//ad_peso=ad_peso - ld_peso_non_prezioso
			select id_titolo
			into :ll_id_titolo
			from articolo
			where id_articolo=:ll_id_art
			;
			
				
			ld_fino=f_converti_in_fino(ldc_peso, ll_id_titolo)
			li_ret=dw_1.setitem(row, "fino", ld_fino)
			if li_ret<>1 then messagebox("Errore!", "Fino non settato")
			ld_coef_calo=dw_1.getitemdecimal(row, "coef_calo")
			if ld_coef_calo>0 and not isnull(ld_coef_calo) then
					ld_calo=f_round(ldc_peso*(ld_coef_calo)/1000, -2, 'M')
					ld_calo= f_round(ld_calo - ld_fino, -2, 'M')
					li_ret=dw_1.setitem(row, "calo",ld_calo) 
					if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
			elseif ld_coef_calo=0 then 
				li_ret=dw_1.setitem(row, "calo",0)
				if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
			else
					
	
			end if
			
		end if
		case "peso_lordo_tara"
		//se modifica tara devo modificare peso netto (grammi)
		ldc_tara=dec(data)
		if ldc_tara> 0 then
			ldc_peso= getitemdecimal(row, "peso_netto")
			if ldc_peso>ldc_tara then
				setitem(row, "peso_netto", ldc_peso - ldc_tara) 
				post event itemchanged(row, object.peso_netto, string(ldc_peso - ldc_tara))
				
			else
				messagebox("Attenzione!", "Tara maggiore del peso!")
				return 2
			end if
		end if
end choose
		
		
end event

event itemfocuschanged;call super::itemfocuschanged;dwobject my_dwo
string data
decimal ldc_peso, ldc_null
setnull(ldc_null)



if dwo.name='peso_netto' and is_ultimo_campo='quantita' and cbx_bilancia.checked then
	data=wf_bilancia()
	my_dwo = this.object.peso_netto
	ldc_peso=dec(data)
	
	setitem(row,"peso_netto",ldc_peso)
	this.trigger event itemchanged(row, my_dwo, data)
	if ldc_peso<1 then
		messagebox("ATTENZIONE!", "Il peso è inferiore ad 1 grammo!")
		setitem(row, "peso_netto", ldc_null)
		
	end if
end if
choose case string(dwo.name)
	case	"peso_lordo_tara"
		if getitemdecimal(row, "peso_lordo_tara")=0 then
			setitem(row, "peso_lordo_tara", ldc_null)
		end if
end choose

is_ultimo_campo=dwo.name
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow>0 then
	
	is_ultimo_campo="peso_netto"
	post wf_set_col("quantita")
end if
end event

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

long ll_id_riga
if row>0 then
	ll_id_doc=getitemnumber(row, "id_documento")
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
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

type dw_2 from udw_base within w_correggi_bollettina
integer x = 969
integer y = 24
integer width = 2025
integer height = 212
boolean bringtotop = true
string dataobject = "d_correggi_bol_selezione"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_carica from commandbutton within w_correggi_bollettina
integer x = 955
integer y = 248
integer width = 256
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

type cb_salva from commandbutton within w_correggi_bollettina
integer x = 1253
integer y = 248
integer width = 256
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

event clicked;integer i, li_righe_comp, a, ldc_qta_distinta, li_num_riga[]
long LL_ID_RIGA, ll_id_art, ll_id_art_comp, ll_id_doc, ll_id_art_trovati[]
decimal ldc_peso, ldc_peso_distinta, ldc_coef_calo, ldc_perc_sfrido, ldc_qta
integer e
long ll_id_doc_sfrido, ll_id_caus, ll_id_locazione, ll_id_valuta
long ll_id_prof, ll_id_registro, ll_id_mod_registro, ll_num_prog
string ls_sfrido
datetime ldt_data_modifica
decimal ldc_coef_var

ls_sfrido=cbx_sfrido.text
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
			insert into dba.riga_doc_estensione
			(id_riga_documento, data_ora_modifica)
			values (:ll_id_riga, :ldt_data_modifica)
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				update dba.riga_doc_estensione
				set data_ora_modifica=today()
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
			ldc_qta=dw_1.getitemnumber(i, "quantita")
			//trovo coef_variazione del padre per riportarlo sui figli
			if ldc_val_pz_originali[i]>0 then
				ldc_coef_var=ldc_qta/ldc_val_pz_originali[i]
			else
				ll_num_prog=dw_1.getitemnumber(i, "num_progressivo")
				Messagebox("Attenzione!", "Verificare doc. n.prog.:"+string(ll_num_prog)+" - Potrebbe avere pezzi=0!")
				ldc_coef_var=1
			end if
			
			ldc_coef_calo=dw_1.getitemdecimal(i, "coef_calo")
			//faccio il retireve per id_art_padre e trovo le righe dei componenti
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
	
		messagebox("OK!", "Salvataggio Eseguito con Successo!")
	else
		messagebox("Ahi!", "Salvataggio NON riuscito!")
	end if
//else
	//messagebox("Ahi!", "Documento di sfrido non creato! Bloccato Tutto!")
//end if
end event

type cb_esci from commandbutton within w_correggi_bollettina
integer x = 2569
integer y = 248
integer width = 151
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

type dw_3 from udw_base within w_correggi_bollettina
integer x = 14
integer y = 24
integer width = 914
integer height = 328
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_correggi_componenti_bol"
boolean hscrollbar = true
end type

type cb_stampa from commandbutton within w_correggi_bollettina
integer x = 2368
integer y = 248
integer width = 174
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

event clicked;dw_1.setsort("provv_subage_2")
dw_1.sort()
printsetup()
dw_1.modify("riga_doc_estensione_data_ora_modifica.visible=0")
dw_1.modify("c_peso_unitario.visible=1")
dw_1.modify("dim_l.visible=1")
dw_1.modify("t_peso_unitario.visible=1")
dw_1.modify("t_dim_l.visible=1")
dw_1.print()
wf_crea_pdf()
dw_1.modify("riga_doc_estensione_data_ora_modifica.visible=1")
dw_1.modify("c_peso_unitario.visible=0")
dw_1.modify("dim_l.visible=0")
dw_1.modify("t_peso_unitario.visible=0")
dw_1.modify("t_dim_l.visible=0")
//
end event

type cbx_vedi from checkbox within w_correggi_bollettina
integer x = 1550
integer y = 264
integer width = 480
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

type cbx_bilancia from checkbox within w_correggi_bollettina
integer x = 2057
integer y = 240
integer width = 270
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
string text = "Bilancia"
boolean checked = true
end type

type dw_4 from udw_base within w_correggi_bollettina
boolean visible = false
integer x = 32
integer y = 1544
integer width = 2958
integer height = 244
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_crea_doc_sfrido"
boolean hscrollbar = true
boolean vscrollbar = false
end type

type dw_5 from udw_base within w_correggi_bollettina
boolean visible = false
integer x = 32
integer y = 1784
integer width = 2958
integer height = 612
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_crea_riga_sfrido"
boolean hscrollbar = true
boolean vscrollbar = false
end type

type cbx_sfrido from checkbox within w_correggi_bollettina
integer x = 2057
integer y = 304
integer width = 274
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
string text = "Sfrido"
end type

type dw_6 from udw_base within w_correggi_bollettina
boolean visible = false
integer x = 2729
integer y = 200
integer width = 736
integer height = 176
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ins_barcode_plurimo_ext"
boolean vscrollbar = false
end type

event editchanged;call super::editchanged;long ll_id_bollettina,ll_id_test, ll_riga_inserita,ll_riga2_inserita
string ls_num_doc, ls_test
//
if dwo.name="cod_barre"  then
	if len(data)=2 then
		if data='80' then
			ii_13=13
		else
			ii_13=7
		end if
	end if
	
	if len(data)=7 and ii_13<>13 then
		ls_num_doc=mid(data, 3, 5)
		select id_documento
		into :ll_id_bollettina
		from dba.documento d, dba.prof_documento p
		where right(num_documento, 5)=:ls_num_doc
		and (p.codice='BOL' or p.codice='SBOL')
		;
		if ll_id_bollettina>0 then
			
			dw_1.retrieve(ll_id_bollettina)
		else
			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
		end if
		dw_6.reset()
		dw_6.insertrow(1)
	elseif len(data)=13 then
		ls_num_doc=mid(data, 8, 5)
		select id_documento
		into :ll_id_bollettina
		from dba.documento d, dba.prof_documento p
		where right(num_documento, 5)=:ls_num_doc
		and (p.codice='BOL' or p.codice='SBOL')
		;
		if ll_id_bollettina>0 then
			dw_1.retrieve(ll_id_bollettina)
		else
			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
		end if
		dw_6.reset()
		dw_6.insertrow(1)
	end if
end if

//
////se il doc è già legato nella produzione non faccio nulla
//select id_bollettina
//into :ll_id_test
//from dba.produzione_2011
//where id_doc_produzione=:il_id_doc;
//if isnull(ll_id_test) or ll_id_test=0 then
//	//allora inserisco questo documento legato alla bolelttina da cui proviene
//	ls_num_doc=idw_gen.getitemstring(1, "num_documento")
//	ls_num_doc=right(ls_num_doc, 5)
//	//adesso trovo la bollettina
//	select id_documento
//	into :ll_id_bollettina
//	from dba.documento d, dba.prof_documento p
//	where right(num_documento, 5)=:ls_num_doc
//	and (p.codice='BOL' or p.codice='SBOL')
//	;
//	if ll_id_bollettina>0 then
//		insert into dba.produzione_2011 (id_bollettina, id_doc_produzione)
//		values(:ll_id_bollettina, :il_id_documento)
//		;
//		if sqlca.sqlcode=0 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "Questo Doc. non è stato legato alla bollettina: "+ls_num_doc+"!")
//		end if
//	else
//		messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
//	end if
//end if














//long ll_id, ll_codice
//
//string ls_tipo
//
//if dwo.name="cod_barre"  then
//	if len(data)=13 then
//		ll_codice=long(mid(data, 8, 5))
//		
//		select id_dipendente
//		into :ll_id
//		from dba.dipendente
//		where codice=:ll_codice
//		;
//		setitem(row, "id_dipendente", ll_id)
//		setitem(row, "data", today())
//		setitem(row, "ora", now())
//		select max(tipo)
//		into :ls_tipo
//		from dba.ore
//		where id_dipendente=:ll_id
//		and data=today()
//		;
//		choose case ls_tipo 
//			case "E" 
//				setitem(row, "tipo", "P")
//				case "P" 
//				setitem(row, "tipo", "R")
//				case "R" 
//				setitem(row, "tipo", "U")
//				
//			case else
//				setitem(row, "tipo", "E")
//		end choose
//		dw_1.settransobject(sqlca)
//		cb_salva.triggerevent("clicked") 
//		
////		lt_time1=now()
////		lt_time1=relativetime(lt_time1, 1)
////		do
////			lt_time=now()
////		loop while lt_time<=lt_time1
////
//		post reset()
//		post event ue_insert(0)
//		dw_1.setcolumn("id_dipendente")
//	end if
//end if
end event

type rb_barcode from radiobutton within w_correggi_bollettina
integer x = 3022
integer y = 20
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "BARCODE"
end type

event clicked;dw_1.dataobject="d_correggi_bollettina_cod_barre"
dw_1.settransobject(sqlca)
cb_carica.visible=false
DW_6.VISIBLE=TRUE
dw_6.insertrow(1)
is_no_reset='S'
end event

type rb_data from radiobutton within w_correggi_bollettina
integer x = 3022
integer y = 100
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "PER DATA"
end type

event clicked;dw_1.dataobject="d_correggi_bollettina"
dw_1.settransobject(sqlca)
DW_6.VISIBLE=false
cb_carica.visible=true
is_no_reset='N'
end event

type ole_1 from olecustomcontrol within w_correggi_bollettina
event oncomm ( )
integer x = 201
integer y = 404
integer width = 174
integer height = 152
integer taborder = 60
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_correggi_bollettina.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type st_2 from statictext within w_correggi_bollettina
integer x = 334
integer y = 680
integer width = 2798
integer height = 368
boolean bringtotop = true
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "NON USARE !!!!!!!!!"
boolean focusrectangle = false
end type

