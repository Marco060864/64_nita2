forward
global type uo_liq_ventilata from nonvisualobject
end type
end forward

global type uo_liq_ventilata from nonvisualobject
end type
global uo_liq_ventilata uo_liq_ventilata

forward prototypes
public subroutine uf_divisioni_iva (integer rd_esercizio, date rd_data, date ra_data, integer rd_attivita)
end prototypes

public subroutine uf_divisioni_iva (integer rd_esercizio, date rd_data, date ra_data, integer rd_attivita);decimal ld_tot_acq, ld_tot_corr, ld_tmp_imp, ld_tmp_iva, ld_imp_rigo, ld_%iva, ld_%det, ld_tmp
long ll_riga, ll_num_righe, ll_group, ll_next_group
long ll_tab_iva
date ld_din

datastore ds_corr
ds_corr=create datastore
ds_corr.dataobject="ds_iva_corr"
ds_corr.settransobject(sqlca)
ds_corr.retrieve(rd_esercizio,rd_attivita,rd_data,ra_data)
ll_riga=ds_corr.rowcount()
ld_tot_corr=ds_corr.getitemdecimal(ll_riga,'tot_imp')
destroy ds_corr

select data_inizio into :ld_din from esercizio where id_esercizio=:rd_esercizio;

datastore ds_liq
ds_liq=create datastore
ds_liq.dataobject="ds_iva_acq_ventilata"
ds_liq.settransobject(sqlca)
ds_liq.retrieve(rd_esercizio,rd_attivita,ld_din,ra_data)

delete from tmp_iva;
commit;
SQLCA.sp_tmp_iva('C')

ll_riga=ds_liq.rowcount()
ld_tot_acq=ds_liq.GetItemDecimal(ll_riga,'tot_imponibile_a') + ds_liq.GetItemDecimal(ll_riga,'tot_iva_a')

ll_riga=ds_liq.rowcount()
ll_num_righe=1
if ll_riga>0 then
	DO
		ll_group=ds_liq.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=ds_liq.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=ds_liq.RowCount()
			end if
		end if
		ll_tab_iva=ds_liq.getitemnumber(ll_riga,'id_tab_iva')
		ld_imp_rigo=ds_liq.getitemdecimal(ll_riga,'col5') + ds_liq.getitemdecimal(ll_riga,'col6')
		ld_%iva=ds_liq.getitemdecimal(ll_riga,'per_aliquota')
		
		ld_tmp=ld_tot_corr*(ld_imp_rigo/ld_tot_acq)
		ld_tmp_imp=(ld_tmp*100)/(ld_%iva+100)
		ld_tmp_iva=ld_tmp - ld_tmp_imp
		
		
		insert into tmp_iva (id_tab_iva, per_imp, per_iva) 
		       values       (:ll_tab_iva, :ld_tmp_imp, :ld_tmp_iva);
		commit;
		
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ds_liq.rowcount()
end if	

destroy ds_liq




















end subroutine

on uo_liq_ventilata.create
TriggerEvent( this, "constructor" )
end on

on uo_liq_ventilata.destroy
TriggerEvent( this, "destructor" )
end on

