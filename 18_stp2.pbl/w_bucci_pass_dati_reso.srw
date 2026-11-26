forward
global type w_bucci_pass_dati_reso from w_semplice_gd
end type
type cb_1 from commandbutton within w_bucci_pass_dati_reso
end type
type dw_2 from udw_base within w_bucci_pass_dati_reso
end type
type dw_3 from udw_figlia within w_bucci_pass_dati_reso
end type
type dw_4 from udw_base within w_bucci_pass_dati_reso
end type
type cb_2 from commandbutton within w_bucci_pass_dati_reso
end type
type dw_5 from udw_base within w_bucci_pass_dati_reso
end type
type cb_3 from commandbutton within w_bucci_pass_dati_reso
end type
end forward

global type w_bucci_pass_dati_reso from w_semplice_gd
integer width = 4850
integer height = 2916
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean clientedge = true
cb_1 cb_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
cb_2 cb_2
dw_5 dw_5
cb_3 cb_3
end type
global w_bucci_pass_dati_reso w_bucci_pass_dati_reso

forward prototypes
public function long wf_articolo (string as_cod_art, string as_cartellino, string as_descrizione)
public function long wf_cartellino (string as_cartellino, long al_id_art)
end prototypes

public function long wf_articolo (string as_cod_art, string as_cartellino, string as_descrizione);long ll_id_art, ll_null, ll_id_cat_merc


setnull(ll_null)

select id_articolo into :ll_id_art  from dba.articolo
where codice=:as_cod_art
;
if ll_id_art>0   then 
	return ll_id_art
else
	//inserisco l'articolo
	dw_5.reset()
	dw_5.insertrow(1)
	dw_5.setitem(1, "id_articolo", ll_null)
	dw_5.setitem(1, "id_cat_codifica", 8)
	dw_5.setitem(1, "codice", as_cod_art)
	dw_5.setitem(1, "id_cat_com_articolo", 8)
	dw_5.setitem(1, "ID_unita_conf_base", 2)
	//descrizione 
	dw_5.setitem(1, "descrizione", as_descrizione)
	if pos(as_cartellino, "AG")>0 then
		dw_5.setitem(1, "coef_calo", 925)
		dw_5.setitem(1, "id_titolo", 4)
	else
		dw_5.setitem(1, "coef_calo", 750)
		dw_5.setitem(1, "id_titolo", 3)
	end if
	//salvo
	dw_5.setitemstatus(1, 0, Primary!, NewModified!)
	dw_5.trigger event ue_update()
	//recupero l'id_articolo per passarlo a wf_cartellino
	ll_id_art=dw_5.getitemnumber(1, "id_articolo")
	
	//cartellino
	select id_cat_merceologica into :ll_id_cat_merc from dba.cat_merceologica where descrizione=:as_cartellino;
	if ll_id_cat_merc>0 then
		dw_5.setitem(1, "id_cat_merceologica", ll_id_cat_merc)
	else
		ll_id_cat_merc=wf_cartellino(as_cartellino, ll_id_art)
		dw_5.setitem(1, "id_cat_merceologica", ll_id_cat_merc)
	end if
	dw_5.trigger event ue_update()	
end if
return ll_id_art



end function

public function long wf_cartellino (string as_cartellino, long al_id_art);long ll_id_cartellino, ll_max
string ls_max_codice

select id_cat_merceologica into :ll_id_cartellino  from dba.cat_merceologica
where descrizione=:as_cartellino
;
if isnull(ll_id_cartellino) or ll_id_cartellino=0 then //lo inserisco
	select max(codice) into :ls_max_codice from dba.cat_merceologica;
	ll_max=long(right(ls_max_codice, 6))
	ls_max_codice=""
	ls_max_codice="X_"+fill("0", 6 - len(string(ll_max+1)))+string(ll_max+1)
	insert into dba.cat_merceologica ("codice", "descrizione", "id_anag_modello")
	values(:ls_max_codice, :as_cartellino, :al_id_art);
	if sqlca.sqlNrows>0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Cartellino NON inserito")
		return 0
	end if
	select id_cat_merceologica into :ll_id_cartellino  from dba.cat_merceologica
	where codice=:ls_max_codice
	;
end if

return ll_id_cartellino
end function

on w_bucci_pass_dati_reso.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_2=create cb_2
this.dw_5=create dw_5
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.dw_5
this.Control[iCurrent+7]=this.cb_3
end on

on w_bucci_pass_dati_reso.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.dw_5)
destroy(this.cb_3)
end on

event resize;//
end event

event open;call super::open;dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_4.insertrow(1)
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_bucci_pass_dati_reso
integer x = 4105
integer y = 1192
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_bucci_pass_dati_reso
integer x = 4425
integer y = 1280
end type

type cb_primo from w_semplice_gd`cb_primo within w_bucci_pass_dati_reso
integer x = 4425
integer y = 1428
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_bucci_pass_dati_reso
integer x = 4425
integer y = 1548
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_bucci_pass_dati_reso
integer x = 4425
integer y = 1668
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_bucci_pass_dati_reso
integer x = 4425
integer y = 1788
end type

type dw_1 from w_semplice_gd`dw_1 within w_bucci_pass_dati_reso
integer width = 4704
string dataobject = "d_imp_reso_bucci_movimenti"
end type

type cb_inserisci from w_semplice_gd`cb_inserisci within w_bucci_pass_dati_reso
integer x = 4425
end type

type cb_salva from w_semplice_gd`cb_salva within w_bucci_pass_dati_reso
integer x = 4421
integer y = 1096
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_bucci_pass_dati_reso
integer x = 4425
integer y = 1908
end type

type cb_annulla from w_semplice_gd`cb_annulla within w_bucci_pass_dati_reso
integer x = 4425
integer y = 2056
end type

type cb_ok from w_semplice_gd`cb_ok within w_bucci_pass_dati_reso
integer x = 4425
integer y = 2204
end type

type cb_1 from commandbutton within w_bucci_pass_dati_reso
integer x = 82
integer y = 992
integer width = 402
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "1"
end type

event clicked;//string ls_path, ls_file
//
//getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\excel")
//if  not(trim(ls_file)="" or isnull(ls_file)) then
//	dw_1.importfile(DBase3!,ls_file)
//end if	 

string ls_path, ls_file

getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_1.importfile(text!,ls_file, 2, 100000)
end if	 

end event

type dw_2 from udw_base within w_bucci_pass_dati_reso
integer x = 46
integer y = 1812
integer width = 3867
integer height = 420
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

type dw_3 from udw_figlia within w_bucci_pass_dati_reso
integer x = 46
integer y = 2248
integer width = 3867
integer height = 472
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
end type

type dw_4 from udw_base within w_bucci_pass_dati_reso
integer x = 2546
integer y = 1012
integer width = 1390
integer height = 196
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_scegli_prof_documento"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_2 from commandbutton within w_bucci_pass_dati_reso
integer x = 544
integer y = 988
integer width = 402
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Reso"
end type

event clicked;long ll_id_prof, ll_id_mag, ll_id_reg_mod, ll_id_locazione, ll_id_causale, ll_id_esercizio, ll_id_reg
date ldt_data_odierna, ldt_data_doc
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
string ls_tipo_registro, ls_numero, ls_des, ls_um, ls_cod_art, ls_cartellino
long ll_null, ll_righe, ll_id_art, ll_id_doc, ll_id_sog_intestatario,  ll_id_uc,ll_riga_inserita
integer i, li_ret
decimal ldc_grammi, ldc_qta
long ll_id_locazione_2, ll_id_mag_2, ll_id_cartellino
//w_orafo_documento_ordine_cx w_orafo
//s_list_main s_list

setnull(ll_null)
//dw_3.accepttext()

ll_id_sog_intestatario=dw_4.getitemnumber(1, "id_sog_commerciale")
ll_id_prof=dw_4.getitemnumber(1, "id_profilo")
if ll_id_prof>0 and ll_id_sog_intestatario>0  then

	//con il profilo trovo magazzino, locazione, causale e registro (modello)
	select id_magazzino_1_prop, id_mod_registro_prop, id_locazione_1_prop,  id_caus_magazzino_prop, id_locazione_2_prop,  id_magazzino_2_prop
	into :ll_id_mag, :ll_id_reg_mod, :ll_id_locazione, :ll_id_causale, :ll_id_locazione_2, :ll_id_mag
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof
	;
	//ora trovo il registro attuale (modello registro riportato alla data odierna)
	ldt_data_odierna=date(today())
	select id_esercizio
	into :ll_id_esercizio
	from dba.esercizio
	where data_inizio<= :ldt_data_odierna
	and data_fine>=:ldt_data_odierna
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
	//recupero i dati per inserire il documento
	dw_2.insertrow(1)
	dw_2.SetItem(1, "id_sog_commerciale", ll_id_sog_intestatario)
	dw_2.SetItem(1, "id_sog_commerciale_fattura", ll_id_sog_intestatario)
	dw_2.SetItem(1, "id_registro", ll_id_reg)
	dw_2.SetItem(1, "id_prof_documento", ll_id_prof)
	dw_2.SetItem(1, "num_progressivo", ls_trova_prog.sl_num_progressivo)
	dw_2.SetItem(1, "num_documento", string(ls_trova_prog.sl_num_progressivo))
	dw_2.SetItem(1, "data_registrazione", ldt_data_odierna)
	dw_2.SetItem(1, "data_documento", ldt_data_odierna)
	dw_2.SetItem(1, "id_caus_magazzino", ll_id_causale)
	dw_2.SetItem(1, "id_locazione_1", ll_id_locazione)
	dw_2.SetItem(1, "id_locazione_2", ll_id_locazione_2)
	dw_2.SetItem(1, "id_magazzino", ll_id_mag)
	dw_2.SetItem(1, "origine", "RESO doc. importato il "+string(datetime(today(),now()) ,"dd/mm/yy hh:mm:ss"))
	dw_2.SetItem(1, "id_documento", ll_null)
	dw_2.SetItem(1, "id_destinazione", ll_null)
	dw_2.SetItem(1, "id_valuta", 3)
	//08/03/2021 aggiungo annullamento condizine pagamento
	dw_2.SetItem(1, "id_con_pagamento", ll_null)
	dw_2.setitemstatus(1, 0, Primary!, NewModified!)
	li_ret=dw_2.trigger event ue_update()
	ll_id_doc=dw_2.getitemnumber(1, "id_documento")
	if ll_id_doc>0 then
		ll_righe=dw_1.rowcount()
		for i= 1 to ll_righe
			ll_riga_inserita=dw_3.insertrow(0)
				dw_3.SetItem(ll_riga_inserita, "id_valuta", 3)
			dw_3.SetItem(ll_riga_inserita, "num_riga", ll_riga_inserita)
			dw_3.SetItem(ll_riga_inserita, "id_documento", ll_id_doc)
			dw_3.SetItem(ll_riga_inserita, "id_riga_documento", ll_null)
			//dw_2.SetItem(i, "id_riga_doc_provenienza", ll_null)  //commento perché la uso 20210219
			dw_3.SetItem(ll_riga_inserita, "id_caus_magazzino", ll_id_causale)
			dw_3.SetItem(ll_riga_inserita, "id_locazione_1", ll_id_locazione)
			dw_3.SetItem(ll_riga_inserita, "id_locazione_2", ll_id_locazione_2)
			dw_3.SetItem(ll_riga_inserita, "id_des_articolo", ll_null)
			//dw_3.SetItem(i, "id_listino", ll_id_variazione)
			dw_3.SetItem(ll_riga_inserita, "qta_evasa", 0)
			dw_3.SetItem(ll_riga_inserita, "peso_netto_evaso", 0)
			dw_3.SetItem(ll_riga_inserita, "qta_EVASA_UN_base", 0)
			//recupero i dati
			ls_des=dw_1.getitemstring(i, "descrizione")
			ldt_data_doc=dw_1.getitemdate(i, "data_doc")
			ls_numero=dw_1.getitemstring(i, "num_doc")
			dw_3.SetItem(ll_riga_inserita, "descrizione", ls_des+" - Rif. Doc. n. "+ls_numero+" del "+ string(ldt_data_doc, "DD/MM/YYYY")) //+ numero e data doc padre
			ls_um=dw_1.getitemstring(i, "um")
			if upper(ls_um)="N" then
				ldc_qta=dw_1.getitemdecimal(i, "qta")
				ldc_grammi=dw_1.getitemdecimal(i, "gr")
			else
				ldc_grammi=dw_1.getitemdecimal(i, "qta")
				ldc_qta=1
			end if
			dw_3.SetItem(ll_riga_inserita, "quantita", ldc_qta)
			dw_3.SetItem(ll_riga_inserita, "peso_netto", ldc_grammi)
			ls_cod_art=dw_1.getitemstring(i, "codice")
			ls_cartellino=dw_1.getitemstring(i, "cartellino")
			if pos(ls_cartellino, "AG")>0 then
				dw_3.setitem(ll_riga_inserita, "coef_calo", 925)
			else
				dw_3.setitem(ll_riga_inserita, "coef_calo", 750)
			end if
			ll_id_art=wf_articolo(ls_cod_art, ls_cartellino,ls_des )
			ll_id_cartellino=wf_cartellino(ls_cartellino,ll_id_art)
			dw_3.setitem(ll_riga_inserita, "id_articolo", ll_id_art)
			if ll_id_cartellino>0 then 	dw_3.setitem(ll_riga_inserita, "id_gruppo_agenti_2", ll_id_cartellino)					
			dw_3.setitemstatus(i, 0, Primary!, NewModified!)			
		next
		li_ret=dw_3.trigger event ue_update()
	else
		messagebox("Attenzione!", "Doc NON salvato!!")
	end if
else
		messagebox("Attenzione!", "Inserire il profilo o l'intestatario documento!!")
end if
	
	
	

end event

type dw_5 from udw_base within w_bucci_pass_dati_reso
integer x = 41
integer y = 1156
integer width = 1445
integer height = 532
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_articolo_2016"
boolean hscrollbar = true
end type

type cb_3 from commandbutton within w_bucci_pass_dati_reso
integer x = 1024
integer y = 988
integer width = 402
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "CARICO"
end type

event clicked;long ll_id_prof, ll_id_mag, ll_id_reg_mod, ll_id_locazione, ll_id_causale, ll_id_esercizio, ll_id_reg
date ldt_data_odierna, ldt_data_doc
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
string ls_tipo_registro, ls_numero, ls_des, ls_um, ls_cod_art, ls_cartellino, ls_numero_old
long ll_null, ll_righe, ll_id_art, ll_id_doc, ll_id_sog_intestatario,  ll_id_uc,ll_riga_inserita
integer i, li_ret, a
decimal ldc_grammi, ldc_qta
long ll_id_locazione_2, ll_id_mag_2, ll_id_cartellino
//w_orafo_documento_ordine_cx w_orafo
//s_list_main s_list

setnull(ll_null)
//dw_3.accepttext()

ll_id_sog_intestatario=dw_4.getitemnumber(1, "id_sog_commerciale")
ll_id_prof=dw_4.getitemnumber(1, "id_profilo")
if ll_id_prof>0 and ll_id_sog_intestatario>0  then

	//con il profilo trovo magazzino, locazione, causale e registro (modello)
	select id_magazzino_1_prop, id_mod_registro_prop, id_locazione_1_prop,  id_caus_magazzino_prop, id_locazione_2_prop,  id_magazzino_2_prop
	into :ll_id_mag, :ll_id_reg_mod, :ll_id_locazione, :ll_id_causale, :ll_id_locazione_2, :ll_id_mag
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof
	;
	//ora trovo il registro attuale (modello registro riportato alla data odierna)
	ldt_data_odierna=date(today())
	select id_esercizio
	into :ll_id_esercizio
	from dba.esercizio
	where data_inizio<= :ldt_data_odierna
	and data_fine>=:ldt_data_odierna
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
	
	//recupero i dati per inserire il documento
	for i=1 to dw_1.rowcount()
		ls_numero=dw_1.getitemstring(i, "num_doc")
		if ls_numero_old<>ls_numero then
			ls_numero_old=ls_numero
			ldt_data_doc=dw_1.getitemdate(i, "data_doc")
			dw_2.reset()
			dw_3.reset()
			dw_2.insertrow(1)
			ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_reg, 0, ls_tipo_registro)
			dw_2.SetItem(1, "id_sog_commerciale", ll_id_sog_intestatario)
			dw_2.SetItem(1, "id_sog_commerciale_fattura", ll_id_sog_intestatario)
			dw_2.SetItem(1, "id_registro", ll_id_reg)
			dw_2.SetItem(1, "id_prof_documento", ll_id_prof)
			dw_2.SetItem(1, "num_progressivo", ls_trova_prog.sl_num_progressivo)
			dw_2.SetItem(1, "num_documento", ls_numero)
			dw_2.SetItem(1, "data_registrazione", ldt_data_odierna)
			dw_2.SetItem(1, "data_documento", ldt_data_doc)
			dw_2.SetItem(1, "id_caus_magazzino", ll_id_causale)
			dw_2.SetItem(1, "id_locazione_1", ll_id_locazione)
			dw_2.SetItem(1, "id_locazione_2", ll_id_locazione_2)
			dw_2.SetItem(1, "id_magazzino", ll_id_mag)
			dw_2.SetItem(1, "origine", "RESO doc. importato il "+string(datetime(today(),now()) ,"dd/mm/yy hh:mm:ss"))
			dw_2.SetItem(1, "id_documento", ll_null)
			dw_2.SetItem(1, "id_destinazione", ll_null)
			dw_2.SetItem(1, "id_valuta", 3)
			//08/03/2021 aggiungo annullamento condizine pagamento
			dw_2.SetItem(1, "id_con_pagamento", ll_null)
			dw_2.setitemstatus(1, 0, Primary!, NewModified!)
			li_ret=dw_2.trigger event ue_update()
			ll_id_doc=dw_2.getitemnumber(1, "id_documento")
		end if
			//if ll_id_doc>0 then
			
			//ll_righe=dw_1.rowcount()
//			for i= 1 to ll_righe
				ll_riga_inserita=dw_3.insertrow(0)
				dw_3.SetItem(ll_riga_inserita, "id_valuta", 3)
				dw_3.SetItem(ll_riga_inserita, "num_riga", ll_riga_inserita)
				dw_3.SetItem(ll_riga_inserita, "id_documento", ll_id_doc)
				dw_3.SetItem(ll_riga_inserita, "id_riga_documento", ll_null)
				//dw_2.SetItem(i, "id_riga_doc_provenienza", ll_null)  //commento perché la uso 20210219
				dw_3.SetItem(ll_riga_inserita, "id_caus_magazzino", ll_id_causale)
				dw_3.SetItem(ll_riga_inserita, "id_locazione_1", ll_id_locazione)
				dw_3.SetItem(ll_riga_inserita, "id_locazione_2", ll_id_locazione_2)
				dw_3.SetItem(ll_riga_inserita, "id_des_articolo", ll_null)
				//dw_3.SetItem(i, "id_listino", ll_id_variazione)
				dw_3.SetItem(ll_riga_inserita, "qta_evasa", 0)
				dw_3.SetItem(ll_riga_inserita, "peso_netto_evaso", 0)
				dw_3.SetItem(ll_riga_inserita, "qta_EVASA_UN_base", 0)
				//recupero i dati
				ls_des=dw_1.getitemstring(i, "descrizione")
//				ldt_data_doc=dw_1.getitemdate(i, "data_doc")
//				ls_numero=dw_1.getitemstring(i, "num_doc")
				dw_3.SetItem(ll_riga_inserita, "descrizione", ls_des) //+" - Rif. Doc. n. "+ls_numero+" del "+ string(ldt_data_doc, "DD/MM/YYYY")) //+ numero e data doc padre
				ls_um=dw_1.getitemstring(i, "um")
				if upper(ls_um)="N" then
					ldc_qta=dw_1.getitemdecimal(i, "qta")
					ldc_grammi=dw_1.getitemdecimal(i, "gr")
				else
					ldc_grammi=dw_1.getitemdecimal(i, "qta")
					ldc_qta=1
				end if
				dw_3.SetItem(ll_riga_inserita, "quantita", ldc_qta)
				dw_3.SetItem(ll_riga_inserita, "peso_netto", ldc_grammi)
				ls_cod_art=dw_1.getitemstring(i, "codice")
				ls_cartellino=dw_1.getitemstring(i, "cartellino")
				if pos(ls_cartellino, "AG")>0 then
					dw_3.setitem(ll_riga_inserita, "coef_calo", 925)
				else
					dw_3.setitem(ll_riga_inserita, "coef_calo", 750)
				end if
				ll_id_art=wf_articolo(ls_cod_art, ls_cartellino,ls_des )
				ll_id_cartellino=wf_cartellino(ls_cartellino,ll_id_art)
				dw_3.setitem(ll_riga_inserita, "id_articolo", ll_id_art)
				if ll_id_cartellino>0 then 	dw_3.setitem(ll_riga_inserita, "id_gruppo_agenti_2", ll_id_cartellino)					
				dw_3.setitemstatus(i, 0, Primary!, NewModified!)		
				
				li_ret=dw_3.trigger event ue_update()
			next
			
		destroy uo_proponi_num_progressivo
		
//		else
//			messagebox("Attenzione!", "Doc NON salvato!!")
//		end if
	//next
else
		messagebox("Attenzione!", "Inserire il profilo o l'intestatario documento!!")
end if
	
	
	

end event

