forward
global type w_doc_veloce_cx from w_001
end type
type cb_ricerca from commandbutton within w_doc_veloce_cx
end type
type cb_inserisci from commandbutton within w_doc_veloce_cx
end type
type cb_salva from commandbutton within w_doc_veloce_cx
end type
type cb_cancella from commandbutton within w_doc_veloce_cx
end type
type cb_ok from commandbutton within w_doc_veloce_cx
end type
type cb_annulla from commandbutton within w_doc_veloce_cx
end type
type dw_1 from udw_base within w_doc_veloce_cx
end type
type cb_stampa from commandbutton within w_doc_veloce_cx
end type
type ole_1 from olecustomcontrol within w_doc_veloce_cx
end type
type cb_1 from commandbutton within w_doc_veloce_cx
end type
type dw_2 from udw_figlia within w_doc_veloce_cx
end type
type rb_nessun_filtro from radiobutton within w_doc_veloce_cx
end type
type rb_solo_cl from radiobutton within w_doc_veloce_cx
end type
type rb_solo_fo from radiobutton within w_doc_veloce_cx
end type
type cb_nuovo from commandbutton within w_doc_veloce_cx
end type
type dw_3 from udw_figlia within w_doc_veloce_cx
end type
type st_des_2_prezzo from statictext within w_doc_veloce_cx
end type
type st_des_3_prezzo from statictext within w_doc_veloce_cx
end type
end forward

global type w_doc_veloce_cx from w_001
integer x = 1057
integer y = 483
integer width = 3899
integer height = 2664
windowtype windowtype = main!
event ue_keystop pbm_dwnprocessenter
cb_ricerca cb_ricerca
cb_inserisci cb_inserisci
cb_salva cb_salva
cb_cancella cb_cancella
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
cb_stampa cb_stampa
ole_1 ole_1
cb_1 cb_1
dw_2 dw_2
rb_nessun_filtro rb_nessun_filtro
rb_solo_cl rb_solo_cl
rb_solo_fo rb_solo_fo
cb_nuovo cb_nuovo
dw_3 dw_3
st_des_2_prezzo st_des_2_prezzo
st_des_3_prezzo st_des_3_prezzo
end type
global w_doc_veloce_cx w_doc_veloce_cx

type variables
integer i_dw_corrente, ii_ricerca_art_fornitore, ii_finestra_ricerca
string as_metallo
datawindowchild idwc_sog, idwc_cod_sog
//long il_id_iva
end variables

forward prototypes
public function integer wf_salva_dw (datawindow adw_1, datawindow adw_2, integer as_flag)
public function integer wf_rec_prezzo (long row, decimal adc_qta, decimal idc_cambio, long al_id_val_az, long il_id_documento)
public subroutine wf_valori_default (long al_riga)
public subroutine wf_val_iniziali_riga (long al_riga)
public subroutine wf_salva_righe ()
public subroutine wf_art_aut_del_fornitore ()
public function string uf_tipo_registro (long al_id_registro)
public subroutine wf_ins_riga ()
public subroutine wf_rec_galvanica (string as_id, long al_riga)
public subroutine wf_calcola_prezzo (long row)
public subroutine wf_setta_fino_calo (long row)
public subroutine wf_nuovo ()
public function integer wf_verifica_met_profilo (long al_id_titolo)
public subroutine wf_imposta_metallo (long al_id_profilo)
public subroutine wf_controlla_doppioni (string as_num_doc)
public subroutine wf_rec_des_prezzo (long al_riga)
public subroutine wf_prezzo_galvanica (long al_row, string as_cod_art)
public subroutine wf_cerca_bol_excel (string as_numero, long al_riga_corrente)
public subroutine wf_gestisci_iva_riga (long al_row)
end prototypes

event ue_keystop;return 1
end event

public function integer wf_salva_dw (datawindow adw_1, datawindow adw_2, integer as_flag);integer li_ret

li_ret=dw_1.trigger event ue_update()

if as_flag=2 and li_ret=1 then	
	li_ret=dw_2.trigger event ue_update()
	
end if
return li_ret
	
end function

public function integer wf_rec_prezzo (long row, decimal adc_qta, decimal idc_cambio, long al_id_val_az, long il_id_documento);

string 			ls_tipo_applicazione	, ls_sconto	
STRING			LS_SQL_SCRIPT				
STRING			ls_app	, ls_app1					
long 				ll_riga_corrente
date 				ldt_data_attuale			
long				ll_id_U_C_in_esame		
long 				ll_sog_com					
decimal		ld_prezzo	, ld_cambio				
decimal{2}		ld_coef_calo
long 				ll_listino					
string			ls_percentuali				
integer			li_ret
long				ll_id_cat_com_sc			
long				ll_id_art_in_esame		
long 				ll_id_cat_com_articolo	
decimal{4}		ld_adc_qta						
long           ll_sog_com_fornitore		
long 				ll_id_produttore			
long				ll_id_listino				
string			ls_adc_qta, ls_um
long				ll_pos
long 				ll_id_registro
string   		ls_tipo_registro
string 			ls_cod_art_in_esame		
long 				ll_id_magazzino,ll_caus_magazzino
long 				ll_id_titolo, ll_tipo_prezzo , ll_id_riga_padre 
decimal        ld_var_prezzo
decimal		ld_var_calo 

decimal{4} ld_legato, ld_fino, ld_calo , ldc_cambio
long ll_id_valuta_riga,ll_nr_cifre_arrot
string ls_tipo_arrotondamento,ls_test, ls_des_2, ls_des_3, ls_des_1

setnull(ld_calo)
dw_2.setitem(row, "prezzo", ld_calo)
dw_2.setitem(row, "prezzo_manifattura", ld_calo)
//se è silverdreams ed è una riga esplosa (con id_riga-doc_padre>0 
//allora non si recupera il prezzo
select rag_soc_1
into :ls_test
from azienda
where id_azienda=1
;
if pos(ls_test, "Silver Dreams")>0 then
	ll_id_riga_padre=dw_2.getitemnumber(row, "id_riga_doc_padre")
	if ll_id_riga_padre>0 then
		return 0
	end if
end if
ll_riga_corrente=dw_1.getrow()
long ll_riga
if row>0 then
	ll_riga=row
else
	ll_riga=dw_2.getrow()
end if
ll_caus_magazzino=dw_2.getitemnumber(ll_riga,"riga_documento_id_caus_magazzino") 
select tipo_valorizzazione
into :ls_app
from caus_magazzino
where id_caus_magazzino=:ll_caus_magazzino;
if ls_app='' or isnull(ls_app) then ls_app='V'

ldt_data_attuale=dw_1.getitemdate(ll_riga_corrente, "data_registrazione")
if isnull(ldt_data_attuale) then 
	messagebox("Attenzione!", "Specificare la data del documento") 
	return 0
end if
ll_sog_com=dw_1.getitemnumber(ll_riga_corrente, "id_sog_commerciale")
select id_cat_com_sc, id_listino
into :ll_id_cat_com_sc, :ll_id_listino
from sog_commerciale
where id_sog_commerciale = :ll_sog_com;
if isnull(ll_id_cat_com_sc) then ll_id_cat_com_sc=0
if isnull(ll_id_listino) then ll_id_listino=0

ll_id_art_in_esame=dw_2.getitemnumber(ll_riga,"riga_documento_id_articolo")
if isnull(ll_id_art_in_esame) then ll_id_art_in_esame=0
ls_cod_art_in_esame=dw_2.getitemstring(ll_riga, "c_articolo_cod")
select id_cat_com_articolo
into :ll_id_cat_com_articolo
from articolo
where id_articolo= :ll_id_art_in_esame;
if isnull(ll_id_cat_com_articolo) then ll_id_cat_com_articolo=0	
	
select id_sog_commerciale, id_anagrafica
into :ll_sog_com_fornitore, :ll_id_produttore
from articolo
where id_articolo= :ll_id_art_in_esame;
if isnull(ll_sog_com_fornitore) then ll_sog_com_fornitore=0	
if isnull(ll_id_produttore) then ll_id_produttore=0	

	
ll_id_U_C_in_esame=dw_2.getitemnumber(ll_riga, "riga_documento_id_unita_confezione")
if isnull(ll_id_U_C_in_esame) then ll_id_U_C_in_esame=0
ld_adc_qta=adc_qta
if isnull(ld_adc_qta) then ld_adc_qta=0
ls_adc_qta=string(ld_adc_qta)
ll_pos = Pos(ls_adc_qta, ",", 1)
ls_adc_qta=replace(ls_adc_qta, ll_pos, 1, ".")

ll_id_magazzino=dw_2.getitemnumber(ll_riga, "id_locazione_1")
if ll_id_magazzino<1 then 
	Messagebox("Attenzione!", "Non è stato specificato alcun magazzino~r~n"&
									+"per questa riga!")
end if
integer i, li_pos

ll_id_valuta_riga=dw_1.GetItemNumber(1, "documento_id_valuta_des")
	SELECT "valuta"."cifra_arrotondamento",
		"valuta"."tipo_arrotondamento"
			INTO :ll_nr_cifre_arrot ,
			:ls_tipo_arrotondamento
	FROM "dba"."valuta"  
	WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;			

ldc_cambio=1
for i = 1 to 4
	if i=1 then ls_tipo_applicazione="P"
	if i=2 then ls_tipo_applicazione="R" 
	if i=3 then ls_tipo_applicazione="S" 
	if i=4 then ls_tipo_applicazione="D" 
	
	string ls_prezzo
	long ll_valuta, ll_id_var
	string ls_lis_variazione
	ll_valuta=dw_2.getitemnumber(1,"riga_documento_id_valuta")
	
	
	ls_um=dw_2.getitemstring(row, "tipo_um")
	if isnull(ls_um) then ls_um=""
	
	if not(ls_um='P') then 
		ls_prezzo=f_recupera_prezzo_manifattura(ls_app, ll_id_U_C_in_esame, ll_sog_com,ll_id_cat_com_sc, ls_cod_art_in_esame, & 
		ll_id_cat_com_articolo,	ll_sog_com_fornitore, ll_id_produttore,& 
		ld_adc_qta, ls_tipo_applicazione, ll_id_art_in_esame, ll_id_magazzino, &
		ll_id_valuta_riga,'PZ',ldc_cambio, ll_id_valuta_riga)
	else
		ls_prezzo=f_recupera_prezzo_manifattura(ls_app, ll_id_U_C_in_esame, ll_sog_com,ll_id_cat_com_sc, ls_cod_art_in_esame, & 
		ll_id_cat_com_articolo,	ll_sog_com_fornitore, ll_id_produttore,& 
		ld_adc_qta, ls_tipo_applicazione, ll_id_art_in_esame, ll_id_magazzino, &
		ll_id_valuta_riga,'PS', ldc_cambio, ll_id_valuta_riga)
	end if
		li_pos=pos(ls_prezzo, "!")
			string ls_coef_calo
			ls_app1=ls_prezzo
	if li_pos>0 then
		ls_prezzo=left(ls_app1, li_pos - 1)
		ls_app1=right(ls_app1, len(LS_APP1) - li_pos)
	end if
	li_pos=pos(ls_app1, "!")
	if li_pos>0 then
		ls_lis_variazione=right(ls_app1, len(ls_app1) - li_pos)
		ls_coef_calo=left(ls_app1, li_pos - 1)		
		if ll_id_var=0 then
			ll_id_var=long(ls_lis_variazione)
			if ll_id_var>0 then  // devo aggiungere <> da listino base vendita
				dw_2.setitem(row, "riga_documento_id_listino", ll_id_var)
			else
				setnull(ll_id_var)
				dw_2.setitem(row, "riga_documento_id_listino", ll_id_var)
			end if
		end if
	else
		ls_coef_calo=ls_app1
		if ll_id_var=0 then
			setnull(ll_id_var)
			dw_2.setitem(row, "riga_documento_id_listino", ll_id_var)
		end if
	end if
							
	if i=1  then 
		ld_prezzo=dec(ls_prezzo)
		
		
		if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
			ld_Prezzo=f_Round(ld_Prezzo ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)		
			
		if not(ls_um='P') then 
	
			
			select p.coef_calo
			into :ld_var_calo 
			from prezzo_documento p, unita_confezione u, articolo a
			where id_documento=:il_id_documento
			and u.id_unita_confezione= :ll_id_U_C_in_esame
			and p.id_titolo=a.id_titolo
			and u.id_articolo=a.id_articolo;
			
			if ld_prezzo >0 then 
				dw_2.setitem(ll_riga, "prezzo", ld_prezzo)
				dw_2.setitem(ll_riga, "prezzo_complessivo", ld_prezzo)
			end if
		else 
			long ll_id_caus_magazzino, ll_null
			string ls_manifattura
			setnull(ll_null)
			
			ll_id_caus_magazzino=dw_2.getitemnumber(ll_riga,"riga_documento_id_caus_magazzino")
			select proponi_prezzo_manifattura
			into :ls_manifattura
			from caus_magazzino
			where id_caus_magazzino=:ll_id_caus_magazzino;
			if ls_manifattura='S' then
				
					
					
					
					select u.unita_produzione, a.id_titolo
					into :ls_manifattura, :ll_id_titolo
					from unita_confezione u, articolo a
					where u.id_unita_confezione= :ll_id_U_C_in_esame
					and u.id_articolo=a.id_articolo;
												
					select coef_calo, prezzo, id_unita_conf_base
					into :ld_var_calo, :ld_var_prezzo, :ll_tipo_prezzo
					from prezzo_documento
					where id_documento=:il_id_documento
					and id_titolo=:ll_id_titolo;
					if ld_var_prezzo>0 then ld_prezzo+=ld_var_prezzo
					
				if ld_prezzo >0 then
					if ll_tipo_prezzo=2 then 
						ls_manifattura='C' 
					elseif ll_tipo_prezzo=1 then 
						ls_manifattura='S'
					end if
					
					if ls_manifattura='S' then
						dw_2.setitem(ll_riga,"prezzo_complessivo",ld_prezzo)
						dw_2.setitem(ll_riga,"prezzo_manifattura",ll_null)
					else
						dw_2.setitem(ll_riga, "prezzo_manifattura", ld_prezzo)
						dw_2.setitem(ll_riga,"prezzo_complessivo",ll_null)
					end if
				else
					dw_2.setitem(ll_riga,"prezzo_complessivo",ll_null)
					dw_2.setitem(ll_riga,"prezzo_manifattura",ll_null)
				end if
			end if	
		end if
		ld_legato=dw_2.getitemdecimal(row, "riga_documento_peso_netto")
		if ld_legato>0 then
			ld_fino=dw_2.getitemdecimal(row, "fino")
			ld_calo=dw_2.getitemdecimal(row, "calo")
			if isnull(ld_calo) then ld_calo=0
			if isnull(ld_fino) then ld_fino=0
			ld_fino=ld_fino+ld_calo
		else
			ld_fino=0
		end if
		
	elseif i=2 then 
		ld_prezzo=dec(ls_prezzo)
		if ld_prezzo >0 then dw_2.setitem(ll_riga, "riga_documento_sconto_riga", (ld_prezzo )*ld_adc_qta)										
	elseif i=3 then
		
		ls_sconto=dw_2.getitemstring(ll_riga, "sconto")
		if ls_sconto<='0' or isnull(ls_sconto) then
			dw_2.setitem(ll_riga, "sconto", ls_prezzo)
		else
			li_ret=messagebox("Attenzione!", "Esiste già uno sconto applicato. Si vuole sovrascriverlo?",  stopsign!, yesno!)
			if li_ret=1 then dw_2.setitem(ll_riga, "sconto", ls_prezzo)
		end if
	elseif i=4 then
		ld_prezzo=dec(ls_prezzo)
		ll_riga_corrente=dw_1.getrow()
		dw_1.setitem(ll_riga_corrente, "documento_sconto_finanziario", ls_prezzo)
	end if
	ld_coef_calo=dec(ls_coef_calo)
	
	if ld_var_calo>0 then ld_coef_calo=ld_var_calo
//	//20-04-2016 aggiungo recupero delle descrizioni del listino (per ora solo la des_2)
//	if isnull(ll_id_var) or ll_id_var<=0 then
//		ll_id_var=dw_1.getitemnumber(1, "documento_id_variazione")
//	end if
//	if ll_id_var>0 then
//		select des_1, des_2, des_3 
//		into  :ls_des_1, :ls_des_2, :ls_des_3
//		from dba.prezzo 
//		where id_variazione=:ll_id_var
//		and id_unita_confezione=:ll_id_U_C_in_esame
//		;
//	else
//		//provo dal listino base
//		select des_2, des_3, des_1
//		into :ls_des_2, :ls_des_3, :ls_des_1
//		from dba.prezzo p, dba.listino l, dba.variazione v
//		where l.id_listino=v.id_listino
//		and v.id_variazione=p.id_variazione
//		and p.id_unita_confezione=:ll_id_U_C_in_esame
//		and l.lis_base='S'
//		and l.tipo='V'
//		and v.data_inizio<=:ldt_data_attuale
//		and v.data_fine>=:ldt_data_attuale
//		;
//	end if
//	if ls_des_2>" " then
//		st_des_2_prezzo.text=ls_des_2
//	end if
//	if ls_des_3>" " then
//		st_des_3_prezzo.text=ls_des_3
//	end if
	
	
	
next
return 1
	
end function

public subroutine wf_valori_default (long al_riga);//valuta sicuro
long ll_id_val, ll_id_causale

select id_valuta
into :ll_id_val
from dba.par_sistema
;
dw_1.setitem(1, "documento_id_valuta_des", ll_id_val)


//dw_1.setitem(1, "documento_id_caus_magazzino", ll_id_causale)
end subroutine

public subroutine wf_val_iniziali_riga (long al_riga);//num riga, causale, magazzino tanto per cominciare

long ll_num_riga, ll_id_causale, ll_id_locazione, ll_id_valuta, ll_id_listino, ll_id_variazione

decimal ldc_cambio
date ldt_data_doc

ll_num_riga=dw_2.getitemnumber(1, "c_max_num")
if isnull(ll_num_riga) then ll_num_riga=0
dw_2.setitem(al_riga, "riga_documento_num_riga", ll_num_riga + 1)
ll_id_causale=dw_1.getitemnumber(1, "documento_id_caus_magazzino")
ll_id_locazione=dw_1.getitemnumber(1, "documento_id_locazione_1")
dw_2.setitem(al_riga, "riga_documento_id_caus_magazzino", ll_id_causale)
dw_2.setitem(al_riga, "id_locazione_1", ll_id_locazione)

ll_id_valuta=dw_1.getitemnumber(1, "documento_id_valuta_des")
dw_2.setitem(al_riga, "riga_documento_id_valuta", ll_id_valuta)

ldc_cambio=dw_1.getitemnumber(1, "documento_CAMBIO")
dw_2.setitem(al_riga, "riga_documento_cambio", ldc_cambio)

//ldt_data_doc=dw_1.getitemdate(1, "data_documento")
//ll_id_listino=dw_1.getitemnumber(1, "documento_id_listino")
//if ll_id_listino>0 then
	//	select id_variazione
	//	into :ll_id_variazione
	//	from dba.variazione v, dba.listino l
	//	where l.id_listino=:ll_id_listino
	//	and data_inizio<=:ldt_data_doc
	//	and data_fine>=:ldt_data_doc
	//	;
	////	
	//	dw_2.setitem(al_riga, "riga_documento_id_listino", ll_id_variazione)
//end if
end subroutine

public subroutine wf_salva_righe ();integer	li_retvalue

if (dw_2.deletedcount() + dw_2.modifiedcount()) > 1 then
		
	li_retvalue=dw_2.trigger Event ue_update()

	if li_retvalue<>1 then MessageBox("Salvataggio automatico del documento", sqlca.sqlerrtext, Exclamation!)
end if


end subroutine

public subroutine wf_art_aut_del_fornitore ();//per recuperare eventuale articolo da proporre nella riga doc se il fornitore è adeguato
//mm 23-12-13 12.00 13.00
//parte da selectionchanged del tab, ma se lo vuole per tutte le righe va messo nell'ue_insert o ue_INIT
long ll_id_sog_commerciale, ll_id_articolo, ll_riga, ll_id_registro
string ls_cod_articolo, ls_tipo_registro

ll_riga=dw_2.getrow()
if ll_riga>0 then
 	ll_id_registro=dw_1.getitemnumber(1, "id_registro")
	ls_tipo_registro=uf_tipo_registro(ll_id_registro)
	
	if ls_tipo_registro='DV' then
	
		ll_id_sog_commerciale=dw_1.getitemnumber(1, "id_sog_commerciale")
		
		select f.id_articolo, codice
		into :ll_id_articolo, :ls_cod_articolo
		from dba.fornitore_articolo f, dba.articolo a
		where f.id_sog_commerciale=:ll_id_sog_commerciale
		and a.id_articolo=f.id_articolo;
		
		//ERA LANCIATO DAL  UE:_INITIAL DELLA RIGA ... 010114
		ll_riga=dw_2.getrow()
		if ll_id_articolo>0 then
			dw_2.trigger event itemchanged(ll_riga, dw_2.object.c_articolo_cod, ls_cod_articolo)
			dw_2.setcolumn("riga_documento_peso_netto")
		end if
	end if
end if
end subroutine

public function string uf_tipo_registro (long al_id_registro);
string ls_RetVal = ""

IF al_id_registro > 0 THEN
	SELECT dba.registro.tipo_registro
		INTO :ls_RetVal
		FROM dba.registro
		WHERE registro.id_registro = :al_id_registro
		USING SQLCA;
		
		CHOOSE CASE SQLCA.SQLCode
			CASE -1
				MessageBox("Errore sul DataBase", "w_doc_veloce_cx / uf_tipo_registro / 1")
		END CHOOSE

END IF

RETURN ls_RetVal
end function

public subroutine wf_ins_riga ();i_dw_corrente=2
cb_inserisci.event clicked()
dw_2.post setfocus()


end subroutine

public subroutine wf_rec_galvanica (string as_id, long al_riga);decimal ldc_prezzo
string ls_descrizione, ls_des_originale
long ll_id, ll_pos
date ldt_data_doc

ll_id=long(as_id)
ldt_data_doc=dw_1.getitemdate(1, "data_documento")
select descrizione
into  :ls_descrizione
from dba.galvanica
where id_galvanica=:ll_id;

ldc_prezzo=f_rec_prezzo_galvanica(ldt_data_doc, ll_id)

dw_2.setitem(al_riga, "prezzo_metallo", ldc_prezzo)
ls_des_originale=dw_2.getitemstring(al_riga, "riga_documento_descrizione")
ll_pos=pos(ls_des_originale, "__")
if ll_pos>0 then
	ls_des_originale=left(ls_des_originale, ll_pos - 1)
end if
dw_2.setitem(al_riga, "riga_documento_descrizione", ls_des_originale +" __ "+ ls_descrizione)
//dw_2.setitem(al_riga, "id_gruppo_agenti_2", ll_id)

end subroutine

public subroutine wf_calcola_prezzo (long row);decimal ld_importo, ld_imp_manifattura_val, ldc_cambio, ld_imp_manifattura
long ll_id_valuta_riga, ll_nr_cifre_arrot, ll_galvanica
string ls_tipo_arrotondamento, ls_sconto, ls_um, ls_codice_profilo
decimal ld_pr_metallo, ld_pr_manifattura, ld_pr_complessivo
decimal ld_fino_calo, ld_peso, ld_fino, ld_calo

ls_um=dw_2.GetItemstring(row, "tipo_um")
ld_pr_complessivo=dw_2.GetItemdecimal(row, "prezzo_complessivo")
if ls_um='P' then
	ld_pr_metallo=dw_2.GetItemdecimal(row, "prezzo_metallo")
	ld_pr_manifattura=dw_2.GetItemdecimal(row, "prezzo_manifattura")
	ld_fino=dw_2.GetItemdecimal(row, "fino")
	if isnull(ld_fino) then ld_fino=0
	ld_calo=dw_2.GetItemdecimal(row, "calo")
	if isnull(ld_calo) then ld_calo=0
	ld_fino_calo=ld_calo+ld_fino
	ld_peso=dw_2.getitemdecimal(row, "riga_documento_peso_netto")
	
	if isnull(ld_peso) then ld_peso=0
	if isnull(ld_pr_metallo) then ld_pr_metallo=0
	if isnull(ld_fino_calo) then ld_fino_calo=0
	if isnull(ld_pr_manifattura) or ld_pr_manifattura=0 then 
		
		
		ld_pr_manifattura=ld_pr_complessivo
	end if
	if isnull(ld_pr_manifattura) then	ld_pr_manifattura=0
	
	ld_imp_manifattura_val=ld_pr_manifattura*ld_peso
	ls_sconto=dw_2.getitemstring(row, "sconto")
	if not((isnull(ls_sconto)) or (ls_sconto='')) then
		// da rimettere subito ld_imp_manifattura_val= uf_calcola_prezzo(ls_Sconto, ld_imp_manifattura_val, 1)
	end if
	ld_imp_manifattura_val= Round(ld_imp_manifattura_val, 3)
	//14-02-14 se ilprofilo ="MRBOL" è galvanica
	//non è davvero quotazione e va moltiplicata per il peso, non per il puro
	ls_codice_profilo=dw_1.getitemstring(1, "c_prof_doc_cod")
	if ls_codice_profilo='MRBOL' or ls_codice_profilo='MFATLAV' then
		ld_importo=(ld_pr_metallo*ld_peso)+(ld_imp_manifattura_val)
	else
		ld_importo=(ld_pr_metallo*ld_fino_calo)+(ld_imp_manifattura_val)
	end if
	//fine 14-02-14
	ld_importo=Round(ld_importo, 3)
	dw_2.setitem(row,"importo_manifattura_val", ld_imp_manifattura_val)
		
	//ld_imp_manifattura= ld_imp_manifattura_val * idc_cambio
	ld_imp_manifattura= ld_imp_manifattura_val// / idc_cambio
	DW_2.setitem(row,"importo_manifattura", ld_imp_manifattura)
	if ld_importo>=0 then
		ld_importo=dw_2.setitem(row, "prezzo", ld_importo)
		if ld_importo<>1 then 
			messagebox("Errore!", "Setitem fallito, prezzo non settato")
		end if
	else
		
	end if
else
	dw_2.setitem(row, "prezzo", ld_pr_complessivo)
end if

//tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_riga(row)
//WF_SETTA_MASK_RIGA()


end subroutine

public subroutine wf_setta_fino_calo (long row);	decimal{2} ld_fino, ld_coef_calo, ld_peso_non_prezioso, ld_calo, ld_peso
		long ll_id_titolo
		integer li_ret
		
		ll_id_titolo=dw_2.getitemnumber(row, "id_titolo")
		ld_peso_non_prezioso=dw_2.getitemdecimal(row, "peso_non_prezioso")
		if isnull(ld_peso_non_prezioso) then ld_peso_non_prezioso=0
		ld_peso=dw_2.getitemdecimal(row, "riga_documento_peso_netto")
		ld_peso=ld_peso - ld_peso_non_prezioso
					
		ld_fino=f_converti_in_fino(ld_peso, ll_id_titolo)
		li_ret=dw_2.setitem(row, "fino", ld_fino)
		if li_ret<>1 then messagebox("Errore!", "Fino non settato")
		
		ld_coef_calo=dw_2.getitemdecimal(row, "coef_calo")
		
		if ld_coef_calo>0 and not isnull(ld_coef_calo) then
				ld_calo=f_round(ld_peso*(ld_coef_calo)/1000, -2, 'M')
				ld_calo= f_round(ld_calo - ld_fino, -2, 'M')
				li_ret=dw_2.setitem(row, "calo",ld_calo) 
				if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
		elseif ld_coef_calo=0 then 
			li_ret=dw_2.setitem(row, "calo",0)
			if li_ret<>1 then messagebox("Errore!", "Settaggio calo errato!")
		end if
end subroutine

public subroutine wf_nuovo ();long ll_id_prof, ll_riga

if dw_1.rowcount()>0 then
	if messagebox("Attenzione!", "Vuoi salvare il documento prima di sostituirlo?")= 1 then
		wf_salva_dw(dw_1, dw_2, 2)
	end if
	ll_id_prof=dw_1.getitemnumber(1, "id_prof_documento")
	dw_1.reset()
end if

ll_riga=dw_1.trigger event ue_insert(0)
dw_1.setitem(ll_riga, "id_prof_documento", ll_id_prof)
dw_1.trigger event itemchanged(ll_riga, dw_1.object.id_prof_documento, string(ll_id_prof))

dw_1.setitem(ll_riga, "id_sog_commerciale", 43)
dw_1.trigger event itemchanged(ll_riga, dw_1.object.id_sog_commerciale, "43")
dw_1.post event itemfocuschanged(ll_riga, dw_1.object.num_documento)
end subroutine

public function integer wf_verifica_met_profilo (long al_id_titolo);string ls_metallo
long ll_id_profilo

ll_id_profilo=dw_1.getitemnumber(1, "id_prof_documento")
//if ll_id_profilo>0 and  (ll_id_profilo= 65 or ll_id_profilo>=111 or ll_id_profilo<=113)  then
//	select codice
//	into :ls_metallo
//	from orafo_metallo m, orafo_titolo t
//	where m.id_metallo=t.id_metallo
//	and t.id_titolo=:al_id_titolo
//	;
	if as_metallo>" " then
		choose case ll_id_profilo
		case 65
			if as_metallo <> 'AG' then  
				Messagebox("Attenzione!", "Il profilo selezionato richiede articoli in AG!")
				return 0
			end if
		case 111
			if as_metallo <> 'OT' then  
				Messagebox("Attenzione!", "Il profilo selezionato richiede articoli in OT!")
				return 0
			end if
		case 112
			if as_metallo <> 'BZ' then  
				Messagebox("Attenzione!", "Il profilo selezionato richiede articoli in BZ!")
				return 0
			end if
		case 113
			if as_metallo <> 'SI' then  
				Messagebox("Attenzione!", "Il profilo selezionato richiede articoli in SI!")
				return 0
			end if
	end choose
	end if
//end if
return 1
	


end function

public subroutine wf_imposta_metallo (long al_id_profilo);
choose case al_id_profilo
	case 65
		as_metallo ="AG"
	case 111
		as_metallo ="OT"
	case 112
		as_metallo ="BZ"
	case 113
		as_metallo ="SI"
	case	else
		as_metallo=""
end choose
		
	
end subroutine

public subroutine wf_controlla_doppioni (string as_num_doc);string ls_numero_ultime_5, ls_num_doppio
long ll_num_prog, ll_id_registro


ll_id_registro=dw_1.getitemnumber(1, "id_registro")
if ll_id_registro=65 or   ll_id_registro=111 or  ll_id_registro=112 or  ll_id_registro=113  then
	ls_numero_ultime_5=dw_1.getitemstring(1, "num_documento")
	if ll_id_registro>0 and  as_num_doc> " " then
		ls_numero_ultime_5=right(as_num_doc, 5)
		select num_documento, num_progressivo
		into :ls_num_doppio, :ll_num_prog
		from dba.documento
		where id_registro=:ll_id_registro
		and right(num_documento, 5)=:ls_numero_ultime_5
		;
	
		if ll_num_prog> 0 then messagebox("Attenzione!", "Bollettina già esistente nell'anno " +string(year(today())) + " al numero progressivo  "+ string(ll_num_prog)+"!")
	end if
end if
end subroutine

public subroutine wf_rec_des_prezzo (long al_riga);long ll_id_uc, ll_id_var, ll_id_listino
string ls_des_1, ls_des_2, ls_des_3
date ldt_data_attuale

//20-04-2016 aggiungo recupero delle descrizioni del listino (per ora solo la des_2)
ldt_data_attuale=dw_1.getitemdate(1, "data_documento")
	ll_id_uc=dw_2.getitemnumber(al_riga, "riga_documento_id_unita_confezione")
	if isnull(ll_id_var) or ll_id_var<=0 then
		ll_id_listino=dw_1.getitemnumber(1, "documento_id_listino")
		if ll_id_listino>0 then
			select id_variazione
			into :ll_id_var
			from dba.variazione
			where id_listino=:ll_id_listino
			and data_inizio<=:ldt_data_attuale
			and data_fine >=:ldt_data_attuale
			;
		end if
	end if
	if ll_id_var>0 then
		select des_1, des_2, des_3 
		into  :ls_des_1, :ls_des_2, :ls_des_3
		from dba.prezzo 
		where id_variazione=:ll_id_var
		and id_unita_confezione=:ll_id_uc
		;
	else
		//provo dal listino base
		select des_2, des_3, des_1
		into :ls_des_2, :ls_des_3, :ls_des_1
		from dba.prezzo p, dba.listino l, dba.variazione v
		where l.id_listino=v.id_listino
		and v.id_variazione=p.id_variazione
		and p.id_unita_confezione=:ll_id_uc
		and l.lis_base='S'
		and l.tipo='V'
		and v.data_inizio<=:ldt_data_attuale
		and v.data_fine>=:ldt_data_attuale
		;
	end if
	if ls_des_2>" " then
		st_des_2_prezzo.text=ls_des_2
	end if
	if ls_des_3>" " then
		st_des_3_prezzo.text=ls_des_3
	end if
end subroutine

public subroutine wf_prezzo_galvanica (long al_row, string as_cod_art);//samy 280910 recuepro prezzo galvanica da listino (lo metto per adesso
//in prezzo metallo poi si vedrà ...
long ll_id_uc, ll_id_sog, ll_id_lis_cliente, ll_id_var, ll_id_galvanica
date ldt_data_doc
decimal ldc_costo_galvanica
string ls_controllato


ll_id_uc=dw_2.getitemnumber(al_row, "riga_documento_id_unita_confezione")
ll_id_sog=dw_1.getitemnumber(1, "id_sog_commerciale")
ldt_data_doc=dw_1.getitemdate(1, "data_documento")

select id_listino
into :ll_id_lis_cliente
from dba.sog_commerciale
where id_sog_commerciale=:ll_id_sog;
if ll_id_lis_cliente>0 then
	//trovo la variaizone e quindi il prezzo galvanica
	select id_variazione
	into :ll_id_var
	from dba.variazione
	where id_listino=:ll_id_lis_cliente
	and data_inizio<= :ldt_data_doc
	and (data_fine>=:ldt_data_doc or data_fine is null)
	;
else //cerco nel listino di base di vendita
	select id_variazione
	into :ll_id_var
	from dba.variazione v, dba.listino l
	where l.id_listino=v.id_listino
	and l.lis_base='S'
	and l.tipo='V'
	and data_inizio<= :ldt_data_doc
	and (data_fine>=:ldt_data_doc or data_fine is null)
	;
end if
select galvanica, confermato, id_galvanica //agg 2019-05-02
into :ldc_costo_galvanica, :ls_controllato, :ll_id_galvanica
from dba.prezzo
where id_unita_confezione=:ll_id_uc
and id_variazione=:ll_id_var
;
if ldc_costo_galvanica>0 then
	dw_2.setitem(al_row, "prezzo_metallo", ldc_costo_galvanica)
end if
if ls_controllato='C' then
	//dw_2.setitem(al_row, "provv_agente_2", 1)
end if
if ll_id_galvanica>0 then 	dw_2.setitem(al_row, "id_gruppo_agenti_2", ll_id_galvanica)
end subroutine

public subroutine wf_cerca_bol_excel (string as_numero, long al_riga_corrente); string ls_cod_barre, ls_cliente, ls_articolo, ls_des, ls_galv, ls_art_kar
 integer li_pezzi, li_num_riga, li_pos
 date ldt_data
 decimal ldc_peso
 long ll_id_riga_doc, ll_id_art, ll_id_galv
 
 
 li_pos=pos(as_numero, "-")
 if li_pos<= 0 then 
	messagebox("A", "Bollettina NON trovata!")
	return
end if
ls_cliente=left(as_numero, li_pos -1)
ls_cod_barre=right(as_numero, 5)
 
 SELECT "bollettine_excel"."cod_barre",   
         "bollettine_excel"."cliente",   
         "bollettine_excel"."pezzi",   
         "bollettine_excel"."peso",   
         "bollettine_excel"."articolo",   
         "bollettine_excel"."descrizione",   
         "bollettine_excel"."data",   
         "bollettine_excel"."galvanica",   
         "bollettine_excel"."id_riga_documento",   //se è valorizzato allora è già stata derivata
         "bollettine_excel"."num_riga"  
 into
 :ls_cod_barre, :ls_cliente, :li_pezzi, :ldc_peso, :ls_articolo, :ls_des, :ldt_data, :ls_galv, :ll_id_riga_doc, :li_num_riga
			
 FROM dba."bollettine_excel"   
 WHERE
	 cliente like '%'+:ls_cliente and cod_barre like '%'+:ls_cod_barre and id_riga_documento is null
	 ;
	 
if al_riga_corrente>0 and li_num_riga>0  then
	select id_articolo
	into :ll_id_art
	from dba.articolo
	where codice=:ls_articolo
	;
	if ll_id_art<=0 or isnull(ll_id_art) then
		select id_articolo_corrispondente
		into :ll_id_art
		from dba.corrispondenza_cod_id_articolo
		where cod_articolo=:ls_articolo
		;
		ls_art_kar=ls_articolo
		if  ll_id_art<=0 or isnull(ll_id_art) then
			//mostro una finestra dove faccio vedere il codice che ho io e chiedo di indicarmi l'id articolo corrispondente
			openwithparm(w_chiedi_id_art_corrispondente, ls_articolo)
			ll_id_art=message.doubleparm
			if ll_id_art>0 then
				insert into dba.corrispondenza_cod_id_articolo (cod_articolo, id_articolo_corrispondente)
				values (:ls_articolo, :ll_id_art);
				if sqlca.sqlNrows>0 then
					commit;
				else
					rollback;
					messagebox("Attenzione!", "Articolo: "+ls_articolo+ " NON salvato!")
				end if					
			else
				messagebox("Attenzione!", "Articolo NON trovato!")
				return
			end if
		end if
	end if
	//ora inserisco i dati nella riga
	select codice, descrizione
	into :ls_articolo, :ls_des
	from dba.articolo
	where id_articolo=:ll_id_art;
	dw_2.setitem(al_riga_corrente, "c_articolo_cod", ls_articolo)
	dw_2.trigger event itemchanged(al_riga_corrente, dw_2.object.c_articolo_cod, ls_articolo)
	if isnull(ls_des) then ls_des=""
	ls_des+=" - "+ls_art_kar
	if ls_galv> " " then ls_des+=" - "+ls_galv
	if ls_des> " " then dw_2.post setitem(al_riga_corrente, "riga_documento_descrizione", ls_des)
	dw_2.setitem(al_riga_corrente, "riga_documento_peso_netto", 0)// ldc_peso)  22/01/2020 Samy NON vuole il peso da excel
 	dw_2.setitem(al_riga_corrente, "quantita", li_pezzi) 
	//select id_galvanica into :ll_id_galv from dba.galvanica where lavorazione=:ls_galv;
	//dw_2.setitem(al_riga_corrente, "id_gruppo_agenti_2", ll_id_galv)
	
	 i_dw_corrente=1
	cb_salva.trigger event clicked()
	ll_id_riga_doc=dw_2.getitemnumber(al_riga_corrente, "id_riga_documento")
	update dba."bollettine_excel" 
	set    id_riga_documento=:ll_id_riga_doc
	WHERE 	 cliente like '%'+:ls_cliente and cod_barre like '%'+:ls_cod_barre and id_riga_documento is null
	;
	if sqlca.sqlnrows>0 then
		commit;
	else
		rollback;
		messagebox("Attenzione!", "Collegamento riga NON salvato!")
	end if
end if

end subroutine

public subroutine wf_gestisci_iva_riga (long al_row);long ll_id_prof_doc, ll_id_sog, ll_id_articolo, ll_id_tab_iva

ll_id_prof_doc=dw_1.getitemnumber(1, "id_prof_documento")
ll_id_sog=dw_1.getitemnumber(1, "id_sog_commerciale")
ll_id_articolo=dw_2.getitemnumber(al_row, "riga_documento_id_articolo")
ll_id_tab_iva=f_rec_iva_riga_doc(ll_id_prof_doc, ll_id_sog, ll_id_articolo)

dw_2.setitem(al_row, "riga_documento_id_tab_iva", ll_id_tab_iva)
end subroutine

on w_doc_veloce_cx.create
int iCurrent
call super::create
this.cb_ricerca=create cb_ricerca
this.cb_inserisci=create cb_inserisci
this.cb_salva=create cb_salva
this.cb_cancella=create cb_cancella
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.cb_stampa=create cb_stampa
this.ole_1=create ole_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.rb_nessun_filtro=create rb_nessun_filtro
this.rb_solo_cl=create rb_solo_cl
this.rb_solo_fo=create rb_solo_fo
this.cb_nuovo=create cb_nuovo
this.dw_3=create dw_3
this.st_des_2_prezzo=create st_des_2_prezzo
this.st_des_3_prezzo=create st_des_3_prezzo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ricerca
this.Control[iCurrent+2]=this.cb_inserisci
this.Control[iCurrent+3]=this.cb_salva
this.Control[iCurrent+4]=this.cb_cancella
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_annulla
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.cb_stampa
this.Control[iCurrent+9]=this.ole_1
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.dw_2
this.Control[iCurrent+12]=this.rb_nessun_filtro
this.Control[iCurrent+13]=this.rb_solo_cl
this.Control[iCurrent+14]=this.rb_solo_fo
this.Control[iCurrent+15]=this.cb_nuovo
this.Control[iCurrent+16]=this.dw_3
this.Control[iCurrent+17]=this.st_des_2_prezzo
this.Control[iCurrent+18]=this.st_des_3_prezzo
end on

on w_doc_veloce_cx.destroy
call super::destroy
destroy(this.cb_ricerca)
destroy(this.cb_inserisci)
destroy(this.cb_salva)
destroy(this.cb_cancella)
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.cb_stampa)
destroy(this.ole_1)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.rb_nessun_filtro)
destroy(this.rb_solo_cl)
destroy(this.rb_solo_fo)
destroy(this.cb_nuovo)
destroy(this.dw_3)
destroy(this.st_des_2_prezzo)
destroy(this.st_des_3_prezzo)
end on

event open;call super::open;long ll_riga, ll_id_prof
s_list_main ls_list
string ls_prof_id

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)
//dw_riga.settransobject(sqlca)
dw_1.getchild("id_sog_commerciale", idwc_sog)
dw_1.getchild("id_sog_commerciale_1", idwc_cod_sog)
idwc_sog.settransobject(sqlca)
idwc_cod_sog.settransobject(sqlca)
connect using sqlca;
idwc_sog.retrieve()
idwc_cod_sog.retrieve()
ll_riga=dw_1.trigger event ue_insert(0)

post setfocus(dw_1)
dw_1.post setcolumn("id_sog_commerciale")


rb_solo_cl.trigger event clicked()

ls_list=message.powerobjectparm
dw_1.setitem(ll_riga, "id_prof_documento", long(ls_list.s_win_parametri))
dw_1.trigger event itemchanged(ll_riga, dw_1.object.id_prof_documento, ls_list.s_win_parametri)

dw_1.setitem(ll_riga, "id_sog_commerciale", 43)
dw_1.trigger event itemchanged(ll_riga, dw_1.object.id_sog_commerciale, "43")
dw_1.post event itemfocuschanged(ll_riga, dw_1.object.num_documento)


end event

type st_1 from w_001`st_1 within w_doc_veloce_cx
end type

type cb_ricerca from commandbutton within w_doc_veloce_cx
integer x = 3310
integer y = 32
integer width = 343
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ricerca"
end type

event clicked;s_ric_param		ls_ric_param
string 	lw_sm, ls_column, ls_colval
long ll_id_documento



lw_sm = "w_documento_sw"
ls_ric_param.s_filter_value ="" 
ls_ric_param.s_filter_name = "cc_filtro_1"
OpenWithParm(w_documento_sw, ls_ric_param)

ls_ric_param= Message.PowerObjectParm
ll_id_documento = long(ls_ric_param.s_id_seg_value[1])

if ll_id_documento>0 then
	dw_1.retrieve(ll_id_documento)
	dw_1.trigger event rowfocuschanged(1)
else
	dw_2.reset()
end if
			
		
end event

type cb_inserisci from commandbutton within w_doc_veloce_cx
integer x = 32
integer y = 780
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inserisci"
end type

event clicked;long ll_riga, ll_id

ll_riga=dw_1.getrow()
if ll_riga>0 then
	ll_id=dw_1.getitemnumber(ll_riga, 1)
	if isnull(ll_id)  then
		if wf_salva_dw(dw_1,dw_2, 1)=1 then
			this.triggerevent(clicked!)
		end if
	else
		ll_riga=dw_2.trigger event ue_insert(0)
		//dw_riga.trigger event ue_insert(0)
	end if
end if

end event

type cb_salva from commandbutton within w_doc_veloce_cx
integer x = 457
integer y = 780
integer width = 343
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva"
end type

event clicked;if i_dw_corrente=1 then
	wf_salva_dw(dw_1, dw_2, 1)
elseif  i_dw_corrente=2 then
	wf_salva_dw(dw_1, dw_2, 2)
end if
end event

type cb_cancella from commandbutton within w_doc_veloce_cx
integer x = 882
integer y = 780
integer width = 343
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancella"
end type

event clicked;long ll_riga_da_cancellare, ll_righe
integer i

if i_dw_corrente=1 then
	if messagebox("Attenzione!", "Sei sicuro di voler cancellare l'intero documento?",  stopsign!,yesno!)=1 then


		ll_righe=dw_2.rowcount()
		for i = ll_righe to 1 step -1
			dw_2.trigger event ue_delete(i)
		next
		dw_2.trigger event ue_update()
		ll_riga_da_cancellare=dw_1.getrow()
		if ll_riga_da_cancellare>0 then
			dw_1.trigger event ue_delete(ll_riga_da_cancellare)
			dw_1.trigger event ue_update()
			dw_1.trigger event ue_insert(1)
			dw_2.reset()
		end if
	end if
elseif  i_dw_corrente=2 then
		ll_riga_da_cancellare=dw_2.getrow()
		if ll_riga_da_cancellare>0 then
		dw_2.trigger event ue_delete(ll_riga_da_cancellare)
		end if
end if

end event

type cb_ok from commandbutton within w_doc_veloce_cx
boolean visible = false
integer x = 3685
integer y = 332
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
string text = "OK"
end type

event clicked;cb_salva.triggerevent(clicked!)
close(parent)
end event

type cb_annulla from commandbutton within w_doc_veloce_cx
integer x = 3310
integer y = 320
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
string text = "Annulla"
end type

event clicked;if messagebox("Attenzione!", "Chiudere senza Salvare?", stopsign!, yesno!)=1 then
	close(parent)
end if
end event

type dw_1 from udw_base within w_doc_veloce_cx
integer x = 27
integer y = 28
integer width = 3214
integer height = 732
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_doc_veloce_tb"
boolean vscrollbar = false
end type

event getfocus;call super::getfocus;
i_dw_corrente=1
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id
integer li_test  

if currentrow>0 then
	
	ll_id=getitemnumber(currentrow, 1)
	
	if ll_id>0 then
		dw_2.retrieve(ll_id)
		//dw_riga.retrieve(ll_id)
	else
		dw_2.reset()
		//dw_riga.reset()
	end if
end if
end event

event itemchanged;call super::itemchanged;long 		ll_id_registro, ll_ultimo_num_reg, ll_num_suggerito_min, ll_num_suggerito_Max
long 		ll_id_documento, ll_id_profilo, rtncode, ll_id_locazione, ll_id_causale
decimal 	ldc_ultimo_num_reg, ldc_doc_globale
date		ld_ultima_data_reg, ld_data_prec, ld_data_succ, ld_Data, ldt_data
string	ls_message, ls_doc_globale, ls_num_documento,ls_tipo_registro
integer li_ret   
u_setta_campi_documento uo_proponi_num_progressivo
s_trova_progressivo ls_trova_prog
long ll_id_caus_trasporto, ll_id_sog,ll_id_vettore, ll_id_prof, ll_id_listino, ll_num_prog, ll_id_variazione
long ll_test, ll_id_valuta, ll_id_linguaggio, ll_id_magazzino, ll_id_pagamento, ll_id_banca_sog
string ls_asp_beni, ls_trasp_a_mezzo, ls_bollo

DataWindowChild dwc_dest

choose case dwo.name
	case "num_progressivo"
		ll_num_prog=long(data)
		ll_id_registro=dw_1.getitemnumber(1, "id_registro")
		if ll_id_registro>0 then
			select id_documento
			into :ll_id_documento
			from dba.documento
			where num_progressivo=:ll_num_prog
			and id_registro=:ll_id_registro
			;
			if ll_id_documento>0 then
				retrieve(ll_id_documento)
				trigger event rowfocuschanged(1)
			end if
		end if
	case "id_prof_documento"
		ldt_data=date(today())
		ll_id_profilo=long(data)
		select id_registro, r.tipo_registro, p.id_caus_magazzino_prop, p.id_locazione_1_prop,
		trasp_mezzo_prop, id_caus_trasporto_prop, aspetto_beni_prop, id_sog_comm_vettore_1_prop
		
		into :ll_id_registro, :ls_tipo_registro, :ll_id_causale, :ll_id_locazione,
		:ls_trasp_a_mezzo, :ll_id_caus_trasporto, :ls_asp_beni, :ll_id_vettore
		
		from dba.registro r, dba.prof_documento p, dba.esercizio e
		where r.id_mod_registro=p.id_mod_registro_prop
		and p.id_prof_documento=:ll_id_profilo
		and e.data_inizio<=:ldt_data
		and e.data_fine>=:ldt_data
		and e.id_esercizio=r.id_esercizio
		;
		
		select id_magazzino
		into :ll_id_magazzino
		from dba.locazione
		where id_locazione=:ll_id_locazione
		;
		
		setitem(1, "id_registro",ll_id_registro)
		setitem(1, "documento_id_caus_magazzino",ll_id_causale)
		setitem(1, "documento_id_locazione_1",ll_id_locazione)
		setitem(1, "documento_id_magazzino",ll_id_magazzino)
		setitem(1, "asp_beni", ls_asp_beni)
		setitem(1, "documento_tras_mezzo",ls_trasp_a_mezzo)
		setitem(1, "id_caus_trasporto",ll_id_caus_trasporto)
		setitem(1, "documento_id_sog_commerciale_vettore",ll_id_vettore)
	
		IF  ll_id_registro > 0 THEN
			uo_proponi_num_progressivo=create u_setta_campi_documento
			ls_trova_prog=uo_proponi_num_progressivo.uf_set_progressivo(ll_id_registro, 0, ls_tipo_registro)
			destroy uo_proponi_num_progressivo
			SetItem(1, "num_progressivo", ls_trova_prog.sl_num_progressivo)
			
			ls_trova_prog.sdt_data_registrazione = Today()
			SetItem(1, "data_registrazione", ls_trova_prog.sdt_data_registrazione)
			SetItem(1, "documento_data_competenza", ls_trova_prog.sdt_data_registrazione)
			If right(ls_tipo_registro, 1)="V" or right(ls_tipo_registro, 1)="C" then
				SetItem(1, "num_documento", string(ls_trova_prog.sl_num_progressivo))
				SetItem(1, "data_documento", ls_trova_prog.sdt_data_registrazione)
	//		else
	//			dw_1.Object.tipo_fattura.Protect = 0
			end if
		END IF
		wf_imposta_metallo(ll_id_profilo)
		
		
	CASE "id_sog_commerciale"
		if long(data)>0 then 
			ll_id_sog=long(data)
			rtncode = dw_1.GetChild('id_destinazione', dwc_dest)
			IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
			CONNECT USING SQLCA;
			dwc_dest.settransobject(sqlca)
			dwc_dest.retrieve(ll_id_sog)
			//carico eventuale vettore associato
			select id_sog_com_vettore, bollo, a.id_valuta, s.id_linguaggio,
			s.id_con_pagamento, s.id_banca_sog_commerciale, id_listino
			into :ll_id_vettore, :ls_bollo, :ll_id_valuta, :ll_id_linguaggio,
			:ll_id_pagamento, :ll_id_banca_sog, :ll_id_listino
			from dba.sog_commerciale s, dba.anagrafica a
			where id_sog_commerciale=:ll_id_sog
			and a.id_anagrafica=s.id_anagrafica
			;
			
			//metto anche il sog com fattura 29-10-2015
			setitem(1, "documento_id_sog_commerciale_fattura", ll_id_sog)
			if ll_id_vettore> 0 then
				setitem(1, "documento_id_sog_commerciale_vettore", ll_id_vettore)
			end if
			
			if ls_bollo> " " then  setitem(1, "bollo", ls_bollo)
	
			if ll_id_valuta>0 then setitem(1, "documento_id_valuta_des", ll_id_valuta)
			if ll_id_linguaggio>0 then 	setitem(1, "documento_id_linguaggio", ll_id_linguaggio)
			if ll_id_pagamento>0 then setitem(1, "id_con_pagamento_des", ll_id_pagamento)
			if ll_id_banca_sog>0 then setitem(1, "id_banca_sog_commerciale", ll_id_banca_sog)
			if ll_id_listino>0 then 
				setitem(1, "documento_id_listino", ll_id_listino)
				ldt_data=dw_1.getitemdate(1, "data_documento")
				select id_variazione into :ll_id_variazione from dba.variazione
				where id_listino=:ll_id_listino and data_inizio<=:ldt_data and data_fine>=:ldt_data
				;
				if ll_id_variazione>0 then setitem(1, "documento_id_variazione", ll_id_variazione)
			end if
			//carico l'eventuale profilo associato 210114
//			select id_prof_documento, 
//			into :ll_id_prof, :ll_id_magazzino
//			from dba.fornitore_articolo
//			where id_sog_commerciale=:ll_id_sog
//			;
//			if ll_id_prof>0 then
//				ll_test=getitemnumber(1, "id_prof_documento")
//				if isnull(ll_test) then
//					setitem(1, "id_prof_documento", ll_id_prof)
//					post event itemchanged(row, object.id_prof_documento, string(ll_id_prof))
//					setfocus(dw_2)
//					cb_inserisci.postevent(clicked!)
//				end if
//			end if
		end if
	case "num_documento"
		wf_controlla_doppioni(data)
		

end choose
end event

event ue_insert;

long ll_riga
ll_riga=this.insertrow(al_riga_precedente)
scrolltorow(ll_riga)
post wf_valori_default(ll_riga)


return ll_riga

end event

event itemfocuschanged;call super::itemfocuschanged;long ll_id_prof_doc, ll_id_documento
s_stringa_data_prog s_struct
string ls_barcode, ls_numero, ls_prog, ls_data_scadenza
integer li_pos

if dwo.name="num_documento" then
	ll_id_prof_doc=getitemnumber(1, "id_prof_documento")
	if ll_id_prof_doc>0 then
		select ins_barcode
		into :ls_barcode
		from dba.prof_documento
		where id_prof_documento =:ll_id_prof_doc
		;
		IF ls_barcode='B' then
			open(w_ins_barcode_pop)
			ls_numero=message.stringparm
			
			if ls_numero>"" then
				s_struct=f_scomp_stringa_num_data_prog(ls_numero)
				select id_documento
				into :ll_id_documento
				from dba.documento
				where num_documento=:s_struct.as_numero
				and data_prev_consegna=: s_struct.adt_data
				;
				if ll_id_documento>0 then
					dw_1.retrieve(ll_id_documento)
					dw_1.trigger event rowfocuschanged(1)
				else
					if s_struct.as_numero> " " then
						post setitem(1, "num_documento", s_struct.as_numero )  //ls_numero)
					end if
					if  s_struct.adt_data> date("01-01-1901") then
						post setitem(1, "data_prev_consegna",  s_struct.adt_data)  //date(ls_data_scadenza))
					end if
	//				li_pos=0
	//				li_pos=pos(ls_numero, "___")
					if s_struct.al_prog>0 then
	//					ls_prog=right(ls_numero, len(ls_numero) - (li_pos +2))
	//					ls_numero=left(ls_numero, li_pos -1)
						post setitem(1, "num_progressivo", s_struct.al_prog)
					end if
	//					
	//				post setitem(1, "num_documento", ls_numero)
					post wf_controlla_doppioni(ls_numero)
					wf_ins_riga()
					post wf_cerca_bol_excel(s_struct.as_numero, dw_2.getrow())
				end if
				
			end if
			
		end if
	END IF
end if
end event

type cb_stampa from commandbutton within w_doc_veloce_cx
integer x = 3310
integer y = 176
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
string text = "Stampa"
end type

event clicked;s_crea_dw s_dati_doc
long ll_id_doc, ll_id_prof
string ls_nome_report

cb_salva.trigger event clicked()

ll_id_doc=dw_1.getitemnumber(1, "id_documento")
ll_id_prof=dw_1.getitemnumber(1, "id_prof_documento")
select nome_report
into :ls_nome_report
from dba.prof_documento
where id_prof_documento=:ll_id_prof
;
s_dati_doc.ls_dw_sintax=lower(ls_nome_report)
s_dati_doc.ll_id_doc=ll_id_doc
//if cbx_prezzo.checked then
//	s_dati_doc.s_selezione="NO PREZZO"
//end if
openwithparm(w_catalogo_foto, s_dati_doc)
end event

type ole_1 from olecustomcontrol within w_doc_veloce_cx
event oncomm ( )
integer x = 3698
integer y = 452
integer width = 174
integer height = 152
integer taborder = 60
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "w_doc_veloce_cx.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type cb_1 from commandbutton within w_doc_veloce_cx
integer x = 2341
integer y = 768
integer width = 247
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Bilancia"
end type

event clicked;DWObject my_dwo
decimal ld_peso_netto
long	ll_row

w_bilancia w_bil
open(w_bil)

ld_peso_netto=w_bil.f_rendi_peso()
if ld_peso_netto>0 then
	ld_peso_netto=round(ld_peso_netto, 1)
	
	ll_row = dw_2.getrow()
				
	my_dwo = dw_2.object.riga_documento_peso_netto
	dw_2.setitem(ll_row,"riga_documento_peso_netto",ld_peso_netto)
	dw_2.trigger event itemchanged(ll_row, my_dwo, string(ld_peso_netto))
end if
close(w_bil)
end event

type dw_2 from udw_figlia within w_doc_veloce_cx
integer x = 73
integer y = 872
integer width = 3753
integer height = 1488
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_riga_veloce_gd"
end type

event clicked;call super::clicked;s_new_ordini s_ordini
s_list_main ls_list_distinta
long ll_id_art_originale, ll_id_cliente, ll_row, ll_id_documento, ll_id_sorgente, ll_ret, ll_riga, ll_tot 
w_orafo_lista_dis_cliente_gd  w_lista
long ll_id_dis, ll_art
string ls_data

choose case string(dwo.name)
	case "c_articolo_cod_sw"
		accepttext()
		ii_finestra_ricerca=1
		dwo=object.c_articolo_cod
		ls_data=getitemstring(row, "c_articolo_cod")
		trigger event itemchanged(row, dwo, ls_data)
		ii_finestra_ricerca=0
//		setfocus(this)
//		setcolumn("c_articolo_cod")
//		post event clicked(1958,0,row,dwo)
	case 'varianti' 
	ll_row=getrow() 
	if ll_row>0 then
		s_ordini.s_ll_id_sorgente=getitemnumber(ll_row, "id_riga_sorgente")
		
		s_ordini.s_ll_id_documento=getitemnumber(ll_row, "id_documento")
		s_ordini.s_ll_id_art_originale=getitemnumber(ll_row, "riga_documento_id_articolo")
		s_ordini.s_ll_id_cliente=dw_1.getitemnumber(1, "id_sog_commerciale")
		OpenWithParm(w_lista, s_ordini)
		ll_ret=message.doubleparm
		if ll_ret= -1 then 
			messagebox("Attenzione!", "Non esiste distinta per questo articolo!")
		elseif ll_ret>0 then
					
			if  ll_row>1 then ll_riga=find( "id_riga_sorgente="+string(ll_ret), 1, ll_row -1)
			ll_tot=rowcount()
			if ll_row<ll_tot and isnull(ll_riga) then 
				ll_riga=find( "id_riga_sorgente=" +string(ll_ret), ll_row, ll_tot)
			end if	
			if not isnull(ll_riga) and ll_riga>0 then 
				  messagebox('Attenzione','La variante selezionata è già stata utilizzata nella riga '&
				  +string(ll_riga) + ' di questo documento, ~r~nè consigliabile cambiare la variante'+ &
				  ' o provvedere a sommare le due righe in una riga sola')	  
		   end if
			setitem(ll_row,"id_riga_sorgente",ll_ret)
	     end if
	end if
case "distinta" 
	
	
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
end choose
end event

event getfocus;call super::getfocus;i_dw_corrente=2
end event

event itemchanged;call super::itemchanged;long ll_id_doc, ll_id_art, ll_id_uc, ll_id_titolo, ll_id_prof_doc, ll_id_sog
string  ls_dbc[], ls_dwc[], ls_dbv[],ls_cod_art, ls_des, ls_null
integer li_ok, i
s_ric_param		ls_ric_param
string 	lw_sm, ls_column, ls_colval, ls_tipo_um
decimal ldc_coef_calo, ld_peso_gr, ld_peso_originale



choose case string(dwo.name)
	case "c_articolo_cod"
		
		if ii_finestra_ricerca<>1 then
			select a.id_articolo, a.codice, a.descrizione, u.id_unita_confezione, a.coef_calo,
			um.tipo, a.stato, um.simbolo,
			u.conv_misura_peso, u.dim_l, a.id_titolo
			into :ll_id_art, :ls_ric_param.s_main_value, :ls_ric_param.s_ausil_value[1], :ll_id_uc, :ldc_coef_calo,
			:ls_ric_param.s_ausil_value[14], :ls_ric_param.s_ausil_value[2], :ls_ric_param.s_ausil_value[13],
			:ls_ric_param.s_ausil_value[11], :ls_ric_param.s_ausil_value[10], :ls_ric_param.s_ausil_value[15]
			
			from dba.articolo a, dba.unita_confezione u, dba.unita_misura um
			where a.codice=:data
			and a.id_articolo=u.id_articolo
			and u.unita_base='S'
			and u.id_unita_misura=um.id_unita_misura;
		end if
				
		if isnull(ll_id_art) or ll_id_art=0 then
			
			lw_sm = "w_articolo_coddes_documento_sw"
			ls_ric_param.s_filter_value =data
			ls_ric_param.s_filter_name = "articolo_codice"
			ls_ric_param.metallo=as_metallo
			
			OpenWithParm(w_articolo_coddes_documento_sw, ls_ric_param)
	
			ls_ric_param= Message.PowerObjectParm
			if isvalid(ls_ric_param) then
				if upperbound(ls_ric_param.s_id_seg_value)>0 then
					ll_id_art = long(ls_ric_param.s_id_seg_value[1])
					ll_id_uc=long(ls_ric_param.s_ausil_value[9])
					ldc_coef_calo=dec(ls_ric_param.s_ausil_value[12])
				end if
			end if
		end if
		if ll_id_art> 0 then
			//verifico che il titolo dell'articolo  sia coerente con il profilo
			li_ok=wf_verifica_met_profilo(long(ls_ric_param.s_ausil_value[15]))	  //gli passo il titolo ..
			
			if li_ok=0 then
				setitem(row, "c_articolo_cod", ls_null)
				return 1
			end if
			
			post setitem(row, "c_articolo_cod", ls_ric_param.s_main_value)
			post setitem(row, "riga_documento_id_articolo", ll_id_art)
			post setitem(row, "riga_documento_descrizione", ls_ric_param.s_ausil_value[1])
			post setitem(row, "articolo_stato", ls_ric_param.s_ausil_value[2])
			//post setitem(row, "usimbolo", ls_ric_param.s_ausil_value[3])
			//post setitem(row, "udescrizione", ls_ric_param.s_ausil_value[4])
			//post setitem(row, "unita_misura_b_simbolo", ls_ric_param.s_ausil_value[5])
			//post setitem(row, "unita_misura_b_descrizione", ls_ric_param.s_ausil_value[6])
			//post setitem(row, "conversione_peso_comune", ls_ric_param.s_ausil_value[7])
			//post setitem(row, "conversione_volume_comune", ls_ric_param.s_ausil_value[8])
			post setitem(row, "riga_documento_id_unita_confezione", ll_id_uc)
			post setitem(row, "riga_documento_dim_l", ls_ric_param.s_ausil_value[10])
			post setitem(row, "conv_misura_peso", ls_ric_param.s_ausil_value[11])
			post setitem(row, "coef_calo", ldc_coef_calo)
			//post setitem(row, "unita_misura_c_simbolo_um", ls_ric_param.s_ausil_value[13])
			post setitem(row, "tipo_um", ls_ric_param.s_ausil_value[14])			
			//post setitem(row, "conversione_volume_comune", ls_ric_param.s_ausil_value[15])
			post setitem(row, "id_titolo", long(ls_ric_param.s_ausil_value[15]))	
			ll_id_doc=dw_1.getitemnumber(1, "id_documento")
			//20200826 per id_tab_iva
			wf_gestisci_iva_riga(row)
			post event rowfocuschanged(row)
			post wf_prezzo_galvanica(row, data)
			POST wf_rec_prezzo(row, dec(data), 1, 4, ll_id_doc)
			post setcolumn("quantita")
		end if
	case "prezzo_complessivo" //questo è da riguardare al più presto 07042016
		post setitem(row, "riga_documento_prezzo_netto", dec(data))
	case "prezzo_manifattura" //questo è da riguardare al più presto 07042016
		post setitem(row, "riga_documento_prezzo_netto", dec(data))
	case "riga_documento_peso_lordo", "riga_documento_provv_imp_carea_2"
		ld_peso_gr=dec(data)
		if dwo.name= "riga_documento_provv_imp_carea_2" then
			ld_peso_gr*=0.47  //0.47 è il peso in grammi del singolo laccio
		end if
		ld_peso_originale=getitemdecimal(row, "riga_documento_peso_netto")
		//controllo se la tara è maggiore del peso, se è così non accetto il cambiamento
		if ld_peso_originale - ld_peso_gr >0 then
			dw_2.setitem(row, "riga_documento_peso_netto", ld_peso_originale - ld_peso_gr)
			dw_2.post event itemchanged(row, dw_2.object.riga_documento_peso_netto, string(ld_peso_originale - ld_peso_gr))
		end if
	case "riga_documento_peso_lordo", "riga_documento_peso_netto", "coef_calo", "riga_documento_provv_imp_carea_2"
      post wf_setta_fino_calo(row)
	case "id_gruppo_agenti_2"
		post wf_rec_galvanica(data, row)
		post wf_calcola_prezzo(row)
end choose





end event

event ue_insert;long ll_riga
ll_riga=this.insertrow(al_riga_precedente)
setcolumn("c_articolo_cod")
scrolltorow(ll_riga)
post wf_val_iniziali_riga(ll_riga)

post event ue_initial(ll_riga)
st_des_2_prezzo.text=""
st_des_3_prezzo.text=""

return ll_riga
end event

event ue_initial;call super::ue_initial;long ll_id

wf_art_aut_del_fornitore()

ll_id=dw_1.getitemnumber(1, 1)
if isnull(ll_id)  then  wf_salva_dw(dw_1,dw_2, 1)
ll_id=dw_1.getitemnumber(1, 1)
if ll_id >0 then
	dw_2.setitem(al_riga, "id_documento", ll_id)
	post wf_salva_righe()
else
	messagebox("Errore!", "Impossibile salvare La testata del documento!")
end if


end event

event itemfocuschanged;call super::itemfocuschanged;if dwo.name="forza_chius_evasione" or dwo.name="riga_documento_id_unita_confezione" then
	cb_inserisci.trigger event clicked()
	
end if
end event

event editchanged;call super::editchanged;string ls_dato
if dwo.name= "riga_documento_descrizione" then
	if pos(data, "-|-")<=0 then
		ls_dato=left(data, len(data) - 1)
		ls_dato+="  -|- "
		setitem(row, "riga_documento_descrizione", ls_dato)
		//Send(Handle(this),256,9,Long(0,0))
			keybd_event(35,0,0,0) // TAB Depressed
	
			keybd_event(35,0,2,0) // TAB Released (Can be omitted)
	end if
end if
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id_art

if currentrow>0 then
	ll_id_art=dw_2.getitemnumber(currentrow, "riga_documento_id_articolo")
	if ll_id_art> 0 then
		dw_3.retrieve(ll_id_art)
		wf_rec_des_prezzo(currentrow)
	else
		dw_3.reset()
	end if
end if
end event

event ue_key;if keyflags=2 then
	CHOOSE CASE key
		CASE  KeyF!
			cb_salva.	triggerevent(clicked!)
		CASE KeyI!
			trigger event ue_insert(getrow())
		CASE  keyadd!
			trigger event ue_insert(0)
		CASE KeyD!, keysubtract!
			trigger event ue_delete(getrow())
	END CHOOSE
end if
end event

type rb_nessun_filtro from radiobutton within w_doc_veloce_cx
integer x = 3310
integer y = 748
integer width = 366
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
string text = "Nessun filtro"
end type

event clicked;

if checked then
	
	
	idwc_sog.setfilter("")
	idwc_sog.filter()
	// Populate with values for eastern states
	
	


end if
end event

type rb_solo_cl from radiobutton within w_doc_veloce_cx
integer x = 3310
integer y = 684
integer width = 338
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
string text = "Solo Clienti"
boolean checked = true
end type

event clicked;
string ls_tipo_sog

if checked then
	select pref_cod_cliente
	into :ls_tipo_sog
	from dba.par_sistema
	;
	
	idwc_sog.setfilter("left(codice, 2)='"+ls_tipo_sog+"'")
	idwc_sog.filter()
	// Populate with values for eastern states
	
	


end if
end event

type rb_solo_fo from radiobutton within w_doc_veloce_cx
integer x = 3310
integer y = 616
integer width = 357
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
string text = "Solo fornitori"
end type

event clicked;string ls_tipo_sog

if checked then
	select pref_cod_fornitore
	into :ls_tipo_sog
	from dba.par_sistema
	;
	
	idwc_sog.setfilter("left(codice, 2)='"+ls_tipo_sog+"'")
	idwc_sog.filter()
	// Populate with values for eastern states
	
	


end if
end event

type cb_nuovo from commandbutton within w_doc_veloce_cx
integer x = 3310
integer y = 460
integer width = 343
integer height = 100
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuovo"
end type

event clicked;long ll_riga, ll_id_prof

dw_1.accepttext()
dw_2.accepttext()
post wf_nuovo()

end event

type dw_3 from udw_figlia within w_doc_veloce_cx
integer x = 690
integer y = 2144
integer width = 1842
integer height = 92
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_vedi_note_articolo"
boolean vscrollbar = false
boolean livescroll = false
end type

event doubleclicked;call super::doubleclicked;
	long ll_articolo, ll_temp
nvo_file_list sl_lista_file
integer li_ret
string ls_file_trovato, ls_path

if dwo.name='id_articolo' then
	ll_articolo=getitemnumber(row, "id_articolo")
	if ll_articolo>0 then
		select dir_immagini 
		into :ls_path
		from dba.par_sistema
		;

		sl_lista_file=f_leggi_files(ls_path, false)
	end if
	FOR ll_temp = 1 TO UpperBound( sl_lista_file.as_file )
		 li_ret=pos(sl_lista_file.as_file[ll_temp], string(ll_articolo))
		 if li_ret>0 then
			ls_file_trovato=sl_lista_file.as_file[ll_temp]
			//l'ho trovato ora lo mostro (prima la chiudo fosse aperta ...)
			close(w_mostra_foto)
			openwithparm(w_mostra_foto, ls_file_trovato)
			exit
			
			
		end if
	 NEXT
end if
	
end event

type st_des_2_prezzo from statictext within w_doc_veloce_cx
integer x = 2487
integer y = 2408
integer width = 1257
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_des_3_prezzo from statictext within w_doc_veloce_cx
integer x = 2487
integer y = 2316
integer width = 1257
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

