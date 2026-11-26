forward
global type w_caus_mag_sw from w_search_main
end type
end forward

global type w_caus_mag_sw from w_search_main
boolean TitleBar=true
string Title="Causali di Magazzino"
end type
global w_caus_mag_sw w_caus_mag_sw

on w_caus_mag_sw.create
call super::create
end on

on w_caus_mag_sw.destroy
call super::destroy
end on

event open;call super::open;
Long ll_row
ll_row = dw_lista.GetRow()
ddlb_tiposel.SelectItem(1)
end event

type dw_lista from w_search_main`dw_lista within w_caus_mag_sw
string DataObject="d_caus_magazzino_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_caus_magazzino")
is_ricpar.s_main_value = THIS.uf_get_colval("codice")
is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("descrizione")

end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_caus_mag_sw
long BackColor=1090519039
end type

