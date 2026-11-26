forward
global type w_bol_accessori0402 from w_001
end type
type dw_3 from udw_base within w_bol_accessori0402
end type
type cb_1 from commandbutton within w_bol_accessori0402
end type
type rb_2018 from radiobutton within w_bol_accessori0402
end type
type rb_2019 from radiobutton within w_bol_accessori0402
end type
type rb_2020 from radiobutton within w_bol_accessori0402
end type
type rb_2021 from radiobutton within w_bol_accessori0402
end type
type cb_crea_accessori from commandbutton within w_bol_accessori0402
end type
type dw_4 from udw_001 within w_bol_accessori0402
end type
type cb_inserisci from uo_commandbutton within w_bol_accessori0402
end type
type cb_salva from uo_commandbutton within w_bol_accessori0402
end type
type cb_cancella from uo_commandbutton within w_bol_accessori0402
end type
type cb_ricalcola_gruppo from commandbutton within w_bol_accessori0402
end type
type rr_1 from roundrectangle within w_bol_accessori0402
end type
type dw_1 from udw_base within w_bol_accessori0402
end type
type dw_2 from udw_base within w_bol_accessori0402
end type
type dw_5 from udw_000 within w_bol_accessori0402
end type
type cb_crea_sald from commandbutton within w_bol_accessori0402
end type
type dw_6 from udw_000 within w_bol_accessori0402
end type
type cb_st_dw_2 from commandbutton within w_bol_accessori0402
end type
type cb_2 from commandbutton within w_bol_accessori0402
end type
type cb_4 from commandbutton within w_bol_accessori0402
end type
type cb_3 from commandbutton within w_bol_accessori0402
end type
type cb_5 from commandbutton within w_bol_accessori0402
end type
type dw_7 from udw_001 within w_bol_accessori0402
end type
type cb_6 from commandbutton within w_bol_accessori0402
end type
type cb_reset_filtro from commandbutton within w_bol_accessori0402
end type
type cb_7 from commandbutton within w_bol_accessori0402
end type
end forward

global type w_bol_accessori0402 from w_001
boolean visible = false
integer width = 5472
integer height = 2820
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
end type
global w_bol_accessori0402 w_bol_accessori0402

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
boolean ib_gia_creati=false
integer ii_sort
end variables

forward prototypes
public subroutine wf_inserisci_in_lista (string as_accessorio, long al_row, string as_flag)
public subroutine wf_aggiungi ()
public subroutine wf_stampa_video ()
public subroutine wf_ins_righe_doc ()
end prototypes

public subroutine wf_inserisci_in_lista (string as_accessorio, long al_row, string as_flag);//arriva 2AN8 la prima lettera è la qta in cui è presente in distinta (in questo caso per fare 1 pezzo occorrono 2 an8)
integer li_qta, li_pezzi, li_pos, i, A
string ls_cod_accessorio, ls_appoggio,ls_bollo, ls_num_bollo, ls_num_bollettina,ls_des_libera, ls_da_saldare,ls_cl_da_saldare
long ll_riga, ll_riga_bol_prov, ll_id_doc_sald, ll_test
datetime ldt_data


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
		//inserisco l'id_doc_sald
		select d.id_documento
		into :ll_id_doc_sald
		from dba.documento d, riga_documento r
		where r.id_documento=d.id_documento and r.id_riga_documento=:ll_riga_bol_prov
		;
		dw_2.setitem(ll_riga, "id_doc_sald",ll_id_doc_sald )
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
		if pos(ls_cod_accessorio, "AN SAMY")>0 then ls_cod_accessorio="ANSAMY"
		if pos(ls_cod_accessorio, "CU024")> 0 then ls_cod_accessorio="CU024"
		//samy 26/09/2020: se nella des_libera ci sono TUTTI o ANELLI o SALDATI devo aggiungere la codice "-SALD"
		ll_test=0
		select id_accessorio
		into :ll_test
		from dba.acc_da_saldare where acc_da_saldare=:ls_cod_accessorio; //ma lo faccio solo se l'accessorio è adatto (segnato in acc_da_saldare)
		if ll_test>0 then
			ls_des_libera=dw_4.getitemstring(al_row, "des_libera")
			ls_des_libera=upper(ls_des_libera)	
			ls_cl_da_saldare=dw_4.getitemstring(al_row, "cliente_da_saldare")
			if pos(ls_des_libera, "SALD")>0 or ls_cl_da_saldare> "  " then ls_cod_accessorio+="-SALD"
		end if
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
		dw_2.setitem(ll_riga, "accessorio",ls_cod_accessorio )
		dw_2.setitem(ll_riga, "data_lista",ldt_data )
	end if
end if





end subroutine

public subroutine wf_aggiungi ();string ls_des_accessori, ls_singolo_acc, ls_bollo, ls_bollo_ok
integer li_pos, i, a

for i=1 to dw_4.rowcount()
	li_pos=0
	ls_des_accessori=""
	a=0
	ls_des_accessori=dw_4.getitemstring(i, "cod_accessori_k_descrizione")
	if len(ls_des_accessori)>0 then
		li_pos=pos(ls_des_accessori, "+")
		ls_singolo_acc=mid(ls_des_accessori, a, li_pos - 1)
		wf_inserisci_in_lista(ls_singolo_acc, i, "A")
		do while li_pos>0
			a=li_pos+1
			li_pos=pos(ls_des_accessori, "+", li_pos+1)
			ls_singolo_acc=mid(ls_des_accessori, a, li_pos  - a)
			wf_inserisci_in_lista(ls_singolo_acc, i, "A")
			
			//li_pos=pos(ls_des_accessori, "+", li_pos+1)
		loop
		ls_singolo_acc=right(ls_des_accessori, len(ls_des_accessori) - a+1)
		wf_inserisci_in_lista(ls_singolo_acc, i, "A")
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
string ls_accessorio
decimal ldc_tot_pezzi
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
	ll_riga=dw_5.insertrow(0)
	dw_5.setitem(ll_riga, "accessorio", ls_accessorio)
	dw_5.setitem(ll_riga, "qta", ldc_tot_pezzi+ldc_tot_pezzi*3/100) //aumento del 3% 20200930 samy

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

on w_bol_accessori0402.create
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
end on

on w_bol_accessori0402.destroy
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


//dw_3.setitem(1, "da_data", relativedate(today(), - 30))






end event

event ue_postopen;call super::ue_postopen;dw_3.post setfocus()
dw_3.post setcolumn("cod_barre")
end event

type st_1 from w_001`st_1 within w_bol_accessori0402
end type

type dw_3 from udw_base within w_bol_accessori0402
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
		end if
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
					messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata al fabbisogno del "+string(ldt_data_lista, "dd/mm/yy/ hh:mm"))
				else
					for i=1 to dw_1.rowcount()
						dw_1.setitem(i, "riga_documento_peso_netto_evaso", i)
					next
					dw_1.retrieve(ll_id_bollettina)
					ib_gia_creati=false
					dw_3.setitem(1, "cod_barre", "")
					dw_3.setfocus()
					dw_3.setcolumn("cod_barre")
					
					//ll_righe=dw_2.retrieve(ll_id_bollettina)
					//wf_bilancia(dw_2.rowcount())
					//setcolumn("cod_barre_galvanica")
				end if
			end if
		else
			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
		end if
	end if
end if


end event

type cb_1 from commandbutton within w_bol_accessori0402
integer x = 3424
integer y = 2500
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

event clicked;//integer i, li_pos
//string ls_accessorio
//decimal ldc_tot_pezzi
//long ll_riga, ll_breakrow
//boolean lb_found 
//
//dw_5.reset()
//dw_2.trigger event ue_update()
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
//	ldc_tot_pezzi=dw_2.getitemdecimal(ll_breakrow, "c_tot_gruppo")
//	ll_riga=dw_5.insertrow(0)
//	dw_5.setitem(ll_riga, "accessorio", ls_accessorio)
//	dw_5.setitem(ll_riga, "qta", ldc_tot_pezzi)
//
//LOOP WHILE ll_breakrow > 0
if ib_gia_creati=false then
	dw_2.trigger event ue_update()
end if
dw_5.sort()
dw_5.print(true, true)
	
end event

type rb_2018 from radiobutton within w_bol_accessori0402
integer x = 82
integer y = 268
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

type rb_2019 from radiobutton within w_bol_accessori0402
integer x = 82
integer y = 364
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

type rb_2020 from radiobutton within w_bol_accessori0402
integer x = 82
integer y = 452
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

type rb_2021 from radiobutton within w_bol_accessori0402
integer x = 82
integer y = 540
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
boolean checked = true
end type

type cb_crea_accessori from commandbutton within w_bol_accessori0402
integer x = 361
integer y = 260
integer width = 581
integer height = 112
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

event clicked;long ll_id_riga_bol, ll_riga_trovata, ll_righe
integer i, li_pezzi_bol, li_pezzi_xls, a, li_ret

ll_righe=dw_2.rowcount()
if ll_righe<=0 then
	for i=1 to dw_1.rowcount()
		ll_id_riga_bol=dw_1.getitemnumber(i, "riga_documento_id_riga_documento")
		li_pezzi_bol=dw_1.getitemnumber(i, "riga_documento_quantita")
		if ll_id_riga_bol>0 then
			ll_righe=dw_4.rowcount()
			li_ret=dw_4.retrieve(ll_id_riga_bol)
			if li_ret>0 and ll_righe< dw_4.rowcount() then
				ll_riga_trovata=dw_4.find("id_riga_documento="+string(ll_id_riga_bol), 1,dw_4.rowcount())
				li_pezzi_xls=dw_4.getitemnumber(ll_riga_trovata, "pezzi")
				if li_pezzi_xls<>li_pezzi_bol then
					if messagebox("Attenzione!", "I pezzi della BOL NON coincidono con quelli XLS (del Vedi Bollettine)! Forse sono stati corretti. Vuoi riportare quelli della BOL?", stopsign!, yesno!)=1 then
						dw_4.setitem(ll_riga_trovata, "pezzi", li_pezzi_bol)
					end if
				end if
			else
				messagebox("Attenzione!", "La bollettina con id_riga="+string(ll_id_riga_bol)+" NON ha riferimento in Vedi_Bollettine Excel")
			end if
	
		else
			messagebox("Attenzione!", "Non c'è collegamento alla bollettina nel Vedi_Bollettine Excel")
		end if
	next
	wf_aggiungi()
	wf_stampa_video()
else
	messagebox("Attenzione!", "Non è ancora possibile creare la lista accessori in due volte! Resetta e carica TUTTO prima di creare la lista.")
end if

end event

type dw_4 from udw_001 within w_bol_accessori0402
integer x = 3401
integer y = 1748
integer width = 1998
integer height = 736
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_bol_excel_ra_id_riga_bol"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrievestart;call super::retrievestart;return 2
end event

type cb_inserisci from uo_commandbutton within w_bol_accessori0402
string tag = "Inserisce una nuova riga nella finestra che ha il fuoco."
integer x = 2939
integer y = 1044
integer width = 430
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
string text = "Inserisci"
end type

event clicked;long ll_riga
ll_riga=dw_2.trigger event ue_insert(0)

end event

type cb_salva from uo_commandbutton within w_bol_accessori0402
string tag = "Salva la finestra che ha il fuoco. Se essa è figlia, salva anche la finestra madre."
integer x = 2939
integer y = 1264
integer width = 430
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
string text = "Salva"
end type

event clicked;dw_2.trigger event ue_update()

end event

type cb_cancella from uo_commandbutton within w_bol_accessori0402
string tag = "Cancella la riga selezionata nella finestra che ha il fuoco. Richiede il salvataggio successivo per perfezionare la cancellazione."
integer x = 2939
integer y = 1152
integer width = 430
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare
ll_riga_da_cancellare=dw_2.getrow()
dw_2.trigger event ue_delete(ll_riga_da_cancellare)		

end event

type cb_ricalcola_gruppo from commandbutton within w_bol_accessori0402
integer x = 2939
integer y = 1508
integer width = 430
integer height = 96
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

type rr_1 from roundrectangle within w_bol_accessori0402
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 1073741824
integer x = 64
integer y = 260
integer width = 279
integer height = 376
integer cornerheight = 40
integer cornerwidth = 46
end type

type dw_1 from udw_base within w_bol_accessori0402
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

type dw_2 from udw_base within w_bol_accessori0402
integer x = 59
integer y = 848
integer width = 2866
integer height = 876
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_fab_accessori_k"
boolean hscrollbar = true
end type

event itemchanged;call super::itemchanged;dw_2.print(true,true)
end event

type dw_5 from udw_000 within w_bol_accessori0402
integer x = 59
integer y = 1736
integer width = 3328
integer height = 872
integer taborder = 60
string dataobject = "d_fab_acc_k_etic"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_crea_sald from commandbutton within w_bol_accessori0402
integer x = 361
integer y = 544
integer width = 581
integer height = 112
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
integer i, a
string ls_esiste_gia
long ll_id_bol_test

dw_6.accepttext()
s_list.l_id_riga[1]=100
s_list.l_id_riga[2]=dw_6.getitemnumber(1, "id_sog_commerciale")
if s_list.l_id_riga[2]>0 then
	for i=1 to dw_1.rowcount() 
		ll_id_bol_test=dw_1.getitemnumber(i, "id_documento")
		ls_esiste_gia=""
		select num_documento+' del '+string(data_documento) into :ls_esiste_gia from dba.produzione_2011 p, dba.riga_documento r, dba.documento d
		where p.id_bollettina=:ll_id_bol_test and r.id_documento=d.id_documento and p.id_doc_produzione=r.id_riga_documento;// order by d.num_documento ;
		if ls_esiste_gia>" " then
			messagebox("Attenzione!", "La bollettina alla riga "+string(i)+" è già derivata in doc sald: "+ls_esiste_gia)
			continue
//			if messagebox("Attenzione!", "La bollettina alla riga "+string(i)+" è già derivata in doc sald: "+ls_esiste_gia+", vuoi aggiungere altre righe?", stopsign!,yesno!)=1 then
//				//wf_ins_righe_doc()
//				
//			else
//				continue
//			end if
		end if
		a++
		s_list.l_id_riga[a+2]=	ll_id_bol_test
	next
	if upperbound(s_list.l_id_riga)>=3 then
		//s_list.s_identifica[1]="id_documento"
		s_list.s_modo=modo_inserisci
		s_list.s_win_parametri="DV"
		openwithparm(w_orafo, s_list)
	else
		messagebox("Attenzione!", "Tutte le righe sono state scartate! Probabilmente sono già state derivate in SALD!")
	end if
else
	messagebox("Attenzione!", "L'intestatario del DOC DEVE essere inserito!")
end if


//ldw_master=w_orafo_documento_ordine_cx.tab_1.tabpage_1.dw_documento_ordine_ff
//idw_master.is_list = Message.PowerObjectParm
//Message.Processed=TRUE
//
//is_tipo_documento= idw_master.is_list.s_win_parametri
end event

type dw_6 from udw_000 within w_bol_accessori0402
integer x = 55
integer y = 660
integer width = 896
integer height = 208
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_scegli_fo"
boolean border = false
borderstyle borderstyle = stylebox!
end type

type cb_st_dw_2 from commandbutton within w_bol_accessori0402
integer x = 2939
integer y = 1620
integer width = 430
integer height = 96
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

type cb_2 from commandbutton within w_bol_accessori0402
integer x = 361
integer y = 396
integer width = 581
integer height = 112
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

event clicked;dw_1.reset()
dw_2.reset()
dw_4.reset()
dw_5.reset()

dw_3.setitem(1, "cod_barre", "")
dw_3.setfocus()
dw_3.setcolumn("cod_barre")
end event

type cb_4 from commandbutton within w_bol_accessori0402
integer x = 2939
integer y = 1384
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
string text = "Stampa"
end type

event clicked;dw_2.print(true, true)
end event

type cb_3 from commandbutton within w_bol_accessori0402
integer x = 2939
integer y = 844
integer width = 430
integer height = 92
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

type cb_5 from commandbutton within w_bol_accessori0402
integer x = 2939
integer y = 940
integer width = 430
integer height = 92
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

type dw_7 from udw_001 within w_bol_accessori0402
integer x = 3401
integer y = 28
integer width = 1998
integer height = 1540
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Ristampa liste già create"
string dataobject = "D_VEDI_FAB_PASSATI"
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

type cb_6 from commandbutton within w_bol_accessori0402
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

type cb_reset_filtro from commandbutton within w_bol_accessori0402
integer x = 3931
integer y = 1596
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

type cb_7 from commandbutton within w_bol_accessori0402
integer x = 4329
integer y = 1596
integer width = 594
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ri-Crea solo scelti"
end type

event clicked;integer i
long ll_id_bollettina, ll_id_doc

dw_7.setfilter("c_scelto=1")
dw_7.filter()
for i= 1 to dw_7.rowcount()
		
	ll_id_doc=dw_7.getitemnumber(i,  "documento_id_documento")
	//select first(id_documento) into :ll_id_bollettina from dba.riga_documento where id_riga_documento=:ll_id_riga order by id_riga_documento;
	dw_1.retrieve(ll_id_doc)
next
ib_gia_creati=true
end event

