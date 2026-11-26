forward
global type w_carica_xls_copia20210823 from w_001
end type
type cb_salva from commandbutton within w_carica_xls_copia20210823
end type
type cb_cancella from commandbutton within w_carica_xls_copia20210823
end type
type cb_carica from commandbutton within w_carica_xls_copia20210823
end type
type sle_colonna from singlelineedit within w_carica_xls_copia20210823
end type
type dw_1 from udw_001 within w_carica_xls_copia20210823
end type
type cb_crea_bol from commandbutton within w_carica_xls_copia20210823
end type
type dw_6 from udw_base within w_carica_xls_copia20210823
end type
type dw_3 from udw_figlia within w_carica_xls_copia20210823
end type
type cb_4 from commandbutton within w_carica_xls_copia20210823
end type
type cb_3 from commandbutton within w_carica_xls_copia20210823
end type
type cb_controlla_articoli from commandbutton within w_carica_xls_copia20210823
end type
type dw_9 from udw_000 within w_carica_xls_copia20210823
end type
type pb_cerca from picturebutton within w_carica_xls_copia20210823
end type
type cb_canc_bollettina from commandbutton within w_carica_xls_copia20210823
end type
type dw_10 from udw_000 within w_carica_xls_copia20210823
end type
type st_2 from statictext within w_carica_xls_copia20210823
end type
type dw_11 from udw_000 within w_carica_xls_copia20210823
end type
type pb_carica from picturebutton within w_carica_xls_copia20210823
end type
type dw_4 from udw_base within w_carica_xls_copia20210823
end type
type cb_prezzo from commandbutton within w_carica_xls_copia20210823
end type
type dw_5 from udw_base within w_carica_xls_copia20210823
end type
type cb_bol_50000 from commandbutton within w_carica_xls_copia20210823
end type
type dw_8 from udw_001 within w_carica_xls_copia20210823
end type
type cb_carica_old from commandbutton within w_carica_xls_copia20210823
end type
type ole_1 from olecontrol within w_carica_xls_copia20210823
end type
type dw_7 from udw_000 within w_carica_xls_copia20210823
end type
type cb_1 from commandbutton within w_carica_xls_copia20210823
end type
type dw_2 from udw_000 within w_carica_xls_copia20210823
end type
type cb_2 from commandbutton within w_carica_xls_copia20210823
end type
end forward

global type w_carica_xls_copia20210823 from w_001
integer width = 6469
integer height = 3164
string title = "Importazione BOL da EXCEL"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
cb_salva cb_salva
cb_cancella cb_cancella
cb_carica cb_carica
sle_colonna sle_colonna
dw_1 dw_1
cb_crea_bol cb_crea_bol
dw_6 dw_6
dw_3 dw_3
cb_4 cb_4
cb_3 cb_3
cb_controlla_articoli cb_controlla_articoli
dw_9 dw_9
pb_cerca pb_cerca
cb_canc_bollettina cb_canc_bollettina
dw_10 dw_10
st_2 st_2
dw_11 dw_11
pb_carica pb_carica
dw_4 dw_4
cb_prezzo cb_prezzo
dw_5 dw_5
cb_bol_50000 cb_bol_50000
dw_8 dw_8
cb_carica_old cb_carica_old
ole_1 ole_1
dw_7 dw_7
cb_1 cb_1
dw_2 dw_2
cb_2 cb_2
end type
global w_carica_xls_copia20210823 w_carica_xls_copia20210823

type variables
string is_bol_senza_accessorio[]
end variables

forward prototypes
public subroutine wf_decifra ()
public function boolean wf_esiste_galvanica (string as_galv)
public function integer wf_uc (long al_id_art)
public subroutine wf_salva_progressivo (long al_riga)
public subroutine wf_filtra (string as_numero)
public subroutine wf_trova_prezzo (long al_riga)
public subroutine wf_salva_des_2 (long al_row)
public subroutine wf_carica_des_2 (long al_row)
public function integer wf_controlla_se_esistente (string as_cliente, string as_cod_barre, string as_tipo)
public function long wf_crea_articolo (string as_cod_art, long al_id_titolo)
public subroutine wf_salva_descrizione (long al_riga)
public function string wf_togli_apostrofo (string as_cod_art)
public function boolean wf_esiste_art_e_lunghezza (long al_id_art_locale, string as_cod_art, long al_row, long al_id_titolo)
public function long wf_controlla_lunghezza (string as_cod_art, long al_row, long al_id_titolo, decimal adc_lunghezza_cm, decimal adc_lunghezza_inch, long al_test)
public function long wf_trova_id_art (string as_cod_art, long al_riga, decimal adc_lunghezza, integer ai_um)
public subroutine wf_salva_e_torna_cod_barre (long al_row)
public subroutine wf_ins_art_in_dw (string as_cod_art, long al_id_art_locale, long al_row)
public function boolean wf_controlla_des_2 (long al_id_articolo)
public function long wf_articolo (string as_cod_articolo, string as_cliente)
public function boolean wf_controlla_des_lib (long al_row, string as_cod_art)
public function string wf_controlla_k4_6 (long al_row, string as_cod_art, long al_id_titolo)
end prototypes

public subroutine wf_decifra ();integer i, li_riga_inserita
string ls_dati, ls_imp
date ldt_data
long ll_num
decimal ldc_qta

dw_2.reset()
for i = 1 to dw_1.rowcount()
	ls_dati=dw_1.getitemstring(i, "a1")
	
	
	ls_imp=mid(ls_dati, 16, 6)
	if ls_imp>"      " then
		li_riga_inserita=dw_2.insertrow(0)
		dw_2.setitem(li_riga_inserita, "num_doc", ls_imp)
	else
		continue
	end if
	
	ls_imp=mid(ls_dati, 5, 6)
	ls_imp=right(ls_imp, 2)+"/"+mid(ls_imp, 3,2)+"/"+left(ls_imp, 2)
	ldt_data=date(ls_imp)
	dw_2.setitem(li_riga_inserita, "data_doc", ldt_data)
	
	ls_imp=mid(ls_dati, 22, 2)
	dw_2.setitem(li_riga_inserita, "serie", ls_imp)
	
	ls_imp=mid(ls_dati, 24, 5)
	ll_num=long(ls_imp)
	dw_2.setitem(li_riga_inserita, "num_riga", ll_num)
	
	ls_imp=mid(ls_dati, 29, 20)
	dw_2.setitem(li_riga_inserita, "art", ls_imp)
	
	ls_imp=mid(ls_dati, 49, 40)
	dw_2.setitem(li_riga_inserita, "des_art", ls_imp)
	
	ls_imp=mid(ls_dati, 99, 9)
	ls_imp=left(ls_imp, 6)+","+right(ls_imp, 3)
	ldc_qta=	dec(ls_imp)
	dw_2.setitem(li_riga_inserita, "qta", ldc_qta)
	
	ls_imp=mid(ls_dati, 108, 14)
	ls_imp=left(ls_imp, 11)+","+right(ls_imp, 3)
	ldc_qta=	dec(ls_imp)
	dw_2.setitem(li_riga_inserita, "prezzo", ldc_qta)
	
	ls_imp=mid(ls_dati, 134, 6)
	ls_imp=left(ls_imp, 4)+","+right(ls_imp, 2)
	ldc_qta=	dec(ls_imp)
	dw_2.setitem(li_riga_inserita, "sconto1", ldc_qta)
	
	ls_imp=mid(ls_dati, 140, 6)
	ls_imp=left(ls_imp, 4)+","+right(ls_imp, 2)
	ldc_qta=	dec(ls_imp)
	dw_2.setitem(li_riga_inserita, "sconto2", ldc_qta)
	
	ls_imp=mid(ls_dati, 152, 3)
	dw_2.setitem(li_riga_inserita, "iva", ls_imp)
		
	
next
end subroutine

public function boolean wf_esiste_galvanica (string as_galv);boolean lb_esiste=false
long ll_id_galvanica=0

select id_galvanica
into :ll_id_galvanica
from dba.galvanica
where lavorazione=:as_galv;
if ll_id_galvanica> 0 then
	lb_esiste=true
end if

return lb_esiste
end function

public function integer wf_uc (long al_id_art);long ll_id_uc

select id_unita_confezione
	into  :ll_id_uc
	from dba.unita_confezione 
	where id_articolo=:al_id_art
	and unita_base='S'
	;
	return ll_id_uc
end function

public subroutine wf_salva_progressivo (long al_riga);long ll_num_prog, ll_id_doc
integer i
dw_5.accepttext()
ll_id_doc=dw_5.getitemnumber(al_riga, "id_documento")
ll_num_prog=dw_5.getitemnumber(al_riga, "num_progressivo")
if ll_num_prog>0 then
	update dba.documento
	set num_progressivo=:ll_num_prog
	where id_documento=:ll_id_doc
	;
	if sqlca.sqlNrows>0 then
		commit;
		dw_5.setitem(al_riga, "des_contabile", "V")
		dw_5.filter()
	else
		rollback;
		messagebox("Attenzione!", "Numero progressivo per riga "+string(al_riga)+" NON salvato!") 
	end if
end if

//for i = 1 to dw_5.rowcount()
//	ll_num_prog=dw_5.getitemnumber(i, "num_progressivo")
//	ll_id_doc=dw_5.getitemnumber(i, "id_documento")
//	update dba.documento
//	set num_progressivo=:ll_num_prog
//	where id_documento=:ll_id_doc
//	;
//	if sqlca.sqlNrows>0 then
//		commit;
//	else
//		rollback;
//		messagebox("Attenzione!", "Numero progressivo per riga "+string(i)+" NON salvato!") 
//	end if
//	
//next
end subroutine

public subroutine wf_filtra (string as_numero);string ls_filter

if as_numero> " " then
	ls_filter="num_documento like '%"+as_numero+"%'"
	dw_5.setfilter(ls_filter)
else
	dw_5.setfilter(" isnull(des_contabile ) or des_contabile<>'V'")
end if
dw_5.filter()
end subroutine

public subroutine wf_trova_prezzo (long al_riga);date ldt_data
long ll_id_uc, ll_id_variazione
decimal ldc_prezzo, ldc_pr_man

ldt_data=dw_5.getitemdate(al_riga, "data_documento")
ll_id_uc=dw_5.getitemnumber(al_riga, "id_unita_confezione")
select id_variazione into :ll_id_variazione from dba.variazione where id_listino=18 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
SELECT prezzo, prezzo_manifattura
into :ldc_prezzo, :ldc_pr_man
from dba.prezzo
where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc
;
if isnull(ldc_prezzo) or ldc_prezzo=0  and ldc_pr_man>0 then
	ldc_prezzo=ldc_pr_man
	dw_5.setitem(al_riga, "num_riga", 11) //lo segno per colorare il prezzo se è manifattura gr, bianco se PZ
else
	dw_5.setitem(al_riga, "num_riga", 1)
end if
if ldc_prezzo>0 then
	dw_5.setitem(al_riga, "prezzo", ldc_prezzo)
end if
//return ldc_prezzo
end subroutine

public subroutine wf_salva_des_2 (long al_row);string ls_des_2
long ll_id_art,ll_id_variazione,ll_id_uc
date ldt_data

ls_des_2=dw_5.getitemstring(al_row, "c_des_2")
if ls_des_2>" " then
	ll_id_art=dw_5.getItemnumber(al_row, "id_articolo")
	select id_unita_confezione
	into :ll_id_uc
	from dba.unita_confezione
	where id_articolo=:ll_id_art and unita_base='S';			
	if ll_id_uc> 0 then //inserisco l'articolo sulla tb prezzo nel listino/variazione corretta
		ldt_data=dw_5.getitemdate(1, "data_documento")
		if isnull(ldt_data) or  ldt_data=date("1900-01-01") then
			ldt_data=dw_11.getitemdate(1, "data")
		end if
			
		
		select id_variazione 
		into :ll_id_variazione from dba.variazione
		where id_listino=18 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
		insert into dba.prezzo (id_variazione, id_unita_confezione, des_1, des_2)
		values (:ll_id_variazione, :ll_id_uc, 'AUTO_xsl',:ls_des_2 );
		if sqlca.sqlNrows>0 then
			commit;
		else
			rollback;
			update  dba.prezzo 
			set des_2=: ls_des_2
			where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc
			;
			if sqlca.sqlNrows>0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Des_2: "+ls_des_2+" NON salvata in listino KAR!")
			end if
		end if
	end if
end if
end subroutine

public subroutine wf_carica_des_2 (long al_row);string ls_des_2
long ll_id_art, ll_id_variazione, ll_id_uc
date ldt_data

if al_row>0 then
	ll_id_art=dw_5.getitemnumber(al_row, "id_articolo")
	select id_unita_confezione
	into :ll_id_uc
	from dba.unita_confezione
	where id_articolo=:ll_id_art and unita_base='S';			
	if ll_id_uc> 0 then //inserisco l'articolo sulla tb prezzo nel listino/variazione corretta
		ldt_data=dw_5.getitemdate(AL_ROW, "data_documento")
		select id_variazione 
		into :ll_id_variazione from dba.variazione
		where id_listino=18 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
		select des_2
		into :ls_des_2 from dba.prezzo
		where id_variazione=:ll_id_variazione and id_unita_confezione=:ll_id_uc
		;
		if ls_des_2> " " then
			dw_5.setitem(al_row, "c_des_2", ls_des_2)
		end if
	end if
end if

end subroutine

public function integer wf_controlla_se_esistente (string as_cliente, string as_cod_barre, string as_tipo);//as_cliente è il codice del cliente, 
//as_cod_barre è il codice a barre 
// insieme formano la chiave prmaria della tabella "bollettine_excel"
date ldt_data

select data
into :ldt_data
from dba.bollettine_excel
where cliente=:as_cliente
and cod_barre=:as_cod_barre
and tipo=:as_tipo
;
if ldt_data> date("2000/01/01") then
	messagebox("Attenzione!", "Bollettina n. "+right(as_cliente, 4)+"-"+right(as_cod_barre, 5)+ " ESISTE già! NON sarà inserita 2 volte: SALTO!")
	return 0 //NON inserisce
else
	return 1 //inserisce
end if
end function

public function long wf_crea_articolo (string as_cod_art, long al_id_titolo);long ll_riga_inserita, ll_null, ll_id_art_locale, ll_id_uc, ll_id_variazione
string ls_data, ls_num_doc,LS_AZIENDA
datetime ldt_data


//select rag_soc_1 into :ls_azienda from azienda;
//IF POS(LS_AZIENDA,'SILVER DR%')>0 then
//	messagebox("Attenzione!", "Articolo NON presente nel nostro archivio! Il fornitore ha sbagliato il codice o giù di lì!")
//	return -100  //la Silverdreams NON deve creare articoli con importa righe e documenti
//end if
dw_6.reset()

setnull(ll_null)

//INCREDIBilE; controllo che l'articolo non sia già inserito (nel qual caso rimando lìid articolo trovato
select id_articolo into :ll_id_art_locale from dba.articolo where codice=:as_cod_art;
if isnull(ll_id_art_locale) or ll_id_art_locale<=0 then

	ll_riga_inserita=dw_6.insertrow(1)
	dw_6.setitem(ll_riga_inserita, "id_articolo", ll_null)
	if len(as_cod_art)>64 then messagebox("Attenzione!", "Articolo: "+as_cod_art+" Più lungo di 64!!!!")
	dw_6.setitem(ll_riga_inserita, "codice", as_cod_art)  
	dw_6.setitem(ll_riga_inserita, "descrizione", as_cod_art)
	dw_6.setitem(ll_riga_inserita, "des_breve", left(as_cod_art, 40))
	dw_6.setitem(ll_riga_inserita, "id_cat_codifica", 66) //è cat_codifica creata all'uopo "AUTO"
	dw_6.setitem(ll_riga_inserita,"id_sog_comm_variante", ll_null)
	
	dw_6.setitem(ll_riga_inserita,"id_cat_com_articolo", 8) //è ARG
	dw_6.setitem(ll_riga_inserita,"id_titolo", al_id_titolo) 
	dw_6.setitem(ll_riga_inserita,"coef_calo",1000) //deve essere sempre 1000 ????
	dw_6.setitem(ll_riga_inserita,"immagine", as_cod_art+".jpg")
	dw_6.setitem(ll_riga_inserita,"nota", "Art. da EXCEL")
	dw_6.setitem(ll_riga_inserita,"id_unita_conf_base", 2) // con questa crea da se unita_conf a PZ
	dw_6.setitemstatus(ll_riga_inserita, 0, Primary!, NewModified!)
	dw_6.trigger event ue_update()  //salvo e inserisco l'articolo
	
	ll_id_art_locale=dw_6.getitemnumber(1, "id_articolo") //lo recupero
	select id_unita_confezione
	into :ll_id_uc
	from dba.unita_confezione
	where id_articolo=:ll_id_art_locale and unita_base='S';
	
	if ll_id_uc> 0 then //inserisco l'articolo sulla tb prezzo nel listino/variazione corretto
		ldt_data=dw_1.getitemdatetime(1, "data")
		ls_data="AUTO_XLS "+string(ldt_data, "dd_mm_yy")
		ll_id_variazione=0
		select id_variazione 
		into :ll_id_variazione from dba.variazione
		where id_listino=17 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
		insert into dba.prezzo (id_variazione, id_unita_confezione, des_1)
		values (:ll_id_variazione, :ll_id_uc, :ls_data);
		if sqlca.sqlNrows>0 then
			commit;
		else
			rollback;
			//messagebox("Attenzione!", "Articolo: "+ls_cod_articolo+" NON inserito in listino BASE VENDITA!")
		end if
		select id_variazione 
		into :ll_id_variazione from dba.variazione
		where id_listino=18 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
		insert into dba.prezzo (id_variazione, id_unita_confezione, des_1, des_3, des_2)
		values (:ll_id_variazione, :ll_id_uc, :ls_data,:ls_num_doc, '$' ) //20200728 richiesta: segnare articoli nuovi con "$" perché non hanno prezzo des_2 svolto con i "K"
		;
		if sqlca.sqlNrows>0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Articolo: "+as_cod_art+" NON inserito in listino KAR!")
		end if
	else
		messagebox("Attenzione!", "Unita Confezione art.: "+as_cod_art+" NON inserita!")
	end if
end if

	
return ll_id_art_locale
end function

public subroutine wf_salva_descrizione (long al_riga);string ls_des
long ll_id_riga_doc

dw_5.accepttext()
ll_id_riga_doc=dw_5.getitemnumber(al_riga, "id_riga_documento")
ls_des=dw_5.getitemstring(al_riga, "descrizione")

	update dba.riga_documento
	set descrizione=:ls_des
	where id_riga_documento=:ll_id_riga_doc
	;
	if sqlca.sqlNrows>0 then
		commit;
		//dw_5.setitem(al_riga, , "V")
		//dw_5.filter()
	else
		rollback;
		messagebox("Attenzione!", "Descrizione per riga "+string(al_riga)+" NON salvato!") 
	end if

end subroutine

public function string wf_togli_apostrofo (string as_cod_art);integer li_pos
string ls_cod_art_pulito

li_pos=pos(as_cod_art, "'") 
if li_pos>0 then
	ls_cod_art_pulito=replace(as_cod_art, li_pos, 1,  "~~~'" )
else
	ls_cod_art_pulito=as_cod_art
end if
return ls_cod_art_pulito
end function

public function boolean wf_esiste_art_e_lunghezza (long al_id_art_locale, string as_cod_art, long al_row, long al_id_titolo);boolean lb_ret
decimal ldc_lunghezza_inch, ldc_lunghezza_cm
long ll_id_art_ok,ll_test
string ls_cod_art_lunghezza

ldc_lunghezza_inch=dw_1.getitemdecimal(al_row, "dim_l_inch") 
ldc_lunghezza_cm=dw_1.getitemdecimal(al_row, "dim_l_cm") 
if isnull(ldc_lunghezza_inch) then ldc_lunghezza_inch=0
if isnull(ldc_lunghezza_cm) then ldc_lunghezza_cm=0
//controllo se  la lunghezza va controllata
ls_cod_art_lunghezza=left(as_cod_art, pos(as_cod_art, '-') - 1)+'%'
select id_articolo into :ll_test from dba.articolo
where codice like :ls_cod_art_lunghezza and ges_matricole='S'
;
if ll_test>0 or ldc_lunghezza_inch>=24 or ldc_lunghezza_cm>=60 or ldc_lunghezza_cm=1 or (ldc_lunghezza_inch<=3.4 and ldc_lunghezza_inch>0) then //se sì si controlla la lunghezza
	select id_articolo
	into :ll_id_art_ok
	from dba.unita_confezione
	where id_articolo=:al_id_art_locale and unita_base='S' and (dim_l=:ldc_lunghezza_cm or dim_l=:ldc_lunghezza_inch)
	;
	if ll_id_art_ok>0 then
		lb_ret=true
	else
		wf_controlla_lunghezza(as_cod_art, al_row, al_id_titolo, ldc_lunghezza_cm, ldc_lunghezza_inch, ll_test) //se deve aggiunge la lunghezza al codice, altrimenti crea semplicemente l'articolo
	end if
else //altrimenti ok così
	lb_ret=true
end if

return lb_ret
end function

public function long wf_controlla_lunghezza (string as_cod_art, long al_row, long al_id_titolo, decimal adc_lunghezza_cm, decimal adc_lunghezza_inch, long al_test);long ll_id_art_locale=0, ll_test=0, ll_riga_trovata,ll_riga_inserita
string ls_art_orecchino, ls_cod_art_pulito,ls_lunghezza
boolean lb_f6=true

if al_test>0 then //se è  "ges_matricole"='S' allora creo un articolo per ogni misura diversa
	if adc_lunghezza_inch>0 or adc_lunghezza_cm=0 then adc_lunghezza_cm=adc_lunghezza_inch 
	ls_lunghezza=string(adc_lunghezza_cm, "#,0.00")
	ls_art_orecchino=left(as_cod_art, len(as_cod_art) - 6 ) +"_"+ls_lunghezza +right(as_cod_art, 6)  //+ls_lunghezza tolgo il cliente aggiungo L+lunghezza e rimetto cliente
	ls_cod_art_pulito=wf_togli_apostrofo(ls_art_orecchino)
	//controllo se esiste già
	select a.id_articolo
	into :ll_id_art_locale
	from dba.articolo a, unita_confezione u
	where a.id_articolo=u.id_articolo and u.unita_base='S' and 
	(a.codice=:ls_art_orecchino or (a.codice=:as_cod_art and u.dim_l=:adc_lunghezza_cm))
	;
	if isnull(ll_id_art_locale) or ll_id_art_locale<=0 then  //lo creo
		ls_art_orecchino=wf_controlla_k4_6(al_row, ls_art_orecchino, al_id_titolo)
		ll_id_art_locale=wf_crea_articolo(ls_art_orecchino, al_id_titolo )
		if ll_id_art_locale= -100 then return -100
		update dba.unita_confezione
		set unita_confezione.dim_l =:adc_lunghezza_cm
		from dba.unita_confezione , dba.articolo a
		where a.id_articolo=unita_confezione.id_articolo and unita_confezione.unita_base='S' and a.id_articolo=:ll_id_art_locale;
		if sqlca.sqlcode=0 then
			commit;
			ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
			if ll_riga_trovata<=0 then 
			ll_riga_inserita=dw_8.insertrow(0)
			dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
			dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
		end if
		dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
		else
			rollback;
			messagebox("Attenzione!", "Lunghezza non salvata articolo: "+string(ll_id_art_locale))
		end if
	else
		ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
		if ll_riga_trovata<=0 then 
			ll_riga_inserita=dw_8.insertrow(0)
			dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
			dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
		end if
		dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
	end if	
//metto a postoEAR
elseif adc_lunghezza_cm=adc_lunghezza_inch and adc_lunghezza_cm=1 then //è un'orecchino 
//	//controllo se esiste già con EAR nel codice
	//if pos(as_cod_art, "EAR")>0 then  //'avrebbe già trovato wf_esiste_art_e_lunghezza----
		//ll_id_art_locale=0  //non devo fare nulla esiste già come deve essere
	//else
	ls_art_orecchino=as_cod_art
	if pos(ls_art_orecchino, "OR")<=0 then //21-20-20 samy dice che se nel codice c'è già "OR" inutile mettere EAR
		ls_art_orecchino=left(as_cod_art, len(as_cod_art) - 6 ) +" EAR" +right(as_cod_art, 6)  //tolgo il cliente aggiungo spazio+EAR e rimetto cliente	
	end if
	//controllo se esiste già
	select id_articolo
	into :ll_id_art_locale
	from dba.articolo
	where codice=:ls_art_orecchino
	;
	ls_cod_art_pulito= wf_togli_apostrofo(ls_art_orecchino)
	if isnull(ll_id_art_locale) or ll_id_art_locale<=0 then  //lo creo
		ls_art_orecchino=wf_controlla_k4_6(al_row, ls_art_orecchino, al_id_titolo)
		ll_id_art_locale=wf_crea_articolo(ls_art_orecchino, al_id_titolo )
		if ll_id_art_locale= -100 then return -100
		update dba.unita_confezione
		set unita_confezione.dim_l =1
		from dba.unita_confezione , dba.articolo a
		where a.id_articolo=unita_confezione.id_articolo and unita_confezione.unita_base='S' and a.id_articolo=:ll_id_art_locale;
		if sqlca.sqlcode=0 then
			commit;
			ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
			if ll_riga_trovata<=0 then 	 
				ll_riga_inserita=dw_8.insertrow(0)
				dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
				dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
			end if
			dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
		else
			rollback;
			messagebox("Attenzione!", "Lunghezza non salvata articolo EAR: "+string(ll_id_art_locale))
		end if
	else
		ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
		if ll_riga_trovata<=0 then 
			ll_riga_inserita=dw_8.insertrow(0)
			dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
			dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
		end if
		dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
	end if
	//22082020 se lunghezza >=24,00 e <= 39,37 o >=60 e <=100 cm si fa così (_@)
elseif (adc_lunghezza_inch>=24 and adc_lunghezza_inch<=39.37)  or (adc_lunghezza_cm>=60 and adc_lunghezza_cm<=100) then
	if adc_lunghezza_inch>=24 or adc_lunghezza_cm=0 then adc_lunghezza_cm=adc_lunghezza_inch  //metto il valore in una delle 2 variabili
	//controllo se esiste con la lunghezza nel codice altrimenti lo creo
	//ls_lunghezza=string(adc_lunghezza_cm, "#,0.00")
	if pos(as_cod_art, "K6")>0 then
		ls_art_orecchino=left(as_cod_art, len(as_cod_art) - 9 ) +"_@" +right(as_cod_art, 9) 
	else
		ls_art_orecchino=left(as_cod_art, len(as_cod_art) - 6 ) +"_@" +right(as_cod_art, 6)  //+ls_lunghezza tolgo il cliente aggiungo L+lunghezza e rimetto cliente
		ls_cod_art_pulito=wf_controlla_k4_6(al_row, ls_art_orecchino, al_id_titolo)
		if ls_cod_art_pulito<>ls_art_orecchino then ls_art_orecchino=ls_cod_art_pulito
	end if
	ls_cod_art_pulito=wf_togli_apostrofo(ls_art_orecchino)
	//controllo se esiste già
	
	select a.id_articolo
	into :ll_id_art_locale
	from dba.articolo a, unita_confezione u
	where a.id_articolo=u.id_articolo and u.unita_base='S' and 
	(a.codice=:ls_art_orecchino or (a.codice=:as_cod_art and u.dim_l=:adc_lunghezza_cm))
	;
	if isnull(ll_id_art_locale) or ll_id_art_locale<=0 then  //lo creo
		ls_art_orecchino=wf_controlla_k4_6(al_row, ls_art_orecchino, al_id_titolo)
		ll_id_art_locale=wf_crea_articolo(ls_art_orecchino, al_id_titolo )
		if ll_id_art_locale= -100 then return -100
		update dba.unita_confezione
		set unita_confezione.dim_l =:adc_lunghezza_cm
		from dba.unita_confezione , dba.articolo a
		where a.id_articolo=unita_confezione.id_articolo and unita_confezione.unita_base='S' and a.id_articolo=:ll_id_art_locale;
		if sqlca.sqlcode=0 then
			commit;
			ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
			if ll_riga_trovata<=0 then 
			ll_riga_inserita=dw_8.insertrow(0)
			dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
			dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
		end if
		dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
		else
			rollback;
			messagebox("Attenzione!", "Lunghezza non salvata articolo: "+string(ll_id_art_locale))
		end if
	else
		ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
		if ll_riga_trovata<=0 then 
			ll_riga_inserita=dw_8.insertrow(0)
			dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
			dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
		end if
		dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
	end if	
elseif adc_lunghezza_inch>39.37  or adc_lunghezza_cm>100 then //aggiungo "_@1"
	if adc_lunghezza_inch>0 or adc_lunghezza_cm=0 then adc_lunghezza_cm=adc_lunghezza_inch  //metto il valore in una delle 2 variabili
	//controllo se esiste con la lunghezza nel codice altrimenti lo creo
	//ls_lunghezza=string(adc_lunghezza_cm, "#,0.00")
	ls_art_orecchino=left(as_cod_art, len(as_cod_art) - 6 ) +"_@1" +right(as_cod_art, 6)  //+ls_lunghezza tolgo il cliente aggiungo L+lunghezza e rimetto cliente
	ls_cod_art_pulito=wf_togli_apostrofo(ls_art_orecchino)
	//controllo se esiste già
	select a.id_articolo
	into :ll_id_art_locale
	from dba.articolo a, unita_confezione u
	where a.id_articolo=u.id_articolo and u.unita_base='S' and 
	(a.codice=:ls_art_orecchino or (a.codice=:as_cod_art and u.dim_l=:adc_lunghezza_cm)) //controllo se esiste cgià con@1 o se esiste già con la stessa misura
	;
	if isnull(ll_id_art_locale) or ll_id_art_locale<=0 then  //lo creo
		ls_art_orecchino=wf_controlla_k4_6(al_row, ls_art_orecchino, al_id_titolo)
		ll_id_art_locale=wf_crea_articolo(ls_art_orecchino, al_id_titolo )
		if ll_id_art_locale= -100 then return -100
		update dba.unita_confezione
		set unita_confezione.dim_l =:adc_lunghezza_cm
		from dba.unita_confezione , dba.articolo a
		where a.id_articolo=unita_confezione.id_articolo and unita_confezione.unita_base='S' and a.id_articolo=:ll_id_art_locale;
		if sqlca.sqlcode=0 then
			commit;
			ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
			if ll_riga_trovata<=0 then 
				ll_riga_inserita=dw_8.insertrow(0)
				dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
				dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
			end if
		dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
		else
			rollback;
			messagebox("Attenzione!", "Lunghezza non salvata articolo: "+string(ll_id_art_locale))
		end if
	else
		ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
		if ll_riga_trovata<=0 then 
			ll_riga_inserita=dw_8.insertrow(0)
			dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
			dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
		end if
		dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
	end if	
elseif (adc_lunghezza_inch<=3.4 and adc_lunghezza_inch<>1 and adc_lunghezza_inch>0) or adc_lunghezza_cm<=6 then // or  then
	ls_art_orecchino=left(as_cod_art, len(as_cod_art) - 6 ) +"<4" +right(as_cod_art, 6)  //+ls_lunghezza tolgo il cliente aggiungo L+lunghezza e rimetto cliente
	ls_cod_art_pulito=wf_togli_apostrofo(ls_art_orecchino)
	//controllo se esiste già
	select a.id_articolo
	into :ll_id_art_locale
	from dba.articolo a, unita_confezione u
	where a.id_articolo=u.id_articolo and u.unita_base='S' and 
	(a.codice=:ls_art_orecchino or (a.codice=:as_cod_art and u.dim_l=:adc_lunghezza_cm)) //controllo se esiste già con<4 o se esiste già con la stessa misura
	;
	if isnull(ll_id_art_locale) or ll_id_art_locale<=0 then  //lo creo
		ls_art_orecchino=wf_controlla_k4_6(al_row, ls_art_orecchino, al_id_titolo)
		ll_id_art_locale=wf_crea_articolo(ls_art_orecchino, al_id_titolo )
		if ll_id_art_locale= -100 then return -100
		update dba.unita_confezione
		set unita_confezione.dim_l =:adc_lunghezza_cm
		from dba.unita_confezione , dba.articolo a
		where a.id_articolo=unita_confezione.id_articolo and unita_confezione.unita_base='S' and a.id_articolo=:ll_id_art_locale;
		if sqlca.sqlcode=0 then
			commit;
			ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
			if ll_riga_trovata<=0 then 
				ll_riga_inserita=dw_8.insertrow(0)
				dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
				dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
			end if
			dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
		else
			rollback;
			messagebox("Attenzione!", "Lunghezza non salvata articolo: "+string(ll_id_art_locale))
		end if
	else
		ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
		if ll_riga_trovata<=0 then 
			ll_riga_inserita=dw_8.insertrow(0)
			dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_art_orecchino)
			dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
		end if
		dw_1.setitem(al_row, "cod_art_assegnato", ls_art_orecchino)
		
	end if	
else //creo l'articolo così come è
	ls_cod_art_pulito=wf_togli_apostrofo(as_cod_art)
	as_cod_art=wf_controlla_k4_6(al_row, ls_cod_art_pulito, al_id_titolo)
	ll_id_art_locale=wf_crea_articolo(as_cod_art, al_id_titolo )
	if ll_id_art_locale= -100 then return -100
	ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
	if ll_riga_trovata<=0 then 
		ll_riga_inserita=dw_8.insertrow(0)
		dw_8.setitem(ll_riga_inserita, "cod_articolo", as_cod_art)
		dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
	end if
	dw_1.setitem(al_row, "cod_art_assegnato", as_cod_art)
end if

return ll_id_art_locale
end function

public function long wf_trova_id_art (string as_cod_art, long al_riga, decimal adc_lunghezza, integer ai_um);long ll_id_articolo, ll_riga_trovata, ll_test
string ls_cod_art_pulilto, ls_metallo, ls_pre_codice,ls_cod_art_lunghezza,ls_art_orecchino
integer li_pos

li_pos=pos(as_cod_art, "'")
if li_pos>0 then
ls_cod_art_pulilto=replace(as_cod_art, li_pos, 1, "~~~'" )
else
	ls_cod_art_pulilto=as_cod_art
end if
ll_riga_trovata=dw_8.find("cod_articolo='"+ls_cod_art_pulilto+"'", 1, dw_8.rowcount())
if ll_riga_trovata> 0 then
	ll_id_articolo=dw_8.getitemnumber(ll_riga_trovata, "id_articolo_corrispondente")
else
	
	//potrebbe essere metallo <> AG e quindi controllo
	ls_metallo=dw_1.getitemstring(al_riga, "metallo")
	//se il metallo è BD il codice corrispondente è "SI"
	ls_pre_codice=""
	if trim(ls_metallo)='BD' then 
			ls_pre_codice='s'
	elseif ls_metallo='BZ' then
		ls_pre_codice='b'
	elseif  ls_metallo='OT' then
		ls_pre_codice='o'
	end if
	ll_riga_trovata=dw_8.find("cod_articolo='"+ls_pre_codice+ls_cod_art_pulilto+"'", 1, dw_8.rowcount())
	if ll_riga_trovata> 0 then
		ll_id_articolo=dw_8.getitemnumber(ll_riga_trovata, "id_articolo_corrispondente")
	else
		//potrebbe essere stata aggiunta la lunghezza nel codice articolo ("_24,00" o "EAR" )
		//ai_um=0 sono cemtimetri nullo=inch
		ls_cod_art_lunghezza=left(as_cod_art, pos(as_cod_art, '-') - 1)+'%'
		select id_articolo into :ll_test from dba.articolo
		where codice like :ls_cod_art_lunghezza and ges_matricole='S'
		;
		
		if adc_lunghezza=1   then
			ls_art_orecchino=left(as_cod_art, len(as_cod_art) - 6 ) +" EAR" +right(as_cod_art, 6) 
			ll_riga_trovata=dw_8.find("cod_articolo='"+ls_pre_codice+ls_art_orecchino+"'", 1, dw_8.rowcount())
			if ll_riga_trovata> 0 then
				ll_id_articolo=dw_8.getitemnumber(ll_riga_trovata, "id_articolo_corrispondente")
			else
				messagebox("Attenzione!", "Articolo: "+as_cod_art+" non trovato in finestra articoli (dw_8)!")
			end if
		elseif (adc_lunghezza>=24 and isnull(ai_um)) or adc_lunghezza>=60  or ll_test>0 then
			ls_art_orecchino=left(as_cod_art, len(as_cod_art) - 6 ) +"_"+string(adc_lunghezza) +right(as_cod_art, 6)
			ll_riga_trovata=dw_8.find("cod_articolo='"+ls_pre_codice+ls_art_orecchino+"'", 1, dw_8.rowcount())
			if ll_riga_trovata> 0 then 
				ll_id_articolo=dw_8.getitemnumber(ll_riga_trovata, "id_articolo_corrispondente")
			else
				messagebox("Attenzione!", "Articolo: "+as_cod_art+" non trovato in finestra articoli (dw_8)!")
			end if
		end if
	end if
end if
return ll_id_articolo
end function

public subroutine wf_salva_e_torna_cod_barre (long al_row);
end subroutine

public subroutine wf_ins_art_in_dw (string as_cod_art, long al_id_art_locale, long al_row);long ll_riga_trovata, ll_riga_inserita
string ls_cod_art_pulito

ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
if ll_riga_trovata<=0 then 
	ll_riga_inserita=dw_8.insertrow(0)
	dw_8.setitem(ll_riga_inserita, "cod_articolo", as_cod_art)
	dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", al_id_art_locale)
end if
dw_1.setitem(al_row, "cod_art_assegnato", as_cod_art)
end subroutine

public function boolean wf_controlla_des_2 (long al_id_articolo);boolean lb_f6=false
string ls_des_2
long ll_id_uc


select id_unita_confezione
into :ll_id_uc
from dba.unita_confezione
where id_articolo=:al_id_articolo and unita_base='S';			
if ll_id_uc> 0 then //inserisco l'articolo sulla tb prezzo nel listino/variazione corretta
	select des_2
	into :ls_des_2 from dba.prezzo
	where id_variazione=15 and id_unita_confezione=:ll_id_uc
	;
	ls_des_2=upper(ls_des_2)
	if pos(ls_des_2, "K6")>0 or pos(ls_des_2, "K55")>0  or pos(ls_des_2, "K4")>0 then
		lb_f6=false
	else
		lb_f6=true
	end if
end if
return lb_f6
end function

public function long wf_articolo (string as_cod_articolo, string as_cliente);string ls_codice, ls_cod_art_cliente
long ll_riga_trovata, ll_id_art_locale,  ll_null, ll_id_art
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc,ll_riga_inserita

setnull(ll_null)



ls_cod_art_cliente=as_cod_articolo+"-"+as_cliente

select id_articolo
into :ll_id_art_locale
from dba.articolo
where codice=:as_cod_articolo or  codice=:ls_cod_art_cliente
;																	//la Samy prima 30-01-20 mi ha detto di inserire articolo così com'è e, quindi, farlo diventare articolo silverdreams, ora invece (01-02-20) ....
if ll_id_art_locale<=0 or isnull(ll_id_art_locale) then //l'articolo non esiste occorre inserirlo (//si guarda se c'è nella tabella di corrispondenza ? ma aspettiamo ... 01-02-20 proviamo ...)
	select id_articolo_corrispondente
	into :ll_id_art_locale
	from dba.corrispondenza_cod_id_articolo
	where cod_articolo=:as_cod_articolo or  cod_articolo=:ls_cod_art_cliente
	;
	//ls_art_kar=ls_articolo
	if  ll_id_art_locale<=0 or isnull(ll_id_art_locale) then
		messagebox("ARTICOLO", "Articolo NON trovato! Fai girare Controlla Articoli prima di creare le bollettine!")
//		per ora commento lunedì 3 si decide con Samy
//		dw_6.reset()
////		dw_7.reset()
//		ll_riga_inserita=dw_6.insertrow(1)
//		dw_6.setitem(ll_riga_inserita, "id_articolo", ll_null)
//		dw_6.setitem(ll_riga_inserita, "codice", as_cod_articolo)
//		dw_6.setitem(ll_riga_inserita, "descrizione", as_cod_articolo)
//		dw_6.setitem(ll_riga_inserita, "des_breve", as_cod_articolo)
//		dw_6.setitem(ll_riga_inserita, "id_cat_codifica", 66) //è cat_codifica creata all'uopo "AUTO"
//		dw_6.setitem(ll_riga_inserita,"id_sog_comm_variante", ll_null)
//		dw_6.setitem(ll_riga_inserita,"id_cat_com_articolo", 8) //è ARG
//		dw_6.setitem(ll_riga_inserita,"id_titolo",4)
//		dw_6.setitem(ll_riga_inserita,"coef_calo",1000)
//		dw_6.setitem(ll_riga_inserita,"immagine", as_cod_articolo+".jpg")
//		dw_6.setitem(ll_riga_inserita,"nota", "Art. da EXCEL")
//		dw_6.setitemstatus(ll_riga_inserita, 0, Primary!, NewModified!)
//		dw_6.trigger event ue_update()
//		ll_id_art_locale=dw_6.getitemnumber(1, "id_articolo")
//		dw_7.SetItem(1,"id_unita_confezione", ll_null)
//		dw_7.setitem(1, "id_articolo", ll_id_art_locale)
//		dw_7.setitemstatus(1, 0, Primary!, NewModified!)
//		dw_7.trigger event ue_update()	
	end if
end if
return ll_id_art_locale
end function

public function boolean wf_controlla_des_lib (long al_row, string as_cod_art);boolean lb_f6=false
string ls_des_libera
long ll_id_art

//20210812
ls_des_libera=dw_1.getitemstring(al_row, "des_libera")
if  (pos(ls_des_libera, "TUTT")>0 and  pos(ls_des_libera, "ANEL")>0) or  (pos(ls_des_libera, "TUTT")>0 and pos(ls_des_libera, "SALD")>0) or &
		(pos(ls_des_libera, "ANEL")>0 and pos(ls_des_libera, "SALD")>0)   then
		select id_articolo into :ll_id_art from dba.articolo where codice=:as_cod_art;
		if ll_id_art>0 then  
			lb_f6=wf_controlla_des_2(ll_id_art)
		else
			lb_f6=true  //se l'articolo non esiste ancora certamente la sua "des_2" NON contiene "K6 K4"
		end if
end if

return lb_f6
end function

public function string wf_controlla_k4_6 (long al_row, string as_cod_art, long al_id_titolo);//controllo l'articolo per vedere se devo aggiungere K6 (des_libera deve contenere un po' di cose e nella des_2 non deve già esserci "K6" 
boolean lb_f6
string ls_cod_art_pulito, ls_test
long ll_id_art_locale, ll_riga_trovata
	
	
	if pos(as_cod_art, "K6")>0 then return as_cod_art
	lb_f6=wf_controlla_des_lib(al_row, as_cod_art)
	if lb_f6 then //ci sono le condizioni per inserire "K6"
	//controllo che non sia già stto inserito...
		ls_test=left(as_cod_art, len(as_cod_art) - 6)+"_K6"+right(as_cod_art, 6)
		select id_articolo into :ll_id_art_locale from dba.articolo where codice=:ls_test;
		if ll_id_art_locale>0 then //l'articolo è già stato inserito
			as_cod_art=ls_test
		else
			ls_cod_art_pulito=as_cod_art
			as_cod_art=ls_test
		//	ll_id_art_locale=wf_crea_articolo(as_cod_art, al_id_titolo )
		end if
		
//		ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art_pulito+"'",1, 1000000)
//		if ll_riga_trovata<=0 then 
//			ll_riga_trovata=dw_8.insertrow(0)
//			dw_8.setitem(ll_riga_trovata, "cod_articolo", as_cod_art)
//			dw_8.setitem(ll_riga_trovata, "id_articolo_corrispondente", ll_id_art_locale)
//		end if
//		dw_1.setitem(al_row, "cod_art_assegnato", as_cod_art)
		
	end if

return as_cod_art
end function

on w_carica_xls_copia20210823.create
int iCurrent
call super::create
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_carica=create cb_carica
this.sle_colonna=create sle_colonna
this.dw_1=create dw_1
this.cb_crea_bol=create cb_crea_bol
this.dw_6=create dw_6
this.dw_3=create dw_3
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_controlla_articoli=create cb_controlla_articoli
this.dw_9=create dw_9
this.pb_cerca=create pb_cerca
this.cb_canc_bollettina=create cb_canc_bollettina
this.dw_10=create dw_10
this.st_2=create st_2
this.dw_11=create dw_11
this.pb_carica=create pb_carica
this.dw_4=create dw_4
this.cb_prezzo=create cb_prezzo
this.dw_5=create dw_5
this.cb_bol_50000=create cb_bol_50000
this.dw_8=create dw_8
this.cb_carica_old=create cb_carica_old
this.ole_1=create ole_1
this.dw_7=create dw_7
this.cb_1=create cb_1
this.dw_2=create dw_2
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salva
this.Control[iCurrent+2]=this.cb_cancella
this.Control[iCurrent+3]=this.cb_carica
this.Control[iCurrent+4]=this.sle_colonna
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_crea_bol
this.Control[iCurrent+7]=this.dw_6
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.cb_3
this.Control[iCurrent+11]=this.cb_controlla_articoli
this.Control[iCurrent+12]=this.dw_9
this.Control[iCurrent+13]=this.pb_cerca
this.Control[iCurrent+14]=this.cb_canc_bollettina
this.Control[iCurrent+15]=this.dw_10
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.dw_11
this.Control[iCurrent+18]=this.pb_carica
this.Control[iCurrent+19]=this.dw_4
this.Control[iCurrent+20]=this.cb_prezzo
this.Control[iCurrent+21]=this.dw_5
this.Control[iCurrent+22]=this.cb_bol_50000
this.Control[iCurrent+23]=this.dw_8
this.Control[iCurrent+24]=this.cb_carica_old
this.Control[iCurrent+25]=this.ole_1
this.Control[iCurrent+26]=this.dw_7
this.Control[iCurrent+27]=this.cb_1
this.Control[iCurrent+28]=this.dw_2
this.Control[iCurrent+29]=this.cb_2
end on

on w_carica_xls_copia20210823.destroy
call super::destroy
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_carica)
destroy(this.sle_colonna)
destroy(this.dw_1)
destroy(this.cb_crea_bol)
destroy(this.dw_6)
destroy(this.dw_3)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_controlla_articoli)
destroy(this.dw_9)
destroy(this.pb_cerca)
destroy(this.cb_canc_bollettina)
destroy(this.dw_10)
destroy(this.st_2)
destroy(this.dw_11)
destroy(this.pb_carica)
destroy(this.dw_4)
destroy(this.cb_prezzo)
destroy(this.dw_5)
destroy(this.cb_bol_50000)
destroy(this.dw_8)
destroy(this.cb_carica_old)
destroy(this.ole_1)
destroy(this.dw_7)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.cb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_7.settransobject(sqlca)
dw_8.settransobject(sqlca)
//dw_9.settransobject(sqlca)
dw_9.insertrow(1)
dw_10.insertrow(1)

dw_11.settransobject(sqlca)
dw_11.insertrow(1)
//dw_11.retrieve()
dw_7.insertrow(1)
dw_7.setitem(1, "dt_data", today())





end event

type st_1 from w_001`st_1 within w_carica_xls_copia20210823
end type

type cb_salva from commandbutton within w_carica_xls_copia20210823
integer x = 1449
integer y = 412
integer width = 338
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Salva"
end type

event clicked;integer li_ret
li_ret=dw_1.triggerevent("ue_update")
if li_ret=1 then
	messagebox("OK", "Salvato!")
	cb_crea_bol.enabled=true
else
	messagebox("NO", "NON Salvato!")
end if
end event

type cb_cancella from commandbutton within w_carica_xls_copia20210823
integer x = 1449
integer y = 524
integer width = 338
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "< Cancella"
end type

event clicked;dw_1.trigger event ue_delete(dw_1.getrow())
end event

type cb_carica from commandbutton within w_carica_xls_copia20210823
integer x = 1449
integer y = 44
integer width = 338
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica Excel"
end type

event clicked;
integer li_ret, li_pos, li_num_prog, a, b
string ls_path, ls_file, ls_num_doc, LS_INCH, ls_um, ls_lettera, ls_bollo, ls_des_libera, ls_art_verifica
integer i, li_riga_inserita
string ls_dati, ls_imp, ls_pezzi, ls_cod_numerico, ls_metallo, ls_tipo,ls_test2, ls_des3
string ls_cod_barre, ls_cliente,   ls_des, ls_galv, ls_art, ls_test, ls_accessorio, ls_acc_precedente
datetime ldt_data
long ll_num, ll_id_tab_iva, ll_pezzi, ll_id_art
decimal ldc_qta, ldc_peso, ldc_titolo, ldc_inch
boolean lb_esiste, lb_data_ok=true
date ldt_data_scadenza
	
getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+"txt"
	if fileexists(ls_file) then FileDelete(ls_file)
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_2.importfile(Text!,ls_file)

end if	 

dw_1.reset()

ldt_data=datetime(date(dw_2.getitemstring(10, "A08")), now())
for i = 1 to dw_2.rowcount() 
	ls_test=""
	ls_test=dw_2.getitemstring(i, "A18")
	li_num_prog=integer(ls_test)
	if li_num_prog>0 then
		if lb_data_ok then 
			ldt_data=datetime(dw_2.getitemstring(i, "A04"))
			lb_data_ok=false
		end if
		ls_cod_barre=""
		ls_cod_barre=dw_2.getitemstring(i, "A15")
		if ls_cod_barre> "0" then
			ls_cliente=""
			ls_cliente=dw_2.getitemstring(i, "A16")
			ls_des=""
			//ls_des=dw_2.getitemstring(i+2, "A??") la des è stata tolta ... 2020-07-15
			if pos(upper(ls_des), "RESO")>0 then ls_tipo='R' else ls_tipo="B"
			li_ret=wf_controlla_se_esistente(ls_cliente, ls_cod_barre, ls_tipo)
			if li_ret=0 then continue // se esiste già la chiave primaria NON carico il record, lo salto
			
			ll_pezzi=0
			ll_pezzi=long(dw_2.getitemstring(i, "A12"))
			ldc_peso=0
			ldc_peso=dec(dw_2.getitemstring(i, "A13"))
			ls_art=""
			ls_art=dw_2.getitemstring(i, "A08")+" "+dw_2.getitemstring(i, "A09") 
			ls_art=f_togli_spazi_doppi(ls_art)
			//ll_id_art=wf_articolo(ls_art)
			ls_galv=""
			ls_galv=dw_2.getitemstring(i, "A07")
			ls_metallo=""
			ls_metallo=dw_2.getitemstring(i, "A05")
			ldc_titolo=0
			ldc_titolo=dec(dw_2.getitemstring(i, "A06"))
			lb_esiste=wf_esiste_galvanica(ls_galv)
			if not(lb_esiste) then ls_galv=""
			//20200727
			//recupero accessorio (a11)
			ls_des_libera=dw_2.getitemstring(i, "A20")
			ls_accessorio=dw_2.getitemstring(i, "A11")
			//05/03/2021 controllo prima di ogni cosa che l'accessorio legato all'articolo NON sia diverso da quello che l'articolo aveva precedentemente
			//questo perché per il cliente lo stesso articolo può cambiare accessorio e una volta avere "A02" l'altra "A11" ...
//			ls_art_verifica=ls_art+"-"+ls_cliente
//			select first(accessorio) into :ls_acc_precedente from bollettine_excel where articolo=:ls_art_verifica order by data desc;
//		
//			if ls_acc_precedente> " " then
//				if ls_acc_precedente<>ls_accessorio then
//					ls_art+="_X"
//				end if
//			end if
			//controllo che l'accessorio esista nella tabella cod_accessori_k, altrimenti lo segnalo
			ls_test2=""
			select cod_accessorio into :ls_test2 from dba.cod_accessori_k where cod_accessorio=:ls_accessorio;
			if ls_test2<>ls_accessorio then
				b++
				is_bol_senza_accessorio[b]="#-"+ls_accessorio+"-"+ls_cod_barre
				if messagebox("Attenzione!", "Accessorio: "+ls_accessorio+ " NON trovato in tabella cod_accessori! Vuoi inserirlo ora?", stopsign!, yesno!)=1 then
					openwithparm(w_cod_accessori_k, ls_accessorio )
				end if
			end if
			
			//controllo se galvanica="YG" e nella nota c'è "TUTTI ANELLI SALDATI" allora metto oltre la galvanica "articolo_YG"+_C011-12211
			if ls_galv="YG" and pos(ls_des_libera, "TUTTI ANELLI SALDATI")>0 and pos(ls_cliente, "2211")>0 then
				ls_art+="_"+ls_galv+"_"+ls_accessorio
			else //prova se funge si lascia, altrimenti....
				if ls_accessorio<>'X' and ls_accessorio<>'XXX' then
					ls_art+="_"+ls_accessorio
				end if
			end if
			//fine
			//inserisco
			li_riga_inserita=dw_1.insertrow(0)
			//23-06-2020 devo recuperare anche la lunghezza! la fuznione rutrna true se devo caricare lunghezza
			//if f_rec_lunghezza( ls_art+"-"+ls_cliente) then
			LS_INCH=""
			LS_INCH=dw_2.getitemstring(i, "A10")
			if pos(ls_inch, "EAR") >0 then //se c'è EAR è un orecchino quindi lunghezza sia cm che inch=1
				dw_1.setitem(li_riga_inserita, "dim_l_inch", 1)
				dw_1.setitem(li_riga_inserita, "dim_l_cm", 1)
			else
				IF pos(ls_inch, "METR")>0 then
					ldc_inch=3.4  //non 0, ma 3.4 perché così poi lo trova a metraggio e aggiunge il "<4"
				ELSE
					if pos(ls_inch, ",")>0 then
						ls_des+=LS_INCH
					else
					li_pos=pos(ls_inch, ".")
						if li_pos>0 then
							ls_inch=left(ls_inch, li_pos - 1)+","+right(ls_inch, len(ls_inch) - li_pos)
						end if			
						ls_um=""
						for a = len(ls_inch) to 1 step -1
							ls_lettera=mid(ls_inch, a, 1)
							if isnumber(ls_lettera) then exit
							ls_um+=ls_lettera
						next
						ldc_inch=dec(left(LS_INCH, len(ls_inch) - len(ls_um)))
						if ldc_inch<=0 or isnull(ldc_inch) then
							messagebox("Attenzione!", "Lunghezza non trovata!")
						else
							ls_um=trim(ls_um)
							if ls_um='"' then
								dw_1.setitem(li_riga_inserita, "dim_l_inch", ldc_inch)
							elseif ls_um='mc' then //prendo i valori al contrario quindi cm -->mc
								dw_1.setitem(li_riga_inserita, "dim_l_cm", ldc_inch)
							end if
						end if		
					end if
				END IF
			end if
			//fine lunghezza (da spostare in funzione
			//27-08-2020 aggiutni 3 campi: bollo (a11b) data_scadenza (a19) des_libera (a20)
			ls_bollo=dw_2.getitemstring(i, "A11b")
			ldt_data_scadenza=date(dw_2.getitemstring(i, "A19"))
			
			dw_1.setitem(li_riga_inserita, "bollo", ls_bollo)
			dw_1.setitem(li_riga_inserita, "data_scadenza", ldt_data_scadenza)
			dw_1.setitem(li_riga_inserita, "des_libera", ls_des_libera)
			
			
			dw_1.setitem(li_riga_inserita, "accessorio", ls_accessorio)
			dw_1.setitem(li_riga_inserita, "cod_barre", ls_cod_barre)
			dw_1.setitem(li_riga_inserita, "cliente", ls_cliente)
			dw_1.setitem(li_riga_inserita, "pezzi", ll_pezzi)
			dw_1.setitem(li_riga_inserita, "peso", ldc_peso)
			dw_1.setitem(li_riga_inserita, "articolo", ls_art+"-"+ls_cliente)
			if len(ls_des)>255 then
				ls_des= left(ls_des, 255)
			end if
			dw_1.setitem(li_riga_inserita, "descrizione", ls_des)
			dw_1.setitem(li_riga_inserita, "data", ldt_data)
			dw_1.setitem(li_riga_inserita, "galvanica", ls_galv)
			//20200617 cambio perché da Vicenza mandano file xls con numerazione che riparte da 1 anche 3-4volte e il numero riga è parte del mio indice 
			//dw_1.setitem(li_riga_inserita, "num_riga", integer(ls_test)) //in questo formato pare che il progressivo sia rispettato... 2020-07-15
			dw_1.setitem(li_riga_inserita, "num_riga", li_num_prog )
			//fine 20200617 fine 2020-07-15
			dw_1.setitem(li_riga_inserita, "metallo", ls_metallo)
			dw_1.setitem(li_riga_inserita, "titolo", ldc_titolo)
			dw_1.setitem(li_riga_inserita, "tipo", ls_tipo)
		end if
	end if
next

cb_controlla_articoli.enabled=true
//
//
end event

type sle_colonna from singlelineedit within w_carica_xls_copia20210823
integer x = 4526
integer y = 832
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
long textcolor = 33554432
string text = " "
boolean border = false
end type

type dw_1 from udw_001 within w_carica_xls_copia20210823
integer x = 37
integer y = 48
integer width = 1394
integer height = 876
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_bol_excel"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;//wf_articolo(ls_art)
end event

type cb_crea_bol from commandbutton within w_carica_xls_copia20210823
integer x = 1801
integer y = 12
integer width = 517
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "CREA BOLLETTINE"
end type

event clicked;integer i, li_ret, li_pezzi, li_pos, b
long ll_righe, ll_id_sog, ll_id_esercizio, ll_id_reg,ll_id_prof, ll_id_reg_mod, ll_id_mag, ll_id_locazione, ll_id_causale, ll_num_prog_esistente
long ll_null, ll_id_doc, ll_id_art, ll_id_uc, ll_id_conto, ll_riga_nuova, ll_id_galvanica, ll_id_variazione, ll_test
long ll_id_con_pagamento, ll_id_iva, ll_id_riga, ll_id_banca, ll_id_profOBOL, ll_um_lunghezza
date ldt_data, ldt_data_scadenza
string ls_num_doc, ls_cod_art, ls_des,ls_galv, ls_metallo, ls_cliente, ls_tipo,ls_des_da_xls,  ls_bollo, ls_test=""
decimal ldc_prezzo, ldc_lunghezza
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog

setnull(ll_null)
//questo va cambiato nel caso di adattamento ad altro cliente
select id_con_pagamento, id_tab_iva, id_banca_sog_commerciale
into :ll_id_con_pagamento, :ll_id_iva, :ll_id_banca
from dba.sog_commerciale
where id_sog_commerciale=43
;
if 	isnull(ll_id_con_pagamento) then ll_id_con_pagamento=34
if 	isnull(ll_id_iva) then ll_id_iva=80 //NI08/2C

//ldt_data=date(dw_1.getitemdatetime(1, "data"))
dw_7.accepttext()
ldt_data= dw_7.getitemdate(1, "dt_data")// NON PIù: inserito campo data per poterla modificare a bisogno relativedate(ldt_data, 1)
if ldt_data<date("1990-01-01") or isnull(ldt_data) then
	messagebox("Attenzione!", "La data non è valida: impostare la data nell'apposito campo!")
end if
ll_id_sog=43 //il cliente è sempre Karizia
ll_id_conto=1003
select id_esercizio
into :ll_id_esercizio
from dba.esercizio
where data_inizio<= :ldt_data
and data_fine>=:ldt_data
;

select id_prof_documento
into :ll_id_prof
from dba.prof_documento
where codice='BOL'
;
select id_prof_documento
into :ll_id_profOBOL
from dba.prof_documento
where codice='OBOL'
;

//Con il profilo trovo 
select id_magazzino_1_prop, id_mod_registro_prop, id_locazione_1_prop, id_caus_magazzino_prop
into :ll_id_mag, :ll_id_reg_mod, :ll_id_locazione, :ll_id_causale
from dba.prof_documento
where id_prof_documento=:ll_id_prof
;
SELECT registro.id_registro
INTO :ll_id_reg  
FROM "dba"."registro"  
WHERE  "registro"."id_esercizio" = :ll_id_esercizio  AND  
id_mod_registro = :ll_id_reg_mod
and numero=2 
;
select id_variazione
into :ll_id_variazione
from dba.variazione
where id_listino=18
and data_inizio<=:ldt_data and data_fine>=:ldt_data
;
//uo_proponi_num_progressivo=create u_setta_campi_documento
//ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_reg, 0, 'GV')
//destroy uo_proponi_num_progressivo
//ls_trova_prog.sl_num_progressivo+=100 //era 100000
ls_trova_prog.sl_num_progressivo=50001  //si parte sempre da 50001

open(w_bol_50000)	
if isvalid(message) then
	ll_test=message.doubleparm
	if ll_test>50000 then ls_trova_prog.sl_num_progressivo=ll_test + 1
end if
//ma prima controllo che non ci siano bol con numero >50000
ll_righe=dw_1.rowcount()
for i =1 to ll_righe
	ls_tipo=""
	ls_tipo=dw_1.getitemstring(i, "tipo")
	if ls_tipo='R' then continue
	ls_num_doc=""
	ls_num_doc=right(dw_1.getitemstring(i, "cliente"), 4)
	if left(ls_num_doc, 1)="0" then ls_num_doc=right(ls_num_doc, 3)//ho corretto i numeri iniziali possono essere anche solo 3 quindi occorre prender le lettere prima del "-" 04-02-2020
	ls_num_doc+="-"+right(dw_1.getitemstring(i, "cod_barre"), 5) 
	ll_num_prog_esistente=0
	//controllo se il doc esiste già
	select num_progressivo
	into :ll_num_prog_esistente
	from dba.documento
	where id_registro=:ll_id_reg
	and num_documento=:ls_num_doc
	and data_documento=:ldt_data
	;
	if ll_num_prog_esistente>0 then
		messagebox("Attenzione!", "Il documento è già stato importato al num. prog.: "+string(ll_num_prog_esistente))//, stopsign!, yesno!)=1 then
	else
		
		dw_4.reset()
		dw_4.insertrow(1)
		dw_4.SetItem(1, "id_valuta", 3)
		dw_4.SetItem(1, "num_documento", ls_num_doc)
		dw_4.SetItem(1, "data_documento", ldt_data)
		dw_4.SetItem(1, "id_sog_commerciale", ll_id_sog)
		dw_4.SetItem(1, "id_sog_commerciale_fattura", ll_id_sog)
		dw_4.SetItem(1, "id_registro", ll_id_reg)
		ls_metallo=""
		ls_metallo=dw_1.getitemstring(i, "metallo")
		if ls_metallo="AG" then //è argento 925 quindi "BOL"
			dw_4.SetItem(1, "id_prof_documento", ll_id_prof)
		else
			dw_4.SetItem(1, "id_prof_documento", ll_id_profOBOL) // è BD, SI, o OT quindi OBOL
		end if
		dw_4.SetItem(1, "num_progressivo", ls_trova_prog.sl_num_progressivo+i)
		dw_4.SetItem(1, "data_registrazione", ldt_data)
		dw_4.SetItem(1, "id_caus_magazzino", ll_id_causale)
		dw_4.SetItem(1, "id_locazione_1", ll_id_locazione)
		dw_4.SetItem(1, "id_magazzino", ll_id_locazione)
		dw_4.SetItem(1, "origine", "BOL da Excel il "+string(datetime(today(),now()) ,"dd/mm/yy hh:mm:ss"))
		dw_4.SetItem(1, "id_documento", ll_null)
		dw_4.SetItem(1, "id_destinazione", ll_null)
		dw_4.SetItem(1, "id_variazione", ll_id_variazione)
		dw_4.SetItem(1, "id_con_pagamento", ll_id_con_pagamento)
		dw_4.SetItem(1, "chius_forzata", "N") //già inseriti nel initial della dw che salva ma non funge allora ...
		dw_4.SetItem(1, "sospeso", "N")
		dw_4.SetItem(1, "bloccato", "N")
		dw_4.SetItem(1, "evaso_totalmente", "N")
		dw_4.SetItem(1, "id_banca_sog_commerciale", ll_id_banca)
		//aggiungo 27-08-2000
		ldt_data_scadenza=dw_1.getitemdate(i, "data_scadenza")
		ls_bollo=dw_1.getitemstring(i, "bollo")
		dw_4.SetItem(1, "data_prev_consegna", ldt_data_scadenza)
		dw_4.SetItem(1, "bollo", ls_bollo)
		
		
		
		
		dw_4.setitemstatus(1, 0, Primary!, NewModified!)
		li_ret=dw_4.trigger event ue_update()
		ll_id_doc=0
		ll_id_doc=dw_4.getitemnumber(1, "id_documento")
		if ll_id_doc>0 then //inserisco le righe
			ls_cod_art=""
			ls_cliente=""
			//ls_cod_art=dw_1.getitemstring(i, "articolo")
			//proviamo così con il cod_art_assegnato 1208200
			ls_cod_art=dw_1.getitemstring(i, "cod_art_assegnato")
			ls_cliente=dw_1.getitemstring(i, "cliente")
			//20200715 aggiungo lunghezza e l'unità di misura della lunghezza articolo su dim_h : se è nullo sono inch (colore background bianco) se =0 allora sono cm (colore background giallo)
			setnull(ll_um_lunghezza)
			ldc_lunghezza=dw_1.getitemdecimal(i, "dim_l_inch")
			if isnull(ldc_lunghezza) or ldc_lunghezza=0 then
				ldc_lunghezza=dw_1.getitemdecimal(i, "dim_l_cm")
				if ldc_lunghezza>0 then
					ll_um_lunghezza=0
				end if
			end if
			//ll_id_art=wf_articolo(ls_cod_art, ls_cliente)
			ll_id_art=wf_trova_id_art(ls_cod_art, i, ldc_lunghezza, ll_um_lunghezza)
			ll_id_uc=wf_uc(ll_id_art)	
			ls_des=""
			//ls_des=ls_cod_art
			select descrizione
			into :ls_des
			from dba.articolo
			where id_articolo=:ll_id_art;
			if isnull(ls_des) then ls_des=ls_cod_art
			ls_des_da_xls=dw_1.getitemstring(i, "descrizione")
			if isnull(ls_des_da_xls) then ls_des_da_xls=""
			ls_des+=" "+dw_1.getitemstring(i, "descrizione") //in descrizione ci va la lunghezza se sono più di una (20", 22", 24")
			if left(ls_cod_art, 2)<>'KC' then
				ls_galv=""
				//22-06-20 tolgo perché Samy non lo vuole più
//				select cod_articolo
//				into :ls_galv
//				from dba.corrispondenza_cod_id_articolo
//				where id_articolo_corrispondente=:ll_id_art
//				;
				//if ls_galv> " " then ls_des+=" - "+ls_cod_art //aggiungo alla des il codice articolo karizia samy richiesto il 03-02-2020 uso ls_galv come variabile di test
				//fine tolgo 22-06
			end if
			li_pezzi=0
			li_pezzi=dw_1.getitemnumber(i, "pezzi")
			ls_galv=""
			ls_galv=dw_1.getitemstring(i, "galvanica")
			if ls_galv> " " then ls_des+=" - "+ls_galv //aggiungo alla des la galvanica, se c'è
			//02-11-2020 se c'è accessorio non registrato coloro descrizione
			for b=1 to upperbound(is_bol_senza_accessorio)
				if pos(ls_num_doc, right(is_bol_senza_accessorio[b], 5))>0 then
					ls_test=is_bol_senza_accessorio[b]
					update dba.prezzo set des_3=:is_bol_senza_accessorio[b]
					where id_variazione=:ll_id_variazione and id_unita_confezione= :ll_id_uc;
					if sqlca.sqlcode=0 then
						commit;
					else
						rollback;
						messagebox("Attenzione!", "Accessorio mancante NON salvato in des_3 listino!")
					end if
					exit
				else
					ls_test=""
				end if
			next
			ls_des+=ls_test
			
			//31-01-2020 per ora NON vuole la galvanica
//			select id_galvanica
//			into :ll_id_galvanica
//			from dba.galvanica
//			where lavorazione=:ls_galv
//			;
			//if isnull(ls_des) then ls_des=ls_cod_art
			
			//pulisco e inserisco
			dw_3.reset()
			dw_3.insertrow(1)
			dw_3.SetItem(1, "dim_l", ldc_lunghezza)
			dw_3.SetItem(1, "dim_h", ll_um_lunghezza)
			dw_3.SetItem(1, "num_riga", 1)
			dw_3.SetItem(1, "id_documento", ll_id_doc)
			dw_3.SetItem(1, "id_articolo", ll_id_art)
			dw_3.SetItem(1, "id_unita_confezione", ll_id_uc)
			dw_3.SetItem(1, "id_caus_magazzino", ll_id_causale)
			dw_3.SetItem(1, "id_locazione_1", ll_id_locazione)
			dw_3.SetItem(1, "coef_calo", 1000)
			dw_3.SetItem(1, "id_valuta", 3)
			dw_3.SetItem(1, "id_conto", ll_id_conto)
			dw_3.SetItem(1, "quantita", li_pezzi)
			dw_3.SetItem(1, "qta_un_base", li_pezzi)
			//dw_3.SetItem(1, "qta_evasa_un_base", li_pezzi)
			dw_3.SetItem(1, "qta_evasa", 0)
			dw_3.SetItem(1, "peso_netto", 0)
			dw_3.SetItem(1, "peso_netto_evaso", 0)
			dw_3.SetItem(1, "descrizione", ls_des)
			dw_3.SetItem(1, "id_listino", ll_id_variazione)
			dw_3.SetItem(1, "id_tab_iva", ll_id_iva)
			//31-01-2020 per ora NON vuole la galvanica
			//dw_3.SetItem(1, "id_gruppo_agenti_2", ll_id_galvanica)
			//setnull(ll_id_galvanica)
			dw_3.setitemstatus(i, 0, Primary!, NewModified!)
			li_ret=dw_3.trigger event ue_update()
			if li_ret=1 then
				dw_5.retrieve(ll_id_doc)
				ll_id_riga=0
				ll_id_riga=dw_3.getitemnumber(1, "id_riga_documento")
				
				dw_1.setitem(i, "id_riga_documento",  ll_id_riga)
				li_ret=dw_1.triggerevent("ue_update")
				//dw_5.setitem(ll_riga_nuova, "prezzo",  ldc_prezzo)
				//ll_riga_nuova=dw_5.insertrow(1)
				//dw_5.setitem(ll_riga_nuova, "id_documento",  ll_id_doc)	
//				dw_5.setitem(ll_riga_nuova, "num_progressivo",  ls_trova_prog.sl_num_progressivo)
//				dw_5.setitem(ll_riga_nuova, "data_documento", ldt_data)
//				dw_5.setitem(ll_riga_nuova, "num_documento",  ls_num_doc)
//				dw_5.setitem(ll_riga_nuova, "pezzi",  li_pezzi)				
			end if
		end if
	

		
	end if

next

//destroy uo_proponi_num_progressivo

end event

type dw_6 from udw_base within w_carica_xls_copia20210823
integer x = 37
integer y = 2292
integer width = 5317
integer height = 684
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_articolo_newff"
boolean hscrollbar = true
end type

type dw_3 from udw_figlia within w_carica_xls_copia20210823
boolean visible = false
integer x = 201
integer y = 1380
integer width = 3429
integer height = 376
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
end type

type cb_4 from commandbutton within w_carica_xls_copia20210823
boolean visible = false
integer x = 2249
integer y = 2436
integer width = 347
integer height = 100
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci Stampa"
end type

event clicked;dw_5.reset()
end event

type cb_3 from commandbutton within w_carica_xls_copia20210823
boolean visible = false
integer x = 2688
integer y = 2476
integer width = 462
integer height = 100
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa Bol. Create"
end type

event clicked;string ls_titolo
printsetup()

ls_titolo="Bol_del_"+string(today(), "dd-mm-yy hh:mm:ss")
dw_5.Modify("DataWindow.Print.DocumentName='"+ls_titolo+"'")
dw_5.print()
end event

type cb_controlla_articoli from commandbutton within w_carica_xls_copia20210823
integer x = 1449
integer y = 292
integer width = 338
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Controlla Art."
end type

event clicked;integer i, li_pos
string ls_cod_art, ls_cod_art_cliente, ls_metallo,ls_pre_codice, ls_art_altro_titolo, ls_cod_art_pulito, ls_cod_art_K
long ll_id_art_locale, ll_id_art_corrispondente,ll_riga_inserita, ll_riga_trovata, ll_id_titolo, ll_id_tit_locale, ll_id_new_art_locale
decimal ldc_titolo,ldc_lunghezza_cm, ldc_lunghezza_inch
boolean lb_esiste

dw_8.reset()
dw_1.accepttext()
for i = 1 to dw_1.rowcount() 
/* controllo tutti codici articolo e propongo accanto il corrispondente*/
	ls_cod_art=dw_1.getitemstring(i, "articolo")
	//if len(ls_cod_art)>=26 then messagebox("Attenzione!", "Articolo: "+ls_cod_art+ " lungo 26! ")
	//controllo se l'articolo è già stato trovato (allora è nella dw_8)
	//ll_riga_trovata=0
	ls_cod_art_pulito=wf_togli_apostrofo(ls_cod_art)

	ls_metallo=dw_1.getitemstring(i, "metallo")
	//se il metallo è BD il codice corrispondente è "SI"
	ls_pre_codice=""
	if trim(ls_metallo)='BD' then 
		ls_metallo='SI'
		ll_id_titolo=26
		ls_pre_codice='s'
	elseif ls_metallo='BZ' then
		ll_id_titolo=25
		ls_pre_codice='b'
	elseif  ls_metallo='OT' then
		ll_id_titolo=24
		ls_pre_codice='o'
	else
		ldc_titolo=dw_1.getitemdecimal(i, "titolo")
		ll_id_titolo=0
		select id_titolo into :ll_id_titolo
		from dba.orafo_metallo m, dba.orafo_titolo t
		where m.id_metallo=t.id_metallo
		and m.codice=:ls_metallo and t.titolo=:ldc_titolo;	
	end if
	ll_id_art_locale=0
	
	if ll_id_titolo<=0 or isnull(ll_id_titolo) then 
		messagebox("Attenzione!", "Articolo: "+ls_cod_art+ " senza titolo! Metto AG925!")
		ll_id_titolo=4
	end if
	//cerco l'articolo nel DB  e prendo anche il titolo perché la fonte (K) usa lo stesso codice articolo per diversi titoli, noi abbiamo un codice un titolo
	
	if pos(ls_cod_art, "K6")<=0 then
		ls_cod_art_K=wf_controlla_k4_6(i, ls_cod_art, ll_id_titolo)
		if ls_cod_art_K<>ls_cod_art then ls_cod_art=ls_cod_art_K
	end if
	select id_articolo, id_titolo
	into :ll_id_art_locale, :ll_id_tit_locale
	from dba.articolo
	where codice=:ls_cod_art
	;
	if  ll_id_art_locale>0 then //art esiste: controllo titolo
		if ll_id_tit_locale=ll_id_titolo then //se il titolo è = l'ho trovato non devo fare altro ASSOCIARLI NO! devo controllare lunghezza 20200727
			ls_pre_codice="" 
			lb_esiste=wf_esiste_art_e_lunghezza(ll_id_art_locale, ls_cod_art, i, ll_id_titolo) //controllo se l'articolo ha lunghezza = a quella richiesta
			if lb_esiste then
				ls_cod_art_K=wf_controlla_k4_6(i, ls_cod_art, ll_id_titolo)
				ls_cod_art=ls_cod_art_K  //perché ho commentato quella sotto che era dannosa!!!!
				//if ls_cod_art_K=ls_cod_art then //se era da K6 ha già fatto tutto, altrimenti lo faccio (da migliorare e farlo fare tutto nel controllok6
					ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_pre_codice+ls_cod_art_pulito+"'",1, 1000000)
					if ll_riga_trovata<=0 then 	
						ll_riga_inserita=dw_8.insertrow(0)
						dw_8.setitem(ll_riga_inserita, "cod_articolo", ls_cod_art)
						dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
					end if
					dw_1.setitem(i, "cod_art_assegnato", ls_cod_art)
				//end if
				continue
			else
				//ll_id_new_art_locale=wf_controlla_lunghezza(ls_cod_art,i, ll_id_titolo) la faccio partire da wf_esiste_art_E_LUNGHEZZA
			end if
		else  //non ha lo stesso titolo
			//l'articolo non esiste o ha titolo diverso: occorre inserirlo controllando anche di non averlo già fatto (//si guarda se c'è nella tabella di corrispondenza ? ma aspettiamo ... 01-02-20 proviamo ...)
			//provo a cercare l'articolo con il pre codice
			if pos(ls_cod_art, "K6")<=0 then
				ls_cod_art_K=wf_controlla_k4_6(i, ls_cod_art, ll_id_titolo)
				if ls_cod_art_K<>ls_cod_art then ls_cod_art=ls_cod_art_K
			end if
			ls_art_altro_titolo=""
			ls_art_altro_titolo=ls_pre_codice+ls_cod_art 
			select id_articolo
			into :ll_id_art_locale
			from dba.articolo
			where codice=:ls_art_altro_titolo  //articolo + precodice
			;
			if ll_id_art_locale>0 then //se lo trovo lo inserisco e ho finito NO! 20200727 se lunghezza>=24" o 60cm allora sii controlla se esiste proprio con quella lunghezza altrimenti si mette la lunghezza nel codice e si crea nuovo
				lb_esiste=wf_esiste_art_e_lunghezza(ll_id_art_locale, ls_art_altro_titolo, i, ll_id_titolo) //controllo se l'articolo ha lunghezza = a quella richiesta
				if lb_esiste then //se esiste già perfetto lo inserisco nella dw_8 altrimenti ha pensato la wf_controlla_lunghezza ad inserirlo
					ls_cod_art_K=wf_controlla_k4_6(i, ls_art_altro_titolo, ll_id_titolo)
					if ls_cod_art_K=ls_art_altro_titolo then 
						ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_pre_codice+ls_cod_art_pulito+"'",1, 1000000)
						if ll_riga_trovata<=0 then 
							ll_riga_inserita=dw_8.insertrow(0)
							dw_8.setitem(ll_riga_inserita, "cod_articolo",ls_art_altro_titolo )
							dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
						end if
						dw_1.setitem(i, "cod_art_assegnato", ls_art_altro_titolo)
					end if
					continue	
				end if
			else //lo creo e lo inserisco
				lb_esiste=wf_esiste_art_e_lunghezza(ll_id_art_locale, ls_cod_art, i, ll_id_titolo) //controllo se l'articolo ha lunghezza = a quella richiesta
				if lb_esiste then //se esiste già perfetto lo inserisco nella dw_8 altrimenti ha pensato la wf_controlla_lunghezza ad inserirlo
					ls_cod_art_K=wf_controlla_k4_6(i, ls_cod_art, ll_id_titolo)
					 ls_cod_art_K=ls_cod_art
					//if ls_cod_art_K=ls_cod_art then 
						ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_pre_codice+ls_cod_art_pulito+"'",1, 1000000)
						if ll_riga_trovata<=0 then 
							ll_riga_inserita=dw_8.insertrow(0)
							dw_8.setitem(ll_riga_inserita, "cod_articolo",ls_art_altro_titolo )
							dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
						end if
						dw_1.setitem(i, "cod_art_assegnato", ls_art_altro_titolo)
					//end if
				end if
			end if
		end if	
	else //l'articolo non esiste: lo inserisco
		lb_esiste=wf_esiste_art_e_lunghezza(ll_id_art_locale, ls_cod_art, i, ll_id_titolo) //controllo se l'articolo ha lunghezza = a quella richiesta
		if lb_esiste then //non è stato inserito per lunghezza occore farlo semplicemente
			ls_cod_art_K=wf_controlla_k4_6(i, ls_cod_art, ll_id_titolo)
			ls_cod_art=ls_cod_art_K  //non ha molto senso ora prima usavo la seconda variabile per confrontare ,,,
			//if ls_cod_art_K=ls_cod_art then 
				ll_id_art_locale=wf_crea_articolo(ls_cod_art, ll_id_titolo)
				if ll_id_art_locale= -100 then return -100
				ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_cod_art+"'",1, 1000000)
				if ll_riga_trovata<=0 then 
					ll_riga_inserita=dw_8.insertrow(0)
					dw_8.setitem(ll_riga_inserita, "cod_articolo",ls_cod_art )
					dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
				end if
				dw_1.setitem(i, "cod_art_assegnato", ls_cod_art)
			//end if
		end if
		//non esiste quindi inutile controllare il ritorno... ha già fatto tutto la wf_controlla_lunghezza (che richiama la wf_crea_articolo)
	end if
next
cb_salva.enabled=true

//	ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_pre_codice+ls_cod_art_pulito+"'",1, 1000000)
//	if ll_riga_trovata>0 then 	continue //se c'è già salto il giro (NO! occorre controllare la lunghezza!! Se la lunghezza è=1 occorre vedere se esiste già un'orecchino
												//se invece è >24" o 60cm allora occorre vedere se l'articolo esiste con quella misura altrimenti si crea
	
//	//l'articolo non esiste o ha titolo diverso: occorre inserirlo controllando anche di non averlo già fatto (//si guarda se c'è nella tabella di corrispondenza ? ma aspettiamo ... 01-02-20 proviamo ...)
//	if isnull(ll_id_art_locale) or ll_id_art_locale<=0 then
//		//provo a cercare l'articolo con il pre codice
//		ls_art_altro_titolo=""
//		ls_art_altro_titolo=ls_pre_codice+ls_cod_art 
//		select id_articolo
//		into :ll_id_art_locale
//		from dba.articolo
//		where codice=:ls_art_altro_titolo  //articolo + precodice
//		;
//		if ll_id_art_locale>0 then //se lo trovo lo inserisco e ho finito NO! 20200727 se lunghezza>=24" o 60cm allora sii controlla se esiste proprio con quella lunghezza altrimenti si mette la lunghezza nel codice e si crea nuovo
//			lb_esiste=wf_esiste_art_e_lunghezza(ll_id_art_locale, ls_art_altro_titolo, i, ll_id_titolo) //controllo se l'articolo ha lunghezza = a quella richiesta
//			if lb_esiste then //se esiste già perfetto lo inserisco nella dw_8 altrimenti ha pensato la wf_controlla_lunghezza ad inserirlo
//				ll_riga_trovata=dw_8.find("cod_articolo= '"+ls_pre_codice+ls_cod_art_pulito+"'",1, 1000000)
//				if ll_riga_trovata<=0 then 
//					ll_riga_inserita=dw_8.insertrow(0)
//					dw_8.setitem(ll_riga_inserita, "cod_articolo",ls_art_altro_titolo )
//					dw_8.setitem(ll_riga_inserita, "ID_ARTicolo_CORRISPONDENTE", ll_id_art_locale)
//				end if
//				continue	
//			end if
//		else //lo creo e lo inserisco
//			lb_esiste=wf_esiste_art_e_lunghezza(ll_id_art_locale, ls_cod_art, i, ll_id_titolo) //controllo se l'articolo ha lunghezza = a quella richiesta
//			if lb_esiste then messagebox("Attenzione!", "Articolo incredibile!!!!! "+ls_cod_art+" riga: "+string(i))
////			ll_id_new_art_locale=wf_controlla_lunghezza(ls_cod_art,i, ll_id_titolo)
////			if ll_id_new_art_locale>0 then 
////				ll_id_art_locale=ll_id_new_art_locale
//			//else //non è possibile: l'articolo non esiste in altro modo quindi lo crea wf_controlla_lunghezza(ls_cod_art,i, ll_id_titolo)
//			//creo articolo
//				//ll_id_art_locale=wf_crea_articolo(ls_pre_codice+ls_cod_art,ll_id_titolo )
//			//end if
//		end if
	//end if
	
//next
//cb_salva.enabled=true

end event

type dw_9 from udw_000 within w_carica_xls_copia20210823
integer x = 5298
integer y = 12
integer width = 923
integer height = 112
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_cliente_cod_barre"
end type

type pb_cerca from picturebutton within w_carica_xls_copia20210823
integer x = 6226
integer width = 142
integer height = 120
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Ricerca.png"
alignment htextalign = left!
end type

event clicked;string ls_numero, ls_filter

dw_9.accepttext()
ls_numero=dw_9.getitemstring(1, "numero")
wf_filtra(ls_numero)

end event

type cb_canc_bollettina from commandbutton within w_carica_xls_copia20210823
integer x = 1445
integer y = 824
integer width = 347
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Canc. BOL  >"
end type

event clicked;long ll_riga_corrente, ll_id_doc

ll_riga_corrente=dw_5.getrow()
if ll_riga_corrente>0 then
	ll_id_doc=dw_5.getitemnumber(ll_riga_corrente, "id_documento")
	if ll_id_doc>0 then
		delete from dba.riga_documento
		where id_documento=:ll_id_doc;
		if sqlca.sqlcode=0 then
			commit;
			delete from dba.documento
			where id_documento=:ll_id_doc;
			if sqlca.sqlcode=0 then
				commit;
				dw_5.deleterow(ll_riga_corrente)
			else
				rollback;
				messagebox("Attenzione!", "Riga "+string(ll_riga_corrente, "#,0")+" NON cancellata!")
			end if
		else
			rollback;
			messagebox("Attenzione!", "Riga "+string(ll_riga_corrente, "#,0")+" NON cancellata!")
		end if
	end if
end if


end event

type dw_10 from udw_000 within w_carica_xls_copia20210823
integer x = 4407
integer y = 12
integer width = 466
integer height = 112
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_cliente_cod_barre"
end type

event editchanged;call super::editchanged;string ls_cod_barre

if len(data) =7 then
	ls_cod_barre=right(data, 5)
	wf_filtra(ls_cod_barre)
	post setitem(1, "numero", "")
	wf_carica_des_2(row)
	post setfocus(dw_5)
	dw_5.post scrolltorow(1)
	dw_5.post setcolumn("num_progressivo")
	
end if
end event

type st_2 from statictext within w_carica_xls_copia20210823
integer x = 3941
integer y = 32
integer width = 453
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "CODICE BARRE:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_11 from udw_000 within w_carica_xls_copia20210823
integer x = 2651
integer y = 12
integer width = 727
integer height = 108
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_data_bol_lista"
end type

type pb_carica from picturebutton within w_carica_xls_copia20210823
integer x = 3383
integer width = 142
integer height = 120
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\nita\icone\Ricerca.png"
alignment htextalign = left!
end type

event clicked;datetime ldt_data
date ldt_data_per_anno
datastore ds_bol_excel
long ll_righe, ll_id_riga, ll_id_doc, ll_riga
integer i, li_anno
string ls_num_doc



ds_bol_excel=create datastore
ds_bol_excel.dataobject="d_bol_excel_ra_solo_b"
ds_bol_excel.settransobject(sqlca)

dw_11.accepttext()
ldt_data=dw_11.getitemdatetime(1, "datatempo") //ldt_data=dw_11.getitemdatetime(1, "data")
if ldt_data>datetime(date("2000-01-01"), now()) then
	ll_righe=ds_bol_excel.retrieve(ldt_data)
	if ll_righe>0 then dw_5.reset()
	for i= 1 to ll_righe
		ll_id_riga=0
		ll_id_riga=ds_bol_excel.getitemnumber(i, "id_riga_documento")
		if ll_id_riga>0 then
			ll_id_doc=0
			select id_documento
			into :ll_id_doc
			from dba.riga_documento
			where id_riga_documento=:ll_id_riga
			;
			ll_riga=dw_5.retrieve(ll_id_doc)
			wf_carica_des_2(ll_riga)
		else
			ls_num_doc=right(ds_bol_excel.getitemstring(i, "cliente"), 4)
			if left(ls_num_doc, 1)="0" then ls_num_doc=right(ls_num_doc, 3)
			ls_num_doc+="-"+right(ds_bol_excel.getitemstring(i, "cod_barre"), 5) 
			ldt_data_per_anno=date(ldt_data)
			li_anno=year(ldt_data_per_anno)
				ll_id_doc=0
				select id_documento
				into :ll_id_doc
				from dba.documento
				where num_documento=:ls_num_doc
				and year(data_documento)=:li_anno
				;
				if ll_id_doc>0 then
					ll_riga=dw_5.retrieve(ll_id_doc)	
					wf_carica_des_2(ll_riga)
				end if
		end if
	next
end if
destroy ds_bol_excel
end event

type dw_4 from udw_base within w_carica_xls_copia20210823
boolean visible = false
integer x = 2427
integer y = 1516
integer width = 3415
integer height = 332
integer taborder = 20
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
end type

type cb_prezzo from commandbutton within w_carica_xls_copia20210823
integer x = 3543
integer y = 12
integer width = 366
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Rec. Prezzo"
end type

event clicked;integer i


for i= 1 to dw_5.rowcount()
	wf_trova_prezzo(i)
	wf_carica_des_2(i)
next
end event

type dw_5 from udw_base within w_carica_xls_copia20210823
integer x = 1815
integer y = 140
integer width = 5449
integer height = 2132
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_bol_create_gd"
boolean hscrollbar = true
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

event buttonclicked;call super::buttonclicked;if dwo.name="b_salva" then
	post wf_salva_progressivo(row)
	wf_salva_des_2(row)
	post setfocus(dw_10)
	dw_10.scrolltorow(1)
end if
end event

event itemchanged;call super::itemchanged;long ll_id_uc, ll_id_art, ll_id_variazione
string ls_des, ls_des_old,ls_des2
decimal ldc_prezzo, ldc_pr_man
date ldt_data
integer li_pos

ll_id_art=long(data)
choose case dwo.name
	case 'id_articolo' 
		select id_unita_confezione
		into :ll_id_uc
		from dba.unita_confezione
		where id_articolo= :ll_id_art
		and unita_base='S'
		;
		if ll_id_uc>0 then
			setitem(row, "id_unita_confezione", ll_id_uc)
			select des_2 into :ls_des2 from dba.prezzo where id_unita_confezione=:ll_id_uc and id_variazione=15;
			setitem(row, "c_des_2", ls_des2)
		else
			messagebox("Attenzione!", "Unita confezione per riga "+string(row)+" NON trovata!") 
		end if
		select descrizione
		into :ls_des
		from dba.articolo
		where id_articolo=:ll_id_art
		;
		ls_des_old=getitemstring(row, "descrizione")
		li_pos=pos(ls_des_old, "-")
		if li_pos>0 then
			ls_des+=right (ls_des_old, len(ls_des_old) - (li_pos - 1)) //inserisco anche il trattino (-)
		end if
		
		setitem(row, "descrizione", ls_des)
		wf_trova_prezzo(row)
	case "num_progressivo"
		
	//	post wf_salva_e_torna_cod_barre(row)
		
		
end choose
end event

event retrievestart;call super::retrievestart;return 2
end event

event rbuttondown;call super::rbuttondown;if dwo.name="b_salva" then
	post wf_salva_descrizione(row)
	post wf_salva_progressivo(row) //questo fa sparire la riga: tienilo sempre per ultimo
	
end if
end event

event editchanged;call super::editchanged;string ls_dato, ls_azienda
long ll_num_prog

select codice
into :ls_azienda
from dba.azienda
where id_azienda=1
;
if dwo.name="descrizione" and ls_azienda="SILVERDR" then
	if pos(data, "-|-")<=0 then
		ls_dato=left(data, len(data) - 1)
		ls_dato+="  -|- "
		setitem(row, "descrizione", ls_dato)
		
		keybd_event(35,0,0,0) // END Depressed
		
		keybd_event(35,0,2,0) // END Released (Can be omitted) 
		
		
	end if
	
end if
IF dwo.name="num_progressivo" and KeyDown(KeyAdd!) THEN
	ll_num_prog=long(left(data, len(data) - 1))
	if ll_num_prog>0 then 
		setitem(row, "num_progressivo", ll_num_prog)
		trigger event buttonclicked(row, 2, object.b_salva)
	end if
		
end if
end event

event retrieveend;call super::retrieveend;integer i
long ll_id_art, ll_id_art_1
string ls_des_2

for i=1 to rowcount - 1
	ls_des_2=getitemstring(i, "c_des_2")
	ll_id_art=getitemnumber(i, "id_articolo")
	ll_id_art_1=getitemnumber(i+1, "id_articolo")
	if ls_des_2='$' and  ll_id_art <> ll_id_art_1 then
		setitem(i, "des_contabile", "#")
		//		rgb(255, 255, 0)
	else 
		//rgb(255,255,255))
	end if
next
end event

type cb_bol_50000 from commandbutton within w_carica_xls_copia20210823
integer x = 4974
integer y = 12
integer width = 206
integer height = 100
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "50000"
end type

event clicked;long ll_max
open(w_bol_50000)
if isvalid(message) then
	ll_max=message.doubleparm
	messagebox("MAX", ll_max)
end if
end event

type dw_8 from udw_001 within w_carica_xls_copia20210823
integer x = 37
integer y = 948
integer width = 1769
integer height = 1316
integer taborder = 60
string dataobject = "dw_corr_cod_articolo_gd"
boolean vscrollbar = true
end type

event buttonclicked;call super::buttonclicked;string ls_codice, ls_cod_articolo, ls_metallo,  ls_num_doc, ls_cliente,ls_data,ls_pre_codice
long ll_riga_trovata, ll_id_art_locale[],  ll_null, ll_id_art, ll_riga[], ll_id_variazione
long ll_id_um, ll_riga_uc, ll_id_uc, ll_riga_trovata_uc,ll_riga_inserita, ll_id_titolo,ll_id_titolo_locale
integer i, a, li_ret
datetime ldt_data
decimal ldc_titolo
setnull(ll_null)
datawindowchild dwc_id_art
//string ls_azienda

if dwo.name="b_crea_articoli" then
	dw_8.getchild("id_articolo_corrispondente", dwc_id_art)
	dwc_id_art.settransobject(sqlca)
	for i = 1 to dw_8.rowcount()
		ll_id_art=0
		ll_id_art=dw_8.getitemnumber(i, "id_articolo_corrispondente")
		ls_cod_articolo=dw_8.getitemstring(i, "cod_articolo")
		//devo trovare il titolo dell'articolo, quindi vado nella dw_1, lo ricerco e trovo il titolo
		ll_riga_trovata=dw_1.find("articolo='"+ls_cod_articolo+"'", 1, dw_1.rowcount())
		if ll_riga_trovata>0 then
			ls_metallo=dw_1.getitemstring(ll_riga_trovata, "metallo")
			//se il metallo è BD il codice corrispondente è "SI"
			//if pos(upper(ls_azienda), "SILVER")>0 then 
				if trim(ls_metallo)='BD' then 
					ls_metallo='SI'
					ll_id_titolo=26
					ls_pre_codice='s'
				elseif ls_metallo='BZ' then
					ll_id_titolo=25
					ls_pre_codice='b'
				elseif  ls_metallo='OT' then
					ll_id_titolo=24
					ls_pre_codice='o'
				else
					ldc_titolo=dw_1.getitemdecimal(ll_riga_trovata, "titolo")
					ll_id_titolo=0
					select id_titolo into :ll_id_titolo
					from dba.orafo_metallo m, dba.orafo_titolo t
					where m.id_metallo=t.id_metallo
					and m.codice=:ls_metallo and t.titolo=:ldc_titolo;		
				end if				
				//prendo cliente e num_bollettina li metto su num_:doc
				ls_cliente=dw_1.getitemstring(ll_riga_trovata, "cliente") 
				ls_num_doc=right(dw_1.getitemstring(ll_riga_trovata, "cliente"), 4)
				if left(ls_num_doc, 1)="0" then ls_num_doc=right(ls_num_doc, 3)//ho corretto i numeri iniziali possono essere anche solo 3 quindi occorre prender le lettere prima del "-" 04-02-2020
				if left(ls_num_doc, 1)="0" then ls_num_doc=right(ls_num_doc, 2)//possono essere anche solo 2
				ls_num_doc+="-"+right(dw_1.getitemstring(i, "cod_barre"), 5) 
			//end if
		end if
		if isnull(ll_id_art)or ll_id_art=0 then
			select id_articolo, id_titolo //controllo se per caso esiste questo articolo (ma l'ho già fatto, è solo perdita di tempo ...)
			into :ll_id_art, :ll_id_titolo_locale
			from dba.articolo where codice=:ls_cod_articolo;
			if ll_id_art>0 then //tutto sciocco, ma una volta è servito ... tanto non succede più, si toglie fra un po' di tempo 05-03-2020
				if ll_id_titolo_locale=ll_id_titolo then
					dw_8.setitem(i, "id_articolo_corrispondente", ll_id_art)
					ls_pre_codice=""
					setnull(ll_id_art)
					continue
				end if
			end if
				
			//else
				a++
				
				if isnull(ll_id_titolo) or ll_id_titolo=0 then 
					messagebox("Attenzione!", "NON HO POTUTO IDENTIFICARE IL TITOLO DELL'ARTICOLO: "+ls_cod_articolo+" - Metto 'AG925'!")
					ll_id_titolo=4
				end if
				dw_6.reset()
				//dw_7.reset()
				ll_riga_inserita=dw_6.insertrow(1)
				dw_6.setitem(ll_riga_inserita, "id_articolo", ll_null)
				dw_6.setitem(ll_riga_inserita, "codice", ls_cod_articolo)  //+"-"+ls_cliente) //13-03-2020 aggiungo al codice articolo il codice cliente NO l'ho già aggiunto in "carica xls"
				
				dw_6.setitem(ll_riga_inserita, "descrizione", ls_cod_articolo)
				dw_6.setitem(ll_riga_inserita, "des_breve", ls_cod_articolo)
				dw_6.setitem(ll_riga_inserita, "id_cat_codifica", 66) //è cat_codifica creata all'uopo "AUTO"
				dw_6.setitem(ll_riga_inserita,"id_sog_comm_variante", ll_null)
				dw_6.setitem(ll_riga_inserita,"id_cat_com_articolo", 8) //è ARG
				dw_6.setitem(ll_riga_inserita,"id_titolo", ll_id_titolo) //AG925 =4  BD 100=SI 1000 (l'ha deto Samy)= 26
				dw_6.setitem(ll_riga_inserita,"coef_calo",1000) //deve essere sempre 1000 ????
				dw_6.setitem(ll_riga_inserita,"immagine", ls_cod_articolo+".jpg")
				dw_6.setitem(ll_riga_inserita,"nota", "Art. da EXCEL")
				dw_6.setitem(ll_riga_inserita,"id_unita_conf_base", 2) // con questa crea da se unita_conf a PZ
				dw_6.setitemstatus(ll_riga_inserita, 0, Primary!, NewModified!)
				dw_6.trigger event ue_update()
				
				ll_id_art_locale[a]=dw_6.getitemnumber(1, "id_articolo")
				ll_riga[a]=i
				select id_unita_confezione
				into :ll_id_uc
				from dba.unita_confezione
				where id_articolo=:ll_id_art_locale[a] and unita_base='S';

				if ll_id_uc> 0 then //inserisco l'articolo sulla tb prezzo nel listino/variazione corretta
					ldt_data=dw_1.getitemdatetime(1, "data")
					ls_data="AUTO_XLS "+string(ldt_data, "dd_mm_yy")
					ll_id_variazione=0
					select id_variazione 
					into :ll_id_variazione from dba.variazione
					where id_listino=17 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
					insert into dba.prezzo (id_variazione, id_unita_confezione, des_1)
					values (:ll_id_variazione, :ll_id_uc, :ls_data);
						if sqlca.sqlNrows>0 then
						commit;
					else
						rollback;
						//messagebox("Attenzione!", "Articolo: "+ls_cod_articolo+" NON inserito in listino BASE VENDITA!")
					end if
					select id_variazione 
					into :ll_id_variazione from dba.variazione
					where id_listino=18 and data_inizio<=:ldt_data and data_fine>=:ldt_data;
					insert into dba.prezzo (id_variazione, id_unita_confezione, des_1, des_3)
					values (:ll_id_variazione, :ll_id_uc, :ls_data,:ls_num_doc )
					;
					if sqlca.sqlNrows>0 then
						commit;
					else
						rollback;
						messagebox("Attenzione!", "Articolo: "+ls_cod_articolo+" NON inserito in listino KAR!")
					end if
				else
					messagebox("Attenzione!", "Unita Confezione art.: "+ls_cod_articolo+" NON inserita!")
				end if
			//end if
			
		end if
	next
	
	for i=1 to upperbound(ll_id_art_locale)
		setitem(ll_riga[1], "id_articolo_corrispondente", ll_id_art_locale[1])
	next
	dwc_id_art.post retrieve()
end if
	
end event

type cb_carica_old from commandbutton within w_carica_xls_copia20210823
integer x = 1449
integer y = 156
integer width = 338
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CE OLD"
end type

event clicked;
integer li_ret
string ls_path, ls_file, ls_num_doc
integer i, li_riga_inserita
string ls_dati, ls_imp, ls_pezzi, ls_cod_numerico, ls_metallo, ls_tipo
string ls_cod_barre, ls_cliente,   ls_des, ls_galv, ls_art, ls_test
datetime ldt_data
long ll_num, ll_id_tab_iva, ll_pezzi, ll_id_art
decimal ldc_qta, ldc_peso, ldc_titolo, ldc_inch
boolean lb_esiste
	
getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc")
if  not(trim(ls_file)="" or isnull(ls_file)) then
	ole_1.open(ls_path)
	ls_file=left(ls_path, len(ls_path) - 3)+"txt"
	if fileexists(ls_file) then FileDelete(ls_file)
	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_2.importfile(Text!,ls_file)

end if	 

dw_1.reset()

ldt_data=datetime(date(dw_2.getitemstring(10, "A08")), now())
for i = 1 to dw_2.rowcount() 
	ls_test=""
	ls_test=dw_2.getitemstring(i, "A01")
	if integer(ls_test)>0 then
		ls_cod_barre=""
		ls_cod_barre=dw_2.getitemstring(i, "A17")
		if ls_cod_barre> "0" then
			ls_cliente=""
			ls_cliente=dw_2.getitemstring(i, "A19")
			ls_des=""
			ls_des=dw_2.getitemstring(i+2, "A03")
			if pos(upper(ls_des), "RESO")>0 then ls_tipo='R' else ls_tipo="B"
			li_ret=wf_controlla_se_esistente(ls_cliente, ls_cod_barre, ls_tipo)
			if li_ret=0 then continue // se esiste già la chiave primaria NON carico il record, lo salto
			
			ll_pezzi=0
			ll_pezzi=long(dw_2.getitemstring(i, "A25"))
			ldc_peso=0
			ldc_peso=dec(dw_2.getitemstring(i, "A28"))
			ls_art=""
			ls_art=dw_2.getitemstring(i, "A06")+" "+dw_2.getitemstring(i, "A13") //cerca se esiste in caso negativo chiedi di associarlo con id_art in nita
			ls_art=f_togli_spazi_doppi(ls_art)
			//ll_id_art=wf_articolo(ls_art)
			ls_galv=""
			ls_galv=dw_2.getitemstring(i, "A05")
			ls_metallo=""
			ls_metallo=dw_2.getitemstring(i, "A03")
			ldc_titolo=0
			ldc_titolo=dec(dw_2.getitemstring(i, "A04"))
			lb_esiste=wf_esiste_galvanica(ls_galv)
			if not(lb_esiste) then ls_galv=""
			
				//inserisco
			li_riga_inserita=dw_1.insertrow(0)
			//23-06-2020 se l'articolo è ges_matricole='S' allora devo recuperare anche la lunghezza! la fuznione rutrna true se devo caricare lunghezza
			//if wf_rec_lunghezza( ls_art+"-"+ls_cliente) then
//				ldc_inch=dec(dw_2.getitemstring(i, "A04????")) //inserire un campo in più nella dw_2!!!!
//				dw_1.setitem(li_riga_inserita, "dim_l_inch", ldc_inch)
			//end if
			//23-06-2020 fine
			dw_1.setitem(li_riga_inserita, "cod_barre", ls_cod_barre)
			dw_1.setitem(li_riga_inserita, "cliente", ls_cliente)
			dw_1.setitem(li_riga_inserita, "pezzi", ll_pezzi)
			dw_1.setitem(li_riga_inserita, "peso", ldc_peso)
			dw_1.setitem(li_riga_inserita, "articolo", ls_art+"-"+ls_cliente)
			if len(ls_des)>255 then
				ls_des= left(ls_des, 255)
			end if
			dw_1.setitem(li_riga_inserita, "descrizione", ls_des)
			dw_1.setitem(li_riga_inserita, "data", ldt_data)
			dw_1.setitem(li_riga_inserita, "galvanica", ls_galv)
			//20200617 cambio perché da Vicenza mandano file xls con numerazione che riparte da 1 anche 3-4volte e il numero riga è parte del mio indice 
			//dw_1.setitem(li_riga_inserita, "num_riga", integer(ls_test))
			dw_1.setitem(li_riga_inserita, "num_riga", li_riga_inserita )
			//fine 20200617
			dw_1.setitem(li_riga_inserita, "metallo", ls_metallo)
			dw_1.setitem(li_riga_inserita, "titolo", ldc_titolo)
			dw_1.setitem(li_riga_inserita, "tipo", ls_tipo)
		end if
	end if
next
dw_2.sort()
cb_controlla_articoli.enabled=true
//
//
end event

type ole_1 from olecontrol within w_carica_xls_copia20210823
event queryinterface ( oleobject riid,  ref pointer ppvobj )
event addref ( )
event release ( )
event selectionchange ( oleobject target )
event beforedoubleclick ( oleobject target,  boolean cancel )
event beforerightclick ( oleobject target,  boolean cancel )
event activate ( )
event deactivate ( )
event calculate ( )
event change ( oleobject target )
integer x = 1454
integer y = 640
integer width = 320
integer height = 140
integer taborder = 50
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_carica_xls_copia20210823.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type dw_7 from udw_000 within w_carica_xls_copia20210823
integer x = 1449
integer y = 636
integer width = 338
integer height = 172
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_data_xls"
end type

type cb_1 from commandbutton within w_carica_xls_copia20210823
integer x = 2373
integer y = 12
integer width = 224
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset"
end type

event clicked;
if messagebox("Attenzione!", "Si azzera tutto! Hai salvato?", stopsign!,yesno!)=1 then
	dw_1.reset()
	dw_2.reset()
	dw_3.reset()
	dw_4.reset()
	dw_5.reset()
	dw_6.reset()
end if
	
end event

type dw_2 from udw_000 within w_carica_xls_copia20210823
integer x = 55
integer y = 2308
integer width = 4599
integer height = 1316
integer taborder = 50
string dataobject = "d_EXT_PER_IMPORT"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_2 from commandbutton within w_carica_xls_copia20210823
boolean visible = false
integer x = 5435
integer y = 2464
integer width = 343
integer height = 352
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "dd"
end type

event clicked;dw_6.trigger event ue_update()
end event

