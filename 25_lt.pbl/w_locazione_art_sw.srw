forward
global type w_locazione_art_sw from w_search_main
end type
end forward

global type w_locazione_art_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Locazione"
end type
global w_locazione_art_sw w_locazione_art_sw

on w_locazione_art_sw.create
call w_search_main::create
end on

on w_locazione_art_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_locazione_art_sw
string DataObject="d_locazione_mag_art_lt"
end type

event dw_lista::ue_init;call super::ue_init;
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_main_value = THIS.uf_get_colval("cc_locazione_mag")
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("locazione_id_locazione")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("locazione_id_magazzino")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("area_descrizione")

end event

event dw_lista::ue_retrieve;


string	ls_sql, ls_where_cond, ls_sql_cond 
pointer	lp_oldp
long		ll_retval


ll_retval = 0
lp_oldp = setpointer(Hourglass!)

if ib_havetoscan then
	
	
		
		
		ls_sql_cond = ""
		if is_last_dbname<>"" then
			ll_retval = uf_get_where_cond(is_last_dbname,is_val_sel,ii_tipo_sel,ls_sql_cond)
		end if
		if is_ricpar.s_sql_cond <> "" then
			ls_sql_cond = "( "+ ls_sql_cond + " ) AND ( " + is_ricpar.s_sql_cond + " )"
		end if
		if ls_sql_cond > "" then
			ius_scanner.f_reset_cur_as_ini()
			ius_scanner.f_add_where_condition(ls_sql_cond)
			ls_sql = ius_scanner.f_getcurrent()
			this.object.datawindow.table.select = ls_sql
			ib_havetoscan = false
		end if
	
end if

long ll_art
ll_art=long(istr_ric.s_main_value)
retrieve(ll_art)
is_last_column="loc_pred"
if rowcount() > 0 then
	this.SetSort(is_last_column + " D")
	is_last_sort = "D"
	this.sort()
	this.ScrollToRow(0)
	il_last_row = getrow()
	this.SelectRow(0, false)
	this.SelectRow(il_last_row, true)
end if
lp_oldp = setpointer(lp_oldp)
return(ll_retval)

end event

