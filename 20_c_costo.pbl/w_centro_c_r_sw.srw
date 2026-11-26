forward
global type w_centro_c_r_sw from w_search_main
end type
end forward

global type w_centro_c_r_sw from w_search_main
int Width=2195
int Height=1433
boolean TitleBar=true
string Title="Ricerca"
boolean ControlMenu=true
end type
global w_centro_c_r_sw w_centro_c_r_sw

on w_centro_c_r_sw.create
call w_search_main::create
end on

on w_centro_c_r_sw.destroy
call w_search_main::destroy
end on

type cb_cerca from w_search_main`cb_cerca within w_centro_c_r_sw
int X=1052
end type

type dw_lista from w_search_main`dw_lista within w_centro_c_r_sw
int X=302
int Y=321
int Width=1308
int Height=581
string DataObject="d_cen_testa1"
end type

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1]=this.uf_get_colval("id_cen_cos_t")

choose case is_ricpar.s_filter_name
	case "conto_codice"
		is_ricpar.s_main_value= this.uf_get_colval("conto_codice")
		is_ricpar.s_ausil_value[1]= this.uf_get_colval("conto_descrizione")
	case "conto_descrizione"
		is_ricpar.s_main_value= this.uf_get_colval("conto_descrizione")
		is_ricpar.s_ausil_value[1]= this.uf_get_colval("conto_codice")
end choose


end event

type sle_showsort from w_search_main`sle_showsort within w_centro_c_r_sw
int X=298
int Y=925
int Width=1317
int Height=81
end type

type cb_modi from w_search_main`cb_modi within w_centro_c_r_sw
int X=622
end type

type cb_nuovo from w_search_main`cb_nuovo within w_centro_c_r_sw
int X=293
int Width=275
int Height=81
end type

type cb_annulla from w_search_main`cb_annulla within w_centro_c_r_sw
int X=1335
int Y=1037
int Width=229
end type

type cb_ok from w_search_main`cb_ok within w_centro_c_r_sw
int X=1002
int Width=229
end type

type sle_ricerca from w_search_main`sle_ricerca within w_centro_c_r_sw
int X=298
int Width=526
int Height=81
end type

type sle_filtro from w_search_main`sle_filtro within w_centro_c_r_sw
int X=755
int Width=503
int Height=81
end type

type ddlb_tiposel from w_search_main`ddlb_tiposel within w_centro_c_r_sw
int X=298
int Width=407
end type

