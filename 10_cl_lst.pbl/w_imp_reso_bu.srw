forward
global type w_imp_reso_bu from w_001
end type
type dw_1 from udw_base within w_imp_reso_bu
end type
type dw_2 from udw_figlia within w_imp_reso_bu
end type
type cb_carica from commandbutton within w_imp_reso_bu
end type
type dw_3 from udw_base within w_imp_reso_bu
end type
type cb_importa from commandbutton within w_imp_reso_bu
end type
type dw_4 from udw_base within w_imp_reso_bu
end type
type dw_5 from udw_base within w_imp_reso_bu
end type
type cb_reset from commandbutton within w_imp_reso_bu
end type
type dw_8 from udw_base within w_imp_reso_bu
end type
type dw_9 from udw_base within w_imp_reso_bu
end type
type dw_10 from udw_base within w_imp_reso_bu
end type
type dw_11 from udw_base within w_imp_reso_bu
end type
type dw_6 from udw_base within w_imp_reso_bu
end type
type dw_7 from udw_base within w_imp_reso_bu
end type
type cb_1 from commandbutton within w_imp_reso_bu
end type
type dw_12 from udw_base within w_imp_reso_bu
end type
type cb_2 from commandbutton within w_imp_reso_bu
end type
type cb_3 from commandbutton within w_imp_reso_bu
end type
end forward

global type w_imp_reso_bu from w_001
integer x = 1057
integer y = 483
integer width = 4055
integer height = 2188
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_2 dw_2
cb_carica cb_carica
dw_3 dw_3
cb_importa cb_importa
dw_4 dw_4
dw_5 dw_5
cb_reset cb_reset
dw_8 dw_8
dw_9 dw_9
dw_10 dw_10
dw_11 dw_11
dw_6 dw_6
dw_7 dw_7
cb_1 cb_1
dw_12 dw_12
cb_2 cb_2
cb_3 cb_3
end type
global w_imp_reso_bu w_imp_reso_bu

type variables
string ls_azienda
end variables

forward prototypes
public subroutine wf_articolo (long al_id_articolo, long al_riga_doc)
public subroutine wf_cambia_iva ()
public function long wf_imp_sog_com (long al_id_ana)
public function long wf_imp_anagrafica ()
public function string wf_estrai_cod_barre (string as_numero)
public subroutine wf_salva_in_listino (decimal adc_prezzo, long al_id_uc, long al_id_variazione)
public function long wf_controlla_esistente (string as_codice, long al_riga)
end prototypes

public subroutine wf_articolo (long al_id_articolo, long al_riga_doc);string ls_codice, ls_tipo_um, ls_confermato,ls_simbolo_um
long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_art_riga, ll_id_cat_cod
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc, ll_id_variazione
decimal ldc_prezzo
datetime ldt_datatime

setnull(ll_null)

ll_riga_trovata=dw_4.find("id_articolo="+string(al_id_articolo), 1, dw_4.rowcount())
if ll_riga_trovata>0 then
	ls_codice=dw_4.getitemstring(ll_riga_trovata, "codice")
	select a.id_articolo, u.id_unita_confezione
	into :ll_id_art_locale, :ll_id_uc
	from dba.articolo a, dba.unita_confezione u
	where a.codice=:ls_codice
	and u.unita_base='S'
	and a.id_articolo=u.id_articolo
	;
	if ll_id_art_locale>0 then //l'articolo esiste già non si deve fare nulla , quasi nulla
		dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
		dw_2.SetItem(al_riga_doc,"id_unita_confezione", ll_id_uc)
		
	else //l'articolo non esiste occorre inserirlo
		dw_6.reset()
		dw_7.reset()
		ll_riga_trovata_uc=dw_5.find("id_articolo="+string(al_id_articolo), 1, dw_5.rowcount())
		if ll_riga_trovata_uc>0 then
			dw_4.rowscopy(ll_riga_trovata, ll_riga_trovata, primary!, dw_6, 1, primary!)
			dw_6.setitem(1, "id_articolo", ll_null)
			select id_cat_codifica into :ll_id_cat_cod from dba.cat_codifica where codice='AUTO';
			dw_6.setitem(1,"id_cat_codifica", ll_id_cat_cod)
			dw_6.setitem(1,"id_sog_comm_variante", ll_null)
			dw_6.setitemstatus(1, 0, Primary!, NewModified!)
			dw_6.trigger event ue_update()
			ll_id_art_locale=dw_6.getitemnumber(1, "id_articolo")
			dw_2.SetItem(al_riga_doc,"id_articolo", ll_id_art_locale)
			ls_simbolo_um=dw_5.getitemstring(ll_riga_trovata_uc, "codice")
			select id_unita_misura into :ll_id_um from dba.unita_misura where simbolo=:ls_simbolo_um;
			if isnull(ll_id_um) or ll_id_um<=0 then messagebox("Attenzione!", "Per importare gli articoli occorre che esista una unità di misura con simbolo='"+ls_simbolo_um +"'!" )
				
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
			
		else
			messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON PRESENTE NEL FILE ART.txt")
		end if
	
		end if
	end if //
	if pos(ls_azienda, "PANNA")>0 then
		select simbolo into :ls_simbolo_um from dba.unita_misura u, unita_confezione uc
		where uc.id_unita_misura=u.id_unita_misura and uc.id_unita_confezione=:ll_id_uc;
		ll_id_variazione=	dw_1.getItemnumber(1, "id_variazione")
		//ora inserisco l'articolo nel llistino del'intestatario del doc //prima verifico che non ci sia già e se il prezzo è confermato
		select prezzo into :ldc_prezzo 
		from dba.prezzo where id_unita_confezione=:ll_id_uc and id_variazione=:ll_id_variazione;
		
		if sqlca.sqlcode<>0 then //il record non esiste
			ldt_datatime=datetime(today(), now())
			if ls_simbolo_um='PZ' then //muove a pezzo altrimenti è peso (o cm ecc ma il prezzo allora è in manifattura)
				ldc_prezzo=dw_2.getitemdecimal(al_riga_doc, "prezzo")
				
				insert into dba.prezzo (id_unita_confezione, id_variazione, prezzo, confermato, ultima_modifica)
				values (:ll_id_uc, :ll_id_variazione, :ldc_prezzo, 'N', :ldt_datatime);
				if sqlca.sqlcode=0 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON inserito in listino!")
				end if
			else
				ldc_prezzo=dw_2.getitemdecimal(al_riga_doc, "prezzo_manifattura")
				insert into dba.prezzo (id_unita_confezione, id_variazione, prezzo_manifattura, confermato, ultima_modifica)
				values (:ll_id_uc, :ll_id_variazione, :ldc_prezzo, 'N',  :ldt_datatime);
				if sqlca.sqlcode=0 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Art. "+ string(al_id_articolo)+" - Riga: "+string(al_riga_doc)+" ERRORE! ARTICOLO NON inserito in listino!")
				end if
			end if
		end if
end if

end subroutine

public subroutine wf_cambia_iva ();long ll_id_tab_iva
INTEGER I

select id_TAB_IVA
into :ll_id_tab_iva
from 
dba.tab_iva
where per_aliquota=22 and per_detrazione=100
;
if ll_id_tab_iva> 0 then
	for i= 1 TO DW_2.ROWCOUNT()
		DW_2.SETITEM(I, "ID_TAB_IVA",ll_id_tab_iva)
		//DW_2.SETITEM(I, "provv_imp_carea_2", 0)
	NEXT
else
	messagebox("Attenzione!", "IVA NON TROVATA!")
END IF
	
end subroutine

public function long wf_imp_sog_com (long al_id_ana);long ll_id_sog, ll_null
string ls_cod_cliente

setnull(ll_null)
//ll_id_sog=dw_9.getitemnumber(1, "id_sog_commerciale")
ls_cod_cliente=dw_9.getitemstring(1, "codice")
select id_sog_commerciale
into :ll_id_sog
from dba.sog_commerciale
where id_anagrafica=:al_id_ana //and tipo='C'
;

if ll_id_sog<=0 or isnull(ll_id_sog) then
	
	dw_9.rowscopy(1, 1, primary!, dw_11, 1, primary!)
	dw_11.setitem(1,"id_sog_commerciale", ll_null)
	dw_11.setitem(1,"id_anagrafica", al_id_ana)
	dw_11.setitem(1,"id_conto", ll_null)
	dw_11.setitemstatus(1, 0, Primary!, NewModified!)
	dw_11.trigger event ue_update()
	ll_id_sog=dw_11.getitemnumber(1, "id_sog_commerciale")
	IF ll_id_sog<=0 OR ISNULL(ll_id_sog) then messagebox("Attenzione!", "Controllare l'anagrafica: forse esiste, ma non è stato inserito il codice cliente!")
end if
return ll_id_sog
end function

public function long wf_imp_anagrafica ();long ll_id_ana, ll_null, ll_new_codice
string ls_rag_soc

setnull(ll_null)
//ll_id_ana=dw_8.getitemnumber(1, "id_anagrafica")
ls_rag_soc=dw_8.getitemstring(1, "rag_soc_1")
select id_anagrafica
into :ll_id_ana
from dba.anagrafica
where rag_soc_1=:ls_rag_soc;
if ll_id_ana>0 then
	dw_10.retrieve(ll_id_ana)
	ll_id_ana=dw_10.getitemnumber(1, "id_anagrafica")
else
	select max(codice)
	into :ll_new_codice
	from dba.anagrafica;
	ll_new_codice++
	//non c'è va inserita: copio la riga nella dw_10
	dw_8.rowscopy(1, 1, primary!, dw_10, 1, primary!)
	dw_10.setitem(1,"id_anagrafica", ll_null)
	dw_10.setitem(1,"codice", ll_new_codice)
	dw_10.setitemstatus(1, 0, Primary!, NewModified!)
	dw_10.trigger event ue_update()
	ll_id_ana=dw_10.getitemnumber(1, "id_anagrafica")
end if
return ll_id_ana
end function

public function string wf_estrai_cod_barre (string as_numero);as_numero=right(as_numero, 5)
return as_numero
end function

public subroutine wf_salva_in_listino (decimal adc_prezzo, long al_id_uc, long al_id_variazione);decimal ldc_prezzo_man, ldc_prezzo_esistente
string ls_tipo, ls_confermato

select tipo into :ls_tipo from dba.unita_misura m, dba.unita_confezione u
where u.id_unita_confezione=:al_id_uc and u.id_unita_misura=m.id_unita_misura
;
if ls_tipo='P' then //è a "peso" quindi "prezzo manifattura"
	select prezzo_manifattura, confermato
	into :ldc_prezzo_esistente, :ls_confermato
	from dba.prezzo
	where id_unita_confezione=:al_id_uc and id_variazione=:al_id_variazione
	;
elseif ls_tipo='N' then //è al pezzo quindi "prezzo"
	select prezzo, confermato
	into :ldc_prezzo_esistente, :ls_confermato
	from dba.prezzo
	where id_unita_confezione=:al_id_uc and id_variazione=:al_id_variazione
	;
else
	messagebox("Attenzione!", "Tipo dell'unità di misura non trovato (nè P nè N!!!)")
	return
end if
if isnull(ls_confermato) or ls_confermato<>'S' then // inserisco quello nuovo nel listino
	if ls_tipo='P' then
		insert into dba.prezzo(id_variazione, id_unita_confezione, prezzo_manifattura, des_1)
		values(:al_id_variazione, :al_id_uc, :adc_prezzo, 'Da importa documenti')
		;
		if sqlca.sqlnrows>0 then
			commit;
		else
			update dba.prezzo set prezzo_manifattura=:adc_prezzo
			where id_variazione=:al_id_variazione and id_unita_confezione=:al_id_uc
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo non aggiornato/inserito!")
			end if
		end if
	else
		insert into dba.prezzo(id_variazione, id_unita_confezione, prezzo, des_1)
		values(:al_id_variazione, :al_id_uc, :adc_prezzo, 'Da importa documenti')
		;
		if sqlca.sqlnrows>0 then
			commit;
		else
			update dba.prezzo set prezzo=:adc_prezzo
			where id_variazione=:al_id_variazione and id_unita_confezione=:al_id_uc
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo non aggiornato/inserito!")
			end if
		end if
	end if
else
	//messagebox("Attenzione!", "Prezzo già confermato!")
end if
end subroutine

public function long wf_controlla_esistente (string as_codice, long al_riga);long ll_id_art, ll_riga_trovata, ll_id_cat_merc
string ls_des, ls_des_breve, ls_nota, ls_cod_cm
integer li_ret, li_num_cod

if as_codice> "  "  then
	if dw_6.rowcount()>0 then 
			ls_des=dw_12.getitemstring(al_riga, "descrizione")
			ls_des_breve=dw_12.getitemstring(al_riga, "des_breve")
		ll_riga_trovata=dw_6.find("codice='"+as_codice+"'", 1, dw_6.rowcount())
		if ll_riga_trovata>0 then
		
			select id_cat_merceologica into :ll_id_cat_merc from dba.cat_merceologica where descrizione=:ls_des_breve;
			if ll_id_cat_merc<=0 or isnull(ll_id_cat_merc) then
				select max(codice) into :ls_cod_cm from dba.cat_merceologica where left(codice, 2)='X_';
				if isnull(ls_cod_cm) then 
					ls_cod_cm="X_000001"
				else
					li_num_cod=integer(right(ls_cod_cm, len(ls_cod_cm) - 2))
					li_num_cod++
					ls_cod_cm=string(li_num_cod)
					li_ret=len(ls_cod_cm)
					ls_cod_cm="X_"+fill("0", 6 - li_ret)+ls_cod_cm
				end if
				insert into dba.cat_merceologica (codice, descrizione, id_azienda)
				values(:ls_cod_cm, :ls_des_breve, 1)
				;
				if sqlca.sqlNrows>0 then
					commit;
					select id_cat_merceologica into :ll_id_cat_merc from dba.cat_merceologica where descrizione=:ls_des_breve;
				else
					rollback;
					messagebox("Attenzione!", "Cat. Merceologica NON salvata!")
				end if
			end if
			ls_des=dw_12.getitemstring(al_riga, "descrizione")
			ls_des_breve=dw_12.getitemstring(al_riga, "des_breve")
			ls_nota=dw_6.getitemstring(ll_riga_trovata, "nota")
			if isnull(ls_nota) then ls_nota=""
			dw_6.setitem(ll_riga_trovata, "nota", ls_nota+"~r~n"+"Des: "+ls_des+" - "+"Des_breve: "+ls_des_breve)
			return 1
		end if
	end if
	
	select id_cat_merceologica into :ll_id_cat_merc from dba.cat_merceologica where descrizione=:ls_des_breve;
	if ll_id_cat_merc<=0 or isnull(ll_id_cat_merc) then
		select max(codice) into :ls_cod_cm from dba.cat_merceologica where left(codice, 2)='X_';
		if isnull(ls_cod_cm) then 
			ls_cod_cm="X_000001"
		else
			li_num_cod=integer(right(ls_cod_cm, len(ls_cod_cm) - 2))
			li_num_cod++
			ls_cod_cm=string(li_num_cod)
			li_ret=len(ls_cod_cm)
			ls_cod_cm="X_"+fill("0", 6 - li_ret)+ls_cod_cm
		end if
		insert into dba.cat_merceologica (codice, descrizione, id_azienda)
		values(:ls_cod_cm, :ls_des_breve, 1)
		;
		if sqlca.sqlNrows>0 then
			commit;
			select id_cat_merceologica into :ll_id_cat_merc from dba.cat_merceologica where descrizione=:ls_des_breve;
		else
			rollback;
			messagebox("Attenzione!", "Cat. Merceologica NON salvata!")
		end if
	end if

	
	select id_articolo into :ll_id_art from dba.articolo where codice=:as_codice;

end if
return ll_id_art
end function

on w_imp_reso_bu.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_carica=create cb_carica
this.dw_3=create dw_3
this.cb_importa=create cb_importa
this.dw_4=create dw_4
this.dw_5=create dw_5
this.cb_reset=create cb_reset
this.dw_8=create dw_8
this.dw_9=create dw_9
this.dw_10=create dw_10
this.dw_11=create dw_11
this.dw_6=create dw_6
this.dw_7=create dw_7
this.cb_1=create cb_1
this.dw_12=create dw_12
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_carica
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_importa
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_5
this.Control[iCurrent+8]=this.cb_reset
this.Control[iCurrent+9]=this.dw_8
this.Control[iCurrent+10]=this.dw_9
this.Control[iCurrent+11]=this.dw_10
this.Control[iCurrent+12]=this.dw_11
this.Control[iCurrent+13]=this.dw_6
this.Control[iCurrent+14]=this.dw_7
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.dw_12
this.Control[iCurrent+17]=this.cb_2
this.Control[iCurrent+18]=this.cb_3
end on

on w_imp_reso_bu.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_carica)
destroy(this.dw_3)
destroy(this.cb_importa)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.cb_reset)
destroy(this.dw_8)
destroy(this.dw_9)
destroy(this.dw_10)
destroy(this.dw_11)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.cb_1)
destroy(this.dw_12)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event open;call super::open;s_list_main ls_list

this.title=string(this.classname())

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_7.settransobject(sqlca)
dw_10.settransobject(sqlca)
dw_11.settransobject(sqlca)
dw_12.settransobject(sqlca)
dw_3.insertrow(1)
dw_6.insertrow(1)


//idw_master.is_list = Message.PowerObjectParm
//Message.Processed=TRUE
//
//is_tipo_documento= idw_master.is_list.s_win_parametri




end event

type st_1 from w_001`st_1 within w_imp_reso_bu
end type

type dw_1 from udw_base within w_imp_reso_bu
boolean visible = false
integer x = 69
integer y = 44
integer width = 3867
integer height = 332
boolean bringtotop = true
boolean enabled = false
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;w_orafo_documento_ordine_cx w_orafo
s_list_main s_list
long ll_id_doc
s_list.s_identifica[1]="id_documento"
s_list.s_modo=modo_modifica
ll_id_doc=dw_1.getitemnumber(1, "id_documento")
if ll_id_doc>0 then
	s_list.l_identifica[1]=ll_id_doc
	openwithparm(w_orafo, s_list)
end if
end event

type dw_2 from udw_figlia within w_imp_reso_bu
boolean visible = false
integer x = 69
integer y = 400
integer width = 3867
integer height = 476
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
end type

type cb_carica from commandbutton within w_imp_reso_bu
integer x = 32
integer y = 972
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

event clicked;integer li_ret, i
string ls_path, ls_file
long ll_null

setnull(ll_null)
	
getfileopenname("Cerca DOCasci_", ls_path, ls_file, "txt", "testo, *.txt", "C:\dati\reso 125")
//if  not(trim(ls_file)="" or isnull(ls_file)) then
//	 tab_1.tabpage_1.dw_prof_documento_gen_ff.setitem(row, "nome_report", ls_path)
//	end if
//end if	 



	li_ret=dw_12.importfile(ls_file, 2, 99999)

	

end event

type dw_3 from udw_base within w_imp_reso_bu
boolean visible = false
integer x = 2551
integer y = 932
integer width = 1390
integer height = 180
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_scegli_prof_documento"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_importa from commandbutton within w_imp_reso_bu
integer x = 416
integer y = 972
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

event clicked;integer i, li_ret, li_num_cod
string ls_des, ls_des_breve, ls_codice, ls_um,ls_cod_cm
long ll_riga_inserita, ll_id_cat_cod, ll_null, ll_id_art, ll_id_uc_base, ll_id_cat_merc

setnull(ll_null)
select id_cat_codifica into :ll_id_cat_cod from dba.cat_codifica where codice='AUTO';
for i= 1 to dw_12.rowcount()
	ll_id_art=0
	ls_codice=dw_12.getitemstring(i, "codice")
	if isnull(ls_codice) then continue
	ll_id_art=wf_controlla_esistente(ls_codice, i)
	if ll_id_art>0 then continue 
	ls_des=dw_12.getitemstring(i, "descrizione")
	if len(ls_des)>80 then ls_des=left(ls_des, 80)
	ls_des_breve=dw_12.getitemstring(i, "des_breve")
	IF len(LS_DES_BREVE)> 40 then LS_DES_BREVE=left(LS_DES_BREVE, 40)
	ls_um=dw_12.getitemstring(i, "um")
	ll_riga_inserita=dw_6.insertrow(0)
	dw_6.setitem(ll_riga_inserita, "codice", ls_codice)
	dw_6.setitem(ll_riga_inserita, "descrizione", ls_des)
	dw_6.setitem(ll_riga_inserita, "des_breve", ls_des_breve)
	
	if ls_des_breve> "  " then
		ll_id_cat_merc=0
		select id_cat_merceologica into :ll_id_cat_merc from dba.cat_merceologica where descrizione=:ls_des_breve;
		if ll_id_cat_merc<=0 or isnull(ll_id_cat_merc) then
			select max(codice) into :ls_cod_cm from dba.cat_merceologica where left(codice, 2)='X_';
			if isnull(ls_cod_cm) then 
				ls_cod_cm="X_000001"
			else
				li_num_cod=integer(right(ls_cod_cm, len(ls_cod_cm) - 2))
				li_num_cod++
				ls_cod_cm=string(li_num_cod)
				li_ret=len(ls_cod_cm)
				ls_cod_cm="X_"+fill("0", 6 - li_ret)+ls_cod_cm
			end if
			insert into dba.cat_merceologica (codice, descrizione, id_azienda)
			values(:ls_cod_cm, :ls_des_breve, 1)
			;
			if sqlca.sqlNrows>0 then
				commit;
				select id_cat_merceologica into :ll_id_cat_merc from dba.cat_merceologica where descrizione=:ls_des_breve;
			else
				rollback;
				messagebox("Attenzione!", "Cat. Merceologica NON salvata!")
			end if
		end if
		dw_6.setitem(ll_riga_inserita,"id_cat_merceologica", ll_id_cat_merc)
	end if
	dw_6.setitem(ll_riga_inserita,"id_cat_codifica", ll_id_cat_cod)
	if ls_um='N' then ll_id_uc_base=2 else ll_id_uc_base=1
	dw_6.setitem(ll_riga_inserita,"id_unita_conf_base", ll_id_uc_base)
	dw_6.setitem(ll_riga_inserita,"id_cat_com_articolo", 8)
	dw_6.setitem(ll_riga_inserita,"id_articolo", ll_null)
	
	dw_6.setitemstatus(ll_riga_inserita, 0, Primary!, NewModified!)
	//end if
	li_ret=dw_6.trigger event ue_update()
	
	
	if li_ret<>1 then
		messagebox("A", "Riga non salvata n. "+string(i))
	else
	end if
	
next

end event

type dw_4 from udw_base within w_imp_reso_bu
boolean visible = false
integer x = 37
integer y = 936
integer width = 1445
integer height = 532
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type dw_5 from udw_base within w_imp_reso_bu
boolean visible = false
integer x = 18
integer y = 1508
integer width = 1403
integer height = 316
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_unita_confezione_2016"
boolean hscrollbar = true
end type

type cb_reset from commandbutton within w_imp_reso_bu
integer x = 3607
integer y = 972
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

event clicked;dw_6.reset()
dw_12.reset()
end event

type dw_8 from udw_base within w_imp_reso_bu
integer x = 2089
integer y = 2152
integer width = 1445
integer height = 276
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_anagrafica_2016"
boolean hscrollbar = true
end type

type dw_9 from udw_base within w_imp_reso_bu
boolean visible = false
integer x = 2089
integer y = 2444
integer width = 1445
integer height = 460
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_sog_comm_2016"
boolean hscrollbar = true
end type

type dw_10 from udw_base within w_imp_reso_bu
boolean visible = false
integer x = 9
integer y = 2564
integer width = 910
integer height = 352
integer taborder = 40
boolean bringtotop = true
string dataobject = "ds_anagrafica_2016"
boolean hscrollbar = true
end type

type dw_11 from udw_base within w_imp_reso_bu
boolean visible = false
integer x = 974
integer y = 2560
integer width = 910
integer height = 352
integer taborder = 40
boolean bringtotop = true
string dataobject = "ds_sog_comm_2016"
boolean hscrollbar = true
end type

type dw_6 from udw_base within w_imp_reso_bu
integer x = 41
integer y = 44
integer width = 3895
integer height = 912
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type dw_7 from udw_base within w_imp_reso_bu
integer x = 2697
integer y = 2244
integer width = 887
integer height = 640
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_unita_confezione_2016"
boolean hscrollbar = true
end type

type cb_1 from commandbutton within w_imp_reso_bu
boolean visible = false
integer x = 3045
integer y = 1628
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;integer i, a
long ll_riga
string ls_dato

for i= 1 to dw_4.rowcount()
	ll_riga=dw_6.insertrow(0)
	for a=1 to 49
		if a>=1 and a<10 then
			ls_dato=dw_4.getitemstring(i, "a_0"+string(a) )
		else
			ls_dato=dw_4.getitemstring(i, "a_"+string(a) )
		end if
		if a=2 then
			dw_6.setitem(i, "codice", ls_dato)
		elseif a=3 then
			dw_6.setitem(i, "id_cat_codifica", long(ls_dato))
		else
			dw_6.object.datawindow.data[ll_riga, a]= ls_dato 
			//dw_6.setitem(i, a, ls_dato)
		end if
		//dw_6.object.datawindow.data[ll_riga, a]= ls_dato 
	next
	
next


//dw_4.rowscopy(1, dw_4.rowcount(), primary!, dw_6,  1, primary!)
end event

type dw_12 from udw_base within w_imp_reso_bu
integer x = 27
integer y = 1072
integer width = 3909
integer height = 944
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_imp_art_bucci"
boolean hscrollbar = true
end type

type cb_2 from commandbutton within w_imp_reso_bu
integer x = 882
integer y = 972
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
string text = "salva"
end type

event clicked;dw_6.trigger event ue_update()
end event

type cb_3 from commandbutton within w_imp_reso_bu
integer x = 1431
integer y = 972
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;long ll_id_art
string ls_codice, ls_des_breve
integer i

for i= 1 to dw_12.rowcount()
	ls_codice=dw_12.getitemstring(i, "codice")
	if isnull(ls_codice) then continue
	ls_des_breve=dw_12.getitemstring(i, "des_breve")
	if len(ls_des_breve)>40 then ls_des_breve=left(ls_des_breve, 40)
	select id_articolo into :ll_id_art from dba.articolo where codice=:ls_codice;
	update cat_merceologica set id_anag_modello= :ll_id_art where descrizione=:ls_des_breve;
next
end event

