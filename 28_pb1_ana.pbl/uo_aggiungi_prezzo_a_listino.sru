forward
global type uo_aggiungi_prezzo_a_listino from nonvisualobject
end type
end forward

global type uo_aggiungi_prezzo_a_listino from nonvisualobject
end type
global uo_aggiungi_prezzo_a_listino uo_aggiungi_prezzo_a_listino

forward prototypes
public subroutine uf_aggiungi_prezzo_a_listino (datawindow adw_art)
public subroutine uf_prezzo_calo_fornitore (decimal ad_prezzo, decimal ad_c_calo, long al_id_uc, long al_id_sog_comm, string as_tipo_um)
end prototypes

public subroutine uf_aggiungi_prezzo_a_listino (datawindow adw_art);long ll_row, ll_id_articolo, ll_id_variazione, ll_id_u_conf, ll_id_unita_misura, ll_id_sog_fornitore
decimal{6} ld_prezzo, coeff_calo, ldc_pr_aggiuntivo
string ls_tipo_um

ll_row=adw_art.getrow()
ll_id_articolo=adw_art.getitemnumber(ll_row,"id_articolo")
ld_prezzo=adw_art.getitemdecimal(ll_row,"prezzo")
coeff_calo = adw_art.getitemdecimal(ll_row,"coef_calo")
ldc_pr_aggiuntivo=adw_art.getitemdecimal(ll_row,"costo_aggiuntivo")

select "unita_confezione"."id_unita_confezione", "unita_confezione"."id_unita_misura", "unita_misura"."tipo"
into :ll_id_u_conf, :ll_id_unita_misura, :ls_tipo_um
from "unita_confezione", "unita_misura"
where "unita_confezione"."id_articolo"=:ll_id_articolo
and "unita_confezione"."unita_base"='S'
and "unita_misura"."id_unita_misura"="unita_confezione"."id_unita_misura";

if ll_id_u_conf>0 then
//	if POS(UPPER(U_FREDDIE.ISTR_DATABASE.NAME),'ORAFO') >0 then
//		select "unita_confezione"."id_unita_misura"
//		into :ll_id_unita_misura
//		from "unita_confezione"
//		where("unita_confezione"."id_articolo"=:ll_id_articolo)
//		and("unita_confezione"."unita_base"='S');
//			
//		select "unita_misura"."tipo"
//		into :ls_tipo_um
//		from "unita_misura"
//		where("unita_misura"."id_unita_misura"=:ll_id_unita_misura);
		
		if ls_tipo_um = 'P' then
			update "prezzo", "listino", "variazione" 
			set "prezzo"."prezzo_manifattura" = :ld_prezzo ,"prezzo"."coef_calo" = :coeff_calo, "prezzo"."galvanica"=:ldc_pr_aggiuntivo
			where ("variazione"."id_variazione"="prezzo"."id_variazione")
			and("listino"."id_listino"="variazione"."id_listino")
			and  ("prezzo"."id_unita_confezione"= :ll_id_u_conf)
			and("listino"."lis_base"='S')  and ("listino"."tipo"='V')
			and(("variazione"."data_fine" >= today()) or("variazione"."data_fine" is null))
			and "variazione"."data_inizio"<=today();
		else
			update "prezzo", "listino", "variazione" 
			set "prezzo"."prezzo" = :ld_prezzo ,"prezzo"."coef_calo" = :coeff_calo, "prezzo"."galvanica"=:ldc_pr_aggiuntivo
			where ("variazione"."id_variazione"="prezzo"."id_variazione")
			and("listino"."id_listino"="variazione"."id_listino")
			and  ("prezzo"."id_unita_confezione"= :ll_id_u_conf)
			and("listino"."lis_base"='S')  and ("listino"."tipo"='V')
			and(("variazione"."data_fine" >= today()) or("variazione"."data_fine" is null))
			and "variazione"."data_inizio"<=today();
		end if
				
		if sqlca.sqlnrows > 0 then
			commit;
		else
			rollback;
			
			select "variazione"."id_variazione"
			into :ll_id_variazione
			from "variazione", "listino"
			where("listino"."lis_base"='S') and ("listino"."tipo"='V')
			and("variazione"."id_listino"="listino"."id_listino")
			and(("variazione"."data_fine" >= today()) or("variazione"."data_fine" is null))
			and "variazione"."data_inizio" <= today();
			
			if ll_id_variazione < 1 then
				messagebox('Errore!','Sembra che non esista una variazione valida per il listino base (v)!',StopSign!)
				return
			end if
				   			
	   	if ls_tipo_um = 'P' then			
				insert into "prezzo"("id_unita_confezione", "id_variazione", "prezzo_manifattura", "coef_calo", "galvanica")
				values (:ll_id_u_conf, :ll_id_variazione, :ld_prezzo, :coeff_calo, :ldc_pr_aggiuntivo);
			else
				insert into "prezzo"("id_unita_confezione", "id_variazione", "prezzo", "coef_calo", "galvanica")
				values (:ll_id_u_conf, :ll_id_variazione, :ld_prezzo, :coeff_calo, :ldc_pr_aggiuntivo);
			end if
			
			if sqlca.sqlnrows>0 then 
				commit;
			else
				rollback;
				messagebox('Errore!','Impossibile aggiornare il listino base! riga 81',StopSign!)							
			end if
		end if
		//ora si passa a gestire il listino di acquisto (fornitori)			
		
	
		ld_prezzo=adw_art.getitemdecimal(ll_row,"prezzo_for")
		coeff_calo	=adw_art.getitemdecimal(ll_row,"coeff_calo")
		
		ll_id_sog_fornitore=adw_art.getitemnumber(ll_row, "id_sog_commerciale")
		if ll_id_sog_fornitore>0 then
			uf_prezzo_calo_fornitore(ld_prezzo, coeff_calo, ll_id_u_conf, ll_id_sog_fornitore, ls_tipo_um)
		end if
	  	
		if ls_tipo_um = 'P' then					
			update "prezzo", "listino", "variazione" 
			set "prezzo"."prezzo_manifattura" = :ld_prezzo, "prezzo"."coef_calo" = :coeff_calo
			where ("variazione"."id_variazione"="prezzo"."id_variazione")
			and("listino"."id_listino"="variazione"."id_listino")
			and  ("prezzo"."id_unita_confezione"= :ll_id_u_conf)
			and("listino"."lis_base"='S')  and ("listino"."tipo"='A')
			and(("variazione"."data_fine" >= today()) or("variazione"."data_fine" is null))
			and "variazione"."data_inizio"<=today();
		else
			update "prezzo", "listino", "variazione" 
			set "prezzo"."prezzo" = :ld_prezzo, "prezzo"."coef_calo" = :coeff_calo
			where ("variazione"."id_variazione"="prezzo"."id_variazione")
			and("listino"."id_listino"="variazione"."id_listino")
			and  ("prezzo"."id_unita_confezione"= :ll_id_u_conf)
			and("listino"."lis_base"='S')  and ("listino"."tipo"='A')
			and(("variazione"."data_fine" >= today()) or("variazione"."data_fine" is null))
			and "variazione"."data_inizio"<=today();		
		end if
			
		if sqlca.sqlnrows > 0 then
			commit;
		else
			rollback;
			ll_id_variazione=0
			
			select "variazione"."id_variazione"
			into :ll_id_variazione
			from "variazione", "listino"
			where("listino"."lis_base"='S') and ("listino"."tipo"='A')
			and("variazione"."id_listino"="listino"."id_listino")
			and(("variazione"."data_fine" >= today()) or ("variazione"."data_fine" is null))
			and "variazione"."data_inizio" <= today();
			
			if ll_id_variazione<1 then
				messagebox('Errore!','Sembra che non esista una variazione valida per il listino base!(APF)',StopSign!)
				return
			end if
			
			select "unita_confezione"."id_unita_confezione"
			into :ll_id_u_conf
			from "unita_confezione"
			where("unita_confezione"."id_articolo"=:ll_id_articolo)
			and("unita_confezione"."unita_base"='S');

			if ls_tipo_um = 'P' then								
				
				insert into "prezzo"("id_unita_confezione", "id_variazione", "prezzo_manifattura", "coef_calo")
				values (:ll_id_u_conf, :ll_id_variazione, :ld_prezzo, :coeff_calo);
			else
				insert into "prezzo"("id_unita_confezione", "id_variazione", "prezzo", "coef_calo")
				values (:ll_id_u_conf, :ll_id_variazione, :ld_prezzo, :coeff_calo);
			end if
			
			if sqlca.sqlnrows >0 then 
				commit;
			else
				rollback;
				messagebox('Errore!','Impossibile aggiornare il listino base! riga 153',StopSign!)
			end if
		end if
		
//	else
//		
//					
//		
//		
//		
//		update "prezzo", "listino", "variazione" 
//		set "prezzo"."prezzo" = :ld_prezzo
//					
//		where ("variazione"."id_variazione"="prezzo"."id_variazione")
//		and("listino"."id_listino"="variazione"."id_listino")
//		and  ("prezzo"."id_unita_confezione"= :ll_id_u_conf)
//		and("listino"."lis_base"='S')  and ("listino"."tipo"='V')
//		and(("variazione"."data_fine" >= today()) or("variazione"."data_fine" is null))
//		and "variazione"."data_inizio"<=today();
//		
//		
//		
//				
//		
//		if sqlca.sqlnrows< 1 then
//			
//			select "variazione"."id_variazione"
//			into :ll_id_variazione
//			from "variazione", "listino"
//			where("listino"."lis_base"='S') and ("listino"."tipo"='V')
//			and("variazione"."id_listino"="listino"."id_listino")
//			and(("variazione"."data_fine" >= today()) or("variazione"."data_fine" is null))
//			and "variazione"."data_inizio" <= today();
//				
//			if sqlca.sqlcode<>0 then
//				messagebox('Errore!','Sembra che non esista una variazione valida per il listino base!(BAV)',StopSign!)
//				return
//			end if
//						
//			
//			insert into "prezzo"("id_unita_confezione", "id_variazione", "prezzo")
//			values (:ll_id_u_conf, :ll_id_variazione, :ld_prezzo);
//			if sqlca.sqlnrows<1 then messagebox('Errore!','Impossibile aggiornare il listino base!',StopSign!)
//		end if
//					
//		
//		
//		
//		
//				
//		ll_id_articolo=adw_art.getitemnumber(ll_row,"id_articolo")
//		ld_prezzo=adw_art.getitemdecimal(ll_row,"prezzo_for")
//				
//		
//		
//		
//		update "prezzo", "listino", "variazione" 
//		set "prezzo"."prezzo" = :ld_prezzo
//				
//		where ("variazione"."id_variazione"="prezzo"."id_variazione")
//		and("listino"."id_listino"="variazione"."id_listino")
//		and  ("prezzo"."id_unita_confezione"= :ll_id_u_conf)
//		and("listino"."lis_base"='S')  and ("listino"."tipo"='A')
//		and(("variazione"."data_fine" >= today()) or("variazione"."data_fine" is null))
//		and "variazione"."data_inizio"<=today();
//		
//		
//		
//					
//		
//		if sqlca.sqlnrows< 1 then
//			
//			select "variazione"."id_variazione"
//			into :ll_id_variazione
//			from "variazione", "listino"
//			where("listino"."lis_base"='S') and ("listino"."tipo"='A')
//			and("variazione"."id_listino"="listino"."id_listino")
//			and(("variazione"."data_fine" >= today()) or ("variazione"."data_fine" is null))
//			and "variazione"."data_inizio" <= today();
//				
//			if sqlca.sqlcode<>0 then
//				messagebox('Errore!','Sembra che non esista una variazione valida per il listino base!(BAA)',StopSign!)
//				return
//			end if
//			
//			select "unita_confezione"."id_unita_confezione"
//			into :ll_id_u_conf
//			from "unita_confezione"
//			where("unita_confezione"."id_articolo"=:ll_id_articolo)
//			and("unita_confezione"."unita_base"='S');
//			
//			insert into "prezzo"("id_unita_confezione", "id_variazione", "prezzo")
//			values (:ll_id_u_conf, :ll_id_variazione, :ld_prezzo);
//			if sqlca.sqlnrows<1 then messagebox('Errore!','Impossibile aggiornare il listino base!',StopSign!)
//		end if
//	end if
//				
else
	messagebox("Alert","Qualcosa è andato storto. wf_aggiungi_prezzo_a listino")
end if

end subroutine

public subroutine uf_prezzo_calo_fornitore (decimal ad_prezzo, decimal ad_c_calo, long al_id_uc, long al_id_sog_comm, string as_tipo_um);long ll_id_listino, ll_id_variazione

select id_listino
into :ll_id_listino
from sog_commerciale
where id_sog_commerciale=:al_id_sog_comm;

if ll_id_listino>0 then
	select id_variazione
	into :ll_id_variazione
	from variazione
	where id_listino=:ll_id_listino
	and data_inizio<=today()
	and (data_fine>=today() or data_fine is null);
	if ll_id_variazione>0 then
		if as_tipo_um = 'P' then
			update "prezzo", "listino", "variazione" 
			set "prezzo"."prezzo_manifattura" = :ad_prezzo ,"prezzo"."coef_calo" = :ad_c_calo
			where ("variazione"."id_variazione"="prezzo"."id_variazione")
			and("listino"."id_listino"="variazione"."id_listino")
			and  ("prezzo"."id_unita_confezione"= :al_id_uc)
			and  ("variazione"."id_variazione"=:ll_id_variazione);
		else
			update "prezzo", "listino", "variazione" 
			set "prezzo"."prezzo" = :ad_prezzo ,"prezzo"."coef_calo" = :ad_c_calo
			where ("variazione"."id_variazione"="prezzo"."id_variazione")
			and("listino"."id_listino"="variazione"."id_listino")
			and  ("prezzo"."id_unita_confezione"= :al_id_uc)
			and  ("variazione"."id_variazione"=:ll_id_variazione);
		end if
		
		if sqlca.sqlnrows>0  then
			commit;
		else
			rollback;
			if as_tipo_um = 'P' then			
				
				insert into "prezzo"("id_unita_confezione", "id_variazione", "prezzo_manifattura", "coef_calo")
				values (:al_id_uc, :ll_id_variazione, :ad_prezzo, :ad_c_calo);
			else
				insert into "prezzo"("id_unita_confezione", "id_variazione", "prezzo", "coef_calo")
				values (:al_id_uc, :ll_id_variazione, :ad_prezzo, :ad_c_calo);
			end if
			if sqlca.sqlcode=0 then
				commit;
			else
				messagebox("Errore!", "Listino fornitore non salvato!")
				rollback;
			end if
		end if		
	end if
end if

end subroutine

on uo_aggiungi_prezzo_a_listino.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_aggiungi_prezzo_a_listino.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

