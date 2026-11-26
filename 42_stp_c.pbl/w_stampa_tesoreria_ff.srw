forward
global type w_stampa_tesoreria_ff from Window
end type
type cb_2 from commandbutton within w_stampa_tesoreria_ff
end type
type dw_1 from datawindow within w_stampa_tesoreria_ff
end type
type cb_7 from commandbutton within w_stampa_tesoreria_ff
end type
type cb_6 from commandbutton within w_stampa_tesoreria_ff
end type
type cb_5 from commandbutton within w_stampa_tesoreria_ff
end type
type cb_4 from commandbutton within w_stampa_tesoreria_ff
end type
type cb_3 from commandbutton within w_stampa_tesoreria_ff
end type
type cb_1 from commandbutton within w_stampa_tesoreria_ff
end type
end forward

shared variables

end variables

global type w_stampa_tesoreria_ff from Window
int X=5
int Y=48
int Width=3675
int Height=2388
boolean TitleBar=true
string Title="Tesoreria"
long BackColor=80264376
boolean ControlMenu=true
WindowState WindowState=maximized!
WindowType WindowType=response!
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
global w_stampa_tesoreria_ff w_stampa_tesoreria_ff

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

on w_stampa_tesoreria_ff.create
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

on w_stampa_tesoreria_ff.destroy
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

event open;date data_saldo_iniziale, data_saldo_attuale, da_data_estratto, a_data_estratto
long  ll_decimali, ll_val, i, ll_id_conto
string ls_valuta, ls_conto[], ls_da_conto, ls_a_conto
decimal ll_saldo_iniziale, ll_saldo_estratto, ld_cambio

LONG ll_row, ll_breakrow, ll_conto[]
INTEGER li_ret

s_passa_date str_parametri  

str_parametri=message.powerobjectparm
data_saldo_iniziale=str_parametri.data_saldo_iniziale
data_saldo_attuale=str_parametri.data_saldo_fine
da_data_estratto=str_parametri.data_inizio_estratto
a_data_estratto=str_parametri.data_fine_estratto
ls_valuta=str_parametri.valuta
ld_cambio=str_parametri.cambio
ll_decimali=str_parametri.decimali
ll_val=str_parametri.id_valuta
ls_da_conto = str_parametri.da_conto
ls_a_conto = str_parametri.a_conto

datastore ds_stampa
ds_stampa=create datastore
ds_stampa.dataobject='ds_saldo_banca_tes'
ds_stampa.reset()
ds_stampa.settransobject(sqlca)

dw_1.settransobject(sqlca)
dw_1.retrieve(ls_da_conto,ls_a_conto, data_saldo_attuale)

for i=1 to dw_1.rowcount()
	ll_id_conto = dw_1.getitemnumber(i,"conto_id_conto")
	
	
	li_ret=ds_stampa.retrieve(ll_id_conto,str_parametri.data_saldo_iniziale,str_parametri.data_fine_estratto,str_parametri.cambio,str_parametri.decimali, ll_val )
	if li_ret>0 then 
		ll_saldo_iniziale=ds_stampa.getitemdecimal(ds_stampa.rowcount(),'saldo_iniziale')
	else	
		ll_saldo_iniziale=0
	end if			
	dw_1.setitem(i,"saldo",ll_saldo_iniziale)
next
		
destroy ds_stampa

end event

type cb_2 from commandbutton within w_stampa_tesoreria_ff
int X=3127
int Y=40
int Width=247
int Height=84
int TabOrder=40
string Text="Setup"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
end event

type dw_1 from datawindow within w_stampa_tesoreria_ff
int X=23
int Y=140
int Width=3611
int Height=2144
int TabOrder=50
string DataObject="d_st_tesoreria"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event retrieverow;
end event

type cb_7 from commandbutton within w_stampa_tesoreria_ff
event clicked pbm_bnclicked
int X=1760
int Y=36
int Width=261
int Height=88
int TabOrder=30
string Text="Zoom Out"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom - 10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_6 from commandbutton within w_stampa_tesoreria_ff
event clicked pbm_bnclicked
int X=1472
int Y=40
int Width=261
int Height=84
int TabOrder=60
string Text="Zoom In"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;il_zoom=il_zoom+10
dw_1.object.datawindow.zoom=il_zoom
end event

type cb_5 from commandbutton within w_stampa_tesoreria_ff
int X=411
int Y=40
int Width=466
int Height=84
int TabOrder=70
string Text="Pagina Precedente"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage ( ) 
end event

type cb_4 from commandbutton within w_stampa_tesoreria_ff
int X=891
int Y=40
int Width=466
int Height=84
int TabOrder=20
string Text="Pagina Successiva"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage ( ) 
end event

type cb_3 from commandbutton within w_stampa_tesoreria_ff
int X=3383
int Y=40
int Width=247
int Height=84
int TabOrder=10
string Text="Stampa"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;printsetup()
dw_1.print()



end event

type cb_1 from commandbutton within w_stampa_tesoreria_ff
int X=23
int Y=40
int Width=247
int Height=84
int TabOrder=80
string Text="Annulla"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

