forward
global type w_listino_coddes_sw from w_search_main
end type
end forward

global type w_listino_coddes_sw from w_search_main
int X=46
int Y=73
int Width=2798
end type
global w_listino_coddes_sw w_listino_coddes_sw

on w_listino_coddes_sw.create
call w_search_main::create
end on

on w_listino_coddes_sw.destroy
call w_search_main::destroy
end on

event open;call super::open;

This.width = 3100

ddlb_tiposel.SelectItem(1)

end event

event cb_cerca::clicked;call super::clicked;
dw_lista.SetSort("tipo A , codice A")
dw_lista.Sort()
end event

type dw_lista from w_search_main`dw_lista within w_listino_coddes_sw
string DataObject="d_listino_gd"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = this.uf_get_colval("id_listino")

end event

