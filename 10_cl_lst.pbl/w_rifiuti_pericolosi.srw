forward
global type w_rifiuti_pericolosi from w_001
end type
type dw_1 from udw_base within w_rifiuti_pericolosi
end type
type dw_3 from udw_base within w_rifiuti_pericolosi
end type
type cb_passa from commandbutton within w_rifiuti_pericolosi
end type
type dw_2 from udw_figlia within w_rifiuti_pericolosi
end type
type cb_reset from commandbutton within w_rifiuti_pericolosi
end type
type cb_saldo from commandbutton within w_rifiuti_pericolosi
end type
end forward

global type w_rifiuti_pericolosi from w_001
boolean visible = false
integer width = 4530
integer height = 2748
string title = "Rifiuti Pericolosi"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_1 dw_1
dw_3 dw_3
cb_passa cb_passa
dw_2 dw_2
cb_reset cb_reset
cb_saldo cb_saldo
end type
global w_rifiuti_pericolosi w_rifiuti_pericolosi

type variables
transaction trans_destinazione
long il_id_prof_doc, il_id_sog
date idt_da_data
integer li_anno
string is_ultima_colonna
end variables

on w_rifiuti_pericolosi.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_3=create dw_3
this.cb_passa=create cb_passa
this.dw_2=create dw_2
this.cb_reset=create cb_reset
this.cb_saldo=create cb_saldo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.cb_passa
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_reset
this.Control[iCurrent+6]=this.cb_saldo
end on

on w_rifiuti_pericolosi.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.cb_passa)
destroy(this.dw_2)
destroy(this.cb_reset)
destroy(this.cb_saldo)
end on

event open;call super::open;s_list_main ls_list
long ll_id_prof
integer li_ret
string ls_prof_id


dw_3.settransobject(sqlca)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.insertrow(1)

//dw_3.setitem(1, "da_data", relativedate(today(), - 30))

datawindowchild dwc_fornitori
 ls_list=message.powerobjectparm
ll_id_prof=long(ls_list.s_win_parametri)
dw_3.setitem(1, "id_prof_destinazione", ll_id_prof)
li_ret= dw_3.GetChild('id_sog_com', dwc_fornitori)
 IF li_ret = -1 THEN MessageBox("Error", "Not a DataWindowChild")
CONNECT USING SQLCA;
dwc_fornitori.SetTransObject(SQLCA)
dwc_fornitori.Retrieve()
dwc_fornitori.setfilter("sog_commerciale_tipo='C'")
dwc_fornitori.filter()





end event

event ue_postopen;call super::ue_postopen;dw_3.post setfocus()
dw_3.post setcolumn("cod_barre")
end event

type st_1 from w_001`st_1 within w_rifiuti_pericolosi
end type

type dw_1 from udw_base within w_rifiuti_pericolosi
boolean visible = false
integer x = 59
integer y = 1460
integer width = 3840
boolean bringtotop = true
string dataobject = "ds_documento_2016"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_id_doc
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

type dw_3 from udw_base within w_rifiuti_pericolosi
integer x = 55
integer y = 28
integer width = 2811
integer height = 192
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_rifiuti_pericolosi"
boolean vscrollbar = false
boolean livescroll = false
end type

event editchanged;call super::editchanged;//20221117 funzione per creare riga da salvare in un doc id_prof207 
string ls_test,ls_des,ls_id_art
long ll_num_prog, ll_id_test, ll_id_uc, ll_id_doc,ll_riga, ll_null, ll_id_art, ll_id_prof, ll_id_causale, ll_id_locazione, ll_id_magazzino
decimal ldc_prezzo, ldc_prezzo_da_Data1
date ldt_data
u_dw_master_main idw_rigadoc
long ll_id_riga_campione

setnull(ll_null)
if dwo.name="cod_barre"  then
	if len(data)=13   then
		dw_3.setitem(1, "n_lacci", ll_null)  //pezzi= quantita
		dw_3.setitem(1, "n_fili", ll_null)  // litri, vanno sempre sulla quantita
		ls_id_art=right(data, 7)
		ls_id_art=left(ls_id_art, 6)
		ll_id_art=long(ls_id_art)
		select a.descrizione, u.id_unita_confezione into :ls_des, :ll_id_uc from dba.articolo a, dba.unita_confezione u
		where a.id_articolo=:ll_id_art and u.id_articolo=a.id_articolo and u.unita_base='S';
		select first(id_riga_documento) into :ll_id_riga_campione from riga_documento  where id_articolo>0; 
		ll_riga=dw_2.retrieve(ll_id_riga_campione)  //20221117 copio una riga campione per i campi obbligatori, poi cambio solo quelli che mi servono
		//207 prof e 111 causale
		dw_2.setitem(ll_riga, "id_riga_documento",ll_null)
		dw_2.setitem(ll_riga, "id_documento", ll_null)
		dw_2.setitem(ll_riga, "descrizione",ls_des)
		dw_2.setitem(ll_riga, "id_unita_confezione",ll_id_uc)
		dw_2.setitem(ll_riga, "id_unita_confezione",ll_id_uc)
		dw_2.setitem(ll_riga, "peso_netto",0)
		dw_2.setitem(ll_riga, "quantita", 0)
		dw_2.setitem(ll_riga, "fino", 0)
		dw_2.setitem(ll_riga, "calo", 0)
		dw_2.setitem(ll_riga, "coef_calo", 0)
		ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
	
		select id_locazione_1_prop, id_magazzino_1_prop,  id_caus_magazzino_prop
		into :ll_id_locazione, :ll_id_magazzino,  :ll_id_causale
		from dba.prof_documento
		where id_prof_documento=:ll_id_prof
		;
		dw_2.setitem(ll_riga, "id_locazione_1", ll_id_locazione)
		
		dw_2.setitem(ll_riga, "id_caus_magazzino", ll_id_causale)
		dw_2.setitem(ll_riga, "id_articolo",ll_id_art)
		
		//20220928 annullo anche fili, lacci e tara...
		dw_2.setitem(ll_riga, "provv_imp_carea_2", ll_null)
		dw_2.setitem(ll_riga, "provv_imp_agente_2", ll_null)
		dw_2.setitem(ll_riga, "peso_lordo", ll_null)
		dw_3.post setcolumn("n_lacci")
	end if
end if
//	ls_test="id_documento="+string(ll_id_bollettina)
//			ll_id_test=dw_8.find(ls_test, 1, dw_1.rowcount())
//			if ll_id_test>0 then
//	//			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" già legata a questo documento!")
//			else
////				dw_8.retrieve(ll_id_bollettina)
//				dw_3.setitem(1, "cod_barre", "")
//				dw_3.setfocus()
//				dw_3.setcolumn("cod_barre")
//				
////				ll_righe=dw_2.retrieve(ll_id_bollettina)
//				
//				//20220928 annullo anche fili, lacci e tara...
//				dw_2.setitem(ll_righe, "provv_imp_carea_2", ll_null)
//				dw_2.setitem(ll_righe, "provv_imp_agente_2", ll_null)
//				dw_2.setitem(ll_righe, "peso_lordo", ll_null)
//				//20220928 fine
////				wf_bilancia(dw_2.rowcount(), ll_id_bollettina)
//				if cb_passa.text="Manda in Galv" then
//					setcolumn("cod_barre_galvanica")
//				else
//					if getitemdecimal(row,"legato")> 0 then
//						post setcolumn("n_lacci")
//					else
//						post setcolumn("cod_barre")
//					end if
//				end if
//			end if
//		else
////			messagebox("Attenzione!", "Bollettina: "+ls_num_doc+" non trovata!")
//		end if
////	end if
////end if
//
//
end event

event itemchanged;call super::itemchanged;date ldt_data_doc
integer  li_pezzi_o_litri
decimal ldc_peso_netto, ldc_peso_medio
string ls_articolo
long ll_id_art

choose case dwo.name
	case "n_lacci", "n_fili"
		li_pezzi_o_litri= integer(data)
		if li_pezzi_o_litri>0 then
			dw_2.setitem(dw_2.rowcount(), "quantita", li_pezzi_o_litri)
			ls_articolo=getitemstring(1, "cod_barre")
			ls_articolo=mid(ls_articolo, 8,5)
			ll_id_art=long (ls_articolo)
			select peso_netto into :ldc_peso_medio from unita_confezione where id_articolo=:ll_id_art and unita_base='S';
			if ldc_peso_medio>0 then dw_2.setitem(dw_2.rowcount(), "peso_netto", ldc_peso_medio*li_pezzi_o_litri)
		end if
		
		post setfocus()
		post setcolumn("cod_barre")
	
end choose
end event

event itemfocuschanged;call super::itemfocuschanged;

if string(dwo.name)="ultima" then 
	setfocus()
	setcolumn("cod_barre")
end if
end event

type cb_passa from commandbutton within w_rifiuti_pericolosi
integer x = 3941
integer y = 240
integer width = 471
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "RIPL"
end type

event clicked;integer li_ret, i, li_righe
long     ll_null, ll_riga_doc, ll_id_doc_campione
string    ls_num_doc, ls_tipo_registro, ls_nota="",  ls_des
date  ldt_data_doc
long  ll_id_doc_inserito,  ll_id_prof,ll_id_sog, ll_riga_doc_inserito,ll_id_art
long ll_id_esercizio, ll_id_mod_registro, ll_id_registro, ll_num_prog_test,ll_riga_madre,ll_riga_trovata,ll_id_uc
DWItemStatus ldw_status
setnull(ll_null)

long ll_id_locazione, ll_id_magazzino,ll_id_causale
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog

	dw_3.accepttext()
	select first(id_documento) into :ll_id_doc_campione from documento; 
	ll_riga_doc=dw_1.retrieve(ll_id_doc_campione)
	ldt_data_doc=dw_3.getitemdate(1, "doc_data")
	ll_id_prof=dw_3.getitemnumber(1, "id_prof_destinazione")
	ll_id_sog=dw_3.getitemnumber(1, "id_sog_com")
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
	dw_1.setitem(ll_riga_doc, "id_sog_commerciale", ll_id_sog)
	dw_1.setitem(ll_riga_doc, "id_sog_commerciale_fattura", ll_id_sog)
	dw_1.setitem(ll_riga_doc, "data_registrazione", ldt_data_doc)
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
	
	ls_nota="Rifiuti Pericolosi"

	dw_1.setitem(ll_riga_doc, "note_intestazione", ls_nota)
	//20220322 agg. la dataora creazione aggiornata
	dw_1.setitem(ll_riga_doc, "data_ora_creazione", today())
	dw_1.setitemstatus(ll_riga_doc, 0, primary!, newmodified!)
	li_ret=dw_1.trigger event ue_update()
	ll_id_doc_inserito=dw_1.getitemnumber(ll_riga_doc, "id_documento")
	
	for i=1 to dw_2.rowcount()
		dw_2.setitem(i, "id_documento", ll_id_doc_inserito)
		dw_2.setitem(i, "num_riga", i)
		dw_2.setitemstatus(i, 0, primary!, newmodified!)
	next
	//ldw_status=dw_2.getitemstatus(
	
	li_ret=dw_2.trigger event ue_update() 
end event

type dw_2 from udw_figlia within w_rifiuti_pericolosi
integer x = 64
integer y = 248
integer width = 3840
integer height = 1144
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_riga_doc_rif_pericolosi"
boolean hscrollbar = true
boolean livescroll = false
end type

event retrievestart;call super::retrievestart;return 2
end event

event doubleclicked;call super::doubleclicked;long ll_id_doc
w_orafo_documento_ordine_cx w_orafo
s_list_main s_list

if row >0  then
	s_list.s_identifica[1]="id_documento"
	s_list.s_modo=modo_modifica
	ll_id_doc=getitemnumber(row, "id_documento")
	if ll_id_doc>0 then
		s_list.l_identifica[1]=ll_id_doc
		openwithparm(w_orafo, s_list)
	end if
end if
end event

type cb_reset from commandbutton within w_rifiuti_pericolosi
integer x = 3945
integer y = 1436
integer width = 471
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "RESET"
end type

event clicked;
if messagebox("Attenzione!", "Vuoi davvero pulire le finestre per fare un altro DDT?", stopsign!, yesno!)= 1 then
	dw_3.reset()
	dw_2.reset()	
	dw_1.reset()
end if
end event

type cb_saldo from commandbutton within w_rifiuti_pericolosi
integer x = 3941
integer y = 456
integer width = 471
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Saldo"
end type

event clicked;open(w_rif_pericolosi_st)
end event

