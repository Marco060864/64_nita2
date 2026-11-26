forward
global type w_estr_conto_banca_ff from w_wiz_main
end type
type cb_ok from commandbutton within w_estr_conto_banca_ff
end type
type cb_annulla from commandbutton within w_estr_conto_banca_ff
end type
type dw_1 from u_dw_ext_main within w_estr_conto_banca_ff
end type
end forward

global type w_estr_conto_banca_ff from w_wiz_main
int Width=2482
int Height=1084
WindowType WindowType=response!
boolean TitleBar=true
string Title="E.C. x data valuta bancaria"
long BackColor=80263581
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_estr_conto_banca_ff w_estr_conto_banca_ff

type variables
date		id_data_registrazione
s_con_effetti	istr_struct
boolean		ib_feed_struct = FALSE
boolean lb_ges_periodo
long ll_valuta
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

on w_estr_conto_banca_ff.create
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

on w_estr_conto_banca_ff.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;



long ll_id_es
date dat2, dat1

dat1 = date('1990/01/01')

IF dw_1.GetRow() = 0 THEN
	dw_1.InsertRow(0)
   
	
	select id_esercizio
	into :ll_id_es
	from azienda;
	
	select data_inizio, id_valuta
	into :dat1, :ll_valuta
	from esercizio
	where id_esercizio=:ll_id_es;
	
	dat2=today()
		
	dw_1.setitem(1, 'd_in', dat1 )
	dw_1.setitem(1, 'd_fin', dat2)	
	
END IF


datawindowchild ldw_sottomastro 
dw_1.getchild("sottomastro",ldw_sottomastro)
ldw_sottomastro.settransobject(sqlca)
ldw_sottomastro.retrieve()

datawindowchild ldw_valuta 
dw_1.getchild("valuta",ldw_valuta)
ldw_valuta.settransobject(sqlca)
ldw_valuta.retrieve()

dw_1.setitem(1,'valuta',ll_valuta)

dw_1.setitem(1, 'tipo_stp', 'L')	
	
dw_1.setitem(1, 'solo_periodo', 'N')
dw_1.setitem(1, 'data_stampa', today())


end event

event closequery;
end event

type cb_ok from commandbutton within w_estr_conto_banca_ff
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

string  ls_conto, ls_conto2, ls_mastro, ls_sottomastro, ls_valuta
decimal ld_cambio
long ll_apertura, ll_id_registro, ll_id_esercizio, ll_chiusura, ll_cifre_decimali
date  ld_inizio, ld_data_competenza, d_dat_in, d_dat_fin
integer li_d_day, li_d_fine , i
long lc_valuta, ll_val_lire
select id_val_lire into :ll_val_lire from par_sistema;

dw_1.accepttext()

d_dat_in = dw_1.getitemdate(1, 'd_in')
d_dat_fin = dw_1.getitemdate(1, 'd_fin')

ls_mastro=dw_1.getitemstring(1,"mastro")
ls_sottomastro=dw_1.getitemstring(1,"sottomastro")
ls_conto=dw_1.getitemstring(1, 'a_cod') 
if isnull(ls_conto) then ls_conto=''

ls_conto2=dw_1.getitemstring(1, 'da_cod') 
if isnull(ls_conto2) then ls_conto2=''
lc_valuta=dw_1.getitemnumber(1,'valuta')

IF ls_conto2 > ls_conto THEN
	messagebox ('Attenzione', 'Il conto iniziale è maggiore del conto finale')
	return
end if	

IF d_dat_in > d_dat_fin THEN
	messagebox ('Attenzione', 'Verificare date inserite')
	return
ELSE
	if isnull(d_dat_fin) then
		messagebox ('Attenzione', 'Inserire = fino a data')
	end if


	open (W_attesa)

   
	if ll_valuta=ll_val_lire then
		select descrizione, cambio, dec_significativi
		into :ls_valuta, :ld_cambio, :ll_cifre_decimali
		from valuta where id_valuta=:lc_valuta;
	else	
		select descrizione, parita_euro, dec_significativi
		into :ls_valuta, :ld_cambio, :ll_cifre_decimali
		from valuta where id_valuta=:lc_valuta;
   end if
   
		
	if isnull(ls_mastro) then 
   	IF isnull(ls_conto2) then
	   	SELECT min(codice)
			INTO :ls_conto2
			FROM conto;
		end if
		str_parametri.da_conto= ls_conto2
		if isnull (ls_conto) then 
			SELECT max(codice)
			INTO :ls_conto
			FROM conto;
		end if
		str_parametri.a_conto= ls_conto
	else
		IF isnull(ls_sottomastro) then 
	   	SELECT min(codice), max(codice)
			INTO :ls_conto2, :ls_conto
			FROM conto
			where left(codice,2)=:ls_mastro;
		else
			SELECT min(codice), max(codice)
			INTO :ls_conto2, :ls_conto
			FROM conto
			where left(codice,4)=:ls_mastro+:ls_sottomastro;
		end if
		str_parametri.da_conto= ls_conto2
		str_parametri.a_conto= ls_conto
	end if

	str_parametri.data_inizio_estratto= d_dat_in
	str_parametri.data_fine_estratto= d_dat_fin
	str_parametri.valuta=ls_valuta
	str_parametri.cambio=ld_cambio
	str_parametri.decimali=ll_cifre_decimali
	
   str_parametri.id_valuta=lc_valuta

	select min(data_val_banca)
	into :ld_data_competenza
	from mov_contabile;

	if sqlca.sqlcode=0 then
		ld_data_competenza=RelativeDate(ld_data_competenza,  - 30)
	else
		ld_data_competenza=date('1900-01-01')
	end if	

	str_parametri.data_saldo_iniziale= ld_data_competenza
	str_parametri.data_saldo_fine=today()	

	str_parametri.solo_per=dw_1.getitemstring(1,'solo_periodo') 
   
	str_parametri.data_stampa=dw_1.getitemdate(1,'data_stampa') 

	close (w_attesa)
	
	
	openwithparm(w_stampa_est_banca_ff, str_parametri)
	
	
	
end if


end event

type cb_annulla from commandbutton within w_estr_conto_banca_ff
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

type dw_1 from u_dw_ext_main within w_estr_conto_banca_ff
int X=50
int Y=144
int Width=2377
int Height=816
int TabOrder=10
boolean BringToTop=true
string DataObject="d_est_conto_banca"
end type

event itemchanged;string ls_filtro
integer li_ok

string ls_sql_cond, ls_null, ls_cond
string ls_dbc[], ls_dwc[], ls_dbv[]

setnull(ls_null)

CHOOSE CASE dwo.name
		
		CASE "da_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
	  
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_cod", Data)			
           This.SetItem(1, "a_des", This.GetItemString(1, "da_des"))
         end if
			RETURN 2
		END IF
		
		
	case "da_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "da_cod"
		ls_dwc[2] = "da_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)	
			
		IF (li_ok > 0) THEN
			if isnull(This.GetItemString(1, "a_cod")) or This.GetItemString(1, "a_cod")='' then
       	  This.SetItem(1, "a_des", Data)			
           This.SetItem(1, "a_cod", This.GetItemString(1, "da_cod"))
         end if
			RETURN 2
		END IF

	case "a_cod"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)

		IF (li_ok > 0) THEN
			RETURN 2
		END IF
	case "a_des"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		
		ls_dwc[1] = "a_cod"
		ls_dwc[2] = "a_des"
		
		li_ok = uf_autofind_col(dwo.Name, "conto_pdc", "descrizione", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
			
		
		IF (li_ok > 0) THEN
			RETURN 2
		END IF
		
	case "mastro"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "id_mastro"
		
		ls_dwc[1] = "mastro"
		ls_dwc[2] = "id_mastro"
		
		li_ok = uf_autofind_col(dwo.Name, "mastro", "codice", "A", data, ls_sql_cond, 2, &
			ls_dbc, ls_dbv, ls_dwc)
		
		IF (li_ok > 0) or li_ok=0 THEN 
        if isnull(data) or trim(data)='' then
		    this.setitem(row,"sottomastro",ls_null)	
		  elseif li_ok>0 then	
			 this.setitem(row,"a_des",ls_null)
			 this.setitem(row,"a_cod",ls_null)
	       this.setitem(row,"da_des",ls_null)
			 this.setitem(row,"da_cod",ls_null)	
			 ls_filtro=ls_dbv[2]
			 if not isnull(ls_filtro) then
		      datawindowchild ldwc_dddw
		      this.GetChild('sottomastro',ldwc_dddw )
		      ldwc_dddw.setfilter("sottomastro_id_mastro="+ls_filtro)
		      ldwc_dddw.filter()
		    end if  
		  end if
	   end if  
		
end choose

end event

event ue_set_search;string ls_cond

CHOOSE CASE as_nomecol
	CASE "a_cod", "a_des"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "a_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "a_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF

	CASE "da_cod", "da_des"
		is_search_window = "w_conti_pdc_sw"

		IF as_nomecol = "da_cod" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_codice"
		ELSEIF as_nomecol = "da_des" THEN
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "conto_descrizione"
		END IF
		
	case "mastro"
		is_search_window = "w_mastro_sw"
      is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"

 

END CHOOSE	
end event

event ue_use_search;string ls_null, ls_filtro

setnull(ls_null)

CHOOSE CASE as_nomecol
	CASE "a_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_des", is_ricpar.s_ausil_value[1])

	CASE "a_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("a_cod", is_ricpar.s_ausil_value[1])
	
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

   Case "mastro"
      uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_mastro", is_ricpar.s_id_seg_value[1])
		if isnull(as_nomecol) then 
		   this.setitem(1,"sottomastro",ls_null)
		else	
			this.setitem(1,"a_des",ls_null)
			this.setitem(1,"a_cod",ls_null)
	      this.setitem(1,"da_des",ls_null)
			this.setitem(1,"da_cod",ls_null)
			ls_filtro=is_ricpar.s_id_seg_value[1]
			if not isnull(ls_filtro) then
		     datawindowchild ldwc_dddw
		     this.GetChild('sottomastro',ldwc_dddw )
		     ldwc_dddw.setfilter("sottomastro_id_mastro="+ls_filtro)
		     ldwc_dddw.filter()
		   end if
		end if
		
	
	


END CHOOSE








end event

