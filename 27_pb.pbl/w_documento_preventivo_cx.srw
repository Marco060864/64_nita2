forward
global type w_documento_preventivo_cx from w_p_data
end type
type dw_documento_preventivo_ff from u_dw_master_main within tabpage_1
end type
type cb_note from commandbutton within tabpage_1
end type
type dw_documento_preventivo_ff from u_dw_master_main within tabpage_1
end type
type cb_note from commandbutton within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_riga_documento_dett_prev_ff from u_dw_master_main within tabpage_2
end type
type p_arrow from picture within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type dw_riga_documento_preventivo_gd from u_dw_master_main within tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_documento_bolla_trasp_ff from u_dw_master_main within tabpage_3
end type
type tabpage_4 from userobject within tab_1
end type
type dw_castelletto_iva_gd from u_dw_ext_main within tabpage_4
end type
type dw_spesa_documento_gd from u_dw_master_main within tabpage_4
end type
type dw_documento_ord_tot_ff from u_dw_master_main within tabpage_4
end type
type st_spese_riepilogo from statictext within tabpage_4
end type
type st_st_scadenze_sconti from statictext within tabpage_4
end type
type cb_aggiorna from commandbutton within tabpage_4
end type
type st_spese_riepilogo_cont from statictext within tabpage_4
end type
type st_st_scadenze_sconti_cont from statictext within tabpage_4
end type
type cb_ricalcola_scadenze from commandbutton within tabpage_4
end type
type dw_scadenza_documento_lt from u_dw_master_main within tabpage_4
end type
type cb_ricalcola from commandbutton within tabpage_4
end type
type cbx_simbolo from checkbox within tabpage_4
end type
type dw_documento_tot_ext_ff from datawindow within tabpage_4
end type
type cb_valuta from commandbutton within tabpage_4
end type
type st_message from statictext within w_documento_preventivo_cx
end type
type cb_blocco from commandbutton within w_documento_preventivo_cx
end type
type tabpage_2 from userobject within tab_1
dw_riga_documento_dett_prev_ff dw_riga_documento_dett_prev_ff
p_arrow p_arrow
cb_1 cb_1
dw_riga_documento_preventivo_gd dw_riga_documento_preventivo_gd
end type
type tabpage_3 from userobject within tab_1
dw_documento_bolla_trasp_ff dw_documento_bolla_trasp_ff
end type
type tabpage_4 from userobject within tab_1
dw_castelletto_iva_gd dw_castelletto_iva_gd
dw_spesa_documento_gd dw_spesa_documento_gd
dw_documento_ord_tot_ff dw_documento_ord_tot_ff
st_spese_riepilogo st_spese_riepilogo
st_st_scadenze_sconti st_st_scadenze_sconti
cb_aggiorna cb_aggiorna
st_spese_riepilogo_cont st_spese_riepilogo_cont
st_st_scadenze_sconti_cont st_st_scadenze_sconti_cont
cb_ricalcola_scadenze cb_ricalcola_scadenze
dw_scadenza_documento_lt dw_scadenza_documento_lt
cb_ricalcola cb_ricalcola
cbx_simbolo cbx_simbolo
dw_documento_tot_ext_ff dw_documento_tot_ext_ff
cb_valuta cb_valuta
end type
end forward

global type w_documento_preventivo_cx from w_p_data
int Width=2921
int Height=1692
boolean TitleBar=true
string Title="Documento Semplificato"
event ue_tipo_documento ( )
event ue_ges_sp_incasso ( )
st_message st_message
cb_blocco cb_blocco
end type
global w_documento_preventivo_cx w_documento_preventivo_cx

type variables
u_dw_main	idw_gen
u_dw_main	idw_riga  
u_dw_main	idw_riga_tot
u_dw_main	idw_gen_trasp
u_dw_main	idw_scadenza
u_dw_main	idw_gen_tot
datawindow 	idw_gen_tot_ext
u_dw_main	idw_spesa
u_dw_ext_main	idw_castelletto
long 		il_arrotondamento
decimal		idc_cambio
string		is_tipo_arrotondamento
string 		is_simbolo_valuta
string		is_tipo_documento
string		is_nome_tipo_documento
string		as_last_field
string		is_int_consentiti, is_tipo_registro
string		is_stato_scad_generata
boolean		ib_genera_scadenza = FALSE
boolean		ib_crea_spesa=FALSE
long		il_id_mod_registro, il_id_registro, il_id_esercizio
long		il_id_tab_iva
long		il_id_tab_iva_art_15
string		is_esenzione
long		il_id_spesa_bollo
long		il_id_spesa_incasso
decimal		idc_spesa_inc_importo
uo_esp_pag	iuo_pag
string		 is_ric_riga
string		 is_con_data_progressiva

end variables

forward prototypes
public function decimal uf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita)
public function long uf_iva_item (long al_item)
public function long uf_individua_spese ()
public function integer uf_set_des_articolo (long al_row, long al_id_lingua, long al_id_linguaggio, long al_id_sog_comm)
public function integer uf_set_ric (string as_value, string as_field, datawindow adw_datawindow)
public function long uf_calc_des_art (long al_id_articolo, long al_id_sog_comm, long al_id_lingua, long al_id_linguaggio)
public subroutine uf_crea_spesa (long al_row, string as_codice, long al_id_spesa, long al_percentuale, long al_importo, long al_tab_iva, string as_mod_calc_iva)
public function long uf_calc_nr_rate (long al_id_sog_comm)
public function long uf_ges_eventi (string as_evento)
public function long uf_ins_riga_cast (long al_id_tab_iva, u_dw_ext_main adw_castelletto, decimal adc_imponibile, decimal adc_imposta, decimal adc_omaggi_sc_merce)
public function string uf_check_sospesi ()
public function string uf_calc_eva_doc (u_dw_main adw_righe)
public function string uf_calc_stato_doc ()
public function integer uf_blocco_documento ()
public function long uf_calc_locazione (long al_id_magazzino)
public function long uf_get_ali_max ()
public function long uf_get_imp_max ()
public function integer uf_set_dec_mask (integer ai_decimali, string as_valuta)
public function decimal uf_round (decimal adc_numero)
end prototypes

event ue_tipo_documento;call super::ue_tipo_documento;CHOOSE CASE is_tipo_documento
	CASE "O"
		st_message.text= "Ordine Bloccato"
		tab_1.tabpage_3.visible= FALSE
		tab_1.tabpage_3.enabled= FALSE
		is_nome_tipo_documento= "Ordine"
		this.Title = "Ordine Semplificato"
	CASE "F"
		st_message.text= "Fattura Bloccata"
		is_nome_tipo_documento= "Fattura"
		this.Title = "Fattura Semplificata"
		
	CASE "B"
		st_message.text= "Bolla Bloccata"
		is_nome_tipo_documento= "Bolla-DDT"
		this.Title = "Bolla Semplificata"

END CHOOSE
end event

event ue_ges_sp_incasso;call super::ue_ges_sp_incasso;long ll_id_sog_commerciale

ll_id_sog_commerciale= idw_gen.GetItemNumber(idw_gen.GetRow(), "id_sog_commerciale")
SELECT "spesa"."id_spesa" ,"spesa_sog_commerciale"."importo"  
	INTO :il_id_spesa_incasso , 
		:idc_spesa_inc_importo  
	FROM "spesa_sog_commerciale",   
		"spesa"  
	WHERE ( "spesa"."id_spesa" = "spesa_sog_commerciale"."id_spesa" ) and  
		( ( "spesa"."codice" = 'C' ) AND  
		( "spesa_sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) )   ;

end event

public function decimal uf_calcola_prezzo (string as_sconto, decimal adc_prezzo, decimal adc_quantita);


decimal  ldc_parte,ldc_tot_riga
string  ls_parte
long ll_row, ll_pos
boolean lb_non_calcolabile
string ls_tot_riga

if IsNull(adc_prezzo) then adc_prezzo = 0
if not (IsNull(as_sconto) OR as_sconto= "") then
	as_sconto= Trim(as_sconto)
	ll_pos=Pos(as_sconto,"+")
	DO WHILE ll_pos > 0
			
			ls_parte= Mid(as_sconto,1,ll_pos - 1)
			ldc_parte= Dec(ls_parte)
			if ldc_parte > 100 OR ldc_parte < 0 then 
			
				SetNull(ldc_parte)	
				RETURN ldc_parte
			else
				adc_prezzo = adc_prezzo - adc_prezzo * (ldc_parte / 100)
			end if
			
			as_sconto= Mid(as_sconto,ll_pos+1,Len(as_sconto))
			ll_pos=Pos(as_sconto,"+")
	LOOP
	ls_parte= as_sconto
	ldc_parte= Dec(ls_parte)
	if ldc_parte > 100 OR ldc_parte < 0 then 
		
			SetNull(ldc_parte)	
			RETURN ldc_parte
		else
			adc_prezzo = adc_prezzo - (adc_prezzo * (ldc_parte / 100))
	end if
end if

RETURN adc_prezzo

end function

public function long uf_iva_item (long al_item);
long ll_item_found

return ll_item_found
end function

public function long uf_individua_spese ();

long 			ll_row, ll_intestatario, ll_prof_documento, ll_count, ll_size, ll_id_spesa, ll_new_spese
long 			ll_id_tab_iva, ll_ret_value
string 		ls_codice_int, ls_codice_prof, ls_codice, ls_mod_calc_iva
decimal  	ldc_percentuale, ldc_importo

ll_row = idw_gen.GetRow()
if ((idw_gen.GetItemStatus(ll_row, 0, Primary!)= DataModified!) OR (idw_gen.GetItemStatus(ll_row, 0, Primary!)= NotModified!)) AND idw_spesa.RowCount() = 0 then
	if not (IsNull(il_id_spesa_bollo) OR il_id_spesa_bollo = 0) then
		
		
		ll_prof_documento= idw_gen.GetItemNumber(ll_row,"id_prof_documento")
		SELECT "prof_documento"."spese_gestite"  
			INTO :ls_codice_prof  
			FROM "prof_documento"  
			WHERE "prof_documento"."id_prof_documento" = :ll_prof_documento   ;
		
		ll_intestatario= idw_gen.GetItemNumber(ll_row,"id_sog_commerciale")
		DECLARE lcur_spesa CURSOR FOR  
		SELECT "spesa"."codice" ,
				"spesa"."id_spesa" ,
				"spesa"."percentuale" ,
				"spesa_sog_commerciale"."importo",
				"spesa"."id_tab_iva",
				"spesa"."mod_cal_iva"
			FROM "spesa_sog_commerciale",   
				"spesa"  
			WHERE ( "spesa"."id_spesa" = "spesa_sog_commerciale"."id_spesa" ) AND
				("spesa_sog_commerciale"."id_sog_commerciale" =  :ll_intestatario) ;
		if SQLCA.SQLCode <> -1 then
			OPEN lcur_spesa;
			
			ll_size= Len(ls_codice_prof)
			do while sqlca.sqlcode = 0
				fetch lcur_spesa into :ls_codice_int, :ll_id_spesa , :ldc_percentuale , :ldc_importo,:ll_id_tab_iva, :ls_mod_calc_iva;
				if Pos(ls_codice_prof,ls_codice_int) > 0 then 
				
					uf_crea_spesa(ll_row, ls_codice_int,ll_id_spesa , ldc_percentuale,ldc_importo, ll_id_tab_iva, ls_mod_calc_iva)
					ll_new_spese=ll_new_spese+1
				end if
			loop
			CLOSE lcur_spesa;
		else
			ll_ret_value=1
		end if
	end if
end if
return ll_ret_value
end function

public function integer uf_set_des_articolo (long al_row, long al_id_lingua, long al_id_linguaggio, long al_id_sog_comm);
long ll_row, ll_id_articolo, ll_id_des_articolo
ll_id_articolo= tab_1.tabpage_2.dw_riga_documento_preventivo_gd.GetItemNumber( al_row, "riga_documento_id_articolo")
if not (IsNull(al_id_lingua) OR IsNull(al_id_linguaggio) OR IsNull(al_id_sog_comm) OR IsNull(ll_id_articolo)) then
		SELECT Max("des_articolo"."id_des_articolo" )
		 INTO :ll_id_des_articolo  
		 FROM "des_articolo",   
				"sog_commerciale",   
				"anagrafica"  
		WHERE ( "sog_commerciale"."id_sog_commerciale" = "des_articolo"."id_sog_commerciale" ) and  
				( "anagrafica"."id_anagrafica" = "sog_commerciale"."id_anagrafica" ) and  
				( "anagrafica"."id_lingua" =:al_id_lingua ) and  
				( "anagrafica"."id_linguaggio" = :al_id_linguaggio ) and  
				( ( "des_articolo"."id_articolo" = :ll_id_articolo ) AND  
				( "sog_commerciale"."id_sog_commerciale" = :al_id_sog_comm ) )   ;
	if SQLCA.SQLCode = 100 then
		SELECT Max("des_articolo"."id_des_articolo" )
		 INTO :ll_id_des_articolo  
		 FROM "des_articolo",   
				"sog_commerciale",   
				"anagrafica"  
		WHERE ( "anagrafica"."id_anagrafica" = "sog_commerciale"."id_anagrafica" ) and  
				( "anagrafica"."id_lingua" = "des_articolo"."id_lingua" ) and  
				( "anagrafica"."id_linguaggio" = "des_articolo"."id_linguaggio" ) and  
				( ( "des_articolo"."id_articolo" = :ll_id_articolo ) AND  
				( "sog_commerciale"."id_sog_commerciale" = :al_id_sog_comm ) ) ;
	end if
	if not (IsNull(ll_id_des_articolo) OR ll_id_des_articolo = 0) then tab_1.tabpage_2.dw_riga_documento_preventivo_gd.SetItem(al_row, "riga_documento_id_des_articolo", ll_id_des_articolo)

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

if SQLCA.SQLCode =100 then
	SELECT Max("des_articolo"."id_des_articolo" )
		 INTO :ll_id_des_articolo  
		 FROM "dba"."des_articolo"  
		WHERE ( "des_articolo"."id_linguaggio" = :al_id_linguaggio ) AND  
				( "des_articolo"."id_lingua" = :al_id_lingua ) AND  
				( "des_articolo"."id_articolo" = :al_id_articolo ) AND   
				( "des_articolo"."id_azienda" = 1 );
end if

RETURN ll_id_des_articolo

end function

public subroutine uf_crea_spesa (long al_row, string as_codice, long al_id_spesa, long al_percentuale, long al_importo, long al_tab_iva, string as_mod_calc_iva);

long ll_row, ll_id_documento

ll_id_documento=idw_gen.GetItemNumber(idw_gen.GetRow(), "id_documento")

ll_row=idw_spesa.Find("id_spesa_cod = " + String(al_id_spesa) ,1,idw_spesa.RowCount())
if ll_row= 0 then 
	ll_row=idw_spesa.InsertRow(0)
	idw_spesa.SetItem(ll_row, "id_spesa_cod", al_id_spesa)
	idw_spesa.SetItem(ll_row, "id_documento", ll_id_documento)
	idw_spesa.SetItem(ll_row, "percentuale", al_percentuale)
	idw_spesa.SetItem(ll_row, "importo", al_importo / idc_cambio)
	idw_spesa.SetItem(ll_row, "cc_importo_buffer", al_importo)
	idw_spesa.SetItem(ll_row, "id_tab_iva_cod", al_tab_iva)
	idw_spesa.SetItem(ll_row, "cc_mod_calc_iva", as_mod_calc_iva)
end if


end subroutine

public function long uf_calc_nr_rate (long al_id_sog_comm);

long ll_nr_rate

if isNull(al_id_sog_comm) then
 ll_nr_rate= 1
else
	SELECT sum("app_pagamento"."num_rate")  
		INTO :ll_nr_rate  
		FROM "con_pagamento",   
			"sog_commerciale",   
			"app_pagamento"  
		WHERE ( "sog_commerciale"."id_con_pagamento" = "con_pagamento"."id_con_pagamento" ) and  
			( "app_pagamento"."id_con_pagamento" = "con_pagamento"."id_con_pagamento" ) and  
			( ( "sog_commerciale"."id_sog_commerciale" = :al_id_sog_comm ) )   ;
	If IsNull(ll_nr_rate) then ll_nr_rate= 0
end if

return ll_nr_rate
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
			st_message.visible= TRUE
		CASE ELSE 
			idw_gen.enabled= TRUE
			idw_riga.enabled= TRUE
			idw_spesa.enabled= TRUE
			idw_riga_tot.enabled= TRUE
			idw_gen_tot.enabled= TRUE
			st_message.visible= FALSE

END CHOOSE


return 0
end function

public function long uf_ins_riga_cast (long al_id_tab_iva, u_dw_ext_main adw_castelletto, decimal adc_imponibile, decimal adc_imposta, decimal adc_omaggi_sc_merce);

decimal 		ldc_aliquota, ldc_imponibile, ldc_ret_value, ldc_omaggi_sc_merce, ldc_imposta
string 		ls_codice, ls_descr_breve
long 			ll_row_found, ll_new_row


if not (IsNull(al_id_tab_iva) OR al_id_tab_iva = 0) then 
	ll_row_found=adw_castelletto.Find("id_iva =" + string(al_id_tab_iva),1,adw_castelletto.RowCount())
	if ll_row_found= 0 then
	
		ll_new_row= adw_castelletto.InsertRow(0)
	  SELECT "tab_iva"."codice",   
				"tab_iva"."des_breve" ,
				"tab_iva"."per_aliquota"
		 INTO :ls_codice,   
				:ls_descr_breve, 
				:ldc_aliquota
		 FROM "tab_iva"  
		 WHERE "tab_iva"."id_tab_iva" = :al_id_tab_iva   ;
		ldc_ret_value=ll_new_row
		adw_castelletto.SetItem(ll_new_row, "id_iva",al_id_tab_iva)
		adw_castelletto.SetItem(ll_new_row, "codice_iva", ls_codice)
		adw_castelletto.SetItem(ll_new_row, "des_breve_iva", ls_descr_breve)
		adw_castelletto.SetItem(ll_new_row, "omaggi_merce", adc_omaggi_sc_merce)
		adw_castelletto.SetItem(ll_new_row, "c_imposta", adc_imposta)
		adw_castelletto.SetItem(ll_new_row, "imponibile", adc_imponibile)
		adw_castelletto.SetItem(ll_new_row, "aliquota_iva", ldc_aliquota)
	else
	
		ldc_ret_value= ll_row_found
		ldc_imponibile= adw_castelletto.uf_GetItemDecimal(ll_row_found,"imponibile")
		if IsNull(ldc_imponibile) then ldc_imponibile= 0
		adw_castelletto.SetItem(ll_row_found, "imponibile", adc_imponibile + ldc_imponibile)
	 	ldc_imposta= adw_castelletto.uf_GetItemDecimal(ll_row_found,"c_imposta")
		if IsNull(ldc_imposta) then ldc_imposta= 0
		adw_castelletto.SetItem(ll_row_found, "c_imposta", adc_imposta + ldc_imposta)
		ldc_omaggi_sc_merce=adw_castelletto.uf_GetItemDecimal(ll_row_found,"omaggi_merce")
		if IsNull(ldc_omaggi_sc_merce) then ldc_omaggi_sc_merce= 0
		adw_castelletto.SetItem(ll_row_found, "omaggi_merce", adc_omaggi_sc_merce + ldc_omaggi_sc_merce)
	end if
end if
return ldc_ret_value


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

ls_st = tab_1.tabpage_1.dw_documento_preventivo_ff.uf_get_colval("bloccato")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = tab_1.tabpage_1.dw_documento_preventivo_ff.uf_get_colval("documento_chius_forzata")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = tab_1.tabpage_1.dw_documento_preventivo_ff.uf_get_colval("documento_contabilizzato")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = uf_calc_eva_doc(tab_1.tabpage_2.dw_riga_documento_preventivo_gd)
ls_ret = ls_ret + ls_st


ls_st = tab_1.tabpage_1.dw_documento_preventivo_ff.uf_get_colval("documento_sospeso")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = tab_1.tabpage_1.dw_documento_preventivo_ff.uf_get_colval("documento_stampato")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if

ls_st = tab_1.tabpage_1.dw_documento_preventivo_ff.uf_get_colval("creato_in_esenzione")
if ls_st = "S" then
	ls_ret = ls_ret + "S" 
else
	ls_ret = ls_ret + "N"
end if


return ls_ret
end function

public function integer uf_blocco_documento ();

string	ls_mes1, ls_mes2, ls_mes3, ls_mes4, ls_mes5
string	ls_stato_doc	
											

ls_stato_doc = uf_calc_stato_doc()

if mid(ls_stato_doc,1,1) = "S" then
	ls_mes1 = "Bloccato dall'utente. ~r"
end if

if mid(ls_stato_doc,2,1) = "S" then

	ls_mes2 = "Chiuso dall'utente. ~r"
end if

if mid(ls_stato_doc,3,1) = "S" then
	ls_mes3 = "Contabilizzato. ~r"
end if

if mid(ls_stato_doc,4,1) = "S" then
	ls_mes4 = "Evaso Totalmente. ~r"
end if

if mid(ls_stato_doc,6,1) = "T" then
	ls_mes5 = "Stampato. ~r"
end if

if (mid(ls_stato_doc,1,1) = "S" or mid(ls_stato_doc,2,1) = "S" or &
			mid(ls_stato_doc,3,1) = "S" or mid(ls_stato_doc,5,1) = "T") then
	MessageBox("Documento", "Il documento è stato bloccato in quanto: ~r" + ls_mes1 + ls_mes2 + ls_mes3 + ls_mes4 + ls_mes5,Exclamation!)
	st_message.Visible= TRUE
	tab_1.tabpage_1.dw_documento_preventivo_ff.Enabled = FALSE
	tab_1.tabpage_2.dw_riga_documento_preventivo_gd.Enabled = FALSE
	tab_1.tabpage_2.dw_riga_documento_dett_prev_ff.Enabled = FALSE
	tab_1.tabpage_3.dw_documento_bolla_trasp_ff.Enabled = FALSE
	tab_1.tabpage_4.dw_spesa_documento_gd.Enabled = FALSE
	tab_1.tabpage_4.dw_castelletto_iva_gd.Enabled = FALSE
	tab_1.tabpage_4.dw_documento_ord_tot_ff.Enabled = FALSE
else
	st_message.Visible= FALSE
	tab_1.tabpage_1.dw_documento_preventivo_ff.Enabled = TRUE
	tab_1.tabpage_2.dw_riga_documento_preventivo_gd.Enabled = TRUE
	tab_1.tabpage_2.dw_riga_documento_dett_prev_ff.Enabled = TRUE
	tab_1.tabpage_3.dw_documento_bolla_trasp_ff.Enabled = TRUE
	tab_1.tabpage_4.dw_spesa_documento_gd.Enabled = TRUE
	tab_1.tabpage_4.dw_castelletto_iva_gd.Enabled = TRUE
	tab_1.tabpage_4.dw_documento_ord_tot_ff.Enabled = TRUE

end if
return 0
end function

public function long uf_calc_locazione (long al_id_magazzino);
long ll_id_locazione

SELECT max("locazione"."id_locazione")
	INTO :ll_id_locazione  
	FROM "documento",   
		"locazione",   
		"magazzino"  
	WHERE ( "magazzino"."id_magazzino" = "locazione"."id_magazzino" ) and  
		( "magazzino"."id_magazzino" = :al_id_magazzino) and  
		( "locazione"."id_area" IS NULL ) AND  
		( "locazione"."corsia" IS NULL ) AND  
		( "locazione"."scaffale" IS NULL ) AND  
		( "locazione"."ripiano" IS NULL ) AND  
		( "locazione"."posizione" IS NULL ) ;

RETURN ll_id_locazione
end function

public function long uf_get_ali_max ();

long 		ll_nr_row, ll_count, ll_id_iva_max
decimal 	ldc_aliquota, ldc_max_aliquota

ldc_max_aliquota=0
SetNull(ll_id_iva_max)
ll_nr_row= idw_castelletto.RowCount()
for ll_count = 1 to ll_nr_row 
	ldc_aliquota= idw_castelletto.uf_GetItemDecimal(ll_count, "aliquota_iva")
	if ldc_aliquota > ldc_max_aliquota then
		ldc_max_aliquota=ldc_aliquota
		ll_id_iva_max= idw_castelletto.GetItemNumber(ll_count, "id_iva")
	end if
next
return ll_id_iva_max
end function

public function long uf_get_imp_max ();

long 		ll_nr_row, ll_count, ll_id_iva_max
decimal 	ldc_prezzo, ldc_max_prezzo

ldc_max_prezzo=0
SetNull(ll_id_iva_max)
ll_nr_row= idw_castelletto.RowCount()
for ll_count = 1 to ll_nr_row 
	ldc_prezzo= idw_castelletto.uf_GetItemDecimal(ll_count, "imponibile")
	if ldc_prezzo > ldc_max_prezzo then
		ldc_max_prezzo=ldc_prezzo
		ll_id_iva_max= idw_castelletto.GetItemNumber(ll_count, "id_iva")
	end if
next
return ll_id_iva_max
end function

public function integer uf_set_dec_mask (integer ai_decimali, string as_valuta);
string 		ls_mask, ls_mask_lire, ls_simbolo_lire
decimal 		ldc_cambio_lire
integer		ll_arrot_lire, li_decimali
integer 		li_count
boolean 		lb_simbolo

lb_simbolo= tab_1.tabpage_4.cbx_simbolo.Checked
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
	FROM "valuta"  
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

idw_spesa.Modify("importo.edit.format = '" + ls_mask + "'")
idw_spesa.Modify("importo.format = '" + ls_mask + "'")
idw_castelletto.Modify("c_imponibile_spesa.format = '" + ls_mask + "'")
idw_castelletto.Modify("c_imponibile_spesa_lire.format = '" + ls_mask_lire + "'")
idw_castelletto.Modify("c_imposta.format = '" + ls_mask + "'")
idw_castelletto.Modify("c_iva_lire.format = '" + ls_mask_lire + "'")
idw_castelletto.Modify("c_iva_val.format = '" + ls_mask + "'")

idw_scadenza.Modify("importo.format = '" + ls_mask_lire + "'")
idw_scadenza.Modify("imp_valuta.format = '" + ls_mask + "'")
idw_gen_tot.Modify("fin_incondizionato.edit.format = '" + ls_mask + "'")
idw_gen_tot.Modify("fin_incondizionato.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_merce.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("netto_merce.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_omaggi_sc_merce.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_imponibile.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_imposta.format = '" + ls_mask + "'")
idw_gen_tot_ext.Modify("tot_documento.format = '" + ls_mask + "'")

idw_gen_tot_ext.Modify("tot_imponibile_lire.format = '" + ls_mask_lire + "'")
idw_gen_tot_ext.Modify("tot_imposta_lire.format = '" + ls_mask_lire + "'")
idw_gen_tot_ext.Modify("tot_documento_lire.format = '" + ls_mask_lire + "'")
idw_gen_tot_ext.Modify("tot_merce_lire.format = '" + ls_mask_lire + "'")
idw_gen_tot_ext.Modify("netto_merce_lire.format = '" + ls_mask_lire + "'")
idw_gen_tot_ext.Modify("tot_omaggi_sc_merce_lire.format = '" + ls_mask_lire + "'")

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

on w_documento_preventivo_cx.create
int iCurrent
call super::create
this.st_message=create st_message
this.cb_blocco=create cb_blocco
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_message
this.Control[iCurrent+2]=this.cb_blocco
end on

on w_documento_preventivo_cx.destroy
call super::destroy
destroy(this.st_message)
destroy(this.cb_blocco)
end on

event open;call super::open;idw_gen = tab_1.tabpage_1.dw_documento_preventivo_ff
idw_riga=  tab_1.tabpage_2.dw_riga_documento_preventivo_gd  
idw_riga_tot= tab_1.tabpage_2.dw_riga_documento_dett_prev_ff
idw_gen_trasp=tab_1.tabpage_3.dw_documento_bolla_trasp_ff
idw_scadenza= tab_1.tabpage_4.dw_scadenza_documento_lt
idw_gen_tot= tab_1.tabpage_4.dw_documento_ord_tot_ff
idw_gen_tot_ext = tab_1.tabpage_4.dw_documento_tot_ext_ff
idw_spesa= tab_1.tabpage_4.dw_spesa_documento_gd 
idw_castelletto=tab_1.tabpage_4.dw_castelletto_iva_gd


this.enabled = FALSE
st_message.visible= FALSE
iuo_pag = create uo_esp_pag
idw_master=tab_1.tabpage_1.dw_documento_preventivo_ff
idw_master.is_list = Message.PowerObjectParm
is_tipo_documento= idw_master.is_list.s_win_parametri
tab_1.tabpage_2.dw_riga_documento_preventivo_gd.SetRowFocusIndicator(tab_1.tabpage_2.p_arrow)

TriggerEvent("ue_tipo_documento")


end event

event close;call super::close;destroy iuo_pag
end event

event ue_post_open;call super::ue_post_open;
if idw_master.is_list.s_modo <> modo_inserisci then
	idw_gen.Object.c_prof_doc_cod.Protect=1
	idw_gen.Object.c_prof_doc_des.Protect=1
	idw_gen.Object.c_sog_comm_cod.Protect=1
	idw_gen.Object.c_sog_comm_des.Protect=1
end if

SELECT "spesa"."id_spesa"  
	INTO :il_id_spesa_bollo  
	FROM "dba"."spesa"  
	WHERE "spesa"."codice" = 'B' ;


this.enabled = TRUE
idw_gen.SetFocus()

end event

type p_crescente from w_p_data`p_crescente within w_documento_preventivo_cx
boolean BringToTop=true
end type

type p_decrescente from w_p_data`p_decrescente within w_documento_preventivo_cx
boolean BringToTop=true
end type

type cb_ok from w_p_data`cb_ok within w_documento_preventivo_cx
boolean BringToTop=true
end type

type cb_annulla from w_p_data`cb_annulla within w_documento_preventivo_cx
boolean BringToTop=true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_documento_preventivo_cx
boolean BringToTop=true
end type

event cb_nuovo::clicked;

parent.TriggerEvent("ue_update")
if not(idw_master.GetItemStatus(idw_master.GetRow(), 0, Primary!)= New! or idw_master.GetItemStatus(idw_master.GetRow(), 0, Primary!)= NewModified!) then
	tab_1.tabpage_1.dw_documento_preventivo_ff.event ue_reset()
	parent.TriggerEvent("ue_insert_mode")
	idw_master.SetFocus()
end if
end event

type cb_inserisci from w_p_data`cb_inserisci within w_documento_preventivo_cx
int X=2011
boolean BringToTop=true
end type

type cb_cancella from w_p_data`cb_cancella within w_documento_preventivo_cx
int X=2309
boolean BringToTop=true
end type

type cb_salva from w_p_data`cb_salva within w_documento_preventivo_cx
int X=2606
boolean BringToTop=true
end type

event cb_salva::clicked;long ll_row, ll_intestatario, ll_prof_documento, ll_count, ll_size
string ls_codice_int, ls_codice_prof, ls_codice

ll_row= tab_1.tabpage_1.dw_documento_preventivo_ff.GetRow()
if tab_1.tabpage_1.dw_documento_preventivo_ff.GetItemStatus(ll_row, 0, Primary!)= New! or tab_1.tabpage_1.dw_documento_preventivo_ff.GetItemStatus(ll_row, 0, Primary!)= NewModified! then
	
	ib_crea_spesa= TRUE
end if
parent.TriggerEvent("ue_update")
tab_1.tabpage_4.dw_spesa_documento_gd.SetColumn("percentuale")

end event

type tab_1 from w_p_data`tab_1 within w_documento_preventivo_cx
int X=50
int Y=168
int Width=2811
int Height=1420
boolean BringToTop=true
long BackColor=79741120
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_2
this.Control[iCurrent+2]=this.tabpage_3
this.Control[iCurrent+3]=this.tabpage_4
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event tab_1::selectionchanged;call super::selectionchanged;

UserObject		luo_page
string			ls_pagename, ls_null
decimal			ldc_null

luo_page = control[newindex]
ls_pagename = luo_page.classname()

choose case ls_pagename
	case "tabpage_1"
		SetNull(ldc_null)
		SetNull(ls_null)
		tab_1.tabpage_1.dw_documento_preventivo_ff.Post Event ue_calc_totale(ls_null, ldc_null,ldc_null)
	case "tabpage_2"
		tab_1.tabpage_2.dw_riga_documento_preventivo_gd.TriggerEvent("ue_set_comp_riga")
end choose
end event

type tabpage_1 from w_p_data`tabpage_1 within tab_1
int X=18
int Y=104
int Width=2775
int Height=1300
long BackColor=79741120
string Text="Generale"
long TabBackColor=79741120
dw_documento_preventivo_ff dw_documento_preventivo_ff
cb_note cb_note
end type

on tabpage_1.create
this.dw_documento_preventivo_ff=create dw_documento_preventivo_ff
this.cb_note=create cb_note
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_documento_preventivo_ff
this.Control[iCurrent+2]=this.cb_note
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_documento_preventivo_ff)
destroy(this.cb_note)
end on

type cb_ricerca from w_p_data`cb_ricerca within w_documento_preventivo_cx
boolean BringToTop=true
end type

type dw_documento_preventivo_ff from u_dw_master_main within tabpage_1
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
int X=23
int Y=28
int Width=2706
int Height=1232
int TabOrder=1
string DataObject="d_documento_preventivo_ff"
end type

event ue_set_sog_fields;call super::ue_set_sog_fields;

long			ll_id_sog_commerciale, ll_row, ll_id_lingua, ll_id_linguaggio, ll_id_valuta, ll_id_listino
long 			ll_con_pagamento, ll_count, ll_size, ll_id_tab_iva, ll_id_riga, ll_id_articolo, ll_codice
long 			ll_id_des_articolo, ll_id_tipo_trasporto, ll_destinazione, ll_id_banca, ll_id_sog_com_vettore
long 			ll_id_profilo, ll_id_sog_com_vett_prop
string	 	ls_rag_soc, ls_tipo_iva, ls_codice, ls_info
decimal 		ldc_cambio

ll_row= GetRow()
ll_id_sog_commerciale= GetItemNumber(ll_row, "id_sog_commerciale")
if not IsNull(ll_id_sog_commerciale) then
	
	SetNull(ll_destinazione)
	SetItem(ll_row, "id_destinazione", ll_destinazione)
	SetItem(ll_row, "c_destinazione_des", "")
	
	ls_info= f_info_sc(ll_id_sog_commerciale)
	SetItem(ll_row,"cinfo", ls_info)
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
    FROM "anagrafica",   
         "sog_commerciale",   
         "valuta"  
   WHERE ( "sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and  
         ( "valuta"."id_valuta" = "anagrafica"."id_valuta" ) and  
         ( ( "sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) )   ;
 
		SetItem(ll_row,"c_sog_comm_des", ls_rag_soc)
		SetItem(ll_row,"c_sog_comm_cod", ls_codice)
		if not (IsNull(ll_id_sog_commerciale) OR ll_id_sog_commerciale = 0) then SetItem(ll_row,"documento_id_sog_commerciale_fattura", ll_id_sog_commerciale)
		if not (IsNull(ll_id_tipo_trasporto) OR ll_id_tipo_trasporto = 0) then SetItem(ll_row,"id_tipo_trasporto", ll_id_tipo_trasporto)
		
		if not (IsNull(ll_id_lingua) OR ll_id_lingua = 0) then SetItem(ll_row,"id_lingua", ll_id_lingua)
		if not (IsNull(ll_id_valuta) OR ll_id_valuta = 0) then 
			SetItem(ll_row,"documento_id_valuta_des", ll_id_valuta)
			TriggerEvent("ue_set_valu_fields")
		end if
		if not (IsNull(ll_id_linguaggio) OR ll_id_linguaggio = 0) then SetItem(ll_row,"documento_id_linguaggio", ll_id_linguaggio)

		if not (IsNull(ll_id_listino) OR ll_id_listino = 0) then SetItem(ll_row,"documento_id_listino", ll_id_listino)
		if not (IsNull(ll_con_pagamento) OR ll_con_pagamento = 0) then SetItem(ll_row,"id_con_pagamento", ll_con_pagamento)
		if not (IsNull(ll_id_banca) OR ll_id_banca = 0) then SetItem(ll_row,"id_banca_sog_commerciale", ll_id_banca)
		
		ll_id_profilo= GetItemNumber(ll_row, "id_prof_documento")
		if not IsNull(ll_id_profilo) then
			SELECT "prof_documento"."id_sog_comm_vettore_1_prop"  
				INTO :ll_id_sog_com_vett_prop  
				FROM "prof_documento"  
				WHERE "prof_documento"."id_prof_documento" = :ll_id_profilo   ;
			if IsNull(ll_id_sog_com_vett_prop) then SetItem(ll_row,"documento_id_sog_commerciale_vettore", ll_id_sog_com_vettore)
		end if

		SELECT "tab_iva"."tipo_iva"  
			INTO :ls_tipo_iva  
			FROM "tab_iva"  
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
							 FROM "articolo"  
							WHERE "articolo"."id_articolo" = :ll_id_articolo   ;
						if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then idw_riga.SetItem(ll_count, "riga_documento_id_tab_iva",ll_id_tab_iva)
				else
					if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then idw_riga.SetItem(ll_count, "riga_documento_id_tab_iva",ll_id_tab_iva)
				end if
				
				uf_set_des_articolo(ll_count, ll_id_lingua, ll_id_linguaggio, ll_id_sog_commerciale)
			next
		end if
else
	SetItem(ll_row,"cinfo", "")
end if
TriggerEvent("ue_set_calc_fields")
event ue_set_sp_incasso()
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
long ll_id_lingua_prop, ll_id_listino_prop, ll_quantita_prop_riga
string ls_ric_id_unita_confezione_riga ,ls_ric_pesi_riga ,ls_ric_data_prev_consegna_riga 
string ls_ric_locazione_2_riga ,ls_ric_locazione_1_riga ,ls_ric_id_caus_magazzino_riga ,ls_ric_unita_prezzo_riga ,ls_ric_unita_base_riga ,ls_ric_quantita_riga 
string ls_ric_id_tab_iva_riga ,ls_ric_sconto_riga_riga ,ls_ric_prezzo_netto_riga ,ls_ric_sconto_riga ,ls_ric_prezzo_riga ,ls_ric_id_listino_riga ,ls_ric_id_valuta_riga ,ls_ric_colli_riga ,ls_ric_dim_riga 
string ls_ric_contropartite_riga ,ls_ric_date_competenza_riga ,ls_ric_val_attribuito_riga ,ls_ric_provvigioni_riga ,ls_ric_id_sog_comm_agente_riga 
string ls_ric_id_caus_trasporto ,ls_ric_volumi 
string ls_ric_pesi ,ls_ric_colli_documento ,ls_ric_data_trasporto ,ls_ric_trasp_mezzo ,ls_ric_asp_beni 

ll_id_prof=GetItemNumber(GetRow(), "id_prof_documento")
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

		"prof_documento"."trasp_mezzo_prop", 
		"prof_documento"."aspetto_beni_prop",
		"prof_documento"."id_mod_registro",
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

uf_set_ric(ls_ric_id_registro, "c_registro_des", this)
uf_set_ric(ls_ric_id_registro, "c_registro", this)
uf_set_ric(ls_ric_num_progressivo,"num_progressivo", this) 
uf_set_ric(ls_ric_num_documento, "num_documento", this)
uf_set_ric(ls_ric_id_sog_comm, "c_sog_comm_cod", this)
uf_set_ric(ls_ric_id_sog_comm, "c_sog_comm_des", this)

uf_set_ric(ls_ric_id_caus_magazzino,"documento_id_caus_magazzino", this)
uf_set_ric(ls_ric_id_con_pagamento, "id_con_pagamento", this)
uf_set_ric(ls_ric_id_con_pagamento, "id_con_pagamento_des", this)
uf_set_ric(ls_ric_id_tipo_trasporto,"id_tipo_trasporto", this)
uf_set_ric(ls_ric_id_tipo_trasporto,"id_tipo_trasporto_des", this)
uf_set_ric(ls_ric_id_sog_comm_agente, "c_gruppo_agenti_cod", this)
uf_set_ric(ls_ric_id_sog_comm_agente, "c_gruppo_agenti_des", this)
uf_set_ric(ls_ric_id_valuta, "documento_id_valuta_cod", this)
uf_set_ric(ls_ric_id_valuta, "documento_id_valuta_des", this)
uf_set_ric(ls_ric_id_sog_comm_vettore_1,"c_vettore_cod", this)
uf_set_ric(ls_ric_id_sog_comm_vettore_1,"c_vettore_des", this)

uf_set_ric(ls_ric_id_tipo_trasporto,"id_tipo_trasporto", idw_gen_trasp)
uf_set_ric(ls_ric_id_tipo_trasporto,"id_tipo_trasporto_des", idw_gen_trasp)
uf_set_ric(ls_ric_colli_documento,"num_colli", idw_gen_trasp)
uf_set_ric(ls_ric_pesi,"peso_netto", idw_gen_trasp)
uf_set_ric(ls_ric_pesi,"peso_lordo", idw_gen_trasp)
uf_set_ric(ls_ric_id_caus_trasporto,"id_caus_trasporto", idw_gen_trasp)
uf_set_ric(ls_ric_id_caus_trasporto,"id_caus_trasporto_des", idw_gen_trasp)
uf_set_ric(ls_ric_asp_beni,"asp_beni", idw_gen_trasp)
uf_set_ric(ls_ric_trasp_mezzo,"tras_mezzo", idw_gen_trasp)
uf_set_ric(ls_ric_id_sog_comm_vettore_1,"c_vettore_cod", idw_gen_trasp)
uf_set_ric(ls_ric_id_sog_comm_vettore_1,"c_vettore_des", idw_gen_trasp)
uf_set_ric(ls_ric_data_trasporto,"data_trasporto", idw_gen_trasp)

uf_set_ric(ls_ric_quantita_riga,"quantita", idw_riga)
uf_set_ric(ls_ric_data_prev_consegna_riga,"riga_documento_data_prev_consegna", idw_riga)
uf_set_ric(ls_ric_prezzo_riga,"prezzo", idw_riga)
uf_set_ric(ls_ric_sconto_riga,"sconto", idw_riga)
uf_set_ric(ls_ric_prezzo_netto_riga,"prezzo_netto", idw_riga)
uf_set_ric(ls_ric_id_tab_iva_riga,"riga_documento_id_tab_iva", idw_riga)

uf_set_ric(ls_ric_data_prev_consegna_riga,"data_prevista_consegna", idw_riga_tot)
uf_set_ric(ls_ric_prezzo_netto_riga,"prezzo_netto", idw_riga_tot)

is_ric_riga= is_ric_riga + ls_ric_id_unita_confezione_riga + ls_ric_quantita_riga + ls_ric_unita_base_riga
is_ric_riga= is_ric_riga + ls_ric_unita_prezzo_riga + ls_ric_id_caus_magazzino_riga + ls_ric_locazione_1_riga
is_ric_riga= is_ric_riga + ls_ric_locazione_2_riga + ls_ric_data_prev_consegna_riga + ls_ric_pesi_riga + ls_ric_dim_riga
is_ric_riga= is_ric_riga + ls_ric_colli_riga + ls_ric_id_valuta_riga  + ls_ric_id_listino_riga + ls_ric_prezzo_riga
is_ric_riga= is_ric_riga + ls_ric_sconto_riga + ls_ric_prezzo_netto_riga + ls_ric_sconto_riga_riga + ls_ric_id_tab_iva_riga
is_ric_riga= is_ric_riga + ls_ric_id_sog_comm_agente_riga + ls_ric_provvigioni_riga 
is_ric_riga= is_ric_riga + ls_ric_val_attribuito_riga  + ls_ric_date_competenza_riga + ls_ric_contropartite_riga 

if (getItemStatus(GetRow(),0,Primary!) = New!) or (getItemStatus(GetRow(),0,Primary!) = NewModified!) then
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
	event ue_set_registro()
	event ue_set_regi_fields()
	event ue_set_sog_fields()
end if


event ue_set_calc_fields()

return 0
end event

event ue_set_calc_fields;call super::ue_set_calc_fields;long 		ll_id_sog_commerciale, ll_row, ll_id_esercizio
string 	ls_info, ls_esercizio
string 	ls_codice, ls_descrizione, ls_tipo_registro
long 		ll_destinazione, ll_registro, ll_numero, ll_prof_documento, ll_sog_comm
long		ll_sog_comm_vettore, ll_id_gruppo_agenti


ll_row= GetRow()
ll_id_sog_commerciale= GetItemNumber(ll_row, "id_sog_commerciale")
if not IsNull(ll_id_sog_commerciale) then
	
	ls_info= f_info_sc(ll_id_sog_commerciale)
	SetItem(ll_row,"cinfo", ls_info)
end if

ll_row= GetRow()
if RowCount() > 0 then
	
ll_destinazione = long(uf_get_colval("id_destinazione"))

	
	SELECT "destinazione"."rag_soc_1" 
	  	INTO :ls_descrizione
     	FROM "destinazione"
	 	WHERE ( "destinazione"."id_destinazione" = :ll_destinazione )   ;
	
	uf_set_colval("c_destinazione_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_destinazione_des", PRIMARY!, NotModified!)
ls_descrizione = ""
	
ll_registro = long(uf_get_colval("id_registro"))

	
	  SELECT "registro"."tipo_registro",   
				"registro"."numero", 
				"registro"."descrizione", 
				"esercizio"."codice"  
			 INTO :ls_tipo_registro, :ll_numero, :ls_descrizione, :ls_codice  
			 FROM "esercizio", "registro"  
			 WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
					 ( ( "registro"."id_registro" = :ll_registro ) )   ;
					 
	
	uf_set_colval("c_registro_des",ls_descrizione)
	uf_set_colval("c_registro", "Esercizio: " + ls_codice + " - " + &
							  "Tipo: " + ls_tipo_registro + " - " + &
							  "Numero: " + string(ll_numero))
	
	setitemstatus(ll_row, "c_registro_des", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_registro", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

	
	ll_prof_documento = long(uf_get_colval("id_prof_documento"))

	
	SELECT "prof_documento"."codice" , "prof_documento"."descrizione" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "prof_documento" 
	 	WHERE ( "prof_documento"."id_prof_documento" = :ll_prof_documento )   ;

	
	uf_set_colval("c_prof_doc_cod",ls_codice)
	uf_set_colval("c_prof_doc_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_prof_doc_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_prof_doc_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

ll_sog_comm = long(uf_get_colval("id_sog_commerciale"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen"
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm)   ;
	
	uf_set_colval("c_sog_comm_cod",ls_codice)
	uf_set_colval("c_sog_comm_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_sog_comm_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_sog_comm_des", PRIMARY!, NotModified!)
ls_codice = ""
ls_descrizione = ""

ll_sog_comm_vettore = long(uf_get_colval("documento_id_sog_commerciale_vettore"))

	
	SELECT "sog_commerciale_gen"."codice" , "sog_commerciale_gen"."rag_soc_1" 
	  	INTO : ls_codice, :ls_descrizione
     	FROM "sog_commerciale_gen" 
	 	WHERE ( "sog_commerciale_gen"."id_sog_commerciale" = :ll_sog_comm_vettore )   ;

	
	uf_set_colval("c_vettore_cod",ls_codice)
	uf_set_colval("c_vettore_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_vettore_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_vettore_des", PRIMARY!, NotModified!)

ls_codice = ""
ls_descrizione = ""
ll_id_gruppo_agenti = long(uf_get_colval("id_gruppo_agenti"))

	
  SELECT "gruppo_agenti"."codice",   
         "gruppo_agenti"."descrizione"  
    INTO :ls_codice,   
         :ls_descrizione  
    FROM "gruppo_agenti"  
   WHERE "gruppo_agenti"."id_gruppo_agenti" = :ll_id_gruppo_agenti   ;

	
	uf_set_colval("c_gruppo_agenti_cod",ls_codice)
	uf_set_colval("c_gruppo_agenti_des",ls_descrizione)
	
	
	setitemstatus(ll_row, "c_gruppo_agenti_cod", PRIMARY!, NotModified!)
	setitemstatus(ll_row, "c_gruppo_agenti_des", PRIMARY!, NotModified!)

end if

end event

event ue_set_not_new;call super::ue_set_not_new;if not ((getItemStatus(GetRow(),0,Primary!) = New!) or (getItemStatus(GetRow(),0,Primary!) = NewModified!)) then
	f_displayonly(this, "c_prof_doc_cod", TRUE)
	f_displayonly(this, "c_prof_doc_des", TRUE)
	f_displayonly(this, "c_registro", TRUE)
	f_displayonly(this, "c_registro_des", TRUE)
	f_displayonly(this, "num_progressivo", TRUE)
	f_displayonly(this, "documento_id_valuta_cod", TRUE)
	f_displayonly(this, "documento_id_valuta_des", TRUE)
	f_displayonly(this, "documento_cambio", TRUE)
end if
end event

event ue_set_regi_fields;call super::ue_set_regi_fields;
long ll_id_registro, ll_ultimo_num_reg, ll_row
decimal ldc_ultimo_num_reg
date ld_ultima_data_reg

ll_row = getRow()
ll_id_registro = GetItemNumber(ll_row,"id_registro")

	
	

	IF NOT (IsNull(ll_id_registro) OR ll_id_registro = 0) THEN

		SQLCA.sp_Prop_Progr_Registro(ll_id_registro, ldc_ultimo_num_reg,ld_ultima_data_reg )
		

		
		IF IsNull(ldc_ultimo_num_reg) THEN ll_Ultimo_Num_Reg = 0
		SetItem(ll_row, "num_progressivo", (ldc_ultimo_num_reg))
		IF IsNull(ld_Ultima_Data_Reg) THEN ld_Ultima_Data_Reg = Today()
		SetItem(ll_row, "data_registrazione", ld_Ultima_Data_Reg)
		SetItem(ll_row, "documento_data_competenza", ld_Ultima_Data_Reg)
	END IF
event ue_set_valu_fields("")

	
	

end event

event ue_set_valu_fields;call super::ue_set_valu_fields;
long		ll_row, ll_id_valuta
 
ll_row= GetRow()
if IsNull(as_data) OR as_data="" then 
	ll_id_valuta= GetItemNumber(ll_row, "documento_id_valuta_des")
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
		FROM "valuta"  
		WHERE "valuta"."id_valuta" = :ll_id_valuta   ;

	if sqlca.sqlcode = 0 then
		if GetItemStatus(ll_row, 0, Primary!) =New! OR GetItemStatus(ll_row, 0, Primary!) =NewModified! then
			SetItem (ll_row,"documento_cambio",idc_cambio)
		end if
		
		
		idc_cambio= uf_GetItemDecimal(ll_row, "documento_cambio")
		idw_castelletto.Modify("c_cambio_text.text = '" + String(idc_cambio) + "'")
		idw_castelletto.Modify("c_arrotondamento_text.text = '" + String(il_arrotondamento) + "'")
		idw_castelletto.Modify("c_tipo_arrotondamento.text = '" + is_tipo_arrotondamento + "'")

		uf_set_dec_mask(il_arrotondamento, is_simbolo_valuta)
	end if
end if




end event

event ue_canc_intestatario;call super::ue_canc_intestatario;long ll_row, ll_null

ll_row= GetRow()
SetNull(ll_null)
SetItem(ll_row, "id_sog_commerciale", ll_null)
SetItem(ll_row, "c_intestatario_cod", "")
SetItem(ll_row, "c_intestatario_des", "")

end event

event ue_set_sp_incasso;call super::ue_set_sp_incasso;
long ll_id_sog_commerciale

ll_id_sog_commerciale= GetItemNumber(GetRow(), "id_sog_commerciale")
SELECT "spesa"."id_spesa" ,"spesa_sog_commerciale"."importo"  
	INTO :il_id_spesa_incasso , 
		:idc_spesa_inc_importo  
	FROM "spesa_sog_commerciale",   
		"spesa"  
	WHERE ( "spesa"."id_spesa" = "spesa_sog_commerciale"."id_spesa" ) and  
		( ( "spesa"."codice" = 'C' ) AND  
		( "spesa_sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale ) )   ;

end event

event ue_set_registro;call super::ue_set_registro;
long ll_id_esercizio, ll_row

ll_row= GetRow()
SELECT Max("registro"."id_registro")
	INTO :il_id_registro  
	FROM "registro"  
	WHERE ( "registro"."id_esercizio" = :il_id_esercizio ) AND  
		( "registro"."id_mod_registro" = :il_id_mod_registro )   ;

If SQLCA.SQLCode = 0 then
	SetItem(ll_row, "id_registro", il_id_registro)

	TriggerEvent("ue_set_regi_fields")
end if

end event

event ue_set_esercizio;call super::ue_set_esercizio;

string  ls_esercizio
SELECT "esercizio"."id_esercizio", "esercizio"."codice"  
	INTO : il_id_esercizio,
			:ls_esercizio  
	FROM "azienda",   
		"esercizio"  
	WHERE ( "esercizio"."id_esercizio" = "azienda"."id_esercizio" ) and  
		( ( "azienda"."id_azienda" = 1 ) )   ;
uf_set_colval("c_esercizio",ls_esercizio)

end event

event ue_reset;call super::ue_reset;

integer 			li_size, li_counter
long 				ll_row
datawindow		ldw_item

li_size = UpperBound(iudw_children)
for li_counter = 1 to li_size
	ldw_item = iudw_children[li_counter]
	ldw_item.Reset()
next
uf_set_ric("M", "c_registro_des", this)
uf_set_ric("M", "c_registro", this)
uf_set_ric("M","num_progressivo", this) 
uf_set_ric("M", "num_documento", this)
uf_set_ric("M", "c_sog_comm_cod", this)
uf_set_ric("M", "c_sog_comm_des", this)

uf_set_ric("M","documento_id_caus_magazzino", this)
uf_set_ric("M", "id_con_pagamento", this)
uf_set_ric("M", "id_con_pagamento_des", this)
uf_set_ric("M","id_tipo_trasporto", this)
uf_set_ric("M","id_tipo_trasporto_des", this)
uf_set_ric("M", "c_gruppo_agenti_cod", this)
uf_set_ric("M", "c_gruppo_agenti_des", this)
uf_set_ric("M", "documento_id_valuta_cod", this)
uf_set_ric("M", "documento_id_valuta_des", this)
uf_set_ric("M","c_vettore_cod", this)
uf_set_ric("M","c_vettore_des", this)

uf_set_ric("M","id_tipo_trasporto", idw_gen_trasp)
uf_set_ric("M","id_tipo_trasporto_des", idw_gen_trasp)
uf_set_ric("M","num_colli", idw_gen_trasp)
uf_set_ric("M","peso_netto", idw_gen_trasp)
uf_set_ric("M","peso_lordo", idw_gen_trasp)
uf_set_ric("M","id_caus_trasporto", idw_gen_trasp)
uf_set_ric("M","id_caus_trasporto_des", idw_gen_trasp)
uf_set_ric("M","asp_beni", idw_gen_trasp)
uf_set_ric("M","tras_mezzo", idw_gen_trasp)
uf_set_ric("M","c_vettore_cod", idw_gen_trasp)
uf_set_ric("M","c_vettore_des", idw_gen_trasp)
uf_set_ric("M","data_trasporto", idw_gen_trasp)

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
f_displayonly(this, "c_registro", FALSE)
f_displayonly(this, "c_registro_des", FALSE)
f_displayonly(this, "num_progressivo", FALSE)
f_displayonly(this, "documento_id_valuta_cod", FALSE)
f_displayonly(this, "documento_id_valuta_des", FALSE)
f_displayonly(this, "documento_cambio", FALSE)
ll_row= idw_gen_tot_ext.GetRow()
idw_gen_tot_ext.SetItem(ll_row, "tot_imponibile_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "tot_imposta_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "tot_documento_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "tot_merce_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "netto_merce_lire", 0)
idw_gen_tot_ext.SetItem(ll_row, "tot_omaggi_sc_merce_lire", 0)

end event

event ue_calc_totale;call super::ue_calc_totale;

decimal ldc_tot_righe, ldc_tot_scontato
long ll_nr_row, ll_sc_cassa, ll_row, ll_sc_inc
string ls_sc_fin
u_dw_main ldw_righe

ldw_righe=tab_1.tabpage_2.dw_riga_documento_preventivo_gd
ll_row= GetRow()
ll_nr_row= ldw_righe.RowCount()
if ll_nr_row > 0 then 
	ldc_tot_righe=ldw_righe.uf_GetItemDecimal(ll_nr_row, "c_tot_righe")
else
	ldc_tot_righe=0
end if
SetItem(ll_row, "c_totale_righe", ldc_tot_righe)
if IsNull(as_sc_finanziario) then
	ls_sc_fin=GetItemString(ll_row, "documento_sconto_finanziario")
else
	ls_sc_fin= as_sc_finanziario
end if

if IsNull(adc_sc_fin_cassa) then
	ll_sc_cassa=GetItemNumber(ll_row, "documento_sconto_fin_cassa")
else
	ll_sc_cassa= adc_sc_fin_cassa
end if

if IsNull(adc_sconto_fin_inc) then
	ll_sc_inc=GetItemNumber(ll_row, "sconto_fin_incondizionato")
else
	ll_sc_inc= adc_sconto_fin_inc
end if

ldc_tot_scontato = ldc_tot_righe
ldc_tot_scontato=uf_Calcola_Prezzo(ls_sc_fin, ldc_tot_scontato, 0)
if not IsNull(ll_sc_inc) then ldc_tot_scontato = ldc_tot_scontato - ll_sc_inc
if not IsNull(ll_sc_cassa) then ldc_tot_scontato = ldc_tot_scontato - (ll_sc_cassa * ldc_tot_scontato / 100)

SetItem(ll_row, "c_totale_scontato", ldc_tot_scontato)
return 0
end event

event itemchanged;call super::itemchanged;
long 			ll_id_sog_commerciale, ll_row, ll_id_valuta, ll_id_tipo_trasporto, ll_Cur_IDRegistro, ll_ID_Prof_Doc
long			ll_gg_prev_cons,ll_numero, ll_num_succ, ll_num_prec, ll_id_con_pagamento
long 			ll_id_magazzino, ll_id_locazione, ll_nr_righe, ll_count_righe
string		ls_sc_fin, ls_tipo_registro, ls_descrizione, ls_codice, ls_info
date			ld_Ultima_Data_Reg, ld_Data, ld_data_succ, ld_data_prec
string		ls_tb, ls_cp, ls_vr, ls_tr, ls_rag_soc, ls_sql
string		ls_dbc[], ls_dbv[], ls_dwc[], ls_null
integer		li_ok
decimal 		ldc_tot_righe, ldc_sc_1, ldc_sc_2, ldc_tot_scontato, ldc_sconto_cassa, ldc_null
long			ll_sc_imp

SetNull(ls_null)
SetNull(ldc_null)
ll_row = GetRow()
CHOOSE CASE dwo.name

	
	CASE 'c_prof_doc_cod'
		ls_dbc[1] = "codice"
		ls_dbc[2] = "descrizione"
		ls_dbc[3] = "id_prof_documento"
		ls_dwc[1] = "c_prof_doc_cod"
		ls_dwc[2] = "c_prof_doc_des"
		ls_dwc[3] = "id_prof_documento"
		CHOOSE CASE is_tipo_documento
			CASE "O"
				ls_sql = "prof_documento.tipo_registro = 'OA' OR prof_documento.tipo_registro = 'OV'"
			CASE "D"
				ls_sql = "prof_documento.tipo_registro = 'DA' OR prof_documento.tipo_registro = 'DV'"
			CASE "F"
				ls_sql = "prof_documento.tipo_registro = 'IA' OR prof_documento.tipo_registro = 'IV'"
			CASE "P"
				ls_sql  = "prof_documento.tipo_registro = 'PA' OR prof_documento.tipo_registro = 'PV'"

		END CHOOSE

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
		CHOOSE CASE is_tipo_documento
			CASE "O"
				ls_sql = "prof_documento.tipo_registro = 'OA' OR prof_documento.tipo_registro = 'OV'"
			CASE "D"
				ls_sql = "prof_documento.tipo_registro = 'DA' OR prof_documento.tipo_registro = 'DV'"
			CASE "F"
				ls_sql = "prof_documento.tipo_registro = 'IA' OR prof_documento.tipo_registro = 'IV'"
			
		END CHOOSE
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
			FROM "esercizio"  
			WHERE "esercizio"."codice" = :data   ;
			if SQLCA.SQLCode = 0 then
				event ue_set_registro()
				event ue_set_calc_fields()
			end if
		else
			il_id_esercizio =0
		end if

	CASE 'c_registro_des'
		uf_SW_SetNull(data, 'id_registro')
		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "id_registro"
		ls_dwc[1] = "c_registro_des"
		ls_dwc[2] = "id_registro"
		li_ok = uf_autofind_col (string(dwo.name),"registro","descrizione","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
			event ue_set_regi_fields()
			ll_Cur_IDRegistro= GetItemNumber(ll_row, "id_registro")
			if not IsNull(ll_Cur_IDRegistro) then
					  SELECT "registro"."tipo_registro",   
								"registro"."numero", 
								 "registro"."descrizione", 
								"esercizio"."codice"  
						 INTO :ls_tipo_registro,   
								:ll_numero, 
								:ls_descrizione,  
								:ls_codice  
						 FROM "esercizio",   
								"registro"  
						WHERE ( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
								( ( "registro"."id_registro" = :ll_Cur_IDRegistro ) )   ;
						uf_set_colval("c_registro", "Esercizio: " + ls_codice + " - " + &
							  "Tipo: " + ls_tipo_registro + " - " + &
							  "Numero: " + string(ll_numero))
					SetItem(ll_row,"c_sog_comm_des", ls_rag_soc)
			end if
			return 2 
		end if

	CASE 'c_registro'
		uf_SW_SetNull(data, 'id_registro')
		event ue_set_regi_fields()

	CASE 'data_registrazione'
		
		
		SetItem(ll_row, "documento_data_competenza", date(data))
		ll_Cur_IDRegistro = GetItemNumber(ll_row, "id_registro")
		ll_ID_Prof_Doc = GetItemNumber(ll_row, "id_prof_documento")
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) AND NOT (IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc = 0) THEN
			ld_Ultima_Data_Reg=Date(data)
			SELECT "prof_documento"."gg_consegna"  
				INTO :ll_gg_prev_cons  
				FROM "prof_documento"  
				WHERE "prof_documento"."id_prof_documento" = :ll_ID_Prof_Doc   ;
			SetItem(ll_row, "data_prev_consegna", RelativeDate(ld_Ultima_Data_Reg, ll_gg_prev_cons))
		END IF	

	
		ll_numero = GetItemNumber(ll_row, "num_progressivo")
		ll_Cur_IDRegistro= GetItemNumber(ll_row, "id_registro")
		if not(IsNull(ll_numero) OR ll_numero < 0 OR IsNull(ll_Cur_IDRegistro)) then
			if is_con_data_progressiva = 'S' then
				  SELECT Max("documento"."num_progressivo")
					 INTO :ll_num_prec
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_Cur_IDRegistro ) AND  
							( "documento"."num_progressivo" < :ll_numero )   ;
	  			  SELECT Max("documento"."data_registrazione" )
					 INTO :ld_data_prec  
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_Cur_IDRegistro ) AND  
							( "documento"."num_progressivo" = :ll_num_prec )   ;
				If DaysAfter(Date(data), ld_data_prec) <= 0 then
  				  SELECT Min("documento"."num_progressivo")
					 INTO :ll_num_succ
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_Cur_IDRegistro ) AND  
							( "documento"."num_progressivo" > :ll_numero )   ;
	  			  SELECT Min("documento"."data_registrazione" )
					 INTO :ld_data_succ  
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_Cur_IDRegistro ) AND  
							( "documento"."num_progressivo" = :ll_num_succ )   ;
					If DaysAfter(Date(data), ld_data_succ) < 0 then RETURN 1
				else
					RETURN 1
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
			return 2 
		end if

	CASE 'c_destinazione_des'
		
		ls_dbc[1] = "rag_soc_1"
		ls_dwc[1] = "c_destinazione_des"
		ls_dbc[2] = "id_destinazione"
		ls_dwc[2] = "id_destinazione"
		li_ok = uf_autofind_col (string(dwo.name),"destinazione",&
										"rag_soc_1","A",data,"",2,ls_dbc,ls_dbv,ls_dwc)
		if li_ok > 0 then
				return 2 
		end if
	CASE "id_con_pagamento", "id_con_pagamento_des"
		ll_id_con_pagamento= Long(data)
		SELECT "con_pagamento"."sconto_cassa"  
			INTO :ldc_sconto_cassa  
			FROM "con_pagamento"  
			WHERE "con_pagamento"."id_con_pagamento" = :ll_id_con_pagamento  ;
		SetItem(ll_row, "documento_sconto_fin_cassa", ldc_sconto_cassa)

	case "documento_id_valuta_cod","documento_id_valuta_des"
		event ue_set_valu_fields(data)


	CASE "data_documento"
		
		ld_Data= GetItemDate(ll_row, "data_registrazione")
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
			return 2 
		end if
	
	

	CASE "documento_id_valuta_cod", "documento_id_valuta_des"
		event ue_set_valu_fields(data)

	CASE "documento_sconto_finanziario"
		Event ue_calc_totale(string(data), ldc_null, ldc_null)

	CASE "documento_sconto_fin_cassa"
		Event ue_calc_totale(ls_null,Dec(data), ldc_null)

	CASE "sconto_fin_incondizionato"
		Event ue_calc_totale(ls_null, ldc_null,Dec(data))
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
	CASE "c_esercizio"
		is_search_window = "w_esercizio_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice"

	CASE "c_prof_doc_cod"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_codice" 
		
		CHOOSE CASE is_tipo_documento
			CASE "O"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'OA' OR prof_documento.tipo_registro = 'OV'"
			CASE "D"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'DA' OR prof_documento.tipo_registro = 'DV'"
			CASE "F"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'IA' OR prof_documento.tipo_registro = 'IV'"
			CASE "P"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'PA' OR prof_documento.tipo_registro = 'PV'"
			
		END CHOOSE
	CASE "c_prof_doc_des"
		is_search_window = "w_prof_documento_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "prof_documento_descrizione" 
		
		CHOOSE CASE is_tipo_documento
			CASE "O"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'OA' OR prof_documento.tipo_registro = 'OV'"
			CASE "D"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'DA' OR prof_documento.tipo_registro = 'DV'"
			CASE "F"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'IA' OR prof_documento.tipo_registro = 'IV'"
			CASE "P"
				is_ricpar.s_sql_cond  = "prof_documento.tipo_registro = 'PA' OR prof_documento.tipo_registro = 'PV'"
			
		END CHOOSE

	CASE "c_registro"
		is_search_window = "w_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "registro_descrizione" 
		is_ricpar.s_sql_cond = "registro.tipo_registro = '"+ is_tipo_registro + "'"
		
		If not( IsNull(il_id_mod_registro) OR IsNull(il_id_esercizio) ) then
			is_ricpar.s_sql_cond  = "registro.id_esercizio = " + String(il_id_esercizio) + " AND  registro.id_mod_registro = " + String(ll_id_mod_registro)
		end if
	CASE "c_registro_des"
		is_search_window = "w_registro_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "registro_descrizione" 
		is_ricpar.s_sql_cond = "registro.tipo_registro = '"+ is_tipo_registro + "'"
		
		
	CASE "c_sog_comm_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
		if not (IsNull(ls_intestatari) OR ls_intestatari="") then is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo IN " + ls_intestatari

	CASE "c_sog_comm_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		if not (IsNull(ls_intestatari) OR ls_intestatari="") then is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo IN " + ls_intestatari

	CASE "c_destinazione_des"
		ll_id_sog_comm = GetItemNumber(ll_row,"id_sog_commerciale")
		is_search_window = "w_destinazione_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		if not (IsNull(ll_id_sog_comm) OR ll_id_sog_comm= 0) then is_ricpar.s_sql_cond = "destinazione.id_sog_commerciale = " + string(ll_id_sog_comm)
	
	CASE "c_vettore_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"

	CASE "c_vettore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"

	CASE "c_gruppo_agenti_cod"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		

	CASE "c_gruppo_agenti_des"
		is_search_window = "w_gruppo_agenti_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "descrizione" 
		
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
	CASE "c_esercizio"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		il_id_esercizio=Long(is_ricpar.s_id_seg_value[1])
		event ue_set_registro()
		event ue_set_calc_fields()

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

	CASE "c_registro"
		uf_set_colval("c_registro_des", is_ricpar.s_main_value)
		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])
		
		uf_set_colval("c_registro", "Esercizio: " + string(is_ricpar.s_ausil_value[1]) + " - " + &
					  "Tipo: " + string(is_ricpar.s_ausil_value[2]) + " - " + &
					  "Numero: " + string(is_ricpar.s_ausil_value[3]))
		event ue_set_regi_fields()

	CASE "c_registro_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_registro", is_ricpar.s_id_seg_value[1])
		

		uf_set_colval("c_registro", "Esercizio: " + string(is_ricpar.s_ausil_value[1]) + " - " + &
					  "Tipo: " + string(is_ricpar.s_ausil_value[2]) + " - " + &
					  "Numero: " + string(is_ricpar.s_ausil_value[3]))
		event ue_set_regi_fields()

	CASE "c_sog_comm_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_sog_comm_des", is_ricpar.s_ausil_value[1])
		triggerEvent("ue_set_sog_fields")

	CASE "c_sog_comm_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		triggerEvent("ue_set_sog_fields")

	CASE "c_destinazione_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_destinazione", is_ricpar.s_id_seg_value[1])


	CASE "c_vettore_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_vettore_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_cod", is_ricpar.s_ausil_value[1])

	CASE "c_gruppo_agenti_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_gruppo_agenti_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_gruppo_agenti_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_gruppo_agenti", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_gruppo_agenti_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event ue_init;call super::ue_init;iudw_children[1] = tab_1.tabpage_2.dw_riga_documento_preventivo_gd
iudw_children[2] = tab_1.tabpage_3.dw_documento_bolla_trasp_ff
iudw_children[3] = tab_1.tabpage_4.dw_documento_ord_tot_ff
iudw_children[4] = tab_1.tabpage_4.dw_spesa_documento_gd
iudw_children[5] = tab_1.tabpage_4.dw_scadenza_documento_lt


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
				FROM "documento"   
				WHERE "documento"."id_registro" = :ll_Cur_IDRegistro;
	
			
			IF IsNull(ll_Ultimo_Num_Reg) THEN ll_Ultimo_Num_Reg = 0
			SetItem(al_row, "num_progressivo", (ll_Ultimo_Num_Reg+1))
		END IF

	CASE "data_registrazione"
		
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) THEN
			SELECT MAX("documento"."data_documento")
				INTO :ld_Ultima_Data_Reg
				FROM "documento"   
				WHERE "documento"."id_registro" = :ll_Cur_IDRegistro;
			
			
			IF IsNull(ld_Ultima_Data_Reg) THEN ld_Ultima_Data_Reg = Today()
			SetItem(al_row, "data_registrazione", ld_Ultima_Data_Reg)
			SetItem(al_row, "documento_data_competenza", ld_Ultima_Data_Reg)
		END IF

	CASE "documento_id_valuta_cod"
		
		
		select "par_sistema"."id_valuta"
			into :ll_id_valuta

			from "par_sistema"
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
		

	CASE "id_tipo_trasporto"
		
	  SELECT "sog_commerciale"."id_con_pagamento"  
		 	INTO :ll_id_tipo_trasporto
		 	FROM "sog_commerciale"  
			WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_intestatario   ;
		IF NOT (IsNull(ll_id_tipo_trasporto) OR ll_id_tipo_trasporto = 0) THEN SetItem(al_row, "id_tipo_trasporto", ll_id_tipo_trasporto)

	CASE "data_prev_consegna"
		IF NOT (IsNull(ll_Cur_IDRegistro) OR ll_Cur_IDRegistro = 0) AND NOT (IsNull(ll_ID_Prof_Doc) OR ll_ID_Prof_Doc = 0) THEN

			ld_Ultima_Data_Reg=GetItemDate(al_row, "data_registrazione")
			SELECT "prof_documento"."gg_consegna"  
				INTO :ll_gg_prev_cons  
				FROM "prof_documento"  
				WHERE "prof_documento"."id_prof_documento" = :ll_ID_Prof_Doc ;
				
			SetItem(al_row, "data_prev_consegna", RelativeDate(ld_Ultima_Data_Reg, ll_gg_prev_cons))
		END IF	
		
		
END CHOOSE

end event

event ue_update;call super::ue_update;
event ue_set_not_new()

end event

event ue_retrieve;call super::ue_retrieve;long 			ll_row, ll_id_valuta, ll_arrotondamento
decimal 		ldc_cambio

is_title = is_nome_tipo_documento
event ue_set_esercizio()
event ue_set_prof_fields()
event ue_set_valu_fields("")
event ue_set_sp_incasso()
event ue_set_not_new()
uf_blocco_documento()


end event

event rowfocuschanged;call super::rowfocuschanged;

if GetItemStatus(GetRow(), 0,Primary!) = NewModified! OR GetItemStatus(GetRow(), 0,Primary!) = New! then
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

end event

event ue_itemerror;call super::ue_itemerror;long ll_id_registro, ll_numero, ll_num_prec, ll_num_succ, ll_ret_value, ll_days
date ld_Data, ld_data_prec, ld_data_succ

SetNull(ll_ret_value)
CHOOSE CASE adwo_dwo.name

	CASE "data_documento"
		
		ld_Data= GetItemDate(al_row, "data_registrazione")
		ll_days= DaysAfter(Date(as_data), ld_Data)
		If not isNull(ll_days) then
			If ll_days < 0 then
				MessageBox("Documento", "Immettere una data di Documento e ~r precedente alla data di Registrazione.", Exclamation!)
				ll_ret_value = 1
			end if
		end if

	CASE "data_registrazione"
		ll_numero = GetItemNumber(al_row, "num_progressivo")
		ll_id_registro= GetItemNumber(al_row, "id_registro")
		if not(IsNull(ll_numero) OR ll_numero < 0 OR IsNull(ll_id_registro)) then
			if is_con_data_progressiva = 'S' then
				  SELECT Max("documento"."num_progressivo")
					 INTO :ll_num_prec
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" < :ll_numero )   ;
	  			  SELECT Max("documento"."data_registrazione" )
					 INTO :ld_data_prec  
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" = :ll_num_prec )   ;
				If DaysAfter(Date(as_data), ld_data_prec) <= 0 then
  				  SELECT Min("documento"."num_progressivo")
					 INTO :ll_num_succ
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" > :ll_numero )   ;
	  			  SELECT Min("documento"."data_registrazione" )
					 INTO :ld_data_succ  
					 FROM "documento"  
					WHERE ( "documento"."id_registro" = :ll_id_registro ) AND  
							( "documento"."num_progressivo" = :ll_num_succ )   ;
					If DaysAfter(Date(as_data), ld_data_succ) < 0 then ll_ret_value= 1
				else
					ll_ret_value= 1
				end if
			end if
		end if
		if ll_ret_value= 1 then MessageBox(is_title, "Immettere una data compresa tra le date ~r del Documento Puccessivo e del Documento Precedente.", Exclamation!)
		
END CHOOSE
RETURN ll_ret_value



end event

event ue_validate_row;call super::ue_validate_row;
long ll_id_prof, ll_row, ll_err_count
string ls_ric_id_registro, ls_ric_num_progressivo, ls_ric_num_documento, ls_ric_id_caus_magazzino
string ls_ric_id_sog_comm, ls_ric_id_con_pagamento, ls_ric_id_sog_comm_agente, ls_ric_id_tipo_trasporto
string ls_ric_id_valuta, ls_ric_id_sog_comm_vettore_1, ls_note_intestazione_prop
string ls_aspetto_beni_prop, ls_trasp_mezzo_prop
string ls_ric_id_caus_trasporto ,ls_ric_volumi 
string ls_ric_pesi ,ls_ric_colli_documento ,ls_ric_data_trasporto ,ls_ric_trasp_mezzo ,ls_ric_asp_beni 

ll_row= GetRow()
ll_id_prof=GetItemNumber(GetRow(), "id_prof_documento")
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
FROM "prof_documento"  
WHERE "prof_documento"."id_prof_documento" = :ll_id_prof   ;
ll_err_count=0
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
if is_tipo_documento <> "O" then
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

return ll_err_count
end event

event ue_insert;call super::ue_insert;

event ue_set_esercizio()
end event

event losefocus;call super::losefocus;AcceptText()
end event

type cb_note from commandbutton within tabpage_1
int X=2267
int Y=664
int Width=192
int Height=84
int TabOrder=11
boolean BringToTop=true
string Text="Note"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_note
long ll_id_prof_doc

ls_note= idw_gen.uf_get_colval("documento_note_intestazione")
if IsNull(ls_note) OR ls_note="" then 
	ll_id_prof_doc = idw_gen.GetItemNumber(idw_gen.GetRow(), "id_prof_documento")
	SELECT "prof_documento"."note_intestazione_prop"  
    INTO :ls_note  
    FROM "prof_documento"  
   WHERE "prof_documento"."id_prof_documento" = :ll_id_prof_doc   ;
end if
OpenWithParm(w_doc_note, ls_note)
ls_note=Message.StringParm
idw_gen.uf_set_colval("documento_note_intestazione", ls_note)
idw_gen.SetFocus()
end event

type tabpage_2 from userobject within tab_1
int X=18
int Y=104
int Width=2775
int Height=1300
long BackColor=79741120
string Text="Righe"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_riga_documento_dett_prev_ff dw_riga_documento_dett_prev_ff
p_arrow p_arrow
cb_1 cb_1
dw_riga_documento_preventivo_gd dw_riga_documento_preventivo_gd
end type

on tabpage_2.create
this.dw_riga_documento_dett_prev_ff=create dw_riga_documento_dett_prev_ff
this.p_arrow=create p_arrow
this.cb_1=create cb_1
this.dw_riga_documento_preventivo_gd=create dw_riga_documento_preventivo_gd
this.Control[]={this.dw_riga_documento_dett_prev_ff,&
this.p_arrow,&
this.cb_1,&
this.dw_riga_documento_preventivo_gd}
end on

on tabpage_2.destroy
destroy(this.dw_riga_documento_dett_prev_ff)
destroy(this.p_arrow)
destroy(this.cb_1)
destroy(this.dw_riga_documento_preventivo_gd)
end on

type dw_riga_documento_dett_prev_ff from u_dw_master_main within tabpage_2
int X=27
int Y=916
int Width=2706
int Height=352
int TabOrder=3
string DataObject="d_riga_documento_dett_prev_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE
end event

event itemfocuschanged;call super::itemfocuschanged;
end event

event itemchanged;call super::itemchanged;long			ll_row
decimal		ld_prezzo_netto, ld_qta, ld_sconto_riga, ld_totale_riga
decimal		ld_cambio, ld_totale_riga_lire, ld_QTA_SM, ld_Qta_Effettiva

ll_row= GetRow()

CHOOSE CASE dwo.name
	CASE "prezzo_netto"
		
		ld_Prezzo_Netto=Dec(data)
		if not IsNull(ld_Prezzo_Netto) then 
			ld_QTA = uf_GetItemDecimal(ll_row, "riga_documento_quantita")
			if IsNull(ld_QTA) then ld_QTA=0
			ld_Sconto_Riga= uf_GetItemDecimal(ll_row, "riga_documento_sconto_riga")
			if IsNull(ld_Sconto_Riga) then ld_Sconto_Riga=0
			ld_totale_riga= ld_qta * Truncate(ld_prezzo_netto, 0) - ld_Sconto_Riga
			SetItem(ll_row, "tot_riga_val_riga",ld_Totale_Riga)
			SetItem(ll_row, "tot_riga_val_doc",ld_Totale_Riga)
			
			ld_QTA_SM = uf_GetItemDecimal(ll_row, "qta_sconto_merce")
			if IsNull(ld_QTA_SM) then ld_QTA_SM=0			
			ld_Qta_Effettiva= ld_QTA + ld_QTA_SM
			if not(IsNull(ld_Qta_Effettiva) OR ld_Qta_Effettiva=0) then SetItem(ll_row, "riga_documento_val_attribuito",ld_Totale_Riga / ld_Qta_Effettiva)
			ld_Cambio= uf_GetItemDecimal(ll_row, "riga_documento_cambio")
			if IsNull(ld_Cambio) then ld_Cambio=0
			ld_Totale_Riga_Lire= ld_Totale_Riga * ld_Cambio
			SetItem(ll_row, "tot_riga_val_az",ld_Totale_Riga_Lire)
		else
			ld_Prezzo_Netto=0
			SetItem(ll_row, "tot_riga_val_riga",0)
			SetItem(ll_row, "tot_riga_val_doc",0)
			SetItem(ll_row, "tot_riga_val_az",0)
		end if

END CHOOSE

return 0





end event

event ue_retrieve;call super::ue_retrieve;is_title="Riga " + is_nome_tipo_documento
end event

event ue_itemerror;call super::ue_itemerror;
CHOOSE CASE adwo_dwo.name
	CASE "data_prevista_consegna"
	
		RETURN 3

END CHOOSE
end event

type p_arrow from picture within tabpage_2
int X=27
int Y=168
int Width=46
int Height=64
boolean Visible=false
boolean BringToTop=true
string PictureName="s:\pb\cometa\arrow.bmp"
boolean FocusRectangle=false
end type

type cb_1 from commandbutton within tabpage_2
int X=2405
int Y=736
int Width=283
int Height=84
int TabOrder=31
boolean BringToTop=true
string Text="Ricalcola"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_row

ll_row= idw_riga.GetRow()
If ll_row > 0 then tab_1.tabpage_2.dw_riga_documento_preventivo_gd.event ue_set_calc_riga (ll_row)
end event

type dw_riga_documento_preventivo_gd from u_dw_master_main within tabpage_2
event type integer ue_setta_prezzo ( )
event type string ue_get_nrcolval ( integer al_column )
event type long ue_setta_un_conf ( )
event ue_setta_rif_des_agg ( )
event ue_set_arti_riga ( )
event ue_set_ucon_riga ( )
event type integer ue_set_calc_riga ( long al_row )
event ue_set_comp_riga ( )
int X=27
int Y=36
int Width=2706
int Height=832
int TabOrder=3
string Tag="Righe di Documento"
string DataObject="d_riga_documento_preventivo_gd"
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
ld_comp= idw_gen.GetItemDate(idw_gen.GetRow(), "data_registrazione")
SQLCA.sp_prezzo_riferimento (ll_id_un_confezione, ll_id_listino,ld_comp, ldc_ret_value )
SetItem(ll_row, "prezzo", ldc_ret_value)

ls_sconto = uf_get_colval("sconto")
ldc_ret_value=uf_calcola_prezzo(ls_sconto, ldc_ret_value, uf_GetItemDecimal(ll_row, "quantita"))
if not IsNull(ldc_ret_value) then 
	SetItem(ll_row,"riga_documento_prezzo_netto",Truncate(ldc_ret_value, 0))
	ldc_quantita=uf_GetItemDecimal(ll_row, "quantita")
	if GetItemString(ll_row,"c_unita_conf_tipo_conversione") = 'D' then
		ldc_fattore=1 / uf_GetItemDecimal(ll_row,"c_unita_conf_fat_conversione")
	else
		ldc_fattore=uf_GetItemDecimal(ll_row,"c_unita_conf_fat_conversione")
	end if
	ldc_molteplicita=uf_GetItemDecimal(ll_row,"c_unita_conf_molteplicita")
	if IsNull(ldc_molteplicita) then ldc_molteplicita= 0
	ldc_totale= ldc_quantita * Truncate(ldc_ret_value, 0) * ldc_fattore * ldc_molteplicita
	SetItem(ll_row,"qta_un_base", ldc_totale)
end if

return ll_ret_value

end event

event ue_setta_rif_des_agg;call super::ue_setta_rif_des_agg;long ll_id_articolo, ll_id_intestatario, ll_id_linguaggio, ll_row, ll_ret_value, ll_des_art
decimal ldc_ret_value, ldc_fat_conversione, ldc_molteplicita
date ld_comp
string ls_lingua

ll_row= GetRow()
ll_id_articolo= GetItemNumber(ll_row, "riga_documento_id_articolo")
ll_id_intestatario= idw_gen.GetItemNumber(idw_gen.GetRow(), "id_sog_commerciale")
ls_lingua= idw_gen.GetItemString(idw_gen.GetRow(), "documento_lingua")
ll_id_linguaggio= idw_gen.GetItemNumber(idw_gen.GetRow(), "id_linguaggio")
if not IsNull(ll_id_articolo) then
	  SELECT "des_articolo"."id_des_articolo"  
		 INTO :ll_des_art  
		 FROM "des_articolo"  
		WHERE ( "des_articolo"."id_sog_commerciale" = :ll_id_intestatario ) AND  
				( "des_articolo"."id_articolo" = :ll_id_articolo ) AND  
				( "des_articolo"."lingua" = :ls_lingua ) AND  
				( "des_articolo"."id_linguaggio" = :ll_id_linguaggio )   ;
		if IsNull(ll_des_art) then
			SetNull(ll_id_intestatario)
		  SELECT "des_articolo"."id_des_articolo"  
			 INTO :ll_des_art  
			 FROM "des_articolo"  
			WHERE ( "des_articolo"."id_sog_commerciale" = :ll_id_intestatario ) AND  
					( "des_articolo"."id_articolo" = :ll_id_articolo ) AND  
					( "des_articolo"."lingua" = :ls_lingua ) AND  
					( "des_articolo"."id_linguaggio" = :ll_id_linguaggio )   ;
		end if
		if not IsNull(ll_des_art) then uf_set_colval("riga_documento_id_des_articolo", string(ll_des_art))
end if

end event

event ue_set_arti_riga;call super::ue_set_arti_riga;


long 				ll_id_articolo, ll_id_des_articolo, ll_id_lingua, ll_id_linguaggio
long				ll_id_sog_commerciale, ll_id_unita_confezione, ll_id_tab_iva
string			ls_tipo_iva



ll_id_lingua = idw_gen.GetItemNumber(idw_gen.GetRow(), "id_lingua")
ll_id_linguaggio = idw_gen.GetItemNumber(idw_gen.GetRow(), "documento_id_linguaggio")
ll_id_sog_commerciale = idw_gen.GetItemNumber(idw_gen.GetRow(), "id_sog_commerciale")
ll_id_articolo = GetItemNumber(GetRow(), "riga_documento_id_articolo")
ll_id_des_articolo = uf_calc_des_art(ll_id_articolo,ll_id_sog_commerciale,ll_id_lingua,ll_id_linguaggio)

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

	if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then
		uf_set_colval("riga_documento_id_tab_iva", string(ll_id_tab_iva))
	end if
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
	uf_set_colval("c_unita_conf_fat_conversione", string(ld_fatconv))
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
decimal		ld_Cambio, ld_Sconto_Riga, ld_QTA_Evasa_UB, ld_Qta_Evasa
decimal		ld_Prezzo, ld_Quantita, ld_Totale_Riga_Lire, ld_Qta_Effettiva, ld_Totale_Riga_val
string		ls_Sconto, ls_tipoconv, ls_tipo_arrotondamento
decimal		ld_fatconv, ld_fatglob, ld_molt, ld_cambio_riga, ld_cambio_documento
long			ll_row, ll_id_valuta_riga, ll_valuta_documento, ll_nr_cifre_arrot


ll_row= al_row

ls_tipoconv = uf_get_colval("c_unita_conf_tipo_conversione")
ld_fatconv = Dec(uf_get_colval("c_unita_conf_fat_conversione"))
ld_molt = Dec(uf_get_colval("c_unita_conf_molteplicita"))
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
uf_set_colval("fat_con_globale",string(ld_fatglob))


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

ld_Prezzo_Netto= uf_calcola_prezzo(ls_Sconto, ld_Prezzo, 1)
ld_Prezzo_Netto=Truncate(ld_Prezzo_Netto, 0)
if IsNull(ld_Prezzo_Netto) then ld_Prezzo_Netto=0
SetItem(ll_row, "riga_documento_prezzo_netto",ld_Prezzo_Netto)

ld_Sconto_Riga= uf_GetItemDecimal(ll_row, "riga_documento_sconto_riga")
if IsNull(ld_Sconto_Riga) then ld_Sconto_Riga=0

ld_Totale_Riga= (ld_Prezzo_Netto * ld_QTA) - ld_Sconto_Riga

ll_id_valuta_riga= GetItemNumber(ll_row, "riga_documento_id_valuta")
ll_valuta_documento= idw_gen.GetItemNumber(idw_gen.GetRow(), "documento_id_valuta_des")
SELECT "valuta"."cifra_arrotondamento",
	"valuta"."tipo_arrotondamento"
	INTO :ll_nr_cifre_arrot ,
			:ls_tipo_arrotondamento
	FROM "valuta"  
	WHERE "valuta"."id_valuta" = :ll_id_valuta_riga   ;
if IsNull(ll_nr_cifre_arrot) then ll_nr_cifre_arrot=0
ld_cambio_riga= GetItemNumber(ll_row, "riga_documento_cambio")
if IsNull(ld_cambio_riga) then ld_cambio_riga=1
ld_Totale_Riga= f_Round(ld_Totale_Riga ,ll_nr_cifre_arrot, ls_tipo_arrotondamento)
SetItem(ll_row, "tot_riga_val_riga",ld_Totale_Riga)
SetItem(ll_row, "tot_riga_val_az",Round(ld_Totale_Riga / ld_cambio_riga, 0))
ld_Qta_Effettiva= ld_QTA + ld_QTA_SM
if not(IsNull(ld_Qta_Effettiva) OR ld_Qta_Effettiva=0) then SetItem(ll_row, "riga_documento_val_attribuito",ld_Totale_Riga / ld_Qta_Effettiva)
if IsNull(ld_Cambio_riga) then ld_Cambio_riga=0
ld_Totale_Riga_Lire= ld_Totale_Riga * ld_Cambio_riga
SetItem(ll_row, "tot_riga_val_az",ld_Totale_Riga_Lire)

if ll_id_valuta_riga = ll_valuta_documento then
	SetItem(ll_row, "tot_riga_val_doc",ld_Totale_Riga)
else
	
	if IsNull(idc_cambio) then idc_cambio=0
	ld_Totale_Riga_val= ld_Totale_Riga_Lire / idc_cambio
	
	if IsNull(il_arrotondamento) then il_arrotondamento=0
	ld_Totale_Riga_val= uf_round(ld_Totale_Riga_val)
	SetItem(ll_row, "tot_riga_val_doc",ld_Totale_Riga_val)
end if

return 0


end event

event ue_set_comp_riga;call super::ue_set_comp_riga;

string 		ls_codice, ls_descrizione
long 			ll_row, ll_id_articolo, ll_count
long			ll_id_unita_conf
decimal		ld_molt, ld_fatconv, ld_fatglob
string		ls_tipoconv


ll_count= RowCount()

IF ll_count > 0 THEN
	FOR ll_row = 1 to  ll_count
		ll_id_articolo = GetItemNumber(ll_row, "riga_documento_id_articolo")

		if (not IsNull(ll_id_Articolo)) and (ll_id_articolo > 0) then
			
			SELECT "articolo"."codice", "articolo"."descrizione" 
				INTO : ls_codice, :ls_descrizione
				FROM "articolo" 
				WHERE ( "articolo"."id_articolo" = :ll_id_articolo )   ;
		
			SetItem(ll_row, "c_articolo_cod",ls_codice)
			setitemstatus(ll_row, "c_articolo_cod", PRIMARY!, NotModified!)
	
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
				setitem(ll_row,"c_unita_conf_tipo_conversione", ls_tipoconv)
				setitem(ll_row,"c_unita_conf_fat_conversione", ld_fatconv)
				setitem(ll_row,"c_unita_conf_molteplicita", ld_molt)
				setitemstatus(ll_row, "c_unita_conf_tipo_conversione", PRIMARY!, NotModified!)
				setitemstatus(ll_row, "c_unita_conf_fat_conversione", PRIMARY!, NotModified!)
				setitemstatus(ll_row, "c_unita_conf_molteplicita", PRIMARY!, NotModified!)
			end if

		end if
	next

END IF
end event

event ue_init;call super::ue_init;iudw_children[1] = dw_riga_documento_dett_prev_ff
				
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

ll_row= GetRow()
CHOOSE CASE dwo.name
	
	CASE "c_articolo_cod"
		
		ls_dbc[1] = "descrizione"
		ls_dbc[2] = "id_articolo"
		ls_dbc[3] = "codice"
		ls_dwc[1] = "riga_documento_descrizione"
		ls_dwc[2] = "riga_documento_id_articolo"
		ls_dwc[3] = "c_articolo_cod"
		li_ok = uf_autofind_col (string(dwo.name),"articolo","codice","A",data,"",3,ls_dbc,ls_dbv,ls_dwc)

		if li_ok > 0 then
			event ue_set_arti_riga()
			post event ue_set_calc_riga(ll_row)
			return 2 
		end if

	CASE "quantita"
		post event ue_set_calc_riga(ll_row)
		
	CASE "prezzo"
		post event ue_set_calc_riga(ll_row)

	CASE "sconto"
		post event ue_set_calc_riga(ll_row)

END CHOOSE
post event ue_set_calc_riga(ll_row)
RETURN ll_ret_value

end event

event ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "riga_documento_descrizione"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_descrizione" 
		
	CASE "c_articolo_cod"
		is_search_window = "w_articolo_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "articolo_codice" 
		
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
		
		event ue_set_arti_riga()
		post event ue_set_calc_riga(ll_row)
	CASE "riga_documento_descrizione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("riga_documento_id_articolo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_articolo_cod", is_ricpar.s_ausil_value[1])
		event ue_set_arti_riga()
		post event ue_set_calc_riga(ll_row)
END CHOOSE

end event

event ue_initial;call super::ue_initial;date 				ld_data_prev_consegna
decimal 			ldc_cambio

long				ll_id_magazzino, ll_row, ll_numero, ll_id_valuta, ll_righe, ll_count, ll_nriga
long				ll_id_listino, ll_id_caus_magazzino, ll_id_locazione, ll_id_agente


ll_row = GetRow()


ld_data_prev_consegna = idw_gen.GetItemDate(idw_gen.GetRow(),"data_prev_consegna")
SetItem(ll_row, "riga_documento_data_prevista_consegna", ld_data_prev_consegna)

ll_nriga = GetItemNumber(1, "c_max_num")
if isnull(ll_nriga) then ll_nriga = 0
SetItem(ll_row, "riga_documento_num_riga", ll_nriga+1)

ll_id_valuta=idw_gen.GetItemNumber(idw_gen.GetRow(), "documento_id_valuta_des")
ldc_cambio=idw_gen.uf_GetItemDecimal(idw_gen.GetRow(), "documento_cambio")
SetItem(ll_row,"riga_documento_id_valuta",  ll_id_valuta)
SetItem(ll_row,"riga_documento_cambio",  ldc_cambio)

ll_id_listino=idw_gen.GetItemNumber(idw_gen.GetRow(), "documento_id_listino")
SetItem(ll_row, "riga_documento_id_listino",ll_id_listino)

ll_id_caus_magazzino = idw_gen.GetItemNumber(idw_gen.GetRow(), "documento_id_caus_magazzino")
SetItem(ll_row, "riga_documento_id_caus_magazzino",ll_id_caus_magazzino)

ll_id_magazzino = idw_gen.GetItemNumber(idw_gen.GetRow(), "documento_id_magazzino")
ll_id_locazione= uf_calc_locazione(ll_id_magazzino)
SetItem(ll_row, "id_locazione_1",ll_id_locazione)

ll_id_magazzino = idw_gen.GetItemNumber(idw_gen.GetRow(), "documento_id_magazzino_2")
ll_id_locazione= uf_calc_locazione(ll_id_magazzino)
SetItem(ll_row, "id_locazione_2",ll_id_locazione)


ll_id_agente = idw_gen.GetItemNumber(idw_gen.GetRow(), "id_gruppo_agenti")
SetItem(ll_row, "id_gruppo_agenti",ll_id_agente)

end event

event itemfocuschanged;call super::itemfocuschanged;
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
	ls_array[15]= uf_Get_Colval("riga_documento_provvigione")
	ls_array[16]= uf_Get_Colval("qta_sconto_merce")
	ls_array[17]= uf_Get_Colval("id_locazione_1")
	ls_array[18]= uf_Get_Colval("id_locazione_2")
	ls_array[19]= uf_Get_Colval("riga_documento_id_caus_magazzino")
	ls_array[20]= is_ric_riga
	ls_array[21]= uf_Get_Colval("riga_documento_id_articolo")
	ls_array[22]= uf_Get_Colval("riga_documento_id_valuta")
	ls_array[23]= uf_Get_Colval("riga_documento_cambio")
	ls_array[24]= uf_Get_Colval("id_riga_documento")
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
	
	uf_Set_Colval("qta_evasa",ls_array[13])
	uf_Set_Colval("riga_documento_provvigione",ls_array[15])
	uf_Set_Colval("qta_sconto_merce", ls_array[16])
	uf_Set_Colval("id_locazione_1",ls_array[17])
	uf_Set_Colval("id_locazione_2",ls_array[18])
	uf_Set_Colval("riga_documento_id_caus_magazzino",ls_array[19])
	uf_Set_Colval("riga_documento_id_valuta", ls_array[22])
	uf_Set_Colval("riga_documento_cambio", ls_array[23])

	TriggerEvent("ue_set_ucon_riga")
	Event ue_set_calc_riga(ll_row)
end if

end event

event rowfocuschanged;call super::rowfocuschanged;AcceptText()
end event

event ue_retrieve;call super::ue_retrieve;is_title = "Riga " + is_nome_tipo_documento
end event

type tabpage_3 from userobject within tab_1
int X=18
int Y=104
int Width=2775
int Height=1300
boolean Visible=false
long BackColor=79741120
string Text="Trasporto"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_documento_bolla_trasp_ff dw_documento_bolla_trasp_ff
end type

on tabpage_3.create
this.dw_documento_bolla_trasp_ff=create dw_documento_bolla_trasp_ff
this.Control[]={this.dw_documento_bolla_trasp_ff}
end on

on tabpage_3.destroy
destroy(this.dw_documento_bolla_trasp_ff)
end on

type dw_documento_bolla_trasp_ff from u_dw_master_main within tabpage_3
int X=27
int Y=36
int Width=2706
int Height=1232
string DataObject="d_documento_bolla_trasp_ff"
end type

event ue_init;call super::ue_init;is_list.s_colonne_drop[1] = "id_unita_misura_peso_cod"
is_list.s_colonne_drop[2] = "id_tipo_trasporto"
is_list.s_colonne_drop[3] = "id_tipo_trasporto_des"
is_list.s_colonne_drop[4] = "id_caus_trasporto"
is_list.s_colonne_drop[5] = "id_caus_trasporto_des"

ib_dw_shared = TRUE

end event

event itemchanged;call super::itemchanged;
long 			ll_row

string		ls_dbc[], ls_dbv[], ls_dwc[]
integer		li_ok


ll_row = GetRow()
CHOOSE CASE dwo.name

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

	
END CHOOSE

end event

event ue_set_search;call super::ue_set_search;
long  ll_row

ll_row = GetRow()

CHOOSE CASE as_nomecol
	
	CASE "c_vettore_cod"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "codice" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"

	CASE "c_vettore_des"
		is_search_window = "w_sog_commerciale_gen_coddes_sw" 
		is_ricpar.s_filter_value = as_valcol 
		is_ricpar.s_filter_name = "rag_soc_1" 
		
		is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"

END CHOOSE
end event

event ue_use_search;call super::ue_use_search;
long  ll_row

ll_row= GetRow()
CHOOSE CASE as_nomecol

	CASE "c_vettore_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_des", is_ricpar.s_ausil_value[1])
			
	CASE "c_vettore_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("documento_id_sog_commerciale_vettore", is_ricpar.s_id_seg_value[1])
		uf_set_colval("c_vettore_cod", is_ricpar.s_ausil_value[1])

END CHOOSE

end event

event ue_retrieve;call super::ue_retrieve;is_title= is_nome_tipo_documento
end event

type tabpage_4 from userobject within tab_1
int X=18
int Y=104
int Width=2775
int Height=1300
boolean Visible=false
long BackColor=79741120
string Text="Totali"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_castelletto_iva_gd dw_castelletto_iva_gd
dw_spesa_documento_gd dw_spesa_documento_gd
dw_documento_ord_tot_ff dw_documento_ord_tot_ff
st_spese_riepilogo st_spese_riepilogo
st_st_scadenze_sconti st_st_scadenze_sconti
cb_aggiorna cb_aggiorna
st_spese_riepilogo_cont st_spese_riepilogo_cont
st_st_scadenze_sconti_cont st_st_scadenze_sconti_cont
cb_ricalcola_scadenze cb_ricalcola_scadenze
dw_scadenza_documento_lt dw_scadenza_documento_lt
cb_ricalcola cb_ricalcola
cbx_simbolo cbx_simbolo
dw_documento_tot_ext_ff dw_documento_tot_ext_ff
cb_valuta cb_valuta
end type

on tabpage_4.create
this.dw_castelletto_iva_gd=create dw_castelletto_iva_gd
this.dw_spesa_documento_gd=create dw_spesa_documento_gd
this.dw_documento_ord_tot_ff=create dw_documento_ord_tot_ff
this.st_spese_riepilogo=create st_spese_riepilogo
this.st_st_scadenze_sconti=create st_st_scadenze_sconti
this.cb_aggiorna=create cb_aggiorna
this.st_spese_riepilogo_cont=create st_spese_riepilogo_cont
this.st_st_scadenze_sconti_cont=create st_st_scadenze_sconti_cont
this.cb_ricalcola_scadenze=create cb_ricalcola_scadenze
this.dw_scadenza_documento_lt=create dw_scadenza_documento_lt
this.cb_ricalcola=create cb_ricalcola
this.cbx_simbolo=create cbx_simbolo
this.dw_documento_tot_ext_ff=create dw_documento_tot_ext_ff
this.cb_valuta=create cb_valuta
this.Control[]={this.dw_castelletto_iva_gd,&
this.dw_spesa_documento_gd,&
this.dw_documento_ord_tot_ff,&
this.st_spese_riepilogo,&
this.st_st_scadenze_sconti,&
this.cb_aggiorna,&
this.st_spese_riepilogo_cont,&
this.st_st_scadenze_sconti_cont,&
this.cb_ricalcola_scadenze,&
this.dw_scadenza_documento_lt,&
this.cb_ricalcola,&
this.cbx_simbolo,&
this.dw_documento_tot_ext_ff,&
this.cb_valuta}
end on

on tabpage_4.destroy
destroy(this.dw_castelletto_iva_gd)
destroy(this.dw_spesa_documento_gd)
destroy(this.dw_documento_ord_tot_ff)
destroy(this.st_spese_riepilogo)
destroy(this.st_st_scadenze_sconti)
destroy(this.cb_aggiorna)
destroy(this.st_spese_riepilogo_cont)
destroy(this.st_st_scadenze_sconti_cont)
destroy(this.cb_ricalcola_scadenze)
destroy(this.dw_scadenza_documento_lt)
destroy(this.cb_ricalcola)
destroy(this.cbx_simbolo)
destroy(this.dw_documento_tot_ext_ff)
destroy(this.cb_valuta)
end on

event dragdrop;dw_castelletto_iva_gd.TriggerEvent("ue_calcola_cast_iva")
end event

type dw_castelletto_iva_gd from u_dw_ext_main within tabpage_4
event ue_calc_righe_cast ( )
event ue_calc_sp_iva_cast ( )
event ue_calc_sp_noiva_cast ( )
event ue_calc_cast_iva ( )
event type decimal ue_calc_bollo_cast ( )
event type decimal ue_calc_bolli_sc_cast ( )
event ue_setta_incasso ( )
event ue_calc_sconti_cast ( )
event ue_calc_sp_bollo_cast ( )
int X=27
int Y=496
int Width=1746
int Height=380
int TabOrder=0
string DataObject="d_castelletto_iva_gd"
boolean VScrollBar=true
end type

event ue_calc_righe_cast;call super::ue_calc_righe_cast;
long 			ll_nr_row, ll_count, ll_id_iva, ll_new_row,ll_row_found, ll_id_iva_max, ll_tot_row
decimal 		ldc_imponibile, ldc_tot_riga,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_omaggi_sc_merce
decimal 		ldc_val_omaggi, ldc_sconto_merce_art_15, ldc_sconto_merce_iva, ldc_tot_omaggi_sc_merce
string 		ls_codice, ls_descr_breve, ls_sconto
decimal 		ldc_sconto_merce



ldc_val_omaggi=0
ldc_sconto_merce_art_15= 0
ldc_sconto_merce_iva=0

ll_nr_row= idw_riga.RowCount()
for ll_count = 1 to ll_nr_row
	
	
	ldc_omaggi_sc_merce=0
	ldc_tot_riga = idw_riga.uf_GetItemDecimal(ll_count, "tot_riga_val_doc")
	if IsNull(ldc_tot_riga)  then ldc_tot_riga = 0
	ldc_prezzo_un = idw_riga.uf_GetItemDecimal(ll_count, "prezzo")
	if IsNull(ldc_prezzo_un)  then ldc_prezzo_un = 0
	ldc_sconto_merce= idw_riga.uf_GetItemDecimal(ll_count, "qta_sconto_merce")
	if IsNull(ldc_sconto_merce)  then ldc_sconto_merce = 0
	ls_sconto = idw_riga.GetItemString(ll_count, "sconto")
	if IsNull(ls_sconto)  then ls_sconto = ""
	ldc_quantita = idw_riga.uf_GetItemDecimal(ll_count, "quantita")
	if IsNull(ldc_quantita)  then ldc_quantita = 0
	ll_id_iva = idw_riga.GetItemNumber(ll_count, "riga_documento_id_tab_iva")
	if IsNull(ll_id_iva)  then 
		ldc_aliquota= 0
	else
		
		SELECT "tab_iva"."per_aliquota"  
			INTO :ldc_aliquota  
			FROM "tab_iva"  
			WHERE "tab_iva"."id_tab_iva" = :ll_id_iva  ;
	end if
	if uf_calcola_prezzo(ls_sconto, 1000000, 1) = 0 then
	
		ldc_imposta= Ceiling((ldc_prezzo_un * ldc_quantita * ldc_aliquota) / 100)
		
		ldc_omaggi_sc_merce= (ldc_quantita * ldc_prezzo_un)
		ldc_val_omaggi= ldc_val_omaggi + ldc_omaggi_sc_merce
		uf_ins_riga_cast(ll_id_iva, this, 0, ldc_imposta, ldc_omaggi_sc_merce)
	else
	
		if ldc_quantita <> 0 then
		
			ldc_imponibile= ldc_tot_riga
			ldc_imposta= Ceiling(ldc_aliquota * ldc_tot_riga / 100)
			uf_ins_riga_cast(ll_id_iva, this, ldc_imponibile, ldc_imposta, 0)
			if ldc_sconto_merce <> 0 then
				ldc_omaggi_sc_merce= (ldc_sconto_merce * (ldc_tot_riga / ldc_quantita) )
				ldc_sconto_merce_art_15= ldc_sconto_merce_art_15 + ldc_omaggi_sc_merce
				uf_ins_riga_cast(il_id_tab_iva_art_15, this, 0, 0, ldc_omaggi_sc_merce)
			end if
		else
		
			if ldc_sconto_merce <> 0 then
			
				ldc_imposta= Ceiling(ldc_sconto_merce * ldc_prezzo_un * (ldc_aliquota / 100))
				uf_ins_riga_cast(ll_id_iva, this, 0, ldc_imposta, 0)
				if ll_id_iva = il_id_tab_iva_art_15 then
					ldc_omaggi_sc_merce= (ldc_sconto_merce * ldc_prezzo_un ) 
					ldc_sconto_merce_art_15= ldc_sconto_merce_art_15 + ldc_omaggi_sc_merce
					uf_ins_riga_cast(il_id_tab_iva_art_15, this, 0, 0, ldc_omaggi_sc_merce)
				else
					ldc_omaggi_sc_merce= (ldc_sconto_merce * ldc_prezzo_un ) 
					ldc_sconto_merce_iva= ldc_sconto_merce_iva +  ldc_omaggi_sc_merce
					uf_ins_riga_cast(ll_id_iva, this, 0, 0, ldc_sconto_merce_iva)
				end if
			end if
		end if
	end if
next
If IsNull(ldc_val_omaggi) then ldc_val_omaggi=0
If IsNull(ldc_sconto_merce_art_15) then ldc_sconto_merce_art_15=0
If IsNull(ldc_sconto_merce_iva) then ldc_sconto_merce_iva=0
ll_tot_row= idw_gen_tot.GetRow()
idw_gen.SetItem(idw_gen.GetRow(), "c_val_omaggi", ldc_val_omaggi )
idw_gen_tot_ext.SetItem(ll_tot_row, "tot_omaggi", ldc_val_omaggi )
idw_gen.SetItem(idw_gen.GetRow(), "c_val_sc_merce_art_15", ldc_sconto_merce_art_15 )
idw_gen_tot_ext.SetItem(ll_tot_row, "tot_sc_merce_art_15", ldc_sconto_merce_art_15 )
idw_gen.SetItem(idw_gen.GetRow(), "c_val_sc_merce_iva", ldc_sconto_merce_iva )
idw_gen_tot_ext.SetItem(ll_tot_row, "tot_sc_merce_iva", ldc_sconto_merce_iva )
ldc_tot_omaggi_sc_merce=ldc_val_omaggi + ldc_sconto_merce_art_15 + ldc_sconto_merce_iva
idw_gen_tot_ext.SetItem(ll_tot_row, "tot_omaggi_sc_merce", ldc_tot_omaggi_sc_merce)
idw_gen_tot_ext.SetItem(ll_tot_row, "tot_omaggi_sc_merce_lire",ldc_tot_omaggi_sc_merce * idc_cambio )


end event

event ue_calc_sp_iva_cast;call super::ue_calc_sp_iva_cast;

long 			ll_nr_row, ll_count, ll_id_iva, ll_new_row,ll_row_found, ll_id_iva_max, ll_id_spesa
long 			ll_cast_count, ll_cast_row_nr, ll_id_iva_max_imp, ll_id_iva_max_ali, ll_nr_rate
long			ll_id_sog_comm
decimal 		ldc_imponibile, ldc_prezzo,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_tot_imponibile, ldc_proporz
string 		ls_codice, ls_descr_breve, ls_sconto, ls_mod_calc_iva

ll_nr_row= idw_spesa.RowCount()
for ll_count = 1 to ll_nr_row
	ll_id_iva= idw_spesa.GetItemNumber(ll_count, "id_tab_iva_des")
	if not (IsNull(ll_id_iva) OR ll_id_iva = 0) then 
		ll_id_spesa= idw_spesa.uf_GetItemDecimal(ll_count, "id_spesa_cod")
		
		SELECT "spesa"."codice"  
			INTO :ls_codice  
			FROM "spesa"  
			WHERE "spesa"."id_spesa" = :ll_id_spesa   ;
		CHOOSE CASE ls_codice
			CASE "C"
				
				
				ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "importo")
				if IsNull(ldc_importo) then ldc_importo = 0
				idw_spesa.SetItem(ll_count, "importo", ldc_importo)
				
				ll_row_found=Find("id_iva =" + string(ll_id_iva),1,RowCount())
				if ll_row_found= 0 then
					
					ll_new_row= InsertRow(0)
					  SELECT "tab_iva"."codice",   
								"tab_iva"."des_breve" ,
								"tab_iva"."per_aliquota"
						 INTO :ls_codice,   
								:ls_descr_breve, 
								:ldc_aliquota
						 FROM "tab_iva"  
						 WHERE "tab_iva"."id_tab_iva" = :ll_id_iva   ;
					SetItem(ll_new_row, "id_iva",ll_id_iva)
					SetItem(ll_new_row, "codice_iva", ls_codice)
					SetItem(ll_new_row, "des_breve_iva", ls_descr_breve)
					SetItem(ll_new_row, "spesa", ldc_importo)
					SetItem(ll_new_row, "aliquota_iva", ldc_aliquota)
					ldc_imposta= Ceiling(ldc_aliquota * ldc_importo / 100)
					SetItem(ll_new_row, "c_imposta", ldc_imposta)
				else
					
					ldc_imponibile= uf_GetItemDecimal(ll_row_found,"spesa")
					if not IsNull(ldc_importo) then SetItem(ll_row_found,"spesa", ldc_imponibile + ldc_importo)
				end if
			CASE ELSE
				
				ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "importo")
				
				if (IsNull(ldc_importo) OR ldc_importo = 0) then 
						if idw_riga.RowCount() > 0 then
							ldc_tot_righe= idw_riga.uf_GetItemDecimal(1, "c_tot_righe")
							ldc_importo=ldc_tot_righe * idw_spesa.uf_GetItemDecimal(ll_count, "percentuale") / 100
							
							idw_spesa.SetItem(ll_count, "importo", ldc_importo)

						end if	
				end if
				
				ll_row_found=Find("id_iva =" + string(ll_id_iva),1,RowCount())
				if ll_row_found= 0 then
					ll_new_row= InsertRow(0)
					  SELECT "tab_iva"."codice",   
								"tab_iva"."des_breve" ,
								"tab_iva"."per_aliquota"
						 INTO :ls_codice,   
								:ls_descr_breve, 
								:ldc_aliquota
						 FROM "tab_iva"  
						 WHERE "tab_iva"."id_tab_iva" = :ll_id_iva   ;
					SetItem(ll_new_row, "id_iva",ll_id_iva)
					SetItem(ll_new_row, "codice_iva", ls_codice)
					SetItem(ll_new_row, "des_breve_iva", ls_descr_breve)
					SetItem(ll_new_row, "spesa", ldc_importo)
					SetItem(ll_new_row, "aliquota_iva", ldc_aliquota)
					ldc_imposta= Ceiling(ldc_aliquota * ldc_importo / 100)
					SetItem(ll_new_row, "c_imposta", ldc_imposta)
				else
					ldc_imponibile= uf_GetItemDecimal(ll_row_found,"spesa")
					if not IsNull(ldc_importo) then SetItem(ll_row_found,"spesa", ldc_imponibile + ldc_importo)
				end if
		END CHOOSE
	end if
next

end event

event ue_calc_sp_noiva_cast;call super::ue_calc_sp_noiva_cast;

long 			ll_nr_row, ll_count, ll_id_iva, ll_new_row,ll_row_found, ll_id_iva_max, ll_id_spesa
long 			ll_cast_count, ll_cast_row_nr, ll_id_iva_max_imp, ll_id_iva_max_ali
decimal 		ldc_imponibile, ldc_prezzo,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_tot_imponibile, ldc_proporz
string 		ls_codice, ls_descr_breve, ls_sconto, ls_mod_calc_iva


ll_cast_row_nr= RowCount()
for ll_cast_count = 1 to ll_cast_row_nr
	SetItem(ll_cast_count, "prop_imponibile", GetItemNumber(ll_cast_count, "c_proporzionale"))
next
ll_id_iva_max_imp = uf_get_imp_max()

ll_id_iva_max_ali = uf_get_ali_max()

ll_nr_row= idw_spesa.RowCount()
for ll_count = 1 to ll_nr_row
	ll_id_iva= idw_spesa.GetItemNumber(ll_count, "id_tab_iva_des")
	if (IsNull(ll_id_iva) OR ll_id_iva = 0) then 
		
		ls_mod_calc_iva= idw_spesa.GetItemString(ll_count, "cc_mod_calc_iva")
		CHOOSE CASE ls_mod_calc_iva
			CASE "I"
				ll_id_iva_max = ll_id_iva_max_imp
			CASE "A"
				ll_id_iva_max = ll_id_iva_max_ali
			CASE "P"
				ll_id_iva_max = 0
			CASE ELSE
				ll_id_iva_max = 0
		END CHOOSE 
		if ll_id_iva_max>0 then
			ll_id_iva= ll_id_iva_max
			idw_spesa.SetItem(ll_count, "id_tab_iva_cod", ll_id_iva)
			ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "importo")
			
			if (IsNull(ldc_importo) OR ldc_importo = 0) then 
				if idw_riga.RowCount() > 0 then
					ldc_tot_righe= idw_riga.uf_GetItemDecimal(1, "c_tot_righe")
					ldc_importo=ldc_tot_righe * idw_spesa.uf_GetItemDecimal(ll_count, "percentuale") / 100
					
					idw_spesa.SetItem(ll_count, "importo", ldc_importo)
				end if	
			end if
			
			
			ll_row_found=Find("id_iva =" + string(ll_id_iva),1,RowCount())
			if ll_row_found <> 0 then
				ldc_imponibile= uf_GetItemDecimal(ll_row_found,"spesa")
				if not IsNull(ldc_importo) then 
					SetItem(ll_row_found,"spesa", ldc_imponibile + ldc_importo)
				end if
				ldc_aliquota= uf_GetItemDecimal(ll_row_found,"aliquota_iva")
			end if
		else
			ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "importo")
			
			if (IsNull(ldc_importo) OR ldc_importo = 0) then 
				if idw_riga.RowCount() > 0 then
					ldc_tot_righe= idw_riga.uf_GetItemDecimal(1, "c_tot_righe")
					ldc_importo=ldc_tot_righe * idw_spesa.uf_GetItemDecimal(ll_count, "percentuale") / 100
					
					idw_spesa.SetItem(ll_count, "importo", ldc_importo)
				end if	
			end if
			ll_cast_row_nr = RowCount()
			for ll_cast_count = 1 to ll_cast_row_nr
			
				ldc_proporz= uf_GetItemDecimal(ll_cast_count,"c_proporzionale")
				ldc_imponibile= uf_GetItemDecimal(ll_cast_count,"spesa") + (ldc_importo * ldc_proporz)
				if not IsNull(ldc_importo) then SetItem(ll_cast_count,"spesa", ldc_imponibile)
			next
		end if
	end if
next



end event

event ue_calc_cast_iva;call super::ue_calc_cast_iva;
long ll_nr_row, ll_count, ll_gen_row, ll_bollo_row, ll_row, ll_row_found
decimal ldc_bollo

if Not (IsNull(il_id_spesa_bollo) OR il_id_spesa_bollo = 0) then
	
	ll_nr_row= RowCount()
	for ll_count =  1 to ll_nr_row 
		DeleteRow(ll_nr_row - ll_count + 1)
	next
	
	ll_gen_row=idw_gen.GetRow()
	idw_gen.SetItem(ll_gen_row, "c_val_sc_merce_art_15", 0)
	idw_gen.SetItem(ll_gen_row, "c_val_sc_merce_iva", 0)
	idw_gen.SetItem(ll_gen_row, "c_val_omaggi", 0)
	
	SELECT "par_sistema"."id_tab_iva_art_15"  
		INTO :il_id_tab_iva_art_15  
		FROM "par_sistema"  
		WHERE "par_sistema"."id_azienda" = 1   ;
	
	ll_bollo_row= idw_spesa.Find("id_spesa_cod = " + String(il_id_spesa_bollo),1,idw_spesa.RowCount())
	if not (IsNull(ll_bollo_row) OR ll_bollo_row =0) then 
		idw_spesa.SetItem(ll_bollo_row, "importo", 0)
	end if
	TriggerEvent("ue_setta_incasso")

	TriggerEvent("ue_calc_righe_cast")
	TriggerEvent("ue_calc_sconti_cast")
	TriggerEvent("ue_calc_sp_noiva_cast")
	TriggerEvent("ue_calc_sp_iva_cast")

	TriggerEvent("ue_calc_bollo_cast")
	ldc_bollo= Event ue_calc_bolli_sc_cast()
	if IsNull(ldc_bollo) then ldc_bollo=0
	TriggerEvent("ue_calc_sp_bollo_cast")
	ll_row= RowCount()
	if ll_row > 0 then
		
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_merce", uf_GetItemDecimal(ll_row, "c_tot_imponibile"))
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "netto_merce", uf_GetItemDecimal(ll_row, "c_tot_imp_scontato"))
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_merce_lire", uf_GetItemDecimal(ll_row, "c_tot_imponibile") * idc_cambio)
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "netto_merce_lire", uf_GetItemDecimal(ll_row, "c_tot_imp_scontato") * idc_cambio)
	
		
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_imponibile", uf_GetItemDecimal(ll_row, "c_tot_imponibile_spesa"))
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_imposta", uf_GetItemDecimal(ll_row, "c_tot_imposta") )
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_documento", uf_GetItemDecimal(ll_row, "c_tot_imponibile_spesa") + uf_GetItemDecimal(RowCount(), "c_tot_imposta") )
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_imponibile_lire", uf_GetItemDecimal(ll_row, "c_tot_imponibile_spesa_lire"))
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_imposta_lire", uf_GetItemDecimal(ll_row, "c_tot_iva_lire") )
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_documento_lire", uf_GetItemDecimal(ll_row, "c_tot_imponibile_spesa_lire") + uf_GetItemDecimal(ll_row, "c_tot_iva_lire") )
	else
		
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_merce", 0)
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "netto_merce", 0)
	
		
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_imponibile", 0)
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_imposta", 0)
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_documento", 0)
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_imponibile_lire", 0)
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_imposta_lire", 0 )
		idw_gen_tot_ext.SetItem(idw_gen_tot.GetRow(), "tot_documento_lire", 0)
	
	end if
	SetSort("codice_iva A")
	Sort()
else
	MessageBox("Castelletto IVA", "Impossibile generare il Castelletto IVA ~n in quanto non esiste una spesa di tipo Bollo.", Information!)
end if
end event

event ue_calc_bollo_cast;call super::ue_calc_bollo_cast;
long 			ll_nr_row, ll_count, ll_id_iva, ll_bollo_row, ll_row_found
decimal		ldc_imp_min_fattura, ldc_imp_bollo_fattura, ldc_totale, ldc_bollo, ldc_importo

ldc_bollo=0
ll_nr_row= RowCount()
if ll_nr_row > 0 then
	
	ldc_totale=uf_GetItemDecimal(ll_nr_row, "c_tot_imponibile_spesa")
	
	
	for ll_count =  1 to ll_nr_row 
		
		ll_id_iva= uf_GetItemDecimal(ll_count, "id_iva")
		SELECT "tab_iva"."imp_min_fattura",   
			"tab_iva"."imp_bollo_fattura"  
			INTO :ldc_imp_min_fattura,   
			:ldc_imp_bollo_fattura  
			FROM "tab_iva"  
			WHERE "tab_iva"."id_tab_iva" = :ll_id_iva   ;
		if Not(Isnull(ldc_imp_min_fattura) OR ldc_imp_min_fattura <=0 OR &
				Isnull(ldc_imp_bollo_fattura) OR ldc_imp_bollo_fattura <=0 ) then
			if ldc_imp_min_fattura <= ldc_totale then
				ldc_bollo= ldc_bollo + ldc_imp_bollo_fattura
			end if
		end if
	next
	If ldc_bollo > 0 then 
		ll_bollo_row=idw_spesa.Find("id_spesa_cod = " + String(il_id_spesa_bollo),1,idw_spesa.RowCount())
		if not (IsNull(ll_bollo_row) OR ll_bollo_row=0) then 
			ldc_importo= idw_spesa.uf_GetItemDecimal(ll_bollo_row, "importo")
			If isNull(ldc_importo) then ldc_importo=0
			idw_spesa.SetItem(ll_bollo_row, "importo", ldc_bollo + ldc_importo)
		else
			ll_bollo_row=idw_spesa.InsertRow(0)
			idw_spesa.SetItem(ll_bollo_row, "id_spesa_cod", il_id_spesa_bollo)
			idw_spesa.SetItem(ll_bollo_row, "id_documento", idw_gen.GetItemNumber(idw_gen.GetRow(), "id_documento"))
			idw_spesa.SetItem(ll_bollo_row, "id_tab_iva_cod", il_id_tab_iva_art_15)
			idw_spesa.SetItem(ll_bollo_row, "importo", ldc_bollo)
		end if
	end if
end if
return ldc_bollo

end event

event ue_calc_bolli_sc_cast;call super::ue_calc_bolli_sc_cast;
s_scadenze		lstr_scadenze
boolean			lb_ok
long				ll_id_cp, ll_id_anag, ll_nr_row, ll_bollo_row, ll_row_found
decimal			ld_impon, ld_impos, ld_bollo, ld_importo
date				ld_iniz
decimal			ld_impr[], ld_ivar[]
date				ld_datr[]
integer			li_size, li_i

ld_bollo=0
ll_nr_row= RowCount()
If ll_nr_row > 0 then
	ld_impon = GetItemDecimal(ll_nr_row,"c_tot_imponibile")
	ld_impos = GetItemDecimal(ll_nr_row,"c_tot_imposta")
	ld_iniz = Date("01/01/1999")
	ll_id_cp = idw_gen.GetItemNumber(idw_gen.GetRow(), "id_con_pagamento")
	ll_id_anag = idw_gen.GetItemNumber(idw_gen.GetRow(), "id_sog_commerciale")
	ld_bollo= tab_1.tabpage_4.dw_scadenza_documento_lt.Event ue_simula()
	If ld_bollo > 0 then 
		
		ll_bollo_row=idw_spesa.Find("id_spesa_cod = " + String(il_id_spesa_bollo),1,idw_spesa.RowCount())
		if not (IsNull(ll_bollo_row) OR ll_bollo_row=0) then 
			ld_importo= idw_spesa.uf_GetItemDecimal(ll_bollo_row, "importo")
			If IsNull(ld_importo) then ld_importo =0
			idw_spesa.SetItem(ll_bollo_row, "importo", ld_bollo + ld_importo)

		else
			ll_bollo_row=idw_spesa.InsertRow(0)
			idw_spesa.SetItem(ll_bollo_row, "id_spesa_cod", il_id_spesa_bollo)
			idw_spesa.SetItem(ll_bollo_row, "id_documento", idw_gen.GetItemNumber(idw_gen.GetRow(), "id_documento"))
			idw_spesa.SetItem(ll_bollo_row, "id_tab_iva_cod", il_id_tab_iva_art_15)
			idw_spesa.SetItem(ll_bollo_row, "importo", ld_bollo)
		end if
	end if
end if
return ld_bollo
end event

event ue_setta_incasso;call super::ue_setta_incasso;
long 			ll_nr_row,ll_id_con_pagamento, ll_nr_rate, ll_id_spesa_inc, ll_spesa
decimal	 	ldc_totale

SELECT "spesa"."id_spesa"  
	INTO :ll_id_spesa_inc  
	FROM "spesa"  
	WHERE "spesa"."codice" = 'C'   ;

If not(IsNull(ll_id_spesa_inc) OR ll_id_spesa_inc=0) then
	
	ll_id_con_pagamento= idw_gen.GetItemNumber(idw_gen.GetRow(), "id_con_pagamento")

	ll_nr_rate = tab_1.tabpage_4.dw_scadenza_documento_lt.Event ue_rate_ges_spesa("C")
	
	ll_spesa = idw_spesa.Find("id_spesa_cod = " + string(ll_id_spesa_inc), 1, idw_spesa.RowCount())
	if not(IsNull(ll_spesa) OR ll_spesa=0 OR IsNull(ll_nr_rate)) then
		
		idw_spesa.SetItem(ll_spesa, "importo", idw_spesa.uf_GetItemDecimal(ll_spesa, "cc_importo_buffer") * ll_nr_rate)
	end if
end if


end event

event ue_calc_sconti_cast;call super::ue_calc_sconti_cast;

long 			ll_nr_row, ll_count, ll_gen_row, ll_cast_count, ll_cast_row_nr
decimal 		ldc_sc_fin_cassa, ldc_sc_incondizionato, ldc_imponibile, ldc_sconto, ldc_imp_complemento
decimal 		ldc_perc_incondizionato
string 		ls_sc_finanziario

ll_gen_row= idw_gen.GetRow()
ls_sc_finanziario= idw_gen.GetItemString(ll_gen_row, "documento_sconto_finanziario")
ldc_sc_incondizionato= idw_gen.uf_GetItemDecimal(ll_gen_row, "sconto_fin_incondizionato")
ldc_sc_fin_cassa= idw_gen.uf_GetItemDecimal(ll_gen_row, "documento_sconto_fin_cassa")

ll_cast_row_nr= RowCount()
for ll_cast_count = 1 to ll_cast_row_nr
	SetItem(ll_cast_count, "prop_imponibile", Round(GetItemNumber(ll_cast_count, "c_proporzionale"), 2))
next

If not (IsNull(ls_sc_finanziario) OR ls_sc_finanziario = "") then
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "imponibile")
		ldc_imponibile= uf_calcola_prezzo(ls_sc_finanziario, ldc_imponibile, 0)
		SetItem(ll_cast_count, "imponibile_scontato", ldc_imponibile)
	next
else
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "imponibile")
		SetItem(ll_cast_count, "imponibile_scontato", ldc_imponibile)
	next
end if
ldc_imp_complemento=0
If not (IsNull(ldc_sc_incondizionato) OR ldc_sc_incondizionato = 0) then
	if ll_cast_row_nr > 0 then
		for ll_cast_count = 1 to ll_cast_row_nr - 1
			ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "imponibile_scontato")
			ldc_perc_incondizionato= uf_Round(ldc_sc_incondizionato * uf_GetItemDecimal(ll_cast_count, "c_proporzionale"))
			ldc_imponibile= ldc_imponibile - ldc_perc_incondizionato
			ldc_imp_complemento= ldc_imp_complemento + ldc_perc_incondizionato
			SetItem(ll_cast_count, "imponibile_scontato", ldc_imponibile)
		next
		ldc_imponibile= uf_GetItemDecimal(ll_cast_row_nr, "imponibile_scontato")
		ldc_imponibile= ldc_imponibile - ldc_sc_incondizionato + ldc_imp_complemento
		SetItem(ll_cast_row_nr, "imponibile_scontato", ldc_imponibile)
	end if
end if
If not (IsNull(ldc_sc_fin_cassa) OR ldc_sc_fin_cassa = 0) then
	for ll_cast_count = 1 to ll_cast_row_nr
		ldc_imponibile= uf_GetItemDecimal(ll_cast_count, "imponibile_scontato")
		ldc_imponibile= ldc_imponibile - (ldc_imponibile * ldc_sc_fin_cassa / 100)
		SetItem(ll_cast_count, "imponibile_scontato", ldc_imponibile)
	next
end if


end event

event ue_calc_sp_bollo_cast;call super::ue_calc_sp_bollo_cast;

long 			ll_nr_row, ll_count, ll_id_iva, ll_new_row,ll_row_found, ll_id_spesa, ll_bollo_nullo
long 			ll_cast_count, ll_cast_row_nr, ll_id_iva_max_imp, ll_id_iva_max_ali, ll_nr_rate

decimal 		ldc_imponibile, ldc_prezzo,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo
decimal 		ldc_quantita, ldc_prezzo_un
string 		ls_codice, ls_descr_breve, ls_sconto

ll_nr_row= idw_spesa.RowCount()
for ll_count = 1 to ll_nr_row
	ll_id_spesa= idw_spesa.uf_GetItemDecimal(ll_count, "id_spesa_cod")
	
	SELECT "spesa"."codice"  
		INTO :ls_codice  
		FROM "spesa"  
		WHERE "spesa"."id_spesa" = :ll_id_spesa   ;
	CHOOSE CASE ls_codice
		CASE "B"
			ll_id_iva= idw_spesa.GetItemNumber(ll_count, "id_tab_iva_des")
			if IsNull(ll_id_iva) then ll_id_iva= il_id_tab_iva_art_15
			
			ldc_importo= idw_spesa.uf_GetItemDecimal(ll_count, "importo")
			if not (IsNull(ldc_importo) OR ldc_importo=0) then 
					
				
				ll_row_found=Find("id_iva =" + string(ll_id_iva),1,RowCount())
				if ll_row_found= 0 then
					ll_new_row= InsertRow(0)
					  SELECT "tab_iva"."codice",   
								"tab_iva"."des_breve" ,
								"tab_iva"."per_aliquota"
						 INTO :ls_codice,   
								:ls_descr_breve, 
								:ldc_aliquota
						 FROM "tab_iva"  
						 WHERE "tab_iva"."id_tab_iva" = :ll_id_iva   ;
					SetItem(ll_new_row, "id_iva",ll_id_iva)
					SetItem(ll_new_row, "codice_iva", ls_codice)
					SetItem(ll_new_row, "des_breve_iva", ls_descr_breve)
					SetItem(ll_new_row, "spesa", ldc_importo)
					SetItem(ll_new_row, "aliquota_iva", ldc_aliquota)
					ldc_imposta= Ceiling(ldc_aliquota * ldc_importo / 100)
					SetItem(ll_new_row, "c_imposta", ldc_imposta)
				else
					ldc_imponibile= uf_GetItemDecimal(ll_row_found,"spesa")
					if IsNull(ldc_imponibile) then ldc_imponibile=0
					SetItem(ll_row_found,"spesa", ldc_imponibile + ldc_importo)
					ldc_imposta= uf_GetItemDecimal(ll_row_found,"c_imposta")
					if IsNull(ldc_imposta) then ldc_imposta=0
					ldc_imposta= ldc_imposta + Ceiling(ldc_aliquota * ldc_importo / 100)
					SetItem(ll_row_found, "c_imposta", ldc_imposta)
				end if
			else
				
				ll_bollo_nullo= ll_count
			end if
	END CHOOSE
next
if ll_bollo_nullo > 0 then idw_spesa.DeleteRow(ll_bollo_nullo)

end event

event getfocus;call super::getfocus;

w_p_data lw_current

lw_current=u_freddie.iw_current
lw_current.cb_inserisci.Enabled = FALSE
lw_current.cb_cancella.Enabled = FALSE

end event

event losefocus;call super::losefocus;w_p_data lw_current
lw_current=u_freddie.iw_current
lw_current.cb_inserisci.Enabled = TRUE
lw_current.cb_cancella.Enabled = TRUE

end event

event constructor;call super::constructor;

this.Object.c_proporzionale.width = 0
this.Object.c_imp_spesa_omaggi.width = 0
this.Object.c_imposta.width = 0
this.Object.c_imponibile_spesa.width = 0
this.Object.c_iva_val.width = 0


end event

type dw_spesa_documento_gd from u_dw_master_main within tabpage_4
event ue_cancella_spese ( )
event ue_aggiorna ( )
int X=27
int Y=116
int Width=1746
int Height=332
int TabOrder=10
string DataObject="d_spesa_documento_gd"
boolean VScrollBar=true
end type

event ue_cancella_spese;call super::ue_cancella_spese;
long ll_count, ll_nr_row

ll_nr_row= idw_spesa.RowCount()

for ll_count= 1 to ll_nr_row
	idw_spesa.DeleteRow(ll_nr_row - ll_count + 1)
next
end event

event ue_aggiorna;call super::ue_aggiorna;long ll_ret_value

TriggerEvent("ue_cancella_spese")
ll_ret_value= uf_individua_spese()
tab_1.tabpage_4.dw_castelletto_iva_gd.PostEvent("ue_calc_cast_iva")
end event

event itemchanged;call super::itemchanged;long ll_spesa, ll_row, ll_id_tab_iva
string ls_codice
long					ll_count, ll_nr_row 
boolean 				lb_spesa_esistente= FALSE
integer				li_ret_code
string 				ls_filter


ll_row= GetRow()
If not (GetItemStatus(ll_row, 0, Primary!) = New! OR GetItemStatus(ll_row, 0, Primary!) = NewModified!) then
	CHOOSE CASE dwo.name
		CASE "percentuale","id_tab_iva_cod"
			dw_castelletto_iva_gd.PostEvent("ue_calc_cast_iva")
		CASE "importo"
			SetItem(ll_row, "cc_importo_buffer", Dec(data))
			dw_castelletto_iva_gd.PostEvent("ue_calc_cast_iva")
	END CHOOSE
else
	CHOOSE CASE dwo.name
		CASE "id_spesa_cod", "id_spesa_des"
			
		
		
		ll_nr_row= RowCount()
		FOR ll_count= 1 to ll_nr_row
			ll_spesa= GetItemNumber(ll_count, "id_spesa_cod")
			if ll_spesa= Long(data) AND not(ll_count = ll_row) then lb_spesa_esistente= TRUE
		NEXT
		If lb_spesa_esistente then RETURN 2

		
			ll_spesa= Long(data)
			SELECT "spesa"."id_tab_iva"  
				INTO :ll_id_tab_iva  
				FROM "spesa"  
				WHERE "spesa"."id_spesa" = :ll_spesa ;
			SetItem(ll_row, "id_tab_iva_cod", ll_id_tab_iva)
	END CHOOSE
end if

end event

event ue_init;call super::ue_init;is_list.s_identifica[1] = "id_documento"


end event

event getfocus;call super::getfocus;




end event

event losefocus;call super::losefocus;




end event

event ue_delete;call super::ue_delete;
end event

event ue_insert;call super::ue_insert;
end event

event retrieverow;call super::retrieverow;

if GetItemNumber(row,"id_spesa_cod") = il_id_spesa_incasso then
	SetItem(row, "cc_importo_buffer", idc_spesa_inc_importo)
end if
end event

event ue_retrieve;call super::ue_retrieve;is_title= "Spese " + is_nome_tipo_documento
end event

event itemfocuschanged;call super::itemfocuschanged;
end event

type dw_documento_ord_tot_ff from u_dw_master_main within tabpage_4
int X=1819
int Y=496
int Width=923
int Height=380
int TabOrder=30
string DataObject="d_documento_ord_tot_ff"
end type

event ue_init;call super::ue_init;ib_dw_shared = TRUE

end event

event itemchanged;call super::itemchanged;CHOOSE CASE dwo.name
	CASE "sconto_finanziario", "sconto_fin_cassa", "fin_incondizionato"
		tab_1.tabpage_4.dw_castelletto_iva_gd.PostEvent("ue_calc_cast_iva")
END CHOOSE
end event

event ue_retrieve;call super::ue_retrieve;is_title= is_nome_tipo_documento
end event

type st_spese_riepilogo from statictext within tabpage_4
int X=27
int Y=36
int Width=1243
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Spese / Riepilogo IVA"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_st_scadenze_sconti from statictext within tabpage_4
int X=1819
int Y=36
int Width=489
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text=" Scadenze / Sconti"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_aggiorna from commandbutton within tabpage_4
int X=1285
int Y=36
int Width=398
int Height=84
int TabOrder=50
boolean BringToTop=true
string Text="Ricalcola Spese"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if tab_1.tabpage_4.dw_spesa_documento_gd.RowCount() > 0 then
	If MessageBox(is_nome_tipo_documento, "Vuoi sostituire le attuali Spese ricalcolandole?", Information!,YesNo!, 1) = 1 then
		tab_1.tabpage_4.dw_spesa_documento_gd.TriggerEvent("ue_aggiorna")
	End if
else
	tab_1.tabpage_4.dw_spesa_documento_gd.TriggerEvent("ue_aggiorna")
End if


end event

type st_spese_riepilogo_cont from statictext within tabpage_4
int X=1696
int Y=36
int Width=78
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_st_scadenze_sconti_cont from statictext within tabpage_4
int X=2688
int Y=36
int Width=55
int Height=80
boolean Enabled=false
boolean BringToTop=true
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ricalcola_scadenze from commandbutton within tabpage_4
int X=2313
int Y=36
int Width=370
int Height=84
int TabOrder=60
boolean BringToTop=true
string Text="Ricalc. Scad."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If MessageBox(is_nome_tipo_documento, "Vuoi sostituire le attuali Scadenze ricalcolandole?", Information!,YesNo!, 1) = 1 then
	ib_genera_scadenza= TRUE
	tab_1.tabpage_4.dw_castelletto_iva_gd.TriggerEvent("ue_calc_cast_iva")
end if




end event

type dw_scadenza_documento_lt from u_dw_master_main within tabpage_4
event type decimal ue_simula ( )
event type decimal ue_rate_ges_spesa ( string as_spesa )
int X=1819
int Y=116
int Width=923
int Height=332
string DataObject="d_scadenza_documento_lt"
boolean VScrollBar=true
end type

event ue_simula;
s_scadenze		lstr_scadenze
boolean	lb_ok
long		ll_id_cp, ll_id_anag, ll_row, ll_nr_row, ll_id_valuta, ll_id_documento
long		ll_nr_scadenze, ll_count, ll_id_intestatario, ll_id_azienda
long		ll_id_banca_azienda, ll_id_banca_sog_com
decimal	ldc_impon, ldc_impos, ldc_bollo, ldc_imp_lire, ldc_bollo_tot
decimal	ldc_imp_parziale, ldc_tot_imp_val,ldc_imp_val
date		ldc_iniz
decimal	ldc_impr[], ldc_ivar[]
date		ldc_datr[]
integer	li_size, li_i
boolean 	lb_scadenze_raggruppate

ll_row= idw_gen.GetRow()
ll_id_valuta= idw_gen.GetItemNumber(ll_row, "documento_id_valuta_des")
ll_id_intestatario= idw_gen.GetItemNumber(ll_row, "id_sog_commerciale")
SELECT "sog_commerciale"."id_banca_sog_commerciale"  
	INTO :ll_id_banca_sog_com  
	FROM "sog_commerciale"  
	WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_intestatario   ;
SELECT "sog_commerciale"."scad_raggruppate"  
	INTO :lb_scadenze_raggruppate  
	FROM "sog_commerciale"  
	WHERE "sog_commerciale"."id_sog_commerciale" = :ll_id_intestatario    ;

ll_id_documento= idw_gen.GetItemNumber(ll_row, "id_documento")
ll_id_azienda= idw_gen.GetItemNumber(ll_row, "documento_id_azienda")
SELECT "azienda"."id_banca_azienda"  
	INTO :ll_id_banca_azienda  
	FROM "azienda"  
	WHERE "azienda"."id_azienda" = :ll_id_azienda   ;

ll_nr_row= idw_castelletto.RowCount()
If ll_nr_row > 0 then
	ldc_impon = idw_castelletto.GetItemDecimal(ll_nr_row,"c_tot_imponibile_spesa_lire")
	
	ldc_impos = idw_castelletto.GetItemDecimal(ll_nr_row,"c_tot_iva_lire")
	
	ldc_tot_imp_val= idw_castelletto.GetItemDecimal(ll_nr_row,"c_tot_imponibile_spesa") + idw_castelletto.GetItemDecimal(ll_nr_row,"c_tot_iva_val")
	ldc_iniz = idw_gen.GetItemDate( ll_row,"documento_data_dec_pagamento")
	If IsNull(ldc_iniz) then ldc_iniz = idw_gen.GetItemDate( ll_row,"data_registrazione")
	If IsNull(ldc_iniz) then ldc_iniz = Date("01/01/1900")
	ll_id_cp = idw_gen.GetItemNumber( ll_row,"id_con_pagamento_des")
	ll_id_anag = idw_gen.GetItemNumber( ll_row,"id_sog_commerciale")
	
	
	
	lb_ok = iuo_pag.uf_calcola_pagamenti_e(ll_id_valuta,ldc_impon,ldc_impos,ldc_iniz,ll_id_anag,ll_id_cp,lstr_scadenze)	
	
	
	

	if is_stato_scad_generata <> "N" AND ib_genera_scadenza then
		
		ll_nr_scadenze= RowCount()
		for ll_count= 1 to ll_nr_scadenze
			DeleteRow(ll_nr_scadenze - ll_count + 1)
		next
	
		li_size = UpperBound(lstr_scadenze.dc_imp_out)
		for li_i = 1 to li_size -1
			ll_row = InsertRow(0)
			if ll_row>0 then
				SetItem(ll_row, "id_sog_commerciale", ll_id_intestatario)
				SetItem(ll_row,"data_scadenza",lstr_scadenze.d_date[li_i])
				SetItem(ll_row, "id_valuta", ll_id_valuta)
				SetItem(ll_row, "cambio", idc_cambio)
				
				ldc_imp_val= uf_Round((lstr_scadenze.dc_iva_out[li_i] + lstr_scadenze.dc_imp_out[li_i]) / idc_cambio)
				ldc_imp_parziale= ldc_imp_parziale + ldc_imp_val
				ldc_imp_lire= lstr_scadenze.dc_iva_out[li_i] + lstr_scadenze.dc_imp_out[li_i] + lstr_scadenze.dc_bollo[li_i]
				SetItem(ll_row,"imp_valuta", ldc_imp_val + (lstr_scadenze.dc_bollo[li_i] / idc_cambio))
				If not IsNull(idc_cambio) then SetItem(ll_row,"importo", ldc_imp_lire)
				SetItem(ll_row,"id_tipo_pagamento",lstr_scadenze.l_id_tipo_pagamento[li_i])
				SetItem(ll_row,"id_banca_sog_commerciale",ll_id_banca_sog_com)
				SetItem(ll_row,"stato_scadenza",is_stato_scad_generata)
				SetItem(ll_row,"esito_pagamento","E")
				SetItem(ll_row,"scadenza_da_raggruppare",lb_scadenze_raggruppate)
				SetItem(ll_row, "id_documento", ll_id_documento)
			end if
		next
		
		
		ll_row = InsertRow(0)
		if ll_row>0 then
			SetItem(ll_row, "id_sog_commerciale", ll_id_intestatario)
			SetItem(ll_row,"data_scadenza",lstr_scadenze.d_date[li_size])
			SetItem(ll_row, "id_valuta", ll_id_valuta)
			SetItem(ll_row, "cambio", idc_cambio)
			ldc_imp_lire= ((ldc_tot_imp_val  - ldc_imp_parziale) * idc_cambio) + lstr_scadenze.dc_bollo[li_size]
			SetItem(ll_row,"imp_valuta", ldc_imp_lire / idc_cambio)
			If not IsNull(idc_cambio) then SetItem(ll_row,"importo", ldc_imp_lire)
			SetItem(ll_row,"id_tipo_pagamento",lstr_scadenze.l_id_tipo_pagamento[li_size])
			SetItem(ll_row,"id_banca_sog_commerciale",ll_id_banca_sog_com)
			SetItem(ll_row,"stato_scadenza",is_stato_scad_generata)
			SetItem(ll_row,"esito_pagamento","E")
			SetItem(ll_row,"scadenza_da_raggruppare",lb_scadenze_raggruppate)
			SetItem(ll_row, "id_documento", ll_id_documento)
		end if
	end if
end if
ldc_bollo_tot= lstr_scadenze.dc_bollo_tot / idc_cambio
RETURN ldc_bollo_tot


end event

event ue_rate_ges_spesa;call super::ue_rate_ges_spesa;
long ll_count, ll_nr_row, ll_scad_x_spesa, ll_id_con_pagamento
string ls_spese

ll_nr_row= RowCount()
if ll_nr_row > 0  AND not ib_genera_scadenza then
	FOR ll_count = 1 to  ll_nr_row
		
		ll_id_con_pagamento= GetItemNumber(ll_count, "id_tipo_pagamento")
		SELECT "tipo_pagamento"."spese_gestite"  
			INTO :ls_spese  
			FROM "tipo_pagamento"  
			WHERE "tipo_pagamento"."id_tipo_pagamento" = :ll_id_con_pagamento   ;
		if Pos(ls_spese, as_spesa) > 0 then
			ll_scad_x_spesa ++
		end if
	NEXT
else
	ll_id_con_pagamento= idw_gen.GetItemNumber(idw_gen.GetRow(), "id_con_pagamento")
	ll_scad_x_spesa= iuo_pag.uf_rate_ges_spesa(ll_id_con_pagamento, "C")
end if
RETURN ll_scad_x_spesa


end event

event ue_init;call super::ue_init;is_list.s_identifica[1]= "id_documento"


end event

event ue_delete;

long ll_count, ll_nr_row

if MessageBox(is_title, "Vuoi calcellare tutte le Scadenze?", Information!, YesNo!,1) = 1 then
	ll_nr_row= RowCount()
	for ll_count= 1 to ll_nr_row
		DeleteRow(ll_nr_row - ll_count + 1)
	next
	ib_genera_scadenza= TRUE
end if
end event

event ue_retrieve;call super::ue_retrieve;is_title = "Scadenze " + is_nome_tipo_documento
If RowCount() = 0 then
	ib_genera_scadenza= TRUE
end if
end event

event ue_update;call super::ue_update;
ib_genera_scadenza = FALSE


end event

event ue_insert;
end event

type cb_ricalcola from commandbutton within tabpage_4
int X=2350
int Y=1136
int Width=370
int Height=84
int TabOrder=40
boolean BringToTop=true
string Text="Ricalcola Totali"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;tab_1.tabpage_4.dw_castelletto_iva_gd.TriggerEvent("ue_calc_cast_iva")
end event

type cbx_simbolo from checkbox within tabpage_4
int X=2277
int Y=936
int Width=443
int Height=64
boolean BringToTop=true
string Text="Simbolo di Valuta"
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
end event

type dw_documento_tot_ext_ff from datawindow within tabpage_4
int X=27
int Y=916
int Width=2715
int Height=340
string DataObject="d_documento_tot_ext_ff"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

event constructor;InsertRow(0)
end event

type cb_valuta from commandbutton within tabpage_4
event clicked pbm_bnclicked
int X=2405
int Y=1016
int Width=306
int Height=84
int TabOrder=31
boolean BringToTop=true
string Text="Valuta"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If this.text = "Lire" then
	this.text = "Valuta"
	idw_castelletto.Object.c_iva_lire.width = 415
	idw_castelletto.Object.c_iva_val.width = 0
	idw_castelletto.Object.c_imponibile_spesa.width = 0
	idw_castelletto.Object.c_imponibile_spesa_lire.width = 415
	idw_scadenza.Object.importo.width = 450
	idw_scadenza.Object.imp_valuta.width = 0
	idw_gen_tot_ext.Modify("tot_documento_lire.visible = 1")
	idw_gen_tot_ext.Modify("tot_imposta_lire.visible = 1")
	idw_gen_tot_ext.Modify("tot_imponibile_lire.visible = 1")
	idw_gen_tot_ext.Modify("tot_merce_lire.visible = 1")
	idw_gen_tot_ext.Modify("netto_merce_lire.visible = 1")
	idw_gen_tot_ext.Modify("tot_omaggi_sc_merce_lire.visible = 1")
else
	this.text = "Lire"
	idw_castelletto.Object.c_iva_lire.width = 0
	idw_castelletto.Object.c_iva_val.width = 415
	idw_castelletto.Object.c_imponibile_spesa.width = 415
	idw_castelletto.Object.c_imponibile_spesa_lire.width = 0
	idw_scadenza.Object.importo.width = 0
	idw_scadenza.Object.imp_valuta.width = 450
	idw_gen_tot_ext.Modify("tot_documento_lire.visible = 0")
	idw_gen_tot_ext.Modify("tot_imposta_lire.visible = 0")
	idw_gen_tot_ext.Modify("tot_imponibile_lire.visible = 0")
	idw_gen_tot_ext.Modify("tot_merce_lire.visible = 0")
	idw_gen_tot_ext.Modify("netto_merce_lire.visible = 0")
	idw_gen_tot_ext.Modify("tot_omaggi_sc_merce_lire.visible = 0")

end if
	
end event

type st_message from statictext within w_documento_preventivo_cx
int X=2034
int Y=160
int Width=594
int Height=60
boolean Enabled=false
boolean BringToTop=true
string Text="Bloccato"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-12
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_blocco from commandbutton within w_documento_preventivo_cx
int X=1371
int Y=40
int Width=485
int Height=84
boolean BringToTop=true
string Text="Blocco Documento"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long				ll_row, ll_id_documento, ll_id_azienda, ll_id_prof_documento
char				lch_stato[]
dwItemStatus 	l_itemstatus
s_any_array 	lstr_array

ll_row = idw_gen.GetRow()
l_itemstatus = idw_gen.GetItemStatus(ll_row, 0, Primary!)
IF (l_itemstatus = New! OR l_itemstatus = NewModified!) THEN
	Return
END IF	
lch_stato= uf_calc_stato_doc()

lstr_array.s_array[1] = idw_gen.GetItemNumber(ll_row, "id_documento")
lstr_array.s_array[2] = idw_gen.GetItemNumber(ll_row, "id_prof_documento")
lstr_array.s_array[3] = idw_gen.GetItemNumber(ll_row, "documento_id_azienda")
lstr_array.s_array[4] = lch_stato[1]
lstr_array.s_array[5] = lch_stato[2]
lstr_array.s_array[6] = lch_stato[3]
lstr_array.s_array[7] = lch_stato[4]
lstr_array.s_array[8] = lch_stato[5]
lstr_array.s_array[9] = lch_stato[6]

OpenWithParm(w_blocco_docum_wz, lstr_array)

lstr_array= Message.PowerObjectParm

idw_gen.SetItem(ll_row, "bloccato",lstr_array.s_array[1])
idw_gen.SetItem(ll_row, "documento_chius_forzata",lstr_array.s_array[2])
idw_gen.SetItem(ll_row, "documento_contabilizzato",lstr_array.s_array[3])
idw_gen.SetItem(ll_row, "documento_evaso_totalmente",lstr_array.s_array[4])
idw_gen.SetItem(ll_row, "documento_sospeso",lstr_array.s_array[5])
idw_gen.SetItem(ll_row, "documento_stampato",lstr_array.s_array[6])

uf_blocco_documento()



end event

