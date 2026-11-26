forward
global type w_tracciamento_produzione from w_base
end type
type cb_2 from commandbutton within w_tracciamento_produzione
end type
type cb_1 from commandbutton within w_tracciamento_produzione
end type
type cb_6 from commandbutton within w_tracciamento_produzione
end type
type cb_5 from commandbutton within w_tracciamento_produzione
end type
type cb_4 from commandbutton within w_tracciamento_produzione
end type
type dw_4 from udw_000 within w_tracciamento_produzione
end type
type cb_3 from commandbutton within w_tracciamento_produzione
end type
type cb_stampa from commandbutton within w_tracciamento_produzione
end type
type sle_path from singlelineedit within w_tracciamento_produzione
end type
type dw_lista_foto from udw_001 within w_tracciamento_produzione
end type
type cb_vai from commandbutton within w_tracciamento_produzione
end type
type dw_3 from udw_001 within w_tracciamento_produzione
end type
type dw_2 from udw_001 within w_tracciamento_produzione
end type
type dw_1 from udw_001 within w_tracciamento_produzione
end type
end forward

global type w_tracciamento_produzione from w_base
integer width = 5353
integer height = 1784
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
cb_2 cb_2
cb_1 cb_1
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_4 dw_4
cb_3 cb_3
cb_stampa cb_stampa
sle_path sle_path
dw_lista_foto dw_lista_foto
cb_vai cb_vai
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
global w_tracciamento_produzione w_tracciamento_produzione

forward prototypes
public subroutine wf_salva_file (string as_file)
public function string wf_carica_doc_e_righe (string as_nome_file)
public function string uf_extract_exe_name (string url)
end prototypes

public subroutine wf_salva_file (string as_file);insert into dba.tracc_file_processato (nome_file_processato, esito)
values(:as_file, 'S');
if sqlca.sqlcode=0 then
	commit;
else
	rollback;
	messagebox("Attenzione!", "IL file "+as_file+" NON è stato Salvato!")
end if
end subroutine

public function string wf_carica_doc_e_righe (string as_nome_file);integer li_ret, i, li_righe, li_anno, li_pos
long     ll_null,ll_riga_doc, ll_id_doc, ll_id_galvanica,ll_id_doc_riga_da_cancellare, ll_riga_erase, ll_parametro[], ll_id_galv,ll_id_operatore
string    ls_num_doc, ls_tipo_registro,ls_nota="", ls_num_bol, ls_des,ls_des2, ls_des_bollettina, ls_tipo,ls_profilo
string ls_data_doc, ls_um, ls_num_per_id, ls_operatore, ls_ret
date  ldt_data_doc, ldt_data_inserimento
long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_id_riga_provenienza,ll_riga_doc_inserito,ll_new_riga_doc,ll_id_art, ll_righe
long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre,ll_riga_trovata,ll_id_uc, ll_id_riga_bollettina,ll_id_doc_bollettina
setnull(ll_null)
decimal ldc_prezzo, ldc_legato, ldc_tot_riga,ldc_prezzo_metallo, ls_tot_peso, ldc_coef_calo
long ll_id_locazione, ll_id_magazzino,ll_id_causale, ll_id_titolo, ll_id_riga_bol ,ll_id_var, ll_id_listino, ll_riga_sald, ll_righe_sald
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
datetime ldt_data_ora
time lt_time

ls_ret=""
ls_profilo=dw_3.getitemstring(1, "dati_vari")
ll_id_prof=integer(right(ls_profilo, len(ls_profilo) - 1))
if ll_id_prof>0 then
//preparo il documento
	ll_riga_doc=dw_1.insertrow(1)
	ls_data_doc=dw_3.getitemstring(dw_3.rowcount(), "dati_vari")
	if Len(ls_data_doc) >= 15 then
		 ldt_data_doc = Date(Right(ls_data_doc, 10))
		 li_pos=pos(ls_data_doc, "-")
		 lt_time = Time(Mid(ls_data_doc,li_pos - 6, 5))
		 ldt_data_ora = DateTime(ldt_data_doc, lt_time)
	else
		 // Gestione errore: la stringa non ha abbastanza caratteri
		 MessageBox("Errore", "Formato 'dati_vari' non valido.")
	end if
//	ldt_data_doc=date(right(ls_data_doc, 10))
//	lt_time=time(mid(ls_data_doc, 10, 5))
//	ldt_data_ora=datetime(ldt_data_doc, lt_time)
	ls_operatore=left(ls_data_doc, 4)
	ll_id_operatore=long(right(ls_operatore, 3))
	ll_id_sog=1897 //silverdreams cliente
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
	dw_1.SetItem(1, "id_valuta", 3)
	//memorizzo opertore 20250701
	dw_1.SetItem(1, "imp_avanzo_acconto", ll_id_operatore)  //20250715: imp_avanzo_acconto nella bollettina segna l'anticipo del cliente/ordine, qui invece memorizza l'operatore
	
	dw_1.setitem(ll_riga_doc, "id_sog_commerciale", ll_id_sog)
	dw_1.setitem(ll_riga_doc, "id_sog_commerciale_fattura", ll_id_sog)
	dw_1.setitem(ll_riga_doc, "data_registrazione", ldt_data_doc)
	dw_1.setitem(ll_riga_doc, "data_ora_creazione", ldt_data_ora)

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
	//20250716 tampono per ora, poi si vede meglio...
	if isnull(ll_id_registro) or ll_id_registro=0 then ll_id_registro=3311
	//20250716 fine		
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
	
	ls_nota="Bol. in questo doc: "
	select id_listino into :ll_id_listino from dba.sog_commerciale where id_sog_commerciale=:ll_id_sog;
	select id_variazione into :ll_id_var from dba.variazione  where id_listino=:ll_id_listino and data_inizio<= :ldt_data_doc and data_fine>=:ldt_data_doc ;
	
	dw_1.setitem(ll_riga_doc, "note_intestazione", ls_nota)
	
	dw_1.setitemstatus(ll_riga_doc, 0, primary!, newmodified!)
	li_ret=dw_1.trigger event ue_update()  //salvo la testa
	//fine inserimento testa
	ll_id_doc_inserito=dw_1.getitemnumber(ll_riga_doc, "id_documento")
else
	
end if
	
//completo e salvo le righe
for i=2 to dw_3.rowcount() - 1  //carico le bollettine
	ls_num_bol=dw_3.getitemstring(i, "dati_vari")
	
	ls_num_per_id="%"+ls_num_bol
	select first( r.id_riga_documento), r.id_documento	into :ll_riga_madre, :ll_id_doc_bollettina
	from dba.documento d, dba.riga_documento r
	where r.id_documento=d.id_documento 
	and d.num_documento like  :ls_num_per_id  and r.num_riga=1 
	order by r.id_riga_documento
	;
	
	ll_righe=dw_2.retrieve(ll_id_doc_bollettina)
	if ll_righe>0 then				
		ll_riga_trovata=dw_2.find("id_documento="+string(ll_id_doc_bollettina), 1, 9999999, primary!)
		dw_2.setitem(ll_riga_trovata, "id_documento", ll_id_doc_inserito)
		dw_2.setitem(ll_riga_trovata, "num_riga", ll_riga_trovata)
		//20221018 inserisco per le stampe
		dw_2.setitem(ll_riga_trovata, "provv_imp_subage_2", ll_riga_madre)  //questo è il legame con la bollettina (non posso usare id_riga_doc_provenienza altrimenti lo segna evaso...)
		dw_2.setitem(ll_riga_trovata, "id_riga_documento", ll_null)
		//fine
		//20221027 aggiungo da wf_importa
		dw_2.SetItem(ll_riga_trovata, "id_caus_magazzino", ll_id_causale)
		dw_2.SetItem(ll_riga_trovata, "id_locazione_1", ll_id_locazione)
		//20221027 fine
		//20221212 sAMY DICE CHE il titolo deve essere sempre = 925 se è argento e se il fornitore è ???? me li deve dare
		ll_id_art=dw_2.getitemnumber(ll_riga_trovata, "id_articolo")
		select id_titolo into :ll_id_titolo from dba.articolo where id_articolo=:ll_id_art;
		if ll_id_titolo=4 then
			//20231205 il coef_calodeve essere sempre = al titolo se ag
			dw_2.SetItem(ll_riga_trovata, "coef_calo", 925)
		end if
		ldc_prezzo_metallo=dw_2.getitemdecimal(ll_riga_trovata, "prezzo_metallo")
		//20221212 fine
		if ls_um="P" then
			dw_2.setitem(ll_riga_trovata, "prezzo_manifattura", ldc_prezzo)
		else
			dw_2.setitem(ll_riga_trovata, "prezzo_complessivo", ldc_prezzo)
		end if
	
		//devo calcolare anche il totale riga ...
		dw_2.setitem(ll_riga_trovata, "prezzo_metallo", ldc_prezzo_metallo)
		ldc_tot_riga=dw_2.getitemdecimal(ll_riga_trovata, "tot_riga_val_az")
		ldc_legato=dw_2.getitemdecimal(ll_riga_trovata, "peso_netto")
		if isnull(ldc_legato) or ldc_legato<0 then ldc_legato=0  //controllo anche che il legato sia >=0 20220728
		ls_tot_peso+=ldc_legato
		ldc_tot_riga+=ldc_prezzo*ldc_legato
		if isnull(ldc_tot_riga) then ldc_tot_riga=0
		dw_2.setitem(ll_riga_trovata, "peso_netto", ldc_legato)
		//20250401 Pare che non ricalcoli bene il calo e il fino delle righe....
		ldc_coef_calo=dw_2.getitemdecimal(ll_riga_trovata, "coef_calo")
		select id_titolo into :ll_id_titolo from dba.articolo where id_articolo= :ll_id_art;
		dw_2.setitem(ll_riga_trovata, "fino", ldc_legato*ll_id_titolo/1000)
		dw_2.setitem(ll_riga_trovata, "calo", ldc_legato*(ldc_coef_calo - ll_id_titolo) /1000)
		//20250401 fine
		dw_2.setitem(ll_riga_trovata, "tot_riga_val_az", ldc_tot_riga)  //la valuta è sempre euro
		dw_2.setitem(ll_riga_trovata, "tot_riga_val_doc", ldc_tot_riga)
		dw_2.setitem(ll_riga_trovata, "tot_riga_val_riga", ldc_tot_riga)
		//20220922 azzero eventuali derivazioni della bollettina
		dw_2.setitem(ll_riga_trovata, "peso_netto_evaso", 0)
		dw_2.setitem(ll_riga_trovata, "qta_evasa", 0)
		//20221107 aggiungo importante: evasa un base
		dw_2.setitem(ll_riga_trovata, "qta_evasa_un_base", 0)
		//20220922 fine
		//20220929 aggiusto i fattori di conversione altrimenti nulli
		dw_2.setitem(ll_riga_trovata, "fat_con_globale", 1)
		dw_2.setitem(ll_riga_trovata, "fat_con_unita_base", 1)

	dw_2.setitem(ll_riga_trovata, "prezzo_metallo", 0) 
		ls_des=dw_2.getitemstring(ll_riga_trovata, "descrizione")
		ls_des_bollettina=ls_des
		if pos(ls_des, "BOL:")<=0 then ls_des+= " - BOL: "+ls_num_bol		
		dw_2.setitem(ll_riga_trovata, "descrizione", ls_des)
		dw_2.setitemstatus(ll_riga_trovata, 0, primary!, newmodified!)
		//salvo la riga
		li_ret=dw_2.trigger event ue_update()  //20220725
		if li_ret<>1 then
			//messagebox("Attenzione!", "La bollettina "+ls_num_bol+" NONè stata salvata!")
			ls_ret="-"+ls_num_bol  //20250716 salvo in tabella apostia fallimenti
			 insert into dba.tracc_bol_non_passate (nome_file_processato, bol_non_passata)
				 values(:as_nome_file,  :ls_num_bol);
				 if sqlca.sqlcode=0 then
					commit;
				else
					rollback;
					//messagebox("Attenzione!", "La bollettina "+ls_num_bol+" NONè stata salvata!")
				end if
		end if
	else
		messagebox("Attenzione!", "La bollettina "+ls_num_bol+" NON esiste!!! Molto strano-...!")
	end if

next
return ls_ret

end function

public function string uf_extract_exe_name (string url);//Routine intelligentissima ma utile che dato un path con nome di applicazione in fondo terminale ne estrae il nome
//privato del .exe
//es: uf_extract_exe_name("c:\mammiferi\bovini\camilla.exe") ritorna "camilla"
long ll_last_slash, ll_pos

ll_last_slash = 1
ll_pos=1
DO
 	ll_pos = Pos(url,"\",ll_pos+1)
	if ll_pos<>0 then
		ll_last_slash = ll_pos
	end if
	
LOOP UNTIL ll_pos=0
// Come direbbe Giuliani: "(Fault) Tollerance: Zero!"
return mid(url,ll_last_slash+1, len(url) - ll_last_slash - 4)
end function

on w_tracciamento_produzione.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_4=create dw_4
this.cb_3=create cb_3
this.cb_stampa=create cb_stampa
this.sle_path=create sle_path
this.dw_lista_foto=create dw_lista_foto
this.cb_vai=create cb_vai
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_6
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.cb_4
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.cb_stampa
this.Control[iCurrent+9]=this.sle_path
this.Control[iCurrent+10]=this.dw_lista_foto
this.Control[iCurrent+11]=this.cb_vai
this.Control[iCurrent+12]=this.dw_3
this.Control[iCurrent+13]=this.dw_2
this.Control[iCurrent+14]=this.dw_1
end on

on w_tracciamento_produzione.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_4)
destroy(this.cb_3)
destroy(this.cb_stampa)
destroy(this.sle_path)
destroy(this.dw_lista_foto)
destroy(this.cb_vai)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;call super::open;string ls_minuti, ls_file_ini, ls_path, ls_apri_tracciamento
integer li_minuti

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_4.settransobject(sqlca)


//ls_path=""
//GetModuleFileNameA(0, ls_path, 256) 
//ls_file_ini ="C:\nita\"+uf_extract_exe_name(ls_path)+".ini"
//ls_apri_tracciamento = ProfileString (ls_file_ini , "TRACCIAMENTO", "APRI", "Error!" ) 
//if ls_apri_tracciamento="S" then
//	li_minuti=5 //message.doubleparm
//	if li_minuti>0 then
//		timer(li_minuti, this)
//	end if
//end if
end event

event timer;call super::timer;
cb_vai.trigger event clicked()
end event

type cb_2 from commandbutton within w_tracciamento_produzione
integer x = 1175
integer y = 124
integer width = 549
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Errori"
end type

event clicked;open(w_tracc_bol_non_passata)
end event

type cb_1 from commandbutton within w_tracciamento_produzione
boolean visible = false
integer x = 439
integer y = 608
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;string ls_codiceOriginale, ls_codiceBarre

//qui vado su profili e prendo solo quelli che mi interessano, poi vado su operatori e stampo i cod a barre degli operatori

//// Inserisci qui il testo da convertire in barcode
//
//ls_codiceOriginale = dw_4.getitemstring(
//
//// Routine base: per font Code 128 B (supporta lettere maiuscole e minuscole, numeri e simboli)
//ls_codiceBarre = "~" + ls_codiceOriginale + "!"  // I font Code128 a volte richiedono caratteri speciali per delimitare l'inizio/fine
//
//// Imposta il testo su un controllo StaticText con font Code128
//st_barcode.Text = ls_codiceBarre
//st_barcode.Font.Name = "Code 128"
//st_barcode.Font.Size = 36
////
end event

type cb_6 from commandbutton within w_tracciamento_produzione
integer x = 1170
integer y = 244
integer width = 549
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Files Processati"
end type

event clicked;open(w_files_processati_gd)
end event

type cb_5 from commandbutton within w_tracciamento_produzione
integer x = 1243
integer y = 408
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OPERATORI"
end type

event clicked;open(w_operatore)
end event

type cb_4 from commandbutton within w_tracciamento_produzione
boolean visible = false
integer x = 672
integer y = 504
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "ST. CODE"
end type

event clicked;dw_4.print(true,true)
end event

type dw_4 from udw_000 within w_tracciamento_produzione
boolean visible = false
integer x = 101
integer y = 60
integer width = 1001
integer taborder = 40
string dataobject = "d_code128"
end type

type cb_3 from commandbutton within w_tracciamento_produzione
boolean visible = false
integer x = 96
integer y = 504
integer width = 425
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Inserisci code"
end type

event clicked;// Assicurati che il font "Code 128" sia installato nel sistema
dw_4.insertrow(1)

end event

type cb_stampa from commandbutton within w_tracciamento_produzione
integer x = 3625
integer y = 388
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Stampa"
end type

event clicked;open(w_traccia_p1_st)
end event

type sle_path from singlelineedit within w_tracciamento_produzione
integer x = 1829
integer width = 1029
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "\\server2021\versione1\txt\"
borderstyle borderstyle = stylelowered!
end type

type dw_lista_foto from udw_001 within w_tracciamento_produzione
integer x = 4064
integer y = 40
integer width = 1175
integer height = 1576
integer taborder = 30
boolean bringtotop = true
string title = "Lista Foto possibili"
string dataobject = "d_lista_foto_bilancia"
boolean vscrollbar = true
end type

event doubleclicked;string ls_path
if row>0 then
	ls_path=dw_lista_foto.getitemstring(row, "nome_file")
	close(w_mostra_foto)
	openwithparm(w_mostra_foto, ls_path)
	w_mostra_foto.width=3840
	w_mostra_foto.height=2160
end if
end event

type cb_vai from commandbutton within w_tracciamento_produzione
integer x = 3634
integer y = 60
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica"
end type

event clicked;string ls_path, ls_max_file, ls_file_candidato, ls_test,ls_ret
integer li_lunghezza_path
long ll_temp, li_riga_inserita
nvo_file_list sl_lista_file
datetime ldt_max_file, ldt_candidato, ldt_data_ora

dw_lista_foto.reset()
ldt_data_ora=datetime(today(), now())
//wf_salva_file("TENTATIVO ore: "+string(ldt_data_ora))
ls_path=sle_path.text
if isnull(ls_path) or ls_path< "  " then
	ls_path="\\server2021\versione1\TXT\"
end if
li_lunghezza_path=len(ls_path)
if right(ls_path, 1) <>"\" then li_lunghezza_path++
sl_lista_file=f_leggi_files(ls_path, false)

FOR ll_temp = 1 TO UpperBound( sl_lista_file.as_file )
	if right(sl_lista_file.as_file[ll_temp], 3)="txt" then
		ls_test=""
		select '1' into :ls_test from dba.tracc_file_processato where nome_file_processato=:sl_lista_file.as_file[ll_temp] ;
		if ls_test<>"1" then
			ls_file_candidato=mid(sl_lista_file.as_file[ll_temp], len(ls_path ) +1, len(sl_lista_file.as_file[ll_temp]) - len(ls_path) - 4)
			dw_3.reset()
			dw_1.reset()
			dw_2.reset()
			li_riga_inserita=dw_lista_foto.insertrow(0)
			dw_lista_foto.setitem(li_riga_inserita,"nome_file", sl_lista_file.as_file[ll_temp])
			dw_3.importfile(Text!,sl_lista_file.as_file[ll_temp])
			ls_ret=wf_carica_doc_e_righe(sl_lista_file.as_file[ll_temp])
			if ls_ret> " " then
				 MessageBox("Errore", "Le seguenti bollettine NON sono state passate: "+ls_ret)
				 wf_salva_file(sl_lista_file.as_file[ll_temp]+".ERR")
			else
				wf_salva_file(sl_lista_file.as_file[ll_temp])
			end if	
		end if
	end if
next




end event

type dw_3 from udw_001 within w_tracciamento_produzione
integer x = 1778
integer y = 144
integer width = 1760
integer taborder = 10
string dataobject = "d_dati_tracciamento"
boolean vscrollbar = true
end type

type dw_2 from udw_001 within w_tracciamento_produzione
integer x = 37
integer y = 1120
integer width = 3918
integer height = 496
integer taborder = 10
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;return 2
end event

type dw_1 from udw_001 within w_tracciamento_produzione
integer x = 37
integer y = 756
integer width = 3918
integer height = 336
integer taborder = 10
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
end type

event doubleclicked;long ll_id_doc
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

