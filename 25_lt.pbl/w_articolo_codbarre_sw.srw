forward
global type w_articolo_codbarre_sw from w_search_main
end type
end forward

global type w_articolo_codbarre_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Articolo"
end type
global w_articolo_codbarre_sw w_articolo_codbarre_sw

on w_articolo_codbarre_sw.create
call super::create
end on

on w_articolo_codbarre_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_articolo_codbarre_sw
int Width=1189
int Height=580
string DataObject="d_articolo_codbarre_lt"
end type

event dw_lista::ue_init;if pos(upper(u_freddie.istr_database.name), 'ORAFO')>0 then
	is_resp_window = "w_orafo_articolo_cx"
else
	is_resp_window = "w_articolo_cx"
end if
is_list.s_win_chiave[1] = "id_articolo"
end event

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_articolo")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "id_articolo"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_descrizione")
	CASE "articolo_codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_descrizione")
	CASE "articolo_descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_codice")
END CHOOSE
is_ricpar.s_id_seg_value[2] = THIS.uf_get_colval("unita_confezione_id_unita_confezione")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("unita_confezione_codice")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_confezione_descrizione")
end event

event dw_lista::doubleclicked;string ls_column

if row = 0 then 
	if not (dwo.Name = "datawindow") then
		
	 	ls_column = Mid( dwo.name, 1, Len(string(dwo.name)) - 2)
		if ls_column = is_last_column then 
			if is_last_sort = "D" then
				this.SetSort(ls_column + " A")
				is_last_sort = "A"
			else
				this.SetSort(ls_column + " D")
				is_last_sort = "D"
			end if
		else 
			this.SetSort(ls_column + " A")
			is_last_column = ls_column
			is_last_sort = "A"
			is_last_dbname = string(Describe(ls_column+".dbName"))
			is_last_coltype = string(Describe(ls_column+".coltype"))
			is_last_coldesc = dwo.text
			trigger event ue_change_col (true)
		end if
		this.Sort()
	end if
else
	
	
	triggerevent("ue_return_values")
	CloseWithReturn (parent,is_ricpar)	
end if 


end event

event dw_lista::ue_change_col;

string		ls_temp, ls_car
integer		li_i

if ib_reset then sle_filtro.text = ""

sle_ricerca.setfocus()
ls_temp = ""
for li_i = 1 to len(dw_lista.is_last_coldesc)
	ls_car = mid(dw_lista.is_last_coldesc,li_i,1)
	if asc(ls_car) < 32 then
		ls_temp = ls_temp+" "
	else
		ls_temp = ls_temp+ls_car
	end if
next

sle_showsort.text = ls_temp+ " "+ ddlb_tiposel.text+" "+sle_filtro.text

end event

event dw_lista::ue_retrieve;


string	ls_sql, ls_where_cond, ls_sql_cond 
pointer	lp_oldp
long		ll_retval, a


ll_retval = 0
lp_oldp = setpointer(Hourglass!)

if ib_havetoscan then
	
	this.object.datawindow.table.select = ius_scanner.f_getinitial()
	
	
		
		
		ls_sql_cond = ""
		
		
		if is_last_dbname<>"" and is_val_sel>'' then
		
			ll_retval = uf_get_where_cond(is_last_dbname,is_val_sel,ii_tipo_sel,ls_sql_cond)
			if upper(left(ls_sql_cond, 6))="CODICE" or upper(left(ls_sql_cond, 11))="DESCRIZIONE" or upper(left(ls_sql_cond, 11))="ID_ARTICOLO" then 
				if is_last_column="des_articolo_codice" then
					ls_sql_cond="des_articolo."+ls_sql_cond
				else
					ls_sql_cond="articolo."+ls_sql_cond
				end if
			else
				
				
			end if
		end if
		if is_ricpar.s_sql_cond <> "" then
			ls_sql_cond = "( "+ ls_sql_cond + " ) AND ( " + is_ricpar.s_sql_cond + " )"
		end if
		
		a=pos(ls_sql_cond, 'NULL')
		if ls_sql_cond > "" and  a=0 then
		
			ius_scanner.f_reset_cur_as_ini()
			ius_scanner.f_add_where_condition(ls_sql_cond)
			ls_sql = ius_scanner.f_getcurrent()
			this.object.datawindow.table.select = ls_sql
			ib_havetoscan = false
		end if
	
end if

ls_sql=this.object.datawindow.table.select



retrieve()
if rowcount() > 0 then
	this.SetSort(is_last_column + " A")
	is_last_sort = "A"
	this.sort()
	this.ScrollToRow(0)
	il_last_row = getrow()
	this.SelectRow(0, false)
	this.SelectRow(il_last_row, true)
end if
lp_oldp = setpointer(lp_oldp)
return(ll_retval)

end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_articolo_codbarre_sw
boolean BringToTop=true
end type

