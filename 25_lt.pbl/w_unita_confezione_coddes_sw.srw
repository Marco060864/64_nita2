forward
global type w_unita_confezione_coddes_sw from w_search_main
end type
end forward

global type w_unita_confezione_coddes_sw from w_search_main
boolean TitleBar=true
string Title="Ricerca Unità Confezione"
end type
global w_unita_confezione_coddes_sw w_unita_confezione_coddes_sw

on w_unita_confezione_coddes_sw.create
call w_search_main::create
end on

on w_unita_confezione_coddes_sw.destroy
call w_search_main::destroy
end on

event cb_cerca::clicked;long		ll_retval, ll_pos   
string	ls_value, ls_nome_tabella_db

ll_retval = 0
dw_lista.ib_havetoscan = true

ls_value	= sle_filtro.text

sle_showsort.text = dw_lista.is_last_coldesc+ " "+ ddlb_tiposel.text+" "+ls_value

dw_lista.is_val_sel = ls_value
	if mid(sle_showsort.text,2,1)="U" or isnull(sle_showsort.text)or sle_showsort.text="" then
		ls_nome_tabella_db="unita_confezione."
	else
		ls_nome_tabella_db="articolo."
	end if
	dw_lista.is_last_dbname=ls_nome_tabella_db+dw_lista.is_last_dbname
ll_retval = dw_lista.event ue_retrieve()
if ll_retval < 0 then
	sle_filtro.text = ""
	sle_showsort.text = ""
end if
sle_ricerca.text = ""
sle_ricerca.setfocus()

end event

type dw_lista from w_search_main`dw_lista within w_unita_confezione_coddes_sw
string DataObject="d_unita_confezione_siart_lt"
end type

event dw_lista::ue_return_values;call super::ue_return_values;is_ricpar.s_id_seg_value[1] = THIS.uf_get_colval("id_unita_confezione")


CHOOSE CASE is_ricpar.s_filter_name
	CASE "unita_confezione_codice"
		is_ricpar.s_main_value = THIS.uf_get_colval("unita_confezione_codice")

		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("unita_confezione_descrizione")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("unita_confezione_peso_netto")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_confezione_peso_lordo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("unita_misura_B_simbolo")
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("unita_misura_B_descrizione")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("unita_misura_C_simbolo")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("unita_misura_C_descrizione")
	CASE "unita_confezione_descrizione"
		is_ricpar.s_main_value = THIS.uf_get_colval("unita_confezione_descrizione")

		is_ricpar.s_ausil_value[1] = THIS.uf_get_colval("unita_confezione_codice")
		is_ricpar.s_ausil_value[2] = THIS.uf_get_colval("unita_confezione_peso_netto")
		is_ricpar.s_ausil_value[3] = THIS.uf_get_colval("unita_confezione_peso_lordo")
		is_ricpar.s_ausil_value[4] = THIS.uf_get_colval("unita_misura_B_simbolo")
		is_ricpar.s_ausil_value[5] = THIS.uf_get_colval("unita_misura_B_descrizione")
		is_ricpar.s_ausil_value[6] = THIS.uf_get_colval("unita_misura_C_simbolo")
		is_ricpar.s_ausil_value[7] = THIS.uf_get_colval("unita_misura_C_descrizione")
END CHOOSE

is_ricpar.s_ausil_value[8] = THIS.uf_get_colval("unita_confezione_num_colli")
end event

