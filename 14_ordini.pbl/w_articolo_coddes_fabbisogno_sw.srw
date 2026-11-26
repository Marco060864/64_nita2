forward
global type w_articolo_coddes_fabbisogno_sw from w_search_main
end type
end forward

global type w_articolo_coddes_fabbisogno_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Articolo"
end type
global w_articolo_coddes_fabbisogno_sw w_articolo_coddes_fabbisogno_sw

on w_articolo_coddes_fabbisogno_sw.create
call super::create
end on

on w_articolo_coddes_fabbisogno_sw.destroy
call super::destroy
end on

type dw_lista from w_search_main`dw_lista within w_articolo_coddes_fabbisogno_sw
int Width=1189
int Height=582
string DataObject="d_articolo_lt"
end type

event dw_lista::ue_init;call super::ue_init;is_resp_window = "w_orafo_articolo_cx"
is_list.s_win_chiave[1] = "id_articolo"
end event

event dw_lista::ue_return_values;call super::ue_return_values;
is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_articolo")

CHOOSE CASE is_ricpar.s_filter_name
	CASE "id_articolo"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_descrizione")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("articolo_stato")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_misura_simbolo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("unita_misura_descrizione")
		
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("unita_misura_b_simbolo")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("unita_misura_b_descrizione")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("conversione_peso_comune")
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("conversione_volume_comune")
		
			
		
		is_ricpar.s_ausil_value[9] = THIS.uf_get_colval("id_titolo")
		is_ricpar.s_ausil_value[10] = THIS.uf_get_colval("lunghezza")
		is_ricpar.s_ausil_value[11] = THIS.uf_get_colval("conv_misura_peso")
		is_ricpar.s_ausil_value[12] = THIS.uf_get_colval("coef_calo")
		
		is_ricpar.s_ausil_value[13] = THIS.uf_get_colval("unita_misura_c_simbolo_um")
		is_ricpar.s_ausil_value[14] = THIS.uf_get_colval("unita_misura_c_tipo_um")
		
	CASE "articolo_codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_descrizione")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("articolo_stato")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_misura_simbolo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("unita_misura_descrizione")
		
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("unita_misura_b_simbolo")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("unita_misura_b_descrizione")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("conversione_peso_comune")
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("conversione_volume_comune")
		
		
		
		is_ricpar.s_ausil_value[9] = THIS.uf_get_colval("id_titolo")
		is_ricpar.s_ausil_value[10] = THIS.uf_get_colval("lunghezza")
		is_ricpar.s_ausil_value[11] = THIS.uf_get_colval("conv_misura_peso")
		is_ricpar.s_ausil_value[12] = THIS.uf_get_colval("coef_calo")
		
		is_ricpar.s_ausil_value[13] = THIS.uf_get_colval("unita_misura_c_simbolo_um")
		is_ricpar.s_ausil_value[14] = THIS.uf_get_colval("unita_misura_c_tipo_um")
		
	CASE "articolo_descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("articolo_descrizione")
		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("articolo_codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("articolo_stato")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_misura_simbolo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("unita_misura_descrizione")
		
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("unita_misura_b_simbolo")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("unita_misura_b_descrizione")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("conversione_peso_comune")
		is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("conversione_volume_comune")
		
		
		

		is_ricpar.s_ausil_value[9] = THIS.uf_get_colval("id_titolo")
		is_ricpar.s_ausil_value[10] = THIS.uf_get_colval("lunghezza")
		is_ricpar.s_ausil_value[11] = THIS.uf_get_colval("conv_misura_peso")
		is_ricpar.s_ausil_value[12] = THIS.uf_get_colval("coef_calo")
		
		is_ricpar.s_ausil_value[13] = THIS.uf_get_colval("unita_misura_c_simbolo_um")
		is_ricpar.s_ausil_value[14] = THIS.uf_get_colval("unita_misura_c_tipo_um")
	
END CHOOSE
is_ricpar.s_id_seg_value[2] = THIS.uf_get_colval("unita_confezione_id_unita_confezione")
is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("unita_confezione_codice")
is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_confezione_descrizione")
end event

