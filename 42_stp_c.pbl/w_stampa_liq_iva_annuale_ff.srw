forward
global type w_stampa_liq_iva_annuale_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_stampa_liq_iva_annuale_ff
end type
type cb_annulla from commandbutton within w_stampa_liq_iva_annuale_ff
end type
type dw_1 from u_dw_ext_main within w_stampa_liq_iva_annuale_ff
end type
type st_1 from statictext within w_stampa_liq_iva_annuale_ff
end type
end forward

global type w_stampa_liq_iva_annuale_ff from w_wiz_main
int Width=1824
int Height=1372
WindowType WindowType=response!
boolean TitleBar=true
string Title="Stampa Liquidazione Iva Annuale"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
st_1 st_1
end type
global w_stampa_liq_iva_annuale_ff w_stampa_liq_iva_annuale_ff

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
         "azienda"."id_azienda" = 1 
			
			
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

ld_acconto=dw_1.getitemnumber(1,"acconto")

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

on w_stampa_liq_iva_annuale_ff.create
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

on w_stampa_liq_iva_annuale_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;call super::open;

long ll_id_attivita

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

  SELECT "esercizio"."data_inizio", 
         "esercizio"."data_fine"
	 INTO :ld_data_inizio, :ld_data_fine
    FROM "esercizio" 
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio_proposto; 
   
dw_1.setitem(1,"id_esercizio",ll_id_esercizio_proposto)
dw_1.setitem(1,"id_attivita",ll_id_attivita)
dw_1.setitem(1,"d_in",ld_data_inizio)
dw_1.setitem(1,"d_fin",ld_data_fine)



	


end event

event closequery;call super::closequery;

end event

type cb_ok from commandbutton within w_stampa_liq_iva_annuale_ff
event clicked pbm_bnclicked
int X=46
int Y=36
int Width=270
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stampa"
boolean Default=true
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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
	li_rispo1=messagebox("Controllo","Attenzione,~ni Registri Iva non risultano stampati.~nVuoi stampare comunque?",&
	                      question!,yesno!,1)
	if li_rispo1=1 then 
		ls_flag='S'
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

	
	
	IF ls_ret='OK' THEN
		openwithparm(w_stampa_liq_iva1_annuale_ff,ls_param)
		
		
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

type cb_annulla from commandbutton within w_stampa_liq_iva_annuale_ff
int X=338
int Y=36
int Width=256
int Height=84
int TabOrder=30
boolean BringToTop=true
string Text="Annulla"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

Close(Parent)
end event

type dw_1 from u_dw_ext_main within w_stampa_liq_iva_annuale_ff
event ue_post_itemchanged ( )
int X=23
int Y=260
int Width=1765
int Height=1004
int TabOrder=10
string DataObject="d_stampa_liq_iva_ff"
end type

event itemchanged;call super::itemchanged;

long ll_id_attivita, ll_id_esercizio
date ld_data_inizio, ld_data_fine

IF dwo.Name = "id_esercizio" THEN
	ll_id_esercizio=dec(data)
  
  SELECT "esercizio"."data_inizio", 
         "esercizio"."data_fine"
	 INTO :ld_data_inizio, :ld_data_fine
    FROM "esercizio" 
	WHERE "esercizio"."id_esercizio" = :ll_id_esercizio; 

	dw_1.setitem(1,"d_in",ld_data_inizio)
   dw_1.setitem(1,"d_fin",ld_data_fine)
   
END IF

	

end event

type st_1 from statictext within w_stampa_liq_iva_annuale_ff
int X=50
int Y=160
int Width=1902
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="Immettere la data di inizio e di fine delle registrazioni contabili ."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

