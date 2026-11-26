forward
global type w_trova_prezzi_articolo_in_riga_doc_rpt from window
end type
type cb_5 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cbx_3 from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type dw_5 from udw_001 within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_4 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cbx_2 from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_3 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_2 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type dw_3 from udw_001 within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type dw_2 from udw_001 within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_nc from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_nd from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cbx_1 from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cbx_solo_aperti from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cbx_vedi_doc from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cbx_vedi_totali from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cbx_vedi_righe from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type sle_pg from singlelineedit within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type st_1 from statictext within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type st_2 from statictext within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type sle_copie from singlelineedit within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type sle_zoom from singlelineedit within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_7 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_6 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_imp_st from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_stampa from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_preview from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_pg_dopo from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_pg_prima from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_1 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type dw_1 from datawindow within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type cb_salva_su_file from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
type dw_4 from udw_001 within w_trova_prezzi_articolo_in_riga_doc_rpt
end type
end forward

global type w_trova_prezzi_articolo_in_riga_doc_rpt from window
integer x = 23
integer y = 12
integer width = 4667
integer height = 2748
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 79741120
event ue_post_open ( )
cb_5 cb_5
cbx_3 cbx_3
dw_5 dw_5
cb_4 cb_4
cbx_2 cbx_2
cb_3 cb_3
cb_2 cb_2
dw_3 dw_3
dw_2 dw_2
cb_nc cb_nc
cb_nd cb_nd
cbx_1 cbx_1
cbx_solo_aperti cbx_solo_aperti
cbx_vedi_doc cbx_vedi_doc
cbx_vedi_totali cbx_vedi_totali
cbx_vedi_righe cbx_vedi_righe
sle_pg sle_pg
st_1 st_1
st_2 st_2
sle_copie sle_copie
sle_zoom sle_zoom
cb_7 cb_7
cb_6 cb_6
cb_imp_st cb_imp_st
cb_stampa cb_stampa
cb_preview cb_preview
cb_pg_dopo cb_pg_dopo
cb_pg_prima cb_pg_prima
cb_1 cb_1
dw_1 dw_1
cb_salva_su_file cb_salva_su_file
dw_4 dw_4
end type
global w_trova_prezzi_articolo_in_riga_doc_rpt w_trova_prezzi_articolo_in_riga_doc_rpt

type variables

integer ii_zoom=100
string is_da_art, is_ad_art, is_num_ordine, is_cod_cliente
long il_id_cat_codifica, il_id_ordine[], il_id_sog

s_array s_dati

end variables

forward prototypes
public subroutine wf_prepara_doc_righe (string as_tipo_nota)
public subroutine wf_crea_doc_e_righe (long al_id_sog, long al_id_prof)
public subroutine wf_oscura (string as_oscura, string as_colonna)
end prototypes

public subroutine wf_prepara_doc_righe (string as_tipo_nota);integer li_test, i,li_num_colli  //il campo num_colli lo uso per segnare la fatturache è diventata o NC (100) o ND (101)
long ll_id_doc, ll_riga, ll_id_riga_ddt, ll_id_riga_fat_collegata,ll_id_prof
decimal ldc_prezzo, ldc_qta
string   ls_num_ddt, ls_num_fat, ls_des
date ldt_data_ddt, ldt_data_fat

dw_2.reset()
dw_3.reset()

for i=1 to dw_1.rowcount()
	li_test=0
	li_test=dw_1.getitemnumber(i, as_tipo_nota)
	if as_tipo_nota="c_nc" then 
		li_num_colli=100 
		ls_des="Nota di credito "
		ll_id_prof=182
	else 
		li_num_colli=101
		ls_des="Nota di debito "
		ll_id_prof=183
	end if
	if li_test=1  then
		ll_id_riga_fat_collegata=dw_1.getitemnumber(i, "id_riga_documento")
		
		ll_id_doc=dw_1.getitemnumber(i, "documento_id_documento")
		ldc_prezzo=dw_1.getitemnumber(i, "prezzo") - dw_1.getitemnumber(i, "c_prezzo")
		ldc_prezzo=abs(ldc_prezzo)
		dw_3.retrieve(ll_id_riga_fat_collegata)
		ll_riga=dw_3.rowcount()
		dw_3.setitem(ll_riga, "prezzo_complessivo", ldc_prezzo)
		//dw_3.setitem(ll_riga, "id_listino", 15)
		ll_id_riga_ddt=dw_3.getitemnumber(ll_riga, "id_riga_Doc_provenienza")
		SELECT NUM_DOCUMENTO, DATA_DOCUMENTO into :ls_num_ddt, :ldt_data_ddt
		from dba.documento d, riga_documento r where d.id_documento = r.id_documento and id_riga_documento=:ll_id_riga_ddt;
		
		SELECT NUM_DOCUMENTO, DATA_DOCUMENTO into :ls_num_fat, :ldt_data_fat
		from dba.documento where id_documento = :ll_id_doc;
		
	//	ls_des+="rif. fat. n. "+ls_num_fat+" del "+string(ldt_data_fat, "dd/mm/yyyy") +" relativa al ddt. n. "+ls_num_ddt+" del "+string(ldt_data_ddt, "dd/mm/yyyy")  //20240311: Stringere un po'....
		ls_des+="rif. fat. n. "+ls_num_fat+" del "+string(ldt_data_fat, "dd/mm/yy") +" rif. ddt. n. "+ls_num_ddt+" del "+string(ldt_data_ddt, "dd/mm/yy")
		dw_3.setitem(ll_riga, "descrizione", ls_des)
		dw_3.setitem(ll_riga, "peso_netto", 0) //samy vuole così 23/04/2021
		ldc_qta=dw_3.getitemnumber(ll_riga, "quantita")
		dw_3.setitem(ll_riga, "tot_riga_val_riga", round(ldc_prezzo, 4)*ldc_qta)
		dw_3.setitem(ll_riga, "importo_manifattura", round(ldc_prezzo, 4)*ldc_qta)
		dw_3.setitem(ll_riga, "id_riga_doc_provenienza", ll_id_riga_fat_collegata )
		update dba.riga_documento set num_colli=:li_num_colli where id_riga_documento=:ll_id_riga_fat_collegata;
		if sqlca.sqlNrows>0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Riga "+string(i)+" NON segnata!")
		end if
	end if
next
wf_crea_doc_e_righe(43, ll_id_prof)
end subroutine

public subroutine wf_crea_doc_e_righe (long al_id_sog, long al_id_prof);long  ll_id_listino_associato, ll_id_variazione, ll_id_mag, ll_id_reg_mod, ll_id_locazione
long ll_id_reg, ll_id_causale, ll_id_esercizio, ll_num_prog_esistente, ll_id_doc_esistente, ll_null,ll_id_doc, ll_righe, ll_id_art
string ls_tipo, ls_tipo_listino,ls_tipo_registro, ls_numero, ls_azienda, ls_des
s_trova_progressivo ls_trova_prog

integer li_ret, i, li_pos
u_setta_campi_documento uo_proponi_num_progressivo
date ldt_data_doc
setnull(ll_null)
dw_4.accepttext()
ldt_data_doc=dw_4.getitemdate(1, "data_doc")
if isnull(ldt_data_doc) then ldt_data_doc=date(today())

if al_id_sog>0 then
	//adt_data_doc=dw_2.getitemdate(1, "data_documento")
	//controllo se ha un listino associato e lo riporto nel doc. che creo
	select id_listino, tipo
	into :ll_id_listino_associato, :ls_tipo
	from dba.sog_commerciale
	where id_sog_commerciale=:al_id_sog
	;
	if ll_id_listino_associato>0 then
		select id_variazione
		into :ll_id_variazione
		from dba.variazione
		where id_listino=:ll_id_listino_associato
		and data_inizio<= :ldt_data_doc and data_fine>=:ldt_data_doc
		;
	else
		if ls_tipo='F' then ls_tipo_listino='A' else ls_tipo_listino='V'
		select id_variazione, l.id_listino
		into :ll_id_variazione, :ll_id_listino_associato
		from dba.variazione v, dba.listino l
		where v.id_listino=l.id_listino
		and tipo=:ls_tipo_listino and lis_base='S'  
		and data_inizio<= :ldt_data_doc and data_fine>=:ldt_data_doc
		;
	end if
	
	if al_id_prof>0 then
	
		//con il profilo trovo magazzino, locazione, causale e registro (modello)
		select id_magazzino_1_prop, id_mod_registro_prop, id_locazione_1_prop, id_caus_magazzino_prop
		into :ll_id_mag, :ll_id_reg_mod, :ll_id_locazione, :ll_id_causale
		from dba.prof_documento
		where id_prof_documento=:al_id_prof
		;
		//ora trovo il registro attuale (modello registro riportato alla data odierna)
		//adt_data_doc=date(today())
		select id_esercizio
		into :ll_id_esercizio
		from dba.esercizio
		where data_inizio<= :ldt_data_doc  //adt_data_doc
		and data_fine>=:ldt_data_doc  //adt_data_doc
		;
		
		SELECT Max("registro"."id_registro")
		INTO :ll_id_reg  
		FROM "dba"."registro"  
		WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
				( "registro"."id_mod_registro" = :ll_id_reg_mod )   ;
		select tipo_registro
		into :ls_tipo_registro
		from dba.registro
		where id_registro=:ll_id_reg;
		//poi trovo num_progressivo e data registrazione (data odierna)
		uo_proponi_num_progressivo=create u_setta_campi_documento
		ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_reg, 0, ls_tipo_registro)
		destroy uo_proponi_num_progressivo
		
		//adt_data_doc=dw_2.getitemdate(1, "data_documento")
		ll_num_prog_esistente=0
		select num_progressivo, id_documento
		into :ll_num_prog_esistente, :ll_id_doc_esistente
		from dba.documento
		where id_registro=:ll_id_reg
		and num_documento=:ls_numero
		and data_documento=:ldt_data_doc and id_sog_commerciale=:al_id_sog
		;
		if ll_num_prog_esistente>0 then
			messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog_esistente)+"!", stopsign!, yesno!)
			return
//			if messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog_esistente)+"! Vuoi aprirlo?", stopsign!, yesno!)=1 then
//				s_list.s_identifica[1]="id_documento"
//				s_list.s_modo=modo_modifica
//				s_list.l_identifica[1]=ll_id_doc_esistente
//				openwithparm(w_orafo, s_list)
//			end if	
		else
			//controllo che il documento non esista già
			dw_2.reset()
			dw_2.insertrow(1)
			ls_numero=string(ls_trova_prog.sl_num_progressivo)    //dw_2.getitemstring(1, "num_documento")
			dw_2.SetItem(1, "id_sog_commerciale", al_id_sog)
			dw_2.SetItem(1, "id_sog_commerciale_fattura", al_id_sog)
			//agg. 27-05-2020
			dw_2.SetItem(1, "id_listino", ll_id_listino_associato)
			dw_2.SetItem(1, "id_variazione", ll_id_variazione)
			//fine2705
			dw_2.SetItem(1, "id_registro", ll_id_reg)
			dw_2.SetItem(1, "id_prof_documento", al_id_prof)
			dw_2.SetItem(1, "num_progressivo", ls_trova_prog.sl_num_progressivo)
			dw_2.SetItem(1, "data_registrazione", ldt_data_doc)
			dw_2.SetItem(1, "num_documento",ls_numero)
			dw_2.SetItem(1, "data_documento", ldt_data_doc)
			dw_2.SetItem(1, "id_caus_magazzino", ll_id_causale)
			dw_2.SetItem(1, "id_locazione_1", ll_id_locazione)
			dw_2.SetItem(1, "id_magazzino", ll_id_locazione)
			dw_2.SetItem(1, "origine", "PDA nota  il "+string(datetime(today(),now()) ,"dd/mm/yy hh:mm:ss"))
			dw_2.SetItem(1, "id_documento", ll_null)
			dw_2.SetItem(1, "id_destinazione", ll_null)
			dw_2.SetItem(1, "id_valuta", 3)
			//08/03/2021 aggiungo annullamento condizine pagamento
			dw_2.SetItem(1, "id_con_pagamento", ll_null)
			dw_2.setitemstatus(1, 0, Primary!, NewModified!)
			li_ret=dw_2.trigger event ue_update()
			ll_id_doc=dw_2.getitemnumber(1, "id_documento")
			if ll_id_doc>0 then
				ll_righe=dw_3.rowcount()
				for i= 1 to ll_righe
					if dw_3.getItemnumber(i, "id_riga_documento") > 0 then
						dw_3.SetItem(i, "id_documento", ll_id_doc)
						dw_3.SetItem(i, "id_riga_documento", ll_null)
						//quessto ora 20220115 lo commento perché ho già messo il valore della riga fattura nella funzione precedente
						//dw_3.SetItem(i, "id_riga_doc_provenienza", al_id_riga_fat_collegata)  //commento perché la uso 20210219 ???????? Non ricordo più cosa significhi 20220115
						dw_3.SetItem(i, "num_riga", i)
						dw_3.SetItem(i, "id_caus_magazzino", ll_id_causale)
						dw_3.SetItem(i, "id_locazione_1", ll_id_locazione)
						dw_3.SetItem(i, "id_locazione_2", ll_null)
						dw_3.SetItem(i, "id_des_articolo", ll_null)
						//27-05-2020 inserisco id_variaizone e azzero eventuali qta evase
						dw_3.SetItem(i, "id_listino", ll_id_variazione)
						dw_3.SetItem(i, "qta_evasa", 0)
						dw_3.SetItem(i, "peso_netto_evaso", 0)
						dw_3.SetItem(i, "qta_EVASA_UN_base", 0)
						dw_3.setitemstatus(i, 0, Primary!, NewModified!)
					else
						dw_3.deleterow(i)
						ll_righe --
						i --
					end if
					
				next
				li_ret=dw_3.trigger event ue_update()		
			else
				messagebox("Attenzione!", "Doc NON salvato!!")
			end if
		end if
	end if
end if
end subroutine

public subroutine wf_oscura (string as_oscura, string as_colonna);integer i, a,li_larghezza_colonna, li_new_posizione
string  ls_colonne[], ls_campo, ls_larghezza_colonna, ls_pos_attuale, ls_pos_attuale_campo
string ls_pos_attuale_etichetta, ls_test, ls_pos_attuale_oscura

ls_colonne[1]="t_documento_data_documento"
ls_colonne[2]="t_documento_num_progressivo"
ls_colonne[3]="t_prof_documento_codice"
ls_colonne[4]="t_documento_num_documento"
ls_colonne[5]="t_riga_documento_num_riga"
ls_colonne[6]="t_articolo_codice"
ls_colonne[7]="t_riga_documento_descrizione"
ls_colonne[8]="t_riga_documento_quantita_1"
ls_colonne[9]="t_c_prezzo"  
ls_colonne[10]= "t_sog_commerciale_tipo" //non ha etichetta
ls_colonne[11]="t_c_nc"
ls_colonne[12]="t_c_nd"
ls_colonne[13]="t_num_colli"  //non ha etichetta
ls_colonne[14]="t_prezzo"  //non ha etichetta

ls_campo=right(as_colonna, len(as_colonna) - 2)
if as_oscura="S" then
	dw_1.modify(as_colonna+".visible=0")//sparisce l'etichetta per oscurare
	dw_1.modify(ls_campo+"_t.visible=0")//sparisce l'etichetta
	dw_1.modify(ls_campo+".visible=0")  //invisibilizzo il campo: samy non vuole stamparlo
	for i=1 to upperbound(ls_colonne) //trovo la posizione nel vettore della colonna sparita
		if ls_colonne[i]=as_colonna then 
			a=i
			exit
		end if
	next
	ls_larghezza_colonna=dw_1.describe(as_colonna+".width")
	li_larghezza_colonna=integer(ls_larghezza_colonna)
	for i = a+1 to  upperbound(ls_colonne) //ora sposto le colonne a dx per coprire lo spazio rimasto vuoto
		ls_test=dw_1.describe(ls_colonne[i]+".text")
		if ls_test="-" then continue
		ls_campo=right(ls_colonne[i], len(ls_colonne[i]) - 2)
		ls_pos_attuale=dw_1.describe(ls_campo+".x")
		li_new_posizione=integer(ls_pos_attuale) - li_larghezza_colonna
		
		ls_pos_attuale_campo=ls_colonne[i]+".x="+string(li_new_posizione)
		dw_1.modify(ls_pos_attuale_campo) //sposto l'etichetta per oscurare
		dw_1.modify(right(ls_pos_attuale_campo, len(ls_pos_attuale_campo) - 2)) //sposto il campo
		if i=10 or i=13 or i=14 then continue
		ls_pos_attuale_etichetta=ls_campo+"_t.x="+string(li_new_posizione)
		dw_1.modify(ls_pos_attuale_etichetta)
		
	next
else
	dw_1.modify(ls_campo+".visible=1")  //torna visibile samy  vuole stamparlo	
end if
//		ls_test=dw_1.describe(ls_colonne[i]+".text")
//		if ls_test='-' then
//			ls_campo=right(ls_colonne[i], len(ls_colonne[i]) - 2)
//			dw_1.modify(ls_campo+".visible=0")  //invisibilizzo samy non vuole stamparlo
//			for a = i+1 to upperbound(ls_colonne) //sposto i campi a destra verso sx per la larghezza del campo oscurato
//				
//			next
//		end if
//	next
end subroutine

on w_trova_prezzi_articolo_in_riga_doc_rpt.create
this.cb_5=create cb_5
this.cbx_3=create cbx_3
this.dw_5=create dw_5
this.cb_4=create cb_4
this.cbx_2=create cbx_2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_3=create dw_3
this.dw_2=create dw_2
this.cb_nc=create cb_nc
this.cb_nd=create cb_nd
this.cbx_1=create cbx_1
this.cbx_solo_aperti=create cbx_solo_aperti
this.cbx_vedi_doc=create cbx_vedi_doc
this.cbx_vedi_totali=create cbx_vedi_totali
this.cbx_vedi_righe=create cbx_vedi_righe
this.sle_pg=create sle_pg
this.st_1=create st_1
this.st_2=create st_2
this.sle_copie=create sle_copie
this.sle_zoom=create sle_zoom
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_imp_st=create cb_imp_st
this.cb_stampa=create cb_stampa
this.cb_preview=create cb_preview
this.cb_pg_dopo=create cb_pg_dopo
this.cb_pg_prima=create cb_pg_prima
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_salva_su_file=create cb_salva_su_file
this.dw_4=create dw_4
this.Control[]={this.cb_5,&
this.cbx_3,&
this.dw_5,&
this.cb_4,&
this.cbx_2,&
this.cb_3,&
this.cb_2,&
this.dw_3,&
this.dw_2,&
this.cb_nc,&
this.cb_nd,&
this.cbx_1,&
this.cbx_solo_aperti,&
this.cbx_vedi_doc,&
this.cbx_vedi_totali,&
this.cbx_vedi_righe,&
this.sle_pg,&
this.st_1,&
this.st_2,&
this.sle_copie,&
this.sle_zoom,&
this.cb_7,&
this.cb_6,&
this.cb_imp_st,&
this.cb_stampa,&
this.cb_preview,&
this.cb_pg_dopo,&
this.cb_pg_prima,&
this.cb_1,&
this.dw_1,&
this.cb_salva_su_file,&
this.dw_4}
end on

on w_trova_prezzi_articolo_in_riga_doc_rpt.destroy
destroy(this.cb_5)
destroy(this.cbx_3)
destroy(this.dw_5)
destroy(this.cb_4)
destroy(this.cbx_2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.cb_nc)
destroy(this.cb_nd)
destroy(this.cbx_1)
destroy(this.cbx_solo_aperti)
destroy(this.cbx_vedi_doc)
destroy(this.cbx_vedi_totali)
destroy(this.cbx_vedi_righe)
destroy(this.sle_pg)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_copie)
destroy(this.sle_zoom)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_imp_st)
destroy(this.cb_stampa)
destroy(this.cb_preview)
destroy(this.cb_pg_dopo)
destroy(this.cb_pg_prima)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_salva_su_file)
destroy(this.dw_4)
end on

event open;long ll_id_art


s_dati=message.powerobjectparm

ll_id_art=long(s_dati.as_string[1])
if isnull(ll_id_art) or ll_id_art=0  then ll_id_art=long(s_dati.as_string[2])

if upperbound(s_dati.as_string)>=5 then
	dw_1.dataobject=s_dati.as_string[5]
end if
dw_1.settransobject(sqlca)
if s_dati.as_string[5]="d_trova_prezzi_cliente_in_riga_rpt" then
	
	dw_1.retrieve()
elseif s_dati.as_string[5]="d_trova_prezzi_articolo_in_riga_tutti_rpt"  then     // "d_trova_prezzi_articolo_in_riga_tutti_rpt"   ///// e d_trova_prezzi_articolo_in_riga_tutti_ndnc_rpt
	
	dw_1.retrieve(date(s_dati.as_string[10]), date(s_dati.as_string[11]))
elseif s_dati.as_string[5]="d_trova_prezzi_in_riga_tutti_ndnc_rpt"  then
	dw_1.retrieve()
else
//20230428 proviamo così che sennò non funge
 	if upperbound(s_dati.as_string)>=7 then il_id_sog=long(s_dati.as_string[7])
	
	dw_1.retrieve(ll_id_art)
end if
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_4.insertrow(1)
dw_4.setitem(1, "data_doc", date(today()))


//	
end event

event resize;dw_1.height=newheight - 225  - 800  //20230508
dw_1.width=newwidth - 75
dw_4.x=dw_1.x+dw_1.width - dw_4.width
dw_4.y=dw_1.y+dw_1.height+10
dw_2.x=dw_1.x
dw_3.x=dw_1.x
dw_2.y=dw_1.y+dw_1.height
dw_3.y=dw_1.y+dw_1.height + 200
end event

event rbuttondown;messagebox("Informazioni!", ClassName())
end event

type cb_5 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 4128
integer y = 12
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

type cbx_3 from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 2171
integer y = 32
integer width = 357
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Qta editabile"
end type

event clicked;string ls_ret
if checked then
	ls_ret=dw_1.modify("riga_documento_quantita_1.protect=0")
	ls_ret=dw_1.modify("documento_data_documento.protect=0")
	ls_ret=dw_1.modify("documento_num_progressivo.protect=0")
	ls_ret=dw_1.modify("documento_num_documento.protect=0")
else
	ls_ret=dw_1.modify("riga_documento_quantita_1.protect=1")
	ls_ret=dw_1.modify("documento_data_documento.protect=1")
	ls_ret=dw_1.modify("documento_num_progressivo.protect=1")
	ls_ret=dw_1.modify("documento_num_documento.protect=1")
end if
end event

type dw_5 from udw_001 within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 4242
integer y = 332
integer width = 1783
integer height = 732
integer taborder = 60
string dataobject = "d_nd_nc_per_xls"
boolean vscrollbar = true
end type

type cb_4 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 3369
integer y = 2388
integer width = 343
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Excel"
end type

event clicked;INTEGER I
decimal ldc_pr_pz, ldc_pr_man, ldc_verifica_prezzo
string ls_cliente,ls_cod_art, ls_des_prezzo, ls_filtro,ls_filename, ls_des_1
long ll_riga_inserita, LL_ID_ART
integer li_righe


ls_filtro= dw_2.describe("datawindow.table.filter")

DW_2.SETFILTER(" c_scelto=1 and "+ls_filtro)
dw_2.filter()
li_righe=dw_2.rowcount()
if li_righe<=0 then 
	messagebox("Attenzione!", "Non hai selezionato alcuna riga")
	return
end if

//dw_7.reset()
//for i=1 to li_righe
//	ls_cod_art=""
//	ls_cliente=""
//	ldc_pr_pz=0
//	ldc_pr_man=0
//	ls_des_prezzo=""
//	ls_des_1=""
//	ldc_verifica_prezzo=0
//	LL_ID_ART=0
//	ls_cod_art=dw_2.getitemstring(i, "articolo_codice")
//	ls_cliente=dw_2.getitemstring(i,"prezzo_cliente")
//	ldc_pr_pz=dw_2.getitemdecimal(i,"prezzo_prezzo")
//	ldc_pr_man=dw_2.getitemdecimal(i,"prezzo_prezzo_manifattura")
//	ls_des_prezzo=dw_2.getitemstring(i,"prezzo_des_2")
//	ls_des_1=dw_2.getitemstring(i,"prezzo_des_1")
//	LL_ID_ART=dw_2.getitemnumber(i,"id_articolo")
//	ldc_verifica_prezzo=dw_2.getitemdecimal(i,"c_controllato_k")
//	if ldc_verifica_prezzo<=0.00002 then ldc_verifica_prezzo=0
//	ll_riga_inserita=dw_7.insertrow(0)
//	dw_7.setitem(ll_riga_inserita, "cod_articolo", ls_cod_art)
//	dw_7.setitem(ll_riga_inserita, "cliente", ls_cliente)
//	dw_7.setitem(ll_riga_inserita, "pr_pz", ldc_pr_pz)
//	dw_7.setitem(ll_riga_inserita, "pr_man", ldc_pr_man)
//	dw_7.setitem(ll_riga_inserita, "descrizione_prezzo", ls_des_prezzo)
//	dw_7.setitem(ll_riga_inserita, "des_1", ls_des_1)
//	dw_7.setitem(ll_riga_inserita, "id_articolo", LL_ID_ART)	
//	dw_7.setitem(ll_riga_inserita, "controllato_k", ldc_verifica_prezzo)	
//	//controllato_k
//next
//ls_filename=""
//dw_7.saveas(ls_filename, Excel!, true)      // il true vuol dire con intestazione
//
//DW_2.SETFILTER(ls_filtro)
//dw_2.filter()
//
end event

type cbx_2 from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 2560
integer y = 4
integer width = 439
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo Vedi"
end type

event clicked;if checked then
	dw_1.setfilter("c_vedi = 1")
	dw_1.filter()
	dw_1.groupcalc()
else
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.groupcalc()
end if
end event

type cb_3 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 1874
integer width = 187
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;integer li_ret, i, li_num_colli, a
dwitemstatus dwis_stato
long ll_id_riga

dw_1.accepttext()

if messagebox("Attenzione!", "Modifica i 101-100 solo se sei MOLTO sicura!!! Vuoi davvero modificarli?", stopsign!,  yesno!)=1 then

	for i = 1 to dw_1.rowcount()
		dwis_stato=dw_1.getitemstatus(i, 0, primary!)
		if dwis_stato=NotModified! then continue
		li_num_colli=dw_1.getitemnumber(i, "num_colli")
		ll_id_riga=dw_1.getitemnumber(i, "id_riga_documento")
		update dba.riga_documento set num_colli=:li_num_colli
		where id_riga_documento=:ll_id_riga;
		if sqlca.sqlNrows>0 then
			commit;
			a++
		else
			rollback;
			messagebox("Attenzione!", "Salvataggio Fallito!")
		end if
	next
	messagebox("Righe Salvate", "Salvate n. "+string(a)+" righe!")
end if


end event

type cb_2 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 2496
integer y = 2364
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "for"
end type

event clicked;//integer i, li_test
//long ll_id_riga
//
//il_id_sog=143
//idt_DATA=date(today())
//il_id_prof=119
//for i=1 to dw_1.rowcount()
//	li_test=0
//	li_test=dw_1.getitemnumber(i, "c_nc")
//	if li_test>0  then
//		ll_id_riga=dw_1.getitemnumber(i, "riga_documento_id_riga_documento")
//		dw_3.retrieve(ll_id_riga)
//		update dba.riga_documento set num_colli=100 where id_riga_documento=:ll_id_riga;
//		if sqlca.sqlNrows>0 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "Riga "+string(i)+" NON segnata!")
//		end if
//	end if
//next
//wf_crea_doc_e_righe(il_id_sog, idt_DATA, il_id_prof)
end event

type dw_3 from udw_001 within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 41
integer y = 2020
integer width = 4091
integer taborder = 50
string dataobject = "ds_riga_documento_ra_id_riga"
end type

event retrievestart;call super::retrievestart;return 2
end event

type dw_2 from udw_001 within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 27
integer y = 1780
integer width = 3625
integer height = 188
integer taborder = 50
string dataobject = "ds_documento_2016"
end type

event doubleclicked;//
long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica

ll_id_doc=getitemnumber(row, "id_documento")

if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type cb_nc from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 3008
integer y = 40
integer width = 128
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "NC"
end type

event clicked;
dw_1.accepttext()

wf_prepara_doc_righe("c_nc")

end event

type cb_nd from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 3191
integer y = 40
integer width = 114
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "ND"
end type

event clicked;

wf_prepara_doc_righe("c_nd")




//integer i, li_test
//long ll_id_riga, ll_riga, ll_id_doc, ll_id_riga_ddt
//decimal ldc_prezzo, ldc_qta
//string ls_num_fat, ls_des, ls_num_ddt
//date ldt_data_fat, ldt_data_ddt
//
//il_id_sog=43
//idt_DATA=date(today())
//il_id_prof=183
//dw_2.reset()
//dw_3.reset()
//for i=1 to dw_1.rowcount()
//	li_test=0
//	li_test=dw_1.getitemnumber(i, "c_nd")
//	if li_test=1  then
//		ll_id_riga=dw_1.getitemnumber(i, "riga_documento_id_riga_documento")
//		
//		ll_id_doc=dw_1.getitemnumber(i, "documento_id_documento")
//		ldc_prezzo=dw_1.getitemnumber(i, "prezzo") - dw_1.getitemnumber(i, "c_prezzo")
//		ldc_prezzo=abs(ldc_prezzo)
//		dw_3.retrieve(ll_id_riga)
//		ll_riga=dw_3.rowcount()
//		dw_3.setitem(ll_riga, "prezzo_complessivo", ldc_prezzo)
//		//dw_3.setitem(ll_riga, "id_listino", 15)
//		ll_id_riga_ddt=dw_3.getitemnumber(ll_riga, "id_riga_Doc_provenienza")
//		SELECT NUM_DOCUMENTO, DATA_DOCUMENTO into :ls_num_ddt, :ldt_data_ddt
//		from dba.documento d, riga_documento r where d.id_documento = r.id_documento and id_riga_documento=:ll_id_riga_ddt;
//		
//		SELECT NUM_DOCUMENTO, DATA_DOCUMENTO into :ls_num_fat, :ldt_data_fat
//		from dba.documento where id_documento = :ll_id_doc;
//		ls_des="Nota di credito rif. fat. n. "+ls_num_fat+" del "+string(ldt_data_fat, "dd/mm/yyyy") +" a sua volta rif. a ddt. n. "+ls_num_ddt+" del "+string(ldt_data_ddt, "dd/mm/yyyy")
//		dw_3.setitem(ll_riga, "descrizione", ls_des)
//		dw_3.setitem(ll_riga, "peso_netto", 0)
//		ldc_qta=dw_3.getitemnumber(ll_riga, "quantita")
//		dw_3.setitem(ll_riga, "tot_riga_val_riga", round(ldc_prezzo, 4)*ldc_qta)
//		dw_3.setitem(ll_riga, "importo_manifattura", round(ldc_prezzo, 4)*ldc_qta)
//		update dba.riga_documento set num_colli=101 where id_riga_documento=:ll_id_riga;
//		if sqlca.sqlNrows>0 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "Riga "+string(i)+" NON segnata!")
//		end if
//	end if
//next
//wf_crea_doc_e_righe(il_id_sog, idt_DATA, il_id_prof)
end event

type cbx_1 from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 2560
integer y = 72
integer width = 439
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo venduto=0"
end type

event clicked;if checked then
	dw_1.setfilter("c_tot_ven_qta = 0")
	dw_1.filter()
	dw_1.groupcalc()
else
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.groupcalc()
end if
end event

type cbx_solo_aperti from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 2217
integer y = 76
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Solo aperti"
end type

event clicked;if checked then
	dw_1.setfilter("c_solo_aperti > 0")
	dw_1.filter()
	dw_1.groupcalc()
else
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.groupcalc()
end if
end event

type cbx_vedi_doc from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 2217
integer y = 12
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Vedi Doc."
end type

event clicked;if checked then
	dw_1.modify("datawindow.trailer.2.height = 80")
else
	dw_1.modify("datawindow.trailer.2.height = 0")
end if
end event

type cbx_vedi_totali from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 1879
integer y = 76
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi Totali"
end type

event clicked;if checked then
	if dw_1.dataobject="d_prod_2011_tb" then
		dw_1.modify("datawindow.summary.height = 76")
	else
		dw_1.modify("datawindow.trailer.2.height = 248")
	end if
else
	if dw_1.dataobject="d_prod_2011_tb" then
		dw_1.modify("datawindow.summary.height = 148")
	else
		dw_1.modify("datawindow.trailer.2.height = 0")
	end if
end if
end event

type cbx_vedi_righe from checkbox within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 1879
integer y = 8
integer width = 343
integer height = 72
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
	if dw_1.dataobject="d_prod_2011_tb" then
		dw_1.modify("datawindow.detail.height = 76")
		dw_1.modify("data_documento_t.visible=1")
		dw_1.modify("num_documento_t.visible=1")
		dw_1.modify("causale_t.visible=1")
	else
		dw_1.modify("datawindow.detail.height.Autosize = Yes")
		dw_1.modify("datawindow.header.2.height = 172")
	end if		
else
	if dw_1.dataobject="d_prod_2011_tb" then
		dw_1.modify("datawindow.detail.height = 0")
		dw_1.modify("data_documento_t.visible=0")
		dw_1.modify("causale_t.visible=0")
	else
		dw_1.modify("datawindow.detail.height.autosize = No")
		dw_1.modify("datawindow.header.2.height = 92")
	end if
	
end if
end event

type sle_pg from singlelineedit within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 1207
integer y = 32
integer width = 379
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 937
integer y = 40
integer width = 270
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Stampa Pg.:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 1591
integer y = 40
integer width = 151
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Copie:"
boolean focusrectangle = false
end type

type sle_copie from singlelineedit within w_trova_prezzi_articolo_in_riga_doc_rpt
boolean visible = false
integer x = 1737
integer y = 32
integer width = 133
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_zoom from singlelineedit within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 663
integer y = 32
integer width = 133
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;ii_zoom=integer(this.text)
dw_1.object.datawindow.zoom=ii_zoom

end event

type cb_7 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 805
integer y = 36
integer width = 123
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OUT"
end type

event clicked;ii_zoom=ii_zoom - 5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_6 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 562
integer y = 36
integer width = 110
integer height = 88
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "IN"
end type

event clicked;ii_zoom=ii_zoom+5
dw_1.object.datawindow.zoom=ii_zoom
sle_zoom.text=string(ii_zoom)
end event

type cb_imp_st from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 3589
integer y = 40
integer width = 297
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imp. Stamp."
end type

event clicked;printsetup()
dw_1.object.datawindow.print.preview='yes'
dw_1.object.datawindow.print.preview.rulers='yes'
end event

type cb_stampa from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 3899
integer y = 40
integer width = 215
integer height = 88
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Stampa"
end type

event clicked;
dw_1.accepttext()

printsetup()
 if upperbound(s_dati.as_string)>=5 then
	if s_dati.as_string[5]="d_trova_prezzi_in_riga_ndnc_rpt" then
		dw_1.modify("c_vedi.visible=0")
		dw_1.modify("st_vedi.visible=0")
		dw_1.modify("sog_commerciale_tipo.visible=0")

	end if
end if
dw_1.print()
dw_1.modify("c_vedi.visible=1")
dw_1.modify("st_vedi.visible=1")
dw_1.modify("sog_commerciale_tipo.visible=1")
end event

type cb_preview from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 3346
integer y = 40
integer width = 238
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview"
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	dw_1.object.datawindow.print.preview='yes'
	dw_1.object.datawindow.print.preview.rulers='yes'
else
	cb_preview.text='Preview'
	dw_1.object.datawindow.print.preview='No'
	dw_1.object.datawindow.print.preview.rulers='no'
end if
end event

type cb_pg_dopo from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 434
integer y = 36
integer width = 91
integer height = 88
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_pg_prima from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 325
integer y = 36
integer width = 91
integer height = 88
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_1 from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 37
integer y = 36
integer width = 261
integer height = 88
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Annulla"
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 27
integer y = 152
integer width = 4530
integer height = 2128
integer taborder = 120
string dataobject = "d_trova_prezzi_articolo_in_riga_rpt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event printpage;//integer li_copie, li_ap, i , li_pos=0, li_inizio, li_fine
//string ls_nr_pg
//boolean lb_stampa=false
//
//
//
//ls_nr_pg=sle_pg.text
//if isnull(ls_nr_pg) then ls_nr_pg='T'
//
//choose case ls_nr_pg
//	case 'T'
//		
//	case 'P'
//		if mod(pagenumber, 2)<>0 then
//			return 1
//		end if
//	case 'D'
//		if mod(pagenumber, 2)=0 then
//			return 1
//		end if	
//	case else
//		li_copie=len(ls_nr_pg)
//      li_pos=pos(ls_nr_pg, "-", li_pos+1)
//		if li_pos>0 then	
//			li_inizio=integer(left(ls_nr_pg, li_pos - 1))
//			li_fine=integer(right(ls_nr_pg, li_copie - li_pos))
//			if li_fine=0 or isnull(li_fine) then li_fine=pagenumber
//			if li_inizio=0 or li_fine=0 or isnull(li_inizio) then
//				messagebox("Attenzione!", "Pagine da stampare non impostate correttamente")
//			end if
//			if pagenumber>=li_inizio and pagenumber<=li_fine then lb_stampa=true
//		else	
//			for i = 1 to li_copie
//				if li_pos>=i then continue
//				//if li_pos>=li_copie then exit
//				li_pos=pos(ls_nr_pg, ",", li_pos+1)
//				if li_pos=0 then li_pos=li_copie + 1
//				li_ap=integer(mid(ls_nr_pg, i, li_pos - 1))
//				if li_ap=0 or isnull(li_ap) then
//					messagebox("Attenzione!", "Pagine da stampare non impostate correttamente")
//				else
//					if li_ap=pagenumber then 
//						lb_stampa=true
//						exit
//					end if
//				end if
//			next
//		end if
//		if lb_stampa=false then return 1
//end choose
//
//
////messagebox("pagina", pagenumber)
//
////messagebox("copie", copy)
end event

event printstart;integer li_copie
string ls_pg, ls_orienta

li_copie=integer(sle_copie.text)
if isnull(li_copie) or li_copie=0 then li_copie=1
dw_1.Modify("DataWindow.Print.copies = "+string(li_copie))

ls_pg=sle_pg.text
dw_1.Modify("DataWindow.Print.Page.Range = '"+ls_pg+"'")
end event

event sqlpreview;string ls_sql,  ls_sql_temp
//long ll_id_ordine[]
//
integer i, li_pos
ls_sql=sqlsyntax
//	
if s_dati.as_string[3]>" " then
	ls_sql+=" and right(registro.tipo_registro, 1)= '"+s_dati.as_string[3]+"'"
end if
if s_dati.as_string[4]>" " then
	ls_sql+=" and registro.tipo_registro= '"+s_dati.as_string[4]+"'"
end if
if s_dati.as_string[6]>" " then
	ls_sql+=" and documento.num_documento like '"+s_dati.as_string[6]+"%'"
end if


if s_dati.ll_id_doc[1] > 0 then //questo è l'id_prof_documento
	ls_sql+=" and documento.id_prof_documento= "+string(s_dati.ll_id_doc[1])
end if
if upperbound(s_dati.ll_id_prof) >0 then
	for i= 1 to upperbound(s_dati.ll_id_prof) 
		if i=1 then 
			ls_sql+=" and (documento.id_prof_documento= "+string(s_dati.ll_id_prof[i])
		else
			ls_sql+=" or documento.id_prof_documento= "+string(s_dati.ll_id_prof[i])
		end if
	next
	ls_sql+=" ) "
end if
if upperbound(s_dati.li_anno) >0 then
	for i= 1 to upperbound(s_dati.li_anno) 
		if i=1 then 
			ls_sql+=" and (year(documento.data_documento)= "+string(s_dati.li_anno[i])
		else
			ls_sql+=" or year(documento.data_documento)= "+string(s_dati.li_anno[i])
		end if
	next
	ls_sql+=" ) "
end if
if s_dati.ll_id_doc[2]> 0 then//questo è l'id_registro
	ls_sql+=" and registro.id_registro= "+string(s_dati.ll_id_doc[2])
end if
if long(s_dati.as_string[7])> 0 then//questo è lid_soggetto fornitore 20230428
	ls_sql+=" and documento.id_sog_commerciale= "+s_dati.as_string[7]
end if
if s_dati.as_string[5]="d_mov_art_gd"  then
	if s_dati.as_string[10] >" " and s_dati.as_string[11]> " " then
		ls_sql+=" and (documento.data_documento)>= date('"+ s_dati.as_string[10]+"') "  &
		+ " and (documento.data_documento)<=  date( '"+ s_dati.as_string[11]+"') " 		
	end if
end if
if (pos(s_dati.as_string[5], "d_trova_prezzi_articolo_in_riga_tutti")>0 or pos(s_dati.as_string[5], "d_trova_prezzi_in_riga_tutti_ndnc")>0) then
	if s_dati.as_string[10] >" " and s_dati.as_string[11]> " " then
		ls_sql+=" and (documento.data_documento)>= date('"+ s_dati.as_string[10]+"') "  &
		+ " and (documento.data_documento)<=  date( '"+ s_dati.as_string[11]+"') " 		
	end if
	if  string(s_dati.as_string[2])> " " then	ls_sql+=" and riga_documento.id_articolo= "+string(s_dati.as_string[2]) +" "
end if


if setsqlpreview(ls_sql)<>1 then
	messagebox("SQLpreview", ls_sql)
end if

end event

event doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list
string ls_tipo_reg

if dwo.name<>"c_nd" and dwo.name<>"c_nc" then
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	if dw_1.dataobject="d_segui_produzione_rpt" then
		ll_id_doc=getitemnumber(row, "id_documento")
	else
		ll_id_doc=getitemnumber(row, "documento_id_documento")
	end if
	ls_tipo_reg=getitemstring(row, "registro_tipo_registro")
	if ll_id_doc>0 and ls_tipo_reg<>'IV' then //20230711 samy: se sono fatture NON si devono aprire
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
end if
end event

event itemchanged;//if dwo.name='c_nc' then
//	if data='1' then
//		dw_3.retrieve(
//	
//end if
end event

event clicked;integer i, li_gia_fatto
decimal ldc_prezzo_attuale, ldc_prezzo_listino,ldc_differenza
string ls_tipo_reg,ls_test

if dwo.name="b_seleziona" then
	for i= 1 to rowcount()
		li_gia_fatto=0
		li_gia_fatto=getitemnumber(i, "c_nc")
		if li_gia_fatto>0 then 
			continue
		else
			li_gia_fatto=getitemnumber(i, "c_nc")
			if li_gia_fatto>0 then continue
		end if
		ls_tipo_reg=getitemstring(i, "registro_tipo_registro")
		if ls_tipo_reg="IV" then //seleziona solo se sono fatture (IV)
			ldc_prezzo_attuale=getitemdecimal(i, "c_prezzo")
			ldc_prezzo_listino=getitemdecimal(i, "prezzo")
			ldc_differenza=abs(round(ldc_prezzo_attuale, 4) - round(ldc_prezzo_listino, 4) )
			if ldc_differenza>= 0.0001 then
				if ldc_prezzo_attuale>ldc_prezzo_listino then //nota di credito 100 c_nc 
					setitem(i, "c_nc", 1)
				else
					setitem(i, "c_nd", 1)
				end if
			end if
		end if
		
	next
end if
if left(dwo.name, 2)="t_" then
	ls_test=dw_1.describe(dwo.name+".text")
	if ls_test="-" then 
		ls_test="V"
		wf_oscura("N", string(dwo.name))
	else
		ls_test="-"
		wf_oscura("S", string(dwo.name))
	end if
	dw_1.modify(dwo.name+".text='"+ls_test+"'")
end if
end event

event rbuttondown;string ls_campo, ls_sort

if dwo.type="column" or dwo.type="compute" then
ls_campo=string(dwo.name)
ls_sort=ls_campo+" A,"
dw_1.setsort(ls_sort)
dw_1.sort()
end if
end event

type cb_salva_su_file from commandbutton within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 1874
integer y = 72
integer width = 187
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "EXCEL"
end type

event clicked;date ldt_data_doc
long ll_num_prog, ll_riga_inserita
integer  i
string ls_articolo,ls_prof_doc, ls_num_doc, ls_descrizione
decimal ldc_qta, ldc_prezzo_in_fat, ldc_prezzo_listino

for i= 1 to dw_1.rowcount()
	ldt_data_doc=dw_1.getitemdate(i, "documento_data_documento")
	ll_num_prog=dw_1.getitemnumber(i, "documento_num_progressivo")
	ls_prof_doc=dw_1.getitemstring(i, "prof_documento_codice")
	ls_num_doc=dw_1.getitemstring(i, "documento_num_documento")
	
	ls_articolo=dw_1.getitemstring(i, "articolo_codice")
	ls_descrizione=dw_1.getitemstring(i, "riga_documento_descrizione")
	ldc_qta=dw_1.getitemdecimal(i, "riga_documento_quantita_1")
	ldc_prezzo_in_fat=dw_1.getitemdecimal(i, "c_prezzo")
	ldc_prezzo_listino=dw_1.getitemdecimal(i, "prezzo")
	ll_riga_inserita=dw_5.insertrow(0)
	dw_5.setitem(ll_riga_inserita, "data_doc",ldt_data_doc)
	dw_5.setitem(ll_riga_inserita, "num_prog",ll_num_prog)
	dw_5.setitem(ll_riga_inserita, "prof_doc", ls_prof_doc)
	dw_5.setitem(ll_riga_inserita, "num_doc", ls_num_doc)

	dw_5.setitem(ll_riga_inserita, "cod_articolo",  ls_articolo)
	dw_5.setitem(ll_riga_inserita, "descrizione" , ls_descrizione)
	dw_5.setitem(ll_riga_inserita, "qta", ldc_qta)
	dw_5.setitem(ll_riga_inserita, "prezzo", ldc_prezzo_in_fat)
	dw_5.setitem(ll_riga_inserita, "prezzo_ok", ldc_prezzo_listino)
next


dw_5.SaveAs("", Excel8!, true)
end event

type dw_4 from udw_001 within w_trova_prezzi_articolo_in_riga_doc_rpt
integer x = 3680
integer y = 2036
integer width = 443
integer height = 188
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_data_una_ext"
end type

