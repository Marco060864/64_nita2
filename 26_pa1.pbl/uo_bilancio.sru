forward
global type uo_bilancio from nonvisualobject
end type
end forward

global type uo_bilancio from nonvisualobject
end type
global uo_bilancio uo_bilancio

type variables
long il_filtro
end variables

forward prototypes
public subroutine of_conti_sp_periodo (date data_da, date data_a, long id_esercizio)
public subroutine of_conti_ce_ch (date data_da, date data_a, integer ll_val)
public subroutine of_conti_ce_parz (date data_da, date data_a, integer ll_val)
public subroutine of_conti_sp_ch (date data_da, date data_a, integer ll_val)
public subroutine of_conti_ce_parz_man (date data_da, date data_a, long id_esercizio, integer ll_val)
public subroutine of_conti_sp_parz (date data_da, date data_a, integer ll_val)
public subroutine of_conti_sp_parz_man (date data_da, date data_a, long id_esercizio, integer ll_val)
end prototypes

public subroutine of_conti_sp_periodo (date data_da, date data_a, long id_esercizio);


long ll_id_conto, ll_prof_aper, ll_prof_chiu
decimal {2} ld_conto,ld_dare,ld_avere
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
      COMMIT;  

end subroutine

public subroutine of_conti_ce_ch (date data_da, date data_a, integer ll_val);


long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group
decimal {2} ld_conto,ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_chiusura
into :ll_ch from par_sistema;

datastore ds_bil
ds_bil=create datastore
ds_bil.dataobject="ds_bil_ce_ch"
ds_bil.settransobject(sqlca)
ds_bil.retrieve(data_da,data_a,ll_ch,ll_val)

ll_riga=ds_bil.rowcount()
ll_num_righe=1
if ll_riga>0 then
	DO
		ll_group=ds_bil.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=ds_bil.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=ds_bil.RowCount()
			end if
		end if
		lb_flag=true
		ll_id_conto=ds_bil.getitemnumber(ll_riga,'id_conto')
		
		ld_dare=ds_bil.getitemnumber(ll_riga,'cavere')
		ld_avere=ds_bil.getitemnumber(ll_riga,'cdare')
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
      COMMIT;  
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
end if	


end subroutine

public subroutine of_conti_ce_parz (date data_da, date data_a, integer ll_val);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group
decimal {2} ld_conto,ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_apertura, id_prof_reg_chiusura
into :ll_ap, :ll_ch from par_sistema;

datastore ds_bil
ds_bil=create datastore
ds_bil.dataobject="ds_bil_ce"
ds_bil.settransobject(sqlca)
ds_bil.retrieve(data_da,data_a,ll_ap, ll_ch, ll_val)

ll_riga=ds_bil.rowcount()
ll_num_righe=1
if ll_riga>0 then
	DO
		ll_group=ds_bil.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=ds_bil.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=ds_bil.RowCount()
			end if
		end if
		lb_flag=true
		ll_id_conto=ds_bil.getitemnumber(ll_riga,'id_conto')
		ld_dare=ds_bil.getitemnumber(ll_riga,'cdare')
		ld_avere=ds_bil.getitemnumber(ll_riga,'cavere')
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
      COMMIT;  
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
end if	


end subroutine

public subroutine of_conti_sp_ch (date data_da, date data_a, integer ll_val);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group
decimal {2} ld_conto,ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_chiusura
into :ll_ch from par_sistema;

datastore ds_bil
ds_bil=create datastore
ds_bil.dataobject="ds_bil_sp_ch"
ds_bil.settransobject(sqlca)
ds_bil.retrieve(data_da,data_a,ll_ch, ll_val)

ll_riga=ds_bil.rowcount()
ll_num_righe=1
if ll_riga>0 then
	DO
		ll_group=ds_bil.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=ds_bil.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=ds_bil.RowCount()
			end if
		end if
		lb_flag=true
		ll_id_conto=ds_bil.getitemnumber(ll_riga,'id_conto')
		
		ld_dare=ds_bil.getitemnumber(ll_riga,'cavere')
		ld_avere=ds_bil.getitemnumber(ll_riga,'cdare')
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
				values (:ll_id_conto,:ld_conto,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			end if
			      COMMIT;  
		end if
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
end if	



end subroutine

public subroutine of_conti_ce_parz_man (date data_da, date data_a, long id_esercizio, integer ll_val);
long ll_id_conto, ll_val_es
decimal {2} ld_conto,ld_dare,ld_avere, old_avere, old_dare
boolean lb_flag

select id_valuta into :ll_val_es
from esercizio where id_esercizio=:id_esercizio;

declare lc_conti_ce cursor for
	select c.id_conto, 
			CAST (SUM (fn_conv_valuta(:ll_val_es,M.DARE,:ll_val)) AS decimal)  DARE,
			CAST (SUM (fn_conv_valuta(:ll_val_es,M.AVERE,:ll_val)) AS decimal)  AVERE
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
COMMIT;  

end subroutine

public subroutine of_conti_sp_parz (date data_da, date data_a, integer ll_val);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group
decimal {2} ld_conto,ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_apertura, id_prof_reg_chiusura
into :ll_ap, :ll_ch from par_sistema;

datastore ds_bil
ds_bil=create datastore
ds_bil.dataobject="ds_bil_sp"
ds_bil.settransobject(sqlca)
ds_bil.retrieve(data_da,data_a,ll_ap, ll_ch, ll_val)

ll_riga=ds_bil.rowcount()
ll_num_righe=1
if ll_riga>0 then
	DO
		ll_group=ds_bil.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=ds_bil.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=ds_bil.RowCount()
			end if
		end if
		lb_flag=true
		ll_id_conto=ds_bil.getitemnumber(ll_riga,'id_conto')
		ld_dare=ds_bil.getitemnumber(ll_riga,'cdare')
		ld_avere=ds_bil.getitemnumber(ll_riga,'cavere')
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
				values (:ll_id_conto,:ld_conto,'P');
			else
				insert into  chiusura_apertura  (id_conto,saldo_dare,tipo)
				values (:ll_id_conto,:ld_conto,'P');
			end if
		end if
      COMMIT;  		
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
end if	


end subroutine

public subroutine of_conti_sp_parz_man (date data_da, date data_a, long id_esercizio, integer ll_val);
long ll_id_conto, ll_val_es
decimal {2} ld_conto,ld_dare,ld_avere, old_avere, old_dare
boolean lb_flag

select id_valuta into :ll_val_es
from esercizio where id_esercizio=:id_esercizio;

declare lc_conti_sp cursor for
	select c.id_conto, 
			CAST (SUM (fn_conv_valuta(:ll_val_es,M.DARE,:ll_val)) AS decimal)  DARE,
			CAST (SUM (fn_conv_valuta(:ll_val_es,M.AVERE,:ll_val)) AS decimal)  AVERE
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
      COMMIT;  
end subroutine

on uo_bilancio.create
TriggerEvent( this, "constructor" )
end on

on uo_bilancio.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;
end event

