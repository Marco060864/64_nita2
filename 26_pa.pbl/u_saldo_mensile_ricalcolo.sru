forward
global type u_saldo_mensile_ricalcolo from nonvisualobject
end type
end forward

global type u_saldo_mensile_ricalcolo from nonvisualobject
end type
global u_saldo_mensile_ricalcolo u_saldo_mensile_ricalcolo

type variables
DataStore	ids_saldo_mensile
DataStore	ids_delete
DataStore                ids_saldo_mensile_man
end variables

forward prototypes
public subroutine uf_create_ds ()
public subroutine uf_destroy_ds ()
public subroutine uf_esegui (long al_id_esercizio, string as_conto_cod_da, string as_conto_cod_a, string as_esercizio_tutti)
public subroutine uf_core_esegui (long al_id_esercizio, string as_conto_cod_da, string as_conto_cod_a)
public subroutine uf_controlla_codice (ref string as_conto_cod, string as_bound)
public subroutine uf_new_core_esegui (long al_id_esercizio, string as_conto_cod_da, string as_conto_cod_a)
end prototypes

public subroutine uf_create_ds ();

ids_saldo_mensile_man= create datastore
ids_saldo_mensile_man.DataObject = "d_saldo_mensile_man_ds"
ids_saldo_mensile_man.SetTransObject(SQLCA)

ids_saldo_mensile= create datastore
ids_saldo_mensile.DataObject = "ds_saldo_mensile_gd"
ids_saldo_mensile.SetTransObject(SQLCA)
end subroutine

public subroutine uf_destroy_ds ();

IF IsValid(ids_saldo_mensile) THEN
	Destroy ids_saldo_mensile
END IF


IF IsValid(ids_saldo_mensile) THEN
	Destroy ids_saldo_mensile_man
END IF
end subroutine

public subroutine uf_esegui (long al_id_esercizio, string as_conto_cod_da, string as_conto_cod_a, string as_esercizio_tutti);

long ll_Rows, ll_i, ll_id_conto, ll_id_mov_contabile, ll_id_esercizi[], ll_j = 1, ll_id_esercizio
string ls_sort
decimal ldc_dare, ldc_avere
date ld_data_inizio_comp, ld_data_fine_comp, ld_data_competenza

uf_controlla_codice(as_conto_cod_da, "min")
uf_controlla_codice(as_conto_cod_a, "max")

CHOOSE CASE as_esercizio_tutti
	CASE "1"
		uf_core_esegui(al_id_esercizio, as_conto_cod_da, as_conto_cod_a)

	CASE "0"
		DECLARE lcur_esercizio CURSOR FOR
			SELECT esercizio.id_esercizio
				FROM dba.esercizio
				ORDER BY esercizio.data_inizio;
				
		OPEN lcur_esercizio;
		
		FETCH lcur_esercizio INTO :ll_id_esercizio;
		IF SQLCA.SQLCode = 0 THEN ll_id_esercizi[ll_j] = ll_id_esercizio
		
		DO WHILE SQLCA.SQLCode = 0
			ll_j ++
			
			FETCH lcur_esercizio INTO :ll_id_esercizio;
			IF SQLCA.SQLCode = 0 THEN ll_id_esercizi[ll_j] = ll_id_esercizio
		LOOP
		CLOSE lcur_esercizio;
		
		IF UpperBound(ll_id_esercizi) > 0 THEN
			FOR ll_j = 1 TO UpperBound(ll_id_esercizi)
				uf_core_esegui(ll_id_esercizi[ll_j], as_conto_cod_da, as_conto_cod_a)
			NEXT
		END IF		
END CHOOSE
end subroutine

public subroutine uf_core_esegui (long al_id_esercizio, string as_conto_cod_da, string as_conto_cod_a);

long ll_Rows, ll_i, ll_id_conto, ll_id_mov_contabile, ll_id_mov_contabile_m, ll_id_conto_m,ll_mese,ll_anno
long ll_riga, ll_num_righe, ll_group, ll_next_group
boolean lb_flag
string ls_sort, ls_tipo_registro
decimal ldc_dare, ldc_avere, ldc_dare_m, ldc_avere_m, ld_conto
date ld_data_inizio_comp, ld_data_fine_comp, ld_data_competenza
date ld_data_inizio_comp_m, ld_data_fine_comp_m, ld_data_competenza_m, ld_da, ld_a

select data_inizio, data_fine into :ld_da, :ld_a 
from esercizio where id_esercizio=:al_id_esercizio;
ll_anno = year(ld_da)
ll_Rows=ids_saldo_mensile.Retrieve(as_conto_cod_da, as_conto_cod_a,ld_da,ld_a)

DELETE FROM saldo_mensile from conto WHERE saldo_mensile.id_conto=conto.id_conto 
				and conto.codice<=:as_conto_cod_a and conto.codice>=:as_conto_cod_da 
				and saldo_mensile.id_esercizio=:al_id_esercizio;    
				
if sqlca.sqlcode=0 then
	commit;
else
	rollback;
	messagebox("Errore!", "Saldo non azzerato!")
end if

	
ll_riga=ids_saldo_mensile.rowcount()
ll_num_righe=1
if ll_riga>0 then
	DO
		ll_group=ids_saldo_mensile.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=ids_saldo_mensile.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=ids_saldo_mensile.RowCount()
			end if
		end if
		lb_flag=true
		ll_id_conto=ids_saldo_mensile.getitemnumber(ll_riga,'mov_contabile_id_conto')
		
		
      ldc_avere=ids_saldo_mensile.getitemdecimal(ll_riga,'sum_dare')
		ldc_dare=ids_saldo_mensile.getitemdecimal(ll_riga,'sum_avere')
		
		ll_mese=ids_saldo_mensile.getitemnumber(ll_riga,'mese')
		if isnull(ldc_dare) then ldc_dare=0
		if isnull(ldc_avere) then ldc_avere=0			
		ld_conto=ldc_dare - ldc_avere	
		if ld_conto<0 then 
			lb_flag=false
			ld_conto=ld_conto* -1
			
		end if
		if ld_conto<>0 then
			if lb_flag=false then
				insert into  saldo_mensile  (id_conto,anno,id_esercizio,mese,dare_competenza,
													  avere_competenza,dare,avere,dare_mn,avere_mn)
				values (:ll_id_conto,:ll_anno,:al_id_esercizio,:ll_mese,:ld_conto,0,:ld_conto,0,0,0);
			else
				insert into  saldo_mensile  (id_conto,anno,id_esercizio,mese,dare_competenza,
													  avere_competenza,dare,avere,dare_mn,avere_mn)
				values (:ll_id_conto,:ll_anno,:al_id_esercizio,:ll_mese,0,:ld_conto,0,:ld_conto,0,0);									  
			end if
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Errore!", "Saldo mese "+string(ll_mese)+" id_conto="+string(ll_id_conto)+" non inserito!")
				Messagebox("Interruzione ricalcolo saldi!", "Il ricalcolo sarà interrotto!")
				return
			end if	
		end if
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga>=ll_rows
end if	

	
	
ll_Rows=ids_saldo_mensile_man.Retrieve(as_conto_cod_da, as_conto_cod_a,ld_da,ld_a)	
	
FOR ll_i = 1 TO ll_Rows

		ldc_dare            = ids_saldo_mensile.GetITemDecimal(ll_i, "mov_contabile_dare")
		IF IsNull(ldc_dare) THEN ldc_dare = 0
		
		ldc_avere           = ids_saldo_mensile.GetITemDecimal(ll_i, "mov_contabile_avere")
		IF IsNull(ldc_avere) THEN ldc_avere = 0
		
		ld_data_inizio_comp = ids_saldo_mensile.GetITemDate(ll_i, "mov_contabile_data_inizio_competenza")
		ld_data_fine_comp   = ids_saldo_mensile.GetITemDate(ll_i, "mov_contabile_data_fine_competenza")
		ld_data_competenza  = ids_saldo_mensile.GetITemDate(ll_i, "reg_pd_data_competenza")
		ll_id_conto         = ids_saldo_mensile.GetITemNumber(ll_i, "mov_contabile_id_conto")
		ll_id_mov_contabile = ids_saldo_mensile.GetITemNumber(ll_i, "mov_contabile_id_mov_contabile")
		ls_tipo_registro    = ids_saldo_mensile.GetITemString(ll_i, "registro_tipo_registro")
		
		
		
		
		DECLARE Scr_manageriali PROCEDURE FOR 
			
		sp_Scritture_manageriali 
		Mov_Dare=:ldc_dare,  Mov_Avere=:ldc_avere , Data_Inizio_Competenza=:ld_data_inizio_comp, Data_Fine_Competenza=:ld_data_fine_comp , Data_Competenza=:ld_data_competenza, Conto=:ll_id_conto , Esercizio=:al_id_esercizio , @ID_Mov_Contab=:ll_id_mov_contabile;
		
		EXECUTE Scr_manageriali ;																														
	
NEXT



end subroutine

public subroutine uf_controlla_codice (ref string as_conto_cod, string as_bound);

IF IsNull(as_conto_cod) OR (as_conto_cod = "") THEN
	
	CHOOSE CASE as_bound
		CASE "min"
			SELECT min(conto.codice)
				INTO :as_conto_cod
				FROM dba.conto
				USING SQLCA;
		CASE "max"
			SELECT max(conto.codice)
				INTO :as_conto_cod
				FROM dba.conto
				USING SQLCA;
		CASE ELSE
			RETURN
	END CHOOSE
	
	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			MessageBox("Errore sul DataBase","u_saldo_mensile_ricalcolo / uf_controlla_codice / 1")
	END CHOOSE
	
END IF
end subroutine

public subroutine uf_new_core_esegui (long al_id_esercizio, string as_conto_cod_da, string as_conto_cod_a);

long ll_Rows, ll_i, ll_id_conto, ll_id_mov_contabile, ll_id_mov_contabile_m, ll_id_conto_m,ll_mese,ll_anno
long ll_riga, ll_num_righe, ll_group, ll_next_group

string ls_sort, ls_tipo_registro
decimal  ldc_avere, ldc_dare_m, ldc_avere_m, ldc_dare
date ld_data_inizio_comp, ld_data_fine_comp, ld_data_competenza
date ld_data_inizio_comp_m, ld_data_fine_comp_m, ld_data_competenza_m, ld_da, ld_a


DELETE FROM saldo_mensile from conto WHERE saldo_mensile.id_conto=conto.id_conto 
				and conto.codice<=:as_conto_cod_a and conto.codice>=:as_conto_cod_da 
				and saldo_mensile.id_esercizio=:al_id_esercizio;    
				
if sqlca.sqlcode=0 then
	commit;
else
	rollback;
	messagebox("Errore!", "Saldo mensile non azzerato! Impossibile continuare!")
	return
end if

select data_inizio, data_fine into :ld_da, :ld_a 
from esercizio where id_esercizio=:al_id_esercizio;
ll_anno = year(ld_da)
ll_Rows=ids_saldo_mensile.Retrieve(as_conto_cod_da, as_conto_cod_a,ld_da,ld_a)

ll_num_righe=1
if ll_Rows>0 then
	DO
		ll_group=ids_saldo_mensile.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=ids_saldo_mensile.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=ll_Rows
			end if
		end if
		ll_id_conto=ids_saldo_mensile.getitemnumber(ll_riga,'mov_contabile_id_conto')
		ll_mese=ids_saldo_mensile.getitemnumber(ll_riga,'mese')
		ldc_dare=ids_saldo_mensile.getitemdecimal(ll_riga, "saldo_conto_mese")
		if ldc_dare<>0 then
			if ldc_dare<0 then 
				ldc_avere=ldc_dare* -1
				ldc_dare=0
			else
				ldc_avere=0
			end if
			insert into  saldo_mensile  
							(id_conto,  anno,   id_esercizio,  mese,
							dare_competenza, avere_competenza,
							dare,  avere,  dare_mn,  avere_mn)
			values 		(:ll_id_conto,:ll_anno,:al_id_esercizio,:ll_mese,
							:ldc_dare, :ldc_avere,
							:ldc_dare,:ldc_avere,0,0);
			if sqlca.sqlcode=0 then
				commit;
			else
				rollback;
				messagebox("Errore!", "Saldo mese "+string(ll_mese)+" id_conto="+string(ll_id_conto)+" non inserito!")
			end if	
		end if
		ll_num_righe=ll_group+1
	Loop Until ll_group=0 or ll_riga >= ll_rows
end if	

	
	
ll_Rows=ids_saldo_mensile_man.Retrieve(as_conto_cod_da, as_conto_cod_a,ld_da,ld_a)	
	
FOR ll_i = 1 TO ll_Rows

		ldc_dare            = ids_saldo_mensile.GetITemDecimal(ll_i, "mov_contabile_dare")
		IF IsNull(ldc_dare) THEN ldc_dare = 0
		
		ldc_avere           = ids_saldo_mensile.GetITemDecimal(ll_i, "mov_contabile_avere")
		IF IsNull(ldc_avere) THEN ldc_avere = 0
		
		ld_data_inizio_comp = ids_saldo_mensile.GetITemDate(ll_i, "mov_contabile_data_inizio_competenza")
		ld_data_fine_comp   = ids_saldo_mensile.GetITemDate(ll_i, "mov_contabile_data_fine_competenza")
		ld_data_competenza  = ids_saldo_mensile.GetITemDate(ll_i, "reg_pd_data_competenza")
		ll_id_conto         = ids_saldo_mensile.GetITemNumber(ll_i, "mov_contabile_id_conto")
		ll_id_mov_contabile = ids_saldo_mensile.GetITemNumber(ll_i, "mov_contabile_id_mov_contabile")
		ls_tipo_registro    = ids_saldo_mensile.GetITemString(ll_i, "registro_tipo_registro")
		
		
		
		
		DECLARE Scr_manageriali PROCEDURE FOR 
			
		sp_Scritture_manageriali 
		Mov_Dare=:ldc_dare,  Mov_Avere=:ldc_avere , Data_Inizio_Competenza=:ld_data_inizio_comp, Data_Fine_Competenza=:ld_data_fine_comp , Data_Competenza=:ld_data_competenza, Conto=:ll_id_conto , Esercizio=:al_id_esercizio , @ID_Mov_Contab=:ll_id_mov_contabile;
		
		EXECUTE Scr_manageriali ;																														
	
NEXT



end subroutine

on u_saldo_mensile_ricalcolo.create
TriggerEvent( this, "constructor" )
end on

on u_saldo_mensile_ricalcolo.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;

uf_create_ds()
end event

event destructor;

uf_destroy_ds()
end event

