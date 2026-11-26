forward
global type w_riep_art_rpt from w_wiz_main
end type
type cb_ok from commandbutton within w_riep_art_rpt
end type
type cb_annulla from commandbutton within w_riep_art_rpt
end type
type dw_1 from u_dw_ext_main within w_riep_art_rpt
end type
end forward

global type w_riep_art_rpt from w_wiz_main
int Width=2482
int Height=1200
WindowType WindowType=response!
boolean TitleBar=true
string Title="Merci in conto deposito"
long BackColor=80263581
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
cb_ok cb_ok
cb_annulla cb_annulla
dw_1 dw_1
end type
global w_riep_art_rpt w_riep_art_rpt

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

on w_riep_art_rpt.create
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

on w_riep_art_rpt.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_annulla)
destroy(this.dw_1)
end on

event open;call super::open;



dw_1.settransobject(sqlca)
dw_1.insertrow(0)

dw_1.setitem(1,'alla_data',today())
dw_1.setitem(1,'dalla_data',date('01/01/'+string(year(today()))))


datawindowchild ldw_registro
dw_1.getchild("tipo_registro",ldw_registro)
ldw_registro.settransobject(sqlca)
ldw_registro.retrieve()

datawindowchild ldw_da_mag 
dw_1.getchild("da_mag",ldw_da_mag)
ldw_da_mag.settransobject(sqlca)
ldw_da_mag.retrieve()

datawindowchild ldw_a_mag 
dw_1.getchild("a_mag",ldw_a_mag)
ldw_a_mag.settransobject(sqlca)
ldw_a_mag.retrieve()

end event

event closequery;
end event

type cb_ok from commandbutton within w_riep_art_rpt
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

event clicked;dw_1.accepttext()

s_riep_art str_passa


string ls_da_sog, ls_a_sog, ls_da_art, ls_a_art, ls_da_maga, ls_a_maga, ls_filtro, ls_def
date ld_ddata, ld_adata
long ll_reg

select id_mod_reg_merci_deposito
into :ll_reg from par_sistema;


ls_filtro=''

ls_def=dw_1.getitemstring(1,'definitiva')
ld_ddata=dw_1.getitemdate(1,'dalla_data')
ld_adata=dw_1.getitemdate(1,'alla_data')

if ls_def='S' then
	str_passa.filtro='DEF'
else
	ls_da_art=dw_1.getitemstring(1,'da_articolo')
	ls_a_art=dw_1.getitemstring(1,'a_articolo')
	ls_da_maga=dw_1.getitemstring(1,'da_mag')
	ls_a_maga=dw_1.getitemstring(1,'a_mag')
	ls_da_sog=dw_1.getitemstring(1,'da_sogg_comm')
	ls_a_sog=dw_1.getitemstring(1,'a_sogg_comm')

	if isnull(ld_ddata) or isnull(ld_adata) or ld_ddata>ld_adata  then
		messagebox('Attenzione', 'Le date inserite non sono valide')
		return
	end if

	if isnull(ls_da_art) or isnull(ls_a_art) then
  		ls_filtro=ls_filtro + 'A'	
	end if

	if isnull(ls_da_maga) or isnull(ls_a_maga) then
		ls_filtro = ls_filtro + 'M'
	end if

	if isnull(ls_da_sog) or isnull(ls_a_sog) then
		ls_filtro = ls_filtro + 'S'
	end if

	str_passa.da_articolo=ls_da_art
	str_passa.a_articolo=ls_a_art
	str_passa.da_soggetto=ls_da_sog
	str_passa.a_soggetto=ls_a_sog
	str_passa.da_magazzino=ls_da_maga
	str_passa.a_magazzino=ls_a_maga
	str_passa.filtro=ls_filtro
end if

str_passa.dalla_data=ld_ddata
str_passa.alla_data=ld_adata
str_passa.tipo_registro=ll_reg

openwithparm(w_stp_art_deposito_rpt,str_passa)

close(parent)
end event

type cb_annulla from commandbutton within w_riep_art_rpt
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

type dw_1 from u_dw_ext_main within w_riep_art_rpt
int X=37
int Y=132
int Width=2377
int Height=916
int TabOrder=10
boolean BringToTop=true
string DataObject="d_art_riep_rpt"
end type

event itemchanged;date		ld_dalla_data
string	ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
integer li_ok

CHOOSE CASE dwo.name
	CASE 'alla_data'
		ld_dalla_data = This.GetItemDate(1, "dalla_data")
		if Date(data) < ld_dalla_data then
			MessageBox("Attenzione", "Data fine non può essere inferiore alla data di inizio.")
			Post SetColumn("alla_data")
		end if
	case "da_articolo"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
				 this.setitem(1,'a_articolo',data)
				 this.setitem(1,'a_articolo_des',this.getitemstring(1,'da_articolo_des'))
			end if
			return 2
		end if	
		
	case "da_articolo_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "da_articolo"
		ls_dwc[2] = "da_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
				 this.setitem(1,'a_articolo_des',data)
				 this.setitem(1,'a_articolo',this.getitemstring(1,'da_articolo'))
			end if
			return 2
		end if	
	
	case "a_articolo"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_articolo_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dwc[1] = "a_articolo"
		ls_dwc[2] = "a_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if		
		
		
		
	case "da_sogg_comm"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_sogg_comm"
		ls_dwc[2] = "da_sogg_comm_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_sogg_comm')) or this.getitemstring(1,'a_sogg_comm')='' then
				 this.setitem(1,'a_sogg_comm',data)
				 this.setitem(1,'a_sogg_comm_des',this.getitemstring(1,'da_sogg_comm_des'))
			end if
			return 2
		end if	
		
	case "da_sogg_comm_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "da_sogg_comm"
		ls_dwc[2] = "da_sogg_comm_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		
		if li_ok>0 then 
			if isnull(this.getitemstring(1,'a_sogg_comm')) or this.getitemstring(1,'a_sogg_comm')='' then
				 this.setitem(1,'a_sogg_comm_des',data)
				 this.setitem(1,'a_sogg_comm',this.getitemstring(1,'da_sogg_comm'))
			end if
			return 2
		end if	
	
	case "a_sogg_comm"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_sogg_comm"
		ls_dwc[2] = "a_sogg_comm_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","codice","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	case "a_sogg_comm_des"
		ls_dbc[1] = "codice"
		ls_dbc[2] = "rag_soc_1"
		ls_dwc[1] = "a_sogg_comm"
		ls_dwc[2] = "a_sogg_comm_des"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen","rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)	
		if li_ok>0 then 
			return 2
		end if	
		
	CASE "definitiva"
		date ld_data
		if data='S' then
			
			select max(ultima_data) into :ld_data
			from contatore_deposito_articoli;
		   if sqlca.sqlcode=0 and not isnull(ld_data) then
				ld_data=RelativeDate ( ld_data, 1 )
				dw_1.setitem(1,'dalla_data',relativedate(ld_data,1))
				dw_1.setitem(1,'alla_data',today())
			else 
				dw_1.setitem(1,'dalla_data',date('01-01-2000'))
				dw_1.setitem(1,'alla_data',today())
			end if	
			
	   end if
END CHOOSE

end event

event ue_set_search;CHOOSE CASE as_nomecol
				
	CASE "da_articolo", "a_articolo"
		is_search_window = "w_articolo_coddes_sw" 			
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "articolo_codice" 			
	CASE "da_articolo_des", "a_articolo_des"
		is_search_window = "w_articolo_coddes_sw" 			
		is_ricpar.s_filter_value = as_valcol 					
		is_ricpar.s_filter_name = "articolo_descrizione" 	
		
	CASE "da_sogg_comm", "a_sogg_comm"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "codice" 							
	CASE "da_sogg_comm_des", "a_sogg_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 	
		is_ricpar.s_filter_value = as_valcol 						
		is_ricpar.s_filter_name = "rag_soc_1" 						
		
END CHOOSE

end event

event ue_use_search;CHOOSE CASE as_nomecol
		
	CASE "da_sogg_comm", "a_sogg_comm"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_sogg_comm" then
			uf_set_colval("da_sogg_comm_des", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_sogg_comm')) or this.getitemstring(1,'a_sogg_comm')='' then
				 uf_set_colval('a_sogg_comm', is_ricpar.s_main_value)
			    uf_set_colval("a_sogg_comm_des", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_sogg_comm_des", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_sogg_comm_des", "a_sogg_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		if as_nomecol = "da_sogg_comm_des" then
			uf_set_colval("da_sogg_comm", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_sogg_comm')) or this.getitemstring(1,'a_sogg_comm')='' then
				 uf_set_colval('a_sogg_comm_des', is_ricpar.s_main_value)
			    uf_set_colval("a_sogg_comm", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_sogg_comm", is_ricpar.s_ausil_value[1])
		end if
		
  CASE "da_articolo", "a_articolo"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_articolo" then
			uf_set_colval("da_articolo_des", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
				 uf_set_colval('a_articolo', is_ricpar.s_main_value)
			    uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_articolo_des", is_ricpar.s_ausil_value[1])
		end if
	CASE "da_articolo_des", "a_articolo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		if as_nomecol = "da_articolo_des" then
			uf_set_colval("da_articolo", is_ricpar.s_ausil_value[1])
			if isnull(this.getitemstring(1,'a_articolo')) or this.getitemstring(1,'a_articolo')='' then
				 uf_set_colval('a_articolo_des', is_ricpar.s_main_value)
			    uf_set_colval("a_articolo", is_ricpar.s_ausil_value[1])
			end if
		else
			uf_set_colval("a_articolo", is_ricpar.s_ausil_value[1])
		end if
		
	CASE "da_cod_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_des_ag", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_ag")) or This.GetItemString(1, "a_cod_ag")='' then
        uf_set_colval('a_cod_ag', is_ricpar.s_main_value)
        uf_set_colval("a_des_ag", is_ricpar.s_ausil_value[1])
	   end if
		

	CASE "da_des_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("da_cod_ag", is_ricpar.s_ausil_value[1])
		if isnull(This.GetItemString(1, "a_cod_ag")) or This.GetItemString(1, "a_cod_ag")='' then
        uf_set_colval('a_cod_ag', is_ricpar.s_main_value)
        uf_set_colval("a_des_ag", is_ricpar.s_ausil_value[1])
	   end if

	CASE "a_cod_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_des_ag", is_ricpar.s_ausil_value[1])

	CASE "a_des_ag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		
		uf_set_colval("a_cod_ag", is_ricpar.s_ausil_value[1])
	
	
END CHOOSE

end event

