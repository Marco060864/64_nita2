forward
global type w_banca_appoggioa_sw from w_search_main
end type
end forward

global type w_banca_appoggioa_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Banca d'Appoggio"
end type
global w_banca_appoggioa_sw w_banca_appoggioa_sw

type variables
u_sql_scanner	iu_scan
end variables

on w_banca_appoggioa_sw.create
call w_search_main::create
end on

on w_banca_appoggioa_sw.destroy
call w_search_main::destroy
end on

type dw_lista from w_search_main`dw_lista within w_banca_appoggioa_sw
int Width=1166
int Height=581
string DataObject="d_banca_appoggio_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;string	ls_d_abi, ls_d_cab


is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_banca_appoggio")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "den_abi", "den_cab"
		
		ls_d_abi =	THIS.uf_get_colval("den_abi")
		
		if isnull(ls_d_abi) then ls_d_abi=""
	
		ls_d_cab =	THIS.uf_get_colval("den_cab")
		
		if isnull(ls_d_cab) then ls_d_cab=""
		
		is_ricpar.s_main_value =  ls_d_abi+ " - " +ls_d_cab 
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("cod_abi")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("den_abi")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("cod_cab")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("den_cab")
		
	CASE "cod_abi"
		is_ricpar.s_main_value = THIS.uf_get_colval("cod_abi")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("cod_abi")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("den_abi")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("cod_cab")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("den_cab")
		
	CASE "cod_cab"
		is_ricpar.s_main_value = THIS.uf_get_colval("cod_cab")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("cod_abi")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("den_abi")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("cod_cab")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("den_cab")
		
END CHOOSE


end event

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_banca_appoggioa_rpt"
is_list.s_win_chiave[1] = "id_banca_appoggio"
end event

