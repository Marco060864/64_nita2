forward
global type w_stampa_liq_iva1_ff from window
end type
type cb_2 from commandbutton within w_stampa_liq_iva1_ff
end type
type dw_1 from datawindow within w_stampa_liq_iva1_ff
end type
type cb_7 from commandbutton within w_stampa_liq_iva1_ff
end type
type cb_6 from commandbutton within w_stampa_liq_iva1_ff
end type
type cb_5 from commandbutton within w_stampa_liq_iva1_ff
end type
type cb_4 from commandbutton within w_stampa_liq_iva1_ff
end type
type cb_3 from commandbutton within w_stampa_liq_iva1_ff
end type
type cb_1 from commandbutton within w_stampa_liq_iva1_ff
end type
end forward

shared variables

end variables

global type w_stampa_liq_iva1_ff from window
integer x = 5
integer y = 48
integer width = 3707
integer height = 2432
boolean titlebar = true
string title = "Liquidazione IVA"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 78748035
event ue_post_open ( )
cb_2 cb_2
dw_1 dw_1
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
end type
global w_stampa_liq_iva1_ff w_stampa_liq_iva1_ff

type variables
long il_zoom

s_param1 ls_param
long il_id_dich_per

end variables

forward prototypes
public subroutine wf_dich_per ()
end prototypes

event ue_post_open;dw_1.Height=(this.Height) - 272


end event

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
long ll_id_esercizio,ll_id_attivita, ll_prova1
decimal ld_acconto, ll_prova , ld_perc_prorata, ld_iva_credito, ld_iva_debito
decimal ld_c_imposta,ld_c_periodo
string ls_flag, ls_mese, ls_calcola_iva_precedente, ls_tmp_iva
integer li_trimestre
string ls_ges_periodo, ls_rif, ls_liqiva
long ll_righe, i, ll_mod_sosp, ll_reg_sosp
datastore lds_corr
uo_liq_ventilata lo_sp


	

ll_id_esercizio=ls_param.id_esercizio
ll_id_attivita=ls_param.id_attivita
ld_data_in=ls_param.data_in
ld_data_fin=ls_param.data_fin
ld_acconto=ls_param.acconto
ls_flag=ls_param.flag
ls_mese=ls_param.mese
li_trimestre=ls_param.trimestre
lb_ges_periodo=ls_param.ges_periodo
ld_c_imposta=ls_param.c_imposta
ld_c_periodo=ls_param.c_periodo

ls_rif=ls_param.rif_dich
ls_liqiva=ls_param.tipo_dich


select tmp_iva, id_mod_reg_iva_sos  into :ls_tmp_iva, :ll_mod_sosp from par_sistema;  
if isnull(ll_mod_sosp) then ll_mod_sosp=0

if ls_calcola_iva_precedente='S' then
	ld_data_fin=relativedate(ld_data_in, -1)
	select data_inizio
	into :ld_data_in
	from dba.esercizio
	where id_esercizio=:ll_id_esercizio;

	if ls_tmp_iva='S' then
		
		lo_sp= create  uo_liq_ventilata
		lo_sp.uf_divisioni_iva(ll_id_esercizio,ld_data_in,ld_data_fin,ll_id_attivita)
		destroy lo_sp
	
		if lb_ges_periodo=true then
			ls_ges_periodo='S'
		else
			ls_ges_periodo='N'
		end if
		lds_corr= create datastore
		lds_corr.dataobject="d_stampa_liq_iva_corr_a4"
		lds_corr.settransobject(sqlca)
		ll_prova1=lds_corr.retrieve(ls_flag, ll_id_esercizio, ll_id_attivita, ld_data_in, ld_data_fin)
		if ll_prova1>0 then
			ll_prova=lds_corr.getitemdecimal(ll_prova1, "tot_iva")
		else
			ll_prova=0
		end if	
		destroy lds_corr
		if ls_param.las_aghi='N' then 
			dw_1.dataobject='d_stampa_liq_iva_vent_a4'
		else
			dw_1.dataobject='d_stampa_liq_iva_vent'
		end if	
		dw_1.settransobject(sqlca)
		
		dw_1.retrieve(ls_flag,ll_id_esercizio,ll_id_attivita,ld_data_in,ld_data_fin,ld_c_imposta,ld_acconto,ld_c_periodo,ls_ges_periodo, ll_prova, ll_mod_sosp)	
	else	
		lds_corr= create datastore
		lds_corr.dataobject="d_stampa_liq_iva_corr_laser"
		lds_corr.settransobject(sqlca)
		ll_prova1=lds_corr.retrieve(ls_flag, ll_id_esercizio, ll_id_attivita, ld_data_in, ld_data_fin)
		if ll_prova1>0 then
			ll_prova=lds_corr.getitemdecimal(1, "tot_iva")
			if 	ll_prova=0 then 
				dw_1.object.d_stampa_liq_iva_corr_laser.visible=false				
			end if
		else
			dw_1.object.d_stampa_liq_iva_corr_laser.visible=false
		end if
		destroy lds_corr
		if lb_ges_periodo=true then
			ls_ges_periodo='S'
		else
			ls_ges_periodo='N'
		end if
	
		if ls_param.las_aghi='N' then 
			dw_1.dataobject='d_stampa_liq_iva_laser_a4'
		elseif ls_param.las_aghi='P' then //stampa con numeri di pgg
			dw_1.dataobject='d_liq_iva'
		end if
		dw_1.settransobject(sqlca)
		
		dw_1.retrieve(ls_flag,ll_id_esercizio,ll_id_attivita,ld_data_in,ld_data_fin,ld_c_imposta,ld_acconto,ld_c_periodo,ls_ges_periodo, ll_mod_sosp) 
	end if
	
	close(w_attesa)
	il_zoom=100
	
	
	select perc_prorata
	  into :ld_perc_prorata
	  from registro
	 where id_attivita=:ll_id_attivita and 
			 id_esercizio=:ll_id_esercizio and
			 tipo_registro='IA';
	
	
	SELECT MAX(ULTIMA_LIQ) 
	  INTO :ld_ultima_liq
	  FROM RIEP_IVA;
	
	SELECT IVA_CREDITO 
	  INTO :ld_iva_credito
	  FROM RIEP_IVA
	 WHERE ULTIMA_LIQ=:ld_ultima_liq;
	if isnull(ld_iva_credito) then
		ld_iva_credito=0
	end if
	
	SELECT IVA_DEBITO 
	  INTO : ld_iva_debito
	  FROM RIEP_IVA
	 WHERE ULTIMA_LIQ=:ld_ultima_liq;
	if isnull(ld_iva_debito) then
		ld_iva_debito=0
	end if
	if ld_iva_debito > 50.000 then
		ld_iva_debito=0
	end if
	
	
	ll_righe=dw_1.rowcount()
	FOR i=1 TO ll_righe
		 dw_1.object.a.object.cper_prorata[i]=ld_perc_prorata
		 dw_1.object.b.object.cper_prorata[i]=ld_perc_prorata
		 dw_1.object.c.object.cper_prorata[i]=ld_perc_prorata
		 
		 dw_1.object.a.object.cult_iva_credito[i]=ld_iva_credito
		 dw_1.object.b.object.cult_iva_credito[i]=ld_iva_credito
		 dw_1.object.c.object.cult_iva_credito[i]=ld_iva_credito
		 
		 dw_1.object.a.object.cmese[i]=ls_mese
		 dw_1.object.b.object.cmese[i]=ls_mese
		 dw_1.object.c.object.cmese[i]=ls_mese
		 
		 dw_1.object.a.object.ctrimestre[i]=li_trimestre
		 dw_1.object.b.object.ctrimestre[i]=li_trimestre
		 dw_1.object.c.object.ctrimestre[i]=li_trimestre
		 dw_1.object.c.object.deb_prec[i]=ld_iva_debito
	NEXT
	
	if ls_tmp_iva<>'S' or isnull(ls_tmp_iva)  then   
		decimal ld_tot
		if ll_prova1>0 then
			dw_1.object.c.object.tot_corr[i]=ll_prova
			
			
		end if	
	end if	
end if
//recupero l'iva precedente
ld_c_periodo=dw_1.getitemdecimal(1, "c_iva_differenza")
//fine calcolo iva periodo precedente

//ll_id_esercizio=ls_param.id_esercizio
//ll_id_attivita=ls_param.id_attivita
ld_data_in=ls_param.data_in
ld_data_fin=ls_param.data_fin
//ld_acconto=ls_param.acconto
//ls_flag=ls_param.flag
//ls_mese=ls_param.mese
//li_trimestre=ls_param.trimestre
//lb_ges_periodo=ls_param.ges_periodo
//ld_c_imposta=ls_param.c_imposta
//ld_c_periodo=ls_param.c_periodo

ls_rif=ls_param.rif_dich
ls_liqiva=ls_param.tipo_dich


if ls_tmp_iva='S' then
	lo_sp= create  uo_liq_ventilata
   lo_sp.uf_divisioni_iva(ll_id_esercizio,ld_data_in,ld_data_fin,ll_id_attivita)
	destroy lo_sp

	if lb_ges_periodo=true then
		ls_ges_periodo='S'
	else
		ls_ges_periodo='N'
	end if
	lds_corr= create datastore
	lds_corr.dataobject="d_stampa_liq_iva_corr_a4"
	lds_corr.settransobject(sqlca)
	ll_prova1=lds_corr.retrieve(ls_flag, ll_id_esercizio, ll_id_attivita, ld_data_in, ld_data_fin)
	if ll_prova1>0 then
		ll_prova=lds_corr.getitemdecimal(ll_prova1, "tot_iva")
	else
		ll_prova=0
	end if	
	destroy lds_corr
	if ls_param.las_aghi='N' then 
		dw_1.dataobject='d_stampa_liq_iva_vent_a4'
	else
	   dw_1.dataobject='d_stampa_liq_iva_vent'
	end if	
   dw_1.settransobject(sqlca)
	
   dw_1.retrieve(ls_flag,ll_id_esercizio,ll_id_attivita,ld_data_in,ld_data_fin,ld_c_imposta,ld_acconto,ld_c_periodo,ls_ges_periodo, ll_prova, ll_mod_sosp)	
else	
	lds_corr= create datastore
	lds_corr.dataobject="d_stampa_liq_iva_corr_laser"
	lds_corr.settransobject(sqlca)
	ll_prova1=lds_corr.retrieve(ls_flag, ll_id_esercizio, ll_id_attivita, ld_data_in, ld_data_fin)
	if ll_prova1>0 then
		ll_prova=lds_corr.getitemdecimal(1, "tot_iva")
		if 	ll_prova=0 then 
			dw_1.object.d_stampa_liq_iva_corr_laser.visible=false				
		end if
	else
		dw_1.object.d_stampa_liq_iva_corr_laser.visible=false
	end if
	destroy lds_corr
	if lb_ges_periodo=true then
		ls_ges_periodo='S'
	else
		ls_ges_periodo='N'
	end if

	if ls_param.las_aghi='N' then 
		dw_1.dataobject='d_stampa_liq_iva_laser_a4'
	elseif ls_param.las_aghi='P' then //stampa con numeri di pgg
		dw_1.dataobject='d_liq_iva'
	end if
   dw_1.settransobject(sqlca)
	
   dw_1.retrieve(ls_flag,ll_id_esercizio,ll_id_attivita,ld_data_in,ld_data_fin,ld_c_imposta,ld_acconto,ld_c_periodo,ls_ges_periodo, ll_mod_sosp) 
end if

close(w_attesa)
il_zoom=100


select perc_prorata
  into :ld_perc_prorata
  from registro
 where id_attivita=:ll_id_attivita and 
       id_esercizio=:ll_id_esercizio and
		 tipo_registro='IA';


SELECT MAX(ULTIMA_LIQ) 
  INTO :ld_ultima_liq
  FROM RIEP_IVA;

SELECT IVA_CREDITO 
  INTO :ld_iva_credito
  FROM RIEP_IVA
 WHERE ULTIMA_LIQ=:ld_ultima_liq;
if isnull(ld_iva_credito) then
	ld_iva_credito=0
end if

SELECT IVA_DEBITO 
  INTO : ld_iva_debito
  FROM RIEP_IVA
 WHERE ULTIMA_LIQ=:ld_ultima_liq;
if isnull(ld_iva_debito) then
	ld_iva_debito=0
end if
if ld_iva_debito > 50.000 then
	ld_iva_debito=0
end if


ll_righe=dw_1.rowcount()
FOR i=1 TO ll_righe
	 dw_1.object.a.object.cper_prorata[i]=ld_perc_prorata
	 dw_1.object.b.object.cper_prorata[i]=ld_perc_prorata
	 dw_1.object.c.object.cper_prorata[i]=ld_perc_prorata
	 
	 dw_1.object.a.object.cult_iva_credito[i]=ld_iva_credito
	 dw_1.object.b.object.cult_iva_credito[i]=ld_iva_credito
	 dw_1.object.c.object.cult_iva_credito[i]=ld_iva_credito
	 
	 dw_1.object.a.object.cmese[i]=ls_mese
	 dw_1.object.b.object.cmese[i]=ls_mese
	 dw_1.object.c.object.cmese[i]=ls_mese
	 
	 dw_1.object.a.object.ctrimestre[i]=li_trimestre
	 dw_1.object.b.object.ctrimestre[i]=li_trimestre
	 dw_1.object.c.object.ctrimestre[i]=li_trimestre
	 dw_1.object.c.object.deb_prec[i]=ld_iva_debito
NEXT

if ls_tmp_iva<>'S' or isnull(ls_tmp_iva)  then   
		if ll_prova1>0 then
  		dw_1.object.c.object.tot_corr[i]=ll_prova
    	
		
	end if	
end if	
end event

on w_stampa_liq_iva1_ff.create
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.dw_1,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_1}
end on

on w_stampa_liq_iva1_ff.destroy
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event key;

keycode			lk_code
string			ls_nome
windowobject	lw_me

lk_code = key

choose case lk_code
	case KeyF12!
		if keyflags=3 then
			ls_nome = this.ClassName()
			MessageBox ("ClassName",ls_nome)
		end if
	case KeyF1!
		if (keyflags = 0 Or keyflags = 1 Or keyflags = 2) then
		end if
end choose
end event

type cb_2 from commandbutton within w_stampa_liq_iva1_ff
integer x = 3127
integer y = 44
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Setup"
end type

event clicked;printsetup()
end event

type dw_1 from datawindow within w_stampa_liq_iva1_ff
integer x = 23
integer y = 140
integer width = 3611
integer height = 2144
integer taborder = 50
string dataobject = "d_stampa_liq_iva_laser"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieverow;
end event

type cb_7 from commandbutton within w_stampa_liq_iva1_ff
event clicked pbm_bnclicked
integer x = 1760
integer y = 36
integer width = 261
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom Out"
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_stampa_liq_iva1_ff
event clicked pbm_bnclicked
integer x = 1472
integer y = 44
integer width = 261
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Zoom In"
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_liq_iva1_ff
integer x = 411
integer y = 44
integer width = 466
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Precedente"
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_liq_iva1_ff
integer x = 891
integer y = 44
integer width = 466
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pagina Successiva"
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_3 from commandbutton within w_stampa_liq_iva1_ff
integer x = 3383
integer y = 44
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
dw_1.print()



s_liq_iva ls_liq_iva
decimal ld_interessi, ld_differenza,ld_totale_d,ld_totale_c, ld_plafond_diff, ld_per_prorata, ld_cc_imposta


dw_1.object.c.object.cc_periodo[1]=0

ld_plafond_diff=dw_1.object.c.object.plafond_diff[1]
ls_liq_iva.plafond_diff=ld_plafond_diff

ld_interessi=dw_1.object.c.object.interessi[1]
ls_liq_iva.interessi=ld_interessi

ld_cc_imposta=dw_1.object.c.object.cc_imposta[1]
if isnull(ld_cc_imposta) then ld_cc_imposta=0

ld_differenza=dw_1.object.c.object.differenza[2] -  ld_cc_imposta


ld_totale_d=dw_1.object.c.object.totale_d[1]
ld_totale_c=dw_1.object.c.object.totale_c[1] -  ld_cc_imposta



if ld_totale_d>ld_totale_c then
   	ls_liq_iva.iva_debito=ld_differenza
        else
			ls_liq_iva.iva_credito=ld_differenza
end if

ld_per_prorata=dw_1.object.c.object.cper_prorata[1]
ls_liq_iva.per_prorata=ld_per_prorata


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

closewithreturn(w_stampa_liq_iva1_ff,ls_liq_iva)


end event

type cb_1 from commandbutton within w_stampa_liq_iva1_ff
integer x = 23
integer y = 44
integer width = 247
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;close(parent)
end event

