forward
global type w_par_aper_agenti_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_par_aper_agenti_ff
end type
type cb_annulla from commandbutton within w_par_aper_agenti_ff
end type
type dw_1 from u_dw_ext_main within w_par_aper_agenti_ff
end type
end forward

global type w_par_aper_agenti_ff from w_wiz_main
int Width=2647
int Height=904
WindowType WindowType=response!
boolean TitleBar=true
string Title="Partite Aperte"
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_par_aper_agenti_ff w_par_aper_agenti_ff

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

on w_par_aper_agenti_ff.create
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

on w_par_aper_agenti_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;date dat2, dat1

dat1 = date('1990/01/01')

IF dw_1.GetRow() = 0 THEN
	dw_1.InsertRow(0)

	
	select max(data_fine)
		into :dat2
		from esercizio;
		
	dw_1.setitem(1, 'd_in', dat1 )
	dw_1.setitem(1, 'd_fin', dat2)	
	
END IF
end event

event closequery;call super::closequery;

end event

type cb_ok from commandbutton within w_par_aper_agenti_ff
event clicked pbm_bnclicked
int X=50
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
DATE d_dat_in, d_dat_fin
STRING ls_conto2, ls_conto, ls_stato, ls_da_gruppo_agente, ls_a_gruppo_agente 

s_param_partite s_par  
d_dat_in = dw_1.getitemdate(1, 'd_in')
d_dat_fin = dw_1.getitemdate(1, 'd_fin')
ls_conto2=dw_1.getitemstring(1, 'conto_codice1') 
ls_conto=dw_1.getitemstring(1, 'conto_codice2') 
ls_stato=dw_1.getitemstring(1, 'stato')
ls_da_gruppo_agente=dw_1.getitemstring(1, 'da_gruppo_agenti')
ls_a_gruppo_agente=dw_1.getitemstring(1, 'a_gruppo_agenti')

s_par.codice1 = ls_conto
s_par.codice2 = ls_conto2
s_par.dat1 =d_dat_in
s_par.dat2 =d_dat_fin
s_par.stato =ls_stato
s_par.da_gruppo_agente=ls_da_gruppo_agente
s_par.a_gruppo_agente=ls_a_gruppo_agente

open (w_attesa)

Update par_aperta set stato = 'A';

IF isnull(ls_conto)  then
	SELECT min(codice)
		INTO :ls_conto
		FROM conto;
		if isnull (ls_conto2) then
		SELECT max(codice)
		  INTO :ls_conto2
		  FROM conto;
		end if
end if

IF ls_stato <> 'T' then
	
	DATASTORE ds_prepara_partite 
	ds_prepara_partite = CREATE DATASTORE
	ds_prepara_partite.DATAOBJECT = "ds_ges_partite_aperte"
	ds_prepara_partite.SETTRANSOBJECT(SQLCA)
	ds_prepara_partite.RETRIEVE(d_dat_in, d_dat_fin, ls_conto, ls_conto2 ) 
	
	long ll_num, ll_breakrow
	integer i, li_ret
	string ls_valore
	boolean lb_found
	
	ll_num = ds_prepara_partite.rowcount()
		
	lb_found = FALSE
	ll_breakrow = 0
			
	DO WHILE NOT (lb_found)
	ll_breakrow = ds_prepara_partite.FindGroupChange(ll_breakrow, 1)
			IF ll_breakrow <= 0 THEN EXIT
				ls_valore= ds_prepara_partite.GetItemstring(ll_breakrow, "stato") 
				ds_prepara_partite.setitem(ll_breakrow, "par_aperta_stato", ls_valore)
			lb_found = false
			ll_breakrow = ll_breakrow + 1
	LOOP
		
	ds_prepara_partite.update()
	
	DESTROY ds_prepara_partite
	

ELSE
	Update par_aperta set stato = 'T';
	commit;
END IF
close (w_attesa)
OpenWithparm(w_stampa_partite_agenti, s_par) 

end event

type cb_annulla from commandbutton within w_par_aper_agenti_ff
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

type dw_1 from u_dw_ext_main within w_par_aper_agenti_ff
event ue_post_itemchanged ( )
int X=55
int Y=148
int Width=2519
int Height=616
int TabOrder=10
string DataObject="d_sel_par_aperte_agenti"
end type

event ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "conto_codice1", "conto_descrizione1"
		is_search_window = "w_conto_coddes_sw"

		IF as_nomecol = "conto_codice1" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "conto_descrizione1" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF

	CASE "conto_codice2", "conto_descrizione2"
		is_search_window = "w_conto_coddes_sw"

		IF as_nomecol = "conto_codice2" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "conto_descrizione2" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF
		
		CASE "da_gruppo_agenti"
		is_search_window = "w_gruppo_agenti_coddes_sw"

		IF as_nomecol = "da_gruppo_agenti" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "descrizione"
		END IF
		
		CASE "a_gruppo_agenti"
		is_search_window = "w_gruppo_agenti_coddes_sw"

		IF as_nomecol = "a_gruppo_agenti" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "descrizione"
		END IF



END CHOOSE	










end event

event ue_use_search;CHOOSE CASE as_nomecol
	CASE "conto_codice1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_descrizione1", is_ricpar.s_ausil_value[1])

	CASE "conto_descrizione1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_codice1", is_ricpar.s_ausil_value[1])
		
	CASE "conto_codice2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_descrizione2", is_ricpar.s_ausil_value[1])

	CASE "conto_descrizione2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("conto_codice2", is_ricpar.s_ausil_value[1])

	CASE "da_gruppo_agenti"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)


	CASE "a_gruppo_agenti"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)

END CHOOSE


end event

event itemfocuschanged;call super::itemfocuschanged;string ls_conto_cod_da, ls_conto_des_da, ls_da_gr_ag, ls_a_gr_ag

CHOOSE CASE dwo.name
	CASE "conto_codice1"
		ls_conto_cod_da = THIS.GetItemString(1, "conto_codice2")
		ls_conto_des_da = THIS.GetItemString(1, "conto_descrizione2")
		
		THIS.SetItem(1, "conto_codice1", ls_conto_cod_da)
		THIS.SetItem(1, "conto_descrizione1", ls_conto_des_da)
		
	
END CHOOSE
end event

event itemchanged;integer li_ok

string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

choose case dwo.name
	case "conto_codice2"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "conto_codice2"
		ls_dwc[2] = "conto_descrizione2"
		
		li_ok = uf_autofind_col(dwo.Name, "conto", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
			
						
			
 		This.SetItem(1, "conto_codice1", Data)			
      This.SetItem(1, "conto_descrizione1", This.GetItemString(1, "conto_descrizione2"))

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "conto_descrizione2"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "conto_codice2"
		ls_dwc[2] = "conto_descrizione2"
		
		li_ok = uf_autofind_col(dwo.Name, "conto", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "conto_codice1"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "conto_codice1"
		ls_dwc[2] = "conto_descrizione1"
		
		li_ok = uf_autofind_col(dwo.Name, "conto", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "conto_descrizione1"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "conto_codice1"
		ls_dwc[2] = "conto_descrizione1"
		
		li_ok = uf_autofind_col(dwo.Name, "conto", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
				
	case "da_gruppo_agenti"
		ls_sql_cond = ""
		
		ls_dbc[1] = "descrizione"
			
		ls_dwc[1] = "conto_descrizione1"
		
		li_ok = uf_autofind_col(dwo.Name, "gruppo_agenti", "descrizione", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 1
		END IF
	case "a_gruppo_agenti"
		ls_sql_cond = ""
	
		ls_dbc[1] = "descrizione"
		
		ls_dwc[1] = "conto_descrizione1"
		
		li_ok = uf_autofind_col(dwo.Name, "gruppo_agenti", "descrizione", "A", data, ls_sql_cond, 1, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 1
		END IF
		
		
end choose

end event

