forward
global type w_orafo_listino_cx from w_listino_cx
end type
end forward

global type w_orafo_listino_cx from w_listino_cx
end type
global w_orafo_listino_cx w_orafo_listino_cx

on w_orafo_listino_cx.create
call super::create
end on

on w_orafo_listino_cx.destroy
call super::destroy
end on

event open;call super::open;il_HelpTopic = 43

idw_master = dw_listino_ff
idw_master.is_list = Message.PowerObjectParm
if Upperbound(idw_master.is_list.s_identifica)=0 then  
	idw_master.ias_key_name[1] = "id_listino"
	idw_master.is_list.s_modo=modo_inserisci
end if
idw_master.ib_use_scanner = TRUE
idw_master.is_list.s_sql_ident[1] = "listino.id_listino"


end event

type p_msg_log from w_listino_cx`p_msg_log within w_orafo_listino_cx
end type

type p_crescente from w_listino_cx`p_crescente within w_orafo_listino_cx
end type

type p_decrescente from w_listino_cx`p_decrescente within w_orafo_listino_cx
end type

type cb_ok from w_listino_cx`cb_ok within w_orafo_listino_cx
end type

type cb_annulla from w_listino_cx`cb_annulla within w_orafo_listino_cx
end type

type cb_nuovo from w_listino_cx`cb_nuovo within w_orafo_listino_cx
end type

type cb_inserisci from w_listino_cx`cb_inserisci within w_orafo_listino_cx
end type

type cb_cancella from w_listino_cx`cb_cancella within w_orafo_listino_cx
end type

type cb_salva from w_listino_cx`cb_salva within w_orafo_listino_cx
end type

type tab_1 from w_listino_cx`tab_1 within w_orafo_listino_cx
end type

type tabpage_1 from w_listino_cx`tabpage_1 within tab_1
end type

type cb_ricerca from w_listino_cx`cb_ricerca within w_orafo_listino_cx
end type

type dw_listino_ff from w_listino_cx`dw_listino_ff within w_orafo_listino_cx
end type

type dw_variazione_gd from w_listino_cx`dw_variazione_gd within w_orafo_listino_cx
end type

event dw_variazione_gd::ue_init;call super::ue_init;is_resp_window = ""
is_list.s_win_zoom = "w_orafo_variazione_ff"

end event

event dw_variazione_gd::ue_modify;long 				ll_row
integer 			li_size, li_counter
string 			ls_filter, ls_colname, ls_colval
s_list_main 	lstr_for_win
s_rit_wp			lstr_rit

ll_row = GetRow()
if ll_row>0 then
	if not(is_resp_window = "") OR not(is_list.s_win_zoom = "") then
	
		is_list.s_modo 					= modo_modifica
		lstr_for_win.s_modo 				= is_list.s_modo
		lstr_for_win.s_identifica 		= is_list.s_win_chiave
		lstr_for_win.l_identifica 		= is_list.l_win_chiave
		lstr_for_win.s_par_name 		= is_list.s_par_name
		lstr_for_win.s_par_value 		= is_list.s_par_value
		lstr_for_win.s_win_parametri 	= is_list.s_win_parametri
		
		li_size = UpperBound(lstr_for_win.s_identifica)		
		for li_counter = 1 to li_size
			lstr_for_win.l_identifica[li_counter] = GetItemNumber( ll_row, lstr_for_win.s_identifica[li_counter])
		next
		
		li_size = UpperBound(lstr_for_win.s_par_name)
		for li_counter = 1 to li_size
			lstr_for_win.s_par_value[li_counter] = string(GetItemNumber(GetRow(), lstr_for_win.s_par_name[li_counter]))
		next

		
		long ll_id_valuta
		ll_id_valuta = dw_listino_ff.getitemnumber(1, "id_valuta")

		lstr_for_win.s_par_name[1] = "id_valuta"
		lstr_for_win.s_par_value[1] = string(ll_id_valuta)
		

		if is_list.s_win_zoom = "" then
			OpenWithParm(iw_support, lstr_for_win, is_resp_window)
		else
			if not ((GetItemStatus(ll_row, 0, Primary!) = New!) OR (GetItemStatus(ll_row, 0, Primary!) = NewModified!)) then
				this.update()
				OpenWithParm(iw_support, lstr_for_win,is_list.s_win_zoom)
			end if
		end if
	
		
		ls_filter = ""
//		lstr_rit = Message.PowerObjectParm
//		li_size = UpperBound(lstr_rit.s_identifica)
//		for  li_counter = 1 to li_size
//			ls_colname = lstr_rit.s_identifica[li_counter]
//			ls_colval = string(lstr_rit.l_identifica[li_counter])
//			ls_filter = ls_filter + " AND " + ls_colname + " = " + ls_colval
//		next
//		ls_filter = Mid(ls_filter,5)
//		
		
		
		
			TriggerEvent("ue_retrieve")
			if (RowCount()>0) and (is_resp_window <> "") then
				selectrow(1,true)
			end if
			ll_row = Find( ls_filter, 1, RowCount( ))
			ScrollToRow(ll_row)
		
		
	else
		
	end if
end if

//
end event

type dw_variazione_gd_t from w_listino_cx`dw_variazione_gd_t within w_orafo_listino_cx
end type

type dw_listino_ff_t from w_listino_cx`dw_listino_ff_t within w_orafo_listino_cx
string text = " Listino Orafo"
end type

