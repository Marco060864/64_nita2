forward
global type w_documento_batch_wz from Window
end type
type cb_procedi from commandbutton within w_documento_batch_wz
end type
type cb_anomalie from commandbutton within w_documento_batch_wz
end type
type cb_report from commandbutton within w_documento_batch_wz
end type
type cb_genera from commandbutton within w_documento_batch_wz
end type
type tab_1 from tab within w_documento_batch_wz
end type
type tabpage_1 from userobject within tab_1
end type
type st_title from statictext within tabpage_1
end type
type dw_select_riordini_lt from u_dw_ext_main within tabpage_1
end type
type dw_scelta from u_dw_ext_main within tabpage_1
end type
type dw_testa_wrk from datawindow within tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_anom_rpt from datawindow within tabpage_2
end type
type dw_errori from datawindow within tabpage_2
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
type tabpage_4 from userobject within tab_1
end type
type mle_report from multilineedit within tabpage_4
end type
type dw_testrighe from datawindow within tabpage_4
end type
type cb_annulla from commandbutton within w_documento_batch_wz
end type
type tabpage_1 from userobject within tab_1
st_title st_title
dw_select_riordini_lt dw_select_riordini_lt
dw_scelta dw_scelta
dw_testa_wrk dw_testa_wrk
end type
type tabpage_2 from userobject within tab_1
dw_anom_rpt dw_anom_rpt
dw_errori dw_errori
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
mle_report mle_report
dw_testrighe dw_testrighe
end type
type tab_1 from tab within w_documento_batch_wz
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
end forward

global type w_documento_batch_wz from Window
int X=1074
int Y=484
int Width=2816
int Height=1660
boolean TitleBar=true
string Title="Generazione automatica documenti"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_procedi cb_procedi
cb_anomalie cb_anomalie
cb_report cb_report
cb_genera cb_genera
tab_1 tab_1
cb_annulla cb_annulla
end type
global w_documento_batch_wz w_documento_batch_wz

type variables
w_wait_01	iw_wait

integer ii_dwi

multilineedit	imle_rep

long		il_cifra_arr
string		is_tipo_arr

u_sql_scanner	iuo_scan
u_sql_scanner	iuo_scan_fabbisogno
uo_esp_pag	iuo_pag

u_ds_main	ids_derp,ids_docs
u_ds_main	ids_sc, ids_testa, ids_spese, ids_riga
u_ds_main	ids_iva, ids_scad, ids_cpt
u_ds_main	ids_righe_sog_comm

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

long		il_sc_idl1, il_sc_idl2, il_sc_idtt
long		il_sc_idlis, il_sc_idvet, il_sc_idconto



end variables

forward prototypes
public function long wf_check_sel ()
public function long wf_elab_sc (boolean ab_definitiva, long al_scrow)
public function long wf_elab_tutto (boolean ab_definitiva, string as_dummy)
public function integer wf_set_testa (long al_scrow)
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
public function long wf_calc_piede_doc (long al_row, boolean ab_definitiva)
public function boolean wf_salva_documento ()
public function integer wf_raccogli_sogg_commerciali ()
public function long wf_get_righe (long al_id_sogg_commerciale)
public function integer wf_set_riga_arr (long al_r1, long al_id_sogg_commerciale)
public function boolean wf_test_data_registrazione (date ad_data)
public function integer wf_calc_spese ()
public function integer wf_insert_riga_cpt (long al_idcpt, string as_tipo, u_ds_main ads_cpt, decimal ad_imponibile, decimal ad_impscontato, decimal ad_omaggism, decimal ad_spese)
public function integer wf_insert_riga_iva (long al_idtabiva, decimal ad_aliquota, decimal ad_perdetra, decimal ad_imponibile, decimal ad_imposta, decimal ad_omaggism, u_ds_main ads_cast)
public function integer wf_set_note ()
public function boolean wf_verify_data (date ad_data)
public function integer wf_dw_setfocus ()
public function integer wf_delete_rows_fabbisogno ()
end prototypes

public function long wf_check_sel ();
long		ll_prof, ll_idvp,ll_id_esercizio_prop
long		ll_retv, ll_code,ll_i
char		lc_temp[],lc_t
string	ls_toterr,ls_intestatari_consentiti,ls_tipo
boolean	lb_found
long		ll_temp, ll_id_mod_registro, ll_id_m1p, ll_id_m2p

lb_found	= false

ll_retv = 0
ls_toterr = ""

id_ch_reg 		= idw_scelta.GetItemDate(il_ch_exrow,"data_emissione")
il_ch_idsc 		= idw_scelta.GetItemNumber(il_ch_exrow,"id_sog_commerciale")
il_ch_idmag 	= idw_scelta.GetItemNumber(il_ch_exrow,"id_magazzino_cod")
ll_prof 			= idw_scelta.GetItemNumber(il_ch_exrow,"id_profilo")
ll_id_esercizio_prop = idw_scelta.GetItemNumber(il_ch_exrow,"id_esercizio")


if isNull(ll_prof) or ll_prof=0 then
	ls_toterr += "Manca il profilo documento nella finestra di scelta.~r"
	ll_retv ++
	il_ch_idprof = 0
else
	il_ch_idprof = ll_prof
end if



select	prof_documento.usa_int_fattura,			prof_documento.id_caus_magazzino_prop,
			prof_documento.des_contabile,				prof_documento.id_mod_registro_prop,
			prof_documento.id_magazzino_1_prop,		prof_documento.id_magazzino_2_prop,
			prof_documento.id_lingua_prop,			prof_documento.id_linguaggio_prop,
			prof_documento.cambio_rical_der,			prof_documento.id_listino_prop,
			prof_documento.note_intestazione_prop,	prof_documento.id_prof_registrazione,
			prof_documento.spese_gestite,				prof_documento.stato_scad_generata,
			prof_documento.tipo_registro
			
into		:is_ch_intfat, :il_td_idcmag, :is_td_descon, :ll_id_mod_registro, :ll_id_m1p,  :ll_id_m2p,
			:il_td_idl1,   :il_td_idl2,   :is_ch_ricchg, :il_td_idlis,        :is_td_note, :il_td_idprr,
			:is_ch_spgest, :is_statoscgen,:is_td_tiporeg
				
from		dba.prof_documento
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

if isNull(il_ch_idsc) then
	ls_toterr += "Manca il soggetto commerciale nella finestra di scelta.~r"
	ll_retv ++
	il_ch_idsc = 0
end if

if isNull (il_ch_idmag) then
	ls_toterr += "Manca il magazzino nella finestra di scelta.~r"
	ll_retv ++
	il_ch_idsc 	= 0
	il_td_idmag = 0
else
	il_td_idmag = il_ch_idmag
end if

if isNull(id_ch_reg) then
	ls_toterr += "Manca la data emissione nella finestra di scelta.~r"
	ll_retv ++
end if

if not isNull(il_ch_idsc) and not isNull(il_ch_idprof) and il_ch_idprof <> 0 then
	select "prof_documento"."int_consentiti"
		into :ls_intestatari_consentiti
		from "dba"."prof_documento"
		where "prof_documento"."id_prof_documento" = :il_ch_idprof
		using SQLCA;
		
	select "sog_commerciale_gen"."tipo"
		into :ls_tipo
		from "dba"."sog_commerciale_gen"
		where "sog_commerciale_gen"."id_sog_commerciale" = :il_ch_idsc
		using SQLCA;	
		
	lc_temp	= 	ls_intestatari_consentiti
	lc_t		= 	ls_tipo
	for ll_i = 1 to Upperbound( lc_temp )
		if lc_temp[ll_i] = lc_t then
			lb_found = true
		end if
	next
	
	if lb_found	= false then
		ls_toterr += "Il tipo del soggetto commerciale non rientra nel profilo.~r"
		ll_retv ++
	end if
		
end if

if isNull(ll_id_esercizio_prop ) then
	ls_toterr += "Manca l'esercizio.~r"
	ll_retv ++
end if

select	"azienda"."id_esercizio"
	into	:ll_temp
	from	"dba"."azienda"
	where "azienda"."id_azienda" = 1
	using SQLCA;
		
if SQLCA.SQLCode < 0 then
	ls_toterr += "Impossibile recuperare l'esercizio.~r"
	ll_retv ++
	il_td_ideser = 0
else
	il_td_ideser = ll_temp
end if


select	"par_sistema"."id_valuta"
	into	:ll_idvp
	from	"dba"."par_sistema"
	where	"par_sistema"."id_azienda" = 1
	using	SQLCA;
		
if ll_idvp>0 then
	select	"valuta"."id_valuta",	"valuta"."cambio",
				"valuta"."cifra_arrotondamento",	"valuta"."tipo_arrotondamento"  
		into	:il_az_idvalu, :idc_az_cambio, :il_az_arrot, :is_az_tipoarr
		from	"dba"."valuta"
		where	"valuta"."id_valuta" = :ll_idvp
		using SQLCA;
end if

if ll_retv > 0 then
	MessageBox ("Errori nel controllo parametri",ls_toterr)
end if

return ll_retv

end function

public function long wf_elab_sc (boolean ab_definitiva, long al_scrow);

long			ll_nsc, ll_i, ll_errs, ll_idsc
long			ll_nrows
long			ll_righe_articoli
string		ls_filter, ls_sort
boolean		lb_rottura
pointer		lptr_1

lptr_1 = setPointer(HourGlass!)

open (iw_wait,"w_wait_01")

ll_idsc = ids_sc.GetItemNumber(al_scrow,"idsc")

if not isNull( ll_idsc ) then
	
	ll_righe_articoli	= wf_get_righe( ll_idsc )
	
	if ll_righe_articoli > 0 then
		
		open (iw_wait,"w_wait_01")
		
		is_mfa = ids_sc.GetItemString(al_scrow,"mfatt")
		if isNull (is_mfa) then 
			is_mfa = "R"
		end if
		
		select	"anagrafica"."id_lingua",						"anagrafica"."id_tipo_trasporto",
					"sog_commerciale"."id_linguaggio",			"sog_commerciale"."id_listino",
					"sog_commerciale"."id_sog_com_vettore",	"sog_commerciale"."id_conto"
				
			into	:il_sc_idl1,		:il_sc_idtt,	:il_sc_idl2,	:il_sc_idlis,
					:il_sc_idvet,		:il_sc_idconto

			from	"dba"."anagrafica",	"dba"."sog_commerciale"

			where	("sog_commerciale"."id_anagrafica" = "anagrafica"."id_anagrafica" ) and
					("sog_commerciale"."id_sog_commerciale" = :ll_idsc) ;

		wf_set_testa(al_scrow)
		
		for ll_i = 1 to ll_righe_articoli
			wf_set_riga_arr(ll_i,ll_idsc)
		next
		
		wf_calc_piede_doc(ll_i, ab_definitiva)
		
	end if
end if

SetPointer(lptr_1)

return 0

end function

public function long wf_elab_tutto (boolean ab_definitiva, string as_dummy);
long			ll_sogg_count, ll_i, ll_errs

imle_rep.text = "Inizio, wf_elab_tutto"
wf_raccogli_sogg_commerciali()

ll_sogg_count	= ids_sc.rowCount()
ll_errs = 0
if ll_sogg_count	>	0 then
	ids_sc.sort()
	for ll_i = 1 to ll_sogg_count
		ll_errs = wf_elab_sc(ab_definitiva,ll_i)
	next
end if

return ll_errs

end function

public function integer wf_set_testa (long al_scrow);
long		ll_row,       ll_idsc,ll_row_scelta
long		ll_id_profilo,ll_id_magazzino,ll_id_sog_commerciale
long		ll_id_prof_reg,ll_id_caus_magazzino,ll_id_magazzino_2
long		ll_id_lingua,ll_id_linguaggio,ll_id_anagrafica
long		ll_id_valuta,ll_id_listino,ll_id_gruppo_agenti,ll_id_con_pagamento
long		ll_id_banca_sog_commerciale
long		ll_giorni_consegna,ll_id_tipo_trasporto,ll_id_esercizio_prop
long		ll_id_vettore_1,ll_id_mod_registro
date		ld_data_reg
integer	li_ret
string	ls_temp, ls_ttot, ls_1, ls_2, ls_3, ls_4, ls_5
string	ls_testata, ls_dval
string	ls_des_contabile,ls_note_intestazione
string	ls_asp_beni,ls_tras_mezzo,ls_tipo_fattura

li_ret = 0
ll_idsc = ids_sc.GetItemNumber(al_scrow,"idsc")

ll_row_scelta				= tab_1.tabpage_1.dw_Scelta.GetRow()
ll_id_profilo				= tab_1.tabpage_1.dw_Scelta.GetItemNumber( ll_row_Scelta,"id_profilo" )
ll_id_magazzino			= tab_1.tabpage_1.dw_Scelta.GetItemNumber( ll_row_Scelta,"id_magazzino_cod" )
ll_id_sog_commerciale	= tab_1.tabpage_1.dw_Scelta.GetItemNumber( ll_row_Scelta,"id_sog_commerciale" )
ll_id_esercizio_prop		= tab_1.tabpage_1.dw_Scelta.GetItemNumber( ll_row_Scelta,"id_esercizio" )
ld_data_reg					= tab_1.tabpage_1.dw_Scelta.GetItemDate( ll_row_Scelta,"data_emissione" )

ids_spese.reset()
ids_riga.reset()

il_rowtesta = 0
ids_testa.reset()

ids_riga.object.testa_descon_t.text		= ""
ids_riga.object.testa_data_reg_t.text	= ""
ids_riga.object.testa_anag_t.text		= ""
ids_riga.object.testa_dest_t.text		= ""
ids_riga.object.testa_cpag_t.text		= ""
ids_riga.object.testa_bapp_t.text		= ""
ids_riga.object.testa_porto_t.text		= ""

ll_row = ids_testa.InsertRow(0)

if ll_row > 0 then

	select "prof_documento"."id_mod_registro_prop"     , "prof_documento"."id_prof_registrazione", "prof_documento"."des_contabile", &
			 "prof_documento"."id_caus_magazzino_prop"   , "prof_documento"."id_magazzino_2_prop"  , "prof_documento"."gg_consegna", &
			 "prof_documento"."note_intestazione_prop"   , "prof_documento"."aspetto_beni_prop"    , "prof_documento"."trasp_mezzo_prop", &
			 "prof_documento"."id_sog_comm_vettore_1_prop", "prof_documento"."tipo_fattura"
		into :ll_id_mod_registro,   :ll_id_prof_reg,    :ls_des_contabile, &
			  :ll_id_caus_magazzino, :ll_id_magazzino_2, :ll_giorni_consegna, &
			  :ls_note_intestazione, :ls_asp_beni,       :ls_tras_mezzo, &
			  :ll_id_vettore_1,      :ls_tipo_fattura
		from "dba"."prof_documento"
		where "prof_documento"."id_prof_documento" = :ll_id_profilo
		using SQLCA;	
	
	if SQLCA.SQLCode = -1 then
		MessageBox( "Select profilo","Errore : " + SQLCA.SQLErrText,StopSign! )
	end if
	select sog_commerciale.id_anagrafica, sog_commerciale.id_linguaggio, sog_commerciale.id_listino, &
			 sog_commerciale.id_con_pagamento, sog_commerciale.id_gruppo_agenti, sog_commerciale.id_banca_sog_commerciale, &
			 sog_commerciale.id_tipo_trasporto
		into :ll_id_anagrafica, :ll_id_linguaggio, :ll_id_listino, &
			  :ll_id_con_pagamento, :ll_id_gruppo_agenti, :ll_id_banca_sog_commerciale, &
			  :ll_id_tipo_trasporto
		from sog_commerciale
		where sog_commerciale.id_sog_commerciale = :ll_id_sog_commerciale
		using SQLCA;	
	
	if not isNull(ll_id_profilo) then
		ids_testa.SetItem(ll_row,"id_prof_documento",ll_id_profilo)
	end if

	if not isNull(ll_id_mod_registro) then
		
		select registro.id_registro
			into :il_td_idregi
			from registro
			where registro.id_mod_registro = :ll_id_mod_registro and registro.id_esercizio = :ll_id_esercizio_prop
			using SQLCA;
		
		if SQLCA.SQLCode = 0 then
			If not(IsNull(il_td_idregi) OR il_td_idregi=0) then
				ids_testa.SetItem(ll_row,"id_registro",il_td_idregi)
			end if	
		end if	
	end if
	ids_testa.SetItem(ll_row,"num_progressivo",0)
	ids_testa.SetItem(ll_row,"num_documento","0")
	
	if wf_test_data_registrazione(ld_data_reg) then
		ids_testa.SetItem(ll_row,"data_registrazione",ld_data_reg)
	else	
		ids_testa.SetItem(ll_row,"data_registrazione",Today())
	end if	

	if wf_test_data_registrazione(ld_data_reg) then
		ids_testa.SetItem(ll_row,"data_documento",ld_data_reg)
	else
		ids_testa.SetItem(ll_row,"data_documento",Today())
	end if
	
	if wf_test_data_registrazione(ld_data_reg) then
		ids_testa.SetItem(ll_row,"documento_data_competenza",ld_data_reg)
	else
		ids_testa.SetItem(ll_row,"documento_data_competenza",Today())
	end if

	if not isNull(ll_id_prof_reg) then 
		ids_testa.SetItem(ll_row,"id_prof_registrazione",ll_id_prof_reg)
	end if

	if not isNull(ls_des_contabile) then	
		ids_testa.SetItem(ll_row,"des_contabile",ls_des_contabile)
	end if	

	if not IsNull(ll_id_sog_commerciale) then 
		ids_testa.SetItem(ll_row,"id_sog_commerciale",ll_id_sog_commerciale)
	end if	

	if not isNull(ll_id_caus_magazzino) then	
		ids_testa.SetItem(ll_row,"documento_id_caus_magazzino",ll_id_caus_magazzino)
	end if	

	If not IsNull(ll_id_magazzino) then 
		ids_testa.SetItem(ll_row,"documento_id_magazzino",ll_id_magazzino)
	end if

	if not isNull(ll_id_magazzino_2) then
		ids_testa.SetItem(ll_row,"documento_id_magazzino_2",ll_id_magazzino_2)
	end if	

	if not IsNull(ll_id_sog_commerciale) then 
		ids_testa.SetItem(ll_row,"documento_id_sog_commerciale_fattura",ll_id_sog_commerciale)
	end if	

	if not isNull( ll_id_anagrafica ) then	
		select anagrafica.id_lingua
			into :ll_id_lingua
			from anagrafica
			where anagrafica.id_anagrafica = :ll_id_anagrafica
			using SQLCA;
		
		if SQLCA.SQLCode = 0 then
			ids_testa.SetItem(ll_row,"id_lingua",ll_id_lingua)
		else
			select prof_documento.id_lingua_prop
				into :ll_id_lingua
				from prof_documento
				where prof_documento.id_prof_documento = :ll_id_profilo
				using SQLCA;		
			if SQLCA.SQLCode = 0 then
				ids_testa.SetItem(ll_row,"id_lingua",ll_id_lingua)
			end if
		end if
	end if
	if not isNull(ll_id_linguaggio) then
		ids_testa.SetItem(ll_row,"documento_id_linguaggio",ll_id_linguaggio)
	else
		select prof_documento.id_linguaggio_prop
			into :ll_id_linguaggio
			from prof_documento
			where prof_documento.id_prof_documento = :ll_id_profilo
			using SQLCA;		
		if SQLCA.SQLCode = 0 then
			ids_testa.SetItem(ll_row,"documento_id_linguaggio",ll_id_linguaggio)
		end if
	end if

	if not isNull(ll_id_anagrafica) then	
		select anagrafica.id_valuta
			into :ll_id_valuta
			from anagrafica
			where anagrafica.id_anagrafica = :ll_id_anagrafica
			using SQLCA;
		
		if SQLCA.SQLCode = 0 then
			ids_testa.SetItem(ll_row,"documento_id_valuta_des",ll_id_valuta)
		else
			select prof_documento.id_valuta_prop
				into :ll_id_valuta
				from prof_documento
				where prof_documento.id_prof_documento = :ll_id_profilo
				using SQLCA;		
			if SQLCA.SQLCode = 0 then
				ids_testa.SetItem(ll_row,"documento_id_valuta_des",ll_id_valuta)
			else
				ll_id_valuta = il_az_idvalu
				ids_testa.SetItem(ll_row,"documento_id_valuta_des",ll_id_valuta)
			end if
		end if
	end if		
	select valuta.cambio,valuta.cifra_arrotondamento,valuta.tipo_arrotondamento
		into :idc_td_cambio,:il_cifra_arr,:is_tipo_arr
		from "dba".valuta
		where valuta.id_valuta = :ll_id_valuta
		using SQLCA;
		
	If SQLCA.SQLCode = 0 then 
		ids_testa.SetItem(ll_row,"documento_cambio",idc_td_cambio)
	end if	

	if not isNull(ll_id_listino) then
		ids_testa.SetItem(ll_row,"documento_id_listino",ll_id_listino)
	else
		select prof_documento.id_listino_prop
			into :ll_id_listino
			from prof_documento
			where prof_documento.id_prof_documento = :ll_id_profilo
			using SQLCA;		
		if SQLCA.SQLCode = 0 then
			ids_testa.SetItem(ll_row,"documento_id_listino",ll_id_listino)
		end if
	end if
	
	if not isNull(ll_id_con_pagamento) then
		ids_testa.SetItem(ll_row,"id_con_pagamento",ll_id_con_pagamento)
	else
		select prof_documento.id_con_pagamento_prop
			into :ll_id_con_pagamento
			from prof_documento
			where prof_documento.id_prof_documento = :ll_id_profilo
			using SQLCA;		
		if SQLCA.SQLCode = 0 then
			ids_testa.SetItem(ll_row,"id_con_pagamento",ll_id_con_pagamento)
		end if
	end if

	if not isNull(ll_id_gruppo_agenti) then
		ids_testa.SetItem(ll_row,"id_gruppo_agenti",ll_id_listino)
	end if

	if not isNull(ll_id_banca_sog_commerciale) then
		ids_testa.SetItem(ll_row,"id_banca_sog_commerciale",ll_id_banca_sog_commerciale)
	end if
	
	if not isNull(ll_giorni_consegna) then
		ids_testa.SetItem(ll_row,"data_prev_consegna",RelativeDate(ld_data_reg,ll_giorni_consegna) )
	end if
	
	if	not isNull(ls_note_intestazione) then
		ids_testa.SetItem(ll_row,"documento_note_intestazione",ls_note_intestazione)
	end if	
	
	if not isNull(ll_id_tipo_trasporto) then
		ids_testa.SetItem(ll_row,"id_tipo_trasporto",ll_id_tipo_trasporto)
	end if
	
	if not isNull(ls_asp_beni) then
		ids_testa.SetItem(ll_row,"documento_asp_beni",ls_asp_beni)
	end if	
		
	if not isNull(ls_tras_mezzo) then
		ids_testa.SetItem(ll_row,"documento_tras_mezzo",ls_tras_mezzo)
	end if

			
	if not isNull(ll_id_vettore_1) then
		ids_testa.SetItem(ll_row,"documento_id_sog_commerciale_vettore",ll_id_vettore_1)
	else
		select sog_commerciale.id_sog_com_vettore
			into :ll_id_vettore_1
			from sog_commerciale
			where sog_commerciale.id_sog_commerciale = :ll_id_sog_commerciale
			using SQLCA;		
		if SQLCA.SQLCode = 0 then
			ids_testa.SetItem(ll_row,"documento_id_sog_commerciale_vettore",ll_id_vettore_1)
		end if
	end if

	ids_testa.SetItem(ll_row,"documento_stampato","N")
	ids_testa.SetItem(ll_row,"documento_contabilizzato","N")
	ids_testa.SetItem(ll_row,"documento_evaso_totalmente","N")
	ids_testa.SetItem(ll_row,"documento_chius_forzata","N")
	ids_testa.SetItem(ll_row,"documento_sospeso","N")
	ids_testa.SetItem(ll_row,"creato_in_esenzione","N")
	ids_testa.SetItem(ll_row,"bloccato","N")
	
	
	if not isNull(ls_tipo_fattura) then
		ids_testa.SetItem(ll_row,"tipo_fattura",ls_tipo_fattura)
		choose case ls_tipo_fattura
			case "N","D"
				ids_testa.SetItem( ll_row,"segno_iva",1 )
			case "C"
				ids_testa.SetItem( ll_row,"segno_iva",-1 )
		end choose		
	end if	

	ids_testa.SetItem(ll_row,"documento_id_azienda",1)
	ids_testa.SetItem(ll_row,"documento_num_colli",0)
	ids_testa.SetItem(ll_row,"sconto_fin_incondizionato",0)
	ids_testa.SetItem(ll_row,"documento_imp_acconto",0)
	
	
	if not isNull(is_td_descon) then
		ids_riga.object.testa_descon_t.text 	= is_td_descon
	end if
	if not isNull(id_ch_reg) then
		ids_riga.object.testa_data_reg_t.text 	= string(id_ch_reg,"dd/mm/yyyy")
	end if
	if not isNull(ls_dval) then
		ids_riga.object.testa_valuta_t.text 	= ls_dval
	end if
	if not isNull(idc_td_cambio) then
		ids_riga.object.testa_cambio_t.text 	= string(idc_td_cambio)
	end if	
	
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
	ids_riga.object.testa_anag_t.text = ls_ttot
	
	ls_1 = ""
	ls_2 = ""
	select	"con_pagamento"."codice",	"con_pagamento"."descrizione"  
		into	:ls_1,	:ls_2  
		from	"dba"."con_pagamento"  
		where "con_pagamento"."id_con_pagamento" = :ll_id_con_pagamento;
	
	if isNull (ls_1) then ls_1 = ""
	if isNull (ls_2) then ls_2 = ""
	ls_ttot = ls_1+" "+ls_2
	ids_riga.object.testa_cpag_t.text = ls_ttot

	ls_1 = ""
	ls_2 = ""
	ls_3 = ""
	ls_4 = ""
	select	"banca_sog_commerciale_gen"."cod_abi", "banca_sog_commerciale_gen"."cod_cab",
				"banca_sog_commerciale_gen"."den_abi", "banca_sog_commerciale_gen"."den_cab"
		into	:ls_1, :ls_2, :ls_3, :ls_4  
		from 	"banca_sog_commerciale_gen"
		where	"banca_sog_commerciale_gen"."id_banca_sog_commerciale" = :ll_id_banca_sog_commerciale
		using	sqlca;
		
	if isNull (ls_1) then ls_1 = ""
	if isNull (ls_2) then ls_2 = ""
	if isNull (ls_3) then ls_3 = ""
	if isNull (ls_4) then ls_4 = ""
	ls_ttot = ls_1+" "+ls_2+" - "+ls_3+", "+ls_4
	ids_riga.object.testa_bapp_t.text = ls_ttot
	
	ls_1 = ""
	ls_2 = ""
	select	"tipo_trasporto"."codice",	"tipo_trasporto"."descrizione"  
		into	:ls_1, :ls_2
		from	"dba"."tipo_trasporto"
		where	"tipo_trasporto"."id_tipo_trasporto" = :ll_id_tipo_trasporto
		using	sqlca;
		
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
decimal		ld_tot_val_om3

long			ll_numrighe,ll_count
long			ll_idtabiva,ll_row_testa

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
		
		ld_totaleriga = ids_riga.GetItemDecimal(ll_count, "tot_riga_val_doc")
		ld_prezzounit = ids_riga.GetItemDecimal(ll_count, "prezzo")
		ld_quantita   = ids_riga.GetItemDecimal(ll_count, "quantita")
		ld_scontomerc = ids_riga.GetItemDecimal(ll_count, "qta_sconto_merce")
		ls_sconto     = ids_riga.GetItemString(ll_count, "sconto")
		
		if isNull (ld_totaleriga) then ld_totaleriga = 0
		if isNull (ld_prezzounit) then ld_prezzounit = 0
		if isNull (ld_quantita)   then ld_quantita 	= 0
		if isNull (ld_scontomerc) then ld_scontomerc = 0
		if isNull (ls_sconto)     then ls_sconto 		= ""
		
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
			
			ld_imposta			= Ceiling((ld_prezzounit * ld_quantita * ld_aliquota) / 100)
			ld_val_omaggi_sm 	= (ld_quantita * ld_prezzounit)
			ld_tot_val_omaggi = ld_tot_val_omaggi + ld_val_omaggi_sm
			
			wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, ld_imposta, ld_val_omaggi_sm, ids_iva)
		else
			
			if ld_quantita <> 0 then
				
				ld_imponibile = ld_totaleriga
				ld_imposta = Ceiling(ld_aliquota * ld_totaleriga / 100)

				wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, ld_imponibile, ld_imposta, 0, ids_iva)

				if ld_scontomerc <> 0 then
					ld_val_omaggi_sm = (ld_scontomerc * (ld_totaleriga / ld_quantita) )
					ld_tot_val_sma15 = ld_tot_val_sma15 + ld_val_omaggi_sm
					
					wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, 0, ld_val_omaggi_sm, ids_iva)
				end if
			else
				
				if ld_scontomerc <> 0 then
					ld_imposta = Ceiling (ld_scontomerc * ld_prezzounit * (ld_aliquota / 100))

					wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, ld_imposta, 0, ids_iva)
					if ll_idtabiva = il_az_idivaart15 then
						ld_val_omaggi_sm = (ld_scontomerc * ld_prezzounit)
						ld_tot_val_sma15 = ld_tot_val_sma15 + ld_val_omaggi_sm
						wf_insert_riga_iva (ll_idtabiva, ld_aliquota, ld_perdetraz, 0, 0, ld_val_omaggi_sm, ids_iva)
					else
						ld_val_omaggi_sm = (ld_scontomerc * ld_prezzounit) 
						ld_tot_val_smiva = ld_tot_val_smiva + ld_val_omaggi_sm
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

ll_row_testa	= ids_testa.GetRow()
ids_testa.SetItem(ll_row_testa, "c_val_omaggi", ld_tot_val_omaggi)
ids_testa.SetItem(ll_row_testa, "c_val_sc_merce_art_15", ld_tot_val_sma15)
ids_testa.SetItem(ll_row_testa, "c_val_sc_merce_iva", ld_tot_val_smiva)

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
long			ll_nrowsiva, ll_countiva,ll_row_testa
string		ls_scfinanz
decimal		ld_scfininc, ld_scfincas, ld_imponibile, ld_temp
decimal		ld_impriman, ld_percincond

ll_row_testa	= ids_testa.GetRow()
ls_scfinanz 	= ids_testa.GetItemString(ll_row_testa,"documento_sconto_finanziario")
ld_scfininc 	= ids_testa.GetItemDecimal(ll_row_testa,"sconto_fin_incondizionato")
ld_scfincas 	= ids_testa.GetItemDecimal(ll_row_testa,"documento_sconto_fin_cassa")

ll_nrowsiva = ids_iva.rowCount()
for ll_countiva = 1 to ll_nrowsiva
	ld_temp = Round(ids_iva.GetItemNumber(ll_countiva, "c_proporzionale"), 2)
	ids_iva.SetItem(ll_countiva, "c_prop_imp", ld_temp)
next

If not (IsNull(ls_scfinanz) OR ls_scfinanz = "") then
	for ll_countiva = 1 to ll_nrowsiva
		ld_imponibile= ids_iva.GetItemDecimal (ll_countiva, "val_imponibile")
		
		ld_imponibile= wf_calc_prezzo_riga (ls_scfinanz, ld_imponibile, 0)
		
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

			ld_percincond = wf_Round (ld_temp, il_cifra_arr, is_tipo_arr)
			
			ld_imponibile= ld_imponibile - ld_percincond
			ld_impriman= ld_impriman + ld_percincond
			ids_iva.SetItem(ll_countiva, "val_imp_scontato", ld_imponibile)
		next
		ld_imponibile= ids_iva.GetItemDecimal(ll_nrowsiva, "val_imp_scontato")
		ld_imponibile= ld_imponibile - ld_scfininc + ld_impriman
		ids_iva.SetItem(ll_nrowsiva, "val_imp_scontato", ld_imponibile)
	end if
end if

If not (IsNull(ld_scfincas) OR ld_scfincas = 0) then
	for ll_countiva = 1 to ll_nrowsiva
		ld_imponibile = ids_iva.GetItemDecimal(ll_countiva, "val_imp_scontato")
		ld_imponibile = ld_imponibile - (ld_imponibile * ld_scfincas / 100)
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
				
				if isNull(ldc_importo) then ldc_importo = 0
				ids_spese.SetItem(ll_count, "importo", ldc_importo)
			end if	
		end if
		if not (IsNull(ldc_importo) OR ldc_importo = 0) then 
			if ll_id_tab_iva_max>0 then
				
				ll_id_tab_iva= ll_id_tab_iva_max
				ids_spese.SetItem(ll_count, "id_tab_iva", ll_id_tab_iva)
				
				
				
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
			WHERE "spesa"."id_spesa" = :ll_id_spesa;
		CHOOSE CASE ls_codice
			CASE "C"
				ldc_importo= ids_spese.GetItemDecimal(ll_count, "importo")
				if not ((IsNull(ldc_importo) OR ldc_importo = 0)) then
					
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
						if not IsNull(ldc_importo) then ids_iva.SetItem(ll_row_found,"val_spese", ldc_imponibile + ldc_importo)
					end if
				end if
			CASE ELSE
				
				ldc_importo= ids_spese.GetItemDecimal(ll_count, "importo")
				
				if (IsNull(ldc_importo) OR ldc_importo = 0) then 
					if ids_riga.RowCount() > 0 then
						ldc_tot_righe= ids_riga.GetItemDecimal(1, "c_tot_righe")
						ldc_importo=ldc_tot_righe * ids_spese.GetItemDecimal(ll_count, "percentuale") / 100
						
						if isNull( ldc_importo ) then ldc_importo = 0
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	If ld_bollo > 0 then
		
		
		ll_bollo_row = ids_spese.Find("id_spesa = " + String(il_az_idspesabol),1,ids_spese.RowCount())
		if not (IsNull(ll_bollo_row) OR ll_bollo_row=0) then 
			ld_importo = ids_spese.GetItemDecimal(ll_bollo_row, "importo")
			If IsNull(ld_importo) then ld_importo =0
			ids_spese.SetItem(ll_bollo_row, "importo", ld_bollo + ld_importo)

		else
			ll_bollo_row=ids_spese.InsertRow(0)
			ids_spese.SetItem(ll_bollo_row, "id_spesa", il_az_idspesabol)
			
			
			
			
			ids_spese.SetItem(ll_bollo_row, "id_tab_iva", il_az_idivaart15)
			ids_spese.SetItem(ll_bollo_row, "importo", ld_bollo)
		end if
	end if
end if


return ld_bollo


end function

public subroutine wf_setta_incasso ();


long			ll_id_spesa_inc, ll_nrate, ll_row, ll_tabiva_sp
long			ll_rt_ocpag,ll_row_testa
decimal		ld_importo

ld_importo = 0

if pos(is_ch_spgest,'C') >0 then
	
	ll_id_spesa_inc = 0
	SELECT	"spesa"."id_spesa", "spesa"."id_tab_iva"
		INTO	:ll_id_spesa_inc, :ll_tabiva_sp
		FROM	"dba"."spesa"  
		WHERE	"spesa"."codice" = 'C';
	
	if (not isNull(ll_id_spesa_inc)) and (ll_id_spesa_inc > 0 ) then
		SELECT	"spesa_sog_commerciale"."importo"
			INTO	:ld_importo
			FROM	"spesa_sog_commerciale"  
			WHERE	("spesa_sog_commerciale"."id_sog_commerciale" = :il_ch_idsc ) AND  
					("spesa_sog_commerciale"."id_spesa" = :ll_id_spesa_inc );
		if sqlca.sqlcode<>0 then
			ld_importo = 0
		end if
	end if
		
	
	
	
	if ld_importo <> 0 then
		ll_row_testa	= ids_testa.GetRow()
		ll_rt_ocpag		= ids_testa.GetItemNumber( ll_row_testa,"id_con_pagamento" )
		ll_nrate 		= iuo_pag.uf_rate_ges_spesa(ll_rt_ocpag, "C")
		
		ld_importo = ld_importo * ll_nrate / idc_td_cambio
		if isNull(ld_importo ) then ld_importo = 0
		
		ll_row = ids_spese.Find( "id_spesa = " + string(ll_id_spesa_inc),1,ids_spese.RowCount() )	
		
		if ll_row = 0 then
			ll_row = ids_spese.InsertRow(0)
		end if	

		if ll_row > 0 then
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
		
		ll_bollo_row = ids_spese.Find("id_spesa = " + String(il_az_idspesabol),1,ids_spese.RowCount())
		if not (IsNull(ll_bollo_row) OR ll_bollo_row=0) then 
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
		if not IsNull(ld_importo) OR ld_importo=0 then
			
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
long		ll_id_spesa
string	ls_codice
decimal 	ldc_valore

ll_nr_row= ids_spese.RowCount()
for ll_count =  ll_nr_row to 1 step -1
	ldc_valore	= ids_spese.GetItemNumber(ll_count, "importo")
	ll_id_spesa	= ids_spese.GetItemNumber(ll_count, "id_spesa")
	
	select spesa.codice
		into :ls_codice
		from spesa
		where spesa.id_spesa = :ll_id_spesa
		using SQLCA;
	
	if ls_codice <> "B" then
		if (IsNull(ldc_valore) Or ldc_valore=0) then
			ids_spese.DeleteRow(ll_count)
		end if	
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
		ldc_tot_iva_val_calc		= ids_iva.GetItemDecimal(ll_count,"c_iva_val")
		ldc_tot_imp_val_calc		= ids_iva.GetItemDecimal(ll_count,"c_imponibile_spesa")
		ldc_tot_iva_lire_calc	= ids_iva.GetItemDecimal(ll_count,"c_iva_lire")
		ldc_tot_imp_lire_calc	= ids_iva.GetItemDecimal(ll_count,"c_imponibile_spesa_lire")
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
long			ll_id_banca_sc, ll_id_banca_azienda,ll_id_con_pagamento
long			ll_row_testa,ll_id_valuta
boolean		lb_scadragg
decimal		ld_impon, ld_impos, ld_tot_imp_val
date			ldt_iniz
s_scadenze	lstr_scadenze


long			ll_nrowsiva, ll_size, ll_i, ll_row
boolean		lb_ok
decimal		ld_temp, ld_impparzv, ld_implire, ld_impval, ld_bollotot


ld_bollotot=0
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
	WHERE "sog_commerciale"."id_sog_commerciale" = :il_ch_idsc;

SELECT "azienda"."id_banca_azienda"  
	INTO :ll_id_banca_azienda  
	FROM "dba"."azienda"  
	WHERE "azienda"."id_azienda" = :il_az_idaz;

ll_nrowsiva= ids_iva.RowCount()
If ll_nrowsiva > 0 then
	
	ld_impon = ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_imponibile_spesa_lire")
	ld_impos = ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_iva_lire")
	ll_row_testa			= ids_testa.GetRow()
	ll_id_con_pagamento	= ids_testa.GetItemNumber(ll_row_testa,"id_con_pagamento")
	ll_id_valuta			= ids_testa.GetItemNumber(ll_row_testa,"documento_id_valuta_des")

	ld_tot_imp_val = ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_imponibile_spesa") + &
							ids_iva.GetItemDecimal(ll_nrowsiva,"c_tot_iva_val")

	ldt_iniz = ids_testa.GetItemDate(ll_row_testa,"documento_data_dec_pagamento")
	if isNull(ldt_iniz) or ldt_iniz = date("01/01/1900") then ldt_iniz = today()
	
	
	
	lb_ok = iuo_pag.uf_calcola_pagamenti_e(ll_id_valuta,ld_impon,ld_impos,ldt_iniz,il_ch_idsc,ll_id_con_pagamento,lstr_scadenze)	
	
	
	ids_scad.reset()
	ll_size = UpperBound(lstr_scadenze.dc_imp_out)
	
	if not (IsNull(ll_size) OR ll_size<=0) then
		ld_impparzv = 0
		
		
		
		for ll_i = 1 to ll_size - 1
			ll_row = ids_scad.insertRow(0)
			if ll_row>0 then
				ids_scad.SetItem(ll_row, "id_sog_commerciale", il_ch_idsc)
				ids_scad.SetItem(ll_row,"data_scadenza",lstr_scadenze.d_date[ll_i])
				ids_scad.SetItem(ll_row, "id_valuta", ll_id_valuta)
				ids_scad.SetItem(ll_row, "cambio", idc_td_cambio)
				
				ld_temp = (lstr_scadenze.dc_iva_out[ll_i] + lstr_scadenze.dc_imp_out[ll_i]) / idc_td_cambio
				ld_impval= wf_Round(ld_temp, il_cifra_arr, is_tipo_arr)
				ld_impparzv = ld_impparzv + ld_impval
				ld_implire = lstr_scadenze.dc_iva_out[ll_i] + lstr_scadenze.dc_imp_out[ll_i] + lstr_scadenze.dc_bollo[ll_i]

				ids_scad.SetItem(ll_row,"imp_valuta", ld_impval + (lstr_scadenze.dc_bollo[ll_i] / idc_td_cambio))
				if isNull(ld_implire) then ld_implire = 0 
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
			ids_scad.SetItem(ll_row, "id_sog_commerciale", il_ch_idsc)
			ids_scad.SetItem(ll_row,"data_scadenza",lstr_scadenze.d_date[ll_size])
			ids_scad.SetItem(ll_row, "id_valuta", ll_id_valuta)
			ids_scad.SetItem(ll_row, "cambio", idc_td_cambio)
			ld_implire= ((ld_tot_imp_val  - ld_impparzv) * idc_td_cambio) + lstr_scadenze.dc_bollo[ll_size]
			ids_scad.SetItem(ll_row,"imp_valuta", ld_implire / idc_td_cambio)

			if isNull(ld_implire) then ld_implire = 0 
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

	
end if

ids_cpt.SetSort("tipo_riga_cpt A")
ids_cpt.Sort()

return lb_ok

end function

public function integer wf_calc_cpt_righe ();

long		ll_nrows, ll_count, ll_idcpt, ll_idtabiva, ll_create
decimal	ld_totriga, ld_qta, ld_qtasm, ld_preuni, ld_prenet, ld_temp
string	ls_rigavalida, ls_sconto

ll_create = 0
ll_nrows = ids_riga.RowCount()
for ll_count = 1 to ll_nrows
	
	ld_totriga = ids_riga.GetItemDecimal(ll_count, "tot_riga_val_az")
	if IsNull(ld_totriga)  then ld_totriga = 0
	ld_qta = ids_riga.GetItemDecimal(ll_count, "quantita")
	if IsNull(ld_qta)  then ld_qta = 0
	ld_qtasm = ids_riga.GetItemDecimal(ll_count, "qta_sconto_merce")
	if IsNull(ld_qtasm)  then ld_qtasm = 0
	ld_preuni = ids_riga.GetItemDecimal(ll_count, "prezzo")
	if IsNull(ld_preuni)  then ld_preuni = 0
	ls_sconto = ids_riga.GetItemString(ll_count, "sconto")
	if IsNull(ls_sconto)  then ls_sconto = ""
	
	ll_idtabiva= ids_riga.GetItemNumber(ll_count, "id_tab_iva")
	ll_idcpt = ids_riga.GetItemNumber(ll_count, "id_conto")
	If IsNull(ll_idcpt) OR ll_idcpt = 0 then ll_idcpt = il_az_idcontoprd
	
	ls_rigavalida 	= ids_riga.GetItemString(ll_count, "c_riga_valida")
	ld_prenet 		= wf_calc_prezzo_riga (ls_sconto, 1000000, 1)
	
	If (ls_rigavalida="V") then
		
		if ld_prenet = 0 then
			
			ld_temp = (ld_qta * ld_preuni)
			wf_insert_riga_cpt (ll_idcpt, "C", ids_cpt, 0, 0, ld_temp, 0)
		else
			
			ld_temp = (ld_qtasm * ld_preuni)
			wf_insert_riga_cpt (ll_idcpt, "C", ids_cpt, ld_totriga, 0, ld_temp, 0)
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

ls_scfinanz = ids_testa.GetItemString(il_rowtesta,"documento_sconto_finanziario")
ld_scfininc = ids_testa.GetItemDecimal(il_rowtesta,"sconto_fin_incondizionato")
ld_scfincas = ids_testa.GetItemDecimal(il_rowtesta,"documento_sconto_fin_cassa")

ll_nrows = ids_cpt.rowcount()
for ll_count = 1 to ll_nrows
	ld_temp = Round(ids_cpt.GetItemNumber(ll_count, "c_proporzionale"), 2)
	ids_cpt.SetItem(ll_count, "c_prop_imp", ld_temp)
next

for ll_count = 1 to ll_nrows
	ld_temp = ids_cpt.GetItemDecimal(ll_count, "val_imponibile")
	If not (IsNull(ls_scfinanz) OR ls_scfinanz = "") then
		ld_temp = wf_calc_prezzo_riga(ls_scfinanz, ld_temp, 0)
	end if
	ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_temp)
next

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
		ids_cpt.SetItem(ll_count, "val_imp_scontato", ld_impon)
	next
end if


end subroutine

public subroutine wf_calc_cpt_spese ();
long		ll_count, ll_nrows
long		ll_idspesa, ll_idconto
string	ls_tipo_registro
decimal	ld_importo

ll_nrows = ids_spese.rowcount()
for ll_count = 1 to ll_nrows
	
	ll_idspesa = ids_spese.GetItemNumber(ll_count, "id_spesa")

	choose case is_td_tiporeg
		
		CASE "IA", "PA", "OA", "DA", "LA", "GA"			
			SELECT	"conto_azienda"."id_conto"
				INTO	:ll_idconto
				FROM	"dba"."conto_azienda", "dba"."spesa"  
				WHERE ("spesa"."id_conto_acquisti" = "conto_azienda"."id_conto" ) and  
						("spesa"."id_spesa" = :ll_idspesa) and
						("conto_azienda"."id_azienda" = :il_az_idaz);

		
		CASE "IV", "PV", "OV", "DV", "LV", "GV"
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
		
		ld_importo = ids_spese.GetItemDecimal(ll_count, "cc_importo_buffer")
		wf_insert_riga_cpt (ll_idconto, "C", ids_cpt, 0 , 0, 0, ld_importo)
	end if
next



end subroutine

public function integer wf_calc_cpt_totali ();
long		ll_scode, ll_iddetr, ll_idnond, ll_castrow
long		ll_row_testa
decimal	ld_totdetr, ld_totnond
decimal	ld_valomsc, ld_totdocu


ll_row_testa	= ids_testa.getRow()

ld_valomsc = ids_testa.GetItemDecimal (ll_row_testa, "c_val_omaggi")
ld_valomsc = ld_valomsc + ids_testa.GetItemDecimal (ll_row_testa, "c_val_sc_merce_art_15")
ld_valomsc = ld_valomsc + ids_testa.GetItemDecimal (ll_row_testa, "c_val_sc_merce_iva")
ld_valomsc = ld_valomsc * idc_td_cambio
ld_valomsc = truncate (ld_valomsc,0)

ld_totdocu = ids_iva.GetItemDecimal(1, "c_tot_val_tot_imp_l")
ld_totdocu = ld_totdocu + ids_iva.GetItemDecimal(1, "c_tot_val_tot_iva_l")
wf_insert_riga_cpt (il_sc_idconto, "S", ids_cpt, 0, ld_totdocu, ld_valomsc, 0)


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
long		ll_nrows,	ll_count,	ll_row_testa
long		ll_idspesa,	ll_idiva
string	ls_spdesc,	ls_spimpo,	ls_desc1,	ls_desc2,	ls_impo1,	ls_impo2
string	ls_codiva,	ls_aliquo,	ls_ivimp,	ls_iviva
string	ls_temp
decimal	ld_importo,	ld_impiva,	ld_nettom,	ld_totdoc
integer	li_switch

ll_nrows = ids_spese.rowcount()
if ll_nrows>10 then ll_nrows = 10
li_switch = 1
ls_desc1 = ""
ls_desc2 = ""
ls_impo1 = ""
ls_impo2 = ""
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
			USING SQLCA;
	
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


ll_row_testa = ids_testa.GetRow()

ld_importo = ids_testa.GetItemDecimal(ll_row_testa,"sconto_fin_incondizionato")
ids_riga.object.piede_scinc_t.text = string (ld_importo,"#,##0.00")


if ids_iva.RowCount() > 0 then
	ld_nettom = ids_iva.GetItemDecimal(1,"c_tot_imp_scontato")
	ld_importo = ids_iva.GetItemDecimal(1, "c_tot_val_tot_imp_v")
	ld_impiva = ids_iva.GetItemDecimal(1, "c_tot_val_tot_iva_v")
end if

ld_totdoc = ld_importo + ld_impiva

ids_riga.object.piede_tot_merce_t.text     = string (ld_nettom,"#,##0.00")
ids_riga.object.piede_tot_impo_t.text      = string (ld_importo,"#,##0.00")
ids_riga.object.piede_tot_iva_t.text       = string (ld_impiva,"#,##0.00")
ids_riga.object.piede_tot_documento_t.text = string (ld_totdoc,"#,##0.00")


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


ls_temp = idw_testr.describe("linea2.y1")

return 0

end function

public function long wf_calc_piede_doc (long al_row, boolean ab_definitiva);
boolean		lb_Ok, lb_Tot_Ok
long			ll_ret
decimal		ld_bollo
string		ls_testata

ll_ret = 0

if isNull (il_az_idspesabol) or (il_az_idspesabol = 0) then
	close (iw_wait)							
	return -1
end if
if isNull (il_az_idcontoprd) or (il_az_idcontoprd = 0) then
	close (iw_wait)							
	return -1
end if
if isNull (il_az_idivaart15) or (il_az_idivaart15 = 0) then
	close (iw_wait)							
	return -1
end if

ids_testa.SetItem (il_rowtesta, "c_val_sc_merce_art_15", 0)
ids_testa.SetItem (il_rowtesta, "c_val_sc_merce_iva", 0)
ids_testa.SetItem (il_rowtesta, "c_val_omaggi", 0)

ids_iva.Reset()

ids_iva.Modify("c_cambio_text.text='" + String(idc_td_cambio) + "'")
idw_spese.Modify("c_cambio_text.text = '" + String(idc_td_cambio) + "'")

wf_calc_spese()										
wf_setta_incasso()									
wf_calc_righe_cast()									
wf_calc_sconti_cast()								
wf_calc_sp_noiva_cast()								
wf_calc_sp_iva_cast()								

wf_calc_bollo_cast()									
ld_bollo = wf_genera_scadenze()

wf_calc_sp_bollo_cast()								
wf_del_spese_nulle()									
wf_setup_cast_iva(0)									
wf_calc_cpt()

wf_calc_finali()										

close (iw_wait)							
							
lb_Tot_Ok=TRUE
If ab_definitiva then
	lb_Ok = wf_Salva_Documento()
	If not lb_Ok then 
		lb_Tot_Ok=FALSE
	end if
else
	ids_riga.print()
end if
If not lb_Tot_Ok then MessageBox("Derivazione Batch", "La derivazione di uno o più Documenti~r" &
			+ "derivati non ha avuto successo", StopSign!)
imle_rep.text += "~r~n wf_calc_piede_doc, le righe documento erano "+string(ids_riga.rowcount())

return 0


end function

public function boolean wf_salva_documento ();
long		ll_Id_Documento, ll_Row, ll_Size, ll_Update
string	ls_message
long 		ll_id_registro, ll_ultimo_num_reg, ll_num_suggerito_min, ll_num_suggerito_Max
date		ld_ultima_data_reg, ld_data_prec, ld_data_succ, ld_Data
date		ld_data_reg
boolean	lb_Ok

lb_Ok = TRUE

ll_id_registro = ids_testa.GetItemNumber(ids_testa.GetRow(),"id_registro")
IF NOT (IsNull(ll_id_registro) OR ll_id_registro = 0) THEN
	SetNull(ld_Data)
	SQLCA.sp_Ges_NumProg_DataReg( 0, ll_id_registro, ll_ultimo_num_reg, ld_Data,ls_message, &
		ll_num_suggerito_min, ll_num_suggerito_max, ld_data_prec, ld_data_succ, ll_id_documento);	
	IF IsNull(ll_ultimo_num_reg) THEN ll_ultimo_num_reg = 0
	ld_data_reg	= ids_testa.GetItemDate( ids_testa.GetRow(), "data_registrazione" )
	ids_testa.SetItem( ids_testa.GetRow(), "num_progressivo", ll_ultimo_num_reg)
	ids_testa.SetItem( ids_testa.GetRow(), "num_documento", string(ll_ultimo_num_reg))
end if

ll_Update	= ids_testa.Update()

If ll_Update < 0 then 
	lb_Ok = FALSE
	return false
end if


If ll_Update =1 then
	
	ll_Row = ids_testa.GetRow()
	If not(IsNull(ll_Row) OR ll_Row=0) then 
		
		ll_Id_Documento=ids_testa.GetItemNumber(ll_Row, "id_documento")
		
		
		ll_Size = ids_riga.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_riga.SetItem(ll_Row, "id_documento", ll_Id_Documento)
		NEXT
		
		ll_Update	= ids_riga.Update()
		If ll_Update < 0 then lb_Ok = FALSE

		ll_Size = ids_spese.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_spese.SetItem(ll_Row, "id_documento", ll_Id_Documento)			
		NEXT
		
		ll_Update	= ids_spese.Update()
		If ll_Update < 0 then lb_Ok = FALSE
		
		ll_Size = ids_iva.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_iva.SetItem(ll_Row, "id_documento", ll_Id_Documento)
		NEXT
		
		ll_Update	= ids_iva.Update()
		If ll_Update < 0 then lb_Ok = FALSE

		ll_Size = ids_scad.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_scad.SetItem(ll_Row, "id_documento", ll_Id_Documento)
		NEXT
		
		ll_Update	= ids_scad.Update()
		If ll_Update < 0 then lb_Ok = FALSE

		ll_Size = ids_cpt.RowCount()
		FOR ll_Row= 1 to ll_Size
			ids_cpt.SetItem(ll_Row, "id_documento", ll_Id_Documento)
		NEXT
		
		ll_Update	= ids_cpt.Update()
		If ll_Update < 0 then lb_Ok = FALSE

	end if
end if
If lb_Ok then 
	COMMIT USING SQLCA;
	MessageBox( "Informazione","E' stato generato un documento con i seguenti dati : " + "~r" + &
										" progressivo : " + string(ll_ultimo_num_reg) + "~r" + &
										" in data        : " + string(ld_data_reg),Information! )
	wf_delete_rows_fabbisogno()									
else
	
	
	
	ROLLBACK USING SQLCA;
end if

RETURN lb_Ok

end function

public function integer wf_raccogli_sogg_commerciali ();
long			ll_row,ll_row_count
long			ll_row_sc,ll_ricerca
long			ll_id_sog_commerciale,ll_i
string		ls_find
string		ls_codice, ls_ragione, ls_indirizzo, ls_cap, ls_localita, ls_provincia, ls_scmft

ll_row_sc		= 0
ll_ricerca		= 0
ll_row_count	= tab_1.tabpage_1.dw_select_riordini_lt.RowCount()
if ll_row_count > 0 then
	ids_sc.reset() 
	tab_1.tabpage_1.dw_select_riordini_lt.ScrollToRow(1)
	
	for ll_i = 1 to ll_row_count 
		
		ll_id_sog_commerciale	= tab_1.tabpage_1.dw_select_riordini_lt.GetItemNumber( ll_i,"fabbisogno_id_sog_commerciale" )
		
		if not isNull( ll_id_sog_commerciale ) then
			if ll_row_sc > 0 then
				ls_find 		= "idsc = "+string(ll_id_sog_commerciale)
				ll_ricerca 	= ids_sc.find(ls_find,1,ll_row_sc)
			else 	
				ll_ricerca  = 0
			end if	

			if ll_ricerca = 0 then
				ll_row	= ids_sc.insertRow(0)	

				ids_sc.SetItem(ll_row,"idsc",ll_id_sog_commerciale)
				
				SELECT	"sog_commerciale_gen"."codice",			"sog_commerciale_gen"."rag_soc_1",
							"sog_commerciale_gen"."indirizzo",		"sog_commerciale_gen"."cap",   
							"sog_commerciale_gen"."localita",		"sog_commerciale_gen"."provincia",
							"sog_commerciale"."modo_fatturazione"
				INTO		:ls_codice,:ls_ragione,:ls_indirizzo,:ls_cap,
							:ls_localita,:ls_provincia,:ls_scmft

				FROM		"dba"."sog_commerciale",	"dba"."sog_commerciale_gen"

				WHERE		("sog_commerciale"."id_sog_commerciale" = "sog_commerciale_gen"."id_sog_commerciale")
							and ("sog_commerciale"."id_sog_commerciale" = :ll_id_sog_commerciale) ;

				if sqlca.sqlcode=0 then
					ids_sc.SetItem(ll_row, "codice", ls_codice)
					ids_sc.SetItem(ll_row, "ragsoc", ls_ragione)
					ids_sc.SetItem(ll_row, "indir", ls_indirizzo)
					ids_sc.SetItem(ll_row, "cap", ls_cap)
					ids_sc.SetItem(ll_row, "loc", ls_localita)
					ids_sc.SetItem(ll_row, "prov", ls_provincia)
					ids_sc.SetItem(ll_row, "mfatt", ls_scmft)
				end if				
				ll_row_sc++
			end if	
			
		end if		
		
	next
	
end if

return 0


end function

public function long wf_get_righe (long al_id_sogg_commerciale);
long			ll_row,ll_i,ll_row_count
long			ll_id_sog_commerciale
long			ll_id_articolo,ll_id_unita_conf
long			ll_num_rows
decimal		ldc_riordino
string		ls_selected

ll_num_rows		= 0
ids_righe_sog_comm.reset()

ll_row_count	= tab_1.tabpage_1.dw_select_riordini_lt.RowCount()
for ll_i = 1 to ll_row_count 
	ll_id_sog_commerciale	= tab_1.tabpage_1.dw_select_riordini_lt.GetItemNumber( ll_i,"fabbisogno_id_sog_commerciale" )
	if not isNull( ll_id_sog_commerciale ) then
		if ll_id_sog_commerciale = al_id_sogg_commerciale then
			ls_selected	= tab_1.tabpage_1.dw_select_riordini_lt.GetItemString( ll_i,"cc_selezionato" )
			if ls_selected = "S" then
				
				ll_id_articolo		= tab_1.tabpage_1.dw_select_riordini_lt.GetItemNumber( ll_i,"fabbisogno_id_articolo" )
				ll_id_unita_conf	= tab_1.tabpage_1.dw_select_riordini_lt.GetItemNumber( ll_i,"fabbisogno_id_unita_confezione" )
				ldc_riordino		= tab_1.tabpage_1.dw_select_riordini_lt.GetItemDecimal( ll_i,"fabbisogno_qta_riordino" ) 
				 
				
				
				ll_row	= ids_righe_sog_comm.InsertRow(0)
				ids_righe_sog_comm.SetItem( ll_row,"id_articolo",ll_id_articolo )
				ids_righe_sog_comm.SetItem( ll_row,"id_unita_confezione",ll_id_unita_conf )
				ids_righe_sog_comm.SetItem( ll_row,"riordino",ldc_riordino )
				ll_num_rows++
			end if
		end if
	end if	
next


return ll_num_rows

end function

public function integer wf_set_riga_arr (long al_r1, long al_id_sogg_commerciale);
long		ll_idr1, ll_rr2, ll_idcauder, ll_Id_Sog_Comm, ll_Id_tab_Iva, ll_Id_Prof_Doc, ll_num_riga
long		ll_idgrag,  ll_idarti,  ll_iddesa,  ll_idloc1,  ll_idloc2
long		ll_idvalu,  ll_idlist,  ll_idcoli,  ll_idctra,  ll_idaz,    ll_oldiva
long		ll_idcpt,   ll_arrot,	ll_idrigaprov
string	ls_Att_Esenzione, ls_Prec_Esenzione, ls_contr_esen_der
string	ls_descr,   ls_scon
string	ls_codart,  ls_catcom,  ls_catmer,  ls_codiva,  ls_codcpt
string	ls_tipoarr,	ls_tipoconv
integer	li_ret
decimal	ld_qta,     ld_qtasm,   ld_fcon,    ld_oldchg,  ld_prez,    ld_prnt
decimal	ld_scri,    ld_pnet,    ld_plor,    ld_diml,    ld_dimh,    ld_dimp
decimal  ld_ncoll,   ld_prov1,   ld_valatt,  ld_prov2,   ld_prov3
decimal	ld_fatconv,	ld_molt,		ld_fatglob,	ld_qtaub, 	ld_newchg,	ld_qtaeff
decimal	ld_totrigavalriga,		ld_TotRigaValLire,		ld_TotRigaValDoc
date		ldt_prc,    ldt_icmp,   ldt_fcmp
date		ld_data_prev_consegna_testa
long		ll_row_testa,ll_row_scelta
long		ll_id_magazzino,ll_id_magazzino_2,ll_id_profilo
long		ll_id_articolo,ll_id_unita_confezione
long		ll_id_contropartita, ll_id_azienda, ll_id_registro,ll_null,ll_giorni
long		ll_id_cat_com_Articolo,ll_id_caus_trasporto,ll_id_gruppo
date		ld_data_reg
string	ls_tipo, ls_tipo_registro 
decimal	ldc_riordino

SetNull(ll_null)
li_ret 				= 0	
ll_row_testa		= ids_testa.getRow()
ll_row_scelta		= tab_1.tabpage_1.dw_scelta.getRow()

if ll_row_scelta > 0 then
	ll_id_magazzino	= tab_1.tabpage_1.dw_scelta.GetItemNumber( ll_row_scelta,"id_magazzino_cod" )
	ll_id_profilo		= tab_1.tabpage_1.dw_scelta.GetItemNumber( ll_row_scelta,"id_profilo" )
	ld_data_reg			= tab_1.tabpage_1.dw_scelta.GetItemDate( ll_row_scelta,"data_emissione" )
end if

if ll_row_testa > 0 then
	ll_id_azienda		= ids_testa.GetItemNumber(ll_row_testa,"documento_id_azienda")
	ll_id_magazzino_2	= ids_testa.GetItemNumber(ll_row_testa,"documento_id_magazzino_2")
end if

ll_id_articolo				= ids_righe_sog_comm.GetItemNumber( al_r1,"id_articolo" )
ll_id_unita_confezione	= ids_righe_sog_comm.GetItemNumber( al_r1,"id_unita_confezione" )
ldc_riordino				= ids_righe_sog_comm.GetItemNumber( al_r1,"riordino" ) 

ll_rr2 		= ids_riga.insertRow(0)
ll_num_riga	= ids_riga.RowCount()
if ll_rr2 <= 0 then
	return -1
end if

ll_idarti	= ll_id_articolo
ld_qta		= ldc_riordino

ids_riga.SetItem(ll_rr2,"id_unita_confezione",ll_id_unita_confezione)
ids_riga.SetItem(ll_rr2,"num_riga",ll_num_riga)
ids_riga.SetItem(ll_rr2,"id_articolo",ll_idarti)
ids_riga.SetItem(ll_rr2,"quantita",ld_qta)
ids_riga.SetItem(ll_rr2,"qta_sconto_merce",0)

select articolo.descrizione 
	into :ls_descr
	from articolo
	where articolo.id_Articolo = :ll_id_articolo
	using SQLCA;

if SQLCA.SQLCode = 0 then
	if not isNull(ls_descr) then
		ids_riga.SetItem(ll_rr2,"descrizione",ls_descr)
	end if
end if

select des_articolo.id_des_Articolo
	into :ll_iddesa
	from des_articolo 
	where des_articolo.id_articolo = :ll_id_articolo and des_articolo.id_sog_commerciale = :al_id_sogg_commerciale
	using SQLCA;

if SQLCA.SQLCode = 0 then
	if not isNull(ll_iddesa) then
		ids_riga.SetItem(ll_rr2,"id_des_articolo",ll_iddesa)
	end if
end if

SetNull(ll_id_contropartita)

select prof_documento.tipo_registro
	into :ls_tipo_registro  
	from prof_documento
	where prof_documento.id_prof_documento = :ll_id_profilo
	using SQLCA;

if SQLCA.SQLCode = 0 then
	choose case ls_tipo_registro
		case "IA", "PA", "OA", "DA", "LA", "GA"
			
			ls_tipo= "A"
		case "IV", "PV", "OV", "DV", "LV", "GV"
			
			ls_tipo= "V"
	end choose
	long ll_id_causale
	ll_id_causale=ids_riga.getItemnumber(ll_rr2,"riga_documento_id_caus_magazzino")
	SQLCA.sp_calc_cpt(al_id_sogg_commerciale, ll_id_articolo,ll_null, ls_tipo, ll_id_azienda, ll_id_contropartita, ll_id_causale)
	
	ids_riga.SetItem(ll_rr2,"id_conto",ll_id_contropartita)
	
end if

select unita_confezione.fat_conversione
	into :ld_fcon
	from unita_confezione
	where unita_confezione.id_unita_confezione = :ll_id_unita_confezione
	using SQLCA;

if SQLCA.SQLCode = 0 then
	ids_riga.SetItem(ll_rr2,"fat_con_unita_base",ld_fcon)
end if

select max("locazione"."id_locazione")
	into :ll_idloc1
	from "dba"."locazione",   
		  "dba"."magazzino"  
	where ("magazzino"."id_magazzino" = "locazione"."id_magazzino" ) and  
			( "magazzino"."id_magazzino" = :ll_id_magazzino) and  
			( "locazione"."id_area" is null ) and
			( "locazione"."corsia" is null ) and  
			( "locazione"."scaffale" is null ) and
			( "locazione"."ripiano" is null ) and  
			( "locazione"."posizione" is null ) ;

if SQLCA.SQLCode = 0 then
	ids_riga.SetItem(ll_rr2,"id_locazione_1",ll_idloc1)	
end if

if not isNull( ll_id_magazzino_2 ) then
	select max("locazione"."id_locazione")
		into :ll_idloc2
		from "dba"."locazione",   
			  "dba"."magazzino"  
		where ("magazzino"."id_magazzino" = "locazione"."id_magazzino" ) and  
				( "magazzino"."id_magazzino" = :ll_id_magazzino_2) and  
				( "locazione"."id_area" is null ) and
				( "locazione"."corsia" is null ) and  
				( "locazione"."scaffale" is null ) and
				( "locazione"."ripiano" is null ) and  
				( "locazione"."posizione" is null ) ;
	
	if SQLCA.SQLCode = 0 then
		ids_riga.SetItem(ll_rr2,"id_locazione_2",ll_idloc2)	
	end if
	
end if

if ll_row_testa > 0 then
	ll_id_gruppo	= ids_testa.GetItemNumber( ll_row_testa,"id_gruppo_agenti" )
	if not isNull(ll_id_gruppo) then
		ids_riga.setItem(ll_rr2,"id_gruppo_agenti",ll_id_gruppo)
	end if
end if	

if ll_row_testa > 0 then
	
	ll_idvalu	= ids_testa.GetItemNumber( ll_row_testa,"documento_id_valuta_des" )
	ld_newchg	= ids_testa.GetItemDecimal( ll_row_testa,"documento_cambio" )
	ll_idlist	= ids_testa.GetItemNumber( ll_row_testa,"documento_id_listino" )
	
	ids_riga.setItem(ll_rr2,"id_valuta",ll_idvalu)
	ids_riga.setItem(ll_rr2,"cambio",ld_newchg)
	ids_riga.setItem(ll_rr2,"id_listino",ll_idlist)	

end if

SQLCA.sp_prezzo_riferimento (ll_id_unita_confezione, ll_idlist,ld_data_reg,ld_prez )
If IsNull(ld_prez) then ld_prez = 0
ld_prnt = ld_prez	
ids_riga.SetItem(ll_rr2,"prezzo",ld_prez)
ids_riga.SetItem(ll_rr2,"prezzo_netto",ld_prnt)

select approvvigionamento.giorni_consegna
	into :ll_giorni
	from approvvigionamento
	where approvvigionamento.id_sog_commerciale = :al_id_sogg_commerciale and
	      approvvigionamento.id_unita_confezione = :ll_id_unita_confezione
	using SQLCA;
	
if SQLCA.SQLCode = 0 then
	if not isNull(ll_giorni) then
		ids_riga.SetItem(ll_rr2,"data_prevista_consegna", RelativeDate(ld_data_reg,ll_giorni))	
	else
		ld_data_prev_consegna_testa	= ids_testa.GetItemDate( ll_row_testa,"data_prev_consegna" )		
		if not isNull( ld_data_prev_consegna_testa ) then
			ids_riga.SetItem(ll_rr2,"data_prevista_consegna", ld_data_prev_consegna_testa )	
		end if	
	end if
else
	ld_data_prev_consegna_testa	= ids_testa.GetItemDate( ll_row_testa,"data_prev_consegna" )		
	if not isNull( ld_data_prev_consegna_testa ) then
		ids_riga.SetItem(ll_rr2,"data_prevista_consegna", ld_data_prev_consegna_testa )	
	end if	
end if

SQLCA.sp_calc_iva_sc_Art( ll_id_Articolo,al_id_sogg_commerciale,ld_data_reg,ll_oldiva )
ids_riga.SetItem(ll_rr2,"id_tab_iva",ll_oldiva)

if ll_row_testa > 0 then	
	ll_idctra	= ids_testa.GetItemNumber( ll_row_testa,"documento_id_caus_trasporto" )
	if not isNull(ll_idctra) then
		ids_riga.SetItem(ll_rr2,"id_caus_trasporto",ll_idctra)		
	end if
end if	

ids_riga.SetItem(ll_rr2,"data_inizio_competenza",ld_data_reg)
ids_riga.SetItem(ll_rr2,"data_fine_competenza",ld_data_reg)
ids_riga.SetItem(ll_rr2,"id_azienda",ll_id_azienda)


select	"unita_confezione"."fat_conversione",   
			"unita_confezione"."molteplicita",   
			"unita_confezione"."tipo_conversione"  
	into	:ld_fatconv, :ld_molt, :ls_tipoconv
	from	"dba"."unita_confezione"  
	where "unita_confezione"."id_unita_confezione" = :ll_id_unita_confezione;

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

select	"valuta"."cambio",  "valuta"."cifra_arrotondamento",
			"valuta"."tipo_arrotondamento"
	into	:ld_oldchg, :ll_arrot, :ls_tipoarr
	from	"dba"."valuta"  
	where	"valuta"."id_valuta" = :ll_idvalu;


if isNull (ld_qta) 	then ld_qta 	= 0
if isNull (ld_qtasm) then ld_qtasm 	= 0
if isNull (ld_prnt) 	then ld_prnt 	= 0


if IsNull(ll_arrot) 		then ll_arrot  = 0
if isNull(ld_oldchg) 	then ld_oldchg = 1
if isNull(ld_scri)	 	then ld_scri   = 0
	
ld_TotRigaValRiga = (ld_qta * ld_prnt) - ld_scri
ld_TotRigaValRiga = f_Round(ld_TotRigaValRiga ,ll_arrot, ls_tipoarr)
ids_riga.SetItem(ll_rr2, "tot_riga_val_riga",ld_TotRigaValRiga)
ld_TotRigaValLire = ld_TotRigaValRiga * ld_oldchg

ld_qtaeff = ld_qta+ld_qtasm
if ld_qtaeff > 0 then
	ids_riga.SetItem (ll_rr2, "val_attribuito", ld_TotRigaValLire/ld_qtaeff)
else
	ids_riga.SetItem (ll_rr2, "val_attribuito", 0)
end if


ids_riga.SetItem(ll_rr2, "tot_riga_val_az",ld_TotRigaValLire)
if idc_td_cambio = 0 or isNull (idc_td_cambio) then idc_td_cambio=1
ld_TotRigaValDoc = ld_totRigaValRiga *  ld_oldchg / idc_td_cambio
ids_riga.SetItem(ll_rr2, "tot_riga_val_doc",ld_TotRigaValDoc)

ids_riga.SetItem(ll_rr2,"qta_evasa",0)
ids_riga.SetItem(ll_rr2,"qta_evasa_un_base",0)
ids_riga.SetItem(ll_rr2,"forza_chius_evasione","N")
ids_riga.SetItem(ll_rr2,"sospesa","N")
ids_riga.SetItem(ll_rr2,"da_stampare","S")

if ll_row_testa > 0 then	
	ll_idcauder	= ids_testa.GetItemNumber( ll_row_testa,"documento_id_caus_magazzino" )
	if not isNull(ll_idcauder) then
		ids_riga.SetItem(ll_rr2,"id_caus_magazzino",ll_idcauder)
	end if
end if	



select "articolo"."codice",   
       "cat_com_articolo"."codice",   
       "cat_merceologica"."codice"  
   into :ls_codart,   
        :ls_catcom,   
        :ls_catmer  
   from {oj "articolo" LEFT OUTER JOIN "cat_com_articolo"  ON "articolo"."id_cat_com_articolo" = "cat_com_articolo"."id_cat_com_articolo"},
	 	  {oj "articolo"  LEFT OUTER JOIN "cat_merceologica"  ON "articolo"."id_cat_merceologica" = "cat_merceologica"."id_cat_merceologica"}
   where "articolo"."id_articolo" = :ll_idarti
	using	SQLCA ;

if isNull (ls_codart) then ls_codart = ""
if isNull (ls_catcom) then ls_catcom = ""
if isNull (ls_catmer) then ls_catmer = ""


select "tab_iva"."codice"  
    into :ls_codiva  
    from "tab_iva"  
    where "tab_iva"."id_tab_iva" = :ll_oldiva;

if isNull (ls_codiva) then ls_codiva = ""
	 
select "conto_azienda"."codice"  
    into :ls_codcpt  
    from "conto_azienda"  
    where "conto_azienda"."id_conto" = :ll_id_contropartita ;

ids_riga.SetItem(ll_rr2,"c_codart",ls_codart)
ids_riga.SetItem(ll_rr2,"c_catcom",ls_catcom)
ids_riga.SetItem(ll_rr2,"c_catmer",ls_catmer)
ids_riga.SetItem(ll_rr2,"c_codiva",ls_codiva)
ids_riga.SetItem(ll_rr2,"c_contro",ls_codcpt)

return 0

end function

public function boolean wf_test_data_registrazione (date ad_data);
date		ld_data_inizio, ld_data_fine
long		ll_id_esercizio
boolean	lb_Valida

lb_Valida= TRUE

select "azienda"."id_esercizio"
	into :ll_id_esercizio
	from "dba"."azienda"
	where "azienda"."id_azienda" = 1
	using SQLCA;
	
if SQLCA.SQLCode = 0 then	

	select "esercizio"."data_inizio",   
			 "esercizio"."data_fine"  
		into 	:ld_data_inizio,   
				:ld_data_fine
		from 	"dba"."esercizio"  
		where "esercizio"."id_esercizio" = :ll_id_esercizio ;
	
	If ld_data_inizio > ad_data then  lb_Valida= FALSE
	If ld_data_fine < ad_data then  lb_Valida= FALSE
	
end if

RETURN lb_Valida

end function

public function integer wf_calc_spese ();
long 			ll_row,ll_row_scelta,ll_row_spese
long			ll_intestatario, ll_prof_documento, ll_count, ll_size, ll_id_spesa
long 			ll_id_tab_iva, ll_ret_value
string 		ls_codice_int, ls_codice_prof, ls_codice, ls_mod_calc_iva
decimal  	ldc_percentuale, ldc_importo, ldc_importo_ripiego 

ll_row					= 0
ll_row_scelta			= tab_1.tabpage_1.dw_scelta.GetRow()

if ll_row_scelta > 0 then
	ll_intestatario	= tab_1.tabpage_1.dw_scelta.GetItemNumber( ll_row_scelta,"id_sog_commerciale" )
	ll_prof_documento	= tab_1.tabpage_1.dw_scelta.GetItemNumber( ll_row_scelta,"id_profilo" )
end if

if not IsNull(il_az_idspesabol) OR il_az_idspesabol = 0 then
		
	select "prof_documento"."spese_gestite"  
		into :ls_codice_prof  
		from "dba"."prof_documento"  
		where "prof_documento"."id_prof_documento" = :ll_prof_documento;
	
	if isNull(ls_codice_prof) then 	
		MessageBox( "Avviso","Mancano le spese gestite nel profilo documento.",Information!)	
		return 0
	else

		declare lcur_spesa cursor for  
		select "spesa"."codice" ,
				 "spesa"."id_spesa" ,
				 "spesa"."percentuale" ,
				 "spesa_sog_commerciale"."importo",
				 "spesa"."importo",
				 "spesa"."id_tab_iva",
				 "spesa"."mod_cal_iva"
			from "dba"."spesa_sog_commerciale",   
				  "dba"."spesa"  
			where ( "spesa"."id_spesa" = "spesa_sog_commerciale"."id_spesa" ) AND
					("spesa_sog_commerciale"."id_sog_commerciale" =  :ll_intestatario);
					
		if SQLCA.SQLCode <> -1 then 
			
			open lcur_spesa;
			
			
			ll_size = Len(ls_codice_prof)
			
			do while sqlca.sqlcode = 0
				
				fetch lcur_spesa into :ls_codice_int, :ll_id_spesa , &
											 :ldc_percentuale , :ldc_importo,&
											 :ldc_importo_ripiego, :ll_id_tab_iva,&
											 :ls_mod_calc_iva;
				
				if Pos(ls_codice_prof,ls_codice_int) > 0 then 
					If IsNull(ldc_importo) OR ldc_importo = 0  then 
						ldc_importo= ldc_importo_ripiego
					end if	
					
					if ls_codice_int = 'B' then 
						
						ldc_importo = 0
					end if								
					
					ll_row_spese	=  ids_spese.RowCount()
					
					if ls_codice_int = 'B' then
						if ll_row_spese > 0 then 
							ll_row	=	ids_spese.Find("id_spesa = " + String(il_az_idspesabol) ,1,ll_row_spese )
						end if
					else	
						if ll_row_spese > 0 then 
							ll_row	=	ids_spese.Find("id_spesa = " + String(ll_id_spesa) ,1,ll_row_spese )
						end if
					end if	
					
					if ll_row = 0 then 
						ll_row	= ids_spese.InsertRow(0)
						ids_spese.SetItem(ll_row, "id_spesa", ll_id_spesa)
						ids_spese.SetItem(ll_row, "percentuale", ldc_percentuale)
						ids_spese.SetItem(ll_row, "importo", ldc_importo / idc_td_cambio)
						ids_spese.SetItem(ll_row, "cc_importo_buffer", ldc_importo)
						ids_spese.SetItem(ll_row, "id_tab_iva", ll_id_tab_iva)
						ids_spese.SetItem(ll_row, "cc_mod_calc_iva", ls_mod_calc_iva)
					end if
					
				end if
				
			loop
			
			close lcur_spesa;
		else
			ll_ret_value = 1
		end if
	end if
else
	MessageBox( "Avviso","Manca una spesa di tipo bollo.",Information!)	
	ll_ret_value = 1
end if

return ll_ret_value
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
	ll_rowfound = ads_cast.Find("id_tab_iva =" + string(al_idtabiva),1,ll_nrows)
else
	ll_rowfound = 0
end if


if ll_rowfound= 0 then
	ll_newrow = ads_cast.insertrow(0)
	ll_retval = ll_newrow
	
	
	
	
	
	
	ads_cast.SetItem(ll_newrow, "id_tab_iva",al_idtabiva)
	ads_cast.SetItem(ll_newrow, "val_omaggi", ad_omaggism)
	ads_cast.SetItem(ll_newrow, "c_imposta", ad_imposta)
	ads_cast.SetItem(ll_newrow, "val_imponibile", ad_imponibile)
	ads_cast.SetItem(ll_newrow, "c_aliquota", ad_aliquota)
	ads_cast.SetItem(ll_newrow, "cc_per_detrazione", ad_perdetra)
	
else
	
	ll_retval = ll_rowfound
	
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

public function integer wf_set_note ();
long		ll_id_mod_registro
long		ll_id_esercizio_prop,ll_id_profilo
string	ls_descrizione,ls_tipo_registro,ls_note

ll_id_esercizio_prop	= tab_1.tabpage_1.dw_scelta.GetItemNumber( 1,"id_esercizio" )
ll_id_profilo			= tab_1.tabpage_1.dw_scelta.GetItemNumber( 1,"id_profilo" )

select prof_documento.id_mod_registro_prop
	into :ll_id_mod_registro
	from prof_documento
	where prof_documento.id_prof_documento = :ll_id_profilo
	using SQLCA;
	
	
if not isNull(ll_id_mod_registro) then
		
	select registro.descrizione,registro.tipo_registro
		into :ls_descrizione,:ls_tipo_registro
		from registro
		where registro.id_mod_registro = :ll_id_mod_registro and registro.id_esercizio = :ll_id_esercizio_prop
		using SQLCA;
		
	if SQLCA.SQLCode = 0 then
		ls_note	= "Desc. : " + ls_descrizione + "~r" + "Tipo    : " + ls_tipo_registro
		tab_1.tabpage_1.dw_scelta.SetItem( 1,"note",ls_note )
	end if	
	
end if

return 0
end function

public function boolean wf_verify_data (date ad_data);
long		ll_id_esercizio
date		ld_da_data,ld_a_data

ll_id_esercizio	= tab_1.tabpage_1.dw_scelta.GetItemNumber( 1,"id_esercizio" )

select esercizio.data_inizio,esercizio.data_fine
	into :ld_da_data,:ld_a_data
	from esercizio
	where esercizio.id_esercizio = :ll_id_esercizio
	using SQLCA;
	
if not isNull(ld_da_data) and not isNull(ld_a_data) then
	if (ad_data >= ld_da_data) and (ad_data <= ld_a_data) then
		return true
	end if	
end if

return false
end function

public function integer wf_dw_setfocus ();
choose case ii_dwi
	case 1
		tab_1.SelectTab(1)
		tab_1.tabpage_1.dw_scelta.setfocus()
	case 2
		tab_1.SelectTab(1)
		tab_1.tabpage_1.dw_select_riordini_lt.setfocus() 
	case 3
		tab_1.SelectTab(2)
		tab_1.tabpage_2.dw_errori.setfocus()

end choose

return 0
end function

public function integer wf_delete_rows_fabbisogno ();
long			ll_row_count,ll_i
string		ls_checked
boolean		lb_success

lb_success		= true
ll_row_count	= tab_1.tabpage_1.dw_select_riordini_lt.RowCount()

for ll_i = ll_row_count to 1 step -1
	
	ls_checked	=  tab_1.tabpage_1.dw_select_riordini_lt.GetItemString( ll_i,"cc_selezionato" )
	if ls_checked = 'S' then
		if tab_1.tabpage_1.dw_select_riordini_lt.DeleteRow(ll_i)	= -1 then
			lb_success	= false
		end if
	end if	
	
next

if lb_success	= true then
	if tab_1.tabpage_1.dw_select_riordini_lt.Update() = 1 then
		commit using SQLCA;
		if SQLCA.SQLCode <> 0 then
			rollback using SQLCA;
		end if
	else
		rollback using SQLCA;
	end if	
else
	rollback using SQLCA;
end if	

return 0
end function

event open;string		ls_sql

tab_1.tabpage_3.Visible						= FALSE
tab_1.tabpage_4.Visible						= FALSE
tab_1.tabpage_1.dw_testa_wrk.Visible	= FALSE

iuo_scan 				= create u_sql_scanner
iuo_scan_fabbisogno	= create u_sql_scanner
iuo_pag 					= create uo_esp_pag

ids_righe_sog_comm	= create u_ds_main
ids_righe_sog_comm.dataobject	= "d_righe_sogg_comm_ex"
ids_righe_sog_comm.SetTransObject(SQLCA)

ids_docs = create u_ds_main
ids_docs.dataobject = "d_deriva_batch_01_gd"
ids_docs.SetTransObject(SQLCA)
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
ids_riga.dataobject = "d_deriva_batch_righe_tb"
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
tab_1.tabpage_1.dw_scelta.SetFocus()
ii_dwi = 1

end event

event close;
if isvalid(iuo_scan) then destroy iuo_scan
if isvalid(iuo_scan_fabbisogno) then destroy iuo_scan_fabbisogno
if isvalid(ids_derp) then destroy ids_derp
if isvalid(ids_docs) then destroy ids_docs
if isvalid(ids_sc) then destroy ids_sc
if isvalid(ids_testa) then destroy ids_testa
if isvalid(ids_riga) then destroy ids_riga
if isvalid(ids_spese) then destroy ids_spese
if isvalid(ids_scad) then destroy ids_scad
if isvalid(ids_iva) then destroy ids_iva

if isvalid(ids_righe_sog_comm) then destroy ids_righe_sog_comm

if isvalid(iuo_pag) then destroy iuo_pag
end event

on w_documento_batch_wz.create
this.cb_procedi=create cb_procedi
this.cb_anomalie=create cb_anomalie
this.cb_report=create cb_report
this.cb_genera=create cb_genera
this.tab_1=create tab_1
this.cb_annulla=create cb_annulla
this.Control[]={this.cb_procedi,&
this.cb_anomalie,&
this.cb_report,&
this.cb_genera,&
this.tab_1,&
this.cb_annulla}
end on

on w_documento_batch_wz.destroy
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

type cb_procedi from commandbutton within w_documento_batch_wz
event clicked pbm_bnclicked
int X=46
int Y=20
int Width=306
int Height=84
int TabOrder=50
string Text="Procedi..."
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
long		ll_row,ll_id_sog_commerciale,ll_id_magazzino
long		ll_row_count
string	ls_sql,ls_where


ls_sql						= ""
ll_row						= tab_1.tabpage_1.dw_scelta.GetRow()

if ll_row > 0 then
	
	tab_1.tabpage_1.dw_select_riordini_lt.SetTransObject(SQLCA)
	
	ll_id_sog_commerciale	= tab_1.tabpage_1.dw_scelta.GetItemNumber( ll_row,"id_sog_commerciale" )
	ll_id_magazzino			= tab_1.tabpage_1.dw_scelta.GetItemNumber( ll_row,"id_magazzino_cod" )
	
	if not isNull( ll_id_sog_commerciale ) then
		ls_sql += " ( fabbisogno.id_sog_commerciale = "+ string(ll_id_sog_commerciale) +" )"
	end if
	
	if isNull( ll_id_magazzino ) then
		Messagebox( "Avviso","Selezionare un Magazzino !!!",Information! )
		return 0
	else
		if isNull( ll_id_sog_commerciale ) then
			ls_sql += " (fabbisogno.id_magazzino = "+string(ll_id_magazzino)+")"
		else
			ls_sql += " AND (fabbisogno.id_magazzino = "+string(ll_id_magazzino)+")"
		end if	
	end if
	
	ls_where = tab_1.tabpage_1.dw_select_riordini_lt.object.datawindow.table.select
	iuo_scan_fabbisogno.f_setinitial(ls_where)
	iuo_scan_fabbisogno.f_setcurrent(ls_where)
	iuo_scan_fabbisogno.f_reset_cur_as_ini()
	iuo_scan_fabbisogno.f_add_where_condition (ls_sql)
	ls_sql = iuo_scan_fabbisogno.f_getcurrent()
	tab_1.tabpage_1.dw_select_riordini_lt.object.datawindow.table.select = ls_sql
		
	ll_row_count = tab_1.tabpage_1.dw_select_riordini_lt.Retrieve()
	
end if
end event

type cb_anomalie from commandbutton within w_documento_batch_wz
event clicked pbm_bnclicked
int X=1394
int Y=20
int Width=443
int Height=84
int TabOrder=10
boolean Enabled=false
string Text="St. &Anomalie"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
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

type cb_report from commandbutton within w_documento_batch_wz
event clicked pbm_bnclicked
int X=1851
int Y=20
int Width=443
int Height=84
int TabOrder=30
boolean Enabled=false
string Text="&Report di prova"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer		li_ret

li_ret = wf_check_sel()
if li_ret = 0 then

	wf_elab_tutto(false,"ciao")

end if


end event

type cb_genera from commandbutton within w_documento_batch_wz
int X=2309
int Y=20
int Width=443
int Height=84
int TabOrder=40
string Text="&Gen. Documenti"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
integer		li_ret

li_ret = wf_check_sel()
if li_ret = 0 then
	wf_elab_tutto(true,"ciao")
end if
end event

type tab_1 from tab within w_documento_batch_wz
event create ( )
event destroy ( )
int X=23
int Y=120
int Width=2766
int Height=1440
int TabOrder=60
boolean RaggedRight=true
int SelectedTab=1
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2729
int Height=1320
long BackColor=79741120
string Text="Scelta Parametri"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
st_title st_title
dw_select_riordini_lt dw_select_riordini_lt
dw_scelta dw_scelta
dw_testa_wrk dw_testa_wrk
end type

on tabpage_1.create
this.st_title=create st_title
this.dw_select_riordini_lt=create dw_select_riordini_lt
this.dw_scelta=create dw_scelta
this.dw_testa_wrk=create dw_testa_wrk
this.Control[]={this.st_title,&
this.dw_select_riordini_lt,&
this.dw_scelta,&
this.dw_testa_wrk}
end on

on tabpage_1.destroy
destroy(this.st_title)
destroy(this.dw_select_riordini_lt)
destroy(this.dw_scelta)
destroy(this.dw_testa_wrk)
end on

type st_title from statictext within tabpage_1
int X=50
int Y=656
int Width=2629
int Height=80
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Articoli selezionati"
boolean FocusRectangle=false
long TextColor=16777215
long BackColor=276856960
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_select_riordini_lt from u_dw_ext_main within tabpage_1
int X=50
int Y=736
int Width=2629
int Height=540
int TabOrder=20
string DataObject="d_select_riordini_lt"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>3 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=3
	end choose
	wf_dw_setfocus()
end if

end event

type dw_scelta from u_dw_ext_main within tabpage_1
event itemchanged pbm_dwnitemchange
event ue_set_search ( string as_nomecol,  string as_valcol )
event ue_use_search ( string as_nomecol )
event ue_controllo_data_fine ( string as_column )
event ue_set_sql_cond ( string as_column )
int X=50
int Y=36
int Width=2629
int Height=600
int TabOrder=10
string DataObject="d_scelta_parametri_ff"
end type

event itemchanged;call super::itemchanged;string		ls_dbc[], ls_dbv[], ls_dwc[], ls_sql_cond
string		ls_a, ls_b, ls_c, ls_pc
date			ld_data_inizio,ld_data
long			ll_a, ll_ok, ll_row, ll_scode

ll_row = GetRow()
if ll_row > 0 then
	CHOOSE CASE dwo.name
		
		CASE "sog_commerciale_cod"
			ls_sql_cond = ""
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_sog_commerciale"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "sog_commerciale_cod"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "sog_commerciale_des"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
			
		CASE "sog_commerciale_des"
			ls_sql_cond = ""
			ls_dbc[1] = "id_sog_commerciale"
			ls_dwc[1] = "id_sog_commerciale"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "sog_commerciale_cod"
			ls_dbc[3] = "rag_soc_1"
			ls_dwc[3] = "sog_commerciale_des"
			ll_ok = uf_autofind_col(dwo.Name, "sog_commerciale_gen", &  
											"rag_soc_1", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF

		CASE "magazzino_cod"
			ls_sql_cond = ""
			ls_dbc[1] = "id_magazzino"
			ls_dwc[1] = "id_magazzino_cod"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "magazzino_cod"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "magazzino_des"
			ll_ok = uf_autofind_col(dwo.Name, "magazzino", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
			
		CASE "magazzino_des"
			ls_sql_cond = ""
			ls_dbc[1] = "id_magazzino"
			ls_dwc[1] = "id_magazzino_cod"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "magazzino_cod"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "magazzino_des"
			ll_ok = uf_autofind_col(dwo.Name, "magazzino", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				RETURN 2
			END IF
			
		CASE 'profilo_cod'
			ls_sql_cond = ""
			ls_dbc[1] = "id_prof_documento"
			ls_dwc[1] = "id_profilo"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "profilo_cod"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "profilo_des"
			ll_ok = uf_autofind_col(dwo.Name, "prof_documento", &  
											"codice", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				wf_set_note()
				RETURN 2
			END IF

		CASE 'profilo_des'
			ls_sql_cond = ""
			ls_dbc[1] = "id_prof_documento"
			ls_dwc[1] = "id_profilo"
			ls_dbc[2] = "codice"
			ls_dwc[2] = "profilo_cod"
			ls_dbc[3] = "descrizione"
			ls_dwc[3] = "profilo_des"
			ll_ok = uf_autofind_col(dwo.Name, "prof_documento", &  
											"descrizione", "A", data, & 
											ls_sql_cond, 3, &
											ls_dbc, ls_dbv, ls_dwc)
			IF (ll_ok > 0) THEN
				wf_set_note()
				RETURN 2
			END IF
			
		case 'id_esercizio'
			wf_set_note()
			
		case 'data_emissione'
			ld_data	= date(data)
			if wf_verify_data(ld_data) = false then
				MessageBox( "Avviso","La data di emissione non è compresa nell'esercizio !!!",StopSign! )
				return 2
			end if	
			
	end choose
else
	MessageBox("Errore!","Riga nulla!")
end if
end event

event ue_set_search;call super::ue_set_search;

long		ll_row, ll_id_int, ll_id_destinazione

ll_row = GetRow()
CHOOSE CASE as_nomecol

	CASE "sog_commerciale_cod"
		is_search_window			 	= "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value 	= as_valcol
		is_ricpar.s_filter_name 	= "codice"
	CASE "sog_commerciale_des"
		is_search_window 				= "w_sog_commerciale_gen_coddes_sw"
		is_ricpar.s_filter_value 	= as_valcol
		is_ricpar.s_filter_name 	= "rag_soc_1"
		
	CASE "magazzino_cod"
		is_search_window			 	= "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value 	= as_valcol
		is_ricpar.s_filter_name 	= "codice"
	CASE "magazzino_des"
		is_search_window 				= "w_magazzino_coddes_sw"
		is_ricpar.s_filter_value 	= as_valcol
		is_ricpar.s_filter_name 	= "descrizione"

	CASE "profilo_cod"
		is_search_window 				= "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value 	= as_valcol
		is_ricpar.s_filter_name 	= "prof_documento_codice"
	CASE "profilo_des"
		is_search_window 				= "w_prof_documento_coddes_sw"
		is_ricpar.s_filter_value 	= as_valcol
		is_ricpar.s_filter_name 	= "prof_documento_descrizione"

END CHOOSE

end event

event ue_use_search;call super::ue_use_search;

CHOOSE CASE as_nomecol

	CASE "sog_commerciale_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_des", is_ricpar.s_ausil_value[1])
		
	CASE "sog_commerciale_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_sog_commerciale", is_ricpar.s_id_seg_value[1])
		uf_set_colval("sog_commerciale_cod", is_ricpar.s_ausil_value[1])

	CASE "magazzino_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino_cod", is_ricpar.s_id_seg_value[1])
		uf_set_colval("magazzino_des", is_ricpar.s_ausil_value[1])
		
	CASE "magazzino_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_magazzino_cod", is_ricpar.s_id_seg_value[1])
		uf_set_colval("magazzino_cod", is_ricpar.s_ausil_value[1])
	
	CASE "profilo_cod"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_profilo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("profilo_des", is_ricpar.s_ausil_value[1])
		wf_set_note()
		
	CASE "profilo_des"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_profilo", is_ricpar.s_id_seg_value[1])
		uf_set_colval("profilo_cod", is_ricpar.s_ausil_value[1])
		wf_set_note()

END CHOOSE

end event

event ue_controllo_data_fine;call super::ue_controllo_data_fine;
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

event ue_init;call super::ue_init;is_colonne_drop[1] = "id_esercizio"
this.triggerevent("ue_initial")

end event

event ue_post_open;call super::ue_post_open;
long		ll_id_esercizio_prop
long		ll_row

select azienda.id_esercizio_proposto
	into :ll_id_esercizio_prop
	from azienda
	where azienda.id_azienda = 1
	using SQLCA;
	
ll_row	= this.GetRow()	
if SQLCA.SQLCode = 0 then
	if not isNull(ll_id_esercizio_prop) then
		this.SetItem( ll_row,"id_esercizio",ll_id_esercizio_prop )
	end if
end if

this.SetItem( ll_row,"data_emissione",Today() )
end event

event ue_key;call super::ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>3 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=3
	end choose
	wf_dw_setfocus()
end if


end event

type dw_testa_wrk from datawindow within tabpage_1
int X=1513
int Y=116
int Width=1120
int Height=1160
int TabOrder=30
string DataObject="d_documento_ordine_ff"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event sqlpreview;MessageBox("",sqlsyntax)

end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2729
int Height=1320
long BackColor=79741120
string Text="Anomalie"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
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
int X=27
int Y=76
int Width=3314
int Height=1480
int TabOrder=51
boolean Visible=false
string DataObject="d_deriva_batch_err_rpt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;
this.visible = false
idw_errori.visible = true
end event

type dw_errori from datawindow within tabpage_2
event ue_key pbm_dwnkey
int X=27
int Y=36
int Width=2606
int Height=1240
int TabOrder=51
string DataObject="d_deriva_batch_03_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_key;
if key = KeyF6! then
	choose case keyflags
		case 0
			
			ii_dwi ++
			if ii_dwi>3 then ii_dwi=1
		case 1
			
			ii_dwi --
			if ii_dwi<1 then ii_dwi=3
	end choose
	wf_dw_setfocus()
end if


end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2729
int Height=1320
long BackColor=79741120
string Text="Work DW"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
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
int X=2542
int Y=516
int Width=1326
int Height=400
int TabOrder=64
string DataObject="d_contr_documento_lt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_scad_wrk from datawindow within tabpage_3
int X=2542
int Y=36
int Width=1326
int Height=440
int TabOrder=63
string DataObject="d_scadenza_documento_lt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_iva_wrk from datawindow within tabpage_3
int X=2542
int Y=936
int Width=1326
int Height=440
int TabOrder=62
string DataObject="d_cast_iva_documento_lt"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_spese_wrk from datawindow within tabpage_3
int X=27
int Y=16
int Width=2194
int Height=360
int TabOrder=52
string DataObject="d_deriva_batch_spese_tb"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_docs from datawindow within tabpage_3
int X=27
int Y=396
int Width=1143
int Height=1180
int TabOrder=62
string DataObject="d_deriva_batch_01_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_sc from datawindow within tabpage_3
int X=1193
int Y=1036
int Width=1303
int Height=540
int TabOrder=61
string DataObject="d_deriva_batch_sc_gd"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_r2 from datawindow within tabpage_3
int X=1193
int Y=396
int Width=1303
int Height=580
int TabOrder=51
string DataObject="d_deriva_batch_04_ex"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type tabpage_4 from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=104
int Width=2729
int Height=1320
long BackColor=79741120
string Text="Report di prova"
long TabBackColor=79741120
long TabTextColor=33554432
long PictureMaskColor=536870912
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
int X=1902
int Y=76
int Width=1714
int Height=1460
int TabOrder=61
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
string Text="Report dell'acquisizione"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_testrighe from datawindow within tabpage_4
int X=27
int Y=36
int Width=2880
int Height=1540
int TabOrder=51
boolean BringToTop=true
string DataObject="d_deriva_batch_righe_tb"
boolean TitleBar=true
BorderStyle BorderStyle=StyleLowered!
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_annulla from commandbutton within w_documento_batch_wz
int X=411
int Y=20
int Width=306
int Height=84
int TabOrder=20
string Text="&Esci"
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close (parent)
end event

