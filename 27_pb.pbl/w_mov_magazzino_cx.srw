forward
global type w_mov_magazzino_cx from w_p_data
end type
type cb_deriva from commandbutton within tabpage_1
end type
type cb_note from commandbutton within tabpage_1
end type
type cb_blocco from commandbutton within tabpage_1
end type
type cb_deriva from commandbutton within tabpage_1
end type
type cb_note from commandbutton within tabpage_1
end type
type cb_blocco from commandbutton within tabpage_1
end type
type p_stampa from picture within w_mov_magazzino_cx
end type
type dw_documento_ordine_ff from u_dw_master_main within w_mov_magazzino_cx
end type
type p_arrow from picture within w_mov_magazzino_cx
end type
type dw_riga_documento_ordine_gd from u_dw_master_main within w_mov_magazzino_cx
end type
type dw_riga_documento_dett_ord_ff from u_dw_master_main within w_mov_magazzino_cx
end type
type cbx_simbolo from checkbox within w_mov_magazzino_cx
end type
end forward

global type w_mov_magazzino_cx from w_p_data
int X=329
int Y=36
int Width=2802
int Height=1712
boolean TitleBar=true
string Title="Movimenti Semplificati"
event ue_tipo_documento ( )
event ue_ges_sp_incasso ( )
p_stampa p_stampa
dw_documento_ordine_ff dw_documento_ordine_ff
p_arrow p_arrow
dw_riga_documento_ordine_gd dw_riga_documento_ordine_gd
dw_riga_documento_dett_ord_ff dw_riga_documento_dett_ord_ff
cbx_simbolo cbx_simbolo
end type
global w_mov_magazzino_cx w_mov_magazzino_cx

type variables
w_mov_magazzino_cx	iw_corrente
u_dw_main	idw_gen
u_dw_main	idw_riga  
u_dw_main	idw_riga_tot
u_dw_main	idw_gen_trasp
u_dw_main	idw_scadenza
u_dw_main	idw_gen_tot
u_dw_main	idw_gen_tot_ext
u_dw_main	idw_spesa
u_dw_main	idw_castelletto
u_dw_main	idw_contropartita
long 		il_row
long 		il_id_documento
long 		il_arrotondamento
decimal		idc_cambio
string		is_tipo_arrotondamento
string 		is_simbolo_valuta
string		is_tipo_documento
string		is_nome_tipo_documento
string		is_last_field
string		is_int_consentiti, is_tipo_registro
string		is_stato_scad_generata
boolean		ib_genera_scadenza = TRUE
boolean		ib_genera_castelletto = FALSE
boolean		ib_crea_spesa=FALSE
boolean		ib_vis_esi_disponibilita=FALSE
boolean		ib_reset=FALSE
long		il_id_mod_registro, il_id_registro, il_id_esercizio
long		il_id_tab_iva
long		il_id_tab_iva_art_15
long		il_id_conto_predefinito
string		is_esenzione

long		il_id_spesa_bollo

long		il_id_spesa_incasso
decimal		idc_spesa_inc_importo

uo_esp_pag	iuo_pag

string		 is_ric_riga, is_ric_documento

string		 is_con_data_progressiva

string		is_blocco

boolean		ib_prot_modificato=FALSE

boolean		ib_cast_modificato=FALSE


end variables

forward prototypes
public function decimal uf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita)
public function integer uf_set_des_articolo (long al_row, long al_id_lingua, long al_id_linguaggio, long al_id_sog_comm)
public function integer uf_set_ric (string as_value, string as_field, datawindow adw_datawindow)
public function long uf_calc_des_art (long al_id_articolo, long al_id_sog_comm, long al_id_lingua, long al_id_linguaggio)
public function long uf_ges_eventi (string as_evento)
public function string uf_check_sospesi ()
public function string uf_calc_eva_doc (u_dw_main adw_righe)
public function string uf_calc_stato_doc ()
public function long uf_calc_locazione (long al_id_magazzino)
public function integer uf_set_dec_mask (integer ai_decimali, string as_valuta)
public function decimal uf_round (decimal adc_numero)
public function integer uf_set_mask_riga ()
public function string uf_update_info ()
public function long uf_dw_changed (u_dw_master_main adw_current)
public function integer uf_importa_righe (s_par_der_doc astr_par)
public function long wf_calcola_cpt (long al_id_sog_commerciale, long al_id_gr_agente, long al_id_articolo)
public function integer uf_ricerca ()
public function integer uf_set_documento ()
public function integer uf_set_istanze ()
public function integer uf_set_title ()
public function boolean uf_riga_valida (long al_row)
public function long uf_set_currow ()
public function integer uf_default_focus ()
public function integer uf_stampa ()
public function integer uf_wizard_riga ()
public function integer uf_nuovo_documento ()
public function integer uf_load_documento (long al_id_documento)
public function integer uf_report_righe ()
public function boolean uf_is_modified ()
public function integer uf_agg_loc_1_riga (long al_id_magazzino)
public function integer uf_agg_loc_2_riga (long al_id_magazzino)
end prototypes

event ue_tipo_documento;call super::ue_tipo_documento;

is_nome_tipo_documento= "Movimenti Semplificati"
this.Title = "Movimenti Semplificati"


end event

event ue_ges_sp_incasso;call super::ue_ges_sp_incasso;
long ll_id_sog_commerciale

ll_id_sog_commerciale= idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
SELECT "spesa"."id_spesa" ,"spesa_sog_commerciale"."importo"  
	INTO :il_id_spesa_incasso , 
		:idc_spesa_inc_importo  
	FROM "dba"."spesa_sog_commerciale",   
		"dba"."spesa"  
	WHERE ( "spesa"."id_spesa" = "spesa_sog_commerciale"."id_spesa" ) and  
		( ( "spesa"."codice" = 'C' ) AND  
		( "spesa_sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) )   ;

end event

public function decimal uf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita);
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

public function integer uf_set_des_articolo (long al_row, long al_id_lingua, long al_id_linguaggio, long al_id_sog_comm);
long ll_row, ll_id_articolo, ll_id_des_articolo
ll_id_articolo= dw_riga_documento_ordine_gd.GetItemNumber( al_row, "riga_documento_id_articolo")
if not (IsNull(al_id_lingua) OR IsNull(al_id_linguaggio) OR IsNull(al_id_sog_comm) OR IsNull(ll_id_articolo)) then
		SELECT Max("des_articolo"."id_des_articolo" )
		 INTO :ll_id_des_articolo  
		 FROM "dba"."des_articolo",   
				"dba"."sog_commerciale",   
				"dba"."anagrafica"  
		WHERE ( "sog_commerciale"."id_sog_commerciale" = "des_articolo"."id_sog_commerciale" ) and  
				( "anagrafica"."id_anagrafica" = "sog_commerciale"."id_anagrafica" ) and  
				( "anagrafica"."id_lingua" =:al_id_lingua ) and  
				( "anagrafica"."id_linguaggio" = :al_id_linguaggio ) and  
				( ( "des_articolo"."id_articolo" = :ll_id_articolo ) AND  
				( "sog_commerciale"."id_sog_commerciale" = :al_id_sog_comm ) )   ;
	if SQLCA.SQLCode = 100 or (IsNull(ll_id_des_articolo) OR ll_id_des_articolo=0) then
	SELECT Max("des_articolo"."id_des_articolo" )
			 INTO :ll_id_des_articolo  
			 FROM "dba"."des_articolo"  
			WHERE ( "des_articolo"."id_linguaggio" = :al_id_linguaggio ) AND  
					( "des_articolo"."id_lingua" = :al_id_lingua ) AND  
					( "des_articolo"."id_sog_commerciale" IS NULL ) AND  
					( "des_articolo"."id_articolo" = :ll_id_articolo ) AND   
					( "des_articolo"."id_azienda" = 1 );
		if IsNull(ll_id_des_articolo) OR (SQLCA.SQLCode=100) then
			SELECT Max("des_articolo"."id_des_articolo" )
			 INTO :ll_id_des_articolo  
			 FROM "dba"."des_articolo",   
					"dba"."sog_commerciale",   
					"dba"."anagrafica"  
			WHERE ( "anagrafica"."id_anagrafica" = "sog_commerciale"."id_anagrafica" ) and  
					( "anagrafica"."id_lingua" = "des_articolo"."id_lingua" ) and  
					( "anagrafica"."id_linguaggio" = "des_articolo"."id_linguaggio" ) and  
					( ( "des_articolo"."id_articolo" = :ll_id_articolo ) AND  
					( "sog_commerciale"."id_sog_commerciale" = :al_id_sog_comm ) ) ;
		end if
	end if
	if not (IsNull(ll_id_des_articolo) OR ll_id_des_articolo = 0) then dw_riga_documento_ordine_gd.SetItem(al_row, "riga_documento_id_des_articolo", ll_id_des_articolo)
end if
return 0
end function

public function integer uf_set_ric (string as_value, string as_field, datawindow adw_datawindow);

string ls_color
CHOOSE CASE as_value
	CASE "N"
		f_displayonly(adw_datawindow, as_field, TRUE)

		
		ls_color = "276856960"
		adw_datawindow.Modify(as_field + ".color = " + ls_color)
	CASE "L"
		f_displayonly(adw_datawindow, as_field, TRUE)
		ls_color= f_get_dwo_property(adw_datawindow.Describe(as_field + ".color"), "0", "")
		adw_datawindow.Modify(as_field + ".color = " + ls_color)
		
		adw_datawindow.Modify(as_field + ".color = 0")

	CASE "M"
		f_displayonly(adw_datawindow, as_field, FALSE)
		ls_color= f_get_dwo_property(adw_datawindow.Describe(as_field + ".color"), "0", "")
		adw_datawindow.Modify(as_field + ".color = " + ls_color)

		CHOOSE CASE String(adw_datawindow.Describe(as_field + ".edit.style"))
			CASE "edit"
				adw_datawindow.Modify(as_field + ".edit.nilisnull = FALSE")
				adw_datawindow.Modify(as_field + ".edit.required = FALSE")
			CASE "dddw"
				adw_datawindow.Modify(as_field + ".dddw.required = FALSE")

			CASE "ddlb"
				adw_datawindow.Modify(as_field + ".ddlb.required = FALSE")
			CASE "editmask"
				adw_datawindow.Modify(as_field + ".editmask.required = FALSE")
			CASE ELSE
		END CHOOSE
	CASE "O"
		CHOOSE CASE String(adw_datawindow.Describe(as_field + ".edit.style"))
			CASE "edit"
				adw_datawindow.Modify(as_field + ".edit.nilisnull = TRUE")
				adw_datawindow.Modify(as_field + ".edit.required = TRUE")
			CASE "dddw"
				adw_datawindow.Modify(as_field + ".dddw.required = TRUE")

			CASE "ddlb"
				adw_datawindow.Modify(as_field + ".ddlb.required = TRUE")
			CASE "editmask"
				adw_datawindow.Modify(as_field + ".editmask.required = TRUE")
			CASE ELSE
		END CHOOSE
END CHOOSE
return 0
end function

public function long uf_calc_des_art (long al_id_articolo, long al_id_sog_comm, long al_id_lingua, long al_id_linguaggio);

long ll_id_des_articolo

SetNull(ll_id_des_articolo)

SELECT Max("des_articolo"."id_des_articolo" )
 INTO :ll_id_des_articolo  
 FROM "dba"."des_articolo"  
WHERE ( "des_articolo"."id_linguaggio" = :al_id_linguaggio ) AND  
		( "des_articolo"."id_lingua" = :al_id_lingua ) AND  
		( "des_articolo"."id_sog_commerciale" = :al_id_sog_comm ) AND  
		( "des_articolo"."id_articolo" = :al_id_articolo ) AND 
		( "des_articolo"."id_azienda" = 1 );

if IsNull(ll_id_des_articolo) OR (SQLCA.SQLCode=100) then
	SELECT Max("des_articolo"."id_des_articolo" )
		 INTO :ll_id_des_articolo  
		 FROM "dba"."des_articolo"  
		WHERE ( "des_articolo"."id_linguaggio" = :al_id_linguaggio ) AND  
				( "des_articolo"."id_lingua" = :al_id_lingua ) AND  
				( "des_articolo"."id_sog_commerciale" IS NULL ) AND  
				( "des_articolo"."id_articolo" = :al_id_articolo ) AND   
				( "des_articolo"."id_azienda" = 1 );
	if IsNull(ll_id_des_articolo) OR (SQLCA.SQLCode=100) then
		SELECT Max("des_articolo"."id_des_articolo" )
			 INTO :ll_id_des_articolo  
			 FROM "dba"."des_articolo"  
			WHERE ( "des_articolo"."id_linguaggio" = :al_id_linguaggio ) AND  
					( "des_articolo"."id_lingua" = :al_id_lingua ) AND  
					( "des_articolo"."id_articolo" = :al_id_articolo ) AND   
					( "des_articolo"."id_azienda" = 1 );
	end if
end if

RETURN ll_id_des_articolo

end function

public function long uf_ges_eventi (string as_evento);

long 			ll_nr_campi, ll_count
string 		ls_name

dwobject ldw[]

CHOOSE CASE as_evento
		CASE "STAMPATO", "BLOCCATO", "CONTABILIZZATO"
			idw_gen.enabled= FALSE
			idw_riga.enabled= FALSE
			idw_spesa.enabled= FALSE
			idw_riga_tot.enabled= FALSE
			idw_gen_tot.enabled= FALSE
			tab_1.tabpage_1.cb_note.enabled= FALSE

		CASE ELSE 
			idw_gen.enabled= TRUE
			idw_riga.enabled= TRUE
			idw_spesa.enabled= TRUE
			idw_riga_tot.enabled= TRUE
			idw_gen_tot.enabled= TRUE

END CHOOSE


return 0
end function

public function string uf_check_sospesi ();

RETURN "OK"

end function

public function string uf_calc_eva_doc (u_dw_main adw_righe);long		ll_righe, ll_i, ll_et, ll_ep, ll_ne, ll_cf, ll_nc
decimal	ld_qta1, ld_qta2
string	ls_cf, ls_r1, ls_r2, ls_ret

ll_et = 0
ll_ep = 0
ll_ne = 0
ll_righe = adw_righe.RowCount()
if ll_righe > 0 then
	for ll_i = 1 to ll_righe
		ld_qta1 = adw_righe.uf_GetItemDecimal(ll_i,"quantita") + &
						adw_righe.uf_GetItemDecimal(ll_i,"qta_sconto_merce")
		ld_qta2 = adw_righe.uf_GetItemDecimal(ll_i,"qta_evasa")
		ls_cf = adw_righe.GetItemString(ll_i,"riga_documento_forza_chius_evasione")
		if (ld_qta1 > 0) and (ld_qta2 = 0) then ll_ne = ll_ne + 1
		if (ld_qta1 > 0) and (ld_qta2 >= ld_qta1) then ll_et = ll_et + 1
		if (ld_qta1 > 0) and (ld_qta2 > 0) and (ld_qta2 <  ld_qta1) then ll_ep = ll_ep + 1
		if (ls_cf = "S") then
			ll_cf = ll_cf + 1
		else
			ll_nc = ll_nc + 1
		end if
	next
	if ((ll_et = 0) and (ll_ep = 0)) then
		ls_r1 = "N"
	else
		if ((ll_et > 0) and (ll_ep = 0) and (ll_ne = 0)) then
			ls_r1 = "T"
		else
			ls_r1 = "P"
		end if
	end if
	if (ll_cf = 0) then
		ls_r2 = "N"
	else
		if (ll_nc = 0) then
			ls_r2 = "T" 
		else
			ls_r2 = "P" 
		end if
	end if
else
	ls_r1 = "N"
	ls_r2 = "N"
end if

ls_ret = ls_r1 + ls_r2
return ls_ret
end function

public function string uf_calc_stato_doc ();


string 	ls_ret, ls_st

ls_st = dw_documento_ordine_ff.uf_get_colval("bloccato")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = dw_documento_ordine_ff.uf_get_colval("documento_chius_forzata")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = dw_documento_ordine_ff.uf_get_colval("documento_contabilizzato")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = uf_calc_eva_doc(dw_riga_documento_ordine_gd)
ls_ret = ls_ret + ls_st


ls_st = dw_documento_ordine_ff.uf_get_colval("documento_sospeso")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if


ls_st = dw_documento_ordine_ff.uf_get_colval("documento_stampato")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = dw_documento_ordine_ff.uf_get_colval("creato_in_esenzione")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if


return ls_ret
end function

public function long uf_calc_locazione (long al_id_magazzino);
long ll_id_locazione

SELECT max("locazione"."id_locazione")
	INTO :ll_id_locazione  
	FROM "dba"."locazione",   
		"dba"."magazzino"  
	WHERE ( "magazzino"."id_magazzino" = "locazione"."id_magazzino" ) and  
		( "magazzino"."id_magazzino" = :al_id_magazzino) and  
		( "locazione"."id_area" IS NULL ) AND  
		( "locazione"."corsia" IS NULL ) AND  
		( "locazione"."scaffale" IS NULL ) AND  
		( "locazione"."ripiano" IS NULL ) AND  
		( "locazione"."posizione" IS NULL ) ;

RETURN ll_id_locazione
end function

public function integer uf_set_dec_mask (integer ai_decimali, string as_valuta);
string 		ls_mask, ls_mask_lire, ls_simbolo_lire
decimal 		ldc_cambio_lire
integer		ll_arrot_lire, li_decimali
integer 		li_count
boolean 		lb_simbolo

lb_simbolo= cbx_simbolo.Checked
ls_mask= "#,0"
li_decimali= ai_decimali
li_decimali = - li_decimali
if li_decimali > 0 then
	ls_mask = ls_mask + "."
	FOR li_count = 1 to li_decimali
		ls_mask = ls_mask + "0"
	NEXT
end if
if (as_valuta <> "" AND lb_simbolo= TRUE) then ls_mask = as_valuta + " " + ls_mask
SELECT "valuta"."simbolo",   
		"valuta"."cambio",   
		"valuta"."cifra_arrotondamento"
	INTO :ls_simbolo_lire,   
		:ldc_cambio_lire,   
		:ll_arrot_lire 
	FROM "dba"."valuta"  
	WHERE "valuta"."cambio" = 1  ;

ls_mask_lire= "#,0"
ll_arrot_lire = - ll_arrot_lire
if ll_arrot_lire > 0 then
	ls_mask_lire = ls_mask_lire + "."
	FOR li_count = 1 to li_decimali
		ls_mask_lire = ls_mask_lire + "0"
	NEXT
end if
if ls_simbolo_lire <> "" AND lb_simbolo= TRUE then ls_mask_lire = ls_simbolo_lire + " " + ls_mask_lire


idw_gen.Modify("documento_cambio.format = '" + ls_mask_lire + "'")

idw_riga.Modify("c_tot_righe_lire.format = '" + ls_mask_lire + "'")
idw_riga.Modify("c_tot_righe.format = '" + ls_mask + "'")

if is_tipo_documento = "P" then
	idw_gen.Modify("sconto_fin_incondizionato.format = '" + ls_mask + "'")
	idw_gen.Modify("c_totale_righe.format = '" + ls_mask + "'")
	idw_gen.Modify("c_totale_scontato.format = '" + ls_mask + "'")
end if 
uf_set_mask_riga()

return 0

end function

public function decimal uf_round (decimal adc_numero);
decimal 	ldc_ret_number, ldc_precisione
long ll_arrotondamento

ll_arrotondamento= il_arrotondamento
If ll_arrotondamento >= 0 then
	ldc_precisione = 10^ll_arrotondamento
else
	ll_arrotondamento= - ll_arrotondamento
	ldc_precisione = 1 / (10^ll_arrotondamento)
end if

CHOOSE CASE is_tipo_arrotondamento
	CASE "I"
		
		ldc_ret_number = adc_numero / ldc_precisione
		ldc_ret_number = Truncate(ldc_ret_number, 0) * ldc_precisione
	CASE "M"
	
		ldc_ret_number = adc_numero / ldc_precisione
		ldc_ret_number = Round(ldc_ret_number, 0) * ldc_precisione
	CASE "S"
		
		ldc_ret_number = adc_numero / ldc_precisione
		ldc_ret_number = Ceiling(ldc_ret_number) * ldc_precisione
	CASE ELSE
END CHOOSE

RETURN ldc_ret_number
end function

public function integer uf_set_mask_riga ();
string 		ls_mask, ls_simbolo
long 			ll_row, ll_id_valuta
decimal 		ldc_cambio
integer		ll_arrotondamento, li_decimali
integer 		li_count
boolean 		lb_simbolo

lb_simbolo= cbx_simbolo.Checked
ls_mask= "#,0"
ll_row= idw_riga.GetRow()
if ll_row > 0 then
	ls_mask= "#,0"
	ll_id_valuta= idw_riga.GetItemNumber(ll_row, "riga_documento_id_valuta")
	if not(IsNull(ll_id_valuta) OR ll_id_valuta=0) then
		ldc_cambio= idw_riga.uf_GetItemDecimal(ll_row, "riga_documento_cambio")
		SELECT "valuta"."simbolo",   
				"valuta"."cifra_arrotondamento"  
			INTO :ls_simbolo,   
				:ll_arrotondamento  
			FROM "dba"."valuta"  
			WHERE "valuta"."id_valuta" = :ll_id_valuta   ;
	
		li_decimali = - ll_arrotondamento
		if li_decimali > 0 then
			ls_mask = ls_mask + "."
			FOR li_count = 1 to li_decimali
				ls_mask = ls_mask + "0"
			NEXT
		end if
		if ls_simbolo <> "" AND lb_simbolo= TRUE then ls_mask = ls_simbolo + " " + ls_mask
	end if
	idw_riga_tot.Modify("prezzo_netto.format = '" + ls_mask + "'")
	idw_riga_tot.Modify("prezzo_netto.edit.mask = '" + ls_mask + "'")
	idw_riga_tot.Modify("tot_riga_val_riga.format = '" + ls_mask + "'")
end if 

return 0


end function

public function string uf_update_info ();

long 			ll_count, ll_size, ll_row_count
boolean 		lb_dw_changed
string 		ls_Report
u_dw_master_main	ldw_children

ll_size= UpperBound(idw_master.iudw_children)
FOR ll_count= 1 to ll_size
	ldw_children= idw_master.iudw_children[ll_count]
	lb_dw_changed= FALSE
	if not ldw_children.ib_dw_shared then
	
		if uf_dw_changed(ldw_children) > 0 then lb_dw_changed= TRUE
	end if
	
	If lb_dw_changed then ls_Report= ls_Report + "~n"+ ldw_children.is_title
NEXT

RETURN ls_Report

end function

public function long uf_dw_changed (u_dw_master_main adw_current);
long 			ll_size, ll_row_count, ll_row_changed
boolean 		lb_dw_changed
string 		ls_Report


lb_dw_changed= FALSE
if adw_current.RowCount() > 0 AND (not adw_current.ib_dw_shared) then
	ll_size= adw_current.RowCount()
	FOR ll_row_count= 1 to ll_size
		If (adw_current.GetItemStatus(adw_current.RowCount(), 0, Primary!)<> NotModified!) then
			ll_row_changed= ll_row_changed + 1
		end if
	NEXT
end if

return ll_row_changed
end function

public function integer uf_importa_righe (s_par_der_doc astr_par);




long		ll_size, ll_count, ll_row
boolean	lb_ricc

long		ll_idriga, ll_idart, ll_iddes, ll_idunc,ll_idcaus
long		ll_idl1, ll_idl2, ll_idval, ll_idlis, ll_idcla, ll_idiva
long		ll_idage, ll_idctr, ll_idcpt, ll_idazi
string	ls_descr, ls_scon
decimal	ld_fcub, ld_fcgl, ld_camb, ld_prez, ld_scri, ld_psnt, ld_pslo
decimal	ld_diml, ld_dimh, ld_dimp, ld_numc, ld_prv1, ld_prv2, ld_prv3, ld_vatt
date		ldt_cns, ldt_dic, ldt_dfc

				
lb_ricc = false

ll_size = upperbound(astr_par.s_dbn)

for ll_count = 1 to ll_size
	

	ll_idriga = long(astr_par.s_dbn[ll_count])
	ll_idcaus = long(astr_par.s_dbt[ll_count])
	if ll_idcaus <= 0 or isNull(ll_idcaus) then 
		ll_idcaus = long(idw_gen.uf_get_colval("documento_id_caus_magazzino"))
	end if
	if ll_idcaus <= 0 then SetNull(ll_idcaus)

	SELECT "riga_documento"."id_articolo",				"riga_documento"."descrizione",
			 "riga_documento"."id_des_articolo",	 	"riga_documento"."id_unita_confezione",
			 "riga_documento"."fat_con_unita_base",	"riga_documento"."fat_con_globale",
			 "riga_documento"."id_locazione_1",       "riga_documento"."id_locazione_2",
			 "riga_documento"."id_valuta",				"riga_documento"."cambio",
			 "riga_documento"."id_listino",				"riga_documento"."id_con_lis_articolo",
			 "riga_documento"."prezzo",					"riga_documento"."sconto",
			 "riga_documento"."sconto_riga",
			 "riga_documento"."data_prevista_consegna",
			 "riga_documento"."peso_netto",				"riga_documento"."peso_lordo",
			 "riga_documento"."dim_l",						"riga_documento"."dim_h",
			 "riga_documento"."dim_p",						"riga_documento"."num_colli",
			 "riga_documento"."id_tab_iva",				"riga_documento"."id_gruppo_agenti",
			 "riga_documento"."provv_agente",			"riga_documento"."provv_subage",
			 "riga_documento"."provv_carea",				"riga_documento"."val_attribuito",
			 "riga_documento"."id_caus_trasporto",
			 "riga_documento"."data_inizio_competenza",
			 "riga_documento"."data_fine_competenza",
			 "riga_documento"."id_conto",					"riga_documento"."id_azienda"
			 
	INTO	:ll_idart, :ls_descr, :ll_iddes, :ll_idunc, :ld_fcub, :ld_fcgl,
			:ll_idl1,  :ll_idl2,  :ll_idval, :ld_camb,  :ll_idlis, :ll_idcla,
			:ld_prez,  :ls_scon,  :ld_scri,  :ldt_cns, :ld_psnt,  :ld_pslo,
			:ld_diml,  :ld_dimh,  :ld_dimp,  :ld_numc, :ll_idiva, :ll_idage,
			:ld_prv1,  :ld_prv2,  :ld_prv3,  :ld_vatt,  :ll_idctr,
			:ldt_dic,  :ldt_dfc,  :ll_idcpt, :ll_idazi
			 
	FROM "dba"."riga_documento"  
	WHERE "riga_documento"."id_riga_documento" = :ll_idriga   ;

	if SQLCA.SQLCode = 0 then

		idw_riga.event ue_insert(0,0)
		ll_row = idw_riga.GetRow()
	
		if ll_row>0 then
			
			
			idw_riga.SetItem(ll_row,"riga_documento_id_articolo",ll_idart)
			idw_riga.SetItem(ll_row,"riga_documento_descrizione",ls_descr)
			idw_riga.SetItem(ll_row,"riga_documento_id_des_articolo",ll_iddes)
			idw_riga.SetItem(ll_row,"riga_documento_id_unita_confezione",ll_idunc)
			
			idw_riga.SetItem(ll_row,"quantita",dec(astr_par.s_op[ll_count]))
			idw_riga.SetItem(ll_row,"qta_sconto_merce",dec(astr_par.s_dbv[ll_count]))
			idw_riga.SetItem(ll_row,"qta_evasa",0)
	
			idw_riga.SetItem(ll_row,"riga_documento_fat_con_unita_base",ld_fcub)
			idw_riga.SetItem(ll_row,"fat_con_globale",ld_fcgl)
			idw_riga.SetItem(ll_row,"riga_documento_id_caus_magazzino",ll_idcaus)
			idw_riga.SetItem(ll_row,"id_locazione_1",ll_idl1)
			idw_riga.SetItem(ll_row,"id_locazione_2",ll_idl2)
			idw_riga.SetItem(ll_row,"riga_documento_id_valuta",ll_idval)
			idw_riga.SetItem(ll_row,"riga_documento_cambio",ld_camb)
			idw_riga.SetItem(ll_row,"riga_documento_id_listino",ll_idlis)
			idw_riga.SetItem(ll_row,"riga_documento_id_con_lis_articolo",ll_idcla)
			idw_riga.SetItem(ll_row,"prezzo",ld_prez)
			idw_riga.SetItem(ll_row,"sconto",ls_scon)
			idw_riga.SetItem(ll_row,"riga_documento_sconto_riga",ld_scri)
			idw_riga.SetItem(ll_row,"riga_documento_data_prevista_consegna",ldt_cns)
			idw_riga.SetItem(ll_row,"riga_documento_peso_netto",ld_psnt)
			idw_riga.SetItem(ll_row,"riga_documento_peso_lordo",ld_pslo)
			idw_riga.SetItem(ll_row,"riga_documento_dim_l",ld_diml)
			idw_riga.SetItem(ll_row,"riga_documento_dim_h",ld_dimh)
			idw_riga.SetItem(ll_row,"riga_documento_dim_p",ld_dimp)
			idw_riga.SetItem(ll_row,"riga_documento_num_colli",ld_numc)
	
			
			idw_riga.SetItem(ll_row,"riga_documento_id_tab_iva",ll_idiva)
	
			idw_riga.SetItem(ll_row,"id_gruppo_agenti",ll_idage)
			idw_riga.SetItem(ll_row,"provv_agente",ld_prv1)
			idw_riga.SetItem(ll_row,"provv_subage",ld_prv2)
			idw_riga.SetItem(ll_row,"provv_carea",ld_prv3)
			idw_riga.SetItem(ll_row,"riga_documento_val_attribuito",ld_vatt)
			idw_riga.SetItem(ll_row,"riga_documento_id_caus_trasporto",ll_idctr)
			idw_riga.SetItem(ll_row,"riga_documento_forza_chius_evasione","N")
			idw_riga.SetItem(ll_row,"riga_documento_sospesa","N")
			idw_riga.SetItem(ll_row,"riga_documento_da_stampare","S")
			idw_riga.SetItem(ll_row,"riga_documento_data_inizio_competenza",ldt_dic)
			idw_riga.SetItem(ll_row,"riga_documento_data_fine_competenza",ldt_dfc)
			
			idw_riga.SetItem(ll_row,"id_riga_doc_provenienza",ll_idriga)
			idw_riga.SetItem(ll_row,"riga_documento_id_conto",ll_idcpt)
			idw_riga.SetItem(ll_row,"riga_documento_id_azienda",ll_idazi)
			
			dw_riga_documento_ordine_gd.event ue_set_comp_riga()
			dw_riga_documento_ordine_gd.event ue_set_calc_riga(ll_row)
		end if
	end if
next

return 0


end function

public function long wf_calcola_cpt (long al_id_sog_commerciale, long al_id_gr_agente, long al_id_articolo);
long		ll_id_contropartita, ll_id_azienda, ll_id_registro
string	ls_tipo, ls_tipo_registro
SetNull(ll_id_contropartita)
ll_id_azienda= idw_gen.GetItemNumber(il_row, "documento_id_azienda")
ll_id_registro=idw_gen.GetItemNumber(il_row, "id_registro")
SELECT "registro"."tipo_registro"  
	INTO :ls_tipo_registro  
	FROM "dba"."registro"  
	WHERE ( "registro"."id_registro" = :ll_id_registro ) AND  
		( "registro"."id_azienda" = :ll_id_azienda )   ;
CHOOSE CASE ls_tipo_registro
	CASE "IA", "PA", "OA", "DA", "LA", "GA"
		
		ls_tipo= "A"
	CASE "IV", "PV", "OV", "DV", "LV", "GV"
		
		ls_tipo= "V"
END CHOOSE
long ll_id_causale
ll_id_causale=idw_riga.getitemnumber(idw_riga.getrow(), "riga_documento_id_caus_magazzino")
SQLCA.sp_calc_cpt(al_id_sog_commerciale, al_id_articolo, al_id_gr_agente, ls_tipo, ll_id_azienda, ll_id_contropartita, ll_id_causale)

RETURN ll_id_contropartita
end function

public function integer uf_ricerca ();
w_search_main 	lw_sm
string 			ls_filtro, ls_registro, ls_Parametro, ls_num_progr, ls_data_1, ls_data_2
s_ric_param		ls_ric_param	
date				ld_data
integer			li_risposta, li_retvalue

If idw_gen.AcceptText() > 0 then
	ls_Parametro = Trim(idw_master.is_list.s_win_parametri)
	CHOOSE CASE is_tipo_documento
		CASE "P"
			ls_filtro = "registro.tipo_registro = 'PV' OR registro.tipo_registro = 'PA'"
		CASE "O"
			ls_filtro = "registro.tipo_registro = 'OA' OR registro.tipo_registro = 'OV'"
		CASE "D"
			ls_filtro = "registro.tipo_registro = 'DA' OR registro.tipo_registro = 'DV'"
		CASE "F"
			ls_filtro = "registro.tipo_registro = 'IA' OR registro.tipo_registro = 'IV'"
		CASE "L"			
			ls_filtro = "registro.tipo_registro = 'LA' OR registro.tipo_registro = 'LV'"
		CASE "G"
			ls_filtro = "registro.tipo_registro = 'GA' OR registro.tipo_registro = 'GV'"	
		CASE "I"
			ls_filtro = "registro.tipo_registro = 'IA' OR registro.tipo_registro = 'IV'"	
		CASE ""
			ls_filtro = ""	
		CASE ELSE
	
	END CHOOSE
	
	CHOOSE CASE SQLCA.SQLCode
		CASE -1
			MessageBox("Ricerca del Documento", "I parametri forniti non permettono la ricerca sul Database ~n" &
						+ "oppure si è verificato un errore sul Database.", Information!)
			iuo_msg_log.uf_new_text("I parametri forniti non permettono la ricerca sul Database oppure si è verificato un errore sul Database.",2)
			RETURN 0
	END CHOOSE
	ls_registro=is_tipo_registro
	if IsNull(ls_registro) then ls_registro=""
	ls_num_progr= String(idw_gen.GetItemNumber(il_row,"num_progressivo"))
	if IsNull(ls_num_progr) then ls_num_progr=""
	ld_data= idw_gen.GetItemDate(il_row,"data_registrazione")
	if IsNull(ld_data) then 
		ls_data_1=""
		ls_data_2=""
	else
		ls_data_1=String(ld_data,"dd/mm/yyyy")
		ls_data_2=String(ld_data,"yyyy-mm-dd")
	end if
	If ls_registro= "" then
		if ls_num_progr="" then
			if ls_data_1= "" then
				
				idw_master.is_ricpar.s_filter_value = ""
				idw_master.is_ricpar.s_filter_name = "cc_descrizione"
			else
				
				idw_master.is_ricpar.s_filter_value = ls_data_1
				idw_master.is_ricpar.s_filter_name = "documento_data_registrazione"
			end if
		else
			if ls_data_1= "" then
				
				idw_master.is_ricpar.s_filter_value = ls_num_progr
				idw_master.is_ricpar.s_filter_name = "documento_num_progressivo"
			else
				
				idw_master.is_ricpar.s_filter_value = 'Nr.Progr. ' + ls_num_progr+ ' del ' + ls_data_2
				idw_master.is_ricpar.s_filter_name = "cc_filtro_3"
			end if
		end if
	else
		if ls_num_progr="" then
			if ls_data_1= "" then
				
				idw_master.is_ricpar.s_filter_value = ls_registro
				idw_master.is_ricpar.s_filter_name = "registro_tipo_registro"
			else
				
				idw_master.is_ricpar.s_filter_value = ls_registro + ' del ' + ls_data_2
				idw_master.is_ricpar.s_filter_name = "cc_filtro_2"
			end if
		else
			if ls_data_1= "" then
				
				idw_master.is_ricpar.s_filter_value = ls_registro + ' - Nr.Progr. ' +  ls_num_progr
				idw_master.is_ricpar.s_filter_name = "cc_filtro_1"
			else
				
				idw_master.is_ricpar.s_filter_value = ls_registro + ' - Nr.Progr. ' + ls_num_progr + ' del ' + ls_data_2		
				idw_master.is_ricpar.s_filter_name = "cc_filtro_4"
			end if
		end if
	end if
	If IsNull(idw_master.is_ricpar.s_filter_value) OR idw_master.is_ricpar.s_filter_value = "" then idw_master.is_ricpar.s_filter_value = ""
	If IsNull(idw_master.is_ricpar.s_filter_name) OR idw_master.is_ricpar.s_filter_name = "" then idw_master.is_ricpar.s_filter_name = "cc_descrizione"
	idw_master.is_ricpar.s_SQL_cond = ls_filtro
	OpenWithParm(lw_sm, idw_master.is_ricpar, "w_documento_sw")
	
	ls_ric_param= Message.PowerObjectParm
	if not IsNull(ls_ric_param) then 
		idw_master.is_ricpar=ls_ric_param
		IF UpperBound(idw_master.is_ricpar.s_id_seg_value) > 0 THEN
			if uf_is_modified() = True then
				
				if idw_master.uf_to_update() > 0 then
					li_risposta = MessageBox(idw_master.is_title, "Ci sono modifiche non salvate nella " + &
						"finestra.~n~rVuoi salvarle?", Question!, YesNo!,1)
					CHOOSE CASE li_risposta
						CASE 1
							
							li_retvalue=idw_master.event ue_update (0,0)
						CASE 2
							
							li_retvalue=0
					END CHOOSE
				end if
			end if	
			If li_retvalue=0 then
				il_id_documento = long(idw_master.is_ricpar.s_id_seg_value[1])
				idw_master.is_list.s_modo = modo_modifica
				idw_master.is_list.s_identifica[1] = "id_documento"
				idw_master.is_list.l_identifica[1] = il_id_documento
				SetPointer(HourGlass!)
				
				this.enabled= FALSE
				idw_master.Event ue_retrieve(0, 0)
				uf_set_documento()
				uf_set_istanze()
				this.enabled= TRUE
				uf_default_focus()
				SetPointer(Arrow!)
			end if
		END IF
	END IF
END IF
RETURN 0

end function

public function integer uf_set_documento ();
long 			ll_row, ll_id_valuta, ll_arrotondamento
decimal 		ldc_cambio, ldc_null
string		ls_null

dw_documento_ordine_ff.event ue_set_esercizio()
dw_documento_ordine_ff.event ue_set_prof_fields()
dw_documento_ordine_ff.event ue_set_valu_fields("")
dw_documento_ordine_ff.event ue_set_sp_incasso()
dw_documento_ordine_ff.event ue_set_not_new()
if idw_master.is_list.s_modo <> modo_inserisci then
	idw_gen.Object.c_prof_doc_cod.Protect=1
	idw_gen.Object.c_prof_doc_des.Protect=1
	idw_gen.Object.c_sog_comm_cod.Protect=1
	idw_gen.Object.c_sog_comm_des.Protect=1
end if
il_id_documento= idw_gen.GetItemNumber(il_row, "id_documento")
is_blocco=""
if is_tipo_documento = "P" AND is_blocco="" then
	SetNull(ldc_null)
	SetNull(ls_null)
	dw_documento_ordine_ff.Event ue_calc_totale(ls_null, ldc_null,ldc_null)
end if

RETURN 0

end function

public function integer uf_set_istanze ();
long ll_id_azienda
SELECT "spesa"."id_spesa"  
	INTO :il_id_spesa_bollo  
	FROM "dba"."spesa"  
	WHERE "spesa"."codice" = 'B' ;
ll_id_azienda= idw_gen.GetItemNumber(il_row, "documento_id_azienda")
SELECT "par_sistema"."id_conto_predefinito"  
INTO :il_id_conto_predefinito  
FROM "dba"."par_sistema"  
WHERE "par_sistema"."id_azienda" = :ll_id_azienda   ;
uf_set_title()

RETURN 0
end function

public function integer uf_set_title ();
string 	ls_num_progressivo, ls_data_registrazione, ls_tipo_registro,ls_title
long 		ll_id_registro

ls_num_progressivo= idw_gen.uf_get_colval("num_progressivo")
ll_id_registro=idw_gen.GetItemNumber(il_row,"id_registro")
ls_data_registrazione= idw_gen.uf_get_colval("data_registrazione")
If idw_gen.GetItemStatus(il_row, 0,Primary!)= New! OR idw_gen.GetItemStatus(il_row, 0,Primary!)= NewModified! then
	ls_title =	"Nuovo Movimento Semplificato" 

else
	ls_title =	"Movimento Semplificato" 
	
end if
If IsNull(ls_num_progressivo) then ls_num_progressivo=""
if not IsNull(ll_id_registro) then 
	SELECT "registro"."tipo_registro"  
		INTO :ls_tipo_registro  
		FROM "registro"  
		WHERE "registro"."id_registro" = :ll_id_registro  ;
	ls_title= ls_title + " " + ls_tipo_registro
end if
If not (IsNull(ls_num_progressivo) OR ls_num_progressivo= "") then ls_title= ls_title + " - Nr. " + ls_num_progressivo
If not (IsNull(ls_data_registrazione) OR ls_data_registrazione= "") then ls_title= ls_title + " del " + ls_data_registrazione
CHOOSE CASE idw_gen.uf_get_colval("tipo_fattura")
	CASE "C"
		ls_title= "Nota di Accredito - " + ls_title
	CASE "D"
		ls_title= "Nota di Addebito - " + ls_title
END CHOOSE

this.title = ls_title

RETURN 0
end function

public function boolean uf_riga_valida (long al_row);RETURN FALSE
end function

public function long uf_set_currow ();
il_row= idw_gen.GetRow()
if IsNull(il_row) OR il_row = 0 then
	il_row= idw_gen.RowCount()
end if
RETURN il_row
end function

public function integer uf_default_focus ();
tab_1.SelectTab(tab_1.tabpage_1)
idw_master.SetFocus()
idw_master.SetColumn("c_prof_doc_cod")

RETURN 0
end function

public function integer uf_stampa ();

string			ls_msg_a, ls_msg_b
string			ls_doc_stampato, ls_stampato
boolean			lb_definit, lb_can_go
long				ll_row, ll_id_documento
string			ls_tipo_registro, ls_nome_report, ls_dir, ls_selection_formula
window			lw_win
long				ll_retv, ll_sqlcode, ll_sqlrows
integer			li_outdev, li_stampa_ok
integer 			li_retvalue
boolean			lb_iva_ok, lb_cpt_ok


if (idw_master.uf_to_update() > 0) OR (idw_master.GetItemStatus(il_row,0,Primary!)=New!) then	
	
	ib_askforsave=FALSE
	li_retvalue=idw_master.Event ue_update(0,0)
else
	li_retvalue=0
end if
	iuo_msg_log.uf_new_text("Stampa del Documento",3)
if li_retvalue>0 then
	MessageBox("Stampa del Documento","Impossibile salvare il documento,~n indispensabile per avviare la stampa",Exclamation!)
	iuo_msg_log.uf_new_text("Stampa del Documento",3)
	iuo_msg_log.uf_new_text("Impossibile salvare il documento,~n indispensabile per avviare la stampa",4)
	RETURN 0
end if

ls_msg_a = "Stampa Documento; Warning!"
ls_doc_stampato = "documento_stampato"
ls_stampato = "S"


lb_definit = false
lb_can_go = true

ll_id_documento = idw_gen.GetItemNumber(il_row, "id_documento")

if lb_can_go then
	ls_msg_b = "ID.DOCUMENTO NULLO"
	if (IsNull(ll_id_documento)) then
		MessageBox(ls_msg_a, ls_msg_b)
		lb_can_go = false
	else 
		ls_selection_formula="{documento.id_documento}=" + String(ll_id_documento)
	end if
end if

if lb_can_go then
	ls_tipo_registro = is_tipo_registro
	if isNull(ls_tipo_registro) then
		ls_tipo_registro = ""
	end if
	ls_msg_b = "Tipo registro "+ls_tipo_registro+" sconosciuto. Si userà il preventivo"
	CHOOSE CASE ls_tipo_registro
		CASE "OV", "OA"
			ls_nome_report = "grr_ordine.rpt"  
		CASE "DV", "DA"
			ls_nome_report = "txr_bolla.rpt"
		CASE "IV", "IA"
			ls_nome_report = "txr_fattura_acc.rpt"
		CASE "PV", "PA"
			ls_nome_report = "grr_preventivo.rpt"
		CASE "GV", "GA"
			ls_nome_report = "grr_mov_generico.rpt"
		CASE ELSE
			MessageBox(ls_msg_a, ls_msg_b)
			ls_nome_report = "grr_preventivo_rpt"
	END CHOOSE
end if


if lb_can_go then
	Open(lw_win, "w_st_prov_def_wz")
	ll_retv = Message.DoubleParm
	CHOOSE CASE ll_retv
		CASE 0							
			li_outdev = 1
		CASE 1							
			li_outdev = 1
			lb_definit = true
			
		CASE 2							
			li_outdev = 2
		CASE 3							
			li_outdev = 2
			lb_definit = true
			
		CASE -1							
			lb_can_go = false
		CASE ELSE						
			lb_can_go = false
	END CHOOSE
end if


if lb_can_go then
	
	select "par_sistema"."dir_report" into :ls_dir
		from "dba"."par_sistema"
		where "par_sistema"."id_azienda" = 1
		using SQLCA;
	ll_sqlcode = sqlca.sqlcode
	ll_sqlrows = sqlca.sqlnrows
	if (isNull(ls_dir)) or (ll_sqlcode<>0) or (ll_sqlrows>1) then
		messageBox(ls_msg_a, ls_msg_b)
		lb_can_go = false
	end if
	
	ls_msg_b = "Errore nella scrittura sul database"
	if lb_definit then
		ll_retv = idw_master.event ue_update (0,0)
		if ll_retv <> 0 then
			messageBox(ls_msg_a,ls_msg_b)
			lb_can_go = false
		end if
	end if
	
end if


//u_freddie.iuo_stampa.of_set_selection_formula(ls_selection_formula) 
//li_stampa_ok = u_freddie.iuo_stampa.of_stampa(0, li_outdev, 0, 0, 1,ls_dir, ls_nome_report)


ls_msg_b = "Errore in fase di stampa"
if li_stampa_OK <> 0 then
	MessageBox(ls_msg_a, ls_msg_b)
else
	ls_msg_b = "Errore nella scrittura sul database"
	if lb_definit then
		idw_gen.SetItem(il_row, ls_doc_stampato, ls_stampato)
		ll_retv = idw_master.event ue_update (0,0)
		if ll_retv <> 0 then
			messageBox(ls_msg_a,ls_msg_b)
		end if
	end if
end if

RETURN 0

end function

public function integer uf_wizard_riga ();
integer li_retvalue

if (idw_master.uf_to_update() > 0) AND (idw_master.GetItemStatus(il_row,0,Primary!) = NewModified!)then	
	
	ib_askforsave=FALSE
	li_retvalue=idw_master.Event ue_update(0,0)
	if li_retvalue>0 then
	
		MessageBox("Wizard del Documento","Impossibile salvare il documento,~n tale azione è indispensabile per creare una nuova riga.",Exclamation!)
		iuo_msg_log.uf_new_text("Wizard del Documento",3)
		iuo_msg_log.uf_new_text("Impossibile salvare il documento,~n tale azione è indispensabile per creare una nuova riga.",4)
		RETURN 0
	else
		dw_riga_documento_ordine_gd.event ue_wiz_insert()
	end if
end if

RETURN 0
end function

public function integer uf_nuovo_documento ();

integer li_retvalue

if idw_master.uf_to_update() > 0 then	
	
	li_retvalue=idw_master.Event ue_update(0,0)
else
	li_retvalue=0
end if
if li_retvalue<=0 then
	
	dw_documento_ordine_ff.event ue_reset()
	idw_master.is_list.s_modo= modo_inserisci
	TriggerEvent("ue_insert_mode")
	il_row= idw_gen.GetRow()
	if IsNull(il_row) OR il_row =0 then
		il_row= idw_gen.RowCount()
	end if
	if not(IsNull(il_row) OR il_row =0) then il_id_documento= idw_gen.GetItemNumber(il_row, "id_documento")
	uf_default_focus()
	iuo_msg_log.uf_new_text("Nuovo Documento",1)
end if

RETURN 0
end function

public function integer uf_load_documento (long al_id_documento);
idw_master.is_list.s_modo = modo_modifica
idw_master.is_list.s_identifica[1] = "id_documento"
idw_master.is_list.l_identifica[1] = al_id_documento
SetPointer(HourGlass!)
this.enabled= FALSE
idw_master.Event ue_retrieve(0, 0)
uf_set_documento()
uf_set_istanze()
this.enabled= TRUE
uf_default_focus()
SetPointer(Arrow!)
RETURN 0
end function

public function integer uf_report_righe ();
long		ll_row, ll_nr_row, ll_nr_descrittive
string	ls_Stato, ls_report, ls_text

ls_report=""
ll_nr_descrittive=0
ll_nr_row= idw_riga.RowCount()
For ll_row = 1 to ll_nr_row
	ls_Stato= idw_riga.GetItemString(ll_row,"c_riga_valida")
	CHOOSE CASE ls_Stato
		CASE	"I"
			ll_nr_descrittive++
			ls_report=ls_report + " - Nr. " + String(ll_row)
		CASE "D"
			ll_nr_descrittive++
	END CHOOSE
next
If ll_nr_descrittive>0 then
	iuo_msg_log.uf_new_text("Le Righe di Documento comprendono:",3)
	iuo_msg_log.uf_new_text(String(ll_nr_descrittive) + " Righe descrittive.",4)
	If ls_report <> "" then
		iuo_msg_log.uf_new_text("Di cui le seguenti Righe sono probabilmente incomplete di IVA: " + ls_report + ".",4)
	end if
end if
RETURN 0

end function

public function boolean uf_is_modified ();long ll_row
ll_row = this.dw_documento_ordine_ff.GetRow()

if this.dw_documento_ordine_ff.GetItemStatus( ll_row,"c_prof_doc_cod",Primary! ) <> NotModified! or & 
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"c_prof_doc_des",Primary! ) <> NotModified! or &
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"c_sog_comm_cod",Primary! ) <> NotModified! or &
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"c_sog_comm_des",Primary! ) <> NotModified! or &	
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"c_destinazione",Primary! ) <> NotModified! or &
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"c_magazzino_1_cod",Primary! ) <> NotModified! or &
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"c_magazzino_1_des",Primary! ) <> NotModified! or &
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"documento_id_valuta_cod",Primary! ) <> NotModified! or &
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"documento_id_valuta_des",Primary! ) <> NotModified! or &
   this.dw_documento_ordine_ff.GetItemStatus( ll_row,"num_progressivo",Primary! ) <> NotModified! or &
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"data_registrazione",Primary! ) <> NotModified! or &
	this.dw_documento_ordine_ff.GetItemStatus( ll_row,"documento_cambio",Primary! ) <> NotModified! then
	return True
end if  

return False
end function

public function integer uf_agg_loc_1_riga (long al_id_magazzino);
long 		ll_id_locazione, ll_Row_Size, ll_Count, ll_Id_Loc_Riga

SELECT max("locazione"."id_locazione")
	INTO :ll_id_locazione  
	FROM "dba"."locazione",   
		"dba"."magazzino"  
	WHERE ( "magazzino"."id_magazzino" = "locazione"."id_magazzino" ) and  
		( "magazzino"."id_magazzino" = :al_id_magazzino) and  
		( "locazione"."id_area" IS NULL ) AND  
		( "locazione"."corsia" IS NULL ) AND  
		( "locazione"."scaffale" IS NULL ) AND  
		( "locazione"."ripiano" IS NULL ) AND  
		( "locazione"."posizione" IS NULL ) ;
ll_Row_Size= idw_riga.RowCount()
FOR ll_Count = 1 to ll_Row_Size
	ll_Id_Loc_Riga=idw_riga.GetItemNumber(ll_Count, "id_locazione_1")
	If IsNull(ll_Id_Loc_Riga) OR ll_Id_Loc_Riga=0 then
		idw_riga.SetItem(ll_Count, "id_locazione_1", ll_id_locazione)
	end if	
NEXT

RETURN 0
end function

public function integer uf_agg_loc_2_riga (long al_id_magazzino);
long 		ll_id_locazione, ll_Row_Size, ll_Count, ll_Id_Loc_Riga

SELECT max("locazione"."id_locazione")
	INTO :ll_id_locazione  
	FROM "dba"."locazione",   
		"dba"."magazzino"  
	WHERE ( "magazzino"."id_magazzino" = "locazione"."id_magazzino" ) and  
		( "magazzino"."id_magazzino" = :al_id_magazzino) and  
		( "locazione"."id_area" IS NULL ) AND  
		( "locazione"."corsia" IS NULL ) AND  
		( "locazione"."scaffale" IS NULL ) AND  
		( "locazione"."ripiano" IS NULL ) AND  
		( "locazione"."posizione" IS NULL ) ;
ll_Row_Size= idw_riga.RowCount()
FOR ll_Count = 1 to ll_Row_Size
	ll_Id_Loc_Riga=idw_riga.GetItemNumber(ll_Count, "id_locazione_2")
	If IsNull(ll_Id_Loc_Riga) OR ll_Id_Loc_Riga = 0 then
		idw_riga.SetItem(ll_Count, "id_locazione_2", ll_id_locazione)
	end if	
NEXT

RETURN 0
end function

on w_mov_magazzino_cx.create
int iCurrent
call super::create
this.p_stampa=create p_stampa
this.dw_documento_ordine_ff=create dw_documento_ordine_ff
this.p_arrow=create p_arrow
this.dw_riga_documento_ordine_gd=create dw_riga_documento_ordine_gd
this.dw_riga_documento_dett_ord_ff=create dw_riga_documento_dett_ord_ff
this.cbx_simbolo=create cbx_simbolo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_stampa
this.Control[iCurrent+2]=this.dw_documento_ordine_ff
this.Control[iCurrent+3]=this.p_arrow
this.Control[iCurrent+4]=this.dw_riga_documento_ordine_gd
this.Control[iCurrent+5]=this.dw_riga_documento_dett_ord_ff
this.Control[iCurrent+6]=this.cbx_simbolo
end on

on w_mov_magazzino_cx.destroy
call super::destroy
destroy(this.p_stampa)
destroy(this.dw_documento_ordine_ff)
destroy(this.p_arrow)
destroy(this.dw_riga_documento_ordine_gd)
destroy(this.dw_riga_documento_dett_ord_ff)
destroy(this.cbx_simbolo)
end on

event open;call super::open;il_helptopic = 53
iw_corrente=this
SetPointer(HourGlass!)

This.y = 10

ib_nonmodale = TRUE

idw_gen = dw_documento_ordine_ff
idw_riga=  dw_riga_documento_ordine_gd  
idw_riga_tot= dw_riga_documento_dett_ord_ff

this.enabled = FALSE

iuo_pag = create uo_esp_pag
idw_master=dw_documento_ordine_ff
idw_master.is_list = Message.PowerObjectParm
Message.Processed=TRUE
is_tipo_documento= idw_master.is_list.s_win_parametri
if is_tipo_documento = "P" then
	idw_gen.dataobject = "d_documento_preventivo_ff"
	idw_gen.SetTransObject(SQLCA)
end if
dw_riga_documento_ordine_gd.SetRowFocusIndicator(p_arrow)

TriggerEvent("ue_tipo_documento")
If Upperbound(idw_master.is_list.s_identifica) = 0 then
	idw_master.is_list.s_modo= modo_inserisci
end if

end event

event close;call super::close;destroy iuo_pag

end event

event ue_post_open;call super::ue_post_open;If Upperbound(idw_master.is_list.s_identifica) > 0 then
	uf_set_documento()
end if
uf_set_istanze()
iuo_msg_log.uf_new_text("Per scegliere documento esistente cliccare su 'Ricerca ...'.", 4)
iuo_msg_log.uf_new_text("E' possibile utilizzare come filtro il Registro, il Protocollo e la Data di Registrazione.", 4)

this.enabled= TRUE
SetPointer(Arrow!)
this.SetFocus()
idw_gen.SetFocus()
end event

event activate;call super::activate;
If not IsValid(u_freddie.iudw_current) then
	u_freddie.iudw_current= idw_master
end if

end event

event ue_print;

uf_stampa()
end event

event closequery;integer		li_ret
if uf_is_modified() = True then
	li_ret = Super::EVENT closequery()
	return li_ret
end if  
return 0

end event

type p_msg_log from w_p_data`p_msg_log within w_mov_magazzino_cx
int X=1349
int Y=40
boolean Visible=true
end type

type p_crescente from w_p_data`p_crescente within w_mov_magazzino_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_mov_magazzino_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_mov_magazzino_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_mov_magazzino_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_mov_magazzino_cx
boolean BringToTop=true
end type

event cb_nuovo::clicked;
uf_nuovo_documento()
end event

type cb_inserisci from w_p_data`cb_inserisci within w_mov_magazzino_cx
int X=1874
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_mov_magazzino_cx
int X=2171
boolean BringToTop=true
end type

event cb_cancella::clicked;


long	ll_retval,ll_row

w_p_data  lw_win
u_dw_main lu_dw

s_par_record	lstr_par_documento


ll_row	= dw_documento_ordine_ff.GetRow()
lstr_par_documento.nome_tabella			= "documento"
lstr_par_documento.nome_id_tabella		= "id_documento"
lstr_par_documento.id_tabella				= il_id_documento
lstr_par_documento.visible					= false

If not(idw_gen.GetItemStatus(il_row,0,Primary!) = NewModified! OR idw_gen.GetItemStatus(il_row,0,Primary!) = New!) then
	lw_win = u_freddie.iw_current
	lu_dw = u_freddie.iudw_current
	if isValid(lu_dw) then
		if isValid(lu_dw.iudw_parent) then
			if not lu_dw.ib_dw_shared then
				if lu_dw.RowCount() >0 then
					parent.triggerevent("ue_delete")
				end if
			end if
		else
			
			

			OpenWithParm(w_cancella_documento_wz,lstr_par_documento )
			ll_retval	= Message.DoubleParm

			
			
			choose case ll_retval
				case 0
					dw_documento_ordine_ff.SetFocus()
				case 1
					uf_nuovo_documento()
			end choose
			
		end if
	end if
end if

end event

type cb_salva from w_p_data`cb_salva within w_mov_magazzino_cx
int X=2469
boolean BringToTop=true
end type

type tab_1 from w_p_data`tab_1 within w_mov_magazzino_cx
int X=2194
int Y=1180
int Width=549
int Height=360
int TabOrder=30
boolean Visible=false
boolean Enabled=false
boolean BringToTop=true
long BackColor=79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=512
int Height=240
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
cb_deriva cb_deriva
cb_note cb_note
cb_blocco cb_blocco
end type

on tabpage_1.create
this.cb_deriva=create cb_deriva
this.cb_note=create cb_note
this.cb_blocco=create cb_blocco
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_deriva
this.Control[iCurrent+2]=this.cb_note
this.Control[iCurrent+3]=this.cb_blocco
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_deriva)
destroy(this.cb_note)
destroy(this.cb_blocco)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_mov_magazzino_cx
int X=1554
int Width=302
int TabOrder=20
boolean BringToTop=true
string Text="&Ricerca ..."
end type

event cb_ricerca::clicked;call super::clicked;
uf_ricerca()
end event

type cb_deriva from commandbutton within tabpage_1
event clicked pbm_bnclicked
int X=2359
int Y=1016
int Width=261
int Height=88
int TabOrder=11
string Text="Deriva ..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

long				ll_row
string			ls_nome[]
integer			li_size, li_i
s_par_der_doc	ls_par, ls_par2, ls_par3
window			lw_1





ll_row = idw_gen.getRow()

li_size = 1
ls_par.s_dbn[li_size] = "der_profilo.id_prof_documento_derivato"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_prof_documento")
li_size++
ls_par.s_dbn[li_size] = "documento.id_sog_commerciale"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_sog_commerciale")
li_size++
ls_par.s_dbn[li_size] = "documento.id_destinazione"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_destinazione")
li_size++

ls_par.s_dbn[li_size] = "documento.id_magazzino"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("documento_id_magazzino")
li_size++
ls_par.s_dbn[li_size] = "documento.id_magazzino_2"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("documento_id_magazzino_2")
li_size++
ls_par.s_dbn[li_size] = "documento.id_gruppo_agenti"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_gruppo_agenti")
li_size++
ls_par.s_dbn[li_size] = "documento.id_valuta"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("documento_id_valuta_cod")
li_size++
ls_par.s_dbn[li_size] = "documento.id_con_pagamento"
ls_par.s_dbv[li_size] = idw_gen.uf_get_colval("id_con_pagamento")

ls_par.a_optional[1] = idw_gen.uf_get_colval("data_registrazione")
for li_i = 1 to li_size
	ls_par.s_op[li_i] = "="
	ls_par.s_dbt[li_i] = "N"
next

OpenWithParm(lw_1, ls_par, "w_check_deriva_wz")
ls_par2 = Message.PowerObjectParm
if isValid(ls_par2) then
	OpenWithParm(lw_1, ls_par2, "w_deriva_wz")
	ls_par3 = Message.PowerObjectParm
	if isValid(ls_par3) then
		
		uf_importa_righe (ls_par3)
	end if
end if



end event

type cb_note from commandbutton within tabpage_1
int X=2359
int Y=896
int Width=261
int Height=84
int TabOrder=11
boolean BringToTop=true
string Text="Altro ..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
string 		ls_note
long 			ll_id_prof_doc
string 		ls_array[]
s_any_array lstr_array

ls_array[2] = idw_gen.uf_get_colval("id_documento")  
ls_array[3] = idw_gen.uf_get_colval("id_prof_documento")   
ls_array[4] = idw_gen.uf_get_colval("id_registro")  
ls_array[5] = idw_gen.uf_get_colval("num_progressivo")  
ls_array[6] = idw_gen.uf_get_colval("data_registrazione")  
ls_array[7] = idw_gen.uf_get_colval("num_documento")
ls_array[8] = idw_gen.uf_get_colval("data_documento")  
ls_array[9] = idw_gen.uf_get_colval("documento_data_competenza")  
ls_array[10] = idw_gen.uf_get_colval("id_sog_commerciale")  
ls_array[12] = idw_gen.uf_get_colval("documento_id_caus_magazzino")   
ls_array[13] = idw_gen.uf_get_colval("documento_id_magazzino")  
ls_array[14] = idw_gen.uf_get_colval("documento_id_magazzino_2")  
ls_array[15] = idw_gen.uf_get_colval("documento_id_sog_commerciale_fattura")    
ls_array[21] = idw_gen.uf_get_colval("documento_id_listino")
ls_array[22] = idw_gen.uf_get_colval("id_con_pagamento")  
ls_array[23] = idw_gen.uf_get_colval("id_banca_sog_commerciale")  
ls_array[24] = idw_gen.uf_get_colval("id_gruppo_agenti")  
ls_array[28] = idw_gen.uf_get_colval("documento_note_intestazione")  
ls_array[35] = idw_gen.uf_get_colval("id_tipo_trasporto")   
ls_array[36] = idw_gen.uf_get_colval("documento_id_caus_trasporto")  
ls_array[39] = idw_gen.uf_get_colval("documento_id_sog_commerciale_vettore")  
ls_array[40] = idw_gen.uf_get_colval("documento_id_sog_commerciale_vettore_2")  


ls_array[65] = idw_gen.uf_get_colval("id_documento_padre")
ls_array[66] = idw_gen.uf_get_colval("id_prof_registrazione")
ls_array[67] = idw_gen.uf_get_colval("des_contabile")
if idw_gen.uf_get_colval("tipo_fattura")= "N" then 
	is_ric_documento = is_ric_documento + "N"
else
	is_ric_documento = is_ric_documento + "O"
end if
ls_array[71] = is_ric_documento
if IsValid(u_freddie.iw_current) then 
	ls_array[72] =	u_freddie.iw_current.title
else
	ls_array[72] =	idw_gen.is_title
end if
ls_array[73] = idw_gen.uf_get_colval("c_prof_doc_cod" )
ls_array[74] = idw_gen.uf_get_colval("c_prof_doc_des" )
ls_array[75] = idw_gen.uf_get_colval("c_registro_des" )
ls_array[76] = idw_gen.uf_get_colval("c_registro" )

lstr_array.s_array= ls_array
OpenWithParm(w_documento_ordine_wz, lstr_array)
lstr_array= Message.PowerObjectParm
ls_array=lstr_array.s_array
dw_documento_ordine_ff.event ue_set_wz_fields(ls_array)


idw_gen.SetFocus()
dw_documento_ordine_ff.TriggerEvent("ue_set_calc_fields")


end event

type cb_blocco from commandbutton within tabpage_1
event clicked pbm_bnclicked
int X=2359
int Y=1136
int Width=261
int Height=80
int TabOrder=11
boolean BringToTop=true
string Text="Blocco ..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
end event

type p_stampa from picture within w_mov_magazzino_cx
int X=1166
int Y=40
int Width=110
int Height=88
boolean BringToTop=true
string PictureName="s:\pb\commonframework\printer.bmp"
boolean FocusRectangle=false
end type

event clicked;

uf_stampa()
end event

type dw_documento_ordine_ff from u_dw_master_main within w_mov_magazzino_cx
event type integer ue_set_sog_fields ( )
event type integer ue_set_prof_fields ( )
event ue_set_calc_fields ( )
event ue_set_not_new ( )
event ue_set_regi_fields ( )
event ue_set_valu_fields ( string as_data )
event ue_canc_intestatario ( )
event ue_set_sp_incasso ( )
event ue_set_registro ( )
event ue_set_esercizio ( )
event ue_reset ( )
event type decimal ue_calc_totale ( string as_sc_finanziario,  decimal adc_sc_fin_cassa,  decimal adc_sconto_fin_inc )
event type integer ue_set_wz_fields ( string as_array[] )
event type integer ue_set_contropartita ( )
event ue_set_con_pagamento ( )
int X=46
int Y=180
int Width=2697
int Height=560
int TabOrder=10
string DataObject="d_mov_magazzino_ff"
end type

event ue_set_sog_fields;call super::ue_set_sog_fields;

long			ll_id_sog_commerciale, ll_id_lingua, ll_id_linguaggio, ll_id_valuta, ll_id_listino
long 			ll_con_pagamento, ll_count, ll_size, ll_id_tab_iva, ll_id_riga, ll_id_articolo, ll_codice
long 			ll_id_des_articolo, ll_id_tipo_trasporto, ll_destinazione, ll_id_banca, ll_id_sog_com_vettore
long 			ll_id_profilo, ll_id_sog_com_vett_prop, ll_id_sog_comm_fattura
string	 	ls_rag_soc, ls_tipo_iva, ls_codice, ls_info
decimal 		ldc_cambio

ll_id_sog_commerciale= GetItemNumber(il_row, "id_sog_commerciale")
if not (IsNull(ll_id_sog_commerciale) OR ll_id_sog_commerciale = 0) then
	
	SetNull(ll_destinazione)
	SetItem(il_row, "id_destinazione", ll_destinazione)
	
	ls_info= f_info_sc(ll_id_sog_commerciale)
	SetItem(il_row,"cinfo", ls_info)
  	SELECT "anagrafica"."rag_soc_1",   
         "anagrafica"."id_lingua",   
         "anagrafica"."id_valuta", 
			"anagrafica"."id_tipo_trasporto", 
			"sog_commerciale"."codice",
			"sog_commerciale"."id_con_pagamento",
         "sog_commerciale"."id_linguaggio",   
         "sog_commerciale"."id_listino", 
			"sog_commerciale"."id_tab_iva" ,
			"sog_commerciale"."id_banca_sog_commerciale" ,
			"sog_commerciale"."id_sog_com_vettore" ,
         "valuta"."cambio"  
    INTO :ls_rag_soc,   
         :ll_id_lingua,   
         :ll_id_valuta, 
			:ll_id_tipo_trasporto,
			:ls_codice, 
			:ll_con_pagamento ,
         :ll_id_linguaggio,   
         :ll_id_listino, 
			:ll_id_tab_iva, 
			:ll_id_banca, 
			:ll_id_sog_com_vettore, 
         :ldc_cambio  
    FROM "dba"."anagrafica",   
         "dba"."sog_commerciale",   
         "dba"."valuta"  
   WHERE ( "sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and  
         ( "valuta"."id_valuta" = "anagrafica"."id_valuta" ) and  
         ( ( "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) )   ;
 
		SetItem(il_row,"c_sog_comm_des", ls_rag_soc)
		SetItem(il_row,"c_sog_comm_cod", ls_codice)
		
		ll_id_sog_comm_fattura=GetItemNumber(il_row,"documento_id_sog_commerciale_fattura")
		if (IsNull(ll_id_sog_comm_fattura) OR ll_id_sog_comm_fattura = 0) then SetItem(il_row,"documento_id_sog_commerciale_fattura", ll_id_sog_commerciale)
		if not (IsNull(ll_id_tipo_trasporto) OR ll_id_tipo_trasporto = 0) then SetItem(il_row,"id_tipo_trasporto", ll_id_tipo_trasporto)
		
		if not (IsNull(ll_id_lingua) OR ll_id_lingua = 0) then SetItem(il_row,"id_lingua", ll_id_lingua)
		if not (IsNull(ll_id_valuta) OR ll_id_valuta = 0) then 
			SetItem(il_row,"documento_id_valuta_des", ll_id_valuta)
			TriggerEvent("ue_set_valu_fields")
		end if
		if not (IsNull(ll_id_linguaggio) OR ll_id_linguaggio = 0) then SetItem(il_row,"documento_id_linguaggio", ll_id_linguaggio)

		if not (IsNull(ll_id_listino) OR ll_id_listino = 0) then SetItem(il_row,"documento_id_listino", ll_id_listino)
		if not (IsNull(ll_con_pagamento) OR ll_con_pagamento = 0) then SetItem(il_row,"id_con_pagamento_des", ll_con_pagamento)
		if not (IsNull(ll_id_banca) OR ll_id_banca = 0) then SetItem(il_row,"id_banca_sog_commerciale", ll_id_banca)
		
		ll_id_profilo= GetItemNumber(il_row, "id_prof_documento")
		if not IsNull(ll_id_profilo) then
			SELECT "prof_documento"."id_sog_comm_vettore_1_prop"  
				INTO :ll_id_sog_com_vett_prop  
				FROM "dba"."prof_documento"  
				WHERE "prof_documento"."id_prof_documento" = :ll_id_profilo   ;
			if IsNull(ll_id_sog_com_vett_prop) then SetItem(il_row,"documento_id_sog_commerciale_vettore", ll_id_sog_com_vettore)
		end if

		SELECT "tab_iva"."tipo_iva"  
			INTO :ls_tipo_iva  
			FROM "dba"."tab_iva"  
			WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva;
			
		if SQLCA.SQLCode = 0 then
			if ls_tipo_iva <> "S" then
				SetNull(ll_id_tab_iva)
			end if
			ll_size = idw_riga.RowCount()
			
			for ll_count = 1 to ll_size
				
				

				
				if IsNull(ll_id_tab_iva) then
					
					  SELECT "articolo"."id_tab_iva"  
							 INTO :ll_id_tab_iva  
							 FROM "dba"."articolo"  
							WHERE "articolo"."id_articolo" = :ll_id_articolo   ;
						if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then idw_riga.SetItem(ll_count, "riga_documento_id_tab_iva",ll_id_tab_iva)
				else
					if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then idw_riga.SetItem(ll_count, "riga_documento_id_tab_iva",ll_id_tab_iva)
				end if
				
				uf_set_des_articolo(ll_count, ll_id_lingua, ll_id_linguaggio, ll_id_sog_commerciale)
			next
		end if
else
	SetItem(il_row,"cinfo", "")
end if
TriggerEvent("ue_set_calc_fields")
event ue_set_sp_incasso()
event ue_set_con_pagamento()

post event ue_set_contropartita()
return 0
end event

event ue_set_prof_fields;call super::ue_set_prof_fields;

long ll_id_prof
string ls_ric_id_registro, ls_ric_num_progressivo, ls_ric_num_documento, ls_ric_id_caus_magazzino
string ls_ric_id_sog_comm, ls_ric_id_con_pagamento, ls_ric_id_sog_comm_agente, ls_ric_id_tipo_trasporto
string ls_ric_id_valuta, ls_ric_id_sog_comm_vettore_1, ls_note_intestazione_prop
string ls_aspetto_beni_prop, ls_trasp_mezzo_prop
long ll_id_caus_magazzino_prop, ll_id_sog_comm_prop, ll_id_valuta_prop, ll_id_con_pagamento_prop, ll_id_sog_comm_vettore_1_prop
long ll_id_magazzino_1_prop, ll_id_magazzino_2_prop, ll_id_sog_comm_fattura_prop, ll_id_linguaggio_prop
long ll_id_lingua_prop, ll_id_listino_prop, ll_quantita_prop_riga, ll_row
string ls_ric_id_unita_confezione_riga ,ls_ric_pesi_riga ,ls_ric_data_prev_consegna_riga 
string ls_ric_locazione_2_riga ,ls_ric_locazione_1_riga ,ls_ric_id_caus_magazzino_riga ,ls_ric_unita_prezzo_riga ,ls_ric_unita_base_riga ,ls_ric_quantita_riga 
string ls_ric_id_tab_iva_riga ,ls_ric_sconto_riga_riga ,ls_ric_prezzo_netto_riga ,ls_ric_sconto_riga ,ls_ric_prezzo_riga ,ls_ric_id_listino_riga ,ls_ric_id_valuta_riga ,ls_ric_colli_riga ,ls_ric_dim_riga 
string ls_ric_contropartite_riga ,ls_ric_date_competenza_riga ,ls_ric_val_attribuito_riga ,ls_ric_provvigioni_riga ,ls_ric_id_sog_comm_agente_riga 
string ls_ric_id_caus_trasporto ,ls_ric_volumi 
string ls_ric_pesi ,ls_ric_colli_documento ,ls_ric_data_trasporto ,ls_ric_trasp_mezzo ,ls_ric_asp_beni 
string ls_ric_id_magazzino_1 , ls_ric_id_magazzino_2, ls_ric_id_sog_comm_fattura, ls_ric_id_listino
string ls_tipo_fattura

ll_row= GetRow()
ll_id_prof=GetItemNumber(ll_row, "id_prof_documento")
SELECT "prof_documento"."ric_id_registro",   
		"prof_documento"."ric_num_progressivo",   
		"prof_documento"."ric_num_documento",   
		"prof_documento"."ric_id_caus_magazzino",   
		"prof_documento"."ric_id_sog_comm",   
		"prof_documento"."ric_id_con_pagamento",   
		"prof_documento"."ric_id_sog_comm_agente",   
		"prof_documento"."ric_id_tipo_trasporto",   
		"prof_documento"."ric_id_valuta",   
		"prof_documento"."ric_id_sog_comm_vettore_1",

		"prof_documento"."ric_colli_documento",
		"prof_documento"."ric_pesi", 
		"prof_documento"."ric_volumi",  
		"prof_documento"."ric_id_caus_trasporto",
		"prof_documento"."ric_asp_beni",
		"prof_documento"."ric_trasp_mezzo", 
		"prof_documento"."ric_data_trasporto",

		"prof_documento"."stato_scad_generata",
		"prof_documento"."con_data_progressiva",
		"prof_documento"."tipo_fattura",

		"prof_documento"."trasp_mezzo_prop", 
		"prof_documento"."aspetto_beni_prop",
		"prof_documento"."id_mod_registro_prop",
		"prof_documento"."note_intestazione_prop", 
		"prof_documento"."id_caus_magazzino_prop",   
		"prof_documento"."id_sog_comm_prop",  
		"prof_documento"."id_magazzino_1_prop",
		"prof_documento"."id_magazzino_2_prop",
		"prof_documento"."id_sog_comm_fattura_prop",
		"prof_documento"."id_linguaggio_prop",
		"prof_documento"."id_valuta_prop",   
		"prof_documento"."id_con_pagamento_prop",   
		"prof_documento"."id_sog_comm_vettore_1_prop",
		"prof_documento"."id_lingua_prop",   
		"prof_documento"."id_listino_prop",   
		"prof_documento"."aspetto_beni_prop",   
		"prof_documento"."trasp_mezzo_prop",
		"prof_documento"."int_consentiti",

		"prof_documento"."ric_id_magazzino_1",   
		"prof_documento"."ric_id_magazzino_2",   
		"prof_documento"."ric_id_sog_comm_fattura", 
		"prof_documento"."ric_id_listino",   

		"prof_documento"."ric_id_unita_confezione_riga",   
		"prof_documento"."ric_quantita_riga",   
		"prof_documento"."quantita_prop_riga",   
		"prof_documento"."ric_unita_base_riga",   
		"prof_documento"."ric_unita_prezzo_riga",   
		"prof_documento"."ric_id_caus_magazzino_riga",   
		"prof_documento"."ric_locazione_1_riga",   
		"prof_documento"."ric_locazione_2_riga",   
		"prof_documento"."ric_data_prev_consegna_riga",   
		"prof_documento"."ric_pesi_riga",   
		"prof_documento"."ric_dim_riga",   
		"prof_documento"."ric_colli_riga",   
		"prof_documento"."ric_id_valuta_riga",   
		"prof_documento"."ric_id_listino_riga",   
		"prof_documento"."ric_prezzo_riga",   
		"prof_documento"."ric_sconto_riga",   
		"prof_documento"."ric_prezzo_netto_riga",   
		"prof_documento"."ric_sconto_riga_riga",   
		"prof_documento"."ric_id_tab_iva_riga",   
		"prof_documento"."ric_id_sog_comm_agente_riga",   
		"prof_documento"."ric_provvigioni_riga",   
		"prof_documento"."ric_val_attribuito_riga",   
		"prof_documento"."ric_date_competenza_riga",   
		"prof_documento"."ric_contropartite_riga"

 INTO :ls_ric_id_registro, 
		:ls_ric_num_progressivo,
		:ls_ric_num_documento, 
		:ls_ric_id_caus_magazzino,
		:ls_ric_id_sog_comm, 
		:ls_ric_id_con_pagamento, 
		:ls_ric_id_sog_comm_agente, 
		:ls_ric_id_tipo_trasporto,
		:ls_ric_id_valuta, 
		:ls_ric_id_sog_comm_vettore_1,

		:ls_ric_colli_documento,
		:ls_ric_pesi, 
		:ls_ric_volumi,  
		:ls_ric_id_caus_trasporto,
		:ls_ric_asp_beni,
		:ls_ric_trasp_mezzo, 
		:ls_ric_data_trasporto,

		:is_stato_scad_generata,
		:is_con_data_progressiva,
		:ls_tipo_fattura,

		:ls_trasp_mezzo_prop, 
		:ls_aspetto_beni_prop,
		:il_id_mod_registro, 
		:ls_note_intestazione_prop,
		:ll_id_caus_magazzino_prop,  
		:ll_id_sog_comm_prop,  
		:ll_id_magazzino_1_prop,
		:ll_id_magazzino_2_prop,
		:ll_id_sog_comm_fattura_prop,
		:ll_id_linguaggio_prop,
		:ll_id_valuta_prop,  
		:ll_id_con_pagamento_prop,  
		:ll_id_sog_comm_vettore_1_prop,
		:ll_id_lingua_prop,
		:ll_id_listino_prop,
		:ls_aspetto_beni_prop,
		:ls_trasp_mezzo_prop,
		:is_int_consentiti,

		:ls_ric_id_magazzino_1,
		:ls_ric_id_magazzino_2,
		:ls_ric_id_sog_comm_fattura,
		:ls_ric_id_listino,

		:ls_ric_id_unita_confezione_riga ,
		:ls_ric_quantita_riga ,
		:ll_quantita_prop_riga ,
		:ls_ric_unita_base_riga ,
		:ls_ric_unita_prezzo_riga ,
		:ls_ric_id_caus_magazzino_riga ,
		:ls_ric_locazione_1_riga ,
		:ls_ric_locazione_2_riga ,
		:ls_ric_data_prev_consegna_riga ,
		:ls_ric_pesi_riga ,
		:ls_ric_dim_riga ,
		:ls_ric_colli_riga ,
		:ls_ric_id_valuta_riga ,
		:ls_ric_id_listino_riga ,
		:ls_ric_prezzo_riga ,
		:ls_ric_sconto_riga ,
		:ls_ric_prezzo_netto_riga ,
		:ls_ric_sconto_riga_riga ,
		:ls_ric_id_tab_iva_riga ,
		:ls_ric_id_sog_comm_agente_riga ,
		:ls_ric_provvigioni_riga ,
		:ls_ric_val_attribuito_riga ,
		:ls_ric_date_competenza_riga ,
		:ls_ric_contropartite_riga 
FROM "prof_documento"  
WHERE "prof_documento"."id_prof_documento" = :ll_id_prof   ;

uf_set_ric(ls_ric_num_progressivo,"num_progressivo", this) 
uf_set_ric(ls_ric_id_valuta, "documento_id_valuta_cod", this)
uf_set_ric(ls_ric_id_valuta, "documento_id_valuta_des", this)

uf_set_ric(ls_ric_quantita_riga,"quantita", idw_riga)
uf_set_ric(ls_ric_data_prev_consegna_riga,"riga_documento_data_prev_consegna", idw_riga)
uf_set_ric(ls_ric_prezzo_riga,"prezzo", idw_riga)
uf_set_ric(ls_ric_sconto_riga,"sconto", idw_riga)
uf_set_ric(ls_ric_prezzo_netto_riga,"prezzo_netto", idw_riga)
uf_set_ric(ls_ric_id_tab_iva_riga,"riga_documento_id_tab_iva", idw_riga)

is_ric_documento = ""
is_ric_documento= is_ric_documento + ls_ric_id_caus_magazzino + ls_ric_id_magazzino_1 + ls_ric_id_magazzino_2 
is_ric_documento= is_ric_documento + ls_ric_id_sog_comm_fattura + ls_ric_id_listino 
is_ric_documento= is_ric_documento + ls_ric_id_sog_comm_agente + ls_ric_id_tipo_trasporto 
is_ric_documento= is_ric_documento + ls_ric_id_sog_comm_vettore_1 
is_ric_riga = ""
is_ric_riga= is_ric_riga + ls_ric_id_unita_confezione_riga + ls_ric_quantita_riga + ls_ric_unita_base_riga
is_ric_riga= is_ric_riga + ls_ric_unita_prezzo_riga + ls_ric_id_caus_magazzino_riga + ls_ric_locazione_1_riga
is_ric_riga= is_ric_riga + ls_ric_locazione_2_riga + ls_ric_data_prev_consegna_riga + ls_ric_pesi_riga + ls_ric_dim_riga
is_ric_riga= is_ric_riga + ls_ric_colli_riga + ls_ric_id_valuta_riga  + ls_ric_id_listino_riga + ls_ric_prezzo_riga
is_ric_riga= is_ric_riga + ls_ric_sconto_riga + ls_ric_prezzo_netto_riga + ls_ric_sconto_riga_riga + ls_ric_id_tab_iva_riga
is_ric_riga= is_ric_riga + ls_ric_id_sog_comm_agente_riga + ls_ric_provvigioni_riga 
is_ric_riga= is_ric_riga + ls_ric_val_attribuito_riga  + ls_ric_date_competenza_riga + ls_ric_contropartite_riga 

if (getItemStatus(GetRow(),0,Primary!) = New!) or (getItemStatus(GetRow(),0,Primary!) = NewModified!) then
	
	CHOOSE CASE ls_tipo_fattura
		CASE "N"
			uf_Setitem(ll_row,"segno_iva","1", TRUE)
		CASE "D"
			uf_Setitem(ll_row,"segno_iva","1", TRUE)
		CASE "C"
			uf_Setitem(ll_row,"segno_iva","-1", TRUE)
	END CHOOSE
	uf_set_colval( "documento_note_intestazione", ls_note_intestazione_prop)
	uf_set_colval( "documento_id_caus_magazzino", string(ll_id_caus_magazzino_prop)) 
	uf_set_colval( "id_sog_commerciale", string(ll_id_sog_comm_prop ))
	uf_set_colval( "documento_id_magazzino", string(ll_id_magazzino_1_prop))
	uf_set_colval( "documento_id_magazzino_2", string(ll_id_magazzino_2_prop))
	uf_set_colval( "documento_id_sog_commerciale_fattura", string(ll_id_sog_comm_fattura_prop))
	uf_set_colval( "documento_id_linguaggio", string(ll_id_linguaggio_prop))
	uf_set_colval( "documento_id_valuta_des", string(ll_id_valuta_prop ))
	PostEvent("ue_set_valu_fields")
	uf_set_colval( "id_con_pagamento_des", string(ll_id_con_pagamento_prop ) )
	uf_set_colval( "documento_id_sog_commerciale_vettore", string(ll_id_sog_comm_vettore_1_prop))
	uf_set_colval( "id_lingua" , string(ll_id_lingua_prop))
	uf_set_colval( "documento_id_listino", string(ll_id_listino_prop))
	uf_set_colval( "documento_asp_beni", ls_aspetto_beni_prop)
	uf_set_colval( "documento_trasp_mezzo", ls_trasp_mezzo_prop)
	uf_set_colval( "tipo_fattura", ls_tipo_fattura)
	If IsNull(il_id_esercizio) OR il_id_esercizio=0 then event ue_set_esercizio()
	event ue_set_registro()
	event ue_set_regi_fields()
	event ue_set_sog_fields()
	event ue_set_con_pagamento()
end if
event ue_set_calc_fields()
return 0

end event

event ue_set_calc_fields;call super::ue_set_calc_fields;long 		ll_id_sog_commerciale, ll_id_esercizio,ll_id_magazzino
string 	ls_info, ls_esercizio
string 	ls_codice, ls_descrizione, ls_tipo_registro
long 		ll_destinazione, ll_registro, ll_numero, ll_prof_documento, ll_sog_comm
long		ll_sog_comm_vettore, ll_id_gruppo_agenti

ll_id_sog_commerciale= GetItemNumber(il_row, "id_sog_commerciale")
if not IsNull(ll_id_sog_commerciale) then
	
	ls_info= f_info_sc(ll_id_sog_commerciale)
	uf_SetItem(il_row,"cinfo", ls_info, TRUE)
end if

if RowCount() > 0 then
	
ll_destinazione = long(uf_get_colval("id_destinazione"))

SELECT "destinazione"."rag_soc_1" 
	INTO :ls_descrizione
	FROM "dba"."destinazione"
	WHERE ( "destinazione"."id_destinazione" = :ll_destinazione )   ;
uf_SetItem(il_row,"c_destinazione",ls_descrizione, TRUE)
	
ls_codice = ""
ls_descrizione = ""

	
	ll_prof_documento = long(uf_get_colval("id_prof_documento"))

	
	SELECT "prof_documento"."codice" , "prof_documento"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "dba"."prof_documento" 
	 	WHERE ( "prof_documento"."id_prof_documento" = :ll_prof_documento )   ;

	
	uf_SetItem(il_row,"c_prof_doc_cod",ls_codice, TRUE)
	uf_SetItem(il_row,"c_prof_doc_des",ls_descrizione, TRUE)
	
ls_codice = ""
ls_descrizione = ""

ll_sog_comm = long(uf_get_colval("id_sog_commerciale"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "dba"."sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm)   ;
	
	uf_SetItem(il_row,"c_sog_comm_cod",ls_codice, TRUE)
	uf_SetItem(il_row,"c_sog_comm_des",ls_descrizione, TRUE)
	
ls_codice = ""
ls_descrizione = ""
ll_id_magazzino = long(uf_get_colval("documento_id_magazzino"))

	
  SELECT "magazzino"."codice",   
         "magazzino"."descrizione"  
    INTO :ls_codice,   
         :ls_descrizione  
    FROM "magazzino"  
   WHERE "magazzino"."id_magazzino" = :ll_id_magazzino   ;


	
	uf_setitem(il_row,"c_magazzino_1_cod",ls_codice, TRUE)
	uf_setitem(il_row,"c_magazzino_1_des",ls_descrizione, TRUE)
	
ls_codice = ""
ls_descrizione = ""

end if

end event

event ue_set_not_new;call super::ue_set_not_new;
if not ((getItemStatus(il_row,0,Primary!) = New!) or (getItemStatus(il_row,0,Primary!) = NewModified!)) then
	il_id_documento= GetItemNumber(il_row, "id_documento")
	f_displayonly(this, "c_prof_doc_cod", TRUE)
	f_displayonly(this, "c_prof_doc_des", TRUE)
	f_displayonly(this, "c_esercizio", TRUE)
	f_displayonly(this, "num_progressivo", TRUE)
	f_displayonly(this, "documento_id_valuta_cod", TRUE)
	f_displayonly(this, "documento_id_valuta_des", TRUE)
	f_displayonly(this, "documento_cambio", TRUE)
end if
end event

event ue_set_regi_fields;call super::ue_set_regi_fields;
long 		ll_id_registro, ll_ultimo_num_reg, ll_num_suggerito_min, ll_num_suggerito_Max, ll_id_documento
decimal 	ldc_ultimo_num_reg, ldc_doc_globale
date		ld_ultima_data_reg, ld_data_prec, ld_data_succ, ld_Data
string	ls_message, ls_doc_globale

ll_id_registro = GetItemNumber(il_row,"id_registro")
	
	
	IF NOT (IsNull(ll_id_registro) OR ll_id_registro = 0) THEN
		SetNull(ld_Data)
		SQLCA.sp_Ges_NumProg_DataReg( 0,ll_id_registro, ll_ultimo_num_reg, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ, ll_id_documento);	
		
		IF IsNull(ll_ultimo_num_reg) THEN ll_ultimo_num_reg = 0
		SetItem(il_row, "num_progressivo", ll_ultimo_num_reg)
		IF IsNull(ld_data_prec) THEN ld_data_prec = Today()
		SetItem(il_row, "data_registrazione", ld_data_prec)
		SetItem(il_row, "documento_data_competenza", ld_data_prec)
		If is_tipo_registro="IV" then	
			SetItem(il_row, "num_documento", String(ll_ultimo_num_reg))
		else
			SetItem(il_row, "num_documento", "")
		end if
	END IF
event ue_set_valu_fields("")


end event

event ue_set_valu_fields;call super::ue_set_valu_fields;
long		ll_id_valuta
 
if IsNull(as_data) OR as_data="" then 
	ll_id_valuta= GetItemNumber(il_row, "documento_id_valuta_des")
else
	ll_id_valuta = long(as_data)
end if

if (not isNull(ll_id_valuta)) and (ll_id_valuta>0) then
	SELECT "valuta"."cambio",   
			"valuta"."cifra_arrotondamento" ,
			"valuta"."tipo_arrotondamento",
			"valuta"."simbolo"
		INTO :idc_cambio,   
			:il_arrotondamento,
			:is_tipo_arrotondamento ,
			:is_simbolo_valuta
		FROM "dba"."valuta"  
		WHERE "valuta"."id_valuta" = :ll_id_valuta   ;

	if sqlca.sqlcode = 0 then
		if GetItemStatus(il_row, 0, Primary!) =New! OR GetItemStatus(il_row, 0, Primary!) =NewModified! then
			SetItem (il_row,"documento_cambio",idc_cambio)
		end if
		
		
		idc_cambio= uf_GetItemDecimal(il_row, "documento_cambio")

		uf_set_dec_mask(il_arrotondamento, is_simbolo_valuta)
		iF idc_cambio = 1 then
			cbx_simbolo.checked = FALSE
			
			uf_set_dec_mask( il_arrotondamento, is_simbolo_valuta)
		end if
	else
		iuo_msg_log.uf_new_text("Impossibile settare il cambio.",3)
	end if
end if




end event

event ue_canc_intestatario;call super::ue_canc_intestatario;long ll_null

SetNull(ll_null)
SetItem(il_row, "id_sog_commerciale", ll_null)
SetItem(il_row, "c_intestatario_cod", "")
SetItem(il_row, "c_intestatario_des", "")

end event

event ue_set_sp_incasso;call super::ue_set_sp_incasso;
long ll_id_sog_commerciale

ll_id_sog_commerciale= GetItemNumber(il_row, "id_sog_commerciale")
SELECT "spesa"."id_spesa" ,"spesa_sog_commerciale"."importo"  
	INTO :il_id_spesa_incasso , 
		:idc_spesa_inc_importo  
	FROM "dba"."spesa_sog_commerciale",   
		"dba"."spesa"  
	WHERE ( "spesa"."id_spesa" = "spesa_sog_commerciale"."id_spesa" ) and  
		( ( "spesa"."codice" = 'C' ) AND  
		( "spesa_sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) )   ;

end event

event ue_set_registro;call super::ue_set_registro;
long ll_id_esercizio

SELECT Max("registro"."id_registro")
	INTO :il_id_registro  
	FROM "dba"."registro"  
	WHERE ( "registro"."id_esercizio" = :il_id_esercizio ) AND  
		( "registro"."id_mod_registro" = :il_id_mod_registro )   ;

If SQLCA.SQLCode = 0 then
	uf_SetItem(il_row, "id_registro", il_id_registro, TRUE)
	SELECT "registro"."tipo_registro"  
		INTO :is_tipo_registro
		FROM "dba"."registro"  
		WHERE "registro"."id_registro" = :il_id_registro ;

	TriggerEvent("ue_set_regi_fields")
else
	iuo_msg_log.uf_new_text("Impossibile settare automaticamente il Registro",3)
end if

end event

event ue_set_esercizio;call super::ue_set_esercizio;

long 		ll_id_registro
string  	ls_esercizio

if il_row > 0 then
	ll_id_registro = GetItemNumber(il_row,"id_registro")
	
	
	IF NOT (IsNull(ll_id_registro) OR ll_id_registro = 0) THEN
		SELECT "esercizio"."id_esercizio",   
				"esercizio"."codice"  
			INTO :il_id_esercizio,   
				:ls_esercizio  
			FROM "dba"."esercizio",   
				"dba"."registro"  
			WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
				( ( "registro"."id_registro" = :ll_id_registro ) )   ;
		
	else
	
	SELECT "azienda"."id_esercizio_proposto"
		INTO : il_id_esercizio
		FROM "dba"."azienda"   
		WHERE ( "azienda"."id_azienda" = 1 );
	end if

	uf_SetItem(il_row, "c_esercizio",il_id_esercizio, TRUE)

end if

end event

event ue_reset;call super::ue_reset;
integer 			li_size, li_counter
long 				ll_row
datawindow		ldw_item

ib_reset= TRUE
li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ldw_item.Reset()
next
ib_reset= FALSE
SetNull(il_id_esercizio)
is_tipo_registro=""
is_int_consentiti=""
is_simbolo_valuta=""
is_stato_scad_generata=""
ib_prot_modificato=FALSE
uf_set_ric("M", "c_esercizio", this)
uf_set_ric("M","num_progressivo", this) 
uf_set_ric("M", "num_documento", this)
uf_set_ric("M", "c_sog_comm_cod", this)
uf_set_ric("M", "c_sog_comm_des", this)

uf_set_ric("M", "documento_id_valuta_cod", this)
uf_set_ric("M", "documento_id_valuta_des", this)

uf_set_ric("M","quantita", idw_riga)
uf_set_ric("M","riga_documento_data_prev_consegna", idw_riga)
uf_set_ric("M","prezzo", idw_riga)
uf_set_ric("M","sconto", idw_riga)
uf_set_ric("M","prezzo_netto", idw_riga)
uf_set_ric("M","riga_documento_id_tab_iva", idw_riga)

uf_set_ric("M","data_prevista_consegna", idw_riga_tot)
uf_set_ric("M","prezzo_netto", idw_riga_tot)

is_ric_riga= "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM" 

f_displayonly(this, "c_prof_doc_cod", FALSE)
f_displayonly(this, "c_prof_doc_des", FALSE)
f_displayonly(this, "num_progressivo", FALSE)
f_displayonly(this, "documento_id_valuta_cod", FALSE)
f_displayonly(this, "documento_id_valuta_des", FALSE)
f_displayonly(this, "documento_cambio", FALSE)

end event

event ue_calc_totale;call super::ue_calc_totale;

decimal ldc_tot_righe, ldc_tot_scontato
long ll_nr_row, ll_sc_cassa, ll_sc_inc
string ls_sc_fin
u_dw_main ldw_righe

ldw_righe=dw_riga_documento_ordine_gd
ll_nr_row= ldw_righe.RowCount()
if ll_nr_row > 0 then 
	ldc_tot_righe=ldw_righe.uf_GetItemDecimal(ll_nr_row, "c_tot_righe")
else
	ldc_tot_righe=0
end if
uf_SetItem(il_row, "c_totale_righe", ldc_tot_righe, TRUE)
if IsNull(as_sc_finanziario) then
	ls_sc_fin=GetItemString(il_row, "documento_sconto_finanziario")
else
	ls_sc_fin= as_sc_finanziario
end if

if IsNull(adc_sc_fin_cassa) then
	ll_sc_cassa=GetItemNumber(il_row, "documento_sconto_fin_cassa")
else
	ll_sc_cassa= adc_sc_fin_cassa
end if

if IsNull(adc_sconto_fin_inc) then
	ll_sc_inc=GetItemNumber(il_row, "sconto_fin_incondizionato")
else
	ll_sc_inc= adc_sconto_fin_inc
end if

ldc_tot_scontato = ldc_tot_righe
ldc_tot_scontato=uf_Calcola_Prezzo(ls_sc_fin, ldc_tot_scontato, 0)
if not IsNull(ll_sc_inc) then ldc_tot_scontato = ldc_tot_scontato - ll_sc_inc
if not IsNull(ll_sc_cassa) then ldc_tot_scontato = ldc_tot_scontato - (ll_sc_cassa * ldc_tot_scontato / 100)

uf_SetItem(il_row, "c_totale_scontato", ldc_tot_scontato, TRUE)
return 0
end event

event ue_set_wz_fields;call super::ue_set_wz_fields;
string ls_id_magazzino_1, ls_id_magazzino_2, ls_id_caus_magazzino
long ll_id_locazione, ll_nr_righe, ll_count_righe

ls_id_caus_magazzino= uf_get_colval("documento_id_caus_magazzino")
if ls_id_caus_magazzino = as_array[12] then
	uf_set_colval("documento_id_caus_magazzino",as_array[12])  
else
	
	uf_set_colval("documento_id_caus_magazzino",as_array[12]) 
	ll_nr_righe= idw_riga.RowCount() 
	FOR ll_count_righe= 1 to ll_nr_righe
		
		if IsNull(idw_riga.GetItemNumber(ll_count_righe, "id_riga_doc_provenienza")) then
			idw_riga.setItem(ll_count_righe, "riga_documento_id_caus_magazzino", Long(as_array[12]))
		end if
	NEXT
end if

ls_id_magazzino_1= uf_get_colval("documento_id_magazzino")
if ls_id_magazzino_1 = as_array[13] OR IsNull(as_array[13]) OR IsNull(ls_id_magazzino_1) then
	uf_set_colval("documento_id_magazzino", as_array[13]) 
else
	
	uf_set_colval("documento_id_magazzino", as_array[13]) 
	ll_id_locazione = uf_calc_locazione(Long(as_array[13]))
	ll_nr_righe= idw_riga.RowCount() 
	FOR ll_count_righe= 1 to ll_nr_righe
		idw_riga.setItem(ll_count_righe, "id_locazione_1", ll_id_locazione)
	NEXT
end if
ls_id_magazzino_2= uf_get_colval("documento_id_magazzino_2")
SetNull(ll_id_locazione)
if ls_id_magazzino_2 = as_array[14] OR IsNull(as_array[14]) OR IsNull(ls_id_magazzino_2) then
	uf_set_colval("documento_id_magazzino_2", as_array[14]) 
else
	
	uf_set_colval("documento_id_magazzino_2", as_array[14]) 
	ll_id_locazione = uf_calc_locazione(Long(as_array[14]))
	ll_nr_righe= idw_riga.RowCount() 
	FOR ll_count_righe= 1 to ll_nr_righe
		idw_riga.setItem(ll_count_righe, "id_locazione_2", ll_id_locazione)
	NEXT
end if

uf_set_colval("documento_id_sog_commerciale_fattura", as_array[15])    

uf_set_colval("documento_id_listino", as_array[21])
uf_set_colval("id_banca_sog_commerciale", as_array[23])  
uf_set_colval("id_gruppo_agenti", as_array[24])  
uf_set_colval("documento_note_intestazione", as_array[28])  
uf_set_colval("id_tipo_trasporto",as_array[35])   
uf_set_colval("documento_id_caus_trasporto", as_array[36])  
uf_set_colval("documento_id_sog_commerciale_vettore", as_array[39])  

uf_set_colval("documento_id_tipo_pagamento", as_array[50])  
 uf_set_colval("id_documento_padre",as_array[65])
 uf_set_colval("id_prof_registrazione",as_array[66])
 uf_set_colval("des_contabile",as_array[67])

return 0

end event

event ue_set_contropartita;call super::ue_set_contropartita;
long		ll_count_riga, ll_size_riga, ll_id_articolo, ll_id_contropartita
long		ll_id_sog_commerciale, ll_id_agente

ll_id_sog_commerciale= GetItemNumber(il_row, "id_sog_commerciale")
ll_id_agente=  GetItemNumber(il_row, "id_gruppo_agenti")
ll_size_riga= idw_riga.RowCount()
FOR ll_count_riga = 1 to ll_size_riga
	ll_id_articolo= idw_riga.GetItemNumber(ll_count_riga, "riga_documento_id_articolo")
	ll_id_contropartita= wf_calcola_cpt(ll_id_sog_commerciale, ll_id_agente, ll_id_articolo)
	idw_riga.SetItem(ll_count_riga, "riga_documento_id_conto", ll_id_contropartita)
next

RETURN 0
end event

event ue_set_con_pagamento;call super::ue_set_con_pagamento;
long		ll_id_con_pagamento
decimal	ldc_sconto_cassa

ll_id_con_pagamento= GetItemNumber(il_row,"id_con_pagamento_des")
If not (IsNull(ll_id_con_pagamento) OR ll_id_con_pagamento=0) then 
	SELECT "con_pagamento"."sconto_cassa"  
		INTO :ldc_sconto_cassa  
		FROM "dba"."con_pagamento"  
		WHERE "con_pagamento"."id_con_pagamento" = :ll_id_con_pagamento  ;
	If SQLCA.SQLCode = 0 then SetItem(il_row, "documento_sconto_fin_cassa", ldc_sconto_cassa)
end if

end event

event itemchanged;call super::itemchanged;
long 			ll_id_sog_commerciale, ll_id_valuta, ll_id_tipo_trasporto, ll_Cur_IDRegistro, ll_ID_Prof_Doc
long			ll_gg_prev_cons,ll_numero, ll_num_succ, ll_num_prec, ll_id_con_pagamento, ll_old_numero
long 			ll_id_magazzino, ll_id_locazione, ll_nr_righe, ll_count_righe, ll_num_suggerito_min, ll_num_suggerito_max
string		ls_sc_fin, ls_tipo_registro, ls_descrizione, ls_codice, ls_info
date			ld_Ultima_Data_Reg, ld_Data, ld_Old_Data,ld_data_succ, ld_data_prec
string		ls_tb, ls_cp, ls_vr, ls_tr, ls_rag_soc, ls_sql, ls_prec,ls_succ
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_null, ls_message
integer		li_ok
decimal 		ldc_tot_righe, ldc_sc_1, ldc_sc_2, ldc_tot_scontato, ldc_sconto_cassa, ldc_null
long			ll_sc_imp, ll_id_documento
boolean		lb_loading

SetNull(ls_null)
SetNull(ldc_null)
CHOOSE CASE dwo.name

	
	CASE 'c_prof_doc_cod'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		ls_dwc[1] = "c_prof_doc_cod"
		ls_dwc[2] = "c_prof_doc_des"
		ls_dwc[3] = "id_prof_documento"
		ls_sql = "prof_documento.tipo_registro = 'GA' OR prof_documento.tipo_registro = 'GV'"
		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"codice","A",data,ls_sql,3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			event ue_set_prof_fields()
			return 2 
		end if
		
	CASE 'c_prof_doc_des'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		ls_dwc[1] = "c_prof_doc_cod"
		ls_dwc[2] = "c_prof_doc_des"
		ls_dwc[3] = "id_prof_documento"
		ls_sql = "prof_documento.tipo_registro = 'GA' OR prof_documento.tipo_registro = 'GV'"
		li_ok = uf_autofind_col (string(dwo.name),"prof_documento",&
										"descrizione","A",data,ls_sql,3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
				event ue_set_prof_fields()
				return 2 
		end if
		
	CASE 'c_esercizio'
		If not(IsNull(data) OR data = "") then
			SELECT "esercizio"."id_esercizio"  
			INTO :il_id_esercizio  
			FROM "dba"."esercizio"  
			WHERE "esercizio"."id_esercizio" = :data   ;
			if SQLCA.SQLCode = 0 then
				event ue_set_registro()
				event ue_set_calc_fields()
			end if
		else
			il_id_esercizio =0
		end if

	CASE 'c_registro_des'
		
		ll_ID_Prof_Doc=GetItemNumber(il_row,"id_prof_documento")
		If not(IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc=0) then
			uf_SW_SetNull(data, 'id_registro')
			ls_dbc[1] = "descrizione"
			ls_dbc[2] = "id_registro"
			ls_dwc[1] = "c_registro_des"
			ls_dwc[2] = "id_registro"
			li_ok = uf_autofind_col (string(dwo.name),"registro","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)
			if li_ok > 0 then
				event ue_set_regi_fields()
				ll_Cur_IDRegistro= GetItemNumber(il_row, "id_registro")
				if not IsNull(ll_Cur_IDRegistro) then
	
					SELECT "registro"."tipo_registro",   
						"registro"."numero", 
						 "registro"."descrizione", 
						"esercizio"."codice"  
					INTO :is_tipo_registro,   
						:ll_numero, 
						:ls_descrizione,  
						:ls_codice  
					FROM "dba"."esercizio",   
						"dba"."registro"  
					WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
						( ( "registro"."id_registro" = :ll_Cur_IDRegistro ) )   ;
					uf_set_colval("c_registro", "Esercizio: " + ls_codice + " - " + &
					  "Tipo: " + ls_tipo_registro + " - " + &
					  "Numero: " + string(ll_numero))
					SetItem(il_row,"c_sog_comm_des", ls_rag_soc)
				end if
				return 2 
			end if
		end if

	CASE 'c_registro'
		uf_SW_SetNull(data, 'id_registro')
		event ue_set_regi_fields()

	CASE "num_progressivo"
		lb_loading=FALSE
		ib_prot_modificato=TRUE
		ll_numero = Long(data)
		ll_Cur_IDRegistro= GetItemNumber(il_row, "id_registro")
		ll_old_numero=GetItemNumber(il_row, "num_progressivo")
		if not IsNull(ll_Cur_IDRegistro) then
			iuo_msg_log.uf_new_text("Verifica del Numero Progressivo '" + String(data) + "'.",3)
			ld_Data=GetItemDate(il_row, "data_registrazione")
			ld_Old_Data= ld_Data
			SQLCA.sp_Ges_NumProg_DataReg( 2,ll_Cur_IDRegistro, ll_numero, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ,ll_id_documento);	
			If IsNull(ll_numero)  then 
				If IsNull(ll_id_documento) then
					iuo_msg_log.uf_new_text("Il Numero Progressivo '" + String(data) + "' non risulta valido.",4)
					if not (IsNull(ls_message) OR ls_message ="") then iuo_msg_log.uf_new_text(ls_message,4)
					If MessageBox(is_title, "Il valore inserito non è accettabile,"&
							+ "~n calcolare automaticamente il Numero Progressivo?",Information!,  YesNo!, 1) = 1 then
						
	
						ll_numero = ll_num_suggerito_min
					else
						
	
						ll_numero = ll_old_numero
						
						ld_Data= ld_Old_Data
					end if
				else
					If MessageBox(is_title, "Esiste già un Documento con Progressivo '" + String(data) + &
							"'~n vuoi modificarlo?",Information!,  YesNo!, 2) = 1 then
						lb_loading= TRUE
					else
						ll_numero = ll_old_numero
					end if
				end if
			else
				
			
			end if
			if IsNull(ld_Data) then
				if not (IsNull(ls_message) OR ls_message ="") then iuo_msg_log.uf_new_text(ls_message,4)
				SetItem(il_row, "data_registrazione", ld_data_prec)
				MessageBox(is_title, "La Data Registrazione non era valida ~n per il Numero Progressivo fornito : ~n è stata temporaneamente sostituita con " + String(ld_data_prec) + ".")
				iuo_msg_log.uf_new_text("La Data Registrazione non era valida per il Numero Progressivo fornito : è stata temporaneamente sostituita con " + String(ld_data_prec) + ".",4)
			end if
		end if
		If lb_loading then
			Post uf_load_documento(ll_id_documento)
		else
			Post SetItem(il_row, "num_progressivo", ll_numero)
		end if

	CASE 'data_registrazione'
		
		
		SetItem(il_row, "documento_data_competenza", date(data))
		ll_Cur_IDRegistro = GetItemNumber(il_row, "id_registro")
		ll_ID_Prof_Doc = GetItemNumber(il_row, "id_prof_documento")
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) AND NOT (IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc = 0) THEN
			ld_Ultima_Data_Reg=Date(data)
			SELECT "prof_documento"."gg_consegna"  
				INTO :ll_gg_prev_cons  
				FROM "dba"."prof_documento"  
				WHERE "prof_documento"."id_prof_documento" = :ll_ID_Prof_Doc   ;
			SetItem(il_row, "data_prev_consegna", RelativeDate(ld_Ultima_Data_Reg, ll_gg_prev_cons))
		END IF	
	
		ll_numero = GetItemNumber(il_row, "num_progressivo")
		ll_Cur_IDRegistro= GetItemNumber(il_row, "id_registro")
			if is_con_data_progressiva = 'S' then
				ls_prec=""
				ls_succ=""
				ld_Data=Date(data)
				if not IsNull(ll_Cur_IDRegistro) then
					iuo_msg_log.uf_new_text("Verifica della Data di Registrazione '" + String(data) + "'.",3)
					ld_Old_Data= GetItemDate(il_row, "data_registrazione")
					If ib_prot_modificato then
						SQLCA.sp_Ges_NumProg_DataReg( 2,ll_Cur_IDRegistro, ll_numero, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ,ll_id_documento);	
					else
						SQLCA.sp_Ges_NumProg_DataReg( 1,ll_Cur_IDRegistro, ll_numero, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ,ll_id_documento);	
					end if
					If IsNull(ld_Data) then 
					
						If not IsNUll(ld_data_prec) then ls_prec = "e~n successiva al '" + String(ld_data_prec) + "' "
						If not IsNUll(ld_data_succ) then ls_succ = "e~n precedente al '" + String(ld_data_succ) + "'"
						MessageBox(is_title, "La Data corretta deve esser" + ls_prec + ls_succ + ".", Information!)
						iuo_msg_log.uf_new_text("La Data corretta deve esser" + ls_prec + ls_succ + ".",4)
						Post SetItem(il_row, "data_registrazione", ld_Old_Data) 
					end if
				end if
			end if

	CASE 'c_sog_comm_cod'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_sog_comm_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_sog_comm_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			CHOOSE CASE uf_check_sospesi()
				CASE "OK"
					TriggerEvent("ue_set_sog_fields")
					return 2 
				CASE "AVVISA"
					MessageBox("Documento","Cliente Fuori Limite di Fido")
					TriggerEvent("ue_set_sog_fields")
				CASE "BLOCCA"
					MessageBox("Documento","Cliente Fuori Limite di Fido")
					PostEvent("ue_canc_intestatario")
			END CHOOSE
			post event ue_set_contropartita()
		end if

	CASE 'c_sog_comm_des'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_sog_comm_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "id_sog_commerciale"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_sog_comm_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"rag_soc_1","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			TriggerEvent("ue_set_sog_fields")
			post event ue_set_contropartita()

			return 2 
		end if

	CASE 'c_destinazione'
		
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_destinazione"
		ls_dbc[2] = "id_destinazione"
		ls_dwc[2] = "id_destinazione"
		li_ok = uf_autofind_col (string(dwo.name),"destinazione",&
										"rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
				return 2 
		end if
	CASE "id_con_pagamento", "id_con_pagamento_des"
		Post TriggerEvent("ue_set_con_pagamento")

	case "documento_id_valuta_cod","documento_id_valuta_des"
		event ue_set_valu_fields(data)

	CASE "data_documento"
		
		ld_Data= GetItemDate(il_row, "data_registrazione")
		If not IsNull(ld_Data) then
			If DaysAfter(Date(data), ld_Data) < 0 then
				RETURN 1
			end if

		end if

	CASE 'c_vettore_cod'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_vettore_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "documento_id_sog_commerciale_vettore"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_vettore_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if

	CASE 'c_vettore_des'
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_vettore_des"
		ls_dbc[2] = "id_sog_commerciale"
		ls_dwc[2] = "documento_id_sog_commerciale_vettore"
		ls_dbc[3] = "codice"
		ls_dwc[3] = "c_vettore_cod"
		li_ok = uf_autofind_col (string(dwo.name),"sog_commerciale_gen",&
										"rag_soc_1","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			return 2 
		end if
	CASE 'c_gruppo_agenti_cod'
		ls_dbc[1] = "codice"
		ls_dwc[1] = "c_gruppo_agenti_cod"
		ls_dbc[2] = "id_gruppo_agenti"
		ls_dwc[2] = "id_gruppo_agenti"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_gruppo_agenti_des"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			post event ue_set_contropartita()

			return 2 
		end if

	CASE 'c_gruppo_agenti_des'
		ls_dbc[1] = "descrizione"
		ls_dwc[1] = "c_gruppo_agenti_cod"
		ls_dbc[2] = "id_gruppo_agenti"
		ls_dwc[2] = "id_gruppo_agenti"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_gruppo_agenti_des"
		li_ok = uf_autofind_col (string(dwo.name),"gruppo_agenti",&
										"descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			post event ue_set_contropartita()

			return 2 
		end if
	CASE "c_magazzino_1_cod"
		ls_dbc[1] = "codice"
		ls_dwc[1] = "c_magazzino_1_cod"
		ls_dbc[2] = "id_magazzino"
		ls_dwc[2] = "documento_id_magazzino"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_magazzino_1_des"
		li_ok = uf_autofind_col (string(dwo.name),"magazzino",&
										"codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			ll_id_magazzino = Long(ls_dbv[2])
			If not(IsNull(ll_id_magazzino) OR ll_id_magazzino=0) then uf_Agg_Loc_1_Riga(ll_id_magazzino)
			return 2 
		end if

	CASE "c_magazzino_1_des"
	ls_dbc[1] = "codice"
		ls_dwc[1] = "c_magazzino_1_cod"
		ls_dbc[2] = "id_magazzino"
		ls_dwc[2] = "documento_id_magazzino"
		ls_dbc[3] = "descrizione"
		ls_dwc[3] = "c_magazzino_1_des"
		li_ok = uf_autofind_col (string(dwo.name),"magazzino",&
										"descrizione","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			ll_id_magazzino = Long(ls_dbv[2])
			If not(IsNull(ll_id_magazzino) OR ll_id_magazzino=0) then uf_Agg_Loc_1_Riga(ll_id_magazzino)
			return 2 
		end if

	CASE "documento_id_valuta_cod", "documento_id_valuta_des"
		event ue_set_valu_fields(data)
	
	CASE "documento_cambio"
		ll_id_valuta= GetItemNumber(il_row, "documento_id_valuta_cod")
		event ue_set_valu_fields(String(ll_id_valuta))
	CASE "documento_sconto_finanziario"
		Event ue_calc_totale(string(data), ldc_null, ldc_null)

	CASE "documento_sconto_fin_cassa"
		Event ue_calc_totale(ls_null,Dec(data), ldc_null)

	CASE "sconto_fin_incondizionato"
		Event ue_calc_totale(ls_null, ldc_null,Dec(data))
	CASE "id_gruppo_agenti"
		post event ue_set_contropartita()

END CHOOSE

end event

event ue_set_search;call super::ue_set_search;string ls_intestatari, ls_int_cons,ls_tipo_reg
long ll_count, ll_len, ll_id_prof_documento, ll_row, ll_id_sog_comm, ll_id_mod_registro

ll_row = GetRow()

ls_intestatari =""
if not (IsNull(is_int_consentiti) OR is_int_consentiti="")  then
	ll_len = Len(is_int_consentiti)
	for ll_count = 1 to ll_len
		ls_intestatari = ls_intestatari + ",'" + Mid(is_int_consentiti, ll_count, 1) + "'"
	next
	if not IsNull(ls_intestatari) then ls_intestatari = Mid(ls_intestatari, 2,Len(ls_intestatari)-1)
	ls_intestatari = "(" + ls_intestatari + ")"
end if


ls_tipo_reg = is_list.s_win_parametri

CHOOSE CASE as_nomecol

	CASE "c_prof_doc_cod"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_codice" 
		
		is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'GA' OR prof_documento.tipo_registro = 'GV'"

	CASE "c_prof_doc_des"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_descrizione" 
		
		is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'GA' OR prof_documento.tipo_registro = 'GV'"

	CASE "c_magazzino_1_cod"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		

	CASE "c_magazzino_1_des"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		

	CASE "c_destinazione"
		ll_id_sog_comm = GetItemNumber(il_row,"id_sog_commerciale")
		is_search_window = "w_destinazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		if not (IsNull(ll_id_sog_comm) OR ll_id_sog_comm= 0) then is_ricpar.s_sql_cond = "destinazione.id_sog_commerciale = " + string(ll_id_sog_comm)


	CASE "c_magazzino_2_cod"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		

	CASE "c_magazzino_2_des"
		is_search_window = "w_magazzino_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		

	CASE "c_sog_comm_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
		is_ricpar.b_asneeded= TRUE
		if not (IsNull(ls_intestatari) OR ls_intestatari="") then is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo IN " + ls_intestatari

	CASE "c_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		is_ricpar.b_asneeded= TRUE
		if not (IsNull(ls_intestatari) OR ls_intestatari="") then is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo IN " + ls_intestatari


END CHOOSE
CHOOSE CASE as_nomecol
		
	CASE "id_tipo_trasporto"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Trasporto"
		is_ricpar.s_ausil_value[1] = "id_tipo_trasporto_des"

		is_ricpar.i_width = 2606
		is_ricpar.i_height = 873
	CASE "id_tipo_trasporto_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tipo_trasporto_gd"
		is_ricpar.s_titolo_finestra = "Tipi di Trasporto"
		is_ricpar.s_ausil_value[1] = "id_tipo_trasporto"
		is_ricpar.i_width = 2606
		is_ricpar.i_height = 873
		
	CASE "documento_id_valuta_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "documento_id_valuta_des"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
	CASE "documento_id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "documento_id_valuta_cod"
		is_ricpar.i_width = 2798
		is_ricpar.i_height = 861
		
END CHOOSE


end event

event ue_use_search;call super::ue_use_search;
long ll_id_valuta , ll_id_tipo_trasporto, ll_id_sog_commerciale, ll_row, ll_id_magazzino

ll_row= GetRow()
CHOOSE CASE as_nomecol

	CASE "c_prof_doc_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_doc_des", is_ricpar.s_ausil_value[1])
		event ue_set_prof_fields()

	CASE "c_prof_doc_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_prof_documento", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_prof_doc_cod", is_ricpar.s_ausil_value[1])
		event ue_set_prof_fields()

	CASE "c_magazzino_1_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_magazzino_1_des", is_ricpar.s_ausil_value[1])
		ll_id_magazzino = Long(is_ricpar.s_id_seg_value[1])
		If not(IsNull(ll_id_magazzino) OR ll_id_magazzino=0) then uf_Agg_Loc_1_Riga(ll_id_magazzino)

	CASE "c_magazzino_1_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_magazzino", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_magazzino_1_cod", is_ricpar.s_ausil_value[1])
		ll_id_magazzino = Long(is_ricpar.s_id_seg_value[1])
		If not(IsNull(ll_id_magazzino) OR ll_id_magazzino=0) then uf_Agg_Loc_1_Riga(ll_id_magazzino)


	CASE "c_destinazione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_destinazione", is_ricpar.s_id_seg_value[1])

	CASE "c_magazzino_2_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_magazzino_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_magazzino_2_des", is_ricpar.s_ausil_value[1])
		ll_id_magazzino = Long(is_ricpar.s_main_value)
		If not(IsNull(ll_id_magazzino) OR ll_id_magazzino=0) then uf_Agg_Loc_2_Riga(ll_id_magazzino)

	CASE "c_magazzino_2_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_magazzino_2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_magazzino_2_cod", is_ricpar.s_ausil_value[1])
		ll_id_magazzino = Long(is_ricpar.s_main_value)
		If not(IsNull(ll_id_magazzino) OR ll_id_magazzino=0) then uf_Agg_Loc_2_Riga(ll_id_magazzino)

	CASE "c_sog_comm_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_des", is_ricpar.s_ausil_value[1])
		triggerEvent("ue_set_sog_fields")

	CASE "c_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		triggerEvent("ue_set_sog_fields")

END CHOOSE

end event

event ue_init;call super::ue_init;iudw_children[1] = dw_riga_documento_ordine_gd


is_title = is_nome_tipo_documento
end event

event ue_default;call super::ue_default;

string 	ls_codice, ls_Par_Menu_Cod, ls_tipo_registro, ls_descrizione
long 		ll_id_registro, ll_numero, ll_Cur_IDRegistro, ll_ID_Prof_Doc, ll_Ultimo_Num_Reg, ll_id_tipo_trasporto
long 		ll_id_intestatario, ll_id_con_pagam, ll_gg_prev_cons, ll_id_attivita, ll_id_esercizio
long 		ll_id_valuta, ll_id_agente, ll_id_dest, ll_id_sog_commerciale
date 		ld_Ultima_Data_Reg
decimal 	ldc_sconto_cassa
string	ls_dbc[], ls_dwc[], ls_dbv[]
integer	li_ok


ls_Par_Menu_Cod = trim(THIS.is_list.s_win_parametri)


ll_Cur_IDRegistro = GetItemNumber(al_row, "id_registro")
ll_ID_Prof_Doc = GetItemNumber(al_row, "id_prof_documento")
ll_id_intestatario=GetItemNumber(al_row, "id_sog_commerciale")

CHOOSE CASE string(adwo_current.name)
	
		

	CASE "num_progressivo"
		
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) THEN
			SELECT MAX("documento"."num_progressivo")
				INTO :ll_Ultimo_Num_Reg
				FROM "dba"."documento"   
				WHERE "documento"."id_registro" = :ll_Cur_IDRegistro;
	
			
			IF IsNull(ll_Ultimo_Num_Reg) THEN ll_Ultimo_Num_Reg = 0
			SetItem(al_row, "num_progressivo", (ll_Ultimo_Num_Reg+1))
		END IF

	CASE "data_registrazione"
		
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) THEN
			SELECT MAX("documento"."data_documento")
				INTO :ld_Ultima_Data_Reg
				FROM "dba"."documento"   
				WHERE "documento"."id_registro" = :ll_Cur_IDRegistro;
			
			
			IF IsNull(ld_Ultima_Data_Reg) THEN ld_Ultima_Data_Reg = Today()
			SetItem(al_row, "data_registrazione", ld_Ultima_Data_Reg)
			SetItem(al_row, "documento_data_competenza", ld_Ultima_Data_Reg)
		END IF

	CASE "documento_id_valuta_cod"
		
		
		select "par_sistema"."id_valuta"
			into :ll_id_valuta

			from "dba"."par_sistema"
			where "par_sistema"."id_azienda" = 1;

		SetItem(al_row, "documento_id_valuta_cod", ld_Ultima_Data_Reg)


	case "c_agente_cod","c_agente_des"
		
		ll_id_agente = u_freddie.gl_null
		ll_id_dest = this.GetItemNumber(al_row,"id_destinazione")
		if (not IsNull(ll_id_dest)) and (ll_id_dest>0) then
		end if
		if isNull(ll_id_agente) then
			ll_id_sog_commerciale = this.GetItemNumber(al_row,"id_sog_commerciale")

			SELECT "sog_commerciale"."id_gruppo_agenti"  
    			INTO :ll_id_agente  
    			FROM "dba"."sog_commerciale"  
   			WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale;
		end if
		if not isNull(ll_id_agente) then
			ls_dbc[1] = "codice"
			ls_dbc[2] = "descrizione"
			ls_dbc[3] = "id_gruppo_agenti"
			ls_dwc[1] = "c_gruppo_agenti_cod"
			ls_dwc[2] = "c_gruppo_agenti_des"
			ls_dwc[3] = "id_gruppo_agenti"
			li_ok = uf_autofind_col ("id_gruppo_agenti","gruppo_agenti",&
										"id_sog_commerciale","A",string(ll_id_agente),"",3,ls_dbc,ls_dbv,ls_dwc)
		end if
		
	CASE "data_prev_consegna"
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) AND NOT (IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc = 0) THEN

			ld_Ultima_Data_Reg=GetItemDate(al_row, "data_registrazione")
			SELECT "prof_documento"."gg_consegna"  
				INTO :ll_gg_prev_cons  
				FROM "dba"."prof_documento"  
				WHERE "prof_documento"."id_prof_documento" = :ll_ID_Prof_Doc ;
			SetItem(al_row, "data_prev_consegna", RelativeDate(ld_Ultima_Data_Reg, ll_gg_prev_cons))
		END IF	
		
		
END CHOOSE

end event

event ue_update;
integer li_RetVal

li_RetVal = super::EVENT ue_update(wparam, lparam)

uf_set_currow()
event ue_set_not_new()
RETURN li_RetVal 
end event

event rowfocuschanged;call super::rowfocuschanged;
if not ib_reset then
	
	uf_set_currow()
	If IsNull(il_row) OR il_row = 0 then
		il_row=currentrow
		If IsNull(il_row) OR il_row = 0 then
			MessageBox(is_title,"ERRORE FATALE: Non è possibile considerare una riga di documento valida.", Exclamation!)
			HALt CLOSE 
		end if	
	end if	
	
	if GetItemStatus(il_row, 0,Primary!) = NewModified! OR GetItemStatus(il_row, 0,Primary!) = New! then
		this.Object.c_prof_doc_cod.Protect=0
		this.Object.c_prof_doc_des.Protect=0
	
		this.Object.c_sog_comm_cod.Protect=0
		this.Object.c_sog_comm_des.Protect=0
	else
		this.Object.c_prof_doc_cod.Protect=1
		this.Object.c_prof_doc_des.Protect=1
		this.Object.c_sog_comm_cod.Protect=1
		this.Object.c_sog_comm_des.Protect=1
	end if
end if
end event

event ue_itemerror;call super::ue_itemerror;long 		ll_id_registro, ll_numero, ll_num_prec, ll_num_succ, ll_ret_value, ll_days
long 		ll_Cur_IDRegistro, ll_num_suggerito_min, ll_num_suggerito_max,ll_id_documento
date 		ld_Data, ld_data_prec, ld_data_succ, ld_Old_Data
string 	ls_colonna, ls_message, ls_value, ls_prec ,ls_succ, ls_nome

SetNull(ll_ret_value)
CHOOSE CASE adwo_dwo.name

	CASE "data_documento"
		
		ld_Data= GetItemDate(al_row, "data_registrazione")
		ll_days= DaysAfter(Date(as_data), ld_Data)
		If not isNull(ll_days) then
			If ll_days < 0 then
				MessageBox("Documento", "Immettere una data di Documento e ~r precedente alla data di Registrazione.", Exclamation!)
				iuo_msg_log.uf_new_text("Immettere una data di Documento precedente alla data di Registrazione.",3)
				ll_ret_value = 1
			end if
		end if

	CASE "data_registrazione"
	
		ll_numero = GetItemNumber(al_row, "num_progressivo")
		ll_Cur_IDRegistro= GetItemNumber(al_row, "id_registro")
			if is_con_data_progressiva = 'S' then
				ld_Data=Date(as_data)
				if not IsNull(ll_Cur_IDRegistro) then
					iuo_msg_log.uf_new_text("Verifica della Data di Registrazione '" + String(ld_Data) + "'.",3)
					ld_Old_Data= GetItemDate(il_row, "data_registrazione")
					If ib_prot_modificato then
						SQLCA.sp_Ges_NumProg_DataReg(2,ll_Cur_IDRegistro, ll_numero, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ,ll_id_documento);	
					else
						SQLCA.sp_Ges_NumProg_DataReg(0,ll_Cur_IDRegistro, ll_numero, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ,ll_id_documento);	
					end if
					If IsNull(ld_Data) then 
					
						If not IsNUll(ld_data_prec) then ls_prec = "e~n successiva al '" + String(ld_data_prec) + "' "
						If not IsNUll(ld_data_succ) then ls_succ = "e~n precedente al '" + String(ld_data_succ) + "'"
						MessageBox(is_title, "La Data corretta deve esser" + ls_prec + ls_succ + ".", Information!)
						iuo_msg_log.uf_new_text("La Data corretta deve esser" + ls_prec + ls_succ + ".",4)
						Post SetItem(il_row, "data_registrazione", ld_Old_Data) 
					end if
			end if
		end if

		
END CHOOSE

IF (this.Describe(adwo_dwo.name + ".edit.required") = "yes") and  IsNull(ll_ret_value) AND IsNull(as_data) then
	ll_ret_value= 2
	ls_nome= Describe(adwo_dwo.name + "_t.text")
	MessageBox(is_title + " " + adwo_dwo.name, "Il campo " + ls_nome + " è obbligatorio :~rinserire quanto prima un valore.", Information!)
	iuo_msg_log.uf_new_text("Il campo è obbligatorio :~rinserire quanto prima un valore.", 3)
	ls_value= uf_get_colval(adwo_dwo.name)
	post uf_set_colval(adwo_dwo.name,ls_value)
end if

RETURN ll_ret_value



end event

event ue_validate_row;call super::ue_validate_row;
long 		ll_id_prof, ll_err_count, ll_id_doc_riferimento, ll_Cur_IDRegistro,ll_numero, ll_protocollo
string 	ls_ric_id_registro, ls_ric_num_progressivo, ls_ric_num_documento, ls_ric_id_caus_magazzino
string 	ls_ric_id_sog_comm, ls_ric_id_con_pagamento, ls_ric_id_sog_comm_agente, ls_ric_id_tipo_trasporto
string 	ls_ric_id_valuta, ls_ric_id_sog_comm_vettore_1, ls_note_intestazione_prop
string 	ls_aspetto_beni_prop, ls_trasp_mezzo_prop
string 	ls_ric_id_caus_trasporto ,ls_ric_volumi 
string 	ls_ric_pesi ,ls_ric_colli_documento ,ls_ric_data_trasporto ,ls_ric_trasp_mezzo ,ls_ric_asp_beni 
date		ld_Data, ld_data_prec, ld_data_succ
long 		ll_id_documento, ll_num_suggerito_max, ll_num_suggerito_min
string	ls_message

ll_err_count=0
SetNull(ld_Data)
ll_Cur_IDRegistro= GetItemNumber(al_row, "id_registro")
ll_id_documento= GetItemNumber(al_row, "id_documento")
ll_numero=GetItemNumber(al_row, "num_progressivo")
ll_protocollo=ll_numero
If ib_prot_modificato then
	SQLCA.sp_Ges_NumProg_DataReg(2,ll_Cur_IDRegistro, ll_numero, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ,ll_id_documento);	
	as_error_text="Il Protocollo '"+String(ll_protocollo) + "' non risulta valido."
else
	SQLCA.sp_Ges_NumProg_DataReg(0,ll_Cur_IDRegistro, ll_numero, ld_Data,ls_message, ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ,ll_id_documento);	
	If IsNull(ll_numero) then
	
		If not IsNull(ll_num_suggerito_min) then
			SetItem(al_row, "num_progressivo", ll_num_suggerito_min)
			iuo_msg_log.uf_new_text("Il Protocollo '"+String(ll_protocollo) + "' non risulta valido: è stato sostituito con '"+String(ll_num_suggerito_min)+"'.",4)
		end if
	end if
end if

ll_id_prof=GetItemNumber(al_row, "id_prof_documento")
If not (IsNull(ll_id_prof) OR  ll_id_prof=0) then
	SELECT "prof_documento"."ric_id_registro",   
			"prof_documento"."ric_num_progressivo",   
			"prof_documento"."ric_num_documento",   
			"prof_documento"."ric_id_caus_magazzino",   
			"prof_documento"."ric_id_sog_comm",   
			"prof_documento"."ric_id_con_pagamento",   
			"prof_documento"."ric_id_sog_comm_agente",   
			"prof_documento"."ric_id_tipo_trasporto",   
			"prof_documento"."ric_id_valuta",   
			"prof_documento"."ric_id_sog_comm_vettore_1",
	
			"prof_documento"."ric_colli_documento",
			"prof_documento"."ric_pesi", 
			"prof_documento"."ric_volumi",  
			"prof_documento"."ric_id_caus_trasporto",
			"prof_documento"."ric_asp_beni",
			"prof_documento"."ric_trasp_mezzo", 
			"prof_documento"."ric_data_trasporto"
	 INTO :ls_ric_id_registro, 
			:ls_ric_num_progressivo,
			:ls_ric_num_documento, 
			:ls_ric_id_caus_magazzino,
			:ls_ric_id_sog_comm, 
			:ls_ric_id_con_pagamento, 
			:ls_ric_id_sog_comm_agente, 
			:ls_ric_id_tipo_trasporto,
			:ls_ric_id_valuta, 
			:ls_ric_id_sog_comm_vettore_1,
	
			:ls_ric_colli_documento,
			:ls_ric_pesi, 
			:ls_ric_volumi,  
			:ls_ric_id_caus_trasporto,
			:ls_ric_asp_beni,
			:ls_ric_trasp_mezzo, 
			:ls_ric_data_trasporto
	FROM "dba"."prof_documento"  
	WHERE "prof_documento"."id_prof_documento" = :ll_id_prof   ;
	If SQLCA.SQLCode = 0 then
		If ls_ric_id_registro= "O" then 
			if IsNull(uf_get_colval("id_registro")) then
				as_error_text= as_error_text + "~n  Il Registro non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_num_progressivo= "O" then 
			if IsNull(uf_get_colval("num_progressivo")) then
				as_error_text= as_error_text + "~n Il Numero Progressivo non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_num_documento= "O" then 
			if IsNull(uf_get_colval("num_documento")) then
				as_error_text= as_error_text + "~n Il Numero del Documento non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		
		If ls_ric_id_sog_comm= "O" then 
			if IsNull(uf_get_colval("id_sog_commerciale")) then
				as_error_text= as_error_text + "~n L'Intestatario non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_caus_magazzino= "O" then 
			if IsNull(uf_get_colval("documento_id_caus_magazzino")) then
				as_error_text= as_error_text + "~n La Causale di Magazzino non può essere nulla."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_con_pagamento= "O" then 
			if IsNull(uf_get_colval("id_con_pagamento")) then
				as_error_text= as_error_text + "~n La Condizione di Pagamento non può essere nulla."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_tipo_trasporto= "O" then 
			if IsNull(uf_get_colval("id_tipo_trasporto")) then
				as_error_text= as_error_text + "~n Il Tipo di Trasporto non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_sog_comm_agente= "O" then 
			if IsNull(uf_get_colval("id_gruppo_agenti")) then
				as_error_text= as_error_text + "~n L'Agente non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_valuta= "O" then 
			if IsNull(uf_get_colval("documento_id_valuta_des")) then
				as_error_text= as_error_text + "~n La Valuta non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		If ls_ric_id_sog_comm_vettore_1= "O" then 
			if IsNull(uf_get_colval("documento_id_sog_commerciale_vettore")) then
				as_error_text= as_error_text + "~n Il Vettore non può essere nullo."
				ll_err_count = ll_err_count + 1
			end if
		end if
		if is_tipo_documento <> "O" AND is_tipo_documento <> "P" then
			
			If ls_ric_colli_documento= "O" then 
				if IsNull(uf_get_colval("documento_num_colli")) then
					as_error_text= as_error_text + "~n Il Numero dei Colli non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_pesi= "O" then 
				if IsNull(uf_get_colval("documento_peso_netto")) then
					as_error_text= as_error_text + "~n Il Peso Netto non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_pesi= "O" then 
				if IsNull(uf_get_colval("documento_peso_lordo")) then
					as_error_text= as_error_text + "~n Il Peso Lordo non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_id_caus_trasporto= "O" then 
				if IsNull(uf_get_colval("documento_id_caus_trasporto")) then
					as_error_text= as_error_text + "~n La Causale di Trasporto non può essere nulla."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_asp_beni= "O" then 
				if IsNull(uf_get_colval("documento_asp_beni")) then
					as_error_text= as_error_text + "~n L' Aspetto dei Beni non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			If ls_ric_trasp_mezzo= "O" then 
				if IsNull(uf_get_colval("documento_tras_mezzo")) then
					as_error_text= as_error_text + "~n Il Mezzo di Trasporto non può essere nullo."
					ll_err_count = ll_err_count + 1
				end if
			end if
			
			If ls_ric_data_trasporto= "O" then 
				if IsNull(uf_get_colval("documento_data_trasporto")) then
					as_error_text= as_error_text + "~n La Data di Trasporto non può essere nulla."
					ll_err_count = ll_err_count + 1
				end if
			end if
		end if
	end if
end if	
If uf_get_colval("tipo_fattura") = "C" OR uf_get_colval("tipo_fattura") = "D" then
	ll_id_doc_riferimento= GetItemNumber(al_row, "id_documento_padre")
	If IsNull(ll_id_doc_riferimento) OR ll_id_doc_riferimento=0 then
			as_error_text= as_error_text + "~n Per questo tipo di documento deve essere definito un Documento di Riferimento,~n è possibile accedervi tramite il bottone ~"Altro...~"."
			ll_err_count = ll_err_count + 1
	end if
end if
if IsNull(uf_get_colval("documento_id_magazzino")) then
	as_error_text= as_error_text + "~n Il Magazzino Principale non può essere nullo."
	ll_err_count = ll_err_count + 1
end if

If ll_err_count > 0 then iuo_msg_log.uf_new_text(as_error_text, 2)
return ll_err_count

end event

event ue_insert;call super::ue_insert;
is_title = is_nome_tipo_documento
uf_set_currow()
event ue_set_esercizio()

end event

event doubleclicked;call super::doubleclicked;
CHOOSE CASE dwo.name
	CASE "c_esercizio"
		IF GetItemStatus(il_row, 0, Primary!) = New! OR GetItemStatus(il_row, 0, Primary!) = NewModified! THEN
			THIS.Object.c_esercizio.Protect = 0
			THIS.SetColumn("c_esercizio")
		END IF
END CHOOSE
end event

type p_arrow from picture within w_mov_magazzino_cx
int X=46
int Y=884
int Width=55
int Height=72
boolean BringToTop=true
string PictureName="s:\pb\cometa\sel_riga.bmp"
boolean FocusRectangle=false
boolean OriginalSize=true
end type

type dw_riga_documento_ordine_gd from u_dw_master_main within w_mov_magazzino_cx
event type integer ue_setta_prezzo ( )
event type string ue_get_nrcolval ( integer al_column )
event type long ue_setta_un_conf ( )
event ue_setta_rif_des_agg ( )
event ue_set_arti_riga ( )
event ue_set_ucon_riga ( )
event type integer ue_set_calc_riga ( long al_row )
event ue_set_comp_riga ( )
event type integer ue_wiz_insert ( )
event ue_wiz_getfocus ( )
event type integer ue_set_calc_tot_riga ( long al_row,  decimal adc_quantita,  decimal adc_prezzo_netto,  boolean ab_calc_sconto )
event ue_set_contropartita ( )
int X=46
int Y=760
int Width=2697
int Height=700
int TabOrder=40
string Tag="Righe di Documento"
boolean BringToTop=true
string DataObject="d_riga_mov_magazzino_gd"
boolean VScrollBar=true
end type

event ue_setta_prezzo;call super::ue_setta_prezzo;
long 			ll_id_un_confezione, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value
decimal 		ldc_ret_value, ldc_fat_conversione, ldc_molteplicita, ldc_quantita, ldc_fattore, ldc_totale
date 			ld_comp
string 		ls_tipo_conversione, ls_sconto

ll_row= GetRow()

ll_id_un_confezione= GetItemNumber(ll_row, "riga_documento_id_unita_confezione")
ll_id_listino=GetItemNumber(ll_row, "riga_documento_id_listino")
ld_comp= idw_gen.GetItemDate(il_row, "data_registrazione")
SQLCA.sp_prezzo_riferimento (ll_id_un_confezione, ll_id_listino,ld_comp, ldc_ret_value )
If IsNull(ldc_ret_value) then ldc_ret_value=0
SetItem(ll_row, "prezzo", ldc_ret_value)

ls_sconto = uf_get_colval("sconto")
ldc_ret_value=uf_calcola_prezzo(ls_sconto, ldc_ret_value, uf_GetItemDecimal(ll_row, "quantita"))
if not IsNull(ldc_ret_value) then 
	
	SetItem(ll_row,"riga_documento_prezzo_netto",Truncate(ldc_ret_value, 0))
	ldc_quantita=uf_GetItemDecimal(ll_row, "quantita")
	if GetItemString(ll_row,"c_unita_conf_tipo_conversione") = 'D' then
		ldc_fattore=1 / uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	else
		ldc_fattore=uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
	end if
	ldc_molteplicita=uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
	if IsNull(ldc_molteplicita) then ldc_molteplicita= 0
	ldc_totale= ldc_quantita * Truncate(ldc_ret_value, 0) * ldc_fattore * ldc_molteplicita
	
	SetItem(ll_row,"qta_un_base", ldc_totale)
end if

return ll_ret_value

end event

event ue_setta_rif_des_agg;call super::ue_setta_rif_des_agg;
long 		ll_id_articolo, ll_id_intestatario, ll_id_linguaggio, ll_row, ll_ret_value
long 		ll_des_art, ll_lingua
decimal 	ldc_ret_value, ldc_fat_conversione, ldc_molteplicita
date 		ld_comp

ll_row= GetRow()
ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
ll_id_intestatario= idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
ll_lingua= idw_gen.GetItemNumber(il_row, "documento_id_lingua")
ll_id_linguaggio= idw_gen.GetItemNumber(il_row, "id_linguaggio")
if not IsNull(ll_id_articolo) then
		SELECT "des_articolo"."id_des_articolo"  
		INTO :ll_des_art  
		FROM "dba"."des_articolo"  
		WHERE ( "des_articolo"."id_sog_commerciale" = :ll_id_intestatario ) AND  
			( "des_articolo"."id_articolo" = :ll_id_articolo ) AND  
			( "des_articolo"."id_lingua" = :ll_lingua ) AND  
			( "des_articolo"."id_linguaggio" = :ll_id_linguaggio )   ;
		if IsNull(ll_des_art) then
			SetNull(ll_id_intestatario)
			SELECT "des_articolo"."id_des_articolo"  
			INTO :ll_des_art  
			FROM "dba"."des_articolo"  
			WHERE ( "des_articolo"."id_sog_commerciale" = :ll_id_intestatario ) AND  
				( "des_articolo"."id_articolo" = :ll_id_articolo ) AND  
				( "des_articolo"."id_lingua" = :ll_lingua ) AND  
				( "des_articolo"."id_linguaggio" = :ll_id_linguaggio )   ;
		end if
		if not IsNull(ll_des_art) then uf_set_colval("riga_documento_id_des_articolo", string(ll_des_art))
end if

end event

event ue_set_arti_riga;call super::ue_set_arti_riga;
long 				ll_id_articolo, ll_id_des_articolo, ll_id_lingua, ll_id_linguaggio
long				ll_id_sog_commerciale, ll_id_unita_confezione, ll_id_tab_iva, ll_row
string			ls_tipo_iva


ll_row=GetRow()
ll_id_lingua = idw_gen.GetItemNumber(il_row, "id_lingua")
ll_id_linguaggio = idw_gen.GetItemNumber(il_row, "documento_id_linguaggio")
ll_id_sog_commerciale = idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
ll_id_articolo = GetItemNumber(ll_row, "riga_documento_id_articolo")
ll_id_des_articolo = uf_calc_des_art(ll_id_articolo,ll_id_sog_commerciale,ll_id_lingua,ll_id_linguaggio)
SetItem(ll_row,"riga_documento_id_des_articolo", ll_id_des_articolo)
SELECT max("unita_confezione"."id_unita_confezione" )
	INTO :ll_id_unita_confezione  
 	FROM "dba"."articolo", "dba"."unita_confezione"  
	WHERE ( "unita_confezione"."id_articolo" = "articolo"."id_articolo" ) and  
			( ( "articolo"."id_articolo" = :ll_id_articolo ) AND  
			( "unita_confezione"."unita_documenti" = 'S' ) ) ;

if not (IsNull(ll_id_unita_confezione) OR ll_id_unita_confezione = 0) then
	uf_set_colval("riga_documento_id_unita_confezione", string(ll_id_unita_confezione))

	
	triggerevent("ue_set_ucon_riga")
end if


TriggerEvent("ue_setta_prezzo")



SELECT "tab_iva"."tipo_iva", "tab_iva"."id_tab_iva"
	INTO :ls_tipo_iva, :ll_id_tab_iva
	FROM "dba"."sog_commerciale", "dba"."tab_iva"  
	WHERE ( "tab_iva"."id_tab_iva" = "sog_commerciale"."id_tab_iva" ) and  
			( ( "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) ) ;

if ls_tipo_iva = "S" then
	
	uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
else
	
	SELECT "articolo"."id_tab_iva"  
		INTO :ll_id_tab_iva  
		FROM "dba"."articolo"
		WHERE "articolo"."id_articolo" = :ll_id_articolo ;

	if (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
		
		SELECT "cat_com_articolo"."id_tab_iva"  
			INTO :ll_id_tab_iva  
			FROM "dba"."articolo",   
			"cat_com_articolo"  
			WHERE ( "cat_com_articolo"."id_cat_com_articolo" = "articolo"."id_cat_com_articolo" ) and  
			( ( "articolo"."id_articolo" = :ll_id_articolo ) )   ;
	end if
	if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
		uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
	end if
end if
if ib_vis_esi_disponibilita then
		dw_riga_documento_dett_ord_ff.event ue_vis_esi_disponibilita()
end if
end event

event ue_set_ucon_riga;call super::ue_set_ucon_riga;


long			ll_id_unita_conf
decimal		ld_molt, ld_fatconv, ld_fatglob
string		ls_tipoconv

ll_id_unita_conf = long(uf_get_colval("riga_documento_id_unita_confezione"))

SELECT "unita_confezione"."fat_conversione",   
		"unita_confezione"."molteplicita",   
		"unita_confezione"."tipo_conversione"  
 INTO :ld_fatconv, :ld_molt, :ls_tipoconv
 FROM "dba"."unita_confezione"  
WHERE "unita_confezione"."id_unita_confezione" = :ll_id_unita_conf ;


if SQLCA.SQLCode = 0 then
	uf_set_colval("riga_documento_fat_con_unita_base",string(ld_fatconv))
	uf_set_colval("c_unita_conf_tipo_conversione", string(ls_tipoconv))
	uf_set_colval("c_unita_conf_molteplicita", string(ld_molt))
	If ls_tipoconv = "D" then
		uf_set_colval("fat_con_globale", string(ld_fatconv / ld_molt))
	else
		uf_set_colval("fat_con_globale", string(ld_fatconv * ld_molt))		
	end if

	
	
	triggerevent("ue_set_calc_riga")

end if




end event

event ue_set_calc_riga;call super::ue_set_calc_riga;

decimal		ld_QTA_UB, ld_QTA, ld_QTA_SM, ld_Prezzo_Netto, ld_Sconti, ld_Totale_Riga
decimal		ld_Cambio, ld_Sconto_Riga, ld_QTA_Evasa_UB, ld_Qta_Evasa, lcd_null
decimal		ld_Prezzo, ld_Quantita, ld_Totale_Riga_Lire, ld_Qta_Effettiva, ld_Totale_Riga_val
string		ls_Sconto, ls_tipoconv, ls_tipo_arrotondamento
decimal		ld_fatconv, ld_fatglob, ld_molt, ld_cambio_riga, ld_cambio_documento
long			ll_row, ll_id_valuta_riga, ll_valuta_documento, ll_nr_cifre_arrot


ll_row= al_row
SetNull(lcd_null)
ls_tipoconv = GetItemString(ll_row,"c_unita_conf_tipo_conversione")
ld_fatconv = uf_GetItemDecimal(ll_row,"riga_documento_fat_con_unita_base")
ld_molt =uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
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
SetItem(ll_row,"fat_con_globale",string(ld_fatglob))


ls_Sconto= GetItemString(ll_row, "sconto")
ld_QTA = uf_GetItemDecimal(ll_row, "quantita")
if IsNull(ld_QTA) then ld_QTA=0
if uf_calcola_prezzo(ls_Sconto, 1000000, 1) = 0 then
	ld_QTA_SM= 0 
	SetItem(ll_row, "qta_sconto_merce", 0)
else
	ld_QTA_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
	if IsNull(ld_QTA_SM) then ld_QTA_SM=0
end if
ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
SetItem(ll_row, "qta_un_base", ld_QTA_UB)

ld_Qta_Evasa= uf_GetItemDecimal(ll_row, "qta_evasa")
if IsNull(ld_Qta_Evasa) then ld_Qta_Evasa=0
ld_QTA_Evasa_UB = ld_Qta_Evasa * ld_FatGlob
SetItem(ll_row, "qta_evasa_un_base", ld_QTA_Evasa_UB)

ld_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
if IsNull(ld_Prezzo) then ld_prezzo = 0

ll_valuta_documento= idw_gen.GetItemNumber(il_row, "documento_id_valuta_des")
ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")

SELECT "valuta"."cifra_arrotondamento",
	"valuta"."tipo_arrotondamento"
	INTO :ll_nr_cifre_arrot ,
			:ls_tipo_arrotondamento
	FROM "dba"."valuta"  
	WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
ld_cambio_riga= GetItemNumber(ll_row, "riga_documento_cambio")
if IsNull(ld_cambio_riga) then ld_cambio_riga=1

ld_Prezzo_Netto= uf_calcola_prezzo(ls_Sconto, ld_Prezzo, 1)
ld_Prezzo_Netto=f_Round(ld_Prezzo_Netto ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0
SetItem(ll_row, "riga_documento_prezzo_netto",ld_Prezzo_Netto)

event ue_set_calc_tot_riga(ll_row, lcd_null, ld_Prezzo_Netto, FALSE)

return 0


end event

event ue_set_comp_riga;call super::ue_set_comp_riga;

string 		ls_codice, ls_descrizione
long 			ll_row, ll_id_articolo, ll_count
long			ll_id_unita_conf
decimal		ld_molt, ld_fatconv, ld_fatglob, ld_old_fatconv
string		ls_tipoconv


ll_count= RowCount()
IF ll_count > 0 THEN
	FOR ll_row = 1 to  ll_count
		ll_id_articolo = GetItemNumber(ll_row, "riga_documento_id_articolo")
		if (not IsNull(ll_id_Articolo)) and (ll_id_articolo > 0) then
			
			SELECT "articolo"."codice", "articolo"."descrizione" 
				INTO : ls_codice, :ls_descrizione
				FROM "dba"."articolo" 
				WHERE ( "articolo"."id_articolo" = :ll_id_articolo )   ;
		
			uf_SetItem(ll_row, "c_articolo_cod",ls_codice, TRUE)
			uf_SetItem(ll_row, "c_articolo_des",ls_descrizione, TRUE)
			ll_id_unita_conf = getItemNumber(ll_row,"riga_documento_id_unita_confezione")

			
			SELECT "unita_confezione"."fat_conversione",   
					"unita_confezione"."molteplicita",   
					"unita_confezione"."tipo_conversione"  
			 INTO :ld_fatconv, :ld_molt, :ls_tipoconv
			 FROM "dba"."unita_confezione"  
			WHERE "unita_confezione"."id_unita_confezione" = :ll_id_unita_conf ;
			
			if SQLCA.SQLCode = 0 then
				if IsNull(ls_tipoconv) then ls_tipoconv = "M"
				if IsNull(ld_fatconv) then ld_fatconv = 0
				if IsNull(ld_molt) then ld_molt = 0
				uf_SetItem(ll_row,"c_unita_conf_tipo_conversione", ls_tipoconv, TRUE)
				ld_old_fatconv= uf_GetItemDecimal(ll_row, "riga_documento_fat_con_unita_base")
				if IsNull(ld_old_fatconv) OR  ld_old_fatconv =0 then uf_SetItem(ll_row,"riga_documento_fat_con_unita_base", ld_fatconv, TRUE)
				uf_SetItem(ll_row,"c_unita_conf_molteplicita", ld_molt, TRUE)
			end if
		end if
	next

END IF
end event

event ue_wiz_insert;call super::ue_wiz_insert;
long ll_last_row
SetFocus()
SetRedraw(FALSE)
TriggerEvent("ue_insert")
ll_last_row= idw_riga.RowCount()
SetRow(ll_last_row)
SetColumn("c_articolo_cod")
SetRedraw(TRUE)
return 0

end event

event ue_wiz_getfocus;call super::ue_wiz_getfocus;
long ll_current_row

SetFocus()
ll_current_row= idw_riga.GetRow()
SetRow(ll_current_row)
SetColumn("c_articolo_cod")



end event

event ue_set_calc_tot_riga;call super::ue_set_calc_tot_riga;
long			ll_row, ll_nr_cifre_arrot, ll_id_valuta_riga, ll_valuta_documento
string		ls_tipo_arrotondamento
decimal		ldc_sconto_riga, ldc_totale_riga, ldc_Totale_Riga_val, ldc_Prezzo, ldc_Sconto
decimal		ldc_cambio, ldc_totale_riga_lire, adc_quantita_SM, adc_quantita_Effettiva

ll_row=al_row

if IsNull(adc_quantita) then adc_quantita= uf_GetItemDecimal(ll_row, "quantita")

if IsNull(adc_Prezzo_Netto) then	adc_Prezzo_Netto= uf_GetItemDecimal(ll_row, "riga_documento_prezzo_netto")

if not IsNull(adc_Prezzo_Netto) then 
	if IsNull(adc_quantita) then adc_quantita=0
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	ll_valuta_documento= idw_gen.GetItemNumber(il_row, "documento_id_valuta_des")
	ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")
	
	SELECT "valuta"."cifra_arrotondamento",
		"valuta"."tipo_arrotondamento"
		INTO :ll_nr_cifre_arrot ,
				:ls_tipo_arrotondamento
		FROM "dba"."valuta"  
		WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
	
	if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
	ldc_cambio= GetItemNumber(ll_row, "riga_documento_cambio")
	if IsNull(ldc_cambio) then ldc_cambio=1
	
	ldc_Sconto_Riga= uf_GetItemDecimal(ll_row, "riga_documento_sconto_riga")
	if IsNull(ldc_Sconto_Riga) then ldc_Sconto_Riga=0
	
	ldc_Totale_Riga= (adc_Prezzo_Netto * adc_quantita) - ldc_Sconto_Riga
	
	ldc_Totale_Riga= f_Round(ldc_Totale_Riga ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
	SetItem(ll_row, "tot_riga_val_riga",ldc_Totale_Riga)
	
	
	adc_quantita_Effettiva= adc_quantita + adc_quantita_SM
	if not(IsNull(adc_quantita_Effettiva) OR adc_quantita_Effettiva=0) then SetItem(ll_row, "riga_documento_val_attribuito",ldc_Totale_Riga / adc_quantita_Effettiva)
	
	if IsNull(ldc_Cambio) OR ldc_Cambio=0 then ldc_Cambio=1
	ldc_Totale_Riga_Lire= ldc_Totale_Riga * ldc_Cambio
	SetItem(ll_row, "tot_riga_val_az",ldc_Totale_Riga_Lire)
	
	if ll_id_valuta_riga = ll_valuta_documento then
		SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga)
	else
		
		if IsNull(idc_cambio) then idc_cambio=0
		ldc_Totale_Riga_val= ldc_Totale_Riga_Lire / idc_cambio
		
		if IsNull(il_arrotondamento) then il_arrotondamento=0
		ldc_Totale_Riga_val= uf_round(ldc_Totale_Riga_val)
		
		SetItem(ll_row, "tot_riga_val_doc",ldc_Totale_Riga_val)
	end if

else
	adc_Prezzo_Netto=0
	SetItem(ll_row, "tot_riga_val_riga",0)
	SetItem(ll_row, "tot_riga_val_doc",0)
	SetItem(ll_row, "tot_riga_val_az",0)
end if
If ab_calc_sconto then
	ldc_Prezzo= uf_GetItemDecimal(ll_row, "prezzo")
	If not IsNull(ldc_Prezzo) OR ldc_Prezzo =0 then 
		ldc_Sconto= (ldc_Prezzo - adc_prezzo_netto) * 100 / ldc_Prezzo
		ldc_Sconto= Round(ldc_Sconto , 2)
		SetItem(ll_row, "sconto", String(ldc_Sconto))
	end if
	
end if


return 0



end event

event ue_set_contropartita;call super::ue_set_contropartita;

long		ll_row, ll_id_articolo, ll_id_contropartita
long		ll_id_sog_commerciale, ll_id_agente


ll_id_sog_commerciale= idw_gen.GetItemNumber(il_row, "id_sog_commerciale")
ll_id_agente=  idw_gen.GetItemNumber(il_row, "id_gruppo_agenti")
ll_row= GetRow()
ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
ll_id_contropartita= wf_calcola_cpt(ll_id_sog_commerciale, ll_id_agente, ll_id_articolo)
SetItem(ll_row, "riga_documento_id_conto", ll_id_contropartita)


end event

event ue_init;call super::ue_init;
iudw_children[1] = dw_riga_documento_dett_ord_ff
				
is_list.s_identifica[1] = "id_documento"
is_list.s_win_zoom = "w_riga_documento_wz"
end event

event itemchanged;call super::itemchanged;decimal 		ldc_prezzo, ldc_parte,ldc_tot_riga, ldc_ret_value, ldc_quantita, ldc_totale, ldc_fattore
decimal 		ldc_molteplicita
string 		ls_sconto, ls_parte, ls_descrizione
long 			ll_row, ll_pos, ll_ret_value, ll_id, ll_tab_iva, ll_id_magazzino, ll_id_locazione
boolean 		lb_non_calcolabile
string 		ls_tot_riga
string		ls_tb, ls_cp, ls_vr, ls_tr
string		ls_dbc[], ls_dbv[], ls_dwc[]
integer		li_ok
decimal		ldc_null

ll_row= GetRow()
If ll_row=0 OR IsNull(ll_row) then ll_row= row
SetNull(ldc_null)
CHOOSE CASE dwo.name
	CASE "c_articolo_cod"
		
		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "id_articolo"
		ls_dbc[3] = "codice"
		ls_dbc[4] = "descrizione"
		ls_dwc[1] = "riga_documento_descrizione"
		ls_dwc[2] = "riga_documento_id_articolo"
		ls_dwc[3] = "c_articolo_cod"
		ls_dwc[4] = "c_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",4,ls_dbc,ls_dbv,ls_dwc)

		if li_ok > 0 then
			event ue_set_arti_riga()
			post event ue_set_contropartita()
			post event ue_set_calc_riga(ll_row)
			return 2 
		end if
	CASE "riga_documento_descrizione"
		
		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "id_articolo"
		ls_dbc[3] = "codice"
		ls_dbc[4] = "descrizione"
		ls_dwc[1] = "riga_documento_descrizione"
		ls_dwc[2] = "riga_documento_id_articolo"
		ls_dwc[3] = "c_articolo_cod"
		ls_dwc[4] = "c_articolo_des"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","descrizione","A",data,"",4,ls_dbc,ls_dbv,ls_dwc)

		if li_ok > 0 then
			event ue_set_arti_riga()
			post event ue_set_contropartita()
			post event ue_set_calc_riga(ll_row)
			return 2 
		end if
	CASE "quantita"
		post event ue_set_calc_tot_riga(ll_row, Dec(data), ldc_null, FALSE)
		
	CASE "prezzo"
		post event ue_set_calc_riga(ll_row)

	CASE "sconto"
		post event ue_set_calc_riga(ll_row)

END CHOOSE

RETURN ll_ret_value

end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "riga_documento_descrizione"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		is_ricpar.b_asneeded=TRUE
	CASE "c_articolo_cod"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
		is_ricpar.b_asneeded=TRUE
END CHOOSE


end event

event ue_use_search;call super::ue_use_search;long ll_id_articolo, ll_id_unita_confezione, ll_id_listino, ll_row, ll_ret_value, ll_id_tab_iva
decimal ldc_ret_value
date ld_comp

ll_row= GetRow()
CHOOSE CASE as_nomecol

	CASE "c_articolo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("riga_documento_descrizione", is_ricpar.s_ausil_value[1])
		uf_set_colval("c_articolo_des", is_ricpar.s_ausil_value[1])
		
		event ue_set_arti_riga()
		post event ue_set_contropartita()
		post event ue_set_calc_riga(ll_row)
	CASE "riga_documento_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_cod", is_ricpar.s_ausil_value[1])
		uf_set_colval("c_articolo_des", is_ricpar.s_main_value)
		event ue_set_arti_riga()
		post event ue_set_contropartita()
		post event ue_set_calc_riga(ll_row)
END CHOOSE

end event

event ue_initial;call super::ue_initial;date 				ld_data_prev_consegna
decimal 			ldc_cambio

long				ll_id_magazzino, ll_row, ll_numero, ll_id_valuta, ll_righe, ll_count, ll_nriga
long				ll_id_listino, ll_id_caus_magazzino, ll_id_locazione, ll_id_agente


ll_row = GetRow()

ld_data_prev_consegna = idw_gen.GetItemDate(il_row,"data_prev_consegna")
SetItem(ll_row, "riga_documento_data_prevista_consegna", ld_data_prev_consegna)

ll_nriga = GetItemNumber(1, "c_max_num")
if isnull(ll_nriga) then ll_nriga = 0
SetItem(ll_row, "riga_documento_num_riga", ll_nriga+1)

ll_id_valuta=idw_gen.GetItemNumber(il_row, "documento_id_valuta_des")
ldc_cambio=idw_gen.uf_GetItemDecimal(il_row, "documento_cambio")
SetItem(ll_row,"riga_documento_id_valuta",  ll_id_valuta)
SetItem(ll_row,"riga_documento_cambio",  ldc_cambio)

ll_id_listino=idw_gen.GetItemNumber(il_row, "documento_id_listino")
SetItem(ll_row, "riga_documento_id_listino",ll_id_listino)

ll_id_caus_magazzino = idw_gen.GetItemNumber(il_row, "documento_id_caus_magazzino")
SetItem(ll_row, "riga_documento_id_caus_magazzino",ll_id_caus_magazzino)


ll_id_magazzino = idw_gen.GetItemNumber(il_row, "documento_id_magazzino")
ll_id_locazione= uf_calc_locazione(ll_id_magazzino)
SetItem(ll_row, "id_locazione_1",ll_id_locazione)

ll_id_magazzino = idw_gen.GetItemNumber(il_row, "documento_id_magazzino_2")
ll_id_locazione= uf_calc_locazione(ll_id_magazzino)
SetItem(ll_row, "id_locazione_2",ll_id_locazione)


ll_id_agente = idw_gen.GetItemNumber(il_row, "id_gruppo_agenti")
SetItem(ll_row, "id_gruppo_agenti",ll_id_agente)
uf_set_mask_riga()
end event

event itemfocuschanged;call super::itemfocuschanged;is_last_field=dwo.name
end event

event ue_itemerror;call super::ue_itemerror;long ll_ret_value

SetNull(ll_ret_value)
CHOOSE CASE adwo_dwo.name
	CASE "sconto"
		MessageBox(is_title, "Ricontrollare lo sconto immesso.")
		ll_ret_value=2
END CHOOSE
return ll_ret_value
end event

event ue_modify;

s_any_array			lstr_array
string				ls_array[], ls_sconto
long					ll_nr_column= 48, ll_count, ll_row
decimal				ldc_fattore, ldc_molteplicita, ldc_totale, ldc_ret_value, ldc_quantita
string				ls_nome

ll_row = GetRow()
If AcceptText() = 1 then
	ls_array[1]= uf_Get_Colval("riga_documento_id_unita_confezione")
	ls_array[2]= uf_Get_Colval("quantita")
	ls_array[3]= uf_Get_Colval("riga_documento_data_prevista_consegna")
	ls_array[4]= uf_Get_Colval("prezzo")
	ls_array[5]= uf_Get_Colval("sconto")
	ls_array[6]= uf_Get_Colval("riga_documento_prezzo_netto")
	ls_array[7]= uf_Get_Colval("riga_documento_sconto_riga")
	ls_array[8]= uf_Get_Colval("riga_documento_id_tab_iva")
	ls_array[9]= uf_Get_Colval("riga_documento_forza_chius_evasione")
	ls_array[10]= uf_Get_Colval("riga_documento_sospesa")
	ls_array[11]= uf_Get_Colval("id_riga_doc_provenienza")
	ls_array[12]= uf_Get_Colval("riga_documento_id_articolo")
	ls_array[13]= uf_Get_Colval("qta_evasa")
	ls_array[14]= uf_Get_Colval("id_gruppo_agenti")
	ls_array[15]= uf_Get_Colval("provv_agente")
	ls_array[16]= uf_Get_Colval("qta_sconto_merce")
	ls_array[17]= uf_Get_Colval("id_locazione_1")
	ls_array[18]= uf_Get_Colval("id_locazione_2")
	ls_array[19]= uf_Get_Colval("riga_documento_id_caus_magazzino")
	ls_array[20]= is_ric_riga
	ls_array[21]= uf_Get_Colval("riga_documento_id_articolo")
	ls_array[22]= uf_Get_Colval("riga_documento_id_valuta")
	ls_array[23]= uf_Get_Colval("riga_documento_cambio")
	ls_array[24]= uf_Get_Colval("id_riga_documento")
	ls_array[25]= uf_Get_Colval("provv_subage")
	ls_array[26]= uf_Get_Colval("provv_carea")
	ls_array[27]= uf_Get_Colval("riga_documento_id_conto")
	lstr_array.s_array = ls_array
	OpenWithParm(iw_support, lstr_array,"w_riga_documento_wz")
	lstr_array= Message.PowerObjectParm
	
	ls_array= lstr_array.s_array
	uf_Set_Colval("riga_documento_id_unita_confezione",ls_array[1])
	uf_Set_Colval("quantita",ls_array[2])
	if not (IsNull(ls_array[3]) OR  ls_array[3]="") then uf_Set_Colval("riga_documento_data_prevista_consegna",ls_array[3])
	uf_Set_Colval("prezzo",ls_array[4])
	uf_Set_Colval("sconto",ls_array[5])
	
	uf_Set_Colval("riga_documento_sconto_riga",ls_array[7])
	uf_Set_Colval("riga_documento_id_tab_iva",ls_array[8])
	uf_Set_Colval("riga_documento_forza_chius_evasione",ls_array[9])
	uf_Set_Colval("riga_documento_sospesa",ls_array[10])
	uf_Set_Colval("id_riga_doc_provenienza",ls_array[11])
	uf_Set_Colval("qta_evasa",ls_array[13])
	uf_Set_Colval("id_gruppo_agenti",ls_array[14])
	uf_Set_Colval("provv_agente",ls_array[15])
	uf_Set_Colval("qta_sconto_merce", ls_array[16])
	uf_Set_Colval("id_locazione_1",ls_array[17])
	uf_Set_Colval("id_locazione_2",ls_array[18])
	uf_Set_Colval("riga_documento_id_caus_magazzino",ls_array[19])
	uf_Set_Colval("riga_documento_id_valuta", ls_array[22])
	uf_Set_Colval("riga_documento_cambio", ls_array[23])
	uf_Set_Colval("provv_subage",ls_array[25])
	uf_Set_Colval("provv_carea",ls_array[26])
	uf_Set_Colval("riga_documento_id_conto",ls_array[27])
	TriggerEvent("ue_set_ucon_riga")
	uf_set_mask_riga()
	Event ue_set_calc_riga(ll_row)
end if

end event

event rowfocuschanged;call super::rowfocuschanged;if AcceptText() > 0 then
	uf_set_mask_riga()
end if 
end event

event ue_retrieve;call super::ue_retrieve;
long ll_altezza
ll_altezza= idw_riga.height

idw_riga.Modify("c_tot_righe_lire.y = " + String(ll_altezza - 130 ))
idw_riga.Modify("c_tot_righe_lire_t.y = " + String(ll_altezza - 130))
idw_riga.Modify("c_tot_righe.y = " + String(ll_altezza - 130))
idw_riga.Modify("c_tot_righe_t.y = " + String(ll_altezza - 130))
idw_riga.Modify("linea.y1 = " + String(ll_altezza - 140))
idw_riga.Modify("linea.y2 = " + String(ll_altezza - 140))
idw_riga.Modify("datawindow.summary.height = " + String (ll_altezza - 516))

is_title = "Riga " + is_nome_tipo_documento
TriggerEvent("ue_set_comp_riga")
end event

event ue_key;call super::ue_key;
boolean 	lb_new=FALSE

CHOOSE CASE key
	CASE KeyTab!
		If keyflags =0 then
			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
			if is_last_field = "riga_documento_id_tab_iva" AND lb_new then
				idw_riga_tot.PostEvent("GetFocus")
				idw_riga_tot.SetColumn("descrizione")
				RETURN 1
			end if
		end if
END CHOOSE
end event

event ue_validate_row;call super::ue_validate_row;long 		ll_id_tab_iva, ll_prezzo
integer	li_err_count
decimal	ld_QTA, ld_QTA_SM, ld_QTA_UB, ld_Fatglob

ld_QTA = uf_GetItemDecimal(al_row, "quantita")
if IsNull(ld_QTA) then ld_QTA=0
ld_QTA_SM = uf_GetItemDecimal(al_row, "qta_sconto_merce")
if IsNull(ld_QTA_SM) then ld_QTA_SM=0
ld_Fatglob=uf_GetItemDecimal(al_row,"fat_con_globale")
if IsNull(ld_Fatglob) then ld_Fatglob=0
ld_QTA_UB= (ld_QTA + ld_QTA_SM) * ld_Fatglob
SetItem(al_row, "qta_un_base", ld_QTA_UB)

li_err_count=0
ll_id_tab_iva= GetItemNumber(al_row, "riga_documento_id_tab_iva")
ll_prezzo= GetItemNumber(al_row, "prezzo")
if not(IsNull(ll_prezzo) OR ll_prezzo =0) AND (IsNull(ll_id_tab_iva) OR ll_id_tab_iva =0) then
	as_error_text= "Esistono righe non descrittive senza IVA. "
	li_err_count=1
end if
If li_err_count > 0 then iuo_msg_log.uf_new_text(as_error_text, 3)
return li_err_count

end event

event ue_update;
integer li_RetVal

li_RetVal = super::EVENT ue_update(wparam, lparam)
if ib_vis_esi_disponibilita then
		dw_riga_documento_dett_ord_ff.event ue_vis_esi_disponibilita()
end if

RETURN li_RetVal 

end event

event constructor;call super::constructor;



end event

type dw_riga_documento_dett_ord_ff from u_dw_master_main within w_mov_magazzino_cx
event ue_vis_esi_disponibilita ( )
int X=46
int Y=1480
int Width=2697
int Height=120
int TabOrder=50
boolean BringToTop=true
string DataObject="d_riga_mov_magazzino_ff"
end type

event ue_vis_esi_disponibilita;call super::ue_vis_esi_disponibilita;
decimal 		ldc_esistenza, ldc_disponibilita
long			ll_id_articolo, ll_id_azienda,ll_id_documento, ll_id_par_disponibilita, ll_row

ll_row= GetRow()
if not(IsNull(ll_row) OR ll_row=0) then
	ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
	ll_id_documento= GetItemNumber(ll_row, "riga_documento_id_documento")
	SELECT "par_disponibilita"."id_par_disponibilita",
			 "documento"."id_azienda" 
		INTO :ll_id_par_disponibilita, :ll_id_azienda
		FROM "dba"."par_disponibilita",   
				"dba"."documento"  
		WHERE ( "documento"."id_prof_documento" = "par_disponibilita"."id_prof_documento" ) and  
				( ( "documento"."id_documento" = :ll_id_documento ) )   ;
	If not( IsNull(ll_id_articolo) OR  IsNull(ll_id_azienda) OR  IsNull(ll_id_par_disponibilita) ) then
		SQLCA.sp_esi_disp_totali( ll_id_articolo, il_id_esercizio, ll_id_azienda, ll_id_par_disponibilita, ldc_esistenza, ldc_disponibilita )
		uf_SetItem(ll_row,"c_esistenza", ldc_esistenza, TRUE)
		uf_SetItem(ll_row,"c_disponibilita", ldc_disponibilita, TRUE)
	end if
end if


end event

event ue_init;call super::ue_init;is_title= "Riga Movimento"
ib_dw_shared= TRUE
is_list.s_colonne_drop[1] = "riga_documento_id_tab_iva_cod"
is_list.s_colonne_drop[2] = "riga_documento_id_tab_iva_des"
triggerevent("ue_retrieve_dddw")

end event

event itemfocuschanged;call super::itemfocuschanged;is_last_field=dwo.name
end event

event itemchanged;call super::itemchanged;long			ll_row
decimal		lcd_null
decimal		ld_prezzo_netto, ld_qta, ld_sconto_riga, ld_totale_riga
decimal		ld_cambio, ld_totale_riga_lire, ld_QTA_SM, ld_Qta_Effettiva

ll_row= GetRow()
If IsNull(ll_row) OR ll_row=0 then ll_row=row
SetNull(lcd_null)
CHOOSE CASE dwo.name
	CASE "prezzo_netto"
		dw_riga_documento_ordine_gd.event ue_set_calc_tot_riga(ll_row ,lcd_null, Dec(data), TRUE)
END CHOOSE

return 0





end event

event ue_retrieve;call super::ue_retrieve;is_title="Riga " + is_nome_tipo_documento
end event

event ue_key;call super::ue_key;boolean 	lb_new=FALSE
boolean 	lb_last=FALSE
long 		ll_last_row

CHOOSE CASE key
	CASE KeyTab!
		If keyflags = 0 then
			lb_new= (GetItemStatus(GetRow(), 0, Primary!)= New!) OR (GetItemStatus(GetRow(), 0, Primary!) = NewModified!)
			lb_last = (GetRow() = RowCount())
			if is_last_field = "data_prevista_consegna" then
				if lb_new then
				
					if lb_last then
					
						idw_riga.PostEvent("ue_wiz_insert")
					else
	
						idw_riga.PostEvent("ue_wiz_getfocus")
					end if
				else
				
					idw_riga.PostEvent("ue_wiz_getfocus")
				end if
				RETURN -1
			end if
		end if
END CHOOSE
end event

event clicked;call super::clicked;
decimal 		ldc_esistenza, ldc_disponibilita
long			ll_id_articolo, ll_id_azienda,ll_id_documento, ll_id_par_disponibilita, ll_row
s_any_array	lstr_any_array

CHOOSE CASE dwo.name 
	CASE "img_info"
		if Describe("img_info.filename") = "s:\PB\CommonFramework\Info_In.bmp" then
			Modify("img_info.filename= 's:\PB\CommonFramework\Info_Out.bmp'") 
			ib_vis_esi_disponibilita= FALSE
		else
			Modify("img_info.filename= 's:\PB\CommonFramework\Info_In.bmp'") 
			ib_vis_esi_disponibilita= TRUE
			event ue_vis_esi_disponibilita()
		end if
	CASE "c_esistenza","c_disponibilita"
		ll_row= GetRow()
		if not(IsNull(ll_row) OR ll_row=0) then
			ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
		
			ll_id_documento= GetItemNumber(ll_row, "riga_documento_id_documento")
			SELECT "par_disponibilita"."id_par_disponibilita",
					 "documento"."id_azienda" 
				INTO :ll_id_par_disponibilita, :ll_id_azienda
				FROM "dba"."par_disponibilita",   
						"dba"."documento"  
				WHERE ( "documento"."id_prof_documento" = "par_disponibilita"."id_prof_documento" ) and  
						( ( "documento"."id_documento" = :ll_id_documento ) )   ;
			If not( IsNull(ll_id_articolo) OR  IsNull(ll_id_azienda) OR  IsNull(ll_id_par_disponibilita) ) then
				lstr_any_array.s_array[1]= ll_id_articolo
				lstr_any_array.s_array[2]=il_id_esercizio
				lstr_any_array.s_array[3]=ll_id_azienda
				lstr_any_array.s_array[4]=ll_id_par_disponibilita
				OpenWithParm(w_esi_disponibilita_wz, lstr_any_array)
			end if
		end if

END CHOOSE

end event

event rowfocuschanged;call super::rowfocuschanged;if ib_vis_esi_disponibilita then
		event ue_vis_esi_disponibilita()
end if


end event

type cbx_simbolo from checkbox within w_mov_magazzino_cx
event clicked pbm_bnclicked
int X=2240
int Y=1360
int Width=457
int Height=64
boolean BringToTop=true
string Text="Simbolo di Valuta "
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;uf_set_dec_mask( il_arrotondamento, is_simbolo_valuta)
idw_riga.SetRedraw(TRUE)
end event

