forward
global type w_locazione_gd from w_np_single_data
end type
end forward

global type w_locazione_gd from w_np_single_data
int Width=2835
boolean TitleBar=true
string Title="Locazioni"
end type
global w_locazione_gd w_locazione_gd

on w_locazione_gd.create
call w_np_single_data::create
end on

on w_locazione_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_locazione_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_locazione_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_locazione_gd
int Width=2698
string DataObject="d_locazione_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Locazioni"
end event

event dw_single::ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_area_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_area_gd"
		is_ricpar.s_titolo_finestra = "Aree Magazzino"
		is_ricpar.s_ausil_value[1] = "id_area_des"
	CASE "id_area_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_area_gd"
		is_ricpar.s_titolo_finestra = "Aree Magazzino"
		is_ricpar.s_ausil_value[1] = "id_area_cod"

END CHOOSE
end event

