forward
global type uo_lis_fornitori from nonvisualobject
end type
end forward

global type uo_lis_fornitori from nonvisualobject
end type
global uo_lis_fornitori uo_lis_fornitori

forward prototypes
public subroutine f_agg_lis_fornitore (long id_sog_cliente, decimal adc_prezzo, long al_id_uc, date adt_data_doc)
end prototypes

public subroutine f_agg_lis_fornitore (long id_sog_cliente, decimal adc_prezzo, long al_id_uc, date adt_data_doc);datastore ds_lis_fo, ds_salva_lis
integer li_righe, i
long ll_id_var
decimal ldc_sconto, ldc_prezzo
string ls_tipo_um
//ds_salva_lis=create datastore
//ds_salva_lis.dataobject="ds_salva_nuovo_prezzo"
//ds_salva_lis.settransobject(sqlca)

ds_lis_fo=create datastore
ds_lis_fo.dataobject="d_trova_lis_fornitore"
ds_lis_fo.settransobject(sqlca)
li_righe=ds_lis_fo.retrieve(id_sog_cliente, adt_data_doc)
for I=1 to li_righe
	select m.tipo 
	into :ls_tipo_um
	from unita_confezione u, unita_misura m
	where u.id_unita_misura=m.id_unita_misura
	and u.id_unita_confezione=:al_id_uc;
	
	ll_id_var=ds_lis_fo.getitemnumber(i, "id_variazione")
	ldc_sconto=ds_lis_fo.getitemdecimal(i, "sconto")
	ldc_prezzo=adc_prezzo - adc_prezzo*ldc_sconto/100
	if ls_tipo_um='P' then
		insert into dba.prezzo (id_variazione, id_unita_confezione, prezzo_manifattura)
		values(:ll_id_var, :al_id_uc, :ldc_prezzo);
		if sqlca.sqlnrows>0 then
			commit;
		else
			rollback;
			update dba.prezzo
			set prezzo_manifattura=:ldc_prezzo
			where id_variazione=:ll_id_var
			and id_unita_confezione=:al_id_uc
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo Man. non salvato!")
			end if
		end if
	else //prezzo al pezzo: "prezzo" non "prezzo_manifattura"
		insert into dba.prezzo (id_variazione, id_unita_confezione, prezzo)
		values(:ll_id_var, :al_id_uc, :ldc_prezzo);
		if sqlca.sqlnrows>0 then
			commit;
		else
			rollback;
			update dba.prezzo
			set prezzo=:ldc_prezzo
			where id_variazione=:ll_id_var
			and id_unita_confezione=:al_id_uc
			;
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Attenzione!", "Prezzo PZ non salvato!")
			end if
		end if
	end if
	
next


end subroutine

on uo_lis_fornitori.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_lis_fornitori.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

