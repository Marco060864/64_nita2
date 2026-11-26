forward
global type w_lega_doc_a_bollettina_pop from w_001
end type
type dw_1 from udw_base within w_lega_doc_a_bollettina_pop
end type
type cb_ok from commandbutton within w_lega_doc_a_bollettina_pop
end type
type cb_annulla from commandbutton within w_lega_doc_a_bollettina_pop
end type
type dw_2 from udw_base within w_lega_doc_a_bollettina_pop
end type
type rb_2016 from radiobutton within w_lega_doc_a_bollettina_pop
end type
type rb_2017 from radiobutton within w_lega_doc_a_bollettina_pop
end type
type rb_2018 from radiobutton within w_lega_doc_a_bollettina_pop
end type
type cb_legato from commandbutton within w_lega_doc_a_bollettina_pop
end type
type rb_2019 from radiobutton within w_lega_doc_a_bollettina_pop
end type
type rb_2020 from radiobutton within w_lega_doc_a_bollettina_pop
end type
type rb_2021 from radiobutton within w_lega_doc_a_bollettina_pop
end type
type rb_2022 from radiobutton within w_lega_doc_a_bollettina_pop
end type
type dw_3 from udw_001 within w_lega_doc_a_bollettina_pop
end type
type cbx_controllo from checkbox within w_lega_doc_a_bollettina_pop
end type
end forward

global type w_lega_doc_a_bollettina_pop from w_001
integer x = 1057
integer y = 483
integer width = 3255
integer height = 1740
windowtype windowtype = response!
dw_1 dw_1
cb_ok cb_ok
cb_annulla cb_annulla
dw_2 dw_2
rb_2016 rb_2016
rb_2017 rb_2017
rb_2018 rb_2018
cb_legato cb_legato
rb_2019 rb_2019
rb_2020 rb_2020
rb_2021 rb_2021
rb_2022 rb_2022
dw_3 dw_3
cbx_controllo cbx_controllo
end type
global w_lega_doc_a_bollettina_pop w_lega_doc_a_bollettina_pop

type variables
long il_id_doc
integer ii_13

end variables

forward prototypes
public subroutine wf_set_cod ()
public subroutine wf_rec_peso_bilancia (long al_riga_inserita)
public subroutine wf_controlla (decimal adc_qta, string as_num_bol, string as_test)
end prototypes

public subroutine wf_set_cod ();time lt_time1, lt_time

lt_time1=now()
		lt_time1=relativetime(lt_time1, 1)
		do
			lt_time=now()
		loop while lt_time<=lt_time1
		
dw_2.setitem(1, "cod_barre", "")
end subroutine

public subroutine wf_rec_peso_bilancia (long al_riga_inserita);DWObject my_dwo
decimal ld_peso_netto
long	ll_row, ll_id_articolo
string ls_metallo



w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()
dw_1.setitem(al_riga_inserita, "legato", ld_peso_netto)

close(w_bil)
end subroutine

public subroutine wf_controlla (decimal adc_qta, string as_num_bol, string as_test);long ll_riga_trovata

if as_test="ADD" then
	ll_riga_trovata=dw_3.insertrow(0)
	dw_3.setitem(ll_riga_trovata, "num_documento", "ADD: "+as_num_bol)
else
	ll_riga_trovata=dw_3.find("num_documento='"+as_num_bol+"'", 1, dw_3.rowcount())
end if
if ll_riga_trovata>0 then
	dw_3.setitem(ll_riga_trovata, "test", as_test)
	dw_3.setitem(ll_riga_trovata, "pz_bol", adc_qta)
end if
end subroutine

on w_lega_doc_a_bollettina_pop.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_2=create dw_2
this.rb_2016=create rb_2016
this.rb_2017=create rb_2017
this.rb_2018=create rb_2018
this.cb_legato=create cb_legato
this.rb_2019=create rb_2019
this.rb_2020=create rb_2020
this.rb_2021=create rb_2021
this.rb_2022=create rb_2022
this.dw_3=create dw_3
this.cbx_controllo=create cbx_controllo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_annulla
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.rb_2016
this.Control[iCurrent+6]=this.rb_2017
this.Control[iCurrent+7]=this.rb_2018
this.Control[iCurrent+8]=this.cb_legato
this.Control[iCurrent+9]=this.rb_2019
this.Control[iCurrent+10]=this.rb_2020
this.Control[iCurrent+11]=this.rb_2021
this.Control[iCurrent+12]=this.rb_2022
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.cbx_controllo
end on

on w_lega_doc_a_bollettina_pop.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_2)
destroy(this.rb_2016)
destroy(this.rb_2017)
destroy(this.rb_2018)
destroy(this.cb_legato)
destroy(this.rb_2019)
destroy(this.rb_2020)
destroy(this.rb_2021)
destroy(this.rb_2022)
destroy(this.dw_3)
destroy(this.cbx_controllo)
end on

event open;call super::open;long ll_righe, ll_riga_inserita

dw_1.settransobject(sqlca)
dw_3.settransobject(sqlca)

il_id_doc=message.doubleparm
ll_righe=dw_1.retrieve(il_id_doc)


dw_2.insertrow(1)
dw_2.post setfocus()

dw_3.retrieve(il_id_doc)

end event

type st_1 from w_001`st_1 within w_lega_doc_a_bollettina_pop
end type

type dw_1 from udw_base within w_lega_doc_a_bollettina_pop
integer x = 23
integer y = 28
integer width = 1778
integer height = 1128
boolean bringtotop = true
string dataobject = "d_produzione_2011_gd"
end type

event sqlpreview;call super::sqlpreview;//string ls_sql, ls_ordine
//long ll_id_ordine[]
//integer i
////integer i, li_pos
////
//	
//	
//	ls_sql=sqlsyntax
//	
//
//	if il_id_doc>0 then
//		ls_sql=ls_sql + ' where ("produzione_2011"."id_doc_produzione" = '+string(il_id_doc)+')'
//	end if
//	
//	setsqlpreview(ls_sql)
//
end event

event itemchanged;call super::itemchanged;integer li_numero
string ls_tipo
date ldt_data
decimal ldc_peso_filo_laccio, ldc_legato

choose case dwo.name
	case "n_lacci", "n_fili"
		li_numero=integer(data)			
		if dwo.name="n_lacci" then ls_tipo='L' else ls_tipo='F' 
		ldc_peso_filo_laccio=f_rec_prezzo_laccio_filo_rame(ls_tipo, ldt_data)
		if ldc_peso_filo_laccio>0 then
			ldc_legato=getitemdecimal(row, "legato")
			if ldc_legato>0 then
				ldc_legato -= ldc_peso_filo_laccio
				setitem(row, "legato", ldc_legato)
			end if
			
		end if
end choose
end event

type cb_ok from commandbutton within w_lega_doc_a_bollettina_pop
integer x = 2821
integer y = 168
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Riporta"
end type

event clicked;integer li_test, i
s_array s_bol
string ls_azienda

//datastore ds_salva_legame
//
//ds_salva_legame=create datastore
//ds_salva_legame.dataobject="d_produzione_2011_gd"
//ds_salva_legame.settransobject(sqlca)
//li_test=dw_1.rowscopy(1, dw_1.rowcount(), Primary!, ds_salva_legame, 1, Primary!)
//li_test=ds_salva_legame.rowcount()

//if dw_1.update()=1 then
//	commit;
//	for i= 1 to dw_1.rowcount()
//		s_bol.ll_id_doc[i]=dw_1.getitemnumber(i, "id_bollettina")
//	next
//	closewithreturn(parent, s_bol)
//else
//	rollback;
//	messagebox("Attenzione!", "Collegamento non salvato!")
//	
//end if
	select rag_soc_1
		into :ls_azienda
		from dba.azienda
		;
		ls_azienda=upper(ls_azienda)
if dw_1.rowcount()>0 then
	
	for i= 1 to dw_1.rowcount()
		s_bol.ll_id_doc[i]=dw_1.getitemnumber(i, "id_bollettina")
		
		s_bol.ldc_legato[i]=dw_1.getitemnumber(i, "legato")
		if cbx_controllo.checked then 
			s_bol.as_string[i]="ADD"
		else
			s_bol.as_string[i]=""
		end if
	next
	closewithreturn(parent, s_bol)
else
	
	messagebox("Attenzione!", "Nessuna Bollettina selezionata!")
	
end if

//destroy(ds_salva_legame)
end event

type cb_annulla from commandbutton within w_lega_doc_a_bollettina_pop
integer x = 251
integer y = 1544
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

type dw_2 from udw_base within w_lega_doc_a_bollettina_pop
integer x = 1824
integer y = 32
integer width = 969
integer height = 240
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ins_barcode_plurimo_ext"
end type

event editchanged;call super::editchanged;long ll_id_bollettina,ll_id_test, ll_riga_inserita,ll_riga2_inserita,ll_id_sog, ll_id_riga_bollettina
string ls_num_doc, ls_test, ls_anno, ls_azienda, ls_articolo, ls_num_bollettina
long ll_num_prog,ll_esiste, ll_id_riga_doc
date ldt_data_doc, ldt_data_doc_esistente, ldt_da_data
integer li_anno, li_num_riga
decimal{0} ldc_num_bol, ldc_qta, ldc_num_bollettina
string ls_num_doc_esistente, ls_profilo_doc_esistente

//
if dwo.name="cod_barre"  then
	if len(data)=2 then
		if data='80' then
			ii_13=13
		else
			ii_13=7
		end if
	end if
		
	if len(data)=7 and ii_13 <> 13  then
		select rag_soc_1
		into :ls_azienda
		from dba.azienda
		;
		select id_sog_commerciale into :ll_id_sog from dba.documento where id_documento=:il_id_doc;
		ls_azienda=upper(ls_azienda)
		//da cambiare subito!!! e son già 5 anni...
		if rb_2021.checked then
			li_anno=2021
		elseif rb_2020.checked then
			li_anno=2020	
		elseif rb_2019.checked then
			li_anno=2019
		elseif rb_2018.checked then
			li_anno=2018
		elseif rb_2017.checked then
			li_anno=2017
		elseif rb_2022.checked then
			li_anno=2022
		else
			li_anno=2016
		end if
		ldt_da_data=relativedate(today(), -90)
		if pos(ls_azienda, "PANNA")>0 or pos(ls_azienda, "SILVERG")>0  or pos(ls_azienda, "STELLE")>0 or pos(ls_azienda, "TITANS")>0 then
			//ls_num_doc=mid(data, 3, 5)   //20251016 cambio da 5 a 7 così allineamo tutto  
			ls_num_doc=data //mid(data, 3, 7)
			ldc_num_bol=dec(ls_num_doc)
			select first(r.id_riga_documento) , r.quantita, a.codice, r.id_documento 
			into :ll_id_riga_bollettina   , :ldc_qta, :ls_articolo, :ll_id_bollettina 
			from dba.riga_documento r,  dba.documento d, dba.articolo a
			where  r.provv_imp_carea=:ldc_num_bol  //20251014 aggiunto r.provv_imp_carea perché carea2 sono i lacci e da oggi servono, mantengo per compatibilità anche carea_2
			and d.id_documento=r.id_documento
			and r.id_articolo=a.id_articolo and d.id_prof_documento=28
			and data_documento>:ldt_da_data
			order by d.data_documento desc
			;
			if ll_id_bollettina>0 then
				ls_num_bollettina=string(ldc_num_bol,"#,0")
			else
				ls_num_doc=mid(data, 3, 5)   //20251016 se per ragioni di tempistica errata ci sono bollettine ancora a 5 cerco anche quelle... prenderò, al massimo, quella vecchia...  
				ldc_num_bol=dec(ls_num_doc)
				select first(r.id_riga_documento) , r.quantita, a.codice, r.id_documento 
				into :ll_id_riga_bollettina   , :ldc_qta, :ls_articolo, :ll_id_bollettina 
				from dba.riga_documento r,  dba.documento d, dba.articolo a
				where r.provv_imp_carea_2=:ldc_num_bol   //20251014 aggiunto r.provv_imp_carea perché carea2 sono i lacci e da oggi servono, mantengo per compatibilità anche carea_2
				and d.id_documento=r.id_documento
				and r.id_articolo=a.id_articolo and d.id_prof_documento=28
				and data_documento>:ldt_da_data
				order by d.data_documento desc
				;
				ls_num_bollettina=string(ldc_num_bol,"#,0")
			end if
			
		else	
			if li_anno=2022 then  //2022: si cambia.... in realtà dal 10/01, prima 
				ls_num_doc=data
				ll_num_prog=long(ls_num_doc)
				select id_documento, num_documento
				into :ll_id_bollettina, :ls_num_bollettina
				from dba.documento d, dba.prof_documento p
				where right(num_documento, 7)=:ls_num_doc
				//where num_progressivo=:ll_num_prog
				//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
				and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL' or p.codice='BOLCLIEN') //20230113 samy aggiungi per bol clienti
				and d.id_prof_documento=p.id_prof_documento
				
				//and year(data_documento)= 2023 
				;
			else
				ls_num_doc=mid(data, 3, 5)
				ll_num_prog=long(ls_num_doc)
		//11-05-12 cambio il modo di ricercare (per prog e non per num doc)
		//vedere inseguito se porta conseguenze in silverdreams (credo che precedentemente non sia stato usato e quindi direi di no!)
		//se è stato usato hanno smesso di usarlo da diversi mesi (10-12)
								
//			SELEcT DATA_DOCUMENTO
//			into :ldt_data_doc
//			from dba.documento
//			where id_documento=:il_id_doc
//			;
//			li_anno=year(ldt_data_doc)
		
				select id_documento, num_documento
				into :ll_id_bollettina, :ls_num_bollettina
				from dba.documento d, dba.prof_documento p
				where right(num_documento, 5)=:ls_num_doc
				//where num_progressivo=:ll_num_prog
				//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
				and (p.codice='BBOL' or p.codice='2BOL' or p.codice='OBOL' or p.codice='BOL')
				and d.id_prof_documento=p.id_prof_documento
				and year(data_documento)= :li_anno
				;
			end if
		end if
		if ll_id_bollettina>0 then
			//cambio perché altrimenti si può inserire 2 volte la stessa bollettina 
			//27-01-2016 ricambio perché si può mandare la stessa bollettina prima a saldare e poi a spazzolare ecc..
//			select id_doc_produzione
//			into :ll_id_test
//			from dba.produzione_2011
//			where id_bollettina=:ll_id_bollettina
//			;
			ls_test="id_bollettina="+string(ll_id_bollettina)
			ll_id_test=dw_1.find(ls_test, 1, dw_1.rowcount())
			if ll_id_test>0 then
				messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
			else
				//controllo utleriore esistenza bollettina in doc
				ll_esiste=0
				if pos(ls_azienda, "PANNA")>0 or pos(ls_azienda, "SILVERG")>0 or pos(ls_azienda, "STELLE")>0 or pos(ls_azienda, "TITANS")>0 then //and ll_id_sog=1869 then
					ldc_num_bollettina=dec(ls_num_doc)
					Select first(r.id_riga_documento),  d.data_documento, d.num_documento, p.codice, r.num_riga
					into :ll_id_riga_doc, :ldt_data_doc_esistente, :ls_num_doc_esistente, :ls_profilo_doc_esistente, :li_num_riga
					from dba.documento d, dba.prof_documento p, dba.riga_documento r
					where d.id_documento=r.id_documento and d.id_prof_documento=p.id_prof_documento and d.id_sog_commerciale=:ll_id_sog and
					//r.provv_imp_carea_2=:ldc_num_bollettina   //20220412
					//(r.provv_imp_carea_2=:ldc_num_bollettina)  //20220412 aggiunto r.provv_imp_carea perché carea2 sono i lacci e da oggi servono, quindi sposto il num bollettina in provv_imp_carea
					( r.provv_imp_carea=:ldc_num_bollettina  //20251014: aggiunto r.provv_imp_carea perché carea2 sono i lacci e da oggi servono, quindi sposto il num bollettina in provv_imp_carea
					or r.provv_imp_carea_2=:ldc_num_bollettina) //20251014 mantengo anche l'altro per compatibilità indietro, ma in poche settimane dovrebbe diventare inutile
					//and  d.id_prof_documento<>28 and d.id_prof_documento<>156  //20230920 cambio con sald=130
					  //20230920 cambio con sald=130
					and  d.id_prof_documento<>28  //47=fatlav, 54nc
					and data_documento>:ldt_da_data   //20250118 aggiunto perché trovava la bollettina a distanza di 10-12 mesi e non faceva andare avanti (perché è a 5 caratteri)
					  //20230920 fine
					 //20230118 da cambiare subito con qualcosa che non si debba aggiornare tutti gli anni
					and year(d.data_documento)>=2023  //28= ACLC importato in automatico
					order by r.id_riga_documento desc	;
					if ls_num_doc_esistente> "0" then
						messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a doc.: "+ls_profilo_doc_esistente+"-"+ls_num_doc_esistente+" del "+&
						string(ldt_data_doc_esistente, "dd/mm/yy")+" Num. riga: "+string(li_num_riga))
						return
					end if
				else
					select id_doc_produzione
					into : ll_esiste
					from dba.produzione_2011
					where id_bollettina=:ll_id_bollettina;
					if ll_esiste>0 then
						Select d.num_documento, d.data_documento, p.codice, r.num_riga
						into :ls_num_doc_esistente, :ldt_data_doc_esistente, :ls_profilo_doc_esistente, :li_num_riga
						from dba.documento d, dba.prof_documento p, dba.riga_documento r
						where d.id_documento=r.id_documento and d.id_prof_documento=p.id_prof_documento and 
						r.id_riga_documento=:ll_esiste
						;
						if cbx_controllo.checked=false then messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a doc.: "+ls_profilo_doc_esistente+"-"+ls_num_doc_esistente+" del "+&
						string(ldt_data_doc_esistente, "dd/mm/yy")+" Num. riga: "+string(li_num_riga))
						if pos(ls_azienda, "SILVER DR")>0 or pos(ls_azienda, "PANNA")>0 or pos(ls_azienda, "SILVERG")>0 or pos(ls_azienda, "STELLE")>0 or pos(ls_azienda, "TITANS")>0  then //20230112
							if cbx_controllo.checked then
								select a.codice, r.quantita
								into :ls_articolo, :ldc_qta
								from dba.riga_documento r, dba.articolo a, dba.documento d
								where d.id_documento=r.id_documento
								and r.id_articolo=a.id_articolo
								and d.id_documento=:ll_id_bollettina
								;
								wf_controlla(ldc_qta, ls_num_bollettina, "OK!")
							end if
						end if
						return
					end if
				end if
				ll_riga_inserita=dw_1.insertrow(0)
				//20230117 se è silvergold o panna metto l'id_riga_documento perché la bollettina è nello stesso doc insieme a tante altre
				if pos(ls_azienda, "PANNA")>0 or pos(ls_azienda, "SILVERG")>0 or pos(ls_azienda, "STELLE")>0 or pos(ls_azienda, "TITANS")>0 then 
					dw_1.setitem(ll_riga_inserita, "id_bollettina", ll_id_riga_bollettina)
				else
					dw_1.setitem(ll_riga_inserita, "id_bollettina", ll_id_bollettina)
				end if
				//20230117 fine
				dw_1.setitem(ll_riga_inserita, "id_doc_produzione", il_id_doc)
				select a.codice, r.quantita
				into :ls_articolo, :ldc_qta
				from dba.riga_documento r, dba.articolo a, dba.documento d
				where d.id_documento=r.id_documento
				and r.id_articolo=a.id_articolo
				and d.id_documento=:ll_id_bollettina
				;
				if ls_articolo>"" then
					dw_1.setitem(ll_riga_inserita, "c_art", ls_articolo)
					dw_1.setitem(ll_riga_inserita, "pezzi", ldc_qta)
					//se è Silver rdreams si altrimenti non recupera il peso
					if pos(ls_azienda, "SILVER DR")>0 then
						wf_rec_peso_bilancia(ll_riga_inserita)
						if cbx_controllo.checked then	wf_controlla(ldc_qta, ls_num_bollettina, "ADD")
					end if
					dw_1.setitem(ll_riga_inserita, "num_bollettina", ls_num_bollettina)
					
				end if
				dw_1.scrolltorow(ll_riga_inserita)
			end if
		else
			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
		end if
		dw_2.reset()
		dw_2.insertrow(1)
		dw_2.setfocus()
		dw_2.scrolltorow(1)
		
	elseif len(data)=13 then
		//090113: la ricerca trova le bollettine dell'anno scorso ... devo inserire l'esercizio
		//aggiungo registro ed esercizio
		ls_anno=mid(data, 4, 4)
		ls_num_doc=mid(data, 8, 5)
		ll_num_prog=long(ls_num_doc)
		select id_documento
		into :ll_id_bollettina
		from dba.documento d, dba.prof_documento p, registro r, esercizio e
		//where right(num_documento, 5)=:ls_num_doc
		where d.num_progressivo=:ll_num_prog
		//and (p.codice='BOL' or p.codice='SBOL' or p.codice='VBOL')
		and p.codice='VBOL'
		and d.id_prof_documento=p.id_prof_documento
		and d.id_registro=r.id_registro
		and r.id_esercizio=e.id_esercizio
		and e.codice=:ls_anno
		;
		if ll_id_bollettina>0 then
			ls_test="id_bollettina="+string(ll_id_bollettina)
			ll_id_test=dw_1.find(ls_test, 1, dw_1.rowcount())
			if ll_id_test>0 then
				messagebox("Attenzione!", "Bollettina n. prog.: "+ls_num_doc+" già legata a questo documento!")
				
			else
				ll_riga_inserita=dw_1.insertrow(0)
				dw_1.setitem(ll_riga_inserita, "id_bollettina", ll_id_bollettina)
				dw_1.setitem(ll_riga_inserita, "id_doc_produzione", il_id_doc)
				
			end if
		else
			messagebox("Attenzione!", "Bollettina n. prog.: "+ls_num_doc+" non trovata!")
		end if
		dw_2.reset()
		dw_2.insertrow(1)
		dw_2.setfocus()
		dw_2.scrolltorow(1)
	end if
end if

end event

type rb_2016 from radiobutton within w_lega_doc_a_bollettina_pop
integer x = 27
integer y = 1168
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "2016"
end type

type rb_2017 from radiobutton within w_lega_doc_a_bollettina_pop
integer x = 27
integer y = 1240
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "2017"
end type

type rb_2018 from radiobutton within w_lega_doc_a_bollettina_pop
integer x = 27
integer y = 1312
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "2018"
end type

type cb_legato from commandbutton within w_lega_doc_a_bollettina_pop
boolean visible = false
integer x = 2181
integer y = 684
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Legato"
end type

event clicked;DWObject my_dwo
decimal ld_peso_netto
long	ll_row, ll_id_articolo
string ls_metallo

w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()

close(w_bil)
end event

type rb_2019 from radiobutton within w_lega_doc_a_bollettina_pop
integer x = 27
integer y = 1380
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "2019"
end type

type rb_2020 from radiobutton within w_lega_doc_a_bollettina_pop
integer x = 27
integer y = 1452
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "2020"
end type

type rb_2021 from radiobutton within w_lega_doc_a_bollettina_pop
integer x = 27
integer y = 1516
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "2021"
end type

type rb_2022 from radiobutton within w_lega_doc_a_bollettina_pop
integer x = 27
integer y = 1584
integer width = 233
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "2022"
boolean checked = true
end type

type dw_3 from udw_001 within w_lega_doc_a_bollettina_pop
integer x = 1819
integer y = 288
integer width = 1390
integer height = 1344
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_verifica_bollettine_sald"
boolean vscrollbar = true
end type

type cbx_controllo from checkbox within w_lega_doc_a_bollettina_pop
integer x = 2811
integer y = 40
integer width = 366
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "CONTROLLO"
end type

