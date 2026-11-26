forward
global type w_df2cometa_ddt_cx from Window
end type
type dw_iva_doc from u_dw_ext_main within w_df2cometa_ddt_cx
end type
type dw_prof_doc from u_dw_ext_main within w_df2cometa_ddt_cx
end type
type dw_dati_doc from u_dw_ext_main within w_df2cometa_ddt_cx
end type
type dw_1 from u_dw_master_main within w_df2cometa_ddt_cx
end type
type cb_genera from commandbutton within w_df2cometa_ddt_cx
end type
type st_1 from statictext within w_df2cometa_ddt_cx
end type
type sle_1 from singlelineedit within w_df2cometa_ddt_cx
end type
type cb_importa from commandbutton within w_df2cometa_ddt_cx
end type
end forward

global type w_df2cometa_ddt_cx from Window
int X=1051
int Y=480
int Width=3141
int Height=1400
boolean TitleBar=true
string Title="Importazione DDT da file ASCII"
long BackColor=80133307
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_iva_doc dw_iva_doc
dw_prof_doc dw_prof_doc
dw_dati_doc dw_dati_doc
dw_1 dw_1
cb_genera cb_genera
st_1 st_1
sle_1 sle_1
cb_importa cb_importa
end type
global w_df2cometa_ddt_cx w_df2cometa_ddt_cx

forward prototypes
public function decimal wf_trova_prezzo (decimal aid_unita_conf, decimal ad_qta, decimal ad_peso, decimal ad_prezzo)
public function decimal wf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita)
end prototypes

public function decimal wf_trova_prezzo (decimal aid_unita_conf, decimal ad_qta, decimal ad_peso, decimal ad_prezzo);string ls_um, ls_tipo
decimal ld_prezzo

select simbolo, tipo
into :ls_um, :ls_tipo
from unita_confezione, unita_misura
where (unita_confezione.id_unita_confezione=:aid_unita_conf) and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
choose case ls_tipo
	case "P"
		ld_prezzo=ad_peso*ad_prezzo
	case else 
		ld_prezzo=ad_qta*ad_prezzo
end choose
return ld_prezzo
end function

public function decimal wf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita);
char		lch_sconto[], lch_item[]
long 		ll_char_size, ll_char_count, ll_item_count
decimal  ldc_parte,ldc_tot_riga
string  ls_parte
long ll_row, ll_pos_plus,ll_pos_minus, ll_pos
boolean lb_non_calcolabile, lb_minus
string ls_tot_riga

lb_minus= FALSE
lch_item = ""
ll_item_count=0
if IsNull(adc_prezzo) then adc_prezzo = 0
if not (IsNull(as_sconto) OR as_sconto= "") then
	lch_sconto= Trim(as_sconto)
	ll_char_size= UpperBound(lch_sconto)
	For ll_char_count= 1 to ll_char_size
		CHOOSE CASE lch_sconto[ll_char_count]
			CASE "-"
				If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if  ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
						else
							adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = TRUE
			CASE "+"
					If not(lch_item = "") OR ll_char_count = 1 then
					ldc_parte= Dec(lch_item)
					if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
					
						SetNull(ldc_parte)	
						RETURN ldc_parte
					else
						if lb_minus then
							adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
						else
							adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
						end if
					end if
				else
					
					SetNull(ldc_parte)	
					RETURN ldc_parte				
				end if
				lch_item = ""
				ll_item_count=0
				lb_minus = FALSE
			CASE ELSE
				ll_item_count ++
				lch_item[ll_item_count]= lch_sconto[ll_char_count]
		END CHOOSE
	next


	If not(lch_item = "") then
		ldc_parte= Dec(lch_item)
		if ldc_parte < 0 OR (ldc_parte > 100 AND not lb_minus) then 
		
			SetNull(ldc_parte)	
			RETURN ldc_parte
		else
			if lb_minus then
				adc_prezzo = adc_prezzo + adc_prezzo * (ldc_parte / 100)
			else
				adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
			end if
		end if
	end if
end if

RETURN adc_prezzo

end function

on w_df2cometa_ddt_cx.create
this.dw_iva_doc=create dw_iva_doc
this.dw_prof_doc=create dw_prof_doc
this.dw_dati_doc=create dw_dati_doc
this.dw_1=create dw_1
this.cb_genera=create cb_genera
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_importa=create cb_importa
this.Control[]={this.dw_iva_doc,&
this.dw_prof_doc,&
this.dw_dati_doc,&
this.dw_1,&
this.cb_genera,&
this.st_1,&
this.sle_1,&
this.cb_importa}
end on

on w_df2cometa_ddt_cx.destroy
destroy(this.dw_iva_doc)
destroy(this.dw_prof_doc)
destroy(this.dw_dati_doc)
destroy(this.dw_1)
destroy(this.cb_genera)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_importa)
end on

event open;

dw_1.settransobject(sqlca)
dw_prof_doc.settransobject(sqlca)
dw_iva_doc.settransobject(sqlca)

DataWindowChild ldw_id_esercizio, ldw_id_tabiva

dw_dati_doc.insertrow(0)
dw_prof_doc.insertrow(0)
dw_iva_doc.insertrow(0)

dw_dati_doc.GetChild("id_esercizio", ldw_id_esercizio)
ldw_id_esercizio.SetTransObject(SQLCA)
ldw_id_esercizio.Retrieve()

dw_iva_doc.GetChild("id_tab_iva", ldw_id_tabiva)
ldw_id_tabiva.SetTransObject(SQLCA)
ldw_id_tabiva.Retrieve()


end event

type dw_iva_doc from u_dw_ext_main within w_df2cometa_ddt_cx
int X=2354
int Y=56
int Width=699
int Height=108
int TabOrder=30
string DataObject="d_df2cometa_iva"
end type

type dw_prof_doc from u_dw_ext_main within w_df2cometa_ddt_cx
int X=503
int Y=56
int Width=1838
int Height=112
int TabOrder=20
string DataObject="d_df2cometa_prof"
end type

event ue_set_search;choose case as_nomecol
	case "prof_doc_cod_ini"
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_codice"
	case "prof_doc_des_ini" 
		is_search_window="W_stp_prof_documento_sw"
		is_ricpar.s_filter_value=as_valcol
		is_ricpar.s_filter_name="prof_documento_descrizione"
end choose

end event

event ue_use_search;choose case as_nomecol
		case "prof_doc_cod_ini"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_doc_des_ini",is_ricpar.s_ausil_value[1])
	
	case "prof_doc_des_ini"
		uf_set_colval(as_nomecol,is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento",is_ricpar.s_id_seg_value[1])
		uf_set_colval("prof_doc_cod_ini",is_ricpar.s_ausil_value[1])
end choose

end event

event itemchanged;integer li_ok
string ls_sql_cond
string ls_dbc[], ls_dwc[], ls_dbv[]
long ll_null
SETNULL(LL_NULL)

choose case dwo.name
case "prof_doc_cod_ini"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		
		ls_dwc[1] = "prof_doc_cod_ini"
		ls_dwc[2] = "prof_doc_des_ini"
		ls_dwc[3] = "id_prof_documento"
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "codice", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)

	case "prof_doc_des_ini"
		ls_sql_cond = ""
		
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"		
		
		ls_dwc[1] = "prof_doc_cod_ini"
		ls_dwc[2] = "prof_doc_des_ini"
		ls_dwc[3] = "id_prof_documento"		
		
		li_ok = uf_autofind_col(dwo.Name, "prof_documento", "descrizione", "A", data, ls_sql_cond, 3, &
			ls_dbc, ls_dbv, ls_dwc)		
			
end choose


end event

type dw_dati_doc from u_dw_ext_main within w_df2cometa_ddt_cx
int X=1966
int Y=1036
int Width=416
int Height=196
int TabOrder=40
string DataObject="d_df2cometa_dati_doc"
end type

event itemchanged;string    ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
long      ll_ok, ll_priorita, ll_riga_corrente, ll_id_riga
ls_sql_cond = ""

CHOOSE CASE dwo.name
	CASE 'sog_commerciale_gen_codice'
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_codice"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_rag_soc_1"
		
		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"codice", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF

	
	CASE "sog_commerciale_gen_rag_soc_1"
		ls_sql_cond = ""
		ls_dbc[1] = "id_sog_commerciale"
		ls_dwc[1] = "id_sog_commerciale"
		ls_dbc[2] = "codice"
		ls_dwc[2] = "sog_commerciale_gen_rag_soc_1"
		ls_dbc[3] = "rag_soc_1"
		ls_dwc[3] = "sog_commerciale_gen_codice"

		ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &
										"rag_soc_1", "A", data, & 
										ls_sql_cond, 3, &
										ls_dbc, ls_dbv, ls_dwc)
		IF (ll_ok > 0) THEN
			RETURN 2
		END IF
END CHOOSE
end event

event ue_set_search;CHOOSE CASE as_nomecol
	CASE "sog_commerciale_gen_codice"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "codice"
	CASE "sog_commerciale_gen_rag_soc_1"
			is_search_window = "w_sog_commerciale_gen_coddes_sw"
			is_ricpar.s_filter_value = as_valcol
			is_ricpar.s_filter_name = "rag_soc_1"
	CASE "id_cat_com_sc"
		is_search_window = "w_mod_single_data"
		is_ricpar.s_datawindow = "d_cat_com_sc_gd"
		is_ricpar.s_titolo_finestra = "Categoria Commerciale dei Soggetti Commerciali"			
END CHOOSE
end event

event ue_use_search;string ls_null
setnull(ls_null)
CHOOSE CASE as_nomecol
	CASE "sog_commerciale_gen_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_rag_soc_1", is_ricpar.s_ausil_value[1])
		
	CASE "sog_commerciale_gen_rag_soc_1"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_gen_codice", is_ricpar.s_ausil_value[1])
END CHOOSE
end event

type dw_1 from u_dw_master_main within w_df2cometa_ddt_cx
int X=46
int Y=248
int Width=3008
int Height=764
int TabOrder=30
string DataObject="d_tmp_df2cometa"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=false
end type

event getfocus;
end event

event losefocus;
end event

type cb_genera from commandbutton within w_df2cometa_ddt_cx
int X=2423
int Y=1028
int Width=626
int Height=204
int TabOrder=50
boolean Enabled=false
string Text="&Generazione Documenti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_id_reg_car, ll_id_reg_scar, ll_id_prof_car, ll_id_prof_scar, ll_num_prog, ll_id_sog_com, ll_id_valuta
long ll_id_art, ll_id_doc, ll_id_u_conf, ll_riga, i, ll_id_caus_car, ll_id_caus_scar, ll_id_locazione, ll_totrows
long ll_id_eser, ll_id_tab_iva, ll_id_sog_com_2, ll_id_mod_reg
long ll_id_con_pag, ll_id_banca_sc, ll_num_righe, ll_group, ll_next_group, ll_id_caus_car_art, ll_numero
decimal{2} ld_quantita
date ld_data_reg=Today()
string ls_des_art, ls_tipo_registro, ls_num_documento, ls_cliente, ls_msg, ls_omaggio
boolean errore=false
integer cont

string 			ls_tipo_applicazione		
STRING			LS_SQL_SCRIPT				
STRING			ls_app						
string 			ls_quantita
long 				ll_riga_corrente, ll_id_tab_iva_com
date 				ldt_data_attuale			
long				ll_id_U_C_in_esame		
long 				ll_sog_com					
decimal{4}		ld_prezzo, ld_prezzo_app					
string    		ls_sconto	
decimal{4}		ld_sconto_riga
long 				ll_listino					
string			ls_percentuali				
long				ll_id_cat_com_sc			
long				ll_id_art_in_esame		
long 				ll_id_cat_com_articolo	
decimal{4}		ld_qta						
long           ll_sog_com_fornitore		
long 				ll_id_produttore			
long				ll_id_listino				
string			ls_qta
long				ll_pos
long 				ll_id_registro
string 			ls_cod_art_in_esame		
long 				ll_id_magazzino
Long				ll_id_destinazione		
String			ls_con_listino				
Integer			li_pos_cond					
Long				ll_con_listino				
date				ldt_data_documento

decimal		ld_QTA_SM, ld_Sconti, ld_Totale_Riga
decimal		ld_Cambio, ld_QTA_Evasa_UB, ld_Qta_Evasa, lcd_null
decimal		ld_Totale_Riga_Lire, ld_Qta_Effettiva, ld_Totale_Riga_val,ld_peso
string		ls_tipoconv, ls_tipo_arrotondamento
decimal		ld_fatconv,  ld_molt, ld_cambio_riga, ld_cambio_documento
long			ll_id_valuta_riga, ll_valuta_documento, ll_nr_cifre_arrot, ll_id_valuta_prop, ll_id_locaz1, ll_id_locaz2
long ll_id_magazzino_1_prop, ll_id_magazzino_2_prop
decimal{4} ldc_totale_riga, ldc_val_attribuito, ldc_Totale_Riga_Lire, ld_fatglob, ld_QTA_UB, ld_Prezzo_Netto 
string ls_prezzo
long ll_valuta, ll_id_var
integer li_pos
string ls_lis_variazione, ls_tras_mezzo				

ll_totrows = dw_1.rowcount()

ll_id_prof_car = dw_prof_doc.getitemnumber(1,"id_prof_documento")
if isnull(ll_id_prof_car) then
	messagebox ("ATTENZIONE!","Non è stato specificato il Profilo DDT da usare")
	return
end if

ll_id_eser    = dw_dati_doc.getitemnumber(1,"id_esercizio")
if isnull(ll_id_eser) then
	messagebox ("ATTENZIONE!","NON E' STATO SPECIFICATO L'ESERCIZIO PER IL DOCUMENTO")
	return
end if

ll_id_tab_iva_com = dw_iva_doc.getitemnumber(1,"id_tab_iva")
if isnull(ll_id_tab_iva_com) then
	messagebox ("ATTENZIONE!","Non è stata specificata la tabella IVA da usare per gli articoli commento")
	return
end if


if ll_totrows > 0 then

	w_search_main		lw_sm
	long					ll_i_fronte, ll_row
	s_ric_param			ls_ricpar

	ls_ricpar.s_filter_name = "cc_locazione_mag"
	ls_ricpar.s_filter_value=""
	OpenWithParm (lw_sm, ls_ricpar, "w_locazione_sw")
	ls_ricpar = Message.PowerObjectParm

	IF UpperBound(ls_ricpar.s_id_seg_value) > 0 THEN ll_id_locazione = long(ls_ricpar.s_id_seg_value[1])
	
	if isnull(ll_id_locazione) or ll_id_locazione = 0 then 
   	messagebox ("ATTENZIONE!","NON E' STATA SPECIFICATA LA LOCAZIONE PER IL DOCUMENTO")		
		return 
	end if

	select tipo_registro, id_sog_comm_prop, id_caus_magazzino_prop, id_mod_registro_prop, id_valuta_prop,
	       id_locazione_1_prop, id_locazione_2_prop
	into :ls_tipo_registro, :ll_id_sog_com_2, :ll_id_caus_car, :ll_id_mod_reg, :ll_id_valuta_prop,
	     :ll_id_locaz1, :ll_id_locaz2
	from prof_documento
	where prof_documento.id_prof_documento=:ll_id_prof_car;	

	setnull(ll_id_magazzino_1_prop)
	select id_magazzino
	into :ll_id_magazzino_1_prop
	from locazione
	where id_locazione=:ll_id_locaz1;
	if isnull(ll_id_magazzino_1_prop) then setnull(ll_id_magazzino_1_prop)
	setnull(ll_id_magazzino_2_prop)
	select id_magazzino
	into :ll_id_magazzino_2_prop
	from locazione
	where id_locazione=:ll_id_locaz2;
	if isnull(ll_id_magazzino_2_prop) then setnull(ll_id_magazzino_2_prop)
	
	if not isnull(ll_id_magazzino_1_prop) then 
		ll_id_magazzino = ll_id_magazzino_1_prop
	else
		ll_id_magazzino = ll_id_magazzino_2_prop		
	end if
	
	SELECT Max("registro"."id_registro")
	INTO :ll_id_reg_car  
	FROM "dba"."registro"  
	WHERE ( "registro"."id_esercizio" = :ll_id_eser ) AND  
	( "registro"."id_mod_registro" = :ll_id_mod_reg )   ;
	
	
	
	
	if IsNull(ll_id_prof_car)or(ll_id_prof_car=0) then
		messagebox('Errore!', 'Impossibile trovare Profilo Documento')		
		return
	end if
	
	if IsNull(ll_id_reg_car)or(ll_id_reg_car=0) then 
		messagebox('Errore!', 'Impossibile trovare Registro')
		return
	end if

	if IsNull(ll_id_caus_car)or(ll_id_caus_car=0) then
		messagebox('Errore!', 'Impossibile trovare Causale')				
		return
	end if
	
	
	if isnull(ll_id_valuta_prop) or ll_id_valuta_prop =0 then
		select id_valuta
		into :ll_id_valuta
		from esercizio
		where id_esercizio = :ll_id_eser;
		if IsNull(ll_id_valuta)or(ll_id_valuta=0) then
			messagebox('Errore!', 'Impossibile trovare Valuta Esercizio')		
			return
		end if						
	else 
		ll_id_valuta = ll_id_valuta_prop
	end if
	
  // open(w_pausa)
	
	SELECT "valuta"."cifra_arrotondamento",
	"valuta"."tipo_arrotondamento"
	INTO :ll_nr_cifre_arrot ,
	  	  :ls_tipo_arrotondamento
	FROM "dba"."valuta"  
	WHERE "valuta"."id_valuta" = :ll_id_valuta;
	
	
   ll_num_righe=1
   dw_1.groupcalc()
   do
		ll_group=dw_1.FindGroupChange(ll_num_righe,1)
		if ll_group>0 then
			ll_next_group=dw_1.FindGroupChange(ll_group+1,1)
			if ll_next_group>0 then
				ll_riga=ll_next_group - 1
			else
				ll_riga=dw_1.RowCount()
			end if
		
			ll_id_sog_com = dw_1.getitemnumber(ll_group,"id_sog_commerciale")
			ls_cliente = dw_1.getitemstring(ll_group,"cod_cliente")
			
			if isnull(ll_id_sog_com) or ll_id_sog_com = 0 then 
				ls_msg = "Non è stato trovato il cliente " + ls_cliente
				messagebox("Attenzione!",ls_msg,information!,ok!)
			else	
				select id_con_pagamento, id_banca_sog_commerciale
				into :ll_id_con_pag, :ll_id_banca_sc
				from sog_commerciale
				where id_sog_commerciale = :ll_id_sog_com;
				
				
				select id_cat_com_sc, id_listino
				into :ll_id_cat_com_sc, :ll_id_listino
				from sog_commerciale
				where id_sog_commerciale = :ll_id_sog_com;
				if isnull(ll_id_cat_com_sc) then ll_id_cat_com_sc=0
				if isnull(ll_id_listino) then ll_id_listino=0		
		
				ll_numero = dw_1.getitemnumber(ll_group,"codice")	
				
				ld_data_reg = dw_1.getitemdate(ll_group,"data")
				if isnull(ld_data_reg) then ld_data_reg = today()
					
				
				select max(num_progressivo)
				into :ll_num_prog
				from documento
				where documento.id_registro=:ll_id_reg_car;
				if IsNull(ll_num_prog) then 
					ll_num_prog=1
				else
					ll_num_prog++
				end if
				
				if isnull(ll_numero) or ll_numero = 0 then
					If right(ls_tipo_registro, 1)="V" or right(ls_tipo_registro, 1)="C" then
						ls_num_documento = f_Proponi_Num_Documento_Anno(ll_id_reg_car, Year(ld_data_reg))
					else
						ls_num_documento = ""
					end if	
				else
					ls_num_documento = string(ll_numero)
				end if
			
				insert into documento (documento.id_prof_documento, documento.id_registro, documento.num_progressivo, documento.data_registrazione,
										documento.id_sog_commerciale, documento.id_valuta, documento.id_caus_magazzino, documento.id_locazione_1,
										documento.id_con_pagamento, documento.id_banca_sog_commerciale, documento.num_documento, documento.data_documento,
										documento.stampato, documento.contabilizzato, documento.evaso_totalmente, documento.chius_forzata, 
										documento.sospeso, documento.creato_in_esenzione, documento.bloccato, documento.tipo_fattura,
										documento.id_magazzino)
				values (:ll_id_prof_car, :ll_id_reg_car, :ll_num_prog, :ld_data_reg, :ll_id_sog_com, :ll_id_valuta, :ll_id_caus_car, :ll_id_locazione,
						  :ll_id_con_pag, :ll_id_banca_sc, :ls_num_documento, :ld_data_reg, 
						  'N','N','N','N','N','N','N', 'N',:ll_id_magazzino);	
					
				if sqlca.sqlcode<>0 then
					//close(w_pausa)				
					messagebox("Errore", "Documento non creato")
					errore=true		
					rollback;
					return
				else
					commit;
				end if
			
				select Max(id_documento)
				into :ll_id_doc
				from documento;
			
				
				FOR i=ll_group TO ll_riga
					ll_id_art   = dw_1.getitemnumber(i,"id_articolo")					
					ls_des_art  = dw_1.getitemstring(i,"descrizione")		
					ld_quantita = dw_1.getitemnumber(i,"quantita")				
					
					
					if isnull(ll_id_art) or ll_id_art = 0 then 
						ll_id_tab_iva = ll_id_tab_iva_com
					else
						select id_tab_iva
						into :ll_id_tab_iva
						from articolo
						where id_articolo = :ll_id_art;
						if sqlca.sqlcode <> 0 then ll_id_tab_iva = ll_id_tab_iva_com
					end if
					
					if ld_quantita = 0 then ld_quantita = 1
					ls_app= right(ls_tipo_registro, 1)
					
					
					select id_cat_com_articolo, codice
					into :ll_id_cat_com_articolo, :ls_cod_art_in_esame
					from articolo
					where id_articolo= :ll_id_art;
					if isnull(ll_id_cat_com_articolo) then ll_id_cat_com_articolo=0	
					if isnull(ls_cod_art_in_esame) then ls_cod_art_in_esame=''	

					
					
					select id_sog_commerciale, id_anagrafica
					into :ll_sog_com_fornitore, :ll_id_produttore
					from articolo
					where id_articolo= :ll_id_art;
					if isnull(ll_sog_com_fornitore) then ll_sog_com_fornitore=0	
					if isnull(ll_id_produttore) then ll_id_produttore=0	
					
					
					if isnull(ld_quantita) then ld_quantita=0
					ls_quantita=string(ld_quantita)
					ll_pos = Pos(ls_quantita, ",", 1)
					ls_quantita=replace(ls_quantita, ll_pos, 1, ".")
				
					select id_unita_confezione
					into :ll_id_u_conf
					from unita_confezione
					where (unita_confezione.id_articolo=:ll_id_art)and(unita_confezione.unita_base='S');	
					if sqlca.sqlcode <> 0 then setnull(ll_id_u_conf)
					
					SELECT fat_conversione, molteplicita, tipo_conversione
					INTO	 :ld_fatconv, :ld_molt, :ls_tipoconv
					FROM	 unita_confezione
					WHERE  id_unita_confezione = :ll_id_u_conf;	
					
					ld_prezzo      = dw_1.getitemdecimal(i,"prezzo")
					ls_sconto      = dw_1.getitemstring(i,"sconto")
					ls_omaggio     = trim(dw_1.getitemstring(i,"omaggio"))
					if ls_omaggio = "O" then ls_sconto = "100"
									
						ll_row= i
						SetNull(lcd_null)
			
						if ls_tipoconv = "D" then
							if ld_fatconv <> 0 then
								ld_fatglob = 1/ld_fatconv
							else
								ld_fatglob = 0
							end if
						else
							ld_fatglob = ld_fatconv
						end if
						ld_fatglob = ld_fatglob * ld_molt
			
						ld_QTA = ld_quantita
						if IsNull(ld_QTA) then ld_QTA=0
						ld_QTA_UB= ld_QTA * ld_Fatglob
						if IsNull(ld_Prezzo) then ld_prezzo = 0
			
						if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
						ld_cambio_riga = 1
						ld_Prezzo_Netto= wf_calcola_prezzo(ls_Sconto, ld_Prezzo, 1)	
						ld_Prezzo_Netto=f_Round(ld_Prezzo_Netto ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
						if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0
			
						if not IsNull(ld_Prezzo_Netto) then 
							ld_qta_Effettiva= ld_quantita 
							ldc_Totale_Riga= wf_trova_prezzo(ll_id_u_conf, ld_qta_Effettiva, 0, ld_Prezzo_Netto)
			
							ldc_Totale_Riga= f_Round(ldc_Totale_Riga ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
							if ld_qta_effettiva > 0 then 
								ldc_val_attribuito = ldc_Totale_Riga / ld_qta_Effettiva
							else
								ldc_val_attribuito = 0							
							end if
			
							ldc_Totale_Riga_Lire= ldc_Totale_Riga * ld_Cambio_riga 
						else
							ld_Prezzo_Netto=0
							ldc_totale_riga = 0
							ldc_totale_riga_lire = 0			
						end if
								
						if isnull(ll_id_u_conf) then
							insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
											riga_documento.quantita,
											riga_documento.descrizione, riga_documento.id_locazione_1, 
											riga_documento.id_caus_magazzino, riga_documento.fat_con_unita_base,
											riga_documento.fat_con_globale, riga_documento.qta_un_base, riga_documento.id_tab_iva,
											riga_documento.id_listino, riga_documento.prezzo,
											riga_documento.sconto, riga_documento.sconto_riga, 
											riga_documento.prezzo_netto, riga_documento.tot_riga_val_riga,
											riga_documento.val_attribuito, riga_documento.tot_riga_val_az, riga_documento.tot_riga_val_doc)
							values (:ll_id_doc, :i, :ll_id_valuta, :ld_quantita, :ls_des_art, 
									:ll_id_locazione, :ll_id_caus_car, 1, :ld_fatglob, :ld_QTA_UB, :ll_id_tab_iva, :ll_id_var,
									:ld_prezzo, :ls_sconto, :ld_sconto_riga, :ld_prezzo_netto, :ldc_Totale_Riga,
									:ldc_val_attribuito, :ldc_Totale_Riga_Lire, :ldc_Totale_Riga);									
						else
							insert into riga_documento (riga_documento.id_documento, riga_documento.num_riga, riga_documento.id_valuta, 
											riga_documento.id_articolo, riga_documento.quantita,
											riga_documento.descrizione, riga_documento.id_unita_confezione, riga_documento.id_locazione_1, 
											riga_documento.id_caus_magazzino, riga_documento.fat_con_unita_base,
											riga_documento.fat_con_globale, riga_documento.qta_un_base, riga_documento.id_tab_iva,
											riga_documento.id_listino, riga_documento.prezzo,
											riga_documento.sconto, riga_documento.sconto_riga, 
											riga_documento.prezzo_netto, riga_documento.tot_riga_val_riga,
											riga_documento.val_attribuito, riga_documento.tot_riga_val_az, riga_documento.tot_riga_val_doc)
							values (:ll_id_doc, :i, :ll_id_valuta, :ll_id_art, :ld_quantita, :ls_des_art, 
									:ll_id_u_conf, :ll_id_locazione, :ll_id_caus_car, 1, :ld_fatglob, :ld_QTA_UB, :ll_id_tab_iva, :ll_id_var,
									:ld_prezzo, :ls_sconto, :ld_sconto_riga, :ld_prezzo_netto, :ldc_Totale_Riga,
									:ldc_val_attribuito, :ldc_Totale_Riga_Lire, :ldc_Totale_Riga);		
						end if
					
				NEXT	
				
				
				
				if sqlca.sqlcode<>0 then
					//close(w_pausa)					
					messagebox("",sqlca.sqlerrtext)
					messagebox("Errore", "Riga documento non creata")
					errore=true		
					rollback;
				else
					commit;
				//	close(w_pausa)					
					messagebox("Informazione","Generato Documento N. " + string(ll_num_prog) + " del " + string(ld_data_reg))
					
					
				end if	
			end if
		end if		
		ll_num_righe=ll_group+1
	Loop Until ll_group=0		
					
   
	
end if	

end event

type st_1 from statictext within w_df2cometa_ddt_cx
int X=50
int Y=1068
int Width=928
int Height=56
boolean Enabled=false
string Text="Percorso File ASCII per importazione DDT:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_df2cometa_ddt_cx
int X=50
int Y=1132
int Width=1573
int Height=92
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=15793151
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_importa from commandbutton within w_df2cometa_ddt_cx
int X=46
int Y=40
int Width=439
int Height=132
int TabOrder=10
string Text="&Importazione DDT"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_nome, ls_msg, ls_riga, ls_articolo, ls_numdoc, ls_cau, ls_anno, ls_numero
boolean lb_esiste
integer li_app, li_eof, li_iva, li_riga
string ls_datareg, ls_datadoc, ls_nriga, ls_stringa
string ls_qta, ls_importo, ls_mese, ls_giorno, ls_provdest, ls_taglia, ls_pezzi
long ll_id_articolo, ll_id_rch_caus_mag, li_pos, ll_ret, ll_id_sog_com, ll_numero
date ld_data_doc
dec ld_quantita, ld_importo
string ls_cliente, ls_desart, ls_sconto, ls_iva, ls_omaggio

dw_1.reset()
cb_genera.enabled = false

ls_nome = sle_1.text
if isnull(ls_nome) or ls_nome = '' then ls_nome = "C:\ddt.txt"

lb_esiste=fileexists(ls_nome)
if lb_esiste=true then
//	open(w_pausa)
	
	DELETE FROM tmp_df2cometa;
	
	li_app=fileopen(ls_nome)	
	li_eof=0

	do while li_eof<>-100 

		li_eof=fileread(li_app,ls_numero)			
		li_eof=fileread(li_app,ls_datareg)					
		li_eof=fileread(li_app,ls_cliente)					
		li_eof=fileread(li_app,ls_nriga)			
		li_eof=fileread(li_app,ls_articolo)					
		li_eof=fileread(li_app,ls_desart)
		li_eof=fileread(li_app,ls_qta)		
		li_eof=fileread(li_app,ls_importo)				
		li_eof=fileread(li_app,ls_sconto)							
		li_eof=fileread(li_app,ls_iva)							
		li_eof=fileread(li_app,ls_omaggio)													
					
		if li_eof<> -100 then
			ls_articolo = trim(ls_articolo)

			select id_articolo 
			into :ll_id_articolo
			from articolo
			where codice = :ls_articolo;				
			if sqlca.sqlcode <> 0 then ll_id_articolo = 0
			
			ls_cliente = left(ls_cliente,2) + "00" + right(ls_cliente,4)				
			select id_sog_commerciale
			into :ll_id_sog_com
			from sog_commerciale
			where codice = :ls_cliente;
			if sqlca.sqlcode <> 0 then ll_id_sog_com = 0					
			
			ls_anno   = right(ls_datareg,4)
			ls_giorno = left(ls_datareg,2)
			ls_mese   = mid(ls_datareg,4,2)
		
			ls_datareg = ls_anno + "-" + ls_mese + "-" + ls_giorno
			ld_data_doc = date(ls_datareg)
	
			li_pos = pos(ls_qta, ".")			
			if li_pos > 0 then ls_qta = replace(ls_qta,li_pos,1, ",")
			ld_quantita = dec(ls_qta)			
	
			li_pos = pos(ls_importo, ".")			
			if li_pos > 0 then ls_importo = replace(ls_importo,li_pos,1, ",")			
			ld_importo = dec(ls_importo)
			
			ld_importo = round((ld_importo/1936.27),4)
			
			ll_numero = long(ls_numero)					
			li_riga = integer(ls_nriga)
			li_iva = integer(ls_iva)
		
			insert into tmp_df2cometa (codice, data, cod_cliente, n_riga, articolo, descrizione, quantita, prezzo, sconto, iva, omaggio, id_articolo, id_sog_commerciale)
			values (:ll_numero, :ld_data_doc, :ls_cliente, :li_riga, :ls_articolo, :ls_desart, :ld_quantita, :ld_importo, :ls_sconto, :li_iva, :ls_omaggio, :ll_id_articolo, :ll_id_sog_com);
			if sqlca.sqlcode <> 0 then
			//	close(w_pausa)				
				messagebox("ATTENZIONE",sqlca.sqlerrtext)
				fileclose(li_app)	
				return
			end if

		end if	
	loop
	
	fileclose(li_app)	
//	close(w_pausa)	
	
   
	commit;
	ll_ret = dw_1.retrieve()
	if ll_ret > 0 then cb_genera.enabled = true
else
	ls_msg = "il file ASCII " + ls_nome + " non è stato trovato"
	messagebox("ATTENZIONE",ls_msg)
end if

end event

