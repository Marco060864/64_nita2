forward
global type w_scad_fornitori_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_scad_fornitori_ff
end type
type cb_annulla from commandbutton within w_scad_fornitori_ff
end type
type dw_1 from u_dw_ext_main within w_scad_fornitori_ff
end type
end forward

global type w_scad_fornitori_ff from w_wiz_main
int Width=2144
int Height=788
WindowType WindowType=response!
boolean TitleBar=true
string Title="Estratto Conto"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_scad_fornitori_ff w_scad_fornitori_ff

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE
boolean lb_ges_periodo
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

IF ls_stampato='N' THEN 
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

on w_scad_fornitori_ff.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_annulla=create cb_annulla
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_annulla
this.Control[iCurrent+3]=this.dw_1
end on

on w_scad_fornitori_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;



dw_1.settransobject(sqlca)
dw_1.insertrow(0)

date  dat1

dat1=today()
dw_1.setitem(1, 'd_in', dat1 )
	
	





end event

event closequery;
end event

type cb_ok from commandbutton within w_scad_fornitori_ff
event clicked pbm_bnclicked
int X=46
int Y=36
int Width=270
int Height=84
int TabOrder=20
boolean BringToTop=true
string Text="Stampa"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

s_passa_date str_parametri  

string  ls_conto2

long  ll_id_conto
date   d_dat_in
integer li_d_day, li_d_fine , i, li_ret


datastore ds_stampa
ds_stampa=create datastore

dw_1.accepttext()




d_dat_in = dw_1.getitemdate(1, 'd_in')



ls_conto2=dw_1.getitemstring(1, 'da_cod') 

IF isnull(ls_conto2) then 
	messagebox ('Attenzione', 'Non è stato inserito nessun conto')
   return
end if	

select id_conto
into :ll_id_conto
from conto
where codice=:ls_conto2;
if isnull(ls_conto2) then ls_conto2=''


str_parametri.da_id_conto=ll_id_conto
str_parametri.data_inizio_estratto= d_dat_in

openwithparm(w_stampa_scad_fornitori_ff, str_parametri)




end event

type cb_annulla from commandbutton within w_scad_fornitori_ff
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

type dw_1 from u_dw_ext_main within w_scad_fornitori_ff
int X=50
int Y=152
int Width=1989
int Height=496
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ordini_for_gd"
end type

event itemchanged;string ls_filtro
integer li_ok

string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

setnull(ls_null)

CHOOSE CASE dwo.name
		
		CASE "da_cod"
		ls_sql_cond = "mastro.codice='" +ls_cond+"'"  
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
		
	case "da_des"
		ls_sql_cond ="mastro.codice='" +ls_cond+"'"  
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			RETURN 2
		END IF



		
end choose

end event

event ue_set_search;string ls_cond

select pref_cod_fornitore
into :ls_cond
from par_sistema;

CHOOSE CASE as_nomecol

	CASE "da_cod", "da_des"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "da_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
			is_ricpar.s_sql_cond="mastro.codice='" +ls_cond+"'"  
		ELSEIF as_nomecol = "da_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
			is_ricpar.s_sql_cond="mastro.codice='" +ls_cond+"'"  
		END IF
		
END CHOOSE	
end event

event ue_use_search;string ls_null, ls_filtro

setnull(ls_null)

CHOOSE CASE as_nomecol

	CASE "da_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_des", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_cod', is_ricpar.s_main_value)
        uf_set_colval("a_des", is_ricpar.s_ausil_value[1])
	   end if
		

	CASE "da_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("da_cod", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
        uf_set_colval('a_des', is_ricpar.s_main_value)
        uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
	   end if		



END CHOOSE








end event

