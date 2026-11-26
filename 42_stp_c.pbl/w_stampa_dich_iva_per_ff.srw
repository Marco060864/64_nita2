forward
global type w_stampa_dich_iva_per_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_stampa_dich_iva_per_ff
end type
type cb_annulla from commandbutton within w_stampa_dich_iva_per_ff
end type
type dw_1 from u_dw_ext_main within w_stampa_dich_iva_per_ff
end type
type st_1 from statictext within w_stampa_dich_iva_per_ff
end type
type cb_tab_ali_dich_per from commandbutton within w_stampa_dich_iva_per_ff
end type
end forward

global type w_stampa_dich_iva_per_ff from w_wiz_main
int Width=1605
int Height=1080
WindowType WindowType=response!
boolean TitleBar=true
string Title="Elaborazione Dichiarazione Periodica IVA"
long BackColor=78682240
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
st_1 st_1
cb_tab_ali_dich_per cb_tab_ali_dich_per
end type
global w_stampa_dich_iva_per_ff w_stampa_dich_iva_per_ff

type variables
date		id_data_registrazione
boolean		ib_feed_struct = FALSE
boolean lb_ges_periodo
end variables

on w_stampa_dich_iva_per_ff.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.st_1=create st_1
this.cb_tab_ali_dich_per=create cb_tab_ali_dich_per
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_tab_ali_dich_per
end on

on w_stampa_dich_iva_per_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.cb_tab_ali_dich_per)
end on

event open;call super::open;

long ll_id_attivita, ll_id_eser
string ls_data_fine, ls_liq_iva, ls_trim_mese, ls_annoes
integer li_mese, li_anno, li_ret
boolean lb_trimestrale, lb_mensile
lb_ges_periodo=false
datawindowchild ldw_id_esercizio, ldw_attivita, ldw_attivita_1,  ldw_attivita_2, ldw_id_riep_iva

dw_1.getchild("id_esercizio",ldw_id_esercizio)
ldw_id_esercizio.settransobject(sqlca)
ldw_id_esercizio.retrieve()

dw_1.getchild("id_riep_iva",ldw_id_riep_iva)
ldw_id_riep_iva.settransobject(sqlca)
ldw_id_riep_iva.retrieve()

dw_1.getchild("id_attivita",ldw_attivita)
ldw_attivita.settransobject(sqlca)
ldw_attivita.retrieve()

dw_1.getchild("id_attivita_1",ldw_attivita_1)
ldw_attivita_1.settransobject(sqlca)
ldw_attivita_1.retrieve()


dw_1.getchild("id_attivita_2",ldw_attivita_2)
ldw_attivita_2.settransobject(sqlca)
ldw_attivita_2.retrieve()

IF dw_1.GetRow() = 0 THEN
	dw_1.InsertRow(0)
END IF

long ll_id_esercizio_proposto
date ld_data_inizio, ld_data_fine

  SELECT "azienda"."id_esercizio_proposto", 
         "azienda"."id_attivita"
	 INTO :ll_id_esercizio_proposto,:ll_id_attivita
    FROM "azienda"  
   WHERE "azienda"."id_azienda" = 1   ;

  SELECT "attivita"."liq_iva"
	 INTO :ls_liq_iva
    FROM "attivita" 
   WHERE "attivita"."id_attivita" = :ll_id_attivita   ;

  SELECT max("riep_iva"."ultima_liq")   
    INTO :ld_data_inizio
    FROM "riep_iva"  
   WHERE "riep_iva"."id_azienda" = 1   ;



dw_1.setitem(1,"rif_dich","1")
dw_1.setitem(1,"id_esercizio",ll_id_esercizio_proposto)

ll_id_eser = dw_1.getitemnumber(1,"id_esercizio")
  SELECT "esercizio"."codice"
	 INTO :ls_annoes
    FROM "esercizio" 
   WHERE "esercizio"."id_esercizio" = :ll_id_eser;


if ls_liq_iva = "T" then
	ld_data_inizio = date("01/01/" + ls_annoes)
	ld_data_fine   = date("31/03/" + ls_annoes)			
else
	ld_data_inizio = date("01/01/" + ls_annoes)
	ld_data_fine   = date("31/01/" + ls_annoes)				
end if	
			
dw_1.setitem(1,"id_attivita",ll_id_attivita)
dw_1.setitem(1,"d_in",ld_data_inizio)
dw_1.setitem(1,"d_fin",ld_data_fine)
if ls_liq_iva = 'M' then 
	dw_1.setitem(1,"tipo_dich","M")
else
	dw_1.setitem(1,"tipo_dich","T")
end if


end event

event closequery;


end event

event ue_post_open;call super::ue_post_open;
string  ls_liq_iva

select liq_iva
	into :ls_liq_iva
	from attivita, azienda
	where azienda.id_azienda = 1 and
	azienda.id_attivita = attivita.id_attivita;
	
dw_1.setitem(1, "tipo_dich", ls_liq_iva)	
	
	
	
end event

type cb_ok from commandbutton within w_stampa_dich_iva_per_ff
event clicked pbm_bnclicked
int X=46
int Y=40
int Width=270
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Elabora"
boolean Default=true
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_id_es, ll_id_att, ll_row, ll_dich, ll_num, ll_vp1, ll_vp5, ll_risp, ll_val_lire, ll_id_valuta, ll_id_riep_iva
long ll_id_prof_risc_fat_sos
date ld_dat1, ld_dat2, ld_dat_dich
boolean b_vai
decimal {4} de_imponibile, de_imposta, de_imponibile_cee, ll_rif_liq, ll_liq_trim, ll_acconto, ll_parita_euro
string ls_tipo, ls_rif, ls_eurolire, ls_carica, ls_codfisc
s_st_param              param_dich
b_vai = true

dw_1.accepttext()

ll_id_es=dw_1.getitemnumber(1,"id_esercizio")
ll_id_att=dw_1.getitemnumber(1,"id_attivita")
ld_dat1= dw_1.getitemdate(1,"d_in")
ld_dat2=dw_1.getitemdate(1,"d_fin")
ld_dat_dich = dw_1.getitemdate(1,"data_mod")
ls_tipo =dw_1.getitemstring(1,"tipo_dich")
ls_rif = dw_1.getitemstring(1,"rif_dich")
ls_eurolire=dw_1.getitemstring(1,"euro_lire")
ll_id_riep_iva = dw_1.getitemnumber(1, "id_riep_iva") 

select  id_val_lire, id_prof_risc_fat_sos
into  :ll_val_lire, :ll_id_prof_risc_fat_sos
from par_sistema;

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
	
ll_risp=	messagebox('Attenzione', 'Esiste già una dichiarazione periodica IVA per il periodo selezionato,~r~nproseguire lo stesso con la elaborazione ?',Question!,YesNo! ,1)
select  id_dich_per_iva  
	into  :ll_dich
	from dich_per_iva
	where id_esercizio = :ll_id_es and
			id_attivita = :ll_id_att and
			tipo_dichiarazione = :ls_tipo and
			rif_dichiarazione = :ls_rif;
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
		  end if			
		end if
		
		end if  

		DESTROY ds_credito
		
	ELSE	
			param_dich.id_esercizio= ll_dich
			CloseWithReturn (w_stampa_dich_iva_per_ff, param_dich)
		
	END IF 

select  id_dich_per_iva  
	into  :ll_dich
	from dich_per_iva
	where id_esercizio = :ll_id_es and
			id_attivita = :ll_id_att and
			tipo_dichiarazione = :ls_tipo and
			rif_dichiarazione = :ls_rif;

param_dich.id_esercizio = ll_dich
CloseWithReturn (w_stampa_dich_iva_per_ff, param_dich)
END IF  


end event

type cb_annulla from commandbutton within w_stampa_dich_iva_per_ff
int X=338
int Y=40
int Width=256
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

s_st_param              param_dich
param_dich.id_esercizio = 0
CloseWithReturn (w_stampa_dich_iva_per_ff, param_dich)
end event

type dw_1 from u_dw_ext_main within w_stampa_dich_iva_per_ff
event ue_post_itemchanged ( )
int X=32
int Y=252
int Width=1522
int Height=716
int TabOrder=10
string DataObject="d_stampa_dich_iva_ff"
end type

event ue_post_itemchanged;call super::ue_post_itemchanged;


end event

event itemchanged;long ll_id_attivita, ll_id_eser
string ls_data_fine, ls_liq_iva, ls_trim_mese, ls_annoes
integer li_mese, li_anno, li_ret
date ld_data_inizio, ld_data_fine, ld_data_app

ll_id_eser = dw_1.getitemnumber(1,"id_esercizio")
  SELECT "esercizio"."codice"
	 INTO :ls_annoes
    FROM "esercizio" 
   WHERE "esercizio"."id_esercizio" = :ll_id_eser;

IF dwo.Name = "id_attivita" THEN
   ll_id_attivita=dec(data)
	
	
   SELECT "attivita"."liq_iva"
	  INTO :ls_liq_iva
     FROM "attivita" 
    WHERE "attivita"."id_attivita" = :ll_id_attivita   ;

   
   SELECT "riep_iva"."ultima_liq"   
     INTO :ld_data_inizio
     FROM "riep_iva"  
    WHERE "riep_iva"."id_azienda" = 1   ;

	
dw_1.setitem(1,"id_attivita",ll_id_attivita)
if ls_liq_iva = 'M' then 
	dw_1.setitem(1,"tipo_dich","M")
	dw_1.setitem(1,"rif_dich",'1')
	dw_1.setitem(1,"mese","1")	
	ld_data_inizio = date("01/01/" + ls_annoes)
	ld_data_fine   = date("31/01/" + ls_annoes)	
	dw_1.setitem(1,"d_in",ld_data_inizio)
   dw_1.setitem(1,"d_fin",ld_data_fine)	
else
	dw_1.setitem(1,"tipo_dich","T")
	dw_1.setitem(1,"rif_dich",'1')
	dw_1.setitem(1,"trim","1")		
	ld_data_inizio = date("01/01/" + ls_annoes)
	ld_data_fine   = date("31/03/" + ls_annoes)	
	dw_1.setitem(1,"d_in",ld_data_inizio)
   dw_1.setitem(1,"d_fin",ld_data_fine)		
end if

lb_ges_periodo=false
END IF

if dwo.name = "mese"  or dwo.name = "trim" then 
	dw_1.setitem(1,"rif_dich",data)
end if

if dwo.name = "mese" then
	CHOOSE CASE data
		CASE "1"
			ld_data_inizio = date("01/01/" + ls_annoes)
			ld_data_fine   = date("31/01/" + ls_annoes)			
			
		CASE "2"
			ld_data_inizio = date("01/02/" + ls_annoes)
			ld_data_app = date ("01/03/" + ls_annoes)
			ld_data_fine = relativedate(ld_data_app, -1)
			
		CASE "3"
			ld_data_inizio = date("01/03/" + ls_annoes)
			ld_data_fine   = date("31/03/" + ls_annoes)			
			
		CASE "4"
			ld_data_inizio = date("01/04/" + ls_annoes)
			ld_data_fine   = date("30/04/" + ls_annoes)			
			
		CASE "5"
			ld_data_inizio = date("01/05/" + ls_annoes)
			ld_data_fine   = date("31/05/" + ls_annoes)			
			
		CASE "6"
			ld_data_inizio = date("01/06/" + ls_annoes)
			ld_data_fine   = date("30/06/" + ls_annoes)						
			
		CASE "7"
			ld_data_inizio = date("01/07/" + ls_annoes)
			ld_data_fine   = date("31/07/" + ls_annoes)						
			
		CASE "8"
			ld_data_inizio = date("01/08/" + ls_annoes)
			ld_data_fine   = date("31/08/" + ls_annoes)						
			
		CASE "9"
			ld_data_inizio = date("01/09/" + ls_annoes)
			ld_data_fine   = date("30/09/" + ls_annoes)						
			
		CASE "10"
			ld_data_inizio = date("01/10/" + ls_annoes)
			ld_data_fine   = date("31/10/" + ls_annoes)						
			
		CASE "11"
			ld_data_inizio = date("01/11/" + ls_annoes)
			ld_data_fine   = date("30/11/" + ls_annoes)						
			
		CASE "12"
			ld_data_inizio = date("01/12/" + ls_annoes)
			ld_data_fine   = date("31/12/" + ls_annoes)						

	END CHOOSE	
	
	dw_1.setitem(1,"d_in",ld_data_inizio)
   dw_1.setitem(1,"d_fin",ld_data_fine)		
end if
	
if dwo.name = "trim" then	
	CHOOSE CASE data
		CASE "1"
			ld_data_inizio = date("01/01/" + ls_annoes)
			ld_data_fine   = date("31/03/" + ls_annoes)			
			
		CASE "2"
			ld_data_inizio = date("01/04/" + ls_annoes)
			ld_data_fine   = date("30/06/" + ls_annoes)			
			
		CASE "3"
			ld_data_inizio = date("01/07/" + ls_annoes)
			ld_data_fine   = date("30/09/" + ls_annoes)			
			
		CASE "4"
			ld_data_inizio = date("01/10/" + ls_annoes)
			ld_data_fine   = date("31/12/" + ls_annoes)						
		
	END CHOOSE	
	dw_1.setitem(1,"d_in",ld_data_inizio)
   dw_1.setitem(1,"d_fin",ld_data_fine)			
end if

IF dwo.Name = "tipo_dich" THEN
	CHOOSE CASE data
		CASE "A"
			dw_1.setitem(1,"rif_dich","")
			ld_data_inizio = date("01/01/" + ls_annoes)
			ld_data_fine   = date("31/12/" + ls_annoes)	
			dw_1.setitem(1,"d_in",ld_data_inizio)
		   dw_1.setitem(1,"d_fin",ld_data_fine)
			
		CASE "M"
			dw_1.setitem(1,"rif_dich","1")
			dw_1.setitem(1,"mese","1")			
			ld_data_inizio = date("01/01/" + ls_annoes)
			ld_data_fine   = date("31/01/" + ls_annoes)	
			dw_1.setitem(1,"d_in",ld_data_inizio)
		   dw_1.setitem(1,"d_fin",ld_data_fine)	
			
		CASE "T"
			dw_1.setitem(1,"rif_dich","1")			
			dw_1.setitem(1,"trim","1")			
			ld_data_inizio = date("01/01/" + ls_annoes)
			ld_data_fine   = date("31/03/" + ls_annoes)	
			dw_1.setitem(1,"d_in",ld_data_inizio)
		   dw_1.setitem(1,"d_fin",ld_data_fine)			
			
	END CHOOSE

end if	


end event

event itemfocuschanged;call super::itemfocuschanged;if dwo.name = "d_fin" then
	cb_ok.enabled=true

end if

end event

type st_1 from statictext within w_stampa_dich_iva_per_ff
int X=50
int Y=160
int Width=1504
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Immettere la data di inizio e di fine delle registrazioni contabili ."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_tab_ali_dich_per from commandbutton within w_stampa_dich_iva_per_ff
int X=960
int Y=36
int Width=594
int Height=80
int TabOrder=40
boolean BringToTop=true
string Text="Tabella raffronto aliquote"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;open(w_tab_ali_dich_per)
end event

