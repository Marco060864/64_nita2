forward
global type w_listino_gd from w_np_single_data
end type
end forward

global type w_listino_gd from w_np_single_data
int Width=2922
boolean TitleBar=true
string Title="Listini"
end type
global w_listino_gd w_listino_gd

on w_listino_gd.create
call w_np_single_data::create
end on

on w_listino_gd.destroy
call w_np_single_data::destroy
end on

type p_crescente from w_np_single_data`p_crescente within w_listino_gd
boolean BringToTop=true
end type

type p_decrescente from w_np_single_data`p_decrescente within w_listino_gd
boolean BringToTop=true
end type

type dw_single from w_np_single_data`dw_single within w_listino_gd
int Width=2812
string DataObject="d_listino_gd"
end type

event dw_single::ue_init;call super::ue_init;is_title = "Listini"
end event

event dw_single::ue_set_search;call super::ue_set_search;
CHOOSE CASE as_nomecol
		
	CASE "id_valuta_cod"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_des"
	CASE "id_valuta_des"
		is_search_window = "w_mod_cometa_gd"
		is_ricpar.s_datawindow = "d_valuta_gd"
		is_ricpar.s_titolo_finestra = "Valute"
		is_ricpar.s_ausil_value[1] = "id_valuta_cod"

END CHOOSE


end event

