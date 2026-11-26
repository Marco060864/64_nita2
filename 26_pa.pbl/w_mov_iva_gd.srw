forward
global type w_mov_iva_gd from w_np_single_data
end type
end forward

global type w_mov_iva_gd from w_np_single_data
int Width=2757
boolean TitleBar=true
string Title="Movimenti IVA"
end type
global w_mov_iva_gd w_mov_iva_gd

on w_mov_iva_gd.create
call w_np_single_data::create
end on

on w_mov_iva_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_mov_iva_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_mov_iva_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_mov_iva_gd
int Width=2606
string DataObject="d_mov_iva_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Movimenti IVA"
end event

event dw_single::ue_set_search;call super::ue_set_search;CHOOSE CASE as_nomecol
		
	CASE "id_tab_iva_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tab_iva_gd"
		is_ricpar.s_titolo_finestra = "Tabella IVA"
		is_ricpar.s_ausil_value[1] = "id_tab_iva_des"
	CASE "id_tab_iva_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_tab_iva_gd"
		is_ricpar.s_titolo_finestra = "Tabella IVA"
		is_ricpar.s_ausil_value[1] = "id_tab_iva_cod"
		
END CHOOSE


end event

