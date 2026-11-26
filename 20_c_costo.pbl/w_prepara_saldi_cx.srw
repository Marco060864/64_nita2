forward
global type w_prepara_saldi_cx from w_bilancio_cx
end type
end forward

global type w_prepara_saldi_cx from w_bilancio_cx
boolean TitleBar=true
string Title="Gestione Centri di Costo"
end type
global w_prepara_saldi_cx w_prepara_saldi_cx

on w_prepara_saldi_cx.create
call super::create
end on

on w_prepara_saldi_cx.destroy
call super::destroy
end on

event cb_1::clicked;



delete from chiusura_apertura;
long ll_id_prof,ll_id_reg,ll_id_es,ll_id_azienda
decimal ld_dec_significativi, ld_cambio
date ld_data
string ls_bloc
string ls_da,ls_a
uo_chiusura_apertura lo_sp
ll_id_es=dw_1.getitemnumber(1,"id_esercizio")

select bloccato 
into :ls_bloc
from esercizio
where id_esercizio=:ll_id_es;

  ld_cambio=dw_1.getitemnumber(1,"valuta")
  SELECT "valuta"."dec_significativi"  
    INTO :ld_dec_significativi  
    FROM "valuta"  
   WHERE "valuta"."cambio" = :ld_cambio   ;
ll_id_azienda=dw_1.getitemnumber(1,"id_azienda")

date ld_da,ld_a
ld_da=dw_1.getitemdate(1,"da")
ld_a=dw_1.getitemdate(1,"a")
date ld_in,ld_fin
string ls_in,ls_fin
ls_in=dw_1.getitemstring(1,"d_in")
ls_fin=dw_1.getitemstring(1,"d_fin")
ld_in=date(ls_in)
ld_fin=date(ls_fin)
if ls_bloc='N' then 
	
	
	long ll_id_e
	ll_id_e=dw_1.getitemnumber(1,"id_esercizio")
	ld_cambio=dw_1.getitemnumber(1,"valuta")
	
	if ((ld_cambio<>0) and (not isnull(ld_cambio))) and &
		not isnull(ll_id_e) then
		open(w_attesa)
		long il_prof
		date ld_d
	
		ld_d=today()
		il_prof=1
		ll_id_es=dw_1.getitemnumber(1,"id_esercizio")
		if not isnull(ll_id_es) then
			
			ld_d=dw_1.getitemdate(1,"data_c")
			lo_sp= create uo_chiusura_apertura 
			ls_da=string(dw_1.getitemdate(1,"da"),"yy/mm/dd")
			ls_a=string(dw_1.getitemdate(1,"a"),"yy/mm/dd")
						
			if ls_da="" and ls_a="" then
				lo_sp.of_conti_sp(il_prof,ld_d,ll_id_es,ll_id1,ll_id3,'B')
				lo_sp.of_conti_ce(il_prof,ld_d,ll_id_es,ll_id2,ll_id4,'B')
			else
			
	
	
				lo_sp.of_conti_sp_parziali(ls_da,ls_a,ll_id_es)
				lo_sp.of_conti_ce_parziali(ls_da,ls_a,ll_id_es)
			end if
			destroy lo_sp
			close(w_attesa)
		end if
	end if
end if 

if ls_bloc='S' and (ld_in=ld_da and ld_fin=ld_a) then 
	
	
	
	messagebox("Informazione","La chiusura conti dell'esercizio selezionato è già stata effettuata.")		
	open(w_attesa)
	select id_prof_reg_chiusura
	into :ll_id_prof
	from par_sistema;
	
	
	
	
	
	
	
	lo_sp= create uo_chiusura_apertura 
	
	
	
	
			lo_sp.of_conti_sp_chiusura(ld_in, ld_a)
			lo_sp.of_conti_ce_chiusura(ld_in, ld_a)	
	
	
	destroy lo_sp
	
	close(w_attesa)
end if 


if ls_bloc='S' and (ld_da>ld_in or ld_a<ld_fin) then
	
	
	open(w_attesa)
	select id_prof_reg_chiusura
	into :ll_id_prof
	from par_sistema;
	integer li_num
	select count(reg_pd.id_reg_pd) 
		into :li_num
		from reg_pd,esercizio,registro
		where reg_pd.id_prof_registrazione=:ll_id_prof
		and registro.id_registro=reg_pd.id_registro
		and registro.id_esercizio=esercizio.id_esercizio
		and esercizio.id_esercizio=:ll_id_es
		and reg_pd.data_registrazione >= :ld_da AND reg_pd.data_registrazione <= :ld_a;
	
	
	
	
	
	IF li_num = 0 THEN
		

			ll_id_e=dw_1.getitemnumber(1,"id_esercizio")
			ld_cambio=dw_1.getitemnumber(1,"valuta")
			
			if ((ld_cambio<>0) and (not isnull(ld_cambio))) and &
				not isnull(ll_id_e) then
				open(w_attesa)
			
				ld_d=today()
				il_prof=1
				ll_id_es=dw_1.getitemnumber(1,"id_esercizio")
				if not isnull(ll_id_es) then
				
					ld_d=dw_1.getitemdate(1,"data_c")
					lo_sp= create uo_chiusura_apertura 
					ls_da=string(dw_1.getitemdate(1,"da"),"yy/mm/dd")
					ls_a=string(dw_1.getitemdate(1,"a"),"yy/mm/dd")
								
						lo_sp.of_conti_sp_parziali(ls_da,ls_a,ll_id_es)
						lo_sp.of_conti_ce_parziali(ls_da,ls_a,ll_id_es)
					destroy lo_sp
					close(w_attesa)
				end if
			end if
			
	ELSE
	
		IF LI_NUM <> 2 THEN 
			MESSAGEBOX ('ATTENZIONE', 'Non possiamo procedere, contattare l~assistenza software')
		ELSE
			
			
		
			integer li_id1, li_id2
			
			select reg_pd.id_reg_pd 
						into :li_id1
						from reg_pd,esercizio,registro
						where reg_pd.id_prof_registrazione=:ll_id_prof
						and registro.id_registro=reg_pd.id_registro
						and registro.id_esercizio=esercizio.id_esercizio
						and esercizio.id_esercizio=:ll_id_es
						and reg_pd.data_registrazione >= :ld_da AND reg_pd.data_registrazione <= :ld_a;
						
			select reg_pd.id_reg_pd 
						into :li_id2
						from reg_pd,esercizio,registro
						where reg_pd.id_prof_registrazione=:ll_id_prof
						and registro.id_registro=reg_pd.id_registro
						and registro.id_esercizio=esercizio.id_esercizio
						and esercizio.id_esercizio=:ll_id_es
						and reg_pd.data_registrazione >= :ld_da AND reg_pd.data_registrazione <= :ld_a
						and reg_pd.id_reg_pd <> :li_id1;
			
	
			
			ll_id_e=dw_1.getitemnumber(1,"id_esercizio")
			ld_cambio=dw_1.getitemnumber(1,"valuta")
			
			if ((ld_cambio<>0) and (not isnull(ld_cambio))) and &
				not isnull(ll_id_e) then
				open(w_attesa)
			
				ld_d=today()
				il_prof=1
				ll_id_es=dw_1.getitemnumber(1,"id_esercizio")
				if not isnull(ll_id_es) then
				
					ld_d=dw_1.getitemdate(1,"data_c")
					lo_sp= create uo_chiusura_apertura 
					ls_da=string(dw_1.getitemdate(1,"da"),"yy/mm/dd")
					ls_a=string(dw_1.getitemdate(1,"a"),"yy/mm/dd")
						
						lo_sp.of_conti_sp_parziali_ch(ls_da,ls_a,ll_id_es,li_id1,li_id2)
						lo_sp.of_conti_ce_parziali_ch(ls_da,ls_a,ll_id_es,li_id1,li_id2)

					destroy lo_sp
					close(w_attesa)
				end if
			end if							
		END IF
	END IF
		
		close(w_attesa)
end if 






DATASTORE DS_SALDI
DS_SALDI = CREATE DATASTORE
DS_SALDI.DATAOBJECT = "d_calcolo_saldo_perc_ds"
DS_SALDI.SETTRANSOBJECT(SQLCA)
DS_SALDI.RETRIEVE()
STRING LS_SALDO_REC
DECIMAL {4} LS_CONTO_REC
INTEGER I
LONG DS_SS

DS_SS = DS_SALDI.ROWCOUNT()

FOR I = 1 TO DS_SS
	LS_SALDO_REC =	DS_SALDI.GETITEMSTRING(I, "SEGNO")
	DS_SALDI.SETITEM(I, "centro_costo_righe_segno", LS_SALDO_REC)
	LS_CONTO_REC = DS_SALDI.GETITEMNUMBER (I, "saldo_conto")
	DS_SALDI.SETITEM(I, "centro_costo_righe_saldo_cen_costo", LS_CONTO_REC)
	
NEXT

I = DS_SALDI.UPDATE()
IF I <> 1 THEN
	MESSAGEBOX ('ERRORE','SALVATAGGIO NON ESEGUITO')
END IF

		


DATASTORE DS_TOTALE
DS_TOTALE = CREATE DATASTORE
DS_TOTALE.DATAOBJECT = "d_saldo_testa_cen_costo_ds"
DS_TOTALE.SETTRANSOBJECT(SQLCA)
DS_TOTALE.RETRIEVE()

STRING LS_SEGNO_TOT
DECIMAL {4} LS_TOTALE
LONG DS_tot

DS_tot = DS_TOTALE.ROWCOUNT()
messagebox ('righe', ds_tot)
FOR I = 1 TO DS_tot
	LS_SEGNO_TOT=	DS_TOTALE.GETITEMSTRING(I, "SS_SEGNO")
	messagebox ('segno', ls_segno_tot)
	DS_TOTALE.SETITEM(I, "centro_costo_testa_segno", LS_SEGNO_TOT)
	LS_TOTALE = DS_TOTALE.GETITEMNUMBER (I, "tot")
		messagebox ('totale', ls_totale)
	DS_TOTALE.SETITEM(I, "centro_costo_testa_totale", LS_TOTALE)
NEXT

I = DS_TOTALE.UPDATE()
IF I <> 1 THEN
	MESSAGEBOX ('ERRORE','SALVATAGGIO NON ESEGUITO')
END IF
MESSAGEBOX ('OK','COMPLETATO CALCOLO SALDI PER CENTRI DI COSTO')


ld_da=dw_1.getitemdate(1,"da")
ld_a=dw_1.getitemdate(1,"a")
ll_id_e=dw_1.getitemnumber(1,"id_esercizio")
ld_cambio=dw_1.getitemnumber(1,"valuta")
if ((ld_cambio<>0) and (not isnull(ld_cambio))) and &
		 not isnull(ll_id_e) then
		string ls_mod
		string ls_cf
		
		
		
		
		
		
		
		long ll_cod_esercizio
		select esercizio.codice
		into :ll_cod_esercizio
		from esercizio
		where esercizio.id_esercizio=:ll_id_e;
		
		
		date ld_data_in, ld_data_fin
		ld_data_in=dw_1.getitemdate(1,"da")
		ld_data_fin=dw_1.getitemdate(1,"a")
		s_param ls_param
		ls_param.cambio=ld_cambio
		ls_param.dec_significativi=ld_dec_significativi
		ls_param.id_azienda=ll_id_azienda
		ls_param.cod_esercizio=ll_cod_esercizio
		ls_param.data_in=ld_data_in
		ls_param.data_fin=ld_data_fin
		
		
		
		
	
	

		
		openwithparm(w_stampa_bil_cen_costo_cx,ls_param)



else
	messagebox("Informazione","Non sono state inserite tutte le informazioni necessarie")
end if



end event

type dw_1 from w_bilancio_cx`dw_1 within w_prepara_saldi_cx
string DataObject="d_prep_saldi_ff"
end type

