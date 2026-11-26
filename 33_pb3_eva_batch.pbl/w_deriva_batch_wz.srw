forward
global type w_deriva_batch_wz from window
end type
type cbx_st_errors from checkbox within w_deriva_batch_wz
end type
type cbx_st_rp_prova from checkbox within w_deriva_batch_wz
end type
type cb_procedi from commandbutton within w_deriva_batch_wz
end type
type cb_anomalie from commandbutton within w_deriva_batch_wz
end type
type cb_report from commandbutton within w_deriva_batch_wz
end type
type cb_genera from commandbutton within w_deriva_batch_wz
end type
type tab_1 from tab within w_deriva_batch_wz
end type
type tabpage_1 from userobject within tab_1
end type
type cb_scelta_prof from commandbutton within tabpage_1
end type
type dw_scelta from u_dw_ext_main within tabpage_1
end type
type dw_testa_wrk from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_scelta_prof cb_scelta_prof
dw_scelta dw_scelta
dw_testa_wrk dw_testa_wrk
end type
type tabpage_6 from userobject within tab_1
end type
type cb_remove_all from commandbutton within tabpage_6
end type
type cb_remove_many from commandbutton within tabpage_6
end type
type cb_drop_many from commandbutton within tabpage_6
end type
type cb_drop_all from commandbutton within tabpage_6
end type
type dw_selezionati_lt from u_dw_pura within tabpage_6
end type
type dw_recuperati_lt from u_dw_pura within tabpage_6
end type
type tabpage_6 from userobject within tab_1
cb_remove_all cb_remove_all
cb_remove_many cb_remove_many
cb_drop_many cb_drop_many
cb_drop_all cb_drop_all
dw_selezionati_lt dw_selezionati_lt
dw_recuperati_lt dw_recuperati_lt
end type
type tabpage_2 from userobject within tab_1
end type
type dw_anom_rpt from datawindow within tabpage_2
end type
type dw_errori from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_anom_rpt dw_anom_rpt
dw_errori dw_errori
end type
type tabpage_3 from userobject within tab_1
end type
type dw_cpt_wrk from datawindow within tabpage_3
end type
type dw_scad_wrk from datawindow within tabpage_3
end type
type dw_iva_wrk from datawindow within tabpage_3
end type
type dw_spese_wrk from datawindow within tabpage_3
end type
type dw_docs from datawindow within tabpage_3
end type
type dw_sc from datawindow within tabpage_3
end type
type dw_r2 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_cpt_wrk dw_cpt_wrk
dw_scad_wrk dw_scad_wrk
dw_iva_wrk dw_iva_wrk
dw_spese_wrk dw_spese_wrk
dw_docs dw_docs
dw_sc dw_sc
dw_r2 dw_r2
end type
type tabpage_4 from userobject within tab_1
end type
type mle_report from multilineedit within tabpage_4
end type
type dw_testrighe from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
mle_report mle_report
dw_testrighe dw_testrighe
end type
type tabpage_5 from userobject within tab_1
end type
type cb_stampa_lis_fat from commandbutton within tabpage_5
end type
type dw_fat_gen from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
cb_stampa_lis_fat cb_stampa_lis_fat
dw_fat_gen dw_fat_gen
end type
type tab_1 from tab within w_deriva_batch_wz
tabpage_1 tabpage_1
tabpage_6 tabpage_6
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
type cb_annulla from commandbutton within w_deriva_batch_wz
end type
end forward

global type w_deriva_batch_wz from window
integer x = 1074
integer y = 492
integer width = 2825
integer height = 1776
boolean titlebar = true
string title = "Evasione automatica documenti"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
cbx_st_errors cbx_st_errors
cbx_st_rp_prova cbx_st_rp_prova
cb_procedi cb_procedi
cb_anomalie cb_anomalie
cb_report cb_report
cb_genera cb_genera
tab_1 tab_1
cb_annulla cb_annulla
end type
global w_deriva_batch_wz w_deriva_batch_wz

type variables
multilineedit	imle_rep

u_sql_scanner	iuo_scan
uo_esp_pag	iuo_pag

u_ds_main	ids_rows, ids_docs, ids_r2, ids_derp
u_ds_main	ids_sc, ids_testa, ids_spese, ids_riga
u_ds_main	ids_iva, ids_scad, ids_cpt

u_dw_ext_main	idw_scelta
datawindow	idw_errori, idw_r2, idw_docs, idw_sc
datawindow	idw_testr, idw_anom_rpt
datawindow	idw_spese, idw_scad, idw_iva, idw_cpt

long	il_az_idcontoprd	
long	il_az_idspesabol	
long	il_az_idivaart15	
long	il_az_idvalu	
long	il_az_arrot	
string	is_az_tipoarr	
decimal	idc_az_cambio	
long	il_az_idaz		


long	il_ch_exrow	
date	id_ch_iniz		
date	id_ch_fine	
date	id_ch_reg		
long	il_ch_idsc		
long	il_ch_iddest	
long	il_ch_idsc2	
long	il_ch_idmag	
long	il_ch_idccsc	
long	il_ch_idczon	
long	il_ch_idcatt	
long	il_ch_idvett	
long	il_ch_idgrag	
long	il_ch_idcpag	
string	is_ch_rtdest	
string	is_ch_rcforz	
string	is_ch_opdef	
long	il_ch_idprof	
string	is_ch_spgest	
string	is_ch_intfat	
string	is_ch_ricchg	
string	is_ch_codsc1	
string	is_ch_codsc2	
string       is_per_fatturazione   

long		il_rt_dest, il_rt_odest	
long		il_rt_valu, il_rt_ovalu	
long		il_rt_cpag, il_rt_ocpag	
string		is_rt_scfi, is_rt_oscfi	
decimal		idc_rt_scca, idc_rt_oscca	
long		il_rt_bapp, il_rt_obapp	
long		il_rt_docu, il_rt_odocu	
long		il_rt_arrvalu	
string	is_rt_tiparrvalu	
long		il_rt_scom

decimal		id_rt_imp_acconto, id_rt_oimp_acconto
long		il_rt_id_tipo_pag_acconto, il_rt_oid_tipo_pag_acconto
long		il_rt_id_tab_iva_acconto, il_rt_oid_tab_iva_acconto
long		il_rt_id_val_acconto, il_rt_oid_val_acconto
decimal		id_tot_acconto




long				il_rowtesta

string			is_sql_cond

boolean			ib_servepiede
string			is_mfa, is_statoscgen

long		il_td_ideser	
long		il_td_idregi	
long		il_td_idcmag	
long		il_td_idmag	
long		il_td_idmag2	
long		il_td_idl1	
long		il_td_idl2	
long		il_td_idlis	
long		il_td_idprr	
string		is_td_tiporeg	
string		is_td_descon	
decimal		idc_td_cambio	
string		is_td_note	

long				il_sc_idl1, il_sc_idl2, il_sc_idtt
long				il_sc_idlis, il_sc_idvet, il_sc_idconto

string  is_sql_originale

long il_num_fat, il_oid_gruppo_agenti,  il_id_agente, il_siamo_nell_orafo

long il_id_agente_2
decimal idc_old_td_cambio

//string is_pancali
long il_id_cat_imb
DATASTORE ds_eva_imb_app

long il_dec_significativi
string is_tipo_arr
end variables

forward prototypes
public function long wf_retrieve_1 ()
public function long wf_check_sel ()
public function long wf_ask_conf (long al_riga)
public function long wf_check_r2 ()
public function long wf_elab_sc (boolean ab_definitiva, long al_scrow)
public subroutine wf_set_ini_sc (long al_idsc)
public function boolean wf_check_break_doc ()
public function long wf_check_righe ()
public function long wf_elab_tutto (boolean ab_definitiva, string as_dummy)
public subroutine wf_get_riga_doc (long al_row)
public function long wf_ragg_sc ()
public function integer wf_totalizza_doc ()
public function integer wf_set_riga_arr (long al_r1)
public function integer wf_set_testa (long al_scrow)
public function long wf_insert_errori (long al_row, long al_rig, string as_err)
public function integer wf_set_istanze ()
public function integer wf_calc_righe_cast ()
public function decimal wf_calc_prezzo_riga (string as_sconto, decimal ad_prezzo, decimal ad_quant)
public function integer wf_calc_sconti_cast ()
public function decimal wf_round (decimal ad_numero, long al_arro, string as_tipo_arr)
public function long wf_get_imp_max ()
public function long wf_get_ali_max ()
public function integer wf_calc_sp_noiva_cast ()
public function integer wf_calc_sp_iva_cast ()
public function decimal wf_calc_bolli_sc_cast ()
public subroutine wf_setta_incasso ()
public function decimal wf_calc_bollo_cast ()
public subroutine wf_calc_sp_bollo_cast ()
public function long wf_del_spese_nulle ()
public function long wf_setup_cast_iva (long al_riga)
public function decimal wf_genera_scadenze ()
public function boolean wf_calc_cpt ()
public function integer wf_calc_cpt_righe ()
public subroutine wf_calc_cpt_sconti ()
public subroutine wf_calc_cpt_spese ()
public function integer wf_calc_cpt_totali ()
public function long wf_calc_finali ()
public function integer wf_insert_rigaok (long al_row, long al_riga, long al_cauder, long al_cpt, string as_descr)
public function long wf_calc_piede_doc (long al_row, boolean ab_definitiva)
public function boolean wf_salva_documento ()
public function integer wf_insert_riga_cpt (long al_idcpt, string as_tipo, u_ds_main ads_cpt, decimal ad_imponibile, decimal ad_impscontato, decimal ad_omaggism, decimal ad_spese)
public function integer wf_insert_riga_iva (long al_idtabiva, decimal ad_aliquota, decimal ad_perdetra, decimal ad_imponibile, decimal ad_imposta, decimal ad_omaggism, u_ds_main ads_cast)
public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_filtro_agg, string as_col_dest)
public subroutine wf_setta_colonna (datawindow adw_dw, string as_colonna, long al_riga, string as_valore)
public subroutine wf_calcola_spese ()
public subroutine wf_calc_cpt_quadra ()
public subroutine wf_calc_cpt_ripul ()
public subroutine wf_applica_acconto ()
public function integer wf_calc_arrotondamento ()
end prototypes

public function long wf_retrieve_1 ();
string		ls_sql, ls_campo1, ls_data1
long		   ll_rows, ll_id_prof_iniziale
long			ll_id_prof_iniz,ll_id_con_pag
integer   	li_profili_scelti, i
long			ll_id_tipo_pagamento	

ll_id_prof_iniz		= tab_1.tabpage_1.dw_scelta.GetItemNumber( 1,"id_pro_iniz" )
ll_id_con_pag			= tab_1.tabpage_1.dw_scelta.GetItemNumber( 1,"id_cpag" )
ls_sql = ""
if not isNull(id_ch_iniz) then
	ls_data1 = string(id_ch_iniz,"yyyy-mm-dd")
	ls_sql = ls_sql+" AND (documento.data_registrazione >= '"+ls_data1+"')"
end if
if not isNull(id_ch_fine) then
	ls_data1 = string(id_ch_fine,"yyyy-mm-dd")
	ls_sql = ls_sql+" AND (documento.data_registrazione <= '"+ls_data1+"')"
end if



ls_campo1 = "sog_commerciale_gen.codice"
if is_ch_intfat="S" then
	ls_sql = ls_sql + "AND (documento.id_sog_commerciale_fattura = sog_commerciale_gen.id_sog_commerciale)"
	if not IsNull(il_ch_idsc) then
		ls_sql = ls_sql +" AND ("+ls_campo1+" >= '"+ is_ch_codsc1 +"')"
	end if
	if not IsNull(il_ch_idsc2) then
		ls_sql = ls_sql +" AND ("+ls_campo1+" <= '"+ is_ch_codsc2 +"')"
	end if
else
	ls_sql = ls_sql + "AND (documento.id_sog_commerciale = sog_commerciale_gen.id_sog_commerciale)"
	if not IsNull (il_ch_iddest) then
		if is_ch_codsc1>"" then
			ls_sql = ls_sql +" AND ("+ls_campo1+" = '"+ is_ch_codsc1 +"')"
		end if
		ls_sql = ls_sql +" AND (documento.id_destinazione = "+string(il_ch_iddest)+")"
	else
		if is_ch_codsc1>"" then
			ls_sql = ls_sql +" AND ("+ls_campo1+" >= '"+ is_ch_codsc1 +"')"
		end if
		if is_ch_codsc2>"" then
			ls_sql = ls_sql +" AND ("+ls_campo1+" <= '"+ is_ch_codsc2 +"')"
		end if
	end if
end if


if not isNull (il_ch_idccsc) then
	ls_sql = ls_sql+" AND (sog_commerciale.id_cat_com_sc= "+string(il_ch_idccsc)+")"
end if
if not isNull (il_ch_idczon) then
	ls_sql = ls_sql+" AND (sog_commerciale.id_cat_zona= "+string(il_ch_idczon)+")"
end if
if not isNull (il_ch_idcatt) then
	ls_sql = ls_sql+" AND (sog_commerciale.id_cat_attivita= "+string(il_ch_idcatt)+")"
end if

if not isNull (is_per_fatturazione) then
	ls_sql = ls_sql+" AND (sog_commerciale.per_fatturazione= '"+is_per_fatturazione+"')"
end if


if not isNull (il_ch_idmag) then
	ls_sql = ls_sql+" AND (documento.id_magazzino = "+string(il_ch_idmag)+")"
end if

li_profili_scelti=tab_1.tabpage_6.dw_selezionati_lt.rowcount()
ls_sql = ls_sql + " AND (documento.id_prof_documento = der_profilo.id_prof_documento_padre)"
if li_profili_scelti>0 then
	ll_id_prof_iniziale=tab_1.tabpage_6.dw_selezionati_lt.getitemnumber(1, "id_prof_documento_padre")
	if li_profili_scelti=1 then
		ls_sql = ls_sql + " AND (der_profilo.id_prof_documento_padre = "+string(ll_id_prof_iniziale)+")"
	else
		ls_sql = ls_sql + " AND ((der_profilo.id_prof_documento_padre = "+string(ll_id_prof_iniziale)+")"
	end if
	for i = 2 to li_profili_scelti
		ll_id_prof_iniziale=tab_1.tabpage_6.dw_selezionati_lt.getitemnumber(i, "id_prof_documento_padre")
		if i=li_profili_scelti then
			ls_sql = ls_sql + " OR (der_profilo.id_prof_documento_padre = "+string(ll_id_prof_iniziale)+"))"
		else
			ls_sql = ls_sql + " OR (der_profilo.id_prof_documento_padre = "+string(ll_id_prof_iniziale)+")"
		end if
	next
else
	ls_sql = ls_sql + " AND (der_profilo.id_prof_documento_derivato = "+string(il_ch_idprof)+")"
	if not isNull(ll_id_prof_iniz) then
		ls_sql = ls_sql + " AND (der_profilo.id_prof_documento_padre = "+string(ll_id_prof_iniz)+")"
	end if
end if



ls_sql = ls_sql + " AND (documento.bloccato <> 'S' OR documento.bloccato IS NULL) AND (documento.evaso_totalmente <> 'S' OR documento.evaso_totalmente IS NULL)"
ls_sql = ls_sql + " AND (documento.chius_forzata <> 'S' OR documento.chius_forzata IS NULL)"


if not isNull(ll_id_con_pag) then
	ls_sql = ls_sql + " AND (1 <= (SELECT COUNT(*) " + &
				 			" 				 FROM	  app_pagamento " + &
				 			"				 WHERE  id_tipo_pagamento = " + string(ll_id_con_pag) + &
				 			" 				 AND	  id_con_pagamento = documento.id_con_pagamento)) " 
end if


iuo_scan.f_reset_cur_as_ini()
iuo_scan.f_add_where_condition (ls_sql)
ls_sql= is_sql_originale + ls_sql

ids_docs.setsqlselect(ls_sql)

ls_sql=ids_docs.getsqlselect()

ids_docs.reset()
ll_rows = ids_docs.retrieve()

if ll_rows>0 then
	ids_derp.retrieve(il_ch_idprof)
end if


return ll_rows

end function

public function long wf_check_sel ();
long		ll_prof, ll_idvp,ll_prof_iniz,ll_id_prof_documento_derivato
long		ll_retv, ll_code, ll_id_prof_doc_derivato
string	ls_toterr
boolean  lb_trovato
long		ll_temp, ll_id_mod_registro, ll_id_m1p, ll_id_m2p
long		ll_id_l1p, ll_id_l2p	

ll_retv = 0
ls_toterr = ""

id_ch_iniz = idw_scelta.GetItemDate(il_ch_exrow,"data_inizio")
id_ch_fine = idw_scelta.GetItemDate(il_ch_exrow,"data_fine")
id_ch_reg = idw_scelta.GetItemDate(il_ch_exrow,"data_emissione")
il_ch_idsc = idw_scelta.GetItemNumber(il_ch_exrow,"id_int")
il_ch_iddest = idw_scelta.GetItemNumber(il_ch_exrow,"id_destinazione")
il_ch_idsc2 = idw_scelta.GetItemNumber(il_ch_exrow,"id_int2")
il_ch_idccsc = idw_scelta.GetItemNumber(il_ch_exrow,"id_cat_com_sc")
il_ch_idczon = idw_scelta.GetItemNumber(il_ch_exrow,"id_cat_zona")
il_ch_idcatt = idw_scelta.GetItemNumber(il_ch_exrow,"id_cat_attivita")
il_ch_idmag = idw_scelta.GetItemNumber(il_ch_exrow,"id_mag")
il_ch_idvett = idw_scelta.GetItemNumber(il_ch_exrow,"id_vett")
il_ch_idgrag = idw_scelta.GetItemNumber(il_ch_exrow,"id_grag")
il_ch_idcpag = idw_scelta.GetItemNumber(il_ch_exrow,"id_cpag")
is_ch_rtdest = idw_scelta.GetItemString(il_ch_exrow,"rottura")
is_ch_rcforz = idw_scelta.GetItemString(il_ch_exrow,"conferma")
is_ch_opdef = idw_scelta.GetItemString(il_ch_exrow,"definitiva")
is_ch_codsc1 = idw_scelta.GetItemString(il_ch_exrow,"cod_int")
if isNull (is_ch_codsc1) then is_ch_codsc1 = ""
is_ch_codsc2 = idw_scelta.GetItemString(il_ch_exrow,"cod_int2")
if isNull (is_ch_codsc2) then is_ch_codsc2 = ""
is_per_fatturazione=idw_scelta.GetItemString(il_ch_exrow,"per_fatturazione")


if isNull (id_ch_fine) then
	id_ch_fine = today()
	idw_scelta.setItem(il_ch_exrow,"data_fine",id_ch_fine)
end if
if isNull (id_ch_reg) then
	id_ch_reg = today()
	idw_scelta.setItem(il_ch_exrow,"data_fine",id_ch_reg)
end if




ll_prof = idw_scelta.GetItemNumber(il_ch_exrow,"id_pro")
if isNull(ll_prof) or ll_prof=0 then
	ls_toterr += "Manca il profilo documento nella finestra di scelta.~r"
	ll_retv ++
	il_ch_idprof = 0
else
	il_ch_idprof = ll_prof
end if

if not isNull (id_ch_iniz) then
	if (id_ch_fine<id_ch_iniz) then
		ls_toterr += "Le date di inizio e fine non sono ordinate correttamente.~r"
		ll_retv ++
	end if
end if
if (id_ch_reg<id_ch_fine) then
	ls_toterr += "La data di evasione deve essere posteriore a quella dei documenti evasi.~r"
	ll_retv ++
end if

if (not isNull(is_ch_codsc1)) and (not isNull(is_ch_codsc2)) &
	and (is_ch_codsc1>"") and (is_ch_codsc2>"") then
	if is_ch_codsc1 > is_ch_codsc2 then
		ls_toterr += "La selezione per gli intestatari non è coerente.~r"
		ll_retv++
	end if
end if

ll_prof_iniz	= idw_scelta.GetItemNumber(il_ch_exrow,"id_pro_iniz")
if not isNull(ll_prof_iniz) then
	select der_profilo.id_prof_documento_derivato
	into :ll_id_prof_doc_derivato
	from der_profilo
	where der_profilo.id_prof_documento_padre = :ll_prof_iniz
	and id_prof_documento_derivato=:ll_prof
	;
	
	if SQLCA.SQLCode <> 0 then
		ls_toterr += "Il profilo di arrivo non può essere derivato da quello di partenza.~r"
		ll_retv++
	end if
	
		
	
		
end if	


	select	prof_documento.usa_int_fattura,			prof_documento.id_caus_magazzino_prop,
				prof_documento.des_contabile,				prof_documento.id_mod_registro_prop,
				prof_documento.id_magazzino_1_prop,		prof_documento.id_magazzino_2_prop,
				prof_documento.id_lingua_prop,			prof_documento.id_linguaggio_prop,
				prof_documento.cambio_rical_der,			prof_documento.id_listino_prop,
				prof_documento.note_intestazione_prop,	prof_documento.id_prof_registrazione,
				prof_documento.spese_gestite,				prof_documento.stato_scad_generata,
				prof_documento.id_locazione_1_prop,		prof_documento.id_locazione_2_prop
						

	into		:is_ch_intfat, :il_td_idcmag, :is_td_descon, :ll_id_mod_registro, :ll_id_m1p,  :ll_id_m2p,
				:il_td_idl1,   :il_td_idl2,   :is_ch_ricchg, :il_td_idlis,        :is_td_note, :il_td_idprr,
				:is_ch_spgest, :is_statoscgen,
				:ll_id_l1p,  :ll_id_l2p
				
	from		"dba".prof_documento
	where		prof_documento.id_prof_documento = :il_ch_idprof
	using		SQLCA;
		
	ll_code = sqlca.sqlcode
	choose case ll_code
		case 100	
			ll_retv += 2
			is_ch_intfat='N'
			ls_toterr += "Profilo documento non in elenco.~r"
		case is <0 
			ll_retv += 2
			is_ch_intfat='N'
			ls_toterr += "Errore critico nel collegamento al database.~r"
			MessageBox("Attenzione!","")
	end choose
	if isNull (is_ch_intfat) then is_ch_intfat= 'N'
	if isNull (is_td_descon) then is_td_descon = ""
	if isNull (il_ch_idmag) then
		il_td_idmag = ll_id_m1p
		
		il_td_idl1  = ll_id_l1p
		il_td_idl2  = ll_id_l2p		
		
	else
		il_td_idmag = il_ch_idmag
	end if
	
	if isNull (is_ch_ricchg) then is_ch_ricchg= 'N'



	
	date ld_data_em
	ld_data_em=tab_1.tabpage_1.dw_scelta.getitemdate(1,'data_emissione')
	
	select	id_esercizio
	into	:ll_temp
	from	esercizio
	where data_inizio<=:ld_data_em and data_fine>=:ld_data_em
	using SQLCA;	
	
	
		
	
	if SQLCA.SQLCode < 0 then
		ls_toterr += "Impossibile recuperare l'esercizio.~r"
		ll_retv ++
		il_td_ideser = 0
	else
		il_td_ideser = ll_temp
	end if
	
	



	


	select Max("registro"."id_registro")
		into :ll_temp
		from "dba"."registro"  
		where ("registro"."id_esercizio" = :il_td_ideser)
			and ("registro"."id_mod_registro" = :ll_id_mod_registro)
		using SQLCA ;

	if SQLCA.SQLCode < 0 then
		ls_toterr += "Impossibile recuperare il registro.~r"
		ll_retv ++
		il_td_idregi = 0
	else
		il_td_idregi = ll_temp
	end if
	
if il_td_idregi > 0 then
	select	"registro"."tipo_registro"
		into	:is_td_tiporeg
		from	"dba"."registro"  
		where	"registro"."id_registro" = :il_td_idregi
		using	SQLCA;
end if
		


select id_valuta
into :ll_idvp
from esercizio
where id_esercizio = :il_td_ideser;

	if ll_idvp>0 then
		SELECT	"valuta"."id_valuta",	"valuta"."cambio",
					
					"valuta"."dec_significativi",	"valuta"."tipo_arrotondamento" 
			INTO	:il_az_idvalu, :idc_az_cambio, :il_az_arrot, :is_az_tipoarr
			FROM	"dba"."valuta"
			WHERE	"valuta"."id_valuta" = :ll_idvp
			USING SQLCA;
			
			if (sqlca.sqlcode = -1) then messagebox("dberror", sqlca.sqlerrtext)
	end if


if ll_retv > 0 then
	MessageBox ("Errori nel controllo parametri",ls_toterr)
end if

return ll_retv

end function

public function long wf_ask_conf (long al_riga);
 
long		ll_idrig, ll_retv

string	ls_codese,	ls_tipreg,	ls_codcli,	ls_ragsoc,	ls_codart,	ls_desart, ls_descau
long		ll_numreg,	ll_numpro,	ll_numrig
date		ld_datreg
decimal	ld_qta,		ld_prezzo

string	ls_zk, ls_cr

ll_retv = -1
ls_cr = char(13)+char(10)

if al_riga>0 then
	ll_idrig = ids_rows.GetItemNumber(al_riga,"riga_documento_id_riga_documento")
else
	ll_idrig=0
end if
if isNull (ll_idrig) then
	ll_idrig = 0
end if


if ll_idrig>0 then

	SELECT	"esercizio"."codice",					"registro"."tipo_registro",
				"registro"."numero",						"documento"."num_progressivo",
				"documento"."data_registrazione",	"sog_commerciale_gen"."codice",
				"sog_commerciale_gen"."rag_soc_1",	"riga_documento"."num_riga",
				"articolo"."codice",						"riga_documento"."descrizione",
				"caus_magazzino"."descrizione",		"riga_documento"."quantita",
				"riga_documento"."prezzo"
	
	INTO		:ls_codese, :ls_tipreg, :ll_numreg, :ll_numpro, :ld_datreg, :ls_codcli,
				:ls_ragsoc, :ll_numrig, :ls_codart, :ls_desart, :ls_descau, :ld_qta,
				:ld_prezzo
	
	FROM		"dba"."articolo",		"dba"."documento",		"dba"."esercizio",
				"dba"."registro",		"dba"."riga_documento",	"dba"."sog_commerciale_gen",
				"dba"."caus_magazzino"
	
	WHERE		( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
				( "registro"."id_registro" = "documento"."id_registro" ) and  
				( "riga_documento"."id_documento" = "documento"."id_documento" ) and  
				( "riga_documento"."id_articolo" = "articolo"."id_articolo" ) and  
				( "documento"."id_sog_commerciale" = "sog_commerciale_gen"."id_sog_commerciale" ) and
				( "riga_documento"."id_riga_documento" = :ll_idrig)
				
	USING SQLCA;
	
	
	
	
	ls_zk = ""
	ls_zk = ls_zk+"Doc.to:~t"+ls_tipreg+string(ll_numreg)+" - "+string(ll_numpro)+" del "+string(ld_datreg)+ls_cr
	ls_zk = ls_zk+"Int.rio:~t"+ls_codcli+"-"+ls_ragsoc+ls_cr
	ls_zk = ls_zk+"Riga:~t"+string(ll_numrig)+": "+ls_codart+" - "+ls_desart+ls_cr
	ls_zk = ls_zk+"~tQta: "+string(ld_qta)+"  - Prezzo: "+string(ld_prezzo)+ls_cr
	ls_zk = ls_zk+"~tCausale: "+ls_descau
	
	ll_retv = Message.longParm
	
end if


return ll_retv

end function

public function long wf_check_r2 ();


long			ll_nrej, ll_nrows, ll_irow, ll_iddoc, ll_idoc, ll_ndocs
string		ls_acc, ls_temp, ls_tiporeg
long			ll_a1, ll_a2, ll_n1, ll_n2

ll_nrej=0
ll_nrows = ids_r2.rowCount()
ll_ndocs = ids_docs.rowCount()

ll_irow = ll_nrows
DO WHILE ll_irow>0
	ll_iddoc = ids_r2.GetItemNumber(ll_irow,"id_doc")
	ll_idoc = ids_docs.find("documento_id_documento = "+string(ll_iddoc),0,ll_ndocs)
	if ll_idoc>0 then
		ls_acc = ids_docs.GetItemString(ll_idoc,"cc_ok")
		if ls_acc='N' then
			
			ids_r2.deleterow(ll_irow)
			ll_nrej ++
		end if
	else
		
		ids_r2.deleterow(ll_irow)
		ll_nrej ++
	end if
	ll_irow --
LOOP

return ll_nrej

end function

public function long wf_elab_sc (boolean ab_definitiva, long al_scrow);



long			ll_nsc, ll_i, ll_errs, ll_idsc
long			ll_nrows
string		ls_filter, ls_sort
boolean		lb_rottura
pointer		lptr_1
integer		i
long 			ll_row
decimal{0}  ld_num_progressivo
string		ls_num_documento

lptr_1 = setPointer(HourGlass!)
ll_idsc = ids_sc.GetItemNumber(al_scrow,"idsc")
ls_filter = "id_sc = "+string(ll_idsc)
ids_r2.SetFilter (ls_filter)
ids_r2.filter ()


is_mfa = ids_sc.GetItemString(al_scrow,"mfatt")
if isNull (is_mfa) then is_mfa = "R"
if is_mfa = "R" then
	if (is_ch_rtdest="S") then
		
		ls_sort = "id_sc A, id_dest A, id_valu A, id_cpag A, id_ban A, sc_fin A, sc_cas A, id_doc A"
	else
		
		ls_sort = "id_sc A, id_valu A, id_cpag A, id_ban A, sc_fin A, sc_cas A, id_doc A"
	end if
else
	
	ls_sort= "id_doc A"
end if
ids_r2.SetSort(ls_sort)
ids_r2.sort()

	select	"anagrafica"."id_lingua",						"anagrafica"."id_tipo_trasporto",
				"sog_commerciale"."id_linguaggio",			"sog_commerciale"."id_listino",
				"sog_commerciale"."id_sog_com_vettore",	"sog_commerciale"."id_conto"
				
		into	:il_sc_idl1,		:il_sc_idtt,	:il_sc_idl2,	:il_sc_idlis,
				:il_sc_idvet,		:il_sc_idconto

		from	"dba"."anagrafica",	"dba"."sog_commerciale"

		where	("sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and
				("sog_commerciale"."id_sog_commerciale" = :ll_idsc) ;
		
		
		string ls_rag_soc
		select anagrafica.rag_soc_1 
		into :ls_rag_soc
		from anagrafica, sog_commerciale
		where sog_commerciale.id_sog_commerciale=:ll_idsc
		and sog_commerciale.id_anagrafica=anagrafica.id_anagrafica;
ll_nrows = ids_r2.rowCount()
imle_rep.text += "~r~n wf_elab_sc, righe di r2 presenti = "+string (ll_nrows)
id_tot_acconto = 0
if ll_nrows>0 then
	
	wf_set_ini_sc(ll_idsc)
	
	for ll_i = 1 to ll_nrows
		
		wf_get_riga_doc(ll_i)
		
		lb_rottura = wf_check_break_doc()
		if lb_rottura then
			
			if ib_servepiede then
				
				wf_calc_piede_doc(ll_i, ab_definitiva)
				ib_servepiede = false
				i++
				
				
				
				
				ll_row=tab_1.tabpage_5.dw_fat_gen.insertrow(0)
				ls_num_documento = ids_testa.GetItemString(ids_testa.GetRow(), "num_documento")
				ld_num_progressivo = ids_testa.GetItemNumber( ids_testa.GetRow(), "num_progressivo")
				
				tab_1.tabpage_5.dw_fat_gen.setitem(ll_row, "intestatario", ls_rag_soc)
				tab_1.tabpage_5.dw_fat_gen.setitem(ll_row, "num_progressivo", ld_num_progressivo)
				tab_1.tabpage_5.dw_fat_gen.setitem(ll_row, "num_documento", ls_num_documento)
				
			end if
			
			wf_set_testa(al_scrow)
			id_tot_acconto = 0				
		end if 
		
		
		
		
		if (il_rt_odocu<>il_rt_docu) then wf_totalizza_doc()
		
		wf_set_riga_arr(ll_i)
		ib_servepiede = true
		
		
		
		
		
	next
	
	if ib_servepiede then
		
		wf_calc_piede_doc(ll_i, ab_definitiva)
		ib_servepiede = false
		
		
		
		
		ll_row=tab_1.tabpage_5.dw_fat_gen.insertrow(0)
		ls_num_documento = ids_testa.GetItemString(ids_testa.GetRow(), "num_documento")
		ld_num_progressivo = ids_testa.GetItemNumber( ids_testa.GetRow(), "num_progressivo")
			
		tab_1.tabpage_5.dw_fat_gen.setitem(ll_row, "intestatario", ls_rag_soc)
		tab_1.tabpage_5.dw_fat_gen.setitem(ll_row, "num_progressivo", ld_num_progressivo)
		tab_1.tabpage_5.dw_fat_gen.setitem(ll_row, "num_documento", ls_num_documento)
		tab_1.tabpage_5.dw_fat_gen.setitem(ll_row, "num_fat_generate", i+1)
		
	end if
	
	
	
	
end if

SetPointer(lptr_1)

return 0

end function

public subroutine wf_set_ini_sc (long al_idsc);


il_rt_dest = -1
il_rt_odest = -1
il_rt_valu = -1
il_rt_ovalu = -1
il_rt_cpag = -1
il_rt_ocpag = -1
il_rt_bapp = -1
il_rt_obapp = -1
il_rt_docu = -1
il_rt_odocu = -1
is_rt_scfi = "nulla"
is_rt_oscfi = "nulla"
idc_rt_scca = -1000
idc_rt_oscca = -1000
id_rt_imp_acconto = -1000
il_rt_id_tipo_pag_acconto 	= -1
il_rt_id_tab_iva_acconto 	= -1
il_rt_id_val_acconto			= -1
id_rt_oimp_acconto = -1000
il_rt_oid_tipo_pag_acconto 	= -1
il_rt_oid_tab_iva_acconto 	= -1
il_rt_oid_val_acconto			= -1
il_oid_gruppo_agenti= -1

end subroutine

public function boolean wf_check_break_doc ();

boolean lb_rottura

lb_rottura = false
if (is_mfa="R") and (is_ch_rtdest="S") and (il_rt_odest<>il_rt_dest) then lb_rottura=true
if (is_mfa="R") and (il_rt_ovalu<>il_rt_valu) then lb_rottura=true
if (is_mfa="R") and (il_rt_ocpag<>il_rt_cpag) then lb_rottura=true
if (is_mfa="R") and (is_rt_oscfi<>is_rt_scfi) then lb_rottura=true
if (is_mfa="R") and (idc_rt_oscca<>idc_rt_scca) then lb_rottura=true
if (is_mfa="R") and (il_rt_obapp<>il_rt_bapp) then lb_rottura=true

if (is_mfa="R") and (il_rt_oid_val_acconto<>il_rt_id_val_acconto) then lb_rottura=true
if (is_mfa="R") and (il_rt_oid_tipo_pag_acconto<>il_rt_id_tipo_pag_acconto) then lb_rottura=true
if (is_mfa="R") and (il_rt_oid_tab_iva_acconto<>il_rt_id_tab_iva_acconto) then lb_rottura=true

if (is_mfa="R") and (il_oid_gruppo_agenti<>il_id_agente) then lb_rottura=true




if (is_mfa<>"R") and (il_rt_odocu<>il_rt_docu) then lb_rottura=true
if (is_mfa="R") and (idc_old_td_cambio<>idc_td_cambio) then lb_rottura=true


imle_rep.text += "~r~n wf_check_break_doc, rottura = "+string(lb_rottura)
imle_rep.text += "~r~n                     serve piede = "+string(ib_servepiede)

return lb_rottura

end function

public function long wf_check_righe ();

long		ll_idsc, ll_idar, ll_idag
string	ls_tipodoc, ls_tipo2, ls_rdes
long		ll_nrows, ll_row, ll_iddoc, ll_idrig, ll_idcpt
long		ll_nrigs, ll_rig, ll_idrmag
long		ll_idc1, ll_idc2, ll_idp1, ll_idp2
long		ll_nerr, ll_lerr, ll_sqlcode, ll_errow, ll_ret1
string	ls_modo, ls_tipoerr, ls_val
boolean	lb_desc, lb_isok, lb_putr, lb_putcpt
decimal	ld_val

long		ll_cnt, ll_fcode, ll_id_caus
string	ls_find

idw_errori.reset()
ids_r2.reset()
ll_nerr = 0
ll_nrows = ids_docs.rowCount()

if ll_nrows >0 then
	for ll_row = 1 to ll_nrows
		
		
		
		
		
		ll_iddoc = ids_docs.GetItemNumber(ll_row,"documento_id_documento")
		lb_isok = false
		ids_rows.retrieve(ll_iddoc)
		
		
		
		ll_nrigs = ids_rows.rowCount()
		if ll_nrigs>0 then
			lb_isok = true
			lb_putr = false
			for ll_rig = 1 to ll_nrigs
				ll_idrig = ids_rows.GetItemNumber(ll_rig,"riga_documento_id_riga_documento")
				ll_lerr = 0
				
				if ll_lerr=0 then
					ls_rdes = "S"
					lb_desc = true
					
					
					ld_val = ids_rows.GetItemNumber(ll_rig,"riga_documento_id_articolo")
					if isNull(ld_val) then ld_val = 0
					if ld_val > 0 then lb_desc = false
					
				end if
				if not lb_desc then
					ls_rdes = "N"
					
					
					if ll_lerr=0 then
						if not isNull(il_ch_idmag) and (il_ch_idmag>0) then
							ll_idrmag = ids_rows.GetItemNumber(ll_rig,"locazione_id_magazzino")
							if (isNull(ll_idrmag)) or (ll_idrmag <> il_ch_idmag) then
								ll_lerr = 1
								ls_tipoerr = "Il magazzino non corrisponde"
							end if
						end if
					end if
					
					
					if ll_lerr=0 then
						ld_val = ids_rows.GetItemNumber(ll_rig,"riga_documento_qta_evasa")
						if isNull(ld_val) then ld_val = 0
						decimal ld_qta, ld_peso, ld_peso_evaso
						ld_qta=ids_rows.GetItemNumber(ll_rig,"riga_documento_quantita")
						ld_peso=ids_rows.GetItemNumber(ll_rig,"peso_netto")
						ld_peso_evaso=ids_rows.GetItemNumber(ll_rig,"peso_netto_evaso")
						if isnull(ld_peso_evaso) then ld_peso_evaso=0
						if isnull(ld_peso) then ld_peso=0

					
						
						
						if ld_val=0 and ld_qta=0 and (ld_peso - ld_peso_evaso)<=0 then 
							ll_lerr=1
							ls_tipoerr = "La quantità è uguale a zero oppure la riga è già derivata."
						end if


						if (ld_val > 0 and ld_qta > 0 and ld_qta - ld_val <= 0) and &
						   (ld_peso > 0 and ld_peso_evaso > 0 and ld_peso - ld_peso_evaso <= 0) then
							ll_lerr=1
							ls_tipoerr = "La riga è già derivata"
						end if
						

						if ld_val >0 then
							
							lb_isok = false
						end if
					end if
					
					
					if ll_lerr=0 then
						ls_val = ids_rows.GetItemString(ll_rig,"riga_documento_chiuforz")
						if isNull(ls_val) then ls_val = 'N'
						if ls_val ='S' then
							ll_lerr = 1
							ls_tipoerr = "La riga è stata chiusa forzatamente"
						end if
					end if
					
					
					if ll_lerr=0 then
						
						
						
						
						
						
						
						
						
						ll_idp1 = ids_docs.GetItemNumber(ll_row,"documento_id_prof_documento")
						ll_idp2 = il_ch_idprof
						ll_idc1 = ids_rows.GetItemNumber(ll_rig,"riga_documento_id_caus_magazzino")
						ll_lerr = 1
						ll_cnt = ids_derp.rowCount()	
						long ll_id_distinta,ll_id_articolo,ll_cat_fiscale
						ll_id_articolo=ids_rows.GetItemNumber(ll_rig,"riga_documento_id_articolo")
						select id_cat_fiscale
						into :ll_cat_fiscale
						from articolo
						where id_articolo=:ll_id_articolo;
						if isnull(ll_cat_fiscale)then
							select id_distinta
							into :ll_id_distinta
							from distinta
							where id_articolo=:ll_id_articolo;
							if ll_id_distinta>0 and not isnull(ll_id_distinta)then
								ls_find = "id_prof_padre = "+string(ll_idp1)+" AND id_prof_der = "+string(ll_idp2)
							else
								ls_find = "id_prof_padre = "+string(ll_idp1)+" AND id_prof_der = "+string(ll_idp2)+" AND id_caus_prov = "+string(ll_idc1)
							end if
						else
							ls_find = "id_prof_padre = "+string(ll_idp1)+" AND id_prof_der = "+string(ll_idp2)+" AND id_caus_prov = "+string(ll_idc1)
						end if

						ll_fcode = ids_derp.find (ls_find,1,ll_cnt)
						if ll_fcode>0 then
							ll_lerr = 0
							ls_modo = ids_derp.GetItemString(ll_fcode,"modo")
							ll_idc2 = ids_derp.GetItemNumber(ll_fcode,"id_caus_der")
							choose case ls_modo
								case 'A'
									lb_putr = true
								case 'M'
									lb_putr = false
								case 'R'
									ll_lerr = 0
									lb_putr = false
									if is_ch_rcforz='S' then
										ll_ret1 = wf_ask_conf(ll_rig)
										if ll_ret1 >0 then lb_putr = true
									end if
								case else
									lb_putr = true
							end choose
						else
							ls_tipoerr = "Manca la concordanza tra le causali!"							
						end if
						
					end if		
					
					
					
					if ll_lerr=0 then
						lb_putcpt = false
						ll_idcpt = ids_rows.GetItemNumber(ll_rig,"riga_documento_id_conto")
						if (isNull(ll_idcpt)) then
							
							
							
							
							
							
							
							
							
							
							
							ll_idsc = ids_docs.GetItemNumber(ll_row,"documento_id_sog_commerciale")
							ll_idag = ids_docs.GetItemNumber(ll_row,"documento_id_gruppo_agenti")
							ll_idar = ids_rows.GetItemNumber(ll_rig,"riga_documento_id_articolo")
							ls_tipodoc = ids_docs.GetItemString(ll_row,"registro_tipo_registro")
							ls_tipo2 = "X"
							if mid(ls_tipodoc,2,1) = "A" then ls_tipo2 = "A"
							if mid(ls_tipodoc,2,1) = "V" then ls_tipo2 = "V"
							ll_id_caus = ids_rows.GetItemNumber(ll_rig,"riga_documento_id_caus_magazzino")
							SQLCA.sp_calc_cpt (ll_idsc,ll_idar,ll_idag,ls_tipo2,il_az_idaz,ll_idcpt, ll_id_caus)
							if ((isNull(ll_idcpt)) or( ll_idcpt<1)) then
								ll_idcpt=il_az_idcontoprd
								if ll_idcpt<0 or isnull(ll_idcpt) then
									ll_lerr = 1
									ls_tipoerr = "Impossibile calcolare la contropartita"
								end if
							else
								ids_rows.setitem(ll_rig,"riga_documento_id_conto",ll_idcpt)
								lb_putcpt = true
							end if
						end if
						
					end if					
					
					
				else
					ll_idc2 = u_freddie.gl_null
					ll_idcpt = u_freddie.gl_null
					lb_putr = true
				end if		
				
				if (lb_isok=true) and (ll_lerr=1) then
					lb_isok = false
				end if
				if (ll_lerr>0) then
					wf_insert_errori(ll_row,ll_rig,ls_tipoerr)
				end if
				
				if (lb_isok=true) and (lb_putr=true) then
					
					wf_insert_rigaok (ll_row, ll_idrig, ll_idc2, ll_idcpt,ls_rdes)
				end if
			next
		else
			ls_tipoerr = "Il Documento è senza righe!"
			wf_insert_errori(ll_row,0,ls_tipoerr)
			lb_isok = false
		end if
		
		if lb_isok then
			ids_docs.setItem(ll_row,"cc_ok","S")
		else
			ids_docs.setItem(ll_row,"cc_ok","N")
			ll_nerr ++
		end if
	next
end if

return ll_nerr

end function

public function long wf_elab_tutto (boolean ab_definitiva, string as_dummy);

long			ll_nsc, ll_i, ll_errs

imle_rep.text = "Inizio, wf_elab_tutto"
ll_nsc = ids_sc.rowCount()
ll_errs = 0
if ll_nsc>0 then
	tab_1.tabpage_5.dw_fat_gen.reset()
	ids_sc.sort()
	for ll_i = 1 to ll_nsc
		
		ll_errs = wf_elab_sc(ab_definitiva,ll_i)
	next
	messagebox("Elaborazione", "Elaborazione completata!")
end if

return ll_errs

end function

public subroutine wf_get_riga_doc (long al_row);


il_rt_dest = ids_r2.object.id_dest[al_row]
if isNull (il_rt_dest) then il_rt_dest = 0
il_rt_valu = ids_r2.object.id_valu[al_row]
if isNull (il_rt_valu) then il_rt_valu = 0
il_rt_cpag = ids_r2.object.id_cpag[al_row]
if isNull (il_rt_cpag) then il_rt_cpag = 0
is_rt_scfi = ids_r2.object.sc_fin[al_row]
if isNull (is_rt_scfi) then is_rt_scfi = ""
idc_rt_scca = ids_r2.object.sc_cas[al_row]
if isNull (idc_rt_scca) then idc_rt_scca = 0
il_rt_bapp = ids_r2.object.id_ban[al_row]
if isNull (il_rt_bapp) then il_rt_bapp = 0
il_rt_docu = ids_r2.object.id_doc[al_row]
if isNull (il_rt_docu) then il_rt_docu = 0
il_rt_scom = ids_r2.object.id_sc[al_row]
if isNull (il_rt_scom) then il_rt_scom = 0

if is_ch_ricchg='S' then
	idc_td_cambio	= ids_r2.object.cambio[al_row]
else
	SELECT "valuta"."cambio"
   INTO  :idc_td_cambio
   FROM "valuta"  
   WHERE "valuta"."id_valuta" = :il_rt_valu;
end if

long ll_id_val_euro, ll_id_valu_eser
decimal ldc_az_parita_euro

select id_valuta
into :ll_id_valu_eser
from esercizio
where id_esercizio = :il_td_ideser;

SELECT "valuta"."parita_euro"
INTO  :ldc_az_parita_euro
FROM "valuta"  
WHERE "valuta"."id_valuta" = :il_rt_valu;

select "par_sistema"."id_val_euro"
into	:ll_id_val_euro
from	"dba"."par_sistema"
where	"par_sistema"."id_azienda" = 1
using	SQLCA;

if ll_id_valu_eser = ll_id_val_euro then idc_td_cambio = ldc_az_parita_euro		

if isNull (idc_td_cambio) then idc_td_cambio = 1

id_rt_imp_acconto = ids_r2.object.d_imp_acconto[al_row]	
il_rt_id_tipo_pag_acconto = ids_r2.object.l_id_tipo_pag_acconto[al_row]
il_rt_id_tab_iva_acconto = ids_r2.object.l_id_tab_iva_acconto[al_row]
il_rt_id_val_acconto = ids_r2.object.l_id_val_acconto[al_row]

il_id_agente=ids_r2.object.id_gruppo_agenti[al_row]
if isNull (il_id_agente) then il_id_agente = 0
il_id_agente_2=ids_r2.object.id_gruppo_agenti_2[al_row]
if isnull(il_id_agente_2) then il_id_agente_2=0

end subroutine

public function long wf_ragg_sc ();


long		ll_nrows, ll_row, ll_scrow, ll_nrsc
long		ll_idsc
string	ls_find

string	ls_sccod, ls_scrag, ls_scind, ls_sccap, ls_scloc, ls_scpro, ls_scmft

ll_nrows = ids_r2.RowCount()
ll_nrsc = 0
ids_sc.reset()
for ll_row = 1 to ll_nrows
	ll_idsc = ids_r2.GetItemNumber(ll_row,"id_sc")
	if ll_nrsc=0 then
		ll_scrow = 0
	else
		ls_find = "idsc = "+string(ll_idsc)
		ll_scrow = ids_sc.find(ls_find,1,ll_nrsc)
	end if
	if ll_scrow=0 then
		ll_scrow = ids_sc.insertRow(0)
		if ll_scrow>0 then
			
			ids_sc.SetItem(ll_scrow,"idsc",ll_idsc)
			
			SELECT	"sog_commerciale_gen"."codice",			"sog_commerciale_gen"."rag_soc_1",
						"sog_commerciale_gen"."indirizzo",		"sog_commerciale_gen"."cap",   
						"sog_commerciale_gen"."localita",		"sog_commerciale_gen"."provincia",
						"sog_commerciale"."modo_fatturazione"
			INTO		:ls_sccod,		:ls_scrag,		:ls_scind,		:ls_sccap,
						:ls_scloc,		:ls_scpro,		:ls_scmft

			FROM		"dba"."sog_commerciale",	"dba"."sog_commerciale_gen"

			WHERE		("sog_commerciale"."id_sog_commerciale" = "sog_commerciale_gen"."id_sog_commerciale")
						and ("sog_commerciale"."id_sog_commerciale" = :ll_idsc) ;

			if sqlca.sqlcode=0 then
				ids_sc.SetItem(ll_scrow, "codice", ls_sccod)
				ids_sc.SetItem(ll_scrow, "ragsoc", ls_scrag)
				ids_sc.SetItem(ll_scrow, "indir", ls_scind)
				ids_sc.SetItem(ll_scrow, "cap", ls_sccap)
				ids_sc.SetItem(ll_scrow, "loc", ls_scloc)
				ids_sc.SetItem(ll_scrow, "prov", ls_scpro)
				ids_sc.SetItem(ll_scrow, "mfatt", ls_scmft)
			end if
			
			ll_nrsc++
			
		end if
	end if
next


return 0

end function

public function integer wf_totalizza_doc ();

integer		li_ret

decimal		ld_nc, ld_sc, ld_ia
decimal		ld_temp
decimal		ld_impo, ld_perc, ld_tot_fattura 

long			ll_scode, ll_sprow
long			ll_idsp, ll_idti

string		ls_find, ls_codsp

li_ret = 0

imle_rep.text += "~r~n wf_totalizza_doc, ID originale = "+string(il_rt_docu)


	select	"documento"."num_colli",
				"documento"."sconto_fin_incondizionato",
				"documento"."imp_acconto"
		into	:ld_nc, :ld_sc, :ld_ia
		from	"dba"."documento"
		where	"documento"."id_documento" = :il_rt_docu
		using	SQLCA;

	
	
	
	ll_scode = sqlca.sqlcode;
	if ll_scode <> 0 then
		li_ret = -1
	else
		if isNull (ld_nc) then ld_nc = 0
		if isNull (ld_sc) then ld_sc = 0
		if isNull (ld_ia) then ld_ia = 0
		
		
//		if is_pancali = 'S' then
//			long ll_id_sog_commerciale, ll_ret
//			decimal ld_tot_fattura
//			
//			ll_id_sog_commerciale= ids_testa.GetItemNumber(ids_testa.GetRow(),"id_sog_commerciale")
//					
//			DATASTORE ds_tot_fat 
//			ds_tot_fat = CREATE DATASTORE
//			ds_tot_fat.DATAOBJECT = "ds_saldo_imb_ncc"
//			ds_tot_fat.SETTRANSOBJECT(SQLCA)		
//			ll_ret = ds_tot_fat.retrieve(ll_id_sog_commerciale,id_ch_iniz,id_ch_fine)
//			if ll_ret > 0 then
//				ld_tot_fattura = ds_tot_fat.getitemdecimal(1,"tot_fattura")
//			else
//				ld_tot_fattura = 0
//			end if
//			
//			destroy ds_tot_fat
//			
//			if isnull(il_rt_id_tipo_pag_acconto) or il_rt_id_tipo_pag_acconto = 0 then
//				select id_tipo_pagamento
//				into :il_rt_id_tipo_pag_acconto
//				from tipo_pagamento
//				where upper(tipo_pagamento.descrizione) = 'CONTANTI';				
//				if isnull(il_rt_id_tipo_pag_acconto) then il_rt_id_tipo_pag_acconto = 0
//				if il_rt_id_tipo_pag_acconto = 0 then 
//					messagebox("Attenzione","Impossibile generare il compenso. Inserire il pagamento Contanti",stopsign!,ok!)					
//				end if
//			end if
//		else 
//			ld_tot_fattura = 0
//		end if
//		
		ld_tot_fattura = 0
		
		ld_temp = ids_testa.GetItemDecimal(il_rowtesta,"documento_num_colli")
		ld_temp += ld_nc
		ids_testa.setItem(il_rowtesta,"documento_num_colli",ld_temp)
		ld_temp = ids_testa.GetItemDecimal(il_rowtesta,"sconto_fin_incondizionato")
		ld_temp += ld_sc
		ids_testa.setItem(il_rowtesta,"sconto_fin_incondizionato",ld_temp)
		ld_temp = ids_testa.GetItemDecimal(il_rowtesta,"imp_acconto")

		
		
		ld_temp = ld_temp + ld_ia + ld_tot_fattura 
		
		
		ids_testa.setItem(il_rowtesta,"imp_acconto",ld_temp)
		
		id_tot_acconto = ld_temp
		

		ids_testa.setitem(il_rowtesta,"id_tab_iva_acconto", 	il_rt_id_tab_iva_acconto )
		ids_testa.setitem(il_rowtesta,"id_tipo_pag_acconto", 	il_rt_id_tipo_pag_acconto )
		ids_testa.setitem(il_rowtesta,"id_val_acconto",			il_rt_id_val_acconto )	

	end if


if li_ret = 0 then
	
	
	declare lcur_sp cursor for select
		"spesa_documento"."id_spesa", "spesa_documento"."id_tab_iva",
		"spesa_documento"."importo", "spesa_documento"."percentuale",
		"spesa"."codice"
		from	"dba"."spesa_documento", "dba"."spesa", 
				prof_documento p
		where	("spesa_documento"."id_spesa" = "spesa"."id_spesa") and
				("spesa_documento"."id_documento" = :il_rt_docu) and
				(p.id_prof_documento = :il_ch_idprof) and
				(LOCATE(p.spese_gestite, "spesa"."codice")) > 0
		using	SQLCA;

	ll_scode = sqlca.sqlcode
	if ll_scode < 0 then
		li_ret = -1
	end if
		
	if li_ret=0 then
		open lcur_sp;
		ll_scode = 0
		do while ll_scode = 0
			fetch lcur_sp into :ll_idsp, :ll_idti, :ld_impo, :ld_perc, :ls_codsp;
			ll_scode = sqlca.sqlcode
			choose case ll_scode
				case 0
					
					if (ls_codsp<>'B') and (ls_codsp<>'C') then
						
						if isNull(ld_impo) then ld_impo = 0
						if isNull(ld_perc) then ld_perc = 0
						
						ls_find = "id_spesa = "+string(ll_idsp)
						ll_sprow = ids_spese.find (ls_find,1,100)
						if ll_sprow = 0 then
							ll_sprow = ids_spese.insertrow(0)
							ids_spese.setItem(ll_sprow,"id_spesa",ll_idsp)
							ids_spese.setItem(ll_sprow,"id_tab_iva",ll_idti)
							ids_spese.setItem(ll_sprow,"importo",0)
							
						end if
						ids_spese.setItem(ll_sprow,"importo",ld_impo+ids_spese.getItemDecimal(ll_sprow,"importo"))
						
					end if
				case is < 0
					
					MessageBox ("Errore","Fetch spese in w_totalizza_doc")
					li_ret = -1
			end choose
		loop
		
		close lcur_sp;
	end if

end if

return li_ret

end function

public function integer wf_set_riga_arr (long al_r1);
string	ls_Att_Esenzione, ls_Prec_Esenzione, ls_contr_esen_der

long		ll_idr1, ll_rr2, ll_idcauder, ll_Id_Sog_Comm, ll_Id_tab_Iva, ll_Id_Prof_Doc, ll_num_riga
integer	li_ret


long		ll_idunco,  ll_idgrag,  ll_idarti,  ll_iddesa,  ll_idloc1,  ll_idloc2
long		ll_idvalu,  ll_idlist,  ll_idcoli,  ll_idctra,  ll_idaz,    ll_oldiva
long		ll_idcpt,   ll_arrot,	ll_idrigaprov,  ll_id_riga_lotto

string	ls_descr,   ls_scon

decimal	ld_qta,     ld_qtasm,   ld_fcon,    ld_oldchg,  ld_prez,    ld_prnt
decimal	ld_scri,    ld_pnet,    ld_plor,    ld_diml,    ld_dimh,    ld_dimp
decimal  ld_ncoll,   ld_prov1,   ld_valatt,  ld_prov2,   ld_prov3,	peso_netto_evaso

date		ldt_prc,    ldt_icmp,   ldt_fcmp

string	ls_codart,  ls_catcom,  ls_catmer,  ls_codiva,  ls_codcpt

decimal	ld_fatconv,	ld_molt,		ld_fatglob,	ld_qtaub, 	ld_newchg,	ld_qtaeff

decimal	ld_totrigavalriga,		ld_TotRigaValLire,		ld_TotRigaValDoc

string	ls_tipoarr,	ls_tipoconv

decimal  ld_prv_imp1,  ld_prv_imp2,  ld_prv_imp3
decimal	ld_prv1_2, ld_prv2_2, ld_prv3_2, ld_prv_imp1_2,  ld_prv_imp2_2,  ld_prv_imp3_2
long 		ll_idage_2
	boolean lb_ok 
li_ret = 0

ll_idr1 = ids_r2.GetItemNumber(al_r1,"id_riga_doc")
if isNull (ll_idr1) then
	return -1
end if
if ll_idr1<=0 then
	return -1
end if	
ll_idcauder = ids_r2.GetItemNumber(al_r1,"id_cauder")
ll_idcpt = ids_r2.GetItemNumber(al_r1,"id_cpt")

SELECT "riga_documento"."id_riga_documento",
		"riga_documento"."id_unita_confezione",   
		"riga_documento"."id_gruppo_agenti",   
		"riga_documento"."id_articolo",   
		"riga_documento"."descrizione",   
		"riga_documento"."id_des_articolo",   
		"riga_documento"."quantita",   
		"riga_documento"."qta_sconto_merce",   
		"riga_documento"."fat_con_unita_base",   
		"riga_documento"."id_locazione_1",   
		"riga_documento"."id_locazione_2",   
		"riga_documento"."id_valuta",   
		"riga_documento"."cambio",   
		"riga_documento"."id_listino",   
		"riga_documento"."id_con_lis_articolo",   
		"riga_documento"."prezzo",   
		"riga_documento"."sconto",   
		"riga_documento"."prezzo_netto",   
		"riga_documento"."sconto_riga",   
		"riga_documento"."data_prevista_consegna",
		"riga_documento"."peso_netto",   
		"riga_documento"."peso_lordo",   
		"riga_documento"."dim_l",   
		"riga_documento"."dim_h",   
		"riga_documento"."dim_p",   
		"riga_documento"."num_colli",   
		"riga_documento"."id_tab_iva",   
		"riga_documento"."provv_agente",   
		"riga_documento"."val_attribuito",   
		"riga_documento"."id_caus_trasporto",   
		"riga_documento"."data_inizio_competenza",   
		"riga_documento"."data_fine_competenza",   
		"riga_documento"."id_azienda",   
		"riga_documento"."provv_subage",   
		"riga_documento"."provv_carea",
	   "riga_documento"."id_riga_lotto",
		"riga_documento"."peso_netto_evaso",
	
	   "riga_documento"."provv_imp_agente", "riga_documento"."provv_imp_subage",
		"riga_documento"."provv_imp_carea", "riga_documento"."id_gruppo_agenti_2",
		"riga_documento"."provv_agente_2", "riga_documento"."provv_subage_2",
		"riga_documento"."provv_carea_2", "riga_documento"."provv_imp_agente_2", 
		"riga_documento"."provv_imp_subage_2", "riga_documento"."provv_imp_carea_2" 
	
		
 INTO :ll_idrigaprov,
		:ll_idunco,
		:ll_idgrag,
		:ll_idarti,
		:ls_descr,
		:ll_iddesa,
		:ld_qta,
		:ld_qtasm,
		:ld_fcon,
		:ll_idloc1,
		:ll_idloc2,
		:ll_idvalu,
		:ld_oldchg,
		:ll_idlist,
		:ll_idcoli,
		:ld_prez,
		:ls_scon,
		:ld_prnt,
		:ld_scri,
		:ldt_prc,
		:ld_pnet,
		:ld_plor,
		:ld_diml,
		:ld_dimh,
		:ld_dimp,
		:ld_ncoll,
		:ll_oldiva,
		:ld_prov1,
		:ld_valatt,
		:ll_idctra,
		:ldt_icmp,
		:ldt_fcmp,
		:ll_idaz,
		:ld_prov2,
		:ld_prov3,
      :ll_id_riga_lotto,
		:peso_netto_evaso,
	
		:ld_prv_imp1,  :ld_prv_imp2,  :ld_prv_imp3,
		:ll_idage_2, :ld_prv1_2, :ld_prv2_2, :ld_prv3_2, 
		:ld_prv_imp1_2,  :ld_prv_imp2_2,  :ld_prv_imp3_2 
	
FROM "dba"."riga_documento"  
WHERE "riga_documento"."id_riga_documento" = :ll_idr1;
	
if sqlca.sqlcode<>0 then
	return -1
end if

//if is_pancali = 'S' then
//	string ls_segno
//	long ll_id_cat_art, ll_ret, ll_saldo, ll_id_sog_commerciale, ll_id_prof_documento, ll_found, ll_row	
//	boolean lb_ok 
//	decimal ld_qta_saldo
//	
//	lb_ok = false
//	ll_ret = 0 
//	ll_saldo = 0
//	
//	select id_cat_com_articolo 
//	into :ll_id_cat_art
//	from articolo
//	where id_articolo = :ll_idarti;
//	
//	if ll_id_cat_art = il_id_cat_imb then
//		ll_id_sog_commerciale= ids_testa.GetItemNumber(ids_testa.GetRow(),"id_sog_commerciale")
//		ll_id_prof_documento = ids_testa.GetItemNumber(ids_testa.GetRow(),"id_prof_documento")
//		SELECT segno  
//		INTO	:ls_segno
//		FROM	tab_prof_imb
//		WHERE	id_prof_documento = :ll_id_prof_documento ;					
//		if isnull(ls_segno) then ls_segno = '-'
//		if ls_segno = '+' then
//			ll_found = ds_eva_imb_app.find("id_sog_com = " + string(ll_id_sog_commerciale) + " and id_art_imb = " + string(ll_idarti), 0 , ds_eva_imb_app.rowcount())
//			
//			if ll_found <= 0 then 
//				DATASTORE ds_saldo_imb 
//				ds_saldo_imb = CREATE DATASTORE
//				ds_saldo_imb.DATAOBJECT = "ds_saldo_imb"
//				ds_saldo_imb.SETTRANSOBJECT(SQLCA)					
//				ll_ret = ds_saldo_imb.retrieve(ll_id_sog_commerciale, ll_idarti, id_ch_fine) 
//				if ll_ret > 0 then 
//					ll_saldo = ds_saldo_imb.getitemnumber(1,"saldo") 
//					if not isnull(ll_saldo) and ll_saldo < 0 then 
//						ll_row = ds_eva_imb_app.insertrow(0)
//						ds_eva_imb_app.setitem(ll_row,"id_sog_com",ll_id_sog_commerciale)
//						ds_eva_imb_app.setitem(ll_row,"id_art_imb",ll_idarti)
//						
//						ld_qta_saldo = dec(abs(ll_saldo))
//						if ld_qta >= ld_qta_saldo then
//							ld_qta = ld_qta_saldo
//							ds_eva_imb_app.setitem(ll_row,"saldo",0)
//						else
//							ds_eva_imb_app.setitem(ll_row,"saldo",(ld_qta_saldo - ld_qta))					
//						end if			
//						
//						lb_ok = true
//						
//					end if
//				end if
//				destroy ds_saldo_imb
//			else
//				ld_qta_saldo = ds_eva_imb_app.getitemnumber(ll_found,"saldo")
//				if ld_qta_saldo > 0 then
//					if ld_qta >= ld_qta_saldo then
//						ld_qta = ld_qta_saldo
//						ds_eva_imb_app.setitem(ll_found,"saldo",0)
//						lb_ok = true
//					else
//						ds_eva_imb_app.setitem(ll_found,"saldo",(ld_qta_saldo - ld_qta))					
//						lb_ok = true						
//					end if		
//				else
//					lb_ok = false
//				end if
//			end if			
//		else
//			lb_ok = true
//		end if
//	else
//		lb_ok = true
//	end if
//else 
//	lb_ok = true
//end if
lb_ok = true
if lb_ok = false then
	il_rt_odest = il_rt_dest
	il_rt_ovalu = il_rt_valu
	il_rt_ocpag = il_rt_cpag
	is_rt_oscfi = is_rt_scfi
	idc_rt_oscca = idc_rt_scca
	il_rt_obapp = il_rt_bapp
	il_rt_odocu = il_rt_docu
	id_rt_oimp_acconto = id_rt_imp_acconto
	il_rt_oid_tipo_pag_acconto = il_rt_id_tipo_pag_acconto
	il_rt_oid_tab_iva_acconto = il_rt_id_tab_iva_acconto
	il_rt_oid_val_acconto = il_rt_id_val_acconto
	il_oid_gruppo_agenti=  il_id_agente
	idc_old_td_cambio=idc_td_cambio	
	
	return 0
end if

ll_rr2 = ids_riga.insertRow(0)
ll_num_riga= ids_riga.RowCount()
if ll_rr2 <= 0 then
	return -1
end if

ids_riga.SetItem(ll_rr2,"id_unita_confezione",ll_idunco)
ids_riga.SetItem(ll_rr2,"num_riga",ll_num_riga)
ids_riga.SetItem(ll_rr2,"id_gruppo_agenti",ll_idgrag)
ids_riga.SetItem(ll_rr2,"id_articolo",ll_idarti)
ids_riga.SetItem(ll_rr2,"descrizione",ls_descr)
ids_riga.SetItem(ll_rr2,"id_des_articolo",ll_iddesa)
ids_riga.SetItem(ll_rr2,"quantita",ld_qta)
ids_riga.SetItem(ll_rr2,"qta_sconto_merce",ld_qtasm)
ids_riga.SetItem(ll_rr2,"fat_con_unita_base",ld_fcon)
ids_riga.SetItem(ll_rr2,"id_locazione_1",il_td_idl1)
ids_riga.SetItem(ll_rr2,"id_locazione_2",il_td_idl2)
ids_riga.SetItem(ll_rr2,"id_valuta",ll_idvalu)
ids_riga.SetItem(ll_rr2,"id_listino",ll_idlist)
ids_riga.SetItem(ll_rr2,"id_con_lis_articolo",ll_idcoli)
ids_riga.SetItem(ll_rr2,"prezzo",ld_prez)
ids_riga.SetItem(ll_rr2,"sconto",ls_scon)
ids_riga.SetItem(ll_rr2,"prezzo_netto",ld_prnt)
ids_riga.SetItem(ll_rr2,"sconto_riga",ld_scri)
ids_riga.SetItem(ll_rr2,"data_prevista_consegna",ldt_prc)
ids_riga.SetItem(ll_rr2,"peso_netto",ld_pnet)
ids_riga.SetItem(ll_rr2,"peso_lordo",ld_plor)
ids_riga.SetItem(ll_rr2,"dim_l",ld_diml)
ids_riga.SetItem(ll_rr2,"dim_h",ld_dimh)
ids_riga.SetItem(ll_rr2,"dim_p",ld_dimp)
ids_riga.SetItem(ll_rr2,"num_colli",ld_ncoll)
ids_riga.SetItem(ll_rr2,"provv_agente",ld_prov1)
ids_riga.SetItem(ll_rr2,"val_attribuito",ld_valatt)
ids_riga.SetItem(ll_rr2,"id_caus_trasporto",ll_idctra)
ids_riga.SetItem(ll_rr2,"data_inizio_competenza",ldt_icmp)
ids_riga.SetItem(ll_rr2,"data_fine_competenza",ldt_fcmp)
ids_riga.SetItem(ll_rr2,"id_riga_doc_provenienza",ll_idrigaprov)
ids_riga.SetItem(ll_rr2,"id_azienda",ll_idaz)
ids_riga.SetItem(ll_rr2,"provv_subage",ld_prov2)
ids_riga.SetItem(ll_rr2,"provv_carea",ld_prov3)
ids_riga.SetItem(ll_rr2,"peso_netto_evaso",peso_netto_evaso)
ids_riga.SetItem(ll_rr2,"riga_documento_id_riga_lotto",ll_id_riga_lotto)
ids_riga.SetItem(ll_rr2,"riga_documento_provv_imp_agente",ld_prv_imp1)
ids_riga.SetItem(ll_rr2,"riga_documento_provv_imp_subage",ld_prv_imp2)
ids_riga.SetItem(ll_rr2,"riga_documento_provv_imp_carea",ld_prv_imp3)
ids_riga.SetItem(ll_rr2,"id_gruppo_agenti_2",ll_idage_2)
ids_riga.SetItem(ll_rr2,"provv_agente_2",ld_prv1_2)
ids_riga.SetItem(ll_rr2,"provv_subage_2",ld_prv2_2)
ids_riga.SetItem(ll_rr2,"provv_carea_2",ld_prv3_2)
ids_riga.SetItem(ll_rr2,"provv_imp_agente_2",ld_prv_imp1_2)
ids_riga.SetItem(ll_rr2,"provv_imp_subage_2",ld_prv_imp2_2)
ids_riga.SetItem(ll_rr2,"provv_imp_carea_2",ld_prv_imp3_2)

string ls_num_prog
date ldt_data_reg
select num_progressivo, data_registrazione
into :ls_num_prog, :ldt_data_reg
from documento
where id_documento=(select id_documento from riga_documento where id_riga_documento= :ll_idr1);
	
	
ids_riga.SetItem(ll_rr2,"rif_num",ls_num_prog)
ls_num_prog=string(ldt_data_reg)
ids_riga.SetItem(ll_rr2,"rif_data",ls_num_prog)



	
if il_siamo_nell_orafo>0 THEN	
	decimal{2}  coef_calo,calo,fino
	decimal prezzo_metallo,prezzo_manifattura,valoriz_peso_non_prezioso, qta_ordinata_fo, prezzo_complessivo
	decimal importo_manifattura, peso_non_prezioso, importo_manifattura_val
	long id_riga_partita,id_riga_doc_padre, id_riga_sorgente
	string sigla_prezzo,ordinato_fo
	select coef_calo
	,calo
	,fino
	,prezzo_metallo
	,prezzo_manifattura
	,id_riga_partita
	,sigla_prezzo
	,valoriz_peso_non_prezioso
	,qta_ordinata_fo
	,ordinato_fo
	,prezzo_complessivo
	,importo_manifattura
	,peso_non_prezioso
	
	,importo_manifattura_val
	into
	:coef_calo,
	:calo,
	:fino,
	:prezzo_metallo,
	:prezzo_manifattura,
	:id_riga_partita,
	:sigla_prezzo,
	:valoriz_peso_non_prezioso,
	:qta_ordinata_fo,
	:ordinato_fo,
	:prezzo_complessivo,
	:importo_manifattura,
	:peso_non_prezioso,
	
	:importo_manifattura_val
	
	from riga_documento
	where id_riga_documento=:ll_idr1;

	ids_riga.SetItem(ll_rr2,"COEF_CALO",coef_calo)
	ids_riga.SetItem(ll_rr2,"CALO",calo)
	ids_riga.SetItem(ll_rr2,"FINO",fino)
	ids_riga.SetItem(ll_rr2,"PREZZO_METALLO",prezzo_metallo)
	ids_riga.SetItem(ll_rr2,"PREZZO_MANIFATTURA",prezzo_manifattura)
	ids_riga.SetItem(ll_rr2,"ID_RIGA_PARTITA",id_riga_partita)
	ids_riga.SetItem(ll_rr2,"SIGLA_PREZZO",sigla_prezzo)
	ids_riga.SetItem(ll_rr2,"VALORIZ_PESO_NON_PREZIOSO",valoriz_peso_non_prezioso)
	ids_riga.SetItem(ll_rr2,"QTA_ORDINATA_FO",qta_ordinata_fo)
	ids_riga.SetItem(ll_rr2,"ORDINATO_FO",ordinato_fo)
	ids_riga.SetItem(ll_rr2,"prezzo_complessivo",prezzo_complessivo)
	ids_riga.SetItem(ll_rr2,"importo_manifattura",importo_manifattura)
	ids_riga.SetItem(ll_rr2,"peso_non_prezioso",peso_non_prezioso)
	ids_riga.SetItem(ll_rr2,"importo_manifattura_val",importo_manifattura_val)
	
END IF




ids_riga.SetItem(ll_rr2,"id_conto",ll_idcpt)

SELECT	"unita_confezione"."fat_conversione",   
			"unita_confezione"."molteplicita",   
			"unita_confezione"."tipo_conversione"  
	INTO	:ld_fatconv, :ld_molt, :ls_tipoconv
	FROM	"dba"."unita_confezione"  
	WHERE "unita_confezione"."id_unita_confezione" = :ll_idunco;

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
ids_riga.SetItem(ll_rr2,"fat_con_globale",ld_fatglob)

ld_qtaub = (ld_qta + ld_qtasm) * ld_fatglob
ids_riga.SetItem(ll_rr2, "qta_un_base", ld_qtaub)


long ll_id_val_euro, ll_id_valu_eser
decimal ldc_az_parita_euro

SELECT	"valuta"."cambio",  "valuta"."dec_significativi",
			"valuta"."tipo_arrotondamento", "valuta"."parita_euro"
	INTO	:ld_newchg, :ll_arrot, :ls_tipoarr, :ldc_az_parita_euro
	FROM	"dba"."valuta"  
	WHERE	"valuta"."id_valuta" = :ll_idvalu;
	
select id_valuta
into :ll_id_valu_eser
from esercizio
where id_esercizio = :il_td_ideser;

select "par_sistema"."id_val_euro"
into	:ll_id_val_euro
from	"dba"."par_sistema"
where	"par_sistema"."id_azienda" = 1
using	SQLCA;

if ll_id_valu_eser = ll_id_val_euro then ld_newchg = ldc_az_parita_euro
	
if is_ch_ricchg <> "S" then
	if ld_newchg>0 then
		ld_oldchg = ld_newchg
	end if
end if
ids_riga.setItem(ll_rr2,"cambio",ld_oldchg)

idc_td_cambio=ld_oldchg


If not IsNull(ll_oldiva) then
	ll_Id_Prof_Doc=ids_testa.GetItemNumber(ids_testa.GetRow(),"id_prof_documento")
	SELECT "prof_documento"."contr_esen_der"  
		INTO :ls_contr_esen_der  
		FROM "dba"."prof_documento"  
		WHERE "prof_documento"."id_prof_documento" = :ll_Id_Prof_Doc ;
	
	
	If ls_contr_esen_der ="S" then
	 
		ls_Att_Esenzione=ids_testa.GetItemString(ids_testa.GetRow(),"creato_in_esenzione")
		If IsNull(ls_Att_Esenzione) then ls_Att_Esenzione=""
		
		SELECT "documento"."creato_in_esenzione"  
			INTO :ls_Prec_Esenzione  
			FROM 	"dba"."documento",   
					"dba"."riga_documento"  
			WHERE ( "riga_documento"."id_documento" = "documento"."id_documento" ) and  
					( ( "riga_documento"."id_riga_documento" = :ll_idr1 ) )   ;
		If IsNull(ls_Prec_Esenzione) then ls_Prec_Esenzione = ""
		
		If ls_Prec_Esenzione = "S" then
			If ls_Att_Esenzione = "S" then
				
				SELECT "articolo"."id_tab_iva"  
					INTO :ll_Id_tab_Iva 
					FROM "dba"."articolo"  
					WHERE "articolo"."id_articolo" = :ll_idarti ;
				ids_riga.SetItem(ll_rr2,"id_tab_iva",ll_Id_tab_Iva)
			else
				
				ids_riga.SetItem(ll_rr2,"id_tab_iva",ll_oldiva)
			end if
		else
			If ls_Att_Esenzione = "S" then
				
				ll_Id_Sog_Comm=ids_testa.GetItemNumber(ids_testa.GetRow(),"id_sog_commerciale")
				SELECT "sog_commerciale"."id_tab_iva"  
					INTO :ll_Id_tab_Iva  
					FROM "dba"."sog_commerciale"  
					WHERE "sog_commerciale"."id_sog_commerciale" = :ll_Id_Sog_Comm   ;
				ids_riga.SetItem(ll_rr2,"id_tab_iva",ll_oldiva)
			else
				
				ids_riga.SetItem(ll_rr2,"id_tab_iva",ll_oldiva)
			end if
		end if
	else
		
		ids_riga.SetItem(ll_rr2,"id_tab_iva",ll_oldiva)
	end if
else
	ids_riga.SetItem(ll_rr2,"id_tab_iva",ll_oldiva)
end if
if isNull (ld_qta) then ld_qta = 0
if isNull (ld_qtasm) then ld_qtasm = 0
if isNull (ld_prnt) then ld_prnt = 0

	
if IsNull(ll_arrot) then ll_arrot=0
if isNull(ld_oldchg) then ld_oldchg=1
if isNull(ld_scri) then ld_scri=0

string ls_um, ls_tipo


select simbolo, tipo
into :ls_um, :ls_tipo
from unita_confezione, unita_misura
where (unita_confezione.id_unita_confezione=:ll_idunco) and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
choose case upper(ls_tipo)
	case "P"
		if il_siamo_nell_orafo>0 then
			ld_TotRigaValRiga=ld_prnt
		else
			ld_TotRigaValRiga=(ld_pnet*ld_prnt) - ld_scri 
		end if
	case else 
		ld_TotRigaValRiga=(ld_qta * ld_prnt) - ld_scri
end choose

ld_TotRigaValRiga = f_Round(ld_TotRigaValRiga ,ll_arrot, ls_tipoarr)
ids_riga.SetItem(ll_rr2, "tot_riga_val_riga",ld_TotRigaValRiga)
ld_TotRigaValLire = ld_TotRigaValRiga * ld_oldchg

ld_qtaeff = ld_qta+ld_qtasm
if ld_qtaeff > 0 then
	ids_riga.SetItem (ll_rr2, "val_attribuito", ld_TotRigaValLire/ld_qtaeff)
else
	ids_riga.SetItem (ll_rr2, "val_attribuito", 0)
end if


long ll_dec_significativi
string ls_tipo_arr
select dec_significativi, tipo_arrotondamento
into :ll_dec_significativi, :ls_tipo_arr
from valuta
where id_valuta = :il_az_idvalu;

ld_TotRigaValLire = f_round(ld_TotRigaValLire,ll_dec_significativi,ls_tipo_arr)
ids_riga.SetItem(ll_rr2, "tot_riga_val_az",ld_TotRigaValLire)

if idc_td_cambio = 0 or isNull (idc_td_cambio) then idc_td_cambio=1

ld_TotRigaValDoc = ld_totRigaValRiga *  ld_oldchg / idc_td_cambio

ld_TotRigaValDoc = f_Round(ld_TotRigaValDoc ,ll_arrot, ls_tipoarr)
ids_riga.SetItem(ll_rr2, "tot_riga_val_doc",ld_TotRigaValDoc)



ids_riga.SetItem(ll_rr2,"qta_evasa",0)
ids_riga.SetItem(ll_rr2,"qta_evasa_un_base",0)
ids_riga.SetItem(ll_rr2,"forza_chius_evasione","N")
ids_riga.SetItem(ll_rr2,"sospesa","N")
ids_riga.SetItem(ll_rr2,"da_stampare","S")

ids_riga.SetItem(ll_rr2,"id_caus_magazzino",ll_idcauder)



  SELECT "articolo"."codice",   
         "cat_com_articolo"."codice",   
         "cat_merceologica"."codice"  
    INTO :ls_codart,   
         :ls_catcom,   
         :ls_catmer  
    FROM {oj "articolo" LEFT OUTER JOIN "cat_com_articolo"  ON "articolo"."id_cat_com_articolo" = "cat_com_articolo"."id_cat_com_articolo"},
	 		{oj "articolo"  LEFT OUTER JOIN "cat_merceologica"  ON "articolo"."id_cat_merceologica" = "cat_merceologica"."id_cat_merceologica"}
   WHERE "articolo"."id_articolo" = :ll_idarti
	USING	SQLCA ;

	if isNull (ls_codart) then ls_codart = ""
	if isNull (ls_catcom) then ls_catcom = ""
	if isNull (ls_catmer) then ls_catmer = ""


  SELECT "tab_iva"."codice"  
    INTO :ls_codiva  
    FROM "tab_iva"  
   WHERE "tab_iva"."id_tab_iva" = :ll_oldiva;

	if isNull (ls_codiva) then ls_codiva = ""
	 

  SELECT "conto_azienda"."codice"  
    INTO :ls_codcpt  
    FROM "conto_azienda"  
   WHERE "conto_azienda"."id_conto" = :ll_idcpt ;

ids_riga.SetItem(ll_rr2,"c_codart",ls_codart)
ids_riga.SetItem(ll_rr2,"c_catcom",ls_catcom)
ids_riga.SetItem(ll_rr2,"c_catmer",ls_catmer)
ids_riga.SetItem(ll_rr2,"c_codiva",ls_codiva)
ids_riga.SetItem(ll_rr2,"c_contro",ls_codcpt)


	
il_rt_odest = il_rt_dest
il_rt_ovalu = il_rt_valu
il_rt_ocpag = il_rt_cpag
is_rt_oscfi = is_rt_scfi
idc_rt_oscca = idc_rt_scca
il_rt_obapp = il_rt_bapp
il_rt_odocu = il_rt_docu
id_rt_oimp_acconto = id_rt_imp_acconto
il_rt_oid_tipo_pag_acconto = il_rt_id_tipo_pag_acconto
il_rt_oid_tab_iva_acconto = il_rt_id_tab_iva_acconto
il_rt_oid_val_acconto = il_rt_id_val_acconto
il_oid_gruppo_agenti=  il_id_agente
idc_old_td_cambio=idc_td_cambio

return 0

end function

public function integer wf_set_testa (long al_scrow);
long		ll_row, ll_idsc
integer	li_ret
string	ls_temp, ls_ttot, ls_1, ls_2, ls_3, ls_4, ls_5
string	ls_testata, ls_dval
integer  li_i, li_len	

li_ret = 0
ll_idsc = ids_sc.GetItemNumber(al_scrow,"idsc")



  SELECT	"valuta"."dec_significativi",
  			"valuta"."tipo_arrotondamento",
  			"valuta"."descrizione"			  
    INTO  :il_rt_arrvalu, :is_rt_tiparrvalu, :ls_dval 
    FROM "valuta"  
   WHERE "valuta"."id_valuta" = :il_rt_valu;

	if sqlca.sqlcode<0 then
		li_ret = -1
	end if


ids_spese.reset()
ids_riga.reset()
il_rowtesta = 0
ids_testa.reset()
ids_riga.object.testa_descon_t.text = ""
ids_riga.object.testa_data_reg_t.text = ""
ids_riga.object.testa_anag_t.text = ""
ids_riga.object.testa_dest_t.text = ""
ids_riga.object.testa_cpag_t.text = ""
ids_riga.object.testa_bapp_t.text = ""
ids_riga.object.testa_porto_t.text = ""
ids_riga.object.testa_cambio_t.text= ""
ids_riga.object.piede_cast_spesa_1_t.text= ""
ids_riga.object.piede_cast_spesa_2_t.text= ""
ids_riga.object.piede_cast_spesa_3_t.text= ""
ids_riga.object.piede_cast_spesa_4_t.text= ""
ids_riga.object.piede_scfin_t.text= ""
ids_riga.object.piede_sccas_t.text= ""
ids_riga.object.piede_scinc_t.text= ""

ll_row = ids_testa.InsertRow(0)
if ll_row>0 then
	
	
	
	
	
	If not(IsNull(il_ch_idprof) OR il_ch_idprof=0) then ids_testa.SetItem(ll_row,"id_prof_documento",il_ch_idprof)
	If not(IsNull(il_td_idregi) OR il_td_idregi=0) then ids_testa.SetItem(ll_row,"id_registro",il_td_idregi)
	
	
	ids_testa.SetItem(ll_row,"num_progressivo",0)
	
	ids_testa.SetItem(ll_row,"data_registrazione",id_ch_reg)
	
	
	ids_testa.SetItem(ll_row,"num_documento","0")
	
	ids_testa.SetItem(ll_row,"data_documento",id_ch_reg)
	ids_testa.SetItem(ll_row,"documento_data_competenza",id_ch_reg)
	If not(IsNull(ll_idsc) OR ll_idsc=0) then ids_testa.SetItem(ll_row,"id_sog_commerciale",ll_idsc)
	
	
	
	
	If not(IsNull(il_ch_idprof) OR il_ch_idprof=0) then ids_testa.SetItem(ll_row,"documento_id_caus_magazzino",il_td_idcmag)
	
	
	
	
	
	If not(IsNull(il_td_idmag) OR il_td_idmag=0) then ids_testa.SetItem(ll_row,"documento_id_magazzino",il_td_idmag)
	If not(IsNull(il_td_idmag2) OR il_td_idmag2=0) then ids_testa.SetItem(ll_row,"documento_id_magazzino_2",il_td_idmag2)
	
	If not(IsNull(il_td_idl1) OR il_td_idl1=0) then ids_testa.SetItem(ll_row,"documento_id_locazione_1",il_td_idl1)
	If not(IsNull(il_td_idl2) OR il_td_idl2=0) then ids_testa.SetItem(ll_row,"documento_id_locazione_2",il_td_idl2)	
	
	If not(IsNull(ll_idsc) OR ll_idsc=0) then ids_testa.SetItem(ll_row,"documento_id_sog_commerciale_fattura",ll_idsc)
	
	
	
	
	
	If not(IsNull(il_td_idl2) OR il_td_idl2=0) then ids_testa.SetItem(ll_row,"documento_id_linguaggio",il_td_idl2)
	If not(IsNull(il_rt_valu) OR il_rt_valu=0) then ids_testa.SetItem(ll_row,"documento_id_valuta_des",il_rt_valu)
	
	
	
	If not(IsNull(idc_td_cambio) OR idc_td_cambio=0) then ids_testa.SetItem(ll_row,"documento_cambio",idc_td_cambio)
	
	
	If not(IsNull(il_td_idlis) OR il_td_idlis=0) then ids_testa.SetItem(ll_row,"documento_id_listino",il_td_idlis)

	
	If not(IsNull(il_rt_cpag) OR il_rt_cpag<=0) then ids_testa.SetItem(ll_row,"id_con_pagamento",il_rt_cpag)
	If not(IsNull(il_rt_bapp) OR il_rt_bapp<=0) then ids_testa.SetItem(ll_row,"id_banca_sog_commerciale",il_rt_bapp)
	
	
	
	
	
	If not(IsNull(il_id_agente) OR il_id_agente<=0) then ids_testa.SetItem(ll_row,"id_gruppo_agenti",il_id_agente)
	
	If not(IsNull(il_id_agente_2) OR il_id_agente_2<=0) then ids_testa.SetItem(ll_row,"id_gruppo_agenti_2",il_id_agente_2)
	
	
	
	
	
	
	ids_testa.SetItem(ll_row,"documento_note_intestazione",is_td_note)
	
	
	
	
	
	
	If not(IsNull(il_sc_idtt) OR il_sc_idtt=0) then ids_testa.SetItem(ll_row,"id_tipo_trasporto",il_sc_idtt)
	If not(IsNull(il_sc_idvet) OR il_sc_idvet=0) then ids_testa.SetItem(ll_row,"documento_id_sog_commerciale_vettore_2",il_sc_idvet)
	
	ids_testa.SetItem(ll_row,"documento_sconto_finanziario",is_rt_scfi)
	
	
	
	ids_testa.SetItem(ll_row,"documento_sconto_fin_cassa",idc_rt_scca)
	ids_testa.SetItem(ll_row,"documento_data_dec_pagamento",id_ch_reg)
	
	
	
	
	
	ids_testa.SetItem(ll_row,"documento_stampato","N")
	ids_testa.SetItem(ll_row,"documento_contabilizzato","N")
	ids_testa.SetItem(ll_row,"documento_evaso_totalmente","N")
	ids_testa.SetItem(ll_row,"documento_chius_forzata","N")
	ids_testa.SetItem(ll_row,"documento_sospeso","N")
	
	
	
	
	
	
	string ls_tipo_fattura
	
	select tipo_fattura
	into :ls_tipo_fattura
	from prof_documento
	where id_prof_documento = :il_ch_idprof;
	
	
	
	ids_testa.SetItem(ll_row,"tipo_fattura",ls_tipo_fattura)
	
	
	ids_testa.SetItem(ll_row,"bloccato","N")
	ids_testa.SetItem(ll_row,"segno_iva",1)
	
	
	
	If not(IsNull(il_td_idprr) OR il_td_idprr=0) then ids_testa.SetItem(ll_row,"id_prof_registrazione",il_td_idprr)
	ids_testa.SetItem(ll_row,"des_contabile",is_td_descon)
	
	
	
	
	ids_testa.SetItem(ll_row,"documento_ID_AZIENDA",1)
	
	
	
	
	
	
	
	
	ids_testa.SetItem(ll_row,"documento_num_colli",0)
	ids_testa.SetItem(ll_row,"sconto_fin_incondizionato",0)
	ids_testa.SetItem(ll_row,"imp_acconto",0)
	
	
	
	
	ids_riga.object.testa_descon_t.text = is_td_descon
	ids_riga.object.testa_data_reg_t.text = string(id_ch_reg,"dd/mm/yyyy")
	ids_riga.object.testa_valuta_t.text = ls_dval
	ids_riga.object.testa_cambio_t.text = string(idc_td_cambio)
	ls_temp = ids_sc.GetItemString(al_scrow,"ragsoc")
	if not isNull (ls_temp) then ls_ttot = ls_temp
	ls_temp = ids_sc.GetItemString(al_scrow,"indir")
	if not isNull (ls_temp) then ls_ttot = ls_ttot + ", " + ls_temp
	ls_temp = ids_sc.GetItemString(al_scrow,"cap")
	if not isNull (ls_temp) then ls_ttot = ls_ttot + ", " + ls_temp
	ls_temp = ids_sc.GetItemString(al_scrow,"loc")
	if not isNull (ls_temp) then ls_ttot = ls_ttot + " " + ls_temp
	ls_temp = ids_sc.GetItemString(al_scrow,"prov")
	if not isNull (ls_temp) then ls_ttot = ls_ttot + " " + ls_temp
	
	
	integer li_app
	li_app=pos(ls_ttot, '"')
	do while li_app>0
		ls_ttot=replace(ls_ttot, li_app, 1, " ")
		li_app=pos(ls_ttot, '"')
	loop
	
	ids_riga.object.testa_anag_t.text = ls_ttot
	
	
	
	
	if (is_ch_rtdest="S") or (not isNull (il_ch_iddest)) then
		ls_1 = ""
		ls_2 = ""
		ls_3 = ""
		ls_4 = ""
		ls_5 = ""
		SELECT	"destinazione"."rag_soc_1",	"destinazione"."indirizzo",
					"destinazione"."cap",			"destinazione"."localita",
					"destinazione"."provincia"
			INTO	:ls_1, :ls_2,  :ls_3,  :ls_4,  :ls_5
			FROM	"destinazione"
			WHERE	"destinazione"."id_destinazione" = :il_ch_iddest
			USING	SQLCA;

		if isNull (ls_1) then ls_1 = ""
		if isNull (ls_2) then ls_2 = ""
		if isNull (ls_3) then ls_3 = ""
		if isNull (ls_4) then ls_4 = ""
		if isNull (ls_5) then ls_5 = ""
		ls_ttot = ls_1+", "+ls_2+", "+ls_3+" "+ls_4+" "+ls_5
		ids_riga.object.testa_dest_t.text = ls_ttot

	end if
	
	
	
	ls_1 = ""
	ls_2 = ""
	SELECT	"con_pagamento"."codice",	"con_pagamento"."descrizione"  
		INTO	:ls_1,	:ls_2  
		FROM	"dba"."con_pagamento"  
		WHERE "con_pagamento"."id_con_pagamento" = :il_rt_cpag;
	
	if isNull (ls_1) then ls_1 = ""
	if isNull (ls_2) then ls_2 = ""
	ls_ttot = ls_1+" "+ls_2
	ids_riga.object.testa_cpag_t.text = ls_ttot


	
	
	
	ls_1 = ""
	ls_2 = ""
	ls_3 = ""
	ls_4 = ""
	SELECT	"banca_sog_commerciale_gen"."cod_abi", "banca_sog_commerciale_gen"."cod_cab",
				"banca_sog_commerciale_gen"."den_abi", "banca_sog_commerciale_gen"."den_cab"
		INTO	:ls_1, :ls_2, :ls_3, :ls_4  
		FROM 	"banca_sog_commerciale_gen"
		WHERE	"banca_sog_commerciale_gen"."id_banca_sog_commerciale" = :il_rt_bapp
		USING	sqlca;
		
	if isNull (ls_1) then ls_1 = ""
	if isNull (ls_2) then ls_2 = ""
	if isNull (ls_3) then ls_3 = ""
	if isNull (ls_4) then ls_4 = ""
	ls_ttot = ls_1+" "+ls_2+" - "+ls_3+", "+ls_4
	
	li_len = len(ls_ttot)
	if (li_len > 0) then
		for li_i = 1 to li_len
			if mid(ls_ttot, li_i, 1) = '"' then 
				ls_ttot = replace(ls_ttot, li_i, 1, " ")
			end if
		next
	end if
	
	ids_riga.object.testa_bapp_t.text = ls_ttot
	
	
	
	
	ls_1 = ""
	ls_2 = ""
	SELECT	"tipo_trasporto"."codice",	"tipo_trasporto"."descrizione"  
		INTO	:ls_1, :ls_2
		FROM	"dba"."tipo_trasporto"
		WHERE	"tipo_trasporto"."id_tipo_trasporto" = :il_sc_idtt
		USING	sqlca;
		
	if isNull (ls_1) then ls_1 = ""
	if isNull (ls_2) then ls_2 = ""
	ls_ttot = ls_1+" "+ls_2
	ids_riga.object.testa_porto_t.text = ls_ttot
		
	
	
	idw_testr.object.testa_descon_t.text		= ids_riga.object.testa_descon_t.text
	idw_testr.object.testa_data_reg_t.text		= ids_riga.object.testa_data_reg_t.text
	idw_testr.object.testa_anag_t.text			= ids_riga.object.testa_anag_t.text
	idw_testr.object.testa_dest_t.text			= ids_riga.object.testa_dest_t.text
	idw_testr.object.testa_cpag_t.text			= ids_riga.object.testa_cpag_t.text
	idw_testr.object.testa_bapp_t.text			= ids_riga.object.testa_bapp_t.text
	idw_testr.object.testa_porto_t.text			= ids_riga.object.testa_porto_t.text
	
	idw_testr.object.testa_valuta_t.text		= ids_riga.object.testa_valuta_t.text
	idw_testr.object.testa_cambio_t.text		= ids_riga.object.testa_cambio_t.text
	
	
	
	
	il_rowtesta = ll_row
	
else
	li_ret = -1
end if

imle_rep.text += "~r~n wf_set_testa, La riga testata = "+string(il_rowtesta)
imle_rep.text += "~r~n               ID SC   = "+ string (ll_idsc)
imle_rep.text += "~r~n               Cli/For = "+ ids_sc.GetItemString(al_scrow,"ragsoc")
imle_rep.text += "~r~n               condpag = "+ ids_riga.object.testa_cpag_t.text

return li_ret

end function

public function long wf_insert_errori (long al_row, long al_rig, string as_err);

long		ll_iddoc,   ll_idrig,   ll_errow
string	ls_codese,	ls_tipreg,	ls_codcli,	ls_ragsoc,	ls_codart,	ls_desart
long		ll_numreg,	ll_numpro,	ll_numrig,	ll_idart
date		ld_datreg



ll_errow = idw_errori.insertRow(0)
if ll_errow<=0 then
	return -1
end if


if al_rig>0 then
	ll_idrig = ids_rows.GetItemNumber(al_rig,"riga_documento_id_riga_documento")
else
	ll_idrig=0
end if
if al_row>0 then
	ll_iddoc = ids_docs.GetItemNumber(al_row,"documento_id_documento")
else
	ll_iddoc = 0
end if



if ll_idrig>0 then
	
	
	
	SELECT	"esercizio"."codice",					"registro"."tipo_registro",
				"registro"."numero",						"documento"."num_progressivo",
				"documento"."data_registrazione",	"sog_commerciale_gen"."codice",
				"sog_commerciale_gen"."rag_soc_1",	"riga_documento"."num_riga",
				"riga_documento"."descrizione",		"riga_documento"."id_articolo"
	
	INTO		:ls_codese, :ls_tipreg, :ll_numreg, :ll_numpro, :ld_datreg, :ls_codcli,
				:ls_ragsoc, :ll_numrig,	:ls_desart,	:ll_idart
	
	FROM		"dba"."documento",		"dba"."esercizio",				"dba"."registro",
				"dba"."riga_documento",	"dba"."sog_commerciale_gen"  
	
	WHERE		( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
				( "registro"."id_registro" = "documento"."id_registro" ) and  
				( "riga_documento"."id_documento" = "documento"."id_documento" ) and  
				( "documento"."id_sog_commerciale" = "sog_commerciale_gen"."id_sog_commerciale" ) and
				( "riga_documento"."id_riga_documento" = :ll_idrig)
				
	USING SQLCA;
	
	if (not isNull(ll_idart)) and (ll_idart>0) then
		select	"articolo"."codice"
			into	:ls_codart
			from	"dba"."articolo"
			where	"articolo"."id_articolo" = :ll_idart
			using	SQLCA;
		if isNull(ls_codart) then ls_codart = ""
	end if
	
else
	
	
	
	
	
	SELECT	"esercizio"."codice",					"registro"."tipo_registro",
				"registro"."numero",						"documento"."num_progressivo",
				"documento"."data_registrazione",	"sog_commerciale_gen"."codice",
				"sog_commerciale_gen"."rag_soc_1"
	
	INTO		:ls_codese, :ls_tipreg, :ll_numreg, :ll_numpro, :ld_datreg, :ls_codcli,
				:ls_ragsoc
	
	FROM		"dba"."documento",		"dba"."esercizio",
				"dba"."registro",		"dba"."sog_commerciale_gen"  
	
	WHERE		( "registro"."id_esercizio" = "esercizio"."id_esercizio" ) and  
				( "registro"."id_registro" = "documento"."id_registro" ) and  
				( "documento"."id_sog_commerciale" = "sog_commerciale_gen"."id_sog_commerciale" ) and
				( "documento"."id_documento" = :ll_iddoc)
				
	USING SQLCA;
	
	ll_numrig = 0
	ls_codart = ""
	ls_desart = "<Testata Documento>"

end if


idw_errori.SetItem (ll_errow,"esercizio_codice",ls_codese)
idw_errori.SetItem (ll_errow,"registro_tipo_registro",ls_tipreg)
idw_errori.SetItem (ll_errow,"registro_numero",ll_numreg)
idw_errori.SetItem (ll_errow,"documento_num_progressivo",ll_numpro)
idw_errori.SetItem (ll_errow,"documento_data_registrazione",ld_datreg)
idw_errori.SetItem (ll_errow,"sog_commerciale_gen_codice",ls_codcli)
idw_errori.SetItem (ll_errow,"sog_commerciale_gen_rag_soc_1",ls_ragsoc)
idw_errori.SetItem (ll_errow,"riga_documento_num_riga",ll_numrig)
idw_errori.SetItem (ll_errow,"articolo_codice",ls_codart)
idw_errori.SetItem (ll_errow,"riga_documento_descrizione",ls_desart)
idw_errori.SetItem (ll_errow,"cerr_txt",as_err)
idw_errori.SetItem (ll_errow,"documento_id_documento",ll_iddoc)
idw_errori.SetItem (ll_errow,"riga_documento_id_riga_documento",ll_idrig)


return 0

end function

public function integer wf_set_istanze ();

integer		li_ret


li_ret = 0
il_az_idaz = 1

SELECT	"spesa"."id_spesa"  
	INTO	:il_az_idspesabol  
	FROM	"dba"."spesa"  
	WHERE	"spesa"."codice" = 'B';
	
if sqlca.sqlcode<>0 then
	li_ret = 1
end if


SELECT	"par_sistema"."id_conto_predefinito",
			"par_sistema"."id_tab_iva_art_15"
	INTO	:il_az_idcontoprd, :il_az_idivaart15
	FROM	"dba"."par_sistema"  
	WHERE	"par_sistema"."id_azienda" = :il_az_idaz;

if sqlca.sqlcode<>0 then
	li_ret = 1
end if



return li_ret


end function

public function integer wf_calc_righe_cast ();


decimal		ld_totaleriga,			ld_prezzounit,			ld_quantita, 		ld_imponibile
decimal		ld_scontomerc,			ld_aliquota,			ld_imposta,			ld_perdetraz
decimal		ld_tot_val_omaggi,	ld_tot_val_sma15,		ld_tot_val_smiva
decimal		ld_val_omaggi_sm,		ld_val_sma15,			ld_val_smiva
decimal		ld_tot_val_om3, 		ld_peso

long			ll_numrighe,	ll_count
long			ll_idtabiva

string		ls_riga_valida
string		ls_sconto


ld_tot_val_omaggi = 0
ld_tot_val_sma15 = 0
ld_tot_val_smiva = 0

ll_numrighe = ids_riga.rowCount()			


for ll_count = 1 to ll_numrighe
	ls_riga_valida = ids_riga.GetItemString(ll_count,"c_riga_valida")
	if ls_riga_valida = "V" then
		
		ld_val_omaggi_sm = 0
		
		
		
		
		
			ld_peso = ids_riga.GetItemDecimal(ll_count, "peso_netto")
		
		
		if isnull(ld_peso) then ld_peso=0
		
		
		
		ld_totaleriga = ids_riga.GetItemDecimal(ll_count, "tot_riga_val_doc")
		ld_prezzounit = ids_riga.GetItemDecimal(ll_count, "prezzo")
		ld_quantita   = ids_riga.GetItemDecimal(ll_count, "quantita")
		ld_scontomerc = ids_riga.GetItemDecimal(ll_count, "qta_sconto_merce")
		ls_sconto     = ids_riga.GetItemString(ll_count, "sconto")
		
		if isNull (ld_totaleriga) then ld_totaleriga = 0
		if isNull (ld_prezzounit) then ld_prezzounit = 0
		if isNull (ld_quantita) then ld_quantita = 0
		if isNull (ld_scontomerc) then ld_scontomerc = 0
		if isNull (ls_sconto) then ls_sconto = ""
		
		ll_idtabiva = ids_riga.GetItemNumber(ll_count, "id_tab_iva")
		if isNull (ll_idtabiva) then
			ld_aliquota = 0
		else
			SELECT	"tab_iva"."per_aliquota", "tab_iva"."per_detrazione"
				INTO	:ld_aliquota, :ld_perdetraz
				FROM	"dba"."tab_iva"  
				WHERE	"tab_iva"."id_tab_iva" = :ll_idtabiva;
		end if	
		
		
		
		if wf_calc_prezzo_riga (ls_sconto, 1000000, 1) = 0 then
			
			ld_imposta= Ceiling((ld_prezzounit * ld_quantita * ld_aliquota) / 100)
			ld_val_omaggi_sm = (ld_quantita * ld_prezzounit)
			ld_tot_val_omaggi = ld_tot_val_omaggi + ld_val_omaggi_sm
			
			ld_val_omaggi_sm = wf_round(ld_val_omaggi_sm,il_rt_arrvalu, is_rt_tiparrvalu) 
			wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, ld_imposta, ld_val_omaggi_sm, ids_iva)
		else
			
			
			if ld_quantita <> 0 or ld_peso>0 then
				
				ld_imponibile = ld_totaleriga
				ld_imposta = Ceiling(ld_aliquota * ld_totaleriga / 100)

				wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, ld_imponibile, ld_imposta, 0, ids_iva)

				if ld_scontomerc <> 0 then
					ld_val_omaggi_sm = (ld_scontomerc * (ld_totaleriga / ld_quantita) )
					ld_tot_val_sma15 = ld_tot_val_sma15 + ld_val_omaggi_sm
					
					ld_val_omaggi_sm = wf_round(ld_val_omaggi_sm,il_rt_arrvalu, is_rt_tiparrvalu) 
					wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, 0, ld_val_omaggi_sm, ids_iva)
				end if
			else
				
				if ld_scontomerc <> 0 then
					ld_imposta = Ceiling (ld_scontomerc * ld_prezzounit * (ld_aliquota / 100))

					wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, ld_imposta, 0, ids_iva)
					if ll_idtabiva = il_az_idivaart15 then
						ld_val_omaggi_sm = (ld_scontomerc * ld_prezzounit)
						ld_tot_val_sma15 = ld_tot_val_sma15 + ld_val_omaggi_sm
						ld_val_omaggi_sm = wf_round(ld_val_omaggi_sm,il_rt_arrvalu, is_rt_tiparrvalu) 
						wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, 0, ld_val_omaggi_sm, ids_iva)
					else
						ld_val_omaggi_sm = (ld_scontomerc * ld_prezzounit) 
						ld_tot_val_smiva = ld_tot_val_smiva + ld_val_omaggi_sm
						
						ld_val_omaggi_sm = wf_round(ld_val_omaggi_sm,il_rt_arrvalu, is_rt_tiparrvalu) 
						wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, 0, ld_val_omaggi_sm, ids_iva)
					end if
				end if
			end if
		end if
	end if
next


if isNull(ld_tot_val_omaggi) then ld_tot_val_omaggi = 0
if isNull(ld_tot_val_sma15)  then ld_tot_val_sma15 = 0
if isNull(ld_tot_val_smiva)  then ld_tot_val_smiva = 0

ld_tot_val_om3 = ld_tot_val_omaggi + ld_tot_val_sma15 + ld_tot_val_smiva

ids_testa.SetItem(il_rowtesta, "c_val_omaggi", ld_tot_val_omaggi)
ids_testa.SetItem(il_rowtesta, "c_val_sc_merce_art_15", ld_tot_val_sma15)
ids_testa.SetItem(il_rowtesta, "c_val_sc_merce_iva", ld_tot_val_smiva)


return 0

end function

public function decimal wf_calc_prezzo_riga (string as_sconto, decimal ad_prezzo, decimal ad_quant);
long		ll_char_size,	ll_char_count,	ll_item_count
long		ll_row,			ll_pos_plus,	ll_pos_minus,	ll_pos
decimal  ldc_parte,		ldc_tot_riga
string	ls_parte,		ls_tot_riga
char		lch_sconto[],	lch_item[]
boolean 	lb_minus,		lb_non_calcolabile



lb_minus= FALSE
lch_item = ""
ll_item_count=0
if IsNull(ad_prezzo) then ad_prezzo = 0
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
							ad_prezzo = ad_prezzo + ad_prezzo * (ldc_parte / 100)
						else
							ad_prezzo = ad_prezzo - ad_prezzo * (ldc_parte / 100)
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
							ad_prezzo = ad_prezzo + ad_prezzo * (ldc_parte / 100)
						else
							ad_prezzo = ad_prezzo - ad_prezzo * (ldc_parte / 100)
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
				ad_prezzo = ad_prezzo + ad_prezzo * (ldc_parte / 100)
			else
				ad_prezzo = ad_prezzo - ad_prezzo * (ldc_parte / 100)
			end if
		end if
	end if
end if

RETURN ad_prezzo

end function

public function integer wf_calc_sconti_cast ();

long			ll_nrowsiva, ll_countiva
string		ls_scfinanz
decimal		ld_scfininc, ld_scfincas, ld_imponibile, ld_temp
decimal		ld_impriman, ld_percincond


ls_scfinanz = ids_testa.GetItemString(il_rowtesta,"documento_sconto_finanziario")
ld_scfininc = ids_testa.GetItemDecimal(il_rowtesta,"sconto_fin_incondizionato")
ld_scfincas = ids_testa.GetItemDecimal(il_rowtesta,"documento_sconto_fin_cassa")


ll_nrowsiva = ids_iva.rowCount()
for ll_countiva = 1 to ll_nrowsiva
	ld_temp = Round(ids_iva.GetItemNumber(ll_countiva, "c_proporzionale"), 2)
	ids_iva.SetItem(ll_countiva, "c_prop_imp", ld_temp)
next


If not (IsNull(ls_scfinanz) OR ls_scfinanz = "") then
	for ll_countiva = 1 to ll_nrowsiva
		ld_imponibile= ids_iva.GetItemDecimal (ll_countiva, "val_imponibile")		
		ld_imponibile= wf_calc_prezzo_riga (ls_scfinanz, ld_imponibile, 0)				
		ld_imponibile = wf_round(ld_imponibile,il_rt_arrvalu, is_rt_tiparrvalu) 
		ids_iva.SetItem(ll_countiva, "val_imp_scontato", ld_imponibile)
	next
else
	for ll_countiva = 1 to ll_nrowsiva
		ld_imponibile= ids_iva.GetItemDecimal(ll_countiva, "val_imponibile")		
		ids_iva.SetItem(ll_countiva, "val_imp_scontato", ld_imponibile)
	next
end if


ld_impriman=0
If not (IsNull(ld_scfininc) OR ld_scfininc = 0) then
	if ll_nrowsiva > 0 then
		for ll_countiva = 1 to ll_nrowsiva - 1
			ld_imponibile = ids_iva.GetItemDecimal(ll_countiva, "val_imp_scontato")
			ld_temp = ld_scfininc * ids_iva.GetItemDecimal(ll_countiva, "c_proporzionale")

			ld_percincond = wf_Round (ld_temp, il_rt_arrvalu, is_rt_tiparrvalu)
			
			ld_imponibile= ld_imponibile - ld_percincond
			ld_impriman= ld_impriman + ld_percincond
			
			ld_imponibile = wf_round(ld_imponibile,il_rt_arrvalu, is_rt_tiparrvalu) 
			ids_iva.SetItem(ll_countiva, "val_imp_scontato", ld_imponibile)
		next
		ld_imponibile= ids_iva.GetItemDecimal(ll_nrowsiva, "val_imp_scontato")
		ld_imponibile= ld_imponibile - ld_scfininc + ld_impriman
		
		ld_imponibile = wf_round(ld_imponibile,il_rt_arrvalu, is_rt_tiparrvalu) 
		ids_iva.SetItem(ll_nrowsiva, "val_imp_scontato", ld_imponibile)
	end if
end if


If not (IsNull(ld_scfincas) OR ld_scfincas = 0) then
	for ll_countiva = 1 to ll_nrowsiva
		ld_imponibile = ids_iva.GetItemDecimal(ll_countiva, "val_imp_scontato")
		ld_imponibile = ld_imponibile - (ld_imponibile * ld_scfincas / 100)
		
		ld_imponibile = wf_round(ld_imponibile,il_rt_arrvalu, is_rt_tiparrvalu) 
		ids_iva.SetItem (ll_countiva, "val_imp_scontato", ld_imponibile)
	next
end if


return 0


end function

public function decimal wf_round (decimal ad_numero, long al_arro, string as_tipo_arr);


decimal	ld_retval, ld_precis
long		ll_arro

ll_arro = al_arro
If ll_arro >= 0 then
	ld_precis = 10^ll_arro
else
	ll_arro = - ll_arro
	ld_precis = 1 / (10^ll_arro)
end if

CHOOSE CASE as_tipo_arr
	CASE "I"
		ld_retval = ad_numero/ ld_precis
		ld_retval = Truncate(ld_retval, 0) * ld_precis
	CASE "M"
		ld_retval = ad_numero / ld_precis
		ld_retval = Round(ld_retval, 0) * ld_precis
	CASE "S"
		ld_retval = ad_numero / ld_precis
		ld_retval = Ceiling(ld_retval) * ld_precis
	CASE ELSE
END CHOOSE

return ld_retval

end function

public function long wf_get_imp_max ();

long 		ll_nr_row, ll_count, ll_id_tab_iva_max
decimal 	ldc_prezzo, ldc_max_prezzo

ldc_max_prezzo=0
SetNull(ll_id_tab_iva_max)
ll_nr_row= ids_iva.RowCount()
for ll_count = 1 to ll_nr_row 
	ldc_prezzo= ids_iva.GetItemDecimal(ll_count, "val_imponibile")
	if ldc_prezzo > ldc_max_prezzo then
		ldc_max_prezzo=ldc_prezzo
		ll_id_tab_iva_max= ids_iva.GetItemNumber(ll_count, "id_tab_iva")
	end if
next


return ll_id_tab_iva_max

end function

public function long wf_get_ali_max ();

long 		ll_nr_row, ll_count, ll_id_tab_iva_max
decimal 	ldc_aliquota, ldc_max_aliquota

ldc_max_aliquota=0
SetNull(ll_id_tab_iva_max)
ll_nr_row= ids_iva.RowCount()
for ll_count = 1 to ll_nr_row 
	ldc_aliquota= ids_iva.GetItemDecimal(ll_count, "c_aliquota")
	if ldc_aliquota > ldc_max_aliquota then
		ldc_max_aliquota=ldc_aliquota
		ll_id_tab_iva_max= ids_iva.GetItemNumber(ll_count, "id_tab_iva")
	end if
next


return ll_id_tab_iva_max

end function

public function integer wf_calc_sp_noiva_cast ();

long 			ll_nr_row, ll_count, ll_id_tab_iva, ll_new_row,ll_row_found, ll_id_tab_iva_max, ll_id_spesa
long 			ll_cast_count, ll_cast_row_nr, ll_id_tab_iva_max_imp, ll_id_tab_iva_max_ali
decimal 		ldc_imponibile, ldc_prezzo,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_tot_imponibile, ldc_proporz
string 		ls_codice, ls_descr_breve, ls_sconto, ls_mod_calc_iva


ll_cast_row_nr = ids_iva.RowCount()
for ll_cast_count = 1 to ll_cast_row_nr
	ids_iva.SetItem(ll_cast_count, "c_prop_imp", ids_iva.GetItemNumber(ll_cast_count, "c_proporzionale"))
next
ll_id_tab_iva_max_imp = wf_get_imp_max()

ll_id_tab_iva_max_ali = wf_get_ali_max()

ll_nr_row = ids_spese.RowCount()
for ll_count = 1 to ll_nr_row
	ll_id_tab_iva = ids_spese.GetItemNumber(ll_count, "id_tab_iva")
	if (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then 
		
		ls_mod_calc_iva = ids_spese.GetItemString(ll_count, "cc_mod_calc_iva")
		CHOOSE CASE ls_mod_calc_iva
			CASE "I"
				ll_id_tab_iva_max = ll_id_tab_iva_max_imp
			CASE "A"
				ll_id_tab_iva_max = ll_id_tab_iva_max_ali
			CASE "P"
				ll_id_tab_iva_max = 0
			CASE ELSE
				ll_id_tab_iva_max = 0
		END CHOOSE 
		ldc_importo= ids_spese.GetItemDecimal(ll_count, "importo")
		
		if (IsNull(ldc_importo) OR ldc_importo = 0) then 
			if ids_riga.RowCount() > 0 then
				
				
				
				ldc_tot_righe= ids_riga.GetItemDecimal(1, "c_tot_righe")
				
				
				
				ldc_importo=ldc_tot_righe * ids_spese.GetItemDecimal(ll_count, "percentuale") / 100
				
				ids_spese.SetItem(ll_count, "importo", ldc_importo)
			end if	
		end if
		if not (IsNull(ldc_importo) OR ldc_importo = 0) then 
			if ll_id_tab_iva_max>0 then
				
				ll_id_tab_iva= ll_id_tab_iva_max
				ids_spese.SetItem(ll_count, "id_tab_iva_cod", ll_id_tab_iva)
				
				
				
				ll_row_found=ids_iva.Find("id_tab_iva =" + string(ll_id_tab_iva),1,ids_iva.RowCount())
				if ll_row_found <> 0 then
					ldc_imponibile= ids_iva.GetItemDecimal(ll_row_found,"val_spese")
					if IsNull(ldc_imponibile) then ldc_imponibile = 0
					if not IsNull(ldc_importo) then 
						ids_iva.SetItem(ll_row_found,"val_spese", ldc_imponibile + ldc_importo)
					end if
					ldc_aliquota= ids_iva.GetItemDecimal(ll_row_found,"c_aliquota")
				end if
			else
				
				ll_cast_row_nr = ids_iva.RowCount()
				for ll_cast_count = 1 to ll_cast_row_nr
					
					ldc_proporz= ids_iva.GetItemDecimal(ll_cast_count,"c_proporzionale")
					ldc_imponibile= ids_iva.GetItemDecimal(ll_cast_count,"val_spese") + (ldc_importo * ldc_proporz)
					if IsNull(ldc_proporz) then ldc_proporz = 0
					if IsNull(ldc_imponibile) then ldc_imponibile = 0
					if not IsNull(ldc_importo) then ids_iva.SetItem(ll_cast_count,"val_spese", ldc_imponibile)
				next
			end if
		end if
	end if
next


return 0
end function

public function integer wf_calc_sp_iva_cast ();

long 			ll_nr_row, ll_count, ll_id_tab_iva, ll_new_row,ll_row_found, ll_id_tab_iva_max, ll_id_spesa
long 			ll_cast_count, ll_cast_row_nr, ll_id_tab_iva_max_imp, ll_id_tab_iva_max_ali, ll_nr_rate
long			ll_id_sog_comm
decimal 		ldc_imponibile, ldc_prezzo,ldc_aliquota, ldc_imposta, ldc_percentuale, ldc_importo, ldc_tot_righe
decimal 		ldc_max_prezzo, ldc_quantita, ldc_prezzo_un, ldc_tot_imponibile, ldc_proporz, ldc_per_detrazione
string 		ls_codice, ls_descr_breve, ls_sconto, ls_mod_calc_iva



ll_nr_row = ids_spese.RowCount()
for ll_count = 1 to ll_nr_row
	ll_id_tab_iva= ids_spese.GetItemNumber(ll_count, "id_tab_iva")
	if not (IsNull(ll_id_tab_iva) OR ll_id_tab_iva = 0) then 
		ll_id_spesa = ids_spese.GetItemDecimal(ll_count, "id_spesa")
		
		SELECT "spesa"."codice"  
			INTO :ls_codice  
			FROM "dba"."spesa"  
			WHERE "spesa"."id_spesa" = :ll_id_spesa   ;
		CHOOSE CASE ls_codice
			CASE "C"
				ldc_importo= ids_spese.GetItemDecimal(ll_count, "importo")
				if not ((IsNull(ldc_importo) OR ldc_importo = 0)) then
					ids_spese.SetItem(ll_count, "importo", ldc_importo)
					
					ll_row_found = ids_iva.Find("id_tab_iva =" + string(ll_id_tab_iva),1,ids_iva.RowCount())
					if ll_row_found= 0 then
						
						ll_new_row= ids_iva.InsertRow(0)
						SELECT "tab_iva"."per_aliquota", "tab_iva"."per_detrazione"
						 INTO :ldc_aliquota, :ldc_per_detrazione
						 FROM "dba"."tab_iva"  
						 WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva   ;
						 
						
						
						
						
						
						ids_iva.SetItem(ll_new_row, "id_tab_iva",ll_id_tab_iva)
						ids_iva.SetItem(ll_new_row, "val_spese", ldc_importo)
						ids_iva.SetItem(ll_new_row, "c_aliquota", ldc_aliquota)
						ids_iva.SetItem(ll_new_row, "cc_per_detrazione", ldc_per_detrazione)
						ldc_imposta= Ceiling(ldc_aliquota * ldc_importo / 100)
						ids_iva.SetItem(ll_new_row, "c_imposta", ldc_imposta)
					else
						
						ldc_imponibile= ids_iva.GetItemDecimal(ll_row_found,"val_spese")
						if IsNull(ldc_imponibile) then ldc_imponibile=0 
						if not IsNull(ldc_importo) then ids_iva.SetItem(ll_row_found,"val_spese", ldc_imponibile + ldc_importo)
					end if
				end if
			CASE ELSE
				
				ldc_importo= ids_spese.GetItemDecimal(ll_count, "importo")
				
				if (IsNull(ldc_importo) OR ldc_importo = 0) then 
						if ids_riga.RowCount() > 0 then
							ldc_tot_righe= ids_riga.GetItemDecimal(1, "c_tot_righe")
							ldc_importo=ldc_tot_righe * ids_spese.GetItemDecimal(ll_count, "percentuale") / 100
							
							ids_spese.SetItem(ll_count, "importo", ldc_importo)
						end if	
				end if
				if not (IsNull(ldc_importo) OR ldc_importo = 0) then 
					
					ll_row_found = ids_iva.Find("id_tab_iva =" + string(ll_id_tab_iva),1,ids_iva.RowCount())
					if ll_row_found = 0 then
						ll_new_row = ids_iva.InsertRow(0)
						SELECT "tab_iva"."per_aliquota", "tab_iva"."per_detrazione"
						 INTO :ldc_aliquota, :ldc_per_detrazione
						 FROM "dba"."tab_iva"  
						 WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva   ;
						
						
						
						
						
						ids_iva.SetItem(ll_new_row, "id_tab_iva",ll_id_tab_iva)
						ids_iva.SetItem(ll_new_row, "val_spese", ldc_importo)
						ids_iva.SetItem(ll_new_row, "c_aliquota", ldc_aliquota)
						ids_iva.SetItem(ll_new_row, "cc_per_detrazione", ldc_per_detrazione)
						ldc_imposta= Ceiling(ldc_aliquota * ldc_importo / 100)
						ids_iva.SetItem(ll_new_row, "c_imposta", ldc_imposta)
					else
						ldc_imponibile = ids_iva.GetItemDecimal(ll_row_found,"val_spese")
						if IsNull(ldc_imponibile) then ldc_imponibile=0
						if not IsNull(ldc_importo) then ids_iva.SetItem(ll_row_found,"val_spese", ldc_imponibile + ldc_importo)
					end if
				end if
		END CHOOSE
	end if
next

return 0

end function

public function decimal wf_calc_bolli_sc_cast ();
s_scadenze		lstr_scadenze
boolean			lb_ok
long				ll_id_cp, ll_id_anag, ll_nr_row, ll_bollo_row, ll_row_found
decimal			ld_impon, ld_impos, ld_bollo, ld_importo
date				ld_iniz
decimal			ld_impr[], ld_ivar[]
date				ld_datr[]
integer			li_size, li_i

ld_bollo = 0
ll_nr_row = ids_iva.RowCount()
If ll_nr_row > 0 then
	ld_impon = ids_iva.GetItemDecimal(ll_nr_row,"c_tot_imponibile")
	ld_impos = ids_iva.GetItemDecimal(ll_nr_row,"c_tot_imposta")
	
	ld_iniz = Date("01/01/1999")
	
	
	ll_id_cp = il_rt_cpag
	
	
	ll_id_anag = il_rt_scom
	
	
	
	
	
	
	
	
	If ld_bollo > 0 then
		
		
		ll_bollo_row = ids_spese.Find("id_spesa_cod = " + String(il_az_idspesabol),1,ids_spese.RowCount())
		if not (IsNull(ll_bollo_row) OR ll_bollo_row=0) then 
			ld_importo = ids_spese.GetItemDecimal(ll_bollo_row, "importo")
			If IsNull(ld_importo) then ld_importo =0
			ids_spese.SetItem(ll_bollo_row, "importo", ld_bollo + ld_importo)

		else
			ll_bollo_row=ids_spese.InsertRow(0)
			ids_spese.SetItem(ll_bollo_row, "id_spesa_cod", il_az_idspesabol)
			
			
			
			
			ids_spese.SetItem(ll_bollo_row, "id_tab_iva_cod", il_az_idivaart15)
			ids_spese.SetItem(ll_bollo_row, "importo", ld_bollo)
		end if
	end if
end if


return ld_bollo


end function

public subroutine wf_setta_incasso ();


long			ll_id_spesa_inc, ll_nrate, ll_row, ll_tabiva_sp
decimal		ld_importo
string 		ls_sp_ges_cp

ld_importo = 0
if pos(is_ch_spgest,'C') >0 then
	
	ll_id_spesa_inc = 0
	SELECT	"spesa"."id_spesa", "spesa"."id_tab_iva"
		INTO	:ll_id_spesa_inc, :ll_tabiva_sp
		FROM	"dba"."spesa"  
		WHERE	"spesa"."codice" = 'C';
	
	if ll_id_spesa_inc>0 then
		SELECT	"spesa_sog_commerciale"."importo"
			INTO	:ld_importo
			FROM	"spesa_sog_commerciale"  
			WHERE	("spesa_sog_commerciale"."id_sog_commerciale" = :il_rt_scom ) AND  
					("spesa_sog_commerciale"."id_spesa" = :ll_id_spesa_inc );
		if sqlca.sqlcode<>0 then
			ld_importo = 0
		end if
	end if
	
	if (ll_id_spesa_inc>0)and(ld_importo=0) then
		declare cp cursor for
			SELECT "tipo_pagamento"."spese_gestite"  
			 FROM "app_pagamento",   
					"tipo_pagamento"  
			WHERE ( "tipo_pagamento"."id_tipo_pagamento" = "app_pagamento"."id_tipo_pagamento" ) and  
					( ( "app_pagamento"."id_con_pagamento" = :il_rt_ocpag ) )   ;
		open cp;
		fetch cp into :ls_sp_ges_cp;
		do while sqlca.sqlcode=0
			if pos(ls_sp_ges_cp,'C') >0  then
				select importo
				into :ld_importo
				from spesa
				where spesa.id_spesa=:ll_id_spesa_inc;
			end if
			fetch cp into :ls_sp_ges_cp;
		loop
		close cp;
	end if
	
	
	
	
	if ld_importo <> 0 then
		ll_nrate = iuo_pag.uf_rate_ges_spesa(il_rt_ocpag, "C")
		
		ld_importo = ld_importo * ll_nrate / idc_td_cambio
		
		ll_row = ids_spese.InsertRow(0)
		if ll_row>0 then
			ids_spese.SetItem(ll_row,"id_spesa",ll_id_spesa_inc)
			ids_spese.SetItem(ll_row,"importo",ld_importo)
			ids_spese.SetItem(ll_row,"percentuale",0)
			ids_spese.SetItem(ll_row,"id_tab_iva",ll_tabiva_sp)
		end if
		
	end if

end if

end subroutine

public function decimal wf_calc_bollo_cast ();
long 			ll_nr_row, ll_count, ll_id_tab_iva, ll_bollo_row, ll_row_found
decimal		ldc_imp_min_fattura, ldc_imp_bollo_fattura, ldc_totale, ldc_bollo, ldc_importo

ldc_bollo = 0
ll_nr_row = ids_iva.RowCount()
if ll_nr_row > 0 then
	
	ldc_totale=ids_iva.GetItemDecimal(ll_nr_row, "c_tot_imponibile_spesa")
	
	for ll_count =  1 to ll_nr_row
		
		ll_id_tab_iva= ids_iva.GetItemNumber(ll_count, "id_tab_iva")
		SELECT	"tab_iva"."imp_min_fattura",	"tab_iva"."imp_bollo_fattura"  
			INTO	:ldc_imp_min_fattura,	:ldc_imp_bollo_fattura  
			FROM	"dba"."tab_iva"
			WHERE "tab_iva"."id_tab_iva" = :ll_id_tab_iva;
		if Not(Isnull(ldc_imp_min_fattura) OR ldc_imp_min_fattura <=0 OR &
				Isnull(ldc_imp_bollo_fattura) OR ldc_imp_bollo_fattura <=0 ) then
			
			if ldc_imp_min_fattura <= ldc_totale then
				ldc_bollo= ldc_bollo + ldc_imp_bollo_fattura
			end if
		end if
	next
	
	If ldc_bollo > 0 then 
		
		ll_bollo_row = ids_spese.Find("id_spesa_cod = " + String(il_az_idspesabol),1,ids_spese.RowCount())
		
		if ll_bollo_row>0 then
			ldc_importo= ids_spese.GetItemDecimal(ll_bollo_row, "importo")
			If isNull(ldc_importo) then ldc_importo=0
			ids_spese.SetItem(ll_bollo_row, "importo", ldc_bollo + ldc_importo)
		else
			ll_bollo_row=ids_spese.InsertRow(0)
			ids_spese.SetItem(ll_bollo_row, "id_spesa", il_az_idspesabol)
			
			
			
			
			
			ids_spese.SetItem(ll_bollo_row, "id_tab_iva", il_az_idivaart15)
			ids_spese.SetItem(ll_bollo_row, "importo", ldc_bollo)
		end if
	end if
end if

return ldc_bollo

end function

public subroutine wf_calc_sp_bollo_cast ();

long		ll_nrows, ll_count, ll_idspesa, ll_idtabiva, ll_rowiva
string	ls_codice
decimal	ld_importo, ld_aliquota, ld_perdetraz, ld_imponibile, ld_imposta

ll_nrows = ids_spese.RowCount()
for ll_count = 1 to ll_nrows
	ll_idspesa= ids_spese.GetItemNumber(ll_count, "id_spesa")
	
	
	SELECT "spesa"."codice"  
		INTO :ls_codice  
		FROM "dba"."spesa"  
		WHERE "spesa"."id_spesa" = :ll_idspesa;

	if ls_codice = "B" then
		ll_idtabiva = ids_spese.GetItemNumber(ll_count, "id_tab_iva")
		if IsNull(ll_idtabiva) then ll_idtabiva = il_az_idivaart15
		ld_importo = ids_spese.GetItemDecimal(ll_count, "importo")
		if not (IsNull(ld_importo) OR ld_importo=0) then
			
			ll_rowiva = ids_iva.find("id_tab_iva =" + string(ll_idtabiva),1,ids_iva.RowCount())
			if ll_rowiva = 0 then
				ll_rowiva = ids_iva.InsertRow(0)
				SELECT "tab_iva"."per_aliquota", "tab_iva"."per_detrazione"
					 INTO :ld_aliquota, :ld_perdetraz
					 FROM "dba"."tab_iva"  
					 WHERE "tab_iva"."id_tab_iva" = :ll_idtabiva;
				
				
				
				
				
				ids_iva.SetItem(ll_rowiva, "id_tab_iva",ll_idtabiva)
				ids_iva.SetItem(ll_rowiva, "val_spese", ld_importo)
				ids_iva.SetItem(ll_rowiva, "c_aliquota", ld_aliquota)
				ids_iva.SetItem(ll_rowiva, "cc_per_detrazione", ld_perdetraz)
				ld_imposta = Ceiling(ld_aliquota * ld_importo / 100)
				ids_iva.SetItem(ll_rowiva, "c_imposta", ld_imposta)
			else
				ld_imponibile = ids_iva.GetItemDecimal(ll_rowiva,"val_spese")
				if IsNull(ld_imponibile) then ld_imponibile = 0
				ids_iva.SetItem(ll_rowiva,"val_spese", ld_imponibile + ld_importo)
				ld_imposta= ids_iva.GetItemDecimal(ll_rowiva,"c_imposta")
				if IsNull(ld_imposta) then ld_imposta=0
				ld_imposta= ld_imposta + Ceiling(ld_aliquota * ld_importo / 100)
				ids_iva.SetItem(ll_rowiva, "c_imposta", ld_imposta)
			end if			
		end if
	end if
next
end subroutine

public function long wf_del_spese_nulle ();
long 		ll_nr_row, ll_count, ll_row
decimal 	ldc_valore

ll_nr_row= ids_spese.RowCount()
for ll_count =  ll_nr_row to 1 step -1
	ldc_valore=ids_spese.GetItemNumber(ll_count, "importo")
	If (IsNull(ldc_valore) Or ldc_valore=0) then
		ids_spese.DeleteRow(ll_count)
	end if
next

return 0

end function

public function long wf_setup_cast_iva (long al_riga);
long		ll_nr_row, ll_count
decimal	ldc_tot_imp_val_calc ,ldc_tot_iva_val_calc 
decimal	ldc_tot_imp_lire_calc ,ldc_tot_iva_lire_calc 

ll_nr_row = ids_iva.RowCount()
if ll_nr_row > 0 then
	FOR ll_count=1 to ll_nr_row
		ldc_tot_iva_val_calc=ids_iva.GetItemDecimal(ll_count,"c_iva_val")
		ldc_tot_imp_val_calc=ids_iva.GetItemDecimal(ll_count,"c_imponibile_spesa")
		ldc_tot_iva_lire_calc=ids_iva.GetItemDecimal(ll_count,"c_iva_lire")
		ldc_tot_imp_lire_calc=ids_iva.GetItemDecimal(ll_count,"c_imponibile_spesa_lire")
		ids_iva.SetItem(ll_count,"val_tot_iva_v", ldc_tot_iva_val_calc)
		ids_iva.SetItem(ll_count,"val_tot_imp_v", ldc_tot_imp_val_calc)
		ids_iva.SetItem(ll_count,"val_tot_iva_l", ldc_tot_iva_lire_calc)
		ids_iva.SetItem(ll_count,"val_tot_imp_l", ldc_tot_imp_lire_calc)
	NEXT
end if

RETURN 0

end function

public function decimal wf_genera_scadenze ();

string		ls_tipo_scadenza
long			ll_id_banca_sc, ll_id_banca_azienda
string		lb_scadragg
decimal		ld_impon, ld_impos, ld_tot_imp_val
date			ldt_iniz
s_scadenze	lstr_scadenze

long			ll_nrowsiva, ll_size, ll_i, ll_row
boolean		lb_ok
decimal		ld_temp, ld_impparzv, ld_implire, ld_impval, ld_bollotot

datastore ds_scade
ds_scade=create datastore
ds_scade.dataobject='ds_spec_scadenza'
ds_scade.reset()
ds_scade.settransobject(sqlca)

integer li_giorno_con, li_mese_con, li_anno, li_giorno, li_mese
string  ls_anno, ls_giorno, ls_mese
date    ldc_nuova_data

ld_bollotot=0

if (is_statoscgen = "N" or isnull(is_statoscgen)) then &
	return ld_bollotot
	
choose case right(is_td_tiporeg,1)
	case "A"
		ls_tipo_scadenza = "P"
	case "V"
		ls_tipo_scadenza = "A"
	case else
		ls_tipo_scadenza = "A"
end choose

SELECT	"sog_commerciale"."id_banca_sog_commerciale",
			"sog_commerciale"."scad_raggruppate"
	INTO :ll_id_banca_sc, :lb_scadragg
	FROM "dba"."sog_commerciale"  
	WHERE "sog_commerciale"."id_sog_commerciale" = :il_rt_scom;

if il_rt_obapp>0 then ll_id_banca_sc = il_rt_obapp

SELECT "azienda"."id_banca_azienda"  
	INTO :ll_id_banca_azienda  
	FROM "dba"."azienda"  
	WHERE "azienda"."id_azienda" = :il_az_idaz;

ll_nrowsiva= ids_iva.RowCount()
If ll_nrowsiva > 0 then
	ld_impon = ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_imponibile_spesa_lire")
	
	
	
	decimal	ldc_impon_acc
	long		ll_id_tab_iva_acconto
	if ids_testa.rowcount()>0 then
		ldc_impon_acc=ids_testa.getitemdecimal(il_rowtesta,"imp_acconto")
		ll_id_tab_iva_acconto=ids_testa.getitemdecimal(il_rowtesta,"id_tab_iva_acconto")
	end if
	if isnull(ids_testa) then ldc_impon_acc=0
	if ll_id_tab_iva_acconto>0 then
		ld_impon=ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_imponibile_spesa_lire")
	else
		ld_impon=ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_imponibile_spesa_lire")-ldc_impon_acc
	end if
	

	
	ld_impos = ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_iva_lire")

	ld_tot_imp_val = ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_imponibile_spesa") + &
							ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_iva_val")

	ldt_iniz = ids_testa.GetItemDate(il_rowtesta,"documento_data_dec_pagamento")
	if isNull(ldt_iniz) or ldt_iniz = date("01/01/1900") then ldt_iniz = today()
	
	
	
	lb_ok = iuo_pag.uf_calcola_pagamenti_e(il_rt_ovalu,ld_impon,ld_impos,ldt_iniz,il_rt_scom,il_rt_ocpag,lstr_scadenze)	
	
	
	ids_scad.reset()
	ll_size = UpperBound(lstr_scadenze.dc_imp_out)
	
	if not (IsNull(ll_size) OR ll_size<=0) then
		ld_impparzv = 0
		
		
		
		for ll_i = 1 to ll_size - 1
			ll_row = ids_scad.insertRow(0)
			if ll_row>0 then
				
				

					li_giorno_con=day(lstr_scadenze.d_date[ll_i])
					li_mese_con=month(lstr_scadenze.d_date[ll_i])
					ds_scade.reset()
					ds_scade.retrieve(il_rt_scom,li_giorno_con,li_mese_con)
					if ds_scade.rowcount()>0 then
						li_giorno=ds_scade.getitemnumber(1,'gg_app')
						li_mese=ds_scade.getitemnumber(1,'ms_app')
					

						if li_mese_con>li_mese then
							li_anno=year(lstr_scadenze.d_date[ll_i]) + 1
					  	else
							if li_mese_con=li_mese and li_giorno_con>li_giorno then
								li_anno=year(lstr_scadenze.d_date[ll_i]) + 1
					   	else
								li_anno=year(lstr_scadenze.d_date[ll_i])
							end if
						end if

				
				
					ls_anno=string(li_anno)
					ls_giorno=string(li_giorno)
					if len(ls_giorno)=1 then ls_giorno='0'+ls_giorno
					ls_mese=string(li_mese)
					if len(ls_mese)=1 then ls_mese='0'+ls_mese
					ldc_nuova_data=date(ls_giorno+'/'+ls_mese+'/'+ls_anno)
					lstr_scadenze.d_date[ll_i]=ldc_nuova_data
				end if
				
				ids_scad.SetItem(ll_row, "id_sog_commerciale", il_rt_scom)
				ids_scad.SetItem(ll_row,"data_scadenza",lstr_scadenze.d_date[ll_i])
				ids_scad.SetItem(ll_row, "id_valuta", il_rt_ovalu)
				ids_scad.SetItem(ll_row, "cambio", idc_td_cambio)
				
				
				
				if isnull(ll_id_tab_iva_acconto) or ll_id_tab_iva_acconto<1 then
					ld_impval = ld_impval - ldc_impon_acc
				end if
				
				
				ld_temp = (lstr_scadenze.dc_iva_out[ll_i] + lstr_scadenze.dc_imp_out[ll_i]) / idc_td_cambio
				ld_impval= wf_Round(ld_temp, il_rt_arrvalu, is_rt_tiparrvalu)
				ld_impparzv = ld_impparzv + ld_impval
				ld_implire = lstr_scadenze.dc_iva_out[ll_i] + lstr_scadenze.dc_imp_out[ll_i] + lstr_scadenze.dc_bollo[ll_i]

				ids_scad.SetItem(ll_row,"imp_valuta", ld_impval + (lstr_scadenze.dc_bollo[ll_i] / idc_td_cambio))
				ids_scad.SetItem(ll_row,"importo", ld_implire)

				ids_scad.SetItem(ll_row,"id_tipo_pagamento",lstr_scadenze.l_id_tipo_pagamento[ll_i])
				ids_scad.SetItem(ll_row,"id_banca_sog_commerciale",ll_id_banca_sc)
				ids_scad.SetItem(ll_row,"stato_scadenza",is_statoscgen)
				ids_scad.SetItem(ll_row,"esito_pagamento","E")
				ids_scad.SetItem(ll_row,"scadenza_da_raggruppare",lb_scadragg)
				ids_scad.SetItem(ll_row, "tipo_scadenza", ls_tipo_scadenza)
				
			end if
		next
		
		
		
		ll_row = ids_scad.InsertRow(0)
		if ll_row>0 then
			
			li_giorno_con=day(lstr_scadenze.d_date[ll_size])
			li_mese_con=month(lstr_scadenze.d_date[ll_size])


				ds_scade.reset()
				ds_scade.retrieve(il_rt_scom,li_giorno_con,li_mese_con)
				if ds_scade.rowcount()>0 then
					li_giorno=ds_scade.getitemnumber(1,'gg_app')
					li_mese=ds_scade.getitemnumber(1,'ms_app')
					if li_mese_con>li_mese then
						li_anno=year(lstr_scadenze.d_date[ll_size]) + 1
					  else
						if li_mese_con=li_mese and li_giorno_con>li_giorno then
							li_anno=year(lstr_scadenze.d_date[ll_size]) + 1
					   else
							li_anno=year(lstr_scadenze.d_date[ll_size])
						end if
					end if

				
				ls_anno=string(li_anno)
				ls_giorno=string(li_giorno)
				if len(ls_giorno)=1 then ls_giorno='0'+ls_giorno
				ls_mese=string(li_mese)
				if len(ls_mese)=1 then ls_mese='0'+ls_mese
				ldc_nuova_data=date(ls_giorno+'/'+ls_mese+'/'+ls_anno)
				lstr_scadenze.d_date[ll_size]=ldc_nuova_data
			end if
			
			ids_scad.SetItem(ll_row, "id_sog_commerciale", il_rt_scom)
			ids_scad.SetItem(ll_row,"data_scadenza",lstr_scadenze.d_date[ll_size])
			ids_scad.SetItem(ll_row, "id_valuta", il_rt_ovalu)
			ids_scad.SetItem(ll_row, "cambio", idc_td_cambio)

			
			
			if isnull(ll_id_tab_iva_acconto) or ll_id_tab_iva_acconto<1 then
				ld_tot_imp_val = ld_tot_imp_val - ldc_impon_acc
			end if
			
			
			ld_implire= ((ld_tot_imp_val  - ld_impparzv) * idc_td_cambio) + lstr_scadenze.dc_bollo[ll_size]
			ids_scad.SetItem(ll_row,"imp_valuta", ld_implire / idc_td_cambio)
			ids_scad.SetItem(ll_row,"importo", ld_implire)
			
			ids_scad.SetItem(ll_row,"id_tipo_pagamento",lstr_scadenze.l_id_tipo_pagamento[ll_size])
			ids_scad.SetItem(ll_row,"id_banca_sog_commerciale",ll_id_banca_sc)
			ids_scad.SetItem(ll_row,"stato_scadenza",is_statoscgen)
			ids_scad.SetItem(ll_row,"esito_pagamento","E")
			ids_scad.SetItem(ll_row,"scadenza_da_raggruppare",lb_scadragg)
			ids_scad.SetItem(ll_row, "tipo_scadenza", ls_tipo_scadenza)
		end if
		ld_bollotot= lstr_scadenze.dc_bollo_tot / idc_td_cambio
	end if
end if

if ld_bollotot>0 then
	
	ll_row = ids_spese.Find("id_spesa = " + String(il_az_idspesabol),1,ids_spese.RowCount())
	if (ll_row>0) and (not isNull(ll_row)) then
		ld_impval = ids_spese.GetItemDecimal(ll_row, "importo")
		If IsNull(ld_impval) then ld_impval = 0
		ids_spese.SetItem (ll_row, "importo", ld_bollotot + ld_impval)
	else
		ll_row = ids_spese.InsertRow(0)
		ids_spese.SetItem(ll_row, "id_spesa", il_az_idspesabol)
		ids_spese.SetItem(ll_row, "id_tab_iva", il_az_idivaart15)
		ids_spese.SetItem(ll_row, "importo", ld_bollotot)
	end if
end if

DESTROY ds_scade

return ld_bollotot

end function

public function boolean wf_calc_cpt ();



boolean		lb_ok
long			ll_nr



lb_ok = true

ids_cpt.reset()
ll_nr = wf_calc_cpt_righe()						
if ll_nr>0 then
	wf_calc_cpt_sconti()								
	wf_calc_cpt_spese()								
	
	wf_calc_cpt_totali()								
	
	
	wf_calc_cpt_quadra() 							
	wf_calc_cpt_ripul() 								
	
	
end if

ids_cpt.SetSort("tipo_riga_cpt A")
ids_cpt.Sort()

return lb_ok

end function

public function integer wf_calc_cpt_righe ();

long		ll_nrows, ll_count, ll_idcpt, ll_idtabiva, ll_create, ll_id_uc
decimal	ld_totriga, ld_qta, ld_qtasm, ld_preuni, ld_prenet, ld_temp, ld_peso
string	ls_rigavalida, ls_sconto


string ls_cpt_sconti
long ll_id_cpt_sconti, ll_id_sog_commerciale, ll_gen_row, ll_id_articolo
decimal ldc_sc_fin_cassa, ldc_sc_incondizionato, ldc_sconto_riga, ldc_sconto_unit_riga, ldc_sconto_merce,ldc_imponibile, ldc_imponibile_non_sc
string ls_sc_finanziario

select gest_cpt_sconti
into :ls_cpt_sconti
from par_sistema;

ll_id_sog_commerciale=ids_testa.getitemnumber(il_rowtesta,'id_sog_commerciale')
ls_sc_finanziario= ids_testa.GetItemString(il_rowtesta, "documento_sconto_finanziario")
ldc_sc_incondizionato= ids_testa.uf_GetItemDecimal(il_rowtesta, "sconto_fin_incondizionato")
ldc_sc_fin_cassa= ids_testa.GetItemDecimal(il_rowtesta, "documento_sconto_fin_cassa")

long ll_id_valuta, ll_id_esercizio, ll_id_val_conto, ll_id_val_euro
decimal ld_cambio_appoggio, ld_parita_euro
ll_id_valuta=ids_testa.getitemnumber(il_rowtesta,'documento_id_valuta_des')
ll_id_esercizio=ids_testa.getitemnumber(il_rowtesta,'c_esercizio')

SELECT "valuta"."cambio",   
		 "valuta"."parita_euro"
	INTO :ld_cambio_appoggio,   
		  :ld_parita_euro
	FROM "dba"."valuta"  
	WHERE "valuta"."id_valuta" = :ll_id_valuta;

select id_val_euro
into :ll_id_val_euro
from par_sistema;

select id_valuta
into :ll_id_val_conto
from esercizio
where id_esercizio = :ll_id_esercizio;

select dec_significativi, tipo_arrotondamento
into :il_dec_significativi, :is_tipo_arr
from valuta
where id_valuta = :ll_id_val_conto;

if ll_id_val_conto = ll_id_val_euro then ld_cambio_appoggio = ld_parita_euro

ll_create = 0
ll_nrows = ids_riga.RowCount()
for ll_count = 1 to ll_nrows
	
	ld_totriga = ids_riga.GetItemDecimal(ll_count, "tot_riga_val_az")
	if IsNull(ld_totriga)  then ld_totriga = 0
	ld_qta = ids_riga.GetItemDecimal(ll_count, "quantita")
	if IsNull(ld_qta)  then ld_qta = 0

	
	ll_id_uc = ids_riga.GetItemnumber(ll_count, "id_unita_confezione")
	ld_peso = ids_riga.GetItemDecimal(ll_count, "peso_netto")
	if IsNull(ld_peso)  then ld_peso = 0	
	string ls_tipo
	select tipo
	into :ls_tipo
	from unita_confezione, unita_misura
	where (unita_confezione.id_unita_confezione=:ll_id_uc) and (unita_confezione.id_unita_misura=unita_misura.id_unita_misura);
	
	
	ld_qtasm = ids_riga.GetItemDecimal(ll_count, "qta_sconto_merce")
	if IsNull(ld_qtasm)  then ld_qtasm = 0
	ld_preuni = ids_riga.GetItemDecimal(ll_count, "prezzo")
	if IsNull(ld_preuni)  then ld_preuni = 0
	ls_sconto = ids_riga.GetItemString(ll_count, "sconto")
	if IsNull(ls_sconto)  then ls_sconto = ""
	
	ll_idtabiva= ids_riga.GetItemNumber(ll_count, "id_tab_iva")
	ll_idcpt = ids_riga.GetItemNumber(ll_count, "id_conto")
	If IsNull(ll_idcpt) OR ll_idcpt = 0 then ll_idcpt = il_az_idcontoprd
	
	ls_rigavalida = ids_riga.GetItemString(ll_count, "c_riga_valida")
	ld_prenet = wf_calc_prezzo_riga (ls_sconto, 1000000, 1)
	
	If (ls_rigavalida="V") then
		
		
		ldc_sconto_riga = ids_riga.GetItemnumber(ll_count, "sconto_riga")
		ldc_sconto_unit_riga = 0
		ldc_sconto_merce= ids_riga.uf_GetItemDecimal(ll_count, "qta_sconto_merce")
		if IsNull(ldc_sconto_merce)  then ldc_sconto_merce = 0		
		ll_id_articolo= ids_riga.GetItemNumber(ll_count, "id_articolo")
		
		if ls_cpt_sconti = 'S' then
			uo_cpt_sconti u_cpt_sconti
			u_cpt_sconti = create uo_cpt_sconti

		 	
			
			ll_id_cpt_sconti = u_cpt_sconti.uf_cpt_sconti("",0,0,ls_sconto,ldc_sconto_merce,ldc_sconto_riga,ldc_sconto_unit_riga, ll_id_sog_commerciale, ll_id_articolo)							  
		 	
			 
			
			destroy (u_cpt_sconti)
		end if
		
		
		if ld_prenet = 0 then
			
			
			
			if ls_tipo = 'P' then
				ld_temp = (ld_peso * ld_preuni * ld_cambio_appoggio) 
			else
				ld_temp = (ld_qta * ld_preuni * ld_cambio_appoggio) 
			end if			
			
			
			
			ld_temp = f_round(ld_temp,il_dec_significativi, is_tipo_arr) 
		
			
			if ls_cpt_sconti = 'S' and (isnull(ll_id_cpt_sconti) = false or ll_id_cpt_sconti <> 0) then 
				
				
				wf_insert_riga_cpt (ll_idcpt, "C", ids_cpt, ld_temp, 0, 0, 0)				
				wf_insert_riga_cpt (ll_id_cpt_sconti, "S", ids_cpt, ld_temp, 0, 0, 0)				
			else 
				wf_insert_riga_cpt (ll_idcpt, "C", ids_cpt, 0, 0, ld_temp, 0)				
				
			end if
			
		else
			
			ld_temp = (ld_qtasm * ld_preuni)
			
								
			
			if ls_cpt_sconti = 'S' and (isnull(ll_id_cpt_sconti) = false or ll_id_cpt_sconti <> 0) then	
	
				
				if ls_tipo = 'P' then
					ldc_imponibile_non_sc=(ld_peso * ld_preuni * ld_cambio_appoggio) 
				else
					ldc_imponibile_non_sc=(ld_qta * ld_preuni * ld_cambio_appoggio) 
				end if			
				
				
				
				ldc_imponibile_non_sc = f_round(ldc_imponibile_non_sc,il_dec_significativi, is_tipo_arr) 
			
				wf_insert_riga_cpt(ll_idcpt,"C", ids_cpt, ldc_imponibile_non_sc ,0, 0, 0)
				ldc_imponibile=ldc_imponibile_non_sc - ld_totriga
				wf_insert_riga_cpt(ll_id_cpt_sconti,"S", ids_cpt, ldc_imponibile ,0, 0, 0)
			else							
				ldc_imponibile= ld_totriga
				wf_insert_riga_cpt(ll_idcpt,"C", ids_cpt, ldc_imponibile ,0, 0, 0)
			end if
			
						
		end if
		ll_create ++
	end if
next

return ll_create


end function

public subroutine wf_calc_cpt_sconti ();


long			ll_nrows, ll_count
decimal		ld_temp, ld_impon, ld_rimanenza
decimal		ld_qprop, ld_percinc
decimal		ld_scfincas, ld_scfininc
string		ls_scfinanz

string ls_cpt_sconti, ls_tipo_cpt
long ll_id_cpt_sconti, ll_id_sog_commerciale
decimal  ldc_sconto_riga, ldc_sconto_unit_riga

select gest_cpt_sconti
into :ls_cpt_sconti
from par_sistema;

ls_scfinanz = ids_testa.GetItemString(il_rowtesta,"documento_sconto_finanziario")
ld_scfininc = ids_testa.GetItemDecimal(il_rowtesta,"sconto_fin_incondizionato")
ld_scfincas = ids_testa.GetItemDecimal(il_rowtesta,"documento_sconto_fin_cassa")


ll_nrows = ids_cpt.rowcount()
for ll_count = 1 to ll_nrows
	ld_temp = Round(ids_cpt.GetItemNumber(ll_count, "c_proporzionale"), 2)
	ids_cpt.SetItem(ll_count, "c_prop_imp", ld_temp)
next

decimal ldc_imponibile, ldc_imponibile1, ldc_imponibile2
boolean lb_ok
long ll_count_app

if ls_cpt_sconti = 'S' then
	ldc_imponibile = 0
	ll_id_sog_commerciale=ids_testa.getitemnumber(il_rowtesta,'id_sog_commerciale')
	
	uo_cpt_sconti u_cpt_sconti
	u_cpt_sconti = create uo_cpt_sconti	
	ll_id_cpt_sconti = u_cpt_sconti.uf_cpt_sconti(ls_scfinanz,0,0,"",0,0,0, ll_id_sog_commerciale, 0)				  
	destroy (u_cpt_sconti)
	
	if not isnull(ll_id_cpt_sconti) then
		lb_ok = false
		for ll_count = 1 to ll_nrows
			ls_tipo_cpt = ids_cpt.getitemstring(ll_count,"tipo_riga_cpt")
			ldc_imponibile1= ids_cpt.GetItemDecimal(ll_count, "val_imponibile")
			ids_cpt.SetItem(ll_count, "val_imp_scontato", ldc_imponibile1)			
			
			choose case ls_tipo_cpt
				case "C"
					ldc_imponibile = ldc_imponibile + ldc_imponibile1
				CASE "S"
					ldc_imponibile = ldc_imponibile - ldc_imponibile1
					
					if ids_cpt.getitemnumber(ll_count, "id_conto") = ll_id_cpt_sconti then
						lb_ok = true
						ll_count_app = ll_count
					end if
			end choose
		next				
				
		ldc_imponibile2= wf_calc_prezzo_riga(ls_scfinanz, ldc_imponibile, 0)
		ldc_imponibile2= f_round(ldc_imponibile2,il_dec_significativi, is_tipo_arr) 
		
		ldc_imponibile = ldc_imponibile - ldc_imponibile2
		
		if lb_ok = true then
			ldc_imponibile1 = ids_cpt.getitemdecimal(ll_count_app,"val_imponibile") 
			ids_cpt.SetItem(ll_count_app, "val_imponibile", ldc_imponibile+ldc_imponibile1)
			ids_cpt.SetItem(ll_count_app, "val_imp_scontato", ldc_imponibile+ldc_imponibile1)				
		else
			wf_insert_riga_cpt (ll_id_cpt_sconti, "S", ids_cpt, ldc_imponibile, ldc_imponibile, 0, 0)
		end if
	else
		for ll_count = 1 to ll_nrows
			ld_temp = ids_cpt.GetItemDecimal(ll_count, "val_imponibile")
			If not (IsNull(ls_scfinanz) OR ls_scfinanz = "") then
				ld_temp = wf_calc_prezzo_riga(ls_scfinanz, ld_temp, 0)
				ld_temp = f_round(ld_temp,il_dec_significativi, is_tipo_arr) 
			end if
			ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_temp)
		next		
	end if			
else
	for ll_count = 1 to ll_nrows
		ld_temp = ids_cpt.GetItemDecimal(ll_count, "val_imponibile")
		If not (IsNull(ls_scfinanz) OR ls_scfinanz = "") then
			ld_temp = wf_calc_prezzo_riga(ls_scfinanz, ld_temp, 0)
			ld_temp = f_round(ld_temp,il_dec_significativi, is_tipo_arr) 
		end if
		ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_temp)
	next
end if

ld_rimanenza = 0

If not (IsNull(ld_scfininc) OR ld_scfininc = 0) then
	if ll_nrows > 0 then
		for ll_count = 1 to ll_nrows - 1
			ld_impon = ids_cpt.GetItemDecimal(ll_count, "val_imp_scontato")
			ld_qprop = ids_cpt.GetItemDecimal(ll_count, "c_proporzionale")
			
			
			ld_impon = ld_impon - ld_percinc
			ld_rimanenza = ld_rimanenza + ld_percinc
			ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_impon)
		next
		
		ld_impon = ids_cpt.GetItemDecimal(ll_nrows, "val_imp_scontato")
		ld_impon = ld_impon - ld_scfininc + ld_rimanenza
		ids_cpt.SetItem(ll_nrows, "val_imp_scontato", ld_impon)
	end if
end if


If not (IsNull(ld_scfincas) OR ld_scfincas = 0) then
	for ll_count = 1 to ll_nrows
		ld_impon = ids_cpt.GetItemDecimal(ll_count, "val_imp_scontato")
		ld_impon = ld_impon - (ld_impon * ld_scfincas / 100)
		
		ld_impon = f_round(ld_impon,il_dec_significativi, is_tipo_arr) 
		ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_impon)

	next
end if


end subroutine

public subroutine wf_calc_cpt_spese ();


long		ll_count, ll_nrows
long		ll_idspesa, ll_idconto
decimal	ld_importo

ll_nrows = ids_spese.rowcount()
for ll_count = 1 to ll_nrows
	
	ll_idspesa= ids_spese.GetItemNumber(ll_count, "id_spesa")

	choose case is_td_tiporeg
		
		CASE "IA", "PA", "OA", "DA", "LA", "GA"			
			SELECT	"conto_azienda"."id_conto"
				INTO	:ll_idconto
				FROM	"dba"."conto_azienda", "dba"."spesa"  
				WHERE ("spesa"."id_conto_acquisti" = "conto_azienda"."id_conto" ) and  
						("spesa"."id_spesa" = :ll_idspesa) and
						("conto_azienda"."id_azienda" = :il_az_idaz);

		
		CASE "IV", "PV", "OV", "DV", "LV", "GV", "IC"
			SELECT	"conto_azienda"."id_conto"  
				INTO	:ll_idconto
				FROM	"dba"."conto_azienda", "dba"."spesa"  
				WHERE ("spesa"."id_conto_vendite" = "conto_azienda"."id_conto" ) and
						("spesa"."id_spesa" = :ll_idspesa ) and
						("conto_azienda"."id_azienda" = :il_az_idaz);
			
	end choose
	if sqlca.sqlcode<>0 then
		setNull (ll_idconto)
	end if
	
	If not (IsNull(ll_idconto) OR ll_idconto=0) then 
		ld_importo = ids_spese.GetItemDecimal(ll_count, "c_importo_lire")
		wf_insert_riga_cpt (ll_idconto, "C", ids_cpt, 0 , 0, 0, ld_importo)
	end if
next



end subroutine

public function integer wf_calc_cpt_totali ();
long		ll_scode, ll_iddetr, ll_idnond, ll_castrow,ll_row_iva
decimal	ld_totdetr, ld_totnond
decimal	ld_valomsc, ld_totdocu

ld_valomsc = ids_testa.GetItemDecimal (il_rowtesta, "c_val_omaggi")
ld_valomsc = ld_valomsc + ids_testa.GetItemDecimal (il_rowtesta, "c_val_sc_merce_art_15")
ld_valomsc = ld_valomsc + ids_testa.GetItemDecimal (il_rowtesta, "c_val_sc_merce_iva")
ld_valomsc = ld_valomsc * idc_td_cambio
ld_valomsc = truncate (ld_valomsc,0)

ll_row_iva = ids_iva.RowCount()
if ll_row_iva > 0  then
	ld_totdocu = ids_iva.GetItemDecimal(1, "c_tot_val_tot_imp_l")
	ld_totdocu = ld_totdocu + ids_iva.GetItemDecimal(1, "c_tot_val_tot_iva_l")
	wf_insert_riga_cpt (il_sc_idconto, "S", ids_cpt, 0, ld_totdocu, ld_valomsc, 0)
else	
end if	



choose case is_td_tiporeg
	case "IA", "PA", "OA", "DA", "LA", "GA"
		SELECT "par_sistema"."id_conto_iva_ia", "par_sistema"."id_conto_iva_nd"  
		INTO :ll_iddetr, :ll_idnond
		FROM "dba"."par_sistema"
		WHERE "par_sistema"."id_azienda" = :il_az_idaz ;
		ll_scode = sqlca.sqlcode

	case "IV", "PV", "OV", "DV", "LV", "GV"
		SELECT "par_sistema"."id_conto_iva_iv", "par_sistema"."id_conto_iva_nd"  
		INTO :ll_iddetr, :ll_idnond
		FROM "dba"."par_sistema"
		WHERE "par_sistema"."id_azienda" = :il_az_idaz ;
		ll_scode = sqlca.sqlcode

	case else
		ll_scode = -1
end choose


If ll_scode = 0 then
	
	
	ll_castrow= ids_iva.RowCount()
	If ll_castrow > 0 then
		ld_totdetr = ids_iva.GetItemDecimal(ll_castrow,"c_tot_detraibile")
		if ld_totdetr>0 then
			wf_insert_riga_cpt (ll_iddetr, "I", ids_cpt, 0 , ld_totdetr, 0, 0)
		end if
		ld_totnond = ids_iva.GetItemDecimal(ll_castrow,"c_tot_non_detraibile")
		if ld_totnond>0 then
			wf_insert_riga_cpt (ll_idnond, "N", ids_cpt, 0 , ld_totnond, 0, 0)
		end if
	end if
	
end if

return 0

end function

public function long wf_calc_finali ();



long		ll_nrows,	ll_count
long		ll_idspesa,	ll_idiva,	ll_row_iva
string	ls_spdesc,	ls_spimpo,	ls_desc1,	ls_desc2,	ls_impo1,	ls_impo2
string	ls_codiva,	ls_aliquo,	ls_ivimp,	ls_iviva
decimal	ld_importo,	ld_impiva,	ld_nettom,	ld_totdoc
integer	li_switch

string	ls_temp



ll_nrows = ids_spese.rowcount()
if ll_nrows>10 then ll_nrows = 10
li_switch = 1
ls_desc1 = ""
ls_desc2 = ""
ls_impo1 = ""
ls_impo2 = ""

ids_riga.object.piede_cast_spesa_1_t.text = ""
ids_riga.object.piede_cast_spesa_2_t.text = ""
ids_riga.object.piede_cast_spesa_3_t.text = ""
ids_riga.object.piede_cast_spesa_4_t.text = ""

if ll_nrows>0 then
	for ll_count = 1 to ll_nrows
		
		ll_idspesa = ids_spese.GetItemNumber(ll_count,"id_spesa")
		ld_importo = ids_spese.GetItemDecimal(ll_count,"importo")
		ls_spimpo = string(ld_importo,"#,##0.00")
		ls_spdesc = ""
		SELECT	"spesa"."descrizione"  
			INTO	:ls_spdesc
			FROM	"dba"."spesa"  
			WHERE	"spesa"."id_spesa" = :ll_idspesa
			USING sqlca;
			
		if isNull(ls_spdesc) then ls_spdesc = ""
		
		if sqlca.sqlcode=0 then
			ls_spdesc = "~r" + ls_spdesc
			ls_spimpo = "~r" + ls_spimpo
			
			if li_switch=1 then
				ls_desc1 += ls_spdesc
				ls_impo1 += ls_spimpo
				li_switch = 2
				
			else
				ls_desc2 += ls_spdesc
				ls_impo2 += ls_spimpo
				li_switch = 1
			end if
			
		end if
	next
	ls_desc1 = Mid (ls_desc1,2)
	ls_desc2 = Mid (ls_desc2,2)
	ls_impo1 = Mid (ls_impo1,2)
	ls_impo2 = Mid (ls_impo2,2)
	ids_riga.object.piede_cast_spesa_1_t.text = ls_desc1
	ids_riga.object.piede_cast_spesa_2_t.text = ls_impo1
	ids_riga.object.piede_cast_spesa_3_t.text = ls_desc2
	ids_riga.object.piede_cast_spesa_4_t.text = ls_impo2
end if

ls_desc1 = ""
ls_desc2 = ""
ls_impo1 = ""
ls_impo2 = ""
ll_nrows = ids_iva.rowcount()
if ll_nrows>5 then ll_nrows = 5
if ll_nrows>0 then
	for ll_count = 1 to ll_nrows
		ll_idiva = ids_iva.GetItemNumber(ll_count,"id_tab_iva")
		ld_importo = ids_iva.GetItemNumber(ll_count,"val_tot_imp_l")
		ld_impiva = ids_iva.GetItemNumber(ll_count,"val_tot_iva_l")
		ls_ivimp = string(ld_importo,"#,##0.00")
		ls_iviva = string(ld_impiva,"#,##0.00")
		
		ls_codiva = ""
		ls_aliquo = ""
		SELECT	"tab_iva"."codice",	"tab_iva"."per_aliquota"  
			INTO	:ls_codiva, :ls_aliquo
			FROM	"dba"."tab_iva"  
			WHERE "tab_iva"."id_tab_iva" = :ll_idiva
			USING Sqlca;
	
		if isNull (ls_codiva) then ls_codiva = ""
		if isNull (ls_aliquo) then ls_aliquo = ""
		if isNull (ls_ivimp) then ls_ivimp = ""
		if isNull (ls_iviva) then ls_iviva = ""
		if sqlca.sqlcode=0 then
			
			ls_codiva = "~r" + ls_codiva
			ls_aliquo = "~r" + ls_aliquo
			ls_ivimp  = "~r" + ls_ivimp
			ls_iviva  = "~r" + ls_iviva
			
			ls_impo1 += ls_ivimp
			ls_impo2 += ls_iviva
			ls_desc1 += ls_codiva
			ls_desc2 += ls_aliquo
		end if
	next
	ls_desc1 = Mid (ls_desc1,2)
	ls_desc2 = Mid (ls_desc2,2)
	ls_impo1 = Mid (ls_impo1,2)
	ls_impo2 = Mid (ls_impo2,2)
	ids_riga.object.piede_cast_iva_1_t.text = ls_desc1
	ids_riga.object.piede_cast_iva_2_t.text = ls_desc2
	ids_riga.object.piede_cast_iva_3_t.text = ls_impo1
	ids_riga.object.piede_cast_iva_4_t.text = ls_impo2
end if


ll_nrows = ids_scad.rowcount()
if ll_nrows>10 then ll_nrows = 10
li_switch = 1
ls_desc1 = ""
ls_desc2 = ""
ls_impo1 = ""
ls_impo2 = ""
if ll_nrows>0 then
	for ll_count = 1 to ll_nrows
		
		ld_importo = ids_scad.GetItemDecimal(ll_count,"importo")
		ls_spimpo = string(ld_importo,"#,##0.00")
		ls_spdesc = string(ids_scad.GetItemDate(ll_count,"data_scadenza"),"dd/mm/yyyy")
		if isNull(ls_spdesc) then ls_spdesc = ""
		
		ls_spdesc = "~r" + ls_spdesc
		ls_spimpo = "~r" + ls_spimpo
		
		if li_switch=1 then
			ls_desc1 += ls_spdesc
			ls_impo1 += ls_spimpo
			li_switch = 2
			
		else
			ls_desc2 += ls_spdesc
			ls_impo2 += ls_spimpo
			li_switch = 1
		end if
		
	next
	ls_desc1 = Mid (ls_desc1,2)
	ls_desc2 = Mid (ls_desc2,2)
	ls_impo1 = Mid (ls_impo1,2)
	ls_impo2 = Mid (ls_impo2,2)
	ids_riga.object.piede_cast_scad_1_t.text = ls_desc1
	ids_riga.object.piede_cast_scad_2_t.text = ls_impo1
	ids_riga.object.piede_cast_scad_3_t.text = ls_desc2
	ids_riga.object.piede_cast_scad_4_t.text = ls_impo2
end if


ld_importo = ids_testa.getItemDecimal(il_rowtesta,"sconto_fin_incondizionato")
ids_riga.object.piede_scfin_t.text = is_rt_oscfi
ids_riga.object.piede_scinc_t.text = string (ld_importo,"#,##0.00")
ids_riga.object.piede_sccas_t.text = string(idc_rt_scca,"##.##")


ll_row_iva = ids_iva.RowCount()
if ll_row_iva > 0 then
	ld_nettom = ids_iva.GetItemDecimal(1,"c_tot_imp_scontato")
	ld_importo = ids_iva.GetItemDecimal(1, "c_tot_val_tot_imp_v")
	ld_impiva = ids_iva.GetItemDecimal(1, "c_tot_val_tot_iva_v")
	ld_totdoc = ld_importo + ld_impiva
else	
	ld_nettom = 0
	ld_importo = 0
	ld_impiva = 0
	ld_totdoc = 0
end if

ids_riga.object.piede_tot_merce_t.text     = string (ld_nettom,"#,##0.00")
ids_riga.object.piede_tot_impo_t.text      = string (ld_importo,"#,##0.00")
ids_riga.object.piede_tot_iva_t.text       = string (ld_impiva,"#,##0.00")
ids_riga.object.piede_tot_documento_t.text = string (ld_totdoc,"#,##0.00")
ids_riga.object.anticipo_versato_t.text    = string(id_tot_acconto,"#,##0.00")

idw_testr.object.piede_cast_spesa_1_t.text = ids_riga.object.piede_cast_spesa_1_t.text
idw_testr.object.piede_cast_spesa_2_t.text = ids_riga.object.piede_cast_spesa_2_t.text
idw_testr.object.piede_cast_spesa_3_t.text = ids_riga.object.piede_cast_spesa_3_t.text
idw_testr.object.piede_cast_spesa_4_t.text = ids_riga.object.piede_cast_spesa_4_t.text

idw_testr.object.piede_cast_iva_1_t.text = ids_riga.object.piede_cast_iva_1_t.text
idw_testr.object.piede_cast_iva_2_t.text = ids_riga.object.piede_cast_iva_2_t.text
idw_testr.object.piede_cast_iva_3_t.text = ids_riga.object.piede_cast_iva_3_t.text
idw_testr.object.piede_cast_iva_4_t.text = ids_riga.object.piede_cast_iva_4_t.text

idw_testr.object.piede_cast_scad_1_t.text = ids_riga.object.piede_cast_scad_1_t.text
idw_testr.object.piede_cast_scad_2_t.text = ids_riga.object.piede_cast_scad_2_t.text
idw_testr.object.piede_cast_scad_3_t.text = ids_riga.object.piede_cast_scad_3_t.text
idw_testr.object.piede_cast_scad_4_t.text = ids_riga.object.piede_cast_scad_4_t.text

idw_testr.object.piede_scfin_t.text = ids_riga.object.piede_scfin_t.text
idw_testr.object.piede_scinc_t.text = ids_riga.object.piede_scinc_t.text
idw_testr.object.piede_sccas_t.text = ids_riga.object.piede_sccas_t.text

idw_testr.object.piede_tot_merce_t.text     = ids_riga.object.piede_tot_merce_t.text
idw_testr.object.piede_tot_impo_t.text      = ids_riga.object.piede_tot_impo_t.text
idw_testr.object.piede_tot_iva_t.text       = ids_riga.object.piede_tot_iva_t.text
idw_testr.object.piede_tot_documento_t.text = ids_riga.object.piede_tot_documento_t.text
idw_testr.object.anticipo_versato_t.text      = ids_riga.object.anticipo_versato_t.text

ls_temp = idw_testr.describe("linea2.y1")

return 0

end function

public function integer wf_insert_rigaok (long al_row, long al_riga, long al_cauder, long al_cpt, string as_descr);


long		ll_row, ll_scode
decimal	ldc_imp_acconto, ld_val_cambio
long		ll_id_tab_iva_acconto, ll_id_tipo_pag_acconto, ll_id_val_acconto, ll_id_grag
integer	li_ret
long		ll_iddoc, ll_idrig, ll_idsc, ll_iddest, ll_idval, ll_idcpag, ll_idban, ll_idscf
string	ls_scfin
decimal	ld_sccas, ld_doc_cambio
date		ldt_dreg
long		ll_id_gruppo_agenti_2


li_ret = 0
ll_row = ids_r2.insertRow(0)
if ll_row>0 then
	
	ll_iddoc		= ids_docs.GetItemNumber(al_row,"documento_id_documento")
	ll_idrig		= al_riga
	ll_idsc		= ids_docs.GetItemNumber(al_row,"documento_id_sog_commerciale")
	ll_iddest	= ids_docs.GetItemNumber(al_row,"documento_id_destinazione")
	ll_idval		= ids_docs.GetItemNumber(al_row,"documento_id_valuta")
	ll_idcpag	= ids_docs.GetItemNumber(al_row,"documento_id_con_pagamento")
	ll_idban		= ids_docs.GetItemNumber(al_row,"documento_id_banca_sog_commerciale")
	ls_scfin		= ids_docs.GetItemString(al_row,"documento_sconto_finanziario")
	ld_sccas		= ids_docs.GetItemNumber(al_row,"documento_sconto_fin_cassa")
	ldt_dreg		= ids_docs.GetItemDate(al_row,"documento_data_registrazione")
	
	ll_id_grag	=ids_docs.GetItemNumber(al_row,"documento_id_gruppo_agenti")
	
	ll_id_gruppo_agenti_2=ids_docs.getitemnumber(al_row, "documento_id_gruppo_agenti_2")
	
	
	

	ldc_imp_acconto = ids_docs.GetItemDecimal(al_row,"documento_imp_acconto")
	ll_id_tab_iva_acconto = ids_docs.GetItemNumber(al_row,"documento_id_tab_iva_acconto")
	ll_id_tipo_pag_acconto = ids_docs.GetItemNumber(al_row,"documento_id_tipo_pag_acconto")
	ll_id_val_acconto = ids_docs.GetItemNumber(al_row,"documento_id_val_acconto")



	if isNull(ls_scfin) then ls_scfin = ""
	if is_ch_intfat="S" then
		ll_idsc = ll_idscf
	else
		ll_idscf = ll_idsc
	end if
	
	ids_r2.setItem(ll_row,"id_doc",ll_iddoc)
	ids_r2.setItem(ll_row,"id_riga_doc",ll_idrig)
	ids_r2.setItem(ll_row,"id_sc",ll_idsc)
	ids_r2.setItem(ll_row,"id_scf",ll_idscf)
	ids_r2.setItem(ll_row,"id_dest",ll_iddest)
	ids_r2.setItem(ll_row,"id_valu",ll_idval)
	ids_r2.setItem(ll_row,"id_cpag",ll_idcpag)
	ids_r2.setItem(ll_row,"id_ban",ll_idban)
	ids_r2.setItem(ll_row,"sc_fin",ls_scfin)
	ids_r2.setItem(ll_row,"sc_cas",ld_sccas)
	ids_r2.setItem(ll_row,"data_reg",ldt_dreg)
	ids_r2.setItem(ll_row,"id_cauder",al_cauder)
	ids_r2.setItem(ll_row,"id_cpt",al_cpt)
	ids_r2.SetItem(ll_row,"s_rdes",as_descr)
	
	
	ids_r2.SetItem(ll_row,"id_gruppo_agenti",ll_id_grag)
	
	ids_r2.setitem(ll_row,"id_gruppo_agenti_2", ll_id_gruppo_agenti_2)
	
	
	ld_doc_cambio		= ids_docs.GetItemdecimal(al_row,"documento_cambio")
	
	ids_r2.setItem(ll_row,"d_imp_acconto",ldc_imp_acconto)
	ids_r2.setItem(ll_row,"l_id_tab_iva_acconto",ll_id_tab_iva_acconto)
	ids_r2.setItem(ll_row,"l_id_tipo_pag_acconto",ll_id_tipo_pag_acconto)
	ids_r2.setItem(ll_row,"l_id_val_acconto",ll_id_val_acconto)
	
	
	if is_ch_ricchg<>'S' then
		select cambio 
		into :ld_val_cambio
		from valuta
		where id_valuta=:ll_idval;
		if ld_val_cambio>0 then ld_doc_cambio=ld_val_cambio
	end if
	ids_r2.setItem(ll_row,"cambio",ld_doc_cambio)
	
	

else
	li_ret = -1
end if

return li_ret

end function

public function long wf_calc_piede_doc (long al_row, boolean ab_definitiva);
boolean		lb_Ok, lb_Tot_Ok
long			ll_ret
decimal		ld_bollo
string		ls_testata

ll_ret = 0
if isNull (il_az_idcontoprd) or (il_az_idcontoprd = 0) then
	return -1
end if
if isNull (il_az_idivaart15) or (il_az_idivaart15 = 0) then
	return -1
end if

ids_testa.SetItem (il_rowtesta, "c_val_sc_merce_art_15", 0)
ids_testa.SetItem (il_rowtesta, "c_val_sc_merce_iva", 0)
ids_testa.SetItem (il_rowtesta, "c_val_omaggi", 0)

ids_iva.Reset()

ids_iva.Modify("c_arrotondamento_text.text = '" + String(il_rt_arrvalu) + "'")
ids_iva.Modify("c_arrotondamento_text_v_conto.text = '" + String(il_az_arrot) + "'")
ids_iva.Modify("c_tipo_arrotondamento.text = '" + is_rt_tiparrvalu + "'")
ids_spese.Modify("c_arrotondamento_text_v_conto.text = '" + String(il_az_arrot) + "'")

ids_iva.Modify("c_cambio_text.text='" + String(idc_old_td_cambio) + "'")
idw_spese.Modify("c_cambio_text.text = '" + String(idc_old_td_cambio) + "'")

wf_calcola_spese()

wf_calc_righe_cast()									
wf_calc_sconti_cast()								
wf_calc_sp_noiva_cast()								
wf_calc_sp_iva_cast()								
wf_calc_bollo_cast()									

wf_calc_arrotondamento()							

ld_bollo = wf_genera_scadenze()

wf_calc_sp_bollo_cast()								

wf_applica_acconto()									
wf_del_spese_nulle()									
wf_setup_cast_iva(0)									

wf_calc_cpt()

wf_calc_finali()										
							
lb_Tot_Ok=TRUE
If ab_definitiva then
	lb_Ok = wf_Salva_Documento()
	If not lb_Ok then 
		lb_Tot_Ok=FALSE
	end if
else
	if cbx_st_rp_prova.checked then
		ids_riga.print()
	end if
end if
If not lb_Tot_Ok then MessageBox("Derivazione Batch", "La derivazione di uno o più Documenti~r" &
			+ "derivati non ha avuto successo", StopSign!)
imle_rep.text += "~r~n wf_calc_piede_doc, le righe documento erano "+string(ids_riga.rowcount())

return 0


end function

public function boolean wf_salva_documento ();
long		ll_Id_Documento, ll_Row, ll_Size, ll_Update
string	ls_sql, ls_message, ls_num_documento, ls_num_fat_inizio, ls_des_contabile
long 		ll_id_registro, ll_ultimo_num_reg, ll_num_suggerito_min, ll_num_suggerito_Max
date		ld_ultima_data_reg, ld_data_prec, ld_data_succ, ld_Data, ld_data_emissione
boolean	lb_Ok
char lc_tipo_fattura

lb_Ok = TRUE

ll_id_registro = ids_testa.GetItemNumber(ids_testa.GetRow(),"id_registro")
IF NOT (IsNull(ll_id_registro) OR ll_id_registro = 0) THEN
	SetNull(ld_Data)
	
	SQLCA.sp_Ges_NumProg_DataReg( 0, ll_id_registro, ll_ultimo_num_reg, ld_Data,ls_message, &
		ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ, ll_id_documento);	
	IF IsNull(ll_ultimo_num_reg) THEN ll_ultimo_num_reg = 0
	
	il_num_fat++
	
	
	
	
	
	ld_data_emissione=tab_1.tabpage_1.dw_scelta.getitemdate(1, "data_emissione")
	
	ls_num_documento = f_Proponi_Num_Documento_Anno(ll_id_registro, Year(ld_data_emissione))
	
	
	
	
	
	If il_num_fat=1 then
		
		ls_num_fat_inizio=tab_1.tabpage_1.dw_scelta.getitemstring(1, "num_fat_inizio")
		
		
		
		
		
		if long(ls_num_fat_inizio)>0 then
			ids_testa.SetItem(ids_testa.GetRow(), "num_documento", ls_num_fat_inizio)
			ids_testa.SetItem( ids_testa.GetRow(), "num_progressivo", long(ls_num_fat_inizio))
			
			
			ll_Row=ids_testa.GetRow()
			lc_tipo_fattura=ids_testa.GetItemstring(ll_Row, "tipo_fattura")
			choose case lc_tipo_fattura
				case 'N'
					ls_des_contabile="Fattura n° "+ls_num_fat_inizio+" del "+ string(ld_data_emissione)
				case 'C' 
					ls_des_contabile="Nota Credito n° "+ls_num_fat_inizio+" del "+ string(ld_data_emissione)					
				case 'D'
					ls_des_contabile="Nota Debito n° "+ls_num_fat_inizio+" del "+ string(ld_data_emissione)					
			end choose
		else 
			ids_testa.SetItem(ids_testa.GetRow(), "num_documento", ls_num_documento)
			ids_testa.SetItem( ids_testa.GetRow(), "num_progressivo", ll_ultimo_num_reg)
			
			ll_Row=ids_testa.GetRow()
			lc_tipo_fattura=ids_testa.GetItemstring(ll_Row, "tipo_fattura")
			choose case lc_tipo_fattura
				case 'N'
					ls_des_contabile="Fattura n° "+ls_num_documento+" del "+ string(ld_data_emissione)
				case 'C' 
					ls_des_contabile="Nota Credito n° "+ls_num_documento+" del "+ string(ld_data_emissione)
				case 'D'
					ls_des_contabile="Nota Debito n° "+ls_num_documento+" del "+ string(ld_data_emissione)
			end choose
		end if
	else
		ids_testa.SetItem(ids_testa.GetRow(), "num_documento", ls_num_documento)
		ids_testa.SetItem( ids_testa.GetRow(), "num_progressivo", ll_ultimo_num_reg)
		
		ls_des_contabile="Fattura n° "+ls_num_documento+" del "+ string(ld_data_emissione)
		
	end if
	
	ids_testa.SetItem( ids_testa.GetRow(), "des_contabile", ls_des_contabile)
end if

ll_update = ids_testa.Update()
If ll_update < 0 then lb_Ok = FALSE

If ll_Update = 1 then
	
	ll_Row=ids_testa.GetRow()
	If not(IsNull(ll_Row) OR ll_Row=0) then 
		ll_Id_Documento=ids_testa.GetItemNumber(ll_Row, "id_documento")
		
		ll_Size = ids_riga.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_riga.SetItem(ll_Row, "id_documento", ll_Id_Documento)
		NEXT
		If ids_riga.Update() < 0 then lb_Ok = FALSE

		ll_Size = ids_spese.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_spese.SetItem(ll_Row, "id_documento", ll_Id_Documento)
		NEXT
		If ids_spese.Update() < 0 then lb_Ok = FALSE

		ll_Size = ids_iva.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_iva.SetItem(ll_Row, "id_documento", ll_Id_Documento)
		NEXT
		If ids_iva.Update() < 0 then lb_Ok = FALSE

		ll_Size = ids_scad.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_scad.SetItem(ll_Row, "id_documento", ll_Id_Documento)
		NEXT
		If ids_scad.Update() < 0 then lb_Ok = FALSE

		ll_Size = ids_cpt.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_cpt.SetItem(ll_Row, "id_documento", ll_Id_Documento)
		NEXT
		If ids_cpt.Update() < 0 then lb_Ok = FALSE
		

	end if
end if
If lb_Ok then 
	COMMIT USING SQLCA;
else
	
	
	if cbx_st_errors.checked then ids_riga.print()
	ROLLBACK USING SQLCA;
	if il_num_fat=1 then il_num_fat=0
end if

RETURN lb_Ok

end function

public function integer wf_insert_riga_cpt (long al_idcpt, string as_tipo, u_ds_main ads_cpt, decimal ad_imponibile, decimal ad_impscontato, decimal ad_omaggism, decimal ad_spese);


integer		li_ret
long			ll_rowfound
string		ls_codice, ls_descrizione
decimal		ld_temp


li_ret = 0

if not (IsNull(al_idcpt) OR al_idcpt = 0) then 
	

	If ads_cpt.RowCount() > 0 then
		ll_rowfound = ads_cpt.Find("id_conto =" + string(al_idcpt),1,ads_cpt.RowCount())
	else
		ll_rowfound = 0
	end if
	if ll_rowfound=0 then
		
		SELECT	"conto_azienda"."codice", "conto_azienda"."descrizione"  
			INTO	:ls_codice,	:ls_descrizione  
			FROM	"dba"."conto_azienda"  
			WHERE	"conto_azienda"."id_conto" = :al_idcpt;

		
		ll_rowfound = ads_cpt.InsertRow(0)
		if ll_rowfound > 0 then
			ads_cpt.SetItem(ll_rowfound, "id_conto",al_idcpt)
			ads_cpt.SetItem(ll_rowfound, "tipo_riga_cpt", as_tipo)
			ads_cpt.SetItem(ll_rowfound, "conto_azienda_codice",ls_codice)
			ads_cpt.SetItem(ll_rowfound, "conto_azienda_descrizione",ls_descrizione)
			ads_cpt.SetItem(ll_rowfound, "val_imponibile", ad_imponibile)
			ads_cpt.SetItem(ll_rowfound, "val_imp_scontato", ad_impscontato)
			ads_cpt.SetItem(ll_rowfound, "val_omaggi", ad_omaggism)
			ads_cpt.SetItem(ll_rowfound, "val_spese", ad_spese)
		else
			li_ret = -1
		end if
	else
		
		

		ld_temp = ads_cpt.GetItemDecimal(ll_rowfound,"val_imponibile")
		if IsNull(ld_temp) then ld_temp = 0
		ads_cpt.SetItem(ll_rowfound, "val_imponibile", ld_temp + ad_imponibile)

		ld_temp = ads_cpt.GetItemDecimal(ll_rowfound,"val_imp_scontato")
		if IsNull(ld_temp) then ld_temp = 0
		ads_cpt.SetItem(ll_rowfound, "val_imp_scontato", ld_temp + ad_impscontato)

		ld_temp = ads_cpt.GetItemDecimal(ll_rowfound,"val_omaggi")
		if IsNull(ld_temp) then ld_temp = 0
		ads_cpt.SetItem(ll_rowfound, "val_omaggi", ld_temp + ad_omaggism)

		ld_temp = ads_cpt.GetItemDecimal(ll_rowfound,"val_spese")
		if IsNull(ld_temp) then ld_temp = 0
		ads_cpt.SetItem(ll_rowfound, "val_spese", ld_temp + ad_spese)
	end if
end if

return li_ret

end function

public function integer wf_insert_riga_iva (long al_idtabiva, decimal ad_aliquota, decimal ad_perdetra, decimal ad_imponibile, decimal ad_imposta, decimal ad_omaggism, u_ds_main ads_cast);



long			ll_retval, ll_nrows, ll_rowfound, ll_newrow
decimal		ld_temp


ll_retval = 0
if IsNull(al_idtabiva) or al_idtabiva = 0 then ll_retval = -1

if ll_retval <0 then
	return ll_retval
end if


ll_nrows = ads_cast.rowcount()
if ll_nrows >0 then
	ll_rowfound=ads_cast.Find("id_tab_iva =" + string(al_idtabiva),1,ll_nrows)
else
	ll_rowfound=0
end if

if ll_rowfound= 0 then
	ll_newrow = ads_cast.insertrow(0)
	ll_retval = ll_newrow
	
	
	
	
	
	
	
	If il_rt_id_tab_iva_acconto=al_idtabiva then
		ads_cast.setitem(ll_newrow, "cc_acconto", id_tot_acconto)
	end if
	
	ads_cast.SetItem(ll_newrow, "id_tab_iva",al_idtabiva)
	ads_cast.SetItem(ll_newrow, "val_omaggi", ad_omaggism)
	ads_cast.SetItem(ll_newrow, "c_imposta", ad_imposta)
	ads_cast.SetItem(ll_newrow, "val_imponibile", ad_imponibile)
	ads_cast.SetItem(ll_newrow, "c_aliquota", ad_aliquota)
	ads_cast.SetItem(ll_newrow, "cc_per_detrazione", ad_perdetra)
	
else
	
	ll_retval = ll_rowfound
	
	If il_rt_id_tab_iva_acconto=al_idtabiva then
		ads_cast.setitem(ll_newrow, "cc_acconto", id_tot_acconto)
	end if
	
	ld_temp = ads_cast.GetItemDecimal(ll_rowfound,"val_imponibile")
	if IsNull(ld_temp) then ld_temp = 0
	ads_cast.SetItem(ll_rowfound, "val_imponibile", ad_imponibile + ld_temp)
	ld_temp = ads_cast.GetItemDecimal(ll_rowfound,"c_imposta")
	if IsNull(ld_temp) then ld_temp = 0
	ads_cast.SetItem(ll_rowfound, "c_imposta", ad_imposta + ld_temp)
	ld_temp = ads_cast.GetItemDecimal(ll_rowfound,"val_omaggi")
	if IsNull(ld_temp) then ld_temp = 0
	ads_cast.SetItem(ll_rowfound, "val_omaggi", ad_omaggism + ld_temp)
end if

return ll_retval


end function

public function string wf_selezione (long row, datawindow adw_origine, string as_col_origine, datawindow adw_dest, string as_filtro_agg, string as_col_dest);long i, ll_righe, ll_row
string ls_filter
boolean lb_filter

if as_filtro_agg<>"" then
	ls_filter=as_filtro_agg+" and ("
else
	ls_filter="("
end if
lb_filter=(as_col_origine<>"")and(as_col_dest<>"")
if NOT(KeyDown(KeyShift!))And NOT(KeyDown(KeyControl!)) then
	ll_righe=adw_origine.RowCount()
	ll_row=row
	
	for i = 1 to ll_righe
		if i=ll_row then continue
		if adw_origine.IsSelected(i) then adw_origine.SelectRow(i,false)
	next
	
	adw_origine.SelectRow(ll_row, not (adw_origine.isselected(ll_row)))
	if lb_filter then ls_filter = ls_filter + as_col_dest+' ='+string(adw_origine.GetItemNumber(ll_row,as_col_origine))+' or '
elseif KeyDown(KeyShift!) then
		ll_row=row
		adw_origine.SelectRow(ll_row,true)
		ll_righe=adw_origine.RowCount()
		ll_row=ll_righe
		
		for i= 1 to ll_row
			if adw_origine.IsSelected(i) then ll_row=i
		next
		
		for i=ll_row+1 to ll_righe
			if adw_origine.IsSelected(i) then ll_righe=i
		next
		
		for i = ll_row to ll_righe
			adw_origine.SelectRow(i,true)
			if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '					
		next
	elseif KeyDown(KeyControl!) then
		
		ll_row=row
		adw_origine.SelectRow(ll_row,Not adw_origine.IsSelected(ll_row))
		
		ll_righe=adw_origine.RowCount()
		for i = 1 to ll_righe
			if adw_origine.IsSelected(i) then
				if lb_filter then ls_filter = ls_filter + as_col_dest+'='+string(adw_origine.GetItemNumber(i,as_col_origine))+' or '	
			end if
		next
end if
	return ""

	

end function

public subroutine wf_setta_colonna (datawindow adw_dw, string as_colonna, long al_riga, string as_valore);adw_dw.setitem(al_riga, as_colonna, as_valore)
end subroutine

public subroutine wf_calcola_spese ();
integer	 li_rows, li_i
long		 ll_row, ll_id_spesa
long		 ll_id_tipo_trasporto, ll_id_doc
decimal	 ld_tot_merce
long		 ll_id_val_doc 

s_spese_calcolate ls_spese_calcolate

if (ids_riga.rowcount() <= 0) then 
	ld_tot_merce = 0
else
	ld_tot_merce = ids_riga.GetItemDecimal(1, "tot_righe_val_az")
end if

setnull(ll_id_tipo_trasporto)

if (il_ch_idprof > 0 and il_rt_scom > 0) then
	
	ll_id_val_doc = ids_testa.getitemnumber(1, "documento_id_valuta_des")
	ll_id_doc=ids_testa.getitemnumber(1, "id_documento")  //20260125 aggiunto per gestire spesoe bollo con tab iva (no_bollo labella)

	
	DATASTORE lds_iva
	lds_iva = create datastore
	lds_iva.dataobject = "ds_iva_spese_gd"

	if (ids_riga.rowcount() > 0) then &
		lds_iva.object.id_tab_iva.Current = ids_riga.object.id_tab_iva.Current
	
	
	ls_spese_calcolate = f_calcola_spese_documento(il_ch_idprof, ll_id_tipo_trasporto, il_rt_cpag, il_rt_scom, ld_tot_merce, ll_id_val_doc , ll_id_val_doc, lds_iva, ll_id_doc)	
		
	destroy lds_iva
	
	
	li_rows = upperbound(ls_spese_calcolate.id_spesa)
	
	if (li_rows <= 0) then return
	
	for li_i = 1 to li_rows
		ll_row = ids_spese.Find("id_spesa = " + String(ls_spese_calcolate.id_spesa[li_i]) , &
										1, ids_spese.rowcount())
		if ll_row=0 then
			ll_row = ids_spese.InsertRow(0)	
			ids_spese.SetItem(ll_row,"id_spesa",    ls_spese_calcolate.id_spesa[li_i])
			ids_spese.SetItem(ll_row,"importo",     ls_spese_calcolate.importo[li_i])
			ids_spese.SetItem(ll_row,"percentuale", ls_spese_calcolate.percentuale[li_i])
			ids_spese.SetItem(ll_row,"id_tab_iva",  ls_spese_calcolate.id_tab_iva[li_i])
		end if
	next
end if
end subroutine

public subroutine wf_calc_cpt_quadra ();
long 		ll_nr_row, ll_row, ll_row_c
string	ls_tipo
decimal	ldc_valore_c, ldc_valore_imp_sc ,ldc_valore_spese , ldc_valore_s, ldc_differenza, ldc_parziale
decimal	ldc_conguaglio, ldc_valore_in, ldc_acconto
boolean	lb_prima

ldc_valore_c = 0
ll_row_c=0
ll_nr_row= ids_cpt.RowCount()
If ll_nr_row> 0 then
	FOR ll_row = 1 to ll_nr_row
		ls_tipo= ids_cpt.GetItemString(ll_row,"tipo_riga_cpt")
		CHOOSE CASE ls_tipo 
			CASE "C" 
				ll_row_c++
				ldc_valore_imp_sc=ids_cpt.GetItemDecimal(ll_row,"val_imp_scontato")
				If IsNull(ldc_valore_imp_sc) then ldc_valore_imp_sc = 0
				ldc_valore_spese=ids_cpt.GetItemDecimal(ll_row,"val_spese")
				If IsNull(ldc_valore_spese) then ldc_valore_spese = 0
				ldc_valore_c= ldc_valore_c + ldc_valore_imp_sc +ldc_valore_spese
			CASE "I" ,"N" 
				ldc_valore_imp_sc=ids_cpt.GetItemDecimal(ll_row,"val_imp_scontato")
				If IsNull(ldc_valore_imp_sc) then ldc_valore_imp_sc = 0
				ldc_valore_in= ldc_valore_in + ldc_valore_imp_sc
			CASE "S" 
				if isnull(ldc_valore_s) then ldc_valore_s=0
				ldc_valore_s= ldc_valore_s+ids_cpt.GetItemDecimal(ll_row,"val_imp_scontato")
		END CHOOSE
	NEXT
	ldc_differenza= ldc_valore_s - (ldc_valore_c + ldc_valore_in) 
	If ldc_differenza <> 0 and ll_row_c>0  then 
		ldc_parziale= Round(ldc_differenza/ll_row_c, 0)
		ldc_conguaglio= ldc_parziale + (ldc_differenza - (ldc_parziale * ll_row_c))
		lb_prima= TRUE
		FOR ll_row = 1 to ll_nr_row - 1
			ls_tipo= ids_cpt.GetItemString(ll_row,"tipo_riga_cpt")
			If ls_tipo = "C" then
				ldc_valore_imp_sc= ids_cpt.GetItemDecimal(ll_row,"val_imp_scontato")
				If lb_prima then
					lb_prima= FALSE
					ids_cpt.SetItem(ll_row,"val_imp_scontato", ldc_valore_imp_sc + ldc_conguaglio)
				else
					ids_cpt.SetItem(ll_row,"val_imp_scontato", ldc_valore_imp_sc + ldc_parziale)
				end if
			end if
		NEXT
	end if
end if
	
	
end subroutine

public subroutine wf_calc_cpt_ripul ();
long 		ll_nr_row, ll_count, ll_row
decimal 	ldc_valore

ll_nr_row= ids_cpt.RowCount()
for ll_count =  1 to ll_nr_row 
	ll_row=ll_nr_row - ll_count + 1
	ldc_valore=ids_cpt.GetItemNumber(ll_row, "c_valore")
	If (IsNull(ldc_valore) Or ldc_valore=0) then
		ids_cpt.DeleteRow(ll_row)
	end if
next


end subroutine

public subroutine wf_applica_acconto ();
	long 		ll_id_iva
	long		ll_id_valuta
	long		ll_id_tipo_pagamento
decimal		ld_importo_acconto, ld_importo_acconto_lire
	long		ll_id_iva_acconto
	long		ll_n_righe
	long		ll_riga_giusta
	long		li_c
	long		errore, ll_nr_cifre_arrot, ll_id_valuta_doc
	string  ls_tipo_arrotondamento
	
	li_c = ids_testa.getrow()
	ll_id_iva_acconto = ids_testa.getitemnumber(li_c,"id_tab_iva_acconto")
	if not isnull (ll_id_iva_acconto) then

		ld_importo_acconto = ids_testa.getitemdecimal(li_c,"imp_acconto")
		if not (isnull(ld_importo_acconto) Or ld_importo_acconto = 0) then
			ld_importo_acconto = ids_testa.getitemdecimal(li_c,"c_imp_acconto_convertito")
		end if
		

		ll_n_righe = ids_iva.RowCount()
	
		if ll_n_righe > 0 then
			li_c = 1
			ll_id_iva = ids_iva.getitemnumber(li_c, "id_tab_iva")
			do while ( ll_id_iva <> ll_id_iva_acconto) And ( li_c <= ll_n_righe )
				li_c ++
				if li_c <= ll_n_righe then
					ll_id_iva = ids_iva.getitemnumber(li_c,"id_tab_iva")
				end if
			loop
			ll_riga_giusta = li_c
			if li_c > ll_n_righe then	
				messagebox ( "ERRORE", 	"Non Esiste Nessuna Aliquota Nel Castelletto ~r~n"+ &
											"Corrispondente a quella dell' aliquota" )
			else
				ll_id_valuta_doc=ids_testa.getitemnumber(1, "documento_id_valuta_cod")
				SELECT "valuta"."cifra_arrotondamento",
				"valuta"."tipo_arrotondamento"
				INTO :ll_nr_cifre_arrot ,
						:ls_tipo_arrotondamento
				FROM "dba"."valuta"  
				WHERE "valuta"."id_valuta" = :ll_id_valuta_doc   ;
				ld_importo_acconto=F_ROUND(ld_importo_acconto, ll_nr_cifre_arrot, ls_tipo_arrotondamento)
				errore = ids_iva.setItem(ll_riga_giusta,"cc_acconto",ld_importo_acconto)
			end if
		end if
	else
		li_c = ids_testa.getrow()
		ld_importo_acconto = ids_testa.getitemdecimal(li_c,"imp_acconto")
		if ld_importo_acconto > 0 then
			ll_riga_giusta = ids_scad.insertrow(1)
			if not isnull(ll_riga_giusta) or ll_riga_giusta > 0 then
				ld_importo_acconto_lire = ld_importo_acconto 
				ll_id_valuta = ids_testa.getitemnumber(li_c,"id_val_acconto")
				ll_id_tipo_pagamento = ids_testa.getitemnumber(li_c,"id_tipo_pag_acconto")
			
				ids_scad.setitem(ll_riga_giusta,"data_scadenza",Today())
				ids_scad.setitem(ll_riga_giusta,"tipo_scadenza","A")
				ids_scad.setitem(ll_riga_giusta,"id_valuta",ll_id_valuta)
				ids_scad.setitem(ll_riga_giusta,"id_tipo_pagamento",ll_id_tipo_pagamento)
				ids_scad.setitem(ll_riga_giusta,"importo",ld_importo_acconto_lire )
				ids_scad.setitem(ll_riga_giusta,"imp_valuta",ld_importo_acconto )
			end if
		end if
	end if
end subroutine

public function integer wf_calc_arrotondamento ();

long		ll_id_prof_documento, ll_id_spesa_arr, ll_id_val_doc, ll_id_tab_iva
decimal	ldc_arrotondamento, ldc_tot_documento_val, ldc_tot_doc_val_arr
integer	li_row

ll_id_prof_documento = ids_testa.getitemnumber(ids_testa.getrow(), "id_prof_documento")

if ll_id_prof_documento > 0 then
	SELECT a.id_spesa, a.arrotondamento, s.id_tab_iva
	INTO	 :ll_id_spesa_arr, :ldc_arrotondamento, :ll_id_tab_iva
	FROM	 arr_tot_documento a, spesa s
	WHERE  a.id_prof_documento = :ll_id_prof_documento
	AND	 s.id_spesa = a.id_spesa
	;

	if (sqlca.sqlcode = -1) then
		messagebox("WF_CALC_ARROTONDAMENTO/ dberror", sqlca.sqlerrtext)
	end if

	if (ll_id_spesa_arr > 0 and ldc_arrotondamento > 0) then
		
		
		li_row = ids_spese.Find("id_spesa = " + String(ll_id_spesa_arr) , &
										1, ids_spese.rowcount())

		if li_row > 0 then 	
			ids_spese.DeleteRow(li_Row)
			ids_iva.reset()
			wf_calc_righe_cast()									
			wf_calc_sconti_cast()								
			wf_calc_sp_noiva_cast()								
			wf_calc_sp_iva_cast()								
			wf_calc_bollo_cast()									
		end if

		
		li_row = ids_iva.RowCount()
		if li_row > 0 then
			ldc_tot_documento_val = ids_iva.GetItemDecimal(li_row,"c_tot_imponibile_spesa") + &
								  			ids_iva.GetItemDecimal(li_row,"c_tot_iva_val")
		else
			ldc_tot_documento_val = 0
		end if
		
		if ldc_tot_documento_val > 0 then
			
			ldc_tot_doc_val_arr = f_arrotonda(ldc_tot_documento_val, "E", ldc_arrotondamento)
			
			ldc_arrotondamento = ldc_tot_doc_val_arr - ldc_tot_documento_val
			
			if (ldc_arrotondamento) > 0 then
				ll_id_val_doc = ids_testa.getitemnumber(1, "documento_id_valuta_des")
				ldc_arrotondamento =	f_round_2(ll_id_val_doc, ldc_arrotondamento)

				
				li_row = ids_spese.InsertRow(0)	
				ids_spese.SetItem(li_row,"id_spesa",    ll_id_spesa_arr)
				ids_spese.SetItem(li_row,"importo",     ldc_arrotondamento)
				ids_spese.SetItem(li_row,"percentuale", 0)
				ids_spese.SetItem(li_row,"id_tab_iva",  ll_id_tab_iva)
				
				
				ids_iva.reset()
				wf_calc_righe_cast()									
				wf_calc_sconti_cast()								
				wf_calc_sp_noiva_cast()								
				wf_calc_sp_iva_cast()								
				wf_calc_bollo_cast()									
			end if
		end if
	end if
end if

return 0
end function

event open;string		ls_sql, variabile_stringa


iuo_scan = create u_sql_scanner
iuo_pag = create uo_esp_pag

ids_docs = create u_ds_main
ids_docs.dataobject = "d_deriva_batch_01_gd"
ids_docs.SetTransObject(SQLCA)
ids_rows = create u_ds_main
ids_rows.dataobject = "d_deriva_batch_02_gd"
ids_rows.SetTransObject(SQLCA)
ids_r2 = create u_ds_main
ids_r2.dataobject = "d_deriva_batch_04_ex"		
ids_derp = create u_ds_main
ids_derp.dataobject = "d_deriva_batch_05_gd"
ids_derp.SetTransObject(SQLCA)
ids_sc = create u_ds_main
ids_sc.dataobject = "d_deriva_batch_sc_gd"
ids_sc.SetTransObject(SQLCA)
ids_testa = create u_ds_main
ids_testa.dataobject = "d_documento_ordine_ff"
ids_testa.SetTransObject(SQLCA)

ids_riga = create u_ds_main
select table_id 
into :il_siamo_nell_orafo
from systable
where table_name='orafo_par_sistema';

if sqlca.sqlcode=0 then
	tab_1.tabpage_4.dw_testrighe.dataobject="d_orafo_deriva_batch_righe_tb"
	tab_1.tabpage_4.dw_testrighe.settransobject(sqlca)
	ids_riga.dataobject = "d_orafo_deriva_batch_righe_tb"
else
	ids_riga.dataobject = "d_deriva_batch_righe_tb"
end if
ids_riga.setTransObject(SQLCA)

ids_spese = create u_ds_main
ids_spese.dataobject = "d_deriva_batch_spese_tb"
ids_spese.SetTransObject(SQLCA)

ids_iva = create u_ds_main
ids_iva.dataobject = "d_cast_iva_documento_lt"
ids_iva.setTransObject(SQLCA)

ids_scad = create u_ds_main
ids_scad.dataobject = "d_scadenza_documento_lt"
ids_scad.setTransObject(SQLCA)

ids_cpt = create u_ds_main
ids_cpt.dataobject = "d_contr_documento_lt"
ids_cpt.setTransObject(SQLCA)

idw_scelta = tab_1.tabpage_1.dw_scelta
idw_errori = tab_1.tabpage_2.dw_errori
idw_anom_rpt = tab_1.tabpage_2.dw_anom_rpt
idw_r2 = tab_1.tabpage_3.dw_r2
idw_docs = tab_1.tabpage_3.dw_docs
idw_sc = tab_1.tabpage_3.dw_sc
idw_testr = tab_1.tabpage_4.dw_testrighe
idw_spese = tab_1.tabpage_3.dw_spese_wrk
idw_scad = tab_1.tabpage_3.dw_scad_wrk
idw_iva = tab_1.tabpage_3.dw_iva_wrk
idw_cpt = tab_1.tabpage_3.dw_cpt_wrk

idw_errori.ShareData(idw_anom_rpt)

ids_r2.ShareData(idw_r2)
ids_docs.ShareData(idw_docs)
ids_sc.ShareData(idw_sc)
ids_riga.ShareData(idw_testr)
ids_spese.ShareData(idw_spese)
ids_scad.ShareData(idw_scad)
ids_iva.ShareData(idw_iva)
ids_cpt.sharedata(idw_cpt)
imle_rep = tab_1.tabpage_4.mle_report
ids_testa.sharedata(tab_1.tabpage_1.dw_testa_wrk)

ls_sql = ids_docs.object.datawindow.table.select
iuo_scan.f_setinitial(ls_sql)
iuo_scan.f_setcurrent(ls_sql)

wf_set_istanze()

il_ch_exrow = idw_scelta.InsertRow(0)
idw_scelta.triggerevent("ue_post_open")
tab_1.selectTab(1)

is_sql_originale=ids_docs.getsqlselect()

//string ls_pancali
string ls_segno
long ll_id_cat_imb, ll_id_cat_art, ll_ret, ll_saldo

//select pancali, id_cat_com_art_imb
//into :is_pancali, :il_id_cat_imb
//from pers_par_sistema;
//if isnull(is_pancali) then is_pancali = 'N'
//if isnull(il_id_cat_imb) then il_id_cat_imb = 0
//
//if is_pancali = 'S' then
//	ds_eva_imb_app = CREATE DATASTORE
//	ds_eva_imb_app.DATAOBJECT = "ds_eva_imb_app"
//	ds_eva_imb_app.SETTRANSOBJECT(SQLCA)			
//end if
end event

event close;
if isvalid(iuo_scan) then destroy iuo_scan
if isvalid(ids_rows) then destroy ids_rows
if isvalid(ids_docs) then destroy ids_docs
if isvalid(ids_r2) then destroy ids_r2
if isvalid(ids_derp) then destroy ids_derp
if isvalid(ids_sc) then destroy ids_sc
if isvalid(ids_testa) then destroy ids_testa
if isvalid(ids_riga) then destroy ids_riga
if isvalid(ids_spese) then destroy ids_spese
if isvalid(ids_scad) then destroy ids_scad
if isvalid(ids_iva) then destroy ids_iva

if isvalid(iuo_pag) then destroy iuo_pag
end event

on w_deriva_batch_wz.create
this.cbx_st_errors=create cbx_st_errors
this.cbx_st_rp_prova=create cbx_st_rp_prova
this.cb_procedi=create cb_procedi
this.cb_anomalie=create cb_anomalie
this.cb_report=create cb_report
this.cb_genera=create cb_genera
this.tab_1=create tab_1
this.cb_annulla=create cb_annulla
this.Control[]={this.cbx_st_errors,&
this.cbx_st_rp_prova,&
this.cb_procedi,&
this.cb_anomalie,&
this.cb_report,&
this.cb_genera,&
this.tab_1,&
this.cb_annulla}
end on

on w_deriva_batch_wz.destroy
destroy(this.cbx_st_errors)
destroy(this.cbx_st_rp_prova)
destroy(this.cb_procedi)
destroy(this.cb_anomalie)
destroy(this.cb_report)
destroy(this.cb_genera)
destroy(this.tab_1)
destroy(this.cb_annulla)
end on

event key;
if key=keyF1! then
	
	showHelp("Cometa_Help.hlp",Keyword!,"SoggettiComemrciali!")
end if
end event

type cbx_st_errors from checkbox within w_deriva_batch_wz
integer x = 2318
integer y = 140
integer width = 434
integer height = 76
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Stampa errori"
boolean lefttext = true
end type

type cbx_st_rp_prova from checkbox within w_deriva_batch_wz
integer x = 805
integer y = 28
integer width = 535
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Stampa report prova"
boolean lefttext = true
end type

event clicked;if cbx_st_rp_prova.checked then	
	printsetup()
end if
end event

type cb_procedi from commandbutton within w_deriva_batch_wz
event clicked pbm_bnclicked
integer x = 50
integer y = 28
integer width = 306
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = " Procedi"
end type

event clicked;


long			ll_rtv
w_wait_01	lw_win

cb_report.enabled = false
cb_anomalie.enabled = false
cb_genera.enabled = false
idw_errori.reset()
idw_errori.setRedraw(false)

//if is_pancali = 'S' then
//	ds_eva_imb_app.reset()
//end if 	

Open (lw_win,"w_wait_01",parent)
lw_win.st_wait_b.text = "Controllo Selezione..."

ll_rtv = wf_check_sel()
if ll_rtv = 0 then
	
	
	
	lw_win.st_wait_b.text = "Raccolta Documenti..."
	ll_rtv = wf_retrieve_1()
	if ll_rtv = 0 then
		messageBox ("Attenzione!","Non ci sono documenti validi con questa selezione!")
	else
		
		
		
		lw_win.st_wait_b.text = "Primo controllo righe..."
		ll_rtv = wf_check_righe()
		lw_win.st_wait_b.text = "Secondo controllo righe..."
		ll_rtv = wf_check_r2()
		lw_win.st_wait_b.text = "Raggruppamento Soggetti Commerciali..."
		ll_rtv = wf_ragg_sc()
	end if
end if

lw_win.st_wait_b.text = "Fase finale preparazione..."
idw_errori.sort()
idw_errori.groupcalc()
idw_errori.setRedraw(true)

if ids_r2.rowcount() >0 then
	
	ids_sc.sort()
	cb_report.enabled = true
	cb_genera.enabled = true
end if
if idw_errori.rowcount() >0 then
	cb_anomalie.enabled = true
end if



close (lw_win)


end event

type cb_anomalie from commandbutton within w_deriva_batch_wz
event clicked pbm_bnclicked
integer x = 1394
integer y = 28
integer width = 443
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "St. &Anomalie"
end type

event clicked;

long			ll_temp
string		ls_titolo, ls_temp


ls_titolo = ""
ls_temp = string(idw_scelta.GetItemDate(il_ch_exrow,"data_inizio"))
if isNull (ls_temp) then ls_temp = "__/__/____"
ls_titolo = ls_titolo + " Dal " + ls_temp
ls_temp = string(idw_scelta.GetItemDate(il_ch_exrow,"data_fine"))
if isNull (ls_temp) then ls_temp = "__/__/____"
ls_titolo = ls_titolo + " Al " + ls_temp
ll_temp = idw_scelta.GetItemNumber(il_ch_exrow,"id_int")
if not isNull(ll_temp) and (ll_temp>0) then
	ls_temp = string(idw_scelta.GetItemString(il_ch_exrow,"cod_int"))
	if isNull (ls_temp) then ls_temp = "___"
	ls_titolo = ls_titolo + " Intestatario " + ls_temp
	ls_temp = string(idw_scelta.GetItemString(il_ch_exrow,"des_int"))
	if isNull (ls_temp) then ls_temp = "___"
	ls_titolo = ls_titolo + " - " + ls_temp
else
	ls_titolo = ls_titolo + " <Tutti gli Intestatari> "
end if
ll_temp = idw_scelta.GetItemNumber(il_ch_exrow,"id_int")
if not isNull(ll_temp) and (ll_temp>0) then
	ls_temp = string(idw_scelta.GetItemString(il_ch_exrow,"destinazione"))
	if isNull (ls_temp) then ls_temp = "___"
	ls_titolo = ls_titolo + " Destinazione " + ls_temp
end if
ll_temp = idw_scelta.GetItemNumber(il_ch_exrow,"id_mag")
if not isNull(ll_temp) and (ll_temp>0) then
	ls_temp = string(idw_scelta.GetItemString(il_ch_exrow,"cod_mag"))
	if isNull (ls_temp) then ls_temp = "___"
	ls_titolo = ls_titolo + " Magazzino " + ls_temp
	ls_temp = string(idw_scelta.GetItemString(il_ch_exrow,"des_mag"))
	if isNull (ls_temp) then ls_temp = "___"
	ls_titolo = ls_titolo + " - " + ls_temp
end if
ls_titolo += "~rTipo documenti da generare: "
ls_temp = string(idw_scelta.GetItemString(il_ch_exrow,"cod_pro"))
if isNull (ls_temp) then ls_temp = "___"
ls_titolo = ls_titolo + ls_temp + " - "
ls_temp = string(idw_scelta.GetItemString(il_ch_exrow,"des_pro"))
if isNull (ls_temp) then ls_temp = "___"
ls_titolo = ls_titolo + ls_temp

idw_anom_rpt.object.titolo_2.text = ls_titolo

idw_errori.visible = false
idw_anom_rpt.visible = true

end event

type cb_report from commandbutton within w_deriva_batch_wz
event clicked pbm_bnclicked
integer x = 1851
integer y = 28
integer width = 443
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Report di prova"
end type

event clicked;
//if is_pancali = 'S' then
//	ds_eva_imb_app.reset()
//end if 	

wf_elab_tutto(false,"ciao")



end event

type cb_genera from commandbutton within w_deriva_batch_wz
integer x = 2309
integer y = 28
integer width = 443
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&Gen. Documenti"
end type

event clicked;
//if is_pancali = 'S' then
//	ds_eva_imb_app.reset()
//end if 	

il_num_fat=0
wf_elab_tutto(true,"ciao")
enabled=false


end event

type tab_1 from tab within w_deriva_batch_wz
event create ( )
event destroy ( )
integer x = 37
integer y = 152
integer width = 2761
integer height = 1524
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_6 tabpage_6
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_6=create tabpage_6
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_6,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_6)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2725
integer height = 1404
long backcolor = 79741120
string text = "Scelta Parametri"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_scelta_prof cb_scelta_prof
dw_scelta dw_scelta
dw_testa_wrk dw_testa_wrk
end type

on tabpage_1.create
this.cb_scelta_prof=create cb_scelta_prof
this.dw_scelta=create dw_scelta
this.dw_testa_wrk=create dw_testa_wrk
this.Control[]={this.cb_scelta_prof,&
this.dw_scelta,&
this.dw_testa_wrk}
end on

on tabpage_1.destroy
destroy(this.cb_scelta_prof)
destroy(this.dw_scelta)
destroy(this.dw_testa_wrk)
end on

type cb_scelta_prof from commandbutton within tabpage_1
integer x = 521
integer y = 492
integer width = 855
integer height = 92
integer taborder = 74
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Scegli più di un Profilo Iniziale"
end type

event clicked;long ll_id_prof_dest, ll_null
string ls_null

if cb_scelta_prof.text="Scegli un solo Profilo Iniziale" then
	
	tab_1.tabpage_6.dw_recuperati_lt.reset()
	tab_1.tabpage_6.dw_selezionati_lt.reset()
	
	dw_scelta.setitem(1, "scelta_prof", 'N')
	
	tab_1.tabpage_6.visible=false
	
	cb_scelta_prof.text="Scegli più di un Profilo Iniziale"
else
	
	ll_id_prof_dest=dw_scelta.getitemnumber(1, "id_pro")
	if isnull(ll_id_prof_dest) then
		messagebox("Attenzione!", "Inserire prima un profilo di destinazione!") 
		return
	end if
	
	setnull(ll_null)
	setnull(ls_null)
	dw_scelta.setitem(1, "id_pro_iniz", ll_null)
	dw_scelta.setitem(1, "cod_pro_iniz", ls_null)
	dw_scelta.setitem(1, "des_pro_iniz", ls_null)
	
	dw_scelta.setitem(1, "scelta_prof", 'S')
	
	tab_1.tabpage_6.visible=true
	dw_scelta.setcolumn("data_emissione")
	
	tab_1.tabpage_6.dw_recuperati_lt.settransobject(sqlca)
	tab_1.tabpage_6.dw_recuperati_lt.retrieve(ll_id_prof_dest)
	tab_1.SelectTab(2)
	
	cb_scelta_prof.text="Scegli un solo Profilo Iniziale"
end if

end event

type dw_scelta from u_dw_ext_main within tabpage_1
event itemchanged pbm_dwnitemchange
event ue_set_search ( string as_nomecol,  string as_valcol )
event ue_use_search ( string as_nomecol )
event ue_controllo_data_fine ( string as_column )
event ue_set_sql_cond ( string as_column )
integer x = 27
integer y = 44
integer width = 2674
integer height = 1360
integer taborder = 51
string dataobject = "d_par_der_batch"
end type

event itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string		ls_a, ls_b, ls_c, ls_pc
date			ld_data_inizio
long			ll_a, ll_ok, ll_row, ll_scode, ll_id_prof_dest
long			ll_null
setnull(ll_null)

ll_row = GetRow()
if ll_row > 0 then
	CHOOSE CASE dwo.name
		CASE 'data_fine'
			Post Event ue_controllo_data_fine("data_fine")
		CASE 'data_emissione'
			Post Event ue_controllo_data_fine("data_emissione")

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		CASE "cod_int"
			ls_pc = data
			SELECT	"sog_commerciale_gen"."id_sog_commerciale",
						"sog_commerciale_gen"."codice",   
						"sog_commerciale_gen"."rag_soc_1"  
				INTO	:ll_a, :ls_b, :ls_c  
				FROM	"dba"."sog_commerciale_gen"  
				WHERE "sog_commerciale_gen"."codice" = :ls_pc;
			
			if sqlca.sqlcode=0 then
				setItem (ll_row,"id_int",ll_a)
				setItem (ll_row,"COD_int",ls_b)
				setItem (ll_row,"des_int",ls_c)
				return 2
			else
				setItem (ll_row,"id_int",u_freddie.gl_null)
				setItem (ll_row,"des_int",u_freddie.gs_null)
				setItem (ll_row,"id_destinazione",u_freddie.gl_null)
				setItem (ll_row,"destinazione",u_freddie.gs_null)
				return 0
			end if

		CASE 'des_int'
			ls_sql_cond = ""
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_int"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_int"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "des_int"
			ls_dbc[4] = "indirizzo"
			ls_dwc[4] = "destinazione"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 4, &
											ls_dbc, ls_dbv, ls_dwc)
			if isNull (GetItemNumber(ll_row,"id_int")) then
				setItem (ll_row,"id_destinazione",u_freddie.gl_null)
				setItem (ll_row,"destinazione",u_freddie.gs_null)
			end if
			IF (ll_ok > 0) Or data <> GetItemString(ll_row, "des_int") THEN
				RETURN 2
			END IF

		CASE 'destinazione'
			
			Event ue_set_sql_cond("id_int")
			ls_sql_cond = is_ricpar.s_sql_cond  
			ls_dbc[1]  = "id_destinazione"
			ls_dwc[1]  = "id_destinazione"
			ls_dbc[2]  = "rag_soc_1"
			ls_dwc[2]  = "destinazione"
			ll_ok = uf_autofind_col(dwo.Name, "destinazione", &
											"rag_soc_1", "A", data, &
											ls_sql_cond, 2, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		CASE "cod_int2"
			ls_pc = data
			SELECT	"sog_commerciale_gen"."id_sog_commerciale",
						"sog_commerciale_gen"."codice",   
						"sog_commerciale_gen"."rag_soc_1"  
				INTO	:ll_a, :ls_b, :ls_c  
				FROM	"dba"."sog_commerciale_gen"  
				WHERE "sog_commerciale_gen"."codice" = :ls_pc;
			
			if sqlca.sqlcode=0 then
				setItem (ll_row,"id_int2",ll_a)
				setItem (ll_row,"cod_int2",ls_b)
				setItem (ll_row,"des_int2",ls_c)
				return 2
			else
				setItem (ll_row,"id_int2",u_freddie.gl_null)
				setItem (ll_row,"des_int2",u_freddie.gs_null)
				return 0	
			end if

		CASE 'des_int2'
			ls_sql_cond = ""
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_int2"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_int2"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "des_int2"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) Or data <> GetItemString(ll_row, "des_int2") THEN
				RETURN 2
			END IF

		CASE 'cod_mag'
			ls_sql_cond = ""
			ls_dbc[1]  = "id_magazzino"
			ls_dwc[1]  = "id_mag"
			ls_dbc[2]  = "codice"
			ls_dwc[2]  = "cod_mag"
			ls_dbc[3]  = "descrizione"
			ls_dwc[3]  = "des_mag"
			ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
											"codice", "A", data, &
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		CASE 'des_mag'
			ls_sql_cond = ""  
			ls_dbc[1]  = "id_magazzino"
			ls_dwc[1]  = "id_mag"
			ls_dbc[2]  = "codice"
			ls_dwc[2]  = "cod_mag"
			ls_dbc[3]  = "descrizione"
			ls_dwc[3]  = "des_mag"
			ll_ok = uf_autofind_col(dwo.Name, "magazzino", &
											"descrizione", "A", data, &
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		CASE 'cod_vett'
			
			Event ue_set_sql_cond("id_vett")
			ls_sql_cond = is_ricpar.s_sql_cond  
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_vett"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_vett"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "des_vett"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) Or data <> GetItemString(ll_row, "cod_vett") THEN
				RETURN 2
			END IF

		CASE 'des_vett'
			
			Event ue_set_sql_cond("id_vett")
			ls_sql_cond = is_ricpar.s_sql_cond  
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_vett"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "cod_vett"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "des_vett"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) Or data <> GetItemString(ll_row, "des_vett") THEN
				RETURN 2
			END IF
			
		CASE 'cod_pro'
			
			
			Event ue_set_sql_cond("id_mag")
			ls_sql_cond = is_ricpar.s_sql_cond  
			ls_dbc[1]  = "id_prof_documento"
			ls_dwc[1]  = "id_pro"
			ls_dbc[2]  = "codice"
			ls_dwc[2]  = "cod_pro"
			ls_dbc[3]  = "descrizione"
			ls_dwc[3]  = "des_pro"
			ll_ok = uf_autofind_col(dwo.Name, "prof_documento", &
											"codice", "A", data, &
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
		CASE 'des_pro'
			
			
			Event ue_set_sql_cond("id_mag")
			ls_sql_cond = is_ricpar.s_sql_cond  
			ls_dbc[1]  = "id_prof_documento"
			ls_dwc[1]  = "id_pro"
			ls_dbc[2]  = "codice"
			ls_dwc[2]  = "cod_pro"
			ls_dbc[3]  = "descrizione"
			ls_dwc[3]  = "des_pro"
			ll_ok = uf_autofind_col(dwo.Name, "prof_documento", &
											"descrizione", "A", data, &
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		CASE 'cod_pro_iniz'
			
			
			
			ll_id_prof_dest=dw_scelta.getitemnumber(1, "id_pro")
			if isnull(ll_id_prof_dest) then
				messagebox("Attenzione!", "Inserire prima un profilo di destinazione!") 
				post wf_setta_colonna(this, string(dwo.name),1,  "")
				return 
			end if
			
			Event ue_set_sql_cond("id_mag")
			ls_sql_cond = is_ricpar.s_sql_cond  
			ls_dbc[1]  = "id_prof_documento"
			ls_dbc[2]  = "codice"
			ls_dbc[3]  = "descrizione"
			if dwo.name='cod_pro_fin' then
				ls_dwc[1]  = "id_pro_fine"
				ls_dwc[2]  = "cod_pro_fin"
				ls_dwc[3]  = "des_pro_fin"
			else
				ls_dwc[1]  = "id_pro_iniz"
				ls_dwc[2]  = "cod_pro_iniz"
				ls_dwc[3]  = "des_pro_iniz"
			end if
			
			ll_ok = uf_autofind_col(dwo.Name, "prof_documento", &
											"codice", "A", data, &
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
		CASE 'des_pro_iniz'
			
			
			
			ll_id_prof_dest=dw_scelta.getitemnumber(1, "id_pro")
			if isnull(ll_id_prof_dest) then
				messagebox("Attenzione!", "Inserire prima un profilo di destinazione!") 
				post wf_setta_colonna(this, string(dwo.name),1,  "")
				return 
			end if
			
			Event ue_set_sql_cond("id_mag")
			ls_sql_cond = is_ricpar.s_sql_cond  
			if dwo.name='des_pro_fin' then
				ls_dwc[1]  = "id_pro_fine"
				ls_dwc[2]  = "cod_pro_fin"
				ls_dwc[3]  = "des_pro_fin"
			else
				ls_dwc[1]  = "id_pro_iniz"
				ls_dwc[2]  = "cod_pro_iniz"
				ls_dwc[3]  = "des_pro_iniz"
			end if
			ls_dbc[1]  = "id_prof_documento"
			ls_dbc[2]  = "codice"
			ls_dbc[3]  = "descrizione"
		
			ll_ok = uf_autofind_col(dwo.Name, "prof_documento", &
											"descrizione", "A", data, &
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
			
		case 'ordina'
			if data='C' then
				tab_1.tabpage_3.dw_sc.setsort("codice")
				tab_1.tabpage_3.dw_sc.sort()
			else
				tab_1.tabpage_3.dw_sc.setsort("ragsoc")
				tab_1.tabpage_3.dw_sc.sort()
			end if
	END CHOOSE
else
	
	MessageBox("Errore!","Riga nulla!")
end if
end event

event ue_set_search;

long		ll_row, ll_id_int, ll_id_destinazione

ll_row = GetRow()
CHOOSE CASE as_nomecol

	CASE "cod_int"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	CASE "des_int"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"

	CASE "cod_int2"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	CASE "des_int2"
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"

   CASE "destinazione"
		Event ue_set_sql_cond("id_int")
		is_search_window = "w_destinazione_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"

	CASE "cod_mag"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	CASE "des_mag"
		is_search_window = "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "descrizione"
	
	CASE "cod_vett"
		Event ue_set_sql_cond("id_vett")
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "codice"
	CASE "des_vett"

		Event ue_set_sql_cond("id_vett")
		is_search_window = "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "rag_soc_1"

	CASE "cod_pro"
		Event ue_set_sql_cond("id_mag")
		is_search_window = "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_codice"
	CASE "des_pro"
		Event ue_set_sql_cond("id_mag")
		is_search_window = "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value = as_valcol
		is_ricpar.s_filter_name = "prof_documento_descrizione"
		
	CASE "cod_pro_iniz"
		is_search_window 				= "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value 	= as_valcol
		is_ricpar.s_filter_name 	= "prof_documento_codice"
	CASE "des_pro_iniz"
		is_search_window 				= "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value 	= as_valcol
		is_ricpar.s_filter_name 	= "prof_documento_descrizione"
		
	

END CHOOSE

end event

event ue_use_search;

CHOOSE CASE as_nomecol

	CASE "cod_int"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_int", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_int", is_ricpar.s_ausil_value[1])
		
	CASE "des_int"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_int", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_int", is_ricpar.s_ausil_value[1])
		
	CASE "cod_int2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_int2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_int2", is_ricpar.s_ausil_value[1])
	CASE "des_int2"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_int2", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_int2", is_ricpar.s_ausil_value[1])

	CASE "destinazione"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_destinazione", is_ricpar.s_id_seg_value[1])

	CASE "cod_mag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_mag", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_mag", is_ricpar.s_ausil_value[1])
	CASE "des_mag"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_mag", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_mag", is_ricpar.s_ausil_value[1])

	CASE "cod_vett"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_vett", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_vett", is_ricpar.s_ausil_value[1])
	CASE "des_vett"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_vett", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_vett", is_ricpar.s_ausil_value[1])

	CASE "cod_pro"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_pro", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_pro", is_ricpar.s_ausil_value[1])
	CASE "des_pro"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_pro", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_pro", is_ricpar.s_ausil_value[1])

	CASE "cod_pro_iniz"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_pro_iniz", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_pro_iniz", is_ricpar.s_ausil_value[1])
	CASE "des_pro_iniz"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_pro_iniz", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_pro_iniz", is_ricpar.s_ausil_value[1])
	CASE "cod_pro_fin"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_pro_fine", is_ricpar.s_id_seg_value[1])
		uf_set_colval("des_pro_fin", is_ricpar.s_ausil_value[1])
	CASE "des_pro_fin"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_pro_fine", is_ricpar.s_id_seg_value[1])
		uf_set_colval("cod_pro_fin", is_ricpar.s_ausil_value[1])
		
END CHOOSE

end event

event ue_controllo_data_fine;call super::ue_controllo_data_fine;long		ll_row
date		ld_data_inizio, ld_data_fine, ld_data_emissione

ll_row = This.GetRow()

CHOOSE CASE as_column
	CASE "data_fine"
		ld_data_inizio = GetItemDate(ll_row, "data_inizio")
		ld_data_fine = GetItemDate(ll_row, "data_fine")
		if String(ld_data_fine, "yyyymmdd") < String(ld_data_inizio,"yyyymmdd") then
			MessageBox("Attenzione!", "La data finale non può essere inferiore a quella di inizio.")
			SetColumn("data_fine")
		end if
	CASE "data_emissione"
		ld_data_fine = GetItemDate(ll_row, "data_fine")
		ld_data_emissione = GetItemDate(ll_row, "data_emissione")
		if String(ld_data_emissione, "yyyymmdd") < String(ld_data_fine,"yyyymmdd") then
			MessageBox("Attenzione!", "La data di emissione non può essere inferiore a quella finale.")
			SetColumn("data_emissione")
		end if
END CHOOSE
end event

event ue_set_sql_cond;call super::ue_set_sql_cond;long		ll_row, ll_id_int, ll_id_mag

ll_row = GetRow()

if ll_row > 0 then
	CHOOSE CASE as_column
		CASE "id_int"
		
			ll_id_int = GetItemNumber(ll_row, "id_int")
			if ll_id_int > 0 And Not IsNull(ll_id_int) then
				is_sql_cond = "destinazione.id_sog_commerciale = " + string(ll_id_int)
				is_ricpar.s_sql_cond = is_sql_cond
			else
				is_sql_cond = ""
				is_ricpar.s_sql_cond = ""
			end if
		CASE "id_mag"
			
			
			ll_id_mag = GetItemNumber(ll_row, "id_mag")
			if ll_id_mag > 0 AND Not IsNull(ll_id_mag) then
				is_sql_cond = "prof_documento.id_magazzino_1_prop = " + string(ll_id_mag) + " AND "
				is_ricpar.s_sql_cond = is_sql_cond
			else
				is_sql_cond = ""
				is_ricpar.s_sql_cond = ""
			end if
			
			
			is_ricpar.s_sql_cond = is_ricpar.s_sql_cond + "prof_documento.id_caus_magazzino_prop is not null"

		CASE "id_vett"
			
			is_ricpar.s_sql_cond = "sog_commerciale_gen.tipo = 'V'"

END CHOOSE
end if

end event

event ue_init;is_colonne_drop[1] = "id_cat_com_sc"
is_colonne_drop[2] = "id_cat_zona"
is_colonne_drop[3] = "id_cat_attivita"
is_colonne_drop[4] = "id_grag"
is_colonne_drop[5] = "id_cpag"
is_colonne_drop[6] = "id_cpag_des"		
end event

event clicked;long ll_id_prof_dest


if ((dwo.type="bitmap") and (dwo.name="cod_pro_iniz_sw" or dwo.name="des_pro_iniz_sw" )) then
	ll_id_prof_dest=dw_scelta.getitemnumber(1, "id_pro")
	if isnull(ll_id_prof_dest) then
		messagebox("Attenzione!", "Inserire prima un profilo di destinazione!") 
		return
	end if
end if
call super::clicked		
		
		
end event

type dw_testa_wrk from datawindow within tabpage_1
integer x = 1211
integer y = 44
integer width = 1211
integer height = 1244
integer taborder = 63
string dataobject = "d_documento_ordine_ff"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event sqlpreview;MessageBox("",sqlsyntax)

end event

type tabpage_6 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 104
integer width = 2725
integer height = 1404
long backcolor = 79741120
string text = "Profili da Derivare"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_remove_all cb_remove_all
cb_remove_many cb_remove_many
cb_drop_many cb_drop_many
cb_drop_all cb_drop_all
dw_selezionati_lt dw_selezionati_lt
dw_recuperati_lt dw_recuperati_lt
end type

on tabpage_6.create
this.cb_remove_all=create cb_remove_all
this.cb_remove_many=create cb_remove_many
this.cb_drop_many=create cb_drop_many
this.cb_drop_all=create cb_drop_all
this.dw_selezionati_lt=create dw_selezionati_lt
this.dw_recuperati_lt=create dw_recuperati_lt
this.Control[]={this.cb_remove_all,&
this.cb_remove_many,&
this.cb_drop_many,&
this.cb_drop_all,&
this.dw_selezionati_lt,&
this.dw_recuperati_lt}
end on

on tabpage_6.destroy
destroy(this.cb_remove_all)
destroy(this.cb_remove_many)
destroy(this.cb_drop_many)
destroy(this.cb_drop_all)
destroy(this.dw_selezionati_lt)
destroy(this.dw_recuperati_lt)
end on

type cb_remove_all from commandbutton within tabpage_6
integer x = 1221
integer y = 724
integer width = 247
integer height = 88
integer taborder = 94
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<"
end type

event clicked;long ll_Rows, ll_i, ll_CurrRow


ll_Rows = dw_selezionati_lt.RowCount()

dw_selezionati_lt.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
			dw_selezionati_lt.rowsmove(ll_i,ll_i,primary!,dw_recuperati_lt,1,primary!)
			
NEXT

dw_recuperati_lt.Sort()

end event

type cb_remove_many from commandbutton within tabpage_6
integer x = 1225
integer y = 604
integer width = 247
integer height = 88
integer taborder = 84
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
end type

event clicked;long ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo

ll_Rows = dw_selezionati_lt.RowCount()
dw_selezionati_lt.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF dw_selezionati_lt.IsSelected(ll_i) THEN
		dw_selezionati_lt.rowsmove(ll_i,ll_i,primary!,dw_recuperati_lt,1,primary!)
	END IF
NEXT

dw_recuperati_lt.Sort()

end event

type cb_drop_many from commandbutton within tabpage_6
integer x = 1221
integer y = 388
integer width = 247
integer height = 88
integer taborder = 61
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
end type

event clicked;

long ll_Rows, ll_i, ll_CurrRow
decimal ldc_tot_scadenza_importo

ll_Rows = dw_recuperati_lt.RowCount()
dw_recuperati_lt.SetRow(1)

FOR ll_i = ll_Rows TO 1 STEP -1
	IF dw_recuperati_lt.IsSelected(ll_i) THEN
		dw_recuperati_lt.rowsmove(ll_i,ll_i,primary!,dw_selezionati_lt,1,primary!)
	END IF
NEXT

dw_selezionati_lt.Sort()


end event

type cb_drop_all from commandbutton within tabpage_6
integer x = 1221
integer y = 268
integer width = 247
integer height = 88
integer taborder = 90
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;long ll_Rows, ll_i, ll_CurrRow,contatore
decimal ldc_tot_scadenza_importo

ll_Rows =dw_recuperati_lt.rowcount()

dw_recuperati_lt.setrow(1)
FOR ll_i = ll_Rows TO 1 STEP -1
		dw_recuperati_lt.ScrollToRow (ll_i) 		
		dw_recuperati_lt.rowsmove(ll_i,ll_i,primary!,dw_selezionati_lt,1,primary!)
		contatore=contatore+1
		dw_selezionati_lt.selectrow(contatore,true)
NEXT

dw_selezionati_lt.Sort()



dw_selezionati_lt.setfocus()


end event

type dw_selezionati_lt from u_dw_pura within tabpage_6
integer x = 1522
integer y = 32
integer width = 1134
integer height = 1372
integer taborder = 11
boolean titlebar = true
string title = "Selezionati"
string dataobject = "d_prof_doc_derivabili_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;wf_selezione(row,this,"",this,"","")

end event

type dw_recuperati_lt from u_dw_pura within tabpage_6
event ue_buttonup pbm_lbuttonup
event ue_buttondown pbm_lbuttondown
event ue_mousemove pbm_mousemove
integer x = 23
integer y = 24
integer width = 1134
integer height = 1372
integer taborder = 11
boolean titlebar = true
string title = "Disponibili"
string dataobject = "d_prof_doc_derivabili_gd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_buttonup;
end event

event ue_buttondown;
end event

event ue_mousemove;
end event

event clicked;wf_selezione(row,this,"",this,"","")
end event

event dragenter;
end event

event dragleave;
end event

event rowfocuschanged;
end event

event sqlpreview;

end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2725
integer height = 1404
long backcolor = 79741120
string text = "Anomalie"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_anom_rpt dw_anom_rpt
dw_errori dw_errori
end type

on tabpage_2.create
this.dw_anom_rpt=create dw_anom_rpt
this.dw_errori=create dw_errori
this.Control[]={this.dw_anom_rpt,&
this.dw_errori}
end on

on tabpage_2.destroy
destroy(this.dw_anom_rpt)
destroy(this.dw_errori)
end on

type dw_anom_rpt from datawindow within tabpage_2
event clicked pbm_dwnlbuttonclk
integer x = 37
integer y = 40
integer width = 3109
integer height = 1484
integer taborder = 51
string dataobject = "d_deriva_batch_err_rpt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
this.visible = false
idw_errori.visible = true
end event

type dw_errori from datawindow within tabpage_2
event doubleclicked pbm_dwnlbuttondblclk
boolean visible = false
integer x = 27
integer y = 44
integer width = 2629
integer height = 1244
integer taborder = 51
string dataobject = "d_deriva_batch_03_gd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;

end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 104
integer width = 2725
integer height = 1404
long backcolor = 79741120
string text = "Work DW"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cpt_wrk dw_cpt_wrk
dw_scad_wrk dw_scad_wrk
dw_iva_wrk dw_iva_wrk
dw_spese_wrk dw_spese_wrk
dw_docs dw_docs
dw_sc dw_sc
dw_r2 dw_r2
end type

on tabpage_3.create
this.dw_cpt_wrk=create dw_cpt_wrk
this.dw_scad_wrk=create dw_scad_wrk
this.dw_iva_wrk=create dw_iva_wrk
this.dw_spese_wrk=create dw_spese_wrk
this.dw_docs=create dw_docs
this.dw_sc=create dw_sc
this.dw_r2=create dw_r2
this.Control[]={this.dw_cpt_wrk,&
this.dw_scad_wrk,&
this.dw_iva_wrk,&
this.dw_spese_wrk,&
this.dw_docs,&
this.dw_sc,&
this.dw_r2}
end on

on tabpage_3.destroy
destroy(this.dw_cpt_wrk)
destroy(this.dw_scad_wrk)
destroy(this.dw_iva_wrk)
destroy(this.dw_spese_wrk)
destroy(this.dw_docs)
destroy(this.dw_sc)
destroy(this.dw_r2)
end on

type dw_cpt_wrk from datawindow within tabpage_3
integer x = 2071
integer y = 480
integer width = 640
integer height = 400
integer taborder = 64
string dataobject = "d_contr_documento_lt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_scad_wrk from datawindow within tabpage_3
integer x = 2071
integer y = 28
integer width = 640
integer height = 444
integer taborder = 63
string dataobject = "d_scadenza_documento_lt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_iva_wrk from datawindow within tabpage_3
integer x = 2075
integer y = 892
integer width = 640
integer height = 444
integer taborder = 62
string dataobject = "d_cast_iva_documento_lt"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_spese_wrk from datawindow within tabpage_3
integer x = 27
integer y = 28
integer width = 2030
integer height = 364
integer taborder = 52
string dataobject = "d_deriva_batch_spese_tb"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_docs from datawindow within tabpage_3
integer x = 27
integer y = 396
integer width = 960
integer height = 880
integer taborder = 62
string dataobject = "d_deriva_batch_01_gd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_sc from datawindow within tabpage_3
integer x = 1015
integer y = 896
integer width = 1042
integer height = 380
integer taborder = 61
string dataobject = "d_deriva_batch_sc_gd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_r2 from datawindow within tabpage_3
integer x = 1029
integer y = 396
integer width = 1029
integer height = 464
integer taborder = 51
string dataobject = "d_deriva_batch_04_ex"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_4 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 2725
integer height = 1404
long backcolor = 79741120
string text = "Report di prova"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
mle_report mle_report
dw_testrighe dw_testrighe
end type

on tabpage_4.create
this.mle_report=create mle_report
this.dw_testrighe=create dw_testrighe
this.Control[]={this.mle_report,&
this.dw_testrighe}
end on

on tabpage_4.destroy
destroy(this.mle_report)
destroy(this.dw_testrighe)
end on

type mle_report from multilineedit within tabpage_4
integer x = 434
integer y = 60
integer width = 2080
integer height = 1244
integer taborder = 61
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Report dell~'acquisizione"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_testrighe from datawindow within tabpage_4
integer x = 41
integer y = 40
integer width = 2592
integer height = 1320
integer taborder = 51
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_deriva_batch_righe_tb"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 2725
integer height = 1404
long backcolor = 79741120
string text = "Lista Fatture"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_stampa_lis_fat cb_stampa_lis_fat
dw_fat_gen dw_fat_gen
end type

on tabpage_5.create
this.cb_stampa_lis_fat=create cb_stampa_lis_fat
this.dw_fat_gen=create dw_fat_gen
this.Control[]={this.cb_stampa_lis_fat,&
this.dw_fat_gen}
end on

on tabpage_5.destroy
destroy(this.cb_stampa_lis_fat)
destroy(this.dw_fat_gen)
end on

type cb_stampa_lis_fat from commandbutton within tabpage_5
integer x = 1655
integer y = 16
integer width = 247
integer height = 96
integer taborder = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Stampa"
end type

event clicked;printsetup()
dw_fat_gen.print()
end event

type dw_fat_gen from datawindow within tabpage_5
integer x = 14
integer y = 124
integer width = 2642
integer height = 1152
integer taborder = 61
string dataobject = "d_fatture_generate"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_annulla from commandbutton within w_deriva_batch_wz
integer x = 411
integer y = 28
integer width = 306
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Esci"
end type

event clicked;close (parent)
end event

