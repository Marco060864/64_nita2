forward
global type w_conto_pdc_sw from w_search_main
end type
end forward

global type w_conto_pdc_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca conto"
end type
global w_conto_pdc_sw w_conto_pdc_sw

on w_conto_pdc_sw.create
call super::create
end on

on w_conto_pdc_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_conto_pdc_sw
string DataObject="d_conto_pdc_lt"
end type

event dw_lista::ue_init;is_resp_window = "w_conto_ff"
is_list.s_win_chiave[1] = "conto_id_conto"
end event

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_conto")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")
	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
END CHOOSE

end event

event cb_modi::clicked;long ll_RetVal, ll_CurrRow, ll_id_conto, ll_id_sog_commerciale

ll_CurrRow = dw_lista.GetRow()

IF ll_CurrRow > 0 THEN
	ll_id_conto = dw_lista.GetItemNumber(ll_CurrRow, "id_conto")
	SELECT "dba"."sog_commerciale"."id_sog_commerciale"  
		INTO :ll_id_sog_commerciale  
		FROM "dba"."sog_commerciale"  
		WHERE "dba"."sog_commerciale"."id_conto" = :ll_id_conto   ;
		
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			dw_lista.is_resp_window = "w_sog_commerciale_cx"
			dw_lista.is_list.s_win_chiave[1] = "id_sog_commerciale"
		CASE -1
			MessageBox("Errore sul DataBase", "w_conto_sw::cb_modi / clicked / 1")
	END CHOOSE

END IF

ll_RetVal = Super::Event Clicked()
RETURN ll_RetVal

end event

