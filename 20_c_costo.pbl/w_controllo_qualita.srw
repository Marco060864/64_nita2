forward
global type w_controllo_qualita from w_001
end type
type dw_1 from udw_base within w_controllo_qualita
end type
type dw_3 from udw_base within w_controllo_qualita
end type
type cb_passa from commandbutton within w_controllo_qualita
end type
type cb_1 from commandbutton within w_controllo_qualita
end type
type dw_9 from udw_base within w_controllo_qualita
end type
type dw_2 from udw_figlia within w_controllo_qualita
end type
type dw_8 from udw_base within w_controllo_qualita
end type
type rb_2018 from radiobutton within w_controllo_qualita
end type
type rb_2019 from radiobutton within w_controllo_qualita
end type
type rb_2020 from radiobutton within w_controllo_qualita
end type
type rb_2021 from radiobutton within w_controllo_qualita
end type
type rb_2022 from radiobutton within w_controllo_qualita
end type
type cb_2 from commandbutton within w_controllo_qualita
end type
type cb_st_doc from commandbutton within w_controllo_qualita
end type
type cb_reset from commandbutton within w_controllo_qualita
end type
type pb_spazzola from picturebutton within w_controllo_qualita
end type
type cbx_controllo from checkbox within w_controllo_qualita
end type
type st_2 from statictext within w_controllo_qualita
end type
type pb_buratto from picturebutton within w_controllo_qualita
end type
type rr_1 from roundrectangle within w_controllo_qualita
end type
end forward

global type w_controllo_qualita from w_001
boolean visible = false
integer x = 1057
integer y = 483
integer width = 4530
integer height = 2748
string title = "INVIO MERCE IN GALVANICA"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_3 dw_3
cb_passa cb_passa
cb_1 cb_1
dw_9 dw_9
dw_2 dw_2
dw_8 dw_8
rb_2018 rb_2018
rb_2019 rb_2019
rb_2020 rb_2020
rb_2021 rb_2021
rb_2022 rb_2022
cb_2 cb_2
cb_st_doc cb_st_doc
cb_reset cb_reset
pb_spazzola pb_spazzola
cbx_controllo cbx_controllo
st_2 st_2
pb_buratto pb_buratto
rr_1 rr_1
end type
global w_controllo_qualita w_controllo_qualita

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
integer li_anno
string is_ultima_colonna
end variables

forward prototypes
public subroutine wf_articolo (long al_id_articolo, long al_riga_doc)
public function long wf_importa (integer ai_riga)
public subroutine wf_agg_fino_calo (decimal adc_legato, long al_riga_inserita)
public subroutine wf_storna_legato (decimal adc_peso_da_stornare)
public subroutine wf_ges_lacci_fili (string as_tipo, integer ai_num_lacci_fili)
public subroutine wf_bilancia (long al_riga_inserita, long al_id_bollettina_doc)
public function string wf_corretto_nonpiu_blocco (long al_id_art, string as_tipo, string as_flag)
end prototypes

public subroutine wf_articolo (long al_id_articolo, long al_riga_doc);//string ls_codice
//long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_tab_iva
//long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc
//
//setnull(ll_null)
//ll_riga_trovata=dw_4.find("id_articolo="+string(al_id_articolo), 1, dw_4.rowcount())
//if ll_riga_trovata>0 then
//	ls_codice=dw_4.getitemstring(ll_riga_trovata, "codice")
//	select id_articolo
//	into :ll_id_art_locale
//	from dba.articolo
//	where codice=:ls_codice
//	USING trans_destinazione
//;
//	if ll_id_art_locale>0 then //l'articolo esiste già non si deve fare nulla a parte recuperare la uc ...
//		dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
//		ll_riga_uc=dw_7.retrieve(ll_id_art_locale)
//		if ll_riga_uc>0 then
//			ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
//			dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
//		else
//			
//		end if
//	else //l'articolo non esiste occorre inserirlo
//		dw_6.reset()
//		dw_7.reset()
//		ll_riga_trovata_uc=dw_5.find("id_articolo="+string(al_id_articolo), 1, dw_5.rowcount())
//		if ll_riga_trovata_uc>0 then
//			dw_4.rowscopy(ll_riga_trovata, ll_riga_trovata, primary!, dw_6, 1, primary!)
//			dw_6.setitem(1, "id_articolo", ll_null)
//			dw_6.setitem(1,"id_sog_comm_variante", ll_null)
//			ll_id_tab_iva=dw_6.getitemnumber(1, "id_tab_iva")
//			if isnull(ll_id_tab_iva) then dw_6.setitem(1, "id_tab_iva",122) //22%
//			dw_6.setitemstatus(1, 0, Primary!, NewModified!)
//			
//			dw_6.trigger event ue_update()
//			ll_id_art_locale=dw_6.getitemnumber(1, "id_articolo")
//			dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
//			ll_id_um=dw_5.getitemnumber(ll_riga_trovata_uc, "id_unita_misura")
//			ll_riga_uc=dw_7.retrieve(ll_id_art_locale)
//			if ll_riga_uc>0 then
//				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
//				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
//				dw_7.setitem(1, "id_unita_misura", ll_id_um)
//				dw_7.trigger event ue_update()
//			else
//				dw_5.rowscopy(ll_riga_trovata_uc, ll_riga_trovata_uc, primary!, dw_7, 1, primary!)
//				dw_7.SetItem(1,"id_unita_confezione", ll_null)
//				dw_7.setitem(1, "id_articolo", ll_id_art_locale)
//				dw_7.setitemstatus(1, 0, Primary!, NewModified!)
//				dw_7.trigger event ue_update()	
//				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
//				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
//			end if
//		end if
//	end if
//end if
end subroutine

public function long wf_importa (integer ai_riga);long ll_id_prof,  ll_id_locazione, ll_id_causale,  ll_id_magazzino, ll_id_mod_reg, ll_id_registro, ll_id_doc, ll_null, ll_num_prog
date ldt_data_odierna, ldt_data_doc
integer li_ret, i
string ls_tipo_registro, ls_numero, ls_nota, ls_id_doc
long ll_righe, ll_return, ll_num_prog_nuovo,ll_id_riga_doc_provenienza, ll_riga_doc_inserito

setnull(ll_null)

ll_id_prof=dw_3.getitemnumber(1,"id_prof_destinazione")
if isnull(ll_id_prof) then
	messagebox("Attenzione!", "Il profilo di destinazione DEVE essere valorizzato! Operazione annullata!")
	return -1
end if
select id_locazione_1_prop, id_magazzino_1_prop, id_mod_registro_prop, id_caus_magazzino_prop
into :ll_id_locazione, :ll_id_magazzino, :ll_id_mod_reg, :ll_id_causale
from dba.prof_documento
where id_prof_documento=:ll_id_prof
;
//con il modello registro recupero il registro nell'esercizio corrente
ldt_data_odierna=date(today())
select r.id_registro, r.num_progressivo
into :ll_id_registro, :ll_num_prog_nuovo
from dba.registro r, esercizio e
where r.id_mod_registro=:ll_id_mod_reg
and e.id_esercizio=r.id_esercizio
and e.data_inizio<=:ldt_data_odierna
and e.data_fine>=:ldt_data_odierna
;

//l'ID DOCUMENTO lo salvo poi nell'origine documento
ll_id_doc=dw_1.getitemnumber(1, "id_documento")

//controllo che il documento non esista già ?NON posso più perché faccio un solo doc a fronte
ls_id_doc=string(ll_id_doc)
select num_progressivo
into :ll_num_prog
from dba.documento
where origine=:ls_id_doc
;
if ll_num_prog>0 then
	messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog)+"!")
else
	
	//fine controllo
	ls_numero=dw_1.getitemstring(1, "num_documento")
	ldt_data_doc=dw_1.getitemdate(1, "data_documento")
	ll_num_prog=0

	//24052017  segno nel campo "origine" che è inserito in automatico da questo passaggio dati 24052017
	dw_1.SetItem(1, "origine",  string(ll_id_doc))
	ls_nota="Rif. Doc. n. "+ls_numero+" del "+string(ldt_data_doc)
	dw_1.SetItem(1, "note_intestazione",  "Ins. AUTOMATICO  "+ls_nota)
	//occorrono: il nuovo profilo con causale, magazzino, registro, num_progressivo (il num_doc = a quello derivato e la data è del giorno)
	dw_1.SetItem(1, "data_documento", ldt_data_odierna)
	dw_1.SetItem(1, "data_registrazione", ldt_data_odierna)
	dw_1.SetItem(1, "id_prof_documento", ll_id_prof)
	dw_1.SetItem(1, "id_caus_magazzino", ll_id_causale)
	dw_1.SetItem(1, "id_magazzino", ll_id_magazzino)
	dw_1.SetItem(1, "id_locazione_1", ll_id_locazione)
	dw_1.SetItem(1, "id_registro", ll_id_registro)
	dw_1.SetItem(1, "num_progressivo", ll_num_prog_nuovo)
	//fine 24052017
	dw_1.SetItem(1, "id_documento", ll_null)
	dw_1.setitemstatus(1, 0, Primary!, NewModified!)
	//salvo doc
	li_ret=dw_1.trigger event ue_update()
	//ora le righe
	setnull(ll_id_doc)
	ll_id_doc=dw_1.getItemnumber(1, "id_documento")
	if ll_id_doc>0 then
		ll_righe=dw_2.rowcount()
		for i= 1 to ll_righe
			dw_2.SetItem(i, "id_documento", ll_id_doc)
			dw_2.SetItem(i, "id_caus_magazzino", ll_id_causale)
			dw_2.SetItem(i, "id_locazione_1", ll_id_locazione)
			ll_id_riga_doc_provenienza=dw_2.getitemnumber(i, "id_riga_documento")
			dw_2.SetItem(i, "id_riga_doc_provenienza", ll_id_riga_doc_provenienza)
			dw_2.SetItem(i, "id_riga_documento", ll_null)
			dw_2.setitemstatus(i, 0, Primary!, NewModified!)
		next
		//salvo righe
		li_ret=dw_2.trigger event ue_update()
		if li_ret=1 then
			ll_return=ll_id_doc
			//inserisco il doc nella tabella dei doc passati per l'eventuale stampa a memoria
			ll_riga_doc_inserito=dw_9.insertrow(0)
			dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ll_num_prog_nuovo)
			dw_9.setitem(ll_riga_doc_inserito, "num_documento",	ls_numero)
			dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_odierna)
		end if
	else
		messagebox("Attenzione!", "Doc NON salvato!!")
	end if
end if


return ll_return
	
	
	

end function

public subroutine wf_agg_fino_calo (decimal adc_legato, long al_riga_inserita);decimal ldc_coef_calo, ldc_titolo, ldc_calo, ldc_fino
long	 ll_id_articolo


ldc_coef_calo=dw_2.getitemdecimal(al_riga_inserita, "coef_calo")
ll_id_articolo=dw_2.getitemnumber(al_riga_inserita, "id_articolo")
select titolo
into :ldc_titolo
from orafo_titolo t, articolo a
where a.id_titolo=t.id_titolo
and a.id_articolo=:ll_id_articolo
;
ldc_fino=round(adc_legato*ldc_titolo/1000, 2)
ldc_calo=round(adc_legato*ldc_coef_calo/1000,2) - ldc_fino
dw_2.setitem(al_riga_inserita, "fino", ldc_fino)
dw_2.setitem(al_riga_inserita, "calo", ldc_calo)
end subroutine

public subroutine wf_storna_legato (decimal adc_peso_da_stornare);decimal ldc_legato

ldc_legato=dw_3.getitemdecimal(1, "legato")
if ldc_legato - adc_peso_da_stornare<=0 then
	//messagebox("Attenzione!" , "Peso minore di 0!!!") //commento perché blocca il lavoro... metto legato=0 e zitto 20220728
	ldc_legato=0
else
	ldc_legato -=adc_peso_da_stornare
end if
dw_3.setitem(1, "legato", ldc_legato)
dw_2.setitem(dw_2.rowcount(), "peso_netto", ldc_legato)

wf_agg_fino_calo(ldc_legato, dw_2.rowcount())

end subroutine

public subroutine wf_ges_lacci_fili (string as_tipo, integer ai_num_lacci_fili);date ldt_data_doc
decimal ldc_peso_lacci
	
ldt_data_doc=dw_3.getitemdate(1, "doc_data")

if ai_num_lacci_fili>0 then
	ldc_peso_lacci=f_rec_prezzo_laccio_filo_rame( as_tipo, ldt_data_doc)
	ldc_peso_lacci *=ai_num_lacci_fili
	if as_tipo='L' then
		dw_2.setitem(dw_2.rowcount(), "provv_imp_carea_2", ai_num_lacci_fili)
	else
		dw_2.setitem(dw_2.rowcount(), "provv_imp_agente_2", ai_num_lacci_fili)
	end if
	wf_storna_legato(ldc_peso_lacci)
end if
end subroutine

public subroutine wf_bilancia (long al_riga_inserita, long al_id_bollettina_doc);DWObject my_dwo
decimal ld_peso_netto,ldc_coef_calo, ldc_titolo, ldc_calo, ldc_fino
long	ll_row, ll_id_articolo, ll_riga_trovata
string ls_metallo,ls_test



w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()
dw_3.setitem(1, "legato", ld_peso_netto)
dw_2.setitem(al_riga_inserita, "peso_netto", ld_peso_netto)
ls_test="id_documento="+string(al_id_bollettina_doc)
ll_riga_trovata=dw_8.find(ls_test, 1, dw_1.rowcount())
if ll_riga_trovata>0 then
	dw_8.setitem(ll_riga_trovata, "peso_netto", ld_peso_netto)
end if
wf_agg_fino_calo(ld_peso_netto, al_riga_inserita)
if ld_peso_netto=0 or isnull(ld_peso_netto) then 
	dw_3.setfocus()
	dw_3.setcolumn("cod_barre")
end if
close(w_bil)
end subroutine

public function string wf_corretto_nonpiu_blocco (long al_id_art, string as_tipo, string as_flag);string ls_corretto, ls_non_segnare_piu, ls_blocco_assoluto, ls_ret

//20230628 per gestire i controlli da tabella art_senza_spazzolatura
select corretto, non_segnare_piu, blocco_assoluto into :ls_corretto, :ls_non_segnare_piu, :ls_blocco_assoluto from dba.art_senza_spazzolatura
where id_articolo=:al_id_art and tipo=:as_tipo;
if as_flag="B" then
	ls_ret=ls_blocco_assoluto //blocco assoluto
else
	if ls_corretto="S" then ls_ret="S" //già corretto
	if ls_non_segnare_piu="S" then ls_ret+="S" //non segnare più
end if


return ls_ret
end function

on w_controllo_qualita.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_passa=create cb_passa
this.cb_1=create cb_1
this.dw_9=create dw_9
this.dw_2=create dw_2
this.dw_8=create dw_8
this.rb_2018=create rb_2018
this.rb_2019=create rb_2019
this.rb_2020=create rb_2020
this.rb_2021=create rb_2021
this.rb_2022=create rb_2022
this.cb_2=create cb_2
this.cb_st_doc=create cb_st_doc
this.cb_reset=create cb_reset
this.pb_spazzola=create pb_spazzola
this.cbx_controllo=create cbx_controllo
this.st_2=create st_2
this.pb_buratto=create pb_buratto
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_passa
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_9
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_8
this.Control[iCurrent+8]=this.rb_2018
this.Control[iCurrent+9]=this.rb_2019
this.Control[iCurrent+10]=this.rb_2020
this.Control[iCurrent+11]=this.rb_2021
this.Control[iCurrent+12]=this.rb_2022
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.cb_st_doc
this.Control[iCurrent+15]=this.cb_reset
this.Control[iCurrent+16]=this.pb_spazzola
this.Control[iCurrent+17]=this.cbx_controllo
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.pb_buratto
this.Control[iCurrent+20]=this.rr_1
end on

on w_controllo_qualita.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_passa)
destroy(this.cb_1)
destroy(this.dw_9)
destroy(this.dw_2)
destroy(this.dw_8)
destroy(this.rb_2018)
destroy(this.rb_2019)
destroy(this.rb_2020)
destroy(this.rb_2021)
destroy(this.rb_2022)
destroy(this.cb_2)
destroy(this.cb_st_doc)
destroy(this.cb_reset)
destroy(this.pb_spazzola)
destroy(this.cbx_controllo)
destroy(this.st_2)
destroy(this.pb_buratto)
destroy(this.rr_1)
end on

event open;call super::open;s_list_main ls_list
long ll_id_prof
integer li_ret
string ls_prof_id

dw_8.settransobject(sqlca)
dw_9.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.insertrow(1)

//dw_3.setitem(1, "da_data", relativedate(today(), - 30))

datawindowchild dwc_fornitori
 
li_ret= dw_3.GetChild('id_sog_com', dwc_fornitori)
 IF li_ret = -1 THEN MessageBox("Error", "Not a DataWindowChild")
CONNECT USING SQLCA;
dwc_fornitori.SetTransObject(SQLCA)
dwc_fornitori.Retrieve()
dwc_fornitori.setfilter("sog_commerciale_tipo='F'")
dwc_fornitori.filter()

ls_list=message.powerobjectparm
ll_id_prof=long(ls_list.s_win_parametri)
if ll_id_prof>0 then dw_3.setitem(1, "id_prof_destinazione", ll_id_prof)
if ll_id_prof=184 then //buratto
	title=upper("Invio Merce al reparto Buratto")
	dw_3.setitem(1, "id_sog_com", 2049)  //reparto buratti
	cb_passa.text="A Burattare"
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	//pb_buratto.visible=true   ////20230828 stampa che mostra anche attesa secondo il paramentro passato
elseif ll_id_prof=196 then  //laser
	title=upper("Invio Merce al reparto LASER")
	dw_3.setitem(1, "id_sog_com", 2110) //RBGOLD
	cb_passa.text="A Laserare"
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	pb_spazzola.visible=true
	pb_buratto.visible=false
	dw_3.modify("DataWindow.Detail.color=8388352")  //verde
elseif ll_id_prof=203 or  ll_id_prof=228 then //spazzolare
	title=upper("Invio Merce al reparto Spazzolatura")
	if  ll_id_prof=203 then
		dw_3.setitem(1, "id_sog_com", 2146)  //reparto spazzolatura
	else
		dw_3.setitem(1, "id_sog_com", 2148)  // itre fratelli
	end if
	cb_passa.text="A Spazzolare"
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	pb_spazzola.visible=true
	pb_buratto.visible=false
	dw_3.modify("DataWindow.Detail.color=65535") //gialla
elseif ll_id_prof=204 then //ripara
	dw_3.setitem(1, "id_sog_com", 2044)  //reparto riparazione 
	title=upper("Invio Merce al reparto Riparazione")
	cb_passa.text="A Riparare"
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")   //dw colore grigio
	pb_buratto.visible=false
elseif ll_id_prof=224 then  //ceramico
	title=upper("Invio Merce al reparto Ceramico")
		dw_3.setitem(1, "id_sog_com", 2145) //reparto ceramico
	cb_passa.text="Al Ceramico"
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("DataWindow.Detail.color="+string(rgb(176,224,230))) //celeste
elseif ll_id_prof=226 then  //mERCE IN ATTESA
	title=upper("Invio Merce al reparto Attesa")
//	pb_buratto.visible=true  //20230828 stampa che mostra anche attesa secondo il paramentro passato
	cb_passa.text="Manda In Attesa"
	dw_3.setitem(1, "id_sog_com", 2142) //reparto attesa
	dw_3.modify("N_lacci.visible=1")
	dw_3.modify("N_fili.visible=1")
	dw_3.modify("t_lacci.visible=1")
	dw_3.modify("t_fili.visible=1")
	dw_3.modify("DataWindow.Detail.color='#FF7F50'") //ross0
end if


end event

event ue_postopen;call super::ue_postopen;dw_3.post setfocus()
dw_3.post setcolumn("cod_barre")
end event

type st_1 from w_001`st_1 within w_controllo_qualita
end type

type dw_1 from udw_base within w_controllo_qualita
integer x = 73
integer y = 1772
integer width = 3840
boolean bringtotop = true
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row<=0  then return
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=getitemnumber(row, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type dw_3 from udw_base within w_controllo_qualita
integer x = 55
integer y = 28
integer width = 3849
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_rientro_galvanica"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;
string ls_num_doc, ls_num_bollettina, ls_test,ls_galv,ls_lav, ls_tipo, ls_ret, ls_bol_corretta, ls_g_settimana
long ll_num_prog, ll_id_bollettina, ll_id_test, ll_righe, ll_id_doc,ll_riga,ll_id_galv, ll_null, ll_id_prof, ll_id_riga_bol, ll_id_intestatario, ll_id_art
decimal ldc_prezzo, ldc_prezzo_da_Data1
date ldt_data, ldt_g_settimana
string ls_cliente


setnull(ll_null)
if dwo.name="cod_barre"  then
	if len(data)=7   then
		 //20230920 prima di tutto vediamo se è già presente nella lista attuale (dw_8)
		ll_id_test=dw_8.find("c_solo_bol ='"+data+"'", 1, 1000000)
		if ll_id_test>0 then 
			messagebox("Attenzione!", "Bollettina n. "+data+" già INSERITA!!")
			return
		end if
		  //20230920 fine
		dw_3.setitem(1, "n_lacci", ll_null)
		dw_3.setitem(1, "n_fili", ll_null)
		dw_3.setitem(1, "legato", ll_null)
		//da cambiare subito!!!
		if rb_2021.checked then
			li_anno=2021
		elseif	rb_2022.checked then
			li_anno=2022
		elseif	rb_2020.checked then
			li_anno=2020
		elseif rb_2019.checked then
			li_anno=2019
		elseif rb_2018.checked then
			li_anno=2018
		end if
			
		if li_anno=2022 then
			ls_num_doc=data
			ll_num_prog=long(ls_num_doc)
			select id_documento, num_documento
			into :ll_id_bollettina, :ls_num_bollettina
			from dba.documento d, dba.prof_documento p
			where right(num_documento, 7)=:ls_num_doc
			and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL' or  p.codice='BOLCLIEN') 
			and d.id_prof_documento=p.id_prof_documento
			;
			SELECT first(ordinato_fo) into :ls_bol_corretta from dba.riga_documento where id_documento=:ll_id_bollettina;
			if ls_bol_corretta='S' then
				messagebox("Attenzione!", "Bollettina n. "+ls_num_bollettina+" già corretta: NON è più possibile inviarla ad alcuna lavorazione!!!!")
				return
			end if
			 //20230307 Samy: NON POSSONO più essere sparate due volte! Se è già stata sparata CON LO STESSO INTESTATARIO (è in un buratto) avverti e blocca
			
			 //20230113 agg samy per blollettine cllienti diversi
		else
			ls_num_doc=mid(data, 3, 5)
			ll_num_prog=long(ls_num_doc)
			select id_documento, num_documento
			into :ll_id_bollettina, :ls_num_bollettina
			from dba.documento d, dba.prof_documento p
			where right(num_documento, 5)=:ls_num_doc
			//where num_progressivo=:ll_num_prog
			//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
			and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
			and d.id_prof_documento=p.id_prof_documento
			and year(data_documento)=:li_anno
			;
		end if

		if ll_id_bollettina>0 then
			//20230628 controllo se l'articolo è bloccato se lo fosse mmi fermo qui
			select id_articolo into :ll_id_art from documento d , riga_documento r where r.id_documento=d.id_documento and d.num_documento= :ls_num_bollettina
			;
			if ll_id_prof=203 then ls_tipo="S"
			if ll_id_prof=196 then ls_tipo="L"
			ls_ret=wf_corretto_nonpiu_blocco(ll_id_art, ls_tipo, "B" )
			if ls_ret="S" then //è bloccato assolutamente mi fermo e NON lo inserisco
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" BLOCCATA!!!")
				dw_3.setitem(1, "cod_barre", "")
				return 0
			end if
			//20230628 controllo fine
			
			ls_test="id_documento="+string(ll_id_bollettina)
			ll_id_test=dw_8.find(ls_test, 1, dw_1.rowcount())
			if ll_id_test>0 then
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
			else
				dw_8.retrieve(ll_id_bollettina)
				ll_id_test=dw_8.find(ls_test, 1, dw_8.rowcount())
				dw_8.setitem(ll_id_test, "sog_commerciale_gen_codice", "")
				//20230920 inserisco per poter ordinare in modo da avere in cima sempre l'ultima insierita
				dw_8.setitem(ll_id_test, "c_num_riga", dw_8.rowcount())
				dw_8.sort()
				//20230920 fine
				dw_3.setitem(1, "cod_barre", "")
				dw_3.setfocus()
				dw_3.setcolumn("cod_barre")
				//20230912 Samy dice che ci vuole il giorno della settimana per gestire le spedizioni (a volte la spedizioine NON è precisa e slitta a secondo del giorno di consegna
				ls_g_settimana= f_cliente_giorno(ls_num_bollettina)
				//ls_g_settimana=f_g_settimana(ldt_g_settimana)
				if isnull(ls_g_settimana) or ls_g_settimana="" then ls_g_settimana="-"
				dw_8.setitem(ll_id_test, "des_contabile", ls_g_settimana)
				//20230912 fine
				ll_righe=dw_2.retrieve(ll_id_bollettina)
				//20220928 annullo anche fili, lacci e tara...
				dw_2.setitem(ll_righe, "provv_imp_carea_2", ll_null)
				dw_2.setitem(ll_righe, "provv_imp_agente_2", ll_null)
				dw_2.setitem(ll_righe, "peso_lordo", ll_null)
				//20220928 fine
				wf_bilancia(dw_2.rowcount(), ll_id_bollettina)  
				if cb_passa.text="Manda in Galv" then
					setcolumn("cod_barre_galvanica")
				else
					if getitemdecimal(row,"legato")> 0 then
						post setcolumn("n_lacci")
					else
						post setcolumn("cod_barre")
					end if
				end if
			end if
		else
			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
		end if
	end if
end if

if dwo.name="cod_barre_galvanica"  then
	if len(data)=13   then
		//ll_riga=dw_2.rowcount()
		ll_id_doc=dw_8.getitemnumber(1, "id_documento") //bisogna trovare di meglio ...
		ll_riga=dw_2.find("id_documento="+string(ll_id_doc), 1, 999999)
		//
		ls_galv=left(data, 12)
		ls_galv=right(ls_galv, 5)
		ll_id_galv=long(ls_galv)
		ldt_data=dw_3.getitemdate(1, "doc_data")
		ls_galv=""
		select lavorazione, descrizione
		into :ls_lav, :ls_galv
		from dba.galvanica
		where id_galvanica=:ll_id_galv
		;
		ldc_prezzo=f_rec_prezzo_galvanica(ldt_data, ll_id_galv)
//		ldt_data=dw_3.getitemdate(1, "doc_data")
//		if ldt_data> date("2000-01-01") then
//			if ldt_data>= date("2019-06-01") then
//				 ldc_prezzo=ldc_prezzo_da_Data1
//			end if
//		else
//			messagebox("Attenzione!", "Inserire Data Doc Destinazione!")
//		end if

		dw_2.setitem(ll_riga, "prezzo_metallo",ldc_prezzo)
		dw_2.setitem(ll_riga, "id_gruppo_agenti_2",ll_id_galv)
		ls_test=dw_2.getitemstring(ll_riga, "descrizione")
		if ls_test> " " then
			ls_galv=ls_test+"  __ "+ls_galv
		end if
		dw_2.setitem(ll_riga, "descrizione", ls_galv)
		dw_3.setitem(1, "cod_barre", "")
		dw_3.setitem(1, "cod_barre_galvanica", "")
		//prima c'erà 1 invece di rowcopuint
		dw_8.setitem(1, "sog_commerciale_gen_codice", ls_lav)  //speriamo vada bene 1 ....
		dw_3.setfocus()
		dw_3.setcolumn("cod_barre")
	end if
	
	
end if
end event

event itemchanged;call super::itemchanged;date ldt_data_doc
integer  li_num_lacci_fili
decimal ldc_peso_netto

choose case dwo.name
	case "n_lacci"
		li_num_lacci_fili= integer(data)
		if li_num_lacci_fili>0 then
			wf_ges_lacci_fili("L", li_num_lacci_fili)
		end if
		post setcolumn("n_fili")
	case "n_fili"
		li_num_lacci_fili= integer(data)
		if li_num_lacci_fili>0 then
			wf_ges_lacci_fili("F", li_num_lacci_fili)
		end if
		post setfocus()
		post setcolumn("cod_barre")
	case "legato"
		ldc_peso_netto=dec(data)
		if ldc_peso_netto> 0 then
			dw_3.setitem(1, "legato", ldc_peso_netto)
			dw_2.setitem( dw_2.rowcount(), "peso_netto", ldc_peso_netto)
			wf_agg_fino_calo(ldc_peso_netto, dw_2.rowcount())
			post setfocus()
			post setcolumn("n_lacci")
		end if
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;

if string(dwo.name)="ultima" then 
	setfocus()
	setcolumn("cod_barre")
end if
end event

type cb_passa from commandbutton within w_controllo_qualita
integer x = 3941
integer y = 240
integer width = 471
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Genera"
end type

event clicked;integer li_ret, i, li_righe
long     ll_null,ll_riga_doc, ll_id_doc, ll_id_galvanica,ll_id_doc_riga_da_cancellare, ll_riga_erase, ll_parametro[], ll_id_galv
string    ls_num_doc, ls_tipo_registro,ls_nota="", ls_num_bol, ls_des,ls_num_bollettina,ls_des2, ls_des_bollettina, ls_tipo
string ls_corretto, ls_non_segnare_piu, li_len, ls_ret, ls_galv,ls_um
date  ldt_data_doc, ldt_data_inserimento
long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_id_riga_provenienza,ll_riga_doc_inserito,ll_new_riga_doc,ll_id_art
long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre,ll_riga_trovata,ll_id_uc
setnull(ll_null)
decimal ldc_prezzo, ldc_legato, ldc_tot_riga
long ll_id_locazione, ll_id_magazzino,ll_id_causale, ll_id_titolo, ll_id_riga_bol ,ll_id_var, ll_id_listino
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog


	dw_8.accepttext()
IF DW_8.ROWCOUNT()>0 THEN
	//20230906 controllo che ogni riga abbia la galvanica, altrimenti lo segnalo e la faccio mettere
	ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
	if ll_id_prof=170 then
		for i= 1 to DW_8.ROWCOUNT()
			ls_galv=""
			ls_galv=dw_8.getitemstring(i, "sog_commerciale_gen_codice")
			if ls_galv> " " and len(ls_galv)<=3  then 
				continue  //rimane il codice clilente (cl010004 che è lungo per forza 8, mentre la galv è max 3)
			else
				messagebox("Attenzione!!", "La riga n. "+string(i)+" NON ha galvanica: puoi inserirla a mano, se vuoi.")
				setfocus(dw_8)
				dw_8.setitem(i, "sog_commerciale_gen_codice", "********")
				dw_8.scrolltorow(i)
				dw_8.setcolumn("sog_commerciale_gen_codice")
				return
			end if
		next
	end if
//20230906 fine
	ll_id_doc=dw_8.getitemnumber(1, "id_documento")
	ll_riga_doc=dw_1.retrieve(ll_id_doc)
	ldt_data_doc=dw_3.getitemdate(1, "doc_data")
	//ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")  //spostato sopra 20230906
	ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
	select id_locazione_1_prop, id_magazzino_1_prop, id_mod_registro_prop, id_caus_magazzino_prop
	into :ll_id_locazione, :ll_id_magazzino, :ll_id_mod_registro, :ll_id_causale
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof
	;
	dw_1.setitem(ll_riga_doc, "id_documento", ll_null)
	dw_1.setitem(ll_riga_doc, "data_documento", ldt_data_doc)
	dw_1.setitem(ll_riga_doc, "id_prof_documento", ll_id_prof)
	//20221027 aggiungo da wf_importa che avevo preparato ma non ho mai usato...
	dw_1.SetItem(1, "id_caus_magazzino", ll_id_causale)
	dw_1.SetItem(1, "id_magazzino", ll_id_magazzino)
	dw_1.SetItem(1, "id_locazione_1", ll_id_locazione)
	dw_1.SetItem(1, "id_registro", ll_id_registro)
	//20221027 fine
	dw_1.setitem(ll_riga_doc, "id_sog_commerciale", ll_id_sog)
	dw_1.setitem(ll_riga_doc, "id_sog_commerciale_fattura", ll_id_sog)
	dw_1.setitem(ll_riga_doc, "data_registrazione", ldt_data_doc)
	//20221014 il tio fattura è importante, se è diverso da 'N' mette il segno "-"
	dw_1.setitem(ll_riga_doc, "tipo_fattura", 'N')
	//trovo il numprog
	
	
	select id_esercizio
	into :ll_id_esercizio
	from dba.esercizio
	where data_inizio<=:ldt_data_doc
	and data_fine>=:ldt_data_doc
	;
	SELECT Max("registro"."id_registro")
		INTO :ll_id_registro  
		FROM "dba"."registro"  
		WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
			( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
			
	dw_1.setitem(ll_riga_doc, "id_registro", ll_id_registro)
	select tipo_registro
	into :ls_tipo_registro
	from dba.registro
	where id_registro=:ll_id_registro
	;
	
	IF  ll_id_registro > 0 THEN
		uo_proponi_num_progressivo=create u_setta_campi_documento
		ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_registro, 0, ls_tipo_registro)
		destroy uo_proponi_num_progressivo
		dw_1.SetItem(ll_riga_doc, "num_progressivo", ls_trova_prog.sl_num_progressivo)
		dw_1.SetItem(ll_riga_doc, "num_documento", string( ls_trova_prog.sl_num_progressivo))
	end if	
	//ls_num_doc="'"+dw_3.getitemstring(1, "num_documento")+"'"
	//select num_progressivo
	//into :ll_num_prog_test
	//from dba.documento
	//where id_registro=:ll_id_registro and num_documento=:ls_num_doc
	//;
	//if ll_num_prog_test>0 then
	//	messagebox("Attenzione!", "QUesto documento è già stato importato in Galvanica!")
	//	return
	//end if
	ls_nota="Bol. in questo doc: "
	select id_listino into :ll_id_listino from dba.sog_commerciale where id_sog_commerciale=:ll_id_sog;
	select id_variazione into :ll_id_var from dba.variazione  where id_listino=:ll_id_listino and data_inizio<= :ldt_data_doc and data_fine>=:ldt_data_doc ;
	
//	li_anno=integer 
	for i=1 to dw_8.rowcount()
		
//		ll_id_doc=dw_8.getitemnumber(i, "id_documento")
//		//select id_riga_documento into :ll_id_riga_bol from dba.riga_documento where id_documento=:ll_id_doc;
//		//update dba.riga_documento set descrizione=descrizione+ ' RSPA' where id_riga_documento=:ll_id_riga_bol;
//		update dba.riga_documento set descrizione=descrizione+ ' RSPA' where id_documento=:ll_id_doc;
//		if sqlca.sqlnrows>0 then
//			commit;
//		else
//			rollback;
//		messagebox("Attenzione!", "Descrizione in bollettina non aggiornata con RSPA!")
//	end if
		
		
		ls_num_bol=dw_8.getitemstring(i, "num_documento")
		select d.num_progressivo
		into :ll_num_prog_test
		from dba.documento d, dba.riga_documento r
		where r.id_documento=d.id_documento and id_prof_documento=:ll_id_prof
		and note_intestazione like ''%'+:ls_num_bol+'%''   //segno note inestazione
		and year(data_documento)=:li_anno
		;
		if ll_num_prog_test>0 then
			messagebox("Attenzione!", "La bollettina "+ls_num_bol+" è già stata importata in Galvanica! Num. Prog.:"+string(ll_num_prog_test))
			ll_id_doc_riga_da_cancellare=dw_8.getitemnumber(i, "id_documento")
			ll_riga_erase=dw_2.find("id_documento="+string(ll_id_doc_riga_da_cancellare), 1, dw_2.rowcount())
			if ll_riga_erase>0 then
				dw_2.RowsMove(ll_riga_erase, ll_riga_erase, Primary!,  dw_2, 1, filter!)
			else
				messagebox("Attenzione!", "Riga da cancellare NON trovata!")
			end if
			dw_8.deleterow(i)
			i --
			continue
	//		dw_8.reset()
	//		dw_1.reset()
	//		dw_2.reset()
	//		setfocus(dw_3)
	//		dw_3.setcolumn(1)
	//		return
		end if
		ls_nota+=ls_num_bol+";"
	next
	
	dw_1.setitem(ll_riga_doc, "note_intestazione", ls_nota)
	//20220322 agg. la dataora creazione aggiornata
	dw_1.setitem(ll_riga_doc, "data_ora_creazione", today())
	dw_1.setitemstatus(ll_riga_doc, 0, primary!, newmodified!)
	li_ret=dw_1.trigger event ue_update()  //salvo la testa
	ll_id_doc_inserito=dw_1.getitemnumber(ll_riga_doc, "id_documento")
	//completo e salvo le righe
	for i=1 to dw_2.rowcount()
		dw_2.setitem(i, "id_documento", ll_id_doc_inserito)
		dw_2.setitem(i, "num_riga", i)
		ll_riga_madre=dw_2.getitemnumber(i, "id_riga_documento")
		//20221018 inserisco per le stampe
		dw_2.setitem(i, "provv_imp_subage_2", ll_riga_madre)  //questo è il legame con la bollettina (non posso usare id_riga_doc_provenienza altrimenti lo segna evaso...)
		//fine
		//20221027 aggiungo da wf_importa
		dw_2.SetItem(i, "id_caus_magazzino", ll_id_causale)
		dw_2.SetItem(i, "id_locazione_1", ll_id_locazione)
		//20221027 fine
		dw_2.setitem(i, "id_riga_documento", ll_null)
		ll_id_galvanica=0
		ll_id_galvanica=dw_2.getitemnumber(i, "id_gruppo_agenti_2")
		
		//20221212 sAMY DIUCE CHE il titolo deve essere sempre = 925 se è argento e se il fornitore è ???? me li deve dare
		ll_id_art=dw_2.getitemnumber(i, "id_articolo")
		select id_titolo into :ll_id_titolo from dba.articolo where id_articolo=:ll_id_art;
		if ll_id_titolo=4 then
			
		end if
		//20221212 fine
		//20231031
		if ll_id_prof=228 then //è una spazzolatura esterni i prezzi degli articoli sono in pr_spazzolatura
			ll_id_uc=dw_2.getitemnumber(i, "id_unita_confezione")
		
			select pr_spazzolatura into :ldc_prezzo from dba.prezzo where id_unita_confezione=:ll_id_uc and id_variazione=:ll_id_var;
			if ldc_prezzo>0 then 
				dw_2.setitem(i, "prezzo", ldc_prezzo)
				dw_2.setitem(i, "id_listino", ll_id_var)
				select tipo into :ls_um from unita_misura um, unita_confezione uc where um.id_unita_misura=uc.id_unita_misura and id_unita_confezione=:ll_id_uc;
				if ls_um="P" then
					dw_2.setitem(i, "prezzo_manifattura", ldc_prezzo)
				else
					dw_2.setitem(i, "prezzo_complessivo", ldc_prezzo)
				end if
				dw_2.setitem(i, "prezzo_metallo", 0)
			end if
		else
		//20231031 fine
			ldc_prezzo=dw_2.getitemdecimal(i, "prezzo_metallo")
			//devo calcolare anche il totale riga ...
			ldc_tot_riga=dw_2.getitemdecimal(i, "tot_riga_val_az")
			ldc_legato=dw_2.getitemdecimal(i, "peso_netto")
			if isnull(ldc_legato) or ldc_legato<0 then ldc_legato=0  //controllo anche che il legato sia >=0 20220728
			ldc_tot_riga+=ldc_prezzo*ldc_legato
		end if
		
		if isnull(ldc_tot_riga) then ldc_tot_riga=0
		dw_2.setitem(i, "peso_netto", ldc_legato)
		dw_2.setitem(i, "tot_riga_val_az", ldc_tot_riga)  //la valuta è sempre euro
		dw_2.setitem(i, "tot_riga_val_doc", ldc_tot_riga)
		dw_2.setitem(i, "tot_riga_val_riga", ldc_tot_riga)
		//20220922 azzero eventuali derivazioni della bollettina
		dw_2.setitem(i, "peso_netto_evaso", 0)
		dw_2.setitem(i, "qta_evasa", 0)
		//20221107 aggiungo importante: evasa un base
		dw_2.setitem(i, "qta_evasa_un_base", 0)
		//20220922 fine
		//20220929 aggiusto i fattori di conversione altrimenti nulli
		dw_2.setitem(i, "fat_con_globale", 1)
		dw_2.setitem(i, "fat_con_unita_base", 1)
		
		select num_documento, d.id_documento into :ls_num_bollettina, :ll_id_doc from dba.documento d, dba.riga_documento r
		where d.id_documento=r.id_documento and id_riga_documento=:ll_riga_madre;
		//20220921 samy vuole che l'articolo delle riparazioini sia sempre ripgratis  //NOOOO Intendeva nella stampa del ddt... 20220926
//		if  ll_id_prof=204 then
//			ll_id_art=281
//			ll_id_uc=277
//		else
			ll_id_uc=dw_2.getitemnumber(i, "id_unita_confezione")
			
		//end if
		//20220921 fine
		//20230517
		//20230628 controllo corretto e non più
		if ll_id_prof=203 then ls_tipo="S"
		if ll_id_prof=196 then ls_tipo="L"
		ls_ret=wf_corretto_nonpiu_blocco(ll_id_art, ls_tipo, "Z" )
		if  pos(ls_ret, "S")>0 then
			
		else
			select des_2 into :ls_des2 from dba.prezzo where id_variazione=15 and id_unita_confezione=:ll_id_uc;
			ldt_data_inserimento=date(today())
			ls_tipo=''  //20230906 commento perché deve essere un errore o un incompletezza: se ="" NON fa mai l'insert
			if ll_id_prof=203 then  //spazzolatura
				if pos(ls_des2, "k56")<=0 and  pos(ls_des2, "k56a")<=0  and  pos(ls_des2, "k57")<=0 and  pos(ls_des2, "k58")<=0 and  pos(ls_des2, "k59")<=0 &
				and  pos(ls_des2, "k60")<=0 and  pos(ls_des2, "k60a")<=0  and  pos(ls_des2, "k61")<=0 and pos(ls_des2, "K61a")<=0   and pos(ls_des2, "K60")<=0 then 
					messagebox("Attenzione!", "L'articolo NON contiene il K spazzolatura!!")
					ls_tipo='S'
				end if
			elseif   ll_id_prof=196 then  //laseratura 20230517
				if pos(ls_des2, "k55")<=0 and pos(ls_des2, "k96")<=0 and pos(ls_des2, "k51l")<=0 then
					messagebox("Attenzione!", "L'articolo NON contiene il K laseratura!!")
					ls_tipo='L'
				end if
			end if
			if ls_tipo>'' then
				insert into dba.art_senza_spazzolatura (id_articolo,tipo,data_inserimento)    //20230517 aggiungo un campo per distinguere il tipo di lavorazione
				values(:ll_id_art,:ls_tipo,:ldt_data_inserimento);
				if sqlca.sqlNrows>0 then
					commit;
				else
					rollback;
				end if
			end if
		end if

// Kk56a, K57	K58 K59 K60 K60a K61
//		if //NON serve più???
//		dw_2.setitem(i, "prezzo_metallo", 0)  //20220830: ANNA chiede che la quotazione della galvanica NON venga riportata sul buratto
		ls_des=dw_2.getitemstring(i, "descrizione")
		ls_des_bollettina=ls_des
		if pos(ls_des, "BOL:")<=0 then ls_des+= " - BOL: "+ls_num_bollettina		
		dw_2.setitem(i, "descrizione", ls_des)
		dw_2.setitemstatus(i, 0, primary!, newmodified!)
		//salvo la riga
		li_ret=dw_2.trigger event ue_update()  //20220725
		//aggiungo legame con la produzionevorrei portare tutti i legami in questa tabella mi chiedo perché non l'ho fatto dall'inizio....)
		ll_new_riga_doc=dw_2.getitemnumber(i, "id_riga_documento")
		insert into dba.produzione_2011 (id_bollettina, id_doc_produzione)
		values(:ll_id_doc, :ll_new_riga_doc)
		;
		if sqlca.sqlNrows>0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Legame bollettina-riga_doc_produzione per bol: "+ls_num_bol+" NON è stato salvato!")
		end if
		// 20220907 fine
		if li_ret=1 then //funzione che vuole Samy: le righe passate correttamente spariscono quelle che rimangono NON sono state passate 20220728
			ll_riga_trovata=dw_8.find("num_documento='"+ ls_num_bollettina+"'", 1, 1000000)
			dw_8.deleterow(ll_riga_trovata)
		end if
	//inserisco il doc nella tabella dei doc passati per l'eventuale stampa a memoria
		ll_riga_doc_inserito=dw_9.insertrow(0)
//		dw_9.setitem(ll_riga_doc_inserito, "id_riga_bollettina",ll_riga_madre)
		dw_9.setitem(ll_riga_doc_inserito, "id_documento",ll_id_doc_inserito)
//		dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ls_trova_prog.sl_num_progressivo)
		dw_9.setitem(ll_riga_doc_inserito, "num_documento",	string(ls_trova_prog.sl_num_progressivo))
		dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_doc)
		dw_9.setitem(ll_riga_doc_inserito, "num_riga", i)	
		dw_9.setitem(ll_riga_doc_inserito, "num_bollettina",	ls_num_bollettina)
//		li_ret=dw_9.trigger event ue_update() 
//fine inserimento		
		
		//aggiorna LA BOLLETTINA CON LA GALVANICA E IL PREZZO GALVANICA NEL PREZZO METALLO
		//20220425 Sara dice che si blocca perché manca galvanica....
		
		//20220822 e se per non saper leggere né scrivere io azzerassi tutto comunque 20220822??????
		//if ll_id_galvanica>0 and ldc_prezzo>0  then
//			update dba.riga_documento
//			set id_gruppo_agenti_2=:ll_id_galvanica, prezzo_metallo=:ldc_prezzo, tot_riga_val_riga=:ldc_tot_riga, 
//			tot_riga_val_az=:ldc_tot_riga,  tot_riga_val_doc=:ldc_tot_riga,  descrizione=:ls_des  
//			where id_riga_documento=:ll_riga_madre
//			;
			//20220822 Samy dice che si ritrova delle bollettine con numero lacci quando fa rbol (spedizione)
			//non capisco come sia possibile, ma mi adeguo....
			//202305417 se è spaz o laser aggiungere in descrizione riga
			if ll_id_prof=203 then ls_des_bollettina+= " R_SPAZ"  //spazzolatura
			if ll_id_prof=196 then ls_des_bollettina+= " LASER"  //laseratura
			if ll_id_prof=224 then ls_des_bollettina+= " CERAMICA" //ceramica
			//20230906 se è galvanica e non c'è galvanica (non l'hanno battuta o per qualsiasi altro motivo) devo mettere "G"
			if ll_id_prof=170 and (isnull(ll_id_galvanica) or ll_id_galvanica<=0) then ll_id_galvanica= 3
			
			update dba.riga_documento
			set id_gruppo_agenti_2=:ll_id_galvanica, prezzo_metallo=:ldc_prezzo, 
			provv_imp_carea_2=0, provv_imp_agente_2=0,  peso_netto=0, descrizione=:ls_des_bollettina
			where id_riga_documento=:ll_riga_madre
			;
			//tot_riga_val_riga=:ldc_tot_riga, 
			//tot_riga_val_az=:ldc_tot_riga,  tot_riga_val_doc=:ldc_tot_riga,  
			//descrizione=:ls_des 
			 //peso_netto=:ldc_legato 20220426 Samy non vuole che il peso della bollettina sia cambiato!!!
			 
			if sqlca.sqlNrows>0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "La bollettina "+ls_num_bol+" NON è stata aggiornata con il valore galvanica!")
			end if  
				//inserisco il doc nella tabella dei doc passati per l'eventuale stampa a memoria
//				ll_riga_doc_inserito=dw_9.insertrow(0)
//				dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ls_trova_prog.sl_num_progressivo)
//				dw_9.setitem(ll_riga_doc_inserito, "num_documento",	string(ls_trova_prog.sl_num_progressivo))
//				dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_doc)
//				dw_9.setitem(ll_riga_doc_inserito, "num_riga", i)	
//				dw_9.setitem(ll_riga_doc_inserito, "num_bollettina",	ls_num_bollettina)
			
			//20220822 e se per non saper leggere né scrivere io azzerassi tutto comunque 20220822??????
//		elseif ldc_legato>0 then
//			update dba.riga_documento set peso_netto=0 	where id_riga_documento=:ll_riga_madre;
//			if sqlca.sqlNrows>0 then
//				commit;
//			else
//				rollback;
//				messagebox("Attenzione!", "NON azzerato peso netto in bollettina "+ls_num_bol+"!")
//			end if
		//end if  //20220425 Sara dice che si blocca perché manca galvanica... //20220822 e se per non saper leggere né scrivere io azzerassi tutto comunque 20220822??????
	next
	dw_9.sort()
	dw_9.groupcalc()
	//li_ret=dw_2.trigger event ue_update()   //spostato sopra per vedere se funziona meglio salvando una riga alla volta... 20220725
	f_pdf_doc_fo(ll_id_doc_inserito, "d_pdf_doc_fo_doc", "")
	f_pdf_doc_fo(ll_id_doc_inserito, "d_pdf_doc_fo_doc", "articolo_id_articolo")
	if dw_8.rowcount()<=0 then dw_8.reset()  //resetto solo se NON ci sono righe non passate 20220728
	
	dw_1.reset()
	dw_2.reset()
	dw_3.setitem(1, "n_lacci", ll_null)
	dw_3.setitem(1, "n_fili", ll_null)
	setfocus(dw_3)
	dw_3.setcolumn(1)
END IF

end event

type cb_1 from commandbutton within w_controllo_qualita
integer x = 3941
integer y = 404
integer width = 471
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;
dw_9.print(true, true)
end event

type dw_9 from udw_base within w_controllo_qualita
integer x = 2610
integer y = 240
integer width = 1298
integer height = 1512
integer taborder = 20
string dataobject = "d_bol_galv_buratto2"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if dwo.name="num_riga" then
	if row<=0  then return
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	ll_id_doc=getitemnumber(row, "id_documento")
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
end if
end event

type dw_2 from udw_figlia within w_controllo_qualita
integer x = 73
integer y = 2172
integer width = 3840
integer height = 404
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
boolean livescroll = false
end type

event retrievestart;call super::retrievestart;return 2
end event

type dw_8 from udw_base within w_controllo_qualita
integer x = 55
integer y = 240
integer width = 2523
integer height = 1512
string dataobject = "d_ra_doc_rientro_fo"
boolean hscrollbar = true
end type

event sqlpreview;call super::sqlpreview;string ls_sql
integer i

ls_sql=sqlsyntax

if il_id_prof_doc>0 then
		ls_sql+= " and documento.id_prof_documento= "+string(il_id_prof_doc)+" "
end if
	
if il_id_sog>0 then
		ls_sql+= " and documento.id_sog_commerciale= "+string(il_id_sog)+" "
end if	

if idt_da_data> date('2010-01-01') then
	ls_sql+= " and documento.data_documento>= '"+string(idt_da_data, "yyyy-mm-dd")+"' "
end if
if ls_sql>sqlsyntax then
	i=SetSQLPreview(ls_sql)
end if
	
end event

event retrievestart;call super::retrievestart;return 2
end event

event itemchanged;call super::itemchanged;long ll_id_galv, ll_riga, ll_id_doc
date ldt_data
string ls_test, ls_galv
decimal ldc_prezzo

if dwo.name="sog_commerciale_gen_codice" then
select id_galvanica
	into :ll_id_galv
	from dba.galvanica
	where lavorazione=:data
	;
	if ll_id_galv>0 then
		ll_id_doc=getitemnumber(row, "id_documento")
		ll_riga=dw_2.find("id_documento="+string(ll_id_doc), 1, 999999)
		ldc_prezzo=f_rec_prezzo_galvanica(ldt_data, ll_id_galv)
		dw_2.setitem(ll_riga, "prezzo_metallo",ldc_prezzo)
		dw_2.setitem(ll_riga, "id_gruppo_agenti_2",ll_id_galv)
		ls_test=dw_2.getitemstring(ll_riga, "descrizione")
		if ls_test> " " then
			ls_galv=ls_test+"  __ "+data
		end if
		dw_2.setitem(ll_riga, "descrizione", ls_galv)
	else
		messagebox("Attenzione!", "Galvanica NON riconosciuta!!")
	end if
end if
end event

type rb_2018 from radiobutton within w_controllo_qualita
integer x = 4064
integer y = 696
integer width = 251
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
string text = "2018"
end type

type rb_2019 from radiobutton within w_controllo_qualita
integer x = 4064
integer y = 792
integer width = 251
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
string text = "2019"
end type

type rb_2020 from radiobutton within w_controllo_qualita
integer x = 4064
integer y = 880
integer width = 251
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
string text = "2020"
end type

type rb_2021 from radiobutton within w_controllo_qualita
integer x = 4064
integer y = 964
integer width = 251
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
string text = "2021"
end type

type rb_2022 from radiobutton within w_controllo_qualita
integer x = 4064
integer y = 1052
integer width = 251
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
string text = "2022"
boolean checked = true
end type

type cb_2 from commandbutton within w_controllo_qualita
integer x = 3941
integer y = 544
integer width = 471
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rivedi "
end type

event clicked;date ldt_data
long ll_id_prof

ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
ldt_data=dw_3.getitemdate(1, "doc_data")

dw_9.retrieve(ll_id_prof, ldt_data)
end event

type cb_st_doc from commandbutton within w_controllo_qualita
integer x = 3941
integer y = 1276
integer width = 471
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "St. DDT"
end type

event clicked;//stampo il DDT creato (per ora impongo si crei un DDT alla volta, quindi quando stampo ce n'è soltanto uno) 20220901
long ll_id_prof_doc, ll_id_conf_oggetti, ll_job, ll_id_sog, ll_id_reg, ll_id_prof, ll_id_doc
string ls_nome_report,ls_cod_profilo, ls_path_libreria, dwsyntax, ls_ret, ls_printer, ls_ret2, ls_invia, ls_cod_azienda,ls_tipo_reg
integer li_retvalue, li_ret
uo_mail u_mail

ll_id_doc=dw_9.getitemnumber(1, "id_documento")

datastore ds_stampa

select codice into :ls_cod_azienda from azienda;

ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
ll_id_prof_doc=dw_3.getitemnumber(1, "id_prof_destinazione")

//spostato qui perchè Samy dal 20110920 vuole inviare anche prezzi per sald
select invia_mail_e_dati, mostra_prezzi
into :ls_invia, :ls_ret
from dba.sog_profilo_personalizza
where id_sog_commerciale=:ll_id_sog
and id_prof_documento=:ll_id_prof_doc
;
if  pos(upper(ls_cod_azienda), "SILVERDR")>0 then
	ds_stampa=create datastore
	if isnull(ll_id_prof_doc) then return
//	ib_askforsave=false
	//parent.TriggerEvent("ue_update")
	
	select nome_report
	into :ls_nome_report
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof_doc
	;
	
	select id_conf_oggetti, libreria
	into :ll_id_conf_oggetti, :ls_path_libreria
	from conf_oggetti
	where codice=:ls_nome_report;
	
//	ll_id_prof=idw_gen.getitemnumber(1, "id_prof_documento")
//	wf_rec_prezzi_silver(ll_id_prof, ls_cod_azienda, ls_tipo_reg, ll_id_sog)
//	if pos(ls_cod_azienda,"SILVERDR")>0  and ls_tipo_reg="DV" and  (ll_id_sog=43 or ll_id_sog=1862 )  then //deve partire il recupera prezzi per karizia ma anche per panna
//		tab_1.tabpage_2.cb_rec_prezzi.trigger event clicked()
//		idw_riga.Event ue_update(0,0)
//	end if

	
	if ll_id_conf_oggetti>0 then
		ll_job=printopen()
		dwsyntax = LibraryExport(ls_path_libreria, ls_nome_report, ExportDataWindow!)
		IF dwsyntax>"" THEN
			ds_stampa.create(dwsyntax)
			ds_stampa.settransobject(sqlca)
		else
			messagebox("Errore!", "Libreria o report non trovati: "+ls_path_libreria +"-"+ls_nome_report)
			printclose(ll_job)
			return
		end if
	end if
	li_ret=ds_stampa.retrieve(ll_id_doc)
	//non si vuole il prezzo! Samy 04-10-2017 da oggi 20210920 no, si guarda la tabella (vedi sopra all'inizio
	if ls_ret='S' then
		ls_ret2=ds_stampa.Modify("c_prezzo.visible=1")
		ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=1")
	else
		ls_ret2=ds_stampa.Modify("c_prezzo.visible=0")
		ds_stampa.modify("riga_documento_tot_riga_val_doc.visible=0")
	end if
	//ls_ret2=ds_stampa.Modify("riga_documento_tot_riga_val_doc.visible=0")
	
	
	//fine prezzo
	
	ds_stampa.Modify("DataWindow.Print.copies = 2")
	
	
	//ls_cod_profilo=idw_gen.getitemstring(ll_row,"prof_documento_codice")
	//ls_num_doc=ds_documenti.getitemstring(ll_row,"documento_num_documento")
	//ldt_data_doc=ds_documenti.getitemdate(ll_row,"documento_data_documento")
	//ls_nome_file=ls_dir_export+ls_cod_profilo+ls_num_doc+".pdf"
					
	ls_ret2=ds_stampa.Modify("DataWindow.Print.documentName = 'RBOL'")
	
	ls_printer=ds_stampa.describe ('DataWindow.Printer')
		//ds_stampa.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
		
	
	if ls_ret2<>"" then 
		messagebox("Errore!", "Documento non stampato!")
	else
		printdatawindow(ll_job, ds_stampa)
	end if
	printclose(ll_job)				
end if
//questo lo fa anche per Panna... 09062020 spostato in cima 20110920

//select invia_mail_e_dati, mostra_prezzi
//into :ls_invia, :ls_ret
//from dba.sog_profilo_personalizza
//where id_sog_commerciale=:ll_id_sog
//and id_prof_documento=:ll_id_prof_doc
//;
if isnull(ls_ret) then ls_ret='N'
if ls_invia='S' then 
	u_mail.is_mail.s_testo="Inviata in automatico da Nita."
	u_mail.of_prepara_campi_mail(ll_id_doc)
	u_mail.of_allega_files(ll_id_doc, ls_ret )
	u_mail.of_crea_pdf(ll_id_doc, ls_ret, "N")
	u_mail.of_invia_mail("MAIL", ls_ret, true, true) //il primo è il codice della riga con i dati per inviare la mail, il secondo il "vedi prezzi", il terzo e il quarto per creare o no file di log e debug
end if








end event

type cb_reset from commandbutton within w_controllo_qualita
integer x = 3945
integer y = 1436
integer width = 471
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "RESET"
end type

event clicked;
if messagebox("Attenzione!", "Vuoi davvero pulire le finestre per fare un altro DDT?", stopsign!, yesno!)= 1 then
	dw_9.reset()
	dw_8.reset()
end if
end event

type pb_spazzola from picturebutton within w_controllo_qualita
boolean visible = false
integer x = 4178
integer y = 2268
integer width = 288
integer height = 256
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\spazzola.jpeg"
alignment htextalign = left!
end type

event clicked;//long ll_id_profilo
//string ls_tipo
//
//ll_id_profilo =dw_3.getitemnumber(1,  "id_prof_destinazione")
//if ll_id_profilo =203 then ls_tipo="S"  //20230517 spazzolatura
//if ll_id_profilo =196 then ls_tipo="L"  //20230517 laseratura
//openwithparm(w_art_senza_spazzolatura,ls_tipo)
//
end event

type cbx_controllo from checkbox within w_controllo_qualita
integer x = 3977
integer y = 76
integer width = 402
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
string text = "Controllo"
boolean checked = true
end type

type st_2 from statictext within w_controllo_qualita
integer x = 3963
integer y = 1568
integer width = 485
integer height = 424
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 65535
string text = "In questa finestra la dicitura RSPAZ e RLASER viene inserita solo se l~'articolo non la contiene"
boolean focusrectangle = false
end type

type pb_buratto from picturebutton within w_controllo_qualita
integer x = 4183
integer y = 2004
integer width = 288
integer height = 256
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "C:\nita\icone\about.png"
alignment htextalign = left!
end type

event clicked;long ll_id_prof
ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")


openwithparm(w_scad_buratto_rpt, ll_id_prof)

end event

type rr_1 from roundrectangle within w_controllo_qualita
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 4046
integer y = 688
integer width = 279
integer height = 452
integer cornerheight = 40
integer cornerwidth = 46
end type

