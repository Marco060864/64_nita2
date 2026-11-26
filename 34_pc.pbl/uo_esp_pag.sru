forward
global type uo_esp_pag from nonvisualobject
end type
type us_app_pag from structure within uo_esp_pag
end type
type us_con_spe from structure within uo_esp_pag
end type
end forward

type us_app_pag from structure
	integer		i_num_rate
	integer		i_giorni_tra_rate
	string		s_tipo_scad
	decimal {0}	d_perc_iva
	decimal {0}	d_perc_imp
	integer		i_giorni_data_dec
	integer		i_giorno_fisso
	string		s_spese_gestite
	decimal {2}	d_perc_tratte
	decimal {0}	d_arr_bollo
	decimal {0}	d_imp_min_bollo
	long		l_id_tipo_pagamento
	decimal {4}	d_imp_fisso
	decimal {4}	d_imp_fisso_iva
end type

type us_con_spe from structure
	integer		i_g_ini_per
	integer		i_m_ini_per
	integer		i_g_fin_per
	integer		i_m_fin_per
	integer		i_g_app
	integer		i_m_app
end type

global type uo_esp_pag from nonvisualobject
end type
global uo_esp_pag uo_esp_pag

forward prototypes
public function long uf_primo_fetch (long al_id_cp, ref us_app_pag astr_app_pag[])
public function date uf_check_data_speciale (date ad_data, us_con_spe astr_con_spe[])
public function long uf_secondo_fetch (long al_id_anag, ref us_con_spe astr_cs[])
public function boolean uf_calcola_pagamenti (decimal ad_imponibile, decimal ad_imposta, date adt_inizio, long al_id_anag, long al_id_cp, ref s_scadenze astr_scadenze)
public function long uf_rate_ges_spesa (long al_id_con_pagamento, string as_spese)
public function date uf_absolutedate (date data_inizio, integer aumenta_giorni)
public function boolean uf_calcola_pagamenti_e (long al_id_valuta, decimal ad_imponibile, decimal ad_imposta, date adt_inizio, long al_id_anag, long al_id_cp, ref s_scadenze astr_scadenze)
end prototypes

public function long uf_primo_fetch (long al_id_cp, ref us_app_pag astr_app_pag[]);

integer		li_er, li_nrows					
integer		li_1, li_2, li_6, li_7			
string		ls_3, ls_8
decimal		ld_4, ld_5, ld_9, ld_10, ld_11,ld_s1,ld_s2
long			ll_12                         
us_app_pag	lstr_app_pag[]						

Declare my_cur cursor for
	SELECT app_pagamento.num_rate, 
			 app_pagamento.giorni_rate,
			 app_pagamento.giorno_scadenza, 
			 app_pagamento.per_iva,
			 app_pagamento.per_imponibile, 
			 app_pagamento.giorni_data_decorrenza,
			 app_pagamento.giorno_fisso, 
			 app_pagamento.importo_fisso,
			 app_pagamento.importo_fisso_iva,
			 tipo_pagamento.spese_gestite,
			 tipo_pagamento.perc_tratte, 
			 tipo_pagamento.arr_bollo_tratta,
			 tipo_pagamento.imp_min_bollo_tratta,
			 tipo_pagamento.id_tipo_pagamento
	FROM app_pagamento, tipo_pagamento
	WHERE (app_pagamento.id_tipo_pagamento = tipo_pagamento.id_tipo_pagamento) and
			(app_pagamento.id_con_pagamento = :al_id_cp)
	USING SQLCA;

open my_cur;

li_er = 0
li_nrows = 0
do 
	fetch my_Cur into :li_1, :li_2, :ls_3, :ld_4, :ld_5, :li_6, :li_7,:ld_s1,:ld_s2, :ls_8, :ld_9, :ld_10, :ld_11, :ll_12 ;
	li_er = sqlca.sqlcode
	if li_er = 0 then
		
		li_nrows ++
		lstr_app_pag[li_nrows].i_num_rate = li_1
		lstr_app_pag[li_nrows].i_giorni_tra_rate = li_2
		lstr_app_pag[li_nrows].s_tipo_scad = ls_3
		lstr_app_pag[li_nrows].d_perc_iva = ld_4
		lstr_app_pag[li_nrows].d_perc_imp = ld_5
		lstr_app_pag[li_nrows].i_giorni_data_dec = li_6
		lstr_app_pag[li_nrows].i_giorno_fisso = li_7
		lstr_app_pag[li_nrows].s_spese_gestite = ls_8
		lstr_app_pag[li_nrows].d_perc_tratte = ld_9
		lstr_app_pag[li_nrows].d_arr_bollo = ld_10
		lstr_app_pag[li_nrows].d_imp_min_bollo = ld_11
		lstr_app_pag[li_nrows].l_id_tipo_pagamento = ll_12
		lstr_app_pag[li_nrows].d_imp_fisso = ld_s1
		lstr_app_pag[li_nrows].d_imp_fisso_iva = ld_s2
		if isnull(ld_s1) then ld_s1=0
		if isnull(ld_s2) then ld_s2=0		
		if (li_6 < 30) then lstr_app_pag[li_nrows].s_tipo_scad = "D"
	else
		
	end if

loop while li_er = 0

close my_cur;

astr_app_pag = lstr_app_pag

return li_nrows

end function

public function date uf_check_data_speciale (date ad_data, us_con_spe astr_con_spe[]);

date			ld_d1, ld_d2, ld_d3, ld_arrivo
integer		li_anno, li_i, li_size
boolean		lb_finito

li_anno = year(ad_data)
li_size = upperbound(astr_con_spe)
ld_arrivo = ad_data

if li_size > 0 then

	li_i = 1
	lb_finito = false
	do while not lb_finito
		
		ld_d1 = date(string(astr_con_spe[li_i].i_g_ini_per)+"-"+string(astr_con_spe[li_i].i_m_ini_per)+"-"+string(li_anno))
		ld_d2 = date(string(astr_con_spe[li_i].i_g_fin_per)+"-"+string(astr_con_spe[li_i].i_m_fin_per)+"-"+string(li_anno))
		ld_d3 = date(string(astr_con_spe[li_i].i_g_app)+"-"+string(astr_con_spe[li_i].i_m_app)+"-"+string(li_anno))
		if ld_d2 < ld_d1 then
			ld_d2 = date(string(astr_con_spe[li_i].i_g_fin_per)+"-"+string(astr_con_spe[li_i].i_m_fin_per)+"-"+string(li_anno+1))
			ld_d3 = date(string(astr_con_spe[li_i].i_g_app)+"-"+string(astr_con_spe[li_i].i_m_app)+"-"+string(li_anno+1))
		end if
		if ld_d3 < ld_d2 then
			ld_d3 = date(string(astr_con_spe[li_i].i_g_app)+"-"+string(astr_con_spe[li_i].i_m_app)+"-"+string(li_anno+1))
		end if
		
		if (ad_data >= ld_d1) and  (ad_data <= ld_d2) then
			ld_arrivo = ld_d3
			lb_finito = true
		end if
		
		li_i ++
		if li_i > li_size then lb_finito = true
	loop

end if

return ld_arrivo

end function

public function long uf_secondo_fetch (long al_id_anag, ref us_con_spe astr_cs[]);


integer		li_er, li_nrows
integer		li_1, li_2, li_3, li_4, li_5, li_6
us_con_spe	lstr_cs[]									

if not isNull(al_id_anag) and (al_id_anag>0) then
	
	Declare my_cur2 cursor for
		select con_spec_scadenza.giorno_inizio_periodo, con_spec_scadenza.mese_inizio_periodo, 
			con_spec_scadenza.giorno_fine_periodo, con_spec_scadenza.mese_fine_periodo,
			con_spec_scadenza.giorno_applicazione, con_spec_scadenza.mese_applicazione
		from con_spec_scadenza
		where con_spec_scadenza.id_anagrafica = :al_id_anag
		using SQLCA;
		
	open my_cur2;

	li_er = 0
	li_nrows = 0
	do 
		fetch my_cur2 into :li_1, :li_2, :li_3, :li_4, :li_5, :li_6 ;
		li_er = sqlca.sqlcode
		if li_er = 0 then
			li_nrows ++
			lstr_cs[li_nrows].i_g_ini_per = li_1
			lstr_cs[li_nrows].i_m_ini_per = li_2
			lstr_cs[li_nrows].i_g_fin_per = li_3
			lstr_cs[li_nrows].i_m_fin_per = li_4
			lstr_cs[li_nrows].i_g_app = li_5
			lstr_cs[li_nrows].i_m_app = li_6
		end if
	loop while li_er = 0		

end if

astr_cs = lstr_cs

return li_nrows

end function

public function boolean uf_calcola_pagamenti (decimal ad_imponibile, decimal ad_imposta, date adt_inizio, long al_id_anag, long al_id_cp, ref s_scadenze astr_scadenze);

integer		a,b,li_napp, li_nspe, li_k
decimal{4}		ld_imponibile[], ld_imposta[], ld_importo, ld_import[]
date			ld_datapag[]
long 			ll_id_tipo_pagamento[] , ll_conto
decimal{4}		ld_1, ld_2, ld_4, ld_5, ld_k1, ld_k2, ld_3
date			ld_d1, ld_d2, ld_vd
integer		li_g1, li_m1, li_a1, li_i1
integer		li_size, li_i, li_j, li_kk, li_kl
long			ll_row


decimal{4} 			ldc_perc_tratte, ldc_perc_totale, ldc_bollo_tot
decimal{4} 			ldc_rata, ldc_imp_tr, ldc_bollo_parz, ldc_bollo[], ldc_arr_bollo_tratta, ldc_imp_min_bollo_tratta
long 				ll_nr_row, ll_id_con_pagamento, ll_num_rate, ll_cur_count

decimal{4} ld_stef1,ld_stef2
ld_stef1=ad_imponibile
ld_stef2=ad_imposta
us_app_pag	lstr_ap[]				
us_con_spe	lstr_cs[]				

li_napp = uf_primo_fetch (al_id_cp, lstr_ap)

li_nspe = uf_secondo_fetch (al_id_anag, lstr_cs)


li_k = 0
for li_i = 1 to li_napp
	
	
	if lstr_ap[li_i].d_imp_fisso>0 or lstr_ap[li_i].d_imp_fisso_iva>0 then
		ad_imponibile=ad_imponibile - lstr_ap[li_i].d_imp_fisso
		ad_imposta=ad_imposta - lstr_ap[li_i].d_imp_fisso_iva
		ld_1=lstr_ap[li_i].d_imp_fisso
		ld_2=lstr_ap[li_i].d_imp_fisso_iva
		ld_stef1=ld_stef1 - ld_1
		ld_stef2=ld_stef2 - ld_2
		if (ld_stef1<0) or ( ld_stef2<0) then
			messagebox("Errore","Errore nell'impostazione delle rate")
			return false
		end if
	else
		ld_1 = ad_imponibile * lstr_ap[li_i].d_perc_imp / 100
		ld_2 = ad_imposta * lstr_ap[li_i].d_perc_iva / 100
		ld_stef1=ld_stef1 - ld_1
		ld_stef2=ld_stef2 - ld_2
		if (ld_stef1<0) or ( ld_stef2<0) then
			messagebox("Errore","Errore nell'impostazione delle rate")
			return false
		end if
	end if
	
	
	
	
	ld_k1 = 100 / double(lstr_ap[li_i].i_num_rate)
	ld_k2 = 0
	ld_4 = 0
	ld_5 = 0
	li_kk = li_k
	
	
	
	
	ldc_perc_tratte= lstr_ap[li_i].d_perc_tratte
	ldc_arr_bollo_tratta = lstr_ap[li_i].d_arr_bollo
	ldc_imp_min_bollo_tratta = lstr_ap[li_i].d_imp_min_bollo
		
		
		if (lstr_ap[1].i_num_rate=3) and (lstr_ap[1].d_perc_imp=100) and mod(ad_imponibile,3)=0 then 
		      ld_imponibile[1] = (ld_1/3)
		      ld_imponibile[2] = (ld_1/3)
		      ld_imponibile[3] = (ld_1/3)
          a=1 
		end if
		
		if (lstr_ap[1].i_num_rate=3) and (lstr_ap[1].d_perc_iva=100) and mod(ad_imposta,3)=0 then
		      ld_imposta[1] = (ld_2/3)
		      ld_imposta[2] = (ld_2/3)
		      ld_imposta[3] = (ld_2/3)
          b=1
		end if
	
	
	
	
		
		for li_j = 1 to lstr_ap[li_i].i_num_rate - 1 
		ld_k2 = ld_k2 + ld_k1
		li_k ++
	
		if a<>1 then
		  
		  
		  ld_imponibile[li_k] = f_round(ld_1 / lstr_ap[li_i].i_num_rate ,2,'M')
		  ld_4 = ld_4 + ld_imponibile[li_k] 
	   end if
		
		if b<>1 then
		  
		  
		  ld_imposta[li_k] = f_round(ld_2 / lstr_ap[li_i].i_num_rate ,2,'M')		  		  
		  ld_5 = ld_5 + ld_imposta[li_k]
	   end if
		
		
		
		
		
	
		
		
		
		
		If Pos(lstr_ap[li_i].s_spese_gestite, "B") > 0 then
		
		
			ld_importo = ld_imponibile[li_k] + ld_imposta[li_k]
			ldc_imp_tr = Ceiling(ld_importo / 10) * 10
			if not (IsNull(ldc_perc_tratte) OR ldc_perc_tratte <= 0) then 
				ldc_bollo_parz= ldc_imp_tr * ldc_perc_tratte / 100
				if not (IsNull(ldc_arr_bollo_tratta) OR ldc_arr_bollo_tratta <=1) then
					ldc_bollo_parz = Round(ldc_bollo_parz / ldc_arr_bollo_tratta, 0) * ldc_arr_bollo_tratta
				end if
				
				if Not(IsNull(ldc_imp_min_bollo_tratta) OR ldc_imp_min_bollo_tratta =0) then 
					ldc_bollo_parz= Max( ldc_bollo_parz, ldc_imp_min_bollo_tratta)
					ldc_bollo[li_k]=ldc_bollo_parz
					ldc_bollo_tot= ldc_bollo_tot + ldc_bollo_parz
				else
					ldc_bollo[li_k]= 0
				end if
			else
				ldc_bollo[li_k]= 0
			end if
		else
			ldc_bollo[li_k]= 0
		end if
		
		ll_id_tipo_pagamento[li_k] = lstr_ap[li_i].l_id_tipo_pagamento	
		
	next


	
	
	
		
	
	
	
	
	
	ld_k1 = 100 - ld_k2
	li_k ++
	
	if a<>1 then
	  ld_imponibile[li_k] = ld_1 - ld_4
   end if
	if b<>1 then
	  ld_imposta[li_k] = ld_2 - ld_5
   end if
	
	
	
	
	
	
	
	
	
	
	
	ll_id_tipo_pagamento[li_k] = lstr_ap[li_i].l_id_tipo_pagamento		

	If Pos(lstr_ap[li_napp].s_spese_gestite, "B") > 0 then
		
		
		
         ld_importo= ld_imponibile[li_k] + ld_imposta[li_k]
       	ldc_imp_tr= Ceiling(ld_importo / 10) * 10
		if not (IsNull(ldc_perc_tratte) OR ldc_perc_tratte <= 0) then 
			ldc_bollo_parz= ldc_imp_tr * ldc_perc_tratte / 100
			if not (IsNull(ldc_arr_bollo_tratta) OR ldc_arr_bollo_tratta <=0) then
				ldc_bollo_parz = Round(ldc_bollo_parz / ldc_arr_bollo_tratta, 0) * ldc_arr_bollo_tratta
			end if
			
			if Not(IsNull(ldc_imp_min_bollo_tratta) OR ldc_imp_min_bollo_tratta =0) then 
				ldc_bollo_parz= Max( ldc_bollo_parz, ldc_imp_min_bollo_tratta)
				ldc_bollo[li_k]=ldc_bollo_parz
				ldc_bollo_tot= ldc_bollo_tot + ldc_bollo_parz
			else
				ldc_bollo[li_k]= 0
			end if
		else
			ldc_bollo[li_k]= 0
		end if
	else
		ldc_bollo[li_k]= 0
	end if

	
	ld_d1 = uf_absolutedate (adt_inizio,lstr_ap[li_i].i_giorni_data_dec)
	li_i1 = 1
	li_kl = li_kk
	do
		ld_vd = ld_d1
		f_date2ymd(ld_d1,li_a1,li_m1,li_g1)
		
		
		
		if lstr_ap[li_i].s_tipo_scad = "M" then
			
			li_g1 = f_gmese(li_m1,li_a1)
			
			
			
			ld_vd = date(string(li_g1)+"-"+string(li_m1)+"-"+string(li_a1))
			
			
		end if
		
		if lstr_ap[li_i].s_tipo_scad = "F" then
			
			if li_g1 > lstr_ap[li_i].i_giorno_fisso then
				li_m1 ++
				if li_m1>12 then
					li_m1 = 1
					li_a1 ++
					
					
				end if
			end if
			li_g1 = lstr_ap[li_i].i_giorno_fisso
			ld_vd = date(string(li_g1)+"-"+string(li_m1)+"-"+string(li_a1))
		end if
		
	
	
	
		ld_datapag[li_kl+li_i1] = ld_vd
		li_i1 ++
		ld_d1 = uf_absolutedate ( ld_d1, lstr_ap[li_i].i_giorni_tra_rate )
		
		
	loop while li_i1 <= lstr_ap[li_i].i_num_rate
next

li_size = upperbound(ld_datapag)
for li_i = 1 to li_size
	ld_d1 = ld_datapag[li_i]
	ld_vd = uf_check_data_speciale(ld_d1,lstr_cs)
	ld_datapag[li_i] = ld_vd
next


li_size = upperbound(ld_datapag)
for li_i = 1 to li_size
	
	astr_scadenze.dc_imp_out[li_i] = ld_imponibile[li_i]
	astr_scadenze.dc_iva_out[li_i] = ld_imposta[li_i]
	astr_scadenze.d_date[li_i] = ld_datapag[li_i]
	astr_scadenze.dc_bollo[li_i] = ldc_bollo[li_i]
	astr_scadenze.l_id_tipo_pagamento[li_i] = ll_id_tipo_pagamento[li_i]
	
next
astr_scadenze.dc_bollo_tot= ldc_bollo_tot
return true

end function

public function long uf_rate_ges_spesa (long al_id_con_pagamento, string as_spese);long ll_num_rate
string ls_spesa

ls_spesa= '%' + as_spese + '%'
SELECT Sum("app_pagamento"."num_rate" )
	INTO :ll_num_rate  
	FROM "app_pagamento",   
		"tipo_pagamento"  
	WHERE ( "tipo_pagamento"."id_tipo_pagamento" = "app_pagamento"."id_tipo_pagamento" ) and  
		( ( "app_pagamento"."id_con_pagamento" = :al_id_con_pagamento ) AND  
		( ( "tipo_pagamento"."spese_gestite" LIKE  :ls_spesa ) ) )   ;

if SQLCA.SQLCode = 0 AND not IsNull(ll_num_rate) then
		RETURN ll_num_rate
else
		RETURN 0
end if
end function

public function date uf_absolutedate (date data_inizio, integer aumenta_giorni);
integer 	li_inc_mese, li_anno,li_giorno,li_mese, inc_mese
date		ld_rit_data


if mod (aumenta_giorni, 30) = 0 then

	inc_mese = aumenta_giorni / 30
	f_date2ymd ( data_inizio, li_anno, li_mese, li_giorno )
	li_mese = li_mese + inc_mese
	if li_mese > 12 then
		li_mese = li_mese - 12
		li_anno ++
	end if
	if li_giorno > f_gmese(li_mese, li_anno) then 
		li_giorno = f_gmese(li_mese, li_anno)
		if (li_giorno<>29 and li_giorno<>28) and li_giorno<>0 then li_giorno=30
	end if
	ld_rit_data = date(string(li_giorno)+"-"+string(li_mese)+"-"+string(li_anno))
else
	ld_rit_data = relativedate ( data_inizio, aumenta_giorni )
end if

return ld_rit_data
end function

public function boolean uf_calcola_pagamenti_e (long al_id_valuta, decimal ad_imponibile, decimal ad_imposta, date adt_inizio, long al_id_anag, long al_id_cp, ref s_scadenze astr_scadenze);integer		a,b,li_napp, li_nspe, li_k
decimal{4}		ld_imponibile[], ld_imposta[], ld_importo, ld_import[]
date			ld_datapag[]
long 			ll_id_tipo_pagamento[] , ll_conto
decimal{4}		ld_1, ld_2, ld_4, ld_5, ld_k1, ld_k2, ld_3
date			ld_d1, ld_d2, ld_vd
integer		li_g1, li_m1, li_a1, li_i1
integer		li_size, li_i, li_j, li_kk, li_kl
long			ll_row
decimal{4} 			ldc_perc_tratte, ldc_perc_totale, ldc_bollo_tot
decimal{4} 			ldc_rata, ldc_imp_tr, ldc_bollo_parz, ldc_bollo[], ldc_arr_bollo_tratta, ldc_imp_min_bollo_tratta
long 				ll_nr_row, ll_id_con_pagamento, ll_num_rate, ll_cur_count
long ll_dec_sig, ll_arrot
decimal{4} ld_stef1,ld_stef2
us_app_pag	lstr_ap[]				
us_con_spe	lstr_cs[]

ll_dec_sig = 0

select dec_significativi, cifra_arrotondamento
into :ll_dec_sig, :ll_arrot
from valuta
where id_valuta = :al_id_valuta;

ld_stef1=ad_imponibile
ld_stef2=ad_imposta

li_napp = uf_primo_fetch (al_id_cp, lstr_ap)
li_nspe = uf_secondo_fetch (al_id_anag, lstr_cs)
li_k = 0
for li_i = 1 to li_napp
	if lstr_ap[li_i].d_imp_fisso>0 or lstr_ap[li_i].d_imp_fisso_iva>0 then
		ad_imponibile=ad_imponibile - lstr_ap[li_i].d_imp_fisso
		ad_imposta=ad_imposta - lstr_ap[li_i].d_imp_fisso_iva
		ld_1=lstr_ap[li_i].d_imp_fisso
		ld_2=lstr_ap[li_i].d_imp_fisso_iva
		ld_stef1=ld_stef1 - ld_1
		ld_stef2=ld_stef2 - ld_2
		if (ld_stef1<0) or ( ld_stef2<0) then
			messagebox("Errore","Errore nell'impostazione delle rate")
			return false
		end if
	else
		ld_1 = ad_imponibile * lstr_ap[li_i].d_perc_imp / 100
		ld_2 = ad_imposta * lstr_ap[li_i].d_perc_iva / 100
		ld_stef1=ld_stef1 - ld_1
		ld_stef2=ld_stef2 - ld_2
		if (ld_stef1<0) or ( ld_stef2<0) then
			messagebox("Errore","Errore nell'impostazione delle rate")
			return false
		end if
	end if
	ld_k1 = 100 / double(lstr_ap[li_i].i_num_rate)
	ld_k2 = 0
	ld_4 = 0
	ld_5 = 0
	li_kk = li_k
	ldc_perc_tratte= lstr_ap[li_i].d_perc_tratte
	ldc_arr_bollo_tratta = lstr_ap[li_i].d_arr_bollo
	ldc_imp_min_bollo_tratta = lstr_ap[li_i].d_imp_min_bollo
	if (lstr_ap[1].i_num_rate=3) and (lstr_ap[1].d_perc_imp=100) and mod(ad_imponibile,3)=0 then 
	      ld_imponibile[1] = (ld_1/3)
	      ld_imponibile[2] = (ld_1/3)
	      ld_imponibile[3] = (ld_1/3)
         a=1 
	end if
		
	if (lstr_ap[1].i_num_rate=3) and (lstr_ap[1].d_perc_iva=100) and mod(ad_imposta,3)=0 then
	      ld_imposta[1] = (ld_2/3)
	      ld_imposta[2] = (ld_2/3)
	      ld_imposta[3] = (ld_2/3)
         b=1
	end if
	for li_j = 1 to lstr_ap[li_i].i_num_rate - 1 
		ld_k2 = ld_k2 + ld_k1
		li_k ++
	
		if a<>1 then
		  ld_imponibile[li_k] = f_round(ld_1 / lstr_ap[li_i].i_num_rate ,ll_arrot,'M')
		  ld_4 = ld_4 + ld_imponibile[li_k] 
	   end if
		if b<>1 then
		  ld_imposta[li_k] = f_round(ld_2 / lstr_ap[li_i].i_num_rate ,ll_arrot,'M')
		  ld_5 = ld_5 + ld_imposta[li_k]
	   end if
		If Pos(lstr_ap[li_i].s_spese_gestite, "B") > 0 then
			ld_importo = ld_imponibile[li_k] + ld_imposta[li_k]
			ldc_imp_tr = Ceiling(ld_importo / 10) * 10
			if not (IsNull(ldc_perc_tratte) OR ldc_perc_tratte <= 0) then 
				ldc_bollo_parz= ldc_imp_tr * ldc_perc_tratte / 100
				if not (IsNull(ldc_arr_bollo_tratta) OR ldc_arr_bollo_tratta <=1) then
					ldc_bollo_parz = Round(ldc_bollo_parz / ldc_arr_bollo_tratta, ll_dec_sig) * ldc_arr_bollo_tratta
				end if
				if Not(IsNull(ldc_imp_min_bollo_tratta) OR ldc_imp_min_bollo_tratta =0) then 
					ldc_bollo_parz= Max( ldc_bollo_parz, ldc_imp_min_bollo_tratta)
					ldc_bollo[li_k]=ldc_bollo_parz
					ldc_bollo_tot= ldc_bollo_tot + ldc_bollo_parz
				else
					ldc_bollo[li_k]= 0
				end if
			else
				ldc_bollo[li_k]= 0
			end if
		else
			ldc_bollo[li_k]= 0
		end if
		ll_id_tipo_pagamento[li_k] = lstr_ap[li_i].l_id_tipo_pagamento	
	next
	ld_k1 = 100 - ld_k2
	li_k ++
	
	if a<>1 then
	  ld_imponibile[li_k] = ld_1 - ld_4
   end if
	if b<>1 then
	  ld_imposta[li_k] = ld_2 - ld_5
   end if
	ll_id_tipo_pagamento[li_k] = lstr_ap[li_i].l_id_tipo_pagamento		
	If Pos(lstr_ap[li_napp].s_spese_gestite, "B") > 0 then
      ld_importo= ld_imponibile[li_k] + ld_imposta[li_k]
     	ldc_imp_tr= Ceiling(ld_importo / 10) * 10
		if not (IsNull(ldc_perc_tratte) OR ldc_perc_tratte <= 0) then 
			ldc_bollo_parz= ldc_imp_tr * ldc_perc_tratte / 100
			if not (IsNull(ldc_arr_bollo_tratta) OR ldc_arr_bollo_tratta <=0) then
				ldc_bollo_parz = Round(ldc_bollo_parz / ldc_arr_bollo_tratta, ll_dec_sig) * ldc_arr_bollo_tratta
			end if
			if Not(IsNull(ldc_imp_min_bollo_tratta) OR ldc_imp_min_bollo_tratta =0) then 
				ldc_bollo_parz= Max( ldc_bollo_parz, ldc_imp_min_bollo_tratta)
				ldc_bollo[li_k]=ldc_bollo_parz
				ldc_bollo_tot= ldc_bollo_tot + ldc_bollo_parz
			else
				ldc_bollo[li_k]= 0
			end if
		else
			ldc_bollo[li_k]= 0
		end if
	else
		ldc_bollo[li_k]= 0
	end if
	ld_d1 = uf_absolutedate (adt_inizio,lstr_ap[li_i].i_giorni_data_dec)
	li_i1 = 1
	li_kl = li_kk
	do
		ld_vd = ld_d1
		f_date2ymd(ld_d1,li_a1,li_m1,li_g1)
		if lstr_ap[li_i].s_tipo_scad = "M" then
			li_g1 = f_gmese(li_m1,li_a1)
			ld_vd = date(string(li_g1)+"-"+string(li_m1)+"-"+string(li_a1))
		end if
		//se è dal primo del mese, il giorno fisso va esattamente nel mese che è stato calcolato
		//quindi occorre solo cambiare il giorno della data trovata 21-09-2016
		if lstr_ap[li_i].s_tipo_scad = "A" or lstr_ap[li_i].s_tipo_scad = "F" then
			if lstr_ap[li_i].s_tipo_scad = "A" then
				li_g1 = lstr_ap[li_i].i_giorno_fisso +1
			end if
			if li_g1 > lstr_ap[li_i].i_giorno_fisso then
				li_m1 ++
				if li_m1>12 then
					li_m1 = 1
					li_a1 ++
				end if
			end if
			li_g1 = lstr_ap[li_i].i_giorno_fisso
			ld_vd = date(string(li_g1)+"-"+string(li_m1)+"-"+string(li_a1))
		end if
		ld_datapag[li_kl+li_i1] = ld_vd
		li_i1 ++
		ld_d1 = uf_absolutedate ( ld_d1, lstr_ap[li_i].i_giorni_tra_rate )
	loop while li_i1 <= lstr_ap[li_i].i_num_rate
next

li_size = upperbound(ld_datapag)
for li_i = 1 to li_size
	ld_d1 = ld_datapag[li_i]
	ld_vd = uf_check_data_speciale(ld_d1,lstr_cs)
	ld_datapag[li_i] = ld_vd
next
li_size = upperbound(ld_datapag)
for li_i = 1 to li_size
	astr_scadenze.dc_imp_out[li_i] = ld_imponibile[li_i]
	astr_scadenze.dc_iva_out[li_i] = ld_imposta[li_i]
	astr_scadenze.d_date[li_i] = ld_datapag[li_i]
	astr_scadenze.dc_bollo[li_i] = ldc_bollo[li_i]
	astr_scadenze.l_id_tipo_pagamento[li_i] = ll_id_tipo_pagamento[li_i]
next
astr_scadenze.dc_bollo_tot= ldc_bollo_tot
return true

end function

on uo_esp_pag.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_esp_pag.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

