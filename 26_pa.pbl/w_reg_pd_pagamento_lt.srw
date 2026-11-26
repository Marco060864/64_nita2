forward
global type w_reg_pd_pagamento_lt from w_list_main
end type
end forward

global type w_reg_pd_pagamento_lt from w_list_main
int Width=2798
boolean TitleBar=true
string Title="Riscossioni e Pagamenti Fatture"
end type
global w_reg_pd_pagamento_lt w_reg_pd_pagamento_lt

on w_reg_pd_pagamento_lt.create
call w_list_main::create
end on

on w_reg_pd_pagamento_lt.destroy
call w_list_main::destroy
end on

event open;call super::open;ias_key_name[1] = "id_reg_pd"

end event

type p_crescente from w_list_main`p_crescente within w_reg_pd_pagamento_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_reg_pd_pagamento_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_reg_pd_pagamento_lt
int Width=2675
string DataObject="d_reg_pd_pagamento_lt"
end type

event dw_list::ue_init;call super::ue_init;is_title = "Registrazioni Prima Nota per Ritenute d'Acconto"
is_resp_window = "w_rit_acconto_wz"
end event

event dw_list::doubleclicked;

long ll_CurrRow, ll_IDReg_PD, ll_IDConto, ll_SQLCode, ll_IDPar_Aperta
decimal ldc_importo, ldc_movimenti, ldc_dare, ldc_avere  
string las_array[]

ll_CurrRow = dw_list.GetRow()
ll_IDReg_PD = dw_list.GetItemNumber(ll_CurrRow, "id_reg_pd")
ll_IDConto = dw_list.GetItemNumber(ll_CurrRow, "reg_pd_id_conto")

  SELECT "mov_contabile"."dare",   
         "mov_contabile"."avere",   
			"par_aperta"."id_par_aperta",
         "par_aperta"."importo",   
         sum("mov_partita"."importo") as Movimenti  
    INTO :ldc_dare,   
         :ldc_avere,   
			:ll_IDPar_Aperta,
         :ldc_importo,   
         :ldc_movimenti  
    FROM "mov_contabile",   
         "mov_partita",   
         "par_aperta"  
   WHERE ( "mov_partita"."id_mov_contabile" = "mov_contabile"."id_mov_contabile" ) and  
         ( "par_aperta"."id_reg_pd" = "mov_contabile"."id_reg_pd" ) and  
         ( ( "mov_contabile"."id_reg_pd" = :ll_IDReg_PD ) AND  
         ( "mov_contabile"."numero" = 1 ) )   
GROUP BY	"mov_contabile"."dare",   
         "mov_contabile"."avere",   
			"par_aperta"."id_par_aperta",
         "par_aperta"."importo"	;

ll_SQLCode = SQLCA.SQLCode

las_array[1] = "pag_risc"
las_array[2] = f_info_reg_pd(ll_IDReg_PD)
las_array[3] = f_info_sc(ll_IDConto)
las_array[4] = string(ldc_importo)
las_array[5] = string(ldc_movimenti)
las_array[6] = string(dw_list.GetItemDate(ll_CurrRow, "reg_pd_data_registrazione"), "dd/mm/yyyy")
las_array[7] = string(ll_IDConto)

CHOOSE CASE ll_SQLCode
	CASE 0
		IF IsNull(ldc_dare) THEN
			las_array[8] = "A"
		ELSE 
			las_array[8] = "D"
		END IF
		
		las_array[9] = string(ll_IDPar_Aperta)
		
		u_freddie.sp_push(las_array)
			
		s_list_main lstr_for_win
		lstr_for_win.s_modo = modo_modifica
		
		OpenWithParm(w_pag_riscossioni_wz, lstr_for_win)

END CHOOSE

end event

