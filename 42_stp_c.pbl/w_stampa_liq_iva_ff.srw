forward
global type w_stampa_liq_iva_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_stampa_liq_iva_ff
end type
type cb_annulla from commandbutton within w_stampa_liq_iva_ff
end type
type dw_1 from u_dw_ext_main within w_stampa_liq_iva_ff
end type
type st_1 from statictext within w_stampa_liq_iva_ff
end type
end forward

global type w_stampa_liq_iva_ff from w_wiz_main
integer y = 437
integer width = 1897
integer height = 1360
string title = "Stampa Liquidazione Iva"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
st_1 st_1
end type
global w_stampa_liq_iva_ff w_stampa_liq_iva_ff

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE
boolean lb_ges_periodo
date ld_ist_inizio
date  ld_ist_fine

datawindowchild  ldw_registro

end variables

forward prototypes
public function string uf_controlla_dati ()
public function string uf_controllo_recupero ()
public subroutine uf_blocca_dati ()
public subroutine uf_sblocca_dati ()
public subroutine uf_conferma_stampa ()
public subroutine uf_aggiorna_riepiloghi_iva (s_liq_iva ls_liq_iva)
end prototypes

public function string uf_controlla_dati ();


long ll_id_esercizio, ll_id_attivita 
date ld_data_in, ld_data_fin
string ls_ret, ls_flag, ls_st_liquidazione

ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
ld_data_in=dw_1.getitemdate(1,"d_in")
ld_data_fin=dw_1.getitemdate(1,"d_fin")

ls_ret='OK'

DECLARE ws_liquidazione_cur CURSOR FOR
  SELECT "ws_liquidazione_iva"."st_liquidazione"  
    FROM "ws_liquidazione_iva",   
         "attivita",   
         "azienda",   
         "par_sistema"  
   WHERE ( "ws_liquidazione_iva"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_azienda" = "par_sistema"."id_azienda" ) and  
         ( "ws_liquidazione_iva"."id_esercizio" = :ll_id_esercizio ) AND  
         ( "ws_liquidazione_iva"."id_attivita" = :ll_id_attivita ) AND  
         ( ( "ws_liquidazione_iva"."data_comp_liq_iva" >= :ld_data_in ) AND  
         ( "ws_liquidazione_iva"."data_comp_liq_iva" <= :ld_data_fin ) ) AND  
         "azienda"."id_azienda" = 1;

OPEN ws_liquidazione_cur;

FETCH ws_liquidazione_cur INTO :ls_st_liquidazione;

DO WHILE sqlca.sqlcode=0
	IF ls_st_liquidazione<>'N' THEN
	   ls_ret='KO'
   END IF
	FETCH ws_liquidazione_cur INTO :ls_st_liquidazione;
LOOP

CLOSE ws_liquidazione_cur;


return ls_ret
end function

public function string uf_controllo_recupero ();


long ll_id_esercizio, ll_id_attivita,ll_tot_righe
date ld_data_in, ld_data_fin
string ls_ret, ls_flag, ls_st_liquidazione,ls_stampato

ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
ld_data_in=dw_1.getitemdate(1,"d_in")
ld_data_fin=dw_1.getitemdate(1,"d_fin")


  SELECT max("ws_liquidazione_iva"."st_liquidazione"  )
    INTO :ls_stampato
    FROM "ws_liquidazione_iva",   
         "attivita",   
         "azienda",   
         "par_sistema"  
   WHERE ( "ws_liquidazione_iva"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_azienda" = "par_sistema"."id_azienda" ) and  
         ( "ws_liquidazione_iva"."id_esercizio" = :ll_id_esercizio ) AND  
         ( "ws_liquidazione_iva"."id_attivita" = :ll_id_attivita ) AND  
         ( ( "ws_liquidazione_iva"."data_comp_liq_iva" >= :ld_data_in ) AND  
         ( "ws_liquidazione_iva"."data_comp_liq_iva" <= :ld_data_fin ) ) AND  
         "azienda"."id_azienda" = 1  
			USING SQLCA;  

IF ls_stampato='N'  THEN 
	ls_ret='OK'
elseif ls_stampato='' or isnull(ls_STAMPATO) THEN
	ls_ret="OO" 
ELSE
   ls_ret='KO'
END IF

return ls_ret

end function

public subroutine uf_blocca_dati ();


long ll_id_esercizio, ll_id_attivita, ll_id_reg_pd 
date ld_data_in, ld_data_fin
string ls_st_liquidazione

ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
ld_data_in=dw_1.getitemdate(1,"d_in")
ld_data_fin=dw_1.getitemdate(1,"d_fin")


DECLARE ws_liquidazione_cur CURSOR FOR

  SELECT "ws_liquidazione_iva"."id_reg_pd"
    FROM "ws_liquidazione_iva",   
         "attivita",   
         "azienda",   
         "par_sistema"  
   WHERE ( "ws_liquidazione_iva"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_azienda" = "par_sistema"."id_azienda" ) and  
         ( "ws_liquidazione_iva"."id_esercizio" = :ll_id_esercizio ) AND  
         ( "ws_liquidazione_iva"."id_attivita" = :ll_id_attivita ) AND  
         ( ( "ws_liquidazione_iva"."data_comp_liq_iva" >= :ld_data_in ) AND  
         ( "ws_liquidazione_iva"."data_comp_liq_iva" <= :ld_data_fin ) ) AND  
         "azienda"."id_azienda" = 1 AND  
         "ws_liquidazione_iva"."st_liquidazione" = 'N'; 

OPEN ws_liquidazione_cur;

FETCH ws_liquidazione_cur INTO :ll_id_reg_pd ;

DO WHILE sqlca.sqlcode=0
	IF sqlca.sqlcode=0 THEN
      UPDATE reg_pd
		   SET st_liquidazione='I'
		 WHERE id_reg_pd=:ll_id_reg_pd;
   END IF
	FETCH ws_liquidazione_cur INTO :ll_id_reg_pd ;
LOOP

CLOSE ws_liquidazione_cur;


end subroutine

public subroutine uf_sblocca_dati ();


long ll_id_esercizio, ll_id_attivita, ll_id_reg_pd 
date ld_data_in, ld_data_fin
string ls_st_liquidazione

ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
ld_data_in=dw_1.getitemdate(1,"d_in")
ld_data_fin=dw_1.getitemdate(1,"d_fin")


DECLARE ws_liquidazione_cur CURSOR FOR

  SELECT "ws_liquidazione_iva"."id_reg_pd"
    FROM "ws_liquidazione_iva",   
         "attivita",   
         "azienda",   
         "par_sistema"  
   WHERE ( "ws_liquidazione_iva"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_azienda" = "par_sistema"."id_azienda" ) and  
         ( "ws_liquidazione_iva"."id_esercizio" = :ll_id_esercizio ) AND  
         ( "ws_liquidazione_iva"."id_attivita" = :ll_id_attivita ) AND  
         ( ( "ws_liquidazione_iva"."data_comp_liq_iva" >= :ld_data_in ) AND  
         ( "ws_liquidazione_iva"."data_comp_liq_iva" <= :ld_data_fin ) ) AND  
         "azienda"."id_azienda" = 1 AND  
         "ws_liquidazione_iva"."st_liquidazione" = 'I'; 

OPEN ws_liquidazione_cur;

FETCH ws_liquidazione_cur INTO :ll_id_reg_pd ;

DO WHILE sqlca.sqlcode=0
	IF sqlca.sqlcode=0 THEN
      UPDATE reg_pd
		   SET st_liquidazione='N'
		 WHERE id_reg_pd=:ll_id_reg_pd;
   END IF
	FETCH ws_liquidazione_cur INTO :ll_id_reg_pd ;
LOOP

CLOSE ws_liquidazione_cur;

end subroutine

public subroutine uf_conferma_stampa ();


long ll_id_esercizio, ll_id_attivita, ll_id_reg_pd 
date ld_data_in, ld_data_fin
string ls_st_liquidazione

ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
ld_data_in=dw_1.getitemdate(1,"d_in")
ld_data_fin=dw_1.getitemdate(1,"d_fin")


DECLARE ws_liquidazione_cur CURSOR FOR

  SELECT "ws_liquidazione_iva"."id_reg_pd"
    FROM "ws_liquidazione_iva",   
         "attivita",   
         "azienda",   
         "par_sistema"  
   WHERE ( "ws_liquidazione_iva"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_attivita" = "attivita"."id_attivita" ) and  
         ( "azienda"."id_azienda" = "par_sistema"."id_azienda" ) and  
         ( "ws_liquidazione_iva"."id_esercizio" = :ll_id_esercizio ) AND  
         ( "ws_liquidazione_iva"."id_attivita" = :ll_id_attivita ) AND  
         ( ( "ws_liquidazione_iva"."data_comp_liq_iva" >= :ld_data_in ) AND  
         ( "ws_liquidazione_iva"."data_comp_liq_iva" <= :ld_data_fin ) ) AND  
         "azienda"."id_azienda" = 1 AND  
         "ws_liquidazione_iva"."st_liquidazione" = 'I'; 
			
			
			

end subroutine

public subroutine uf_aggiorna_riepiloghi_iva (s_liq_iva ls_liq_iva);

decimal ld_interessi, ld_iva_credito, ld_iva_debito, ld_acconto, ld_plafond_diff
decimal ld_attuale_plafond, ld_per_prorata
date ld_fino_data, ld_data_inizio_esercizio, ld_data_sistema
long ll_id_attivita, ll_id_esercizio
integer li_anno, li_mese, li_trimestre
string ls_tipo_liq 

ld_plafond_diff=ls_liq_iva.plafond_diff
if ld_plafond_diff=0 then 
	setnull(ld_plafond_diff) 
   messagebox("E","il plafond_diff è nullo")
end if

ld_interessi=ls_liq_iva.interessi
if ld_interessi=0 then setnull(ld_interessi) 

ld_iva_credito=ls_liq_iva.iva_credito
if ld_iva_credito=0 then setnull(ld_iva_credito)

ld_iva_debito=ls_liq_iva.iva_debito
if ld_iva_debito=0 then setnull(ld_iva_debito)

ld_per_prorata=ls_liq_iva.per_prorata
if ld_per_prorata=0 then setnull(ld_per_prorata)

ld_fino_data=dw_1.getitemdate(1,"d_fin")

UPDATE par_sistema
   SET ult_data_liquidazione=:ld_fino_data;

ld_acconto=0 

ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
SELECT data_inizio
  INTO :ld_data_inizio_esercizio
  FROM esercizio
 WHERE id_esercizio=:ll_id_esercizio;

li_anno=integer(year(ld_data_inizio_esercizio))

ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
SELECT liq_iva, attuale_plafond
  INTO :ls_tipo_liq, :ld_attuale_plafond
  FROM attivita
 WHERE id_attivita=:ll_id_attivita;

IF ls_tipo_liq='M' THEN
   li_mese=integer(month(ld_fino_data))
	setnull(li_trimestre)
END IF

IF ls_tipo_liq='T' THEN
   li_mese=integer(month(ld_fino_data))
	if li_mese=3  then li_trimestre=1
   if li_mese=6  then li_trimestre=2
	if li_mese=9  then li_trimestre=3
	if li_mese=12 then li_trimestre=4
	setnull(li_mese)
END IF

ld_data_sistema=today()

ld_attuale_plafond=ld_attuale_plafond - ld_plafond_diff



    INSERT INTO "riep_iva"  
         ( "id_attivita",   
           "anno",   
           "acconto",   
           "id_azienda",   
           "mese",   
           "trimestre",   
           "iva_credito",   
           "iva_debito",   
           "data_liq",   
           "interessi_trim",   
           "ultima_liq" ,
			  "plafond",
			  "per_prorata")  
  VALUES ( :ll_id_attivita,   
           :li_anno,   
           :ld_acconto,   
           1,   
           :li_mese,   
           :li_trimestre,   
           :ld_iva_credito,   
           :ld_iva_debito,   
           :ld_data_sistema,   
           :ld_interessi,   
           :ld_fino_data,
			  :ld_attuale_plafond,
			  :ld_per_prorata)  ;
			  



UPDATE attivita
   SET attuale_plafond=:ld_plafond_diff
 WHERE id_attivita=:ll_id_attivita;
end subroutine

on w_stampa_liq_iva_ff.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_1
end on

on w_stampa_liq_iva_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;call super::open;

long ll_id_attivita,  ll_registro, a
decimal ll_acconto, ll_cred_iva, ll_cred_imposta
string ls_data_fine, ls_liq_iva
integer li_mese, li_anno, li_ret
lb_ges_periodo=false
a=0
datawindowchild ldw_id_esercizio, ldw_attivita, ldw_attivita_1,  ldw_attivita_2


dw_1.getchild("id_esercizio",ldw_id_esercizio)
ldw_id_esercizio.settransobject(sqlca)
ldw_id_esercizio.retrieve()

dw_1.getchild("id_attivita",ldw_attivita)
ldw_attivita.settransobject(sqlca)
ldw_attivita.retrieve()

dw_1.getchild("id_attivita_1",ldw_attivita_1)
ldw_attivita_1.settransobject(sqlca)
ldw_attivita_1.retrieve()


dw_1.getchild("id_attivita_2",ldw_attivita_2)
ldw_attivita_2.settransobject(sqlca)
ldw_attivita_2.retrieve()


IF dw_1.GetRow() = 0 THEN
	dw_1.InsertRow(0)
END IF

long ll_id_esercizio_proposto

  SELECT "azienda"."id_esercizio_proposto", 
         "azienda"."id_attivita"
	 INTO :ll_id_esercizio_proposto,:ll_id_attivita
    FROM "azienda"  
   WHERE "azienda"."id_azienda" = 1   ;
	
dw_1.getchild("registro",ldw_registro)
ldw_registro.settransobject(sqlca)
ldw_registro.retrieve(ll_id_esercizio_proposto)	
  select id_registro
  into :ll_registro
  from registro
  where id_azienda = 1 and  id_esercizio=:ll_id_esercizio_proposto and numero=1 and tipo_registro='IV';
	

  SELECT "attivita"."liq_iva"
	 INTO :ls_liq_iva
    FROM "attivita" 
   WHERE "attivita"."id_attivita" = :ll_id_attivita   ;

  SELECT max(ultima_liq)   
    INTO :ld_ist_inizio
    FROM riep_iva
    WHERE id_azienda=1 ;
	
	if isnull(ld_ist_inizio) then
		select data_inizio
		into :ld_ist_inizio
		from esercizio
	   where id_esercizio=:ll_id_esercizio_proposto;
		a=1
	end if
	 
	
	SELECT acconto, iva_credito, credito_imposta   
   INTO :ll_acconto, :ll_cred_iva, :ll_cred_imposta
   FROM riep_iva  
   WHERE id_azienda= 1 and ultima_liq=:ld_ist_inizio;
	

   if a=0 then ld_ist_inizio=RelativeDate(ld_ist_inizio,1) 

IF ls_liq_iva='M' THEN
	li_mese=integer(month(ld_ist_inizio))
	li_anno=integer(year(ld_ist_inizio))
	li_ret=f_gmese(li_mese,li_anno)
	ls_data_fine=string(li_ret)+"/"+string(integer(month(ld_ist_inizio)))+"/"+ &
					 string(integer(year(ld_ist_inizio)))
	ld_ist_fine=date(ls_data_fine)
       ELSE
          li_mese=integer(month(ld_ist_inizio))+2
			 li_anno=integer(year(ld_ist_inizio))
          li_ret=f_gmese(li_mese,li_anno)
			 ls_data_fine=string(li_ret)+"/"+string(li_mese)+"/"+ &
				           string(integer(year(ld_ist_inizio)))
			 ld_ist_fine=date(ls_data_fine)
END IF

dw_1.setitem(1,"id_esercizio",ll_id_esercizio_proposto)
dw_1.setitem(1,"id_attivita",ll_id_attivita)
dw_1.setitem(1,"d_in",ld_ist_inizio)
dw_1.setitem(1,"d_fin",ld_ist_fine)
dw_1.setitem(1,"acconto",ll_acconto)
dw_1.setitem(1,"credito_periodo",ll_cred_iva)
dw_1.setitem(1,"credito_imposta",ll_cred_imposta)
dw_1.setitem(1,"registro",ll_registro)

	


end event

event closequery;call super::closequery;

end event

type cb_ok from commandbutton within w_stampa_liq_iva_ff
event clicked pbm_bnclicked
integer x = 50
integer y = 36
integer width = 270
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
boolean default = true
end type

event clicked;

string ls_flag, ls_ret, ls_avanti, ls_st_def_prov
integer li_rispo, li_rispo1, ls_rispok
long ll_st_reg_iva, ll_st_reg_iva_regpd, ll_id_esercizio, ll_id_attivita, ll_registro, ll_pag_usate, ll_num_pag
date ld_data_in, ld_data_fin,ldt_ult_data
decimal{4} c_imposta,c_periodo
s_param1 ls_param
dw_1.accepttext()
ls_param.id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
ls_param.id_attivita=dw_1.getitemnumber(1,"id_attivita")
ls_param.data_in=dw_1.getitemdate(1,"d_in")
ls_param.data_fin=dw_1.getitemdate(1,"d_fin")
ls_param.acconto=dw_1.getitemnumber(1,"acconto")
ls_param.c_imposta=dw_1.getitemdecimal(1,"credito_imposta")
ls_param.c_periodo=dw_1.getitemdecimal(1,"credito_periodo")
ls_param.ges_periodo=lb_ges_periodo
ls_param.las_aghi=dw_1.getitemstring(1,'tipo_stp')
ll_registro=dw_1.getitemnumber(1,"registro")

ls_param.dich_per = dw_1.getitemstring(1,'dich_per') 

	date ld_data_inizio, ld_data_fine
	integer li_rif, li_rif2
	string ls_liqiva
	
   ll_id_attivita = dw_1.getitemnumber(1,"id_attivita")
	
	
   SELECT "attivita"."liq_iva"
	  INTO :ls_liqiva
     FROM "attivita" 
    WHERE "attivita"."id_attivita" = :ll_id_attivita   ;

   ld_data_inizio = dw_1.getitemdate(1,"d_in")
	ld_data_fine   = dw_1.getitemdate(1,"d_fin")
	
	
   
   IF ls_liqiva='M' THEN
	   li_rif=integer(month(ld_data_inizio))
	ELSE
		li_rif2=integer(month(ld_data_inizio))
		if li_rif2 >= 1 and li_rif2  <= 3 then li_rif  = 1
		if li_rif2 >= 4 and li_rif2  <= 6 then li_rif  = 2
		if li_rif2 >= 7 and li_rif2  <= 9 then li_rif  = 3		
		if li_rif2 >= 10 and li_rif2 <= 12 then li_rif = 4
   END IF
ls_param.rif_dich=string(li_rif)
ls_param.tipo_dich=ls_liqiva


ls_flag=dw_1.getitemstring(1,"flag")
ls_avanti='S'
ls_st_def_prov = 'N'

if ls_flag='S' and not isnull(ls_flag) then
	ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
	ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
	ld_data_in=dw_1.getitemdate(1,"d_in")
	ld_data_fin=dw_1.getitemdate(1,"d_fin")
	


	
	
	
	
		
			
			select max(ultima_data)
			into :ldt_ult_data
			from contatori_registri;
			
		
		if ldt_ult_data<ld_data_fin or isnull(ldt_ult_data) then
				li_rispo1=messagebox("Controllo","Attenzione,~ni Registri Iva non risultano stampati.~nProcedo con la stampa non definitiva?",&
	                      question!,yesno!,1)
				if li_rispo1=1 then 
					ls_flag='N'
					ls_avanti='S'
				else
					ls_avanti='N'
				end if
			end if
		else
			
			
		end if
	





IF LS_AVANTI='S' THEN
	
	
	open(w_attesa)
	ls_ret=uf_controllo_recupero()
	if ls_ret="OO" then 
		close(w_attesa)
		messagebox("Controllo","Nessun movimento rilevato nel periodo selezionato")
		return
	end if

		 
	
	
	
	
	
	
	

		ls_param.flag='N'
	
	
	
	
	
	string ls_tipo_liq_iva, ls_mese
	integer li_trimestre, li_mese
	
	
	ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
	
	ld_data_in=dw_1.getitemdate(1,"d_in")
	
	li_mese=integer(month(ld_data_in))
	
	SELECT "attivita"."liq_iva"
	 INTO :ls_tipo_liq_iva
    FROM "attivita" 
   WHERE "attivita"."id_attivita" = :ll_id_attivita   ;
	
	IF ls_tipo_liq_iva='M' THEN
	   ls_mese=uf_mese(li_mese) 
	     ELSE 
	       li_trimestre=uf_trimestre(li_mese)	
   END IF
	
	ls_param.mese=ls_mese
	ls_param.trimestre=li_trimestre
	
	
	

	openwithparm(w_stampa_liq_iva1_ff,ls_param)
	
	
	s_liq_iva ls_liq_iva
	ls_liq_iva=Message.PowerObjectParm	
	if ls_ret='OK' then
		IF ls_flag='S' and ls_st_def_prov = 'N' THEN
			
			
			
			
			if isvalid(ls_liq_iva) then
				li_rispo=messagebox("Controllo","La stampa è andata a buon fine?",question!,yesno!,1)
			else
				li_rispo=2
			end if
			
			
			open(w_attesa)
		END IF	
		
		IF ls_flag='S' AND li_rispo=1 THEN
		
			
			uf_aggiorna_riepiloghi_iva(ls_liq_iva)
			
			select pagine_usate 
			into :ll_pag_usate 
			from contatori_bollati
			where id_registro=:ll_registro;
				
			if sqlca.sqlcode=0 then
					if not isnull(ll_pag_usate) then
						ll_num_pag=ll_num_pag+ll_pag_usate
					end if
		
					update contatori_bollati
					set pagine_usate=:ll_num_pag
					where id_registro=:ll_registro;
			else
				messagebox("Errore","Le pagine per questo tipo di stampa non sono state preparate.",StopSign!)
			end if		
			
			
			
		END IF
		
		IF ls_flag='S' AND li_rispo=2 THEN
			uf_sblocca_dati()
		END IF
	end if

	

	close(w_attesa)
	
END IF 
end event

type cb_annulla from commandbutton within w_stampa_liq_iva_ff
integer x = 338
integer y = 36
integer width = 256
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
boolean cancel = true
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_stampa_liq_iva_ff
event ue_post_itemchanged ( )
integer x = 32
integer y = 252
integer width = 1801
integer height = 996
integer taborder = 10
string dataobject = "d_stampa_liq_iva_ff"
end type

event ue_post_itemchanged;call super::ue_post_itemchanged;


end event

event itemchanged;

long ll_id_attivita, ll_esercizio, ll_registro
string ls_data_fine, ls_liq_iva
integer li_mese, li_anno, li_ret
date ld_data_inizio, ld_data_fine


IF dwo.Name = "id_attivita" THEN
   ll_id_attivita=dec(data)

	
   SELECT "attivita"."liq_iva"
	  INTO :ls_liq_iva
     FROM "attivita" 
    WHERE "attivita"."id_attivita" = :ll_id_attivita   ;

   
   SELECT "riep_iva"."ultima_liq"   
     INTO :ld_data_inizio
     FROM "riep_iva"  
    WHERE "riep_iva"."id_azienda" = 1   ;

   
   ld_data_inizio=RelativeDate(ld_data_inizio,1) 

   
   
   
   
   IF ls_liq_iva='M' THEN
	   li_mese=integer(month(ld_data_inizio))
	   li_anno=integer(year(ld_data_inizio))
	   li_ret=f_gmese(li_mese,li_anno)
	   ls_data_fine=string(li_ret)+"/"+string(integer(month(ld_data_inizio)))+"/"+ &
	   				 string(integer(year(ld_data_inizio)))
	   ld_data_fine=date(ls_data_fine)
           ELSE
              li_mese=integer(month(ld_data_inizio))+2
			     li_anno=integer(year(ld_data_inizio))
              li_ret=f_gmese(li_mese,li_anno)
			     ls_data_fine=string(li_ret)+"/"+string(li_mese)+"/"+ &
				               string(integer(year(ld_data_inizio)))
			     ld_data_fine=date(ls_data_fine)
   END IF
dw_1.setitem(1,"id_attivita",ll_id_attivita)
dw_1.setitem(1,"d_in",ld_data_inizio)
dw_1.setitem(1,"d_fin",ld_data_fine)
lb_ges_periodo=false
END IF

IF dwo.Name = "id_esercizio" THEN
	setnull(ld_data_inizio)
	setnull(ld_data_fine)
	dw_1.setitem(1,"d_in",ld_data_inizio)
   dw_1.setitem(1,"d_fin",ld_data_fine)
	lb_ges_periodo=false
   
	ll_esercizio=long(data)
	ldw_registro.retrieve(ll_esercizio)	
	select id_registro
   into :ll_registro
   from registro
   where id_azienda = 1 and  id_esercizio=:ll_esercizio and numero=1 and tipo_registro='IV';
	dw_1.setitem(1,"registro",ll_registro)
	
END IF
if dwo.name="d_in" or dwo.name="d_fin" then
	dw_1.object.credito_periodo.protect=0
	decimal ld_null
	setnull(ld_null)
	dw_1.setitem(1,"credito_periodo",ld_null)
end if
if dwo.name="credito_periodo" then
	lb_ges_periodo=true
end if
	


if dwo.name='flag' then
	if data='S' then
		dw_1.setitem(1,"d_in",ld_ist_inizio)
		if dw_1.getitemdate(1,"d_fin")<ld_ist_inizio then dw_1.setitem(1,"d_fin",ld_ist_fine)
	end if
end if	
end event

type st_1 from statictext within w_stampa_liq_iva_ff
integer x = 50
integer y = 160
integer width = 1774
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Immettere la data di inizio e di fine delle registrazioni contabili ."
boolean focusrectangle = false
end type

