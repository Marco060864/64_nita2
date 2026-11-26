forward
global type w_passa_doc_automatico from w_001
end type
type dw_1 from udw_base within w_passa_doc_automatico
end type
type cb_carica from commandbutton within w_passa_doc_automatico
end type
type dw_3 from udw_base within w_passa_doc_automatico
end type
type cb_importa from commandbutton within w_passa_doc_automatico
end type
type dw_4 from udw_base within w_passa_doc_automatico
end type
type dw_5 from udw_base within w_passa_doc_automatico
end type
type cb_reset from commandbutton within w_passa_doc_automatico
end type
type dw_6 from udw_base within w_passa_doc_automatico
end type
type dw_7 from udw_base within w_passa_doc_automatico
end type
type cb_passa from commandbutton within w_passa_doc_automatico
end type
type cb_1 from commandbutton within w_passa_doc_automatico
end type
type dw_9 from udw_base within w_passa_doc_automatico
end type
type dw_2 from udw_figlia within w_passa_doc_automatico
end type
type dw_8 from udw_base within w_passa_doc_automatico
end type
end forward

global type w_passa_doc_automatico from w_001
boolean visible = false
integer x = 1057
integer y = 483
integer width = 3657
integer height = 1936
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
cb_carica cb_carica
dw_3 dw_3
cb_importa cb_importa
dw_4 dw_4
dw_5 dw_5
cb_reset cb_reset
dw_6 dw_6
dw_7 dw_7
cb_passa cb_passa
cb_1 cb_1
dw_9 dw_9
dw_2 dw_2
dw_8 dw_8
end type
global w_passa_doc_automatico w_passa_doc_automatico

type variables
transaction trans_destinazione
end variables

forward prototypes
public subroutine wf_articolo (long al_id_articolo, long al_riga_doc)
public function long wf_importa (integer ai_riga)
end prototypes

public subroutine wf_articolo (long al_id_articolo, long al_riga_doc);string ls_codice
long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_tab_iva
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc

setnull(ll_null)
ll_riga_trovata=dw_4.find("id_articolo="+string(al_id_articolo), 1, dw_4.rowcount())
if ll_riga_trovata>0 then
	ls_codice=dw_4.getitemstring(ll_riga_trovata, "codice")
	select id_articolo
	into :ll_id_art_locale
	from dba.articolo
	where codice=:ls_codice
	USING trans_destinazione
;
	if ll_id_art_locale>0 then //l'articolo esiste già non si deve fare nulla a parte recuperare la uc ...
		dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
		ll_riga_uc=dw_7.retrieve(ll_id_art_locale)
		if ll_riga_uc>0 then
			ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
			dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
		else
			
		end if
	else //l'articolo non esiste occorre inserirlo
		dw_6.reset()
		dw_7.reset()
		ll_riga_trovata_uc=dw_5.find("id_articolo="+string(al_id_articolo), 1, dw_5.rowcount())
		if ll_riga_trovata_uc>0 then
			dw_4.rowscopy(ll_riga_trovata, ll_riga_trovata, primary!, dw_6, 1, primary!)
			dw_6.setitem(1, "id_articolo", ll_null)
			dw_6.setitem(1,"id_sog_comm_variante", ll_null)
			ll_id_tab_iva=dw_6.getitemnumber(1, "id_tab_iva")
			if isnull(ll_id_tab_iva) then dw_6.setitem(1, "id_tab_iva",122) //22%
			dw_6.setitemstatus(1, 0, Primary!, NewModified!)
			
			dw_6.trigger event ue_update()
			ll_id_art_locale=dw_6.getitemnumber(1, "id_articolo")
			dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
			ll_id_um=dw_5.getitemnumber(ll_riga_trovata_uc, "id_unita_misura")
			ll_riga_uc=dw_7.retrieve(ll_id_art_locale)
			if ll_riga_uc>0 then
				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
				dw_7.setitem(1, "id_unita_misura", ll_id_um)
				dw_7.trigger event ue_update()
			else
				dw_5.rowscopy(ll_riga_trovata_uc, ll_riga_trovata_uc, primary!, dw_7, 1, primary!)
				dw_7.SetItem(1,"id_unita_confezione", ll_null)
				dw_7.setitem(1, "id_articolo", ll_id_art_locale)
				dw_7.setitemstatus(1, 0, Primary!, NewModified!)
				dw_7.trigger event ue_update()	
				ll_id_uc=dw_7.getitemnumber(1, "id_unita_confezione")
				dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
			end if
		end if
	end if
end if
end subroutine

public function long wf_importa (integer ai_riga);long ll_id_prof, ll_id_mag, ll_id_reg_mod, ll_id_locazione, ll_id_causale, ll_id_esercizio, ll_id_reg
date ldt_data_odierna, ldt_data_doc
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
string ls_tipo_registro, ls_numero, ls_nota,ls_prof_codice
long ll_null, ll_righe, ll_id_art, ll_id_doc,ll_num_prog_esistente, ll_id_sog_intestatario, ll_return
integer i, li_ret
long ll_id_tab_iva

setnull(ll_null)
ll_id_sog_intestatario=dw_3.getitemnumber(1, "id_sog_commerciale")
if ll_id_sog_intestatario>0 then
	ls_prof_codice=dw_8.getitemstring(ai_riga, "prof_documento_codice")
	if pos(ls_prof_codice, "NP")>0 then
		ll_id_prof=dw_3.getitemnumber(1, "id_profilo_2")
	else
		ll_id_prof=dw_3.getitemnumber(1, "id_profilo")
	end if
	if ll_id_prof>0 then
		
		//con il profilo trovo magazzino, locazione, causale e registro (modello)
		select id_magazzino_1_prop, id_mod_registro_prop, id_locazione_1_prop, id_caus_magazzino_prop
		into :ll_id_mag, :ll_id_reg_mod, :ll_id_locazione, :ll_id_causale
		from dba.prof_documento
		where id_prof_documento=:ll_id_prof
		using trans_destinazione
		;
		//ora trovo il registro attuale (modello registro riportato alla data odierna)
		ldt_data_odierna=date(today())
		select id_esercizio
		into :ll_id_esercizio
		from dba.esercizio
		where data_inizio<= :ldt_data_odierna
		and data_fine>=:ldt_data_odierna
		using trans_destinazione
		;
		
		SELECT Max("registro"."id_registro")
		INTO :ll_id_reg  
		FROM "dba"."registro"  
		WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
				( "registro"."id_mod_registro" = :ll_id_reg_mod )
				using trans_destinazione
				;
		select tipo_registro, num_progressivo
		into :ls_tipo_registro, :ls_trova_prog.sl_num_progressivo
		from dba.registro
		where id_registro=:ll_id_reg
		using trans_destinazione;
		
		//controllo che il documento non esista già
		ls_numero=dw_1.getitemstring(1, "num_documento")
		ldt_data_doc=dw_1.getitemdate(1, "data_documento")
		ll_num_prog_esistente=0
		select num_progressivo
		into :ll_num_prog_esistente
		from dba.documento
		where id_registro=:ll_id_reg
		and num_documento=:ls_numero
		and data_documento=:ldt_data_doc
		using trans_destinazione
		;
		if ll_num_prog_esistente>0 then
			messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog_esistente)+"!")
		else
			dw_1.SetItem(1, "id_sog_commerciale", ll_id_sog_intestatario)
			dw_1.SetItem(1, "id_sog_commerciale_fattura", ll_id_sog_intestatario)
			dw_1.SetItem(1, "id_registro", ll_id_reg)
			dw_1.SetItem(1, "id_prof_documento", ll_id_prof)
			dw_1.SetItem(1, "num_progressivo", ls_trova_prog.sl_num_progressivo)
			dw_1.SetItem(1, "data_registrazione", ldt_data_odierna)
			dw_1.SetItem(1, "id_caus_magazzino", ll_id_causale)
			dw_1.SetItem(1, "id_locazione_1", ll_id_locazione)
			dw_1.SetItem(1, "id_magazzino", ll_id_locazione)
			dw_1.SetItem(1, "id_variazione", ll_null)
			
			
			//24052017aggiungo in  ORIGINE che non è mai usato un segno che è inserito in automatico da questo passaggio dati 24052017
//			ls_nota=dw_1.getItemstring(1, "note_intestazione")
//			if isnull(ls_nota) then ls_nota=""
//			dw_1.SetItem(1, "note_intestazione", "PDA - Inserito in automatico.  -  "+ls_nota)
			ls_nota=string(today(), "dd/mm/yy hh:mm")
			dw_1.SetItem(1, "origine",  "PDA - Ins. automatico -"+ls_nota)
			
			//fine 24052017
			dw_1.SetItem(1, "id_documento", ll_null)
			dw_1.setitemstatus(1, 0, Primary!, NewModified!)
			//salvo doc
			li_ret=dw_1.trigger event ue_update()
			//ora le righe
			ll_id_doc=dw_1.getitemnumber(1, "id_documento")
			if ll_id_doc>0 then
				ll_righe=dw_2.rowcount()
				for i= 1 to ll_righe
					dw_2.SetItem(i, "id_documento", ll_id_doc)
					dw_2.SetItem(i, "id_riga_documento", ll_null)
					dw_2.SetItem(i, "id_caus_magazzino", ll_id_causale)
					dw_2.SetItem(i, "id_locazione_1", ll_id_locazione)
//					ll_id_tab_iva=dw_2.getitemnumber(1, "id_tab_iva")
//					if ll_id_tab_iva<>122 then
						dw_2.SetItem(i, "id_tab_iva", 122) //iva al 22% se l'iva non ci fosse ...
					//end if
					ll_id_art=dw_2.getitemnumber(i, "id_articolo")
					dw_4.retrieve(ll_id_art)
					dw_5.retrieve(ll_id_art)
					wf_articolo(ll_id_art, i)
					dw_2.setitemstatus(i, 0, Primary!, NewModified!)
					
				next
				//salvo righe
				li_ret=dw_2.trigger event ue_update()
				if li_ret=1 then
					ll_return=ll_id_doc
				end if
			else
				messagebox("Attenzione!", "Doc NON salvato!!")
			end if
		end if
	else
		messagebox("Attenzione!", "Inserire il profilo documento!!")
	end if
else
	messagebox("Attenzione!", "Inserire l'intestatario del documento!!")
end if
return ll_return
	
	
	

end function

on w_passa_doc_automatico.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_carica=create cb_carica
this.dw_3=create dw_3
this.cb_importa=create cb_importa
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cb_reset=create cb_reset
this.dw_6=create dw_6
this.dw_7=create dw_7
this.cb_passa=create cb_passa
this.cb_1=create cb_1
this.dw_9=create dw_9
this.dw_2=create dw_2
this.dw_8=create dw_8
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_carica
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_importa
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.dw_5
this.Control[iCurrent+7]=this.cb_reset
this.Control[iCurrent+8]=this.dw_6
this.Control[iCurrent+9]=this.dw_7
this.Control[iCurrent+10]=this.cb_passa
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.dw_9
this.Control[iCurrent+13]=this.dw_2
this.Control[iCurrent+14]=this.dw_8
end on

on w_passa_doc_automatico.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_carica)
destroy(this.dw_3)
destroy(this.cb_importa)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cb_reset)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.cb_passa)
destroy(this.cb_1)
destroy(this.dw_9)
destroy(this.dw_2)
destroy(this.dw_8)
end on

event open;call super::open;string ls_azienda,ConnectString, ls_odbc_destinazione

//questi sono locali
dw_5.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_8.settransobject(sqlca)
dw_9.settransobject(sqlca)

dw_8.retrieve()

select odbc_destinazione
into :ls_odbc_destinazione
from dba.orafo_par_sistema
;
if isnull(ls_odbc_destinazione) then ls_odbc_destinazione='prova'

trans_destinazione = CREATE transaction
// Set connection parameters in the transaction object
trans_destinazione.DBMS = "ODBC"
trans_destinazione.DBParm = "ConnectString='DSN="+ls_odbc_destinazione+"'"
CONNECT USING trans_destinazione;

dw_1.settransobject(trans_destinazione)
dw_2.settransobject(trans_destinazione)
dw_3.settransobject(trans_destinazione)
dw_6.settransobject(trans_destinazione)
dw_2.settransobject(trans_destinazione)
dw_7.settransobject(trans_destinazione)

select rag_soc_1
into :ls_azienda
from dba.azienda
using trans_destinazione
;
dw_3.insertrow(1)
if pos(ls_azienda, "Panna Art")>0 then
	dw_3.setitem(1, "id_profilo",28)
	dw_3.setitem(1, "id_profilo_2",153)
	dw_3.setitem(1, "id_sog_commerciale",1869)
end if


end event

type st_1 from w_001`st_1 within w_passa_doc_automatico
end type

type dw_1 from udw_base within w_passa_doc_automatico
boolean visible = false
integer x = 1993
integer y = 1772
integer width = 1609
boolean bringtotop = true
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
end type

type cb_carica from commandbutton within w_passa_doc_automatico
integer x = 3621
integer y = 1808
integer width = 320
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica "
end type

event clicked;integer li_ret


string ls_path, ls_file
	
getfileopenname("Cerca DOCasci_", ls_path, ls_file)
//if  not(trim(ls_file)="" or isnull(ls_file)) then
//	 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_path)
//	end if
//end if	 

li_ret=dw_1.importfile(ls_file, 2, 2)
if li_ret=1 then
	ls_file="Riga"+right(ls_file, len(ls_file) -3)
	li_ret=dw_2.importfile(ls_file, 2, 9999)
	ls_file="Art"+right(ls_file, len(ls_file) -4)
	li_ret=dw_4.importfile(ls_file, 2, 99999)
	ls_file="Uc"+right(ls_file, len(ls_file) -3)
	li_ret=dw_5.importfile(ls_file, 2, 99999)
end if


//messagebox("A", li_ret)
//getfileopenname("Cerca RIGAasci_", ls_path, ls_file)
//li_ret=dw_2.importfile(ls_file, 2, 9999)
//messagebox("A", li_ret)
//
//getfileopenname("Cerca ARTasci_", ls_path, ls_file)
//li_ret=dw_4.importfile(ls_file, 2, 9999)
//messagebox("A", li_ret)
//
//getfileopenname("Cerca UCasci_", ls_path, ls_file)
//li_ret=dw_5.importfile(ls_file, 2, 9999)
//messagebox("A", li_ret)
//

end event

type dw_3 from udw_base within w_passa_doc_automatico
integer x = 55
integer y = 40
integer width = 2167
integer height = 180
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_scegli_prof_doc_e_odbc"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_importa from commandbutton within w_passa_doc_automatico
boolean visible = false
integer x = 3250
integer y = 1808
integer width = 320
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importa"
end type

event clicked;long ll_id_prof, ll_id_mag, ll_id_reg_mod, ll_id_locazione, ll_id_causale, ll_id_esercizio, ll_id_reg
date ldt_data_odierna, ldt_data_doc
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
string ls_tipo_registro, ls_numero
long ll_null, ll_righe, ll_id_art, ll_id_doc,ll_num_prog_esistente, ll_id_sog_intestatario
integer i, li_ret

setnull(ll_null)
ll_id_sog_intestatario=dw_3.getitemnumber(1, "id_sog_commerciale")
if ll_id_sog_intestatario>0 then
	ll_id_prof=dw_3.getitemnumber(1, "id_profilo")
	if ll_id_prof>0 then
	
		//con il profilo trovo magazzino, locazione, causale e registro (modello)
		select id_magazzino_1_prop, id_mod_registro_prop, id_locazione_1_prop, id_caus_magazzino_prop
		into :ll_id_mag, :ll_id_reg_mod, :ll_id_locazione, :ll_id_causale
		from dba.prof_documento
		where id_prof_documento=:ll_id_prof
		using trans_destinazione
		;
		//ora trovo il registro attuale (modello registro riportato alla data odierna)
		ldt_data_odierna=date(today())
		select id_esercizio
		into :ll_id_esercizio
		from dba.esercizio
		where data_inizio<= :ldt_data_odierna
		and data_fine>=:ldt_data_odierna
		using trans_destinazione
		;
		
		SELECT Max("registro"."id_registro")
		INTO :ll_id_reg  
		FROM "dba"."registro"  
		WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
				( "registro"."id_mod_registro" = :ll_id_reg_mod )
				using trans_destinazione
				;
		select tipo_registro, num_progressivo
		into :ls_tipo_registro, :ls_trova_prog.sl_num_progressivo
		from dba.registro
		where id_registro=:ll_id_reg
		using trans_destinazione;
		
		//controllo che il documento non esista già
		ls_numero=dw_1.getitemstring(1, "num_documento")
		ldt_data_doc=dw_1.getitemdate(1, "data_documento")
		ll_num_prog_esistente=0
		select num_progressivo
		into :ll_num_prog_esistente
		from dba.documento
		where id_registro=:ll_id_reg
		and num_documento=:ls_numero
		and data_documento=:ldt_data_doc
		using trans_destinazione
		;
		if ll_num_prog_esistente>0 then
			messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog_esistente)+"!")
		else
			dw_1.SetItem(1, "id_sog_commerciale", ll_id_sog_intestatario)
			dw_1.SetItem(1, "id_sog_commerciale_fattura", ll_id_sog_intestatario)
			dw_1.SetItem(1, "id_registro", ll_id_reg)
			dw_1.SetItem(1, "id_prof_documento", ll_id_prof)
			dw_1.SetItem(1, "num_progressivo", ls_trova_prog.sl_num_progressivo)
			dw_1.SetItem(1, "data_registrazione", ldt_data_odierna)
			dw_1.SetItem(1, "id_caus_magazzino", ll_id_causale)
			dw_1.SetItem(1, "id_locazione_1", ll_id_locazione)
			dw_1.SetItem(1, "id_magazzino", ll_id_locazione)
			dw_1.SetItem(1, "id_variazione", ll_null)
			
			dw_1.SetItem(1, "id_documento", ll_null)
			dw_1.setitemstatus(1, 0, Primary!, NewModified!)
			//salvo doc
			li_ret=dw_1.trigger event ue_update()
			//ora le righe
			ll_id_doc=dw_1.getitemnumber(1, "id_documento")
			if ll_id_doc>0 then
				ll_righe=dw_2.rowcount()
				for i= 1 to ll_righe
					dw_2.SetItem(i, "id_documento", ll_id_doc)
					dw_2.SetItem(i, "id_riga_documento", ll_null)
					dw_2.SetItem(i, "id_caus_magazzino", ll_id_causale)
					dw_2.SetItem(i, "id_locazione_1", ll_id_locazione)
					ll_id_art=dw_2.getitemnumber(i, "id_articolo")
					wf_articolo(ll_id_art, i)
					dw_2.setitemstatus(i, 0, Primary!, NewModified!)
					
				next
				//salvo righe
				dw_2.trigger event ue_update()
			else
				messagebox("Attenzione!", "Doc NON salvato!!")
			end if
		end if
	else
		messagebox("Attenzione!", "Inserire il profilo documento!!")
	end if
else
	messagebox("Attenzione!", "Inserire l'intestatario del documento!!")
end if
	
	
	

end event

type dw_4 from udw_base within w_passa_doc_automatico
integer x = 82
integer y = 1856
integer width = 901
integer height = 280
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type dw_5 from udw_base within w_passa_doc_automatico
integer x = 1065
integer y = 1892
integer width = 901
integer height = 280
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_unita_confezione_2016"
boolean hscrollbar = true
end type

type cb_reset from commandbutton within w_passa_doc_automatico
integer x = 3986
integer y = 1804
integer width = 320
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset"
end type

event clicked;dw_1.reset()
dw_2.reset()
dw_4.reset()
dw_5.reset()
dw_6.reset()
dw_7.reset()
end event

type dw_6 from udw_base within w_passa_doc_automatico
integer x = 69
integer y = 2216
integer width = 901
integer height = 280
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type dw_7 from udw_base within w_passa_doc_automatico
integer x = 1070
integer y = 2196
integer width = 887
integer height = 292
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_unita_confezione_2016"
boolean hscrollbar = true
end type

type cb_passa from commandbutton within w_passa_doc_automatico
integer x = 2240
integer y = 116
integer width = 677
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Passa Doc. Selezionati"
end type

event clicked;integer li_ret, i, li_righe, a
long ll_id_riga_doc_provenienza, ll_id_doc, ll_id_riga
string ls_doc, ls_numero, ls_allegati, ls_num_doc, ls_test, ls_numero_doc_inserito
date ldt_data
integer li_pos
long ll_id_art, ll_id_doc_inserito, ll_riga_doc_inserito,ll_num_prog_doc_passato
decimal ldc_num_bollettina

datastore ds_doc, ds_righe
ds_doc=create datastore
ds_doc.dataobject="ds_documento_2016"
ds_doc.settransobject(sqlca)

ds_righe=create datastore
ds_righe.dataobject="ds_riga_documento_2016"
ds_righe.settransobject(sqlca)

dw_8.setfilter("passato_a_fornitore='S'")
dw_8.filter()

for a= 1 to dw_8.rowcount()
	//ls_test='N'
	//ls_test=dw_8.getitemstring(i, "passato_a_fornitore")
	//if ls_test='S' then
		ds_doc.reset()
		ds_righe.reset()
		dw_1.reset()
		dw_2.reset()
		ldt_data=dw_8.getitemdate(a, "data_documento")
		ls_numero=dw_8.getitemstring(a, "num_documento")
		ls_numero_doc_inserito=ls_numero
		li_pos=pos(ls_numero, "/")
		if li_pos>0 then
			ls_numero=left(ls_numero, li_pos -1) +"-"+right(ls_numero, len(ls_numero) - li_pos)
		end if
		ls_doc="n_"+ls_numero+"_del_"+string(ldt_data, "dd-mm-yy")
		ll_id_doc=dw_8.getitemnumber(a, "id_documento")
		li_ret=ds_doc.retrieve(ll_id_doc)
		
		if li_ret>0 then
			li_ret=ds_doc.rowscopy(1, 1, primary!, dw_1, 1, primary!)
			if li_ret<>1 then 
				messagebox("Attenzione!", "Errore copiatura doc!")
				return
			else
			//	li_ret=dw_1.trigger event ue_update()
			end if
		end if
	
		li_righe=ds_righe.retrieve(ll_id_doc)
		if li_righe>0 then
			for i=1 to li_righe
				//inserisco il riferimento (id riga) alla bollettina da cui il RCLF proviene)
				ll_id_riga_doc_provenienza=ds_righe.getitemnumber(i, "provv_imp_subage_2")
				if ll_id_riga_doc_provenienza>0 then
					select num_documento
					into :ls_num_doc
					from dba.riga_documento r, dba.documento d
					where d.id_documento=r.id_documento
					and r.id_riga_documento=:ll_id_riga_doc_provenienza
					;
					li_pos=pos(ls_num_doc, "-")
					ldc_num_bollettina= dec(left(ls_num_doc, li_pos - 1))//+","+right(ls_num_doc, 5))
					ds_righe.setitem(i, "provv_imp_carea_2", dec(right(ls_num_doc, 5))) //provv_imp_carea_2 qui c'è il numero della bollettina ultimi 5 caratteri
					ds_righe.setitem(i, "provv_imp_agente_2", ldc_num_bollettina)  //qui c'è il cliente della bollettina
				end if
				//recupera articoli e uc
				ll_id_art=ds_righe.getitemnumber(i, "id_articolo")
				dw_4.retrieve(ll_id_art)
				dw_5.retrieve(ll_id_art)
				ll_id_riga=ds_righe.getitemnumber(i, "id_riga_documento")
				//wf_articolo(ll_id_art, ll_id_riga)
			next
			li_ret=ds_righe.rowscopy(1, ds_righe.rowcount(), primary!, dw_2, 1, primary!)
			if li_ret<>1 then 
				messagebox("Attenzione!", "Errore copiatura righe!")	
				return
			else
				//li_ret=dw_2.trigger event ue_update()
				//cb_importa.triggerevent(clicked!)
				ll_id_doc_inserito=wf_importa(a)
				if ll_id_doc_inserito>0 then
					//inserisco il doc nella tabella dei doc passati per l'eventuale stampa a memoria
					ll_riga_doc_inserito=dw_9.insertrow(0)
					ll_num_prog_doc_passato=dw_1.getItemnumber(1, "num_progressivo")
					dw_9.setitem(ll_riga_doc_inserito, "num_progressivo", ll_num_prog_doc_passato)
					dw_9.setitem(ll_riga_doc_inserito, "num_documento",	ls_numero_doc_inserito)
					dw_9.setitem(ll_riga_doc_inserito, "data_documento",	ldt_data)
					
					//segno il doc come "passato al fornitore"
					insert into dba.passa_doc_automatico("passato_a_fornitore", "id_documento", "id_doc_passato", "num_prog_doc_passato")
					values('S', :ll_id_doc,:ll_id_doc_inserito,  :ll_num_prog_doc_passato) using sqlca;
					if sqlca.sqlcode=0 then
						commit;
					else
						rollback;
						messagebox("Attenzione!", "Errore salvataggio passato a fornitore!")
					end if
//					dw_8.setitem(i, "passa_doc_automatico_id_documento", ll_id_doc)
//					dw_8.trigger event ue_update()
				end if
			end if
			
		else
			messagebox("Attenzione!", "RIGA non trovata!")
		end if
	//END IF
next
dw_8.setfilter("")
dw_8.filter()
dw_8.retrieve()
//disconnetti db remoto
DISCONNECT USING trans_destinazione;
destroy ds_doc
destroy ds_righe
end event

type cb_1 from commandbutton within w_passa_doc_automatico
integer x = 3278
integer y = 116
integer width = 279
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

type dw_9 from udw_base within w_passa_doc_automatico
integer x = 2240
integer y = 240
integer width = 1321
integer height = 1512
integer taborder = 20
string dataobject = "d_passa_Doc_inseriti"
boolean hscrollbar = true
end type

type dw_2 from udw_figlia within w_passa_doc_automatico
integer x = 1975
integer y = 1904
integer width = 1609
integer height = 404
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
end type

type dw_8 from udw_base within w_passa_doc_automatico
integer x = 55
integer y = 240
integer width = 2167
integer height = 1512
string dataobject = "d_scegli_doc_passadati"
boolean hscrollbar = true
end type

