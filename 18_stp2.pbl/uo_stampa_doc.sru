forward
global type uo_stampa_doc from nonvisualobject
end type
end forward

global type uo_stampa_doc from nonvisualobject
end type
global uo_stampa_doc uo_stampa_doc

forward prototypes
public subroutine uf_trova_saldi_metallo (long al_id_sog_com, datetime adt_data_doc, long id_registro, long num_prog, long al_id_doc)
end prototypes

public subroutine uf_trova_saldi_metallo (long al_id_sog_com, datetime adt_data_doc, long id_registro, long num_prog, long al_id_doc);date ld_OrderDate
time lt_OrderTime
long ll_righe,ll_breakrow
datastore lds_saldo
decimal  ld_carico[], ld_scarico[],	ld_saldo[]
date ld_da_data1
string ls_metallo[], ls_tipo_reg, ls_metallo_saldo[], ls_saldi_in_esercizio
datetime ldt_data_doc, ld_da_data
long ll_num_prog
integer li_update, i, a, li_up
string ls_saldi_per_titolo, ls_azienda
decimal{2} ld_titolo[]

delete from orafo_st_saldi
where id_doc=:al_id_doc;
if sqlca.sqlcode=0 then
	commit;
else
	rollback;
end if

lds_saldo=create datastore
select saldi_in_esercizio, saldi_per_titolo
into :ls_saldi_in_esercizio, :ls_saldi_per_titolo
from orafo_par_sistema;
select codice into :ls_azienda from dba.azienda;
if ls_saldi_per_titolo='S' then
	lds_saldo.dataobject='d_or_st_saldi_per_titolo_tb'
else
	lds_saldo.dataobject='d_or_par_mov_per_fatt_tb'
end if
lds_saldo.settransobject(sqlca)
select data_inizio
into :ld_da_data1
from esercizio e, registro r
where  e.id_esercizio=r.id_esercizio
and r.id_registro=:id_registro
;
if sqlca.sqlcode<>0 then
	messagebox("Attenzione!", "Data inizio esercizio non trovata!!")
else
	ld_da_data=datetime(ld_da_data1, time('00:00:00'))
end if
if ls_saldi_in_esercizio='N' or isnull(ls_saldi_in_esercizio) then
	ld_OrderDate = Date('1951-01-01')
	lt_OrderTime = time('00:00:00')
	ld_da_data=datetime(ld_OrderDate, lt_OrderTime)
end if
if ls_saldi_in_esercizio='S' then
	select data_ora_creazione into :ldt_data_doc from dba.documento where id_documento=:al_id_doc;
else
	select max(data_ora_creazione)
	into :ldt_data_doc
	from documento
	where id_sog_commerciale=:al_id_sog_com
	and id_registro=:id_registro
	and data_ora_creazione< :adt_data_doc;
end if
if ldt_data_doc>ld_da_data and not isnull(ldt_data_doc) then 
	
	ll_righe=lds_saldo.retrieve(ld_da_data, ldt_data_doc, al_id_sog_com)
	if ll_righe>0 then
		DO 
			ll_breakrow = lds_saldo.FindGroupChange(ll_breakrow, 1)
			IF ll_breakrow <= 0 THEN EXIT
			i++
			if ls_saldi_per_titolo='S' then
				ld_titolo[i]=lds_saldo.GetItemdecimal(ll_breakrow, "titolo")
				ls_metallo_saldo[i]=lds_saldo.GetItemstring(ll_breakrow, "tipo")+string(ld_titolo[i])
			else
				ls_metallo_saldo[i]=lds_saldo.GetItemstring(ll_breakrow, "tipo")
			end if
			ld_saldo[i]=lds_saldo.GetItemdecimal(ll_breakrow, "saldo_2") 
		   
			ll_breakrow = ll_breakrow + 1
		LOOP WHILE ll_breakrow>0
	end if	
	
else
		ldt_data_doc=ld_da_data 
end if
if ls_saldi_in_esercizio='S' then
	if upperbound(ls_metallo_saldo) > upperbound(ls_metallo) then
		for a = 1 to upperbound(ls_metallo_saldo)
			li_up=0
			for i=1 to upperbound(ls_metallo)
				if ls_metallo[i]=	ls_metallo_saldo[a] then
					li_up=1
					exit
				end if
			next
			if li_up=0 then
				insert into orafo_st_saldi (metallo, carico, scarico, id_doc, titolo)
				values (:ls_metallo_saldo[a], :ld_saldo[a], 0, :al_id_doc, :ld_titolo[i]);
				if sqlca.sqlcode=0 then
					commit;
				else
					rollback;
				end if
			end if
		next
	end if
else
	ll_righe=lds_saldo.retrieve(ldt_data_doc, adt_data_doc, al_id_sog_com)
	i=0
	if ll_righe>0 then
		DO 
			ll_breakrow = lds_saldo.FindGroupChange(ll_breakrow, 1)
			IF ll_breakrow <= 0 THEN EXIT
			i++
			ld_carico[i]=lds_saldo.GetItemdecimal(ll_breakrow, "somma_carichi") 
			ld_scarico[i]=lds_saldo.GetItemdecimal(ll_breakrow, "somma_scarichi") 
			ld_titolo[i]=lds_saldo.GetItemdecimal(ll_breakrow, "titolo")
			if ls_saldi_per_titolo='S' then
				ls_metallo[i]=lds_saldo.GetItemstring(ll_breakrow, "tipo")+string(ld_titolo[i])
			else
				ls_metallo[i]=lds_saldo.GetItemstring(ll_breakrow, "tipo")
			end if
			ll_breakrow = ll_breakrow + 1
		LOOP WHILE ll_breakrow>0
		
		for i= 1 to upperbound(ls_metallo)
			for a= 1 to upperbound(ls_metallo_saldo)
				if ls_metallo[i]=	ls_metallo_saldo[a] then
					ld_carico[i]+=ld_saldo[a]
					exit
				end if
			next
			insert into orafo_st_saldi (metallo, carico, scarico, id_doc, titolo)
			values (:ls_metallo[i], :ld_carico[i], :ld_scarico[i], :al_id_doc, :ld_titolo[i]);
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
			end if
		next
			
	end if	
	
	if upperbound(ls_metallo_saldo) > upperbound(ls_metallo) then
		for a = 1 to upperbound(ls_metallo_saldo)
			li_up=0
			for i=1 to upperbound(ls_metallo)
				if ls_metallo[i]=	ls_metallo_saldo[a] then
					li_up=1
					exit
				end if
			next
			if li_up=0 then
				insert into orafo_st_saldi (metallo, carico, scarico, id_doc, titolo)
				values (:ls_metallo_saldo[a], :ld_saldo[a], 0, :al_id_doc, :ld_titolo[i]);
				if sqlca.sqlcode=0 then
					commit;
				else
					rollback;
				end if
			end if
		next
	end if
	
end if
destroy lds_saldo	
end subroutine

on uo_stampa_doc.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_stampa_doc.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

