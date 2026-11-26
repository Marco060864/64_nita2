forward
global type w_con_lis_art_sw from w_search_main
end type
end forward

global type w_con_lis_art_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Registrazioni"
end type
global w_con_lis_art_sw w_con_lis_art_sw

on w_con_lis_art_sw.create
call super::create
end on

on w_con_lis_art_sw.destroy
call super::destroy
end on

event open;call super::open;
end event

type dw_lista from w_search_main`dw_lista within w_con_lis_art_sw
string DataObject="d_con_lis_artic_gd"
end type

event dw_lista::ue_init;is_list.s_win_chiave[1] = "id_con_lis_articolo"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_con_lis_articolo")

end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_con_lis_art_sw
boolean BringToTop=true
end type

