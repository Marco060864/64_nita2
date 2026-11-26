forward
global type w_stampa_liq_iva2_cx from w_wiz_main
end type
type cb_ok from commandbutton within w_stampa_liq_iva2_cx
end type
type cb_annulla from commandbutton within w_stampa_liq_iva2_cx
end type
type dw_1 from u_dw_ext_main within w_stampa_liq_iva2_cx
end type
type st_1 from statictext within w_stampa_liq_iva2_cx
end type
type st_2 from statictext within w_stampa_liq_iva2_cx
end type
end forward

global type w_stampa_liq_iva2_cx from w_wiz_main
integer y = 437
integer width = 2199
integer height = 1440
string title = "Stampa Liquidazione Iva"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
st_1 st_1
st_2 st_2
end type
global w_stampa_liq_iva2_cx w_stampa_liq_iva2_cx

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE
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
string ls_ret, ls_flag, ls_st_liquidazione

ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
ld_data_in=dw_1.getitemdate(1,"d_in")
ld_data_fin=dw_1.getitemdate(1,"d_fin")


  SELECT count("ws_liquidazione_iva"."st_liquidazione"  )
    INTO :ll_tot_righe
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
         "ws_liquidazione_iva"."st_liquidazione" = 'N' 
			USING SQLCA;  

IF ll_tot_righe>0 THEN 
	ls_ret='OK'
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

OPEN ws_liquidazione_cur;

FETCH ws_liquidazione_cur INTO :ll_id_reg_pd ;

DO WHILE sqlca.sqlcode=0
	IF sqlca.sqlcode=0 THEN
      UPDATE reg_pd
		   SET st_liquidazione='S'
		 WHERE id_reg_pd=:ll_id_reg_pd;
   END IF
	FETCH ws_liquidazione_cur INTO :ll_id_reg_pd ;
LOOP

CLOSE ws_liquidazione_cur;

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
     else
	     messagebox("plafond_diff",ld_plafond_diff)
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

ld_acconto=dw_1.getitemdecimal(1,"acconto")

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

on w_stampa_liq_iva2_cx.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
end on

on w_stampa_liq_iva2_cx.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;

long ll_id_attivita
string ls_data_fine, ls_liq_iva
integer li_mese, li_anno, li_ret

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
date ld_data_inizio, ld_data_fine

  SELECT "azienda"."id_esercizio_proposto", 
         "azienda"."id_attivita"
	 INTO :ll_id_esercizio_proposto,:ll_id_attivita
    FROM "azienda"  
   WHERE "azienda"."id_azienda" = 1   ;

  SELECT "attivita"."liq_iva"
	 INTO :ls_liq_iva
    FROM "attivita" 
   WHERE "attivita"."id_attivita" = :ll_id_attivita   ;

  SELECT max("riep_iva"."ultima_liq")   
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

dw_1.setitem(1,"id_esercizio",ll_id_esercizio_proposto)
dw_1.setitem(1,"id_attivita",ll_id_attivita)
dw_1.setitem(1,"d_in",ld_data_inizio)
dw_1.setitem(1,"d_fin",ld_data_fine)



	


end event

event closequery;call super::closequery;

end event

type cb_ok from commandbutton within w_stampa_liq_iva2_cx
event clicked pbm_bnclicked
integer x = 46
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

string ls_flag, ls_ret, ls_avanti
integer li_rispo, li_rispo1
long ll_st_reg_iva, ll_st_reg_iva_regpd, ll_id_esercizio, ll_id_attivita
date ld_data_in, ld_data_fin

s_param1 ls_param
ls_param.id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
ls_param.id_attivita=dw_1.getitemnumber(1,"id_attivita")
ls_param.data_in=dw_1.getitemdate(1,"d_in")
ls_param.data_fin=dw_1.getitemdate(1,"d_fin")
ls_param.acconto=dw_1.getitemnumber(1,"acconto")

ls_flag=dw_1.getitemstring(1,"flag")
ls_avanti='S'

if ls_flag='S' then
	ll_id_esercizio=dw_1.getitemnumber(1,"id_esercizio")
	ll_id_attivita=dw_1.getitemnumber(1,"id_attivita")
	ld_data_in=dw_1.getitemdate(1,"d_in")
	ld_data_fin=dw_1.getitemdate(1,"d_fin")
	
	select count(st_reg_iva), count(st_reg_iva_regpd)
	  into :ll_st_reg_iva, :ll_st_reg_iva_regpd
	  from ws_liquidazione_iva
	 where id_esercizio=:ll_id_esercizio     and
	       id_attivita=:ll_id_attivita       and 
			 data_comp_liq_iva >= :ld_data_in  and  
          data_comp_liq_iva <= :ld_data_fin and  
          tipo_registro='IV'                and 
          st_reg_iva<>'S'                   and
          st_reg_iva_regpd<>'S'; 
end if
if ll_st_reg_iva>0 or ll_st_reg_iva_regpd>0 then
	li_rispo1=messagebox("Controllo","Attenzione,~ni Registri Iva non risultano stampati.~nProcedo con la stampa non definitiva?",&
	                      question!,yesno!,1)
	if li_rispo1=1 then 
		ls_flag='N'
		ls_avanti='S'
	   else
			ls_avanti='N'
	end if
end if


IF LS_AVANTI='S' THEN
	
	
	open(w_attesa)
	ls_ret=uf_controllo_recupero()
	if ls_ret='KO' then
		close(w_attesa)
		messagebox("Controllo","Non ci sono dati da stampare!")
	end if
		 
	
	
	
	
	
	
	IF ls_flag='S' AND ls_ret='OK' THEN
		ls_ret=uf_controlla_dati()
		if ls_ret='OK' then
			uf_blocca_dati()
			ls_param.flag='I'
				else
					messagebox("Controllo","Attenzione! ~nImpossibile Stampare i dati del periodo selezionato risultano bloccati!") 
		end if
			ELSE
				ls_param.flag='N'
	END IF
	
	
	
	
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
	
	
	
	IF ls_ret='OK' THEN
		openwithparm(w_stampa_liq_iva2_ff,ls_param)
		
		
		s_liq_iva ls_liq_iva
		ls_liq_iva=Message.PowerObjectParm	
	
		IF ls_flag='S' THEN
			
			li_rispo=messagebox("Controllo","La stampa è andata a buon fine?",question!,yesno!,1)
			open(w_attesa)
		END IF	
		
		IF ls_flag='S' AND li_rispo=1 THEN
			uf_conferma_stampa()
			
			uf_aggiorna_riepiloghi_iva(ls_liq_iva)
		END IF
		
		IF ls_flag='S' AND li_rispo=2 THEN
			uf_sblocca_dati()
		END IF
	
	
	END IF
	close(w_attesa)
	
END IF 
end event

type cb_annulla from commandbutton within w_stampa_liq_iva2_cx
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

type dw_1 from u_dw_ext_main within w_stampa_liq_iva2_cx
event ue_post_itemchanged ( )
integer x = 32
integer y = 260
integer width = 2089
integer height = 1004
integer taborder = 10
string dataobject = "d_stampa_liq_iva_ff"
end type

event ue_post_itemchanged;call super::ue_post_itemchanged;


end event

event itemchanged;call super::itemchanged;

long ll_id_attivita
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
END IF

IF dwo.Name = "id_esercizio" THEN
	setnull(ld_data_inizio)
	setnull(ld_data_fine)
	dw_1.setitem(1,"d_in",ld_data_inizio)
   dw_1.setitem(1,"d_fin",ld_data_fine)
   
END IF

	
if dwo.name="d_in" or dwo.name="d_fin" then
	dw_1.object.credito_periodo.protect=0
end if
end event

type st_1 from statictext within w_stampa_liq_iva2_cx
integer x = 50
integer y = 160
integer width = 1902
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

type st_2 from statictext within w_stampa_liq_iva2_cx
integer x = 901
integer y = 52
integer width = 503
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Per Stampanti ad aghi"
boolean focusrectangle = false
end type

