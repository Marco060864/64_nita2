forward
global type w_stp_grafico_cx from w_bilancio_cx
end type
end forward

global type w_stp_grafico_cx from w_bilancio_cx
int Height=801
boolean TitleBar=true
string Title="Gestione Centri di Costo"
end type
global w_stp_grafico_cx w_stp_grafico_cx

on w_stp_grafico_cx.create
call w_bilancio_cx::create
end on

on w_stp_grafico_cx.destroy
call w_bilancio_cx::destroy
end on

event cb_1::clicked;long ll_id_es,ll_id_azienda, ll_id_e
date ld_data
string ls_da,ls_a, ls_codice
long ll_cod_esercizio
string ls_da1, ls_da2

		
		select esercizio.codice
		into :ll_cod_esercizio
		from esercizio
		where esercizio.id_esercizio=:ll_id_e;
		date ld_data_in, ld_data_fin

ll_id_es=dw_1.getitemnumber(1,"id_esercizio")
ls_codice=dw_1.getitemstring(1,"conto_codice")
ll_id_azienda=dw_1.getitemnumber(1,"id_azienda")
ll_id_e=dw_1.getitemnumber(1,"id_esercizio")
ls_codice = dw_1.getitemstring(1,"conto_codice")

ls_da1=dw_1.getitemstring(1,"d_in")
ls_da2=dw_1.getitemstring(1,"d_fin")

ld_data_in=date(string(ls_da1))
ld_data_fin= date(string(ls_da2))



		select esercizio.codice
		into :ll_cod_esercizio
		from esercizio
		where esercizio.id_esercizio=:ll_id_e;
		
		
		
		s_par_grafico ls_parar_graf
		
		ls_parar_graf.id_azienda=ll_id_azienda
		ls_parar_graf.cod_esercizio=ll_cod_esercizio
		ls_parar_graf.data_in=ld_data_in
		ls_parar_graf.data_fin=ld_data_fin
		ls_parar_graf.codice= ls_codice
		
				
		openwithparm(w_grafico_cen_costo,ls_parar_graf)



end event

type dw_1 from w_bilancio_cx`dw_1 within w_stp_grafico_cx
int Height=529
string DataObject="d_prep_stp_grafico_ff"
end type

event dw_1::ue_set_search;call super::ue_set_search;choose case as_nomecol
		case "conto_codice"
		Is_search_window="w_pdc1cenr_sw"
     	is_ricpar.s_filter_value= as_valcol
		is_ricpar.s_filter_name= "conto_codice"
	
end choose

end event

event dw_1::ue_use_search;call super::ue_use_search;choose case as_nomecol
	case "conto_codice"
		uf_set_colval(as_nomecol, is_ricpar.s_main_value)
		uf_set_colval("id_conto", is_ricpar.s_id_seg_value[1])
   	
		
	
end choose



end event

