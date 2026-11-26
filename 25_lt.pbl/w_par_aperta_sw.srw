forward
global type w_par_aperta_sw from w_search_main
end type
end forward

global type w_par_aperta_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Partite Aperte"
end type
global w_par_aperta_sw w_par_aperta_sw

on w_par_aperta_sw.create
call super::create
end on

on w_par_aperta_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_par_aperta_sw
string DataObject="d_par_aperta_aperte_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;

is_ricpar.s_main_value = THIS.uf_get_colval("num_documento")
								 
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("par_aperta_id_par_aperta")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("registro_numero")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("registro_descrizione")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("registro_tipo_registro")

is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("cnumero")
is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("cdata")
end event

event dw_lista::doubleclicked;

string ls_column

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
			if is_last_dbname='descrizione' then is_last_dbname='conto.descrizione'
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

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_par_aperta_sw
boolean BringToTop=true
end type

