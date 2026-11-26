forward
global type w_dich_per_iva_p2 from w_p_data
end type
type dw_1 from u_dw_master_main within w_dich_per_iva_p2
end type
type cb_1 from commandbutton within w_dich_per_iva_p2
end type
type cb_calcola from commandbutton within w_dich_per_iva_p2
end type
type p_1 from picture within w_dich_per_iva_p2
end type
type cb_2 from commandbutton within w_dich_per_iva_p2
end type
end forward

global type w_dich_per_iva_p2 from w_p_data
int X=123
int Y=188
int Width=2414
int Height=1980
boolean TitleBar=true
string Title="Gestione Dichiarazione Periodica IVA"
long BackColor=78682240
dw_1 dw_1
cb_1 cb_1
cb_calcola cb_calcola
p_1 p_1
cb_2 cb_2
end type
global w_dich_per_iva_p2 w_dich_per_iva_p2

type variables

end variables

forward prototypes
public subroutine uf_aggiorna_sk ()
end prototypes

public subroutine uf_aggiorna_sk ();decimal {4} ll_vp1, ll_vp2, ll_vp3, ll_vp4, ll_vp5, ll_vp6, ll_vp7, ll_vp7b, ll_vp8, ll_vp9, ll_vp10 ,ll_vp11
decimal {4} ll_vp12, ll_vp12b, ll_vp8b, ll_vp10b, ll_vp13, ll_vp14, ll_vp15, ll_vp16
string ls_tipo, ls_rif
long  ld_iva_deb
long ll_row, ld_iva_ver, ld_dif
integer li_rif

ls_tipo = dw_1.getitemstring(1, "tipo_dichiarazione")

ll_vp5   = dw_1.getitemnumber(1, "vp5")  
ll_vp6   = dw_1.getitemnumber(1, "vp6")  
ll_vp8   = dw_1.getitemnumber(1, "vp8") 
ll_vp9   = dw_1.getitemnumber(1, "vp9") 
ll_vp10  = dw_1.getitemnumber(1, "vp10") 
ll_vp8b  = dw_1.getitemnumber(1, "vp8b") 
ll_vp10b = dw_1.getitemnumber(1, "vp10b") 
ll_vp11  = dw_1.getitemnumber(1, "vp11") 
ll_vp13  = dw_1.getitemnumber(1, "vp13")
ll_vp14  = dw_1.getitemnumber(1, "vp14")
ll_vp15  = dw_1.getitemnumber(1, "vp15")
ls_rif   = dw_1.getitemstring(1, "rif_dichiarazione")

if isnumber(ls_rif) = TRUE then 
	li_rif = integer(ls_rif)
else
	li_rif = 0
end if


if ll_vp5 > ll_vp6 then
	ll_vp7= (ll_vp5 - ll_vp6)
   dw_1.setitem(1, "vp7", ll_vp7)
	ll_vp7b = 0
   dw_1.setitem(1, "vp7b", ll_vp7b)	
else
	ll_vp7b = (ll_vp6 - ll_vp5)
   dw_1.setitem(1, "vp7b", ll_vp7b)		
	ll_vp7 = 0	
	dw_1.setitem(1, "vp7", ll_vp7)
end if

ll_vp12  = ll_vp7  + ll_vp8  + ll_vp9   + ll_vp10
ll_vp12b = ll_vp7b + ll_vp8b + ll_vp10b + ll_vp11

if ll_vp12 > ll_vp12b then
	ll_vp12 = ll_vp12 - ll_vp12b
		
   dw_1.setitem(1, "vp12", ll_vp12)
	ll_vp12b = 0
   dw_1.setitem(1, "vp12b", ll_vp12b)	
else
	ll_vp12b = ll_vp12b - ll_vp12
	
   dw_1.setitem(1, "vp12b", ll_vp12b)
	ll_vp12 = 0
   dw_1.setitem(1, "vp12", ll_vp12)		
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

dw_1.setitem(1, "vp16", ll_vp16)

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

dw_1.setitem(1, "vp17", ld_iva_ver)

end subroutine

on w_dich_per_iva_p2.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_calcola=create cb_calcola
this.p_1=create p_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_calcola
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.cb_2
end on

on w_dich_per_iva_p2.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_calcola)
destroy(this.p_1)
destroy(this.cb_2)
end on

event open;call super::open;long ll_screenh

idw_master = dw_1
idw_master.is_list = Message.PowerObjectParm

idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "dich_per_iva.id_dich_per_iva"

ib_NonModale = TRUE

IF UpperBound(idw_master.is_list.s_identifica) = 0 THEN
	idw_master.ias_key_name[1] = "id_dich_per_iva"
	idw_master.is_list.s_modo = modo_inserisci
	
END IF

end event

type p_crescente from w_p_data`p_crescente within w_dich_per_iva_p2
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_dich_per_iva_p2
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_dich_per_iva_p2
int X=23
int Y=20
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_dich_per_iva_p2
int Y=28
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_dich_per_iva_p2
int X=1691
int Y=32
int Width=87
int Height=68
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
FontCharSet FontCharSet=Ansi!
end type

type cb_inserisci from w_p_data`cb_inserisci within w_dich_per_iva_p2
int X=1550
int Y=24
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_dich_per_iva_p2
int X=1829
int Y=20
boolean BringToTop=true
end type

event cb_cancella::clicked;
long ll_riga

ll_riga=dw_1.getrow()
if ll_riga > 0 then
	dw_1.deleterow(ll_riga)
end if
end event

type cb_salva from w_p_data`cb_salva within w_dich_per_iva_p2
int Y=20
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_dich_per_iva_p2
int X=2190
int Y=1332
int Width=192
int Height=148
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
long BackColor=78682240
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=155
int Height=28
end type

type cb_ricerca from w_p_data`cb_ricerca within w_dich_per_iva_p2
int X=1545
int Y=20
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
int Weight=700
FontCharSet FontCharSet=Ansi!
end type

event cb_ricerca::clicked;w_search_main		lw_sm
long					ll_i_dich, ll_row
s_ric_param			ls_ricpar

idw_master.is_ricpar.s_filter_name = "id_dich_per_iva"
idw_master.is_ricpar.s_filter_value=""
OpenWithParm (lw_sm, idw_master.is_ricpar, "w_dich_iva_sc")
idw_master.is_ricpar = Message.PowerObjectParm
IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
	ll_i_dich = long(idw_master.is_ricpar.s_id_seg_value[1])
	idw_master.is_list.s_modo = modo_modifica
	idw_master.is_list.s_identifica[1] = "id_dich_per_iva"
	idw_master.is_list.l_identifica[1] = ll_i_dich
	idw_master.Event ue_retrieve(0, 0)
	idw_master.SetFocus()
end if

dw_1.enabled = true
cb_calcola.enabled = true
uf_aggiorna_sk()
end event

type dw_1 from u_dw_master_main within w_dich_per_iva_p2
int X=23
int Y=124
int Width=2350
int Height=1748
int TabOrder=10
boolean BringToTop=true
string DataObject="d_dich_per_iva_p3"
end type

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_dich_per_iva"

end event

type cb_1 from commandbutton within w_dich_per_iva_p2
int X=297
int Y=20
int Width=535
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Agg./Mod. Modello"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_vp1, ll_vp5, ll_risp, ll_row, ll_id_valuta
date ld_dat1, ld_dat2, ld_dat_dich
decimal {4} de_imponibile, de_imposta, de_imponibile_cee, ll_rif_liq, ll_liq_trim, ll_acconto, ll_val_lire, ll_parita_euro
long ll_dich, ll_righe, ll_id_riep_iva
string ls_tipo, ls_eurolire, ls_rif, ls_carica, ls_codfisc



ll_righe = dw_1.getrow()
IF ll_righe > 0 THEN   

	ls_eurolire=dw_1.getitemstring(ll_righe,"euro_lire")
	
	select  id_val_lire
	into  :ll_val_lire
	from par_sistema;
	
	ll_dich= dw_1.getitemnumber(ll_righe, "id_dich_per_iva")
   ls_tipo = dw_1.getitemstring(ll_righe, "tipo_dichiarazione")	
	ll_id_riep_iva = dw_1.getitemnumber(ll_righe, "id_riep_iva")
	ls_rif = dw_1.getitemstring(ll_righe,"rif_dichiarazione")	

	if ll_id_riep_iva > 0 then
		update dich_per_iva
		set id_riep_iva = :ll_id_riep_iva
		where id_dich_per_iva = :ll_dich;
	end if
	

ll_risp=	messagebox('Attenzione', 'Si procede con la nuova elaborazione del modello ?',Question!,YesNo! ,1)

select data_in_liq, data_fi_liq
	into :ld_dat1, :ld_dat2
	from dich_per_iva
	where id_dich_per_iva = :ll_dich;
		
	If ll_risp = 1 then  
	
	open(w_attesa)

		
		
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
					de_imponibile = round(ds_acq.getitemnumber(ll_row, "a")/1000,0)*1000
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
		
	dw_1.retrieve()
	close (w_attesa)		

	END IF 

END IF 
end event

type cb_calcola from commandbutton within w_dich_per_iva_p2
int X=846
int Y=20
int Width=265
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="Calcola"
int TextSize=-8
int Weight=700
string FaceName="Arial"
boolean Italic=true
boolean Underline=true
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uf_aggiorna_sk()
end event

type p_1 from picture within w_dich_per_iva_p2
int X=1129
int Y=20
int Width=114
int Height=80
boolean BringToTop=true
string PictureName="s:\pb\commonframework\printer.bmp"
boolean FocusRectangle=false
end type

event clicked;
long ll_righe, ll_id

s_st_param strut_dich  

ll_righe = dw_1.getrow()
if ll_righe > 0 then
	ll_id=dw_1.getitemnumber(ll_righe, "id_dich_per_iva")
	strut_dich.id_esercizio = ll_id
	
	OpenWithParm(w_stampa_dichiarazione_rpt_p3, strut_dich)
end if

end event

type cb_2 from commandbutton within w_dich_per_iva_p2
int X=1262
int Y=20
int Width=261
int Height=84
int TabOrder=50
boolean BringToTop=true
string Text="Esporta"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uo_dich_per_iva u_dich_per
u_dich_per=create uo_dich_per_iva
u_dich_per.uf_crea_file(dw_1)
destroy u_dich_per
end event

