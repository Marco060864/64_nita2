forward
global type w_azzera_movimenti_wz from w_wiz_main
end type
type dw_7 from udw_001 within w_azzera_movimenti_wz
end type
type cb_1 from commandbutton within w_azzera_movimenti_wz
end type
type tab_1 from tab within w_azzera_movimenti_wz
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from u_dw_ext_main within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from u_dw_main within tabpage_2
end type
type cb_st_cancellazione from commandbutton within tabpage_2
end type
type st_righe_non_cancellate from statictext within tabpage_2
end type
type sle_righe_non_cancellate from singlelineedit within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
cb_st_cancellazione cb_st_cancellazione
st_righe_non_cancellate st_righe_non_cancellate
sle_righe_non_cancellate sle_righe_non_cancellate
end type
type tabpage_3 from userobject within tab_1
end type
type dw_4 from u_dw_ext_main within tabpage_3
end type
type cb_preview from commandbutton within tabpage_3
end type
type cb_stampa from commandbutton within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_4 dw_4
cb_preview cb_preview
cb_stampa cb_stampa
end type
type tabpage_4 from userobject within tab_1
end type
type dw_2 from u_dw_ext_main within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_5 from userobject within tab_1
end type
type dw_5 from datawindow within tabpage_5
end type
type cb_save from commandbutton within tabpage_5
end type
type tabpage_5 from userobject within tab_1
dw_5 dw_5
cb_save cb_save
end type
type tabpage_6 from userobject within tab_1
end type
type dw_6 from udw_000 within tabpage_6
end type
type tabpage_6 from userobject within tab_1
dw_6 dw_6
end type
type tab_1 from tab within w_azzera_movimenti_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
type cbx_controllo from checkbox within w_azzera_movimenti_wz
end type
type cbx_tk from checkbox within w_azzera_movimenti_wz
end type
type cbx_solo_clfo from checkbox within w_azzera_movimenti_wz
end type
type cb_saldi from commandbutton within w_azzera_movimenti_wz
end type
type cb_annulla from commandbutton within w_azzera_movimenti_wz
end type
end forward

global type w_azzera_movimenti_wz from w_wiz_main
integer width = 4475
integer height = 1764
string title = "Azzeramento Movimenti e Ricostruzione Saldi CL/FO"
boolean resizable = false
dw_7 dw_7
cb_1 cb_1
tab_1 tab_1
cbx_controllo cbx_controllo
cbx_tk cbx_tk
cbx_solo_clfo cbx_solo_clfo
cb_saldi cb_saldi
cb_annulla cb_annulla
end type
global w_azzera_movimenti_wz w_azzera_movimenti_wz

type variables
long  il_id_valuta, il_id_esercizio
date idt_data_doc
long  il_id_conto
long  il_id_prima_saldi  //20261127 ultimo id_documento prima dei documenti di saldo (compensazione del magazzino)
end variables

forward prototypes
public function string uf_controlla_dati ()
public function date uf_prossimo_mese (readonly date data_attuale)
public subroutine wf_azzera (s_param_articoli str_param)
public function integer wf_crea_doc (s_ricostruisci_saldi as_saldi)
public function integer wf_creo_righe (s_ricostruisci_saldi as_saldi)
public function integer wf_ricostruisci_saldi (s_param_articoli str_param)
public function integer wf_ges_ap_partita (s_param_articoli str_param)
public subroutine wf_riempi_causali (integer al_righe)
public function long wf_cerca_causale (decimal as_saldo_fino, decimal as_saldo_lire, STRING AS_FLAG)
public function integer wf_riapri_partite (s_param_articoli str_param)
public function integer wf_new_ric_saldo (s_param_articoli str_param)
public function integer wf_doc_saldo (long al_id_sog, long al_id_caus, long al_id_riga_orig, decimal adc_qta, string as_num_orig, date ad_data_orig, long al_id_tipo_partita)
public function integer wf_doc_testata (long al_id_sog, long al_id_caus, string as_num_doc, date ad_data_prev, ref long al_id_doc, ref long al_loc_1, ref long al_loc_2)
public function integer wf_saldi_magazzino (s_param_articoli str_param)
public function integer wf_new_crea_doc (s_ricostruisci_saldi as_saldi)
public function string wf_scegli_causale_e_profilo (string as_cod_partita)
public subroutine wf_new_crea_righe (s_ricostruisci_saldi as_saldi)
end prototypes

public function string uf_controlla_dati ();


string ls_tipo_registro,ls_flag_registri,ls_filtro,ls_flag_definitiva,ls_ret,ls_st_reg_iva,ls_st_reg2_iva
long ll_row,ll_n_registro
date ld_dalla_data,ld_alla_data

ll_row=tab_1.tabpage_1.dw_1.getrow()
ls_tipo_registro=tab_1.tabpage_1.dw_1.getitemstring(ll_row,"tipo_registro")
ld_dalla_data=tab_1.tabpage_1.dw_1.getitemdate(ll_row,"dalla_data")
ld_alla_data=tab_1.tabpage_1.dw_1.getitemdate(ll_row,"alla_data")
ls_flag_registri=tab_1.tabpage_1.dw_1.getitemstring(ll_row,"tutti_reg")
ll_n_registro=tab_1.tabpage_1.dw_1.getitemnumber(ll_row,"numero_registro")
ls_flag_definitiva=tab_1.tabpage_1.dw_1.getitemstring(ll_row,"elab_prova")




ls_ret='OK'
if ls_flag_registri='N' then
	
DECLARE ws_registri_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and  
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri_iva_cur;

FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri_iva_cur;


DECLARE ws_registri2_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         ( "ws_registri_iva"."numero" = :ll_n_registro  ) and 
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri2_iva_cur ;

FETCH ws_registri2_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri2_iva_cur;
return ls_ret
else
	
	
	
	
	
DECLARE ws_registri3_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri3_iva_cur;

FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri3_iva_cur INTO :ls_st_reg_iva;
LOOP

CLOSE ws_registri3_iva_cur;


DECLARE ws_registri4_iva_cur CURSOR FOR
  SELECT "ws_registri_iva"."st_reg_iva_a"  
    FROM "ws_registri_iva",   
           
   WHERE ( "ws_registri_iva"."tipo_registro" = :ls_tipo_registro ) and  
         
         ( "ws_registri_iva"."data_registrazione" >= :ld_dalla_data  ) and  
         ( "ws_registri_iva"."data_registrazione" <= :ld_alla_data ); 
         

OPEN ws_registri4_iva_cur ;

FETCH ws_registri4_iva_cur  INTO :ls_st_reg2_iva;

DO WHILE sqlca.sqlcode=0
	IF ls_st_reg2_iva<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_registri2_iva_cur INTO :ls_st_reg2_iva;
LOOP

CLOSE ws_registri4_iva_cur;
return ls_ret
end if

end function

public function date uf_prossimo_mese (readonly date data_attuale);integer mese,anno,day,giorni_mese
date nuova_data
anno=year(data_attuale)
mese=month(data_attuale)
if mese=12 then
	mese=1
	anno=anno+1
else
mese=mese+1
end if
day=day(data_attuale)


giorni_mese=f_gmese(mese,anno)
if day>giorni_mese then
	day=giorni_mese
end if

nuova_data=date(string(day)+"/"+string(mese)+"/"+string(anno))
return nuova_data
end function

public subroutine wf_azzera (s_param_articoli str_param);integer i,a, li_test, q, li_riga_da_cancellare,li_ret, li_conta_errori
long ll_righe, ll_pippo
long ll_da, ll_blocco, ll_k   //20261126b cancellazione a blocchi
string ls_data_obj[]

update scadenza, documento, caus_magazzino, sog_commerciale
set esito_pagamento='E'
where  ( "documento"."id_caus_magazzino" = "caus_magazzino"."id_caus_magazzino" ) and  
         ( "sog_commerciale"."id_sog_commerciale" = "documento"."id_sog_commerciale" ) and  
         ( "scadenza"."id_documento" = "documento"."id_documento" ) and  
         ( ( "caus_magazzino"."codice" >= :str_param.da_CATEGORIA ) AND  
         ( "caus_magazzino"."codice" <= :str_param.a_CATEGORIA) AND  
         ("documento"."data_documento" >= :str_param.da_data AND  
         "documento"."data_documento" <= :str_param.a_data OR  
         "documento"."data_documento" is null) AND  
         "sog_commerciale"."codice" >= :str_param.da_sog_comm AND  
         "sog_commerciale"."codice" <= :str_param.a_sog_comm ) AND  
         "scadenza"."esito_pagamento" <> 'E'    
			;
if sqlca.sqlcode<0 then
	messagebox("Errore!", "Potrebbero esserci problemi con l'esito delle scadenze!")
	rollback;
else
	commit;
end if
if cbx_controllo.checked then li_test=1
ls_data_obj[1]="d_doc_senza_data"
ls_data_obj[2]="d_canc_scar_partite"
ls_data_obj[3]="d_canc_car_partite2"
ls_data_obj[4]="d_cancella_righe2"
ls_data_obj[5]="d_canc_cpt_doc"
ls_data_obj[6]="d_canc_iva_doc"
ls_data_obj[7]="d_cancella_documenti2"
tab_1.selecttab(2)

for a= 1 to 7
	if a=1 then
		tab_1.tabpage_2.dw_3.dataobject=ls_data_obj[a]
		tab_1.tabpage_2.dw_3.settransobject(sqlca)
		ll_righe=tab_1.tabpage_2.dw_3.retrieve()
		if ll_righe>0 then
			messagebox("Attenzione!","Potrebbero esistere documenti con data non valorizzata!")
		end if
		continue
	end if
	if li_conta_errori>0 then
//		if messagebox("Attenzione!","Ci sono righe non cancellate: vuoi interrompere la cancellazione?", STOPSIGN!,YESNO!)=1 then
//			exit
//		end if
		li_conta_errori=0
	end if
	tab_1.tabpage_2.dw_3.dataobject=ls_data_obj[a]
	tab_1.tabpage_2.dw_3.settransobject(sqlca)
	ll_righe=tab_1.tabpage_2.dw_3.retrieve(str_param.da_data, str_param.a_data, &
						str_param.da_sog_comm, str_param.a_sog_comm, &
							str_param.da_CATEGORIA, str_param.a_CATEGORIA)
	if ll_righe>0 then
		if li_test=1 then
			i=messagebox("Attenzione!", "Selezionati "+string(ll_righe)+" da cancellare. Continuare?", stopsign!, yesno!)
		else
			i=1
		end if
		IF i=1 then
			//20261126b cancellazione a blocchi di 500 righe con un commit per blocco (prima: una riga, un update e un commit
			//alla volta: lentissimo). Se il blocco non passa: rollback e quel blocco si rifa una riga alla volta come prima;
			//le righe che non si cancellano restano in cima alla lista (sle_righe_non_cancellate = quante sono)
			tab_1.tabpage_2.dw_3.setredraw(false)
			ll_da = 1
			do while tab_1.tabpage_2.dw_3.rowcount() >= ll_da
				ll_blocco = tab_1.tabpage_2.dw_3.rowcount() - ll_da + 1
				if ll_blocco > 500 then ll_blocco = 500
				tab_1.tabpage_2.dw_3.rowsmove(ll_da, ll_da + ll_blocco - 1, primary!, tab_1.tabpage_2.dw_3, 1, delete!)
				if tab_1.tabpage_2.dw_3.update() = 1 then
					commit;
				else
					rollback;
					tab_1.tabpage_2.dw_3.rowsmove(1, tab_1.tabpage_2.dw_3.deletedcount(), delete!, tab_1.tabpage_2.dw_3, ll_da, primary!)
					for ll_k = 1 to ll_blocco
						tab_1.tabpage_2.dw_3.rowsmove(ll_da, ll_da, primary!, tab_1.tabpage_2.dw_3, 1, delete!)
						if tab_1.tabpage_2.dw_3.update() = 1 then
							commit;
						else
							rollback;
							li_conta_errori++
							tab_1.tabpage_2.dw_3.rowsmove(1, 1, delete!, tab_1.tabpage_2.dw_3, ll_da, primary!)
							ll_da++
						end if
					next
					tab_1.tabpage_2.sle_righe_non_cancellate.text = string(ll_da - 1)
				end if
			loop
			tab_1.tabpage_2.dw_3.setredraw(true)
			end if
		else
			
		end if
next

end subroutine

public function integer wf_crea_doc (s_ricostruisci_saldi as_saldi);long ll_id_articolo, ll_id_prof_doc, ll_id_caus, ll_riga, ll_id_reg, ll_num_prog

string ls_tipo_partita
datetime ldt_data_ora_creazione
integer li_ret


ldt_data_ora_creazione=datetime(idt_data_doc,now())

ll_id_caus=as_saldi.id_caus_magazzino

select min(id_prof_documento)
into :ll_id_prof_doc
from prof_documento
where id_caus_magazzino_prop=:ll_id_caus;

if sqlca.sqlcode<>0 or isnull(ll_id_prof_doc) then 
	messagebox("Errore!", "Non esiste un profilo per la causale selezionata! ("+string(ll_id_caus)+")"+&
	+"~r~nInserire il profilo prima di usare la procedura!")
	return -1
end if

select id_magazzino_1_prop, id_magazzino_2_prop, id_locazione_1_prop,id_locazione_2_prop
into :as_saldi.id_mag_1, :as_saldi.id_mag_2,:as_saldi.id_loc_1,:as_saldi.id_loc_2
from prof_documento
where id_prof_documento=:ll_id_prof_doc;


ll_id_reg=tab_1.tabpage_1.dw_1.getitemnumber(1, "id_registro")


if ll_id_reg>0 then
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	where id_registro=:ll_id_reg;
	if isnull(ll_num_prog) then ll_num_prog=0
	ll_num_prog++
else
	messagebox("Errore!", "Registro non trovato")
	return -1 
end if
if cbx_tk.checked then
	as_saldi.num_doc=string(ll_num_prog)
	as_saldi.data_doc=idt_data_doc
end if

INSERT INTO documento (id_prof_documento, id_registro,&
				num_progressivo, data_registrazione, num_documento, data_documento,&
				data_prev_consegna,&
				id_sog_commerciale, id_caus_magazzino, id_magazzino,id_magazzino_2,
				id_locazione_1,id_locazione_2,
				id_valuta, data_ora_creazione, cambio)
	VALUES (:ll_id_prof_doc, :ll_id_reg, :ll_num_prog, :idt_data_doc, :as_saldi.num_doc, :idt_data_doc, &
				:as_saldi.data_doc,&
				:as_saldi.id_sog, :ll_id_caus, 
				:as_saldi.id_mag_1, :as_saldi.id_mag_2,:as_saldi.id_loc_1,:as_saldi.id_loc_2,
				:il_id_valuta, :ldt_data_ora_creazione, 1);
if sqlca.sqlcode=0 then
	//20261126b niente commit qui: lo fa wf_creo_righe con la riga (se la riga fallisce, il rollback toglie anche il documento: prima restavano documenti vuoti)
	as_saldi.num_riga=1
	as_saldi.id_caus_magazzino=ll_id_caus
   sqlca.identity(as_saldi.id_doc)
	li_ret=wf_creo_righe(as_saldi)
	if li_ret<>1 then return -1
else
	rollback;
	messagebox("Errore", "Documento non inserito")
	return -1
end if

return 1  







end function

public function integer wf_creo_righe (s_ricostruisci_saldi as_saldi);decimal ld_prezzo, ld_prezzo_met, ld_prezzo_man, ld_peso_netto,ld_fino_per_prezzo
decimal ld_imp_man, ld_imp_met
long ll_id_articolo, ll_riga, ll_righe_tot, ll_id_UC, ll_id_tab_iva
long ll_id_caus_mag
string ls_des_articolo, ls_flag
string ls_art_msg  //20261126b
integer i=1

if as_saldi.articolo<='' then
	ll_righe_tot=tab_1.tabpage_4.dw_2.rowcount()
	ll_riga=tab_1.tabpage_4.dw_2.find("metallo="+string(as_saldi.id_metallo),1, ll_righe_tot)
	if ll_riga>0 then
		ll_id_articolo=tab_1.tabpage_4.dw_2.getitemnumber(ll_riga, "id_articolo")
		ls_des_articolo=tab_1.tabpage_4.dw_2.getitemstring(ll_riga, "des_articolo")
		if isnull(ll_id_articolo) then
			tab_1.selecttab(4)
			messagebox("Errore!", "Articolo per metallo non valorizzato: riga "+string(ll_riga))
			rollback; //20261126b
			return -1
		end if
	else
		messagebox("Errore!", "Inserire riga per metallo! (metallo "+string(as_saldi.id_metallo)+")")
		rollback; //20261126b
		return -1
	end if
else
	select id_articolo, descrizione
	into :ll_id_articolo, :ls_des_articolo
	from articolo
	where codice=:as_saldi.articolo;
end if
select id_unita_confezione
into :ll_id_UC
from unita_confezione
where id_articolo=:ll_id_articolo
and unita_base='S';
if sqlca.sqlcode<>0 then
	ls_art_msg = ""  //20261126b niente NULL nel messaggio
	if not isnull(ll_id_articolo) then ls_art_msg = string(ll_id_articolo)
	if not isnull(as_saldi.articolo) then ls_art_msg = ls_art_msg + " (" + as_saldi.articolo + ")"
	messagebox("Errore!", "Unita~' confezione base non trovata per l~'articolo " + ls_art_msg)
	rollback; //20261126b
	return -1
end if
SELECT "tab_iva"."id_tab_iva"
INTO  :ll_id_tab_iva
FROM "dba"."sog_commerciale", "dba"."tab_iva"  
WHERE ( "tab_iva"."id_tab_iva" = "sog_commerciale"."id_tab_iva" ) and  
		( ( "sog_commerciale"."id_sog_commerciale" = :as_saldi.id_sog ) ) ;

if sqlca.sqlcode<>0 then
	
	SELECT "articolo"."id_tab_iva"  
	INTO :ll_id_tab_iva  
	FROM "dba"."articolo"
	WHERE "articolo"."id_articolo" = :ll_id_articolo ;
	if sqlca.sqlcode<>0 then
			
		SELECT "cat_com_articolo"."id_tab_iva"  
		INTO :ll_id_tab_iva  
		FROM "dba"."articolo",   
		"cat_com_articolo"  
		WHERE ( "cat_com_articolo"."id_cat_com_articolo" = "articolo"."id_cat_com_articolo" ) and  
		( ( "articolo"."id_articolo" = :ll_id_articolo ) )   ;
	end if
end if


as_saldi.qta=abs(as_saldi.qta)

if as_saldi.totale_lire_az <0 then
	as_saldi.totale_lire_az=abs(as_saldi.totale_lire_az)
	
	
	
	
	
	if as_saldi.imp_met<=0 then	
		as_saldi.imp_met=as_saldi.imp_met* -1
	else 
		ll_riga=tab_1.tabpage_5.dw_5.find&
		("orafo_caus_saldi_id_caus_magazzino="+string(as_saldi.id_caus_magazzino), 1, 8)
		if ll_riga>0 then 
			ls_flag=tab_1.tabpage_5.dw_5.getitemstring(ll_riga, 'flag')
			if ls_flag='C' then 
				ll_riga=tab_1.tabpage_5.dw_5.find&
				("lire_vero='+'", 1, 8)
			else 
				ll_riga=tab_1.tabpage_5.dw_5.find&
				("lire_vero='C'", 1, 8)
			end if
			if ll_riga>0 then 
				ll_id_caus_mag=tab_1.tabpage_5.dw_5.getitemnumber(ll_riga, "orafo_caus_saldi_id_caus_magazzino")
				
				
				ld_imp_met=	as_saldi.imp_met
				
				as_saldi.imp_met=0
				
				as_saldi.totale_lire_az =ABS(as_saldi.imp_man)
			end if
		end if
	end if
	
	if as_saldi.imp_man<0 then 
		as_saldi.imp_man=as_saldi.imp_man* -1
	else 
		ll_riga=tab_1.tabpage_5.dw_5.find&
		("orafo_caus_saldi_id_caus_magazzino="+string(as_saldi.id_caus_magazzino), 1, 8)
		if ll_riga>0 then 
			ls_flag=tab_1.tabpage_5.dw_5.getitemstring(ll_riga, 'flag')
			if ls_flag='C' then 
				ll_riga=tab_1.tabpage_5.dw_5.find&
				("lire_vero='+'", 1, 8)
			else 
				ll_riga=tab_1.tabpage_5.dw_5.find&
				("lire_vero='C'", 1, 8)
			end if
			if ll_riga>0 then 
				ll_id_caus_mag=tab_1.tabpage_5.dw_5.getitemnumber(ll_riga, "orafo_caus_saldi_id_caus_magazzino")
				
				
				ld_imp_man=	as_saldi.imp_man
				
				as_saldi.imp_man=0
				
				as_saldi.totale_lire_az =ABS(as_saldi.imp_met)
			end if
		end if
	end if
else
	
	
	
	
	
	if as_saldi.imp_met<=0 then	
		as_saldi.imp_met=as_saldi.imp_met* -1
	
		ll_riga=tab_1.tabpage_5.dw_5.find&
		("orafo_caus_saldi_id_caus_magazzino="+string(as_saldi.id_caus_magazzino), 1, 8)
		if ll_riga>0 then 
			ls_flag=tab_1.tabpage_5.dw_5.getitemstring(ll_riga, 'flag')
			if ls_flag='C' then 
				ll_riga=tab_1.tabpage_5.dw_5.find&
				("lire_vero='-'", 1, 8)
			else 
				ll_riga=tab_1.tabpage_5.dw_5.find&
				("lire_vero='S'", 1, 8)
			end if
			if ll_riga>0 then 
				ll_id_caus_mag=tab_1.tabpage_5.dw_5.getitemnumber(ll_riga, "orafo_caus_saldi_id_caus_magazzino")
				
				
				ld_imp_met=	as_saldi.imp_met
				
				as_saldi.imp_met=0
				
				as_saldi.totale_lire_az =ABS(as_saldi.imp_man)
			end if
		end if
	end if
	
	if as_saldi.imp_man<0 then 
		as_saldi.imp_man=as_saldi.imp_man* -1
 
		ll_riga=tab_1.tabpage_5.dw_5.find&
		("orafo_caus_saldi_id_caus_magazzino="+string(as_saldi.id_caus_magazzino), 1, 8)
		if ll_riga>0 then 
			ls_flag=tab_1.tabpage_5.dw_5.getitemstring(ll_riga, 'flag')
			if ls_flag='C' then 
				ll_riga=tab_1.tabpage_5.dw_5.find&
				("lire_vero='-'", 1, 8)
			else 
				ll_riga=tab_1.tabpage_5.dw_5.find&
				("lire_vero='S'", 1, 8)
			end if
			if ll_riga>0 then 
				ll_id_caus_mag=tab_1.tabpage_5.dw_5.getitemnumber(ll_riga, "orafo_caus_saldi_id_caus_magazzino")
				
				
				ld_imp_man=	as_saldi.imp_man
				
				as_saldi.imp_man=0
				
				as_saldi.totale_lire_az =ABS(as_saldi.imp_met)
			end if
		end if
	end if
end if





		
	if as_saldi.qta<=0 or isnull(as_saldi.qta) then as_saldi.qta=1
	ld_prezzo=as_saldi.totale_lire_az/as_saldi.qta
	
	ld_peso_netto=as_saldi.fino+as_saldi.calo
	
	ld_peso_netto=abs(ld_peso_netto)
	if (as_saldi.fino + as_saldi.calo)<0 then
		as_saldi.fino=as_saldi.fino* -1			
		as_saldi.calo=	as_saldi.calo* -1
	end if
	
	
	IF ld_peso_netto<abs(as_saldi.fino) THEN
		ld_peso_netto=ld_peso_netto + ABS(as_saldi.calo)
	END IF
		
	
	
	ld_fino_per_prezzo=as_saldi.fino+as_saldi.calo
	if ld_fino_per_prezzo=0 then ld_fino_per_prezzo=1
	ld_prezzo_met=abs(as_saldi.imp_met/ld_fino_per_prezzo)
	ld_prezzo_man=abs(as_saldi.imp_man/ld_fino_per_prezzo)
	
	insert into riga_documento
	(id_documento, id_unita_confezione, num_riga, id_articolo, descrizione, quantita,
	qta_un_base, id_caus_magazzino, id_locazione_1, id_locazione_2, id_valuta, cambio, 
	prezzo, prezzo_netto,
	peso_netto, id_tab_iva, tot_riga_val_riga, tot_riga_val_doc, tot_riga_val_az, 
	id_conto, id_azienda, coef_calo, calo, fino, prezzo_metallo, prezzo_manifattura, 
	importo_manifattura, importo_manifattura_val,
	fat_con_unita_base, fat_con_globale, sconto, da_stampare, forza_chius_evasione, sospesa)
	values 
	(:as_saldi.id_doc, :ll_id_UC, :as_saldi.num_riga, :ll_id_articolo, :ls_des_articolo, :as_saldi.qta,
	:as_saldi.qta, :as_saldi.id_caus_magazzino, :as_saldi.id_loc_1,:as_saldi.id_loc_2, :il_id_valuta,1,
	:ld_prezzo, :ld_prezzo,
	:ld_peso_netto, :ll_id_tab_iva, :as_saldi.totale_lire_az, :as_saldi.totale_lire_az, :as_saldi.totale_lire_az,
	:il_id_conto, 1, 1000, :as_saldi.calo, :as_saldi.fino, :ld_prezzo_met, :ld_prezzo_man,
	:as_saldi.imp_man, :as_saldi.imp_man,
	1, 1, 0, 'N','N', 'S');
	if sqlca.sqlcode<>0 then
		messagebox("Errore!", "wf_creo_riga:Riga documento non creata~r~n" + sqlca.sqlerrtext)  //20261126c
		rollback;
		return -1
	else
		//20261126c tutto o niente: commit solo alla fine di wf_ricostruisci_saldi
	end if

if ld_imp_met>0 or ld_imp_man>0 then 
	as_saldi.num_riga++ 
	
	as_saldi.id_caus_magazzino=ll_id_caus_mag
	
	as_saldi.fino=0
	as_saldi.calo=0
	ld_prezzo_met=0
	ld_prezzo_man=0
	
	ld_peso_netto=0
	if ld_imp_met>0 then
		
		as_saldi.totale_lire_az=ld_imp_met
		
		ld_prezzo=ld_imp_met
		
		as_saldi.imp_man=0
	else
		
		as_saldi.totale_lire_az=ld_imp_man
		
		ld_prezzo=ld_imp_man
		
		as_saldi.imp_man=ld_imp_man
	end if
	
	insert into riga_documento
	(id_documento, id_unita_confezione, num_riga, id_articolo, descrizione, quantita,
	qta_un_base, id_caus_magazzino, id_locazione_1, id_locazione_2, id_valuta, cambio, 
	prezzo, prezzo_netto,
	peso_netto, id_tab_iva, tot_riga_val_riga, tot_riga_val_doc, tot_riga_val_az, 
	id_conto, id_azienda, coef_calo, calo, fino, prezzo_metallo, prezzo_manifattura, 
	importo_manifattura, importo_manifattura_val,
	fat_con_unita_base, fat_con_globale, sconto, da_stampare, forza_chius_evasione, sospesa)
	values 
	(:as_saldi.id_doc, :ll_id_UC, :as_saldi.num_riga, :ll_id_articolo, :ls_des_articolo, 
	:as_saldi.qta,
	:as_saldi.qta, :as_saldi.id_caus_magazzino, :as_saldi.id_loc_1,:as_saldi.id_loc_2, :il_id_valuta,1,
	:ld_prezzo, :ld_prezzo,
	:ld_peso_netto, :ll_id_tab_iva, :as_saldi.totale_lire_az, :as_saldi.totale_lire_az, 
	:as_saldi.totale_lire_az,
	:il_id_conto, 1, 1000, :as_saldi.calo, :as_saldi.fino, :ld_prezzo_met, :ld_prezzo_man,
	:as_saldi.imp_man, :as_saldi.imp_man,
	1, 1, 0, 'N','N', 'S');
	if sqlca.sqlcode<>0 then
		messagebox("Errore!", "wf_creo_riga:Riga documento non creata~r~n" + sqlca.sqlerrtext)  //20261126c
		rollback;
		return -1
	else
		//20261126c tutto o niente: commit solo alla fine di wf_ricostruisci_saldi
	end if

end if

return 1
end function

public function integer wf_ricostruisci_saldi (s_param_articoli str_param);
datastore ds_saldi
long ll_righe, ll_id_doc
long ll_breakrow, ll_old_id_sog, ll_old_caus
s_ricostruisci_saldi s_saldi, s_azzera
integer li_ret
string ls_tipo_partita,  ls_rag

s_saldi.contabilizzati=tab_1.tabpage_1.dw_1.getitemstring(1, "contabilizzati")
if isnull(s_saldi.contabilizzati) then s_saldi.contabilizzati='N'

long ll_id_prima, ll_num_riga  //20261126b
string ls_art
//20261126b documenti creati da questo giro = id oltre l ultimo che c era prima
select max(id_documento) into :ll_id_prima from documento;
if isnull(ll_id_prima) then ll_id_prima = 0

ds_saldi=create datastore
if cbx_tk.checked then
	ds_saldi.dataobject="d_or_saldi_tk"
else
	ds_saldi.dataobject="d_or_saldi"
end if

ds_saldi.settransobject(sqlca)
ll_righe=ds_saldi.retrieve(str_param.da_data, str_param.a_data, &
							str_param.da_sog_comm, str_param.a_sog_comm, &
							str_param.da_CATEGORIA, str_param.a_CATEGORIA)
							
if ll_righe>0 then
	tab_1.tabpage_3.dw_4.reset()
	tab_1.selecttab(3)
	ll_breakrow = 1
	DO 
		s_saldi=s_azzera
		ll_old_caus=s_saldi.id_caus_magazzino
		ll_old_id_sog=s_saldi.id_sog
		s_saldi.id_sog=ds_saldi.GetItemNumber(ll_breakrow, "id_sog_commerciale")
		s_saldi.id_metallo=	ds_saldi.GetItemNumber(ll_breakrow, "id_metallo")
		s_saldi.calo=ds_saldi.GetItemdecimal(ll_breakrow, "calo")
		s_saldi.fino=ds_saldi.GetItemdecimal(ll_breakrow, "fino")
		s_saldi.imp_man= ds_saldi.GetItemdecimal(ll_breakrow, "imp_man")
		s_saldi.imp_met=ds_saldi.GetItemdecimal(ll_breakrow, "imp_met")
		s_saldi.totale_lire_az=ds_saldi.GetItemdecimal(ll_breakrow, "totale_lire")
		s_saldi.tipo_partita=ds_saldi.GetItemstring(ll_breakrow, "cod_partita")
		s_saldi.qta=ds_saldi.GetItemdecimal(ll_breakrow, "sum_qta")
		s_saldi.id_caus_magazzino=ds_saldi.GetItemNumber(ll_breakrow,"caus_magazzino_id_caus_magazzino")
		if not(cbx_tk.checked) then
			s_saldi.articolo=ds_saldi.GetItemstring(ll_breakrow, "articolo_codice")
			
		end if
		
		
		
		
		if abs(s_saldi.fino+s_saldi.calo)>=0.1 or s_saldi.totale_lire_az<>0 then
			li_ret=tab_1.tabpage_3.dw_4.insertrow(0)
			tab_1.tabpage_3.dw_4.setitem(li_ret, "saldoau" , s_saldi.calo+s_saldi.fino)
			tab_1.tabpage_3.dw_4.setitem(li_ret, "id_metallo" , s_saldi.id_metallo)
			tab_1.tabpage_3.dw_4.setitem(li_ret, "saldolire" ,s_saldi.totale_lire_az)
			tab_1.tabpage_3.dw_4.setitem(li_ret, "tipo" , s_saldi.tipo_partita)
			
			tab_1.tabpage_3.dw_4.setitem(li_ret, "articolo" , s_saldi.articolo)
			select rag_soc_1 into :ls_rag
			from sog_commerciale_gen
			where id_sog_commerciale=:s_saldi.id_sog;
			tab_1.tabpage_3.dw_4.setitem(li_ret, "sog_com" , ls_rag)
			
			if cbx_tk.checked then
				s_saldi.id_caus_magazzino=wf_cerca_causale(s_saldi.calo+s_saldi.fino, s_saldi.totale_lire_az, 'C')
			end if
			tab_1.tabpage_3.dw_4.setitem(li_ret, "id_caus" , s_saldi.id_caus_magazzino)
			
			
			
			//20261126b prima ll_old_id_sog e ll_old_caus si leggevano DOPO s_saldi=s_azzera (sempre vuoti) e ogni articolo
			//apriva un documento suo (Labella: 13.896 documenti di una riga). Ora la riga va nel documento gia creato in questo
			//giro con lo stesso soggetto e causale e (senza tk) lo stesso documento originale: numero in num_documento e data in
			//data_prev_consegna restano quelli dell originale (decisione utente 26/11)
			if not(cbx_tk.checked) then
				s_saldi.num_doc=ds_saldi.GetItemstring(ll_breakrow, "documento_num_documento")
				s_saldi.data_doc=ds_saldi.GetItemdate(ll_breakrow, "documento_data_documento")
			end if
			setnull(ll_id_doc)
			if cbx_tk.checked then
				select max(id_documento) into :ll_id_doc from documento
				where id_documento > :ll_id_prima and id_sog_commerciale = :s_saldi.id_sog
				and id_caus_magazzino = :s_saldi.id_caus_magazzino and data_documento = :idt_data_doc;
			else
				select max(id_documento) into :ll_id_doc from documento
				where id_documento > :ll_id_prima and id_sog_commerciale = :s_saldi.id_sog
				and id_caus_magazzino = :s_saldi.id_caus_magazzino and data_documento = :idt_data_doc
				and num_documento = :s_saldi.num_doc and data_prev_consegna = :s_saldi.data_doc;
			end if
			if ll_id_doc > 0 then
				s_saldi.id_doc = ll_id_doc
				//20261126c locazioni come in wf_crea_doc (dal profilo del documento): senza, la riga andava con locazione 0 e non si inseriva
				select p.id_locazione_1_prop, p.id_locazione_2_prop into :s_saldi.id_loc_1, :s_saldi.id_loc_2
				from documento d, prof_documento p where p.id_prof_documento = d.id_prof_documento and d.id_documento = :ll_id_doc;
				setnull(ll_num_riga)
				select max(num_riga) into :ll_num_riga from riga_documento where id_documento = :ll_id_doc;
				if isnull(ll_num_riga) then ll_num_riga = 0
				s_saldi.num_riga = ll_num_riga + 1
				li_ret = wf_creo_righe(s_saldi)
			else
				s_saldi.num_riga = 1
				li_ret = wf_crea_doc(s_saldi)
			end if
			if li_ret<>1 then 
				rollback;  //20261126c tutto o niente: si toglie tutto quello creato in questo giro
				ls_art = s_saldi.articolo  //20261126b soggetto e articolo nel messaggio
				if isnull(ls_art) then ls_art = ""
				if isnull(ls_rag) then ls_rag = ""
				messagebox("Errore!", "Saldi non ricostruiti! Operazione interrotta: non e~' stato salvato niente.~r~nSoggetto: "+ls_rag+" ("+string(s_saldi.id_sog)+")~r~nArticolo: "+ls_art)
				return -1
			end if
		end if
		
		ll_breakrow = ll_breakrow + 1
		ll_breakrow = ds_saldi.FindGroupChange(ll_breakrow, 2)
	LOOP WHILE ll_breakrow>0
	
	
	//questa è un'altra storia (qui è finita la ricostruzione effettiva, comincia quella alternativa)
	if cbx_tk.checked and not(cbx_solo_clfo.checked) then
		//20261126b documenti di questo secondo giro: separati da quelli del primo
		select max(id_documento) into :ll_id_prima from documento;
		ll_breakrow = 1
		do
			s_saldi=s_azzera
			ll_old_caus=s_saldi.id_caus_magazzino
			ll_old_id_sog=s_saldi.id_sog
			s_saldi.id_sog=ds_saldi.GetItemNumber(ll_breakrow, "id_sog_commerciale")
			s_saldi.id_metallo=	ds_saldi.GetItemNumber(ll_breakrow, "id_metallo")
			s_saldi.calo=ds_saldi.GetItemdecimal(ll_breakrow, "som_calo")
			s_saldi.fino=ds_saldi.GetItemdecimal(ll_breakrow, "som_fino")
			s_saldi.imp_man= ds_saldi.GetItemdecimal(ll_breakrow, "som_imp_man")
			s_saldi.imp_met=ds_saldi.GetItemdecimal(ll_breakrow, "som_imp_met")
			s_saldi.totale_lire_az=ds_saldi.GetItemdecimal(ll_breakrow, "som_tot")
			s_saldi.tipo_partita=ds_saldi.GetItemstring(ll_breakrow, "cod_partita")
			s_saldi.qta=ds_saldi.GetItemdecimal(ll_breakrow, "som_qta_1")
			s_saldi.id_caus_magazzino=wf_cerca_causale(s_saldi.calo+s_saldi.fino, s_saldi.totale_lire_az, 'M')	
			
			if abs(s_saldi.fino+s_saldi.calo)>=0.1 or s_saldi.totale_lire_az<>0 then
				li_ret=tab_1.tabpage_3.dw_4.insertrow(0)
				tab_1.tabpage_3.dw_4.setitem(li_ret, "saldoau" , s_saldi.calo+s_saldi.fino)
				tab_1.tabpage_3.dw_4.setitem(li_ret, "id_metallo" , s_saldi.id_metallo)
				tab_1.tabpage_3.dw_4.setitem(li_ret, "saldolire" ,s_saldi.totale_lire_az)
				tab_1.tabpage_3.dw_4.setitem(li_ret, "tipo" , s_saldi.tipo_partita)
				tab_1.tabpage_3.dw_4.setitem(li_ret, "id_caus" , s_saldi.id_caus_magazzino)
							
				select rag_soc_1 into :ls_rag
				from sog_commerciale_gen
				where id_sog_commerciale=:s_saldi.id_sog;
				tab_1.tabpage_3.dw_4.setitem(li_ret, "sog_com" , ls_rag)
				
				
				//20261126b prima ll_old_id_sog e ll_old_caus si leggevano DOPO s_saldi=s_azzera (sempre vuoti) e ogni articolo
				//apriva un documento suo (Labella: 13.896 documenti di una riga). Ora la riga va nel documento gia creato in questo
				//giro con lo stesso soggetto e causale e (senza tk) lo stesso documento originale: numero in num_documento e data in
				//data_prev_consegna restano quelli dell originale (decisione utente 26/11)
				setnull(ll_id_doc)
				if cbx_tk.checked then
					select max(id_documento) into :ll_id_doc from documento
					where id_documento > :ll_id_prima and id_sog_commerciale = :s_saldi.id_sog
					and id_caus_magazzino = :s_saldi.id_caus_magazzino and data_documento = :idt_data_doc;
				else
					select max(id_documento) into :ll_id_doc from documento
					where id_documento > :ll_id_prima and id_sog_commerciale = :s_saldi.id_sog
					and id_caus_magazzino = :s_saldi.id_caus_magazzino and data_documento = :idt_data_doc
					and num_documento = :s_saldi.num_doc and data_prev_consegna = :s_saldi.data_doc;
				end if
				if ll_id_doc > 0 then
					s_saldi.id_doc = ll_id_doc
					//20261126c locazioni come in wf_crea_doc (dal profilo del documento): senza, la riga andava con locazione 0 e non si inseriva
					select p.id_locazione_1_prop, p.id_locazione_2_prop into :s_saldi.id_loc_1, :s_saldi.id_loc_2
					from documento d, prof_documento p where p.id_prof_documento = d.id_prof_documento and d.id_documento = :ll_id_doc;
					setnull(ll_num_riga)
					select max(num_riga) into :ll_num_riga from riga_documento where id_documento = :ll_id_doc;
					if isnull(ll_num_riga) then ll_num_riga = 0
					s_saldi.num_riga = ll_num_riga + 1
					li_ret = wf_creo_righe(s_saldi)
				else
					s_saldi.num_riga = 1
					li_ret = wf_crea_doc(s_saldi)
				end if
				if li_ret<>1 then 
					rollback;  //20261126c tutto o niente: si toglie tutto quello creato in questo giro
					ls_art = s_saldi.articolo  //20261126b soggetto e articolo nel messaggio
					if isnull(ls_art) then ls_art = ""
					if isnull(ls_rag) then ls_rag = ""
				messagebox("Errore!", "Saldi non ricostruiti! Operazione interrotta: non e~' stato salvato niente.~r~nSoggetto: "+ls_rag+" ("+string(s_saldi.id_sog)+")~r~nArticolo: "+ls_art)
					return -1
				end if
			end if
		
		
			ll_breakrow = ll_breakrow + 1
			ll_breakrow = ds_saldi.FindGroupChange(ll_breakrow, 1)
		LOOP WHILE ll_breakrow>0	
	end if	
	
	tab_1.tabpage_3.dw_4.setsort("sog_com")
	tab_1.tabpage_3.dw_4.sort()
	
	
	
	
end if
//wf_ges_ap_partita(str_param)
//20261126c tutto o niente: se la riapertura delle partite fallisce (ha gia fatto rollback) non si va avanti;
//altrimenti un solo commit per tutti i documenti dei saldi e delle partite
li_ret = wf_riapri_partite(str_param)
if li_ret <> 1 then
	rollback;
	messagebox("Errore!", "Saldi non ricostruiti: errore nella riapertura delle partite. Non e~' stato salvato niente.")
	return -1
end if
commit;
return 1
							



end function

public function integer wf_ges_ap_partita (s_param_articoli str_param);
datastore ds_saldi
long ll_righe, ll_id_doc
long ll_breakrow, ll_old_id_sog, ll_old_caus
s_ricostruisci_saldi s_saldi, s_azzera
integer li_ret
string ls_tipo_partita,  ls_rag

	
ds_saldi=create datastore
ds_saldi.dataobject="d_or_saldi_cli_fo"
//ds_saldi.dataobject="d_par_aperte_per_saldi"
ds_saldi.settransobject(sqlca)
ll_righe=ds_saldi.retrieve(str_param.da_data, str_param.a_data)
							
if ll_righe>0 then
	ll_breakrow = 1
	DO 
		s_saldi=s_azzera
		s_saldi.id_sog=ds_saldi.GetItemNumber(ll_breakrow, "id_sog_commerciale")
		s_saldi.id_metallo=	ds_saldi.GetItemNumber(ll_breakrow, "id_metallo")
		
		select id_titolo
		into :s_saldi.id_mag_1 
		from orafo_titolo
		where id_metallo=:s_saldi.id_metallo
		and titolo=1000
		;
		s_saldi.tipo_partita='A'+ds_saldi.GetItemstring(ll_breakrow, "cod_partita")
		
		select min(id_caus_magazzino)
		into :s_saldi.id_caus_magazzino
		from caus_magazzino c, orafo_tipo_partita t
		where c.id_tipo_partita=t.id_tipo_partita
		and t.cod_tipo_partita=:s_saldi.tipo_partita
		;
		select id_tipo_partita
		into :s_saldi.id_mag_2
		from orafo_tipo_partita
		where cod_tipo_partita=:s_saldi.tipo_partita
		;
		
		
		
		
		
		s_saldi.fino=ds_saldi.GetItemdecimal(ll_breakrow, "saldo_2")
		
		s_saldi.fino=abs(s_saldi.fino)
		s_saldi.id_caus_magazzino=ds_saldi.GetItemNumber(ll_breakrow,"caus_magazzino_id_caus_magazzino")
		select max(id_documento)
		into :s_saldi.id_doc
		from documento
		where id_caus_magazzino=:s_saldi.id_caus_magazzino
		and id_sog_commerciale=:s_saldi.id_sog
		;
		if s_saldi.fino<>0 then
			insert into orafo_aper_partita
			(id_documento, id_titolo, val_apertura, val_scarico, 
			id_tipo_partita, stato)
			values
			(:s_saldi.id_doc, :s_saldi.id_mag_1, :s_saldi.fino,
			0, :s_saldi.id_mag_2, 'A')
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Errore!", "Partita non inserita!")
				return -1
			end if
	
		end if
		
		ll_breakrow = ll_breakrow + 1
		ll_breakrow = ds_saldi.FindGroupChange(ll_breakrow, 2)
	LOOP WHILE ll_breakrow>0
end if
return 1
							
		


end function

public subroutine wf_riempi_causali (integer al_righe);integer a
string ls_tipo

for a= al_righe+1 to 8
	tab_1.tabpage_5.dw_5.insertrow(0)
	tab_1.tabpage_5.dw_5.setitem(a, "numero", string(a))
	if a < 5 then ls_tipo='M' else ls_tipo='C'
	tab_1.tabpage_5.dw_5.setitem(a, "flag", ls_tipo)
next
end subroutine

public function long wf_cerca_causale (decimal as_saldo_fino, decimal as_saldo_lire, STRING AS_FLAG);long ll_id_caus, LL_RIGA

IF AS_FLAG='C' THEN
	if as_saldo_fino >=0  and as_saldo_lire >=0 then
		ll_id_caus=tab_1.tabpage_5.dw_5.getitemnumber(7, "orafo_caus_saldi_id_caus_magazzino")
		return ll_id_caus			
	elseif as_saldo_fino >=0  and as_saldo_lire <=0 then
		ll_id_caus=tab_1.tabpage_5.dw_5.getitemnumber(8, "orafo_caus_saldi_id_caus_magazzino")
		return ll_id_caus	
	elseif as_saldo_fino <=0  and as_saldo_lire >=0 then
		ll_id_caus=tab_1.tabpage_5.dw_5.getitemnumber(5, "orafo_caus_saldi_id_caus_magazzino")
		return ll_id_caus	
	elseif as_saldo_fino <=0  and as_saldo_lire <=0 then			
		ll_id_caus=tab_1.tabpage_5.dw_5.getitemnumber(6, "orafo_caus_saldi_id_caus_magazzino")
		return ll_id_caus				
	end if
ELSE
	if as_saldo_fino >=0  and as_saldo_lire >=0 then
		ll_id_caus=tab_1.tabpage_5.dw_5.getitemnumber(4, "orafo_caus_saldi_id_caus_magazzino")
		return ll_id_caus			
	elseif as_saldo_fino >=0  and as_saldo_lire <=0 then
		ll_id_caus=tab_1.tabpage_5.dw_5.getitemnumber(3, "orafo_caus_saldi_id_caus_magazzino")
		return ll_id_caus	
	elseif as_saldo_fino <=0  and as_saldo_lire >=0 then
		ll_id_caus=tab_1.tabpage_5.dw_5.getitemnumber(2, "orafo_caus_saldi_id_caus_magazzino")
		return ll_id_caus	
	elseif as_saldo_fino <=0  and as_saldo_lire <=0 then			
		ll_id_caus=tab_1.tabpage_5.dw_5.getitemnumber(1, "orafo_caus_saldi_id_caus_magazzino")
		return ll_id_caus				
	end if
	
	
END IF 
	
return -1
end function

public function integer wf_riapri_partite (s_param_articoli str_param);datastore ds_saldi
long ll_righe, ll_id_doc, i, ll_id_titolo, ll_id_tipo_partita
long ll_id_prof_doc, ll_id_reg, ll_num_prog, ll_id_sog, LL_ID_CAUSALE
string ls_num_doc
date ldt_data_doc_su_prev_consegna
decimal ldc_fino
datetime ldt_data_ora_creazione
integer li_test
time lt_time
	
ds_saldi=create datastore

ds_saldi.dataobject="d_par_aperte_per_saldi"
ds_saldi.settransobject(sqlca)
ll_righe=ds_saldi.retrieve(str_param.da_data, str_param.a_data)


//+string(time(now()))
ll_id_reg=TAB_1.TABPAGE_1.DW_1.GETITEMNUMBER(1, "ID_REGISTRO")
SELECT MAX(NUM_progressivo)
into :ll_num_prog
from documento
where id_registro=:ll_id_reg;


for I=1 to ll_righe
	li_test++
	ll_num_prog++
	lt_time=relativetime(now(), li_test)
	
	
	
	ll_id_prof_doc=ds_saldi.GETITEMNUMBER(I, "ID_PROF_DOCUMENTO")
	LL_ID_CAUSALE=ds_saldi.GETITEMNUMBER(I, "ID_CAUS_MAGAZZINO")
	ls_num_doc=ds_saldi.GETITEMstring(I, "num_DOCUMENTO")
	ll_id_sog=ds_saldi.GETITEMNUMBER(I, "ID_sog_commerciale")
	ldt_data_doc_su_prev_consegna=ds_saldi.GETITEMdate(I, "data_documento")
	//ldt_data_ora_creazione=datetime(today(), lt_time)
	ldt_data_ora_creazione=datetime(idt_data_doc, lt_time)
	
	INSERT INTO documento (id_prof_documento, id_registro,&
				num_progressivo, data_registrazione, num_documento, data_documento,&
				id_sog_commerciale, id_valuta, data_prev_consegna, &
				 data_ora_creazione, id_azienda, id_caus_magazzino)
	VALUES (:ll_id_prof_doc, :ll_id_reg,&
				:ll_num_prog, :idt_data_doc,:ls_num_doc, :idt_data_doc,&
				:ll_id_sog, :il_id_valuta, :ldt_data_doc_su_prev_consegna, &
				:ldt_data_ora_creazione, 1, :LL_ID_CAUSALE);
	if sqlca.sqlcode=0 then
		//20261126c tutto o niente: commit solo alla fine di wf_ricostruisci_saldi
		
		sqlca.identity(ll_id_doc)
		ll_id_titolo=ds_saldi.GETITEMNUMBER(I, "ID_titolo")
		ldc_fino=ds_saldi.GETITEMdecimal(I, "c_saldo")
		ll_id_tipo_partita=ds_saldi.GETITEMNUMBER(I, "ID_tipo_partita")
		insert into orafo_aper_partita
		(id_documento, id_titolo, val_apertura, val_scarico, 
		id_tipo_partita, stato)
		values
		(:ll_id_doc, :ll_id_titolo, :ldc_fino,
		0, :ll_id_tipo_partita, 'A')
		;
		if sqlca.sqlcode=0 then
			//20261126c tutto o niente: commit solo alla fine di wf_ricostruisci_saldi
		else
			rollback;
			messagebox("Errore!", "Partita non inserita!")
			return -1
		end if
	else
		rollback;
		messagebox("Errore", "Documento non inserito")
		return -1
	end if

next


destroy(ds_saldi)

return 1
end function

public function integer wf_new_ric_saldo (s_param_articoli str_param);//20261127 RISCRITTA (richiesta utente 26-27/11): saldi di conto lavoro, visione, riparazione... DALLE PARTITE, con
//il saldo calcolato come la stampa dei saldi (d_new_scheda_clfo_cl) ma per soggetto, metallo e TIPO PARTITA (ultime 3 lettere:
//CLC, CLF, CVC... ognuno per se, utente 27/11: la stampa li unisce per 2 lettere e non va), riga per riga round(peso (col segno di saldi_cl_fino) + correzione K, 2) x coef. calo (0 = titolo) / 1000 a 2
//decimali. Provato su Labella al 27/11/2026: totale -233.076,72 come il PDF.
//Il segno del saldo sceglie la causale dello stesso tipo partita: prima il carico base (CLC+ CBCLCL, CLF- CBCLFO, CVC- CBCVCL,
//CVF+ CBCVFO, CRC+ CBCRCL, con partita), poi una di reso/scarico senza partita (CLC- RCLC, CLF+ RCLF, CVC+ RCVC...), per ultima
//un altra apertura (CRF- ACRF, con partita).
//Il saldo si distribuisce sulle partite aperte di quel tipo dalla piu vecchia, saltando quelle sotto soglia (oro 1 g,
//altri metalli 3 g); il resto va sull ultima. Un documento per partita con numero e data del documento originale e la
//partita nuova. Senza partite sopra soglia: un documento lo stesso, sull articolo dell ultimo movimento di quel gruppo e
//metallo (del soggetto, se no di chiunque) e un avviso. Saldi sotto 0,1 g: niente. Solo grammi. Niente commit (cb_saldi).
datastore ds_aperture
long ll_n, ll_k, ll_righe_partita, ll_id_sog, ll_ultima, i, ll_id_caus, ll_id_tipo_ap, ll_id_riga, ll_id_metallo, ll_r
long ll_sog[]
integer li_ret, li_exit, li_avvisi, li_f
string ls_met[], ls_grp[], ls_rag[]
string ls_metallo, ls_gruppo, ls_rag_s, ls_segno, ls_cod_tipo, ls_avvisi, ls_num, ls_art, ls_file, ls_s, ls_g, ls_r, ls_m
decimal ldc_val[]
decimal ldc_saldo, ldc_qta, ldc_saldo_partita, ldc_fc_restante, ldc_soglia, ldc_v
long ll_s
date ld_data, ld_inizio

ld_inizio = date(1901, 1, 1)
ls_avvisi = ""
tab_1.tabpage_3.dw_4.reset()
tab_1.selecttab(3)
//documenti creati da questo giro: id oltre questo (serve anche al saldo di magazzino)
select max(id_documento) into :il_id_prima_saldi from documento;
if isnull(il_id_prima_saldi) then il_id_prima_saldi = 0

//----- saldi come la stampa, letti tutti in memoria prima di creare i documenti
DECLARE c_saldi CURSOR FOR
select d.id_sog_commerciale, g.rag_soc_1, m.codice, right(tp.cod_tipo_partita, 3),
	sum(round(round((case when c.saldi_cl_fino = '+' then r.peso_netto else - r.peso_netto end)
		+ isnull((select k.correzione from correzioni_k k where k.id_riga_documento = r.id_riga_documento), 0), 2)
		* (case when r.coef_calo = 0 then t.titolo else r.coef_calo end) / 1000, 2))
from riga_documento r, documento d, caus_magazzino c, orafo_tipo_partita tp, articolo a, orafo_titolo t, orafo_metallo m, sog_commerciale_gen g
where c.id_caus_magazzino = r.id_caus_magazzino and d.id_documento = r.id_documento and tp.id_tipo_partita = c.id_tipo_partita
and a.id_articolo = r.id_articolo and t.id_titolo = a.id_titolo and m.id_metallo = t.id_metallo
and g.id_sog_commerciale = d.id_sog_commerciale
and c.saldi_cl_fino > ' ' and d.data_documento <= :str_param.a_data
and g.codice >= :str_param.da_sog_comm and g.codice <= :str_param.a_sog_comm
group by d.id_sog_commerciale, g.rag_soc_1, m.codice, right(tp.cod_tipo_partita, 3)
order by m.codice, g.rag_soc_1, 4;

OPEN c_saldi;
if sqlca.sqlcode <> 0 then
	messagebox("Errore!", "Saldi non letti~r~n" + sqlca.sqlerrtext)
	return -1
end if
ll_n = 0
do
	FETCH c_saldi INTO :ll_s, :ls_r, :ls_m, :ls_g, :ldc_v;
	if sqlca.sqlcode <> 0 then exit
	if isnull(ldc_v) then ldc_v = 0
	if abs(ldc_v) >= 0.1 then
		ll_n++
		ll_sog[ll_n] = ll_s
		ls_rag[ll_n] = ls_r
		ls_met[ll_n] = ls_m
		ls_grp[ll_n] = ls_g
		ldc_val[ll_n] = ldc_v
	end if
loop while true
if sqlca.sqlcode < 0 then
	messagebox("Errore!", "Saldi non letti~r~n" + sqlca.sqlerrtext)
	CLOSE c_saldi;
	return -1
end if
CLOSE c_saldi;

ds_aperture = create datastore
ds_aperture.dataobject = "d_trova_partite_aperte_per_saldi"
ds_aperture.settransobject(sqlca)

for ll_k = 1 to ll_n
	ll_id_sog = ll_sog[ll_k]
	ls_rag_s = ls_rag[ll_k]
	if isnull(ls_rag_s) then ls_rag_s = ""
	ls_metallo = ls_met[ll_k]
	if isnull(ls_metallo) then ls_metallo = ""
	ls_gruppo = ls_grp[ll_k]
	if isnull(ls_gruppo) then ls_gruppo = ""
	ldc_saldo = ldc_val[ll_k]
	if ldc_saldo > 0 then
		ls_segno = "+"
	else
		ls_segno = "-"
	end if
	setnull(ll_id_metallo)
	select id_metallo into :ll_id_metallo from orafo_metallo where codice = :ls_metallo;

	//causale dello stesso tipo partita col segno del saldo: carico base, poi reso/scarico, poi altra apertura
	setnull(ll_id_caus)
	setnull(ll_id_tipo_ap)
	setnull(ls_cod_tipo)
	select top 1 c.id_caus_magazzino, c.id_tipo_partita, tp.cod_tipo_partita
	into :ll_id_caus, :ll_id_tipo_ap, :ls_cod_tipo
	from caus_magazzino c, orafo_tipo_partita tp
	where tp.id_tipo_partita = c.id_tipo_partita and c.saldi_cl_fino = :ls_segno
	and right(tp.cod_tipo_partita, 3) = :ls_gruppo
	and exists (select 1 from prof_documento p where p.id_caus_magazzino_prop = c.id_caus_magazzino)
	order by (case when c.codice like 'CB%' then 0 when left(tp.cod_tipo_partita, 1) <> 'A' then 1 else 2 end),
		(case when isnull(c.segno, '') = '' then 0 else 1 end), c.id_caus_magazzino;
	if isnull(ll_id_caus) then
		ls_avvisi = ls_avvisi + ls_rag_s + " - " + ls_metallo + " " + ls_gruppo + ": " + string(ldc_saldo, "#,##0.00") + " g NON ricostruiti (nessuna causale " + ls_gruppo + " col segno " + ls_segno + ")~r~n"
		li_avvisi++
		continue
	end if
	if left(ls_cod_tipo, 1) <> "A" then ll_id_tipo_ap = 0  //causale di scarico: niente partita

	//partite aperte del tipo esatto, anche aperte prima del periodo
	ll_ultima = 0
	ll_righe_partita = 0
	if ll_id_tipo_ap > 0 then
		ll_righe_partita = ds_aperture.retrieve(ls_cod_tipo, ll_id_sog, ls_metallo, ld_inizio, str_param.a_data)
		if ls_metallo = "AU" then
			ldc_soglia = 1
		else
			ldc_soglia = 3
		end if
		for i = 1 to ll_righe_partita
			ldc_saldo_partita = ds_aperture.getitemdecimal(i, "c_saldo_partita")
			if isnull(ldc_saldo_partita) then ldc_saldo_partita = 0
			if ldc_saldo_partita >= ldc_soglia then ll_ultima = i
		next
	end if

	if ll_ultima > 0 then
		//----- saldo distribuito sulle partite: un documento per partita, con la sua partita nuova
		ldc_fc_restante = abs(ldc_saldo)
		li_exit = 0
		for i = 1 to ll_righe_partita
			ldc_saldo_partita = ds_aperture.getitemdecimal(i, "c_saldo_partita")
			if isnull(ldc_saldo_partita) then ldc_saldo_partita = 0
			if ldc_saldo_partita < ldc_soglia then continue //partite quasi chiuse: niente documento
			ldc_qta = round(ldc_saldo_partita, 2)
			if ldc_qta >= ldc_fc_restante then
				ldc_qta = ldc_fc_restante
				li_exit = 1
			end if
			if i = ll_ultima and ldc_qta < ldc_fc_restante then ldc_qta = ldc_fc_restante //l ultima prende il resto
			ldc_fc_restante = ldc_fc_restante - ldc_qta
			ls_num = ds_aperture.getitemstring(i, "num_documento")
			ld_data = ds_aperture.getitemdate(i, "data_documento")
			ll_id_riga = ds_aperture.getitemnumber(i, "id_riga_documento")
			li_ret = wf_doc_saldo(ll_id_sog, ll_id_caus, ll_id_riga, ldc_qta, ls_num, ld_data, ll_id_tipo_ap)
			if li_ret <> 1 then
				destroy ds_aperture
				return -1
			end if
			setnull(ls_art)
			select a.codice into :ls_art from riga_documento r, articolo a where a.id_articolo = r.id_articolo and r.id_riga_documento = :ll_id_riga;
			ll_r = tab_1.tabpage_3.dw_4.insertrow(0)
			tab_1.tabpage_3.dw_4.setitem(ll_r, "saldoau", ldc_qta * sign(ldc_saldo))
			tab_1.tabpage_3.dw_4.setitem(ll_r, "id_metallo", ll_id_metallo)
			tab_1.tabpage_3.dw_4.setitem(ll_r, "saldolire", 0)
			tab_1.tabpage_3.dw_4.setitem(ll_r, "tipo", right(ls_cod_tipo, 3))
			tab_1.tabpage_3.dw_4.setitem(ll_r, "articolo", ls_art)
			tab_1.tabpage_3.dw_4.setitem(ll_r, "sog_com", ls_rag_s)
			tab_1.tabpage_3.dw_4.setitem(ll_r, "id_caus", ll_id_caus)
			if li_exit = 1 then exit
		next
	else
		//----- nessuna partita aperta sopra soglia: un documento lo stesso, sull articolo dell ultimo movimento di quel
		//gruppo e metallo del soggetto (se non c e, di qualsiasi soggetto), e un avviso
		setnull(ll_id_riga)
		select max(r.id_riga_documento) into :ll_id_riga
		from riga_documento r, documento d, caus_magazzino c, orafo_tipo_partita tp, articolo a, orafo_titolo t, orafo_metallo m
		where d.id_documento = r.id_documento and c.id_caus_magazzino = r.id_caus_magazzino and tp.id_tipo_partita = c.id_tipo_partita
		and right(tp.cod_tipo_partita, 3) = :ls_gruppo and a.id_articolo = r.id_articolo and t.id_titolo = a.id_titolo
		and m.id_metallo = t.id_metallo and m.codice = :ls_metallo and d.id_sog_commerciale = :ll_id_sog
		and d.data_documento <= :str_param.a_data;
		if isnull(ll_id_riga) then
			select max(r.id_riga_documento) into :ll_id_riga
			from riga_documento r, documento d, caus_magazzino c, orafo_tipo_partita tp, articolo a, orafo_titolo t, orafo_metallo m
			where d.id_documento = r.id_documento and c.id_caus_magazzino = r.id_caus_magazzino and tp.id_tipo_partita = c.id_tipo_partita
			and right(tp.cod_tipo_partita, 3) = :ls_gruppo and a.id_articolo = r.id_articolo and t.id_titolo = a.id_titolo
			and m.id_metallo = t.id_metallo and m.codice = :ls_metallo and d.data_documento <= :str_param.a_data;
		end if
		if isnull(ll_id_riga) then
			ls_avvisi = ls_avvisi + ls_rag_s + " - " + ls_metallo + " " + ls_gruppo + ": " + string(ldc_saldo, "#,##0.00") + " g NON ricostruiti (nessun articolo di quel gruppo e metallo)~r~n"
			li_avvisi++
			continue
		end if
		if ll_id_tipo_ap > 0 then
			ls_avvisi = ls_avvisi + ls_rag_s + " - " + ls_metallo + " " + right(ls_cod_tipo, 3) + ": " + string(ldc_saldo, "#,##0.00") + " g senza partite aperte sopra soglia: documento con partita nuova~r~n"
		else
			ls_avvisi = ls_avvisi + ls_rag_s + " - " + ls_metallo + " " + right(ls_cod_tipo, 3) + ": " + string(ldc_saldo, "#,##0.00") + " g su documento senza partita~r~n"
		end if
		li_avvisi++
		li_ret = wf_doc_saldo(ll_id_sog, ll_id_caus, ll_id_riga, abs(ldc_saldo), "SALDO", str_param.a_data, ll_id_tipo_ap)
		if li_ret <> 1 then
			destroy ds_aperture
			return -1
		end if
		setnull(ls_art)
		select a.codice into :ls_art from riga_documento r, articolo a where a.id_articolo = r.id_articolo and r.id_riga_documento = :ll_id_riga;
		ll_r = tab_1.tabpage_3.dw_4.insertrow(0)
		tab_1.tabpage_3.dw_4.setitem(ll_r, "saldoau", ldc_saldo)
		tab_1.tabpage_3.dw_4.setitem(ll_r, "id_metallo", ll_id_metallo)
		tab_1.tabpage_3.dw_4.setitem(ll_r, "saldolire", 0)
		tab_1.tabpage_3.dw_4.setitem(ll_r, "tipo", right(ls_cod_tipo, 3))
		tab_1.tabpage_3.dw_4.setitem(ll_r, "articolo", ls_art)
		tab_1.tabpage_3.dw_4.setitem(ll_r, "sog_com", ls_rag_s)
		tab_1.tabpage_3.dw_4.setitem(ll_r, "id_caus", ll_id_caus)
	end if
next

destroy ds_aperture

if li_avvisi > 0 then
	//avvisi anche su file, per rileggerli con calma
	ls_file = "c:\nita\log\saldi_avvisi_" + string(today(), "yyyymmdd") + "_" + string(now(), "hhmmss") + ".txt"
	li_f = fileopen(ls_file, streammode!, write!, lockwrite!, replace!)
	if li_f > 0 then
		filewriteex(li_f, ls_avvisi)
		fileclose(li_f)
	else
		ls_file = "(file non scritto)"
	end if
	if len(ls_avvisi) > 2500 then ls_avvisi = left(ls_avvisi, 2500) + "~r~n..."
	messagebox("Saldi: " + string(li_avvisi) + " avvisi", ls_avvisi + "~r~nElenco completo in " + ls_file)
end if
return 1
end function

public function integer wf_doc_saldo (long al_id_sog, long al_id_caus, long al_id_riga_orig, decimal adc_qta, string as_num_orig, date ad_data_orig, long al_id_tipo_partita);//20261126d un documento di saldo (richiesta utente 26/11): testata + una riga con articolo, descrizione, unita e
//coef. calo della riga di carico al_id_riga_orig, per adc_qta grammi di fino+calo, + la partita aperta se al_id_tipo_partita > 0.
//Niente commit: tutto o niente (lo fa cb_saldi).
long ll_id_doc, ll_loc_1, ll_loc_2, ll_id_art, ll_id_uc, ll_id_iva, ll_id_titolo
decimal ldc_coef, ldc_titolo, ldc_peso, ldc_fino, ldc_calo
string ls_des

if wf_doc_testata(al_id_sog, al_id_caus, as_num_orig, ad_data_orig, ll_id_doc, ll_loc_1, ll_loc_2) <> 1 then return -1

select r.id_articolo, r.descrizione, r.id_unita_confezione, r.coef_calo, r.id_tab_iva, a.id_titolo, t.titolo
into :ll_id_art, :ls_des, :ll_id_uc, :ldc_coef, :ll_id_iva, :ll_id_titolo, :ldc_titolo
from riga_documento r, articolo a, orafo_titolo t
where r.id_riga_documento = :al_id_riga_orig and a.id_articolo = r.id_articolo and t.id_titolo = a.id_titolo;
if sqlca.sqlcode <> 0 then
	messagebox("Errore!", "Riga di carico " + string(al_id_riga_orig) + " non trovata~r~n" + sqlca.sqlerrtext)
	return -1
end if
if isnull(ldc_coef) or ldc_coef = 0 then ldc_coef = 1000
if isnull(ldc_titolo) then ldc_titolo = 0
//come wf_new_crea_righe: la qta e il fino+calo; peso dal coef. calo, fino dal titolo, il calo e il resto
ldc_peso = round(adc_qta * 1000 / ldc_coef, 4)
ldc_fino = round(ldc_peso * ldc_titolo / 1000, 4)
ldc_calo = adc_qta - ldc_fino

insert into riga_documento (id_documento, id_unita_confezione, num_riga, id_articolo, descrizione, quantita, qta_un_base,
	id_caus_magazzino, id_locazione_1, id_locazione_2, id_valuta, cambio, prezzo, prezzo_netto, peso_netto, id_tab_iva,
	tot_riga_val_riga, tot_riga_val_doc, tot_riga_val_az, id_conto, id_azienda, coef_calo, calo, fino,
	prezzo_metallo, prezzo_manifattura, importo_manifattura, importo_manifattura_val,
	fat_con_unita_base, fat_con_globale, sconto, da_stampare, forza_chius_evasione, sospesa, qta_evasa)
values (:ll_id_doc, :ll_id_uc, 1, :ll_id_art, :ls_des, 1, 1,
	:al_id_caus, :ll_loc_1, :ll_loc_2, :il_id_valuta, 1, 0, 0, :ldc_peso, :ll_id_iva,
	0, 0, 0, :il_id_conto, 1, :ldc_coef, :ldc_calo, :ldc_fino,
	0, 0, 0, 0,
	1, 1, 0, 'N', 'N', 'S', 0);
if sqlca.sqlcode <> 0 then
	messagebox("Errore!", "Riga del documento di saldo non creata~r~n" + sqlca.sqlerrtext)
	return -1
end if

if al_id_tipo_partita > 0 then
	insert into orafo_aper_partita (id_documento, id_titolo, val_apertura, val_scarico, id_tipo_partita, stato)
	values (:ll_id_doc, :ll_id_titolo, :adc_qta, 0, :al_id_tipo_partita, 'A');
	if sqlca.sqlcode <> 0 then
		messagebox("Errore!", "Partita del documento di saldo non creata~r~n" + sqlca.sqlerrtext)
		return -1
	end if
end if
return 1
end function

public function integer wf_doc_testata (long al_id_sog, long al_id_caus, string as_num_doc, date ad_data_prev, ref long al_id_doc, ref long al_loc_1, ref long al_loc_2);//20261126d testata di un documento di saldo: profilo dalla causale, registro dall esercizio scelto e dal profilo,
//numero progressivo successivo, data = data scelta, data_prev_consegna = ad_data_prev. Niente commit.
long ll_id_prof, ll_id_reg, ll_num_prog, ll_id_mod_reg, ll_id_ese, ll_mag_1
datetime ldt_crea

setnull(ll_id_prof)
select min(id_prof_documento) into :ll_id_prof from prof_documento where id_caus_magazzino_prop = :al_id_caus;
if isnull(ll_id_prof) then
	messagebox("Errore!", "Non esiste un profilo per la causale " + string(al_id_caus) + ": inserirlo prima di usare la procedura")
	return -1
end if
select id_magazzino_1_prop, id_locazione_1_prop, id_locazione_2_prop, id_mod_registro_prop
into :ll_mag_1, :al_loc_1, :al_loc_2, :ll_id_mod_reg
from prof_documento where id_prof_documento = :ll_id_prof;
ll_id_ese = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_esercizio")
setnull(ll_id_reg)
select id_registro into :ll_id_reg from registro where id_esercizio = :ll_id_ese and id_mod_registro = :ll_id_mod_reg;
if isnull(ll_id_reg) then
	messagebox("Errore!", "Registro non trovato per il profilo " + string(ll_id_prof) + " nell esercizio scelto")
	return -1
end if
setnull(ll_num_prog)
select max(num_progressivo) into :ll_num_prog from documento where id_registro = :ll_id_reg;
if isnull(ll_num_prog) then ll_num_prog = 0
ll_num_prog++
ldt_crea = datetime(idt_data_doc, now())
INSERT INTO documento (id_prof_documento, id_registro, num_progressivo, data_registrazione, num_documento, data_documento,
	data_prev_consegna, id_sog_commerciale, id_caus_magazzino, id_magazzino, id_locazione_1, id_locazione_2,
	id_valuta, data_ora_creazione, cambio)
VALUES (:ll_id_prof, :ll_id_reg, :ll_num_prog, :idt_data_doc, :as_num_doc, :idt_data_doc,
	:ad_data_prev, :al_id_sog, :al_id_caus, :ll_mag_1, :al_loc_1, :al_loc_2,
	:il_id_valuta, :ldt_crea, 1);
if sqlca.sqlcode <> 0 then
	messagebox("Errore!", "Documento di saldo non inserito~r~n" + sqlca.sqlerrtext)
	return -1
end if
sqlca.identity(al_id_doc)
return 1
end function

public function integer wf_saldi_magazzino (s_param_articoli str_param);//20261126d (richiesta utente 26/11) saldo di magazzino: basta che il TOTALE PER METALLO torni quello di fine periodo.
//Il totale buono e il FINO (utente 27/11: un fino maggiore del peso non e credibile; i totali di peso e fino non stanno
//insieme perche il metallo entra e esce con titoli diversi). Una riga per metallo sull articolo di titolo piu alto (es. AG PURO):
//fino = totale del fino, peso = fino / titolo (al titolo 1000 peso = fino), calo = peso - fino. Metalli senza fino (pietre):
//il totale del peso. Causali con segno C/S, documenti fino ad a_data. 2 documenti intestati alla ditta: positivi con
//CARICO BASE MAGAZZINO (52), negativi con DDT VENDITA (2). Niente commit: tutto o niente (lo fa cb_saldi).
//20261127 i documenti di saldo appena creati che muovono il magazzino (es. CBCLCL, CBCRCL, ACRF) si tolgono, cosi
//nel nuovo anno il totale per metallo (saldo magazzino + documenti di saldo) torna quello di fine periodo.
long ll_id_sog, ll_id_doc, ll_loc_1, ll_loc_2, ll_caus, ll_n, ll_r
integer k, li_segno
string ls_pref, ls_tipo

if cbx_solo_clfo.checked then return 1  //solo conto lavoro: il magazzino non si tocca
if str_param.da_sog_comm <> " " or str_param.a_sog_comm <> "ZZZZZZZZ" or str_param.da_categoria <> " " or str_param.a_categoria <> "ZZZZZZZZ" then
	messagebox("Saldo di magazzino", "Con una selezione di soggetti o causali il saldo di magazzino non si ricostruisce: si fa solo sull intero archivio.")
	return 1
end if

//la ditta come soggetto: stessa partita IVA dell azienda, preferibilmente il codice cliente
select pref_cod_cliente into :ls_pref from par_sistema;
if isnull(ls_pref) then ls_pref = ""
setnull(ll_id_sog)
select min(g.id_sog_commerciale) into :ll_id_sog from sog_commerciale_gen g, azienda z
where z.id_azienda = 1 and g.par_iva = z.par_iva and g.codice like :ls_pref || '%';
if isnull(ll_id_sog) then
	select min(g.id_sog_commerciale) into :ll_id_sog from sog_commerciale_gen g, azienda z
	where z.id_azienda = 1 and g.par_iva = z.par_iva;
end if
if isnull(ll_id_sog) then
	messagebox("Errore!", "Saldo di magazzino: nessun soggetto con la partita IVA della ditta")
	return -1
end if

for k = 1 to 2
	if k = 1 then
		ll_caus = 52
		li_segno = 1
		ls_tipo = "CARICO"
	else
		ll_caus = 2
		li_segno = -1
		ls_tipo = "SCARICO"
	end if
	if wf_doc_testata(ll_id_sog, ll_caus, "SALDO MAG", str_param.a_data, ll_id_doc, ll_loc_1, ll_loc_2) <> 1 then return -1
	//righe con forza_chius_evasione = S: la DDT a se stessi non deve risultare da fatturare
	insert into riga_documento (id_documento, id_unita_confezione, num_riga, id_articolo, descrizione, quantita, qta_un_base,
		id_caus_magazzino, id_locazione_1, id_locazione_2, id_valuta, cambio, prezzo, prezzo_netto, peso_netto, id_tab_iva,
		tot_riga_val_riga, tot_riga_val_doc, tot_riga_val_az, id_conto, id_azienda, coef_calo, calo, fino,
		prezzo_metallo, prezzo_manifattura, importo_manifattura, importo_manifattura_val,
		fat_con_unita_base, fat_con_globale, sconto, da_stampare, forza_chius_evasione, sospesa, qta_evasa)
	select :ll_id_doc, (select min(u.id_unita_confezione) from unita_confezione u where u.id_articolo = y.id_art and u.unita_base = 'S'),
		number(*), y.id_art, a.descrizione, 1, 1,
		:ll_caus, :ll_loc_1, :ll_loc_2, :il_id_valuta, 1, 0, 0,
		(case when y.f <> 0 and t.titolo > 0 then round(y.f * 1000 / t.titolo, 4) when y.f <> 0 then y.f else y.p end) * :li_segno,
		a.id_tab_iva,
		0, 0, 0, :il_id_conto, 1, 1000,
		(case when y.f <> 0 and t.titolo > 0 then round(y.f * 1000 / t.titolo, 4) - y.f else 0 end) * :li_segno,
		y.f * :li_segno,
		0, 0, 0, 0,
		1, 1, 0, 'N', 'S', 'S', 0
	from (select x.*, (select top 1 a2.id_articolo from articolo a2, orafo_titolo t2
				where t2.id_titolo = a2.id_titolo and t2.id_metallo = x.id_metallo
				order by t2.titolo desc, (select count(*) from riga_documento r2 where r2.id_articolo = a2.id_articolo) desc, a2.id_articolo) as id_art
		from (select t.id_metallo,
				sum((case c.segno when 'C' then r.peso_netto when 'S' then - r.peso_netto else 0 end) * (case when d.id_documento > :il_id_prima_saldi then -1 else 1 end)) as p,
				sum((case c.segno when 'C' then r.fino when 'S' then - r.fino else 0 end) * (case when d.id_documento > :il_id_prima_saldi then -1 else 1 end)) as f
			from riga_documento r, documento d, caus_magazzino c, articolo a, orafo_titolo t
			where d.id_documento = r.id_documento and c.id_caus_magazzino = r.id_caus_magazzino
			and a.id_articolo = r.id_articolo and t.id_titolo = a.id_titolo
			and (d.data_documento <= :str_param.a_data
				or (d.id_documento > :il_id_prima_saldi and d.id_caus_magazzino not in (52, 2)))
			group by t.id_metallo) x) y, articolo a, orafo_metallo m, orafo_titolo t
	where a.id_articolo = y.id_art and m.id_metallo = y.id_metallo and t.id_titolo = a.id_titolo
	and (case when y.f <> 0 then y.f else y.p end) * :li_segno > 0
	order by m.codice;
	if sqlca.sqlcode < 0 then
		messagebox("Errore!", "Saldo di magazzino (" + ls_tipo + "): righe non create~r~n" + sqlca.sqlerrtext)
		return -1
	end if
	ll_n = sqlca.sqlnrows
	if ll_n = 0 then
		//niente da riportare: via la testata vuota
		delete from documento where id_documento = :ll_id_doc;
	else
		ll_r = tab_1.tabpage_3.dw_4.insertrow(0)
		tab_1.tabpage_3.dw_4.setitem(ll_r, "sog_com", "MAGAZZINO " + ls_tipo)
		tab_1.tabpage_3.dw_4.setitem(ll_r, "articolo", string(ll_n) + " metalli")
		tab_1.tabpage_3.dw_4.setitem(ll_r, "id_caus", ll_caus)
	end if
next
return 1
end function

public function integer wf_new_crea_doc (s_ricostruisci_saldi as_saldi);long ll_id_articolo, ll_id_prof_doc, ll_id_caus, ll_riga, ll_id_reg, ll_num_prog, ll_id_mod_reg, ll_id_ese

string ls_tipo_partita, ls_ret
datetime ldt_data_ora_creazione
integer li_ret


ldt_data_ora_creazione=datetime(idt_data_doc,now())

ls_ret=wf_scegli_causale_e_profilo(as_saldi.tipo_partita)
ll_id_prof_doc=integer(left(ls_ret,2))
ll_id_caus=integer(right(ls_ret, 2) )
as_saldi.id_caus_magazzino=ll_id_caus

select min(id_prof_documento)
into :ll_id_prof_doc
from prof_documento
where id_caus_magazzino_prop=:ll_id_caus;

if sqlca.sqlcode<>0 or isnull(ll_id_prof_doc) then 
	messagebox("Errore!", "Non esiste un profilo per la causale selezionata! ("+string(ll_id_caus)+")"+&
	+"~r~nInserire il profilo prima di usare la procedura!")
	return -1
end if

select id_magazzino_1_prop,  id_locazione_1_prop,id_locazione_2_prop, id_mod_registro_prop
into :as_saldi.id_mag_1, :as_saldi.id_loc_1,:as_saldi.id_loc_2, :ll_id_mod_reg
from prof_documento
where id_prof_documento=:ll_id_prof_doc;

ll_id_ese=tab_1.tabpage_1.dw_1.getitemnumber(1, "id_esercizio")
select id_registro into :ll_id_reg from registro
where id_esercizio=:ll_id_ese and id_mod_registro=:ll_id_mod_reg;

//ll_id_reg=tab_1.tabpage_1.dw_1.getitemnumber(1, "id_registro")


if ll_id_reg>0 then
	select max(num_progressivo)
	into :ll_num_prog
	from documento
	where id_registro=:ll_id_reg;
	if isnull(ll_num_prog) then ll_num_prog=0
	ll_num_prog++
else
	messagebox("Errore!", "Registro non trovato")
	return -1 
end if
if cbx_tk.checked then
	as_saldi.num_doc=string(ll_num_prog)
	as_saldi.data_doc=idt_data_doc
end if

INSERT INTO documento (id_prof_documento, id_registro,&
				num_progressivo, data_registrazione, num_documento, data_documento,&
				data_prev_consegna,&
				id_sog_commerciale, id_caus_magazzino, id_magazzino,
				id_locazione_1,id_locazione_2,
				id_valuta, data_ora_creazione, cambio)
	VALUES (:ll_id_prof_doc, :ll_id_reg, :ll_num_prog, :idt_data_doc, :as_saldi.num_doc, :idt_data_doc, &
				:as_saldi.data_doc,&
				:as_saldi.id_sog, :ll_id_caus, 
				:as_saldi.id_mag_1, :as_saldi.id_loc_1,:as_saldi.id_loc_2,
				:il_id_valuta, :ldt_data_ora_creazione, 1);
if sqlca.sqlcode=0 then
	commit;
	as_saldi.num_riga=1
	as_saldi.id_caus_magazzino=ll_id_caus
   sqlca.identity(as_saldi.id_doc)
	wf_new_crea_righe(as_saldi)
	if li_ret<>1 then return -1
else
	rollback;
	messagebox("Errore", "Documento non inserito")
	return -1
end if

return 1  







end function

public function string wf_scegli_causale_e_profilo (string as_cod_partita);string ls_ret

if as_cod_partita='CLC' then ls_ret="58-47"
if as_cod_partita='CLF' then ls_ret="59-48"
if as_cod_partita='CRC' then ls_ret="87-69"
if as_cod_partita='CVC' then ls_ret="60-49"
if as_cod_partita='CLf' then ls_ret="61-50"

return ls_ret


	
end function

public subroutine wf_new_crea_righe (s_ricostruisci_saldi as_saldi);integer  li_ret  //20230103
long ll_riga, ll_null, ll_id_articolo
decimal ldc_coef_calo, ldc_titolo, ldc_fino, ldc_calo,ldc_peso

setnull(ll_null)
dw_7.reset()
ll_riga=dw_7.retrieve(as_saldi.id_mag_2)
if ll_riga>0 then
	dw_7.SetItem(ll_riga, "id_documento", as_saldi.id_doc)
	dw_7.SetItem(ll_riga, "id_riga_documento", ll_null)
	dw_7.SetItem(ll_riga, "id_caus_magazzino", as_saldi.id_caus_magazzino)
	ldc_coef_calo=dw_7.getitemdecimal(ll_riga, "coef_calo")
	ll_id_articolo=dw_7.getitemnumber(ll_riga, "id_articolo")
	select titolo into :ldc_titolo from orafo_titolo t, articolo a where a.id_titolo=t.id_titolo and a.id_articolo=:ll_id_articolo;
	ldc_peso= as_saldi.qta*1000/ldc_coef_calo  //la qta è il fino+calo della riga...
	ldc_fino=ldc_peso*ldc_titolo/1000
	ldc_calo=as_saldi.qta - ldc_fino
	dw_7.setitem(ll_riga, "peso_netto", ldc_peso)
	dw_7.setitem(ll_riga, "fino", ldc_fino)
	dw_7.setitem(ll_riga, "calo", ldc_calo)
	li_ret=dw_7.setitemstatus(ll_riga, 0, Primary!, NewModified!)
	li_ret=dw_7.trigger event ue_update()	
ELSE
	
END IF

end subroutine

on w_azzera_movimenti_wz.create
int iCurrent
call super::create
this.dw_7=create dw_7
this.cb_1=create cb_1
this.tab_1=create tab_1
this.cbx_controllo=create cbx_controllo
this.cbx_tk=create cbx_tk
this.cbx_solo_clfo=create cbx_solo_clfo
this.cb_saldi=create cb_saldi
this.cb_annulla=create cb_annulla
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_7
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.cbx_controllo
this.Control[iCurrent+5]=this.cbx_tk
this.Control[iCurrent+6]=this.cbx_solo_clfo
this.Control[iCurrent+7]=this.cb_saldi
this.Control[iCurrent+8]=this.cb_annulla
end on

on w_azzera_movimenti_wz.destroy
call super::destroy
destroy(this.dw_7)
destroy(this.cb_1)
destroy(this.tab_1)
destroy(this.cbx_controllo)
destroy(this.cbx_tk)
destroy(this.cbx_solo_clfo)
destroy(this.cb_saldi)
destroy(this.cb_annulla)
end on

event closequery;

end event

event open;call super::open;datawindowchild ldw_da_cat_merceologica, ldw_a_cat_merceologica, ldw_data_inizio_es, ldw_art_met
datawindowchild ldw_iva, ldw_maga, ldw_met, ldw_esercizio, ldw_met4, ldw_caus, ldw_reg,ldw_caus_saldi
date ldt_data_inzio
integer a
String ls_par 
long ll_riga, ll_id_met, ll_righe
date ld_data

tab_1.tabpage_5.dw_5.settransobject(sqlca)
tab_1.tabpage_6.dw_6.settransobject(sqlca)
dw_7.settransobject(sqlca)
ll_righe=tab_1.tabpage_5.dw_5.retrieve()
if ll_righe<8 then 
	if	ll_righe<0 then ll_righe=0
	wf_riempi_causali(ll_righe)
end if
	
tab_1.tabpage_5.dw_5.getchild("id_caus_magazzino",ldw_caus_saldi)
ldw_caus_saldi.settransobject(sqlca)
ldw_caus_saldi.retrieve()

tab_1.tabpage_3.dw_4.getchild("id_caus",ldw_caus)
ldw_caus.settransobject(sqlca)
ldw_caus.retrieve()

tab_1.tabpage_4.dw_2.getchild("metallo",ldw_met)
ldw_met.settransobject(sqlca)
ldw_met.retrieve()
tab_1.tabpage_3.dw_4.getchild("id_metallo",ldw_met4)
ldw_met4.settransobject(sqlca)
ldw_met4.retrieve()

tab_1.tabpage_1.dw_1.getchild("id_esercizio",ldw_esercizio)
ldw_esercizio.settransobject(sqlca)
ldw_esercizio.retrieve()


tab_1.tabpage_1.dw_1.getchild("id_tab_iva",ldw_iva)
ldw_iva.settransobject(sqlca)
ldw_iva.retrieve()

tab_1.tabpage_1.dw_1.getchild("id_magazzino",ldw_maga)
ldw_maga.settransobject(sqlca)
ldw_maga.retrieve()

tab_1.tabpage_1.dw_1.getchild("da_cod_cat",ldw_da_cat_merceologica)
ldw_da_cat_merceologica.settransobject(sqlca)
ldw_da_cat_merceologica.retrieve()

tab_1.tabpage_1.dw_1.getchild("da_cod_cat",ldw_da_cat_merceologica)
ldw_da_cat_merceologica.settransobject(sqlca)
ldw_da_cat_merceologica.retrieve()
tab_1.tabpage_1.dw_1.getchild("a_cod_cat",ldw_a_cat_merceologica)
ldw_a_cat_merceologica.settransobject(sqlca)
ldw_a_cat_merceologica.retrieve()

tab_1.tabpage_1.dw_1.getchild("da_des_cat",ldw_da_cat_merceologica)
ldw_da_cat_merceologica.settransobject(sqlca)
ldw_da_cat_merceologica.retrieve()

tab_1.tabpage_1.dw_1.getchild("a_des_cat",ldw_a_cat_merceologica)
ldw_a_cat_merceologica.settransobject(sqlca)
ldw_a_cat_merceologica.retrieve()

tab_1.tabpage_1.dw_1.insertrow(1)
tab_1.tabpage_4.dw_2.insertrow(1)

ld_data=today()

tab_1.tabpage_1.dw_1.setitem(1, "a_data", ld_data)
ld_data=relativedate(ld_data, +1)
tab_1.tabpage_1.dw_1.setitem(1, "data_documento", ld_data)
select data_inizio
into :ldt_data_inzio
from esercizio e, azienda a
where e.id_esercizio=a.id_esercizio
and a.id_azienda=1;
if sqlca.sqlcode=0 then
	
	tab_1.tabpage_1.dw_1.setitem(1, "da_data", ldt_data_inzio)
else
	messagebox("Errore!", "Esercizio non recuperato: confronta esercizio corrente in dati azienda")
end if
Select id_esercizio
into :ll_riga
from azienda;
if ll_riga>0 then
	tab_1.tabpage_1.dw_1.setitem(1, "id_esercizio", ll_riga)
	tab_1.tabpage_1.dw_1.getchild("id_registro",ldw_reg)
	ldw_reg.settransobject(sqlca)
	ll_righe=ldw_reg.retrieve(ll_riga)
	if ll_righe>0 then
		ll_righe=ldw_reg.getitemnumber(1, "id_registro")
		tab_1.tabpage_1.dw_1.setitem(1, "id_registro", ll_righe)
	else
		messagebox("Errore!", "Non esiste un registro generico per creare i saldi!"&
		+"~r~nCrearne almeno uno dall'apposita finestra.")
		setnull(ll_righe)
		tab_1.tabpage_1.dw_1.setitem(1, "id_registro", ll_righe)
	end if
end if
select min(id_magazzino)
into :ll_riga
from magazzino;
if ll_riga>0 then
	tab_1.tabpage_1.dw_1.setitem(1, "id_magazzino", ll_riga)
end if
select min(id_tab_iva)
into :ll_riga
from tab_iva
where per_aliquota=0;
if ll_riga>0 then
	tab_1.tabpage_1.dw_1.setitem(1, "id_tab_iva", ll_riga)
end if

declare  metallo cursor for
select id_metallo
from orafo_metallo
order by codice
;

open metallo;

fetch metallo into :ll_id_met;
do while sqlca.sqlcode=0 
	ll_riga=tab_1.tabpage_4.dw_2.insertrow(0)
	tab_1.tabpage_4.dw_2.setitem(ll_riga, "metallo", ll_id_met)
	fetch metallo into :ll_id_met;
loop
close metallo;
	
end event

event ue_post_open;call super::ue_post_open;
end event

event resize;
end event

type dw_7 from udw_001 within w_azzera_movimenti_wz
integer x = 64
integer y = 1116
integer width = 4329
integer height = 256
integer taborder = 40
string dataobject = "ds_riga_doc_new_saldi"
end type

type cb_1 from commandbutton within w_azzera_movimenti_wz
boolean visible = false
integer x = 50
integer width = 402
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;
s_param_articoli str_param

str_param.da_data=tab_1.tabpage_1.dw_1.getitemdate(1, "da_data")
str_param.a_data=tab_1.tabpage_1.dw_1.getitemdate(1, "a_data")
str_param.da_sog_comm=tab_1.tabpage_1.dw_1.getitemstring(1, "da_cod_sog_comm")
str_param.a_sog_comm=tab_1.tabpage_1.dw_1.getitemstring(1, "a_cod_sog_comm")
idt_data_doc=tab_1.tabpage_1.dw_1.getitemdate(1, "data_documento")
il_id_valuta=3
//20261126d la ricostruzione dalle partite ora e dentro Azzera/Ricostruisci (cb_saldi)
//wf_new_ric_saldo(str_param)
messagebox("Saldi", "Usare il pulsante Azzera/Ricostruisci")
end event

type tab_1 from tab within w_azzera_movimenti_wz
event create ( )
event destroy ( )
string tag = "Selezione"
integer x = 14
integer y = 100
integer width = 2473
integer height = 996
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event selectionchanged;
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2437
integer height = 876
long backcolor = 79741120
string text = "Selezione"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw_ext_main within tabpage_1
integer x = 9
integer y = 4
integer width = 2414
integer height = 796
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_azzera_mov_st"
end type

event itemchanged;
integer li_ok
long ll_righe

string ls_sql_cond
datawindowchild ldw_reg
string ls_dbc[], ls_dwc[], ls_dbv[]

CHOOSE CASE dwo.name
	case "id_esercizio"
		
		tab_1.tabpage_1.dw_1.getchild("id_registro",ldw_reg)
		ldw_reg.settransobject(sqlca)
		ll_righe=ldw_reg.retrieve(long (data))
		if ll_righe>0 then
			ll_righe=ldw_reg.getitemnumber(1, "id_registro")
			tab_1.tabpage_1.dw_1.setitem(1, "id_registro", ll_righe)
		else
			messagebox("Errore!", "Non esiste un registro generico per creare i saldi!"&
			+"~r~nCrearne almeno uno dall'apposita finestra.")
			setnull(ll_righe)
			tab_1.tabpage_1.dw_1.setitem(1, "id_registro", ll_righe)
			ll_righe=0
		end if
		
	CASE "da_cod_sog_comm"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "da_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
	

		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
           This.SetItem(1, "a_cod_sog_comm", Data)			
           This.SetItem(1, "a_sog_comm_des", This.GetItemString(1, "da_sog_comm_des"))
	      end if
			RETURN 2
		END IF
		
		
	case "da_sog_comm_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "da_cod_sog_comm"
		ls_dwc[2] = "da_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
		    This.SetItem(1, "a_sog_comm_des", Data)			
          This.SetItem(1, "a_cod_sog_comm", This.GetItemString(1, "da_cod_sog_comm"))
	      end if
			RETURN 2
		END IF

	case "a_cod_sog_comm"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_sog_comm"
		ls_dwc[2] = "a_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_sog_comm_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		
		ls_dwc[1] = "a_cod_sog_comm"
		ls_dwc[2] = "a_sog_comm_des"
		
		li_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", "rag_soc_1", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
end choose

end event

event ue_set_search;CHOOSE CASE as_nomecol
		
	

	CASE "da_cod_sog_comm", "da_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "da_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "da_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF

	CASE "a_cod_sog_comm", "a_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"

		IF as_nomecol = "a_cod_sog_comm" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
		ELSEIF as_nomecol = "a_sog_comm_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
		END IF


END CHOOSE	
end event

event ue_use_search;CHOOSE CASE as_nomecol
			
	CASE "da_cod_sog_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_sog_comm_des", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
		  uf_set_colval("a_cod_sog_comm", is_ricpar.s_main_value)
		  uf_set_colval("a_sog_comm_des", is_ricpar.s_ausil_value[1])
	   end if  
		
	CASE "da_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	
		uf_set_colval("da_cod_sog_comm", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_sog_comm")) or This.GetItemString(1, "a_cod_sog_comm")='' then
		  uf_set_colval("a_sog_comm_des", is_ricpar.s_main_value)
		  uf_set_colval("a_cod_sog_comm", is_ricpar.s_ausil_value[1])
		end if  
		
	CASE "a_cod_sog_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_sog_comm_des", is_ricpar.s_ausil_value[1])

	CASE "a_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_cod_sog_comm", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2437
integer height = 876
long backcolor = 79741120
string text = "Cancellazione"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
cb_st_cancellazione cb_st_cancellazione
st_righe_non_cancellate st_righe_non_cancellate
sle_righe_non_cancellate sle_righe_non_cancellate
end type

on tabpage_2.create
this.dw_3=create dw_3
this.cb_st_cancellazione=create cb_st_cancellazione
this.st_righe_non_cancellate=create st_righe_non_cancellate
this.sle_righe_non_cancellate=create sle_righe_non_cancellate
this.Control[]={this.dw_3,&
this.cb_st_cancellazione,&
this.st_righe_non_cancellate,&
this.sle_righe_non_cancellate}
end on

on tabpage_2.destroy
destroy(this.dw_3)
destroy(this.cb_st_cancellazione)
destroy(this.st_righe_non_cancellate)
destroy(this.sle_righe_non_cancellate)
end on

type dw_3 from u_dw_main within tabpage_2
integer x = 18
integer y = 12
integer width = 2400
integer height = 724
integer taborder = 12
boolean bringtotop = true
string dataobject = "d_cancella_documenti2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;
end event

event dberror;return 1
end event

event itemerror;return 1
end event

event ue_validate_rows;return 1
end event

type cb_st_cancellazione from commandbutton within tabpage_2
integer x = 2112
integer y = 752
integer width = 283
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;tab_1.tabpage_2.dw_3.print()
end event

type st_righe_non_cancellate from statictext within tabpage_2
integer x = 142
integer y = 764
integer width = 585
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
boolean enabled = false
string text = "Righe non cancellate: "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_righe_non_cancellate from singlelineedit within tabpage_2
integer x = 754
integer y = 756
integer width = 297
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
boolean enabled = false
boolean border = false
boolean autohscroll = false
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2437
integer height = 876
long backcolor = 79741120
string text = "Saldi"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_4 dw_4
cb_preview cb_preview
cb_stampa cb_stampa
end type

on tabpage_3.create
this.dw_4=create dw_4
this.cb_preview=create cb_preview
this.cb_stampa=create cb_stampa
this.Control[]={this.dw_4,&
this.cb_preview,&
this.cb_stampa}
end on

on tabpage_3.destroy
destroy(this.dw_4)
destroy(this.cb_preview)
destroy(this.cb_stampa)
end on

type dw_4 from u_dw_ext_main within tabpage_3
integer x = 32
integer y = 12
integer width = 2368
integer height = 724
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_ver_saldi"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_preview from commandbutton within tabpage_3
integer x = 1815
integer y = 748
integer width = 274
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Preview"
end type

event clicked;if cb_preview.text='Preview' then
	cb_preview.text='Ritorna'
	printsetup()
	tab_1.tabpage_3.dw_4.object.datawindow.print.preview='yes'
	tab_1.tabpage_3.dw_4.object.datawindow.print.preview.rulers='yes'
	
else
	cb_preview.text='Preview'
	tab_1.tabpage_3.dw_4.object.datawindow.print.preview='no'
	tab_1.tabpage_3.dw_4.object.datawindow.print.preview.rulers='no'
end if


end event

type cb_stampa from commandbutton within tabpage_3
integer x = 2144
integer y = 748
integer width = 274
integer height = 108
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

event clicked;tab_1.tabpage_3.dw_4.print()
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2437
integer height = 876
long backcolor = 79741120
string text = "Articoli per Saldo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_4.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_4.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw_ext_main within tabpage_4
integer y = 28
integer width = 2405
integer height = 796
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Scegli Articolo per Metallo/Lire"
string dataobject = "d_orafo_met_articolo"
boolean vscrollbar = true
end type

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
CHOOSE CASE dwo.name
	CASE "cod_articolo"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_articolo"
		
		ls_dwc[1] = "cod_articolo"
		ls_dwc[2] = "des_articolo"
		ls_dwc[3] = "id_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)
				
	case "des_articolo"
		ls_sql_cond = ""
		

		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_articolo"
		
		ls_dwc[1] = "cod_articolo"
		ls_dwc[2] = "des_articolo"
		ls_dwc[3] = "id_articolo"
		
		li_ok = uf_autofind_col(dwo.Name, "articolo", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc) 
end choose
end event

event ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "cod_articolo", "des_articolo"
		is_search_window = "w_articolo_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		IF as_nomecol = "cod_articolo" THEN
			is_ricpar.s_filter_name = "articolo_codice"
		ELSEIF as_nomecol = "des_articolo" THEN
			is_ricpar.s_filter_name = "articolo_descrizione"
		END IF
end choose
end event

event ue_use_search;choose case as_nomecol
	CASE "cod_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_articolo", is_ricpar.s_ausil_value[1])
	CASE "des_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
   	uf_set_colval("id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_articolo", is_ricpar.s_ausil_value[1])
end choose
end event

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2437
integer height = 876
long backcolor = 79741120
string text = "Causali per Saldo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_5 dw_5
cb_save cb_save
end type

on tabpage_5.create
this.dw_5=create dw_5
this.cb_save=create cb_save
this.Control[]={this.dw_5,&
this.cb_save}
end on

on tabpage_5.destroy
destroy(this.dw_5)
destroy(this.cb_save)
end on

type dw_5 from datawindow within tabpage_5
integer x = 9
integer y = 12
integer width = 1829
integer height = 780
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_caus_per_saldi"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_save from commandbutton within tabpage_5
integer x = 1874
integer y = 16
integer width = 416
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva e Controlla"
end type

event clicked;integer li_ret, a, li_num
string ls_tipo
datawindowchild ldw_caus_saldi
dw_5.accepttext()
li_ret=dw_5.update()
if li_ret=1 then
	tab_1.tabpage_5.dw_5.retrieve()
	tab_1.tabpage_5.dw_5.getchild("id_caus_magazzino",ldw_caus_saldi)
	ldw_caus_saldi.settransobject(sqlca)
	ldw_caus_saldi.retrieve()
end if
li_ret=tab_1.tabpage_5.dw_5.rowcount()
if li_ret<8 then 
	wf_riempi_causali(li_ret)
end if
end event

type tabpage_6 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2437
integer height = 876
long backcolor = 79741120
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_6 dw_6
end type

on tabpage_6.create
this.dw_6=create dw_6
this.Control[]={this.dw_6}
end on

on tabpage_6.destroy
destroy(this.dw_6)
end on

type dw_6 from udw_000 within tabpage_6
integer x = 5
integer y = 12
integer width = 2235
integer height = 852
integer taborder = 21
string dataobject = "d_trova_partite_aperte_per_saldi"
end type

type cbx_controllo from checkbox within w_azzera_movimenti_wz
integer x = 1243
integer y = 12
integer width = 311
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
string text = "Controllo"
boolean checked = true
boolean lefttext = true
end type

type cbx_tk from checkbox within w_azzera_movimenti_wz
integer x = 873
integer y = 12
integer width = 352
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
string text = "Per Metallo"
boolean checked = true
boolean lefttext = true
end type

type cbx_solo_clfo from checkbox within w_azzera_movimenti_wz
integer x = 539
integer y = 12
integer width = 311
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
string text = "Solo Cl/Fo"
boolean lefttext = true
end type

type cb_saldi from commandbutton within w_azzera_movimenti_wz
event clicked pbm_bnclicked
integer x = 1774
integer y = 12
integer width = 480
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Azzera/Ricostruisci"
boolean cancel = true
end type

event clicked;
date ldt_inizio_es, ldt_fine_es
string ls_da_cod_sog_comm, ls_a_cod_sog_comm, ls_parametri
string ls_a_categoria, ls_da_categoria
date ld_da_data,ld_a_data
s_param_articoli str_param
integer li_ret
long ll_righe

tab_1.tabpage_1.dw_1.accepttext()
ll_righe=tab_1.tabpage_1.dw_1.getitemnumber(1, "id_registro")
if isnull(ll_righe) then
	messagebox("Errore!", "Non esiste un registro generico per creare i saldi!"&
	+"~r~nCrearne almeno uno dall'apposita finestra.")
	return
end if

idt_data_doc=tab_1.tabpage_1.dw_1.getitemdate(1, "data_documento")


il_id_esercizio=tab_1.tabpage_1.dw_1.getitemnumber(1, "id_esercizio")
if isnull(il_id_esercizio) then
	messagebox("Dati Incompleti!", "Esercizio non trovato")
	return
end if

select data_inizio, data_fine
into :ldt_inizio_es, :ldt_fine_es
from esercizio
where id_esercizio=:il_id_esercizio;
if sqlca.sqlcode<>0 then
	messagebox("Dati Incompleti!", "Esercizio non trovato")
	return
end if
if idt_data_doc>ldt_fine_es or idt_data_doc<ldt_inizio_es then
	messagebox("Dati Incoerenti!", "Data documento non compresa nell'esercizio scelto!")
	setfocus(tab_1.tabpage_1.dw_1)
	tab_1.tabpage_1.dw_1.setcolumn("id_esercizio")
	return
end if
select id_conto_predefinito
into :il_id_conto
from par_sistema;
if sqlca.sqlcode<>0 then
	messagebox("Attenzione!", "Contropartita predefinita non trovata in Parametri di Sistema!"&
					+"~r~nControllare e inserire la contropartita prima di lanciare questa procedura")
	return				
end if
select id_valuta
into :il_id_valuta
from par_sistema;
if isnull(il_id_valuta) then
	messagebox("Dati Incompleti!", "Inserire la valuta da utilizzare nei parametri di sistema")
end if

li_ret=messagebox("Attenzione!", "Prima di continuare eseguire una copia del database! ~r~n"&
+"Se la copia è già stata fatta premere 'SI' altrimenti 'NO'", stopsign!, yesno!)
if li_ret<>1 then return
ls_da_cod_sog_comm=tab_1.tabpage_1.dw_1.getitemstring(1,"da_cod_sog_comm")
ls_a_cod_sog_comm=tab_1.tabpage_1.dw_1.getitemstring(1,"a_cod_sog_comm")
if ls_da_cod_sog_comm>ls_a_cod_sog_comm or (isnull(ls_da_cod_sog_comm) and ls_a_cod_sog_comm>'') then
	messagebox("Attenzione!", "Sog. Com. iniziale maggiore di quello finale!")
	return
end if
if ls_da_cod_sog_comm>'' then ls_parametri=ls_parametri+'Da Codice Sog. Com: ' + ls_da_cod_sog_comm + " "
if ls_a_cod_sog_comm>'' then ls_parametri=ls_parametri+' A Codice Sog. Com: ' + ls_a_cod_sog_comm+ " "
ls_a_categoria=tab_1.tabpage_1.dw_1.getitemstring(1,"a_cod_cat")
ls_da_categoria=tab_1.tabpage_1.dw_1.getitemstring(1,"da_cod_cat")
if ls_da_categoria>ls_a_categoria or (isnull(ls_da_categoria) and ls_a_categoria>'') then
	messagebox("Attenzione!", "Causale iniziale maggiore di quella finale!")
	return
end if
if ls_a_categoria>'' then ls_parametri=ls_parametri+"~r~n"+'Da Causale: ' + ls_a_categoria + " "
if ls_da_categoria>'' then ls_parametri=ls_parametri+'A Causale: ' + ls_da_categoria + " "
ld_da_data=tab_1.tabpage_1.dw_1.getitemdate(1,"da_data")
ld_a_data=tab_1.tabpage_1.dw_1.getitemdate(1,"a_data")
if string(ld_da_data)>'' then ls_parametri=ls_parametri+'Da Data: ' + string(ld_da_data) + " "
if string(ld_a_data)>'' then ls_parametri=ls_parametri+'A Data: ' + string(ld_a_data) + " "
If (IsNull(ld_da_data) or IsNull(ld_a_data)) then
	MessageBox("Azzeramento Movimenti","Le date di inizio e fine sono obbligatorie",exclamation!)
	Return
End If
If ld_da_data > ld_a_data then
	MessageBox("Azzeramento Movimenti","La data iniziale è maggiore di quella finale",exclamation!)
	Return
End If


if ls_da_cod_sog_comm<='' or isnull(ls_da_cod_sog_comm) then ls_da_cod_sog_comm=' '
if ls_a_cod_sog_comm<='' or isnull(ls_a_cod_sog_comm) then ls_a_cod_sog_comm='ZZZZZZZZ'
if ls_da_categoria<='' or isnull(ls_da_categoria) then ls_da_categoria=' '
if ls_a_categoria<='' or isnull(ls_a_categoria) then ls_a_categoria='ZZZZZZZZ'


str_param.da_data=ld_da_data
str_param.a_data=ld_a_data
str_param.da_sog_comm=ls_da_cod_sog_comm
str_param.a_sog_comm=ls_a_cod_sog_comm
str_param.filtro=ls_parametri
str_param.da_CATEGORIA=ls_da_categoria
str_param.a_categoria = ls_a_categoria

li_ret=messagebox("Attenzione!", "Si è scelto di cancellare i documenti secondo la seguente selezione:~r~n"&
				+ls_parametri, stopsign!, yesno!)
if li_ret=1 then 
	li_ret=messagebox("Attenzione!", "Vuoi ricostruire i saldi per il periodo selezionato?", stopsign!, yesno!)
	if li_ret=1 then
		//20261126d (richiesta utente) i saldi di conto lavoro si ricostruiscono dalle partite (wf_new_ric_saldo riscritta)
		//e il magazzino con l esistenza di fine periodo (wf_saldi_magazzino); la procedura vecchia wf_ricostruisci_saldi
		//(un documento per articolo, dai movimenti) non si usa piu. Tutto o niente: un commit solo alla fine.
		li_ret = wf_new_ric_saldo(str_param)
		if li_ret = 1 then li_ret = wf_saldi_magazzino(str_param)
		if li_ret <> 1 then
			rollback;
			messagebox("Errore!", "Saldi non ricostruiti: non e~' stato salvato niente.")
			return
		end if
		commit;
		tab_1.selecttab(3)  //20261126b i saldi ricostruiti a video, poi la domanda con No predefinito (un Invio non cancella)
		ll_righe = tab_1.tabpage_3.dw_4.rowcount()
		li_ret=messagebox("Attenzione!", "Saldi ricostruiti: "+string(ll_righe)+" righe (pagina dei saldi): controllali.~r~n~r~nProcedere con la cancellazione?", stopsign!, yesno!, 2)
		if li_ret=1 then wf_azzera(str_param)
	else
		li_ret=messagebox("Attenzione!", "Procedere con la cancellazione?", stopsign!, yesno!, 2)  //20261126b No predefinito
		if li_ret=1 then wf_azzera(str_param)
	end if
	
end if
end event

type cb_annulla from commandbutton within w_azzera_movimenti_wz
integer x = 2272
integer y = 12
integer width = 210
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Chiudi"
boolean cancel = true
end type

event clicked;

Close(Parent)
end event

