forward
global type w_reg_pd_sw from w_search_main
end type
end forward

global type w_reg_pd_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Registrazioni"
end type
global w_reg_pd_sw w_reg_pd_sw

on w_reg_pd_sw.create
call super::create
end on

on w_reg_pd_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_reg_pd_sw
string DataObject="d_reg_pd_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_list.s_win_chiave[1] = "id_reg_pd"
end event

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_reg_pd")

is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("reg_pd_st_stampa_bollato")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("reg_pd_st_liquidazione")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("reg_pd_st_reg_iva")

is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("reg_pd_st_data_bollato")
is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("reg_pd_st_data_liquidazione")
is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("reg_pd_st_data_reg_iva")

end event

event dw_lista::ue_retrieve;call super::ue_retrieve;

string ls_sort

ls_sort = "esercizio_codice A, registro_tipo_registro A, registro_numero A, reg_pd_num_progressivo D"
dw_lista.SetSort(ls_sort)
dw_lista.Sort()
this.ScrollToRow(0)
this.SelectRow(0, false)
this.SelectRow(il_last_row, true)
RETURN 0
end event

