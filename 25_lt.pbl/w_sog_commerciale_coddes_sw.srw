forward
global type w_sog_commerciale_coddes_sw from w_search_main
end type
end forward

global type w_sog_commerciale_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Soggetto Commerciale"
end type
global w_sog_commerciale_coddes_sw w_sog_commerciale_coddes_sw

on w_sog_commerciale_coddes_sw.create
call super::create
end on

on w_sog_commerciale_coddes_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_sog_commerciale_coddes_sw
string DataObject="d_sog_commerciale_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_sog_commerciale_cx"
is_list.s_win_chiave[1] = "id_sog_commerciale"
end event

event dw_lista::ue_return_values;call super::ue_return_values;
CHOOSE CASE is_ricpar.s_filter_name

	CASE "sog_commerciale_codice"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")
		is_ricpar.s_main_value = THIS.uf_get_colval("sog_commerciale_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("anagrafica_rag_soc_1")

	CASE "anagrafica_rag_soc_1"
		is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_sog_commerciale")
		is_ricpar.s_main_value = THIS.uf_get_colval("anagrafica_rag_soc_1")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("sog_commerciale_codice")

END CHOOSE

is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("anagrafica_rag_soc_2")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("sog_commerciale_tipo")
end event

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_sog_commerciale_coddes_sw
long BackColor=1090519039
FontCharSet FontCharSet=Ansi!
string Item[]={"Contiene",&
"Inizia per",&
"Termina per"}
end type

