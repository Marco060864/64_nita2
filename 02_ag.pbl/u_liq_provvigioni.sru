forward
global type u_liq_provvigioni from nonvisualobject
end type
end forward

global type u_liq_provvigioni from nonvisualobject
end type
global u_liq_provvigioni u_liq_provvigioni

type variables
boolean ib_definitiva,ib_pagamenti
end variables

forward prototypes
public subroutine uf_liq_provvigioni (long al_id_documento)
public subroutine uf_budget (ref s_budget as_budget[], date ad_elaborazione)
public function boolean uf_liquidazione_provvigioni (long aid_reg_pd, long aid_documento, date ad_data_icassi, long aid_agente, long aid_riep_provvigioni, date ad_data_elaborazione, string as_periodo, ref s_budget as_budget[])
public function boolean uf_liquidazione_provvigioni (long aid_reg_pd, long aid_documento, date ad_data_icassi, long aid_agente, long aid_riep_provvigioni, date ad_data_elaborazione, string as_periodo, ref s_budget as_budget[], string as_definitiva, long al_id_gruppo_agenti)
public function decimal uf_importo_provvigioni (long aid_riep_provvigioni, string tipo_provv)
end prototypes

public subroutine uf_liq_provvigioni (long al_id_documento);
	

long ll_righe,ll_id_agente,i,ll_row,ll_id_riep_provvigioni
decimal{4} ld_provvigioni,ld_imp_provv
string ls_tipo_fattura
long ll_id_agente_2 
long ll_id_gruppo_agenti 
datastore lds_agenti_righe_documento
datastore lds_provv_per, lds_provv_imp

char 		lc_modo_liquidazione
integer  li_i
long	   ll_id_riga_documento

select tipo_fattura
into 	 :ls_tipo_fattura
from 	 documento
where  id_documento=:al_id_documento;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If
	
lds_agenti_righe_documento = CREATE datastore
lds_agenti_righe_documento.dataobject = 'd_riep_provv_agente'
lds_agenti_righe_documento.settransobject(sqlca)
lds_agenti_righe_documento.retrieve(al_id_documento)

ll_righe=lds_agenti_righe_documento.rowcount()
if ll_righe>0 then
	for ll_row=1 to ll_righe
		ll_id_agente=lds_agenti_righe_documento.getitemnumber(ll_row,"id_agente")
		ll_id_gruppo_agenti=lds_agenti_righe_documento.getitemnumber(ll_row,"gruppo_agenti_id_gruppo_agenti")
		if (ll_id_agente>0) and (not isnull(ll_id_agente)) then
			INSERT INTO riep_provvigioni (id_documento, id_agente, stato_provvigioni, id_gruppo_agenti)
			VALUES (:al_id_documento, :ll_id_agente, 'A', :ll_id_gruppo_agenti)
			;
			
			if (SQLCA.SQLCODE = -1) then
				MessageBox("DB Error", SQLCA.SQLERRTEXT)
			end if
			
			COMMIT;
		end if
	next
end if

lds_provv_per = CREATE datastore
lds_provv_imp = create datastore
lds_provv_per.dataobject = 'd_riep_provv_perc'
lds_provv_imp.dataobject = 'd_riep_provv_imp'
lds_provv_per.settransobject(sqlca)
lds_provv_imp.settransobject(sqlca)
lds_provv_per.retrieve(al_id_documento)
lds_provv_imp.retrieve(al_id_documento)

SELECT modo_liquidazione
INTO	 :lc_modo_liquidazione
FROM	 par_sistema
;

ll_righe=lds_provv_imp.rowcount()
if ll_righe>0 then
	

	if (lc_modo_liquidazione = 'D') then
		for li_i = 1 to ll_righe
			ll_id_agente  =lds_provv_imp.getitemnumber(li_i,"id_agente")
			ld_provvigioni=lds_provv_imp.getitemnumber(li_i,"prov_imp_qta")
			ld_imp_provv=lds_provv_imp.getitemnumber(li_i,"imp_prov_tot")
			ll_id_riga_documento=lds_provv_imp.getitemnumber(li_i,"riga_documento_id_riga_documento")
			
			SELECT id_riep_provvigioni
			INTO	 :ll_id_riep_provvigioni
			FROM	 riep_provvigioni
			WHERE	 id_agente=:ll_id_agente
			AND	 id_documento=:al_id_documento;
			
			If SQLCA.SQLCODE = -1 Then
				MessageBox("Database Error", SQLCA.SQLERRTEXT)
			End If
			
			if ls_tipo_fattura='C' then
				if ld_imp_provv>0 then ld_imp_provv=ld_imp_provv * -1
				if ld_provvigioni>0 then ld_provvigioni=ld_provvigioni * -1
			end if
			INSERT INTO riep_prov_righe (id_riep_provvigioni,provvigioni,tipo_prov,
												  imp_provv_documento, id_riga_documento,
												  modo_liquidazione)
			VALUES (:ll_id_riep_provvigioni,:ld_provvigioni,'I',
					  :ld_imp_provv, :ll_id_riga_documento, 'D');
			
			If SQLCA.SQLCODE = -1 Then
				MessageBox("Database Error", SQLCA.SQLERRTEXT, stopsign!)
			End If			
		next
	
	else
		
		ll_row=lds_provv_imp.FindGroupChange (1,1)
		do while ll_row>0 
			ll_id_agente=lds_provv_imp.getitemnumber(ll_row,"id_agente")
			ld_provvigioni=lds_provv_imp.getitemnumber(ll_row,"provv_tot")
			ld_imp_provv=lds_provv_imp.getitemnumber(ll_row,"imp_prov_tot")
			ll_id_riga_documento=lds_provv_imp.getitemnumber(1,"riga_documento_id_riga_documento")	
			select id_riep_provvigioni
			into :ll_id_riep_provvigioni
			from riep_provvigioni
			where id_agente=:ll_id_agente
			and id_documento=:al_id_documento;
			
			If SQLCA.SQLCODE = -1 Then
				MessageBox("Database Error", SQLCA.SQLERRTEXT)
			End If
			
			if ls_tipo_fattura='C' then
				if ld_imp_provv>0 then ld_imp_provv=ld_imp_provv * -1
				if ld_provvigioni>0 then ld_provvigioni=ld_provvigioni * -1
			end if
			
			insert into riep_prov_righe (id_riep_provvigioni,provvigioni,
											     tipo_prov,imp_provv_documento,
												  id_riga_documento,modo_liquidazione)												  
			values (:ll_id_riep_provvigioni,:ld_provvigioni,'I',:ld_imp_provv,
					  :ll_id_riga_documento, 'R');
			
			If SQLCA.SQLCODE = -1 Then
				MessageBox("Database Error", SQLCA.SQLERRTEXT, stopsign!)
			End If
			
	
	
			ll_row=lds_provv_imp.FindGroupChange (ll_row+1,1)
		loop
	end if
end if
ll_righe=lds_provv_per.rowcount()
if ll_righe>0 then
	
	if (lc_modo_liquidazione = 'D') then
		for li_i = 1 to ll_righe
			ll_id_agente=lds_provv_per.getitemnumber(li_i,"id_agente")
			ld_provvigioni=lds_provv_per.getitemnumber(li_i,"riga_documento_provv_carea")
			ld_imp_provv=lds_provv_per.getitemnumber(li_i,"imp_provv_tot")
			ll_id_riga_documento=lds_provv_per.getitemnumber(li_i,"riga_documento_id_riga_documento")	
			
			SELECT id_riep_provvigioni
			INTO	 :ll_id_riep_provvigioni
			FROM	 riep_provvigioni
			WHERE	 id_agente=:ll_id_agente
			AND	 id_documento=:al_id_documento;
			
			If SQLCA.SQLCODE = -1 Then
				MessageBox("Database Error", SQLCA.SQLERRTEXT)
			End If
			
			
			if ls_tipo_fattura='C' then
				if ld_imp_provv>0 then ld_imp_provv=ld_imp_provv * -1
			end if
			INSERT INTO riep_prov_righe (id_riep_provvigioni,provvigioni,tipo_prov,
												  imp_provv_documento,
												  id_riga_documento,modo_liquidazione)
			VALUES (:ll_id_riep_provvigioni,:ld_provvigioni,'P',:ld_imp_provv,
					  :ll_id_riga_documento, 'D');
	
			If SQLCA.SQLCODE = -1 Then
				MessageBox("Database Error", SQLCA.SQLERRTEXT, stopsign!)
			End If		
		next
	else
	
	
		ll_row=lds_provv_per.FindGroupChange (1,1)
		do while ll_row>0 
			ll_id_agente=lds_provv_per.getitemnumber(ll_row,"id_agente")
			ld_provvigioni=lds_provv_per.getitemnumber(ll_row,"provv_tot")
			ld_imp_provv=lds_provv_per.getitemnumber(ll_row,"imp_provv_tot")
			ll_id_riga_documento=lds_provv_per.getitemnumber(1,"riga_documento_id_riga_documento")	
			
			select id_riep_provvigioni
			into :ll_id_riep_provvigioni
			from riep_provvigioni
			where id_agente=:ll_id_agente
			and id_documento=:al_id_documento;
			
			If SQLCA.SQLCODE = -1 Then
				MessageBox("Database Error", SQLCA.SQLERRTEXT)
			End If
			
			
			if ls_tipo_fattura='C' then
				if ld_imp_provv>0 then ld_imp_provv=ld_imp_provv * -1
			end if
			
			insert into riep_prov_righe (id_riep_provvigioni,provvigioni,tipo_prov,
												  imp_provv_documento,
												  id_riga_documento,modo_liquidazione)
			values (:ll_id_riep_provvigioni,:ld_provvigioni,'P',:ld_imp_provv,
					  :ll_id_riga_documento, 'R');
	
			If SQLCA.SQLCODE = -1 Then
				MessageBox("Database Error", SQLCA.SQLERRTEXT, stopsign!)
			End If		
			
	
	
			ll_row=lds_provv_per.FindGroupChange (ll_row+1,1)
		loop
	end if
end if

destroy lds_provv_per
destroy lds_provv_imp
end subroutine

public subroutine uf_budget (ref s_budget as_budget[], date ad_elaborazione);
integer li_size,i, i1
decimal{4} ld_importo,ld_percentuale,ld_budget,ld_cambio
long ll_valuta
li_size=upperbound(as_budget)
for i=1 to li_size
	
	select importo,premio,id_valuta
	into :ld_importo,:ld_percentuale,:ll_valuta
	from budget 
	where id_sog_commerciale=:as_budget[i].id_agente
	and anno=:as_budget[i].anno
	and mese=:as_budget[i].mese;
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If	
	
	if sqlca.sqlcode=0 then
		
		select cambio
		into :ld_cambio
		from valuta
		where id_valuta=:ll_valuta;
		
		If SQLCA.SQLCODE = -1 Then
			MessageBox("Database Error", SQLCA.SQLERRTEXT)
		End If
		
		if isnull(ld_cambio) then ld_cambio=1
		
		ld_importo=ld_importo * ld_cambio
		
		if ld_importo<=as_budget[i].imponibile then
			
			If isnull(ld_budget) Then ld_budget = 0
			i1 = i - 1			
			If i > 1 Then
				If as_budget[i].id_agente = as_budget[i1].id_agente Then
					ld_budget=ld_budget + (as_budget[i].imponibile * ld_percentuale) / 100
				Else
					ld_budget=(as_budget[i].imponibile * ld_percentuale) / 100
				End If
			Else
				ld_budget=(as_budget[i].imponibile * ld_percentuale) / 100				
			End If
			as_budget[i].imponibile=ld_budget
		end if
	end if
	
	If i+1 <= li_size Then
		If as_budget[i].id_agente <> as_budget[i+1].id_agente Then
			update sog_commerciale
			set imp_fisso_ult_elab=imp_fisso,
			imp_premio_budget=:ld_budget,
			prec_elab_definitivo=ult_elab_definitivo,
			ult_elab_definitivo=:ad_elaborazione
			where id_sog_commerciale=:as_budget[i].id_agente
			and (ult_elab_definitivo<>:ad_elaborazione or ult_elab_definitivo is null);
		End If
	Else
		update sog_commerciale
		set imp_fisso_ult_elab=imp_fisso,
		imp_premio_budget=:ld_budget,
		prec_elab_definitivo=ult_elab_definitivo,
		ult_elab_definitivo=:ad_elaborazione
		where id_sog_commerciale=:as_budget[i].id_agente
		and (ult_elab_definitivo<>:ad_elaborazione or ult_elab_definitivo is null);		
	End If
		
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If	
next
end subroutine

public function boolean uf_liquidazione_provvigioni (long aid_reg_pd, long aid_documento, date ad_data_icassi, long aid_agente, long aid_riep_provvigioni, date ad_data_elaborazione, string as_periodo, ref s_budget as_budget[]);
return true
end function

public function boolean uf_liquidazione_provvigioni (long aid_reg_pd, long aid_documento, date ad_data_icassi, long aid_agente, long aid_riep_provvigioni, date ad_data_elaborazione, string as_periodo, ref s_budget as_budget[], string as_definitiva, long al_id_gruppo_agenti);
 
decimal ld_incdoc_ins_doc,ld_pag,ld_prec,ld_tot,ld_tot_documento,ld_imp_provv
decimal ld_imp_provv_documento,ld_per_da_liquidare,ld_imp_provv_perc,ld_imp_provv_imp
decimal ld_imp_star_credere,ld_imp_incassato,ld_star_effettivo,ld_importo_movimento
decimal ld_importo_scadenza,ld_imp_premi_penalita,ld_imp_premi_penalita_tot
decimal ld_percentuale,ld_budget,ld_imp_provv_doc,ld_inc_precedente,ld_app,ld_star_credere
decimal ld_imp_star_credere_agg,ld_star_credere_agg,ld_fatturato,ld_provvigioni
decimal ld_fat_ult_elab,ld_netto,ld_incassato_netto,ld_imp_liq,ld_rimborso
decimal ld_perc_enasarco,ld_enasarco_calc,ld_prog_calcolato,ld_imp_max,ld_imp_min
decimal ld_progressivo_enasarco,ld_enasarco_versare
integer li_giorni_franchigia,li_periodo,li_giorni_pp,li_size,li_mese,li_anno,i
integer li_anno_doc,li_mese_doc,ld_anno
date    ld_scadenza,ld_fine_periodo,ld_data_scadenza,ld_data_mov_partita,ld_data_doc
date    ld_ult_elab,ld_data_appoggio
long    ll_id_premi_penalita,ll_id_scadenza,ll_id_budget
long    ll_agente,ll_id_riep_prov_star_credere
string  ls_mod_liq,ls_stato,ls_tipo_prov,ls_tipo_fattura
boolean lb_budget
String	ls_definitiva
decimal	ld_per_enasarco	

Decimal	ld_rip_per_fatturato, ld_rip_per_incassato
long		ll_id_valuta	
Long		ll_id_val_doc	
long		ll_id_val_conto 

SELECT tipo_fattura, id_valuta
INTO 	 :ls_tipo_fattura, :ll_id_val_doc
FROM 	 documento
WHERE  id_documento=:aid_documento;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If

SELECT	id_val_prov_agente
INTO		:ll_id_valuta
FROM		sog_commerciale
WHERE    id_sog_commerciale = :aid_agente;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If





SELECT	rip_per_fatturato, rip_per_incassato
INTO	   :ld_rip_per_fatturato, :ld_rip_per_incassato
FROM	   gruppo_agenti
WHERE		id_gruppo_agenti = :al_id_gruppo_agenti
;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If


If (ld_rip_per_incassato > 0) Then
	SELECT sum(FN_CONV_VALUTA(par_aperta.id_valuta, mov_partita.importo, :ll_id_val_doc))
	INTO 	 :ld_incdoc_ins_doc
	FROM 	 mov_partita,par_aperta
	WHERE  par_aperta.id_reg_pd=:aid_reg_pd
	AND 	 mov_partita.id_par_aperta=par_aperta.id_par_aperta
	;
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If
End If
	
If isnull(ld_incdoc_ins_doc) Then ld_incdoc_ins_doc=0

If (ld_rip_per_incassato > 0) Then
	
	select sog_commerciale.giorni_franchigia
	into   :li_giorni_franchigia
	from   sog_commerciale
	where  sog_commerciale.id_sog_commerciale=:aid_agente
	;
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If
	
	if isnull(li_giorni_franchigia) then li_giorni_franchigia=0
	
	
	ld_data_appoggio=relativedate(ad_data_icassi,(li_giorni_franchigia * -1))
	
	
	SELECT sum(FN_CONV_VALUTA(par_aperta.id_valuta, mov_partita.importo, :ll_id_val_doc))
	INTO 	 :ld_pag
	FROM 	 mov_partita,par_aperta,mov_scadenza
	WHERE  par_aperta.id_reg_pd=:aid_reg_pd
	AND 	 mov_partita.id_par_aperta=par_aperta.id_par_aperta
	AND 	 mov_scadenza.id_mov_partita=mov_partita.id_mov_partita
	AND 	 mov_scadenza.id_scadenza IN (SELECT id_scadenza
												 	FROM 	 scadenza
												 	WHERE  scadenza.id_par_aperta=par_aperta.id_par_aperta
												 	AND 	 scadenza.data_scadenza >:ld_data_appoggio);

	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If

	if isnull(ld_pag) then ld_pag=0

	
	SELECT inc_precedente
	INTO 	 :ld_prec
	FROM 	 riep_provvigioni
	WHERE  id_documento=:aid_documento
	AND 	 id_agente=:aid_agente;
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If
	
	if isnull(ld_prec) then ld_prec=0
	
	
	ld_tot=ld_incdoc_ins_doc - ld_pag - ld_prec
	ld_app=ld_incdoc_ins_doc - ld_pag
End If
	
SELECT FN_CONV_VALUTA(id_valuta, importo, :ll_id_val_doc)
INTO 	 :ld_tot_documento
FROM   par_aperta
WHERE  id_reg_pd=:aid_reg_pd;
	
If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If
	
if isnull(ld_tot_documento) then ld_tot_documento=0

	
If (ld_rip_per_incassato > 0) Then	
	
	SELECT mod_liq_provvigione
	INTO 	 :ls_mod_liq
	FROM	 gruppo_agenti
	WHERE  id_gruppo_agenti=:al_id_gruppo_agenti;
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If
	
	CHOOSE CASE ls_mod_liq
		CASE 'T'	
			
			if ld_tot_documento<>ld_tot then return false
			
			ld_imp_provv = uf_importo_provvigioni(aid_riep_provvigioni,'P')
			if isnull(ld_imp_provv) then ld_imp_provv=0
			ld_imp_provv = ld_imp_provv + uf_importo_provvigioni(aid_riep_provvigioni,'I')
			if isnull(ld_imp_provv) then ld_imp_provv=0
		CASE ELSE
			if ld_tot_documento = ld_tot then 
				
				ld_imp_provv=uf_importo_provvigioni(aid_riep_provvigioni,'P')
				if isnull(ld_imp_provv) then ld_imp_provv=0
				ld_imp_provv=ld_imp_provv + uf_importo_provvigioni(aid_riep_provvigioni,'I')
				if isnull(ld_imp_provv) then ld_imp_provv=0
			else
				
				select sum(imp_provv_documento)
				into   :ld_imp_provv_documento
				from   riep_prov_righe
				where  id_riep_provvigioni=:aid_riep_provvigioni;
				
				If SQLCA.SQLCODE = -1 Then
					MessageBox("Database Error", SQLCA.SQLERRTEXT)
				End If
	
				if isnull(ld_imp_provv_documento) then ld_imp_provv_documento=0
				
				if ld_tot_documento<>0 then
					ld_incassato_netto=(ld_tot*ld_imp_provv_documento) / ld_tot_documento
				end if
				if isnull(ld_per_da_liquidare) then ld_per_da_liquidare=0
				
				select sum( ((:ld_incassato_netto * provvigioni) / 100))
				into   :ld_imp_provv_perc
				from   riep_prov_righe
				where  id_riep_provvigioni=:aid_riep_provvigioni
				and    tipo_prov='P';
				
				If SQLCA.SQLCODE = -1 Then
					MessageBox("Database Error", SQLCA.SQLERRTEXT)
				End If
	
				if isnull(ld_imp_provv_perc) then ld_imp_provv_perc=0
				
				select provvigioni
				into   :ld_imp_provv_imp
				from   riep_prov_righe
				where  id_riep_provvigioni=:aid_riep_provvigioni
				and    tipo_prov='I';
				
				If SQLCA.SQLCODE = -1 Then
					MessageBox("Database Error", SQLCA.SQLERRTEXT)
				End If
	
				if isnull(ld_imp_provv_imp) then ld_imp_provv_imp=0
				
				if (not isnull(ld_tot_documento) and ld_tot_documento > 0) then 
					ld_imp_provv_imp=(ld_tot*ld_imp_provv_imp) / ld_tot_documento
				else
					ld_imp_provv_imp=(ld_tot*ld_imp_provv_imp)
				end if
				
				
				if isnull(ld_imp_provv_imp) then ld_imp_provv_imp=0
				
				ld_imp_provv=ld_imp_provv_perc+ld_imp_provv_imp
			end if		
	END CHOOSE
End If



if ld_app>=ld_tot_documento then 
	ls_stato='C' 
else 
	ls_stato='A'
end if

update riep_provvigioni
set    liq_pagato=inc_precedente,
       inc_precedente=isnull(inc_precedente,0,inc_precedente) + :ld_tot,
       stato_provvigioni=:ls_stato,
       imp_premi_penalita=:ld_imp_premi_penalita_tot
where  id_riep_provvigioni=:aid_riep_provvigioni;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If

If as_definitiva = 'S' Then  
	update riep_prov_righe
	set 	 data_elab_fatturato=:ad_data_elaborazione
	where  id_riep_provvigioni=:aid_riep_provvigioni
	and	 data_elab_fatturato IS NULL
	;
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If	

	
	update riep_prov_righe
	set 	 imp_prov_incassato=:ld_imp_provv
	where  id_riep_provvigioni=:aid_riep_provvigioni
	;
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If	
Else
	
	update	riep_prov_righe
	set 		imp_prov_incassato=:ld_imp_provv
	where 	id_riep_provvigioni=:aid_riep_provvigioni;	
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If	
End If

update gruppo_agenti
set inc_ult_elab = rip_per_incassato,
	 fat_ult_elab = rip_per_fatturato
where id_gruppo_agenti=:al_id_gruppo_agenti;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If







select fat_ult_elab
into   :ld_fat_ult_elab
from   gruppo_agenti
where  id_gruppo_agenti=:al_id_gruppo_agenti;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If

select sum(imp_provv_documento)
into   :ld_netto
from   riep_prov_righe
where  id_riep_provvigioni=:aid_riep_provvigioni;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If
			
if isnull(ld_netto) then ld_netto=0

ld_fatturato=0;
IF ISNULL(ld_ult_elab) THEN 
	declare riepilogo_righe1 cursor for 
	select provvigioni,tipo_prov
	from   riep_prov_righe
	where  id_riep_provvigioni=:aid_riep_provvigioni;
	
	
	open riepilogo_righe1;
	
	fetch riepilogo_righe1 into :ld_provvigioni,:ls_tipo_prov;
	
	do while sqlca.sqlcode=0
		if ls_tipo_fattura='C' then
	
	
	
	
	
			if ls_tipo_prov='P' then
				ld_fatturato=ld_fatturato+((((ld_fat_ult_elab * ld_netto) /100)* ld_provvigioni)/100)
			else
				ld_fatturato=ld_fatturato +((ld_fat_ult_elab * ld_provvigioni) /100) 
			end if
		else
			if ls_tipo_prov='P' then
				ld_fatturato=ld_fatturato+((ld_netto * ld_provvigioni) /100)
			else
				ld_fatturato=ld_fatturato + ld_provvigioni
			end if
		end if
		fetch riepilogo_righe1 into :ld_provvigioni,:ls_tipo_prov;
	loop
close riepilogo_righe1;

ELSE
	declare riepilogo_righe cursor for 
	select provvigioni,tipo_prov
	from riep_prov_righe
	where id_riep_provvigioni=:aid_riep_provvigioni
	and data_elab_fatturato=:ld_ult_elab;
	
	open riepilogo_righe;
	
	fetch riepilogo_righe into :ld_provvigioni,:ls_tipo_prov;
	
	do while sqlca.sqlcode=0
		if ls_tipo_fattura='C' then
	
	
	
	
	
			if ls_tipo_prov='P' then
				ld_fatturato=ld_fatturato+((((ld_fat_ult_elab * ld_netto) /100)* ld_provvigioni)/100)
			else
				ld_fatturato=ld_fatturato +((ld_fat_ult_elab * ld_provvigioni) /100) 
			end if
		else
			if ls_tipo_prov='P' then
				ld_fatturato=ld_fatturato+((ld_netto * ld_provvigioni) /100)
			else
				ld_fatturato=ld_fatturato + ld_provvigioni
			end if
		end if
		fetch riepilogo_righe into :ld_provvigioni,:ls_tipo_prov;
	loop
	close riepilogo_righe;
END IF

if (isnull(ld_tot_documento) or ld_tot_documento = 0) then
	ld_incassato_netto=(ld_netto*ld_tot)
else
	ld_incassato_netto=(ld_netto*ld_tot) / ld_tot_documento
end if



select FN_CONV_VALUTA(id_valuta, imp_premio_budget, :ll_id_val_doc),
		 FN_CONV_VALUTA(id_valuta, imp_fisso_ult_elab, :ll_id_val_doc)
into   :ld_budget, :ld_rimborso
from   sog_commerciale
where  id_sog_commerciale=:aid_agente;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If

IF ISNULL(ld_budget) THEN ld_budget=0
IF ISNULL(ld_rimborso) THEN ld_rimborso=0

ld_imp_premi_penalita = 0
ld_rimborso = 0 
ld_budget = 0

ld_imp_liq=ld_fatturato + ld_incassato_netto + &
			  ld_imp_premi_penalita + ld_rimborso + ld_budget
			  
			  
select per_car_azienda
into   :ld_perc_enasarco
from   per_enasarco
where  data_inizio<=:ad_data_elaborazione
and    data_fine>=:ad_data_elaborazione;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If

ld_enasarco_calc = (ld_imp_liq * ld_perc_enasarco) / 100

SELECT id_valuta
INTO	 :ll_id_val_conto
FROM	 esercizio
WHERE  data_inizio <= :ad_data_elaborazione
AND	 data_fine >= :ad_data_elaborazione
;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If

SELECT FN_CONV_VALUTA(:ll_id_val_doc, :ld_enasarco_calc, :ll_id_val_conto)
INTO	 :ld_enasarco_calc
FROM	 SYS.DUMMY;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If


ld_anno=integer(string(ad_data_elaborazione,'yyyy'))

select prog_calcolato,progressivo_enasarco
into   :ld_prog_calcolato, :ld_progressivo_enasarco
from   prog_enasarco
where  id_sog_commerciale=:aid_agente
and    anno=:ld_anno;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error 3", SQLCA.SQLERRTEXT)
End If

select 	FN_CONV_VALUTA(scag_enasarco.id_valuta, scag_enasarco.imp_massimo, :ll_id_val_conto),
			FN_CONV_VALUTA(scag_enasarco.id_valuta, scag_enasarco.imp_minimo, :ll_id_val_conto),
			scag_enasarco.percentuale		
into 		:ld_imp_max,:ld_imp_min,
			:ld_per_enasarco		
from 		scag_enasarco, sog_commerciale
where 	scag_enasarco.data_inizio<=:ad_data_elaborazione
and 		scag_enasarco.data_fine>=:ad_data_elaborazione
and 		sog_commerciale.id_sog_commerciale=:aid_agente
and 		sog_commerciale.id_tipo_agente=scag_enasarco.id_tipo_agente;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If

if (ld_per_enasarco > 0) then &
	ld_enasarco_calc = ld_enasarco_calc * ld_per_enasarco / 100

ld_prog_calcolato=ld_prog_calcolato+ld_enasarco_calc

if ld_prog_calcolato>ld_imp_max then ld_prog_calcolato=ld_imp_max
if (ld_enasarco_calc + ld_progressivo_enasarco) <= ld_imp_min then
	ld_enasarco_versare=ld_imp_min
end if
if ld_prog_calcolato <= ld_progressivo_enasarco then ld_enasarco_versare=0
if ld_prog_calcolato > ld_progressivo_enasarco then
	ld_enasarco_versare=ld_prog_calcolato - ld_progressivo_enasarco
end if

If IsNull(ld_prog_calcolato) Then
	ld_prog_calcolato = 0
End If
	
update prog_enasarco
set 	 progressivo_enasarco = isnull(progressivo_enasarco,0,progressivo_enasarco) + :ld_enasarco_versare,
		 imp_ver_ult_elab = :ld_enasarco_versare,
		 prog_calcolato = prog_calcolato + :ld_prog_calcolato
where  id_sog_commerciale=:aid_agente
and 	 anno=:ld_anno;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If

if sqlca.sqlnrows=0 and SQLCA.SQLCODE <> -1 then
	insert into prog_enasarco(id_sog_commerciale,anno,progressivo_enasarco,imp_ver_ult_elab,prog_calcolato)
	values (:aid_agente,:ld_anno,:ld_enasarco_versare,:ld_enasarco_versare,:ld_prog_calcolato);
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If
end if

select count(id_budget)
into   :ll_id_budget
from   budget
where  id_sog_commerciale=:aid_agente;

If SQLCA.SQLCODE = -1 Then
	MessageBox("Database Error", SQLCA.SQLERRTEXT)
End If

if ll_id_budget<=0 then
	update sog_commerciale
	set 	 prec_elab_definitivo=ult_elab_definitivo,
	    	 ult_elab_definitivo=:ad_data_elaborazione,
	    	 imp_fisso_ult_elab=imp_fisso
	where  id_sog_commerciale=:aid_agente
	and 	 (ult_elab_definitivo<>:ad_data_elaborazione or ult_elab_definitivo is null);
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If

end if
return true

end function

public function decimal uf_importo_provvigioni (long aid_riep_provvigioni, string tipo_provv);decimal ld_imp_provv

if tipo_provv='P' then
	select sum( (imp_provv_documento * provvigioni) / 100)
	into   :ld_imp_provv
	from   riep_prov_righe
	where  id_riep_provvigioni=:aid_riep_provvigioni
	and    tipo_prov='P';
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If	
else
	select provvigioni
	into   :ld_imp_provv
	from   riep_prov_righe
	where  id_riep_provvigioni=:aid_riep_provvigioni
	and    tipo_prov='I';
	
	If SQLCA.SQLCODE = -1 Then
		MessageBox("Database Error", SQLCA.SQLERRTEXT)
	End If	
end if
return ld_imp_provv
end function

on u_liq_provvigioni.create
TriggerEvent( this, "constructor" )
end on

on u_liq_provvigioni.destroy
TriggerEvent( this, "destructor" )
end on

