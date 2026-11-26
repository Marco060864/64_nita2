forward
global type w_par_aperta_partite_gd from w_wiz_main
end type
type cb_ok from commandbutton within w_par_aperta_partite_gd
end type
type cb_chiudi from commandbutton within w_par_aperta_partite_gd
end type
type cbx_filtro from checkbox within w_par_aperta_partite_gd
end type
type cb_proponi_saldo from commandbutton within w_par_aperta_partite_gd
end type
type p_msg_log from picture within w_par_aperta_partite_gd
end type
type dw_mov_partita_partite_gd from u_dw_pura within w_par_aperta_partite_gd
end type
type dw_mov_partita_scadenze_gd from u_dw_pura within w_par_aperta_partite_gd
end type
type p_arrow from picture within w_par_aperta_partite_gd
end type
type cb_1 from commandbutton within w_par_aperta_partite_gd
end type
type cb_deproponi_saldo from commandbutton within w_par_aperta_partite_gd
end type
end forward

global type w_par_aperta_partite_gd from w_wiz_main
int X=663
int Y=424
int Width=2363
int Height=1548
WindowType WindowType=response!
boolean TitleBar=true
string Title="Movimentazione Partite"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_chiudi cb_chiudi
cbx_filtro cbx_filtro
cb_proponi_saldo cb_proponi_saldo
p_msg_log p_msg_log
dw_mov_partita_partite_gd dw_mov_partita_partite_gd
dw_mov_partita_scadenze_gd dw_mov_partita_scadenze_gd
p_arrow p_arrow
cb_1 cb_1
cb_deproponi_saldo cb_deproponi_saldo
end type
global w_par_aperta_partite_gd w_par_aperta_partite_gd

type variables
string is_tag
long il_id_conto
long il_id_reg_pd
long il_num_riga
long il_id_mov_contabile
decimal idc_dare
decimal idc_avere
string is_caller_col
date id_data_registrazione
boolean ib_return = FALSE
integer ii_dw = 0
decimal idc_iva
integer il_giro
long il_lire
long il_val_reg, il_esercizio
long ll_reg_now
end variables

forward prototypes
public subroutine uf_assegna_totale ()
public subroutine uf_crea_mov_scadenza (long al_riga_mov_partita, long al_id_mov_partita)
public subroutine uf_filtra_scadenze (long al_row)
public subroutine uf_proponi_saldo ()
public subroutine uf_reset_proponi ()
public subroutine uf_chiudi_partite (string test)
end prototypes

public subroutine uf_assegna_totale ();

long ll_CurrRow_Partite, ll_CurrRow_Scadenze
decimal ldc_tot_mov_scad, ldc_tot_mov_partita

ll_CurrRow_Partite = dw_mov_partita_partite_gd.GetRow()
ll_CurrRow_Scadenze = dw_mov_partita_scadenze_gd.GetRow()

ldc_tot_mov_scad = dw_mov_partita_scadenze_gd.GetItemDecimal(ll_CurrRow_Scadenze, "tot_mov_scadenza_importo")
ldc_tot_mov_partita = dw_mov_partita_partite_gd.GetItemDecimal(ll_CurrRow_Partite, "par_aperta_movimento")

IF IsNull(ldc_tot_mov_partita) OR ldc_tot_mov_partita = 0 THEN
	dw_mov_partita_partite_gd.SetItem(ll_CurrRow_Partite, "par_aperta_movimento", ldc_tot_mov_scad)
END IF
end subroutine

public subroutine uf_crea_mov_scadenza (long al_riga_mov_partita, long al_id_mov_partita);

long ll_NRows, ll_i, ll_id_mov_scadenza, ll_id_scadenza, ll_CurrRow_Mov_Partita, ll_RetVal = 0
decimal ldc_mov_scadenza 
date ld_data_mov_scadenza
string ls_note
integer LCI_ID_AZIENDA
dwItemStatus ldwis_status

LCI_ID_AZIENDA = 1

uf_filtra_scadenze(al_riga_mov_partita)

ll_NRows = dw_mov_partita_scadenze_gd.RowCount()

FOR ll_i = 1 TO ll_NRows
   ldc_mov_scadenza = dw_mov_partita_scadenze_gd.GetItemDecimal(ll_i, "mov_scadenza_importo")
   ldwis_status = dw_mov_partita_scadenze_gd.GetItemStatus(ll_i, 0, Primary!)
   IF ldwis_status = DataModified! THEN
      ll_id_mov_scadenza = dw_mov_partita_scadenze_gd.GetItemNumber(ll_i, "mov_scadenza_id_mov_scadenza")
      ll_id_scadenza = dw_mov_partita_scadenze_gd.GetItemNumber(ll_i, "scadenza_id_scadenza")
      ld_data_mov_scadenza = dw_mov_partita_scadenze_gd.GetItemDate(ll_i, "mov_scadenza_data")
      ls_note = dw_mov_partita_scadenze_gd.GetItemString(ll_i, "mov_scadenza_note")
      
      
		
      IF IsNull(ll_id_mov_scadenza) THEN
   		IF NOT IsNull(ldc_mov_scadenza) THEN 
				INSERT INTO "mov_scadenza"  
					( "id_scadenza",
					"id_mov_partita",
					"data",   
					"importo",   
					"imp_valuta",   
					"note",
					"id_azienda")  
				VALUES ( :ll_id_scadenza,
					:al_id_mov_partita,
					:ld_data_mov_scadenza,   
					:ldc_mov_scadenza,   
					:ldc_mov_scadenza,   
					:ls_note,
					:LCI_ID_AZIENDA)  ;
				commit;	
			END IF   
      ELSE
			
         IF IsNull(ldc_mov_scadenza) THEN 
				
            DELETE FROM mov_scadenza
               WHERE mov_scadenza.id_mov_scadenza = :ll_id_mov_scadenza ;
				commit;	
         ELSE
				
            UPDATE "mov_scadenza"  
               SET "data"       = :ld_data_mov_scadenza,   
                   "importo"    = :ldc_mov_scadenza,   
                   "imp_valuta" = :ldc_mov_scadenza,
                   "note"       = :ls_note
               WHERE "mov_scadenza"."id_mov_scadenza" = :ll_id_mov_scadenza   ;
					commit;
      	END IF

      END IF
      
      IF SQLCA.SQLCode <> 0 THEN
         ll_RetVal = 5
      END IF

   END IF
NEXT


end subroutine

public subroutine uf_filtra_scadenze (long al_row);

long ll_id_par_aperta, ll_id_mov_partita, ll_ret
string ls_filter

IF (dw_mov_partita_partite_gd.GetRow() > 0) and (al_row > 0) THEN
	ll_id_par_aperta = dw_mov_partita_partite_gd.GetItemNumber(al_row, "id_par_aperta")
	ls_filter = "(scadenza_id_par_aperta = " + string(ll_id_par_aperta) + ")"
	dw_mov_partita_scadenze_gd.SetFilter(ls_filter)
	dw_mov_partita_scadenze_gd.Filter()
   if	dw_mov_partita_scadenze_gd.rowcount()>0 then 
		dw_mov_partita_partite_gd.Modify("par_aperta_movimento.Protect=1")
	else
		dw_mov_partita_partite_gd.Modify("par_aperta_movimento.Protect=0")
	end if	
END IF
end subroutine

public subroutine uf_proponi_saldo ();

long ll_Curr_Row
integer i
decimal ldc_saldo, ld_tot_saldo
string ls_dataobject


ls_dataobject = u_freddie.iudw_current.dataobject

CHOOSE CASE ii_dw
	CASE 1
		ll_Curr_Row = dw_mov_partita_partite_gd.GetRow()
		
		IF ll_Curr_Row > 0 THEN
			ldc_saldo = dw_mov_partita_partite_gd.GetItemDecimal(ll_Curr_Row, "csaldo")
			dw_mov_partita_partite_gd.SetItem(ll_Curr_Row, "par_aperta_movimento", ldc_saldo)
			if dw_mov_partita_scadenze_gd.Rowcount()=0 then 
				dw_mov_partita_partite_gd.setitem(ll_Curr_Row, "note",'%%')
			else
				for i=1 to dw_mov_partita_scadenze_gd.Rowcount()
					ld_tot_saldo=dw_mov_partita_scadenze_gd.getitemDecimal(i,"scadenza_saldo")
					dw_mov_partita_scadenze_gd.setitem(i,"mov_scadenza_importo", ld_tot_saldo)
				next	
			end if	
			dw_mov_partita_partite_gd.SetFocus()
		END IF
	CASE 2
		ll_Curr_Row = dw_mov_partita_scadenze_gd.GetRow()
		
		IF ll_Curr_Row > 0 THEN
			ldc_saldo = dw_mov_partita_scadenze_gd.GetItemDecimal(ll_Curr_Row, "scadenza_saldo")
			if ldc_saldo=0 then 
				messagebox('Information!', 'La scadenza selezionata è stata totalmente estinta')
		   else	
				dw_mov_partita_scadenze_gd.SetItem(ll_Curr_Row, "mov_scadenza_data", id_data_registrazione)
				dw_mov_partita_scadenze_gd.SetItem(ll_Curr_Row, "mov_scadenza_importo", ldc_saldo)
				
				dw_mov_partita_scadenze_gd.SetFocus()
				dw_mov_partita_partite_gd.Event Post ue_assegna_tot_mov_scad()
			end if	
		END IF
END CHOOSE


end subroutine

public subroutine uf_reset_proponi ();


long ll_par, ll_test1, ll_test2, ll_scad
decimal ld_imp, ld_imp_scad
DECLARE cur_par CURSOR FOR 
		  Select id_par_aperte, importo_par
		  From gest_chiudi_partite
		  Where num_riga=:il_num_riga and id_reg_now=:ll_reg_now; 
		  
OPEN cur_par;
FETCH cur_par INTO :ll_par, :ld_imp;
DO WHILE sqlca.sqlcode=0
	ll_test1=dw_mov_partita_partite_gd.Find("id_par_aperta="+string(ll_par), 1,  dw_mov_partita_partite_gd.rowcount())
	dw_mov_partita_partite_gd.setrow(ll_test1)
	uf_filtra_scadenze(ll_test1)
	ll_test2=dw_mov_partita_scadenze_gd.Find("scadenza_id_par_aperta="+string(ll_par), 1,  dw_mov_partita_scadenze_gd.rowcount())			
	IF ll_test2=0 and ll_test1>0 then 
		ii_dw=1
		uf_proponi_saldo()
		dw_mov_partita_partite_gd.setitem(ll_test1,'chiudi','1')
		Delete from gest_chiudi_scadenze 
		where id_par_aperte=:ll_par and id_reg_now=:ll_reg_now; 
	ELSE	
		DECLARE cur_scad CURSOR FOR 
		  Select id_scadenza, imp_scadenza
		  From gest_chiudi_scadenze
		  Where id_par_aperte=:ll_par and id_reg_now=:ll_reg_now; 
		  OPEN cur_scad;
		  FETCH cur_scad INTO :ll_scad, :ld_imp_scad;
		  DO WHILE sqlca.sqlcode=0
			  ii_dw=2
			  ll_test2=dw_mov_partita_scadenze_gd.Find("scadenza_id_scadenza="+string(ll_scad), 1,  dw_mov_partita_scadenze_gd.rowcount())
			  dw_mov_partita_scadenze_gd.setrow(ll_test2)
			  dw_mov_partita_scadenze_gd.setitem(ll_test2,"mov_scadenza_importo",ld_imp_scad)
			  dw_mov_partita_partite_gd.Event ue_assegna_tot_mov_scad()
			  
		     FETCH cur_scad INTO :ll_scad, :ld_imp_scad;
		  LOOP
		  dw_mov_partita_partite_gd.setitem(ll_test1,'chiudi','1')
		  CLOSE cur_scad;
		  Delete from gest_chiudi_scadenze 
		  where id_par_aperte=:ll_par and id_reg_now=:ll_reg_now; 
		  Delete from gest_chiudi_partite
		  where id_par_aperte=:ll_par and id_reg_now=:ll_reg_now; 
	END IF	  
	FETCH cur_par INTO :ll_par, :ld_imp;	  
	idc_dare=0; idc_avere=0;
LOOP
CLOSE cur_par;

end subroutine

public subroutine uf_chiudi_partite (string test);



long ll_test
select count(*) into :ll_test from gest_chiudi_partite 
where id_reg_pd=:il_id_reg_pd and id_reg_now=:ll_reg_now; 
if ll_test<=0 or isnull(ll_test) then
	delete from gest_chiudi_partite where id_reg_now=:ll_reg_now; 
	delete from gest_chiudi_scadenze where id_reg_now=:ll_reg_now; 
	commit;
end if	

dwItemStatus l_status
integer li_rows, i, li_ret

long li_id_scadenza, li_id_mov_scadenza, li_id_azienda
long li_id_par_aperte 

decimal ld_importo_par,ld_imp_scadenza, ld_imp_valuta_scad, ld_imp_originale
date ld_data_mov, ld_data_scadenza
string ls_note, ls_scadenza, ls_filter

if test='1' then
	dw_mov_partita_partite_gd.setfilter("chiudi='1'")
   dw_mov_partita_partite_gd.filter()
end if	

li_rows=dw_mov_partita_partite_gd.RowCount()


if li_rows>0 then
	
   for i=1 to li_rows
		 l_status=dw_mov_partita_partite_gd.getItemStatus(i,"par_aperta_movimento",Primary!)
		 
	    
		 if l_status=DataModified! then
			 li_id_par_aperte=dw_mov_partita_partite_gd.GetItemNumber(i,"id_par_aperta")
			 ld_importo_par=dw_mov_partita_partite_gd.GetItemDecimal(i,"par_aperta_movimento")
			 ld_data_mov=dw_mov_partita_partite_gd.GetItemDate(i,"par_aperta_data_partita")
		    ls_note=dw_mov_partita_partite_gd.GetItemString(i,"note")
			 ld_imp_originale=dw_mov_partita_partite_gd.GetItemDecimal(i,"csaldo")
			 
			 
			 
			 
			 
			 

		    IF ld_importo_par<>0 THEN 
				 
				 INSERT INTO "gest_chiudi_partite"  
								( "id_par_aperte",   
								  "importo_par",   
								  "id_reg_pd",   
								  "num_riga",   
								  "data_mov",
								  "note",
								  "importo_originale",
								  "id_reg_now")      
					  VALUES ( :li_id_par_aperte,   
								  :ld_importo_par,   
								  :il_id_reg_pd,   
								  :il_num_riga,   
								  :ld_data_mov,
								  :ls_note,
								  :ld_imp_originale,
								  :ll_reg_now)  ;  
						commit;		  
				
				if sqlca.sqlcode<>0 then
					messagebox("Attenzione!", "Gestione chiusura partite fallita!")
				end if
				
			 END IF

		 end if
	next
end if


ls_filter=''
dw_mov_partita_scadenze_gd.setfilter(ls_filter)
dw_mov_partita_scadenze_gd.filter()

li_rows=dw_mov_partita_scadenze_gd.RowCount()

if li_rows>0 then
	
   for i=1 to li_rows
		 l_status=dw_mov_partita_scadenze_gd.getItemStatus(i,"mov_scadenza_importo",Primary!)
		 if l_status=DataModified! then
   		 li_id_par_aperte=dw_mov_partita_scadenze_gd.GetItemNumber(i,"scadenza_id_par_aperta")
		    ld_imp_scadenza=dw_mov_partita_scadenze_gd.GetItemDecimal(i,"mov_scadenza_importo")
			 ld_data_scadenza=dw_mov_partita_scadenze_gd.GetItemDate(i,"mov_scadenza_data")
			 li_id_scadenza=dw_mov_partita_scadenze_gd.GetItemNumber(i,"scadenza_id_scadenza")
			 ls_note=dw_mov_partita_scadenze_gd.GetItemString(i,"mov_scadenza_note")
          ld_imp_originale=dw_mov_partita_scadenze_gd.GetItemDecimal(i,"scadenza_saldo")

			 IF ld_imp_scadenza<>0 THEN 
				 INSERT INTO "gest_chiudi_scadenze"  
								( "id_par_aperte",
								  "imp_scadenza",   
								  "id_scadenza",   
								  "data_scadenza",   
								  "imp_valuta_scad",   
								  "note",
								  "importo_originale",
								  "id_reg_now")   
					  VALUES ( :li_id_par_aperte,  
								  :ld_imp_scadenza,   
								  :li_id_scadenza,   
								  :ld_data_scadenza,  
								  :ld_imp_scadenza,     
								  :ls_note,
								  :ld_imp_originale,
								  :ll_reg_now)  ;   
					  commit;			  
				
				if sqlca.sqlcode<>0 then
					messagebox("Attenzione!", "Gestione chiusura partite fallita!")
				end if
				
			 END IF

		 end if
	next
end if
end subroutine

on w_par_aperta_partite_gd.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_chiudi=create cb_chiudi
this.cbx_filtro=create cbx_filtro
this.cb_proponi_saldo=create cb_proponi_saldo
this.p_msg_log=create p_msg_log
this.dw_mov_partita_partite_gd=create dw_mov_partita_partite_gd
this.dw_mov_partita_scadenze_gd=create dw_mov_partita_scadenze_gd
this.p_arrow=create p_arrow
this.cb_1=create cb_1
this.cb_deproponi_saldo=create cb_deproponi_saldo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_chiudi
this.Control[iCurrent+3]=this.cbx_filtro
this.Control[iCurrent+4]=this.cb_proponi_saldo
this.Control[iCurrent+5]=this.p_msg_log
this.Control[iCurrent+6]=this.dw_mov_partita_partite_gd
this.Control[iCurrent+7]=this.dw_mov_partita_scadenze_gd
this.Control[iCurrent+8]=this.p_arrow
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_deproponi_saldo
end on

on w_par_aperta_partite_gd.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_chiudi)
destroy(this.cbx_filtro)
destroy(this.cb_proponi_saldo)
destroy(this.p_msg_log)
destroy(this.dw_mov_partita_partite_gd)
destroy(this.dw_mov_partita_scadenze_gd)
destroy(this.p_arrow)
destroy(this.cb_1)
destroy(this.cb_deproponi_saldo)
end on

event open;call super::open;



ll_reg_now=Message.DoubleParm	

string las_array[]

dw_mov_partita_partite_gd.SetRowFocusIndicator(p_arrow)

u_freddie.sp_pop(las_array)

is_tag = las_array[1]
il_id_reg_pd = long(las_array[2])
il_num_riga = long(las_array[3])
il_id_mov_contabile = long(las_array[4])
idc_dare = dec(las_array[5])
idc_avere = dec(las_array[6])
is_caller_col = las_array[7]
id_data_registrazione = date(las_array[8])
il_id_conto = long(las_array[9])
il_esercizio = long(las_array[10])

dw_mov_partita_partite_gd.SetFilter("stato ='A' and csaldo<>0")
dw_mov_partita_partite_gd.Filter()

select id_valuta into :il_val_reg
from esercizio where id_esercizio=:il_esercizio;
dw_mov_partita_partite_gd.Object.par_aperta_movimento.Edit.format=f_valu_mask(il_val_reg)
dw_mov_partita_scadenze_gd.Object.mov_scadenza_importo.Edit.format=f_valu_mask(il_val_reg)

dw_mov_partita_partite_gd.SetTransObject(SQLCA)
dw_mov_partita_partite_gd.Retrieve(il_id_conto, il_val_reg)  



dw_mov_partita_scadenze_gd.SetTransObject(SQLCA)
dw_mov_partita_scadenze_gd.Retrieve(il_id_conto,il_id_mov_contabile, il_val_reg)  

uf_reset_proponi()


select id_val_lire into :il_lire
from par_sistema;




end event

event ue_post_open;call super::ue_post_open;

long ll_row

ll_row = dw_mov_partita_partite_gd.GetRow()

IF ll_row > 0 THEN
	uf_filtra_scadenze(ll_row)
END IF

long ll_nrighe,ll_id_reg_pd,ll_id_par_aperta,i
ll_nrighe=dw_mov_partita_partite_gd.rowcount()
if ll_nrighe<>0 then
	FOR i=1 TO ll_nrighe
		ll_id_par_aperta=dw_mov_partita_partite_gd.getitemnumber(i,"id_par_aperta")
		select id_reg_pd
		into :ll_id_reg_pd
		from par_aperta
		where id_par_aperta=:ll_id_par_aperta;
		dw_mov_partita_partite_gd.setitem(i,"id_reg_pd",ll_id_reg_pd)
	NEXT
end if

	
end event

event closequery;call super::closequery;string las_array[]

IF ib_return = FALSE THEN
	u_freddie.sp_clear()
	las_array[1] = ""
	las_array[2] = ""
	u_freddie.sp_push(las_array)
END IF
end event

type cb_ok from commandbutton within w_par_aperta_partite_gd
int X=32
int Y=40
int Width=192
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

string las_array[], ls_segno
long ll_RetVal
integer li_RetVal_Msg
decimal ldc_tot_movimenti, ldc_importo

IF dw_mov_partita_partite_gd.RowCount() > 0 THEN
	dw_mov_partita_partite_gd.AcceptText()
	dw_mov_partita_partite_gd.Event ue_assegna_tot_mov_scad()
	uf_chiudi_partite('0') 
	ldc_tot_movimenti = dw_mov_partita_partite_gd.GetItemDecimal(dw_mov_partita_partite_gd.GetRow(), "tot_movimenti")
	if ldc_tot_movimenti<=0 then
		messagebox('Attenzione', "L'importo proponibile non può essere minore di 0")
		return
	end if	
	u_freddie.sp_clear()
	las_array[1] = "dw_mov_partita_partite_gd"
	las_array[2] = string(ldc_tot_movimenti)
	long ll_reg
	ll_reg=dw_mov_partita_partite_gd.GetItemnumber(dw_mov_partita_partite_gd.GetRow(), "id_reg_pd")
	las_array[3] = string(ll_reg)
	u_freddie.sp_push(las_array)
END IF
ib_return = TRUE
Close(Parent)

end event

type cb_chiudi from commandbutton within w_par_aperta_partite_gd
int X=247
int Y=40
int Width=201
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="Chiudi"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;


string las_array[], ls_segno
long ll_RetVal
integer li_RetVal_Msg
decimal ldc_tot_movimenti, ldc_importo

IF dw_mov_partita_partite_gd.RowCount() > 0 THEN
	dw_mov_partita_partite_gd.AcceptText()
	dw_mov_partita_partite_gd.Event ue_assegna_tot_mov_scad()
	uf_chiudi_partite('1') 
	
	
	if dw_mov_partita_partite_gd.GetRow()>0 then	
		ldc_tot_movimenti = dw_mov_partita_partite_gd.GetItemDecimal(dw_mov_partita_partite_gd.GetRow(), "tot_movimenti")
	else
		Close(Parent)
	end if	
	
	if ldc_tot_movimenti<=0 then
		messagebox('Attenzione', "L'importo proponibile non può essere minore di 0")
		return
	end if	
	u_freddie.sp_clear()
	las_array[1] = "dw_mov_partita_partite_gd"
	las_array[2] = string(ldc_tot_movimenti)
	long ll_reg
	ll_reg=dw_mov_partita_partite_gd.GetItemnumber(dw_mov_partita_partite_gd.GetRow(), "id_reg_pd")
	las_array[3] = string(ll_reg)
	u_freddie.sp_push(las_array)
END IF
ib_return = TRUE
Close(Parent)

end event

type cbx_filtro from checkbox within w_par_aperta_partite_gd
event clicked pbm_bnclicked
int X=489
int Y=40
int Width=654
int Height=76
int TabOrder=50
boolean BringToTop=true
string Text="&Mostra solo partite aperte:"
boolean Checked=true
boolean LeftText=true
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_filtro

IF THIS.Checked = TRUE THEN
	ls_filtro = "stato='A'"
ELSE
	ls_filtro = ""
END IF

dw_mov_partita_partite_gd.SetFilter(ls_filtro)
dw_mov_partita_partite_gd.Filter()
end event

type cb_proponi_saldo from commandbutton within w_par_aperta_partite_gd
event clicked pbm_bnclicked
int X=2002
int Y=40
int Width=325
int Height=84
int TabOrder=60
boolean BringToTop=true
string Text="&Proponi Saldo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

uf_proponi_saldo()
end event

type p_msg_log from picture within w_par_aperta_partite_gd
int X=2222
int Y=40
int Width=96
int Height=84
boolean Visible=false
string PictureName="s:\pb\commonframework\info_in.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
end type

event clicked;
integer li_in

li_in=iuo_msg_log.uf_manage_msg()
parent.SetFocus()

end event

type dw_mov_partita_partite_gd from u_dw_pura within w_par_aperta_partite_gd
event ue_assegna_tot_mov_scad ( )
event ue_genera_mov_partita ( )
event ue_visualizza_importi ( )
event ue_saldaconto ( decimal adc_movimento )
int X=32
int Y=160
int Width=2290
int Height=632
int TabOrder=10
string DataObject="d_par_aperta_gd"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_assegna_tot_mov_scad;

decimal ldc_tot_mov_scadenza
long ll_CurrRow_Mov_Scad, ll_CurrRow_Mov_Partita, ll_id_scadenza
string ls_note

ll_CurrRow_Mov_Scad = dw_mov_partita_scadenze_gd.GetRow()
ll_CurrRow_Mov_Partita = dw_mov_partita_partite_gd.GetRow()

IF ll_CurrRow_Mov_Scad > 0 THEN
	dw_mov_partita_scadenze_gd.AcceptText()
	ldc_tot_mov_scadenza = dw_mov_partita_scadenze_gd.GetItemDecimal(ll_CurrRow_Mov_Scad, "tot_mov_scadenza_importo")
	IF ldc_tot_mov_scadenza > 0 THEN
		dw_mov_partita_partite_gd.SetItem(ll_CurrRow_Mov_Partita, "par_aperta_movimento", ldc_tot_mov_scadenza)
	END IF
END IF
end event

event itemchanged;

decimal ldc_saldo

CHOOSE CASE string(dwo.name)
	CASE "par_aperta_movimento"
		ldc_saldo = THIS.GetItemDecimal(row, "csaldo")
		IF dec(data) > ldc_saldo THEN
			MessageBox("Movimentazione Partite", "Attenzione: l'importo immesso è superiore del Saldo.", Exclamation!)
		END IF
	
	
	
	
	
	case "par_aperta_num_partita"
		return 2
		
END CHOOSE


end event

event rowfocuschanged;




Post Function uf_filtra_scadenze(currentrow)
end event

event getfocus;call super::getfocus;

ii_dw = 1
end event

event editchanged;
long ll_pos, ll_pos1, ll_imp

if dwo.name = "par_aperta_movimento" then
   if il_lire=il_val_reg then
		ll_pos=pos(data,',')
		ll_pos1=pos(data,',00')
		if ll_pos>0 and ll_pos1=0 then
			if ll_pos>1 then
				ll_imp=long(left(data,ll_pos - 1))
			else 
				ll_imp=0
			end if	
			messagebox('Attenzione','In valuta lire non è possibile inserire cifre decimali')
			this.post setitem(1,'par_aperta_movimento',ll_imp)
			return 2
		end if
	end if
end if		
end event

type dw_mov_partita_scadenze_gd from u_dw_pura within w_par_aperta_partite_gd
int X=27
int Y=820
int Width=2295
int Height=608
int TabOrder=20
string DataObject="d_mov_partita_scadenze_gd"
boolean TitleBar=true
string Title="Scadenze"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event doubleclicked;call super::doubleclicked;

decimal ldc_imp_scadenza

CHOOSE CASE dwo.Name
	CASE "scadenza_data_scadenza", "scadenza_importo_scadenza", "scadenza_saldo"
		uf_proponi_saldo()
END CHOOSE
end event

event editchanged;

CHOOSE CASE string(dwo.name)
	CASE "mov_scadenza_importo"
		
		
		long ll_pos, ll_pos1, ll_imp
  		if il_lire=il_val_reg then
			ll_pos=pos(data,',')
			ll_pos1=pos(data,',00')
			if ll_pos>0 and ll_pos1=0 then
				if ll_pos>1 then
					ll_imp=long(left(data,ll_pos - 1))
				else 
					ll_imp=0
				end if	
				messagebox('Attenzione','In valuta lire non è possibile inserire cifre decimali')
				this.post setitem(1,'mov_scadenza_importo',ll_imp)
				return 2
			end if
		end if
		
		
		dw_mov_partita_partite_gd.Event Post ue_assegna_tot_mov_scad()		
		
END CHOOSE

end event

event getfocus;call super::getfocus;

ii_dw = 2

iuo_msg_log.uf_new_text("Fare doppio click sulla Data o sull'Importo Scadenza per creare un movimento di scadenza.", 3)
iuo_msg_log.uf_new_text("Per cancellare un movimento di scadenza esistente, vuotare il campo 'Importo Movimento'.",3)
end event

event itemchanged;


decimal ldc_tot_mov_scadenza
long ll_CurrRow_Mov_Partita
date ld_null

setnull(ld_null)

CHOOSE CASE string(dwo.name)
	CASE "mov_scadenza_importo"
		IF long(data)=0 or isnull(long(data)) THEN
			dw_mov_partita_scadenze_gd.SetItem(Row, "mov_scadenza_data", ld_null)
			dw_mov_partita_scadenze_gd.SetItem(Row, "mov_scadenza_importo", 0)
			dw_mov_partita_scadenze_gd.SetFocus()				
			ll_CurrRow_Mov_Partita = dw_mov_partita_partite_gd.GetRow()
			ldc_tot_mov_scadenza = dw_mov_partita_scadenze_gd.GetItemDecimal(Row, "tot_mov_scadenza_importo")
			dw_mov_partita_partite_gd.SetItem(ll_CurrRow_Mov_Partita, "par_aperta_movimento", ldc_tot_mov_scadenza)
		END IF			
END CHOOSE

end event

type p_arrow from picture within w_par_aperta_partite_gd
int X=73
int Y=304
int Width=55
int Height=64
boolean Visible=false
boolean BringToTop=true
string PictureName="s:\pb\cometa\arrow.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type cb_1 from commandbutton within w_par_aperta_partite_gd
int X=1189
int Y=40
int Width=421
int Height=84
int TabOrder=70
boolean BringToTop=true
string Text="Scala Acc/Credito"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;openwithparm(w_associa_partite_cx,il_id_conto)

long ll_row
ll_row=message.doubleparm

dw_mov_partita_partite_gd.Retrieve(il_id_conto, il_val_reg)  

dw_mov_partita_scadenze_gd.Retrieve(il_id_conto,il_id_mov_contabile, il_val_reg)  

ll_row = dw_mov_partita_partite_gd.GetRow()

IF ll_row > 0 THEN
	uf_filtra_scadenze(ll_row)
END IF

long ll_nrighe,ll_id_reg_pd,ll_id_par_aperta,i
ll_nrighe=dw_mov_partita_partite_gd.rowcount()
if ll_nrighe<>0 then
	FOR i=1 TO ll_nrighe
		ll_id_par_aperta=dw_mov_partita_partite_gd.getitemnumber(i,"id_par_aperta")
		select id_reg_pd
		into :ll_id_reg_pd
		from par_aperta
		where id_par_aperta=:ll_id_par_aperta;
		dw_mov_partita_partite_gd.setitem(i,"id_reg_pd",ll_id_reg_pd)
	NEXT
end if

	
end event

type cb_deproponi_saldo from commandbutton within w_par_aperta_partite_gd
int X=1646
int Y=40
int Width=334
int Height=84
int TabOrder=70
boolean BringToTop=true
string Text="&Azzera Saldo"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long ll_Curr_Row
integer i
decimal ld_tot_saldo
string ls_dataobject, ls_null
date ld_null

setnull(ld_null)
setnull(ls_null)

ls_dataobject = u_freddie.iudw_current.dataobject

CHOOSE CASE ii_dw
	CASE 1
		ll_Curr_Row = dw_mov_partita_partite_gd.GetRow()
		
		IF ll_Curr_Row > 0 THEN
			dw_mov_partita_partite_gd.SetItem(ll_Curr_Row, "par_aperta_movimento", 0)
			if dw_mov_partita_scadenze_gd.Rowcount()=0 then 
				dw_mov_partita_partite_gd.setitem(ll_Curr_Row, "note", ls_null)
			else
				for i=1 to dw_mov_partita_scadenze_gd.Rowcount()
					dw_mov_partita_scadenze_gd.setitem(i,"mov_scadenza_importo", 0)
				next	
			end if	
			dw_mov_partita_partite_gd.SetFocus()
		END IF

	CASE 2
		ll_Curr_Row = dw_mov_partita_scadenze_gd.GetRow()
		
		IF ll_Curr_Row > 0 THEN
			
			dw_mov_partita_scadenze_gd.SetItem(ll_Curr_Row, "mov_scadenza_data", ld_null)
			dw_mov_partita_scadenze_gd.SetItem(ll_Curr_Row, "mov_scadenza_importo", 0)
				
			dw_mov_partita_scadenze_gd.SetFocus()
				
		   decimal ldc_tot_mov_scadenza
			long ll_CurrRow_Mov_Partita

			ll_CurrRow_Mov_Partita = dw_mov_partita_partite_gd.GetRow()

			IF ll_Curr_Row > 0 THEN
				ldc_tot_mov_scadenza = dw_mov_partita_scadenze_gd.GetItemDecimal(ll_Curr_Row, "tot_mov_scadenza_importo")
			   dw_mov_partita_partite_gd.SetItem(ll_CurrRow_Mov_Partita, "par_aperta_movimento", ldc_tot_mov_scadenza)
			END IF
		END IF
				
END CHOOSE

end event

