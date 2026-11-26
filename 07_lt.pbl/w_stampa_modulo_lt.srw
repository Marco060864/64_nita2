forward
global type w_stampa_modulo_lt from w_list_main
end type
end forward

global type w_stampa_modulo_lt from w_list_main
int Width=2657
int Height=1041
end type
global w_stampa_modulo_lt w_stampa_modulo_lt

type variables

end variables

event open;call super::open;ias_key_name[1] = "id_distinta"
end event

on w_stampa_modulo_lt.create
call w_list_main::create
end on

on w_stampa_modulo_lt.destroy
call w_list_main::destroy
end on

event ue_modify;
end event

type p_crescente from w_list_main`p_crescente within w_stampa_modulo_lt
boolean BringToTop=true
end type

type p_decrescente from w_list_main`p_decrescente within w_stampa_modulo_lt
boolean BringToTop=true
end type

type dw_list from w_list_main`dw_list within w_stampa_modulo_lt
int Y=21
int Width=2529
string DataObject="d_stampa_modulo_specifica_prodotto"
end type

event dw_list::ue_init;call super::ue_init;long ll_riga
is_resp_window = "w_stampa_modulo_cx"

end event

event dw_list::rowfocuschanged;call super::rowfocuschanged;
end event

event dw_list::ue_modify;long			ll_row, ll_nr
integer		li_size, li_counter
string		ls_filter, ls_colname, ls_colval
s_rit_wp		lstr_rit



is_resp_window="W_STAMPA_MODULO_CX"
LL_ROW=GETROW()
is_list.l_identifica[1] =getitemnumber(ll_row, "id_distinta")
is_list.s_modo = modo_modifica
uf_get_key_col_values()
OpenWithParm(iw_support, is_list.l_identifica[1] , is_resp_window)

if UpperBound(is_list.l_identifica) > 0 then
	is_list.l_identifica[1] = 0
end if


	
	Retrieve()
	ll_nr = rowcount()
	
	if ll_nr>0 then
		selectrow(1,true)
	end if
	ll_row = Find( ls_filter, 1, RowCount( ))
	if ll_row >1 then
		ScrollToRow(ll_row)
	end if
this.post SetFocus()

end event

