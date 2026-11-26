forward
global type w_conti_pdc_new_sw from w_search_main
end type
end forward

global type w_conti_pdc_new_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Conto"
end type
global w_conti_pdc_new_sw w_conti_pdc_new_sw

on w_conti_pdc_new_sw.create
call super::create
end on

on w_conti_pdc_new_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_conti_pdc_new_sw
int Y=276
string DataObject="d_conto_azienda_new_lt"
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

event dw_lista::ue_insert;

long				ll_row
integer			li_size, li_counter
s_list_main		lstr_for_win
string			ls_filter, ls_colname, ls_colval
window			lw_support
s_rit_wp			lstr_rit

ll_row = GetRow()
if is_resp_window>"" then
	
	li_size = upperbound(is_list.s_win_chiave)
	for li_counter = 1 to li_size
		if ll_row>0 then
			is_list.l_win_chiave[li_counter] = GetItemNumber(ll_row, is_list.s_win_chiave[li_counter])
		else
			is_list.l_win_chiave[li_counter] = 0
		end if
	next
	lstr_for_win.s_identifica = is_list.s_win_chiave
	lstr_for_win.l_identifica = is_list.l_win_chiave
	
	lstr_for_win.s_par_name = is_list.s_par_name
	lstr_for_win.s_par_value = is_list.s_par_value
	lstr_for_win.s_modo = modo_inserisci
	lstr_for_win.s_win_parametri = is_list.s_win_parametri
	
	OpenWithParm(lw_support, lstr_for_win, is_resp_window)

	
	ls_filter = ""
	lstr_rit = Message.PowerObjectParm
	li_size = UpperBound(lstr_rit.s_identifica)
	if li_size>0 then
		ls_colname = lstr_rit.s_identifica[1]
		ls_colval = string(lstr_rit.l_identifica[1])
		is_last_dbname = string(Describe(ls_colname+".dbName"))
		is_val_sel = ls_colval
		ii_tipo_sel = 1
	end if
	for  li_counter = 1 to li_size
		ls_colname = lstr_rit.s_identifica[li_counter]
		ls_colval = string(lstr_rit.l_identifica[li_counter])
		ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
	next
	ls_filter = Mid(ls_filter,5)
	
	
	if ls_filter <> "" then
		ib_havetoscan = true
		TriggerEvent("ue_retrieve")
		ll_row = Find( ls_filter, 1, RowCount( ))
		ScrollToRow(ll_row)
	end if
	
	
end if

return 0

end event

event cb_modi::clicked;long ll_RetVal, ll_CurrRow, ll_id_conto, ll_anagrafica
ll_CurrRow = dw_lista.GetRow()

IF ll_CurrRow > 0 THEN
	ll_id_conto = dw_lista.GetItemNumber(ll_CurrRow, "id_sog_commerciale")
		
	select id_anagrafica
	into :ll_anagrafica
	from sog_commerciale
	where id_sog_commerciale=:ll_id_conto;
	
	dw_lista.setItem(ll_CurrRow, "id_anagrafica",ll_anagrafica)
	
		
		
		
	CHOOSE CASE SQLCA.SQLCode
		CASE 0
			dw_lista.is_resp_window = "w_anag_2_cx"
			dw_lista.is_list.s_win_chiave[1] = "id_anagrafica"
		CASE -1
			MessageBox("Errore sul DataBase", "w_conto_sw::cb_modi / clicked / 1")
	END CHOOSE


END IF

ll_RetVal = Super::Event Clicked()
RETURN ll_RetVal
end event

