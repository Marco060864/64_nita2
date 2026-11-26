forward
global type uo_bilancio_cee from nonvisualobject
end type
end forward

global type uo_bilancio_cee from nonvisualobject
end type
global uo_bilancio_cee uo_bilancio_cee

type variables
long il_filtro
end variables

forward prototypes
public subroutine of_conti_ce_parz (date data_da, date data_a, integer n_anno, integer anno)
public subroutine of_conti_sp_parz (date data_da, date data_a, integer n_anno, integer anno)
public subroutine of_calcola_saldi ()
end prototypes

public subroutine of_conti_ce_parz (date data_da, date data_a, integer n_anno, integer anno);


long ll_id_conto, ll_id_bil_cee, ll_prof_aper , ll_prof_chiu, ll_id_mm, ll_id_ss
decimal {2} ld_conto,ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_apertura, id_prof_reg_chiusura
into :ll_prof_aper , :ll_prof_chiu
from par_sistema;

DECLARE lc_conti_ce CURSOR FOR
	SELECT c.id_conto, 
			 CAST (SUM (M.DARE) AS decimal)  DARE,
			 CAST (SUM (M.AVERE) AS decimal)  AVERE
   FROM conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
   WHERE c.id_conto = m.id_conto
	  and M.ID_REG_PD = R.ID_REG_PD
	  and c.id_sottomastro=s.id_sottomastro
	  and s.id_mastro=mm.id_mastro	
     and (R.DATA_competenza >=:data_da) and (R.DATA_competenza <=  :data_a )
	  and r.id_registro = t.id_registro
	  and r.id_prof_registrazione<>:ll_prof_chiu  and r.id_prof_registrazione<>:ll_prof_aper
	  and t.tipo_registro <> 'MN'
     and ((c.id_bilancio_cee is not null) or (mm.id_bilancio_cee is not null) or (s.id_bilancio_cee is not null))
	  and ( ( mm.tipo='C') or (mm.tipo='R') or (mm.tipo='E'))
	GROUP BY C.ID_CONTO
	ORDER BY C.ID_CONTO;

open lc_conti_ce;
do while sqlca.sqlcode=0
	fetch lc_conti_ce into :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		select id_bilancio_cee, id_sottomastro
		into:ll_id_bil_cee, :ll_id_ss
		from conto
		where id_conto=:ll_id_conto;
		if isnull(ll_id_bil_cee) then
		   select id_bilancio_cee, id_mastro
			into:ll_id_bil_cee, :ll_id_mm
			from sottomastro
			where id_sottomastro=:ll_id_ss;
			if isnull(ll_id_bil_cee) then
		   	select id_bilancio_cee
				into:ll_id_bil_cee
				from mastro
				where id_mastro=:ll_id_mm;
			end if
		end if
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		if n_anno=1 then	
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
		else
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
	end if
loop
close lc_conti_ce;
end subroutine

public subroutine of_conti_sp_parz (date data_da, date data_a, integer n_anno, integer anno);


long ll_id_conto, ll_id_bil_cee, ll_prof_chiu, ll_id_ss, ll_id_mm
decimal {2} ld_conto,ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_chiusura
into :ll_prof_chiu
from par_sistema;

long ll_128, ll_176, ll_179, ll_139, ll_168, ll_124, ll_163, ll_138
select id_bilancio_cee into :ll_176 from bilancio_cee where riferimento=176;
select id_bilancio_cee into :ll_128 from bilancio_cee where riferimento=128;
select id_bilancio_cee into :ll_179 from bilancio_cee where riferimento=179;
select id_bilancio_cee into :ll_168 from bilancio_cee where riferimento=168;
select id_bilancio_cee into :ll_124 from bilancio_cee where riferimento=124;
select id_bilancio_cee into :ll_163 from bilancio_cee where riferimento=163;
select id_bilancio_cee into :ll_138 from bilancio_cee where riferimento=138;
select id_bilancio_cee into :ll_139 from bilancio_cee where riferimento=139;


DECLARE lc_conti_ce CURSOR FOR
   SELECT c.id_conto,  
			 CAST (SUM (M.DARE) AS decimal)  DARE,
			 CAST (SUM (M.AVERE) AS decimal)  AVERE
   FROM conto c, mov_contabile m, reg_pd r,  REGISTRO t, mastro mm, sottomastro s
   WHERE c.id_conto = m.id_conto
	  and M.ID_REG_PD = R.ID_REG_PD
	  and c.id_sottomastro=s.id_sottomastro
	  and s.id_mastro=mm.id_mastro	
     and (R.DATA_competenza >=:data_da) and (R.DATA_competenza <=  :data_a )
	  and r.id_registro = t.id_registro
	  and r.id_prof_registrazione<>:ll_prof_chiu
	  and t.tipo_registro <> 'MN'
     and ((c.id_bilancio_cee is not null) or (mm.id_bilancio_cee is not null) or (s.id_bilancio_cee is not null))
	  and ( ( mm.tipo='T') or (mm.tipo='A') or (mm.tipo='P'))
	GROUP BY C.ID_CONTO
	ORDER BY C.ID_CONTO;

OPEN lc_conti_ce;
DO WHILE sqlca.sqlcode=0
	FETCH lc_conti_ce INTO :ll_id_conto,:ld_dare,:ld_avere;
	if sqlca.sqlcode=0 then 
		select id_bilancio_cee, id_sottomastro
		into:ll_id_bil_cee, :ll_id_ss
		from conto
		where id_conto=:ll_id_conto;
		if isnull(ll_id_bil_cee) then
		   select id_bilancio_cee, id_mastro
			into:ll_id_bil_cee, :ll_id_mm
			from sottomastro
			where id_sottomastro=:ll_id_ss;
			if isnull(ll_id_bil_cee) then
		   	select id_bilancio_cee
				into:ll_id_bil_cee
				from mastro
				where id_mastro=:ll_id_mm;
			end if
		end if	
			
		lb_flag=true
		if isnull(ld_dare) then ld_dare=0
		if isnull(ld_avere) then ld_avere=0		
		ld_conto=ld_dare - ld_avere
		if ld_conto<0 then lb_flag=false
		ld_conto=abs(ld_conto)
		if n_anno=1 then	
			if ld_conto<>0 then
				if lb_flag=false then
					if ll_id_bil_cee=ll_176 then ll_id_bil_cee=ll_128
					
					if ll_id_bil_cee=ll_179 then ll_id_bil_cee=ll_139
					if ll_id_bil_cee=ll_163 then ll_id_bil_cee=ll_138
					if ll_id_bil_cee=ll_168 then ll_id_bil_cee=ll_124
					
					update chiusura_apertura set saldo1=:ld_conto,tipo='E',segno1='D',anno1=:anno,id_bil_cee=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo1,tipo,segno1,anno1,id_bil_cee)
						values (:ll_id_conto,:ld_conto,'E','D',:anno,:ll_id_bil_cee);
					end if
				else
					
					if ll_id_bil_cee=ll_138 then ll_id_bil_cee=ll_163
					if ll_id_bil_cee=ll_124 then ll_id_bil_cee=ll_168
					
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
		else
			if ld_conto<>0 then
				if lb_flag=false then
					if ll_id_bil_cee=ll_176 then ll_id_bil_cee=ll_128
					
					if ll_id_bil_cee=ll_179 then ll_id_bil_cee=ll_139
					if ll_id_bil_cee=ll_163 then ll_id_bil_cee=ll_138
					if ll_id_bil_cee=ll_168 then ll_id_bil_cee=ll_124
					update chiusura_apertura set saldo2=:ld_conto,tipo='E',segno2='D',anno2=:anno,id_bil_cee2=:ll_id_bil_cee
					where id_conto=:ll_id_conto;
					if sqlca.SQLNRows=0 then
						insert into  chiusura_apertura  (id_conto,saldo2,tipo,segno2,anno2,id_bil_cee2)
						values (:ll_id_conto,:ld_conto,'E','D',:anno,:ll_id_bil_cee);
					end if
				else
					
					if ll_id_bil_cee=ll_138 then ll_id_bil_cee=ll_163
					if ll_id_bil_cee=ll_124 then ll_id_bil_cee=ll_168

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
	end if
LOOP
CLOSE lc_conti_ce;
end subroutine

public subroutine of_calcola_saldi ();long ll_id_bil_cce,ll_rif
decimal {2} ld_dare,ld_avere,ld_saldo




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

		if (ll_rif=188) or (ll_rif=25) or (ll_rif=26) then 
			ld_saldo=ld_saldo * (-1)
		elseif (ld_saldo<0) then 
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
		if (ll_rif=188) or (ll_rif=25) or (ll_rif=26) then 
			ld_saldo=ld_saldo * (-1)
		elseif (ld_saldo<0) then 
				ld_saldo=ld_saldo * (-1)
		end if
		update bilancio_cee set saldo2=:ld_saldo where id_bilancio_cee=:ll_id_bil_cce;
	end if
loop
close calcola_saldi2;
end subroutine

on uo_bilancio_cee.create
TriggerEvent( this, "constructor" )
end on

on uo_bilancio_cee.destroy
TriggerEvent( this, "destructor" )
end on

