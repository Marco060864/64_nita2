forward
global type uo_chiusura_apertura from nonvisualobject
end type
end forward

global type uo_chiusura_apertura from nonvisualobject
end type
global uo_chiusura_apertura uo_chiusura_apertura

type variables
long il_filtro
end variables

forward prototypes
public subroutine of_conti_ce (long ll_prof, date ld_data, long ll_esercizio, long ll_conto_utile, long ll_conto_perdite, string tipo)
public subroutine of_conti_sp (long ll_prof, date ld_data, long ll_esercizio, long ll_conto_utile, long ll_conto_perdite, string tipo)
public subroutine of_conti_ce_parziali (string data_da, string data_a, long id_esercizio)
public subroutine of_conti_sp_parziali (string data_da, string data_a, long id_esercizio)
public subroutine of_cambia_rif ()
public subroutine of_conti_cee_ce (string data_da, string data_a, long id_es, integer anno, integer n_anno)
public subroutine of_conti_cee_ce_chiuso (string data_da, string data_a, integer anno, integer id_reg, integer n_anno)
public subroutine of_conti_cee_sp (string data_da, string data_a, long id_es, integer anno, integer n_anno)
public subroutine of_conti_cee_sp_chiuso (string data_da, string data_a, long id_reg, integer anno, integer n_anno)
public subroutine of_calcola_saldi ()
public subroutine of_conti_ce_chiusura_1 (long ll_id_reg_pd, date ld_data_inizio, date ld_data_fine)
public subroutine of_conti_sp_chiusura_1 (long ll_id_reg_pd, date ld_data_inizio, date ld_data_fine)
public subroutine of_conti_sp_parziali_ch (string data_da, string data_a, long id_esercizio, integer num_reg1, integer num_reg2)
public subroutine of_conti_ce_parziali_ch (string data_da, string data_a, long id_esercizio, integer num_reg1, integer num_reg2)
public subroutine of_registrazione_chiusura (long ll_prof, long ll_reg, date ld_data, date ld_data_competenza)
public subroutine of_registrazione_apertura (long ll_prof, long ll_reg, date ld_data, date ld_data_competenza)
public subroutine of_conti_sp_parz (date data_da, date data_a, long id_esercizio)
public subroutine of_conti_ce_parz (date data_da, date data_a, long id_esercizio)
public subroutine of_conti_ce_parz_ch1 (date data_da, date data_a, long id_esercizio, integer num_reg1, integer num_reg2)
public subroutine of_conti_sp_parz_ch1 (date data_da, date data_a, long id_esercizio, integer num_reg1, integer num_reg2)
public subroutine of_conti_ce_parz_man (date data_da, date data_a, long id_esercizio)
public subroutine of_conti_sp_parz_man (date data_da, date data_a, long id_esercizio)
public subroutine of_conti_sp_periodo (date data_da, date data_a, long id_esercizio)
public subroutine of_conti_sp_chiusura (date data_da, date data_a)
public subroutine of_conti_ce_chiusura (date data_da, date data_a)
end prototypes

public subroutine of_conti_ce (long ll_prof, date ld_data, long ll_esercizio, long ll_conto_utile, long ll_conto_perdite, string tipo);
long ll_id_conto
decimal ld_conto
boolean lb_flag
date ld_esercizio
declare lc_conti_sp cursor for
	SELECT "conto"."id_conto"  
	 FROM "azienda",   
			"conto",   
			"esercizio",   
			"mastro",   
			"sottomastro"  
	WHERE ( "azienda"."id_azienda" = "conto"."id_azienda" ) and  
			( "sottomastro"."id_mastro" = "mastro"."id_mastro" ) and  
			( "sottomastro"."id_sottomastro" = "conto"."id_sottomastro" ) and  
			
			( "esercizio"."id_esercizio" = :ll_esercizio ) and 
			( ( "mastro"."tipo"='C') or ("mastro"."tipo"='R') or ("mastro"."tipo"='E'));
			
select data_fine
into :ld_esercizio
from esercizio
where id_esercizio=:ll_esercizio;
			

open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into :ll_id_conto;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		
		SElECT sum(avere - dare)
		INTO :ld_conto
		FROM saldo_mensile
		WHERE id_conto = :ll_id_conto and id_esercizio=:ll_esercizio; 
		
		if ld_conto<0 then lb_flag=false
		
		ld_conto=abs(ld_conto)
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_dare,id_prof_registrazione,data,tipo)
				values (:ll_id_conto,:ld_conto,:ll_prof,:ld_data,'E');
			else
				insert into  chiusura_apertura  (id_conto,saldo_avere,id_prof_registrazione,data,tipo)
				values (:ll_id_conto,:ld_conto,:ll_prof,:ld_data,'E');
			end if
		end if
	end if
loop
close lc_conti_sp;
if tipo='CA' then
	decimal ld_sum												
	select isnull(sum("chiusura_apertura"."saldo_avere"),0,sum("chiusura_apertura"."saldo_avere")) &
	      - isnull(sum("chiusura_apertura"."saldo_dare"),0,sum("chiusura_apertura"."saldo_dare"))
	into :ld_sum
	from "chiusura_apertura"
	where "chiusura_apertura"."tipo"='E';
	if ld_sum>0 then
		insert into  chiusura_apertura  (id_conto,saldo_dare,id_prof_registrazione,data,tipo)
		values (:ll_conto_utile,:ld_sum,:ll_prof,:ld_data,'E');
	else
		ld_sum=ld_sum * -1
		insert into  chiusura_apertura  (id_conto,saldo_avere,id_prof_registrazione,data,tipo)
		values (:ll_conto_perdite,:ld_sum,:ll_prof,:ld_data,'E');
	end if
end if
end subroutine

public subroutine of_conti_sp (long ll_prof, date ld_data, long ll_esercizio, long ll_conto_utile, long ll_conto_perdite, string tipo);

long ll_id_conto, a
decimal ld_conto
boolean lb_flag
date ld_esercizio
declare lc_conti_sp cursor for
	SELECT "conto"."id_conto"  
	 FROM "azienda",   
			"conto",   
			"esercizio",   
			"mastro",   
			"sottomastro"  
	WHERE ( "azienda"."id_azienda" = "conto"."id_azienda" ) and  
			( "sottomastro"."id_mastro" = "mastro"."id_mastro" ) and  
			( "sottomastro"."id_sottomastro" = "conto"."id_sottomastro" ) and
			( "esercizio"."id_esercizio" = :ll_esercizio ) and  
		
			( ( "mastro"."tipo"='T') or ("mastro"."tipo"='A') or ("mastro"."tipo"='P'));
			
select data_fine
into :ld_esercizio
from esercizio
where id_esercizio=:ll_esercizio;
			

open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into :ll_id_conto;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		
		SElECT sum(avere - dare)			
		INTO :ld_conto
		FROM saldo_mensile 
		WHERE id_conto = :ll_id_conto and id_esercizio=:ll_esercizio; 
		
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_dare,id_prof_registrazione,data,tipo)
				values (:ll_id_conto,:ld_conto,:ll_prof,:ld_data,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_avere,id_prof_registrazione,data,tipo)
				values (:ll_id_conto,:ld_conto,:ll_prof,:ld_data,'P');
			end if
		end if
	end if
loop
close lc_conti_sp;
commit;
if tipo='CA' then
	decimal ld_sum
select isnull(sum("chiusura_apertura"."saldo_avere"),0,sum("chiusura_apertura"."saldo_avere")) &
	      - isnull(sum("chiusura_apertura"."saldo_dare"),0,sum("chiusura_apertura"."saldo_dare"))
	into :ld_sum
	from "chiusura_apertura"
	where "chiusura_apertura"."tipo"='P';
	if ld_sum>0 then
		insert into  chiusura_apertura(id_conto,saldo_dare,id_prof_registrazione,data,tipo)
		values (:ll_conto_perdite,:ld_sum,:ll_prof,:ld_data,'P');
	else
		ld_sum=ld_sum * -1
		insert into  chiusura_apertura(id_conto,saldo_avere,id_prof_registrazione,data,tipo)
		values (:ll_conto_utile,:ld_sum,:ll_prof,:ld_data,'P');
	end if
	if sqlca.sqlcode=0 then
		commit;
	else
		messagebox("Errore!", "Utile/perdita non inserito!")
		rollback;
	end if
end if	

end subroutine

public subroutine of_conti_ce_parziali (string data_da, string data_a, long id_esercizio);
long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
declare lc_conti_ce cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
   AND (dateformat(R.DATA_competenza,'yy/mm/dd') >=:data_da) AND (dateformat(R.DATA_competenza,'yy/mm/dd') <=  :data_a )
	 and r.id_registro = t.id_registro
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='C') or (mm.tipo='R') or (mm.tipo='E'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_ce;
do while sqlca.sqlcode=0
	fetch lc_conti_ce into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0			
			ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			end if
		end if
	end if

loop
close lc_conti_ce;

end subroutine

public subroutine of_conti_sp_parziali (string data_da, string data_a, long id_esercizio);
long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
declare lc_conti_sp cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 AND (dateformat(R.DATA_competenza,'yy/mm/dd') >=:data_da) AND (dateformat(R.DATA_competenza,'yy/mm/dd') <=  :data_a )
	 and r.id_registro = t.id_registro
	
	 
	 
	 
	 
	 and ( ( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			end if
		end if
	end if
loop
close lc_conti_sp;
end subroutine

public subroutine of_cambia_rif ();long ll_rif,ll_id_bil
 DECLARE rif CURSOR FOR  
  SELECT "bilancio_cee"."riferimento" ,
		   "chiusura_apertura"."id_bil_cee"
    FROM "bilancio_cee",   
         "chiusura_apertura"  
   WHERE ( "bilancio_cee"."id_bilancio_cee" = "chiusura_apertura"."id_bil_cee" )   ;
open rif;
do while sqlca.sqlcode=0 
	fetch rif into :ll_rif,:ll_id_bil;
	if sqlca.sqlcode=0 then
		CHOOSE CASE ll_rif
			CASE 168
				update chiusura_apertura set id_bil_cee=124
				where id_bil_cee=:ll_id_bil
				and (segno1='A'or segno1='N');
			CASE 176	
				update chiusura_apertura set id_bil_cee=128
				where id_bil_cee=:ll_id_bil
				and (segno1='A' or segno1='N');
			CASE 163
				update chiusura_apertura set id_bil_cee=138
				where id_bil_cee=:ll_id_bil
				and (segno1='A' or segno1='N');
			CASE 179
				update chiusura_apertura set id_bil_cee=139
				where id_bil_cee=:ll_id_bil
				and (egno1='A' or segno1='N');
			CASE 138	
				update chiusura_apertura set id_bil_cee=163
				where id_bil_cee=:ll_id_bil
				and (egno1='D' or segno1='N');
		END CHOOSE
 
	end if
loop
close rif;
		
		
 DECLARE rif2 CURSOR FOR  
  SELECT "bilancio_cee"."riferimento" ,
		   "chiusura_apertura"."id_bil_cee2"
    FROM "bilancio_cee",   
         "chiusura_apertura"  
   WHERE ( "bilancio_cee"."id_bilancio_cee" = "chiusura_apertura"."id_bil_cee2" )   ;
open rif2;
do while sqlca.sqlcode=0 
	fetch rif2 into :ll_rif,:ll_id_bil;
	if sqlca.sqlcode=0 then
		CHOOSE CASE ll_rif
			CASE 168
				update chiusura_apertura set id_bil_cee=124
				where id_bil_cee2=:ll_id_bil
				and (segno1='A'or segno1='N');
			CASE 176	
				update chiusura_apertura set id_bil_cee=128
				where id_bil_cee2=:ll_id_bil
				and (segno1='A' or segno1='N');
			CASE 163
				update chiusura_apertura set id_bil_cee=138
				where id_bil_cee2=:ll_id_bil
				and (segno1='A' or segno1='N');
			CASE 179
				update chiusura_apertura set id_bil_cee=139
				where id_bil_cee2=:ll_id_bil
				and (egno1='A' or segno1='N');
			CASE 138	
				update chiusura_apertura set id_bil_cee=163
				where id_bil_cee2=:ll_id_bil
				and (egno1='D' or segno1='N');
		END CHOOSE
 
	end if
loop
close rif2;		
		
		
	
end subroutine

public subroutine of_conti_cee_ce (string data_da, string data_a, long id_es, integer anno, integer n_anno);
long ll_id_conto,ll_id_bil_cee
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
string ls_anno
ls_anno=Right(string(anno),2)
data_da=Replace ( data_da, 1, 2, ls_anno ) 
data_a=Replace ( data_a, 1, 2, ls_anno )
declare lc_conti_cee_ce cursor for
	select c.id_conto,
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
    AND (dateformat(R.DATA_REGISTRAZIONE,'yy/mm/dd') >=:data_da) AND (dateformat(R.DATA_REGISTRAZIONE,'yy/mm/dd') <=  :data_a )
	 and r.id_registro = t.id_registro
	 and c.id_bilancio_cee is not null
	
	 
	 
	 
	 
	 and ( ( mm.tipo='C') or (mm.tipo='R') or (mm.tipo='E'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;

if n_anno=1 then
	open lc_conti_cee_ce;
	do while sqlca.sqlcode=0
		fetch lc_conti_cee_ce into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			select id_bilancio_cee
			into:ll_id_bil_cee
			from conto
			where id_conto=:ll_id_conto;
			lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0		
			ld_conto=ld_dare - ld_avere
			if ld_conto<0 then lb_flag=false
			ld_conto=abs(ld_conto)
			if ld_conto<>0 then
				if lb_flag=false then
					update chiusura_apertura set saldo1=:ld_conto,tipo='E',segno1='D',anno1=:anno,id_bil_cee=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
						values (:ll_id_conto,:ld_conto,'E','D',:anno,:ll_id_bil_cee);
					end if
				else
					update chiusura_apertura set saldo1=:ld_conto,tipo='E',segno1='A',anno1=:anno,id_bil_cee=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
						values (:ll_id_conto,:ld_conto,'E','A',:anno,:ll_id_bil_cee);
					end if
				end if
			else
				update chiusura_apertura set saldo1=0,tipo='E',segno1='N',anno1=:anno,id_bil_cee=:ll_id_bil_cee
				where id_conto=:ll_id_conto;
				if sqlca.SQLNRows=0 then
					insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
					values (:ll_id_conto,0,'E','N',:anno,:ll_id_bil_cee);
				end if
			end if
		end if
	
	loop
	close lc_conti_cee_ce;
else
	open lc_conti_cee_ce;
	do while sqlca.sqlcode=0
		fetch lc_conti_cee_ce into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			select id_bilancio_cee
			into:ll_id_bil_cee
			from conto
			where id_conto=:ll_id_conto;
			lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0		
			ld_conto=ld_dare - ld_avere
			if ld_conto<0 then lb_flag=false
			ld_conto=abs(ld_conto)
			if ld_conto<>0 then
				if lb_flag=false then
					update chiusura_apertura set saldo2=:ld_conto,tipo='E',segno2='D',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
						values (:ll_id_conto,:ld_conto,'E','D',:anno,:ll_id_bil_cee);
					end if
				else
					update chiusura_apertura set saldo2=:ld_conto,tipo='E',segno2='A',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
						values (:ll_id_conto,:ld_conto,'E','A',:anno,:ll_id_bil_cee);
					end if
				end if
			else
				update chiusura_apertura set saldo2=0,tipo='E',segno2='N',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
				where id_conto=:ll_id_conto;
				if sqlca.SQLNRows=0 then
					insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
					values (:ll_id_conto,0,'E','N',:anno,:ll_id_bil_cee);
				end if
			end if
		end if
	
	loop
	close lc_conti_cee_ce;
	
end if
end subroutine

public subroutine of_conti_cee_ce_chiuso (string data_da, string data_a, integer anno, integer id_reg, integer n_anno);
long ll_id_conto,ll_id_bil_cee
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
string ls_anno
ls_anno=Right(string(anno),2)
data_da=Replace ( data_da, 1, 2, ls_anno ) 
data_a=Replace ( data_a, 1, 2, ls_anno )
declare lc_conti_cee_ce cursor for
	select c.id_conto,
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = :id_reg
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 and c.id_bilancio_cee is not null
	 and ( ( mm.tipo='C') or (mm.tipo='R') or (mm.tipo='E'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
if n_anno=1 then
	open lc_conti_cee_ce;
	do while sqlca.sqlcode=0
		fetch lc_conti_cee_ce into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			select id_bilancio_cee
			into:ll_id_bil_cee
			from conto
			where id_conto=:ll_id_conto;
			lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0		
			ld_conto=ld_dare - ld_avere
			if ld_conto<0 then lb_flag=false
			ld_conto=abs(ld_conto)
			if ld_conto<>0 then
				if lb_flag=false then
					update chiusura_apertura set saldo1=:ld_conto,tipo='E',segno1='A',anno1=:anno,id_bil_cee=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
						values (:ll_id_conto,:ld_conto,'E','A',:anno,:ll_id_bil_cee);
					end if
				else
					update chiusura_apertura set saldo1=:ld_conto,tipo='E',segno1='D',anno1=:anno,id_bil_cee=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
						values (:ll_id_conto,:ld_conto,'E','D',:anno,:ll_id_bil_cee);
					end if
				end if
			else
				update chiusura_apertura set saldo1=0,tipo='E',segno1='N',anno1=:anno,id_bil_cee=:ll_id_bil_cee
				where id_conto=:ll_id_conto;
				if sqlca.SQLNRows=0 then
					insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
					values (:ll_id_conto,0,'E','N',:anno,:ll_id_bil_cee);
				end if
			end if
		end if
	
	loop
	close lc_conti_cee_ce;
	

else
	open lc_conti_cee_ce;
	do while sqlca.sqlcode=0
		fetch lc_conti_cee_ce into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			select id_bilancio_cee
			into:ll_id_bil_cee
			from conto
			where id_conto=:ll_id_conto;
			lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0		
			ld_conto=ld_dare - ld_avere
			if ld_conto<0 then lb_flag=false
			ld_conto=abs(ld_conto)
			if ld_conto<>0 then
				if lb_flag=false then
					update chiusura_apertura set saldo2=:ld_conto,tipo='E',segno2='A',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
						values (:ll_id_conto,:ld_conto,'E','A',:anno,:ll_id_bil_cee);
					end if
				else
					update chiusura_apertura set saldo2=:ld_conto,tipo='E',segno2='D',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
						values (:ll_id_conto,:ld_conto,'E','D',:anno,:ll_id_bil_cee);
					end if
				end if
			else
				update chiusura_apertura set saldo2=0,tipo='E',segno2='N',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
				where id_conto=:ll_id_conto;
				if sqlca.SQLNRows=0 then
					insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
					values (:ll_id_conto,0,'E','N',:anno,:ll_id_bil_cee);
				end if
			end if
		end if
	
	loop
	close lc_conti_cee_ce;
	
end if
end subroutine

public subroutine of_conti_cee_sp (string data_da, string data_a, long id_es, integer anno, integer n_anno);
long ll_id_conto,ll_id_bil_cee
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
string ls_anno
ls_anno=Right(string(anno),2)
data_da=Replace ( data_da, 1, 2, ls_anno ) 
data_a=Replace ( data_a, 1, 2, ls_anno )
declare lc_conti_cee_ce cursor for
	select c.id_conto,
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
    AND (dateformat(R.DATA_REGISTRAZIONE,'yy/mm/dd') >=:data_da) AND (dateformat(R.DATA_REGISTRAZIONE,'yy/mm/dd') <=  :data_a )
	 and r.id_registro = t.id_registro
	 and c.id_bilancio_cee is not null
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
if n_anno=1 then
	open lc_conti_cee_ce;
	do while sqlca.sqlcode=0
		fetch lc_conti_cee_ce into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			select id_bilancio_cee
			into:ll_id_bil_cee
			from conto
			where id_conto=:ll_id_conto;
			lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0		
			ld_conto=ld_dare - ld_avere
			if ld_conto<0 then lb_flag=false
			ld_conto=abs(ld_conto)
			if ld_conto<>0 then
				if lb_flag=false then
					update chiusura_apertura set saldo1=:ld_conto,tipo='P',segno1='A',anno1=:anno,id_bil_cee=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
						values (:ll_id_conto,:ld_conto,'P','A',:anno,:ll_id_bil_cee);
					end if
				else
					update chiusura_apertura set saldo1=:ld_conto,tipo='P',segno1='D',anno1=:anno,id_bil_cee=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
						values (:ll_id_conto,:ld_conto,'P','D',:anno,:ll_id_bil_cee);
					end if
				end if
			else
				update chiusura_apertura set saldo1=0,tipo='P',segno1='N',anno1=:anno,id_bil_cee=:ll_id_bil_cee
				where id_conto=:ll_id_conto;
				if sqlca.SQLNRows=0 then
					insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
					values (:ll_id_conto,0,'P','N',:anno,:ll_id_bil_cee);
				end if
			end if
	
		end if
	
	loop
	close lc_conti_cee_ce;
	

else
	open lc_conti_cee_ce;
	do while sqlca.sqlcode=0
		fetch lc_conti_cee_ce into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			select id_bilancio_cee
			into:ll_id_bil_cee
			from conto
			where id_conto=:ll_id_conto;
			lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0		
			ld_conto=ld_dare - ld_avere
			if ld_conto<0 then lb_flag=false
			ld_conto=abs(ld_conto)
			if ld_conto<>0 then
				if lb_flag=false then
					update chiusura_apertura set saldo2=:ld_conto,tipo='P',segno2='A',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
						values (:ll_id_conto,:ld_conto,'P','A',:anno,:ll_id_bil_cee);
					end if
				else
					update chiusura_apertura set saldo2=:ld_conto,tipo='P',segno2='D',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
						values (:ll_id_conto,:ld_conto,'P','D',:anno,:ll_id_bil_cee);
					end if
				end if
			else
				update chiusura_apertura set saldo2=0,tipo='P',segno2='N',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
				where id_conto=:ll_id_conto;
				if sqlca.SQLNRows=0 then
					insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
					values (:ll_id_conto,0,'P','N',:anno,:ll_id_bil_cee);
				end if
			end if
	
		end if
	
	loop
	close lc_conti_cee_ce;
	
end if
end subroutine

public subroutine of_conti_cee_sp_chiuso (string data_da, string data_a, long id_reg, integer anno, integer n_anno);
long ll_id_conto,ll_id_bil_cee
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
string ls_anno
ls_anno=Right(string(anno),2)
data_da=Replace ( data_da, 1, 2, ls_anno ) 
data_a=Replace ( data_a, 1, 2, ls_anno )
declare lc_conti_cee_ce cursor for
	select c.id_conto,
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = :id_reg
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 and c.id_bilancio_cee is not null
	 and ( ( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
if n_anno=1 then
	open lc_conti_cee_ce;
	do while sqlca.sqlcode=0
		fetch lc_conti_cee_ce into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			select id_bilancio_cee
			into:ll_id_bil_cee
			from conto
			where id_conto=:ll_id_conto;
			lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0		
			ld_conto=ld_dare - ld_avere
			if ld_conto<0 then lb_flag=false
			ld_conto=abs(ld_conto)
			if ld_conto<>0 then
				if lb_flag=false then
					update chiusura_apertura set saldo1=:ld_conto,tipo='P',segno1='D',anno1=:anno,id_bil_cee=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
						values (:ll_id_conto,:ld_conto,'P','D',:anno,:ll_id_bil_cee);
					end if
				else
					update chiusura_apertura set saldo1=:ld_conto,tipo='P',segno1='A',anno1=:anno,id_bil_cee=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
						values (:ll_id_conto,:ld_conto,'P','A',:anno,:ll_id_bil_cee);
					end if
				end if
			else
				update chiusura_apertura set saldo1=0,tipo='P',segno1='N',anno1=:anno,id_bil_cee=:ll_id_bil_cee
				where id_conto=:ll_id_conto;
				if sqlca.SQLNRows=0 then
					insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
					values (:ll_id_conto,0,'P','N',:anno,:ll_id_bil_cee);
				end if
			end if
	
		end if
	
	loop
	close lc_conti_cee_ce;
else	 
	open lc_conti_cee_ce;
	do while sqlca.sqlcode=0
		fetch lc_conti_cee_ce into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			select id_bilancio_cee
			into:ll_id_bil_cee
			from conto
			where id_conto=:ll_id_conto;
			lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0		
			ld_conto=ld_dare - ld_avere
			if ld_conto<0 then lb_flag=false
			ld_conto=abs(ld_conto)
			if ld_conto<>0 then
				if lb_flag=false then
					update chiusura_apertura set saldo2=:ld_conto,tipo='P',segno2='D',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
						values (:ll_id_conto,:ld_conto,'P','D',:anno,:ll_id_bil_cee);
					end if
				else
					update chiusura_apertura set saldo2=:ld_conto,tipo='P',segno2='A',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
						values (:ll_id_conto,:ld_conto,'P','A',:anno,:ll_id_bil_cee);
					end if
				end if
			else
				update chiusura_apertura set saldo2=0,tipo='P',segno2='N',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
				where id_conto=:ll_id_conto;
				if sqlca.SQLNRows=0 then
					insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
					values (:ll_id_conto,0,'P','N',:anno,:ll_id_bil_cee);
				end if
			end if
	
		end if
	
	loop
	close lc_conti_cee_ce;
	
end if
end subroutine

public subroutine of_calcola_saldi ();long ll_id_bil_cce,ll_rif
decimal ld_dare,ld_avere,ld_saldo
declare calcola_saldi cursor for
	select id_bil_cee
   from chiusura_apertura
	where  id_bil_cee<>0
	group by id_bil_cee
	order by id_bil_cee;
open calcola_saldi;
do while sqlca.sqlcode=0 
	fetch calcola_saldi into :ll_id_bil_cce;
	if sqlca.sqlcode=0 then
		select riferimento
		into :ll_rif
		from bilancio_cee
		where id_bilancio_cee=:ll_id_bil_cce;
		
		select CAST (SUM (saldo1) AS decimal)  avere
		into :ld_avere
    	from chiusura_apertura
    	where segno1='A'
		and id_bil_cee=:ll_id_bil_cce;
		select CAST (SUM (saldo1) AS decimal)  dare
		into :ld_dare
    	from chiusura_apertura
    	where segno1='D'
		and id_bil_cee=:ll_id_bil_cce;
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_saldo=ld_dare - ld_avere
		if (ll_rif=188) or (ll_rif=25) or (ll_rif=26) or (ll_rif=137) or (ll_rif=138) then
			ld_saldo=ld_saldo * (-1)
		elseif (ld_saldo<0) and (ll_rif<>37) and (ll_rif<>41) then
				ld_saldo=ld_saldo * (-1)
		end if
		update bilancio_cee set saldo1=:ld_saldo where id_bilancio_cee=:ll_id_bil_cce;
	end if
loop
close calcola_saldi;

declare calcola_saldi2 cursor for
	select id_bil_cee2
    from chiusura_apertura
	 where  id_bil_cee<>0
	 group by id_bil_cee2
	 order by id_bil_cee2;
open calcola_saldi2;
do while sqlca.sqlcode=0 
	fetch calcola_saldi2 into :ll_id_bil_cce;
	if sqlca.sqlcode=0 then
		select riferimento
		into :ll_rif
		from bilancio_cee
		where id_bilancio_cee=:ll_id_bil_cce;
		select CAST (SUM (saldo2) AS decimal)  dare
		into :ld_dare
    	from chiusura_apertura
    	where segno2='D'
		and id_bil_cee2=:ll_id_bil_cce;
		select CAST (SUM (saldo2) AS decimal)  avere
		into :ld_avere
    	from chiusura_apertura
    	where segno2='A'
		and id_bil_cee2=:ll_id_bil_cce;
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_saldo=ld_dare - ld_avere
		if (ll_rif=188) or (ll_rif=25) or (ll_rif=26) or (ll_rif=137) or (ll_rif=138) then
			ld_saldo=ld_saldo * (-1)
		elseif (ld_saldo<0) and (ll_rif<>37) and (ll_rif<>41) then
				ld_saldo=ld_saldo * (-1)
		end if
		update bilancio_cee set saldo2=:ld_saldo where id_bilancio_cee=:ll_id_bil_cce;
	end if
loop
close calcola_saldi2;
end subroutine

public subroutine of_conti_ce_chiusura_1 (long ll_id_reg_pd, date ld_data_inizio, date ld_data_fine);

long ll_id_conto
decimal ld_conto,ld_conto2
boolean lb_flag

long ll_id_conto_utile_sp,ll_id_conto_utile_ce,ll_id_conto_perdite_sp,ll_id_conto_perdite_ce
select id_conto_utile_sp,id_conto_utile_ce,id_conto_perdite_sp,id_conto_perdite_ce
into :ll_id_conto_utile_sp,:ll_id_conto_utile_ce,:ll_id_conto_perdite_sp,:ll_id_conto_perdite_ce
from par_sistema;
declare lc_conti_ce cursor for
	  SELECT "mov_contabile"."id_conto",   
         "mov_contabile"."dare",   
         "mov_contabile"."avere"  
    FROM "conto",   
         "mastro",   
         "mov_contabile",   
         "sottomastro"
   WHERE ( "mov_contabile"."id_conto" = "conto"."id_conto" ) and  
         ( "sottomastro"."id_mastro" = "mastro"."id_mastro" ) and  
         ( "sottomastro"."id_sottomastro" = "conto"."id_sottomastro" ) and  
         ( ( "mov_contabile"."id_reg_pd" = :ll_id_reg_pd ) )  and 
			( ( "mastro"."tipo"='C') or ("mastro"."tipo"='R') or ("mastro"."tipo"='E')) and
			(("mov_contabile"."id_conto"<>:ll_id_conto_utile_sp)and
			 ("mov_contabile"."id_conto"<>:ll_id_conto_utile_ce)and
			 ("mov_contabile"."id_conto"<>:ll_id_conto_perdite_sp)and
			 ("mov_contabile"."id_conto"<>:ll_id_conto_perdite_ce))and
			 ("mov_contabile"."data_inizio_competenza">=:ld_data_inizio)and
			 ("mov_contabile"."data_inizio_competenza"<=:ld_data_fine);

open lc_conti_ce;
do while sqlca.sqlcode=0
	fetch lc_conti_ce into  :ll_id_conto,:ld_conto,:ld_conto2 ; 
	if sqlca.sqlcode=0 then 
		
		insert into  chiusura_apertura  (id_conto,saldo_dare,saldo_avere,id_prof_registrazione,data,tipo)
		values (:ll_id_conto,:ld_conto,:ld_conto2,null,null,'E');
			
		
	end if
loop
close lc_conti_ce;

end subroutine

public subroutine of_conti_sp_chiusura_1 (long ll_id_reg_pd, date ld_data_inizio, date ld_data_fine);

long ll_id_conto
decimal ld_conto,ld_conto2
boolean lb_flag
long ll_id_conto_utile_sp,ll_id_conto_utile_ce,ll_id_conto_perdite_sp,ll_id_conto_perdite_ce
select id_conto_utile_sp,id_conto_utile_ce,id_conto_perdite_sp,id_conto_perdite_ce
into :ll_id_conto_utile_sp,:ll_id_conto_utile_ce,:ll_id_conto_perdite_sp,:ll_id_conto_perdite_ce
from par_sistema;
declare lc_conti_sp cursor for
	  SELECT "mov_contabile"."id_conto",   
         "mov_contabile"."dare",   
         "mov_contabile"."avere"
    FROM "conto",   
         "mastro",   
         "mov_contabile",   
         "sottomastro" 
   WHERE ( "mov_contabile"."id_conto" = "conto"."id_conto" ) and  
         ( "sottomastro"."id_mastro" = "mastro"."id_mastro" ) and  
         ( "sottomastro"."id_sottomastro" = "conto"."id_sottomastro" ) and  
         ( ( "mov_contabile"."id_reg_pd" = :ll_id_reg_pd ) )  and 
			( ( "mastro"."tipo"='T') or ("mastro"."tipo"='A') or ("mastro"."tipo"='P'))and
			(("mov_contabile"."id_conto"<>:ll_id_conto_utile_sp)and
			 ("mov_contabile"."id_conto"<>:ll_id_conto_utile_ce)and
			 ("mov_contabile"."id_conto"<>:ll_id_conto_perdite_sp)and
			 ("mov_contabile"."id_conto"<>:ll_id_conto_perdite_ce))and
			 ("mov_contabile"."data_inizio_competenza">=:ld_data_inizio)and
			 ("mov_contabile"."data_inizio_competenza"<=:ld_data_fine);

open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into  :ll_id_conto,:ld_conto,:ld_conto2 ; 
	if sqlca.sqlcode=0 then 
		
		insert into  chiusura_apertura  (id_conto,saldo_dare,saldo_avere,id_prof_registrazione,data,tipo)
		values (:ll_id_conto,:ld_conto,:ld_conto2,null,null,'P');
			
		
	end if
loop
close lc_conti_sp;



end subroutine

public subroutine of_conti_sp_parziali_ch (string data_da, string data_a, long id_esercizio, integer num_reg1, integer num_reg2);
long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
declare lc_conti_sp cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 AND (dateformat(R.DATA_competenza,'yy/mm/dd') >=:data_da) AND (dateformat(R.DATA_competenza,'yy/mm/dd') <=  :data_a )
	 and r.id_registro = t.id_registro
	 
	 
	 
	 
	 
	 and (( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	 and (r.id_reg_pd <> :num_reg1 and r.id_reg_pd <> :num_reg2)
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			end if
		end if
	end if
loop
close lc_conti_sp;


end subroutine

public subroutine of_conti_ce_parziali_ch (string data_da, string data_a, long id_esercizio, integer num_reg1, integer num_reg2);

long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
declare lc_conti_ce cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
   AND (dateformat(R.DATA_competenza,'yy/mm/dd') >=:data_da) AND (dateformat(R.DATA_competenza,'yy/mm/dd') <=  :data_a )
	 and r.id_registro = t.id_registro
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='C') or (mm.tipo='R') or (mm.tipo='E'))
	 and (r.id_reg_pd <> :num_reg1 and r.Id_reg_pd <> :num_reg2)
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_ce;
do while sqlca.sqlcode=0
	fetch lc_conti_ce into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0			
			ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			end if
		end if
	end if

loop
close lc_conti_ce;

end subroutine

public subroutine of_registrazione_chiusura (long ll_prof, long ll_reg, date ld_data, date ld_data_competenza);

long ll_num,ll_valuta,ll_id_reg,ll_id_conto,ll_numero,ll_somma,ll_conto
decimal ld_dare,ld_avere

select max(num_progressivo)
into :ll_num
from reg_pd
where id_registro=:ll_reg;
ll_num++
if (isnull(ll_num)) or (ll_num=0) then ll_num=1
select id_valuta
into :ll_valuta
from esercizio
where data_inizio<=:ld_data and data_fine>=:ld_data;
if sqlca.sqlcode <>0 or isnull(ll_valuta) then 
	messagebox("Errore","Nell'esercizio indicato non è stata specificata nessuna valuta")
else
	string ls_descrizione
	
	select descrizione
	into :ls_descrizione
	from prof_registrazione
	where id_prof_registrazione=:ll_prof;
	insert into reg_pd 
	
	
	(id_registro,num_progressivo,data_competenza,data_registrazione,id_valuta,id_prof_registrazione,descrizione)
	values (:ll_reg,:ll_num,:ld_data_competenza,:ld_data,:ll_valuta,:ll_prof,:ls_descrizione);
	
	
	select id_reg_pd
	into :ll_id_reg
	from reg_pd
	where id_registro=:ll_reg and
			num_progressivo=:ll_num and
			data_registrazione=:ld_data;
	if sqlca.sqlcode<>0 or isnull(ll_id_reg) then messagebox("Errore","Si è verificato un errore inserendo la testa della registrazione")
			
	declare lc_conti_sp cursor for
	SELECT "chiusura_apertura"."id_conto",   
         "chiusura_apertura"."saldo_dare",   
         "chiusura_apertura"."saldo_avere"  
    FROM "chiusura_apertura"  
	 WHERE "chiusura_apertura"."tipo"='P';

	open lc_conti_sp;
	ll_numero=1
	do while sqlca.sqlcode=0
		fetch lc_conti_sp into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			if ld_avere>0 then
				
	         
				insert into mov_contabile
				(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,des_contabile,dare)
				values(:ll_id_reg,:ll_numero,:ll_id_conto,:ll_valuta,1,:ld_data,:ld_data,:ls_descrizione,:ld_avere);
			else
				insert into mov_contabile
				(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,des_contabile,avere)
				values(:ll_id_reg,:ll_numero,:ll_id_conto,:ll_valuta,1,:ld_data,:ld_data,:ls_descrizione,:ld_dare);
			end if
			ll_numero++
		end if
	loop
	
	
	ll_num++
	insert into reg_pd 
	(id_registro,num_progressivo,data_competenza,data_registrazione,id_valuta,id_prof_registrazione,descrizione)
	values (:ll_reg,:ll_num,:ld_data_competenza,:ld_data,:ll_valuta,:ll_prof,:ls_descrizione);
	
	select id_reg_pd
	into :ll_id_reg
	from reg_pd
	where id_registro=:ll_reg and
			num_progressivo=:ll_num and
			data_registrazione=:ld_data;
			

	declare lc_conti_ce cursor for
	SELECT "chiusura_apertura"."id_conto",   
         "chiusura_apertura"."saldo_dare",   
         "chiusura_apertura"."saldo_avere"  
    FROM "chiusura_apertura"  
	 WHERE "chiusura_apertura"."tipo"='E';

	open lc_conti_ce;
	ll_numero=1
	do while sqlca.sqlcode=0
		fetch lc_conti_ce into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then 
			if ld_avere>0 then
				insert into mov_contabile
				(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,des_contabile,dare)
				values(:ll_id_reg,:ll_numero,:ll_id_conto,:ll_valuta,1,:ld_data,:ld_data,:ls_descrizione,:ld_avere);
			else
				insert into mov_contabile
				(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,des_contabile,avere)
				values(:ll_id_reg,:ll_numero,:ll_id_conto,:ll_valuta,1,:ld_data,:ld_data,:ls_descrizione,:ld_dare);
			end if
			ll_numero++
		end if
	loop
	
end if
end subroutine

public subroutine of_registrazione_apertura (long ll_prof, long ll_reg, date ld_data, date ld_data_competenza);
long ll_conto_utile_sp,ll_conto_perdite_sp
select id_conto_utile_sp,id_conto_perdite_sp
into :ll_conto_utile_sp,:ll_conto_perdite_sp
from par_sistema;

long ll_num,ll_valuta,ll_id_reg,ll_id_conto,ll_numero
decimal ld_dare,ld_avere
string ls_descrizione
select max(num_progressivo)
into :ll_num
from reg_pd
where id_registro=:ll_reg;
ll_num++
if (isnull(ll_num)) or (ll_num=0) then ll_num=1


select descrizione
into  :ls_descrizione
from prof_registrazione
where id_prof_registrazione=:ll_prof;
select id_valuta
into :ll_valuta
from esercizio
where data_inizio<=:ld_data and data_fine>=:ld_data;
if sqlca.sqlcode <>0 or isnull(ll_valuta) then 
	messagebox("Errore","Nel profilo indicato non è stata specificata nessuna valuta")
else
	
	
   insert into reg_pd 
	
	
	(id_registro,num_progressivo,data_competenza,data_registrazione,id_valuta,id_prof_registrazione,descrizione)
	values (:ll_reg,:ll_num,:ld_data_competenza,:ld_data,:ll_valuta,:ll_prof,:ls_descrizione);
	
	
	select id_reg_pd
	into :ll_id_reg
	from reg_pd
	where id_registro=:ll_reg and
			num_progressivo=:ll_num and
			data_registrazione=:ld_data;
	if sqlca.sqlcode<>0 then messagebox("Errore","Si è verificato un errore inserendo la testa della registrazione")
			
	declare lc_conti_sp cursor for
	SELECT "chiusura_apertura"."id_conto",   
         "chiusura_apertura"."saldo_dare",   
         "chiusura_apertura"."saldo_avere"  
    FROM "chiusura_apertura"  
	 WHERE "chiusura_apertura"."tipo"='P';

	open lc_conti_sp;
	ll_numero=1
	do while sqlca.sqlcode=0
		fetch lc_conti_sp into :ll_id_conto,:ld_dare,:ld_avere;
		if sqlca.sqlcode=0 then
				if ld_avere>0 then
					insert into mov_contabile
					(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,des_contabile,avere)
					values(:ll_id_reg,:ll_numero,:ll_id_conto,:ll_valuta,1,:ld_data,:ld_data,:ls_descrizione,:ld_avere);
				else
					insert into mov_contabile
					(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,des_contabile,dare)
					values(:ll_id_reg,:ll_numero,:ll_id_conto,:ll_valuta,1,:ld_data,:ld_data,:ls_descrizione,:ld_dare);
				end if
			ll_numero++
		end if
	loop
	
			
			
end if
end subroutine

public subroutine of_conti_sp_parz (date data_da, date data_a, long id_esercizio);
long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
declare lc_conti_sp cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 AND (R.DATA_competenza >=:data_da) AND (R.DATA_competenza <=  :data_a )
	 and r.id_registro = t.id_registro
	 and t.tipo_registro <> 'MN'
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			end if
		end if
	end if
loop
close lc_conti_sp;
end subroutine

public subroutine of_conti_ce_parz (date data_da, date data_a, long id_esercizio);
long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
declare lc_conti_ce cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 
	
   AND (R.DATA_competenza >=:data_da) AND (R.DATA_competenza <=  :data_a )
	
	 and r.id_registro = t.id_registro
	 and t.tipo_registro <> 'MN'
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='C') or (mm.tipo='R') or (mm.tipo='E'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_ce;
do while sqlca.sqlcode=0
	fetch lc_conti_ce into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0			
			ld_conto=ld_dare - ld_avere
		if ld_conto<0 then 
			lb_flag=false
			ld_conto=ld_conto* -1
			
		end if
			
		
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			end if
		end if
	end if

loop
close lc_conti_ce;

end subroutine

public subroutine of_conti_ce_parz_ch1 (date data_da, date data_a, long id_esercizio, integer num_reg1, integer num_reg2);

long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
declare lc_conti_ce cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 AND (R.DATA_competenza >=:data_da) AND (R.DATA_competenza <=  :data_a )
    and r.id_registro = t.id_registro
	 and t.tipo_registro <> 'MN'
	
	 
	 
	 
	 
	 and ( ( mm.tipo='C') or (mm.tipo='R') or (mm.tipo='E'))
	 and (r.id_reg_pd <> :num_reg1 and r.Id_reg_pd <> :num_reg2)
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_ce;
do while sqlca.sqlcode=0
	fetch lc_conti_ce into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0			
			ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			end if
		end if
	end if

loop
close lc_conti_ce;

end subroutine

public subroutine of_conti_sp_parz_ch1 (date data_da, date data_a, long id_esercizio, integer num_reg1, integer num_reg2);
long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
declare lc_conti_sp cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
 	 
    
	 
	 AND (R.DATA_competenza >=:data_da) AND (R.DATA_competenza <=  :data_a )
	 
	 and r.id_registro = t.id_registro
	 and t.tipo_registro <> 'MN'
	 
	 
	 
	 
	 
	 and (( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	 and (r.id_reg_pd <> :num_reg1 and r.id_reg_pd <> :num_reg2)
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			end if
		end if
	end if
loop
close lc_conti_sp;


end subroutine

public subroutine of_conti_ce_parz_man (date data_da, date data_a, long id_esercizio);
long ll_id_conto
decimal ld_conto,ld_dare,ld_avere, old_avere, old_dare
boolean lb_flag
declare lc_conti_ce cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 AND (R.DATA_competenza >=:data_da) AND (R.DATA_competenza <=  :data_a )
	 and r.id_registro = t.id_registro
	 and t.tipo_registro = 'MN'
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='C') or (mm.tipo='R') or (mm.tipo='E'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_ce;
do while sqlca.sqlcode=0
	fetch lc_conti_ce into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere

		select saldo_dare, saldo_avere
		into :old_dare, :old_avere
		from chiusura_apertura
		where id_conto=:ll_id_conto;
		if sqlca.sqlcode=0 then 
		   lb_flag=true
		   if isnull(old_dare) then old_dare=0
		   if isnull(old_avere) then old_avere=0		
		   ld_conto=ld_conto + old_dare -old_avere
			if ld_conto=0 then 
				update chiusura_apertura 
				set saldo_avere=:ld_conto, saldo_dare=:ld_conto
				where id_conto=:ll_id_conto;
			end if
			if ld_conto<0 then 
				ld_conto=abs(ld_conto)
				update chiusura_apertura set saldo_avere=:ld_conto, saldo_dare=0 where id_conto=:ll_id_conto;
			else	
				update chiusura_apertura set saldo_dare=:ld_conto, saldo_avere=0 where id_conto=:ll_id_conto;
			end if	
	   else
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			end if
		end if
	   end if
	end if

loop
close lc_conti_ce;

end subroutine

public subroutine of_conti_sp_parz_man (date data_da, date data_a, long id_esercizio);
long ll_id_conto
decimal ld_conto,ld_dare,ld_avere, old_avere, old_dare
boolean lb_flag
declare lc_conti_sp cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 
 	 
	 
	 AND (R.DATA_competenza >=:data_da) AND (R.DATA_competenza <=  :data_a )
	 
	 and r.id_registro = t.id_registro
	 and t.tipo_registro = 'MN'
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere

		select saldo_dare, saldo_avere
		into :old_dare, :old_avere
		from chiusura_apertura
		where id_conto=:ll_id_conto;
		if sqlca.sqlcode=0 then 
		   lb_flag=true
		   if isnull(old_dare) then old_dare=0
		   if isnull(old_avere) then old_avere=0		
		   ld_conto=ld_conto + old_dare -old_avere
			if ld_conto=0 then 
				update chiusura_apertura 
				set saldo_avere=:ld_conto, saldo_dare=:ld_conto
				where id_conto=:ll_id_conto;
			end if
			if ld_conto<0 then 
				ld_conto=abs(ld_conto)
				update chiusura_apertura 
				set saldo_avere=:ld_conto, saldo_dare=0
				where id_conto=:ll_id_conto;
			else	
				update chiusura_apertura 
				set saldo_dare=:ld_conto, saldo_avere=0
				where id_conto=:ll_id_conto;
			end if	
	   else
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			end if
		end if
	end if
	end if
loop
close lc_conti_sp;
end subroutine

public subroutine of_conti_sp_periodo (date data_da, date data_a, long id_esercizio);


long ll_id_conto, ll_prof_aper, ll_prof_chiu
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
select id_prof_reg_apertura, id_prof_reg_chiusura
into :ll_prof_aper , :ll_prof_chiu
from par_sistema;

declare lc_conti_sp cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 AND (R.DATA_competenza >=:data_da) AND (R.DATA_competenza <=  :data_a )
    and r.id_prof_registrazione<>:ll_prof_chiu  and r.id_prof_registrazione<>:ll_prof_aper
	 and r.id_registro = t.id_registro
	 and t.tipo_registro <> 'MN'
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			end if
		end if
	end if
loop
close lc_conti_sp;


end subroutine

public subroutine of_conti_sp_chiusura (date data_da, date data_a);


long ll_id_conto, ll_prof_chiu
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
select  id_prof_reg_chiusura
into :ll_prof_chiu
from par_sistema;

declare lc_conti_sp cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 AND (R.DATA_competenza >=:data_da) AND (R.DATA_competenza <=  :data_a )
    and r.id_prof_registrazione<>:ll_prof_chiu  
	 and r.id_registro = t.id_registro
	 and t.tipo_registro <> 'MN'
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_sp;
do while sqlca.sqlcode=0
	fetch lc_conti_sp into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			end if
		end if
	end if
loop
close lc_conti_sp;


end subroutine

public subroutine of_conti_ce_chiusura (date data_da, date data_a);

long ll_id_conto
decimal ld_conto,ld_dare,ld_avere
boolean lb_flag
declare lc_conti_ce cursor for
	select c.id_conto, 
			CAST (SUM (M.DARE) AS decimal)  DARE,
			CAST (SUM (M.AVERE) AS decimal)  AVERE
    from conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
    where c.id_conto = m.id_conto
	 AND M.ID_REG_PD = R.ID_REG_PD
	 and c.id_sottomastro=s.id_sottomastro
	 and s.id_mastro=mm.id_mastro	
	 
	
   AND (R.DATA_competenza >=:data_da) AND (R.DATA_competenza <=  :data_a )
	
	 and r.id_registro = t.id_registro
	 and t.tipo_registro <> 'MN'
	 
	 
	 
	 
	 
	 and ( ( mm.tipo='C') or (mm.tipo='R') or (mm.tipo='E'))
	 GROUP BY C.ID_CONTO
	 ORDER BY C.ID_CONTO;
open lc_conti_ce;
do while sqlca.sqlcode=0
	fetch lc_conti_ce into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		lb_flag=true
			if isnull(ld_dare) then ld_dare=0
			if isnull(ld_avere) then ld_avere=0			
			ld_conto=ld_dare - ld_avere
		if ld_conto<0 then 
			lb_flag=false
			ld_conto=ld_conto* -1
			
		end if
			
		
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  chiusura_apertura  (id_conto,saldo_avere,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'E');
			end if
		end if
	end if

loop
close lc_conti_ce;

end subroutine

on uo_chiusura_apertura.create
TriggerEvent( this, "constructor" )
end on

on uo_chiusura_apertura.destroy
TriggerEvent( this, "destructor" )
end on

