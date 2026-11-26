forward
global type w_r_galvanica from w_001
end type
type dw_1 from udw_base within w_r_galvanica
end type
type dw_3 from udw_base within w_r_galvanica
end type
type cb_passa from commandbutton within w_r_galvanica
end type
type cb_stampa from commandbutton within w_r_galvanica
end type
type dw_9 from udw_base within w_r_galvanica
end type
type dw_2 from udw_figlia within w_r_galvanica
end type
type dw_8 from udw_base within w_r_galvanica
end type
type rb_2018 from radiobutton within w_r_galvanica
end type
type rb_2019 from radiobutton within w_r_galvanica
end type
type rb_2020 from radiobutton within w_r_galvanica
end type
type rb_2021 from radiobutton within w_r_galvanica
end type
type rb_2022 from radiobutton within w_r_galvanica
end type
type cb_situazione from commandbutton within w_r_galvanica
end type
type rr_1 from roundrectangle within w_r_galvanica
end type
end forward

global type w_r_galvanica from w_001
boolean visible = false
integer x = 1057
integer y = 483
integer width = 5051
integer height = 2760
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_3 dw_3
cb_passa cb_passa
cb_stampa cb_stampa
dw_9 dw_9
dw_2 dw_2
dw_8 dw_8
rb_2018 rb_2018
rb_2019 rb_2019
rb_2020 rb_2020
rb_2021 rb_2021
rb_2022 rb_2022
cb_situazione cb_situazione
rr_1 rr_1
end type
global w_r_galvanica w_r_galvanica

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
integer li_anno
end variables

forward prototypes
public subroutine wf_articolo (long al_id_articolo, long al_riga_doc)
public function long wf_importa (integer ai_riga)
public function decimal wf_bilancia (long al_riga_inserita)
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

public function decimal wf_bilancia (long al_riga_inserita);DWObject my_dwo
decimal ld_peso_netto,ldc_coef_calo, ldc_titolo, ldc_calo, ldc_fino
long	ll_row, ll_id_articolo
string ls_metallo



w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()


dw_3.setitem(1, "legato", ld_peso_netto)
dw_2.setitem(al_riga_inserita, "peso_netto", ld_peso_netto)

ldc_coef_calo=dw_2.getitemdecimal(al_riga_inserita, "coef_calo")
ldc_calo=ld_peso_netto*ldc_coef_calo/1000
ll_id_articolo=dw_2.getitemnumber(al_riga_inserita, "id_articolo")
select titolo
into :ldc_titolo
from orafo_titolo t, articolo a
where a.id_titolo=t.id_titolo
and a.id_articolo=:ll_id_articolo
;

ldc_fino=round(ld_peso_netto*ldc_titolo/1000, 2)
ldc_calo=round(ld_peso_netto*ldc_coef_calo/1000,2) - ldc_fino
dw_2.setitem(al_riga_inserita, "fino", ldc_fino)
dw_2.setitem(al_riga_inserita, "calo", ldc_calo)
close(w_bil)
if isnull(ld_peso_netto) then ld_peso_netto=0
return ld_peso_netto
end function

on w_r_galvanica.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_passa=create cb_passa
this.cb_stampa=create cb_stampa
this.dw_9=create dw_9
this.dw_2=create dw_2
this.dw_8=create dw_8
this.rb_2018=create rb_2018
this.rb_2019=create rb_2019
this.rb_2020=create rb_2020
this.rb_2021=create rb_2021
this.rb_2022=create rb_2022
this.cb_situazione=create cb_situazione
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_passa
this.Control[iCurrent+4]=this.cb_stampa
this.Control[iCurrent+5]=this.dw_9
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_8
this.Control[iCurrent+8]=this.rb_2018
this.Control[iCurrent+9]=this.rb_2019
this.Control[iCurrent+10]=this.rb_2020
this.Control[iCurrent+11]=this.rb_2021
this.Control[iCurrent+12]=this.rb_2022
this.Control[iCurrent+13]=this.cb_situazione
this.Control[iCurrent+14]=this.rr_1
end on

on w_r_galvanica.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_passa)
destroy(this.cb_stampa)
destroy(this.dw_9)
destroy(this.dw_2)
destroy(this.dw_8)
destroy(this.rb_2018)
destroy(this.rb_2019)
destroy(this.rb_2020)
destroy(this.rb_2021)
destroy(this.rb_2022)
destroy(this.cb_situazione)
destroy(this.rr_1)
end on

event open;call super::open;s_list_main ls_list
long ll_id_prof

dw_8.settransobject(sqlca)
dw_9.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.insertrow(1)

//dw_3.setitem(1, "da_data", relativedate(today(), - 30))





string ls_prof_id


ls_list=message.powerobjectparm
//20230711 
ll_id_prof=long(ls_list.s_win_parametri)
dw_3.setitem(1, "id_prof_destinazione", ll_id_prof)

if ll_id_prof=189 then
	this.title="RIENTRO DA GALVANICA INTERNA"
elseif ll_id_prof=225 then
	this.title="RIENTRO DA CERAMICA INTERNA"
		cb_passa.text="Rientro da ceramica"
		cb_situazione.text="Situazione ceramica"

end if




end event

event ue_postopen;call super::ue_postopen;dw_3.post setfocus()
dw_3.post setcolumn("cod_barre")
end event

type st_1 from w_001`st_1 within w_r_galvanica
end type

type dw_1 from udw_base within w_r_galvanica
integer x = 55
integer y = 1772
integer width = 4251
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

type dw_3 from udw_base within w_r_galvanica
integer x = 55
integer y = 28
integer width = 3502
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_r_galvanica"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;
string ls_num_doc, ls_num_bollettina, ls_test,ls_galv,ls_lav, ls_bol_corretta
long ll_num_prog, ll_id_bollettina, ll_id_test, ll_righe, ll_id_doc,ll_riga,ll_id_galv, ll_test,ll_id_galvint,ll_id_riga_bol, ll_id_prof, ll_prog_sql
long ll_riga_inserita
decimal ldc_prezzo, ldc_prezzo_da_Data1, ldc_peso_netto,ldc_peso_originale
date ldt_data

if dwo.name="cod_barre"  then
	if len(data)=7   then
		ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
		reset()
		INSERTROW(1)
		dw_3.setitem(1, "id_prof_destinazione", ll_id_prof)
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
			and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL' or p.codice='GBOL')
			and d.id_prof_documento=p.id_prof_documento
			;
			//20250718 controllo che non sia già corretta!!!! è successo!
			SELECT first(ordinato_fo) into :ls_bol_corretta from dba.riga_documento where id_documento=:ll_id_bollettina;
			if ls_bol_corretta='S' then
				messagebox("Attenzione!", "Bollettina n. "+ls_num_bollettina+" già corretta: NON è più possibile inviarla ad alcuna lavorazione!!!!")
				return
			end if
			//20250718 fine
			ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
			if ll_id_prof=189 then ll_prog_sql=170
			if  ll_id_prof=225 then ll_prog_sql=224
			select r2.id_riga_documento into :ll_test  from riga_documento r, riga_documento r2, documento d2
			where r.id_documento = :ll_id_bollettina and d2.id_prof_documento=:ll_prog_sql and r.id_riga_documento=r2.provv_imp_subage_2
			and r2.id_documento=d2.id_documento    //aggiunto 20220308 deve prendere solo bollettine già andate in galvanica...
			;
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

		if ll_id_bollettina>0 and ll_test>0 then  //aggiunto 20220308 deve prendere solo bollettine già andate in galvanica...
			ls_test="id_documento="+string(ll_id_bollettina)
			ll_id_test=dw_8.find(ls_test, 1, dw_1.rowcount())
			if ll_id_test>0 then
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
			else
				dw_8.retrieve(ll_id_bollettina)
				select id_riga_documento into :ll_id_riga_bol from dba.riga_documento where id_documento=:ll_id_bollettina;
				select r.id_riga_documento into :ll_id_galvint from dba.riga_documento r, dba.documento d
				where d.id_documento=r.id_documento and provv_imp_subage_2=:ll_id_riga_bol and d.id_prof_documento=:ll_prog_sql
				;
	
				dw_3.setitem(1, "cod_barre", "")
				dw_3.setfocus()
				dw_3.setcolumn("cod_barre")
				
				ll_righe=dw_2.retrieve(ll_id_galvint) //(ll_id_bollettina)
				ll_riga_inserita=dw_2.find("id_riga_documento="+string(ll_id_galvint), 1, ll_righe)
				//20250224 per alessandro prendere vecchio peso e ripoortarlo in legato originale sulla riga dw_8
				ldc_peso_originale=dw_2.getitemdecimal(ll_riga_inserita, "peso_netto")
				ldc_peso_netto=wf_bilancia(dw_2.rowcount())
				ll_id_test=dw_8.find(ls_test, 1, dw_8.rowcount())
				dw_8.setitem(ll_id_test, "peso_netto", ldc_peso_netto)  //20250224 da fare per Alessandro e mettere anche campo nuovo con peso con il quale la bollettina è andata in galvanica oceramico
				dw_8.setitem(ll_id_test, "c_peso_originale", ldc_peso_originale) 
				//if cb_passa.text="Manda in Galv" then
					setcolumn("cod_barre_galvanica")
//				elseif cb_passa.text="Manda in Galv" then
//					setcolumn("fili")
//				end if
			end if
		else
			if ll_id_bollettina>0 then
				if ll_id_prof=189 then
					messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non è in Galvanica!")
				elseif ll_id_prof=225 then
					messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non è in CERAMICO!")
				end if
			else
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
			end if
		end if
	end if
end if

//if dwo.name="cod_barre_galvanica"  then
//	if len(data)=13   then
//		ll_riga=dw_2.rowcount()
//		ls_galv=left(data, 12)
//		ls_galv=right(ls_galv, 5)
//		ll_id_galv=long(ls_galv)
//		ldt_data=dw_3.getitemdate(1, "doc_data")
//		ls_galv=""
//		select lavorazione, descrizione
//		into :ls_lav, :ls_galv
//		from dba.galvanica
//		where id_galvanica=:ll_id_galv
//		;
//		ldc_prezzo=f_rec_prezzo_galvanica(ldt_data, ll_id_galv)
////		ldt_data=dw_3.getitemdate(1, "doc_data")
////		if ldt_data> date("2000-01-01") then
////			if ldt_data>= date("2019-06-01") then
////				 ldc_prezzo=ldc_prezzo_da_Data1
////			end if
////		else
////			messagebox("Attenzione!", "Inserire Data Doc Destinazione!")
////		end if
//
//		dw_2.setitem(ll_riga, "prezzo_metallo",ldc_prezzo)
//		dw_2.setitem(ll_riga, "id_gruppo_agenti_2",ll_id_galv)
//		ls_test=dw_2.getitemstring(ll_riga, "descrizione")
//		if ls_test> " " then
//			ls_galv=ls_test+"  __ "+ls_galv
//		end if
//		dw_2.setitem(ll_riga, "descrizione", ls_galv)
//		dw_3.setitem(1, "cod_barre", "")
//		dw_3.setitem(1, "cod_barre_galvanica", "")
//		dw_8.setitem(1, "sog_commerciale_gen_codice", ls_lav)  //speriamo vada bene 1 ....
//		dw_3.setfocus()
//		dw_3.setcolumn("cod_barre")
//	end if
//	
//	
//end if
end event

event itemchanged;call super::itemchanged;decimal ldc_peso, ldc_peso_laccio, ldc_coef_calo, ldc_calo, ldc_titolo, ldc_fino
date ldt_data
long ll_id_articolo, ll_riga, ll_null

setnull(ll_null)

if dwo.name='cod_barre_galvanica' then
	ldc_peso=getitemdecimal(1, "legato")
	if ldc_peso>0 then
		ldt_data=getitemdate(1, "doc_data")
		ldc_peso_laccio=f_rec_prezzo_laccio_filo_rame("L", ldt_data)
		ldc_peso_laccio*=integer(data)
		if ldc_peso_laccio>0 then
			ldc_peso -=ldc_peso_laccio
			setitem(1, "legato", ldc_peso)
			//questo deve essere messo in una funzione da richiamare da qui e wf_bilancia
			ll_riga=dw_2.rowcount() //20250903 spostato da più sotto per verificare che ci siano righe prima dei getitem
			if ll_riga> 0 then
				ldc_coef_calo=dw_2.getitemdecimal(ll_riga, "coef_calo") //prima invece di ll_riga c'era 1!!!! 20250903
				ldc_calo=ldc_peso*ldc_coef_calo/1000
				ll_id_articolo=dw_2.getitemnumber(ll_riga, "id_articolo")
				select titolo
				into :ldc_titolo
				from orafo_titolo t, articolo a
				where a.id_titolo=t.id_titolo
				and a.id_articolo=:ll_id_articolo
				;
				//deve mettere anche il numero dei lacci ... 20220313
				dw_2.setitem(ll_riga, "provv_imp_carea_2", integer(data))
				dw_2.setitem(ll_riga, "peso_netto", ldc_peso)
				ldc_fino=round(ldc_peso*ldc_titolo/1000, 2)
				ldc_calo=round(ldc_peso*ldc_coef_calo/1000,2) - ldc_fino
				dw_2.setitem(ll_riga, "fino", ldc_fino)
				dw_2.setitem(ll_riga, "calo", ldc_calo)
			else
				messagebox("Attenzione!", "Sembra che non vi siano righe nella finestra più in basso: è strano!!!! SEGNALARE A MARCO!")
			end if
			post setitem(row, "cod_barre_galvanica", "")
			setitem(row, "legato", 0)
			post setcolumn(1)
		else
			messagebox("Attenzione!", "Peso LACCI NON trovato!!!")
		end if
	else
		messagebox("Attenzione!", "Peso NON trovato!!!")
	end if
	
end if
end event

type cb_passa from commandbutton within w_r_galvanica
integer x = 3849
integer y = 536
integer width = 594
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "RIENTRO da Galv"
end type

event clicked;integer li_ret, i, li_righe
long     ll_null,ll_riga_doc, ll_id_doc, ll_id_galvanica,ll_id_doc_riga_da_cancellare, ll_riga_erase
string    ls_num_doc, ls_tipo_registro,ls_nota="", ls_num_bol, ls_des
date  ldt_data_doc
long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_id_riga_provenienza,ll_riga_doc_inserito
long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre
setnull(ll_null)
decimal ldc_prezzo, ldc_legato, ldc_tot_riga

IF DW_8.ROWCOUNT()>0 THEN

	ll_id_doc=dw_8.getitemnumber(1, "id_documento")
	ll_riga_doc=dw_1.retrieve(ll_id_doc)
	ldt_data_doc=dw_3.getitemdate(1, "doc_data")
	ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
	ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
	dw_1.setitem(ll_riga_doc, "id_documento", ll_null)
	dw_1.setitem(ll_riga_doc, "data_documento", ldt_data_doc)
	dw_1.setitem(ll_riga_doc, "id_prof_documento", ll_id_prof)
	dw_1.setitem(ll_riga_doc, "id_sog_commerciale", ll_id_sog)
	dw_1.setitem(ll_riga_doc, "id_sog_commerciale_fattura", ll_id_sog)
	dw_1.setitem(ll_riga_doc, "data_registrazione", ldt_data_doc)
	dw_1.setitem(ll_riga_doc, "data_ora_creazione", datetime(today(), now()))  //20240323 aggiorniamo la data ora creazione....
	//trovo il numprog
	u_setta_campi_documento uo_proponi_num_progressivo
	s_trova_progressivo ls_trova_prog
	select id_mod_registro_prop
	into :ll_id_mod_registro
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof
	;
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
//	li_anno=integer 
	for i=1 to dw_8.rowcount()
		
		ls_num_bol=dw_8.getitemstring(i, "num_documento")
		select d.num_progressivo
		into :ll_num_prog_test
		from dba.documento d, dba.riga_documento r
		where r.id_documento=d.id_documento and id_prof_documento=:ll_id_prof
		and note_intestazione like ''%'+:ls_num_bol+'%''
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
	
	dw_1.setitemstatus(ll_riga_doc, 0, primary!, newmodified!)
	li_ret=dw_1.trigger event ue_update()
	ll_id_doc_inserito=dw_1.getitemnumber(ll_riga_doc, "id_documento")
	for i=1 to dw_2.rowcount()
		dw_2.setitem(i, "id_documento", ll_id_doc_inserito)
		dw_2.setitem(i, "num_riga", i)
		//ll_riga_madre=dw_2.getitemnumber(i, "id_riga_documento") 
		
		//dw_2.setitem(i, "provv_imp_subage_2", ll_riga_madre) //20220312 ci rimane quello che c'è perché prendendo il galvint nella riga c'è già l'id_riga della bollettina...
		dw_2.setitem(i, "id_riga_documento", ll_null)
		ll_id_galvanica=dw_2.getitemnumber(i, "id_gruppo_agenti_2")
		ldc_prezzo=dw_2.getitemdecimal(i, "prezzo_metallo")
		//devo calcolare anche il totale riga ...
//		ldc_tot_riga=dw_2.getitemdecimal(i, "tot_riga_val_az")
//		ldc_legato=dw_2.getitemdecimal(i, "peso_netto")
//		if isnull(ldc_legato) then ldc_legato=0
//		if isnull(ldc_tot_riga) then ldc_tot_riga=0
//		ldc_tot_riga+=ldc_prezzo*ldc_legato
//		//dw_2.setitem(i, "peso_netto", ldc_legato)
//		dw_2.setitem(i, "tot_riga_val_az", ldc_tot_riga)
//		dw_2.setitem(i, "tot_riga_val_doc", ldc_tot_riga)
//		dw_2.setitem(i, "tot_riga_val_riga", ldc_tot_riga)
		ls_des=dw_2.getitemstring(i, "descrizione")
		dw_2.setitemstatus(i, 0, primary!, newmodified!)
		//aggiorna LA BOLLETTINA CON LA GALVANICA E IL PREZZO GALVANICA NEL PREZZO METALLO
//		update dba.riga_documento
//		set id_gruppo_agenti_2=:ll_id_galvanica, prezzo_metallo=:ldc_prezzo, tot_riga_val_riga=:ldc_tot_riga, 
//		tot_riga_val_az=:ldc_tot_riga,  tot_riga_val_doc=:ldc_tot_riga, peso_netto=:ldc_legato, descrizione=:ls_des
//		where id_riga_documento=:ll_riga_madre
//		;
//		if sqlca.sqlNrows>0 then
//			commit;
			//inserisco il doc nella tabella dei doc passati per l'eventuale stampa a memoria
//			ll_riga_doc_inserito=dw_9.insertrow(0)
//			dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ls_trova_prog.sl_num_progressivo)
//			dw_9.setitem(ll_riga_doc_inserito, "num_documento",	string(ls_trova_prog.sl_num_progressivo))
//			dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_doc)
//		else
//			rollback;
//			messagebox("Attenzione!", "La bollettina "+ls_num_bol+" NON è stata aggiornata con il valore galvanica!")
//		end if
	next
	ll_riga_doc_inserito=dw_9.insertrow(0)
	dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ls_trova_prog.sl_num_progressivo)
	dw_9.setitem(ll_riga_doc_inserito, "num_documento",	string(ls_trova_prog.sl_num_progressivo))
	dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data_doc)
	dw_9.setitem(ll_riga_doc_inserito, "id_doc", ll_id_doc_inserito)
	li_ret=dw_2.trigger event ue_update()
	f_pdf_doc_fo(ll_id_doc_inserito, "d_pdf_doc_fo", "")
	dw_8.reset()
	dw_1.reset()
	dw_2.reset()
	setfocus(dw_3)
	dw_3.setcolumn(1)
END IF

end event

type cb_stampa from commandbutton within w_r_galvanica
integer x = 3849
integer y = 708
integer width = 594
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

event clicked;dw_9.print(true, true)
end event

type dw_9 from udw_base within w_r_galvanica
integer x = 3813
integer y = 872
integer width = 1157
integer height = 876
integer taborder = 20
string dataobject = "d_passa_Doc_inseriti"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc, ll_row
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
ll_id_doc=getitemnumber(ll_row, "id_doc")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type dw_2 from udw_figlia within w_r_galvanica
integer x = 55
integer y = 2172
integer width = 4251
integer height = 404
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_r_riga_documento_2016"
boolean hscrollbar = true
boolean livescroll = false
end type

event retrievestart;call super::retrievestart;return 2
end event

type dw_8 from udw_base within w_r_galvanica
integer x = 55
integer y = 240
integer width = 3749
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

event itemchanged;call super::itemchanged;//decimal ldc_peso
//
//if dwo.name='peso_netto' then
//	ldc_peso=dec(data)
//	if ldc_peso>0 then
//		dw_2.setitem(al_riga_inserita, "peso_netto", ld_peso_netto)
//		ldc_coef_calo=dw_2.getitemdecimal(al_riga_inserita, "coef_calo")
//		ldc_calo=ld_peso_netto*ldc_coef_calo/1000
//		ll_id_articolo=dw_2.getitemnumber(al_riga_inserita, "id_articolo")
//		select titolo
//		into :ldc_titolo
//		from orafo_titolo t, articolo a
//		where a.id_titolo=t.id_titolo
//		and a.id_articolo=:ll_id_articolo
//		;
//		
//		ldc_fino=round(ld_peso_netto*ldc_titolo/1000, 2)
//		ldc_calo=round(ld_peso_netto*ldc_coef_calo/1000,2) - ldc_fino
//		dw_2.setitem(al_riga_inserita, "fino", ldc_fino)
//		dw_2.setitem(al_riga_inserita, "calo", ldc_calo)
//	end if
//end if
end event

type rb_2018 from radiobutton within w_r_galvanica
integer x = 4558
integer y = 348
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

type rb_2019 from radiobutton within w_r_galvanica
integer x = 4558
integer y = 444
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

type rb_2020 from radiobutton within w_r_galvanica
integer x = 4558
integer y = 532
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

type rb_2021 from radiobutton within w_r_galvanica
integer x = 4558
integer y = 616
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

type rb_2022 from radiobutton within w_r_galvanica
integer x = 4558
integer y = 704
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

type cb_situazione from commandbutton within w_r_galvanica
integer x = 3849
integer y = 312
integer width = 594
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Situazione Galvanica"
end type

event clicked;s_array s_prof
s_prof.ll_id_prof[1]=dw_3.getitemnumber(1,"id_prof_destinazione")
if s_prof.ll_id_prof[1]=189 then 
	s_prof.ll_id_prof[1]=170
	s_prof.ll_id_prof[2]=189
elseif  s_prof.ll_id_prof[1]=225 then
	s_prof.ll_id_prof[2]=225
	s_prof.ll_id_prof[1]=224
end if
openwithparm(w_st_sit_galvanica, s_prof)
end event

type rr_1 from roundrectangle within w_r_galvanica
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 4539
integer y = 340
integer width = 279
integer height = 452
integer cornerheight = 40
integer cornerwidth = 46
end type

