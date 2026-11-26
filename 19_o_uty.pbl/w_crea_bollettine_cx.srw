forward
global type w_crea_bollettine_cx from w_001
end type
type dw_5 from udw_base within w_crea_bollettine_cx
end type
type cb_crea_bollettine from commandbutton within w_crea_bollettine_cx
end type
type dw_1 from udw_base within w_crea_bollettine_cx
end type
type dw_2 from udw_base within w_crea_bollettine_cx
end type
type cb_1 from commandbutton within w_crea_bollettine_cx
end type
type cb_2 from commandbutton within w_crea_bollettine_cx
end type
type st_2 from statictext within w_crea_bollettine_cx
end type
type dw_6 from udw_base within w_crea_bollettine_cx
end type
type cb_3 from commandbutton within w_crea_bollettine_cx
end type
type cb_4 from commandbutton within w_crea_bollettine_cx
end type
type cbx_1 from checkbox within w_crea_bollettine_cx
end type
type cb_stampa from commandbutton within w_crea_bollettine_cx
end type
type tv_1 from u_tv_distinta within w_crea_bollettine_cx
end type
type dw_4 from u_dw_master_main within w_crea_bollettine_cx
end type
type p_1 from picture within w_crea_bollettine_cx
end type
type dw_3 from udw_base within w_crea_bollettine_cx
end type
end forward

global type w_crea_bollettine_cx from w_001
integer width = 3902
integer height = 2518
string title = "Crea Bollettine da Ordine"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
dw_5 dw_5
cb_crea_bollettine cb_crea_bollettine
dw_1 dw_1
dw_2 dw_2
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_6 dw_6
cb_3 cb_3
cb_4 cb_4
cbx_1 cbx_1
cb_stampa cb_stampa
tv_1 tv_1
dw_4 dw_4
p_1 p_1
dw_3 dw_3
end type
global w_crea_bollettine_cx w_crea_bollettine_cx

type variables
////////
end variables

forward prototypes
public subroutine wf_decifra ()
public subroutine wf_carica_prezzo (string as_cod_art, decimal adc_prezzo, integer ai_flag)
public subroutine wf_carica_listino_ven (long al_id_uc, decimal adc_prezzo, string as_cod_art)
public function integer wf_inserisci_righe (long al_id_doc, long al_id_caus, long al_id_locazione, long al_id_valuta, long al_id_tab_iva, long al_id_contropartita, long al_num_prog)
public subroutine f_componenti_distinta (long ll_id_distinta)
public subroutine wf_prepara_esplodi (long row, string data)
public subroutine wf_inserisci_pesi_riga (decimal quantita)
public subroutine wf_qta (long righe_old, long righe_new, long al_di_caus_magazzino, long al_id_locazione)
public function string wf_doc_gia_esistente (integer i, string ls_num_doc_originale, long al_id_prof_bollettina, long id_riga_ordine)
end prototypes

public subroutine wf_decifra ();//integer i, li_riga_inserita
//string ls_dati, ls_imp
//date ldt_data
//long ll_num
//decimal ldc_qta
//
//dw_2.reset()
//for i = 1 to dw_1.rowcount()
//	ls_dati=dw_1.getitemstring(i, "a1")
//	
//	
//	ls_imp=mid(ls_dati, 16, 6)
//	if ls_imp>"      " then
//		li_riga_inserita=dw_2.insertrow(0)
//		dw_2.setitem(li_riga_inserita, "num_doc", ls_imp)
//	else
//		continue
//	end if
//	
//	ls_imp=mid(ls_dati, 5, 6)
//	ls_imp=right(ls_imp, 2)+"/"+mid(ls_imp, 3,2)+"/"+left(ls_imp, 2)
//	ldt_data=date(ls_imp)
//	dw_2.setitem(li_riga_inserita, "data_doc", ldt_data)
//	
//	ls_imp=mid(ls_dati, 22, 2)
//	dw_2.setitem(li_riga_inserita, "serie", ls_imp)
//	
//	ls_imp=mid(ls_dati, 24, 5)
//	ll_num=long(ls_imp)
//	dw_2.setitem(li_riga_inserita, "num_riga", ll_num)
//	
//	ls_imp=mid(ls_dati, 29, 20)
//	dw_2.setitem(li_riga_inserita, "art", ls_imp)
//	
//	ls_imp=mid(ls_dati, 49, 40)
//	dw_2.setitem(li_riga_inserita, "des_art", ls_imp)
//	
//	ls_imp=mid(ls_dati, 99, 9)
//	ls_imp=left(ls_imp, 6)+","+right(ls_imp, 3)
//	ldc_qta=	dec(ls_imp)
//	dw_2.setitem(li_riga_inserita, "qta", ldc_qta)
//	
//	ls_imp=mid(ls_dati, 108, 14)
//	ls_imp=left(ls_imp, 11)+","+right(ls_imp, 3)
//	ldc_qta=	dec(ls_imp)
//	dw_2.setitem(li_riga_inserita, "prezzo", ldc_qta)
//	
//	ls_imp=mid(ls_dati, 134, 6)
//	ls_imp=left(ls_imp, 4)+","+right(ls_imp, 2)
//	ldc_qta=	dec(ls_imp)
//	dw_2.setitem(li_riga_inserita, "sconto1", ldc_qta)
//	
//	ls_imp=mid(ls_dati, 140, 6)
//	ls_imp=left(ls_imp, 4)+","+right(ls_imp, 2)
//	ldc_qta=	dec(ls_imp)
//	dw_2.setitem(li_riga_inserita, "sconto2", ldc_qta)
//	
//	ls_imp=mid(ls_dati, 152, 3)
//	dw_2.setitem(li_riga_inserita, "iva", ls_imp)
//		
//	
//next
end subroutine

public subroutine wf_carica_prezzo (string as_cod_art, decimal adc_prezzo, integer ai_flag);//long ll_id_uc, ll_id_var, ll_id_sog
//long ll_id_listino_fo, ll_id_listino_base, ll_id_var_base
//
////ll_id_sog=dw_6.getitemnumber(1, "id_sog_com")
//
//select id_listino
//into :ll_id_listino_fo
//from dba.sog_commerciale
//where id_sog_commerciale=:ll_id_sog
//;
//	select id_variazione
//	into :ll_id_var_base
//	from dba.variazione v, dba.listino l
//	where l.lis_base='S' and l.tipo='A'
//	and v.id_listino=l.id_listino
//	and v.data_inizio<= today() and (v.data_fine is null or v.data_fine>=today())
//	;
//if ll_id_listino_fo>0 then
//	select id_variazione
//	into :ll_id_var
//	from dba.variazione
//	where id_listino=:ll_id_listino_fo
//	and data_inizio<= today() and (data_fine is null or data_fine>=today())
//	;
//end if
//
//select id_unita_confezione
//into :ll_id_uc
//from unita_confezione u, articolo a
//where a.id_articolo=u.id_articolo
//and a.codice=:as_cod_art
//and u.unita_base='S'
//;
////testo il flag: se =0 inserimento, se =1 update
//if ai_flag=1 then  //aggiornamento
//	if messagebox("Attenzione!", "ART: "+as_cod_art+",  Prezzo: "+string(adc_prezzo)+ "- AGGIORNO?", &
//		stopsign!, yesno!)=1 then
//		
//	
//		if ll_id_var>0 then //se esiste un listino fornitore lo aggiorno
//			update dba.prezzo
//			set prezzo=:adc_prezzo
//			where id_variazione=:ll_id_var
//			and id_unita_confezione=:ll_id_uc;
//		
//			if sqlca.sqlnrows>0 then
//				commit;
//			else
//				rollback;
//				messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino personale non caricato!")
//			end if
//			
//		end if
//		//aggiorno il listino base acquisto
//		update dba.prezzo
//		set prezzo=:adc_prezzo
//		where id_variazione=:ll_id_var_base
//		and id_unita_confezione=:ll_id_uc;
//		
//		if sqlca.sqlnrows>0 then
//			commit;
//		else
//			rollback;
//			messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino base acquisto non caricato!")
//		end if
//	end if
//else //inserimento
//	if messagebox("Attenzione!", "ART: "+as_cod_art+",  Prezzo: "+string(adc_prezzo)+ "- INSERISCO?", &
//		stopsign!, yesno!)=1 then
//	
//		if ll_id_var>0 then //se esiste un listino fornitore inserisco
//			insert into dba.prezzo
//			(id_unita_confezione, id_variazione, prezzo)
//			values(:ll_id_uc, :ll_id_var, :adc_prezzo)
//			;
//			if sqlca.sqlcode=0 then
//				commit;
//			else
//				rollback;
//				messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino personale non caricato!")
//			end if
//		end if
//		//comunque inserisco il list acq base
//		insert into dba.prezzo
//		(id_unita_confezione, id_variazione, prezzo)
//		values(:ll_id_uc, :ll_id_var_base, :adc_prezzo)
//		;
//		if sqlca.sqlcode=0 then
//			commit;
//			wf_carica_listino_ven(ll_id_uc, adc_prezzo, as_cod_art)
//		else
//			rollback;
//			messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino base acquisto non caricato!")
//		end if
//	end if
//end if
//
end subroutine

public subroutine wf_carica_listino_ven (long al_id_uc, decimal adc_prezzo, string as_cod_art);//
//long ll_id_var
//decimal ldc_ricarico
////recupero id_variazione del listino vendita
//ll_id_var=dw_6.getitemnumber(1, "lis_vendita")
//ldc_ricarico=dw_6.getitemnumber(1, "ricarico")
//
//if ll_id_var>0 and ldc_ricarico>=0 then
//	insert into dba.prezzo
//	(id_unita_confezione, id_variazione, prezzo)
//	values(:al_id_uc, :ll_id_var, :adc_prezzo*:ldc_ricarico)
//	;
//	if sqlca.sqlcode=0 then
//		commit;
//	else
//		rollback;
//		messagebox("Attenzione!", "Prezzo Articolo "+as_cod_art+" nel listino vendita non caricato!")
//	end if
//else
//	messagebox("Attenzione!", "Inserire listino vendita!")
//end if
end subroutine

public function integer wf_inserisci_righe (long al_id_doc, long al_id_caus, long al_id_locazione, long al_id_valuta, long al_id_tab_iva, long al_id_contropartita, long al_num_prog);long ll_id_articolo, ll_riga, ll_id_UC
integer i
string ls_cod_art, ls_des_art
decimal ldc_qta, ldc_prezzo,ldc_misura,ldc_coef_calo

for i= 1 to dw_4.rowcount()
		ls_cod_art=dw_4.getitemstring(i, "art")
		ls_cod_art=trim(ls_cod_art)
		if ls_cod_art>" " then
			select a.id_articolo, id_unita_confezione, dim_l, coef_calo, a.descrizione
			into :ll_id_articolo, :ll_id_UC, :ldc_misura, :ldc_coef_calo, :ls_des_art
			from dba.articolo a, dba.unita_confezione u
			where a.codice=:ls_cod_art
			and a.id_articolo=u.id_articolo
			and u.unita_base='S'
			;
			if ll_id_articolo>0 then
				ll_riga=dw_4.insertrow(0)
				dw_4.setitem(ll_riga, "id_documento", al_id_doc)
				dw_4.setitem(ll_riga, "riga_documento_num_riga", i)
				dw_4.setitem(ll_riga, "riga_documento_id_caus_magazzino", al_id_caus)
				dw_4.setitem(ll_riga, "id_locazione_1", al_id_locazione)
				dw_4.setitem(ll_riga, "riga_documento_id_valuta", al_id_valuta)
				dw_4.setitem(ll_riga, "riga_documento_cambio", 1)
				dw_4.setitem(ll_riga, "tipo_um", "N")
				dw_4.setitem(ll_riga, "riga_documento_id_conto", al_id_contropartita)
				dw_4.setitem(ll_riga, "riga_documento_descrizione", ls_des_art)
				dw_4.setitem(ll_riga, "riga_documento_id_articolo", ll_id_articolo)
				dw_4.setitem(ll_riga, "riga_documento_id_unita_confezione", ll_id_UC)
				dw_4.setitem(ll_riga, "riga_documento_dim_l", ldc_misura)
				dw_4.setitem(ll_riga, "coef_calo", ldc_coef_calo)
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
			else
				messagebox("Ahi!", "Articolo:"+ls_cod_art+ " non trovato nel DB! Forse non è stato inserito? O il codice scritto nel file excel non è corretto?")
			end if
			
		end if
		
		
		
		
next
if dw_4.update() = 1 then
	messagebox("OK!", "Documento n. "+string(al_num_prog)+" importato correttamente!")
else
	messagebox("Ahi!", "Documento non importato!")
end if
return 1
end function

public subroutine f_componenti_distinta (long ll_id_distinta);u_tv_distinta luo_distinta

if upperbound(tv_1.is_comp) >0 then 
	u_tv_distinta app
	app = create u_tv_distinta
	tv_1.is_comp = app.is_comp
	destroy app
end if
	
f_rec_righe_comp(tv_1,0,true,ll_id_distinta,date('01/01/90'),date('31/12/99'),ll_id_distinta,false)
if upperbound(tv_1.is_comp) >0 then 
	luo_distinta=create u_tv_distinta
	luo_distinta.is_comp=tv_1.is_comp
	openwithparm(w_variante_comp_ff,luo_distinta)
	luo_distinta=message.powerobjectparm
	if isvalid(luo_distinta) then 
		tv_1.is_comp=luo_distinta.is_comp
		destroy luo_distinta;
	else
		messagebox("Errore","Si e verificato un errore nel passaggio di parametri")
		destroy luo_distinta;
		return
	end if
	tv_1.deleteitem(0)							
end if
							
end subroutine

public subroutine wf_prepara_esplodi (long row, string data);long ll_articolo,ll_id_cat_fiscale,ll_null,ll_id_distinta,ll_ret,ll_riga, ll_righe_new, ll_totrows
string ls_ges, ls_tipo_reg
long ll_prof, ll_righe_old, ll_id_caus
integer li_ret, i
string ls_parigi, ls_la
dec{4} ld_qta 
boolean lb_ok
long ll_id_valuta, ll_id_causale, ll_id_locazione
integer li_ges_lotti
setnull(ll_null)


ll_riga=row 
ll_articolo=dw_2.getitemnumber(ll_riga,"riga_documento_id_articolo")
select id_cat_fiscale
into :ll_id_cat_fiscale
from articolo
where id_articolo=:ll_articolo;


if isnull(ll_id_cat_fiscale) then	
	select id_distinta 
	into :ll_id_distinta
	from distinta
	where id_articolo=:ll_articolo;
	if ll_id_distinta>0 then
		ll_id_locazione=dw_4.getitemnumber(1,"id_locazione_1")	
		ll_id_caus=dw_4.getitemnumber(1,"riga_documento_id_caus_magazzino")
		//controllare se è il caso di annullare caus e locazione o no ... 210312
		//l'annullo perché se esplodo e reta causale muovo 2 volte la stessa cosa (finito e componenti)
		//invece vanno mossi solo i componenti (credo)
		dw_4.setitem(1,"id_locazione_1",ll_null)
		dw_4.setitem(1,"id_locazione_2",ll_null)	
		dw_4.setitem(1,"riga_documento_id_caus_magazzino",ll_null)	
		
		ll_righe_old=dw_4.rowcount()						
		if dw_4.update()=1 then
			commit;
		else
			rollback;
			messagebox("Attenzione!", "Riga non salvata!")
		end if
	//mm commento 051212 per cambio sistema di varianti (non più var_dis_cliente ma orafo Dis_cliente ...
		//f_componenti_distinta(ll_id_distinta)
		f_esplodi_documento_2(tv_1,0,true,ll_id_distinta,date('01/01/90'),date('31/12/99'),ll_id_distinta,dw_4,dec(data),li_ges_lotti, 1)
		ll_righe_new=dw_4.rowcount()
		wf_qta(ll_righe_old,ll_righe_new, ll_id_caus, ll_id_locazione)
				
			
	end if
end if

end subroutine

public subroutine wf_inserisci_pesi_riga (decimal quantita);long 		ll_id_u_conf, ll_row
decimal{4} ld_peso_netto, ld_peso_lordo, ld_quantita, ld_dim_l, ld_dim_h, ld_dim_p
decimal{4} ld_controlla_misura


		ll_row=dw_4.getrow()
		
		ll_id_u_conf=dw_4.getitemnumber(ll_row, "riga_documento_id_unita_confezione")
		
		SELECT 	"unita_confezione"."peso_netto", "unita_confezione"."peso_lordo",	
					"unita_confezione"."dim_l", 
					"unita_confezione"."dim_h", 
					"unita_confezione"."dim_p"
		into :ld_peso_netto, :ld_peso_lordo, :ld_dim_l, :ld_dim_h, :ld_dim_p
		from "unita_confezione"
		where "unita_confezione"."id_unita_confezione" = :ll_id_u_conf;
		
		if isnull(ld_dim_l) then ld_dim_l=0
	
		if quantita = 0 then		
			ld_quantita = dw_4.getitemnumber(ll_row, "quantita" )
			if isnull(ld_quantita) then ld_quantita = 0
		else 
			ld_quantita = quantita
		end if
		if not (dw_4.getitemdecimal(ll_row, "riga_documento_peso_netto")>0) then
			
			if not(isnull(ld_peso_netto) or ld_peso_netto=0) then
				
				ld_peso_netto = ld_peso_netto * ld_quantita 
				if (ld_peso_netto > 0) and (ll_id_u_conf > 0) then
					ld_peso_netto = uf_converti_peso(ll_id_u_conf, ld_peso_netto)
				end if
				dw_4.setitem(ll_row, "riga_documento_peso_netto", ld_peso_netto)
			end if
			
			if not(isnull(ld_peso_lordo) or ld_peso_lordo=0) then
				
				ld_peso_lordo = ld_peso_lordo * ld_quantita 
				if (ld_peso_lordo > 0 and not isnull(ld_peso_lordo)) and (ll_id_u_conf > 0 and not isnull(ll_id_u_conf)) then
					ld_peso_lordo = uf_converti_peso(ll_id_u_conf, ld_peso_lordo)
				end if
				dw_4.setitem(ll_row, "riga_documento_peso_netto", ld_peso_lordo)
			end if
		end if
		
		
		ld_controlla_misura=dw_4.getitemdecimal(ll_row, "riga_documento_dim_l")
		
		if ld_controlla_misura=0 then
			dw_4.setitem(ll_row, "riga_documento_dim_l", ld_dim_l )
			dw_4.setitem(ll_row, "riga_documento_dim_h", ld_dim_h )
			dw_4.setitem(ll_row, "riga_documento_dim_p", ld_dim_p )
		end if
		
end subroutine

public subroutine wf_qta (long righe_old, long righe_new, long al_di_caus_magazzino, long al_id_locazione);long i,row,ll_row,ll_id_unita_conf,ll_doc,ll_riga_padre
dwobject ldwo_pippo
decimal ld_qta,ld_qta_max,ldc_null
string ls_message
dwitemstatus ldw_status
ll_doc=dw_4.getitemnumber(righe_old,"id_documento")

ll_riga_padre=dw_4.getitemnumber(righe_old ,"id_riga_documento")
//ll_di_caus_magazzino=
for i=righe_old+1 to righe_new
	row=i
	ll_row=i
	dw_4.setrow(i)
	dw_4.event trigger ue_initial()
	dw_4.setitem(i,"id_documento",ll_doc)
	dw_4.setitem(i,"id_riga_doc_padre",ll_riga_padre)
	dw_4.setitem(i, "riga_documento_id_caus_magazzino", al_di_caus_magazzino)
	dw_4.setitem(i, "id_locazione_1", al_id_locazione)
	
	ld_qta=dw_4.getitemdecimal(i,"quantita")
	
	ld_qta_max=dw_4.getitemdecimal(row, "qta_sconto_merce")
	
	
	if ld_qta_max>ld_qta then
	
		ls_message="La quantità inserita è inferiore o uguale~r~nalla quantità sconto merce!.~r~nInserire una quantità maggiore!"
		dw_4.post event ue_post_itemchanged(row,"quantita", ls_message)
	end if
	
	
	dw_4.post event ue_set_calc_tot_riga(ll_row, ld_qta, ldc_null, FALSE)

	wf_inserisci_pesi_riga (ld_qta)
next

end subroutine

public function string wf_doc_gia_esistente (integer i, string ls_num_doc_originale, long al_id_prof_bollettina, long id_riga_ordine);string ls_contatore, ls_num_doc 
long ll_test,  ll_num_prog


ls_contatore=string(i)
do while len(ls_contatore)<3
	ls_contatore="0"+ls_contatore
loop
ls_num_doc=ls_num_doc_originale+"_"+ls_contatore
//ls_contatore=""
//select id_documento
//into :ll_test
//from dba.documento
//where num_documento=:ls_num_doc
//and id_prof_documento=:al_id_prof_bollettina;
//if ll_test>0 then
//	messagebox("Attenzione!", "Documento "+ls_num_doc+" già esistente!")
//	return ""
//else
//	return ls_num_doc
//end if
select d.num_progressivo
into :ll_num_prog
from dba.riga_documento r, dba.documento d
where provv_imp_subage_2=:id_riga_ordine
and d.id_documento=r.id_documento
;
if isnull(ll_num_prog) or ll_num_prog=0 then
	return ls_num_doc
else
	messagebox("Attenzione!", "Documento "+ls_num_doc+ "prog. "+ string(ll_num_prog)+" già esistente!")
	return ""
end if


end function

on w_crea_bollettine_cx.create
int iCurrent
call super::create
this.dw_5=create dw_5
this.cb_crea_bollettine=create cb_crea_bollettine
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_6=create dw_6
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cbx_1=create cbx_1
this.cb_stampa=create cb_stampa
this.tv_1=create tv_1
this.dw_4=create dw_4
this.p_1=create p_1
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.cb_crea_bollettine
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_6
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.cb_4
this.Control[iCurrent+11]=this.cbx_1
this.Control[iCurrent+12]=this.cb_stampa
this.Control[iCurrent+13]=this.tv_1
this.Control[iCurrent+14]=this.dw_4
this.Control[iCurrent+15]=this.p_1
this.Control[iCurrent+16]=this.dw_3
end on

on w_crea_bollettine_cx.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.cb_crea_bollettine)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_6)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cbx_1)
destroy(this.cb_stampa)
destroy(this.tv_1)
destroy(this.dw_4)
destroy(this.p_1)
destroy(this.dw_3)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_5.settransobject(sqlca)
dw_6.settransobject(sqlca)


dw_1.retrieve()
dw_5.insertrow(1)


dw_1.trigger event rowfocuschanged(1)


end event

type st_1 from w_001`st_1 within w_crea_bollettine_cx
end type

type dw_5 from udw_base within w_crea_bollettine_cx
integer x = 51
integer y = 13
integer width = 1587
integer height = 173
boolean bringtotop = true
string dataobject = "d_dati_fissi_imp_ordini"
boolean vscrollbar = false
boolean livescroll = false
end type

type cb_crea_bollettine from commandbutton within w_crea_bollettine_cx
integer x = 2889
integer y = 1677
integer width = 417
integer height = 99
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea Bollettine"
end type

event clicked;integer i, li_ret
long ll_id_prof_doc, ll_id_registro, ll_num_prog, ll_id_sog
long ll_id_valuta, ll_id_prof_reg, ll_id_doc, ll_id_caus, ll_riga_doc_selezionata
string ls_num_doc, ls_des_art,ls_contatore, ls_num_doc_originale
date ldt_data_doc
long ll_id_locazione, ll_id_contropartita, ll_id_tab_iva,ll_riga_stampa
long ll_test,ll_id_mod_reg,ll_riga, ll_id_articolo, ll_id_uc,ll_id_null, ll_riga_inserita
decimal ldc_qta, ldc_misura, ldc_coef_calo, ldc_prezzo, ldc_qta_divisa
long ll_riga_passata, ll_id_riga, ll_id_riga_ordine,ll_id_bol, ll_righe_prod, ll_riga_esiste
date ldt_data_scadenza
string ls_bollo, ls_nota_produzione, ls_nota_qualita
datastore ds_prod_2011

setnull(ll_id_null)
dw_4.reset()


ll_id_prof_doc=dw_5.getitemnumber(1, "id_profilo")
if ll_id_prof_doc>0 then
	//recupero subito data e num doc: se esiste già non se ne fa di nulla
	// adesso recupero data e num doc della fattura
	ll_riga_doc_selezionata=dw_1.GetSelectedRow(0)
	if ll_riga_doc_selezionata>0 then
		ldt_data_doc=dw_5.getitemdate(1, "data_doc")
		//il numero è nel file excel: prima riga, campo "pezzi"
		ls_num_doc_originale=dw_1.getitemstring(ll_riga_doc_selezionata, "num_documento")
		//140312 recupero anche bollo eventuale e data prev_consegna (data scadenza ordine)
		ldt_data_scadenza=dw_1.getitemdate(ll_riga_doc_selezionata, "data_prev_consegna")
		ls_bollo=dw_1.getitemstring(ll_riga_doc_selezionata, "bollo")
		//140312
		//05-03-14 sostituisco sog commerciale con quello del documento
		ll_id_sog=dw_1.getitemnumber(ll_riga_doc_selezionata, "id_sog_commerciale")	
		//ll_id_sog=dw_5.getitemnumber(1, "id_sog_com")
		//fine  05-03-14
		select id_mod_registro_prop
		into :ll_id_mod_reg
		from dba.prof_documento
		where id_prof_documento=:ll_id_prof_doc
		;
		
		select id_registro
		into :ll_id_registro
		from dba.registro r, dba.esercizio e
		where id_mod_registro=:ll_id_mod_reg
		and e.id_esercizio=r.id_esercizio
		and e.data_inizio<=today()
		and e.data_fine>=today()
		;
		if ll_id_registro >0 then
			//recupero l'id_documento dell'ordine che crea le bollettine
			
			for i= 1 to dw_2.rowcount()
				dw_4.reset()
				ll_id_riga_ordine=dw_2.getitemnumber(i, "id_riga_documento")
				ls_num_doc=wf_doc_gia_esistente(i, ls_num_doc_originale, ll_id_prof_doc, ll_id_riga_ordine)
				if ls_num_doc="" then continue
				//da pensare: devo testare se la riga è padre o se è una figlia di un'altra riga (id_riga_doc_padre)?
				//per ora vado avanti così ...
				ldc_qta=dw_2.getitemdecimal(i, "quantita")
				//questo lo commemnto per il momento per semplificare il lavoro poi lo rimetto 190312
//				do while ldc_qta>0 
//					if ldc_qta>1300 then
//						ldc_qta_divisa=1000
//					else
//						ldc_qta_divisa=ldc_qta
//					end if
				//ldc_qta -= 1000
				ldc_qta_divisa=ldc_qta  //questa poi la togli ma per ora è essenziale
//         //fine commento da rimettere a posto
					
				
					//inserisco riga per creare testa doc bollettina
					dw_3.insertrow(1)
					
					//140312 inserisco anche bollo eventuale e data prev_consegna (data scadenza ordine)
					dw_3.setitem(1, "data_prev_consegna", ldt_data_scadenza)
					dw_3.setitem(1, "bollo", ls_bollo)
					
					dw_3.setitem(1, "data_documento", ldt_data_doc)
					dw_3.setitem(1, "data_competenza", ldt_data_doc)
					dw_3.setitem(1, "num_documento", ls_num_doc)
						
					dw_3.setitem(1, "id_prof_documento", ll_id_prof_doc)
					select id_prof_registrazione, id_caus_magazzino_prop, id_locazione_1_prop, id_mod_registro_prop
					into :ll_id_prof_reg, :ll_id_caus, :ll_id_locazione, :ll_id_mod_reg
					from dba.prof_documento
					where id_prof_documento=:ll_id_prof_doc;
					
					dw_3.setitem(1, "id_magazzino", ll_id_locazione)
					dw_3.setitem(1, "documento_id_locazione_1", ll_id_locazione)
					dw_3.setitem(1, "id_caus_magazzino", ll_id_caus)
					
					
					dw_3.setitem(1, "id_prof_registrazione", ll_id_prof_reg)
					dw_3.setitem(1, "id_registro", ll_id_registro)
					
					select num_progressivo
					into :ll_num_prog
					from registro
					where id_registro=:ll_id_registro
					;
					dw_3.setitem(1, "num_progressivo", ll_num_prog)
					dw_3.setitem(1, "data_registrazione", 	today())
					dw_3.setitem(1, "id_sog_commerciale", 	ll_id_sog)
					dw_3.setitem(1, "id_sog_commerciale_fattura", 	ll_id_sog)
					//trova contropartita
					select id_conto
					into :ll_id_contropartita
					from dba.con_movimento
					where id_sog_commerciale=:ll_id_sog
					and applicazione='V'
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
						into :ll_id_tab_iva
						from dba.par_sistema;
					end if
					
					//valuta
					select id_val_euro
					into :ll_id_valuta
					from dba.par_sistema;
					dw_3.setitem(1, "id_valuta", 	ll_id_valuta)
					
					//ora provo a salvare
					dw_3.triggerevent("ue_update")
					
					ll_id_doc=dw_3.getitemnumber(1, "id_documento")
					//se tutto va bene carico le righe
					
					if ll_id_doc>0 then
						//proviamo a vedere se copiando la riga e cambiando solo qta, 
						//id_documento e stato può fungere ...
						
						if dw_2.rowscopy(i, i, Primary!, dw_4, 1, Primary!)=1 then
							//qui va inserito recupero note prod e qualità
							//però ci manca l'id_riga_documento qundi occorre saqlvare riga riga
							//recuperare l'id_riga e salvare in note prod e qualità con l'id Riga recuperato
							
							dw_4.setitem(1, "id_riga_documento", ll_id_null)
							dw_4.setitem(1, "quantita", ldc_qta_divisa)
							dw_4.setitem(1, "qta_un_base", ldc_qta_divisa)
							dw_4.setitem(1, "id_documento", ll_id_doc)
							dw_4.setitem(1, "riga_documento_id_caus_magazzino", ll_id_caus)
							dw_4.setitem(1, "id_locazione_1", ll_id_locazione)
							dw_4.setitem(1, "riga_documento_peso_netto", 0)
							dw_4.setitem(1, "peso_netto_evaso", 0)
							
							dw_4.setitem(1, "riga_documento_num_riga", 1)
							li_ret=dw_4.setitem(1, "riga_documento_provv_imp_subage_2", ll_id_riga_ordine)
							if li_ret<>1 then
								messagebox("Attenzione!", "Bollettina "+string(ll_num_prog)+" NON collegata all'ordine!!!")
							end if
							
							//dw_4.setitem(1, "id_riga_doc_provenienza", ll_id_riga_ordine)
							//dw_4.setitemstatus(1, 0, Primary!, NewModified!)
							if dw_4.update()=1 then
								commit;
							else
								rollback;
								messagebox("Attenzione!", "Riga non salvata!")
							end if
							select id_riga_documento
							into :ll_id_riga
							from dba.riga_documento
							where id_documento=:ll_id_doc
							and num_riga=1
							;
							if ll_id_riga>0 then
								select nota_produzione, nota_qualita
								into :ls_nota_produzione ,:ls_nota_qualita
								from dba.nota_riga_documento
								where note_id_riga_doc=:ll_id_riga_ordine
								;
								if ls_nota_produzione>" " or ls_nota_qualita>" " then
									insert into dba.nota_riga_documento
									values(:ll_id_riga, :ls_nota_produzione, :ls_nota_qualita)
									;
									if sqlca.sqlcode=0 then
										commit;
									else
										rollback;
										messagebox("Attenzione!", "Nota prod. e Qualità non salvata!")
									end if
								end if
							else
								messagebox("Attenzione!", "Riga non salvata!")
							end if
							//esplodo la riga inserita nella bollettina nei suoi componenti
							wf_prepara_esplodi(i, string(ldc_qta_divisa))
													
							//inserisco in dw per stampa bollettine create
							ll_riga_stampa=dw_6.insertrow(0)
							dw_6.setitem(ll_riga_stampa, "id_documento", ll_id_doc)
							dw_6.setitem(ll_riga_stampa, "num_progressivo", ll_num_prog)
							dw_6.setitem(ll_riga_stampa, "data_registrazione", today())
							dw_6.setitem(ll_riga_stampa, "pezzi", ldc_qta_divisa)
							dw_6.setitem(ll_riga_stampa, "num_doc", ls_num_doc)
							
						else
							messagebox("Attenzione!", "Riga non copiata!")	
						end if
					else
						messagebox("Errore!", "Documento non salvato!")
					end if
				//commentato 190312 da rimettere a posto				
//				loop
				//fine commentato 190312 da rimettere a posto
				
				//provo a salvare le righe una riga alla volta (con le righe esplose se ci sono)
				if dw_4.update()=1 then
					commit;
//					//devo legare l'ordine alla bollettina (id_bollettina- id_doc_ordine in produzione_2011
					ll_id_bol=dw_4.getitemnumber(1, "id_documento")
					ds_prod_2011=create datastore
					ds_prod_2011.dataobject="d_produzione_2011_ra_gd"
					ds_prod_2011.settransobject(sqlca)
					ll_righe_prod=ds_prod_2011.retrieve(ll_id_bol)
					if ll_righe_prod>0 then
						ll_riga_esiste=ds_prod_2011.find("id_doc_produzione="+string(ll_id_riga_ordine), 1, ds_prod_2011.rowcount())
					else
						ll_riga_esiste=0
					end if
					//se esiste già non faccio nulla
					if ll_riga_esiste<=0 then
						ll_riga_inserita=ds_prod_2011.insertrow(0)
						ds_prod_2011.setitem(ll_riga_inserita, "id_bollettina", ll_id_bol)
						ds_prod_2011.setitem(ll_riga_inserita, "id_doc_produzione", ll_id_riga_ordine)
						//salvo
						if ds_prod_2011.update()=1 then
							commit;
						else
							rollback;
							messagebox("Errore!", "Legame con bollettina non salvato!")
						end if
					end if
										
							
							
					ll_riga_passata=dw_1.getselectedrow(0)
					dw_1.setitem(ll_riga_passata, "stampato", "S")
					if dw_1.triggerevent("ue_update")<>1 then
						messagebox("Errore!", "Ordine non segnato come passato!")
					end if
					
				else
					rollback;
					messagebox("Errore!", "Righe non salvate!")
				end if
			next
// finito ciclo sulle righe
		else
			messagebox("Errore!", "Manca il registro!")
		end if
	else
		messagebox("Errore!", "Devi selezionare prima un ordine!")
	end if
	messagebox("OK!", "Bollettine create correttamente, salvo quelle già esistenti!")
else
	messagebox("Errore!", "Occorre scegliere un profilo!")
end if

end event

type dw_1 from udw_base within w_crea_bollettine_cx
integer x = 51
integer y = 195
integer width = 2406
integer height = 925
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_doc_segna_passati_prog"
boolean hscrollbar = true
boolean livescroll = false
end type

event clicked;call super::clicked;long ll_id_doc,ll_num_prog,ll_riga_stampa
long ll_id_sog, ll_id_bollettina, ll_righe_trovate
string ls_num_bollettina
datastore ds_rec_bol
integer i

if row>0 then
	selectrow(0, false)
	selectrow(row, not(isselected(row)))
	scrolltorow(row)
	
	ll_id_doc=getitemnumber(row, "id_documento")
	
	dw_2.retrieve(ll_id_doc)
	
ds_rec_bol=create datastore
//ds_rec_bol.dataobject="ds_recupera_bollettine"
ds_rec_bol.dataobject="d_prod_trova_bol_gd"
ds_rec_bol.settransobject(sqlca)
if dw_2.rowcount()>0 then
		//ls_num_bollettina="%"+getitemstring(row, "num_documento")+"%"
		
		//ll_righe_trovate=ds_rec_bol.retrieve(ls_num_bollettina)
		ll_righe_trovate=ds_rec_bol.retrieve(ll_id_doc)
		if ll_righe_trovate>0 then
			messagebox("Attenzione!", "Bollettina già esistente")
		end if
		for i=1 to ll_righe_trovate
			ll_id_doc=ds_rec_bol.getitemnumber(i, "id_documento")
			ll_num_prog=ds_rec_bol.getitemnumber(i, "num_progressivo")
			ls_num_bollettina=ds_rec_bol.getitemstring(i, "num_documento")
			
			//inserisco in dw per stampa bollettine create
			ll_riga_stampa=dw_6.insertrow(0)
			dw_6.setitem(ll_riga_stampa, "id_documento", ll_id_doc)
			dw_6.setitem(ll_riga_stampa, "num_progressivo", ll_num_prog)
			dw_6.setitem(ll_riga_stampa, "data_registrazione", today())
			dw_6.setitem(ll_riga_stampa, "pezzi", 0)
			dw_6.setitem(ll_riga_stampa, "num_doc", ls_num_bollettina)
			
		next
//			ds_rec_bol.rowscopy(1, ll_righe_trovate, primary!, dw_6, 1, primary!)
//		end if
		
	end if
end if
	destroy ds_rec_bol
	
	
	
end event

event sqlpreview;call super::sqlpreview;//string ls_sql
//
//integer i
//
//ls_sql=sqlsyntax
//
//	
//ls_sql=ls_sql + " and registro.tipo_registro='OV' "
//	
//
//setsqlpreview(ls_sql)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id_sog

if currentrow>0 and rowcount()>0 then
	ll_id_sog=getitemnumber(currentrow, "id_sog_commerciale")
	dw_5.setitem(1, "id_sog_com", ll_id_sog)
end if


end event

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

type dw_2 from udw_base within w_crea_bollettine_cx
integer x = 51
integer y = 1149
integer width = 2831
integer height = 733
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_orafo_riga_documento_ordine_260510_gd"
end type

type cb_1 from commandbutton within w_crea_bollettine_cx
integer x = 3397
integer y = 35
integer width = 344
integer height = 99
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Chiudi"
end type

event clicked;close(parent)
end event

type cb_2 from commandbutton within w_crea_bollettine_cx
boolean visible = false
integer x = 3185
integer y = 1389
integer width = 625
integer height = 99
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "vecchio crea bollettine"
end type

event clicked;//integer i
//long ll_id_prof_doc, ll_id_registro, ll_num_prog, ll_id_sog
//long ll_id_valuta, ll_id_prof_reg, ll_id_doc, ll_id_caus, ll_riga_doc_selezionata
//string ls_num_doc, ls_des_art,ls_contatore, ls_num_doc_originale
//date ldt_data_doc
//long ll_id_locazione, ll_id_contropartita, ll_id_tab_iva
//long ll_test,ll_id_mod_reg,ll_riga, ll_id_articolo, ll_id_uc
//decimal ldc_qta, ldc_misura, ldc_coef_calo, ldc_prezzo, ldc_qta_divisa
//dw_3.reset()
//dw_4.reset()
//
//ll_id_prof_doc=dw_5.getitemnumber(1, "id_profilo")
//if ll_id_prof_doc>0 then
//	//recupero subito data e num doc: se esiste già noin se ne fa di nulla
//	// adesso recupero data e num doc della fattura
//	ll_riga_doc_selezionata=dw_1.GetSelectedRow(0)
//	if ll_riga_doc_selezionata>0 then
//		
//		ldt_data_doc=dw_5.getitemdate(1, "data_doc")
//		//il numero è nel file excel: prima riga, campo "pezzi"
//		ls_num_doc_originale=dw_1.getitemstring(ll_riga_doc_selezionata, "num_documento")
//						
//		
//		ll_id_sog=dw_5.getitemnumber(1, "id_sog_com")
//		select id_mod_registro_prop
//		into :ll_id_mod_reg
//		from dba.prof_documento
//		where id_prof_documento=:ll_id_prof_doc
//		;
//		
//		select id_registro
//		into :ll_id_registro
//		from dba.registro r, dba.esercizio e
//		where id_mod_registro=:ll_id_mod_reg
//		and e.id_esercizio=r.id_esercizio
//		and e.data_inizio<=today()
//		and e.data_fine>=today()
//		;
//		if ll_id_registro >0 then
//			for i= 1 to dw_2.rowcount()
//				ls_contatore=string(i)
//				do while len(ls_contatore)<3
//					ls_contatore="0"+ls_contatore
//				loop
//				ls_num_doc="GA_"+ls_num_doc_originale+"_"+ls_contatore
//				ls_contatore=""
//				select id_documento
//				into :ll_test
//				from dba.documento
//				where num_documento=:ls_num_doc
//				and id_prof_documento=:ll_id_prof_doc;
//				if ll_test>0 then
//					messagebox("Attenzione!", "Documento "+ls_num_doc+" già esistente!")
//					continue
//				end if
//				//da pensare: devo testare se la riga è padre o se è una figlia di un'altra riga (id_riga_doc_padre)?
//				//per ora vado avanti così ...
//					ldc_qta=dw_2.getitemdecimal(i, "quantita")
//					do while ldc_qta>0 
//						if ldc_qta>1300 then
//							ldc_qta_divisa=1000
//						else
//							ldc_qta_divisa=ldc_qta
//						end if
//						ldc_qta -= 1000
//						dw_3.insertrow(1)
//				
//						dw_3.setitem(1, "data_documento", ldt_data_doc)
//						dw_3.setitem(1, "data_competenza", ldt_data_doc)
//						dw_3.setitem(1, "num_documento", ls_num_doc)
//							
//						dw_3.setitem(1, "id_prof_documento", ll_id_prof_doc)
//						select id_prof_registrazione, id_caus_magazzino_prop, id_locazione_1_prop, id_mod_registro_prop
//						into :ll_id_prof_reg, :ll_id_caus, :ll_id_locazione, :ll_id_mod_reg
//						from dba.prof_documento
//						where id_prof_documento=:ll_id_prof_doc;
//						dw_3.setitem(1, "id_prof_registrazione", ll_id_prof_reg)
//						dw_3.setitem(1, "id_registro", ll_id_registro)
//						select num_progressivo
//						into :ll_num_prog
//						from registro
//						where id_registro=:ll_id_registro
//						;
//						dw_3.setitem(1, "num_progressivo", ll_num_prog)
//						dw_3.setitem(1, "data_registrazione", 	today())
//						
//						
//						dw_3.setitem(1, "id_sog_commerciale", 	ll_id_sog)
//						dw_3.setitem(1, "id_sog_commerciale_fattura", 	ll_id_sog)
//						//trova contropartita
//						select id_conto
//						into :ll_id_contropartita
//						from dba.con_movimento
//						where id_sog_commerciale=:ll_id_sog
//						and applicazione='V'
//						;
//						if isnull(ll_id_contropartita) or ll_id_contropartita=0 then
//							select id_conto_predefinito
//							into :ll_id_contropartita
//							from dba.par_sistema;
//						end if
//						select id_tab_iva
//						into :ll_id_tab_iva
//						from dba.sog_commerciale
//						where id_sog_commerciale=:ll_id_sog
//						;
//						if isnull(ll_id_tab_iva) then
//							select id_conto_iva_ia
//							into :ll_id_tab_iva
//							from dba.par_sistema;
//						end if
//						
//						//valuta
//						select id_val_euro
//						into :ll_id_valuta
//						from dba.par_sistema;
//						dw_3.setitem(1, "id_valuta", 	ll_id_valuta)
//						
//						//ora provo a salvare
//						dw_3.triggerevent("ue_update")
//						//se tutto va bene carico le righe
//						ll_id_doc=dw_3.getitemnumber(1, "id_documento")
//					if ll_id_doc>0 then
//						//proviamo a vedere se copiando la riga e cambiando solo qta, 
//						//id_documento e stato può fungere ...
//						if dw_2.rowscopy(i, i, Primary!, dw_4, 1, Primary!)=1 then
//							
//							dw_4.setitem(i, "quantita", ldc_qta_divisa)
//							dw_4.setitem(i, "qta_un_base", ldc_qta_divisa)
//							dw_4.setitem(i, "id_documento", ll_id_doc)
//							dw_4.setitem(i, "riga_documento_id_caus_magazzino", ll_id_caus)
//							dw_4.setitem(i, "riga_documento_num_riga", i)
//							
//						else
//							messagebox("Attenzione!", "Riga no copiata!")
//						
//						end if
//						
//		  
//		  
//		  
////						ll_id_articolo=dw_2.getitemnumber(i, "riga_documento_id_articolo")
////						ll_id_UC=dw_2.getitemnumber(i, "riga_documento_id_unita_confezione")
////						ldc_misura=dw_2.getitemdecimal(i, "riga_documento_dim_l")
////						ldc_coef_calo=dw_2.getitemdecimal(i, "coef_calo")
////						ls_des_art=dw_2.getitemstring(i, "riga_documento_descrizione")
////						
////						if ll_id_articolo>0 then
////							ll_riga=dw_4.insertrow(0)
////							
////							dw_4.setitem(ll_riga, "quantita", ldc_qta_divisa)
////							dw_4.setitem(ll_riga, "qta_un_base", ldc_qta_divisa)
////							
////							dw_4.setitem(ll_riga, "id_documento", ll_id_doc)
////							dw_4.setitem(ll_riga, "riga_documento_num_riga", i)
////							dw_4.setitem(ll_riga, "riga_documento_id_caus_magazzino", ll_id_caus)
////							dw_4.setitem(ll_riga, "id_locazione_1", ll_id_locazione)
////							dw_4.setitem(ll_riga, "riga_documento_id_valuta", ll_id_valuta)
////							dw_4.setitem(ll_riga, "riga_documento_cambio", 1)
////							dw_4.setitem(ll_riga, "tipo_um", "N")
////							dw_4.setitem(ll_riga, "riga_documento_id_conto", ll_id_contropartita)
////							dw_4.setitem(ll_riga, "riga_documento_descrizione", ls_des_art)
////							dw_4.setitem(ll_riga, "riga_documento_id_articolo", ll_id_articolo)
////							dw_4.setitem(ll_riga, "riga_documento_id_unita_confezione", ll_id_UC)
////							dw_4.setitem(ll_riga, "riga_documento_dim_l", ldc_misura)
////							dw_4.setitem(ll_riga, "coef_calo", ldc_coef_calo)
////							
////							
////							ldc_prezzo=dw_2.getitemdecimal(i, "prezzo")
////							dw_4.setitem(ll_riga, "prezzo_complessivo", ldc_prezzo)
////							dw_4.setitem(ll_riga, "prezzo", ldc_prezzo)
////							dw_4.setitem(ll_riga, "riga_documento_prezzo_netto", ldc_prezzo)
////							dw_4.setitem(ll_riga, "riga_documento_id_tab_iva", ll_id_tab_iva)
////							//il totale è prezzo per qta
////							dw_4.setitem(ll_riga, "importo_manifattura", ldc_prezzo*ldc_qta_divisa)
////							dw_4.setitem(ll_riga, "tot_riga_val_riga", ldc_prezzo*ldc_qta_divisa)
////							dw_4.setitem(ll_riga, "tot_riga_val_az", ldc_prezzo*ldc_qta_divisa)
////							dw_4.setitem(ll_riga, "tot_riga_val_doc", ldc_prezzo*ldc_qta_divisa)
////							
////						end if
//					else
//						messagebox("Errore!", "Documento non salvato!")
//					end if
//					
//				loop
//				//provo a salvare le righe
//				if dw_4.triggerevent("ue_update")<>1 then
//					messagebox("Errore!", "Righe non salvate!")
//				end if
//			next
//		else
//			messagebox("Errore!", "Manca il registro!")
//		end if	
//	end if
//else
//	messagebox("Errore!", "Occorre scegliere un profilo!")
//end if
//
end event

type st_2 from statictext within w_crea_bollettine_cx
integer x = 1668
integer y = 13
integer width = 728
integer height = 173
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleziona un ordine dalla finestra qui sotto, poi clicca su ~"Crea Bollettine~""
boolean focusrectangle = false
end type

type dw_6 from udw_base within w_crea_bollettine_cx
integer x = 2472
integer y = 195
integer width = 1331
integer height = 925
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_bollettine_create_ext"
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

type cb_3 from commandbutton within w_crea_bollettine_cx
integer x = 3328
integer y = 1136
integer width = 461
integer height = 99
integer taborder = 110
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
dw_6.Modify("DataWindow.Print.DocumentName='"+ls_titolo+"'")
dw_6.print()
end event

type cb_4 from commandbutton within w_crea_bollettine_cx
integer x = 2893
integer y = 1136
integer width = 410
integer height = 99
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pulisci Stampa"
end type

event clicked;dw_6.reset()
end event

type cbx_1 from checkbox within w_crea_bollettine_cx
integer x = 2447
integer y = 115
integer width = 805
integer height = 77
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vedi anche ordini passati"
end type

event clicked;if checked then
	dw_1.setfilter("")
	dw_1.filter()
	dw_1.sort()
else
	dw_1.setfilter("Stampato<> 'S'")
	dw_1.filter()
	dw_1.sort()
end if
end event

type cb_stampa from commandbutton within w_crea_bollettine_cx
integer x = 2889
integer y = 1789
integer width = 417
integer height = 99
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
long ll_job, ll_id_conf_oggetti, ll_row, ll_id_documento,ll_id_prof
datastore ds_stampa
string ls_nome_report_precedente, ls_nome_report, ls_path_libreria, dwsyntax
string ls_cod_profilo,ls_num_doc, ls_ret, ls_dir, ls_num_prog
string ls_stato, ls_fornitore, ls_progressivo, ls_check, ls_codice, ls_codice_ok
long ll_codice
integer i , ll_len, li_pos, li_width, li_height, li_larg_ok
string ls_path, ls_foto
boolean lb_exist
decimal ldc_rapporto

ll_job=printopen()
ds_stampa=create datastore
ll_id_conf_oggetti=0
open(w_attesa)

for ll_row=1 to dw_6.rowcount()
	ll_id_documento=dw_6.getitemnumber(ll_row,"id_documento")
	ls_nome_report="d_ordgen_ff"
	select id_conf_oggetti, libreria
	into :ll_id_conf_oggetti, :ls_path_libreria
	from conf_oggetti
	where codice=:ls_nome_report;
	if ll_id_conf_oggetti>0 then
		if ls_nome_report_precedente<>ls_nome_report then
			dwsyntax = LibraryExport(ls_path_libreria, ls_nome_report, ExportDataWindow!)
			IF dwsyntax>"" THEN
				ds_stampa.create(dwsyntax)
				ds_stampa.settransobject(sqlca)
			else
				messagebox("Errore!", "libreria o report non trovati: "+ls_path_libreria +"-"+ls_nome_report)
				return -1
			end if
		end if
		ds_stampa.retrieve(ll_id_documento)

		
		
		//ds_stampa.Modify("DataWindow.Print.copies = "+string(li_copie))
		ls_nome_report_precedente=ls_nome_report
		ll_id_prof=dw_5.getitemnumber(1,"id_profilo")
		select codice 
		into :ls_cod_profilo
		from dba.prof_documento
		where id_prof_documento=:ll_id_prof;
		ls_num_doc=dw_6.getitemstring(ll_row,"num_doc")
		ls_num_prog=string(dw_6.getitemnumber(ll_row,"num_progressivo"))
		
		//con il numero creo il codice a barre (spero) 26-03-12
			
		if ls_num_prog > " " then
//			ll_len=len(ls_num_doc)
//			if ll_len<5 then
//				for i=ll_len to 5
//					ls_num_doc="0"+ls_num_doc
//				next
//			end if
				
			ls_stato='80'
			
			ls_fornitore="0"+string(year(today()))
			ls_progressivo=ls_num_prog
			//ls_progressivo=mid(ls_num_doc,5, len(ls_num_doc) - 4)
			//ls_progressivo=right(mid(ls_num_doc,5, len(ls_num_doc) - 4), 5)
//			for i=1 to 5
//				ls_test=right(ls_progressivo, i)
//				ll_test=int(ls_test)
//				if ll_test>0 then
//					continue
//				else
//					exit
//				end if
//			next
//			ls_progressivo=
			
			do while len(ls_progressivo)<5 
				ls_progressivo="0"+ls_progressivo
			loop
			
			ls_codice= ls_stato+ls_fornitore+ls_progressivo
			ls_check=string(f_check_digit(ls_codice, 13))
			
			ls_codice= ls_stato+ls_fornitore+ls_progressivo+ls_check
			//ls_codice_ok=wf_crea_codice_barre(ls_codice)
			ls_codice_ok=f_crea_codice_a_barre(ls_codice)
			ds_stampa.setitem(1, "cod_barre_codice", ls_codice_ok)
		end if
		//la foto ...
		select dir_immagini
		into :ls_path
		from dba.par_sistema;
		if right(ls_path,1)<>"\" then ls_path+="\"
		ls_foto=ls_path+ds_stampa.getitemstring(1, "articolo_immagine")
		lb_exist = FileExists(ls_foto)
		if not lb_exist then ls_foto=ls_path+"no_immagine.jpg"
		p_1.picturename=ls_foto
		li_width=p_1.width
		li_height=p_1.height
		
		ldc_rapporto=li_width/li_height
		li_larg_ok=ldc_rapporto*2500
//		ds_stampa.modify('p_foto_1.filename="'+ls_foto+'"')
//		ds_stampa.modify('p_foto_1.width='+string(li_larg_ok))
//		ds_stampa.modify('p_foto_1.height='+string(li_altezza_ok))
		
		ds_stampa.modify("p_1.filename='"+ls_foto+"'")
		ds_stampa.modify("p_1.width="+string(li_larg_ok))
		ds_stampa.modify("p_1.height=2500")
		//questo purtroppo funge solo con adobe acrobat writer 4.0 ...
		ls_ret=ds_stampa.Modify("DataWindow.Print.documentName = '"+&
			 ls_dir+ls_cod_profilo+"_"+ls_num_doc+".pdf'")
			
		if ls_ret<>"" then 
			messagebox("Errore!", "Documento non stampato!")
			return -1
		end if
	else
		messagebox("Errore!", "libreria o report non trovati: "+ls_path_libreria +"-"+ls_nome_report)
		close(w_attesa)
		return -1
	end if
	printdatawindow(ll_job, ds_stampa)
next
close(w_attesa)
printclose(ll_job)


end event

type tv_1 from u_tv_distinta within w_crea_bollettine_cx
boolean visible = false
integer x = 3193
integer width = 197
integer height = 157
integer taborder = 70
boolean bringtotop = true
end type

type dw_4 from u_dw_master_main within w_crea_bollettine_cx
event type integer ue_setta_prezzo ( )
event type string ue_get_nrcolval ( integer al_column )
event type long ue_setta_un_conf ( )
event ue_setta_rif_des_agg ( )
event ue_set_arti_riga ( )
event ue_set_ucon_riga ( )
event type integer ue_set_calc_riga ( long al_row )
event ue_set_comp_riga ( )
event type integer ue_wiz_insert ( )
event ue_wiz_getfocus ( )
event type integer ue_set_calc_tot_riga ( long al_row,  decimal adc_quantita,  decimal adc_prezzo_netto,  boolean ab_calc_sconto )
event ue_set_contropartita ( )
event ue_lb_down pbm_lbuttondown
event type integer ue_rec_prezzo ( long row,  decimal qta )
event ue_post_itemchanged ( long al_riga,  string as_colonna,  string as_message )
string tag = "Righe di Documento"
boolean visible = false
integer x = 22
integer y = 1904
integer width = 2820
integer height = 883
integer taborder = 40
string dragicon = "Asterisk!"
boolean bringtotop = true
string dataobject = "d_orafo_riga_documento_ordine_260510_gd"
boolean vscrollbar = true
boolean livescroll = false
end type

event type integer ue_setta_prezzo();
long 			ll_id_un_confezione, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value,il_row
decimal 		ldc_ret_value, ldc_fat_conversione, ldc_molteplicita, ldc_quantita, ldc_fattore, ldc_totale
date 			ld_comp
string 		ls_tipo_conversione, ls_sconto

ll_row= GetRow()
il_row=dw_1.getrow()
ll_id_un_confezione= GetItemNumber(ll_row, "riga_documento_id_unita_confezione")
ll_id_listino=GetItemNumber(ll_row, "riga_documento_id_listino")
ld_comp= dw_1.GetItemDate(il_row, "data_registrazione")

ls_sconto = uf_get_colval("sconto")
//ldc_ret_value=uf_calcola_prezzo(ls_sconto, ldc_ret_value, uf_GetItemDecimal(ll_row, "quantita"))
if not IsNull(ldc_ret_value) then 
	
	SetItem(ll_row,"riga_documento_prezzo_netto",Truncate(ldc_ret_value, 0))
	ldc_quantita=uf_GetItemDecimal(ll_row, "quantita")
	if GetItemString(ll_row,"c_unita_conf_tipo_conversione") = 'D' then
		ldc_fattore=1 / uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	else
		ldc_fattore=uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	end if
	ldc_molteplicita=uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
	if IsNull(ldc_molteplicita) then ldc_molteplicita= 0
	ldc_totale= ldc_quantita * Truncate(ldc_ret_value, 0) * ldc_fattore * ldc_molteplicita
	
	SetItem(ll_row,"qta_un_base", ldc_totale)
end if

return ll_ret_value

end event

event ue_setta_rif_des_agg;
end event

event ue_set_arti_riga();//
//
//long				ll_num_colli
//decimal			ld_quantita
//
//long 				ll_id_articolo, ll_id_lingua, ll_id_linguaggio
//long				ll_id_sog_commerciale, ll_id_unita_confezione, ll_id_tab_iva, ll_row
//string			ls_tipo_iva
//
//
//ll_row=GetRow()
//POST WF_METTI_DESCRIZIONE(LL_ROW)
//ll_id_sog_commerciale = idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
//ll_id_articolo = GetItemNumber(ll_row, "riga_documento_id_articolo")
//
//ll_id_unita_confezione = long(uf_get_colval("riga_documento_id_unita_confezione"))	
//
//if (isnull(ll_id_unita_confezione) or ll_id_unita_confezione <= 0) then
//	
//	SELECT id_unita_confezione, num_colli
//	INTO 	 :ll_id_unita_confezione, :ll_num_colli  
//	FROM 	 unita_confezione  
//	WHERE  id_articolo = :ll_id_articolo
//	AND    unita_base = 'S'
//	;
//	
//	if (sqlca.sqlcode = -1) then
//		messagebox("dberror", sqlca.sqlerrtext)
//	end if	
//end if
//
//SELECT num_colli
//INTO 	 :ll_num_colli  
//FROM 	 unita_confezione  
//WHERE  id_unita_confezione = :ll_id_unita_confezione
//;
//
//if (sqlca.sqlcode = -1) then
//	messagebox("dberror", sqlca.sqlerrtext)
//end if
//
//
//if (not IsNull(ll_id_unita_confezione)) and (ll_id_unita_confezione > 0) then
//	
//
//	if (not isnull(ld_quantita) and ld_quantita > 0) then ll_num_colli=ll_num_colli*ld_quantita
//	uf_set_colval("riga_documento_num_colli", string(ll_num_colli))
//
//	
//	triggerevent("ue_set_ucon_riga")
//end if
//
//
//
//
//
//SELECT "tab_iva"."tipo_iva", "tab_iva"."id_tab_iva"
//	INTO :ls_tipo_iva, :ll_id_tab_iva
//	FROM "dba"."sog_commerciale", "dba"."tab_iva"  
//	WHERE ( "tab_iva"."id_tab_iva" = "sog_commerciale"."id_tab_iva" ) and  
//			( ( "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) ) ;
//
//if ls_tipo_iva > '' then
//	
//	uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
//else
//	
//	SELECT "articolo"."id_tab_iva"  
//		INTO :ll_id_tab_iva  
//		FROM "dba"."articolo"
//		WHERE "articolo"."id_articolo" = :ll_id_articolo ;
//
//	if (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
//		
//		SELECT "cat_com_articolo"."id_tab_iva"  
//			INTO :ll_id_tab_iva  
//			FROM "dba"."articolo",   
//			"cat_com_articolo"  
//			WHERE ( "cat_com_articolo"."id_cat_com_articolo" = "articolo"."id_cat_com_articolo" ) and  
//			( ( "articolo"."id_articolo" = :ll_id_articolo ) )   ;
//	end if
//	if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
//		uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
//	end if
//end if
//
//tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.event ue_vis_esi_disponibilita()
//wf_cal_costi()	
end event

event ue_set_ucon_riga();


long			ll_id_unita_conf, ll_num_colli
decimal		ld_molt, ld_fatconv, ld_fatglob, ld_qta_proposta, ld_qta
string		ls_tipoconv

ll_id_unita_conf = long(uf_get_colval("riga_documento_id_unita_confezione"))
ld_qta = dec(uf_get_colval("quantita"))

SELECT fat_conversione, molteplicita, tipo_conversione, num_colli
INTO	 :ld_fatconv, :ld_molt, :ls_tipoconv, :ll_num_colli
FROM	 unita_confezione
WHERE  id_unita_confezione = :ll_id_unita_conf
;

if (SQLCA.SQLCODE = 0) then
	
	

	if ( ld_qta = 0 or isnull(ld_qta) ) then
		

		
		long 		ll_id_prof_documento
		ll_id_prof_documento = dw_1.getitemnumber(dw_1.getrow(), "id_prof_documento")
		
		SELECT quantita_prop_riga
		INTO	 :ld_qta_proposta
		FROM	 prof_documento
		WHERE  id_prof_documento = :ll_id_prof_documento
		;
		
		
		if (SQLCA.SQLCODE = 0) then
			if (not isnull(ld_qta_proposta)) and (ld_qta_proposta > 0) then
				uf_set_colval("quantita",string(ld_qta_proposta))
				
				if (ll_num_colli > 0) and (not isnull(ll_num_colli)) then
					ll_num_colli = ll_num_colli * ld_qta_proposta
					uf_set_colval("riga_documento_num_colli",string(ll_num_colli))
				end if
				
			end if
		end if
	end if

	uf_set_colval("riga_documento_fat_con_unita_base",string(ld_fatconv))
	uf_set_colval("c_unita_conf_tipo_conversione", string(ls_tipoconv))
	uf_set_colval("c_unita_conf_molteplicita", string(ld_molt))
	If ls_tipoconv = "D" then
		uf_set_colval("fat_con_globale", string(ld_fatconv / ld_molt))
	else
		uf_set_colval("fat_con_globale", string(ld_fatconv * ld_molt))		
	end if

	
	long ll_row
	ll_row = getrow()
	
	
	
	if (not isnull(ld_qta_proposta)) and (ld_qta_proposta > 0) then
		
		dwobject	my_dwo
		my_dwo = this.object.quantita
		this.trigger event itemchanged(ll_row, my_dwo, string(ld_qta_proposta))		
		
	end if
	
	
	
end if




end event

event type integer ue_set_calc_riga(long al_row);//
//
//decimal		ld_QTA_UB, ld_QTA, ld_QTA_SM, ld_Prezzo_Netto, ld_Sconti, ld_Totale_Riga
//decimal		ld_Cambio, ld_Sconto_Riga, ld_QTA_Evasa_UB, ld_Qta_Evasa, lcd_null
//decimal		ld_Prezzo, ld_Quantita, ld_Totale_Riga_Lire, ld_Qta_Effettiva, ld_Totale_Riga_val
//string		ls_Sconto, ls_tipoconv, ls_tipo_arrotondamento
//decimal		ld_fatconv, ld_fatglob, ld_molt, ld_cambio_riga, ld_cambio_documento
//long			ll_row, ll_id_valuta_riga, ll_valuta_documento, ll_nr_cifre_arrot
//
//
//if al_row>0 then
//	ll_row= al_row
//	
//	SetNull(lcd_null)
//	ls_tipoconv = GetItemString(ll_row,"c_unita_conf_tipo_conversione")
//	ld_fatconv = uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
//	ld_molt =uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
//	
//	
//	ld_prezzo=getitemdecimal(al_row, "prezzo")
//	
//	
//	
//	if ls_tipoconv = "D" then
//		if ld_fatconv <> 0 then
//			ld_fatglob = 1/ld_fatconv
//		else
//			ld_fatglob = 0
//		end if
//	else
//		ld_fatglob = ld_fatconv
//	end if
//	ld_fatglob = ld_fatglob * ld_molt
//	SetItem(ll_row,"fat_con_globale",string(ld_fatglob))
//	
//	
//	
//	
//	ls_Sconto= GetItemString(ll_row, "sconto")
//	ld_QTA = uf_GetItemDecimal(ll_row, "quantita")
//	if IsNull(ld_QTA) then ld_QTA=0
//	if uf_calcola_prezzo(ls_Sconto, 1000000, 1) = 0 then
//	
//		ld_QTA_SM= 0 
//		SetItem(ll_row, "qta_sconto_merce", 0)
//	else
//		ld_QTA_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
//		if IsNull(ld_QTA_SM) then ld_QTA_SM=0
//	end if
//	
//	ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
//	SetItem(ll_row, "qta_un_base", ld_QTA_UB)
//	
//	ld_Qta_Evasa= uf_GetItemDecimal(ll_row, "qta_evasa")
//	if IsNull(ld_Qta_Evasa) then ld_Qta_Evasa=0
//	
//	ld_QTA_Evasa_UB = ld_Qta_Evasa * ld_FatGlob
//	SetItem(ll_row, "qta_evasa_un_base", ld_QTA_Evasa_UB)
//	ld_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
//	if IsNull(ld_Prezzo) then ld_prezzo = 0
//	
//	ll_valuta_documento= idw_gen.GetItemNumber(il_row, "documento_id_valuta_des")
//	ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")
//	
//	SELECT "valuta"."cifra_arrotondamento",
//		"valuta"."tipo_arrotondamento"
//		INTO :ll_nr_cifre_arrot ,
//				:ls_tipo_arrotondamento
//		FROM "dba"."valuta"  
//		WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
//	
//	if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
//	ld_cambio_riga= GetItemNumber(ll_row, "riga_documento_cambio")
//	if IsNull(ld_cambio_riga) then ld_cambio_riga=1
//	
//	ld_Prezzo_Netto= uf_calcola_prezzo(ls_Sconto, ld_Prezzo, 1)
//	
//	decimal ld_importo_sconto_riga
//	string ls_um, ls_tipo
//	long ll_id_un_conf
//	decimal ld_peso_netto
//	ld_importo_sconto_riga=getitemdecimal(ll_row, "riga_documento_sconto_riga")
//	ll_id_un_conf=getitemnumber(al_row, "riga_documento_id_unita_confezione")
//	select simbolo, tipo
//	into :ls_um, :ls_tipo
//	from unita_confezione, unita_misura
//	where (unita_confezione.id_unita_confezione=:ll_id_un_conf) 
//	and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
//	
//	ld_peso_netto=getitemdecimal(al_row, "riga_documento_peso_netto")
//	
//	
//	
//	if (ld_qta > 0 and ld_importo_sconto_riga > 0) then
//			ld_importo_sconto_riga=ld_importo_sconto_riga/ld_qta
//	end if
//	if (ld_importo_sconto_riga > 0) then
//		ld_Prezzo_Netto=ld_Prezzo_Netto - ld_importo_sconto_riga
//	end if
//			
//	
//	
//	ld_Prezzo_Netto=f_Round(ld_Prezzo_Netto ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
//	
//	if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0
//	
//	SetItem(ll_row, "riga_documento_prezzo_netto",ld_Prezzo_Netto)
//	
//	event ue_set_calc_tot_riga(ll_row, lcd_null, ld_Prezzo_Netto, FALSE)
//	
//end if
return 0
//
//
end event

event ue_set_comp_riga;
	

end event

event type integer ue_wiz_insert();//
//long ll_last_row
//SetFocus()
//SetRedraw(FALSE)
//TriggerEvent("ue_insert")
//ll_last_row= idw_riga.RowCount()
//SetRow(ll_last_row)
//SetColumn("c_articolo_cod")
//SetRedraw(TRUE)
return 0
//
end event

event ue_wiz_getfocus();//
//long ll_current_row
//
//SetFocus()
//ll_current_row= idw_riga.GetRow()
//SetRow(ll_current_row)
//SetColumn("c_articolo_cod")
//
//
//
end event

event type integer ue_set_calc_tot_riga(long al_row, decimal adc_quantita, decimal adc_prezzo_netto, boolean ab_calc_sconto);//
//long			ll_row, ll_nr_cifre_arrot, ll_id_valuta_riga, ll_valuta_documento
//string		ls_tipo_arrotondamento, ls_tipo_Arr
//decimal		ldc_sconto_riga, ldc_totale_riga, ldc_Totale_Riga_val, ldc_Prezzo, ldc_Sconto
//decimal		ldc_cambio, ldc_totale_riga_lire, adc_quantita_SM, adc_quantita_Effettiva
//long			ll_cifra_arr
//ll_row=al_row
//
//if ll_row>0 and  not isnull(ll_row) then
//	if IsNull(adc_quantita) then adc_quantita= uf_GetItemDecimal(ll_row, "quantita")
//	
//	if IsNull(adc_Prezzo_Netto) then	adc_Prezzo_Netto= uf_GetItemDecimal(ll_row, "riga_documento_prezzo_netto")
//	
//	if not IsNull(adc_Prezzo_Netto) then 
//		if IsNull(adc_quantita) then adc_quantita=0
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		
//		ll_valuta_documento= idw_gen.GetItemNumber(1, "documento_id_valuta_des")
//		ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")
//		
//		SELECT "valuta"."cifra_arrotondamento",
//			"valuta"."tipo_arrotondamento"
//			INTO :ll_nr_cifre_arrot ,
//					:ls_tipo_arrotondamento
//			FROM "dba"."valuta"  
//			WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
//		
//		if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
//		
//		ldc_cambio= GetItemNumber(ll_row, "riga_documento_cambio")
//		
//		if IsNull(ldc_cambio) then ldc_cambio=1
//		
//				
//		
//		adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
//			if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
//			adc_quantita_Effettiva= adc_quantita 
//
//		
//		long ll_id_art
//		decimal ld_peso
//		
//		ll_id_art=GetItemNumber(al_row,"riga_documento_id_unita_confezione")
//		ld_peso=GetItemDecimal(al_row,"riga_documento_peso_netto")
//		
//		ldc_Totale_Riga= wf_trova_prezzo(ll_id_art, adc_quantita_Effettiva, ld_peso, adc_Prezzo_Netto)
//		
//		
//		
//		
//		select cifra_arrotondamento, tipo_arrotondamento
//		into   :ll_cifra_arr, :ls_tipo_arr
//		from   valuta
//		where  id_valuta = :al_id_val_az;
//		
//		if (sqlca.sqlcode = -1) then messagebox("dberror", sqlca.sqlerrtext)
//		
//		
//		
//		
//		
//		
//		ldc_Totale_Riga= f_Round(ldc_Totale_Riga, ll_cifra_arr, "M")
//		
//		
//		SetItem(ll_row, "tot_riga_val_riga",ldc_Totale_Riga)
//		
//		
//		
//		
//			adc_quantita_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
//			if IsNull(adc_quantita_SM) then adc_quantita_SM=0		
//			adc_quantita_Effettiva= adc_quantita + adc_quantita_SM
//		
//		if not(IsNull(adc_quantita_Effettiva) OR adc_quantita_Effettiva=0) then SetItem(ll_row, "riga_documento_val_attribuito",ldc_Totale_Riga / adc_quantita_Effettiva)
//		
//		if IsNull(ldc_Cambio) OR ldc_Cambio=0 then ldc_Cambio=1		
//		ldc_Totale_Riga_Lire= ldc_Totale_Riga * ldc_Cambio
//		
//		
//		
//		SetItem(ll_row, "tot_riga_val_az",f_round(ldc_Totale_Riga_Lire,ll_cifra_arr, "M"))
//
//		if ll_id_valuta_riga = ll_valuta_documento then
//			SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga)
//		else
//			
//			//if IsNull(idc_cambio) then idc_cambio=0
//			//ldc_Totale_Riga_val= ldc_Totale_Riga_Lire / idc_cambio
//			ldc_Totale_Riga_val= ldc_Totale_Riga_Lire / ldc_cambio
//			
//			if IsNull(il_arrotondamento) then il_arrotondamento=0
//			
//			
//			ldc_Totale_Riga_val= f_round(ldc_Totale_Riga_val, ll_cifra_arr, "M")
//			
//			
//			
//			SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga_val)
//		end if
//	
//	else
//		adc_Prezzo_Netto=0
//		SetItem(ll_row, "tot_riga_val_riga",0)
//		SetItem(ll_row, "tot_riga_val_doc",0)
//		SetItem(ll_row, "tot_riga_val_az",0)
//	end if
//	If ab_calc_sconto then
//		ldc_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
//		If not IsNull(ldc_Prezzo) OR ldc_Prezzo <> 0 then 
//			ldc_Sconto= (ldc_Prezzo - adc_prezzo_netto) * 100 / ldc_Prezzo
//			ldc_Sconto= Round(ldc_Sconto , 2)
//			SetItem(ll_row, "sconto", String(ldc_Sconto))
//		end if
//		
//	end if
//end if
return 0
//
//
//
end event

event ue_set_contropartita();//
//
//long		ll_row, ll_id_articolo, ll_id_contropartita, ll_id_causale
//long		ll_id_sog_commerciale, ll_id_agente, LL_IDAZ
//u_setta_campi_documento u_cerca_cpt
//u_cerca_cpt=create u_setta_campi_documento
//ll_id_sog_commerciale= idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
//ll_id_agente=  idw_gen.GetItemNumber(il_row, "id_gruppo_agenti")
//ll_row= GetRow()
//ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
//ll_id_causale=GetItemNumber(ll_row, "riga_documento_id_caus_magazzino")
//
//ll_id_contropartita= wf_calcola_cpt(ll_id_sog_commerciale, ll_id_agente, ll_id_articolo, ll_id_causale)
//
//
//
//SetItem(ll_row, "riga_documento_id_conto", ll_id_contropartita)
//
end event

event ue_lb_down;//
//long			ll_row, ll_pos
//string		ls_dati, ls_riga
//
//If ib_rinumera_righe then
//	ll_row = 0
//	ls_dati = this.GetObjectAtPointer()
//	ll_pos = pos(ls_dati,"~t")
//	if ll_pos>0 then
//		ls_riga = mid(ls_dati,ll_pos+1)
//		il_drag_row = Long(ls_riga)
//	end if
//	if (il_drag_row > 0 ) then
//		This.ScrollToRow(il_drag_row)
//		This.Drag(begin!)
//	else
//		this.Drag(end!)
//	end if
//end if
//
end event

event type integer ue_rec_prezzo(long row, decimal qta);//
//
//integer ll_return, ll_riga_corrente
//string ls_tras_mezzo
//long    ll_id_trasporto 
//
//
//ls_tras_mezzo=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemstring(1, "tras_mezzo")
//ll_id_trasporto=tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber(1, "id_tipo_trasporto_des") 
//
//ll_return = f_rec_prezzo(row, qta, tab_1.tabpage_1.dw_documento_ordine_ff, this, ls_tras_mezzo, ll_id_trasporto)
//
//if (ll_return = 1) then
//	ll_riga_corrente = getrow()
//	post event ue_set_calc_riga(ll_riga_corrente)
//end if
//
return 1
end event

event ue_post_itemchanged;
if as_message >"" then
	messagebox("Attenzione!", as_message)
end if
setitem(al_riga, as_colonna, 0)
setcolumn(as_colonna)
end event

event clicked;string ls1_nomedwo, ls1_column, ls1_tipodwo, ls_riga_descrittiva, ls_art
long ll_id_art, ll_id_cat_codifica
ls1_nomedwo = dwo.name
ls1_tipodwo = dwo.type
if ((ls1_tipodwo="bitmap") and (right(ls1_nomedwo,3)="_sw")) then
	ls1_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 3)
	if ls1_column="c_articolo_cod" or ls1_column="riga_documento_descrizione" then
		
			ls_riga_descrittiva=getitemstring(getrow(), "riga_documento_descrizione")
			ll_id_art=this.getitemnumber(getrow(),"riga_documento_id_articolo")
			if ls_riga_descrittiva>"" and not (isnull(ls_riga_descrittiva)) and  isnull(ll_id_art) then
				messagebox("Attenzione!", "Impossibile inserire un articolo in una riga descrittiva.~r~n"+&
				"Cancellare la riga e inserirne una nuova")
				return 
			end if	
		
	end if
end if

call super::clicked

if dwo.name="distinta" then
	s_list_main ls_list_distinta
	long ll_id_dis,ll_art
	ll_art=this.getitemnumber(row,"riga_documento_id_articolo")
	select id_distinta
	into :ll_id_dis
	from distinta
	where id_articolo=:ll_art;
	if sqlca.sqlcode=0 then
		ls_list_distinta.s_modo = modo_modifica
		ls_list_distinta.s_SQL_ident[1] = "distinta.id_distinta"
		ls_list_distinta.s_identifica[1]="id_distinta"
		ls_list_distinta.l_identifica[1]=ll_id_dis
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
	else 
		ls_list_distinta.s_identifica[1]="id_articolo"
		ls_list_distinta.l_identifica[1]=ll_art
		OpenSheetWithParm( w_distinta_base_cx, ls_list_distinta,w_app_frame, 2, Original!)
		setfocus(w_distinta_base_cx)
	end if
end if



	
end event

event constructor;call super::constructor;

this.Object.c_riga_valida.width = 0
this.Object.c_evasione.width = 0
If FileExists ("Arr1.cur") then this.Object.DataWindow.Pointer="Arr1.cur"




end event

event dberror;
choose case sqldbcode
	case -196
		messagebox("Salvataggio fallito!", "Si sta tentando di inserire una riga documento~r~n"&
		+"con numero riga già esistente")
		return 1
	case -99999
		messagebox("Salvataggio fallito!", "Per movimentare un articolo occorre~r~n"&
		+"inserire la quantità o il peso (Legato).")
		return 1
	case else
		call super::dberror
end choose

end event

event doubleclicked;

//if string(dwo.name) ="c_articolo_cod" and cbx_cod_barre.checked then
//	return
//	
//
//else
	call Super::doubleClicked
//end if



end event

event dragdrop;call super::dragdrop;
long		ll_drag_num_riga, ll_drop_num_riga

//If ib_rinumera_righe then
//	If not(IsNull(il_drag_row) OR IsNull(row) OR il_drag_row <=0  OR row<=0 OR il_drag_row=row) then
//		this.SetRedraw(FALSE)
//		ll_drag_num_riga=GetItemNumber(il_drag_row,"riga_documento_num_riga")
//		ll_drop_num_riga=GetItemNumber(row,"riga_documento_num_riga")
//		SetItem(il_drag_row,"riga_documento_num_riga", ll_drop_num_riga)
//		SetItem(row,"riga_documento_num_riga", ll_drag_num_riga)
//		SetSort("riga_documento_num_riga A") 
//		Sort()
//	end if
//end if
//this.Drag(end!)
//If not (IsNull(row) Or row=0) then ScrollToRow(row)
//this.SetRedraw(TRUE)
end event

event editchanged;
end event

event getfocus;call super::getfocus;


end event

event itemchanged;//decimal 		ldc_prezzo, ldc_parte,ldc_tot_riga, ldc_ret_value, ldc_quantita, ldc_totale, ldc_fattore
//decimal 		ldc_molteplicita
//string 		ls_sconto, ls_parte, ls_descrizione
//long 			ll_row, ll_pos, ll_ret_value, ll_id, ll_tab_iva, ll_id_magazzino, ll_id_locazione
//boolean 		lb_non_calcolabile
//string 		ls_tot_riga
//string		ls_tb, ls_cp, ls_vr, ls_tr, ls_riga_descrittiva, ls_tipo, ls_art
//string		ls_dbc[], ls_dbv[], ls_dwc[], ls_message
//integer		li_ok
//decimal		ldc_null, ld_sc_unit_riga, ld_sc_riga, ld_qta_min, ld_qta_max 
//dwItemStatus	ldw_status
//long  		ll_id_unita_conf,ll_confezione,ll_id_art,ll_righe_old,ll_righe_new,i, ll_lotto_trovato
//decimal 		ld_qta, ld_qta_lotto, ld_qta_iniz, ld_qta_eff, ldt_qta_scar_attuale
//string ls_gruppo, ls_gruppo_2, ls_cod_lotto
//integer li_ret
//decimal d_azzera[]
//long l_azzera[], LL_NUMERO
//date ldt_scadenza
//
//decimal ld_tara
//decimal ld_peso_netto, ld_peso_lordo
//string  ls_codice_azienda
//
//long 	ll_id_gruppo_agenti, ll_id_gruppo_agenti_2, ll_id_documento
//date	ldt_data_reg
//s_con_provvigione ls_con_provvigione			
//
//
////idt_qta_scar_attuale[]=d_azzera[]
////idt_qta_lotti[]=d_azzera[] 
////il_id_lotti[]=l_azzera[]
////
//
////if is_prof_dispo='C' or is_prof_dispo='B' then
////	decimal ld_tot_precedente
////	if (dwo.name='quantita' and this.getitemstring(row,'tipo_um')<>'P') or (dwo.name='riga_documento_peso_netto' and this.getitemstring(row,'tipo_um')='P') then
////   if dwo.name='quantita' then
////		ld_tot_precedente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,'quantita') 	
////	else
////		ld_tot_precedente=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(row,'riga_documento_peso_netto')
////	end if	
////	if uf_blocca_dispo(ld_tot_precedente,data,row)=2 then 
////		post uf_setta_precedente(row,ld_tot_precedente,dwo.name)
////		return 2
////	end if	
////	end if
////end if	
////
//dwobject ldwo_pippo
//
//ll_row= GetRow()
//If ll_row=0 OR IsNull(ll_row) then ll_row= row
//SetNull(ldc_null)
////if IsValid(ids_lotti) and this.dataobject<>"d_riga_documento_ordine_ritorno_gd" then
////	CHOOSE CASE dwo.name
////	CASE "c_articolo_cod"
////		select id_articolo
////		into :ll_id
////		from articolo
////		where codice=:data;
////		if isnull(ll_id) then return 1
////		
////		wf_carico_lotti(row, ll_id)
////	CASE "riga_documento_descrizione"
////		
////		setnull(ll_id)
////		wf_carico_lotti(row,ll_id )
////	CASE "cod_lotto"
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"cod_esterno", data)
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if
////	CASE "data_scadenza"
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"data_scadenza",date(data))
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if
////	CASE "quantita"
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"qta_iniziale",dec(data))
////			
////			ll_id_unita_conf = this.getitemnumber(row,"riga_documento_id_unita_confezione")
////			SELECT peso_netto
////			INTO	 :ld_peso_netto
////			FROM	 unita_confezione
////			WHERE  id_unita_confezione = :ll_id_unita_conf
////			;
////			
////			if (ld_peso_netto > 0) and (not isnull(ld_peso_netto)) then
////				ld_peso_netto = ld_peso_netto * dec(data)
////				ids_lotti.SetItem(i,"peso_netto_iniziale",ld_peso_netto)				
////			end if
////			
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if
////	CASE "riga_documento_peso_netto"
////		
////		ll_row=getitemnumber(row,"id_riga_lotto")
////		i= ids_lotti.find("numero = "+string(ll_row),1, ids_lotti.rowcount())
////		if i>0 then	
////			ids_lotti.SetItem(i,"peso_netto_iniziale",dec(data))
////		else
////			messagebox("Errore","Lotto non trovato")
////		end if		
////		
////		
////	END CHOOSE
////end if 
//long ll_id_articolo, ll_id_cat_fiscale2
//
//ll_id_articolo=getitemnumber(row, "riga_documento_id_articolo")
//
//			 
//char lc_tipo_ges_lotti
//string ls_tipo_mov
//
//SELECT a.id_cat_fiscale, m.tipo
//INTO   :ll_id_cat_fiscale2, :ls_tipo_mov
//FROM   articolo a, unita_confezione u, unita_misura m
//WHERE  a.id_articolo=:ll_id_articolo
//AND	 u.id_articolo = a.id_articolo
//AND	 u.unita_base = 'S'
//AND	 m.id_unita_misura =* u.id_unita_misura
//;
//
//SELECT tipo_ges_lotti
//INTO	 :lc_tipo_ges_lotti
//FROM	 pers_par_sistema
//;
//
////if (lc_tipo_ges_lotti = 'G' and ls_tipo_mov = 'P') then
////	if dwo.name="riga_documento_peso_netto" and isvalid(ids_scar_lotto) and (not(isnull(ll_id_cat_fiscale2))) then
////		wf_scarico_lotti(ll_id_articolo, dec(data), row)
////	end if		
////else
////	
////	if dwo.name="quantita" and isvalid(ids_scar_lotto) and (not(isnull(ll_id_cat_fiscale2))) then
////		wf_scarico_lotti(ll_id_articolo, dec(data), row)
////	end if	
////end if
//CHOOSE CASE dwo.name
//	CASE "c_articolo_cod", "riga_documento_descrizione"
//			
//	
//		IF DWO.NAME="c_articolo_cod" THEN
////			If (cbx_cod_barre.Checked) = TRUE then
////			
////				String ls_cod_articolo
////			
////				
////				long   ll_id_unita_confezione 
////				SELECT a.codice, c.id_unita_confezione
////				INTO	 :ls_cod_articolo, :ll_id_unita_confezione
////				FROM	 cod_barre c, unita_confezione u, articolo a
////				WHERE	 c.codice = :Data
////				AND	 u.id_unita_confezione = c.id_unita_confezione
////				AND	 a.id_articolo = u.id_articolo;
////				choose case SQLCA.SQLCODE
////					case -1
////						messagebox("", SQLCA.SQLERRTEXT)
////					case 100
////						messagebox("", "Il codice a barre acquisito non è stato codificato ")
////						return 2
////					case 0
////						this.Post setitem(row,"c_articolo_cod", ls_cod_articolo)
////						this.Post setitem(row,"riga_documento_id_unita_confezione", ll_id_unita_confezione)
////						data = ls_cod_articolo
////				end choose
////				
////			end if
//			
//		END IF
//		ls_riga_descrittiva=getitemstring(row, "riga_documento_descrizione")
//		ll_id_art=this.getitemnumber(row,"riga_documento_id_articolo")
//		if ls_riga_descrittiva>"" and not (isnull(ls_riga_descrittiva)) and  isnull(ll_id_art) then
//			messagebox("Attenzione!", "Impossibile inserire un articolo in una riga descrittiva.~r~n"+&
//			"Cancellare la riga e inserirne una nuova")
//			return 1
//		end if		
//	if ii_ricerca_art_fornitore=0 then
//		for i= 1 to 2
//			ls_dbc[1] = "descrizione"
//			ls_dbc[2] = "id_articolo"
//			ls_dbc[3] = "codice"
//			ls_dbc[4] = "descrizione"
//			ls_dwc[1] = "riga_documento_descrizione"
//			ls_dwc[2] = "riga_documento_id_articolo"
//			ls_dwc[3] = "c_articolo_cod"
//			ls_dwc[4] = "c_articolo_des"
//			li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",4,ls_dbc,ls_dbv,ls_dwc)
//			if li_ok>0 and i=1 then
//				ls_art=wf_varianti_set(data, row)
//				if ls_art>"" then
//					data=ls_art
//				else
//					exit
//				end if
//			else
//				exit
//			end if
//		next
//	end if	
//	ii_ricerca_art_fornitore=0	
//	
//		ll_id_art=this.getitemnumber(this.getrow(),"riga_documento_id_articolo")
//		if ll_id_art>0 then
//			li_ret=wf_controlla_utilizzabile(ll_id_art)
//			if li_ret=-1 then 
//				POST uf_set_colval("c_articolo_cod", "")	
//				data=""
//				RETURN
//			end if
//
//
//
//		end if
//		select id_unita_confezione
//		into :ll_confezione
//		from unita_confezione
//		where id_articolo=:ll_id_art
//		and unita_base='S';
//		setitem(ROW,"riga_documento_id_unita_confezione",ll_confezione)
//		wf_inf_aggiuntive(ll_confezione,ROW,ll_id_art)	
//		
//		
//		
//		
//		
//		if li_ok > 0 then
//			
//			
//			
//			
//			ldw_status = GetItemStatus( row,0,Primary! )
//			if ldw_status = New! or ldw_status = NewModified! then
//				post uf_scaglione_provvigione() 
//			end if
//			post wf_inserisci_pesi_riga(0)
//			wf_impongo_magazzino(row,row)
//			trigger event ue_set_arti_riga()	
//			trigger event ue_set_contropartita()
//			
//			if is_prof_dispo='C' or is_prof_dispo='B' then	uf_pre_blocca_dispo(row)
//			return 2 			
//		end if	
//	
//CASE "quantita"
//	ld_qta_max=getitemdecimal(row, "qta_sconto_merce")
//	if (ld_qta_max <> 0 and Not(IsNull(ld_qta_max))) and ld_qta_max>=dec(data) then
//		ls_message="La quantità inserita è inferiore o uguale~r~nalla quantità sconto merce!.~r~nInserire una quantità maggiore!"
//		post event ue_post_itemchanged(row, string(dwo.name), ls_message)
//	end if
//	WF_SE_CAMBIA_QTA(ROW, data)
//	
//	ll_confezione=this.getitemnumber(this.getrow(),"riga_documento_id_unita_confezione")	
//	if (not isnull(data) and dec(data) > 0) and (not isnull(ll_confezione)) and ll_confezione > 0 then
//		decimal {0} ld_num_colli 
//		SELECT num_colli
//		INTO	 :ld_num_colli
//		FROM	 unita_confezione
//		WHERE  id_unita_confezione = :ll_confezione
//		;
//		
//		if (SQLCA.SQLCODE = -1) then messagebox("DBError", SQLCA.SQLERRTEXT)
//		
//		if ld_num_colli > 0 then
//			ld_num_colli = ld_num_colli * dec(data)
//			setitem(row, "riga_documento_num_colli", ld_num_colli)
//		end if
//	end if
//	
//CASE "prezzo", "quantita", "riga_documento_peso_netto" 
//	
//	
//	
//	
//	
//	if (dwo.name = "riga_documento_peso_netto") then
//		SELECT 1
//		INTO   :ls_codice_azienda
//		FROM   azienda
//		WHERE  id_azienda = 1
//		AND	 UCASE(codice) = 'GIESSE'
//		;
//		
//		if (SQLCA.SQLCODE = 0) then
//			ll_row = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getrow()
//			ld_tara = tab_1.tabpage_3.dw_documento_bolla_trasp_ff.getitemnumber(ll_row, "tara")
//
//			ll_row = getrow()
//			ld_peso_lordo = dec(data)
//			ld_peso_netto = (ld_peso_lordo - ld_tara)
//			post setitem(ll_row, "riga_documento_peso_lordo", ld_peso_lordo)	
//			post setitem(ll_row, "riga_documento_peso_netto", ld_peso_netto)
//		end if
//	end if
//	
//	
//	
//	ldw_status = GetItemStatus( row,0,Primary! )
//	
//	
//	string ls_tipo_um
//	decimal ld_prezzo
//	ld_prezzo=getitemdecimal(row, "prezzo")
//	
//	
//	if (dwo.name = "riga_documento_peso_netto") then
//	
//		ls_tipo_um=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(row,"tipo_um")
//		if ls_tipo_um='P' then
//			
//			
//			if pos(upper(u_freddie.istr_database.name), 'ORAFO')>0 then
//			else 
//				post event ue_rec_prezzo(row,1)
//			end if
//		end if
//	end if
//
//	
//	if (dwo.name = "prezzo") then
//		if dec(Data) > 0 and isnull(this.getitemnumber(row, "riga_documento_id_articolo")) then
//			post event ue_set_contropartita()
//		end if
//	end if
//	
//
//CASE "sconto"
//	post event ue_set_calc_riga(row)
//	
//	
//	
//	decimal ld_null
//	setnull(ld_null)
//	this.setitem(row,"riga_documento_sconto_riga",ld_null)
//	
//END CHOOSE
//
//if (dwo.name = "sconto" or dwo.name = "quantita" &
//	 or dwo.name = "riga_documento_peso_netto") then
//	post wf_gruppo_agenti(row)
//end if
//
//
//RETURN ll_ret_value
end event

event itemfocuschanged;call super::itemfocuschanged;//is_last_field=dwo.name


end event

event losefocus;call super::losefocus;
GraphicObject 	lgo_cur_control
string			ls_class

lgo_cur_control = GetFocus( ) 
If IsValid(lgo_cur_control) then
	ls_class=lgo_cur_control.ClassName()
end if
//If ib_rinumera_righe AND not(ls_class="pb_sort") then uf_Rinumera_Righe(0)
end event

event rowfocuschanged;if AcceptText() > 0 then
//	uf_set_mask_riga()
end if 
	
end event

event updateend;//
//IF rowsinserted+rowsupdated+rowsdeleted+modifiedcount()+deletedcount()>0 THEN
//	wf_new_cal_cmc()
//
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//	
//								
//								
//								
//	
//tab_1.tabpage_2.pb_sort.enabled=true
//
//
//END IF
//
//
end event

event updatestart;//boolean lb_calcola_spese = FALSE 
//decimal ld_tot_riga_val_az, ld_tot_riga_val_az_o
//
//If ib_rinumera_righe then uf_Rinumera_Righe(0)
//
//ib_genera_castelletto= TRUE
//	SetPointer(HourGlass!)
//	tab_1.tabpage_4.dw_cast_iva_documento_lt.TriggerEvent("ue_calc_cast_iva")
//	tab_1.tabpage_5.dw_contr_documento_lt.TriggerEvent("ue_calc_contropartita")
//	uf_report_righe()
//	SetPointer(Arrow!)
//
//long  ll_righe, ll_id, ll_riga_doc, ll_id_loc2,i
//long  ll_id_doc, ll_id_caus_magazzino 
//long  ll_id_doc1 
//decimal{2} ld_qta, ld_qta_evasa
//boolean lb_ordinato_fo
//
//
//
//long ll_id_caus_mag_nmn
//
//SELECT id_caus_mag_nmn
//INTO	 :ll_id_caus_mag_nmn
//FROM	 par_sistema
//;
//
//long ll_causale,ll_loc1,ll_loc2, ll_id_articolo
//string ls_loc1,ls_loc2, ls_des
//
//for i=rowcount() to 1 step -1
//	
//	ll_id_articolo=getitemnumber(i,"riga_documento_id_articolo")
//	if isnull(ll_id_articolo) then
//			setitem(i,"riga_documento_id_caus_magazzino", ll_id_articolo)
//			setitem(i,"id_locazione_1", ll_id_articolo)
//			setitem(i,"id_locazione_2", ll_id_articolo)			
//	else
//		
//		long ll_id_cat_fiscale
//		
//		SELECT id_cat_fiscale
//		INTO	 :ll_id_cat_fiscale
//		FROM	 articolo
//		WHERE  id_articolo = :ll_id_articolo
//		;
//		
//		if (isnull(ll_id_cat_fiscale) and not isnull(ll_id_caus_mag_nmn)) then 
//			setitem(i,"riga_documento_id_caus_magazzino", ll_id_caus_mag_nmn)
//			setitem(i,"id_locazione_1", ll_id_cat_fiscale)
//			setitem(i,"id_locazione_2", ll_id_cat_fiscale)
//		end if
//		
//		
//		
//		ll_causale=this.getitemnumber(i,"riga_documento_id_caus_magazzino")
//		select mag_par_richiesto,mag_des_richiesto
//			into :ls_loc1, :ls_loc2
//			from caus_magazzino
//			where id_caus_magazzino=:ll_causale;
//			ll_loc1=this.getitemnumber(i,"id_locazione_1")
//			ll_loc2=this.getitemnumber(i,"id_locazione_2")
//		if not isnull(ll_causale ) then
//			if ls_loc1='S' and isnull(ll_loc1) then
//				messagebox("Errore","La locazione di partenza non è presente sulla riga "+string (i)+" !",stopsign!)
//				return 1
//			end if
//			if ls_loc2='S' and isnull(ll_loc2) then
//				messagebox("Errore","La locazione di destinazione non è presente sulla riga "+string (i)+" !",stopsign!)
//				return 1
//			end if
//			if ls_loc1='N' and not isnull(ll_loc1) then
//				messagebox("Informazione","E' stata impostata una locazione di partenza, su una o più righe, che non sarà utilizzata!")
//			end if	
//			if ls_loc2='N' and not isnull(ll_loc2) then
//				messagebox("Informazione","E' stata impostata una locazione di destinazione, su una o più righe, che non sarà utilizzata!")
//			end if
//		else
//			
//			ll_causale=idw_gen.getitemnumber(1, "documento_id_caus_magazzino")
//			ll_loc1=idw_gen.getitemnumber(1,"documento_id_locazione_1")
//			ll_loc2=idw_gen.getitemnumber(1,"documento_id_locazione_2")
//			setitem(i,"riga_documento_id_caus_magazzino", ll_causale)
//			setitem(i,"id_locazione_1", ll_loc1)
//			setitem(i,"id_locazione_2", ll_loc2)	
//		end if
//	end if
//next
//
//
//
//long ll_id_causale
//string ls_ges_lotti
//integer li_ret
//
//ll_id_causale=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_caus_magazzino")
//ls_ges_lotti=wf_gestisci_lotti(ll_id_causale, 0)	
//if ls_ges_lotti='C' or ls_ges_lotti='S' or ls_ges_lotti='A' or ls_ges_lotti='R' then
//	if wf_controlla_lotti(ls_ges_lotti)<0 then
//		messagebox('Errore','Impossibile salvare lotti:  righe errate!')
//		return 1
//	ELSE
//		LI_RET=WF_SALVA_LOTTI(ls_ges_lotti)
//		IF LI_RET<>1 THEN 
//			messagebox('Errore','Impossibile salvare lotti: contattare assistenza!')
//			RETURN 1
//		END IF
//	end if
//end if
//
//
//string ls_des_personale, ls_des_codice, ls_des_estesa
//long ll_id_linguaggio, ll_id_sog_comm, ll_id_lingua, ll_id_linguaggio1, ll_id_lingua1
//long ll_id_riga_padre
//s_des_articolo s_des_art
//string ls_simbolo_um
//decimal{2} ld_lunghezza
//
//ll_righe=tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
//if not (tab_1.tabpage_1.dw_documento_ordine_ff.getrow()>0) then return
//ll_id_sog_comm=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_sog_commerciale")
//ll_id_linguaggio=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_linguaggio")
//ll_id_lingua=tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_lingua")
//if (isnull(ll_id_linguaggio) or ll_id_linguaggio<1) or (isnull(ll_id_lingua) or ll_id_lingua<1) then
//		select id_linguaggio, id_lingua
//		into :ll_id_linguaggio1, :ll_id_lingua1
//		from par_sistema;
//		if sqlca.sqlcode<>0 then
//			messagebox("Errore!", "Non posso salvare le descrizioni associate al soggetto~r~n"+&
//			"commerciale corrente in quanto non specificato il linguaggio nei parametri di sistema")
//			return
//	end if
//end if
//if isnull(ll_id_lingua) then ll_id_lingua=ll_id_lingua1
//if isnull(ll_id_linguaggio) then ll_id_linguaggio=ll_id_linguaggio1
//for i = 1 to ll_righe
//	ld_lunghezza=getitemdecimal(i,"riga_documento_dim_l")
//	ls_simbolo_um=getitemstring(i, "unita_misura_b_simbolo")
//	if isnull(ls_simbolo_um) then ls_simbolo_um='XX'
//	ls_des_estesa=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i,"des_articolo_des_estesa")
//	ls_des_codice=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i, "des_articolo_codice")
//	ls_des_personale=tab_1.tabpage_2.dw_riga_documento_dett_ord_ff.getitemstring(i, "des_articolo_descrizione")
//	ll_id_articolo=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "riga_documento_id_articolo")
//	//mm 210110 nell'esplosione non deve ricopiare cod cl/fo
//	ll_id_riga_padre=tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(i, "id_riga_doc_padre")
//	
//	if (ls_des_personale>'' or ls_des_codice>'' &
//	or ls_des_estesa>'') and isnull(ll_id_riga_padre) &
//	and (not (Isnull(ll_id_articolo))) then
//		
//		update des_articolo
//		set 	descrizione=:ls_des_personale,
//				des_estesa=:ls_des_estesa,
//				codice=:ls_des_codice,
//				id_lingua=:ll_id_lingua,
//				id_linguaggio=:ll_id_linguaggio
//		where id_sog_commerciale=:ll_id_sog_comm
//		and id_articolo=:ll_id_articolo
//		and id_linguaggio=:ll_id_linguaggio
//		and id_lingua=:ll_id_lingua
//		and (simbolo_um=:ls_simbolo_um and lunghezza=:ld_lunghezza)
//		;
//		if sqlca.sqlnrows<1 then
//			
//			insert into des_articolo 
//			(id_linguaggio, descrizione, des_estesa, codice, id_sog_commerciale,
//			id_articolo, id_lingua, lunghezza, simbolo_um)
//			values (:ll_id_linguaggio,:ls_des_personale,:ls_des_estesa,:ls_des_codice, :ll_id_sog_comm, &
//			:ll_id_articolo, :ll_id_lingua, 0,'XX');
//			if sqlca.sqlcode<>0 then
//				rollback;
//			else
//				commit;
//				s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
//				ll_id_lingua,ll_id_linguaggio, i)
//				SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
//			end if
//			if ls_simbolo_um<>'XX' then
//				insert into des_articolo 
//				(id_linguaggio, descrizione, des_estesa, codice, id_sog_commerciale,
//				id_articolo, id_lingua, lunghezza, simbolo_um)
//				values (:ll_id_linguaggio,:ls_des_personale,:ls_des_estesa,:ls_des_codice, :ll_id_sog_comm, &
//				:ll_id_articolo, :ll_id_lingua,  :ld_lunghezza, :ls_simbolo_um);
//				if sqlca.sqlcode<>0 then
//					rollback;
//					messagebox("Errore!", "Descrizione personale "+ls_des_codice+"  non salvata!")
//				else 
//					commit;
//					
//					s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
//					ll_id_lingua,ll_id_linguaggio, i)
//					SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
//				end if
//			end if
//		else 
//			commit;
//			s_des_art = uf_calc_des_art(ll_id_articolo,ll_id_sog_comm,&
//				ll_id_lingua,ll_id_linguaggio, i)
//			SetItem(i,"riga_documento_id_des_articolo", s_des_art.sl_id_des_articolo)
//		end if
//	end if
//	
//next
//
//if (this.DeletedCount() > 0) then lb_calcola_spese = true	
//
//if (lb_calcola_spese) then wf_calcola_spese('N')	
end event

event ue_init;call super::ue_init;
//iudw_children[1] = dw_riga_documento_dett_ord_ff
//				
//is_list.s_identifica[1] = "id_documento"
//is_list.s_win_zoom = "w_riga_documento_wz"
end event

event ue_insert;call super::ue_insert;//ii_ricerca_art_fornitore = 0
//wf_salva_automaticamente()	
end event

event ue_update;
//integer li_RetVal
//
//li_RetVal = super::EVENT ue_update(wparam, lparam)
//
//
//	
//	
//	
//
//RETURN li_RetVal 

end event

event ue_delete;//
//decimal ld_precedente, ld_datastore
//long row, ll_ret, ll_id_art_dispo
//row=this.getrow()
//if is_prof_dispo='C' or is_prof_dispo='B' then
//	if this.getitemstring(row,'tipo_um')<>'P' then
//      ld_precedente=this.getitemdecimal(row,'quantita') 	
//	else
//		ld_precedente=this.getitemdecimal(row,'riga_documento_peso_netto')
//	end if	
//	
//	ll_id_art_dispo=this.getitemnumber(row,'riga_documento_id_articolo')
//   ll_ret=ids_disponibilita.find("id_articolo=" +string(ll_id_art_dispo), 1,ids_disponibilita.RowCount())
//   if ll_ret>0 then ld_datastore=ids_disponibilita.getitemdecimal(ll_ret,'totale')
//	if ld_datastore>ld_precedente then
//		ld_datastore=ld_datastore - ld_precedente
//		ids_disponibilita.setitem(ll_ret,'totale',ld_datastore)
//	else 
//		ids_disponibilita.deleterow(ll_ret)
//	end if
//end if	
//		
//call super ::ue_delete	
end event

event ue_retrieve;call super::ue_retrieve;
long ll_altezza
//ll_altezza= idw_riga.height
long ll_delta_y

//iF POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO')<=0 THEN
//
//	ll_delta_y = 165
//	idw_riga.Modify("c_tot_righe_lire.y = " + String(	 ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe_lire_t.y = " + String( ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe.y = " + String(			 ll_altezza 	- ll_delta_y ))
//	idw_riga.Modify("c_tot_righe_t.y = " + String(		 ll_altezza 	- ll_delta_y ))
//	
//	
//	idw_riga.Modify("datawindow.summary.height = " + String (ll_altezza - 516))
//end if
//is_title = "Riga " + is_nome_tipo_documento
//SetSort("riga_documento_num_riga A") 
//Sort()
end event

event ue_modify;//
//
//s_any_array			lstr_array
//string				ls_array[], ls_sconto, ls_verifica
//long					ll_nr_column= 48, ll_count, ll_row, ll_id_u_conf
//decimal				ldc_fattore, ldc_molteplicita, ldc_totale, ldc_ret_value, ldc_quantita
//decimal{4}			ld_peso_lordo, ld_peso_netto
//string				ls_nome, ls_ric_riga
//
//long					ll_id_art_o, ll_id_loc_o
//
//
//ll_row = GetRow()
//If AcceptText() = 1 then
//	
//	ls_array[1]= uf_Get_Colval("riga_documento_id_unita_confezione")
//	ls_array[2]= uf_Get_Colval("quantita")
//	
//	ls_verifica=ls_array[2]
//	
//	ls_array[3]= uf_Get_Colval("riga_documento_data_prevista_consegna")
//	ls_array[4]= uf_Get_Colval("prezzo")
//	ls_array[5]= uf_Get_Colval("sconto")
//	ls_array[6]= uf_Get_Colval("riga_documento_prezzo_netto")
//	ls_array[7]= uf_Get_Colval("riga_documento_sconto_riga")
//	ls_array[8]= uf_Get_Colval("riga_documento_id_tab_iva")
//	ls_array[9]= uf_Get_Colval("riga_documento_forza_chius_evasione")
//	ls_array[10]= uf_Get_Colval("riga_documento_sospesa")
//	ls_array[11]= uf_Get_Colval("id_riga_doc_provenienza")
//	ls_array[12]= uf_Get_Colval("riga_documento_id_articolo")
//	ll_id_art_o = long(ls_array[12])	
//	ls_array[13]= uf_Get_Colval("qta_evasa")
//	ls_array[14]= uf_Get_Colval("id_gruppo_agenti")
//	ls_array[15]= uf_Get_Colval("provv_agente")
//	ls_array[16]= uf_Get_Colval("qta_sconto_merce")
//	ls_array[17]= uf_Get_Colval("id_locazione_1")
//	ll_id_loc_o = long(ls_array[17])	
//	ls_array[18]= uf_Get_Colval("id_locazione_2")
//	ls_array[19]= uf_Get_Colval("riga_documento_id_caus_magazzino")
//	ls_ric_riga=is_ric_riga
//	If  uf_Get_Colval("c_evasione") <> "NE" then 
//		ls_ric_riga=Replace(ls_ric_riga,1,1,"L")
//		ls_ric_riga=Replace(ls_ric_riga,13,1,"L")
//		ls_ric_riga=Replace(ls_ric_riga,14,1,"L")
//	end if
//	
//	if is_ges_locazioni = "S" then 
//		ls_ric_riga=Replace(ls_ric_riga,6,1,"M")
//		ls_ric_riga=Replace(ls_ric_riga,7,1,"M")
//	else
//		ls_ric_riga=Replace(ls_ric_riga,6,1,"L")
//		ls_ric_riga=Replace(ls_ric_riga,7,1,"L")
//	end if
//	
//	ls_array[20]= ls_ric_riga
//	ls_array[21]= uf_Get_Colval("riga_documento_id_articolo")
//	ls_array[22]= uf_Get_Colval("riga_documento_id_valuta")
//	ls_array[23]= uf_Get_Colval("riga_documento_cambio")
//	ls_array[24]= uf_Get_Colval("id_riga_documento")
//	ls_array[25]= uf_Get_Colval("provv_subage")
//	ls_array[26]= uf_Get_Colval("provv_carea")
//	ls_array[27]= uf_Get_Colval("riga_documento_id_conto")
//	
//	
//	long ll_riga_corrente
//	ll_riga_corrente=tab_1.tabpage_1.dw_documento_ordine_ff.getrow()
//	ls_array[28]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
//	(ll_riga_corrente,"documento_id_magazzino"))
//	ls_array[29]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber&
//	(ll_riga_corrente,"documento_id_magazzino_2"))
//	
//	
//	ls_array[30]= uf_Get_Colval("riga_documento_num_colli")
//	ls_array[31]= uf_Get_Colval("riga_documento_peso_netto")
//	ls_array[32]= uf_Get_Colval("riga_documento_peso_lordo")
//	
//	ls_array[33]= uf_Get_Colval("usimbolo")
//	ls_array[34]= uf_Get_Colval("udescrizione")
//	ls_array[35]= uf_Get_Colval("riga_documento_dim_l")
//	ls_array[36]= uf_Get_Colval("riga_documento_dim_h")
//	ls_array[37]= uf_Get_Colval("riga_documento_dim_p")
//	
//	ls_array[38]= uf_Get_Colval("unita_misura_b_simbolo")
//	ls_array[39]= uf_Get_Colval("unita_misura_b_descrizione")
//	ls_array[40]=string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1,"id_sog_commerciale"))
//	
//	ls_array[41]= uf_Get_Colval("provv_imp_agente")
//	ls_array[42]= uf_Get_Colval("provv_imp_subage")
//	ls_array[43]= uf_Get_Colval("provv_imp_carea")
//	
//	
//	ls_array[44]= uf_Get_Colval("riga_documento_id_gruppo_agenti_2")
//	ls_array[45]= uf_Get_Colval("riga_documento_provv_agente_2")
//	ls_array[46]= uf_Get_Colval("riga_documento_provv_subage_2")
//	ls_array[47]= uf_Get_Colval("riga_documento_provv_carea_2")
//	ls_array[48]= uf_Get_Colval("riga_documento_provv_imp_agente_2")
//	ls_array[49]= uf_Get_Colval("riga_documento_provv_imp_subage_2")
//	ls_array[50]= uf_Get_Colval("riga_documento_provv_imp_carea_2")
//	
//	
//	ls_array[51]= string(tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(ll_riga_corrente,"id_documento"))
//	
//	
//	ls_array[52]= string(tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber(ll_riga_corrente,"riga_documento_id_con_lis_articolo"))
//	
//	lstr_array.s_array = ls_array
//
//	
//	OpenWithParm(iw_support, lstr_array,"w_riga_documento_wz")
//	lstr_array= Message.PowerObjectParm
//	
//	ls_array= lstr_array.s_array
//	uf_Set_Colval("riga_documento_id_unita_confezione",ls_array[1])
//	long ll_id_unita_confezione
//	ll_id_unita_confezione=long(ls_array[1])
//	if (ll_id_unita_confezione)>0 and not isnull(ll_id_unita_confezione) then
//		string ls_tipo,ls_simbolo
//		SELECT "unita_misura"."tipo","unita_misura"."simbolo"  
//		INTO :ls_tipo,:ls_simbolo 
//		FROM "unita_confezione",   
//		  	  "unita_misura"  
//		WHERE ( "unita_confezione"."id_unita_misura" = "unita_misura"."id_unita_misura" ) and  
//            ( ( "unita_confezione"."id_unita_confezione" = :ll_id_unita_confezione ) )   ;
//		
//		uf_Set_Colval("tipo_um",ls_tipo)
//		uf_Set_Colval("simbolo_mov",ls_simbolo)		
//		
//	end if
//	uf_Set_Colval("quantita",ls_array[2])
//	
//	if ls_verifica<>ls_array[2] then
//		ll_id_u_conf=long(uf_get_colval("riga_documento_id_unita_confezione"))
//		ll_id_u_conf=wf_controlla_qta_mov(ll_id_u_conf, ls_array[2])
//		if ll_id_u_conf=0 then 
//			post event ue_post_itemchanged(getrow(), "quantita", "Non si può movimentare questa quantità!")
//		else
//			post event ue_rec_prezzo(getrow(), dec(ls_array[2]))
//		end if
//	end if
//	
//	if not (IsNull(ls_array[3]) OR  ls_array[3]="") then uf_Set_Colval("riga_documento_data_prevista_consegna",ls_array[3])
//	uf_Set_Colval("prezzo",ls_array[4])
//	uf_Set_Colval("sconto",ls_array[5])
//	
//	uf_Set_Colval("riga_documento_sconto_riga",ls_array[7])
//	uf_Set_Colval("riga_documento_id_tab_iva",ls_array[8])
//	uf_Set_Colval("riga_documento_forza_chius_evasione",ls_array[9])
//	uf_Set_Colval("riga_documento_sospesa",ls_array[10])
//	uf_Set_Colval("id_riga_doc_provenienza",ls_array[11])
//	uf_Set_Colval("qta_evasa",ls_array[13])
//	uf_Set_Colval("id_gruppo_agenti",ls_array[14])
//	uf_Set_Colval("provv_agente",ls_array[15])
//	uf_Set_Colval("qta_sconto_merce", ls_array[16])
//	uf_Set_Colval("id_locazione_1",ls_array[17])
//	uf_Set_Colval("id_locazione_2",ls_array[18])
//	uf_Set_Colval("riga_documento_id_caus_magazzino",ls_array[19])
//	uf_Set_Colval("riga_documento_id_valuta", ls_array[22])
//	uf_Set_Colval("riga_documento_cambio", ls_array[23])
//	uf_Set_Colval("provv_subage",ls_array[25])
//	uf_Set_Colval("provv_carea",ls_array[26])
//	uf_Set_Colval("riga_documento_id_conto",ls_array[27])
//	
//	ll_riga_corrente=getrow()
//	setitem(ll_riga_corrente,"riga_documento_num_colli",dec(ls_array[30]))
//	setitem(ll_riga_corrente,"riga_documento_peso_netto",dec(ls_array[31]))
//	setitem(ll_riga_corrente,"riga_documento_peso_lordo",dec(ls_array[32]))
//
//	
//	setitem(ll_riga_corrente,"riga_documento_dim_l",dec(ls_array[35]))
//	setitem(ll_riga_corrente,"riga_documento_dim_h",dec(ls_array[36]))
//	setitem(ll_riga_corrente,"riga_documento_dim_p",dec(ls_array[37]))	
//	
//	
//	
//	uf_Set_Colval("provv_imp_agente",ls_array[41])
//	uf_Set_Colval("provv_imp_subage",ls_array[42])
//	uf_Set_Colval("provv_imp_carea",ls_array[43])
//	
//	
//	
//	
//	
//	if (long(ls_array[44]) > 0) then
//		
//		uf_Set_Colval("riga_documento_id_gruppo_agenti_2",ls_array[44])
//		uf_Set_Colval("riga_documento_provv_agente_2",ls_array[45])
//		uf_Set_Colval("riga_documento_provv_subage_2",ls_array[46])
//		uf_Set_Colval("riga_documento_provv_carea_2",ls_array[47])
//		uf_Set_Colval("riga_documento_provv_imp_agente_2",ls_array[48])
//		uf_Set_Colval("riga_documento_provv_imp_subage_2",ls_array[49])
//		uf_Set_Colval("riga_documento_provv_imp_carea_2",ls_array[50])	
//		
//	end if
//	
//
//	TriggerEvent("ue_set_ucon_riga")
//	uf_set_mask_riga()
//	
//
//	
//	if (ll_id_art_o <> long(ls_array[12]) or &
//		 ll_id_loc_o <> long(ls_array[17])) then	wf_cal_costi()
//	
//	
//end if
//
end event

event ue_key;//DataWindowChild	ldw_dropdown
//DataWindowChild	ldw_drop
//string				ls_column, ls_style, ls_tipof, ls_filter, ls_colval, ls_cod, ls_des
//integer				li_cdw, li_size, li_i, li_ret
//w_search_main		lw_sm
//w_data_main			lw_win
//w_mod_single_data lw_mw
//w_p_data				lw_pwin
//u_dw_main			lu_dw
//
//long					ll_retv, ll_art, ll_id_sog
//
//integer li_row 
//li_row = getrow()					
//long ll_id_unita_confezione
//if (li_row > 0) then ll_id_unita_confezione = this.getitemnumber(li_row, "riga_documento_id_unita_confezione")
//
//ll_retv = 0
//
//
//choose case key
//	
//	case KeyF1!
//		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
//			
//			u_freddie.iw_current.Event ue_help(Topic!, long(this.object.DataWindow.Help.TypeID.Retrieve.Argument), "")
//		end if
//		
//	case KeyF5!
//		if keyflags = 0 then
//			ls_column = getColumnName()
//			uf_reply_retrieve_dddw(ls_column)
//			
//		end if	
//	
//	
//	
//	
//	case KeyF3!	
//		string ls_parigi, ls_filter2
//		long ll_id_riga_documento
//		integer i
//			
//		select parigi
//		into :ls_parigi
//		from pers_par_sistema;
//			
//		if ls_parigi = 'S' then	
//			
//			open(w_attesa)
//			ls_filter2 = "quantita > 0"
//			setfilter(ls_filter2)
//			filter()
//			update()
//			setfilter("")
//			filter()
//			
//			declare c_canc cursor for
//						
//			select id_riga_documento 
//			from riga_documento
//			where id_documento = :il_id_documento
//			and quantita = 0;
//			
//			open c_canc;
//			fetch c_canc into :ll_id_riga_documento;
//
//			DO WHILE sqlca.sqlcode = 0
//				delete from riga_documento 
//				where id_riga_documento = :ll_id_riga_documento;
//				
//				fetch c_canc into :ll_id_riga_documento;
//			LOOP
//
//	      close c_canc;		
//						
//			commit;
//			
//			idw_master.is_list.s_modo = modo_modifica
//			idw_master.is_list.s_identifica[1] = "id_documento"
//			idw_master.is_list.l_identifica[1] = il_id_documento
//			SetPointer(HourGlass!)
//			
//			this.enabled= FALSE
//			idw_master.Event ue_retrieve(0, 0)
//			uf_set_documento()
//			uf_setup_documento()
//			uf_set_istanze()
//			this.enabled= TRUE
//			uf_default_focus()
//			SetPointer(Arrow!)
//			close(w_attesa)
//		end if
//	
//		
//	case KeyF4!
//		ll_retv = 1
//		ib_during_f4 = true
//		is_ricpar = is_e_ricpar
//		ls_column = getColumnName()
//		ls_style = this.describe(ls_column+".edit.style")
//		is_ricpar.b_imm_retrieve = false
//		is_ricpar.s_caller_column = ls_column
//		is_ricpar.s_sql_cond = ""
//		is_search_window = ""
//		ls_colval = ""
//		trigger event ue_set_search (ls_column,ls_colval)
//		if (is_search_window) <> "" then
//			choose case keyflags
//				case 0	
//					
//					ls_colval = gettext()
//					
//					
//					is_ricpar.b_imm_insert = false
//					is_ricpar.s_caller_column = ls_column
//					is_ricpar.b_imm_retrieve = false
//					is_ricpar.s_sql_cond = ""
//					trigger event ue_set_search (ls_column,ls_colval)
//					if lower (ls_style) <> "dddw" then
//						
//						OpenWithParm (lw_sm,is_ricpar,is_search_window)
//						
//						
//						
//						is_ricpar = Message.PowerObjectParm
//						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
//							trigger event ue_use_search (ls_column)
//						end if
//					end if
//					
//				case 1	
//
//					
//					ls_colval = gettext()
//					
//					
//					is_ricpar.b_imm_insert = true
//					is_ricpar.s_caller_column = ls_column
//					is_ricpar.b_imm_retrieve = false
//					is_ricpar.s_sql_cond = ""
//					trigger event ue_set_search (ls_column, ls_colval)
//					if lower (ls_style) = "dddw" then
//						
//						OpenWithParm (lw_mw,is_ricpar,is_search_window)
//						this.GetChild (ls_column, ldw_dropdown)
//						ldw_dropdown.SetTransObject(SQLCA)
//						ldw_dropdown.Retrieve ()
//						li_size = upperbound(is_ricpar.s_ausil_value)
//						for li_i = 1 to li_size
//							if is_ricpar.s_ausil_value[li_i] > " " then
//								this.GetChild (is_ricpar.s_ausil_value[li_i], ldw_dropdown)
//								ldw_dropdown.SetTransObject(SQLCA)
//								ldw_dropdown.Retrieve ()
//							end if
//						next
//					else
//						
//						
//						OpenWithParm (lw_sm,is_ricpar,is_search_window)
//						is_ricpar = Message.PowerObjectParm
//						IF UpperBound(is_ricpar.s_id_seg_value) > 0 THEN
//							trigger event ue_use_search (ls_column)
//						end if
//					end if
//				case 2	
//				case 3	
//					ls_colval = gettext()
//					is_ricpar.b_imm_maint = true
//					is_ricpar.s_caller_column = ls_column
//					is_ricpar.b_imm_retrieve = false
//					is_ricpar.s_sql_cond = ""
//					trigger event ue_set_search (ls_column,ls_colval)
//					if lower (ls_style) = "dddw" then
//						
//					else
//						
//						
//						OpenWithParm (lw_sm,is_ricpar,is_search_window)
//						if not IsNull(Message.PowerObjectParm) then
//							is_ricpar = Message.PowerObjectParm
//							trigger event ue_use_search (ls_column)
//						end if
//					end if
//					is_ricpar.b_imm_maint = false
//			end choose
//		end if
//		ib_during_f4 = false
//		
//		
//		
//		ii_ricerca_art_fornitore = 0
//
//		
//		
//	case Keyadd!
//		
//		
//		if (keyFlags=2) then
//			ll_retv = 1
//			lw_win = u_freddie.iw_current
//			ls_tipof = lw_win.is_wintype
//			lu_dw = lw_win.idw_master
//			choose case ls_tipof
//				case "W_P_DATA"
//					if this = lu_dw then
//						if is_list.s_modo = modo_inserisci then 			
//							if (event ue_update (0,0) = 0) then
//								triggerevent("ue_insert")
//							end if
//							lu_dw.setFocus()
//						end if
//					else
//						triggerevent("ue_insert")
//					end if
//				case else
//					triggerevent("ue_insert")
//			end choose
//		end if
//	case KeySubtract!
//		if (keyFlags=2) then
//			cb_cancella.event trigger clicked()
//		end if
//
//	case KeyS!
//		if (keyFlags=2) then
//			ll_retv = 1
//			lw_win = u_freddie.iw_current
//			lu_dw = lw_win.idw_master
//			
//			if IsNull(lu_dw) then lu_dw = this
//			lu_dw.triggerevent("ue_update")
//		end if
//	case KeyF12!
//		if (keyFlags=0) then
//			ll_retv = 1
//			lw_win = u_freddie.iw_current
//			lu_dw = lw_win.idw_master
//			
//			if IsNull(lu_dw) then lu_dw = this
//			lu_dw.triggerevent("ue_update")
//		end if
//		
//		
//		if (keyflags=3) then
//			lw_win = u_freddie.iw_current
//			lw_win.trigger event key (keyF12!,3)
//		end if
//	case KeyN!
//		if (keyFlags=2) then
//			ll_retv = 1
//				lw_win = u_freddie.iw_current
//				ls_tipof = lw_win.is_wintype
//				lu_dw = lw_win.idw_master
//				if ls_tipof = "W_P_DATA" then
//					if (lu_dw.is_list.s_modo = modo_inserisci) or (lw_win.ib_nonmodale = true) then 	
//						if (lu_dw.event ue_update (0,0) = 0) then
//							lu_dw.triggerevent("ue_insert")
//						end if
//						lu_dw.setFocus()
//					end if
//				end if
//      end if
//
//	case KeyF6!
//		lw_win = u_freddie.iw_current
//		ls_tipof = lw_win.is_wintype
//		if ls_tipof = "W_P_DATA" then
//			lw_win.ib_F6_in_dw = true
//			if (keyflags=0) then		
//				ll_retv = 0
//				li_ret = -1
//				do while li_ret<0
//					li_cdw = lw_win.ii_dwcurr
//					li_cdw++
//					if li_cdw > lw_win.ii_dwcount then li_cdw = 1
//					lw_win.ii_dwcurr = li_cdw
//					lw_pwin = lw_win
//					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
//				loop
//			end if
//			if (keyFlags=1) then		
//				ll_retv = 0
//				li_ret = -1
//				do while li_ret<0
//					li_cdw = lw_win.ii_dwcurr
//					li_cdw --
//					if li_cdw < 1 then li_cdw = lw_win.ii_dwcount
//					lw_win.ii_dwcurr = li_cdw
//					lw_pwin = lw_win
//					li_ret = lw_pwin.uf_dwsetfocus(lw_pwin.idw_tree[li_cdw])
//				loop
//			end if
//		end if
//	case keydelete!		
//		ls_column = getColumnName()
//		ls_style = this.describe(ls_column+".edit.style")
//		if ls_style = "ddlb" then
//			uf_set_colval(ls_column,u_freddie.gs_null)
//			ll_retv = 1
//		end if
//end choose
//
//
//
//CHOOSE CASE key
//		
//   
//	CASE KeyI!
//		CHOOSE CASE keyflags
//			CASE 2
//				
//				
//				long li_num_prec, li_num_prec2
//				long ll_nr_row, ll_row
//				
//			
//				ll_nr_row = RowCount()
//				FOR ll_row=1 to ll_nr_row
//				   SetItem(ll_row, "riga_documento_num_riga", ll_row * 1000)
//         	NEXT
//
//				li_ret=update()
//				if li_ret<>1 then
//					messagebox("Errore!" , "Salvataggio righe non riuscito!")
//					return 
//				end if
//
//  				if (li_row - 1) >= 1 then
//					li_num_prec=this.getitemnumber((li_row ), "riga_documento_num_riga") - 1
//				else 
//					li_num_prec = 999
//				end if								
//				
//				trigger event ue_insert(0,0)
//				
//				this.setitem(this.rowcount(), "riga_documento_num_riga", li_num_prec)	
//				
//				li_ret=this.SetSort("riga_documento_num_riga A") 		
//				li_ret=this.Sort()												
//				
//				ll_nr_row= RowCount()
//				FOR ll_row= ll_nr_row to 1 step -1
//					SetItem(ll_row, "riga_documento_num_riga", ll_row)
//				NEXT	
//				
//				li_ret=update()
//				if li_ret<>1 then
//					messagebox("Errore!" , "Salvataggio righe non riuscito! #2")
//					return 
//				end if				
//				scrolltorow(li_row)
//		END CHOOSE	
//	
//	
//				
//	CASE KeyF!
//		CHOOSE CASE keyflags
//			CASE 2
//					ii_ricerca_art_fornitore = 1				
//   			   this.accepttext()
//				   ll_row=this.getrow()
//				   ls_cod=trim(this.getitemstring(ll_row,'c_articolo_cod'))
//					ll_id_sog=idw_gen.getitemnumber(1, "id_sog_commerciale")
//					select id_articolo 
//					into :ll_Art
//					from des_articolo
//					where codice = :ls_cod
//					and id_sog_commerciale=:ll_id_sog
//					and simbolo_um='XX'
//					;
//					if sqlca.sqlcode=0 then
//						string ls_stato
//						select  codice, descrizione, stato
//						into :ls_cod, :ls_des, :ls_stato 
//						from articolo 
//						where id_articolo = :ll_art;
//						
//						this.setitem(ll_row,'c_articolo_cod', ls_cod)
//						this.setitem(ll_row,'riga_documento_id_articolo', ll_art)
//						this.setitem(ll_row,'riga_documento_descrizione', ls_des)
//						
//						
//						long ll_id_uc, ll_id_um
//						select id_unita_confezione, id_unita_misura
//						into :ll_id_uc, :ll_id_um
//						from unita_confezione
//						where id_articolo = :ll_art
//						and	unita_base = 'S';		
//						
//						this.setitem(ll_row,'riga_documento_id_unita_confezione', ll_id_uc)						
//						
//						
//						
//						ii_ricerca_art_fornitore = 1	
//						post wf_inserisci_pesi_riga(0)
//						trigger event ue_set_arti_riga()	
//						
//						s_lung_peso s_lung
//						long ll_id_prof_documento
//						string ls_test
//						ll_id_prof_documento=idw_gen.getitemnumber(1, "id_prof_documento")
//						select prop_lunghezza
//						into :ls_test
//						from prof_documento
//						where id_prof_documento=:ll_id_prof_documento;
//						if ls_test='S' then
//							s_lung.id_sog_commerciale=ll_id_sog	
//							s_lung.cod_articolo=ls_cod
//							openwithparm(w_ric_lung_peso_gd, s_lung)
//							s_lung=message.powerobjectparm
//						end if
//						if isvalid(s_lung)  then
//							if s_lung.cod_articolo>"" then
//								post setitem(ll_row, "riga_documento_dim_l", s_lung.lunghezza)
//							end if
//						end if
//						
//						
//						
//						ii_ricerca_art_fornitore = 0
//						
//						return 
//					else	
//						ii_ricerca_art_fornitore = 1	
//						trigger event ue_key(KeyF4!, 0)
//					end if	
//			END CHOOSE		
//		
//			
//	
//	CASE KeyG!
//		CHOOSE CASE keyflags
//			CASE 2
//				decimal ld_peso_netto 
//				char lc_tipo_ges_lotti
//				
//				SELECT tipo_ges_lotti
//				INTO	 :lc_tipo_ges_lotti
//				FROM	 pers_par_sistema
//				;
//				
//				
//				string		ls_tipo_mov
//				decimal{4}  ld_quantita
//				
//				SELECT m.tipo
//				INTO	 :ls_tipo_mov
//				FROM	 unita_confezione u, unita_misura m
//				WHERE  u.id_unita_confezione = :ll_id_unita_confezione
//				AND	 m.id_unita_misura = u.id_unita_misura
//				;
//				
//				
//				if (lc_tipo_ges_lotti = 'G' and 	(tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject = 'd_riga_documento_ordine_lotti_gd') ) then
//					
//		
//					DWObject my_dwo
//					
//					if (ls_tipo_mov = 'P') then
//						my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.riga_documento_peso_netto
//						ld_peso_netto = getitemnumber(li_row,"riga_documento_peso_netto")
//						trigger event itemchanged(li_row, my_dwo, string(ld_peso_netto))
//					else
//						
//						my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.quantita
//						ld_quantita = getitemnumber(li_row,"quantita")
//						trigger event itemchanged(li_row, my_dwo, string(ld_quantita))						
//						
//					end if
//				end if
//		END CHOOSE
//	
//	
//	
//	CASE KeyW!
//		CHOOSE CASE keyflags
//			CASE 2	
//
//			string ls_cod_barre
//			integer li_len		
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.accepttext()				
//			ls_cod_barre = getitemstring(li_row,"c_articolo_cod")
//			my_dwo = tab_1.tabpage_2.dw_riga_documento_ordine_gd.object.c_articolo_cod
//			trigger event itemchanged(li_row, my_dwo, ls_cod_barre)
//			tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetColumn("quantita")	
//		END CHOOSE
//	
//	
//	
//	CASE KeyP!
//		CHOOSE CASE keyflags
//			CASE 2
//				long ll_id_locazione_1
//				date ldt_data_registrazione
//				ll_id_locazione_1 = this.getitemnumber(li_row, "id_locazione_1")
//				ldt_data_registrazione = tab_1.tabpage_1.dw_documento_ordine_ff.getitemdate(1, "data_registrazione")
//				s_list_main my_st
//				my_st.s_modo=modo_modifica
//				my_st.s_identifica[1]="id_unita_confezione"
//				my_st.l_identifica[1]=ll_id_unita_confezione
//				my_st.l_id_varie=ll_id_locazione_1
//				my_st.s_provenienza=string(ldt_data_registrazione)
//				
//				openwithparm(w_mod_prz_cx, my_st)
//				
//		END CHOOSE
//	
//	
//	
//	
//	boolean 	lb_new=FALSE
//	boolean 	lb_last=FALSE
//	long 		ll_last_row
//
//		CASE KeyTab!
//		If keyflags = 0 then
//			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
//			lb_last = (GetRow() = RowCount())
//			if is_last_field = "riga_documento_id_tab_iva" then
//					
//				
//					if lb_last then
//					
//						idw_riga.PostEvent("ue_wiz_insert")
//					else
//	
//						idw_riga.PostEvent("ue_wiz_getfocus")
//					end if
//				RETURN -1
//			end if
//		end if
//	
//	
//END CHOOSE
//	
//return ll_retv
//
//
//
//lb_new=FALSE
//CHOOSE CASE key
//	CASE KeyTab!
//		If keyflags =0 then
//			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
//			if is_last_field = "riga_documento_id_tab_iva" AND lb_new then
//				idw_riga_tot.PostEvent("GetFocus")
//				idw_riga_tot.SetColumn("descrizione")
//				RETURN 1
//			end if
//		end if
//END CHOOSE	
//
end event

event ue_validate_row;call super::ue_validate_row;//
//long 		ll_id_tab_iva, ll_prezzo
integer	li_err_count
//decimal	ld_QTA, ld_QTA_SM, ld_QTA_UB, ld_Fatglob, ld_qta_evasa, ld_qta_evasa_un_base
//
//ld_QTA = uf_GetItemDecimal(al_row, "quantita")
//if IsNull(ld_QTA) then ld_QTA=0
//ld_QTA_SM = uf_GetItemDecimal(al_row, "qta_sconto_merce")
//if IsNull(ld_QTA_SM) then ld_QTA_SM=0
//ld_Fatglob=uf_GetItemDecimal(al_row,"fat_con_globale")
//if IsNull(ld_Fatglob) then ld_Fatglob=0
//ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
//SetItem(al_row, "qta_un_base", ld_QTA_UB)
//
//ld_qta_evasa = uf_GetItemDecimal(al_row, "qta_evasa")
//if isNull(ld_qta_evasa) then ld_qta_evasa = 0
//ld_qta_evasa_un_base = ld_qta_evasa * ld_fatGlob
//SetItem(al_row, "qta_evasa_un_base", ld_qta_evasa_un_base )
//
//
//li_err_count=0
//ll_id_tab_iva= GetItemNumber(al_row, "riga_documento_id_tab_iva")
//ll_prezzo= GetItemNumber(al_row, "prezzo")
//if not(IsNull(ll_prezzo) OR ll_prezzo =0) AND (IsNull(ll_id_tab_iva) OR ll_id_tab_iva =0) then
//	as_error_text= "Esistono righe non descrittive senza IVA. "
//	li_err_count=1
//end if
//If li_err_count > 0 then iuo_msg_log.uf_new_text(as_error_text, 3)
return li_err_count
//
end event

event ue_initial;call super::ue_initial;//date 				ld_data_prev_consegna
//
//long				ll_id_magazzino, ll_row, ll_numero, ll_id_valuta, ll_righe, ll_count, ll_nriga
//long				ll_id_listino, ll_id_caus_magazzino, ll_id_locazione, ll_id_agente, ll_test
//long il_row
//
//ll_row=rowcount()
//
//il_row=dw_1.getrow()
//
//ld_data_prev_consegna = dw_1.GetItemDate(il_row,"data_prev_consegna")
//SetItem(ll_row, "riga_documento_data_prevista_consegna", ld_data_prev_consegna)
//
//ll_nriga = GetItemNumber(1, "c_max_num")
//if isnull(ll_nriga) then ll_nriga = 0
//SetItem(ll_row, "riga_documento_num_riga", ll_nriga+1)
//
//
//ll_id_valuta=dw_1.GetItemNumber(il_row, "documento_id_valuta_des")
//
//
//SetItem(ll_row,"riga_documento_id_valuta",  ll_id_valuta)
//
//SetItem(ll_row,"riga_documento_cambio",  1)
//
//
//ll_id_caus_magazzino = dw_1.GetItemNumber(il_row, "documento_id_caus_magazzino")
//SetItem(ll_row, "riga_documento_id_caus_magazzino",ll_id_caus_magazzino)
//
//
//
//long ll_locazione, ll_locazione2
//ll_locazione=dw_1.GetItemNumber(il_row, "documento_id_locazione_1")
//
//SetItem(ll_row, "id_locazione_1",ll_locazione)
//
//ll_locazione2=dw_1.GetItemNumber(il_row, "documento_id_locazione_2")
//SetItem(ll_row, "id_locazione_2",ll_locazione2)
//
//
//ll_id_agente = dw_1.GetItemNumber(il_row, "id_gruppo_agenti")
//SetItem(ll_row, "id_gruppo_agenti",ll_id_agente)
////mm per silver dreams uso per galvanica
////ll_id_agente = dw_1.GetItemNumber(il_row, "id_gruppo_agenti_2")
////SetItem(ll_row, "riga_documento_id_gruppo_agenti_2",ll_id_agente)
////uf_set_mask_riga()
//
//
//long ll_id_r_lotto, ll_riga, ll_id_doc
//string ls_flag_comm
////if isValid(ids_lotti) or isValid(ids_scar_lotto) then
////	select prog_materie_prime
////	into :ll_id_r_lotto
////	from prog_lotti;
////	if ll_id_r_lotto<1 then 
////		messagebox("Errore", "Riferimento per gestione lotti non creato!")
////		deleterow(ll_row)
////		return
////	else
////		ll_id_r_lotto++
////		update prog_lotti
////		set prog_materie_prime = :ll_id_r_lotto;
////		if sqlca.sqlnrows>0 then
////			ll_riga=tab_1.tabpage_2.dw_riga_documento_ordine_gd.RowCount()
////			tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_riga,"id_riga_lotto",ll_id_r_lotto)
////			commit;	
////		else
////			messagebox("Errore", "Riferimento per gestione lotti non creato!")
////			deleterow(ll_row)
////			return
////		end if
////	end if
////end if
////if isValid(ids_lotti) then	
////	ll_riga=ids_lotti.InsertRow(0)
////	ids_lotti.SetItem(ll_riga,"numero",ll_id_r_lotto)
////	ids_lotti.SetItem(ll_riga,"attivo",'S')
////	select commerciale
////	into :ls_flag_comm
////	from par_sistema;
////	if sqlca.sqlcode=0 then
////		if ls_flag_comm="S" then
////			ids_lotti.SetItem(ll_riga,"tipo_lotto",'Z')
////		else
////			ids_lotti.SetItem(ll_riga,"tipo_lotto",'M')
////		end if
////	else
////		messagebox("Errore", "parametro 'commerciale' non trovato in par_sistema")
////	end if
////end if
//
////wf_tipo_prezzi()
end event

event ue_set_search;call super::ue_set_search;//string ls_riga_descrittiva
//long ll_id_art
//
//
//this.Object.DataWindow.Selected.Mouse = "No"
//
//CHOOSE CASE as_nomecol
//	CASE "riga_documento_descrizione"
//		is_ricpar.s_filter_value = as_valcol 
//		
//		if (ii_ricerca_art_fornitore = 1) then
//			is_search_window = "w_des_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "des_articolo_descrizione"
//		else
//			is_search_window = "w_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "articolo_descrizione" 
//		end if
//		
//		is_ricpar.b_asneeded=TRUE
//	CASE "c_articolo_cod"
//		is_ricpar.s_filter_value = trim(as_valcol) 
//		is_ricpar.l_id_doc=idw_gen.getitemnumber(1, "id_documento")
//		
//		if (ii_ricerca_art_fornitore = 1) then
//			is_search_window = "w_des_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "des_articolo_codice"
//		else
//			is_search_window = "w_articolo_coddes_documento_sw" 
//			is_ricpar.s_filter_name = "articolo_codice" 
//		end if
//		
//		is_ricpar.b_asneeded=TRUE
//END CHOOSE
//
//
end event

event ue_use_search;//long ll_id_articolo, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value, ll_id_tab_iva
//decimal ldc_ret_value
//date ld_comp
//string ls_simbolo
//dwItemStatus	ldw_status
//string ls_utilizzabile
//decimal{4} ld_peso_lordo, ld_peso_netto
//long row, ll_id, ll_id_uc
//integer li_riga_fine, li_riga_inizio, i, li_ret
//string ls_um
//long ll_soggetto
//
//
//ll_row= GetRow()
//
//long	ll_id_art_o
//ll_id_art_o = this.getitemnumber(ll_row, "riga_documento_id_articolo")
//if isnull(ll_id_art_o) then ll_id_art_o = 0
//
//this.Object.DataWindow.Selected.Mouse = "Yes"
//
//CHOOSE CASE as_nomecol
//	CASE "c_articolo_cod"
//		
//		
//		
//		
//		
//		
//		
//			ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
//			LI_RET=wf_controlla_utilizzabile(ll_id_articolo)
//			IF LI_RET=-1 THEN
//				RETURN
//			END IF
//		
//		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
//		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
//		uf_set_colval("riga_documento_descrizione", is_ricpar.s_ausil_value[1])
//		uf_set_colval("c_articolo_des", is_ricpar.s_ausil_value[1])
//		
//		uf_set_colval("articolo_stato", is_ricpar.s_ausil_value[2])
//		
//		
//		uf_set_colval("usimbolo", is_ricpar.s_ausil_value[3])
//		uf_set_colval("udescrizione", is_ricpar.s_ausil_value[4])
//		uf_set_colval("unita_misura_b_simbolo", is_ricpar.s_ausil_value[5])
//		uf_set_colval("unita_misura_b_descrizione", is_ricpar.s_ausil_value[6])
//		uf_set_colval("conversione_peso_comune", is_ricpar.s_ausil_value[7])
//		uf_set_colval("conversione_volume_comune", is_ricpar.s_ausil_value[8])
//		uf_set_colval("riga_documento_id_unita_confezione", is_ricpar.s_ausil_value[9])
//		
//		
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then event ue_set_arti_riga()
//		
//		post event ue_set_contropartita()
//		post event ue_set_calc_riga(ll_row)
//		ldw_status = GetItemStatus( ll_row,0,Primary! )
//		if ldw_status = New! or ldw_status = NewModified! then
//			post uf_scaglione_provvigione() 
//		end if	
//		
//		post	wf_inserisci_pesi_riga(0)
//		
//		li_riga_inizio=ll_row
//		li_riga_fine=ll_row
//		wf_impongo_magazzino(li_riga_inizio, li_riga_fine)
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then post wf_cal_costi()
//		
//		
//		
//		ll_id_uc=long(is_ricpar.s_ausil_value[9])
//		select tipo,simbolo
//		into :ls_um,:ls_simbolo
//		from unita_confezione, unita_misura
//		
//		where (unita_confezione.id_unita_confezione=:ll_id_uc) and
//		(unita_misura.id_unita_misura=unita_confezione.id_unita_misura);
//		
//		uf_set_colval("tipo_um", ls_um)	
//		if POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO')>0 THEN 
//			uf_set_colval("simbolo_mov", ls_simbolo)		
//		end if
//		
//		
//		
//		
//		
//		
//		
//		
//
//		
//		if is_prof_dispo='C' or is_prof_dispo='B' then post uf_pre_blocca_dispo(this.getrow())
//		
//
//
//	
//
//	CASE "riga_documento_descrizione"
//		ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
//		LI_RET=wf_controlla_utilizzabile(ll_id_articolo)
//		IF LI_RET=-1 THEN
//				
//				RETURN
//			END IF
//		
//		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
//		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
//		uf_set_colval("c_articolo_cod", is_ricpar.s_ausil_value[1])
//		uf_set_colval("c_articolo_des", is_ricpar.s_main_value)
//		
//		
//		uf_set_colval("articolo_stato", is_ricpar.s_ausil_value[2])
//		
//		
//		
//		uf_set_colval("usimbolo", is_ricpar.s_ausil_value[3])
//		uf_set_colval("udescrizione", is_ricpar.s_ausil_value[4])
//		uf_set_colval("unita_misura_b_simbolo", is_ricpar.s_ausil_value[5])
//		uf_set_colval("unita_misura_b_descrizione", is_ricpar.s_ausil_value[6])
//		uf_set_colval("conversione_peso_comune", is_ricpar.s_ausil_value[7])
//		uf_set_colval("conversione_volume_comune", is_ricpar.s_ausil_value[8])
//		uf_set_colval("riga_documento_id_unita_confezione", is_ricpar.s_ausil_value[9])
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then event ue_set_arti_riga()
//		
//		post event ue_set_contropartita()
//		post event ue_set_calc_riga(ll_row)
//		ldw_status = GetItemStatus( ll_row,0,Primary! )
//		if ldw_status = New! or ldw_status = NewModified! then
//			post uf_scaglione_provvigione() 
//		end if	
//		
//		post wf_inserisci_pesi_riga(0)
//		
//		li_riga_inizio=ll_row
//		li_riga_fine=ll_row
//		wf_impongo_magazzino(li_riga_inizio, li_riga_fine)
//		
//		
//		if (ll_id_art_o <> ll_id_articolo) then post wf_cal_costi()
//		
//		
//		select tipo
//		into :ls_um
//		from unita_confezione, unita_misura
//		where (unita_confezione.id_articolo=:is_ricpar.s_id_seg_value[1])and
//		(unita_misura.id_unita_misura=unita_confezione.id_unita_misura);
//		uf_set_colval("simbolo_mov", ls_um)	
//		
//		
//		
//		
//		
//		
//		
//		
//		if is_prof_dispo='C' or is_prof_dispo='B' then post uf_pre_blocca_dispo(this.getrow())
//
//		
//		
//END CHOOSE
//
//if IsValid(ids_lotti) then
//	ll_id_articolo= long(is_ricpar.s_id_seg_value[1])
//	CHOOSE CASE as_nomecol
//	CASE "c_articolo_cod"
//		row=getitemnumber(ll_row,"id_riga_lotto")
//		i= ids_lotti.find("numero = "+string(row),1, ids_lotti.rowcount())
//		if i>0 then	
//			li_ret=ids_lotti.SetItem(i,"id_articolo", ll_id_articolo)
//			if li_ret<>1 then messagebox("Errore", "Non settato id_articolo in lotto")
//		else
//			messagebox("Errore","Lotto non trovato")
//		end if
//		
//		if this.dataobject <> "d_riga_documento_ordine_ritorno_gd" then wf_carico_lotti(ll_row, ll_id_articolo)
//		
//	CASE "riga_documento_descrizione"
//		row=getitemnumber(ll_row,"id_riga_lotto")
//		i= ids_lotti.find("numero = "+string(row),1, ids_lotti.rowcount())
//		if i>0 then	
//			ids_lotti.SetItem(i,"id_articolo",ll_id_articolo)
//		else
//			messagebox("Errore","Lotto non trovato")
//		end if
//		
//		if this.dataobject <> "d_riga_documento_ordine_ritorno_gd" then wf_carico_lotti(ll_row, ll_id_articolo)
//		
//	end choose
//end if
//
end event

event ue_itemerror;call super::ue_itemerror;long ll_ret_value

SetNull(ll_ret_value)
CHOOSE CASE adwo_dwo.name
	CASE "sconto"
		MessageBox(is_title, "Ricontrollare lo sconto immesso.")
		ll_ret_value=2
END CHOOSE
return ll_ret_value
end event

type p_1 from picture within w_crea_bollettine_cx
boolean visible = false
integer x = 2655
integer y = 13
integer width = 322
integer height = 96
boolean bringtotop = true
boolean originalsize = true
boolean focusrectangle = false
end type

type dw_3 from udw_base within w_crea_bollettine_cx
boolean visible = false
integer x = 66
integer y = 1219
integer width = 3763
integer height = 429
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_doc"
boolean hscrollbar = true
end type

