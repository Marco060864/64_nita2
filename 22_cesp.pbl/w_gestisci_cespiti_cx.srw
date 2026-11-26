forward
global type w_gestisci_cespiti_cx from window
end type
type dw_3 from udw_base within w_gestisci_cespiti_cx
end type
type cb_1 from commandbutton within w_gestisci_cespiti_cx
end type
type rb_canc_mov from radiobutton within w_gestisci_cespiti_cx
end type
type dw_1 from u_dw_ext_main within w_gestisci_cespiti_cx
end type
type st_3 from statictext within w_gestisci_cespiti_cx
end type
type st_2 from statictext within w_gestisci_cespiti_cx
end type
type st_1 from statictext within w_gestisci_cespiti_cx
end type
type rb_gen_registrazione from radiobutton within w_gestisci_cespiti_cx
end type
type rb_calc_quota from radiobutton within w_gestisci_cespiti_cx
end type
type rb_1 from radiobutton within w_gestisci_cespiti_cx
end type
type dw_2 from u_dw_ext_main within w_gestisci_cespiti_cx
end type
end forward

global type w_gestisci_cespiti_cx from window
integer x = 834
integer y = 365
integer width = 4111
integer height = 1933
boolean titlebar = true
string title = "Gestione calcolo quote ammortamento"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 78748035
dw_3 dw_3
cb_1 cb_1
rb_canc_mov rb_canc_mov
dw_1 dw_1
st_3 st_3
st_2 st_2
st_1 st_1
rb_gen_registrazione rb_gen_registrazione
rb_calc_quota rb_calc_quota
rb_1 rb_1
dw_2 dw_2
end type
global w_gestisci_cespiti_cx w_gestisci_cespiti_cx

forward prototypes
public subroutine uf_calcola_quote ()
public subroutine uf_registra (long af_prof, long af_es, date af_data)
public subroutine uf_agg_cespiti (long rd_id_es, long rd_prof_amm)
end prototypes

public subroutine uf_calcola_quote ();DECIMAL ld_tot,ld_val_acq,ld_perc_amm,ld_perc_rid,ld_perc_ant, ld_residuo
DECIMAL ld_rival, ld_sval, ld_tot_ant, ld_perc_cat, ld_non_amm, ld_promi
LONG ll_id_cespite, ll_righe, ll_mese, ll_es
datastore ds_calcola_cespiti
INTEGER i, ll_anni_amm
STRING ls_tipo_amm
DATE ld_data

ds_calcola_cespiti=create datastore
ds_calcola_cespiti.dataobject="d_calcolo_ammortamento"
ds_calcola_cespiti.settransobject(sqlca)
ll_es=dw_1.getitemnumber(1,'esercizio')

Select data_fine
into :ld_data 
from esercizio
where id_esercizio=:ll_es;

ll_righe=ds_calcola_cespiti.retrieve(ld_data)

IF ll_righe<=0 THEN 
	messagebox("Attenzione!", "Non ho trovato cespiti di cui Calcolare quote!")
	return
end if

FOR i=1 TO ll_righe

	ll_id_cespite=ds_calcola_cespiti.getitemnumber(i, "id_cespite")
	ld_val_acq  =ds_calcola_cespiti.getitemdecimal(i, "valore_acq")
   
	ld_rival    =ds_calcola_cespiti.getitemdecimal(i, "rival_valore")
	if isnull(ld_rival) then ld_rival = 0			
	ld_sval     =ds_calcola_cespiti.getitemdecimal(i, "sval_valore")	
	if isnull(ld_sval) then ld_sval = 0				
	ld_non_amm  =ds_calcola_cespiti.getitemdecimal(i, "imp_non_amm")
	if isnull(ld_non_amm) then ld_non_amm = 0			
	ld_promi    =ds_calcola_cespiti.getitemdecimal(i, "perd_uso_promiscuo")	
	if isnull(ld_promi) then ld_promi = 0		
   
	ld_perc_amm =ds_calcola_cespiti.getitemdecimal(i, "amm_particolare")	
	ld_perc_cat =ds_calcola_cespiti.getitemdecimal(i, "perc_amm_cat_int")
	if isnull(ld_perc_amm) or ld_perc_amm=0 then ld_perc_amm = ld_perc_cat	
	ld_perc_rid =ds_calcola_cespiti.getitemdecimal(i, "perc_primo_amm")
	ld_perc_ant =ds_calcola_cespiti.getitemdecimal(i, "amm_anticipato")
	ll_anni_amm =ds_calcola_cespiti.getitemdecimal(i, "anni_ammortizzati")
   
	ld_val_acq  = ld_val_acq + ld_rival - ld_sval - ld_promi - ld_non_amm
	
	ls_tipo_amm=ds_calcola_cespiti.getitemstring(i, "tipo_ammortamento")
	
	
		IF ll_anni_amm=0 THEN
			ld_tot_ant=0
			ld_tot=(((ld_val_acq*ld_perc_cat)/100)*ld_perc_rid)/100
			
			IF ls_tipo_amm='R' THEN	ld_tot=(ld_tot*ld_perc_rid)/100
			IF ls_tipo_amm='A' THEN ld_tot_ant=(ld_tot*ld_perc_ant)/100		
			
			
		ELSE	
			ld_tot_ant=0
			ld_tot=(ld_val_acq*ld_perc_amm)/100
			IF ls_tipo_amm='R' THEN	ld_tot=(ld_tot*ld_perc_rid)/100
			IF ls_tipo_amm='A' THEN ld_tot_ant=(ld_tot*ld_perc_ant)/100		

		   ld_residuo=ds_calcola_cespiti.getitemdecimal(i, "residuo")	
	
			IF ld_tot>=ld_residuo THEN
				ld_tot=ld_residuo
				ld_tot_ant=0
			ELSEIF (ld_tot + ld_tot_ant)>ld_residuo THEN
				ld_tot_ant=ld_residuo - ld_tot
			END IF
		END IF	
	
	//arrotondo le quote a 2 decimali mm 290807
	ld_tot=round(ld_tot, 2)
	ld_tot_ant=round(ld_tot_ant, 2)
	//fine arrotondamento
	UPDATE cespite SET quota_amm_prev_norm=:ld_tot , 
			 quota_amm_prev_antic=:ld_tot_ant
	WHERE  id_cespite=:ll_id_cespite;
	
	if sqlca.sqlcode=0 then
		COMMIT;
	else
		rollback;
		messagebox("Errore!", "Cespite non salvato!")
	end if
NEXT

DESTROY ds_calcola_cespiti


end subroutine

public subroutine uf_registra (long af_prof, long af_es, date af_data);DECIMAL ld_quota_nor,ld_quota_ant,ld_amm_norm,ld_amm_ant, ld_cambio, ld_fondo
LONG ll_num,ll_valuta,ll_cat_int,ll_reg_pd, ll_num_p, ll_registro
LONG ll_cfondo_ant, ll_cfondo_ord, ll_cquota_ord, ll_cquota_ant, ll_anni 
LONG ll_cespite,ll_prof_norm, ll_prof_ant
INTEGER  li_ret, ll_righe, il_nriga, i
STRING ls_filter
datastore ds_calcola_cespiti


ds_calcola_cespiti=create datastore
ds_calcola_cespiti.dataobject="d_calcolo_ammortamento"
ds_calcola_cespiti.settransobject(sqlca)

ll_righe=ds_calcola_cespiti.retrieve(af_data)

ls_filter="qu_nor<>0 or qu_ant<>0"
ds_calcola_cespiti.setfilter(ls_filter)
ll_righe=ds_calcola_cespiti.filter()

ll_righe=ds_calcola_cespiti.rowcount()

IF ll_righe<=0 THEN RETURN

SELECT R.id_registro INTO :ll_registro	
FROM prof_registrazione P, registro R
WHERE P.id_mod_registro=R.id_mod_registro
AND P.id_prof_registrazione=:af_prof
AND R.id_esercizio=:af_es;
	
SELECT id_valuta INTO :ll_valuta
FROM esercizio WHERE id_esercizio=:af_es;
SELECT parita_euro INTO :ld_cambio
FROM valuta WHERE id_valuta = :ll_valuta;

SELECT max(num_progressivo) INTO :ll_num
FROM reg_pd WHERE id_registro=:ll_registro;
if isnull(ll_num) then ll_num=1

ll_num++

INSERT INTO REG_PD (id_registro,     num_progressivo,
                    data_competenza, data_registrazione,
						  id_valuta,       id_prof_registrazione, 
						  cambio,          descrizione)
	         VALUES (:ll_registro,    :ll_num,
				        :af_data,        :af_data,
						  :ll_valuta,      :af_prof, 
						  :ld_cambio,      'Quota ammortamento');

IF sqlca.sqlcode<>0 THEN
	messagebox("Errore","Si è verificato un errore nel salvattaggio della testa!")
	ROLLBACK;
	RETURN
END IF

COMMIT;

SELECT @@identity
INTO	 :ll_reg_pd 
FROM	 SYS.DUMMY;

il_nriga=0
li_ret=1

FOR i=1 TO ll_righe   			
			
	ld_quota_nor=ds_calcola_cespiti.getitemdecimal(i,'qu_nor')
	ld_quota_ant=ds_calcola_cespiti.getitemdecimal(i,'qu_ant')	
   ll_cat_int  =ds_calcola_cespiti.getitemnumber(i,'id_cat_int_cespite')

	SELECT id_conto_fondo_ant, id_conto_fondo_ord,   
			 id_conto_quota_ord, id_conto_quota_ant  
	INTO   :ll_cfondo_ant, :ll_cfondo_ord,   
		    :ll_cquota_ord, :ll_cquota_ant  
	FROM   cat_int_cespite
	WHERE id_cat_int_cespite=:ll_cat_int;
	
	if ld_quota_nor<>0 then
		il_nriga++
		insert into mov_contabile
		(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,dare)
		values(:ll_reg_pd,:il_nriga,:ll_cquota_ord,:ll_valuta,:ld_cambio,:af_data,:af_data,:ld_quota_nor);
		il_nriga++
		insert into mov_contabile
		(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,avere)
		values(:ll_reg_pd,:il_nriga,:ll_cfondo_ord,:ll_valuta,:ld_cambio,:af_data,:af_data,:ld_quota_nor);
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			li_ret=0
		end if
	end if
	if ld_quota_ant<>0 then 
		il_nriga++
		insert into mov_contabile
		(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,dare)
		values(:ll_reg_pd,:il_nriga,:ll_cquota_ant,:ll_valuta,:ld_cambio,:af_data,:af_data,:ld_quota_ant);
		
		il_nriga++
		insert into mov_contabile
		(id_reg_pd,numero,id_conto,id_valuta,cambio,data_inizio_competenza,data_fine_competenza,avere)
		values(:ll_reg_pd,:il_nriga,:ll_cfondo_ant,:ll_valuta,:ld_cambio,:af_data,:af_data,:ld_quota_ant);
		if sqlca.sqlcode=0 then
			commit;
		else
			rollback;
			li_ret=0
		end if
	end if	
	
NEXT

if li_ret=0 then
	messagebox ('Esecuzione', ' Nessuna scrittura generata!')
	delete from reg_pd
	where id_reg_pd=:ll_reg_pd;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
	end if
else
	SELECT num_progressivo
 	into :ll_num_p
 	from reg_pd
 	where id_reg_pd = :ll_reg_pd;
	messagebox ('Esecuzione', ' E~ stata generata la scrittura n. : ' + string(ll_num))
		

	select id_prof_cespite into :ll_prof_norm
	from prof_cespite where prof_base='N';
	
	select id_prof_cespite into :ll_prof_ant
	from prof_cespite where prof_base='A';
	
	if isnull(ll_prof_norm) or isnull(ll_prof_ant) then 
		messagebox('Attenzione','Non sono stati impostati correttamente le causali registrazione cespiti!')
		return
	end if	
		
	FOR i=1 TO ll_righe   			
		 
		 ld_quota_nor = ds_calcola_cespiti.getitemdecimal(i,'qu_nor')
		 ld_quota_ant = ds_calcola_cespiti.getitemdecimal(i,'qu_ant')
		 ll_cespite   = ds_calcola_cespiti.getitemnumber(i,'id_cespite')

		 insert into mov_cespite
					(id_cespite,id_esercizio,importo,data_mov_cespite,id_reg_pd,id_prof_cespite,id_valuta)
		 values 	(:ll_cespite,:af_es,:ld_quota_nor,:af_data,:ll_reg_pd,:ll_prof_norm,:ll_valuta,);
		
		if sqlca.sqlcode=0 then
			 COMMIT;
		else
			messagebox("Attenzione!", "Mov_cespite ordinario non inserito!")
			rollback;
		end if
			 
		 if ld_quota_ant>0 then
			 insert into mov_cespite
					  (id_cespite,id_esercizio,importo,data_mov_cespite,id_reg_pd,id_prof_cespite,id_valuta)
		 	 values (:ll_cespite,:af_es,:ld_quota_ant,:af_data,:ll_reg_pd,:ll_prof_ant,:ll_valuta); 
		 end if	
		 
		 if sqlca.sqlcode=0 then
			 COMMIT;
		else
			messagebox("Attenzione!", "Mov_cespite anticipato non inserito!")
			rollback;
		end if
		 ld_fondo=ds_calcola_cespiti.getitemdecimal(i,'fondo_amm_norm')
		 if isnull(ld_fondo) then ld_fondo=0
		 ld_fondo=ld_fondo + ld_quota_nor
 		 ds_calcola_cespiti.setitem(i,'fondo_amm_norm',ld_fondo)
     	 	ds_calcola_cespiti.setitem(i,'quota_norm',0)
	
		 ld_fondo=ds_calcola_cespiti.getitemdecimal(i,'fondo_amm_ant')
		 if isnull(ld_fondo) then ld_fondo=0
		 ld_fondo=ld_fondo + ld_quota_ant
		 ds_calcola_cespiti.setitem(i,'fondo_amm_ant',ld_fondo)
		 ds_calcola_cespiti.setitem(i,'quota_antic',0)
		 ll_anni=ds_calcola_cespiti.getitemnumber(i,'anni_ammortizzati')
		 ll_anni=ll_anni+1
		 ds_calcola_cespiti.setitem(i,'anni_ammortizzati',ll_anni)
	
		 if ds_calcola_cespiti.getitemnumber(i,'residuo')<=0 then 
			ds_calcola_cespiti.setitem(i,'stato','E')
		 end if	
	  
	NEXT
		
	li_ret=ds_calcola_cespiti.update()
	
	if li_ret=1 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Cespite non aggiornato!")
	end if
	
end if


end subroutine

public subroutine uf_agg_cespiti (long rd_id_es, long rd_prof_amm);long ll_righe, ll_ii, ll_anni, li_ret
long ll_cespite, ll_row_mov, ll_kk
decimal ld_fondo, ld_acq, ld_ces, ld_inc_val
decimal ld_dec_val, ld_acc_ord, ld_acc_ant
decimal ld_residuo, ld_imp
date ld_data_acq, ld_data_ces, ld_data
date ld_data_inc_val, ld_data_dec_val
long ll_cat_cespite, ll_anni_amm
long ll_causale, ll_anni_storico
char lc_acq, lc_ces, lc_inc_anni, lc_inc_val
char lc_dec_val, lc_acc_ord, lc_acc_ant
string ls_base

datastore ds_calcola_cespiti
datastore ds_mov

ds_calcola_cespiti=create datastore
ds_calcola_cespiti.dataobject="ds_agg_cesp"
ds_calcola_cespiti.settransobject(sqlca)

ll_righe=ds_calcola_cespiti.retrieve()
ll_righe=ds_calcola_cespiti.rowcount()

IF ll_righe<=0 THEN RETURN

FOR ll_ii=1 TO ll_righe   			
	
		  ll_cespite=ds_calcola_cespiti.getitemnumber(ll_ii,'id_cespite')	
		  ll_cat_cespite=ds_calcola_cespiti.getitemnumber(ll_ii,'id_cat_int_cespite')
		  
  		  SETNULL(ld_data_dec_val)
		  SETNULL(ld_data_acq); SETNULL(ld_data)		  
		  SETNULL(ld_data_ces); SETNULL(ld_data_inc_val)
		  SETNULL(lc_acq);      SETNULL(lc_inc_anni)
		  SETNULL(lc_inc_val);  SETNULL(lc_dec_val)
		  SETNULL(lc_acc_ord);  SETNULL(lc_acc_ant)
		  SETNULL(ls_base);     SETNULL(lc_ces)
		  ld_acq=0;             ld_inc_val=0
		  ld_dec_val=0;         ld_ces=0
		  ld_acc_ord=0;         ld_acc_ant=0
		  ld_residuo=0;			ll_anni_amm=0
		  
		  ds_mov=create datastore
		  ds_mov.dataobject="ds_agg_mov"
		  ds_mov.settransobject(sqlca)
		  ll_row_mov=ds_mov.retrieve(ll_cespite)
		  FOR ll_kk=1 TO ll_row_mov   			
			
	         ll_causale=ds_mov.getitemnumber(ll_kk,'id_prof_cespite')
			   SELECT cessione, acquisto, incrementa_anni_utilizzo,
			          incrementi_valore, decrementi_valore,
	  			       accantonamento_ordinario, accantonamento_anticipato, prof_base
  		      INTO :lc_ces, :lc_acq, :lc_inc_anni, :lc_inc_val, :lc_dec_val,
  			        :lc_acc_ord, :lc_acc_ant, :ls_base
 		      FROM prof_cespite WHERE id_prof_cespite=:ll_causale;
				
				ld_imp=ds_mov.getitemdecimal(ll_kk,'importo') 
		      ld_data=ds_mov.getitemdate(ll_kk,'data_mov_cespite')	 
			   IF lc_acq ='S' THEN 
  		         ld_acq = ld_acq + ld_imp
					ld_data_acq=ld_data
				END IF	 	 
				IF lc_ces ='S' THEN 
					ld_ces = ld_ces + ld_imp	 
					ld_data_ces=ld_data
					ds_calcola_cespiti.setitem(ll_ii,'stato','V')
		         ds_calcola_cespiti.setitem(ll_ii,'data_fine_amm',ld_data)
				END IF	 
	 	 		IF lc_inc_val	='S' THEN 
					ld_inc_val = ld_inc_val + ld_imp	  
					ld_data_inc_val=ld_data
				END IF	 
				IF lc_dec_val	='S' THEN 
					ld_dec_val = ld_dec_val + ld_imp	 
					ld_data_dec_val=ld_data
				END IF	 
				IF lc_acc_ord	='S' THEN ld_acc_ord  = ld_acc_ord + ld_imp	  
				IF lc_acc_ant	='S' THEN ld_acc_ant  = ld_acc_ant + ld_imp	
				IF lc_inc_anni='S' THEN 
					IF ls_base='I' THEN 
						ll_anni_storico=ds_mov.getitemnumber(ll_kk,'anni_amm')
						if isnull(ll_anni_storico) then ll_anni_storico=0
						ll_anni_amm = ll_anni_amm + ll_anni_storico
					ELSE	
						ll_anni_amm = ll_anni_amm + 1
					END IF	 
				END IF
		  NEXT
		  ds_calcola_cespiti.setitem(ll_ii,'anni_ammortizzati',ll_anni_amm)
		  ds_calcola_cespiti.setitem(ll_ii,'valore_acq',ld_acq)
		  ds_calcola_cespiti.setitem(ll_ii,'rival_valore',ld_inc_val)
		  ds_calcola_cespiti.setitem(ll_ii,'sval_valore',ld_dec_val)
		  ds_calcola_cespiti.setitem(ll_ii,'alien_valore',ld_ces)
		  ds_calcola_cespiti.setitem(ll_ii,'fondo_amm_norm',ld_acc_ord)
		  ds_calcola_cespiti.setitem(ll_ii,'fondo_amm_ant',ld_acc_ant)
		  ds_calcola_cespiti.setitem(ll_ii,'data_inizio_utilizzo',ld_data_acq)
		  ds_calcola_cespiti.setitem(ll_ii,'alien_data',ld_data_ces)
		  ds_calcola_cespiti.setitem(ll_ii,'rival_data',ld_data_inc_val)
		  ds_calcola_cespiti.setitem(ll_ii,'sval_data',ld_data_dec_val)
		  ld_residuo=ds_calcola_cespiti.getitemdecimal(ll_ii,'residuo')
		  if ld_residuo<=0 then 
			  ds_calcola_cespiti.setitem(ll_ii,'stato','U')
		  end if	
		 
        DESTROY ds_mov
NEXT
		
li_ret=ds_calcola_cespiti.update()

if li_ret=1 then
	commit;
else
	rollback;
	messagebox("Errore!", "Cespite non aggiornato!")
end if

end subroutine

on w_gestisci_cespiti_cx.create
this.dw_3=create dw_3
this.cb_1=create cb_1
this.rb_canc_mov=create rb_canc_mov
this.dw_1=create dw_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.rb_gen_registrazione=create rb_gen_registrazione
this.rb_calc_quota=create rb_calc_quota
this.rb_1=create rb_1
this.dw_2=create dw_2
this.Control[]={this.dw_3,&
this.cb_1,&
this.rb_canc_mov,&
this.dw_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.rb_gen_registrazione,&
this.rb_calc_quota,&
this.rb_1,&
this.dw_2}
end on

on w_gestisci_cespiti_cx.destroy
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.rb_canc_mov)
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_gen_registrazione)
destroy(this.rb_calc_quota)
destroy(this.rb_1)
destroy(this.dw_2)
end on

event open;LONG ll_es, ll_prof_reg
STRING ls_stato, ls_cod, ls_des

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
dw_3.settransobject(sqlca)

dw_1.insertrow(1)
dw_2.insertrow(1)

datawindowchild ldc_es
dw_1.getchild('esercizio',ldc_es)
ldc_es.settransobject(sqlca)
ldc_es.retrieve()

SELECT min(id_esercizio) INTO :ll_es FROM esercizio where stato_cespite='N' or stato_cespite='C';

dw_1.setitem(1,'esercizio',ll_es)

SELECT id_prof_registrazione INTO :ll_prof_reg
FROM prof_cespite WHERE prof_base='N';

SELECT codice, descrizione INTO :ls_cod, :ls_des
FROM prof_registrazione WHERE id_prof_registrazione=:ll_prof_reg;

dw_2.setitem(1,'profilo',ll_prof_reg)
dw_2.setitem(1,'prof_reg_cod',ls_cod)
dw_2.setitem(1,'prof_reg_des',ls_des)

SELECT stato_cespite INTO :ls_stato
FROM esercizio WHERE id_esercizio=:ll_es;


CHOOSE CASE ls_stato
	CASE 'N'
		rb_calc_quota.enabled=TRUE
		rb_gen_registrazione.enabled=FALSE
		dw_2.visible=FALSE
		rb_canc_mov.enabled=FALSE	
	CASE 'C'
		dw_2.visible=TRUE	
		rb_calc_quota.enabled=TRUE
		rb_gen_registrazione.enabled=TRUE
		rb_canc_mov.enabled=FALSE	
	CASE 'D'
		Messagebox("'Attenzione","Per l'esercizio selezionato sono già state generate~r~nle registrazioni di ammortamento")
		rb_calc_quota.enabled=FALSE
		rb_gen_registrazione.enabled=FALSE
		rb_canc_mov.enabled=TRUE		
		dw_2.visible=FALSE		
END CHOOSE


end event

type dw_3 from udw_base within w_gestisci_cespiti_cx
integer x = 29
integer y = 742
integer width = 3979
integer height = 1024
integer taborder = 50
string dataobject = "d_cancella_mov_cespite"
end type

type cb_1 from commandbutton within w_gestisci_cespiti_cx
integer x = 293
integer y = 307
integer width = 501
integer height = 90
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancella Movimenti"
end type

event clicked;long ll_id_es, ll_righe,ll_id_nor, i
datastore ds_cancella_mov
date ldt_data_mov

if Messagebox('Information!','Procedere con la cancellazione?',Question!,yesno!)<>1 then
	return
end if	

ll_id_es=dw_1.getitemnumber(1,'esercizio')
select data_fine
into :ldt_data_mov
from dba.esercizio
where id_esercizio=:ll_id_es;
ds_cancella_mov=create datastore
ds_cancella_mov.dataobject="d_cancella_mov_cespite"
ds_cancella_mov.settransobject(sqlca)
ll_righe=ds_cancella_mov.retrieve(ldt_data_mov)
if ll_righe>0 then
	ds_cancella_mov.rowscopy(1, ll_righe, primary!, dw_3, 1, primary!)
	ds_cancella_mov.rowsmove(1, ll_righe, primary!, ds_cancella_mov, 1, delete!)

	if ds_cancella_mov.update()=1 then
		commit;
		Select id_prof_cespite into :ll_id_nor from prof_cespite where prof_base='N';
		uf_agg_cespiti(ll_id_es,ll_id_nor)
		update esercizio set stato_cespite='N' where id_esercizio=:ll_id_es;
		Messagebox('Information!','Cancellazione terminata')
	else
		rollback;
		Messagebox('Information!','Cancellazione NON Riuscita')
	end if
else
	Messagebox('Information!','Nessuna Riga da cancellare!')
end if



destroy ds_cancella_mov
end event

type rb_canc_mov from radiobutton within w_gestisci_cespiti_cx
integer x = 998
integer y = 288
integer width = 728
integer height = 77
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Cancellazione scritture"
end type

event clicked;long ll_id_es, ll_id_ant, ll_id_nor, ll_righe
long ll_reg, ll_prog, ll_mov[]
date ld_data_reg
string ls_cod_ces, ls_des_ces
integer ii, kk
datastore ds_cancella_mov

if Messagebox('Information!','Procedere con la cancellazione?',Question!,yesno!)<>1 then
	rb_canc_mov.enabled=TRUE
	rb_canc_mov.Checked =FALSE
	return
end if	

ll_id_es=dw_1.getitemnumber(1,'esercizio')

ds_cancella_mov=create datastore
ds_cancella_mov.dataobject="d_cancella_mov_cespite"
ds_cancella_mov.settransobject(sqlca)
ll_righe=ds_cancella_mov.retrieve(ll_id_es)
if ll_righe>0 then
	ds_cancella_mov.rowsmove(1, ll_righe, primary!, ds_cancella_mov, 1, delete!)
	if ds_cancella_mov.update()=1 then
		commit;
	else
		rollback;
	end if
end if

Select id_prof_cespite into :ll_id_ant from prof_cespite where prof_base='A';
Select id_prof_cespite into :ll_id_nor from prof_cespite where prof_base='N';



DECLARE mov_cur CURSOR FOR 
        Select id_reg_pd, id_mov_cespite, data_mov_cespite from mov_cespite 
		  where (id_prof_cespite=:ll_id_ant 
		  or id_prof_cespite=:ll_id_nor)
		  and id_esercizio=:ll_id_es;
OPEN mov_cur;
ii=1
FETCH mov_cur INTO :ll_reg, :ll_mov[ii], :ld_data_reg;
DO WHILE sqlca.sqlcode=0 
	ii=ii + 1
	select num_progressivo, data_registrazione 
	into :ll_prog, :ld_data_reg
	from reg_pd where id_reg_pd=:ll_reg;
	if sqlca.sqlcode=0 then
		messagebox('Attenzione!','Prima di procedere con la cancellazione dei movimewnti,~n~r'& 
		+" è necessario cancellare tutte le registrazioni di ammortamento nell'anno selezionato.~n~r"&
		+"Controllare registrazione num. "+string(ll_prog) + " del "+string(ld_data_reg) )
		messagebox('Attenzione!','Cancellazione abortita!')
		return
	end if	
	FETCH mov_cur INTO :ll_reg, :ll_mov[ii], :ld_data_reg;
LOOP

CLOSE mov_cur;

For kk=1 to ii - 1
	 delete mov_cespite where id_mov_cespite=:ll_mov[kk];
	 if sqlca.sqlcode=0 then 
		 commit;
	 else	
		 select c.codice, c.descrizione into :ls_cod_ces, :ls_des_ces
		 from cespite c, mov_cespite m where c.id_cespite=m.id_cespite 
		 and m.id_mov_cespite=:ll_mov[kk];
		 messagebox('Attenzione!','Cancellazione fallita per il cespite '+ls_cod_ces+' '+ls_des_ces +'~n~r'&
		           +sqlca.sqlerrtext)
	    rollback;
	 end if	 
Next	 

uf_agg_cespiti(ll_id_es,ll_id_nor)

update esercizio set stato_cespite='N' where id_esercizio=:ll_id_es;
Messagebox('Information!','Cancellazione terminata')


CLOSE(PARENT)
end event

type dw_1 from u_dw_ext_main within w_gestisci_cespiti_cx
integer x = 26
integer y = 19
integer width = 2011
integer height = 144
integer taborder = 10
string dataobject = "d_es_cespite_lt"
end type

event getfocus;
end event

event itemchanged;long ll_es, ll_es_def
date ld_data
string ls_stato

IF dwo.name='esercizio' THEN
	
	select max(data_inizio) into :ld_data
	from esercizio where stato_cespite='D';

	select id_esercizio into :ll_es_def
	from esercizio where data_inizio=:ld_data;

	ll_es=long(data)
	
	IF ll_es_def>ll_es then 
		Messagebox("'Attenzione","Esiste un esercizio successivo dove sono già state generate~r~nle registrazioni di ammortamento")
		rb_calc_quota.enabled=FALSE
		rb_gen_registrazione.enabled=FALSE
		dw_2.visible=FALSE		
	ELSE				
		SELECT stato_cespite INTO :ls_stato
		FROM esercizio WHERE id_esercizio=:ll_es;
		if isnull(ls_stato) then ls_stato="C"
		CHOOSE CASE ls_stato
			CASE 'N'
				rb_calc_quota.enabled=TRUE
				rb_gen_registrazione.enabled=FALSE
				dw_2.visible=FALSE
				rb_canc_mov.enabled=FALSE	
			CASE 'C'
				dw_2.visible=TRUE	
				rb_calc_quota.enabled=TRUE
				rb_gen_registrazione.enabled=TRUE
				rb_canc_mov.enabled=FALSE	
			CASE 'D'
				Messagebox("'Attenzione","Per l'esercizio selezionato sono già state generate~r~nle registrazioni di ammortamento")
				rb_calc_quota.enabled=FALSE
				rb_gen_registrazione.enabled=FALSE
				rb_canc_mov.enabled=TRUE
				dw_2.visible=FALSE		
		END CHOOSE
	END IF
END IF
end event

type st_3 from statictext within w_gestisci_cespiti_cx
integer x = 1064
integer y = 208
integer width = 998
integer height = 77
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Generazione scritture Ammortamento"
boolean focusrectangle = false
end type

type st_2 from statictext within w_gestisci_cespiti_cx
integer x = 113
integer y = 208
integer width = 786
integer height = 77
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Calcolo quote Ammortamento"
boolean focusrectangle = false
end type

type st_1 from statictext within w_gestisci_cespiti_cx
boolean visible = false
integer x = 168
integer y = 154
integer width = 1020
integer height = 77
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Calcolo del Plafond  "
boolean focusrectangle = false
end type

type rb_gen_registrazione from radiobutton within w_gestisci_cespiti_cx
integer x = 976
integer y = 205
integer width = 69
integer height = 77
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean lefttext = true
end type

event clicked;DATE ld_data
LONG ll_prof, ll_es

if messagebox('Attenzione','Procedere la creazione della registrazione?',Question!,yesno!)=1 then
	ld_data=dw_2.getitemdate(1,'data_c')
	ll_prof=dw_2.getitemnumber(1,'profilo')
	ll_es  =dw_1.getitemnumber(1,'esercizio')

	IF ISNULL(ld_data) or ISNULL(ll_prof) THEN 
		messagebox('Attenzione','Prima di procedere inserire la data di registrazione e il profilo!')
	
		this.checked=false
		RETURN
	END IF
	
	UF_REGISTRA(ll_prof,ll_es,ld_data)
	
	UPDATE esercizio 
	SET stato_cespite='D' 
	WHERE id_esercizio=:ll_es;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Stato cespite in Esercizio non salvato!")
	end if
end if
CLOSE(PARENT)
end event

type rb_calc_quota from radiobutton within w_gestisci_cespiti_cx
integer x = 26
integer y = 205
integer width = 69
integer height = 77
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 78748035
boolean enabled = false
boolean lefttext = true
end type

event clicked;LONG ll_es
ll_es=dw_1.getitemnumber(1,'esercizio')

if messagebox('Attenzione','Procedere con il calcolo QUOTE?',Question!,yesno!)=1 then
	UF_CALCOLA_QUOTE()
	dw_2.visible=TRUE
	this.enabled=FALSE
	rb_gen_registrazione.enabled=TRUE
	
	UPDATE esercizio SET stato_cespite='C' WHERE id_esercizio=:ll_es;
	if sqlca.sqlcode=0 then
		commit;
	else
		rollback;
		messagebox("Errore!", "Stato cespite in Esercizio non salvato!")
	end if
else
	this.checked=FALSE
end if	
end event

type rb_1 from radiobutton within w_gestisci_cespiti_cx
boolean visible = false
integer x = 146
integer y = 128
integer width = 66
integer height = 77
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean lefttext = true
end type

event clicked;open (w_plafond_ff)
rb_calc_quota.enabled = true
rb_1.enabled = false
end event

type dw_2 from u_dw_ext_main within w_gestisci_cespiti_cx
integer x = 40
integer y = 419
integer width = 2011
integer height = 301
integer taborder = 40
string dataobject = "d_registrazione_cespite_ff"
end type

event itemchanged;string   	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long 		 	ll_ok

ls_sql_cond = ""

CHOOSE CASE string(dwo.name)

	CASE 'prof_reg_cod'
		ls_sql_cond = ''		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "da_cod_des"
		ll_ok = uf_autofind_col(dwo.Name, "registro", "codice", "A", data, ls_sql_cond, 2, ls_dbc, ls_dbv, ls_dwc)
								
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	
	
	CASE 'prif_reg_des'
		ls_sql_cond = ''		
		ls_dbc[1] = "codice"
		ls_dwc[1] = "da_cod"
		ls_dbc[2] = "descrizione"
		ls_dwc[2] = "da_cod_des"
		ll_ok = uf_autofind_col(dwo.Name, "registro", "descrizione", "A", data, ls_sql_cond, 2, ls_dbc, ls_dbv, ls_dwc)
				
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF	

END CHOOSE

end event

event ue_set_search;long ll_id_mod_reg
CHOOSE CASE as_nomecol
	CASE "prof_reg_cod"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = 'codice'
		is_ricpar.b_imm_retrieve  = TRUE
	CASE "prof_reg_des"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = 'descrizione'
		is_ricpar.b_imm_retrieve  = TRUE
END CHOOSE

end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "prof_reg_cod"
      uf_set_colval("profilo", is_ricpar.s_id_seg_value[1])
      uf_set_colval("prof_reg_cod", is_ricpar.s_main_value)
      uf_set_colval("prof_reg_des", is_ricpar.s_ausil_value[1])
	 CASE"prof_reg_des"
      uf_set_colval("profilo", is_ricpar.s_id_seg_value[1])
      uf_set_colval("prof_reg_des", is_ricpar.s_main_value)
      uf_set_colval("prof_reg_cod", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

event getfocus;
end event

