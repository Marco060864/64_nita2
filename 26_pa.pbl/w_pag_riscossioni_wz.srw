forward
global type w_pag_riscossioni_wz from w_p_data
end type
type dw_pag_riscossioni_ff from u_dw_master_main within w_pag_riscossioni_wz
end type
end forward

global type w_pag_riscossioni_wz from w_p_data
integer x = 430
integer y = 424
integer width = 2807
integer height = 1488
string title = "Riscossioni e Pagamenti"
event ue_genera ( )
dw_pag_riscossioni_ff dw_pag_riscossioni_ff
end type
global w_pag_riscossioni_wz w_pag_riscossioni_wz

type variables
string 	is_tag, is_info_reg_pd, is_info_sc, is_segno, is_item_precedente, is_num_documento
decimal{4}	idc_par_dare, idc_par_avere, idc_tot_imponibile, idc_tot_imposta, idc_cambio, id_cambio
long 	il_id_conto, il_id_par_aperta, il_id_valuta, il_id_esercizio, il_num_progressivo, il_id_registro, il_id_reg_pd
date 	id_data_documento, id_data_reg_pd, id_data_competenza
uo_esp_pag	iuo_pag

end variables

forward prototypes
public subroutine uf_displayonly (datawindow dw_dwobj, string s_field, boolean b_status)
public function integer uf_genera ()
public subroutine uf_setta_format (long il_valuta)
end prototypes

event ue_genera;call super::ue_genera;
end event

public subroutine uf_displayonly (datawindow dw_dwobj, string s_field, boolean b_status);

dw_dwobj.Modify(s_field + ".Protect = " + string(b_status))
dw_dwobj.Modify(s_field + ".Background.Mode=" + string(b_status))
end subroutine

public function integer uf_genera ();

long ll_RetVal1, ll_RetVal2, ll_id_prof_reg, ll_id_con_pag, ll_id_anagrafica, ll_row
long ll_id_scadenza, ll_id_sog_commerciale, ll_id_banca_azienda, ll_id_banca_sog_commerciale
long ll_num_scadenze, ll_id_documento, ll_id_conto_mc[], ll_id_par_aperta[]
decimal ldc_saldo, ldc_contanti, ldc_differenza, ldc_imponibile, ldc_imposta, ldc_bollo
decimal ldc_differenza2, ldc_tot_importo, ldc_tot_importo_valuta, ldc_importo_mc[], ld_imp_residuo
date ld_data_reg, ld_inizio, ld_data_competenza
boolean lb_ok, lb_scad_generate, lb_mc_iva[]
integer li_size, li_i, li_RetVal
char lc_tipo_scadenza, lc_scad_raggruppate, lc_segno_mc[]
string las_param[]
s_scadenze lstr_scadenze
s_list_main lstr_list_main
constant long   LCL_ID_AZIENDA = 1
constant string LCS_DARE       = "D"
constant string LCS_AVERE      = "A"
constant char   LCC_ATTIVA     = "A"
constant char   LCC_PASSIVA    = "P"
constant char   LCC_DEFINITIVA = "D"
constant char   LCC_EMESSO     = "E"

u_reg_pd lu_reg_pd
lu_reg_pd = CREATE u_reg_pd

ld_imp_residuo=dw_pag_riscossioni_ff.uf_GetItemDecimal(1, "imp_residuo")
ldc_saldo = dw_pag_riscossioni_ff.uf_GetItemDecimal(1, "par_saldo")
ldc_contanti = dw_pag_riscossioni_ff.uf_GetItemDecimal(1, "imp_contanti")
ldc_differenza = ldc_saldo - ldc_contanti
ll_id_prof_reg = dw_pag_riscossioni_ff.GetItemNumber(1, "id_prof_registrazione")
ll_id_con_pag = dw_pag_riscossioni_ff.GetItemNumber(1, "id_con_pagamento")



ld_data_reg = dw_pag_riscossioni_ff.GetItemDate(1, "data_reg_pd")
lb_scad_generate = FALSE

IF (ldc_differenza > 0) AND (IsNull(ll_id_con_pag) OR ll_id_con_pag = 0) THEN
	
	CHOOSE CASE MessageBox("Riscossioni e Pagamenti", "Attenzione: non è stata immessa la condizione di pagamento.~rContinuare ugualmente senza generare le scadenze?", Question!, YesNo!)
		CASE 2
			dw_pag_riscossioni_ff.SetColumn("con_pagamento_cod")
			dw_pag_riscossioni_ff.SetFocus()
			RETURN 1
	END CHOOSE
END IF

IF ldc_contanti > 0 THEN
	IF IsNull(ll_id_prof_reg) OR ll_id_prof_reg = 0 THEN
		MessageBox("Riscossioni e Pagamenti", "Selezionare il Profilo Registrazione o immettere 0 nel campo dell'Importo in Contanti")
		dw_pag_riscossioni_ff.SetColumn("prof_registrazione_cod")
		dw_pag_riscossioni_ff.SetFocus()
		RETURN 1
	ELSE
		
		
		STRING ls_des_fatt
		SELECT descrizione INTO :ls_des_fatt 
		FROM reg_pd WHERE id_reg_pd=:il_id_reg_pd;
		IF is_segno = LCS_DARE THEN
			ls_des_fatt='Riscosso ' + LEFT(ls_des_fatt,31)
		else
			ls_des_fatt='Pagata ' + LEFT(ls_des_fatt,31)
		end if
		lu_reg_pd.uf_descrizione(ls_des_fatt)
		
		
		lu_reg_pd.uf_id_prof_registrazione(ll_id_prof_reg)
		lu_reg_pd.uf_data_registrazione(ld_data_reg)
		
	//	lu_reg_pd.uf_data_competenza(ld_data_competenza)
		
		
		long ll_id_es
		select id_esercizio into :ll_id_es from esercizio 
		where data_inizio<=:ld_data_reg and data_fine>=:ld_data_reg;
		lu_reg_pd.uf_id_esercizio(ll_id_es)
		
		
		ll_id_conto_mc[1]   = il_id_conto
		IF is_segno = LCS_DARE THEN
			lc_segno_mc[1] = LCS_AVERE
		ELSE
			lc_segno_mc[1] = LCS_DARE
		END IF	
		ldc_importo_mc[1]   = ldc_contanti
		ll_id_par_aperta[1] = il_id_par_aperta
		lb_mc_iva[1]        = FALSE
		
		ll_id_conto_mc[2] = 0
	
		lc_segno_mc[2]      = is_segno
		ldc_importo_mc[2]   = ldc_contanti
		SetNull(ll_id_par_aperta[2])
		lb_mc_iva[2]        = FALSE
		
		lu_reg_pd.uf_id_conto_mc(ll_id_conto_mc)
		lu_reg_pd.uf_segno_mc(lc_segno_mc)
		lu_reg_pd.uf_importo_mc(ldc_importo_mc)
		lu_reg_pd.uf_id_par_aperta(ll_id_par_aperta)
		lu_reg_pd.uf_crea_mov_partita(TRUE)
		lu_reg_pd.uf_mc_iva(lb_mc_iva)
		
		ll_RetVal1 = lu_reg_pd.uf_crea()
	END IF
END IF

IF (ldc_differenza > 0) AND (ll_id_con_pag > 0) THEN
	
		ll_num_scadenze = 0
		SELECT Count(*),
				 documento.id_documento
			INTO :ll_num_scadenze,
				  :ll_id_documento
			FROM dba.scadenza,
				  dba.documento
			WHERE (documento.id_documento = scadenza.id_documento) AND
					(documento.id_registro = :il_id_registro) AND
					(documento.num_progressivo = :il_num_progressivo) AND
					(documento.data_registrazione = :id_data_reg_pd)
			GROUP BY documento.id_documento
			USING SQLCA ;
		
		IF ll_num_scadenze = 0 THEN
			
         
			ldc_differenza2 = idc_tot_imposta - ldc_contanti - idc_par_avere

		
			CHOOSE CASE ldc_differenza2
				CASE IS > 0
					ldc_imponibile = idc_tot_imponibile
					ldc_imposta = ldc_differenza2
				CASE IS < 0
					ldc_imponibile = ldc_saldo - ldc_contanti
					
					
					ldc_imposta = 0
				CASE 0
					ldc_imponibile = idc_tot_imponibile
					ldc_imposta = 0			
			END CHOOSE
			
			
			  SELECT anagrafica.id_anagrafica,
						sog_commerciale.id_sog_commerciale,
						sog_commerciale.id_banca_sog_commerciale,
						sog_commerciale.scad_raggruppate
				 INTO :ll_id_anagrafica,
						:ll_id_sog_commerciale,
						:ll_id_banca_sog_commerciale,
						:lc_scad_raggruppate
				 FROM dba.anagrafica,   
						dba.conto,   
						dba.sog_commerciale  
				WHERE ( sog_commerciale.id_conto = conto.id_conto ) and  
						( sog_commerciale.id_anagrafica = anagrafica.id_anagrafica ) and  
						( conto.id_conto = :il_id_conto )
				USING SQLCA ;
						
		
			CHOOSE CASE SQLCA.SQLCode
				CASE 100
					MessageBox("Riscossioni e Pagamenti", "Impossibile generare le scadenze: il conto selezionato~rnella registrazione non è collegato ad un Soggetto Commerciale.")
					RETURN 0
				CASE -1
					MessageBox("Errore sul DataBase", "w_pag_riscossioni_wz / ue_genera / 1")
					RETURN 0
			END CHOOSE
			
			IF IsNull(lc_scad_raggruppate) THEN lc_scad_raggruppate = 'N'
			
			
			  SELECT "azienda"."id_banca_azienda"  
				 INTO :ll_id_banca_azienda  
				 FROM "azienda"  
				WHERE "azienda"."id_azienda" in (0, 1)   ;
		
			CHOOSE CASE SQLCA.SQLCode
				CASE -1
					MessageBox("Errore sul DataBase", "w_pag_riscossioni_wz / ue_genera / 2")
					RETURN 0
			END CHOOSE
		
			
			
			
			// occorre modificare opportunamente la data documento per far calcolare la scadenza correttamente (Fat. Elettronica)
//			lb_ok = iuo_pag.uf_calcola_pagamenti_e(il_id_valuta,ldc_imponibile,    &
//															 ldc_imposta,       &
//															 id_data_documento, &														
//															 ll_id_anagrafica,  &
//															 ll_id_con_pag,     &
//															 lstr_scadenze)			

//	sotto qui prima c'era  // id_data_competenza, &		invece di 	 id_data_documento, &	20210924
			
			lb_ok = iuo_pag.uf_calcola_pagamenti_e(il_id_valuta,ldc_imponibile,    &
															 ldc_imposta,       &
															 id_data_documento, &                      												
															 ll_id_anagrafica,  &
															 ll_id_con_pag,     &
															 lstr_scadenze)															 
			
																																				
			
			
			
			char lc_tipo_fat
			
			select tipo_fattura
			into :lc_tipo_fat
			from prof_registrazione
			where id_prof_registrazione = :ll_id_prof_reg;
			
			
			IF is_segno= LCS_DARE THEN
				lc_tipo_scadenza = LCC_ATTIVA
				if lc_tipo_fat = 'C' then lc_tipo_scadenza = LCC_PASSIVA 
			ELSEIF is_segno= LCS_AVERE THEN
				lc_tipo_scadenza = LCC_PASSIVA
				if lc_tipo_fat = 'C' then lc_tipo_scadenza = LCC_ATTIVA 
			END IF
			
			li_size = upperbound(lstr_scadenze.dc_imp_out)
			
			FOR li_i = 1 TO li_size
				
				ldc_tot_importo = lstr_scadenze.dc_imp_out[li_i] + &
										lstr_scadenze.dc_iva_out[li_i]
		
		      
				
				ldc_tot_importo_valuta = ldc_tot_importo
				
            
				
				
															
				ll_id_scadenza = f_crea_scadenza(lc_tipo_scadenza,                        &
															ll_id_sog_commerciale,                   &
															lstr_scadenze.d_date[li_i],              &
															il_id_valuta,                            &
															id_cambio,                               &       
															ldc_tot_importo_valuta,                  &
															ldc_tot_importo, 								  &
															lstr_scadenze.l_id_tipo_pagamento[li_i], &
															ll_id_banca_azienda,                     &
															ll_id_banca_sog_commerciale,             &
															u_freddie.gs_NULL,                       &
															u_freddie.gs_NULL,                       &
															u_freddie.gs_NULL,                       &
															u_freddie.gs_NULL,                       &
															u_freddie.gs_NULL,                       &
															u_freddie.gs_NULL,                       &
															u_freddie.gs_NULL,                       &
															u_freddie.gd_NULL,                       &
															LCC_DEFINITIVA,                          &
															u_freddie.gd_NULL,                       &
															LCC_EMESSO,                              &
															lc_scad_raggruppate,                     &
															u_freddie.gl_NULL,                       &
															u_freddie.gl_NULL,                       &
															il_id_par_aperta,                        &
															u_freddie.gl_NULL,                       &
															u_freddie.gl_NULL,                       &
															LCL_ID_AZIENDA)
		
				IF ll_id_scadenza > 0 THEN lb_scad_generate = TRUE
			NEXT
			IF lb_scad_generate = TRUE THEN
				
				
											  
				
				
					las_param[1] = string(il_id_par_aperta)
					u_freddie.sp_clear()
					u_freddie.sp_push(las_param)
					OpenWithParm(w_par_aperta_scadenza_lt, lstr_list_main)
				
				
		
			END IF
		ELSE
			SQLCA.sp_Aggiorna_Scadenze(ll_id_documento, il_id_reg_pd)
			MessageBox(THIS.title, "Il documento che si sta contabilizzando ha già delle scadenze.~rQueste sono state collegate alla partita numero:" + trim(is_num_documento) + " del " + string(id_data_documento, "dd/mm/yyyy") + ".")
		END IF
	
END IF

RETURN 0
end function

public subroutine uf_setta_format (long il_valuta);

string ls_format, LS_EDIT


LS_FORMAT = F_VALU_MASK(il_valuta)
LS_EDIT = F_VALU_EDIT(il_valuta)
dw_pag_riscossioni_ff.MODIFY("PAR_DARE.EDIT.FORMAT ='"+ ls_edit+"'")
dw_pag_riscossioni_ff.MODIFY("PAR_DARE.FORMAT ='"+ ls_format+"'")
dw_pag_riscossioni_ff.MODIFY("PAR_AVERE.EDIT.FORMAT ='"+ ls_edit+"'")
dw_pag_riscossioni_ff.MODIFY("PAR_AVERE.FORMAT ='"+ ls_format+"'")
dw_pag_riscossioni_ff.MODIFY("IMP_CONTANTI.EDIT.FORMAT ='"+ ls_edit+"'")
dw_pag_riscossioni_ff.MODIFY("IMP_CONTANTI.FORMAT ='"+ ls_format+"'")
dw_pag_riscossioni_ff.MODIFY("PAR_SALDO.FORMAT ='"+ ls_format+"'")
dw_pag_riscossioni_ff.MODIFY("IMP_RESIDUO.FORMAT ='"+ ls_format+"'")
end subroutine

on w_pag_riscossioni_wz.create
int iCurrent
call super::create
this.dw_pag_riscossioni_ff=create dw_pag_riscossioni_ff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pag_riscossioni_ff
end on

on w_pag_riscossioni_wz.destroy
call super::destroy
destroy(this.dw_pag_riscossioni_ff)
end on

event open;call super::open;

string las_array[]
constant char lcc_separatore = "@"
long ll_pos_separatore
u_freddie.sp_pop(las_array)

ib_AskForSave = FALSE
dw_pag_riscossioni_ff.ib_allow_update = FALSE

idw_master = dw_pag_riscossioni_ff
idw_master.is_list = Message.PowerObjectParm

iuo_pag = Create uo_esp_pag

is_tag = las_array[1]
is_info_reg_pd = las_array[2]
is_info_sc = las_array[3]
idc_par_dare = dec(las_array[4])
idc_par_avere = dec(las_array[5])
il_id_esercizio = long(las_array[6])
il_id_conto = long(las_array[7])
is_segno = las_array[8]

ll_pos_separatore = Pos(las_array[9], lcc_separatore)
il_id_par_aperta = long(left(las_array[9], (ll_pos_separatore - 1)))
il_id_reg_pd = long(right(las_array[9], len(las_array[9]) - ll_pos_separatore))

  SELECT reg_pd.data_registrazione,   
         reg_pd.data_documento,   
			reg_pd.num_progressivo,
			reg_pd.num_documento,
         reg_pd.cambio,
			reg_pd.id_registro,
			reg_pd.data_competenza
    INTO :id_data_reg_pd,   
         :id_data_documento,   
			:il_num_progressivo,
			:is_num_documento,
         :idc_cambio,
			:il_id_registro,
			:id_data_competenza
    FROM dba.reg_pd  
   WHERE reg_pd.id_reg_pd = :il_id_reg_pd   ;

select e.id_valuta into :il_id_valuta from esercizio e , registro r 
where e.id_esercizio=r.id_esercizio and r.id_registro=:il_id_registro;
select cambio into :id_cambio from valuta where id_valuta=:il_id_valuta;

CHOOSE CASE SQLCA.SQLCode
	CASE -1
		MessageBox("Errore sul DataBase", "w_pag_riscossioni_wz / open / 1")
END CHOOSE

ll_pos_separatore = Pos(las_array[10], lcc_separatore)
idc_tot_imponibile = dec(left(las_array[10], (ll_pos_separatore - 1)))
idc_tot_imposta = dec(right(las_array[10], len(las_array[10]) - ll_pos_separatore))

ib_NonModale = FALSE
end event

event ue_post_open;call super::ue_post_open;
long ll_CurrRow

UF_SETTA_FORMAT(il_id_valuta)

ll_CurrRow = dw_pag_riscossioni_ff.GetRow()

IF ll_CurrRow = 0 OR IsNull(ll_CurrRow) THEN dw_pag_riscossioni_ff.InsertRow(0)

dw_pag_riscossioni_ff.SetItem(1, "info_reg_pd", is_info_reg_pd)
dw_pag_riscossioni_ff.SetItem(1, "info_sc", is_info_sc)
dw_pag_riscossioni_ff.SetItem(1, "par_dare", idc_par_dare)
dw_pag_riscossioni_ff.SetItem(1, "par_avere", idc_par_avere)
dw_pag_riscossioni_ff.SetItem(1, "imp_contanti", idc_par_dare - idc_par_avere)



end event

event closequery;

RETURN 0

end event

type p_msg_log from w_p_data`p_msg_log within w_pag_riscossioni_wz
end type

type p_crescente from w_p_data`p_crescente within w_pag_riscossioni_wz
end type

type p_decrescente from w_p_data`p_decrescente within w_pag_riscossioni_wz
end type

type cb_ok from w_p_data`cb_ok within w_pag_riscossioni_wz
integer taborder = 20
boolean default = true
end type

event cb_ok::clicked;

long ll_RetVal
integer li_RetVal

IF uf_genera() = 0 THEN
	ll_RetVal = Super::Event Clicked()
	RETURN ll_RetVal 
END IF
end event

type cb_annulla from w_p_data`cb_annulla within w_pag_riscossioni_wz
integer taborder = 40
boolean cancel = true
end type

type cb_nuovo from w_p_data`cb_nuovo within w_pag_riscossioni_wz
boolean visible = false
boolean enabled = false
end type

type cb_inserisci from w_p_data`cb_inserisci within w_pag_riscossioni_wz
boolean visible = false
boolean enabled = false
end type

type cb_cancella from w_p_data`cb_cancella within w_pag_riscossioni_wz
boolean visible = false
boolean enabled = false
end type

type cb_salva from w_p_data`cb_salva within w_pag_riscossioni_wz
boolean visible = false
boolean enabled = false
end type

type tab_1 from w_p_data`tab_1 within w_pag_riscossioni_wz
boolean visible = false
integer x = 1097
integer y = 40
integer width = 251
integer height = 120
integer taborder = 30
boolean enabled = false
long backcolor = 79741120
end type

type tabpage_1 from w_p_data`tabpage_1 within tab_1
integer width = 215
integer height = 0
end type

type cb_ricerca from w_p_data`cb_ricerca within w_pag_riscossioni_wz
end type

type dw_pag_riscossioni_ff from u_dw_master_main within w_pag_riscossioni_wz
event type long ue_abilita_controlli ( decimal adc_imp_contanti )
integer x = 46
integer y = 160
integer width = 2706
integer height = 1212
integer taborder = 10
string dataobject = "d_pag_riscossioni_ff"
end type

event ue_abilita_controlli;call super::ue_abilita_controlli;

decimal ldc_saldo, ldc_differenza

ldc_saldo = THIS.uf_GetItemDecimal(1, "par_saldo")
ldc_differenza = ldc_saldo - adc_imp_contanti

CHOOSE CASE ldc_differenza
	CASE 0 
		Parent.uf_displayonly(THIS, "data_reg_pd", FALSE)
		Parent.uf_displayonly(THIS, "prof_registrazione_cod", FALSE)
		Parent.uf_displayonly(THIS, "prof_registrazione_des", FALSE)
		Parent.uf_displayonly(THIS, "con_pagamento_cod", TRUE)
		Parent.uf_displayonly(THIS, "con_pagamento_des", TRUE)
		RETURN 0		
	CASE ldc_saldo 
		Parent.uf_displayonly(THIS, "data_reg_pd", TRUE)
		Parent.uf_displayonly(THIS, "prof_registrazione_cod", TRUE)
		Parent.uf_displayonly(THIS, "prof_registrazione_des", TRUE)
		Parent.uf_displayonly(THIS, "con_pagamento_cod", FALSE)
		Parent.uf_displayonly(THIS, "con_pagamento_des", FALSE)
		RETURN 0		
	CASE IS > 0 
		Parent.uf_displayonly(THIS, "data_reg_pd", FALSE)
		Parent.uf_displayonly(THIS, "prof_registrazione_cod", FALSE)
		Parent.uf_displayonly(THIS, "prof_registrazione_des", FALSE)
		Parent.uf_displayonly(THIS, "con_pagamento_cod", FALSE)
		Parent.uf_displayonly(THIS, "con_pagamento_des", FALSE)		
		RETURN 0
	CASE IS < 0 
		
		RETURN 1
	CASE ELSE
		RETURN 0
END CHOOSE
end event

event ue_default;call super::ue_default;

long ll_CurrRow, ll_id_con_pagamento
decimal ldc_imp_saldo
string ls_con_pagamento_cod, ls_con_pagamento_des

CHOOSE CASE adwo_current.name
	CASE "imp_contanti"
		ldc_imp_saldo = THIS.uf_GetItemDecimal(1, "par_saldo")
		THIS.SetItem(1, "imp_contanti", ldc_imp_saldo)
	CASE "data_reg_pd"
		THIS.SetItem(1, "data_reg_pd", id_data_reg_pd)
	CASE "con_pagamento_cod"
		SELECT "dba"."con_pagamento"."id_con_pagamento",   
				 "dba"."con_pagamento"."codice",   
				 "dba"."con_pagamento"."descrizione"  
			INTO :ll_id_con_pagamento,   
				  :ls_con_pagamento_cod,   
				  :ls_con_pagamento_des
			FROM "dba"."sog_commerciale",   
				  "dba"."con_pagamento"  
			WHERE ( "dba"."con_pagamento"."id_con_pagamento" = "dba"."sog_commerciale"."id_con_pagamento" ) AND
					( "dba"."sog_commerciale"."id_conto" = :il_id_conto) ;

		CHOOSE CASE SQLCA.SQLCode
			CASE 0
				THIS.SetItem(1, "id_con_pagamento", ll_id_con_pagamento)
				THIS.SetItem(1, "con_pagamento_cod", ls_con_pagamento_cod)
				THIS.SetItem(1, "con_pagamento_des", ls_con_pagamento_des)
			CASE -1
				MessageBox("Errore sul DataBase","w_pag_riscossioni_wz / dw_pag_riscossioni_ff::ue_default / 1")
		END CHOOSE

END CHOOSE

end event

event ue_set_search;call super::ue_set_search;

CHOOSE CASE as_nomecol
	CASE "prof_registrazione_cod"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "prof_registrazione.usa_pagamenti = 'S'"
	CASE "prof_registrazione_des"
		is_search_window = "w_prof_registrazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
		is_ricpar.b_imm_retrieve = TRUE
		is_ricpar.s_SQL_cond = "prof_registrazione.usa_pagamenti = 'S'"		
	CASE "con_pagamento_cod"
		is_search_window = "w_con_pagamento_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
		is_ricpar.b_imm_retrieve = TRUE
		
	CASE "con_pagamento_des"
		is_search_window = "w_con_pagamento_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
		is_ricpar.b_imm_retrieve = TRUE
		
END CHOOSE

end event

event ue_use_search;call super::ue_use_search;


CHOOSE CASE as_nomecol
	CASE "prof_registrazione_cod"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_des", is_ricpar.s_ausil_value[1])		
	CASE "prof_registrazione_des"
		uf_set_colval("id_prof_registrazione", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("prof_registrazione_cod", is_ricpar.s_ausil_value[1])				
	CASE "con_pagamento_cod"
		uf_set_colval("id_con_pagamento", is_ricpar.s_id_seg_value[1])				
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("con_pagamento_des", is_ricpar.s_ausil_value[1])
	CASE "con_pagamento_des"
		uf_set_colval("id_con_pagamento", is_ricpar.s_id_seg_value[1])						
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("con_pagamento_cod", is_ricpar.s_ausil_value[1])		
END CHOOSE

end event

event itemchanged;call super::itemchanged;

long ll_RetVal, ll_id_esercizio
date ld_data_reg_pd

CHOOSE CASE dwo.name
	CASE "imp_contanti"
		ll_RetVal = Event ue_abilita_controlli(dec(data))
		RETURN ll_RetVal
	CASE "prof_registrazione_cod", "prof_registrazione_des"
		uf_SW_SetNull(data, "id_prof_registrazione")
	CASE "con_pagamento_cod", "con_pagamento_des"
		uf_SW_SetNull(data, "id_con_pagamento")		
	CASE "data_reg_pd"
		
		ld_data_reg_pd = date(data)
		  SELECT "esercizio"."id_esercizio"  
			 INTO :ll_id_esercizio  
			 FROM "esercizio"  
			WHERE ( "esercizio"."data_inizio" <= :ld_data_reg_pd ) AND  
					( "esercizio"."data_fine" >= :ld_data_reg_pd )  AND
					( "esercizio"."id_esercizio" = :il_id_esercizio ) ;

		CHOOSE CASE SQLCA.SQLCode
			CASE 100
				MessageBox("Riscossioni e Pagamenti", "Attenzione: ")
		END CHOOSE

END CHOOSE

end event

event ue_init;call super::ue_init;is_title = "Riscossioni e Pagamenti"
end event

event itemfocuschanged;

long ll_RetVal
decimal ldc_contanti

CHOOSE CASE is_item_precedente
	CASE "imp_contanti"
		ldc_contanti = THIS.uf_GetItemDecimal(1, "imp_contanti")
		ll_RetVal = Event ue_abilita_controlli(ldc_contanti)
		
END CHOOSE

is_item_precedente = dwo.name

ll_RetVal = Super::Event ItemFocusChanged(row, dwo)
RETURN ll_RetVal 


end event

event retrieveend;call super::retrieveend;

is_item_precedente = "imp_contanti"
end event

