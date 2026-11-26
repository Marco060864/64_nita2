forward
global type w_des_articolo_coddes_sw from w_search_main
end type
end forward

global type w_des_articolo_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Descrizione Articolo"
end type
global w_des_articolo_coddes_sw w_des_articolo_coddes_sw

on w_des_articolo_coddes_sw.create
call w_search_main::create
end on

on w_des_articolo_coddes_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_des_articolo_coddes_sw
string DataObject="d_des_articolo_noart_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_des_articolo")


CHOOSE CASE is_ricpar.s_filter_name
	CASE "codice"
		
		
		is_ricpar.s_main_value = THIS.uf_get_colval("codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")
	CASE "descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("codice")
END CHOOSE

end event

event dw_lista::constructor;call super::constructor;string ls_where

ls_where = ius_scanner.f_get_token_value("WHERE",0,0)
ls_where = ""
ius_scanner.f_set_token("WHERE",ls_where)
this.object.datawindow.table.select =  ius_scanner.f_getcurrent()
end event

