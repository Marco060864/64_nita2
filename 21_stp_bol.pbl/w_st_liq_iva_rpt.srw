forward
global type w_st_liq_iva_rpt from w_stampa_001
end type
end forward

global type w_st_liq_iva_rpt from w_stampa_001
integer width = 3794
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
end type
global w_st_liq_iva_rpt w_st_liq_iva_rpt

type variables
s_param1 ls_param
long il_id_dich_per
end variables

forward prototypes
public subroutine wf_dich_per ()
end prototypes

public subroutine wf_dich_per ();long ll_id_es, ll_id_att, ll_row, ll_dich, ll_num, ll_vp1, ll_vp5, ll_risp, ll_val_lire, ll_id_valuta, ll_id_riep_iva
long ll_id_prof_risc_fat_sos
date ld_dat1, ld_dat2, ld_dat_dich
boolean b_vai
decimal {4} de_imponibile, de_imposta, de_imponibile_cee, ll_rif_liq, ll_liq_trim, ll_acconto, ll_parita_euro
string ls_tipo, ls_rif, ls_eurolire, ls_carica, ls_codfisc
decimal {4} ll_vp2, ll_vp3, ll_vp4, ll_vp6, ll_vp7, ll_vp7b, ll_vp8, ll_vp9, ll_vp10 ,ll_vp11
decimal {4} ll_vp12, ll_vp12b, ll_vp8b, ll_vp10b, ll_vp13, ll_vp14, ll_vp15, ll_vp16
long  ld_iva_deb
long ld_iva_ver, ld_dif
integer li_rif

select  id_val_lire, id_prof_risc_fat_sos
into  :ll_val_lire, :ll_id_prof_risc_fat_sos
from par_sistema;

ld_dat1   = ls_param.data_in
ld_dat2   = ls_param.data_fin
ls_tipo   = ls_param.tipo_dich
ls_rif    = ls_param.rif_dich
ll_id_es  = ls_param.id_esercizio
ll_id_att = ls_param.id_attivita

if isnull(ld_dat1) or isnull(ld_dat2) then
	messagebox ('Attenzione', 'Inserire date valide per poter procedere')
else
	if	isnull(ls_tipo) or isnull(ls_rif) then
		messagebox ('Attenzione', 'Inserire riferimenti per il calcolo')
	else
		b_vai = true
		
		if ld_dat1 > ld_dat2 then
			messagebox ('Attenzione', 'Controllare immissione date')
			b_vai = false
		end if
	end if
end if

IF b_vai = true then    

	
select  count(id_dich_per_iva)  
	into  :ll_num
	from dich_per_iva
		where id_esercizio = :ll_id_es and
				id_attivita = :ll_id_att and
				tipo_dichiarazione = :ls_tipo and
				rif_dichiarazione = :ls_rif;

if ll_num = 0  then  
	insert into dich_per_iva (id_azienda, id_attivita, id_esercizio, tipo_dichiarazione, rif_dichiarazione, data_in_liq, data_fi_liq, euro_lire, ver_euro_lire, rumb_euro_lire)	
		values (1, :ll_id_att, :ll_id_es, :ls_tipo, :ls_rif, :ld_dat1, :ld_dat2, :ls_eurolire, :ls_eurolire, :ls_eurolire);
	if sqlca.sqlcode <> 0 then
		messagebox ('Attenzione', 'Errore Insert Dich_per_iva riga 55 clicked cb_ok')
	end if
	select  id_dich_per_iva  
		into  :ll_dich
		from dich_per_iva
		where id_esercizio = :ll_id_es and
				id_attivita = :ll_id_att and
				tipo_dichiarazione = :ls_tipo and
				rif_dichiarazione = :ls_rif;	
	ll_risp = 1			
else  

	
	ll_risp = 0
	select  id_dich_per_iva  
	into  :ll_dich
	from dich_per_iva
	where id_esercizio = :ll_id_es and
			id_attivita = :ll_id_att and
			tipo_dichiarazione = :ls_tipo and
			rif_dichiarazione = :ls_rif;
			
	il_id_dich_per = ll_dich

end if  
			
If ll_risp = 1 then  

	if ll_id_riep_iva > 0 then
		update dich_per_iva
		set id_riep_iva = :ll_id_riep_iva
		where id_dich_per_iva = :ll_dich;
	end if
		
		DATASTORE ds_acq  
		ds_acq = CREATE DATASTORE
		ds_acq.DATAOBJECT = "d_mov_iva_acq_ven"
		ds_acq.SETTRANSOBJECT(SQLCA)
		
		ll_row=ds_acq.RETRIEVE('IA', ld_dat1, ld_dat2, 'vp2a')		
      
		if ll_row > 0 then
			ll_id_valuta = ds_acq.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
			
			select  parita_euro
			into  :ll_parita_euro
			from valuta
			where id_valuta = :ll_id_valuta;						
				
            if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
               de_imponibile = round((ds_acq.getitemnumber(ll_row, "a")/ll_parita_euro),4)					
				else
					de_imponibile = (round(ds_acq.getitemnumber(ll_row, "a")/1000,0)*1000)

				end if
				
				
				update dich_per_iva
				set vp2 = :de_imponibile
				where id_dich_per_iva = :ll_dich;
				
			end if
			
		ll_row=ds_acq.RETRIEVE('IA', ld_dat1, ld_dat2, 'vp2b')
					
			if ll_row > 0 then
				ll_id_valuta = ds_acq.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
				
				select  parita_euro
				into  :ll_parita_euro
				from valuta
				where id_valuta = :ll_id_valuta;						
				
            if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
               de_imponibile_cee = round((ds_acq.getitemnumber(ll_row, "tot_imp_cee")/ll_parita_euro),4)					
				else
					de_imponibile_cee = round(ds_acq.getitemnumber(ll_row, "tot_imp_cee")/1000,0)*1000
				end if				
				
				
				update dich_per_iva
				set vp2b = :de_imponibile_cee
				where id_dich_per_iva = :ll_dich;
				
			end if			
			
		ll_row=ds_acq.RETRIEVE('IA', ld_dat1, ld_dat2, 'vp11')
      
			if ll_row > 0 then
				ll_id_valuta = ds_acq.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
				
				select  parita_euro
				into  :ll_parita_euro
				from valuta
				where id_valuta = :ll_id_valuta;					
				
            if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
	            de_imposta = round((ds_acq.getitemnumber(ll_row, "b")/ll_parita_euro),4)					
				else
					de_imposta = round(ds_acq.getitemnumber(ll_row, "b")/1000,0)*1000
				end if	
				
				
				update dich_per_iva
				set vp6 = :de_imposta
				where id_dich_per_iva = :ll_dich;
				
				ll_vp6 = de_imposta
			end if	
			
		ll_row=ds_acq.RETRIEVE('IA', ld_dat1, ld_dat2, 'vp3a')
		      	
			if ll_row > 0 then
				ll_id_valuta = ds_acq.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
				
				select  parita_euro
				into  :ll_parita_euro
				from valuta
				where id_valuta = :ll_id_valuta;		
				
				if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
	            de_imponibile = round((ds_acq.getitemnumber(ll_row, "a")/ll_parita_euro),4)					
				else
					de_imponibile = round(ds_acq.getitemnumber(ll_row, "a")/1000,0)*1000
				end if					
				
				
				update dich_per_iva
				set vp3 = :de_imponibile
				where id_dich_per_iva = :ll_dich;
				
			end if
			
		ll_row=ds_acq.RETRIEVE('IA', ld_dat1, ld_dat2, 'vp3b')
		
			if ll_row > 0 then
				ll_id_valuta = ds_acq.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
				
				select  parita_euro
				into  :ll_parita_euro
				from valuta
				where id_valuta = :ll_id_valuta;								
				
            if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
					de_imposta = round((ds_acq.getitemnumber(ll_row, "b")/ll_parita_euro),4)					
				else
					de_imposta = round(ds_acq.getitemnumber(ll_row, "b")/1000,0)*1000
				end if						
				
				
				update dich_per_iva
				set vp3b = :de_imposta
				where id_dich_per_iva = :ll_dich;
				
			end if				
			
		DESTROY ds_acq
		
		DATASTORE ds_vend  
		ds_vend = CREATE DATASTORE
		ds_vend.DATAOBJECT = "d_mov_iva_acq_ven"
		ds_vend.SETTRANSOBJECT(SQLCA)
		
		ll_row=ds_vend.RETRIEVE('IV', ld_dat1, ld_dat2, 'vp1a')
		
		 	if ll_row > 0 then
				ll_id_valuta = ds_vend.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
				
				select  parita_euro
				into  :ll_parita_euro
				from valuta
				where id_valuta = :ll_id_valuta;									
				
            if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
               de_imponibile = round((ds_vend.getitemnumber(ll_row, "a")/ll_parita_euro),4)					
				else
					de_imponibile = round(ds_vend.getitemnumber(ll_row, "a")/1000,0)*1000
				end if							
            				
				
				update dich_per_iva
				set vp1 = :de_imponibile
				where id_dich_per_iva = :ll_dich;
				
			end if
			
		ll_row=ds_vend.RETRIEVE('IV', ld_dat1, ld_dat2, 'vp1b')
		
		 	if ll_row > 0 then
				ll_id_valuta = ds_vend.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
				
				select  parita_euro
				into  :ll_parita_euro
				from valuta
				where id_valuta = :ll_id_valuta;											
				
				if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
	            de_imponibile_cee = round((ds_vend.getitemnumber(ll_row, "tot_imp_cee")/ll_parita_euro),4)					
				else
					de_imponibile_cee = round(ds_vend.getitemnumber(ll_row, "tot_imp_cee")/1000,0)*1000
				end if						
				
				
				update dich_per_iva
				set vp1b = :de_imponibile_cee
				where id_dich_per_iva = :ll_dich;
				
			end if			
			
		ll_row=ds_vend.RETRIEVE('IV', ld_dat1, ld_dat2,'vp10')
		
		 	if ll_row > 0 then
				ll_id_valuta = ds_vend.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
				
				select  parita_euro
				into  :ll_parita_euro
				from valuta
				where id_valuta = :ll_id_valuta;													
				
            if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
	            de_imposta = round((ds_vend.getitemnumber(ll_row, "b")/ll_parita_euro),4)					
				else
					de_imposta = round(ds_vend.getitemnumber(ll_row, "b")/1000,0)*1000
				end if					
				
				
				update dich_per_iva
				set vp5 =:de_imposta
				where id_dich_per_iva = :ll_dich;
				
				ll_vp5 = de_imposta
			end if			
		
		DESTROY ds_vend		
		
		DATASTORE ds_corr 
		ds_corr = CREATE DATASTORE
		ds_corr.DATAOBJECT = "d_mov_iva_acq_ven"
		ds_corr.SETTRANSOBJECT(SQLCA)
		
		ll_row= ds_corr.RETRIEVE('IC', ld_dat1, ld_dat2,'vp1a')
		
			if ll_row > 0 then
				ll_id_valuta = ds_corr.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
				
				select  parita_euro
				into  :ll_parita_euro
				from valuta
				where id_valuta = :ll_id_valuta;															
				
            if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
					de_imponibile = round((ds_corr.getitemnumber(ll_row, "a")/ll_parita_euro),4)					
				else
					de_imponibile = round(ds_corr.getitemnumber(ll_row, "a")/1000,0)*1000
				end if		
				
			 select vp1
				 into :ll_vp1
				 from dich_per_iva
				 where id_dich_per_iva = :ll_dich;
		
			de_imponibile = ll_vp1 + de_imponibile
			
		
			update dich_per_iva
				set vp1 = :de_imponibile
				where id_dich_per_iva = :ll_dich;
			
			end if
			
		ll_row= ds_corr.RETRIEVE('IC', ld_dat1, ld_dat2,'vp10')
		
			if ll_row > 0 then
				ll_id_valuta = ds_corr.getitemnumber(ll_row, "ws_registri_iva_id_valuta")
				
				select  parita_euro
				into  :ll_parita_euro
				from valuta
				where id_valuta = :ll_id_valuta;																	
				
            if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
	            de_imposta = round((ds_corr.getitemnumber(ll_row, "b")/ll_parita_euro),4)					
				else
					de_imposta = round(ds_corr.getitemnumber(ll_row, "b")/1000,0)*1000
				end if						
				
			 select vp5
				 into :ll_vp5
				 from dich_per_iva
				 where id_dich_per_iva = :ll_dich;
		
			de_imposta    = ll_vp5 + de_imposta
			
		
			update dich_per_iva
				set vp5 =:de_imposta
				where id_dich_per_iva = :ll_dich;
				
				ll_vp5 = ll_vp5 + de_imposta
			
			end if			
		
		DESTROY ds_corr		
		
		DATASTORE ds_credito 
		ds_credito = CREATE DATASTORE
		ds_credito.DATAOBJECT = "ds_lista_dich_periodiche_iva"
		ds_credito.SETTRANSOBJECT(SQLCA)
		ll_row=ds_credito.RETRIEVE()  
		
		if ll_row > 0 then			
			ll_id_valuta = ds_credito.getitemnumber(ll_row, "dich_per_iva_id_valuta")
			
			select  parita_euro
			into  :ll_parita_euro
			from valuta
			where id_valuta = :ll_id_valuta;						
			
         if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
	         ll_liq_trim = round((ds_credito.getitemnumber(ll_row, "riep_iva_interessi_trim")/ll_parita_euro),4)					
			else
				ll_liq_trim = round(ds_credito.getitemnumber(ll_row, "riep_iva_interessi_trim")/1000,0)*1000
			end if					
		  
		   if ls_tipo = 'T' then
				if not (isnull(ll_liq_trim)) and ls_rif <> "4" then
					update dich_per_iva
					set vp14 = :ll_liq_trim
					where id_dich_per_iva = :ll_dich;
					
					ll_vp14 = ll_liq_trim
				end if		
   		end if
			
         if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
	         ll_acconto = round((ds_credito.getitemnumber(ll_row, "riep_iva_acconto")/ll_parita_euro),4)					
			else
				ll_acconto = round(ds_credito.getitemnumber(ll_row, "riep_iva_acconto")/1000,0)*1000
			end if								
			
			if not (isnull(ll_acconto)) then
				update dich_per_iva
				set vp15 = :ll_acconto
				where id_dich_per_iva = :ll_dich;
				
				ll_vp15 = ll_acconto
			end if
		end if
			
   	  ll_row = (ll_row - 1) 
	 
    if ll_row > 0 then				  
		
			ll_id_valuta = ds_credito.getitemnumber(ll_row, "dich_per_iva_id_valuta")
			
			select  parita_euro
			into  :ll_parita_euro
			from valuta
			where id_valuta = :ll_id_valuta;	
			
			ls_carica  = ds_credito.getitemstring(ll_row, "dich_per_iva_cod_carica")
			ls_codfisc = ds_credito.getitemstring(ll_row, "dich_per_iva_cod_fisc_dich")
				update dich_per_iva
				set cod_carica = :ls_carica, cod_fisc_dich = :ls_codfisc
				where id_dich_per_iva = :ll_dich;			
			
         if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
	         ll_rif_liq = round((ds_credito.getitemnumber(ll_row, "dich_per_iva_vp12b")/ll_parita_euro),4)				
				
			else
				ll_rif_liq = round(ds_credito.getitemnumber(ll_row, "dich_per_iva_vp12b")/1000,0)*1000
			end if								
			
		  if not (isnull(ll_rif_liq)) then
		
			update dich_per_iva
				set vp10b = :ll_rif_liq
				where id_dich_per_iva = :ll_dich;
				
				ll_vp10b = ll_rif_liq
			end if
			
         if ls_eurolire = 'S' and ll_val_lire = ll_id_valuta then
				ll_rif_liq = round((ds_credito.getitemnumber(ll_row, "dich_per_iva_vp12")/ll_parita_euro),4)	
				
			else
				ll_rif_liq = round(ds_credito.getitemnumber(ll_row, "dich_per_iva_vp12")/1000,0)*1000
			end if											
			
		if ll_rif_liq <= 50000 then
		  if not (isnull(ll_rif_liq)) then
		
			update dich_per_iva
				set vp10 = :ll_rif_liq
				where id_dich_per_iva = :ll_dich;
				
			ll_vp10 = ll_rif_liq
		  end if			
		end if
		
		end if  

		DESTROY ds_credito
		
      

		
		
		
		
		
		
		

		if isnumber(ls_rif) = TRUE then 
			li_rif = integer(ls_rif)
		else
			li_rif = 0
		end if
		if ll_vp5 > ll_vp6 then
			ll_vp7= (ll_vp5 - ll_vp6)
			
			update dich_per_iva
				set vp7 = :ll_vp7
				where id_dich_per_iva = :ll_dich;			
			
		  	ll_vp7b = 0
			  
			update dich_per_iva
				set vp7b = :ll_vp7b
				where id_dich_per_iva = :ll_dich;			
		else
			ll_vp7b = (ll_vp6 - ll_vp5)
			
			update dich_per_iva
				set vp7b = :ll_vp7b
				where id_dich_per_iva = :ll_dich;			
				
			ll_vp7 = 0	
			
			update dich_per_iva
				set vp7 = :ll_vp7
				where id_dich_per_iva = :ll_dich;						
		end if

		ll_vp12  = ll_vp7  + ll_vp8  + ll_vp9   + ll_vp10
		ll_vp12b = ll_vp7b + ll_vp8b + ll_vp10b + ll_vp11
	
		if ll_vp12 > ll_vp12b then
			ll_vp12 = ll_vp12 - ll_vp12b
		
			update dich_per_iva
				set vp12 = :ll_vp12
				where id_dich_per_iva = :ll_dich;									
			
			ll_vp12b = 0
			
			update dich_per_iva
				set vp12b = :ll_vp12b
				where id_dich_per_iva = :ll_dich;												
		else
			ll_vp12b = ll_vp12b - ll_vp12
		
			update dich_per_iva
				set vp12b = :ll_vp12b
				where id_dich_per_iva = :ll_dich;												
				
			ll_vp12 = 0
			
			update dich_per_iva
				set vp12 = :ll_vp12
				where id_dich_per_iva = :ll_dich;															
			
		end if

		if ls_tipo <> 'T' then
			ll_vp16 = (ll_vp12 - ll_vp13 + ll_vp14 - ll_vp15)
		else
			if li_rif <> 4 then
				ll_vp16 = (ll_vp12 - ll_vp13 + ll_vp14 - ll_vp15)		
			else
				ll_vp16 = 0
			end if
		end if

		update dich_per_iva
			set vp16 = :ll_vp16
			where id_dich_per_iva = :ll_dich;														
	
		
		if ll_vp16 > 50000 then
			ld_iva_deb= ll_vp16

			if not (isnull(ld_iva_deb)) then
				ld_iva_ver = long (RIGHT(string(ld_iva_deb), 3))
		
				if ld_iva_ver > 500 then
					ld_dif = long (RIGHT(string(ld_iva_deb), 3)) - 500
	
				else
					ld_dif = long (RIGHT(string(ld_iva_deb), 3)) 
	
				end if
		
			ld_iva_ver = ld_iva_deb - ld_dif
	
			end if
		else
			ld_iva_ver = 0
		end if

		update dich_per_iva
			set vp17 = :ld_iva_ver
			where id_dich_per_iva = :ll_dich;														
		
		
		
	ELSE	
	END IF 

select  id_dich_per_iva  
	into  :ll_dich
	from dich_per_iva
	where id_esercizio = :ll_id_es and
			id_attivita = :ll_id_att and
			tipo_dichiarazione = :ls_tipo and
			rif_dichiarazione = :ls_rif;
			
il_id_dich_per = ll_dich
END IF  


end subroutine

event open;boolean lb_ges_periodo

ls_param=Message.PowerObjectParm	

date ld_data_in,ld_data_fin, ld_ultima_liq
long ll_id_esercizio,ll_id_attivita, ll_test, ll_row, ll_registro
decimal ld_acconto, ld_iva_corr, ld_perc_prorata, ld_iva_credito, ld_iva_debito
decimal ld_c_imposta,ld_c_periodo
string ls_flag, ls_calcola_precedente
string ls_ges_periodo, ls_rif, ls_liqiva
integer li_pagine, li_a_Pag, li_anno
uo_liq_ventilata lo_sp
datastore lds_corr
string ls_tmp_iva
long ll_mod_sosp, ll_reg_sosp

ll_id_esercizio=ls_param.id_esercizio
ll_id_attivita=ls_param.id_attivita
ld_data_in=ls_param.data_in
ld_data_fin=ls_param.data_fin
ld_acconto=ls_param.acconto
ls_flag=ls_param.flag
lb_ges_periodo=ls_param.ges_periodo
ld_c_imposta=ls_param.c_imposta
ld_c_periodo=ls_param.c_periodo
ls_rif=ls_param.rif_dich
ls_liqiva=ls_param.tipo_dich
ls_calcola_precedente=ls_param.s_calcola_credito
if isnull(ls_calcola_precedente) then ls_calcola_precedente='N'
select tmp_iva, id_mod_reg_iva_sos  into :ls_tmp_iva, :ll_mod_sosp from par_sistema; 
if isnull(ll_mod_sosp) then ll_mod_sosp=0

if lb_ges_periodo=true then 
	ls_ges_periodo='S'
else	
	ls_ges_periodo='N' 	
end if
ld_iva_corr=0

if isnull(ld_c_imposta) then ld_c_imposta=0
if isnull(ld_acconto) then ld_acconto=0
if isnull(ld_c_periodo) then ld_c_periodo=0

if ls_calcola_precedente='S' then
	ld_data_fin=relativedate(ld_data_in, -1)
	select data_inizio
	into :ld_data_in
	from dba.esercizio
	where id_esercizio=:ll_id_esercizio;

	if ls_tmp_iva='S' then
		lo_sp= create  uo_liq_ventilata
		lo_sp.uf_divisioni_iva(ll_id_esercizio,ld_data_in,ld_data_fin,ll_id_attivita)
		destroy lo_sp
	
		lds_corr= create datastore
		lds_corr.dataobject="d_st_liq_iva_vent_corr_a4"
		lds_corr.settransobject(sqlca)
		ll_test=lds_corr.retrieve(ls_flag, ll_id_esercizio, ll_id_attivita, ld_data_in, ld_data_fin)
		if ll_test>0 then	ld_iva_corr=lds_corr.getitemdecimal(ll_test, "tot_iva")
		if isnull(ld_iva_corr) then ld_iva_corr=0
	
		destroy lds_corr
		if ls_param.las_aghi='N' then 
			dw_1.dataobject='d_st_liq_iva_vent_gd_a4'  //a4
		elseif ls_param.las_aghi='P' then 
			dw_1.dataobject='d_liq_iva' //?? num pagine???
		else
			dw_1.dataobject='d_st_liq_iva_vent_gd'  //aghi
		end if	
		dw_1.settransobject(sqlca)
		
		dw_1.retrieve(ls_flag,ll_id_attivita,ld_data_in,ld_data_fin,ld_c_imposta,ld_acconto,ld_c_periodo,ls_ges_periodo, ll_mod_sosp, ld_iva_corr)	
	else	
		if ls_param.las_aghi='N' then 
			dw_1.dataobject='d_st_liq_iva_gd_a4' 
		elseif ls_param.las_aghi='P' then 
			dw_1.dataobject='d_liq_iva'
		end if
		dw_1.settransobject(sqlca)
		dw_1.retrieve(ls_flag,ll_id_attivita,ld_data_in,ld_data_fin, &
		ld_c_imposta,ld_acconto,ld_c_periodo,ls_ges_periodo, ll_mod_sosp)
	end if
	if dw_1.dataobject='d_liq_iva' then
		ll_registro=long(ls_param.dich_per)
		select pagine_prep, pagine_usate, anno
		into :li_a_pag, :li_pagine, :li_anno
		from dba.contatori_bollati
		where id_registro=:ll_registro;
		select descrizione
		into :ls_param.dich_per 
		from dba.registro
		where id_registro=:ll_registro;
		dw_1.object.t_reg.text=ls_param.dich_per
		
		dw_1.object.pagine.text=string(li_pagine)
		dw_1.object.t_anno.text=string(li_anno)
		dw_1.object.na_pag.text=string(li_a_pag)
	end if
	close(w_attesa)
	
	

	SELECT perc_prorata INTO :ld_perc_prorata
	  FROM registro WHERE id_attivita=:ll_id_attivita 
		AND id_esercizio=:ll_id_esercizio 
		AND tipo_registro='IA';
		
	SELECT MAX(ULTIMA_LIQ) INTO :ld_ultima_liq
	FROM RIEP_IVA;
	
	IF ld_c_periodo=0 THEN
		SELECT IVA_CREDITO INTO :ld_iva_credito
		FROM RIEP_IVA WHERE ULTIMA_LIQ=:ld_ultima_liq;
		if isnull(ld_iva_credito) then	
			ld_iva_credito=0
		end if
	ELSE
		ld_iva_credito=ld_c_periodo
	END IF
	
	SELECT IVA_DEBITO INTO : ld_iva_debito
	FROM RIEP_IVA WHERE ULTIMA_LIQ=:ld_ultima_liq;
	if isnull(ld_iva_debito) then
		ld_iva_debito=0
	end if
	if ld_iva_debito > 26 then
		ld_iva_debito=0
	end if
	
	ll_row=dw_1.rowcount()
	dw_1.setitem(ll_row,'cper_prorata',ld_perc_prorata)	 
	dw_1.setitem(ll_row,'cc_periodo',ld_iva_credito)
	dw_1.setitem(ll_row,'deb_prec',ld_iva_debito)
	//recupero l'iva precedente
	if dw_1.rowcount()>0 then
		ld_c_periodo=dw_1.getitemdecimal(1, "tot_liq")
	end if	
	ld_data_in=ls_param.data_in
	ld_data_fin=ls_param.data_fin
	
end if
//fine calcolo iva periodo precedente


	if ls_tmp_iva='S' then
		
		lo_sp= create  uo_liq_ventilata
		lo_sp.uf_divisioni_iva(ll_id_esercizio,ld_data_in,ld_data_fin,ll_id_attivita)
		destroy lo_sp
	
		lds_corr= create datastore
		lds_corr.dataobject="d_st_liq_iva_vent_corr_a4"
		lds_corr.settransobject(sqlca)
		ll_test=lds_corr.retrieve(ls_flag, ll_id_esercizio, ll_id_attivita, ld_data_in, ld_data_fin)
		if ll_test>0 then	ld_iva_corr=lds_corr.getitemdecimal(ll_test, "tot_iva")
		if isnull(ld_iva_corr) then ld_iva_corr=0
	
		destroy lds_corr
		if ls_param.las_aghi='N' then 
			dw_1.dataobject='d_st_liq_iva_vent_gd_a4'
		elseif ls_param.las_aghi='P' then 
			dw_1.dataobject='d_liq_iva'
		else
			dw_1.dataobject='d_st_liq_iva_vent_gd'
		end if	
		dw_1.settransobject(sqlca)
		
		dw_1.retrieve(ls_flag,ll_id_attivita,ld_data_in,ld_data_fin,ld_c_imposta,ld_acconto,ld_c_periodo,ls_ges_periodo, ll_mod_sosp, ld_iva_corr)	
	else	
		if ls_param.las_aghi='N' then 
			dw_1.dataobject='d_st_liq_iva_gd_a4' 
		elseif ls_param.las_aghi='P' then 
			dw_1.dataobject='d_liq_iva'
		end if
			dw_1.settransobject(sqlca)
			dw_1.retrieve(ls_flag,ll_id_attivita,ld_data_in,ld_data_fin, &
			ld_c_imposta,ld_acconto,ld_c_periodo,ls_ges_periodo, ll_mod_sosp)
	
	 
	end if
	if dw_1.dataobject='d_liq_iva' then
		ll_registro=long(ls_param.dich_per)
		select pagine_prep, pagine_usate, anno
		into :li_a_pag, :li_pagine, :li_anno
		from dba.contatori_bollati
		where id_registro=:ll_registro;
		select descrizione
		into :ls_param.dich_per 
		from dba.registro
		where id_registro=:ll_registro;
		dw_1.object.t_reg.text=ls_param.dich_per
		
		dw_1.object.pagine.text=string(li_pagine)
		dw_1.object.t_anno.text=string(li_anno)
		dw_1.object.na_pag.text=string(li_a_pag)
	end if
	close(w_attesa)
	
	
	
	SELECT perc_prorata INTO :ld_perc_prorata
	  FROM registro WHERE id_attivita=:ll_id_attivita 
		AND id_esercizio=:ll_id_esercizio 
		AND tipo_registro='IA';
	
	SELECT MAX(ULTIMA_LIQ) INTO :ld_ultima_liq
	FROM RIEP_IVA;
	
	IF ld_c_periodo=0 THEN
		SELECT IVA_CREDITO INTO :ld_iva_credito
		FROM RIEP_IVA WHERE ULTIMA_LIQ=:ld_ultima_liq;
		if isnull(ld_iva_credito) then	
			ld_iva_credito=0
		end if
	ELSE
		ld_iva_credito=ld_c_periodo
	END IF
	
	SELECT IVA_DEBITO INTO : ld_iva_debito
	FROM RIEP_IVA WHERE ULTIMA_LIQ=:ld_ultima_liq;
	if isnull(ld_iva_debito) then
		ld_iva_debito=0
	end if
	if ld_iva_debito > 26 then
		ld_iva_debito=0
	end if
	
	ll_row=dw_1.rowcount()
	dw_1.setitem(ll_row,'cper_prorata',ld_perc_prorata)	 
	dw_1.setitem(ll_row,'cc_periodo',ld_iva_credito)
	dw_1.setitem(ll_row,'deb_prec',ld_iva_debito)

end event

on w_st_liq_iva_rpt.create
call super::create
end on

on w_st_liq_iva_rpt.destroy
call super::destroy
end on

type dw_1 from w_stampa_001`dw_1 within w_st_liq_iva_rpt
integer width = 3707
string dataobject = "d_st_liq_iva_gd"
end type

event dw_1::retrieveend;decimal ld_tot
long ll_row

ll_row=dw_1.Find ( "tipo_registro='IC'", 1, rowcount )
if ll_row>0 then 
	ld_tot=round(this.getitemdecimal(ll_row,'tot_iva_mrc_ic'),2)
	this.setitem(rowcount,'totale2',ld_tot)
end if	

end event

type sle_pg from w_stampa_001`sle_pg within w_st_liq_iva_rpt
end type

type st_1 from w_stampa_001`st_1 within w_st_liq_iva_rpt
end type

type st_2 from w_stampa_001`st_2 within w_st_liq_iva_rpt
end type

type sle_copie from w_stampa_001`sle_copie within w_st_liq_iva_rpt
end type

type sle_zoom from w_stampa_001`sle_zoom within w_st_liq_iva_rpt
end type

type cb_salva_su_file from w_stampa_001`cb_salva_su_file within w_st_liq_iva_rpt
end type

type cb_7 from w_stampa_001`cb_7 within w_st_liq_iva_rpt
end type

type cb_6 from w_stampa_001`cb_6 within w_st_liq_iva_rpt
end type

type cb_imp_st from w_stampa_001`cb_imp_st within w_st_liq_iva_rpt
end type

type cb_stampa from w_stampa_001`cb_stampa within w_st_liq_iva_rpt
integer x = 3429
integer weight = 700
end type

event cb_stampa::clicked;printsetup()
dw_1.print()

s_liq_iva ls_liq_iva
decimal ld_differenza,ld_totale_d,ld_totale_c, ld_cc_imposta
long ll_row

ll_row=dw_1.rowcount()
ls_liq_iva.plafond_diff=dw_1.getitemdecimal(ll_row,'plafond_diff')

ls_liq_iva.interessi=dw_1.getitemdecimal(ll_row,'interessi')


ld_cc_imposta=dw_1.getitemdecimal(ll_row,'cc_imposta')
if isnull(ld_cc_imposta) then ld_cc_imposta=0

ld_differenza=dw_1.getitemdecimal(ll_row,'differenza') -  ld_cc_imposta


ld_totale_d=dw_1.getitemdecimal(ll_row,"totale_d")
ld_totale_c=dw_1.getitemdecimal(ll_row,"totale_c") -  ld_cc_imposta

if ld_totale_d>ld_totale_c then
  	ls_liq_iva.iva_debito=ld_differenza
else
	ls_liq_iva.iva_credito=ld_differenza
end if

ls_liq_iva.per_prorata=dw_1.getitemdecimal(ll_row,'cper_prorata')


if ls_param.dich_per = 'S' then
	wf_dich_per()
	if ls_param.las_aghi='N' then 
		dw_1.dataobject='d_dich_per_iva_breve'
		dw_1.settransobject(sqlca)
		dw_1.retrieve(il_id_dich_per)
		dw_1.print()	
	else
		dw_1.dataobject='d_dich_per_iva_breve_aghi'
		dw_1.settransobject(sqlca)
		dw_1.retrieve(il_id_dich_per)
		dw_1.print()			
	end if		

end if
dw_1.object.datawindow.print.preview='yes'
ls_liq_iva.num_pagine_usate=dw_1.getitemnumber(1,"page")
closewithreturn(parent,ls_liq_iva)

end event

type cb_preview from w_stampa_001`cb_preview within w_st_liq_iva_rpt
end type

type cb_pg_dopo from w_stampa_001`cb_pg_dopo within w_st_liq_iva_rpt
end type

type cb_pg_prima from w_stampa_001`cb_pg_prima within w_st_liq_iva_rpt
end type

type cb_1 from w_stampa_001`cb_1 within w_st_liq_iva_rpt
end type

