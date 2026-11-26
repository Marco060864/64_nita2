forward
global type w_silver_copia_doc from w_001
end type
type dw_1 from udw_base within w_silver_copia_doc
end type
type cb_carica_txt from commandbutton within w_silver_copia_doc
end type
type dw_2 from udw_base within w_silver_copia_doc
end type
type cb_importa from commandbutton within w_silver_copia_doc
end type
type cb_salva from commandbutton within w_silver_copia_doc
end type
type cb_cancella from commandbutton within w_silver_copia_doc
end type
type dw_3 from udw_base within w_silver_copia_doc
end type
type dw_4 from udw_base within w_silver_copia_doc
end type
type cb_crea_articoli from commandbutton within w_silver_copia_doc
end type
type dw_5 from udw_base within w_silver_copia_doc
end type
type dw_6 from udw_base within w_silver_copia_doc
end type
type st_2 from statictext within w_silver_copia_doc
end type
end forward

global type w_silver_copia_doc from w_001
integer width = 3666
integer height = 1196
string title = "Importazione Fatture Acquisto"
dw_1 dw_1
cb_carica_txt cb_carica_txt
dw_2 dw_2
cb_importa cb_importa
cb_salva cb_salva
cb_cancella cb_cancella
dw_3 dw_3
dw_4 dw_4
cb_crea_articoli cb_crea_articoli
dw_5 dw_5
dw_6 dw_6
st_2 st_2
end type
global w_silver_copia_doc w_silver_copia_doc

forward prototypes
public function integer wf_inserisci_righe (long al_id_doc, long al_id_caus, long al_id_locazione, long al_id_valuta, long al_id_tab_iva, long al_id_contropartita)
public subroutine wf_decifra ()
public subroutine wf_carica_prezzo (string as_cod_art, decimal adc_prezzo)
end prototypes

public function integer wf_inserisci_righe (long al_id_doc, long al_id_caus, long al_id_locazione, long al_id_valuta, long al_id_tab_iva, long al_id_contropartita);long ll_id_articolo, ll_riga, ll_id_UC
integer i
string ls_cod_art, ls_des_art
decimal ldc_qta, ldc_prezzo

for i= 1 to dw_2.rowcount()
		ll_riga=dw_4.insertrow(0)
		dw_4.setitem(ll_riga, "id_documento", al_id_doc)
		dw_4.setitem(ll_riga, "riga_documento_num_riga", i)
		dw_4.setitem(ll_riga, "riga_documento_id_caus_magazzino", al_id_caus)
		dw_4.setitem(ll_riga, "id_locazione_1", al_id_locazione)
		dw_4.setitem(ll_riga, "riga_documento_id_valuta", al_id_valuta)
		dw_4.setitem(ll_riga, "riga_documento_cambio", 1)
		dw_4.setitem(ll_riga, "tipo_um", "N")
		dw_4.setitem(ll_riga, "riga_documento_id_conto", al_id_contropartita)
		
		ls_cod_art=dw_2.getitemstring(i, "art")
		if ls_cod_art>" " then
			select a.id_articolo, id_unita_confezione
			into :ll_id_articolo, :ll_id_UC
			from dba.articolo a, dba.unita_confezione u
			where a.codice=:ls_cod_art
			and a.id_articolo=u.id_articolo
			and u.unita_base='S'
			;
			if ll_id_articolo>0 then
				dw_4.setitem(ll_riga, "riga_documento_id_articolo", ll_id_articolo)
				dw_4.setitem(ll_riga, "riga_documento_id_unita_confezione", ll_id_UC)
			end if
			ls_des_art=dw_2.getitemstring(i, "des_art")
			dw_4.setitem(ll_riga, "riga_documento_descrizione", ls_des_art)
		end if
		ldc_qta=dw_2.getitemdecimal(i, "qta")
		dw_4.setitem(ll_riga, "quantita", ldc_qta)
		dw_4.setitem(ll_riga, "qta_un_base", ldc_qta)
		ldc_prezzo=dw_2.getitemdecimal(i, "prezzo")
		dw_4.setitem(ll_riga, "prezzo_complessivo", ldc_prezzo)
		dw_4.setitem(ll_riga, "prezzo", ldc_prezzo)
		dw_4.setitem(ll_riga, "riga_documento_prezzo_netto", ldc_prezzo)
		dw_4.setitem(ll_riga, "riga_documento_id_tab_iva", al_id_tab_iva)
		
		//il totale è prezzo per qta
		dw_4.setitem(ll_riga, "importo_manifattura", ldc_prezzo*ldc_qta)
		dw_4.setitem(ll_riga, "tot_riga_val_riga", ldc_prezzo*ldc_qta)
		dw_4.setitem(ll_riga, "tot_riga_val_az", ldc_prezzo*ldc_qta)
		dw_4.setitem(ll_riga, "tot_riga_val_doc", ldc_prezzo*ldc_qta)
next
if dw_4.trigger event ue_update() = 1 then
	messagebox("OK!", "Documento importato correttamente!")
else
	messagebox("Ahi!", "Documento non importato!")
end if
return 1
end function

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
	ls_imp=left(ls_imp, 2)+"/"+mid(ls_imp, 3,2)+"/"+right(ls_imp, 2)
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
	
	ls_imp=mid(ls_dati, 96, 9)
	ls_imp=left(ls_imp, 6)+"."+right(ls_imp, 3)
	ldc_qta=	dec(ls_imp)
	dw_2.setitem(li_riga_inserita, "qta", ldc_qta)
	
	ls_imp=mid(ls_dati, 105, 14)
	ls_imp=left(ls_imp, 11)+"."+right(ls_imp, 3)
	ldc_qta=	dec(ls_imp)
	dw_2.setitem(li_riga_inserita, "prezzo", ldc_qta)
	
	ls_imp=mid(ls_dati, 131, 6)
	ls_imp=left(ls_imp, 4)+"."+right(ls_imp, 2)
	ldc_qta=	dec(ls_imp)
	dw_2.setitem(li_riga_inserita, "sconto1", ldc_qta)
	
	ls_imp=mid(ls_dati, 137, 6)
	ls_imp=left(ls_imp, 4)+"."+right(ls_imp, 2)
	ldc_qta=	dec(ls_imp)
	dw_2.setitem(li_riga_inserita, "sconto2", ldc_qta)
	
	ls_imp=mid(ls_dati, 152, 3)
	dw_2.setitem(li_riga_inserita, "iva", ls_imp)
		
	
next
end subroutine

public subroutine wf_carica_prezzo (string as_cod_art, decimal adc_prezzo);long ll_id_uc, ll_id_var, ll_id_sog
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
if ll_id_var>0 then //se esiste un listino fornitore inserisco
	insert into dba.prezzo
	(id_unita_confezione, id_variazione, prezzo)
	values(:ll_id_uc, :ll_id_var, :adc_prezzo)
	;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" non caricato!")
	end if
end if
//comunque inserisco il list acwq base
insert into dba.prezzo
(id_unita_confezione, id_variazione, prezzo)
values(:ll_id_uc, :ll_id_var_base, :adc_prezzo)
;
if sqlca.sqlcode=0 then
	commit;
else
	rollback;
	messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" non caricato!")
end if

end subroutine

on w_silver_copia_doc.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_carica_txt=create cb_carica_txt
this.dw_2=create dw_2
this.cb_importa=create cb_importa
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_crea_articoli=create cb_crea_articoli
this.dw_5=create dw_5
this.dw_6=create dw_6
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_carica_txt
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_importa
this.Control[iCurrent+5]=this.cb_salva
this.Control[iCurrent+6]=this.cb_cancella
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.cb_crea_articoli
this.Control[iCurrent+10]=this.dw_5
this.Control[iCurrent+11]=this.dw_6
this.Control[iCurrent+12]=this.st_2
end on

on w_silver_copia_doc.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_carica_txt)
destroy(this.dw_2)
destroy(this.cb_importa)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_crea_articoli)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.st_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)
dw_6.insertrow(1)
end event

type st_1 from w_001`st_1 within w_silver_copia_doc
end type

type dw_1 from udw_base within w_silver_copia_doc
boolean visible = false
integer x = 2784
integer y = 1184
integer width = 384
integer height = 232
boolean bringtotop = true
string dataobject = "d_imp_255"
end type

type cb_carica_txt from commandbutton within w_silver_copia_doc
integer x = 59
integer y = 960
integer width = 343
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carica TXT"
end type

event clicked;integer li_ret
string ls_path, ls_file
	
getfileopenname("Cerca File da Importare", ls_path, ls_file)
if  not(trim(ls_file)="" or isnull(ls_file)) then
	dw_1.reset()
	dw_1.ImportFile(text!,ls_path)
end if	 

post wf_decifra()




end event

type dw_2 from udw_base within w_silver_copia_doc
integer x = 59
integer y = 176
integer width = 3552
integer height = 760
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_imp_fatture_gd"
end type

type cb_importa from commandbutton within w_silver_copia_doc
integer x = 855
integer y = 960
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
string text = "Importa"
end type

event clicked;long ll_id_prof_doc, ll_id_registro, ll_num_prog, ll_id_sog
long ll_id_valuta, ll_id_prof_reg, ll_id_doc, ll_id_caus
string ls_num_doc
date ldt_data_doc
long ll_id_locazione, ll_id_contropartita, ll_id_tab_iva
long ll_test


select id_prof_documento
into :ll_id_prof_doc
from prof_documento
where codice='IMPFAT'

;

if ll_id_prof_doc>0 then
	//recupero subito data e num doc: se esiste già noin se ne fa di nulla
	// adesso recupero data e num doc della fattura
	ldt_data_doc=dw_2.getitemdate(1, "data_doc")
	ls_num_doc=dw_2.getitemstring(1, "num_doc")
	do while left(ls_num_doc,1)='0'
		ls_num_doc=right(ls_num_doc, len(ls_num_doc) - 1)		
	loop
	select id_documento
	into :ll_test
	from dba.documento
	where data_documento=:ldt_data_doc
	and num_documento=:ls_num_doc
	and id_prof_documento=:ll_id_prof_doc;
	if ll_test>0 then
		messagebox("Attenzione!", "Documento già esistente! L'importazione viene terminata!")
		return
	end if
	dw_3.insertrow(1)
	
	dw_3.setitem(1, "data_documento", ldt_data_doc)
	dw_3.setitem(1, "data_competenza", ldt_data_doc)
	dw_3.setitem(1, "num_documento", ls_num_doc)
		
	dw_3.setitem(1, "id_prof_documento", ll_id_prof_doc)
	select id_prof_registrazione, id_caus_magazzino_prop, id_locazione_1_prop
	into :ll_id_prof_reg, :ll_id_caus, :ll_id_locazione
	from dba.prof_documento
	where id_prof_documento=:ll_id_prof_doc;
	dw_3.setitem(1, "id_prof_registrazione", ll_id_prof_reg)
	select first(id_registro)
	into :ll_id_registro
	from registro r, esercizio e
	where tipo_registro='IA'
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
	
		dw_3.setitem(1, "data_registrazione", 	today())
		ll_id_sog=dw_6.getitemnumber(1, "id_sog_com")
		dw_3.setitem(1, "id_sog_commerciale", 	ll_id_sog)
		dw_3.setitem(1, "id_sog_commerciale_fattura", 	ll_id_sog)
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
	messagebox("Errore!", "Occorre creare un profilo documento per la fattura d'acquisto con registro tipo IA")
	
end if
end event

type cb_salva from commandbutton within w_silver_copia_doc
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

type cb_cancella from commandbutton within w_silver_copia_doc
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

event clicked;dw_2.trigger event ue_delete(dw_1.getrow())
end event

type dw_3 from udw_base within w_silver_copia_doc
boolean visible = false
integer x = 2167
integer y = 1224
integer width = 526
integer height = 244
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_doc"
boolean hscrollbar = true
boolean vscrollbar = false
end type

type dw_4 from udw_base within w_silver_copia_doc
boolean visible = false
integer x = 1029
integer y = 1156
integer width = 1051
integer height = 344
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_orafo_riga_documento_ordine_260510_gd"
end type

type cb_crea_articoli from commandbutton within w_silver_copia_doc
integer x = 457
integer y = 960
integer width = 343
integer height = 100
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Articoli"
end type

event clicked;integer i, li_riga
string ls_cod_art, ls_test, ls_prod_int, ls_des_art
long ll_id_cat_codifica, ll_id_UC_base, ll_id_cat_com, ll_id_titolo
decimal ldc_calo, ldc_prezzo

ll_id_cat_codifica=dw_6.getitemnumber(1, "id_cat_codifica")
ll_id_UC_base=dw_6.getitemnumber(1, "id_uc_base")
ll_id_cat_com=dw_6.getitemnumber(1, "id_cat_com")
ll_id_titolo=dw_6.getitemnumber(1, "id_titolo")
ldc_calo=dw_6.getitemdecimal(1, "c_calo")
ls_prod_int=dw_6.getitemstring(1, "prod_interna")

dw_2.setsort("art")
dw_2.sort()
for i = 1 to dw_2.rowcount()
	ls_cod_art=dw_2.getitemstring(i, "art")
	if trim(ls_cod_art) >"  " then
		if i>1 then
			ls_test=dw_2.getitemstring(i - 1, "art")
			if ls_cod_art=ls_test then continue
		end if
		
		select codice
		into :ls_test
		from dba.articolo
		where codice=:ls_cod_art;
		if ls_test=ls_cod_art then
			//articolo esiste già
		else
			//occorre creare l'articolo
			li_riga=dw_5.insertrow(0)
			dw_5.setitem(li_riga, "codice", ls_cod_art)
			ls_des_art=dw_2.getitemstring(i, "des_art")
			dw_5.setitem(li_riga, "descrizione", ls_des_art)
			dw_5.setitem(li_riga, "des_breve", ls_des_art)
			dw_5.setitem(li_riga, "id_unita_conf_base", ll_id_UC_base)
			dw_5.setitem(li_riga, "id_cat_codifica", ll_id_cat_codifica)
			dw_5.setitem(li_riga, "id_cat_com_articolo", ll_id_cat_com)
			dw_5.setitem(li_riga, "id_titolo", ll_id_titolo)
			dw_5.setitem(li_riga, "coef_calo", ldc_calo)
			dw_5.setitem(li_riga, "prod_interna", ls_prod_int)
			if dw_5.trigger event ue_update()=1 then
				ldc_prezzo=dw_2.getitemdecimal(i, "prezzo")
				wf_carica_prezzo(ls_cod_art, ldc_prezzo)
			else
				messagebox("OK!", "Articolo "+ls_cod_art +" non importato!")
			end if
					
		end if
	end if
	
next
dw_2.setsort("num_riga")
dw_2.sort()
if dw_5.rowcount()>0 then 
		messagebox("OK!", "Articoli importati!")
else
	messagebox("OK!", "Nessun Articolo importato!")
end if
end event

type dw_5 from udw_base within w_silver_copia_doc
boolean visible = false
integer x = 78
integer y = 1148
integer width = 910
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_per_inserimento_art_da_imp_fatture"
boolean hscrollbar = true
end type

type dw_6 from udw_base within w_silver_copia_doc
integer x = 69
integer width = 3534
integer height = 168
boolean bringtotop = true
string dataobject = "d_dati_fissi_imp_fatture"
boolean vscrollbar = false
boolean livescroll = false
end type

type st_2 from statictext within w_silver_copia_doc
integer x = 2281
integer y = 964
integer width = 1248
integer height = 152
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Deve esistere un profilo documento con codice ~"IMPFAT~""
boolean focusrectangle = false
end type

