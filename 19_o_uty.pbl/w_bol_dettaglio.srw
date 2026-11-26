forward
global type w_bol_dettaglio from w_ra_padre_figlio_cx
end type
type cb_stampa from commandbutton within w_bol_dettaglio
end type
type cb_pdf from commandbutton within w_bol_dettaglio
end type
type cb_crea_ddt from commandbutton within w_bol_dettaglio
end type
type dw_4 from udw_figlia within w_bol_dettaglio
end type
type cb_agg_rbol from commandbutton within w_bol_dettaglio
end type
type st_1 from statictext within w_bol_dettaglio
end type
type cb_da_excel from commandbutton within w_bol_dettaglio
end type
type dw_3 from udw_000 within w_bol_dettaglio
end type
type r_1 from rectangle within w_bol_dettaglio
end type
end forward

global type w_bol_dettaglio from w_ra_padre_figlio_cx
string tag = "w_bol_dettaglio"
integer width = 5943
integer height = 2728
string title = "w_bol_dettaglio"
cb_stampa cb_stampa
cb_pdf cb_pdf
cb_crea_ddt cb_crea_ddt
dw_4 dw_4
cb_agg_rbol cb_agg_rbol
st_1 st_1
cb_da_excel cb_da_excel
dw_3 dw_3
r_1 r_1
end type
global w_bol_dettaglio w_bol_dettaglio

type variables
string is_tipo
end variables

forward prototypes
public subroutine wf_retrieve (date adt_data)
public function decimal wf_bilancia (string as_bollettina, long al_riga_inserita)
end prototypes

public subroutine wf_retrieve (date adt_data);
string ls_num_bol


declare  rec_catena_resa cursor for
select num_bollettina from dba.catena_resa
where data_reso = :adt_data and tipo=:is_tipo;
open  rec_catena_resa;
fetch rec_catena_resa into :ls_num_bol;
DO WHILE sqlca.sqlcode = 0
	dw_2.retrieve(ls_num_bol, adt_data)
	fetch rec_catena_resa into :ls_num_bol;
LOOP
close rec_catena_resa;
//dw_2.setfilter("tipo='"+is_tipo+"'")
//dw_2.filter()
end subroutine

public function decimal wf_bilancia (string as_bollettina, long al_riga_inserita);DWObject my_dwo
decimal ld_peso_netto,ldc_coef_calo, ldc_titolo, ldc_calo, ldc_fino
long	ll_row, ll_id_articolo, ll_riga_trovata,ll_id_prof,ll_id_riga_bol
string ls_metallo,ls_test



w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()
if ld_peso_netto=0 or isnull(ld_peso_netto) then 
	dw_1.setfocus()
	dw_1.setcolumn("cod_barre")
end if
close (w_bil)
return ld_peso_netto
end function

on w_bol_dettaglio.create
int iCurrent
call super::create
this.cb_stampa=create cb_stampa
this.cb_pdf=create cb_pdf
this.cb_crea_ddt=create cb_crea_ddt
this.dw_4=create dw_4
this.cb_agg_rbol=create cb_agg_rbol
this.st_1=create st_1
this.cb_da_excel=create cb_da_excel
this.dw_3=create dw_3
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stampa
this.Control[iCurrent+2]=this.cb_pdf
this.Control[iCurrent+3]=this.cb_crea_ddt
this.Control[iCurrent+4]=this.dw_4
this.Control[iCurrent+5]=this.cb_agg_rbol
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_da_excel
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.r_1
end on

on w_bol_dettaglio.destroy
call super::destroy
destroy(this.cb_stampa)
destroy(this.cb_pdf)
destroy(this.cb_crea_ddt)
destroy(this.dw_4)
destroy(this.cb_agg_rbol)
destroy(this.st_1)
destroy(this.cb_da_excel)
destroy(this.dw_3)
destroy(this.r_1)
end on

event ue_postopen;call super::ue_postopen;date ldt_oggi

ldt_oggi=dw_1.getitemdate(1, "data_reso")
wf_retrieve(ldt_oggi)

//dw_2.setfilter("tipo='"+is_tipo+"'")
//dw_2.filter()
end event

event resize;cb_inserisci.y=newheight - 224
cb_inserisci.x=dw_1.x
cb_cancella.y=newheight - 224
cb_salva.y=newheight - 224
cb_salva.x=cb_inserisci.x + 285
cb_cancella.x=cb_salva.x + 285
//cb_primo.y=newheight - 208
//cb_primo.x=cb_inserisci.x + 918
//cb_indietro.y=newheight - 208
//cb_indietro.x=cb_primo.x + 160
//cb_avanti.y=newheight - 208
//cb_avanti.x=cb_indietro.x + 160
//cb_ultimo.y=newheight - 208
//cb_ultimo.x=cb_avanti.x + 128
cb_ok.y=newheight - 224
cb_ok.x=newwidth - cb_ok.width - 100
cb_ricerca.y=newheight - 224
cb_ricerca.x=cb_ok.x - 285
cb_annulla.y=newheight - 224
cb_annulla.x=cb_ricerca.x - 285
dw_2.width=this.width - 150

dw_2.y=dw_1.y + dw_1.height + 20
dw_2.height=this.height - (dw_1.y + dw_1.height + 20) - 280 - cb_ok.height

cb_da_excel.y=cb_ricerca.y
cb_da_excel.x=cb_annulla.x -285
end event

event open;call super::open;s_list_main ls_list

DW_4.SETTRANSOBJECT(SQLCA)

 ls_list=message.powerobjectparm
 is_tipo=ls_list.s_win_parametri

if ls_list.s_win_parametri="M" then
	r_1.fillcolor=255
	dw_2.dataobject="d_bol_dettaglio"
	
else
	r_1.fillcolor=16777215
	dw_2.dataobject="d_bol_dettaglio_kar"
end if
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
end event

type cb_ricerca from w_ra_padre_figlio_cx`cb_ricerca within w_bol_dettaglio
end type

type dw_1 from w_ra_padre_figlio_cx`dw_1 within w_bol_dettaglio
integer x = 78
integer y = 36
integer width = 2935
integer height = 220
string dataobject = "d_bol_dett_input"
end type

event dw_1::itemchanged;call super::itemchanged;string ls_bol, ls_filtro,ls_test
decimal ldc_peso,  ldc_peso_laccio, ldc_tot_peso_lacci,ldc_tara
date ldt_data
long ll_righe,ll_riga_esistente,ll_retrieve, ll_null,ll_riga_nuova, ll_max_riga, ll_num_riga
integer li_num_lacci,li_num_riga
dwitemstatus ldw_status

setnull(ll_null)
if dwo.name="cod_barre" then
	ls_bol=data
	// se esiste PK ..
	if len(ls_bol)=7 then
		ldt_data=dw_1.getitemdate(1, "data_reso")
		ls_filtro="num_bollettina='"+ls_bol+"' and tipo='"+is_tipo+"' and data_reso= date('"+string(ldt_data)+"')"
		ll_riga_esistente=dw_2.find(ls_filtro, 1, 99999999, primary!)
		if ll_riga_esistente>0 then
			messagebox("Attenzione!", "La riga n. = "+string(ll_riga_esistente)+" ha già la bollettina "+ ls_bol)
			post setitem(1, "cod_barre", "")
			post setcolumn("cod_barre") 
			return
		end if
		ll_righe=dw_2.rowcount()
//		dw_2.setfilter("")
//		dw_2.filter()
		select num_bollettina into :ls_test from dba.catena_resa
		where data_reso=today() and tipo=:is_tipo;
		if isnull(ls_test) or ls_test<>ls_bol then
			select max (num_riga) into :li_num_riga from dba.catena_resa
			where data_reso=today() and tipo=:is_tipo;
			if isnull(li_num_riga) or li_num_riga=0 then li_num_riga=1
			insert into dba.catena_resa ("data_reso", "num_bollettina", "legato", "num_riga", "tipo")
			values (today(), :ls_bol, 0, :li_num_riga, :is_tipo);
			if sqlca.sqlNrows>0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "bol.: "+ls_bol+" NON inserita in catena resa!")
				return
			end if
		end if
		ll_retrieve=dw_2.retrieve(ls_bol, ldt_data)
		if ll_retrieve>ll_righe then //20241014 controllo se ha inserito la riga: se la bollettina NON esiste, ad esempio, non inserisce la riga con il retrieve perché non la trova....
			ls_filtro="num_bollettina='"+ls_bol+"' "
			ll_riga_nuova=dw_2.find(ls_filtro, 1, 99999999, primary!)
			ll_num_riga=dw_2.getitemnumber(ll_retrieve, "c_max_num_riga")  //20250321 è primavera si cambia modo di stabilire il massimo num_riga (anche perché quello precedente era una castroneria..(ma non c'erano le cancellazioni qunado l'ho pensato)
			dw_2.setitem(ll_riga_nuova, "num_riga", ll_num_riga+1)
			dw_2.setitem(ll_riga_nuova, "tipo", is_tipo)
			dw_2.setitem(ll_riga_nuova, "data_reso", ldt_data)
			//dw_2.sort()
			ldc_peso=wf_bilancia(ls_bol, 1)  //RIATTIVA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//ldc_peso=250
			dw_2.setitem(ll_riga_nuova, "legato", ldc_peso)
			dw_2.setitem(ll_riga_nuova, "c_peso_lordo", ldc_peso)
			dw_2.setitem(ll_riga_nuova, "num_bollettina", ls_bol)
			dw_2.setitem(ll_riga_nuova, "data_reso", ldt_data)
			//20241029 inserisco la data ora creazione
			dw_2.setitem(ll_riga_nuova, "data_ora_creazione", today())
			
			ldw_status=dw_2.getitemstatus(ll_riga_nuova,0, primary!)
			//dw_2.setitemstatus(ll_riga_nuova,0, primary!, newmodified!)
			dw_2.trigger event ue_update()
			dw_2.sort()
//			dw_2.setfilter("tipo='"+is_tipo+"'")
//			dw_2.filter()
			setitem(1, "n_lacci", 0)  //20241014 aggiungo per facilitare insierimento
			post setcolumn("n_lacci") 
		else
			//riga non inserita
			messagebox("Attenzione!", "La bollettina "+ ls_bol+ " NON esiste?!?!")
		end if
		
	else
		
	end if

	dw_1.post setfocus()
	dw_1.post setcolumn("cod_barre")	
elseif dwo.name="n_lacci" then
	ldc_peso=dw_2.getitemdecimal(1, "legato")
	li_num_lacci=integer(data)
	ldt_data=dw_1.getitemdate(1, "data_reso")
	ldc_peso_laccio=f_rec_prezzo_laccio_filo_rame( "L", ldt_data)
	ldc_tot_peso_lacci=li_num_lacci*ldc_peso_laccio
	ldc_peso -= ldc_tot_peso_lacci
	dw_2.setitem(1, "legato",ldc_peso )
	dw_2.setitem(1, "lacci",li_num_lacci ) //20240925 aggiungo peso dei lacci
	dw_2.trigger event ue_update()
	post setcolumn("tara")   //20241014 aggiungo per facilitare insierimento
elseif dwo.name="tara" then
	ldc_peso=dw_2.getitemdecimal(1, "legato")
	ldc_tara=dec(data)
	if ldc_tara<ldc_peso then
		ldc_peso -= ldc_tara
		dw_2.setitem(1, "legato",ldc_peso )
		dw_2.setitem(1, "tara",ldc_tara ) //20240925 aggiungo peso tara
		dw_2.trigger event ue_update()
	end if
	post setitem(1, "tara", ll_null)
	post setitem(1, "n_lacci", 0)
	post setitem(1, "cod_barre", "")
	post setcolumn("cod_barre")  //20241014 aggiungo per facilitare insierimento
elseif dwo.name="data_reso" then
	dw_2.reset()
	ldt_data=date(data)
	wf_retrieve(ldt_data)
end if

end event

event dw_1::rowfocuschanged;//
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;//if dwo.name="data_reso" then
//	post setitem(1, "cod_barre", "")
//	post setcolumn("cod_barre")
//	post setitem(1, "n_lacci", 0)
//	post setitem(1, "tara", 0)
//END IF
//if dwo.name="tara" then
//	post setitem(1, "tara", 0)
//	post setitem(1, "n_lacci", 0)
//	post setitem(1, "cod_barre", "")
//	post setcolumn("cod_barre")  //20241014 aggiungo per facilitare insierimento
//end if
end event

type dw_2 from w_ra_padre_figlio_cx`dw_2 within w_bol_dettaglio
integer y = 272
integer width = 5783
integer height = 1540
string dataobject = "d_bol_dettaglio"
end type

event dw_2::retrievestart;call super::retrievestart;return 2
end event

event dw_2::sqlpreview;//string ls_sql
////date ldt_data
//integer li_ret
////
//ls_sql=upper(sqlsyntax)
////
////ldt_data=today()
////
//ls_sql += " and (catena_resa.tipo='" +is_tipo+"' or catena_resa.tipo is null) "
//li_ret=setsqlpreview(ls_sql)
end event

event dw_2::itemchanged;call super::itemchanged;if dwo.name="num_riga" then dw_2.sort()


if dwo.name="descrizione" then  //20251013 richiesta Elena: se ho messo l'ultimo campo (descrizoine) il cursore torna all'inizio di tutto
	dw_1.post setfocus()
	dw_1.post setcolumn("cod_barre")
end if
end event

type cb_inserisci from w_ra_padre_figlio_cx`cb_inserisci within w_bol_dettaglio
end type

type cb_salva from w_ra_padre_figlio_cx`cb_salva within w_bol_dettaglio
end type

event cb_salva::clicked;
dw_2.trigger event ue_update()
end event

type cb_cancella from w_ra_padre_figlio_cx`cb_cancella within w_bol_dettaglio
end type

event cb_cancella::rbuttondown;call super::rbuttondown;long ll_riga_da_cancellare
integer i

if messagebox("Attenzione!", "Vuoi cancellare TUTTO? Dovrai confermare con il salvataggio!",  stopsign!, yesno!)=1 then
	for i= dw_2.rowcount() to 1 step -1
		dw_2.deleterow(i)
	next
end if

end event

type cb_annulla from w_ra_padre_figlio_cx`cb_annulla within w_bol_dettaglio
end type

type cb_ok from w_ra_padre_figlio_cx`cb_ok within w_bol_dettaglio
end type

type cb_stampa from commandbutton within w_bol_dettaglio
integer x = 3077
integer y = 36
integer width = 402
integer height = 220
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "STAMPA"
end type

event clicked;dw_2.print(true, true)
end event

type cb_pdf from commandbutton within w_bol_dettaglio
integer x = 3534
integer y = 36
integer width = 402
integer height = 220
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "PDF"
end type

event clicked;integer li_ret
string ls_nome_file

ls_nome_file="c:\nita\pdf\cat_resa1.pdf"//+string(today(),"dd_mm_yy hh_mm")+".pdf"
dw_2.Modify("Export.PDF.Method = Distill!")
dw_2.Modify("DataWindow.Print.printername = 'Sybase DataWindow PS'")
dw_2.Modify("Export.PDF.Distill.CustomPostScript='Yes'")
li_ret=dw_2.SaveAs(ls_nome_file, PDF!, FALSE)
IF LI_RET<> 1 THEN
	messagebox("Errore!", "File PDF non generato!")	
end if
end event

type cb_crea_ddt from commandbutton within w_bol_dettaglio
boolean visible = false
integer x = 5024
integer y = 568
integer width = 402
integer height = 220
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Crea DDT"
end type

event clicked;//integer li_ret, i, li_righe
//long     ll_null,ll_riga_doc, ll_id_doc, ll_id_galvanica,ll_id_doc_riga_da_cancellare, ll_riga_erase, ll_parametro[], ll_id_galv
//string    ls_num_doc, ls_tipo_registro,ls_nota="", ls_num_bol, ls_des,ls_num_bollettina,ls_des2, ls_des_bollettina, ls_tipo
//string ls_corretto, ls_non_segnare_piu, li_len, ls_ret, ls_galv,ls_um, ls_giorno_rientro_silver
//date  ldt_data_doc, ldt_data_inserimento
//long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_id_riga_provenienza,ll_riga_doc_inserito,ll_new_riga_doc,ll_id_art
//long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre,ll_riga_trovata,ll_id_uc
//setnull(ll_null)
//decimal ldc_prezzo, ldc_legato, ldc_tot_riga,ldc_prezzo_metallo, ls_tot_peso
//long ll_id_locazione, ll_id_magazzino,ll_id_causale, ll_id_titolo, ll_id_riga_bol ,ll_id_var, ll_id_listino, ll_riga_sald, ll_righe_sald
//u_setta_campi_documento uo_proponi_num_progressivo
//s_trova_progressivo ls_trova_prog
//
//
//	dw_1.accepttext()
//IF DW_2.ROWCOUNT()>0 THEN
//	ll_riga_doc=dw_2.getitemnumber(1, "id_riga_documento")
//	select id_documento into :ll_id_doc from dba.riga_documento where id_riga_documento=:ll_riga_doc;
//	//20230906 controllo che ogni riga abbia la galvanica, altrimenti lo segnalo e la faccio mettere
//	ll_id_prof=dw_1.getitemnumber(1, "id_prof_destinazione")
//	if ll_id_prof>0 then 
//		ll_riga_doc=dw_3.retrieve(ll_id_doc) //dw_3 è la dw che salva e recupera la testa del documento 20240925
//		ldt_data_doc=today()
//		//ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")  //spostato sopra 20230906
//		ll_id_sog=dw_3.getitemnumber(1, "id_sog_commerciale")
//		select id_locazione_1_prop, id_magazzino_1_prop, id_mod_registro_prop, id_caus_magazzino_prop
//		into :ll_id_locazione, :ll_id_magazzino, :ll_id_mod_registro, :ll_id_causale
//		from dba.prof_documento
//		where id_prof_documento=:ll_id_prof
//		;
//		dw_3.setitem(ll_riga_doc, "id_documento", ll_null)
//		dw_3.setitem(ll_riga_doc, "data_documento", ldt_data_doc)
//		dw_3.setitem(ll_riga_doc, "id_prof_documento", ll_id_prof)
//		//20221027 aggiungo da wf_importa che avevo preparato ma non ho mai usato...
//		dw_3.SetItem(1, "id_caus_magazzino", ll_id_causale)
//		dw_3.SetItem(1, "id_magazzino", ll_id_magazzino)
//		dw_3.SetItem(1, "id_locazione_1", ll_id_locazione)
//		dw_3.SetItem(1, "id_registro", ll_id_registro)
//		//20221027 fine
//		dw_3.setitem(ll_riga_doc, "id_sog_commerciale", ll_id_sog)
//		dw_3.setitem(ll_riga_doc, "id_sog_commerciale_fattura", ll_id_sog)
//		dw_3.setitem(ll_riga_doc, "data_registrazione", ldt_data_doc)
//		//20221014 il tio fattura è importante, se è diverso da 'N' mette il segno "-"
//		dw_3.setitem(ll_riga_doc, "tipo_fattura", 'N')
//		//trovo il numprog
//			
//		select id_esercizio
//		into :ll_id_esercizio
//		from dba.esercizio
//		where data_inizio<=:ldt_data_doc
//		and data_fine>=:ldt_data_doc
//		;
//		SELECT Max("registro"."id_registro")
//			INTO :ll_id_registro  
//			FROM "dba"."registro"  
//			WHERE ( "registro"."id_esercizio" = :ll_id_esercizio ) AND  
//				( "registro"."id_mod_registro" = :ll_id_mod_registro )   ;
//				
//		dw_3.setitem(ll_riga_doc, "id_registro", ll_id_registro)
//		select tipo_registro
//		into :ls_tipo_registro
//		from dba.registro
//		where id_registro=:ll_id_registro
//		;
//		
//		IF  ll_id_registro > 0 THEN
//			uo_proponi_num_progressivo=create u_setta_campi_documento
//			ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_registro, 0, ls_tipo_registro)
//			destroy uo_proponi_num_progressivo
//			dw_3.SetItem(ll_riga_doc, "num_progressivo", ls_trova_prog.sl_num_progressivo)
//			dw_3.SetItem(ll_riga_doc, "num_documento", string( ls_trova_prog.sl_num_progressivo))
//		end if	
//	
//		ls_nota="Bol. in questo doc: "
//		select id_listino into :ll_id_listino from dba.sog_commerciale where id_sog_commerciale=:ll_id_sog;
//		select id_variazione into :ll_id_var from dba.variazione  where id_listino=:ll_id_listino and data_inizio<= :ldt_data_doc and data_fine>=:ldt_data_doc ;
//		ls_nota+=ls_num_bol+";"
//		dw_3.setitem(ll_riga_doc, "note_intestazione", ls_nota)
//		//20220322 agg. la dataora creazione aggiornata
//		dw_3.setitem(ll_riga_doc, "data_ora_creazione", today())
//		dw_3.setitemstatus(ll_riga_doc, 0, primary!, newmodified!)
//		li_ret=dw_3.trigger event ue_update()  //salvo la testa
//		//fine inserimento testa
//		ll_id_doc_inserito=dw_3.getitemnumber(ll_riga_doc, "id_documento")
//	end if
//end if
end event

type dw_4 from udw_figlia within w_bol_dettaglio
boolean visible = false
integer x = 137
integer y = 1992
integer width = 5271
integer height = 464
integer taborder = 30
boolean bringtotop = true
string dataobject = "ds_riga_documento_2016"
boolean hscrollbar = true
boolean livescroll = false
end type

event retrievestart;call super::retrievestart;return 2
end event

type cb_agg_rbol from commandbutton within w_bol_dettaglio
integer x = 3995
integer y = 36
integer width = 402
integer height = 220
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Agg. a RBOL"
end type

event clicked;long ll_id_riga_doc, ll_id_doc, ll_riga_inserita, ll_num_prog
integer li_num_riga, li_ret
decimal ldc_legato
string ls_des

dw_1.accepttext()
ll_id_doc=dw_1.getitemnumber(1, "ID_RBOL")

if ll_id_doc>0 then
	ll_riga_inserita=dw_4.insertrow(0)
	dw_4.setitem(ll_riga_inserita, "id_documento", ll_id_doc)
	select num_progressivo into :ll_num_prog from dba.documento where id_documento=:ll_id_doc;
	select max(num_riga) into :li_num_riga from dba.riga_documento where id_documento=:ll_id_doc;
	if isnull(li_num_riga) then li_num_riga=0  //20241018 controllo se non ci fossero righe...
	li_num_riga++
	dw_4.setitem(ll_riga_inserita, "num_riga", li_num_riga)
	dw_4.SetItem(ll_riga_inserita, "id_valuta", 3 )
	dw_4.SetItem(ll_riga_inserita, "id_caus_magazzino", 45 )
	dw_4.SetItem(ll_riga_inserita, "id_locazione_1",  1)
	dw_4.setitem(ll_riga_inserita, "id_articolo", 608) //20240930 l'articolo è "catres"
	dw_4.setitem(ll_riga_inserita, "id_unita_confezione", 556) //e questa è l'UC di catres
	dw_4.SetItem(ll_riga_inserita, "coef_calo", 1000)
	ldc_legato=dw_2.getitemdecimal(1, "c_totale_peso")
	if ldc_legato>0 then  //controllo anche che il legato sia >=0
		dw_4.setitem(ll_riga_inserita, "peso_netto", ldc_legato)
		dw_4.setitem(ll_riga_inserita, "fino", ldc_legato*925/1000)
		dw_4.setitem(ll_riga_inserita, "calo", ldc_legato*75/1000)
	end if
	dw_4.setitem(ll_riga_inserita, "quantita", 0)
	dw_4.setitem(ll_riga_inserita, "fat_con_globale", 1)
	dw_4.setitem(ll_riga_inserita, "fat_con_unita_base", 1)
	dw_4.setitem(ll_riga_inserita, "id_conto", 1003)
	dw_4.setitem(ll_riga_inserita, "descrizione", "Catena Resa")
	dw_4.setitemstatus(ll_riga_inserita, 0, primary!, newmodified!)
	//salvo la riga
	li_ret=dw_4.trigger event ue_update()  //20220725
	if li_ret=1 then
		messagebox("OK!", "Riga con catena resa SALVATA correttamente in RBOL n. "+string(ll_num_prog)+".")
	else
		messagebox("Attenzione!!", "Riga con catena resa NON SALVATA!!!")
	end if
else
	messagebox("Attenzione!!", "Scegliere un documento cui aggiungere la catena resa...!!!!")
end if
end event

type st_1 from statictext within w_bol_dettaglio
integer x = 4914
integer y = 24
integer width = 795
integer height = 208
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tasto dx del mouse su ~"Cancella~" cancella tutte le righe!"
boolean focusrectangle = false
end type

type cb_da_excel from commandbutton within w_bol_dettaglio
integer x = 2697
integer y = 960
integer width = 261
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CSV"
end type

event clicked;string ls_path, ls_file, ls_bol
integer i

getfileopenname("Cerca report", ls_path, ls_file, "Excel, *.csv", "csv" , "C:\nita\exp_doc") //20230519 xls diventa xlsx .... proviamo
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_3.reset()
	dw_3.importfile(Text!,ls_file)
	for i= 2 to dw_3.rowcount()
		ls_bol=dw_3.getitemstring(i, "bollettina")
		dw_1.trigger event itemchanged(1, dw_1.object.cod_barre, ls_bol)
		insert into dba.ver_giorno_merce_fo (num_bollettina, data_spedizione)
		values (:ls_bol, today());
		if sqlca.sqlNrows>0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "bol.: "+ls_bol+" NON inserita in ver_giorno_merce_fo!")
			//return
		end if
	next
end if	 

end event

type dw_3 from udw_000 within w_bol_dettaglio
boolean visible = false
integer x = 5234
integer y = 2100
integer width = 581
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_carica_bol_urgenti"
end type

type r_1 from rectangle within w_bol_dettaglio
long linecolor = 33554432
integer linethickness = 4
long fillcolor = 12639424
integer x = 4457
integer y = 40
integer width = 329
integer height = 176
end type

