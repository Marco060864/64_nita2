forward
global type w_bol_excel from w_semplice_gd
end type
type dw_2 from udw_000 within w_bol_excel
end type
type cb_agg_cod_articoli from commandbutton within w_bol_excel
end type
type dw_4 from udw_000 within w_bol_excel
end type
type cb_save_as from commandbutton within w_bol_excel
end type
type cb_verifica_bol from commandbutton within w_bol_excel
end type
type cb_fabbisogno from commandbutton within w_bol_excel
end type
type dw_3 from udw_base within w_bol_excel
end type
type cb_st_fabbisogno from commandbutton within w_bol_excel
end type
type cb_pulisci from commandbutton within w_bol_excel
end type
end forward

global type w_bol_excel from w_semplice_gd
integer width = 5915
integer height = 2680
dw_2 dw_2
cb_agg_cod_articoli cb_agg_cod_articoli
dw_4 dw_4
cb_save_as cb_save_as
cb_verifica_bol cb_verifica_bol
cb_fabbisogno cb_fabbisogno
dw_3 dw_3
cb_st_fabbisogno cb_st_fabbisogno
cb_pulisci cb_pulisci
end type
global w_bol_excel w_bol_excel

forward prototypes
public subroutine wf_aggiungi ()
public subroutine wf_inserisci_in_lista (string as_accessorio, long al_row, string as_flag, long al_id_art)
public subroutine wf_stampa_video ()
end prototypes

public subroutine wf_aggiungi ();string ls_des_accessori, ls_singolo_acc, ls_bollo, ls_bollo_ok,ls_cod_art, ls_accessorio
integer li_pos, i, a
long ll_id_art

for i=1 to dw_1.rowcount()
	li_pos=0
	ls_des_accessori=""
	a=0
	ls_cod_art=dw_1.getitemstring(i, "cod_art_assegnato")
	select id_articolo into :ll_id_art from dba.articolo where codice =:ls_cod_art;
	ls_accessorio=dw_1.getitemstring(i, "accessorio")
	select descrizione into :ls_des_accessori from cod_accessori_k where cod_accessorio=:ls_accessorio;
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
next
end subroutine

public subroutine wf_inserisci_in_lista (string as_accessorio, long al_row, string as_flag, long al_id_art);//arriva 2AN8 la prima lettera è la qta in cui è presente in distinta (in questo caso per fare 1 pezzo occorrono 2 an8)
integer li_qta, li_pezzi, li_pos, i, A
string ls_cod_accessorio, ls_appoggio,ls_bollo, ls_num_bollo, ls_num_bollettina,ls_des_libera
string ls_da_saldare,ls_cl_da_saldare, ls_acc_sostituto, ls_acc_aggiunto, ls_cliente, ls_des_bollo
long ll_riga, ll_riga_bol_prov, ll_id_doc_sald, ll_test, ll_id_art_eccezione, ll_id_cliente, ll_id_acc_da_saldare, ll_riga_acc_2
datetime ldt_data
boolean lb_eccezione=true

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
		ll_riga_bol_prov=dw_1.getitemnumber(al_row, "id_riga_documento")
		ls_num_bollettina=dw_1.getitemstring(al_row, "cliente")
		ls_num_bollettina+="-"+dw_1.getitemstring(al_row, "cod_barre")
		ll_riga=dw_3.insertrow(0)
		dw_3.setitem(ll_riga, "qta_distinta",li_qta )
		dw_3.setitem(ll_riga, "c_num_bol", ls_num_bollettina)
		//inserisco l'id_doc_sald
//		select d.id_documento
//		into :ll_id_doc_sald
//		from dba.documento d, riga_documento r
//		where r.id_documento=d.id_documento and r.id_riga_documento=:ll_riga_bol_prov
//		;
		//if ll_id_doc_sald>0 then 	dw_3.setitem(ll_riga, "id_doc_sald",ll_id_doc_sald )
		li_pezzi=dw_1.getitemnumber(al_row, "pezzi")
		//samy 30092020 aumentare il numero dei PZ necessari del 3% no lo faccio direttamnte nella dw
		dw_3.setitem(ll_riga, "qta",li_pezzi) //+li_pezzi*3/100 )
		ll_riga_bol_prov=dw_1.getitemnumber(al_row, "id_riga_documento")
		dw_3.setitem(ll_riga, "id_riga_bol_provenienza",ll_riga_bol_prov )
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
		
			//se l'articolo è da saldare lo vedo dalla tabella "acc_da_saldare"
		select id_accessorio
		into :ll_test
		from dba.acc_da_saldare where acc_da_saldare=:ls_cod_accessorio; //lo faccio solo se l'accessorio è adatto (segnato in acc_da_saldare)
		
		ls_cliente=dw_1.getitemstring(al_row, "cliente")
		ls_cl_da_saldare=""
		select cliente into :ls_cl_da_saldare from dba.cliente_da_saldare where cliente=:ls_cliente;
			// Ora 13/10/2021, se il cliente associato è da saldare SI SALDA E se anche l'accessorio è da saldare(SE C'è è DA SALDARE, ALTRIMENTI no, IL CONTROLLO LO FACCIO DIRETTAMETNE NELLA dw)
		//if ll_test<=0 or isnull(ll_test) then //se è già da saldare inutile controllare oltre ... NO! ERRATO! DEVE ESSERE DA Saldare e avere sald (ecc..) nella des_libera!!!!
			//2021 05 01 da oggi no! Samy vuole che se nella des_lib c'è "tutt"+"Anel"+"Sald" vada "-SALD" comuqnue anche se l'accesorio non è nella tabella
			ls_des_libera=dw_1.getitemstring(al_row, "des_libera")
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
				dw_3.setitem(ll_riga, "qta_distinta",li_qta )
			end if
		end if
		//ora aggiungo eventuale aggiunta (acc_aggiunto)  //20220117
		if ls_acc_aggiunto>" " then
			ll_riga_acc_2=dw_3.insertrow(0)
			if ll_id_doc_sald>0 then 	dw_3.setitem(ll_riga_acc_2, "id_doc_sald",ll_id_doc_sald )
			dw_3.setitem(ll_riga_acc_2, "qta",li_pezzi) //+li_pezzi*3/100 )
			dw_3.setitem(ll_riga_acc_2, "id_riga_bol_provenienza",ll_riga_bol_prov )
		//	if as_flag='A' then
			if isnumber(left(ls_acc_aggiunto, 1)) then 	//la prima lettera se è un numero indica la qta_distinta (li_qta)
				if integer(left(ls_acc_aggiunto, 1))>0 then li_qta=integer(left(ls_acc_aggiunto, 1)) else  li_qta=1
				ls_acc_aggiunto=right(ls_acc_aggiunto, len(ls_acc_aggiunto) - 1)
			end if
			dw_3.setitem(ll_riga_acc_2, "qta_distinta",li_qta )
			dw_3.setitem(ll_riga_acc_2, "c_num_bol", ls_num_bollettina)
		end if
		//fine controllo sostituzione20210902
		//20210501: samy dice: se nella descrizione c'è "TUTT"+SALD + ANEL in combinazione di almeno 2/3 sono da saldare (-SALD), 
		//ma anche se nella des_lib non c'è nulla SE trovo cliente da saldare E accessorio da saldare metto comuqnue -SALD (a meno che non sia un'eccezione lb_eccezione=false
//		if (ll_test>0 and  ls_cl_da_saldare> "  ") or  (pos(ls_des_libera, "TUTT")>0 and  pos(ls_des_libera, "ANEL")>0) or  (pos(ls_des_libera, "TUTT")>0 &
//			and pos(ls_des_libera, "SALD")>0) or (pos(ls_des_libera, "ANEL")>0 and pos(ls_des_libera, "SALD")>0) and lb_eccezione  then
//				ls_cod_accessorio+="-SALD"
//		end if
		//proviamo così 24092021 ll_test lo segno alla riga 56 più sopra (esiste nella tabella degli accesori da saldare)
		//lb_eccezione NON si usa più 20220628, ma lo lascio tanto è sempre TRUE, perché se si riusasse basterebbe scommentare le righe da 53 in giù
		if (ll_test>0 and  ls_cl_da_saldare> "  " and lb_eccezione) or  (pos(ls_des_libera, "TUTT")>0 and  pos(ls_des_libera, "ANEL")>0) or  (pos(ls_des_libera, "TUTT")>0 &
			and pos(ls_des_libera, "SALD")>0) or (pos(ls_des_libera, "AN")>0 and pos(ls_des_libera, "SALD")>0) and lb_eccezione  then  //(pos(ls_des_libera, "ANEL")>0 and pos(ls_des_libera, "SALD")>0)  cambiata 20220628
				ls_cod_accessorio+="-SALD"
		end if


		if pos(as_accessorio, "FP")>0  or pos(as_accessorio, "FT")>0 or  pos(as_accessorio, "MB")>0 or  pos(as_accessorio, "FB")>0 or pos(as_accessorio, "CU")>0 &
			or pos(as_accessorio, "CONCR")>0 then
			//per il bollo recupero tutto ciò che trovo dopo "bollo" nella tabella dei bolli
			ls_bollo=dw_1.getitemstring(al_row, "bollo")
			if len(ls_bollo)>0 then
				//aggiunto 20230220 URGENTE!!!!! deve riportare anche il bollo
				//ls_bollo="'"+ls_bollo+"'"
				select first(descrizione) into :ls_des_bollo from dba.cod_bolli_k 
				where substring(art_bollo, 15, 20)= :ls_bollo order by art_bollo;
				ls_des_bollo=RIGHT(ls_des_bollo, len(ls_des_bollo) - pos(ls_des_bollo, "-"))
//				li_pos=pos(upper(ls_bollo), "BOLLO")
//				if li_pos>0 then
//					ls_bollo=right(ls_bollo,  len(ls_bollo) - (li_pos + 6))
//					ls_num_bollo=left(ls_bollo,  pos(ls_bollo, "-") - 1)
					ls_cod_accessorio+="-"+ ls_des_bollo   //ls_bollo
					//ls_cod_accessorio+= right(ls_bollo, len(ls_bollo) - len(ls_num_bollo) - 1)
				//end if //aggiunto 20230220 fino a qui
			end if
		end if
	//	end if
		dw_3.setitem(ll_riga, "accessorio",ls_cod_accessorio )
		dw_3.setitem(ll_riga, "data_lista",ldt_data )
		if ll_riga_acc_2>0 then
			dw_3.setitem(ll_riga_acc_2, "accessorio",ls_acc_aggiunto )
			dw_3.setitem(ll_riga_acc_2, "data_lista",ldt_data )
		end if
		
	end if
end if
end subroutine

public subroutine wf_stampa_video ();//integer i, li_pos
//string ls_accessorio
//decimal ldc_tot_pezzi
//long ll_riga, ll_breakrow
//boolean lb_found
//
//dw_2.sort()
//dw_2.groupcalc()
//dw_5.reset()
////dw_2.trigger event ue_update()
//dw_2.setsort("accessorio")
//dw_2.sort()
//cb_ricalcola_gruppo.triggerevent(clicked!)
////for i= 1 to dw_2.rowcount()
//////	ls_accessorio=dw_2.getitemstring(i, "accessorio")
//////	ldc_tot_pezzi=dw_2.getitemdecimal(i, "c_tot_pezzi")
//////	ll_riga=dw_5.insertrow(0)
//////	dw_5.setitem(ll_riga, "accessorio", ls_accessorio)
//////	dw_5.setitem(ll_riga, "qta", ldc_tot_pezzi)
////next
//
//lb_found = false
//ll_breakrow = -1
//DO    
//	ll_breakrow = ll_breakrow + 1
//	ll_breakrow = dw_2.FindGroupChange(ll_breakrow, 1)    
//	if ll_breakrow<=0 then exit  // If no breaks are found, exit.    
//	ls_accessorio=dw_2.getitemstring(ll_breakrow, "accessorio")
//	//28/12/2020a volte è troppo lungo e quindi lo divido
//	if len(ls_accessorio)>=24 then
//		li_pos=pos(ls_accessorio, " ")
//		if li_pos>0 then
//			ls_accessorio=left(ls_accessorio, li_pos -1)+"~r~n"+right(ls_accessorio, len(ls_accessorio) - li_pos)
//		else
//			ls_accessorio=left(ls_accessorio, 20)+"~r~n"+right(ls_accessorio, len(ls_accessorio) - 20)
//		end if
//	end if //fine divisione
//	ldc_tot_pezzi=dw_2.getitemdecimal(ll_breakrow, "c_tot_gruppo")
//	ll_riga=dw_5.insertrow(0)
//	dw_5.setitem(ll_riga, "accessorio", ls_accessorio)
//	dw_5.setitem(ll_riga, "qta", ldc_tot_pezzi+ldc_tot_pezzi*3/100) //aumento del 3% 20200930 samy
//
//LOOP WHILE ll_breakrow > 0
//
//
end subroutine

on w_bol_excel.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_agg_cod_articoli=create cb_agg_cod_articoli
this.dw_4=create dw_4
this.cb_save_as=create cb_save_as
this.cb_verifica_bol=create cb_verifica_bol
this.cb_fabbisogno=create cb_fabbisogno
this.dw_3=create dw_3
this.cb_st_fabbisogno=create cb_st_fabbisogno
this.cb_pulisci=create cb_pulisci
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_agg_cod_articoli
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.cb_save_as
this.Control[iCurrent+5]=this.cb_verifica_bol
this.Control[iCurrent+6]=this.cb_fabbisogno
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.cb_st_fabbisogno
this.Control[iCurrent+9]=this.cb_pulisci
end on

on w_bol_excel.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_agg_cod_articoli)
destroy(this.dw_4)
destroy(this.cb_save_as)
destroy(this.cb_verifica_bol)
destroy(this.cb_fabbisogno)
destroy(this.dw_3)
destroy(this.cb_st_fabbisogno)
destroy(this.cb_pulisci)
end on

event open;dw_2.settransobject(sqlca)
dw_1.settransobject(sqlca)

dw_2.retrieve()


dw_4.settransobject(sqlca)

end event

event ue_postopen;call super::ue_postopen;dw_3.modify("datawindow.detail.height=0")
end event

event resize;dw_1.width=newwidth - 105 - 540
dw_1.height=newheight - 292 - 1000
dw_2.height=newheight - 292 
dw_3.y=dw_1.height + dw_1.y +50
dw_3.x=newwidth - dw_3.width
cb_fabbisogno.x=dw_3.x - cb_fabbisogno.width - 50
cb_st_fabbisogno.x=dw_3.x - cb_st_fabbisogno.width - 50
cb_fabbisogno.y=dw_3.y
cb_st_fabbisogno.y=dw_3.y +dw_3.height -cb_st_fabbisogno.height
cb_pulisci.x=dw_3.x - cb_pulisci.width - 50
cb_pulisci.y=dw_3.y + dw_3.height/2 - cb_pulisci.height/2

cb_inserisci.y=newheight - 224
cb_inserisci.x=dw_1.x + 330
cb_cancella.y=newheight - 224
cb_salva.y=newheight - 224
cb_salva.x=cb_inserisci.x + 285
cb_cancella.x=cb_salva.x + 285

cb_stampa.x=cb_cancella.x + 285
cb_stampa.y=cb_salva.y


cb_primo.y=newheight - 208
cb_primo.x=cb_stampa.x + 270
cb_indietro.y=newheight - 208
cb_indietro.x=cb_primo.x + 160
cb_avanti.y=newheight - 208
cb_avanti.x=cb_indietro.x + 160
cb_ultimo.y=newheight - 208
cb_ultimo.x=cb_avanti.x + 128


cb_ok.y=newheight - 224
cb_ok.x=dw_1.x+dw_1.width - cb_ok.width
cb_annulla.y=newheight - 224
cb_annulla.x=cb_ok.x - 285
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_annulla.x - 285


cb_agg_cod_articoli.y=newheight - 224 
cb_agg_cod_articoli.x=dw_1.x+dw_1.width + cb_ok.width +30

cb_save_as.y=newheight - 224 
cb_save_as.x=cb_inserisci.x - cb_save_as.width - 60

cb_verifica_bol.y=newheight - 224 
cb_verifica_bol.x=dw_2.x 
end event

type cb_stampa from w_semplice_gd`cb_stampa within w_bol_excel
integer x = 2391
integer y = 1612
end type

type cb_ricerca from w_semplice_gd`cb_ricerca within w_bol_excel
integer x = 2921
integer y = 1612
end type

type cb_primo from w_semplice_gd`cb_primo within w_bol_excel
integer x = 974
integer y = 1328
end type

type cb_ultimo from w_semplice_gd`cb_ultimo within w_bol_excel
integer x = 1390
integer y = 1328
end type

type cb_indietro from w_semplice_gd`cb_indietro within w_bol_excel
integer x = 1134
integer y = 1328
end type

type cb_avanti from w_semplice_gd`cb_avanti within w_bol_excel
integer x = 1262
integer y = 1328
end type

type dw_1 from w_semplice_gd`dw_1 within w_bol_excel
integer x = 622
integer y = 40
integer width = 5221
integer height = 1524
string dataobject = "d_bol_excel_ra_dt"
boolean hscrollbar = true
end type

event dw_1::rbuttondown;string ls_art, ls_num_bol
long ll_id_doc,ll_id_riga_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if keydown(KeyControl!) then
	choose case dwo.name
		case "articolo"
			ls_art=dw_1.getitemstring(row, "articolo")
			dw_4.retrieve(ls_art)
			dw_1.visible=false
			dw_4.visible=true
		case "id_riga_documento"
			if row>0 then
				ll_id_riga_doc=	dw_1.getitemnumber(row, "id_riga_documento")
				select id_documento into :ll_id_doc from dba.riga_documento where id_riga_documento=:ll_id_riga_doc;
				if ll_id_doc>0 then
					s_list.s_identifica[1]="id_documento"
					s_list.s_modo=modo_modifica
					s_list.l_identifica[1]=ll_id_doc
					openwithparm(w_orafo, s_list)
				end if
			end if
			
		case "cod_barre"
			ls_num_bol=right(dw_1.getitemstring(row, "cod_barre"), 5)
			select id_documento into :ll_id_doc
			from documento 
			where  right(num_documento, 5)=:ls_num_bol;
			if ll_id_doc>0 then
				s_list.s_identifica[1]="id_documento"
				s_list.s_modo=modo_modifica
				s_list.l_identifica[1]=ll_id_doc
				openwithparm(w_orafo, s_list)
			end if
		
		
	end choose
end if


end event

event dw_1::clicked;call super::clicked;string ls_tag

if keydown(KeyControl!) then
	ls_tag=dwo.tag	
	messagebox("Informazione!", ls_tag)
end if
end event

type cb_inserisci from w_semplice_gd`cb_inserisci within w_bol_excel
integer x = 1527
integer y = 1612
end type

type cb_salva from w_semplice_gd`cb_salva within w_bol_excel
integer x = 1810
integer y = 1612
end type

type cb_cancella from w_semplice_gd`cb_cancella within w_bol_excel
integer x = 2098
integer y = 1612
end type

event cb_cancella::rbuttondown;//

dw_1.rowsmove(1, dw_1.rowcount(), primary!, dw_1, 1, delete!)


end event

type cb_annulla from w_semplice_gd`cb_annulla within w_bol_excel
integer x = 3200
integer y = 1612
end type

type cb_ok from w_semplice_gd`cb_ok within w_bol_excel
integer x = 3493
integer y = 1612
end type

type dw_2 from udw_000 within w_bol_excel
integer x = 73
integer y = 36
integer width = 521
integer height = 1524
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_data_bol_excel"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;datetime ldt_data


ldt_data=dw_2.getitemdatetime(currentrow, "data")

if ldt_data> datetime(date('1900-01-01'), now()) then dw_1.retrieve(ldt_data)
end event

event clicked;call super::clicked;dw_4.visible=false
dw_1.visible=true
end event

type cb_agg_cod_articoli from commandbutton within w_bol_excel
integer x = 4160
integer y = 1600
integer width = 750
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aggiungi Cliente a Codici Articoli"
end type

event clicked;integer i
string ls_cliente, ls_cod_articolo, ls_new_cod_articolo


for i= 1 to dw_1.rowcount() //per ogni articolo trovo se essite già in tabella ARTICOLO, se esiste lo aggiorno con il codice cliente in suffisso, altrimenti lo creo con codice cliete già presente
	ls_cliente=dw_1.getitemstring(i,"cliente")
	ls_cod_articolo=dw_1.getitemstring(i,"articolo")
	ls_new_cod_articolo=ls_cod_articolo+"-"+ls_cliente
next
end event

type dw_4 from udw_000 within w_bol_excel
boolean visible = false
integer x = 622
integer y = 40
integer width = 4677
integer height = 1524
integer taborder = 20
string dataobject = "d_bol_excel_ra_articolo"
end type

type cb_save_as from commandbutton within w_bol_excel
integer x = 759
integer y = 1612
integer width = 338
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Salva Come"
end type

event clicked;string ls_file

if not(directoryexists("c:\nita\xls")) then
	createdirectory("c:\nita\xls")
end if
ls_file=string(dw_2.getitemdatetime(dw_2.getrow(), "data"), "yyyy_mm_dd")
ls_file="c:\nita\xls\Bol_excel"+ls_file+".xls"

dw_1.saveas(ls_file, Excel!, false)


end event

type cb_verifica_bol from commandbutton within w_bol_excel
integer x = 1134
integer y = 1612
integer width = 338
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Verifica BOL"
end type

event clicked;integer i
string ls_cod_bollettina
long ll_id_riga_bol, ll_id_bol_attuale, ll_null

setnull(ll_null)

for i= 1 to dw_1.rowcount()
	ls_cod_bollettina=right(dw_1.getitemstring(i, "cod_barre"), 5)
	select id_riga_documento into :ll_id_riga_bol
	from riga_documento r, documento d
	where r.id_documento= d.id_documento and right(d.num_documento, 5)=:ls_cod_bollettina;
	if ll_id_riga_bol>0 then
		ll_id_bol_attuale=dw_1.getitemnumber(i, "id_riga_documento")
		if isnull(ll_id_bol_attuale) then ll_id_bol_attuale=0
		if ll_id_bol_attuale<>ll_id_riga_bol then
			dw_1.setitem(i, "id_riga_documento", ll_id_riga_bol)
		end if
	else //significa che non vi è documento collegato!!!!
		messagebox("Attenzione!", "La riga n. "+string(i)+" NON ha BOLLETTINA collegata!!! Controllare e ricreare la bollettina!")
		dw_1.setitem(i, "id_riga_documento", ll_null)
	end if
	
next
messagebox("INFORMAZIONE!", "Controllo Completato! Il campo 'id_riga_documento' sarà colorato per i collegamenti che sono stati cambiati!")
end event

type cb_fabbisogno from commandbutton within w_bol_excel
integer x = 2610
integer y = 2060
integer width = 343
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fabbisogno"
end type

event clicked;long ll_id_riga_bol, ll_riga_trovata, ll_righe, ll_id_sog
integer i, li_pezzi_bol, li_pezzi_xls, a, li_ret

ll_righe=dw_3.rowcount()
if ll_righe<=0 then
	
		//ll_id_riga_bol=dw_1.getitemnumber(i, "id_riga_documento")
		//li_pezzi_bol=dw_1.getitemnumber(i, "pezzi")
		wf_aggiungi()
		//wf_aggiungi_tag()

//	wf_stampa_video()  //20221110 da attivare più in qua
else
	messagebox("Attenzione!", "Cancellare le righe fabbisogno prima di crearne uno nuovo!")
end if
dw_3.modify("datawindow.detail.height=0")
dw_3.sort()
dw_3.groupcalc()
end event

type dw_3 from udw_base within w_bol_excel
integer x = 2976
integer y = 1716
integer width = 2866
integer height = 844
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_fab_accessori_k"
boolean hscrollbar = true
end type

event itemchanged;call super::itemchanged;dw_2.print(true,true)
end event

type cb_st_fabbisogno from commandbutton within w_bol_excel
integer x = 2610
integer y = 2436
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;dw_3.Modify("DataWindow.Print.DocumentName='Fabbisogno'")
dw_3.print(true, true)
end event

type cb_pulisci from commandbutton within w_bol_excel
integer x = 2610
integer y = 2248
integer width = 343
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci"
end type

event clicked;dw_3.reset()
end event

