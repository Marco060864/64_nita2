forward
global type w_bol_accessori from w_001
end type
type dw_3 from udw_base within w_bol_accessori
end type
type cb_1 from commandbutton within w_bol_accessori
end type
type rb_2018 from radiobutton within w_bol_accessori
end type
type rb_2019 from radiobutton within w_bol_accessori
end type
type rb_2020 from radiobutton within w_bol_accessori
end type
type rb_2021 from radiobutton within w_bol_accessori
end type
type cb_crea_accessori from commandbutton within w_bol_accessori
end type
type dw_4 from udw_001 within w_bol_accessori
end type
type cb_inserisci from uo_commandbutton within w_bol_accessori
end type
type cb_salva from uo_commandbutton within w_bol_accessori
end type
type cb_cancella from uo_commandbutton within w_bol_accessori
end type
type cb_ricalcola_gruppo from commandbutton within w_bol_accessori
end type
type rr_1 from roundrectangle within w_bol_accessori
end type
type dw_1 from udw_base within w_bol_accessori
end type
type dw_2 from udw_base within w_bol_accessori
end type
type dw_5 from udw_000 within w_bol_accessori
end type
type cb_crea_sald from commandbutton within w_bol_accessori
end type
type dw_6 from udw_000 within w_bol_accessori
end type
type cb_st_dw_2 from commandbutton within w_bol_accessori
end type
type cb_2 from commandbutton within w_bol_accessori
end type
type cb_4 from commandbutton within w_bol_accessori
end type
type cb_3 from commandbutton within w_bol_accessori
end type
type cb_5 from commandbutton within w_bol_accessori
end type
type dw_7 from udw_001 within w_bol_accessori
end type
type cb_6 from commandbutton within w_bol_accessori
end type
type cb_reset_filtro from commandbutton within w_bol_accessori
end type
type cb_7 from commandbutton within w_bol_accessori
end type
type cb_accantona from commandbutton within w_bol_accessori
end type
type cb_9 from commandbutton within w_bol_accessori
end type
type cb_10 from commandbutton within w_bol_accessori
end type
type cb_8 from commandbutton within w_bol_accessori
end type
type rb_2022 from radiobutton within w_bol_accessori
end type
type cb_11 from commandbutton within w_bol_accessori
end type
type cb_12 from commandbutton within w_bol_accessori
end type
type cb_13 from commandbutton within w_bol_accessori
end type
type ole_1 from olecontrol within w_bol_accessori
end type
type dw_8 from udw_001 within w_bol_accessori
end type
type cb_14 from commandbutton within w_bol_accessori
end type
type cb_15 from commandbutton within w_bol_accessori
end type
type dw_9 from udw_000 within w_bol_accessori
end type
type cb_16 from commandbutton within w_bol_accessori
end type
type cb_estensione_tag from commandbutton within w_bol_accessori
end type
end forward

global type w_bol_accessori from w_001
boolean visible = false
integer x = 1057
integer y = 483
integer width = 5472
integer height = 2932
string title = "Fabbisogno Accessori"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_3 dw_3
cb_1 cb_1
rb_2018 rb_2018
rb_2019 rb_2019
rb_2020 rb_2020
rb_2021 rb_2021
cb_crea_accessori cb_crea_accessori
dw_4 dw_4
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_ricalcola_gruppo cb_ricalcola_gruppo
rr_1 rr_1
dw_1 dw_1
dw_2 dw_2
dw_5 dw_5
cb_crea_sald cb_crea_sald
dw_6 dw_6
cb_st_dw_2 cb_st_dw_2
cb_2 cb_2
cb_4 cb_4
cb_3 cb_3
cb_5 cb_5
dw_7 dw_7
cb_6 cb_6
cb_reset_filtro cb_reset_filtro
cb_7 cb_7
cb_accantona cb_accantona
cb_9 cb_9
cb_10 cb_10
cb_8 cb_8
rb_2022 rb_2022
cb_11 cb_11
cb_12 cb_12
cb_13 cb_13
ole_1 ole_1
dw_8 dw_8
cb_14 cb_14
cb_15 cb_15
dw_9 dw_9
cb_16 cb_16
cb_estensione_tag cb_estensione_tag
end type
global w_bol_accessori w_bol_accessori

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
boolean ib_gia_creati=false
integer ii_sort
end variables

forward prototypes
public subroutine wf_aggiungi ()
public subroutine wf_stampa_video ()
public subroutine wf_ins_righe_doc ()
public subroutine wf_inserisci_in_lista (string as_accessorio, long al_row, string as_flag, long al_id_art)
public subroutine wf_aggiungi_tag ()
end prototypes

public subroutine wf_aggiungi ();string ls_des_accessori, ls_singolo_acc, ls_bollo, ls_bollo_ok,ls_cod_art, ls_des_libera
integer li_pos, i, a
long ll_id_art

for i=1 to dw_4.rowcount()
	li_pos=0
	ls_des_accessori=""
	a=0
	ls_cod_art=dw_4.getitemstring(i, "articolo")
	select id_articolo into :ll_id_art from dba.articolo where codice =:ls_cod_art;
	ls_des_accessori=dw_4.getitemstring(i, "cod_accessori_k_descrizione")
	if len(ls_des_accessori)>0 then
		li_pos=pos(ls_des_accessori, "+")
		ls_singolo_acc=mid(ls_des_accessori, a, li_pos - 1)
		wf_inserisci_in_lista(ls_singolo_acc, i, "A", ll_id_art)
		do while li_pos>0
			a=li_pos+1
			li_pos=pos(ls_des_accessori, "+", li_pos+1)
			ls_singolo_acc=mid(ls_des_accessori, a, li_pos  - a)
			wf_inserisci_in_lista(ls_singolo_acc, i, "A", ll_id_art)
			//li_pos=pos(ls_des_accessori, "+", li_pos+1)
		loop
		ls_singolo_acc=right(ls_des_accessori, len(ls_des_accessori) - a+1)
		wf_inserisci_in_lista(ls_singolo_acc, i, "A", ll_id_art)
	end if
//	//per il bollo recupero le mb o le fp, ft...
//	ls_bollo=dw_4.getitemstring(i, "c_bollo")
//	if len(ls_bollo)>0 then
//		li_pos=pos(upper(ls_bollo), "BOLLO")
//		if li_pos>0 then
//			ls_bollo_ok=left(ls_bollo, li_pos - 1)
//			wf_inserisci_in_lista(ls_bollo_ok, i, "B")
//		end if
//	end if
next
end subroutine

public subroutine wf_stampa_video ();integer i, li_pos
string ls_accessorio, ls_bollo
decimal ldc_tot_pezzi, ldc_perc, ldc_peso
long ll_riga, ll_breakrow
boolean lb_found

dw_2.sort()
dw_2.groupcalc()
dw_5.reset()
//dw_2.trigger event ue_update()
dw_2.setsort("accessorio")
dw_2.sort()
cb_ricalcola_gruppo.triggerevent(clicked!)
//for i= 1 to dw_2.rowcount()
////	ls_accessorio=dw_2.getitemstring(i, "accessorio")
////	ldc_tot_pezzi=dw_2.getitemdecimal(i, "c_tot_pezzi")
////	ll_riga=dw_5.insertrow(0)
////	dw_5.setitem(ll_riga, "accessorio", ls_accessorio)
////	dw_5.setitem(ll_riga, "qta", ldc_tot_pezzi)
//next

lb_found = false
ll_breakrow = -1
DO    
	ll_breakrow = ll_breakrow + 1
	ll_breakrow = dw_2.FindGroupChange(ll_breakrow, 1)    
	if ll_breakrow<=0 then exit  // If no breaks are found, exit.    
	ls_accessorio=dw_2.getitemstring(ll_breakrow, "accessorio")
	//28/12/2020a volte è troppo lungo e quindi lo divido
	if len(ls_accessorio)>=24 then
		li_pos=pos(ls_accessorio, " ")
		if li_pos>0 then
			ls_accessorio=left(ls_accessorio, li_pos -1)+"~r~n"+right(ls_accessorio, len(ls_accessorio) - li_pos)
		else
			ls_accessorio=left(ls_accessorio, 20)+"~r~n"+right(ls_accessorio, len(ls_accessorio) - 20)
		end if
	end if //fine divisione
	ldc_tot_pezzi=dw_2.getitemdecimal(ll_breakrow, "c_tot_gruppo")
	ls_bollo=dw_2.getitemstring(ll_breakrow, "c_bollo") //20240323 riporto il bollo in stampa dw_5 per ordine
	ll_riga=dw_5.insertrow(0)
	dw_5.setitem(ll_riga, "accessorio", ls_accessorio)
	dw_5.setitem(ll_riga, "bollo", ls_bollo) //20240323 per ordinare per bollo ho bisogno di inserirlo da solo....
	//20231113 si guarda la acc_da_sald_no_sald per vedere se c'è una perc diversa...
//	ldc_perc=3
	select perc_ricarico into :ldc_perc from dba.acc_da_sald_no_sald where acc_da_sald_no_sald=:ls_accessorio;
	if ldc_perc<=0 or isnull(ldc_perc) then ldc_perc=3
	//20231113 fine
	ldc_peso=dw_2.getitemdecimal(ll_breakrow, "peso_uni_accessorio")
	dw_5.setitem(ll_riga, "qta", ldc_tot_pezzi+ldc_tot_pezzi*ldc_perc/100) //aumento del 3% 20200930 samy
	if ldc_peso>0 then dw_5.setitem(ll_riga, "peso", (ldc_tot_pezzi+ldc_tot_pezzi*ldc_perc/100) *ldc_peso )
LOOP WHILE ll_breakrow > 0


end subroutine

public subroutine wf_ins_righe_doc ();//datastore ds_copia
//ds_copia=create datastore
//ds_copia.dataobject="d_orafo_riga_documento_ordine_silver_gd"
//ds_copia.settransobject(sqlca)
////
//
//idw_gen.setitem(1, "id_prof_documento", 130) // è il SALD
//idw_gen.triggerevent ("ue_set_prof_fields")
//idw_gen.setitem(1, "id_sog_commerciale", idw_master.is_list.l_id_riga[2])
//idw_gen.triggerevent ("ue_set_sog_fields")
//ib_askforsave=FALSE	
//li_ret=idw_gen.trigger event ue_update(0,0)
////idw_riga.reset()
//for i= 3 to upperbound( idw_master.is_list.l_id_riga)  //nelle dispari c'è l'id_doc
//	//ll_riga=idw_riga.retrieve( idw_master.is_list.l_id_riga[i])
//	//nelle bollettine silver c'è una (1) sola riga, quindi con il retrieve per id_doc tiro su quella e basta 2020-10-25
//	ll_riga=ds_copia.retrieve( idw_master.is_list.l_id_riga[i])
//	//quindi la copio sulla riga attuale
//	li_ret=ds_copia.rowscopy(1, 1, primary!, idw_riga, 1, primary!)
//	//ds_copia.reset()
//next
//
//ll_id_doc=idw_gen.getitemnumber(1, "id_documento")
//if ll_id_doc>0 then
//	for i=1 to idw_riga.rowcount()
//		
//		ll_id_bol[i]=idw_riga.getitemnumber(i, "id_documento")
//		ll_id_riga_bol=0
//		//recupero id_riga della bollettina padre di questa riga
//		//ll_id_riga_bol=idw_riga.getitemnumber(i, "id_riga_documento")
//		//poi annullo il campo per predisporre salvataggio della nuova riga "sald"
//		li_ret=idw_riga.setitem(i, "id_riga_documento", ll_null)
//		idw_riga.setitem(i, "id_documento", ll_id_doc) //canbio id doc, causale e magazzino
//		idw_riga.setitem(i, "id_locazione_1", 1)
//		idw_riga.setitem(i, "riga_documento_id_caus_magazzino", 55)
//		idw_riga.setitem(i, "riga_documento_num_riga", i)
//		//inserisco il legame con la bollettina //NOOOO il legame è attraverso "produzione2011" vedi sotto ma lo tengo per retrocompatibilità
//		idw_riga.setitem(i, "riga_documento_provv_imp_subage_2", ll_id_riga_bol)
//		//azzero eventuali qta_evase
//		idw_riga.setitem(i, "qta_evasa", 0)
//		idw_riga.setitem(i, "qta_evasa_un_base", 0)
//		idw_riga.setitem(i, "peso_netto_evaso", 0)
//		
////		ldw_status=idw_riga.getitemstatus(i, 0, primary!)
////		idw_riga.setitemstatus(i, 0, primary!, newmodified!)
//	next
//	//lego il tutto al doc bollettina padre
//	//prima salvo per avere il nuovo id_riga_doc del sald
//	idw_master.triggerevent("ue_update")
//	for i=1 to  idw_riga.rowcount()
//		ll_id_new_riga=idw_riga.getitemnumber(i, "id_riga_documento")
//		insert into dba.produzione_2011 (id_bollettina, id_doc_produzione)
//		values (:ll_id_bol[i], :ll_id_new_riga);
//		if sqlca.sqlcode=0 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "Bol non legata a riga")
//		end if
//	next
end subroutine

public subroutine wf_inserisci_in_lista (string as_accessorio, long al_row, string as_flag, long al_id_art);//arriva 2AN8 la prima lettera è la qta in cui è presente in distinta (in questo caso per fare 1 pezzo occorrono 2 an8)
integer li_qta, li_pezzi, li_pos, i, A
string ls_cod_accessorio, ls_appoggio,ls_bollo, ls_num_bollo, ls_num_bollettina,ls_des_libera, ls_cliente
string ls_da_saldare,ls_cl_da_saldare, ls_acc_sostituto, ls_acc_aggiunto,ls_ext, ls_accessorio, ls_acc_peso, ls_tg
long ll_riga, ll_riga_bol_prov, ll_id_doc_sald, ll_test, ll_id_art_eccezione, ll_id_cliente, ll_id_acc_da_saldare, ll_riga_acc_2,ll_NO_sald
datetime ldt_data
boolean lb_eccezione=true
decimal ldc_peso

if as_accessorio> "  " then
	if as_flag='A' then
		as_accessorio=trim(as_accessorio)  //tolgo eventuali spazi iniziali e finali
		li_qta=integer(left(as_accessorio, 1))
		if isnull(li_qta) or li_qta=0 then li_qta=1
	elseif as_flag='B' then
		li_qta=1
	end if
	ldt_data=datetime(today(), now())
	if li_qta>0 then
		ll_riga_bol_prov=dw_4.getitemnumber(al_row, "id_riga_documento")
		ls_num_bollettina=dw_4.getitemstring(al_row, "cliente")
		ls_num_bollettina+="-"+right(dw_4.getitemstring(al_row, "cod_barre"), 5)
		ll_riga=dw_2.insertrow(0)
		dw_2.setitem(ll_riga, "qta_distinta",li_qta )
		dw_2.setitem(ll_riga, "c_num_bol", ls_num_bollettina)
		//20250203 se c'è Exx o Txx nelle ultime 3 lettere del CODICE ACCESSORIO c'è una E e un numero (1, 2 22, 34)  allora prendo il peso
		ls_accessorio=dw_4.getitemstring(al_row, "accessorio")
		if pos(right(ls_accessorio, 3), "E")>0 then
			if mid(ls_accessorio, len(ls_accessorio) - 2, 1)="E" then
				ls_ext=mid(ls_accessorio, len(ls_accessorio) - 2, 3)
			elseif mid(ls_accessorio, len(ls_accessorio) - 1, 1)="E" then
				ls_ext=mid(ls_accessorio, len(ls_accessorio) - 1, 2)
			end if
			if pos(ls_ext, "E")>0 then //potrebbe essere un controllo pleonastico, ma ....
				select peso into :ldc_peso from dba.estensione_tag where cod_est_tag=:ls_ext;
				if ldc_peso>0 then
					dw_2.setitem(ll_riga, "peso_uni_accessorio", ldc_peso)
				end if
			end if
		end if
		//20250303 si recupera il peso anche del TG (TAG)
		if pos(upper(ls_accessorio), "TG")>0 then
			li_pos=pos(upper(ls_accessorio), "TG")
			if isnumber(mid(ls_accessorio, li_pos +2, 1)) then
				if 	isnumber(mid(ls_accessorio, li_pos +3, 1)) then
					ls_tg=mid(ls_accessorio, li_pos, 4)
				else
					ls_tg=mid(ls_accessorio, li_pos, 3)
				end if
			end if
		end if
		select peso into :ldc_peso from dba.estensione_tag where cod_est_tag=:ls_tg; //mette peso unitario 20250303
		if ldc_peso>0 then
			dw_2.setitem(ll_riga, "peso_uni_accessorio", ldc_peso)
		end if
		//20250303 FINE
		 //20250220 potrebbe essere interessante portare su il peso anche per gli altri accessori...
		//Francesco mi prepara un file excel con codice accessorio (CHR, MB5, AN8...) con accanto il peso unitario)
		ls_acc_peso=right(as_accessorio, len(as_accessorio) - 1)
		ldc_peso=0
		select acc_peso into :ldc_peso from dba.acc_peso where acc_codice=:ls_acc_peso;   //20250220
		if ldc_peso>0 then
			dw_2.setitem(ll_riga, "peso_uni_accessorio", ldc_peso)
		end if
		//20250220 fine
		
		//inserisco l'id_doc_sald
		select d.id_documento
		into :ll_id_doc_sald
		from dba.documento d, riga_documento r
		where r.id_documento=d.id_documento and r.id_riga_documento=:ll_riga_bol_prov
		;
		if ll_id_doc_sald>0 then 	dw_2.setitem(ll_riga, "id_doc_sald",ll_id_doc_sald )
		li_pezzi=dw_4.getitemnumber(al_row, "pezzi")
		//samy 30092020 aumentare il numero dei PZ necessari del 3% no lo faccio direttamnte nella dw
		dw_2.setitem(ll_riga, "qta",li_pezzi) //+li_pezzi*3/100 )
		ll_riga_bol_prov=dw_4.getitemnumber(al_row, "id_riga_documento")
		dw_2.setitem(ll_riga, "id_riga_bol_provenienza",ll_riga_bol_prov )
	//	if as_flag='A' then
		if isnumber(left(as_accessorio, 1)) then 	
			ls_cod_accessorio=right(as_accessorio, len(as_accessorio) - 1)
		else
			ls_cod_accessorio=as_accessorio
		end if
		//comincio a controllare l'accessorio ...
		if pos(ls_cod_accessorio, "AN SAMY")>0 then ls_cod_accessorio="ANSAMY"
		if pos(ls_cod_accessorio, "CU024")> 0 then ls_cod_accessorio="CU024"
		ll_test=0
		//l'esclusione dalla saldatura di articoli indicati nell'apposita tabella NON è ancora in funzione
//		select id_articolo_escluso, id_cliente_da_saldare, id_acc_da_saldare into :ll_id_art_eccezione, :ll_id_cliente, :ll_id_acc_da_saldare
//		from dba.ecc_art_no_saldare where id_articolo_escluso=:al_id_art
//		;
//		//se l'articolo è un'eccezione NON va saldato anche se c'è cliente e/o accessorio da saldare
//		if ll_id_art_eccezione>0 then
//			lb_eccezione=false
//		end if
			//se l'articolo è da saldare lo vedo dalla tabella "acc_da_saldare"
		select id_accessorio
		into :ll_test
		from dba.acc_da_saldare where acc_da_saldare=:ls_cod_accessorio; //lo faccio solo se l'accessorio è adatto (segnato in acc_da_saldare)
		ls_cl_da_saldare=""
		ls_cl_da_saldare=dw_4.getitemstring(al_row, "cliente_da_saldare")  //  Cambiato!!!!
		// Ora 13/10/2021, se il cliente associato è da saldare SI SALDA E se anche l'accessorio è da saldare(SE C'è è DA SALDARE, ALTRIMENTI no, IL CONTROLLO LO FACCIO DIRETTAMETNE NELLA dw)
		//if ll_test<=0 or isnull(ll_test) then //se è già da saldare inutile controllare oltre ... NO! ERRATO! DEVE ESSERE DA Saldare e avere sald (ecc..) nella des_libera!!!!
			//2021 05 01 da oggi no! Samy vuole che se nella des_lib c'è "tutt"+"Anel"+"Sald" vada "-SALD" comuqnue anche se l'accesorio non è nella tabella
			ls_des_libera=dw_4.getitemstring(al_row, "des_libera")
			ls_des_libera=upper(ls_des_libera)	
		//end if
		//ora controllo se l'accessorio per questo articolo è da sostituire .... o anche se devo aggiungere un altro accessorio 20210902
		select acc_sostituto, acc_aggiunto into :ls_acc_sostituto, :ls_acc_aggiunto
		from dba.acc_sostituzioni where id_articolo=:al_id_art and acc_da_sostituire=:ls_cod_accessorio
		;
		if ls_acc_sostituto> " " then 
			ls_cod_accessorio=ls_acc_sostituto //lo sostituisco
			//ora devo controllare la qta (primo carattere se e solo se è numerico e >0)
			if isnumber(left(ls_acc_aggiunto, 1)) then 	//la prima lettera se è un numero indica la qta_distinta (li_qta)
				if integer(left(ls_cod_accessorio, 1))>0 then li_qta=integer(left(ls_cod_accessorio, 1)) 
				ls_cod_accessorio=right(ls_cod_accessorio, len(ls_cod_accessorio) - 1)
				if isnull(li_qta) then li_qta=1
				dw_2.setitem(ll_riga, "qta_distinta",li_qta )
			end if
		else
			if pos(upper(ls_cod_accessorio), "CH")>0  then   //20240506 se è "ch" e c'è laserato nella desc acc allora aggiungo il codice del cliente es: CH11_1430
				ls_des_libera=dw_4.getitemstring(al_row, "des_libera")
				if pos(upper(ls_des_libera), "LASER") >0 then 
					ls_cliente=dw_4.getitemstring(al_row, "cliente")
					ls_cod_accessorio+="_"+right(ls_cliente, 4)
				end if
			end if  //fine 20240506
		end if
		//ora aggiungo eventuale aggiunta (acc_aggiunto)  //20220117
		if ls_acc_aggiunto>" " then
			ll_riga_acc_2=dw_2.insertrow(0)
			if ll_id_doc_sald>0 then 	dw_2.setitem(ll_riga_acc_2, "id_doc_sald",ll_id_doc_sald )
			dw_2.setitem(ll_riga_acc_2, "qta",li_pezzi) //+li_pezzi*3/100 )
			dw_2.setitem(ll_riga_acc_2, "id_riga_bol_provenienza",ll_riga_bol_prov )
		//	if as_flag='A' then
			if isnumber(left(ls_acc_aggiunto, 1)) then 	//la prima lettera se è un numero indica la qta_distinta (li_qta)
				if integer(left(ls_acc_aggiunto, 1))>0 then li_qta=integer(left(ls_acc_aggiunto, 1)) else  li_qta=1
				ls_acc_aggiunto=right(ls_acc_aggiunto, len(ls_acc_aggiunto) - 1)
			end if
			dw_2.setitem(ll_riga_acc_2, "qta_distinta",li_qta )
			dw_2.setitem(ll_riga_acc_2, "c_num_bol", ls_num_bollettina)
		end if
		//fine controllo sostituzione20210902
		//20210501: samy dice: se nella descrizione c'è "TUTT"+SALD + ANEL in combinazione di almeno 2/3 sono da saldare (-SALD), 
		//ma anche se nella des_lib non c'è nulla SE trovo cliente da saldare E accessorio da saldare metto comuqnue -SALD (a meno che non sia un'eccezione lb_eccezione=false
//		if (ll_test>0 and  ls_cl_da_saldare> "  ") or  (pos(ls_des_libera, "TUTT")>0 and  pos(ls_des_libera, "ANEL")>0) or  (pos(ls_des_libera, "TUTT")>0 &
//			and pos(ls_des_libera, "SALD")>0) or (pos(ls_des_libera, "ANEL")>0 and pos(ls_des_libera, "SALD")>0) and lb_eccezione  then
//				ls_cod_accessorio+="-SALD"
//		end if

		//20230113 se l'accessorio è in tabella "acc_da_sald_no_sald" allora NON metto -SALD anche se ci andasse
		ll_NO_sald=0
		select  id_acc_da_sald_no_sald into :ll_NO_sald
		from dba.acc_da_sald_no_sald where acc_da_sald_no_sald=:ls_cod_accessorio;
		if isnull(ll_NO_sald) or ll_NO_sald=0 then
		//proviamo così 24092021 ll_test lo segno alla riga 56 più sopra (esiste nella tabella degli accesori da saldare)
		//lb_eccezione NON si usa più 20220628, ma lo lascio tanto è sempre TRUE, perché se si riusasse basterebbe scommentare le righe da 53 in giù
			if (ll_test>0 and  ls_cl_da_saldare> "  " and lb_eccezione) or  (pos(ls_des_libera, "TUTT")>0 and  pos(ls_des_libera, "ANEL")>0) or  (pos(ls_des_libera, "TUTT")>0 &
				and pos(ls_des_libera, "SALD")>0) or (pos(ls_des_libera, "AN")>0 and pos(ls_des_libera, "SALD")>0) and lb_eccezione  then  //(pos(ls_des_libera, "ANEL")>0 and pos(ls_des_libera, "SALD")>0)  cambiata 20220628
					ls_cod_accessorio+="-SALD"
			end if
		end if  //20230113 fine


		if pos(as_accessorio, "FP")>0  or pos(as_accessorio, "FT")>0 or  pos(as_accessorio, "MB")>0 or  pos(as_accessorio, "FB")>0 or pos(as_accessorio, "CU")>0 &
			or pos(as_accessorio, "CONCR")>0 then
			//per il bollo recupero tutto ciò che trovo dopo "bollo" nella tabella dei bolli
			ls_bollo=dw_4.getitemstring(al_row, "c_bollo")
			if len(ls_bollo)>0 then
				li_pos=pos(upper(ls_bollo), "BOLLO")
				if li_pos>0 then
					ls_bollo=right(ls_bollo,  len(ls_bollo) - (li_pos + 6))
					ls_num_bollo=left(ls_bollo,  pos(ls_bollo, "-") - 1)
					ls_cod_accessorio+="~r~n"+ ls_num_bollo+"~r~n"
					ls_cod_accessorio+= right(ls_bollo, len(ls_bollo) - len(ls_num_bollo) - 1)
				end if
			end if
		end if
	//	end if
		if len(ls_cod_accessorio)>32 then ls_cod_accessorio=left(ls_cod_accessorio, 32)
		dw_2.setitem(ll_riga, "accessorio",ls_cod_accessorio )
		dw_2.setitem(ll_riga, "data_lista",ldt_data )
		dw_2.setitem(ll_riga, "c_bollo",ls_num_bollo )  //20240323 scrivo il bollo per poterlo riprendere e metterlo in dw_5 per ordinare per bollo
		if ll_riga_acc_2>0 then
				if len(ls_acc_aggiunto)>32 then ls_acc_aggiunto=left(ls_acc_aggiunto, 32)
			dw_2.setitem(ll_riga_acc_2, "accessorio",ls_acc_aggiunto )
			dw_2.setitem(ll_riga_acc_2, "data_lista",ldt_data )
			
		end if
		//se c'è un accessorio da aggiungere rilancio questa funzione (NO, aggiungo subito qui, i controlli NON sono, infatti, necessari
		//20210914: non può fungere, troppo lungo da inserire. Quindi: leggere la des_libera, se trovi "TAG" o "TARG" o "EXT" o "ESTEN"
		
//		if ls_acc_aggiunto>" " then
//			li_qta=integer(left(ls_acc_aggiunto, 1))
//			if isnull(li_qta) or li_qta=0 then li_qta=1
//			if isnumber(left(ls_acc_aggiunto, 1)) then ls_acc_aggiunto=right(ls_acc_aggiunto, len(ls_acc_aggiunto) - 1)
//			ll_riga=dw_2.insertrow(0)
//			dw_2.setitem(ll_riga, "qta",li_pezzi) //+li_pezzi*3/100 )
//			dw_2.setitem(ll_riga, "id_riga_bol_provenienza",ll_riga_bol_prov )
//			dw_2.setitem(ll_riga, "qta_distinta",li_qta )
//			dw_2.setitem(ll_riga, "c_num_bol", ls_num_bollettina)
//			dw_2.setitem(ll_riga, "accessorio",ls_acc_aggiunto )
//			dw_2.setitem(ll_riga, "data_lista",ldt_data )
//		end if
	end if
end if





end subroutine

public subroutine wf_aggiungi_tag ();string ls_des_libera, ls_acc_aggiunto_ext, ls_num_bollettina, ls_nome_tag, ls_nome_ext, ls_applica_sempre, ls_cliente
string ls_acc_aggiunto_tag,ls_bollo,ls_num_bollo,ls_nota_art_cliente, ls_art
integer li_qta, i, li_pezzi, li_pos
long ll_riga_bol_prov,ll_riga
date ldt_data
//se c'è un accessorio da aggiungere rilancio questa funzione (NO, aggiungo subito qui, i controlli NON sono, infatti, necessari
				//20210914: non può fungere, troppo lungo da inserire. Quindi: leggere la des_libera, se trovi "TAG" o "TARG" o "EXT" o "ESTEN"
for i= 1 to dw_4.ROWCOUNT()
	ls_des_libera=""
	ls_acc_aggiunto_ext=""
	ls_acc_aggiunto_tag=""
	ls_nome_tag=""
	ls_nome_ext=""
	ls_applica_sempre="N"
	ls_des_libera=dw_4.getitemstring(i, "des_libera")
	ls_des_libera=upper(ls_des_libera)
	if pos(ls_des_libera, "TAG")>0 or  (pos(ls_des_libera, "TARG")>0 and pos(ls_des_libera, "NO TARG")<=0) then 
		ls_acc_aggiunto_tag="TAG" //se c'è tag valorizzo
	end if
	if pos(ls_des_libera, "EXT")>0 or  pos(ls_des_libera, "ESTEN")>0 then 
		ls_acc_aggiunto_ext="EXT" //se c'è ext valorizzo
	end if
	ls_nota_art_cliente=""
	ls_cliente=dw_4.getitemstring(i, "cliente")
	select nome_tag, nome_ext, applica_sempre , nota_art_cliente  //20220902 SAMY rec. anche nota
	into :ls_nome_tag, :ls_nome_ext, :ls_applica_sempre, :ls_nota_art_cliente 
	from dba.cliente_ext_tag
	where cod_cliente=:ls_cliente ;
	
	//se il cliente ha il flag applica_sempre='S' applico anche se non c'è TAG in des_libera
	if  ls_applica_sempre="S" then
		if ls_nome_ext> " " then ls_acc_aggiunto_ext=ls_nome_ext
		if ls_nome_tag> " " then ls_acc_aggiunto_tag=ls_nome_tag		
	else
		if ls_acc_aggiunto_ext > " " and ls_nome_ext> " "   then  ls_acc_aggiunto_ext=ls_nome_ext
		if ls_acc_aggiunto_tag > " " and ls_nome_tag> " "   then  ls_acc_aggiunto_tag=ls_nome_tag
	end if
	//ora controllo se c'è il bollo, se così fosse lo applico anche alle tag e alle ext
	ls_bollo=dw_4.getitemstring(i, "c_bollo")
		if len(ls_bollo)>0 then
			li_pos=pos(upper(ls_bollo), "BOLLO")
			if li_pos>0 then
				ls_bollo=right(ls_bollo,  len(ls_bollo) - (li_pos + 6))
				ls_num_bollo=left(ls_bollo,  pos(ls_bollo, "-") - 1)
				if  ls_acc_aggiunto_ext > " " then ls_acc_aggiunto_ext+="~r~n"+ ls_num_bollo+"~r~n"
				if ls_acc_aggiunto_tag > " " then ls_acc_aggiunto_tag+="~r~n"+ ls_num_bollo+"~r~n"
			end if
		end if
		
		li_pezzi=dw_4.getitemnumber(i, "pezzi")
		ll_riga_bol_prov=dw_4.getitemnumber(i, "id_riga_documento")
		//ls_num_bollettina=dw_4.getitemstring(i, "cliente")
		//ls_acc_aggiunto+='-'+ls_num_bollettina
		ls_num_bollettina=right(dw_4.getitemstring(i, "cod_barre"), 5)
		if isnull(li_qta) or li_qta=0 then li_qta=1 //per ora è sempre =1
		//if isnumber(left(ls_acc_aggiunto, 1)) then ls_acc_aggiunto=right(ls_acc_aggiunto, len(ls_acc_aggiunto) - 1)
		if  ls_acc_aggiunto_ext> " " then
			ll_riga=dw_2.insertrow(0)
			dw_2.setitem(ll_riga, "qta",li_pezzi) //+li_pezzi*3/100 )
			dw_2.setitem(ll_riga, "id_riga_bol_provenienza",ll_riga_bol_prov )
			dw_2.setitem(ll_riga, "qta_distinta",li_qta )
			dw_2.setitem(ll_riga, "c_num_bol", ls_num_bollettina)
			dw_2.setitem(ll_riga, "accessorio",ls_acc_aggiunto_ext + '-' +ls_cliente ) //non più num_bollettina perché deve fare gruppo 20210928
			dw_2.setitem(ll_riga, "data_lista",datetime(today(), now()) )
			dw_2.setitem(ll_riga, "c_bollo", ls_num_bollo ) //20240323 aggiungo bollo per ordine
		end if
		if  ls_acc_aggiunto_tag> " " then
			ll_riga=dw_2.insertrow(0)
			dw_2.setitem(ll_riga, "qta",li_pezzi) //+li_pezzi*3/100 )
			dw_2.setitem(ll_riga, "id_riga_bol_provenienza",ll_riga_bol_prov )
			dw_2.setitem(ll_riga, "qta_distinta",li_qta )
			dw_2.setitem(ll_riga, "c_num_bol", ls_num_bollettina)
			dw_2.setitem(ll_riga, "accessorio",ls_acc_aggiunto_tag + '-' +ls_cliente )
			dw_2.setitem(ll_riga, "data_lista",datetime(today(), now()) )
			dw_2.setitem(ll_riga, "c_bollo", ls_num_bollo ) //20240323 aggiungo bollo per ordine
		end if
		
		 //20220902 SAMY rec. anche nota
		if 	ls_nota_art_cliente> " " then
			if ll_riga<=0 then ll_riga=dw_2.insertrow(0)
			ls_art=dw_4.getitemstring(i, "articolo")
			if pos(ls_art, ls_cliente)>0 then
				dw_2.setitem(ll_riga, "descrizione", ls_nota_art_cliente)
			end if
		end if
		
//	end if
NEXT
		
end subroutine

on w_bol_accessori.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.cb_1=create cb_1
this.rb_2018=create rb_2018
this.rb_2019=create rb_2019
this.rb_2020=create rb_2020
this.rb_2021=create rb_2021
this.cb_crea_accessori=create cb_crea_accessori
this.dw_4=create dw_4
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_ricalcola_gruppo=create cb_ricalcola_gruppo
this.rr_1=create rr_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_5=create dw_5
this.cb_crea_sald=create cb_crea_sald
this.dw_6=create dw_6
this.cb_st_dw_2=create cb_st_dw_2
this.cb_2=create cb_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_5=create cb_5
this.dw_7=create dw_7
this.cb_6=create cb_6
this.cb_reset_filtro=create cb_reset_filtro
this.cb_7=create cb_7
this.cb_accantona=create cb_accantona
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_8=create cb_8
this.rb_2022=create rb_2022
this.cb_11=create cb_11
this.cb_12=create cb_12
this.cb_13=create cb_13
this.ole_1=create ole_1
this.dw_8=create dw_8
this.cb_14=create cb_14
this.cb_15=create cb_15
this.dw_9=create dw_9
this.cb_16=create cb_16
this.cb_estensione_tag=create cb_estensione_tag
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.rb_2018
this.Control[iCurrent+4]=this.rb_2019
this.Control[iCurrent+5]=this.rb_2020
this.Control[iCurrent+6]=this.rb_2021
this.Control[iCurrent+7]=this.cb_crea_accessori
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.cb_inserisci
this.Control[iCurrent+10]=this.cb_salva
this.Control[iCurrent+11]=this.cb_cancella
this.Control[iCurrent+12]=this.cb_ricalcola_gruppo
this.Control[iCurrent+13]=this.rr_1
this.Control[iCurrent+14]=this.dw_1
this.Control[iCurrent+15]=this.dw_2
this.Control[iCurrent+16]=this.dw_5
this.Control[iCurrent+17]=this.cb_crea_sald
this.Control[iCurrent+18]=this.dw_6
this.Control[iCurrent+19]=this.cb_st_dw_2
this.Control[iCurrent+20]=this.cb_2
this.Control[iCurrent+21]=this.cb_4
this.Control[iCurrent+22]=this.cb_3
this.Control[iCurrent+23]=this.cb_5
this.Control[iCurrent+24]=this.dw_7
this.Control[iCurrent+25]=this.cb_6
this.Control[iCurrent+26]=this.cb_reset_filtro
this.Control[iCurrent+27]=this.cb_7
this.Control[iCurrent+28]=this.cb_accantona
this.Control[iCurrent+29]=this.cb_9
this.Control[iCurrent+30]=this.cb_10
this.Control[iCurrent+31]=this.cb_8
this.Control[iCurrent+32]=this.rb_2022
this.Control[iCurrent+33]=this.cb_11
this.Control[iCurrent+34]=this.cb_12
this.Control[iCurrent+35]=this.cb_13
this.Control[iCurrent+36]=this.ole_1
this.Control[iCurrent+37]=this.dw_8
this.Control[iCurrent+38]=this.cb_14
this.Control[iCurrent+39]=this.cb_15
this.Control[iCurrent+40]=this.dw_9
this.Control[iCurrent+41]=this.cb_16
this.Control[iCurrent+42]=this.cb_estensione_tag
end on

on w_bol_accessori.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.rb_2018)
destroy(this.rb_2019)
destroy(this.rb_2020)
destroy(this.rb_2021)
destroy(this.cb_crea_accessori)
destroy(this.dw_4)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_ricalcola_gruppo)
destroy(this.rr_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_5)
destroy(this.cb_crea_sald)
destroy(this.dw_6)
destroy(this.cb_st_dw_2)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_5)
destroy(this.dw_7)
destroy(this.cb_6)
destroy(this.cb_reset_filtro)
destroy(this.cb_7)
destroy(this.cb_accantona)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_8)
destroy(this.rb_2022)
destroy(this.cb_11)
destroy(this.cb_12)
destroy(this.cb_13)
destroy(this.ole_1)
destroy(this.dw_8)
destroy(this.cb_14)
destroy(this.cb_15)
destroy(this.dw_9)
destroy(this.cb_16)
destroy(this.cb_estensione_tag)
end on

event open;call super::open;
dw_6.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.insertrow(1)
dw_6.insertrow(1)
dw_7.settransobject(sqlca)
dw_7.retrieve()
dw_9.insertrow(1)


//dw_3.setitem(1, "da_data", relativedate(today(), - 30))






end event

event ue_postopen;call super::ue_postopen;dw_3.post setfocus()
dw_3.post setcolumn("cod_barre")
end event

type st_1 from w_001`st_1 within w_bol_accessori
end type

type dw_3 from udw_base within w_bol_accessori
integer x = 55
integer y = 24
integer width = 896
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ins_barcode_plurimo_ext"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;integer li_anno, i
string ls_num_doc, ls_num_bollettina, ls_test,ls_galv,ls_lav
long ll_num_prog, ll_id_bollettina, ll_id_test, ll_righe, ll_id_doc,ll_riga,ll_id_galv
decimal ldc_prezzo, ldc_prezzo_da_Data1
date ldt_data
datetime ldt_data_lista

if dwo.name="cod_barre"  then
	if len(data)=7   then
		
		//da cambiare subito!!!
		if rb_2020.checked then
			li_anno=2020
		elseif rb_2019.checked then
			li_anno=2019
		elseif rb_2018.checked then
			li_anno=2018
		elseif rb_2021.checked then
			li_anno=2021
		elseif rb_2022.checked then
			li_anno=2022
		end if
		
		if li_anno>=2022 then
			ls_num_doc=data
			ll_num_prog=long(ls_num_doc)
			select id_documento, num_documento
			into :ll_id_bollettina, :ls_num_bollettina
			from dba.documento d, dba.prof_documento p
			where right(num_documento, 7)=:ls_num_doc
			and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
			and d.id_prof_documento=p.id_prof_documento
			;
		else	
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
			//devo azzerare eventuali
			ls_test="id_documento="+string(ll_id_bollettina)
			ll_id_test=dw_1.find(ls_test, 1, dw_1.rowcount())
			if ll_id_test>0 then //controllo che non sia stata già caricata
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
			else
				//cerco anche nello storico
				select data_lista
				into :ldt_data_lista
				from dba.fabbisogno_accessori_k f, dba.documento d, dba.riga_documento r
				where id_riga_bol_provenienza=r.id_riga_documento
				and d.id_documento=r.id_documento and d.id_documento=:ll_id_bollettina
				;
				if  ldt_data_lista>=datetime("2000/01/01") then
					if messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata al fabbisogno del "&
						+string(ldt_data_lista, "dd/mm/yy/ hh:mm")+" Vuoi annullare il caricamento?",stopsign!, yesno! )=1 then
						return
						//ll_righe=dw_2.retrieve(ll_id_bollettina)
						//wf_bilancia(dw_2.rowcount())
						//setcolumn("cod_barre_galvanica")
					end if
				end if
				for i=1 to dw_1.rowcount()
					dw_1.setitem(i, "riga_documento_peso_netto_evaso", i)
				next
				dw_1.retrieve(ll_id_bollettina)
				ib_gia_creati=false
				dw_3.setitem(1, "cod_barre", "")
				dw_3.setfocus()
				dw_3.setcolumn("cod_barre")
			end if
		else
			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
		end if
	end if
end if


end event

type cb_1 from commandbutton within w_bol_accessori
integer x = 3424
integer y = 2568
integer width = 430
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<  Stampa"
end type

event clicked;integer li_ret
string ls_nome_file, ls_num_sald, ls_rag_soc
long ll_id_doc_sald, ll_riga
date ldt_data_doc


ll_id_doc_sald=dw_2.getitemnumber(1, "id_doc_sald")
if ll_id_doc_sald>0 then
	
	select   "documento"."num_documento",    "documento"."data_documento",  "sog_commerciale_gen"."rag_soc_1"
    into :ls_num_sald, :ldt_data_doc, :ls_rag_soc
	 FROM 
         "sog_commerciale_gen",   "documento",            riga_documento , produzione_2011
   WHERE          
"riga_documento"."id_documento" = "documento"."id_documento"  and
"produzione_2011"."id_bollettina"  = :ll_id_doc_sald   and
"produzione_2011"."id_doc_produzione" = "riga_documento"."id_riga_documento" and
sog_commerciale_gen.id_sog_commerciale=documento.id_sog_commerciale;
	
	
//	select num_documento, data_documento, rag_soc_1
//	into :ls_num_sald, :ldt_data_doc, :ls_rag_soc
//	from documento d, sog_commerciale_gen s
//	where d.id_sog_commerciale=s.id_sog_commerciale
//	and d.id_documento=:ll_id_doc_sald;
	ls_num_sald="Sald: "+ls_num_sald+" del "+string(ldt_data_doc, "dd/mm/yy")+"~r~n"+ls_rag_soc
else
	messagebox("Attenzione!", "Numero doc sald NON recuperato!")	
	ls_num_sald="Numero doc sald NON recuperato!"
end if
ll_riga=dw_5.insertrow(0)
dw_5.setitem(ll_riga, "accessorio", ls_num_sald)
dw_5.setitem(ll_riga, "qta", 0) //aumento del 3% 20200930 samy

dw_2.groupcalc()
dw_2.Modify("Export.PDF.Method = Distill!")
dw_2.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
dw_2.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
ls_nome_file="\\192.168.1.3\fabbisogno_pdf\fab_"+string(dw_2.getitemdate(1, "data_lista"), "yyyy_mm_dd")+string(now(), "hh_mm")+".pdf"
li_ret=dw_2.SaveAs(ls_nome_file, PDF!, FALSE)
IF LI_RET<> 1 THEN
	messagebox("Errore!", "File PDF non generato!")	
end if


dw_5.sort()
dw_5.groupcalc()
dw_5.print(true, true)




	
end event

type rb_2018 from radiobutton within w_bol_accessori
integer x = 82
integer y = 232
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

type rb_2019 from radiobutton within w_bol_accessori
integer x = 82
integer y = 308
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

type rb_2020 from radiobutton within w_bol_accessori
integer x = 82
integer y = 392
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

type rb_2021 from radiobutton within w_bol_accessori
integer x = 82
integer y = 468
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

type cb_crea_accessori from commandbutton within w_bol_accessori
integer x = 361
integer y = 444
integer width = 581
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Crea Lista Accessori"
end type

event clicked;long ll_id_riga_bol, ll_riga_trovata, ll_righe, ll_id_sog
integer i, li_pezzi_bol, li_pezzi_xls, a, li_ret

ll_righe=dw_2.rowcount()
if ll_righe<=0 then
	ll_id_sog=dw_6.getitemnumber(1, "id_sog_commerciale")
	if ll_id_sog>0 then  //se non c'è sog comm non si fa nulla... samy 04-03-2021
		for i=1 to dw_1.rowcount()
			ll_id_riga_bol=dw_1.getitemnumber(i, "riga_documento_id_riga_documento")
			li_pezzi_bol=dw_1.getitemnumber(i, "riga_documento_quantita")
			if ll_id_riga_bol>0 then
				ll_righe=dw_4.rowcount()  //conto eventuali righe in dw_4
				li_ret=dw_4.retrieve(ll_id_riga_bol) //aggiungo la riga corrente
				if li_ret>0 and ll_righe< dw_4.rowcount() then  //vuol dire che il retrieve ha aggiunto una riga (pleonastico!)
					ll_riga_trovata=dw_4.find("id_riga_documento="+string(ll_id_riga_bol), 1,dw_4.rowcount()) //trovo la bollettina
					li_pezzi_xls=dw_4.getitemnumber(ll_riga_trovata, "pezzi")
//					if li_pezzi_xls<>li_pezzi_bol then
//						if messagebox("Attenzione!", "I pezzi della BOL NON coincidono con quelli XLS (del Vedi Bollettine)! Forse sono stati corretti. Vuoi riportare quelli della BOL?", stopsign!, yesno!)=1 then
							dw_4.setitem(ll_riga_trovata, "pezzi", li_pezzi_bol)
//						end if
//					end if
				else
					messagebox("Attenzione!", "La bollettina con id_riga="+string(ll_id_riga_bol)+" NON ha riferimento in Vedi_Bollettine Excel")
				end if
			else
				messagebox("Attenzione!", "Non c'è collegamento alla bollettina nel Vedi_Bollettine Excel")
			end if
		next
		wf_aggiungi()
		wf_aggiungi_tag()
		wf_stampa_video()
	else
		messagebox("Attenzione!", "L'intestatario (FORNITORE) del DOC DEVE essere inserito!")
	end if
else
	messagebox("Attenzione!", "Non è ancora possibile creare la lista accessori in due volte! Resetta e carica TUTTO prima di creare la lista.")
end if






	

end event

type dw_4 from udw_001 within w_bol_accessori
integer x = 3401
integer y = 1864
integer width = 1998
integer height = 696
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_bol_excel_ra_id_riga_bol"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;return 2
end event

type cb_inserisci from uo_commandbutton within w_bol_accessori
string tag = "Inserisce una nuova riga nella finestra che ha il fuoco."
integer x = 2939
integer y = 1448
integer width = 430
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "Inserisci"
end type

event clicked;long ll_riga
ll_riga=dw_2.trigger event ue_insert(0)

end event

type cb_salva from uo_commandbutton within w_bol_accessori
string tag = "Salva la finestra che ha il fuoco. Se essa è figlia, salva anche la finestra madre."
integer x = 2939
integer y = 1624
integer width = 430
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string text = "Salva"
end type

event clicked;dw_2.trigger event ue_update()

end event

type cb_cancella from uo_commandbutton within w_bol_accessori
string tag = "Cancella la riga selezionata nella finestra che ha il fuoco. Richiede il salvataggio successivo per perfezionare la cancellazione."
integer x = 2939
integer y = 1536
integer width = 430
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=dw_2.getrow()
dw_2.trigger event ue_delete(ll_riga_da_cancellare)		

end event

type cb_ricalcola_gruppo from commandbutton within w_bol_accessori
integer x = 2939
integer y = 1804
integer width = 430
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricalcola Gruppo"
end type

event clicked;dw_2.sort()
dw_2.groupcalc()
end event

type rr_1 from roundrectangle within w_bol_accessori
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 64
integer y = 224
integer width = 279
integer height = 408
integer cornerheight = 40
integer cornerwidth = 46
end type

type dw_1 from udw_base within w_bol_accessori
integer x = 965
integer y = 24
integer width = 2414
integer height = 812
boolean bringtotop = true
string dataobject = "d_ra_bol_doc_riga"
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

type dw_2 from udw_base within w_bol_accessori
integer x = 59
integer y = 976
integer width = 2866
integer height = 876
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_fab_accessori_k"
boolean hscrollbar = true
end type

event itemchanged;call super::itemchanged;dw_2.print(true,true)
end event

type dw_5 from udw_000 within w_bol_accessori
integer x = 59
integer y = 1960
integer width = 3328
integer height = 804
integer taborder = 60
string dataobject = "d_fab_acc_k_etic"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_crea_sald from commandbutton within w_bol_accessori
integer x = 361
integer y = 336
integer width = 581
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Crea SALD"
end type

event clicked;w_orafo_documento_ordine_cx w_orafo
s_list_main s_list
integer i, a, li_ret
string ls_esiste_gia,ls_test, ls_num_bol
long ll_id_bol_test, ll_id_doc_sald, ll_id_fo, ll_id_art

//dw_6.accepttext()

s_list.l_id_riga[1]=100
s_list.l_id_riga[2]=dw_6.getitemnumber(1, "id_sog_commerciale")
if s_list.l_id_riga[2]>0 then
	ll_id_fo=s_list.l_id_riga[2]
	for i=1 to dw_1.rowcount() 
		ll_id_bol_test=dw_1.getitemnumber(i, "id_documento")
		ls_num_bol=dw_1.getitemstring(i, "num_documento")
		ls_esiste_gia=""
		select num_documento+' del '+string(data_documento) into :ls_esiste_gia from dba.produzione_2011 p, dba.riga_documento r, dba.documento d
		where p.id_bollettina=:ll_id_bol_test and r.id_documento=d.id_documento and p.id_doc_produzione=r.id_riga_documento;// order by d.num_documento ;
		if ls_esiste_gia>" " then
			messagebox("Attenzione!", "La bollettina alla riga "+string(i)+" è già derivata in doc sald: "+ls_esiste_gia)
			continue
		end if
		//controllo esclusioni coppia fornitore-articolo 20220902
		ll_id_art=0
		ll_id_art=dw_1.getitemnumber(i, "id_articolo")
		select esclusione into :ls_test from dba.fo_art_esclusione
		where id_articolo=:ll_id_art and id_sog_commerciale=:ll_id_fo;
		if ls_test="S" then
			messagebox("Attenzione!", "Coppia Fornitore/articolo alla riga "+string(i)+" è ESCLUSA!!!")
			continue
		end if
		a++
		s_list.l_id_riga[a+2]=	ll_id_bol_test
	next
	if upperbound(s_list.l_id_riga)>=3 then
		//s_list.s_identifica[1]="id_documento"
		cb_accantona.triggerevent(clicked!)
		
		s_list.s_modo=modo_inserisci
		s_list.s_win_parametri="DV"
		openwithparm(w_orafo, s_list)
		select d.id_documento into :ll_id_doc_sald from dba.produzione_2011 p, dba.riga_documento r, dba.documento d
		where p.id_bollettina=:ll_id_bol_test and r.id_documento=d.id_documento and p.id_doc_produzione=r.id_riga_documento;
		if ll_id_doc_sald>0 then
			for i=1 to dw_2.rowcount()
				dw_2.setitem(i, "id_doc_sald", ll_id_doc_sald)
			next
		   	dw_2.trigger event ue_update()
		else  //20221212 provo a dare un messaggio perché si è verificato, sembra, che non abbia creato i SALD... vediamo
			messagebox("Attenzione!", "SALD per bollettina n. "+ls_num_bol+" NON creato!!!")
		end if
	else
		messagebox("Attenzione!", "Tutte le righe sono state scartate! Probabilmente sono già state derivate in SALD!")
	end if
else
	messagebox("Attenzione!", "L'intestatario del DOC DEVE essere inserito!")
end if


end event

type dw_6 from udw_000 within w_bol_accessori
integer x = 55
integer y = 664
integer width = 896
integer height = 184
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_scegli_fo"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event losefocus;call super::losefocus;accepttext()
end event

type cb_st_dw_2 from commandbutton within w_bol_accessori
integer x = 2354
integer y = 1864
integer width = 430
integer height = 88
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa SALD"
end type

event clicked;

dw_2.setsort("accessorio")
dw_2.sort()
dw_2.groupcalc()
openwithparm(w_fab_acc_k_rpt, dw_2)
//"d_fab_acc_k_rpt"

end event

type cb_2 from commandbutton within w_bol_accessori
integer x = 361
integer y = 552
integer width = 581
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Resetta"
end type

event clicked; integer i
dw_1.reset()
dw_2.reset()
dw_4.reset()
dw_5.reset()

dw_3.setitem(1, "cod_barre", "")
dw_3.setfocus()
dw_3.setcolumn("cod_barre")

 ib_gia_creati=false
 
 

for i= 1 to dw_7.rowcount()
	dw_7.setitem(i, "c_scegli", 0)	
next

	
end event

type cb_4 from commandbutton within w_bol_accessori
integer x = 2939
integer y = 1712
integer width = 430
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;dw_2.groupcalc()

dw_2.print(true, true)
end event

type cb_3 from commandbutton within w_bol_accessori
integer x = 2939
integer y = 1064
integer width = 430
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CL da SALD"
end type

event clicked;open(w_cliente_da_saldare)
end event

type cb_5 from commandbutton within w_bol_accessori
integer x = 2939
integer y = 1156
integer width = 430
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "ACC da SALD"
end type

event clicked;open(w_acc_da_saldare)
end event

type dw_7 from udw_001 within w_bol_accessori
integer x = 3401
integer y = 28
integer width = 1998
integer height = 1704
integer taborder = 40
boolean bringtotop = true
string title = "Ristampa liste già create"
string dataobject = "d_accantonamento_new"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;string ls_filtro, ls_sort, ls_asc
date ldt_data_lista

IF DWO.NAME="data_lista" then
	ldt_data_lista=getitemdate(row, "data_lista")
	if ldt_data_lista> date("1990/01/01") then
		ls_filtro="data_lista=date('"+string(ldt_data_lista, "yyyy/mm/dd")+"')"
		setfilter(ls_filtro)
		filter()
	else
		
	end if
end if

if dwo.type='text' then
	ii_sort++
	if ii_sort=2 then 
		ii_sort=0
		ls_asc=" desc" 
	else 
		ls_asc=""
	end if
	ls_sort=left(dwo.name, len(string(dwo.name)) - 2)
	setsort(ls_sort+ls_asc)
	sort()
end if
end event

event clicked;call super::clicked;//integer i
//
//if dwo.name='c_scegli' then
//	for i= 1 to dw_7.rowcount()
//		
//	next
//end if
	
end event

type cb_6 from commandbutton within w_bol_accessori
boolean visible = false
integer x = 4937
integer y = 1596
integer width = 457
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ri-Crea TUTTI"
end type

event clicked;integer i
long ll_id_bollettina, ll_id_doc

for i= 1 to dw_7.rowcount()
//	ll_id_riga=dw_7.getitemnumber(i,  "id_riga_bol_provenienza")
//	select first(id_documento) into :ll_id_bollettina from dba.riga_documento where id_riga_documento=:ll_id_riga order by id_riga_documento;
//	dw_1.retrieve(ll_id_bollettina)
	ll_id_doc=dw_7.getitemnumber(i,  "documento_id_documento")
	//select first(id_documento) into :ll_id_bollettina from dba.riga_documento where id_riga_documento=:ll_id_riga order by id_riga_documento;
	dw_1.retrieve(ll_id_doc)
next
ib_gia_creati=true
end event

type cb_reset_filtro from commandbutton within w_bol_accessori
integer x = 4174
integer y = 1740
integer width = 384
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Azzera Filtro"
end type

event clicked;dw_7.setfilter("")
dw_7.filter()
end event

type cb_7 from commandbutton within w_bol_accessori
integer x = 4567
integer y = 1740
integer width = 814
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ri-Crea solo scelti"
end type

event clicked;
long ll_id_bollettina, ll_numero, ll_riga, ll_id_sog
string ls_sql

//dw_7.setfilter("c_scegli=1")
//dw_7.filter()

ll_riga=dw_7.find("c_scegli=1", 1, 10000)

//ll_numero=dw_7.getitemnumber(ll_riga,  "numero")
ll_numero=dw_7.getitemnumber(ll_riga,  "id_documento")
ll_id_sog=dw_7.getitemnumber(ll_riga,  "id_sog_commerciale")
dw_6.setitem(1, "id_sog_commerciale", ll_id_sog)

declare my_cursor CURSOR FOR 
//select id_bollettina  from dba.accantonamento where numero =:ll_numero
	select id_bollettina  from dba.produzione_2011 p, dba.riga_documento r 
	where r.id_documento =:ll_numero and r.id_riga_documento=p.id_doc_produzione
;
open my_cursor;
do 
	ll_id_bollettina=0
	FETCH my_cursor INTO :ll_id_bollettina ;
	if ll_id_bollettina>0 then
		dw_1.retrieve(ll_id_bollettina)
	else
		exit
	end if
loop while  ll_id_bollettina>0 
close my_cursor;


ib_gia_creati=true

end event

type cb_accantona from commandbutton within w_bol_accessori
boolean visible = false
integer x = 78
integer y = 852
integer width = 402
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Accantona"
end type

event clicked;long ll_id_bollettina, ll_id_sog, ll_numero,ll_riga, ll_test
integer i
string ls_esiste_gia

ll_riga=dw_7.find("c_scegli=1", 1, 10000)
if ll_riga> 0 then 
	//ll_numero=dw_7.getitemnumber(ll_riga, "numero")  //20240213 proviamo così
	ll_numero=dw_7.getitemnumber(ll_riga, "documento_num_documento")
else
	setnull(ll_numero)
end if
ll_id_sog=dw_6.getitemnumber(1, "id_sog_commerciale")
for i=1 to dw_6.rowcount()
	ll_id_bollettina=dw_1.getitemnumber(i, "id_documento")
	ls_esiste_gia=""
	select num_documento+' del '+string(data_documento) into :ls_esiste_gia from dba.produzione_2011 p, dba.riga_documento r, dba.documento d
	where p.id_bollettina=:ll_id_bollettina and r.id_documento=d.id_documento and p.id_doc_produzione=r.id_riga_documento;// order by d.num_documento ;
	if ls_esiste_gia>" " then
		messagebox("Attenzione!", "La bollettina alla riga "+string(i)+" è già derivata in doc sald: "+ls_esiste_gia)
		continue
	else
		ll_test=0
		select numero into :ll_test from dba.accantonamento
		where id_bollettina=:ll_id_bollettina;
		if ll_test>0 then
			messagebox("Attenzione!", "La bollettina alla riga "+string(i)+" è già nell'accantonamento n. "+string(ll_test))
			continue
		end if
	end if
	insert into dba.accantonamento ("numero", "id_sog_commerciale", "id_bollettina")
	values(:ll_numero, :ll_id_sog, :ll_id_bollettina)
	;
	if sqlca.sqlNrows>0 then
		commit;
		dw_7.retrieve()
	else
		rollback;
		messagebox("Attenzione!", "Accantonamento NON riuscito!")
	end if
next
end event

type cb_9 from commandbutton within w_bol_accessori
integer x = 3410
integer y = 1740
integer width = 718
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Vedi Accantonamento"
end type

event clicked;open(w_accantonamento_gd, parent)
end event

type cb_10 from commandbutton within w_bol_accessori
integer x = 2939
integer y = 972
integer width = 430
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SOSTITUZIONI"
end type

event clicked;//open(w_art_eccezione)

open(w_acc_sostituzioni) 
end event

type cb_8 from commandbutton within w_bol_accessori
integer x = 2939
integer y = 1256
integer width = 430
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CL/TAG/EXT"
end type

event clicked;open(w_cliente_ext_tag)
end event

type rb_2022 from radiobutton within w_bol_accessori
integer x = 82
integer y = 548
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

type cb_11 from commandbutton within w_bol_accessori
integer x = 59
integer y = 1856
integer width = 754
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Escludi coppia Fornitore/Articolo"
end type

event clicked;open(w_fo_art_esclusione)
end event

type cb_12 from commandbutton within w_bol_accessori
integer x = 2939
integer y = 1352
integer width = 430
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Acc sald NO"
end type

event clicked;open(w_ACC_DA_SALD_NO_SALD)
end event

type cb_13 from commandbutton within w_bol_accessori
integer x = 361
integer y = 232
integer width = 581
integer height = 88
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Carica da XLS"
end type

event clicked;string ls_path, ls_file, ls_num_bollettina
integer i
long ll_id_bollettina

getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.xls", "xls" , "C:\nita\exp_doc")
if  not(trim(ls_file)="" or isnull(ls_file)) then
//	ole_1.open(ls_path)
//	ls_file=left(ls_path, len(ls_path) - 3)+"txt"  //20241119 CAMBIO: SI FA CON CSV... SPERIAMO BENE
//	if fileexists(ls_file) then FileDelete(ls_file)
//	ole_1.object.activesheet.saveas(ls_file, 21)
	dw_8.importfile(Text!,ls_file)

end if	 

dw_1.reset()


for i = 2 to dw_8.rowcount() 
	ls_num_bollettina=""
	ls_num_bollettina=dw_8.getitemstring(i, "A15")
	ll_id_bollettina=0
	select id_documento
	into :ll_id_bollettina
	from dba.documento d, dba.prof_documento p
	where right(num_documento, 7)=:ls_num_bollettina
	and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
	and d.id_prof_documento=p.id_prof_documento
	;
	if ll_id_bollettina>0 then 
		dw_1.retrieve(ll_id_bollettina)
	end if
next
end event

type ole_1 from olecontrol within w_bol_accessori
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
boolean visible = false
integer x = 4370
integer y = 2560
integer width = 320
integer height = 140
integer taborder = 50
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_bol_accessori.win"
omactivation activation = activateondoubleclick!
omdisplaytype displaytype = displayascontent!
omcontentsallowed contentsallowed = containsany!
end type

type dw_8 from udw_001 within w_bol_accessori
boolean visible = false
integer x = 165
integer y = 2256
integer width = 3040
integer height = 540
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_EXT_PER_IMPORT"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;return 2
end event

type cb_14 from commandbutton within w_bol_accessori
integer x = 1682
integer y = 1864
integer width = 471
integer height = 88
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "St. x Art/Cliente"
end type

event clicked;openwithparm(w_acc_art_cliente, dw_2)
end event

type cb_15 from commandbutton within w_bol_accessori
integer x = 946
integer y = 1856
integer width = 494
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordina  per Bollo"
end type

event clicked;dw_5.setsort("bollo")
dw_5.sort()
end event

type dw_9 from udw_000 within w_bol_accessori
integer x = 933
integer y = 832
integer width = 677
integer height = 140
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_da_data_a_data"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event losefocus;call super::losefocus;accepttext()
end event

type cb_16 from commandbutton within w_bol_accessori
integer x = 1632
integer y = 868
integer width = 375
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa Unione"
end type

event clicked;date ldt_da_data, ldt_a_data
string ls_num_bollettina
long ll_id_bollettina, ll_righe
datastore ds_lista_bol
integer i

dw_9.accepttext()

ds_lista_bol=create datastore
ds_lista_bol.dataobject="d_trova_bol_accessori"
ds_lista_bol.settransobject(sqlca)
ldt_da_data=dw_9.getitemdate(1, "da_data")
ldt_a_data=dw_9.getitemdate(1, "a_data")
ll_righe=ds_lista_bol.retrieve(ldt_da_data, ldt_a_data)

for i= 1 to ll_righe
	ll_id_bollettina=0
	ll_id_bollettina=ds_lista_bol.getitemnumber(i, "id_documento")
	dw_1.retrieve(ll_id_bollettina)
next


//ldt_da_data=dw_9.getitemdate(1, "da_data")
//ldt_a_data=dw_9.getitemdate(1, "a_data")
//ldt_da_data_time=datetime(ldt_da_data, time("00:00"))
//ldt_a_data_time=datetime(ldt_a_data, time("11:59"))
//declare c_trova_bol cursor for 
//	select cod_barre from dba.bollettine_excel
//	where data>=:ldt_da_data_time and data <= :ldt_a_data_time;
//	
//	fetch c_trova_bol into :ls_num_bollettina;
//	
//	
//do while sqlca.sqlcode=1
//	select id_documento
//	into :ll_id_bollettina
//	from dba.documento d, dba.prof_documento p
//	where right(num_documento, 7)=:ls_num_bollettina and
// 	(d.id_prof_documento=65 or d.id_prof_documento=111 or d.id_prof_documento=112 or d.id_prof_documento=113 )
//	;
//	dw_1.retrieve(ll_id_bollettina)
//	fetch c_trova_bol into :ls_num_bollettina;
//loop
	
	
end event

type cb_estensione_tag from commandbutton within w_bol_accessori
integer x = 2939
integer y = 852
integer width = 430
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Estensione_TAG"
end type

event clicked;open(w_estensione_tag)
end event

