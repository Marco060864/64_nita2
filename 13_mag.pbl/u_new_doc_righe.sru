forward
global type u_new_doc_righe from nonvisualobject
end type
end forward

global type u_new_doc_righe from nonvisualobject
end type
global u_new_doc_righe u_new_doc_righe

forward prototypes
public subroutine uf_importa_righe_veloce (s_par_der_doc astr_par, ref w_new_doc a_win_doc)
public subroutine uf_calcola_cambio (decimal adc_cambio, ref w_new_doc a_win_doc)
public subroutine uf_calcola_cambio_derivazione (decimal adc_cambio, w_new_doc a_win_doc)
public subroutine uf_importa_righe_old (s_par_der_doc astr_par, ref w_new_doc a_win_doc)
public subroutine uf_importa_righe (s_par_der_doc astr_par, ref w_new_doc a_win_doc)
end prototypes

public subroutine uf_importa_righe_veloce (s_par_der_doc astr_par, ref w_new_doc a_win_doc);
long		ll_size, ll_count
integer		li_num_riga , li_ordine
long			ll_id_documento_o, ll_id_documento_d
long			ll_id_caus_magazzino, ll_id_locazione_1, ll_id_locazione_2

ll_size = upperbound(astr_par.s_mio)

ll_id_documento_d = a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_documento")

for ll_count = 1 to ll_size
	ll_id_documento_o = long(astr_par.s_mio[ll_count])
	
	SELECT COUNT(*)
	INTO	 :li_num_riga
	FROM	 riga_documento
	WHERE  id_documento = :ll_id_documento_d
	;
	
	SELECT id_caus_magazzino, id_locazione_1, id_locazione_2
	INTO	 :ll_id_caus_magazzino, :ll_id_locazione_1, :ll_id_locazione_2
	FROM	 documento
	WHERE  id_documento = :ll_id_documento_d
	;
	
	
	SELECT id_caus_mag_der
	INTO	 :ll_id_caus_magazzino
	FROM	 der_profilo p, documento d, documento dd
	WHERE  d.id_documento  = :ll_id_documento_o
	AND	 dd.id_documento = :ll_id_documento_d
	AND	 p.id_prof_documento_padre = d.id_prof_documento
	AND	 p.id_prof_documento_derivato = dd.id_prof_documento
	AND	 p.id_caus_mag_pro = d.id_caus_magazzino
	;
	
	li_ordine=li_num_riga/100
	INSERT INTO RIGA_DOCUMENTO (id_documento,id_unita_confezione,id_gruppo_agenti,
		num_riga,id_articolo,descrizione,id_des_articolo,quantita,qta_sconto_merce,
		fat_con_unita_base,fat_con_globale,qta_un_base,
		id_caus_magazzino,id_locazione_1,id_locazione_2,id_valuta,cambio,id_listino,
		id_con_lis_articolo,prezzo,sconto,prezzo_netto,sconto_riga,data_prevista_consegna,
		peso_netto,peso_lordo,dim_l,dim_h,dim_p,num_colli,id_tab_iva,val_attribuito,
		provv_agente,provv_subage,provv_carea,id_caus_trasporto,forza_chius_evasione,
		sospesa,da_stampare,data_inizio_competenza,data_fine_competenza,tot_riga_val_riga,
		tot_riga_val_doc,tot_riga_val_az,id_riga_doc_provenienza,id_conto,id_azienda,
		id_riga_doc_padre,provv_imp_agente,provv_imp_subage,provv_imp_carea,
		id_gruppo_Agenti_2,provv_agente_2,
		provv_subage_2,provv_carea_2,provv_imp_agente_2,provv_imp_subage_2,provv_imp_carea_2)
	SELECT :ll_id_documento_d, id_unita_confezione,id_gruppo_agenti,
		:li_num_riga+NUMBER(*),id_articolo,descrizione,id_des_articolo,quantita,qta_sconto_merce,
		fat_con_unita_base,fat_con_globale,qta_un_base,
		IFNULL(id_caus_magazzino, NULL, :ll_id_caus_magazzino), 
		IFNULL(id_caus_magazzino, NULL, :ll_id_locazione_1), 
		IFNULL(id_caus_magazzino, NULL, :ll_id_locazione_2),id_valuta,cambio,
		id_listino,id_con_lis_articolo,prezzo,sconto,prezzo_netto,
		sconto_riga,data_prevista_consegna,
		peso_netto,peso_lordo,dim_l,dim_h,dim_p,num_colli,id_tab_iva,val_attribuito,
		provv_agente,provv_subage,provv_carea,id_caus_trasporto,forza_chius_evasione,
		sospesa,da_stampare,data_inizio_competenza,data_fine_competenza,tot_riga_val_riga,
		tot_riga_val_doc,tot_riga_val_az,id_riga_documento,id_conto,id_azienda,
		id_riga_doc_padre,provv_imp_agente,provv_imp_subage,provv_imp_carea,
		id_gruppo_Agenti_2,provv_agente_2,
		provv_subage_2+ :li_ordine/100,provv_carea_2,provv_imp_agente_2,provv_imp_subage_2,provv_imp_carea_2
	FROM	riga_documento
	WHERE	id_documento = :ll_id_documento_o 
	
	order by num_riga 
	;
	
	if (SQLCA.SQLCODE = -1) then &
		messagebox("DBError", SQLCA.SQLERRTEXT)
	COMMIT;
	
next

a_win_doc.idw_master.is_list.s_modo=modo_modifica
a_win_doc.idw_master.is_list.s_identifica[1]="id_documento"
a_win_doc.idw_master.is_list.l_identifica[1]=ll_id_documento_d
a_win_doc.idw_master.event ue_retrieve(0,0)
a_win_doc.idw_master.setfocus()


end subroutine

public subroutine uf_calcola_cambio (decimal adc_cambio, ref w_new_doc a_win_doc);
integer li_ret
if a_win_doc.idw_riga.rowcount()>0 then
	li_ret=messagebox("Attenzione!", "Vuoi modificare il cambio su tutte le righe?",&
	stopsign!, yesno!)
	if li_ret=1 then
		a_win_doc.tab_1.tabpage_4.dw_cast_iva_documento_lt.object.c_cambio_text.text=string(adc_cambio)
		a_win_doc.tab_1.tabpage_4.dw_spesa_documento_gd.object.c_cambio_text.text=string(adc_cambio)
		a_win_doc.idc_cambio=adc_cambio
		for li_ret=1 to a_win_doc.idw_riga.rowcount()
			a_win_doc.idw_riga.setitem(li_ret, "riga_documento_cambio", adc_cambio)	
		next
		a_win_doc.tab_1.tabPage_2.cb_ricalcola.triggerevent(clicked!)
		a_win_doc.tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)
	end if
end if
end subroutine

public subroutine uf_calcola_cambio_derivazione (decimal adc_cambio, w_new_doc a_win_doc);
integer li_ret
if a_win_doc.idw_riga.rowcount()>0 then
	li_ret=messagebox("Attenzione!", "Vuoi modificare il cambio su tutte le righe?",&
	stopsign!, yesno!)
	if li_ret=1 then
		a_win_doc.tab_1.tabpage_4.dw_cast_iva_documento_lt.object.c_cambio_text.text=string(adc_cambio)
		a_win_doc.tab_1.tabpage_4.dw_spesa_documento_gd.object.c_cambio_text.text=string(adc_cambio)
		a_win_doc.idc_cambio=adc_cambio
		for li_ret=1 to a_win_doc.idw_riga.rowcount()
//			a_win_doc.idw_riga.setitem(li_ret, "riga_documento_cambio", 1/adc_cambio)
			a_win_doc.idw_riga.setitem(li_ret, "riga_documento_cambio", adc_cambio)
		next
		a_win_doc.tab_1.tabPage_2.cb_ricalcola.triggerevent(clicked!)
		a_win_doc.tab_1.tabpage_4.cb_ricalcola_cast.triggerevent(clicked!)
	end if
end if
end subroutine

public subroutine uf_importa_righe_old (s_par_der_doc astr_par, ref w_new_doc a_win_doc);
long		ll_size, ll_count, ll_row, ll_id_prof_documento, ll_id_riga_documento
boolean	lb_ricc, lb_Ok, lb_descr, lb_tengo

long		ll_idriga, ll_idart, ll_iddes, ll_idunc,ll_idcaus, ll_id_sog_commerciale
long		ll_idl1, ll_idl2, ll_idval, ll_idlis, ll_idcla, ll_idiva, ll_id_agente, ll_id_r_lotto
long		ll_idage, ll_idctr, ll_idcpt, ll_idazi, ll_Id_tab_Iva, ll_Id_Sog_Comm
string	ls_descr, ls_scon, ls_Contabilizzabile, ls_cod_lotto
decimal	ld_fcub, ld_fcgl, ld_camb, ld_prez, ld_scri, ld_psnt, ld_pslo
decimal	ld_diml, ld_dimh, ld_dimp, ld_numc, ld_prv1, ld_prv2, ld_prv3, ld_vatt
date		ldt_cns, ldt_dic, ldt_dfc, ld_data_lotto
string	ls_Prec_Esenzione, ls_Att_Esenzione, ls_simbolo, ls_tipo
long		ll_rows[], ll_id_loc_1, ll_id_loc_2

decimal  ld_prv_imp1,  ld_prv_imp2,  ld_prv_imp3
decimal	ld_prv1_2, ld_prv2_2, ld_prv3_2, ld_prv_imp1_2,  ld_prv_imp2_2,  ld_prv_imp3_2
long 		ll_idage_2
string   ls_cod_articolo		

Long		ll_SizeIni
ll_sizeini =a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
long ll_test_orafo, ll_null, ll_id_doc, ll_test_orafo_1,ll_righe_esistenti
decimal ld_fino, ld_calo
setnull(ll_null)
decimal ld_cambio_attuale
integer li_ret, li_max
Long		ll_id_articolo, riga_in
String	ls_des_articolo
//string ls_pancali, ls_segno
long ll_id_cat_imb, ll_id_cat_art, ll_ret, ll_saldo


//select pancali, id_cat_com_art_imb
//into :ls_pancali, :ll_id_cat_imb
//from pers_par_sistema;
//if isnull(ls_pancali) then ls_pancali = 'N'
//if isnull(ll_id_cat_imb) then ll_id_cat_imb = 0
//
//if ls_pancali = 'S' then
//	DATASTORE ds_eva_imb_app	
//	ds_eva_imb_app = CREATE DATASTORE
//	ds_eva_imb_app.DATAOBJECT = "ds_eva_imb_app"
//	ds_eva_imb_app.SETTRANSOBJECT(SQLCA)			
//end if
	
lb_ricc = false
lb_descr = false

ll_size = upperbound(astr_par.s_dbn)

ll_id_loc_1=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_locazione_1")
ll_id_loc_2=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_locazione_2")

datastore ds_orafo_riga
ds_orafo_riga=create datastore
ds_orafo_riga.dataobject="ds_orafo_riga_deriva"
ds_orafo_riga.settransobject(sqlca)


ll_id_doc=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_documento")
ll_righe_esistenti=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
if ll_righe_esistenti<0 then ll_righe_esistenti=0
if ll_righe_esistenti=1 then
	ll_id_articolo = a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemNumber(1, "riga_documento_id_articolo")
	ls_des_articolo = a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemString(1, "riga_documento_descrizione")
	If IsNull(ll_id_articolo) and IsNull(ls_des_articolo) Then
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.deleterow(1)
		ll_righe_esistenti=0
	end if
end if			
ll_id_sog_commerciale = a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "id_sog_commerciale")
select id_tab_iva
into :ll_id_tab_iva
from sog_commerciale
where id_sog_commerciale=:ll_id_sog_commerciale;

for ll_count = 1 to ll_size
	

	ll_idriga = long(astr_par.s_dbn[ll_count])
	ll_idcaus = long(astr_par.s_dbt[ll_count])
	if ll_idcaus <= 0 or isNull(ll_idcaus) then 
		ll_idcaus = long(a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.uf_get_colval("documento_id_caus_magazzino"))
	end if
	if ll_idcaus <= 0 then SetNull(ll_idcaus)
	
	select 1 
	into :ll_test_orafo
	from orafo_par_sistema;
	if sqlca.sqlcode<0 then
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
			 "riga_documento"."id_conto",					"riga_documento"."id_azienda",
			 "riga_documento"."id_riga_lotto",
	
			 "riga_documento"."provv_imp_agente", "riga_documento"."provv_imp_subage",
			 "riga_documento"."provv_imp_carea", "riga_documento"."id_gruppo_agenti_2",
			 "riga_documento"."provv_agente_2", "riga_documento"."provv_subage_2",
			 "riga_documento"."provv_carea_2", "riga_documento"."provv_imp_agente_2", 
			 "riga_documento"."provv_imp_subage_2", "riga_documento"."provv_imp_carea_2",
	
			 a.codice		
	
	INTO	:ll_idart, :ls_descr, :ll_iddes, :ll_idunc, :ld_fcub, :ld_fcgl,
			:ll_idl1,  :ll_idl2,  :ll_idval, :ld_camb,  :ll_idlis, :ll_idcla,
			:ld_prez,  :ls_scon,  :ld_scri,  :ldt_cns, :ld_psnt,  :ld_pslo,
			:ld_diml,  :ld_dimh,  :ld_dimp,  :ld_numc, :ll_idiva, :ll_idage,
			:ld_prv1,  :ld_prv2,  :ld_prv3,  :ld_vatt,  :ll_idctr,
			:ldt_dic,  :ldt_dfc,  :ll_idcpt, :ll_idazi, :ll_id_r_lotto,
	
			:ld_prv_imp1,  :ld_prv_imp2,  :ld_prv_imp3,
			:ll_idage_2, :ld_prv1_2, :ld_prv2_2, :ld_prv3_2, 
			:ld_prv_imp1_2,  :ld_prv_imp2_2,  :ld_prv_imp3_2,
	
			:ls_cod_articolo		
	FROM "dba"."riga_documento", articolo a
	WHERE "riga_documento"."id_riga_documento" = :ll_idriga
	AND	a.id_articolo =* riga_documento.id_articolo		
	;
		
	if SQLCA.SQLCode = 0 then
		
		
//		if ls_pancali = 'S' then
//			long ll_found
//			decimal ld_qta_saldo
//			date ld_data_doc
//			
//			lb_ok = false
//			ll_ret = 0 
//			ll_saldo = 0
//			
//			select id_cat_com_articolo 
//			into :ll_id_cat_art
//			from articolo
//			where id_articolo = :ll_idart;
//			
//			ld_data_doc = a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemdate(1, "data_documento") 
//			if isnull(ld_data_doc) then ld_data_doc = a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemdate(1, "data_registrazione") 
//			
//			if ll_id_cat_art = ll_id_cat_imb then
//				ll_id_sog_commerciale = a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "id_sog_commerciale")
//				ll_id_prof_documento= a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "id_prof_documento")
//				SELECT segno  
//				INTO	:ls_segno
//				FROM	tab_prof_imb
//				WHERE	id_prof_documento = :ll_id_prof_documento ;					
//				if isnull(ls_segno) then ls_segno = '-'
//				if ls_segno = '+' then
//					ll_found = ds_eva_imb_app.find("id_sog_com = " + string(ll_id_sog_commerciale) + " and id_art_imb = " + string(ll_idart), 0 , ds_eva_imb_app.rowcount())
//					
//					if ll_found <= 0 then 
//						DATASTORE ds_saldo_imb 
//						ds_saldo_imb = CREATE DATASTORE
//						ds_saldo_imb.DATAOBJECT = "ds_saldo_imb"
//						ds_saldo_imb.SETTRANSOBJECT(SQLCA)					
//						ll_ret = ds_saldo_imb.retrieve(ll_id_sog_commerciale, ll_idart, ld_data_doc) 
//						if ll_ret > 0 then 
//							ll_saldo = ds_saldo_imb.getitemnumber(1,"saldo") 
//							if not isnull(ll_saldo) and ll_saldo < 0 then 
//								ll_row = ds_eva_imb_app.insertrow(0)
//								ds_eva_imb_app.setitem(ll_row,"id_sog_com",ll_id_sog_commerciale)
//								ds_eva_imb_app.setitem(ll_row,"id_art_imb",ll_idart)
//								
//								ld_qta_saldo = dec(abs(ll_saldo))
//								if dec(astr_par.s_op[ll_count]) >= ld_qta_saldo then
//									astr_par.s_op[ll_count] = string(ld_qta_saldo)
//									ds_eva_imb_app.setitem(ll_row,"saldo",0)
//								else
//									ds_eva_imb_app.setitem(ll_row,"saldo",(ld_qta_saldo - dec(astr_par.s_op[ll_count])))					
//								end if			
//								
//								lb_ok = true
//							end if
//						end if
//						destroy ds_saldo_imb
//					else
//						ld_qta_saldo = ds_eva_imb_app.getitemnumber(ll_found,"saldo")
//						if ld_qta_saldo > 0 then
//							if dec(astr_par.s_op[ll_count]) >= ld_qta_saldo then
//								astr_par.s_op[ll_count] = string(ld_qta_saldo)
//								ds_eva_imb_app.setitem(ll_found,"saldo",0)
//								lb_ok = true
//							else
//								ds_eva_imb_app.setitem(ll_found,"saldo",(ld_qta_saldo - dec(astr_par.s_op[ll_count])))					
//								lb_ok = true						
//							end if		
//						else
//							lb_ok = false
//						end if
//					end if			
//				else
//					lb_ok = true
//				end if
//			else
//				lb_ok = true
//			end if
//		else 
//			lb_ok = true
//		end if			
		
		lb_ok = true
		if lb_ok = true then
		
		
			ll_id_riga_documento = ll_idriga	
	
						
			riga_in=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
			if riga_in>0 then
				ll_id_articolo = a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemNumber(1, "riga_documento_id_articolo")
				ls_des_articolo = a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemString(1, "riga_documento_descrizione")
			end if
			
			If not (IsNull(ll_id_articolo)) or not (IsNull(ls_des_articolo)) Then
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_insert(0,0)
			Else
				ll_sizeini = 0
			End If
			
			
			ll_row = a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getrow()
			if ll_row > 0 then
				
				
				
				
				
				
				
				lb_descr = true
				
				if (not isNull(astr_par.s_op[ll_count])) and (dec(astr_par.s_op[ll_count])<>0) then
					lb_descr = false
				end if
				
				if (not isNull(astr_par.s_dbv[ll_count])) and (dec(astr_par.s_dbv[ll_count])<>0) then
					lb_descr = false
				end if
				
				if (not isNull(ld_prez)) and (ld_prez<>0) then
					lb_descr = false
				end if
				
				if (not isNull(ld_scri)) and (ld_scri<>0) then
					lb_descr = false
				end if
				
				
				
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_articolo",ll_idart)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"c_articolo_cod", ls_cod_articolo) 
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_descrizione",ls_descr)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_des_articolo",ll_iddes)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_unita_confezione",ll_idunc)
				
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"quantita",dec(astr_par.s_op[ll_count]))
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"qta_sconto_merce",dec(astr_par.s_dbv[ll_count]))
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"qta_evasa",0)
		
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_fat_con_unita_base",ld_fcub)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"fat_con_globale",ld_fcgl)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_caus_magazzino",ll_idcaus)
				
	
	
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"id_locazione_1",ll_id_loc_1)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"id_locazione_2",ll_id_loc_2)
				
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_valuta",ll_idval)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_cambio",ld_camb)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_listino",ll_idlis)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_con_lis_articolo",ll_idcla)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"prezzo",ld_prez)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"sconto",ls_scon)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_sconto_riga",ld_scri)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_data_prevista_consegna",ldt_cns)
				ld_psnt=f_round(Dec(astr_par.orafo_peso_ev[ll_count]), -2, 'M')
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_peso_netto",ld_psnt)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_peso_lordo",ld_pslo)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_dim_l",ld_diml)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_dim_h",ld_dimh)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_dim_p",ld_dimp)
				
				
				
				
				long ll_colli_uc
				string ls_tipoum
				
				select num_colli
				into :ll_colli_uc
				from unita_confezione
				where id_unita_confezione = :ll_idunc;
				if isnull(ll_colli_uc) or ll_colli_uc = 0 then					
				else
					SELECT m.tipo
					INTO	 :ls_tipo
					FROM	 unita_misura m, unita_confezione u
					WHERE	 u.id_unita_confezione = :ll_idunc
					AND	 m.id_unita_misura = u.id_unita_misura
					;
					
					if (ls_tipoum = 'P') then					
						ld_numc = ld_psnt * ll_colli_uc
					else
						ld_numc = dec(astr_par.s_op[ll_count]) * ll_colli_uc
					end if
				end if				
				
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_num_colli",ld_numc)									
				
				
				
				if (ll_id_r_lotto > 0 and not isnull(ll_id_r_lotto)) then a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"id_riga_lotto",ll_id_r_lotto)
				
				
				
				
				if a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_riga_documento_ordine_lotti_gd" &
				or a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.dataobject="d_riga_documento_ordine_ritorno_gd" then
					if Not(IsNull(ll_id_r_lotto)) then
						if not(lb_descr) then
							select lotto.cod_esterno, lotto.data_scadenza
							into :ls_cod_lotto, :ld_data_lotto
							from riga_doc_lotto, lotto
							where(riga_doc_lotto.id_riga_lotto=:ll_id_r_lotto)
							and(riga_doc_lotto.id_lotto=lotto.id_lotto);
							a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"cod_lotto",ls_cod_lotto)
							a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"data_scadenza",ld_data_lotto)
						end if
					end if
				end if
				
	
				
				
				
				
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_tab_iva",ll_idiva)
				if not lb_descr then
					
					If a_win_doc.is_contr_esen_der ="S" then
						
						If not IsNull(ll_idiva) then
							
							ls_Prec_Esenzione=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemString(a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetRow(),"creato_in_esenzione")
							If IsNull(ls_Prec_Esenzione) then ls_Prec_Esenzione=""
							
							SELECT "documento"."creato_in_esenzione"  
								INTO :ls_Att_Esenzione  
								FROM 	"dba"."documento",   
										"dba"."riga_documento" 
								WHERE ( "riga_documento"."id_documento" = "documento"."id_documento" ) and  
										( ( "riga_documento"."id_riga_documento" = :ll_idriga ) )   ;
							If IsNull(ls_Att_Esenzione) then ls_Att_Esenzione = ""
							
							If ls_Prec_Esenzione = "S" then
								If ls_Att_Esenzione = "S" then
									
									SELECT "articolo"."id_tab_iva"  
										INTO :ll_Id_tab_Iva 
										FROM "dba"."articolo"  
										WHERE "articolo"."id_articolo" = :ll_idart ;
									a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_tab_iva",ll_Id_tab_Iva)
								else
									
									a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_tab_iva",ll_idiva)
								end if
							else
								If ls_Att_Esenzione = "S" then
									
									SELECT "sog_commerciale"."id_tab_iva"  
										INTO :ll_Id_tab_Iva
										FROM 	"dba"."documento",   
												"dba"."riga_documento",   
												"dba"."sog_commerciale"  
										WHERE ( "riga_documento"."id_documento" = "documento"."id_documento" ) and  
												( "sog_commerciale"."id_sog_commerciale" = "documento"."id_sog_commerciale" ) and  
												( ( "riga_documento"."id_riga_documento" = :ll_idriga ) ) ;
										
									a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_tab_iva",ll_Id_tab_Iva)
								else
									
									a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_tab_iva",ll_idiva)
								end if
							end if
						end if
					end if
				end if
		
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"id_gruppo_agenti",ll_idage)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"provv_agente",ld_prv1)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"provv_subage",ld_prv2)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"provv_carea",ld_prv3)
				
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"provv_imp_agente",ld_prv_imp1)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"provv_imp_subage",ld_prv_imp2)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"provv_imp_carea",ld_prv_imp3)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_gruppo_agenti_2",ll_idage_2)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_provv_agente_2",ld_prv1_2)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_provv_subage_2",ld_prv2_2)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_provv_carea_2",ld_prv3_2)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_provv_imp_agente_2",ld_prv_imp1_2)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_provv_imp_subage_2",ld_prv_imp2_2)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_provv_imp_carea_2",ld_prv_imp3_2)
				
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_val_attribuito",ld_vatt)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_caus_trasporto",ll_idctr)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_forza_chius_evasione","N")
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_sospesa","N")
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_da_stampare","S")
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_data_inizio_competenza",ldt_dic)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_data_fine_competenza",ldt_dfc)
				
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"id_riga_doc_provenienza",ll_idriga)
				
				
				a_win_doc.wf_inf_aggiuntive(ll_idunc,ll_ROW,ll_idart)	
				
			
				
				
				
				
				
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_azienda",ll_idazi)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_conto",ll_idcpt)
				lb_tengo = true
				if not lb_descr then
					
					If IsNull(ll_idcpt) OR ll_idcpt=0 then 
						ll_id_sog_commerciale = a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "id_sog_commerciale")
						ll_id_agente = a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "id_gruppo_agenti")
						
						ll_idcpt = a_win_doc.wf_calcola_cpt(ll_id_sog_commerciale, ll_id_agente, ll_idart,ll_idcaus)
					end if
					
					IF ll_idcpt=0 OR ISNULL(ll_idcpt) THEN
							SELECT "par_sistema"."id_conto_predefinito"  
							INTO :ll_idcpt  
							FROM "dba"."par_sistema"  
							WHERE "par_sistema"."id_azienda" = :ll_idazi ;
					END IF
					
					
					If IsNull(ll_idcpt) OR ll_idcpt=0 then 
			
						
						ll_id_prof_documento= a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "id_prof_documento")
						SELECT	"prof_documento"."contabilizzabile"  
							INTO	:ls_Contabilizzabile 
							FROM	"dba"."prof_documento"  
							WHERE	"prof_documento"."id_prof_documento" = :ll_id_prof_documento ;	
							
						If SQLCA.SQLCode <>0 then
							MessageBox("SQL ERROR","Errore in w_new_doc / uf_importa_righe ")
							lb_tengo = false
						end if
						If ls_Contabilizzabile="S" then lb_tengo = false
					end if
				end if
				
				
				if lb_tengo then
					
					a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_conto",ll_idcpt)
					a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"riga_documento_id_azienda",ll_idazi)
					
					select unita_misura.simbolo, unita_misura.tipo
					into :ls_simbolo, :ls_tipo
					from unita_misura,unita_confezione
					where unita_confezione.id_unita_confezione=:ll_idunc
					and unita_confezione.id_unita_misura=unita_misura.id_unita_misura;
	
	
	
	
	
	
	
	
	
	
	
	
	
					a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"tipo_um",ls_tipo)
		
					
					
					a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_riga(ll_row)
					ll_rows[ll_row] = ll_count
				else
					
					If IsNull(ll_idcpt) OR ll_idcpt=0 then 
						Messagebox("ATTENZIONE", "La riga Nr. ("+string(ll_count)+") Non Può essere Derivata ~r~n Non Esiste Nessuna Contropartita Per Questa Riga")
					end if
					a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.DeleteRow(ll_row)
				end if
				
				
				
				
			end if
		end if 
	end if
else
	ll_test_orafo_1=1
	ll_test_orafo=ds_orafo_riga.retrieve(ll_idriga)
	
		ll_row=ll_righe_esistenti+ll_count
		
		ll_test_orafo=ds_orafo_riga.rowscopy&
		(1,1, primary!, a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd,ll_row, primary!)
		if ll_test_orafo<=0 then messagebox("Errore!", "Riga non copiata")
		
		
		if ll_count=1 then
			ld_cambio_attuale=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemdecimal(1, "documento_cambio")
			ld_camb=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
			(ll_row, "riga_documento_cambio")
//			ld_cambio_attuale=round(1/ld_cambio_attuale, 4)
			
			if ld_cambio_attuale<>round(ld_camb, 4) then
				
				li_ret=messagebox("Attenzione!", "Il cambio impostato in fattura è diverso "&
				+"da quello della bolla che si sta derivando.~r~n Scegliere 'Sì' per"&
				+" usare il cambio della Fattura, 'No' per quello della bolla",stopsign!, yesno!)
				if li_ret=2 then
					ld_cambio_attuale=ld_camb
//					a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1, "documento_cambio",1/ld_cambio_attuale)
					a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1, "documento_cambio",ld_cambio_attuale)
					uf_calcola_cambio_derivazione(ld_cambio_attuale, a_win_doc)
				end if
			else
				
			end if
		end if
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
			(ll_row, "riga_documento_cambio", ld_cambio_attuale)
		
		
		
		
		li_max=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber&
		(1, "c_max_num")
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "riga_documento_num_riga", li_max+1)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "riga_documento_id_caus_magazzino",ll_idcaus)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_documento",ll_id_doc)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_riga_documento",ll_null)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_locazione_1",ll_id_loc_1)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_locazione_2",ll_id_loc_2)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_riga_doc_provenienza",ll_idriga)

		
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_riga_partita",ll_null)
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_tipo_partita",ll_null)
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "cod_tipo_partita",'')
		
		
		
		ld_psnt=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemdecimal(ll_row,"riga_documento_peso_netto")
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"valoriz_peso_non_prezioso", ld_psnt)
			
		
		if isnull(astr_par.orafo_peso_ev[ll_count]) then astr_par.orafo_peso_ev[ll_count]="0"
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"riga_documento_peso_netto",Dec(astr_par.orafo_peso_ev[ll_count]))
		
		ld_psnt=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(ll_row, "riga_documento_peso_netto")
		
		
		if ld_psnt<>Dec(astr_par.orafo_peso_ev[ll_count]) then
			ld_fino=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(ll_row, "fino")
			ld_calo=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(ll_row, "calo")
			if ld_psnt=0 or isnull(ld_psnt) then
				ld_fino=0
				ld_calo=0
			else
				ld_fino=ld_fino*Dec(astr_par.orafo_peso_ev[ll_count])/ld_psnt
				ld_calo=ld_calo*Dec(astr_par.orafo_peso_ev[ll_count])/ld_psnt
			end if
			
			a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"fino", ld_fino)
			
			a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"calo", ld_calo)
		end if
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"peso_netto_evaso",0)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"qta_sconto_merce",dec(astr_par.s_dbv[ll_count]))
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"quantita",dec(astr_par.s_op[ll_count]))
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"qta_evasa",0)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"qta_evasa_un_base",0)
		
		
		if ll_id_tab_iva>0 then
			a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
												(ll_row,"riga_documento_id_tab_iva",ll_id_tab_iva)
		end if
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_riga(ll_row)
		
	
end if
	
next
destroy ds_orafo_riga
if ll_test_orafo_1<> 1 then
	ll_size = a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
	for ll_count = ll_sizeini + 1 To ll_size
		if astr_par.s_mio[ll_rows[ll_count]] = "S" then
			ll_id_riga_documento = long( astr_par.s_dbn[ll_rows[ll_count]] )
			 a_win_doc.post wf_update_riga ( ll_id_riga_documento, "S" )
		end if
	next
else
	a_win_doc.cbx_simbolo.triggerevent(clicked!)
end if

//if ls_pancali = 'S' then destroy ds_eva_imb_app	

end subroutine

public subroutine uf_importa_righe (s_par_der_doc astr_par, ref w_new_doc a_win_doc);
long		ll_size, ll_count, ll_row, ll_id_prof_documento, ll_id_riga_documento
boolean	lb_ricc, lb_Ok, lb_descr, lb_tengo

long		ll_idriga, ll_idart, ll_iddes, ll_idunc,ll_idcaus, ll_id_sog_commerciale
long		ll_idl1, ll_idl2, ll_idval, ll_idlis, ll_idcla, ll_idiva, ll_id_agente, ll_id_r_lotto
long		ll_idage, ll_idctr, ll_idcpt, ll_idazi, ll_Id_tab_Iva, ll_Id_Sog_Comm
string	ls_descr, ls_scon, ls_Contabilizzabile, ls_cod_lotto
decimal	ld_fcub, ld_fcgl, ld_camb, ld_prez, ld_scri, ld_psnt, ld_pslo, ldc_attuale
decimal	ld_diml, ld_dimh, ld_dimp, ld_numc, ld_prv1, ld_prv2, ld_prv3, ld_vatt
date		ldt_cns, ldt_dic, ldt_dfc, ld_data_lotto
string	ls_Prec_Esenzione, ls_Att_Esenzione, ls_simbolo, ls_tipo
long		ll_rows[], ll_id_loc_1, ll_id_loc_2

decimal  ld_prv_imp1,  ld_prv_imp2,  ld_prv_imp3
decimal	ld_prv1_2, ld_prv2_2, ld_prv3_2, ld_prv_imp1_2,  ld_prv_imp2_2,  ld_prv_imp3_2
long 		ll_idage_2
string   ls_cod_articolo		

Long		ll_SizeIni
ll_sizeini =a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
long ll_test_orafo, ll_null, ll_id_doc, ll_test_orafo_1,ll_righe_esistenti
decimal ld_fino, ld_calo
setnull(ll_null)
decimal ld_cambio_attuale, ld_cambio_attuale_2
integer li_ret, li_max, li_storno, li_num_riga_derivata, li_num_riga
Long		ll_id_articolo, riga_in
String	ls_des_articolo
//string ls_pancali, 
string ls_segno, ls_tipo_reg, ls_nocomp, ls_azienda
long ll_id_cat_imb, ll_id_cat_art, ll_ret, ll_saldo, ll_id_reg, ll_id_riga_doc_padre
long ll_id_doc_derivato, ll_riga_2
string ls_prezzi_confermati,ls_des_aggiuntiva , ls_des, ls_cod_azienda
integer li_pos, li_pos2


//select pancali, id_cat_com_art_imb
//into :ls_pancali, :ll_id_cat_imb
//from pers_par_sistema;
//if isnull(ls_pancali) then ls_pancali = 'N'
if isnull(ll_id_cat_imb) then ll_id_cat_imb = 0

//if ls_pancali = 'S' then
//	DATASTORE ds_eva_imb_app	
//	ds_eva_imb_app = CREATE DATASTORE
//	ds_eva_imb_app.DATAOBJECT = "ds_eva_imb_app"
//	ds_eva_imb_app.SETTRANSOBJECT(SQLCA)			
//end if
	
lb_ricc = false
lb_descr = false

ll_size = upperbound(astr_par.s_dbn)

ll_id_loc_1=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_locazione_1")
ll_id_loc_2=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "documento_id_locazione_2")

datastore ds_orafo_riga
ds_orafo_riga=create datastore
ds_orafo_riga.dataobject="ds_orafo_riga_deriva"
ds_orafo_riga.settransobject(sqlca)

//trovo il registro perché se è fattura (IV) non devo derivare componenti esplosi (silver 260110)
ll_id_reg=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_registro")
select tipo_registro
into :ls_tipo_reg
from dba.registro
where id_registro= :ll_id_reg;
//metti campo in orafo_par_sistema: no_comp_in_fattura e saggialo
//select no_comp_in_fattura
//into :ls_nocomp
//from orafo_par_sistema;
select rag_soc_1 into :ls_azienda from dba.azienda;

ll_id_doc=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_documento")
ll_righe_esistenti=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
if ll_righe_esistenti<0 then ll_righe_esistenti=0
if ll_righe_esistenti=1 then
	ll_id_articolo = a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.GetItemNumber(1, "riga_documento_id_articolo")
	ls_des_articolo = a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemString(1, "riga_documento_descrizione")
	If IsNull(ll_id_articolo) and IsNull(ls_des_articolo) Then
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.deleterow(1)
		ll_righe_esistenti=0
	end if
end if			
ll_id_sog_commerciale = a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.GetItemNumber(1, "id_sog_commerciale")
select id_tab_iva
into :ll_id_tab_iva
from sog_commerciale
where id_sog_commerciale=:ll_id_sog_commerciale;

for ll_count = 1 to ll_size
	

	ll_idriga = long(astr_par.s_dbn[ll_count])
	ll_idcaus = long(astr_par.s_dbt[ll_count])
	if ll_idcaus <= 0 or isNull(ll_idcaus) then 
		ll_idcaus = long(a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.uf_get_colval("documento_id_caus_magazzino"))
	end if
	if ll_idcaus <= 0 then SetNull(ll_idcaus)
	
	ll_test_orafo_1=1
	ll_test_orafo=ds_orafo_riga.retrieve(ll_idriga)
	//020914 predno num_riga per riga_documento_2
	li_num_riga_derivata=ds_orafo_riga.getitemnumber(1, "riga_documento_num_riga")
	//020914 fine
	
	//240713 se il doc derivato e controllato nei prezzi (stampato="C" o "X")
	//allora segno le righe altrimenti no
	ll_id_doc_derivato=ds_orafo_riga.getitemnumber(1, "id_documento")
	select stampato
	into :ls_prezzi_confermati
	from dba.documento
	where id_documento=:ll_id_doc_derivato;
	if isnull(ls_prezzi_confermati) then ls_prezzi_confermati="N"
	//fine 240713
		//per silverdreams se è fattura non derivo righe compoennti esplose
		//20260414: modifico e metto davvero SOLO per silverdr...
		select codice into :ls_cod_azienda from dba.azienda;
		if ls_cod_azienda= "SILVERDR" then
			ll_id_riga_doc_padre=ds_orafo_riga.getitemnumber(1, "id_riga_doc_padre")
			if left(ls_tipo_reg, 1)='I' then
				if ll_id_riga_doc_padre>0 then 
					li_storno++
					continue
				end if
			end if
		end if
		
		ll_row=ll_righe_esistenti+ll_count - li_storno
		
		ll_test_orafo=ds_orafo_riga.rowscopy&
		(1,1, primary!, a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd,ll_row, primary!)
		if ll_test_orafo<=0 then messagebox("Errore!", "Riga non copiata")
			
		if ll_count=1 then
			ld_cambio_attuale=a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemdecimal(1, "documento_cambio")
			ld_camb=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal&
			(ll_row, "riga_documento_cambio")
			ld_cambio_attuale_2=round(1/ld_cambio_attuale, 8)  //riattivo proviamo20220325
			
			if round(ld_cambio_attuale_2, 5)<>round(ld_camb, 5) then
				
				li_ret=messagebox("Attenzione!", "Il cambio impostato in fattura è diverso "&
				+"da quello della bolla che si sta derivando.~r~n Scegliere 'Sì' per"&
				+" usare il cambio della Fattura, 'No' per quello della bolla",stopsign!, yesno!)
				if li_ret=2 then
					ld_cambio_attuale=round(1/ld_camb, 5)  //modificato 20220325
//					a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1, "documento_cambio",1/ld_cambio_attuale)
					a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.setitem(1, "documento_cambio",ld_cambio_attuale)
					uf_calcola_cambio_derivazione(ld_camb, a_win_doc)
				end if
			else
				ld_cambio_attuale=round(1/ld_cambio_attuale, 8)
				a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row, "riga_documento_cambio", ld_cambio_attuale)
			end if
		end if
		
	
		//240713 aggiungo flag prezzi confermati
		if ls_prezzi_confermati='C' or ls_prezzi_confermati='X' then
			a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
			(ll_row, "riga_documento_da_stampare", "C")
			
		end if
		//fine 240713
			
		li_max=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemnumber&
		(1, "c_max_num")
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "riga_documento_num_riga", li_max+1)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "riga_documento_id_caus_magazzino",ll_idcaus)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_documento",ll_id_doc)
		//2020 12 19 ordine righe importate in più volte riparte dall'utlimo numero
		if pos(upper(ls_azienda), "SILVER DR")>0 then
			ldc_attuale=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(ll_row, "riga_documento_provv_subage_2")
			if isnull(ldc_attuale) then ldc_attuale=0
			a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row, "riga_documento_provv_subage_2", ldc_attuale+ll_row/100)
			//20220928 se nella descrizione c'è "- BOL: xxxx-XXXXXXX" lo tolgo.. ma solo se il prof dest. è=RBOL  //commentato oil 20221017 non serve più
//			if a_win_doc.tab_1.tabpage_1.dw_documento_ordine_ff.getitemnumber(1, "id_prof_documento")=66   then //66=RBOL
//				ls_des=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemstring(ll_row, "riga_documento_descrizione")
//				li_pos=pos(ls_des, "- BOL")
//				if li_pos>0 then					//- BOL: xxx-
//					li_pos2=pos(ls_des, "-", li_pos+1) 
//					li_pos2+=7 //il numero dopo il "-" è della bollettina ed è lungo 7
//					ls_des=left(ls_des, li_pos - 1)+ " "+right(ls_des, len(ls_des) - li_pos2 - 1)
//					a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem(ll_row, "riga_documento_descrizione", ls_des)
//				end if
//			end if
		end if
		
		
		////020914 se esiste una descrizione aggiuntiva la derivo
		select des_aggiuntiva
		into :ls_des_aggiuntiva
		from dba.riga_documento_2
		where id_documento=:ll_id_doc_derivato
		and num_riga=:li_num_riga_derivata
		;
		li_num_riga=li_max+1
		if ls_des_aggiuntiva>" " then
			a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.scrolltorow(ll_row)
			a_win_doc.wf_ins_riga_2()
			ll_riga_2=a_win_doc.tab_1.tabpage_2.dw_des_aggiuntiva.find("num_riga="+string(li_num_riga), 1, 100000)
			a_win_doc.tab_1.tabpage_2.dw_des_aggiuntiva.setitem(ll_riga_2, "des_aggiuntiva",ls_des_aggiuntiva)
			
		end if
		//020914 fine
		
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_riga_documento",ll_null)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_locazione_1",ll_id_loc_1)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_locazione_2",ll_id_loc_2)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_riga_doc_provenienza",ll_idriga)

		
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_riga_partita",ll_null)
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "id_tipo_partita",ll_null)
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.setitem&
		(ll_row, "cod_tipo_partita",'')
		
		
		
		//ld_psnt=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getItemdecimal(ll_row,"riga_documento_peso_netto")
		//300713 commento perché si è perso il senso della valorizzazione e non si capisce più perché
		//la valorizzazioen sia uguale al peso (legato)!!!
		//a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"valoriz_peso_non_prezioso", ld_psnt)
			
		
		if isnull(astr_par.orafo_peso_ev[ll_count]) then astr_par.orafo_peso_ev[ll_count]="0"
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"riga_documento_peso_netto",Dec(astr_par.orafo_peso_ev[ll_count]))
		
		ld_psnt=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(ll_row, "riga_documento_peso_netto")
		
		
		if ld_psnt<>Dec(astr_par.orafo_peso_ev[ll_count]) then
			ld_fino=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(ll_row, "fino")
			ld_calo=a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.getitemdecimal(ll_row, "calo")
			if ld_psnt=0 or isnull(ld_psnt) then
				ld_fino=0
				ld_calo=0
			else
				ld_fino=ld_fino*Dec(astr_par.orafo_peso_ev[ll_count])/ld_psnt
				ld_calo=ld_calo*Dec(astr_par.orafo_peso_ev[ll_count])/ld_psnt
			end if
			
			a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"fino", ld_fino)
			
			a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem(ll_row,"calo", ld_calo)
		end if
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"peso_netto_evaso",0)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"qta_sconto_merce",dec(astr_par.s_dbv[ll_count]))
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"quantita",dec(astr_par.s_op[ll_count]))
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"qta_evasa",0)
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
		(ll_row,"qta_evasa_un_base",0)
		
		
		if ll_id_tab_iva>0 then
			a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.SetItem&
												(ll_row,"riga_documento_id_tab_iva",ll_id_tab_iva)
		end if
		
		a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.event ue_set_calc_riga(ll_row)
		
next
destroy ds_orafo_riga
if ll_test_orafo_1<> 1 then
	ll_size = a_win_doc.tab_1.tabpage_2.dw_riga_documento_ordine_gd.rowcount()
	for ll_count = ll_sizeini + 1 To ll_size
		if astr_par.s_mio[ll_rows[ll_count]] = "S" then
			ll_id_riga_documento = long( astr_par.s_dbn[ll_rows[ll_count]] )
			 a_win_doc.post wf_update_riga ( ll_id_riga_documento, "S" )
		end if
	next
else
	a_win_doc.cbx_simbolo.triggerevent(clicked!)
end if

//if ls_pancali = 'S' then destroy ds_eva_imb_app	

end subroutine

on u_new_doc_righe.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_new_doc_righe.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

