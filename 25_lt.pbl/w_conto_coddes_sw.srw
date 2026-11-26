forward
global type w_conto_coddes_sw from w_search_main
end type
end forward

global type w_conto_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Conto"
end type
global w_conto_coddes_sw w_conto_coddes_sw

on w_conto_coddes_sw.create
call super::create
end on

on w_conto_coddes_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_conto_coddes_sw
int Y=276
string DataObject="d_anag_sog_conto_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("conto_id_conto")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "conto_codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("conto_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("conto_descrizione")
	CASE "conto_descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("conto_descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("conto_codice")
END CHOOSE

end event

event dw_lista::ue_init;is_resp_window = "w_anag_2_cx"
is_list.s_win_chiave[1] = "id_anagrafica"
end event

event cb_modi::clicked;long ll_RetVal, ll_CurrRow, ll_id_conto, ll_id_sog_commerciale, ll_id_anagrafica, ll_id_anag

ll_CurrRow = dw_lista.GetRow()

IF ll_CurrRow > 0 THEN
	ll_id_anag = dw_lista.GetItemNumber(ll_CurrRow, "id_anagrafica")
			dw_lista.is_resp_window = "w_anag_2_cx"
			dw_lista.is_list.s_win_chiave[1] = "id_anagrafica"

END IF

ll_RetVal = Super::Event Clicked()
RETURN ll_RetVal
end event

