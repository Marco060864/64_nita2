forward
global type w_inventario_cx from w_001
end type
type dw_2 from udw_base within w_inventario_cx
end type
type cb_importa from commandbutton within w_inventario_cx
end type
type cb_salva from commandbutton within w_inventario_cx
end type
type cb_cancella from commandbutton within w_inventario_cx
end type
type dw_3 from udw_base within w_inventario_cx
end type
type dw_4 from udw_base within w_inventario_cx
end type
type dw_6 from udw_base within w_inventario_cx
end type
type rte_1 from richtextedit within w_inventario_cx
end type
end forward

global type w_inventario_cx from w_001
integer width = 4347
integer height = 1984
string title = "Inventario"
boolean minbox = true
windowtype windowtype = popup!
dw_2 dw_2
cb_importa cb_importa
cb_salva cb_salva
cb_cancella cb_cancella
dw_3 dw_3
dw_4 dw_4
dw_6 dw_6
rte_1 rte_1
end type
global w_inventario_cx w_inventario_cx

forward prototypes
public function integer wf_inserisci_righe (long al_id_doc, long al_id_caus, long al_id_locazione, long al_id_valuta, long al_id_tab_iva, long al_id_contropartita)
public subroutine wf_carica_prezzo (string as_cod_art, decimal adc_prezzo, integer ai_flag)
public subroutine wf_carica_listino_ven (long al_id_uc, decimal adc_prezzo, string as_cod_art)
end prototypes

public function integer wf_inserisci_righe (long al_id_doc, long al_id_caus, long al_id_locazione, long al_id_valuta, long al_id_tab_iva, long al_id_contropartita);long ll_id_articolo, ll_riga, ll_id_UC
integer i
string ls_cod_art, ls_des_art, ls_segno,ls_bollo
decimal ldc_qta, ldc_prezzo, ldc_peso, ldc_titolo, ldc_calo, ldc_fino
dw_2.accepttext()

for i= 1 to dw_2.rowcount()
		ll_riga=dw_4.insertrow(0)
		dw_4.setitem(ll_riga, "id_documento", al_id_doc)
		dw_4.setitem(ll_riga, "riga_documento_num_riga", i)
		ls_segno=dw_2.getitemstring(i, "segno")
		if ls_segno='+' then
			al_id_caus=dw_6.getitemnumber(1, "id_caus_carico")
		else
			al_id_caus=dw_6.getitemnumber(1, "id_caus_scarico")
		end if
		dw_4.setitem(ll_riga, "riga_documento_id_caus_magazzino", al_id_caus)
		dw_4.setitem(ll_riga, "id_locazione_1", al_id_locazione)
		dw_4.setitem(ll_riga, "riga_documento_id_valuta", al_id_valuta)
		dw_4.setitem(ll_riga, "riga_documento_cambio", 1)
		dw_4.setitem(ll_riga, "tipo_um", "N")
		dw_4.setitem(ll_riga, "riga_documento_id_conto", al_id_contropartita)
		//inserisco coef_calo=1000 speriamo vada bene ... 270812
		dw_4.setitem(ll_riga, "coef_calo", 1000)
		//e inserisco anche il bollo 2708012	
		ls_bollo=dw_2.getitemstring(i, "bollo")
		dw_4.setitem(ll_riga, "sigla_prezzo", ls_bollo)
		ls_cod_art=dw_2.getitemstring(i, "cod_art")
		ll_id_articolo=dw_2.getitemnumber(i, "id_articolo")
			select id_unita_confezione
			into  :ll_id_UC
			from dba.articolo a, dba.unita_confezione u
			where a.id_articolo=:ll_id_articolo
			and a.id_articolo=u.id_articolo
			and u.unita_base='S'
			;
			if ll_id_articolo>0 then
				dw_4.setitem(ll_riga, "riga_documento_id_articolo", ll_id_articolo)
				dw_4.setitem(ll_riga, "riga_documento_id_unita_confezione", ll_id_UC)
			end if
			ls_des_art=dw_2.getitemstring(i, "des_art")
			dw_4.setitem(ll_riga, "riga_documento_descrizione", ls_des_art)

		ldc_qta=0
		dw_4.setitem(ll_riga, "quantita", ldc_qta)
		dw_4.setitem(ll_riga, "qta_un_base", ldc_qta)
		ldc_prezzo=0
		dw_4.setitem(ll_riga, "prezzo_complessivo", ldc_prezzo)
		dw_4.setitem(ll_riga, "prezzo", ldc_prezzo)
		dw_4.setitem(ll_riga, "riga_documento_prezzo_netto", ldc_prezzo)
		dw_4.setitem(ll_riga, "riga_documento_id_tab_iva", al_id_tab_iva)
		
		//il totale è prezzo per qta
		dw_4.setitem(ll_riga, "importo_manifattura", ldc_prezzo*ldc_qta)
		dw_4.setitem(ll_riga, "tot_riga_val_riga", ldc_prezzo*ldc_qta)
		dw_4.setitem(ll_riga, "tot_riga_val_az", ldc_prezzo*ldc_qta)
		dw_4.setitem(ll_riga, "tot_riga_val_doc", ldc_prezzo*ldc_qta)
		//ora il più importante: il peso che rimette a posto l'inventario richiesta samy 270812
		ldc_peso=dw_2.getitemdecimal(i, "correzione")
		dw_4.setitem(ll_riga, "riga_documento_peso_netto", ldc_peso)
		//devo inserire fino e calo (devo prima trovare id_titolo)
		select titolo
		into :ldc_titolo
		from dba.articolo a, dba.orafo_titolo t
		where id_articolo=:ll_id_articolo
		and a.id_titolo=t.id_titolo
		;
		ldc_fino=ldc_peso*ldc_titolo/1000
		ldc_calo=ldc_peso - ldc_fino
		dw_4.setitem(ll_riga, "fino", ldc_fino)
		dw_4.setitem(ll_riga, "calo", ldc_calo)
		
next
if dw_4.trigger event ue_update() = 1 then
	messagebox("OK!", "Correzione effettuata correttamente!")
else
	messagebox("Ahi!", "Corerzione NON effettuata!")
end if
return 1
end function

public subroutine wf_carica_prezzo (string as_cod_art, decimal adc_prezzo, integer ai_flag);long ll_id_uc, ll_id_var, ll_id_sog
long ll_id_listino_fo, ll_id_listino_base, ll_id_var_base

ll_id_sog=dw_6.getitemnumber(1, "id_sog_com")

select id_listino
into :ll_id_listino_fo
from dba.sog_commerciale
where id_sog_commerciale=:ll_id_sog
;
	select id_variazione
	into :ll_id_var_base
	from dba.variazione v, dba.listino l
	where l.lis_base='S' and l.tipo='A'
	and v.id_listino=l.id_listino
	and v.data_inizio<= today() and (v.data_fine is null or v.data_fine>=today())
	;
if ll_id_listino_fo>0 then
	select id_variazione
	into :ll_id_var
	from dba.variazione
	where id_listino=:ll_id_listino_fo
	and data_inizio<= today() and (data_fine is null or data_fine>=today())
	;
end if

select id_unita_confezione
into :ll_id_uc
from unita_confezione u, articolo a
where a.id_articolo=u.id_articolo
and a.codice=:as_cod_art
and u.unita_base='S'
;
//testo il flag: se =0 inserimento, se =1 update
if ai_flag=1 then  //aggiornamento
	if messagebox("Attenzione!", "ART: "+as_cod_art+",  Prezzo: "+string(adc_prezzo)+ "- AGGIORNO?", &
		stopsign!, yesno!)=1 then
		
	
		if ll_id_var>0 then //se esiste un listino fornitore lo aggiorno
			update dba.prezzo
			set prezzo=:adc_prezzo
			where id_variazione=:ll_id_var
			and id_unita_confezione=:ll_id_uc;
		
			if sqlca.sqlnrows>0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino personale non caricato!")
			end if
			
		end if
		//aggiorno il listino base acquisto
		update dba.prezzo
		set prezzo=:adc_prezzo
		where id_variazione=:ll_id_var_base
		and id_unita_confezione=:ll_id_uc;
		
		if sqlca.sqlnrows>0 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino base acquisto non caricato!")
		end if
	end if
else //inserimento
	if messagebox("Attenzione!", "ART: "+as_cod_art+",  Prezzo: "+string(adc_prezzo)+ "- INSERISCO?", &
		stopsign!, yesno!)=1 then
	
		if ll_id_var>0 then //se esiste un listino fornitore inserisco
			insert into dba.prezzo
			(id_unita_confezione, id_variazione, prezzo)
			values(:ll_id_uc, :ll_id_var, :adc_prezzo)
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino personale non caricato!")
			end if
		end if
		//comunque inserisco il list acq base
		insert into dba.prezzo
		(id_unita_confezione, id_variazione, prezzo)
		values(:ll_id_uc, :ll_id_var_base, :adc_prezzo)
		;
		if sqlca.sqlcode=0 then
			commit;
			wf_carica_listino_ven(ll_id_uc, adc_prezzo, as_cod_art)
		else
			rollback;
			messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino base acquisto non caricato!")
		end if
	end if
end if

end subroutine

public subroutine wf_carica_listino_ven (long al_id_uc, decimal adc_prezzo, string as_cod_art);
long ll_id_var
decimal ldc_ricarico
//recupero id_variazione del listino vendita
ll_id_var=dw_6.getitemnumber(1, "lis_vendita")
ldc_ricarico=dw_6.getitemnumber(1, "ricarico")

if ll_id_var>0 and ldc_ricarico>=0 then
	insert into dba.prezzo
	(id_unita_confezione, id_variazione, prezzo)
	values(:al_id_uc, :ll_id_var, :adc_prezzo*:ldc_ricarico)
	;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino vendita non caricato!")
	end if
else
	messagebox("Attenzione!", "Inserire listino vendita!")
end if
end subroutine

on w_inventario_cx.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_importa=create cb_importa
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_6=create dw_6
this.rte_1=create rte_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_importa
this.Control[iCurrent+3]=this.cb_salva
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.dw_3
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_6
this.Control[iCurrent+8]=this.rte_1
end on

on w_inventario_cx.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_importa)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_6)
destroy(this.rte_1)
end on

event open;call super::open;s_inventario s_inv
long ll_riga_inserita
integer i

//dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
//dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_6.insertrow(1)

s_inv=message.powerobjectparm
for i = 1 to upperbound(s_inv.id_art)
	ll_riga_inserita=dw_2.insertrow(0)
	dw_2.setitem(ll_riga_inserita, "id_articolo", s_inv.id_art[i])
	dw_2.setitem(ll_riga_inserita, "cod_art", s_inv.cod_art[i])
	dw_2.setitem(ll_riga_inserita, "des_art", s_inv.des_art[i])
	dw_2.setitem(ll_riga_inserita, "peso", s_inv.disponibilita[i])
	dw_2.setitem(ll_riga_inserita, "bollo", s_inv.bollo[i])
	
next

rte_1.insertdocument("c:\start\w_inventario_cx.txt", true)




end event

type st_1 from w_001`st_1 within w_inventario_cx
end type

type dw_2 from udw_base within w_inventario_cx
integer x = 59
integer y = 176
integer width = 3552
integer height = 760
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_car_scar_inventario_gd"
end type

type cb_importa from commandbutton within w_inventario_cx
integer x = 3255
integer y = 944
integer width = 343
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CORREGGI"
end type

event clicked;long ll_id_prof_doc, ll_id_registro, ll_num_prog, ll_id_sog
long ll_id_valuta, ll_id_prof_reg, ll_id_doc, ll_id_caus
string ls_num_doc
date ldt_data_doc
long ll_id_locazione, ll_id_contropartita, ll_id_tab_iva
long ll_test, ll_id_mod_registro

dw_3.reset()
dw_4.reset()

select id_prof_documento
into :ll_id_prof_doc
from prof_documento
where codice='INVENTAR'

;

if ll_id_prof_doc>0 then
	//recupero subito data e num doc: se esiste già noin se ne fa di nulla
	// adesso recupero data e num doc della fattura
	ldt_data_doc=dw_6.getitemdate(1, "data_doc")
	
	dw_3.insertrow(1)
	
	dw_3.setitem(1, "data_documento", ldt_data_doc)
	dw_3.setitem(1, "data_competenza", ldt_data_doc)
			
	dw_3.setitem(1, "id_prof_documento", ll_id_prof_doc)
	
	select id_prof_registrazione, id_caus_magazzino_prop, id_locazione_1_prop, id_mod_registro_prop,
			id_sog_comm_prop
	into :ll_id_prof_reg, :ll_id_caus, :ll_id_locazione, :ll_id_mod_registro,
			:ll_id_sog
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof_doc;
	
	dw_3.setitem(1, "id_prof_registrazione", ll_id_prof_reg)
	dw_3.setitem(1, "id_caus_magazzino", ll_id_caus)
	//trovo il registro
	select id_registro
	into :ll_id_registro
	from registro r, esercizio e
	where id_mod_registro= :ll_id_mod_registro
	and e.id_esercizio=r.id_esercizio
	and e.data_inizio<=today()
	and e.data_fine>=today()
	;
	if ll_id_registro >0 then
		dw_3.setitem(1, "id_registro", ll_id_registro)
		select num_progressivo
		into :ll_num_prog
		from registro
		where id_registro=:ll_id_registro
		;
		dw_3.setitem(1, "num_progressivo", ll_num_prog)
		dw_3.setitem(1, "num_documento", string(ll_num_prog))
		dw_3.setitem(1, "data_registrazione", 	today())
	
		dw_3.setitem(1, "id_sog_commerciale", 	ll_id_sog)
		dw_3.setitem(1, "id_sog_commerciale_fattura", 	ll_id_sog)
		//trova la causale
		
		//trova contropartita
		select id_conto
		into :ll_id_contropartita
		from dba.con_movimento
		where id_sog_commerciale=:ll_id_sog
		and applicazione='A'
		;
		if isnull(ll_id_contropartita) or ll_id_contropartita=0 then
			select id_conto_predefinito
			into :ll_id_contropartita
			from dba.par_sistema;
		end if
		select id_tab_iva
		into :ll_id_tab_iva
		from dba.sog_commerciale
		where id_sog_commerciale=:ll_id_sog
		;
		if isnull(ll_id_tab_iva) then
			select id_conto_iva_ia
			into :ll_id_contropartita
			from dba.par_sistema;
		end if
		
		//valuta
		select id_val_euro
		into :ll_id_valuta
		from dba.par_sistema;
		dw_3.setitem(1, "id_valuta", 	ll_id_valuta)
		
		//ora provo a salvare
		dw_3.triggerevent("ue_update")
		//se tutto va bene carico le righe
		ll_id_doc=dw_3.getitemnumber(1, "id_documento")
		if ll_id_doc>0 then
			wf_inserisci_righe(ll_id_doc, ll_id_caus, ll_id_locazione, ll_id_valuta,ll_id_tab_iva, ll_id_contropartita)
		else
			messagebox("Errore!", "Documento non salvato!")
		end if
	else
		messagebox("Errore!", "Occorre creare un registro per la fattura d'acquisto")
	end if	
	
else
	messagebox("Errore!", "Occorre creare un profilo documento")
	
end if
end event

type cb_salva from commandbutton within w_inventario_cx
boolean visible = false
integer x = 471
integer y = 1084
integer width = 343
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;dw_2.triggerevent("ue_update")
end event

type cb_cancella from commandbutton within w_inventario_cx
boolean visible = false
integer x = 119
integer y = 1084
integer width = 343
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;//dw_2.trigger event ue_delete(dw_1.getrow())
end event

type dw_3 from udw_base within w_inventario_cx
boolean visible = false
integer x = 197
integer y = 1204
integer width = 3447
integer height = 376
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_doc"
boolean hscrollbar = true
boolean vscrollbar = false
end type

type dw_4 from udw_base within w_inventario_cx
boolean visible = false
integer x = 183
integer y = 1592
integer width = 3474
integer height = 1008
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_orafo_riga_documento_ordine_260510_gd"
end type

type dw_6 from udw_base within w_inventario_cx
integer x = 69
integer width = 1865
integer height = 168
boolean bringtotop = true
string dataobject = "d_dati_fissi_inventario"
boolean vscrollbar = false
boolean livescroll = false
end type

type rte_1 from richtextedit within w_inventario_cx
integer x = 59
integer y = 1068
integer width = 3552
integer height = 756
integer taborder = 30
boolean bringtotop = true
boolean init_wordwrap = true
borderstyle borderstyle = stylelowered!
end type

