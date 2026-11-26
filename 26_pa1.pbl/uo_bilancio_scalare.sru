forward
global type uo_bilancio_scalare from nonvisualobject
end type
end forward

global type uo_bilancio_scalare from nonvisualobject
end type
global uo_bilancio_scalare uo_bilancio_scalare

type variables
long il_filtro
end variables

forward prototypes
public subroutine of_conti_ce_iniz (date data_da, date data_a, integer rd_prof, integer ll_val)
public subroutine of_conti_ce_parz (date data_da, date data_a, integer rd_prof, integer ll_val)
public subroutine of_conti_sp_ch (date data_da, date data_a, integer rd_prof, integer ll_val)
public subroutine of_conti_sp_iniz (date data_da, date data_a, integer rd_prof, integer ll_val)
public subroutine of_conti_sp_parz (date data_da, date data_a, integer rd_prof, integer ll_val)
end prototypes

public subroutine of_conti_ce_iniz (date data_da, date data_a, integer rd_prof, integer ll_val);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group, ll_test
decimal {2} ld_conto,ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_apertura, id_prof_reg_chiusura
into :ll_ap, :ll_ch from par_sistema;

datastore ds_bil
ds_bil=create datastore
ds_bil.dataobject="ds_bil_ce"
ds_bil.settransobject(sqlca)
ds_bil.retrieve(data_da,data_a,ll_ap, ll_ch,ll_val)

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
		
		insert into  chiusura_apertura  (id_conto,saldo1,tipo)
		values (:ll_id_conto,:ld_conto,'E');
		commit;
		

		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
end if	


end subroutine

public subroutine of_conti_ce_parz (date data_da, date data_a, integer rd_prof, integer ll_val);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group, ll_test
decimal {2} ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_apertura, id_prof_reg_chiusura
into :ll_ap, :ll_ch from par_sistema;

datastore ds_bil
ds_bil=create datastore
ds_bil.dataobject="ds_bil_ce"
ds_bil.settransobject(sqlca)
ds_bil.retrieve(data_da,data_a,ll_ap, ll_ch,ll_val)

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
		
		select id_conto
		into :ll_test
		from chiusura_apertura
		where id_conto=:ll_id_conto;
		if sqlca.sqlcode=0 then 
			update chiusura_apertura 
			set saldo_avere=:ld_avere, saldo_dare=:ld_dare
			where id_conto=:ll_id_conto;
	   else
			insert into  chiusura_apertura  (id_conto,saldo_avere,saldo_dare,tipo)
			values (:ll_id_conto,:ld_avere,:ld_dare,'E');
		end if
		commit;

		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
end if	


end subroutine

public subroutine of_conti_sp_ch (date data_da, date data_a, integer rd_prof, integer ll_val);

long ll_id_conto, ll_ap, ll_riga, ll_num_righe, ll_group, ll_next_group
decimal {2} ld_conto,ld_dare,ld_avere
boolean lb_flag

datastore ds_bil
ds_bil=create datastore
ds_bil.dataobject="ds_bil_sp_ch"
ds_bil.settransobject(sqlca)
ds_bil.retrieve(data_da,data_a,rd_prof,ll_val)

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
		insert into  chiusura_apertura  (id_conto,saldo1,tipo)
		values (:ll_id_conto,:ld_conto,'P');
		commit;
				
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
end if	


end subroutine

public subroutine of_conti_sp_iniz (date data_da, date data_a, integer rd_prof, integer ll_val);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group, ll_test
decimal {2} ld_conto,ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_apertura, id_prof_reg_chiusura
into :ll_ap, :ll_ch from par_sistema;

datastore ds_bil
ds_bil=create datastore
ds_bil.dataobject="ds_bil_sp"
ds_bil.settransobject(sqlca)
ds_bil.retrieve(data_da,data_a,ll_ap, ll_ch,ll_val)

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

		insert into  chiusura_apertura  (id_conto,saldo1,tipo)
		values (:ll_id_conto,:ld_conto,'P');
		commit;
		
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
end if	


end subroutine

public subroutine of_conti_sp_parz (date data_da, date data_a, integer rd_prof, integer ll_val);

long ll_id_conto, ll_ap, ll_ch, ll_riga, ll_num_righe, ll_group, ll_next_group, ll_test
decimal {2} ld_dare,ld_avere
boolean lb_flag

select id_prof_reg_apertura, id_prof_reg_chiusura
into :ll_ap, :ll_ch from par_sistema;

datastore ds_bil
ds_bil=create datastore
ds_bil.dataobject="ds_bil_sp"
ds_bil.settransobject(sqlca)
ds_bil.retrieve(data_da,data_a,ll_ap, ll_ch,ll_val)

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

		select id_conto
		into :ll_test
		from chiusura_apertura
		where id_conto=:ll_id_conto;
		if sqlca.sqlcode=0 then 
			update chiusura_apertura 
			set saldo_avere=:ld_avere, saldo_dare=:ld_dare
			where id_conto=:ll_id_conto;
	   else
			insert into  chiusura_apertura  (id_conto,saldo_avere,saldo_dare,tipo)
			values (:ll_id_conto,:ld_avere, :ld_dare,'P');
		end if
		commit;
		
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_bil.rowcount()
end if	


end subroutine

on uo_bilancio_scalare.create
TriggerEvent( this, "constructor" )
end on

on uo_bilancio_scalare.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;
end event

