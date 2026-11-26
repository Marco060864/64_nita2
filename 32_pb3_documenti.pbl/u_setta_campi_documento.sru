forward
global type u_setta_campi_documento from nonvisualobject
end type
end forward

global type u_setta_campi_documento from nonvisualobject
end type
global u_setta_campi_documento u_setta_campi_documento

forward prototypes
public function integer uf_setta_campi_sog_com (ref datawindow adw_dw, integer al_num_riga, long ll_id_sog_commerciale)
public function string uf_fat_acconto (long al_id_prof_doc)
public function integer uf_cerca_contropartita_predefinita (string as_fat_acconto)
public subroutine uf_set_istanza (datawindow dw_doc)
public function long uf_set_spesa_bollo ()
public function long uf_set_conto_predefinito (datawindow dw_doc)
public function string uf_set_tipo_doc (string as_id_tipo_doc, string as_id_tipo_reg, datawindow adw_doc, long al_row)
public function long uf_set_esercizio (datawindow adw_doc, long al_row)
public function string uf_trova_cod_fornitore (long al_id_doc, long al_id_sog, string as_cod_art, ref u_dw_master_main adw_riga)
public subroutine uf_set_campi_destinazione (ref u_dw_master_main adw_testa_documento)
public function long of_trova_uc (long al_id_art, long al_id_doc)
public function long of_crea_uc_e_prezzo (long ll_id_art, string ls_tipo_prezzo)
public function date uf_ver_num_data_coerenza (long al_id_registro, long al_num_progressivo, date adt_data_reg)
public function s_trova_progressivo uf_set_progressivo (long al_id_registro, long al_num_prog, string as_tipo_registro)
end prototypes

public function integer uf_setta_campi_sog_com (ref datawindow adw_dw, integer al_num_riga, long ll_id_sog_commerciale);
date			ld_lr_prot_documenti, ld_data_registrazione
long			 ll_id_lingua, ll_id_linguaggio, ll_id_valuta, ll_id_listino, ll_id_listino_prop
long 			ll_con_pagamento, ll_count, ll_size, ll_id_tab_iva, ll_id_riga, ll_id_articolo, ll_codice
long 			ll_id_des_articolo, ll_id_tipo_trasporto, ll_destinazione, ll_id_banca, ll_id_sog_com_vettore
long 			ll_id_profilo, ll_id_sog_com_vett_prop, ll_id_sog_comm_fattura
long			ll_id_gruppo_agenti, ll_variazione, ll_id_ana, ll_id_loc
string	 	ls_rag_soc, ls_tipo_iva, ls_codice, ls_info, ls_bollo, ls_prof_codice
decimal 		ldc_cambio
date			ld_data_doc
decimal		ld_parita_euro 

long ll_id_sog_com_vettore_2, ll_id_sog_com_vett_prop_2, ll_id_prof
string	 ls_trasp_mezzo_prop, ls_azienda

long ll_id_gruppo_agenti_2

if not (IsNull(ll_id_sog_commerciale) OR ll_id_sog_commerciale = 0) then

	  
SELECT   "sog_commerciale"."id_tipo_trasporto",   
         "sog_commerciale"."codice",   
         "sog_commerciale"."id_con_pagamento",   
         "sog_commerciale"."id_linguaggio",   
         "sog_commerciale"."id_listino",   
         "sog_commerciale"."id_tab_iva",   
         "sog_commerciale"."id_banca_sog_commerciale",   
         "sog_commerciale"."id_sog_com_vettore",   
         "sog_commerciale"."id_gruppo_agenti",   
         "sog_commerciale"."data_lr_prot_documenti",
			"sog_commerciale"."id_anagrafica",
			"sog_commerciale"."id_magazzino",
			
         "sog_commerciale"."id_sog_com_vettore_2",
			
			"sog_commerciale"."id_gruppo_agenti_2"
INTO :ll_id_tipo_trasporto,   
         :ls_codice,   
         :ll_con_pagamento,   
         :ll_id_linguaggio,   
         :ll_id_listino,  
			:ll_id_tab_iva,   
         :ll_id_banca,   
         :ll_id_sog_com_vettore,   
         :ll_id_gruppo_agenti,   
         :ld_lr_prot_documenti,
			:ll_id_ana,
			:ll_id_loc,
			
         :ll_id_sog_com_vettore_2,
			
			:ll_id_gruppo_agenti_2
FROM 		sog_commerciale  
WHERE 	id_sog_commerciale = :ll_id_sog_commerciale 
;
	
select   "valuta"."cambio", 
         "valuta"."parita_euro",
			"valuta"."id_valuta",  
         "anagrafica"."id_lingua",   
         "anagrafica"."bollo"  
into     :ldc_cambio,   
			:ld_parita_euro,		
         :ll_id_valuta,   
			:ll_id_lingua,  
         :ls_bollo  
from 		"anagrafica", "valuta"
WHERE 	"anagrafica"."id_anagrafica"=:ll_id_ana
and   ( "valuta"."id_valuta" = "anagrafica"."id_valuta" ) ;

		adw_dw.SetItem(al_num_riga,"c_sog_comm_des", ls_rag_soc)
		adw_dw.SetItem(al_num_riga,"c_sog_comm_cod", ls_codice)
		adw_dw.setitem(al_num_riga, "bollo", ls_bollo)
		
		ll_id_sog_comm_fattura=adw_dw.GetItemNumber(al_num_riga,"documento_id_sog_commerciale_fattura")
	if (IsNull(ll_id_sog_comm_fattura) OR ll_id_sog_comm_fattura = 0) then 
			adw_dw.SetItem(al_num_riga,"documento_id_sog_commerciale_fattura", ll_id_sog_commerciale)
		end if
		if not (IsNull(ll_id_tipo_trasporto) OR ll_id_tipo_trasporto = 0) then 
			adw_dw.SetItem(al_num_riga,"id_tipo_trasporto", ll_id_tipo_trasporto)
		end if
			adw_dw.SetItem(al_num_riga,"id_gruppo_agenti", ll_id_gruppo_agenti)
			
			adw_dw.SetItem(al_num_riga,"id_gruppo_agenti_2", ll_id_gruppo_agenti_2)
		if not (IsNull(ll_id_lingua) OR ll_id_lingua = 0) then 
			adw_dw.SetItem(al_num_riga,"id_lingua", ll_id_lingua)
		end if
		if not (IsNull(ll_id_valuta) OR ll_id_valuta = 0) then 
			adw_dw.SetItem(al_num_riga,"documento_id_valuta_des", ll_id_valuta)
			
		end if
		if not (IsNull(ll_id_linguaggio) OR ll_id_linguaggio = 0) then 
			adw_dw.SetItem(al_num_riga,"documento_id_linguaggio", ll_id_linguaggio)
		end if
		if not (IsNull(ll_id_listino) OR ll_id_listino = 0) then 
			adw_dw.SetItem(al_num_riga,"documento_id_listino", ll_id_listino)
		end if
		//010415 solo per Elisa (Samy)
		select codice into :ls_azienda from dba.azienda;
		if ll_id_sog_commerciale=680 and ls_azienda="SILVERDR" then
			ll_id_prof=adw_dw.getitemnumber(1, "id_prof_documento")
			if ll_id_prof=48 or ll_id_prof=25 or ll_id_prof=152   then //or ll_id_prof=148 tolto 02-02-2016
				ll_con_pagamento=34
			end if
		end if
		//fine 010415
		adw_dw.SetItem(al_num_riga,"id_con_pagamento", ll_con_pagamento)
		if not (IsNull(ll_id_banca) OR ll_id_banca = 0) then 
			adw_dw.SetItem(al_num_riga,"id_banca_sog_commerciale", ll_id_banca)
		end if
		
		
		long		ll_id_val_euro, ll_id_val_az, ll_id_esercizio

		SELECT 	id_val_euro
		INTO		:ll_id_val_euro
		FROM		par_sistema
		;

	   ll_id_esercizio = adw_dw.getitemnumber(1, "c_esercizio")

		SELECT	id_valuta
		INTO		:ll_id_val_az  
		FROM		esercizio
		WHERE		id_esercizio = :ll_id_esercizio
		;
		
		if ll_id_val_az = ll_id_val_euro then ldc_cambio = ld_parita_euro 
		
		
		
		if not (IsNull(ldc_cambio) OR ldc_cambio = 0) then 
			adw_dw.SetItem(al_num_riga,"documento_cambio", ldc_cambio)
		end if
		ld_data_doc=adw_dw.getitemdate(al_num_riga,"data_documento")
		select id_variazione
		into :ll_variazione
		from variazione
		where (id_listino=:ll_id_listino)
		AND 	(data_inizio <= :ld_data_doc 
		AND (data_fine >= :ld_data_doc OR data_fine IS NULL)); 		
		if  ll_variazione > 0 then 
			adw_dw.SetItem(al_num_riga,"documento_id_variazione", ll_variazione)		
		end if
		ll_id_profilo= adw_dw.GetItemNumber(al_num_riga, "id_prof_documento")
		if not IsNull(ll_id_profilo) then
			SELECT "prof_documento"."id_sog_comm_vettore_1_prop",
					 "prof_documento"."id_sog_comm_vettore_2_prop", "prof_documento"."trasp_mezzo_prop" ,
					 id_listino_prop, codice
			INTO :ll_id_sog_com_vett_prop, :ll_id_sog_com_vett_prop_2, :ls_trasp_mezzo_prop, :ll_id_listino_prop, :ls_prof_codice
			FROM "dba"."prof_documento"  
			WHERE "prof_documento"."id_prof_documento" = :ll_id_profilo   
			;
			
			//20230920 Luisa Munna vuole legare prioritariamente il listino al profilo
			select rag_soc_1 into :ls_azienda from dba.azienda;
			ls_azienda=upper(ls_azienda)
			if ls_prof_codice="RBOL2" and (pos(ls_azienda, "ITALPANNA")>0 or  pos(ls_azienda, "SILVERSTELLE")>0) then
				ll_variazione=ll_id_listino_prop
				if  ll_variazione > 0 then 
					adw_dw.SetItem(al_num_riga,"documento_id_variazione", ll_variazione)	
				end if
			end if
			//20230920 fine		
			if (ls_trasp_mezzo_prop = "V") then
				if (isnull(ll_id_sog_com_vettore)) then
					adw_dw.SetItem(al_num_riga,"documento_id_sog_commerciale_vettore", ll_id_sog_com_vett_prop)				
				else
					adw_dw.SetItem(al_num_riga,"documento_id_sog_commerciale_vettore", ll_id_sog_com_vettore)				
				end if
			
				if (isnull(ll_id_sog_com_vettore_2)) then
					adw_dw.SetItem(al_num_riga,"documento_id_sog_commerciale_vettore_2", ll_id_sog_com_vett_prop_2)				
				else
					adw_dw.SetItem(al_num_riga,"documento_id_sog_commerciale_vettore_2", ll_id_sog_com_vettore_2)				
				end if
			end if
		end if
		
else
	adw_dw.SetItem(al_num_riga,"cinfo", "")

end if
	
return 0
end function

public function string uf_fat_acconto (long al_id_prof_doc);string ls_fat_anticipo
select fat_anticipo
into :ls_fat_anticipo
from prof_documento
where id_prof_documento=:al_id_prof_doc;

return ls_fat_anticipo
end function

public function integer uf_cerca_contropartita_predefinita (string as_fat_acconto);
string ls_fat_anticipo
long ll_id_contropartita

if as_fat_acconto='S' then 
	SELECT "par_sistema"."id_cont_gen_acconto"  
	INTO :ll_id_contropartita  
	FROM "dba"."par_sistema"  	
	WHERE "par_sistema"."id_azienda" =1   ;
else 
	SELECT "par_sistema"."id_conto_predefinito"  
	INTO :ll_id_contropartita  
	FROM "dba"."par_sistema"  
	WHERE "par_sistema"."id_azienda" =1  ;
end if

return ll_id_contropartita
end function

public subroutine uf_set_istanza (datawindow dw_doc);

string ls_my_den_abi
long   ll_my_id_banca_appoggio
long	 ll_my_id	
long	row


row = dw_doc.getrow()
ll_my_id = dw_doc.getitemnumber(row,"id_banca_sog_commerciale")



					 
SELECT	den_abi + ' - ' + den_cab
INTO	   :ls_my_den_abi
FROM	   banca_sog_commerciale_gen
WHERE	   id_banca_sog_commerciale = :ll_my_id
;

If SQLCA.SQLCODE = -1 Then
	MessageBox("", SQLCA.SQLERRTEXT)
End If

dw_doc.setitem(row,"c_abi_cab_des", ls_my_den_abi )







end subroutine

public function long uf_set_spesa_bollo ();
long ll_id_spesa_bollo

SELECT "spesa"."id_spesa"  
	INTO :ll_id_spesa_bollo  
	FROM "dba"."spesa"  
	WHERE "spesa"."codice" = 'B' ;
	
if sqlca.sqlcode=0 then
	return	ll_id_spesa_bollo
else
	
	setnull(ll_id_spesa_bollo)
	return ll_id_spesa_bollo
end if
end function

public function long uf_set_conto_predefinito (datawindow dw_doc);long ll_id_azienda
ll_id_azienda=dw_doc.getrow()
if ll_id_azienda>0 then
	ll_id_azienda= dw_doc.GetItemNumber(dw_doc.getrow(), "documento_id_azienda")
	SELECT "par_sistema"."id_conto_predefinito"  
	INTO :ll_id_azienda  
	FROM "dba"."par_sistema"  
	WHERE "par_sistema"."id_azienda" = :ll_id_azienda   ;
	
	if sqlca.sqlcode=0 then
		return ll_id_azienda
	else
		messagebox("Attenzione!", "Conto predefinito non trovato")
		setnull(ll_id_azienda)
		return ll_id_azienda
	end if
	
else
	setnull(ll_id_azienda)
	return ll_id_azienda
end if
	
end function

public function string uf_set_tipo_doc (string as_id_tipo_doc, string as_id_tipo_reg, datawindow adw_doc, long al_row);
long		ll_id_registro

If IsNull(as_id_tipo_doc) OR as_id_tipo_doc="" then 
	If  IsNull(as_id_tipo_reg) OR as_id_tipo_reg="" then
		ll_id_registro= adw_doc.GetItemNumber(al_row , "id_registro")
		If not (IsNull(ll_id_registro) OR ll_id_registro=0) then 
			SELECT "registro"."tipo_registro"  
				INTO :as_id_tipo_reg  
				FROM "registro"  
				WHERE "registro"."id_registro" = :ll_id_registro ;
		end if
	end if 
	CHOOSE CASE as_id_tipo_reg
		CASE "OA","OV"
			as_id_tipo_doc="O"
		CASE "IA","IV", "IC"
			as_id_tipo_doc="F"
		CASE "PA","PV"
			as_id_tipo_doc="P"
		CASE "DA","DV"
			as_id_tipo_doc="D"
	END CHOOSE
	
end if
RETURN as_id_tipo_doc
end function

public function long uf_set_esercizio (datawindow adw_doc, long al_row);long ll_id_registro, ll_id_esercizio
ll_id_registro = adw_doc.GetItemNumber(al_row,"id_registro")
IF NOT (IsNull(ll_id_registro) OR ll_id_registro = 0) THEN
	SELECT "esercizio"."id_esercizio" 
		INTO :ll_id_esercizio 
		FROM "dba"."esercizio",   
			"dba"."registro"  
		WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
			( ( "registro"."id_registro" = :ll_id_registro ) )   ;
else
		SELECT "azienda"."id_esercizio_proposto"
			INTO :ll_id_esercizio
			FROM "dba"."azienda"   
			WHERE ( "azienda"."id_azienda" = 1 );
end if

return ll_id_esercizio

end function

public function string uf_trova_cod_fornitore (long al_id_doc, long al_id_sog, string as_cod_art, ref u_dw_master_main adw_riga);
long ll_art, ll_id_sog
string ls_cod_for

select count(id_articolo)
into :ll_art
from des_articolo 
where codice=:as_cod_art;
if ll_art>1 then
	
	
	s_ric_param is_ricpar
	is_ricpar.s_filter_value = as_cod_art 
	is_ricpar.s_filter_name = "des_articolo_codice" 
	is_ricpar.b_asneeded=TRUE
	openwithparm( w_articolo_coddes_documento_sw, is_ricpar) 
	adw_riga.is_ricpar=message.powerobjectparm
	adw_riga.post event ue_use_search("c_articolo_cod")
	
	
	return '-1'
end if


select id_articolo, id_sog_commerciale
into :ll_art, :ll_id_sog
from des_articolo 
where codice=:as_cod_art;

if ll_art>0 then		
	select codice 
	into :ls_cod_for
	from articolo
	where id_articolo=:ll_art;
	if ls_cod_for>'' then
		return ls_cod_for
	else
		return ''
	end if
else
	return ''
end if




end function

public subroutine uf_set_campi_destinazione (ref u_dw_master_main adw_testa_documento);long ll_row, ll_id_destinazione, ll_id_gruppo_agenti, ll_id_gruppo_agenti_2
long ll_id_con_pagamento

ll_row=adw_testa_documento.getrow()
ll_id_destinazione=adw_testa_documento.getitemnumber(ll_row, "id_destinazione")

SELECT id_gruppo_agenti, id_gruppo_agenti_2, id_con_pagamento
INTO	 :ll_id_gruppo_agenti, :ll_id_gruppo_agenti_2, 
		 :ll_id_con_pagamento 
FROM	 destinazione
WHERE  id_destinazione = :ll_id_destinazione
;

choose case SQLCA.SQLCODE
	case -1
		messagebox("DBError", SQLCA.SQLERRTEXT)
	case 0
		if (ll_id_gruppo_agenti > 0) and (not isnull(ll_id_gruppo_agenti)) then	adw_testa_documento.setitem(ll_row, "id_gruppo_agenti", ll_id_gruppo_agenti)
		if (ll_id_gruppo_agenti_2 > 0) and (not isnull(ll_id_gruppo_agenti_2)) then	adw_testa_documento.setitem(ll_row, "id_gruppo_agenti_2", ll_id_gruppo_agenti_2)		
		if (ll_id_con_pagamento > 0) and (not isnull(ll_id_con_pagamento)) then	adw_testa_documento.setitem(ll_row, "id_con_pagamento_des", ll_id_con_pagamento)	
end choose
end subroutine

public function long of_trova_uc (long al_id_art, long al_id_doc);
 
long ll_id_uc_base, ll_id_uC
string ls_tipo
integer li_righe
select u.tipo, c.id_unita_confezione 
into :ls_tipo, :ll_id_uc
from unita_misura u, unita_confezione c
where c.id_unita_misura=u.id_unita_misura
and c.id_articolo=:al_id_art
and c.unita_base='S'
;
if ls_tipo<>'P' then
	return ll_id_uC
end if

select id_titolo
into :ll_id_uC
from articolo
where id_articolo=:al_id_art
;

datastore ds_ucb, ds_var_prezzo
ds_ucb=create datastore
ds_var_prezzo=create datastore
ds_ucb.dataobject="d_cerca_uc"
ds_var_prezzo.dataobject="d_prezzo_documento"
ds_var_prezzo.settransobject(sqlca)
ds_ucb.settransobject(sqlca)
ds_var_prezzo.setfilter('id_titolo='+string(ll_id_uC))
ds_var_prezzo.filter()

li_righe=ds_var_prezzo.retrieve(al_id_doc)
if li_righe>0 then
	ll_id_uC=ds_var_prezzo.getitemnumber(1, "id_unita_conf_base")
	if ll_id_uC=1 then ls_tipo='S' else ls_tipo='N' 
	li_righe=ds_ucb.retrieve(ls_tipo, al_id_art)
	if li_righe>0 then
		ll_id_uC=ds_ucb.getitemnumber(1, "id_unita_confezione")
	else
		
		ll_id_uC=of_crea_uc_e_prezzo(al_id_art, ls_tipo)
	end if
else
	select id_unita_confezione
	into :ll_id_uC
	from unita_confezione
	where id_articolo=:al_id_art
	and unita_base='S';
end if
destroy ds_ucb
destroy ds_var_prezzo
return ll_id_uC
end function

public function long of_crea_uc_e_prezzo (long ll_id_art, string ls_tipo_prezzo);
string ls_codice
long ll_id_uc	, ll_null, ll_id_uc_nuova
integer ll_righe
datastore ds_uc, ds_prezzo
setnull(ll_null)
select id_unita_confezione
into :ll_id_uc
from unita_confezione
where id_articolo=:ll_id_art
and unita_base='S';
if sqlca.sqlcode<>0 then
	messagebox("Errore!", "Non esiste Unità confezione di base per id_articolo="+string(ll_id_art))
	destroy ds_uc
	return 0
end if
if isnull(ls_tipo_prezzo) then
	messagebox("Dati Incompleti", "Non è stato specificato il tipo di prezzo da applicare~r~n"&
	+"Sarà applicato il prezzo Manifattura")
	ls_tipo_prezzo='N'
end if

ds_uc=create datastore
ds_uc.dataobject="d_orafo_duplica_unita_confezione"
ds_uc.settransobject(sqlca)
ll_righe=ds_uc.retrieve(ll_id_uc)
if ll_righe>0 then
	ds_uc.setitem(1, "id_unita_confezione", ll_null)
	ds_uc.setitem(1, "unita_produzione", ls_tipo_prezzo)
	ls_codice=ds_uc.getitemstring(1, "codice")
	ls_codice=left(ls_codice, 6)+"_1"
	ds_uc.setitem(1, "codice", ls_codice)
	ds_uc.setitem(1, "unita_base", "N")
	ds_uc.setitem(1, "unita_documenti", "N")
	ll_id_uc_nuova=ds_uc.setitemstatus(1, 0, primary!,newmodified!)
	if ll_id_uc_nuova<>1 then
		messagebox("Attenzione!", "Stato UC non modificato!")
	end if
	ll_id_uc_nuova=ds_uc.update()
	
	if ll_id_uc_nuova>0 then
		ll_id_uc_nuova=ds_uc.getitemnumber(1, "id_unita_confezione")
		ds_prezzo=create datastore
		ds_prezzo.dataobject="d_inserisci_prezzo_uc"
		ds_prezzo.settransobject(sqlca)
		ll_righe=ds_prezzo.retrieve(ll_id_uc)
		if ll_righe>0 then
			ds_prezzo.setitem(1, "prezzo_id_unita_confezione",ll_id_uc_nuova)
			ll_righe=ds_prezzo.setitemstatus(1, 0, primary!,newmodified!)
			if ll_righe<>1 then
				messagebox("Attenzione!", "Stato prezzo non modificato!")
			end if
			ll_righe=ds_prezzo.update()
			if ll_righe<>1 then
				messagebox("Attenzione!", "Impossibile inserire tabella Prezzo. ~r~nInserire prezzo manualmente e riprovare!")
				
			end if
		else
			messagebox("Attenzione!", "Impossibile inserire Prezzo. ~r~nInserire prezzo manualmente e riprovare!")
		end if
	else
		messagebox("Attenzione!", "Unita Confezione non salvata!")
		
	end if
else
	messagebox("Incredibile!", "Non esiste ciò che esiste!!!")
end if
destroy ds_prezzo
destroy ds_uc
return ll_id_uc_nuova



end function

public function date uf_ver_num_data_coerenza (long al_id_registro, long al_num_progressivo, date adt_data_reg);
date ldt_data_precedente, ldt_data_successivo, ldt_data_ok

select data_registrazione
into :ldt_data_precedente
from documento
where id_registro=:al_id_registro
and num_progressivo=:al_num_progressivo - 1;
if isnull(adt_data_reg) then
	return ldt_data_precedente
else
	select data_registrazione
	into :ldt_data_successivo
	from documento
	where id_registro=:al_id_registro
	and num_progressivo=:al_num_progressivo +1;
	if sqlca.sqlcode<>0 then //non c'è doc successivo
		if adt_data_reg>ldt_data_precedente then ldt_data_precedente=adt_data_reg
		return ldt_data_precedente
	else
		if ldt_data_precedente<=adt_data_reg and  ldt_data_successivo>=adt_data_reg then
			return adt_data_reg
		else
			return ldt_data_successivo
		end if
	end if
end if

end function

public function s_trova_progressivo uf_set_progressivo (long al_id_registro, long al_num_prog, string as_tipo_registro);
long ll_prog_registro, ll_contatore
s_trova_progressivo s_trova_prog
if al_num_prog>0 then
	s_trova_prog.sl_num_progressivo=al_num_prog
else
	select num_progressivo
	into :ll_prog_registro
	from registro
	where id_registro=:al_id_registro;
	s_trova_prog.sl_num_progressivo=ll_prog_registro
	if isnull(ll_prog_registro) then 
		ll_prog_registro=1
		if messagebox("Attenzione!" , "E' il primo documento dell'anno di questo tipo?", stopsign!, YESNO!)=1 then
			s_trova_prog.sl_num_progressivo= 1
		else
			s_trova_prog.sl_num_progressivo= -100
		end if
	end if
end if
IF al_num_prog>0 then
	select data_registrazione, id_documento
	into :s_trova_prog.sdt_data_registrazione, :s_trova_prog.sl_id_documento
	from documento
	where id_registro=:al_id_registro
	and num_progressivo=:s_trova_prog.sl_num_progressivo;
	
	if sqlca.sqlcode=0 then
		
		
		
		
		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	else
		
		IF left(as_tipo_registro, 1)='I' then
			select data_registrazione
			into :s_trova_prog.sdt_data_registrazione
			from reg_pd
			where id_registro=:al_id_registro
			and num_progressivo=:s_trova_prog.sl_num_progressivo;
			if sqlca.sqlcode=0 then
	
	
				s_trova_prog.sl_num_progressivo= -100
				s_trova_prog.sl_id_documento= -1
				return s_trova_prog
			end if
		END IF
	END IF	
else
	do 
		ll_contatore++
		select data_registrazione
		into :s_trova_prog.sdt_data_registrazione
		from documento
		where id_registro=:al_id_registro
		and num_progressivo=:s_trova_prog.sl_num_progressivo - :ll_contatore;
		IF SQLCA.SQLCODE<>0 AND left(as_tipo_registro, 1)='I'  THEN
			select data_registrazione
			into :s_trova_prog.sdt_data_registrazione
			from REG_PD
			where id_registro=:al_id_registro
			and num_progressivo=:s_trova_prog.sl_num_progressivo - :ll_contatore;
		END IF	
	LOOP WHILE  sqlca.sqlcode<>0 and s_trova_prog.sl_num_progressivo>ll_contatore
end if
if ll_contatore>0 and  s_trova_prog.sdt_data_registrazione > date('1969-06-09') then
	if ll_contatore>1 then
		s_trova_prog.sl_num_progressivo -= ll_contatore 
		s_trova_prog.sl_num_progressivo++ 
		update registro
		set num_progressivo=:s_trova_prog.sl_num_progressivo +1 
		where id_registro=:al_id_registro
		and num_progressivo>=:s_trova_prog.sl_num_progressivo;
		if sqlca.sqlcode=0 then
			commit;
		else
			messagebox("Attenzione!" , "Numero progressivo non salvato nel registro")
			rollback;
		end if
	end if


end if

return s_trova_prog


end function

on u_setta_campi_documento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_setta_campi_documento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

