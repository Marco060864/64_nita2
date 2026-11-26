forward
global type w_lotto_cod_sw from w_search_main
end type
end forward

global type w_lotto_cod_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Articolo"
end type
global w_lotto_cod_sw w_lotto_cod_sw

on w_lotto_cod_sw.create
call super::create
end on

on w_lotto_cod_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_lotto_cod_sw
int Width=1189
int Height=580
string DataObject="d_lotto_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_movartlotto_cx"
is_list.s_win_chiave[1] = "id_lotto"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_lotto")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "id_lotto"
		is_ricpar.s_main_value = THIS.uf_get_colval("cod_esterno")
	CASE "cod_esterno"
		is_ricpar.s_main_value = THIS.uf_get_colval("cod_esterno")
END CHOOSE
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

